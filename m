Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbSLKMKd>; Wed, 11 Dec 2002 07:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSLKMKd>; Wed, 11 Dec 2002 07:10:33 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:16143 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267128AbSLKMK2>; Wed, 11 Dec 2002 07:10:28 -0500
Date: Wed, 11 Dec 2002 12:17:49 +0000
To: Kevin Corry <corryk@us.ibm.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Message-ID: <20021211121749.GA20782@reti>
References: <02121016034706.02220@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02121016034706.02220@boiler>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,

On Tue, Dec 10, 2002 at 04:03:47PM -0600, Kevin Corry wrote:
> Joe, Linus,
> 
> This patch fixes problems with the device-mapper I/O path in 2.5.51. The
> existing code does not properly split requests when necessary, and can
> cause segfaults and/or data corruption. This can easily manifest itself
> when running XFS on striped LVM volumes.

Many thanks for doing this work, but _please_ split your patches up more.
There are several changes rolled in here.

I've split the patch up, and will post the ones I'm accepting as
replies to this current mail.

The full set of changes for 2.5.51 is available here:
http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/

This works for me with xfs and stripes (limited testing).


These are the bits of your patch that I have queries about:

--- linux-2.5.51a/drivers/md/dm.c	Tue Dec 10 11:01:13 2002
+++ linux-2.5.51b/drivers/md/dm.c	Tue Dec 10 11:03:55 2002
@@ -242,4 +242,4 @@
-		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
+		bio_endio(io->bio, io->bio->bi_size, io->error);

You seem to be assuming that io->bio->bi_size will always be zero if
an error occurs.  I was not aware that this was the case.


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


All you're doing here is adding a warning (which is nice), and making
the same assumption about bio->bi_size in the case of an error.



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

Why is it better to say that all the io was 'done' rather than none?
It did fail after all.


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
@@ -395,9 +419,9 @@
 	 */
 	if (ci->sector_count) {
 		while (len) {
-			struct bio_vec *bv = clone->bi_io_vec + ci->idx;
-			sector_t bv_len = bv->bv_len >> SECTOR_SHIFT;
+			bv = bio->bi_io_vec + ci->idx;
+			bv_len = bv->bv_len >> SECTOR_SHIFT;
 			if (bv_len <= len)
 				len -= bv_len;
 

There is no need to use bio_alloc in preference to bio_clone, we're
not changing the bvec in any way.  All of the above code is redundant.

- Joe
