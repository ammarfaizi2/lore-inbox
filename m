Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTATQmZ>; Mon, 20 Jan 2003 11:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTATQmZ>; Mon, 20 Jan 2003 11:42:25 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57474 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266296AbTATQmX>;
	Mon, 20 Jan 2003 11:42:23 -0500
Date: Mon, 20 Jan 2003 17:56:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <200301201307.55515.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003, Erich Focht wrote:

> Could you please explain your idea? As far as I understand, the SMP
> balancer (pre-NUMA) tries a global rebalance at each call. Maybe you
> mean something different...

yes, but eg. in the idle-rebalance case we are more agressive at moving
tasks across SMP CPUs. We could perhaps do a similar ->nr_balanced logic
to do this 'agressive' balancing even if not triggered from the
CPU-will-be-idle path. Ie. _perhaps_ the SMP balancer could become a bit
more agressive.

ie. SMP is just the first level in the cache-hierarchy, NUMA is the second
level. (lets hope we dont have to deal with a third caching level anytime
soon - although that could as well happen once SMT CPUs start doing NUMA.)  
There's no real reason to do balancing in a different way on each level -
the weight might be different, but the core logic should be synced up.
(one thing that is indeed different for the NUMA step is locality of
uncached memory.)

> > kernelbench is the kind of benchmark that is most sensitive to over-eager
> > global balancing, and since the 2.5.59 ->nr_balanced logic produced the
> > best results, it clearly shows it's not over-eager. hackbench is one that
> > is quite sensitive to under-balancing. Ie. trying to maximize both will
> > lead us to a good balance.
> 
> Yes! Actually the currently implemented nr_balanced logic is pretty
> dumb: the counter reaches the cross-node balance threshold after a
> certain number of calls to intra-node lb, no matter whether these were
> successfull or not. I'd like to try incrementing the counter only on
> unsuccessfull load balances, this would give a clear priority to
> intra-node balancing and a clear and controllable delay for cross-node
> balancing. A tiny patch for this (for 2.5.59) is attached. As the name
> nr_balanced would be misleading for this kind of usage, I renamed it to
> nr_lb_failed.

indeed this approach makes much more sense than the simple ->nr_balanced
counter. A similar approach makes sense on the SMP level as well: if the
current 'busy' rebalancer fails to get a new task, we can try the current
'idle' rebalancer. Ie. a CPU going idle would do the less intrusive
rebalancing first.

have you experimented with making the counter limit == 1 actually? Ie.  
immediately trying to do a global balancing once the less intrusive
balancing fails?

	Ingo



