Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUHNHrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUHNHrk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHNHrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:47:39 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:62981 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266195AbUHNHrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:47:32 -0400
Date: Sat, 14 Aug 2004 09:49:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040814074953.GA20123@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408120027330.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 01:05:47AM +0200, Roman Zippel wrote:
 
> > It would be nice in menuconfig to see what config symbol
> > that has dependencies and/or side effects. 
> 
> xconfig has something like this, if you enable 'Debug Info', although it 
> rather dumps the internal representation.
> Adding something like this to menuconfig, would mean hacking lxdialog, 
> which is rather at the bottom of the list of things I want to do. :)

Did a quick hack on this.
When choosing help on "HCI BlueFRITZ! USB driver" menuconfig now displays:

-------------------------------------------------
Depends on (select to enable this option):
BT & USB
Selects (will be enabled by this option): 
FW_LOADER

CONFIG_BT_HCIBFUSB

Bluetooth HCI BlueFRITZ! USB driver.
....
-------------------------------------------------

To simplify things I just malloc'ed 'enough' memory for the help screen.
Just a quick hack, but something to play with - and no lxdialog hacking :-)

	Sam

===== scripts/kconfig/expr.c 1.5 vs edited =====
--- 1.5/scripts/kconfig/expr.c	2004-03-19 07:04:54 +01:00
+++ edited/scripts/kconfig/expr.c	2004-08-14 09:20:04 +02:00
@@ -1087,3 +1087,42 @@
 {
 	expr_print(e, expr_print_file_helper, out, E_NONE);
 }
+
+void expr_get_dep_txt(struct expr *e, char *t)
+{
+	if (!e)
+		return;
+
+	switch (e->type) {
+	case E_SYMBOL:
+		strcat(t, e->left.sym->name);
+		break;
+	case E_AND:
+		expr_get_dep_txt(e->left.expr, t);
+		strcat(t, " & ");
+		expr_get_dep_txt(e->right.expr, t);
+		break;
+	case E_OR:
+		expr_get_dep_txt(e->left.expr, t);
+		strcat(t, " | ");
+		expr_get_dep_txt(e->right.expr, t);
+		break;
+	case E_NOT:
+		strcat(t, " !");
+		expr_get_dep_txt(e->left.expr, t);
+		break;
+	case E_EQUAL:
+		expr_get_dep_txt(e->left.expr, t);
+		strcat(t, " == ");
+		expr_get_dep_txt(e->right.expr, t);
+		break;
+	case E_UNEQUAL:
+		expr_get_dep_txt(e->left.expr, t);
+		strcat(t, " != ");
+		expr_get_dep_txt(e->right.expr, t);
+		break;
+	default:
+		printf("expr_calc_value: %d?\n", e->type);
+		break;
+	}
+}
===== scripts/kconfig/expr.h 1.11 vs edited =====
--- 1.11/scripts/kconfig/expr.h	2004-03-19 07:04:54 +01:00
+++ edited/scripts/kconfig/expr.h	2004-08-14 09:18:15 +02:00
@@ -174,6 +174,7 @@
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
 
 void expr_fprint(struct expr *e, FILE *out);
+void expr_get_dep_txt(struct expr *e, char *t);
 
 static inline int expr_is_yes(struct expr *e)
 {
===== scripts/kconfig/lkc_proto.h 1.3 vs edited =====
--- 1.3/scripts/kconfig/lkc_proto.h	2003-05-28 22:46:41 +02:00
+++ edited/scripts/kconfig/lkc_proto.h	2004-08-14 09:01:55 +02:00
@@ -9,6 +9,8 @@
 
 P(menu_is_visible,bool,(struct menu *menu));
 P(menu_get_prompt,const char *,(struct menu *menu));
+P(menu_get_dep_txt,void,(struct menu *menu, char *t));
+P(menu_get_select_txt,void,(struct menu *menu, char *t));
 P(menu_get_root_menu,struct menu *,(struct menu *menu));
 P(menu_get_parent_menu,struct menu *,(struct menu *menu));
 
===== scripts/kconfig/mconf.c 1.12 vs edited =====
--- 1.12/scripts/kconfig/mconf.c	2004-07-14 17:47:52 +02:00
+++ edited/scripts/kconfig/mconf.c	2004-08-14 09:23:13 +02:00
@@ -572,19 +572,29 @@
 static void show_help(struct menu *menu)
 {
 	const char *help;
-	char *helptext;
+	char *helptext = malloc(20000); /* Enough.. */
 	struct symbol *sym = menu->sym;
 
+	*helptext = '\0';
+	strcat(helptext, "Depends on (select to enable this option):\n");
+	menu_get_dep_txt(menu, helptext);
+	strcat(helptext, "\nSelects (will be enabled by this option):\n");
+	menu_get_select_txt(menu, helptext);
+	
 	help = sym->help;
 	if (!help)
 		help = nohelp_text;
 	if (sym->name) {
-		helptext = malloc(strlen(sym->name) + strlen(help) + 16);
-		sprintf(helptext, "CONFIG_%s:\n\n%s", sym->name, help);
-		show_helptext(menu_get_prompt(menu), helptext);
-		free(helptext);
-	} else
-		show_helptext(menu_get_prompt(menu), help);
+		strcat(helptext, "\n\nCONFIG_");
+		strcat(helptext, sym->name);
+		strcat(helptext, "\n\n");
+		strcat(helptext, help);
+	} else {
+		strcat(helptext, "\n\n");
+		strcat(helptext, help);
+	}
+	show_helptext(menu_get_prompt(menu), helptext);
+	free(helptext);
 }
 
 static void show_readme(void)
===== scripts/kconfig/menu.c 1.12 vs edited =====
--- 1.12/scripts/kconfig/menu.c	2004-02-04 06:31:11 +01:00
+++ edited/scripts/kconfig/menu.c	2004-08-14 09:37:28 +02:00
@@ -372,6 +372,26 @@
 	return NULL;
 }
 
+void menu_get_dep_txt(struct menu *menu, char *t)
+{
+	if (menu->dep)
+		expr_get_dep_txt(menu->dep, t);
+	if (menu->sym && menu->sym->dep)
+		expr_get_dep_txt(menu->sym->dep, t);
+}
+
+void menu_get_select_txt(struct menu *menu, char *t)
+{
+	if (menu->sym)
+	{
+		struct property *prop;
+		for_all_properties(menu->sym, prop, P_SELECT)
+		{
+			expr_get_dep_txt(prop->expr, t);
+		}
+	}
+}
+
 struct menu *menu_get_root_menu(struct menu *menu)
 {
 	return &rootmenu;
