Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHLRXA>; Sun, 12 Aug 2001 13:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHLRWu>; Sun, 12 Aug 2001 13:22:50 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:5128 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269390AbRHLRWf>; Sun, 12 Aug 2001 13:22:35 -0400
Date: Sun, 12 Aug 2001 10:21:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8aa1
In-Reply-To: <20010812190202.H737@athlon.random>
Message-ID: <Pine.LNX.4.33.0108121003520.15697-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Aug 2001, Andrea Arcangeli wrote:
>
> virt_to_bus(page_address(pte_page(pte))) actually returns the right bus
> address on x86 in a range of 4G,

No it doesn't.

page_address(page) is (page)->virtual, which is going to be zero for
non-kmapped pages, and going to ve the virtual mapping of a kmapped page.
NEITHER of which will translate correctly with "virt_to_bus()".

In short, "virt_to_bus(page_address(pte_page(pte)))" only works for the
first 1GB. Always have, always will.

> But of course calling page_address() on anything highmem is ugly like
> hell even if it ""incidentally"" works on 2.4 up to 4G (it temporarly
> wraps around in userspace).

It incidentally DOES NOT WORK.

It happens to work for you in the non-highmem case when you disabled
"page->virtual", but in that case HIGHMEM obviously doesn't work at all,
so you cannot actually ever _use_ anything but the low 1GB anyway, so it
ends up not working in practice even then.

So stop making these things up.

> For your suggestion of the pte_to_pfn and the reverse I'm not sure why
> they're needed (of course for the arch is extremely simple to implement
> pte_to_pfn, on x86 is a shitright of 12, on alpha it's a shiftright of
> 32, much simpler than pte_page, pte_page has to deal with discontigmem
> on numa system so it's slower). But in general people shouldn't use
> pte_page in drivers, they shouldn't walk pagetables, the vm of linux
> walks pagetables instead.

I agree. However, if you looked at how I used it, it was just as a helper
function for doing the "struct page -> physical" and "struct page -> bus"
address calculations, which _are_ valid.

Think of the "page_to_pfn()" as an internal helper routine that avoids the
overflow thing.

But also, there is actually at least one useful case in the VM layer that
wouldn't mind having it - look at what the VALID_PAGE() users in
mm/memory.c, and look at the code we generate now (first we do
"pte_page()", then we take the page and turn it into a PFN, and then we
compare that PFN against the highest PFN we support - and all without
realizing that we already _had_ the PFN in the page table and could have
avoided one conversion altogether).

Also, look at remap_pte_range: it would actually be a _lot_ better off
using PFN's instead of the current physical addresses. Right now it cannot
handle 64-bit remapping on x86, and the reason is again that we don't have
good conversion functions..

> So I believe a kind of page_to_bus64 should be implemented, and it should
> possibly return dma64_addr_t typedeffed as 'unsigned long long'.

Fair enough, that sounds like a good idea too.

> But the real problem is how to have the driver understand that on some
> arch it should keep using the iommu 32bit api instead of DAC because
> those archs have crappy PCI64 DAC hardware implementation that inhibits
> pci prefetch cycles or stuff like that that leads to bad performance
> (DaveM can certainly provide more details). This is the hard part of the
> API I believe. So we either need the driver to have two explicit cases
> (then the plain page_to_bus64 would not need other changes), or to hide
> the iommu stuff inside the page_to_bus64, but in such case it means we
> also need to have a second function to release the pte ala pci_unmap_*.

Yes. And we should call them something like "pci_kmap()", "pci_kunmap()",
because that is exactly what they'd be.

> And what the driver should ever do when its device is 32bit and it gets
> a bus address out of page_to_bus64 that overflows 32bit and no iommu is
> available?

It shouldn't use page_to_bus64(), I believe. That function only makes
sense for 64-bit aware drivers.

32-bit drivers could still use the regular PCI mapping functions, which
will map it down to 32 bits as far as the driver is concerned, even if the
"real" unmapped bus address might be >32 bits. Agreed?

		Linus

