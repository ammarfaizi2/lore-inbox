Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSLJWme>; Tue, 10 Dec 2002 17:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSLJWmd>; Tue, 10 Dec 2002 17:42:33 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:34534 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266908AbSLJWm0>; Tue, 10 Dec 2002 17:42:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] dm.c  -  device-mapper I/O path fixes
Date: Tue, 10 Dec 2002 16:03:47 -0600
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com
MIME-Version: 1.0
Message-Id: <02121016034706.02220@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, Linus,

This patch fixes problems with the device-mapper I/O path in 2.5.51. The
existing code does not properly split requests when necessary, and can
cause segfaults and/or data corruption. This can easily manifest itself
when running XFS on striped LVM volumes.

Notes:
- New bio's must be alloc'd instead of clone'd, since the bio vector may need
  to be adjusted if the end of the split request does not fill a page.
- Fix reference counting of md->pending. This should only be incremented once
  for each incoming bio, not for each split bio that is resubmitted.
- Copy the correct bvec when splitting the tail-end of a page.


-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


--- linux-2.5.51a/drivers/md/dm.c	Tue Dec 10 11:01:13 2002
+++ linux-2.5.51b/drivers/md/dm.c	Tue Dec 10 11:03:55 2002
@@ -242,17 +242,18 @@
 	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 
-	spin_lock_irqsave(&_uptodate_lock, flags);
-	if (error)
+	if (error) {
+		spin_lock_irqsave(&_uptodate_lock, flags);
 		io->error = error;
-	spin_unlock_irqrestore(&_uptodate_lock, flags);
+		spin_unlock_irqrestore(&_uptodate_lock, flags);
+	}
 
 	if (atomic_dec_and_test(&io->io_count)) {
 		if (atomic_dec_and_test(&io->md->pending))
 			/* nudge anyone waiting on suspend queue */
 			wake_up(&io->md->wait);
 
-		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
+		bio_endio(io->bio, io->bio->bi_size, io->error);
 		free_io(io);
 	}
 }
@@ -261,15 +262,15 @@
 {
 	struct dm_io *io = bio->bi_private;
 
-	/*
-	 * Only call dec_pending if the clone has completely
-	 * finished.  If a partial io errors I'm assuming it won't
-	 * be requeued.  FIXME: check this.
-	 */
-	if (error || !bio->bi_size) {
-		dec_pending(io, error);
-		bio_put(bio);
+	if (bio->bi_size)
+		return 1;
+
+	if (error) {
+		struct gendisk *disk = dm_disk(io->md);
+		DMWARN("I/O error (%d) on device %s\n", error, disk->disk_name);
 	}
+	dec_pending(io, error);
+	bio_put(bio);
 
 	return 0;
 }
@@ -313,7 +314,6 @@
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->md->pending);
 	atomic_inc(&io->io_count);
 	r = ti->type->map(ti, clone);
 	if (r > 0)
@@ -341,9 +341,7 @@
 {
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
 	struct bio *clone, *bio = ci->bio;
-	struct bio_vec *bv = bio->bi_io_vec + (bio->bi_vcnt - 1);
-
-	DMWARN("splitting page");
+	struct bio_vec *bv = bio->bi_io_vec + ci->idx;
 
 	if (len > ci->sector_count)
 		len = ci->sector_count;
@@ -353,11 +351,13 @@
 
 	clone->bi_sector = ci->sector;
 	clone->bi_bdev = bio->bi_bdev;
-	clone->bi_flags = bio->bi_flags | (1 << BIO_SEG_VALID);
 	clone->bi_rw = bio->bi_rw;
+	clone->bi_vcnt = 1;
 	clone->bi_size = len << SECTOR_SHIFT;
 	clone->bi_end_io = clone_endio;
 	clone->bi_private = ci->io;
+	clone->bi_io_vec->bv_offset = clone->bi_io_vec->bv_len - clone->bi_size;
+	clone->bi_io_vec->bv_len = clone->bi_size;
 
 	ci->sector += len;
 	ci->sector_count -= len;
@@ -369,24 +369,48 @@
 {
 	struct bio *clone, *bio = ci->bio;
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
-	sector_t len = max_io_len(ci->md, bio->bi_sector, ti);
+	sector_t bv_len, len = max_io_len(ci->md, ci->sector, ti);
+	struct bio_vec *bv;
+	int i, vcnt = bio->bi_vcnt - ci->idx;
 
 	/* shorter than current target ? */
 	if (ci->sector_count < len)
 		len = ci->sector_count;
 
 	/* create the clone */
-	clone = bio_clone(ci->bio, GFP_NOIO);
+	clone = bio_alloc(GFP_NOIO, vcnt);
+	if (!clone) {
+		dec_pending(ci->io, -ENOMEM);
+		return;
+	}
 	clone->bi_sector = ci->sector;
-	clone->bi_idx = ci->idx;
+	clone->bi_bdev = bio->bi_bdev;
+	clone->bi_rw = bio->bi_rw;
+	clone->bi_vcnt = vcnt;
 	clone->bi_size = len << SECTOR_SHIFT;
 	clone->bi_end_io = clone_endio;
 	clone->bi_private = ci->io;
 
+	/* copy the original vector and adjust if necessary. */
+	memcpy(clone->bi_io_vec, bio->bi_io_vec + ci->idx,
+	       vcnt * sizeof(*clone->bi_io_vec));
+	bv_len = len << SECTOR_SHIFT;
+	bio_for_each_segment(bv, clone, i) {
+		if (bv_len >= bv->bv_len) {
+			bv_len -= bv->bv_len;
+		} else {
+			bv->bv_len = bv_len;
+			clone->bi_vcnt = i + 1;
+			break;
+		}
+	}
+
+	/* submit this io */
+	__map_bio(ti, clone);
+
 	/* adjust the remaining io */
 	ci->sector += len;
 	ci->sector_count -= len;
-	__map_bio(ti, clone);
 
 	/*
 	 * If we are not performing all remaining io in this
@@ -395,8 +419,8 @@
 	 */
 	if (ci->sector_count) {
 		while (len) {
-			struct bio_vec *bv = clone->bi_io_vec + ci->idx;
-			sector_t bv_len = bv->bv_len >> SECTOR_SHIFT;
+			bv = bio->bi_io_vec + ci->idx;
+			bv_len = bv->bv_len >> SECTOR_SHIFT;
 			if (bv_len <= len)
 				len -= bv_len;
 
@@ -427,6 +451,8 @@
 	ci.sector_count = bio_sectors(bio);
 	ci.idx = 0;
 
+	atomic_inc(&ci.io->md->pending);
+
 	while (ci.sector_count)
 		__clone_and_map(&ci);
 
@@ -457,13 +483,13 @@
 		up_read(&md->lock);
 
 		if (bio_rw(bio) == READA) {
-			bio_io_error(bio, 0);
+			bio_io_error(bio, bio->bi_size);
 			return 0;
 		}
 
 		r = queue_io(md, bio);
 		if (r < 0) {
-			bio_io_error(bio, 0);
+			bio_io_error(bio, bio->bi_size);
 			return 0;
 
 		} else if (r == 0)
