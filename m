Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTG1T4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTG1T4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:56:42 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:11931 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270499AbTG1T4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:56:39 -0400
Date: Mon, 28 Jul 2003 12:55:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <3900670000.1059422153@[10.10.2.4]>
In-Reply-To: <200307280548.53976.efocht@gmx.net>
References: <200307280548.53976.efocht@gmx.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after talking to several people at OLS about the current NUMA
> scheduler the conclusion was:
> (1) it sucks (for particular workloads),
> (2) on x86_64 (embarassingly simple NUMA) it's useless, goto (1).

I really feel there's no point in a NUMA scheduler for the Hammer
style architectures. A config option to turn it off would seem like
a simpler way to go, unless people can see some advantage of the 
full NUMA code? 

The interesting thing is probably whether we want balance on exec
or not ... but that probably applies to UMA SMP as well ...
 
> Fact is that the current separation of local and global balancing,
> where global balancing is done only in the timer interrupt at a fixed
> rate is way too unflexible. A CPU going idle inside a well balanced
> node will stay idle for a while even if there's a lot of work to
> do. Especially in the corner case of one CPU per node this is
> condemning that CPU to idleness for at least 5 ms. 

Surely it'll hit the idle local balancer and rebalance within the node? 
Or are you thinking of a case with 3 tasks on a 4 cpu/node system?

> So x86_64 platforms
> (but not only those!) suffer and whish to switch off the NUMA
> scheduler while keeping NUMA memory management on.

Right - I have a patch to make it a config option (CONFIG_NUMA_SCHED) 
... I'll feed that upstream this week.
 
> The attached patch is a simple solution which
> - solves the 1 CPU / node problem,
> - lets other systems behave (almost) as before,
> - opens the way to other optimisations like multi-level node
>   hierarchies (by tuning the retry rate)
> - simpifies the NUMA scheduler and deletes more lines of code than it
>   adds.

Looks simple, I'll test it out.

> The timer interrupt based global rebalancing might appear to be a
> simple and good idea but it takes the scheduler a lot of
> flexibility. In the patch the global rebalancing is done after a
> certain number of failed attempts to locally balance. The number of
> attempts is proportional to the number of CPUs in the current
> node.

Seems like a good plan.

M.

