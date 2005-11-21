Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVKUWjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVKUWjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKUWju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:39:50 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:30328 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751195AbVKUWjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:39:47 -0500
Date: Mon, 21 Nov 2005 23:39:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [4/7] kconfig: Left aling menu items in menuconfig
Message-ID: <20051121223953.GE19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: Left aling menu items in menuconfig
    
    Keeping menu lines on a fixed position creates less visual
    noise when navigating the menus.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index ebfe6a3..89fcf41 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -56,11 +56,12 @@
  * fscanf would read in 'scroll', and eventually that value would get used.
  */
 
 #include "dialog.h"
 
-static int menu_width, item_x;
+#define ITEM_IDENT 4   /* Indent of menu entries. Fixed for all menus */
+static int menu_width;
 
 /*
  * Print menu item
  */
 static void print_item(WINDOW * win, const char *item, int choice,
@@ -84,17 +85,17 @@ static void print_item(WINDOW * win, con
 	}
 #else
 	wclrtoeol(win);
 #endif
 	wattrset(win, selected ? item_selected_attr : item_attr);
-	mvwaddstr(win, choice, item_x, menu_item);
+	mvwaddstr(win, choice, ITEM_IDENT, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
-		mvwaddch(win, choice, item_x + j, menu_item[j]);
+		mvwaddch(win, choice, ITEM_IDENT + j, menu_item[j]);
 	}
 	if (selected) {
-		wmove(win, choice, item_x + 1);
+		wmove(win, choice, ITEM_IDENT + 1);
 		wrefresh(win);
 	}
 	free(menu_item);
 }
 
@@ -205,23 +206,14 @@ int dialog_menu(const char *title, const
 
 	/* draw a box around the menu items */
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 menubox_border_attr, menubox_attr);
 
-	/*
-	 * Find length of longest item in order to center menu.
-	 * Set 'choice' to default item.
-	 */
-	item_x = 0;
-	for (i = 0; i < item_no; i++) {
-		item_x =
-		    MAX(item_x, MIN(menu_width, strlen(items[i * 2 + 1]) + 2));
+	/* Set choice to default item */
+	for (i = 0; i < item_no; i++)
 		if (strcmp(current, items[i * 2]) == 0)
 			choice = i;
-	}
-
-	item_x = (menu_width - item_x) / 2;
 
 	/* get the scroll info from the temp file */
 	if ((f = fopen("lxdialog.scrltmp", "r")) != NULL) {
 		if ((fscanf(f, "%d\n", &scroll) == 1) && (scroll <= choice) &&
 		    (scroll + max_choice > choice) && (scroll >= 0) &&
@@ -252,14 +244,14 @@ int dialog_menu(const char *title, const
 	}
 
 	wnoutrefresh(menu);
 
 	print_arrows(dialog, item_no, scroll,
-		     box_y, box_x + item_x + 1, menu_height);
+		     box_y, box_x + ITEM_IDENT + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
-	wmove(menu, choice, item_x + 1);
+	wmove(menu, choice, ITEM_IDENT + 1);
 	wrefresh(menu);
 
 	while (key != ESC) {
 		key = wgetch(menu);
 
@@ -284,11 +276,11 @@ int dialog_menu(const char *title, const
 
 		if (i < max_choice ||
 		    key == KEY_UP || key == KEY_DOWN ||
 		    key == '-' || key == '+' ||
 		    key == KEY_PPAGE || key == KEY_NPAGE) {
-
+			/* Remove highligt of current item */
 			print_item(menu, items[(scroll + choice) * 2 + 1],
 				   choice, FALSE,
 				   (items[(scroll + choice) * 2][0] != ':'));
 
 			if (key == KEY_UP || key == '-') {
@@ -362,11 +354,11 @@ int dialog_menu(const char *title, const
 
 			print_item(menu, items[(scroll + choice) * 2 + 1],
 				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
 
 			print_arrows(dialog, item_no, scroll,
-				     box_y, box_x + item_x + 1, menu_height);
+				     box_y, box_x + ITEM_IDENT + 1, menu_height);
 
 			wnoutrefresh(dialog);
 			wrefresh(menu);
 
 			continue;	/* wait for another key press */
