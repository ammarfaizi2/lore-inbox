Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTG2CY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271228AbTG2CY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:24:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30653 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270439AbTG2CYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:24:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Date: Mon, 28 Jul 2003 21:24:28 -0500
User-Agent: KMail/1.4.3
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <200307282218.19578.efocht@hpce.nec.com> <3904530000.1059424676@[10.10.2.4]>
In-Reply-To: <3904530000.1059424676@[10.10.2.4]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307282124.28378.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 15:37, Martin J. Bligh wrote:
> > But the Hammer is a NUMA architecture and a working NUMA scheduler
> > should be flexible enough to deal with it. And: the corner case of 1
> > CPU per node is possible also on any other NUMA platform, when in some
> > of the nodes (or even just one) only one CPU is configured in. Solving
> > that problem automatically gives the Hammer what it needs.

I am going to ask a silly question, do we have any data showing this really is 
a problem on AMD?  I would think, even if we have an idle cpu, sometimes a 
little delay on task migration (on NUMA) may not be a bad thing.   If it is 
too long, can we just make the rebalance ticks arch specific?  

I'd much rather have info related to the properties of the NUMA arch than 
something that makes decisions based on nr_cpus_node().  For example, we may 
want to inter-node balance as much or more often on ppc64 than even AMD, but 
it has 8 cpus per node.  On this patch it would has the lowest inter-node 
balance frequency, even though it probably has one of the lowest latencies 
between nodes and highest throughput interconnects.  

> OK, well what we have now is a "multi-cpu-per-node-numa-scheduler" if
> you really want to say all that ;-)
>
> The question is "does Hammer benefit from the additional complexity"?
> I'm guessing not ... if so, then yes, it's worth fixing. If not, it
> would seem better to just leave it at SMP for the scheduler stuff.
> Simpler, more shared code with common systems.
>
> >> > Fact is that the current separation of local and global balancing,
> >> > where global balancing is done only in the timer interrupt at a fixed
> >> > rate is way too unflexible. A CPU going idle inside a well balanced
> >> > node will stay idle for a while even if there's a lot of work to
> >> > do. Especially in the corner case of one CPU per node this is
> >> > condemning that CPU to idleness for at least 5 ms.
> >>
> >> Surely it'll hit the idle local balancer and rebalance within the node?
> >> Or are you thinking of a case with 3 tasks on a 4 cpu/node system?
> >
> > No, no, the local load balancer just doesn't make sense now if you
> > have one cpu per node. It is called although it will never find
> > another cpu in the own cell to steal from. There just is nothing
> > else... (or did I misunderstand your comment?)
>
> Right, I realise that the 1 cpu per node case is broken. However, doesn't
> this also affect the multi-cpu per node case in the manner I suggested
> above? So even if we turn off NUMA scheduler for Hammer, this still
> needs fixing, right?

Maybe so, but if we start making idle rebalance more aggressive, I think we 
would need to make CAN_MIGRATE more restrictive, taking memory placement of 
the tasks in to account.  On AMD with interleaved memory allocation, tasks 
would move very easily, since their memory is spread out anyway.  On "home 
node" or node-local policy, we may not move a task (or maybe not on the first 
attempt), even if there is an idle cpu in another node.  

>> That's one way, but the proposed patch just solves the problem (in a
>> more general way, also for other NUMA cases). If you deconfigure NUMA
>> for a NUMA platform, we'll have problems switching it back on when
>> adding smarter things like node affine or homenode extensions.
>
>Yeah, maybe. I'd rather have the code in hand that needs it, but still ...
>if Andi's happy that fixes it, then we're OK.

Personally, I'd like to see all systems use NUMA sched, non NUMA systems being 
a single node (no policy difference from non-numa sched), allowing us to 
remove all NUMA ifdefs.  I think the code would be much more readable.

-Andrew Theurer
