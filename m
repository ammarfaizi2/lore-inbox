Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318057AbSFSXij>; Wed, 19 Jun 2002 19:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSFSXii>; Wed, 19 Jun 2002 19:38:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16004 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318057AbSFSXie>;
	Wed, 19 Jun 2002 19:38:34 -0400
Date: Thu, 20 Jun 2002 01:36:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] scheduler bits from 2.5.23-dj1
In-Reply-To: <20020619112308.GA11631@suse.de>
Message-ID: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the scheduler optimisation in 2.5.23-dj1, from James Bottomley, looks fine
to me. I did some modifications:

 - use another form: task_cpu(p) & set_task_cpu(p, cpu), which is shorter
   for the common uses - and this way the optimisation also makes the
   source more compact.

 - put task_cpu() and set_task_cpu() into sched.h, since these are
   task-level operations.

 - there is no need for the #if CONFIG_SMP, gcc is good at optimizing away
   a branch if it has a (0 != 0) condition on UP :-)

 - (i did not carry over all the comment changes, only the speling ones.)

another change in 2.5.23-dj1 is the initialization of the pidhash in
sched_init(). It does not belong there - please create a new init function
within fork.c if needed. The pidhash init used to be in sched_init(), but
this doesnt make it right.

And i'm not quite sure whether it's needed to expose the pidhash to the
rest of the kernel - it would be much simpler to have it in kernel/fork.c
locally, and find_task_by_pid() would be a function instead of an inline.
(it has a ~49 bytes footprint on x86, it's rather heavy i think.)

my current scheduler patchset (against 2.5.23, tested) is attached.

	Ingo

diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Jun 20 01:21:34 2002
+++ b/include/linux/sched.h	Thu Jun 20 01:21:34 2002
@@ -863,6 +863,34 @@
 		clear_thread_flag(TIF_SIGPENDING);
 }
 
+/*
+ * Wrappers for p->thread_info->cpu access. No-op on UP.
+ */
+#ifdef CONFIG_SMP
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return p->thread_info->cpu;
+}
+
+static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	p->thread_info->cpu = cpu;
+}
+
+#else
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+}
+
+#endif /* CONFIG_SMP */
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Thu Jun 20 01:21:34 2002
+++ b/kernel/sched.c	Thu Jun 20 01:21:34 2002
@@ -148,7 +148,7 @@
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
-#define task_rq(p)		cpu_rq((p)->thread_info->cpu)
+#define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
@@ -284,8 +284,8 @@
 	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
 	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
 
-	if (!need_resched && !nrpolling && (p->thread_info->cpu != smp_processor_id()))
-		smp_send_reschedule(p->thread_info->cpu);
+	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
+		smp_send_reschedule(task_cpu(p));
 	preempt_enable();
 #else
 	set_tsk_need_resched(p);
@@ -366,10 +366,10 @@
 		 * currently. Do not violate hard affinity.
 		 */
 		if (unlikely(sync && (rq->curr != p) &&
-			(p->thread_info->cpu != smp_processor_id()) &&
+			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
-			p->thread_info->cpu = smp_processor_id();
+			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
 			goto repeat_lock_task;
 		}
@@ -409,7 +409,7 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	p->thread_info->cpu = smp_processor_id();
+	set_task_cpu(p, smp_processor_id());
 	activate_task(p, rq);
 
 	rq_unlock(rq);
@@ -663,7 +663,7 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
-	next->thread_info->cpu = this_cpu;
+	set_task_cpu(next, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
 	if (next->prio < current->prio)
@@ -821,7 +821,7 @@
 	spin_lock_irq(&rq->lock);
 
 	/*
-	 * if entering off a kernel preemption go straight
+	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
 	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
@@ -906,7 +906,7 @@
 	schedule();
 	ti->preempt_count = 0;
 
-	/* we can miss a preemption opportunity between schedule and now */
+	/* we could miss a preemption opportunity between schedule and now */
 	barrier();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
@@ -1630,7 +1630,7 @@
 
 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->thread_info->cpu);
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
 	unsigned long flags;
 
 	__save_flags(flags);
@@ -1642,7 +1642,7 @@
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
-	idle->thread_info->cpu = cpu;
+	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
@@ -1751,7 +1751,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << p->thread_info->cpu)) {
+	if (new_mask & (1UL << task_cpu(p))) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1760,7 +1760,7 @@
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && (p != rq->curr)) {
-		p->thread_info->cpu = __ffs(p->cpus_allowed);
+		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1775,6 +1775,8 @@
 	preempt_enable();
 }
 
+static __initdata int master_migration_thread;
+
 static int migration_thread(void * bind_cpu)
 {
 	int cpu = (int) (long) bind_cpu;
@@ -1786,14 +1788,12 @@
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	/* FIXME: First CPU may not be zero, but this crap code
-           vanishes with hotplug cpu patch anyway. --RR */
 	/*
-	 * The first migration thread is started on CPU #0. This one can
-	 * migrate the other migration threads to their destination CPUs.
+	 * The first migration thread is started on the boot CPU, it
+	 * migrates the other migration threads to their destination CPUs.
 	 */
-	if (cpu != 0) {
-		while (!cpu_rq(0)->migration_thread)
+	if (cpu != master_migration_thread) {
+		while (!cpu_rq(master_migration_thread)->migration_thread)
 			yield();
 		set_cpus_allowed(current, 1UL << cpu);
 	}
@@ -1829,18 +1829,18 @@
 		cpu_dest = __ffs(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
-		cpu_src = p->thread_info->cpu;
+		cpu_src = task_cpu(p);
 		rq_src = cpu_rq(cpu_src);
 
 		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
-		if (p->thread_info->cpu != cpu_src) {
+		if (task_cpu(p) != cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
 			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src == rq) {
-			p->thread_info->cpu = cpu_dest;
+			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);
@@ -1857,7 +1857,9 @@
 {
 	int cpu;
 
-	current->cpus_allowed = 1UL << 0;
+	master_migration_thread = smp_processor_id();
+	current->cpus_allowed = 1UL << master_migration_thread;
+	
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;

