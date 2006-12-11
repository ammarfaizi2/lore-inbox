Return-Path: <linux-kernel-owner+w=401wt.eu-S1750704AbWLKW4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWLKW4K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWLKW4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:56:10 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49709 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbWLKW4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:56:07 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 12 Dec 2006 09:56:19 +1100
Message-Id: <1061211225619.9700@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: raziebe@gmail.com
Subject: [PATCH] md: Don't assume that READ==0 and WRITE==1 - use the names explicitly.
References: <20061212095548.9668.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

### Comments for Changeset

Thanks Jens for alerting me to this.

Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: raziebe@gmail.com
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/faulty.c |    2 +-
 ./drivers/md/raid1.c  |    2 +-
 ./drivers/md/raid10.c |    6 +++---
 ./drivers/md/raid5.c  |   20 ++++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff .prev/drivers/md/faulty.c ./drivers/md/faulty.c
--- .prev/drivers/md/faulty.c	2006-12-12 09:47:58.000000000 +1100
+++ ./drivers/md/faulty.c	2006-12-12 09:48:10.000000000 +1100
@@ -173,7 +173,7 @@ static int make_request(request_queue_t 
 	conf_t *conf = (conf_t*)mddev->private;
 	int failit = 0;
 
-	if (bio->bi_rw & 1) {
+	if (bio_data_dir(bio) == WRITE) {
 		/* write request */
 		if (atomic_read(&conf->counters[WriteAll])) {
 			/* special case - don't decrement, don't generic_make_request,

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-12-12 09:42:11.000000000 +1100
+++ ./drivers/md/raid10.c	2006-12-12 09:45:02.000000000 +1100
@@ -1785,7 +1785,7 @@ static sector_t sync_request(mddev_t *md
 						biolist = bio;
 						bio->bi_private = r10_bio;
 						bio->bi_end_io = end_sync_read;
-						bio->bi_rw = 0;
+						bio->bi_rw = READ;
 						bio->bi_sector = r10_bio->devs[j].addr +
 							conf->mirrors[d].rdev->data_offset;
 						bio->bi_bdev = conf->mirrors[d].rdev->bdev;
@@ -1801,7 +1801,7 @@ static sector_t sync_request(mddev_t *md
 						biolist = bio;
 						bio->bi_private = r10_bio;
 						bio->bi_end_io = end_sync_write;
-						bio->bi_rw = 1;
+						bio->bi_rw = WRITE;
 						bio->bi_sector = r10_bio->devs[k].addr +
 							conf->mirrors[i].rdev->data_offset;
 						bio->bi_bdev = conf->mirrors[i].rdev->bdev;
@@ -1870,7 +1870,7 @@ static sector_t sync_request(mddev_t *md
 			biolist = bio;
 			bio->bi_private = r10_bio;
 			bio->bi_end_io = end_sync_read;
-			bio->bi_rw = 0;
+			bio->bi_rw = READ;
 			bio->bi_sector = r10_bio->devs[i].addr +
 				conf->mirrors[d].rdev->data_offset;
 			bio->bi_bdev = conf->mirrors[d].rdev->bdev;

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-12-08 12:07:39.000000000 +1100
+++ ./drivers/md/raid1.c	2006-12-12 09:45:10.000000000 +1100
@@ -1736,7 +1736,7 @@ static sector_t sync_request(mddev_t *md
 		/* take from bio_init */
 		bio->bi_next = NULL;
 		bio->bi_flags |= 1 << BIO_UPTODATE;
-		bio->bi_rw = 0;
+		bio->bi_rw = READ;
 		bio->bi_vcnt = 0;
 		bio->bi_idx = 0;
 		bio->bi_phys_segments = 0;

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-12-11 09:54:43.000000000 +1100
+++ ./drivers/md/raid5.c	2006-12-12 09:49:53.000000000 +1100
@@ -1827,16 +1827,16 @@ static void handle_stripe5(struct stripe
 		struct bio *bi;
 		mdk_rdev_t *rdev;
 		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags))
-			rw = 1;
+			rw = WRITE;
 		else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
-			rw = 0;
+			rw = READ;
 		else
 			continue;
  
 		bi = &sh->dev[i].req;
  
 		bi->bi_rw = rw;
-		if (rw)
+		if (rw == WRITE)
 			bi->bi_end_io = raid5_end_write_request;
 		else
 			bi->bi_end_io = raid5_end_read_request;
@@ -1872,7 +1872,7 @@ static void handle_stripe5(struct stripe
 				atomic_add(STRIPE_SECTORS, &rdev->corrected_errors);
 			generic_make_request(bi);
 		} else {
-			if (rw == 1)
+			if (rw == WRITE)
 				set_bit(STRIPE_DEGRADED, &sh->state);
 			PRINTK("skip op %ld on disc %d for sector %llu\n",
 				bi->bi_rw, i, (unsigned long long)sh->sector);
@@ -2370,16 +2370,16 @@ static void handle_stripe6(struct stripe
 		struct bio *bi;
 		mdk_rdev_t *rdev;
 		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags))
-			rw = 1;
+			rw = WRITE;
 		else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
-			rw = 0;
+			rw = READ;
 		else
 			continue;
 
 		bi = &sh->dev[i].req;
 
 		bi->bi_rw = rw;
-		if (rw)
+		if (rw == WRITE)
 			bi->bi_end_io = raid5_end_write_request;
 		else
 			bi->bi_end_io = raid5_end_read_request;
@@ -2415,7 +2415,7 @@ static void handle_stripe6(struct stripe
 				atomic_add(STRIPE_SECTORS, &rdev->corrected_errors);
 			generic_make_request(bi);
 		} else {
-			if (rw == 1)
+			if (rw == WRITE)
 				set_bit(STRIPE_DEGRADED, &sh->state);
 			PRINTK("skip op %ld on disc %d for sector %llu\n",
 				bi->bi_rw, i, (unsigned long long)sh->sector);
@@ -2567,7 +2567,7 @@ static int raid5_mergeable_bvec(request_
 	unsigned int chunk_sectors = mddev->chunk_size >> 9;
 	unsigned int bio_sectors = bio->bi_size >> 9;
 
-	if (bio_data_dir(bio))
+	if (bio_data_dir(bio) == WRITE)
 		return biovec->bv_len; /* always allow writes to be mergeable */
 
 	max =  (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
@@ -2751,7 +2751,7 @@ static int make_request(request_queue_t 
 	disk_stat_inc(mddev->gendisk, ios[rw]);
 	disk_stat_add(mddev->gendisk, sectors[rw], bio_sectors(bi));
 
-	if (bio_data_dir(bi) == READ &&
+	if (rw == READ &&
 	     mddev->reshape_position == MaxSector &&
 	     chunk_aligned_read(q,bi))
             	return 0;
