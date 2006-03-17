Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWCQNEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWCQNEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWCQNEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:04:39 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:56252 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932369AbWCQNEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:04:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/2] sched: sched.c task_t cleanup
Date: Sat, 18 Mar 2006 00:04:13 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 9993
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603180004.13967.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all task_struct instances in sched.c with task_t

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   63 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-17 23:32:09.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-18 00:02:37.000000000 +1100
@@ -607,7 +607,7 @@ static inline void sched_info_switch(tas
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(task_t *p, prio_array_t *array)
 {
 	array->nr_active--;
 	list_del(&p->run_list);
@@ -615,7 +615,7 @@ static void dequeue_task(struct task_str
 		__clear_bit(p->prio, array->bitmap);
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static void enqueue_task(task_t *p, prio_array_t *array)
 {
 	sched_info_queued(p);
 	list_add_tail(&p->run_list, array->queue + p->prio);
@@ -628,12 +628,12 @@ static void enqueue_task(struct task_str
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
  */
-static void requeue_task(struct task_struct *p, prio_array_t *array)
+static void requeue_task(task_t *p, prio_array_t *array)
 {
 	list_move_tail(&p->run_list, array->queue + p->prio);
 }
 
-static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
+static inline void enqueue_task_head(task_t *p, prio_array_t *array)
 {
 	list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
@@ -865,7 +865,7 @@ static void activate_task(task_t *p, run
 /*
  * deactivate_task - remove a task from the runqueue.
  */
-static void deactivate_task(struct task_struct *p, runqueue_t *rq)
+static void deactivate_task(task_t *p, runqueue_t *rq)
 {
 	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
@@ -1058,7 +1058,7 @@ static inline unsigned long cpu_avg_load
  * domain.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+find_idlest_group(struct sched_domain *sd, task_t *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long min_load = ULONG_MAX, this_load = 0;
@@ -1112,7 +1112,7 @@ nextgroup:
  * find_idlest_queue - find the idlest runqueue among the cpus in group.
  */
 static int
-find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+find_idlest_cpu(struct sched_group *group, task_t *p, int this_cpu)
 {
 	cpumask_t tmp;
 	unsigned long load, min_load = ULONG_MAX;
@@ -1147,7 +1147,7 @@ find_idlest_cpu(struct sched_group *grou
  */
 static int sched_balance_self(int cpu, int flag)
 {
-	struct task_struct *t = current;
+	task_t *t = current;
 	struct sched_domain *tmp, *sd = NULL;
 
 	for_each_domain(cpu, tmp)
@@ -1672,7 +1672,7 @@ asmlinkage void schedule_tail(task_t *pr
  * thread's register state.
  */
 static inline
-task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
+task_t *context_switch(runqueue_t *rq, task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -1831,7 +1831,7 @@ static void sched_migrate_task(task_t *p
 	/* force the process onto the specified CPU */
 	if (migrate_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread (might exit: take ref). */
-		struct task_struct *mt = rq->migration_thread;
+		task_t *mt = rq->migration_thread;
 		get_task_struct(mt);
 		task_rq_unlock(rq, &flags);
 		wake_up_process(mt);
@@ -2615,7 +2615,7 @@ unsigned long long current_sched_time(co
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in user space since the last update
  */
-void account_user_time(struct task_struct *p, cputime_t cputime)
+void account_user_time(task_t *p, cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp;
@@ -2636,8 +2636,7 @@ void account_user_time(struct task_struc
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
  */
-void account_system_time(struct task_struct *p, int hardirq_offset,
-			 cputime_t cputime)
+void account_system_time(task_t *p, int hardirq_offset, cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
@@ -2666,7 +2665,7 @@ void account_system_time(struct task_str
  * @p: the process from which the cpu time has been stolen
  * @steal: the cpu time spent in involuntary wait
  */
-void account_steal_time(struct task_struct *p, cputime_t steal)
+void account_steal_time(task_t *p, cputime_t steal)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp = cputime_to_cputime64(steal);
@@ -3190,7 +3189,7 @@ asmlinkage void __sched preempt_schedule
 {
 	struct thread_info *ti = current_thread_info();
 #ifdef CONFIG_PREEMPT_BKL
-	struct task_struct *task = current;
+	task_t *task = current;
 	int saved_lock_depth;
 #endif
 	/*
@@ -3235,7 +3234,7 @@ asmlinkage void __sched preempt_schedule
 {
 	struct thread_info *ti = current_thread_info();
 #ifdef CONFIG_PREEMPT_BKL
-	struct task_struct *task = current;
+	task_t *task = current;
 	int saved_lock_depth;
 #endif
 	/* Catch callers which need to be fixed*/
@@ -3645,7 +3644,7 @@ int can_nice(const task_t *p, const int 
 		capable(CAP_SYS_NICE));
 }
 
-struct task_struct *kgdb_get_idle(int this_cpu)
+task_t *kgdb_get_idle(int this_cpu)
 {
         return cpu_rq(this_cpu)->idle;
 }
@@ -3744,7 +3743,7 @@ static inline task_t *find_process_by_pi
 }
 
 /* Actually do priority change: must hold rq lock. */
-static void __setscheduler(struct task_struct *p, int policy, int prio)
+static void __setscheduler(task_t *p, int policy, int prio)
 {
 	BUG_ON(p->array);
 	p->policy = policy;
@@ -3769,7 +3768,7 @@ static void __setscheduler(struct task_s
  * @policy: new policy.
  * @param: structure containing the new RT priority.
  */
-int sched_setscheduler(struct task_struct *p, int policy,
+int sched_setscheduler(task_t *p, int policy,
 		       struct sched_param *param)
 {
 	int retval;
@@ -3864,7 +3863,7 @@ do_sched_setscheduler(pid_t pid, int pol
 {
 	int retval;
 	struct sched_param lparam;
-	struct task_struct *p;
+	task_t *p;
 
 	if (!param || pid < 0)
 		return -EINVAL;
@@ -4364,22 +4363,22 @@ out_unlock:
 	return retval;
 }
 
-static inline struct task_struct *eldest_child(struct task_struct *p)
+static inline task_t *eldest_child(task_t *p)
 {
 	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
+	return list_entry(p->children.next,task_t,sibling);
 }
 
-static inline struct task_struct *older_sibling(struct task_struct *p)
+static inline task_t *older_sibling(task_t *p)
 {
 	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
+	return list_entry(p->sibling.prev,task_t,sibling);
 }
 
-static inline struct task_struct *younger_sibling(struct task_struct *p)
+static inline task_t *younger_sibling(task_t *p)
 {
 	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
+	return list_entry(p->sibling.next,task_t,sibling);
 }
 
 static void show_task(task_t *p)
@@ -4576,7 +4575,7 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
  * So we race with normal scheduler movements, but that's OK, as long
  * as the task is no longer on this CPU.
  */
-static void __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
+static void __migrate_task(task_t *p, int src_cpu, int dest_cpu)
 {
 	runqueue_t *rq_dest, *rq_src;
 
@@ -4679,7 +4678,7 @@ wait_to_die:
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Figure out where task on dead CPU should go, use force if neccessary. */
-static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+static void move_task_off_dead_cpu(int dead_cpu, task_t *tsk)
 {
 	int dest_cpu;
 	cpumask_t mask;
@@ -4734,7 +4733,7 @@ static void migrate_nr_uninterruptible(r
 /* Run through task list and migrate tasks from the dead cpu. */
 static void migrate_live_tasks(int src_cpu)
 {
-	struct task_struct *tsk, *t;
+	task_t *tsk, *t;
 
 	write_lock_irq(&tasklist_lock);
 
@@ -4757,7 +4756,7 @@ void sched_idle_next(void)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
-	struct task_struct *p = rq->idle;
+	task_t *p = rq->idle;
 	unsigned long flags;
 
 	/* cpu has to be offline */
@@ -4953,7 +4952,7 @@ static int migration_call(struct notifie
 			  void *hcpu)
 {
 	int cpu = (long)hcpu;
-	struct task_struct *p;
+	task_t *p;
 	struct runqueue *rq;
 	unsigned long flags;
 
@@ -6412,7 +6411,7 @@ EXPORT_SYMBOL(__might_sleep);
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
-	struct task_struct *p;
+	task_t *p;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;

