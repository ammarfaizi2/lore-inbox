Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272915AbTG3PrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272935AbTG3PrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:47:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21482 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S272915AbTG3PrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:47:09 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Erich Focht <efocht@hpce.nec.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Wed, 30 Jul 2003 10:44:46 -0500
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <200307290833.05216.habanero@us.ibm.com> <200307301723.55148.efocht@hpce.nec.com>
In-Reply-To: <200307301723.55148.efocht@hpce.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301044.46228.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 10:23, Erich Focht wrote:
> On Tuesday 29 July 2003 15:33, Andrew Theurer wrote:
> > > The fact that global rebalances are done only in the timer interrupt
> > > is simply bad!
> >
> > Even with this patch it still seems that most balances are still timer
> > based, because we still call load_balance in rebalance_tick.  Granted, we
> > may inter-node balance more often, well, maybe less often since
> > node_busy_rebalance_tick was busy_rebalance_tick*2.  I do see the
> > advantage of doing this at idle, but idle only, that's why I'd would be
> > more inclined a only a much more aggressive idle rebalance.
>
> Without this patch the probability to globally balance when going idle
> is 0. Now it is 1/global_balance_rate(cpus_in_this_node) . This is
> tunable and we can make this probability depending on the node load
> imbalance. I'll try that in the next version, it sounds like a good
> idea. Also changing this probability by some factor could give us a
> way to handle the differences between the platforms.
>
> Balancing globally only when idle isn't a good idea as long as we
> don't have multiple steals per balance attempt. Even then, tasks don't
> live all the same time, so you easilly end up with one node overloaded
> and others just busy and not able to steal from the busiest node.

I think I would agree with this statements.  Yes, your patch does fix the 
"going idle" AMD issue, and yes, we don't want to balance globally on idle by 
default.  However I do still think there may be a better way to solve this.  

I see this as "range" problem.  When balancing, the NUMA scheduler's tactic is 
to limit the range of cpus to find a busiest queue.  First we start with 
within a node, then once in a while we go to the next "level", and look at 
cpus in all nodes in that "level".  Someday we may even go up another "level" 
and include even more cpus in our range.  We limit how often we go up a 
level, as to help memory locality of the running tasks.  This is obviously 
well known to you, since you wrote most of this :)   What I would like to 
propose is the following:

For load_balance, each architecture tells the scheduler what the range is, 
where the range starts, and where it ends.  For ex: Summit starts at level1, 
the cpus in a node, and ends at level2, cpus in all level1 nodes.  AMD starts 
at level2, all the cpus in all level1 nodes and also ends at the level2.  
8-way AMD would go to level3 :)  NEC (I assume) would start at the level1, 
and end at level3, the "super" nodes.  This should solve the AMD problem very 
easily. 

As for idle balances, we may be able to go a step further: follow the range 
rules, but do a more aggressive/frequent search.  On busy rebalance, I'd 
prefer to still uphold the node_rebalance_ticks, but on idle, I would think, 
since we are idle, some more time spent on a thorough search would be OK:  We 
first start at the lower range and try to find something to steal (always 
favor stealing a smaller range first), then as needed increase the range, 
looking for a cpu to steal from.  Do not use a node_idle_rebalance interval, 
just keep increasing the range until we are successful.

I'll see if I can get something coded up here.  I don't think these concepts 
would be too difficult to add.

-Andrew Theurer
