Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWAKOxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWAKOxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWAKOxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:53:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751537AbWAKOxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:53:24 -0500
Date: Wed, 11 Jan 2006 15:55:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       htejun@gmail.com
Subject: Re: 2.6.15-mm2
Message-ID: <20060111145504.GT3389@suse.de>
References: <43C4947C.1040703@reub.net> <20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org> <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111145201.GS3389@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Jens Axboe wrote:
> It's not too tricky, you just need to correct that function prototype.
> Could you do that? Would be nice to know _exactly_ which libata
> changeset caused this malfunction. But it does of course point at the
> barrier changes for scsi/libata...

You can also try something quicker - use a newer kernel known to exhibit
the problem, and apply this patch on top of that:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0302723..720ace4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -436,6 +436,7 @@ void md_super_write(mddev_t *mddev, mdk_
 	bio->bi_rw = rw;
 
 	atomic_inc(&mddev->pending_writes);
+#if 0
 	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
 		struct bio *rbio;
 		rw |= (1<<BIO_RW_BARRIER);
@@ -444,6 +445,7 @@ void md_super_write(mddev_t *mddev, mdk_
 		rbio->bi_end_io = super_written_barrier;
 		submit_bio(rw, rbio);
 	} else
+#endif
 		submit_bio(rw, bio);
 }
 

-- 
Jens Axboe

