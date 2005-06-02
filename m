Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFBQJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFBQJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFBQJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:09:44 -0400
Received: from fmr19.intel.com ([134.134.136.18]:54174 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261169AbVFBQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:09:28 -0400
Date: Thu, 2 Jun 2005 09:09:09 -0700
Message-Id: <200506021609.j52G99Ft023464@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: akpm@osdl.org
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Vara Prasad <prasadav@us.ibm.com>, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: [patch] x86_64 specific function return probes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the x86_64 architecture specific implementation
for function return probes to the 2.6.12-rc5-mm2 kernel. 

    --rusty

 arch/x86_64/kernel/kprobes.c |   98 ++++++++++++++++++++++++++++++++++++++++++-
 arch/x86_64/kernel/process.c |   16 +++++++
 include/asm-x86_64/kprobes.h |    3 +
 3 files changed, 116 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/kprobes.c
@@ -27,6 +27,8 @@
  *		<prasanna@in.ibm.com> adapted for x86_64
  * 2005-Mar	Roland McGrath <roland@redhat.com>
  *		Fixed to handle %rip-relative addressing mode correctly.
+ * 2005-May     Rusty Lynch <rusty.lynch@intel.com>
+ *              Added function return probes functionality
  */
 
 #include <linux/config.h>
@@ -272,6 +274,50 @@ static void prepare_singlestep(struct kp
 		regs->rip = (unsigned long)p->ainsn.insn;
 }
 
+struct task_struct  *arch_get_kprobe_task(void *ptr)
+{
+	return ((struct thread_info *) (((unsigned long) ptr) &
+					(~(THREAD_SIZE -1))))->task;
+}
+
+void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+{
+	unsigned long *sara = (unsigned long *)regs->rsp;
+	struct kretprobe_instance *ri;
+	static void *orig_ret_addr;
+
+	/*
+	 * Save the return address when the return probe hits
+	 * the first time, and use it to populate the (krprobe
+	 * instance)->ret_addr for subsequent return probes at
+	 * the same addrress since stack address would have
+	 * the kretprobe_trampoline by then.
+	 */
+	if (((void*) *sara) != kretprobe_trampoline)
+		orig_ret_addr = (void*) *sara;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+		ri->stack_addr = sara;
+		ri->ret_addr = orig_ret_addr;
+		add_rp_inst(ri);
+		/* Replace the return addr with trampoline addr */
+		*sara = (unsigned long) &kretprobe_trampoline;
+	} else {
+		rp->nmissed++;
+	}
+}
+
+void arch_kprobe_flush_task(struct task_struct *tk)
+{
+	struct kretprobe_instance *ri;
+	while ((ri = get_rp_inst_tsk(tk)) != NULL) {
+		*((unsigned long *)(ri->stack_addr)) =
+					(unsigned long) ri->ret_addr;
+		recycle_rp_inst(ri);
+	}
+}
+
 /*
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
@@ -366,6 +412,55 @@ no_kprobe:
 }
 
 /*
+ * For function-return probes, init_kprobes() establishes a probepoint
+ * here. When a retprobed function returns, this probe is hit and
+ * trampoline_probe_handler() runs, calling the kretprobe's handler.
+ */
+ void kretprobe_trampoline_holder(void)
+ {
+ 	asm volatile (  ".global kretprobe_trampoline\n"
+ 			"kretprobe_trampoline: \n"
+ 			"nop\n");
+ }
+
+/*
+ * Called when we hit the probe point at kretprobe_trampoline
+ */
+int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct kretprobe_instance *ri;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	unsigned long *sara = (unsigned long *)regs->rsp - 1;
+
+	tsk = arch_get_kprobe_task(sara);
+	head = kretprobe_inst_table_head(tsk);
+
+	hlist_for_each_entry(ri, node, head, hlist) {
+		if (ri->stack_addr == sara && ri->rp) {
+			if (ri->rp->handler)
+				ri->rp->handler(ri, regs);
+		}
+	}
+	return 0;
+}
+
+void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags)
+{
+	struct kretprobe_instance *ri;
+	/* RA already popped */
+	unsigned long *sara = ((unsigned long *)regs->rsp) - 1;
+
+	while ((ri = get_rp_inst(sara))) {
+		regs->rip = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri);
+	}
+	regs->eflags &= ~TF_MASK;
+}
+
+/*
  * Called after single-stepping.  p->addr is the address of the
  * instruction whose first byte has been replaced by the "int 3"
  * instruction.  To avoid the SMP problems that can occur when we
@@ -455,7 +550,8 @@ int post_kprobe_handler(struct pt_regs *
 		current_kprobe->post_handler(current_kprobe, regs, 0);
 	}
 
-	resume_execution(current_kprobe, regs);
+	if (current_kprobe->post_handler != trampoline_post_handler)
+		resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_rflags;
 
 	/*Restore back the original saved kprobes variables and continue. */
Index: linux-2.6.12-rc5-mm2/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.12-rc5-mm2.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.12-rc5-mm2/include/asm-x86_64/kprobes.h
@@ -38,6 +38,9 @@ typedef u8 kprobe_opcode_t;
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+#define ARCH_SUPPORTS_KRETPROBES
+
+void kretprobe_trampoline(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
@@ -35,6 +35,7 @@
 #include <linux/utsname.h>
 #include <linux/perfctr.h>
 #include <linux/random.h>
+#include <linux/kprobes.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -294,6 +295,14 @@ void exit_thread(void)
 {
 	struct task_struct *me = current;
 	struct thread_struct *t = &me->thread;
+
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(me);
+
 	if (me->thread.io_bitmap_ptr) { 
 		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
 
@@ -314,6 +323,13 @@ void flush_thread(void)
 	struct task_struct *tsk = current;
 	struct thread_info *t = current_thread_info();
 
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(tsk);
+
 	if (t->flags & _TIF_ABI_PENDING)
 		t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32);
 
