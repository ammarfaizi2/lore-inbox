Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTAMDgm>; Sun, 12 Jan 2003 22:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbTAMDgm>; Sun, 12 Jan 2003 22:36:42 -0500
Received: from dp.samba.org ([66.70.73.150]:43970 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267778AbTAMDgk>;
	Sun, 12 Jan 2003 22:36:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Miles Bader <miles@gnu.org>
Subject: [PATCH] v850 obsolete params fix
Date: Mon, 13 Jan 2003 14:39:26 +1100
Message-Id: <20030113034530.E9DC22C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  No variable arrays anywhere.

Rusty.

Name: Make obsolete module parameters work with MODULE_SYMBOL_PREFIX
Author: Rusty Russell, Miles Bader
Status: Trivial

D: Since these are just symbols in the module object, they need symbol name
D: munging to find the symbol from the parameter name.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-obsparm-symprefix/kernel/module.c
--- linux-2.5-bk/kernel/module.c	Fri Jan 10 10:55:43 2003
+++ working-2.5-bk-obsparm-symprefix/kernel/module.c	Mon Jan 13 14:35:01 2003
@@ -679,19 +679,19 @@ static int obsolete_params(const char *n
 	if (!kp)
 		return -ENOMEM;
 
-	DEBUGP("Module %s has %u obsolete params\n", name, num);
-	for (i = 0; i < num; i++)
-		DEBUGP("Param %i: %s type %s\n",
-		       num, obsparm[i].name, obsparm[i].type);
-
 	for (i = 0; i < num; i++) {
+		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
+
+		snprintf(sym_name, sizeof(sym_name), "%s%s",
+			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
+
 		kp[i].name = obsparm[i].name;
 		kp[i].perm = 000;
 		kp[i].set = set_obsolete;
 		kp[i].get = NULL;
 		obsparm[i].addr
 			= (void *)find_local_symbol(sechdrs, symindex, strtab,
-						    obsparm[i].name);
+						    sym_name);
 		if (!obsparm[i].addr) {
 			printk("%s: falsely claims to have parameter %s\n",
 			       name, obsparm[i].name);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
