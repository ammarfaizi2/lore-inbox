Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTESINS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTESINS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:13:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37608 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S262369AbTESINQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:13:16 -0400
Date: Mon, 19 May 2003 10:25:44 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched-cleanup-2.5.69-A0
Message-ID: <Pine.LNX.4.44.0305191024320.4241-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached scheduler cleanup (against BK-curr) removes the unused
requeueing code. Compiles & boots.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -340,10 +340,9 @@ static inline void __activate_task(task_
  * Update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
-static inline int activate_task(task_t *p, runqueue_t *rq)
+static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	long sleep_time = jiffies - p->last_run - 1;
-	int requeue_waker = 0;
 
 	if (sleep_time > 0) {
 		int sleep_avg;
@@ -372,8 +371,6 @@ static inline int activate_task(task_t *
 		}
 	}
 	__activate_task(p, rq);
-
-	return requeue_waker;
 }
 
 /*
@@ -471,8 +468,8 @@ repeat:
  */
 static int try_to_wake_up(task_t * p, unsigned int state, int sync, int kick)
 {
-	int success = 0, requeue_waker = 0;
 	unsigned long flags;
+	int success = 0;
 	long old_state;
 	runqueue_t *rq;
 
@@ -498,7 +495,7 @@ repeat_lock_task:
 			if (sync)
 				__activate_task(p, rq);
 			else {
-				requeue_waker = activate_task(p, rq);
+				activate_task(p, rq);
 				if (p->prio < rq->curr->prio)
 					resched_task(rq->curr);
 			}
@@ -510,21 +507,6 @@ repeat_lock_task:
 	}
 	task_rq_unlock(rq, &flags);
 
-	/*
-	 * We have to do this outside the other spinlock, the two
-	 * runqueues might be different:
-	 */
-	if (requeue_waker) {
-		prio_array_t *array;
-
-		rq = task_rq_lock(current, &flags);
-		array = current->array;
-		dequeue_task(current, array);
-		current->prio = effective_prio(current);
-		enqueue_task(current, array);
-		task_rq_unlock(rq, &flags);
-	}
-
 	return success;
 }
 

