Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUIOPSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUIOPSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIOPSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:18:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39836 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266386AbUIOPRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:17:00 -0400
Date: Wed, 15 Sep 2004 17:18:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915151815.GA30138@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch is a new approach to get rid of Linux's Big Kernel
Lock as we know it today.

The trick is to turn the BKL spinlock + depth counter into a special
type of cpu-affine, recursive semaphore, which gets released by
schedule() but not by preempt_schedule().

this gives the following advantages:

- BKL critical sections are fully preemptable with this patch applied

- there is no time wasted spinning on the BKL if there's BKL contention

- no changes are needed for lock_kernel() users - the new
  semaphore-based approach is fully compatible with the BKL.

code using lock_kernel()/unlock_kernel() will see very similar semantics
as they got from the BKL, so correctness should be fully preserved. 
Per-CPU assumptions still work, locking exclusion and lock-recursion
still works the same way as it did with the BKL.

non-BKL code sees no overhead from this approach. (other than the
slighly smaller code due to the uninlining of the BKL APIs.)

(the patch is against vanilla 2.6.9-rc2. I have tested it on x86
UP+PREEMPT, UP+!PREEMPT, SMP+PREEMPT, SMP+!PREEMPT and x64 SMP+PREEMPT.)

	Ingo

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="remove-bkl.patch"


the attached patch is a new approach to get rid of Linux's Big Kernel
Lock as we know it today.

The trick is to turn the BKL spinlock + depth counter into a special
type of cpu-affine, recursive semaphore, which gets released by
schedule() but not by preempt_schedule().

this gives the following advantages:

- BKL critical sections are fully preemptable with this patch applied

- there is no time wasted spinning on the BKL if there's BKL contention

- no changes are needed for lock_kernel() users - the new
  semaphore-based approach is fully compatible with the BKL.

code using lock_kernel()/unlock_kernel() will see very similar semantics
as they got from the BKL, so correctness should be fully preserved.
Per-CPU assumptions still work, locking exclusion and lock-recursion
still works the same way as it did with the BKL.

non-BKL code sees no overhead from this approach. (other than the
slighly smaller code due to the uninlining of the BKL APIs.)

(the patch is against vanilla 2.6.9-rc2. I have tested it on x86
UP+PREEMPT, UP+!PREEMPT, SMP+PREEMPT, SMP+!PREEMPT and x64 SMP+PREEMPT.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/smp_lock.h.orig	
+++ linux/include/linux/smp_lock.h	
@@ -7,59 +7,14 @@
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
-extern spinlock_t kernel_flag;
-
-#define kernel_locked()		(current->lock_depth >= 0)
-
-#define get_kernel_lock()	spin_lock(&kernel_flag)
-#define put_kernel_lock()	spin_unlock(&kernel_flag)
-
-/*
- * Release global kernel lock.
- */
-static inline void release_kernel_lock(struct task_struct *task)
-{
-	if (unlikely(task->lock_depth >= 0))
-		put_kernel_lock();
-}
-
-/*
- * Re-acquire the kernel lock
- */
-static inline void reacquire_kernel_lock(struct task_struct *task)
-{
-	if (unlikely(task->lock_depth >= 0))
-		get_kernel_lock();
-}
-
-/*
- * Getting the big kernel lock.
- *
- * This cannot happen asynchronously,
- * so we only need to worry about other
- * CPU's.
- */
-static inline void lock_kernel(void)
-{
-	int depth = current->lock_depth+1;
-	if (likely(!depth))
-		get_kernel_lock();
-	current->lock_depth = depth;
-}
-
-static inline void unlock_kernel(void)
-{
-	BUG_ON(current->lock_depth < 0);
-	if (likely(--current->lock_depth < 0))
-		put_kernel_lock();
-}
+extern int kernel_locked(void);
+extern void lock_kernel(void);
+extern void unlock_kernel(void);
 
 #else
 
 #define lock_kernel()				do { } while(0)
 #define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task)		do { } while(0)
-#define reacquire_kernel_lock(task)		do { } while(0)
 #define kernel_locked()				1
 
 #endif /* CONFIG_SMP || CONFIG_PREEMPT */
--- linux/include/linux/hardirq.h.orig	
+++ linux/include/linux/hardirq.h	
@@ -32,12 +32,12 @@
 #define hardirq_trylock()	(!in_interrupt())
 #define hardirq_endlock()	do { } while (0)
 
+#define in_atomic()		((preempt_count() & ~PREEMPT_ACTIVE) != 0)
+
 #ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
-# define in_atomic()	(preempt_count() != 0)
 # define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -454,6 +454,7 @@ struct task_struct {
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
+	cpumask_t saved_cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
 #ifdef CONFIG_SCHEDSTATS
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -2620,6 +2620,121 @@ static inline int dependent_sleeper(int 
 }
 #endif
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+
+/*
+ * The 'big kernel semaphore'
+ *
+ * This mutex is taken and released recursively by lock_kernel()
+ * and unlock_kernel().  It is transparently dropped and reaquired
+ * over schedule().  It is used to protect legacy code that hasn't
+ * been migrated to a proper locking design yet.
+ *
+ * Note: code locked by this semaphore will only be serialized against
+ * other code using the same locking facility. The code guarantees that
+ * the task remains on the same CPU.
+ *
+ * Don't use in new code.
+ */
+static __cacheline_aligned_in_smp DECLARE_MUTEX(kernel_sem);
+
+int kernel_locked(void)
+{
+	return current->lock_depth >= 0;
+}
+
+EXPORT_SYMBOL(kernel_locked);
+
+static inline void put_kernel_sem(void)
+{
+	current->cpus_allowed = current->saved_cpus_allowed;
+	up(&kernel_sem);
+}
+
+/*
+ * Release global kernel semaphore:
+ */
+static inline void release_kernel_sem(struct task_struct *task)
+{
+	if (unlikely(task->lock_depth >= 0))
+		put_kernel_sem();
+}
+
+/*
+ * Re-acquire the kernel semaphore.
+ *
+ * This function is called with preemption off.
+ *
+ * We are executing in schedule() so the code must be extremely careful
+ * about recursion, both due to the down() and due to the enabling of
+ * preemption. schedule() will re-check the preemption flag after
+ * reacquiring the semaphore.
+ */
+static inline void reacquire_kernel_sem(struct task_struct *task)
+{
+	int this_cpu, saved_lock_depth = task->lock_depth;
+
+	if (likely(saved_lock_depth < 0))
+		return;
+
+	task->lock_depth = -1;
+	preempt_enable_no_resched();
+
+	down(&kernel_sem);
+
+	this_cpu = get_cpu();
+	/*
+	 * Magic. We can pin the task to this CPU safely and
+	 * cheaply here because we have preemption disabled
+	 * and we are obviously running on the current CPU:
+	 */
+	current->saved_cpus_allowed = current->cpus_allowed;
+	current->cpus_allowed = cpumask_of_cpu(this_cpu);
+	task->lock_depth = saved_lock_depth;
+}
+
+/*
+ * Getting the big kernel semaphore.
+ */
+void lock_kernel(void)
+{
+	int this_cpu, depth = current->lock_depth + 1;
+
+	if (likely(!depth)) {
+		/*
+		 * No recursion worries - we set up lock_depth _after_
+		 */
+		down(&kernel_sem);
+
+		this_cpu = get_cpu();
+		current->saved_cpus_allowed = current->cpus_allowed;
+		current->cpus_allowed = cpumask_of_cpu(this_cpu);
+		current->lock_depth = depth;
+		put_cpu();
+	} else
+		current->lock_depth = depth;
+}
+
+EXPORT_SYMBOL(lock_kernel);
+
+void unlock_kernel(void)
+{
+	BUG_ON(current->lock_depth < 0);
+
+	if (likely(--current->lock_depth < 0))
+		put_kernel_sem();
+}
+
+EXPORT_SYMBOL(unlock_kernel);
+
+#else
+
+static inline void release_kernel_sem(struct task_struct *task) { }
+static inline void reacquire_kernel_sem(struct task_struct *task) { }
+
+#endif
+
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -2660,7 +2775,7 @@ need_resched:
 		dump_stack();
 	}
 
-	release_kernel_lock(prev);
+	release_kernel_sem(prev);
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
 	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
@@ -2781,7 +2896,7 @@ switch_tasks:
 	} else
 		spin_unlock_irq(&rq->lock);
 
-	reacquire_kernel_lock(current);
+	reacquire_kernel_sem(current);
 	preempt_enable_no_resched();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
@@ -2798,6 +2913,7 @@ EXPORT_SYMBOL(schedule);
 asmlinkage void __sched preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
+	int saved_lock_depth;
 
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
@@ -2808,7 +2924,15 @@ asmlinkage void __sched preempt_schedule
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
+	/*
+	 * We keep the big kernel semaphore locked, but we
+	 * clear ->lock_depth so that schedule() doesnt
+	 * auto-release the semaphore:
+	 */
+	saved_lock_depth = current->lock_depth;
+	current->lock_depth = 0;
 	schedule();
+	current->lock_depth = saved_lock_depth;
 	ti->preempt_count = 0;
 
 	/* we could miss a preemption opportunity between schedule and now */
@@ -3772,11 +3896,7 @@ void __devinit init_idle(task_t *idle, i
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-#ifdef CONFIG_PREEMPT
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
-#else
 	idle->thread_info->preempt_count = 0;
-#endif
 }
 
 /*
@@ -3821,13 +3941,17 @@ int set_cpus_allowed(task_t *p, cpumask_
 	migration_req_t req;
 	runqueue_t *rq;
 
+	lock_kernel();
 	rq = task_rq_lock(p, &flags);
 	if (!cpus_intersects(new_mask, cpu_online_map)) {
+		unlock_kernel();
 		ret = -EINVAL;
 		goto out;
 	}
 
 	p->cpus_allowed = new_mask;
+	unlock_kernel();
+
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpu_isset(task_cpu(p), new_mask))
 		goto out;
@@ -4175,21 +4299,6 @@ int __init migration_init(void)
 }
 #endif
 
-/*
- * The 'big kernel lock'
- *
- * This spinlock is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
- * over schedule().  It is used to protect legacy code that hasn't
- * been migrated to a proper locking design yet.
- *
- * Don't use in new code.
- *
- * Note: spinlock debugging needs this even on !CONFIG_SMP.
- */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-EXPORT_SYMBOL(kernel_flag);
-
 #ifdef CONFIG_SMP
 /* Attach the domain 'sd' to 'cpu' as its base domain */
 static void cpu_attach_domain(struct sched_domain *sd, int cpu)
--- linux/init/main.c.orig	
+++ linux/init/main.c	
@@ -435,6 +435,7 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
+	preempt_enable_no_resched();
  	cpu_idle();
 } 
 
@@ -500,6 +501,12 @@ asmlinkage void __init start_kernel(void
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	/*
+	 * The early boot stage up until we run the first idle thread
+	 * is a very volatile affair for the scheduler. Disable preemption
+	 * up until the init thread has been started:
+	 */
+	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);

--Dxnq1zWXvFF0Q93v--
