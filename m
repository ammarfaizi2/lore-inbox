Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbSJOANr>; Mon, 14 Oct 2002 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJOANr>; Mon, 14 Oct 2002 20:13:47 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4591 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262097AbSJOANn>; Mon, 14 Oct 2002 20:13:43 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15787.24262.280423.570957@wombat.chubb.wattle.id.au>
Date: Tue, 15 Oct 2002 10:18:14 +1000
To: David Mansfield <lkml@dm.cobite.com>, akpm@zip.com.au,
       torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] Compile failure (gcc 2.96 bug?). 2.5.42 raid0.c
In-Reply-To: <540557597@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mansfield <lkml@dm.cobite.com> writes:

David> Trying to compile 2.5.42 I encountered the following error,
David> which looks a lot like a GCC bug.  I did a 'make mrproper; make
David> oldconfig; make bzImage' and it still failed.

(lots of gcc internal structure dump deleted here)

Yes it's a GCC optimiser bug.  I'm surprised I didn't see it: I tried
a whole heap of different compilers on that code, and had problems
only on the earlier similar code in raid0_run().

I didn't try redhat's compilers (I run debian) but didn't expect the
behaviour to be that different.

Anyway, please apply this patch (which also fixes the chunk overlap
problems).

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/raid0.c linux-2.5-mdfix/drivers/md/raid0.c
--- linux-2.5-import/drivers/md/raid0.c	Mon Oct 14 10:32:35 2002
+++ linux-2.5-mdfix/drivers/md/raid0.c	Tue Oct 15 10:03:07 2002
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
@@ -286,13 +304,16 @@
 	
 
 	{
+#if __GNUC__ < 3
+		volatile
+#endif
 		sector_t x = block;
 		sector_div(x, (unsigned long)conf->smallest->size);
 		hash = conf->hash_table + x;
 	}
 
-	/* Sanity check */
-	if (chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10))
+	/* Sanity check -- queue functions should prevent this happening */
+	if (unlikely(chunk_size < (block & (chunk_size - 1)) + (bio->bi_size >> 10)))
 		goto bad_map;
  
 	if (!hash)
