Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWCYDke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWCYDke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 22:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWCYDke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 22:40:34 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:33267 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750740AbWCYDkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 22:40:33 -0500
Message-ID: <4424BBAE.2060005@bigpond.net.au>
Date: Sat, 25 Mar 2006 14:40:30 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: make sure busiest group and run queue are pullable
References: <20060322155122.2745649f.akpm@osdl.org> <4421F702.5040609@bigpond.net.au> <20060324154558.A20018@unix-os.sc.intel.com> <4424953B.9030000@bigpond.net.au> <4424A298.70706@bigpond.net.au>
In-Reply-To: <4424A298.70706@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------080106010505060605030506"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 25 Mar 2006 03:40:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106010505060605030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> more issues with smpnice patch...
>>>
>>> a) consider a 4-way system (simple SMP system with no HT and cores) 
>>> scenario
>>> where a high priority task (nice -20) is running on P0 and two normal
>>> priority tasks running on P1. load balance with smp nice code
>>> will never be able to detect an imbalance and hence will never move 
>>> one of the normal priority tasks on P1 to idle cpus P2 or P3.
>>
>> Why?
> 
> OK, I think I know why.  The load balancing code will always decide that 
> P0 is the busiest CPU, right?

Attached is a patch that addresses this problem.  The strategies 
employed are:

1. for find_busiest_group() only consider groups that have at least one 
CPU with more than one task running as candidates for "busiest", and

2. for find_busiest_queue() only consider queues that have more than one 
running tasks as candidates for "busiest".

I think that the overhead gains from earlier abandonment of load 
balancing attempts that would eventually (most probably -- see next 
paragraph) be abandoned anyway will compensate for the extra overhead 
introduced in these functions.

I think that the only likely behavioural changes for an all tasks have 
nice==0 system is that without these checks there is a small chance that 
a "busiest" that only has one runnable task (and for which move_tasks() 
would eventually not move any tasks) when these tests are made may 
actually acquire extra runnable tasks before the locks are taken in 
preparation for calling move_tasks() and, therefore, load balancing may 
actually take place.  I think that this effect can be safely ignored.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------080106010505060605030506
Content-Type: text/plain;
 name="smpnice-modify-busiest-searches"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-modify-busiest-searches"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-03-25 13:43:06.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-03-25 13:56:37.000000000 +1100
@@ -2115,6 +2115,7 @@ find_busiest_group(struct sched_domain *
 		int local_group;
 		int i;
 		unsigned long sum_nr_running, sum_weighted_load;
+		unsigned int nr_loaded_cpus = 0; /* where nr_running > 1 */
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
@@ -2135,6 +2136,8 @@ find_busiest_group(struct sched_domain *
 
 			avg_load += load;
 			sum_nr_running += rq->nr_running;
+			if (rq->nr_running > 1)
+				++nr_loaded_cpus;
 			sum_weighted_load += rq->raw_weighted_load;
 		}
 
@@ -2149,7 +2152,7 @@ find_busiest_group(struct sched_domain *
 			this = group;
 			this_nr_running = sum_nr_running;
 			this_load_per_task = sum_weighted_load;
-		} else if (avg_load > max_load) {
+		} else if (nr_loaded_cpus && avg_load > max_load) {
 			max_load = avg_load;
 			busiest = group;
 			busiest_nr_running = sum_nr_running;
@@ -2258,16 +2261,16 @@ out_balanced:
 static runqueue_t *find_busiest_queue(struct sched_group *group,
 	enum idle_type idle)
 {
-	unsigned long load, max_load = 0;
-	runqueue_t *busiest = NULL;
+	unsigned long max_load = 0;
+	runqueue_t *busiest = NULL, *rqi;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = weighted_cpuload(i);
+		rqi = cpu_rq(i);
 
-		if (load > max_load) {
-			max_load = load;
-			busiest = cpu_rq(i);
+		if (rqi->nr_running > 1 && rqi->raw_weighted_load > max_load) {
+			max_load = rqi->raw_weighted_load;
+			busiest = rqi;
 		}
 	}
 

--------------080106010505060605030506--
