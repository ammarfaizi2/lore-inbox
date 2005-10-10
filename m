Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVJJOpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVJJOpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJJOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:45:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57306 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750826AbVJJOpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:45:04 -0400
Date: Mon, 10 Oct 2005 10:44:30 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 6/9] Kprobes: Track kprobe on a per_cpu basis - sparc64 changes
Message-ID: <20051010144430.GG4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com> <20051010144343.GF4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144343.GF4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,
This patch is similar to the one you reviewed sometime back:
http://sourceware.org/ml/systemtap/2005-q3/msg00196.html

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Sparc64 changes to track kprobe execution on a per-cpu basis. We now track
the kprobe state machine independently on each cpu using an arch
specific kprobe control block.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/sparc64/kernel/kprobes.c |  131 +++++++++++++++++++++---------------------
 include/asm-sparc64/kprobes.h |   20 ++++++
 2 files changed, 87 insertions(+), 64 deletions(-)

Index: linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/sparc64/kernel/kprobes.c	2005-10-05 15:24:09.000000000 -0400
+++ linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c	2005-10-05 16:06:10.000000000 -0400
@@ -38,6 +38,9 @@
  * - Mark that we are no longer actively in a kprobe.
  */
 
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	return 0;
@@ -66,46 +69,39 @@ void __kprobes arch_remove_kprobe(struct
 {
 }
 
-static struct kprobe *current_kprobe;
-static unsigned long current_kprobe_orig_tnpc;
-static unsigned long current_kprobe_orig_tstate_pil;
-static unsigned int kprobe_status;
-static struct kprobe *kprobe_prev;
-static unsigned long kprobe_orig_tnpc_prev;
-static unsigned long kprobe_orig_tstate_pil_prev;
-static unsigned int kprobe_status_prev;
-
-static inline void save_previous_kprobe(void)
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_status_prev = kprobe_status;
-	kprobe_orig_tnpc_prev = current_kprobe_orig_tnpc;
-	kprobe_orig_tstate_pil_prev = current_kprobe_orig_tstate_pil;
-	kprobe_prev = current_kprobe;
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.orig_tnpc = kcb->kprobe_orig_tnpc;
+	kcb->prev_kprobe.orig_tstate_pil = kcb->kprobe_orig_tstate_pil;
 }
 
-static inline void restore_previous_kprobe(void)
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_status = kprobe_status_prev;
-	current_kprobe_orig_tnpc = kprobe_orig_tnpc_prev;
-	current_kprobe_orig_tstate_pil = kprobe_orig_tstate_pil_prev;
-	current_kprobe = kprobe_prev;
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_orig_tnpc = kcb->prev_kprobe.orig_tnpc;
+	kcb->kprobe_orig_tstate_pil = kcb->prev_kprobe.orig_tstate_pil;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+				struct kprobe_ctlblk *kcb)
 {
-	current_kprobe_orig_tnpc = regs->tnpc;
-	current_kprobe_orig_tstate_pil = (regs->tstate & TSTATE_PIL);
-	current_kprobe = p;
+	__get_cpu_var(current_kprobe) = p;
+	kcb->kprobe_orig_tnpc = regs->tnpc;
+	kcb->kprobe_orig_tstate_pil = (regs->tstate & TSTATE_PIL);
 }
 
-static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
+			struct kprobe_ctlblk *kcb)
 {
 	regs->tstate |= TSTATE_PIL;
 
 	/*single step inline, if it a breakpoint instruction*/
 	if (p->opcode == BREAKPOINT_INSTRUCTION) {
 		regs->tpc = (unsigned long) p->addr;
-		regs->tnpc = current_kprobe_orig_tnpc;
+		regs->tnpc = kcb->kprobe_orig_tnpc;
 	} else {
 		regs->tpc = (unsigned long) &p->ainsn.insn[0];
 		regs->tnpc = (unsigned long) &p->ainsn.insn[1];
@@ -117,6 +113,7 @@ static int __kprobes kprobe_handler(stru
 	struct kprobe *p;
 	void *addr = (void *) regs->tpc;
 	int ret = 0;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
@@ -124,9 +121,9 @@ static int __kprobes kprobe_handler(stru
 		 */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS) {
+			if (kcb->kprobe_status == KPROBE_HIT_SS) {
 				regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
-					current_kprobe_orig_tstate_pil);
+					kcb->kprobe_orig_tstate_pil);
 				unlock_kprobes();
 				goto no_kprobe;
 			}
@@ -136,14 +133,14 @@ static int __kprobes kprobe_handler(stru
 			 * just single step on the instruction of the new probe
 			 * without calling any user handlers.
 			 */
-			save_previous_kprobe();
-			set_current_kprobe(p, regs);
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, regs, kcb);
 			p->nmissed++;
-			kprobe_status = KPROBE_REENTER;
-			prepare_singlestep(p, regs);
+			kcb->kprobe_status = KPROBE_REENTER;
+			prepare_singlestep(p, regs, kcb);
 			return 1;
 		} else {
-			p = current_kprobe;
+			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs))
 				goto ss_probe;
 		}
@@ -174,14 +171,14 @@ static int __kprobes kprobe_handler(stru
 	 * in post_kprobes_handler()
 	 */
 	preempt_disable();
-	set_current_kprobe(p, regs);
-	kprobe_status = KPROBE_HIT_ACTIVE;
+	set_current_kprobe(p, regs, kcb);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
 ss_probe:
-	prepare_singlestep(p, regs);
-	kprobe_status = KPROBE_HIT_SS;
+	prepare_singlestep(p, regs, kcb);
+	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
 no_kprobe:
@@ -262,11 +259,12 @@ static void __kprobes retpc_fixup(struct
  * This function prepares to return from the post-single-step
  * breakpoint trap.
  */
-static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p,
+		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	u32 insn = p->ainsn.insn[0];
 
-	regs->tpc = current_kprobe_orig_tnpc;
+	regs->tpc = kcb->kprobe_orig_tnpc;
 	regs->tnpc = relbranch_fixup(insn,
 				     (unsigned long) p->addr,
 				     (unsigned long) &p->ainsn.insn[0],
@@ -274,26 +272,30 @@ static void __kprobes resume_execution(s
 	retpc_fixup(regs, insn, (unsigned long) p->addr);
 
 	regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
-			current_kprobe_orig_tstate_pil);
+			kcb->kprobe_orig_tstate_pil);
 }
 
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
+	resume_execution(cur, regs, kcb);
 
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
@@ -304,13 +306,16 @@ out:
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
+		resume_execution(cur, regs, kcb);
 
+		reset_current_kprobe();
 		unlock_kprobes();
 		preempt_enable_no_resched();
 	}
@@ -370,24 +375,21 @@ asmlinkage void __kprobes kprobe_trap(un
 }
 
 /* Jprobes support.  */
-static struct pt_regs jprobe_saved_regs;
-static struct pt_regs *jprobe_saved_regs_location;
-static struct sparc_stackf jprobe_saved_stack;
-
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	jprobe_saved_regs_location = regs;
-	memcpy(&jprobe_saved_regs, regs, sizeof(*regs));
+	kcb->jprobe_saved_regs_location = regs;
+	memcpy(&(kcb->jprobe_saved_regs), regs, sizeof(*regs));
 
 	/* Save a whole stack frame, this gets arguments
 	 * pushed onto the stack after using up all the
 	 * arg registers.
 	 */
-	memcpy(&jprobe_saved_stack,
+	memcpy(&(kcb->jprobe_saved_stack),
 	       (char *) (regs->u_regs[UREG_FP] + STACK_BIAS),
-	       sizeof(jprobe_saved_stack));
+	       sizeof(kcb->jprobe_saved_stack));
 
 	regs->tpc  = (unsigned long) jp->entry;
 	regs->tnpc = ((unsigned long) jp->entry) + 0x4UL;
@@ -411,14 +413,15 @@ extern void __show_regs(struct pt_regs *
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	u32 *addr = (u32 *) regs->tpc;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (addr == (u32 *) jprobe_return_trap_instruction) {
-		if (jprobe_saved_regs_location != regs) {
+		if (kcb->jprobe_saved_regs_location != regs) {
 			printk("JPROBE: Current regs (%p) does not match "
 			       "saved regs (%p).\n",
-			       regs, jprobe_saved_regs_location);
+			       regs, kcb->jprobe_saved_regs_location);
 			printk("JPROBE: Saved registers\n");
-			__show_regs(jprobe_saved_regs_location);
+			__show_regs(kcb->jprobe_saved_regs_location);
 			printk("JPROBE: Current registers\n");
 			__show_regs(regs);
 			BUG();
@@ -427,11 +430,11 @@ int __kprobes longjmp_break_handler(stru
 		 * first so that UREG_FP is the original one for
 		 * the stack frame restore.
 		 */
-		memcpy(regs, &jprobe_saved_regs, sizeof(*regs));
+		memcpy(regs, &(kcb->jprobe_saved_regs), sizeof(*regs));
 
 		memcpy((char *) (regs->u_regs[UREG_FP] + STACK_BIAS),
-		       &jprobe_saved_stack,
-		       sizeof(jprobe_saved_stack));
+		       &(kcb->jprobe_saved_stack),
+		       sizeof(kcb->jprobe_saved_stack));
 
 		return 1;
 	}
Index: linux-2.6.14-rc3/include/asm-sparc64/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-sparc64/kprobes.h	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/include/asm-sparc64/kprobes.h	2005-10-05 15:33:35.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/percpu.h>
 
 typedef u32 kprobe_opcode_t;
 
@@ -18,6 +19,25 @@ struct arch_specific_insn {
 	kprobe_opcode_t insn[MAX_INSN_SIZE];
 };
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+	unsigned long orig_tnpc;
+	unsigned long orig_tstate_pil;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_orig_tnpc;
+	unsigned long kprobe_orig_tstate_pil;
+	long *jprobe_saved_esp;
+	struct pt_regs jprobe_saved_regs;
+	struct pt_regs *jprobe_saved_regs_location;
+	struct sparc_stackf jprobe_saved_stack;
+	struct prev_kprobe prev_kprobe;
+};
+
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
