Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319376AbSIKW5U>; Wed, 11 Sep 2002 18:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319377AbSIKW5U>; Wed, 11 Sep 2002 18:57:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59536 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319376AbSIKW5G>;
	Wed, 11 Sep 2002 18:57:06 -0400
Message-ID: <3D7FCB09.7050105@us.ibm.com>
Date: Wed, 11 Sep 2002 16:00:25 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  4KB stack + irq stack for x86 
Content-Type: multipart/mixed;
 boundary="------------010106020702070600080709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010106020702070600080709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a resync of the last patch for 2.5.34 that resulted from this discussion 
(not the original patch):
http://lwn.net/Articles/1642/
The only change was readding the reference to task_info in the beginning of 
common_interrupt.  It had been dropped when we stopped messing with 
preempt_count there.

I've beaten this thing with my normal array of Specweb tests and it is behaving 
so far.  I've booted on an 8-way with and without SMP.

part of Ben's original message:
> Below is a patch against 2.5.20 that implements 4KB stacks for tasks, 
> plus a seperate 4KB irq stack for use by interrupts.  There are a couple 
> of reasons for doing this: 4KB stacks put less pressure on the VM 
> subsystem, reduces the overall memory usage for systems with large 
> numbers of tasks, and increases the reliability of the system when 
> under heavy irq load by provide a fixed stack size for interrupt 
> handlers that other kernel code will not eat into.
> 
> The interrupt stacks are stackable, so we could use multiple 
> 4KB irq stacks.  The thread_info structure is included in each 
> interrupt stack, and has the current pointer copied into it upon 
> entry.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010106020702070600080709
Content-Type: text/plain;
 name="irqstack-2.5.34-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irqstack-2.5.34-1.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.624   -> 1.626  
#	arch/i386/kernel/process.c	1.40    -> 1.41   
#	arch/i386/kernel/irq.c	1.18    -> 1.19   
#	arch/i386/kernel/head.S	1.15    -> 1.16   
#	include/asm-i386/thread_info.h	1.7     -> 1.8    
#	include/asm-i386/page.h	1.16    -> 1.17   
#	arch/i386/kernel/entry.S	1.41    -> 1.43   
#	 arch/i386/config.in	1.47    -> 1.48   
#	  arch/i386/Makefile	1.17    -> 1.18   
#	arch/i386/kernel/i386_ksyms.c	1.30    -> 1.31   
#	arch/i386/kernel/smpboot.c	1.33    -> 1.34   
#	arch/i386/boot/compressed/misc.c	1.7     -> 1.8    
#	arch/i386/kernel/init_task.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	haveblue@elm3b96.(none)	1.625
# Import patch v2.5.20-stack-A2.diff
# --------------------------------------------
# 02/09/11	haveblue@elm3b96.(none)	1.626
# don't fetch things out of ebx when it has garbage in it :(
# --------------------------------------------
#
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/Makefile	Wed Sep 11 15:30:18 2002
@@ -85,6 +85,10 @@
 CFLAGS += -march=i586
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/boot/compressed/misc.c	Wed Sep 11 15:30:18 2002
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/config.in	Wed Sep 11 15:30:18 2002
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
@@ -429,6 +435,7 @@
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Check for stack overflows' CONFIG_X86_STACK_CHECK
 fi
 
 endmenu
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/entry.S	Wed Sep 11 15:30:18 2002
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
@@ -334,7 +334,39 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+
+	GET_THREAD_INFO(%ebx)
+	movl TI_IRQ_STACK(%ebx),%ecx
+	movl TI_TASK(%ebx),%edx
+	movl %esp,%eax
+	leal (THREAD_SIZE-4)(%ecx),%esi
+	testl %ecx,%ecx			# is there a valid irq_stack?
+
+	# switch to the irq stack
+#ifdef CONFIG_X86_HAVE_CMOV
+	cmovnz %esi,%esp
+#else
+	jnz 1f
+	mov %esi,%esp
+1:
+#endif
+
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%esi)
+	movl %edx,TI_TASK(%esi)
+
 	call do_IRQ
+
+	movl %eax,%esp			# potentially restore non-irq stack
+
+	# copy flags from the irq stack back into the task's thread_info
+	# %esi is saved over the do_IRQ call and contains the irq stack
+	# thread_info pointer
+	# %ebx contains the original thread_info pointer
+	movl TI_FLAGS(%esi),%eax
+	movl $0,TI_FLAGS(%esi)
+	LOCK orl %eax,TI_FLAGS(%ebx)
+
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
@@ -506,6 +538,61 @@
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
+
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
+	cmpl $0x200,%eax        /* 512 byte danger zone */
+	jle 1f
+2:
+	popl %eax
+	ret
+1:
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
 
 .data
 ENTRY(sys_call_table)
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/head.S	Wed Sep 11 15:30:18 2002
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
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Wed Sep 11 15:30:18 2002
@@ -172,3 +172,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/init_task.c	Wed Sep 11 15:30:18 2002
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
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/irq.c	Wed Sep 11 15:30:18 2002
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
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/process.c	Wed Sep 11 15:30:18 2002
@@ -438,6 +438,16 @@
 
 extern void show_trace(unsigned long* esp);
 
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
 void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
@@ -693,6 +703,7 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Wed Sep 11 15:30:18 2002
+++ b/arch/i386/kernel/smpboot.c	Wed Sep 11 15:30:18 2002
@@ -67,6 +67,10 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
@@ -762,6 +766,27 @@
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
@@ -785,6 +810,8 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
+	setup_irq_stack(idle, cpu);
+
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
@@ -802,7 +829,13 @@
 
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
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Wed Sep 11 15:30:18 2002
+++ b/include/asm-i386/page.h	Wed Sep 11 15:30:18 2002
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
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Wed Sep 11 15:30:18 2002
+++ b/include/asm-i386/thread_info.h	Wed Sep 11 15:30:18 2002
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
 
@@ -54,42 +58,42 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
+#define THREAD_ORDER  0
+#define INIT_THREAD_SIZE      THREAD_SIZE
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
-
+/* use this one if reg already contains %esp */
+#define GET_THREAD_INFO_WITH_ESP(reg) \
+	andl $-THREAD_SIZE, reg
+ 
 #endif
 
 /*

--------------010106020702070600080709--

