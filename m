Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVFPXMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVFPXMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVFPWf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:35:27 -0400
Received: from fmr20.intel.com ([134.134.136.19]:15791 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261843AbVFPWde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:33:34 -0400
Message-Id: <20050616223308.007672000@linux.jf.intel.com>
References: <20050616223139.444305000@linux.jf.intel.com>
Date: Thu, 16 Jun 2005 15:31:44 -0700
From: rusty.lynch@intel.com
To: akpm@osdl.org
Cc: systemtap@sources.redhat.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, Andi Kleen <ak@suse.de>,
       Ananth N Mavinakayanahalli <amavin@redhat.com>,
       linuxppc64-dev@ozlabs.org
Subject: [patch 5/5] [kprobes] Tweak to the function return probe design - take 2
Content-Disposition: inline; filename=kprobes-return-probes-redux-ppc64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a patch provided by Ananth Mavinakayanahalli that implements
the new PPC64 specific parts of the new function return probe design. 

NOTE: Since getting Ananth's patch, I changed trampoline_probe_handler()
      to consume each of the outstanding return probem instances (feedback
      on my original RFC after Ananth cut a patch), and also added the 
      arch_init() function (adding arch specific initialization.) I have
      cross compiled but have not testing this on a PPC64 machine.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 arch/ppc64/kernel/kprobes.c |   99 ++++++++++++++++++++++++++++++++++++++++++++
 arch/ppc64/kernel/process.c |    4 +
 include/asm-ppc64/kprobes.h |    3 +
 3 files changed, 106 insertions(+)

Index: ppc64-2.6.12-rc6-mm1/arch/ppc64/kernel/kprobes.c
===================================================================
--- ppc64-2.6.12-rc6-mm1.orig/arch/ppc64/kernel/kprobes.c
+++ ppc64-2.6.12-rc6-mm1/arch/ppc64/kernel/kprobes.c
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
@@ -190,6 +207,78 @@ no_kprobe:
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
+	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
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
@@ -329,3 +418,13 @@ int longjmp_break_handler(struct kprobe 
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
Index: ppc64-2.6.12-rc6-mm1/arch/ppc64/kernel/process.c
===================================================================
--- ppc64-2.6.12-rc6-mm1.orig/arch/ppc64/kernel/process.c
+++ ppc64-2.6.12-rc6-mm1/arch/ppc64/kernel/process.c
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
 
Index: ppc64-2.6.12-rc6-mm1/include/asm-ppc64/kprobes.h
===================================================================
--- ppc64-2.6.12-rc6-mm1.orig/include/asm-ppc64/kprobes.h
+++ ppc64-2.6.12-rc6-mm1/include/asm-ppc64/kprobes.h
@@ -42,6 +42,9 @@ typedef unsigned int kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
+#define ARCH_SUPPORTS_KRETPROBES
+void kretprobe_trampoline(void);
+
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */

--
