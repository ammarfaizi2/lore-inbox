Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSAIFAa>; Wed, 9 Jan 2002 00:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSAIFAW>; Wed, 9 Jan 2002 00:00:22 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:4872 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288800AbSAIFAO>; Wed, 9 Jan 2002 00:00:14 -0500
Date: Tue, 8 Jan 2002 21:05:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Mike Kravetz wrote:

> Below are some benchmark results when running the D1 version
> of the O(1) scheduler on 2.5.2-pre9.  To add another data point,
> I hacked together a half-a** multi-queue scheduler based on
> the 2.5.2-pre9 scheduler.  haMQ doesn't do load balancing or
> anything fancy.  However, it aggressively tries to not let CPUs
> go idle (not always a good thing as has been previously discussed).
> For reference, patch is at: lse.sourceforge.net/scheduling/2.5.2-pre9-hamq
> I can't recommend this code for anything useful.
>
> All benchmarks were run on an 8-way Pentium III 700 MHz 1MB caches.
> Number of CPUs was altered via the maxcpus boot flag.
>
> --------------------------------------------------------------------
> mkbench - Time how long it takes to compile the kernel.
>         We use 'make -j 8' and increase the number of makes run
>         in parallel.  Result is average build time in seconds.
>         Lower is better.
> --------------------------------------------------------------------
> # CPUs      # Makes         Vanilla         O(1)	haMQ
> --------------------------------------------------------------------
> 2           1                188             192        184
> 2           2                366             372        362
> 2           4                730             742        600
> 2           6               1096            1112        853
> 4           1                102             101         95
> 4           2                196             198        186
> 4           4                384             386        374
> 4           6                576             579        487
> 8           1                 58              57         58
> 8           2                109             108        105
> 8           4                209             213        186
> 8           6                309             312        280
>
> Surprisingly, O(1) seems to do worse than the vanilla scheduler
> in almost all cases.
>
> --------------------------------------------------------------------
> Chat - VolanoMark simulator.  Result is a measure of throughput.
>        Higher is better.
> --------------------------------------------------------------------
> Configuration Parms     # CPUs   Vanilla    O(1)      haMQ
> --------------------------------------------------------------------
> 10 rooms, 200 messages  2        162644     145915    137097
> 20 rooms, 200 messages  2        145872     136134    138646
> 30 rooms, 200 messages  2        124314     183366    144403
> 10 rooms, 200 messages  4        201745     258444    255415
> 20 rooms, 200 messages  4        177854     246032    263723
> 30 rooms, 200 messages  4        153506     302615    257170
> 10 rooms, 200 messages  8        121792     262804    310603
> 20 rooms, 200 messages  8         68697     248406    420157
> 30 rooms, 200 messages  8         42133     302513    283817
>
> O(1) scheduler does better than Vanilla as load and number of
> CPUs increase.  Still need to look into why it does worse on
> the less loaded 2 CPU runs.
>
> --------------------------------------------------------------------
> Reflex - lat_ctx(of LMbench) on steroids.  Does token passing
>          to over emphasize scheduler paths.  Allows loading of
>          the runqueue unlike lat_ctx.  Result is microseconds
>          per round.  Lower is better.  All runs with 0 delay.
>          lse.sourceforge.net/scheduling/other/reflex/
>          Lower is better.
> --------------------------------------------------------------------
> #tasks   # CPUs       Vanilla        O(1)         haMQ
> --------------------------------------------------------------------
> 2        2             6.594       14.388       15.996
> 4        2             6.988        3.787        4.686
> 8        2             7.322        3.757        5.148
> 16       2             7.234        3.737        7.244
> 32       2             7.651        5.135        7.182
> 64       2             9.462        3.948        7.553
> 128      2            13.889        4.584        7.918
> 2        4             6.019       14.646       15.403
> 4        4            10.997        6.213        6.755
> 8        4             9.838        2.160        2.838
> 16       4            10.595        2.154        3.080
> 32       4            11.870        2.917        3.400
> 64       4            15.280        2.890        3.131
> 128      4            19.832        2.685        3.307
> 2        8             6.338        9.064       15.474
> 4        8            11.454        7.020        8.281
> 8        8            13.354        4.390        5.816
> 16       8            14.976        1.502        2.018
> 32       8            16.757        1.920        2.240
> 64       8            19.961        2.264        2.358
> 128      8            25.010        2.280        2.260
>
> I believe the poor showings for O(1) at the low end are the
> result of having the 2 tasks run on 2 different CPUs.  This
> is the right thing to do in spite of the numbers.  You
> can see lock contention become a factor in the Vanilla scheduler
> as load and number of CPUs increase.  Having multiple runqueues
> eliminates this problem.

Awesome job Mike. Ingo's O(1) scheduler is still 'young' and can be
improved expecially from a balancing point of view. I think that it'll
here that the real challenge will take place ( even if Linus keeps saying
that it's easy :-) ).
Mike can you try the patch listed below on custom pre-10 ?
I've got 30-70% better performances with the chat_s/c test.




PS: next time we'll have lunch i'll talk you about a wanderful tool called
	gnuplot :)



- Davide




diff -Nru linux-2.5.2-pre10.vanilla/include/linux/sched.h linux-2.5.2-pre10.mqo1/include/linux/sched.h
--- linux-2.5.2-pre10.vanilla/include/linux/sched.h	Mon Jan  7 17:12:45 2002
+++ linux-2.5.2-pre10.mqo1/include/linux/sched.h	Mon Jan  7 21:45:19 2002
@@ -305,11 +305,7 @@
 	prio_array_t *array;

 	unsigned int time_slice;
-	unsigned long sleep_timestamp, run_timestamp;
-
-	#define SLEEP_HIST_SIZE 4
-	int sleep_hist[SLEEP_HIST_SIZE];
-	int sleep_idx;
+	unsigned long swap_cnt_last;

 	unsigned long policy;
 	unsigned long cpus_allowed;
diff -Nru linux-2.5.2-pre10.vanilla/kernel/fork.c linux-2.5.2-pre10.mqo1/kernel/fork.c
--- linux-2.5.2-pre10.vanilla/kernel/fork.c	Mon Jan  7 17:12:45 2002
+++ linux-2.5.2-pre10.mqo1/kernel/fork.c	Mon Jan  7 18:49:34 2002
@@ -705,9 +705,6 @@
 		current->time_slice = 1;
 		expire_task(current);
 	}
-	p->sleep_timestamp = p->run_timestamp = jiffies;
-	memset(p->sleep_hist, 0, sizeof(p->sleep_hist[0])*SLEEP_HIST_SIZE);
-	p->sleep_idx = 0;
 	__restore_flags(flags);

 	/*
diff -Nru linux-2.5.2-pre10.vanilla/kernel/sched.c linux-2.5.2-pre10.mqo1/kernel/sched.c
--- linux-2.5.2-pre10.vanilla/kernel/sched.c	Mon Jan  7 17:12:45 2002
+++ linux-2.5.2-pre10.mqo1/kernel/sched.c	Tue Jan  8 18:28:02 2002
@@ -48,6 +48,7 @@
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, last_rt_event;
 	task_t *curr, *idle;
+	unsigned long swap_cnt;
 	prio_array_t *active, *expired, arrays[2];
 	char __pad [SMP_CACHE_BYTES];
 } runqueues [NR_CPUS] __cacheline_aligned;
@@ -91,115 +92,20 @@
 	p->array = array;
 }

-/*
- * This is the per-process load estimator. Processes that generate
- * more load than the system can handle get a priority penalty.
- *
- * The estimator uses a 4-entry load-history ringbuffer which is
- * updated whenever a task is moved to/from the runqueue. The load
- * estimate is also updated from the timer tick to get an accurate
- * estimation of currently executing tasks as well.
- */
-#define NEXT_IDX(idx) (((idx) + 1) % SLEEP_HIST_SIZE)
-
-static inline void update_sleep_avg_deactivate(task_t *p)
-{
-	unsigned int idx;
-	unsigned long j = jiffies, last_sample = p->run_timestamp / HZ,
-		curr_sample = j / HZ, delta = curr_sample - last_sample;
-
-	if (unlikely(delta)) {
-		if (delta < SLEEP_HIST_SIZE) {
-			for (idx = 0; idx < delta; idx++) {
-				p->sleep_idx++;
-				p->sleep_idx %= SLEEP_HIST_SIZE;
-				p->sleep_hist[p->sleep_idx] = 0;
-			}
-		} else {
-			for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
-				p->sleep_hist[idx] = 0;
-			p->sleep_idx = 0;
-		}
-	}
-	p->sleep_timestamp = j;
-}
-
-#if SLEEP_HIST_SIZE != 4
-# error update this code.
-#endif
-
-static inline unsigned int get_sleep_avg(task_t *p, unsigned long j)
-{
-	unsigned int sum;
-
-	sum = p->sleep_hist[0];
-	sum += p->sleep_hist[1];
-	sum += p->sleep_hist[2];
-	sum += p->sleep_hist[3];
-
-	return sum * HZ / ((SLEEP_HIST_SIZE-1)*HZ + (j % HZ));
-}
-
-static inline void update_sleep_avg_activate(task_t *p, unsigned long j)
-{
-	unsigned int idx;
-	unsigned long delta_ticks, last_sample = p->sleep_timestamp / HZ,
-		curr_sample = j / HZ, delta = curr_sample - last_sample;
-
-	if (unlikely(delta)) {
-		if (delta < SLEEP_HIST_SIZE) {
-			p->sleep_hist[p->sleep_idx] += HZ - (p->sleep_timestamp % HZ);
-			p->sleep_idx++;
-			p->sleep_idx %= SLEEP_HIST_SIZE;
-
-			for (idx = 1; idx < delta; idx++) {
-				p->sleep_idx++;
-				p->sleep_idx %= SLEEP_HIST_SIZE;
-				p->sleep_hist[p->sleep_idx] = HZ;
-			}
-		} else {
-			for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
-				p->sleep_hist[idx] = HZ;
-			p->sleep_idx = 0;
-		}
-		p->sleep_hist[p->sleep_idx] = 0;
-		delta_ticks = j % HZ;
-	} else
-		delta_ticks = j - p->sleep_timestamp;
-	p->sleep_hist[p->sleep_idx] += delta_ticks;
-	p->run_timestamp = j;
-}
-
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *array = rq->active;
-	unsigned long j = jiffies;
-	unsigned int sleep, load;
-	int penalty;

-	if (likely(p->run_timestamp == j))
-		goto enqueue;
-	/*
-	 * Give the process a priority penalty if it has not slept often
-	 * enough in the past. We scale the priority penalty according
-	 * to the current load of the runqueue, and the 'load history'
-	 * this process has. Eg. if the CPU has 3 processes running
-	 * right now then a process that has slept more than two-thirds
-	 * of the time is considered to be 'interactive'. The higher
-	 * the load of the CPUs is, the easier it is for a process to
-	 * get an non-interactivity penalty.
-	 */
-#define MAX_PENALTY (MAX_USER_PRIO/3)
-	update_sleep_avg_activate(p, j);
-	sleep = get_sleep_avg(p, j);
-	load = HZ - sleep;
-	penalty = (MAX_PENALTY * load)/HZ;
 	if (!rt_task(p)) {
-		p->prio = NICE_TO_PRIO(p->__nice) + penalty;
-		if (p->prio > MAX_PRIO-1)
-			p->prio = MAX_PRIO-1;
+		unsigned long prio_bonus = rq->swap_cnt - p->swap_cnt_last;
+
+		p->swap_cnt_last = rq->swap_cnt;
+		if (prio_bonus > MAX_PRIO)
+			prio_bonus = MAX_PRIO;
+		p->prio -= prio_bonus;
+		if (p->prio < MAX_RT_PRIO)
+			p->prio = MAX_RT_PRIO;
 	}
-enqueue:
 	enqueue_task(p, array);
 	rq->nr_running++;
 }
@@ -209,7 +115,6 @@
 	rq->nr_running--;
 	dequeue_task(p, p->array);
 	p->array = NULL;
-	update_sleep_avg_deactivate(p);
 }

 static inline void resched_task(task_t *p)
@@ -535,33 +440,16 @@
 		p->need_resched = 1;
 		if (rt_task(p))
 			p->time_slice = RT_PRIO_TO_TIMESLICE(p->prio);
-		else
+		else {
 			p->time_slice = PRIO_TO_TIMESLICE(p->prio);
-
-		/*
-		 * Timeslice used up - discard any possible
-		 * priority penalty:
-		 */
-		dequeue_task(p, rq->active);
-		/*
-		 * Tasks that have nice values of -20 ... -15 are put
-		 * back into the active array. If they use up too much
-		 * CPU time then they'll get a priority penalty anyway
-		 * so this can not starve other processes accidentally.
-		 * Otherwise this is pretty handy for sysadmins ...
-		 */
-		if (p->prio <= MAX_RT_PRIO + MAX_PENALTY/2)
-			enqueue_task(p, rq->active);
-		else
+			/*
+			 * Timeslice used up - discard any possible
+			 * priority penalty:
+			 */
+			dequeue_task(p, rq->active);
+			if (++p->prio >= MAX_PRIO)
+				p->prio = MAX_PRIO - 1;
 			enqueue_task(p, rq->expired);
-	} else {
-		/*
-		 * Deactivate + activate the task so that the
-		 * load estimator gets updated properly:
-		 */
-		if (!rt_task(p)) {
-			deactivate_task(p, rq);
-			activate_task(p, rq);
 		}
 	}
 	load_balance(rq);
@@ -616,6 +504,7 @@
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
+		rq->swap_cnt++;
 	}

 	idx = sched_find_first_zero_bit(array->bitmap);
@@ -1301,6 +1190,7 @@
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		rq->cpu = i;
+		rq->swap_cnt = 0;

 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;


