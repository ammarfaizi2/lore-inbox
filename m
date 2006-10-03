Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWJCIvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWJCIvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJCIvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:51:19 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:16318 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S965592AbWJCIvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:51:18 -0400
Date: Tue, 3 Oct 2006 09:51:16 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
In-Reply-To: <1159849491.5482.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net> 
 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
 <1159849491.5482.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006, Benjamin Herrenschmidt wrote:

> On Thu, 2006-09-14 at 19:11 +0100, Mel Gorman wrote:
>> On Thu, 14 Sep 2006, Judith Lebzelter wrote:
>>
>>> For ppc in our cross-compile build farm (PLM), there is an error
>>> compiling file ppc/mm/init.c:
>>>
>>>  CC      arch/ppc/mm/init.o
>>>  CC      arch/powerpc/kernel/init_task.o
>>> arch/ppc/mm/init.c: In function 'paging_init':
>>> arch/ppc/mm/init.c:381: error: subscripted value is neither array nor pointer
>>> arch/ppc/mm/init.c:383: warning: passing argument 1 of '/' makes pointer from integer without a cast
>>> make[1]: [arch/ppc/mm/init.o] Error 1 (ignored)
>>>
>>>
>>> This is caused by an error/oversight in file
>>> 'have-power-use-add_active_range-and-free_area_init_nodes.patch'
>>>
>>> Here is a patch to fix that patch.
>>>
>>
>> Looks good. Thanks
>>
>> Acked-by: Mel Gorman <mel@csn.ul.ie>
>
> Note that the whole ppc patch here seems broken. Sorry for not jumping
> earlier, I've been swamped with other things.
>
> First, why the heck do you use indices 0 and 1 explicitely rather than
> the symbolic constants ?

Because in the -mm kernel the patches were rolled against, ZONE_DMA was 
optional and MAX_NR_ZONES could change which led to this confusion. It is 
wrong and thanks for catching it. However, this is a a fairly small part 
of the whole patch, is it an exaggeration to call the whole patch broken?

On a semi-related (but not very important) note, why does PPC use ZONE_DMA 
as it's lowest zone and not ZONE_NORMAL? I currently view zones as 
meaning;

ZONE_DMA - The physical range of memory usable by a subset of devices
 	available on the target platform (usually considered to be ISA
 	devices). It is mapped into the kernel
 	virtual address space

ZONE_DMA32 - The physical range of memory usable by 32 bit devices on 64
 	bit platforms. It is mapped into the kernel virtual address space

ZONE_NORMAL - The physical range of memory excluding the lower
 	zones directly mapped into the kernel virtual address space.

ZONE_HIGHMEM - The higher physical address spaces not permanently mapped
 	into the kernel virtual address space

This is not 100% bullet-proof definition. For example, memmap can be 
allocated from highmem and placed in the kernel virtual address space. But 
by the definitions above, ppc would have no ZONE_DMA, only ZONE_NORMAL and 
ZONE_HIGHMEM. Was ZONE_DMA used for any particular reason?

> ppc doesn't have a ZONE_NORMAL, so we should be
> filling ZONE_DMA and ZONE_HIGHMEM but you end up filling ZONE_DMA and
> ZONE_NORMAL and leave ZONE_HIGHMEM alone. Also, you leave other entries
> filled with crap (the array isn't initialized) which cause some strange
> display of the PFN list, if not worse problems later, I don't know for
> sure at this stage.
>

By the PFN list, I assume you mean the dmesg entry that starts with "Zone 
PFN ranges:". If that is messed up, it is bad, but it should still boot 
albeit with memory in the wrong zones.

> I've about to run some tests with this patch.

I made a minor comment on your patch below.

> Looks like we need give a
> closer look at those patches, in case that breakage appears on other
> archs as well (or similar).

I looked through the other patches for similar breakage. On x86, 
max_zone_pfns is initialised as;

# x86 init
+       unsigned long max_zone_pfns[MAX_NR_ZONES] = {
+               virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
+               max_low_pfn,
+               highend_pfn
+       };

as it does not have ZONE_DMA32, I believe it's ok. On x86_64, I used

# x86_64 init
+       unsigned long max_zone_pfns[MAX_NR_ZONES] = {MAX_DMA_PFN,
+                                                       MAX_DMA32_PFN,
+                                                       end_pfn};

This should be ok because x86_64 uses ZONE_NORMAL as the highest zone.

On ia64, there is

# ia64
+       max_zone_pfns[ZONE_DMA] = max_dma;
+       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;

That should also be ok because it doesn't use HIGHMEM.

How do they look to you?


> ---
>
> New zone initialisation on powerpc is broken, especially with
> CONFIG_HIGHMEM, this fixes it by initializing the array to 0 and filling
> up the right entries.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Index: linux-work/arch/powerpc/mm/mem.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/mm/mem.c	2006-10-03 12:41:03.000000000 +1000
> +++ linux-work/arch/powerpc/mm/mem.c	2006-10-03 14:08:30.000000000 +1000
> @@ -307,11 +307,12 @@ void __init paging_init(void)
> 	       top_of_ram, total_ram);
> 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> 	       (top_of_ram - total_ram) >> 20);
> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> #ifdef CONFIG_HIGHMEM
> -	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
> -	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
> +	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;

Add

max_zone_pfns[ZONE_NORMAL] = total_lowmem >> PAGE_SHIFT;

The effect will be that ZONE_NORMAL will be initialised as empty.

> +	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
> #else
> -	max_zone_pfns[0] = top_of_ram >> PAGE_SHIFT;
> +	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
> #endif
> 	free_area_init_nodes(max_zone_pfns);
> }
>
>
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
