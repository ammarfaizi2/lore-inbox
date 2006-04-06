Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWDFETZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWDFETZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWDFETZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:19:25 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:46775 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932139AbWDFETZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:19:25 -0400
Message-ID: <443496CA.6050905@bigpond.net.au>
Date: Thu, 06 Apr 2006 14:19:22 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Darren Hart <darren@dvhart.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
References: <200604052025.05679.darren@dvhart.com>
In-Reply-To: <200604052025.05679.darren@dvhart.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Apr 2006 04:19:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:
> My last mail specifically addresses preempt-rt, but I'd like to know people's 
> thoughts regarding this issue in the mainline kernel.  Please see my previous 
> post "realtime-preempt scheduling - rt_overload behavior" for a testcase that 
> produces unpredictable scheduling results.
> 
> Part of the issue here is to define what we consider "correct behavior" for 
> SCHED_FIFO realtime tasks.  Do we (A) need to strive for "strict realtime 
> priority scheduling" where the NR_CPUS highest priority runnable SCHED_FIFO 
> tasks are _always_ running?  Or do we (B) take the best effort approach with 
> an upper limit RT priority imbalances, where an imbalance may occur (say at 
> wakeup or exit) but will be remedied within 1 tick.  The smpnice patches 
> improve load balancing, but don't provide (A).
> 
> More details in the previous mail...

I'm currently researching some ideas to improve smpnice that may help in 
this situation.  The basic idea is that as well as trying to equally 
distribute the weighted load among the groups/queues we should also try 
to achieve equal "average load per task" for each group/queue.  (As well 
as helping with problems such as yours, this will help to restore the 
"equal distribution of nr_running" amongst groups/queues aim that is 
implicit without smpnice due to the fact that load is just a smoothed 
version of nr_running.)

In find_busiest_group(), I think that load balancing in the case where 
*imbalance is greater than busiest_load_per_task will tend towards this 
result and also when *imbalance is less than busiest_load_per_task AND 
busiest_load_per_task is less than this_load_per_task.  However, in the 
case where *imbalance is less than busiest_load_per_task AND 
busiest_load_per_task is greater than this_load_per_task this will not 
be the case as the amount of load moved from "busiest" to "this" will be 
less than or equal to busiest_load_per_task and this will actually 
increase the value of busiest_load_per_task.  So, although it will 
achieve the aim of equally distributing the weighted load, it won't help 
the second aim of equal "average load per task" values for groups/queues.

The obvious way to fix this problem is to alter the code so that more 
than busiest_load_per_task is moved from "busiest" to "this" in these 
cases while at the same time ensuring that the imbalance between their 
loads doesn't get any bigger.  I'm working on a patch along these lines.

Changes to find_idlest_group() and try_to_wake_up() taking into account 
the "average load per task" on the candidate queues/groups as well as 
their weighted loads may also help and I'll be looking at them as well. 
  It's not immediately obvious to me how this can be done so any ideas 
would be welcome.  It will likely involve taking the load weight of the 
waking task into account as well.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
