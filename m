Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUCROHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUCROHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:07:10 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:7175 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262652AbUCROEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:04:43 -0500
Message-ID: <4059AC74.4010807@cs.wisc.edu>
Date: Thu, 18 Mar 2004 06:04:36 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2][RFC] add detailed error values to block layer
Content-Type: multipart/mixed;
 boundary="------------030702080405020806010804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702080405020806010804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

02-ec-bioendio.patch converts the bio_endio and bi_end_io
callers to pass one of the error values defined in 01-ec-core.patch
instead of the Exxx errnos. Should be applied on top of
01-ec-core.patch.

diffstat

drivers/block/cciss.c        |    3 ++-
drivers/block/cpqarray.c     |    2 +-
drivers/block/ll_rw_blk.c    |    4 ++--
drivers/block/loop.c         |    2 +-
drivers/block/rd.c           |    2 +-
drivers/block/umem.c         |    2 +-
drivers/md/dm-crypt.c        |    6 +++---
drivers/md/dm.c              |    2 +-
drivers/md/multipath.c       |    2 +-
drivers/md/raid1.c           |    2 +-
drivers/md/raid5.c           |    4 ++--
drivers/md/raid6main.c       |    4 ++--
drivers/s390/block/dcssblk.c |    2 +-
drivers/s390/block/xpram.c   |    2 +-
fs/bio.c                     |    4 ++--
mm/highmem.c                 |    2 +-
16 files changed, 23 insertions(+), 22 deletions(-)



Mike Chrisite

--------------030702080405020806010804
Content-Type: text/plain;
 name="02-ec-bioendio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-ec-bioendio.patch"

diff -aurp linux-2.6.5-rc1-orig/drivers/block/cciss.c linux-2.6.5-rc1-ec/drivers/block/cciss.c
--- linux-2.6.5-rc1-orig/drivers/block/cciss.c	2004-03-15 21:47:36.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/cciss.c	2004-03-18 05:21:14.371872116 -0800
@@ -1747,7 +1747,8 @@ static inline void complete_buffers(stru
 
 		bio->bi_next = NULL; 
 		blk_finished_io(len);
-		bio_endio(bio, nr_sectors << 9, status ? 0 : -EIO);
+		bio_endio(bio, nr_sectors << 9,
+			  status ? BLK_SUCCESS : BLK_ERR);
 		bio = xbh;
 	}
 
diff -aurp linux-2.6.5-rc1-orig/drivers/block/cpqarray.c linux-2.6.5-rc1-ec/drivers/block/cpqarray.c
--- linux-2.6.5-rc1-orig/drivers/block/cpqarray.c	2004-03-15 21:45:34.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/cpqarray.c	2004-03-18 05:21:14.407867710 -0800
@@ -886,7 +886,7 @@ static inline void complete_buffers(stru
 		bio->bi_next = NULL;
 		
 		blk_finished_io(nr_sectors);
-		bio_endio(bio, nr_sectors << 9, ok ? 0 : -EIO);
+		bio_endio(bio, nr_sectors << 9, ok ? BLK_SUCCESS : BLK_ERR);
 
 		bio = xbh;
 	}
diff -aurp linux-2.6.5-rc1-orig/drivers/block/ll_rw_blk.c linux-2.6.5-rc1-ec/drivers/block/ll_rw_blk.c
--- linux-2.6.5-rc1-orig/drivers/block/ll_rw_blk.c	2004-03-18 05:27:12.971665933 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/ll_rw_blk.c	2004-03-18 05:21:14.443863304 -0800
@@ -2309,7 +2309,7 @@ out:
 	return 0;
 
 end_io:
-	bio_endio(bio, nr_sectors << 9, -EWOULDBLOCK);
+	bio_endio(bio, nr_sectors << 9, BLK_RETRY_DRV);
 	return 0;
 }
 
@@ -2411,7 +2411,7 @@ void generic_make_request(struct bio *bi
 				bdevname(bio->bi_bdev, b),
 				(long long) bio->bi_sector);
 end_io:
-			bio_endio(bio, bio->bi_size, -EIO);
+			bio_endio(bio, bio->bi_size, BLK_ERR);
 			break;
 		}
 
diff -aurp linux-2.6.5-rc1-orig/drivers/block/loop.c linux-2.6.5-rc1-ec/drivers/block/loop.c
--- linux-2.6.5-rc1-orig/drivers/block/loop.c	2004-03-15 21:46:44.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/loop.c	2004-03-18 05:21:14.447862815 -0800
@@ -450,7 +450,7 @@ static inline void loop_handle_bio(struc
 		bio_put(bio);
 	} else {
 		ret = do_bio_filebacked(lo, bio);
-		bio_endio(bio, bio->bi_size, ret);
+		bio_endio(bio, bio->bi_size, ret ? BLK_ERR : BLK_SUCCESS);
 	}
 }
 
diff -aurp linux-2.6.5-rc1-orig/drivers/block/rd.c linux-2.6.5-rc1-ec/drivers/block/rd.c
--- linux-2.6.5-rc1-orig/drivers/block/rd.c	2004-03-15 21:46:44.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/rd.c	2004-03-18 05:21:14.479858899 -0800
@@ -237,7 +237,7 @@ static int rd_make_request(request_queue
 	if (ret)
 		goto fail;
 
-	bio_endio(bio, bio->bi_size, 0);
+	bio_endio(bio, bio->bi_size, BLK_SUCCESS);
 	return 0;
 fail:
 	bio_io_error(bio, bio->bi_size);
diff -aurp linux-2.6.5-rc1-orig/drivers/block/umem.c linux-2.6.5-rc1-ec/drivers/block/umem.c
--- linux-2.6.5-rc1-orig/drivers/block/umem.c	2004-03-15 21:47:38.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/block/umem.c	2004-03-18 05:21:14.543851066 -0800
@@ -544,7 +544,7 @@ static void process_page(unsigned long d
 
 		return_bio = bio->bi_next;
 		bio->bi_next = NULL;
-		bio_endio(bio, bio->bi_size, 0);
+		bio_endio(bio, bio->bi_size, BLK_SUCCESS);
 	}
 }
 
diff -aurp linux-2.6.5-rc1-orig/drivers/md/dm.c linux-2.6.5-rc1-ec/drivers/md/dm.c
--- linux-2.6.5-rc1-orig/drivers/md/dm.c	2004-03-15 21:47:17.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/dm.c	2004-03-18 05:21:14.546850699 -0800
@@ -486,7 +486,7 @@ static void __split_bio(struct mapped_de
 	ci.md = md;
 	ci.bio = bio;
 	ci.io = alloc_io(md);
-	ci.io->error = 0;
+	ci.io->error = BLK_SUCCESS;
 	atomic_set(&ci.io->io_count, 1);
 	ci.io->bio = bio;
 	ci.io->md = md;
diff -aurp linux-2.6.5-rc1-orig/drivers/md/dm-crypt.c linux-2.6.5-rc1-ec/drivers/md/dm-crypt.c
--- linux-2.6.5-rc1-orig/drivers/md/dm-crypt.c	2004-03-15 21:45:19.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/dm-crypt.c	2004-03-18 05:21:14.608843111 -0800
@@ -320,8 +320,8 @@ static void dec_pending(struct crypt_io 
 {
 	struct crypt_config *cc = (struct crypt_config *) io->target->private;
 
-	if (error < 0)
-		io->error = error;
+	if (error)
+		io->error = BLK_ERR;
 
 	if (!atomic_dec_and_test(&io->pending))
 		return;
@@ -635,7 +635,7 @@ static int crypt_map(struct dm_target *t
 	io->target = ti;
 	io->bio = bio;
 	io->first_clone = NULL;
-	io->error = 0;
+	io->error = BLK_SUCCESS;
 	atomic_set(&io->pending, 1); /* hold a reference */
 
 	if (bio_data_dir(bio) == WRITE)
diff -aurp linux-2.6.5-rc1-orig/drivers/md/multipath.c linux-2.6.5-rc1-ec/drivers/md/multipath.c
--- linux-2.6.5-rc1-orig/drivers/md/multipath.c	2004-03-15 21:46:34.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/multipath.c	2004-03-18 05:21:14.610842866 -0800
@@ -106,7 +106,7 @@ static void multipath_end_bh_io (struct 
 	struct bio *bio = mp_bh->master_bio;
 	multipath_conf_t *conf = mddev_to_conf(mp_bh->mddev);
 
-	bio_endio(bio, bio->bi_size, uptodate ? 0 : -EIO);
+	bio_endio(bio, bio->bi_size, uptodate ? BLK_SUCCESS : BLK_ERR);
 	mempool_free(mp_bh, conf->pool);
 }
 
diff -aurp linux-2.6.5-rc1-orig/drivers/md/raid1.c linux-2.6.5-rc1-ec/drivers/md/raid1.c
--- linux-2.6.5-rc1-orig/drivers/md/raid1.c	2004-03-15 21:46:44.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/raid1.c	2004-03-18 05:21:14.672835278 -0800
@@ -229,7 +229,7 @@ static void raid_end_bio_io(r1bio_t *r1_
 	struct bio *bio = r1_bio->master_bio;
 
 	bio_endio(bio, bio->bi_size,
-		test_bit(R1BIO_Uptodate, &r1_bio->state) ? 0 : -EIO);
+		test_bit(R1BIO_Uptodate, &r1_bio->state) ? BLK_SUCCESS : BLK_ERR);
 	free_r1bio(r1_bio);
 }
 
diff -aurp linux-2.6.5-rc1-orig/drivers/md/raid5.c linux-2.6.5-rc1-ec/drivers/md/raid5.c
--- linux-2.6.5-rc1-orig/drivers/md/raid5.c	2004-03-15 21:45:49.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/raid5.c	2004-03-18 05:25:55.340809465 -0800
@@ -1221,7 +1221,7 @@ static void handle_stripe(struct stripe_
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes, BLK_SUCCESS);
 	}
 	for (i=disks; i-- ;) {
 		int rw;
@@ -1372,7 +1372,7 @@ static int make_request (request_queue_t
 		if ( bio_data_dir(bi) == WRITE )
 			md_write_end(mddev);
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes, BLK_SUCCESS);
 	}
 	spin_unlock_irq(&conf->device_lock);
 	return 0;
diff -aurp linux-2.6.5-rc1-orig/drivers/md/raid6main.c linux-2.6.5-rc1-ec/drivers/md/raid6main.c
--- linux-2.6.5-rc1-orig/drivers/md/raid6main.c	2004-03-15 21:45:19.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/md/raid6main.c	2004-03-18 05:23:54.908210939 -0800
@@ -1383,7 +1383,7 @@ static void handle_stripe(struct stripe_
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes, BLK_SUCCESS);
 	}
 	for (i=disks; i-- ;) {
 		int rw;
@@ -1534,7 +1534,7 @@ static int make_request (request_queue_t
 		if ( bio_data_dir(bi) == WRITE )
 			md_write_end(mddev);
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes, BLK_SUCCESS);
 	}
 	spin_unlock_irq(&conf->device_lock);
 	return 0;
diff -aurp linux-2.6.5-rc1-orig/drivers/s390/block/dcssblk.c linux-2.6.5-rc1-ec/drivers/s390/block/dcssblk.c
--- linux-2.6.5-rc1-orig/drivers/s390/block/dcssblk.c	2004-03-15 21:45:49.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/s390/block/dcssblk.c	2004-03-18 05:21:14.715830016 -0800
@@ -641,7 +641,7 @@ dcssblk_make_request(request_queue_t *q,
 		}
 		bytes_done += bvec->bv_len;
 	}
-	bio_endio(bio, bytes_done, 0);
+	bio_endio(bio, bytes_done, BLK_SUCCESS);
 	return 0;
 fail:
 	bio_io_error(bio, bytes_done);
diff -aurp linux-2.6.5-rc1-orig/drivers/s390/block/xpram.c linux-2.6.5-rc1-ec/drivers/s390/block/xpram.c
--- linux-2.6.5-rc1-orig/drivers/s390/block/xpram.c	2004-03-15 21:47:04.000000000 -0800
+++ linux-2.6.5-rc1-ec/drivers/s390/block/xpram.c	2004-03-18 05:25:49.008622034 -0800
@@ -322,7 +322,7 @@ static int xpram_make_request(request_qu
 	set_bit(BIO_UPTODATE, &bio->bi_flags);
 	bytes = bio->bi_size;
 	bio->bi_size = 0;
-	bio->bi_end_io(bio, bytes, 0);
+	bio->bi_end_io(bio, bytes, BLK_SUCCESS);
 	return 0;
 fail:
 	bio_io_error(bio, bio->bi_size);
diff -aurp linux-2.6.5-rc1-orig/fs/bio.c linux-2.6.5-rc1-ec/fs/bio.c
--- linux-2.6.5-rc1-orig/fs/bio.c	2004-03-18 05:27:13.000000000 -0800
+++ linux-2.6.5-rc1-ec/fs/bio.c	2004-03-18 05:21:14.000000000 -0800
@@ -473,7 +473,7 @@ struct bio *bio_map_user(request_queue_t
 		bio_get(bio);
 
 		if (bio->bi_size < len) {
-			bio_endio(bio, bio->bi_size, 0);
+			bio_endio(bio, bio->bi_size, BLK_SUCCESS);
 			bio_unmap_user(bio, 0);
 			return NULL;
 		}
@@ -737,7 +737,7 @@ struct bio_pair *bio_split(struct bio *b
 	BUG_ON(bi->bi_vcnt != 1);
 	BUG_ON(bi->bi_idx != 0);
 	atomic_set(&bp->cnt, 3);
-	bp->error = 0;
+	bp->error = BLK_SUCCESS;
 	bp->bio1 = *bi;
 	bp->bio2 = *bi;
 	bp->bio2.bi_sector += first_sectors;
diff -aurp linux-2.6.5-rc1-orig/mm/highmem.c linux-2.6.5-rc1-ec/mm/highmem.c
--- linux-2.6.5-rc1-orig/mm/highmem.c	2004-03-15 21:46:45.000000000 -0800
+++ linux-2.6.5-rc1-ec/mm/highmem.c	2004-03-18 05:21:14.000000000 -0800
@@ -328,7 +328,7 @@ static void bounce_end_io(struct bio *bi
 	}
 
 out_eio:
-	bio_endio(bio_orig, bio_orig->bi_size, 0);
+	bio_endio(bio_orig, bio_orig->bi_size, BLK_SUCCESS);
 	bio_put(bio);
 }
 

--------------030702080405020806010804--

