Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVKUWk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVKUWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKUWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:40:25 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:43798 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751195AbVKUWkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:40:21 -0500
Date: Mon, 21 Nov 2005 23:40:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [5/7] kconfig: Fix indention when using menuconfig in text-onle consoles
Message-ID: <20051121224027.GF19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: Fix indention when using menuconfig in text-onle consoles
    
    When using menuconfig in a text-only console (no X started)
    the indention was often two spaces wrong. This proved to be a ncurses
    issue which are worked around by calling wrefresh more often.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 89fcf41..461ee08 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -92,13 +92,13 @@ static void print_item(WINDOW * win, con
 		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
 		mvwaddch(win, choice, ITEM_IDENT + j, menu_item[j]);
 	}
 	if (selected) {
 		wmove(win, choice, ITEM_IDENT + 1);
-		wrefresh(win);
 	}
 	free(menu_item);
+	wrefresh(win);
 }
 
 /*
  * Print the scroll indicators.
  */
@@ -123,10 +123,11 @@ static void print_arrows(WINDOW * win, i
 		waddch(win, ACS_HLINE);
 	}
 
 	y = y + height + 1;
 	wmove(win, y, x);
+	wrefresh(win);
 
 	if ((height < item_no) && (scroll + height < item_no)) {
 		wattrset(win, darrow_attr);
 		waddch(win, ACS_DARROW);
 		waddstr(win, "(+)");
@@ -137,10 +138,11 @@ static void print_arrows(WINDOW * win, i
 		waddch(win, ACS_HLINE);
 		waddch(win, ACS_HLINE);
 	}
 
 	wmove(win, cur_y, cur_x);
+	wrefresh(win);
 }
 
 /*
  * Display the termination buttons.
  */
@@ -155,10 +157,21 @@ static void print_buttons(WINDOW * win, 
 
 	wmove(win, y, x + 1 + 12 * selected);
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
 int dialog_menu(const char *title, const char *prompt, int height, int width,
                 int menu_height, const char *current, int item_no,
@@ -284,15 +297,11 @@ int dialog_menu(const char *title, const
 				   (items[(scroll + choice) * 2][0] != ':'));
 
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
 				} else
 					choice = MAX(choice - 1, 0);
@@ -304,15 +313,11 @@ int dialog_menu(const char *title, const
 					   (items[(scroll + choice) * 2][0] != ':'));
 
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
 						   (items [(scroll + max_choice - 1) * 2][0] != ':'));
 				} else
@@ -320,37 +325,31 @@ int dialog_menu(const char *title, const
 
 			} else if (key == KEY_PPAGE) {
 				scrollok(menu, TRUE);
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll > 0) {
-						wscrl(menu, -1);
-						scroll--;
+						do_scroll(menu, &scroll, -1);
 						print_item(menu, items[scroll * 2 + 1], 0, FALSE,
 							   (items[scroll * 2][0] != ':'));
 					} else {
 						if (choice > 0)
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
 					} else {
 						if (choice + 1 < max_choice)
 							choice++;
 					}
 				}
-
 			} else
 				choice = i;
 
 			print_item(menu, items[(scroll + choice) * 2 + 1],
 				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
