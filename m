Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVJJOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVJJOnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJJOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:43:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:9615 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750821AbVJJOnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:43:09 -0400
Date: Mon, 10 Oct 2005 10:42:48 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 4/9] Kprobes: Track kprobe on a per_cpu basis - ia64 changes
Message-ID: <20051010144248.GE4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144206.GD4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

IA64 changes to track kprobe execution on a per-cpu basis. We now track
the kprobe state machine independently on each cpu using an arch specific
kprobe control block.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/ia64/kernel/kprobes.c |   83 ++++++++++++++++++++++++---------------------
 include/asm-ia64/kprobes.h |   13 +++++++
 2 files changed, 58 insertions(+), 38 deletions(-)

Index: linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/ia64/kernel/kprobes.c	2005-10-05 15:23:17.000000000 -0400
+++ linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c	2005-10-05 15:29:28.000000000 -0400
@@ -38,13 +38,8 @@
 
 extern void jprobe_inst_return(void);
 
-/* kprobe_status settings */
-#define KPROBE_HIT_ACTIVE	0x00000001
-#define KPROBE_HIT_SS		0x00000002
-
-static struct kprobe *current_kprobe, *kprobe_prev;
-static unsigned long kprobe_status, kprobe_status_prev;
-static struct pt_regs jprobe_saved_regs;
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 enum instruction_type {A, I, M, F, B, L, X, u};
 static enum instruction_type bundle_encoding[32][3] = {
@@ -313,21 +308,22 @@ static int __kprobes valid_kprobe_addr(i
 	return 0;
 }
 
-static inline void save_previous_kprobe(void)
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	kprobe_prev = current_kprobe;
-	kprobe_status_prev = kprobe_status;
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
 }
 
-static inline void restore_previous_kprobe(void)
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = kprobe_prev;
-	kprobe_status = kprobe_status_prev;
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
 }
 
-static inline void set_current_kprobe(struct kprobe *p)
+static inline void set_current_kprobe(struct kprobe *p,
+			struct kprobe_ctlblk *kcb)
 {
-	current_kprobe = p;
+	__get_cpu_var(current_kprobe) = p;
 }
 
 static void kretprobe_trampoline(void)
@@ -389,6 +385,7 @@ int __kprobes trampoline_probe_handler(s
 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
 	regs->cr_iip = orig_ret_address;
 
+	reset_current_kprobe();
 	unlock_kprobes();
 	preempt_enable_no_resched();
 
@@ -606,12 +603,13 @@ static int __kprobes pre_kprobes_handler
 	int ret = 0;
 	struct pt_regs *regs = args->regs;
 	kprobe_opcode_t *addr = (kprobe_opcode_t *)instruction_pointer(regs);
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	/* Handle recursion cases */
 	if (kprobe_running()) {
 		p = get_kprobe(addr);
 		if (p) {
-			if ( (kprobe_status == KPROBE_HIT_SS) &&
+			if ((kcb->kprobe_status == KPROBE_HIT_SS) &&
 	 		     (p->ainsn.inst_flag == INST_FLAG_BREAK_INST)) {
   				ia64_psr(regs)->ss = 0;
 				unlock_kprobes();
@@ -623,17 +621,17 @@ static int __kprobes pre_kprobes_handler
 			 * just single step on the instruction of the new probe
 			 * without calling any user handlers.
 			 */
-			save_previous_kprobe();
-			set_current_kprobe(p);
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, kcb);
 			p->nmissed++;
 			prepare_ss(p, regs);
-			kprobe_status = KPROBE_REENTER;
+			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
 		} else if (args->err == __IA64_BREAK_JPROBE) {
 			/*
 			 * jprobe instrumented function just completed
 			 */
-			p = current_kprobe;
+			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
 			}
@@ -668,8 +666,8 @@ static int __kprobes pre_kprobes_handler
 	 * in post_kprobes_handler()
 	 */
 	preempt_disable();
-	kprobe_status = KPROBE_HIT_ACTIVE;
-	set_current_kprobe(p);
+	set_current_kprobe(p, kcb);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/*
@@ -681,7 +679,7 @@ static int __kprobes pre_kprobes_handler
 
 ss_probe:
 	prepare_ss(p, regs);
-	kprobe_status = KPROBE_HIT_SS;
+	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
 no_kprobe:
@@ -690,22 +688,25 @@ no_kprobe:
 
 static int __kprobes post_kprobes_handler(struct pt_regs *regs)
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
+	resume_execution(cur, regs);
 
 	/*Restore back the original saved kprobes variables and continue. */
-	if (kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe();
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
 		goto out;
 	}
-
+	reset_current_kprobe();
 	unlock_kprobes();
 
 out:
@@ -715,15 +716,18 @@ out:
 
 static int __kprobes kprobes_fault_handler(struct pt_regs *regs, int trapnr)
 {
-	if (!kprobe_running())
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (!cur)
 		return 0;
 
-	if (current_kprobe->fault_handler &&
-	    current_kprobe->fault_handler(current_kprobe, regs, trapnr))
+	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 		return 1;
 
-	if (kprobe_status & KPROBE_HIT_SS) {
-		resume_execution(current_kprobe, regs);
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs);
+		reset_current_kprobe();
 		unlock_kprobes();
 		preempt_enable_no_resched();
 	}
@@ -761,9 +765,10 @@ int __kprobes setjmp_pre_handler(struct 
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr = ((struct fnptr *)(jp->entry))->ip;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	/* save architectural state */
-	jprobe_saved_regs = *regs;
+	kcb->jprobe_saved_regs = *regs;
 
 	/* after rfi, execute the jprobe instrumented function */
 	regs->cr_iip = addr & ~0xFULL;
@@ -781,7 +786,9 @@ int __kprobes setjmp_pre_handler(struct 
 
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	*regs = jprobe_saved_regs;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	*regs = kcb->jprobe_saved_regs;
 	return 1;
 }
 
Index: linux-2.6.14-rc3/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-ia64/kprobes.h	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/include/asm-ia64/kprobes.h	2005-10-05 15:28:35.000000000 -0400
@@ -26,6 +26,7 @@
  */
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/percpu.h>
 #include <asm/break.h>
 
 #define MAX_INSN_SIZE   16
@@ -62,6 +63,18 @@ typedef struct _bundle {
 	} quad1;
 } __attribute__((__aligned__(16)))  bundle_t;
 
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	struct pt_regs jprobe_saved_regs;
+	struct prev_kprobe prev_kprobe;
+};
+
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 
 #define ARCH_SUPPORTS_KRETPROBES
