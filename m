Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUHMOus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUHMOus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 10:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUHMOus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 10:50:48 -0400
Received: from jade.spiritone.com ([216.99.193.136]:43205 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S265847AbUHMOup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 10:50:45 -0400
Date: Fri, 13 Aug 2004 07:50:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
cc: steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <84960000.1092408633@[10.10.2.4]>
In-Reply-To: <200408121646.50740.jbarnes@engr.sgi.com>
References: <200408121646.50740.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On a NUMA machine, page cache pages should be spread out across the system 
> since they're generally global in nature and can eat up whole nodes worth of 
> memory otherwise.  This can end up hurting performance since jobs will have 
> to make off node references for much or all of their non-file data.
> 
> The patch works by adding an alloc_page_round_robin routine that simply 
> allocates on successive nodes each time its called, based on the value of a 
> per-cpu variable modulo the number of nodes.  The variable is per-cpu to 
> avoid cacheline contention when many cpus try to do page cache allocations at 
> once.

I really don't think this is a good idea - you're assuming there's really
no locality of reference, which I don't think is at all true in most cases.

If we round-robin it ... surely 7/8 of your data (on your 8 node machine)
will ALWAYS be off-node ? I thought we discussed this at KS/OLS - what is
needed is to punt old pages back off onto another node, rather than swapping
them out. That way all your pages are going to be local.

> After dd if=/dev/zero of=/tmp/bigfile bs=1G count=2 on a stock kernel:
> Node 7 MemUsed:         49248 kB
> Node 6 MemUsed:         42176 kB
> Node 5 MemUsed:        316880 kB
> Node 4 MemUsed:         36160 kB
> Node 3 MemUsed:         45152 kB
> Node 2 MemUsed:         50000 kB
> Node 1 MemUsed:         68704 kB
> Node 0 MemUsed:       2426256 kB
> 
> and after the patch:
> Node 7 MemUsed:        328608 kB
> Node 6 MemUsed:        319424 kB
> Node 5 MemUsed:        318608 kB
> Node 4 MemUsed:        321600 kB
> Node 3 MemUsed:        319648 kB
> Node 2 MemUsed:        327504 kB
> Node 1 MemUsed:        389504 kB
> Node 0 MemUsed:        744752 kB

OK, so it obviously does something ... but is the dd actually faster? 
I'd think it's slower ...

M.

PS. I think it prob makes sense to make the *receiving* node's kswapd
do the transfer if possible for work distribution reasons ... however
I'm pretty sure there are some locking assumptions that mean this won't
be easy / possible.

