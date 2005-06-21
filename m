Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVFUVAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVFUVAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVFUU6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:58:10 -0400
Received: from fmr20.intel.com ([134.134.136.19]:17068 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262350AbVFUUyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:54:20 -0400
Message-Id: <20050621205406.996100000@linux.jf.intel.com>
References: <20050621205343.548977000@linux.jf.intel.com>
Date: Tue, 21 Jun 2005 13:53:47 -0700
From: Rusty Lynch <rusty.lynch@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch 4/5] Return probe redesign: ia64 specific implementation
Content-Disposition: inline; filename=kprobes-return-probes-redux-ia64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements function return probes for ia64 using
the revised design.  With this new design we no longer need to do some
of the odd hacks previous required on the last ia64 return probe port
that I sent out for comments.

Note that this new implementation still does not resolve the problem noted
by Keith Owens where backtrace data is lost after a return probe is hit.

Changes include:
 * Addition of kretprobe_trampoline to act as a dummy function for instrumented
   functions to return to, and for the return probe infrastructure to place
   a kprobe on on, gaining control so that the return probe handler
   can be called, and so that the instruction pointer can be moved back 
   to the original return address.
 * Addition of arch_init(), allowing a kprobe to be registered on 
   kretprobe_trampoline
 * Addition of trampoline_probe_handler() which is used as the pre_handler
   for the kprobe inserted on kretprobe_implementation.  This is the function
   that handles the details for calling the return probe handler function
   and returning control back at the original return address
 * Addition of arch_prepare_kretprobe() which is setup as the pre_handler
   for a kprobe registered at the beginning of the target function by 
   kernel/kprobes.c so that a return probe instance can be setup when
   a caller enters the target function.  (A return probe instance contains
   all the needed information for trampoline_probe_handler to do it's job.)
 * Hooks added to the exit path of a task so that we can cleanup any left-over
   return probe instances (i.e. if a task dies while inside a targeted function
   then the return probe instance was reserved at the beginning of the function
   but the function never returns so we need to mark the instance as unused.)

    --rusty

signed-off-by: Rusty Lynch <rusty.lynch@intel.com>

 arch/ia64/kernel/kprobes.c |  103 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/ia64/kernel/process.c |   16 ++++++
 include/asm-ia64/kprobes.h |   13 +++--
 3 files changed, 125 insertions(+), 7 deletions(-)

Index: linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
@@ -290,6 +290,94 @@ static inline void set_current_kprobe(st
 	current_kprobe = p;
 }
 
+static void kretprobe_trampoline(void)
+{
+}
+
+/*
+ * At this point the target function has been tricked into
+ * returning into our trampoline.  Lookup the associated instance
+ * and then:
+ *    - call the handler function
+ *    - cleanup by marking the instance as unused
+ *    - long jump back to the original return address
+ */
+int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node, *tmp;
+	unsigned long orig_ret_address = 0;
+	unsigned long trampoline_address =
+		((struct fnptr *)kretprobe_trampoline)->ip;
+
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
+	 *       function, the first instance's ret_addr will point to the
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
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
+	regs->cr_iip = orig_ret_address;
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
+}
+
+void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+		ri->task = current;
+		ri->ret_addr = (kprobe_opcode_t *)regs->b0;
+
+		/* Replace the return addr with trampoline addr */
+		regs->b0 = ((struct fnptr *)kretprobe_trampoline)->ip;
+
+		add_rp_inst(ri);
+	} else {
+		rp->nmissed++;
+	}
+}
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long) p->addr;
@@ -492,8 +580,8 @@ static int pre_kprobes_handler(struct di
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/*
 		 * Our pre-handler is specifically requesting that we just
-		 * do a return.  This is handling the case where the
-		 * pre-handler is really our special jprobe pre-handler.
+		 * do a return.  This is used for both the jprobe pre-handler
+		 * and the kretprobe trampoline
 		 */
 		return 1;
 
@@ -599,3 +687,14 @@ int longjmp_break_handler(struct kprobe 
 	*regs = jprobe_saved_regs;
 	return 1;
 }
+
+static struct kprobe trampoline_p = {
+	.pre_handler = trampoline_probe_handler
+};
+
+int __init arch_init(void)
+{
+	trampoline_p.addr =
+		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip;
+	return register_kprobe(&trampoline_p);
+}
Index: linux-2.6.12-mm1/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-mm1.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-mm1/include/asm-ia64/kprobes.h
@@ -63,6 +63,8 @@ typedef struct _bundle {
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 
+#define ARCH_SUPPORTS_KRETPROBES
+
 #define SLOT0_OPCODE_SHIFT	(37)
 #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
 #define SLOT2_OPCODE_SHIFT 	(37)
@@ -94,11 +96,6 @@ struct arch_specific_insn {
 };
 
 /* ia64 does not need this */
-static inline void jprobe_return(void)
-{
-}
-
-/* ia64 does not need this */
 static inline void arch_copy_kprobe(struct kprobe *p)
 {
 }
@@ -106,6 +103,12 @@ static inline void arch_copy_kprobe(stru
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
+
+/* ia64 does not need this */
+static inline void jprobe_return(void)
+{
+}
+
 #else				/* !CONFIG_KPROBES */
 static inline int kprobe_exceptions_notify(struct notifier_block *self,
 					   unsigned long val, void *data)
Index: linux-2.6.12-mm1/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/process.c
+++ linux-2.6.12-mm1/arch/ia64/kernel/process.c
@@ -27,6 +27,7 @@
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/kprobes.h>
 
 #include <asm/cpu.h>
 #include <asm/delay.h>
@@ -707,6 +708,13 @@ kernel_thread_helper (int (*fn)(void *),
 void
 flush_thread (void)
 {
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(current);
+
 	/* drop floating-point and debug-register state if it exists: */
 	current->thread.flags &= ~(IA64_THREAD_FPH_VALID | IA64_THREAD_DBG_VALID);
 	ia64_drop_fpu(current);
@@ -721,6 +729,14 @@ flush_thread (void)
 void
 exit_thread (void)
 {
+
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(current);
+
 	ia64_drop_fpu(current);
 #ifdef CONFIG_PERFMON
        /* if needed, stop monitoring and flush state to perfmon context */

--
