Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSGBSvw>; Tue, 2 Jul 2002 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSGBSvw>; Tue, 2 Jul 2002 14:51:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:504 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316847AbSGBSvu>; Tue, 2 Jul 2002 14:51:50 -0400
Subject: [PATCH] 2.5: fair scheduler hints
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Jul 2002 11:54:18 -0700
Message-Id: <1025636058.991.1120.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version of scheduler hints (often called hint-based
scheduling) for 2.5.24.  Scheduler hints are a way for a program to give
a "hint" to the scheduler about its present behavior in the hopes of the
scheduler consequently making better scheduling decisions.  After all,
who knows better than the application what it is about to do?

In this version, I have only implement the Solaris-style "gimme
timeslice" hint.  However, I have also implemented a fairness mechanism,
although it is currently voluntary.

To enforce fairness even from malicious applications will require a
small bit of code in schedule (although Pavel can probably think of a
way to stick it in the slow-path in ptrace! 8).  Since this is more a
"does it actually show benefit" than a "we need more stuff in the
kernel" patch I am hesitant to add this code.

Fairness is provided simply by another hint which tells the scheduler
you are finished with your extra timeslice.  The scheduler will
calculate what your timeslice would of been had you not made the hint
and set your new timeslice to that.  If it is negative, you are put on
the expired list.  Thus the hint is more of a safety net to prevent
preemption while holding a critical resource than a method to achieve
arbitrarily long timeslices.  This is what Solaris does.

Typical use would be:

	sched_hint(HINT_START);
	/* acquire critical resource */
	...
	/* release critical resource */
	sched_hint(HINT_STOP);

Even with the fairness implement I am still seeing ~5% improvement with
a hand full of threads contending over a resource.  Interestingly, I can
measure an improvement even if only _one_ thread does the hint.  In
other words, it is fair.

	Robert Love

P.S. I broke out the code to expire a task and move it to the expired
array and put it in its own inline function.  This is a bit cleaner as
both sys_sched_hint and the scheduler_tick use this logic.

diff -urN linux-2.5.24/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.24/arch/i386/kernel/entry.S	Thu Jun 20 15:53:48 2002
+++ linux/arch/i386/kernel/entry.S	Tue Jul  2 10:24:52 2002
@@ -764,6 +764,7 @@
 	.long sys_futex		/* 240 */
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
+	.long sys_sched_hint
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urN linux-2.5.24/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.24/include/asm-i386/unistd.h	Thu Jun 20 15:53:54 2002
+++ linux/include/asm-i386/unistd.h	Tue Jul  2 10:24:52 2002
@@ -247,6 +247,7 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_sched_hint		243
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linux-2.5.24/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.24/include/linux/sched.h	Thu Jun 20 15:53:44 2002
+++ linux/include/linux/sched.h	Tue Jul  2 10:24:52 2002
@@ -115,6 +115,12 @@
 #endif
 
 /*
+ * Scheduling Hints
+ */
+#define HINT_START		1	/* increase remaining timeslice */
+#define HINT_STOP		2	/* restore timeslice */
+
+/*
  * Scheduling policies
  */
 #define SCHED_OTHER		0
@@ -274,6 +280,9 @@
 
 	unsigned int allocation_order, nr_local_pages;
 
+	unsigned long hint_timestamp;
+	unsigned int hint_timeslice;
+
 /* task state */
 	struct linux_binfmt *binfmt;
 	int exit_code, exit_signal;
diff -urN linux-2.5.24/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.24/kernel/sched.c	Thu Jun 20 15:53:47 2002
+++ linux/kernel/sched.c	Tue Jul  2 10:24:52 2002
@@ -716,6 +716,26 @@
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))
 
 /*
+ * expire_task - task's timeslice is up, decide what to do with it
+ *
+ * This is called with the task's runqueue locked and interrupts disabled.
+ */
+static void expire_task(task_t *p, runqueue_t *rq)
+{
+	dequeue_task(p, rq->active);
+	set_tsk_need_resched(p);
+	p->prio = effective_prio(p);
+	p->time_slice = TASK_TIMESLICE(p);
+
+	if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!rq->expired_timestamp)
+			rq->expired_timestamp = jiffies;
+		enqueue_task(p, rq->expired);
+	} else
+		enqueue_task(p, rq->active);
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
@@ -770,19 +790,9 @@
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
-	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
-		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = TASK_TIMESLICE(p);
+	if (!--p->time_slice)
+		expire_task(p, rq);
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
-	}
 out:
 #if CONFIG_SMP
 	if (!(jiffies % BUSY_REBALANCE_TICK))
@@ -1399,6 +1409,74 @@
 	return real_len;
 }
 
+/*
+ * sys_sched_hint - give the scheduler a hint to hopefully provide better
+ * scheduling behavior.
+ *
+ * For example, if a task is about to acquire a highly contended resource, it
+ * would be wise to increase its remaining timeslice to ensure it could drop
+ * the resource before being preempted in which case it would just block other
+ * tasks.
+ *
+ * We enforce fairness and thus require no permissions.
+ *
+ * `hint' is the hint to the scheduler, defined in include/linux/sched.h
+ */
+asmlinkage int sys_sched_hint(unsigned int hint)
+{
+	int ret = -EINVAL;
+	unsigned long flags, hint_time;
+	unsigned int hint_slice;
+	runqueue_t *rq;
+
+	rq = task_rq_lock(current, &flags);
+
+	switch (hint) {
+	case HINT_START:
+		current->hint_timestamp = jiffies;
+		current->hint_timeslice = current->time_slice;
+		current->time_slice = MAX_TIMESLICE;
+		/*
+		 * we may have run out of timeslice and have been put
+		 * on the expired runqueue - we no longer belong there.
+		 */
+		if (unlikely(current->array != rq->active)) {
+			dequeue_task(current, current->array);
+			enqueue_task(current, rq->active);
+		}
+		ret = 0;
+		break;
+	case HINT_STOP:
+		if (current->hint_timestamp) {
+			hint_time = jiffies - current->hint_timestamp;
+			hint_slice = current->hint_timeslice - hint_time;
+			current->hint_timestamp = 0;
+			if (unlikely(current->array != rq->active)) {
+				dequeue_task(current, current->array);
+				enqueue_task(current, rq->active);
+			}
+			/*
+			 * if the task has not even used up the timeslice it
+			 * would of had if it had not called sched_hint,
+			 * then just give it the timeslice back.
+			 *
+			 * if it used more, then act as if it is out of
+			 * timeslice.
+			 */
+			if (hint_slice > 0)
+				current->time_slice = hint_slice;
+			else
+				expire_task(current, rq);
+		}
+		ret = 0;
+		break;
+	}
+
+	task_rq_unlock(rq, &flags);
+
+	return ret;
+}
+
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();

