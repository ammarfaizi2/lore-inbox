Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTAURec>; Tue, 21 Jan 2003 12:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbTAURec>; Tue, 21 Jan 2003 12:34:32 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:43667 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267131AbTAURea> convert rfc822-to-8bit; Tue, 21 Jan 2003 12:34:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.5.59-A2
Date: Tue, 21 Jan 2003 18:44:08 +0100
User-Agent: KMail/1.4.3
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301211844.08372.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 January 2003 17:56, Ingo Molnar wrote:
> On Mon, 20 Jan 2003, Erich Focht wrote:
> > Could you please explain your idea? As far as I understand, the SMP
> > balancer (pre-NUMA) tries a global rebalance at each call. Maybe you
> > mean something different...
>
> yes, but eg. in the idle-rebalance case we are more agressive at moving
> tasks across SMP CPUs. We could perhaps do a similar ->nr_balanced logic
> to do this 'agressive' balancing even if not triggered from the
> CPU-will-be-idle path. Ie. _perhaps_ the SMP balancer could become a bit
> more agressive.

Do you mean: make the SMP balancer more aggressive by lowering the
125% threshold?

> ie. SMP is just the first level in the cache-hierarchy, NUMA is the second
> level. (lets hope we dont have to deal with a third caching level anytime
> soon - although that could as well happen once SMT CPUs start doing NUMA.)
> There's no real reason to do balancing in a different way on each level -
> the weight might be different, but the core logic should be synced up.
> (one thing that is indeed different for the NUMA step is locality of
> uncached memory.)

We have an IA64 2-level node hierarchy machine with 32 CPUs (NEC
TX7). In the "old" node affine scheduler patch the multilevel feature
was in by different cross-node steal delays (longer if node is further
away). In the current approach we could just add another counter, such
that we call the cross-supernode balancer only if the intra-supernode
balancer failed a few times. No idea whether this helps...

> > Yes! Actually the currently implemented nr_balanced logic is pretty
> > dumb: the counter reaches the cross-node balance threshold after a
> > certain number of calls to intra-node lb, no matter whether these were
> > successfull or not. I'd like to try incrementing the counter only on
> > unsuccessfull load balances, this would give a clear priority to
> > intra-node balancing and a clear and controllable delay for cross-node
> > balancing. A tiny patch for this (for 2.5.59) is attached. As the name
> > nr_balanced would be misleading for this kind of usage, I renamed it to
> > nr_lb_failed.
>
> indeed this approach makes much more sense than the simple ->nr_balanced
> counter. A similar approach makes sense on the SMP level as well: if the
> current 'busy' rebalancer fails to get a new task, we can try the current
> 'idle' rebalancer. Ie. a CPU going idle would do the less intrusive
> rebalancing first.
>
> have you experimented with making the counter limit == 1 actually? Ie.
> immediately trying to do a global balancing once the less intrusive
> balancing fails?

Didn't have time to try and probably won't be able to check this
before the beginning of next week :-( .

Regards,
Erich

