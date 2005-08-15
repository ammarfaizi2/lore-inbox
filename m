Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVHOQFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVHOQFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVHOQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:05:39 -0400
Received: from galileo.bork.org ([134.117.69.57]:28343 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S964806AbVHOQFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:05:38 -0400
Date: Mon, 15 Aug 2005 12:05:37 -0400
From: Martin Hicks <mort@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Martin Hicks <mort@sgi.com>,
       Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050815160537.GC13449@localhost>
References: <20050801113913.GA7000@elte.hu> <200508031459.22834.raybry@mpdtxmail.amd.com> <20050803200808.GE8266@wotan.suse.de> <200508051245.59528.raybry@mpdtxmail.amd.com> <20050805214857.GD8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805214857.GD8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Aug 05, 2005 at 11:48:58PM +0200, Andi Kleen wrote:
> On Fri, Aug 05, 2005 at 12:45:58PM -0500, Ray Bryant wrote:
> 
> > discarded.  I think what Martin and I would prefer to see is an interface 
> > that allows one to just get rid of the clean page cache (or at least enough 
> > of it) so that additional mapped page allocations will occur locally to the 
> > node without causing swapping.
> 
> That seems like a very special narrow case. But have you tried if  memhog
> really doesn't work this way?

Yes.  This *is* a very special narrow case.  This doesn't really apply
to a desktop machine, nor to a normal unix server load.

It *does* apply to cleaning up a node (or set of nodes) before running HPC
apps which really need to get local memory to perform correctly.

I'm not suggesting that this is something useful for your average
computer, but it is a feature that would make life a lot easier on big
machines running HPC apps.

The memhog approach works, but it may negatively impact the performance
of other jobs on the same node (by swapping or needlessly forcing the
node into memory reclaim and dirty page writeback).

> > 
> > AFAIK, the number of mapped pages on the node is not exported to user space 
> > (by, for example, /sys).   So there is no good way to size the "slop" to 
> > allow for an existing allocation.  If there was, then using a bound memory 
> > hog would likely be a reasonable replacement for Martin's syscall to release 
> > all free page cache, at least for small to medium sized sized systems.
> 
> I guess it could be exported without too much trouble.

I did this to test out the memhog method.

> > The reason we ended up with a sysctl/syscall (to control the aggressiveness 
> > with which __alloc_pages will try to free page cache before spilling) is that 
> > deciding whether or not  to spend the effort to free up page cache pages on 
> > the local node before  spilling is a workload dependent optimization.   For 
> > an HPC application it is  typically worth the effort to try to free local 
> > node page cache before spilling off node because the program will run 
> > sufficiently long to make the improvement due to getting local storage 
> > dominates the extra cost of doing the page allocation.   For file server 
> > workloads, for example, it is typically important to minimize the time to do 
> > the page allocation; if it turns out to be on a remote node it really doesn't 
> > matter that much.   So it seems to me that we need some way for the 
> > application to tell the system which approach it prefers based on the type of 
> > workload it is -- hence the sysctl or syscall approach.
> 
> Ideally it should just work transparently. Maybe NUMA allocation
> should be a bit more aggressive at cleaning local pages before fallback.
> Problem is that it potentially makes the fast path slow.

This is what we need:  a better level of control over how NUMA
allocations work.  In some cases we *really* would prefer local pages,
even at the cost of page cache.

It does have the potential to make the fast path slower.  Some workloads
are willing to make this sacrifice.

mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
