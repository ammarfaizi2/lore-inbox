Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVCGI2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVCGI2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVCGI2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:28:43 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:43131 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261690AbVCGI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:28:28 -0500
Message-ID: <422C10A7.80002@yahoo.com.au>
Date: Mon, 07 Mar 2005 19:28:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
References: <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com> <422BE7DA.5040304@yahoo.com.au> <20050307000402.A28385@unix-os.sc.intel.com>
In-Reply-To: <20050307000402.A28385@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Nick,
> 
> On Mon, Mar 07, 2005 at 04:34:18PM +1100, Nick Piggin wrote:
> 
>>
>>Active balancing should only kick in after the prescribed number
>>of rebalancing failures - can_migrate_task will see this, and
>>will allow the balancing to take place.
> 
> 
> We are resetting the nr_balance_failed to cache_nice_tries after kicking 
> active balancing. But can_migrate_task will succeed only if
> nr_balance_failed > cache_nice_tries.
> 

It is indeed, thanks for catching that. We should probably make it
reset the count to the point where it will start moving cache hot
tasks (ie. cache_nice_tries+1).

I'll look at that and send Andrew a patch.

> 
>>That said, we currently aren't doing _really_ well for SMT on
>>some workloads, however with this patch we are heading in the
>>right direction I think.
> 
> 
> Lets take an example of three packages with two logical threads each. 
> Assume P0 is loaded with two processes(one in each logical thread), 
> P1 contains only one process and P2 is idle.
> 
> In this example, active balance will be kicked on one of the threads(assume
> thread 0) in P0, which then should find an idle package and move it to 
> one of the idle threads in P2.
> 
> With your current patch, idle package check in active_load_balance has 
> disappeared, and we may endup moving the process from thread 0 to thread 1 
> in P0.  I can't really make logic out of the active_load_balance code 
> after your patch 10/13
> 

Ah yep, right you are there, too. I obviously hadn't looked closely
enough at the recent active_load_balance patches that had gone in :(
What should probably do is heed the "push_cpu" prescription (push_cpu
is now unused).

I think active_load_balance is too complex at the moment, but still
too dumb to really make the right choice here over the full range of
domains. What we need to do is pass in some more info from load_balance,
so active_load_balance doesn't need any "smarts".

Thanks for pointing this out too. I'll make a patch.

> 
>>I have been mainly looking at tuning CMP Opterons recently (they
>>are closer to a "traditional" SMP+NUMA than SMT, when it comes
>>to the scheduler's point of view). However, in earlier revisions
>>of the patch I had been looking at SMT performance and was able
>>to get it much closer to perfect:
>>
> 
> 
> I am reasonably sure that the removal of cpu_and_siblings_are_idle check
> from active_load_balance will cause HT performance regressions.
> 

Yep.

> 
>>I was working on a 4 socket x440 with HT. The problem area is
>>usually when the load is lower than the number of logical CPUs.
>>So on tbench, we do say 450MB/s with 4 or more threads without
>>HT, and 550MB/s with 8 or more threads with HT, however we only
>>do 300MB/s with 4 threads.
> 
> 
> Are you saying 2.6.11 has this problem?
> 

I think so. I'll have a look at it again.

> 
>>Those aren't the exact numbers, but that's basically what they
>>look like. Now I was able to bring the 4 thread + HT case much
>>closer to the 4 thread - HT numbers, but with earlier patchsets.
>>When I get a chance I will do more tests on the HT system, but
>>the x440 is infuriating for fine tuning performance, because it
>>is a NUMA system, but it doesn't tell the kernel about it, so
>>it will randomly schedule things on "far away" CPUs, and results
>>vary.
> 
> 
> Why don't you use any other simple HT+SMP system?
> 

Yes I will, of course. Some issues can become more pronounced
with more physical CPUs, but the main reason is that the x440
is the only one with HT at work where I was doing testing.

To be honest I hadn't looked hard enough at the HT issues yet
as you've noticed. So thanks for the review and I'll fix things
up.

> I will also do some performance analysis with your other patches
> on some of the systems that I have access to.
> 

Thanks.

Nick

