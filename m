Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWFZKhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWFZKhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFZKhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 06:37:46 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:39385 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932447AbWFZKhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 06:37:45 -0400
Date: Mon, 26 Jun 2006 11:37:43 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
In-Reply-To: <449F9B4C.6000404@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com>
 <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
 <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
 <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com>
 <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com>
 <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com>
 <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Franck Bui-Huu wrote:

> Hi Mel
>
> Mel Gorman wrote:
>> On Fri, 23 Jun 2006, Franck Bui-Huu wrote:
>>
>
> [snip]
>
>>>
>>> -unsigned long __init init_bootmem (unsigned long start, unsigned long
>>> pages)
>>> +unsigned long __init init_bootmem(unsigned long start, unsigned long
>>> pages)
>>> {
>>>     max_low_pfn = pages;
>>>     min_low_pfn = start;
>>> -    return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
>>> +    return init_bootmem_core(NODE_DATA(0), start, ARCH_PFN_OFFSET,
>>> pages);
>>> }
>>>
>>
>> Not all arches will use init_bootmem(). Arm for example uses
>> init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map,
>
> well, I don't agree here. ARCH_PFN_OFFSET is used to save the first
> page number that has physical memory. I don't see why we couldn't use
> it to correctly initialise the memory system...
>

Architectures will not always have a known fixed start of physical memory. 
On IA64 at least, they initialise memory as if it starts at 0 but on my 
one test machine, the beginning part is always a memory hole. I've seen 
nothing to indicate that this hole will be the same size on all IA64 
machines but I kinda doubt it. Also, arches that use init_bootmem() do not 
necessary use free_area_init().

> If we don't change init_bootmem() to use ARCH_PFN_OFFSET, then the
> kernel will initialise the start of memory to 0 which is boggus.
> IOW,
> we can't use this function without this change (except if your memory
> start at 0 of course). And I think that init_bootmem() has been
> implemented for systems which have only one node _whatever_ memory
> start value...
>

While you may be right, it'll only fix the problem for arches with 
ARCH_PFN_OFFSET and using init_bootmem (which is the case of MIPS I 
guess). But arches using init_bootmem_node or not using free_area_init() 
may still get kicked.

>>> #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>
> [snip]
>
>>> @@ -2174,8 +2181,7 @@ #endif
>>>
>>> void __init free_area_init(unsigned long *zones_size)
>>> {
>>> -    free_area_init_node(0, NODE_DATA(0), zones_size,
>>> -            __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
>>> +    free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET,
>>> NULL);
>>> }
>>>
>>
>> Same comment applies as for init_bootmem(). I can't be sure it's a good
>> idea.
>>
>
> same comment as for init_bootmem()
>
>
> 		Franck
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
