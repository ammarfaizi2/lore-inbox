Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTLOGLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTLOGJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:09:30 -0500
Received: from dp.samba.org ([66.70.73.150]:61628 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263292AbTLOGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler 
In-reply-to: Your message of "Sat, 13 Dec 2003 17:43:35 +1100."
             <3FDAB517.4000309@cyberone.com.au> 
Date: Mon, 15 Dec 2003 16:53:15 +1100
Message-Id: <20031215060838.BF3D32C257@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FDAB517.4000309@cyberone.com.au> you write:
> Rusty Russell wrote:
> 
> >In message <3FD9679A.1020404@cyberone.com.au> you write:
> >
> >>Thanks for having a look Rusty. I'll try to convince you :)

Actually, having produced the patch, I've changed my mind.

While it was spiritually rewarding to separate "struct runqueue" into
the stuff which was to do with the runqueue, and the stuff which was
per-cpu but there because it was convenient, I'm not sure the churn is
worthwhile since we will want the rest of your stuff anyway.

It (and lots of other things) might become worthwhile if single
processors with HT become the de-facto standard.  For these, lots of
our assumptions about CONFIG_SMP, such as the desirability of per-cpu
data, become bogus.

A few things need work:

1) There's a race between sys_sched_setaffinity() and
   sched_migrate_task() (this is nothing to do with your patch).

2) Please change those #defines into an enum for idle (patch follows,
   untested but trivial)

3) conditional locking in load_balance is v. bad idea.

4) load_balance returns "(!failed && !balanced)", but callers stop
   calling it when it returns true.  Why not simply return "balanced",
   or at least "balanced && !failed"?

Untested patch for #2 below...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

D: Change #defines to enum, and use it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.0-test11-w26/kernel/sched.c working-2.6.0-test11-w26-enum/kernel/sched.c
--- working-2.6.0-test11-w26/kernel/sched.c	2003-12-15 16:31:15.000000000 +1100
+++ working-2.6.0-test11-w26-enum/kernel/sched.c	2003-12-15 16:38:49.000000000 +1100
@@ -1268,9 +1268,12 @@ out:
 	return pulled;
 }
 
-#define TYPE_NOIDLE	0
-#define TYPE_IDLE	1
-#define TYPE_NEWIDLE	2
+enum idle_type
+{
+	NOT_IDLE,
+	AM_IDLE,
+	NEWLY_IDLE,
+};
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
@@ -1279,11 +1282,11 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *domain, int this_cpu,
-				unsigned long *imbalance, int idle)
+				unsigned long *imbalance, enum idle_type idle)
 {
 	unsigned long max_load, avg_load, total_load, this_load;
 	int modify, total_nr_cpus;
-	int package_idle = idle;
+	enum idle_type package_idle = idle;
 	struct sched_group *busiest = NULL, *group = domain->groups;
 
 	max_load = 0;
@@ -1299,7 +1302,7 @@ find_busiest_group(struct sched_domain *
 	 * statistics: its triggered by some value of nr_running (ie. 0).
 	 * Timer based balancing is a good statistic though.
 	 */
-	if (idle == TYPE_NEWIDLE)
+	if (idle == NEWLY_IDLE)
 		modify = 0;
 	else
 		modify = 1;
@@ -1318,7 +1321,7 @@ find_busiest_group(struct sched_domain *
 			if (local_group) {
 				load = get_high_cpu_load(i, modify);
 				if (!idle_cpu(i))
-					package_idle = 0;
+					package_idle = NOT_IDLE;
 			} else
 				load = get_low_cpu_load(i, modify);
 
@@ -1403,11 +1406,11 @@ static runqueue_t *find_busiest_queue(st
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  *
- * Called with this_rq unlocked unless idle == TYPE_NEWIDLE, in which case
+ * Called with this_rq unlocked unless idle == NEWLY_IDLE, in which case
  * it is called with this_rq locked.
  */
 static int load_balance(int this_cpu, runqueue_t *this_rq,
-				struct sched_domain *domain, int idle)
+			struct sched_domain *domain, enum idle_type idle)
 {
 	struct sched_group *group;
 	runqueue_t *busiest = NULL;
@@ -1415,7 +1418,7 @@ static int load_balance(int this_cpu, ru
 	int balanced = 0, failed = 0;
 	int wake_mthread = 0;
 
-	if (idle != TYPE_NEWIDLE)
+	if (idle != NEWLY_IDLE)
 		spin_lock(&this_rq->lock);
 
 	group = find_busiest_group(domain, this_cpu, &imbalance, idle);
@@ -1456,7 +1459,7 @@ static int load_balance(int this_cpu, ru
 	spin_unlock(&busiest->lock);
 
 out:
-	if (idle != TYPE_NEWIDLE) {
+	if (idle != NEWLY_IDLE) {
 		spin_unlock(&this_rq->lock);
 
 		if (failed)
@@ -1495,7 +1498,7 @@ static inline void idle_balance(int this
 			break;
 
 		if (domain->flags & SD_FLAG_NEWIDLE) {
-			if (load_balance(this_cpu, this_rq, domain, TYPE_NEWIDLE)) {
+			if (load_balance(this_cpu, this_rq, domain, NEWLY_IDLE)) {
 				/* We've pulled tasks over so stop searching */
 				break;
 			}
@@ -1537,7 +1540,7 @@ static void active_load_balance(runqueue
 /* Don't have all balancing operations going off at once */
 #define CPU_OFFSET(cpu) (HZ * cpu / NR_CPUS)
 
-static void rebalance_tick(int this_cpu, runqueue_t *this_rq, int idle)
+static void rebalance_tick(int this_cpu, runqueue_t *this_rq, enum idle_type idle)
 {
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *domain = this_sched_domain();
@@ -1556,7 +1559,7 @@ static void rebalance_tick(int this_cpu,
 		if (!(j % modulo)) {
 			if (load_balance(this_cpu, this_rq, domain, idle)) {
 				/* We've pulled tasks over so no longer idle */
-				idle = 0;
+				idle = NOT_IDLE;
 			}
 		}
 
@@ -1567,7 +1570,7 @@ static void rebalance_tick(int this_cpu,
 /*
  * on UP we do not need to balance between CPUs:
  */
-static inline void rebalance_tick(int this_cpu, runqueue_t *this_rq, int idle)
+static inline void rebalance_tick(int this_cpu, runqueue_t *this_rq, enum idle_type idle)
 {
 }
 #endif
@@ -1621,7 +1624,7 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
-		rebalance_tick(cpu, rq, 1);
+		rebalance_tick(cpu, rq, AM_IDLE);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -1703,7 +1706,7 @@ void scheduler_tick(int user_ticks, int 
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
-	rebalance_tick(cpu, rq, 0);
+	rebalance_tick(cpu, rq, NOT_IDLE);
 }
 
 void scheduling_functions_start_here(void) { }



