Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSIWSx4>; Mon, 23 Sep 2002 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSIWSxH>; Mon, 23 Sep 2002 14:53:07 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50575 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261396AbSIWSoD>; Mon, 23 Sep 2002 14:44:03 -0400
Date: Mon, 23 Sep 2002 11:47:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <170330281.1032781640@[10.10.2.3]>
In-Reply-To: <200209232038.15039.efocht@ess.nec.de>
References: <200209232038.15039.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, sounds encouraging. So here is my first attempt (attached). You'll
> have to apply it on top of the two NUMA scheduler patches and hack
> SAPICID_TO_PNODE again.
> 
> The patch adds a node_mem[NR_NODES] array to each task. When allocating
> memory (in rmqueue) and freeing it (in free_pages_ok) the number of
> pages is added/subtracted from that array and the homenode is set to
> the node having the largest entry. Is there a better place where to put
> this in (other than rmqueue/free_pages_ok)?
> 
> I have two problems with this approach:
> 1: Freeing memory is quite expensive, as it currently involves finding the
> maximum of the array node_mem[].

Bleh ... why? This needs to be calculated much more lazily than this,
or you're going to kick the hell out of any cache affinity. Can you 
recalc this in the rebalance code or something instead?

> 2: I have no idea how tasks sharing the mm structure will behave. I'd
> like them to run on different nodes (that's why node_mem is not in mm),
> but they could (legally) free pages which they did not allocate and
> have wrong values in node_mem[].

Yes, that really ought to be per-process, not per task. Which means
locking or atomics ... and overhead. Ick.

For the first cut of the NUMA sched, maybe you could just leave page
allocation alone, and do that seperately? or is that what the second 
patch was meant to be?

M.

