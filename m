Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbSJNDRy>; Sun, 13 Oct 2002 23:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSJNDRy>; Sun, 13 Oct 2002 23:17:54 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:21244 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261803AbSJNDRw>; Sun, 13 Oct 2002 23:17:52 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15786.14523.6938.812495@wombat.chubb.wattle.id.au>
Date: Mon, 14 Oct 2002 13:23:39 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, axboe@suse.de
Subject: [PATCH] Fix Raid0 again.
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Raid0 can't accept I/O requests that span a chunk boundary, as each
chunk goes to a different underlying queue.

The appended patch registers a `mergeable' function with the device
queue, to prevent requests being merged if the merged request would
span a chunk boundary.

I'm assuming that the most restrictive queueing parameters are those
of the raid0 code itself; if that isn't the case, then extra code has
to be added to reflect the most limiting case from the underlying
devices up into the raid0 device's queue.

If raid0 is on top of SCSI or ATA discs, or loopback-mounted
files, the assumption will almost always hold.

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/raid0.c linux-2.5-mdfix/drivers/md/raid0.c
--- linux-2.5-import/drivers/md/raid0.c	Mon Oct 14 10:32:35 2002
+++ linux-2.5-mdfix/drivers/md/raid0.c	Mon Oct 14 11:46:53 2002
@@ -162,6 +162,29 @@
 	return 1;
 }
 
+/**
+ *	raid0_mergeable_bvec -- tell bio layer if a two requests can be merged
+ *	@q: request queue
+ *	@bio: the buffer head that's been built up so far
+ *	@biovec: the request that could be merged to it.
+ *
+ *	Return 1 if the merge is not permitted (because the
+ *	result would cross a chunk boundary), 0 otherwise.
+ */
+static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
+{
+	mddev_t *mddev = q->queuedata;
+	sector_t block;
+	unsigned int chunk_size;
+	unsigned int bio_sz;
+
+	chunk_size = mddev->chunk_size >> 10;
+	block = bio->bi_sector >> 1;
+	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
+
+	return chunk_size < ((block & (chunk_size - 1)) + bio_sz);
+}
+
 static int raid0_run (mddev_t *mddev)
 {
 	unsigned  cur=0, i=0, nb_zone;
@@ -233,6 +256,8 @@
 		conf->hash_table[i++].zone1 = conf->strip_zone + cur;
 		size -= (conf->smallest->size - zone0_size);
 	}
+	blk_queue_max_sectors(&mddev->queue, mddev->chunk_size >> 9);
+	blk_queue_merge_bvec(&mddev->queue, raid0_mergeable_bvec);
 	return 0;
 
 out_free_zone_conf:
@@ -262,13 +287,6 @@
 	return 0;
 }
 
-/*
- * FIXME - We assume some things here :
- * - requested buffers NEVER bigger than chunk size,
- * - requested buffers NEVER cross stripes limits.
- * Of course, those facts may not be valid anymore (and surely won't...)
- * Hey guys, there's some work out there ;-)
- */
 static int raid0_make_request (request_queue_t *q, struct bio *bio)
 {
 	mddev_t *mddev = q->queuedata;
@@ -291,8 +309,8 @@
 		hash = conf->hash_table + x;
 	}
 
-	/* Sanity check */
-	if (chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10))
+	/* Sanity check -- queue functions should prevent this happening */
+	if (unlikely(chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10)))
 		goto bad_map;
  
 	if (!hash)
