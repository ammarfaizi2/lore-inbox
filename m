Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293562AbSBZKdp>; Tue, 26 Feb 2002 05:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293565AbSBZKdg>; Tue, 26 Feb 2002 05:33:36 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:24807 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S293562AbSBZKdR>; Tue, 26 Feb 2002 05:33:17 -0500
Date: Tue, 26 Feb 2002 11:33:14 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20940000.1014663303@flay>
Message-ID: <Pine.LNX.4.21.0202261028370.2830-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Martin J. Bligh wrote:

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
> to wait for a few more ms, and run on the local node? This is a 
> non-trivial problem to solve, and I'm not saying either approach is
> correct, just that there are some disadvantages of being too agressive.
> Perhaps it's architecture dependant (I'm used to NUMA-Q, which has 
> caches on the interconnect, and a cache-miss access speed ratio of 
> about 20:1 remote:local).

Well, maybe my description was a little bit misleading. My approach is not
balancing much more aggressively, the difference is actually minimal,
e.g. for 1ms ticks:

Mike's approach:
- idle CPU : load_balance()     every 1ms    (only within local node)
             balance_cpu_sets() every 2ms    (balance across nodes)
- busy CPU : load_balance()     every 250ms
             balance_cpu_sets() every 500ms
- schedule() : load_balance() if idle        (only within local node)

Erich's approach:
- idle CPU : load_balance() every 1ms   (first try balancing the local 
                            node, if already balanced (no CPU exceeds the
                            current load by >25%) try to find a remote
                            node with larger load than on the current one
                            (>25% again)).
- busy CPU : load_balance() every 250ms (same comment as above)
- schedule() : load_balance() if idle (same comment as above).

So the functional difference is not really that big here, I am also trying
to balance locally first. If that fails (no imbalance), I try
globally. The factor of 2 in the times is not so relevant, I think, and
also I don't consider my approach significantly more aggressive.

More significant is the difference in the data used for the balance
decision:

Mike: calculate load of a particular cpu set in the corresponding
load_balance() call.
        Advantage: cheap (if spinlocks don't hurt there)
        Disadvantage: for busy CPUs it can be really old (250ms)

Erich: calculate load when needed, at the load_balance() call, but not
more than needed (normally only local node data, global data if needed,
all lockless).
        Advantage: fresh, lockless
        Disadvantage: sometimes slower (when balancing across nodes)

As Mike has mainly the cache affinity in mind, it doesn't really matter
where a task is scheduled as long as it stays there long enough and the
nodes are well balanced. A wrong scheduling decision (based on old
data) will be fixed sooner or later (after x*250ms or so).

My problem is that I need to decide on the home node of a process and will
allocate all of its memory on that node. Therefore the decision must be as
good as possible, I really want to keep the task as near to the home node
as possible. If a task gets away from its home node (because of imbalance
between the nodes) the scheduler will try to return it. Of course this
should give us less load on the crossbar between the nodes and best memory
access latency.


> Presumably exec-time balancing is cheaper, since there are fewer shared
> pages to be bounced around between nodes, but less effective if the main
> load on the machine is one large daemon app, which just forks a few copies
> of itself ... I would have though that'd get sorted out a little later anyway
> by the background rebalancing though?

OK, thanks. I agree with the first part of your reply. The last sentence
is true for Mike's approach but a bit more complicated with the boundary
condition of a process having its memory allocated on a particular node...

Thank you very much for your comments!

Best regards,
Erich

