Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTANEro>; Mon, 13 Jan 2003 23:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTANEro>; Mon, 13 Jan 2003 23:47:44 -0500
Received: from franka.aracnet.com ([216.99.193.44]:230 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261568AbTANErm>; Mon, 13 Jan 2003 23:47:42 -0500
Date: Mon, 13 Jan 2003 20:56:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Erich Focht <efocht@ess.nec.de>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Message-ID: <352680000.1042520180@titus>
In-Reply-To: <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8>
References: <52570000.1042156448@flay><200301101734.56182.efocht@ess.nec.de> <967810000.1042217859@titus> <200301130055.28005.efocht@ess.nec.de> <1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com> <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I played with this today on my 4 node (16 CPU) NUMAQ.  Spent most
>> of the time working with the first three patches.  What I found was
>> that rebalancing was happening too much between nodes.  I tried a
>> few things to change this, but have not yet settled on the best
>> approach.  A key item to work with is the check in find_busiest_node
>> to determine if the found node is busier enough to warrant stealing
>> from it.  Currently the check is that the node has 125% of the load
>> of the current node.  I think that, for my system at least, we need
>> to add in a constant to this equation.  I tried using 4 and that
>> helped a little.  
> 
> Michael,
> 
> in:
> 
> +static int find_busiest_node(int this_node)
> +{
> + int i, node = this_node, load, this_load, maxload;
> + 
> + this_load = maxload = atomic_read(&node_nr_running[this_node]);
> + for (i = 0; i < numnodes; i++) {
> +  if (i == this_node)
> +   continue;
> +  load = atomic_read(&node_nr_running[i]);
> +  if (load > maxload && (4*load > ((5*4*this_load)/4))) {
> +   maxload = load;
> +   node = i;
> +  }
> + }
> + return node;
> +}
> 
> You changed ((5*4*this_load)/4) to:
>   (5*4*(this_load+4)/4)
> or
>   (4+(5*4*(this_load)/4))  ?
> 
> We def need some constant to avoid low load ping pong, right?
> 
> Finally I added in the 04 patch, and that helped
>> a lot.  Still, there is too much process movement between nodes.
> 
> perhaps increase INTERNODE_LB?

Before we tweak this too much, how about using the global load 
average for this? I can envisage a situation where we have two
nodes with 8 tasks per node, one with 12 tasks, and one with four.
You really don't want the ones with 8 tasks pulling stuff from
the 12 ... only for the least loaded node to start pulling stuff
later.

What about if we take the global load average, and multiply by
num_cpus_on_this_node / num_cpus_globally ... that'll give us
roughly what we should have on this node. If we're significantly
out underloaded compared to that, we start pulling stuff from
the busiest node? And you get the damping over time for free.

I think it'd be best if we stay fairly conservative for this, all
we're trying to catch is the corner case where a bunch of stuff 
has forked, but not execed, and we have a long term imbalance.
Agressive rebalance might win a few benchmarks, but you'll just
cause inter-node task bounce on others. 

M.

