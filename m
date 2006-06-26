Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWFZNWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWFZNWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:22:23 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:25571 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932291AbWFZNWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:22:22 -0400
Date: Mon, 26 Jun 2006 14:22:20 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
In-Reply-To: <449FC592.8050409@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com>
 <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
 <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
 <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com>
 <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com>
 <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com>
 <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com>
 <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie> <449FC592.8050409@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Franck Bui-Huu wrote:

> Mel Gorman wrote:

>>>> Not all arches will use init_bootmem(). Arm for example uses
>>>> init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map,
>>>>
>>> well, I don't agree here. ARCH_PFN_OFFSET is used to save the first
>>> page number that has physical memory. I don't see why we couldn't 
>>> useit to correctly initialise the memory system...
>>
>> Architectures will not always have a known fixed start of physical
>> memory. On IA64 at least, they initialise memory as if it starts at 0
>> but on my one test machine, the beginning part is always a memory hole.
>
> in that case ARCH_PFN_OFFSET is 0 which is the old behaviour, nothing
> change...
>

The change is that ARCH_PFN_OFFSET has a slightly different meaning when 
you alter those two initialisation functions. Currently it is used to 
offset memmap from NODE_DATA(0)->node_start_pfn. By changing 
free_area_init() and init_bootmem(), it changes to altering the value of 
NODE_DATA(0)->node_start_pfn but only when memory is initialised in a 
particular way. I believe it makes ARCH_PFN_OFFSET even more obscure than 
it currently is.

I think we should just fix the problem at hand now for which two simple 
patches have been posted and consider making further changes to 
free_area_init() and init_bootmem() as a separate issue.

>> I've seen nothing to indicate that this hole will be the same size on
>> all IA64 machines but I kinda doubt it. Also, arches that use
>> init_bootmem() do not necessary use free_area_init().
>>
>
> but in that case do they use ARCH_PFN_OFFSET != 0 ?

IA64 do not and I didn't check all arches.

> if so that would be
> very surprising. That would meand "I have a hole a the start of my mem,
> I don't know at compile time where it starts, but I state that my physical
> mem start at ARCH_PFN_OFFSET anyways"
>
>>> If we don't change init_bootmem() to use ARCH_PFN_OFFSET, then the
>>> kernel will initialise the start of memory to 0 which is boggus.
>>> IOW,
>>> we can't use this function without this change (except if your memory
>>> start at 0 of course). And I think that init_bootmem() has been
>>> implemented for systems which have only one node _whatever_ memory
>>> start value...
>>>
>>
>> While you may be right, it'll only fix the problem for arches with
>> ARCH_PFN_OFFSET and using init_bootmem (which is the case of MIPS I
>> guess). But arches using init_bootmem_node or not using free_area_init()
>> may still get kicked.
>>
>
> Again in these cases, I doubt that they will setup ARCH_PFN_OFFSET...
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
