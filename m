Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUJEWJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUJEWJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUJEWJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:09:45 -0400
Received: from gizmo12bw.bigpond.com ([144.140.70.43]:43693 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S263117AbUJEWJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:09:41 -0400
Message-ID: <41631BA1.5010705@bigpond.net.au>
Date: Wed, 06 Oct 2004 08:09:37 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410051739.i95HdD627957@unix-os.sc.intel.com>
In-Reply-To: <200410051739.i95HdD627957@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Chen, Kenneth W wrote:
> 
>>Current implementation of task_hot() has a performance bug in it
>>that it will cause integer underflow.
>>
>>Variable "now" (typically passed in as rq->timestamp_last_tick)
>>and p->timestamp are all defined as unsigned long long.  However,
>>If former is smaller than the latter, integer under flow occurs
>>which make the result of subtraction a huge positive number. Then
>>it is compared to sd->cache_hot_time and it will wrongly identify
>>a cache hot task as cache cold.
>>
>>This bug causes large amount of incorrect process migration across
>>cpus (at stunning 10,000 per second) and we lost cache affinity very
>>quickly and almost took double digit performance regression on a db
>>transaction processing workload.  Patch to fix the bug.  Diff'ed against
>>2.6.9-rc3.
>>
> 
> 
> Peter Williams wrote on Tuesday, October 05, 2004 12:33 AM
> 
>>The interesting question is: How does now get to be less than timestamp?
>>  This probably means that timestamp_last_tick is not a good way of
>>getting a value for "now".  By the way, neither is sched_clock() when
>>measuring small time differences as it is not monotonic (something that
>>I had to allow for in my scheduling code).  I applied no such safeguards
>>to the timing used by the load balancing code as I assumed that it
>>already worked.
> 
> 
> The reason now gets smaller than timestamp was because of random thing
> that activate_task() do to p->timestamp.  Here are the sequence of events:
> 
> On timer tick, scheduler_tick() updates rq->timestamp_last_tick,
> 1 us later, process A wakes up, entering into run queue. activate_task()
> updates p->timestamp.  At this time p->timestamp is larger than rq->
> timestamp_last_tick.  Then another cpu goes into idle, tries load balancing,
> It wrongly finds process A not cache hot (because of integer underflow),
> moved it.  Then application runs on a cache cold CPU and suffer performance.

Having thought about this over night I've come to the conclusion that 
(because it is set using sched_clock()) timestamp is always bigger than 
timestamp_last_tick for a short period of time (i.e. until the next time 
  scheduler_tick()).  This doesn't effect the load balancing code that 
is triggered by scheduler_tick() (for obvious reasons) but all other 
load balancing code is susceptible to the problem.  The setting of 
timestamp in activate() just exacerbates the problem and the fact that 
Ingo's VP work is reducing the amount of time that it takes tasks to get 
from wake up to a point where load balancing is triggered (or they're 
involved in load balancing decisions) other than by scheduler_tick() 
means that it matters more than it used to.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
