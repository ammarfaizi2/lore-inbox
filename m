Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTFFHWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTFFHWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:22:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1257 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265374AbTFFHWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:22:33 -0400
Date: Fri, 06 Jun 2003 00:32:30 -0700 (PDT)
Message-Id: <20030606.003230.15263591.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16096.16492.286361.509747@napali.hpl.hp.com>
References: <16096.14281.621282.67906@napali.hpl.hp.com>
	<20030605.235249.35666087.davem@redhat.com>
	<16096.16492.286361.509747@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Fri, 6 Jun 2003 00:19:08 -0700

   PCI_DMA_BUS_IS_PHYS (and it's description) is quite misleading: it
   claims that it has something to do with there being an equivalence
   between PCI bus and physical addresses.  That's actually the case for
   (small) ia64 platforms so that's why we ended up setting it to 1.
   
It does have to do with such an equivalence.  If your port couldn't
work if drivers use the deprecated virt_to_bus/bus_to_virt, you must
set PCI_DMA_BUS_IS_PHYS to zero.

The whole block layer makes all kinds of assumptions about what
physically contiguous addresses mean about how they'll be contiguous
in the bus addresses the device will actually use to perform the
DMA transfer.

Likewise, when PCI_DMA_BUS_IS_PHYS is zero, it knows that many
IOMMU'ish things can occur such as taking non-physically-contiguous
pages and mapping them using the IOMMU to create bus-contiguous
mappings.

We could convert the few compile time checks of PCI_DMA_BUS_IS_PHYS
so that you can set this based upon the configuration of the machine
if for some configurations it is true.  drivers/net/tg3.c is the
only offender, my bad :-)
