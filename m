Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVCGIEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVCGIEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCGIEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:04:23 -0500
Received: from fmr22.intel.com ([143.183.121.14]:7867 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261472AbVCGIEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:04:14 -0500
Date: Mon, 7 Mar 2005 00:04:02 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
Message-ID: <20050307000402.A28385@unix-os.sc.intel.com>
References: <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com> <422BE7DA.5040304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422BE7DA.5040304@yahoo.com.au>; from nickpiggin@yahoo.com.au on Mon, Mar 07, 2005 at 04:34:18PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Mon, Mar 07, 2005 at 04:34:18PM +1100, Nick Piggin wrote:
> Siddha, Suresh B wrote:
> 
> > 
> > By code inspection, I see an issue with this patch
> > 	[PATCH 10/13] remove aggressive idle balancing
> > 
> > Why are we removing cpu_and_siblings_are_idle check from active_load_balance?
> > In case of SMT, we  want to give prioritization to an idle package while
> > doing active_load_balance(infact, active_load_balance will be kicked
> > mainly because there is an idle package) 
> > 
> > Just the re-addition of cpu_and_siblings_are_idle check to 
> > active_load_balance might not be enough. We somehow need to communicate 
> > this to move_tasks, otherwise can_migrate_task will fail and we will 
> > never be able to do active_load_balance.
> > 
> 
> Active balancing should only kick in after the prescribed number
> of rebalancing failures - can_migrate_task will see this, and
> will allow the balancing to take place.

We are resetting the nr_balance_failed to cache_nice_tries after kicking 
active balancing. But can_migrate_task will succeed only if
nr_balance_failed > cache_nice_tries.

> 
> That said, we currently aren't doing _really_ well for SMT on
> some workloads, however with this patch we are heading in the
> right direction I think.

Lets take an example of three packages with two logical threads each. 
Assume P0 is loaded with two processes(one in each logical thread), 
P1 contains only one process and P2 is idle.

In this example, active balance will be kicked on one of the threads(assume
thread 0) in P0, which then should find an idle package and move it to 
one of the idle threads in P2.

With your current patch, idle package check in active_load_balance has 
disappeared, and we may endup moving the process from thread 0 to thread 1 
in P0.  I can't really make logic out of the active_load_balance code 
after your patch 10/13

> 
> I have been mainly looking at tuning CMP Opterons recently (they
> are closer to a "traditional" SMP+NUMA than SMT, when it comes
> to the scheduler's point of view). However, in earlier revisions
> of the patch I had been looking at SMT performance and was able
> to get it much closer to perfect:
> 

I am reasonably sure that the removal of cpu_and_siblings_are_idle check
from active_load_balance will cause HT performance regressions.

> I was working on a 4 socket x440 with HT. The problem area is
> usually when the load is lower than the number of logical CPUs.
> So on tbench, we do say 450MB/s with 4 or more threads without
> HT, and 550MB/s with 8 or more threads with HT, however we only
> do 300MB/s with 4 threads.

Are you saying 2.6.11 has this problem?

> 
> Those aren't the exact numbers, but that's basically what they
> look like. Now I was able to bring the 4 thread + HT case much
> closer to the 4 thread - HT numbers, but with earlier patchsets.
> When I get a chance I will do more tests on the HT system, but
> the x440 is infuriating for fine tuning performance, because it
> is a NUMA system, but it doesn't tell the kernel about it, so
> it will randomly schedule things on "far away" CPUs, and results
> vary.

Why don't you use any other simple HT+SMP system?

I will also do some performance analysis with your other patches
on some of the systems that I have access to.

thanks,
suresh
