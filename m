Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbTCQKLd>; Mon, 17 Mar 2003 05:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbTCQKLd>; Mon, 17 Mar 2003 05:11:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48609 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261466AbTCQKLc>;
	Mon, 17 Mar 2003 05:11:32 -0500
Date: Mon, 17 Mar 2003 11:21:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@zip.com.au>
Subject: [patch] sched-2.5.64-D3, more interactivity changes
Message-ID: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) implements more finegrained timeslice
distribution, without changing the total balance of timeslices, by
recalculating the priority of CPU-bound tasks at a finer granularity, and
by roundrobining tasks. Right now this new granularity is 50 msecs (the
default timeslice for default priority tasks is 100 msecs).

Could people, who can reproduce 'audio skips' kind of problems even with
BK-curr, give this patch a go?

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -73,6 +73,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
+#define TIMESLICE_GRANULARITY	(HZ/20 ?: 1)
 #define NODE_THRESHOLD		125
 
 /*
@@ -1259,6 +1260,27 @@ void scheduler_tick(int user_ticks, int 
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

