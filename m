Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWG2U4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWG2U4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWG2U4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:56:39 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:11407 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932237AbWG2U4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:56:38 -0400
Date: Sat, 29 Jul 2006 22:56:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Message-ID: <20060729205621.GB13719@mars.ravnborg.org>
References: <20060727202726.GA3900@mars.ravnborg.org> <Pine.LNX.4.64.0607281348420.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607281348420.6761@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I will during the weekend try to address the resize issue.
> 
Here is my take on the resize support. textbox.c were hit by a little
refactoring in same go. I can split it in two patches if requested.

make menuconfig looks sensible and I have now pushed all patches out to:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/lxdialog.git

It will show up in next -mm for wider testing.
Comments welcome!

	Sam

>From 466ac6aa895d1c25964f9fef4502bb9b1cab6dd9 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Sat, 29 Jul 2006 22:48:57 +0200
Subject: [PATCH] kconfig/lxdialog: support resize

In all dialogs now properly catch KEY_RESIZE and take proper action.
In mconf try to behave sensibly when a dialog routine returns
-ERRDISPLAYTOOSMALL.

The original check for a screnn size of 80x19 is kept for now.
It may make sense to remove it later, but thats anyway what
much text is adjusted for.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/checklist.c |   11 +++
 scripts/kconfig/lxdialog/dialog.h    |    8 +-
 scripts/kconfig/lxdialog/inputbox.c  |   20 ++++-
 scripts/kconfig/lxdialog/menubox.c   |   25 +++++-
 scripts/kconfig/lxdialog/textbox.c   |  140 ++++++++++++++++++++--------------
 scripts/kconfig/lxdialog/util.c      |    6 +
 scripts/kconfig/lxdialog/yesno.c     |   10 ++
 scripts/kconfig/mconf.c              |   12 ++-
 8 files changed, 161 insertions(+), 71 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 39becb7..cf69708 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -125,6 +125,12 @@ int dialog_checklist(const char *title, 
 		}
 	}
 
+do_resize:
+	if (getmaxy(stdscr) < (height + 6))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) < (width + 6))
+		return -ERRDISPLAYTOOSMALL;
+
 	max_choice = MIN(list_height, item_count());
 
 	/* center dialog box on screen */
@@ -303,6 +309,11 @@ int dialog_checklist(const char *title, 
 		case KEY_ESC:
 			key = on_key_esc(dialog);
 			break;
+		case KEY_RESIZE:
+			delwin(list);
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
 		}
 
 		/* Now, update everything... */
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index a7cfdec..8dea47f 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -86,6 +86,9 @@ #ifndef ACS_DARROW
 #define ACS_DARROW 'v'
 #endif
 
+/* error return codes */
+#define ERRDISPLAYTOOSMALL (KEY_MAX + 1)
+
 /*
  *   Color definitions
  */
@@ -181,6 +184,7 @@ #define item_foreach() \
 
 /* generic key handlers */
 int on_key_esc(WINDOW *win);
+int on_key_resize(void);
 
 void init_dialog(const char *backtitle);
 void reset_dialog(void);
@@ -199,8 +203,8 @@ int dialog_yesno(const char *title, cons
 int dialog_msgbox(const char *title, const char *prompt, int height,
 		  int width, int pause);
 int dialog_textbox(const char *title, const char *file, int height, int width);
-int dialog_menu(const char *title, const char *prompt, int height, int width,
-		int menu_height, const void *selected, int *s_scroll);
+int dialog_menu(const char *title, const char *prompt,
+		const void *selected, int *s_scroll);
 int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height);
 extern char dialog_input_result[];
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index edb7975..05e7206 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -49,6 +49,17 @@ int dialog_inputbox(const char *title, c
 	char *instr = dialog_input_result;
 	WINDOW *dialog;
 
+	if (!init)
+		instr[0] = '\0';
+	else
+		strcpy(instr, init);
+
+do_resize:
+	if (getmaxy(stdscr) <= (height - 2))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) <= (width - 2))
+		return -ERRDISPLAYTOOSMALL;
+
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
 	y = (LINES - height) / 2;
@@ -86,11 +97,6 @@ int dialog_inputbox(const char *title, c
 	wmove(dialog, box_y, box_x);
 	wattrset(dialog, dlg.inputbox.atr);
 
-	if (!init)
-		instr[0] = '\0';
-	else
-		strcpy(instr, init);
-
 	input_x = strlen(instr);
 
 	if (input_x >= box_width) {
@@ -220,6 +226,10 @@ int dialog_inputbox(const char *title, c
 		case KEY_ESC:
 			key = on_key_esc(dialog);
 			break;
+		case KEY_RESIZE:
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
 		}
 	}
 
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d3305ba..fcd95a9 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -179,14 +179,25 @@ static void do_scroll(WINDOW *win, int *
 /*
  * Display a menu for choosing among a number of options
  */
-int dialog_menu(const char *title, const char *prompt, int height, int width,
-                int menu_height, const void *selected, int *s_scroll)
+int dialog_menu(const char *title, const char *prompt,
+                const void *selected, int *s_scroll)
 {
 	int i, j, x, y, box_x, box_y;
+	int height, width, menu_height;
 	int key = 0, button = 0, scroll = 0, choice = 0;
 	int first_item =  0, max_choice;
 	WINDOW *dialog, *menu;
 
+do_resize:
+	height = getmaxy(stdscr);
+	width = getmaxx(stdscr);
+	if (height < 15 || width < 65)
+		return -ERRDISPLAYTOOSMALL;
+
+	height -= 4;
+	width  -= 5;
+	menu_height = height - 10;
+
 	max_choice = MIN(menu_height, item_count());
 
 	/* center dialog box on screen */
@@ -226,7 +237,10 @@ int dialog_menu(const char *title, const
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 dlg.menubox_border.atr, dlg.menubox.atr);
 
-	item_x = (menu_width - 70) / 2;
+	if (menu_width >= 80)
+		item_x = (menu_width - 70) / 2;
+	else
+		item_x = 4;
 
 	/* Set choice to default item */
 	item_foreach()
@@ -407,6 +421,11 @@ int dialog_menu(const char *title, const
 		case KEY_ESC:
 			key = on_key_esc(menu);
 			break;
+		case KEY_RESIZE:
+			on_key_resize();
+			delwin(menu);
+			delwin(dialog);
+			goto do_resize;
 		}
 	}
 	delwin(menu);
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index a99e1f4..fabfc1a 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -25,7 +25,7 @@ static void back_lines(int n);
 static void print_page(WINDOW * win, int height, int width);
 static void print_line(WINDOW * win, int row, int width);
 static char *get_line(void);
-static void print_position(WINDOW * win, int height, int width);
+static void print_position(WINDOW * win);
 
 static int hscroll;
 static int begin_reached, end_reached, page_length;
@@ -33,14 +33,28 @@ static const char *buf;
 static const char *page;
 
 /*
+ * refresh window content
+ */
+static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, int boxw,
+							  int cur_y, int cur_x)
+{
+	print_page(box, boxh, boxw);
+	print_position(dialog);
+	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
+	wrefresh(dialog);
+}
+
+
+/*
  * Display text from a file in a dialog box.
  */
-int dialog_textbox(const char *title, const char *tbuf, int height, int width)
+int dialog_textbox(const char *title, const char *tbuf,
+		   int initial_height, int initial_width)
 {
 	int i, x, y, cur_x, cur_y, key = 0;
-	int texth, textw;
+	int height, width, boxh, boxw;
 	int passed_end;
-	WINDOW *dialog, *text;
+	WINDOW *dialog, *box;
 
 	begin_reached = 1;
 	end_reached = 0;
@@ -49,6 +63,25 @@ int dialog_textbox(const char *title, co
 	buf = tbuf;
 	page = buf;	/* page is pointer to start of page to be displayed */
 
+do_resize:
+	getmaxyx(stdscr, height, width);
+	if (height < 8 || width < 8)
+		return -ERRDISPLAYTOOSMALL;
+	if (initial_height != 0)
+		height = initial_height;
+	else
+		if (height > 4)
+			height -= 4;
+		else
+			height = 0;
+	if (initial_width != 0)
+		width = initial_width;
+	else
+		if (width > 5)
+			width -= 5;
+		else
+			width = 0;
+
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
 	y = (LINES - height) / 2;
@@ -58,14 +91,14 @@ int dialog_textbox(const char *title, co
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-	/* Create window for text region, used for scrolling text */
-	texth = height - 4;
-	textw = width - 2;
-	text = subwin(dialog, texth, textw, y + 1, x + 1);
-	wattrset(text, dlg.dialog.atr);
-	wbkgdset(text, dlg.dialog.atr & A_COLOR);
+	/* Create window for box region, used for scrolling text */
+	boxh = height - 4;
+	boxw = width - 2;
+	box = subwin(dialog, boxh, boxw, y + 1, x + 1);
+	wattrset(box, dlg.dialog.atr);
+	wbkgdset(box, dlg.dialog.atr & A_COLOR);
 
-	keypad(text, TRUE);
+	keypad(box, TRUE);
 
 	/* register the new window, along with its borders */
 	draw_box(dialog, 0, 0, height, width,
@@ -86,11 +119,8 @@ int dialog_textbox(const char *title, co
 	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
 
 	/* Print first page of text */
-	attr_clear(text, texth, textw, dlg.dialog.atr);
-	print_page(text, texth, textw);
-	print_position(dialog, height, width);
-	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
-	wrefresh(dialog);
+	attr_clear(box, boxh, boxw, dlg.dialog.atr);
+	refresh_text_box(dialog, box, boxh, boxw, cur_y, cur_x);
 
 	while ((key != KEY_ESC) && (key != '\n')) {
 		key = wgetch(dialog);
@@ -99,7 +129,7 @@ int dialog_textbox(const char *title, co
 		case 'e':
 		case 'X':
 		case 'x':
-			delwin(text);
+			delwin(box);
 			delwin(dialog);
 			return 0;
 		case 'g':	/* First page */
@@ -107,10 +137,8 @@ int dialog_textbox(const char *title, co
 			if (!begin_reached) {
 				begin_reached = 1;
 				page = buf;
-				print_page(text, texth, textw);
-				print_position(dialog, height, width);
-				wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
-				wrefresh(dialog);
+				refresh_text_box(dialog, box, boxh, boxw,
+						 cur_y, cur_x);
 			}
 			break;
 		case 'G':	/* Last page */
@@ -119,11 +147,9 @@ int dialog_textbox(const char *title, co
 			end_reached = 1;
 			/* point to last char in buf */
 			page = buf + strlen(buf);
-			back_lines(texth);
-			print_page(text, texth, textw);
-			print_position(dialog, height, width);
-			wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
-			wrefresh(dialog);
+			back_lines(boxh);
+			refresh_text_box(dialog, box, boxh, boxw,
+					 cur_y, cur_x);
 			break;
 		case 'K':	/* Previous line */
 		case 'k':
@@ -138,16 +164,16 @@ int dialog_textbox(const char *title, co
 				 * point to start of next page. This is done
 				 * by calling get_line() in the following
 				 * 'for' loop. */
-				scrollok(text, TRUE);
-				wscrl(text, -1);	/* Scroll text region down one line */
-				scrollok(text, FALSE);
+				scrollok(box, TRUE);
+				wscrl(box, -1);	/* Scroll box region down one line */
+				scrollok(box, FALSE);
 				page_length = 0;
 				passed_end = 0;
-				for (i = 0; i < texth; i++) {
+				for (i = 0; i < boxh; i++) {
 					if (!i) {
 						/* print first line of page */
-						print_line(text, 0, textw);
-						wnoutrefresh(text);
+						print_line(box, 0, boxw);
+						wnoutrefresh(box);
 					} else
 						/* Called to update 'end_reached' and 'page' */
 						get_line();
@@ -157,7 +183,7 @@ int dialog_textbox(const char *title, co
 						passed_end = 1;
 				}
 
-				print_position(dialog, height, width);
+				print_position(dialog);
 				wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 				wrefresh(dialog);
 			}
@@ -167,23 +193,21 @@ int dialog_textbox(const char *title, co
 		case KEY_PPAGE:
 			if (begin_reached)
 				break;
-			back_lines(page_length + texth);
-			print_page(text, texth, textw);
-			print_position(dialog, height, width);
-			wmove(dialog, cur_y, cur_x);
-			wrefresh(dialog);
+			back_lines(page_length + boxh);
+			refresh_text_box(dialog, box, boxh, boxw,
+					 cur_y, cur_x);
 			break;
 		case 'J':	/* Next line */
 		case 'j':
 		case KEY_DOWN:
 			if (!end_reached) {
 				begin_reached = 0;
-				scrollok(text, TRUE);
-				scroll(text);	/* Scroll text region up one line */
-				scrollok(text, FALSE);
-				print_line(text, texth - 1, textw);
-				wnoutrefresh(text);
-				print_position(dialog, height, width);
+				scrollok(box, TRUE);
+				scroll(box);	/* Scroll box region up one line */
+				scrollok(box, FALSE);
+				print_line(box, boxh - 1, boxw);
+				wnoutrefresh(box);
+				print_position(dialog);
 				wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 				wrefresh(dialog);
 			}
@@ -194,10 +218,8 @@ int dialog_textbox(const char *title, co
 				break;
 
 			begin_reached = 0;
-			print_page(text, texth, textw);
-			print_position(dialog, height, width);
-			wmove(dialog, cur_y, cur_x);
-			wrefresh(dialog);
+			refresh_text_box(dialog, box, boxh, boxw,
+					 cur_y, cur_x);
 			break;
 		case '0':	/* Beginning of line */
 		case 'H':	/* Scroll left */
@@ -212,9 +234,8 @@ int dialog_textbox(const char *title, co
 				hscroll--;
 			/* Reprint current page to scroll horizontally */
 			back_lines(page_length);
-			print_page(text, texth, textw);
-			wmove(dialog, cur_y, cur_x);
-			wrefresh(dialog);
+			refresh_text_box(dialog, box, boxh, boxw,
+					 cur_y, cur_x);
 			break;
 		case 'L':	/* Scroll right */
 		case 'l':
@@ -224,16 +245,21 @@ int dialog_textbox(const char *title, co
 			hscroll++;
 			/* Reprint current page to scroll horizontally */
 			back_lines(page_length);
-			print_page(text, texth, textw);
-			wmove(dialog, cur_y, cur_x);
-			wrefresh(dialog);
+			refresh_text_box(dialog, box, boxh, boxw,
+					 cur_y, cur_x);
 			break;
 		case KEY_ESC:
 			key = on_key_esc(dialog);
 			break;
+		case KEY_RESIZE:
+			back_lines(height);
+			delwin(box);
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
 		}
 	}
-	delwin(text);
+	delwin(box);
 	delwin(dialog);
 	return key;		/* ESC pressed */
 }
@@ -353,13 +379,13 @@ static char *get_line(void)
 /*
  * Print current position
  */
-static void print_position(WINDOW * win, int height, int width)
+static void print_position(WINDOW * win)
 {
 	int percent;
 
 	wattrset(win, dlg.position_indicator.atr);
 	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
 	percent = (page - buf) * 100 / strlen(buf);
-	wmove(win, height - 3, width - 9);
+	wmove(win, getmaxy(win) - 3, getmaxx(win) - 9);
 	wprintw(win, "(%3d%%)", percent);
 }
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index cb21dc4..ebc781b 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -509,6 +509,12 @@ int on_key_esc(WINDOW *win)
 	return -1;
 }
 
+/* redraw screen in new size */
+int on_key_resize(void)
+{
+	dialog_clear();
+	return KEY_RESIZE;
+}
 
 struct dialog_list *item_cur;
 struct dialog_list item_nil;
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index 8364f9d..ee0a04e 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -44,6 +44,12 @@ int dialog_yesno(const char *title, cons
 	int i, x, y, key = 0, button = 0;
 	WINDOW *dialog;
 
+do_resize:
+	if (getmaxy(stdscr) < (height + 4))
+		return -ERRDISPLAYTOOSMALL;
+	if (getmaxx(stdscr) < (width + 4))
+		return -ERRDISPLAYTOOSMALL;
+
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
 	y = (LINES - height) / 2;
@@ -96,6 +102,10 @@ int dialog_yesno(const char *title, cons
 		case KEY_ESC:
 			key = on_key_esc(dialog);
 			break;
+		case KEY_RESIZE:
+			delwin(dialog);
+			on_key_resize();
+			goto do_resize;
 		}
 	}
 
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index ef75d6c..f7abca4 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -606,9 +606,8 @@ static void conf(struct menu *menu)
 		reset_dialog();
 		res = dialog_menu(prompt ? prompt : _("Main Menu"),
 				  _(menu_instructions),
-				  rows, cols, rows - 10,
 				  active_menu, &s_scroll);
-		if (res == 1 || res == KEY_ESC)
+		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
 			break;
 		if (!item_activate_selected())
 			continue;
@@ -617,7 +616,10 @@ static void conf(struct menu *menu)
 
 		submenu = item_data();
 		active_menu = item_data();
-		sym = submenu->sym;
+		if (submenu)
+			sym = submenu->sym;
+		else
+			sym = NULL;
 
 		switch (res) {
 		case 0:
@@ -683,7 +685,7 @@ static void conf(struct menu *menu)
 static void show_textbox(const char *title, const char *text, int r, int c)
 {
 	reset_dialog();
-	dialog_textbox(title, text, r ? r : rows, c ? c : cols);
+	dialog_textbox(title, text, r, c);
 }
 
 static void show_helptext(const char *title, const char *text)
@@ -756,6 +758,8 @@ static void conf_choice(struct menu *men
 			break;
 		case KEY_ESC:
 			return;
+		case -ERRDISPLAYTOOSMALL:
+			return;
 		}
 	}
 }
-- 
1.4.1.rc2.gfc04

