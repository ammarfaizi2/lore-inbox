Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266632AbUGPWPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUGPWPD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUGPWPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:15:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:64409 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266632AbUGPWO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:14:58 -0400
Message-ID: <40F852AE.8060703@comcast.net>
Date: Fri, 16 Jul 2004 15:11:58 -0700
From: "Amit D. Chaudhary" <amit_c@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net, linux-kernel@vger.kernel.org
Subject: Re: MAX_DMA_ADDRESS in include/asm/asm-i386/dma.h (2.6.x and 2.4.x)
References: <40F84A87.5050403@comcast.net> <20040716214721.GA20741@plexity.net>
In-Reply-To: <20040716214721.GA20741@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak,

I am missing what you are directing me to.

If it is,
pci_alloc_consistent(), linux-2.4.25/arch/i386/kernel/pci-dma.c
dma_alloc_coherent(), linux-2.6.8-rc1/arch/i386/kernel/pci-dma.c

They internally seem to __get_free_pages()

If you meant,
pci_pool_create()\pci_pool_alloc
the code in question does not need fixed size buffers like kmem_cache_alloc.

Here is the actual usage planned,
The DMA buffer is a variable size buffer (typically 1k to 128K) 
represent a read or write from an FC initiator. This memory is passed as 
data segments (sg list) with various CTIOs (Type of IOCB on Qlogic FC 
HBA chips). For a write command, the memory is used to read the data 
into the memory and then pass it to a user application without any copy 
(think mmap.)
This is part of implementing a virtual targets in a Target mode device 
driver.

The memory need not be page size, as a matter of fact, using a large 
consecutive block, for example using alloc_bootmem_low() during kernel 
bootup, will simplify the data transfer and result in no internal 
fragmentation, it does introduce inflexibility in changing the size and 
other issues.

Hopefully that sheds more light on the topic.

Amit


Deepak Saxena wrote:
> On Jul 16 2004, at 14:37, Amit D. Chaudhary was caught saying:
> 
>>While writing some DMA page gathering code, I realize that 
>>__get_free_page or kmalloc does not return memory more than 16 MB 
>>(typically around 11-12 MB even if it done right after a reboot.)
>>
>>Since this is for a PCI device (A Fibre channel HBA), I remembered that 
>>the book Linux Device Driver, edition 2 mentions that the 16 MB limit is 
>>for DMA with ISA devices, while PCI DMA can access upto 950 MB or so, 
>>using 32 bit addresses.
> 
> 
> Using __get_free_page() or kmalloc() for device DMA'ble descriptors (I am
> guessing that's what you are doing) is wrong. See Documentation/DMA-API.txt
> and Documentation/DMA-mapping.txt for the proper way to do this. 
> 
> ~Deepak
> 
