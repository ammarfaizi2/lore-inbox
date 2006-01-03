Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWACNcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWACNcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWACNcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:32:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38405 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932350AbWACNZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:36 -0500
Subject: [PATCH 06/26] kconfig: Fix indention when using menuconfig in text-onle consoles
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947253568@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132524229 +0100

When using menuconfig in a text-only console (no X started)
the indention was often two spaces wrong. This proved to be a ncurses
issue which are worked around by calling wrefresh more often.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/menubox.c |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)

7c3badf96e0dc8aa89ebf8919653339a5ee8e035
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 89fcf41..461ee08 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -94,9 +94,9 @@ static void print_item(WINDOW * win, con
 	}
 	if (selected) {
 		wmove(win, choice, ITEM_IDENT + 1);
-		wrefresh(win);
 	}
 	free(menu_item);
+	wrefresh(win);
 }
 
 /*
@@ -125,6 +125,7 @@ static void print_arrows(WINDOW * win, i
 
 	y = y + height + 1;
 	wmove(win, y, x);
+	wrefresh(win);
 
 	if ((height < item_no) && (scroll + height < item_no)) {
 		wattrset(win, darrow_attr);
@@ -139,6 +140,7 @@ static void print_arrows(WINDOW * win, i
 	}
 
 	wmove(win, cur_y, cur_x);
+	wrefresh(win);
 }
 
 /*
@@ -157,6 +159,17 @@ static void print_buttons(WINDOW * win, 
 	wrefresh(win);
 }
 
+/* scroll up n lines (n may be negative) */
+static void do_scroll(WINDOW *win, int *scroll, int n)
+{
+	/* Scroll menu up */
+	scrollok(win, TRUE);
+	wscrl(win, n);
+	scrollok(win, FALSE);
+	*scroll = *scroll + n;
+	wrefresh(win);
+}
+
 /*
  * Display a menu for choosing among a number of options
  */
@@ -286,11 +299,7 @@ int dialog_menu(const char *title, const
 			if (key == KEY_UP || key == '-') {
 				if (choice < 2 && scroll) {
 					/* Scroll menu down */
-					scrollok(menu, TRUE);
-					wscrl(menu, -1);
-					scrollok(menu, FALSE);
-
-					scroll--;
+					do_scroll(menu, &scroll, -1);
 
 					print_item(menu, items[scroll * 2 + 1], 0, FALSE,
 						   (items[scroll * 2][0] != ':'));
@@ -306,11 +315,7 @@ int dialog_menu(const char *title, const
 				if ((choice > max_choice - 3) &&
 				    (scroll + max_choice < item_no)) {
 					/* Scroll menu up */
-					scrollok(menu, TRUE);
-					wscrl(menu, 1);
-					scrollok(menu, FALSE);
-
-					scroll++;
+					do_scroll(menu, &scroll, 1);
 
 					print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
 						   max_choice - 1, FALSE,
@@ -322,8 +327,7 @@ int dialog_menu(const char *title, const
 				scrollok(menu, TRUE);
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll > 0) {
-						wscrl(menu, -1);
-						scroll--;
+						do_scroll(menu, &scroll, -1);
 						print_item(menu, items[scroll * 2 + 1], 0, FALSE,
 							   (items[scroll * 2][0] != ':'));
 					} else {
@@ -331,15 +335,11 @@ int dialog_menu(const char *title, const
 							choice--;
 					}
 				}
-				scrollok(menu, FALSE);
 
 			} else if (key == KEY_NPAGE) {
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll + max_choice < item_no) {
-						scrollok(menu, TRUE);
-						wscrl(menu, 1);
-						scrollok(menu, FALSE);
-						scroll++;
+						do_scroll(menu, &scroll, 1);
 						print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
 							   max_choice - 1, FALSE,
 							   (items [(scroll + max_choice - 1) * 2][0] != ':'));
@@ -348,7 +348,6 @@ int dialog_menu(const char *title, const
 							choice++;
 					}
 				}
-
 			} else
 				choice = i;
 
-- 
1.0.6

