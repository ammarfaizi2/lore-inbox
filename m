Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269721AbUINSnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269721AbUINSnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUINSjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:39:11 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30659 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269700AbUINSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:30:05 -0400
Message-Id: <200409141933.i8EJXr4W003552@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - fix call to sys_clone
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 15:33:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the calling convention of clone on i386 to match that of
the host by leaving the fourth argument unused.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/syscall_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/syscall_kern.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/syscall_kern.c	2004-09-14 14:00:48.000000000 -0400
@@ -44,17 +44,6 @@
 	return(ret);
 }
 
-long sys_clone(unsigned long clone_flags, unsigned long newsp,
-	       int *parent_tid, int *child_tid)
-{
-	long ret;
-
-	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
-	current->thread.forking = 0;
-	return(ret);
-}
-
 long sys_vfork(void)
 {
 	long ret;
Index: 2.6.9-rc2/arch/um/sys-i386/syscalls.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/syscalls.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/syscalls.c	2004-09-14 14:00:48.000000000 -0400
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/sched.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
@@ -56,6 +57,27 @@
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 }
 
+/* The i386 version skips reading from %esi, the fourth argument. So we must do
+ * this, too.
+ */
+int sys_clone(unsigned long clone_flags, unsigned long newsp, int *parent_tid,
+	      int unused, int *child_tid)
+{
+	long ret;
+
+	/* XXX: normal arch do here this pass, and also pass the regs to 
+	 * do_fork, instead of NULL. Currently the arch-independent code 
+	 * ignores these values, while the UML code (actually it's 
+	 * copy_thread) does the right thing. But this should change, 
+	 probably. */
+	/*if (!newsp)
+		newsp = UPT_SP(current->thread.regs);*/
+	current->thread.forking = 1;
+	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	current->thread.forking = 0;
+	return(ret);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

