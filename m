Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132201AbRAUK4V>; Sun, 21 Jan 2001 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135279AbRAUK4L>; Sun, 21 Jan 2001 05:56:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132201AbRAUKz6>;
	Sun, 21 Jan 2001 05:55:58 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101211051.f0LApFv02203@flint.arm.linux.org.uk>
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 21 Jan 2001 10:51:15 +0000 (GMT)
Cc: johannes@erdfelt.com (Johannes Erdfelt), linux-kernel@vger.kernel.org
In-Reply-To: <3A6A9F9A.3CDE1B05@colorfullife.com> from "Manfred Spraul" at Jan 21, 2001 09:36:42 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
> Not yet, but that would be a 2 line patch (currently it's hardcoded to
> BYTES_PER_WORD align or L1_CACHE_BYTES, depending on the HWCACHE_ALIGN
> flag).

I don't think there's a problem then.  However, if slab can be told "I want
1024 bytes aligned to 1024 bytes" then I can get rid of
arch/arm/mm/small_page.c (separate problem to the one we're discussing
though) ;)

> But there are 2 other problems:
> * kmem_cache_alloc returns one pointer, pci_alloc_consistent 2 pointers:
> one dma address, one virtual address.
> * The code relies on the virt_to_page() macro.

What I'm wondering is what about a wrapper around the slab allocator, in
a similar way to pci_alloc_consistent() is a wrapper around gfp.  Since
the slab allocator returns "pointers" in the same space as gfp returns
page references, there shouldn't be a problem (Linus may complain here).

ie, we could make pci_alloc_consistent() a little more intelligent and
allocate from the slab for small sizes, but use gfp for larger sizes?

Comments, anyone (DaveM, Linus, et al) ?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
