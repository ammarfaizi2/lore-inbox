Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWJCJUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWJCJUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWJCJUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:20:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:54445 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030273AbWJCJUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:20:04 -0400
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
	 <1159849491.5482.24.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 19:19:40 +1000
Message-Id: <1159867180.5482.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Because in the -mm kernel the patches were rolled against, ZONE_DMA was 
> optional and MAX_NR_ZONES could change which led to this confusion. It is 
> wrong and thanks for catching it. However, this is a a fairly small part 
> of the whole patch, is it an exaggeration to call the whole patch broken?

Well, that and the partially uninitialized array, that comprises most of
the ppc patch :) I wasn't talking about the other patches forming your
patch set, mostly the whole PPC... the lack of usage of symbolic
constants looked pretty bad to me, I didn't know there were those other
-mm related constraints.

> On a semi-related (but not very important) note, why does PPC use ZONE_DMA 
> as it's lowest zone and not ZONE_NORMAL? I currently view zones as 
> meaning;

History... A lot of driver used to request memory in ZONE_DMA "just in
case" (the SCSI subsystem for example). Not having one meant that those
drivers or subsystem would just not work on powerpc. I don't know if
they have all been fixed, but if that's the case, then we can move
everything to ZONE_NORMAL.

> ZONE_DMA32 - The physical range of memory usable by 32 bit devices on 64
>  	bit platforms. It is mapped into the kernel virtual address space

We haven't done a ZONE_DMA32 for now. Currently, all supported 64 bits
implementations have an iommu that makes this unnecessary, though the
thread of having to deal with an implementation without one is getting
more and more precise, so we may have to add it.

> This is not 100% bullet-proof definition. For example, memmap can be 
> allocated from highmem and placed in the kernel virtual address space. But 
> by the definitions above, ppc would have no ZONE_DMA, only ZONE_NORMAL and 
> ZONE_HIGHMEM. Was ZONE_DMA used for any particular reason?

As explained above. Is that a problem ?

> By the PFN list, I assume you mean the dmesg entry that starts with "Zone 
> PFN ranges:". If that is messed up, it is bad, but it should still boot 
> albeit with memory in the wrong zones.

It was messed up with ZONE_DMA 0 -> xxx where xxx was my actual max_pfn,
and ZONE_NORMAL from xxx -> yyy where yyy was a random very big number.
That was with CONFIG_HIGHMEM off and it did boot. It didn't with
CONFIG_HIGHMEM on as the high memory was being put in ZONE_NORMAL and
ZONE_HIGHMEM left uninitialized.

> > I've about to run some tests with this patch.
> 
> I made a minor comment on your patch below.
> 
> > Looks like we need give a
> > closer look at those patches, in case that breakage appears on other
> > archs as well (or similar).
> 
> I looked through the other patches for similar breakage. On x86, 
> max_zone_pfns is initialised as;
> 
> # x86 init
> +       unsigned long max_zone_pfns[MAX_NR_ZONES] = {
> +               virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
> +               max_low_pfn,
> +               highend_pfn
> +       };
> 
> as it does not have ZONE_DMA32, I believe it's ok. On x86_64, I used

I would much prefer to use explicit array index initializers... but ok.

> # x86_64 init
> +       unsigned long max_zone_pfns[MAX_NR_ZONES] = {MAX_DMA_PFN,
> +                                                       MAX_DMA32_PFN,
> +                                                       end_pfn};
> 
> This should be ok because x86_64 uses ZONE_NORMAL as the highest zone.

Same comment.

> On ia64, there is
> 
> # ia64
> +       max_zone_pfns[ZONE_DMA] = max_dma;
> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> 
> That should also be ok because it doesn't use HIGHMEM.
> 
> How do they look to you?

I suppose they are ok. I dislike this CONFIG_* variation of the
definition of the ZONE_* constants, it's error prone though.

> > ---
> >
> > New zone initialisation on powerpc is broken, especially with
> > CONFIG_HIGHMEM, this fixes it by initializing the array to 0 and filling
> > up the right entries.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >
> > Index: linux-work/arch/powerpc/mm/mem.c
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/mm/mem.c	2006-10-03 12:41:03.000000000 +1000
> > +++ linux-work/arch/powerpc/mm/mem.c	2006-10-03 14:08:30.000000000 +1000
> > @@ -307,11 +307,12 @@ void __init paging_init(void)
> > 	       top_of_ram, total_ram);
> > 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> > 	       (top_of_ram - total_ram) >> 20);
> > +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> > #ifdef CONFIG_HIGHMEM
> > -	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
> > -	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
> > +	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
> 
> Add
> 
> max_zone_pfns[ZONE_NORMAL] = total_lowmem >> PAGE_SHIFT;
> 
> The effect will be that ZONE_NORMAL will be initialised as empty.

Ok, but what happens with the patch code where it's 0 ? I much prefer,
in general, initializing an array to 0, and then only fill the entries
that matter. This avoids the problem of the ZONE_*  constants floating
around (or adding a new one or whatever). It might make sense to have
the generic code handle that instead...

Cheers,
Ben.


