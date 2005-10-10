Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVJJOmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVJJOmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJJOmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:42:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51669 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750819AbVJJOmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:42:23 -0400
Date: Mon, 10 Oct 2005 10:42:06 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 3/9] Kprobes: Track kprobe on a per_cpu basis - i386 changes
Message-ID: <20051010144206.GD4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144107.GC4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

I386 changes to track kprobe execution on a per-cpu basis. We now track
the kprobe state machine independently on each cpu, using an arch specific
kprobe control block.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/i386/kernel/kprobes.c |  126 ++++++++++++++++++++++++---------------------
 include/asm-i386/kprobes.h |   17 ++++++
 2 files changed, 86 insertions(+), 57 deletions(-)

Index: linux-2.6.14-rc3/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/i386/kernel/kprobes.c	2005-10-05 15:22:37.000000000 -0400
+++ linux-2.6.14-rc3/arch/i386/kernel/kprobes.c	2005-10-05 15:27:19.000000000 -0400
@@ -37,16 +37,11 @@
 #include <asm/kdebug.h>
 #include <asm/desc.h>
 
-static struct kprobe *current_kprobe;
-static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
-static struct kprobe *kprobe_prev;
-static unsigned long kprobe_status_prev, kprobe_old_eflags_prev, kprobe_saved_eflags_prev;
-static struct pt_regs jprobe_saved_regs;
-static long *jprobe_saved_esp;
-/* copy of the kernel stack at the probe fire time */
-static kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 void jprobe_return_end(void);
 
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
 /*
  * returns non-zero if opcode modifies the interrupt flag.
  */
@@ -91,29 +86,30 @@ void __kprobes arch_remove_kprobe(struct
 {
 }
 
-static inline void save_previous_kprobe(void)
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_prev = current_kprobe;
-	kprobe_status_prev = kprobe_status;
-	kprobe_old_eflags_prev = kprobe_old_eflags;
-	kprobe_saved_eflags_prev = kprobe_saved_eflags;
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.old_eflags = kcb->kprobe_old_eflags;
+	kcb->prev_kprobe.saved_eflags = kcb->kprobe_saved_eflags;
 }
 
-static inline void restore_previous_kprobe(void)
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = kprobe_prev;
-	kprobe_status = kprobe_status_prev;
-	kprobe_old_eflags = kprobe_old_eflags_prev;
-	kprobe_saved_eflags = kprobe_saved_eflags_prev;
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_old_eflags = kcb->prev_kprobe.old_eflags;
+	kcb->kprobe_saved_eflags = kcb->prev_kprobe.saved_eflags;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+				struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = p;
-	kprobe_saved_eflags = kprobe_old_eflags
+	__get_cpu_var(current_kprobe) = p;
+	kcb->kprobe_saved_eflags = kcb->kprobe_old_eflags
 		= (regs->eflags & (TF_MASK | IF_MASK));
 	if (is_IF_modifier(p->opcode))
-		kprobe_saved_eflags &= ~IF_MASK;
+		kcb->kprobe_saved_eflags &= ~IF_MASK;
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
@@ -157,6 +153,7 @@ static int __kprobes kprobe_handler(stru
 	int ret = 0;
 	kprobe_opcode_t *addr = NULL;
 	unsigned long *lp;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	/* Check if the application is using LDT entry for its code segment and
 	 * calculate the address by reading the base address from the LDT entry.
@@ -175,10 +172,10 @@ static int __kprobes kprobe_handler(stru
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS &&
+			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
 				regs->eflags &= ~TF_MASK;
-				regs->eflags |= kprobe_saved_eflags;
+				regs->eflags |= kcb->kprobe_saved_eflags;
 				unlock_kprobes();
 				goto no_kprobe;
 			}
@@ -188,14 +185,14 @@ static int __kprobes kprobe_handler(stru
 			 * just single step on the instruction of the new probe
 			 * without calling any user handlers.
 			 */
-			save_previous_kprobe();
-			set_current_kprobe(p, regs);
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, regs, kcb);
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
@@ -235,8 +232,8 @@ static int __kprobes kprobe_handler(stru
 	 * in post_kprobe_handler()
 	 */
 	preempt_disable();
-	kprobe_status = KPROBE_HIT_ACTIVE;
-	set_current_kprobe(p, regs);
+	set_current_kprobe(p, regs, kcb);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
@@ -244,7 +241,7 @@ static int __kprobes kprobe_handler(stru
 
 ss_probe:
 	prepare_singlestep(p, regs);
-	kprobe_status = KPROBE_HIT_SS;
+	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
 no_kprobe:
@@ -312,6 +309,7 @@ int __kprobes trampoline_probe_handler(s
 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
 	regs->eip = orig_ret_address;
 
+	reset_current_kprobe();
 	unlock_kprobes();
 	preempt_enable_no_resched();
 
@@ -345,7 +343,8 @@ int __kprobes trampoline_probe_handler(s
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
  */
-static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p,
+		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
 	unsigned long next_eip = 0;
@@ -355,7 +354,7 @@ static void __kprobes resume_execution(s
 	switch (p->ainsn.insn[0]) {
 	case 0x9c:		/* pushfl */
 		*tos &= ~(TF_MASK | IF_MASK);
-		*tos |= kprobe_old_eflags;
+		*tos |= kcb->kprobe_old_eflags;
 		break;
 	case 0xc3:		/* ret/lret */
 	case 0xcb:
@@ -400,22 +399,26 @@ static void __kprobes resume_execution(s
  */
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
-	regs->eflags |= kprobe_saved_eflags;
+	resume_execution(cur, regs, kcb);
+	regs->eflags |= kcb->kprobe_saved_eflags;
 
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
@@ -434,14 +437,17 @@ out:
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
-		regs->eflags |= kprobe_old_eflags;
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs, kcb);
+		regs->eflags |= kcb->kprobe_old_eflags;
 
+		reset_current_kprobe();
 		unlock_kprobes();
 		preempt_enable_no_resched();
 	}
@@ -484,10 +490,11 @@ int __kprobes setjmp_pre_handler(struct 
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	jprobe_saved_regs = *regs;
-	jprobe_saved_esp = &regs->esp;
-	addr = (unsigned long)jprobe_saved_esp;
+	kcb->jprobe_saved_regs = *regs;
+	kcb->jprobe_saved_esp = &regs->esp;
+	addr = (unsigned long)(kcb->jprobe_saved_esp);
 
 	/*
 	 * TBD: As Linus pointed out, gcc assumes that the callee
@@ -496,7 +503,8 @@ int __kprobes setjmp_pre_handler(struct 
 	 * we also save and restore enough stack bytes to cover
 	 * the argument area.
 	 */
-	memcpy(jprobes_stack, (kprobe_opcode_t *) addr, MIN_STACK_SIZE(addr));
+	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *)addr,
+			MIN_STACK_SIZE(addr));
 	regs->eflags &= ~IF_MASK;
 	regs->eip = (unsigned long)(jp->entry);
 	return 1;
@@ -504,34 +512,38 @@ int __kprobes setjmp_pre_handler(struct 
 
 void __kprobes jprobe_return(void)
 {
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
 	asm volatile ("       xchgl   %%ebx,%%esp     \n"
 		      "       int3			\n"
 		      "       .globl jprobe_return_end	\n"
 		      "       jprobe_return_end:	\n"
 		      "       nop			\n"::"b"
-		      (jprobe_saved_esp):"memory");
+		      (kcb->jprobe_saved_esp):"memory");
 }
 
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	u8 *addr = (u8 *) (regs->eip - 1);
-	unsigned long stack_addr = (unsigned long)jprobe_saved_esp;
+	unsigned long stack_addr = (unsigned long)(kcb->jprobe_saved_esp);
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 
 	if ((addr > (u8 *) jprobe_return) && (addr < (u8 *) jprobe_return_end)) {
-		if (&regs->esp != jprobe_saved_esp) {
+		if (&regs->esp != kcb->jprobe_saved_esp) {
 			struct pt_regs *saved_regs =
-			    container_of(jprobe_saved_esp, struct pt_regs, esp);
+			    container_of(kcb->jprobe_saved_esp,
+					    struct pt_regs, esp);
 			printk("current esp %p does not match saved esp %p\n",
-			       &regs->esp, jprobe_saved_esp);
+			       &regs->esp, kcb->jprobe_saved_esp);
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
Index: linux-2.6.14-rc3/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-i386/kprobes.h	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/include/asm-i386/kprobes.h	2005-10-05 15:26:29.000000000 -0400
@@ -49,6 +49,23 @@ struct arch_specific_insn {
 	kprobe_opcode_t insn[MAX_INSN_SIZE];
 };
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long old_eflags;
+	unsigned long saved_eflags;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_old_eflags;
+	unsigned long kprobe_saved_eflags;
+	long *jprobe_saved_esp;
+	struct pt_regs jprobe_saved_regs;
+	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
+	struct prev_kprobe prev_kprobe;
+};
 
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
