Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWINViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWINViW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWINViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:38:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751160AbWINViT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:38:19 -0400
Date: Thu, 14 Sep 2006 22:38:14 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 03/25] dm snapshot: allow zero chunk_size
Message-ID: <20060914213814.GK3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark McLoughlin <markmc@redhat.com>

The chunk size of snapshots cannot be changed so it is redundant to
require it as a parameter when activating an existing snapshot.
Allow a value of zero in this case and ignore it.  For a new snapshot,
use a default value if zero is specified.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-exception-store.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-exception-store.c	2006-09-14 20:25:35.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-exception-store.c	2006-09-14 20:29:57.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 
 #define DM_MSG_PREFIX "snapshots"
+#define DM_CHUNK_SIZE_DEFAULT_SECTORS 32	/* 16KB */
 
 /*-----------------------------------------------------------------
  * Persistent snapshots, by persistent we mean that the snapshot
@@ -150,6 +151,7 @@ static int alloc_area(struct pstore *ps)
 static void free_area(struct pstore *ps)
 {
 	vfree(ps->area);
+	ps->area = NULL;
 }
 
 /*
@@ -198,48 +200,79 @@ static int read_header(struct pstore *ps
 	int r;
 	struct disk_header *dh;
 	chunk_t chunk_size;
+	int chunk_size_supplied = 1;
 
-	r = chunk_io(ps, 0, READ);
+	/*
+	 * Use default chunk size (or hardsect_size, if larger) if none supplied
+	 */
+	if (!ps->snap->chunk_size) {
+        	ps->snap->chunk_size = max(DM_CHUNK_SIZE_DEFAULT_SECTORS,
+		    bdev_hardsect_size(ps->snap->cow->bdev) >> 9);
+		ps->snap->chunk_mask = ps->snap->chunk_size - 1;
+		ps->snap->chunk_shift = ffs(ps->snap->chunk_size) - 1;
+		chunk_size_supplied = 0;
+	}
+
+	r = dm_io_get(sectors_to_pages(ps->snap->chunk_size));
 	if (r)
 		return r;
 
+	r = alloc_area(ps);
+	if (r)
+		goto bad1;
+
+	r = chunk_io(ps, 0, READ);
+	if (r)
+		goto bad2;
+
 	dh = (struct disk_header *) ps->area;
 
 	if (le32_to_cpu(dh->magic) == 0) {
 		*new_snapshot = 1;
+		return 0;
+	}
 
-	} else if (le32_to_cpu(dh->magic) == SNAP_MAGIC) {
-		*new_snapshot = 0;
-		ps->valid = le32_to_cpu(dh->valid);
-		ps->version = le32_to_cpu(dh->version);
-		chunk_size = le32_to_cpu(dh->chunk_size);
-		if (ps->snap->chunk_size != chunk_size) {
-			DMWARN("chunk size %llu in device metadata overrides "
-			       "table chunk size of %llu.",
-			       (unsigned long long)chunk_size,
-			       (unsigned long long)ps->snap->chunk_size);
-
-			/* We had a bogus chunk_size. Fix stuff up. */
-			dm_io_put(sectors_to_pages(ps->snap->chunk_size));
-			free_area(ps);
-
-			ps->snap->chunk_size = chunk_size;
-			ps->snap->chunk_mask = chunk_size - 1;
-			ps->snap->chunk_shift = ffs(chunk_size) - 1;
-
-			r = alloc_area(ps);
-			if (r)
-				return r;
-
-			r = dm_io_get(sectors_to_pages(chunk_size));
-			if (r)
-				return r;
-		}
-	} else {
-		DMWARN("Invalid/corrupt snapshot");
+	if (le32_to_cpu(dh->magic) != SNAP_MAGIC) {
+		DMWARN("Invalid or corrupt snapshot");
 		r = -ENXIO;
+		goto bad2;
 	}
 
+	*new_snapshot = 0;
+	ps->valid = le32_to_cpu(dh->valid);
+	ps->version = le32_to_cpu(dh->version);
+	chunk_size = le32_to_cpu(dh->chunk_size);
+
+	if (!chunk_size_supplied || ps->snap->chunk_size == chunk_size)
+		return 0;
+
+	DMWARN("chunk size %llu in device metadata overrides "
+	       "table chunk size of %llu.",
+	       (unsigned long long)chunk_size,
+	       (unsigned long long)ps->snap->chunk_size);
+
+	/* We had a bogus chunk_size. Fix stuff up. */
+	dm_io_put(sectors_to_pages(ps->snap->chunk_size));
+	free_area(ps);
+
+	ps->snap->chunk_size = chunk_size;
+	ps->snap->chunk_mask = chunk_size - 1;
+	ps->snap->chunk_shift = ffs(chunk_size) - 1;
+
+	r = dm_io_get(sectors_to_pages(chunk_size));
+	if (r)
+		return r;
+
+	r = alloc_area(ps);
+	if (r)
+		goto bad1;
+
+	return 0;
+
+bad2:
+	free_area(ps);
+bad1:
+	dm_io_put(sectors_to_pages(ps->snap->chunk_size));
 	return r;
 }
 
@@ -547,32 +580,22 @@ static void persistent_drop(struct excep
 		DMWARN("write header failed");
 }
 
-int dm_create_persistent(struct exception_store *store, uint32_t chunk_size)
+int dm_create_persistent(struct exception_store *store)
 {
-	int r;
 	struct pstore *ps;
 
-	r = dm_io_get(sectors_to_pages(chunk_size));
-	if (r)
-		return r;
-
 	/* allocate the pstore */
 	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
-	if (!ps) {
-		r = -ENOMEM;
-		goto bad;
-	}
+	if (!ps)
+		return -ENOMEM;
 
 	ps->snap = store->snap;
 	ps->valid = 1;
 	ps->version = SNAPSHOT_DISK_VERSION;
+	ps->area = NULL;
 	ps->next_free = 2;	/* skipping the header and first area */
 	ps->current_committed = 0;
 
-	r = alloc_area(ps);
-	if (r)
-		goto bad;
-
 	ps->callback_count = 0;
 	atomic_set(&ps->pending_count, 0);
 	ps->callbacks = NULL;
@@ -586,13 +609,6 @@ int dm_create_persistent(struct exceptio
 	store->context = ps;
 
 	return 0;
-
-      bad:
-	dm_io_put(sectors_to_pages(chunk_size));
-	if (ps && ps->area)
-		free_area(ps);
-	kfree(ps);
-	return r;
 }
 
 /*-----------------------------------------------------------------
@@ -642,18 +658,16 @@ static void transient_fraction_full(stru
 	*denominator = get_dev_size(store->snap->cow->bdev);
 }
 
-int dm_create_transient(struct exception_store *store,
-			struct dm_snapshot *s, int blocksize)
+int dm_create_transient(struct exception_store *store)
 {
 	struct transient_c *tc;
 
-	memset(store, 0, sizeof(*store));
 	store->destroy = transient_destroy;
 	store->read_metadata = transient_read_metadata;
 	store->prepare_exception = transient_prepare;
 	store->commit_exception = transient_commit;
+	store->drop_snapshot = NULL;
 	store->fraction_full = transient_fraction_full;
-	store->snap = s;
 
 	tc = kmalloc(sizeof(struct transient_c), GFP_KERNEL);
 	if (!tc)
Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:26:20.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:29:57.000000000 +0100
@@ -398,21 +398,60 @@ static void read_snapshot_metadata(struc
 	}
 }
 
+static int set_chunk_size(struct dm_snapshot *s, const char *chunk_size_arg,
+			  char **error)
+{
+	unsigned long chunk_size;
+	char *value;
+
+	chunk_size = simple_strtoul(chunk_size_arg, &value, 10);
+	if (*chunk_size_arg == '\0' || *value != '\0') {
+		*error = "Invalid chunk size";
+		return -EINVAL;
+	}
+
+	if (!chunk_size) {
+		s->chunk_size = s->chunk_mask = s->chunk_shift = 0;
+		return 0;
+	}
+
+	/*
+	 * Chunk size must be multiple of page size.  Silently
+	 * round up if it's not.
+	 */
+	chunk_size = round_up(chunk_size, PAGE_SIZE >> 9);
+
+	/* Check chunk_size is a power of 2 */
+	if (chunk_size & (chunk_size - 1)) {
+		*error = "Chunk size is not a power of 2";
+		return -EINVAL;
+	}
+
+	/* Validate the chunk size against the device block size */
+	if (chunk_size % (bdev_hardsect_size(s->cow->bdev) >> 9)) {
+		*error = "Chunk size is not a multiple of device blocksize";
+		return -EINVAL;
+	}
+
+	s->chunk_size = chunk_size;
+	s->chunk_mask = chunk_size - 1;
+	s->chunk_shift = ffs(chunk_size) - 1;
+
+	return 0;
+}
+
 /*
  * Construct a snapshot mapping: <origin_dev> <COW-dev> <p/n> <chunk-size>
  */
 static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	struct dm_snapshot *s;
-	unsigned long chunk_size;
 	int r = -EINVAL;
 	char persistent;
 	char *origin_path;
 	char *cow_path;
-	char *value;
-	int blocksize;
 
-	if (argc < 4) {
+	if (argc != 4) {
 		ti->error = "requires exactly 4 arguments";
 		r = -EINVAL;
 		goto bad1;
@@ -428,13 +467,6 @@ static int snapshot_ctr(struct dm_target
 		goto bad1;
 	}
 
-	chunk_size = simple_strtoul(argv[3], &value, 10);
-	if (chunk_size == 0 || value == NULL) {
-		ti->error = "Invalid chunk size";
-		r = -EINVAL;
-		goto bad1;
-	}
-
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
 	if (s == NULL) {
 		ti->error = "Cannot allocate snapshot context private "
@@ -457,31 +489,11 @@ static int snapshot_ctr(struct dm_target
 		goto bad2;
 	}
 
-	/*
-	 * Chunk size must be multiple of page size.  Silently
-	 * round up if it's not.
-	 */
-	chunk_size = round_up(chunk_size, PAGE_SIZE >> 9);
-
-	/* Validate the chunk size against the device block size */
-	blocksize = s->cow->bdev->bd_disk->queue->hardsect_size;
-	if (chunk_size % (blocksize >> 9)) {
-		ti->error = "Chunk size is not a multiple of device blocksize";
-		r = -EINVAL;
-		goto bad3;
-	}
-
-	/* Check chunk_size is a power of 2 */
-	if (chunk_size & (chunk_size - 1)) {
-		ti->error = "Chunk size is not a power of 2";
-		r = -EINVAL;
+	r = set_chunk_size(s, argv[3], &ti->error);
+	if (r)
 		goto bad3;
-	}
 
-	s->chunk_size = chunk_size;
-	s->chunk_mask = chunk_size - 1;
 	s->type = persistent;
-	s->chunk_shift = ffs(chunk_size) - 1;
 
 	s->valid = 1;
 	s->active = 0;
@@ -496,16 +508,12 @@ static int snapshot_ctr(struct dm_target
 		goto bad3;
 	}
 
-	/*
-	 * Check the persistent flag - done here because we need the iobuf
-	 * to check the LV header
-	 */
 	s->store.snap = s;
 
 	if (persistent == 'P')
-		r = dm_create_persistent(&s->store, chunk_size);
+		r = dm_create_persistent(&s->store);
 	else
-		r = dm_create_transient(&s->store, s, blocksize);
+		r = dm_create_transient(&s->store);
 
 	if (r) {
 		ti->error = "Couldn't create exception store";
@@ -1205,7 +1213,7 @@ static int origin_status(struct dm_targe
 
 static struct target_type origin_target = {
 	.name    = "snapshot-origin",
-	.version = {1, 4, 0},
+	.version = {1, 5, 0},
 	.module  = THIS_MODULE,
 	.ctr     = origin_ctr,
 	.dtr     = origin_dtr,
@@ -1216,7 +1224,7 @@ static struct target_type origin_target 
 
 static struct target_type snapshot_target = {
 	.name    = "snapshot",
-	.version = {1, 4, 0},
+	.version = {1, 5, 0},
 	.module  = THIS_MODULE,
 	.ctr     = snapshot_ctr,
 	.dtr     = snapshot_dtr,
Index: linux-2.6.18-rc7/drivers/md/dm-snap.h
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.h	2006-09-14 20:25:35.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.h	2006-09-14 20:29:57.000000000 +0100
@@ -128,10 +128,9 @@ int dm_add_exception(struct dm_snapshot 
  * Constructor and destructor for the default persistent
  * store.
  */
-int dm_create_persistent(struct exception_store *store, uint32_t chunk_size);
+int dm_create_persistent(struct exception_store *store);
 
-int dm_create_transient(struct exception_store *store,
-			struct dm_snapshot *s, int blocksize);
+int dm_create_transient(struct exception_store *store);
 
 /*
  * Return the number of sectors in the device.
