Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTAJHZt>; Fri, 10 Jan 2003 02:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAJHYs>; Fri, 10 Jan 2003 02:24:48 -0500
Received: from dp.samba.org ([66.70.73.150]:3820 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263342AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty 
In-reply-to: Your message of "Tue, 07 Jan 2003 15:32:39 +0900."
             <20030107063239.F1ED73745@mcspd15.ucom.lsi.nec.co.jp> 
Date: Wed, 08 Jan 2003 22:56:51 +1100
Message-Id: <20030110073328.D41A52C310@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030107063239.F1ED73745@mcspd15.ucom.lsi.nec.co.jp> you write:
> Since these are just symbols in the module object, they need symbol name
> munging to find the symbol from the parameter name.

Good point.  Linus, please apply.

> [I guess using the stack is bad in general, but parameter names should be
> very short, and hey if they're obsolete, it seems pointless to spend
> much effort.]

Should be fine here.  I removed the spaces between the funcname and
the brackets tho.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Make obsolete module parameters work with MODULE_SYMBOL_PREFIX
Author: Miles Bader
Status: Trivial

D: Since these are just symbols in the module object, they need symbol name
D: munging to find the symbol from the parameter name.

diff -ruN -X../cludes linux-2.5.54-moo.orig/kernel/module.c linux-2.5.54-moo/kernel/module.c
--- linux-2.5.54-moo.orig/kernel/module.c	2003-01-06 10:51:20.000000000 +0900
+++ linux-2.5.54-moo/kernel/module.c	2003-01-07 14:31:53.000000000 +0900
@@ -666,13 +666,18 @@
 		       num, obsparm[i].name, obsparm[i].type);
 
 	for (i = 0; i < num; i++) {
+		char sym_name[strlen(obsparm[i].name) + 2];
+
+		strcpy(sym_name, MODULE_SYMBOL_PREFIX);
+		strcat(sym_name, obsparm[i].name);
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
