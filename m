Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTHOQfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267952AbTHOQM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:12:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267186AbTHOQJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O16int for interactivity
Date: Sat, 16 Aug 2003 01:49:06 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yDQP/qc1C1SfEQs"
Message-Id: <200308160149.29834.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yDQP/qc1C1SfEQs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This one took a lot of detective work to track down the scheduler starvatio=
n=20
issue seen rarely, but reproducibly with certain applications. Thanks Mike=
=20
Galbraith for significantly narrowing my search path.

In O15 I mentioned that preventing parents from preempting their children=20
prevented starvation of applications where they would be busy on wait. Long=
=20
story to describe how, but I discovered the problem inducing starvation in=
=20
O15 was the same, but with wakers and their wakee. The wakee would preempt=
=20
the waker, and the waker could make no progress until it got rescheduled...=
=20
however if the wakee had better priority than the waker it preempted it unt=
il=20
it's own priority dropped enough for the waker to get scheduled. Because in=
=20
O15 the priority decayed slower we were able to see this happening in these=
=20
"busy on wait" applications... and they're not as rare as we'd like. In fac=
t=20
this wakee preemption is going on at a mild level all the time even in the=
=20
vanilla scheduler. I've experimented with ways to improve the=20
performance/feel of these applications but I found it was to the detriment =
of=20
most other apps, so this patch simply makes them run without inducing=20
starvation at usable performance. I'm not convinced the scheduler should ha=
ve=20
a workaround, but that the apps shouldn't busy on wait.

Those who experienced starvation could you please test this patch.

Changes:
Waker is now kept track of.

Only user tasks have the bonus ceiling from uninterruptible sleep.

Preemption of tasks at the same level with twice as much timeslice has been=
=20
dropped as this is not necessary with timeslice granularity (may improve=20
performance of cpu intensive tasks).

Preemption of user tasks is limited to those in the interactive range; cpu=
=20
intensive non interactive tasks can run out their full timeslice (may also=
=20
improve cpu intensive performance)

Tasks cannot preempt their own waker.

Cleanups etc.

This patch applies onto 2.6.0-test3-mm2 (or O15int)
and is available at http://kernel.kolivas.org/2.5

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/PQD1ZUg7+tp6mRURAkObAJ45p2KLBA6lGFQ588PnSuE4yhrGXgCeOpTL
9bhnnGW6e8Pfn1BTHG/wbh8=3D
=3DEQ52
=2D----END PGP SIGNATURE-----

--Boundary-00=_yDQP/qc1C1SfEQs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O15-O16int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O15-O16int"

--- linux-2.6.0-test3-mm2/include/linux/sched.h	2003-08-13 21:45:15.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16/include/linux/sched.h	2003-08-15 15:18:36.000000000 +1000
@@ -378,6 +378,7 @@ struct task_struct {
 	 */
 	struct task_struct *real_parent; /* real parent process (when being debugged) */
 	struct task_struct *parent;	/* parent process */
+	struct task_struct *waker;	/* waker process */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
 	struct task_struct *group_leader;
--- linux-2.6.0-test3-mm2/kernel/sched.c	2003-08-13 21:45:15.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16/kernel/sched.c	2003-08-16 01:11:54.000000000 +1000
@@ -117,6 +117,10 @@
  * too hard.
  */
 
+#define CURRENT_BONUS(p) \
+	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
+		MAX_SLEEP_AVG)
+
 #define SCALE(v1,v1_max,v2_max) \
 	(v1) * (v2_max) / (v1_max)
 
@@ -139,11 +143,6 @@
 #define VARYING_CREDIT(p) \
 	(!(HIGH_CREDIT(p) || LOW_CREDIT(p)))
 
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio || \
-		((p)->prio == (rq)->curr->prio && \
-			(p)->time_slice > (rq)->curr->time_slice * 2))
-
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -347,9 +346,7 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO * PRIO_BONUS_RATIO *
-		NS_TO_JIFFIES(p->sleep_avg) / MAX_SLEEP_AVG / 100;
-	bonus -= MAX_USER_PRIO * PRIO_BONUS_RATIO / 100 / 2;
+	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
@@ -373,9 +370,6 @@ static void recalc_task_prio(task_t *p, 
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (!p->sleep_avg && VARYING_CREDIT(p))
-		p->interactive_credit--;
-
 	if (__sleep_time > NS_MAX_SLEEP_AVG)
 		sleep_time = NS_MAX_SLEEP_AVG;
 	else
@@ -397,9 +391,7 @@ static void recalc_task_prio(task_t *p, 
 			 * The lower the sleep avg a task has the more
 			 * rapidly it will rise with sleep time.
 			 */
-			sleep_time *= (MAX_BONUS + 1 -
-					(NS_TO_JIFFIES(p->sleep_avg) *
-					MAX_BONUS / MAX_SLEEP_AVG));
+			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
 
 			/*
 			 * Tasks with low interactive_credit are limited to
@@ -412,9 +404,10 @@ static void recalc_task_prio(task_t *p, 
 
 			/*
 			 * Non high_credit tasks waking from uninterruptible
-			 * sleep are limited in their sleep_avg rise
+			 * sleep are limited in their sleep_avg rise as they
+			 * are likely to be waiting on I/O
 			 */
-			if (!HIGH_CREDIT(p) && p->activated == -1){
+			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
 				if (p->sleep_avg >=
 					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
 						sleep_time = 0;
@@ -436,12 +429,6 @@ static void recalc_task_prio(task_t *p, 
 			 */
 			p->sleep_avg += sleep_time;
 
-			/*
-			 * 'Overflow' bonus ticks go to the waker as well, so the
-			 * ticks are not lost. This has the effect of further
-			 * boosting tasks that are related to maximum-interactive
-			 * tasks.
-			 */
 			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
 				p->interactive_credit += VARYING_CREDIT(p);
@@ -476,14 +463,22 @@ static inline void activate_task(task_t 
 		 * of time they spend on the runqueue, waiting for execution
 		 * on a CPU, first time around:
 		 */
-		if (in_interrupt())
+		if (in_interrupt()){
 			p->activated = 2;
-		else
+			p->waker = p;
+		} else {
 		/*
 		 * Normal first-time wakeups get a credit too for on-runqueue
 		 * time, but it will be weighted down:
 		 */
 			p->activated = 1;
+			p->waker = current;
+		}
+	} else {
+		if (in_interrupt())
+			p->waker = p;
+		else
+			p->waker = current;
 	}
 
 	p->timestamp = now;
@@ -569,6 +564,21 @@ repeat:
 }
 #endif
 
+static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
+{
+	if (p->prio < rq->curr->prio &&
+		((TASK_INTERACTIVE(p) && p->mm) || !p->mm)) {
+			/*
+			 * Prevent a task preempting it's own waker
+			 * to avoid starvation
+			 */
+			if (unlikely(rq->curr == p->waker))
+				return 0;
+			return 1;
+	}
+	return 0;
+}
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -620,13 +630,8 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				/*
-				 * Parents are not allowed to preempt their
-				 * children
-				 */
-				if (TASK_PREEMPTS_CURR(p, rq) &&
-					p != rq->curr->parent)
-						resched_task(rq->curr);
+				if (task_preempts_curr(p, rq))
+					resched_task(rq->curr);
 			}
 			success = 1;
 		}
@@ -665,7 +670,7 @@ int wake_up_state(task_t *p, unsigned in
  */
 void wake_up_forked_process(task_t * p)
 {
-	unsigned long flags, sleep_avg;
+	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
 	p->state = TASK_RUNNING;
@@ -674,15 +679,13 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	sleep_avg = NS_TO_JIFFIES(current->sleep_avg) * MAX_BONUS /
-			MAX_SLEEP_AVG * PARENT_PENALTY / 100 *
-			MAX_SLEEP_AVG / MAX_BONUS;
-	current->sleep_avg = JIFFIES_TO_NS(sleep_avg);
-
-	sleep_avg = NS_TO_JIFFIES(p->sleep_avg) * MAX_BONUS / MAX_SLEEP_AVG *
-			CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS;
-	p->sleep_avg = JIFFIES_TO_NS(sleep_avg);
+	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
+		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+
+	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
+		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 
+	p->waker = p->parent;
 	p->interactive_credit = 0;
 
 	p->prio = effective_prio(p);
@@ -1129,7 +1132,7 @@ static inline void pull_task(runqueue_t 
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq) && p != this_rq->curr->parent)
+	if (task_preempts_curr(p, this_rq))
 		set_need_resched();
 }
 
@@ -1494,12 +1497,11 @@ need_resched:
 
 	/*
 	 * Tasks with interactive credits get charged less run_time
-	 * as their sleep_avg decreases to slow them losing their
-	 * priority bonus
+	 * at high sleep_avg to delay them losing their interactive
+	 * status
 	 */
 	if (HIGH_CREDIT(prev))
-		run_time /= ((NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
-				MAX_SLEEP_AVG) ? : 1);
+		run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 
@@ -1566,8 +1568,10 @@ switch_tasks:
 	RCU_qsctr(task_cpu(prev))++;
 
 	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg < 0)
+	if ((long)prev->sleep_avg <= 0){
 		prev->sleep_avg = 0;
+		prev->interactive_credit -= VARYING_CREDIT(prev);
+	}
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {

--Boundary-00=_yDQP/qc1C1SfEQs--

