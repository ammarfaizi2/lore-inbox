Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268675AbUIQKih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268675AbUIQKih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUIQKif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:38:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38085 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268675AbUIQKiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:38:04 -0400
Date: Fri, 17 Sep 2004 12:39:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917103945.GA19861@elte.hu>
References: <20040915151815.GA30138@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915151815.GA30138@elte.hu>
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


the attached patch is a simplified variant of the remove-bkl patch i
sent two days ago: it doesnt do the ->cpus_allowed trick.

The question is, is there any BKL-using kernel code that relies on the
task not migrating to another CPU within the BLK critical section?

(Patch is against 2.6.9-rc2-mm1. Patch booted fine on x86 SMP+PREEMPT
and UP and the previous patch was tested on x64 as well so i'd expect
this one to work fine on all platforms.)

	Ingo

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
@@ -27,12 +27,12 @@
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
 
+#define in_atomic()		((preempt_count() & ~PREEMPT_ACTIVE) != 0)
+
 #ifdef CONFIG_PREEMPT
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != 0)
 # define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -2288,6 +2288,105 @@ static inline int dependent_sleeper(int 
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
+/*
+ * Release global kernel semaphore:
+ */
+static inline void release_kernel_sem(struct task_struct *task)
+{
+	if (unlikely(task->lock_depth >= 0))
+		up(&kernel_sem);
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
+	int saved_lock_depth = task->lock_depth;
+
+	if (likely(saved_lock_depth < 0))
+		return;
+
+	task->lock_depth = -1;
+	preempt_enable_no_resched();
+
+	down(&kernel_sem);
+
+	preempt_disable();
+	task->lock_depth = saved_lock_depth;
+}
+
+/*
+ * Getting the big kernel semaphore.
+ */
+void lock_kernel(void)
+{
+	struct task_struct *task = current;
+	int depth = task->lock_depth + 1;
+
+	if (likely(!depth))
+		/*
+		 * No recursion worries - we set up lock_depth _after_
+		 */
+		down(&kernel_sem);
+
+	task->lock_depth = depth;
+}
+
+EXPORT_SYMBOL(lock_kernel);
+
+void unlock_kernel(void)
+{
+	struct task_struct *task = current;
+
+	BUG_ON(task->lock_depth < 0);
+
+	if (likely(--task->lock_depth < 0))
+		up(&kernel_sem);
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
@@ -2328,7 +2427,7 @@ need_resched:
 		dump_stack();
 	}
 
-	release_kernel_lock(prev);
+	release_kernel_sem(prev);
 	schedstat_inc(rq, sched_cnt);
 	now = clock_us();
 	run_time = now - prev->timestamp;
@@ -2443,7 +2542,7 @@ switch_tasks:
 	} else
 		spin_unlock_irq(&rq->lock);
 
-	reacquire_kernel_lock(current);
+	reacquire_kernel_sem(current);
 	preempt_enable_no_resched();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
@@ -2460,6 +2559,8 @@ EXPORT_SYMBOL(schedule);
 asmlinkage void __sched preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
+	struct task_struct *task = current;
+	int saved_lock_depth;
 
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
@@ -2470,7 +2571,15 @@ asmlinkage void __sched preempt_schedule
 
 need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
+	/*
+	 * We keep the big kernel semaphore locked, but we
+	 * clear ->lock_depth so that schedule() doesnt
+	 * auto-release the semaphore:
+	 */
+	saved_lock_depth = task->lock_depth;
+	task->lock_depth = 0;
 	schedule();
+	task->lock_depth = saved_lock_depth;
 	ti->preempt_count = 0;
 
 	/* we could miss a preemption opportunity between schedule and now */
@@ -3519,11 +3628,7 @@ void __devinit init_idle(task_t *idle, i
 	spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-#ifdef CONFIG_PREEMPT
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
-#else
 	idle->thread_info->preempt_count = 0;
-#endif
 }
 
 /*
@@ -3924,21 +4029,6 @@ int __init migration_init(void)
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
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
--- linux/init/main.c.orig	
+++ linux/init/main.c	
@@ -436,6 +436,7 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
+	preempt_enable_no_resched();
  	cpu_idle();
 } 
 
@@ -501,6 +502,12 @@ asmlinkage void __init start_kernel(void
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
 	trap_init();
