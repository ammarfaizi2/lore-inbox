Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUINRxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUINRxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUINRtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:49:40 -0400
Received: from [12.177.129.25] ([12.177.129.25]:26051 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269500AbUINRn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:43:56 -0400
Message-Id: <200409141847.i8EIlb4W003427@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Let page faults always be delivered immediately
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 14:47:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows page faults to be delivered when they happen.  Without this,
it can happen that a page fault will occur when SIGSEGV is disabled, and
the host will then just kill UML because it can't invoke the handler.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/process.c	2004-09-14 13:30:33.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/process.c	2004-09-14 13:30:34.000000000 -0400
@@ -57,11 +57,7 @@
 {
 	int flags = altstack ? SA_ONSTACK : 0;
 
-	/* NODEFER is set here because SEGV isn't turned back on when the
-	 * handler is ready to receive signals.  This causes any segfault
-	 * during a copy_user to kill the process because the fault is blocked.
-	 */
-	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags | SA_NODEFER,
+	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags, 
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags, 
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
Index: 2.6.9-rc2/arch/um/kernel/tt/trap_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/trap_user.c	2004-09-14 13:30:22.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/trap_user.c	2004-09-14 13:30:34.000000000 -0400
@@ -23,6 +23,13 @@
 
 	unprotect_kernel_mem();
 
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
 	r = &TASK_REGS(get_current())->tt;
 	save_regs = *r;
 	is_user = user_context(SC_SP(sc));
More recent patches modify files in segv.

