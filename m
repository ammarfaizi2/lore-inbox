Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTHZQEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbTHZQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:04:47 -0400
Received: from PPP-219-65-146-28.bng.vsnl.net.in ([219.65.146.28]:5249 "EHLO
	debian-hanishkvc") by vger.kernel.org with ESMTP id S262491AbTHZQEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:04:16 -0400
Date: Tue, 26 Aug 2003 21:09:34 +0530 (IST)
From: C Hanish Menon <hanishkvc@yahoo.com>
X-X-Sender: hanishkvc@debian-hanishkvc
To: alan@lxorguk.ukuu.org.uk
Cc: torvalds@osdl.org, <mingo@redhat.com>,
       Linux-Kernel-mailing-list <linux-kernel@vger.kernel.org>,
       <andmike@us.ibm.com>, <rml@tech9.net>, <hanishkvc@fedtec.com>,
       <hanishkvc@yahoo.com>
Subject: mutexks: possible logic to fix "bad: scheduling while atomic!"
 triggered by scsi and more _maybe_
Message-ID: <Pine.LNX.4.44.0308261926130.1713-100000@debian-hanishkvc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi alan,

While checking the lkml archieves I found a reference from you regarding
the scsi subsystem related errors leading to "scheduling while atomic
messages" and that you had a possible solution for it. Yesterday I faced
the same problem on my machine(a AMD duron m/c with 2 CD drives - one
CDWriter and one DVD combo drive), on looking thro the code and the stack
trace, I thought of one possible reason for this and a solution based on a
new synchronisation mechanism (rather fixing a _missing semantic_ in
linux)

In linux the implementation of spinlocks in UniProcessor configurations is
such that It provides a Exclusive Execution mechanism rather than a Mutual
Exclusion mechanism.

On looking thro the Call Trace dumped, I realized that this was occuring
because in scsi_error.c the logic was using spin_lock_irqsave more as a
logic to provide mutual exclusion. Because the handlers it calls inturn
use timers, semaphores and also schedule_timeout. However in a
UniProcessor machine this won't work as spin_lock_irqsave disables both
Interrupts as well as preemption. (Note: Currently It does continue
because the schedule in sched.c just ignores the preempt_count and allows
the scheduling to continue after giving a stack trace on the screen).

So I have written a patch which does:

a) Provide a new synchronisation primitive mutexks which is a simple logic
- a wrapper which inturn uses either spinlock or semaphore depending on
whether one is running in a SMP or a UniProcessor configuration.

b) Fixed the schedule such that it doesn't ignore preempt_count unless a
associated logic sets a flag telling only MutualExclusion is required and
not ExclusiveExecution. - Rather this is a temporary fix as in the long
run where ever only MutualExclusion is required they should use mutexks_t
or something similar.

c) A simple addition to show_trace in traps.c of i386, so that it prints
the distance between the functions in the stack interms of words.

d) A hack or BAD Fix to scsi_error.c so that the current problem in it is
solved TEMPORARILY.

The actual fix for scsi subsystem would involve moving the code to use
mutexks or similar logic inplace of spinlocks in certain cases, if you
want to retain the current flow. However as it involves a lot of simple
changes (but which are logicaly thought thro as requiring mutual exclusion
and not exclusive execution) to many parts of scsi subsystem, I haven't
done it.

If everyone agrees that we want something like mutexks then I think the
scsi maintainers can do that work, so I am ccing to andmike from IBM, as I
found his name corresponding to some work with scsi_unjam_host in
scsi_error.c. It actually shouldn't be that difficult as those spinlocks
which are decided as requiring true mutual exclusion semantics can be
simply replaced by mutexks_t and calls to spin_lock/unlock by
mutexks_lock/unlock.

I am attaching the patch here. Also on my website I have written a small
paper which talks about this issue of MutualExclusion and
ExclusiveExecution and why and how to provide the missing true mutual
exclusion in linux. As can be seen from the patch below, I feel it is
straight forward and simple keeping the KISS principal.

URL: www.hanishkvc.com/work/outside/kernel/mutex_ks/index.html

It contains the patch, the paper of mutexks and dmesg logs of the
CallTrace before and after the application of the patch.

*********** The PATCH which provides mutexks plus few other ***********

diff -Naur linux-2.6.0-test4/arch/i386/kernel/traps.c linux-2.6.0-test4-hkvc/arch/i386/kernel/traps.c
--- linux-2.6.0-test4/arch/i386/kernel/traps.c	Mon Aug 25 23:45:07 2003
+++ linux-2.6.0-test4-hkvc/arch/i386/kernel/traps.c	Mon Aug 25 22:53:16 2003
@@ -95,6 +95,7 @@
 void show_trace(struct task_struct *task, unsigned long * stack)
 {
 	unsigned long addr;
+	int count;

 	if (!stack)
 		stack = (unsigned long*)&stack;
@@ -103,14 +104,18 @@
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
+	count=0;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			printk(" [<%08lx>] ", addr);
+			printk("+%08d [<%08lx>] ", count, addr);
 			print_symbol("%s\n", addr);
+			count = 0;
 		}
+		else
+			count++;
 	}
-	printk("\n");
+	printk("+%08d \n", count);
 }

 void show_trace_task(struct task_struct *tsk)
diff -Naur linux-2.6.0-test4/drivers/scsi/ide-scsi.c linux-2.6.0-test4-hkvc/drivers/scsi/ide-scsi.c
--- linux-2.6.0-test4/drivers/scsi/ide-scsi.c	Mon Aug 25 23:45:21 2003
+++ linux-2.6.0-test4-hkvc/drivers/scsi/ide-scsi.c	Tue Aug 26 16:28:36 2003
@@ -851,6 +851,18 @@
 	return 1;
 }

+/* FIXME:
+ * Shouldn't call scsi_sleep or schedule_timeout in idescsi_abort and
+ * idescsi_reset as it depends on timers and working of scheduler, because
+ * currently interrupts and preemption are disabled cas of spin_lock_irqsave.
+ *
+ * However As I have added the CONFIG_MUTEX_KS related logic in scsi_error.c
+ * file it is partly ok. But for this logic to work fully properly the logic
+ * in scsi system as to be updated to use mutexks rather than spinlocks
+ *
+ * HanishKVC
+ */
+
 static int idescsi_abort (Scsi_Cmnd *cmd)
 {
 	int countdown = 8;
@@ -867,7 +879,7 @@
 				scsi->pc->scsi_cmd->serial_number == cmd->serial_number) {
 			/* yep - let's give it some more time -
 			 * we can do that, we're in _our_ error kernel thread */
-			spin_unlock_irqrestore(&ide_lock, flags);
+			spin_unlock_irqrestore(&ide_lock, flags);
 			scsi_sleep(HZ);
 			continue;
 		}
diff -Naur linux-2.6.0-test4/drivers/scsi/scsi_error.c linux-2.6.0-test4-hkvc/drivers/scsi/scsi_error.c
--- linux-2.6.0-test4/drivers/scsi/scsi_error.c	Mon Aug 25 23:45:23 2003
+++ linux-2.6.0-test4-hkvc/drivers/scsi/scsi_error.c	Tue Aug 26 16:23:29 2003
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <scsi/scsi_ioctl.h>
+#include <linux/mutexks.h>

 #include "scsi.h"
 #include "hosts.h"
@@ -692,10 +693,28 @@
  *    they can provide this facility themselves.  helper functions in
  *    scsi_error.c can be supplied to make this easier to do.
  **/
+/* FIXME:
+ * The proper way to use the mutexks support is to make the host_lock
+ * embedded deep inside the scsi_cmd structure into a mutexks_t
+ * and update all usage of this host_lock to use mutexks_lock/unlock
+ * routines
+ *
+ * However as a temporary solution we are hardcoding both the
+ * CONFIG_MUTEX_KS_SIMPLE and the CONFIG_MUTEX_KS logic. Both of these
+ * logic are not the correct way of doing things and may fail especially
+ * the CONFIG_MUTEX_KS related logic. This is only a quickfix.
+ *
+ * HanishKVC
+ *
+ */
+
 static int scsi_try_to_abort_cmd(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
 	int rtn = FAILED;
+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_t tempMutex = MUTEXKS_UNLOCKED(tempMutex);
+#endif

 	if (!scmd->device->host->hostt->eh_abort_handler)
 		return rtn;
@@ -709,9 +728,21 @@

 	scmd->owner = SCSI_OWNER_LOWLEVEL;

+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_lock(&tempMutex);
+	/* mutexks_lock(scmd->device->host->host_lock); // ideal logic */
+#else
 	spin_lock_irqsave(scmd->device->host->host_lock, flags);
+	mutualexclusion(MEONLY_ENABLE);
+#endif
 	rtn = scmd->device->host->hostt->eh_abort_handler(scmd);
+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_unlock(&tempMutex);
+	/* mutexks_unlock(scmd->device->host->host_lock); // ideal logic */
+#else
 	spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
+	mutualexclusion(MEONLY_DISABLE);
+#endif

 	return rtn;
 }
@@ -819,19 +850,49 @@
  *    timer on it, and set the host back to a consistent state prior to
  *    returning.
  **/
+/* FIXME:
+ * The proper way to use the mutexks support is to make the host_lock
+ * embedded deep inside the scsi_cmd structure into a mutexks_t
+ * and update all usage of this host_lock to use mutexks_lock/unlock
+ * routines
+ *
+ * However as a temporary solution we are hardcoding both the
+ * CONFIG_MUTEX_KS_SIMPLE and the CONFIG_MUTEX_KS logic. Both of these
+ * logic are not the correct way of doing things and may fail especially
+ * the CONFIG_MUTEX_KS related logic. This is only a quickfix.
+ *
+ * HanishKVC
+ *
+ */
+
 static int scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
 	int rtn = FAILED;
+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_t tempMutex = MUTEXKS_UNLOCKED(tempMutex);
+#endif

 	if (!scmd->device->host->hostt->eh_device_reset_handler)
 		return rtn;

 	scmd->owner = SCSI_OWNER_LOWLEVEL;

+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_lock(&tempMutex);
+	/* mutexks_lock(scmd->device->host->host_lock); // ideal logic */
+#else
 	spin_lock_irqsave(scmd->device->host->host_lock, flags);
+	mutualexclusion(MEONLY_ENABLE);
+#endif
 	rtn = scmd->device->host->hostt->eh_device_reset_handler(scmd);
+#ifndef CONFIG_MUTEX_KS_SIMPLE
+	mutexks_unlock(&tempMutex);
+	/* mutexks_unlock(scmd->device->host->host_lock); // ideal logic */
+#else
 	spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
+	mutualexclusion(MEONLY_DISABLE);
+#endif

 	if (rtn == SUCCESS) {
 		scmd->device->was_reset = 1;
diff -Naur linux-2.6.0-test4/include/linux/mutexks.h linux-2.6.0-test4-hkvc/include/linux/mutexks.h
--- linux-2.6.0-test4/include/linux/mutexks.h	Thu Jan  1 05:30:00 1970
+++ linux-2.6.0-test4-hkvc/include/linux/mutexks.h	Tue Aug 26 16:31:42 2003
@@ -0,0 +1,78 @@
+#ifndef _MUTEXKS_H_
+#define _MUTEXKS_H_
+
+/*
+ * True Mutual Exclusion logic in Kernel space
+ *
+ * Copyright (C) 2003  C Hanish Menon (HanishKVC.com)
+ *
+ * look at kernel/mutexks.c
+ *
+ * To help during transition currently both the
+ * temporary (CONFIG_MUTEX_KS_SIMPLE) and
+ * permanent (CONFIG_MUTEX_KS) solutions mentioned in the paper
+ * are provided.
+ *
+ */
+
+#define CONFIG_MUTEX_KS
+
+/* This is the temporary logic to over come the spinlocks lack of
+ * mutual exclusion in UniProcessor mode.
+ * However Ideally one should move all such instances of spinlocks
+ * to use mutexks_t. Which will automatically adapt to SMP or
+ * Uniprocessor configuration.
+ */
+#ifndef CONFIF_SMP
+#define CONFIG_MUTEX_KS_SIMPLE
+#undef CONFIG_MUTEX_KS_SIMPLE
+#endif
+
+#ifdef CONFIG_MUTEX_KS
+
+/*
+typedef union {
+	spinlock_t spinlock;
+	struct semaphore semaphore;
+} mutexks_t;
+*/
+
+#ifdef CONFIG_SMP
+
+#define SPIN_LOCK_LOCKED (spinlock_t) { 0 SPINLOCK_MAGIC_INIT }
+
+typedef spinlock_t mutexks_t;
+
+#define MUTEXKS_LOCKED(name) SPIN_LOCK_LOCKED
+#define MUTEXKS_UNLOCKED(name) SPIN_LOCK_UNLOCKED
+
+#else
+
+typedef struct semaphore mutexks_t;
+
+#define MUTEXKS_LOCKED(name) __SEMAPHORE_INITIALIZER(name,0)
+#define MUTEXKS_UNLOCKED(name) __SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* CONFIG_SMP */
+
+inline void mutexks_lock(mutexks_t *me);
+inline void mutexks_unlock(mutexks_t *me);
+
+#endif /* CONFIG_MUTEX_KS */
+
+#ifdef CONFIG_MUTEX_KS_SIMPLE
+
+#ifndef CONFIG_SMP
+
+#define MEONLY_ENABLE 1
+#define MEONLY_DISABLE 0
+
+extern int mutualExclusionOnlyFlag;
+
+inline void mutualexclusion(int meOnlyFlag);
+
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_MUTEX_KS_SIMPLE */
+
+#endif
diff -Naur linux-2.6.0-test4/kernel/Makefile linux-2.6.0-test4-hkvc/kernel/Makefile
--- linux-2.6.0-test4/kernel/Makefile	Mon Aug 25 23:45:26 2003
+++ linux-2.6.0-test4-hkvc/kernel/Makefile	Tue Aug 26 13:52:50 2003
@@ -6,7 +6,8 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    mutexks.o

 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Naur linux-2.6.0-test4/kernel/ksyms.c linux-2.6.0-test4-hkvc/kernel/ksyms.c
--- linux-2.6.0-test4/kernel/ksyms.c	Mon Aug 25 23:45:26 2003
+++ linux-2.6.0-test4-hkvc/kernel/ksyms.c	Tue Aug 26 14:40:22 2003
@@ -60,6 +60,7 @@
 #include <linux/backing-dev.h>
 #include <linux/percpu_counter.h>
 #include <asm/checksum.h>
+#include <linux/mutexks.h>

 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -618,3 +619,13 @@
 EXPORT_SYMBOL(console_printk);

 EXPORT_SYMBOL(current_kernel_time);
+
+/* mutual exclusion in kernel space */
+#ifdef CONFIG_MUTEX_KS
+EXPORT_SYMBOL(mutexks_lock);
+EXPORT_SYMBOL(mutexks_unlock);
+#endif
+#ifdef CONFIG_MUTEX_KS_SIMPLE
+EXPORT_SYMBOL(mutualexclusion);
+#endif
+
diff -Naur linux-2.6.0-test4/kernel/mutexks.c linux-2.6.0-test4-hkvc/kernel/mutexks.c
--- linux-2.6.0-test4/kernel/mutexks.c	Thu Jan  1 05:30:00 1970
+++ linux-2.6.0-test4-hkvc/kernel/mutexks.c	Tue Aug 26 16:32:31 2003
@@ -0,0 +1,95 @@
+/*
+ * kernel/mutexks.c - True Mutual Exclusion in Kernel space
+ * Logic which provides true Mutual Exclusion in both
+ * SMP and UniProcessor machines in the Kernel space
+ *
+ * 26 august 2003, C Hanish Menon (hanishkvc.com)
+ *
+ * Note that it can put the calling context in a wait queue
+ * or block it if required
+ *
+ * How:
+ * Use spin_lock on SMP
+ * Use semaphore on UniProcessor machines
+ *
+ * Why required:
+ * Because the current spin_lock logics lead to Exclusive Execution
+ * rather than Mutual Exclusion in UniProcessor machines
+ *
+ * Look at www.hanishkvc.com/work/outside/kernel/mutex_ks/index.html
+ *
+ * To help during transition currently both the
+ * temporary (CONFIG_MUTEX_KS_SIMPLE) and
+ * permanent (CONFIG_MUTEX_KS) solutions mentioned in the paper
+ * are provided.
+ *
+ */
+
+
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+#include <linux/mutexks.h>
+
+#ifdef CONFIG_MUTEX_KS
+
+#ifdef CONFIG_SMP
+
+inline void mutexks_lock(mutexks_t *me)
+{
+	spinlock_t *sl;
+
+	sl = (spinlock_t*)me;
+	spin_lock(sl);
+}
+
+inline void mutexks_unlock(mutexks_t *me)
+{
+	spinlock_t *sl;
+
+	sl = (spinlock_t*)me;
+	spin_unlock(sl);
+}
+
+#else /* CONFIG_SMP */
+
+inline void mutexks_lock(mutexks_t *me)
+{
+	struct semaphore *sem;
+
+	sem = (struct semaphore*)me;
+	down(sem);
+}
+
+inline void mutexks_unlock(mutexks_t *me)
+{
+	struct semaphore *sem;
+
+	sem = (struct semaphore*)me;
+	up(sem);
+}
+
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_MUTEX_KS */
+
+/* HanishKVC
+ * Temporary logic to Achieve Mutual Exclusion using a global
+ * flag along with the current Exclusive Execution logic of spinlocks
+ * on uniprocessor machines
+ */
+#ifdef CONFIG_MUTEX_KS_SIMPLE
+
+#ifndef CONFIG_SMP
+
+int mutualExclusionOnlyFlag = MEONLY_DISABLE;
+
+inline void mutualexclusion(int meOnlyFlag)
+{
+	mutualExclusionOnlyFlag = meOnlyFlag;
+}
+
+#endif /* CONFIG_SMP */
+
+
+#endif /* CONFIG_MUTEX_KS_SIMPLE */
+
diff -Naur linux-2.6.0-test4/kernel/sched.c linux-2.6.0-test4-hkvc/kernel/sched.c
--- linux-2.6.0-test4/kernel/sched.c	Mon Aug 25 23:45:26 2003
+++ linux-2.6.0-test4-hkvc/kernel/sched.c	Tue Aug 26 16:30:40 2003
@@ -34,6 +34,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/mutexks.h>

 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -1294,10 +1295,16 @@
 	 * schedule() atomically, we ignore that path for now.
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
+#ifdef CONFIG_MUTEX_KS_SIMPLE
+	if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)) &&
+			!(mutualExclusionOnlyFlag == MEONLY_ENABLE))) {
+#else
 	if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
+#endif
 		if (unlikely(in_atomic())) {
 			printk(KERN_ERR "bad: scheduling while atomic!\n");
 			dump_stack();
+			return;
 		}
 	}












