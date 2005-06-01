Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFAVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFAVrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFAVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:46:07 -0400
Received: from fmr18.intel.com ([134.134.136.17]:58257 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261317AbVFAVjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:39:39 -0400
Date: Wed, 1 Jun 2005 14:39:22 -0700
Message-Id: <200506012139.j51LdMhY031546@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
Subject: [RFC] ia64 function return probes
To: linux-ia64@vger.kernel.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, Rusty Lynch <rusty.lynch@intel.com>,
       systemtap@sources.redhat.com, Hien Nguyen <hien@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is an implementation of the ia64 specific parts for implementing
the function return probes functionality that is a part of kprobes.  There 
were some assumptions about how the architectures work inside kernel/kprobes.c
that force me to do some odd things in this implementation.

For those that have not followed the function return probe discussions, the 
original idea is that in order to have a handler function called when a 
target function returns:

* At system initialization time, kernel/kprobes.c installs a kprobe
  on a function called kretprobe_trampoline() that is implemented in 
  the architecture specific code.  More on this later.

* When a return probe is registered using register_kretprobe(), 
  kernel/kprobes.c will install a kprobe on the first instruction of the 
  targeted function with the pre handler set to arch_prepare_kretprobe()
  which is implemented in the architecture specific code.

* arch_prepare_kretprobe() will prepare a kretprobe instance that stores:
  - nodes for hanging this instance in an empty or free list
  - a pointer to the return probe
  - the original return address
  - a pointer to the stack address

  With all this stowed away, arch_prepare_kretprobe() then sets the return
  address for the targeted function to a special trampoline function called
  kretprobe_trampoline().  

* The kprobe completes as normal, with control passing back to the target
  function that executes as normal, and eventually returns to our trampoline
  function.

* Since a kprobe was installed on kretprobe_trampoline() during system 
  initialization, control passes back to kprobes via the architecture
  specific function trampoline_probe_handler() which will lookup the 
  instance in an hlist maintained by kernel/kprobes.c, and then call
  the handler function.

* When trampoline_probe_handler() is done, the kprobes infrastruction
  single steps the original instruction (in this case just a nop), and
  then calls trampoline_post_handler().  trampoline_post_handler() then
  looks up the instance again, puts the instance back on the free list,
  and then makes a long jump back to the original return instruction.


Ok, that was the idea.  For ia64 complexities came up with respect to:

* the assumption that kernel/kprobes.c is working with a 
  stacked based architecture

* the assumption that changing the return address to kretprobe_trampoline()
  will always result in the first instruction of of kretprobe_trampoline
  being executed.

The following patch works around these problems by:

* Providing an empty kretprobe_trampoline(), but we don't really 
  use it as our trampoline function.  Instead we provide:

	/*
	 * void ia64_kretprobe_trampoline(void):
	 *
	 * When a return probe is set on a given function, it's return
	 * address (which really just points to the bundle) is set for
	 * this single bundle function.
	 *
	 * We don't know which slot of the bundle will be set, so we set
	 * a break using a special immediate value to gain control in
	 * each case so the registered return probe can be called and then
	 * restore the cr->iip  back to the real address
	 * (i.e. the original return address)
	 */
GLOBAL_ENTRY(ia64_kretprobe_trampoline)
{ .mii
	break.m __IA64_BREAK_RPROBE
	break.i __IA64_BREAK_RPROBE
	break.i __IA64_BREAK_RPROBE
}
END(ia64_kretprobe_trampoline)

  ... and then handle the break interrupts using this new reserved immediate
  value by just directly calling trampoline_probe_handler().

  Also, we do everything in trampoline_probe_handler() so there is no need
  to single step a nop instruction.

* The instances are stored in an hlist hashed off the task pointer, but it is 
  possible for more then one hash to use the same slot.  We use the return 
  probe instance stack_addr field to point to the pt_regs structure.  With this 
  information, plus an assumption that the first entry in the list for the 
  given task will always be the correct instance for recursive functions, 
  we have all we need.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 arch/ia64/kernel/Makefile     |    2 
 arch/ia64/kernel/kprobes.c    |  155 +++++++++++++++++++++++++++++++++++++++++-
 arch/ia64/kernel/kretprobes.S |   44 +++++++++++
 arch/ia64/kernel/process.c    |   16 ++++
 arch/ia64/kernel/traps.c      |    1 
 include/asm-ia64/break.h      |    2 
 include/asm-ia64/kprobes.h    |    3 
 7 files changed, 221 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/Makefile
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/Makefile
+++ linux-2.6.12-rc5/arch/ia64/kernel/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_SMP)		+= smp.o smpboot.o do
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o kretprobes.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
 # The gate DSO image is built using a special linker script.
Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -1,4 +1,4 @@
-/*
+ /*
  *  Kernel Probes (KProbes)
  *  arch/ia64/kernel/kprobes.c
  *
@@ -36,6 +36,7 @@
 #include <asm/kdebug.h>
 
 extern void jprobe_inst_return(void);
+extern void ia64_kretprobe_trampoline(void);
 
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
@@ -98,6 +99,132 @@ static inline void set_current_kprobe(st
 	current_kprobe = p;
 }
 
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
+	struct task_struct *tsk;
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node;
+
+	tsk = arch_get_kprobe_task(regs);
+	head = kretprobe_inst_table_head(tsk);
+
+	/*
+	 * The first instance associated with the task is the instance
+	 * we need for this function return
+	 */
+	hlist_for_each_entry(ri, node, head, hlist)
+                /* we are using ri->stack_addr as a pt_regs pointer */
+		if (arch_get_kprobe_task(ri->stack_addr) == tsk)
+			break;
+
+	BUG_ON(!ri);
+
+	if (ri->rp && ri->rp->handler)
+		ri->rp->handler(ri, regs);
+
+	regs->cr_iip = (unsigned long)ri->ret_addr;
+	recycle_rp_inst(ri);
+
+	unlock_kprobes();
+	preempt_enable_no_resched();
+
+	/*
+	 * By returning a non-zero value, we are telling
+	 * pre_kprobes_handle() that we have handled unlocking
+	 * and re-enabling preemption.
+	 */
+	return 1;
+}
+
+/*
+ * The other architectures only call the return probe handler from the
+ * trampoline_probe_handler(), and then perform the cleanup and long
+ * jump from this function that gets called after single stepping the
+ * original nop instruction.
+ *
+ * We handle all of this from the trampoline_probe_handler() and do not
+ * need the extra overhead of single stepping the nop instruction.  This
+ * function is just hear to make kernel/kprobes.c happy.
+ */
+void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
+			     unsigned long flags)
+{
+}
+
+struct task_struct  *arch_get_kprobe_task(void *ptr)
+{
+
+	return (struct task_struct *)(((struct pt_regs *)ptr)->r13);
+}
+
+void arch_kprobe_flush_task(struct task_struct *tk)
+{
+	struct kretprobe_instance *ri;
+	struct hlist_head *head;
+	struct hlist_node *node, *tmp;
+
+	head = kretprobe_inst_table_head(tk);
+
+	/*
+	 * The task is dead so cleanup any remaining instances
+	 */
+	hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+		/*
+		 * The other arch's adjust the return address back
+		 * for each return probe instance, but that seems like
+		 * nonsense to me.  The only reason this this function
+		 * is called is because the task has died before it
+		 * had a chance to finish some return probes.
+		 *
+		 * What's the point in setting the return address of a dead
+		 * task, and is it even safe to be mucking around with
+		 * the task memory at this point?
+		 */
+
+		/* we are using ri->stack_addr as a pt_regs pointer */
+		if (arch_get_kprobe_task(ri->stack_addr) == tk)
+			recycle_rp_inst(ri);
+	}
+}
+
+void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+
+		/*
+		 * The stack address doesn't help us much for ia64,
+		 * so we overload this as a task pointer
+		 */
+		ri->stack_addr = regs;
+
+		/*
+		 * TODO: Properly handle the special cases where b6 or b7
+		 * is used instead of b0 for the return address
+		 */
+		ri->ret_addr = (unsigned long *)regs->b0;
+		regs->b0 = ((struct fnptr *)(ia64_kretprobe_trampoline))->ip;
+
+		/*
+		 * How is this instance list protected?
+		 */
+		add_rp_inst(ri);
+	} else {
+		rp->nmissed++;
+	}
+}
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long) p->addr;
@@ -310,6 +437,11 @@ static int pre_kprobes_handler(struct di
 
 	preempt_disable();
 
+	if (args->err == __IA64_BREAK_RPROBE) {
+		trampoline_probe_handler(0, regs);
+		return 1;
+	}
+
 	/* Handle recursion cases */
 	if (kprobe_running()) {
 		p = get_kprobe(addr);
@@ -464,3 +596,24 @@ int longjmp_break_handler(struct kprobe 
 	*regs = jprobe_saved_regs;
 	return 1;
 }
+
+/*
+ * kernel/kprobes.c assumes that this is the function where we redirect
+ * functions that have a return probe installed.  The idea is that
+ * kernel/kprobes.c then installs a kprobe on the first instruction of this
+ * function to gain control after the targeted function returns.
+ *
+ * For ia64 the return address is just the bundle address and the correct
+ * slot to execute inside that bundle is restored via the psr.ri when the
+ * return instruction is executed.  Therefore we need our trampoline to
+ * have a break on each slot of the first bundle, not just the the first
+ * instruction (i.e. the first slot of the first bundle.)
+ *
+ * We do this without the help of kernel/kprobes.c by writting a function
+ * in kretprobes.S that is just a bundle of break instructions using reserved
+ * immediate value for this purpose.  When we catch that specific break
+ * instruction, we call trampoline_probe_handle() directly.
+ */
+void kretprobe_trampoline(void)
+{
+}
Index: linux-2.6.12-rc5/arch/ia64/kernel/kretprobes.S
===================================================================
--- /dev/null
+++ linux-2.6.12-rc5/arch/ia64/kernel/kretprobes.S
@@ -0,0 +1,44 @@
+/*
+ * return probe specific operations
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Intel Corporation, 2005
+ *
+ * 2005-May     Rusty Lynch <rusty.lynch@intel.com>
+ */
+#include <asm/break.h>
+#include <asm/asmmacro.h>
+
+	/*
+	 * void ia64_kretprobe_trampoline(void):
+	 *
+	 * When a return probe is set on a given function, it's return
+	 * address (which really just points to the bundle) is set for
+	 * this single bundle function.
+	 *
+	 * We don't know which slot of the bundle will be set, so we set
+	 * a break using a special immediate value to gain control in
+	 * each case so the registered return probe can be called and then
+	 * restore the cr->iip  back to the real address
+	 * (i.e. the original return address)
+	 */
+GLOBAL_ENTRY(ia64_kretprobe_trampoline)
+{ .mii
+	break.m __IA64_BREAK_RPROBE
+	break.i __IA64_BREAK_RPROBE
+	break.i __IA64_BREAK_RPROBE
+}
+END(ia64_kretprobe_trampoline)
Index: linux-2.6.12-rc5/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc5.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-rc5/include/asm-ia64/kprobes.h
@@ -45,6 +45,9 @@ typedef struct _bundle {
 } __attribute__((__aligned__(16)))  bundle_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+#define ARCH_SUPPORTS_KRETPROBES
+
+void kretprobe_trampoline(void);
 
 #define SLOT0_OPCODE_SHIFT	(37)
 #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
Index: linux-2.6.12-rc5/include/asm-ia64/break.h
===================================================================
--- linux-2.6.12-rc5.orig/include/asm-ia64/break.h
+++ linux-2.6.12-rc5/include/asm-ia64/break.h
@@ -13,8 +13,10 @@
  */
 #define __IA64_BREAK_KDB		0x80100
 #define __IA64_BREAK_KPROBE		0x80200
+#define __IA64_BREAK_RPROBE             0x80201
 #define __IA64_BREAK_JPROBE		0x80300
 
+
 /*
  * OS-specific break numbers:
  */
Index: linux-2.6.12-rc5/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/traps.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/traps.c
@@ -190,6 +190,7 @@ ia64_bad_break (unsigned long break_num,
 		break;
 
 	      case 0x80200:
+	      case 0x80201:
 	      case 0x80300:
 		if (notify_die(DIE_BREAK, "kprobe", regs, break_num, TRAP_BRKPT, SIGTRAP)
 			       	== NOTIFY_STOP) {
Index: linux-2.6.12-rc5/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/process.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/process.c
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
