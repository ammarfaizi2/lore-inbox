Return-Path: <linux-kernel-owner+w=401wt.eu-S933043AbWLSWNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWLSWNq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWLSWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:13:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44796 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933043AbWLSWNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:13:44 -0500
Date: Tue, 19 Dec 2006 17:13:18 -0500 (EST)
Message-Id: <20061219.171318.31636037.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 5/8] rqbased-dm: add device initialization code
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device initialization code for request-based dm.
By checking md->features, the mapped device can be distinguished
whether it is request-based or not (bio-based).

The pointer to __make_request() is saved in md->saved_make_request_fn
to use in dm_make_request() which is set as md->queue->make_request_fn.
By doing that, __make_request() can be called without definition change
though it is static function in block/ll_rw_blk.c

Because this patch set doesn't split request, only one clone is created
per original request and counting of number of clones isn't needed.
So struct dm_io and struct target_io in bio-based dm are merged into
struct rq_target_io, and it is attached to each clone.
As a result, md->io_pool isn't used in request-based dm.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 4-add-ioctl/drivers/md/dm.c 5-core-init/drivers/md/dm.c
--- 4-add-ioctl/drivers/md/dm.c	2006-12-15 10:24:52.000000000 -0500
+++ 5-core-init/drivers/md/dm.c	2006-12-19 15:40:39.000000000 -0500
@@ -51,6 +51,24 @@ struct target_io {
 	union map_info info;
 };
 
+/*
+ * For request based dm.
+ * One of these is allocated per target (cloned request).
+ *
+ * Since request based dm doesn't split request, we can assume
+ * "original request : cloned request" is 1:1.
+ * So a counter of number of clones like struct dm_io.io_count isn't needed,
+ * and the roles of struct dm_io and struct target_io in bio-based dm
+ * are merged into struct rq_target_io.
+ */
+struct rq_target_io {
+	struct mapped_device *md;
+	int error;
+	struct request *rq;
+	struct dm_target *ti;
+	union map_info info;
+};
+
 union map_info *dm_get_mapinfo(struct bio *bio)
 {
 	if (bio && bio->bi_private)
@@ -69,6 +87,13 @@ union map_info *dm_get_mapinfo(struct bi
 #define DMF_FREEING 3
 #define DMF_DELETING 4
 
+/*
+ * Bits for the md->features field.
+ */
+#define DM_FEAT_REQUEST_BASE (1 << 0)
+
+#define dm_feat_rq_base(md) ((md)->features & DM_FEAT_REQUEST_BASE)
+
 struct mapped_device {
 	struct rw_semaphore io_lock;
 	struct semaphore suspend_lock;
@@ -77,6 +102,7 @@ struct mapped_device {
 	atomic_t open_count;
 
 	unsigned long flags;
+	unsigned long features;
 
 	request_queue_t *queue;
 	struct gendisk *disk;
@@ -118,11 +144,15 @@ struct mapped_device {
 
 	/* forced geometry settings */
 	struct hd_geometry geometry;
+
+	/* For saving the address of __make_request for request based dm */
+	make_request_fn *saved_make_request_fn;
 };
 
 #define MIN_IOS 256
 static kmem_cache_t *_io_cache;
 static kmem_cache_t *_tio_cache;
+static kmem_cache_t *_rq_tio_cache; /* For request based dm */
 
 static int __init local_init(void)
 {
@@ -142,9 +172,19 @@ static int __init local_init(void)
 		return -ENOMEM;
 	}
 
+	_rq_tio_cache = kmem_cache_create("dm_rq_tio",
+					  sizeof(struct rq_target_io),
+					  0, 0, NULL, NULL);
+	if (!_rq_tio_cache) {
+		kmem_cache_destroy(_tio_cache);
+		kmem_cache_destroy(_io_cache);
+		return -ENOMEM;
+	}
+
 	_major = major;
 	r = register_blkdev(_major, _name);
 	if (r < 0) {
+		kmem_cache_destroy(_rq_tio_cache);
 		kmem_cache_destroy(_tio_cache);
 		kmem_cache_destroy(_io_cache);
 		return r;
@@ -158,6 +198,7 @@ static int __init local_init(void)
 
 static void local_exit(void)
 {
+	kmem_cache_destroy(_rq_tio_cache);
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
 
@@ -342,6 +383,17 @@ static inline void free_tio(struct mappe
 	mempool_free(tio, md->tio_pool);
 }
 
+static inline struct rq_target_io *alloc_rq_tio(struct mapped_device *md)
+{
+	return mempool_alloc(md->tio_pool, GFP_ATOMIC);
+}
+
+static inline void free_rq_tio(struct mapped_device *md,
+			       struct rq_target_io *tio)
+{
+	mempool_free(tio, md->tio_pool);
+}
+
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
@@ -953,23 +1005,37 @@ static struct mapped_device *alloc_dev(i
 	atomic_set(&md->open_count, 0);
 	atomic_set(&md->event_nr, 0);
 
-	md->queue = blk_alloc_queue(GFP_KERNEL);
+	if (request_base) {
+		md->features |= DM_FEAT_REQUEST_BASE;
+		md->queue = blk_init_queue(dm_request_fn, NULL);
+	} else {
+		md->queue = blk_alloc_queue(GFP_KERNEL);
+	}
 	if (!md->queue)
 		goto bad1_free_minor;
 
 	md->queue->queuedata = md;
 	md->queue->backing_dev_info.congested_fn = dm_any_congested;
 	md->queue->backing_dev_info.congested_data = md;
-	blk_queue_make_request(md->queue, dm_request);
+	if (request_base) {
+		md->saved_make_request_fn = md->queue->make_request_fn;
+		blk_queue_make_request(md->queue, dm_make_request);
+		blk_queue_prep_rq(md->queue, dm_prep_fn);
+	} else {
+		blk_queue_make_request(md->queue, dm_request);
+	}
 	blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY);
 	md->queue->unplug_fn = dm_unplug_all;
 	md->queue->issue_flush_fn = dm_flush_all;
 
-	md->io_pool = mempool_create_slab_pool(MIN_IOS, _io_cache);
- 	if (!md->io_pool)
- 		goto bad2;
+	if (!request_base) {
+		md->io_pool = mempool_create_slab_pool(MIN_IOS, _io_cache);
+		if (!md->io_pool)
+			goto bad2;
+	}
 
-	md->tio_pool = mempool_create_slab_pool(MIN_IOS, _tio_cache);
+	md->tio_pool = mempool_create_slab_pool(MIN_IOS,
+				request_base ? _rq_tio_cache : _tio_cache);
 	if (!md->tio_pool)
 		goto bad3;
 
@@ -1008,7 +1074,8 @@ static struct mapped_device *alloc_dev(i
  bad_no_bioset:
 	mempool_destroy(md->tio_pool);
  bad3:
-	mempool_destroy(md->io_pool);
+	if (md->io_pool)
+		mempool_destroy(md->io_pool);
  bad2:
 	blk_cleanup_queue(md->queue);
  bad1_free_minor:
@@ -1029,7 +1096,8 @@ static void free_dev(struct mapped_devic
 		bdput(md->suspended_bdev);
 	}
 	mempool_destroy(md->tio_pool);
-	mempool_destroy(md->io_pool);
+	if (md->io_pool)
+		mempool_destroy(md->io_pool);
 	bioset_free(md->bs);
 	del_gendisk(md->disk);
 	free_minor(minor);

