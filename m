Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVEEOjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVEEOjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVEEOje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:39:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56993 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262110AbVEEOjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:39:08 -0400
Date: Thu, 5 May 2005 20:09:58 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, mingo@elte.hu
Cc: george@mvista.com, high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050505143958.GA20162@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050407124629.GA17268@in.ibm.com> <425530AB.90605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425530AB.90605@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:07:55PM +1000, Nick Piggin wrote:
> Srivatsa Vaddagiri wrote:
> 
> >I think a potential area which VST may need to address is 
> >scheduler load balance. If idle CPUs stop taking local timer ticks for 
> >some time, then during that period it could cause the various runqueues to 
> >go out of balance, since the idle CPUs will no longer pull tasks from 
> >non-idle CPUs. 
> >
> 
> Yep.
> 
> >Do we care about this imbalance? Especially considering that most 
> >implementations will let the idle CPUs sleep only for some max duration
> >(~900 ms in case of x86).
> >
> 
> I think we do care, yes. It could be pretty harmful to sleep for
> even a few 10s of ms on a regular basis for some workloads. Although
> I guess many of those will be covered by try_to_wake_up events...
> 
> Not sure in practice, I would imagine it will hurt some multiprocessor
> workloads.

I am looking at the recent changes in load balance and I see that load
balance on fork has been introduced (SD_BALANCE_FORK). I think this changes
the whole scenario.

Considering the fact that there was already balance on wake_up and the 
fact that the scheduler checks for imbalance before running the idle task
(load_balance_newidle), I don't know if sleeping idle CPUs can cause a 
load imbalance (fork/wakeup happening on other CPUs will probably push
tasks to it and wake it up anyway? exits can change the balance, but probably
is not relevant here?)

Except for a small fact: if the CPU sleeps w/o taking rebalance_ticks,
its cpu_load[] can become incorrect over a period.

I noticed that load_balance_newidle uses newidle_idx to gauge the current cpu's 
load. As a result, it can see non-zero load for the idle cpu. Because of this 
it can decide to not pull tasks.  

The rationale here (of using non-zero load): is it to try and let the
cpu become idle? Somehow, this doesn't make sense, because in the very next 
rebalance_tick (assuming that the idle cpu does not sleep), it will start using 
the idle_idx, which will cause the load to show up as zero and can cause the 
idle CPU to pull some tasks.

Have I missed something here?

Anyway, if the idle cpu were to sleep instead, the next rebalance_tick will 
not happen and it will not pull the tasks to restore load balance.

If my above understanding is correct, I see two potential solutions for this:


	A. Have load_balance_newidle use zero load for current cpu while
	  checking for busiest cpu.
	B. Or, if we want to retain load_balance_newidle the way it is, have 
	  the idle thread call back scheduler to zero the load and retry
	  load balance, _when_ it decides that it wants to sleep (there
	  are conditions under which a idle cpu may not want to sleep. for ex:
	  the next timer is only a tick, 1ms, away).

In either case, if the load balance still fails to pull any tasks, then it means
there is really no imbalance. Tasks that will be added into the system later 
(fork/wake_up) will be balanced across the CPUs because of the load-balance 
code that runs during those events.

A possible patch for B follows below:


---

 linux-2.6.12-rc3-mm2-vatsa/include/linux/sched.h |    1 
 linux-2.6.12-rc3-mm2-vatsa/kernel/sched.c        |   38 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff -puN kernel/sched.c~sched-nohz kernel/sched.c
--- linux-2.6.12-rc3-mm2/kernel/sched.c~sched-nohz	2005-05-04 18:23:30.000000000 +0530
+++ linux-2.6.12-rc3-mm2-vatsa/kernel/sched.c	2005-05-05 11:37:12.000000000 +0530
@@ -2214,6 +2214,44 @@ static inline void idle_balance(int this
 	}
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+/*
+ * Try hard to pull tasks. Called by idle task before it sleeps shutting off
+ * local timer ticks.  This clears the various load counters and tries to pull
+ * tasks. If it cannot, then it means that there is really no imbalance at this
+ * point. Any imbalance that arises in future (because of fork/wake_up) will be
+ * handled by the load balance that happens during those events.
+ *
+ * Returns 1 if tasks were pulled over, 0 otherwise.
+ */
+int idle_balance_retry(void)
+{
+	int j, moved = 0, this_cpu = smp_processor_id();
+	struct sched_domain *sd;
+	runqueue_t *this_rq = this_rq();
+	unsigned long flags;
+
+	spin_lock_irqsave(&this_rq->lock, flags);
+
+	for (j = 0; j < 3; j++)
+		this_rq->cpu_load[j] = 0;
+
+	for_each_domain(this_cpu, sd) {
+		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			if (load_balance_newidle(this_cpu, this_rq, sd)) {
+				/* We've pulled tasks over so stop searching */
+				moved = 1;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&this_rq->lock, flags);
+
+	return moved;
+}
+#endif
+
 /*
  * active_load_balance is run by migration threads. It pushes running tasks
  * off the busiest CPU onto idle CPUs. It requires at least 1 task to be
diff -puN include/linux/sched.h~sched-nohz include/linux/sched.h
--- linux-2.6.12-rc3-mm2/include/linux/sched.h~sched-nohz	2005-05-04 18:23:30.000000000 +0530
+++ linux-2.6.12-rc3-mm2-vatsa/include/linux/sched.h	2005-05-04 18:23:37.000000000 +0530
@@ -897,6 +897,7 @@ extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
+extern int idle_balance_retry(void);
 
 void yield(void);
 

_













-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
