Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWACNZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWACNZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWACNZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50949 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932369AbWACNZk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:40 -0500
Subject: [PATCH 25/26] kconfig: Remove support for lxdialog --checklist
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947264187@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Baudis <pasky@ucw.cz>
Date: 1135223044 +0100

Remove support for lxdialog --checklist

The checklist lxdialog functionality is not used by menuconfig
(only the radiolist variant is used) and supporting it would
significantly complicate the forthcoming liblxdialog API.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/lxdialog/checklist.c |   47 ++++++++++------------------------
 scripts/kconfig/lxdialog/dialog.h    |    9 +------
 scripts/kconfig/lxdialog/lxdialog.c  |   12 +--------
 3 files changed, 17 insertions(+), 51 deletions(-)

00213b17cec87d2cd4df75bcc79aea7a91d8532d
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 3fb681f..db07ae7 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -23,7 +23,7 @@
 
 #include "dialog.h"
 
-static int list_width, check_x, item_x, checkflag;
+static int list_width, check_x, item_x;
 
 /*
  * Print list item
@@ -41,10 +41,7 @@ static void print_item(WINDOW * win, con
 
 	wmove(win, choice, check_x);
 	wattrset(win, selected ? check_selected_attr : check_attr);
-	if (checkflag == FLAG_CHECK)
-		wprintw(win, "[%c]", status ? 'X' : ' ');
-	else
-		wprintw(win, "(%c)", status ? 'X' : ' ');
+	wprintw(win, "(%c)", status ? 'X' : ' ');
 
 	wattrset(win, selected ? tag_selected_attr : tag_attr);
 	mvwaddch(win, choice, item_x, item[0]);
@@ -109,18 +106,16 @@ static void print_buttons(WINDOW * dialo
 
 /*
  * Display a dialog box with a list of options that can be turned on or off
- * The `flag' parameter is used to select between radiolist and checklist.
+ * in the style of radiolist (only one option turned on at a time).
  */
 int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height, int item_no,
-		     const char *const *items, int flag)
+		     const char *const *items)
 {
 	int i, x, y, box_x, box_y;
 	int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
 	WINDOW *dialog, *list;
 
-	checkflag = flag;
-
 	/* Allocate space for storing item on/off status */
 	if ((status = malloc(sizeof(int) * item_no)) == NULL) {
 		endwin();
@@ -303,34 +298,20 @@ int dialog_checklist(const char *title, 
 		case ' ':
 		case '\n':
 			if (!button) {
-				if (flag == FLAG_CHECK) {
-					status[scroll + choice] = !status[scroll + choice];
-					wmove(list, choice, check_x);
-					wattrset(list, check_selected_attr);
-					wprintw(list, "[%c]", status[scroll + choice] ? 'X' : ' ');
-				} else {
-					if (!status[scroll + choice]) {
-						for (i = 0; i < item_no; i++)
-							status[i] = 0;
-						status[scroll + choice] = 1;
-						for (i = 0; i < max_choice; i++)
-							print_item(list, items[(scroll + i) * 3 + 1],
-								   status[scroll + i], i, i == choice);
-					}
+				if (!status[scroll + choice]) {
+					for (i = 0; i < item_no; i++)
+						status[i] = 0;
+					status[scroll + choice] = 1;
+					for (i = 0; i < max_choice; i++)
+						print_item(list, items[(scroll + i) * 3 + 1],
+							   status[scroll + i], i, i == choice);
 				}
 				wnoutrefresh(list);
 				wrefresh(dialog);
 
-				for (i = 0; i < item_no; i++) {
-					if (status[i]) {
-						if (flag == FLAG_CHECK) {
-							fprintf(stderr, "\"%s\" ", items[i * 3]);
-						} else {
-							fprintf(stderr, "%s", items[i * 3]);
-						}
-
-					}
-				}
+				for (i = 0; i < item_no; i++)
+					if (status[i])
+						fprintf(stderr, "%s", items[i * 3]);
 			} else
 				fprintf(stderr, "%s", items[(scroll + choice) * 3]);
 			delwin(dialog);
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index f882204..af3cf71 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -160,7 +160,7 @@ int dialog_menu(const char *title, const
 		const char *const *items);
 int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height, int item_no,
-		     const char *const *items, int flag);
+		     const char *const *items);
 extern char dialog_input_result[];
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
@@ -175,10 +175,3 @@ int dialog_inputbox(const char *title, c
  *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
  */
 #define M_EVENT (KEY_MAX+1)
-
-/*
- * The `flag' parameter in checklist is used to select between
- * radiolist and checklist
- */
-#define FLAG_CHECK 1
-#define FLAG_RADIO 0
diff --git a/scripts/kconfig/lxdialog/lxdialog.c b/scripts/kconfig/lxdialog/lxdialog.c
index 2c34ea1..79f6c5f 100644
--- a/scripts/kconfig/lxdialog/lxdialog.c
+++ b/scripts/kconfig/lxdialog/lxdialog.c
@@ -31,12 +31,11 @@ struct Mode {
 	jumperFn *jumper;
 };
 
-jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_textbox, j_inputbox;
+jumperFn j_menu, j_radiolist, j_yesno, j_textbox, j_inputbox;
 jumperFn j_msgbox, j_infobox;
 
 static struct Mode modes[] = {
 	{"--menu", 9, 0, 3, j_menu},
-	{"--checklist", 9, 0, 3, j_checklist},
 	{"--radiolist", 9, 0, 3, j_radiolist},
 	{"--yesno", 5, 5, 1, j_yesno},
 	{"--textbox", 5, 5, 1, j_textbox},
@@ -151,7 +150,6 @@ static void Usage(const char *name)
 \nBox options:\
 \n\
 \n  --menu      <text> <height> <width> <menu height> <tag1> <item1>...\
-\n  --checklist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
 \n  --radiolist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
 \n  --textbox   <file> <height> <width>\
 \n  --inputbox  <text> <height> <width> [<init>]\
@@ -170,16 +168,10 @@ int j_menu(const char *t, int ac, const 
 			   atoi(av[5]), av[6], (ac - 6) / 2, av + 7);
 }
 
-int j_checklist(const char *t, int ac, const char *const *av)
-{
-	return dialog_checklist(t, av[2], atoi(av[3]), atoi(av[4]),
-				atoi(av[5]), (ac - 6) / 3, av + 6, FLAG_CHECK);
-}
-
 int j_radiolist(const char *t, int ac, const char *const *av)
 {
 	return dialog_checklist(t, av[2], atoi(av[3]), atoi(av[4]),
-				atoi(av[5]), (ac - 6) / 3, av + 6, FLAG_RADIO);
+				atoi(av[5]), (ac - 6) / 3, av + 6);
 }
 
 int j_textbox(const char *t, int ac, const char *const *av)
-- 
1.0.6

