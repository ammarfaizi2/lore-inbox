Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUGPXjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUGPXjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUGPXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 19:39:23 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19403 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266631AbUGPXjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 19:39:21 -0400
Message-ID: <40F86677.2070607@comcast.net>
Date: Fri, 16 Jul 2004 16:36:23 -0700
From: "Amit D. Chaudhary" <amit_c@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net, linux-kernel@vger.kernel.org
Subject: Re: MAX_DMA_ADDRESS in include/asm/asm-i386/dma.h (2.6.x and 2.4.x)
References: <40F84A87.5050403@comcast.net> <20040716214721.GA20741@plexity.net> <40F852AE.8060703@comcast.net> <20040716222859.GA21647@plexity.net>
In-Reply-To: <20040716222859.GA21647@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Deepak Saxena wrote:
> On Jul 16 2004, at 15:11, Amit D. Chaudhary was caught saying:
> 
>>Deepak,
>>
>>I am missing what you are directing me to.
>>
>>If it is,
>>pci_alloc_consistent(), linux-2.4.25/arch/i386/kernel/pci-dma.c
>>dma_alloc_coherent(), linux-2.6.8-rc1/arch/i386/kernel/pci-dma.c
>>
>>They internally seem to __get_free_pages()
> 
> 
> Correct, but take a second look at the code (2.6):
> 
>         void *ret;
>         /* ignore region specifiers */
>         gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
> 
>         if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
>                 gfp |= GFP_DMA;
> 
>         ret = (void *)__get_free_pages(gfp, get_order(size));
> 
> It uses GFP_DMA iff your coherent_dma_mask is != 0xffffffff.  Assuming
> your device can address a the full 32-bit PCI address space, you
> need to set the coherent_dma_mask appropriately and you will get
> buffers from all addressable lowmem. I don't do much x86, so not
> sure how you go about allocating highmem DMA buffers.
Thanks, noted and verified.

This chip cannot DMA with a memory buffer returned by kmalloc without a 
GFP_DMA flag, that is memory addresses like 0xf67e0000, it works with 
0xcxxx xxxx.

I verified it by modifying the code and trying it out.

>>The memory need not be page size, as a matter of fact, using a large 
>>consecutive block, for example using alloc_bootmem_low() during kernel 
>>bootup, will simplify the data transfer and result in no internal 
>>fragmentation, it does introduce inflexibility in changing the size and 
>>other issues.
> 
> 
> If you are using alloc_bootmem_low(), all you should have to do after
> allocating the memory is call pci_dma_map_single()/map_sg() to get PCI-DMA 
> addresses. You still should have no reason to touch MAX_DMA_ADDRESS.
This was a backup approach, I mentioned to provide details about the 
memory being allocated. I would like to avoid this approach. See reasons 
above.

Amit
