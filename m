Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVCKDuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVCKDuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVCKDsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:48:35 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:19896 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261161AbVCKDnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:43:06 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 14:42:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Microstate Accounting
---------------------

Timing data on threads at present is pretty crude:  when the timer
interrupt occurs, a tick is added to either system time or user time
for the currently running thread.  Thus in an unpacthed kernel one can
distinguish three timed states:  On-cpu in userspace, on-cpu in system
space, and not running.

The actual number of states is much larger.  A thread can be on a
runqueue or  the expired queue (i.e., ready to run but not running),
sleeping on a semaphore or on a futex, having its time stolen to
service an interrupt, etc., etc.

This patch adds timers per-state to each struct task_struct, so that
time in all these states can be tracked.  This patch contains the core
code do the timing, and to initialise the timers.  Subsequent patches
enable the code (by adding Kconfig options) and add hooks to track
state changes.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

 include/asm-generic/msa.h  |   21 ++
 include/linux/msa-kernel.h |   99 +++++++++
 include/linux/msa.h        |   46 ++++
 include/linux/sched.h      |    4 
 kernel/Makefile            |    2 
 kernel/fork.c              |    2 
 kernel/msa.c               |  472 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 645 insertions(+), 1 deletion(-)

Index: linux-2.6-ustate/kernel/msa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/kernel/msa.c	2005-03-11 09:58:20.574030768 +1100
@@ -0,0 +1,472 @@
+/*
+ * Microstate accounting.
+ * Try to account for various states much more accurately than
+ * the normal code does.
+ *
+ * Copyright (c) Peter Chubb 2005
+ *  UNSW and National ICT Australia
+ * This code is released under the Gnu Public Licence, version 2.
+ */
+
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#ifdef CONFIG_MICROSTATE
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+#include <linux/sched.h>
+#include <linux/jiffies.h>
+
+#include <asm/uaccess.h>
+
+/*
+ * Track time spend in interrupt handlers.
+ */
+struct msa_irq {
+	clk_t times;
+	clk_t last_entered;
+};
+
+/*
+ * When the scheduler last swapped active and expired queues
+ */
+static DEFINE_PER_CPU(clk_t, queueflip_time);
+
+/*
+ * Time spent in interrupt handlers
+ */
+static DEFINE_PER_CPU(struct msa_irq[NR_IRQS+1], msa_irq);
+
+
+/**
+ * msa_switch: Update microstate timers when switching from one task to another.
+ * @prev, @next:  The prev task is coming off the processor;
+ *                the new task is about to run on the processor.
+ *
+ * Update the times in both prev and next.  It may be necessary to infer the 
+ * next state for each task.
+ *
+ */
+void
+msa_switch(struct task_struct *prev, struct task_struct *next)
+{
+	struct microstates *msprev = &prev->microstates;
+	struct microstates *msnext = &next->microstates;
+	clk_t now;
+	enum thread_state next_state;
+	int interrupted = msprev->cur_state == INTERRUPTED;
+
+	preempt_disable();
+
+	MSA_NOW(now);
+
+	if (msprev->flags & QUEUE_FLIPPED) {
+		__get_cpu_var(queueflip_time) = now;
+		msprev->flags &= ~QUEUE_FLIPPED;
+	}
+
+	/*
+	 * If the queues have been flipped,
+	 * update the state as of the last flip time.
+	 */
+	if (msnext->cur_state == ONEXPIREDQUEUE) {
+		clk_t qfp = per_cpu(queueflip_time, msnext->lastqueued);
+		msnext->cur_state = ONACTIVEQUEUE;
+		msnext->timers[ONEXPIREDQUEUE] += qfp - msnext->last_change;
+		msnext->last_change = qfp;
+	}
+
+	msprev->timers[msprev->cur_state] += now - msprev->last_change;
+	msnext->timers[msnext->cur_state] += now - msnext->last_change;
+	
+	/* Update states */
+	switch (msprev->next_state) {
+	case MSA_UNKNOWN:
+			/*
+			 * Infer from actual state
+			 */
+		switch (prev->state) {
+		case TASK_INTERRUPTIBLE:
+			next_state = INTERRUPTIBLE_SLEEP;
+			break;
+		
+		case TASK_UNINTERRUPTIBLE:
+			next_state = UNINTERRUPTIBLE_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case EXIT_DEAD:
+		case EXIT_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = MSA_UNKNOWN;
+			break;
+
+		} 
+		break;
+
+	case PAGING_SLEEP: /*
+			    * Sleep states are PAGING_SLEEP;
+			    * others inferred from task state
+			    */
+		switch(prev->state) {
+		case TASK_INTERRUPTIBLE: /* FALLTHROUGH */
+		case TASK_UNINTERRUPTIBLE:
+			next_state = PAGING_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case EXIT_DEAD:
+		case EXIT_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = MSA_UNKNOWN;
+			break;
+		}
+		break;
+
+	default: /* Explicitly set next state */
+		next_state = msprev->next_state;
+		msprev->next_state = MSA_UNKNOWN;
+		break;
+	}
+
+	msprev->cur_state = next_state;
+	msprev->last_change = now;
+	msprev->lastqueued = smp_processor_id();
+
+	msnext->cur_state = interrupted ? INTERRUPTED : (
+		msnext->flags & MSA_SYS ? ONCPU_SYS : ONCPU_USER);
+	msnext->last_change = now;
+
+	preempt_enable_no_resched();
+}
+
+/**
+ * msa_init:  Initialise the struct microstates in a new task
+ * @p: pointer to the struct task_struct to be initialised
+ *
+ * This function is called from copy_process().
+ * It initialises the microstate timers to zero, and sets the 
+ * current state to UNINTERRUPTIBLE_SLEEP.
+ */
+void msa_init(struct task_struct *p)
+{
+	struct microstates *msp = &p->microstates;
+
+	memset(msp, 0, sizeof *msp);
+	MSA_NOW(msp->last_change);
+	msp->cur_state = UNINTERRUPTIBLE_SLEEP;
+	msp->next_state = MSA_UNKNOWN;
+}
+
+/**
+ * __msa_set_timer: Helper function to update microstate times.
+ * &msp:  Pointer to the struct microstates to update
+ * next_state: the state being changed to.
+ *
+ * The time spent in the current state is updated, and the time of 
+ * last state change set to MSA_NOW().  Then the current state is updated 
+ * to next_state.
+ */
+static void inline __msa_set_timer(struct microstates *msp, int next_state)
+{
+	clk_t now;
+
+	MSA_NOW(now);
+	msp->timers[msp->cur_state] += now - msp->last_change;
+	msp->last_change = now;
+	msp->cur_state = next_state;
+
+}
+
+/**
+ * msa_set_timer:  Time stamp an explicit state change.
+ * @p: pointer to the task that has just changed state.
+ * @next_state: the state being changed to.
+ *
+ * This function is called, e.g., from __activate_task(), when an 
+ * immediate state change happens.
+ */
+void
+msa_set_timer(struct task_struct *p, int next_state)
+{
+	struct microstates *msp = &p->microstates;
+
+	__msa_set_timer(msp, next_state);
+	msp->lastqueued = smp_processor_id();
+	msp->next_state = MSA_UNKNOWN;
+}
+
+/*
+ * Helper routines, to be called from assembly language stubs 
+ */
+/**
+ * msa_start_syscall: change state to ONCPU_SYS.
+ *
+ * Called from assembly language.
+ * Sets the MSA_SYS flags in the current microstate structure, so that
+ * if the process is interrupted, the system remembers that the code 
+ * was running in a system call.
+ */
+void msa_start_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	msp->flags |= MSA_SYS;
+	__msa_set_timer(msp, ONCPU_SYS);
+}
+
+/**
+ * msa_end_syscall: change state out of ONCPU_SYS
+ *
+ * Called when leaving the kernel at the end of a system call.
+ * Clears the MSA_SYS flag in addition to updating the timers.
+ */
+void msa_end_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	msp->flags &= ~MSA_SYS;
+	__msa_set_timer(msp, ONCPU_USER);
+}
+
+/**
+ * msa_start_irq: mark the start of an interrupt handler.
+ * @irq: irq number being handled.
+ *
+ * Update the current task state to INTERRUPTED, and start accumulating time 
+ * to the interrupt handler for irq.
+ */
+void msa_start_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+
+	/* we're in an interrupt handler... no possibility of preemption */
+	MSA_NOW(now);
+	BUG_ON(!in_interrupt());
+
+	mp->timers[mp->cur_state] += now - mp->last_change;
+	mp->last_change = now;
+	mp->cur_state = INTERRUPTED;
+
+	__get_cpu_var(msa_irq)[irq].last_entered = now;
+}
+
+/**
+ * msa_continue_irq: While remaining in INTERRUPTED state, switch to a new IRQ.
+ * @oldirq: the irq that was just serviced
+ * @newirq: the irq that is about to be serviced.
+ *
+ * Architectures such as IA64 can handle more than one interrupt 
+ * without allowing the interrupted process to continue.  This function 
+ * is called when switching to a new interrupt.
+ */
+void msa_continue_irq(int oldirq, int newirq) 
+{
+	clk_t now;
+	struct msa_irq *mip;
+
+	MSA_NOW(now);
+	/* we're in an interrupt handler... no possibility of preemption */
+	BUG_ON(!in_interrupt());
+	mip = __get_cpu_var(msa_irq);
+
+	mip[oldirq].times +=  now - mip[oldirq].last_entered;
+	mip[newirq].last_entered = now;
+}
+
+/**
+ * msa_finish_interrupt: end processing for an interrupt.
+ * @irq: the interrupt that was just serviced.
+ *
+ * Update the time spent handling irq, then update the current task's 
+ * state to ONCPU_USER or ONCPU_SYS.
+ */
+void msa_finish_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+	struct msa_irq *mip;
+
+	MSA_NOW(now);
+	mip = get_cpu_var(msa_irq);
+
+	/*
+	 * Interrupts can nest.
+	 * Set current state to ONCPU_USR or ONCPU_SYS
+	 * iff we're not in a nested interrupt.
+	 * (This charges the remainder of the interupt handler and 
+	 * softIRQ time to the most deeply nested interrupt)
+	 */
+	if (!in_interrupt()) {
+		BUG_ON(mp->cur_state != INTERRUPTED);
+		mp->timers[mp->cur_state] += now - mp->last_change;
+		mp->last_change = now;
+		mp->cur_state = (mp->flags & MSA_SYS) ? ONCPU_SYS : ONCPU_USER;
+	}
+	mip[irq].times += now = mip[irq].last_entered;
+	put_cpu_var(msa_irq);
+
+}
+
+/**
+ * msa_irq_time:  return interrupt handling duration in microseconds
+ * @cpu: processor number
+ * @irq: irq number
+ *
+ * Return the total number of microseconds since boot spent 
+ * in handling interrupt number 'irq' on processor 'cpu'.
+ */
+clk_t msa_irq_time(int cpu, int irq) 
+{
+	clk_t x = per_cpu(msa_irq, cpu)[irq].times;
+	x = MSA_TO_NSEC(x);
+	do_div(x, 1000);
+	return x;
+}
+
+
+/**
+ * msa_update_parent:  Accumulate child times into parent, after zombie is over.
+ * @parent: pointer to parent task
+ * @this: pointer to task that is now a zombie
+ *
+ * Called from release_task(). (Note: it may be better to call this 
+ * from wait_zombie())
+ */
+void msa_update_parent(struct task_struct *parent, struct task_struct *this)
+{
+	enum thread_state s;
+	clk_t *msp = parent->microstates.child_timers;
+	struct microstates *mp = &this->microstates;
+	clk_t *msc = mp->timers;
+	clk_t *msgc = mp->child_timers;
+	clk_t now;
+
+	/*
+	 * State could be ZOMBIE (if parent is interested)
+	 * or something else (if the parent isn't interested)
+	 */
+	MSA_NOW(now);
+	msc[mp->cur_state] += now - mp->last_change;
+
+	for (s = 0; s < NR_MICRO_STATES; s++) {
+		*msp++ += *msc++ + *msgc++;
+	}
+}
+
+/**
+ * sys_msa: get microstate data for self or waited-for children.
+ * @ntimers: the number of timers requested
+ * @which: which set of timers is wanted.
+ * @timers: pointer in user space to an array of timers.
+ *
+ * 'which' can take the values 
+ *   MSA_THREAD: return times for current thread only
+ *   MSA_SELF:  return times for current process, 
+ *		summing over all live threads
+ *   MSA_CHILDREN: return sum of times for all dead children.
+ * 
+ * The timers are ordered so that the most interesting ones are first.
+ * Thus a user program can ask for only the  few most interesting ones 
+ * if it wishes.  Also, we can add more in the kernel as we need 
+ * to without invalidating user code.
+ */
+long asmlinkage sys_msa(int ntimers, int which, __u64 __user *timers)
+{
+	clk_t now;
+	clk_t *tp;
+	int i;
+	struct microstates *msp = &current->microstates;
+	struct microstates out;
+
+	if (ntimers <= 0)
+		return -EINVAL;
+	if (ntimers > NR_MICRO_STATES)
+		ntimers = NR_MICRO_STATES;
+
+	switch (which) {
+	default:
+		return -EINVAL;
+
+	case MSA_SELF:
+	case MSA_THREAD:
+		preempt_disable();
+		if (msp->cur_state != ONCPU_SYS) {
+			printk("In Syscall; msa_state = %d \n", msp->cur_state);
+			msp->cur_state = ONCPU_SYS;
+		}
+
+		MSA_NOW(now);
+		msp->timers[ONCPU_SYS] += now - msp->last_change;
+		msp->last_change = now;
+
+		if (which == MSA_SELF) {
+			struct task_struct *task;
+			struct task_struct *leader_task;
+			clk_t *tp1;
+
+			memset(out.timers, 0, sizeof(out.timers));
+			read_lock(&tasklist_lock);
+			leader_task = task = current->group_leader;
+			do {
+				tp = task->microstates.timers;
+				tp1 = out.timers;
+				for (i = 0; i < ntimers; i++)
+					*tp1++ += *tp++;
+			} while ((task = next_thread(task)) != leader_task);
+			read_unlock(&tasklist_lock);
+			tp = out.timers;
+		}
+		else 
+			tp = msp->timers;
+		preempt_enable();
+		break;
+
+	case MSA_CHILDREN:
+		tp =  msp->child_timers;
+		break;
+	}
+
+	for (i = 0; i < ntimers; i++) {
+		__u64 x = MSA_TO_NSEC(*tp++);
+		if (copy_to_user(timers++, &x, sizeof x))
+			return -EFAULT;
+	}
+
+	return 0L;
+}
+
+#else
+/*
+ * Stub for sys_msa when CONFIG_MICROSTATES is off.
+ */
+asmlinkage long sys_msa(int ntimers, __u64 *timers)
+{
+	return -ENOSYS;
+}
+#endif
Index: linux-2.6-ustate/include/linux/msa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/include/linux/msa.h	2005-03-11 09:58:20.575007323 +1100
@@ -0,0 +1,46 @@
+/* 
+ * msa.h
+ * microstate accounting --- definitions shared with userspace.
+ */
+
+#ifndef _LINUX_MSA_H
+#define _LINUX_MSA_H
+
+typedef __u64 clk_t;
+
+/*
+ * Tracked states
+ */
+
+enum thread_state {
+	MSA_UNKNOWN = -1,
+	ONCPU_USER,
+	ONCPU_SYS,
+	INTERRUPTIBLE_SLEEP,
+	UNINTERRUPTIBLE_SLEEP,
+	ONACTIVEQUEUE,
+	ONEXPIREDQUEUE,
+	ZOMBIE,
+	STOPPED,
+	INTERRUPTED,
+	PAGING_SLEEP,
+	FUTEX_SLEEP,
+	POLL_SLEEP,
+	
+	NR_MICRO_STATES /* Must be last */
+};
+
+
+/*
+ * A system call for getting the timers.
+ * The number of timers wanted is passed as argument, in case not all 
+ * are needed (and to guard against when we add more timers!)
+ */
+
+#define MSA_THREAD 0		/* Just the current thread */
+#define MSA_SELF 2		/* All threads in current process */
+#define MSA_CHILDREN 1		/* All (dead and waited-for) threads */
+
+extern long msa(int ntimers, int which, __u64 __user *timers);
+
+#endif /* _LINUX_MSA_H */
Index: linux-2.6-ustate/kernel/Makefile
===================================================================
--- linux-2.6-ustate.orig/kernel/Makefile	2005-03-11 09:58:15.312352035 +1100
+++ linux-2.6-ustate/kernel/Makefile	2005-03-11 09:58:20.575007323 +1100
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o msa.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6-ustate/include/linux/sched.h
===================================================================
--- linux-2.6-ustate.orig/include/linux/sched.h	2005-03-11 09:58:15.352390793 +1100
+++ linux-2.6-ustate/include/linux/sched.h	2005-03-11 09:58:52.134337814 +1100
@@ -14,6 +14,7 @@
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
 #include <linux/errno.h>
+#include <linux/msa-kernel.h>
 #include <linux/nodemask.h>
 
 #include <asm/system.h>
@@ -625,6 +626,9 @@
 	cputime_t utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
+   #ifdef CONFIG_MICROSTATE
+   	struct microstates microstates;
+   #endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt;
 
Index: linux-2.6-ustate/include/asm-generic/msa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/include/asm-generic/msa.h	2005-03-11 09:58:20.578913543 +1100
@@ -0,0 +1,21 @@
+/*
+ * asm-generic/msa.h
+ * Provide a generic time-of-day clock for 
+ * microstate accounting.
+ */
+
+#ifndef _ASM_GENERIC_MSA_H
+#define _ASM_GENERIC_MSA_H
+
+typedef __u64 clk_t;
+
+# ifdef __KERNEL__
+/*
+ * Every architecture is supposed to provide sched_clock, a free-running, 
+ * non-wrapping, per-cpu clock in nanoseconds.
+ */
+#  define MSA_NOW(now)  do { (now) = sched_clock(); } while (0)
+#  define MSA_TO_NSEC(clk) (clk)
+# endif
+
+#endif /* _ASM_GENERIC_MSA_H */
Index: linux-2.6-ustate/include/linux/msa-kernel.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/include/linux/msa-kernel.h	2005-03-11 09:58:20.579890099 +1100
@@ -0,0 +1,99 @@
+/* 
+ * linux/msa-kernel.h
+ * microstate accounting definitions needed by the Linux kernel.
+ */
+
+#ifndef _LINUX_MSA_KERNEL__H
+#define _LINUX_MSA_KERNEL_H
+
+#include <linux/config.h>
+#include <linux/msa.h>
+
+#ifdef CONFIG_MICROSTATE
+# include <asm/msa.h>
+#endif
+
+
+/*
+ * Times are tracked for the current task in timers[], and for the
+ * current task's children in child_timers[] (accumulated at wait()
+ * time).  One of these structures is added to every struct task_struct.
+ */
+struct microstates {
+	enum thread_state cur_state;
+	enum thread_state next_state;
+	int lastqueued;		/* processor this thread was last queued for */
+	unsigned flags;
+	clk_t last_change;	/* When the last change happened */
+	clk_t timers[NR_MICRO_STATES];
+	clk_t child_timers[NR_MICRO_STATES];
+};
+
+/*
+ * Values for microstates.flags
+ */
+#define QUEUE_FLIPPED	(1<<0)	/* Active and Expired queues were swapped */
+#define MSA_SYS		(1<<1)	/* This task executing in system call */
+
+
+extern long sys_msa(int ntimers, int which, clk_t __user *timers);
+
+
+#if defined(CONFIG_MICROSTATE)
+# include <asm/current.h>
+# include <asm/irq.h>
+
+
+#define MSA_SOFTIRQ NR_IRQS
+
+void msa_init_timer(struct task_struct *task);
+void msa_switch(struct task_struct *prev, struct task_struct *next);
+void msa_update_parent(struct task_struct *parent, struct task_struct *this);
+void msa_init(struct task_struct *p);
+void msa_set_timer(struct task_struct *p, int state);
+void msa_start_irq(int irq);
+void msa_continue_irq(int oldirq, int newirq);
+void msa_finish_irq(int irq);
+void msa_start_syscall(void);
+void msa_end_syscall(void);
+
+clk_t msa_irq_time(int cpu, int irq);
+
+# ifdef TASK_STRUCT_DEFINED
+
+static inline void msa_next_state(struct task_struct *p, enum thread_state next_state) 
+{
+	p->microstates.next_state = next_state;
+}
+
+static inline void msa_flip_expired(struct task_struct *prev) {
+	prev->microstates.flags |= QUEUE_FLIPPED;
+}
+
+# else
+#  define msa_next_state(p, s) ((p)->microstates.next_state = (s))
+#  define msa_flip_expired(p) ((p)->microstates.flags |= QUEUE_FLIPPED)
+# endif
+
+#else /* CONFIG_MICROSTATE */
+
+/*
+ * Dummy functions to do nothing, for when MICROSTATE is configured off.
+ */
+static inline void msa_switch(struct task_struct *prev, struct task_struct *next) { }
+static inline void msa_update_parent(struct task_struct *parent, struct task_struct *this) { }
+
+static inline void msa_init(struct task_struct *p) { }
+static inline void msa_set_timer(struct task_struct *p, int state) { }
+static inline void msa_start_irq(int irq) { }
+static inline void msa_continue_irq(int oldirq, int newirq) { }
+static inline void msa_finish_irq(int irq) { };
+
+static inline clk_t msa_irq_time(int cpu, int irq) { return 0; }
+static inline void msa_next_state(struct task_struct *p, int s) { }
+static inline void msa_flip_expired(struct task_struct *p) { }
+static inline void msa_start_syscall(void) { }
+static inline void msa_end_syscall(void) { }
+
+#endif /* CONFIG_MICROSTATE */
+#endif /* _LINUX_MSA_KERNEL_H */
Index: linux-2.6-ustate/kernel/fork.c
===================================================================
--- linux-2.6-ustate.orig/kernel/fork.c	2005-03-11 09:58:15.395359216 +1100
+++ linux-2.6-ustate/kernel/fork.c	2005-03-11 09:58:20.580866654 +1100
@@ -891,6 +891,8 @@
 
 	p->proc_dentry = NULL;
 
+	msa_init(p);
+
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	p->vfork_done = NULL;
