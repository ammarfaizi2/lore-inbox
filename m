Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268569AbRHPNIw>; Thu, 16 Aug 2001 09:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271277AbRHPNIm>; Thu, 16 Aug 2001 09:08:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268569AbRHPNIc>;
	Thu, 16 Aug 2001 09:08:32 -0400
Date: Thu, 16 Aug 2001 06:08:42 -0700 (PDT)
Message-Id: <20010816.060842.99454999.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816145636.B4352@suse.de>
In-Reply-To: <20010816140317.Y4352@suse.de>
	<20010816.052727.68039859.davem@redhat.com>
	<20010816145636.B4352@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Thu, 16 Aug 2001 14:56:36 +0200

   On Thu, Aug 16 2001, David S. Miller wrote:
   > Enough babbling on my part, I'll have a look at your bounce patch
   > later today. :-)
   
   Wait for the next version, I'll clean up the PCI DMA bounce value
   stuff first and post a new version.

Ok.  I was thinking about the 4GB issue and we could describe it
simply using one platform macro define that could be boolean tested in
both your new block stuff and a fixed up version of the networking's
current ugly HIGHMEM tests.

/* PCI address are equivalent to memory physical addresses.
 * As a consequence, the lower 4GB of main memory may be
 * addressable using PCI single-address cycles.  The rest of
 * memory requires the use of dual-address cycles.
 *
 * If this is false, the kernel assumes that some hardware
 * translation mechanism exists to allow all of physical
 * memory to be accessed using single-address cycles.
 */
#define PCI_DMA_PHYS_IS_BUS	(1)

So you'd get things like:

	if (PCI_DMA_PHYS_IS_BUS) {
		/* We might need to bounce this. */
		if (! dev_dma_in_range(dev, address + len))
			address = make_bounce_buffer(dev, address, len);
	} else {
		/* All physical memory is legal for DMA so there
		 * is nothing to check.
		 */
	}

or whatever.  You get the idea.

This is really interesting because it means things like the following.

A device which is only capable of 32-bit PCI addressing can still just
use the pci_map_{single,sg}() interfaces yet DMA to all of system
memory.  The block and networking layers will never try to bounce stuff.

Basically, this is what happens today with non-CONFIG_HIGHMEM
64-bit platforms, with a particular cost for the cases where
translation is done via bounce buffers (notably ia64).

What do you think?

Later,
David S. Miller
davem@redhat.com
