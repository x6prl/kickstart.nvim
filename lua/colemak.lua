local colemak = {}

local mappings = {
	-- Up/down/left/right
	{ modes = { "n", "o", "x" }, lhs = "n", rhs = "h", desc = "Left (h)" },
	{ modes = { "n", "o", "x" }, lhs = "u", rhs = "k", desc = "Up (k)" },
	{ modes = { "n", "o", "x" }, lhs = "e", rhs = "j", desc = "Down (j)" },
	{ modes = { "n", "o", "x" }, lhs = "i", rhs = "l", desc = "Right (l)" },
	{ modes = { "n", "o", "x" }, lhs = "h", rhs = "<Nop>", desc = "Disable Left op" },

	-- Beginning/end of line
	{ modes = { "n", "o", "x" }, lhs = "L", rhs = "^", desc = "First non-blank character on line" },
	{ modes = { "n", "o", "x" }, lhs = "Y", rhs = "$", desc = "End of line" },

	-- PageUp/PageDown
	{ modes = { "n", "x" }, lhs = "j", rhs = "<PageUp>", desc = "Scroll buffer UP" },
	{ modes = { "n", "x" }, lhs = "m", rhs = "<PageDown>", desc = "Scroll buffer DOWN" },

	-- Jumplist navigation
	{ modes = { "n" }, lhs = "<C-u>", rhs = "<C-i>", desc = "Jumplist forward" },
	{ modes = { "n" }, lhs = "<C-e>", rhs = "<C-o>", desc = "Jumplist backward" },

	-- Word left/right
	{ modes = { "n", "o", "x" }, lhs = "l", rhs = "b", desc = "Word back" },
	{ modes = { "n", "o", "x" }, lhs = "y", rhs = "w", desc = "Word forward" },
	{ modes = { "n", "o", "v" }, lhs = "<C-l>", rhs = "B", desc = "WORD back" },
	{ modes = { "n", "o", "v" }, lhs = "<C-y>", rhs = "W", desc = "WORD forward" },

	-- End of word left/right
	{ modes = { "n", "o", "x" }, lhs = "N", rhs = "ge", desc = "End of word back" },
	{ modes = { "n", "o", "x" }, lhs = "<M-n>", rhs = "gE", desc = "End of WORD back" },
	{ modes = { "n", "o", "x" }, lhs = "I", rhs = "e", desc = "End of word forward" },
	{ modes = { "n", "o", "x" }, lhs = "<M-i>", rhs = "E", desc = "End of WORD forward" },

	-- Text objects
	-- diw is drw. daw is now dtw.
	{ modes = { "o", "v" }, lhs = "r", rhs = "i", desc = "O/V mode: text object inner (i)" },
	{ modes = { "o", "v" }, lhs = "t", rhs = "a", desc = "O/V mode: text object around (a)" },
	-- Move visual replace from 'r' to 'R'
	{ modes = { "o", "v" }, lhs = "R", rhs = "r", desc = "Replace char" },

	-- Folds
	{ modes = { "n", "x" }, lhs = "b", rhs = "z", desc = "Fold command prefix" },
	{ modes = { "n", "x" }, lhs = "bb", rhs = "zb", desc = "Scroll line and cursor to bottom" },
	{ modes = { "n", "x" }, lhs = "bu", rhs = "zk", desc = "Move up to previous fold" },
	{ modes = { "n", "x" }, lhs = "be", rhs = "zj", desc = "Move down to next fold" },

	-- Copy/paste
	{ modes = { "n", "o", "x" }, lhs = "c", rhs = "y", desc = "Yank" },
	{ modes = { "n", "x" }, lhs = "v", rhs = "p", desc = "Paste after" },
	{ modes = { "n" }, lhs = "C", rhs = "y$", desc = "Copy to EOL" },
	{ modes = { "x" }, lhs = "C", rhs = "y", desc = "Yank (visual just y)" },
	{ modes = { "n", "x" }, lhs = "V", rhs = "P", desc = "Paste before" },

	-- Undo/redo
	{ modes = { "n" }, lhs = "z", rhs = "u", desc = "Undo last change" },
	{ modes = { "n" }, lhs = "gz", rhs = "U", desc = "Undo all changes on line" },
	{ modes = { "n" }, lhs = "Z", rhs = "<C-r>", desc = "Redo" },

	-- inSert/append (T)
	{ modes = { "n" }, lhs = "s", rhs = "i", desc = "Insert before" },
	{ modes = { "n" }, lhs = "S", rhs = "I", desc = "Insert at line start" },
	{ modes = { "n" }, lhs = "t", rhs = "a", desc = "Insert after" },
	{ modes = { "n" }, lhs = "T", rhs = "A", desc = "Insert at EOL" },

	-- Change
	{ modes = { "n", "o", "x" }, lhs = "w", rhs = "c", desc = "Change" },
	{ modes = { "n", "x" }, lhs = "W", rhs = "C", desc = "Change to EOL" },

	-- Visual mode
	{ modes = { "n", "x" }, lhs = "a", rhs = "v", desc = "Visual mode" },
	{ modes = { "n", "x" }, lhs = "A", rhs = "V", desc = "Visual linewise" },

	-- Insert in Visual mode
	{ modes = { "v" }, lhs = "S", rhs = "I", desc = "Insert at start of selection" },

	-- Search
	{ modes = { "n", "o", "x" }, lhs = "k", rhs = "n", desc = "Next search match" },
	{ modes = { "n", "o", "x" }, lhs = "K", rhs = "N", desc = "Prev search match" },

	-- 'til
	-- Breaks diffput
	{ modes = { "n", "o", "x" }, lhs = "p", rhs = "t", desc = "Move until char (left) (t)" },
	{ modes = { "n", "o", "x" }, lhs = "P", rhs = "T", desc = "Move until char (right) (T)" },

	-- Fix diffput (t for 'transfer')
	{
		modes = { "n" },
		lhs = "dt",
		rhs = "dp",
		desc = "Diff: put current hunk to other side",
	},

	-- Macros (replay the macro recorded by qq)
	{ modes = { "n" }, lhs = "Q", rhs = "@q", desc = "replay the 'q' macro" },

	-- Cursor to bottom of screen
	-- H (to top) and M (to middle) haven't been remapped, only L needs to be mapped
	{ modes = { "n" }, lhs = "B", rhs = "L", desc = "Cursor to bottom of the screen" },
	{ modes = { "v" }, lhs = "B", rhs = "L", desc = "Cursor to bottom of the screen" },

	-- Misc overridden keys must be prefixed with g
	{ modes = { "n", "x" }, lhs = "gX", rhs = "X", desc = "Delete without yanking (X)" },
	{ modes = { "n", "x" }, lhs = "gU", rhs = "U", desc = "Restore last changed (U)" },
	-- { modes = { "n", "x" },      lhs = "gQ",         rhs = "Q",          desc = "CMD-mode (Q)" },
	{ modes = { "n", "x" }, lhs = "gK", rhs = "K", desc = "Show man for keyword" },
	-- extra alias
	{ modes = { "n" }, lhs = "gh", rhs = "K", desc = "Show man for keyword" },
	{ modes = { "x" }, lhs = "gh", rhs = "K", desc = "Show man for keyword" },

	-- Window navigation
	{ modes = { "n" }, lhs = "<C-w>n", rhs = "<C-w>h", desc = "Move to window left" },
	{ modes = { "n" }, lhs = "<C-w>u", rhs = "<C-w>k", desc = "Move to window up" },
	{ modes = { "n" }, lhs = "<C-w>e", rhs = "<C-w>j", desc = "Move to window down" },
	{ modes = { "n" }, lhs = "<C-w>i", rhs = "<C-w>l", desc = "Move to window right" },
	{ modes = { "n" }, lhs = "<C-w>N", rhs = "<C-w>H", desc = "Move window left" },
	{ modes = { "n" }, lhs = "<C-w>U", rhs = "<C-w>K", desc = "Move window up" },
	{ modes = { "n" }, lhs = "<C-w>E", rhs = "<C-w>J", desc = "Move window down" },
	{ modes = { "n" }, lhs = "<C-w>I", rhs = "<C-w>L", desc = "Move window right" },
	-- Disable spawning empty buffer
	{ modes = { "n" }, lhs = "<C-w><C-n>", rhs = "<nop>", desc = "Disable opening new empty window" },
}

function colemak.setup(_)
	colemak.apply()

	vim.api.nvim_create_user_command("ColemakEnable", colemak.apply, { desc = "Applies Colemak mappings" })
	vim.api.nvim_create_user_command("ColemakDisable", colemak.unapply, { desc = "Removes Colemak mappings" })
end

function colemak.apply()
	for _, mapping in pairs(mappings) do
		vim.keymap.set(mapping.modes, mapping.lhs, mapping.rhs, { desc = mapping.desc })
	end
end

function colemak.unapply()
	for _, mapping in pairs(mappings) do
		vim.keymap.del(mapping.modes, mapping.lhs)
	end
end

return colemak
