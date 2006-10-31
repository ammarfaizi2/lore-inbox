Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423090AbWJaKsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423090AbWJaKsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423098AbWJaKsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:48:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47828 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1423090AbWJaKsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:48:21 -0500
Date: Tue, 31 Oct 2006 02:49:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] [PATCH] Check bio address after mapping through partitions.
Message-ID: <20061031104932.GG5881@sequoia.sous-sol.org>
References: <20061031124940.24199.patches@notabene> <1061031015145.24246@suse.de> <20061031071531.GT14055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031071531.GT14055@kernel.dk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (jens.axboe@oracle.com) wrote:
> On Tue, Oct 31 2006, NeilBrown wrote:
> > This would be good for 2.6.19 and even 18.2, if it is seens acceptable.
> > raid0 at least (possibly other) can be made to Oops with a bad partition 
> > table and best fix seem to be to not let out-of-range request get down
> > to the device.
> > 
> > ### Comments for Changeset
> > 
> > Partitions are not limited to live within a device.  So
> > we should range check after partition mapping.
> > 
> > Note that 'maxsector' was being used for two different things.  I have
> > split off the second usage into 'old_sector' so that maxsector can be
> > still be used for it's primary usage later in the function.
> > 
> > Cc: Jens Axboe <jens.axboe@oracle.com>
> > Signed-off-by: Neil Brown <neilb@suse.de>
> 
> Code looks good to me, but for some reason your comment exceeds 80
> chars. Can you please fix that up?

Maybe just was copy, pasted and pushed one tab over from the same check
above the loop.  What about consolidating that one?

thanks,
-chris

--

From: Neil Brown <neilb@suse.de>

Partitions are not limited to live within a device.  So
we should range check after partition mapping.
                                                                                                                   
Note that 'maxsector' was being used for two different things.  I have
split off the second usage into 'old_sector' so that maxsector can be
still be used for it's primary usage later in the function.
                                                                                                                   
Acked-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Neil Brown <neilb@suse.de>

Add check_bad_sector() to consolidate the checks a touch.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
(smth like this only compile tested extension to Neil's patch)

 block/ll_rw_blk.c |   51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2971,6 +2971,26 @@ static void handle_bad_sector(struct bio
 	set_bit(BIO_EOF, &bio->bi_flags);
 }
 
+static int check_bad_sector(struct bio *bio)
+{
+	sector_t maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
+	int nr_sectors = bio_sectors(bio);
+	if (maxsector) {
+		sector_t sector = bio->bi_sector;
+
+		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
+			/*
+			 * This may well happen - the kernel calls bread()
+			 * without checking the size of the device, e.g., when
+			 * mounting a device.
+			 */
+			handle_bad_sector(bio);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -2998,26 +3018,14 @@ static void handle_bad_sector(struct bio
 void generic_make_request(struct bio *bio)
 {
 	request_queue_t *q;
-	sector_t maxsector;
-	int ret, nr_sectors = bio_sectors(bio);
+	sector_t old_sector;
+	int ret;
 	dev_t old_dev;
 
 	might_sleep();
 	/* Test device or partition size, when known. */
-	maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
-	if (maxsector) {
-		sector_t sector = bio->bi_sector;
-
-		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
-			/*
-			 * This may well happen - the kernel calls bread()
-			 * without checking the size of the device, e.g., when
-			 * mounting a device.
-			 */
-			handle_bad_sector(bio);
-			goto end_io;
-		}
-	}
+	if (check_bad_sector(bio))
+		goto end_io;
 
 	/*
 	 * Resolve the mapping until finished. (drivers are
@@ -3027,7 +3035,7 @@ void generic_make_request(struct bio *bi
 	 * NOTE: we don't repeat the blk_size check for each new device.
 	 * Stacking drivers are expected to know what they are doing.
 	 */
-	maxsector = -1;
+	old_sector = -1;
 	old_dev = 0;
 	do {
 		char b[BDEVNAME_SIZE];
@@ -3061,15 +3069,18 @@ end_io:
 		 */
 		blk_partition_remap(bio);
 
-		if (maxsector != -1)
+		if (old_sector != -1)
 			blk_add_trace_remap(q, bio, old_dev, bio->bi_sector, 
-					    maxsector);
+					    old_sector);
 
 		blk_add_trace_bio(q, bio, BLK_TA_QUEUE);
 
-		maxsector = bio->bi_sector;
+		old_sector = bio->bi_sector;
 		old_dev = bio->bi_bdev->bd_dev;
 
+		if (check_bad_sector(bio))
+			goto end_io;
+
 		ret = q->make_request_fn(q, bio);
 	} while (ret);
 }
