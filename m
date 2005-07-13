Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVGMROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGMROL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:12:25 -0400
Received: from mta03.mail.t-online.hu ([195.228.240.56]:6356 "EHLO
	mta03.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261583AbVGMRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:11:40 -0400
Subject: [PATCH 4/19] Kconfig I18N: lxdialog: multibyte character support
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:11:34 +0200
Message-Id: <1121274694.2975.18.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


UTF-8 support for lxdialog with wchar. The installed wide ncurses 
(ncursesw) is optional because some languages (ex. English, Italian) 
and ISO 8859-xx charsets don't require this patch.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/lxdialog/Makefile    |   43 +++++++++--
 scripts/lxdialog/checklist.c |   66 ++++++++++++++++-
 scripts/lxdialog/dialog.h    |    9 ++
 scripts/lxdialog/inputbox.c  |   23 ++++++
 scripts/lxdialog/menubox.c   |  161 ++++++++++++++++++++++++++++++++++++++++++-
 scripts/lxdialog/msgbox.c    |   22 +++++
 scripts/lxdialog/textbox.c   |   34 ++++++++-
 scripts/lxdialog/util.c      |  148 +++++++++++++++++++++++++++++++++++++--
 scripts/lxdialog/yesno.c     |   22 +++++
 9 files changed, 502 insertions(+), 26 deletions(-)

diff -puN scripts/lxdialog/checklist.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/checklist.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/checklist.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/checklist.c	2005-07-13 18:32:16.000000000 +0200
@@ -33,7 +33,11 @@ print_item (WINDOW * win, const char *it
 	    int choice, int selected)
 {
     int i, item_width=list_width+check_x-item_x;
+#ifdef USE_WIDE_CURSES
+    wchar_t *witems, list_item[item_width+1], fc[2];
+#else /* USE_WIDE_CURSES */
     char list_item[item_width+1];
+#endif /* USE_WIDE_CURSES */
 
     /* Clear 'residue' of last item */
     wattrset (win, menubox_attr);
@@ -48,6 +52,20 @@ print_item (WINDOW * win, const char *it
     else
 	wprintw (win, "(%c)", status ? 'X' : ' ');
 
+#ifdef USE_WIDE_CURSES
+    witems = to_wchar (item);
+    if (witems) {
+	wcsncpy (list_item, witems, item_width);
+	list_item[item_width] = 0;
+	wattrset (win, selected ? tag_selected_attr : tag_attr);
+	fc[0] = list_item[0];
+	fc[1] = 0;
+	mvwaddwstr(win, choice, item_x, fc);
+	wattrset (win, selected ? item_selected_attr : item_attr);
+	waddwstr (win, &list_item[1]);
+	free (witems);
+    }
+#else /* USE_WIDE_CURSES */
     strncpy (list_item, item, item_width);
     list_item[item_width] = 0;
 
@@ -55,6 +73,7 @@ print_item (WINDOW * win, const char *it
     mvwaddch(win, choice, item_x, list_item[0]);
     wattrset (win, selected ? item_selected_attr : item_attr);
     waddstr (win, &list_item[1]);
+#endif /* USE_WIDE_CURSES */
     if (selected) {
     	wmove (win, choice, check_x+1);
     	wrefresh (win);
@@ -128,6 +147,9 @@ dialog_checklist (const char *title, con
     int i, x, y, box_x, box_y;
     int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
     WINDOW *dialog, *list;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle, *witems;
+#endif /* USE_WIDE_CURSES */
 
     checkflag = flag;
 
@@ -167,6 +189,25 @@ dialog_checklist (const char *title, con
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t));
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+	free (wtitle);
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -181,6 +222,7 @@ dialog_checklist (const char *title, con
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
 
     wattrset (dialog, dialog_attr);
     print_autowrap (dialog, prompt, width - 2, 1, 3);
@@ -200,8 +242,16 @@ dialog_checklist (const char *title, con
 
     /* Find length of longest item in order to center checklist */
     check_x = 0;
-    for (i = 0; i < item_no; i++) 
+    for (i = 0; i < item_no; i++) {
+#ifdef USE_WIDE_CURSES
+	witems = to_wchar (items[i * 3 + 1]);
+	if (witems)
+	    check_x = MAX (check_x, MIN(list_width, wcslen (witems) + 4));
+	free (witems);
+#else /* USE_WIDE_CURSES */
 	check_x = MAX (check_x, MIN(list_width, strlen (items[i * 3 + 1]) + 4));
+#endif /* USE_WIDE_CURSES */
+    }
 
     check_x = (list_width - check_x) / 2;
     item_x = check_x + 4;
@@ -228,12 +278,17 @@ dialog_checklist (const char *title, con
 
     while (key != ESC) {
 	key = wgetch (dialog);
-
-    	for (i = 0; i < max_choice; i++)
+    	for (i = 0; i < max_choice; i++) {
+#ifdef USE_WIDE_CURSES
+	    witems = to_wchar (items[(scroll+i)*3+1]);
+            if (witems && towupper(key) == towupper(witems[0]))
+                break;
+	    free (witems);
+#else /* USE_WIDE_CURSES */
             if (toupper(key) == toupper(items[(scroll+i)*3+1][0]))
                 break;
-
-
+#endif /* USE_WIDE_CURSES */
+	}
 	if ( i < max_choice || key == KEY_UP || key == KEY_DOWN || 
 	    key == '+' || key == '-' ) {
 	    if (key == KEY_UP || key == '-') {
@@ -369,7 +424,6 @@ dialog_checklist (const char *title, con
 	/* Now, update everything... */
 	doupdate ();
     }
-    
 
     delwin (dialog);
     free (status);
diff -puN scripts/lxdialog/dialog.h~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/dialog.h
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/dialog.h~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/dialog.h	2005-07-13 18:32:16.000000000 +0200
@@ -36,6 +36,11 @@
 #endif
 #include CURSES_LOC
 
+#ifdef USE_WIDE_CURSES
+#include <wchar.h>
+#include <wctype.h>
+#endif
+
 /*
  * Colors in ncurses 1.9.9e do not work properly since foreground and
  * background colors are OR'd rather than separately masked.  This version
@@ -158,6 +163,10 @@ void draw_box (WINDOW * win, int y, int 
 void draw_shadow (WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha (const char *string, const char *exempt);
+#ifdef USE_WIDE_CURSES
+int first_alphaw (const wchar_t *string, const char *exempt);
+wchar_t* to_wchar (const char *mbs);
+#endif
 int dialog_yesno (const char *title, const char *prompt, int height, int width);
 int dialog_msgbox (const char *title, const char *prompt, int height,
 		int width, int pause);
diff -puN scripts/lxdialog/inputbox.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/inputbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/inputbox.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/inputbox.c	2005-07-13 18:32:16.000000000 +0200
@@ -50,6 +50,9 @@ dialog_inputbox (const char *title, cons
     int input_x = 0, scroll = 0, key = 0, button = -1;
     unsigned char *instr = dialog_input_result;
     WINDOW *dialog;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle;
+#endif /* USE_WIDE_CURSES */
 
     /* center dialog box on screen */
     x = (COLS - width) / 2;
@@ -69,6 +72,25 @@ dialog_inputbox (const char *title, cons
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t));
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+	free (wtitle);
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -83,6 +105,7 @@ dialog_inputbox (const char *title, cons
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
 
     wattrset (dialog, dialog_attr);
     print_autowrap (dialog, prompt, width - 2, 1, 3);
diff -puN scripts/lxdialog/Makefile~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/Makefile
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/Makefile~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/Makefile	2005-07-13 18:32:16.000000000 +0200
@@ -1,23 +1,39 @@
 HOST_EXTRACFLAGS := -DLOCALE 
-ifeq ($(shell uname),SunOS)
-HOST_LOADLIBES   := -lcurses
-else
-HOST_LOADLIBES   := -lncurses
-endif
 
-ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
-        HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"
+ifeq (/usr/include/ncursesw/curses.h, $(wildcard /usr/include/ncursesw/curses.h))
+        HOST_EXTRACFLAGS += -I/usr/include/ncursesw -DCURSES_LOC="<ncursesw/curses.h>"
+        HOST_EXTRACFLAGS += -DUSE_WIDE_CURSES
+        NCURSES_LIB := -lncursesw
+else
+ifeq (/usr/include/ncursesw/ncurses.h, $(wildcard /usr/include/ncursesw/ncurses.h))
+        HOST_EXTRACFLAGS += -I/usr/include/ncursesw -DCURSES_LOC="<ncursesw/ncurses.h>"
+        HOST_EXTRACFLAGS += -DUSE_WIDE_CURSES
+        NCURSES_LIB := -lncursesw
 else
 ifeq (/usr/include/ncurses/curses.h, $(wildcard /usr/include/ncurses/curses.h))
         HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses/curses.h>"
+        NCURSES_LIB := -lncurses
+else
+ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
+        HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"
+        NCURSES_LIB := -lncurses
 else
 ifeq (/usr/include/ncurses.h, $(wildcard /usr/include/ncurses.h))
         HOST_EXTRACFLAGS += -DCURSES_LOC="<ncurses.h>"
+        NCURSES_LIB := -lncurses
 else
-	HOST_EXTRACFLAGS += -DCURSES_LOC="<curses.h>"
+        HOST_EXTRACFLAGS += -DCURSES_LOC="<curses.h>"
+endif
 endif
 endif
 endif
+endif
+
+ifeq ($(shell uname),SunOS)
+HOST_LOADLIBES   := -lcurses
+else
+HOST_LOADLIBES   := $(NCURSES_LIB)
+endif
 
 hostprogs-y	:= lxdialog
 always		:= ncurses $(hostprogs-y)
@@ -25,8 +41,19 @@ always		:= ncurses $(hostprogs-y)
 lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
 		 util.o lxdialog.o msgbox.o
 
+
 .PHONY: $(obj)/ncurses
 $(obj)/ncurses:
+	@if $$(echo $(HOST_LOADLIBES)|grep -qv "-lnursesw"); then \
+		LANGUAGE=$$(echo $$LANG $$LC_ALL) ;\
+	fi ;\
+	if $$(echo $$LANGUAGE|grep -v "en_"|grep -q ".UTF-8"); \
+	then \
+		echo ;\
+		echo ">> Warning: You need wide Ncurses libraries" ;\
+		echo ">> in order to display UTF-8 characters." ;\
+		echo ;\
+	fi
 	@echo "main() {}" > lxtemp.c
 	@if $(HOSTCC) lxtemp.c  $(HOST_LOADLIBES); then \
 		rm -f lxtemp.c a.out; \
diff -puN scripts/lxdialog/menubox.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/menubox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/menubox.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/menubox.c	2005-07-13 18:36:59.000000000 +0200
@@ -67,11 +67,20 @@ static void
 print_item (WINDOW * win, const char *item, int choice, int selected, int hotkey)
 {
     int j;
+#ifdef USE_WIDE_CURSES
+    wchar_t menu_item[menu_width+1], *witems, fc[2];
+
+    witems = to_wchar (item);
+    wcsncpy(menu_item, witems, menu_width);
+    menu_item[menu_width] = 0;
+    j = first_alphaw(menu_item, "YyNnMmHh");
+#else /* USE_WIDE_CURSES */
     char menu_item[menu_width+1];
 
     strncpy(menu_item, item, menu_width);
     menu_item[menu_width] = 0;
     j = first_alpha(menu_item, "YyNnMmHh");
+#endif /* USE_WIDE_CURSES */
 
     /* Clear 'residue' of last item */
     wattrset (win, menubox_attr);
@@ -82,14 +91,24 @@ print_item (WINDOW * win, const char *it
         for (i = 0; i < menu_width; i++)
 	    waddch (win, ' ');
     }
-#else
+#else /* OLD_NCURSES */
     wclrtoeol(win);
-#endif
+#endif /* OLD_NCURSES */
     wattrset (win, selected ? item_selected_attr : item_attr);
+#ifdef USE_WIDE_CURSES
+    mvwaddwstr (win, choice, item_x, menu_item);
+#else /* USE_WIDE_CURSES */
     mvwaddstr (win, choice, item_x, menu_item);
+#endif /* USE_WIDE_CURSES */
     if (hotkey) {
     	wattrset (win, selected ? tag_key_selected_attr : tag_key_attr);
+#ifdef USE_WIDE_CURSES
+		fc[0] = menu_item[j];
+		fc[1] = 0;
+    	mvwaddwstr(win, choice, item_x+j, fc);
+#else /* USE_WIDE_CURSES */
     	mvwaddch(win, choice, item_x+j, menu_item[j]);
+#endif /* USE_WIDE_CURSES */
     }
     if (selected) {
 	wmove (win, choice, item_x+1);
@@ -172,6 +191,9 @@ dialog_menu (const char *title, const ch
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
     WINDOW *dialog, *menu;
     FILE *f;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle, *witems, *witem2, *wcurrent;
+#endif /* USE_WIDE_CURSES */
 
     max_choice = MIN (menu_height, item_no);
 
@@ -193,6 +215,24 @@ dialog_menu (const char *title, const ch
     wbkgdset (dialog, dialog_attr & A_COLOR);
     waddch (dialog, ACS_RTEE);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t));
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -207,6 +247,7 @@ dialog_menu (const char *title, const ch
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
 
     wattrset (dialog, dialog_attr);
     print_autowrap (dialog, prompt, width - 2, 1, 3);
@@ -229,10 +270,26 @@ dialog_menu (const char *title, const ch
      * Set 'choice' to default item. 
      */
     item_x = 0;
+#ifdef USE_WIDE_CURSES
+    wcurrent = to_wchar (current);
+#endif /* USE_WIDE_CURSES */
     for (i = 0; i < item_no; i++) {
+#ifdef USE_WIDE_CURSES
+	witems = to_wchar (items[i * 2 + 1]);
+	witem2 = to_wchar (items[i * 2]);
+	if (witems)
+	    item_x = MAX (item_x, MIN(menu_width, wcslen (witems) + 2));
+	if (witem2 && wcurrent && wcscmp(wcurrent, witem2) == 0) choice = i;
+	free (witems);
+	free (witem2);
+#else /* USE_WIDE_CURSES */
 	item_x = MAX (item_x, MIN(menu_width, strlen (items[i * 2 + 1]) + 2));
 	if (strcmp(current, items[i*2]) == 0) choice = i;
+#endif /* USE_WIDE_CURSES */
     }
+#ifdef USE_WIDE_CURSES
+    free (wcurrent);
+#endif /* USE_WIDE_CURSES */
 
     item_x = (menu_width - item_x) / 2;
 
@@ -261,8 +318,18 @@ dialog_menu (const char *title, const ch
 
     /* Print the menu */
     for (i=0; i < max_choice; i++) {
+#ifdef USE_WIDE_CURSES
+	witems = to_wchar (items[(first_item + i)*2]);
+	if (witems)
+	    print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice,
+                    (witems[0] != ':'));
+	else
+	    print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice, TRUE);
+	free (witems);
+#else /* USE_WIDE_CURSES */
 	print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice,
                     (items[(first_item + i)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
     }
 
     wnoutrefresh (menu);
@@ -284,14 +351,32 @@ dialog_menu (const char *title, const ch
 	else {
         for (i = choice+1; i < max_choice; i++) {
 		j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
+#ifdef USE_WIDE_CURSES
+		witems = to_wchar (items[(scroll+i)*2+1]);
+		if (key == towlower(witems[j])) {
+			free (witems);
+                	break;
+		}
+		free (witems);
+#else /* USE_WIDE_CURSES */
 		if (key == tolower(items[(scroll+i)*2+1][j]))
                 	break;
+#endif /* USE_WIDE_CURSES */
 	}
 	if (i == max_choice)
        		for (i = 0; i < max_choice; i++) {
 			j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
+#ifdef USE_WIDE_CURSES
+			witems = to_wchar (items[(scroll+i)*2+1]);
+			if (key == towlower(witems[j])) {
+				free (witems);
+                		break;
+			}
+			free (witems);
+#else /* USE_WIDE_CURSES */
 			if (key == tolower(items[(scroll+i)*2+1][j]))
                 		break;
+#endif /* USE_WIDE_CURSES */
 		}
 	}
 
@@ -300,8 +385,18 @@ dialog_menu (const char *title, const ch
             key == '-' || key == '+' ||
             key == KEY_PPAGE || key == KEY_NPAGE) {
 
+#ifdef USE_WIDE_CURSES
+	    witems = to_wchar (items[(scroll+choice)*2]);
+	    if (witems)
+		print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
+                    (witems[0] != ':'));
+	    else
+		print_item (menu, items[(scroll+choice)*2+1], choice, FALSE, TRUE);
+	    free (witems);
+#else /* USE_WIDE_CURSES */
             print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
                        (items[(scroll+choice)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
 
 	    if (key == KEY_UP || key == '-') {
                 if (choice < 2 && scroll) {
@@ -312,15 +407,35 @@ dialog_menu (const char *title, const ch
 
                     scroll--;
 
+#ifdef USE_WIDE_CURSES
+		    witems = to_wchar (items[scroll*2]);
+		    if (witems)
+			print_item (menu, items[scroll*2+1], 0, FALSE,
+                	    (witems[0] != ':'));
+		    else
+			print_item (menu, items[scroll*2+1], 0, FALSE, TRUE);
+		    free (witems);
+#else /* USE_WIDE_CURSES */
                     print_item (menu, items[scroll * 2 + 1], 0, FALSE,
                                (items[scroll*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
 		} else
 		    choice = MAX(choice - 1, 0);
 
 	    } else if (key == KEY_DOWN || key == '+')  {
 
+#ifdef USE_WIDE_CURSES
+		witems = to_wchar (items[(scroll+choice)*2]);
+		if (witems)
+		    print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
+                	(witems[0] != ':'));
+		else
+		    print_item (menu, items[(scroll+choice)*2+1], choice, FALSE, TRUE);
+		free (witems);
+#else /* USE_WIDE_CURSES */
 		print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
                                 (items[(scroll+choice)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
 
                 if ((choice > max_choice-3) &&
                     (scroll + max_choice < item_no)
@@ -332,9 +447,20 @@ dialog_menu (const char *title, const ch
 
                     scroll++;
 
+#ifdef USE_WIDE_CURSES
+		witems = to_wchar (items[(scroll+max_choice-1)*2]);
+		if (witems)
+		    print_item (menu, items[(scroll+max_choice-1)*2+1],
+			max_choice-1, FALSE,
+                	(witems[0] != ':'));
+		else
+		    print_item (menu, items[(scroll+max_choice-1)*2+1], max_choice-1, FALSE, TRUE);
+		free (witems);
+#else /* USE_WIDE_CURSES */
                     print_item (menu, items[(scroll+max_choice-1)*2+1],
                                max_choice-1, FALSE,
                                (items[(scroll+max_choice-1)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
                 } else
                     choice = MIN(choice+1, max_choice-1);
 
@@ -344,8 +470,18 @@ dialog_menu (const char *title, const ch
                     if (scroll > 0) {
                 	wscrl (menu, -1);
                 	scroll--;
+#ifdef USE_WIDE_CURSES
+		witems = to_wchar (items[scroll*2]);
+		if (witems)
+		    print_item (menu, items[scroll * 2 + 1], 0, FALSE,
+                	(witems[0] != ':'));
+		else
+		    print_item (menu, items[scroll * 2 + 1], 0, FALSE, TRUE);
+		free (witems);
+#else /* USE_WIDE_CURSES */
                 	print_item (menu, items[scroll * 2 + 1], 0, FALSE,
                 	(items[scroll*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
                     } else {
                         if (choice > 0)
                             choice--;
@@ -360,9 +496,20 @@ dialog_menu (const char *title, const ch
 			wscrl (menu, 1);
 			scrollok (menu, FALSE);
                 	scroll++;
+#ifdef USE_WIDE_CURSES
+			witems = to_wchar (items[(scroll+max_choice-1)*2]);
+			if (witems)
+			    print_item (menu, items[(scroll+max_choice-1)*2+1],
+				max_choice-1, FALSE,
+                		(witems[0] != ':'));
+			else
+			    print_item (menu, items[(scroll+max_choice-1)*2+1], max_choice-1, FALSE, TRUE);
+			free (witems);
+#else /* USE_WIDE_CURSES */
                 	print_item (menu, items[(scroll+max_choice-1)*2+1],
 			            max_choice-1, FALSE,
 			            (items[(scroll+max_choice-1)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
 		    } else {
 			if (choice+1 < max_choice)
 			    choice++;
@@ -372,8 +519,18 @@ dialog_menu (const char *title, const ch
             } else
                 choice = i;
 
+#ifdef USE_WIDE_CURSES
+	    witems = to_wchar (items[(scroll+choice)*2]);
+	    if (witems)
+		print_item (menu, items[(scroll+choice)*2+1], choice, TRUE,
+                    (witems[0] != ':'));
+	    else
+		print_item (menu, items[(scroll+choice)*2+1], choice, TRUE, TRUE);
+	    free (witems);
+#else /* USE_WIDE_CURSES */
             print_item (menu, items[(scroll+choice)*2+1], choice, TRUE,
                        (items[(scroll+choice)*2][0] != ':'));
+#endif /* USE_WIDE_CURSES */
 
             print_arrows(dialog, item_no, scroll,
                          box_y, box_x+item_x+1, menu_height);
diff -puN scripts/lxdialog/msgbox.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/msgbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/msgbox.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/msgbox.c	2005-07-13 18:32:16.000000000 +0200
@@ -31,6 +31,9 @@ dialog_msgbox (const char *title, const 
 {
     int i, x, y, key = 0;
     WINDOW *dialog;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle;
+#endif /* USE_WIDE_CURSES */
 
     /* center dialog box on screen */
     x = (COLS - width) / 2;
@@ -43,6 +46,24 @@ dialog_msgbox (const char *title, const 
 
     draw_box (dialog, 0, 0, height, width, dialog_attr, border_attr);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t));
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -57,6 +78,7 @@ dialog_msgbox (const char *title, const 
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
     wattrset (dialog, dialog_attr);
     print_autowrap (dialog, prompt, width - 2, 1, 2);
 
diff -puN scripts/lxdialog/textbox.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/textbox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/textbox.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/textbox.c	2005-07-13 18:32:16.000000000 +0200
@@ -41,6 +41,9 @@ dialog_textbox (const char *title, const
     int passed_end;
     char search_term[MAX_LEN + 1];
     WINDOW *dialog, *text;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle;
+#endif /* USE_WIDE_CURSES */
 
     search_term[0] = '\0';	/* no search term entered yet */
 
@@ -106,6 +109,24 @@ dialog_textbox (const char *title, const
     wbkgdset (dialog, dialog_attr & A_COLOR);
     waddch (dialog, ACS_RTEE);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t));
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -120,6 +141,7 @@ dialog_textbox (const char *title, const
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
     print_button (dialog, _(" Exit "), height - 2, width / 2 - 4, TRUE);
     wnoutrefresh (dialog);
     getyx (dialog, cur_y, cur_x);	/* Save cursor position */
@@ -461,9 +483,17 @@ print_line (WINDOW * win, int row, int w
 {
     int y, x;
     char *line;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wline;
 
     line = get_line ();
+    wline = to_wchar (line);
+    if (wline)
+	line += MIN (wcslen (wline), hscroll);	/* Scroll horizontally */
+#else /* USE_WIDE_CURSES */
+    line = get_line ();
     line += MIN (strlen (line), hscroll);	/* Scroll horizontally */
+#endif /* USE_WIDE_CURSES */
     wmove (win, row, 0);	/* move cursor to correct line */
     waddch (win, ' ');
     waddnstr (win, line, MIN (strlen (line), width - 2));
@@ -476,9 +506,9 @@ print_line (WINDOW * win, int row, int w
         for (i = 0; i < width - x; i++)
 	    waddch (win, ' ');
     }
-#else
+#else /* OLD_NCURSES */
     wclrtoeol(win);
-#endif
+#endif /* OLD_NCURSES */
 }
 
 /*
diff -puN scripts/lxdialog/util.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/util.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/util.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/util.c	2005-07-13 18:32:16.000000000 +0200
@@ -199,12 +199,63 @@ print_autowrap (WINDOW * win, const char
 {
     int newl, cur_x, cur_y;
     int i, prompt_len, room, wlen;
+#ifdef USE_WIDE_CURSES
+    wchar_t *tempstr, *word, *sp, *sp2;
+
+    tempstr = to_wchar (prompt);
+
+    prompt_len = wcslen(tempstr);
+    /*
+     * Remove newlines
+     */
+    for(i=0; i<prompt_len; i++) {
+	if(tempstr[i] == '\n') tempstr[i] = ' ';
+    }
+
+    if (prompt_len <= width - x * 2) {	/* If prompt is short */
+	wmove (win, y, (width - prompt_len) / 2);
+	waddwstr (win, tempstr);
+    } else {
+	cur_x = x;
+	cur_y = y;
+	newl = 1;
+	word = tempstr;
+	while (word && *word) {
+	    sp = wcschr(word, ' ');
+	    if (sp)
+	        *sp++ = 0;
+	    /* Wrap to next line if either the word does not fit,
+	       or it is the first word of a new sentence, and it is
+	       short, and the next word does not fit. */
+	    room = width - cur_x;
+	    wlen = wcslen(word);
+	    if (wlen > room ||
+	       (newl && wlen < 4 && sp && wlen+1+wcslen(sp) > room
+		     && (!(sp2 = wcschr(sp, ' ')) || wlen+1+(sp2-sp) > room))) {
+		cur_y++;
+		cur_x = x;
+	    }
+	    wmove (win, cur_y, cur_x);
+	    waddwstr (win, word);
+	    getyx (win, cur_y, cur_x);
+	    cur_x++;
+	    if (sp && *sp == ' ') {
+	        cur_x++;	/* double space */
+
+		while (*++sp == ' ');
+		newl = 1;
+	    } else
+	        newl = 0;
+	    word = sp;
+	}
+    }
+#else /* USE_WIDE_CURSES */
     char tempstr[MAX_LEN + 1], *word, *sp, *sp2;
 
     strcpy (tempstr, prompt);
 
     prompt_len = strlen(tempstr);
-	
+
     /*
      * Remove newlines
      */
@@ -249,6 +300,7 @@ print_autowrap (WINDOW * win, const char
 	    word = sp;
 	}
     }
+#endif /* USE_WIDE_CURSES */
 }
 
 /*
@@ -258,6 +310,9 @@ void
 print_button (WINDOW * win, const char *label, int y, int x, int selected)
 {
     int i, temp;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wlabel, fc[2];
+#endif /* USE_WIDE_CURSES */
 
     wmove (win, y, x);
     wattrset (win, selected ? button_active_attr : button_inactive_attr);
@@ -270,10 +325,22 @@ print_button (WINDOW * win, const char *
 	waddch (win, ' ');
     wattrset (win, selected ? button_key_active_attr
 	      : button_key_inactive_attr);
+#ifdef USE_WIDE_CURSES
+    wlabel = to_wchar (label);
+    memset (&fc, 0, 2*sizeof(wchar_t));
+    if (wlabel) {
+	fc[0] = wlabel[0];
+	waddwstr (win, fc);
+	wattrset (win, selected ? button_label_active_attr
+	      : button_label_inactive_attr);
+	waddwstr (win, &wlabel[1]);
+    }
+#else /* USE_WIDE_CURSES */
     waddch (win, label[0]);
     wattrset (win, selected ? button_label_active_attr
 	      : button_label_inactive_attr);
     waddstr (win, (char *)label + 1);
+#endif /* USE_WIDE_CURSES */
     wattrset (win, selected ? button_active_attr : button_inactive_attr);
     waddstr (win, ">");
     wmove (win, y, x + temp + 1);
@@ -342,18 +409,83 @@ draw_shadow (WINDOW * win, int y, int x,
 int
 first_alpha(const char *string, const char *exempt)
 {
-	int i, in_paren=0, c;
+#ifdef USE_WIDE_CURSES
+	int ret;
+	wchar_t *wstring;
+
+	wstring = to_wchar (string);
+	if (!wstring)
+	    return 0;
 
-	for (i = 0; i < strlen(string); i++) {
-		c = tolower(string[i]);
+	ret = first_alphaw (wstring, exempt);
+	free (wstring);
+	
+	return ret;
+#else /* USE_WIDE_CURSES */
+        int i, in_paren=0, c;
+
+        for (i = 0; i < strlen(string); i++) {
+                c = tolower(string[i]);
+
+	        if (strchr("<[(", c)) ++in_paren;
+	        if (strchr(">])", c) && in_paren > 0) --in_paren;
+
+                if ((! in_paren) && isalpha(c) &&
+                     strchr(exempt, c) == 0)
+                     return i;
+	}
+	return 0;
+#endif /* USE_WIDE_CURSES */
+}
+
+#ifdef USE_WIDE_CURSES
+int
+first_alphaw(const wchar_t *wstring, const char *exempt)
+{
+	int i, in_paren=0;
+	wchar_t c, token1[4], token2[4], wexempt[200];
+
+	if (mbstowcs(token1, "<[(", 3) < 0)
+	    return 0;
+	if (mbstowcs(token2, ">])", 3) < 0)
+	    return 0;
+	if (mbstowcs(wexempt, exempt, 200) < 0)
+	    return 0;
 
-		if (strchr("<[(", c)) ++in_paren;
-		if (strchr(">])", c) && in_paren > 0) --in_paren;
+	for (i = 0; i < wcslen(wstring); i++) {
+		c = towlower(wstring[i]);
 
-		if ((! in_paren) && isalpha(c) && 
-		     strchr(exempt, c) == 0)
+		if (wcschr(token1, c)) ++in_paren;
+		if (wcschr(token2, c) && in_paren > 0) --in_paren;
+
+		if ((! in_paren) && iswalpha(c) && 
+		    wcschr(wexempt, c) == 0) {
 			return i;
+		    }
 	}
 
 	return 0;
 }
+
+wchar_t* to_wchar (const char *mbs)
+{
+    mbstate_t state;
+    wchar_t *wcs;
+    const char *mbsptr;
+
+    if (mbs) {
+    	wcs = (wchar_t*) malloc ((2+strlen(mbs))*sizeof(wchar_t));
+        memset (&state, 0, sizeof(state));
+    	mbsptr = mbs;
+    	if (mbsrtowcs (wcs, &mbsptr, strlen(mbs)+1, &state) < 0) {
+	    free (wcs);
+            wcs = 0;
+        }
+    }
+    else
+        wcs = 0;
+
+    return wcs;
+}
+#endif /* USE_WIDE_CURSES */
+
diff -puN scripts/lxdialog/yesno.c~kconfig-i18n-04-lxdialog-multibyte scripts/lxdialog/yesno.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/yesno.c~kconfig-i18n-04-lxdialog-multibyte	2005-07-13 18:32:16.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/yesno.c	2005-07-13 18:36:59.000000000 +0200
@@ -45,6 +45,9 @@ dialog_yesno (const char *title, const c
 {
     int i, x, y, key = 0, button = 0;
     WINDOW *dialog;
+#ifdef USE_WIDE_CURSES
+    wchar_t *wtitle;
+#endif /* USE_WIDE_CURSES */
 
     /* center dialog box on screen */
     x = (COLS - width) / 2;
@@ -63,6 +66,24 @@ dialog_yesno (const char *title, const c
     wattrset (dialog, dialog_attr);
     waddch (dialog, ACS_RTEE);
 
+#ifdef USE_WIDE_CURSES
+    wtitle = to_wchar (title);
+    if (wtitle != NULL && wcslen(wtitle) >= width-2 ) {
+	/* truncate long title -- mec */
+	wchar_t * title2 = malloc((width-2+1)*sizeof(wchar_t));
+	memcpy( title2, wtitle, (width-2)*sizeof(wchar_t) );
+	title2[width-2] = '\0';
+	free (wtitle);
+	wtitle = title2;
+    }
+
+    if (wtitle != NULL) {
+	wattrset (dialog, title_attr);
+	mvwaddch (dialog, 0, (width - wcslen(wtitle))/2 - 1, ' ');
+	waddwstr (dialog, wtitle);
+	waddch (dialog, ' ');
+    }
+#else /* USE_WIDE_CURSES */
     if (title != NULL && strlen(title) >= width-2 ) {
 	/* truncate long title -- mec */
 	char * title2 = malloc(width-2+1);
@@ -77,6 +98,7 @@ dialog_yesno (const char *title, const c
 	waddstr (dialog, (char *)title);
 	waddch (dialog, ' ');
     }
+#endif /* USE_WIDE_CURSES */
 
     wattrset (dialog, dialog_attr);
     print_autowrap (dialog, prompt, width - 2, 1, 3);
_


