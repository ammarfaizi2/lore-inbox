Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWBMBGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWBMBGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWBMBGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:06:53 -0500
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:26226 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751110AbWBMBGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:06:51 -0500
Message-ID: <43EFDBA9.4060107@bigpond.net.au>
Date: Mon, 13 Feb 2006 12:06:49 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: suresh.b.siddha@intel.com, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org>	<20060207153617.6520f126.akpm@osdl.org>	<20060209230145.A17405@unix-os.sc.intel.com>	<20060209231703.4bd796bf.akpm@osdl.org>	<43ED3D6A.8010300@bigpond.net.au> <20060210180010.16c9d20a.akpm@osdl.org> <43EE8BAD.9040601@bigpond.net.au> <43EFC05F.6010204@bigpond.net.au>
In-Reply-To: <43EFC05F.6010204@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------070709080705090102080809"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Feb 2006 01:06:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709080705090102080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Peter Williams wrote:
> 
>> Andrew Morton wrote:
>>
>>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>>
>>>> I don't think either of these issues warrant abandoning smpnice.  
>>>> The first is highly unlikely to occur on real systems and the second 
>>>> is just an example of the patch doing its job (maybe too 
>>>> officiously).  I don't think users would notice either on real systems.
>>>>
>>>> Even if you pull it from 2.6.16 rather than upgrading it with my 
>>>> patch can you please leave both in -mm?
>>>
>>>
>>>
>>>
>>> Yes, I have done that.  I currently have:
>>>
>>> sched-restore-smpnice.patch
>>> sched-modified-nice-support-for-smp-load-balancing.patch
>>> sched-cleanup_task_activated.patch
>>> sched-alter_uninterruptible_sleep_interactivity.patch
>>> sched-make_task_noninteractive_use_sleep_type.patch
>>> sched-dont_decrease_idle_sleep_avg.patch
>>> sched-include_noninteractive_sleep_in_idle_detect.patch
>>> sched-new-sched-domain-for-representing-multi-core.patch
>>> sched-fix-group-power-for-allnodes_domains.patch
>>
>>
>>
>> OK.  Having slept on these problems I am now of the opinion that the 
>> problems are caused by the use of NICE_TO_BIAS_PRIO(0) to set 
>> *imbalance inside the (*imbalance < SCHED_LOAD_SCALE) if statement in 
>> find_busiest_group().  What is happening here is that even though the 
>> imbalance is less than one (average) task sometimes the decision is 
>> made to move a task anyway but with the current version this decision 
>> can be subverted in two ways: 1) if the task to be moved has a nice 
>> value less than zero the value of *imbalance that is set will be too 
>> small for move_tasks() to move it; and 2) if there are a number of 
>> tasks with nice values greater than zero on the "busiest" more than 
>> one of them may be moved as the value of *imbalance that is set may be 
>> big enough to include more than one of these tasks.
>>
>> The fix for this problem is to replace NICE_TO_BIAS_PRIO(0) with the 
>> "average bias prio per runnable task" on "busiest".  This will 
>> (generally) result in a larger value for *imbalance in case 1. above 
>> and a smaller one in case 2. and alleviate both problems.  A patch to 
>> apply this fix is attached.
>>
>> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>>
>> Could you please add this patch to -mm so that it can be tested?
>>
>> [old patch removed]
> 
> 
> Can we pull this one, please?  I've mistakenly assumed that busiest was 
> a run queue when it's actually a sched group. :-(

Here's a fixed version that takes into account the fact that busiest is 
a group not a run queue.  This patch also includes "improvements" to the 
logic at the end of find_busiest_queue() to take account of the fact 
that the loads are weighted.  Hopefully, the comments in the code 
explain these changes.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Because this is a more substantial change it may be advisable to wait 
for comments from Ingo and Nick before including this in -mm for testing.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------070709080705090102080809
Content-Type: text/plain;
 name="fix-smpnice-light-load-problem-v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-smpnice-light-load-problem-v2"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-13 10:23:12.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-13 11:46:41.000000000 +1100
@@ -2033,9 +2033,11 @@ find_busiest_group(struct sched_domain *
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
 	unsigned long max_pull;
+	unsigned long avg_bias_prio, busiest_prio_bias, busiest_nr_running;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
+	busiest_prio_bias = busiest_nr_running = 0;
 	if (idle == NOT_IDLE)
 		load_idx = sd->busy_idx;
 	else if (idle == NEWLY_IDLE)
@@ -2047,13 +2049,16 @@ find_busiest_group(struct sched_domain *
 		unsigned long load;
 		int local_group;
 		int i;
+		unsigned long sum_prio_bias, sum_nr_running;
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
 		/* Tally up the load of all CPUs in the group */
-		avg_load = 0;
+		sum_prio_bias = sum_nr_running = avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			runqueue_t *rq = cpu_rq(i);
+
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
 
@@ -2064,6 +2069,8 @@ find_busiest_group(struct sched_domain *
 				load = source_load(i, load_idx);
 
 			avg_load += load;
+			sum_prio_bias += rq->prio_bias;
+			sum_nr_running += rq->nr_running;
 		}
 
 		total_load += avg_load;
@@ -2078,6 +2085,8 @@ find_busiest_group(struct sched_domain *
 		} else if (avg_load > max_load) {
 			max_load = avg_load;
 			busiest = group;
+			busiest_prio_bias = sum_prio_bias;
+			busiest_nr_running = sum_nr_running;
 		}
 		group = group->next;
 	} while (group != sd->groups);
@@ -2111,12 +2120,25 @@ find_busiest_group(struct sched_domain *
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
-	if (*imbalance < SCHED_LOAD_SCALE) {
+	/* assume that busiest_nr_running > 0 */
+	avg_bias_prio = busiest_prio_bias / busiest_nr_running;
+	/*
+	 * Get rid of the scaling factor, rounding down as we divide and
+	 * converting to biased load for use by move_tasks()
+	 */
+	*imbalance = biased_load(*imbalance);
+	/*
+	 * if *imbalance is less than the average runnable task biased prio
+	 * there is no gaurantee that any tasks will be moved so we'll have
+	 * a think about bumping its value to force at least one task to be
+	 * moved
+	 */
+	if (*imbalance < avg_bias_prio) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
 
-		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = NICE_TO_BIAS_PRIO(0);
+		if (biased_load(max_load - this_load) >= avg_bias_prio*2) {
+			*imbalance = avg_bias_prio;
 			return busiest;
 		}
 
@@ -2146,18 +2168,19 @@ find_busiest_group(struct sched_domain *
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain throughput */
-		if (pwr_move <= pwr_now)
-			goto out_balanced;
+		if (pwr_move <= pwr_now) {
+			/* or if there's a reasonable chance that *imbalance
+			 * is big enough to cause a move
+			 */
+			if (*imbalance <= avg_bias_prio / 2)
+				goto out_balanced;
+			else
+				return busiest;
+		}
 
-		*imbalance = NICE_TO_BIAS_PRIO(0);
-		return busiest;
+		*imbalance = avg_bias_prio;
 	}
 
-	/*
-	 * Get rid of the scaling factor, rounding down as we divide and
-	 * converting to biased load for use by move_tasks()
-	 */
-	*imbalance = biased_load(*imbalance);
 	return busiest;
 
 out_balanced:

--------------070709080705090102080809--
