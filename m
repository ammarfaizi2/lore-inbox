Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286310AbRLJQdY>; Mon, 10 Dec 2001 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286307AbRLJQdQ>; Mon, 10 Dec 2001 11:33:16 -0500
Received: from rj.SGI.COM ([204.94.215.100]:55785 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S286304AbRLJQdG>;
	Mon, 10 Dec 2001 11:33:06 -0500
From: Jack Steiner <steiner@sgi.com>
Message-Id: <200112101633.KAA45958@fsgi055.americas.sgi.com>
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 10 Dec 2001 10:32:59 -0600 (CST)
Cc: steiner@sgi.com (Jack Steiner), linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <3C1343B3.3090304@colorfullife.com> from "Manfred Spraul" at Dec 09, 2001 11:57:55 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >
> >
> >Assuming the slab allocator manages by node, kmem_cache_alloc_node() & 
> >kmem_cache_alloc_cpu() would be identical (exzcept for spelling :-). 
> >Each would pick up the nodeid from the cpu_data struct, then allocate 
> >from the slab cache for that node.
> >
> 
> kmem_cache_alloc is simple - the complex operation is kmem_cache_free.
> 
> The current implementation
> - assumes that virt_to_page() and reading one cacheline from the page 
> structure is fast. Is that true for your setups?
> - uses an array to batch several free calls together: If the array 
> overflows, then up to 120 objects are freed in one call, to reduce 
> cacheline trashing.
> 
> If virt_to_page is fast, then a NUMA allocator would be a simple 
> extention of the current implementation:

I can give you 1 data point. This is for the SGI SN1 platform. This is a NUMA
platform & is running with the DISCONTIGMEM patch that is on sourceforge.

The virt_to_page() function currently generates the following code:

	23 instructions
		18 "real" instructions
		 5 noop (I would like to believe the compiler can eventually
		   use these instructions slots for something else)

The code has
	2 load instructions that are always reference node-local memory & have 
	  a high probability of hitting in the caches
	1 load to the node that contains the target page


I think I see a couple opportunities for reducing the amount of code. However, 
I consider the code to be "fast enough" for most purposes.

> 
> * one slab chain for each node, one spinlock for each node.
> * 2 per-cpu arrays for each cpu: one for "correct node" kmem_cache_free 
> calls , one for "foreign node" kmem_cache_free calls.
> * kmem_cache_alloc allocates from the "correct node" per-cpu array, 
> fallback to the per-node slab chain, then fallback to __get_free_pages.
> * kmem_cache_free checks to which node the freed object belongs and adds 
> it to the appropriate per-cpu array. The array overflow function then 
> sorts the objects into the correct slab chains.
> 
> If virt_to_page is slow we need a different design. Currently it's 
> called in every kmem_cache_free/kfree call.

BTW, I think Tony Luck (at Intel) is currently changing the slab allocator 
to be numa-aware. Are coordinating your work with his???



-- 
Thanks

Jack Steiner    (651-683-5302)   (vnet 233-5302)      steiner@sgi.com

