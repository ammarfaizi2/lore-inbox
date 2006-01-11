Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWAKTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWAKTw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWAKTw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:52:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62299 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932434AbWAKTw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:52:28 -0500
Date: Wed, 11 Jan 2006 20:53:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       htejun@gmail.com
Subject: Re: 2.6.15-mm2
Message-ID: <20060111195349.GF5373@suse.de>
References: <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111194517.GE5373@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Jens Axboe wrote:
> On Thu, Jan 12 2006, Reuben Farrelly wrote:
> > 
> > 
> > On 12/01/2006 3:55 a.m., Jens Axboe wrote:
> > >On Wed, Jan 11 2006, Jens Axboe wrote:
> > >>It's not too tricky, you just need to correct that function prototype.
> > >>Could you do that? Would be nice to know _exactly_ which libata
> > >>changeset caused this malfunction. But it does of course point at the
> > >>barrier changes for scsi/libata...
> > >
> > >You can also try something quicker - use a newer kernel known to exhibit
> > >the problem, and apply this patch on top of that:
> > >
> > >diff --git a/drivers/md/md.c b/drivers/md/md.c
> > >index 0302723..720ace4 100644
> > >--- a/drivers/md/md.c
> > >+++ b/drivers/md/md.c
> > >@@ -436,6 +436,7 @@ void md_super_write(mddev_t *mddev, mdk_
> > > 	bio->bi_rw = rw;
> > > 
> > > 	atomic_inc(&mddev->pending_writes);
> > >+#if 0
> > > 	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
> > > 		struct bio *rbio;
> > > 		rw |= (1<<BIO_RW_BARRIER);
> > >@@ -444,6 +445,7 @@ void md_super_write(mddev_t *mddev, mdk_
> > > 		rbio->bi_end_io = super_written_barrier;
> > > 		submit_bio(rw, rbio);
> > > 	} else
> > >+#endif
> > > 		submit_bio(rw, bio);
> > > }
> > 
> > ...and with that patch, I can now boot up 2.6.15-mm3 (repeated twice).  So 
> > yes, looks like that's where the problem lies.
> 
> At least it shows that the problem is indeed barrier related. I don't
> have the start of this thread, so can you please send me the output from
> dmesg from this kernel boot? I'm curious whether the fallback triggers,
> or if it's the barrier that fails instead.

Or even better, please boot with this patch applied on top of the kernel
you just booted (the new one, with the md patch applied).

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4c5127e..07aee66 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1492,6 +1492,7 @@ static int sd_revalidate_disk(struct gen
 		ordered = QUEUE_ORDERED_DRAIN;
 
 	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush);
+	printk("%s: ordered set to %d\n", disk->disk_name, ordered);
 
 	set_capacity(disk, sdkp->capacity);
 	kfree(buffer);

-- 
Jens Axboe

