Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSLaWd0>; Tue, 31 Dec 2002 17:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLaWd0>; Tue, 31 Dec 2002 17:33:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:26535 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264797AbSLaWdZ>;
	Tue, 31 Dec 2002 17:33:25 -0500
Message-ID: <3E121D28.47282D77@digeo.com>
Date: Tue, 31 Dec 2002 14:41:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: david-b@pacbell.net, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update)
References: <200212312202.OAA10841@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 22:41:44.0550 (UTC) FILETIME=[CB767060:01C2B11D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> David Brownell wrote:
> 
> >struct dma_pool *dma_pool_create(char *, struct device *, size_t)
> >void dma_pool_destroy (struct dma_pool *pool)
> >void *dma_pool_alloc(struct dma_pool *, int mem_flags, dma_addr_t *)
> >void dma_pool_free(struct dma_pool *, void *, dma_addr_t)
> 
>         I would like to be able to have failure-free, deadlock-free
> blocking memory allocation, such as we have with the non-DMA mempool
> library so that we can guarantee that drivers that have been
> successfully initialized will continue to work regardless of memory
> pressure, and reduce error branches that drivers have to deal with.
> 
>         Such a facility could be layered on top of your interface
> perhaps by extending the mempool code to pass an extra parameter
> around.  If so, then you should think about arranging your interface
> so that it could be driven with as little glue as possible by mempool.
> 

What is that parameter?  The size, I assume.   To do that you'd
need to create different pools for different allocation sizes.

Bear in mind that mempool only makes sense with memory objects
which have the special characteristic that "if you wait long enough,
someone will free one".  ie: BIOs, nfs requests, etc.   Probably,
DMA buffers fit into that picture as well.

If anything comes out of this discussion, please let it be the 
removal of the hard-wired GFP_ATOMIC in dma_alloc_coherent.  That's
quite broken - the interface should (always) be designed so that the
caller can pass in the gfp flags (__GFP_WAIT,__GFP_IO,__GFP_FS, at least)
