Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRLIK62>; Sun, 9 Dec 2001 05:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRLIK6S>; Sun, 9 Dec 2001 05:58:18 -0500
Received: from colorfullife.com ([216.156.138.34]:43533 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283310AbRLIK6D>;
	Sun, 9 Dec 2001 05:58:03 -0500
Message-ID: <3C1343B3.3090304@colorfullife.com>
Date: Sun, 09 Dec 2001 11:57:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Assuming the slab allocator manages by node, kmem_cache_alloc_node() & 
>kmem_cache_alloc_cpu() would be identical (exzcept for spelling :-). 
>Each would pick up the nodeid from the cpu_data struct, then allocate 
>from the slab cache for that node.
>

kmem_cache_alloc is simple - the complex operation is kmem_cache_free.

The current implementation
- assumes that virt_to_page() and reading one cacheline from the page 
structure is fast. Is that true for your setups?
- uses an array to batch several free calls together: If the array 
overflows, then up to 120 objects are freed in one call, to reduce 
cacheline trashing.

If virt_to_page is fast, then a NUMA allocator would be a simple 
extention of the current implementation:

* one slab chain for each node, one spinlock for each node.
* 2 per-cpu arrays for each cpu: one for "correct node" kmem_cache_free 
calls , one for "foreign node" kmem_cache_free calls.
* kmem_cache_alloc allocates from the "correct node" per-cpu array, 
fallback to the per-node slab chain, then fallback to __get_free_pages.
* kmem_cache_free checks to which node the freed object belongs and adds 
it to the appropriate per-cpu array. The array overflow function then 
sorts the objects into the correct slab chains.

If virt_to_page is slow we need a different design. Currently it's 
called in every kmem_cache_free/kfree call.

--
    Manfred

