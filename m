Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289394AbSAORX1>; Tue, 15 Jan 2002 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290068AbSAORXT>; Tue, 15 Jan 2002 12:23:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:41994 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289394AbSAORXC>; Tue, 15 Jan 2002 12:23:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 09:28:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -I0
In-Reply-To: <Pine.LNX.4.33.0201151532290.9349-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201150915590.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Ingo Molnar wrote:

>
> the -I0 patch is available at:
>
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-final-I0.patch
>
> stock 2.5.2 includes a 'interactivity estimator' method that includes most
> of the things i think to be important for good interactivity:
>
>  - sleep time based priority boost/penalty.
>
>  - constant frequency runqueue sampling instead of recalculation/switch
>    based runqueue sampling.
>
>  - interactivity based runqueue insertion on timeslice expire.
>
> I'm very happy about the 2.5.2 solution, it's simpler than the one i used
> in -H7 - good work Davide!

I should probably know that good works rarely born from a single head :-)



> There are a number of problems in 2.5.2 that need fixing though:
>
>  - renicing is broken - it does not work at all, neither up nor down, for
>    CPU-bound tasks. Renicing fell victim to the attempt to penalize CPU
>    hogs as much as possible: every CPU-bound task reaches the lowest
>    priority level and stays there. This also makes kernel compile times
>    suffer.
>
>  - RT scheduling is broken.

Why ?


>  - the sleep average is hidden in p->prio, which makes it harder to
>    recover and use the true interactiveness of the task.
>
>  - the runqueue is sampled at a frequency of 20 HZ, which can misdetect
>    periodic user tasks that somehow correlate with 20 HZ.
>
> I've fixed these problems/bugs by taking some of the -H7 solutions:
>
>  - introducing p->sleep_avg, which is updated in a lightweight way. No
>    more 'history slots'. A single counter, updated in a very simple way.
>
>  - limiting the bonus/penalty range according to nice levels - a task can
>    at most get a 5 priority levels penalty over the default level, in
>    stock 2.5.2 it can get to the nice +19 level after a few seconds
>    runtime. Nice levels work again.
>
>  - introducing HZ frequency runqueue sampling. Also the MAX_SLEEP_AVG
>    constant tells us how long into the past we are looking. This is 2
>    seconds right now.
>
>  - separating the RT timeslice code in scheduler_tick(), we used to break
>    the RT case way too often, now we can hack the SCHED_OTHER code without
>    having to touch the RT part.
>
>  - plus the patch also includes all the fixes and improvements from the
>    -H7 patch.

Ingo, IMHO is not correct to give time slices depending on priority and we
should return to the old TS(nice) behavior. This avoid also complex
priority bounding tricks. The other issue, as i wrote to you and Linus
yesterday, is about priority adjustment in do_fork(). IMVHO is not correct
to have new tasks to fully inherit parent priority because :

1) if an interactive task is born it'll show up its behavior very soon
	with an high sleep/run time ratio, and it'll top MAX_RT_PRIO

2) if an interactive task is born we do not need an immediate priority boost

3) if a cpu bound task born from an interactive task ( very very common )
	it'll make a long run on the cpu before falling in the hell of cpu
	bound tasks

I've also decreased the minimum time slice to 10ms and increased the max
to 160ms and this should cast back niced tasks to low cpu usages.
I'm using it in my desk and just to have fun i keep running make -j20 in
background :-)




- Davide



include/linux/sched.h |   44 +++++++++-----------------------------------
kernel/fork.c         |    3 +++
kernel/sched.c        |   14 ++++----------
3 files changed, 16 insertions, 45 deletions




diff -Nru linux-2.5.2.vanilla/include/linux/sched.h linux-2.5.2.mqo1/include/linux/sched.h
--- linux-2.5.2.vanilla/include/linux/sched.h	Mon Jan 14 13:27:08 2002
+++ linux-2.5.2.mqo1/include/linux/sched.h	Mon Jan 14 20:05:17 2002
@@ -455,45 +455,19 @@
 #define DEF_USER_NICE	0

 /*
- * Scales user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ 24 ... 63 (MAX_PRIO-1) ]
- *
- * User-nice value of -20 == static priority 24, and
- * user-nice value 19 == static priority 63. The lower
- * the priority value, the higher the task's priority.
- *
- * Note that while static priority cannot go below 24,
- * the priority of a process can go as low as 0.
+ * Default timeslice is 80 msecs, maximum is 160 msecs.
+ * Minimum timeslice is 10 msecs.
  */
-#define NICE_TO_PRIO(n)	(MAX_PRIO-1 + (n) - 19)
-
-#define DEF_PRIO NICE_TO_PRIO(DEF_USER_NICE)
-
-/*
- * Default timeslice is 90 msecs, maximum is 150 msecs.
- * Minimum timeslice is 20 msecs.
- */
-#define MIN_TIMESLICE	( 20 * HZ / 1000)
-#define MAX_TIMESLICE	(150 * HZ / 1000)
+#define MIN_TIMESLICE	(10 * HZ / 1000)
+#define MAX_TIMESLICE	(160 * HZ / 1000)

 #define USER_PRIO(p) ((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO (USER_PRIO(MAX_PRIO))
+#define DEF_PRIO	(MAX_RT_PRIO + MAX_USER_PRIO / 3)
+#define NICE_TO_PRIO(n) (MAX_PRIO-1 + (n) - 19)

-/*
- * PRIO_TO_TIMESLICE scales priority values [ 100 ... 139  ]
- * to initial time slice values [ MAX_TIMESLICE (150 msec) ... 2 ]
- *
- * The higher a process's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority process gets MIN_TIMESLICE worth of execution time.
- */
-#define PRIO_TO_TIMESLICE(p) \
-	((( (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
-		MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)
-
-#define RT_PRIO_TO_TIMESLICE(p) \
-	((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
-			MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)
+#define NICE_TO_TIMESLICE(n)   (MIN_TIMESLICE + \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * ((n) + 20)) / 39)

 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
 extern void set_user_nice(task_t *p, long nice);
@@ -523,7 +497,7 @@
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
-    time_slice:		PRIO_TO_TIMESLICE(DEF_PRIO),			\
+    time_slice:		NICE_TO_TIMESLICE(DEF_USER_NICE),			\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
     p_opptr:		&tsk,						\
diff -Nru linux-2.5.2.vanilla/kernel/fork.c linux-2.5.2.mqo1/kernel/fork.c
--- linux-2.5.2.vanilla/kernel/fork.c	Wed Jan  9 16:16:28 2002
+++ linux-2.5.2.mqo1/kernel/fork.c	Mon Jan 14 19:51:52 2002
@@ -707,6 +707,9 @@
 	}
 	__restore_flags(flags);

+	if (p->policy == SCHED_OTHER)
+		p->prio = MAX_PRIO - 1 - ((MAX_PRIO - 1 - p->prio) * 1) / 3;
+
 	/*
 	 * Ok, add it to the run-queues and make it
 	 * visible to the rest of the system.
diff -Nru linux-2.5.2.vanilla/kernel/sched.c linux-2.5.2.mqo1/kernel/sched.c
--- linux-2.5.2.vanilla/kernel/sched.c	Mon Jan 14 11:39:31 2002
+++ linux-2.5.2.mqo1/kernel/sched.c	Mon Jan 14 19:56:51 2002
@@ -21,7 +21,7 @@
 #include <asm/mmu_context.h>

 #define BITMAP_SIZE ((MAX_PRIO+7)/8)
-#define PRIO_INTERACTIVE	(MAX_RT_PRIO + (MAX_PRIO - MAX_RT_PRIO) / 4)
+#define PRIO_INTERACTIVE	(MAX_RT_PRIO + (MAX_PRIO - MAX_RT_PRIO) / 3)
 #define TASK_INTERACTIVE(p)	((p)->prio >= MAX_RT_PRIO && (p)->prio <= PRIO_INTERACTIVE)
 #define JSLEEP_TO_PRIO(t)	(((t) * 20) / HZ)

@@ -440,20 +440,14 @@
 	 */
 	spin_lock_irqsave(&rq->lock, flags);
 	if ((p->policy != SCHED_FIFO) && !--p->time_slice) {
-		unsigned int time_slice;
 		p->need_resched = 1;
 		dequeue_task(p, rq->active);
-		time_slice = RT_PRIO_TO_TIMESLICE(p->prio);
 		if (!rt_task(p)) {
-			time_slice = PRIO_TO_TIMESLICE(p->prio);
 			if (++p->prio >= MAX_PRIO)
 				p->prio = MAX_PRIO - 1;
 		}
-		p->time_slice = time_slice;
-		if (TASK_INTERACTIVE(p))
-			enqueue_task(p, rq->active);
-		else
-			enqueue_task(p, rq->expired);
+		p->time_slice = NICE_TO_TIMESLICE(p->__nice);
+		enqueue_task(p, TASK_INTERACTIVE(p) ? rq->active: rq->expired);
 	}
 	spin_unlock_irqrestore(&rq->lock, flags);
 }
@@ -1024,7 +1018,7 @@
 	p = find_process_by_pid(pid);
 	if (p)
 		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : RT_PRIO_TO_TIMESLICE(p->prio), &t);
+					 0 : NICE_TO_TIMESLICE(p->__nice), &t);
 	read_unlock(&tasklist_lock);
 	if (p)
 		retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;


