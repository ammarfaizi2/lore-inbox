Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFMVAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFMVAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFMU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:59:04 -0400
Received: from fmr19.intel.com ([134.134.136.18]:40588 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261350AbVFMUwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:52:40 -0400
Message-Id: <20050613205235.308105000@linux.jf.intel.com>
References: <20050613205153.349171000@linux.jf.intel.com>
Date: Mon, 13 Jun 2005 13:51:55 -0700
From: rusty.lynch@intel.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [patch 2/5] [kprobes] Tweak to the function return probe design 
Content-Disposition: inline; filename=kprobes-return-probes-redux-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The following is a resend from this morning.  The various kernel mailing list
did not seem to get my email, so I am resending the patch series from another
machine.)

The following patch contains the i386 specific changes for the new
return probe design.

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 arch/i386/kernel/kprobes.c |  130 +++++++++++++++++++++++----------------------
 1 files changed, 68 insertions(+), 62 deletions(-)

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/kprobes.c
@@ -127,48 +127,23 @@ static inline void prepare_singlestep(st
 		regs->eip = (unsigned long)&p->ainsn.insn;
 }
 
-struct task_struct  *arch_get_kprobe_task(void *ptr)
-{
-	return ((struct thread_info *) (((unsigned long) ptr) &
-					(~(THREAD_SIZE -1))))->task;
-}
-
 void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
 {
 	unsigned long *sara = (unsigned long *)&regs->esp;
-	struct kretprobe_instance *ri;
-	static void *orig_ret_addr;
+        struct kretprobe_instance *ri;
 
-	/*
-	 * Save the return address when the return probe hits
-	 * the first time, and use it to populate the (krprobe
-	 * instance)->ret_addr for subsequent return probes at
-	 * the same addrress since stack address would have
-	 * the kretprobe_trampoline by then.
-	 */
-	if (((void*) *sara) != kretprobe_trampoline)
-		orig_ret_addr = (void*) *sara;
+        if ((ri = get_free_rp_inst(rp)) != NULL) {
+                ri->rp = rp;
+                ri->task = current;
+		ri->ret_addr = (kprobe_opcode_t *) *sara;
 
-	if ((ri = get_free_rp_inst(rp)) != NULL) {
-		ri->rp = rp;
-		ri->stack_addr = sara;
-		ri->ret_addr = orig_ret_addr;
-		add_rp_inst(ri);
 		/* Replace the return addr with trampoline addr */
 		*sara = (unsigned long) &kretprobe_trampoline;
-	} else {
-		rp->nmissed++;
-	}
-}
 
-void arch_kprobe_flush_task(struct task_struct *tk)
-{
-	struct kretprobe_instance *ri;
-	while ((ri = get_rp_inst_tsk(tk)) != NULL) {
-		*((unsigned long *)(ri->stack_addr)) =
-					(unsigned long) ri->ret_addr;
-		recycle_rp_inst(ri);
-	}
+                add_rp_inst(ri);
+        } else {
+                rp->nmissed++;
+        }
 }
 
 /*
@@ -286,36 +261,58 @@ no_kprobe:
  */
 int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct task_struct *tsk;
-	struct kretprobe_instance *ri;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	unsigned long *sara = ((unsigned long *) &regs->esp) - 1;
-
-	tsk = arch_get_kprobe_task(sara);
-	head = kretprobe_inst_table_head(tsk);
-
-	hlist_for_each_entry(ri, node, head, hlist) {
-		if (ri->stack_addr == sara && ri->rp) {
-			if (ri->rp->handler)
-				ri->rp->handler(ri, regs);
-		}
-	}
-	return 0;
-}
+        struct kretprobe_instance *ri = NULL;
+        struct hlist_head *head;
+        struct hlist_node *node, *tmp;
+	unsigned long orig_ret_address = 0;
 
-void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
-						unsigned long flags)
-{
-	struct kretprobe_instance *ri;
-	/* RA already popped */
-	unsigned long *sara = ((unsigned long *)&regs->esp) - 1;
+        head = kretprobe_inst_table_head(current);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because an multiple functions in the call path
+	 * have a return probe installed on them, and/or more then one return
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always inserted at the head of the list
+	 *     - when multiple return probes are registered for the same
+         *       function, the first instance's ret_addr will point to the
+	 *       real return address, and all the rest will point to
+	 *       kretprobe_trampoline
+	 */
+	hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+                if (ri->task != current)
+			/* another task is sharing our hash bucket */
+                        continue;
+
+		if (ri->rp && ri->rp->handler)
+			ri->rp->handler(ri, regs);
 
-	while ((ri = get_rp_inst(sara))) {
-		regs->eip = (unsigned long)ri->ret_addr;
+		orig_ret_address = (unsigned long)ri->ret_addr;
 		recycle_rp_inst(ri);
+
+		if (orig_ret_address != (unsigned long) &kretprobe_trampoline)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
 	}
-	regs->eflags &= ~TF_MASK;
+
+	BUG_ON(!orig_ret_address);
+	regs->eip = orig_ret_address;
+
+	unlock_kprobes();
+	preempt_enable_no_resched();
+
+        /*
+         * By returning a non-zero value, we are telling
+         * kprobe_handler() that we have handled unlocking
+         * and re-enabling preemption.
+         */
+        return 1;
 }
 
 /*
@@ -403,8 +400,7 @@ static inline int post_kprobe_handler(st
 		current_kprobe->post_handler(current_kprobe, regs, 0);
 	}
 
-	if (current_kprobe->post_handler != trampoline_post_handler)
-		resume_execution(current_kprobe, regs);
+	resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_eflags;
 
 	/*Restore back the original saved kprobes variables and continue. */
@@ -534,3 +530,13 @@ int longjmp_break_handler(struct kprobe 
 	}
 	return 0;
 }
+
+static struct kprobe trampoline_p = {
+	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
+	.pre_handler = trampoline_probe_handler
+};
+
+int __init arch_init(void)
+{
+	return register_kprobe(&trampoline_p);
+}

--
