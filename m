Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbUKPNBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUKPNBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUKPNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:00:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20444 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261968AbUKPM7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:59:38 -0500
Date: Tue, 16 Nov 2004 12:32:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling bugs
Message-ID: <20041116113209.GA1890@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


PREEMPT_RT on SMP systems triggered weird (very high) load average
values rather easily, which turned out to be a mainline kernel
->nr_uninterruptible handling bug in try_to_wake_up().

the following code:

        if (old_state == TASK_UNINTERRUPTIBLE) {
                old_rq->nr_uninterruptible--;

potentially executes with old_rq potentially being != rq, and hence
updating ->nr_uninterruptible without the lock held. Given a
sufficiently concurrent preemption workload the count can get out of
whack and updates might get lost, permanently skewing the global count. 
Nothing except the load-average uses nr_uninterruptible() so this
condition can go unnoticed quite easily.

the fix is to update ->nr_uninterruptible always on the runqueue where
the task currently is. (this is also a tiny performance plus for
try_to_wake_up() as a stackslot gets freed up.)

while fixing this bug i found three other ->nr_uninterruptible related
bugs:

 - the update should be moved from deactivate_task() into schedule(),
   beacause e.g. setscheduler() does deactivate_task()+activate_task(),
   which in turn may result in a -1 counter-skew if setscheduler() is
   done on a task asynchronously, which task is still on the runqueue
   but has already set ->state to TASK_UNINTERRUPTIBLE. 

   sys_sched_setscheduler() is used rarely, but the bug is real. (The
   fix is also a small performance enhancement.)

   The rules for ->nr_uninterruptible updating are the following: it
   gets increased by schedule() only, when a task is moved off the
   runqueue and it has a state of TASK_UNINTERRUPTIBLE. It is decreased
   by try_to_wake_up(), by the first wakeup that materially changes the
   state from TASK_UNINTERRUPTIBLE back to TASK_RUNNING, and moves the
   task to the runqueue.

 - on CPU-hotplug down we might zap a CPU that has a nonzero counter. 
   Due to the fuzzy nature of the global counter a CPU might hold a 
   nonzero ->nr_uninterruptible count even if it has no tasks anymore. 
   The solution is to 'migrate' the counter to another runqueue.

 - we should not return negative counter values from the
   nr_uninterruptible() function, since it accesses them without taking
   the runqueue locks, so the total sum might be slightly above or
   slightly below the real count.

i tested the attached patch on x86 SMP and it solves the load-average
problem. (I have tested CPU_HOTPLUG compilation but not functionality.) 
I think this is a must-have for 2.6.10, because there are apps that go
berzerk if load-average is too high (e.g. sendmail).

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -217,7 +217,16 @@ struct runqueue {
 	unsigned long cpu_load;
 #endif
 	unsigned long long nr_switches;
-	unsigned long expired_timestamp, nr_uninterruptible;
+
+	/*
+	 * This is part of a global counter where only the total sum
+	 * over all CPUs matters. A task can increase this counter on
+	 * one CPU and if it got migrated afterwards it may decrease
+	 * it on another CPU. Always updated under the runqueue lock:
+	 */
+	unsigned long nr_uninterruptible;
+
+	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -762,8 +771,6 @@ static void activate_task(task_t *p, run
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (p->state == TASK_UNINTERRUPTIBLE)
-		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -983,14 +990,14 @@ static int try_to_wake_up(task_t * p, un
 	int cpu, this_cpu, success = 0;
 	unsigned long flags;
 	long old_state;
-	runqueue_t *rq, *old_rq;
+	runqueue_t *rq;
 #ifdef CONFIG_SMP
 	unsigned long load, this_load;
 	struct sched_domain *sd;
 	int new_cpu;
 #endif
 
-	old_rq = rq = task_rq_lock(p, &flags);
+	rq = task_rq_lock(p, &flags);
 	schedstat_inc(rq, ttwu_cnt);
 	old_state = p->state;
 	if (!(old_state & state))
@@ -1085,7 +1092,7 @@ out_set_cpu:
 out_activate:
 #endif /* CONFIG_SMP */
 	if (old_state == TASK_UNINTERRUPTIBLE) {
-		old_rq->nr_uninterruptible--;
+		rq->nr_uninterruptible--;
 		/*
 		 * Tasks on involuntary sleep don't earn
 		 * sleep_avg beyond just interactive state.
@@ -1415,6 +1422,13 @@ unsigned long nr_uninterruptible(void)
 	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
 
+	/*
+	 * Since we read the counters lockless, it might be slightly
+	 * inaccurate. Do not allow it to go below zero though:
+	 */
+	if (unlikely((long)sum < 0))
+		sum = 0;
+
 	return sum;
 }
 
@@ -2581,8 +2595,11 @@ need_resched_nonpreemptible:
 		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
 				unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
-		else
+		else {
+			if (prev->state == TASK_UNINTERRUPTIBLE)
+				rq->nr_uninterruptible++;
 			deactivate_task(prev, rq);
+		}
 	}
 
 	cpu = smp_processor_id();
@@ -3914,6 +3931,26 @@ static void move_task_off_dead_cpu(int d
 	__migrate_task(tsk, dead_cpu, dest_cpu);
 }
 
+/*
+ * While a dead CPU has no uninterruptible tasks queued at this point,
+ * it might still have a nonzero ->nr_uninterruptible counter, because
+ * for performance reasons the counter is not stricly tracking tasks to
+ * their home CPUs. So we just add the counter to another CPU's counter,
+ * to keep the global sum constant after CPU-down:
+ */
+static void migrate_nr_uninterruptible(runqueue_t *rq_src)
+{
+	runqueue_t *rq_dest = cpu_rq(any_online_cpu(CPU_MASK_ALL));
+	unsigned long flags;
+
+	local_irq_save(flags);
+	double_rq_lock(rq_src, rq_dest);
+	rq_dest->nr_uninterruptible += rq_src->nr_uninterruptible;
+	rq_src->nr_uninterruptible = 0;
+	double_rq_unlock(rq_src, rq_dest);
+	local_irq_restore(flags);
+}
+
 /* Run through task list and migrate tasks from the dead cpu. */
 static void migrate_live_tasks(int src_cpu)
 {
@@ -4048,6 +4085,7 @@ static int migration_call(struct notifie
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		migrate_dead_tasks(cpu);
 		task_rq_unlock(rq, &flags);
+		migrate_nr_uninterruptible(rq);
 		BUG_ON(rq->nr_running != 0);
 
 		/* No need to migrate the tasks: it was best-effort if
