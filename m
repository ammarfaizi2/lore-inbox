Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSKFOMH>; Wed, 6 Nov 2002 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265347AbSKFOMH>; Wed, 6 Nov 2002 09:12:07 -0500
Received: from pasky.ji.cz ([62.44.12.54]:59124 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265339AbSKFOMA>;
	Wed, 6 Nov 2002 09:12:00 -0500
Date: Wed, 6 Nov 2002 15:18:36 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [kconfig] Single-menu mode support for make menuconfig II.
Message-ID: <20021106141836.GA5219@pasky.ji.cz>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20021103211632.GB20338@pasky.ji.cz> <Pine.LNX.4.44.0211061359000.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061359000.6949-100000@serv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Nov 06, 2002 at 02:11:24PM CET, I got a letter,
where Roman Zippel <zippel@linux-m68k.org> told me, that...
> Hi,

  Hello,

> > diff -ru linux/scripts/kconfig/expr.h linux+pasky/scripts/kconfig/expr.h
> > --- linux/scripts/kconfig/expr.h	Sun Nov  3 15:24:01 2002
> > +++ linux+pasky/scripts/kconfig/expr.h	Sun Nov  3 15:00:17 2002
> > @@ -169,6 +169,7 @@
> >  	//char *help;
> >  	struct file *file;
> >  	int lineno;
> > +	int expanded; /* solely for frontend use */
> >  	//void *data;
> >  };
> 
> The menu structure is mostly readonly, if front ends need to store 
> something there, I'd rather reactivate the data field (which was meant for 
> this, but it's currently not used).

  Done. It's a little dirty to use it as a boolean, but I'll rather leave the
work with allocation of the stuff etc to the next one who will want to attach
something to the structure, or I will make another patch cleaning that later.

> > @@ -682,6 +699,9 @@
> >  int main(int ac, char **av)
> >  {
> >  	int stat;
> > +
> > +	single_menu_mode = !!getenv("SINGLE_MENU");
> > +
> >  	conf_parse(av[1]);
> >  	conf_read(NULL);
> >  
> 
> Could you give it a different name (MENUCONFIG_MODE?) and check it 
> contents instead of just testing for existence?

  Done.

> > diff -ru linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
> > --- linux/scripts/lxdialog/util.c	Sun Nov  3 15:24:21 2002
> > +++ linux+pasky/scripts/lxdialog/util.c	Sun Nov  3 15:11:44 2002
> > @@ -348,7 +348,7 @@
> >  		c = tolower(string[i]);
> >  
> >  		if (strchr("<[(", c)) ++in_paren;
> > -		if (strchr(">])", c)) --in_paren;
> > +		if (strchr(">])", c) && in_paren > 0) --in_paren;
> >  
> >  		if ((! in_paren) && isalpha(c) && 
> >  		     strchr(exempt, c) == 0)
> 
> What's this needed for?

  We use "-->" and "++>" as a prefix of the categories. Thus, in_parent will
underflow under zero here, thus the condition below will go mad. With this
change, we will change the counter only when we are inside of parenthesis
already.

  This is version 2 of the patch - the only changes are based on remarks by
Roman.  Please apply.

  BTW, I have some more patches almost ready for submission which conflict with
this patch. Should I make them against vanilla tree or against the tree patched
by this patch?

 scripts/README.Menuconfig |   19 +++++++++++++------
 scripts/kconfig/expr.h    |    2 +-
 scripts/kconfig/mconf.c   |   35 +++++++++++++++++++++++++++++++----
 scripts/lxdialog/util.c   |    2 +-
 4 files changed, 46 insertions(+), 12 deletions(-)

  Kind regards,
                                Petr Baudis

diff -ruN linux/scripts/README.Menuconfig linux+pasky/scripts/README.Menuconfig
--- linux/scripts/README.Menuconfig	Sun Nov  3 15:23:43 2002
+++ linux+pasky/scripts/README.Menuconfig	Wed Nov  6 15:01:42 2002
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
@@ -172,11 +173,17 @@
 ******** IMPORTANT, OPTIONAL ALTERNATE PERSONALITY AVAILABLE ********
 ********                                                     ********
 If you prefer to have all of the kernel options listed in a single
-menu, rather than the default multimenu hierarchy, you may edit the
-Menuconfig script and change the line "single_menu_mode="  to 
-"single_menu_mode=TRUE".
+menu, rather than the default multimenu hierarchy, run the menuconfig
+with MENUCONFIG_MODE environment variable set to single_menu. Example:
 
-This mode is not recommended unless you have a fairly fast machine.
+make menuconfig MENUCONFIG_MODE=single_menu
+
+<Enter> will then unroll the appropriate category, or enfold it if it
+is already unrolled.
+
+Note that this mode can eventually be a little more CPU expensive
+(especially with a larger number of unrolled categories) than the
+default mode.
 *********************************************************************
 
 
diff -ruN linux/scripts/kconfig/expr.h linux+pasky/scripts/kconfig/expr.h
--- linux/scripts/kconfig/expr.h	Sun Nov  3 15:24:01 2002
+++ linux+pasky/scripts/kconfig/expr.h	Wed Nov  6 14:53:34 2002
@@ -169,7 +169,7 @@
 	//char *help;
 	struct file *file;
 	int lineno;
-	//void *data;
+	void *data;
 };
 
 #ifndef SWIG
diff -ruN linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
--- linux/scripts/lxdialog/util.c	Tue Nov  5 22:13:49 2002
+++ linux+pasky/scripts/lxdialog/util.c	Wed Nov  6 14:53:14 2002
@@ -348,7 +348,7 @@
 		c = tolower(string[i]);
 
 		if (strchr("<[(", c)) ++in_paren;
-		if (strchr(">])", c)) --in_paren;
+		if (strchr(">])", c) && in_paren > 0) --in_paren;
 
 		if ((! in_paren) && isalpha(c) && 
 		     strchr(exempt, c) == 0)
diff -ruN linux/scripts/kconfig/mconf.c linux+pasky/scripts/kconfig/mconf.c
--- linux/scripts/kconfig/mconf.c	Tue Nov  5 22:13:49 2002
+++ linux+pasky/scripts/kconfig/mconf.c	Wed Nov  6 15:05:21 2002
@@ -1,8 +1,14 @@
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
+ *
+ * Introduced single menu mode (show all sub-menus in one large tree).
+ * 2002-11-06 Petr Baudis <pasky@ucw.cz>
  */
 
+/* Warning: we now use menu->data only as a boolean indicating whether the
+ * sub-menu is expanded or not (relevant for single_menu_mode). */
+
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <ctype.h>
@@ -84,6 +90,7 @@
 static struct menu *current_menu;
 static int child_count;
 static int do_resize;
+static int single_menu_mode;
 
 static void conf(struct menu *menu);
 static void conf_choice(struct menu *menu);
@@ -274,10 +281,20 @@
 			case P_MENU:
 				child_count++;
 				cprint("m%p", menu);
-				if (menu->parent != &rootmenu)
-					cprint1("   %*c", indent + 1, ' ');
-				cprint1("%s  --->", prompt);
+
+				if (single_menu_mode) {
+					cprint1("%s%*c%s",
+						menu->data ? "-->" : "++>",
+						indent + 1, ' ', prompt);
+				} else {
+					if (menu->parent != &rootmenu)
+						cprint1("   %*c", indent + 1, ' ');
+					cprint1("%s  --->", prompt);
+				}
+
 				cprint_done();
+				if (single_menu_mode && menu->data)
+					goto conf_childs;
 				return;
 			default:
 				if (prompt) {
@@ -442,7 +459,10 @@
 		case 0:
 			switch (type) {
 			case 'm':
-				conf(submenu);
+				if (single_menu_mode)
+					submenu->data = (void *) !submenu->data;
+				else
+					conf(submenu);
 				break;
 			case 't':
 				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
@@ -681,7 +701,14 @@
 
 int main(int ac, char **av)
 {
+	char *menuconfig_mode = getenv("MENUCONFIG_MODE");
 	int stat;
+
+	if (menuconfig_mode) {
+		if (!strcasecmp(menuconfig_mode, "single_menu"))
+			single_menu_mode = 1;
+	}
+
 	conf_parse(av[1]);
 	conf_read(NULL);
 
