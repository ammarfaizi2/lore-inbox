Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbUKRKQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUKRKQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKRKPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:15:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12948 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262710AbUKRKMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:12:52 -0500
Date: Thu, 18 Nov 2004 15:43:02 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc64-dev@ozlabs.org
Cc: paulus@samba.org, anton@samba.org, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Kprobes for PPC64 - updated
Message-ID: <20041118101302.GA8830@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the updated kprobes patch for ppc64. Paul's "move emulate_step 
to arch/ppc64/lib" patch is a prereq.

Current patch is against 2.6.9-rc2-mm1.

Kprobes (Kernel dynamic probes) is a lightweight mechanism for kernel
modules to insert probes into a running kernel, without the need to
modify the underlying source. The probe handlers can then be coded
to log relevent data at the probe point. More information on kprobes
can be found at:
                                                                                
     http://www-124.ibm.com/developerworks/oss/linux/projects/kprobes/
                                                                                
Jprobes (or jumper probes) is a small infrastructure to access function
arguments. It can be used by defining a small stub with the same
template as the routine in kernel, within which the required parameters
can be logged.
                                                       
Thanks,
Ananth

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/Kconfig.debug linux-2.6.10-rc2/arch/ppc64/Kconfig.debug
--- temp/linux-2.6.10-rc2/arch/ppc64/Kconfig.debug	2004-11-15 06:58:19.000000000 +0530
+++ linux-2.6.10-rc2/arch/ppc64/Kconfig.debug	2004-11-18 11:19:50.000000000 +0530
@@ -6,6 +6,16 @@ config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
 
+config KPROBES
+	bool "Kprobes"
+	depends on DEBUG_KERNEL
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/kernel/kprobes.c linux-2.6.10-rc2/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.10-rc2/arch/ppc64/kernel/kprobes.c	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.10-rc2/arch/ppc64/kernel/kprobes.c	2004-11-18 11:23:44.000000000 +0530
@@ -0,0 +1,258 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  arch/ppc64/kernel/kprobes.c
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes contributions from
+ *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
+ * 2004-Nov	Ananth N Mavinakayanahalli <ananth@in.ibm.com> kprobes port
+ *		for PPC64
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/preempt.h>
+#include <asm/kdebug.h>
+#include <asm/sstep.h>
+
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+static struct kprobe *current_kprobe;
+static unsigned long kprobe_status, kprobe_saved_msr;
+static struct pt_regs jprobe_saved_regs;
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	if (IS_MTMSRD(p->ainsn.insn[0]) || IS_RFID(p->ainsn.insn[0]))
+		/* cannot put bp on RFID/MTMSRD */ 
+		return 1;
+	return 0;
+}
+
+void arch_remove_kprobe(struct kprobe *p)
+{
+}
+
+static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	*p->addr = p->opcode;
+	regs->nip = (unsigned long)p->addr;
+}
+
+static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->msr |= MSR_SE;
+	regs->nip = (unsigned long)&p->ainsn.insn;
+}
+
+static inline int kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	unsigned int *addr = (unsigned int *)regs->nip;
+
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* Check we're not actually recursing */
+	if (kprobe_running()) {
+		/* We *are* holding lock here, so this is safe.
+		   Disarm the probe we just hit, and ignore it. */
+		p = get_kprobe(addr);
+		if (p) {
+			disarm_kprobe(p, regs);
+			ret = 1;
+		} else {
+			p = current_kprobe;
+			if (p->break_handler && p->break_handler(p, regs)) {
+				goto ss_probe;
+			}
+		}
+		/* If it's not ours, can't be delete race, (we hold lock). */
+		goto no_kprobe;
+	}
+
+	lock_kprobes();
+	p = get_kprobe(addr);
+	if (!p) {
+		unlock_kprobes();
+		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 */
+			ret = 1;
+		}
+		/* Not one of ours: let kernel handle it */
+		goto no_kprobe;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	current_kprobe = p;
+	kprobe_saved_msr = regs->msr;
+	if (p->pre_handler(p, regs)) {
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+	}
+
+ss_probe:
+	prepare_singlestep(p, regs);
+	kprobe_status = KPROBE_HIT_SS;
+	return 1;
+
+no_kprobe:
+	preempt_enable_no_resched();
+	return ret;
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "breakpoint"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ */
+static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+{
+	int ret;
+
+	regs->nip = (unsigned long)p->addr;
+	ret = emulate_step(regs, p->ainsn.insn[0]);
+	if (ret == 0) 
+		regs->nip = (unsigned long)p->addr + 4;
+
+	regs->msr &= ~MSR_SE;
+}
+
+static inline int post_kprobe_handler(struct pt_regs *regs)
+{
+	if (!kprobe_running())
+		return 0;
+
+	if (current_kprobe->post_handler)
+		current_kprobe->post_handler(current_kprobe, regs, 0);
+
+	resume_execution(current_kprobe, regs);
+	regs->msr |= kprobe_saved_msr;
+
+	unlock_kprobes();
+	preempt_enable_no_resched();
+
+	/*
+	 * if somebody else is singlestepping across a probe point, msr
+	 * will have SE set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->msr & MSR_SE)
+		return 0;
+
+	return 1;
+}
+
+/* Interrupts disabled, kprobe_lock held. */
+static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	if (current_kprobe->fault_handler
+	    && current_kprobe->fault_handler(current_kprobe, regs, trapnr))
+		return 1;
+
+	if (kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(current_kprobe, regs);
+		regs->msr |= kprobe_saved_msr;
+
+		unlock_kprobes();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
+			     void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	switch (val) {
+	case DIE_IABR_MATCH:
+	case DIE_DABR_MATCH:
+	case DIE_BPT:
+		if (kprobe_handler(args->regs))
+			return NOTIFY_STOP;
+		break;
+	case DIE_SSTEP:
+		if (post_kprobe_handler(args->regs))
+			return NOTIFY_STOP;
+		break;
+	case DIE_GPF:
+	case DIE_PAGE_FAULT:
+		if (kprobe_running() &&
+		    kprobe_fault_handler(args->regs, args->trapnr))
+			return NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	
+	memcpy(&jprobe_saved_regs, regs, sizeof(struct pt_regs));
+
+	/* setup return addr to the jprobe handler routine */
+	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
+	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
+
+	return 1;
+}
+
+void jprobe_return(void)
+{
+	preempt_enable_no_resched();
+	asm volatile("trap" ::: "memory");
+}
+
+void jprobe_return_end(void)
+{
+};
+
+int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	/* 
+	 * FIXME - we should ideally be validating that we got here 'cos
+	 * of the "trap" in jprobe_return() above, before restoring the
+	 * saved regs...
+	 */
+	memcpy(regs, &jprobe_saved_regs, sizeof(struct pt_regs));
+	return 1;
+} 
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/kernel/Makefile linux-2.6.10-rc2/arch/ppc64/kernel/Makefile
--- temp/linux-2.6.10-rc2/arch/ppc64/kernel/Makefile	2004-11-15 06:58:32.000000000 +0530
+++ linux-2.6.10-rc2/arch/ppc64/kernel/Makefile	2004-11-18 11:18:52.000000000 +0530
@@ -61,5 +61,6 @@ obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 CFLAGS_ioctl32.o += -Ifs/
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/kernel/traps.c linux-2.6.10-rc2/arch/ppc64/kernel/traps.c
--- temp/linux-2.6.10-rc2/arch/ppc64/kernel/traps.c	2004-11-15 06:57:41.000000000 +0530
+++ linux-2.6.10-rc2/arch/ppc64/kernel/traps.c	2004-11-18 11:18:52.000000000 +0530
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <asm/kdebug.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -61,6 +62,20 @@ EXPORT_SYMBOL(__debugger_dabr_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
+struct notifier_block *ppc64_die_chain;
+static spinlock_t die_notifier_lock = SPIN_LOCK_UNLOCKED;
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&ppc64_die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+	return err;
+}
+
 /*
  * Trap & Exception support
  */
@@ -287,6 +302,9 @@ UnknownException(struct pt_regs *regs)
 void
 InstructionBreakpointException(struct pt_regs *regs)
 {
+	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
 	if (debugger_iabr_match(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
@@ -297,6 +315,9 @@ SingleStepException(struct pt_regs *regs
 {
 	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
 
+	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
 	if (debugger_sstep(regs))
 		return;
 
@@ -470,6 +491,9 @@ ProgramCheckException(struct pt_regs *re
 	} else if (regs->msr & 0x20000) {
 		/* trap exception */
 
+		if (notify_die(DIE_BPT, "breakpoint", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+			return;
 		if (debugger_bpt(regs))
 			return;
 
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/lib/Makefile linux-2.6.10-rc2/arch/ppc64/lib/Makefile
--- temp/linux-2.6.10-rc2/arch/ppc64/lib/Makefile	2004-11-18 12:21:15.331888520 +0530
+++ linux-2.6.10-rc2/arch/ppc64/lib/Makefile	2004-11-18 11:23:19.000000000 +0530
@@ -15,4 +15,4 @@ ifdef CONFIG_PPC_ISERIES
 obj-$(CONFIG_PCI)	+= e2a.o
 endif
 
-lib-$(CONFIG_XMON) += sstep.o
+lib-$(CONFIG_DEBUG_KERNEL) += sstep.o
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/mm/fault.c linux-2.6.10-rc2/arch/ppc64/mm/fault.c
--- temp/linux-2.6.10-rc2/arch/ppc64/mm/fault.c	2004-11-18 12:20:55.654957144 +0530
+++ linux-2.6.10-rc2/arch/ppc64/mm/fault.c	2004-11-18 11:18:52.000000000 +0530
@@ -36,6 +36,7 @@
 #include <asm/mmu_context.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/kdebug.h>
 
 /*
  * Check whether the instruction at regs->nip is a store using
@@ -95,6 +96,10 @@ int do_page_fault(struct pt_regs *regs, 
 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
+	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs, error_code,
+				11, SIGSEGV) == NOTIFY_STOP)
+		return 0;
+
 	if (trap == 0x300) {
 		if (debugger_fault_handler(regs))
 			return 0;
@@ -105,6 +110,9 @@ int do_page_fault(struct pt_regs *regs, 
 		return SIGSEGV;
 
 	if (error_code & 0x00400000) {
+		if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
+					11, SIGSEGV) == NOTIFY_STOP)
+			return 0;
 		if (debugger_dabr_match(regs))
 			return 0;
 	}
diff -Naurp temp/linux-2.6.10-rc2/arch/ppc64/xmon/xmon.c linux-2.6.10-rc2/arch/ppc64/xmon/xmon.c
--- temp/linux-2.6.10-rc2/arch/ppc64/xmon/xmon.c	2004-11-18 12:21:15.342886848 +0530
+++ linux-2.6.10-rc2/arch/ppc64/xmon/xmon.c	2004-11-18 11:21:35.000000000 +0530
@@ -229,17 +229,6 @@ extern inline void sync(void)
  */
 
 /*
- * We don't allow single-stepping an mtmsrd that would clear
- * MSR_RI, since that would make the exception unrecoverable.
- * Since we need to single-step to proceed from a breakpoint,
- * we don't allow putting a breakpoint on an mtmsrd instruction.
- * Similarly we don't allow breakpoints on rfid instructions.
- * These macros tell us if an instruction is a mtmsrd or rfid.
- */
-#define IS_MTMSRD(instr)	(((instr) & 0xfc0007fe) == 0x7c000164)
-#define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
-
-/*
  * Disable surveillance (the service processor watchdog function)
  * while we are in xmon.
  * XXX we should re-enable it when we leave. :)
diff -Naurp temp/linux-2.6.10-rc2/include/asm-ppc64/kdebug.h linux-2.6.10-rc2/include/asm-ppc64/kdebug.h
--- temp/linux-2.6.10-rc2/include/asm-ppc64/kdebug.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-ppc64/kdebug.h	2004-11-18 11:18:52.000000000 +0530
@@ -0,0 +1,43 @@
+#ifndef _PPC64_KDEBUG_H
+#define _PPC64_KDEBUG_H 1
+
+/* nearly identical to x86_64/i386 code */
+
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args {
+	struct pt_regs *regs;
+	const char *str;
+	long err;
+	int trapnr;
+	int signr;
+};
+
+/* 
+   Note - you should never unregister because that can race with NMIs.
+   If you really want to do it first unregister - then synchronize_kernel - 
+   then free.
+ */
+int register_die_notifier(struct notifier_block *nb);
+extern struct notifier_block *ppc64_die_chain;
+
+/* Grossly misnamed. */
+enum die_val {
+	DIE_OOPS = 1,
+	DIE_IABR_MATCH,
+	DIE_DABR_MATCH,
+	DIE_BPT,
+	DIE_SSTEP,
+	DIE_GPF,
+	DIE_PAGE_FAULT,
+};
+
+static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
+	return notifier_call_chain(&ppc64_die_chain, val, &args);
+}
+
+#endif
diff -Naurp temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h linux-2.6.10-rc2/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	2004-11-18 11:20:48.000000000 +0530
@@ -0,0 +1,54 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Kernel Probes (KProbes)
+ *  include/asm-ppc64/kprobes.h
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
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes suggestions from
+ *		Rusty Russell).
+ * 2004-Nov	Modified for PPC64 by Ananth N Mavinakayanahalli
+ *		<ananth@in.ibm.com>
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct pt_regs;
+
+typedef unsigned int kprobe_opcode_t;
+#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
+#define MAX_INSN_SIZE 1
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of original instruction */
+	kprobe_opcode_t insn[MAX_INSN_SIZE];
+};
+
+#ifdef CONFIG_KPROBES
+extern int kprobe_exceptions_notify(struct notifier_block *self,
+				    unsigned long val, void *data);
+#else				/* !CONFIG_KPROBES */
+static inline int kprobe_exceptions_notify(struct notifier_block *self,
+					   unsigned long val, void *data)
+{
+	return 0;
+}
+#endif
+#endif				/* _ASM_KPROBES_H */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-ppc64/sstep.h linux-2.6.10-rc2/include/asm-ppc64/sstep.h
--- temp/linux-2.6.10-rc2/include/asm-ppc64/sstep.h	2004-11-18 12:21:15.344886544 +0530
+++ linux-2.6.10-rc2/include/asm-ppc64/sstep.h	2004-11-18 11:21:48.000000000 +0530
@@ -9,5 +9,16 @@
 
 struct pt_regs;
 
+/*
+ * We don't allow single-stepping an mtmsrd that would clear
+ * MSR_RI, since that would make the exception unrecoverable.
+ * Since we need to single-step to proceed from a breakpoint,
+ * we don't allow putting a breakpoint on an mtmsrd instruction.
+ * Similarly we don't allow breakpoints on rfid instructions.
+ * These macros tell us if an instruction is a mtmsrd or rfid.
+ */
+#define IS_MTMSRD(instr)	(((instr) & 0xfc0007fe) == 0x7c000164)
+#define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
+
 /* Emulate instructions that cause a transfer of control. */
 extern int emulate_step(struct pt_regs *regs, unsigned int instr);
