Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTESIBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTESIBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:01:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29084 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S262363AbTESIBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:01:42 -0400
Date: Mon, 19 May 2003 10:14:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: [patch] signal-latency-2.5.69-A1
Message-ID: <Pine.LNX.4.44.0305190952240.3530-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against BK-curr, fixes an SMP window where the kernel
could miss to handle a signal, and increase signal delivery latency up to
200 msecs. Sun has reported to Ulrich that their JVM sees occasional
unexpected signal delays under Linux. The more CPUs, the more delays.

the cause of the problem is that the current signal wakeup implementation
is racy in kernel/signal.c:signal_wake_up():

        if (t->state == TASK_RUNNING)
                kick_if_running(t);
	...
        if (t->state & mask) {
                wake_up_process(t);
                return;
        }

if thread (or process) 't' is woken up on another CPU right after the
TASK_RUNNING check, and thread starts to run, then the wake_up_process()  
here will do nothing, and the signal stays pending up until the thread
will call into the kernel next time - which can be up to 200 msecs later.

the solution is to do the 'kicking' of a running thread on a remote CPU
atomically with the wakeup. For this i've added wake_up_process_kick().
There is no slowdown for the other wakeup codepaths, the new flag to
try_to_wake_up() is compiled off for them. Some other subsystems might
want to use this wakeup facility as well in the future (eg. AIO).

in fact this race triggers quite often under Volanomark rusg, with this
change added, Volanomark performance is up from 500-800 to 2000-3000, on a
4-way x86 box.

please apply,

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -530,6 +530,7 @@ extern void do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
 
@@ -643,7 +644,6 @@ extern void wait_task_inactive(task_t * 
 #else
 #define wait_task_inactive(p)	do { } while (0)
 #endif
-extern void kick_if_running(task_t * p);
 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
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
@@ -518,7 +503,9 @@ repeat_lock_task:
 					resched_task(rq->curr);
 			}
 			success = 1;
-		}
+		} else
+			if (unlikely(kick) && task_running(rq, p))
+				resched_task(rq->curr);
 		p->state = TASK_RUNNING;
 	}
 	task_rq_unlock(rq, &flags);
@@ -543,12 +530,17 @@ repeat_lock_task:
 
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
@@ -1389,7 +1381,7 @@ need_resched:
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
 	task_t *p = curr->task;
-	return try_to_wake_up(p, mode, sync);
+	return try_to_wake_up(p, mode, sync, 0);
 }
 
 /*
--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
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

