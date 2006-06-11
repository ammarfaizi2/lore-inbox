Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWFKF7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWFKF7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWFKF7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:59:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26312 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161085AbWFKF7S (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Sun, 11 Jun 2006 01:59:18 -0400
Date: Sun, 11 Jun 2006 07:58:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060611055828.GA9452@elte.hu>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu> <200606102249.26063.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606102249.26063.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5006]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> Thanks for the updated patch!  It wouldn't quite build (proc_misc.c 
> still referenced the old rt_overload_* variables, fixup patch attached 
> removing those print statements). [...]

doh, forgot to send those changes ...

> [...]  I have it running on a 4 way opteron box running prio-preempt 
> in a timed while loop, exiting only on failure.  It's been running 
> fine for several minutes - usually fails in under a mintue.  We'll see 
> how it's doing in the morning :-)

meanwhile i've released -rt3 with the fix (and the procfs change) 
included.

i slept on it meanwhile, and i think the safest would be to also do the 
attached patch ontop of -rt3. This makes the 'kick other CPUs' logic 
totally unconditional - so whatever happens the wakeup code will notice 
if an RT task is in trouble finding the right CPU. Under -rt3 we'd only 
run into this branch if we stayed on the same CPU - but there can be 
cases when we have your scenario even in precisely such a case. It's 
rare but possible.

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
