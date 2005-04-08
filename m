Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVDHMQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVDHMQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVDHMQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:16:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53143 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262790AbVDHMQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:16:22 -0400
Date: Fri, 8 Apr 2005 14:16:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-arch@vger.kernel.org
Subject: [patch] sched: unlocked context-switches
Message-ID: <20050408121611.GA21026@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.223, required 5.9,
	BAYES_00 -4.90, SUBJ_HAS_UNIQ_ID 2.68
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the scheduler still has a complex maze of locking in the *arch_switch() 
/ *lock_switch() code. Different arches do it differently, creating 
diverging context-switch behavior. There are now 3 variants: fully 
locked, unlocked but irqs-off, unlocked and irqs-on.

Nick has cleaned them up in sched-cleanup-context-switch-locking.patch, 
but i'm still not happy with the end result. So here's a more radical 
approach: do all context-switching without the runqueue lock held and 
with interrupts enabled.

the patch below (which is against Andrew's current scheduler queue) thus 
unifies all arches and greatly simplifies things:

 9 files changed, 83 insertions(+), 236 deletions(-)

other details:

- switched the order of stack/register-switching and MM-switching: we 
  now first switch the stack and registers, this further simplified
  things.

- introduced set_task_on_cpu/task_on_cpu to unify ->oncpu and
  task_running naming and to simplify usage. Did s/oncpu/on_cpu.

- dropped rq->prev_mm - it's now all straight code in one function.

- moved Sparc/Sparc64's prepare_arch_switch() code to the head of
  their switch_to() macros, and s390's finish_arch_switch() to
  the tail of switch_to().

tested on x86, and all other arches should work as well, but if an 
architecture has irqs-off assumptions in its switch_to() logic it might 
break. (I havent found any but there may such assumptions.)

i've measured no regressions in context-switch performance (lat_ctx,
hackbench), on a UP x86 and an 8-way SMP x86 box. Tested it on
PREEMPT/!PREEMPT/SMP/!SMP, on x86 and x64.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -222,7 +222,6 @@ struct runqueue {
 	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
-	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int best_expired_prio;
 	atomic_t nr_iowait;
@@ -276,71 +275,25 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
-#ifndef prepare_arch_switch
-# define prepare_arch_switch(next)	do { } while (0)
-#endif
-#ifndef finish_arch_switch
-# define finish_arch_switch(prev)	do { } while (0)
-#endif
-
-#ifndef __ARCH_WANT_UNLOCKED_CTXSW
-static inline int task_running(runqueue_t *rq, task_t *p)
-{
-	return rq->curr == p;
-}
-
-static inline void prepare_lock_switch(runqueue_t *rq, task_t *next)
-{
-}
-
-static inline void finish_lock_switch(runqueue_t *rq, task_t *prev)
-{
-	spin_unlock_irq(&rq->lock);
-}
-
-#else /* __ARCH_WANT_UNLOCKED_CTXSW */
-static inline int task_running(runqueue_t *rq, task_t *p)
+/*
+ * We can optimise this out completely for !SMP, because the
+ * SMP rebalancing from interrupt is the only thing that cares:
+ */
+static inline void set_task_on_cpu(struct task_struct *p, int val)
 {
 #ifdef CONFIG_SMP
-	return p->oncpu;
-#else
-	return rq->curr == p;
+	p->on_cpu = val;
 #endif
 }
 
-static inline void prepare_lock_switch(runqueue_t *rq, task_t *next)
+static inline int task_on_cpu(runqueue_t *rq, task_t *p)
 {
 #ifdef CONFIG_SMP
-	/*
-	 * We can optimise this out completely for !SMP, because the
-	 * SMP rebalancing from interrupt is the only thing that cares
-	 * here.
-	 */
-	next->oncpu = 1;
-#endif
-#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
-	spin_unlock_irq(&rq->lock);
+	return p->on_cpu;
 #else
-	spin_unlock(&rq->lock);
-#endif
-}
-
-static inline void finish_lock_switch(runqueue_t *rq, task_t *prev)
-{
-#ifdef CONFIG_SMP
-	/*
-	 * After ->oncpu is cleared, the task can be moved to a different CPU.
-	 * We must ensure this doesn't happen until the switch is completely
-	 * finished.
-	 */
-	smp_wmb();
-	prev->oncpu = 0;
-#endif
-#ifndef __ARCH_WANT_INTERRUPTS_ON_CTXSW
-	local_irq_enable();
+	return rq->curr == p;
 #endif
 }
-#endif /* __ARCH_WANT_UNLOCKED_CTXSW */
 
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
@@ -855,7 +808,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!p->array && !task_on_cpu(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -885,9 +838,9 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array || task_running(rq, p))) {
+	if (unlikely(p->array || task_on_cpu(rq, p))) {
 		/* If it's preempted, we yield.  It could be a while. */
-		preempted = !task_running(rq, p);
+		preempted = !task_on_cpu(rq, p);
 		task_rq_unlock(rq, &flags);
 		cpu_relax();
 		if (preempted)
@@ -1150,7 +1103,7 @@ static int try_to_wake_up(task_t * p, un
 	this_cpu = smp_processor_id();
 
 #ifdef CONFIG_SMP
-	if (unlikely(task_running(rq, p)))
+	if (unlikely(task_on_cpu(rq, p)))
 		goto out_activate;
 
 	new_cpu = cpu;
@@ -1311,9 +1264,7 @@ void fastcall sched_fork(task_t *p, int 
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
-	p->oncpu = 0;
-#endif
+	set_task_on_cpu(p, 0);
 #ifdef CONFIG_PREEMPT
 	/* Want to start with kernel preemption disabled. */
 	p->thread_info->preempt_count = 1;
@@ -1458,45 +1409,11 @@ void fastcall sched_exit(task_t * p)
 }
 
 /**
- * prepare_task_switch - prepare to switch tasks
- * @rq: the runqueue preparing to switch
- * @next: the task we are going to switch to.
- *
- * This is called with the rq lock held and interrupts off. It must
- * be paired with a subsequent finish_task_switch after the context
- * switch.
- *
- * prepare_task_switch sets up locking and calls architecture specific
- * hooks.
- */
-static inline void prepare_task_switch(runqueue_t *rq, task_t *next)
-{
-	prepare_lock_switch(rq, next);
-	prepare_arch_switch(next);
-}
-
-/**
- * finish_task_switch - clean up after a task-switch
+ * __schedule_tail - switch to the new MM and clean up after a task-switch
  * @prev: the thread we just switched away from.
- *
- * finish_task_switch must be called after the context switch, paired
- * with a prepare_task_switch call before the context switch.
- * finish_task_switch will reconcile locking set up by prepare_task_switch,
- * and do any other architecture-specific cleanup actions.
- *
- * Note that we may have delayed dropping an mm in context_switch(). If
- * so, we finish that here outside of the runqueue lock.  (Doing it
- * with the lock held can cause deadlocks; see schedule() for
- * details.)
  */
-static inline void finish_task_switch(runqueue_t *rq, task_t *prev)
-	__releases(rq->lock)
+static void __schedule_tail(task_t *prev)
 {
-	struct mm_struct *mm = rq->prev_mm;
-	unsigned long prev_task_flags;
-
-	rq->prev_mm = NULL;
-
 	/*
 	 * A task struct has one reference for the use as "current".
 	 * If a task dies, then it sets EXIT_ZOMBIE in tsk->exit_state and
@@ -1508,11 +1425,34 @@ static inline void finish_task_switch(ru
 	 * be dropped twice.
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
-	prev_task_flags = prev->flags;
-	finish_arch_switch(prev);
-	finish_lock_switch(rq, prev);
-	if (mm)
-		mmdrop(mm);
+	struct task_struct *next = current;
+	unsigned long prev_task_flags = prev->flags;
+	struct mm_struct *prev_mm = prev->active_mm, *next_mm = next->mm;
+
+	/*
+	 * Switch the MM first:
+	 */
+	if (unlikely(!next_mm)) {
+		next->active_mm = prev_mm;
+		atomic_inc(&prev_mm->mm_count);
+		enter_lazy_tlb(prev_mm, next);
+	} else
+		switch_mm(prev_mm, next_mm, next);
+
+	if (unlikely(!prev->mm))
+		prev->active_mm = NULL;
+	else
+		prev_mm = NULL;
+	/*
+	 * After ->on_cpu is cleared, the previous task is free to be
+	 * moved to a different CPU. We must ensure this doesn't happen
+	 * until the switch is completely finished.
+	 */
+	smp_wmb();
+	set_task_on_cpu(prev, 0);
+
+	if (prev_mm)
+		mmdrop(prev_mm);
 	if (unlikely(prev_task_flags & PF_DEAD))
 		put_task_struct(prev);
 }
@@ -1522,48 +1462,15 @@ static inline void finish_task_switch(ru
  * @prev: the thread we just switched away from.
  */
 asmlinkage void schedule_tail(task_t *prev)
-	__releases(rq->lock)
 {
-	runqueue_t *rq = this_rq();
-	finish_task_switch(rq, prev);
-#ifdef __ARCH_WANT_UNLOCKED_CTXSW
-	/* In this case, finish_task_switch does not reenable preemption */
+	__schedule_tail(prev);
+	/* __schedule_tail does not reenable preemption: */
 	preempt_enable();
-#endif
 	if (current->set_child_tid)
 		put_user(current->pid, current->set_child_tid);
 }
 
 /*
- * context_switch - switch to the new MM and the new
- * thread's register state.
- */
-static inline
-task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
-{
-	struct mm_struct *mm = next->mm;
-	struct mm_struct *oldmm = prev->active_mm;
-
-	if (unlikely(!mm)) {
-		next->active_mm = oldmm;
-		atomic_inc(&oldmm->mm_count);
-		enter_lazy_tlb(oldmm, next);
-	} else
-		switch_mm(oldmm, mm, next);
-
-	if (unlikely(!prev->mm)) {
-		prev->active_mm = NULL;
-		WARN_ON(rq->prev_mm);
-		rq->prev_mm = oldmm;
-	}
-
-	/* Here we just switch the register state and the stack. */
-	switch_to(prev, next, prev);
-
-	return prev;
-}
-
-/*
  * nr_running, nr_uninterruptible and nr_context_switches:
  *
  * externally visible scheduler statistics: current number of runnable
@@ -1763,7 +1670,7 @@ int can_migrate_task(task_t *p, runqueue
 		return 0;
 	*all_pinned = 0;
 
-	if (task_running(rq, p))
+	if (task_on_cpu(rq, p))
 		return 0;
 
 	/*
@@ -2900,16 +2807,30 @@ switch_tasks:
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;
-
-		prepare_task_switch(rq, next);
-		prev = context_switch(rq, prev, next);
+		set_task_on_cpu(next, 1);
+		/*
+		 * We release the runqueue lock and enable interrupts,
+		 * but preemption is disabled until the end of the
+		 * context-switch:
+		 */
+		spin_unlock_irq(&rq->lock);
+		/*
+		 * Switch kernel stack and register state. Updates
+		 * 'prev' to point to the real previous task.
+		 *
+		 * Here we are still in the old task, 'prev' is current,
+		 * 'next' is the task we are going to switch to:
+		 */
+		switch_to(prev, next, prev);
 		barrier();
 		/*
-		 * this_rq must be evaluated again because prev may have moved
-		 * CPUs since it called schedule(), thus the 'rq' on its stack
-		 * frame will be invalid.
+		 * Here we are in the new task's stack already. 'prev'
+		 * has been updated by switch_to() to point to the task
+		 * we just switched from, 'next' is invalid.
+		 *
+		 * do the MM switch and clean up:
 		 */
-		finish_task_switch(this_rq(), prev);
+		__schedule_tail(prev);
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -3358,7 +3279,7 @@ void set_user_nice(task_t *p, long nice)
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
 		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
+		if (delta < 0 || (delta > 0 && task_on_cpu(rq, p)))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -3548,7 +3469,7 @@ recheck:
 		 * our priority decreased, or if we are not currently running on
 		 * this runqueue and our priority is higher than the current's
 		 */
-		if (task_running(rq, p)) {
+		if (task_on_cpu(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
 		} else if (TASK_PREEMPTS_CURR(p, rq))
@@ -4157,9 +4078,7 @@ void __devinit init_idle(task_t *idle, i
 
 	spin_lock_irqsave(&rq->lock, flags);
 	rq->curr = rq->idle = idle;
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
-	idle->oncpu = 1;
-#endif
+	set_task_on_cpu(idle, 1);
 	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
 
--- linux/include/asm-ia64/system.h.orig
+++ linux/include/asm-ia64/system.h
@@ -248,32 +248,6 @@ extern void ia64_load_extra (struct task
 # define switch_to(prev,next,last)	__switch_to(prev, next, last)
 #endif
 
-/*
- * On IA-64, we don't want to hold the runqueue's lock during the low-level context-switch,
- * because that could cause a deadlock.  Here is an example by Erich Focht:
- *
- * Example:
- * CPU#0:
- * schedule()
- *    -> spin_lock_irq(&rq->lock)
- *    -> context_switch()
- *       -> wrap_mmu_context()
- *          -> read_lock(&tasklist_lock)
- *
- * CPU#1:
- * sys_wait4() or release_task() or forget_original_parent()
- *    -> write_lock(&tasklist_lock)
- *    -> do_notify_parent()
- *       -> wake_up_parent()
- *          -> try_to_wake_up()
- *             -> spin_lock_irq(&parent_rq->lock)
- *
- * If the parent's rq happens to be on CPU#0, we'll wait for the rq->lock
- * of that CPU which will not be released, because there we wait for the
- * tasklist_lock to become available.
- */
-#define __ARCH_WANT_UNLOCKED_CTXSW
-
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
 void cpu_idle_wait(void);
--- linux/include/asm-sparc/system.h.orig
+++ linux/include/asm-sparc/system.h
@@ -94,22 +94,6 @@ extern void fpsave(unsigned long *fpregs
 	} while(0)
 #endif
 
-/*
- * Flush windows so that the VM switch which follows
- * would not pull the stack from under us.
- *
- * SWITCH_ENTER and SWITH_DO_LAZY_FPU do not work yet (e.g. SMP does not work)
- * XXX WTF is the above comment? Found in late teen 2.4.x.
- */
-#define prepare_arch_switch(next) do { \
-	__asm__ __volatile__( \
-	".globl\tflush_patch_switch\nflush_patch_switch:\n\t" \
-	"save %sp, -0x40, %sp; save %sp, -0x40, %sp; save %sp, -0x40, %sp\n\t" \
-	"save %sp, -0x40, %sp; save %sp, -0x40, %sp; save %sp, -0x40, %sp\n\t" \
-	"save %sp, -0x40, %sp\n\t" \
-	"restore; restore; restore; restore; restore; restore; restore"); \
-} while(0)
-
 	/* Much care has gone into this code, do not touch it.
 	 *
 	 * We need to loadup regs l0/l1 for the newly forked child
@@ -122,6 +106,12 @@ extern void fpsave(unsigned long *fpregs
 	 * - Anton & Pete
 	 */
 #define switch_to(prev, next, last) do {						\
+	__asm__ __volatile__( \
+	".globl\tflush_patch_switch\nflush_patch_switch:\n\t" \
+	"save %sp, -0x40, %sp; save %sp, -0x40, %sp; save %sp, -0x40, %sp\n\t" \
+	"save %sp, -0x40, %sp; save %sp, -0x40, %sp; save %sp, -0x40, %sp\n\t" \
+	"save %sp, -0x40, %sp\n\t" \
+	"restore; restore; restore; restore; restore; restore; restore"); \
 	SWITCH_ENTER(prev);								\
 	SWITCH_DO_LAZY_FPU(next);							\
 	cpu_set(smp_processor_id(), next->active_mm->cpu_vm_mask);			\
--- linux/include/asm-arm/system.h.orig
+++ linux/include/asm-arm/system.h
@@ -142,13 +142,6 @@ extern unsigned int user_debug;
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 /*
- * switch_mm() may do a full cache flush over the context switch,
- * so enable interrupts over the context switch to avoid high
- * latency.
- */
-#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
-
-/*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
  * contains the memory barrier to tell GCC not to cache `current'.
--- linux/include/asm-s390/system.h.orig
+++ linux/include/asm-s390/system.h
@@ -101,6 +101,8 @@ static inline void restore_access_regs(u
 	save_access_regs(&prev->thread.acrs[0]);			     \
 	restore_access_regs(&next->thread.acrs[0]);			     \
 	prev = __switch_to(prev,next);					     \
+	set_fs(current->thread.mm_segment);				     \
+	account_system_vtime(prev);					     \
 } while (0)
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -110,11 +112,6 @@ extern void account_system_vtime(struct 
 #define account_system_vtime(prev) do { } while (0)
 #endif
 
-#define finish_arch_switch(rq, prev) do {				     \
-	set_fs(current->thread.mm_segment);				     \
-	account_system_vtime(prev);					     \
-} while (0)
-
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -367,11 +367,6 @@ struct signal_struct {
 #endif
 };
 
-/* Context switch must be unlocked if interrupts are to be enabled */
-#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
-# define __ARCH_WANT_UNLOCKED_CTXSW
-#endif
-
 /*
  * Bits in flags field of signal_struct.
  */
@@ -597,8 +592,8 @@ struct task_struct {
 
 	int lock_depth;		/* Lock depth */
 
-#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
-	int oncpu;
+#if defined(CONFIG_SMP)
+	int on_cpu;
 #endif
 	int prio, static_prio;
 	struct list_head run_list;
--- linux/include/asm-arm26/system.h.orig
+++ linux/include/asm-arm26/system.h
@@ -94,15 +94,6 @@ extern unsigned int user_debug;
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /*
- * We assume knowledge of how
- * spin_unlock_irq() and friends are implemented.  This avoids
- * us needlessly decrementing and incrementing the preempt count.
- */
-#define prepare_arch_switch(rq,next)	local_irq_enable()
-#define finish_arch_switch(rq,prev)	spin_unlock(&(rq)->lock)
-#define task_running(rq,p)		((rq)->curr == (p))
-
-/*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
  * contains the memory barrier to tell GCC not to cache `current'.
--- linux/include/asm-sparc64/system.h.orig
+++ linux/include/asm-sparc64/system.h
@@ -139,13 +139,6 @@ extern void __flushw_user(void);
 #define flush_user_windows flushw_user
 #define flush_register_windows flushw_all
 
-/* Don't hold the runqueue lock over context switch */
-#define __ARCH_WANT_UNLOCKED_CTXSW
-#define prepare_arch_switch(next)		\
-do {						\
-	flushw_all();				\
-} while (0)
-
 	/* See what happens when you design the chip correctly?
 	 *
 	 * We tell gcc we clobber all non-fixed-usage registers except
@@ -161,7 +154,8 @@ do {						\
 #define EXTRA_CLOBBER
 #endif
 #define switch_to(prev, next, last)					\
-do {	if (test_thread_flag(TIF_PERFCTR)) {				\
+do {	flushw_all();							\
+	if (test_thread_flag(TIF_PERFCTR)) {				\
 		unsigned long __tmp;					\
 		read_pcr(__tmp);					\
 		current_thread_info()->pcr_reg = __tmp;			\
--- linux/include/asm-mips/system.h.orig
+++ linux/include/asm-mips/system.h
@@ -421,12 +421,6 @@ extern void __die_if_kernel(const char *
 
 extern int stop_a_enabled;
 
-/*
- * See include/asm-ia64/system.h; prevents deadlock on SMP
- * systems.
- */
-#define __ARCH_WANT_UNLOCKED_CTXSW
-
 #define arch_align_stack(x) (x)
 
 #endif /* _ASM_SYSTEM_H */
