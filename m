Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTAIJmD>; Thu, 9 Jan 2003 04:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTAIJlp>; Thu, 9 Jan 2003 04:41:45 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35800 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262500AbTAIJko>; Thu, 9 Jan 2003 04:40:44 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH]  Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094923.46A933745@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:49:23 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since these are just symbols in the module object, they need symbol name
munging to find the symbol from the parameter name.

[I guess using the stack is bad in general, but parameter names should be
very short, and hey if they're obsolete, it seems pointless to spend
much effort.]

diff -ruN -X../cludes linux-2.5.55-moo.orig/kernel/module.c linux-2.5.55-moo/kernel/module.c
--- linux-2.5.55-moo.orig/kernel/module.c	2003-01-09 13:44:25.000000000 +0900
+++ linux-2.5.55-moo/kernel/module.c	2003-01-09 14:07:36.000000000 +0900
@@ -685,13 +685,18 @@
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
