Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSG1VF0>; Sun, 28 Jul 2002 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSG1VF0>; Sun, 28 Jul 2002 17:05:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9742 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317422AbSG1VFY>;
	Sun, 28 Jul 2002 17:05:24 -0400
Message-ID: <3D445F53.BDE6B754@zip.com.au>
Date: Sun, 28 Jul 2002 14:17:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: inlines in kernel/sched.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, could you please review the use of inlines in the
scheduler sometime?  They seem to be excessive.

For example, this patch reduces the sched.d icache footprint
by 1.5 kilobytes.

--- linux-2.5.29/kernel/sched.c	Fri Jul 26 20:48:46 2002
+++ 25/kernel/sched.c	Sun Jul 28 14:11:29 2002
@@ -117,7 +117,7 @@
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
 	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
 
-static inline unsigned int task_timeslice(task_t *p)
+static unsigned int task_timeslice(task_t *p)
 {
 	return BASE_TIMESLICE(p);
 }
@@ -201,7 +201,7 @@ static inline void task_rq_unlock(runque
 /*
  * rq_lock - lock a given runqueue and disable interrupts.
  */
-static inline runqueue_t *this_rq_lock(void)
+static runqueue_t *this_rq_lock(void)
 {
 	runqueue_t *rq;
 
@@ -212,7 +212,7 @@ static inline runqueue_t *this_rq_lock(v
 	return rq;
 }
 
-static inline void rq_unlock(runqueue_t *rq)
+static void rq_unlock(runqueue_t *rq)
 {
 	spin_unlock(&rq->lock);
 	local_irq_enable();
@@ -221,7 +221,7 @@ static inline void rq_unlock(runqueue_t 
 /*
  * Adding/removing a task to/from a priority array:
  */
-static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
 	array->nr_active--;
 	list_del(&p->run_list);
@@ -229,7 +229,7 @@ static inline void dequeue_task(struct t
 		__clear_bit(p->prio, array->bitmap);
 }
 
-static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
+static void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
@@ -237,7 +237,7 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
-static inline int effective_prio(task_t *p)
+static int effective_prio(task_t *p)
 {
 	int bonus, prio;
 
@@ -263,7 +263,7 @@ static inline int effective_prio(task_t 
 	return prio;
 }
 
-static inline void activate_task(task_t *p, runqueue_t *rq)
+static void activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long sleep_time = jiffies - p->sleep_timestamp;
 	prio_array_t *array = rq->active;
@@ -285,7 +285,7 @@ static inline void activate_task(task_t 
 	rq->nr_running++;
 }
 
-static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
+static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
@@ -294,7 +294,7 @@ static inline void deactivate_task(struc
 	p->array = NULL;
 }
 
-static inline void resched_task(task_t *p)
+static void resched_task(task_t *p)
 {
 #ifdef CONFIG_SMP
 	int need_resched, nrpolling;
@@ -529,7 +529,7 @@ unsigned long nr_context_switches(void)
  * Note this does not disable interrupts like task_rq_lock,
  * you need to do so manually before calling.
  */
-static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
+static void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	if (rq1 == rq2)
 		spin_lock(&rq1->lock);
