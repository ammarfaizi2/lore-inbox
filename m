Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCHHYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCHHYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVCHHYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:24:23 -0500
Received: from fmr24.intel.com ([143.183.121.16]:30411 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261858AbVCHHX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:23:29 -0500
Date: Mon, 7 Mar 2005 23:22:15 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
Message-ID: <20050307232214.A7715@unix-os.sc.intel.com>
References: <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com> <422BE7DA.5040304@yahoo.com.au> <20050307000402.A28385@unix-os.sc.intel.com> <422C10A7.80002@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422C10A7.80002@yahoo.com.au>; from nickpiggin@yahoo.com.au on Mon, Mar 07, 2005 at 07:28:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Mon, Mar 07, 2005 at 07:28:23PM +1100, Nick Piggin wrote:
> Siddha, Suresh B wrote:
> > We are resetting the nr_balance_failed to cache_nice_tries after kicking 
> > active balancing. But can_migrate_task will succeed only if
> > nr_balance_failed > cache_nice_tries.
> > 
> 
> It is indeed, thanks for catching that. We should probably make it
> reset the count to the point where it will start moving cache hot
> tasks (ie. cache_nice_tries+1).

That still might not be enough. We probably need to pass push_cpu's
sd to move_tasks call in active_load_balance, instead of current busiest_cpu's
sd. Just like push_cpu, we need to add one more field to the runqueue which 
will specify the domain level of the push_cpu at which we have an imbalance.

> 
> I'll look at that and send Andrew a patch.
> 
> > 
> >>That said, we currently aren't doing _really_ well for SMT on
> >>some workloads, however with this patch we are heading in the
> >>right direction I think.
> > 
> > 
> > Lets take an example of three packages with two logical threads each. 
> > Assume P0 is loaded with two processes(one in each logical thread), 
> > P1 contains only one process and P2 is idle.
> > 
> > In this example, active balance will be kicked on one of the threads(assume
> > thread 0) in P0, which then should find an idle package and move it to 
> > one of the idle threads in P2.
> > 
> > With your current patch, idle package check in active_load_balance has 
> > disappeared, and we may endup moving the process from thread 0 to thread 1 
> > in P0.  I can't really make logic out of the active_load_balance code 
> > after your patch 10/13
> > 
> 
> Ah yep, right you are there, too. I obviously hadn't looked closely
> enough at the recent active_load_balance patches that had gone in :(
> What should probably do is heed the "push_cpu" prescription (push_cpu
> is now unused).

push_cpu might not be the ideal destination in all cases. Take a NUMA domain
above SMT+SMP domains in my above example. Assume P0, P1 is in node-0 and
P2, P3 in node-1. Assume Loads of P0,P1,P2 are same as the above example,with P3
containing one process load. Now any idle thread in P2 or P3 can trigger
active load balance on P0. We should be selecting thread in P2 ideally
(currently this is what we get with idle package check). But with push_cpu,
we might move to the idle thread in P3 and then finally move to P2(it will be a
two step process)

thanks,
suresh
