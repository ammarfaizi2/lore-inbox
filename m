Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUGAMqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUGAMqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUGAMqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:46:46 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:64466 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S264819AbUGAMqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:46:36 -0400
Message-ID: <40E406DB.8080909@hp.com>
Date: Thu, 01 Jul 2004 08:43:07 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] on-chip coherent memory API for DMA
References: <1088518868.1862.18.camel@mulgrave>
In-Reply-To: <1088518868.1862.18.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>The purpose of this API is to find a way of declaring on-chip memory as
>a pool for dma_alloc_coherent() that can be useful to all architectures.
>
>The proposed API is:
>
>nt dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
>dma_addr_t device_addr, size_t size, int flags)
>
>This API basically declares a region of memory to be handed out by
>dma_alloc_coherent when it's asked for coherent memory for this device.
>
>bus_addr is the physical address to which the memory is currently
>assigned in the bus responding region
>
>device_addr is the physical address the device needs to be programmed
>with actually to address this memory.
>
>size is the size of the area (must be multiples of PAGE_SIZE).
>
>The flags is where all the magic is.  They can be or'd together and are
>
>DMA_MEMORY_MAP - request that the memory returned from
>dma_alloc_coherent() be directly writeable.
>
>DMA_MEMORY_IO - request that the memory returned from
>dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.
>
>One or both of these flags must be present
>
>DMA_MEMORY_INCLUDES_CHILDREN - make the declared memory be allocated by
>dma_alloc_coherent of any child devices of this one (for memory residing
>on a bridge).
>
>DMA_MEMORY_EXCLUSIVE - only allocate memory from the declared regions. 
>Do not allow dma_alloc_coherent() to fall back to system memory when
>it's out of memory in the declared region.
>
>The return value would be either DMA_MEMORY_MAP or DMA_MEMORY_IO and
>must correspond to a passed in flag (i.e. no returning DMA_MEMORY_IO if
>only DMA_MEMORY_MAP were passed in) or zero for failure.
>
>I think also, it's reasonable only to have a single declared region per
>device.
>
>Implementation details
>
>Obviously, the big change is that dma_alloc_coherent() may now be
>handing out memory that can't be directly written to (in the case of a
>DMA_MEMORY_IO return).
>
>I envisage implementing an internal per device resource allocator in
>drivers/base into which each platform allocator can plug do do the heavy
>allocation lifting (they'd still get to do the platform magic to make
>the returned region visible as memory if necessary).
>
>The API would be platform optional, with platforms not wishing to
>implement it simply hard coding a return 0.
>
>There would also be a corresponding
>
>void dma_release_declared_memory(struct device *dev)
>
>whose job would be to clean up unconditionally (and not check if the
>memory were still in use).
>
>I already have this coded up on x86 and implemented for a SCSI card I
>have with four channels and a shared 2MB memory area on chip.  I'll post
>the implementations when I get it cleaned up.
>
>  
>
The proposed API looks like it will solve our problem.  I will work with 
Ian to test this with our drivers.

Jamey

