Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTAGGYI>; Tue, 7 Jan 2003 01:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTAGGYI>; Tue, 7 Jan 2003 01:24:08 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:8897 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267311AbTAGGYH>; Tue, 7 Jan 2003 01:24:07 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH]  Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030107063239.F1ED73745@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  7 Jan 2003 15:32:39 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since these are just symbols in the module object, they need symbol name
munging to find the symbol from the parameter name.

[I guess using the stack is bad in general, but parameter names should be
very short, and hey if they're obsolete, it seems pointless to spend
much effort.]

diff -ruN -X../cludes linux-2.5.54-moo.orig/kernel/module.c linux-2.5.54-moo/kernel/module.c
--- linux-2.5.54-moo.orig/kernel/module.c	2003-01-06 10:51:20.000000000 +0900
+++ linux-2.5.54-moo/kernel/module.c	2003-01-07 14:31:53.000000000 +0900
@@ -666,13 +666,18 @@
 		       num, obsparm[i].name, obsparm[i].type);
 
 	for (i = 0; i < num; i++) {
+		char sym_name[strlen (obsparm[i].name) + 2];
+
+		strcpy (sym_name, MODULE_SYMBOL_PREFIX);
+		strcat (sym_name, obsparm[i].name);
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
