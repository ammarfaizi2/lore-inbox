Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFGGeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTFGGeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:34:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2179 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262363AbTFGGeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:34:13 -0400
Date: Fri, 06 Jun 2003 23:44:01 -0700 (PDT)
Message-Id: <20030606.234401.104035537.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306062013.h56KDcLe026713@napali.hpl.hp.com>
References: <16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
	<200306062013.h56KDcLe026713@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Fri, 6 Jun 2003 13:13:38 -0700

   Yes, but the comment certainly is confusing.  How about something like
   this:
   
No arguments.

     David> The whole block layer makes all kinds of assumptions about
     David> what physically contiguous addresses mean about how they'll
     David> be contiguous in the bus addresses the device will actually
     David> use to perform the DMA transfer.
   
   This sounds all very dramatic, but try as I might, all I find is three
   places where PCI_DMA_BUS_IS_PHYS is used:
   
   	- ide-lib.c: used to disable bounce buffering
   	- scsi_lib.c: used to disable bounce buffering

Fix your grep, 

   	- tg3.c: what the heck??
   
In order to workaround a "just below 4GB dma address" bug in the
chip, we have to have a reliable way to "remap" the given networking
buffer to some other DMA address that does not meet the hw bug case.

If we don't have an IOMMU, we have to change the buffer itself and
we accomplish this with SKB copy.

But on an IOMMU system, we could end up mapping to the same bogus
DMA address.  So we have to solve this problem by keeping the
existng bad mapping, doing a new DMA mapping, then trowing away
the old one.
   
   Did I get this right (or at least close enough)?
   
Precisely.

   Otherwise, you could just always use the copy-the-entire-buffer
   workaround.

The new PCI dma mapping I make could map to the SAME bad DMA
address, that's the problem.  I could loop forever making new
DMA mappings on an IOMMU system, each and every one falls into
the hw bug case.

   I really dislike PCI_DMA_BUS_IS_PHYS, because it introduces a
   discontinuity.  I don't think it should be necessary.
   
I totally disagree.

     David> We could convert the few compile time checks of
     David> PCI_DMA_BUS_IS_PHYS so that you can set this based upon the
     David> configuration of the machine if for some configurations it is
     David> true.  drivers/net/tg3.c is the only offender, my bad :-)
   
   Yes.  Would you mind fixing that?
   
Sure, no problem.

   
