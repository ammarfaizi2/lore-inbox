Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWG2Uxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWG2Uxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWG2Uxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:53:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:33720 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932235AbWG2Uxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:53:42 -0400
Date: Sat, 29 Jul 2006 22:53:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Message-ID: <20060729205329.GA13719@mars.ravnborg.org>
References: <20060727202726.GA3900@mars.ravnborg.org> <Pine.LNX.4.64.0607281348420.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607281348420.6761@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:09:03PM +0200, Roman Zippel wrote:
 
> > The double ESC ESC thing I dunno how to fix.
> 
> I think the easiest would be to just ignore the first ESC, it matches the 
> documented behaviour and e.g. mc has the same behaviour. The delay of the 
> single ESC makes it a bit annoying/confusing to use, so that sticking to 
> the double ESC is IMO safer.
> I played with it a little and below is an example, which implements this 
> behaviour for the menu window. 

It became a bit more complicated to support ESC-space resulting in
space. That makes sense since one press ESC - wonder what is going on
and then press space (for example).
It does not support ESC-left (or any other key that generate meta
chars).

	Sam

>From 0d9076ae65ffa0a1d7bbaf8cf0b16ac1eac63b6e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Fri, 28 Jul 2006 23:57:48 +0200
Subject: [PATCH] kconfig/lxdialog: let <ESC><ESC> behave as expected

<ESC><ESC> is used to step one back in the dialogs.
When lxdialog became built-in pressing <ESC> once would cause one step back
and pressing <ESC><ESC> would cause two steps back.
This patch - based on concept from Roman Zippel <zippel@linux-m68k.org> -
makes one <ESC> a noop and pressing <ESC><ESC> will cause one step backward.

In addition the final yes/no dialog now has the option to go back to the
the kernel configuration. So if you get too far out you can now go back
to configuring the kernel without saving and starting all over again.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/checklist.c |   10 ++++++----
 scripts/kconfig/lxdialog/dialog.h    |    4 +++-
 scripts/kconfig/lxdialog/inputbox.c  |   10 ++++++----
 scripts/kconfig/lxdialog/menubox.c   |   10 ++++++----
 scripts/kconfig/lxdialog/textbox.c   |    7 ++++---
 scripts/kconfig/lxdialog/util.c      |   33 +++++++++++++++++++++++++++++++++
 scripts/kconfig/lxdialog/yesno.c     |    7 ++++---
 scripts/kconfig/mconf.c              |   25 ++++++++++++++-----------
 8 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 2825110..39becb7 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -192,7 +192,7 @@ int dialog_checklist(const char *title, 
 	wnoutrefresh(list);
 	doupdate();
 
-	while (key != ESC) {
+	while (key != KEY_ESC) {
 		key = wgetch(dialog);
 
 		for (i = 0; i < max_choice; i++) {
@@ -298,8 +298,10 @@ int dialog_checklist(const char *title, 
 			break;
 		case 'X':
 		case 'x':
-			key = ESC;
-		case ESC:
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(dialog);
 			break;
 		}
 
@@ -308,5 +310,5 @@ int dialog_checklist(const char *title, 
 	}
 	delwin(list);
 	delwin(dialog);
-	return 255;		/* ESC pressed */
+	return key;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 065ded0..a7cfdec 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -48,7 +48,7 @@ #endif
 
 #define TR(params) _tracef params
 
-#define ESC 27
+#define KEY_ESC 27
 #define TAB 9
 #define MAX_LEN 2048
 #define BUF_SIZE (10*1024)
@@ -179,6 +179,8 @@ #define item_foreach() \
 	for (item_cur = item_head ? item_head: item_cur; \
 	     item_cur && (item_cur != &item_nil); item_cur = item_cur->next)
 
+/* generic key handlers */
+int on_key_esc(WINDOW *win);
 
 void init_dialog(const char *backtitle);
 void reset_dialog(void);
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 9c53098..edb7975 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -106,7 +106,7 @@ int dialog_inputbox(const char *title, c
 
 	wrefresh(dialog);
 
-	while (key != ESC) {
+	while (key != KEY_ESC) {
 		key = wgetch(dialog);
 
 		if (button == -1) {	/* Input box selected */
@@ -215,12 +215,14 @@ int dialog_inputbox(const char *title, c
 			return (button == -1 ? 0 : button);
 		case 'X':
 		case 'x':
-			key = ESC;
-		case ESC:
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(dialog);
 			break;
 		}
 	}
 
 	delwin(dialog);
-	return 255;		/* ESC pressed */
+	return KEY_ESC;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index f39ae29..d3305ba 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -263,7 +263,7 @@ int dialog_menu(const char *title, const
 	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
 
-	while (key != ESC) {
+	while (key != KEY_ESC) {
 		key = wgetch(menu);
 
 		if (key < 256 && isalpha(key))
@@ -402,12 +402,14 @@ int dialog_menu(const char *title, const
 			return button;
 		case 'e':
 		case 'x':
-			key = ESC;
-		case ESC:
+			key = KEY_ESC;
+			break;
+		case KEY_ESC:
+			key = on_key_esc(menu);
 			break;
 		}
 	}
 	delwin(menu);
 	delwin(dialog);
-	return 255;		/* ESC pressed */
+	return key;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 86b0770..a99e1f4 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -92,7 +92,7 @@ int dialog_textbox(const char *title, co
 	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 	wrefresh(dialog);
 
-	while ((key != ESC) && (key != '\n')) {
+	while ((key != KEY_ESC) && (key != '\n')) {
 		key = wgetch(dialog);
 		switch (key) {
 		case 'E':	/* Exit */
@@ -228,13 +228,14 @@ int dialog_textbox(const char *title, co
 			wmove(dialog, cur_y, cur_x);
 			wrefresh(dialog);
 			break;
-		case ESC:
+		case KEY_ESC:
+			key = on_key_esc(dialog);
 			break;
 		}
 	}
 	delwin(text);
 	delwin(dialog);
-	return 255;		/* ESC pressed */
+	return key;		/* ESC pressed */
 }
 
 /*
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 0b3118d..cb21dc4 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -477,6 +477,39 @@ int first_alpha(const char *string, cons
 	return 0;
 }
 
+/*
+ * ncurses uses ESC to detect escaped char sequences. This resutl in
+ * a small timeout before ESC is actually delivered to the application.
+ * lxdialog suggest <ESC> <ESC> which is correctly translated to two
+ * times esc. But then we need to ignore the second esc to avoid stepping
+ * out one menu too much. Filter away all escaped key sequences since
+ * keypad(FALSE) turn off ncurses support for escape sequences - and thats
+ * needed to make notimeout() do as expected.
+ */
+int on_key_esc(WINDOW *win)
+{
+	int key;
+	int key2;
+	int key3;
+
+	nodelay(win, TRUE);
+	keypad(win, FALSE);
+	key = wgetch(win);
+	key2 = wgetch(win);
+	do {
+		key3 = wgetch(win);
+	} while (key3 != ERR);
+	nodelay(win, FALSE);
+	keypad(win, TRUE);
+	if (key == KEY_ESC && key2 == ERR)
+		return KEY_ESC;
+	else if (key != ERR && key != KEY_ESC && key2 == ERR)
+		ungetch(key);
+
+	return -1;
+}
+
+
 struct dialog_list *item_cur;
 struct dialog_list item_nil;
 struct dialog_list *item_head;
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index 9fc2449..8364f9d 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -69,7 +69,7 @@ int dialog_yesno(const char *title, cons
 
 	print_buttons(dialog, height, width, 0);
 
-	while (key != ESC) {
+	while (key != KEY_ESC) {
 		key = wgetch(dialog);
 		switch (key) {
 		case 'Y':
@@ -93,11 +93,12 @@ int dialog_yesno(const char *title, cons
 		case '\n':
 			delwin(dialog);
 			return button;
-		case ESC:
+		case KEY_ESC:
+			key = on_key_esc(dialog);
 			break;
 		}
 	}
 
 	delwin(dialog);
-	return 255;		/* ESC pressed */
+	return key;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index b1ad9a0..ef75d6c 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -608,7 +608,7 @@ static void conf(struct menu *menu)
 				  _(menu_instructions),
 				  rows, cols, rows - 10,
 				  active_menu, &s_scroll);
-		if (res == 1 || res == 255)
+		if (res == 1 || res == KEY_ESC)
 			break;
 		if (!item_activate_selected())
 			continue;
@@ -754,7 +754,7 @@ static void conf_choice(struct menu *men
 			} else
 				show_help(menu);
 			break;
-		case 255:
+		case KEY_ESC:
 			return;
 		}
 	}
@@ -794,7 +794,7 @@ static void conf_string(struct menu *men
 		case 1:
 			show_help(menu);
 			break;
-		case 255:
+		case KEY_ESC:
 			return;
 		}
 	}
@@ -819,7 +819,7 @@ static void conf_load(void)
 		case 1:
 			show_helptext(_("Load Alternate Configuration"), load_config_help);
 			break;
-		case 255:
+		case KEY_ESC:
 			return;
 		}
 	}
@@ -843,7 +843,7 @@ static void conf_save(void)
 		case 1:
 			show_helptext(_("Save Alternate Configuration"), save_config_help);
 			break;
-		case 255:
+		case KEY_ESC:
 			return;
 		}
 	}
@@ -883,12 +883,15 @@ int main(int ac, char **av)
 	init_wsize();
 	reset_dialog();
 	init_dialog(menu_backtitle);
-	conf(&rootmenu);
-	reset_dialog();
-	res = dialog_yesno(NULL,
-			   _("Do you wish to save your "
-			     "new kernel configuration?"),
-			   5, 60);
+	do {
+		conf(&rootmenu);
+		reset_dialog();
+		res = dialog_yesno(NULL,
+				   _("Do you wish to save your "
+				     "new kernel configuration?\n"
+				     "<ESC><ESC> to continue."),
+				   6, 60);
+	} while (res == KEY_ESC);
 	end_dialog();
 	if (res == 0) {
 		if (conf_write(NULL)) {
-- 
1.4.1.rc2.gfc04

