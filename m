Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUFYRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUFYRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUFYRa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:30:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9966
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266808AbUFYRao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:30:44 -0400
Date: Fri, 25 Jun 2004 19:30:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040625173046.GJ30687@dualathlon.random>
References: <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <s5hsmclgcwl.wl@alsa2.suse.de> <20040624171620.GN30687@dualathlon.random> <s5hbrj8hkm9.wl@alsa2.suse.de> <20040624184447.GW30687@dualathlon.random> <s5hacyrfxhv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hacyrfxhv.wl@alsa2.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 05:50:04PM +0200, Takashi Iwai wrote:
> --- linux-2.6.7/arch/i386/kernel/pci-dma.c-dist	2004-06-24 15:56:46.017473544 +0200
> +++ linux-2.6.7/arch/i386/kernel/pci-dma.c	2004-06-25 17:43:42.509366917 +0200
> @@ -23,11 +23,22 @@ void *dma_alloc_coherent(struct device *
>  	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
>  		gfp |= GFP_DMA;
>  
> + again:
>  	ret = (void *)__get_free_pages(gfp, get_order(size));
>  
> -	if (ret != NULL) {
> +	if (ret == NULL) {
> +		if (dev && (gfp & GFP_DMA)) {
> +			gfp &= ~GFP_DMA;

I would find cleaner to use __GFP_DMA in the whole file, this is not
about your changes, previous code used GFP_DMA too. The issue is that if
we change GFP_DMA to add a __GFP_HIGH or similar, the above will clear
the other bitflags too.

> +		    (((unsigned long)*dma_handle + size - 1) & ~(unsigned long)dev->coherent_dma_mask)) {
> +			free_pages((unsigned long)ret, get_order(size));
> +			return NULL;
> +		}

I would do the memset and setting of dma_handle after the above check.

this approch looks fine, thanks.
