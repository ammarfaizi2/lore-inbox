Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUFBPt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUFBPt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFBPt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:49:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263199AbUFBPm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:42:56 -0400
Date: Wed, 2 Jun 2004 16:42:47 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/5: Device-mapper: snapshots
Message-ID: <20040602154247.GP6302@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snapshot target

--- diff/drivers/md/Kconfig	2004-05-09 21:32:00.000000000 -0500
+++ source/drivers/md/Kconfig	2004-06-01 19:52:09.000000000 -0500
@@ -180,5 +180,11 @@
 
 	  If unsure, say N.
 
+config DM_SNAPSHOT
+       tristate "Snapshot target (EXPERIMENTAL)"
+       depends on BLK_DEV_DM && EXPERIMENTAL
+       ---help---
+         Allow volume managers to take writeable snapshots of a device.
+
 endmenu
 
--- diff/drivers/md/Makefile	2004-06-01 19:51:31.000000000 -0500
+++ source/drivers/md/Makefile	2004-06-01 19:52:09.000000000 -0500
@@ -4,6 +4,7 @@
 
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o kcopyd.o
+dm-snapshot-objs := dm-snap.o dm-exception-store.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
@@ -24,6 +25,7 @@
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
+obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
--- diff/drivers/md/dm-exception-store.c	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-exception-store.c	2004-06-01 19:52:09.000000000 -0500
@@ -0,0 +1,648 @@
+/*
+ * dm-snapshot.c
+ *
+ * Copyright (C) 2001-2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+#include "dm-snap.h"
+#include "dm-io.h"
+#include "kcopyd.h"
+
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+/*-----------------------------------------------------------------
+ * Persistent snapshots, by persistent we mean that the snapshot
+ * will survive a reboot.
+ *---------------------------------------------------------------*/
+
+/*
+ * We need to store a record of which parts of the origin have
+ * been copied to the snapshot device.  The snapshot code
+ * requires that we copy exception chunks to chunk aligned areas
+ * of the COW store.  It makes sense therefore, to store the
+ * metadata in chunk size blocks.
+ *
+ * There is no backward or forward compatibility implemented,
+ * snapshots with different disk versions than the kernel will
+ * not be usable.  It is expected that "lvcreate" will blank out
+ * the start of a fresh COW device before calling the snapshot
+ * constructor.
+ *
+ * The first chunk of the COW device just contains the header.
+ * After this there is a chunk filled with exception metadata,
+ * followed by as many exception chunks as can fit in the
+ * metadata areas.
+ *
+ * All on disk structures are in little-endian format.  The end
+ * of the exceptions info is indicated by an exception with a
+ * new_chunk of 0, which is invalid since it would point to the
+ * header chunk.
+ */
+
+/*
+ * Magic for persistent snapshots: "SnAp" - Feeble isn't it.
+ */
+#define SNAP_MAGIC 0x70416e53
+
+/*
+ * The on-disk version of the metadata.
+ */
+#define SNAPSHOT_DISK_VERSION 1
+
+struct disk_header {
+	uint32_t magic;
+
+	/*
+	 * Is this snapshot valid.  There is no way of recovering
+	 * an invalid snapshot.
+	 */
+	uint32_t valid;
+
+	/*
+	 * Simple, incrementing version. no backward
+	 * compatibility.
+	 */
+	uint32_t version;
+
+	/* In sectors */
+	uint32_t chunk_size;
+};
+
+struct disk_exception {
+	uint64_t old_chunk;
+	uint64_t new_chunk;
+};
+
+struct commit_callback {
+	void (*callback)(void *, int success);
+	void *context;
+};
+
+/*
+ * The top level structure for a persistent exception store.
+ */
+struct pstore {
+	struct dm_snapshot *snap;	/* up pointer to my snapshot */
+	int version;
+	int valid;
+	uint32_t chunk_size;
+	uint32_t exceptions_per_area;
+
+	/*
+	 * Now that we have an asynchronous kcopyd there is no
+	 * need for large chunk sizes, so it wont hurt to have a
+	 * whole chunks worth of metadata in memory at once.
+	 */
+	void *area;
+
+	/*
+	 * Used to keep track of which metadata area the data in
+	 * 'chunk' refers to.
+	 */
+	uint32_t current_area;
+
+	/*
+	 * The next free chunk for an exception.
+	 */
+	uint32_t next_free;
+
+	/*
+	 * The index of next free exception in the current
+	 * metadata area.
+	 */
+	uint32_t current_committed;
+
+	atomic_t pending_count;
+	uint32_t callback_count;
+	struct commit_callback *callbacks;
+};
+
+static inline unsigned int sectors_to_pages(unsigned int sectors)
+{
+	return sectors / (PAGE_SIZE >> 9);
+}
+
+static int alloc_area(struct pstore *ps)
+{
+	int r = -ENOMEM;
+	size_t len;
+
+	len = ps->chunk_size << SECTOR_SHIFT;
+
+	/*
+	 * Allocate the chunk_size block of memory that will hold
+	 * a single metadata area.
+	 */
+	ps->area = vmalloc(len);
+	if (!ps->area)
+		return r;
+
+	return 0;
+}
+
+static void free_area(struct pstore *ps)
+{
+	vfree(ps->area);
+}
+
+/*
+ * Read or write a chunk aligned and sized block of data from a device.
+ */
+static int chunk_io(struct pstore *ps, uint32_t chunk, int rw)
+{
+	struct io_region where;
+	unsigned long bits;
+
+	where.bdev = ps->snap->cow->bdev;
+	where.sector = ps->chunk_size * chunk;
+	where.count = ps->chunk_size;
+
+	return dm_io_sync_vm(1, &where, rw, ps->area, &bits);
+}
+
+/*
+ * Read or write a metadata area.  Remembering to skip the first
+ * chunk which holds the header.
+ */
+static int area_io(struct pstore *ps, uint32_t area, int rw)
+{
+	int r;
+	uint32_t chunk;
+
+	/* convert a metadata area index to a chunk index */
+	chunk = 1 + ((ps->exceptions_per_area + 1) * area);
+
+	r = chunk_io(ps, chunk, rw);
+	if (r)
+		return r;
+
+	ps->current_area = area;
+	return 0;
+}
+
+static int zero_area(struct pstore *ps, uint32_t area)
+{
+	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+	return area_io(ps, area, WRITE);
+}
+
+static int read_header(struct pstore *ps, int *new_snapshot)
+{
+	int r;
+	struct disk_header *dh;
+
+	r = chunk_io(ps, 0, READ);
+	if (r)
+		return r;
+
+	dh = (struct disk_header *) ps->area;
+
+	if (le32_to_cpu(dh->magic) == 0) {
+		*new_snapshot = 1;
+
+	} else if (le32_to_cpu(dh->magic) == SNAP_MAGIC) {
+		*new_snapshot = 0;
+		ps->valid = le32_to_cpu(dh->valid);
+		ps->version = le32_to_cpu(dh->version);
+		ps->chunk_size = le32_to_cpu(dh->chunk_size);
+
+	} else {
+		DMWARN("Invalid/corrupt snapshot");
+		r = -ENXIO;
+	}
+
+	return r;
+}
+
+static int write_header(struct pstore *ps)
+{
+	struct disk_header *dh;
+
+	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+
+	dh = (struct disk_header *) ps->area;
+	dh->magic = cpu_to_le32(SNAP_MAGIC);
+	dh->valid = cpu_to_le32(ps->valid);
+	dh->version = cpu_to_le32(ps->version);
+	dh->chunk_size = cpu_to_le32(ps->chunk_size);
+
+	return chunk_io(ps, 0, WRITE);
+}
+
+/*
+ * Access functions for the disk exceptions, these do the endian conversions.
+ */
+static struct disk_exception *get_exception(struct pstore *ps, uint32_t index)
+{
+	if (index >= ps->exceptions_per_area)
+		return NULL;
+
+	return ((struct disk_exception *) ps->area) + index;
+}
+
+static int read_exception(struct pstore *ps,
+			  uint32_t index, struct disk_exception *result)
+{
+	struct disk_exception *e;
+
+	e = get_exception(ps, index);
+	if (!e)
+		return -EINVAL;
+
+	/* copy it */
+	result->old_chunk = le64_to_cpu(e->old_chunk);
+	result->new_chunk = le64_to_cpu(e->new_chunk);
+
+	return 0;
+}
+
+static int write_exception(struct pstore *ps,
+			   uint32_t index, struct disk_exception *de)
+{
+	struct disk_exception *e;
+
+	e = get_exception(ps, index);
+	if (!e)
+		return -EINVAL;
+
+	/* copy it */
+	e->old_chunk = cpu_to_le64(de->old_chunk);
+	e->new_chunk = cpu_to_le64(de->new_chunk);
+
+	return 0;
+}
+
+/*
+ * Registers the exceptions that are present in the current area.
+ * 'full' is filled in to indicate if the area has been
+ * filled.
+ */
+static int insert_exceptions(struct pstore *ps, int *full)
+{
+	int r;
+	unsigned int i;
+	struct disk_exception de;
+
+	/* presume the area is full */
+	*full = 1;
+
+	for (i = 0; i < ps->exceptions_per_area; i++) {
+		r = read_exception(ps, i, &de);
+
+		if (r)
+			return r;
+
+		/*
+		 * If the new_chunk is pointing at the start of
+		 * the COW device, where the first metadata area
+		 * is we know that we've hit the end of the
+		 * exceptions.  Therefore the area is not full.
+		 */
+		if (de.new_chunk == 0LL) {
+			ps->current_committed = i;
+			*full = 0;
+			break;
+		}
+
+		/*
+		 * Keep track of the start of the free chunks.
+		 */
+		if (ps->next_free <= de.new_chunk)
+			ps->next_free = de.new_chunk + 1;
+
+		/*
+		 * Otherwise we add the exception to the snapshot.
+		 */
+		r = dm_add_exception(ps->snap, de.old_chunk, de.new_chunk);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int read_exceptions(struct pstore *ps)
+{
+	uint32_t area;
+	int r, full = 1;
+
+	/*
+	 * Keeping reading chunks and inserting exceptions until
+	 * we find a partially full area.
+	 */
+	for (area = 0; full; area++) {
+		r = area_io(ps, area, READ);
+		if (r)
+			return r;
+
+		r = insert_exceptions(ps, &full);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static inline struct pstore *get_info(struct exception_store *store)
+{
+	return (struct pstore *) store->context;
+}
+
+static void persistent_fraction_full(struct exception_store *store,
+				     sector_t *numerator, sector_t *denominator)
+{
+	*numerator = get_info(store)->next_free * store->snap->chunk_size;
+	*denominator = get_dev_size(store->snap->cow->bdev);
+}
+
+static void persistent_destroy(struct exception_store *store)
+{
+	struct pstore *ps = get_info(store);
+
+	dm_io_put(sectors_to_pages(ps->chunk_size));
+	vfree(ps->callbacks);
+	free_area(ps);
+	kfree(ps);
+}
+
+static int persistent_read_metadata(struct exception_store *store)
+{
+	int r, new_snapshot;
+	struct pstore *ps = get_info(store);
+
+	/*
+	 * Read the snapshot header.
+	 */
+	r = read_header(ps, &new_snapshot);
+	if (r)
+		return r;
+
+	/*
+	 * Do we need to setup a new snapshot ?
+	 */
+	if (new_snapshot) {
+		r = write_header(ps);
+		if (r) {
+			DMWARN("write_header failed");
+			return r;
+		}
+
+		r = zero_area(ps, 0);
+		if (r) {
+			DMWARN("zero_area(0) failed");
+			return r;
+		}
+
+	} else {
+		/*
+		 * Sanity checks.
+		 */
+		if (!ps->valid) {
+			DMWARN("snapshot is marked invalid");
+			return -EINVAL;
+		}
+
+		if (ps->version != SNAPSHOT_DISK_VERSION) {
+			DMWARN("unable to handle snapshot disk version %d",
+			       ps->version);
+			return -EINVAL;
+		}
+
+		/*
+		 * Read the metadata.
+		 */
+		r = read_exceptions(ps);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int persistent_prepare(struct exception_store *store,
+			      struct exception *e)
+{
+	struct pstore *ps = get_info(store);
+	uint32_t stride;
+	sector_t size = get_dev_size(store->snap->cow->bdev);
+
+	/* Is there enough room ? */
+	if (size < ((ps->next_free + 1) * store->snap->chunk_size))
+		return -ENOSPC;
+
+	e->new_chunk = ps->next_free;
+
+	/*
+	 * Move onto the next free pending, making sure to take
+	 * into account the location of the metadata chunks.
+	 */
+	stride = (ps->exceptions_per_area + 1);
+	if ((++ps->next_free % stride) == 1)
+		ps->next_free++;
+
+	atomic_inc(&ps->pending_count);
+	return 0;
+}
+
+static void persistent_commit(struct exception_store *store,
+			      struct exception *e,
+			      void (*callback) (void *, int success),
+			      void *callback_context)
+{
+	int r;
+	unsigned int i;
+	struct pstore *ps = get_info(store);
+	struct disk_exception de;
+	struct commit_callback *cb;
+
+	de.old_chunk = e->old_chunk;
+	de.new_chunk = e->new_chunk;
+	write_exception(ps, ps->current_committed++, &de);
+
+	/*
+	 * Add the callback to the back of the array.  This code
+	 * is the only place where the callback array is
+	 * manipulated, and we know that it will never be called
+	 * multiple times concurrently.
+	 */
+	cb = ps->callbacks + ps->callback_count++;
+	cb->callback = callback;
+	cb->context = callback_context;
+
+	/*
+	 * If there are no more exceptions in flight, or we have
+	 * filled this metadata area we commit the exceptions to
+	 * disk.
+	 */
+	if (atomic_dec_and_test(&ps->pending_count) ||
+	    (ps->current_committed == ps->exceptions_per_area)) {
+		r = area_io(ps, ps->current_area, WRITE);
+		if (r)
+			ps->valid = 0;
+
+		for (i = 0; i < ps->callback_count; i++) {
+			cb = ps->callbacks + i;
+			cb->callback(cb->context, r == 0 ? 1 : 0);
+		}
+
+		ps->callback_count = 0;
+	}
+
+	/*
+	 * Have we completely filled the current area ?
+	 */
+	if (ps->current_committed == ps->exceptions_per_area) {
+		ps->current_committed = 0;
+		r = zero_area(ps, ps->current_area + 1);
+		if (r)
+			ps->valid = 0;
+	}
+}
+
+static void persistent_drop(struct exception_store *store)
+{
+	struct pstore *ps = get_info(store);
+
+	ps->valid = 0;
+	if (write_header(ps))
+		DMWARN("write header failed");
+}
+
+int dm_create_persistent(struct exception_store *store, uint32_t chunk_size)
+{
+	int r;
+	struct pstore *ps;
+
+	r = dm_io_get(sectors_to_pages(chunk_size));
+	if (r)
+		return r;
+
+	/* allocate the pstore */
+	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
+	if (!ps) {
+		r = -ENOMEM;
+		goto bad;
+	}
+
+	ps->snap = store->snap;
+	ps->valid = 1;
+	ps->version = SNAPSHOT_DISK_VERSION;
+	ps->chunk_size = chunk_size;
+	ps->exceptions_per_area = (chunk_size << SECTOR_SHIFT) /
+	    sizeof(struct disk_exception);
+	ps->next_free = 2;	/* skipping the header and first area */
+	ps->current_committed = 0;
+
+	r = alloc_area(ps);
+	if (r)
+		goto bad;
+
+	/*
+	 * Allocate space for all the callbacks.
+	 */
+	ps->callback_count = 0;
+	atomic_set(&ps->pending_count, 0);
+	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
+				   sizeof(*ps->callbacks));
+
+	if (!ps->callbacks) {
+		r = -ENOMEM;
+		goto bad;
+	}
+
+	store->destroy = persistent_destroy;
+	store->read_metadata = persistent_read_metadata;
+	store->prepare_exception = persistent_prepare;
+	store->commit_exception = persistent_commit;
+	store->drop_snapshot = persistent_drop;
+	store->fraction_full = persistent_fraction_full;
+	store->context = ps;
+
+	return 0;
+
+      bad:
+	dm_io_put(sectors_to_pages(chunk_size));
+	if (ps) {
+		if (ps->callbacks)
+			vfree(ps->callbacks);
+
+		kfree(ps);
+	}
+	return r;
+}
+
+/*-----------------------------------------------------------------
+ * Implementation of the store for non-persistent snapshots.
+ *---------------------------------------------------------------*/
+struct transient_c {
+	sector_t next_free;
+};
+
+static void transient_destroy(struct exception_store *store)
+{
+	kfree(store->context);
+}
+
+static int transient_read_metadata(struct exception_store *store)
+{
+	return 0;
+}
+
+static int transient_prepare(struct exception_store *store, struct exception *e)
+{
+	struct transient_c *tc = (struct transient_c *) store->context;
+	sector_t size = get_dev_size(store->snap->cow->bdev);
+
+	if (size < (tc->next_free + store->snap->chunk_size))
+		return -1;
+
+	e->new_chunk = sector_to_chunk(store->snap, tc->next_free);
+	tc->next_free += store->snap->chunk_size;
+
+	return 0;
+}
+
+static void transient_commit(struct exception_store *store,
+		      struct exception *e,
+		      void (*callback) (void *, int success),
+		      void *callback_context)
+{
+	/* Just succeed */
+	callback(callback_context, 1);
+}
+
+static void transient_fraction_full(struct exception_store *store,
+				    sector_t *numerator, sector_t *denominator)
+{
+	*numerator = ((struct transient_c *) store->context)->next_free;
+	*denominator = get_dev_size(store->snap->cow->bdev);
+}
+
+int dm_create_transient(struct exception_store *store,
+			struct dm_snapshot *s, int blocksize)
+{
+	struct transient_c *tc;
+
+	memset(store, 0, sizeof(*store));
+	store->destroy = transient_destroy;
+	store->read_metadata = transient_read_metadata;
+	store->prepare_exception = transient_prepare;
+	store->commit_exception = transient_commit;
+	store->fraction_full = transient_fraction_full;
+	store->snap = s;
+
+	tc = kmalloc(sizeof(struct transient_c), GFP_KERNEL);
+	if (!tc)
+		return -ENOMEM;
+
+	tc->next_free = 0;
+	store->context = tc;
+
+	return 0;
+}
--- diff/drivers/md/dm-snap.c	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-snap.c	2004-06-01 19:53:19.000000000 -0500
@@ -0,0 +1,1213 @@
+/*
+ * dm-snapshot.c
+ *
+ * Copyright (C) 2001-2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/config.h>
+#include <linux/ctype.h>
+#include <linux/device-mapper.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kdev_t.h>
+#include <linux/list.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "dm-snap.h"
+#include "dm-bio-list.h"
+#include "kcopyd.h"
+
+/*
+ * The percentage increment we will wake up users at
+ */
+#define WAKE_UP_PERCENT 5
+
+/*
+ * kcopyd priority of snapshot operations
+ */
+#define SNAPSHOT_COPY_PRIORITY 2
+
+/*
+ * Each snapshot reserves this many pages for io
+ */
+#define SNAPSHOT_PAGES 256
+
+struct pending_exception {
+	struct exception e;
+
+	/*
+	 * Origin buffers waiting for this to complete are held
+	 * in a bio list
+	 */
+	struct bio_list origin_bios;
+	struct bio_list snapshot_bios;
+
+	/*
+	 * Other pending_exceptions that are processing this
+	 * chunk.  When this list is empty, we know we can
+	 * complete the origins.
+	 */
+	struct list_head siblings;
+
+	/* Pointer back to snapshot context */
+	struct dm_snapshot *snap;
+
+	/*
+	 * 1 indicates the exception has already been sent to
+	 * kcopyd.
+	 */
+	int started;
+};
+
+/*
+ * Hash table mapping origin volumes to lists of snapshots and
+ * a lock to protect it
+ */
+static kmem_cache_t *exception_cache;
+static kmem_cache_t *pending_cache;
+static mempool_t *pending_pool;
+
+/*
+ * One of these per registered origin, held in the snapshot_origins hash
+ */
+struct origin {
+	/* The origin device */
+	struct block_device *bdev;
+
+	struct list_head hash_list;
+
+	/* List of snapshots for this origin */
+	struct list_head snapshots;
+};
+
+/*
+ * Size of the hash table for origin volumes. If we make this
+ * the size of the minors list then it should be nearly perfect
+ */
+#define ORIGIN_HASH_SIZE 256
+#define ORIGIN_MASK      0xFF
+static struct list_head *_origins;
+static struct rw_semaphore _origins_lock;
+
+static int init_origin_hash(void)
+{
+	int i;
+
+	_origins = kmalloc(ORIGIN_HASH_SIZE * sizeof(struct list_head),
+			   GFP_KERNEL);
+	if (!_origins) {
+		DMERR("Device mapper: Snapshot: unable to allocate memory");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ORIGIN_HASH_SIZE; i++)
+		INIT_LIST_HEAD(_origins + i);
+	init_rwsem(&_origins_lock);
+
+	return 0;
+}
+
+static void exit_origin_hash(void)
+{
+	kfree(_origins);
+}
+
+static inline unsigned int origin_hash(struct block_device *bdev)
+{
+	return bdev->bd_dev & ORIGIN_MASK;
+}
+
+static struct origin *__lookup_origin(struct block_device *origin)
+{
+	struct list_head *ol;
+	struct origin *o;
+
+	ol = &_origins[origin_hash(origin)];
+	list_for_each_entry (o, ol, hash_list)
+		if (bdev_equal(o->bdev, origin))
+			return o;
+
+	return NULL;
+}
+
+static void __insert_origin(struct origin *o)
+{
+	struct list_head *sl = &_origins[origin_hash(o->bdev)];
+	list_add_tail(&o->hash_list, sl);
+}
+
+/*
+ * Make a note of the snapshot and its origin so we can look it
+ * up when the origin has a write on it.
+ */
+static int register_snapshot(struct dm_snapshot *snap)
+{
+	struct origin *o;
+	struct block_device *bdev = snap->origin->bdev;
+
+	down_write(&_origins_lock);
+	o = __lookup_origin(bdev);
+
+	if (!o) {
+		/* New origin */
+		o = kmalloc(sizeof(*o), GFP_KERNEL);
+		if (!o) {
+			up_write(&_origins_lock);
+			return -ENOMEM;
+		}
+
+		/* Initialise the struct */
+		INIT_LIST_HEAD(&o->snapshots);
+		o->bdev = bdev;
+
+		__insert_origin(o);
+	}
+
+	list_add_tail(&snap->list, &o->snapshots);
+
+	up_write(&_origins_lock);
+	return 0;
+}
+
+static void unregister_snapshot(struct dm_snapshot *s)
+{
+	struct origin *o;
+
+	down_write(&_origins_lock);
+	o = __lookup_origin(s->origin->bdev);
+
+	list_del(&s->list);
+	if (list_empty(&o->snapshots)) {
+		list_del(&o->hash_list);
+		kfree(o);
+	}
+
+	up_write(&_origins_lock);
+}
+
+/*
+ * Implementation of the exception hash tables.
+ */
+static int init_exception_table(struct exception_table *et, uint32_t size)
+{
+	unsigned int i;
+
+	et->hash_mask = size - 1;
+	et->table = dm_vcalloc(size, sizeof(struct list_head));
+	if (!et->table)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++)
+		INIT_LIST_HEAD(et->table + i);
+
+	return 0;
+}
+
+static void exit_exception_table(struct exception_table *et, kmem_cache_t *mem)
+{
+	struct list_head *slot;
+	struct exception *ex, *next;
+	int i, size;
+
+	size = et->hash_mask + 1;
+	for (i = 0; i < size; i++) {
+		slot = et->table + i;
+
+		list_for_each_entry_safe (ex, next, slot, hash_list)
+			kmem_cache_free(mem, ex);
+	}
+
+	vfree(et->table);
+}
+
+static inline uint32_t exception_hash(struct exception_table *et, chunk_t chunk)
+{
+	return chunk & et->hash_mask;
+}
+
+static void insert_exception(struct exception_table *eh, struct exception *e)
+{
+	struct list_head *l = &eh->table[exception_hash(eh, e->old_chunk)];
+	list_add(&e->hash_list, l);
+}
+
+static inline void remove_exception(struct exception *e)
+{
+	list_del(&e->hash_list);
+}
+
+/*
+ * Return the exception data for a sector, or NULL if not
+ * remapped.
+ */
+static struct exception *lookup_exception(struct exception_table *et,
+					  chunk_t chunk)
+{
+	struct list_head *slot;
+	struct exception *e;
+
+	slot = &et->table[exception_hash(et, chunk)];
+	list_for_each_entry (e, slot, hash_list)
+		if (e->old_chunk == chunk)
+			return e;
+
+	return NULL;
+}
+
+static inline struct exception *alloc_exception(void)
+{
+	struct exception *e;
+
+	e = kmem_cache_alloc(exception_cache, GFP_NOIO);
+	if (!e)
+		e = kmem_cache_alloc(exception_cache, GFP_ATOMIC);
+
+	return e;
+}
+
+static inline void free_exception(struct exception *e)
+{
+	kmem_cache_free(exception_cache, e);
+}
+
+static inline struct pending_exception *alloc_pending_exception(void)
+{
+	return mempool_alloc(pending_pool, GFP_NOIO);
+}
+
+static inline void free_pending_exception(struct pending_exception *pe)
+{
+	mempool_free(pe, pending_pool);
+}
+
+int dm_add_exception(struct dm_snapshot *s, chunk_t old, chunk_t new)
+{
+	struct exception *e;
+
+	e = alloc_exception();
+	if (!e)
+		return -ENOMEM;
+
+	e->old_chunk = old;
+	e->new_chunk = new;
+	insert_exception(&s->complete, e);
+	return 0;
+}
+
+/*
+ * Hard coded magic.
+ */
+static int calc_max_buckets(void)
+{
+	/* use a fixed size of 2MB */
+	unsigned long mem = 2 * 1024 * 1024;
+	mem /= sizeof(struct list_head);
+
+	return mem;
+}
+
+/*
+ * Rounds a number down to a power of 2.
+ */
+static inline uint32_t round_down(uint32_t n)
+{
+	while (n & (n - 1))
+		n &= (n - 1);
+	return n;
+}
+
+/*
+ * Allocate room for a suitable hash table.
+ */
+static int init_hash_tables(struct dm_snapshot *s)
+{
+	sector_t hash_size, cow_dev_size, origin_dev_size, max_buckets;
+
+	/*
+	 * Calculate based on the size of the original volume or
+	 * the COW volume...
+	 */
+	cow_dev_size = get_dev_size(s->cow->bdev);
+	origin_dev_size = get_dev_size(s->origin->bdev);
+	max_buckets = calc_max_buckets();
+
+	hash_size = min(origin_dev_size, cow_dev_size) >> s->chunk_shift;
+	hash_size = min(hash_size, max_buckets);
+
+	/* Round it down to a power of 2 */
+	hash_size = round_down(hash_size);
+	if (init_exception_table(&s->complete, hash_size))
+		return -ENOMEM;
+
+	/*
+	 * Allocate hash table for in-flight exceptions
+	 * Make this smaller than the real hash table
+	 */
+	hash_size >>= 3;
+	if (hash_size < 64)
+		hash_size = 64;
+
+	if (init_exception_table(&s->pending, hash_size)) {
+		exit_exception_table(&s->complete, exception_cache);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Round a number up to the nearest 'size' boundary.  size must
+ * be a power of 2.
+ */
+static inline ulong round_up(ulong n, ulong size)
+{
+	size--;
+	return (n + size) & ~size;
+}
+
+/*
+ * Construct a snapshot mapping: <origin_dev> <COW-dev> <p/n> <chunk-size>
+ */
+static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct dm_snapshot *s;
+	unsigned long chunk_size;
+	int r = -EINVAL;
+	char persistent;
+	char *origin_path;
+	char *cow_path;
+	char *value;
+	int blocksize;
+
+	if (argc < 4) {
+		ti->error = "dm-snapshot: requires exactly 4 arguments";
+		r = -EINVAL;
+		goto bad1;
+	}
+
+	origin_path = argv[0];
+	cow_path = argv[1];
+	persistent = toupper(*argv[2]);
+
+	if (persistent != 'P' && persistent != 'N') {
+		ti->error = "Persistent flag is not P or N";
+		r = -EINVAL;
+		goto bad1;
+	}
+
+	chunk_size = simple_strtoul(argv[3], &value, 10);
+	if (chunk_size == 0 || value == NULL) {
+		ti->error = "Invalid chunk size";
+		r = -EINVAL;
+		goto bad1;
+	}
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (s == NULL) {
+		ti->error = "Cannot allocate snapshot context private "
+		    "structure";
+		r = -ENOMEM;
+		goto bad1;
+	}
+
+	r = dm_get_device(ti, origin_path, 0, ti->len, FMODE_READ, &s->origin);
+	if (r) {
+		ti->error = "Cannot get origin device";
+		goto bad2;
+	}
+
+	r = dm_get_device(ti, cow_path, 0, 0,
+			  FMODE_READ | FMODE_WRITE, &s->cow);
+	if (r) {
+		dm_put_device(ti, s->origin);
+		ti->error = "Cannot get COW device";
+		goto bad2;
+	}
+
+	/*
+	 * Chunk size must be multiple of page size.  Silently
+	 * round up if it's not.
+	 */
+	chunk_size = round_up(chunk_size, PAGE_SIZE >> 9);
+
+	/* Validate the chunk size against the device block size */
+	blocksize = s->cow->bdev->bd_disk->queue->hardsect_size;
+	if (chunk_size % (blocksize >> 9)) {
+		ti->error = "Chunk size is not a multiple of device blocksize";
+		r = -EINVAL;
+		goto bad3;
+	}
+
+	/* Check chunk_size is a power of 2 */
+	if (chunk_size & (chunk_size - 1)) {
+		ti->error = "Chunk size is not a power of 2";
+		r = -EINVAL;
+		goto bad3;
+	}
+
+	s->chunk_size = chunk_size;
+	s->chunk_mask = chunk_size - 1;
+	s->type = persistent;
+	s->chunk_shift = ffs(chunk_size) - 1;
+
+	s->valid = 1;
+	s->have_metadata = 0;
+	s->last_percent = 0;
+	init_rwsem(&s->lock);
+	s->table = ti->table;
+
+	/* Allocate hash table for COW data */
+	if (init_hash_tables(s)) {
+		ti->error = "Unable to allocate hash table space";
+		r = -ENOMEM;
+		goto bad3;
+	}
+
+	/*
+	 * Check the persistent flag - done here because we need the iobuf
+	 * to check the LV header
+	 */
+	s->store.snap = s;
+
+	if (persistent == 'P')
+		r = dm_create_persistent(&s->store, chunk_size);
+	else
+		r = dm_create_transient(&s->store, s, blocksize);
+
+	if (r) {
+		ti->error = "Couldn't create exception store";
+		r = -EINVAL;
+		goto bad4;
+	}
+
+	r = kcopyd_client_create(SNAPSHOT_PAGES, &s->kcopyd_client);
+	if (r) {
+		ti->error = "Could not create kcopyd client";
+		goto bad5;
+	}
+
+	/* Add snapshot to the list of snapshots for this origin */
+	if (register_snapshot(s)) {
+		r = -EINVAL;
+		ti->error = "Cannot register snapshot origin";
+		goto bad6;
+	}
+
+	ti->private = s;
+	ti->split_io = chunk_size;
+
+	return 0;
+
+ bad6:
+	kcopyd_client_destroy(s->kcopyd_client);
+
+ bad5:
+	s->store.destroy(&s->store);
+
+ bad4:
+	exit_exception_table(&s->pending, pending_cache);
+	exit_exception_table(&s->complete, exception_cache);
+
+ bad3:
+	dm_put_device(ti, s->cow);
+	dm_put_device(ti, s->origin);
+
+ bad2:
+	kfree(s);
+
+ bad1:
+	return r;
+}
+
+static void snapshot_dtr(struct dm_target *ti)
+{
+	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
+
+	unregister_snapshot(s);
+
+	exit_exception_table(&s->pending, pending_cache);
+	exit_exception_table(&s->complete, exception_cache);
+
+	/* Deallocate memory used */
+	s->store.destroy(&s->store);
+
+	dm_put_device(ti, s->origin);
+	dm_put_device(ti, s->cow);
+	kcopyd_client_destroy(s->kcopyd_client);
+	kfree(s);
+}
+
+/*
+ * Flush a list of buffers.
+ */
+static void flush_bios(struct bio *bio)
+{
+	struct bio *n;
+
+	while (bio) {
+		n = bio->bi_next;
+		bio->bi_next = NULL;
+		generic_make_request(bio);
+		bio = n;
+	}
+}
+
+/*
+ * Error a list of buffers.
+ */
+static void error_bios(struct bio *bio)
+{
+	struct bio *n;
+
+	while (bio) {
+		n = bio->bi_next;
+		bio->bi_next = NULL;
+		bio_io_error(bio, bio->bi_size);
+		bio = n;
+	}
+}
+
+static struct bio *__flush_bios(struct pending_exception *pe)
+{
+	struct pending_exception *sibling;
+
+	if (list_empty(&pe->siblings))
+		return bio_list_get(&pe->origin_bios);
+
+	sibling = list_entry(pe->siblings.next,
+			     struct pending_exception, siblings);
+
+	list_del(&pe->siblings);
+
+	/* This is fine as long as kcopyd is single-threaded. If kcopyd
+	 * becomes multi-threaded, we'll need some locking here.
+	 */
+	bio_list_merge(&sibling->origin_bios, &pe->origin_bios);
+
+	return NULL;
+}
+
+static void pending_complete(struct pending_exception *pe, int success)
+{
+	struct exception *e;
+	struct dm_snapshot *s = pe->snap;
+	struct bio *flush = NULL;
+
+	if (success) {
+		e = alloc_exception();
+		if (!e) {
+			DMWARN("Unable to allocate exception.");
+			down_write(&s->lock);
+			s->store.drop_snapshot(&s->store);
+			s->valid = 0;
+			flush = __flush_bios(pe);
+			up_write(&s->lock);
+
+			error_bios(bio_list_get(&pe->snapshot_bios));
+			goto out;
+		}
+		memcpy(e, &pe->e, sizeof(*e));
+
+		/*
+		 * Add a proper exception, and remove the
+		 * in-flight exception from the list.
+		 */
+		down_write(&s->lock);
+		insert_exception(&s->complete, e);
+		remove_exception(&pe->e);
+		flush = __flush_bios(pe);
+
+		/* Submit any pending write bios */
+		up_write(&s->lock);
+
+		flush_bios(bio_list_get(&pe->snapshot_bios));
+	} else {
+		/* Read/write error - snapshot is unusable */
+		down_write(&s->lock);
+		if (s->valid)
+			DMERR("Error reading/writing snapshot");
+		s->store.drop_snapshot(&s->store);
+		s->valid = 0;
+		remove_exception(&pe->e);
+		flush = __flush_bios(pe);
+		up_write(&s->lock);
+
+		error_bios(bio_list_get(&pe->snapshot_bios));
+
+		dm_table_event(s->table);
+	}
+
+ out:
+	free_pending_exception(pe);
+
+	if (flush)
+		flush_bios(flush);
+}
+
+static void commit_callback(void *context, int success)
+{
+	struct pending_exception *pe = (struct pending_exception *) context;
+	pending_complete(pe, success);
+}
+
+/*
+ * Called when the copy I/O has finished.  kcopyd actually runs
+ * this code so don't block.
+ */
+static void copy_callback(int read_err, unsigned int write_err, void *context)
+{
+	struct pending_exception *pe = (struct pending_exception *) context;
+	struct dm_snapshot *s = pe->snap;
+
+	if (read_err || write_err)
+		pending_complete(pe, 0);
+
+	else
+		/* Update the metadata if we are persistent */
+		s->store.commit_exception(&s->store, &pe->e, commit_callback,
+					  pe);
+}
+
+/*
+ * Dispatches the copy operation to kcopyd.
+ */
+static inline void start_copy(struct pending_exception *pe)
+{
+	struct dm_snapshot *s = pe->snap;
+	struct io_region src, dest;
+	struct block_device *bdev = s->origin->bdev;
+	sector_t dev_size;
+
+	dev_size = get_dev_size(bdev);
+
+	src.bdev = bdev;
+	src.sector = chunk_to_sector(s, pe->e.old_chunk);
+	src.count = min(s->chunk_size, dev_size - src.sector);
+
+	dest.bdev = s->cow->bdev;
+	dest.sector = chunk_to_sector(s, pe->e.new_chunk);
+	dest.count = src.count;
+
+	/* Hand over to kcopyd */
+	kcopyd_copy(s->kcopyd_client,
+		    &src, 1, &dest, 0, copy_callback, pe);
+}
+
+/*
+ * Looks to see if this snapshot already has a pending exception
+ * for this chunk, otherwise it allocates a new one and inserts
+ * it into the pending table.
+ *
+ * NOTE: a write lock must be held on snap->lock before calling
+ * this.
+ */
+static struct pending_exception *
+__find_pending_exception(struct dm_snapshot *s, struct bio *bio)
+{
+	struct exception *e;
+	struct pending_exception *pe;
+	chunk_t chunk = sector_to_chunk(s, bio->bi_sector);
+
+	/*
+	 * Is there a pending exception for this already ?
+	 */
+	e = lookup_exception(&s->pending, chunk);
+	if (e) {
+		/* cast the exception to a pending exception */
+		pe = container_of(e, struct pending_exception, e);
+
+	} else {
+		/*
+		 * Create a new pending exception, we don't want
+		 * to hold the lock while we do this.
+		 */
+		up_write(&s->lock);
+		pe = alloc_pending_exception();
+		down_write(&s->lock);
+
+		e = lookup_exception(&s->pending, chunk);
+		if (e) {
+			free_pending_exception(pe);
+			pe = container_of(e, struct pending_exception, e);
+		} else {
+			pe->e.old_chunk = chunk;
+			bio_list_init(&pe->origin_bios);
+			bio_list_init(&pe->snapshot_bios);
+			INIT_LIST_HEAD(&pe->siblings);
+			pe->snap = s;
+			pe->started = 0;
+
+			if (s->store.prepare_exception(&s->store, &pe->e)) {
+				free_pending_exception(pe);
+				s->valid = 0;
+				return NULL;
+			}
+
+			insert_exception(&s->pending, &pe->e);
+		}
+	}
+
+	return pe;
+}
+
+static inline void remap_exception(struct dm_snapshot *s, struct exception *e,
+				   struct bio *bio)
+{
+	bio->bi_bdev = s->cow->bdev;
+	bio->bi_sector = chunk_to_sector(s, e->new_chunk) +
+		(bio->bi_sector & s->chunk_mask);
+}
+
+static int snapshot_map(struct dm_target *ti, struct bio *bio,
+			union map_info *map_context)
+{
+	struct exception *e;
+	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
+	int r = 1;
+	chunk_t chunk;
+	struct pending_exception *pe;
+
+	chunk = sector_to_chunk(s, bio->bi_sector);
+
+	/* Full snapshots are not usable */
+	if (!s->valid)
+		return -1;
+
+	/*
+	 * Write to snapshot - higher level takes care of RW/RO
+	 * flags so we should only get this if we are
+	 * writeable.
+	 */
+	if (bio_rw(bio) == WRITE) {
+
+		/* FIXME: should only take write lock if we need
+		 * to copy an exception */
+		down_write(&s->lock);
+
+		/* If the block is already remapped - use that, else remap it */
+		e = lookup_exception(&s->complete, chunk);
+		if (e) {
+			remap_exception(s, e, bio);
+			up_write(&s->lock);
+
+		} else {
+			pe = __find_pending_exception(s, bio);
+
+			if (!pe) {
+				if (s->store.drop_snapshot)
+					s->store.drop_snapshot(&s->store);
+				s->valid = 0;
+				r = -EIO;
+				up_write(&s->lock);
+			} else {
+				remap_exception(s, &pe->e, bio);
+				bio_list_add(&pe->snapshot_bios, bio);
+
+				if (!pe->started) {
+					/* this is protected by snap->lock */
+					pe->started = 1;
+					up_write(&s->lock);
+					start_copy(pe);
+				} else
+					up_write(&s->lock);
+				r = 0;
+			}
+		}
+
+	} else {
+		/*
+		 * FIXME: this read path scares me because we
+		 * always use the origin when we have a pending
+		 * exception.  However I can't think of a
+		 * situation where this is wrong - ejt.
+		 */
+
+		/* Do reads */
+		down_read(&s->lock);
+
+		/* See if it it has been remapped */
+		e = lookup_exception(&s->complete, chunk);
+		if (e)
+			remap_exception(s, e, bio);
+		else
+			bio->bi_bdev = s->origin->bdev;
+
+		up_read(&s->lock);
+	}
+
+	return r;
+}
+
+static void snapshot_resume(struct dm_target *ti)
+{
+	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
+
+	if (s->have_metadata)
+		return;
+
+	if (s->store.read_metadata(&s->store)) {
+		down_write(&s->lock);
+		s->valid = 0;
+		up_write(&s->lock);
+	}
+
+	s->have_metadata = 1;
+}
+
+static int snapshot_status(struct dm_target *ti, status_type_t type,
+			   char *result, unsigned int maxlen)
+{
+	struct dm_snapshot *snap = (struct dm_snapshot *) ti->private;
+	char cow[32];
+	char org[32];
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		if (!snap->valid)
+			snprintf(result, maxlen, "Invalid");
+		else {
+			if (snap->store.fraction_full) {
+				sector_t numerator, denominator;
+				snap->store.fraction_full(&snap->store,
+							  &numerator,
+							  &denominator);
+				snprintf(result, maxlen,
+					 SECTOR_FORMAT "/" SECTOR_FORMAT,
+					 numerator, denominator);
+			}
+			else
+				snprintf(result, maxlen, "Unknown");
+		}
+		break;
+
+	case STATUSTYPE_TABLE:
+		/*
+		 * kdevname returns a static pointer so we need
+		 * to make private copies if the output is to
+		 * make sense.
+		 */
+		format_dev_t(cow, snap->cow->bdev->bd_dev);
+		format_dev_t(org, snap->origin->bdev->bd_dev);
+		snprintf(result, maxlen, "%s %s %c " SECTOR_FORMAT, org, cow,
+			 snap->type, snap->chunk_size);
+		break;
+	}
+
+	return 0;
+}
+
+/*-----------------------------------------------------------------
+ * Origin methods
+ *---------------------------------------------------------------*/
+static void list_merge(struct list_head *l1, struct list_head *l2)
+{
+	struct list_head *l1_n, *l2_p;
+
+	l1_n = l1->next;
+	l2_p = l2->prev;
+
+	l1->next = l2;
+	l2->prev = l1;
+
+	l2_p->next = l1_n;
+	l1_n->prev = l2_p;
+}
+
+static int __origin_write(struct list_head *snapshots, struct bio *bio)
+{
+	int r = 1, first = 1;
+	struct dm_snapshot *snap;
+	struct exception *e;
+	struct pending_exception *pe, *last = NULL;
+	chunk_t chunk;
+
+	/* Do all the snapshots on this origin */
+	list_for_each_entry (snap, snapshots, list) {
+
+		/* Only deal with valid snapshots */
+		if (!snap->valid)
+			continue;
+
+		down_write(&snap->lock);
+
+		/*
+		 * Remember, different snapshots can have
+		 * different chunk sizes.
+		 */
+		chunk = sector_to_chunk(snap, bio->bi_sector);
+
+		/*
+		 * Check exception table to see if block
+		 * is already remapped in this snapshot
+		 * and trigger an exception if not.
+		 */
+		e = lookup_exception(&snap->complete, chunk);
+		if (!e) {
+			pe = __find_pending_exception(snap, bio);
+			if (!pe) {
+				snap->store.drop_snapshot(&snap->store);
+				snap->valid = 0;
+
+			} else {
+				if (last)
+					list_merge(&pe->siblings,
+						   &last->siblings);
+
+				last = pe;
+				r = 0;
+			}
+		}
+
+		up_write(&snap->lock);
+	}
+
+	/*
+	 * Now that we have a complete pe list we can start the copying.
+	 */
+	if (last) {
+		pe = last;
+		do {
+			down_write(&pe->snap->lock);
+			if (first)
+				bio_list_add(&pe->origin_bios, bio);
+			if (!pe->started) {
+				pe->started = 1;
+				up_write(&pe->snap->lock);
+				start_copy(pe);
+			} else
+				up_write(&pe->snap->lock);
+			first = 0;
+			pe = list_entry(pe->siblings.next,
+					struct pending_exception, siblings);
+
+		} while (pe != last);
+	}
+
+	return r;
+}
+
+/*
+ * Called on a write from the origin driver.
+ */
+static int do_origin(struct dm_dev *origin, struct bio *bio)
+{
+	struct origin *o;
+	int r = 1;
+
+	down_read(&_origins_lock);
+	o = __lookup_origin(origin->bdev);
+	if (o)
+		r = __origin_write(&o->snapshots, bio);
+	up_read(&_origins_lock);
+
+	return r;
+}
+
+/*
+ * Origin: maps a linear range of a device, with hooks for snapshotting.
+ */
+
+/*
+ * Construct an origin mapping: <dev_path>
+ * The context for an origin is merely a 'struct dm_dev *'
+ * pointing to the real device.
+ */
+static int origin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	int r;
+	struct dm_dev *dev;
+
+	if (argc != 1) {
+		ti->error = "dm-origin: incorrect number of arguments";
+		return -EINVAL;
+	}
+
+	r = dm_get_device(ti, argv[0], 0, ti->len,
+			  dm_table_get_mode(ti->table), &dev);
+	if (r) {
+		ti->error = "Cannot get target device";
+		return r;
+	}
+
+	ti->private = dev;
+	return 0;
+}
+
+static void origin_dtr(struct dm_target *ti)
+{
+	struct dm_dev *dev = (struct dm_dev *) ti->private;
+	dm_put_device(ti, dev);
+}
+
+static int origin_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
+{
+	struct dm_dev *dev = (struct dm_dev *) ti->private;
+	bio->bi_bdev = dev->bdev;
+
+	/* Only tell snapshots if this is a write */
+	return (bio_rw(bio) == WRITE) ? do_origin(dev, bio) : 1;
+}
+
+#define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))
+
+/*
+ * Set the target "split_io" field to the minimum of all the snapshots'
+ * chunk sizes.
+ */
+static void origin_resume(struct dm_target *ti)
+{
+	struct dm_dev *dev = (struct dm_dev *) ti->private;
+	struct dm_snapshot *snap;
+	struct origin *o;
+	chunk_t chunk_size = 0;
+
+	down_read(&_origins_lock);
+	o = __lookup_origin(dev->bdev);
+	if (o)
+		list_for_each_entry (snap, &o->snapshots, list)
+			chunk_size = min_not_zero(chunk_size, snap->chunk_size);
+	up_read(&_origins_lock);
+
+	ti->split_io = chunk_size;
+}
+
+static int origin_status(struct dm_target *ti, status_type_t type, char *result,
+			 unsigned int maxlen)
+{
+	struct dm_dev *dev = (struct dm_dev *) ti->private;
+	char buffer[32];
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		format_dev_t(buffer, dev->bdev->bd_dev);
+		snprintf(result, maxlen, "%s", buffer);
+		break;
+	}
+
+	return 0;
+}
+
+static struct target_type origin_target = {
+	.name    = "snapshot-origin",
+	.version = {1, 0, 1},
+	.module  = THIS_MODULE,
+	.ctr     = origin_ctr,
+	.dtr     = origin_dtr,
+	.map     = origin_map,
+	.resume  = origin_resume,
+	.status  = origin_status,
+};
+
+static struct target_type snapshot_target = {
+	.name    = "snapshot",
+	.version = {1, 0, 1},
+	.module  = THIS_MODULE,
+	.ctr     = snapshot_ctr,
+	.dtr     = snapshot_dtr,
+	.map     = snapshot_map,
+	.resume  = snapshot_resume,
+	.status  = snapshot_status,
+};
+
+static int __init dm_snapshot_init(void)
+{
+	int r;
+
+	r = dm_register_target(&snapshot_target);
+	if (r) {
+		DMERR("snapshot target register failed %d", r);
+		return r;
+	}
+
+	r = dm_register_target(&origin_target);
+	if (r < 0) {
+		DMERR("Device mapper: Origin: register failed %d\n", r);
+		goto bad1;
+	}
+
+	r = init_origin_hash();
+	if (r) {
+		DMERR("init_origin_hash failed.");
+		goto bad2;
+	}
+
+	exception_cache = kmem_cache_create("dm-snapshot-ex",
+					    sizeof(struct exception),
+					    __alignof__(struct exception),
+					    0, NULL, NULL);
+	if (!exception_cache) {
+		DMERR("Couldn't create exception cache.");
+		r = -ENOMEM;
+		goto bad3;
+	}
+
+	pending_cache =
+	    kmem_cache_create("dm-snapshot-in",
+			      sizeof(struct pending_exception),
+			      __alignof__(struct pending_exception),
+			      0, NULL, NULL);
+	if (!pending_cache) {
+		DMERR("Couldn't create pending cache.");
+		r = -ENOMEM;
+		goto bad4;
+	}
+
+	pending_pool = mempool_create(128, mempool_alloc_slab,
+				      mempool_free_slab, pending_cache);
+	if (!pending_pool) {
+		DMERR("Couldn't create pending pool.");
+		r = -ENOMEM;
+		goto bad5;
+	}
+
+	return 0;
+
+      bad5:
+	kmem_cache_destroy(pending_cache);
+      bad4:
+	kmem_cache_destroy(exception_cache);
+      bad3:
+	exit_origin_hash();
+      bad2:
+	dm_unregister_target(&origin_target);
+      bad1:
+	dm_unregister_target(&snapshot_target);
+	return r;
+}
+
+static void __exit dm_snapshot_exit(void)
+{
+	int r;
+
+	r = dm_unregister_target(&snapshot_target);
+	if (r)
+		DMERR("snapshot unregister failed %d", r);
+
+	r = dm_unregister_target(&origin_target);
+	if (r)
+		DMERR("origin unregister failed %d", r);
+
+	exit_origin_hash();
+	mempool_destroy(pending_pool);
+	kmem_cache_destroy(pending_cache);
+	kmem_cache_destroy(exception_cache);
+}
+
+/* Module hooks */
+module_init(dm_snapshot_init);
+module_exit(dm_snapshot_exit);
+
+MODULE_DESCRIPTION(DM_NAME " snapshot target");
+MODULE_AUTHOR("Joe Thornber");
+MODULE_LICENSE("GPL");
--- diff/drivers/md/dm-snap.h	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-snap.h	2004-06-01 19:52:09.000000000 -0500
@@ -0,0 +1,161 @@
+/*
+ * dm-snapshot.c
+ *
+ * Copyright (C) 2001-2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef DM_SNAPSHOT_H
+#define DM_SNAPSHOT_H
+
+#include "dm.h"
+#include <linux/blkdev.h>
+
+struct exception_table {
+	uint32_t hash_mask;
+	struct list_head *table;
+};
+
+/*
+ * The snapshot code deals with largish chunks of the disk at a
+ * time. Typically 64k - 256k.
+ */
+/* FIXME: can we get away with limiting these to a uint32_t ? */
+typedef sector_t chunk_t;
+
+/*
+ * An exception is used where an old chunk of data has been
+ * replaced by a new one.
+ */
+struct exception {
+	struct list_head hash_list;
+
+	chunk_t old_chunk;
+	chunk_t new_chunk;
+};
+
+/*
+ * Abstraction to handle the meta/layout of exception stores (the
+ * COW device).
+ */
+struct exception_store {
+
+	/*
+	 * Destroys this object when you've finished with it.
+	 */
+	void (*destroy) (struct exception_store *store);
+
+	/*
+	 * The target shouldn't read the COW device until this is
+	 * called.
+	 */
+	int (*read_metadata) (struct exception_store *store);
+
+	/*
+	 * Find somewhere to store the next exception.
+	 */
+	int (*prepare_exception) (struct exception_store *store,
+				  struct exception *e);
+
+	/*
+	 * Update the metadata with this exception.
+	 */
+	void (*commit_exception) (struct exception_store *store,
+				  struct exception *e,
+				  void (*callback) (void *, int success),
+				  void *callback_context);
+
+	/*
+	 * The snapshot is invalid, note this in the metadata.
+	 */
+	void (*drop_snapshot) (struct exception_store *store);
+
+	/*
+	 * Return how full the snapshot is.
+	 */
+	void (*fraction_full) (struct exception_store *store,
+			       sector_t *numerator,
+			       sector_t *denominator);
+
+	struct dm_snapshot *snap;
+	void *context;
+};
+
+struct dm_snapshot {
+	struct rw_semaphore lock;
+	struct dm_table *table;
+
+	struct dm_dev *origin;
+	struct dm_dev *cow;
+
+	/* List of snapshots per Origin */
+	struct list_head list;
+
+	/* Size of data blocks saved - must be a power of 2 */
+	chunk_t chunk_size;
+	chunk_t chunk_mask;
+	chunk_t chunk_shift;
+
+	/* You can't use a snapshot if this is 0 (e.g. if full) */
+	int valid;
+	int have_metadata;
+
+	/* Used for display of table */
+	char type;
+
+	/* The last percentage we notified */
+	int last_percent;
+
+	struct exception_table pending;
+	struct exception_table complete;
+
+	/* The on disk metadata handler */
+	struct exception_store store;
+
+	struct kcopyd_client *kcopyd_client;
+};
+
+/*
+ * Used by the exception stores to load exceptions hen
+ * initialising.
+ */
+int dm_add_exception(struct dm_snapshot *s, chunk_t old, chunk_t new);
+
+/*
+ * Constructor and destructor for the default persistent
+ * store.
+ */
+int dm_create_persistent(struct exception_store *store, uint32_t chunk_size);
+
+int dm_create_transient(struct exception_store *store,
+			struct dm_snapshot *s, int blocksize);
+
+/*
+ * Return the number of sectors in the device.
+ */
+static inline sector_t get_dev_size(struct block_device *bdev)
+{
+	return bdev->bd_inode->i_size >> SECTOR_SHIFT;
+}
+
+static inline chunk_t sector_to_chunk(struct dm_snapshot *s, sector_t sector)
+{
+	return (sector & ~s->chunk_mask) >> s->chunk_shift;
+}
+
+static inline sector_t chunk_to_sector(struct dm_snapshot *s, chunk_t chunk)
+{
+	return chunk << s->chunk_shift;
+}
+
+static inline int bdev_equal(struct block_device *lhs, struct block_device *rhs)
+{
+	/*
+	 * There is only ever one instance of a particular block
+	 * device so we can compare pointers safely.
+	 */
+	return lhs == rhs;
+}
+
+#endif

