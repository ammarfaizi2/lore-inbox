Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbTFSRdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbTFSRdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:33:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24311 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265862AbTFSRbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:31:40 -0400
Subject: [patch] setscheduler fix
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
In-Reply-To: <20030619171950.GA936@rudolph.ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
	 <3EF1DE35.20402@mvista.com>  <20030619171950.GA936@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1056044732.8770.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 19 Jun 2003 10:45:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my patch. It is the same idea as Joe's. Is there a better fix?

Basically, the problem is that setscheduler() does not set need_resched
when needed. There are two basic cases where this is needed:

	- the task is running, but now it is no longer the highest
	  priority task on the rq
	- the task is not running, but now it is the highest
	  priority task on the rq

In either case, we need to set need_resched to invoke the scheduler.

Patch is against 2.5.72. Comments?

	Robert Love


setschedule() needs to force a reschedule in some situations.

 kernel/sched.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)


diff -urN linux-2.5.72/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-16 21:20:20.000000000 -0700
+++ linux/kernel/sched.c	2003-06-17 13:44:15.509894276 -0700
@@ -1691,6 +1691,7 @@
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
+	int oldprio;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
@@ -1757,12 +1758,24 @@
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
+		 * Reschedule if we are currently running on this runqueue and
+		 * our priority decreased, or if we are not currently running on
+		 * this runqueue and our priority is higher than the current's
+		 */
+		if (rq->curr == p) {
+			if (p->prio > oldprio)
+				resched_task(rq->curr);
+		} else if (p->prio < rq->curr->prio)
+			resched_task(rq->curr);
+	}
 
 out_unlock:
 	task_rq_unlock(rq, &flags);


