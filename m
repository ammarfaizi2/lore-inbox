Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSLIWFB>; Mon, 9 Dec 2002 17:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbSLIWEv>; Mon, 9 Dec 2002 17:04:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54458 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266203AbSLIWDe>;
	Mon, 9 Dec 2002 17:03:34 -0500
Message-ID: <3DF51492.3050009@us.ibm.com>
Date: Mon, 09 Dec 2002 14:09:22 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/4) stack updates for x86
Content-Type: multipart/mixed;
 boundary="------------050208070205070102060207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208070205070102060207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The kernel currently uses an 8k stack, per task.  Here is the
infrastructure needed to allow us to halve that.

B-interrupt_stacks-2.5.50+bk-5.patch
	Have special stacks for use in interrupts.


-- 
Dave Hansen
haveblue@us.ibm.com


--------------050208070205070102060207
Content-Type: text/plain;
 name="B-interrupt_stacks-2.5.50+bk-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="B-interrupt_stacks-2.5.50+bk-5.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.859   -> 1.860  
#	arch/i386/kernel/process.c	1.32.1.5 -> 1.35   
#	arch/i386/kernel/irq.c	1.21.1.3 -> 1.25   
#	include/asm-i386/thread_info.h	1.8.1.1 -> 1.11   
#	arch/i386/kernel/entry.S	1.39.1.4 -> 1.44   
#	arch/i386/kernel/smpboot.c	1.36.1.4 -> 1.40   
#	arch/i386/kernel/init_task.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.860
# merge syscall restart with interrupt stacks
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Dec  9 10:56:39 2002
+++ b/arch/i386/kernel/entry.S	Mon Dec  9 10:56:39 2002
@@ -333,7 +333,45 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+
+
+	GET_THREAD_INFO(%ebx)
+	movl TI_IRQ_STACK(%ebx),%ecx
+	movl TI_TASK(%ebx),%edx
+	movl %esp,%eax
+	leal (THREAD_SIZE-4)(%ecx),%esi # %ecx+THREAD_SIZE is next stack
+	                                # -4 keeps us in the right one
+	testl %ecx,%ecx                 # is there a valid irq_stack?
+
+	# switch to the irq stack
+#ifdef CONFIG_X86_HAVE_CMOV
+	cmovnz %esi,%esp
+#else
+	jz 1f
+	mov %esi,%esp
+1:
+#endif
+	
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%esi)
+	movl %edx,TI_TASK(%esi)
+
+	# update the preempt count in the irq stack
+	movl TI_PRE_COUNT(%ebx),%ecx
+	movl %ecx,TI_PRE_COUNT(%esi)
+		
 	call do_IRQ
+
+	movl %eax,%esp                  # potentially restore non-irq stack
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
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Mon Dec  9 10:56:39 2002
+++ b/arch/i386/kernel/init_task.c	Mon Dec  9 10:56:39 2002
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
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Dec  9 10:56:39 2002
+++ b/arch/i386/kernel/irq.c	Mon Dec  9 10:56:39 2002
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
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Dec  9 10:56:39 2002
+++ b/arch/i386/kernel/process.c	Mon Dec  9 10:56:39 2002
@@ -435,6 +435,7 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	next_p->thread_info->irq_stack = prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
 
 	/*
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Dec  9 10:56:39 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Dec  9 10:56:39 2002
@@ -70,6 +70,11 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
+/* Per CPU interrupt stacks */
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
@@ -766,6 +771,28 @@
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
+
 extern unsigned long cpu_initialized;
 
 static void __init do_boot_cpu (int apicid) 
@@ -789,6 +816,8 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
+	setup_irq_stack(idle, cpu);
+
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
@@ -806,7 +835,13 @@
 
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
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Mon Dec  9 10:56:39 2002
+++ b/include/asm-i386/thread_info.h	Mon Dec  9 10:56:39 2002
@@ -30,10 +30,12 @@
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
+						   0 for interrupts: illegal
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
 	struct restart_block    restart_block;
+	struct thread_info	*irq_stack;	/* pointer to cpu irq stack */
 
 	__u8			supervisor_stack[0];
 };
@@ -48,6 +50,7 @@
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
 #define TI_RESTART_BLOCK 0x0000018
+#define TI_IRQ_STACK	0x00000022
 
 #endif
 
@@ -74,6 +77,7 @@
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
 	},					\
+	.irq_stack	= &init_irq_union	\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)

--------------050208070205070102060207--

