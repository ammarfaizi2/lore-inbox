Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSFLJ2R>; Wed, 12 Jun 2002 05:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSFLJ2Q>; Wed, 12 Jun 2002 05:28:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28111 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317672AbSFLJ2Q>;
	Wed, 12 Jun 2002 05:28:16 -0400
Date: Wed, 12 Jun 2002 02:22:58 -0700 (PDT)
Message-Id: <20020612.022258.81407248.davem@redhat.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D06F2FF.8070109@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Wed, 12 Jun 2002 00:06:39 -0700

   David S. Miller wrote:
   > 0 is a valid PCI dma address on many platforms.  This is part
   > of the problem.
   
   OK, so a new call syntax would be desirable.  Or reserving page zero
   even on such platforms.
   
Or, better yet, define a PCI_BAD_ADDR per-arch.
   
   > Huh?  The whole idea is that it is memory for PCI dma, it has to be
   > PCI in nature.  If you want a kmalloc'ish thing, simple use
   > pci_alloc_consistent and carve up the pages you get internally.
   
   And the reason that logic doesn't lead us to rip kmalloc() out of
   the kernel (in favor of the page allocator) is ... what?  Every driver
   shouldn't _need_ to write yet another malloc() clone, that's all I'm
   saying; that'd be a waste.
   
That is why we have the PCI pool thing, it's PCI alloc consistent +
SLAB carving.
   
   Certainly hanging some sort of memory allocator object off struct device
   should be pretty cheap.  At least for USB, all devices on the same bus
   could share the same allocator.  Not that I know PCI that well, but I
   suspect that could be true there too ... more sharing, less internal
   fragmentation, and more efficient use of various resources.
   
These instances we are talking about want to allocate multiple
instance of the same object (thus the same size).  They are not
allocating things like variable length strings and whatnot.

That is why I keep suggesting PCI pools, it's the perfect kind of
setup (and the easiest to implement).  A generic kmalloc() out of
pages is more to implement, certainly.

If you want to hide this behind a usb_dma_pool_create,
usb_dma_pool_alloc etc. kind of interface that calls back into the
host controller layer to get the pci_dev etc., that's fine.

Now enough talking and someone implement this, talk is cheap.
