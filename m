Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJDChi>; Thu, 3 Oct 2002 22:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJDChi>; Thu, 3 Oct 2002 22:37:38 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:29948 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261449AbSJDChg>; Thu, 3 Oct 2002 22:37:36 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15773.54.702505.125505@wombat.chubb.wattle.id.au>
Date: Fri, 4 Oct 2002 12:43:02 +1000
To: akpm@digeo.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix Raid0 request crossing chunk-boundary bug
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The new block layer is much more aggressive at merging requests than
it used to be.  Poor old raid0 can't cope with requests that span a
chunk boundary.  So we see messages like:

raid0_make_request bug: can't convert block across chunks or bigger\
than  8k 72378616 48

if the chunk-size is 8k and enough requests get merged to make a 48k
request.

Fortunately there are ways of telling the bio layer not to do this.
The attached patch against 2.5.40 does this.

Anyone who wants it can either apply the patch, or pull it from
bk://gelato.unsw.edu.au:2026


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.692   -> 1.693  
#	  drivers/md/raid0.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	peterc@gelato.unsw.edu.au	1.693
# 
# Raid0 was spitting out messages like this:
#  raid0_make_request bug: can't convert block across chunks or bigger than\
#  8k 72378616 48 
# 
# To fix it, register a `may-merge' function with the block layer, 
# to prevent requests being merged such that they cross chunk boundaries.
# --------------------------------------------
#
diff -Nru a/drivers/md/raid0.c b/drivers/md/raid0.c
--- a/drivers/md/raid0.c	Fri Oct  4 12:32:11 2002
+++ b/drivers/md/raid0.c	Fri Oct  4 12:32:11 2002
@@ -161,6 +161,29 @@
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
+	return chunk_size < ((block % chunk_size) + bio_sz);
+}
+
 static int raid0_run (mddev_t *mddev)
 {
 	unsigned long cur=0, i=0, size, zone0_size, nb_zone;
@@ -225,6 +248,8 @@
 		conf->hash_table[i++].zone1 = conf->strip_zone + cur;
 		size -= (conf->smallest->size - zone0_size);
 	}
+	blk_queue_max_sectors(&mddev->queue, mddev->chunk_size >> 9);
+	blk_queue_merge_bvec(&mddev->queue, raid0_mergeable_bvec);
 	return 0;
 
 out_free_zone_conf:
@@ -254,13 +279,6 @@
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
@@ -276,8 +294,8 @@
 	block = bio->bi_sector >> 1;
 	hash = conf->hash_table + block / conf->smallest->size;
 
-	/* Sanity check */
-	if (chunk_size < (block % chunk_size) + (bio->bi_size >> 10))
+	/* Sanity check -- queue functions should prevent this happening */
+	if (unlikely(chunk_size < (block % chunk_size) + (bio->bi_size >> 10)))
 		goto bad_map;
  
 	if (!hash)
