Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSFJX2R>; Mon, 10 Jun 2002 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFJX2Q>; Mon, 10 Jun 2002 19:28:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1530 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316533AbSFJX2O>; Mon, 10 Jun 2002 19:28:14 -0400
Subject: Re: Scheduler Bug (set_cpus_allowed)
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206110123230.4761-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 10 Jun 2002 16:28:06 -0700
Message-Id: <1023751686.21176.124.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-10 at 16:24, Ingo Molnar wrote:

> sure, agreed. I've added it to my tree.

What do you think of this?

No more explicit preempt disables...

	Robert Love

diff -urN linux-2.5.21/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.21/kernel/sched.c	Sat Jun  8 22:28:13 2002
+++ linux/kernel/sched.c	Sun Jun  9 13:01:32 2002
@@ -153,17 +153,22 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+/*
+ * task_rq_lock - lock the runqueue a given task resides on and disable
+ * interrupts.  Note the ordering: we can safely lookup the task_rq without
+ * explicitly disabling preemption.
+ */
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
 
 repeat_lock_task:
-	preempt_disable();
+	local_irq_save(*flags);
 	rq = task_rq(p);
-	spin_lock_irqsave(&rq->lock, *flags);
+	spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
-		spin_unlock_irqrestore(&rq->lock, *flags);
-		preempt_enable();
+		spin_unlock(&rq->lock);
+		local_irq_restore(*flags);
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -171,8 +176,25 @@
 
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
-	spin_unlock_irqrestore(&rq->lock, *flags);
-	preempt_enable();
+	spin_unlock(&rq->lock);
+	local_irq_restore(*flags);
+}
+
+/*
+ * rq_lock - lock a given runqueue and disable interrupts.
+ */
+static inline runqueue_t *rq_lock(runqueue_t *rq)
+{
+	local_irq_disable();
+	rq = this_rq();
+	spin_lock(&rq->lock);
+	return rq;
+}
+
+static inline void rq_unlock(runqueue_t *rq)
+{
+	spin_unlock(&rq->lock);
+	local_irq_enable();
 }
 
 /*
@@ -353,9 +375,7 @@
 {
 	runqueue_t *rq;
 
-	preempt_disable();
-	rq = this_rq();
-	spin_lock_irq(&rq->lock);
+	rq = rq_lock(rq);
 
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -371,8 +391,7 @@
 	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
-	spin_unlock_irq(&rq->lock);
-	preempt_enable();
+	rq_unlock(rq);
 }
 
 /*
@@ -1342,8 +1361,7 @@
 	runqueue_t *rq;
 	prio_array_t *array;
 
-	preempt_disable();
-	rq = this_rq();
+	rq = rq_lock(rq);
 
 	/*
 	 * Decrease the yielding task's priority by one, to avoid
@@ -1353,7 +1371,6 @@
 	 * If priority is already MAX_PRIO-1 then we still
 	 * roundrobin the task within the runlist.
 	 */
-	spin_lock_irq(&rq->lock);
 	array = current->array;
 	/*
 	 * If the task has reached maximum priority (or is a RT task)
@@ -1371,7 +1388,6 @@
 		__set_bit(current->prio, array->bitmap);
 	}
 	spin_unlock(&rq->lock);
-	preempt_enable_no_resched();
 
 	schedule();
 


