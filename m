Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbSJBVPh>; Wed, 2 Oct 2002 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJBVO4>; Wed, 2 Oct 2002 17:14:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44962 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262598AbSJBVNo>; Wed, 2 Oct 2002 17:13:44 -0400
Message-ID: <3D9B62AC.30607@us.ibm.com>
Date: Wed, 02 Oct 2002 14:18:36 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-mm@kvack.org
Subject: [RFC][PATCH]  4KB stack + irq stack for x86
Content-Type: multipart/mixed;
 boundary="------------090501030701050105060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501030701050105060509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've resynced Ben's patch against 2.5.40.  However, I'm getting some 
strange failures.  The patch is good enough to pass LTP, but 
consistently freezes when I run tcpdump on it.

Although I don't have CONFIG_PREEMPT on, I have the feeling that I 
need to disable preemption in common_interrupt() like it was before. 
   Any insights would be appreciated.

part of Ben LaHaise's original message:
 > Below is a patch against 2.5.20 that implements 4KB stacks for
 > tasks, plus a seperate 4KB irq stack for use by interrupts.  There
 > are a couple of reasons for doing this: 4KB stacks put less pressure
 > on the VM subsystem, reduces the overall memory usage for systems
 > with large numbers of tasks, and increases the reliability of the
 > system when under heavy irq load by provide a fixed stack size for
 > interrupt handlers that other kernel code will not eat into.
 >
 > The interrupt stacks are stackable, so we could use multiple
 > 4KB irq stacks.  The thread_info structure is included in each
 > interrupt stack, and has the current pointer copied into it upon
 > entry.

-- 
Dave Hansen
haveblue@us.ibm.com


--------------090501030701050105060509
Content-Type: text/plain;
 name="4k+interrupt-stack-2.5.40-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4k+interrupt-stack-2.5.40-1.patch"

diff -ur linux-2.5.40-clean/arch/i386/config.in linux-2.5.40/arch/i386/config.in
--- linux-2.5.40-clean/arch/i386/config.in	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/config.in	2002-10-02 12:59:55.000000000 -0700
@@ -35,6 +35,7 @@
 #
 # Define implied options from the CPU selection here
 #
+define_bool CONFIG_X86_HAVE_CMOV n
 
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
@@ -91,18 +92,21 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_HAVE_CMOV y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_HAVE_CMOV y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_HAVE_CMOV y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -116,6 +120,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_HAVE_CMOV y
 fi
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
@@ -132,6 +137,7 @@
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAVE_CMOV y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -ur linux-2.5.40-clean/arch/i386/kernel/entry.S linux-2.5.40/arch/i386/kernel/entry.S
--- linux-2.5.40-clean/arch/i386/kernel/entry.S	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/entry.S	2002-10-02 13:00:09.000000000 -0700
@@ -136,7 +136,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp, %ebx
 	pushl %ebx
-	andl $-8192, %ebx	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebx)
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
 	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -158,7 +158,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp, %ebx
 	pushl %ebx
-	andl $-8192, %ebx	# GET_THREAD_INFO
+	GET_THREAD_INFO_WITH_ESP(%ebx)
 	movl TI_EXEC_DOMAIN(%ebx), %edx	# Get the execution domain
 	movl 4(%edx), %edx	# Get the lcall7 handler for the domain
 	pushl $0x27
@@ -334,7 +334,30 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+
+	movl TI_IRQ_STACK(%ebx),%ecx
+	movl TI_TASK(%ebx),%edx
+	movl %esp,%eax
+	leal (THREAD_SIZE-4)(%ecx),%ebx
+	testl %ecx,%ecx			# is there a valid irq_stack?
+	# switch to the irq stack
+#ifdef CONFIG_X86_HAVE_CMOV
+	cmovnz %ebx,%esp
+#warning using cmov
+#else
+#warning cannot use cmov
+	jnz 1f
+	mov %ebx,%esp
+1:
+#endif
+
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%ebx)
+	movl %edx,TI_TASK(%ebx)
+
 	call do_IRQ
+	movl %eax,%esp			# potentially restore non-irq stack
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
diff -ur linux-2.5.40-clean/arch/i386/kernel/head.S linux-2.5.40/arch/i386/kernel/head.S
--- linux-2.5.40-clean/arch/i386/kernel/head.S	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/head.S	2002-10-02 12:59:55.000000000 -0700
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
+#include <asm/thread_info.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -305,7 +306,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long init_thread_union+8192
+	.long init_thread_union+THREAD_SIZE
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
diff -ur linux-2.5.40-clean/arch/i386/kernel/init_task.c linux-2.5.40/arch/i386/kernel/init_task.c
--- linux-2.5.40-clean/arch/i386/kernel/init_task.c	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/init_task.c	2002-10-02 12:59:55.000000000 -0700
@@ -13,6 +13,9 @@
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
+union thread_union init_irq_union
+	__attribute__((__section__(".data.init_task")));
+
 /*
  * Initial thread structure.
  *
@@ -22,7 +25,15 @@
  */
 union thread_union init_thread_union 
 	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
+		{ { 
+			task:		&init_task,
+			exec_domain:	&default_exec_domain,
+			flags:		0,
+			cpu:		0,
+			addr_limit:	KERNEL_DS,
+			irq_stack:	&init_irq_union,
+		} };
+
 
 /*
  * Initial task structure.
diff -ur linux-2.5.40-clean/arch/i386/kernel/irq.c linux-2.5.40/arch/i386/kernel/irq.c
--- linux-2.5.40-clean/arch/i386/kernel/irq.c	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/irq.c	2002-10-02 12:59:55.000000000 -0700
@@ -311,7 +311,8 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+struct pt_regs *do_IRQ(struct pt_regs *regs) __attribute__((regparm(1)));
+struct pt_regs *do_IRQ(struct pt_regs *regs)
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
@@ -373,7 +374,7 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -392,7 +393,7 @@
 
 	irq_exit();
 
-	return 1;
+	return regs;
 }
 
 /**
diff -ur linux-2.5.40-clean/arch/i386/kernel/process.c linux-2.5.40/arch/i386/kernel/process.c
--- linux-2.5.40-clean/arch/i386/kernel/process.c	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/process.c	2002-10-02 12:59:55.000000000 -0700
@@ -413,6 +413,7 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
diff -ur linux-2.5.40-clean/arch/i386/kernel/smpboot.c linux-2.5.40/arch/i386/kernel/smpboot.c
--- linux-2.5.40-clean/arch/i386/kernel/smpboot.c	2002-10-02 12:59:09.000000000 -0700
+++ linux-2.5.40/arch/i386/kernel/smpboot.c	2002-10-02 12:59:55.000000000 -0700
@@ -69,6 +69,10 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
@@ -763,6 +767,27 @@
 	return (send_status | accept_status);
 }
 
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
+	p->thread_info->irq_stack = irq_stacks[cpu];
+
+	/* If we want to make the irq stack more than one unit
+	 * deep, we can chain then off of the irq_stack pointer
+	 * here.
+	 */
+}
+
 extern unsigned long cpu_initialized;
 
 static void __init do_boot_cpu (int apicid) 
@@ -786,6 +811,8 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
+	setup_irq_stack(idle, cpu);
+
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
@@ -803,7 +830,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+	stack_start.esp = (void *) (THREAD_SIZE + (char *)idle->thread_info);
 
 	/*
 	 * This grunge runs the startup process for
diff -ur linux-2.5.40-clean/include/asm-i386/page.h linux-2.5.40/include/asm-i386/page.h
--- linux-2.5.40-clean/include/asm-i386/page.h	2002-10-02 12:59:03.000000000 -0700
+++ linux-2.5.40/include/asm-i386/page.h	2002-10-02 12:59:55.000000000 -0700
@@ -3,7 +3,11 @@
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
+#ifndef __ASSEMBLY__
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE	(1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
diff -ur linux-2.5.40-clean/include/asm-i386/thread_info.h linux-2.5.40/include/asm-i386/thread_info.h
--- linux-2.5.40-clean/include/asm-i386/thread_info.h	2002-10-02 12:59:03.000000000 -0700
+++ linux-2.5.40/include/asm-i386/thread_info.h	2002-10-02 12:59:55.000000000 -0700
@@ -9,6 +9,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page.h>
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
@@ -28,9 +29,11 @@
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
+						   0 for interrupts: illegal
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct thread_info	*irq_stack;	/* pointer to cpu irq stack */
 
 	__u8			supervisor_stack[0];
 };
@@ -44,6 +47,7 @@
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
+#define TI_IRQ_STACK	0x00000018
 
 #endif
 
@@ -54,42 +58,40 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
+#define THREAD_ORDER	0
+ 
 #ifndef __ASSEMBLY__
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.task		= &tsk,			\
-	.exec_domain	= &default_exec_domain,	\
-	.flags		= 0,			\
-	.cpu		= 0,			\
-	.preempt_count	= 1,			\
-	.addr_limit	= KERNEL_DS,		\
-}
-
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
+ 	movl $-THREAD_SIZE, reg; \
 	andl %esp, reg
 
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
+
 #endif
 
 /*

--------------090501030701050105060509--

