Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbREVNYj>; Tue, 22 May 2001 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbREVNY3>; Tue, 22 May 2001 09:24:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32021 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261653AbREVNYS>; Tue, 22 May 2001 09:24:18 -0400
Date: Tue, 22 May 2001 15:22:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Cc: rth@twiddle.net
Subject: Re: alpha iommu fixes
Message-ID: <20010522152220.A15155@athlon.random>
In-Reply-To: <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010521105339.A1907@twiddle.net>; from rth@twiddle.net on Mon, May 21, 2001 at 10:53:39AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 10:53:39AM -0700, Richard Henderson wrote:
> diff -ruNp linux/arch/alpha/kernel/pci_iommu.c linux-new/arch/alpha/kernel/pci_iommu.c
> --- linux/arch/alpha/kernel/pci_iommu.c	Fri Mar  2 11:12:07 2001
> +++ linux-new/arch/alpha/kernel/pci_iommu.c	Mon May 21 01:25:25 2001
> @@ -402,8 +402,20 @@ sg_fill(struct scatterlist *leader, stru
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
					    ^^^^ should be == 1

> +				sg->dma_address = 0;
> +
> +		/* Retry.  */
> +		return sg_fill(leader, end, out, arena, max_dma);
> +	}
>  
>  	out->dma_address = arena->dma_base + dma_ofs*PAGE_SIZE + paddr;
>  	out->dma_length = size;

I am going to merge this one (however it won't help on the big memory
machines, it will only try to hide the problem on the machines with not
much memory above 2G).

Andrea
