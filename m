Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTKGBof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 20:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTKGBoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 20:44:34 -0500
Received: from fmr05.intel.com ([134.134.136.6]:52644 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261305AbTKGBo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 20:44:26 -0500
Subject: Re: [PATCH] SMP signal latency fix up.
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: mgross@linux.co.intel.com
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1068169185.1831.9.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org>
	 <1068169185.1831.9.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-AJpLCTin0AW6yCjeiqrK"
Organization: TSP
Message-Id: <1068169363.1831.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Nov 2003 17:42:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AJpLCTin0AW6yCjeiqrK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-11-06 at 17:39, Mark Gross wrote:
> On Thu, 2003-11-06 at 15:20, Linus Torvalds wrote:
> > On 6 Nov 2003, Mark Gross wrote:
> > >
> > > Running on SMP and the 2.6.0-test9 kernel, it takes about 10000 * 1/HZ seconds.  Running this 
> > > command with maxcpus=1 the command finishes in fraction of a second.  Under SMP the 
> > > signal delivery isn't kicking the task if its in the run state on the other CPU.
> > 
> > It looks like the "wake_up_process_kick()" interface is just broken. As it 
> > stands now, it's literally _designed_ to kick the process only when it 
> > wakes it up, which is silly and wrong. It makes no sense to kick a process 
> > that we just woke up, because it _will_ react immediately anyway.
> > 
> > We literally want to kick only processes that didn't need waking up, and 
> > the current interface is totally unsuitable for that.
> > 
> > > The following patch has been tested and seems to fix the problem.  
> > > I'm confident about the change to sched.c actualy fixes a cut and paste bug.
> > 
> > Naah, it's a thinko, the code shouldn't be like that at all.
> > 
> > There's only one user of the "wake_up_process_kick()" thing, and that one 
> > user really wants to kick the process totally independently of waking it 
> > up. Which just implies that we should just have a _regular_ 
> > "wake_up_process()" there, and a _separate_ "kick_process()" thing.
> > 
> > So I've got a feeling that 
> >  - we should remove the "kick" argument from "try_to_wake_up()"
> >  - the signal wakeup case should instead do a _regular_ wakeup.
> >  - we should kick the process if the wakeup _fails_.
> > 
> > Ie signal wakeup should most likely look something like
> > 
> > 
> > 	inline void signal_wake_up(struct task_struct *t, int resume)
> > 	{
> > 		int woken;
> > 		unsigned int mask;
> > 
> > 		set_tsk_thread_flag(t,TIF_SIGPENDING);
> > 		mask = TASK_INTERRUPTIBLE;
> > 		if (resume)
> > 			mask |= TASK_STOPPED;
> > 		woken = 0;
> > 		if (t->state & mask)
> > 			woken = wake_up_state(p, mask);
> > 		if (!woken)
> > 			kick_process(p);
> > 	}
> > 
> > where the "kick_process()" thing does the "is the task running on some 
> > other CPU and if so send it a reschedule event to make it react" thing.
> > 
> > Ingo?
> > 
> > 		Linus
> 
> 
> Are you thinking about something like this?
> 
> It seems to work. I dropped the "task_running" test from
> smp_process_kick intentionaly.  As well as the movement of the success
> flag.  I hope its not too wrong.
> 
> It seems to work on a HT P4 desktop and a dual PIII box.
> 
> --mgross
Evolution messed up my patch.  Retry:

diff -urN -X dontdiff linux-2.6.0-test9/include/linux/sched.h /opt/linux-2.6.0-test9/include/linux/sched.h
--- linux-2.6.0-test9/include/linux/sched.h	2003-10-25 11:42:56.000000000 -0700
+++ /opt/linux-2.6.0-test9/include/linux/sched.h	2003-11-06 14:44:22.000000000 -0800
@@ -573,7 +573,7 @@
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
+extern void FASTCALL(smp_process_kick(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
 
diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
--- linux-2.6.0-test9/kernel/sched.c	2003-10-25 11:44:29.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/sched.c	2003-11-06 14:58:29.000000000 -0800
@@ -585,7 +585,7 @@
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync, int kick)
+static int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	unsigned long flags;
 	int success = 0;
@@ -624,13 +624,8 @@
 				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
-			success = 1;
 		}
-#ifdef CONFIG_SMP
-	       	else
-			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
-				smp_send_reschedule(task_cpu(p));
-#endif
+		success = 1;
 		p->state = TASK_RUNNING;
 	}
 	task_rq_unlock(rq, &flags);
@@ -640,19 +635,22 @@
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 0);
+	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 EXPORT_SYMBOL(wake_up_process);
 
-int wake_up_process_kick(task_t * p)
+void smp_process_kick(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 1);
+#ifdef CONFIG_SMP
+	if (task_cpu(p) != smp_processor_id())
+			smp_send_reschedule(task_cpu(p));
+#endif
 }
 
 int wake_up_state(task_t *p, unsigned int state)
 {
-	return try_to_wake_up(p, state, 0, 0);
+	return try_to_wake_up(p, state, 0);
 }
 
 /*
@@ -1624,7 +1622,7 @@
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
 	task_t *p = curr->task;
-	return try_to_wake_up(p, mode, sync, 0);
+	return try_to_wake_up(p, mode, sync);
 }
 
 EXPORT_SYMBOL(default_wake_function);
diff -urN -X dontdiff linux-2.6.0-test9/kernel/signal.c /opt/linux-2.6.0-test9/kernel/signal.c
--- linux-2.6.0-test9/kernel/signal.c	2003-10-25 11:43:27.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/signal.c	2003-11-06 15:05:41.945237624 -0800
@@ -538,6 +538,7 @@
 inline void signal_wake_up(struct task_struct *t, int resume)
 {
 	unsigned int mask;
+	int woken;
 
 	set_tsk_thread_flag(t,TIF_SIGPENDING);
 
@@ -551,10 +552,14 @@
 	mask = TASK_INTERRUPTIBLE;
 	if (resume)
 		mask |= TASK_STOPPED;
+	woken = 0;
 	if (t->state & mask) {
-		wake_up_process_kick(t);
-		return;
+		woken = wake_up_process(t);
 	}
+#ifdef CONFIG_SMP
+	if (!woken) 
+		smp_process_kick(t);
+#endif	
 }
 
 /*



--=-AJpLCTin0AW6yCjeiqrK
Content-Disposition: attachment; filename=signal_smp_fix.patch
Content-Type: text/x-patch; name=signal_smp_fix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.6.0-test9/include/linux/sched.h /opt/linux-2.6.0-test9/include/linux/sched.h
--- linux-2.6.0-test9/include/linux/sched.h	2003-10-25 11:42:56.000000000 -0700
+++ /opt/linux-2.6.0-test9/include/linux/sched.h	2003-11-06 14:44:22.000000000 -0800
@@ -573,7 +573,7 @@
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern int FASTCALL(wake_up_process_kick(struct task_struct * tsk));
+extern void FASTCALL(smp_process_kick(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
 
diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
--- linux-2.6.0-test9/kernel/sched.c	2003-10-25 11:44:29.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/sched.c	2003-11-06 14:58:29.000000000 -0800
@@ -585,7 +585,7 @@
  *
  * returns failure only if the task is already active.
  */
-static int try_to_wake_up(task_t * p, unsigned int state, int sync, int kick)
+static int try_to_wake_up(task_t * p, unsigned int state, int sync)
 {
 	unsigned long flags;
 	int success = 0;
@@ -624,13 +624,8 @@
 				if (TASK_PREEMPTS_CURR(p, rq))
 					resched_task(rq->curr);
 			}
-			success = 1;
 		}
-#ifdef CONFIG_SMP
-	       	else
-			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
-				smp_send_reschedule(task_cpu(p));
-#endif
+		success = 1;
 		p->state = TASK_RUNNING;
 	}
 	task_rq_unlock(rq, &flags);
@@ -640,19 +635,22 @@
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 0);
+	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 EXPORT_SYMBOL(wake_up_process);
 
-int wake_up_process_kick(task_t * p)
+void smp_process_kick(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 1);
+#ifdef CONFIG_SMP
+	if (task_cpu(p) != smp_processor_id())
+			smp_send_reschedule(task_cpu(p));
+#endif
 }
 
 int wake_up_state(task_t *p, unsigned int state)
 {
-	return try_to_wake_up(p, state, 0, 0);
+	return try_to_wake_up(p, state, 0);
 }
 
 /*
@@ -1624,7 +1622,7 @@
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
 {
 	task_t *p = curr->task;
-	return try_to_wake_up(p, mode, sync, 0);
+	return try_to_wake_up(p, mode, sync);
 }
 
 EXPORT_SYMBOL(default_wake_function);
diff -urN -X dontdiff linux-2.6.0-test9/kernel/signal.c /opt/linux-2.6.0-test9/kernel/signal.c
--- linux-2.6.0-test9/kernel/signal.c	2003-10-25 11:43:27.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/signal.c	2003-11-06 15:05:41.945237624 -0800
@@ -538,6 +538,7 @@
 inline void signal_wake_up(struct task_struct *t, int resume)
 {
 	unsigned int mask;
+	int woken;
 
 	set_tsk_thread_flag(t,TIF_SIGPENDING);
 
@@ -551,10 +552,14 @@
 	mask = TASK_INTERRUPTIBLE;
 	if (resume)
 		mask |= TASK_STOPPED;
+	woken = 0;
 	if (t->state & mask) {
-		wake_up_process_kick(t);
-		return;
+		woken = wake_up_process(t);
 	}
+#ifdef CONFIG_SMP
+	if (!woken) 
+		smp_process_kick(t);
+#endif	
 }
 
 /*

--=-AJpLCTin0AW6yCjeiqrK--

