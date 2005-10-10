Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVJJOoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVJJOoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJJOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:44:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18659 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750830AbVJJOn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:43:59 -0400
Date: Mon, 10 Oct 2005 10:43:43 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 5/9] Kprobes: Track kprobe on a per_cpu basis - ppc64 changes
Message-ID: <20051010144343.GF4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144248.GE4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

PPC64 changes to track kprobe execution on a per-cpu basis. We now track
the kprobe state machine independently on each cpu using an arch specific
kprobe control block.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/ppc64/kernel/kprobes.c |   94 +++++++++++++++++++++++++-------------------
 include/asm-ppc64/kprobes.h |   15 +++++++
 2 files changed, 69 insertions(+), 40 deletions(-)

Index: linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/ppc64/kernel/kprobes.c	2005-10-05 15:23:42.000000000 -0400
+++ linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c	2005-10-05 15:32:00.000000000 -0400
@@ -37,12 +37,8 @@
 #include <asm/sstep.h>
 
 static DECLARE_MUTEX(kprobe_mutex);
-
-static struct kprobe *current_kprobe;
-static unsigned long kprobe_status, kprobe_saved_msr;
-static struct kprobe *kprobe_prev;
-static unsigned long kprobe_status_prev, kprobe_saved_msr_prev;
-static struct pt_regs jprobe_saved_regs;
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
@@ -108,18 +104,25 @@ static inline void prepare_singlestep(st
 		regs->nip = (unsigned long)p->ainsn.insn;
 }
 
-static inline void save_previous_kprobe(void)
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.saved_msr = kcb->kprobe_saved_msr;
+}
+
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_prev = current_kprobe;
-	kprobe_status_prev = kprobe_status;
-	kprobe_saved_msr_prev = kprobe_saved_msr;
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_saved_msr = kcb->prev_kprobe.saved_msr;
 }
 
-static inline void restore_previous_kprobe(void)
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+				struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = kprobe_prev;
-	kprobe_status = kprobe_status_prev;
-	kprobe_saved_msr = kprobe_saved_msr_prev;
+	__get_cpu_var(current_kprobe) = p;
+	kcb->kprobe_saved_msr = regs->msr;
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
@@ -145,6 +148,7 @@ static inline int kprobe_handler(struct 
 	struct kprobe *p;
 	int ret = 0;
 	unsigned int *addr = (unsigned int *)regs->nip;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	/* Check we're not actually recursing */
 	if (kprobe_running()) {
@@ -153,10 +157,10 @@ static inline int kprobe_handler(struct 
 		p = get_kprobe(addr);
 		if (p) {
 			kprobe_opcode_t insn = *p->ainsn.insn;
-			if (kprobe_status == KPROBE_HIT_SS &&
+			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 					is_trap(insn)) {
 				regs->msr &= ~MSR_SE;
-				regs->msr |= kprobe_saved_msr;
+				regs->msr |= kcb->kprobe_saved_msr;
 				unlock_kprobes();
 				goto no_kprobe;
 			}
@@ -166,15 +170,15 @@ static inline int kprobe_handler(struct 
 			 * just single step on the instruction of the new probe
 			 * without calling any user handlers.
 			 */
-			save_previous_kprobe();
-			current_kprobe = p;
-			kprobe_saved_msr = regs->msr;
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, regs, kcb);
+			kcb->kprobe_saved_msr = regs->msr;
 			p->nmissed++;
 			prepare_singlestep(p, regs);
-			kprobe_status = KPROBE_REENTER;
+			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
 		} else {
-			p = current_kprobe;
+			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
 			}
@@ -214,16 +218,15 @@ static inline int kprobe_handler(struct 
 	 * in post_kprobe_handler().
 	 */
 	preempt_disable();
-	kprobe_status = KPROBE_HIT_ACTIVE;
-	current_kprobe = p;
-	kprobe_saved_msr = regs->msr;
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+	set_current_kprobe(p, regs, kcb);
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
 ss_probe:
 	prepare_singlestep(p, regs);
-	kprobe_status = KPROBE_HIT_SS;
+	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
 no_kprobe:
@@ -292,6 +295,7 @@ int __kprobes trampoline_probe_handler(s
 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
 	regs->nip = orig_ret_address;
 
+	reset_current_kprobe();
 	unlock_kprobes();
 	preempt_enable_no_resched();
 
@@ -324,22 +328,26 @@ static void __kprobes resume_execution(s
 
 static inline int post_kprobe_handler(struct pt_regs *regs)
 {
-	if (!kprobe_running())
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (!cur)
 		return 0;
 
-	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
-		kprobe_status = KPROBE_HIT_SSDONE;
-		current_kprobe->post_handler(current_kprobe, regs, 0);
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
 	}
 
-	resume_execution(current_kprobe, regs);
-	regs->msr |= kprobe_saved_msr;
+	resume_execution(cur, regs);
+	regs->msr |= kcb->kprobe_saved_msr;
 
 	/*Restore back the original saved kprobes variables and continue. */
-	if (kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe();
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
 		goto out;
 	}
+	reset_current_kprobe();
 	unlock_kprobes();
 out:
 	preempt_enable_no_resched();
@@ -358,15 +366,18 @@ out:
 /* Interrupts disabled, kprobe_lock held. */
 static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
-	if (current_kprobe->fault_handler
-	    && current_kprobe->fault_handler(current_kprobe, regs, trapnr))
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 		return 1;
 
-	if (kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(current_kprobe, regs);
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs);
 		regs->msr &= ~MSR_SE;
-		regs->msr |= kprobe_saved_msr;
+		regs->msr |= kcb->kprobe_saved_msr;
 
+		reset_current_kprobe();
 		unlock_kprobes();
 		preempt_enable_no_resched();
 	}
@@ -412,8 +423,9 @@ int __kprobes kprobe_exceptions_notify(s
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	memcpy(&jprobe_saved_regs, regs, sizeof(struct pt_regs));
+	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
 
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
@@ -433,12 +445,14 @@ void __kprobes jprobe_return_end(void)
 
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
 	/*
 	 * FIXME - we should ideally be validating that we got here 'cos
 	 * of the "trap" in jprobe_return() above, before restoring the
 	 * saved regs...
 	 */
-	memcpy(regs, &jprobe_saved_regs, sizeof(struct pt_regs));
+	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
 	return 1;
 }
 
Index: linux-2.6.14-rc3/include/asm-ppc64/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-ppc64/kprobes.h	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/include/asm-ppc64/kprobes.h	2005-10-05 15:31:15.000000000 -0400
@@ -28,6 +28,7 @@
  */
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/percpu.h>
 
 struct pt_regs;
 
@@ -54,6 +55,20 @@ struct arch_specific_insn {
 	kprobe_opcode_t *insn;
 };
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long saved_msr;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_saved_msr;
+	struct pt_regs jprobe_saved_regs;
+	struct prev_kprobe prev_kprobe;
+};
+
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
