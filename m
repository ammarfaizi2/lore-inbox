Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbTCYJNf>; Tue, 25 Mar 2003 04:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTCYJNf>; Tue, 25 Mar 2003 04:13:35 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16533 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261823AbTCYJNb>;
	Tue, 25 Mar 2003 04:13:31 -0500
Date: Tue, 25 Mar 2003 10:23:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] sched-2.5.66-A2, scheduler enhancements
Message-ID: <Pine.LNX.4.44.0303251003020.22121-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch does three changes to the 2.5.66 scheduler, mostly to
clean up various aspects of timeslice management:

- cleans up timeslice scaling. Right now the default timeslice is 102
  msecs, while the intended timeslice length is 100 msecs. With the fixed 
  up defines it's now very precise:

	BASE_TIMESLICE(NICE_TO_PRIO(-20)): 200
	BASE_TIMESLICE(NICE_TO_PRIO(0)): 100
	BASE_TIMESLICE(NICE_TO_PRIO(19)): 5

- decreases the minimum timeslice from 10 msecs to 5 msecs. This makes a 
  measurable difference for nice +19 CPU-hogs - they now use up 4.7% CPU 
  time when competing against a default-prio CPU hog, they used to take up
  10% of CPU time before.

- introduces TIMESLICE_GRANULARITY, which defaults to 50 msecs.

timeslice granularity achieves several things: it splits up the timeslice
of high-prio CPU hogs, this makes game-alike multitasking more 'smooth'.
It also splits up the timeslice of interactive tasks, which can have as
much as MAX_TIMESLICE timeslices [due to the exit()-feedback]. So instead
of having a big burst of 200 msec processing at maximum priority, the task
will do 4 chunks of 50 msec processing, re-adjusting its priority at the
end of each sub-timeslice. This will lower its priority by ~1 level even
after the first 50 msecs, giving chance for other, max-prio interactive
tasks (such as audio playback threads) to run.

the global share of timeslices is not impacted by these sub-timeslices,
tasks still get the same amount of total CPU time, depending on their
static priority and on their interactivity. It's just that the bursts of
processing are more finegrained in some workloads. (they do not change in
other workloads.)

timeslice granularity has solved the 'audio skipping' regression reported
by Sean Estabrooks. Martin J. Bligh did testing on NUMA-Q box to see
whether batch jobs suffer from finer grained timeslices, and there was no
measurable impact (which is good).

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -64,7 +64,7 @@
  * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
+#define MIN_TIMESLICE		(( 5 * HZ / 1000) ?: 1)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
 #define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
@@ -73,6 +73,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
+#define TIMESLICE_GRANULARITY	(HZ/20 ?: 1)
 #define NODE_THRESHOLD		125
 
 /*
@@ -124,12 +125,17 @@
  * task_timeslice() is the interface that is used by the scheduler.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+#define BASE_TIMESLICE(p) \
+		(MAX_TIMESLICE * (MAX_PRIO-(p)->static_prio)/MAX_USER_PRIO)
 
-static inline unsigned int task_timeslice(task_t *p)
+static unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	unsigned int time_slice = BASE_TIMESLICE(p);
+
+	if (time_slice < MIN_TIMESLICE)
+		time_slice = MIN_TIMESLICE;
+
+	return time_slice;
 }
 
 /*
@@ -1259,6 +1265,27 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else {
+		/*
+		 * Prevent a too long timeslice allowing a task to monopolize
+		 * the CPU. We do this by splitting up the timeslice into
+		 * smaller pieces.
+		 *
+		 * Note: this does not mean the task's timeslices expire or
+		 * get lost in any way, they just might be preempted by
+		 * another task of equal priority. (one with higher
+		 * priority would have preempted this task already.) We
+		 * requeue this task to the end of the list on this priority
+		 * level, which is in essence a round-robin of tasks with
+		 * equal priority.
+		 */
+		if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
+			       		(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
 	}
 out:
 	spin_unlock(&rq->lock);


