Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSLaXyF>; Tue, 31 Dec 2002 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSLaXyF>; Tue, 31 Dec 2002 18:54:05 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:25046 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264939AbSLaXyE>; Tue, 31 Dec 2002 18:54:04 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 31 Dec 2002 16:02:17 -0800
Message-Id: <200301010002.QAA00628@baldur.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Cc: david-b@pacbell.net, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>The existing mempool code can be used to implement this, I believe.  The
>pool->alloc callback is passed an opaque void *, and it returns
>a void * which can point at any old composite caller-defined blob.

	That field is the same for all allocations (its value
is stored in the struct mempool), so you can't use it.

	David's example would work because it happens to store a copy
of the DMA address in the structure being allocated, and the mempool
code currently does not overwrite the contents of any chunks of memory
when it holds a freed chunk to give to out later.

	We could generalize David's technique for other data
structures by using a wrapper to store the DMA address and
adopting the convention of having the DMA allocator initially
stuff the DMA address in the beginning of the chunk being
allocated, like so.


/* Set mempool.alloc to this */
void *dma_mempool_alloc_callback(int gfp_mask, void *mempool_data)
{
	struct dma_pool *dma_pool = mempool_data;
	dma_addr_t dma_addr;
	void *result = dma_pool_alloc(mempool_data, gfp_mask, &dma_addr);
	if (result)
		memcpy(result, dma_addr, sizeof(dma_addr_t));
	return result;
}

/* Set mempool.free to this */
void dma_mempool_free_callback(void *element, void *arg)
{
	struct dma_pool *dma_pool = mempool_data;
	dma_pool_free(dma_pool, element, *(dma_addr_t*) element);
}




void *dma_mempool_alloc(mempool_t *pool, int gfp_mask, dma_addr_t *dma_addr)
{
        void *result = mempool_alloc(pool, gfp_mask);
        if (result)
                memcpy(dma_addr, result, sizeof(dma_addr_t));
        return result;
}

void dma_mempool_free(void *element, mempool_t *pool,
		      struct dma_addr_t dma_addr)
{
        /* We rely on mempool_free not trashing the first
           sizeof(dma_addr_t) bytes of element if it is going to
           give this element to another caller rather than freeing it.
           Currently, the mempool code does not know the size of the
           elements, so this is safe to to do, but it would be nice if
           in the future, we could let the mempool code use some of the
           remaining byte to maintain its free list. */
        memcpy(element, &dma_addr, sizeof(dma_addr_t));
        mempool_free(element, pool);
}



	So, I guess there is no need to change the mempool interface,
at least if we guarantee that mempool is not going to overwrite any
freed memory chunks that it is holding in reserve, although this also
means that there will continue to be a small but unnecessary memory
overhead in the mempool allocator.  I guess that could be addressed
later.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
