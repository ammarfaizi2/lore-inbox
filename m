Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUBTPbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUBTPbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:31:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21158 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261285AbUBTPbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:31:00 -0500
Date: Fri, 20 Feb 2004 15:34:03 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 1/6] dm: endio method
Message-ID: <20040220153403.GO27549@reti>
References: <20040220153145.GN27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220153145.GN27549@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an endio method to targets.  This method is allowed to request
another shot at failed ios (think multipath).  Context can be passed
between the map method and the endio method.
--- diff/drivers/md/dm-crypt.c	2004-02-18 15:15:18.000000000 +0000
+++ source/drivers/md/dm-crypt.c	2004-02-18 15:16:36.000000000 +0000
@@ -601,7 +601,8 @@ crypt_clone(struct crypt_config *cc, str
 	return clone;
 }
 
-static int crypt_map(struct dm_target *ti, struct bio *bio)
+static int crypt_map(struct dm_target *ti, struct bio *bio,
+		     union map_info *map_context)
 {
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
 	struct crypt_io *io = mempool_alloc(cc->io_pool, GFP_NOIO);
--- diff/drivers/md/dm-linear.c	2003-09-30 15:46:14.000000000 +0100
+++ source/drivers/md/dm-linear.c	2004-02-18 15:16:23.000000000 +0000
@@ -65,7 +65,8 @@ static void linear_dtr(struct dm_target 
 	kfree(lc);
 }
 
-static int linear_map(struct dm_target *ti, struct bio *bio)
+static int linear_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
 
--- diff/drivers/md/dm-stripe.c	2004-02-18 15:15:13.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2004-02-18 15:16:23.000000000 +0000
@@ -166,7 +166,8 @@ static void stripe_dtr(struct dm_target 
 	kfree(sc);
 }
 
-static int stripe_map(struct dm_target *ti, struct bio *bio)
+static int stripe_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
 {
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
 
--- diff/drivers/md/dm-target.c	2003-06-30 10:07:21.000000000 +0100
+++ source/drivers/md/dm-target.c	2004-02-18 15:16:23.000000000 +0000
@@ -157,7 +157,8 @@ static void io_err_dtr(struct dm_target 
 	/* empty */
 }
 
-static int io_err_map(struct dm_target *ti, struct bio *bio)
+static int io_err_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
 {
 	return -EIO;
 }
--- diff/drivers/md/dm.c	2004-02-18 15:15:13.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-18 15:16:23.000000000 +0000
@@ -21,6 +21,9 @@ static const char *_name = DM_NAME;
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
+/*
+ * One of these is allocated per bio.
+ */
 struct dm_io {
 	struct mapped_device *md;
 	int error;
@@ -29,6 +32,21 @@ struct dm_io {
 };
 
 /*
+ * One of these is allocated per target within a bio.  Hopefully
+ * this will be simplified out one day.
+ */
+struct target_io {
+	struct dm_io *io;
+	struct dm_target *ti;
+	union map_info info;
+
+	sector_t bi_sector;
+	struct block_device *bi_bdev;
+	unsigned int bi_size;
+	unsigned short bi_idx;
+};
+
+/*
  * Bits for the md->flags field.
  */
 #define DMF_BLOCK_IO 0
@@ -59,6 +77,7 @@ struct mapped_device {
 	 * io objects are allocated from here.
 	 */
 	mempool_t *io_pool;
+	mempool_t *tio_pool;
 
 	/*
 	 * Event handling.
@@ -69,6 +88,7 @@ struct mapped_device {
 
 #define MIN_IOS 256
 static kmem_cache_t *_io_cache;
+static kmem_cache_t *_tio_cache;
 
 static __init int local_init(void)
 {
@@ -80,9 +100,18 @@ static __init int local_init(void)
 	if (!_io_cache)
 		return -ENOMEM;
 
+	/* allocate a slab for the target ios */
+	_tio_cache = kmem_cache_create("dm_tio", sizeof(struct target_io),
+				       0, 0, NULL, NULL);
+	if (!_tio_cache) {
+		kmem_cache_destroy(_io_cache);
+		return -ENOMEM;
+	}
+
 	_major = major;
 	r = register_blkdev(_major, _name);
 	if (r < 0) {
+		kmem_cache_destroy(_tio_cache);
 		kmem_cache_destroy(_io_cache);
 		return r;
 	}
@@ -95,6 +124,7 @@ static __init int local_init(void)
 
 static void local_exit(void)
 {
+	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
 
 	if (unregister_blkdev(_major, _name) < 0)
@@ -184,6 +214,16 @@ static inline void free_io(struct mapped
 	mempool_free(io, md->io_pool);
 }
 
+static inline struct target_io *alloc_tio(struct mapped_device *md)
+{
+	return mempool_alloc(md->tio_pool, GFP_NOIO);
+}
+
+static inline void free_tio(struct mapped_device *md, struct target_io *tio)
+{
+	mempool_free(tio, md->tio_pool);
+}
+
 /*
  * Add the bio to the list of deferred io.
  */
@@ -232,17 +272,36 @@ static inline void dec_pending(struct dm
 
 static int clone_endio(struct bio *bio, unsigned int done, int error)
 {
-	struct dm_io *io = bio->bi_private;
+	int r = 0;
+	struct target_io *tio = bio->bi_private;
+	struct dm_io *io = tio->io;
+	dm_endio_fn endio = tio->ti->type->end_io;
 
 	if (bio->bi_size)
 		return 1;
 
+	if (endio) {
+		/* Restore bio fields. */
+		bio->bi_sector = tio->bi_sector;
+		bio->bi_bdev = tio->bi_bdev;
+		bio->bi_size = tio->bi_size;
+		bio->bi_idx = tio->bi_idx;
+
+		r = endio(tio->ti, bio, error, &tio->info);
+		if (r < 0)
+			error = r;
+
+		else if (r > 0)
+			/* the target wants another shot at the io */
+			return 1;
+	}
+
+	free_tio(io->md, tio);
 	dec_pending(io, error);
 	bio_put(bio);
-	return 0;
+	return r;
 }
 
-
 static sector_t max_io_len(struct mapped_device *md,
 			   sector_t sector, struct dm_target *ti)
 {
@@ -263,7 +322,8 @@ static sector_t max_io_len(struct mapped
 	return len;
 }
 
-static void __map_bio(struct dm_target *ti, struct bio *clone, struct dm_io *io)
+static void __map_bio(struct dm_target *ti, struct bio *clone,
+		      struct target_io *tio)
 {
 	int r;
 
@@ -273,22 +333,32 @@ static void __map_bio(struct dm_target *
 	BUG_ON(!clone->bi_size);
 
 	clone->bi_end_io = clone_endio;
-	clone->bi_private = io;
+	clone->bi_private = tio;
 
 	/*
 	 * Map the clone.  If r == 0 we don't need to do
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->io_count);
-	r = ti->type->map(ti, clone);
-	if (r > 0)
+	atomic_inc(&tio->io->io_count);
+	r = ti->type->map(ti, clone, &tio->info);
+	if (r > 0) {
+		/* Save the bio info so we can restore it during endio. */
+		tio->bi_sector = clone->bi_sector;
+		tio->bi_bdev = clone->bi_bdev;
+		tio->bi_size = clone->bi_size;
+		tio->bi_idx = clone->bi_idx;
+
 		/* the bio has been remapped so dispatch it */
 		generic_make_request(clone);
+	}
 
-	else if (r < 0)
+	else if (r < 0) {
 		/* error the io and bail out */
+		struct dm_io *io = tio->io;
+		free_tio(tio->io->md, tio);
 		dec_pending(io, -EIO);
+	}
 }
 
 struct clone_info {
@@ -348,6 +418,15 @@ static void __clone_and_map(struct clone
 	struct bio *clone, *bio = ci->bio;
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
 	sector_t len = 0, max = max_io_len(ci->md, ci->sector, ti);
+	struct target_io *tio;
+
+	/*
+	 * Allocate a target io object.
+	 */
+	tio = alloc_tio(ci->md);
+	tio->io = ci->io;
+	tio->ti = ti;
+	memset(&tio->info, 0, sizeof(tio->info));
 
 	if (ci->sector_count <= max) {
 		/*
@@ -356,7 +435,7 @@ static void __clone_and_map(struct clone
 		 */
 		clone = clone_bio(bio, ci->sector, ci->idx,
 				  bio->bi_vcnt - ci->idx, ci->sector_count);
-		__map_bio(ti, clone, ci->io);
+		__map_bio(ti, clone, tio);
 		ci->sector_count = 0;
 
 	} else if (to_sector(bio->bi_io_vec[ci->idx].bv_len) <= max) {
@@ -379,7 +458,7 @@ static void __clone_and_map(struct clone
 		}
 
 		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
-		__map_bio(ti, clone, ci->io);
+		__map_bio(ti, clone, tio);
 
 		ci->sector += len;
 		ci->sector_count -= len;
@@ -394,7 +473,7 @@ static void __clone_and_map(struct clone
 
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset, max);
-		__map_bio(ti, clone, ci->io);
+		__map_bio(ti, clone, tio);
 
 		ci->sector += max;
 		ci->sector_count -= max;
@@ -403,7 +482,11 @@ static void __clone_and_map(struct clone
 		len = to_sector(bv->bv_len) - max;
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset + to_bytes(max), len);
-		__map_bio(ti, clone, ci->io);
+		tio = alloc_tio(ci->md);
+		tio->io = ci->io;
+		tio->ti = ti;
+		memset(&tio->info, 0, sizeof(tio->info));
+		__map_bio(ti, clone, tio);
 
 		ci->sector += len;
 		ci->sector_count -= len;
@@ -441,6 +524,16 @@ static void __split_bio(struct mapped_de
  *---------------------------------------------------------------*/
 
 
+static inline void __dm_request(struct mapped_device *md, struct bio *bio)
+{
+	if (!md->map) {
+		bio_io_error(bio, bio->bi_size);
+		return;
+	}
+
+	__split_bio(md, bio);
+}
+
 /*
  * The request function that just remaps the bio built up by
  * dm_merge_bvec.
@@ -479,12 +572,7 @@ static int dm_request(request_queue_t *q
 		down_read(&md->lock);
 	}
 
-	if (!md->map) {
-		bio_io_error(bio, bio->bi_size);
-		return 0;
-	}
-
-	__split_bio(md, bio);
+	__dm_request(md, bio);
 	up_read(&md->lock);
 	return 0;
 }
@@ -574,9 +662,14 @@ static struct mapped_device *alloc_dev(u
  	if (!md->io_pool)
  		goto bad2;
 
+	md->tio_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+				      mempool_free_slab, _tio_cache);
+	if (!md->tio_pool)
+		goto bad3;
+
 	md->disk = alloc_disk(1);
 	if (!md->disk)
-		goto bad3;
+		goto bad4;
 
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
@@ -592,7 +685,8 @@ static struct mapped_device *alloc_dev(u
 
 	return md;
 
-
+ bad4:
+	mempool_destroy(md->tio_pool);
  bad3:
 	mempool_destroy(md->io_pool);
  bad2:
@@ -606,6 +700,7 @@ static struct mapped_device *alloc_dev(u
 static void free_dev(struct mapped_device *md)
 {
 	free_minor(md->disk->first_minor);
+	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
@@ -644,13 +739,13 @@ static int __bind(struct mapped_device *
 {
 	request_queue_t *q = md->queue;
 	sector_t size;
-	md->map = t;
 
 	size = dm_table_get_size(t);
 	__set_size(md->disk, size);
 	if (size == 0)
 		return 0;
 
+	md->map = t;
 	dm_table_event_callback(md->map, event_callback, md);
 
 	dm_table_get(t);
@@ -710,16 +805,16 @@ void dm_put(struct mapped_device *md)
 }
 
 /*
- * Requeue the deferred bios by calling generic_make_request.
+ * Process the deferred bios
  */
-static void flush_deferred_io(struct bio *c)
+static void __flush_deferred_io(struct mapped_device *md, struct bio *c)
 {
 	struct bio *n;
 
 	while (c) {
 		n = c->bi_next;
 		c->bi_next = NULL;
-		generic_make_request(c);
+		__dm_request(md, c);
 		c = n;
 	}
 }
@@ -814,10 +909,11 @@ int dm_resume(struct mapped_device *md)
 	dm_table_resume_targets(md->map);
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
+
 	def = bio_list_get(&md->deferred);
+	__flush_deferred_io(md, def);
 	up_write(&md->lock);
 
-	flush_deferred_io(def);
 	blk_run_queues();
 
 	return 0;
--- diff/include/linux/device-mapper.h	2003-06-30 10:07:24.000000000 +0100
+++ source/include/linux/device-mapper.h	2004-02-18 15:16:23.000000000 +0000
@@ -13,6 +13,11 @@ struct dm_dev;
 
 typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE } status_type_t;
 
+union map_info {
+	void *ptr;
+	unsigned long long ll;
+};
+
 /*
  * In the constructor the target parameter will already have the
  * table, type, begin and len fields filled in.
@@ -32,7 +37,19 @@ typedef void (*dm_dtr_fn) (struct dm_tar
  * = 0: The target will handle the io by resubmitting it later
  * > 0: simple remap complete
  */
-typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio,
+			  union map_info *map_context);
+
+/*
+ * Returns:
+ * < 0 : error (currently ignored)
+ * 0   : ended successfully
+ * 1   : for some reason the io has still not completed (eg,
+ *       multipath target might want to requeue a failed io).
+ */
+typedef int (*dm_endio_fn) (struct dm_target *ti,
+			    struct bio *bio, int error,
+			    union map_info *map_context);
 
 typedef void (*dm_suspend_fn) (struct dm_target *ti);
 typedef void (*dm_resume_fn) (struct dm_target *ti);
@@ -60,6 +77,7 @@ struct target_type {
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_endio_fn end_io;
 	dm_suspend_fn suspend;
 	dm_resume_fn resume;
 	dm_status_fn status;
