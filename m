Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTEUWa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTEUWa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:30:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16291 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262285AbTEUWaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:30:46 -0400
Message-Id: <200305212243.h4LMhYB09217@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] signal-latency-2.5.69-A1 
In-reply-to: Your message of "Mon, 19 May 2003 10:14:13 +0200."
             <Pine.LNX.4.44.0305190952240.3530-100000@localhost.localdomain> 
Date: Wed, 21 May 2003 15:43:34 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    the attached patch, against BK-curr, fixes an SMP window where the
    kernel could miss to handle a signal, and increase signal delivery
    latency up to 200 msecs.

This has shown some good results on our testing but it yielded a hang
under some circumstances. I think I've located the problem.

When you decide to call resched_task(), you're holding a runqueue lock.
I think this gets us into the same mess the mm stuff did a couple of
months ago with IPIs.

    proc A				proc B

    grabs rq lock			tries to grab rq lock
    rescheds a task on that rq		spins with interrupts disabled
    sends IPI to all processors		<hangs>
    <hangs>
    releases lock

Holding the lock does two things: it allows us to set p's state to
RUNNING, and insures our task_running() check is valid for more than
an instant.  In the case of the call to resched_task(), the small window
between unlocking the runqueue and calling resched_task() should be ok.
If p is no longer running, there's no real harm done that I can see.

Here's a patch which releases the runqueue lock before calling
resched_task().  It's possible it can be prettied up a bit (lots of
unlocks for each if branch now, it seems), but it compiles and gets the
job done.  I've tested this to make sure it doesn't break, but have
been unable to test it (so far) on the machine which exhibits the hang.

Rick

diff -rup linux-2.5.69/include/linux/sched.h linux-2.5.69-sl/include/linux/sched.h
--- linux-2.5.69/include/linux/sched.h	Sun May  4 16:53:02 2003
+++ linux-2.5.69-sl/include/linux/sched.h	Tue May 20 17:29:48 2003
@@ -525,6 +525,7 @@ extern void do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
 
@@ -638,7 +639,6 @@ extern void wait_task_inactive(task_t * 
 #else
 #define wait_task_inactive(p)	do { } while (0)
 #endif
-extern void kick_if_running(task_t * p);
 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
diff -rup linux-2.5.69/kernel/sched.c linux-2.5.69-sl/kernel/sched.c
--- linux-2.5.69/kernel/sched.c	Sun May  4 16:53:37 2003
+++ linux-2.5.69-sl/kernel/sched.c	Tue May 20 17:35:44 2003
@@ -454,27 +454,12 @@ repeat:
 }
 #endif
 
-/*
- * kick_if_running - kick the remote CPU if the task is running currently.
- *
- * This code is used by the signal code to signal tasks
- * which are in user-mode, as quickly as possible.
- *
- * (Note that we do this lockless - if the task does anything
- * while the message is in flight then it will notice the
- * sigpending condition anyway.)
- */
-void kick_if_running(task_t * p)
-{
-	if ((task_running(task_rq(p), p)) && (task_cpu(p) != smp_processor_id()))
-		resched_task(p);
-}
-
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
  * @state: the mask of task states that can be woken
  * @sync: do a synchronous wakeup?
+ * @kick: kick the CPU if the task is already running?
  *
  * Put it on the run-queue if it's not already there. The "current"
  * thread is always on the run-queue (except when the actual
@@ -484,7 +469,7 @@ void kick_if_running(task_t * p)
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync)
+static int try_to_wake_up(task_t * p, unsigned int state, int sync, int kick)
 {
 	int success = 0, requeue_waker = 0;
 	unsigned long flags;
@@ -518,10 +503,20 @@ repeat_lock_task:
 					resched_task(rq->curr);
 			}
 			success = 1;
+			p->state = TASK_RUNNING;
+			task_rq_unlock(rq, &flags);
+		} else {
+			if (unlikely(kick) && task_running(rq, p)) {
+				task_rq_unlock(rq, &flags);
+				resched_task(rq->curr);
+			} else {
+				p->state = TASK_RUNNING;
+				task_rq_unlock(rq, &flags);
+			}
 		}
-		p->state = TASK_RUNNING;
-	}
-	task_rq_unlock(rq, &flags);
+	} else
+		task_rq_unlock(rq, &flags);
+	
 
 	/*
 	 * We have to do this outside the other spinlock, the two
@@ -543,12 +538,17 @@ repeat_lock_task:
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
+	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 0);
+}
+
+int wake_up_process_kick(task_t * p)
+{
+	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 1);
 }
 
 int wake_up_state(task_t *p, unsigned int state)
 {
-	return try_to_wake_up(p, state, 0);
+	return try_to_wake_up(p, state, 0, 0);
 }
 
 /*
@@ -1389,7 +1389,7 @@ need_resched:
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
 	task_t *p = curr->task;
-	return try_to_wake_up(p, mode, sync);
+	return try_to_wake_up(p, mode, sync, 0);
 }
 
 /*
diff -rup linux-2.5.69/kernel/signal.c linux-2.5.69-sl/kernel/signal.c
--- linux-2.5.69/kernel/signal.c	Sat Apr 19 19:49:11 2003
+++ linux-2.5.69-sl/kernel/signal.c	Tue May 20 17:29:48 2003
@@ -521,18 +521,6 @@ inline void signal_wake_up(struct task_s
 	set_tsk_thread_flag(t,TIF_SIGPENDING);
 
 	/*
-	 * If the task is running on a different CPU
-	 * force a reschedule on the other CPU to make
-	 * it notice the new signal quickly.
-	 *
-	 * The code below is a tad loose and might occasionally
-	 * kick the wrong CPU if we catch the process in the
-	 * process of changing - but no harm is done by that
-	 * other than doing an extra (lightweight) IPI interrupt.
-	 */
-	if (t->state == TASK_RUNNING)
-		kick_if_running(t);
-	/*
 	 * If resume is set, we want to wake it up in the TASK_STOPPED case.
 	 * We don't check for TASK_STOPPED because there is a race with it
 	 * executing another processor and just now entering stopped state.
@@ -543,7 +531,7 @@ inline void signal_wake_up(struct task_s
 	if (resume)
 		mask |= TASK_STOPPED;
 	if (t->state & mask) {
-		wake_up_process(t);
+		wake_up_process_kick(t);
 		return;
 	}
 }
