Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUGVPH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUGVPH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:07:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266560AbUGVPGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:06:50 -0400
Date: Thu, 22 Jul 2004 10:56:31 -0200
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1
Message-ID: <20040722125631.GD3987@suse.de>
References: <20040713182559.7534e46d.akpm@osdl.org> <20040720000210.GA4680@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720000210.GA4680@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20 2004, J.A. Magallon wrote:
> 
> On 2004.07.14, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/
> > 
> 
> It oopses if you try to write on a CDRW without media loaded. Who would do
> such a stupid thing ? Me the impatient trying to write before the drive ends
> to load the disc...

It's fixed in later -mm, not sure if Andrew has merged the patch yet. I
have posted it here a week or two ago, here it is again.

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

