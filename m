Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUKSENk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUKSENk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUKSENj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:13:39 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:56534 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261249AbUKSENh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:13:37 -0500
Subject: what is the need for task_rq in setscheduler?
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Thu, 18 Nov 2004 23:13:36 -0500
Message-Id: <1100837616.4051.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious to the need for the task_rq in setscheduler in the following
code:

   3316         rq = task_rq_lock(p, &flags);
   3317         /* recheck policy now with rq lock held */
   3318         if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
   3319                 policy = oldpolicy = -1;
   3320                 task_rq_unlock(rq, &flags);
   3321                 goto recheck;
   3322         }
   3323         array = p->array;
   3324         if (array)
   3325                 deactivate_task(p, task_rq(p));
   3326         retval = 0;
   3327         oldprio = p->prio;
   3328         __setscheduler(p, policy, lp.sched_priority);
   3329         if (array) {
   3330                 __activate_task(p, task_rq(p));
   3331                 /*
   3332                  * Reschedule if we are currently running on this runqueue and
   3333                  * our priority decreased, or if we are not currently running on
   3334                  * this runqueue and our priority is higher than the current's
   3335                  */
   3336                 if (task_running(rq, p)) {
   3337                         if (p->prio > oldprio)
   3338                                 resched_task(rq->curr);
   3339                 } else if (TASK_PREEMPTS_CURR(p, rq))
   3340                         resched_task(rq->curr);
   3341         }
   3342         task_rq_unlock(rq, &flags);


On lines 3325 and 3330 with the calls to deactivate_task and
__activate_task respectively. The runqueue is locked at 3316. Can the
runqueue returned by task_rq change in this setup? If not, what is the
need for the call to task_rq. Can't rq just be used instead, or is this
just some extra paranoia? 

Thanks,

-- Steve
