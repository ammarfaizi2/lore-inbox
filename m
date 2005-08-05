Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbVHEVus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVHEVus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbVHEVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:50:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41941 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263151AbVHEVtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:49:01 -0400
Date: Fri, 5 Aug 2005 23:48:58 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Andi Kleen <ak@suse.de>, Martin Hicks <mort@sgi.com>,
       Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050805214857.GD8266@wotan.suse.de>
References: <20050801113913.GA7000@elte.hu> <200508031459.22834.raybry@mpdtxmail.amd.com> <20050803200808.GE8266@wotan.suse.de> <200508051245.59528.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508051245.59528.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:45:58PM -0500, Ray Bryant wrote:
> > try_to_free_pages should DTRT. That is because we generated a custom zone
> > list only containing nodes in that zone and the zone reclaim only looks
> > into those.
> >
> 
> It may depend on what your definition of DTRT is here.  :-)
> 
> As I understand things, if we have a node that has some mapped memory 
> allocated, and if one starts up a numactl -bind node memhog nodesize-slop so 
> as to clear some clean page cache pages from that node, then unless the 
> "slop" is sized in proportion to the amount of mapped memory used on the 
> node, then the existing mapped memory will get swapped out in order to 
> satisfy the new request.  In addition, clean page-cache pages will get 

The VM should first eat clean pages, but yes at some point it will
swap if you want enough. It has to because it doesn't know how 
to migrate to other nodes.

> discarded.  I think what Martin and I would prefer to see is an interface 
> that allows one to just get rid of the clean page cache (or at least enough 
> of it) so that additional mapped page allocations will occur locally to the 
> node without causing swapping.

That seems like a very special narrow case. But have you tried if  memhog
really doesn't work this way?

> 
> AFAIK, the number of mapped pages on the node is not exported to user space 
> (by, for example, /sys).   So there is no good way to size the "slop" to 
> allow for an existing allocation.  If there was, then using a bound memory 
> hog would likely be a reasonable replacement for Martin's syscall to release 
> all free page cache, at least for small to medium sized sized systems.

I guess it could be exported without too much trouble.

> The reason we ended up with a sysctl/syscall (to control the aggressiveness 
> with which __alloc_pages will try to free page cache before spilling) is that 
> deciding whether or not  to spend the effort to free up page cache pages on 
> the local node before  spilling is a workload dependent optimization.   For 
> an HPC application it is  typically worth the effort to try to free local 
> node page cache before spilling off node because the program will run 
> sufficiently long to make the improvement due to getting local storage 
> dominates the extra cost of doing the page allocation.   For file server 
> workloads, for example, it is typically important to minimize the time to do 
> the page allocation; if it turns out to be on a remote node it really doesn't 
> matter that much.   So it seems to me that we need some way for the 
> application to tell the system which approach it prefers based on the type of 
> workload it is -- hence the sysctl or syscall approach.

Ideally it should just work transparently. Maybe NUMA allocation
should be a bit more aggressive at cleaning local pages before fallback.
Problem is that it potentially makes the fast path slow.


-Andi
