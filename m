Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272653AbTHPI4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272661AbTHPI4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:56:34 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:22989
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272653AbTHPI4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:56:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O16.2int
Date: Sat, 16 Aug 2003 19:02:52 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8MfP/MaiVsmWoQA"
Message-Id: <200308161902.52337.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8MfP/MaiVsmWoQA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Much simpler

Con

--Boundary-00=_8MfP/MaiVsmWoQA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O16.1-O16.2int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O16.1-O16.2int"

--- linux-2.6.0-test3-mm2-O16/kernel/sched.c	2003-08-16 17:38:49.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16.2/kernel/sched.c	2003-08-16 17:38:28.000000000 +1000
@@ -143,6 +143,9 @@
 #define VARYING_CREDIT(p) \
 	(!(HIGH_CREDIT(p) || LOW_CREDIT(p)))
 
+#define TASK_PREEMPTS_CURR(p, rq) \
+	((p)->prio < (rq)->curr->prio)
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -463,24 +466,15 @@ static inline void activate_task(task_t 
 		 * of time they spend on the runqueue, waiting for execution
 		 * on a CPU, first time around:
 		 */
-		if (in_interrupt()){
+		if (in_interrupt())
 			p->activated = 2;
-			p->waker = p;
-		} else {
+		else
 		/*
 		 * Normal first-time wakeups get a credit too for on-runqueue
 		 * time, but it will be weighted down:
 		 */
 			p->activated = 1;
-			p->waker = current;
 		}
-	} else {
-		if (in_interrupt())
-			p->waker = p;
-		else
-			p->waker = current;
-	}
-
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -564,20 +558,6 @@ repeat:
 }
 #endif
 
-static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
-{
-	if (p->prio < rq->curr->prio) {
-			/*
-			 * Prevent a task preempting it's own waker
-			 * to avoid starvation
-			 */
-			if (unlikely(rq->curr == p->waker))
-				return 0;
-			return 1;
-	}
-	return 0;
-}
-
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -629,8 +609,9 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				if (task_preempts_curr(p, rq))
-					resched_task(rq->curr);
+				if (TASK_PREEMPTS_CURR(p, rq) &&
+					(in_interrupt() || !p->mm))
+						resched_task(rq->curr);
 			}
 			success = 1;
 		}
@@ -684,7 +665,6 @@ void wake_up_forked_process(task_t * p)
 	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
 		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 
-	p->waker = p->parent;
 	p->interactive_credit = 0;
 
 	p->prio = effective_prio(p);
@@ -1131,7 +1111,7 @@ static inline void pull_task(runqueue_t 
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (task_preempts_curr(p, this_rq))
+	if (TASK_PREEMPTS_CURR(p, this_rq))
 		set_need_resched();
 }
 
--- linux-2.6.0-test3-mm2-O16/include/linux/sched.h	2003-08-15 15:18:36.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16.2/include/linux/sched.h	2003-08-16 17:39:20.000000000 +1000
@@ -378,7 +378,6 @@ struct task_struct {
 	 */
 	struct task_struct *real_parent; /* real parent process (when being debugged) */
 	struct task_struct *parent;	/* parent process */
-	struct task_struct *waker;	/* waker process */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
 	struct task_struct *group_leader;

--Boundary-00=_8MfP/MaiVsmWoQA--

