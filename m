Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUJRKCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUJRKCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJRKBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:01:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14779 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265795AbUJRJzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:55:23 -0400
Date: Mon, 18 Oct 2004 15:22:29 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc64-dev@ozlabs.org
Cc: paulus@samba.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Kprobes for ppc64
Message-ID: <20041018095229.GA7394@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is kprobes for ppc64. The patch applies on 2.6.9-rc4/2.6.9-final
and provides the kprobes + jprobes functionality.

My earlier post did not reach the mailing lists, hence this resend.

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

The following pseudocode illustrates the usage of a jprobe, where the 
skbuff at tcp_v4_rcv() needs to be decoded:

............
struct jprobe jp;

jtcp_v4_rcv(struct skbuff *skb)
{
	/* decode and log skb related details as required */
	
	jprobe_return();
	return 0;
}
	
init_module
{
	jp.kp.addr = (kprobe_opcode_t *)<addr of tcp_v4_rcv>;
	jp.entry = JPROBE_ENTRY(jtcp_v4_rcv);
	register_jprobe(&jp);
	return 0;
}

cleanup_module
{
	unregister_jprobe(&jp);
}
............


NOTE: 
1. The current implementation uses xmon's emulate_step() and hence 
   requires xmon to be compiled in. 
2. arch_prepare_kprobe() now returns an int. I have made the necessary
   changes to i386 and sparc64 kprobes files, but is untested.


Thanks,
Ananth


diff -Naurp temp/linux-2.6.9-rc4/arch/i386/kernel/kprobes.c linux-2.6.9-rc4/arch/i386/kernel/kprobes.c
--- temp/linux-2.6.9-rc4/arch/i386/kernel/kprobes.c	2004-10-11 08:27:50.000000000 +0530
+++ linux-2.6.9-rc4/arch/i386/kernel/kprobes.c	2004-10-11 15:30:41.000000000 +0530
@@ -58,9 +58,10 @@ static inline int is_IF_modifier(kprobe_
 	return 0;
 }
 
-void arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
 {
 	memcpy(p->insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	return 0;
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/Kconfig.debug linux-2.6.9-rc4/arch/ppc64/Kconfig.debug
--- temp/linux-2.6.9-rc4/arch/ppc64/Kconfig.debug	2004-10-11 08:28:49.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/Kconfig.debug	2004-10-11 15:30:41.000000000 +0530
@@ -6,6 +6,16 @@ config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
 
+config KPROBES
+        bool "Kprobes"
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
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/kernel/kprobes.c linux-2.6.9-rc4/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.9-rc4/arch/ppc64/kernel/kprobes.c	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/kernel/kprobes.c	2004-10-11 15:30:41.000000000 +0530
@@ -0,0 +1,260 @@
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
+ * 2004-Oct	Ananth N Mavinakayanahalli <ananth@in.ibm.com> kprobes port
+ *		for PPC64
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/preempt.h>
+#include <asm/kdebug.h>
+
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+static struct kprobe *current_kprobe;
+static unsigned long kprobe_status, kprobe_saved_msr;
+static struct pt_regs jprobe_saved_regs;
+
+/* we re-use xmon's emulate_step here */
+extern int emulate_step(struct pt_regs *regs, unsigned int instr);
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	memcpy(p->insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	if (IS_MTMSRD(p->insn[0]) || IS_RFID(p->insn[0]))
+		/* cannot put bp on RFID/MTMSRD */ 
+		return 1;
+	return 0;
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
+	regs->nip = (unsigned long)&p->insn;
+}
+
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
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
+ * copy is p->insn.
+ */
+static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+{
+	int ret;
+
+	regs->nip = (unsigned long)p->addr;
+	ret = emulate_step(regs, p->insn[0]);
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
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/kernel/Makefile linux-2.6.9-rc4/arch/ppc64/kernel/Makefile
--- temp/linux-2.6.9-rc4/arch/ppc64/kernel/Makefile	2004-10-11 08:28:50.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/kernel/Makefile	2004-10-11 15:30:41.000000000 +0530
@@ -56,5 +56,6 @@ obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o sm
 endif
 
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 CFLAGS_ioctl32.o += -Ifs/
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/kernel/traps.c linux-2.6.9-rc4/arch/ppc64/kernel/traps.c
--- temp/linux-2.6.9-rc4/arch/ppc64/kernel/traps.c	2004-10-11 08:27:59.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/kernel/traps.c	2004-10-11 15:30:41.000000000 +0530
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
+	if (notify_die(DIE_BPT, "iabr_match", regs, 5,
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
 
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/mm/fault.c linux-2.6.9-rc4/arch/ppc64/mm/fault.c
--- temp/linux-2.6.9-rc4/arch/ppc64/mm/fault.c	2004-10-11 08:28:24.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/mm/fault.c	2004-10-11 15:30:41.000000000 +0530
@@ -36,6 +36,7 @@
 #include <asm/mmu_context.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/kdebug.h>
 
 /*
  * Check whether the instruction at regs->nip is a store using
@@ -96,6 +97,9 @@ int do_page_fault(struct pt_regs *regs, 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
 	if (trap == 0x300) {
+		if (notify_die(DIE_PAGE_FAULT, "page_fault", regs, error_code,
+					11, SIGSEGV) == NOTIFY_STOP)
+			return 0;
 		if (debugger_fault_handler(regs))
 			return 0;
 	}
@@ -105,6 +109,9 @@ int do_page_fault(struct pt_regs *regs, 
 		return SIGSEGV;
 
 	if (error_code & 0x00400000) {
+		if (notify_die(DIE_BPT, "dabr_match", regs, error_code,
+					11, SIGSEGV) == NOTIFY_STOP)
+			return 0;
 		if (debugger_dabr_match(regs))
 			return 0;
 	}
diff -Naurp temp/linux-2.6.9-rc4/arch/ppc64/xmon/xmon.c linux-2.6.9-rc4/arch/ppc64/xmon/xmon.c
--- temp/linux-2.6.9-rc4/arch/ppc64/xmon/xmon.c	2004-10-11 08:28:48.000000000 +0530
+++ linux-2.6.9-rc4/arch/ppc64/xmon/xmon.c	2004-10-11 15:30:41.000000000 +0530
@@ -132,7 +132,7 @@ static void csum(void);
 static void bootcmds(void);
 void dump_segments(void);
 static void symbol_lookup(void);
-static int emulate_step(struct pt_regs *regs, unsigned int instr);
+int emulate_step(struct pt_regs *regs, unsigned int instr);
 static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after);
 static const char *getvecname(unsigned long vec);
@@ -781,7 +781,7 @@ static int branch_taken(unsigned int ins
  * or -1 if the instruction is one that should not be stepped,
  * such as an rfid, or a mtmsrd that would clear MSR_RI.
  */
-static int emulate_step(struct pt_regs *regs, unsigned int instr)
+int emulate_step(struct pt_regs *regs, unsigned int instr)
 {
 	unsigned int opcode, rd;
 	unsigned long int imm;
diff -Naurp temp/linux-2.6.9-rc4/arch/sparc64/kernel/kprobes.c linux-2.6.9-rc4/arch/sparc64/kernel/kprobes.c
--- temp/linux-2.6.9-rc4/arch/sparc64/kernel/kprobes.c	2004-10-11 08:28:49.000000000 +0530
+++ linux-2.6.9-rc4/arch/sparc64/kernel/kprobes.c	2004-10-11 15:30:41.000000000 +0530
@@ -38,10 +38,11 @@
  * - Mark that we are no longer actively in a kprobe.
  */
 
-void arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
 {
 	p->insn[0] = *p->addr;
 	p->insn[1] = BREAKPOINT_INSTRUCTION_2;
+	return 0;
 }
 
 /* kprobe_status settings */
diff -Naurp temp/linux-2.6.9-rc4/include/asm-i386/kprobes.h linux-2.6.9-rc4/include/asm-i386/kprobes.h
--- temp/linux-2.6.9-rc4/include/asm-i386/kprobes.h	2004-10-11 08:28:07.000000000 +0530
+++ linux-2.6.9-rc4/include/asm-i386/kprobes.h	2004-10-11 19:28:07.000000000 +0530
@@ -38,6 +38,8 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
  */
diff -Naurp temp/linux-2.6.9-rc4/include/asm-ppc64/kdebug.h linux-2.6.9-rc4/include/asm-ppc64/kdebug.h
--- temp/linux-2.6.9-rc4/include/asm-ppc64/kdebug.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.9-rc4/include/asm-ppc64/kdebug.h	2004-10-11 15:30:41.000000000 +0530
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
diff -Naurp temp/linux-2.6.9-rc4/include/asm-ppc64/kprobes.h linux-2.6.9-rc4/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.9-rc4/include/asm-ppc64/kprobes.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.9-rc4/include/asm-ppc64/kprobes.h	2004-10-12 22:57:04.000000000 +0530
@@ -0,0 +1,53 @@
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
+ * 2004-Oct	Modified for PPC64 by Ananth N Mavinakayanahalli
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
+#define IS_MTMSRD(instr)	(((instr) & 0xfc0007fe) == 0x7c000164)
+#define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
+
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
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
diff -Naurp temp/linux-2.6.9-rc4/include/linux/kprobes.h linux-2.6.9-rc4/include/linux/kprobes.h
--- temp/linux-2.6.9-rc4/include/linux/kprobes.h	2004-10-11 08:27:16.000000000 +0530
+++ linux-2.6.9-rc4/include/linux/kprobes.h	2004-10-11 15:30:41.000000000 +0530
@@ -94,7 +94,7 @@ static inline int kprobe_running(void)
 	return kprobe_cpu == smp_processor_id();
 }
 
-extern void arch_prepare_kprobe(struct kprobe *p);
+extern int arch_prepare_kprobe(struct kprobe *p);
 extern void show_registers(struct pt_regs *regs);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
diff -Naurp temp/linux-2.6.9-rc4/kernel/kprobes.c linux-2.6.9-rc4/kernel/kprobes.c
--- temp/linux-2.6.9-rc4/kernel/kprobes.c	2004-10-11 08:29:12.000000000 +0530
+++ linux-2.6.9-rc4/kernel/kprobes.c	2004-10-11 15:30:41.000000000 +0530
@@ -27,6 +27,8 @@
  *		interface to access function arguments.
  * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
  *		exceptions notifier to be first on the priority list.
+ * 2004-Oct	Ananth N Mavinakayanahalli <ananth@in.ibm.com> 
+ *		arch_prepare_kprobe now returns an int.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -87,12 +89,17 @@ int register_kprobe(struct kprobe *p)
 	hlist_add_head(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	arch_prepare_kprobe(p);
+	ret = arch_prepare_kprobe(p);
+	if (ret) {
+		unregister_kprobe(p);
+		ret = -EINVAL;
+		goto out;
+	}
 	p->opcode = *p->addr;
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
-      out:
+out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 	return ret;
 }
