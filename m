Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293437AbSBYT0j>; Mon, 25 Feb 2002 14:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293438AbSBYT0a>; Mon, 25 Feb 2002 14:26:30 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17420 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293437AbSBYT0V>; Mon, 25 Feb 2002 14:26:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Feb 2002 11:28:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>,
        Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        <lse-tech@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020225110327.A22497@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202251121390.1499-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Larry McVoy wrote:

> On Mon, Feb 25, 2002 at 10:55:03AM -0800, Martin J. Bligh wrote:
> > > - The load_balancing() concept is different:
> > > 	- there are no special time intervals for balancing across pool
> > > 	boundaries, the need for this can occur very quickly and I
> > > 	have the feeling that 2*250ms is a long time for keeping the
> > > 	nodes unbalanced. This means: each time load_balance() is called
> > > 	it _can_ balance across pool boundaries (but doesn't have to).
> >
> > Imagine for a moment that there's a short spike in workload on one node.
> > By agressively balancing across nodes, won't you incur a high cost
> > in terms of migrating all the cache data to the remote node (destroying
> > the cache on both the remote and local node), when it would be cheaper
> > to wait for a few more ms, and run on the local node?
>
> Great question!  The answer is that you are absolutely right.  SGI tried
> a pile of things in this area, both on NUMA and on traditional SMPs (the
> NUMA stuff was more page migration and the SMP stuff was more process
> migration, but the problems are the same, you screw up the cache).  They
> never got the page migration to give them better performance while I was
> there and I doubt they have today.  And the process "migration" from CPU
> to CPU didn't work either, people tended to lock processes to processors
> for exactly the reason you alluded to.
>
> If you read the early hardware papers on SMP, they all claim "Symmetric
> Multi Processor", i.e., you can run any process on any CPU.  Skip forward
> 3 years, now read the cache affinity papers from the same hardware people.
> You have to step back and squint but what you'll see is that these papers
> could be summarized on one sentence:
>
> 	"Oops, we lied, it's not really symmetric at all"
>
> You should treat each CPU as a mini system and think of a process reschedule
> someplace else as a checkpoint/restart and assume that is heavy weight.  In
> fact, I'd love to see the scheduler code forcibly sleep the process for
> 500 milliseconds each time it lands on a different CPU.  Tune the system
> to work well with that, then take out the sleep, and you'll have the right
> answer.

I made this test on 8 way NUMA machines ( thx to OSDLAB ). When a CPUs
went idle i let it sample the status/load of the system with 100HZ
frequency and i had a variable trigger time derivate that fired a task
steal if a certain load was observed on the same CPU for a time > K ms
I tested it with kernel builds and surprisingly enough having the idle to
observe a load for more than 60ms was a performance loss on these
machines. The moral of the story is:

	"Cache trashing wheighs but wasted CPU time too ..."




- Davide


