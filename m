Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271567AbRHPM1h>; Thu, 16 Aug 2001 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271568AbRHPM11>; Thu, 16 Aug 2001 08:27:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63370 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271567AbRHPM1U>;
	Thu, 16 Aug 2001 08:27:20 -0400
Date: Thu, 16 Aug 2001 05:27:27 -0700 (PDT)
Message-Id: <20010816.052727.68039859.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816140317.Y4352@suse.de>
In-Reply-To: <20010816135150.X4352@suse.de>
	<20010816.045642.116348743.davem@redhat.com>
	<20010816140317.Y4352@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Thu, 16 Aug 2001 14:03:17 +0200

   > That is why PCI_MAX_DMA32, or whatever you would like to name it, does
   > not make any sense.  It can be a shorthand for drivers themselves, but
   > that is it and personally I'd rather they just put the bits there
   > explicitly.
   
   Drivers, right. THe block stuff used it in _one_ place -- the
   BLK_BOUNCE_4G define, to indicated the need to bounce anything above 4G.
   But no problem, I can just define that to 0xffffffff myself.

How can "the block stuff" (ie. generic code) make legal use of this
value?  Which physical bits it may address, this is a device specific
attribute and has nothing to with with 4GB and highmem and PCI
standard specifications. :-)

In fact, this is not only a device specific attribute, it also has
things to do with elements of the platform.

This is why we have things like pci_dma_supported() and friends.
Let me give an example, for most PCI controllers on Sparc64 if your
device can address the upper 2GB of 32-bit PCI space, one may DMA
to any physical memory location via the IOMMU these controllers have.

There may easily be HIGHMEM platforms which operate this way.  So the
result is that CONFIG_HIGHMEM does _not_ mean ">=4GB memory must be
bounced".

Really, 0xffffffff is a meaningless value.  You have to test against
device indicated capabilities for bouncing decisions.

You do not even know how "addressable bits" translates into "range of
physical memory that may be DMA'd to/from by device".  If an IOMMU is
present on the platform, these two things have no relationship
whatsoever.  These two things happen to have a direct relationship
on x86, but that is as far as it goes.

Enough babbling on my part, I'll have a look at your bounce patch
later today. :-)

Later,
David S. Miller
davem@redhat.com
