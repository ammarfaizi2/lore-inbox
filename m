Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUBTCdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267710AbUBTCdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:33:17 -0500
Received: from palrel11.hp.com ([156.153.255.246]:43671 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S267708AbUBTCc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:32:58 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.29131.957886.530446@napali.hpl.hp.com>
Date: Thu, 19 Feb 2004 18:32:43 -0800
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: Ia64 Linux <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 oops ia64 Itanium1 with Silicon Image IDE
In-Reply-To: <20040220005623.GI11475@cse.unsw.EDU.AU>
References: <20040220005623.GI11475@cse.unsw.EDU.AU>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Feb 2004 11:56:23 +1100, Darren Williams <dsw@gelato.unsw.edu.au> said:

  Darren> We have an Itainum 1 that oopses on boot with a Silicon
  Darren> Imagae IDE pci controller. I can boot the same image on a
  Darren> machine with the same setup except for RAM, which is
  Darren> 1GB. Looking through the archives it seems to be related to
  Darren> the following:

  Darren> http://www.ussg.iu.edu/hypermail/linux/kernel/0306.0/1098.html

Hmmh, trying to remember how this all works...

PCI_DMA_BUS_IS_PHYS currently returns its value based on
ia64_max_iommu_merge_mask.  This variable is primarily used to tell
the block-layer (via BIO_VMERGE_BOUNDARY and then
BIOVEC_VIRT_MERGEABLE) whether two physically discontiguous buffers
can be merged via an I/O MMU, such that they appear contiguous from
the perspective of device DMA.

Your machine doesn't have a hardware I/O MMU so it's using swiotlb,
which simulates the effect of a hardware I/O MMU but of course it
cannot do virtual merging, so it has to leave
ia64_max_iommu_merge_mask at its default value (~0).  This in turn has
the effect that PCI_DMA_BUS_IS_PHYS returns 1, which then leads to the
panic you observed in this fashion:

 (1) ide_toggle_bounce() finds that there is no hardware I/O MMU
     (PCI_DMA_BUS_IS_PHYS is 1) and sets the controller's DMA limit to
     its true physical limit
 (2) blk_queue_bounce_limit() finds that the controller can't
     address all physical memory (bounce_pfn < blk_max_low_pfn), and
 (3) controller can't address up to BLK_BOUNCE_ISA (which is ~0UL on ia64)

and so it throws up its hands and gives up.

You could define PCI_DMA_BUS_IS_PHYS as 0, but then you'd get a
needless amount of bounce-buffering, since memory won't be allocated
with GFP_DMA.

Actually, I can't find any uses for ISA_DMA_THRESHOLD anymore, except
for aha1542.c (which probably doesn't work on ia64 anyhow) and for its
use in defining BLK_BOUNCE_ISA.  Perhaps we can define
ISA_DMA_THRESHOLD as 0xffffffff so it matches the 4GB limit implied by
GFP_DMA.  If the controller can do full 32-bit addressing, this should
take avoid the BUG_ON() without any ill effects.

Perhaps someone who understands the disk/block layers better can also
comment.

In summary:

 - You can force PCI_DMA_BUS_IS_PHYS to 0, which is probably the
   safest since it should work even if there is heavy pressure
   on memory <= 4GB.

 - You can try setting ISA_DMA_THRESHOLD to 0xffffffff which should
   work fine as long as there is free memory <= 4GB.

 - You could get a controller that can address all physical memory
   or a machine that has a hardware I/O MMU.

	--david
