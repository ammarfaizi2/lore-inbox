Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJGQMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJGQMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUJGQJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 12:09:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65470 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267431AbUJGQEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:04:24 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Date: Thu, 7 Oct 2004 10:58:53 -0500
User-Agent: KMail/1.5
References: <200410071028.01931.habanero@us.ibm.com>
In-Reply-To: <200410071028.01931.habanero@us.ibm.com>
Cc: kernel@kolivas.org, pwil3058@bigpond.net, nickpiggin@yahoo.com.au,
       mingo@elte.hu, kenneth.w.chen@intel.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9eWZBwGJXIEoIYl"
Message-Id: <200410071058.53618.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9eWZBwGJXIEoIYl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> OK... Well Andrew as I said I'd be happy for this to go in. I'd be *extra*
> happy if Judith ran a few of those dbt thingy tests which had been
> sensitive to idle time. Can you ask her about that? or should I?
>
> > As a side note, I'd like to get involved on future scheduler tuning
>
> experiments,
>
> > we have fair amount of benchmark environments where we can validate
> > things
>
> across
>
> > various kind of workload, i.e., db, java, cpu, etc.  Thanks.
>
> That would be very welcome indeed. We have a big backlog of scheduler
> things to go in after 2.6.9 is released (although not many of them change
> the runtime behaviour IIRC). After that, I have some experimental
> performance work that could use wider testing. After *that*, the
> multiprocessor scheduler will in a state where 2.6 shouldn't need much more
> work, so we can concentrate on just tuning the dials.

I'd like to add some comments as well:

1) We are seeing similar problems with that "well known" DB transaction 
benchmark, as well as another well known benchmark measuring multi-tier J2EE 
server performance.  Both problems are with load balancing.  It's not quite 
the same situation.  We have too much idle time and not enough throughput.  
Giving a more aggressive idle balance has helped there.  The 3 areas we have 
changed at:

wake_idle()  -find the first idle cpu, statring with cpu->sd and moving up the 
sd's as needed.  Modify SD_NODE_INIT.flags and SD_CPU_INIT.flags to include 
SD_WAKE_IDLE.  Now, if there is an idle cpu (and task->cpu is busy), we move 
it to the closest idle cpu.

can_migrate() put back (again) the aggressive idle condition in can_migrate().  
Do not look at task_hot when we have an idle cpu.

idle_balance() / SD_NODE_INIT   add SD_BALANCE_NEWIDLE to SD_NODE_INIT.flags 
so a newly idle_balance can try to balance from an appropriate cpu, first a 
cpu close to it, then farther out.

(the above changes IMO could also pave the way for removing timer based -idle- 
balances)

IMO, I don't think idle cpus should play by the exact same rules as busy ones 
when load balacing.  I am not saying the only answer is not looking at cache 
warmth at all, but maybe a much more relaxed policy.

Also, finding (at boot time) the best cache_hot_time is a step in the right 
direction, but I have to wonder it cache_hot() is really doing the right 
thing.  It looks like all cache_hot does is decide this task is cache hot 
because it ran recently.  Who's to say the task got cache warm in the first 
place?  Shouldn't we be looking at both how long ago it ran and the length of 
time it ran?  Some of these workloads have very high transaction rates, and 
in turn have very high context switch rates.  I would be surprised if many of 
the tasks got more than enough continuous run time to get good cache warmth 
anyway.  I am all for testing chace warmth, but I think we should start 
looking at more than just how long ago the task ran.

-Andrew Theurer




--Boundary-00=_9eWZBwGJXIEoIYl
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="100-wake_idle-patch.269-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="100-wake_idle-patch.269-rc3"

diff -Naurp linux-2.6.9-rc3/kernel/sched.c linux-2.6.9-rc3-wake_idle/kernel/sched.c
--- linux-2.6.9-rc3/kernel/sched.c	2004-10-09 05:59:47.000000000 -0700
+++ linux-2.6.9-rc3-wake_idle/kernel/sched.c	2004-10-11 00:57:28.590909272 -0700
@@ -393,7 +393,8 @@ struct sched_domain {
 	.flags			= SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
-				| SD_WAKE_BALANCE,	\
+				| SD_WAKE_BALANCE	\
+				| SD_WAKE_IDLE,		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
@@ -413,7 +414,8 @@ struct sched_domain {
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
+				| SD_WAKE_BALANCE	\
+				| SD_WAKE_IDLE,		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
@@ -1066,35 +1068,30 @@ static inline unsigned long target_load(
 #endif
 
 /*
- * wake_idle() is useful especially on SMT architectures to wake a
- * task onto an idle sibling if we would otherwise wake it onto a
- * busy sibling.
+ * wake_idle() will wake a task on an idle cpu if task->cpu is
+ * not idle and and idle cpu is available.  The span of cpus to
+ * search is the top most sched domain with SD_BALANCE_EXEC.
  *
  * Returns the CPU we should wake onto.
  */
 #if defined(ARCH_HAS_SCHED_WAKE_IDLE)
 static int wake_idle(int cpu, task_t *p)
 {
-	cpumask_t tmp;
-	runqueue_t *rq = cpu_rq(cpu);
-	struct sched_domain *sd;
+	cpumask_t cpumask;
+	struct sched_domain *sd = NULL;
 	int i;
 
-	if (idle_cpu(cpu))
-		return cpu;
-
-	sd = rq->sd;
-	if (!(sd->flags & SD_WAKE_IDLE))
-		return cpu;
-
-	cpus_and(tmp, sd->span, cpu_online_map);
-	cpus_and(tmp, tmp, p->cpus_allowed);
-
-	for_each_cpu_mask(i, tmp) {
-		if (idle_cpu(i))
-			return i;
+	for_each_domain(cpu, sd) {
+		if (sd->flags & SD_WAKE_IDLE) {
+			cpus_and(cpumask, sd->span, cpu_online_map);
+			cpus_and(cpumask, cpumask, p->cpus_allowed);
+			for_each_cpu_mask(i, cpumask) {
+				if (idle_cpu(i))
+					return i;
+			}
+		}
+		else break;
 	}
-
 	return cpu;
 }
 #else
@@ -1205,10 +1202,12 @@ static int try_to_wake_up(task_t * p, un
 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
 	schedstat_inc(rq, ttwu_attempts);
-	new_cpu = wake_idle(new_cpu, p);
-	if (new_cpu != cpu && cpu_isset(new_cpu, p->cpus_allowed)) {
-		schedstat_inc(rq, ttwu_moved);
-		set_task_cpu(p, new_cpu);
+	if (!idle_cpu(cpu)) {
+		new_cpu = wake_idle(new_cpu, p);
+		if (new_cpu != cpu) {
+			schedstat_inc(rq, ttwu_moved);
+			set_task_cpu(p, new_cpu);
+		}
 		task_rq_unlock(rq, &flags);
 		/* might preempt at this point */
 		rq = task_rq_lock(p, &flags);

--Boundary-00=_9eWZBwGJXIEoIYl
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="120-new_idle-patch.269-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="120-new_idle-patch.269-rc3"

diff -Naurp linux-2.6.9-rc3-wake_idle-can_migrate/kernel/sched.c linux-2.6.9-rc3-wake_idle-can_migrate-newidle/kernel/sched.c
--- linux-2.6.9-rc3-wake_idle-can_migrate/kernel/sched.c	2004-10-11 01:11:58.016917328 -0700
+++ linux-2.6.9-rc3-wake_idle-can_migrate-newidle/kernel/sched.c	2004-10-11 01:24:05.826894464 -0700
@@ -413,7 +413,8 @@ struct sched_domain {
 	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
-	.flags			= SD_BALANCE_EXEC	\
+	.flags			= SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE	\
 				| SD_WAKE_IDLE,		\
 	.last_balance		= jiffies,		\

--Boundary-00=_9eWZBwGJXIEoIYl
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="110-can_migrate-patch.269-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="110-can_migrate-patch.269-rc3"

diff -Naurp linux-2.6.9-rc3-wake_idle/kernel/sched.c linux-2.6.9-rc3-wake_idle-can_migrate/kernel/sched.c
--- linux-2.6.9-rc3-wake_idle/kernel/sched.c	2004-10-11 00:57:28.590909272 -0700
+++ linux-2.6.9-rc3-wake_idle-can_migrate/kernel/sched.c	2004-10-11 01:11:58.016917328 -0700
@@ -1780,14 +1780,8 @@ int can_migrate_task(task_t *p, runqueue
 		return 0;
 	if (!cpu_isset(this_cpu, p->cpus_allowed))
 		return 0;
-
-	/* Aggressive migration if we've failed balancing */
-	if (idle == NEWLY_IDLE ||
-			sd->nr_balance_failed < sd->cache_nice_tries) {
-		if (task_hot(p, rq->timestamp_last_tick, sd))
-			return 0;
-	}
-
+	if (idle == NOT_IDLE && task_hot(p, rq->timestamp_last_tick, sd))
+		return 0;
 	return 1;
 }
 

--Boundary-00=_9eWZBwGJXIEoIYl--

