Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWG0U2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWG0U2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWG0U2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:28:04 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:42162 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750723AbWG0U2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:28:00 -0400
Date: Thu, 27 Jul 2006 22:27:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Petr Baudis <pasky@suse.cz>
Subject: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Message-ID: <20060727202726.GA3900@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dedided to take another stamp on an old TODO item of making lxdialog
a built-in. Following patch is first step to do so.
The patch makes it a built-in - but with two open issues that I yet
have to address.

It is loosly based on a patch from Petr Baudis <pasky@suse.cz>:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.2/1978.html


The diffstat tells a nice story even if you ignore the three deleted
files. (lxdialog.c msgbox.c and lxdialog/Makefile).

I will not claim that the lxdialog files became readable by this but
they are now less unreadable compared to before.

Comments welcome of course.

I will during the weekend try to address the resize issue.
The double ESC ESC thing I dunno how to fix.

	Sam


>From 34a1fd9aa089e814e8ba3e0a99ac9bd10d220032 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Thu, 27 Jul 2006 22:10:27 +0200
Subject: [PATCH] kconfig/menuconfig: lxdialog is now built-in

lxdialog was previously called as an external program causing screen
to flicker when used. With this patch lxdialog is now built-in.
It is loosly based om previous work by:  Petr Baudis <pasky@ucw.cz>

Following is a list of changes:
o Moved build of dialog routings to kconfig Makefile
o menubox + checklist uses a new item list to hold all menu items
o in util.c implmented helper function to deal with item list
o menubox now uses parameters to save scroll state (avoids temp file)
o textbox now get text to be displayed as parameter and not a file
o make sure to properly delete subwin's before main windows
o killed unused files: lxdialog.c msgbox.c
o modified return value for ESC to match direct calling
o in a few places the code has been adjusted to 80 char wide
o in textbox a small refactoring was made to make code remotely readable
o in mconf removed all unused stuff (functions/variables)

Following is a list of know short comings:
a) pressing ESC twice will be interpreted as two ESC presses
b) resize does not work. menuconfig needs to be restarted to be adjusted

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/Makefile             |   23 +-
 scripts/kconfig/lxdialog/Makefile    |   21 -
 scripts/kconfig/lxdialog/checklist.c |  136 ++++------
 scripts/kconfig/lxdialog/dialog.h    |   50 +++-
 scripts/kconfig/lxdialog/inputbox.c  |    2 
 scripts/kconfig/lxdialog/lxdialog.c  |  204 --------------
 scripts/kconfig/lxdialog/menubox.c   |   95 +++----
 scripts/kconfig/lxdialog/msgbox.c    |   72 -----
 scripts/kconfig/lxdialog/textbox.c   |  298 +++++----------------
 scripts/kconfig/lxdialog/util.c      |  133 +++++++++
 scripts/kconfig/lxdialog/yesno.c     |    2 
 scripts/kconfig/mconf.c              |  480 ++++++++++------------------------
 12 files changed, 499 insertions(+), 1017 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index e6499db..6cf45fa 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -11,7 +11,6 @@ gconfig: $(obj)/gconf
 	$< arch/$(ARCH)/Kconfig
 
 menuconfig: $(obj)/mconf
-	$(Q)$(MAKE) $(build)=scripts/kconfig/lxdialog
 	$< arch/$(ARCH)/Kconfig
 
 config: $(obj)/conf
@@ -80,6 +79,23 @@ help:
 	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
 	@echo  '  allnoconfig	  - New config where all options are answered with no'
 
+# lxdialog stuff
+check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
+
+# Use reursively expanded variables so we do not call gcc unless
+# we really need to do so. (Do not call gcc as part of make mrproper)
+HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
+
+HOST_EXTRACFLAGS += -DLOCALE
+
+PHONY += $(obj)/dochecklxdialog
+$(obj)/dochecklxdialog:
+	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_LOADLIBES)
+
+always := dochecklxdialog
+
+
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
 # conf:	  Used for defconfig, oldconfig and related targets
@@ -91,9 +107,12 @@ # gconf:  Used for the gconfig target
 #         Based on GTK which needs to be installed to compile it
 # object files used by all kconfig flavours
 
+lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
+lxdialog += lxdialog/textbox.o lxdialog/yesno.o lxdialog/menubox.o
+
 hostprogs-y	:= conf mconf qconf gconf kxgettext
 conf-objs	:= conf.o  zconf.tab.o
-mconf-objs	:= mconf.o zconf.tab.o
+mconf-objs	:= mconf.o zconf.tab.o $(lxdialog)
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
 ifeq ($(MAKECMDGOALS),xconfig)
diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
deleted file mode 100644
index a8b0263..0000000
--- a/scripts/kconfig/lxdialog/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-# Makefile to build lxdialog package
-#
-
-check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
-
-# Use reursively expanded variables so we do not call gcc unless
-# we really need to do so. (Do not call gcc as part of make mrproper)
-HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
-HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
-
-HOST_EXTRACFLAGS += -DLOCALE
-
-PHONY += dochecklxdialog
-$(obj)/dochecklxdialog:
-	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_LOADLIBES)
-
-hostprogs-y	:= lxdialog
-always		:= $(hostprogs-y) dochecklxdialog
-
-lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
-		 util.o lxdialog.o msgbox.o
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index b90e888..2825110 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -28,8 +28,7 @@ static int list_width, check_x, item_x;
 /*
  * Print list item
  */
-static void print_item(WINDOW * win, const char *item, int status, int choice,
-		       int selected)
+static void print_item(WINDOW * win, int choice, int selected)
 {
 	int i;
 
@@ -42,12 +41,12 @@ static void print_item(WINDOW * win, con
 	wmove(win, choice, check_x);
 	wattrset(win, selected ? dlg.check_selected.atr
 		 : dlg.check.atr);
-	wprintw(win, "(%c)", status ? 'X' : ' ');
+	wprintw(win, "(%c)", item_is_tag('X') ? 'X' : ' ');
 
 	wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
-	mvwaddch(win, choice, item_x, item[0]);
+	mvwaddch(win, choice, item_x, item_str()[0]);
 	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
-	waddstr(win, (char *)item + 1);
+	waddstr(win, (char *)item_str() + 1);
 	if (selected) {
 		wmove(win, choice, check_x + 1);
 		wrefresh(win);
@@ -110,32 +109,23 @@ static void print_buttons(WINDOW * dialo
  * in the style of radiolist (only one option turned on at a time).
  */
 int dialog_checklist(const char *title, const char *prompt, int height,
-		     int width, int list_height, int item_no,
-		     const char *const *items)
+		     int width, int list_height)
 {
 	int i, x, y, box_x, box_y;
-	int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
+	int key = 0, button = 0, choice = 0, scroll = 0, max_choice;
 	WINDOW *dialog, *list;
 
-	/* Allocate space for storing item on/off status */
-	if ((status = malloc(sizeof(int) * item_no)) == NULL) {
-		endwin();
-		fprintf(stderr,
-			"\nCan't allocate memory in dialog_checklist().\n");
-		exit(-1);
-	}
-
-	/* Initializes status */
-	for (i = 0; i < item_no; i++) {
-		status[i] = !strcasecmp(items[i * 3 + 2], "on");
-		if ((!choice && status[i])
-		    || !strcasecmp(items[i * 3 + 2], "selected"))
-			choice = i + 1;
+	/* which item to highlight */
+	item_foreach() {
+		if (item_is_tag('X'))
+			choice = item_n();
+		if (item_is_selected()) {
+			choice = item_n();
+			break;
+		}
 	}
-	if (choice)
-		choice--;
 
-	max_choice = MIN(list_height, item_no);
+	max_choice = MIN(list_height, item_count());
 
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
@@ -176,8 +166,8 @@ int dialog_checklist(const char *title, 
 
 	/* Find length of longest item in order to center checklist */
 	check_x = 0;
-	for (i = 0; i < item_no; i++)
-		check_x = MAX(check_x, +strlen(items[i * 3 + 1]) + 4);
+	item_foreach()
+		check_x = MAX(check_x, strlen(item_str()) + 4);
 
 	check_x = (list_width - check_x) / 2;
 	item_x = check_x + 4;
@@ -189,14 +179,11 @@ int dialog_checklist(const char *title, 
 
 	/* Print the list */
 	for (i = 0; i < max_choice; i++) {
-		if (i != choice)
-			print_item(list, items[(scroll + i) * 3 + 1],
-				   status[i + scroll], i, 0);
+		item_set(scroll + i);
+		print_item(list, i, i == choice);
 	}
-	print_item(list, items[(scroll + choice) * 3 + 1],
-		   status[choice + scroll], choice, 1);
 
-	print_arrows(dialog, choice, item_no, scroll,
+	print_arrows(dialog, choice, item_count(), scroll,
 		     box_y, box_x + check_x + 5, list_height);
 
 	print_buttons(dialog, height, width, 0);
@@ -208,10 +195,11 @@ int dialog_checklist(const char *title, 
 	while (key != ESC) {
 		key = wgetch(dialog);
 
-		for (i = 0; i < max_choice; i++)
-			if (toupper(key) ==
-			    toupper(items[(scroll + i) * 3 + 1][0]))
+		for (i = 0; i < max_choice; i++) {
+			item_set(i + scroll);
+			if (toupper(key) == toupper(item_str()[0]))
 				break;
+		}
 
 		if (i < max_choice || key == KEY_UP || key == KEY_DOWN ||
 		    key == '+' || key == '-') {
@@ -222,15 +210,16 @@ int dialog_checklist(const char *title, 
 					/* Scroll list down */
 					if (list_height > 1) {
 						/* De-highlight current first item */
-						print_item(list, items[scroll * 3 + 1],
-							   status[scroll], 0, FALSE);
+						item_set(scroll);
+						print_item(list, 0, FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, -1);
 						scrollok(list, FALSE);
 					}
 					scroll--;
-					print_item(list, items[scroll * 3 + 1], status[scroll], 0, TRUE);
-					print_arrows(dialog, choice, item_no,
+					item_set(scroll);
+					print_item(list, 0, TRUE);
+					print_arrows(dialog, choice, item_count(),
 						     scroll, box_y, box_x + check_x + 5, list_height);
 
 					wnoutrefresh(dialog);
@@ -241,23 +230,24 @@ int dialog_checklist(const char *title, 
 					i = choice - 1;
 			} else if (key == KEY_DOWN || key == '+') {
 				if (choice == max_choice - 1) {
-					if (scroll + choice >= item_no - 1)
+					if (scroll + choice >= item_count() - 1)
 						continue;
 					/* Scroll list up */
 					if (list_height > 1) {
 						/* De-highlight current last item before scrolling up */
-						print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
-							   status[scroll + max_choice - 1],
-							   max_choice - 1, FALSE);
+						item_set(scroll + max_choice - 1);
+						print_item(list,
+							    max_choice - 1,
+							    FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, 1);
 						scrollok(list, FALSE);
 					}
 					scroll++;
-					print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
-						   status[scroll + max_choice - 1], max_choice - 1, TRUE);
+					item_set(scroll + max_choice - 1);
+					print_item(list, max_choice - 1, TRUE);
 
-					print_arrows(dialog, choice, item_no,
+					print_arrows(dialog, choice, item_count(),
 						     scroll, box_y, box_x + check_x + 5, list_height);
 
 					wnoutrefresh(dialog);
@@ -269,12 +259,12 @@ int dialog_checklist(const char *title, 
 			}
 			if (i != choice) {
 				/* De-highlight current item */
-				print_item(list, items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice, FALSE);
+				item_set(scroll + choice);
+				print_item(list, choice, FALSE);
 				/* Highlight new item */
 				choice = i;
-				print_item(list, items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice, TRUE);
+				item_set(scroll + choice);
+				print_item(list, choice, TRUE);
 				wnoutrefresh(dialog);
 				wrefresh(list);
 			}
@@ -284,10 +274,19 @@ int dialog_checklist(const char *title, 
 		case 'H':
 		case 'h':
 		case '?':
-			fprintf(stderr, "%s", items[(scroll + choice) * 3]);
+			button = 1;
+			/* fall-through */
+		case 'S':
+		case 's':
+		case ' ':
+		case '\n':
+			item_foreach()
+				item_set_selected(0);
+			item_set(scroll + choice);
+			item_set_selected(1);
+			delwin(list);
 			delwin(dialog);
-			free(status);
-			return 1;
+			return button;
 		case TAB:
 		case KEY_LEFT:
 		case KEY_RIGHT:
@@ -297,30 +296,6 @@ int dialog_checklist(const char *title, 
 			print_buttons(dialog, height, width, button);
 			wrefresh(dialog);
 			break;
-		case 'S':
-		case 's':
-		case ' ':
-		case '\n':
-			if (!button) {
-				if (!status[scroll + choice]) {
-					for (i = 0; i < item_no; i++)
-						status[i] = 0;
-					status[scroll + choice] = 1;
-					for (i = 0; i < max_choice; i++)
-						print_item(list, items[(scroll + i) * 3 + 1],
-							   status[scroll + i], i, i == choice);
-				}
-				wnoutrefresh(dialog);
-				wrefresh(list);
-
-				for (i = 0; i < item_no; i++)
-					if (status[i])
-						fprintf(stderr, "%s", items[i * 3]);
-			} else
-				fprintf(stderr, "%s", items[(scroll + choice) * 3]);
-			delwin(dialog);
-			free(status);
-			return button;
 		case 'X':
 		case 'x':
 			key = ESC;
@@ -331,8 +306,7 @@ int dialog_checklist(const char *title, 
 		/* Now, update everything... */
 		doupdate();
 	}
-
+	delwin(list);
 	delwin(dialog);
-	free(status);
-	return -1;		/* ESC pressed */
+	return 255;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 2f4c19d..dd25ca7 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -133,11 +133,53 @@ struct dialog_info {
  * Global variables
  */
 extern struct dialog_info dlg;
+extern char dialog_input_result[];
 
 /*
  * Function prototypes
  */
-void init_dialog(void);
+
+/* item list as used by checklist and menubox */
+void item_reset(void);
+void item_make(const char *fmt, ...);
+void item_add_str(const char *fmt, ...);
+void item_set_tag(char tag);
+void item_set_data(void *p);
+void item_set_selected(int val);
+int item_activate_selected(void);
+void *item_data(void);
+char item_tag(void);
+
+/* item list manipulation for lxdialog use */
+#define MAXITEMSTR 200
+struct dialog_item {
+	char str[MAXITEMSTR];	/* promtp displayed */
+	char tag;
+	void *data;	/* pointer to menu item - used by menubox+checklist */
+	int selected;	/* Set to 1 by dialog_*() function if selected. */
+};
+
+/* list of lialog_items */
+struct dialog_list {
+	struct dialog_item node;
+	struct dialog_list *next;
+};
+
+extern struct dialog_list *item_cur;
+extern struct dialog_list *item_head;
+
+int item_count(void);
+void item_set(int n);
+int item_n(void);
+const char *item_str(void);
+int item_is_selected(void);
+int item_is_tag(char tag);
+#define item_foreach() \
+	for (item_cur = item_head; item_cur; item_cur = item_cur->next)
+
+
+void init_dialog(const char *backtitle);
+void reset_dialog(void);
 void end_dialog(void);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
@@ -154,11 +196,9 @@ int dialog_msgbox(const char *title, con
 		  int width, int pause);
 int dialog_textbox(const char *title, const char *file, int height, int width);
 int dialog_menu(const char *title, const char *prompt, int height, int width,
-		int menu_height, const char *choice, int item_no,
-		const char *const *items);
+		int menu_height, const void *selected, int *s_scroll);
 int dialog_checklist(const char *title, const char *prompt, int height,
-		     int width, int list_height, int item_no,
-		     const char *const *items);
+		     int width, int list_height);
 extern char dialog_input_result[];
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index f75b51f..9c53098 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -222,5 +222,5 @@ int dialog_inputbox(const char *title, c
 	}
 
 	delwin(dialog);
-	return -1;		/* ESC pressed */
+	return 255;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/lxdialog.c b/scripts/kconfig/lxdialog/lxdialog.c
deleted file mode 100644
index c264e02..0000000
--- a/scripts/kconfig/lxdialog/lxdialog.c
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- *  dialog - Display simple dialog boxes from shell scripts
- *
- *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
- *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
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
-#include "dialog.h"
-
-static void Usage(const char *name);
-
-typedef int (jumperFn) (const char *title, int argc, const char *const *argv);
-
-struct Mode {
-	char *name;
-	int argmin, argmax, argmod;
-	jumperFn *jumper;
-};
-
-jumperFn j_menu, j_radiolist, j_yesno, j_textbox, j_inputbox;
-jumperFn j_msgbox, j_infobox;
-
-static struct Mode modes[] = {
-	{"--menu", 9, 0, 3, j_menu},
-	{"--radiolist", 9, 0, 3, j_radiolist},
-	{"--yesno", 5, 5, 1, j_yesno},
-	{"--textbox", 5, 5, 1, j_textbox},
-	{"--inputbox", 5, 6, 1, j_inputbox},
-	{"--msgbox", 5, 5, 1, j_msgbox},
-	{"--infobox", 5, 5, 1, j_infobox},
-	{NULL, 0, 0, 0, NULL}
-};
-
-static struct Mode *modePtr;
-
-#ifdef LOCALE
-#include <locale.h>
-#endif
-
-int main(int argc, const char *const *argv)
-{
-	int offset = 0, opt_clear = 0, end_common_opts = 0, retval;
-	const char *title = NULL;
-
-#ifdef LOCALE
-	(void)setlocale(LC_ALL, "");
-#endif
-
-#ifdef TRACE
-	trace(TRACE_CALLS | TRACE_UPDATE);
-#endif
-	if (argc < 2) {
-		Usage(argv[0]);
-		exit(-1);
-	}
-
-	while (offset < argc - 1 && !end_common_opts) {	/* Common options */
-		if (!strcmp(argv[offset + 1], "--title")) {
-			if (argc - offset < 3 || title != NULL) {
-				Usage(argv[0]);
-				exit(-1);
-			} else {
-				title = argv[offset + 2];
-				offset += 2;
-			}
-		} else if (!strcmp(argv[offset + 1], "--backtitle")) {
-			if (dlg.backtitle != NULL) {
-				Usage(argv[0]);
-				exit(-1);
-			} else {
-				dlg.backtitle = argv[offset + 2];
-				offset += 2;
-			}
-		} else if (!strcmp(argv[offset + 1], "--clear")) {
-			if (opt_clear) {	/* Hey, "--clear" can't appear twice! */
-				Usage(argv[0]);
-				exit(-1);
-			} else if (argc == 2) {	/* we only want to clear the screen */
-				init_dialog();
-				refresh();	/* init_dialog() will clear the screen for us */
-				end_dialog();
-				return 0;
-			} else {
-				opt_clear = 1;
-				offset++;
-			}
-		} else		/* no more common options */
-			end_common_opts = 1;
-	}
-
-	if (argc - 1 == offset) {	/* no more options */
-		Usage(argv[0]);
-		exit(-1);
-	}
-	/* use a table to look for the requested mode, to avoid code duplication */
-
-	for (modePtr = modes; modePtr->name; modePtr++)	/* look for the mode */
-		if (!strcmp(argv[offset + 1], modePtr->name))
-			break;
-
-	if (!modePtr->name)
-		Usage(argv[0]);
-	if (argc - offset < modePtr->argmin)
-		Usage(argv[0]);
-	if (modePtr->argmax && argc - offset > modePtr->argmax)
-		Usage(argv[0]);
-
-	init_dialog();
-	retval = (*(modePtr->jumper)) (title, argc - offset, argv + offset);
-
-	if (opt_clear) {	/* clear screen before exit */
-		attr_clear(stdscr, LINES, COLS, dlg.screen.atr);
-		refresh();
-	}
-	end_dialog();
-
-	exit(retval);
-}
-
-/*
- * Print program usage
- */
-static void Usage(const char *name)
-{
-	fprintf(stderr, "\
-\ndialog, by Savio Lam (lam836@cs.cuhk.hk).\
-\n  patched by Stuart Herbert (S.Herbert@shef.ac.uk)\
-\n  modified/gutted for use as a Linux kernel config tool by \
-\n  William Roadcap (roadcapw@cfw.com)\
-\n\
-\n* Display dialog boxes from shell scripts *\
-\n\
-\nUsage: %s --clear\
-\n       %s [--title <title>] [--backtitle <backtitle>] --clear <Box options>\
-\n\
-\nBox options:\
-\n\
-\n  --menu      <text> <height> <width> <menu height> <tag1> <item1>...\
-\n  --radiolist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
-\n  --textbox   <file> <height> <width>\
-\n  --inputbox  <text> <height> <width> [<init>]\
-\n  --yesno     <text> <height> <width>\
-\n", name, name);
-	exit(-1);
-}
-
-/*
- * These are the program jumpers
- */
-
-int j_menu(const char *t, int ac, const char *const *av)
-{
-	return dialog_menu(t, av[2], atoi(av[3]), atoi(av[4]),
-			   atoi(av[5]), av[6], (ac - 6) / 2, av + 7);
-}
-
-int j_radiolist(const char *t, int ac, const char *const *av)
-{
-	return dialog_checklist(t, av[2], atoi(av[3]), atoi(av[4]),
-				atoi(av[5]), (ac - 6) / 3, av + 6);
-}
-
-int j_textbox(const char *t, int ac, const char *const *av)
-{
-	return dialog_textbox(t, av[2], atoi(av[3]), atoi(av[4]));
-}
-
-int j_yesno(const char *t, int ac, const char *const *av)
-{
-	return dialog_yesno(t, av[2], atoi(av[3]), atoi(av[4]));
-}
-
-int j_inputbox(const char *t, int ac, const char *const *av)
-{
-	int ret = dialog_inputbox(t, av[2], atoi(av[3]), atoi(av[4]),
-				  ac == 6 ? av[5] : (char *)NULL);
-	if (ret == 0)
-		fprintf(stderr, dialog_input_result);
-	return ret;
-}
-
-int j_msgbox(const char *t, int ac, const char *const *av)
-{
-	return dialog_msgbox(t, av[2], atoi(av[3]), atoi(av[4]), 1);
-}
-
-int j_infobox(const char *t, int ac, const char *const *av)
-{
-	return dialog_msgbox(t, av[2], atoi(av[3]), atoi(av[4]), 0);
-}
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index ff991db..f39ae29 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -99,10 +99,10 @@ #endif
 	wrefresh(win);
 }
 
-#define print_item(index, choice, selected) \
-do {\
-	int hotkey = (items[(index) * 2][0] != ':'); \
-	do_print_item(menu, items[(index) * 2 + 1], choice, selected, hotkey); \
+#define print_item(index, choice, selected)				\
+do {									\
+	item_set(index);						\
+	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
 } while (0)
 
 /*
@@ -180,16 +180,14 @@ static void do_scroll(WINDOW *win, int *
  * Display a menu for choosing among a number of options
  */
 int dialog_menu(const char *title, const char *prompt, int height, int width,
-                int menu_height, const char *current, int item_no,
-                const char *const *items)
+                int menu_height, const void *selected, int *s_scroll)
 {
 	int i, j, x, y, box_x, box_y;
 	int key = 0, button = 0, scroll = 0, choice = 0;
 	int first_item =  0, max_choice;
 	WINDOW *dialog, *menu;
-	FILE *f;
 
-	max_choice = MIN(menu_height, item_no);
+	max_choice = MIN(menu_height, item_count());
 
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
@@ -231,28 +229,21 @@ int dialog_menu(const char *title, const
 	item_x = (menu_width - 70) / 2;
 
 	/* Set choice to default item */
-	for (i = 0; i < item_no; i++)
-		if (strcmp(current, items[i * 2]) == 0)
-			choice = i;
-
-	/* get the scroll info from the temp file */
-	if ((f = fopen("lxdialog.scrltmp", "r")) != NULL) {
-		if ((fscanf(f, "%d\n", &scroll) == 1) && (scroll <= choice) &&
-		    (scroll + max_choice > choice) && (scroll >= 0) &&
-		    (scroll + max_choice <= item_no)) {
-			first_item = scroll;
-			choice = choice - scroll;
-			fclose(f);
-		} else {
-			scroll = 0;
-			remove("lxdialog.scrltmp");
-			fclose(f);
-			f = NULL;
-		}
+	item_foreach()
+		if (selected && (selected == item_data()))
+			choice = item_n();
+	/* get the saved scroll info */
+	scroll = *s_scroll;
+	if ((scroll <= choice) && (scroll + max_choice > choice) &&
+	   (scroll >= 0) && (scroll + max_choice <= item_count())) {
+		first_item = scroll;
+		choice = choice - scroll;
+	} else {
+		scroll = 0;
 	}
-	if ((choice >= max_choice) || (f == NULL && choice >= max_choice / 2)) {
-		if (choice >= item_no - max_choice / 2)
-			scroll = first_item = item_no - max_choice;
+	if ((choice >= max_choice)) {
+		if (choice >= item_count() - max_choice / 2)
+			scroll = first_item = item_count() - max_choice;
 		else
 			scroll = first_item = choice - max_choice / 2;
 		choice = choice - scroll;
@@ -265,7 +256,7 @@ int dialog_menu(const char *title, const
 
 	wnoutrefresh(menu);
 
-	print_arrows(dialog, item_no, scroll,
+	print_arrows(dialog, item_count(), scroll,
 		     box_y, box_x + item_x + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
@@ -282,14 +273,16 @@ int dialog_menu(const char *title, const
 			i = max_choice;
 		else {
 			for (i = choice + 1; i < max_choice; i++) {
-				j = first_alpha(items[(scroll + i) * 2 + 1], "YyNnMmHh");
-				if (key == tolower(items[(scroll + i) * 2 + 1][j]))
+				item_set(scroll + i);
+				j = first_alpha(item_str(), "YyNnMmHh");
+				if (key == tolower(item_str()[j]))
 					break;
 			}
 			if (i == max_choice)
 				for (i = 0; i < max_choice; i++) {
-					j = first_alpha(items [(scroll + i) * 2 + 1], "YyNnMmHh");
-					if (key == tolower(items[(scroll + i) * 2 + 1][j]))
+					item_set(scroll + i);
+					j = first_alpha(item_str(), "YyNnMmHh");
+					if (key == tolower(item_str()[j]))
 						break;
 				}
 		}
@@ -314,7 +307,7 @@ int dialog_menu(const char *title, const
 				print_item(scroll+choice, choice, FALSE);
 
 				if ((choice > max_choice - 3) &&
-				    (scroll + max_choice < item_no)) {
+				    (scroll + max_choice < item_count())) {
 					/* Scroll menu up */
 					do_scroll(menu, &scroll, 1);
 
@@ -337,7 +330,7 @@ int dialog_menu(const char *title, const
 
 			} else if (key == KEY_NPAGE) {
 				for (i = 0; (i < max_choice); i++) {
-					if (scroll + max_choice < item_no) {
+					if (scroll + max_choice < item_count()) {
 						do_scroll(menu, &scroll, 1);
 						print_item(scroll+max_choice-1,
 							   max_choice - 1, FALSE);
@@ -351,7 +344,7 @@ int dialog_menu(const char *title, const
 
 			print_item(scroll + choice, choice, TRUE);
 
-			print_arrows(dialog, item_no, scroll,
+			print_arrows(dialog, item_count(), scroll,
 				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
@@ -377,12 +370,11 @@ int dialog_menu(const char *title, const
 		case 'm':
 		case '/':
 			/* save scroll info */
-			if ((f = fopen("lxdialog.scrltmp", "w")) != NULL) {
-				fprintf(f, "%d\n", scroll);
-				fclose(f);
-			}
+			*s_scroll = scroll;
+			delwin(menu);
 			delwin(dialog);
-			fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+			item_set(scroll + choice);
+			item_set_selected(1);
 			switch (key) {
 			case 's':
 				return 3;
@@ -402,17 +394,11 @@ int dialog_menu(const char *title, const
 		case '?':
 			button = 2;
 		case '\n':
+			*s_scroll = scroll;
+			delwin(menu);
 			delwin(dialog);
-			if (button == 2)
-				fprintf(stderr, "%s \"%s\"\n",
-					items[(scroll + choice) * 2],
-					items[(scroll + choice) * 2 + 1] +
-					first_alpha(items [(scroll + choice) * 2 + 1], ""));
-			else
-				fprintf(stderr, "%s\n",
-					items[(scroll + choice) * 2]);
-
-			remove("lxdialog.scrltmp");
+			item_set(scroll + choice);
+			item_set_selected(1);
 			return button;
 		case 'e':
 		case 'x':
@@ -421,8 +407,7 @@ int dialog_menu(const char *title, const
 			break;
 		}
 	}
-
+	delwin(menu);
 	delwin(dialog);
-	remove("lxdialog.scrltmp");
-	return -1;		/* ESC pressed */
+	return 255;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/msgbox.c b/scripts/kconfig/lxdialog/msgbox.c
deleted file mode 100644
index 236759f..0000000
--- a/scripts/kconfig/lxdialog/msgbox.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- *  msgbox.c -- implements the message box and info box
- *
- *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
- *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcapw@cfw.com)
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
-#include "dialog.h"
-
-/*
- * Display a message box. Program will pause and display an "OK" button
- * if the parameter 'pause' is non-zero.
- */
-int dialog_msgbox(const char *title, const char *prompt, int height, int width,
-                  int pause)
-{
-	int i, x, y, key = 0;
-	WINDOW *dialog;
-
-	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
-
-	draw_shadow(stdscr, y, x, height, width);
-
-	dialog = newwin(height, width, y, x);
-	keypad(dialog, TRUE);
-
-	draw_box(dialog, 0, 0, height, width,
-		 dlg.dialog.atr, dlg.border.atr);
-
-	print_title(dialog, title, width);
-
-	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 2);
-
-	if (pause) {
-		wattrset(dialog, dlg.border.atr);
-		mvwaddch(dialog, height - 3, 0, ACS_LTEE);
-		for (i = 0; i < width - 2; i++)
-			waddch(dialog, ACS_HLINE);
-		wattrset(dialog, dlg.dialog.atr);
-		waddch(dialog, ACS_RTEE);
-
-		print_button(dialog, "  Ok  ", height - 2, width / 2 - 4, TRUE);
-
-		wrefresh(dialog);
-		while (key != ESC && key != '\n' && key != ' ' &&
-		       key != 'O' && key != 'o' && key != 'X' && key != 'x')
-			key = wgetch(dialog);
-	} else {
-		key = '\n';
-		wrefresh(dialog);
-	}
-
-	delwin(dialog);
-	return key == ESC ? -1 : 0;
-}
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 336793b..b28f8aa 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -27,54 +27,27 @@ static void print_line(WINDOW * win, int
 static char *get_line(void);
 static void print_position(WINDOW * win, int height, int width);
 
-static int hscroll, fd, file_size, bytes_read;
-static int begin_reached = 1, end_reached, page_length;
-static char *buf, *page;
+static int hscroll;
+static int begin_reached, end_reached, page_length;
+static const char *buf;
+static const char *page;
 
 /*
  * Display text from a file in a dialog box.
  */
-int dialog_textbox(const char *title, const char *file, int height, int width)
+int dialog_textbox(const char *title, const char *tbuf, int height, int width)
 {
-	int i, x, y, cur_x, cur_y, fpos, key = 0;
+	int i, x, y, cur_x, cur_y, key = 0;
+	int texth, textw;
 	int passed_end;
-	char search_term[MAX_LEN + 1];
 	WINDOW *dialog, *text;
 
-	search_term[0] = '\0';	/* no search term entered yet */
-
-	/* Open input file for reading */
-	if ((fd = open(file, O_RDONLY)) == -1) {
-		endwin();
-		fprintf(stderr, "\nCan't open input file in dialog_textbox().\n");
-		exit(-1);
-	}
-	/* Get file size. Actually, 'file_size' is the real file size - 1,
-	   since it's only the last byte offset from the beginning */
-	if ((file_size = lseek(fd, 0, SEEK_END)) == -1) {
-		endwin();
-		fprintf(stderr, "\nError getting file size in dialog_textbox().\n");
-		exit(-1);
-	}
-	/* Restore file pointer to beginning of file after getting file size */
-	if (lseek(fd, 0, SEEK_SET) == -1) {
-		endwin();
-		fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
-		exit(-1);
-	}
-	/* Allocate space for read buffer */
-	if ((buf = malloc(BUF_SIZE + 1)) == NULL) {
-		endwin();
-		fprintf(stderr, "\nCan't allocate memory in dialog_textbox().\n");
-		exit(-1);
-	}
-	if ((bytes_read = read(fd, buf, BUF_SIZE)) == -1) {
-		endwin();
-		fprintf(stderr, "\nError reading file in dialog_textbox().\n");
-		exit(-1);
-	}
-	buf[bytes_read] = '\0';	/* mark end of valid data */
-	page = buf;		/* page is pointer to start of page to be displayed */
+	begin_reached = 1;
+	end_reached = 0;
+	page_length = 0;
+	hscroll = 0;
+	buf = tbuf;
+	page = buf;	/* page is pointer to start of page to be displayed */
 
 	/* center dialog box on screen */
 	x = (COLS - width) / 2;
@@ -86,7 +59,9 @@ int dialog_textbox(const char *title, co
 	keypad(dialog, TRUE);
 
 	/* Create window for text region, used for scrolling text */
-	text = subwin(dialog, height - 4, width - 2, y + 1, x + 1);
+	texth = height - 4;
+	textw = width - 2;
+	text = subwin(dialog, texth, textw, y + 1, x + 1);
 	wattrset(text, dlg.dialog.atr);
 	wbkgdset(text, dlg.dialog.atr & A_COLOR);
 
@@ -111,8 +86,8 @@ int dialog_textbox(const char *title, co
 	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
 
 	/* Print first page of text */
-	attr_clear(text, height - 4, width - 2, dlg.dialog.atr);
-	print_page(text, height - 4, width - 2);
+	attr_clear(text, texth, textw, dlg.dialog.atr);
+	print_page(text, texth, textw);
 	print_position(dialog, height, width);
 	wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 	wrefresh(dialog);
@@ -124,37 +99,15 @@ int dialog_textbox(const char *title, co
 		case 'e':
 		case 'X':
 		case 'x':
+			delwin(text);
 			delwin(dialog);
-			free(buf);
-			close(fd);
 			return 0;
 		case 'g':	/* First page */
 		case KEY_HOME:
 			if (!begin_reached) {
 				begin_reached = 1;
-				/* First page not in buffer? */
-				if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-					endwin();
-					fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
-					exit(-1);
-				}
-				if (fpos > bytes_read) {	/* Yes, we have to read it in */
-					if (lseek(fd, 0, SEEK_SET) == -1) {
-						endwin();
-						fprintf(stderr, "\nError moving file pointer in "
-							        "dialog_textbox().\n");
-						exit(-1);
-					}
-					if ((bytes_read =
-					     read(fd, buf, BUF_SIZE)) == -1) {
-						endwin();
-						fprintf(stderr, "\nError reading file in dialog_textbox().\n");
-						exit(-1);
-					}
-					buf[bytes_read] = '\0';
-				}
 				page = buf;
-				print_page(text, height - 4, width - 2);
+				print_page(text, texth, textw);
 				print_position(dialog, height, width);
 				wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 				wrefresh(dialog);
@@ -164,29 +117,10 @@ int dialog_textbox(const char *title, co
 		case KEY_END:
 
 			end_reached = 1;
-			/* Last page not in buffer? */
-			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-				endwin();
-				fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
-				exit(-1);
-			}
-			if (fpos < file_size) {	/* Yes, we have to read it in */
-				if (lseek(fd, -BUF_SIZE, SEEK_END) == -1) {
-					endwin();
-					fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
-					exit(-1);
-				}
-				if ((bytes_read =
-				     read(fd, buf, BUF_SIZE)) == -1) {
-					endwin();
-					fprintf(stderr, "\nError reading file in dialog_textbox().\n");
-					exit(-1);
-				}
-				buf[bytes_read] = '\0';
-			}
-			page = buf + bytes_read;
-			back_lines(height - 4);
-			print_page(text, height - 4, width - 2);
+			/* point to last char in buf */
+			page = buf + strlen(buf);
+			back_lines(texth);
+			print_page(text, texth, textw);
 			print_position(dialog, height, width);
 			wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
 			wrefresh(dialog);
@@ -197,20 +131,22 @@ int dialog_textbox(const char *title, co
 			if (!begin_reached) {
 				back_lines(page_length + 1);
 
-				/* We don't call print_page() here but use scrolling to ensure
-				   faster screen update. However, 'end_reached' and
-				   'page_length' should still be updated, and 'page' should
-				   point to start of next page. This is done by calling
-				   get_line() in the following 'for' loop. */
+				/* We don't call print_page() here but use 
+				 * scrolling to ensure faster screen update.
+				 * However, 'end_reached' and 'page_length'
+				 * should still be updated, and 'page' should
+				 * point to start of next page. This is done
+				 * by calling get_line() in the following
+				 * 'for' loop. */
 				scrollok(text, TRUE);
 				wscrl(text, -1);	/* Scroll text region down one line */
 				scrollok(text, FALSE);
 				page_length = 0;
 				passed_end = 0;
-				for (i = 0; i < height - 4; i++) {
+				for (i = 0; i < texth; i++) {
 					if (!i) {
 						/* print first line of page */
-						print_line(text, 0, width - 2);
+						print_line(text, 0, textw);
 						wnoutrefresh(text);
 					} else
 						/* Called to update 'end_reached' and 'page' */
@@ -231,8 +167,8 @@ int dialog_textbox(const char *title, co
 		case KEY_PPAGE:
 			if (begin_reached)
 				break;
-			back_lines(page_length + height - 4);
-			print_page(text, height - 4, width - 2);
+			back_lines(page_length + texth);
+			print_page(text, texth, textw);
 			print_position(dialog, height, width);
 			wmove(dialog, cur_y, cur_x);
 			wrefresh(dialog);
@@ -245,7 +181,7 @@ int dialog_textbox(const char *title, co
 				scrollok(text, TRUE);
 				scroll(text);	/* Scroll text region up one line */
 				scrollok(text, FALSE);
-				print_line(text, height - 5, width - 2);
+				print_line(text, texth - 1, textw);
 				wnoutrefresh(text);
 				print_position(dialog, height, width);
 				wmove(dialog, cur_y, cur_x);	/* Restore cursor position */
@@ -258,7 +194,7 @@ int dialog_textbox(const char *title, co
 				break;
 
 			begin_reached = 0;
-			print_page(text, height - 4, width - 2);
+			print_page(text, texth, textw);
 			print_position(dialog, height, width);
 			wmove(dialog, cur_y, cur_x);
 			wrefresh(dialog);
@@ -276,7 +212,7 @@ int dialog_textbox(const char *title, co
 				hscroll--;
 			/* Reprint current page to scroll horizontally */
 			back_lines(page_length);
-			print_page(text, height - 4, width - 2);
+			print_page(text, texth, textw);
 			wmove(dialog, cur_y, cur_x);
 			wrefresh(dialog);
 			break;
@@ -288,7 +224,7 @@ int dialog_textbox(const char *title, co
 			hscroll++;
 			/* Reprint current page to scroll horizontally */
 			back_lines(page_length);
-			print_page(text, height - 4, width - 2);
+			print_page(text, texth, textw);
 			wmove(dialog, cur_y, cur_x);
 			wrefresh(dialog);
 			break;
@@ -296,123 +232,42 @@ int dialog_textbox(const char *title, co
 			break;
 		}
 	}
-
+	delwin(text);
 	delwin(dialog);
-	free(buf);
-	close(fd);
-	return -1;		/* ESC pressed */
+	return 255;		/* ESC pressed */
 }
 
 /*
- * Go back 'n' lines in text file. Called by dialog_textbox().
+ * Go back 'n' lines in text. Called by dialog_textbox().
  * 'page' will be updated to point to the desired line in 'buf'.
  */
 static void back_lines(int n)
 {
-	int i, fpos;
+	int i;
 
 	begin_reached = 0;
-	/* We have to distinguish between end_reached and !end_reached
-	   since at end of file, the line is not ended by a '\n'.
-	   The code inside 'if' basically does a '--page' to move one
-	   character backward so as to skip '\n' of the previous line */
-	if (!end_reached) {
-		/* Either beginning of buffer or beginning of file reached? */
-		if (page == buf) {
-			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-				endwin();
-				fprintf(stderr, "\nError moving file pointer in "
-					        "back_lines().\n");
-				exit(-1);
-			}
-			if (fpos > bytes_read) {	/* Not beginning of file yet */
-				/* We've reached beginning of buffer, but not beginning of
-				   file yet, so read previous part of file into buffer.
-				   Note that we only move backward for BUF_SIZE/2 bytes,
-				   but not BUF_SIZE bytes to avoid re-reading again in
-				   print_page() later */
-				/* Really possible to move backward BUF_SIZE/2 bytes? */
-				if (fpos < BUF_SIZE / 2 + bytes_read) {
-					/* No, move less then */
-					if (lseek(fd, 0, SEEK_SET) == -1) {
-						endwin();
-						fprintf(stderr, "\nError moving file pointer in "
-						                "back_lines().\n");
-						exit(-1);
-					}
-					page = buf + fpos - bytes_read;
-				} else {	/* Move backward BUF_SIZE/2 bytes */
-					if (lseek (fd, -(BUF_SIZE / 2 + bytes_read), SEEK_CUR) == -1) {
-						endwin();
-						fprintf(stderr, "\nError moving file pointer "
-						                "in back_lines().\n");
-						exit(-1);
-					}
-					page = buf + BUF_SIZE / 2;
-				}
-				if ((bytes_read =
-				     read(fd, buf, BUF_SIZE)) == -1) {
-					endwin();
-					fprintf(stderr, "\nError reading file in back_lines().\n");
-					exit(-1);
-				}
-				buf[bytes_read] = '\0';
-			} else {	/* Beginning of file reached */
-				begin_reached = 1;
-				return;
+	/* Go back 'n' lines */
+	for (i = 0; i < n; i++) {
+		if (*page == '\0') {
+			if (end_reached) {
+				end_reached = 0;
+				continue;
 			}
 		}
-		if (*(--page) != '\n') {	/* '--page' here */
-			/* Something's wrong... */
-			endwin();
-			fprintf(stderr, "\nInternal error in back_lines().\n");
-			exit(-1);
+		if (page == buf) {
+			begin_reached = 1;
+			return;
 		}
-	}
-	/* Go back 'n' lines */
-	for (i = 0; i < n; i++)
+		page--;
 		do {
 			if (page == buf) {
-				if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-					endwin();
-					fprintf(stderr, "\nError moving file pointer in back_lines().\n");
-					exit(-1);
-				}
-				if (fpos > bytes_read) {
-					/* Really possible to move backward BUF_SIZE/2 bytes? */
-					if (fpos < BUF_SIZE / 2 + bytes_read) {
-						/* No, move less then */
-						if (lseek(fd, 0, SEEK_SET) == -1) {
-							endwin();
-							fprintf(stderr, "\nError moving file pointer "
-							                "in back_lines().\n");
-							exit(-1);
-						}
-						page = buf + fpos - bytes_read;
-					} else {	/* Move backward BUF_SIZE/2 bytes */
-						if (lseek (fd, -(BUF_SIZE / 2 + bytes_read), SEEK_CUR) == -1) {
-							endwin();
-							fprintf(stderr, "\nError moving file pointer"
-							                " in back_lines().\n");
-							exit(-1);
-						}
-						page = buf + BUF_SIZE / 2;
-					}
-					if ((bytes_read =
-					     read(fd, buf, BUF_SIZE)) == -1) {
-						endwin();
-						fprintf(stderr, "\nError reading file in "
-						                "back_lines().\n");
-						exit(-1);
-					}
-					buf[bytes_read] = '\0';
-				} else {	/* Beginning of file reached */
-					begin_reached = 1;
-					return;
-				}
+				begin_reached = 1;
+				return;
 			}
-		} while (*(--page) != '\n');
-	page++;
+			page--;
+		} while (*page != '\n');
+		page++;
+	}
 }
 
 /*
@@ -467,33 +322,14 @@ #endif
  */
 static char *get_line(void)
 {
-	int i = 0, fpos;
+	int i = 0;
 	static char line[MAX_LEN + 1];
 
 	end_reached = 0;
 	while (*page != '\n') {
 		if (*page == '\0') {
-			/* Either end of file or end of buffer reached */
-			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-				endwin();
-				fprintf(stderr, "\nError moving file pointer in "
-				                "get_line().\n");
-				exit(-1);
-			}
-			if (fpos < file_size) {	/* Not end of file yet */
-				/* We've reached end of buffer, but not end of file yet,
-				   so read next part of file into buffer */
-				if ((bytes_read =
-				     read(fd, buf, BUF_SIZE)) == -1) {
-					endwin();
-					fprintf(stderr, "\nError reading file in get_line().\n");
-					exit(-1);
-				}
-				buf[bytes_read] = '\0';
-				page = buf;
-			} else {
-				if (!end_reached)
-					end_reached = 1;
+			if (!end_reached) {
+				end_reached = 1;
 				break;
 			}
 		} else if (i < MAX_LEN)
@@ -518,17 +354,11 @@ static char *get_line(void)
  */
 static void print_position(WINDOW * win, int height, int width)
 {
-	int fpos, percent;
+	int percent;
 
-	if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
-		endwin();
-		fprintf(stderr, "\nError moving file pointer in print_position().\n");
-		exit(-1);
-	}
 	wattrset(win, dlg.position_indicator.atr);
 	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
-	percent = !file_size ?
-	    100 : ((fpos - bytes_read + page - buf) * 100) / file_size;
+	percent = (page - buf) * 100 / strlen(buf);
 	wmove(win, height - 3, width - 9);
 	wprintw(win, "(%3d%%)", percent);
 }
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index e73a36d..d9a056a 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -268,13 +268,18 @@ void dialog_clear(void)
 /*
  * Do some initialization for dialog
  */
-void init_dialog(void)
+void init_dialog(const char *backtitle)
+{
+	dlg.backtitle = backtitle;
+	color_setup(getenv("MENUCONFIG_COLOR"));
+}
+
+void reset_dialog(void)
 {
 	initscr();		/* Init curses */
 	keypad(stdscr, TRUE);
 	cbreak();
 	noecho();
-	color_setup(getenv("MENUCONFIG_COLOR"));
 	dialog_clear();
 }
 
@@ -471,3 +476,127 @@ int first_alpha(const char *string, cons
 
 	return 0;
 }
+
+struct dialog_list *item_cur;
+struct dialog_list *item_head;
+
+void item_reset(void)
+{
+	struct dialog_list *p, *next;
+
+	for (p = item_head; p; p = next) {
+		next = p->next;
+		free(p);
+	}
+	item_head = NULL;
+	item_cur = NULL;
+}
+
+void item_make(const char *fmt, ...)
+{
+	va_list ap;
+	struct dialog_list *p = malloc(sizeof(*p));
+
+	if (item_cur)
+		item_cur->next = p;
+	else
+		item_head = p;
+	item_cur = p;
+	memset(p, 0, sizeof(*p));
+
+	va_start(ap, fmt);
+	vsnprintf(item_cur->node.str, sizeof(item_cur->node.str), fmt, ap);
+	va_end(ap);
+}
+
+void item_add_str(const char *fmt, ...)
+{
+	va_list ap;
+        size_t avail;
+
+	avail = sizeof(item_cur->node.str) - strlen(item_cur->node.str);
+
+	va_start(ap, fmt);
+	vsnprintf(item_cur->node.str + strlen(item_cur->node.str),
+		  avail, fmt, ap);
+	item_cur->node.str[sizeof(item_cur->node.str) - 1] = '\0';
+	va_end(ap);
+}
+
+void item_set_tag(char tag)
+{
+	item_cur->node.tag = tag;
+}
+void item_set_data(void *ptr)
+{
+	item_cur->node.data = ptr;
+}
+
+void item_set_selected(int val)
+{
+	item_cur->node.selected = val;
+}
+
+int item_activate_selected(void)
+{
+	item_foreach()
+		if (item_is_selected())
+			return 1;
+	return 0;
+}
+
+void *item_data(void)
+{
+	return item_cur->node.data;
+}
+
+char item_tag(void)
+{
+	return item_cur->node.tag;
+}
+
+int item_count(void)
+{
+	int n = 0;
+	struct dialog_list *p;
+
+	for (p = item_head; p; p = p->next)
+		n++;
+	return n;
+}
+
+void item_set(int n)
+{
+	int i = 0;
+	item_foreach()
+		if (i++ == n)
+			return;
+}
+
+int item_n(void)
+{
+	int n = 0;
+	struct dialog_list *p;
+
+	for (p = item_head; p; p = p->next) {
+		if (p == item_cur)
+			return n;
+		n++;
+	}
+	return 0;
+}
+
+const char *item_str(void)
+{
+	return item_cur->node.str;
+}
+
+int item_is_selected(void)
+{
+	return (item_cur->node.selected != 0);
+}
+
+int item_is_tag(char tag)
+{
+	return (item_cur->node.tag == tag);
+}
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index e938037..9fc2449 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -99,5 +99,5 @@ int dialog_yesno(const char *title, cons
 	}
 
 	delwin(dialog);
-	return -1;		/* ESC pressed */
+	return 255;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5992673..54464e6 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -24,6 +24,7 @@ #include <locale.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"
+#include "lxdialog/dialog.h"
 
 static char menu_backtitle[128];
 static const char mconf_readme[] = N_(
@@ -270,16 +271,12 @@ search_help[] = N_(
 	"          USB$ => find all CONFIG_ symbols ending with USB\n"
 	"\n");
 
-static char buf[4096], *bufptr = buf;
-static char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
-static char *args[1024], **argptr = args;
 static int indent;
 static struct termios ios_org;
 static int rows = 0, cols = 0;
 static struct menu *current_menu;
 static int child_count;
-static int do_resize;
 static int single_menu_mode;
 
 static void conf(struct menu *menu);
@@ -290,12 +287,6 @@ static void conf_save(void);
 static void show_textbox(const char *title, const char *text, int r, int c);
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
-static void show_file(const char *filename, const char *title, int r, int c);
-
-static void cprint_init(void);
-static int cprint1(const char *fmt, ...);
-static void cprint_done(void);
-static int cprint(const char *fmt, ...);
 
 static void init_wsize(void)
 {
@@ -332,54 +323,6 @@ static void init_wsize(void)
 	cols -= 5;
 }
 
-static void cprint_init(void)
-{
-	bufptr = buf;
-	argptr = args;
-	memset(args, 0, sizeof(args));
-	indent = 0;
-	child_count = 0;
-	cprint("./scripts/kconfig/lxdialog/lxdialog");
-	cprint("--backtitle");
-	cprint(menu_backtitle);
-}
-
-static int cprint1(const char *fmt, ...)
-{
-	va_list ap;
-	int res;
-
-	if (!*argptr)
-		*argptr = bufptr;
-	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
-	va_end(ap);
-	bufptr += res;
-
-	return res;
-}
-
-static void cprint_done(void)
-{
-	*bufptr++ = 0;
-	argptr++;
-}
-
-static int cprint(const char *fmt, ...)
-{
-	va_list ap;
-	int res;
-
-	*argptr++ = bufptr;
-	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
-	va_end(ap);
-	bufptr += res;
-	*bufptr++ = 0;
-
-	return res;
-}
-
 static void get_prompt_str(struct gstr *r, struct property *prop)
 {
 	int i, j;
@@ -452,108 +395,17 @@ static struct gstr get_relations_str(str
 	return res;
 }
 
-pid_t pid;
-
-static void winch_handler(int sig)
-{
-	if (!do_resize) {
-		kill(pid, SIGINT);
-		do_resize = 1;
-	}
-}
-
-static int exec_conf(void)
-{
-	int pipefd[2], stat, size;
-	struct sigaction sa;
-	sigset_t sset, osset;
-
-	sigemptyset(&sset);
-	sigaddset(&sset, SIGINT);
-	sigprocmask(SIG_BLOCK, &sset, &osset);
-
-	signal(SIGINT, SIG_DFL);
-
-	sa.sa_handler = winch_handler;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGWINCH, &sa, NULL);
-
-	*argptr++ = NULL;
-
-	pipe(pipefd);
-	pid = fork();
-	if (pid == 0) {
-		sigprocmask(SIG_SETMASK, &osset, NULL);
-		dup2(pipefd[1], 2);
-		close(pipefd[0]);
-		close(pipefd[1]);
-		execv(args[0], args);
-		_exit(EXIT_FAILURE);
-	}
-
-	close(pipefd[1]);
-	bufptr = input_buf;
-	while (1) {
-		size = input_buf + sizeof(input_buf) - bufptr;
-		size = read(pipefd[0], bufptr, size);
-		if (size <= 0) {
-			if (size < 0) {
-				if (errno == EINTR || errno == EAGAIN)
-					continue;
-				perror("read");
-			}
-			break;
-		}
-		bufptr += size;
-	}
-	*bufptr++ = 0;
-	close(pipefd[0]);
-	waitpid(pid, &stat, 0);
-
-	if (do_resize) {
-		init_wsize();
-		do_resize = 0;
-		sigprocmask(SIG_SETMASK, &osset, NULL);
-		return -1;
-	}
-	if (WIFSIGNALED(stat)) {
-		printf("\finterrupted(%d)\n", WTERMSIG(stat));
-		exit(1);
-	}
-#if 0
-	printf("\fexit state: %d\nexit data: '%s'\n", WEXITSTATUS(stat), input_buf);
-	sleep(1);
-#endif
-	sigpending(&sset);
-	if (sigismember(&sset, SIGINT)) {
-		printf("\finterrupted\n");
-		exit(1);
-	}
-	sigprocmask(SIG_SETMASK, &osset, NULL);
-
-	return WEXITSTATUS(stat);
-}
-
 static void search_conf(void)
 {
 	struct symbol **sym_arr;
-	int stat;
 	struct gstr res;
-
+	int dres;
 again:
-	cprint_init();
-	cprint("--title");
-	cprint(_("Search Configuration Parameter"));
-	cprint("--inputbox");
-	cprint(_("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"));
-	cprint("10");
-	cprint("75");
-	cprint("");
-	stat = exec_conf();
-	if (stat < 0)
-		goto again;
-	switch (stat) {
+	reset_dialog();
+	dres = dialog_inputbox(_("Search Configuration Parameter"),
+			      _("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"),
+			      10, 75, "");
+	switch (dres) {
 	case 0:
 		break;
 	case 1:
@@ -563,7 +415,7 @@ again:
 		return;
 	}
 
-	sym_arr = sym_re_search(input_buf);
+	sym_arr = sym_re_search(dialog_input_result);
 	res = get_relations_str(sym_arr);
 	free(sym_arr);
 	show_textbox(_("Search Results"), str_get(&res), 0, 0);
@@ -590,24 +442,24 @@ static void build_conf(struct menu *menu
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
-				cprint("m%p", menu);
-
 				if (single_menu_mode) {
-					cprint1("%s%*c%s",
-						menu->data ? "-->" : "++>",
-						indent + 1, ' ', prompt);
+					item_make("%s%*c%s",
+						  menu->data ? "-->" : "++>",
+						  indent + 1, ' ', prompt);
 				} else
-					cprint1("   %*c%s  --->", indent + 1, ' ', prompt);
+					item_make("   %*c%s  --->", indent + 1, ' ', prompt);
 
-				cprint_done();
+				item_set_tag('m');
+				item_set_data(menu);
 				if (single_menu_mode && menu->data)
 					goto conf_childs;
 				return;
 			default:
 				if (prompt) {
 					child_count++;
-					cprint(":%p", menu);
-					cprint("---%*c%s", indent + 1, ' ', prompt);
+					item_make("---%*c%s", indent + 1, ' ', prompt);
+					item_set_tag(':');
+					item_set_data(menu);
 				}
 			}
 		} else
@@ -628,10 +480,9 @@ static void build_conf(struct menu *menu
 
 		val = sym_get_tristate_value(sym);
 		if (sym_is_changable(sym)) {
-			cprint("t%p", menu);
 			switch (type) {
 			case S_BOOLEAN:
-				cprint1("[%c]", val == no ? ' ' : '*');
+				item_make("[%c]", val == no ? ' ' : '*');
 				break;
 			case S_TRISTATE:
 				switch (val) {
@@ -639,84 +490,87 @@ static void build_conf(struct menu *menu
 				case mod: ch = 'M'; break;
 				default:  ch = ' '; break;
 				}
-				cprint1("<%c>", ch);
+				item_make("<%c>", ch);
 				break;
 			}
+			item_set_tag('t');
+			item_set_data(menu);
 		} else {
-			cprint("%c%p", def_menu ? 't' : ':', menu);
-			cprint1("   ");
+			item_make("   ");
+			item_set_tag(def_menu ? 't' : ':');
+			item_set_data(menu);
 		}
 
-		cprint1("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+		item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 		if (val == yes) {
 			if (def_menu) {
-				cprint1(" (%s)", menu_get_prompt(def_menu));
-				cprint1("  --->");
-				cprint_done();
+				item_add_str(" (%s)", menu_get_prompt(def_menu));
+				item_add_str("  --->");
 				if (def_menu->list) {
 					indent += 2;
 					build_conf(def_menu);
 					indent -= 2;
 				}
-			} else
-				cprint_done();
+			}
 			return;
 		}
-		cprint_done();
 	} else {
 		if (menu == current_menu) {
-			cprint(":%p", menu);
-			cprint("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			item_make("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			item_set_tag(':');
+			item_set_data(menu);
 			goto conf_childs;
 		}
 		child_count++;
 		val = sym_get_tristate_value(sym);
 		if (sym_is_choice_value(sym) && val == yes) {
-			cprint(":%p", menu);
-			cprint1("   ");
+			item_make("   ");
+			item_set_tag(':');
+			item_set_data(menu);
 		} else {
 			switch (type) {
 			case S_BOOLEAN:
-				cprint("t%p", menu);
 				if (sym_is_changable(sym))
-					cprint1("[%c]", val == no ? ' ' : '*');
+					item_make("[%c]", val == no ? ' ' : '*');
 				else
-					cprint1("---");
+					item_make("---");
+				item_set_tag('t');
+				item_set_data(menu);
 				break;
 			case S_TRISTATE:
-				cprint("t%p", menu);
 				switch (val) {
 				case yes: ch = '*'; break;
 				case mod: ch = 'M'; break;
 				default:  ch = ' '; break;
 				}
 				if (sym_is_changable(sym))
-					cprint1("<%c>", ch);
+					item_make("<%c>", ch);
 				else
-					cprint1("---");
+					item_make("---");
+				item_set_tag('t');
+				item_set_data(menu);
 				break;
 			default:
-				cprint("s%p", menu);
-				tmp = cprint1("(%s)", sym_get_string_value(sym));
+				tmp = 2 + strlen(sym_get_string_value(sym)); /* () = 2 */
+				item_make("(%s)", sym_get_string_value(sym));
 				tmp = indent - tmp + 4;
 				if (tmp < 0)
 					tmp = 0;
-				cprint1("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
-					(sym_has_value(sym) || !sym_is_changable(sym)) ?
-					"" : " (NEW)");
-				cprint_done();
+				item_add_str("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
+					     (sym_has_value(sym) || !sym_is_changable(sym)) ?
+					     "" : " (NEW)");
+				item_set_tag('s');
+				item_set_data(menu);
 				goto conf_childs;
 			}
 		}
-		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
-			(sym_has_value(sym) || !sym_is_changable(sym)) ?
-			"" : " (NEW)");
+		item_add_str("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
+			  (sym_has_value(sym) || !sym_is_changable(sym)) ?
+			  "" : " (NEW)");
 		if (menu->prompt->type == P_MENU) {
-			cprint1("  --->");
-			cprint_done();
+			item_add_str("  --->");
 			return;
 		}
-		cprint_done();
 	}
 
 conf_childs:
@@ -731,59 +585,43 @@ static void conf(struct menu *menu)
 	struct menu *submenu;
 	const char *prompt = menu_get_prompt(menu);
 	struct symbol *sym;
-	char active_entry[40];
-	int stat, type, i;
+	struct menu *active_menu = NULL;
+	int res;
+	int s_scroll = 0;
 
-	unlink("lxdialog.scrltmp");
-	active_entry[0] = 0;
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--menu");
-		cprint(_(menu_instructions));
-		cprint("%d", rows);
-		cprint("%d", cols);
-		cprint("%d", rows - 10);
-		cprint("%s", active_entry);
+		item_reset();
 		current_menu = menu;
 		build_conf(menu);
 		if (!child_count)
 			break;
 		if (menu == &rootmenu) {
-			cprint(":");
-			cprint("--- ");
-			cprint("L");
-			cprint(_("    Load an Alternate Configuration File"));
-			cprint("S");
-			cprint(_("    Save Configuration to an Alternate File"));
+			item_make("--- ");
+			item_set_tag(':');
+			item_make(_("    Load an Alternate Configuration File"));
+			item_set_tag('L');
+			item_make(_("    Save an Alternate Configuration File"));
+			item_set_tag('S');
 		}
-		stat = exec_conf();
-		if (stat < 0)
-			continue;
-
-		if (stat == 1 || stat == 255)
+		reset_dialog();
+		res = dialog_menu(prompt ? prompt : _("Main Menu"),
+				  _(menu_instructions),
+				  rows, cols, rows - 10,
+				  active_menu, &s_scroll);
+		if (res == 1 || res == 255)
 			break;
-
-		type = input_buf[0];
-		if (!type)
+		if (!item_activate_selected())
+			continue;
+		if (!item_tag())
 			continue;
 
-		for (i = 0; input_buf[i] && !isspace(input_buf[i]); i++)
-			;
-		if (i >= sizeof(active_entry))
-			i = sizeof(active_entry) - 1;
-		input_buf[i] = 0;
-		strcpy(active_entry, input_buf);
-
-		sym = NULL;
-		submenu = NULL;
-		if (sscanf(input_buf + 1, "%p", &submenu) == 1)
-			sym = submenu->sym;
+		submenu = item_data();
+		active_menu = item_data();
+		sym = submenu->sym;
 
-		switch (stat) {
+		switch (res) {
 		case 0:
-			switch (type) {
+			switch (item_tag()) {
 			case 'm':
 				if (single_menu_mode)
 					submenu->data = (void *) (long) !submenu->data;
@@ -814,7 +652,7 @@ static void conf(struct menu *menu)
 				show_helptext("README", _(mconf_readme));
 			break;
 		case 3:
-			if (type == 't') {
+			if (item_is_tag('t')) {
 				if (sym_set_tristate_value(sym, yes))
 					break;
 				if (sym_set_tristate_value(sym, mod))
@@ -822,17 +660,17 @@ static void conf(struct menu *menu)
 			}
 			break;
 		case 4:
-			if (type == 't')
+			if (item_is_tag('t'))
 				sym_set_tristate_value(sym, no);
 			break;
 		case 5:
-			if (type == 't')
+			if (item_is_tag('t'))
 				sym_set_tristate_value(sym, mod);
 			break;
 		case 6:
-			if (type == 't')
+			if (item_is_tag('t'))
 				sym_toggle_tristate_value(sym);
-			else if (type == 'm')
+			else if (item_is_tag('m'))
 				conf(submenu);
 			break;
 		case 7:
@@ -844,13 +682,8 @@ static void conf(struct menu *menu)
 
 static void show_textbox(const char *title, const char *text, int r, int c)
 {
-	int fd;
-
-	fd = creat(".help.tmp", 0777);
-	write(fd, text, strlen(text));
-	close(fd);
-	show_file(".help.tmp", title, r, c);
-	unlink(".help.tmp");
+	reset_dialog();
+	dialog_textbox(title, text, r ? r : rows, c ? c : cols);
 }
 
 static void show_helptext(const char *title, const char *text)
@@ -878,62 +711,44 @@ static void show_help(struct menu *menu)
 	str_free(&help);
 }
 
-static void show_file(const char *filename, const char *title, int r, int c)
-{
-	do {
-		cprint_init();
-		if (title) {
-			cprint("--title");
-			cprint("%s", title);
-		}
-		cprint("--textbox");
-		cprint("%s", filename);
-		cprint("%d", r ? r : rows);
-		cprint("%d", c ? c : cols);
-	} while (exec_conf() < 0);
-}
-
 static void conf_choice(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
 	struct menu *child;
 	struct symbol *active;
-	int stat;
 
 	active = sym_get_choice_value(menu->sym);
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--radiolist");
-		cprint(_(radiolist_instructions));
-		cprint("15");
-		cprint("70");
-		cprint("6");
+		int res;
+		int selected;
+		item_reset();
 
 		current_menu = menu;
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
-			cprint("%p", child);
-			cprint("%s", menu_get_prompt(child));
+			item_make("%s", menu_get_prompt(child));
+			item_set_data(child);
+			if (child->sym == active)
+				item_set_selected(1);
 			if (child->sym == sym_get_choice_value(menu->sym))
-				cprint("ON");
-			else if (child->sym == active)
-				cprint("SELECTED");
-			else
-				cprint("OFF");
+				item_set_tag('X');
 		}
-
-		stat = exec_conf();
-		switch (stat) {
+		reset_dialog();
+		res = dialog_checklist(prompt ? prompt : _("Main Menu"),
+					_(radiolist_instructions),
+					 15, 70, 6);
+		selected = item_activate_selected();
+		switch (res) {
 		case 0:
-			if (sscanf(input_buf, "%p", &child) != 1)
-				break;
-			sym_set_tristate_value(child->sym, yes);
+			if (selected) {
+				child = item_data();
+				sym_set_tristate_value(child->sym, yes);
+			}
 			return;
 		case 1:
-			if (sscanf(input_buf, "%p", &child) == 1) {
+			if (selected) {
+				child = item_data();
 				show_help(child);
 				active = child->sym;
 			} else
@@ -948,33 +763,31 @@ static void conf_choice(struct menu *men
 static void conf_string(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
-	int stat;
 
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--inputbox");
+		int res;
+		char *heading;
+
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			cprint(_(inputbox_instructions_int));
+			heading = _(inputbox_instructions_int);
 			break;
 		case S_HEX:
-			cprint(_(inputbox_instructions_hex));
+			heading = _(inputbox_instructions_hex);
 			break;
 		case S_STRING:
-			cprint(_(inputbox_instructions_string));
+			heading = _(inputbox_instructions_string);
 			break;
 		default:
-			/* panic? */;
+			heading = "Internal mconf error!";
 		}
-		cprint("10");
-		cprint("75");
-		cprint("%s", sym_get_string_value(menu->sym));
-		stat = exec_conf();
-		switch (stat) {
+		reset_dialog();
+		res = dialog_inputbox(prompt ? prompt : _("Main Menu"),
+				      heading, 10, 75, 
+				      sym_get_string_value(menu->sym));
+		switch (res) {
 		case 0:
-			if (sym_set_string_value(menu->sym, input_buf))
+			if (sym_set_string_value(menu->sym, dialog_input_result))
 				return;
 			show_textbox(NULL, _("You have made an invalid entry."), 5, 43);
 			break;
@@ -989,21 +802,17 @@ static void conf_string(struct menu *men
 
 static void conf_load(void)
 {
-	int stat;
 
 	while (1) {
-		cprint_init();
-		cprint("--inputbox");
-		cprint(load_config_text);
-		cprint("11");
-		cprint("55");
-		cprint("%s", filename);
-		stat = exec_conf();
-		switch(stat) {
+		int res;
+		reset_dialog();
+		res = dialog_inputbox(NULL, load_config_text,
+				      11, 55, filename);
+		switch(res) {
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_read(input_buf))
+			if (!conf_read(dialog_input_result))
 				return;
 			show_textbox(NULL, _("File does not exist!"), 5, 38);
 			break;
@@ -1018,21 +827,16 @@ static void conf_load(void)
 
 static void conf_save(void)
 {
-	int stat;
-
 	while (1) {
-		cprint_init();
-		cprint("--inputbox");
-		cprint(save_config_text);
-		cprint("11");
-		cprint("55");
-		cprint("%s", filename);
-		stat = exec_conf();
-		switch(stat) {
+		int res;
+		reset_dialog();
+		res = dialog_inputbox(NULL, save_config_text,
+				      11, 55, filename);
+		switch(res) {
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_write(input_buf))
+			if (!conf_write(dialog_input_result))
 				return;
 			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
 			break;
@@ -1056,7 +860,7 @@ int main(int ac, char **av)
 {
 	struct symbol *sym;
 	char *mode;
-	int stat;
+	int res;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -1079,18 +883,16 @@ int main(int ac, char **av)
 	tcgetattr(1, &ios_org);
 	atexit(conf_cleanup);
 	init_wsize();
+	reset_dialog();
+	init_dialog(menu_backtitle);
 	conf(&rootmenu);
-
-	do {
-		cprint_init();
-		cprint("--yesno");
-		cprint(_("Do you wish to save your new kernel configuration?"));
-		cprint("5");
-		cprint("60");
-		stat = exec_conf();
-	} while (stat < 0);
-
-	if (stat == 0) {
+	reset_dialog();
+	res = dialog_yesno(NULL,
+			   _("Do you wish to save your "
+			     "new kernel configuration?"),
+			   5, 60);
+	end_dialog();
+	if (res == 0) {
 		if (conf_write(NULL)) {
 			fprintf(stderr, _("\n\n"
 				"Error during writing of the kernel configuration.\n"
-- 
1.4.1.rc2.gfc04

