Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292402AbSBYXfk>; Mon, 25 Feb 2002 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSBYXfc>; Mon, 25 Feb 2002 18:35:32 -0500
Received: from air-2.osdl.org ([65.201.151.6]:8971 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292407AbSBYXew>;
	Mon, 25 Feb 2002 18:34:52 -0500
Subject: Re: [Lse-tech] [rebalance at: do_fork() vs. do_execve()] NUMA
	scheduling
From: Andy Pfiffer <andyp@osdl.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>,
        Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20940000.1014663303@flay>
In-Reply-To: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de> 
	<20940000.1014663303@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 15:35:11 -0800
Message-Id: <1014680112.16358.50.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would be interesting to hear oppinions on initial balancing. What are the
> > pros and cons of balancing at do_fork() or do_execve()? And it would be
> > interesting to learn about other approaches, too...

I worked on a system several years ago that supported single-system
image and shared no memory between nodes (NORMA == NO Remote Memory
Access), but did have a very high performance, low-latency interconnect
(100's of megabytes/sec, a few 10's of ns latency for com startup).

The ratios between CPU Clock Rate / Local Memory / Offboard Memory were
(at a gross level) similar to today's GHz CPU's with on-chip L1,
off-die L2, local dram, wires + state machines + dram on some other
node.

There was initially much debate about load balancing at fork time or at
exec time (static), followed by when and how often to rebalance already
running processes (dynamic).

We eventually chose to statically balance at exec time, using a possibly
stale metric, because we wouldn't have to spend time to create address
space remotely (parent on node A, child on node B), only to have it torn
down a few clocks later by a subsequent exec.  (Our workload consisted
almost entirely of fork+exec rather than fork+fork+fork... ).

The analogy here is that commiting modified dcache lines owned by CPU A
and reheating the cache with them on CPU B, only to throw them away by
an exec a few clocks later may be similar to the "rfork() vs. rexec()"
choice we faced.

If you rebalance do_exec(), you are starting with an empty working set
and a cold cache.

To balance at exec time, we used a separate process that would
periodically query (via a spanning tree) nodes within the "interactive
partition" for their current load average, compute which was the least
loaded (a heuristic that used a combination of factors: cpu utilization,
# of processes, memory utilization, is there a shell over there, etc.),
and then update the nodes (again via a spanning tree) with the current
global opinion as to the least loaded node.

In the context of this discussion, computing the loading metric at
regular intervals *when otherwise idle* would appear to be similar to
the approach we used.

The static inter-node load leveling worked pretty well in practice
(although some said it wasn't much better than pure round-robin across
nodes), and it was non-fatal if the initial node selection was a poor
choice

The main problem was minimizing the storm of inbound rexec()'s when a
sudden burst of activity (say, with a make -j) on multiple nodes at once
could cause N-1 nodes to throw *everything* at the least loaded node.  I
don't think this would be a problem in this case because there is a
single entity making a single choice, not mutiple entities making
multiple choices in isolation.

Dynamic load leveling (moving an entire process from one node to
another) was always problematic for highly interactive workloads and a
rash of complexity issues well off topic from this discussion, but
worked well for long-running CPU bound tasks.

Andy




