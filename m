Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWGYHBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWGYHBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWGYHBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:01:34 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:5032 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751477AbWGYHBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:01:33 -0400
Date: Tue, 25 Jul 2006 09:01:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH v2 1/3] kconfig/lxdialog: refactor color support
Message-ID: <20060725070112.GA3033@mars.ravnborg.org>
References: <20060725065640.GA2685@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725065640.GA2685@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9238251dddc15b52656e70b74dffe56193d01215 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Mon, 24 Jul 2006 21:40:46 +0200
Subject: [PATCH] kconfig/lxdialog: refactor color support

Clean up and refactor color support. All color support are now
in util.c including color definitions.
In the process introduced a global variable named 'dlg' which is
used all over to set color - thats the reason why all files are changed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/checklist.c |   28 ++--
 scripts/kconfig/lxdialog/colors.h    |  154 --------------------
 scripts/kconfig/lxdialog/dialog.h    |   82 +++++------
 scripts/kconfig/lxdialog/inputbox.c  |   18 +-
 scripts/kconfig/lxdialog/lxdialog.c  |    6 -
 scripts/kconfig/lxdialog/menubox.c   |   28 ++--
 scripts/kconfig/lxdialog/msgbox.c    |    9 +
 scripts/kconfig/lxdialog/textbox.c   |   19 +-
 scripts/kconfig/lxdialog/util.c      |  259 +++++++++++++++++++---------------
 scripts/kconfig/lxdialog/yesno.c     |    9 +
 10 files changed, 250 insertions(+), 362 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 7988641..b90e888 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -34,18 +34,19 @@ static void print_item(WINDOW * win, con
 	int i;
 
 	/* Clear 'residue' of last item */
-	wattrset(win, menubox_attr);
+	wattrset(win, dlg.menubox.atr);
 	wmove(win, choice, 0);
 	for (i = 0; i < list_width; i++)
 		waddch(win, ' ');
 
 	wmove(win, choice, check_x);
-	wattrset(win, selected ? check_selected_attr : check_attr);
+	wattrset(win, selected ? dlg.check_selected.atr
+		 : dlg.check.atr);
 	wprintw(win, "(%c)", status ? 'X' : ' ');
 
-	wattrset(win, selected ? tag_selected_attr : tag_attr);
+	wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
 	mvwaddch(win, choice, item_x, item[0]);
-	wattrset(win, selected ? item_selected_attr : item_attr);
+	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
 	waddstr(win, (char *)item + 1);
 	if (selected) {
 		wmove(win, choice, check_x + 1);
@@ -62,11 +63,11 @@ static void print_arrows(WINDOW * win, i
 	wmove(win, y, x);
 
 	if (scroll > 0) {
-		wattrset(win, uarrow_attr);
+		wattrset(win, dlg.uarrow.atr);
 		waddch(win, ACS_UARROW);
 		waddstr(win, "(-)");
 	} else {
-		wattrset(win, menubox_attr);
+		wattrset(win, dlg.menubox.atr);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
@@ -77,11 +78,11 @@ static void print_arrows(WINDOW * win, i
 	wmove(win, y, x);
 
 	if ((height < item_no) && (scroll + choice < item_no - 1)) {
-		wattrset(win, darrow_attr);
+		wattrset(win, dlg.darrow.atr);
 		waddch(win, ACS_DARROW);
 		waddstr(win, "(+)");
 	} else {
-		wattrset(win, menubox_border_attr);
+		wattrset(win, dlg.menubox_border.atr);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
@@ -145,17 +146,18 @@ int dialog_checklist(const char *title, 
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
-	wattrset(dialog, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
 	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	waddch(dialog, ACS_RTEE);
 
 	print_title(dialog, title, width);
 
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
 
 	list_width = width - 6;
@@ -170,7 +172,7 @@ int dialog_checklist(const char *title, 
 
 	/* draw a box around the list items */
 	draw_box(dialog, box_y, box_x, list_height + 2, list_width + 2,
-	         menubox_border_attr, menubox_attr);
+	         dlg.menubox_border.atr, dlg.menubox.atr);
 
 	/* Find length of longest item in order to center checklist */
 	check_x = 0;
diff --git a/scripts/kconfig/lxdialog/colors.h b/scripts/kconfig/lxdialog/colors.h
deleted file mode 100644
index db071df..0000000
--- a/scripts/kconfig/lxdialog/colors.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- *  colors.h -- color attribute definitions
- *
- *  AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-/*
- *   Default color definitions
- *
- *   *_FG = foreground
- *   *_BG = background
- *   *_HL = highlight?
- */
-#define SCREEN_FG                    COLOR_CYAN
-#define SCREEN_BG                    COLOR_BLUE
-#define SCREEN_HL                    TRUE
-
-#define SHADOW_FG                    COLOR_BLACK
-#define SHADOW_BG                    COLOR_BLACK
-#define SHADOW_HL                    TRUE
-
-#define DIALOG_FG                    COLOR_BLACK
-#define DIALOG_BG                    COLOR_WHITE
-#define DIALOG_HL                    FALSE
-
-#define TITLE_FG                     COLOR_YELLOW
-#define TITLE_BG                     COLOR_WHITE
-#define TITLE_HL                     TRUE
-
-#define BORDER_FG                    COLOR_WHITE
-#define BORDER_BG                    COLOR_WHITE
-#define BORDER_HL                    TRUE
-
-#define BUTTON_ACTIVE_FG             COLOR_WHITE
-#define BUTTON_ACTIVE_BG             COLOR_BLUE
-#define BUTTON_ACTIVE_HL             TRUE
-
-#define BUTTON_INACTIVE_FG           COLOR_BLACK
-#define BUTTON_INACTIVE_BG           COLOR_WHITE
-#define BUTTON_INACTIVE_HL           FALSE
-
-#define BUTTON_KEY_ACTIVE_FG         COLOR_WHITE
-#define BUTTON_KEY_ACTIVE_BG         COLOR_BLUE
-#define BUTTON_KEY_ACTIVE_HL         TRUE
-
-#define BUTTON_KEY_INACTIVE_FG       COLOR_RED
-#define BUTTON_KEY_INACTIVE_BG       COLOR_WHITE
-#define BUTTON_KEY_INACTIVE_HL       FALSE
-
-#define BUTTON_LABEL_ACTIVE_FG       COLOR_YELLOW
-#define BUTTON_LABEL_ACTIVE_BG       COLOR_BLUE
-#define BUTTON_LABEL_ACTIVE_HL       TRUE
-
-#define BUTTON_LABEL_INACTIVE_FG     COLOR_BLACK
-#define BUTTON_LABEL_INACTIVE_BG     COLOR_WHITE
-#define BUTTON_LABEL_INACTIVE_HL     TRUE
-
-#define INPUTBOX_FG                  COLOR_BLACK
-#define INPUTBOX_BG                  COLOR_WHITE
-#define INPUTBOX_HL                  FALSE
-
-#define INPUTBOX_BORDER_FG           COLOR_BLACK
-#define INPUTBOX_BORDER_BG           COLOR_WHITE
-#define INPUTBOX_BORDER_HL           FALSE
-
-#define SEARCHBOX_FG                 COLOR_BLACK
-#define SEARCHBOX_BG                 COLOR_WHITE
-#define SEARCHBOX_HL                 FALSE
-
-#define SEARCHBOX_TITLE_FG           COLOR_YELLOW
-#define SEARCHBOX_TITLE_BG           COLOR_WHITE
-#define SEARCHBOX_TITLE_HL           TRUE
-
-#define SEARCHBOX_BORDER_FG          COLOR_WHITE
-#define SEARCHBOX_BORDER_BG          COLOR_WHITE
-#define SEARCHBOX_BORDER_HL          TRUE
-
-#define POSITION_INDICATOR_FG        COLOR_YELLOW
-#define POSITION_INDICATOR_BG        COLOR_WHITE
-#define POSITION_INDICATOR_HL        TRUE
-
-#define MENUBOX_FG                   COLOR_BLACK
-#define MENUBOX_BG                   COLOR_WHITE
-#define MENUBOX_HL                   FALSE
-
-#define MENUBOX_BORDER_FG            COLOR_WHITE
-#define MENUBOX_BORDER_BG            COLOR_WHITE
-#define MENUBOX_BORDER_HL            TRUE
-
-#define ITEM_FG                      COLOR_BLACK
-#define ITEM_BG                      COLOR_WHITE
-#define ITEM_HL                      FALSE
-
-#define ITEM_SELECTED_FG             COLOR_WHITE
-#define ITEM_SELECTED_BG             COLOR_BLUE
-#define ITEM_SELECTED_HL             TRUE
-
-#define TAG_FG                       COLOR_YELLOW
-#define TAG_BG                       COLOR_WHITE
-#define TAG_HL                       TRUE
-
-#define TAG_SELECTED_FG              COLOR_YELLOW
-#define TAG_SELECTED_BG              COLOR_BLUE
-#define TAG_SELECTED_HL              TRUE
-
-#define TAG_KEY_FG                   COLOR_YELLOW
-#define TAG_KEY_BG                   COLOR_WHITE
-#define TAG_KEY_HL                   TRUE
-
-#define TAG_KEY_SELECTED_FG          COLOR_YELLOW
-#define TAG_KEY_SELECTED_BG          COLOR_BLUE
-#define TAG_KEY_SELECTED_HL          TRUE
-
-#define CHECK_FG                     COLOR_BLACK
-#define CHECK_BG                     COLOR_WHITE
-#define CHECK_HL                     FALSE
-
-#define CHECK_SELECTED_FG            COLOR_WHITE
-#define CHECK_SELECTED_BG            COLOR_BLUE
-#define CHECK_SELECTED_HL            TRUE
-
-#define UARROW_FG                    COLOR_GREEN
-#define UARROW_BG                    COLOR_WHITE
-#define UARROW_HL                    TRUE
-
-#define DARROW_FG                    COLOR_GREEN
-#define DARROW_BG                    COLOR_WHITE
-#define DARROW_HL                    TRUE
-
-/* End of default color definitions */
-
-#define C_ATTR(x,y)                  ((x ? A_BOLD : 0) | COLOR_PAIR((y)))
-#define COLOR_NAME_LEN               10
-#define COLOR_COUNT                  8
-
-/*
- * Global variables
- */
-
-extern int color_table[][3];
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index af3cf71..2f4c19d 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -87,62 +87,60 @@ #define ACS_DARROW 'v'
 #endif
 
 /*
- * Attribute names
+ *   Color definitions
  */
-#define screen_attr                   attributes[0]
-#define shadow_attr                   attributes[1]
-#define dialog_attr                   attributes[2]
-#define title_attr                    attributes[3]
-#define border_attr                   attributes[4]
-#define button_active_attr            attributes[5]
-#define button_inactive_attr          attributes[6]
-#define button_key_active_attr        attributes[7]
-#define button_key_inactive_attr      attributes[8]
-#define button_label_active_attr      attributes[9]
-#define button_label_inactive_attr    attributes[10]
-#define inputbox_attr                 attributes[11]
-#define inputbox_border_attr          attributes[12]
-#define searchbox_attr                attributes[13]
-#define searchbox_title_attr          attributes[14]
-#define searchbox_border_attr         attributes[15]
-#define position_indicator_attr       attributes[16]
-#define menubox_attr                  attributes[17]
-#define menubox_border_attr           attributes[18]
-#define item_attr                     attributes[19]
-#define item_selected_attr            attributes[20]
-#define tag_attr                      attributes[21]
-#define tag_selected_attr             attributes[22]
-#define tag_key_attr                  attributes[23]
-#define tag_key_selected_attr         attributes[24]
-#define check_attr                    attributes[25]
-#define check_selected_attr           attributes[26]
-#define uarrow_attr                   attributes[27]
-#define darrow_attr                   attributes[28]
+struct dialog_color {
+	chtype atr;	/* Color attribute */
+	int fg;		/* foreground */
+	int bg;		/* background */
+	int hl;		/* highlight this item */
+};
 
-/* number of attributes */
-#define ATTRIBUTE_COUNT               29
+struct dialog_info {
+	const char *backtitle;
+	struct dialog_color screen;
+	struct dialog_color shadow;
+	struct dialog_color dialog;
+	struct dialog_color title;
+	struct dialog_color border;
+	struct dialog_color button_active;
+	struct dialog_color button_inactive;
+	struct dialog_color button_key_active;
+	struct dialog_color button_key_inactive;
+	struct dialog_color button_label_active;
+	struct dialog_color button_label_inactive;
+	struct dialog_color inputbox;
+	struct dialog_color inputbox_border;
+	struct dialog_color searchbox;
+	struct dialog_color searchbox_title;
+	struct dialog_color searchbox_border;
+	struct dialog_color position_indicator;
+	struct dialog_color menubox;
+	struct dialog_color menubox_border;
+	struct dialog_color item;
+	struct dialog_color item_selected;
+	struct dialog_color tag;
+	struct dialog_color tag_selected;
+	struct dialog_color tag_key;
+	struct dialog_color tag_key_selected;
+	struct dialog_color check;
+	struct dialog_color check_selected;
+	struct dialog_color uarrow;
+	struct dialog_color darrow;
+};
 
 /*
  * Global variables
  */
-extern bool use_colors;
-extern bool use_shadow;
-
-extern chtype attributes[];
-
-extern const char *backtitle;
+extern struct dialog_info dlg;
 
 /*
  * Function prototypes
  */
-extern void create_rc(const char *filename);
-extern int parse_rc(void);
-
 void init_dialog(void);
 void end_dialog(void);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
-void color_setup(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 7795037..f75b51f 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -58,17 +58,18 @@ int dialog_inputbox(const char *title, c
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
-	wattrset(dialog, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
 	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	waddch(dialog, ACS_RTEE);
 
 	print_title(dialog, title, width);
 
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
 
 	/* Draw the input field box */
@@ -76,13 +77,14 @@ int dialog_inputbox(const char *title, c
 	getyx(dialog, y, x);
 	box_y = y + 2;
 	box_x = (width - box_width) / 2;
-	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2, border_attr, dialog_attr);
+	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2,
+		 dlg.border.atr, dlg.dialog.atr);
 
 	print_buttons(dialog, height, width, 0);
 
 	/* Set up the initial value */
 	wmove(dialog, box_y, box_x);
-	wattrset(dialog, inputbox_attr);
+	wattrset(dialog, dlg.inputbox.atr);
 
 	if (!init)
 		instr[0] = '\0';
@@ -120,7 +122,7 @@ int dialog_inputbox(const char *title, c
 			case KEY_BACKSPACE:
 			case 127:
 				if (input_x || scroll) {
-					wattrset(dialog, inputbox_attr);
+					wattrset(dialog, dlg.inputbox.atr);
 					if (!input_x) {
 						scroll = scroll < box_width - 1 ? 0 : scroll - (box_width - 1);
 						wmove(dialog, box_y, box_x);
@@ -140,7 +142,7 @@ int dialog_inputbox(const char *title, c
 			default:
 				if (key < 0x100 && isprint(key)) {
 					if (scroll + input_x < MAX_LEN) {
-						wattrset(dialog, inputbox_attr);
+						wattrset(dialog, dlg.inputbox.atr);
 						instr[scroll + input_x] = key;
 						instr[scroll + input_x + 1] = '\0';
 						if (input_x == box_width - 1) {
diff --git a/scripts/kconfig/lxdialog/lxdialog.c b/scripts/kconfig/lxdialog/lxdialog.c
index 79f6c5f..c264e02 100644
--- a/scripts/kconfig/lxdialog/lxdialog.c
+++ b/scripts/kconfig/lxdialog/lxdialog.c
@@ -78,11 +78,11 @@ #endif
 				offset += 2;
 			}
 		} else if (!strcmp(argv[offset + 1], "--backtitle")) {
-			if (backtitle != NULL) {
+			if (dlg.backtitle != NULL) {
 				Usage(argv[0]);
 				exit(-1);
 			} else {
-				backtitle = argv[offset + 2];
+				dlg.backtitle = argv[offset + 2];
 				offset += 2;
 			}
 		} else if (!strcmp(argv[offset + 1], "--clear")) {
@@ -123,7 +123,7 @@ #endif
 	retval = (*(modePtr->jumper)) (title, argc - offset, argv + offset);
 
 	if (opt_clear) {	/* clear screen before exit */
-		attr_clear(stdscr, LINES, COLS, screen_attr);
+		attr_clear(stdscr, LINES, COLS, dlg.screen.atr);
 		refresh();
 	}
 	end_dialog();
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index bf8052f..ff991db 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -74,7 +74,7 @@ static void do_print_item(WINDOW * win, 
 	j = first_alpha(menu_item, "YyNnMmHh");
 
 	/* Clear 'residue' of last item */
-	wattrset(win, menubox_attr);
+	wattrset(win, dlg.menubox.atr);
 	wmove(win, choice, 0);
 #if OLD_NCURSES
 	{
@@ -85,10 +85,11 @@ #if OLD_NCURSES
 #else
 	wclrtoeol(win);
 #endif
-	wattrset(win, selected ? item_selected_attr : item_attr);
+	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
 	mvwaddstr(win, choice, item_x, menu_item);
 	if (hotkey) {
-		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
+		wattrset(win, selected ? dlg.tag_key_selected.atr
+			 : dlg.tag_key.atr);
 		mvwaddch(win, choice, item_x + j, menu_item[j]);
 	}
 	if (selected) {
@@ -117,11 +118,11 @@ static void print_arrows(WINDOW * win, i
 	wmove(win, y, x);
 
 	if (scroll > 0) {
-		wattrset(win, uarrow_attr);
+		wattrset(win, dlg.uarrow.atr);
 		waddch(win, ACS_UARROW);
 		waddstr(win, "(-)");
 	} else {
-		wattrset(win, menubox_attr);
+		wattrset(win, dlg.menubox.atr);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
@@ -133,11 +134,11 @@ static void print_arrows(WINDOW * win, i
 	wrefresh(win);
 
 	if ((height < item_no) && (scroll + height < item_no)) {
-		wattrset(win, darrow_attr);
+		wattrset(win, dlg.darrow.atr);
 		waddch(win, ACS_DARROW);
 		waddstr(win, "(+)");
 	} else {
-		wattrset(win, menubox_border_attr);
+		wattrset(win, dlg.menubox_border.atr);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
@@ -199,18 +200,19 @@ int dialog_menu(const char *title, const
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
-	wattrset(dialog, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
 	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
-	wattrset(dialog, dialog_attr);
-	wbkgdset(dialog, dialog_attr & A_COLOR);
+	wattrset(dialog, dlg.dialog.atr);
+	wbkgdset(dialog, dlg.dialog.atr & A_COLOR);
 	waddch(dialog, ACS_RTEE);
 
 	print_title(dialog, title, width);
 
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
 
 	menu_width = width - 6;
@@ -224,7 +226,7 @@ int dialog_menu(const char *title, const
 
 	/* draw a box around the menu items */
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
-		 menubox_border_attr, menubox_attr);
+		 dlg.menubox_border.atr, dlg.menubox.atr);
 
 	item_x = (menu_width - 70) / 2;
 
diff --git a/scripts/kconfig/lxdialog/msgbox.c b/scripts/kconfig/lxdialog/msgbox.c
index 7323f54..236759f 100644
--- a/scripts/kconfig/lxdialog/msgbox.c
+++ b/scripts/kconfig/lxdialog/msgbox.c
@@ -40,19 +40,20 @@ int dialog_msgbox(const char *title, con
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
 
 	print_title(dialog, title, width);
 
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	print_autowrap(dialog, prompt, width - 2, 1, 2);
 
 	if (pause) {
-		wattrset(dialog, border_attr);
+		wattrset(dialog, dlg.border.atr);
 		mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 		for (i = 0; i < width - 2; i++)
 			waddch(dialog, ACS_HLINE);
-		wattrset(dialog, dialog_attr);
+		wattrset(dialog, dlg.dialog.atr);
 		waddch(dialog, ACS_RTEE);
 
 		print_button(dialog, "  Ok  ", height - 2, width / 2 - 4, TRUE);
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 77848bb..336793b 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -87,20 +87,21 @@ int dialog_textbox(const char *title, co
 
 	/* Create window for text region, used for scrolling text */
 	text = subwin(dialog, height - 4, width - 2, y + 1, x + 1);
-	wattrset(text, dialog_attr);
-	wbkgdset(text, dialog_attr & A_COLOR);
+	wattrset(text, dlg.dialog.atr);
+	wbkgdset(text, dlg.dialog.atr & A_COLOR);
 
 	keypad(text, TRUE);
 
 	/* register the new window, along with its borders */
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
 
-	wattrset(dialog, border_attr);
+	wattrset(dialog, dlg.border.atr);
 	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
-	wattrset(dialog, dialog_attr);
-	wbkgdset(dialog, dialog_attr & A_COLOR);
+	wattrset(dialog, dlg.dialog.atr);
+	wbkgdset(dialog, dlg.dialog.atr & A_COLOR);
 	waddch(dialog, ACS_RTEE);
 
 	print_title(dialog, title, width);
@@ -110,7 +111,7 @@ int dialog_textbox(const char *title, co
 	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
 
 	/* Print first page of text */
-	attr_clear(text, height - 4, width - 2, dialog_attr);
+	attr_clear(text, height - 4, width - 2, dlg.dialog.atr);
 	print_page(text, height - 4, width - 2);
 	print_position(dialog, height, width);
 	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
@@ -524,8 +525,8 @@ static void print_position(WINDOW * win,
 		fprintf(stderr, "\nError moving file pointer in print_position().\n");
 		exit(-1);
 	}
-	wattrset(win, position_indicator_attr);
-	wbkgdset(win, position_indicator_attr & A_COLOR);
+	wattrset(win, dlg.position_indicator.atr);
+	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
 	percent = !file_size ?
 	    100 : ((fpos - bytes_read + page - buf) * 100) / file_size;
 	wmove(win, height - 3, width - 9);
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f82cebb..08f98b1 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -21,85 +21,141 @@
 
 #include "dialog.h"
 
-/* use colors by default? */
-bool use_colors = 1;
+struct dialog_info dlg;
 
-const char *backtitle = NULL;
+static void set_mono_theme(void)
+{
+	dlg.screen.atr = A_NORMAL;
+	dlg.shadow.atr = A_NORMAL;
+	dlg.dialog.atr = A_NORMAL;
+	dlg.title.atr = A_BOLD;
+	dlg.border.atr = A_NORMAL;
+	dlg.button_active.atr = A_REVERSE;
+	dlg.button_inactive.atr = A_DIM;
+	dlg.button_key_active.atr = A_REVERSE;
+	dlg.button_key_inactive.atr = A_BOLD;
+	dlg.button_label_active.atr = A_REVERSE;
+	dlg.button_label_inactive.atr = A_NORMAL;
+	dlg.inputbox.atr = A_NORMAL;
+	dlg.inputbox_border.atr = A_NORMAL;
+	dlg.searchbox.atr = A_NORMAL;
+	dlg.searchbox_title.atr = A_BOLD;
+	dlg.searchbox_border.atr = A_NORMAL;
+	dlg.position_indicator.atr = A_BOLD;
+	dlg.menubox.atr = A_NORMAL;
+	dlg.menubox_border.atr = A_NORMAL;
+	dlg.item.atr = A_NORMAL;
+	dlg.item_selected.atr = A_REVERSE;
+	dlg.tag.atr = A_BOLD;
+	dlg.tag_selected.atr = A_REVERSE;
+	dlg.tag_key.atr = A_BOLD;
+	dlg.tag_key_selected.atr = A_REVERSE;
+	dlg.check.atr = A_BOLD;
+	dlg.check_selected.atr = A_REVERSE;
+	dlg.uarrow.atr = A_BOLD;
+	dlg.darrow.atr = A_BOLD;
+}
 
-/*
- * Attribute values, default is for mono display
- */
-chtype attributes[] = {
-	A_NORMAL,		/* screen_attr */
-	A_NORMAL,		/* shadow_attr */
-	A_NORMAL,		/* dialog_attr */
-	A_BOLD,			/* title_attr */
-	A_NORMAL,		/* border_attr */
-	A_REVERSE,		/* button_active_attr */
-	A_DIM,			/* button_inactive_attr */
-	A_REVERSE,		/* button_key_active_attr */
-	A_BOLD,			/* button_key_inactive_attr */
-	A_REVERSE,		/* button_label_active_attr */
-	A_NORMAL,		/* button_label_inactive_attr */
-	A_NORMAL,		/* inputbox_attr */
-	A_NORMAL,		/* inputbox_border_attr */
-	A_NORMAL,		/* searchbox_attr */
-	A_BOLD,			/* searchbox_title_attr */
-	A_NORMAL,		/* searchbox_border_attr */
-	A_BOLD,			/* position_indicator_attr */
-	A_NORMAL,		/* menubox_attr */
-	A_NORMAL,		/* menubox_border_attr */
-	A_NORMAL,		/* item_attr */
-	A_REVERSE,		/* item_selected_attr */
-	A_BOLD,			/* tag_attr */
-	A_REVERSE,		/* tag_selected_attr */
-	A_BOLD,			/* tag_key_attr */
-	A_REVERSE,		/* tag_key_selected_attr */
-	A_BOLD,			/* check_attr */
-	A_REVERSE,		/* check_selected_attr */
-	A_BOLD,			/* uarrow_attr */
-	A_BOLD			/* darrow_attr */
-};
-
-#include "colors.h"
+#define DLG_COLOR(dialog, f, b, h) \
+do {                               \
+	dlg.dialog.fg = (f);       \
+	dlg.dialog.bg = (b);       \
+	dlg.dialog.hl = (h);       \
+} while (0)
+
+static void set_classic_theme(void)
+{
+	DLG_COLOR(screen,                COLOR_CYAN,   COLOR_BLUE,   true);
+	DLG_COLOR(shadow,                COLOR_BLACK,  COLOR_BLACK,  true);
+	DLG_COLOR(dialog,                COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(title,                 COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(border,                COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(button_active,         COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(button_inactive,       COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(button_key_active,     COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(button_key_inactive,   COLOR_RED,    COLOR_WHITE,  false);
+	DLG_COLOR(button_label_active,   COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_WHITE,  true);
+	DLG_COLOR(inputbox,              COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(inputbox_border,       COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(searchbox,             COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(searchbox_title,       COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(searchbox_border,      COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(position_indicator,    COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(menubox,               COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(menubox_border,        COLOR_WHITE,  COLOR_WHITE,  true);
+	DLG_COLOR(item,                  COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(item_selected,         COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(tag,                   COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(tag_selected,          COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(tag_key,               COLOR_YELLOW, COLOR_WHITE,  true);
+	DLG_COLOR(tag_key_selected,      COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_COLOR(check,                 COLOR_BLACK,  COLOR_WHITE,  false);
+	DLG_COLOR(check_selected,        COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(uarrow,                COLOR_GREEN,  COLOR_WHITE,  true);
+	DLG_COLOR(darrow,                COLOR_GREEN,  COLOR_WHITE,  true);
+}
+
+static void init_one_color(struct dialog_color *color)
+{
+	static int pair = 0;
+
+	pair++;
+	init_pair(pair, color->fg, color->bg);
+	if (color->hl)
+		color->atr = A_BOLD | COLOR_PAIR(pair);
+	else
+		color->atr = COLOR_PAIR(pair);
+}
+
+static void init_dialog_colors(void)
+{
+	init_one_color(&dlg.screen);
+	init_one_color(&dlg.shadow);
+	init_one_color(&dlg.dialog);
+	init_one_color(&dlg.title);
+	init_one_color(&dlg.border);
+	init_one_color(&dlg.button_active);
+	init_one_color(&dlg.button_inactive);
+	init_one_color(&dlg.button_key_active);
+	init_one_color(&dlg.button_key_inactive);
+	init_one_color(&dlg.button_label_active);
+	init_one_color(&dlg.button_label_inactive);
+	init_one_color(&dlg.inputbox);
+	init_one_color(&dlg.inputbox_border);
+	init_one_color(&dlg.searchbox);
+	init_one_color(&dlg.searchbox_title);
+	init_one_color(&dlg.searchbox_border);
+	init_one_color(&dlg.position_indicator);
+	init_one_color(&dlg.menubox);
+	init_one_color(&dlg.menubox_border);
+	init_one_color(&dlg.item);
+	init_one_color(&dlg.item_selected);
+	init_one_color(&dlg.tag);
+	init_one_color(&dlg.tag_selected);
+	init_one_color(&dlg.tag_key);
+	init_one_color(&dlg.tag_key_selected);
+	init_one_color(&dlg.check);
+	init_one_color(&dlg.check_selected);
+	init_one_color(&dlg.uarrow);
+	init_one_color(&dlg.darrow);
+}
 
 /*
- * Table of color values
+ * Setup for color display
  */
-int color_table[][3] = {
-	{SCREEN_FG, SCREEN_BG, SCREEN_HL},
-	{SHADOW_FG, SHADOW_BG, SHADOW_HL},
-	{DIALOG_FG, DIALOG_BG, DIALOG_HL},
-	{TITLE_FG, TITLE_BG, TITLE_HL},
-	{BORDER_FG, BORDER_BG, BORDER_HL},
-	{BUTTON_ACTIVE_FG, BUTTON_ACTIVE_BG, BUTTON_ACTIVE_HL},
-	{BUTTON_INACTIVE_FG, BUTTON_INACTIVE_BG, BUTTON_INACTIVE_HL},
-	{BUTTON_KEY_ACTIVE_FG, BUTTON_KEY_ACTIVE_BG, BUTTON_KEY_ACTIVE_HL},
-	{BUTTON_KEY_INACTIVE_FG, BUTTON_KEY_INACTIVE_BG,
-	 BUTTON_KEY_INACTIVE_HL},
-	{BUTTON_LABEL_ACTIVE_FG, BUTTON_LABEL_ACTIVE_BG,
-	 BUTTON_LABEL_ACTIVE_HL},
-	{BUTTON_LABEL_INACTIVE_FG, BUTTON_LABEL_INACTIVE_BG,
-	 BUTTON_LABEL_INACTIVE_HL},
-	{INPUTBOX_FG, INPUTBOX_BG, INPUTBOX_HL},
-	{INPUTBOX_BORDER_FG, INPUTBOX_BORDER_BG, INPUTBOX_BORDER_HL},
-	{SEARCHBOX_FG, SEARCHBOX_BG, SEARCHBOX_HL},
-	{SEARCHBOX_TITLE_FG, SEARCHBOX_TITLE_BG, SEARCHBOX_TITLE_HL},
-	{SEARCHBOX_BORDER_FG, SEARCHBOX_BORDER_BG, SEARCHBOX_BORDER_HL},
-	{POSITION_INDICATOR_FG, POSITION_INDICATOR_BG, POSITION_INDICATOR_HL},
-	{MENUBOX_FG, MENUBOX_BG, MENUBOX_HL},
-	{MENUBOX_BORDER_FG, MENUBOX_BORDER_BG, MENUBOX_BORDER_HL},
-	{ITEM_FG, ITEM_BG, ITEM_HL},
-	{ITEM_SELECTED_FG, ITEM_SELECTED_BG, ITEM_SELECTED_HL},
-	{TAG_FG, TAG_BG, TAG_HL},
-	{TAG_SELECTED_FG, TAG_SELECTED_BG, TAG_SELECTED_HL},
-	{TAG_KEY_FG, TAG_KEY_BG, TAG_KEY_HL},
-	{TAG_KEY_SELECTED_FG, TAG_KEY_SELECTED_BG, TAG_KEY_SELECTED_HL},
-	{CHECK_FG, CHECK_BG, CHECK_HL},
-	{CHECK_SELECTED_FG, CHECK_SELECTED_BG, CHECK_SELECTED_HL},
-	{UARROW_FG, UARROW_BG, UARROW_HL},
-	{DARROW_FG, DARROW_BG, DARROW_HL},
-};				/* color_table */
+static void color_setup(void)
+{
+	if (has_colors()) {	/* Terminal supports color? */
+		start_color();
+		set_classic_theme();
+		init_dialog_colors();
+	}
+	else
+	{
+		set_mono_theme();
+	}
+}
 
 /*
  * Set window to attribute 'attr'
@@ -119,13 +175,13 @@ void attr_clear(WINDOW * win, int height
 
 void dialog_clear(void)
 {
-	attr_clear(stdscr, LINES, COLS, screen_attr);
+	attr_clear(stdscr, LINES, COLS, dlg.screen.atr);
 	/* Display background title if it exists ... - SLH */
-	if (backtitle != NULL) {
+	if (dlg.backtitle != NULL) {
 		int i;
 
-		wattrset(stdscr, screen_attr);
-		mvwaddstr(stdscr, 0, 1, (char *)backtitle);
+		wattrset(stdscr, dlg.screen.atr);
+		mvwaddstr(stdscr, 0, 1, (char *)dlg.backtitle);
 		wmove(stdscr, 1, 1);
 		for (i = 1; i < COLS - 1; i++)
 			waddch(stdscr, ACS_HLINE);
@@ -142,34 +198,11 @@ void init_dialog(void)
 	keypad(stdscr, TRUE);
 	cbreak();
 	noecho();
-
-	if (use_colors)		/* Set up colors */
-		color_setup();
-
+	color_setup();
 	dialog_clear();
 }
 
 /*
- * Setup for color display
- */
-void color_setup(void)
-{
-	int i;
-
-	if (has_colors()) {	/* Terminal supports color? */
-		start_color();
-
-		/* Initialize color pairs */
-		for (i = 0; i < ATTRIBUTE_COUNT; i++)
-			init_pair(i + 1, color_table[i][0], color_table[i][1]);
-
-		/* Setup color attributes */
-		for (i = 0; i < ATTRIBUTE_COUNT; i++)
-			attributes[i] = C_ATTR(color_table[i][2], i + 1);
-	}
-}
-
-/*
  * End using dialog functions.
  */
 void end_dialog(void)
@@ -184,7 +217,7 @@ void print_title(WINDOW *dialog, const c
 {
 	if (title) {
 		int tlen = MIN(width - 2, strlen(title));
-		wattrset(dialog, title_attr);
+		wattrset(dialog, dlg.title.atr);
 		mvwaddch(dialog, 0, (width - tlen) / 2 - 1, ' ');
 		mvwaddnstr(dialog, 0, (width - tlen)/2, title, tlen);
 		waddch(dialog, ' ');
@@ -264,21 +297,23 @@ void print_button(WINDOW * win, const ch
 	int i, temp;
 
 	wmove(win, y, x);
-	wattrset(win, selected ? button_active_attr : button_inactive_attr);
+	wattrset(win, selected ? dlg.button_active.atr
+		 : dlg.button_inactive.atr);
 	waddstr(win, "<");
 	temp = strspn(label, " ");
 	label += temp;
-	wattrset(win, selected ? button_label_active_attr
-		 : button_label_inactive_attr);
+	wattrset(win, selected ? dlg.button_label_active.atr
+		 : dlg.button_label_inactive.atr);
 	for (i = 0; i < temp; i++)
 		waddch(win, ' ');
-	wattrset(win, selected ? button_key_active_attr
-		 : button_key_inactive_attr);
+	wattrset(win, selected ? dlg.button_key_active.atr
+		 : dlg.button_key_inactive.atr);
 	waddch(win, label[0]);
-	wattrset(win, selected ? button_label_active_attr
-		 : button_label_inactive_attr);
+	wattrset(win, selected ? dlg.button_label_active.atr
+		 : dlg.button_label_inactive.atr);
 	waddstr(win, (char *)label + 1);
-	wattrset(win, selected ? button_active_attr : button_inactive_attr);
+	wattrset(win, selected ? dlg.button_active.atr
+		 : dlg.button_inactive.atr);
 	waddstr(win, ">");
 	wmove(win, y, x + temp + 1);
 }
@@ -326,7 +361,7 @@ void draw_shadow(WINDOW * win, int y, in
 	int i;
 
 	if (has_colors()) {	/* Whether terminal supports color? */
-		wattrset(win, shadow_attr);
+		wattrset(win, dlg.shadow.atr);
 		wmove(win, y + height, x + 2);
 		for (i = 0; i < width; i++)
 			waddch(win, winch(win) & A_CHARTEXT);
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index cb2568a..e938037 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -53,17 +53,18 @@ int dialog_yesno(const char *title, cons
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
-	wattrset(dialog, border_attr);
+	draw_box(dialog, 0, 0, height, width,
+		 dlg.dialog.atr, dlg.border.atr);
+	wattrset(dialog, dlg.border.atr);
 	mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	waddch(dialog, ACS_RTEE);
 
 	print_title(dialog, title, width);
 
-	wattrset(dialog, dialog_attr);
+	wattrset(dialog, dlg.dialog.atr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
 
 	print_buttons(dialog, height, width, 0);
-- 
1.4.1.rc2.gfc04

