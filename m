Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUFXRQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUFXRQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUFXRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:16:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55263
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266238AbUFXRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:16:16 -0400
Date: Thu, 24 Jun 2004 19:16:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624171620.GN30687@dualathlon.random>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <s5hsmclgcwl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmclgcwl.wl@alsa2.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 06:04:58PM +0200, Takashi Iwai wrote:
> At Thu, 24 Jun 2004 17:29:46 +0200,
> Andrea Arcangeli wrote:
> > 
> > On Thu, Jun 24, 2004 at 04:58:24PM +0200, Takashi Iwai wrote:
> > > At Thu, 24 Jun 2004 16:42:58 +0200,
> > > Andi Kleen wrote:
> > > > 
> > > > On Thu, 24 Jun 2004 16:36:47 +0200
> > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > > 
> > > > > At Thu, 24 Jun 2004 13:29:00 +0200,
> > > > > Andi Kleen wrote:
> > > > > > 
> > > > > > > Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> > > > > > > allocated pages are out of dma mask, just like in pci-gart.c?
> > > > > > > (with ifdef x86-64)
> > > > > > 
> > > > > > That won't work reliable enough in extreme cases.
> > > > > 
> > > > > Well, it's not perfect, but it'd be far better than GFP_DMA only :)
> > > > 
> > > > The only description for this patch I can think of is "russian roulette" 
> > > 
> > > Even if we have a bigger DMA zone, it's no guarantee that the obtained
> > > page is precisely in the given mask.  We can unlikely define zones
> > > fine enough for all different 24, 28, 29, 30 and 31bit DMA masks.
> > > 
> > > 
> > > My patch for i386 works well in most cases, because such a device is
> > > usually equipped on older machines with less memory than DMA mask.
> > > 
> > > Without the patch, the allocation is always <16MB, may fail even small
> > > number of pages.
> > 
> > why does it fail? note that with the lower_zone_reserve_ratio algorithm I
> > added to 2.4 all dma zone will be reserved for __GFP_DMA allocations so
> > you should have troubles only with 2.6, 2.4 should work fine.
> > So with latest 2.4 it has to fail only if you already allocated 16M with
> > pci_alloc_consistent which sounds unlikely.
> 
> If a driver needs large contiguous (e.g. a coule of MB) pages and the
> memory is fragmented, it may still fail.  But it's anyway very
> rare...

Yes. This is why I suggested to use GFP_KERNEL _after_ GFP_DMA has
failed, not the other way around. As Andi said in big systems you're
pretty much guaranteed that GFP_KERNEL will always fail.

> However, 16MB isn't enough in some cases indeed.  For example, the
> following devices are often problematic:
> 
> - SB Live (emu10k1)
>   This needs many single pages for WaveTable synthesis per user's
>   request (up to 128MB).  It sets 31bit DMA mask (sigh...)

then it may never work. If the lowmem below 4G is all allocated in
anonymous memory and you've no swap, there's no way, absolutely no way
to make the above work. I start to think you should fail insmod if the
machine has more than 2^31 bytes of ram being used by the kernel.

All we can do is to give it a chance to work, that is to call GFP_KERNEL
_after_ GFP_DMA has failed, but again  there's no guarantee that it will
work, even if you've only a few gigs of ram.

> - ES1968
>   This requires 28bit DMA mask and a single big buffer for all PCM
>   streams.

this is just the order > 0 issue.

Note that 2.6 limits the defragmentation to order == 3, order 4 and
higher are ""guaranteed"" to always fail, this wasn't the case in 2.4.
2.6 adds a few terrible hacks called __GFP_REPEAT and __GFP_NOFAIL,
those are all deadlock prone as much as order < 4 allocations. The basic
deadlocks in 2.6 are due the lack of return value from
try_to_free_pages, 2.6 has no clue when it made progress or not, it can
only try to kill tasks when the highmem and swap are exausted, but there
are tons of other conditions where it can deadlock including while
confusing the oom killer with apps using mlock.

> Also there are other devices with <32bit DMA masks, for example, 24bit
> (als4000, es1938, sonicvibes, azt3328), 28bit (ice1712, maestro3),
> 30bit (trident), 31bit (ali5451)...

creating a GFP_PCI28 zone at _runtime_ only for the intel
implementations that unfortunately lacks an iommu might not be too bad.

Note that one other relevant thing we can add (with O(N) complexity) is
an alloc_pages_range() that walks the whole freelist by hand searching
for anything in the physuical range passed as parameter. But it would
need to be used with care since it'd loop in kernel space for a loong
time.  irq disabling timeouts may also trigger, so implementing it safe
won't be trivial.
