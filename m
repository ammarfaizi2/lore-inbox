Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVHDAp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVHDAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVHDApZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:45:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22803 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261663AbVHDApE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:45:04 -0400
Date: Wed, 3 Aug 2005 17:43:24 -0700
From: zach@vmware.com
Message-Id: <200508040043.j740hOjx004176@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 2/5 privilege-cleanup
X-OriginalArrivalTime: 04 Aug 2005 00:43:21.0984 (UTC) FILETIME=[83DA0000:01C5988D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Privilege checking cleanup.  Originally, these diffs were much greater,
but recent cleanups in Linux have already done much of the cleanup.  I
added some explanatory comments in places where the reasoning behind
certain tests is rather subtle.

Also, in traps.c, we can skip the user_mode check in handle_BUG().  The
reason is, there are only two call chains - one via die_if_kernel() and
one via do_page_fault(), both entering from die().  Both of these paths
already ensure that a kernel mode failure has happened.  Also,
the original check here, if (user_mode(regs)) was insufficient anyways,
since it would not rule out BUG faults from V8086 mode execution.

Saving the %ss segment in show_regs() rather than assuming a fixed value
also gives better information about the current kernel state in the
register dump.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/signal.c	2005-08-02 17:06:21.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/signal.c	2005-08-02 17:09:54.000000000 -0700
@@ -603,7 +603,9 @@
 	 * We want the common case to go fast, which
 	 * is why we may in certain cases get here from
 	 * kernel mode. Just return without doing anything
-	 * if so.
+ 	 * if so.  vm86 regs switched out by assembly code
+ 	 * before reaching here, so testing against kernel
+ 	 * CS suffices.
 	 */
 	if (!user_mode(regs))
 		return 1;
Index: linux-2.6.13/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/traps.c	2005-08-02 17:06:21.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/traps.c	2005-08-02 17:09:54.000000000 -0700
@@ -245,7 +245,7 @@
 	unsigned short ss;
 
 	esp = (unsigned long) (&regs->esp);
-	ss = __KERNEL_DS;
+	savesegment(ss, ss);
 	if (user_mode(regs)) {
 		in_kernel = 0;
 		esp = regs->esp;
@@ -302,9 +302,6 @@
 	char c;
 	unsigned long eip;
 
-	if (user_mode(regs))
-		goto no_bug;		/* Not in kernel */
-
 	eip = regs->eip;
 
 	if (eip < PAGE_OFFSET)
Index: linux-2.6.13/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/ptrace.h	2005-08-02 17:04:23.000000000 -0700
+++ linux-2.6.13/include/asm-i386/ptrace.h	2005-08-02 17:09:54.000000000 -0700
@@ -61,6 +61,13 @@
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
 
+/*
+ * user_mode_vm(regs) determines whether a register set came from user mode.
+ * This is true if V8086 mode was enabled OR if the register set was from
+ * protected mode with RPL-3 CS value.  This tricky test checks that with
+ * one comparison.  Many places in the kernel can bypass this full check
+ * if they have already ruled out V8086 mode, so user_mode(regs) can be used.
+ */
 static inline int user_mode(struct pt_regs *regs)
 {
 	return (regs->xcs & 3) != 0;
