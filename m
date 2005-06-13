Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFMUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFMUzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFMUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:54:33 -0400
Received: from fmr18.intel.com ([134.134.136.17]:31174 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261341AbVFMUwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:52:38 -0400
Message-Id: <20050613205236.351353000@linux.jf.intel.com>
References: <20050613205153.349171000@linux.jf.intel.com>
Date: Mon, 13 Jun 2005 13:51:57 -0700
From: rusty.lynch@intel.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [patch 4/5] [kprobes] Tweak to the function return probe design 
Content-Disposition: inline; filename=kprobes-return-probes-redux-ia64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The following is a resend from this morning.  The various kernel mailing list
did not seem to get my email, so I am resending the patch series from another
machine.)

The following patch implements function return probes for ia64 using
the revised design.  With this new design we no longer need to do some
of the odd hacks previous required on the last ia64 return probe port
that I sent out for comments.

Note that this new implementation still does not resolve the problem noted
by Keith Owens where backtrace data is lost after a return probe is hit.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 arch/ia64/kernel/kprobes.c |  102 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/ia64/kernel/process.c |   16 +++++++
 include/asm-ia64/kprobes.h |    2 
 3 files changed, 118 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc6/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc6/arch/ia64/kernel/kprobes.c
@@ -290,6 +290,93 @@ static inline void set_current_kprobe(st
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
+		if (orig_ret_address !=
+		    ((struct fnptr *)kretprobe_trampoline)->ip)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	BUG_ON(!orig_ret_address);
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
@@ -492,8 +579,8 @@ static int pre_kprobes_handler(struct di
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/*
 		 * Our pre-handler is specifically requesting that we just
-		 * do a return.  This is handling the case where the
-		 * pre-handler is really our special jprobe pre-handler.
+		 * do a return.  This is used for both the jprobe pre-handler
+		 * and the kretprobe trampoline
 		 */
 		return 1;
 
@@ -599,3 +686,14 @@ int longjmp_break_handler(struct kprobe 
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
Index: linux-2.6.12-rc6/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc6.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-rc6/include/asm-ia64/kprobes.h
@@ -63,6 +63,8 @@ typedef struct _bundle {
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 
+#define ARCH_SUPPORTS_KRETPROBES
+
 #define SLOT0_OPCODE_SHIFT	(37)
 #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
 #define SLOT2_OPCODE_SHIFT 	(37)
Index: linux-2.6.12-rc6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/ia64/kernel/process.c
+++ linux-2.6.12-rc6/arch/ia64/kernel/process.c
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
