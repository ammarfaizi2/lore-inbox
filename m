Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUFXPaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUFXPaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUFXPaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:30:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41929
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265689AbUFXP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:29:46 -0400
Date: Thu, 24 Jun 2004 17:29:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624152946.GK30687@dualathlon.random>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy8mdgfzj.wl@alsa2.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:58:24PM +0200, Takashi Iwai wrote:
> At Thu, 24 Jun 2004 16:42:58 +0200,
> Andi Kleen wrote:
> > 
> > On Thu, 24 Jun 2004 16:36:47 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Thu, 24 Jun 2004 13:29:00 +0200,
> > > Andi Kleen wrote:
> > > > 
> > > > > Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> > > > > allocated pages are out of dma mask, just like in pci-gart.c?
> > > > > (with ifdef x86-64)
> > > > 
> > > > That won't work reliable enough in extreme cases.
> > > 
> > > Well, it's not perfect, but it'd be far better than GFP_DMA only :)
> > 
> > The only description for this patch I can think of is "russian roulette" 
> 
> Even if we have a bigger DMA zone, it's no guarantee that the obtained
> page is precisely in the given mask.  We can unlikely define zones
> fine enough for all different 24, 28, 29, 30 and 31bit DMA masks.
> 
> 
> My patch for i386 works well in most cases, because such a device is
> usually equipped on older machines with less memory than DMA mask.
> 
> Without the patch, the allocation is always <16MB, may fail even small
> number of pages.

why does it fail? note that with the lower_zone_reserve_ratio algorithm I
added to 2.4 all dma zone will be reserved for __GFP_DMA allocations so
you should have troubles only with 2.6, 2.4 should work fine.

So with latest 2.4 it has to fail only if you already allocated 16M with
pci_alloc_consistent which sounds unlikely.

the fact 2.6 lacks the lower_zone_reserve_ratio algorithm is a different
issue, but I'm confortable there's no other possible algorithm to solve
this memory balancing problem completely so there's no way around a
forward port.

well 2.6 has a tiny hack like some older 2.4 that attempts to do what
lower_zone_reserve_ratio does, but it's not nearly enough, there's no
per-zone-point-of-view watermark in 2.6 etc.. 2.6 actually has a more
hardcoded hack for highmem, but the lower_zone_reserve_ratio has
absolutely nothing to do with highmem vs lowmem. it's by pure
coincidence that it avoids highmem machine to lockup without swap, but
the very same problem happens on x86-64 with lowmem vs dma.
