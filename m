Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318411AbSHFHc6>; Tue, 6 Aug 2002 03:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSHFHc4>; Tue, 6 Aug 2002 03:32:56 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61074 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318411AbSHFHcn>;
	Tue, 6 Aug 2002 03:32:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] kprobes for 2.5.30 
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
In-reply-to: Your message of "Mon, 05 Aug 2002 22:48:38 MST."
             <Pine.LNX.4.44.0208052247380.1171-100000@home.transmeta.com> 
Date: Tue, 06 Aug 2002 17:22:15 +1000
Message-Id: <20020806073804.690DE4BA4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208052247380.1171-100000@home.transmeta.com> you wri
te:
> 
> On Tue, 6 Aug 2002, Rusty Russell wrote:
> > 
> > I am reading from this that we *should* be explicitly disabling
> > preemption in interrupt handlers if we rely on the cpu number not
> > changing underneath us, even if it's (a) currently unneccessary, and
> > (b) arch-specific code.
> 
> But do_irq() already does that.

Right, that's what I wanted to check.

> You mean _exception_ handlers. It's definitely not unnecessary. Exceptions 
> can very much be preempted.

The patch changes traps 1 and 3 (debug & int3) to interrupt gates
though.  

In fact, the removal of the #ifdef CONFIG_KPROBES around that change
introduced a bug: we didn't reenable interrupts like the older code
expects.

Vamsi, what do you think of this patch?  Is it neccessary to restore
interrupts before handle_vm86_trap (the original patch didn't do this
either, not sure if it's required).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Kprobes for i386
Author: Vamsi Krishna S
Status: Experimental

D: This patch allows trapping at almost any kernel address, useful for
D: various kernel-hacking tasks, and building on for more
D: infrastructure.  This patch is x86 only, but other archs can add
D: support as required.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/Config.help working-2.5.30-kprobes/arch/i386/Config.help
--- linux-2.5.30/arch/i386/Config.help	Mon Jun 17 23:19:15 2002
+++ working-2.5.30-kprobes/arch/i386/Config.help	Tue Aug  6 16:52:59 2002
@@ -967,3 +967,9 @@ CONFIG_SOFTWARE_SUSPEND
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+CONFIG_KPROBES
+  Kprobes allows you to trap at almost any kernel address, using
+  register_kprobe(), and providing a callback function.  This is useful
+  for kernel debugging, non-intrusive instrumentation and testing.  If
+  in doubt, say "N".
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/config.in working-2.5.30-kprobes/arch/i386/config.in
--- linux-2.5.30/arch/i386/config.in	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/config.in	Tue Aug  6 16:52:59 2002
@@ -415,6 +415,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Probes' CONFIG_KPROBES
 fi
 
 endmenu
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/kernel/entry.S working-2.5.30-kprobes/arch/i386/kernel/entry.S
--- linux-2.5.30/arch/i386/kernel/entry.S	Fri Aug  2 11:15:05 2002
+++ working-2.5.30-kprobes/arch/i386/kernel/entry.S	Tue Aug  6 16:52:59 2002
@@ -430,9 +430,16 @@ device_not_available_emulate:
 	jmp ret_from_exception
 
 ENTRY(debug)
+	pushl %eax
+	SAVE_ALL
+	movl %esp,%edx
 	pushl $0
-	pushl $do_debug
-	jmp error_code
+	pushl %edx
+	call do_debug
+	addl $8,%esp
+	testl %eax,%eax 
+	jnz restore_all
+	jmp ret_from_exception
 
 ENTRY(nmi)
 	pushl %eax
@@ -445,9 +452,16 @@ ENTRY(nmi)
 	RESTORE_ALL
 
 ENTRY(int3)
+	pushl %eax
+	SAVE_ALL
+	movl %esp,%edx
 	pushl $0
-	pushl $do_int3
-	jmp error_code
+	pushl %edx
+	call do_int3
+	addl $8,%esp
+	cmpl $0,%eax 
+	jnz restore_all
+	jmp ret_from_exception
 
 ENTRY(overflow)
 	pushl $0
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/kernel/traps.c working-2.5.30-kprobes/arch/i386/kernel/traps.c
--- linux-2.5.30/arch/i386/kernel/traps.c	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/kernel/traps.c	Tue Aug  6 17:04:15 2002
@@ -5,6 +5,9 @@
  *
  *  Pentium III FXSR, SSE support
  *	Gareth Hughes <gareth@valinux.com>, May 2000
+ *
+ *  Dynamic Probes (kprobes) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, July, 2002
  */
 
 /*
@@ -24,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
+#include <linux/kprobes.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -50,6 +54,7 @@
 #include <asm/cobalt.h>
 #include <asm/lithium.h>
 #endif
+#include <linux/hash.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -297,6 +302,162 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
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
+static inline int is_IF_modifier(u8 opcode)
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
+static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	*p->addr = p->opcode;
+	regs->eip = (unsigned long)p->addr;
+}
+
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
+static int kprobe_handler(struct pt_regs *regs)
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
+		/* If it's not ours, can't be delete race, (we hold lock). */
+		if (p) {
+			disarm_kprobe(p, regs);
+			ret = 1;
+		}
+		goto out;
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
+	out:
+		preempt_enable_no_resched();
+		return ret;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	current_kprobe = p;
+	kprobe_saved_eflags = kprobe_old_eflags 
+		= (regs->eflags & (TF_MASK|IF_MASK));
+	if (is_IF_modifier(p->opcode))
+		kprobe_saved_eflags &= ~IF_MASK;
+
+	p->pre_handler(p, regs);
+
+	regs->eflags |= TF_MASK;
+	regs->eflags &= ~IF_MASK;
+
+	/* We hold lock, now we remove breakpoint and single step. */
+	disarm_kprobe(p, regs);
+	kprobe_status = KPROBE_HIT_SS;
+	return 1;
+}
+
+static void rearm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->eflags &= ~TF_MASK;
+	*p->addr = BREAKPOINT_INSTRUCTION;
+}
+	
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate and they
+ * remain disabled thorough out this function.  And we hold kprobe lock.
+ */
+static int post_kprobe_handler(struct pt_regs *regs)
+{
+	if (current_kprobe->post_handler)
+		current_kprobe->post_handler(current_kprobe, regs, 0);
+
+	/*
+	 * We singlestepped with interrupts disabled. So, the result on
+	 * the stack would be incorrect for "pushfl" instruction.
+	 */
+	if (current_kprobe->opcode == 0x9c) { /* pushfl */
+		regs->esp &= ~(TF_MASK | IF_MASK);
+		regs->esp |= kprobe_old_eflags;
+	}
+
+	rearm_kprobe(current_kprobe, regs);
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
+		rearm_kprobe(current_kprobe, regs);
+        	regs->eflags |= kprobe_old_eflags;
+
+		unlock_kprobes();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
+#else
+static inline int post_kprobe_handler(struct pt_regs *regs) { return 0; }
+static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_KPROBES */
+
 static inline unsigned long get_cr2(void)
 {
 	unsigned long address;
@@ -326,6 +487,8 @@ static void inline do_trap(int trapnr, i
 		panic("do_trap: can't hit this");
 	}
 #endif	
+	if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
@@ -392,7 +555,6 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
@@ -408,6 +570,9 @@ asmlinkage void do_general_protection(st
 {
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
+	
+	if (kprobe_running() && kprobe_fault_handler(regs, 13))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
@@ -508,6 +673,15 @@ asmlinkage void do_nmi(struct pt_regs * 
 	inb(0x71);		/* dummy */
 }
 
+asmlinkage int do_int3(struct pt_regs *regs, long error_code)
+{
+	if (kprobe_handler(regs))
+		return 1;
+	restore_interrupts(regs);
+	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	return 0;
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -530,7 +704,7 @@ asmlinkage void do_nmi(struct pt_regs * 
  * find every occurrence of the TF bit that could be saved away even
  * by user code)
  */
-asmlinkage void do_debug(struct pt_regs * regs, long error_code)
+asmlinkage int do_debug(struct pt_regs * regs, long error_code)
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
@@ -552,6 +726,9 @@ asmlinkage void do_debug(struct pt_regs 
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
 	if (condition & DR_STEP) {
+		if (kprobe_running() && post_kprobe_handler(regs))
+			return 1;
+		restore_interrupts(regs);
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -565,7 +742,8 @@ asmlinkage void do_debug(struct pt_regs 
 			goto clear_TF;
 		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
 			goto clear_TF;
-	}
+	} else
+		restore_interrupts(regs);
 
 	/* Ok, finally something we can handle */
 	tsk->thread.trap_no = 1;
@@ -588,15 +766,16 @@ clear_dr7:
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
-	return;
+	return 0;
 
 debug_vm86:
+	restore_interrupts(regs);
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
-	return;
+	return 0;
 
 clear_TF:
 	regs->eflags &= ~TF_MASK;
-	return;
+	return 0;
 }
 
 /*
@@ -760,6 +939,8 @@ asmlinkage void math_state_restore(struc
 	struct task_struct *tsk = current;
 	clts();		/* Allow maths ops (or we recurse) */
 
+	if (kprobe_running() && kprobe_fault_handler(&regs, 7))
+		return;
 	if (!tsk->used_math)
 		init_fpu(tsk);
 	restore_fpu(tsk);
@@ -943,9 +1124,9 @@ void __init trap_init(void)
 #endif
 
 	set_trap_gate(0,&divide_error);
-	set_trap_gate(1,&debug);
+	_set_gate(idt_table+1,14,3,&debug);
 	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
+	_set_gate(idt_table+3,14,3,&int3);
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/mm/fault.c working-2.5.30-kprobes/arch/i386/mm/fault.c
--- linux-2.5.30/arch/i386/mm/fault.c	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/mm/fault.c	Tue Aug  6 16:52:59 2002
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -154,6 +155,9 @@ asmlinkage void do_page_fault(struct pt_
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
+
+	if (kprobe_running() && kprobe_fault_handler(regs, 14))
+		return;
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/include/asm-i386/kprobes.h working-2.5.30-kprobes/include/asm-i386/kprobes.h
--- linux-2.5.30/include/asm-i386/kprobes.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/include/asm-i386/kprobes.h	Tue Aug  6 16:52:59 2002
@@ -0,0 +1,20 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Dynamic Probes (kprobes) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, July, 2002
+ *	Mailing list: dprobes@www-124.ibm.com
+ */
+#include <linux/smp.h>
+#include <linux/types.h>
+
+struct pt_regs;
+
+typedef u8 kprobe_opcode_t;
+
+/* Doesn't exist if !CONFIG_KPROBES, but calls optimized out. */
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+
+#define BREAKPOINT_INSTRUCTION	0xcc
+
+#endif /* _ASM_KPROBES_H */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/include/linux/kprobes.h working-2.5.30-kprobes/include/linux/kprobes.h
--- linux-2.5.30/include/linux/kprobes.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/include/linux/kprobes.h	Tue Aug  6 16:52:59 2002
@@ -0,0 +1,54 @@
+#ifndef _LINUX_KPROBES_H
+#define _LINUX_KPROBES_H
+#include <linux/config.h>
+#include <linux/list.h>
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
+
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
+};
+
+#ifdef CONFIG_KPROBES
+/* Locks kprobe: irq must be disabled */
+void lock_kprobes(void);
+void unlock_kprobes(void);
+
+/* kprobe running now on this CPU? */
+int kprobe_running(void);
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
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/kernel/Makefile working-2.5.30-kprobes/kernel/Makefile
--- linux-2.5.30/kernel/Makefile	Sat Jul 27 15:24:39 2002
+++ working-2.5.30-kprobes/kernel/Makefile	Tue Aug  6 16:52:59 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o kprobes.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -23,6 +23,7 @@ obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_KPROBES) += kprobes.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/kernel/kprobes.c working-2.5.30-kprobes/kernel/kprobes.c
--- linux-2.5.30/kernel/kprobes.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/kernel/kprobes.c	Tue Aug  6 16:52:59 2002
@@ -0,0 +1,94 @@
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
+static unsigned int kprobe_cpu = NR_CPUS;
+static spinlock_t kprobe_lock = SPIN_LOCK_UNLOCKED;
+
+int kprobe_running(void)
+{
+	return kprobe_cpu == smp_processor_id();
+}
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
