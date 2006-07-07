Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWGGMit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWGGMit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGGMit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:38:49 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:10627 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S932149AbWGGMis convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:38:48 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Franck'" <vagabon.xyz@gmail.com>, "'Mel Gorman'" <mel@csn.ul.ie>,
       "Mikael Starvik" <mikael.starvik@axis.com>, <dhowells@redhat.com>
Cc: <akpm@osdl.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
Date: Fri, 7 Jul 2006 14:37:49 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B5596@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66803EF8299@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't care too much about CRIS in this case. I will adopt to whatever you
do. As long as we can keep the flat memory model.

-----Original Message-----
From: Franck Bui-Huu [mailto:vagabon.xyz@gmail.com] 
Sent: Friday, July 07, 2006 1:42 PM
To: Mel Gorman; Mikael Starvik; dhowells@redhat.com
Cc: Franck Bui-Huu; akpm@osdl.org; Linux Kernel Mailing List
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot


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
explained by the fact that it was implemented before the support of "mem
start
is not 0" had been added.

Maybe it's time to make these arches aware of this ?

I CC'ed both frv and cris maitainers...

		Franck

