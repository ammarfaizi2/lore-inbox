Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCHISY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCHISY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVCHISY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:18:24 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:60767 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261862AbVCHIRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:17:45 -0500
Message-ID: <422D5F9B.9070109@yahoo.com.au>
Date: Tue, 08 Mar 2005 19:17:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
References: <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com> <422BE7DA.5040304@yahoo.com.au> <20050307000402.A28385@unix-os.sc.intel.com> <422C10A7.80002@yahoo.com.au> <20050307232214.A7715@unix-os.sc.intel.com>
In-Reply-To: <20050307232214.A7715@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Nick,
> 
> On Mon, Mar 07, 2005 at 07:28:23PM +1100, Nick Piggin wrote:
> 
>>Siddha, Suresh B wrote:
>>
>>>We are resetting the nr_balance_failed to cache_nice_tries after kicking 
>>>active balancing. But can_migrate_task will succeed only if
>>>nr_balance_failed > cache_nice_tries.
>>>
>>
>>It is indeed, thanks for catching that. We should probably make it
>>reset the count to the point where it will start moving cache hot
>>tasks (ie. cache_nice_tries+1).
> 
> 
> That still might not be enough. We probably need to pass push_cpu's
> sd to move_tasks call in active_load_balance, instead of current busiest_cpu's
> sd. Just like push_cpu, we need to add one more field to the runqueue which 
> will specify the domain level of the push_cpu at which we have an imbalance.
> 

It should be the lowest domain level that spans both this_cpu and
push_cpu, and has the SD_BALANCE flag set. We could possibly be a bit
more general here, but so long as nobody is coming up with weird and
wonderful sched_domains schemes, push_cpu should give you all the info
needed.

>>Ah yep, right you are there, too. I obviously hadn't looked closely
>>enough at the recent active_load_balance patches that had gone in :(
>>What should probably do is heed the "push_cpu" prescription (push_cpu
>>is now unused).
> 
> 
> push_cpu might not be the ideal destination in all cases. Take a NUMA domain
> above SMT+SMP domains in my above example. Assume P0, P1 is in node-0 and
> P2, P3 in node-1. Assume Loads of P0,P1,P2 are same as the above example,with P3
> containing one process load. Now any idle thread in P2 or P3 can trigger
> active load balance on P0. We should be selecting thread in P2 ideally
> (currently this is what we get with idle package check). But with push_cpu,
> we might move to the idle thread in P3 and then finally move to P2(it will be a
> two step process)
> 

Hmm yeah. It is a bit tricky. We don't currently do exceptionally well
at this sort of "balancing over multiple domains" very well in the
periodic balancer either.

But at this stage I prefer to not get overly complex, and allow some
imperfect task movement, because it should rarely be a problem, and is
much better than it was before. The main place where it can go wrong
is multi-level NUMA balancing, where moving a task twice (between
different nodes) can cause more problems.

Nick

