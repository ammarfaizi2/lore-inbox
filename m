Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTESVCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTESVCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:02:24 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57093 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262883AbTESVCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:02:22 -0400
Date: Mon, 19 May 2003 23:15:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk1[23] kconfig loop
In-Reply-To: <200305191821.h4JILlE12026@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0305192254330.12110-100000@serv>
References: <200305191821.h4JILlE12026@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 May 2003, Adam J. Richter wrote:

>         I expect there is no input that is supposed to cause
> "make oldconfig" to go into an infinite loop, so this must at
> least be a kconfig bug.

Yes, it is, conf should not restart the configuration if the symbol isn't 
changeable. The patch below fixes this and also fixes another possible 
problem with menuconfig.

bye, Roman

--- linux-2.5.69-bk13/scripts/kconfig/conf.c	16 Dec 2002 19:40:13 -0000
+++ linux-2.5.69-bk13/scripts/kconfig/conf.c	19 May 2003 20:36:28 -0000
@@ -456,29 +456,17 @@ static void check_conf(struct menu *menu
 		return;
 
 	sym = menu->sym;
-	if (!sym)
-		goto conf_childs;
-
-	if (sym_is_choice(sym)) {
-		if (!sym_has_value(sym)) {
+	if (sym) {
+		if (sym_is_changable(sym) && !sym_has_value(sym)) {
 			if (!conf_cnt++)
 				printf("*\n* Restart config...\n*\n");
 			rootEntry = menu_get_parent_menu(menu);
 			conf(rootEntry);
 		}
-		if (sym_get_tristate_value(sym) != mod)
+		if (sym_is_choice(sym) && sym_get_tristate_value(sym) != mod)
 			return;
-		goto conf_childs;
-	}
-
-	if (!sym_has_value(sym)) {
-		if (!conf_cnt++)
-			printf("*\n* Restart config...\n*\n");
-		rootEntry = menu_get_parent_menu(menu);
-		conf(rootEntry);
 	}
 
-conf_childs:
 	for (child = menu->list; child; child = child->next)
 		check_conf(child);
 }
--- linux-2.5.69-bk13/scripts/kconfig/menu.c	17 Mar 2003 23:01:29 -0000
+++ linux-2.5.69-bk13/scripts/kconfig/menu.c	18 May 2003 22:27:39 -0000
@@ -283,8 +283,7 @@ struct menu *menu_get_parent_menu(struct
 {
 	enum prop_type type;
 
-	while (menu != &rootmenu) {
-		menu = menu->parent;
+	for (; menu != &rootmenu; menu = menu->parent) {
 		type = menu->prompt ? menu->prompt->type : 0;
 		if (type == P_MENU || type == P_ROOTMENU)
 			break;


