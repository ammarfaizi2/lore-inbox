Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVDBDUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVDBDUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVDBDTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:19:54 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:42578 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262981AbVDBDS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:18:59 -0500
Message-ID: <424E0F1E.4050908@yahoo.com.au>
Date: Sat, 02 Apr 2005 13:18:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] cleanup context switch locking
Content-Type: multipart/mixed;
 boundary="------------010401020008050105040406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401020008050105040406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This went to linux-arch, but didn't get much response. Dave Miller
thought it looked fine, although I guess this was probably "in
concept" rather than a detailed review.

Andrew, would you care to put it in -mm, or would you rather we get
through the current scheduler patches first? (Note that this patch
is completely seperate to them, and shouldn't change behaviour nor
cause many patch conflicts, I hope).

Been tested on a few things, i386, x86-64, sparc64, ia64.

-- 
SUSE Labs, Novell Inc.

--------------010401020008050105040406
Content-Type: text/plain;
 name="task-running-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="task-running-flag.patch"

Instead of requiring architecture code to interact with the scheduler's
locking implementation, provide a couple of defines that can be used by
the architecture to request runqueue unlocked context switches, and ask
for interrupts to be enabled over the context switch.

Also replaces the "switch_lock" used by these architectures with an oncpu
flag (note, not a potentially slow bitflag). This eliminates one bus locked
memory operation when context switching, and simplifies the task_running
function.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-03-27 13:03:55.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-03-27 13:04:10.000000000 +1000
@@ -269,14 +269,71 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
-/*
- * Default context-switch locking:
- */
 #ifndef prepare_arch_switch
-# define prepare_arch_switch(rq, next)	do { } while (0)
-# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define prepare_arch_switch(next)	do { } while (0)
+#endif
+#ifndef finish_arch_switch
+# define finish_arch_switch(prev)	do { } while (0)
+#endif
+
+#ifndef __ARCH_WANT_UNLOCKED_CTXSW
+static inline int task_running(runqueue_t *rq, task_t *p)
+{
+	return rq->curr == p;
+}
+
+static inline void prepare_lock_switch(runqueue_t *rq, task_t *next)
+{
+}
+
+static inline void finish_lock_switch(runqueue_t *rq, task_t *prev)
+{
+	spin_unlock_irq(&rq->lock);
+}
+
+#else /* __ARCH_WANT_UNLOCKED_CTXSW */
+static inline int task_running(runqueue_t *rq, task_t *p)
+{
+#ifdef CONFIG_SMP
+	return p->oncpu;
+#else
+	return rq->curr == p;
+#endif
+}
+
+static inline void prepare_lock_switch(runqueue_t *rq, task_t *next)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * We can optimise this out completely for !SMP, because the
+	 * SMP rebalancing from interrupt is the only thing that cares
+	 * here.
+	 */
+	next->oncpu = 1;
+#endif
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	spin_unlock_irq(&rq->lock);
+#else
+	spin_unlock(&rq->lock);
 #endif
+}
+
+static inline void finish_lock_switch(runqueue_t *rq, task_t *prev)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * After ->oncpu is cleared, the task can be moved to a different CPU.
+	 * We must ensure this doesn't happen until the switch is completely
+	 * finished.
+	 */
+	smp_wmb();
+	prev->oncpu = 0;
+#endif
+#ifndef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	local_irq_enable();
+#endif
+}
+#endif /* __ARCH_WANT_UNLOCKED_CTXSW */
 
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
@@ -1197,17 +1254,14 @@ void fastcall sched_fork(task_t *p)
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
 	p->array = NULL;
-	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
+#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+	p->oncpu = 0;
+#endif
 #ifdef CONFIG_PREEMPT
-	/*
-	 * During context-switch we hold precisely one spinlock, which
-	 * schedule_tail drops. (in the common case it's this_rq()->lock,
-	 * but it also can be p->switch_lock.) So we compensate with a count
-	 * of 1. Also, we want to start with kernel preemption disabled.
-	 */
+	/* Want to start with kernel preemption disabled. */
 	p->thread_info->preempt_count = 1;
 #endif
 	/*
@@ -1389,22 +1443,40 @@ void fastcall sched_exit(task_t * p)
 }
 
 /**
+ * prepare_task_switch - prepare to switch tasks
+ * @rq: the runqueue preparing to switch
+ * @next: the task we are going to switch to.
+ *
+ * This is called with the rq lock held and interrupts off. It must
+ * be paired with a subsequent finish_task_switch after the context
+ * switch.
+ *
+ * prepare_task_switch sets up locking and calls architecture specific
+ * hooks.
+ */
+static inline void prepare_task_switch(runqueue_t *rq, task_t *next)
+{
+	prepare_lock_switch(rq, next);
+	prepare_arch_switch(next);
+}
+
+/**
  * finish_task_switch - clean up after a task-switch
  * @prev: the thread we just switched away from.
  *
- * We enter this with the runqueue still locked, and finish_arch_switch()
- * will unlock it along with doing any other architecture-specific cleanup
- * actions.
+ * finish_task_switch must be called after the context switch, paired
+ * with a prepare_task_switch call before the context switch.
+ * finish_task_switch will reconcile locking set up by prepare_task_switch,
+ * and do any other architecture-specific cleanup actions.
  *
  * Note that we may have delayed dropping an mm in context_switch(). If
  * so, we finish that here outside of the runqueue lock.  (Doing it
  * with the lock held can cause deadlocks; see schedule() for
  * details.)
  */
-static inline void finish_task_switch(task_t *prev)
+static inline void finish_task_switch(runqueue_t *rq, task_t *prev)
 	__releases(rq->lock)
 {
-	runqueue_t *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
 	unsigned long prev_task_flags;
 
@@ -1422,7 +1494,8 @@ static inline void finish_task_switch(ta
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
 	prev_task_flags = prev->flags;
-	finish_arch_switch(rq, prev);
+	finish_arch_switch(prev);
+	finish_lock_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
 	if (unlikely(prev_task_flags & PF_DEAD))
@@ -1436,8 +1509,12 @@ static inline void finish_task_switch(ta
 asmlinkage void schedule_tail(task_t *prev)
 	__releases(rq->lock)
 {
-	finish_task_switch(prev);
-
+	runqueue_t *rq = this_rq();
+	finish_task_switch(rq, prev);
+#ifdef __ARCH_WANT_UNLOCKED_CTXSW
+	/* In this case, finish_task_switch does not reenable preemption */
+	preempt_enable();
+#endif
 	if (current->set_child_tid)
 		put_user(current->pid, current->set_child_tid);
 }
@@ -2820,11 +2897,15 @@ switch_tasks:
 		rq->curr = next;
 		++*switch_count;
 
-		prepare_arch_switch(rq, next);
+		prepare_task_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
-
-		finish_task_switch(prev);
+		/*
+		 * this_rq must be evaluated again because prev may have moved
+		 * CPUs since it called schedule(), thus the 'rq' on its stack
+		 * frame will be invalid.
+		 */
+		finish_task_switch(this_rq(), prev);
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -4075,6 +4156,9 @@ void __devinit init_idle(task_t *idle, i
 
 	spin_lock_irqsave(&rq->lock, flags);
 	rq->curr = rq->idle = idle;
+#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+	idle->oncpu = 1;
+#endif
 	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-03-27 13:03:55.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2005-03-27 13:04:10.000000000 +1000
@@ -357,6 +357,11 @@ struct signal_struct {
 #endif
 };
 
+/* Context switch must be unlocked if interrupts are to be enabled */
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+# define __ARCH_WANT_UNLOCKED_CTXSW
+#endif
+
 /*
  * Bits in flags field of signal_struct.
  */
@@ -582,6 +587,9 @@ struct task_struct {
 
 	int lock_depth;		/* Lock depth */
 
+#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
+	int oncpu;
+#endif
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
@@ -700,8 +708,6 @@ struct task_struct {
 	spinlock_t alloc_lock;
 /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
 	spinlock_t proc_lock;
-/* context-switch lock */
-	spinlock_t switch_lock;
 
 /* journalling filesystem info */
 	void *journal_info;
Index: linux-2.6/include/linux/init_task.h
===================================================================
--- linux-2.6.orig/include/linux/init_task.h	2005-03-27 13:03:55.000000000 +1000
+++ linux-2.6/include/linux/init_task.h	2005-03-27 13:04:10.000000000 +1000
@@ -108,7 +108,6 @@ extern struct group_info init_groups;
 	.blocked	= {{0}},					\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
-	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 }
Index: linux-2.6/include/asm-ia64/system.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-ia64/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -183,8 +183,6 @@ do {								\
 
 #ifdef __KERNEL__
 
-#define prepare_to_switch()    do { } while(0)
-
 #ifdef CONFIG_IA32_SUPPORT
 # define IS_IA32_PROCESS(regs)	(ia64_psr(regs)->is != 0)
 #else
@@ -274,13 +272,7 @@ extern void ia64_load_extra (struct task
  * of that CPU which will not be released, because there we wait for the
  * tasklist_lock to become available.
  */
-#define prepare_arch_switch(rq, next)		\
-do {						\
-	spin_lock(&(next)->switch_lock);	\
-	spin_unlock(&(rq)->lock);		\
-} while (0)
-#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(prev)->switch_lock)
-#define task_running(rq, p) 		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
+#define __ARCH_WANT_UNLOCKED_CTXSW
 
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
Index: linux-2.6/include/asm-mips/system.h
===================================================================
--- linux-2.6.orig/include/asm-mips/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-mips/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -422,16 +422,10 @@ extern void __die_if_kernel(const char *
 extern int stop_a_enabled;
 
 /*
- * Taken from include/asm-ia64/system.h; prevents deadlock on SMP
+ * See include/asm-ia64/system.h; prevents deadlock on SMP
  * systems.
  */
-#define prepare_arch_switch(rq, next)		\
-do {						\
-	spin_lock(&(next)->switch_lock);	\
-	spin_unlock(&(rq)->lock);		\
-} while (0)
-#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(prev)->switch_lock)
-#define task_running(rq, p) 		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
+#define __ARCH_WANT_UNLOCKED_CTXSW
 
 #define arch_align_stack(x) (x)
 
Index: linux-2.6/include/asm-s390/system.h
===================================================================
--- linux-2.6.orig/include/asm-s390/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-s390/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -103,29 +103,18 @@ static inline void restore_access_regs(u
 	prev = __switch_to(prev,next);					     \
 } while (0)
 
-#define prepare_arch_switch(rq, next)	do { } while(0)
-#define task_running(rq, p)		((rq)->curr == (p))
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void account_user_vtime(struct task_struct *);
 extern void account_system_vtime(struct task_struct *);
-
-#define finish_arch_switch(rq, prev) do {				     \
-	set_fs(current->thread.mm_segment);				     \
-	spin_unlock(&(rq)->lock);					     \
-	account_system_vtime(prev);					     \
-	local_irq_enable();						     \
-} while (0)
-
 #else
+#define account_system_vtime(prev) do { } while (0)
+#endif
 
 #define finish_arch_switch(rq, prev) do {				     \
 	set_fs(current->thread.mm_segment);				     \
-	spin_unlock_irq(&(rq)->lock);					     \
+	account_system_vtime(prev);					     \
 } while (0)
 
-#endif
-
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
Index: linux-2.6/include/asm-sparc/system.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-sparc/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -101,7 +101,7 @@ extern void fpsave(unsigned long *fpregs
  * SWITCH_ENTER and SWITH_DO_LAZY_FPU do not work yet (e.g. SMP does not work)
  * XXX WTF is the above comment? Found in late teen 2.4.x.
  */
-#define prepare_arch_switch(rq, next) do { \
+#define prepare_arch_switch(next) do { \
 	__asm__ __volatile__( \
 	".globl\tflush_patch_switch\nflush_patch_switch:\n\t" \
 	"save %sp, -0x40, %sp; save %sp, -0x40, %sp; save %sp, -0x40, %sp\n\t" \
@@ -109,8 +109,6 @@ extern void fpsave(unsigned long *fpregs
 	"save %sp, -0x40, %sp\n\t" \
 	"restore; restore; restore; restore; restore; restore; restore"); \
 } while(0)
-#define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-#define task_running(rq, p)		((rq)->curr == (p))
 
 	/* Much care has gone into this code, do not touch it.
 	 *
Index: linux-2.6/include/asm-sparc64/system.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-sparc64/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -139,19 +139,13 @@ extern void __flushw_user(void);
 #define flush_user_windows flushw_user
 #define flush_register_windows flushw_all
 
-#define prepare_arch_switch(rq, next)		\
-do {	spin_lock(&(next)->switch_lock);	\
-	spin_unlock(&(rq)->lock);		\
+/* Don't hold the runqueue lock over context switch */
+#define __ARCH_WANT_UNLOCKED_CTXSW
+#define prepare_arch_switch(next)		\
+do {						\
 	flushw_all();				\
 } while (0)
 
-#define finish_arch_switch(rq, prev)		\
-do {	spin_unlock_irq(&(prev)->switch_lock);	\
-} while (0)
-
-#define task_running(rq, p) \
-	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
-
 	/* See what happens when you design the chip correctly?
 	 *
 	 * We tell gcc we clobber all non-fixed-usage registers except
Index: linux-2.6/include/asm-arm/system.h
===================================================================
--- linux-2.6.orig/include/asm-arm/system.h	2005-03-27 13:03:56.000000000 +1000
+++ linux-2.6/include/asm-arm/system.h	2005-03-27 13:04:10.000000000 +1000
@@ -141,34 +141,12 @@ extern unsigned int user_debug;
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
-#ifdef CONFIG_SMP
 /*
- * Define our own context switch locking.  This allows us to enable
- * interrupts over the context switch, otherwise we end up with high
- * interrupt latency.  The real problem area is switch_mm() which may
- * do a full cache flush.
+ * switch_mm() may do a full cache flush over the context switch,
+ * so enable interrupts over the context switch to avoid high
+ * latency.
  */
-#define prepare_arch_switch(rq,next)					\
-do {									\
-	spin_lock(&(next)->switch_lock);				\
-	spin_unlock_irq(&(rq)->lock);					\
-} while (0)
-
-#define finish_arch_switch(rq,prev)					\
-	spin_unlock(&(prev)->switch_lock)
-
-#define task_running(rq,p)						\
-	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
-#else
-/*
- * Our UP-case is more simple, but we assume knowledge of how
- * spin_unlock_irq() and friends are implemented.  This avoids
- * us needlessly decrementing and incrementing the preempt count.
- */
-#define prepare_arch_switch(rq,next)	local_irq_enable()
-#define finish_arch_switch(rq,prev)	spin_unlock(&(rq)->lock)
-#define task_running(rq,p)		((rq)->curr == (p))
-#endif
+#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
 
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'

--------------010401020008050105040406--

