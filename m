Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317839AbSFMVhe>; Thu, 13 Jun 2002 17:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317840AbSFMVhd>; Thu, 13 Jun 2002 17:37:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1420 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317839AbSFMVhc>;
	Thu, 13 Jun 2002 17:37:32 -0400
Date: Thu, 13 Jun 2002 23:35:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
In-Reply-To: <3D090B4D.4060104@avaya.com>
Message-ID: <Pine.LNX.4.44.0206132318010.14637-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002, Bhavesh P. Davda wrote:

> > in terms of 2.4.18, the timer and the setscheduler() change is OK, but i
> > dont think we want the add_to_runqueue() change. It changes wakeup
> > characteristics for non-RT tasks, it could affect any many-threads or
> > many-processes application adversely. And we've been doing FIFO wakeups
> 
> I would think that the logical place to add any process to the runqueue
> would be the back of the runqueue. If all processes are ALWAYS added to
> the back of the runqueue, then every process is GUARANTEED to eventually
> be scheduled. No process will be starved indefinitely.

in the case of the Linux scheduler non-RT processes wont be starved
indefinitely, because timeslices will expire after some time so even
'backlogged' processes will get a chance to run. The LIFO wakeup method
can be argued to improve performance as well: if N equal priority
processes are to be considered then the one with the most recent activity
(the most cache-hot) process should be run. Fairness is enforced via the
timeslice distribution scheme.

for the case of SCHED_FIFO processes there is no timeslice-driven
fairness. For them it's clearly better to do FIFO wakeups.

> The application that I am dealing with is a communications application
> with 86 SCHED_FIFO processes, crammed between priority levels 7-23, that
> depend on priority preemption using System V semaphores. The 2.2 kernel
> SCHED_FIFO behaviour was correct as far as a preempted SCHED_FIFO
> process being put in the back of the runqueue is concerned. But the 2.4
> kernel SCHED_FIFO behaviour was broken because of the add_to_runqueue()  
> bug. That lead to our application grossly misbehaving under the 2.4.18
> scheduler.

okay, you've certainly convinced me.

we can do this without affecting SCHED_OTHER behavior - it adds one more
branch to a hotpath, but correctness comes first. Patch against vanilla
2.4.18 attached, it does the FIFO wakeup if it's a RT task, otherwise the
wakeup is still LIFO. Clearly a FIFO wakeup is broken wrt. RT tasks.

(any recent merge of the O(1) scheduler to 2.4 should have this behavior
'automatically'.)

> As far as performance is concerned, putting the "if" test in
> update_process_times for SCHED_FIFO actually improved the performance of
> our application by 15%, as it would for any SCHED_FIFO centric
> application that relies on priority preemption where the average
> preemption time is > a timer tick.

(strange, calling schedule() every 10 msecs should not cost 1.5 msecs.)

	Ingo

--- linux/kernel/sched.c.orig	Thu Jun 13 20:14:31 2002
+++ linux/kernel/sched.c	Thu Jun 13 23:33:41 2002
@@ -324,7 +324,10 @@
  */
 static inline void add_to_runqueue(struct task_struct * p)
 {
-	list_add(&p->run_list, &runqueue_head);
+	if (p->policy == SCHED_OTHER)
+		list_add(&p->run_list, &runqueue_head);
+	else
+		list_add_tail(&p->run_list, &runqueue_head);
 	nr_running++;
 }
 
@@ -334,12 +337,6 @@
 	list_add_tail(&p->run_list, &runqueue_head);
 }
 
-static inline void move_first_runqueue(struct task_struct * p)
-{
-	list_del(&p->run_list);
-	list_add(&p->run_list, &runqueue_head);
-}
-
 /*
  * Wake up a process. Put it on the run-queue if it's not
  * already there.  The "current" process is always on the
@@ -955,9 +952,6 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (task_on_runqueue(p))
-		move_first_runqueue(p);
-
 	current->need_resched = 1;
 
 out_unlock:
--- linux/kernel/timer.c.orig	Thu Jun 13 20:17:04 2002
+++ linux/kernel/timer.c	Thu Jun 13 20:23:15 2002
@@ -585,7 +585,8 @@
 	if (p->pid) {
 		if (--p->counter <= 0) {
 			p->counter = 0;
-			p->need_resched = 1;
+			if (p->policy != SCHED_FIFO)
+				p->need_resched = 1;
 		}
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;

