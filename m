Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUFXPmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUFXPmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUFXPmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:42:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20683
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265540AbUFXPlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:41:37 -0400
Date: Thu, 24 Jun 2004 17:41:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@muc.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624154143.GL30687@dualathlon.random>
References: <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624144551.GI983@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624144551.GI983@hygelac>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:45:51AM -0500, Terence Ripperda wrote:
> On Thu, Jun 24, 2004 at 04:13:47AM -0700, tiwai@suse.de wrote:
> > > pci_alloc_consistent is limited to 16MB, but so far nobody has really
> > > complained about that. If that should be a real issue we can make
> > > it allocate from the swiotlb pool, which is usually 64MB (and can
> > > be made bigger at boot time) 
> > 
> > Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> > allocated pages are out of dma mask, just like in pci-gart.c?
> > (with ifdef x86-64)
> 
> pci_alloc_consistent (at least on x86-64) does do this. one of the problems
> I've seen in experimentation is that GFP_KERNEL tends to allocate from the
> top of memory down. this means that all of the GFP_KERNEL allocations are >
> 32-bits, which forces us down to GFP_DMA and the < 16M allocations.
> 
> I've mainly tested this after a cold boot, so after running for a while,
> GFP_KERNEL may hit good allocations a lot more.

it's trivial to change the order in the freelist to allocate from lower
address first, but the point is still that over time that will be
random.

the 16M must be reserved enterely to the __GFP_DMA on any machine with
>=1G of ram, and the lowmem_reserve_ratio algorithm accomplish this and
it scales down the reserve ratio according to the balance between lowmem
and dma zone.

I believe if something you should try with GFP_KERNEL if GFP_DMA fails,
not the other way around. btw, 2.6 is even more efficient in shrinking
and paging out the dma zone than it could be in 2.4.
