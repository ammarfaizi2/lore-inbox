Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFMVAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFMVAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFMVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:00:36 -0400
Received: from fmr19.intel.com ([134.134.136.18]:40844 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261354AbVFMUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:52:41 -0400
Message-Id: <20050613205236.873920000@linux.jf.intel.com>
References: <20050613205153.349171000@linux.jf.intel.com>
Date: Mon, 13 Jun 2005 13:51:58 -0700
From: rusty.lynch@intel.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [patch 5/5] [kprobes] Tweak to the function return probe design 
Content-Disposition: inline; filename=kprobes-return-probes-redux-ppc64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The following is a resend from this morning.  The various kernel mailing list
did not seem to get my email, so I am resending the patch series from another
machine.  I also included a fix to the problem that Ananth pointed out.)

The following is a patch provided by Ananth Mavinakayanahalli that implements
the new PPC64 specific parts of the new function return probe design. 

NOTE: Since getting Ananth's patch, I changed trampoline_probe_handler()
      to consume each of the outstanding return probem instances (feedback
      on my original RFC after Ananth cut a patch), and also added the 
      arch_init() function (adding arch specific initialization.) I have
      cross compiled but have not testing this on a PPC64 machine.

    --rusty

 arch/ppc64/kernel/kprobes.c |   98 ++++++++++++++++++++++++++++++++++++++++++++
 arch/ppc64/kernel/process.c |    4 +
 include/asm-ppc64/kprobes.h |    3 +
 3 files changed, 105 insertions(+)

Index: linux-2.6.12-rc6-mm1/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/ppc64/kernel/kprobes.c
+++ linux-2.6.12-rc6-mm1/arch/ppc64/kernel/kprobes.c
@@ -100,6 +100,23 @@ static inline void restore_previous_kpro
 	kprobe_saved_msr = kprobe_saved_msr_prev;
 }
 
+void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+		ri->task = current;
+		ri->ret_addr = (kprobe_opcode_t *)regs->link;
+
+		/* Replace the return addr with trampoline addr */
+		regs->link = (unsigned long)kretprobe_trampoline;
+		add_rp_inst(ri);
+	} else {
+		rp->nmissed++;
+	}
+}
+
 static inline int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
@@ -190,6 +207,77 @@ no_kprobe:
 }
 
 /*
+ * Function return probe trampoline:
+ * 	- init_kprobes() establishes a probepoint here
+ * 	- When the probed function returns, this probe
+ * 		causes the handlers to fire
+ */
+void kretprobe_trampoline_holder(void)
+{
+	asm volatile(".global kretprobe_trampoline\n"
+			"kretprobe_trampoline:\n"
+			"nop\n");
+}
+
+/*
+ * Called when the probe at kretprobe trampoline is hit
+ */
+int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+        struct kretprobe_instance *ri = NULL;
+        struct hlist_head *head;
+        struct hlist_node *node, *tmp;
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
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri);
+
+		if (orig_ret_address != (unsigned long) &kretprobe_trampoline)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	BUG_ON(!orig_ret_address);
+	regs->nip = orig_ret_address;
+
+	unlock_kprobes();
+
+        /*
+         * By returning a non-zero value, we are telling
+         * kprobe_handler() that we have handled unlocking
+         * and re-enabling preemption.
+         */
+        return 1;
+}
+
+/*
  * Called after single-stepping.  p->addr is the address of the
  * instruction whose first byte has been replaced by the "breakpoint"
  * instruction.  To avoid the SMP problems that can occur when we
@@ -329,3 +417,13 @@ int longjmp_break_handler(struct kprobe 
 	memcpy(regs, &jprobe_saved_regs, sizeof(struct pt_regs));
 	return 1;
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
Index: linux-2.6.12-rc6-mm1/arch/ppc64/kernel/process.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/ppc64/kernel/process.c
+++ linux-2.6.12-rc6-mm1/arch/ppc64/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/interrupt.h>
 #include <linux/utsname.h>
 #include <linux/perfctr.h>
+#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -310,6 +311,8 @@ void show_regs(struct pt_regs * regs)
 
 void exit_thread(void)
 {
+	kprobe_flush_task(current);
+
 #ifndef CONFIG_SMP
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
@@ -325,6 +328,7 @@ void flush_thread(void)
 {
 	struct thread_info *t = current_thread_info();
 
+	kprobe_flush_task(current);
 	if (t->flags & _TIF_ABI_PENDING)
 		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
 
Index: linux-2.6.12-rc6-mm1/include/asm-ppc64/kprobes.h
===================================================================
--- linux-2.6.12-rc6-mm1.orig/include/asm-ppc64/kprobes.h
+++ linux-2.6.12-rc6-mm1/include/asm-ppc64/kprobes.h
@@ -42,6 +42,9 @@ typedef unsigned int kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
+#define ARCH_SUPPORTS_KRETPROBES
+void kretprobe_trampoline(void);
+
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */

--
