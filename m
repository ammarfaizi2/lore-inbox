Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSFWJt3>; Sun, 23 Jun 2002 05:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSFWJt2>; Sun, 23 Jun 2002 05:49:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22985 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316970AbSFWJt1>;
	Sun, 23 Jun 2002 05:49:27 -0400
Date: Sun, 23 Jun 2002 11:47:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Bhavesh P. Davda" <bhavesh@avaya.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.2.21
In-Reply-To: <E17LUWf-0001YA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0206231144050.3489-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jun 2002, Alan Cox wrote:

> > What's going on with the kernel community? I posted a similar fix for 
> > the 2.4.18 kernel, and it hasn't been picked up there either.
> 
> I've not seen that one. However the -ac tree uses a different scheduler
> anyway. You should check if 2.4.19pre has the same problem and if so
> mail Marcelo directly a patch

the O(1) scheduler does not have this problem, so the -ac tree is ok.

for vanilla 2.4.18/2.4.19-pre i've created a compromise patch which
reduces the impact and fixes RT behavior (attached). There was no further
comment from Bhavesh, so i assumed it's all a done deal ... Marcelo,
please apply.

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


