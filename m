Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbSJDT4U>; Fri, 4 Oct 2002 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSJDT4T>; Fri, 4 Oct 2002 15:56:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60563 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261928AbSJDTzp>; Fri, 4 Oct 2002 15:55:45 -0400
Message-ID: <3D9DF34D.2030405@us.ibm.com>
Date: Fri, 04 Oct 2002 13:00:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: [PATCH]  4KB stack + irq stack for x86
Content-Type: multipart/mixed;
 boundary="------------060402050003090705050105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060402050003090705050105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I fixed the problems that I was having.  thread_info->preempt_count is 
now used to store softirq state, unlike in 2.5.20.  Preempt count was 
not preserved once the switch to the interrupt stack occurred.  This 
caused two nested softirqs and a deadlock.  It is fixed now.

Any comments?  Is this right for -mm, or should I try to push right to 
Linus?

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



--------------060402050003090705050105
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


--------------060402050003090705050105
Content-Type: text/plain;
 name="interrupt_stack-2.5.40-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupt_stack-2.5.40-0.patch"

Only in linux-2.5.40-irqstack/: ..tmp_vmlinux.cmd
Only in linux-2.5.40: .Makefile.swp
Only in linux-2.5.40-irqstack/: .config
Only in linux-2.5.40-irqstack/: .config.old
Only in linux-2.5.40-irqstack/: .hdepend
Only in linux-2.5.40-irqstack/: .tmp_export-objs
Only in linux-2.5.40-irqstack/: .tmp_kallsyms.o
Only in linux-2.5.40-irqstack/: .tmp_vmlinux
Only in linux-2.5.40-irqstack/: .version
Only in linux-2.5.40-irqstack/: .vmlinux.cmd
Only in linux-2.5.40-irqstack/: System.map
Only in linux-2.5.40-irqstack/arch/i386: .vmlinux.lds.s.cmd
diff -ur linux-2.5.40/arch/i386/Makefile linux-2.5.40-irqstack/arch/i386/Makefile
--- linux-2.5.40/arch/i386/Makefile	2002-10-01 00:06:29.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/Makefile	2002-10-02 15:44:07.000000000 -0700
@@ -91,6 +91,10 @@
 MACHINE	:= mach-generic
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
Only in linux-2.5.40-irqstack/arch/i386: Makefile.orig
Only in linux-2.5.40-irqstack/arch/i386/boot: .bootsect.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: .bootsect.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: .bzImage.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: .setup.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: .setup.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: .vmlinux.bin.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot: bootsect
Only in linux-2.5.40-irqstack/arch/i386/boot: bootsect.o
Only in linux-2.5.40-irqstack/arch/i386/boot: bzImage
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .head.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .misc.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .piggy.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .vmlinux.bin.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .vmlinux.bin.gz.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: .vmlinux.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: head.o
diff -ur linux-2.5.40/arch/i386/boot/compressed/misc.c linux-2.5.40-irqstack/arch/i386/boot/compressed/misc.c
--- linux-2.5.40/arch/i386/boot/compressed/misc.c	2002-10-01 00:07:05.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/boot/compressed/misc.c	2002-10-02 15:44:07.000000000 -0700
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: misc.c.orig
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: misc.o
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: piggy.o
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: vmlinux
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: vmlinux.bin
Only in linux-2.5.40-irqstack/arch/i386/boot/compressed: vmlinux.bin.gz
Only in linux-2.5.40-irqstack/arch/i386/boot: setup
Only in linux-2.5.40-irqstack/arch/i386/boot: setup.o
Only in linux-2.5.40-irqstack/arch/i386/boot/tools: .build.cmd
Only in linux-2.5.40-irqstack/arch/i386/boot/tools: build
Only in linux-2.5.40-irqstack/arch/i386/boot: vmlinux.bin
diff -ur linux-2.5.40/arch/i386/config.in linux-2.5.40-irqstack/arch/i386/config.in
--- linux-2.5.40/arch/i386/config.in	2002-10-01 00:06:28.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/config.in	2002-10-04 12:32:25.000000000 -0700
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
@@ -453,6 +459,7 @@
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
    bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
+   bool '  Check for stack overflows' CONFIG_X86_STACK_CHECK
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
Only in linux-2.5.40-irqstack/arch/i386: config.in.orig
Only in linux-2.5.40-irqstack/arch/i386: config.in.rej
Only in linux-2.5.40-irqstack/arch/i386/kernel: .apic.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .bluesmoke.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .bootflag.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .cpuid.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .dmi_scan.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .entry.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .head.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .i386_ksyms.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .i387.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .i8259.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .init_task.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .io_apic.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .ioport.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .irq.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .ldt.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .mpparse.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .msr.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .nmi.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .pci-dma.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .process.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .ptrace.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .reboot.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .semaphore.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .setup.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .signal.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .smp.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .smpboot.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .sys_i386.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .time.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .trampoline.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .traps.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: .vm86.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel: apic.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: bluesmoke.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: bootflag.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .amd.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .centaur.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .common.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .cyrix.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .intel.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .nexgen.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .proc.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .rise.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .transmeta.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: .umc.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: amd.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: centaur.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: common.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: cyrix.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: intel.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .amd.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .centaur.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .cyrix.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .generic.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .if.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .main.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: .state.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: amd.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: centaur.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: cyrix.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: generic.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: if.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: main.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu/mtrr: state.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: nexgen.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: proc.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: rise.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: transmeta.o
Only in linux-2.5.40-irqstack/arch/i386/kernel/cpu: umc.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: cpuid.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: dmi_scan.o
diff -ur linux-2.5.40/arch/i386/kernel/entry.S linux-2.5.40-irqstack/arch/i386/kernel/entry.S
--- linux-2.5.40/arch/i386/kernel/entry.S	2002-10-01 00:06:26.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/entry.S	2002-10-04 12:32:57.000000000 -0700
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
@@ -334,7 +334,35 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	GET_THREAD_INFO(%ebx)
+
+	movl TI_IRQ_STACK(%ebx),%ecx
+	movl TI_TASK(%ebx),%edx
+	movl %esp,%eax
+	leal (THREAD_SIZE-4)(%ecx),%esi # %ecx+THREAD_SIZE is next stack
+	                                # -4 keeps us in the right one
+	testl %ecx,%ecx                 # is there a valid irq_stack?
+	# switch to the irq stack
+	cmovnz %esi,%esp
+
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%esi)
+	movl %edx,TI_TASK(%esi)
+	# preempt_count must be transferred, otherwise we get deadlocking
+	# softirqs and other madness
+	movl TI_PRE_COUNT(%ebx),%ecx
+	movl %ecx,TI_PRE_COUNT(%esi)
+
 	call do_IRQ
+	movl %eax,%esp                  # potentially restore non-irq stack
+	
+	# copy flags from the irq stack back into the task's thread_info
+	# %esi is saved over the do_IRQ call and contains the irq stack
+	# thread_info pointer
+	# %ebx contains the original thread_info pointer
+	movl TI_FLAGS(%esi),%eax
+	movl $0,TI_FLAGS(%esi)
+	LOCK orl %eax,TI_FLAGS(%ebx)
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
@@ -481,6 +509,62 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+#ifdef CONFIG_X86_STACK_CHECK
+.data
+	.globl	stack_overflowed
+stack_overflowed:
+	.long	0
+
+.text
+
+ENTRY(mcount)
+	push %eax
+	movl $(THREAD_SIZE - 1),%eax
+	andl %esp,%eax
+	cmpl $0x400,%eax        /* 512 byte danger zone */
+	jle 1f
+2:
+	popl %eax
+	ret
+1:
+	int $3	 
+	lock; btsl $0,stack_overflowed	/* Prevent reentry via printk */
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
+	# never neverland
+	call	stack_overflow_panic
+
+	addl	$8,%esp
+
+	popf
+	popl	%eax
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
 	.long sys_ni_syscall	/* 0 - old "setup()" system call*/
Only in linux-2.5.40-irqstack/arch/i386/kernel: entry.S.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: entry.S.rej
Only in linux-2.5.40-irqstack/arch/i386/kernel: entry.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: gdbstub.c
Only in linux-2.5.40-irqstack/arch/i386/kernel: gdbstub.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: gdbstub.c.rej
diff -ur linux-2.5.40/arch/i386/kernel/head.S linux-2.5.40-irqstack/arch/i386/kernel/head.S
--- linux-2.5.40/arch/i386/kernel/head.S	2002-10-01 00:06:17.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/head.S	2002-10-02 15:44:07.000000000 -0700
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
Only in linux-2.5.40-irqstack/arch/i386/kernel: head.S.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: head.S.rej
Only in linux-2.5.40-irqstack/arch/i386/kernel: head.o
diff -ur linux-2.5.40/arch/i386/kernel/i386_ksyms.c linux-2.5.40-irqstack/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	2002-10-01 00:06:59.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/i386_ksyms.c	2002-10-04 12:29:45.000000000 -0700
@@ -179,3 +179,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
Only in linux-2.5.40-irqstack/arch/i386/kernel: i386_ksyms.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: i386_ksyms.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: i387.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: i8259.o
diff -ur linux-2.5.40/arch/i386/kernel/init_task.c linux-2.5.40-irqstack/arch/i386/kernel/init_task.c
--- linux-2.5.40/arch/i386/kernel/init_task.c	2002-10-01 00:07:43.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/init_task.c	2002-10-02 15:44:07.000000000 -0700
@@ -13,6 +13,14 @@
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
+union thread_union init_irq_union
+	__attribute__((__section__(".data.init_task")));
+
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
+
 /*
  * Initial thread structure.
  *
@@ -22,7 +30,15 @@
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
Only in linux-2.5.40-irqstack/arch/i386/kernel: init_task.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: init_task.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: io_apic.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: ioport.o
diff -ur linux-2.5.40/arch/i386/kernel/irq.c linux-2.5.40-irqstack/arch/i386/kernel/irq.c
--- linux-2.5.40/arch/i386/kernel/irq.c	2002-10-01 00:06:16.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/irq.c	2002-10-02 15:56:42.000000000 -0700
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
Only in linux-2.5.40-irqstack/arch/i386/kernel: irq.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: irq.c.rej
Only in linux-2.5.40-irqstack/arch/i386/kernel: irq.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: ldt.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: mpparse.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: msr.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: nmi.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: pci-dma.o
diff -ur linux-2.5.40/arch/i386/kernel/process.c linux-2.5.40-irqstack/arch/i386/kernel/process.c
--- linux-2.5.40/arch/i386/kernel/process.c	2002-10-01 00:05:46.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/process.c	2002-10-03 19:47:28.000000000 -0700
@@ -156,7 +156,17 @@
 
 __setup("idle=", idle_setup);
 
-void show_regs(struct pt_regs * regs)
+#ifdef CONFIG_X86_STACK_CHECK
+void stack_overflow_panic(void *esp, void *eip)
+{
+	printk("stack overflow from %p.  esp: %p\n", eip, esp);
+	show_trace(esp);
+	panic("stack overflow\n");
+}
+
+#endif
+
+asmlinkage void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 
@@ -413,6 +423,7 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
Only in linux-2.5.40-irqstack/arch/i386/kernel: process.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: process.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: ptrace.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: reboot.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: semaphore.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: setup.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: signal.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: smp.o
diff -ur linux-2.5.40/arch/i386/kernel/smpboot.c linux-2.5.40-irqstack/arch/i386/kernel/smpboot.c
--- linux-2.5.40/arch/i386/kernel/smpboot.c	2002-10-01 00:06:59.000000000 -0700
+++ linux-2.5.40-irqstack/arch/i386/kernel/smpboot.c	2002-10-04 08:56:05.000000000 -0700
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
@@ -803,7 +830,13 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+
+	/* The -4 is to correct for the fact that the stack pointer
+	 * is used to find the location of the thread_info structure
+	 * by masking off several of the LSBs.  Without the -4, esp
+	 * is pointing to the page after the one the stack is on.
+	 */
+	stack_start.esp = (void *)(THREAD_SIZE - 4 + (char *)idle->thread_info);
 
 	/*
 	 * This grunge runs the startup process for
Only in linux-2.5.40-irqstack/arch/i386/kernel: smpboot.c.orig
Only in linux-2.5.40-irqstack/arch/i386/kernel: smpboot.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: sys_i386.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: time.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: trampoline.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: traps.o
Only in linux-2.5.40-irqstack/arch/i386/kernel: vm86.o
Only in linux-2.5.40-irqstack/arch/i386/lib: .checksum.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .dec_and_lock.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .delay.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .getuser.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .lib.a.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .memcpy.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .old-checksum.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .strstr.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: .usercopy.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/lib: checksum.o
Only in linux-2.5.40-irqstack/arch/i386/lib: dec_and_lock.o
Only in linux-2.5.40-irqstack/arch/i386/lib: delay.o
Only in linux-2.5.40-irqstack/arch/i386/lib: getuser.o
Only in linux-2.5.40-irqstack/arch/i386/lib: lib.a
Only in linux-2.5.40-irqstack/arch/i386/lib: memcpy.o
Only in linux-2.5.40-irqstack/arch/i386/lib: old-checksum.o
Only in linux-2.5.40-irqstack/arch/i386/lib: strstr.o
Only in linux-2.5.40-irqstack/arch/i386/lib: usercopy.o
Only in linux-2.5.40-irqstack/arch/i386/mach-generic: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mach-generic: .setup.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mach-generic: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/mach-generic: setup.o
Only in linux-2.5.40-irqstack/arch/i386/mm: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .extable.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .fault.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .init.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .ioremap.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .pageattr.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: .pgtable.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/mm: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/mm: extable.o
Only in linux-2.5.40-irqstack/arch/i386/mm: fault.o
Only in linux-2.5.40-irqstack/arch/i386/mm: init.o
Only in linux-2.5.40-irqstack/arch/i386/mm: ioremap.o
Only in linux-2.5.40-irqstack/arch/i386/mm: pageattr.o
Only in linux-2.5.40-irqstack/arch/i386/mm: pgtable.o
Only in linux-2.5.40-irqstack/arch/i386/pci: .built-in.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .common.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .direct.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .fixup.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .i386.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .irq.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .legacy.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: .pcbios.o.cmd
Only in linux-2.5.40-irqstack/arch/i386/pci: built-in.o
Only in linux-2.5.40-irqstack/arch/i386/pci: common.o
Only in linux-2.5.40-irqstack/arch/i386/pci: direct.o
Only in linux-2.5.40-irqstack/arch/i386/pci: fixup.o
Only in linux-2.5.40-irqstack/arch/i386/pci: i386.o
Only in linux-2.5.40-irqstack/arch/i386/pci: irq.o
Only in linux-2.5.40-irqstack/arch/i386/pci: legacy.o
Only in linux-2.5.40-irqstack/arch/i386/pci: pcbios.o
Only in linux-2.5.40-irqstack/arch/i386: vmlinux.lds.s
Only in linux-2.5.40-irqstack/drivers: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .bus.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .class.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .core.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .cpu.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .driver.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .interface.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .intf.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .platform.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .power.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: .sys.o.cmd
Only in linux-2.5.40-irqstack/drivers/base: built-in.o
Only in linux-2.5.40-irqstack/drivers/base: bus.o
Only in linux-2.5.40-irqstack/drivers/base: class.o
Only in linux-2.5.40-irqstack/drivers/base: core.o
Only in linux-2.5.40-irqstack/drivers/base: cpu.o
Only in linux-2.5.40-irqstack/drivers/base: driver.o
Only in linux-2.5.40-irqstack/drivers/base/fs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: .bus.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: .class.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: .device.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: .driver.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: .intf.o.cmd
Only in linux-2.5.40-irqstack/drivers/base/fs: built-in.o
Only in linux-2.5.40-irqstack/drivers/base/fs: bus.o
Only in linux-2.5.40-irqstack/drivers/base/fs: class.o
Only in linux-2.5.40-irqstack/drivers/base/fs: device.o
Only in linux-2.5.40-irqstack/drivers/base/fs: driver.o
Only in linux-2.5.40-irqstack/drivers/base/fs: intf.o
Only in linux-2.5.40-irqstack/drivers/base: interface.o
Only in linux-2.5.40-irqstack/drivers/base: intf.o
Only in linux-2.5.40-irqstack/drivers/base: platform.o
Only in linux-2.5.40-irqstack/drivers/base: power.o
Only in linux-2.5.40-irqstack/drivers/base: sys.o
Only in linux-2.5.40-irqstack/drivers/block: .blkpg.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .block_ioctl.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .deadline-iosched.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .elevator.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .floppy.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .genhd.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .ll_rw_blk.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: .loop.o.cmd
Only in linux-2.5.40-irqstack/drivers/block: blkpg.o
Only in linux-2.5.40-irqstack/drivers/block: block_ioctl.o
Only in linux-2.5.40-irqstack/drivers/block: built-in.o
Only in linux-2.5.40-irqstack/drivers/block: deadline-iosched.o
Only in linux-2.5.40-irqstack/drivers/block: elevator.o
Only in linux-2.5.40-irqstack/drivers/block: floppy.o
Only in linux-2.5.40-irqstack/drivers/block: genhd.o
Only in linux-2.5.40-irqstack/drivers/block: ll_rw_blk.o
Only in linux-2.5.40-irqstack/drivers/block: loop.o
Only in linux-2.5.40-irqstack/drivers: built-in.o
Only in linux-2.5.40-irqstack/drivers/cdrom: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/cdrom: .cdrom.o.cmd
Only in linux-2.5.40-irqstack/drivers/cdrom: built-in.o
Only in linux-2.5.40-irqstack/drivers/cdrom: cdrom.o
Only in linux-2.5.40-irqstack/drivers/char: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .consolemap.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .consolemap_deftbl.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .defkeymap.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .i810_rng.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .keyboard.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .mem.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .misc.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .n_tty.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .pty.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .random.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .selection.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .sysrq.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .tty_io.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .tty_ioctl.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .vc_screen.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .vt.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: .vt_ioctl.o.cmd
Only in linux-2.5.40-irqstack/drivers/char: built-in.o
Only in linux-2.5.40-irqstack/drivers/char: consolemap.o
Only in linux-2.5.40-irqstack/drivers/char: consolemap_deftbl.c
Only in linux-2.5.40-irqstack/drivers/char: consolemap_deftbl.o
Only in linux-2.5.40-irqstack/drivers/char: defkeymap.c
Only in linux-2.5.40-irqstack/drivers/char: defkeymap.o
Only in linux-2.5.40-irqstack/drivers/char: gdbserial.c
Only in linux-2.5.40-irqstack/drivers/char: gdbserial.c.orig
Only in linux-2.5.40-irqstack/drivers/char: gdbserial.c.rej
Only in linux-2.5.40-irqstack/drivers/char: i810_rng.o
Only in linux-2.5.40-irqstack/drivers/char: keyboard.o
Only in linux-2.5.40-irqstack/drivers/char: mem.o
Only in linux-2.5.40-irqstack/drivers/char: misc.o
Only in linux-2.5.40-irqstack/drivers/char: n_tty.o
Only in linux-2.5.40-irqstack/drivers/char: pty.o
Only in linux-2.5.40-irqstack/drivers/char: random.o
Only in linux-2.5.40-irqstack/drivers/char: selection.o
Only in linux-2.5.40-irqstack/drivers/char: sysrq.o
Only in linux-2.5.40-irqstack/drivers/char: tty_io.o
Only in linux-2.5.40-irqstack/drivers/char: tty_ioctl.o
Only in linux-2.5.40-irqstack/drivers/char: vc_screen.o
Only in linux-2.5.40-irqstack/drivers/char: vt.o
Only in linux-2.5.40-irqstack/drivers/char: vt_ioctl.o
Only in linux-2.5.40-irqstack/drivers/ide: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-cd.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-disk.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-dma.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-geometry.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-iops.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-lib.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-probe.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-proc.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide-taskfile.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .ide.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide: .setup-pci.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/arm: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/arm: built-in.o
Only in linux-2.5.40-irqstack/drivers/ide: built-in.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-cd.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-disk.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-dma.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-geometry.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-iops.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-lib.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-probe.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-proc.o
Only in linux-2.5.40-irqstack/drivers/ide: ide-taskfile.o
Only in linux-2.5.40-irqstack/drivers/ide: ide.o
Only in linux-2.5.40-irqstack/drivers/ide/legacy: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/legacy: built-in.o
Only in linux-2.5.40-irqstack/drivers/ide/pci: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/pci: .cmd640.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/pci: .piix.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/pci: built-in.o
Only in linux-2.5.40-irqstack/drivers/ide/pci: cmd640.o
Only in linux-2.5.40-irqstack/drivers/ide/pci: piix.o
Only in linux-2.5.40-irqstack/drivers/ide/ppc: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/ide/ppc: built-in.o
Only in linux-2.5.40-irqstack/drivers/ide: setup-pci.o
Only in linux-2.5.40-irqstack/drivers/input: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: .evbug.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: .evdev.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: .input.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: .joydev.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: .mousedev.o.cmd
Only in linux-2.5.40-irqstack/drivers/input: built-in.o
Only in linux-2.5.40-irqstack/drivers/input: evbug.o
Only in linux-2.5.40-irqstack/drivers/input: evdev.o
Only in linux-2.5.40-irqstack/drivers/input: input.o
Only in linux-2.5.40-irqstack/drivers/input: joydev.o
Only in linux-2.5.40-irqstack/drivers/input/keyboard: .atkbd.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/keyboard: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/keyboard: atkbd.o
Only in linux-2.5.40-irqstack/drivers/input/keyboard: built-in.o
Only in linux-2.5.40-irqstack/drivers/input/mouse: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/mouse: .psmouse.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/mouse: built-in.o
Only in linux-2.5.40-irqstack/drivers/input/mouse: psmouse.o
Only in linux-2.5.40-irqstack/drivers/input: mousedev.o
Only in linux-2.5.40-irqstack/drivers/input/serio: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/serio: .i8042.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/serio: .serio.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/serio: .serport.o.cmd
Only in linux-2.5.40-irqstack/drivers/input/serio: built-in.o
Only in linux-2.5.40-irqstack/drivers/input/serio: i8042.o
Only in linux-2.5.40-irqstack/drivers/input/serio: serio.o
Only in linux-2.5.40-irqstack/drivers/input/serio: serport.o
Only in linux-2.5.40-irqstack/drivers/media: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/media: built-in.o
Only in linux-2.5.40-irqstack/drivers/media/radio: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/media/radio: built-in.o
Only in linux-2.5.40-irqstack/drivers/media/video: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/media/video: built-in.o
Only in linux-2.5.40-irqstack/drivers/misc: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/misc: built-in.o
Only in linux-2.5.40-irqstack/drivers/net: .Space.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .dummy.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .eepro100.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .loopback.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .mii.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .net_init.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .pcnet32.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .setup.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: .starfire.o.cmd
Only in linux-2.5.40-irqstack/drivers/net: Space.o
Only in linux-2.5.40-irqstack/drivers/net: built-in.o
Only in linux-2.5.40-irqstack/drivers/net: dummy.o
Only in linux-2.5.40-irqstack/drivers/net: eepro100.o
Only in linux-2.5.40-irqstack/drivers/net: loopback.o
Only in linux-2.5.40-irqstack/drivers/net: mii.o
Only in linux-2.5.40-irqstack/drivers/net: net_init.o
Only in linux-2.5.40-irqstack/drivers/net: pcnet32.o
Only in linux-2.5.40-irqstack/drivers/net: setup.o
Only in linux-2.5.40-irqstack/drivers/net: starfire.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: .21142.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .eeprom.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .interrupt.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .media.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .pnic.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .pnic2.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .timer.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .tulip.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: .tulip_core.o.cmd
Only in linux-2.5.40-irqstack/drivers/net/tulip: 21142.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: built-in.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: eeprom.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: interrupt.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: media.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: pnic.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: pnic2.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: timer.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: tulip.o
Only in linux-2.5.40-irqstack/drivers/net/tulip: tulip_core.o
Only in linux-2.5.40-irqstack/drivers/pci: .access.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .compat.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .gen-devlist.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .hotplug.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .names.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .pci-driver.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .pci.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .pool.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .probe.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .proc.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .quirks.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .search.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: .setup-res.o.cmd
Only in linux-2.5.40-irqstack/drivers/pci: access.o
Only in linux-2.5.40-irqstack/drivers/pci: built-in.o
Only in linux-2.5.40-irqstack/drivers/pci: classlist.h
Only in linux-2.5.40-irqstack/drivers/pci: compat.o
Only in linux-2.5.40-irqstack/drivers/pci: devlist.h
Only in linux-2.5.40-irqstack/drivers/pci: gen-devlist
Only in linux-2.5.40-irqstack/drivers/pci: hotplug.o
Only in linux-2.5.40-irqstack/drivers/pci: names.o
Only in linux-2.5.40-irqstack/drivers/pci: pci-driver.o
Only in linux-2.5.40-irqstack/drivers/pci: pci.o
Only in linux-2.5.40-irqstack/drivers/pci: pool.o
Only in linux-2.5.40-irqstack/drivers/pci: probe.o
Only in linux-2.5.40-irqstack/drivers/pci: proc.o
Only in linux-2.5.40-irqstack/drivers/pci: quirks.o
Only in linux-2.5.40-irqstack/drivers/pci: search.o
Only in linux-2.5.40-irqstack/drivers/pci: setup-res.o
Only in linux-2.5.40-irqstack/drivers/scsi: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .constants.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .hosts.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .ips.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .qlogicisp.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_error.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_ioctl.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_lib.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_merge.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_mod.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_proc.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_scan.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsi_syms.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .scsicam.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sd.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sd_mod.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sg.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sr.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sr_ioctl.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sr_mod.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .sr_vendor.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi: .st.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7770.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7770_linux.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_93cx6.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_core.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_linux.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_linux_pci.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_pci.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .aic7xxx_proc.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7770.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7770_linux.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_93cx6.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_core.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_linux.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_linux_pci.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_pci.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_proc.o
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_reg.h
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: aic7xxx_seq.h
Only in linux-2.5.40-irqstack/drivers/scsi/aic7xxx: built-in.o
Only in linux-2.5.40-irqstack/drivers/scsi: built-in.o
Only in linux-2.5.40-irqstack/drivers/scsi: constants.o
Only in linux-2.5.40-irqstack/drivers/scsi: hosts.o
Only in linux-2.5.40-irqstack/drivers/scsi: ips.o
Only in linux-2.5.40-irqstack/drivers/scsi: qlogicisp.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_error.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_ioctl.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_lib.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_merge.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_mod.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_proc.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_scan.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsi_syms.o
Only in linux-2.5.40-irqstack/drivers/scsi: scsicam.o
Only in linux-2.5.40-irqstack/drivers/scsi: sd.o
Only in linux-2.5.40-irqstack/drivers/scsi: sd_mod.o
Only in linux-2.5.40-irqstack/drivers/scsi: sg.o
Only in linux-2.5.40-irqstack/drivers/scsi: sr.o
Only in linux-2.5.40-irqstack/drivers/scsi: sr_ioctl.o
Only in linux-2.5.40-irqstack/drivers/scsi: sr_mod.o
Only in linux-2.5.40-irqstack/drivers/scsi: sr_vendor.o
Only in linux-2.5.40-irqstack/drivers/scsi: st.o
Only in linux-2.5.40-irqstack/drivers/serial: .8250.o.cmd
Only in linux-2.5.40-irqstack/drivers/serial: .8250_pci.o.cmd
Only in linux-2.5.40-irqstack/drivers/serial: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/serial: .core.o.cmd
Only in linux-2.5.40-irqstack/drivers/serial: 8250.o
Only in linux-2.5.40-irqstack/drivers/serial: 8250_pci.o
Only in linux-2.5.40-irqstack/drivers/serial: built-in.o
Only in linux-2.5.40-irqstack/drivers/serial: core.o
Only in linux-2.5.40-irqstack/drivers/video: .built-in.o.cmd
Only in linux-2.5.40-irqstack/drivers/video: .vgacon.o.cmd
Only in linux-2.5.40-irqstack/drivers/video: built-in.o
Only in linux-2.5.40-irqstack/drivers/video: vgacon.o
Only in linux-2.5.40-irqstack/fs: .aio.o.cmd
Only in linux-2.5.40-irqstack/fs: .attr.o.cmd
Only in linux-2.5.40-irqstack/fs: .bad_inode.o.cmd
Only in linux-2.5.40-irqstack/fs: .binfmt_aout.o.cmd
Only in linux-2.5.40-irqstack/fs: .binfmt_elf.o.cmd
Only in linux-2.5.40-irqstack/fs: .binfmt_misc.o.cmd
Only in linux-2.5.40-irqstack/fs: .binfmt_script.o.cmd
Only in linux-2.5.40-irqstack/fs: .bio.o.cmd
Only in linux-2.5.40-irqstack/fs: .block_dev.o.cmd
Only in linux-2.5.40-irqstack/fs: .buffer.o.cmd
Only in linux-2.5.40-irqstack/fs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs: .char_dev.o.cmd
Only in linux-2.5.40-irqstack/fs: .dcache.o.cmd
Only in linux-2.5.40-irqstack/fs: .devices.o.cmd
Only in linux-2.5.40-irqstack/fs: .direct-io.o.cmd
Only in linux-2.5.40-irqstack/fs: .dnotify.o.cmd
Only in linux-2.5.40-irqstack/fs: .exec.o.cmd
Only in linux-2.5.40-irqstack/fs: .fcntl.o.cmd
Only in linux-2.5.40-irqstack/fs: .fifo.o.cmd
Only in linux-2.5.40-irqstack/fs: .file.o.cmd
Only in linux-2.5.40-irqstack/fs: .file_table.o.cmd
Only in linux-2.5.40-irqstack/fs: .filesystems.o.cmd
Only in linux-2.5.40-irqstack/fs: .fs-writeback.o.cmd
Only in linux-2.5.40-irqstack/fs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs: .iobuf.o.cmd
Only in linux-2.5.40-irqstack/fs: .ioctl.o.cmd
Only in linux-2.5.40-irqstack/fs: .libfs.o.cmd
Only in linux-2.5.40-irqstack/fs: .locks.o.cmd
Only in linux-2.5.40-irqstack/fs: .mpage.o.cmd
Only in linux-2.5.40-irqstack/fs: .namei.o.cmd
Only in linux-2.5.40-irqstack/fs: .namespace.o.cmd
Only in linux-2.5.40-irqstack/fs: .nfsctl.o.cmd
Only in linux-2.5.40-irqstack/fs: .open.o.cmd
Only in linux-2.5.40-irqstack/fs: .pipe.o.cmd
Only in linux-2.5.40-irqstack/fs: .read_write.o.cmd
Only in linux-2.5.40-irqstack/fs: .readdir.o.cmd
Only in linux-2.5.40-irqstack/fs: .select.o.cmd
Only in linux-2.5.40-irqstack/fs: .seq_file.o.cmd
Only in linux-2.5.40-irqstack/fs: .stat.o.cmd
Only in linux-2.5.40-irqstack/fs: .super.o.cmd
Only in linux-2.5.40-irqstack/fs: .xattr.o.cmd
Only in linux-2.5.40-irqstack/fs: aio.o
Only in linux-2.5.40-irqstack/fs: attr.o
Only in linux-2.5.40-irqstack/fs: bad_inode.o
Only in linux-2.5.40-irqstack/fs: binfmt_aout.o
Only in linux-2.5.40-irqstack/fs: binfmt_elf.o
Only in linux-2.5.40-irqstack/fs: binfmt_misc.o
Only in linux-2.5.40-irqstack/fs: binfmt_script.o
Only in linux-2.5.40-irqstack/fs: bio.o
Only in linux-2.5.40-irqstack/fs: block_dev.o
Only in linux-2.5.40-irqstack/fs: buffer.o
Only in linux-2.5.40-irqstack/fs: built-in.o
Only in linux-2.5.40-irqstack/fs: char_dev.o
Only in linux-2.5.40-irqstack/fs: dcache.o
Only in linux-2.5.40-irqstack/fs: devices.o
Only in linux-2.5.40-irqstack/fs/devpts: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/devpts: .devpts.o.cmd
Only in linux-2.5.40-irqstack/fs/devpts: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/devpts: built-in.o
Only in linux-2.5.40-irqstack/fs/devpts: devpts.o
Only in linux-2.5.40-irqstack/fs/devpts: inode.o
Only in linux-2.5.40-irqstack/fs: direct-io.o
Only in linux-2.5.40-irqstack/fs: dnotify.o
Only in linux-2.5.40-irqstack/fs/driverfs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/driverfs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/driverfs: built-in.o
Only in linux-2.5.40-irqstack/fs/driverfs: inode.o
Only in linux-2.5.40-irqstack/fs: exec.o
Only in linux-2.5.40-irqstack/fs/exportfs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/exportfs: .expfs.o.cmd
Only in linux-2.5.40-irqstack/fs/exportfs: .exportfs.o.cmd
Only in linux-2.5.40-irqstack/fs/exportfs: built-in.o
Only in linux-2.5.40-irqstack/fs/exportfs: expfs.o
Only in linux-2.5.40-irqstack/fs/exportfs: exportfs.o
Only in linux-2.5.40-irqstack/fs/ext2: .balloc.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .bitmap.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .dir.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .ext2.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .file.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .fsync.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .ialloc.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .ioctl.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .namei.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .super.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: .symlink.o.cmd
Only in linux-2.5.40-irqstack/fs/ext2: balloc.o
Only in linux-2.5.40-irqstack/fs/ext2: bitmap.o
Only in linux-2.5.40-irqstack/fs/ext2: built-in.o
Only in linux-2.5.40-irqstack/fs/ext2: dir.o
Only in linux-2.5.40-irqstack/fs/ext2: ext2.o
Only in linux-2.5.40-irqstack/fs/ext2: file.o
Only in linux-2.5.40-irqstack/fs/ext2: fsync.o
Only in linux-2.5.40-irqstack/fs/ext2: ialloc.o
Only in linux-2.5.40-irqstack/fs/ext2: inode.o
Only in linux-2.5.40-irqstack/fs/ext2: ioctl.o
Only in linux-2.5.40-irqstack/fs/ext2: namei.o
Only in linux-2.5.40-irqstack/fs/ext2: super.o
Only in linux-2.5.40-irqstack/fs/ext2: symlink.o
Only in linux-2.5.40-irqstack/fs/ext3: .balloc.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .bitmap.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .dir.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .ext3.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .file.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .fsync.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .ialloc.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .ioctl.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .namei.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .super.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: .symlink.o.cmd
Only in linux-2.5.40-irqstack/fs/ext3: balloc.o
Only in linux-2.5.40-irqstack/fs/ext3: bitmap.o
Only in linux-2.5.40-irqstack/fs/ext3: built-in.o
Only in linux-2.5.40-irqstack/fs/ext3: dir.o
Only in linux-2.5.40-irqstack/fs/ext3: ext3.o
Only in linux-2.5.40-irqstack/fs/ext3: file.o
Only in linux-2.5.40-irqstack/fs/ext3: fsync.o
Only in linux-2.5.40-irqstack/fs/ext3: ialloc.o
Only in linux-2.5.40-irqstack/fs/ext3: inode.o
Only in linux-2.5.40-irqstack/fs/ext3: ioctl.o
Only in linux-2.5.40-irqstack/fs/ext3: namei.o
Only in linux-2.5.40-irqstack/fs/ext3: super.o
Only in linux-2.5.40-irqstack/fs/ext3: symlink.o
Only in linux-2.5.40-irqstack/fs: fcntl.o
Only in linux-2.5.40-irqstack/fs: fifo.o
Only in linux-2.5.40-irqstack/fs: file.o
Only in linux-2.5.40-irqstack/fs: file_table.o
Only in linux-2.5.40-irqstack/fs: filesystems.o
Only in linux-2.5.40-irqstack/fs: fs-writeback.o
Only in linux-2.5.40-irqstack/fs: inode.o
Only in linux-2.5.40-irqstack/fs: iobuf.o
Only in linux-2.5.40-irqstack/fs: ioctl.o
Only in linux-2.5.40-irqstack/fs/isofs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .compress.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .dir.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .isofs.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .joliet.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .namei.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .rock.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: .util.o.cmd
Only in linux-2.5.40-irqstack/fs/isofs: built-in.o
Only in linux-2.5.40-irqstack/fs/isofs: compress.o
Only in linux-2.5.40-irqstack/fs/isofs: dir.o
Only in linux-2.5.40-irqstack/fs/isofs: inode.o
Only in linux-2.5.40-irqstack/fs/isofs: isofs.o
Only in linux-2.5.40-irqstack/fs/isofs: joliet.o
Only in linux-2.5.40-irqstack/fs/isofs: namei.o
Only in linux-2.5.40-irqstack/fs/isofs: rock.o
Only in linux-2.5.40-irqstack/fs/isofs: util.o
Only in linux-2.5.40-irqstack/fs/jbd: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .checkpoint.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .commit.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .jbd.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .journal.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .recovery.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .revoke.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: .transaction.o.cmd
Only in linux-2.5.40-irqstack/fs/jbd: built-in.o
Only in linux-2.5.40-irqstack/fs/jbd: checkpoint.o
Only in linux-2.5.40-irqstack/fs/jbd: commit.o
Only in linux-2.5.40-irqstack/fs/jbd: jbd.o
Only in linux-2.5.40-irqstack/fs/jbd: journal.o
Only in linux-2.5.40-irqstack/fs/jbd: recovery.o
Only in linux-2.5.40-irqstack/fs/jbd: revoke.o
Only in linux-2.5.40-irqstack/fs/jbd: transaction.o
Only in linux-2.5.40-irqstack/fs: libfs.o
Only in linux-2.5.40-irqstack/fs/lockd: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .clntlock.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .clntproc.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .host.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .lockd.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .lockd_syms.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .mon.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svc.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svc4proc.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svclock.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svcproc.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svcshare.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .svcsubs.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .xdr.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: .xdr4.o.cmd
Only in linux-2.5.40-irqstack/fs/lockd: built-in.o
Only in linux-2.5.40-irqstack/fs/lockd: clntlock.o
Only in linux-2.5.40-irqstack/fs/lockd: clntproc.o
Only in linux-2.5.40-irqstack/fs/lockd: host.o
Only in linux-2.5.40-irqstack/fs/lockd: lockd.o
Only in linux-2.5.40-irqstack/fs/lockd: lockd_syms.o
Only in linux-2.5.40-irqstack/fs/lockd: mon.o
Only in linux-2.5.40-irqstack/fs/lockd: svc.o
Only in linux-2.5.40-irqstack/fs/lockd: svc4proc.o
Only in linux-2.5.40-irqstack/fs/lockd: svclock.o
Only in linux-2.5.40-irqstack/fs/lockd: svcproc.o
Only in linux-2.5.40-irqstack/fs/lockd: svcshare.o
Only in linux-2.5.40-irqstack/fs/lockd: svcsubs.o
Only in linux-2.5.40-irqstack/fs/lockd: xdr.o
Only in linux-2.5.40-irqstack/fs/lockd: xdr4.o
Only in linux-2.5.40-irqstack/fs: locks.o
Only in linux-2.5.40-irqstack/fs: mpage.o
Only in linux-2.5.40-irqstack/fs: namei.o
Only in linux-2.5.40-irqstack/fs: namespace.o
Only in linux-2.5.40-irqstack/fs/nfs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .dir.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .file.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .flushd.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .nfs.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .nfs2xdr.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .nfs3proc.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .nfs3xdr.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .pagelist.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .proc.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .read.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .symlink.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .unlink.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: .write.o.cmd
Only in linux-2.5.40-irqstack/fs/nfs: built-in.o
Only in linux-2.5.40-irqstack/fs/nfs: dir.o
Only in linux-2.5.40-irqstack/fs/nfs: file.o
Only in linux-2.5.40-irqstack/fs/nfs: flushd.o
Only in linux-2.5.40-irqstack/fs/nfs: inode.o
Only in linux-2.5.40-irqstack/fs/nfs: nfs.o
Only in linux-2.5.40-irqstack/fs/nfs: nfs2xdr.o
Only in linux-2.5.40-irqstack/fs/nfs: nfs3proc.o
Only in linux-2.5.40-irqstack/fs/nfs: nfs3xdr.o
Only in linux-2.5.40-irqstack/fs/nfs: pagelist.o
Only in linux-2.5.40-irqstack/fs/nfs: proc.o
Only in linux-2.5.40-irqstack/fs/nfs: read.o
Only in linux-2.5.40-irqstack/fs/nfs: symlink.o
Only in linux-2.5.40-irqstack/fs/nfs: unlink.o
Only in linux-2.5.40-irqstack/fs/nfs: write.o
Only in linux-2.5.40-irqstack/fs: nfsctl.o
Only in linux-2.5.40-irqstack/fs/nfsd: .auth.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .export.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .lockd.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfs3proc.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfs3xdr.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfscache.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfsctl.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfsd.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfsfh.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfsproc.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfssvc.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .nfsxdr.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .stats.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: .vfs.o.cmd
Only in linux-2.5.40-irqstack/fs/nfsd: auth.o
Only in linux-2.5.40-irqstack/fs/nfsd: built-in.o
Only in linux-2.5.40-irqstack/fs/nfsd: export.o
Only in linux-2.5.40-irqstack/fs/nfsd: lockd.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfs3proc.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfs3xdr.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfscache.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfsctl.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfsd.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfsfh.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfsproc.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfssvc.o
Only in linux-2.5.40-irqstack/fs/nfsd: nfsxdr.o
Only in linux-2.5.40-irqstack/fs/nfsd: stats.o
Only in linux-2.5.40-irqstack/fs/nfsd: vfs.o
Only in linux-2.5.40-irqstack/fs/nls: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/nls: .nls_base.o.cmd
Only in linux-2.5.40-irqstack/fs/nls: built-in.o
Only in linux-2.5.40-irqstack/fs/nls: nls_base.o
Only in linux-2.5.40-irqstack/fs: open.o
Only in linux-2.5.40-irqstack/fs/partitions: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/partitions: .check.o.cmd
Only in linux-2.5.40-irqstack/fs/partitions: .msdos.o.cmd
Only in linux-2.5.40-irqstack/fs/partitions: built-in.o
Only in linux-2.5.40-irqstack/fs/partitions: check.o
Only in linux-2.5.40-irqstack/fs/partitions: msdos.o
Only in linux-2.5.40-irqstack/fs: pipe.o
Only in linux-2.5.40-irqstack/fs/proc: .array.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .base.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .generic.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .kcore.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .kmsg.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .proc.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .proc_misc.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .proc_tty.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: .root.o.cmd
Only in linux-2.5.40-irqstack/fs/proc: array.o
Only in linux-2.5.40-irqstack/fs/proc: base.o
Only in linux-2.5.40-irqstack/fs/proc: built-in.o
Only in linux-2.5.40-irqstack/fs/proc: generic.o
Only in linux-2.5.40-irqstack/fs/proc: inode.o
Only in linux-2.5.40-irqstack/fs/proc: kcore.o
Only in linux-2.5.40-irqstack/fs/proc: kmsg.o
Only in linux-2.5.40-irqstack/fs/proc: proc.o
Only in linux-2.5.40-irqstack/fs/proc: proc_misc.o
Only in linux-2.5.40-irqstack/fs/proc: proc_tty.o
Only in linux-2.5.40-irqstack/fs/proc: root.o
Only in linux-2.5.40-irqstack/fs/ramfs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/ramfs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/ramfs: .ramfs.o.cmd
Only in linux-2.5.40-irqstack/fs/ramfs: built-in.o
Only in linux-2.5.40-irqstack/fs/ramfs: inode.o
Only in linux-2.5.40-irqstack/fs/ramfs: ramfs.o
Only in linux-2.5.40-irqstack/fs: read_write.o
Only in linux-2.5.40-irqstack/fs: readdir.o
Only in linux-2.5.40-irqstack/fs: select.o
Only in linux-2.5.40-irqstack/fs: seq_file.o
Only in linux-2.5.40-irqstack/fs/smbfs: .built-in.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .cache.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .dir.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .file.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .getopt.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .inode.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .ioctl.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .proc.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .request.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .smbfs.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .smbiod.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .sock.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: .symlink.o.cmd
Only in linux-2.5.40-irqstack/fs/smbfs: built-in.o
Only in linux-2.5.40-irqstack/fs/smbfs: cache.o
Only in linux-2.5.40-irqstack/fs/smbfs: dir.o
Only in linux-2.5.40-irqstack/fs/smbfs: file.o
Only in linux-2.5.40-irqstack/fs/smbfs: getopt.o
Only in linux-2.5.40-irqstack/fs/smbfs: inode.o
Only in linux-2.5.40-irqstack/fs/smbfs: ioctl.o
Only in linux-2.5.40-irqstack/fs/smbfs: proc.o
Only in linux-2.5.40-irqstack/fs/smbfs: request.o
Only in linux-2.5.40-irqstack/fs/smbfs: smbfs.o
Only in linux-2.5.40-irqstack/fs/smbfs: smbiod.o
Only in linux-2.5.40-irqstack/fs/smbfs: sock.o
Only in linux-2.5.40-irqstack/fs/smbfs: symlink.o
Only in linux-2.5.40-irqstack/fs: stat.o
Only in linux-2.5.40-irqstack/fs: super.o
Only in linux-2.5.40-irqstack/fs: xattr.o
Only in linux-2.5.40-irqstack/include: asm
diff -ur linux-2.5.40/include/asm-i386/page.h linux-2.5.40-irqstack/include/asm-i386/page.h
--- linux-2.5.40/include/asm-i386/page.h	2002-10-01 00:06:18.000000000 -0700
+++ linux-2.5.40-irqstack/include/asm-i386/page.h	2002-10-04 12:29:45.000000000 -0700
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
Only in linux-2.5.40-irqstack/include/asm-i386: page.h.orig
diff -ur linux-2.5.40/include/asm-i386/thread_info.h linux-2.5.40-irqstack/include/asm-i386/thread_info.h
--- linux-2.5.40/include/asm-i386/thread_info.h	2002-10-01 00:06:18.000000000 -0700
+++ linux-2.5.40-irqstack/include/asm-i386/thread_info.h	2002-10-03 18:08:08.000000000 -0700
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
 
@@ -54,42 +58,43 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
+#define THREAD_ORDER 0 
+#define INIT_THREAD_SIZE       THREAD_SIZE
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
 
 /* thread information allocation */
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
 
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
+	
 #endif
 
 /*
Only in linux-2.5.40-irqstack/include/asm-i386: thread_info.h.orig
Only in linux-2.5.40-irqstack/include/asm-i386: thread_info.h.rej
Only in linux-2.5.40-irqstack/include: config
Only in linux-2.5.40-irqstack/include/linux: autoconf.h
Only in linux-2.5.40-irqstack/include/linux: compile.h
Only in linux-2.5.40-irqstack/include/linux: modules
Only in linux-2.5.40-irqstack/include/linux: modversions.h
Only in linux-2.5.40-irqstack/include/linux: version.h
Only in linux-2.5.40-irqstack/init: .built-in.o.cmd
Only in linux-2.5.40-irqstack/init: .do_mounts.o.cmd
Only in linux-2.5.40-irqstack/init: .main.o.cmd
Only in linux-2.5.40-irqstack/init: .version.o.cmd
Only in linux-2.5.40-irqstack/init: built-in.o
Only in linux-2.5.40-irqstack/init: do_mounts.o
Only in linux-2.5.40-irqstack/init: main.o
Only in linux-2.5.40-irqstack/init: version.o
Only in linux-2.5.40-irqstack/ipc: .built-in.o.cmd
Only in linux-2.5.40-irqstack/ipc: .msg.o.cmd
Only in linux-2.5.40-irqstack/ipc: .sem.o.cmd
Only in linux-2.5.40-irqstack/ipc: .shm.o.cmd
Only in linux-2.5.40-irqstack/ipc: .util.o.cmd
Only in linux-2.5.40-irqstack/ipc: built-in.o
Only in linux-2.5.40-irqstack/ipc: msg.o
Only in linux-2.5.40-irqstack/ipc: sem.o
Only in linux-2.5.40-irqstack/ipc: shm.o
Only in linux-2.5.40-irqstack/ipc: util.o
Only in linux-2.5.40-irqstack/kernel: .built-in.o.cmd
Only in linux-2.5.40-irqstack/kernel: .capability.o.cmd
Only in linux-2.5.40-irqstack/kernel: .context.o.cmd
Only in linux-2.5.40-irqstack/kernel: .cpu.o.cmd
Only in linux-2.5.40-irqstack/kernel: .dma.o.cmd
Only in linux-2.5.40-irqstack/kernel: .exec_domain.o.cmd
Only in linux-2.5.40-irqstack/kernel: .exit.o.cmd
Only in linux-2.5.40-irqstack/kernel: .fork.o.cmd
Only in linux-2.5.40-irqstack/kernel: .futex.o.cmd
Only in linux-2.5.40-irqstack/kernel: .itimer.o.cmd
Only in linux-2.5.40-irqstack/kernel: .kallsyms.o.cmd
Only in linux-2.5.40-irqstack/kernel: .kmod.o.cmd
Only in linux-2.5.40-irqstack/kernel: .ksyms.o.cmd
Only in linux-2.5.40-irqstack/kernel: .module.o.cmd
Only in linux-2.5.40-irqstack/kernel: .panic.o.cmd
Only in linux-2.5.40-irqstack/kernel: .pid.o.cmd
Only in linux-2.5.40-irqstack/kernel: .platform.o.cmd
Only in linux-2.5.40-irqstack/kernel: .printk.o.cmd
Only in linux-2.5.40-irqstack/kernel: .ptrace.o.cmd
Only in linux-2.5.40-irqstack/kernel: .resource.o.cmd
Only in linux-2.5.40-irqstack/kernel: .sched.o.cmd
Only in linux-2.5.40-irqstack/kernel: .signal.o.cmd
Only in linux-2.5.40-irqstack/kernel: .softirq.o.cmd
Only in linux-2.5.40-irqstack/kernel: .sys.o.cmd
Only in linux-2.5.40-irqstack/kernel: .sysctl.o.cmd
Only in linux-2.5.40-irqstack/kernel: .time.o.cmd
Only in linux-2.5.40-irqstack/kernel: .timer.o.cmd
Only in linux-2.5.40-irqstack/kernel: .uid16.o.cmd
Only in linux-2.5.40-irqstack/kernel: .user.o.cmd
Only in linux-2.5.40-irqstack/kernel: built-in.o
Only in linux-2.5.40-irqstack/kernel: capability.o
Only in linux-2.5.40-irqstack/kernel: context.o
Only in linux-2.5.40-irqstack/kernel: cpu.o
Only in linux-2.5.40-irqstack/kernel: dma.o
Only in linux-2.5.40-irqstack/kernel: exec_domain.o
Only in linux-2.5.40-irqstack/kernel: exit.o
Only in linux-2.5.40-irqstack/kernel: fork.o
Only in linux-2.5.40-irqstack/kernel: futex.o
Only in linux-2.5.40-irqstack/kernel: itimer.o
Only in linux-2.5.40-irqstack/kernel: kallsyms.o
Only in linux-2.5.40-irqstack/kernel: kmod.o
Only in linux-2.5.40-irqstack/kernel: ksyms.o
Only in linux-2.5.40-irqstack/kernel: module.o
Only in linux-2.5.40-irqstack/kernel: panic.o
Only in linux-2.5.40-irqstack/kernel: pid.o
Only in linux-2.5.40-irqstack/kernel: platform.o
Only in linux-2.5.40-irqstack/kernel: printk.o
Only in linux-2.5.40-irqstack/kernel: ptrace.o
Only in linux-2.5.40-irqstack/kernel: resource.o
Only in linux-2.5.40-irqstack/kernel: sched.o
Only in linux-2.5.40-irqstack/kernel: signal.o
Only in linux-2.5.40-irqstack/kernel: softirq.o
Only in linux-2.5.40-irqstack/kernel: sys.o
Only in linux-2.5.40-irqstack/kernel: sysctl.o
Only in linux-2.5.40-irqstack/kernel: time.o
Only in linux-2.5.40-irqstack/kernel: timer.o
Only in linux-2.5.40-irqstack/kernel: uid16.o
Only in linux-2.5.40-irqstack/kernel: user.o
Only in linux-2.5.40-irqstack/lib: .brlock.o.cmd
Only in linux-2.5.40-irqstack/lib: .bust_spinlocks.o.cmd
Only in linux-2.5.40-irqstack/lib: .cmdline.o.cmd
Only in linux-2.5.40-irqstack/lib: .crc32.o.cmd
Only in linux-2.5.40-irqstack/lib: .ctype.o.cmd
Only in linux-2.5.40-irqstack/lib: .dump_stack.o.cmd
Only in linux-2.5.40-irqstack/lib: .errno.o.cmd
Only in linux-2.5.40-irqstack/lib: .lib.a.cmd
Only in linux-2.5.40-irqstack/lib: .radix-tree.o.cmd
Only in linux-2.5.40-irqstack/lib: .rbtree.o.cmd
Only in linux-2.5.40-irqstack/lib: .rwsem.o.cmd
Only in linux-2.5.40-irqstack/lib: .string.o.cmd
Only in linux-2.5.40-irqstack/lib: .vsprintf.o.cmd
Only in linux-2.5.40-irqstack/lib: brlock.o
Only in linux-2.5.40-irqstack/lib: bust_spinlocks.o
Only in linux-2.5.40-irqstack/lib: cmdline.o
Only in linux-2.5.40-irqstack/lib: crc32.o
Only in linux-2.5.40-irqstack/lib: ctype.o
Only in linux-2.5.40-irqstack/lib: dump_stack.o
Only in linux-2.5.40-irqstack/lib: errno.o
Only in linux-2.5.40-irqstack/lib: lib.a
Only in linux-2.5.40-irqstack/lib: radix-tree.o
Only in linux-2.5.40-irqstack/lib: rbtree.o
Only in linux-2.5.40-irqstack/lib: rwsem.o
Only in linux-2.5.40-irqstack/lib: string.o
Only in linux-2.5.40-irqstack/lib: vsprintf.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .built-in.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .infblock.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .infcodes.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .inffast.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .inflate.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .inflate_syms.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .inftrees.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .infutil.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: .zlib_inflate.o.cmd
Only in linux-2.5.40-irqstack/lib/zlib_inflate: built-in.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: infblock.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: infcodes.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: inffast.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: inflate.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: inflate_syms.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: inftrees.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: infutil.o
Only in linux-2.5.40-irqstack/lib/zlib_inflate: zlib_inflate.o
Only in linux-2.5.40-irqstack/mm: .bootmem.o.cmd
Only in linux-2.5.40-irqstack/mm: .built-in.o.cmd
Only in linux-2.5.40-irqstack/mm: .filemap.o.cmd
Only in linux-2.5.40-irqstack/mm: .highmem.o.cmd
Only in linux-2.5.40-irqstack/mm: .madvise.o.cmd
Only in linux-2.5.40-irqstack/mm: .memory.o.cmd
Only in linux-2.5.40-irqstack/mm: .mempool.o.cmd
Only in linux-2.5.40-irqstack/mm: .mincore.o.cmd
Only in linux-2.5.40-irqstack/mm: .mlock.o.cmd
Only in linux-2.5.40-irqstack/mm: .mmap.o.cmd
Only in linux-2.5.40-irqstack/mm: .mprotect.o.cmd
Only in linux-2.5.40-irqstack/mm: .mremap.o.cmd
Only in linux-2.5.40-irqstack/mm: .msync.o.cmd
Only in linux-2.5.40-irqstack/mm: .numa.o.cmd
Only in linux-2.5.40-irqstack/mm: .oom_kill.o.cmd
Only in linux-2.5.40-irqstack/mm: .page-writeback.o.cmd
Only in linux-2.5.40-irqstack/mm: .page_alloc.o.cmd
Only in linux-2.5.40-irqstack/mm: .page_io.o.cmd
Only in linux-2.5.40-irqstack/mm: .pdflush.o.cmd
Only in linux-2.5.40-irqstack/mm: .readahead.o.cmd
Only in linux-2.5.40-irqstack/mm: .rmap.o.cmd
Only in linux-2.5.40-irqstack/mm: .shmem.o.cmd
Only in linux-2.5.40-irqstack/mm: .slab.o.cmd
Only in linux-2.5.40-irqstack/mm: .swap.o.cmd
Only in linux-2.5.40-irqstack/mm: .swap_state.o.cmd
Only in linux-2.5.40-irqstack/mm: .swapfile.o.cmd
Only in linux-2.5.40-irqstack/mm: .vcache.o.cmd
Only in linux-2.5.40-irqstack/mm: .vmalloc.o.cmd
Only in linux-2.5.40-irqstack/mm: .vmscan.o.cmd
Only in linux-2.5.40-irqstack/mm: bootmem.o
Only in linux-2.5.40-irqstack/mm: built-in.o
Only in linux-2.5.40-irqstack/mm: filemap.o
Only in linux-2.5.40-irqstack/mm: highmem.o
Only in linux-2.5.40-irqstack/mm: madvise.o
Only in linux-2.5.40-irqstack/mm: memory.o
Only in linux-2.5.40-irqstack/mm: mempool.o
Only in linux-2.5.40-irqstack/mm: mincore.o
Only in linux-2.5.40-irqstack/mm: mlock.o
Only in linux-2.5.40-irqstack/mm: mmap.o
Only in linux-2.5.40-irqstack/mm: mprotect.o
Only in linux-2.5.40-irqstack/mm: mremap.o
Only in linux-2.5.40-irqstack/mm: msync.o
Only in linux-2.5.40-irqstack/mm: numa.o
Only in linux-2.5.40-irqstack/mm: oom_kill.o
Only in linux-2.5.40-irqstack/mm: page-writeback.o
Only in linux-2.5.40-irqstack/mm: page_alloc.o
Only in linux-2.5.40-irqstack/mm: page_io.o
Only in linux-2.5.40-irqstack/mm: pdflush.o
Only in linux-2.5.40-irqstack/mm: readahead.o
Only in linux-2.5.40-irqstack/mm: rmap.o
Only in linux-2.5.40-irqstack/mm: shmem.o
Only in linux-2.5.40-irqstack/mm: slab.o
Only in linux-2.5.40-irqstack/mm: swap.o
Only in linux-2.5.40-irqstack/mm: swap_state.o
Only in linux-2.5.40-irqstack/mm: swapfile.o
Only in linux-2.5.40-irqstack/mm: vcache.o
Only in linux-2.5.40-irqstack/mm: vmalloc.o
Only in linux-2.5.40-irqstack/mm: vmscan.o
Only in linux-2.5.40-irqstack/net: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net: .netsyms.o.cmd
Only in linux-2.5.40-irqstack/net: .socket.o.cmd
Only in linux-2.5.40-irqstack/net: .sysctl_net.o.cmd
Only in linux-2.5.40-irqstack/net/802: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/802: .p8023.o.cmd
Only in linux-2.5.40-irqstack/net/802: .sysctl_net_802.o.cmd
Only in linux-2.5.40-irqstack/net/802: built-in.o
Only in linux-2.5.40-irqstack/net/802: p8023.o
Only in linux-2.5.40-irqstack/net/802: sysctl_net_802.o
Only in linux-2.5.40-irqstack/net: built-in.o
Only in linux-2.5.40-irqstack/net/core: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/core: .datagram.o.cmd
Only in linux-2.5.40-irqstack/net/core: .dev.o.cmd
Only in linux-2.5.40-irqstack/net/core: .dev_mcast.o.cmd
Only in linux-2.5.40-irqstack/net/core: .dst.o.cmd
Only in linux-2.5.40-irqstack/net/core: .filter.o.cmd
Only in linux-2.5.40-irqstack/net/core: .iovec.o.cmd
Only in linux-2.5.40-irqstack/net/core: .neighbour.o.cmd
Only in linux-2.5.40-irqstack/net/core: .rtnetlink.o.cmd
Only in linux-2.5.40-irqstack/net/core: .scm.o.cmd
Only in linux-2.5.40-irqstack/net/core: .skbuff.o.cmd
Only in linux-2.5.40-irqstack/net/core: .sock.o.cmd
Only in linux-2.5.40-irqstack/net/core: .sysctl_net_core.o.cmd
Only in linux-2.5.40-irqstack/net/core: .utils.o.cmd
Only in linux-2.5.40-irqstack/net/core: built-in.o
Only in linux-2.5.40-irqstack/net/core: datagram.o
Only in linux-2.5.40-irqstack/net/core: dev.o
Only in linux-2.5.40-irqstack/net/core: dev_mcast.o
Only in linux-2.5.40-irqstack/net/core: dst.o
Only in linux-2.5.40-irqstack/net/core: filter.o
Only in linux-2.5.40-irqstack/net/core: iovec.o
Only in linux-2.5.40-irqstack/net/core: neighbour.o
Only in linux-2.5.40-irqstack/net/core: rtnetlink.o
Only in linux-2.5.40-irqstack/net/core: scm.o
Only in linux-2.5.40-irqstack/net/core: skbuff.o
Only in linux-2.5.40-irqstack/net/core: sock.o
Only in linux-2.5.40-irqstack/net/core: sysctl_net_core.o
Only in linux-2.5.40-irqstack/net/core: utils.o
Only in linux-2.5.40-irqstack/net/ethernet: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/ethernet: .eth.o.cmd
Only in linux-2.5.40-irqstack/net/ethernet: .sysctl_net_ether.o.cmd
Only in linux-2.5.40-irqstack/net/ethernet: built-in.o
Only in linux-2.5.40-irqstack/net/ethernet: eth.o
Only in linux-2.5.40-irqstack/net/ethernet: sysctl_net_ether.o
Only in linux-2.5.40-irqstack/net/ipv4: .af_inet.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .arp.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .devinet.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .fib_frontend.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .fib_hash.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .fib_semantics.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .icmp.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .igmp.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .inetpeer.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_forward.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_fragment.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_input.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_options.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_output.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .ip_sockglue.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .proc.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .protocol.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .raw.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .route.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .sysctl_net_ipv4.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_diag.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_input.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_ipv4.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_minisocks.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_output.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .tcp_timer.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .udp.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: .utils.o.cmd
Only in linux-2.5.40-irqstack/net/ipv4: af_inet.o
Only in linux-2.5.40-irqstack/net/ipv4: arp.o
Only in linux-2.5.40-irqstack/net/ipv4: built-in.o
Only in linux-2.5.40-irqstack/net/ipv4: devinet.o
Only in linux-2.5.40-irqstack/net/ipv4: fib_frontend.o
Only in linux-2.5.40-irqstack/net/ipv4: fib_hash.o
Only in linux-2.5.40-irqstack/net/ipv4: fib_semantics.o
Only in linux-2.5.40-irqstack/net/ipv4: icmp.o
Only in linux-2.5.40-irqstack/net/ipv4: igmp.o
Only in linux-2.5.40-irqstack/net/ipv4: inetpeer.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_forward.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_fragment.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_input.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_options.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_output.o
Only in linux-2.5.40-irqstack/net/ipv4: ip_sockglue.o
Only in linux-2.5.40-irqstack/net/ipv4: proc.o
Only in linux-2.5.40-irqstack/net/ipv4: protocol.o
Only in linux-2.5.40-irqstack/net/ipv4: raw.o
Only in linux-2.5.40-irqstack/net/ipv4: route.o
Only in linux-2.5.40-irqstack/net/ipv4: sysctl_net_ipv4.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_diag.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_input.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_ipv4.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_minisocks.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_output.o
Only in linux-2.5.40-irqstack/net/ipv4: tcp_timer.o
Only in linux-2.5.40-irqstack/net/ipv4: udp.o
Only in linux-2.5.40-irqstack/net/ipv4: utils.o
Only in linux-2.5.40-irqstack/net/netlink: .af_netlink.o.cmd
Only in linux-2.5.40-irqstack/net/netlink: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/netlink: .netlink_dev.o.cmd
Only in linux-2.5.40-irqstack/net/netlink: af_netlink.o
Only in linux-2.5.40-irqstack/net/netlink: built-in.o
Only in linux-2.5.40-irqstack/net/netlink: netlink_dev.o
Only in linux-2.5.40-irqstack/net: netsyms.o
Only in linux-2.5.40-irqstack/net/packet: .af_packet.o.cmd
Only in linux-2.5.40-irqstack/net/packet: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/packet: af_packet.o
Only in linux-2.5.40-irqstack/net/packet: built-in.o
Only in linux-2.5.40-irqstack/net/sched: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/sched: .sch_generic.o.cmd
Only in linux-2.5.40-irqstack/net/sched: built-in.o
Only in linux-2.5.40-irqstack/net/sched: sch_generic.o
Only in linux-2.5.40-irqstack/net: socket.o
Only in linux-2.5.40-irqstack/net/sunrpc: .auth.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .auth_null.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .auth_unix.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .clnt.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .pmap_clnt.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .sched.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .stats.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .sunrpc.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .sunrpc_syms.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .svc.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .svcauth.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .svcsock.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .sysctl.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .timer.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .xdr.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: .xprt.o.cmd
Only in linux-2.5.40-irqstack/net/sunrpc: auth.o
Only in linux-2.5.40-irqstack/net/sunrpc: auth_null.o
Only in linux-2.5.40-irqstack/net/sunrpc: auth_unix.o
Only in linux-2.5.40-irqstack/net/sunrpc: built-in.o
Only in linux-2.5.40-irqstack/net/sunrpc: clnt.o
Only in linux-2.5.40-irqstack/net/sunrpc: pmap_clnt.o
Only in linux-2.5.40-irqstack/net/sunrpc: sched.o
Only in linux-2.5.40-irqstack/net/sunrpc: stats.o
Only in linux-2.5.40-irqstack/net/sunrpc: sunrpc.o
Only in linux-2.5.40-irqstack/net/sunrpc: sunrpc_syms.o
Only in linux-2.5.40-irqstack/net/sunrpc: svc.o
Only in linux-2.5.40-irqstack/net/sunrpc: svcauth.o
Only in linux-2.5.40-irqstack/net/sunrpc: svcsock.o
Only in linux-2.5.40-irqstack/net/sunrpc: sysctl.o
Only in linux-2.5.40-irqstack/net/sunrpc: timer.o
Only in linux-2.5.40-irqstack/net/sunrpc: xdr.o
Only in linux-2.5.40-irqstack/net/sunrpc: xprt.o
Only in linux-2.5.40-irqstack/net: sysctl_net.o
Only in linux-2.5.40-irqstack/net/unix: .af_unix.o.cmd
Only in linux-2.5.40-irqstack/net/unix: .built-in.o.cmd
Only in linux-2.5.40-irqstack/net/unix: .garbage.o.cmd
Only in linux-2.5.40-irqstack/net/unix: .sysctl_net_unix.o.cmd
Only in linux-2.5.40-irqstack/net/unix: .unix.o.cmd
Only in linux-2.5.40-irqstack/net/unix: af_unix.o
Only in linux-2.5.40-irqstack/net/unix: built-in.o
Only in linux-2.5.40-irqstack/net/unix: garbage.o
Only in linux-2.5.40-irqstack/net/unix: sysctl_net_unix.o
Only in linux-2.5.40-irqstack/net/unix: unix.o
Only in linux-2.5.40-irqstack/scripts: .conmakehash.cmd
Only in linux-2.5.40-irqstack/scripts: .docproc.cmd
Only in linux-2.5.40-irqstack/scripts: .fixdep.cmd
Only in linux-2.5.40-irqstack/scripts: .split-include.cmd
Only in linux-2.5.40-irqstack/scripts: .split-include.tmp
Only in linux-2.5.40-irqstack/scripts: conmakehash
Only in linux-2.5.40-irqstack/scripts: docproc
Only in linux-2.5.40-irqstack/scripts: fixdep
Only in linux-2.5.40-irqstack/scripts/lxdialog: .checklist.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .inputbox.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .lxdialog.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .lxdialog.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .menubox.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .msgbox.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .textbox.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .util.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: .yesno.o.cmd
Only in linux-2.5.40-irqstack/scripts/lxdialog: checklist.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: inputbox.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: lxdialog
Only in linux-2.5.40-irqstack/scripts/lxdialog: lxdialog.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: menubox.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: msgbox.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: textbox.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: util.o
Only in linux-2.5.40-irqstack/scripts/lxdialog: yesno.o
Only in linux-2.5.40-irqstack/scripts: split-include
Only in linux-2.5.40-irqstack/security: .built-in.o.cmd
Only in linux-2.5.40-irqstack/security: .capability.o.cmd
Only in linux-2.5.40-irqstack/security: .dummy.o.cmd
Only in linux-2.5.40-irqstack/security: .security.o.cmd
Only in linux-2.5.40-irqstack/security: built-in.o
Only in linux-2.5.40-irqstack/security: capability.o
Only in linux-2.5.40-irqstack/security: dummy.o
Only in linux-2.5.40-irqstack/security: security.o
Only in linux-2.5.40-irqstack/sound: .built-in.o.cmd
Only in linux-2.5.40-irqstack/sound: built-in.o
Only in linux-2.5.40-irqstack/: vmlinux

--------------060402050003090705050105--

