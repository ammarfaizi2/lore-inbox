Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVCNEw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVCNEw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVCNEw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:52:26 -0500
Received: from ozlabs.org ([203.10.76.45]:30852 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261304AbVCNEwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:52:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.6337.715642.803244@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 15:53:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix kprobes calling smp_processor_id when preemptible
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with kprobes and preemption both enabled and
CONFIG_DEBUG_PREEMPT=y, I get lots of warnings about smp_processor_id
being called in preemptible code, from kprobe_exceptions_notify.  On
ppc64, interrupts and preemption are not disabled in the handlers for
most synchronous exceptions such as breakpoints and page faults
(interrupts are disabled in the very early exception entry code but
are reenabled before calling the C handler).

This patch adds a preempt_disable/enable pair to
kprobe_exceptions_notify, and moves the preempt_disable() in
kprobe_handler() to be done only in the case where we are about to
single-step an instruction.  This eliminates the bug warnings.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/kprobes.c test/arch/ppc64/kernel/kprobes.c
--- linux-2.5/arch/ppc64/kernel/kprobes.c	2005-03-09 10:25:15.000000000 +1100
+++ test/arch/ppc64/kernel/kprobes.c	2005-03-14 15:11:05.000000000 +1100
@@ -80,9 +80,6 @@
 	int ret = 0;
 	unsigned int *addr = (unsigned int *)regs->nip;
 
-	/* We're in an interrupt, but this is clear and BUG()-safe. */
-	preempt_disable();
-
 	/* Check we're not actually recursing */
 	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
@@ -139,10 +136,14 @@
 ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobe_handler().
+	 */
+	preempt_disable();
 	return 1;
 
 no_kprobe:
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -215,27 +216,35 @@
 			     void *data)
 {
 	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	/*
+	 * Interrupts are not disabled here.  We need to disable
+	 * preemption, because kprobe_running() uses smp_processor_id().
+	 */
+	preempt_disable();
 	switch (val) {
 	case DIE_IABR_MATCH:
 	case DIE_DABR_MATCH:
 	case DIE_BPT:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_SSTEP:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_GPF:
 	case DIE_PAGE_FAULT:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	default:
 		break;
 	}
-	return NOTIFY_DONE;
+	preempt_enable();
+	return ret;
 }
 
 int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
