Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTBDUXB>; Tue, 4 Feb 2003 15:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTBDUXB>; Tue, 4 Feb 2003 15:23:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37323 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267449AbTBDUWy>;
	Tue, 4 Feb 2003 15:22:54 -0500
Message-ID: <3E4022C4.8050801@us.ibm.com>
Date: Tue, 04 Feb 2003 12:29:56 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org, markh@osdl.org
Subject: [PATCH] x86 interrupt stacks
Content-Type: multipart/mixed;
 boundary="------------060004080006050006040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060004080006050006040007
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This applies cleanly againt 2.5.59.  It gets rid of the ugly multi-line
C macros in entry.S and cleans up the declarations of the interrupt
handler functions.

Something in my previous patches was causing faulures with gcc-3.2.  I
suspect it was one of the functions using regparm(1) and asmlinkage
(which implies regparm(0)) at the same time.

Tested:
UP gcc-3.2
SMP gcc-3.2 and 2.95.4
-- 
Dave Hansen
haveblue@us.ibm.com

--------------060004080006050006040007
Content-Type: text/plain;
 name="B-interrupt-stacks-2.5.59-9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="B-interrupt-stacks-2.5.59-9.patch"

diff -ur linux-2.5.59-thread_info-infra/arch/i386/Kconfig linux-2.5.59-irqstack/arch/i386/Kconfig
--- linux-2.5.59-thread_info-infra/arch/i386/Kconfig	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/Kconfig	Tue Feb  4 10:44:02 2003
@@ -368,6 +368,11 @@
 	depends on MK8 || MPENTIUM4
 	default y
 
+config X86_CMOV
+	bool
+	depends on M686 || MPENTIUMII || MPENTIUMIII || MPENTIUM4 || MK8 || MCRUSOE
+	default y
+
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/apic.c linux-2.5.59-irqstack/arch/i386/kernel/apic.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/apic.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/apic.c	Tue Feb  4 11:37:21 2003
@@ -1038,7 +1038,8 @@
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
 
-void smp_apic_timer_interrupt(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(smp_apic_timer_interrupt(struct pt_regs* regs));
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs)
 {
 	int cpu = smp_processor_id();
 
@@ -1058,14 +1059,16 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	smp_local_timer_interrupt(regs);
 	irq_exit();
+	return regs;
 }
 
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
  */
-asmlinkage void smp_spurious_interrupt(void)
+struct pt_regs * IRQHANDLER(smp_spurious_interrupt(struct pt_regs* regs));
+struct pt_regs * smp_spurious_interrupt(struct pt_regs* regs)
 {
 	unsigned long v;
 
@@ -1083,13 +1086,15 @@
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
 	irq_exit();
+	return regs;
 }
 
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
 
-asmlinkage void smp_error_interrupt(void)
+struct pt_regs * IRQHANDLER(smp_error_interrupt(struct pt_regs* regs));
+struct pt_regs * smp_error_interrupt(struct pt_regs* regs)
 {
 	unsigned long v, v1;
 
@@ -1114,6 +1119,7 @@
 	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	return regs;
 }
 
 /*
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/cpu/mcheck/p4.c linux-2.5.59-irqstack/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/cpu/mcheck/p4.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/cpu/mcheck/p4.c	Tue Feb  4 11:37:26 2003
@@ -61,11 +61,13 @@
 /* Thermal interrupt handler for this CPU setup */
 static void (*vendor_thermal_interrupt)(struct pt_regs *regs) = unexpected_thermal_interrupt;
 
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(smp_thermal_interrupt(struct pt_regs* regs));
+struct pt_regs * smp_thermal_interrupt(struct pt_regs* regs)
 {
 	irq_enter();
 	vendor_thermal_interrupt(&regs);
 	irq_exit();
+	return regs;
 }
 
 /* P4/Xeon Thermal regulation detect and init */
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/entry.S linux-2.5.59-irqstack/arch/i386/kernel/entry.S
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/entry.S	Tue Feb  4 12:09:05 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/entry.S	Tue Feb  4 12:13:20 2003
@@ -388,17 +388,78 @@
 vector=vector+1
 .endr
 
+
+# lets play optimizing compiler...
+#ifdef CONFIG_X86_CMOV
+#define COND_MOVE	cmovnz %esi,%esp;
+#else
+#define COND_MOVE	\
+	jz 1f;		\
+	mov %esi,%esp;	\
+1:
+#endif
+
+# These macros will switch you to, and from a per-cpu interrupt stack
+# They take the pt_regs arg and move it from the normal place on the 
+# stack to %eax.  Any handler function can retrieve it using regparm(1). 
+# The handlers are expected to return the stack to switch back to in 
+# the same register. 
+#
+# This means that the irq handlers need to return their arg
+#
+# SWITCH_TO_IRQSTACK clobbers %ebx, %ecx, %edx, %esi
+# old stack gets put in %eax
+
+.macro SWITCH_TO_IRQSTACK 
+	GET_THREAD_INFO(%ebx);
+	movl TI_IRQ_STACK(%ebx),%ecx;
+	movl TI_TASK(%ebx),%edx;
+	movl %esp,%eax;
+
+	# %ecx+THREAD_SIZE is next stack -4 keeps us in the right one
+	leal (THREAD_SIZE-4)(%ecx),%esi; 
+
+	# is there a valid irq_stack?
+	testl %ecx,%ecx;
+	COND_MOVE;
+
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%esi);
+	movl %edx,TI_TASK(%esi);
+
+	# update the preempt count in the irq stack
+	movl TI_PRE_COUNT(%ebx),%ecx;
+	movl %ecx,TI_PRE_COUNT(%esi);
+.endm
+
+# copy flags from the irq stack back into the task's thread_info
+# %esi is saved over the irq handler call and contains the irq stack's
+#      thread_info pointer
+# %eax was returned from the handler, as described above
+# %ebx contains the original thread_info pointer
+
+.macro RESTORE_FROM_IRQSTACK 
+	movl %eax,%esp;
+	movl TI_FLAGS(%esi),%eax;
+	movl $0,TI_FLAGS(%esi);
+	LOCK orl %eax,TI_FLAGS(%ebx);
+.endm
+
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	SWITCH_TO_IRQSTACK
 	call do_IRQ
+	RESTORE_FROM_IRQSTACK
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	SWITCH_TO_IRQSTACK;		\
+	call smp_/**/name;		\
+	RESTORE_FROM_IRQSTACK;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/init_task.c linux-2.5.59-irqstack/arch/i386/kernel/init_task.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/init_task.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/init_task.c	Tue Feb  4 10:44:02 2003
@@ -13,6 +13,10 @@
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
+union thread_union init_irq_union
+	__attribute__((__section__(".data.init_task")));
+
+
 /*
  * Initial thread structure.
  *
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/irq.c linux-2.5.59-irqstack/arch/i386/kernel/irq.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/irq.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/irq.c	Tue Feb  4 11:37:30 2003
@@ -311,7 +311,8 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(do_IRQ(struct pt_regs *regs));
+struct pt_regs * do_IRQ(struct pt_regs *regs)
 {	
 	/* 
 	 * We ack quickly, we don't want the irq controller
@@ -323,7 +324,7 @@
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs->orig_eax & 0xff; /* high bits used in ret_from_ code  */
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
@@ -388,7 +389,7 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -407,7 +408,7 @@
 
 	irq_exit();
 
-	return 1;
+	return regs;
 }
 
 /**
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/process.c linux-2.5.59-irqstack/arch/i386/kernel/process.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/process.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/process.c	Tue Feb  4 10:44:02 2003
@@ -432,6 +432,7 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/smp.c linux-2.5.59-irqstack/arch/i386/kernel/smp.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/smp.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/smp.c	Tue Feb  4 11:37:40 2003
@@ -305,7 +305,8 @@
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
 
-asmlinkage void smp_invalidate_interrupt (void)
+struct pt_regs * IRQHANDLER(smp_invalidate_interrupt(struct pt_regs *regs));
+struct pt_regs * smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
 
@@ -336,6 +337,7 @@
 
 out:
 	put_cpu_no_resched();
+	return regs;
 }
 
 static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
@@ -576,12 +578,15 @@
  * all the work is done automatically when
  * we return from the interrupt.
  */
-asmlinkage void smp_reschedule_interrupt(void)
+struct pt_regs * IRQHANDLER(smp_reschedule_interrupt(struct pt_regs *regs));
+struct pt_regs * smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+	return regs;
 }
 
-asmlinkage void smp_call_function_interrupt(void)
+struct pt_regs * IRQHANDLER(smp_call_function_interrupt(struct pt_regs *regs));
+struct pt_regs * smp_call_function_interrupt(struct pt_regs *regs)
 {
 	void (*func) (void *info) = call_data->func;
 	void *info = call_data->info;
@@ -605,5 +610,6 @@
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	return regs;
 }
 
diff -ur linux-2.5.59-thread_info-infra/arch/i386/kernel/smpboot.c linux-2.5.59-irqstack/arch/i386/kernel/smpboot.c
--- linux-2.5.59-thread_info-infra/arch/i386/kernel/smpboot.c	Tue Feb  4 10:32:54 2003
+++ linux-2.5.59-irqstack/arch/i386/kernel/smpboot.c	Tue Feb  4 10:44:02 2003
@@ -71,6 +71,11 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+/* Per CPU interrupt stacks */
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
@@ -772,6 +777,28 @@
 }
 #endif	/* WAKE_SECONDARY_VIA_INIT */
 
+static void __init setup_irq_stack(struct task_struct *p, int cpu)
+{
+	unsigned long stk;
+
+	stk = __get_free_pages(GFP_KERNEL, THREAD_ORDER);
+	if (!stk)
+		panic("I can't seem to allocate my irq stack.  Oh well, giving up.");
+
+	irq_stacks[cpu] = (void *)stk;
+	memset(irq_stacks[cpu], 0, THREAD_SIZE);
+	irq_stacks[cpu]->thread_info.cpu = cpu;
+	irq_stacks[cpu]->thread_info.preempt_count = 1;
+					/* interrupts are not preemptable */
+	p->thread_info->irq_stack = &irq_stacks[cpu]->thread_info;
+
+	/* If we want to make the irq stack more than one unit
+	 * deep, we can chain then off of the irq_stack pointer
+	 * here.
+	 */
+}
+
+
 extern unsigned long cpu_initialized;
 
 static int __init do_boot_cpu(int apicid)
@@ -795,6 +822,8 @@
 	idle = fork_by_hand();
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+
+	setup_irq_stack(idle, cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
diff -ur linux-2.5.59-thread_info-infra/include/asm-i386/linkage.h linux-2.5.59-irqstack/include/asm-i386/linkage.h
--- linux-2.5.59-thread_info-infra/include/asm-i386/linkage.h	Tue Feb  4 10:32:50 2003
+++ linux-2.5.59-irqstack/include/asm-i386/linkage.h	Tue Feb  4 11:24:24 2003
@@ -3,6 +3,7 @@
 
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #define FASTCALL(x)	x __attribute__((regparm(3)))
+#define IRQHANDLER(x)	x __attribute__((regparm(1)))
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
diff -ur linux-2.5.59-thread_info-infra/include/asm-i386/thread_info.h linux-2.5.59-irqstack/include/asm-i386/thread_info.h
--- linux-2.5.59-thread_info-infra/include/asm-i386/thread_info.h	Tue Feb  4 12:09:05 2003
+++ linux-2.5.59-irqstack/include/asm-i386/thread_info.h	Tue Feb  4 10:44:02 2003
@@ -30,9 +30,11 @@
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
+						   0 for interrupts: illegal
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct thread_info	*irq_stack;	/* pointer to cpu irq stack */
 	struct restart_block    restart_block;
 
 	__u8			supervisor_stack[0];
@@ -47,7 +49,8 @@
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
-#define TI_RESTART_BLOCK 0x0000018
+#define TI_IRQ_STACK	0x00000018
+#define TI_RESTART_BLOCK 0x0000022
 
 #endif
 
@@ -63,17 +66,18 @@
 
 #ifndef __ASSEMBLY__
 
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.task		= &tsk,         	\
-	.exec_domain	= &default_exec_domain,	\
-	.flags		= 0,			\
-	.cpu		= 0,			\
-	.preempt_count	= 1,			\
-	.addr_limit	= KERNEL_DS,		\
-	.restart_block = {			\
-		.fn = do_no_restart_syscall,	\
-	},					\
+#define INIT_THREAD_INFO(tsk)				\
+{							\
+	.task		= &tsk,         		\
+	.exec_domain	= &default_exec_domain,		\
+	.flags		= 0,				\
+	.cpu		= 0,				\
+	.preempt_count	= 1,				\
+	.addr_limit	= KERNEL_DS,			\
+	.irq_stack	= &init_irq_union.thread_info,	\
+	.restart_block = {				\
+		.fn = do_no_restart_syscall,		\
+	}						\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)

--------------060004080006050006040007--

