Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVJCPqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVJCPqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVJCPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:46:54 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:10941 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932304AbVJCPqw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:46:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YrLCKSVQHm+iUpaM2iSNLIywU4TJj3XC4DmnIJpkT1olizOacPFucW4DmQFhwPDB1yImqKrHvGzr/pf7SYrfN7ggYFIlhZtcmBVsAo905veLDzhvcSq7TK131v9toYqW02YTixxXPSFyPt6w2hTtxhGc9WxQw4adwcsfZb9YS5s=
Message-ID: <2cd57c900510030846j75e9abddu872ec0ff215dcfb4@mail.gmail.com>
Date: Mon, 3 Oct 2005 23:46:50 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [1/3] Add 4GB DMA32 zone
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <43246267.mailL4R11PXCB@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43246267.mailL4R11PXCB@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Andi Kleen <ak@suse.de> wrote:
> Add 4GB DMA32 zone
>
> Add a new 4GB GFP_DMA32 zone between the GFP_DMA and GFP_NORMAL zones.
>
> As a bit of historical background: when the x86-64 port
> was originally designed we had some discussion if we should
> use a 16MB DMA zone like i386 or a 4GB DMA zone like IA64 or
> both. Both was ruled out at this point because it was in early
> 2.4 when VM is still quite shakey and had bad troubles even
> dealing with one DMA zone.  We settled on the 16MB DMA zone mainly
> because we worried about older soundcards and the floppy.
>
> But this has always caused problems since then because
> device drivers had trouble getting enough DMA able memory. These days
> the VM works much better and the wide use of NUMA has proven
> it can deal with many zones successfully.
>
> So this patch adds both zones.
>
> This helps drivers who need a lot of memory below 4GB because
> their hardware is not accessing more (graphic drivers - proprietary
> and free ones, video frame buffer drivers, sound drivers etc.).
> Previously they could only use IOMMU+16MB GFP_DMA, which
> was not enough memory.
>
> Another common problem is that hardware who has full memory
> addressing for >4GB misses it for some control structures in memory
> (like transmit rings or other metadata).  They tended to allocate memory
> in the 16MB GFP_DMA or the IOMMU/swiotlb then using pci_alloc_consistent,
> but that can tie up a lot of precious 16MB GFPDMA/IOMMU/swiotlb memory
> (even on AMD systems the IOMMU tends to be quite small) especially if you have
> many devices.  With the new zone pci_alloc_consistent can just put
> this stuff into memory below 4GB which works better.
>
> One argument was still if the zone should be 4GB or 2GB. The main
> motivation for 2GB would be an unnamed not so unpopular hardware
> raid controller (mostly found in older machines from a particular four letter
> company) who has a strange 2GB restriction in firmware. But
> that one works ok with swiotlb/IOMMU anyways, so it doesn't really
> need GFP_DMA32. I chose 4GB to be compatible with IA64 and because
> it seems to be the most common restriction.
>
> The new zone is so far added only for x86-64.
>
> For other architectures who don't set up this
> new zone nothing changes. Architectures can set a compatibility
> define in Kconfig CONFIG_DMA_IS_DMA32 that will define GFP_DMA32
> as GFP_DMA. Otherwise it's a nop because on 32bit architectures
> it's normally not needed because GFP_NORMAL (=0) is DMA able
> enough.
>
> One problem is still that GFP_DMA means different things on different
> architectures. e.g. some drivers used to have #ifdef ia64  use GFP_DMA
> (trusting it to be 4GB) #elif __x86_64__ (use other hacks like
> the swiotlb because 16MB is not enough) ... . This was quite
> ugly and is now obsolete.
>
> These should be now converted to use GFP_DMA32 unconditionally. I haven't done
> this yet. Or best only use pci_alloc_consistent/dma_alloc_coherent
> which will use GFP_DMA32 transparently.
>
> Signed-off-by: Andi Kleen <ak@suse.de>
>

<snip>

> Index: linux/include/linux/mmzone.h
> ===================================================================
> --- linux.orig/include/linux/mmzone.h
> +++ linux/include/linux/mmzone.h
> @@ -70,11 +70,12 @@ struct per_cpu_pageset {
>  #endif
>
>  #define ZONE_DMA               0
> -#define ZONE_NORMAL            1
> -#define ZONE_HIGHMEM           2
> +#define ZONE_DMA32             1
> +#define ZONE_NORMAL            2
> +#define ZONE_HIGHMEM           3
>
> -#define MAX_NR_ZONES           3       /* Sync this with ZONES_SHIFT */
> -#define ZONES_SHIFT            2       /* ceil(log2(MAX_NR_ZONES)) */
> +#define MAX_NR_ZONES           4       /* Sync this with ZONES_SHIFT */
> +#define ZONES_SHIFT            3       /* ceil(log2(MAX_NR_ZONES)) */
>
>
>  /*
> @@ -90,7 +91,7 @@ struct per_cpu_pageset {
>   * be 8 (2 ** 3) zonelists.  GFP_ZONETYPES defines the number of possible
>   * combinations of zone modifiers in "zone modifier space".
>   */
> -#define GFP_ZONEMASK   0x03
> +#define GFP_ZONEMASK   0x07
>  /*
>   * As an optimisation any zone modifier bits which are only valid when
>   * no other zone modifier bits are set (loners) should be placed in
> @@ -110,6 +111,7 @@ struct per_cpu_pageset {
>   * into multiple physical zones. On a PC we have 3 zones:

Now 4 zones.

>   *
>   * ZONE_DMA      < 16 MB       ISA DMA capable memory
> + * ZONE_DMA32       0 MB       Empty
>   * ZONE_NORMAL 16-896 MB       direct mapped by the kernel
>   * ZONE_HIGHMEM         > 896 MB       only page cache and user processes
>   */

<snip>

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
