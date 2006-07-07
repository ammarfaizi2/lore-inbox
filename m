Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWGGLg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWGGLg7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWGGLg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:36:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:49140 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750846AbWGGLg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:36:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=T4tCBgHcN5D4APWMCkj+8cSbjZvn/jD6r+/Jmp1dNvc0KS8YxJYGwKC3D1crnFkA7FXXyFwuQOF2JlfAtV3NLpx2neJy1IGulUKLl1DOzC74y05OyerbTOob7gsVDBScsyozX6MDdGumYw5KvSTwxcrBryWT5AttCPZZEZEcjNM=
Message-ID: <44AE487C.5060602@innova-card.com>
Date: Fri, 07 Jul 2006 13:41:48 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>, starvik@axis.com, dhowells@redhat.com
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie> <44AD1F90.10103@innova-card.com> <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie> <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com> <20060706195558.GA13225@skynet.ie> <44AE14C7.1070806@innova-card.com> <Pine.LNX.4.64.0607070934340.27720@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0607070934340.27720@skynet.skynet.ie>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Fri, 7 Jul 2006, Franck Bui-Huu wrote:
> 
>> Therefore, what I proposed was to let free_area_init_node() work as
>> expected, so whatever the value of ARCH_PFN_OFFSET, this use
>>
>> free_area_init_node(..., ..., ..., whatever, ...);
>>
>> will define the start of mem as 'whatever' value. And if the user
>> wants to use the default start mem value then he can do both:
>>
>> free_area_init_node(..., ..., ..., ARCH_PFN_OFFSET, ...);
>>
>> or (equivalent):
>>
>> free_area_init(...);
>>
> 
> Ok, I'm convinced. This change would make more sense but with direct
> users of mem_map, it is incomplete.
> 

great !

>>> ....
>>>
>>> using mem_map directly. uh uh
>>>
>>> Both of our patches are broken.
>>>
>>> page_to_pfn() and pfn_to_page() both need ARCH_PFN_OFFSET to get PFNs,
>>> that's fine. However, I forgot that another assumption of the FLATMEM
>>> memory
>>> model is that mem_map[0] is the first valid struct page in the system. A
>>
>> I would say that the first valid struct page in the system is
>>
>> mem_map[PFN_UP(__pa(PAGE_OFFSET))] == mem_map[ARCH_PFN_OFFSET]
>>
> 
> That's not the assumption users of mem_map[] are making.
> 
>>> number of architectures walk mem_map[] directly (cris and frv are
>>> examples)
>>> without offsetting based on this assumption.
>>>
>>
>> but they do have ARCH_PFN_OFFSET = 0, no ?
>>
> 
> mel@arnold:~/linux-2.6.17-mm6-clean/include/asm-cris$ grep -r
> ARCH_PFN_OFFSET *
> page.h:#define ARCH_PFN_OFFSET          (PAGE_OFFSET >> PAGE_SHIFT)
> 
> mel@arnold:~/linux-2.6.17-mm6-clean/arch/cris$ grep -r mem_map *
> arch-v10/mm/init.c:      * mem_map page array.
> arch-v32/mm/init.c:      * saves space in the mem_map page array.
> arch-v32/mm/init.c:     mem_map = contig_page_data.node_mem_map;
> mm/init.c:              if (PageReserved(mem_map+i))
> mm/init.c:              else if (PageSwapCache(mem_map+i))
> mm/init.c:              else if (!page_count(mem_map+i))
> mm/init.c:              else if (page_count(mem_map+i) == 1)
> mm/init.c:                      shared += page_count(mem_map+i) - 1;
> mm/init.c:      if(!mem_map)
> mm/init.c:              if (PageReserved(mem_map + tmp))
> 
> That would be a no. In the example of cris and elsewhere, show_mem()
> walks the mem_map array from max_mapnr to 0. If mem_map had been offset
> by ARCH_PFN_OFFSET during init, the first call to show_mem() would have
> had interesting results.
> 
>> Walking mem_map[] directly should be avoid.
>>
> 
> Whether it should be avoided now or not, mem_map[] is walked directly.
> Historically, it was fine to do this. The full patch would need to do
> something like
> 
> o Rename mem_map to __mem_map[] to break incorrect users at compile time
> o #define MEM_MAP (__mem_map + ARCH_PFN_OFFSET)
> o Change all direct users of mem_map to MEM_MAP
>
> While not exactly complicated, is it worth it?
> 

It's always worth to fix broken code. But I don't think that's should
be done by this patch.

>> If the mem start is different from 0 and ARCH_PFN_OFFSET is not set
>> then all patches are correct and mem_map[0] is valid.
>>
>> But if the user set ARCH_PFN_OFFSET != 0, he tells to the system that
>> the start of memory is not 0, and mem_map[0] is now forbidden since no
>> page exist in this area.
> 
> It's what happens thoug: ARCH_PFN_OFFSET != 0 and mem_map[0] is used.
> 
>> BTW the problem exists with the old code, if
>> the user do pfn_to_page(0), he will get an invalid page pointer.
>>
> 
> Good job they don't do that :/
> 

so doing pfn_to_page(0) will crash and mem_map[0] is ok ? it sounds very
silly no ? 

Well, I think this arch has really really weird uses of mem_map. That may be
explained by the fact that it was implemented before the support of "mem start
is not 0" had been added.

Maybe it's time to make these arches aware of this ?

I CC'ed both frv and cris maitainers...

		Franck
