Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSLaQuy>; Tue, 31 Dec 2002 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLaQuy>; Tue, 31 Dec 2002 11:50:54 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:42880 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263366AbSLaQux>; Tue, 31 Dec 2002 11:50:53 -0500
Date: Tue, 31 Dec 2002 09:04:44 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11CE2C.3000308@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212311500.gBVF0qZ01875@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> I think a much easier way of doing this would be a slight modification to the 
> current pci_pool code: we know it works already.  All that really has to 

The same is true of the slab code, which is a better allocator.  Why should
kernels require an extra allocator, when pci_pool can safely be eliminated on
quite a few systems?


> change is that it should take a struct device instead of a pci_dev and it 
> should call dma_alloc_coherent to get the source memory.  The rest of the pci 
> pool code is mainly about memory management and is well tested and so should 
> remain (much as I'd like to see a mempool implementation).

In that patch, the pci_pool code _does_ remain ... only for use on platforms
where __get_free_pages() memory, used by the slab allocator, can't be used
(at least without a lot of setup work).

You finally got me to look at a the mempool code.  I didn't notice any
code to actually allocate 1/Nth page units; that's delegated to some
other code.  (Except for that "Raced" buglet, where it doesn't delegate,
and uses kfree instead of calling pool->free().)  So that's another reason
it'd not be appropriate to try to use it in this area:  it doesn't solve
the core problem, which is non-wasteful allocation of 1/Nth page units.


> +	BUG_ON(dev->bus != &pci_bus_type);
> +
> +	if (size >= PAGE_SIZE)
> +		return pci_alloc_consistent (pdev, size, handle);
> 
> This would work if just passed to dma_alloc_coherent and drop the check for 
> the pci_bus_type 

True ... though that wouldn't be true on the other branch, where it'd
be choosing some pci_pool based on size (when it gets a way to find a
per-device array of pools).  Do you know for a fact that GCC isn't
smart enough to get rid of that duplicate check?  (I'm curious.)


> +dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags)
> +{
> +	void	*ret;
> +
> +	/* We rely on kmalloc memory being aligned to L1_CACHE_BYTES, to
> +	 * prevent cacheline sharing during DMA.  With dma-incoherent caches,
> +	 * such sharing causes bugs, not just cache-related slowdown.
> +	 */
> +	ret = kmalloc (size, mem_flags | __dma_slab_flags (dev));
> +	if (likely (ret != 0))
> +		*handle = virt_to_phys (ret);
> +	return ret;
> 
> Just can't be done: you can't get consistent memory from kmalloc and you 
> certainly can't use virt_to_phys and expect it to work on IOMMU hardware.

Actually it _can_ be done on x86 and several other common platforms.  (But
"coherent" memory was the agreed terminology change, yes?)  Which is where
that particular code kicks in ... x86, some ppc, sa1111, and uml for now.
No IOMMUs there.

Any system where pci_alloc_consistent() is calling  __get_free_pages(), and
doing no further setup beyond a virt_to_phys() call, is a candidate for having
much simpler allocation of I/O memory.  I could even imagine that being true on
some systems where an "IOMMU" just accelerates I/O (prefetch, cache bypass, etc)
for streaming mappings, and isn't strictly needed otherwise.

- Dave


> James
> 
> 
> 
> 
> 
> 
> 




