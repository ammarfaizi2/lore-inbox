Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSFMSjh>; Thu, 13 Jun 2002 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317792AbSFMSjg>; Thu, 13 Jun 2002 14:39:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56557 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317463AbSFMSje>;
	Thu, 13 Jun 2002 14:39:34 -0400
Date: Thu, 13 Jun 2002 20:36:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
In-Reply-To: <Pine.LNX.4.44.0206120942410.2422-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206132007010.8525-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jun 2002, Bhavesh P. Davda wrote:

> The 2.4.18 kernel was behaving incorrectly for SCHED_FIFO and SCHED_RR
> scheduling.
> 
> The correct behaviour for SCHED_FIFO is priority preemption: run to
> completion, or system call, or preemption by higher priority process.
> The correct behaviour for SCHED_RR is the same as SCHED_FIFO for the
> preemption case, or run for a time slice, and go to the back of the run
> queue for that priority.
> 
> More details can be found at:
> 
> http://www.opengroup.org/onlinepubs/7908799/xsh/realtime.html
> 
> As a side note, SCHED_RR is completely broken in the 2.2 series kernels.
> 
> This is a small patch, but fixes the behaviour for SCHED_FIFO and
> SCHED_RR scheduling in the 2.4.18 kernel. It also improves the
> efficiency of the kernel by NOT calling schedule() for every tick for a
> SCHED_FIFO process.

good catch, your observations are correct.

btw., have you checked the 2.5 kernel's scheduler? It does all these
things correctly: it queues freshly woken up tasks to the tail of the
queue, it does not reschedule SCHED_FIFO tasks every timer tick and does
not move RT tasks to the head of the queue in sys_setscheduler().

in terms of 2.4.18, the timer and the setscheduler() change is OK, but i
dont think we want the add_to_runqueue() change. It changes wakeup
characteristics for non-RT tasks, it could affect any many-threads or
many-processes application adversely. And we've been doing FIFO wakeups
like this for ages and nobody complained, so it's not that we are in a big
hurry. Fundamental changes like this are fair game for the 2.5 kernel.
[and we dont even know the full performance impact of this change even in
2.5, although it's been in since 2.5.3 or so. The full effect of things
like this will show up during beta-testing of 2.6 i suspect.] Plus this
change does not make *that* much of a difference - not many people use
SCHED_FIFO tasks with the same priority, the typical usage is to sort the
tasks by priority - this is one reason why there's a push to increase the
number of RT priority levels to something like 1000 in the 2.5 kernel.  
And if multiple SCHED_FIFO tasks have the same priority then exact
scheduling is more like the matter of luck anyway.

I've attached a minimal patch for 2.4.18 which does the other two things
only - the timer optimization has no semantical impact, and the
setscheduler() change only affects tasks that switch between RT and non-RT
scheduling modes.

	Ingo

--- linux/kernel/sched.c.orig	Thu Jun 13 20:14:31 2002
+++ linux/kernel/sched.c	Thu Jun 13 20:23:51 2002
@@ -334,12 +334,6 @@
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
@@ -955,9 +949,6 @@
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

