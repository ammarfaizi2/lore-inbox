Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSFQEwH>; Mon, 17 Jun 2002 00:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSFQEwG>; Mon, 17 Jun 2002 00:52:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64205 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316709AbSFQEv5>;
	Mon, 17 Jun 2002 00:51:57 -0400
Date: Mon, 17 Jun 2002 06:49:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] 2.5.22 current scheduler bits #1.
In-Reply-To: <1024286528.924.52.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206170646370.7536-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one more fix: do not forced-migrate tasks in wakeup if it violates the
affinity mask. My current scheduler tree is attached, against 2.5.22.

	Ingo

--- linux/kernel/sched.c.orig	Mon Jun 17 05:43:53 2002
+++ linux/kernel/sched.c	Mon Jun 17 06:46:01 2002
@@ -6,14 +6,14 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *
  *  1996-12-23  Modified by Dave Grothe to fix bugs in semaphores and
- *              make semaphores SMP safe
+ *		make semaphores SMP safe
  *  1998-11-19	Implemented schedule_timeout() and related stuff
  *		by Andrea Arcangeli
  *  2002-01-04	New ultra-scalable O(1) scheduler by Ingo Molnar:
- *  		hybrid priority-list and round-robin design with
- *  		an array-switch method of distributing timeslices
- *  		and per-CPU runqueues.  Additional code by Davide
- *  		Libenzi, Robert Love, and Rusty Russell.
+ *		hybrid priority-list and round-robin design with
+ *		an array-switch method of distributing timeslices
+ *		and per-CPU runqueues.  Additional code by Davide
+ *		Libenzi, Robert Love, and Rusty Russell.
  */
 
 #include <linux/mm.h>
@@ -180,11 +180,14 @@
 /*
  * rq_lock - lock a given runqueue and disable interrupts.
  */
-static inline runqueue_t *rq_lock(runqueue_t *rq)
+static inline runqueue_t *this_rq_lock(void)
 {
+	runqueue_t *rq;
+
 	local_irq_disable();
 	rq = this_rq();
 	spin_lock(&rq->lock);
+
 	return rq;
 }
 
@@ -358,12 +361,17 @@
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
 	if (!p->array) {
-		if (unlikely(sync && (rq->curr != p))) {
-			if (p->thread_info->cpu != smp_processor_id()) {
-				p->thread_info->cpu = smp_processor_id();
-				task_rq_unlock(rq, &flags);
-				goto repeat_lock_task;
-			}
+		/*
+		 * Fast-migrate the task if it's not running or runnable
+		 * currently. Do not violate hard affinity.
+		 */
+		if (unlikely(sync && (rq->curr != p) &&
+			(p->thread_info->cpu != smp_processor_id()) &&
+			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+
+			p->thread_info->cpu = smp_processor_id();
+			task_rq_unlock(rq, &flags);
+			goto repeat_lock_task;
 		}
 		if (old_state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
@@ -388,9 +396,7 @@
 
 void wake_up_forked_process(task_t * p)
 {
-	runqueue_t *rq;
-
-	rq = rq_lock(rq);
+	runqueue_t *rq = this_rq_lock();
 
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -797,7 +803,8 @@
 	list_t *queue;
 	int idx;
 
-	BUG_ON(in_interrupt());
+	if (unlikely(in_interrupt()))
+		BUG();
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -1158,13 +1165,12 @@
 static int setscheduler(pid_t pid, int policy, struct sched_param *param)
 {
 	struct sched_param lp;
+	int retval = -EINVAL;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
-	int retval;
 	task_t *p;
 
-	retval = -EINVAL;
 	if (!param || pid < 0)
 		goto out_nounlock;
 
@@ -1251,10 +1257,9 @@
 
 asmlinkage long sys_sched_getscheduler(pid_t pid)
 {
+	int retval = -EINVAL;
 	task_t *p;
-	int retval;
 
-	retval = -EINVAL;
 	if (pid < 0)
 		goto out_nounlock;
 
@@ -1271,11 +1276,10 @@
 
 asmlinkage long sys_sched_getparam(pid_t pid, struct sched_param *param)
 {
-	task_t *p;
 	struct sched_param lp;
-	int retval;
+	int retval = -EINVAL;
+	task_t *p;
 
-	retval = -EINVAL;
 	if (!param || pid < 0)
 		goto out_nounlock;
 
@@ -1310,8 +1314,8 @@
 				      unsigned long *user_mask_ptr)
 {
 	unsigned long new_mask;
-	task_t *p;
 	int retval;
+	task_t *p;
 
 	if (len < sizeof(new_mask))
 		return -EINVAL;
@@ -1361,13 +1365,12 @@
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long mask;
 	unsigned int real_len;
-	task_t *p;
+	unsigned long mask;
 	int retval;
+	task_t *p;
 
 	real_len = sizeof(mask);
-
 	if (len < real_len)
 		return -EINVAL;
 
@@ -1392,25 +1395,35 @@
 
 asmlinkage long sys_sched_yield(void)
 {
-	runqueue_t *rq;
-	prio_array_t *array;
-
-	rq = rq_lock(rq);
+	runqueue_t *rq = this_rq_lock();
+	prio_array_t *array = current->array;
 
 	/*
-	 * Decrease the yielding task's priority by one, to avoid
-	 * livelocks. This priority loss is temporary, it's recovered
-	 * once the current timeslice expires.
+	 * There are three levels of how a yielding task will give up
+	 * the current CPU:
 	 *
-	 * If priority is already MAX_PRIO-1 then we still
-	 * roundrobin the task within the runlist.
-	 */
-	array = current->array;
-	/*
-	 * If the task has reached maximum priority (or is a RT task)
-	 * then just requeue the task to the end of the runqueue:
+	 *  #1 - it decreases its priority by one. This priority loss is
+	 *       temporary, it's recovered once the current timeslice
+	 *       expires.
+	 *
+	 *  #2 - once it has reached the lowest priority level,
+	 *       it will give up timeslices one by one. (We do not
+	 *       want to give them up all at once, it's gradual,
+	 *       to protect the casual yield()er.)
+	 *
+	 *  #3 - once all timeslices are gone we put the process into
+	 *       the expired array.
+	 *
+	 *  (special rule: RT tasks do not lose any priority, they just
+	 *  roundrobin on their current priority level.)
 	 */
-	if (likely(current->prio == MAX_PRIO-1 || rt_task(current))) {
+	if (likely(current->prio == MAX_PRIO-1)) {
+		if (current->time_slice <= 1) {
+			dequeue_task(current, rq->active);
+			enqueue_task(current, rq->expired);
+		} else
+			current->time_slice--;
+	} else if (unlikely(rt_task(current))) {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
 	} else {
@@ -1461,9 +1474,9 @@
 
 asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *interval)
 {
+	int retval = -EINVAL;
 	struct timespec t;
 	task_t *p;
-	int retval = -EINVAL;
 
 	if (pid < 0)
 		goto out_nounlock;
@@ -1758,8 +1771,8 @@
 
 static int migration_thread(void * bind_cpu)
 {
-	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: MAX_RT_PRIO-1 };
+	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	runqueue_t *rq;
 	int ret;
 
@@ -1836,15 +1849,14 @@
 	int cpu;
 
 	current->cpus_allowed = 1UL << cpu_logical_map(0);
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
 		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
-	}
 	current->cpus_allowed = -1L;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
 		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
 }
-#endif /* CONFIG_SMP */
+#endif

