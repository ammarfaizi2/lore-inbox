Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLaR5P>; Tue, 31 Dec 2002 12:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSLaR5O>; Tue, 31 Dec 2002 12:57:14 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:20430 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264624AbSLaR5N>; Tue, 31 Dec 2002 12:57:13 -0500
Date: Tue, 31 Dec 2002 10:11:50 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11DDE6.7050601@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212311723.gBVHNS502319@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> David Brownell said:
> 
>>The same is true of the slab code, which is a better allocator.  Why
>>should kernels require an extra allocator, when pci_pool can safely be
>>eliminated on quite a few systems? 
> 
> 
> I agree in principle.  But the way to get this to work is to allow the slab 
> allocater to specify its getpages and freepages in the same way as ctor and 
> dtor, so it can be fed by dma_alloc_coherent.  Then you can wrapper the slab 
> allocator to be used across all platforms (rather than only those which are 
> coherent and have no IOMMU).

Nobody's done that yet, and it's been a couple years now since that point
was made as a desirable evolution path for pci_pool.  In fact the first
(only!) step on that path was the dma_pool update I just posted.

Modifying the slab allocator like that means passing extra parameters around
(for dma_addr_t), causing extra register pressure even for non-dma allocations.
I have a hard time seeing that not slow things down, even on x86 (etc) where
we know we can already get all the benefits of the slab allocator without any
changes to that critical code.


> The benefit mempool has over slab is its guaranteed minimum pool size and 
> hence guaranteed non-failing allocations as long as you manage pool resizing 
> correctly.  I suppose this is primarily useful for storage devices, which 
> sometimes need memory that cannot be obtained from doing I/O.

Yes:  not all drivers need (or want) such a memory-reservation layer.


> However, you can base mempool off slab modified to use dma_alloc_coherent() 
> and get the benefits of everything.

I'd say instead that drivers which happen to need the protection against
failures that mempool provides can safely layer that behavior on top of
any allocator they want.  (Modulo that buglet, which requires them to be
layered on top of kmalloc.)

Which means that the mempool discussion is just a detour, it's not an
implementation tool for any kind of dma_pool but is instead an option
for drivers (in block i/o paths) to use on top of a dma_pool allocator.

- Dave


