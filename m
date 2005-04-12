Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVDLTUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVDLTUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDLTUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:20:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:27849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbVDLKcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:25 -0400
Message-Id: <200504121032.j3CAW8dV005514@shell0.pdx.osdl.net>
Subject: [patch 095/198] x86_64: Keep only a single debug notifier chain
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       jbeulich@novell.com, jfv@bluesong.net, jim.houston@ccur.com,
       kaos@sgi.com, prasanna@in.ibm.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Calling a notifier three times in the debug handler does not make much sense,
because a debugger can figure out the various conditions by itself.  Remove
the additional calls to DIE_DEBUG and DIE_DEBUGSTEP completely.

This matches what i386 does now.

This also makes sure interrupts are always still disabled when calling a
debugger, which prevents:

BUG: using smp_processor_id() in preemptible [00000001] code: tpopf/1470
caller is post_kprobe_handler+0x9/0x70

Call Trace:<ffffffff8024f10f>{smp_processor_id+191} <ffffffff80120e69>{post_kpro
be_handler+9} 
<ffffffff80120f7a>{kprobe_exceptions_notify+58} 
<ffffffff80144fc0>{notifier_call_chain+32} <ffffffff80110daf>{do_debug+335} 
<ffffffff8010f513>{debug+127}  <EOE> 

on preemptible debug kernels with kprobes when single stepping in user space.

This was probably a bug even on non preempt kernels, this function was
supposed to be running with interrupts off according to a comment there.

Note to third part debugger maintainers: please double check your debugger can
still single step.

Cc: <prasanna@in.ibm.com>
Cc: <jbeulich@novell.com>
Cc: <kaos@sgi.com>
Cc: <jim.houston@ccur.com>
Cc: <jfv@bluesong.net>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/traps.c  |   14 +++-----------
 25-akpm/include/asm-x86_64/kdebug.h |    1 -
 2 files changed, 3 insertions(+), 12 deletions(-)

diff -puN arch/x86_64/kernel/traps.c~x86_64-keep-only-a-single-debug-notifier-chain arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-keep-only-a-single-debug-notifier-chain	2005-04-12 03:21:25.729225464 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:25.734224704 -0700
@@ -659,9 +659,9 @@ asmlinkage void do_debug(struct pt_regs 
 	asm("movq %%db6,%0" : "=r" (condition));
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
-						SIGTRAP) == NOTIFY_STOP) {
+						SIGTRAP) == NOTIFY_STOP)
 		return;
-	}
+
 	conditional_sti(regs);
 
 	/* Mask out spurious debug traps due to lazy DR7 setting */
@@ -674,9 +674,7 @@ asmlinkage void do_debug(struct pt_regs 
 	tsk->thread.debugreg6 = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if ((condition & DR_STEP) &&
-	    (notify_die(DIE_DEBUGSTEP, "debugstep", regs, condition,
-			1, SIGTRAP) != NOTIFY_STOP)) {
+	if (condition & DR_STEP) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -711,16 +709,10 @@ asmlinkage void do_debug(struct pt_regs 
 	force_sig_info(SIGTRAP, &info, tsk);	
 clear_dr7:
 	asm volatile("movq %0,%%db7"::"r"(0UL));
-	notify_die(DIE_DEBUG, "debug", regs, condition, 1, SIGTRAP);
 	return;
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-
-clear_TF:
-	/* RED-PEN could cause spurious errors */
-	if (notify_die(DIE_DEBUG, "debug2", regs, condition, 1, SIGTRAP) 
-								!= NOTIFY_STOP)
 	regs->eflags &= ~TF_MASK;
 }
 
diff -puN include/asm-x86_64/kdebug.h~x86_64-keep-only-a-single-debug-notifier-chain include/asm-x86_64/kdebug.h
--- 25/include/asm-x86_64/kdebug.h~x86_64-keep-only-a-single-debug-notifier-chain	2005-04-12 03:21:25.730225312 -0700
+++ 25-akpm/include/asm-x86_64/kdebug.h	2005-04-12 03:21:25.734224704 -0700
@@ -23,7 +23,6 @@ enum die_val { 
 	DIE_OOPS = 1,
 	DIE_INT3,
 	DIE_DEBUG,
-	DIE_DEBUGSTEP,
 	DIE_PANIC,
 	DIE_NMI,
 	DIE_DIE,
_
