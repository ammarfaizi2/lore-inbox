Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTBTQCn>; Thu, 20 Feb 2003 11:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTBTQCn>; Thu, 20 Feb 2003 11:02:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:28321 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265643AbTBTQCb>; Thu, 20 Feb 2003 11:02:31 -0500
Date: Thu, 20 Feb 2003 08:11:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <39710000.1045757490@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========463958336=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========463958336==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Does anybody have an up-to-date "use -gp and a special 'mcount()' 
> function to check stack depth" patch? The CONFIG_DEBUG_STACKOVERFLOW thing 
> is quite possibly too stupid to find things like this (it only finds 
> interrupts that overflow the stack, not deep call sequences).
> 
> Guys: you could try to enable CONFIG_DEBUG_STACKOVERFLOW, and then perhaps 
> make it a bit more aggressive (rigth now it does:
> 
>                 if (unlikely(esp < (sizeof(struct thread_info) + 1024))) {
> 
> and I'd suggest changing it to something more like
> 
> 		/* Have we used up more than half the stack? */
> 		if (unlikely(esp < 4096)) {
> 
> and add a "for (;;)" after doing the dump_stack() because otherwise the 
> machine may reboot before you get anywhere.

There are patches in -mjb from Dave Hansen / Ben LaHaise to detect stack
overflow included with the stuff for the 4K stacks patch (intended for 
scaling to large numbers of tasks). I've split them out attatched, should 
apply to mainline reasonably easily.

M.

PS. Linus, I think the attatchments will work for you as they're text/plain,
if not, I'll resend them all inline.

--==========463958336==========
Content-Type: text/plain; charset=us-ascii; name=220-thread_info_cleanup
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=220-thread_info_cleanup; size=4328

diff -urpN -X /home/fletch/.diff.exclude 211-shpte/arch/i386/kernel/entry.S 220-thread_info_cleanup/arch/i386/kernel/entry.S
--- 211-shpte/arch/i386/kernel/entry.S	Sun Feb 16 15:10:13 2003
+++ 220-thread_info_cleanup/arch/i386/kernel/entry.S	Mon Feb 17 10:57:56 2003
@@ -155,7 +155,7 @@ do_lcall:
 	movl %eax,EFLAGS(%ebp)	#
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%ebp)	#
-	andl $-8192, %ebp	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebp)  # GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain
 	addl $4, %esp
diff -urpN -X /home/fletch/.diff.exclude 211-shpte/arch/i386/kernel/head.S 220-thread_info_cleanup/arch/i386/kernel/head.S
--- 211-shpte/arch/i386/kernel/head.S	Thu Jan  2 22:04:58 2003
+++ 220-thread_info_cleanup/arch/i386/kernel/head.S	Mon Feb 17 10:57:56 2003
@@ -16,6 +16,7 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 #include <asm/cache.h>
+#include <asm/thread_info.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -309,7 +310,7 @@ rp_sidt:
 	ret
 
 ENTRY(stack_start)
-	.long init_thread_union+8192
+	.long init_thread_union+THREAD_SIZE
 	.long __BOOT_DS
 
 /* This is the default interrupt "handler" :-) */
diff -urpN -X /home/fletch/.diff.exclude 211-shpte/include/asm-i386/page.h 220-thread_info_cleanup/include/asm-i386/page.h
--- 211-shpte/include/asm-i386/page.h	Sun Feb 16 13:18:59 2003
+++ 220-thread_info_cleanup/include/asm-i386/page.h	Mon Feb 17 10:57:56 2003
@@ -3,7 +3,11 @@
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#ifndef __ASSEMBLY__
+#define PAGE_SIZE      (1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE      (1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
diff -urpN -X /home/fletch/.diff.exclude 211-shpte/include/asm-i386/thread_info.h 220-thread_info_cleanup/include/asm-i386/thread_info.h
--- 211-shpte/include/asm-i386/thread_info.h	Thu Jan  9 19:16:11 2003
+++ 220-thread_info_cleanup/include/asm-i386/thread_info.h	Mon Feb 17 10:57:56 2003
@@ -9,6 +9,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page.h>
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
@@ -57,11 +58,14 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
+#define THREAD_ORDER 1 
+#define INIT_THREAD_SIZE       THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
+	.task		= &tsk,         	\
 	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
@@ -75,30 +79,36 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
+/* thread information allocation */
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
+#define get_thread_info(ti) get_task_struct((ti)->task)
+#define put_thread_info(ti) put_task_struct((ti)->task)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~8191UL));
+	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~(THREAD_SIZE - 1)));
 	return ti;
 }
 
-/* thread information allocation */
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info() ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
-
 #else /* !__ASSEMBLY__ */
 
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg) \
-	movl $-8192, reg; \
+	movl $-THREAD_SIZE, reg; \
 	andl %esp, reg
 
-#endif
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
 
+#endif
+	 
 /*
  * thread information flags
  * - these are process state flags that various assembly files may need to access

--==========463958336==========
Content-Type: text/plain; charset=us-ascii; name=221-interrupt_stacks
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=221-interrupt_stacks; size=13839

diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/Kconfig 221-interrupt_stacks/arch/i386/Kconfig
--- 220-thread_info_cleanup/arch/i386/Kconfig	Mon Feb 17 10:55:52 2003
+++ 221-interrupt_stacks/arch/i386/Kconfig	Mon Feb 17 10:57:57 2003
@@ -374,6 +374,11 @@ config X86_SSE2
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
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/apic.c 221-interrupt_stacks/arch/i386/kernel/apic.c
--- 220-thread_info_cleanup/arch/i386/kernel/apic.c	Sat Feb 15 16:11:40 2003
+++ 221-interrupt_stacks/arch/i386/kernel/apic.c	Mon Feb 17 10:57:57 2003
@@ -1040,7 +1040,8 @@ inline void smp_local_timer_interrupt(st
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
 
-void smp_apic_timer_interrupt(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(smp_apic_timer_interrupt(struct pt_regs* regs));
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs)
 {
 	int cpu = smp_processor_id();
 
@@ -1060,14 +1061,16 @@ void smp_apic_timer_interrupt(struct pt_
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
 
@@ -1085,13 +1088,15 @@ asmlinkage void smp_spurious_interrupt(v
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
 
@@ -1116,6 +1121,7 @@ asmlinkage void smp_error_interrupt(void
 	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	return regs;
 }
 
 /*
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/cpu/mcheck/p4.c 221-interrupt_stacks/arch/i386/kernel/cpu/mcheck/p4.c
--- 220-thread_info_cleanup/arch/i386/kernel/cpu/mcheck/p4.c	Thu Jan  2 22:04:58 2003
+++ 221-interrupt_stacks/arch/i386/kernel/cpu/mcheck/p4.c	Mon Feb 17 10:57:57 2003
@@ -61,11 +61,13 @@ static void intel_thermal_interrupt(stru
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
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/entry.S 221-interrupt_stacks/arch/i386/kernel/entry.S
--- 220-thread_info_cleanup/arch/i386/kernel/entry.S	Mon Feb 17 10:57:56 2003
+++ 221-interrupt_stacks/arch/i386/kernel/entry.S	Mon Feb 17 10:57:57 2003
@@ -388,17 +388,78 @@ ENTRY(irq_entries_start)
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
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/init_task.c 221-interrupt_stacks/arch/i386/kernel/init_task.c
--- 220-thread_info_cleanup/arch/i386/kernel/init_task.c	Thu Feb 13 11:08:02 2003
+++ 221-interrupt_stacks/arch/i386/kernel/init_task.c	Mon Feb 17 10:57:57 2003
@@ -14,6 +14,10 @@ static struct signal_struct init_signals
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
+union thread_union init_irq_union
+	__attribute__((__section__(".data.init_task")));
+
+
 /*
  * Initial thread structure.
  *
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/irq.c 221-interrupt_stacks/arch/i386/kernel/irq.c
--- 220-thread_info_cleanup/arch/i386/kernel/irq.c	Thu Feb 13 11:08:02 2003
+++ 221-interrupt_stacks/arch/i386/kernel/irq.c	Mon Feb 17 10:57:57 2003
@@ -311,7 +311,8 @@ void enable_irq(unsigned int irq)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(do_IRQ(struct pt_regs *regs));
+struct pt_regs * do_IRQ(struct pt_regs *regs)
 {	
 	/* 
 	 * We ack quickly, we don't want the irq controller
@@ -323,7 +324,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs->orig_eax & 0xff; /* high bits used in ret_from_ code  */
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
@@ -388,7 +389,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -407,7 +408,7 @@ out:
 
 	irq_exit();
 
-	return 1;
+	return regs;
 }
 
 /**
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/process.c 221-interrupt_stacks/arch/i386/kernel/process.c
--- 220-thread_info_cleanup/arch/i386/kernel/process.c	Thu Feb 13 11:08:02 2003
+++ 221-interrupt_stacks/arch/i386/kernel/process.c	Mon Feb 17 10:57:57 2003
@@ -432,6 +432,7 @@ void __switch_to(struct task_struct *pre
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/smp.c 221-interrupt_stacks/arch/i386/kernel/smp.c
--- 220-thread_info_cleanup/arch/i386/kernel/smp.c	Sun Feb 16 13:22:10 2003
+++ 221-interrupt_stacks/arch/i386/kernel/smp.c	Mon Feb 17 10:57:57 2003
@@ -305,7 +305,8 @@ static inline void leave_mm (unsigned lo
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
 
-asmlinkage void smp_invalidate_interrupt (void)
+struct pt_regs * IRQHANDLER(smp_invalidate_interrupt(struct pt_regs *regs));
+struct pt_regs * smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
 
@@ -336,6 +337,7 @@ asmlinkage void smp_invalidate_interrupt
 
 out:
 	put_cpu_no_resched();
+	return regs;
 }
 
 static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
@@ -598,12 +600,15 @@ void smp_send_stop(void)
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
 
-asmlinkage void smp_call_function_interrupt(struct pt_regs regs)
+struct pt_regs * IRQHANDLER(smp_call_function_interrupt(struct pt_regs *regs));
+struct pt_regs * smp_call_function_interrupt(struct pt_regs *regs)
 {
 	void (*func) (void *info, struct pt_regs *) = (void (*)(void *, struct pt_regs*))call_data->func;
 	void *info = call_data->info;
@@ -627,5 +632,6 @@ asmlinkage void smp_call_function_interr
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	return regs;
 }
 
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/arch/i386/kernel/smpboot.c 221-interrupt_stacks/arch/i386/kernel/smpboot.c
--- 220-thread_info_cleanup/arch/i386/kernel/smpboot.c	Sun Feb 16 13:18:39 2003
+++ 221-interrupt_stacks/arch/i386/kernel/smpboot.c	Mon Feb 17 10:57:57 2003
@@ -71,6 +71,11 @@ static unsigned long smp_commenced_mask;
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+/* Per CPU interrupt stacks */
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
@@ -770,6 +775,28 @@ wakeup_secondary_cpu(int phys_apicid, un
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
@@ -793,6 +820,8 @@ static int __init do_boot_cpu(int apicid
 	idle = fork_by_hand();
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+
+	setup_irq_stack(idle, cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/include/asm-i386/linkage.h 221-interrupt_stacks/include/asm-i386/linkage.h
--- 220-thread_info_cleanup/include/asm-i386/linkage.h	Sun Nov 17 20:29:46 2002
+++ 221-interrupt_stacks/include/asm-i386/linkage.h	Mon Feb 17 10:57:57 2003
@@ -3,6 +3,7 @@
 
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #define FASTCALL(x)	x __attribute__((regparm(3)))
+#define IRQHANDLER(x)	x __attribute__((regparm(1)))
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
diff -urpN -X /home/fletch/.diff.exclude 220-thread_info_cleanup/include/asm-i386/thread_info.h 221-interrupt_stacks/include/asm-i386/thread_info.h
--- 220-thread_info_cleanup/include/asm-i386/thread_info.h	Mon Feb 17 10:57:56 2003
+++ 221-interrupt_stacks/include/asm-i386/thread_info.h	Mon Feb 17 10:57:57 2003
@@ -30,9 +30,11 @@ struct thread_info {
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
+						   0 for interrupts: illegal
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct thread_info	*irq_stack;	/* pointer to cpu irq stack */
 	struct restart_block    restart_block;
 
 	__u8			supervisor_stack[0];
@@ -47,7 +49,8 @@ struct thread_info {
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
-#define TI_RESTART_BLOCK 0x0000018
+#define TI_IRQ_STACK	0x00000018
+#define TI_RESTART_BLOCK 0x0000022
 
 #endif
 
@@ -63,17 +66,18 @@ struct thread_info {
 
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

--==========463958336==========
Content-Type: text/plain; charset=us-ascii; name=222-stack_usage_check
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=222-stack_usage_check; size=6600

diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/Kconfig 222-stack_usage_check/arch/i386/Kconfig
--- 221-interrupt_stacks/arch/i386/Kconfig	Mon Feb 17 10:57:57 2003
+++ 222-stack_usage_check/arch/i386/Kconfig	Mon Feb 17 10:57:57 2003
@@ -1764,6 +1764,25 @@ config FRAME_POINTER
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+config X86_STACK_CHECK
+	bool "Detect stack overflows"
+	depends on FRAME_POINTER
+	help
+	  Say Y here to have the kernel attempt to detect when the per-task
+	  kernel stack overflows.  This is much more robust checking than
+	  the above overflow check, which will only occasionally detect
+	  an overflow.  The level of guarantee here is much greater.
+	
+	  Some older versions of gcc don't handle the -p option correctly.  
+	  Kernprof is affected by the same problem, which is described here:
+	  http://oss.sgi.com/projects/kernprof/faq.html#Q9
+	
+	  Basically, if you get oopses in __free_pages_ok during boot when
+	  you have this turned on, you need to fix gcc.  The Redhat 2.96 
+	  version and gcc-3.x seem to work.  
+	
+	  If not debugging a stack overflow problem, say N
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/Makefile 222-stack_usage_check/arch/i386/Makefile
--- 221-interrupt_stacks/arch/i386/Makefile	Sun Feb 16 13:18:58 2003
+++ 222-stack_usage_check/arch/i386/Makefile	Mon Feb 17 10:57:57 2003
@@ -76,6 +76,10 @@ mcore-$(CONFIG_X86_SUMMIT)  := mach-defa
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/boot/compressed/misc.c 222-stack_usage_check/arch/i386/boot/compressed/misc.c
--- 221-interrupt_stacks/arch/i386/boot/compressed/misc.c	Thu Jan  2 22:04:58 2003
+++ 222-stack_usage_check/arch/i386/boot/compressed/misc.c	Mon Feb 17 10:57:57 2003
@@ -377,3 +377,7 @@ asmlinkage int decompress_kernel(struct 
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/kernel/entry.S 222-stack_usage_check/arch/i386/kernel/entry.S
--- 221-interrupt_stacks/arch/i386/kernel/entry.S	Mon Feb 17 10:57:57 2003
+++ 222-stack_usage_check/arch/i386/kernel/entry.S	Mon Feb 17 10:57:57 2003
@@ -640,6 +640,61 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+
+#ifdef CONFIG_X86_STACK_CHECK
+.data
+	.globl	stack_overflowed
+stack_overflowed:
+	.long	0
+.text
+
+ENTRY(mcount)
+	push %eax
+	movl $(THREAD_SIZE - 1),%eax
+	andl %esp,%eax
+	cmpl $STACK_WARN,%eax	/* more than half the stack is used*/
+	jle 1f
+2:
+	popl %eax
+	ret
+1:	
+	lock;   btsl    $0,stack_overflowed
+	jc      2b
+	
+	# switch to overflow stack
+	movl	%esp,%eax
+	movl	$(stack_overflow_stack + THREAD_SIZE - 4),%esp
+
+	pushf
+	cli
+	pushl	%eax
+
+	# push eip then esp of error for stack_overflow_panic
+	pushl	4(%eax)
+	pushl	%eax
+
+	# update the task pointer and cpu in the overflow stack's thread_info.
+	GET_THREAD_INFO_WITH_ESP(%eax)
+	movl	TI_TASK(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_TASK
+	movl	TI_CPU(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_CPU
+
+	call	stack_overflow
+
+	# pop off call arguments
+	addl	$8,%esp 
+
+	popl	%eax
+	popf
+	movl	%eax,%esp
+	popl	%eax
+	movl	$0,stack_overflowed
+	ret
+
+#warning stack check enabled
+#endif
+
 .data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/kernel/i386_ksyms.c 222-stack_usage_check/arch/i386/kernel/i386_ksyms.c
--- 221-interrupt_stacks/arch/i386/kernel/i386_ksyms.c	Sun Feb 16 15:10:06 2003
+++ 222-stack_usage_check/arch/i386/kernel/i386_ksyms.c	Mon Feb 17 10:57:57 2003
@@ -228,3 +228,8 @@ EXPORT_SYMBOL(kmap_atomic_to_page);
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
 #endif
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/kernel/init_task.c 222-stack_usage_check/arch/i386/kernel/init_task.c
--- 221-interrupt_stacks/arch/i386/kernel/init_task.c	Mon Feb 17 10:57:57 2003
+++ 222-stack_usage_check/arch/i386/kernel/init_task.c	Mon Feb 17 10:57:57 2003
@@ -17,6 +17,10 @@ struct mm_struct init_mm = INIT_MM(init_
 union thread_union init_irq_union
 	__attribute__((__section__(".data.init_task")));
 
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
 
 /*
  * Initial thread structure.
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/arch/i386/kernel/process.c 222-stack_usage_check/arch/i386/kernel/process.c
--- 221-interrupt_stacks/arch/i386/kernel/process.c	Mon Feb 17 10:57:57 2003
+++ 222-stack_usage_check/arch/i386/kernel/process.c	Mon Feb 17 10:57:57 2003
@@ -159,7 +159,25 @@ static int __init idle_setup (char *str)
 
 __setup("idle=", idle_setup);
 
-void show_regs(struct pt_regs * regs)
+void stack_overflow(unsigned long esp, unsigned long eip)
+{
+	int panicing = ((esp&(THREAD_SIZE-1)) <= STACK_PANIC);
+
+	printk( "esp: 0x%lx masked: 0x%lx STACK_PANIC:0x%x %d %d\n", 
+		esp, (esp&(THREAD_SIZE-1)), STACK_PANIC, (((esp&(THREAD_SIZE-1)) <= STACK_PANIC)), panicing );
+	
+	if (panicing)
+		print_symbol("stack overflow from %s\n", eip);
+	else
+		print_symbol("excessive stack use from %s\n", eip);
+	printk("esp: %p\n", (void*)esp);
+	show_trace((void*)esp);
+	
+	if (panicing)
+		panic("stack overflow\n");
+}
+
+asmlinkage void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 
diff -urpN -X /home/fletch/.diff.exclude 221-interrupt_stacks/include/asm-i386/thread_info.h 222-stack_usage_check/include/asm-i386/thread_info.h
--- 221-interrupt_stacks/include/asm-i386/thread_info.h	Mon Feb 17 10:57:57 2003
+++ 222-stack_usage_check/include/asm-i386/thread_info.h	Mon Feb 17 10:57:57 2003
@@ -63,6 +63,8 @@ struct thread_info {
  */
 #define THREAD_ORDER 1 
 #define INIT_THREAD_SIZE       THREAD_SIZE
+#define STACK_PANIC		0x200ul
+#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 

--==========463958336==========
Content-Type: text/plain; charset=us-ascii; name=223-4k_stacks
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=223-4k_stacks; size=1664

diff -urpN -X /home/fletch/.diff.exclude 222-stack_usage_check/arch/i386/Kconfig 223-4k_stacks/arch/i386/Kconfig
--- 222-stack_usage_check/arch/i386/Kconfig	Mon Feb 17 10:57:57 2003
+++ 223-4k_stacks/arch/i386/Kconfig	Mon Feb 17 10:57:58 2003
@@ -742,6 +742,16 @@ config SHAREPTE
 	  level of the page table between address spaces that are sharing data
 	  pages.
 
+config 4K_STACK
+	bool "Use smaller 4k per-task stacks"
+	help
+	  This option will shrink the kernel's per-task stack from 8k to
+	  4k.  This will greatly increase your chance of overflowing it.
+	  But, if you use the per-cpu interrupt stacks as well, your chances
+	  go way down.  Also try the CONFIG_X86_STACK_CHECK overflow
+	  detection.  It is much more reliable than the currently in-kernel
+	  version.
+
 config MATH_EMULATION
 	bool "Math emulation"
 	---help---
diff -urpN -X /home/fletch/.diff.exclude 222-stack_usage_check/include/asm-i386/thread_info.h 223-4k_stacks/include/asm-i386/thread_info.h
--- 222-stack_usage_check/include/asm-i386/thread_info.h	Mon Feb 17 10:57:57 2003
+++ 223-4k_stacks/include/asm-i386/thread_info.h	Mon Feb 17 10:57:58 2003
@@ -61,10 +61,16 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#define THREAD_ORDER 1 
+#ifdef CONFIG_4K_STACK
+#define THREAD_ORDER 0
+#define STACK_WARN		0x200
+#define STACK_PANIC		0x100
+#else
+#define THREAD_ORDER 1
+#define STACK_WARN              ((THREAD_SIZE)>>1)
+#define STACK_PANIC             0x100
+#endif
 #define INIT_THREAD_SIZE       THREAD_SIZE
-#define STACK_PANIC		0x200ul
-#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 

--==========463958336==========--

