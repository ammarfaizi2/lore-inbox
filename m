Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268173AbUHFQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268173AbUHFQju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268171AbUHFQjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:39:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39064 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268173AbUHFQeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:34:37 -0400
Date: Fri, 6 Aug 2004 22:07:41 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, vamsi_krishna@in.ibm.com
Subject: Re: [0/3]kprobes-base-268-rc3.patch
Message-ID: <20040806163741.GA3962@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <2pMzT-XA-21@gated-at.bofh.it> <m3hdrhyhuy.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <m3hdrhyhuy.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

I have updated the kprobes patch with you suggestions.
Please find patch below.

Your comments are welcome.

Thanks
Prasanna

On Thu, Aug 05, 2004 at 12:55:17PM +0200, Andi Kleen wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> 
> Hallo,
> 
> Overall it looks good, but some issues noted below. 
> 
> >  		goto gp_in_kernel;
> >  
> > @@ -557,6 +560,17 @@ void unset_nmi_callback(void)
> >  	nmi_callback = dummy_nmi_callback;
> >  }
> >  
> > +asmlinkage int do_int3(struct pt_regs *regs, long error_code)
> > +{
> > +	if (kprobe_handler(regs))
> > +		return 1;
> 
> Same.
> 
> > +	/* This is an interrupt gate, because kprobes wants interrupts
> > +           disabled.  Normal trap handlers don't. */
> > +	restore_interrupts(regs);
> > +	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Our handling of the processor debug registers is non-trivial.
> >   * We do not clear them on entry and exit from the kernel. Therefore
> > @@ -579,12 +593,15 @@ void unset_nmi_callback(void)
> >   * find every occurrence of the TF bit that could be saved away even
> >   * by user code)
> >   */
> > -asmlinkage void do_debug(struct pt_regs * regs, long error_code)
> > +asmlinkage int do_debug(struct pt_regs * regs, long error_code)
> >  {
> >  	unsigned int condition;
> >  	struct task_struct *tsk = current;
> >  	siginfo_t info;
> >  
> > +	if (post_kprobe_handler(regs))
> > +		return 1;
> > +
> 
> Also notifier list.
> 
> >  clear_TF_reenable:
> >  	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> >  clear_TF:
> >  	regs->eflags &= ~TF_MASK;
> > -	return;
> > +	return 0;
> >  }
> >  
> >  /*
> > @@ -817,6 +834,8 @@ asmlinkage void math_state_restore(struc
> >  	struct thread_info *thread = current_thread_info();
> >  	struct task_struct *tsk = thread->task;
> >  
> > +	if (kprobe_running() && kprobe_fault_handler(&regs, 7))
> > +		return;
> 
> Same.
> 
> 
> >  	clts();		/* Allow maths ops (or we recurse) */
> >  	if (!tsk->used_math)
> >  		init_fpu(tsk);
> > @@ -911,7 +930,7 @@ void __init trap_init(void)
> >  	set_trap_gate(0,&divide_error);
> >  	set_intr_gate(1,&debug);
> >  	set_intr_gate(2,&nmi);
> > -	set_system_gate(3,&int3);	/* int3-5 can be called from all */
> > +	_set_gate(idt_table+3,14,3,&int3,__KERNEL_CS); /* int3-5 can be called from all */
> 
> Please define a macro for this (set_system_intr_gate) 
> 
> 
> > +#include <linux/kprobes.h>
> >  
> >  #include <asm/system.h>
> >  #include <asm/uaccess.h>
> > @@ -226,6 +227,9 @@ asmlinkage void do_page_fault(struct pt_
> >  	/* get the address */
> >  	__asm__("movl %%cr2,%0":"=r" (address));
> >  
> > +	if (kprobe_running() && kprobe_fault_handler(regs, 14))
> > +		return;
> 
> Also notifier here. 
> 
> > +/* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
> > + * if necessary, before executing the original int3/1 (trap) handler.
> > + */
> > +static inline void restore_interrupts(struct pt_regs *regs)
> > +{
> > +	if (regs->eflags & IF_MASK)
> > +		__asm__ __volatile__ ("sti");
> 
> That's local_irq_enable()
> 
> > +
> > +/* You have to be holding the kprobe_lock */
> > +struct kprobe *get_kprobe(void *addr)
> > +{
> > +	struct list_head *head, *tmp;
> 
> A hlist would be probably better for the hash table (saves some space) 
> 
> > +
> > +int register_kprobe(struct kprobe *p)
> > +{
> > +	int ret = 0;
> > +
> > +	spin_lock_irq(&kprobe_lock);
> 
> Better use _irqsave here. Safer interface for users.
> 
> 
> > +
> > +void unregister_kprobe(struct kprobe *p)
> > +{
> > +	spin_lock_irq(&kprobe_lock);
> 
> Better make this an _irqsave() 
> 
> > +	*p->addr = p->opcode;
> > +	list_del(&p->list);
> > +	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
> 
> This flush will probably need good review by other architecture
> maintainers. it's ok right now since it is 386 only.
> My suspection is that it is will not be enough for some people
> 
> 
> -Andi
> 

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-base-268-rc3.patch"



Helps developers to trap at almost any kernel code address, specifying
a handler routine to be invoked when the breakpoint is hit. Useful
for analysing the Linux kernel by collecting debugging information
non-disruptively. Employs single-stepping out-of-line to avoid probe
misses on SMP and may be especially useful in aiding debugging elusive
races and problems on live systems. More elaborate dynamic tracing
tools such as DProbes can be built over the kprobes interface.

Sample usage:
	To place a probe on __blockdev_direct_IO:
	static int probe_handler(struct kprobe *p, struct pt_regs *)
	{
		... whatever ...
	}
	struct kprobe kp = {
		.addr = __blockdev_direct_IO, 
		.pre_handler = probe_handler
	};
	register_kprobe(&kp);
---


---


diff -puN arch/i386/Kconfig~kernel-base-notify arch/i386/Kconfig
--- linux-2.6.8-rc3/arch/i386/Kconfig~kernel-base-notify	2004-08-07 11:36:45.360856712 -0700
+++ linux-2.6.8-rc3-root/arch/i386/Kconfig	2004-08-07 11:36:45.392851848 -0700
@@ -1207,6 +1207,15 @@ config EARLY_PRINTK
 	  with klogd/syslogd or the X server. You should normally N here,
 	  unless you want to debug such a crash.
 
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
diff -puN arch/i386/kernel/Makefile~kernel-base-notify arch/i386/kernel/Makefile
--- linux-2.6.8-rc3/arch/i386/kernel/Makefile~kernel-base-notify	2004-08-07 11:36:45.364856104 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/Makefile	2004-08-07 11:36:45.393851696 -0700
@@ -25,6 +25,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o n
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
diff -puN arch/i386/kernel/entry.S~kernel-base-notify arch/i386/kernel/entry.S
--- linux-2.6.8-rc3/arch/i386/kernel/entry.S~kernel-base-notify	2004-08-07 11:36:45.368855496 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/entry.S	2004-08-07 11:36:45.394851544 -0700
@@ -489,9 +489,16 @@ ENTRY(debug)
 	jne debug_stack_correct
 	FIX_STACK(12, debug_stack_correct, debug_esp_fix_insn)
 debug_stack_correct:
-	pushl $0
-	pushl $do_debug
-	jmp error_code
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
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -540,9 +547,16 @@ nmi_debug_stack_fixup:
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
diff -puN /dev/null arch/i386/kernel/kprobes.c
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/kprobes.c	2004-08-07 11:52:14.164657072 -0700
@@ -0,0 +1,255 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  arch/i386/kernel/kprobes.c
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
+ * Copyright (C) IBM Corporation, 2002
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes contributions from
+ *		Rusty Russell).
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
+static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
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
+static inline int kprobe_handler(struct pt_regs *regs)
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
+static inline int post_kprobe_handler(struct pt_regs *regs)
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
+static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
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
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
+						void *data)
+{
+	struct die_args *args= (struct die_args *) data;
+	switch(val) {
+		case DIE_INT3:
+			if (kprobe_handler(args->regs))
+               			return NOTIFY_OK;
+			break;
+		case DIE_DEBUG:
+			if (post_kprobe_handler(args->regs))
+               			return NOTIFY_OK;
+			break;
+		case DIE_GPF:
+			if (kprobe_running() &&
+				kprobe_fault_handler(args->regs, args->trapnr))
+               			return NOTIFY_OK;
+			break;
+		case DIE_PAGE_FAULT:
+			if (kprobe_running() &&
+				kprobe_fault_handler(args->regs, args->trapnr))
+               			return NOTIFY_OK;
+			break;
+		default:
+			break;
+	}
+	return NOTIFY_BAD;
+}
diff -puN arch/i386/kernel/traps.c~kernel-base-notify arch/i386/kernel/traps.c
--- linux-2.6.8-rc3/arch/i386/kernel/traps.c~kernel-base-notify	2004-08-07 11:36:45.374854584 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/traps.c	2004-08-07 11:36:45.397851088 -0700
@@ -26,6 +26,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/version.h>
+#include <linux/kprobes.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -444,7 +445,6 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
@@ -591,6 +591,18 @@ void unset_nmi_callback(void)
 	nmi_callback = dummy_nmi_callback;
 }
 
+asmlinkage int do_int3(struct pt_regs *regs, long error_code)
+{
+	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
+			== NOTIFY_OK)
+		return 1;
+	/* This is an interrupt gate, because kprobes wants interrupts
+	disabled.  Normal trap handlers don't. */
+	restore_interrupts(regs);
+	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	return 0;
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -912,6 +924,14 @@ void set_intr_gate(unsigned int n, void 
 	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
 }
 
+/*
+ * This routine sets up an interrupt gate at directory privilege level 3.
+ */
+static inline void set_system_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+}
+
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
 	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
@@ -948,7 +968,7 @@ void __init trap_init(void)
 	set_trap_gate(0,&divide_error);
 	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
+	set_system_intr_gate(3, &int3); /* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
diff -puN /dev/null include/asm-i386/kprobes.h
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/include/asm-i386/kprobes.h	2004-08-07 11:53:35.243331240 -0700
@@ -0,0 +1,52 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Kernel Probes (KProbes)
+ *  include/asm-i386/kprobes.h
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
+		local_irq_enable();
+}
+
+#ifdef CONFIG_KPROBES
+extern int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
+		void * data);
+#else /* !CONFIG_KPROBES */
+static inline int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val, void * data) { return 0; }
+#endif
+#endif /* _ASM_KPROBES_H */
+
diff -puN /dev/null include/linux/kprobes.h
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/include/linux/kprobes.h	2004-08-07 11:52:52.236869216 -0700
@@ -0,0 +1,87 @@
+#ifndef _LINUX_KPROBES_H
+#define _LINUX_KPROBES_H
+/*
+ *  Kernel Probes (KProbes)
+ *  include/linux/kprobes.h
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
+ * Copyright (C) IBM Corporation, 2002
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes suggestions from
+ *		Rusty Russell).
+ */
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <asm/kprobes.h>
+
+struct kprobe;
+struct pt_regs;
+typedef void (*kprobe_pre_handler_t)(struct kprobe *, struct pt_regs *);
+typedef void (*kprobe_post_handler_t)(struct kprobe *, struct pt_regs *,
+				      unsigned long flags);
+typedef int (*kprobe_fault_handler_t)(struct kprobe *, struct pt_regs *,
+				      int trapnr);
+struct kprobe {
+	struct hlist_node hlist;
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
diff -puN kernel/Makefile~kernel-base-notify kernel/Makefile
--- linux-2.6.8-rc3/kernel/Makefile~kernel-base-notify	2004-08-07 11:36:45.000000000 -0700
+++ linux-2.6.8-rc3-root/kernel/Makefile	2004-08-07 11:36:45.000000000 -0700
@@ -23,6 +23,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_KPROBES) += kprobes.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -puN /dev/null kernel/kprobes.c
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/kernel/kprobes.c	2004-08-07 11:51:55.905432896 -0700
@@ -0,0 +1,123 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  kernel/kprobes.c
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
+ *		Probes initial implementation (includes suggestions from
+ *		Rusty Russell).
+ * 2004-Aug	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> with
+ *		hlists and exceptions notifier as suggested by Andi Kleen.
+ */
+#include <linux/kprobes.h>
+#include <linux/spinlock.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+#include <asm/kdebug.h>
+
+#define KPROBE_HASH_BITS 6
+#define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
+
+static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
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
+	struct hlist_head *head;
+	struct hlist_node *node;
+
+	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
+	hlist_for_each (node, head) {
+		struct kprobe *p = hlist_entry(node, struct kprobe, hlist);
+		if (p->addr == addr)
+			return p;
+	}
+	return NULL;
+}
+
+int register_kprobe(struct kprobe *p)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kprobe_lock, flags);
+	INIT_HLIST_NODE(&p->hlist);
+	if (get_kprobe(p->addr)) {
+		ret = -EEXIST;
+		goto out;
+	}
+	hlist_add_head(&p->hlist, &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
+
+	arch_prepare_kprobe(p);
+	p->opcode = *p->addr;
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+ out:
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+	return ret;
+}
+
+void unregister_kprobe(struct kprobe *p)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&kprobe_lock, flags);
+	*p->addr = p->opcode;
+	hlist_del(&p->hlist);
+	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+}
+
+static struct notifier_block kprobe_exceptions_nb = {
+        .notifier_call = kprobe_exceptions_notify,
+};
+
+static int __init init_kprobes(void)
+{
+	int i, err = 0;
+
+	/* FIXME allocate the probe table, currently defined statically */
+	/* initialize all list heads */
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&kprobe_table[i]);
+
+	err = register_die_chain_notify(&kprobe_exceptions_nb);
+	return err;
+}
+__initcall(init_kprobes);
+
+EXPORT_SYMBOL_GPL(register_kprobe);
+EXPORT_SYMBOL_GPL(unregister_kprobe);

_

--BXVAT5kNtrzKuDFl--
