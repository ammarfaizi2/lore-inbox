Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262098AbSI3NsJ>; Mon, 30 Sep 2002 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbSI3Nra>; Mon, 30 Sep 2002 09:47:30 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:40654 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262071AbSI3Nnp> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (1/26): arch.
Date: Mon, 30 Sep 2002 14:50:14 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301450.14307.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 arch file changes for 2.5.39. 

diff -urN linux-2.5.39/arch/s390/kernel/Makefile linux-2.5.39-s390/arch/s390/kernel/Makefile
--- linux-2.5.39/arch/s390/kernel/Makefile	Fri Sep 27 23:50:55 2002
+++ linux-2.5.39-s390/arch/s390/kernel/Makefile	Mon Sep 30 13:24:59 2002
@@ -5,8 +5,8 @@
 EXTRA_TARGETS	:= head.o init_task.o
 EXTRA_AFLAGS	:= -traditional
 
-export-objs	:= debug.o ebcdic.o irq.o s390_ext.o smp.o s390_ksyms.o
-obj-y	:= entry.o bitmap.o traps.o time.o process.o irq.o \
+export-objs	:= debug.o ebcdic.o s390_ext.o smp.o s390_ksyms.o
+obj-y	:= entry.o bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
             semaphore.o s390fpu.o reipl.o s390_ext.o debug.o
 
diff -urN linux-2.5.39/arch/s390/kernel/head.S linux-2.5.39-s390/arch/s390/kernel/head.S
--- linux-2.5.39/arch/s390/kernel/head.S	Fri Sep 27 23:49:16 2002
+++ linux-2.5.39-s390/arch/s390/kernel/head.S	Mon Sep 30 13:25:16 2002
@@ -653,5 +653,5 @@
 .Lstart:    .long  start_kernel
 .Lbss_bgn:  .long  __bss_start
 .Lbss_end:  .long  _end
-.Laregs:    .long  0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
+.Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 
diff -urN linux-2.5.39/arch/s390/kernel/init_task.c linux-2.5.39-s390/arch/s390/kernel/init_task.c
--- linux-2.5.39/arch/s390/kernel/init_task.c	Fri Sep 27 23:50:21 2002
+++ linux-2.5.39-s390/arch/s390/kernel/init_task.c	Mon Sep 30 13:24:59 2002
@@ -15,7 +15,7 @@
 
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
-static struct signal_struct init_signals = INIT_SIGNALS;
+static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
diff -urN linux-2.5.39/arch/s390/kernel/irq.c linux-2.5.39-s390/arch/s390/kernel/irq.c
--- linux-2.5.39/arch/s390/kernel/irq.c	Fri Sep 27 23:49:55 2002
+++ linux-2.5.39-s390/arch/s390/kernel/irq.c	Thu Jan  1 01:00:00 1970
@@ -1,360 +0,0 @@
-/*
- *  arch/s390/kernel/irq.c
- *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *
- *  Derived from "arch/i386/kernel/irq.c"
- *    Copyright (C) 1992, 1999 Linus Torvalds, Ingo Molnar
- *
- *  S/390 I/O interrupt processing and I/O request processing is
- *   implemented in arch/s390/kernel/s390io.c
- */
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/random.h>
-#include <linux/smp.h>
-#include <linux/threads.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
-#include <linux/seq_file.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/bitops.h>
-#include <asm/smp.h>
-#include <asm/pgtable.h>
-#include <asm/delay.h>
-#include <asm/lowcore.h>
-
-void          s390_init_IRQ   ( void );
-void          s390_free_irq   ( unsigned int irq, void *dev_id);
-int           s390_request_irq( unsigned int irq,
-                     void           (*handler)(int, void *, struct pt_regs *),
-                     unsigned long  irqflags,
-                     const char    *devname,
-                     void          *dev_id);
-
-#if 0
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs), via smp_message_pass():
- */
-BUILD_SMP_INTERRUPT(reschedule_interrupt)
-BUILD_SMP_INTERRUPT(invalidate_interrupt)
-BUILD_SMP_INTERRUPT(stop_cpu_interrupt)
-BUILD_SMP_INTERRUPT(mtrr_interrupt)
-BUILD_SMP_INTERRUPT(spurious_interrupt)
-#endif
-
-int show_interrupts(struct seq_file *p, void *v)
-{
-	int i, j;
-
-	seq_puts(p, "           ");
-
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
-
-	seq_putc(p, '\n');
-
-	for (i = 0 ; i < NR_IRQS ; i++) {
-		if (ioinfo[i] == INVALID_STORAGE_AREA)
-			continue;
-
-		seq_printf(p, "%3d: ",i);
-		seq_printf(p, "  %s", ioinfo[i]->irq_desc.name);
-
-		seq_putc(p, '\n');
-	
-	} /* endfor */
-
-	return 0;
-}
-
-/*
- * Global interrupt locks for SMP. Allow interrupts to come in on any
- * CPU, yet make cli/sti act globally to protect critical regions..
- */
-#ifdef CONFIG_SMP
-atomic_t global_irq_holder = ATOMIC_INIT(NO_PROC_ID);
-atomic_t global_irq_lock = ATOMIC_INIT(0);
-atomic_t global_irq_count = ATOMIC_INIT(0);
-atomic_t global_bh_count;
-
-/*
- * "global_cli()" is a special case, in that it can hold the
- * interrupts disabled for a longish time, and also because
- * we may be doing TLB invalidates when holding the global
- * IRQ lock for historical reasons. Thus we may need to check
- * SMP invalidate events specially by hand here (but not in
- * any normal spinlocks)
- *
- * Thankfully we don't need this as we can deliver flush tlbs with
- * interrupts disabled DJB :-)
- */
-#define check_smp_invalidate(cpu)
-
-extern void show_stack(unsigned long* esp);
-
-static void show(char * str)
-{
-	int cpu = smp_processor_id();
-
-	printk("\n%s, CPU %d:\n", str, cpu);
-	printk("irq:  %d [%d]\n",
-	       atomic_read(&global_irq_count),local_irq_count(smp_processor_id()));
-	printk("bh:   %d [%d]\n",
-	       atomic_read(&global_bh_count),local_bh_count(smp_processor_id()));
-	show_stack(NULL);
-}
-
-#define MAXCOUNT 100000000
-
-static inline void wait_on_bh(void)
-{
-	int count = MAXCOUNT;
-	do {
-		if (!--count) {
-			show("wait_on_bh");
-			count = ~0;
-		}
-		/* nothing .. wait for the other bh's to go away */
-	} while (atomic_read(&global_bh_count) != 0);
-}
-
-static inline void wait_on_irq(int cpu)
-{
-	int count = MAXCOUNT;
-
-	for (;;) {
-
-		/*
-		 * Wait until all interrupts are gone. Wait
-		 * for bottom half handlers unless we're
-		 * already executing in one..
-		 */
-		if (!atomic_read(&global_irq_count)) {
-			if (local_bh_count(cpu)||
-			    !atomic_read(&global_bh_count))
-				break;
-		}
-
-		/* Duh, we have to loop. Release the lock to avoid deadlocks */
-		atomic_set(&global_irq_lock, 0);
-
-		for (;;) {
-			if (!--count) {
-				show("wait_on_irq");
-				count = ~0;
-			}
-			local_irq_enable();
-			SYNC_OTHER_CORES(cpu);
-			local_irq_disable();
-			check_smp_invalidate(cpu);
-			if (atomic_read(&global_irq_count))
-				continue;
-			if (atomic_read(&global_irq_lock))
-				continue;
-			if (!local_bh_count(cpu)
-			    && atomic_read(&global_bh_count))
-				continue;
-			if (!atomic_compare_and_swap(0, 1, &global_irq_lock))
-				 break;
-		}
-	}
-}
-
-/*
- * This is called when we want to synchronize with
- * bottom half handlers. We need to wait until
- * no other CPU is executing any bottom half handler.
- *
- * Don't wait if we're already running in an interrupt
- * context or are inside a bh handler.
- */
-void synchronize_bh(void)
-{
-	if (atomic_read(&global_bh_count) && !in_interrupt())
-		wait_on_bh();
-}
-
-/*
- * This is called when we want to synchronize with
- * interrupts. We may for example tell a device to
- * stop sending interrupts: but to make sure there
- * are no interrupts that are executing on another
- * CPU we need to call this function.
- */
-void synchronize_irq(void)
-{
-	if (atomic_read(&global_irq_count)) {
-		/* Stupid approach */
-		cli();
-		sti();
-	}
-}
-
-static inline void get_irqlock(int cpu)
-{
-	if (atomic_compare_and_swap(0, 1, &global_irq_lock) != 0) {
-		/* do we already hold the lock? */
-		if ( cpu == atomic_read(&global_irq_holder))
-			return;
-		/* Uhhuh.. Somebody else got it. Wait.. */
-		do {
-			check_smp_invalidate(cpu);
-		} while (atomic_compare_and_swap(0, 1, &global_irq_lock) != 0);
-	}
-	/*
-	 * We also to make sure that nobody else is running
-	 * in an interrupt context.
-	 */
-	wait_on_irq(cpu);
-
-	/*
-	 * Ok, finally..
-	 */
-	atomic_set(&global_irq_holder,cpu);
-}
-
-#define EFLAGS_I_SHIFT 25
-
-/*
- * A global "cli()" while in an interrupt context
- * turns into just a local cli(). Interrupts
- * should use spinlocks for the (very unlikely)
- * case that they ever want to protect against
- * each other.
- *
- * If we already have local interrupts disabled,
- * this will not turn a local disable into a
- * global one (problems with spinlocks: this makes
- * save_flags+cli+sti usable inside a spinlock).
- */
-void __global_cli(void)
-{
-	unsigned long flags;
-
-	local_save_flags(flags);
-	if (flags & (1 << EFLAGS_I_SHIFT)) {
-		int cpu = smp_processor_id();
-		local_irq_disable();
-		if (!in_irq())
-			get_irqlock(cpu);
-	}
-}
-
-void __global_sti(void)
-{
-
-	if (!in_irq())
-		release_irqlock(smp_processor_id());
-	local_irq_enable();
-}
-
-/*
- * SMP flags value to restore to:
- * 0 - global cli
- * 1 - global sti
- * 2 - local cli
- * 3 - local sti
- */
-unsigned long __global_save_flags(void)
-{
-	int retval;
-	int local_enabled;
-	unsigned long flags;
-
-	local_save_flags(flags);
-	local_enabled = (flags >> EFLAGS_I_SHIFT) & 1;
-	/* default to local */
-	retval = 2 + local_enabled;
-
-	/* check for global flags if we're not in an interrupt */
-	if (!in_irq())
-	{
-		if (local_enabled)
-			retval = 1;
-		if (atomic_read(&global_irq_holder)== smp_processor_id())
-			retval = 0;
-	}
-	return retval;
-}
-
-void __global_restore_flags(unsigned long flags)
-{
-	switch (flags) {
-	case 0:
-		__global_cli();
-		break;
-	case 1:
-		__global_sti();
-		break;
-	case 2:
-		local_irq_disable();
-		break;
-	case 3:
-		local_irq_enable();
-		break;
-	default:
-		printk("global_restore_flags: %08lx (%08lx)\n",
-		       flags, (&flags)[-1]);
-	}
-}
-
-#endif
-
-
-void __init init_IRQ(void)
-{
-        s390_init_IRQ();
-}
-
-
-void free_irq(unsigned int irq, void *dev_id)
-{
-   s390_free_irq( irq, dev_id);
-}
-
-
-int request_irq( unsigned int   irq,
-                 void           (*handler)(int, void *, struct pt_regs *),
-                 unsigned long  irqflags,
-                 const char    *devname,
-                 void          *dev_id)
-{
-   return( s390_request_irq( irq, handler, irqflags, devname, dev_id ) );
-
-}
-
-void init_irq_proc(void)
-{
-        /* For now, nothing... */
-}
-
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(__global_cli);
-EXPORT_SYMBOL(__global_sti);
-EXPORT_SYMBOL(__global_save_flags);
-EXPORT_SYMBOL(__global_restore_flags);
-EXPORT_SYMBOL(global_irq_holder);
-EXPORT_SYMBOL(global_irq_lock);
-EXPORT_SYMBOL(global_irq_count);
-EXPORT_SYMBOL(global_bh_count);
-#endif
-
-EXPORT_SYMBOL(global_bh_lock);
diff -urN linux-2.5.39/arch/s390/kernel/process.c linux-2.5.39-s390/arch/s390/kernel/process.c
--- linux-2.5.39/arch/s390/kernel/process.c	Fri Sep 27 23:50:27 2002
+++ linux-2.5.39-s390/arch/s390/kernel/process.c	Mon Sep 30 13:25:16 2002
@@ -15,9 +15,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
-#include <stdarg.h>
-
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -121,31 +118,35 @@
 		show_trace((unsigned long *) regs->gprs[15]);
 }
 
+extern void kernel_thread_starter(void);
+__asm__(".align 4\n"
+	"kernel_thread_starter:\n"
+	"    l     15,0(8)\n"
+	"    sr    15,7\n"
+	"    stosm 24(15),3\n"
+	"    lr    2,10\n"
+	"    basr  14,9\n"
+	"    sr    2,2\n"
+	"    br    11\n");
+
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
-        int retval;
+	struct task_struct *p;
+	struct pt_regs regs;
 
-        __asm__ __volatile__(
-                "     sr    2,2\n"
-                "     lr    3,%1\n"
-                "     l     4,%6\n"     /* load kernel stack ptr of parent */
-                "     svc   %b2\n"                     /* Linux system call*/
-                "     cl    4,%6\n"    /* compare ksp's: child or parent ? */
-                "     je    0f\n"                          /* parent - jump*/
-                "     l     15,%6\n"            /* fix kernel stack pointer*/
-                "     ahi   15,%7\n"
-                "     xc    0(96,15),0(15)\n"           /* clear save area */
-                "     lr    2,%4\n"                        /* load argument*/
-                "     lr    14,%5\n"                      /* get fn-pointer*/
-                "     basr  14,14\n"                             /* call fn*/
-                "     svc   %b3\n"                     /* Linux system call*/
-                "0:   lr    %0,2"
-                : "=a" (retval)
-                : "d" (clone_arg), "i" (__NR_clone), "i" (__NR_exit),
-                  "d" (arg), "d" (fn), "i" (__LC_KERNEL_STACK) , "i" (-STACK_FRAME_OVERHEAD)
-                : "2", "3", "4" );
-        return retval;
+	memset(&regs, 0, sizeof(regs));
+	regs.psw.mask = _SVC_PSW_MASK;
+	regs.psw.addr = (__u32) kernel_thread_starter | _ADDR_31;
+	regs.gprs[7] = STACK_FRAME_OVERHEAD;
+	regs.gprs[8] = __LC_KERNEL_STACK;
+	regs.gprs[9] = (unsigned long) fn;
+	regs.gprs[10] = (unsigned long) arg;
+	regs.gprs[11] = (unsigned long) do_exit;
+	regs.orig_gpr2 = -1;
+
+	/* Ok, create the new process.. */
+	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -186,12 +187,13 @@
         frame = ((struct stack_frame *)
 		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
         p->thread.ksp = (unsigned long) frame;
-        memcpy(&frame->childregs,regs,sizeof(struct pt_regs));
+        frame->childregs = *regs;
+	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
         frame->childregs.gprs[15] = new_stackp;
         frame->back_chain = frame->eos = 0;
 
-        /* new return point is ret_from_sys_call */
-        frame->gprs[8] = ((unsigned long) &ret_from_fork) | 0x80000000;
+        /* new return point is ret_from_fork */
+        frame->gprs[8] = (unsigned long) ret_from_fork;
 	/* start disabled because of schedule_tick and rq->lock being held */
 	frame->childregs.psw.mask &= ~0x03000000;
 
@@ -200,6 +202,8 @@
         /* save fprs, if used in last task */
 	save_fp_regs(&p->thread.fp_regs);
         p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _SEGMENT_TABLE;
+	/* start process with ar4 pointing to the correct address space */
+	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
         return 0;
@@ -208,7 +212,7 @@
 asmlinkage int sys_fork(struct pt_regs regs)
 {
 	struct task_struct *p;
-        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -217,12 +221,14 @@
         unsigned long clone_flags;
         unsigned long newsp;
 	struct task_struct *p;
+	int *user_tid;
 
         clone_flags = regs.gprs[3];
         newsp = regs.orig_gpr2;
+	user_tid = (int *) regs.gprs[4];
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -239,7 +245,8 @@
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
 	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.gprs[15], &regs, 0);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		    regs.gprs[15], &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -urN linux-2.5.39/arch/s390/kernel/setup.c linux-2.5.39-s390/arch/s390/kernel/setup.c
--- linux-2.5.39/arch/s390/kernel/setup.c	Fri Sep 27 23:49:05 2002
+++ linux-2.5.39-s390/arch/s390/kernel/setup.c	Mon Sep 30 13:24:59 2002
@@ -524,7 +524,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
 			       "bogomips per cpu: %lu.%02lu\n",
-			       smp_num_cpus, loops_per_jiffy/(500000/HZ),
+			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.39/arch/s390/kernel/smp.c linux-2.5.39-s390/arch/s390/kernel/smp.c
--- linux-2.5.39/arch/s390/kernel/smp.c	Fri Sep 27 23:48:35 2002
+++ linux-2.5.39-s390/arch/s390/kernel/smp.c	Mon Sep 30 13:24:59 2002
@@ -47,45 +47,16 @@
 /*
  * An array with a pointer the lowcore of every CPU.
  */
-static int       max_cpus = NR_CPUS;	  /* Setup configured maximum number of CPUs to activate	*/
-int              smp_num_cpus;
+
 struct _lowcore *lowcore_ptr[NR_CPUS];
 cycles_t         cacheflush_time=0;
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
-static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-volatile unsigned long phys_cpu_present_map;
 volatile unsigned long cpu_online_map;
+volatile unsigned long cpu_possible_map;
 unsigned long    cache_decay_ticks = 0;
 
 /*
- *      Setup routine for controlling SMP activation
- *
- *      Command-line option of "nosmp" or "maxcpus=0" will disable SMP
- *      activation entirely (the MPS table probe still happens, though).
- *
- *      Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
- *      greater than 0, limits the maximum number of CPUs activated in
- *      SMP mode to <NUM>.
- */
-
-static int __init nosmp(char *str)
-{
-	max_cpus = 0;
-	return 1;
-}
-
-__setup("nosmp", nosmp);
-
-static int __init maxcpus(char *str)
-{
-	get_option(&str, &max_cpus);
-	return 1;
-}
-
-__setup("maxcpus=", maxcpus);
-
-/*
  * Reboot, halt and power_off routines for SMP.
  */
 extern char vmhalt_cmd[];
@@ -148,9 +119,10 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
-	if (!cpus || !atomic_read(&smp_commenced))
+	/* FIXME: get cpu lock -hc */
+	if (cpus <= 0)
 		return 0;
 
 	data.func = func;
@@ -183,8 +155,8 @@
         int i, rc;
 
         /* stop all processors */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		do {
 			rc = signal_processor_ps(&dummy, 0, i, sigp_stop);
@@ -199,8 +171,8 @@
         int i, rc;
 
         /* store status of all processors in their lowcores (real 0) */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		low_core_addr = (unsigned long)get_cpu_lowcore(i);
 		do {
@@ -345,8 +317,8 @@
         struct _lowcore *lowcore;
         int i;
 
-        for (i = 0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i = 0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
                 lowcore = get_cpu_lowcore(i);
                 /*
@@ -425,13 +397,11 @@
 void smp_ctl_set_bit(int cr, int bit) {
         ec_creg_mask_parms parms;
 
-        if (atomic_read(&smp_commenced) != 0) {
-                parms.start_ctl = cr;
-                parms.end_ctl = cr;
-                parms.orvals[cr] = 1 << bit;
-                parms.andvals[cr] = 0xFFFFFFFF;
-                smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
-        }
+	parms.start_ctl = cr;
+	parms.end_ctl = cr;
+	parms.orvals[cr] = 1 << bit;
+	parms.andvals[cr] = 0xFFFFFFFF;
+	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_set_bit(cr, bit);
 }
 
@@ -441,13 +411,11 @@
 void smp_ctl_clear_bit(int cr, int bit) {
         ec_creg_mask_parms parms;
 
-        if (atomic_read(&smp_commenced) != 0) {
-                parms.start_ctl = cr;
-                parms.end_ctl = cr;
-                parms.orvals[cr] = 0x00000000;
-                parms.andvals[cr] = ~(1 << bit);
-                smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
-        }
+	parms.start_ctl = cr;
+	parms.end_ctl = cr;
+	parms.orvals[cr] = 0x00000000;
+	parms.andvals[cr] = ~(1 << bit);
+	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_clear_bit(cr, bit);
 }
 
@@ -455,30 +423,30 @@
  * Lets check how many CPUs we have.
  */
 
-void smp_count_cpus(void)
+void __init smp_check_cpus(unsigned int max_cpus)
 {
-        int curr_cpu;
+        int curr_cpu, num_cpus;
 
+	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         current_thread_info()->cpu = 0;
-        smp_num_cpus = 1;
-	phys_cpu_present_map = 1;
+        num_cpus = 1;
+	cpu_possible_map = 1;
 	cpu_online_map = 1;
         for (curr_cpu = 0;
-             curr_cpu <= 65535 && smp_num_cpus < max_cpus; curr_cpu++) {
+             curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
                 if ((__u16) curr_cpu == boot_cpu_addr)
                         continue;
-                __cpu_logical_map[smp_num_cpus] = (__u16) curr_cpu;
-                if (signal_processor(smp_num_cpus, sigp_sense) ==
+                __cpu_logical_map[num_cpus] = (__u16) curr_cpu;
+                if (signal_processor(num_cpus, sigp_sense) ==
                     sigp_not_operational)
                         continue;
-		set_bit(smp_num_cpus, &phys_cpu_present_map);
-                smp_num_cpus++;
+		set_bit(num_cpus, &cpu_possible_map);
+                num_cpus++;
         }
-        printk("Detected %d CPU's\n",(int) smp_num_cpus);
+        printk("Detected %d CPU's\n",(int) num_cpus);
         printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
 
-
 /*
  *      Activate a secondary processor.
  */
@@ -490,19 +458,18 @@
 {
         /* Setup the cpu */
         cpu_init();
-	/* Mark this cpu as online */
-	set_bit(smp_processor_id(), &cpu_online_map);
-        /* Print info about this processor */
-        print_cpu_info(&safe_get_cpu_lowcore(smp_processor_id())->cpu_data);
-        /* Wait for completion of smp startup */
-        while (!atomic_read(&smp_commenced))
-                /* nothing */ ;
         /* init per CPU timer */
         init_cpu_timer();
 #ifdef CONFIG_PFAULT
 	/* Enable pfault pseudo page faults on this cpu. */
 	pfault_init();
 #endif
+	/* Mark this cpu as online */
+	set_bit(smp_processor_id(), &cpu_online_map);
+	/* Switch on interrupts */
+	local_irq_enable();
+        /* Print info about this processor */
+        print_cpu_info(&S390_lowcore.cpu_data);
         /* cpu_idle will call schedule for us */
         return cpu_idle(NULL);
 }
@@ -513,19 +480,36 @@
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
-static void __init do_boot_cpu(int cpu)
+int __cpu_up(unsigned int cpu)
 {
         struct task_struct *idle;
         struct _lowcore    *cpu_lowcore;
+        sigp_ccode          ccode;
+
+	/*
+	 *  Set prefix page for new cpu
+	 */
+
+	ccode = signal_processor_p((u32)(lowcore_ptr[cpu]),
+				   cpu, sigp_set_prefix);
+	if (ccode){
+		printk("sigp_set_prefix failed for cpu %d "
+		       "with condition code %d\n",
+		       (int) cpu, (int) ccode);
+		return -EIO;
+	}
+
 
         /* We can't use kernel_thread since we must _avoid_ to reschedule
            the child. */
         idle = fork_by_hand();
-	if (IS_ERR(idle))
-                panic("failed fork for CPU %d", cpu);
+	if (IS_ERR(idle)){
+                printk("failed fork for CPU %d", cpu);
+		return -EIO;
+	}
 
         /*
          * We remove it from the pidhash and the runqueue
@@ -537,7 +521,7 @@
 
         cpu_lowcore = get_cpu_lowcore(cpu);
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
-	cpu_lowcore->kernel_stack = (__u32) idle->thread_info + 8192;
+	cpu_lowcore->kernel_stack = (__u32) idle->thread_info + (2*PAGE_SIZE);
         __asm__ __volatile__("la    1,%0\n\t"
 			     "stctl 0,15,0(1)\n\t"
 			     "la    1,%1\n\t"
@@ -548,48 +532,34 @@
 
         eieio();
         signal_processor(cpu,sigp_restart);
-}
-
-/*
- *      Architecture specific routine called by the kernel just before init is
- *      fired off. This allows the BP to have everything in order [we hope].
- *      At the end of this all the APs will hit the system scheduling and off
- *      we go. Each AP will load the system gdt's and jump through the kernel
- *      init into idle(). At this point the scheduler will one day take over
- *      and give them jobs to do. smp_callin is a standard routine
- *      we use to track CPUs as they power up.
- */
 
-void __init smp_commence(void)
-{
-        /*
-         *      Lets the callins below out of their loop.
-         */
-        atomic_set(&smp_commenced,1);
+	while (!cpu_online(cpu));
+	return 0;
 }
 
 /*
- *	Cycle through the processors sending sigp_restart to boot each.
+ *	Cycle through the processors and setup structures.
  */
 
-void __init smp_boot_cpus(void)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned long async_stack;
-        sigp_ccode   ccode;
         int i;
 
         /* request the 0x1202 external interrupt */
         if (register_external_interrupt(0x1202, do_ext_call_interrupt) != 0)
                 panic("Couldn't request external interrupt 0x1202");
-        smp_count_cpus();
+        smp_check_cpus(max_cpus);
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
-        
+
         /*
-         *      Initialize the logical to physical CPU number mapping
+         *  Initialize prefix pages and stacks for all possible cpus
          */
         print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
 
-        for(i = 0; i < smp_num_cpus; i++) {
+        for(i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
 		lowcore_ptr[i] = (struct _lowcore *)
 			__get_free_page(GFP_KERNEL|GFP_DMA);
 		async_stack = __get_free_pages(GFP_KERNEL,1);
@@ -598,26 +568,12 @@
 
                 memcpy(lowcore_ptr[i], &S390_lowcore, sizeof(struct _lowcore));
 		lowcore_ptr[i]->async_stack = async_stack + (2 * PAGE_SIZE);
-                /*
-                 * Most of the parameters are set up when the cpu is
-                 * started up.
-                 */
-		if (smp_processor_id() == i) {
-			set_prefix((u32) lowcore_ptr[i]);
-			continue;
-		}
-		ccode = signal_processor_p((u32)(lowcore_ptr[i]),
-					   i, sigp_set_prefix);
-		if (ccode)
-			panic("sigp_set_prefix failed for cpu %d "
-			      "with condition code %d\n",
-			      (int) i, (int) ccode);
-		do_boot_cpu(i);
 	}
-	/*
-	 * Now wait until all of the cpus are online.
-	 */
-	while (phys_cpu_present_map != cpu_online_map);
+	set_prefix((u32) lowcore_ptr[smp_processor_id()]);
+}
+
+void smp_cpus_done(unsigned int max_cpus)
+{
 }
 
 /*
@@ -634,5 +590,4 @@
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
diff -urN linux-2.5.39/arch/s390/kernel/time.c linux-2.5.39-s390/arch/s390/kernel/time.c
--- linux-2.5.39/arch/s390/kernel/time.c	Fri Sep 27 23:48:35 2002
+++ linux-2.5.39-s390/arch/s390/kernel/time.c	Mon Sep 30 13:24:59 2002
@@ -27,6 +27,7 @@
 #include <asm/uaccess.h>
 #include <asm/delay.h>
 #include <asm/s390_ext.h>
+#include <asm/div64.h>
 
 #include <linux/timex.h>
 #include <linux/config.h>
@@ -47,45 +48,22 @@
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
-void tod_to_timeval(__u64 todval, struct timeval *xtime)
+void tod_to_timeval(__u64 todval, struct timespec *xtime)
 {
-        const int high_bit = 0x80000000L;
-        const int c_f4240 = 0xf4240L;
-        const int c_7a120 = 0x7a120;
-	/* We have to divide the 64 bit value todval by 4096
-	 * (because the 2^12 bit is the one that changes every 
-         * microsecond) and then split it into seconds and
-         * microseconds. A value of max (2^52-1) divided by
-         * the value 0xF4240 can yield a max result of approx
-         * (2^32.068). Thats to big to fit into a signed int
-	 *   ... hacking time!
-         */
-	asm volatile ("L     2,%1\n\t"
-		      "LR    3,2\n\t"
-		      "SRL   2,12\n\t"
-		      "SLL   3,20\n\t"
-		      "L     4,%O1+4(%R1)\n\t"
-		      "SRL   4,12\n\t"
-		      "OR    3,4\n\t"  /* now R2/R3 contain (todval >> 12) */
-		      "SR    4,4\n\t"
-		      "CL    2,%2\n\t"
-		      "JL    .+12\n\t"
-		      "S     2,%2\n\t"
-		      "L     4,%3\n\t"
-                      "D     2,%4\n\t"
-		      "OR    3,4\n\t"
-		      "ST    2,%O0+4(%R0)\n\t"
-		      "ST    3,%0"
-		      : "=m" (*xtime) : "m" (todval),
-		        "m" (c_7a120), "m" (high_bit), "m" (c_f4240)
-		      : "cc", "memory", "2", "3", "4" );
+	unsigned long long sec;
+
+	sec = todval >> 12;
+	do_div(sec, 1000000);
+	xtime->tv_sec = sec;
+	todval -= (sec * 1000000) << 12;
+	xtime->tv_nsec = ((todval * 1000) >> 12);
 }
 
 static inline unsigned long do_gettimeoffset(void) 
 {
 	__u64 now;
 
-	asm ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
+	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
         now = (now - init_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
@@ -102,7 +80,7 @@
 
 	read_lock_irqsave(&xtime_lock, flags);
 	sec = xtime.tv_sec;
-	usec = xtime.tv_usec + do_gettimeoffset();
+	usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
 	read_unlock_irqrestore(&xtime_lock, flags);
 
 	while (usec >= 1000000) {
@@ -118,7 +96,7 @@
 {
 
 	write_lock_irq(&xtime_lock);
-	/* This is revolting. We need to set the xtime.tv_usec
+	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
 	 * Discover what correction gettimeofday
@@ -131,7 +109,8 @@
 		tv->tv_sec--;
 	}
 
-	xtime = *tv;
+	xtime.tv_sec = tv->tv_sec;
+	xtime.tv_nsec = tv->tv_usec * 1000;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -152,7 +131,7 @@
 {
 	int cpu = smp_processor_id();
 
-	irq_enter(cpu, 0);
+	irq_enter();
 
 	/*
 	 * set clock comparator for next tick
@@ -174,7 +153,7 @@
 	do_timer(regs);
 #endif
 
-	irq_exit(cpu, 0);
+	irq_exit();
 }
 
 /*
diff -urN linux-2.5.39/arch/s390/kernel/traps.c linux-2.5.39-s390/arch/s390/kernel/traps.c
--- linux-2.5.39/arch/s390/kernel/traps.c	Fri Sep 27 23:49:43 2002
+++ linux-2.5.39-s390/arch/s390/kernel/traps.c	Mon Sep 30 13:24:59 2002
@@ -170,6 +170,14 @@
 	show_trace(sp);
 }
 
+/*
+ * The architecture-independent dump_stack generator
+ */
+void dump_stack(void)
+{
+	show_stack(0);
+}
+
 void show_registers(struct pt_regs *regs)
 {
 	mm_segment_t old_fs;
diff -urN linux-2.5.39/arch/s390x/kernel/Makefile linux-2.5.39-s390/arch/s390x/kernel/Makefile
--- linux-2.5.39/arch/s390x/kernel/Makefile	Fri Sep 27 23:49:45 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/Makefile	Mon Sep 30 13:24:59 2002
@@ -5,10 +5,10 @@
 EXTRA_TARGETS	:= head.o init_task.o
 EXTRA_AFLAGS	:= -traditional
 
-export-objs	:= debug.o ebcdic.o irq.o s390_ext.o smp.o s390_ksyms.o \
+export-objs	:= debug.o ebcdic.o s390_ext.o smp.o s390_ksyms.o \
 		   exec32.o
 
-obj-y		:= entry.o bitmap.o traps.o time.o process.o irq.o \
+obj-y		:= entry.o bitmap.o traps.o time.o process.o \
 		   setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 		   semaphore.o s390fpu.o reipl.o s390_ext.o debug.o
 
diff -urN linux-2.5.39/arch/s390x/kernel/entry.S linux-2.5.39-s390/arch/s390x/kernel/entry.S
--- linux-2.5.39/arch/s390x/kernel/entry.S	Fri Sep 27 23:49:16 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/entry.S	Mon Sep 30 13:24:59 2002
@@ -551,8 +551,8 @@
         .long  SYSCALL(sys_rt_sigtimedwait,sys32_rt_sigtimedwait_wrapper)
         .long  SYSCALL(sys_rt_sigqueueinfo,sys32_rt_sigqueueinfo_wrapper)
         .long  SYSCALL(sys_rt_sigsuspend_glue,sys32_rt_sigsuspend_glue)
-        .long  SYSCALL(sys_pread,sys32_pread_wrapper)           /* 180 */
-        .long  SYSCALL(sys_pwrite,sys32_pwrite_wrapper)
+        .long  SYSCALL(sys_pread64,sys32_pread_wrapper)           /* 180 */
+        .long  SYSCALL(sys_pwrite64,sys32_pwrite_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_chown16_wrapper)    /* old chown16 syscall */
         .long  SYSCALL(sys_getcwd,sys32_getcwd_wrapper)
         .long  SYSCALL(sys_capget,sys32_capget_wrapper)
diff -urN linux-2.5.39/arch/s390x/kernel/head.S linux-2.5.39-s390/arch/s390x/kernel/head.S
--- linux-2.5.39/arch/s390x/kernel/head.S	Fri Sep 27 23:49:06 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/head.S	Mon Sep 30 13:25:16 2002
@@ -645,5 +645,5 @@
 #
             .align 8
 .Ldw:       .quad  0x0002000180000000,0x0000000000000000
-.Laregs:    .long  0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
+.Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 
diff -urN linux-2.5.39/arch/s390x/kernel/init_task.c linux-2.5.39-s390/arch/s390x/kernel/init_task.c
--- linux-2.5.39/arch/s390x/kernel/init_task.c	Fri Sep 27 23:49:44 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/init_task.c	Mon Sep 30 13:24:59 2002
@@ -15,7 +15,7 @@
 
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
-static struct signal_struct init_signals = INIT_SIGNALS;
+static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
diff -urN linux-2.5.39/arch/s390x/kernel/irq.c linux-2.5.39-s390/arch/s390x/kernel/irq.c
--- linux-2.5.39/arch/s390x/kernel/irq.c	Fri Sep 27 23:50:58 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/irq.c	Thu Jan  1 01:00:00 1970
@@ -1,361 +0,0 @@
-/*
- *  arch/s390/kernel/irq.c
- *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *
- *  Derived from "arch/i386/kernel/irq.c"
- *    Copyright (C) 1992, 1999 Linus Torvalds, Ingo Molnar
- *
- *  S/390 I/O interrupt processing and I/O request processing is
- *   implemented in arch/s390/kernel/s390io.c
- */
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/random.h>
-#include <linux/smp.h>
-#include <linux/threads.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
-#include <linux/seq_file.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/bitops.h>
-#include <asm/smp.h>
-#include <asm/pgtable.h>
-#include <asm/delay.h>
-#include <asm/lowcore.h>
-
-void          s390_init_IRQ   ( void );
-void          s390_free_irq   ( unsigned int irq, void *dev_id);
-int           s390_request_irq( unsigned int irq,
-                     void           (*handler)(int, void *, struct pt_regs *),
-                     unsigned long  irqflags,
-                     const char    *devname,
-                     void          *dev_id);
-
-#if 0
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs), via smp_message_pass():
- */
-BUILD_SMP_INTERRUPT(reschedule_interrupt)
-BUILD_SMP_INTERRUPT(invalidate_interrupt)
-BUILD_SMP_INTERRUPT(stop_cpu_interrupt)
-BUILD_SMP_INTERRUPT(mtrr_interrupt)
-BUILD_SMP_INTERRUPT(spurious_interrupt)
-#endif
-
-int show_interrupts(struct seq_file *p, void *v)
-{
-	int i, j;
-
-	seq_puts(p, "           ");
-
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
-
-	seq_putc(p, '\n');
-
-	for (i = 0 ; i < NR_IRQS ; i++)
-	{
-		if (ioinfo[i] == INVALID_STORAGE_AREA)
-			continue;
-
-		seq_printf(p, "%3d: ",i);
-		seq_printf(p, "  %s", ioinfo[i]->irq_desc.name);
-
-		seq_putc(p, '\n');
-	
-	} /* endfor */
-
-	return 0;
-}
-
-/*
- * Global interrupt locks for SMP. Allow interrupts to come in on any
- * CPU, yet make cli/sti act globally to protect critical regions..
- */
-#ifdef CONFIG_SMP
-atomic_t global_irq_holder = ATOMIC_INIT(NO_PROC_ID);
-atomic_t global_irq_lock = ATOMIC_INIT(0);
-atomic_t global_irq_count = ATOMIC_INIT(0);
-atomic_t global_bh_count;
-
-/*
- * "global_cli()" is a special case, in that it can hold the
- * interrupts disabled for a longish time, and also because
- * we may be doing TLB invalidates when holding the global
- * IRQ lock for historical reasons. Thus we may need to check
- * SMP invalidate events specially by hand here (but not in
- * any normal spinlocks)
- *
- * Thankfully we don't need this as we can deliver flush tlbs with
- * interrupts disabled DJB :-)
- */
-#define check_smp_invalidate(cpu)
-
-extern void show_stack(unsigned long* esp);
-
-static void show(char * str)
-{
-	int cpu = smp_processor_id();
-
-	printk("\n%s, CPU %d:\n", str, cpu);
-	printk("irq:  %d [%d]\n",
-	       atomic_read(&global_irq_count),local_irq_count(smp_processor_id()));
-	printk("bh:   %d [%d]\n",
-	       atomic_read(&global_bh_count),local_bh_count(smp_processor_id()));
-	show_stack(NULL);
-}
-
-#define MAXCOUNT 100000000
-
-static inline void wait_on_bh(void)
-{
-	int count = MAXCOUNT;
-	do {
-		if (!--count) {
-			show("wait_on_bh");
-			count = ~0;
-		}
-		/* nothing .. wait for the other bh's to go away */
-	} while (atomic_read(&global_bh_count) != 0);
-}
-
-static inline void wait_on_irq(int cpu)
-{
-	int count = MAXCOUNT;
-
-	for (;;) {
-
-		/*
-		 * Wait until all interrupts are gone. Wait
-		 * for bottom half handlers unless we're
-		 * already executing in one..
-		 */
-		if (!atomic_read(&global_irq_count)) {
-			if (local_bh_count(cpu)||
-			    !atomic_read(&global_bh_count))
-				break;
-		}
-
-		/* Duh, we have to loop. Release the lock to avoid deadlocks */
-                atomic_set(&global_irq_lock, 0);
-
-		for (;;) {
-			if (!--count) {
-				show("wait_on_irq");
-				count = ~0;
-			}
-			local_irq_enable();
-			SYNC_OTHER_CORES(cpu);
-			local_irq_disable();
-			check_smp_invalidate(cpu);
-			if (atomic_read(&global_irq_count))
-				continue;
-			if (atomic_read(&global_irq_lock))
-				continue;
-			if (!local_bh_count(cpu)
-			    && atomic_read(&global_bh_count))
-				continue;
-                        if (!atomic_compare_and_swap(0, 1, &global_irq_lock))
-				break;
-		}
-	}
-}
-
-/*
- * This is called when we want to synchronize with
- * bottom half handlers. We need to wait until
- * no other CPU is executing any bottom half handler.
- *
- * Don't wait if we're already running in an interrupt
- * context or are inside a bh handler.
- */
-void synchronize_bh(void)
-{
-	if (atomic_read(&global_bh_count) && !in_interrupt())
-		wait_on_bh();
-}
-
-/*
- * This is called when we want to synchronize with
- * interrupts. We may for example tell a device to
- * stop sending interrupts: but to make sure there
- * are no interrupts that are executing on another
- * CPU we need to call this function.
- */
-void synchronize_irq(void)
-{
-	if (atomic_read(&global_irq_count)) {
-		/* Stupid approach */
-		cli();
-		sti();
-	}
-}
-
-static inline void get_irqlock(int cpu)
-{
-	if (atomic_compare_and_swap(0,1,&global_irq_lock) != 0) {
-		/* do we already hold the lock? */
-		if ( cpu == atomic_read(&global_irq_holder))
-			return;
-		/* Uhhuh.. Somebody else got it. Wait.. */
-		do {
-			check_smp_invalidate(cpu);
-		} while (atomic_compare_and_swap(0,1,&global_irq_lock) != 0);
-	}
-	/*
-	 * We also to make sure that nobody else is running
-	 * in an interrupt context.
-	 */
-	wait_on_irq(cpu);
-
-	/*
-	 * Ok, finally..
-	 */
-	atomic_set(&global_irq_holder,cpu);
-}
-
-#define EFLAGS_I_SHIFT 57
-
-/*
- * A global "cli()" while in an interrupt context
- * turns into just a local cli(). Interrupts
- * should use spinlocks for the (very unlikely)
- * case that they ever want to protect against
- * each other.
- *
- * If we already have local interrupts disabled,
- * this will not turn a local disable into a
- * global one (problems with spinlocks: this makes
- * save_flags+cli+sti usable inside a spinlock).
- */
-void __global_cli(void)
-{
-	unsigned long flags;
-
-	local_save_flags(flags);
-	if (flags & (1UL << EFLAGS_I_SHIFT)) {
-		int cpu = smp_processor_id();
-		local_irq_disable();
-		if (!in_irq())
-			get_irqlock(cpu);
-	}
-}
-
-void __global_sti(void)
-{
-
-	if (!in_irq())
-		release_irqlock(smp_processor_id());
-	local_irq_enable();
-}
-
-/*
- * SMP flags value to restore to:
- * 0 - global cli
- * 1 - global sti
- * 2 - local cli
- * 3 - local sti
- */
-unsigned long __global_save_flags(void)
-{
-	int retval;
-	int local_enabled;
-	unsigned long flags;
-
-	local_save_flags(flags);
-	local_enabled = (flags >> EFLAGS_I_SHIFT) & 1;
-	/* default to local */
-	retval = 2 + local_enabled;
-
-	/* check for global flags if we're not in an interrupt */
-	if (!in_irq())
-	{
-		if (local_enabled)
-			retval = 1;
-		if (atomic_read(&global_irq_holder)== smp_processor_id())
-			retval = 0;
-	}
-	return retval;
-}
-
-void __global_restore_flags(unsigned long flags)
-{
-	switch (flags) {
-	case 0:
-		__global_cli();
-		break;
-	case 1:
-		__global_sti();
-		break;
-	case 2:
-		local_irq_disable();
-		break;
-	case 3:
-		local_irq_enable();
-		break;
-	default:
-		printk("global_restore_flags: %08lx (%08lx)\n",
-		       flags, (&flags)[-1]);
-	}
-}
-
-#endif
-
-
-void __init init_IRQ(void)
-{
-   s390_init_IRQ();
-}
-
-
-void free_irq(unsigned int irq, void *dev_id)
-{
-   s390_free_irq( irq, dev_id);
-}
-
-
-int request_irq( unsigned int   irq,
-                 void           (*handler)(int, void *, struct pt_regs *),
-                 unsigned long  irqflags,
-                 const char    *devname,
-                 void          *dev_id)
-{
-   return( s390_request_irq( irq, handler, irqflags, devname, dev_id ) );
-
-}
-
-void init_irq_proc(void)
-{
-        /* For now, nothing... */
-}
-
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(__global_cli);
-EXPORT_SYMBOL(__global_sti);
-EXPORT_SYMBOL(__global_save_flags);
-EXPORT_SYMBOL(__global_restore_flags);
-EXPORT_SYMBOL(global_irq_holder);
-EXPORT_SYMBOL(global_irq_lock);
-EXPORT_SYMBOL(global_irq_count);
-EXPORT_SYMBOL(global_bh_count);
-#endif
-
-EXPORT_SYMBOL(global_bh_lock);
diff -urN linux-2.5.39/arch/s390x/kernel/linux32.c linux-2.5.39-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.39/arch/s390x/kernel/linux32.c	Fri Sep 27 23:49:14 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/linux32.c	Mon Sep 30 13:24:59 2002
@@ -1953,15 +1953,19 @@
 			return -EINVAL;
 	}
 
-	spin_lock_irq(&current->sigmask_lock);
-	sig = dequeue_signal(&these, &info);
+	spin_lock_irq(&current->sig->siglock);
+	spin_lock(&current->sigmask_lock);
+	sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
+	if (!sig)
+		sig = dequeue_signal(&current->pending, &these, &info);
 	if (!sig) {
 		/* None ready -- temporarily unblock those we're interested
 		   in so that we'll be awakened when they arrive.  */
-		sigset_t oldblocked = current->blocked;
+		current->real_blocked = current->blocked;
 		sigandsets(&current->blocked, &current->blocked, &these);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 		timeout = MAX_SCHEDULE_TIMEOUT;
 		if (uts)
@@ -1971,12 +1975,17 @@
 		current->state = TASK_INTERRUPTIBLE;
 		timeout = schedule_timeout(timeout);
 
-		spin_lock_irq(&current->sigmask_lock);
-		sig = dequeue_signal(&these, &info);
-		current->blocked = oldblocked;
+		spin_lock_irq(&current->sig->siglock);
+		spin_lock(&current->sigmask_lock);
+		sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
+		if (!sig)
+			sig = dequeue_signal(&current->pending, &these, &info);
+		current->blocked = current->real_blocked;
+		siginitset(&current->real_blocked, 0);
 		recalc_sigpending();
 	}
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	if (sig) {
 		ret = sig;
diff -urN linux-2.5.39/arch/s390x/kernel/process.c linux-2.5.39-s390/arch/s390x/kernel/process.c
--- linux-2.5.39/arch/s390x/kernel/process.c	Fri Sep 27 23:49:14 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/process.c	Mon Sep 30 13:25:16 2002
@@ -15,9 +15,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
-#include <stdarg.h>
-
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -118,31 +115,35 @@
 		show_trace((unsigned long *) regs->gprs[15]);
 }
 
+extern void kernel_thread_starter(void);
+__asm__(".align 4\n"
+	"kernel_thread_starter:\n"
+	"    lg    15,0(8)\n"
+	"    sgr   15,7\n"
+	"    stosm 48(15),3\n"
+	"    lgr   2,10\n"
+	"    basr  14,9\n"
+	"    sgr   2,2\n"
+	"    br    11\n");
+
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
-        int retval;
+	struct task_struct *p;
+	struct pt_regs regs;
 
-        __asm__ __volatile__(
-                "     slgr  2,2\n"
-                "     lgr   3,%1\n"
-                "     lg    4,%6\n"     /* load kernel stack ptr of parent */
-                "     svc   %b2\n"                     /* Linux system call*/
-                "     clg   4,%6\n"    /* compare ksp's: child or parent ? */
-                "     je    0f\n"                          /* parent - jump*/
-                "     lg    15,%6\n"            /* fix kernel stack pointer*/
-                "     aghi  15,%7\n"
-                "     xc    0(160,15),0(15)\n"          /* clear save area */
-                "     lgr   2,%4\n"                        /* load argument*/
-                "     basr  14,%5\n"                             /* call fn*/
-                "     svc   %b3\n"                     /* Linux system call*/
-                "0:   lgr   %0,2"
-                : "=a" (retval)
-                : "d" (clone_arg), "i" (__NR_clone), "i" (__NR_exit),
-                  "d" (arg), "a" (fn), "i" (__LC_KERNEL_STACK) ,
-                  "i" (-STACK_FRAME_OVERHEAD)
-                : "2", "3", "4" );
-        return retval;
+	memset(&regs, 0, sizeof(regs));
+	regs.psw.mask = _SVC_PSW_MASK;
+	regs.psw.addr = (__u64) kernel_thread_starter;
+	regs.gprs[7] = STACK_FRAME_OVERHEAD;
+	regs.gprs[8] = __LC_KERNEL_STACK;
+	regs.gprs[9] = (unsigned long) fn;
+	regs.gprs[10] = (unsigned long) arg;
+	regs.gprs[11] = (unsigned long) do_exit;
+	regs.orig_gpr2 = -1;
+
+	/* Ok, create the new process.. */
+	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -184,17 +185,20 @@
 		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
         p->thread.ksp = (unsigned long) frame;
         frame->childregs = *regs;
+	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
         frame->childregs.gprs[15] = new_stackp;
         frame->back_chain = frame->eos = 0;
 
-        /* new return point is ret_from_sys_call */
-        frame->gprs[8] = (unsigned long) &ret_from_fork;
+        /* new return point is ret_from_fork */
+        frame->gprs[8] = (unsigned long) ret_from_fork;
 
         /* fake return stack for resume(), don't go back to schedule */
         frame->gprs[9] = (unsigned long) frame;
-        /* save fprs, if used in last task */
+        /* save fprs */
 	save_fp_regs(&p->thread.fp_regs);
         p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _REGION_TABLE;
+	/* start new process with ar4 pointing to the correct address space */
+	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
         return 0;
@@ -203,7 +207,7 @@
 asmlinkage int sys_fork(struct pt_regs regs)
 {
 	struct task_struct *p;
-        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -212,12 +216,14 @@
         unsigned long clone_flags;
         unsigned long newsp;
 	struct task_struct *p;
+	int *user_tid;
 
         clone_flags = regs.gprs[3];
         newsp = regs.orig_gpr2;
+	user_tid = (int *) regs.gprs[4];
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -234,7 +240,8 @@
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
 	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.gprs[15], &regs, 0);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		    regs.gprs[15], &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -urN linux-2.5.39/arch/s390x/kernel/setup.c linux-2.5.39-s390/arch/s390x/kernel/setup.c
--- linux-2.5.39/arch/s390x/kernel/setup.c	Fri Sep 27 23:49:45 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/setup.c	Mon Sep 30 13:24:59 2002
@@ -514,7 +514,7 @@
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 				"# processors    : %i\n"
 				"bogomips per cpu: %lu.%02lu\n",
-				smp_num_cpus, loops_per_jiffy/(500000/HZ),
+				num_online_cpus(), loops_per_jiffy/(500000/HZ),
 				(loops_per_jiffy/(5000/HZ))%100);
 	}
 	if (cpu_online_map & (1 << n)) {
diff -urN linux-2.5.39/arch/s390x/kernel/smp.c linux-2.5.39-s390/arch/s390x/kernel/smp.c
--- linux-2.5.39/arch/s390x/kernel/smp.c	Fri Sep 27 23:49:55 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/smp.c	Mon Sep 30 13:24:59 2002
@@ -46,45 +46,16 @@
 /*
  * An array with a pointer the lowcore of every CPU.
  */
-static int       max_cpus = NR_CPUS;	  /* Setup configured maximum number of CPUs to activate	*/
-int              smp_num_cpus;
+
 struct _lowcore *lowcore_ptr[NR_CPUS];
 cycles_t         cacheflush_time=0;
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
-static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
-volatile unsigned long phys_cpu_present_map;
 volatile unsigned long cpu_online_map;
+volatile unsigned long cpu_possible_map;
 unsigned long    cache_decay_ticks = 0;
 
 /*
- *      Setup routine for controlling SMP activation
- *
- *      Command-line option of "nosmp" or "maxcpus=0" will disable SMP
- *      activation entirely (the MPS table probe still happens, though).
- *
- *      Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
- *      greater than 0, limits the maximum number of CPUs activated in
- *      SMP mode to <NUM>.
- */
-
-static int __init nosmp(char *str)
-{
-	max_cpus = 0;
-	return 1;
-}
-
-__setup("nosmp", nosmp);
-
-static int __init maxcpus(char *str)
-{
-	get_option(&str, &max_cpus);
-	return 1;
-}
-
-__setup("maxcpus=", maxcpus);
-
-/*
  * Reboot, halt and power_off routines for SMP.
  */
 extern char vmhalt_cmd[];
@@ -147,9 +118,10 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
-	if (!cpus || !atomic_read(&smp_commenced))
+	/* FIXME: get cpu lock -hc */
+	if (cpus <= 0)
 		return 0;
 
 	data.func = func;
@@ -182,8 +154,8 @@
         int i, rc;
 
         /* stop all processors */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
 			continue;
 		do {
 			rc = signal_processor_ps(&dummy, 0, i, sigp_stop);
@@ -198,8 +170,8 @@
         int i, rc;
 
         /* store status of all processors in their lowcores (real 0) */
-        for (i =  0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i) 
+        for (i =  0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i) 
 			continue;
 		low_core_addr = (unsigned long)get_cpu_lowcore(i);
 		do {
@@ -340,8 +312,8 @@
 {
         int i;
 
-        for (i = 0; i < smp_num_cpus; i++) {
-                if (smp_processor_id() == i)
+        for (i = 0; i < NR_CPUS; i++) {
+                if (!cpu_online(i) || smp_processor_id() == i)
                         continue;
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
@@ -405,13 +377,11 @@
 void smp_ctl_set_bit(int cr, int bit) {
         ec_creg_mask_parms parms;
 
-        if (atomic_read(&smp_commenced) != 0) {
-                parms.start_ctl = cr;
-                parms.end_ctl = cr;
-                parms.orvals[cr] = 1 << bit;
-                parms.andvals[cr] = -1L;
-                smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
-        }
+	parms.start_ctl = cr;
+	parms.end_ctl = cr;
+	parms.orvals[cr] = 1 << bit;
+	parms.andvals[cr] = -1L;
+	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_set_bit(cr, bit);
 }
 
@@ -421,13 +391,11 @@
 void smp_ctl_clear_bit(int cr, int bit) {
         ec_creg_mask_parms parms;
 
-        if (atomic_read(&smp_commenced) != 0) {
-                parms.start_ctl = cr;
-                parms.end_ctl = cr;
-                parms.orvals[cr] = 0;
-                parms.andvals[cr] = ~(1L << bit);
-                smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
-        }
+	parms.start_ctl = cr;
+	parms.end_ctl = cr;
+	parms.orvals[cr] = 0;
+	parms.andvals[cr] = ~(1L << bit);
+	smp_call_function(smp_ctl_bit_callback, &parms, 0, 1);
         __ctl_clear_bit(cr, bit);
 }
 
@@ -436,26 +404,27 @@
  * Lets check how many CPUs we have.
  */
 
-void smp_count_cpus(void)
+void __init smp_check_cpus(unsigned int max_cpus)
 {
-        int curr_cpu;
+        int curr_cpu, num_cpus;
 
+	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         current_thread_info()->cpu = 0;
-        smp_num_cpus = 1;
-	phys_cpu_present_map = 1;
+        num_cpus = 1;
+	cpu_possible_map = 1;
         cpu_online_map = 1;
         for (curr_cpu = 0;
-             curr_cpu <= 65535 && smp_num_cpus < max_cpus; curr_cpu++) {
+             curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
                 if ((__u16) curr_cpu == boot_cpu_addr)
                         continue;
-                __cpu_logical_map[smp_num_cpus] = (__u16) curr_cpu;
-                if (signal_processor(smp_num_cpus, sigp_sense) ==
+                __cpu_logical_map[num_cpus] = (__u16) curr_cpu;
+                if (signal_processor(num_cpus, sigp_sense) ==
                     sigp_not_operational)
                         continue;
-		set_bit(smp_num_cpus, &phys_cpu_present_map);
-                smp_num_cpus++;
+		set_bit(num_cpus, &cpu_possible_map);
+                num_cpus++;
         }
-        printk("Detected %d CPU's\n",(int) smp_num_cpus);
+        printk("Detected %d CPU's\n",(int) num_cpus);
         printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
 
@@ -470,19 +439,18 @@
 {
         /* Setup the cpu */
         cpu_init();
-	/* Mark this cpu as online. */
-	set_bit(smp_processor_id(), &cpu_online_map);
-        /* Print info about this processor */
-        print_cpu_info(&safe_get_cpu_lowcore(smp_processor_id())->cpu_data);
-        /* Wait for completion of smp startup */
-        while (!atomic_read(&smp_commenced))
-                /* nothing */ ;
         /* init per CPU timer */
         init_cpu_timer();
 #ifdef CONFIG_PFAULT
 	/* Enable pfault pseudo page faults on this cpu. */
 	pfault_init();
 #endif
+	/* Mark this cpu as online. */
+	set_bit(smp_processor_id(), &cpu_online_map);
+	/* Switch on interrupts */
+	local_irq_enable();
+        /* Print info about this processor */
+        print_cpu_info(&S390_lowcore.cpu_data);
         /* cpu_idle will call schedule for us */
         return cpu_idle(NULL);
 }
@@ -493,19 +461,35 @@
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
-static void __init do_boot_cpu(int cpu)
+int __cpu_up(unsigned int cpu)
 {
         struct task_struct *idle;
         struct _lowcore    *cpu_lowcore;
+	sigp_ccode          ccode;
+
+	/*
+	 * Set prefix page for new cpu
+	 */
+
+	ccode = signal_processor_p((u64) lowcore_ptr[cpu],
+				   cpu, sigp_set_prefix);
+	if(ccode){
+		printk("sigp_set_prefix failed for cpu %d "
+		       "with condition code %d\n",
+		       (int) cpu, (int) ccode);
+		return -EIO;
+	}
 
         /* We can't use kernel_thread since we must _avoid_ to reschedule
            the child. */
         idle = fork_by_hand();
-	if (IS_ERR(idle))
-                panic("failed fork for CPU %d", cpu);
+	if (IS_ERR(idle)){
+                printk("failed fork for CPU %d", cpu);
+		return -EIO;
+	}
 
         /*
          * We remove it from the pidhash and the runqueue
@@ -517,7 +501,7 @@
 
         cpu_lowcore = get_cpu_lowcore(cpu);
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
-	cpu_lowcore->kernel_stack = (__u64) idle->thread_info + 16384;
+	cpu_lowcore->kernel_stack = (__u64) idle->thread_info + (4*PAGE_SIZE);
         __asm__ __volatile__("la    1,%0\n\t"
 			     "stctg 0,15,0(1)\n\t"
 			     "la    1,%1\n\t"
@@ -528,75 +512,47 @@
 
         eieio();
         signal_processor(cpu,sigp_restart);
-}
-
-/*
- *      Architecture specific routine called by the kernel just before init is
- *      fired off. This allows the BP to have everything in order [we hope].
- *      At the end of this all the APs will hit the system scheduling and off
- *      we go. Each AP will load the system gdt's and jump through the kernel
- *      init into idle(). At this point the scheduler will one day take over
- *      and give them jobs to do. smp_callin is a standard routine
- *      we use to track CPUs as they power up.
- */
 
-void __init smp_commence(void)
-{
-        /*
-         *      Lets the callins below out of their loop.
-         */
-        atomic_set(&smp_commenced,1);
+	while (!cpu_online(cpu));
+	return 0;
 }
 
 /*
- *	Cycle through the processors sending restart sigps to boot each.
+ *	Cycle through the processors and setup structures.
  */
 
-void __init smp_boot_cpus(void)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned long async_stack;
-        sigp_ccode   ccode;
         int i;
 
         /* request the 0x1202 external interrupt */
         if (register_external_interrupt(0x1202, do_ext_call_interrupt) != 0)
                 panic("Couldn't request external interrupt 0x1202");
-        smp_count_cpus();
+        smp_check_cpus(max_cpus);
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
         
         /*
-         *      Initialize the logical to physical CPU number mapping
+         *  Initialize prefix pages and stacks for all possible cpus
          */
         print_cpu_info(&safe_get_cpu_lowcore(0)->cpu_data);
 
-        for(i = 0; i < smp_num_cpus; i++) {
-                lowcore_ptr[i] = (struct _lowcore *)
-                                    __get_free_pages(GFP_KERNEL|GFP_DMA, 1);
+        for(i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		lowcore_ptr[i] = (struct _lowcore *)
+			__get_free_pages(GFP_KERNEL|GFP_DMA, 1);
 		async_stack = __get_free_pages(GFP_KERNEL,2);
 		if (lowcore_ptr[i] == NULL || async_stack == 0ULL)
 			panic("smp_boot_cpus failed to allocate memory\n");
                 memcpy(lowcore_ptr[i], &S390_lowcore, sizeof(struct _lowcore));
 		lowcore_ptr[i]->async_stack = async_stack + (4 * PAGE_SIZE);
-                /*
-                 * Most of the parameters are set up when the cpu is
-                 * started up.
-                 */
-                if (smp_processor_id() == i) {
-                        set_prefix((u32)(u64) lowcore_ptr[i]);
-			continue;
-		}
-		ccode = signal_processor_p((u64) lowcore_ptr[i],
-					   i, sigp_set_prefix);
-		if(ccode)
-			panic("sigp_set_prefix failed for cpu %d "
-			      "with condition code %d\n",
-			      (int) i, (int) ccode);
-		do_boot_cpu(i);
-        }
-	/*
-	 * Now wait until all of the cpus are online.
-	 */
-	while (phys_cpu_present_map != cpu_online_map);
+	}
+	set_prefix((u32)(u64) lowcore_ptr[smp_processor_id()]);
+}
+
+void smp_cpus_done(unsigned int max_cpis)
+{
 }
 
 /*
@@ -613,5 +569,4 @@
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
diff -urN linux-2.5.39/arch/s390x/kernel/time.c linux-2.5.39-s390/arch/s390x/kernel/time.c
--- linux-2.5.39/arch/s390x/kernel/time.c	Fri Sep 27 23:50:28 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/time.c	Mon Sep 30 13:24:59 2002
@@ -47,18 +47,18 @@
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
-void tod_to_timeval(__u64 todval, struct timeval *xtime)
+void tod_to_timeval(__u64 todval, struct timespec *xtime)
 {
-        todval >>= 12;
-        xtime->tv_sec = todval / 1000000;
-        xtime->tv_usec = todval % 1000000;
+        xtime->tv_sec = (todval >> 12) / 1000000;
+	todval -= (xtime->tv_sec * 1000000) << 12;
+	xtime->tv_nsec = ((todval * 1000) >> 12);
 }
 
 static inline unsigned long do_gettimeoffset(void) 
 {
 	__u64 now;
 
-	asm ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
+	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
         now = (now - init_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
@@ -75,7 +75,7 @@
 
 	read_lock_irqsave(&xtime_lock, flags);
 	sec = xtime.tv_sec;
-	usec = xtime.tv_usec + do_gettimeoffset();
+	usec = xtime.tv_nsec + do_gettimeoffset();
 	read_unlock_irqrestore(&xtime_lock, flags);
 
 	while (usec >= 1000000) {
@@ -104,7 +104,8 @@
 		tv->tv_sec--;
 	}
 
-	xtime = *tv;
+	xtime.tv_sec = tv->tv_sec;
+	xtime.tv_nsec = tv->tv_usec * 1000;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -125,7 +126,7 @@
 {
 	int cpu = smp_processor_id();
 
-	irq_enter(cpu, 0);
+	irq_enter();
 
 	/*
 	 * set clock comparator for next tick
@@ -147,7 +148,7 @@
 	do_timer(regs);
 #endif
 
-	irq_exit(cpu, 0);
+	irq_exit();
 }
 
 /*
diff -urN linux-2.5.39/arch/s390x/kernel/traps.c linux-2.5.39-s390/arch/s390x/kernel/traps.c
--- linux-2.5.39/arch/s390x/kernel/traps.c	Fri Sep 27 23:50:26 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/traps.c	Mon Sep 30 13:24:59 2002
@@ -172,6 +172,14 @@
 	show_trace(sp);
 }
 
+/*
+ * The architecture-independent dump_stack generator
+ */
+void dump_stack(void)
+{
+	show_stack(0);
+}
+
 void show_registers(struct pt_regs *regs)
 {
 	mm_segment_t old_fs;

