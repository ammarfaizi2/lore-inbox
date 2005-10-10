Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVJJOjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVJJOjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJJOjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:39:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65461 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750815AbVJJOjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:39:47 -0400
Date: Mon, 10 Oct 2005 10:39:28 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 1/9] Kprobes: rearrange preempt_disable/enable() calls
Message-ID: <20051010143928.GB4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010143747.GA4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Reorder preempt_disable/enable() calls in arch kprobes files in
preparation to introduce locking changes. No functional changes
introduced by this patch.

Signed-off-by: Ananth N Mavinakayahanalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/i386/kernel/kprobes.c    |   27 ++++++++++++++-------------
 arch/ia64/kernel/kprobes.c    |   22 ++++++++++++++--------
 arch/ppc64/kernel/kprobes.c   |   11 ++++++-----
 arch/sparc64/kernel/kprobes.c |   25 +++++++++++++------------
 arch/x86_64/kernel/kprobes.c  |   28 ++++++++++++++--------------
 5 files changed, 61 insertions(+), 52 deletions(-)

Index: linux-2.6.14-rc3/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/i386/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/arch/i386/kernel/kprobes.c	2005-10-05 16:07:48.000000000 -0400
@@ -158,8 +158,6 @@ static int __kprobes kprobe_handler(stru
 	kprobe_opcode_t *addr = NULL;
 	unsigned long *lp;
 
-	/* We're in an interrupt, but this is clear and BUG()-safe. */
-	preempt_disable();
 	/* Check if the application is using LDT entry for its code segment and
 	 * calculate the address by reading the base address from the LDT entry.
 	 */
@@ -232,6 +230,11 @@ static int __kprobes kprobe_handler(stru
 		goto no_kprobe;
 	}
 
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobe_handler()
+	 */
+	preempt_disable();
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	set_current_kprobe(p, regs);
 
@@ -245,7 +248,6 @@ ss_probe:
 	return 1;
 
 no_kprobe:
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -316,7 +318,7 @@ int __kprobes trampoline_probe_handler(s
         /*
          * By returning a non-zero value, we are telling
          * kprobe_handler() that we have handled unlocking
-         * and re-enabling preemption.
+	 * and re-enabling preemption
          */
         return 1;
 }
@@ -453,29 +455,29 @@ int __kprobes kprobe_exceptions_notify(s
 				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	preempt_disable();
 	switch (val) {
 	case DIE_INT3:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_DEBUG:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_GPF:
-		if (kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_STOP;
-		break;
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
 
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
@@ -502,7 +504,6 @@ int __kprobes setjmp_pre_handler(struct 
 
 void __kprobes jprobe_return(void)
 {
-	preempt_enable_no_resched();
 	asm volatile ("       xchgl   %%ebx,%%esp     \n"
 		      "       int3			\n"
 		      "       .globl jprobe_return_end	\n"
Index: linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/ia64/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c	2005-10-05 16:07:47.000000000 -0400
@@ -395,7 +395,7 @@ int __kprobes trampoline_probe_handler(s
         /*
          * By returning a non-zero value, we are telling
          * kprobe_handler() that we have handled unlocking
-         * and re-enabling preemption.
+	 * and re-enabling preemption
          */
         return 1;
 }
@@ -607,8 +607,6 @@ static int __kprobes pre_kprobes_handler
 	struct pt_regs *regs = args->regs;
 	kprobe_opcode_t *addr = (kprobe_opcode_t *)instruction_pointer(regs);
 
-	preempt_disable();
-
 	/* Handle recursion cases */
 	if (kprobe_running()) {
 		p = get_kprobe(addr);
@@ -665,6 +663,11 @@ static int __kprobes pre_kprobes_handler
 		goto no_kprobe;
 	}
 
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobes_handler()
+	 */
+	preempt_disable();
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	set_current_kprobe(p);
 
@@ -682,7 +685,6 @@ ss_probe:
 	return 1;
 
 no_kprobe:
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -733,22 +735,26 @@ int __kprobes kprobe_exceptions_notify(s
 				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	preempt_disable();
 	switch(val) {
 	case DIE_BREAK:
 		if (pre_kprobes_handler(args))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_SS:
 		if (post_kprobes_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_PAGE_FAULT:
 		if (kprobes_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 	default:
 		break;
 	}
-	return NOTIFY_DONE;
+	preempt_enable();
+	return ret;
 }
 
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
Index: linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/ppc64/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c	2005-10-05 16:07:45.000000000 -0400
@@ -209,6 +209,11 @@ static inline int kprobe_handler(struct 
 		goto no_kprobe;
 	}
 
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobe_handler().
+	 */
+	preempt_disable();
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	current_kprobe = p;
 	kprobe_saved_msr = regs->msr;
@@ -219,11 +224,6 @@ static inline int kprobe_handler(struct 
 ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
-	/*
-	 * This preempt_disable() matches the preempt_enable_no_resched()
-	 * in post_kprobe_handler().
-	 */
-	preempt_disable();
 	return 1;
 
 no_kprobe:
@@ -293,6 +293,7 @@ int __kprobes trampoline_probe_handler(s
 	regs->nip = orig_ret_address;
 
 	unlock_kprobes();
+	preempt_enable_no_resched();
 
         /*
          * By returning a non-zero value, we are telling
Index: linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/sparc64/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c	2005-10-05 16:07:44.000000000 -0400
@@ -118,8 +118,6 @@ static int __kprobes kprobe_handler(stru
 	void *addr = (void *) regs->tpc;
 	int ret = 0;
 
-	preempt_disable();
-
 	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
 		 * Disarm the probe we just hit, and ignore it.
@@ -171,6 +169,11 @@ static int __kprobes kprobe_handler(stru
 		goto no_kprobe;
 	}
 
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobes_handler()
+	 */
+	preempt_disable();
 	set_current_kprobe(p, regs);
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	if (p->pre_handler && p->pre_handler(p, regs))
@@ -182,7 +185,6 @@ ss_probe:
 	return 1;
 
 no_kprobe:
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -322,29 +324,29 @@ int __kprobes kprobe_exceptions_notify(s
 				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	preempt_disable();
 	switch (val) {
 	case DIE_DEBUG:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_DEBUG_2:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_GPF:
-		if (kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_STOP;
-		break;
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
 
 asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
@@ -396,7 +398,6 @@ int __kprobes setjmp_pre_handler(struct 
 
 void __kprobes jprobe_return(void)
 {
-	preempt_enable_no_resched();
 	__asm__ __volatile__(
 		".globl	jprobe_return_trap_instruction\n"
 "jprobe_return_trap_instruction:\n\t"
Index: linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c	2005-10-05 16:08:04.000000000 -0400
@@ -302,9 +302,6 @@ int __kprobes kprobe_handler(struct pt_r
 	int ret = 0;
 	kprobe_opcode_t *addr = (kprobe_opcode_t *)(regs->rip - sizeof(kprobe_opcode_t));
 
-	/* We're in an interrupt, but this is clear and BUG()-safe. */
-	preempt_disable();
-
 	/* Check we're not actually recursing */
 	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
@@ -372,6 +369,11 @@ int __kprobes kprobe_handler(struct pt_r
 		goto no_kprobe;
 	}
 
+	/*
+	 * This preempt_disable() matches the preempt_enable_no_resched()
+	 * in post_kprobe_handler()
+	 */
+	preempt_disable();
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	set_current_kprobe(p, regs);
 
@@ -385,7 +387,6 @@ ss_probe:
 	return 1;
 
 no_kprobe:
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -456,7 +457,7 @@ int __kprobes trampoline_probe_handler(s
         /*
          * By returning a non-zero value, we are telling
          * kprobe_handler() that we have handled unlocking
-         * and re-enabling preemption.
+	 * and re-enabling preemption
          */
         return 1;
 }
@@ -599,29 +600,29 @@ int __kprobes kprobe_exceptions_notify(s
 				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	preempt_disable();
 	switch (val) {
 	case DIE_INT3:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_DEBUG:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_STOP;
+			ret = NOTIFY_STOP;
 		break;
 	case DIE_GPF:
-		if (kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_STOP;
-		break;
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
 
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
@@ -647,7 +648,6 @@ int __kprobes setjmp_pre_handler(struct 
 
 void __kprobes jprobe_return(void)
 {
-	preempt_enable_no_resched();
 	asm volatile ("       xchg   %%rbx,%%rsp     \n"
 		      "       int3			\n"
 		      "       .globl jprobe_return_end	\n"
