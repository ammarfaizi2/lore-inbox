Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbREVUOr>; Tue, 22 May 2001 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbREVUOh>; Tue, 22 May 2001 16:14:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23909 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262769AbREVUOY>; Tue, 22 May 2001 16:14:24 -0400
Date: Tue, 22 May 2001 22:14:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel diff_small_2.4.5pre4_2.4.5pre5
Message-ID: <20010522221418.J15155@athlon.random>
In-Reply-To: <200105222004.f4MK4dR24584@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105222004.f4MK4dR24584@athlon.random>; from andrea@athlon.random on Tue, May 22, 2001 at 10:04:39PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 10:04:39PM +0200, Andrea Arcangeli wrote:
> diff -urN 2.4.5pre4/arch/alpha/kernel/pci_iommu.c 2.4.5pre5/arch/alpha/kernel/pci_iommu.c
> --- 2.4.5pre4/arch/alpha/kernel/pci_iommu.c	Sun Apr  1 01:17:07 2001
> +++ 2.4.5pre5/arch/alpha/kernel/pci_iommu.c	Tue May 22 22:04:07 2001
> @@ -402,8 +402,20 @@
>  	paddr &= ~PAGE_MASK;
>  	npages = calc_npages(paddr + size);
>  	dma_ofs = iommu_arena_alloc(arena, npages);
> -	if (dma_ofs < 0)
> -		return -1;
> +	if (dma_ofs < 0) {
> +		/* If we attempted a direct map above but failed, die.  */
> +		if (leader->dma_address == 0)
> +			return -1;
> +
> +		/* Otherwise, break up the remaining virtually contiguous
> +		   hunks into individual direct maps.  */
> +		for (sg = leader; sg < end; ++sg)
> +			if (sg->dma_address == 2 || sg->dma_address == -2)
> +				sg->dma_address = 0;
> +
> +		/* Retry.  */
> +		return sg_fill(leader, end, out, arena, max_dma);
> +	}
>  
>  	out->dma_address = arena->dma_base + dma_ofs*PAGE_SIZE + paddr;
>  	out->dma_length = size;

this is just broken as I said a few hours ago on l-k. please replace ==
2 with == 1 as described in earlier email. However it's not a
showstopper because it will trigger only after running of pci mappings
(and by that time things are going to break pretty soon anyways on the
much bigger than 2G boxes, where the 2G direct window has low probablity
to save you), the fact I found this patch in in I assume is your
agreemnt that the pci mapping bugs are an issue also for 2.4, good.

I couldn't hack all the day long today, I will finish the alpha updates
before tomorrow though.

Andrea
