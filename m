Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVHDNjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVHDNjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVHDNjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:39:39 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:29894 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262535AbVHDNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:39:24 -0400
Message-ID: <42F21A86.8030408@anagramm.de>
Date: Thu, 04 Aug 2005 15:39:18 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: LKML List <linux-kernel@vger.kernel.org>
Subject: Re: How to get the physical page addresses from a kernel virtual
 address for DMA SG List?
References: <42F20CEC.60206@anagramm.de> <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dick!

Thanks for your help so far!

linux-os (Dick Johnson) wrote:
> 
> You are trying to do it backwards. You need to have your driver
> use get_dma_pages() to acquire pages suitable for DMA. Your
> driver then impliments mmap().

Okay, I have seen that, too. I've seen that some drivers do it the other
way around as I do, but I still try to follow my idea that the
application allocs the memory and the dma / the driver fills it up.
Or are there fundamental problems I get with my approach which I haven't seen yet?

> The user-mode application then mmaps() the dma-able pages into
> its address-space. FYI, the pages may be from anywhere, some
> archs can only DMA to/from memory below 16MB.

My DMA machine (ppc32, mpc8540 cpu) can do the whole 32bit phys address
space so, that's not an issue here.

> The pages do not have
> to be continuous because you will build a scatter-list for
> the DMA engine and you will mmap() the pages so they are
> contiguous to the user.

Yes, only virtual space is contigous. The DMA can do nice
sg_lists and chained sg_lists, so, this should not be a problem,
too.

> Also 400 Megabytes is absurd.

Why?
Actually I am planning to alloc more than 1.5GByte at once,
lock that down, build a big sg_list for all that memory because
I need to _continously_ feed it with data from the DMA. I get
about 200MBytes/sec and I cannot stop in between!

Greets,

Clemens



> On Thu, 4 Aug 2005, Clemens Koller wrote:
> 
> 
>>Hello!
>>
>>This might be an FAQ - I've got several ideas from googling
>>around for days and reading 'Linux Device Drivers' or
>>'Understanding The Linux Kernel' which are both really good
>>books. However I am not really sure of how to do it on the latest
>>linux-2.6.
>>
>>I am currently working on a dma driver for a ppc32 system.
>>The idea is that a userspace app allocates a big contigous
>>chunk of memory (i.e. 400MBytes, user virtual mem) and tells
>>my dma's char driver via ioctl the pointer to that memory.
>>
>>In the driver I can now use that (void __user *) casted address
>>as a kernel virtual address, right? It's contigous there and I can
>>do a memcpy() to get data to userspace simliar to a copy_to_user().
>>fine!
>>
>>But I want to setup a scatter/gather DMA list and blow my data
>>directly into the applications physical pages.
>>
>>What's the best way to setup the dma_sg_list?
>>I have checked several things to get the pages and physical addresses
>>but with no real success now:
>>get_user_page()
>>vmalloc_to_page()
>>kvirt_to_bus() (deprecated?)
>>virt_to_phys()
>>virt_to_bus()
>>
>>Or do I need to remap the whole thing before I can get all the pages and
>>physical addresses?
>>remap_page_range()
>>remap_pfn_range()
>>map_user_kiobuf()
>>unmap_kiobuf()
>>
>>Or do I need the direct-io stuff or the block-io?
>>How do I need to alloc the mem in my app? (get_pages()?)
>>How do I need to lock the memory to make sure it's in phys memory? (mlockall()?)
>>Can somebody please put some light on what's _the_ way to do that on the
>>latest 2.6 kernels? I am pretty much confused which functions are current
>>and okay to use to solve my problem.
>>Pointers to some code is also very welcome. But it should be _current_.
>>I've spent already a lot of time reading outdated things. :-(
>>
>>Best regards,
>>
>>Clemens Koller
>>_______________________________
>>R&D Imaging Devices
>>Anagramm GmbH
>>Rupert-Mayer-Str. 45/1
>>81379 Muenchen
>>Germany
>>
>>http://www.anagramm.de
>>Phone: +49-89-741518-50
>>Fax: +49-89-741518-19
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> I apologize for the following. I tried to kill it with the above dot :
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 
