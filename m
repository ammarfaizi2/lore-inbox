Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSL0IlT>; Fri, 27 Dec 2002 03:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSL0IlT>; Fri, 27 Dec 2002 03:41:19 -0500
Received: from dp.samba.org ([66.70.73.150]:14568 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264853AbSL0IlS>;
	Fri, 27 Dec 2002 03:41:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Overzealous permenant mark removed
Date: Fri, 27 Dec 2002 19:44:41 +1100
Message-Id: <20021227084936.1DCBD2C10B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Name: Modules without init functions don't need exit functions
Author: Rusty Russell
Status: Trivial

D: If modules don't use module_exit(), they cannot be unloaded.  This
D: safety mechanism should not apply for modules which don't use
D: module_init() (implying they have nothing to clean up anyway).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/kernel/module.c working-2.5.52-noexit/kernel/module.c
--- linux-2.5.52/kernel/module.c	Tue Dec 17 08:11:03 2002
+++ working-2.5.52-noexit/kernel/module.c	Mon Dec 23 11:26:36 2002
@@ -405,7 +405,8 @@ sys_delete_module(const char *name_user,
 		}
 	}
 
-	if (!mod->exit || mod->unsafe) {
+	/* If it has an init func, it must have an exit func to unload */
+	if ((mod->init && !mod->exit) || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -473,7 +474,7 @@ static void print_unload_info(struct seq
 	if (mod->unsafe)
 		seq_printf(m, " [unsafe]");
 
-	if (!mod->exit)
+	if (mod->init && !mod->exit)
 		seq_printf(m, " [permanent]");
 
 	seq_printf(m, "\n");

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
