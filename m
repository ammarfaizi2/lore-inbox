Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSLPKFB>; Mon, 16 Dec 2002 05:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSLPKEV>; Mon, 16 Dec 2002 05:04:21 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:35340 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266584AbSLPKDH>; Mon, 16 Dec 2002 05:03:07 -0500
Date: Mon, 16 Dec 2002 10:11:13 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 8/19
Message-ID: <20021216101113.GI7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give each device its own io mempool to avoid a potential
deadlock with stacked devices.  [HM + EJT]
--- diff/drivers/md/dm.c	2002-12-16 09:40:44.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:40:58.000000000 +0000
@@ -58,11 +58,15 @@
 	 * The current mapping.
 	 */
 	struct dm_table *map;
+
+	/*
+	 * io objects are allocated from here.
+	 */
+	mempool_t *io_pool;
 };
 
 #define MIN_IOS 256
 static kmem_cache_t *_io_cache;
-static mempool_t *_io_pool;
 
 static __init int local_init(void)
 {
@@ -74,18 +78,10 @@
 	if (!_io_cache)
 		return -ENOMEM;
 
-	_io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				  mempool_free_slab, _io_cache);
-	if (!_io_pool) {
-		kmem_cache_destroy(_io_cache);
-		return -ENOMEM;
-	}
-
 	_major = major;
 	r = register_blkdev(_major, _name, &dm_blk_dops);
 	if (r < 0) {
 		DMERR("register_blkdev failed");
-		mempool_destroy(_io_pool);
 		kmem_cache_destroy(_io_cache);
 		return r;
 	}
@@ -98,7 +94,6 @@
 
 static void local_exit(void)
 {
-	mempool_destroy(_io_pool);
 	kmem_cache_destroy(_io_cache);
 
 	if (unregister_blkdev(_major, _name) < 0)
@@ -178,14 +173,14 @@
 	return 0;
 }
 
-static inline struct dm_io *alloc_io(void)
+static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
-	return mempool_alloc(_io_pool, GFP_NOIO);
+	return mempool_alloc(md->io_pool, GFP_NOIO);
 }
 
-static inline void free_io(struct dm_io *io)
+static inline void free_io(struct mapped_device *md, struct dm_io *io)
 {
-	mempool_free(io, _io_pool);
+	mempool_free(io, md->io_pool);
 }
 
 static inline struct deferred_io *alloc_deferred(void)
@@ -254,7 +249,7 @@
 			wake_up(&io->md->wait);
 
 		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
-		free_io(io);
+		free_io(io->md, io);
 	}
 }
 
@@ -419,7 +414,7 @@
 
 	ci.md = md;
 	ci.bio = bio;
-	ci.io = alloc_io();
+	ci.io = alloc_io(md);
 	ci.io->error = 0;
 	atomic_set(&ci.io->io_count, 1);
 	ci.io->bio = bio;
@@ -558,8 +553,17 @@
 	md->queue.queuedata = md;
 	blk_queue_make_request(&md->queue, dm_request);
 
+	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+				     mempool_free_slab, _io_cache);
+	if (!md->io_pool) {
+		free_minor(md->disk->first_minor);
+		kfree(md);
+		return NULL;
+	}
+
 	md->disk = alloc_disk(1);
 	if (!md->disk) {
+		mempool_destroy(md->io_pool);
 		free_minor(md->disk->first_minor);
 		kfree(md);
 		return NULL;
@@ -581,6 +585,7 @@
 static void free_dev(struct mapped_device *md)
 {
 	free_minor(md->disk->first_minor);
+	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
 	kfree(md);
