Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUEBBI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUEBBI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 21:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEBBI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 21:08:59 -0400
Received: from ozlabs.org ([203.10.76.45]:48056 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262897AbUEBBI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 21:08:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16532.18958.658706.900954@cargo.ozlabs.ibm.com>
Date: Sun, 2 May 2004 11:08:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org, benh@kernel.crashing.org,
       maneesh@in.ibm.com
Subject: [PATCH][PPC64] Fix incorrect signal handler argument
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew & Linus,

This patch fixes a bug in the ppc64 signal delivery code where the
signal number argument to a signal handler can get corrupted before
the handler is called.  The specific scenario is that a process is in
a blocking system call when two signals get generated for it, both of
which have handlers.

The signal code will stack up two signal frames on the process stack
(assuming the mask for the first signal delivered doesn't block the
second signal) and return to userspace to run the handler for the
second signal.  On return from that handler the first handler gets run
with an incorrect signal number argument because we end up with
regs->result still having a negative value (left over from when the
system call was interrupted) when it should be zero.  This patch sets
it to zero when we set up the signal frame (in three places; for
64-bit processes, and for 32-bit processes for RT and non-RT signals).

The way we handle signal delivery and signal handler return using the
regs->result field in ppc64 is more complicated than it needs to be.
In ppc32 I have already simplified it and eliminated use of the
regs->result field.  I am going to do the same in the ppc64 code, but
I think this patch should go in for now to fix the bug.

The patch also fixes a couple of places where we were unnecessarily
and incorrectly truncating the regs->result value to 32 bits
(sys32_sigreturn and sys32_rt_sigreturn return a long value, as all
syscalls do, and if regs->result is negative we need those syscalls to
return a negative value).

Thanks to Maneesh Soni for identifying the specific circumstances
under which this bug shows up.

Please apply.

Thanks,
Paul.

diff -urN ppc64-linux-2.5/arch/ppc64/kernel/signal.c fix/arch/ppc64/kernel/signal.c
--- ppc64-linux-2.5/arch/ppc64/kernel/signal.c	2004-04-20 10:46:36.000000000 +1000
+++ newxmon/arch/ppc64/kernel/signal.c	2004-05-01 20:43:40.193135848 +1000
@@ -430,6 +430,7 @@
 	regs->gpr[1] = newsp;
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
+	regs->result = 0;
 	if (ka->sa.sa_flags & SA_SIGINFO) {
 		err |= get_user(regs->gpr[4], (unsigned long *)&frame->pinfo);
 		err |= get_user(regs->gpr[5], (unsigned long *)&frame->puc);
diff -urN ppc64-linux-2.5/arch/ppc64/kernel/signal32.c fix/arch/ppc64/kernel/signal32.c
--- ppc64-linux-2.5/arch/ppc64/kernel/signal32.c	2004-04-23 13:20:12.000000000 +1000
+++ newxmon/arch/ppc64/kernel/signal32.c	2004-05-01 22:51:31.859190440 +1000
@@ -676,6 +676,7 @@
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
+	regs->result = 0;
 
 	return;
 
@@ -784,7 +785,6 @@
 	 */
        	sys32_sigaltstack((u32)(u64)&rt_sf->uc.uc_stack, 0, 0, 0, 0, 0, regs);
 
-	regs->result &= 0xFFFFFFFF;
 	ret = regs->result;
 
 	return ret;
@@ -841,6 +841,7 @@
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
+	regs->result = 0;
 
 	return;
 
@@ -885,7 +886,6 @@
 	    || restore_user_regs(regs, sr, 1))
 		goto badframe;
 
-	regs->result &= 0xFFFFFFFF;
 	ret = regs->result;
 	return ret;
 
