Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCHU1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCHU1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHU1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:27:19 -0500
Received: from fmr22.intel.com ([143.183.121.14]:10915 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262106AbVCHTgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:36:54 -0500
Date: Tue, 8 Mar 2005 11:36:31 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
Message-ID: <20050308113630.A13045@unix-os.sc.intel.com>
References: <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com> <422BE7DA.5040304@yahoo.com.au> <20050307000402.A28385@unix-os.sc.intel.com> <422C10A7.80002@yahoo.com.au> <20050307232214.A7715@unix-os.sc.intel.com> <422D5F9B.9070109@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422D5F9B.9070109@yahoo.com.au>; from nickpiggin@yahoo.com.au on Tue, Mar 08, 2005 at 07:17:31PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 07:17:31PM +1100, Nick Piggin wrote:
> Siddha, Suresh B wrote:
> > That still might not be enough. We probably need to pass push_cpu's
> > sd to move_tasks call in active_load_balance, instead of current busiest_cpu's
> > sd. Just like push_cpu, we need to add one more field to the runqueue which 
> > will specify the domain level of the push_cpu at which we have an imbalance.
> > 
> 
> It should be the lowest domain level that spans both this_cpu and
> push_cpu, and has the SD_BALANCE flag set. We could possibly be a bit

I agree.

> more general here, but so long as nobody is coming up with weird and
> wonderful sched_domains schemes, push_cpu should give you all the info
> needed.
> 
> > push_cpu might not be the ideal destination in all cases. Take a NUMA domain
> > above SMT+SMP domains in my above example. Assume P0, P1 is in node-0 and
> > P2, P3 in node-1. Assume Loads of P0,P1,P2 are same as the above example,with P3
> > containing one process load. Now any idle thread in P2 or P3 can trigger
> > active load balance on P0. We should be selecting thread in P2 ideally
> > (currently this is what we get with idle package check). But with push_cpu,
> > we might move to the idle thread in P3 and then finally move to P2(it will be a
> > two step process)
> > 
> 
> Hmm yeah. It is a bit tricky. We don't currently do exceptionally well
> at this sort of "balancing over multiple domains" very well in the
> periodic balancer either.

With periodic balancer, moved tasks will not be actively running
and by the time it gets a cpu slot, it will most probably be on the
correct cpu (though "most probably" is the key word here ;-)

> But at this stage I prefer to not get overly complex, and allow some
> imperfect task movement, because it should rarely be a problem, and is
> much better than it was before. The main place where it can go wrong
> is multi-level NUMA balancing, where moving a task twice (between
> different nodes) can cause more problems.

With active_load_balance, we will be moving the currently running
process. So obviously if we can move in one single step, that will be nice.

I agree with the complexity part though. And it will become more complex
with upcoming dual-core requirements.

thanks,
suresh
