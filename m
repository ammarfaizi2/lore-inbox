Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423570AbWJaQdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423570AbWJaQdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423572AbWJaQdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:33:35 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62451 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1423570AbWJaQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:33:34 -0500
Message-ID: <45477ADC.5010305@ti.uni-mannheim.de>
Date: Tue, 31 Oct 2006 17:33:32 +0100
From: Guillermo Marcus <marcus@ti.uni-mannheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Rolf Offermanns <roffermanns@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <ei7si7$1sl$1@sea.gmane.org>
In-Reply-To: <ei7si7$1sl$1@sea.gmane.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

Thanks for your comments. Unfortunately, given some of the platforms we
want to support, I cannot reserve memory at boot time, so I had to find
some other way. Besides, it is anyway interesting to see how to present
a buffer allocated using the DMA interfaces (pci_alloc or dma_alloc) to
the user space.

All the best,
Guillermo

Rolf Offermanns wrote:
> Guillermo Marcus wrote:
>> I recently run with the following situation while developing a PCI
>> driver. The driver allocates memory for a PCI device using
>> pci_alloc_consistent as this memory is going to be used to perform DMA
>> transfers. To pass the data from/to the user application, I mmap the
>> buffer into userspace. However, if I try to use remap_pfn_range
>> (>=2.6.10) or the older remap_page_range(<=2.6.9) for mmaping, it ends
>> up creating a new buffer, because they do not support RAM mapping, then
>> pagefaulting to the VMA and by default allocating new pages. Therefore,
>> I had to implement the nopage method and mmap one page at a time as they
>> fault.
>>
>> However, to my point of view, this is unnecessary. The memory is already
>> allocated, the memory is locked because it is consistent, and it may be
>> a (very small) performance and stability issue to do them one-by-one.
>> Why can't I simply mmap it all at once? am I missing some function? More
>> important, why can't remap_{pfn/page}_range handle it?
>>
> Here is what I did some time ago:
> 
> -> Reserve mem at boot time (mem=realmem-size_of_mem_you_need) / bigphysmem 
> -> I used the highmem allocator from the LDD2/3 examples to get a pointer
> the this reserved memory at runtime.
> -> Use ioremap() to remap the memory to kernelspace
> -> do some magic (I don't remember the background, sorry) with the vma_flags
> in your mmap() function:
> 
>         vma->vm_flags |= VM_RESERVED;
>         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);      
> 
> and then do a remap_pfn_range() as usualy.
> 
> HTH,
> Rolf
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
