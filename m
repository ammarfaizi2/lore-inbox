Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWJCJeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWJCJeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWJCJeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:34:10 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:14529 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932119AbWJCJeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:34:08 -0400
Date: Tue, 3 Oct 2006 10:34:05 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
In-Reply-To: <1159867180.5482.61.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610031023100.13141@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net> 
 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie> 
 <1159849491.5482.24.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
 <1159867180.5482.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006, Benjamin Herrenschmidt wrote:

>
>> Because in the -mm kernel the patches were rolled against, ZONE_DMA was
>> optional and MAX_NR_ZONES could change which led to this confusion. It is
>> wrong and thanks for catching it. However, this is a a fairly small part
>> of the whole patch, is it an exaggeration to call the whole patch broken?
>
> Well, that and the partially uninitialized array, that comprises most of
> the ppc patch :)

ok, that's a fair enough point :) .

> I wasn't talking about the other patches forming your
> patch set, mostly the whole PPC... the lack of usage of symbolic
> constants looked pretty bad to me

Once we have a patch using symbolic names working on ppc, I'll make a 
patch that uses symbolic names on the other architectures and post it.

>, I didn't know there were those other
> -mm related constraints.
>
>> On a semi-related (but not very important) note, why does PPC use ZONE_DMA
>> as it's lowest zone and not ZONE_NORMAL? I currently view zones as
>> meaning;
>
> History... A lot of driver used to request memory in ZONE_DMA "just in
> case" (the SCSI subsystem for example). Not having one meant that those
> drivers or subsystem would just not work on powerpc. I don't know if
> they have all been fixed, but if that's the case, then we can move
> everything to ZONE_NORMAL.
>

I don't know if it has been fixed either.

>> ZONE_DMA32 - The physical range of memory usable by 32 bit devices on 64
>>  	bit platforms. It is mapped into the kernel virtual address space
>
> We haven't done a ZONE_DMA32 for now. Currently, all supported 64 bits
> implementations have an iommu that makes this unnecessary, though the
> thread of having to deal with an implementation without one is getting
> more and more precise, so we may have to add it.
>
>> This is not 100% bullet-proof definition. For example, memmap can be
>> allocated from highmem and placed in the kernel virtual address space. But
>> by the definitions above, ppc would have no ZONE_DMA, only ZONE_NORMAL and
>> ZONE_HIGHMEM. Was ZONE_DMA used for any particular reason?
>
> As explained above. Is that a problem ?
>

No, it's not. It was out of curiousity more than anything else. I need to 
update my definition of ZONE_DMA slightly, that's all.

>> By the PFN list, I assume you mean the dmesg entry that starts with "Zone
>> PFN ranges:". If that is messed up, it is bad, but it should still boot
>> albeit with memory in the wrong zones.
>
> It was messed up with ZONE_DMA 0 -> xxx where xxx was my actual max_pfn,
> and ZONE_NORMAL from xxx -> yyy where yyy was a random very big number.
> That was with CONFIG_HIGHMEM off and it did boot. It didn't with
> CONFIG_HIGHMEM on as the high memory was being put in ZONE_NORMAL and
> ZONE_HIGHMEM left uninitialized.
>

ok, the problem is pretty clear at least.

>>> I've about to run some tests with this patch.
>>
>> I made a minor comment on your patch below.
>>
>>> Looks like we need give a
>>> closer look at those patches, in case that breakage appears on other
>>> archs as well (or similar).
>>
>> I looked through the other patches for similar breakage. On x86,
>> max_zone_pfns is initialised as;
>>
>> # x86 init
>> +       unsigned long max_zone_pfns[MAX_NR_ZONES] = {
>> +               virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
>> +               max_low_pfn,
>> +               highend_pfn
>> +       };
>>
>> as it does not have ZONE_DMA32, I believe it's ok. On x86_64, I used
>
> I would much prefer to use explicit array index initializers... but ok.
>

Once we get ppc sorted, I'll make a patch that uses explicit array 
initialisation and symbolic index names on the other arches.

>> # x86_64 init
>> +       unsigned long max_zone_pfns[MAX_NR_ZONES] = {MAX_DMA_PFN,
>> +                                                       MAX_DMA32_PFN,
>> +                                                       end_pfn};
>>
>> This should be ok because x86_64 uses ZONE_NORMAL as the highest zone.
>
> Same comment.
>
>> On ia64, there is
>>
>> # ia64
>> +       max_zone_pfns[ZONE_DMA] = max_dma;
>> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>>
>> That should also be ok because it doesn't use HIGHMEM.
>>
>> How do they look to you?
>
> I suppose they are ok. I dislike this CONFIG_* variation of the
> definition of the ZONE_* constants, it's error prone though.
>

I believe it was to stop having more empty zones than was really 
necessary. It was a saving on NUMA. I might be wrong, I'll need to check 
the archives again.

>>> ---
>>>
>>> New zone initialisation on powerpc is broken, especially with
>>> CONFIG_HIGHMEM, this fixes it by initializing the array to 0 and filling
>>> up the right entries.
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>
>>> Index: linux-work/arch/powerpc/mm/mem.c
>>> ===================================================================
>>> --- linux-work.orig/arch/powerpc/mm/mem.c	2006-10-03 12:41:03.000000000 +1000
>>> +++ linux-work/arch/powerpc/mm/mem.c	2006-10-03 14:08:30.000000000 +1000
>>> @@ -307,11 +307,12 @@ void __init paging_init(void)
>>> 	       top_of_ram, total_ram);
>>> 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>>> 	       (top_of_ram - total_ram) >> 20);
>>> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>>> #ifdef CONFIG_HIGHMEM
>>> -	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
>>> -	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
>>> +	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
>>
>> Add
>>
>> max_zone_pfns[ZONE_NORMAL] = total_lowmem >> PAGE_SHIFT;
>>
>> The effect will be that ZONE_NORMAL will be initialised as empty.
>
> Ok, but what happens with the patch code where it's 0 ?

Ah (wipes egg off face). In free_area_init_nodes(), it will be set to 
(total_lowmem >> PAGE_SHIFT) by this;

+               arch_zone_lowest_possible_pfn[i] =
+                       arch_zone_highest_possible_pfn[i-1];
+               arch_zone_highest_possible_pfn[i] =
+                       max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);

so you can leave it as 0.

> I much prefer,
> in general, initializing an array to 0, and then only fill the entries
> that matter. This avoids the problem of the ZONE_*  constants floating
> around (or adding a new one or whatever). It might make sense to have
> the generic code handle that instead...
>

You're right. The generic code does handle this case because at one point, 
I remembered clearly that not all zones would be in use :/

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
