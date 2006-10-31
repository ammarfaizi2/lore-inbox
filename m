Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423544AbWJaQPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423544AbWJaQPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423548AbWJaQPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:15:20 -0500
Received: from main.gmane.org ([80.91.229.2]:14754 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423544AbWJaQPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:15:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rolf Offermanns <roffermanns@gmail.com>
Subject: Re: mmaping a kernel buffer to user space
Date: Tue, 31 Oct 2006 17:10:47 +0100
Message-ID: <ei7si7$1sl$1@sea.gmane.org>
References: <4547150F.8070408@ti.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 62.8.134.2
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo Marcus wrote:
> I recently run with the following situation while developing a PCI
> driver. The driver allocates memory for a PCI device using
> pci_alloc_consistent as this memory is going to be used to perform DMA
> transfers. To pass the data from/to the user application, I mmap the
> buffer into userspace. However, if I try to use remap_pfn_range
> (>=2.6.10) or the older remap_page_range(<=2.6.9) for mmaping, it ends
> up creating a new buffer, because they do not support RAM mapping, then
> pagefaulting to the VMA and by default allocating new pages. Therefore,
> I had to implement the nopage method and mmap one page at a time as they
> fault.
> 
> However, to my point of view, this is unnecessary. The memory is already
> allocated, the memory is locked because it is consistent, and it may be
> a (very small) performance and stability issue to do them one-by-one.
> Why can't I simply mmap it all at once? am I missing some function? More
> important, why can't remap_{pfn/page}_range handle it?
> 
Here is what I did some time ago:

-> Reserve mem at boot time (mem=realmem-size_of_mem_you_need) / bigphysmem 
-> I used the highmem allocator from the LDD2/3 examples to get a pointer
the this reserved memory at runtime.
-> Use ioremap() to remap the memory to kernelspace
-> do some magic (I don't remember the background, sorry) with the vma_flags
in your mmap() function:

        vma->vm_flags |= VM_RESERVED;
        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);      

and then do a remap_pfn_range() as usualy.

HTH,
Rolf


