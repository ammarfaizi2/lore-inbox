Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSKCVKD>; Sun, 3 Nov 2002 16:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbSKCVKD>; Sun, 3 Nov 2002 16:10:03 -0500
Received: from pasky.ji.cz ([62.44.12.54]:14071 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262662AbSKCVKA>;
	Sun, 3 Nov 2002 16:10:00 -0500
Date: Sun, 3 Nov 2002 22:16:32 +0100
From: Petr Baudis <pasky@ucw.cz>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [kconfig] Single-menu mode support for make menuconfig
Message-ID: <20021103211632.GB20338@pasky.ji.cz>
Mail-Followup-To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.45) brings the single_menu_mode option from the old
Menuconfig script to the new kconfig. Contrary to the original script, now you
select the mconf behaviour by passing a special environment variable
(SINGLE_MENU) to it. For example, make menuconfig SINGLE_MENU=1.

  With this mode, when you enter a category, no new menu is open, but the
category is unrolled to the current menu, thus the whole configuration is
forming one single tree. Some users prefer this as a form of configuration, as
they consider it easier to take in than the classical behaviour.

 scripts/kconfig/expr.h  |    1 +
 scripts/kconfig/mconf.c |   28 ++++++++++++++++++++++++----
 scripts/lxdialog/util.c |    2 +-
 3 files changed, 26 insertions(+), 5 deletions(-)

  Kind regards,
				Petr Baudis

diff -ru linux/scripts/kconfig/expr.h linux+pasky/scripts/kconfig/expr.h
--- linux/scripts/kconfig/expr.h	Sun Nov  3 15:24:01 2002
+++ linux+pasky/scripts/kconfig/expr.h	Sun Nov  3 15:00:17 2002
@@ -169,6 +169,7 @@
 	//char *help;
 	struct file *file;
 	int lineno;
+	int expanded; /* solely for frontend use */
 	//void *data;
 };
 
diff -ru linux/scripts/kconfig/mconf.c linux+pasky/scripts/kconfig/mconf.c
--- linux/scripts/kconfig/mconf.c	Sun Nov  3 15:24:08 2002
+++ linux+pasky/scripts/kconfig/mconf.c	Sun Nov  3 15:12:27 2002
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
+ *
+ * Introduced single_menu_mode (show all sub-menus in one large tree).
+ * 2002-11-03 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <sys/ioctl.h>
@@ -84,6 +87,7 @@
 static struct menu *current_menu;
 static int child_count;
 static int do_resize;
+static int single_menu_mode;
 
 static void conf(struct menu *menu);
 static void conf_choice(struct menu *menu);
@@ -274,10 +278,20 @@
 			case P_MENU:
 				child_count++;
 				cprint("m%p", menu);
-				if (menu->parent != &rootmenu)
-					cprint1("   %*c", indent + 1, ' ');
-				cprint1("%s  --->", prompt);
+
+				if (single_menu_mode) {
+					cprint1("%s%*c%s",
+						menu->expanded ? "-->" : "++>",
+						indent + 1, ' ', prompt);
+				} else {
+					if (menu->parent != &rootmenu)
+						cprint1("   %*c", indent + 1, ' ');
+					cprint1("%s  --->", prompt);
+				}
+
 				cprint_done();
+				if (single_menu_mode && menu->expanded)
+					goto conf_childs;
 				return;
 			default:
 				if (prompt) {
@@ -442,7 +456,10 @@
 		case 0:
 			switch (type) {
 			case 'm':
-				conf(submenu);
+				if (single_menu_mode)
+					submenu->expanded = !submenu->expanded;
+				else
+					conf(submenu);
 				break;
 			case 't':
 				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
@@ -682,6 +699,9 @@
 int main(int ac, char **av)
 {
 	int stat;
+
+	single_menu_mode = !!getenv("SINGLE_MENU");
+
 	conf_parse(av[1]);
 	conf_read(NULL);
 
diff -ru linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
--- linux/scripts/lxdialog/util.c	Sun Nov  3 15:24:21 2002
+++ linux+pasky/scripts/lxdialog/util.c	Sun Nov  3 15:11:44 2002
@@ -348,7 +348,7 @@
 		c = tolower(string[i]);
 
 		if (strchr("<[(", c)) ++in_paren;
-		if (strchr(">])", c)) --in_paren;
+		if (strchr(">])", c) && in_paren > 0) --in_paren;
 
 		if ((! in_paren) && isalpha(c) && 
 		     strchr(exempt, c) == 0)
--- linux/scripts/README.Menuconfig	Sun Nov  3 15:23:43 2002
+++ linux+pasky/scripts/README.Menuconfig	Sun Nov  3 21:34:56 2002
@@ -1,7 +1,8 @@
 Menuconfig gives the Linux kernel configuration a long needed face
 lift.  Featuring text based color menus and dialogs, it does not
-require X Windows.  With this utility you can easily select a kernel
-option to modify without sifting through 100 other options.
+require X Windows (however, you need ncurses in order to use it).
+With this utility you can easily select a kernel option to modify
+without sifting through 100 other options.
 
 Overview
 --------
@@ -172,11 +173,16 @@
 ******** IMPORTANT, OPTIONAL ALTERNATE PERSONALITY AVAILABLE ********
 ********                                                     ********
 If you prefer to have all of the kernel options listed in a single
-menu, rather than the default multimenu hierarchy, you may edit the
-Menuconfig script and change the line "single_menu_mode="  to 
-"single_menu_mode=TRUE".
+menu, rather than the default multimenu hierarchy, run the menuconfig
+with SINGLE_MENU environment variable set. Example:
 
-This mode is not recommended unless you have a fairly fast machine.
+make menuconfig SINGLE_MENU=1
+
+<Enter> will then unroll the appropriate category, or enfold it if it
+is already unrolled.
+
+Note that this mode is a little more CPU expensive (especially with
+a larger number of unrolled categories) than the default mode.
 *********************************************************************
 
 
