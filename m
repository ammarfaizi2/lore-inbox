Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319363AbSIKWS6>; Wed, 11 Sep 2002 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSIKWS5>; Wed, 11 Sep 2002 18:18:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28170
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319363AbSIKWRp>; Wed, 11 Sep 2002 18:17:45 -0400
Subject: [PATCH] 2.4-ac: misc. scheduler bits
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-3k15TGzUOl4bB+eeHSjm"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 18:22:32 -0400
Message-Id: <1031782952.937.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3k15TGzUOl4bB+eeHSjm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Last one for today: misc. and trivial scheduler updates.  Specifically:

	- s/TASK_TIMESLICE/BASE_TIMESLICE and use inline wrapper
	  function task_timeslice() to access.
	- make rq->nr_uninterruptible unsigned, not signed.
	- move around definitions of idle_cpu, double_rq_lock, and
	  double_rq_unlock to match 2.5 (make future patching easier).
	- misc. cleanup

Patch is against 2.4.20-pre5-ac4, please apply.

	Robert Love



--=-3k15TGzUOl4bB+eeHSjm
Content-Disposition: attachment; filename=230-sched-misc.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=230-sched-misc.patch; charset=ISO-8859-1

diff -urN linux-2.4.20-pre5-ac4-rml/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre5-ac4-rml/kernel/sched.c	Wed Sep 11 17:44:00 2002
+++ linux/kernel/sched.c	Wed Sep 11 17:43:47 2002
@@ -101,16 +101,23 @@
 	((p)->prio <=3D (p)->static_prio - DELTA(p))
=20
 /*
- * TASK_TIMESLICE scales user-nice values [ -20 ... 19 ]
+ * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
  *
- * The higher a process's priority, the bigger timeslices
+ * The higher a thread's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
- * priority process gets MIN_TIMESLICE worth of execution time.
+ * priority thread gets MIN_TIMESLICE worth of execution time.
+ *
+ * task_timeslice() is the interface that is used by the scheduler.
  */
+#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * \
+	 (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
=20
-#define TASK_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/39))
+static inline unsigned int task_timeslice(task_t *p)
+{
+	return BASE_TIMESLICE(p);
+}
=20
 /*
  * These are the runqueue data structures:
@@ -135,8 +142,8 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp;
-	signed long nr_uninterruptible;
+	unsigned long nr_running, nr_switches, expired_timestamp,
+			nr_uninterruptible;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
@@ -204,8 +211,7 @@
=20
 static inline void rq_unlock(runqueue_t *rq)
 {
-	spin_unlock(&rq->lock);
-	local_irq_enable();
+	spin_unlock_irq(&rq->lock);
 }
=20
 /*
@@ -545,13 +551,38 @@
 	return sum;
 }
=20
-/**
- * idle_cpu - is a given cpu idle currently?
- * @cpu: the processor in question.
+/*
+ * double_rq_lock - safely lock two runqueues
+ *
+ * Note this does not disable interrupts like task_rq_lock,
+ * you need to do so manually before calling.
  */
-inline int idle_cpu(int cpu)
+static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
-	return cpu_curr(cpu) =3D=3D cpu_rq(cpu)->idle;
+	if (rq1 =3D=3D rq2)
+		spin_lock(&rq1->lock);
+	else {
+		if (rq1 < rq2) {
+			spin_lock(&rq1->lock);
+			spin_lock(&rq2->lock);
+		} else {
+			spin_lock(&rq2->lock);
+			spin_lock(&rq1->lock);
+		}
+	}
+}
+
+/*
+ * double_rq_unlock - safely unlock two runqueues
+ *
+ * Note this does not restore interrupts like task_rq_unlock,
+ * you need to do so manually after calling.
+ */
+static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
+{
+	spin_unlock(&rq1->lock);
+	if (rq1 !=3D rq2)
+		spin_unlock(&rq2->lock);
 }
=20
 #if CONFIG_SMP
@@ -815,7 +846,7 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy =3D=3D SCHED_RR) && !--p->time_slice) {
-			p->time_slice =3D TASK_TIMESLICE(p);
+			p->time_slice =3D task_timeslice(p);
 			set_tsk_need_resched(p);
=20
 			/* put it at the end of the queue: */
@@ -838,7 +869,7 @@
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio =3D effective_prio(p);
-		p->time_slice =3D TASK_TIMESLICE(p);
+		p->time_slice =3D task_timeslice(p);
=20
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
@@ -1051,7 +1082,7 @@
 	wait_queue_t wait;			\
 	init_waitqueue_entry(&wait, current);
=20
-#define	SLEEP_ON_HEAD					\
+#define SLEEP_ON_HEAD					\
 	spin_lock_irqsave(&q->lock,flags);		\
 	__add_wait_queue(q, &wait);			\
 	spin_unlock(&q->lock);
@@ -1207,6 +1238,15 @@
 }
=20
 /**
+ * idle_cpu - is a given cpu idle currently?
+ * @cpu: the processor in question.
+ */
+inline int idle_cpu(int cpu)
+{
+	return cpu_curr(cpu) =3D=3D cpu_rq(cpu)->idle;
+}
+
+/**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
  */
@@ -1581,7 +1621,7 @@
 	p =3D find_process_by_pid(pid);
 	if (p)
 		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : TASK_TIMESLICE(p), &t);
+					 0 : task_timeslice(p), &t);
 	read_unlock(&tasklist_lock);
 	if (p)
 		retval =3D copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
@@ -1682,40 +1722,6 @@
 	read_unlock(&tasklist_lock);
 }
=20
-/*
- * double_rq_lock - safely lock two runqueues
- *
- * Note this does not disable interrupts like task_rq_lock,
- * you need to do so manually before calling.
- */
-static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
-{
-	if (rq1 =3D=3D rq2)
-		spin_lock(&rq1->lock);
-	else {
-		if (rq1 < rq2) {
-			spin_lock(&rq1->lock);
-			spin_lock(&rq2->lock);
-		} else {
-			spin_lock(&rq2->lock);
-			spin_lock(&rq1->lock);
-		}
-	}
-}
-
-/*
- * double_rq_unlock - safely unlock two runqueues
- *
- * Note this does not restore interrupts like task_rq_unlock,
- * you need to do so manually after calling.
- */
-static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
-{
-	spin_unlock(&rq1->lock);
-	if (rq1 !=3D rq2)
-		spin_unlock(&rq2->lock);
-}
-
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq =3D cpu_rq(cpu), *rq =3D cpu_rq(task_cpu(idle));

--=-3k15TGzUOl4bB+eeHSjm--

