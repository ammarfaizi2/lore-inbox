Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSLaXJG>; Tue, 31 Dec 2002 18:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSLaXJG>; Tue, 31 Dec 2002 18:09:06 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:47298 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264907AbSLaXJF>; Tue, 31 Dec 2002 18:09:05 -0500
Date: Tue, 31 Dec 2002 15:23:43 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: Andrew Morton <akpm@digeo.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Message-id: <3E1226FF.9010407@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212312202.OAA10841@adam.yggdrasil.com>
 <3E121D28.47282D77@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>        Such a facility could be layered on top of your interface
>>perhaps by extending the mempool code to pass an extra parameter
>>around.  If so, then you should think about arranging your interface
>>so that it could be driven with as little glue as possible by mempool.
>>
> 
> 
> What is that parameter?  The size, I assume.   To do that you'd
> need to create different pools for different allocation sizes.

In the other allocators it'd be the dma_addr_t for the memory
being returned ...

I don't think the mempool stuff needs that, see the fragments below.


> Bear in mind that mempool only makes sense with memory objects
> which have the special characteristic that "if you wait long enough,
> someone will free one".  ie: BIOs, nfs requests, etc.   Probably,
> DMA buffers fit into that picture as well.Inside the USB host controller drivers I think that mostly applies
to transfer descriptors (tds), which are freed when some other request
completes.  An 8K buffer takes  1 (ehci), 2 (ohci) or 128 (uhci)
of those, and as you know scatterlists can queue quite a few pages.

I'd imagine mempool based td allocation might go like this; it should
be easy enough to slip into most of the HCDs:

	void *mempool_alloc_td (int mem_flags, void *pool)
	{
		struct td *td;
		dma_addr_t dma;

		td = dma_pool_alloc (pool, mem_flags, &dma);
		if (!td)
			return td;
		td->td_dma = dma;	/* feed to the hardware */
		... plus other init
		return td;
	}

	void mempool_free_td (void *_td, void *pool)
	{
		struct td *td = _td;

		dma_pool_free (pool, td, td->dma);
	}

USB device drivers tend to either allocate and reuse one dma buffer
(kmalloc/kfree usage pattern) or use dma mapping ... so far.

- Dave


