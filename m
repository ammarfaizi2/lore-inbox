Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTHSO5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTHSO4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:56:02 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:51345
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270479AbTHSOzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:55:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O17int
Date: Wed, 20 Aug 2003 01:01:28 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IvjQ/1ySkRlT3F/"
Message-Id: <200308200102.04155.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IvjQ/1ySkRlT3F/
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=46ood for the starving masses.

This patch prevents any single task from being able to starve the runqueue=
=20
that it's on. This minimises the impact a poorly behaved application or a=20
malicious one has on the rest of the system. If an interactive task (eg=20
blender) spins on wait on a cpu hog (X), other tasks will be less affected =
by=20
priority inversion occurring between X and blender (ie X will still suffer=
=20
but the machine wont come to a standstill). Broken apps will improve at lea=
st=20
partially with this, but they should be fixed for good performance.

Changes:
A task that uses up it's full timeslice will not be allowed to be the very=
=20
next task scheduled unless no other tasks on that runqueue are active. This=
=20
allows the next highest priority task to be scheduled or even an array swit=
ch=20
followed by the next task.

Dropped the on runqueue bonus to high credit tasks on requeuing for timesli=
ce=20
granularity for the above to work well.

Patch O16.3-O17int and a full patch against 2.6.0-test3 is available at
http://kernel.kolivas.org/2.5

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/QjvMZUg7+tp6mRURAuLpAJ4wZaZ1qa5n4otk/wE+muarpqilJgCff3Bi
I8J81js9UZL3XoPqR0FnjEE=3D
=3D1KDG
=2D----END PGP SIGNATURE-----

--Boundary-00=_IvjQ/1ySkRlT3F/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O16.3-O17int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O16.3-O17int"

--- linux-2.6.0-test3-mm3-O16.3/kernel/sched.c	2003-08-19 23:17:29.000000000 +1000
+++ linux-2.6.0-test3-mm3/kernel/sched.c	2003-08-20 00:04:00.000000000 +1000
@@ -360,6 +360,16 @@ static int effective_prio(task_t *p)
 }
 
 /*
+ * Activation classes used in p->activated as flags
+ */
+#define STARVED_WAKER	-3	// on runqueue by potential starvation
+#define USED_SLICE	-2	// used up a full timeslice
+#define UNINT_WAKE	-1	// woke from an uninterruptible sleep
+#define AWAKE		0	// other
+#define PART_RQ		1	// on run queue receives partial sleep credit
+#define FULL_RQ		2	// on run queue receives full sleep credit
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
@@ -410,7 +420,7 @@ static void recalc_task_prio(task_t *p, 
 			 * sleep are limited in their sleep_avg rise as they
 			 * are likely to be waiting on I/O
 			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
+			if (p->activated == UNINT_WAKE && !HIGH_CREDIT(p) && p->mm){
 				if (p->sleep_avg >=
 					JIFFIES_TO_NS(JUST_INTERACTIVE_SLEEP(p)))
 						sleep_time = 0;
@@ -458,7 +468,7 @@ static inline void activate_task(task_t 
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
-	if (!p->activated){
+	if (p->activated == AWAKE){
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -467,13 +477,13 @@ static inline void activate_task(task_t 
 		 * on a CPU, first time around:
 		 */
 		if (in_interrupt())
-			p->activated = 2;
+			p->activated = FULL_RQ;
 		else
 		/*
 		 * Normal first-time wakeups get a credit too for on-runqueue
 		 * time, but it will be weighted down:
 		 */
-			p->activated = 1;
+			p->activated = PART_RQ;
 		}
 	p->timestamp = now;
 
@@ -603,7 +613,7 @@ repeat_lock_task:
 				 * Tasks on involuntary sleep don't earn
 				 * sleep_avg beyond just interactive state.
 				 */
-				p->activated = -1;
+				p->activated = UNINT_WAKE;
 			}
 			if (sync)
 				__activate_task(p, rq);
@@ -1398,8 +1408,10 @@ void scheduler_tick(int user_ticks, int 
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			enqueue_task(p, rq->expired);
-		} else
+		} else {
 			enqueue_task(p, rq->active);
+			p->activated = USED_SLICE;
+		}
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -1415,21 +1427,18 @@ void scheduler_tick(int user_ticks, int 
 		 * equal priority.
 		 *
 		 * This only applies to user tasks in the interactive
-		 * delta range with at least MIN_TIMESLICE left.
+		 * delta range or a starved waker with at least MIN_TIMESLICE
+		 * left.
 		 */
-		if (p->mm && TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY) &&
+		if (p->mm && (TASK_INTERACTIVE(p) ||
+			p->activated == STARVED_WAKER) &&
+			!((task_timeslice(p) - p->time_slice) %
+			TIMESLICE_GRANULARITY) &&
 			(p->time_slice > MIN_TIMESLICE) &&
 			(p->array == rq->active)) {
 
 			dequeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			/*
-			 * Tasks with interactive credit get all their
-			 * time waiting on the run queue credited as sleep
-			 */
-			if (HIGH_CREDIT(p))
-				p->activated = 2;
 			p->prio = effective_prio(p);
 			enqueue_task(p, rq->active);
 		}
@@ -1534,18 +1543,46 @@ pick_next_task:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
+	/*
+	 * This prevents tasks that have used up a full timeslice from
+	 * being rescheduled immediately, thus avoiding starvation
+	 * and allowing lower priority tasks to run for at least
+	 * TIMESLICE_GRANULARITY or even allowing an array switch
+	 */
+	if (unlikely(next == prev && prev->activated == USED_SLICE &&
+		prev->mm && rq->nr_running > 1)){
+			dequeue_task(prev, array);
+			if (unlikely(!array->nr_active)) {
+				rq->active = rq->expired;
+				rq->expired = array;
+				array = rq->active;
+				rq->expired_timestamp = 0;
+			}
+			idx = sched_find_first_bit(array->bitmap);
+			queue = array->queue + idx;
+			next = list_entry(queue->next, task_t, run_list);
+			enqueue_task(prev, array);
+			prev->activated = AWAKE;
 
-		if (next->activated == 1)
-			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
+			if (!TASK_INTERACTIVE(next))
+				next->activated = STARVED_WAKER;
+			else
+				next->activated = AWAKE;
+	} else {
+		if (next->activated > 0) {
+			unsigned long long delta = now - next->timestamp;
 
-		array = next->array;
-		dequeue_task(next, array);
-		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+			if (next->activated == PART_RQ)
+				delta = delta * (ON_RUNQUEUE_WEIGHT * 128 /
+				100) / 128;
+
+			array = next->array;
+			dequeue_task(next, array);
+			recalc_task_prio(next, next->timestamp + delta);
+			enqueue_task(next, array);
+		}
+		next->activated = AWAKE;
 	}
-	next->activated = 0;
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);

--Boundary-00=_IvjQ/1ySkRlT3F/--

