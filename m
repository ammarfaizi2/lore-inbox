Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTAPUGT>; Thu, 16 Jan 2003 15:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAPUGT>; Thu, 16 Jan 2003 15:06:19 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46738 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267218AbTAPUGS>;
	Thu, 16 Jan 2003 15:06:18 -0500
Date: Thu, 16 Jan 2003 21:19:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
In-Reply-To: <115000000.1042746190@flay>
Message-ID: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Jan 2003, Martin J. Bligh wrote:

> > complex. It's the one that is aware of the global scheduling picture. For
> > NUMA i'd suggest two asynchronous frequencies: one intra-node frequency,
> > and an inter-node frequency - configured by the architecture and roughly
> > in the same proportion to each other as cachemiss latencies.
> 
> That's exactly what's in the latest set of patches - admittedly it's a
> multiplier of when we run load_balance, not the tick multiplier, but
> that's very easy to fix. Can you check out the stuff I posted last
> night? I think it's somewhat cleaner ...

yes, i saw it, it has the same tying between idle-CPU-rebalance and
inter-node rebalance, as Erich's patch. You've put it into
cpus_to_balance(), but that still makes rq->nr_balanced a 'synchronously'
coupled balancing act. There are two synchronous balancing acts currently:
the 'CPU just got idle' event, and the exec()-balancing (*) event. Neither
must involve any 'heavy' balancing, only local balancing. The inter-node
balancing (which is heavier than even the global SMP balancer), should
never be triggered from the high-frequency path. [whether it's high
frequency or not depends on the actual workload, but it can be potentially
_very_ high frequency, easily on the order of 1 million times a second -
then you'll call the inter-node balancer 100K times a second.]

I'd strongly suggest to decouple the heavy NUMA load-balancing code from
the fastpath and re-check the benchmark numbers.

	Ingo

(*) whether sched_balance_exec() is a high-frequency path or not is up to
debate. Right now it's not possible to get much more than a couple of
thousand exec()'s per second on fast CPUs. Hopefully that will change in
the future though, so exec() events could become really fast. So i'd
suggest to only do local (ie. SMP-alike) balancing in the exec() path, and
only do NUMA cross-node balancing with a fixed frequency, from the timer
tick. But exec()-time is really special, since the user task usually has
zero cached state at this point, so we _can_ do cheap cross-node balancing
as well. So it's a boundary thing - probably doing the full-blown
balancing is the right thing.

