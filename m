Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUGRHTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUGRHTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 03:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUGRHTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 03:19:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262450AbUGRHS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 03:18:56 -0400
Date: Sun, 18 Jul 2004 09:19:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
Message-ID: <20040718071830.GA29753@suse.de>
References: <40F9854D.2000408@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F9854D.2000408@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17 2004, Ed Sweetman wrote:
> Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
> writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
> data cds write as expected, but audio cds will cause (at any speed) the 
> box to start using insane amounts of swap (>150MB) and eventually cause 
> the box to crash before finishing the cd.  CPU usage during the write is 
> very low, but the feeling of lagginess begins after the first few tracks 
> (and as the memory begins to be sucked away).   I've used both cdrecord 
> from cdrtools in debian and from the site and both have the same 
> behavior.  I dont know how i'd go about finding out what the problem is, 
> so far I've coastered over 10 cds trying different ways of burning an 
> audio cd but it appears that burnfree, speed have nothing to do with the 
> problem. 
> 
> Here's some drive info if it helps. 
> 
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.8'.
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 1
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'DVDR   PX-712A  '
> Revision       : '1.01'
> Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> cdrecord: This version of cdrecord does not include DVD-R/DVD-RW support 
> code.
> cdrecord: See /usr/share/doc/cdrecord/README.DVD.Debian for details on 
> DVD support.
> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC FORCESPEED SPEEDREAD 
> SINGLESESSION HIDECDR
> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
> 
> 
> now in cdrecord i use the option -swab not sure if that counters the 
> driver flags or what, either way I doubt it would be causing this problem. 
> 
> the drive by the way is mmc4 compliant, so it's weird that it says mmc2.
> any more info that's needed just tell me.

Sounds like it's leaking all the pages, vmstat 1 during rip will show
for sure. Can you check if this makes a difference, against
2.6.8-rc-mm1 (should apply with offsets, I'm on the road so cannot test
myself)?

--- /mnt/kscratch/linux-2.6.5/mm/highmem.c	2004-04-04 05:37:25.000000000 +0200
+++ linux-2.6.5-SUSE-20040713/mm/highmem.c	2004-07-15 10:28:12.142262512 +0200
@@ -309,12 +309,10 @@ static void bounce_end_io(struct bio *bi
 {
 	struct bio *bio_orig = bio->bi_private;
 	struct bio_vec *bvec, *org_vec;
-	int i;
+	int i, err = 0;
 
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
-		goto out_eio;
-
-	set_bit(BIO_UPTODATE, &bio_orig->bi_flags);
+		err = -EIO;
 
 	/*
 	 * free up bounce indirect pages used
@@ -327,8 +325,7 @@ static void bounce_end_io(struct bio *bi
 		mempool_free(bvec->bv_page, pool);	
 	}
 
-out_eio:
-	bio_endio(bio_orig, bio_orig->bi_size, 0);
+	bio_endio(bio_orig, bio_orig->bi_size, err);
 	bio_put(bio);
 }
 
--- /mnt/kscratch/linux-2.6.5/fs/bio.c	2004-07-14 23:12:42.000000000 +0200
+++ linux-2.6.5-SUSE-20040713/fs/bio.c	2004-07-15 10:30:53.263775247 +0200
@@ -549,7 +549,6 @@ static struct bio *__bio_map_user(reques
 		bio->bi_rw |= (1 << BIO_RW);
 
 	bio->bi_flags |= (1 << BIO_USER_MAPPED);
-	blk_queue_bounce(q, &bio);
 	return bio;
 out:
 	kfree(pages);
--- /mnt/kscratch/linux-2.6.5/drivers/block/scsi_ioctl.c	2004-07-14 23:12:42.000000000 +0200
+++ linux-2.6.5-SUSE-20040713/drivers/block/scsi_ioctl.c	2004-07-15 10:26:39.089364958 +0200
@@ -167,6 +167,13 @@ static int sg_io(request_queue_t *q, str
 	rq->flags |= REQ_BLOCK_PC;
 	bio = rq->bio;
 
+	/*
+	 * bounce this after holding a reference to the original bio, it's
+	 * needed for proper unmapping
+	 */
+	if (rq->bio)
+		blk_queue_bounce(q, &rq->bio);
+
 	rq->timeout = (hdr->timeout * HZ) / 1000;
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
--- /mnt/kscratch/linux-2.6.5/drivers/cdrom/cdrom.c	2004-07-14 23:12:42.000000000 +0200
+++ linux-2.6.5-SUSE-20040713/drivers/cdrom/cdrom.c	2004-07-15 10:27:17.219225057 +0200
@@ -1975,6 +1975,9 @@ static int cdrom_read_cdda_bpc(struct cd
 		rq->timeout = 60 * HZ;
 		bio = rq->bio;
 
+		if (rq->bio)
+			blk_queue_bounce(q, &rq->bio);
+
 		if (blk_execute_rq(q, cdi->disk, rq)) {
 			struct request_sense *s = rq->sense;
 			ret = -EIO;
--- /mnt/kscratch/linux-2.6.5/drivers/block/ll_rw_blk.c	2004-07-14 23:12:42.000000000 +0200
+++ linux-2.6.5-SUSE-20040713/drivers/block/ll_rw_blk.c	2004-07-15 10:34:51.152967583 +0200
@@ -1807,6 +1807,12 @@ EXPORT_SYMBOL(blk_insert_request);
  *
  *    A matching blk_rq_unmap_user() must be issued at the end of io, while
  *    still in process context.
+ *
+ *    Note: The mapped bio may need to be bounced through blk_queue_bounce()
+ *    before being submitted to the device, as pages mapped may be out of
+ *    reach. It's the callers responsibility to make sure this happens. The
+ *    original bio must be passed back in to blk_rq_unmap_user() for proper
+ *    unmapping.
  */
 struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user *ubuf,
 				unsigned int len)


-- 
Jens Axboe

