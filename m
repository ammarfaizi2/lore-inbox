Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVJ1LCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVJ1LCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVJ1LCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:02:12 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:57426 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965192AbVJ1LCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:02:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Thp/YQ2OLyUj/W1CZ//fsD4tXpKD92x4x33IRTln2vwbyfU6NMHMIU5aI6SBge2dp3o2UiKXFfh4eIyvRYk2yRmXP0Qc+d9QoxmpzXQArvpsp+jJaP6fMyfZ0+AW1vaIZinsmQH5d9YZaiPrdiFok3xy9KdilKH9WLM+2jKBvks=  ;
Message-ID: <43620583.9080500@yahoo.com.au>
Date: Fri, 28 Oct 2005 21:03:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com> <4361EC95.5040800@yahoo.com.au> <20051028100806.GA19507@elte.hu>
In-Reply-To: <20051028100806.GA19507@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Chen, Kenneth W wrote:
>>
>>>Once upon a time, this patch was in -mm tree (2.6.13-mm1):
>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2
>>>
>>>It is neither in Linus's official tree, nor it is in -mm anymore.
>>>
>>>I guess I missed the objection for dropping the patch.  I'm bringing
>>
>>My objection for the patch is that it seems to be designed just to 
>>improve your TPC - and I don't think we've seen results yet... or did 
>>I miss that?
>>
>>Also - by no means do I think improving TPC is wrong, but I think such 
>>a patch may not be the right way to go. It doesn't seem to solve your 
>>problem well.
> 
> 
> Nick, the TPC workload is simple and has been described before: lots of 
> interrupts arriving on many CPUs, and waking up tasks randomly, which do 
> short amount of work and then go back to sleep again. There is no 
> correlation between the CPU the interrupt arrives on and the CPU the 
> task gets woken up on. There is no point in immediate balancing either: 
> the IRQs are well-balanced themselves so there are no load transients to 
> take care of (except for idle CPUs, which my patch handles), and the 
> next wakeup for that task wont arrive on the same CPU anyway.
> 
> in such a workload, my patch will clearly improve things, by not 
> bouncing tasks around wildly.
> 

Ingo, I wasn't aware that tasks are bouncing around wildly; does
your patch improve things? Then by definition it must penalise
workloads where the pairings are more predictable?

I would prefer to try fixing wake balancing before giving up and
turning it off for busy CPUs.

> 
>>Now you may have one of two problems. Well it definitely looks like 
>>you are taking a lot of cache misses in try_to_wake_up - however this 
>>won't be due to the load balancing stuff, but rather from locking the 
>>remote CPUs runqueue and touching its runqueues, and cachelines in the 
>>task_struct that had been last touched by the remote CPU.
> 
> 
> no, because you are not considering a fundamentally random workload like 
> TPC. There is only a 1:8 chance to hit the right CPU with the interrupt, 
> and there is no benefit from moving the task to the CPU it got woken up 
> from. In fact, it hurts by doing pointless migrations.
> 

It doesn't always migrate though. That's the point of all the heuristics.

> my patch adds the rule that we only consider 'fast' migration when 
> provably beneficial: if the target CPU is idle. Any other case will have 
> to go over the 'slow' migration paths.
> 

wrong. There is no way you can "prove" that a migration is beneficial!

> 
>>In fact, if the balancing stuff in try_to_wake_up is working as it 
>>should, then it will result in fewer "remote wakups" because tasks 
>>will be moved to the same CPU that wakes them. Schedstats can tell us 
>>a lot about this, BTW.
> 
> 
> wrong. Even if the balancing stuff in try_to_wake_up is working as it 
> should, it can easily happen that moving a task is not worthwhile: if 
> there is little or no further relationship between the wakeup CPU and 
> the IRQ CPU, i.e. when the migration cost is larger than the 
> relationship-win between the wakeup CPU and the IRQ CPU.
> 
> so for me the decision logic is simple: the balancing code logic is 
> migrating over-eagerly, and this simple and straightforward patch makes 
> it less eager for an important workload class. You are welcome to 
> suggest other approaches, but simply saying "I dont like this" wont 
> bring us further, as the damage on TPC workloads is clearly 
> demonstrated. If this patch hurts other workloads (and please 

Ken mentioned it was worth 2%. Not a bad improvement, but if our
performance "sucks" then it sounds like we need to look elsewhere.

> demonstrate them instead of calling my patch a hammer - the patch has 
> been in -mm for many months already) then simply provide the logic that 
> will do the balancing for those workloads only, without hurting this 
> workload!
> 

No doubt that if it is doing pointless migrations that your patch
prevents, then that will improve performance here. However I'd rather
try to fix the actual balancing code.

Without any form of wake balancing, then a multiprocessor system will
tend to have a completely random distribution of tasks over CPUs over
time. I prefer to add a driver so it is not completely random for
amenable workloads.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
