Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHBCLm>; Thu, 1 Aug 2002 22:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSHBCLm>; Thu, 1 Aug 2002 22:11:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37802 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317694AbSHBCLh>;
	Thu, 1 Aug 2002 22:11:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, "S Vamsikrishna" <vamsi_krishna@in.ibm.com>
Subject: [PATCH] kprobes for 2.5.30
Date: Fri, 02 Aug 2002 12:11:47 +1000
Message-Id: <20020802021635.D8A674CA5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Vamsi's kernel probes again, this time with EXPORT_SYMBOL_GPL
so people don't think this is blanket permission to hook into
arbitrary parts of the kernel (as separate from debugging, testing,
diagnostics, etc).

	For a change, this one's cool and *doesn't* break anything 8)

Please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Kprobes for i386
Author: Vamsi Krishna S
Status: Tested on 2.5.26 SMP

D: This patch allows trapping at almost any kernel address, useful for
D: various kernel-hacking tasks, and building on for more
D: infrastructure.  This patch is x86 only.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/Config.help working-2.5.26-kprobes/arch/i386/Config.help
--- linux-2.5.26/arch/i386/Config.help	Mon Jun 17 23:19:15 2002
+++ working-2.5.26-kprobes/arch/i386/Config.help	Fri Jul 19 11:17:46 2002
@@ -967,3 +967,9 @@ CONFIG_SOFTWARE_SUSPEND
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+CONFIG_KPROBES
+  Kprobes allows you to trap at almost any kernel address, using
+  register_kprobe(), and providing a callback function.  This is useful
+  for kernel debugging, non-intrusive instrumentation and testing.  If
+  in doubt, say "N".
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/config.in working-2.5.26-kprobes/arch/i386/config.in
--- linux-2.5.26/arch/i386/config.in	Wed Jul 17 10:25:46 2002
+++ working-2.5.26-kprobes/arch/i386/config.in	Fri Jul 19 11:17:46 2002
@@ -419,6 +419,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Probes' CONFIG_KPROBES
 fi
 
 endmenu
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/kernel/entry.S working-2.5.26-kprobes/arch/i386/kernel/entry.S
--- linux-2.5.26/arch/i386/kernel/entry.S	Mon Jun 17 23:19:16 2002
+++ working-2.5.26-kprobes/arch/i386/kernel/entry.S	Fri Jul 19 11:17:46 2002
@@ -442,9 +442,24 @@ device_not_available_emulate:
 	jmp ret_from_exception
 
 ENTRY(debug)
+#ifdef CONFIG_KPROBES
+	pushl %eax
+	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+	movl %esp,%edx
+	pushl $0
+	pushl %edx
+	call do_debug
+	addl $8,%esp
+	cmpl $0,%eax 
+	jnz restore_all
+	preempt_stop
+	jmp ret_from_exception
+#else
 	pushl $0
 	pushl $do_debug
 	jmp error_code
+#endif
 
 ENTRY(nmi)
 	pushl %eax
@@ -457,9 +472,24 @@ ENTRY(nmi)
 	RESTORE_ALL
 
 ENTRY(int3)
+#ifdef CONFIG_KPROBES
+	pushl %eax
+	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+	movl %esp,%edx
+	pushl $0
+	pushl %edx
+	call do_int3
+	addl $8,%esp
+	cmpl $0,%eax 
+	jnz restore_all
+	preempt_stop
+	jmp ret_from_exception
+#else
 	pushl $0
 	pushl $do_int3
 	jmp error_code
+#endif
 
 ENTRY(overflow)
 	pushl $0
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/kernel/i386_ksyms.c working-2.5.26-kprobes/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.26/arch/i386/kernel/i386_ksyms.c	Fri Jun 21 09:41:52 2002
+++ working-2.5.26-kprobes/arch/i386/kernel/i386_ksyms.c	Fri Jul 19 11:17:46 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/kprobes.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -176,6 +177,11 @@ extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_KPROBES
+EXPORT_SYMBOL_GPL(register_kprobe);
+EXPORT_SYMBOL_GPL(unregister_kprobe);
+#endif
 
 #ifdef CONFIG_MULTIQUAD
 EXPORT_SYMBOL(xquad_portio);
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/kernel/traps.c working-2.5.26-kprobes/arch/i386/kernel/traps.c
--- linux-2.5.26/arch/i386/kernel/traps.c	Fri Jun 21 09:41:52 2002
+++ working-2.5.26-kprobes/arch/i386/kernel/traps.c	Fri Jul 19 11:17:48 2002
@@ -5,6 +5,9 @@
  *
  *  Pentium III FXSR, SSE support
  *	Gareth Hughes <gareth@valinux.com>, May 2000
+ *
+ *  Dynamic Probes (kprobes) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, July, 2002
  */
 
 /*
@@ -50,6 +53,8 @@
 #include <asm/cobalt.h>
 #include <asm/lithium.h>
 #endif
+#include <asm/kprobes.h>
+#include <linux/hash.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -297,6 +302,222 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
+#ifdef CONFIG_KPROBES
+static spinlock_t kprobe_lock = SPIN_LOCK_UNLOCKED;
+unsigned int kprobe_cpu = NR_CPUS;
+static struct kprobe *kprobe_running;
+static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+#define KPROBE_HASH_BITS 6
+#define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
+static struct list_head kprobe_table[KPROBE_TABLE_SIZE];
+
+/* You have to be holding the kprobe_lock */
+static struct kprobe *get_kprobe(void *addr)
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
+	/* Recursion check, so we don't deadlock. */
+	if (kprobe_cpu == smp_processor_id()) {
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
+	spin_lock(&kprobe_lock);
+	kprobe_cpu = smp_processor_id();
+	p = get_kprobe(addr); 
+	if (!p) {
+		kprobe_cpu = NR_CPUS;
+		spin_unlock(&kprobe_lock);
+		/* Unregistered (on another cpu) after this hit?  Ignore */
+		if (*addr != BREAKPOINT_INSTRUCTION)
+			return 1;
+		/* Not one of ours: let kernel handle it */
+		restore_interrupts(regs);
+		return 0;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	kprobe_running = p;
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
+ * remain disabled thorough out this function.  And we hold kprobe_lock.
+ */
+static int post_kprobe_handler(struct pt_regs *regs)
+{
+	if (kprobe_running->post_handler)
+		kprobe_running->post_handler(kprobe_running, regs, 0);
+
+	/*
+	 * We singlestepped with interrupts disabled. So, the result on
+	 * the stack would be incorrect for "pushfl" instruction.
+	 */
+	if (kprobe_running->opcode == 0x9c) { /* pushfl */
+		regs->esp &= ~(EF_TF | EF_IE);
+		regs->esp |= kprobe_old_eflags;
+	}
+
+	rearm_kprobe(kprobe_running, regs);
+	regs->eflags |= kprobe_saved_eflags;
+
+	kprobe_cpu = NR_CPUS;
+	spin_unlock(&kprobe_lock);
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
+	if (kprobe_running->fault_handler
+	    && kprobe_running->fault_handler(kprobe_running, regs, trapnr))
+		return 1;
+
+	if (kprobe_status & KPROBE_HIT_SS) {
+		rearm_kprobe(kprobe_running, regs);
+        	regs->eflags |= kprobe_old_eflags;
+
+		kprobe_cpu = NR_CPUS;
+		spin_unlock(&kprobe_lock);
+	}
+	return 0;
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
+	p->status = 0UL;
+	p->opcode = *p->addr;
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	/* This is a noop on Intel, but good form nonetheless */
+	flush_icache_range(p->addr, p->addr + 4);
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
+	/* This is a noop on Intel, but good form nonetheless */
+	flush_icache_range(p->addr, p->addr + 4);
+	spin_unlock_irq(&kprobe_lock);
+}
+
+static int __init init_kprobes(void)
+{
+	int i;
+	
+	/* FIXME allocate the probe table,  currently defined statically */
+
+	/* initialize all list heads */
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&kprobe_table[i]);
+
+	return 0;
+}
+__initcall(init_kprobes);
+#endif /* CONFIG_KPROBES */
+
 static inline unsigned long get_cr2(void)
 {
 	unsigned long address;
@@ -326,6 +547,8 @@ static void inline do_trap(int trapnr, i
 		panic("do_trap: can't hit this");
 	}
 #endif	
+	if (kprobe_fault(regs, trapnr))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
@@ -392,7 +615,9 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
+#ifndef CONFIG_KPROBES
 DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
+#endif
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
@@ -408,6 +633,9 @@ asmlinkage void do_general_protection(st
 {
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
+	
+	if (kprobe_fault(regs, 13))
+		return;
 
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
@@ -508,6 +736,16 @@ asmlinkage void do_nmi(struct pt_regs * 
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
@@ -530,7 +768,7 @@ asmlinkage void do_nmi(struct pt_regs * 
  * find every occurrence of the TF bit that could be saved away even
  * by user code)
  */
-asmlinkage void do_debug(struct pt_regs * regs, long error_code)
+asmlinkage int do_debug(struct pt_regs * regs, long error_code)
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
@@ -552,6 +790,11 @@ asmlinkage void do_debug(struct pt_regs 
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
 	if (condition & DR_STEP) {
+#ifdef CONFIG_KPROBES
+		if (kprobe_cpu == smp_processor_id()
+		    && post_kprobe_handler(regs))
+			return 1;
+#endif
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -588,15 +831,15 @@ clear_dr7:
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
@@ -760,6 +1003,8 @@ asmlinkage void math_state_restore(struc
 	struct task_struct *tsk = current;
 	clts();		/* Allow maths ops (or we recurse) */
 
+	if (kprobe_fault(&regs, 7))
+		return;
 	if (!tsk->used_math)
 		init_fpu(tsk);
 	restore_fpu(tsk);
@@ -975,9 +1220,17 @@ void __init trap_init(void)
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
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/arch/i386/mm/fault.c working-2.5.26-kprobes/arch/i386/mm/fault.c
--- linux-2.5.26/arch/i386/mm/fault.c	Sun Jul  7 02:12:18 2002
+++ working-2.5.26-kprobes/arch/i386/mm/fault.c	Fri Jul 19 11:17:46 2002
@@ -20,6 +20,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 
+#include <asm/kprobes.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -156,6 +157,9 @@ asmlinkage void do_page_fault(struct pt_
 
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
+
+	if (kprobe_fault(regs, 14))
+		return;
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26/include/asm-i386/kprobes.h working-2.5.26-kprobes/include/asm-i386/kprobes.h
--- linux-2.5.26/include/asm-i386/kprobes.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.26-kprobes/include/asm-i386/kprobes.h	Fri Jul 19 11:17:48 2002
@@ -0,0 +1,63 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Dynamic Probes (kprobes) support
+ *  	Vamsi Krishna S <vamsi_krishna@in.ibm.com>, July, 2002
+ *	Mailing list: dprobes@www-124.ibm.com
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/percpu.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+
+struct kprobe;
+
+typedef void (*kprobe_pre_handler_t)(struct kprobe *, struct pt_regs *);
+typedef void (*kprobe_post_handler_t)(struct kprobe *, struct pt_regs *,
+				      unsigned long flags);
+typedef int (*kprobe_fault_handler_t)(struct kprobe *, struct pt_regs *,
+				      int trapnr);
+
+struct kprobe {
+	u8 * addr;	/* location of the probe point */
+	struct list_head list;
+	unsigned long status;
+	 /* Called before addr is executed. */
+	kprobe_pre_handler_t pre_handler;
+	/* Called after addr is executed, unless... */
+	kprobe_post_handler_t post_handler;
+	 /* ... called if executing addr causes a fault (eg. page fault).
+	  * Return 1 if it handled fault, otherwise kernel will see it. */
+	kprobe_fault_handler_t fault_handler;
+	u8 opcode;
+};
+
+/* Set to cpu currently running a probe hit */
+extern unsigned int kprobe_cpu;
+
+#define BREAKPOINT_INSTRUCTION	0xcc
+#define EF_TF	0x00000100
+#define EF_IE	0x00000200
+
+#ifdef CONFIG_KPROBES
+extern int register_kprobe(struct kprobe *p);
+extern void unregister_kprobe(struct kprobe *p);
+
+extern int kprobe_fault_handler(struct pt_regs * regs, int trapnr);
+
+static inline int kprobe_fault(struct pt_regs *regs, int trapnr)
+{
+	if (kprobe_cpu == smp_processor_id()
+	    && kprobe_fault_handler(regs, trapnr))
+		return 1;
+	return 0;
+}
+#else /* ! CONFIG_KPROBES */
+static inline int register_kprobe(struct probe_struct *p) { return -ENOSYS; }
+static inline void unregister_kprobe(struct probe_struct *p) { }
+static inline int kprobe_fault(struct pt_regs *regs, int trapnr) { return 0; }
+#endif
+
+#endif /* _ASM_KPROBES_H */
