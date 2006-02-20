Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWBTFCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWBTFCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWBTFCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:02:46 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:30090 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932620AbWBTFCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:02:45 -0500
Message-ID: <43F94D71.1040109@bigpond.net.au>
Date: Mon, 20 Feb 2006 16:02:41 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: Consolidated and improved smpnice patch
Content-Type: multipart/mixed;
 boundary="------------070602030207010905060108"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 20 Feb 2006 05:02:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602030207010905060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

The introduction of separate run queues per CPU has brought with it 
"nice" enforcement problems that are best described by a simple example. 
  For the sake of argument suppose that on a single CPU machine with a 
nice==19 hard spinner and a nice==0 hard spinner running that the 
nice==0 task gets 95% of the CPU and the nice==19 task gets 5% of the 
CPU.  Now suppose that there is a system with 2 CPUs and 2 nice==19 hard 
spinners and 2 nice==0 hard spinners running.  The user of this system 
would be entitled to expect that the nice==0 tasks each get 95% of a CPU 
and the nice==19 tasks only get 5% each.  However, whether this 
expectation is met is pretty much down to luck as there are four equally 
likely distributions of the tasks to the CPUs that the load balancing 
code will consider to be balanced with loads of 2.0 for each CPU.  Two 
of these distributions involve one nice==0 and one nice==19 task per CPU 
and in these circumstances the users expectations will be met.  The 
other two distributions both involve both nice==0 tasks being on one CPU 
and both nice==19 being on the other CPU and each task will get 50% of a 
CPU and the user's expectations will not be met.

Solution:

The solution to this problem that is implemented in the attached patch 
is to use weighted loads when determining if the system is balanced and, 
when an imbalance is detected, to move an amount of weighted load 
between run queues (as opposed to a number of tasks) to restore the 
balance.  Once again, the easiest way to explain why both of these 
measures are necessary is to use a simple example.  Suppose that (in a 
slight variation of the above example) that we have a two CPU system 
with 4 nice==0 and 4 nice=19 hard spinning tasks running and that the 4 
nice==0 tasks are on one CPU and the 4 nice==19 tasks are on the other 
CPU.  The weighted loads for the two CPUs would be 4.0 and 0.2 
respectively and the load balancing code would move 2 tasks resulting in 
one CPU with a load of 2.0 and the other with load of 2.2.  If this was 
considered to be a big enough imbalance to justify moving a task and 
that task was moved using the current move_tasks() then it would move 
the highest priority task that it found and this would result in one CPU 
with a load of 3.0 and the other with a load of 1.2 which would result 
in the movement of a task in the opposite direction and so on -- 
infinite loop.  If, on the other hand, an amount of load to be moved is 
calculated from the imbalance (in this case 0.1) and move_tasks() skips 
tasks until it find ones whose contributions to the weighted load are 
less than this amount it would move two of the nice==19 tasks resulting 
in a system with 2 nice==0 and 2 nice=19 on each CPU with loads of 2.1 
for each CPU.

One of the advantages of this mechanism is that on a system where all 
tasks have nice==0 the load balancing calculations would be 
mathematically identical to the current load balancing code.

Notes:

struct task_struct:

has a new filed load_weight which (in a trade off of space for speed) 
stores the contribution that this task makes to a CPU's weighted load 
when it is runnable.

struct runqueue:

has a new field raw_weighted_load which is the sum of the load_weight 
values for the currently runnable tasks on this run queue.  This field 
always needs to be updated when nr_running is updated so two new inline 
functions inc_nr_running() and dec_nr_running() have been created to 
make sure that this happens.  This also offers a convenient way to 
optimize away this part of the smpnice mechanism when CONFIG_SMP is not 
defined.

int try_to_wake_up():

in this function the value SCHED_LOAD_BALANCE is used to represent the 
load contribution of a single task in various calculations in the code 
that decides which CPU to put the waking task on.  While this would be a 
valid on a system where the nice values for the runnable tasks were 
distributed evenly around zero it will lead to anomalous load balancing 
if the distribution is skewed in either direction.  To overcome this 
problem SCHED_LOAD_SCALE has been replaced by the load_weight for the 
relevant task or by the average load_weight per task for the queue in 
question (as appropriate).

int move_tasks():

The modifications to this function were complicated by the fact that 
active_load_balance() uses it to move exactly one task without checking 
whether an imbalance actually exists.  This precluded the simple 
overloading of max_nr_move with max_load_move and necessitated the 
addition of the latter as an extra argument to the function.  The 
internal implementation is then modified to move up to max_nr_move tasks 
and max_load_move of weighted load.  This slightly complicates the code 
where move_tasks() is called and if ever active_load_balance() is 
changed to not use move_tasks() the implementation of move_tasks() 
should be simplified accordingly.

struct sched_group *find_busiest_group():

Similar to try_to_wake_up(), there are places in this function where 
SCHED_LOAD_SCALE is used to represent the load contribution of a single 
task and the same issues are created.  A similar solution is adopted 
except that it is now the average per task contribution to a group's 
load (as opposed to a run queue) that is required.  As this value is not 
directly available from the group it is calculated on the fly as the 
queues in the groups are visited when determining the busiest group.

A key change to this function is that it is no longer to scale down 
*imbalance on exit as move_tasks() uses the load in its scaled form.

void set_user_nice():

has been modified to update the task's load_weight field when it's nice 
value and also to ensure that its run queue's raw_weighted_load field is 
updated if it was runnable.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

  include/linux/sched.h |    3
  kernel/sched.c        |  230 ++++++++++++++++++++++++++++++++----------
  2 files changed, 183 insertions(+), 50 deletions(-)

Thanks to Con Kolivas for his contributions.
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------070602030207010905060108
Content-Type: text/plain;
 name="consolidated-smpnice-load-balancing"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consolidated-smpnice-load-balancing"

Index: GIT-warnings/include/linux/sched.h
===================================================================
--- GIT-warnings.orig/include/linux/sched.h	2006-02-19 11:33:09.000000000 +1100
+++ GIT-warnings/include/linux/sched.h	2006-02-20 09:39:54.000000000 +1100
@@ -701,6 +701,9 @@ struct task_struct {
 	int oncpu;
 #endif
 	int prio, static_prio;
+#ifdef CONFIG_SMP
+	int load_weight;	/* for load balancing purposes */
+#endif
 	struct list_head run_list;
 	prio_array_t *array;
 
Index: GIT-warnings/kernel/sched.c
===================================================================
--- GIT-warnings.orig/kernel/sched.c	2006-02-20 09:14:49.000000000 +1100
+++ GIT-warnings/kernel/sched.c	2006-02-20 13:52:33.000000000 +1100
@@ -215,6 +215,7 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
+	unsigned long raw_weighted_load;
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -668,13 +669,85 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
+#ifdef CONFIG_SMP
+/*
+ * To aid in avoiding the subversion of "niceness" due to uneven distribution
+ * of tasks with abnormal "nice" values across CPUs the contribution that
+ * each task makes to its run queue's load is weighted according to its
+ * scheduling class and "nice" value.
+ */
+
+/*
+ * Priority weight for load balancing ranges from 1/20 (nice==19) to 459/20 (RT
+ * priority of 100).
+ */
+#define NICE_TO_LOAD_PRIO(nice) \
+	((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
+#define LOAD_WEIGHT(lp) \
+	(((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
+#define NICE_TO_LOAD_WEIGHT(nice)	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))
+#define PRIO_TO_LOAD_WEIGHT(prio)	NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
+#define RTPRIO_TO_LOAD_WEIGHT(rp) \
+	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
+
+static inline void set_load_weight(task_t *p)
+{
+	if (rt_task(p)) {
+		if (p == task_rq(p)->migration_thread)
+			/*
+			 * The migration thread does the actual balancing.
+			 * Giving its load any weight will skew balancing
+			 * adversely.
+			 */
+			p->load_weight = 0;
+		else
+			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
+	} else
+		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
+}
+
+static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+	rq->raw_weighted_load += p->load_weight;
+}
+
+static inline void dec_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+	rq->raw_weighted_load -= p->load_weight;
+}
+#else
+static inline void set_load_weight(task_t *p)
+{
+}
+
+static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+}
+
+static inline void dec_raw_weighted_load(runqueue_t *rq, const task_t *p)
+{
+}
+#endif
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	inc_raw_weighted_load(rq, p);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	dec_raw_weighted_load(rq, p);
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 /*
@@ -683,7 +756,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 static int recalc_task_prio(task_t *p, unsigned long long now)
@@ -807,7 +880,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -946,7 +1019,8 @@ void kick_process(task_t *p)
 }
 
 /*
- * Return a low guess at the load of a migration-source cpu.
+ * Return a low guess at the load of a migration-source cpu weighted
+ * according to the scheduling class and "nice" value.
  *
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
@@ -954,24 +1028,36 @@ void kick_process(task_t *p)
 static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+
 	if (type == 0)
-		return load_now;
+		return rq->raw_weighted_load;
 
-	return min(rq->cpu_load[type-1], load_now);
+	return min(rq->cpu_load[type-1], rq->raw_weighted_load);
 }
 
 /*
- * Return a high guess at the load of a migration-target cpu
+ * Return a high guess at the load of a migration-target cpu weighted
+ * according to the scheduling class and "nice" value.
  */
 static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+
 	if (type == 0)
-		return load_now;
+		return rq->raw_weighted_load;
 
-	return max(rq->cpu_load[type-1], load_now);
+	return max(rq->cpu_load[type-1], rq->raw_weighted_load);
+}
+
+/*
+ * Return the average load per task on the cpu's run queue
+ */
+static inline unsigned long cpu_avg_load_per_task(int cpu)
+{
+	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long n = rq->nr_running;
+
+	return n ?  rq->raw_weighted_load / n : rq->raw_weighted_load;
 }
 
 /*
@@ -1223,17 +1309,19 @@ static int try_to_wake_up(task_t *p, uns
 
 		if (this_sd->flags & SD_WAKE_AFFINE) {
 			unsigned long tl = this_load;
+			unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
+
 			/*
 			 * If sync wakeup then subtract the (maximum possible)
 			 * effect of the currently running task from the load
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= SCHED_LOAD_SCALE;
+				tl -= current->load_weight;
 
 			if ((tl <= load &&
-				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
-				100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
+				tl + target_load(cpu, idx) <= tl_per_task) ||
+				100*(tl + p->load_weight) <= imbalance*load) {
 				/*
 				 * This domain has SD_WAKE_AFFINE and
 				 * p is cache cold in this domain, and
@@ -1432,7 +1520,7 @@ void fastcall wake_up_new_task(task_t *p
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
-				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1777,9 +1865,9 @@ void pull_task(runqueue_t *src_rq, prio_
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1827,24 +1915,27 @@ int can_migrate_task(task_t *p, runqueue
 }
 
 /*
- * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
- * as part of a balancing operation within "domain". Returns the number of
- * tasks moved.
+ * move_tasks tries to move up to max_nr_move tasks and max_load_move weighted
+ * load from busiest to this_rq, as part of a balancing operation within
+ * "domain". Returns the number of tasks moved.
  *
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle, int *all_pinned)
+		      unsigned long max_nr_move, unsigned long max_load_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
+	long rem_load_move;
 	task_t *tmp;
 
-	if (max_nr_move == 0)
+	if (max_nr_move == 0 || max_load_move == 0)
 		goto out;
 
+	rem_load_move = max_load_move;
 	pinned = 1;
 
 	/*
@@ -1885,7 +1976,8 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	if (tmp->load_weight > rem_load_move ||
+	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1899,9 +1991,13 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
+	rem_load_move -= tmp->load_weight;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
+	/*
+	 * We only want to steal up to the prescribed number of tasks
+	 * and the prescribed amount of weighted load.
+	 */
+	if (pulled < max_nr_move && rem_load_move > 0) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1922,7 +2018,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the number of tasks which should be
+ * domain. It calculates and returns the amount of weighted load which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -1932,9 +2028,13 @@ find_busiest_group(struct sched_domain *
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
 	unsigned long max_pull;
+	unsigned long busiest_load_per_task, busiest_nr_running;
+	unsigned long this_load_per_task, this_nr_running;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
+	busiest_load_per_task = busiest_nr_running = 0;
+	this_load_per_task = this_nr_running = 0;
 	if (idle == NOT_IDLE)
 		load_idx = sd->busy_idx;
 	else if (idle == NEWLY_IDLE)
@@ -1946,13 +2046,16 @@ find_busiest_group(struct sched_domain *
 		unsigned long load;
 		int local_group;
 		int i;
+		unsigned long sum_nr_running, sum_weighted_load;
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
 		/* Tally up the load of all CPUs in the group */
-		avg_load = 0;
+		sum_weighted_load = sum_nr_running = avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			runqueue_t *rq = cpu_rq(i);
+
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
 
@@ -1963,6 +2066,8 @@ find_busiest_group(struct sched_domain *
 				load = source_load(i, load_idx);
 
 			avg_load += load;
+			sum_nr_running += rq->nr_running;
+			sum_weighted_load += rq->raw_weighted_load;
 		}
 
 		total_load += avg_load;
@@ -1974,14 +2079,18 @@ find_busiest_group(struct sched_domain *
 		if (local_group) {
 			this_load = avg_load;
 			this = group;
+			this_nr_running = sum_nr_running;
+			this_load_per_task = sum_weighted_load;
 		} else if (avg_load > max_load) {
 			max_load = avg_load;
 			busiest = group;
+			busiest_nr_running = sum_nr_running;
+			busiest_load_per_task = sum_weighted_load;
 		}
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
+	if (!busiest || this_load >= max_load || busiest_nr_running <= 1)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
@@ -1990,6 +2099,7 @@ find_busiest_group(struct sched_domain *
 			100*max_load <= sd->imbalance_pct*this_load)
 		goto out_balanced;
 
+	busiest_load_per_task /= busiest_nr_running;
 	/*
 	 * We're trying to get all the cpus to the average_load, so we don't
 	 * want to push ourselves above the average load, nor do we wish to
@@ -2003,19 +2113,25 @@ find_busiest_group(struct sched_domain *
 	 */
 
 	/* Don't want to pull so many tasks that a group would go idle */
-	max_pull = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+	max_pull = min(max_load - avg_load, max_load - busiest_load_per_task);
 
 	/* How much load to actually move to equalise the imbalance */
 	*imbalance = min(max_pull * busiest->cpu_power,
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
-	if (*imbalance < SCHED_LOAD_SCALE) {
+	/*
+	 * if *imbalance is less than the average load per runnable task
+	 * there is no gaurantee that any tasks will be moved so we'll have
+	 * a think about bumping its value to force at least one task to be
+	 * moved
+	 */
+	if (*imbalance < busiest_load_per_task) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
 
-		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = 1;
+		if (max_load - this_load >= busiest_load_per_task*2) {
+			*imbalance = busiest_load_per_task;
 			return busiest;
 		}
 
@@ -2025,35 +2141,39 @@ find_busiest_group(struct sched_domain *
 		 * moving them.
 		 */
 
-		pwr_now += busiest->cpu_power*min(SCHED_LOAD_SCALE, max_load);
-		pwr_now += this->cpu_power*min(SCHED_LOAD_SCALE, this_load);
+		pwr_now += busiest->cpu_power *
+			min(busiest_load_per_task, max_load);
+		if (this_nr_running)
+			this_load_per_task /= this_nr_running;
+		pwr_now += this->cpu_power *
+			min(this_load_per_task, this_load);
 		pwr_now /= SCHED_LOAD_SCALE;
 
 		/* Amount of load we'd subtract */
-		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/busiest->cpu_power;
+		tmp = busiest_load_per_task*SCHED_LOAD_SCALE/busiest->cpu_power;
 		if (max_load > tmp)
-			pwr_move += busiest->cpu_power*min(SCHED_LOAD_SCALE,
-							max_load - tmp);
+			pwr_move += busiest->cpu_power *
+				min(busiest_load_per_task, max_load - tmp);
 
 		/* Amount of load we'd add */
 		if (max_load*busiest->cpu_power <
-				SCHED_LOAD_SCALE*SCHED_LOAD_SCALE)
+				busiest_load_per_task*SCHED_LOAD_SCALE)
 			tmp = max_load*busiest->cpu_power/this->cpu_power;
 		else
-			tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
-		pwr_move += this->cpu_power*min(SCHED_LOAD_SCALE, this_load + tmp);
+			tmp = busiest_load_per_task*SCHED_LOAD_SCALE/this->cpu_power;
+		pwr_move += this->cpu_power*min(this_load_per_task, this_load + tmp);
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain throughput */
-		if (pwr_move <= pwr_now)
+		if (pwr_move > pwr_now)
+			*imbalance = busiest_load_per_task;
+		/* or if there's a reasonable chance that *imbalance is big
+		 * enough to cause a move
+		 */
+		 else if (*imbalance <= busiest_load_per_task / 2)
 			goto out_balanced;
-
-		*imbalance = 1;
-		return busiest;
 	}
 
-	/* Get rid of the scaling factor, rounding down as we divide */
-	*imbalance = *imbalance / SCHED_LOAD_SCALE;
 	return busiest;
 
 out_balanced:
@@ -2090,6 +2210,7 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
+#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2137,6 +2258,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2255,6 +2377,7 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2335,7 +2458,8 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
+			RTPRIO_TO_LOAD_WEIGHT(100), sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2363,7 +2487,7 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	this_load = this_rq->raw_weighted_load;
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -3473,17 +3597,21 @@ void set_user_nice(task_t *p, long nice)
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array)
+	if (array) {
 		dequeue_task(p, array);
+		dec_raw_weighted_load(rq, p);
+	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
+	set_load_weight(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
+		inc_raw_weighted_load(rq, p);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3619,6 +3747,7 @@ static void __setscheduler(struct task_s
 		if (policy == SCHED_BATCH)
 			p->sleep_avg = 0;
 	}
+	set_load_weight(p);
 }
 
 /**
@@ -6053,6 +6182,7 @@ void __init sched_init(void)
 		}
 	}
 
+	set_load_weight(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */

--------------070602030207010905060108--
