Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWGGMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGGMbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGGMbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:31:10 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:64905 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932143AbWGGMbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:31:08 -0400
Date: Fri, 7 Jul 2006 13:31:06 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: starvik@axis.com, dhowells@redhat.com, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
In-Reply-To: <44AE487C.5060602@innova-card.com>
Message-ID: <Pine.LNX.4.64.0607071304080.31091@skynet.skynet.ie>
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie>
 <44AD1F90.10103@innova-card.com> <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie>
 <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com>
 <20060706195558.GA13225@skynet.ie> <44AE14C7.1070806@innova-card.com>
 <Pine.LNX.4.64.0607070934340.27720@skynet.skynet.ie> <44AE487C.5060602@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Franck Bui-Huu wrote:

> Mel Gorman wrote:
>> On Fri, 7 Jul 2006, Franck Bui-Huu wrote:
>>
>>> Therefore, what I proposed was to let free_area_init_node() work as
>>> expected, so whatever the value of ARCH_PFN_OFFSET, this use
>>>
>>> free_area_init_node(..., ..., ..., whatever, ...);
>>>
>>> will define the start of mem as 'whatever' value. And if the user
>>> wants to use the default start mem value then he can do both:
>>>
>>> free_area_init_node(..., ..., ..., ARCH_PFN_OFFSET, ...);
>>>
>>> or (equivalent):
>>>
>>> free_area_init(...);
>>>
>>
>> Ok, I'm convinced. This change would make more sense but with direct
>> users of mem_map, it is incomplete.
>>
>
> great !
>
>>>> ....
>>>>
>>>> using mem_map directly. uh uh
>>>>
>>>> Both of our patches are broken.
>>>>
>>>> page_to_pfn() and pfn_to_page() both need ARCH_PFN_OFFSET to get PFNs,
>>>> that's fine. However, I forgot that another assumption of the FLATMEM
>>>> memory
>>>> model is that mem_map[0] is the first valid struct page in the system. A
>>>
>>> I would say that the first valid struct page in the system is
>>>
>>> mem_map[PFN_UP(__pa(PAGE_OFFSET))] == mem_map[ARCH_PFN_OFFSET]
>>>
>>
>> That's not the assumption users of mem_map[] are making.
>>
>>>> number of architectures walk mem_map[] directly (cris and frv are
>>>> examples)
>>>> without offsetting based on this assumption.
>>>>
>>>
>>> but they do have ARCH_PFN_OFFSET = 0, no ?
>>>
>>
>> mel@arnold:~/linux-2.6.17-mm6-clean/include/asm-cris$ grep -r
>> ARCH_PFN_OFFSET *
>> page.h:#define ARCH_PFN_OFFSET          (PAGE_OFFSET >> PAGE_SHIFT)
>>
>> mel@arnold:~/linux-2.6.17-mm6-clean/arch/cris$ grep -r mem_map *
>> arch-v10/mm/init.c:      * mem_map page array.
>> arch-v32/mm/init.c:      * saves space in the mem_map page array.
>> arch-v32/mm/init.c:     mem_map = contig_page_data.node_mem_map;
>> mm/init.c:              if (PageReserved(mem_map+i))
>> mm/init.c:              else if (PageSwapCache(mem_map+i))
>> mm/init.c:              else if (!page_count(mem_map+i))
>> mm/init.c:              else if (page_count(mem_map+i) == 1)
>> mm/init.c:                      shared += page_count(mem_map+i) - 1;
>> mm/init.c:      if(!mem_map)
>> mm/init.c:              if (PageReserved(mem_map + tmp))
>>
>> That would be a no. In the example of cris and elsewhere, show_mem()
>> walks the mem_map array from max_mapnr to 0. If mem_map had been offset
>> by ARCH_PFN_OFFSET during init, the first call to show_mem() would have
>> had interesting results.
>>
>>> Walking mem_map[] directly should be avoid.
>>>
>>
>> Whether it should be avoided now or not, mem_map[] is walked directly.
>> Historically, it was fine to do this. The full patch would need to do
>> something like
>>
>> o Rename mem_map to __mem_map[] to break incorrect users at compile time
>> o #define MEM_MAP (__mem_map + ARCH_PFN_OFFSET)
>> o Change all direct users of mem_map to MEM_MAP
>>
>> While not exactly complicated, is it worth it?
>>
>
> It's always worth to fix broken code.

It's a question of definition whether the code is actually broken or not. 
Using ARCH_PFN_OFFSET to fudge between mem_map starting at PFN 0 is 
deliberate, just as walking mem_map starting at mem_map[0] is deliberate.

Certainly, it is a bit confused that page_to_pfn and friends assume that 
mem_map[] begins at PFN 0, but direct walkers of mem_map[] assume that 
mem_map[] begins at the first valid struct page whether it's PFN 0 or not. 
It would be nicer to have things consistent.

> But I don't think that's should
> be done by this patch.
>

No, each of the direct users of mem_map would need to be fixed first and 
there are a fair number. http://lxr.free-electrons.com/ident?i=mem_map 
gives an indication of how many although a glance through shows that most 
users are a copied show_mem()

>>> If the mem start is different from 0 and ARCH_PFN_OFFSET is not set
>>> then all patches are correct and mem_map[0] is valid.
>>>
>>> But if the user set ARCH_PFN_OFFSET != 0, he tells to the system that
>>> the start of memory is not 0, and mem_map[0] is now forbidden since no
>>> page exist in this area.
>>
>> It's what happens thoug: ARCH_PFN_OFFSET != 0 and mem_map[0] is used.
>>
>>> BTW the problem exists with the old code, if
>>> the user do pfn_to_page(0), he will get an invalid page pointer.
>>>
>>
>> Good job they don't do that :/
>>
>
> so doing pfn_to_page(0) will crash and mem_map[0] is ok ? it sounds very
> silly no ?
>

I agree. I was pointing what the current assumptions related to mem_map[] 
are, not whether I think it's a good idea or not :)

> Well, I think this arch has really really weird uses of mem_map. That may be
> explained by the fact that it was implemented before the support of "mem start
> is not 0" had been added.
>

Yes, it would be. As I said, historically, using mem_map[0] was fine and 
the current oddness in FLATMEM memory model reflects that.

> Maybe it's time to make these arches aware of this ?
>
> I CC'ed both frv and cris maitainers...
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
