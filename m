Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVKUWlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVKUWlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKUWlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:41:08 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:17925 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751199AbVKUWk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:40:58 -0500
Date: Mon, 21 Nov 2005 23:40:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [6/7] kconfig: make lxdialog/menubox.c more readable
Message-ID: <20051121224056.GG19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: make lxdialog/menubox.c more readable
    
    Utilising a small macro for print_item made wonders for readability
    for this file.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 461ee08..d0bf32b 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -62,12 +62,12 @@
 static int menu_width;
 
 /*
  * Print menu item
  */
-static void print_item(WINDOW * win, const char *item, int choice,
-		       int selected, int hotkey)
+static void do_print_item(WINDOW * win, const char *item, int choice,
+                          int selected, int hotkey)
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width);
@@ -97,10 +97,16 @@ static void print_item(WINDOW * win, con
 	}
 	free(menu_item);
 	wrefresh(win);
 }
 
+#define print_item(index, choice, selected) \
+do {\
+	int hotkey = (items[(index) * 2][0] != ':'); \
+	do_print_item(menu, items[(index) * 2 + 1], choice, selected, hotkey); \
+} while (0)
+
 /*
  * Print the scroll indicators.
  */
 static void print_arrows(WINDOW * win, int item_no, int scroll, int y, int x,
 			 int height)
@@ -249,13 +255,11 @@ int dialog_menu(const char *title, const
 		choice = choice - scroll;
 	}
 
 	/* Print the menu */
 	for (i = 0; i < max_choice; i++) {
-		print_item(menu, items[(first_item + i) * 2 + 1], i,
-			   i == choice,
-			   (items[(first_item + i) * 2][0] != ':'));
+		print_item(first_item + i, i, i == choice);
 	}
 
 	wnoutrefresh(menu);
 
 	print_arrows(dialog, item_no, scroll,
@@ -290,71 +294,61 @@ int dialog_menu(const char *title, const
 		if (i < max_choice ||
 		    key == KEY_UP || key == KEY_DOWN ||
 		    key == '-' || key == '+' ||
 		    key == KEY_PPAGE || key == KEY_NPAGE) {
 			/* Remove highligt of current item */
-			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, FALSE,
-				   (items[(scroll + choice) * 2][0] != ':'));
+			print_item(scroll + choice, choice, FALSE);
 
 			if (key == KEY_UP || key == '-') {
 				if (choice < 2 && scroll) {
 					/* Scroll menu down */
 					do_scroll(menu, &scroll, -1);
 
-					print_item(menu, items[scroll * 2 + 1], 0, FALSE,
-						   (items[scroll * 2][0] != ':'));
+					print_item(scroll, 0, FALSE);
 				} else
 					choice = MAX(choice - 1, 0);
 
 			} else if (key == KEY_DOWN || key == '+') {
-
-				print_item(menu,
-					   items[(scroll + choice) * 2 + 1], choice, FALSE,
-					   (items[(scroll + choice) * 2][0] != ':'));
+				print_item(scroll+choice, choice, FALSE);
 
 				if ((choice > max_choice - 3) &&
 				    (scroll + max_choice < item_no)) {
 					/* Scroll menu up */
 					do_scroll(menu, &scroll, 1);
 
-					print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
-						   max_choice - 1, FALSE,
-						   (items [(scroll + max_choice - 1) * 2][0] != ':'));
+					print_item(scroll+max_choice - 1,
+						   max_choice - 1, FALSE);
 				} else
 					choice = MIN(choice + 1, max_choice - 1);
 
 			} else if (key == KEY_PPAGE) {
 				scrollok(menu, TRUE);
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll > 0) {
 						do_scroll(menu, &scroll, -1);
-						print_item(menu, items[scroll * 2 + 1], 0, FALSE,
-							   (items[scroll * 2][0] != ':'));
+						print_item(scroll, 0, FALSE);
 					} else {
 						if (choice > 0)
 							choice--;
 					}
 				}
 
 			} else if (key == KEY_NPAGE) {
 				for (i = 0; (i < max_choice); i++) {
 					if (scroll + max_choice < item_no) {
 						do_scroll(menu, &scroll, 1);
-						print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
-							   max_choice - 1, FALSE,
-							   (items [(scroll + max_choice - 1) * 2][0] != ':'));
+						print_item(scroll+max_choice-1,
+							   max_choice - 1, FALSE);
 					} else {
 						if (choice + 1 < max_choice)
 							choice++;
 					}
 				}
 			} else
 				choice = i;
 
-			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
+			print_item(scroll + choice, choice, TRUE);
 
 			print_arrows(dialog, item_no, scroll,
 				     box_y, box_x + ITEM_IDENT + 1, menu_height);
 
 			wnoutrefresh(dialog);
