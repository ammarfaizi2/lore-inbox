Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTKRKxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 05:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTKRKxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 05:53:30 -0500
Received: from ozlabs.org ([203.10.76.45]:58530 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262529AbTKRKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 05:53:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16313.64022.203052.444584@cargo.ozlabs.ibm.com>
Date: Tue, 18 Nov 2003 21:53:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: Fix possible race in syscall restart
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This is the PPC64 counterpart of the fix for the potential race in the
syscall restart code that has gone into other architectures.  It resets
current_thread_info()->restart_block.fn to do_no_syscall_restart in
the sigreturn code.

Thanks,
Paul.

diff -urN ppc64-linux-2.5/arch/ppc64/kernel/signal.c ppc64-2.5/arch/ppc64/kernel/signal.c
--- ppc64-linux-2.5/arch/ppc64/kernel/signal.c	2003-10-22 21:59:05.000000000 +1000
+++ ppc64-2.5/arch/ppc64/kernel/signal.c	2003-11-17 08:52:15.000000000 +1100
@@ -220,6 +220,9 @@
 	sigset_t set;
 	stack_t st;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	if (verify_area(VERIFY_READ, uc, sizeof(*uc)))
 		goto badframe;
 
@@ -354,8 +357,6 @@
 {
 	switch ((int)regs->result) {
 	case -ERESTART_RESTARTBLOCK:
-		current_thread_info()->restart_block.fn = do_no_restart_syscall;
-		/* fallthrough */
 	case -ERESTARTNOHAND:
 		/* ERESTARTNOHAND means that the syscall should only be
 		 * restarted if there was no handler for the signal, and since
diff -urN ppc64-linux-2.5/arch/ppc64/kernel/signal32.c ppc64-2.5/arch/ppc64/kernel/signal32.c
--- ppc64-linux-2.5/arch/ppc64/kernel/signal32.c	2003-10-22 21:59:05.000000000 +1000
+++ ppc64-2.5/arch/ppc64/kernel/signal32.c	2003-11-17 08:54:29.000000000 +1100
@@ -300,6 +300,9 @@
 	struct sigcontext32 *sc = (struct sigcontext32 *)(u64)newsp;
 	int i;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
 	if (regs->msr & MSR_FP)
@@ -420,6 +423,9 @@
 	int i;
 	mm_segment_t old_fs;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	/* Adjust the inputted reg1 to point to the first rt signal frame */
 	rt_sf = (struct rt_sigframe_32 *)(regs->gpr[1] + __SIGNAL_FRAMESIZE32);
 	/* Copy the information from the user stack  */
