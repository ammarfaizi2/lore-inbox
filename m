Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVDGMqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVDGMqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVDGMqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:46:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54521 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262449AbVDGMpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:45:54 -0400
Date: Thu, 7 Apr 2005 18:16:29 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: george@mvista.com, nickpiggin@yahoo.com.au, mingo@elte.hu
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: VST and Sched Load Balance
Message-ID: <20050407124629.GA17268@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	VST patch (http://lwn.net/Articles/118693/) attempts to avoid useless 
regular (local) timer ticks when a CPU is idle.

I think a potential area which VST may need to address is 
scheduler load balance. If idle CPUs stop taking local timer ticks for 
some time, then during that period it could cause the various runqueues to 
go out of balance, since the idle CPUs will no longer pull tasks from 
non-idle CPUs. 

Do we care about this imbalance? Especially considering that most 
implementations will let the idle CPUs sleep only for some max duration
(~900 ms in case of x86).

If we do care about this imbalance, then we could hope that the balance logic
present in try_to_wake_up and sched_exec may avoid this imbalance, but can we 
bank upon these events to restore the runqueue balance?

If we cannot, then I had something in mind on these lines:

1. A non-idle CPU (having nr_running > 1) can wakeup a idle sleeping CPU if it 
   finds that the sleeping CPU has not balanced itself for it's 
   "balance_interval" period.

2. It would be nice to minimize the "cross-domain" wakeups. For ex: we may want 
   to avoid a non-idle CPU in node B sending a wakeup to a idle sleeping CPU in 
   another node A, when this wakeup could have been sent from another non-idle
   CPU in node A itself. 
 
	That is why I have imposed the condition for sending wakeup only when
   a whole sched_group of CPUs are sleeping in a domain. We wake one of them 
   up. The chosen one is one which has not balanced itself for 
   "balance_interval" period.

I did think about avoiding all these and putting some hooks in 
wake_up_new_task, to wakeup the sleeping CPUs. But the problem is 
the woken-up CPU may refuse to pull any tasks and go to sleep again
if it has balanced itself in the domain "recently" (balance_interval).


Comments?

Patch (not fully-tested) against 2.6.11 follows.


---

 linux-2.6.11-vatsa/kernel/sched.c |   52 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+)

diff -puN kernel/sched.c~vst-sched_load_balance kernel/sched.c
--- linux-2.6.11/kernel/sched.c~vst-sched_load_balance	2005-04-07 17:51:34.000000000 +0530
+++ linux-2.6.11-vatsa/kernel/sched.c	2005-04-07 17:56:18.000000000 +0530
@@ -1774,9 +1774,17 @@ find_busiest_group(struct sched_domain *
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
+#ifdef CONFIG_VST
+	int grp_sleeping;
+	cpumask_t tmpmask, wakemask;
+#endif
 
 	max_load = this_load = total_load = total_pwr = 0;
 
+#ifdef CONFIG_VST
+	cpus_clear(wakemask);
+#endif
+
 	do {
 		unsigned long load;
 		int local_group;
@@ -1787,7 +1795,20 @@ find_busiest_group(struct sched_domain *
 		/* Tally up the load of all CPUs in the group */
 		avg_load = 0;
 
+#ifdef CONFIG_VST
+		grp_sleeping = 0;
+		cpus_and(tmpmask, group->cpumask, nohz_cpu_mask);
+		if (cpus_equal(tmpmask, group->cpumask))
+			grp_sleeping = 1;
+#endif
+
 		for_each_cpu_mask(i, group->cpumask) {
+#ifdef CONFIG_VST
+			int cpu = smp_processor_id();
+			struct sched_domain *sd1;
+			unsigned long interval;
+			int woken = 0;
+#endif
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
 				load = target_load(i);
@@ -1796,6 +1817,25 @@ find_busiest_group(struct sched_domain *
 
 			nr_cpus++;
 			avg_load += load;
+
+#ifdef CONFIG_VST
+			if (idle != NOT_IDLE || !grp_sleeping ||
+						(grp_sleeping && woken))
+				continue;
+
+			sd1 = sd + (i-cpu);
+			interval = sd1->balance_interval;
+
+			/* scale ms to jiffies */
+			interval = msecs_to_jiffies(interval);
+	                if (unlikely(!interval))
+        	                interval = 1;
+
+			if (jiffies - sd1->last_balance >= interval) {
+				woken = 1;
+				cpu_set(i, wakemask);
+			}
+#endif
 		}
 
 		if (!nr_cpus)
@@ -1819,6 +1859,18 @@ nextgroup:
 		group = group->next;
 	} while (group != sd->groups);
 
+#ifdef CONFIG_VST
+	if (idle == NOT_IDLE && this_load > SCHED_LOAD_SCALE) {
+		int i;
+
+		for_each_cpu_mask(i, wakemask) {
+			spin_lock(&cpu_rq(i)->lock);
+			resched_task(cpu_rq(i)->idle);
+			spin_unlock(&cpu_rq(i)->lock);
+		}
+	}
+#endif
+
 	if (!busiest || this_load >= max_load)
 		goto out_balanced;
 

_





-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
