Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265749AbSJTDNp>; Sat, 19 Oct 2002 23:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265750AbSJTDNp>; Sat, 19 Oct 2002 23:13:45 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:59522 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265749AbSJTDNk>;
	Sat, 19 Oct 2002 23:13:40 -0400
Date: Sat, 19 Oct 2002 23:19:05 -0400
Message-Id: <200210200319.g9K3J5s07242@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org, mingo@elte.hu, andrea@suse.de,
       jim.houston@ccur.com, riel@conectiva.com.br, akpm@digeo.com,
       conman@kolivas.net
Subject: [PATCH] Re: Pathological case identified from contest
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reply-to: jim.houston@attbi.com
--text follows this line--

Hi Ingo, 

I ran into the same problems with the scehduler behaving
badly under load and reported them in this email:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=103133744217082&w=2 

I was testing with the LTP and ran into a live-lock because
scheduler got into a stable state where it always picked the
same processes to run.  See the earlier mail for the full
story.  I exchanged a few messages with Andrea Arcangeli about 
this problem and tried a couple of his patches.  They prevented
the lockup but it got me started thinking about how to make the 
scheduler more fair.

The result is the following patch.  It is against 2.5.40.   

The patch includes:

     -	Code to calculate a traditional unix p_cpu style run
	average.  This is an exponentially decaying average 
	run time.  Based on the process being found running.
	I'm  doing a first order aproximation for the exponential
	 function. 

	I'm punishing processes that actually get to run rather
	than rewarding proceses that sleep.  The decaying average
	means that the value represents the fraction of the cpu
	the process has used.  The current sleep average tends
	to clamp to the limit values.

     -	Code which gradually raises the priority of all of
	the processes in the run queue.  This increase is balanced
	by making time slices shorter for more favorable priorites.
	Rrocesses that consume there time slice with out sleeping
	are moved to a less favorable priority.  This replaces
	the array switch.

I have only done a little testing.  I timed building the kernel
with/without this change and it made no difference.  I also tested
with the witpid06 test which had cause the live-lock.

I had been planning a few more changes but got side tracked with 
real work.  I was thinking about adding some feed back which would 
adjust the rate at which the priorities of processes in the run
queue increase.  I also wanted to play with nice.  The patch currently
uses a weighted average of the prio and static_prio when it calculates
a new effective priority. 

The method I use to raise the priorities of the running processes is
to remap prio values for processes in the run queue.  See the functions
queue_prio an real_prio.  Changing the value of prio_ind changes all
of the priorities.  I have not done anything to the process migration
code so it will migrate processes with random priorities.  I don't
know if this will have any noticeable effect.

I had fun playing with this.  I hope others find it useful.

Jim Houston - Concurrent Computer Corp.

diff -urN x2.old/kernel/sched.c x2.new/kernel/sched.c
--- x2.old/kernel/sched.c	Sat Oct 19 21:56:54 2002
+++ x2.new/kernel/sched.c	Sat Oct 19 21:56:19 2002
@@ -32,6 +32,12 @@
 #include <linux/timer.h>
 
 /*
+ * I'm lazy these belong in the sched.h
+ */
+#define run_avg sleep_avg
+#define MAX_RUN_AVG	(4*HZ)
+
+/*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
@@ -120,7 +126,15 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	/*
+	 * The more favorable priority the shorter the time slice.
+	 * For 100 Hz clock this gives a range 10 - 191 ms.
+	 * For 1000 Hz clock this gives 1 - 157 ms.
+	 */
+	if (HZ > 100)
+		return(((p)->prio - MAX_RT_PRIO)*4 + 1);
+	else
+		return(((p)->prio - MAX_RT_PRIO)/2 + 1);
 }
 
 /*
@@ -149,6 +163,8 @@
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	task_t *curr, *idle;
+	unsigned int prio_ind;
+	int rotate_cnt;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 
@@ -166,6 +182,42 @@
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
 /*
+ * The rq->prio_ind is used to raise/rotate the priority of all of the
+ * processes in the run queue.  I know this  sounds like a pyramid scheme.
+ * This increase in priority is balanced by two feedback mechanisms.
+ * First processes which consume there timeslice are moved to a lower 
+ * priority queue.  To continue the pyramid analogy we make the time
+ * slice smaller for more favorable priorities.
+ *
+ * The rotate_rate is the rate at which the priorities of processes
+ * in the run queue increase.  With the initial HZ/10 guess a process
+ * will go from the worst dynamic priority to the best in 4 seconds.
+ */
+
+int rotate_rate = HZ/10;
+unsigned int sched_hist[MAX_PRIO+1];
+
+static inline int queue_prio(int prio, unsigned prio_ind)
+{
+	if (prio < MAX_RT_PRIO || prio == MAX_PRIO) 
+		return(prio);
+	prio = prio + prio_ind;
+	if (prio >= MAX_PRIO)
+		prio -= MAX_USER_PRIO;
+	return(prio);
+}
+
+static inline int real_prio(int prio, unsigned int prio_ind)
+{
+	if (prio < MAX_RT_PRIO || prio == MAX_PRIO) 
+		return(prio);
+	prio = prio - prio_ind;
+	if (prio < MAX_RT_PRIO)
+		prio += MAX_USER_PRIO;
+	return(prio);
+}
+
+/*
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
@@ -223,14 +275,17 @@
  */
 static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
+
 	array->nr_active--;
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
+	p->prio = real_prio(p->prio,  task_rq(p)->prio_ind);
 }
 
 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
+	p->prio = queue_prio(p->prio, task_rq(p)->prio_ind);
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
@@ -255,10 +310,8 @@
 {
 	int bonus, prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
-
-	prio = p->static_prio - bonus;
+	prio =  p->static_prio + (10 * p->run_avg/MAX_RUN_AVG) - 5;
+	prio = (p->prio*3 + prio)/4;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
@@ -266,6 +319,53 @@
 	return prio;
 }
 
+
+/*
+ * Calculate decaying average.
+ * 
+ * run_avg *= exp(log(alpha) * number_of_ticks);
+ * alpha = exp(log(0.5)/half_life);
+ * 
+ * Of course we need to do this with simple integer math :-)
+ */
+
+void update_run_avg(task_t *p, int v)
+{
+	int hl, as, i, j, shift;
+
+	unsigned long sleep_time = jiffies - p->sleep_timestamp;
+	p->sleep_timestamp = jiffies;
+
+	if (HZ > 100) {
+		hl = 2000;	/* half life of 2 seconds at HZ=1000 */
+		as = -23;	/* 64*1024*log(0.5)/hl */
+	} else {
+		hl = 200;	/* half life of 2 seconds at HZ=100 */
+		as = -229;	/* 64*1024*log(0.5)/hl */
+	}
+	if (sleep_time > 16*hl) {
+		p->run_avg = 0;
+		return;
+	}
+	shift = 16;
+	while (sleep_time > hl) {
+		shift++;
+		sleep_time -= hl;
+	}
+	/*
+	 * Approximate exp using first 2 terms of:
+	 * exp(x) = 1 + x/1! + x^2/2! + x^3/3! ...
+	 */
+	i = sleep_time * as;
+	j = 64*1024 + i + i*i/(2*64*1024);
+	p->run_avg = (p->run_avg * j) >> shift;
+	if (!v)
+		return;
+	p->run_avg += 2;
+	if (p->run_avg > MAX_RUN_AVG)
+		p->run_avg = MAX_RUN_AVG;
+}
+
 /*
  * activate_task - move a task to the runqueue.
 
@@ -285,9 +385,8 @@
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
-		p->sleep_avg += sleep_time;
-		if (p->sleep_avg > MAX_SLEEP_AVG)
-			p->sleep_avg = MAX_SLEEP_AVG;
+
+		update_run_avg(p, 0);
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
@@ -425,7 +524,8 @@
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
 
-		if (p->prio < rq->curr->prio)
+		if (real_prio(p->prio, task_rq(p)->prio_ind) <
+	 	    real_prio(rq->curr->prio, task_rq(p)->prio_ind))
 			resched_task(rq->curr);
 		success = 1;
 	}
@@ -457,8 +557,9 @@
 		 * and children as well, to keep max-interactive tasks
 		 * from forking tasks that are max-interactive.
 		 */
-		current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+		p->run_avg = 0;
+		p->prio = 120;
+		p->sleep_timestamp = jiffies;
 		p->prio = effective_prio(p);
 	}
 	set_task_cpu(p, smp_processor_id());
@@ -487,13 +588,6 @@
 			p->parent->time_slice = MAX_TIMESLICE;
 	}
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 /**
@@ -725,7 +819,8 @@
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (p->prio < this_rq->curr->prio)
+	if (real_prio(p->prio, task_rq(p)->prio_ind) <
+	    real_prio(this_rq->curr->prio, task_rq(p)->prio_ind))
 		set_need_resched();
 }
 
@@ -860,6 +955,7 @@
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	int prio;
 
 	run_local_timers();
 	if (p == rq->idle) {
@@ -883,6 +979,20 @@
 		return;
 	}
 	spin_lock(&rq->lock);
+	prio = real_prio(p->prio, task_rq(p)->prio_ind);
+	sched_hist[prio]++;
+	/*
+	 * I assume that the highest priority queue will be empty
+	 * most of the time.
+	 */
+	if (unlikely(list_empty(rq->active->queue+MAX_RT_PRIO+rq->prio_ind) &&
+		--rq->rotate_cnt <= 0)) {
+		rq->rotate_cnt = rotate_rate;
+		if (rq->prio_ind < MAX_USER_PRIO-1)
+			rq->prio_ind++;
+		else
+			rq->prio_ind = 0;
+	}
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -907,21 +1017,19 @@
 	 * it possible for interactive tasks to use up their
 	 * timeslices at their highest priority levels.
 	 */
-	if (p->sleep_avg)
-		p->sleep_avg--;
+	/*
+	 * We may have been in the run queue but not been given
+	 * a cpu for a long time so we should decay this value.
+	 */
+	update_run_avg(p, 1);
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
+		if (p->prio < MAX_PRIO-1)
+			p->prio++;
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
-
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+		enqueue_task(p, rq->active);
 	}
 out:
 #if CONFIG_SMP
@@ -1010,6 +1118,13 @@
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
+	if (idx >= MAX_RT_PRIO && idx != MAX_PRIO) {
+		int new_idx;
+		new_idx = find_next_bit(array->bitmap, MAX_PRIO,
+			MAX_RT_PRIO+rq->prio_ind);
+		if (new_idx != MAX_PRIO)
+			idx = new_idx;
+	}
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
@@ -1337,6 +1452,13 @@
  */
 int task_prio(task_t *p)
 {
+	/*
+	 * This has SMP race potential.  As long as it is only
+	 * for display purposes do we care?
+	 */
+	if (p->array)
+		return (real_prio(p->prio, task_rq(p)->prio_ind) -
+			 MAX_USER_RT_PRIO);
 	return p->prio - MAX_USER_RT_PRIO;
 }
 
@@ -1663,7 +1785,17 @@
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+		/*
+		 * Is this o.k?  Do I need to restore the original
+		 * priority?  Maybe just move down one level?
+		 */
+#if 0
+		current->prio = MAX_PRIO-1;
+#else
+		if (current->prio < MAX_PRIO-1)
+			current->prio++;
+#endif
+		enqueue_task(current, array);
 	} else {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
