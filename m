Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSHEENx>; Mon, 5 Aug 2002 00:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSHEENx>; Mon, 5 Aug 2002 00:13:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16095 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318293AbSHEENs>;
	Mon, 5 Aug 2002 00:13:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30 
In-reply-to: Your message of "Thu, 01 Aug 2002 19:14:49 MST."
             <20020801.191449.101696880.davem@redhat.com> 
Date: Mon, 05 Aug 2002 14:14:12 +1000
Message-Id: <20020805041904.783374450@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020801.191449.101696880.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Fri, 02 Aug 2002 12:11:47 +1000
> 
>    	Vamsi's kernel probes again, this time with EXPORT_SYMBOL_GPL
>    so people don't think this is blanket permission to hook into
>    arbitrary parts of the kernel (as separate from debugging, testing,
>    diagnostics, etc).
>    
> A nice enhancement would be to move the kprobe table and
> other generic bits into a common area so that it did not
> need to be duplicated as other arches add kprobe support.

Done.  Look better?

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

diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/Config.help working-2.5.30-kprobes/arch/i386/Config.help
--- linux-2.5.30/arch/i386/Config.help	Mon Jun 17 23:19:15 2002
+++ working-2.5.30-kprobes/arch/i386/Config.help	Fri Aug  2 15:36:03 2002
@@ -967,3 +967,9 @@ CONFIG_SOFTWARE_SUSPEND
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+CONFIG_KPROBES
+  Kprobes allows you to trap at almost any kernel address, using
+  register_kprobe(), and providing a callback function.  This is useful
+  for kernel debugging, non-intrusive instrumentation and testing.  If
+  in doubt, say "N".
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/include/linux/kprobes.h working-2.5.30-kprobes/include/linux/kprobes.h
--- linux-2.5.30/include/linux/kprobes.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/include/linux/kprobes.h	Mon Aug  5 10:56:44 2002
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
+static inline int register_kprobe(struct probe_struct *p) { return -ENOSYS; }
+static inline void unregister_kprobe(struct probe_struct *p) { }
+#endif
+#endif /* _LINUX_KPROBES_H */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/kernel/Makefile working-2.5.30-kprobes/kernel/Makefile
--- linux-2.5.30/kernel/Makefile	Sat Jul 27 15:24:39 2002
+++ working-2.5.30-kprobes/kernel/Makefile	Fri Aug  2 15:36:03 2002
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/kernel/kprobes.c working-2.5.30-kprobes/kernel/kprobes.c
--- linux-2.5.30/kernel/kprobes.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/kernel/kprobes.c	Fri Aug  2 15:45:13 2002
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/config.in working-2.5.30-kprobes/arch/i386/config.in
--- linux-2.5.30/arch/i386/config.in	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/config.in	Fri Aug  2 15:36:03 2002
@@ -415,6 +415,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Probes' CONFIG_KPROBES
 fi
 
 endmenu
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/kernel/entry.S working-2.5.30-kprobes/arch/i386/kernel/entry.S
--- linux-2.5.30/arch/i386/kernel/entry.S	Fri Aug  2 11:15:05 2002
+++ working-2.5.30-kprobes/arch/i386/kernel/entry.S	Fri Aug  2 15:36:03 2002
@@ -430,9 +430,22 @@ device_not_available_emulate:
 	jmp ret_from_exception
 
 ENTRY(debug)
+#ifdef CONFIG_KPROBES
+	pushl %eax
+	SAVE_ALL
+	movl %esp,%edx
+	pushl $0
+	pushl %edx
+	call do_debug
+	addl $8,%esp
+	cmpl $0,%eax 
+	jnz restore_all
+	jmp ret_from_exception
+#else
 	pushl $0
 	pushl $do_debug
 	jmp error_code
+#endif
 
 ENTRY(nmi)
 	pushl %eax
@@ -445,9 +460,22 @@ ENTRY(nmi)
 	RESTORE_ALL
 
 ENTRY(int3)
+#ifdef CONFIG_KPROBES
+	pushl %eax
+	SAVE_ALL
+	movl %esp,%edx
+	pushl $0
+	pushl %edx
+	call do_int3
+	addl $8,%esp
+	cmpl $0,%eax 
+	jnz restore_all
+	jmp ret_from_exception
+#else
 	pushl $0
 	pushl $do_int3
 	jmp error_code
+#endif
 
 ENTRY(overflow)
 	pushl $0
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/kernel/traps.c working-2.5.30-kprobes/arch/i386/kernel/traps.c
--- linux-2.5.30/arch/i386/kernel/traps.c	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/kernel/traps.c	Fri Aug  2 17:38:56 2002
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
@@ -297,6 +302,158 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
+#ifdef CONFIG_KPROBES
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+#define EF_TF	0x00000100
+#define EF_IE	0x00000200
+
+static struct kprobe *current_kprobe;
+static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+
+/*
+ * We changed trap3/1 to an intr gate. So, restore the status of IF,
+ * if necessary, before executing the original int3/1 (trap) handler.
+ */
+static inline void restore_interrupts(struct pt_regs *regs)
+{
+	if (regs->eflags & EF_IE)
+		__asm__ __volatile__ ("sti");
+}
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
+static int kprobe_handler(struct pt_regs * regs)
+{
+	struct kprobe *p;
+	u8 *addr = (u8 *)(regs->eip-1);
+
+	/* Lock, check we're not actually recursing */
+	if (kprobe_running()) {
+		/* We *are* holding lock here, so this is safe.
+                   Disarm the probe we just hit, and ignore it. */
+		p = get_kprobe(addr);
+		/* Not ours?  Can't be delete race, since we hold lock. */
+		if (!p)
+			return 0;
+		disarm_kprobe(p, regs);
+		return 1;
+	}
+
+	lock_kprobes();
+	p = get_kprobe(addr); 
+	if (!p) {
+		unlock_kprobes();
+		/* Unregistered (on another cpu) after this hit?  Ignore */
+		if (*addr != BREAKPOINT_INSTRUCTION)
+			return 1;
+		/* Not one of ours: let kernel handle it */
+		restore_interrupts(regs);
+		return 0;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	current_kprobe = p;
+	kprobe_saved_eflags = kprobe_old_eflags = regs->eflags & (EF_TF|EF_IE);
+	if (is_IF_modifier(p->opcode))
+		kprobe_saved_eflags &= ~EF_IE;
+
+	p->pre_handler(p, regs);
+
+	regs->eflags |= EF_TF;
+	regs->eflags &= ~EF_IE;
+
+	/* We hold lock, now we remove breakpoint and single step. */
+	disarm_kprobe(p, regs);
+	kprobe_status = KPROBE_HIT_SS;
+	return 1;
+}
+
+static void rearm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->eflags &= ~EF_TF;
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
+		regs->esp &= ~(EF_TF | EF_IE);
+		regs->esp |= kprobe_old_eflags;
+	}
+
+	rearm_kprobe(current_kprobe, regs);
+	regs->eflags |= kprobe_saved_eflags;
+
+	unlock_kprobes();
+
+        /*
+	 * if somebody else is singlestepping across a probe point, eflags
+	 * will have TF set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->eflags & EF_TF) {
+		restore_interrupts(regs);
+		return 0;
+	}
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
+	}
+	return 0;
+}
+#else
+static inline int post_kprobe_handler(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_KPROBES */
+
 static inline unsigned long get_cr2(void)
 {
 	unsigned long address;
@@ -326,6 +483,8 @@ static void inline do_trap(int trapnr, i
 		panic("do_trap: can't hit this");
 	}
 #endif	
+	if (kprobe_fault(regs, trapnr))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
@@ -392,7 +551,9 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
+#ifndef CONFIG_KPROBES
 DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
+#endif
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
@@ -408,6 +569,9 @@ asmlinkage void do_general_protection(st
 {
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
+	
+	if (kprobe_fault(regs, 13))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
@@ -508,6 +672,16 @@ asmlinkage void do_nmi(struct pt_regs * 
 	inb(0x71);		/* dummy */
 }
 
+#ifdef CONFIG_KPROBES
+asmlinkage int do_int3(struct pt_regs * regs, long error_code)
+{
+	if (kprobe_handler(regs))
+		return 1;
+	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+	return 0;
+}
+#endif
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
@@ -552,6 +726,8 @@ asmlinkage void do_debug(struct pt_regs 
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
 	if (condition & DR_STEP) {
+		if (kprobe_running() && post_kprobe_handler(regs))
+			return 1;
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -588,15 +764,15 @@ clear_dr7:
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
-	return;
+	return 0;
 
 debug_vm86:
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
-	return;
+	return 0;
 
 clear_TF:
 	regs->eflags &= ~TF_MASK;
-	return;
+	return 0;
 }
 
 /*
@@ -760,6 +936,8 @@ asmlinkage void math_state_restore(struc
 	struct task_struct *tsk = current;
 	clts();		/* Allow maths ops (or we recurse) */
 
+	if (kprobe_fault(&regs, 7))
+		return;
 	if (!tsk->used_math)
 		init_fpu(tsk);
 	restore_fpu(tsk);
@@ -943,9 +1121,17 @@ void __init trap_init(void)
 #endif
 
 	set_trap_gate(0,&divide_error);
+#ifndef CONFIG_KPROBES
 	set_trap_gate(1,&debug);
+#else
+	_set_gate(idt_table+1,14,3,&debug);
+#endif
 	set_intr_gate(2,&nmi);
+#ifndef CONFIG_KPROBES
 	set_system_gate(3,&int3);	/* int3-5 can be called from all */
+#else
+	_set_gate(idt_table+3,14,3,&int3);
+#endif
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/arch/i386/mm/fault.c working-2.5.30-kprobes/arch/i386/mm/fault.c
--- linux-2.5.30/arch/i386/mm/fault.c	Sat Jul 27 15:24:35 2002
+++ working-2.5.30-kprobes/arch/i386/mm/fault.c	Mon Aug  5 10:57:18 2002
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
+	if (kprobe_fault(regs, 14))
+		return;
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/fs/partitions/check.c working-2.5.30-kprobes/fs/partitions/check.c
--- linux-2.5.30/fs/partitions/check.c	Fri Aug  2 11:15:09 2002
+++ working-2.5.30-kprobes/fs/partitions/check.c	Fri Aug  2 17:30:34 2002
@@ -467,7 +467,7 @@ void devfs_register_partitions (struct g
 	for (part = 1; part < max_p; part++) {
 		if ( unregister || (p[part].nr_sects < 1) ) {
 			devfs_unregister(p[part].de);
-			dev->part[p].de = NULL;
+			dev->part[part].de = NULL;
 			continue;
 		}
 		devfs_register_partition (dev, minor, part);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.30/include/asm-i386/kprobes.h working-2.5.30-kprobes/include/asm-i386/kprobes.h
--- linux-2.5.30/include/asm-i386/kprobes.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.30-kprobes/include/asm-i386/kprobes.h	Fri Aug  2 15:40:33 2002
@@ -0,0 +1,28 @@
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
+#ifdef CONFIG_KPROBES
+typedef u8 kprobe_opcode_t;
+
+#define BREAKPOINT_INSTRUCTION	0xcc
+
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+
+/* kprobe_running() not defined yet, so this is a macro. */
+#define kprobe_fault(regs, trapnr)					\
+	(kprobe_running() && kprobe_fault_handler(regs, trapnr))
+
+#else /* !CONFIG_KPROBES */
+static inline int kprobe_fault(struct pt_regs *regs, int trapnr) { return 0; }
+#endif
+
+#endif /* _ASM_KPROBES_H */
