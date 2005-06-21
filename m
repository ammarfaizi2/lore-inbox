Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVFUVP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVFUVP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVFUVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:03:16 -0400
Received: from fmr19.intel.com ([134.134.136.18]:15781 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262354AbVFUUyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:54:24 -0400
Message-Id: <20050621205406.001318000@linux.jf.intel.com>
References: <20050621205343.548977000@linux.jf.intel.com>
Date: Tue, 21 Jun 2005 13:53:46 -0700
From: Rusty Lynch <rusty.lynch@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-ia64@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch 3/5] Return probe redesign: x86_64 specific changes
Content-Disposition: inline; filename=kprobes-return-probes-redux-x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch contains the x86_64 specific changes for the new
return probe design.  Changes include:
 * Removing the architecture specific functions for querying a return probe
   instance off a stack address
 * Complete rework onf arch_prepare_kretprobe() and trampoline_probe_handler()
 * Removing trampoline_post_handler()
 * Adding arch_init() so that now we handle registering the return probe
   trampoline instead of kernel/kprobes.c doing it

NOTE:
Note that with this new design, the dependency on calculating a pointer to 
the task off the stack pointer no longer exist (resolving the problem of 
interruption stacks as pointed out in the original feedback to this port.)

signed-off-by: Rusty Lynch <rusty.lynch@intel.com>

 arch/x86_64/kernel/kprobes.c |  131 ++++++++++++++++++++++---------------------
 1 files changed, 69 insertions(+), 62 deletions(-)

Index: linux-2.6.12-mm1/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.12-mm1/arch/x86_64/kernel/kprobes.c
@@ -274,48 +274,23 @@ static void prepare_singlestep(struct kp
 		regs->rip = (unsigned long)p->ainsn.insn;
 }
 
-struct task_struct  *arch_get_kprobe_task(void *ptr)
-{
-	return ((struct thread_info *) (((unsigned long) ptr) &
-					(~(THREAD_SIZE -1))))->task;
-}
-
 void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
 {
 	unsigned long *sara = (unsigned long *)regs->rsp;
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
@@ -428,36 +403,59 @@ no_kprobe:
  */
 int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct task_struct *tsk;
-	struct kretprobe_instance *ri;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	unsigned long *sara = (unsigned long *)regs->rsp - 1;
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
+	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
 
-void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
-						unsigned long flags)
-{
-	struct kretprobe_instance *ri;
-	/* RA already popped */
-	unsigned long *sara = ((unsigned long *)regs->rsp) - 1;
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
-		regs->rip = (unsigned long)ri->ret_addr;
+		orig_ret_address = (unsigned long)ri->ret_addr;
 		recycle_rp_inst(ri);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
 	}
-	regs->eflags &= ~TF_MASK;
+
+	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
+	regs->rip = orig_ret_address;
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
@@ -550,8 +548,7 @@ int post_kprobe_handler(struct pt_regs *
 		current_kprobe->post_handler(current_kprobe, regs, 0);
 	}
 
-	if (current_kprobe->post_handler != trampoline_post_handler)
-		resume_execution(current_kprobe, regs);
+	resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_rflags;
 
 	/* Restore the original saved kprobes variables and continue. */
@@ -790,3 +787,13 @@ static void free_insn_slot(kprobe_opcode
 		}
 	}
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
