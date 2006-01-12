Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWALBZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWALBZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWALBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:25:39 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:22501 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964944AbWALBZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:25:39 -0500
Message-ID: <43C5B010.2050908@bigpond.net.au>
Date: Thu, 12 Jan 2006 12:25:36 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au>
In-Reply-To: <43C58117.9080706@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------040206090201060409030406"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 12 Jan 2006 01:25:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206090201060409030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> On Wednesday 11 January 2006 23:24, Peter Williams wrote:
>>
>>> Martin J. Bligh wrote:
>>>
>>>> That seems broken to me ?
>>>
>>>
>>> But, yes, given that the problem goes away when the patch is removed
>>> (which we're still waiting to see) it's broken.  I think the problem is
>>> probably due to the changed metric (i.e. biased load instead of simple
>>> load) causing idle_balance() to fail more often (i.e. it decides to not
>>> bother moving any tasks more often than it otherwise would) which would
>>> explain the increased idle time being seen.  This means that the fix
>>> would be to review the criteria for deciding whether to move tasks in
>>> idle_balance().
>>
>>
>>
>> Look back on my implementation. The problem as I saw it was that one 
>> task alone with a biased load would suddenly make a runqueue look much 
>> busier than it was supposed to so I special cased the runqueue that 
>> had precisely one task.
> 
> 
> OK.  I'll look at that.

OK.  I agree that this mechanism increases the chances that a queue with 
only one runnable task is selected as the target for stealing tasks 
from.  The attached patch addresses this issue in two ways:

1. in find_busiest_group(), only groups that have at least one queue 
with more than one task running are considered, and
2. in find_busiest_queue(), only queues with more than one runnable task 
are considered.

As I see it, this patch is a bit iffy as it is effected by race 
conditions in two ways:

1. just because there's more than one task runnable when these checks 
are made there's no guarantee that this will be the case when you try to 
move some of them, and
2. just because there's only one task runnable when these checks are 
made it's possible that there will be more than one when you attempt the 
move.

I don't think that this patch makes case 1 any worse than it already is 
but case 2 could cause potential moves to be missed that otherwise 
wouldn't be and I assume this is the reason why there is no similar code 
in the original.  Whether the increased probability of choosing queues 
with only one runnable tasks changes this reasoning is up for debate.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040206090201060409030406
Content-Type: text/plain;
 name="consider-nr_running-when-finding-busiest"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consider-nr_running-when-finding-busiest"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-01-12 10:44:50.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-01-12 10:47:01.000000000 +1100
@@ -2052,6 +2052,7 @@ find_busiest_group(struct sched_domain *
 		unsigned long load;
 		int local_group;
 		int i;
+		unsigned int eligible_qs = 0;
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
@@ -2065,8 +2066,11 @@ find_busiest_group(struct sched_domain *
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
 				load = target_load(i, load_idx);
-			else
+			else {
 				load = source_load(i, load_idx);
+				if (cpu_rq(i)->nr_running > 1)
+					++eligible_qs;
+			}
 
 			avg_load += load;
 		}
@@ -2080,7 +2084,7 @@ find_busiest_group(struct sched_domain *
 		if (local_group) {
 			this_load = avg_load;
 			this = group;
-		} else if (avg_load > max_load) {
+		} else if (avg_load > max_load && eligible_qs) {
 			max_load = avg_load;
 			busiest = group;
 		}
@@ -2181,8 +2185,12 @@ static runqueue_t *find_busiest_queue(st
 		load = source_load(i, 0);
 
 		if (load > max_load) {
-			max_load = load;
-			busiest = cpu_rq(i);
+			runqueue_t *tmprq = cpu_rq(i);
+
+			if (tmprq->nr_running > 1) {
+				max_load = load;
+				busiest = tmprq;
+			}
 		}
 	}
 

--------------040206090201060409030406--
