Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUEZLuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUEZLuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUEZLuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:50:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55981 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265506AbUEZLuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:50:12 -0400
Date: Wed, 26 May 2004 17:21:36 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, Ashok Raj <ashok.raj@intel.com>,
       nickpiggin@yahoo.com.au, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [CPU Hotplug PATCH] Restore Idle task's priority during CPU_DEAD notification
Message-ID: <20040526115136.GB20010@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <A28EFEDC5416054BA1026D892753E9AF059A50EC@orsmsx404.amr.corp.intel.com> <1085537205.2639.61.camel@bach> <20040526061613.GA18314@in.ibm.com> <20040526112726.GA8499@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526112726.GA8499@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 01:27:26PM +0200, Ingo Molnar wrote:
> Looks good. A small nit: while your patch creates a perfectly correct
> idle thread too, i'd prefer the modified variant below. The
> __setscheduler() call is (technically) incorrect because in the
> SCHED_NORMAL case the prio should be zero. So it's a bit cleaner to set
> up the static priority to MAX_PRIO and then revert the policy to
> SCHED_NORMAL via __setscheduler(). Ok?

Fine. Since we will have to setup the static priority everytime CPU_DEAD is
invoked, would it make sense if we setup this static priority (once and for
all) in init_idle instead?

Untested patch below:


---

 linux-2.6.7-rc1-vatsa/kernel/sched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~restore_idle_prio kernel/sched.c
--- linux-2.6.7-rc1/kernel/sched.c~restore_idle_prio	2004-05-25 17:04:19.000000000 +0530
+++ linux-2.6.7-rc1-vatsa/kernel/sched.c	2004-05-26 17:17:44.000000000 +0530
@@ -3246,7 +3246,7 @@ void __devinit init_idle(task_t *idle, i
 	idle_rq->curr = idle_rq->idle = idle;
 	deactivate_task(idle, rq);
 	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->prio = idle->static_prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
 	double_rq_unlock(idle_rq, rq);
@@ -3568,7 +3568,7 @@ static int migration_call(struct notifie
 		/* Idle task back to normal (off runqueue, low prio) */
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
-		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		task_rq_unlock(rq, &flags);
  		BUG_ON(rq->nr_running != 0);
 

_



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
