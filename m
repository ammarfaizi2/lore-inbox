Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWFKHgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWFKHgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 03:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWFKHgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 03:36:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9137 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751571AbWFKHgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 03:36:51 -0400
Date: Sun, 11 Jun 2006 09:36:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060611073609.GA12456@elte.hu>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu> <200606102249.26063.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606102324.58932.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,BAYES_60 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_60               BODY: Bayesian spam probability is 60 to 80%
	[score: 0.7110]
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> > Thanks for the updated patch!  It wouldn't quite build (proc_misc.c still
> > referenced the old rt_overload_* variables, fixup patch attached removing
> > those print statements).  I have it running on a 4 way opteron box running
> > prio-preempt in a timed while loop, exiting only on failure.  It's been
> > running fine for several minutes - usually fails in under a mintue.  We'll
> > see how it's doing in the morning :-)
> 
> Well it failed in about 14 minutes.  The machine was under heavy load 
> running another benchmark.  I have removed the secondary benchmark and 
> am running prio-preempt alone on the same 4 way opteron box.  Will 
> post again when I know more...

ok - could you try the patch from today (re-attached below)? Maybe that 
theoretical scenario i mentioned is only theoretical in theory ;-)

	Ingo

Index: linux-rt.q/kernel/sched.c
===================================================================
--- linux-rt.q.orig/kernel/sched.c
+++ linux-rt.q/kernel/sched.c
@@ -1588,38 +1588,37 @@ out_set_cpu:
 
 		this_cpu = smp_processor_id();
 		cpu = task_cpu(p);
-	} else {
+	}
+	/*
+	 * If a newly woken up RT task cannot preempt the
+	 * current (RT) task (on a target runqueue) then try
+	 * to find another CPU it can preempt:
+	 */
+	if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
+		this_rq = cpu_rq(this_cpu);
 		/*
-		 * If a newly woken up RT task cannot preempt the
-		 * current (RT) task (on a target runqueue) then try
-		 * to find another CPU it can preempt:
+		 * Special-case: the task on this CPU can be
+		 * preempted. In that case there's no need to
+		 * trigger reschedules on other CPUs, we can
+		 * mark the current task for reschedule.
+		 *
+		 * (Note that it's safe to access this_rq without
+		 * extra locking in this particular case, because
+		 * we are on the current CPU.)
 		 */
-		if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
-			this_rq = cpu_rq(this_cpu);
+		if (TASK_PREEMPTS_CURR(p, this_rq))
+			set_tsk_need_resched(this_rq->curr);
+		else
 			/*
-			 * Special-case: the task on this CPU can be
-			 * preempted. In that case there's no need to
-			 * trigger reschedules on other CPUs, we can
-			 * mark the current task for reschedule.
-			 *
-			 * (Note that it's safe to access this_rq without
-			 * extra locking in this particular case, because
-			 * we are on the current CPU.)
+			 * Neither the intended target runqueue
+			 * nor the current CPU can take this task.
+			 * Trigger a reschedule on all other CPUs
+			 * nevertheless, maybe one of them can take
+			 * this task:
 			 */
-			if (TASK_PREEMPTS_CURR(p, this_rq))
-				set_tsk_need_resched(this_rq->curr);
-			else
-				/*
-				 * Neither the intended target runqueue
-				 * nor the current CPU can take this task.
-				 * Trigger a reschedule on all other CPUs
-				 * nevertheless, maybe one of them can take
-				 * this task:
-				 */
-				smp_send_reschedule_allbutself();
+			smp_send_reschedule_allbutself();
 
-			schedstat_inc(this_rq, rto_wakeup);
-		}
+		schedstat_inc(this_rq, rto_wakeup);
 	}
 
 out_activate:
