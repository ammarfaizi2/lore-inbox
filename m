Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTFXIE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTFXIE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:04:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10638 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264835AbTFXIDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:03:15 -0400
Date: Tue, 24 Jun 2003 14:09:26 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: suparna <suparna@in.ibm.com>, richard <richardj_moore@uk.ibm.com>,
       Larry Kessler <kessler@us.ibm.com>,
       dprobes <dprobes@www-124.southbury.usf.ibm.com>
Subject: [patch] kprobes for 2.5.73 with single-stepping out-of-line
Message-ID: <20030624140926.A17908@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version of the kprobes patch.

A major change introduced in this version is that single-stepping
now happens out-of-line, rather than in place. This closes the
small window for probe misses on SMP when a second CPU happens 
to execute the code at the same time when one CPU is single 
stepping that same exact code.

The new implementation enhances the suitability of kprobes for
debugging race conditions on SMP systems.

--
kprobes allows trapping at almost any kernel address, useful for
various kernel-hacking tasks, and building on for more
infrastructure.  This patch is x86 only, but other archs can add
support as required (s390 and ppc support is almost done, will be
submitted once this patch is in).

Rusty Lynch has built a sysfs-based module to use kprobes to
dynamically insert printks in running kernels. Other tools
that build on top of kprobes infrastructure, including
support for user space probes, are available/in development.
--
Comments/suggestions to make kprobes more useable welcome.

Regards,
Vamsi.
-- 
Vamsi Krishna S.
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
[vamsi@vamsiks] ~$ diffstat /patches/kprobes-2573-3.patch
 arch/i386/Kconfig          |    9 +
 arch/i386/kernel/Makefile  |    1
 arch/i386/kernel/entry.S   |   26 ++++-
 arch/i386/kernel/kprobes.c |  203 +++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/traps.c   |   31 +++++-
 arch/i386/mm/fault.c       |    4
 include/asm-i386/kprobes.h |   35 +++++++
 include/linux/kprobes.h    |   64 ++++++++++++++
 kernel/Makefile            |    1
 kernel/kprobes.c           |   90 +++++++++++++++++++
 10 files changed, 452 insertions(+), 12 deletions(-)
--
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/Kconfig 73-kprobes/arch/i386/Kconfig
--- 73-pure/arch/i386/Kconfig	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/arch/i386/Kconfig	2003-06-23 16:32:50.000000000 +0530
@@ -1353,6 +1353,15 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config KPROBES
+	bool "Kprobes"
+	depends on DEBUG_KERNEL
+	help
+	  Kprobes allows you to trap at almost any kernel address, using
+	  register_kprobe(), and providing a callback function.  This is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.  If
+	  in doubt, say "N".
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/kernel/entry.S 73-kprobes/arch/i386/kernel/entry.S
--- 73-pure/arch/i386/kernel/entry.S	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/arch/i386/kernel/entry.S	2003-06-23 16:33:24.000000000 +0530
@@ -493,10 +493,17 @@ ENTRY(debug)
 	jne debug_stack_correct
 	FIX_STACK(12, debug_stack_correct, debug_esp_fix_insn)
 debug_stack_correct:
-	pushl $0
-	pushl $do_debug
-	jmp error_code
-
+	pushl $-1			# mark this as an int
+	SAVE_ALL
+	movl %esp,%edx
+  	pushl $0
+	pushl %edx
+	call do_debug
+	addl $8,%esp
+	testl %eax,%eax 
+	jnz restore_all
+	jmp ret_from_exception
+  
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -544,9 +551,16 @@ nmi_debug_stack_fixup:
 	jmp nmi_stack_correct
 
 ENTRY(int3)
+	pushl $-1			# mark this as an int
+	SAVE_ALL
+	movl %esp,%edx
 	pushl $0
-	pushl $do_int3
-	jmp error_code
+	pushl %edx
+	call do_int3
+	addl $8,%esp
+	testl %eax,%eax 
+	jnz restore_all
+	jmp ret_from_exception
 
 ENTRY(overflow)
 	pushl $0
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/kernel/kprobes.c 73-kprobes/arch/i386/kernel/kprobes.c
--- 73-pure/arch/i386/kernel/kprobes.c	1970-01-01 05:30:00.000000000 +0530
+++ 73-kprobes/arch/i386/kernel/kprobes.c	2003-06-24 12:34:01.000000000 +0530
@@ -0,0 +1,203 @@
+/* 
+ * Support for kernel probes.
+ * (C) 2002 Vamsi Krishna S <vamsi_krishna@in.ibm.com>.
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/preempt.h>
+
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+static struct kprobe *current_kprobe;
+static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+
+/*
+ * returns non-zero if opcode modifies the interrupt flag.
+ */
+static inline int is_IF_modifier(kprobe_opcode_t opcode)
+{
+	switch(opcode) {
+		case 0xfa: 	/* cli */
+		case 0xfb:	/* sti */
+		case 0xcf:	/* iret/iretd */
+		case 0x9d:	/* popf/popfd */
+			return 1;
+	}
+	return 0;
+}
+
+void arch_prepare_kprobe(struct kprobe *p)
+{
+	memcpy(p->insn, p->addr, MAX_INSN_SIZE);
+}
+
+static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	*p->addr = p->opcode;
+	regs->eip = (unsigned long)p->addr;
+}
+
+static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->eflags |= TF_MASK;
+	regs->eflags &= ~IF_MASK;
+	regs->eip = (unsigned long)&p->insn;
+}
+
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
+int kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	u8 *addr = (u8 *)(regs->eip-1);
+
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* Check we're not actually recursing */
+	if (kprobe_running()) {
+		/* We *are* holding lock here, so this is safe.
+                   Disarm the probe we just hit, and ignore it. */
+		p = get_kprobe(addr);
+		if (p) {
+			disarm_kprobe(p, regs);
+			ret = 1;
+		}
+		/* If it's not ours, can't be delete race, (we hold lock). */
+		goto no_kprobe;
+	}
+
+	lock_kprobes();
+	p = get_kprobe(addr); 
+	if (!p) {
+		unlock_kprobes();
+		/* Unregistered (on another cpu) after this hit?  Ignore */
+		if (*addr != BREAKPOINT_INSTRUCTION)
+			ret = 1;
+		/* Not one of ours: let kernel handle it */
+		goto no_kprobe;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	current_kprobe = p;
+	kprobe_saved_eflags = kprobe_old_eflags 
+		= (regs->eflags & (TF_MASK|IF_MASK));
+	if(is_IF_modifier(p->opcode))
+		kprobe_saved_eflags &= ~IF_MASK;
+
+	p->pre_handler(p, regs);
+
+	prepare_singlestep(p, regs);
+	//disarm_kprobe(p, regs);
+	kprobe_status = KPROBE_HIT_SS;
+	return 1;
+
+	if (p->post_handler)
+		p->post_handler(p, regs, 0);
+	unlock_kprobes();
+	preempt_enable_no_resched();
+	return 1;
+
+no_kprobe:
+	preempt_enable_no_resched();
+	return ret;
+}
+
+static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long *tos = &regs->esp;
+	unsigned long next_eip = 0;
+	unsigned long copy_eip = (unsigned long)&p->insn;
+	unsigned long orig_eip = (unsigned long)p->addr;
+
+	/*
+	 * We singlestepped with interrupts disabled. So, the result on
+	 * the stack would be incorrect for "pushfl" instruction.
+	 * Note that regs->esp is actually the top of the stack when the
+	 * trap occurs in kernel space.
+	 */
+	switch(p->insn[0]) {
+		case 0x9c:	/* pushfl */
+			*tos &= ~(TF_MASK | IF_MASK);
+			*tos |= kprobe_old_eflags;
+			break;
+		case 0xe8:	/* call relative */
+			*tos = orig_eip + (*tos - copy_eip);
+			break;
+		case 0xff:	
+			if ((p->insn[1] & 0x30) == 0x10) { /* call absolute, indirect */
+				next_eip = regs->eip;
+				*tos = orig_eip + (*tos - copy_eip);
+			} else if (((p->insn[1] & 0x31) == 0x20) || /* jmp near, absolute indirect */
+				   ((p->insn[1] & 0x31) == 0x21)) { /* jmp far, absolute indirect */
+				next_eip = regs->eip;
+			}
+			break;
+		case 0xea:	/* jmp absolute */
+			next_eip = regs->eip;
+			break;
+		default:
+			break;
+	}
+	
+	regs->eflags &= ~TF_MASK;
+	if (next_eip) {
+		regs->eip = next_eip;
+	} else {
+		regs->eip = orig_eip + (regs->eip - copy_eip);
+	}
+}
+
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate and they
+ * remain disabled thorough out this function.  And we hold kprobe lock.
+ */
+int post_kprobe_handler(struct pt_regs *regs)
+{
+	if (!kprobe_running())
+		return 0;
+
+	if (current_kprobe->post_handler)
+		current_kprobe->post_handler(current_kprobe, regs, 0);
+
+	resume_execution(current_kprobe, regs);
+	regs->eflags |= kprobe_saved_eflags;
+
+	unlock_kprobes();
+	preempt_enable_no_resched();
+
+        /*
+	 * if somebody else is singlestepping across a probe point, eflags
+	 * will have TF set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->eflags & TF_MASK)
+		return 0;
+
+	return 1;
+}
+
+/* Interrupts disabled, kprobe_lock held. */
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	if (current_kprobe->fault_handler
+	    && current_kprobe->fault_handler(current_kprobe, regs, trapnr))
+		return 1;
+
+	if (kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(current_kprobe, regs);
+        	regs->eflags |= kprobe_old_eflags;
+
+		unlock_kprobes();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/kernel/Makefile 73-kprobes/arch/i386/kernel/Makefile
--- 73-pure/arch/i386/kernel/Makefile	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/arch/i386/kernel/Makefile	2003-06-23 16:32:50.000000000 +0530
@@ -28,6 +28,7 @@ obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspen
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/kernel/traps.c 73-kprobes/arch/i386/kernel/traps.c
--- 73-pure/arch/i386/kernel/traps.c	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/arch/i386/kernel/traps.c	2003-06-23 16:32:50.000000000 +0530
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/kprobes.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -358,7 +359,6 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
@@ -372,6 +372,9 @@ asmlinkage void do_general_protection(st
 {
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
+	
+	if (kprobe_running() && kprobe_fault_handler(regs, 13))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
@@ -492,6 +495,17 @@ void unset_nmi_callback(void)
 	nmi_callback = dummy_nmi_callback;
 }
 
+asmlinkage int do_int3(struct pt_regs *regs, long error_code)
+{
+	if (kprobe_handler(regs))
+		return 1;
+	/* This is an interrupt gate, because kprobes wants interrupts
+           disabled.  Normal trap handlers don't. */
+	restore_interrupts(regs);
+	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	return 0;
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -514,12 +528,15 @@ void unset_nmi_callback(void)
  * find every occurrence of the TF bit that could be saved away even
  * by user code)
  */
-asmlinkage void do_debug(struct pt_regs * regs, long error_code)
+asmlinkage int do_debug(struct pt_regs * regs, long error_code)
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
 	siginfo_t info;
 
+	if (post_kprobe_handler(regs))
+		return 1;
+
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
 	/* It's safe to allow irq's after DR6 has been saved */
@@ -576,17 +593,17 @@ clear_dr7:
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
-	return;
+	return 0;
 
 debug_vm86:
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
-	return;
+	return 0;
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 clear_TF:
 	regs->eflags &= ~TF_MASK;
-	return;
+	return 0;
 }
 
 /*
@@ -750,6 +767,8 @@ asmlinkage void math_state_restore(struc
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = thread->task;
 
+	if (kprobe_running() && kprobe_fault_handler(&regs, 7))
+		return;
 	clts();		/* Allow maths ops (or we recurse) */
 	if (!tsk->used_math)
 		init_fpu(tsk);
@@ -848,7 +867,7 @@ void __init trap_init(void)
 	set_trap_gate(0,&divide_error);
 	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
+	_set_gate(idt_table+3,14,3,&int3,__KERNEL_CS); /* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
diff -urNp -X /home/vamsi/.dontdiff 73-pure/arch/i386/mm/fault.c 73-kprobes/arch/i386/mm/fault.c
--- 73-pure/arch/i386/mm/fault.c	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/arch/i386/mm/fault.c	2003-06-23 16:32:50.000000000 +0530
@@ -20,6 +20,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -80,6 +81,9 @@ asmlinkage void do_page_fault(struct pt_
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
 
+	if (kprobe_running() && kprobe_fault_handler(regs, 14))
+		return;
+
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
diff -urNp -X /home/vamsi/.dontdiff 73-pure/include/asm-i386/kprobes.h 73-kprobes/include/asm-i386/kprobes.h
--- 73-pure/include/asm-i386/kprobes.h	1970-01-01 05:30:00.000000000 +0530
+++ 73-kprobes/include/asm-i386/kprobes.h	2003-06-24 10:25:33.000000000 +0530
@@ -0,0 +1,35 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Dynamic Probes (kprobes) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, July, 2002
+ *	Mailing list: dprobes@www-124.ibm.com
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct pt_regs;
+
+typedef u8 kprobe_opcode_t;
+#define BREAKPOINT_INSTRUCTION	0xcc
+#define MAX_INSN_SIZE 16
+
+/* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
+ * if necessary, before executing the original int3/1 (trap) handler.
+ */
+static inline void restore_interrupts(struct pt_regs *regs)
+{
+	if (regs->eflags & IF_MASK)
+		__asm__ __volatile__ ("sti");
+}
+
+#ifdef CONFIG_KPROBES
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+extern int post_kprobe_handler(struct pt_regs *regs);
+extern int kprobe_handler(struct pt_regs *regs);
+#else /* !CONFIG_KPROBES */
+static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr) { return 0; }
+static inline int post_kprobe_handler(struct pt_regs *regs) { return 0; }
+static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
+#endif
+#endif /* _ASM_KPROBES_H */
diff -urNp -X /home/vamsi/.dontdiff 73-pure/include/linux/kprobes.h 73-kprobes/include/linux/kprobes.h
--- 73-pure/include/linux/kprobes.h	1970-01-01 05:30:00.000000000 +0530
+++ 73-kprobes/include/linux/kprobes.h	2003-06-24 12:18:19.000000000 +0530
@@ -0,0 +1,64 @@
+#ifndef _LINUX_KPROBES_H
+#define _LINUX_KPROBES_H
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <asm/kprobes.h>
+
+struct kprobe;
+struct pt_regs;
+
+typedef void (*kprobe_pre_handler_t)(struct kprobe *, struct pt_regs *);
+typedef void (*kprobe_post_handler_t)(struct kprobe *, struct pt_regs *,
+				      unsigned long flags);
+typedef int (*kprobe_fault_handler_t)(struct kprobe *, struct pt_regs *,
+				      int trapnr);
+struct kprobe {
+	struct list_head list;
+
+	/* location of the probe point */
+	kprobe_opcode_t *addr;
+
+	 /* Called before addr is executed. */
+	kprobe_pre_handler_t pre_handler;
+
+	/* Called after addr is executed, unless... */
+	kprobe_post_handler_t post_handler;
+
+	 /* ... called if executing addr causes a fault (eg. page fault).
+	  * Return 1 if it handled fault, otherwise kernel will see it. */
+	kprobe_fault_handler_t fault_handler;
+
+	/* Saved opcode (which has been replaced with breakpoint) */
+	kprobe_opcode_t opcode;
+
+	/* copy of the original instruction */
+	kprobe_opcode_t insn[MAX_INSN_SIZE];
+};
+
+#ifdef CONFIG_KPROBES
+/* Locks kprobe: irq must be disabled */
+void lock_kprobes(void);
+void unlock_kprobes(void);
+
+/* kprobe running now on this CPU? */
+static inline int kprobe_running(void)
+{
+	extern unsigned int kprobe_cpu;
+	return kprobe_cpu == smp_processor_id();
+}
+
+extern void arch_prepare_kprobe(struct kprobe *p);
+
+/* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
+struct kprobe *get_kprobe(void *addr);
+
+int register_kprobe(struct kprobe *p);
+void unregister_kprobe(struct kprobe *p);
+#else
+static inline int kprobe_running(void) { return 0; }
+static inline int register_kprobe(struct kprobe *p) { return -ENOSYS; }
+static inline void unregister_kprobe(struct kprobe *p) { }
+#endif
+#endif /* _LINUX_KPROBES_H */
diff -urNp -X /home/vamsi/.dontdiff 73-pure/kernel/kprobes.c 73-kprobes/kernel/kprobes.c
--- 73-pure/kernel/kprobes.c	1970-01-01 05:30:00.000000000 +0530
+++ 73-kprobes/kernel/kprobes.c	2003-06-24 10:25:33.000000000 +0530
@@ -0,0 +1,90 @@
+/* Support for kernel probes.
+   (C) 2002 Vamsi Krishna S <vamsi_krishna@in.ibm.com>.
+*/
+#include <linux/kprobes.h>
+#include <linux/spinlock.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+
+#define KPROBE_HASH_BITS 6
+#define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
+
+static struct list_head kprobe_table[KPROBE_TABLE_SIZE];
+
+unsigned int kprobe_cpu = NR_CPUS;
+static spinlock_t kprobe_lock = SPIN_LOCK_UNLOCKED;
+
+/* Locks kprobe: irqs must be disabled */
+void lock_kprobes(void)
+{
+	spin_lock(&kprobe_lock);
+	kprobe_cpu = smp_processor_id();
+}
+
+void unlock_kprobes(void)
+{
+	kprobe_cpu = NR_CPUS;
+	spin_unlock(&kprobe_lock);
+}
+
+/* You have to be holding the kprobe_lock */
+struct kprobe *get_kprobe(void *addr)
+{
+	struct list_head *head, *tmp;
+
+	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
+	list_for_each(tmp, head) {
+		struct kprobe *p = list_entry(tmp, struct kprobe, list);
+		if (p->addr == addr)
+			return p;
+	}
+	return NULL;
+}
+
+int register_kprobe(struct kprobe *p)
+{
+	int ret = 0;
+
+	spin_lock_irq(&kprobe_lock);
+	if (get_kprobe(p->addr)) {
+		ret = -EEXIST;
+		goto out;
+	}
+	list_add(&p->list, &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
+
+	arch_prepare_kprobe(p);
+	p->opcode = *p->addr;
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+ out:
+	spin_unlock_irq(&kprobe_lock);
+	return ret;
+}
+
+void unregister_kprobe(struct kprobe *p)
+{
+	spin_lock_irq(&kprobe_lock);
+	*p->addr = p->opcode;
+	list_del(&p->list);
+	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+	spin_unlock_irq(&kprobe_lock);
+}
+
+static int __init init_kprobes(void)
+{
+	int i;
+
+	/* FIXME allocate the probe table, currently defined statically */
+	/* initialize all list heads */
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&kprobe_table[i]);
+
+	return 0;
+}
+__initcall(init_kprobes);
+
+EXPORT_SYMBOL_GPL(register_kprobe);
+EXPORT_SYMBOL_GPL(unregister_kprobe);
diff -urNp -X /home/vamsi/.dontdiff 73-pure/kernel/Makefile 73-kprobes/kernel/Makefile
--- 73-pure/kernel/Makefile	2003-06-24 12:27:25.000000000 +0530
+++ 73-kprobes/kernel/Makefile	2003-06-23 16:32:50.000000000 +0530
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_KPROBES) += kprobes.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
