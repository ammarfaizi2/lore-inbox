Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265330AbSJaTPT>; Thu, 31 Oct 2002 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265332AbSJaTPS>; Thu, 31 Oct 2002 14:15:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43774 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265330AbSJaTPG>;
	Thu, 31 Oct 2002 14:15:06 -0500
Subject: [PATCH] (2/3) per-cpu interrupt stacks for x86
From: "David C. Hansen" <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.COM>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1036091906.4272.87.camel@nighthawk>
References: <1036091906.4272.87.camel@nighthawk>
Content-Type: multipart/mixed; boundary="=-4+lLSY4j4kNs9sPP5UtE"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 11:20:50 -0800
Message-Id: <1036092050.1542.94.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4+lLSY4j4kNs9sPP5UtE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

* interrupt stacks (2/3)
   - allocate per-cpu interrupt stacks.  upon entry to
     common_interrupt, switch to the current cpu's stack.
   - inherit the interrupted task's preempt count, and pass
     back relevant task flags

Depends on the previously sent thread_info cleanup
-- 
Dave Hansen
haveblue@us.ibm.com

--=-4+lLSY4j4kNs9sPP5UtE
Content-Disposition: attachment; filename=B-interrupt_stacks-2.5.45-4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=B-interrupt_stacks-2.5.45-4.patch; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.856   -> 1.857 =20
#	arch/i386/kernel/process.c	1.32    -> 1.32.1.1
#	arch/i386/kernel/irq.c	1.21.1.2 -> 1.23.1.1
#	include/asm-i386/thread_info.h	1.8     -> 1.10  =20
#	arch/i386/kernel/entry.S	1.38.2.1 -> 1.38.1.3
#	arch/i386/kernel/smpboot.c	1.36    -> 1.37  =20
#	arch/i386/kernel/init_task.c	1.6     -> 1.6.1.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	haveblue@elm3b96.(none)	1.857
# Merge
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Oct 31 11:12:05 2002
+++ b/arch/i386/kernel/entry.S	Thu Oct 31 11:12:05 2002
@@ -334,7 +334,45 @@
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
+=09
+	# update the task pointer in the irq stack
+	GET_THREAD_INFO(%esi)
+	movl %edx,TI_TASK(%esi)
+
+	# update the preempt count in the irq stack
+	movl TI_PRE_COUNT(%ebx),%ecx
+	movl %ecx,TI_PRE_COUNT(%esi)
+	=09
 	call do_IRQ
+
+	movl %eax,%esp                  # potentially restore non-irq stack
+=09
+	# copy flags from the irq stack back into the task's thread_info
+	# %esi is saved over the do_IRQ call and contains the irq stack
+	# thread_info pointer
+	# %ebx contains the original thread_info pointer
+	movl TI_FLAGS(%esi),%eax
+	movl $0,TI_FLAGS(%esi)
+	LOCK orl %eax,TI_FLAGS(%ebx)
+
 	jmp ret_from_intr
=20
 #define BUILD_INTERRUPT(name, nr)	\
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Thu Oct 31 11:12:05 2002
+++ b/arch/i386/kernel/init_task.c	Thu Oct 31 11:12:05 2002
@@ -13,6 +13,10 @@
 static struct signal_struct init_signals =3D INIT_SIGNALS(init_signals);
 struct mm_struct init_mm =3D INIT_MM(init_mm);
=20
+union thread_union init_irq_union
+	__attribute__((__section__(".data.init_task")));
+
+
 /*
  * Initial thread structure.
  *
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Thu Oct 31 11:12:05 2002
+++ b/arch/i386/kernel/irq.c	Thu Oct 31 11:12:05 2002
@@ -311,7 +311,8 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+struct pt_regs *do_IRQ(struct pt_regs *regs) __attribute__((regparm(1)));
+struct pt_regs *do_IRQ(struct pt_regs *regs)
 {=09
 	/*=20
 	 * We ack quickly, we don't want the irq controller
@@ -323,7 +324,7 @@
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq =3D regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq =3D regs->orig_eax & 0xff; /* high bits used in ret_from_ code  *=
/
 	int cpu =3D smp_processor_id();
 	irq_desc_t *desc =3D irq_desc + irq;
 	struct irqaction * action;
@@ -388,7 +389,7 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, &regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 	=09
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -407,7 +408,7 @@
=20
 	irq_exit();
=20
-	return 1;
+	return regs;
 }
=20
 /**
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Oct 31 11:12:05 2002
+++ b/arch/i386/kernel/process.c	Thu Oct 31 11:12:05 2002
@@ -413,6 +413,7 @@
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirec=
tly */
=20
+	next_p->thread_info->irq_stack =3D prev_p->thread_info->irq_stack;
 	unlazy_fpu(prev_p);
=20
 	/*
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Thu Oct 31 11:12:05 2002
+++ b/arch/i386/kernel/smpboot.c	Thu Oct 31 11:12:05 2002
@@ -70,6 +70,11 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
=20
+/* Per CPU interrupt stacks */
+extern union thread_union init_irq_union;
+union thread_union *irq_stacks[NR_CPUS] __cacheline_aligned =3D
+	{ &init_irq_union, };
+
 /* Set when the idlers are all forked */
 int smp_threads_ready;
=20
@@ -764,6 +769,28 @@
 	return (send_status | accept_status);
 }
=20
+static void __init setup_irq_stack(struct task_struct *p, int cpu)
+{
+	unsigned long stk;
+
+	stk =3D __get_free_pages(GFP_KERNEL, THREAD_ORDER+1);
+	if (!stk)
+		panic("I can't seem to allocate my irq stack.  Oh well, giving up.");
+
+	irq_stacks[cpu] =3D (void *)stk;
+	memset(irq_stacks[cpu], 0, THREAD_SIZE);
+	irq_stacks[cpu]->thread_info.cpu =3D cpu;
+	irq_stacks[cpu]->thread_info.preempt_count =3D 1;
+					/* interrupts are not preemptable */
+	p->thread_info->irq_stack =3D irq_stacks[cpu];
+
+	/* If we want to make the irq stack more than one unit
+	 * deep, we can chain then off of the irq_stack pointer
+	 * here.
+	 */
+}
+
+
 extern unsigned long cpu_initialized;
=20
 static void __init do_boot_cpu (int apicid)=20
@@ -787,6 +814,8 @@
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
=20
+	setup_irq_stack(idle, cpu);
+
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
@@ -804,7 +833,13 @@
=20
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp =3D (void *) (1024 + PAGE_SIZE + (char *)idle->thread_inf=
o);
+
+	/* The -4 is to correct for the fact that the stack pointer
+	 * is used to find the location of the thread_info structure
+	 * by masking off several of the LSBs.  Without the -4, esp
+	 * is pointing to the page after the one the stack is on.
+	 */
+	stack_start.esp =3D (void *)(THREAD_SIZE - 4 + (char *)idle->thread_info)=
;
=20
 	/*
 	 * This grunge runs the startup process for
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Thu Oct 31 11:12:05 2002
+++ b/include/asm-i386/thread_info.h	Thu Oct 31 11:12:05 2002
@@ -29,9 +29,11 @@
 	__s32			preempt_count; /* 0 =3D> preemptable, <0 =3D> BUG */
=20
 	mm_segment_t		addr_limit;	/* thread address space:
+						   0 for interrupts: illegal
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct thread_info	*irq_stack;	/* pointer to cpu irq stack */
=20
 	__u8			supervisor_stack[0];
 };
@@ -45,6 +47,7 @@
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
+#define TI_IRQ_STACK	0x00000018
=20
 #endif
=20
@@ -67,6 +70,7 @@
 	.cpu		=3D 0,			\
 	.preempt_count	=3D 1,			\
 	.addr_limit	=3D KERNEL_DS,		\
+	.irq_stack	=3D &init_irq_union	\
 }
=20
 #define init_thread_info	(init_thread_union.thread_info)

--=-4+lLSY4j4kNs9sPP5UtE--

