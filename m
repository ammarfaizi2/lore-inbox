Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTAMDgp>; Sun, 12 Jan 2003 22:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbTAMDgp>; Sun, 12 Jan 2003 22:36:45 -0500
Received: from dp.samba.org ([66.70.73.150]:44738 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267781AbTAMDgk>;
	Sun, 12 Jan 2003 22:36:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] Fix strlen_user usage in module.c
Date: Mon, 13 Jan 2003 14:42:57 +1100
Message-Id: <20030113034530.F1ED92C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by Andi Kleen.  strlen_user *is* documented, I just made
assumptions.

Name: Fix strlen_user usage
Author: Rusty Russell
Status: Trivial

D: strlen_user returns 0 on error, not an error number, and otherwise
D: returns the length including the NUL byte.  Found by Andi Kleen.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22129-linux-2.5.55/kernel/module.c .22129-linux-2.5.55.updated/kernel/module.c
--- .22129-linux-2.5.55/kernel/module.c	2003-01-10 10:55:43.000000000 +1100
+++ .22129-linux-2.5.55.updated/kernel/module.c	2003-01-10 20:55:55.000000000 +1100
@@ -1096,17 +1096,17 @@ static struct module *load_module(void *
 	mod = (void *)sechdrs[modindex].sh_addr;
 
 	/* Now copy in args */
-	err = strlen_user(uargs);
-	if (err < 0)
+	arglen = strlen_user(uargs);
+	if (!arglen) {
+		err = -EFAULT;
 		goto free_hdr;
-	arglen = err;
-
-	args = kmalloc(arglen+1, GFP_KERNEL);
+	}
+	args = kmalloc(arglen, GFP_KERNEL);
 	if (!args) {
 		err = -ENOMEM;
 		goto free_hdr;
 	}
-	if (copy_from_user(args, uargs, arglen+1) != 0) {
+	if (copy_from_user(args, uargs, arglen) != 0) {
 		err = -EFAULT;
 		goto free_mod;
 	}
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
