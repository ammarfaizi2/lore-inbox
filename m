Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292309AbSBBPug>; Sat, 2 Feb 2002 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292310AbSBBPu1>; Sat, 2 Feb 2002 10:50:27 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:49370 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292309AbSBBPuV>; Sat, 2 Feb 2002 10:50:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] improving O(1)-J9 in heavily threaded situations
Date: Sat, 2 Feb 2002 10:50:11 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202155013.28C4615CFC@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch improves the performance of O(1) when under load 
and threaded programs are running.  For this patch, threaded is taken
to mean processes sharing their vm (p->mm).  While this type of 
programming is usually not optimal it is very common (ie. java).

Under load, with threaded tasks running niced, and a cpu bound task at 
normal priority we quickly notice the load average shooting up.  What 
is happening is all the threads are trying to run.  Due to the nature
of O(1) all the process in the current array must run to get on to the
inactive array.  This quickly leads to the higher priority cpu bound
task starving.  Running the threaded application at nice +19 can help
but does not solve the base issue.  On UP, I have observed loads of
between 20 and 40 when this is happening,

I tried various approaches to correcting this.  Neither reducing the 
timeslices or playing the the effective prio of the threaded tasks
helped much.  What does seems quite effective is to monitor the total 
time _all_ the tasks sharing a vm use.  Once a threshold is exceeded 
we move any tasks in the same group directly to the inactive array
temporarily increasing their effective prio.

With this change the cpu bound tasks can get over 80% of the cpu.

A couple of comments.  The patch applies its logic to all processes.
This limits the number of times interactive tasks can requeue.  With
this in place we can probably drop the expired_timeslice logic.

I see no reason that some of the tunables should not become part of
the standard scheduler provided they are not adding significant 
overhead.  The THREAD_PENALTY tunable is only used in the tick
processing logic (and not in the common path) - keeping it tunable 
should not introduce measureable overhead.

Patch against 2.4.17pre7

Comments and feedback welcome,
Ed Tomlinson

--- linux/include/linux/sched.h.orig	Fri Feb  1 23:19:44 2002
+++ linux/include/linux/sched.h	Fri Feb  1 23:16:34 2002
@@ -211,6 +211,8 @@
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	unsigned long mm_hogstamp[NR_CPUS];	/* timestamp to reset the hogslice */
+	unsigned long mm_hogslice[NR_CPUS];	/* when this reaches 0, task using this mm are hogs */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
 	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
@@ -486,6 +488,7 @@
 #define INTERACTIVE_DELTA       3
 #define MAX_SLEEP_AVG           (2*HZ)
 #define STARVATION_LIMIT        (2*HZ)
+#define THREAD_PENALTY		8
 
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
--- linux/kernel/sched.c.orig	Fri Feb  1 23:23:50 2002
+++ linux/kernel/sched.c	Fri Feb  1 23:12:49 2002
@@ -41,7 +41,7 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp;
+	unsigned long nr_running, nr_switches, expired_timestamp, switch_timestamp;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
@@ -614,6 +614,28 @@
		} else
 			enqueue_task(p, rq->active);
 	}
+ 
+	/*
+	 * Here we stop a single interactive task or a group of tasks sharing
+	 * a mm_struct (like java threads) from monopolizing the cpu.
+	 */
+	if (p->mm) {
+		if (p->mm->mm_hogstamp[smp_processor_id()] < rq->switch_timestamp) {
+			p->mm->mm_hogstamp[smp_processor_id()] = rq->switch_timestamp;
+			p->mm->mm_hogslice[smp_processor_id()] =
+				NICE_TO_TIMESLICE(p->__nice) * THREAD_PENALTY;
+		}
+		if (!p->mm->mm_hogslice[smp_processor_id()]) {
+			dequeue_task(p, rq->active);
+			p->need_resched = 1;
+			p->prio--;
+        		if (p->prio < MAX_RT_PRIO)
+                		p->prio = MAX_RT_PRIO;
+			enqueue_task(p, rq->expired);
+		} else
+			p->mm->mm_hogslice[smp_processor_id()]--;
+	}
+		
 out:
 #if CONFIG_SMP
 	if (!(now % BUSY_REBALANCE_TICK))
@@ -676,6 +698,7 @@
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
+		rq->switch_timestamp = jiffies;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);


