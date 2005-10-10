Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVJJOpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVJJOpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJJOpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:45:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:61091 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750827AbVJJOpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:45:38 -0400
Date: Mon, 10 Oct 2005 10:45:15 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 7/9] Kprobes: Track kprobe on a per_cpu basis - x86_64 changes
Message-ID: <20051010144515.GH4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com> <20051010144343.GF4389@in.ibm.com> <20051010144430.GG4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144430.GG4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

x86_64 changes to track kprobe execution on a per-cpu basis. We now track
the kprobe state machine independently on each cpu using a arch specific
kprobe control block.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/x86_64/kernel/kprobes.c |  129 +++++++++++++++++++++++--------------------
 include/asm-x86_64/kprobes.h |   19 ++++++
 2 files changed, 89 insertions(+), 59 deletions(-)

Index: linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/kernel/kprobes.c	2005-10-05 16:08:04.000000000 -0400
+++ linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c	2005-10-05 16:08:18.000000000 -0400
@@ -44,17 +44,10 @@
 #include <asm/kdebug.h>
 
 static DECLARE_MUTEX(kprobe_mutex);
-
-static struct kprobe *current_kprobe;
-static unsigned long kprobe_status, kprobe_old_rflags, kprobe_saved_rflags;
-static struct kprobe *kprobe_prev;
-static unsigned long kprobe_status_prev, kprobe_old_rflags_prev, kprobe_saved_rflags_prev;
-static struct pt_regs jprobe_saved_regs;
-static long *jprobe_saved_rsp;
 void jprobe_return_end(void);
 
-/* copy of the kernel stack at the probe fire time */
-static kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 /*
  * returns non-zero if opcode modifies the interrupt flag.
@@ -236,29 +229,30 @@ void __kprobes arch_remove_kprobe(struct
 	up(&kprobe_mutex);
 }
 
-static inline void save_previous_kprobe(void)
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_prev = current_kprobe;
-	kprobe_status_prev = kprobe_status;
-	kprobe_old_rflags_prev = kprobe_old_rflags;
-	kprobe_saved_rflags_prev = kprobe_saved_rflags;
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.old_rflags = kcb->kprobe_old_rflags;
+	kcb->prev_kprobe.saved_rflags = kcb->kprobe_saved_rflags;
 }
 
-static inline void restore_previous_kprobe(void)
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = kprobe_prev;
-	kprobe_status = kprobe_status_prev;
-	kprobe_old_rflags = kprobe_old_rflags_prev;
-	kprobe_saved_rflags = kprobe_saved_rflags_prev;
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_old_rflags = kcb->prev_kprobe.old_rflags;
+	kcb->kprobe_saved_rflags = kcb->prev_kprobe.saved_rflags;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+				struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = p;
-	kprobe_saved_rflags = kprobe_old_rflags
+	__get_cpu_var(current_kprobe) = p;
+	kcb->kprobe_saved_rflags = kcb->kprobe_old_rflags
 		= (regs->eflags & (TF_MASK | IF_MASK));
 	if (is_IF_modifier(p->ainsn.insn))
-		kprobe_saved_rflags &= ~IF_MASK;
+		kcb->kprobe_saved_rflags &= ~IF_MASK;
 }
 
 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
@@ -301,6 +295,7 @@ int __kprobes kprobe_handler(struct pt_r
 	struct kprobe *p;
 	int ret = 0;
 	kprobe_opcode_t *addr = (kprobe_opcode_t *)(regs->rip - sizeof(kprobe_opcode_t));
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	/* Check we're not actually recursing */
 	if (kprobe_running()) {
@@ -308,13 +303,13 @@ int __kprobes kprobe_handler(struct pt_r
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS &&
+			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
 				regs->eflags &= ~TF_MASK;
-				regs->eflags |= kprobe_saved_rflags;
+				regs->eflags |= kcb->kprobe_saved_rflags;
 				unlock_kprobes();
 				goto no_kprobe;
-			} else if (kprobe_status == KPROBE_HIT_SSDONE) {
+			} else if (kcb->kprobe_status == KPROBE_HIT_SSDONE) {
 				/* TODO: Provide re-entrancy from
 				 * post_kprobes_handler() and avoid exception
 				 * stack corruption while single-stepping on
@@ -322,6 +317,7 @@ int __kprobes kprobe_handler(struct pt_r
 				 */
 				arch_disarm_kprobe(p);
 				regs->rip = (unsigned long)p->addr;
+				reset_current_kprobe();
 				ret = 1;
 			} else {
 				/* We have reentered the kprobe_handler(), since
@@ -331,15 +327,15 @@ int __kprobes kprobe_handler(struct pt_r
 				 * of the new probe without calling any user
 				 * handlers.
 				 */
-				save_previous_kprobe();
-				set_current_kprobe(p, regs);
+				save_previous_kprobe(kcb);
+				set_current_kprobe(p, regs, kcb);
 				p->nmissed++;
 				prepare_singlestep(p, regs);
-				kprobe_status = KPROBE_REENTER;
+				kcb->kprobe_status = KPROBE_REENTER;
 				return 1;
 			}
 		} else {
-			p = current_kprobe;
+			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
 			}
@@ -374,8 +370,8 @@ int __kprobes kprobe_handler(struct pt_r
 	 * in post_kprobe_handler()
 	 */
 	preempt_disable();
-	kprobe_status = KPROBE_HIT_ACTIVE;
-	set_current_kprobe(p, regs);
+	set_current_kprobe(p, regs, kcb);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
@@ -383,7 +379,7 @@ int __kprobes kprobe_handler(struct pt_r
 
 ss_probe:
 	prepare_singlestep(p, regs);
-	kprobe_status = KPROBE_HIT_SS;
+	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
 no_kprobe:
@@ -451,6 +447,7 @@ int __kprobes trampoline_probe_handler(s
 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
 	regs->rip = orig_ret_address;
 
+	reset_current_kprobe();
 	unlock_kprobes();
 	preempt_enable_no_resched();
 
@@ -484,7 +481,8 @@ int __kprobes trampoline_probe_handler(s
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
  */
-static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p,
+		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	unsigned long *tos = (unsigned long *)regs->rsp;
 	unsigned long next_rip = 0;
@@ -499,7 +497,7 @@ static void __kprobes resume_execution(s
 	switch (*insn) {
 	case 0x9c:		/* pushfl */
 		*tos &= ~(TF_MASK | IF_MASK);
-		*tos |= kprobe_old_rflags;
+		*tos |= kcb->kprobe_old_rflags;
 		break;
 	case 0xc3:		/* ret/lret */
 	case 0xcb:
@@ -544,24 +542,28 @@ static void __kprobes resume_execution(s
  */
 int __kprobes post_kprobe_handler(struct pt_regs *regs)
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
-	regs->eflags |= kprobe_saved_rflags;
+	resume_execution(cur, regs, kcb);
+	regs->eflags |= kcb->kprobe_saved_rflags;
 
 	/* Restore the original saved kprobes variables and continue. */
-	if (kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe();
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
 		goto out;
 	} else {
 		unlock_kprobes();
 	}
+	reset_current_kprobe();
 out:
 	preempt_enable_no_resched();
 
@@ -579,14 +581,17 @@ out:
 /* Interrupts disabled, kprobe_lock held. */
 int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
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
-		regs->eflags |= kprobe_old_rflags;
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs, kcb);
+		regs->eflags |= kcb->kprobe_old_rflags;
 
+		reset_current_kprobe();
 		unlock_kprobes();
 		preempt_enable_no_resched();
 	}
@@ -629,10 +634,11 @@ int __kprobes setjmp_pre_handler(struct 
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	jprobe_saved_regs = *regs;
-	jprobe_saved_rsp = (long *) regs->rsp;
-	addr = (unsigned long)jprobe_saved_rsp;
+	kcb->jprobe_saved_regs = *regs;
+	kcb->jprobe_saved_rsp = (long *) regs->rsp;
+	addr = (unsigned long)(kcb->jprobe_saved_rsp);
 	/*
 	 * As Linus pointed out, gcc assumes that the callee
 	 * owns the argument space and could overwrite it, e.g.
@@ -640,7 +646,8 @@ int __kprobes setjmp_pre_handler(struct 
 	 * we also save and restore enough stack bytes to cover
 	 * the argument area.
 	 */
-	memcpy(jprobes_stack, (kprobe_opcode_t *) addr, MIN_STACK_SIZE(addr));
+	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *)addr,
+			MIN_STACK_SIZE(addr));
 	regs->eflags &= ~IF_MASK;
 	regs->rip = (unsigned long)(jp->entry);
 	return 1;
@@ -648,34 +655,38 @@ int __kprobes setjmp_pre_handler(struct 
 
 void __kprobes jprobe_return(void)
 {
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
 	asm volatile ("       xchg   %%rbx,%%rsp     \n"
 		      "       int3			\n"
 		      "       .globl jprobe_return_end	\n"
 		      "       jprobe_return_end:	\n"
 		      "       nop			\n"::"b"
-		      (jprobe_saved_rsp):"memory");
+		      (kcb->jprobe_saved_rsp):"memory");
 }
 
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	u8 *addr = (u8 *) (regs->rip - 1);
-	unsigned long stack_addr = (unsigned long)jprobe_saved_rsp;
+	unsigned long stack_addr = (unsigned long)(kcb->jprobe_saved_rsp);
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 
 	if ((addr > (u8 *) jprobe_return) && (addr < (u8 *) jprobe_return_end)) {
-		if ((long *)regs->rsp != jprobe_saved_rsp) {
+		if ((long *)regs->rsp != kcb->jprobe_saved_rsp) {
 			struct pt_regs *saved_regs =
-			    container_of(jprobe_saved_rsp, struct pt_regs, rsp);
+			    container_of(kcb->jprobe_saved_rsp,
+					    struct pt_regs, rsp);
 			printk("current rsp %p does not match saved rsp %p\n",
-			       (long *)regs->rsp, jprobe_saved_rsp);
+			       (long *)regs->rsp, kcb->jprobe_saved_rsp);
 			printk("Saved registers for jprobe %p\n", jp);
 			show_registers(saved_regs);
 			printk("Current registers\n");
 			show_registers(regs);
 			BUG();
 		}
-		*regs = jprobe_saved_regs;
-		memcpy((kprobe_opcode_t *) stack_addr, jprobes_stack,
+		*regs = kcb->jprobe_saved_regs;
+		memcpy((kprobe_opcode_t *) stack_addr, kcb->jprobes_stack,
 		       MIN_STACK_SIZE(stack_addr));
 		return 1;
 	}
Index: linux-2.6.14-rc3/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-x86_64/kprobes.h	2005-10-05 16:07:44.000000000 -0400
+++ linux-2.6.14-rc3/include/asm-x86_64/kprobes.h	2005-10-05 16:08:18.000000000 -0400
@@ -25,6 +25,7 @@
  */
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/percpu.h>
 
 struct pt_regs;
 
@@ -48,6 +49,24 @@ struct arch_specific_insn {
 	kprobe_opcode_t *insn;
 };
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long old_rflags;
+	unsigned long saved_rflags;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_old_rflags;
+	unsigned long kprobe_saved_rflags;
+	long *jprobe_saved_rsp;
+	struct pt_regs jprobe_saved_regs;
+	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
+	struct prev_kprobe prev_kprobe;
+};
+
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
  */
