Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291825AbSBYTDz>; Mon, 25 Feb 2002 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSBYTDp>; Mon, 25 Feb 2002 14:03:45 -0500
Received: from bitmover.com ([192.132.92.2]:1718 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291825AbSBYTD2>;
	Mon, 25 Feb 2002 14:03:28 -0500
Date: Mon, 25 Feb 2002 11:03:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>,
        Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20020225110327.A22497@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>,
	Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de> <20940000.1014663303@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20940000.1014663303@flay>; from Martin.Bligh@us.ibm.com on Mon, Feb 25, 2002 at 10:55:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 10:55:03AM -0800, Martin J. Bligh wrote:
> > - The load_balancing() concept is different:
> > 	- there are no special time intervals for balancing across pool
> > 	boundaries, the need for this can occur very quickly and I
> > 	have the feeling that 2*250ms is a long time for keeping the 
> > 	nodes unbalanced. This means: each time load_balance() is called
> > 	it _can_ balance across pool boundaries (but doesn't have to).
> 
> Imagine for a moment that there's a short spike in workload on one node.
> By agressively balancing across nodes, won't you incur a high cost
> in terms of migrating all the cache data to the remote node (destroying
> the cache on both the remote and local node), when it would be cheaper 
> to wait for a few more ms, and run on the local node?

Great question!  The answer is that you are absolutely right.  SGI tried
a pile of things in this area, both on NUMA and on traditional SMPs (the
NUMA stuff was more page migration and the SMP stuff was more process
migration, but the problems are the same, you screw up the cache).  They
never got the page migration to give them better performance while I was
there and I doubt they have today.  And the process "migration" from CPU
to CPU didn't work either, people tended to lock processes to processors
for exactly the reason you alluded to.

If you read the early hardware papers on SMP, they all claim "Symmetric
Multi Processor", i.e., you can run any process on any CPU.  Skip forward
3 years, now read the cache affinity papers from the same hardware people.
You have to step back and squint but what you'll see is that these papers
could be summarized on one sentence:

	"Oops, we lied, it's not really symmetric at all"

You should treat each CPU as a mini system and think of a process reschedule
someplace else as a checkpoint/restart and assume that is heavy weight.  In
fact, I'd love to see the scheduler code forcibly sleep the process for 
500 milliseconds each time it lands on a different CPU.  Tune the system
to work well with that, then take out the sleep, and you'll have the right
answer.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
