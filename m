Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUH1ONY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUH1ONY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 10:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUH1ONY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 10:13:24 -0400
Received: from zero.aec.at ([193.170.194.10]:3332 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266311AbUH1ONQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 10:13:16 -0400
To: Takao Indoh <indou.takao@soft.fujitsu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4][diskdump] x86-64 support
References: <2y80v-1lR-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 28 Aug 2004 16:13:10 +0200
In-Reply-To: <2y80v-1lR-13@gated-at.bofh.it> (Takao Indoh's message of "Sat,
 28 Aug 2004 11:50:07 +0200")
Message-ID: <m3r7prcpvt.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takao Indoh <indou.takao@soft.fujitsu.com> writes:

Hallo,

> Hi all,
>
> Here is the latest diskdump patch for kernel 2.6.8.1.
>
> - Supports x86_64

Thanks for doing this work.

> When I tested diskdump on x86-64 machine, I found that memory dump of
> the following two areas failed.
>
> 1) 04000000 - 07ffffff
> 2) around last two page
>
> Memory dump of the area 2) failed because page->flag was broken.

Broken in what way? That should probably just be fixed in the core
kernel.

> So I compare PFN to page_to_pfn(pfn_to_page(PFN)) and skip this PFN
> if these value is different.
>
> 		page = pfn_to_page(nr);
> 		if (nr != page_to_pfn(page)) {
> 			/* page_to_pfn() is called from kmap_atomic().
> 			 * If page->flag is broken, it specified a wrong
> 			 * zone and it causes kmap_atomic() fail.
> 			 */
> 			Err("Bad page. PFN %lu flags %lx\n",
> 			    nr, (unsigned long)page->flags);
> 			memset(scratch + blk_in_chunk * PAGE_SIZE, 0,
> 			       PAGE_SIZE);
> 			sprintf(scratch + blk_in_chunk * PAGE_SIZE,
> 				"Bad page. PFN %lu flags %lx\n",
> 			 	 nr, (unsigned long)page->flags);
> 			goto write;
> 		}
>
>
> Memory dump of the area 1) failed because this area was not mapped to
> vaddr. Diskdump checks page using page_is_ram() and maps it using 

Yes, this is done intentionally because the IOMMU is not 100% cache
coherent in the way Linux uses it and accesses to the aperture 
area by the CPU are not allowed. To prevent mistakes or the CPU 
prefetching by its own into it it is unmapped.

SLAB DEBUG can cause the same thing and even on other architectures, so 
you really need to handle it generically.


> kmap_atomic(). In the area 1), both page_is_ram() and kmap_atomic()
> return true, but page is not attached to the page table.

kmap_atomic() on 64bit always just returns the pointer, it's a nop.
Even on 32bit it cannot fail.

> I think this area is AGP Aperture. I found this message in the dmesg.
>
>     PCI-DMA: Disabling AGP.
>     PCI-DMA: aperture base @ 4000000 size 65536 KB
>     PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
>
> To resolve this problem, I check page using kern_addr_valid() before
> kmap_atomic().

kern_addr_valid is probably not a bad way to solve it, although it is
a bit costly.

When the page is not mapped you could always map it on your own with
ioremap(), but that address cannot be used for any DMA, so it 
may not work. Skipping them is probably ok.

-Andi

