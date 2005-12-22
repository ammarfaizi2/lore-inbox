Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVLVFzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVLVFzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVLVFzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 00:55:14 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:59204 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932390AbVLVFzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 00:55:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Za/9zEJzXMnf+xwrwtMNrjimFdTTf9pAACvWYkoqBlaZbEtdN1myCJ8QaVGoif0i96uYsRTCcTdknxVzNnOovrSe2O9ZbctXVQwwk+MspV9c2GZCYrhxPAKJvyxLqtSzcmgQFCiNhRmf7sDYhsi7lHoaVEQ0F0eugeW9nTsSses=
Date: Thu, 22 Dec 2005 14:55:07 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bzolnier@gmail.com, james.steward@dynamicratings.com, rmk@arm.linux.org.uk,
       Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de
Subject: [MM, HELP] PIO to and from user-mapped page caches
Message-ID: <20051222055507.GA19446@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

This subject was brought up in linux-ide mailing list by James
Steward in the following message.

http://marc.theaimsgroup.com/?l=linux-ide&m=113494968723962&w=2

Russell King kindly explained the problem in detail in the following
message.

http://marc.theaimsgroup.com/?l=linux-ide&m=113517728717638&w=2

To reiterate it again for the purpose of discussion, the problem is
that some block drivers (IDE, libata and a few SCSI drivers) sometimes
perform PIO instead of DMA.  Block drivers often perform IOs on page
caches which can also be mapped from user-space.  On machines where
caches are physically indexed, PIO doesn't cause any problem as CPU
handles all cache coherency.

However, on machines with virtually indexed caches, there can be
aliased cache lines of the same page which can result in accessing
stale data if mis-managed.  DMA API takes good care of cache coherency
issues but currently most block drivers don't properly manage cache
coherency for PIOs.

The question is what kind of flushing is required where.  AFAIK, DMA
API does the following flushing operations.

* On READ (DMA_FROM_DEVICE)

	Invalidate all cpu caches of the target memory area before IO.
	There's no need for flushing after IO as DMA transfers don't
	affect cpu caches.

* On WRITE (DMA_TO_DEVICE)

	Writeback (but don't invalidate) all cpu caches of the target
	memory area before IO.  There's no need for flushing after IO
	as DMA write transfers don't dirty cpu caches.

PIO READs are different from DMA READs in that read operation creates
(on write-allocate caches) or dirties cache lines and they need to be
flushed before the page is mapped to user space.

As the ramdisk driver (driver/block/rd.c) deals with similar problem
and it performs flush_dcache_page after READ operation, there's no
question that flush_dcache_page is needed after READ, but we're not
sure...

* Is flush_dcache_page needed before PIO READ?  IOW, is it guaranteed
  that there's no dirty user-mapped cache lines on entry to block
  layer for READ?

* Is flush_dcache_page needed before PIO WRITE?  IOW, is it guaranteed
  that there's no dirty user-mapped cache lines on entry to block
  layer for WRITE?

* Is there any better (lighter) function to call to flush dirty
  kernel-mapped cachelines?  flush_dcache_page seems quite heavy for
  that purpose.

And, I think it would be a good idea to have kmap/unmap wrappers in
block layer, say, kmap/unmap_for_pio(page, rw) which deal with above
cache coherency issues.  How does it sound?

TIA.

-- 
tejun
