Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVDFPNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVDFPNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVDFPNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:13:20 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:3805 "EHLO laptop.blackstar.nl")
	by vger.kernel.org with ESMTP id S262221AbVDFPNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:13:13 -0400
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
From: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504061040420.22273@chaos.analogic.com>
References: <1112781027.2687.6.camel@laptop.blackstar.nl>
	 <tnxzmwc9gun.fsf@arm.com>
	 <Pine.LNX.4.61.0504061040420.22273@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1112800390.2687.36.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Apr 2005 17:13:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 16:53, Richard B. Johnson wrote:
> On Wed, 6 Apr 2005, Catalin Marinas wrote:
> 
> > Bas Vermeulen <bvermeul@blackstar.xs4all.nl> wrote:
> >> I am currently working on the bfinnommu linux port for the BlackFin 533.
> >> I need to grab the top 1 MB of memory so I can give it out to drivers
> >> that need non-cached memory for DMA operations.
> >
> > I did this long time ago (on a 2.4 kernel), trying to avoid a hardware
> > problem. I re-ordered the zones so that ZONE_DMA came after
> > ZONE_NORMAL. Since the DMA memory was quite small (less than 1MB), I
> > also put a "break" before "case ZONE_DMA" in the
> > build_zonelists_node() functions to avoid the allocation fallback.
> >
> > -- 
> > Catalin
> >
> 
> 
> 1 Megabyte of DMA RAM should be available using conventional
> means __get_dma_pages(GFP_KERNEL, 0x100) soon after boot.

The 1 Megabyte of DMA RAM needs to be aligned on 1 MB, since I have to
tell the (software) cache manager to make it uncacheable (and that works
in blocks of 1M or 4M).
I probably could allocate 2M, get the alignment correctly, then free the
pages I don't need/want, and feed that range to the cache manager.
I'm not entirely sure I can do that before the call to free_all_bootmem,
since all pages are reserved before that.

Is there a way to do this directly (eg, just nab the pages I want/need,
and tell the zones not to use them?)

> Or just use mem= on the boot command line. This will tell
> the kernel the extent of memory to use. Any RAM after that
> is available. Your driver can access kernel variable, "num_physpages"
> to find the last page it is supposed to use. Some kernel versions
> actually touch the next page so, to be safe, your code can
> use:
>     mem = (num_physpages * PAGE_SIZE) + PAGE_SIZE;
> ... for the first available free RAM.

That's my backup plan, but I'd prefer to do it properly in kernel memory
space (if at all possible).

> Note that there may be PCI BARS allocated in this address-space if
> you have 4 Gb of RAM. You need to be carefull.

BlackFin doesn't have PCI (and no MMU, so a more limited address space
than 4 GB).

Thanks for the insight so far,

Bas Vermeulen

