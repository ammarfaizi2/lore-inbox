Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbTAJQtK>; Fri, 10 Jan 2003 11:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTAJQtK>; Fri, 10 Jan 2003 11:49:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57059 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264975AbTAJQtJ>; Fri, 10 Jan 2003 11:49:09 -0500
Date: Fri, 10 Jan 2003 08:57:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Minature NUMA scheduler
Message-ID: <967810000.1042217859@titus>
In-Reply-To: <200301101734.56182.efocht@ess.nec.de>
References: <52570000.1042156448@flay> <1042176966.30434.148.camel@kenai> <200301101734.56182.efocht@ess.nec.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Having some sort of automatic node affinity of processes and equal
> node loads in mind (as design targets), we could:
>  - take the minimal NUMA scheduler
>  - if the normal (node-restricted) find_busiest_queue() fails and
>  certain conditions are fulfilled (tried to balance inside own node
>  for a while and didn't succeed, own CPU idle, etc... ???) rebalance
>  over node boundaries (eg. using my load balancer)
> This actually resembles the original design of the node affine
> scheduler, having the cross-node balancing separate is ok and might
> make the ideas clearer.

This seems like the right approach to me, apart from the trigger to
do the cross-node rebalance. I don't believe that has anything to do
with when we're internally balanced within a node or not, it's
whether the nodes are balanced relative to each other. I think we should 
just check that every N ticks, looking at node load averages, and do 
a cross-node rebalance if they're "significantly out".

The definintion of "N ticks" and "significantly out" would be a tunable
number, defined by each platform; roughly speaking, the lower the NUMA
ratio, the lower these numbers would be. That also allows us to wedge
all sorts of smarts in the NUMA rebalance part of the scheduler, such
as moving the tasks with the smallest RSS off node. The NUMA rebalancer
is obviously completely missing from the current implementation, and 
I expect we'd use mainly Erich's current code to implement that. 
However, it's suprising how well we do with no rebalancer at all,
apart from the exec-time initial load balance code.

Another big advantage of this approach is that it *obviously* changes
nothing at all for standard SMP systems (whereas your current patch does),
so it should be much easier to get it accepted into mainline ....

M.
