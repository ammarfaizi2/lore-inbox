Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbTFSRHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbTFSRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:07:13 -0400
Received: from users.ccur.com ([208.248.32.211]:45417 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265845AbTFSRHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:07:09 -0400
Date: Thu, 19 Jun 2003 13:19:51 -0400
From: "'joe.korty@ccur.com'" <joe.korty@ccur.com>
To: george anzinger <george@mvista.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>,
       Robert Love <rml@mvista.com>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta sks
Message-ID: <20030619171950.GA936@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com> <3EF1DE35.20402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF1DE35.20402@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hm!  I wonder.  Robert is working on a fix for schedsetschedule() 
> where it fails to actually tell the scheduler to switch to a process 
> that it just made higher priority or away from one it just lowered.
> 
> The net result is that the caller keeps running (FIFO for all in this 
> case) when, in fact it should have been switched out.  Next time 
> schedule() actually switches, it is all sorted out again.  Could the 
> elavation of the events/0 thread cause this needed switch?


I posted a fix for this a month ago that was ignored.  Which is a
good thing, since now that I look at it again, I don't care for the
approach I took nor does it appear to be complete.

Joe

----------- original posting

> Date: Wed, 21 May 2003 16:40:26 -0400
> From: Joe Korty <joe.korty@ccur.com>
> To: Ingo Molnar <mingo@elte.hu>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] setscheduler resched bug

setscheduler is not forcing a reschedule when needed like set_user_nice
does.  It should.

Joe


--- 2.5.69/kernel/sched.c.orig	2003-05-21 14:50:53.000000000 -0400
+++ 2.5.69/kernel/sched.c	2003-05-21 15:01:13.000000000 -0400
@@ -1716,6 +1716,7 @@
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
+	int oldprio;
 
 	if (!param || pid < 0)
 		goto out_nounlock;
@@ -1778,12 +1779,20 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
+	oldprio = p->prio;
 	if (policy != SCHED_NORMAL)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
-	if (array)
+	if (array) {
 		__activate_task(p, task_rq(p));
+		/*
+		 * Reschedule if on a CPU and the priority dropped, or not on
+		 * a CPU and the priority rose above the currently running task.
+		 */
+		if ((rq->curr == p) ? (p->prio > oldprio) : (p->prio < rq->curr->prio))
+			resched_task(rq->curr);
+	}
 
 out_unlock:
 	task_rq_unlock(rq, &flags);

