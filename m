Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbSJIVml>; Wed, 9 Oct 2002 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSJIVml>; Wed, 9 Oct 2002 17:42:41 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:19417 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S262094AbSJIVmO>; Wed, 9 Oct 2002 17:42:14 -0400
Date: Wed, 9 Oct 2002 23:47:50 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Anton Blanchard <anton@samba.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: 2.5.40: raid0_make_request bug and bad: scheduling while atomic!
Message-ID: <20021009234750.A28071@cistron.nl>
References: <anf7nq$qp2$1@ncc1701.cistron.net> <3DA01C81.D2BDD8C7@aitel.hist.no> <20021006122422.GH22888@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021006122422.GH22888@krispykreme>; from anton@samba.org on Sun, Oct 06, 2002 at 10:24:22PM +1000
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Anton Blanchard:
> Peter Chubb mailed a fix for this to linux-kernel in the last week
> and I can confirm it fixes all my raid0 problems. Thanks Peter!
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103369952814053&w=2

Indeed it works. I'm running it on 2.5.41-mm1; here's the
adjusted patch.

linux-2.5.41-mm1-raid0.patch

--- linux-2.5.41-mm1/drivers/md/raid0.c.orig	Tue Oct  8 23:56:14 2002
+++ linux-2.5.41-mm1/drivers/md/raid0.c	Wed Oct  9 00:00:58 2002
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

