Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUFBP5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUFBP5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUFBP5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:57:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263271AbUFBPo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:44:27 -0400
Date: Wed, 2 Jun 2004 16:44:17 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4/5: Device-mapper: mirroring
Message-ID: <20040602154417.GQ6302@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mirror target

--- diff/drivers/md/Kconfig	2004-06-01 19:52:09.000000000 -0500
+++ source/drivers/md/Kconfig	2004-06-01 19:56:27.000000000 -0500
@@ -186,5 +186,12 @@
        ---help---
          Allow volume managers to take writeable snapshots of a device.
 
+config DM_MIRROR
+       tristate "Mirror target (EXPERIMENTAL)"
+       depends on BLK_DEV_DM && EXPERIMENTAL
+       ---help---
+         Allow volume managers to mirror logical volumes, also
+         needed for live data migration tools such as 'pvmove'.
+
 endmenu
 
--- diff/drivers/md/Makefile	2004-06-01 19:52:09.000000000 -0500
+++ source/drivers/md/Makefile	2004-06-01 19:56:27.000000000 -0500
@@ -5,6 +5,7 @@
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o kcopyd.o
 dm-snapshot-objs := dm-snap.o dm-exception-store.o
+dm-mirror-objs	:= dm-log.o dm-raid1.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
@@ -26,6 +27,7 @@
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
+obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
--- diff/drivers/md/dm-log.c	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-log.c	2004-06-01 19:56:27.000000000 -0500
@@ -0,0 +1,629 @@
+/*
+ * Copyright (C) 2003 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+#include "dm-log.h"
+#include "dm-io.h"
+
+static LIST_HEAD(_log_types);
+static spinlock_t _lock = SPIN_LOCK_UNLOCKED;
+
+int dm_register_dirty_log_type(struct dirty_log_type *type)
+{
+	if (!try_module_get(type->module))
+		return -EINVAL;
+
+	spin_lock(&_lock);
+	type->use_count = 0;
+	list_add(&type->list, &_log_types);
+	spin_unlock(&_lock);
+
+	return 0;
+}
+
+int dm_unregister_dirty_log_type(struct dirty_log_type *type)
+{
+	spin_lock(&_lock);
+
+	if (type->use_count)
+		DMWARN("Attempt to unregister a log type that is still in use");
+	else {
+		list_del(&type->list);
+		module_put(type->module);
+	}
+
+	spin_unlock(&_lock);
+
+	return 0;
+}
+
+static struct dirty_log_type *get_type(const char *type_name)
+{
+	struct dirty_log_type *type;
+
+	spin_lock(&_lock);
+	list_for_each_entry (type, &_log_types, list)
+		if (!strcmp(type_name, type->name)) {
+			type->use_count++;
+			spin_unlock(&_lock);
+			return type;
+		}
+
+	spin_unlock(&_lock);
+	return NULL;
+}
+
+static void put_type(struct dirty_log_type *type)
+{
+	spin_lock(&_lock);
+	type->use_count--;
+	spin_unlock(&_lock);
+}
+
+struct dirty_log *dm_create_dirty_log(const char *type_name, struct dm_target *ti,
+				      unsigned int argc, char **argv)
+{
+	struct dirty_log_type *type;
+	struct dirty_log *log;
+
+	log = kmalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return NULL;
+
+	type = get_type(type_name);
+	if (!type) {
+		kfree(log);
+		return NULL;
+	}
+
+	log->type = type;
+	if (type->ctr(log, ti, argc, argv)) {
+		kfree(log);
+		put_type(type);
+		return NULL;
+	}
+
+	return log;
+}
+
+void dm_destroy_dirty_log(struct dirty_log *log)
+{
+	log->type->dtr(log);
+	put_type(log->type);
+	kfree(log);
+}
+
+/*-----------------------------------------------------------------
+ * Persistent and core logs share a lot of their implementation.
+ * FIXME: need a reload method to be called from a resume
+ *---------------------------------------------------------------*/
+/*
+ * Magic for persistent mirrors: "MiRr"
+ */
+#define MIRROR_MAGIC 0x4D695272
+
+/*
+ * The on-disk version of the metadata.
+ */
+#define MIRROR_DISK_VERSION 1
+#define LOG_OFFSET 2
+
+struct log_header {
+	uint32_t magic;
+
+	/*
+	 * Simple, incrementing version. no backward
+	 * compatibility.
+	 */
+	uint32_t version;
+	sector_t nr_regions;
+};
+
+struct log_c {
+	struct dm_target *ti;
+	int touched;
+	sector_t region_size;
+	unsigned int region_count;
+	region_t sync_count;
+
+	unsigned bitset_uint32_count;
+	uint32_t *clean_bits;
+	uint32_t *sync_bits;
+	uint32_t *recovering_bits;	/* FIXME: this seems excessive */
+
+	int sync_search;
+
+	/*
+	 * Disk log fields
+	 */
+	struct dm_dev *log_dev;
+	struct log_header header;
+
+	struct io_region header_location;
+	struct log_header *disk_header;
+
+	struct io_region bits_location;
+	uint32_t *disk_bits;
+};
+
+/*
+ * The touched member needs to be updated every time we access
+ * one of the bitsets.
+ */
+static  inline int log_test_bit(uint32_t *bs, unsigned bit)
+{
+	return test_bit(bit, (unsigned long *) bs) ? 1 : 0;
+}
+
+static inline void log_set_bit(struct log_c *l,
+			       uint32_t *bs, unsigned bit)
+{
+	set_bit(bit, (unsigned long *) bs);
+	l->touched = 1;
+}
+
+static inline void log_clear_bit(struct log_c *l,
+				 uint32_t *bs, unsigned bit)
+{
+	clear_bit(bit, (unsigned long *) bs);
+	l->touched = 1;
+}
+
+/*----------------------------------------------------------------
+ * Header IO
+ *--------------------------------------------------------------*/
+static void header_to_disk(struct log_header *core, struct log_header *disk)
+{
+	disk->magic = cpu_to_le32(core->magic);
+	disk->version = cpu_to_le32(core->version);
+	disk->nr_regions = cpu_to_le64(core->nr_regions);
+}
+
+static void header_from_disk(struct log_header *core, struct log_header *disk)
+{
+	core->magic = le32_to_cpu(disk->magic);
+	core->version = le32_to_cpu(disk->version);
+	core->nr_regions = le64_to_cpu(disk->nr_regions);
+}
+
+static int read_header(struct log_c *log)
+{
+	int r;
+	unsigned long ebits;
+
+	r = dm_io_sync_vm(1, &log->header_location, READ,
+			  log->disk_header, &ebits);
+	if (r)
+		return r;
+
+	header_from_disk(&log->header, log->disk_header);
+
+	if (log->header.magic != MIRROR_MAGIC) {
+		log->header.magic = MIRROR_MAGIC;
+		log->header.version = MIRROR_DISK_VERSION;
+		log->header.nr_regions = 0;
+	}
+
+	if (log->header.version != MIRROR_DISK_VERSION) {
+		DMWARN("incompatible disk log version");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int write_header(struct log_c *log)
+{
+	unsigned long ebits;
+
+	header_to_disk(&log->header, log->disk_header);
+	return dm_io_sync_vm(1, &log->header_location, WRITE,
+			     log->disk_header, &ebits);
+}
+
+/*----------------------------------------------------------------
+ * Bits IO
+ *--------------------------------------------------------------*/
+static inline void bits_to_core(uint32_t *core, uint32_t *disk, unsigned count)
+{
+	unsigned i;
+
+	for (i = 0; i < count; i++)
+		core[i] = le32_to_cpu(disk[i]);
+}
+
+static inline void bits_to_disk(uint32_t *core, uint32_t *disk, unsigned count)
+{
+	unsigned i;
+
+	/* copy across the clean/dirty bitset */
+	for (i = 0; i < count; i++)
+		disk[i] = cpu_to_le32(core[i]);
+}
+
+static int read_bits(struct log_c *log)
+{
+	int r;
+	unsigned long ebits;
+
+	r = dm_io_sync_vm(1, &log->bits_location, READ,
+			  log->disk_bits, &ebits);
+	if (r)
+		return r;
+
+	bits_to_core(log->clean_bits, log->disk_bits,
+		     log->bitset_uint32_count);
+	return 0;
+}
+
+static int write_bits(struct log_c *log)
+{
+	unsigned long ebits;
+	bits_to_disk(log->clean_bits, log->disk_bits,
+		     log->bitset_uint32_count);
+	return dm_io_sync_vm(1, &log->bits_location, WRITE,
+			     log->disk_bits, &ebits);
+}
+
+/*----------------------------------------------------------------
+ * constructor/destructor
+ *--------------------------------------------------------------*/
+#define BYTE_SHIFT 3
+static int core_ctr(struct dirty_log *log, struct dm_target *ti,
+		    unsigned int argc, char **argv)
+{
+	struct log_c *lc;
+	sector_t region_size;
+	unsigned int region_count;
+	size_t bitset_size;
+
+	if (argc != 1) {
+		DMWARN("wrong number of arguments to log_c");
+		return -EINVAL;
+	}
+
+	if (sscanf(argv[0], SECTOR_FORMAT, &region_size) != 1) {
+		DMWARN("invalid region size string");
+		return -EINVAL;
+	}
+
+	region_count = dm_div_up(ti->len, region_size);
+
+	lc = kmalloc(sizeof(*lc), GFP_KERNEL);
+	if (!lc) {
+		DMWARN("couldn't allocate core log");
+		return -ENOMEM;
+	}
+
+	lc->ti = ti;
+	lc->touched = 0;
+	lc->region_size = region_size;
+	lc->region_count = region_count;
+
+	/*
+	 * Work out how many words we need to hold the bitset.
+	 */
+	bitset_size = dm_round_up(region_count,
+				  sizeof(*lc->clean_bits) << BYTE_SHIFT);
+	bitset_size >>= BYTE_SHIFT;
+
+	lc->bitset_uint32_count = bitset_size / 4;
+	lc->clean_bits = vmalloc(bitset_size);
+	if (!lc->clean_bits) {
+		DMWARN("couldn't allocate clean bitset");
+		kfree(lc);
+		return -ENOMEM;
+	}
+	memset(lc->clean_bits, -1, bitset_size);
+
+	lc->sync_bits = vmalloc(bitset_size);
+	if (!lc->sync_bits) {
+		DMWARN("couldn't allocate sync bitset");
+		vfree(lc->clean_bits);
+		kfree(lc);
+		return -ENOMEM;
+	}
+	memset(lc->sync_bits, 0, bitset_size);
+        lc->sync_count = 0;
+
+	lc->recovering_bits = vmalloc(bitset_size);
+	if (!lc->recovering_bits) {
+		DMWARN("couldn't allocate sync bitset");
+		vfree(lc->sync_bits);
+		vfree(lc->clean_bits);
+		kfree(lc);
+		return -ENOMEM;
+	}
+	memset(lc->recovering_bits, 0, bitset_size);
+	lc->sync_search = 0;
+	log->context = lc;
+	return 0;
+}
+
+static void core_dtr(struct dirty_log *log)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	vfree(lc->clean_bits);
+	vfree(lc->sync_bits);
+	vfree(lc->recovering_bits);
+	kfree(lc);
+}
+
+static int disk_ctr(struct dirty_log *log, struct dm_target *ti,
+		    unsigned int argc, char **argv)
+{
+	int r;
+	size_t size;
+	struct log_c *lc;
+	struct dm_dev *dev;
+
+	if (argc != 2) {
+		DMWARN("wrong number of arguments to log_d");
+		return -EINVAL;
+	}
+
+	r = dm_get_device(ti, argv[0], 0, 0 /* FIXME */,
+			  FMODE_READ | FMODE_WRITE, &dev);
+	if (r)
+		return r;
+
+	r = core_ctr(log, ti, argc - 1, argv + 1);
+	if (r) {
+		dm_put_device(ti, dev);
+		return r;
+	}
+
+	lc = (struct log_c *) log->context;
+	lc->log_dev = dev;
+
+	/* setup the disk header fields */
+	lc->header_location.bdev = lc->log_dev->bdev;
+	lc->header_location.sector = 0;
+	lc->header_location.count = 1;
+
+	/*
+	 * We can't read less than this amount, even though we'll
+	 * not be using most of this space.
+	 */
+	lc->disk_header = vmalloc(1 << SECTOR_SHIFT);
+	if (!lc->disk_header)
+		goto bad;
+
+	/* setup the disk bitset fields */
+	lc->bits_location.bdev = lc->log_dev->bdev;
+	lc->bits_location.sector = LOG_OFFSET;
+
+	size = dm_round_up(lc->bitset_uint32_count * sizeof(uint32_t),
+			   1 << SECTOR_SHIFT);
+	lc->bits_location.count = size >> SECTOR_SHIFT;
+	lc->disk_bits = vmalloc(size);
+	if (!lc->disk_bits) {
+		vfree(lc->disk_header);
+		goto bad;
+	}
+	return 0;
+
+ bad:
+	dm_put_device(ti, lc->log_dev);
+	core_dtr(log);
+	return -ENOMEM;
+}
+
+static void disk_dtr(struct dirty_log *log)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	dm_put_device(lc->ti, lc->log_dev);
+	vfree(lc->disk_header);
+	vfree(lc->disk_bits);
+	core_dtr(log);
+}
+
+static int count_bits32(uint32_t *addr, unsigned size)
+{
+	int count = 0, i;
+
+	for (i = 0; i < size; i++) {
+		count += hweight32(*(addr+i));
+	}
+	return count;
+}
+
+static int disk_resume(struct dirty_log *log)
+{
+	int r;
+	unsigned i;
+	struct log_c *lc = (struct log_c *) log->context;
+	size_t size = lc->bitset_uint32_count * sizeof(uint32_t);
+
+	/* read the disk header */
+	r = read_header(lc);
+	if (r)
+		return r;
+
+	/* read the bits */
+	r = read_bits(lc);
+	if (r)
+		return r;
+
+	/* zero any new bits if the mirror has grown */
+	for (i = lc->header.nr_regions; i < lc->region_count; i++)
+		/* FIXME: amazingly inefficient */
+		log_clear_bit(lc, lc->clean_bits, i);
+
+	/* copy clean across to sync */
+	memcpy(lc->sync_bits, lc->clean_bits, size);
+	lc->sync_count = count_bits32(lc->clean_bits, lc->bitset_uint32_count);
+
+	/* write the bits */
+	r = write_bits(lc);
+	if (r)
+		return r;
+
+	/* set the correct number of regions in the header */
+	lc->header.nr_regions = lc->region_count;
+
+	/* write the new header */
+	return write_header(lc);
+}
+
+static sector_t core_get_region_size(struct dirty_log *log)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	return lc->region_size;
+}
+
+static int core_is_clean(struct dirty_log *log, region_t region)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	return log_test_bit(lc->clean_bits, region);
+}
+
+static int core_in_sync(struct dirty_log *log, region_t region, int block)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	return log_test_bit(lc->sync_bits, region);
+}
+
+static int core_flush(struct dirty_log *log)
+{
+	/* no op */
+	return 0;
+}
+
+static int disk_flush(struct dirty_log *log)
+{
+	int r;
+	struct log_c *lc = (struct log_c *) log->context;
+
+	/* only write if the log has changed */
+	if (!lc->touched)
+		return 0;
+
+	r = write_bits(lc);
+	if (!r)
+		lc->touched = 0;
+
+	return r;
+}
+
+static void core_mark_region(struct dirty_log *log, region_t region)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	log_clear_bit(lc, lc->clean_bits, region);
+}
+
+static void core_clear_region(struct dirty_log *log, region_t region)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+	log_set_bit(lc, lc->clean_bits, region);
+}
+
+static int core_get_resync_work(struct dirty_log *log, region_t *region)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+
+	if (lc->sync_search >= lc->region_count)
+		return 0;
+
+	do {
+		*region = find_next_zero_bit((unsigned long *) lc->sync_bits,
+					     lc->region_count,
+					     lc->sync_search);
+		lc->sync_search = *region + 1;
+
+		if (*region == lc->region_count)
+			return 0;
+
+	} while (log_test_bit(lc->recovering_bits, *region));
+
+	log_set_bit(lc, lc->recovering_bits, *region);
+	return 1;
+}
+
+static void core_complete_resync_work(struct dirty_log *log, region_t region,
+				      int success)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+
+	log_clear_bit(lc, lc->recovering_bits, region);
+	if (success) {
+		log_set_bit(lc, lc->sync_bits, region);
+                lc->sync_count++;
+        }
+}
+
+static region_t core_get_sync_count(struct dirty_log *log)
+{
+        struct log_c *lc = (struct log_c *) log->context;
+
+        return lc->sync_count;
+}
+
+static struct dirty_log_type _core_type = {
+	.name = "core",
+	.module = THIS_MODULE,
+	.ctr = core_ctr,
+	.dtr = core_dtr,
+	.get_region_size = core_get_region_size,
+	.is_clean = core_is_clean,
+	.in_sync = core_in_sync,
+	.flush = core_flush,
+	.mark_region = core_mark_region,
+	.clear_region = core_clear_region,
+	.get_resync_work = core_get_resync_work,
+	.complete_resync_work = core_complete_resync_work,
+        .get_sync_count = core_get_sync_count
+};
+
+static struct dirty_log_type _disk_type = {
+	.name = "disk",
+	.module = THIS_MODULE,
+	.ctr = disk_ctr,
+	.dtr = disk_dtr,
+	.suspend = disk_flush,
+	.resume = disk_resume,
+	.get_region_size = core_get_region_size,
+	.is_clean = core_is_clean,
+	.in_sync = core_in_sync,
+	.flush = disk_flush,
+	.mark_region = core_mark_region,
+	.clear_region = core_clear_region,
+	.get_resync_work = core_get_resync_work,
+	.complete_resync_work = core_complete_resync_work,
+        .get_sync_count = core_get_sync_count
+};
+
+int __init dm_dirty_log_init(void)
+{
+	int r;
+
+	r = dm_register_dirty_log_type(&_core_type);
+	if (r)
+		DMWARN("couldn't register core log");
+
+	r = dm_register_dirty_log_type(&_disk_type);
+	if (r) {
+		DMWARN("couldn't register disk type");
+		dm_unregister_dirty_log_type(&_core_type);
+	}
+
+	return r;
+}
+
+void dm_dirty_log_exit(void)
+{
+	dm_unregister_dirty_log_type(&_disk_type);
+	dm_unregister_dirty_log_type(&_core_type);
+}
+
+EXPORT_SYMBOL(dm_register_dirty_log_type);
+EXPORT_SYMBOL(dm_unregister_dirty_log_type);
+EXPORT_SYMBOL(dm_create_dirty_log);
+EXPORT_SYMBOL(dm_destroy_dirty_log);
--- diff/drivers/md/dm-log.h	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-log.h	2004-06-01 19:56:27.000000000 -0500
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2003 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef DM_DIRTY_LOG
+#define DM_DIRTY_LOG
+
+#include "dm.h"
+
+typedef sector_t region_t;
+
+struct dirty_log_type;
+
+struct dirty_log {
+	struct dirty_log_type *type;
+	void *context;
+};
+
+struct dirty_log_type {
+	struct list_head list;
+	const char *name;
+	struct module *module;
+	unsigned int use_count;
+
+	int (*ctr)(struct dirty_log *log, struct dm_target *ti,
+		   unsigned int argc, char **argv);
+	void (*dtr)(struct dirty_log *log);
+
+	/*
+	 * There are times when we don't want the log to touch
+	 * the disk.
+	 */
+	int (*suspend)(struct dirty_log *log);
+	int (*resume)(struct dirty_log *log);
+
+	/*
+	 * Retrieves the smallest size of region that the log can
+	 * deal with.
+	 */
+	sector_t (*get_region_size)(struct dirty_log *log);
+
+        /*
+	 * A predicate to say whether a region is clean or not.
+	 * May block.
+	 */
+	int (*is_clean)(struct dirty_log *log, region_t region);
+
+	/*
+	 *  Returns: 0, 1, -EWOULDBLOCK, < 0
+	 *
+	 * A predicate function to check the area given by
+	 * [sector, sector + len) is in sync.
+	 *
+	 * If -EWOULDBLOCK is returned the state of the region is
+	 * unknown, typically this will result in a read being
+	 * passed to a daemon to deal with, since a daemon is
+	 * allowed to block.
+	 */
+	int (*in_sync)(struct dirty_log *log, region_t region, int can_block);
+
+	/*
+	 * Flush the current log state (eg, to disk).  This
+	 * function may block.
+	 */
+	int (*flush)(struct dirty_log *log);
+
+	/*
+	 * Mark an area as clean or dirty.  These functions may
+	 * block, though for performance reasons blocking should
+	 * be extremely rare (eg, allocating another chunk of
+	 * memory for some reason).
+	 */
+	void (*mark_region)(struct dirty_log *log, region_t region);
+	void (*clear_region)(struct dirty_log *log, region_t region);
+
+	/*
+	 * Returns: <0 (error), 0 (no region), 1 (region)
+	 *
+	 * The mirrord will need perform recovery on regions of
+	 * the mirror that are in the NOSYNC state.  This
+	 * function asks the log to tell the caller about the
+	 * next region that this machine should recover.
+	 *
+	 * Do not confuse this function with 'in_sync()', one
+	 * tells you if an area is synchronised, the other
+	 * assigns recovery work.
+	*/
+	int (*get_resync_work)(struct dirty_log *log, region_t *region);
+
+	/*
+	 * This notifies the log that the resync of an area has
+	 * been completed.  The log should then mark this region
+	 * as CLEAN.
+	 */
+	void (*complete_resync_work)(struct dirty_log *log,
+				     region_t region, int success);
+
+        /*
+	 * Returns the number of regions that are in sync.
+         */
+        region_t (*get_sync_count)(struct dirty_log *log);
+};
+
+int dm_register_dirty_log_type(struct dirty_log_type *type);
+int dm_unregister_dirty_log_type(struct dirty_log_type *type);
+
+
+/*
+ * Make sure you use these two functions, rather than calling
+ * type->constructor/destructor() directly.
+ */
+struct dirty_log *dm_create_dirty_log(const char *type_name, struct dm_target *ti,
+				      unsigned int argc, char **argv);
+void dm_destroy_dirty_log(struct dirty_log *log);
+
+/*
+ * init/exit functions.
+ */
+int dm_dirty_log_init(void);
+void dm_dirty_log_exit(void);
+
+#endif
--- diff/drivers/md/dm-raid1.c	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-raid1.c	2004-06-01 19:56:27.000000000 -0500
@@ -0,0 +1,1283 @@
+/*
+ * Copyright (C) 2003 Sistina Software Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+#include "dm-bio-list.h"
+#include "dm-io.h"
+#include "dm-log.h"
+#include "kcopyd.h"
+
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+
+static struct workqueue_struct *_kmirrord_wq;
+static struct work_struct _kmirrord_work;
+
+static inline void wake(void)
+{
+	queue_work(_kmirrord_wq, &_kmirrord_work);
+}
+
+/*-----------------------------------------------------------------
+ * Region hash
+ *
+ * The mirror splits itself up into discrete regions.  Each
+ * region can be in one of three states: clean, dirty,
+ * nosync.  There is no need to put clean regions in the hash.
+ *
+ * In addition to being present in the hash table a region _may_
+ * be present on one of three lists.
+ *
+ *   clean_regions: Regions on this list have no io pending to
+ *   them, they are in sync, we are no longer interested in them,
+ *   they are dull.  rh_update_states() will remove them from the
+ *   hash table.
+ *
+ *   quiesced_regions: These regions have been spun down, ready
+ *   for recovery.  rh_recovery_start() will remove regions from
+ *   this list and hand them to kmirrord, which will schedule the
+ *   recovery io with kcopyd.
+ *
+ *   recovered_regions: Regions that kcopyd has successfully
+ *   recovered.  rh_update_states() will now schedule any delayed
+ *   io, up the recovery_count, and remove the region from the
+ *   hash.
+ *
+ * There are 2 locks:
+ *   A rw spin lock 'hash_lock' protects just the hash table,
+ *   this is never held in write mode from interrupt context,
+ *   which I believe means that we only have to disable irqs when
+ *   doing a write lock.
+ *
+ *   An ordinary spin lock 'region_lock' that protects the three
+ *   lists in the region_hash, with the 'state', 'list' and
+ *   'bhs_delayed' fields of the regions.  This is used from irq
+ *   context, so all other uses will have to suspend local irqs.
+ *---------------------------------------------------------------*/
+struct mirror_set;
+struct region_hash {
+	struct mirror_set *ms;
+	sector_t region_size;
+	unsigned region_shift;
+
+	/* holds persistent region state */
+	struct dirty_log *log;
+
+	/* hash table */
+	rwlock_t hash_lock;
+	mempool_t *region_pool;
+	unsigned int mask;
+	unsigned int nr_buckets;
+	struct list_head *buckets;
+
+	spinlock_t region_lock;
+	struct semaphore recovery_count;
+	struct list_head clean_regions;
+	struct list_head quiesced_regions;
+	struct list_head recovered_regions;
+};
+
+enum {
+	RH_CLEAN,
+	RH_DIRTY,
+	RH_NOSYNC,
+	RH_RECOVERING
+};
+
+struct region {
+	struct region_hash *rh;	/* FIXME: can we get rid of this ? */
+	region_t key;
+	int state;
+
+	struct list_head hash_list;
+	struct list_head list;
+
+	atomic_t pending;
+	struct bio *delayed_bios;
+};
+
+/*
+ * Conversion fns
+ */
+static inline region_t bio_to_region(struct region_hash *rh, struct bio *bio)
+{
+	return bio->bi_sector >> rh->region_shift;
+}
+
+static inline sector_t region_to_sector(struct region_hash *rh, region_t region)
+{
+	return region << rh->region_shift;
+}
+
+/* FIXME move this */
+static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw);
+
+static void *region_alloc(int gfp_mask, void *pool_data)
+{
+	return kmalloc(sizeof(struct region), gfp_mask);
+}
+
+static void region_free(void *element, void *pool_data)
+{
+	kfree(element);
+}
+
+#define MIN_REGIONS 64
+#define MAX_RECOVERY 1
+static int rh_init(struct region_hash *rh, struct mirror_set *ms,
+		   struct dirty_log *log, sector_t region_size,
+		   region_t nr_regions)
+{
+	unsigned int nr_buckets, max_buckets;
+	size_t i;
+
+	/*
+	 * Calculate a suitable number of buckets for our hash
+	 * table.
+	 */
+	max_buckets = nr_regions >> 6;
+	for (nr_buckets = 128u; nr_buckets < max_buckets; nr_buckets <<= 1)
+		;
+	nr_buckets >>= 1;
+
+	rh->ms = ms;
+	rh->log = log;
+	rh->region_size = region_size;
+	rh->region_shift = ffs(region_size) - 1;
+	rwlock_init(&rh->hash_lock);
+	rh->mask = nr_buckets - 1;
+	rh->nr_buckets = nr_buckets;
+
+	rh->buckets = vmalloc(nr_buckets * sizeof(*rh->buckets));
+	if (!rh->buckets) {
+		DMERR("unable to allocate region hash memory");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_buckets; i++)
+		INIT_LIST_HEAD(rh->buckets + i);
+
+	spin_lock_init(&rh->region_lock);
+	sema_init(&rh->recovery_count, 0);
+	INIT_LIST_HEAD(&rh->clean_regions);
+	INIT_LIST_HEAD(&rh->quiesced_regions);
+	INIT_LIST_HEAD(&rh->recovered_regions);
+
+	rh->region_pool = mempool_create(MIN_REGIONS, region_alloc,
+					 region_free, NULL);
+	if (!rh->region_pool) {
+		vfree(rh->buckets);
+		rh->buckets = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void rh_exit(struct region_hash *rh)
+{
+	unsigned int h;
+	struct region *reg;
+	struct list_head *tmp, *tmp2;
+
+	BUG_ON(!list_empty(&rh->quiesced_regions));
+	for (h = 0; h < rh->nr_buckets; h++) {
+		list_for_each_safe (tmp, tmp2, rh->buckets + h) {
+			reg = list_entry(tmp, struct region, hash_list);
+			BUG_ON(atomic_read(&reg->pending));
+			mempool_free(reg, rh->region_pool);
+		}
+	}
+
+	if (rh->log)
+		dm_destroy_dirty_log(rh->log);
+	if (rh->region_pool)
+		mempool_destroy(rh->region_pool);
+	vfree(rh->buckets);
+}
+
+#define RH_HASH_MULT 2654435387U
+
+static inline unsigned int rh_hash(struct region_hash *rh, region_t region)
+{
+	return (unsigned int) ((region * RH_HASH_MULT) >> 12) & rh->mask;
+}
+
+static struct region *__rh_lookup(struct region_hash *rh, region_t region)
+{
+	struct region *reg;
+
+	list_for_each_entry (reg, rh->buckets + rh_hash(rh, region), hash_list)
+		if (reg->key == region)
+			return reg;
+
+	return NULL;
+}
+
+static void __rh_insert(struct region_hash *rh, struct region *reg)
+{
+	unsigned int h = rh_hash(rh, reg->key);
+	list_add(&reg->hash_list, rh->buckets + h);
+}
+
+static struct region *__rh_alloc(struct region_hash *rh, region_t region)
+{
+	struct region *reg, *nreg;
+
+	read_unlock(&rh->hash_lock);
+	nreg = mempool_alloc(rh->region_pool, GFP_NOIO);
+	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
+		RH_CLEAN : RH_NOSYNC;
+	nreg->rh = rh;
+	nreg->key = region;
+
+	INIT_LIST_HEAD(&nreg->list);
+
+	atomic_set(&nreg->pending, 0);
+	nreg->delayed_bios = NULL;
+	write_lock_irq(&rh->hash_lock);
+
+	reg = __rh_lookup(rh, region);
+	if (reg)
+		/* we lost the race */
+		mempool_free(nreg, rh->region_pool);
+
+	else {
+		__rh_insert(rh, nreg);
+		if (nreg->state == RH_CLEAN) {
+			spin_lock_irq(&rh->region_lock);
+			list_add(&nreg->list, &rh->clean_regions);
+			spin_unlock_irq(&rh->region_lock);
+		}
+		reg = nreg;
+	}
+	write_unlock_irq(&rh->hash_lock);
+	read_lock(&rh->hash_lock);
+
+	return reg;
+}
+
+static inline struct region *__rh_find(struct region_hash *rh, region_t region)
+{
+	struct region *reg;
+
+	reg = __rh_lookup(rh, region);
+	if (!reg)
+		reg = __rh_alloc(rh, region);
+
+	return reg;
+}
+
+static int rh_state(struct region_hash *rh, region_t region, int may_block)
+{
+	int r;
+	struct region *reg;
+
+	read_lock(&rh->hash_lock);
+	reg = __rh_lookup(rh, region);
+	read_unlock(&rh->hash_lock);
+
+	if (reg)
+		return reg->state;
+
+	/*
+	 * The region wasn't in the hash, so we fall back to the
+	 * dirty log.
+	 */
+	r = rh->log->type->in_sync(rh->log, region, may_block);
+
+	/*
+	 * Any error from the dirty log (eg. -EWOULDBLOCK) gets
+	 * taken as a RH_NOSYNC
+	 */
+	return r == 1 ? RH_CLEAN : RH_NOSYNC;
+}
+
+static inline int rh_in_sync(struct region_hash *rh,
+			     region_t region, int may_block)
+{
+	int state = rh_state(rh, region, may_block);
+	return state == RH_CLEAN || state == RH_DIRTY;
+}
+
+static void dispatch_bios(struct mirror_set *ms, struct bio *bio)
+{
+	struct bio *nbio;
+
+	while (bio) {
+		nbio = bio->bi_next;
+		queue_bio(ms, bio, WRITE);
+		bio = nbio;
+	}
+}
+
+static void rh_update_states(struct region_hash *rh)
+{
+	struct region *reg, *next;
+
+	LIST_HEAD(clean);
+	LIST_HEAD(recovered);
+
+	/*
+	 * Quickly grab the lists.
+	 */
+	write_lock_irq(&rh->hash_lock);
+	spin_lock(&rh->region_lock);
+	if (!list_empty(&rh->clean_regions)) {
+		list_splice(&rh->clean_regions, &clean);
+		INIT_LIST_HEAD(&rh->clean_regions);
+
+		list_for_each_entry (reg, &clean, list) {
+			rh->log->type->clear_region(rh->log, reg->key);
+			list_del(&reg->hash_list);
+		}
+	}
+
+	if (!list_empty(&rh->recovered_regions)) {
+		list_splice(&rh->recovered_regions, &recovered);
+		INIT_LIST_HEAD(&rh->recovered_regions);
+
+		list_for_each_entry (reg, &recovered, list)
+			list_del(&reg->hash_list);
+	}
+	spin_unlock(&rh->region_lock);
+	write_unlock_irq(&rh->hash_lock);
+
+	/*
+	 * All the regions on the recovered and clean lists have
+	 * now been pulled out of the system, so no need to do
+	 * any more locking.
+	 */
+	list_for_each_entry_safe (reg, next, &recovered, list) {
+		rh->log->type->clear_region(rh->log, reg->key);
+		rh->log->type->complete_resync_work(rh->log, reg->key, 1);
+		dispatch_bios(rh->ms, reg->delayed_bios);
+		up(&rh->recovery_count);
+		mempool_free(reg, rh->region_pool);
+	}
+
+	if (!list_empty(&recovered))
+		rh->log->type->flush(rh->log);
+
+	list_for_each_entry_safe (reg, next, &clean, list)
+		mempool_free(reg, rh->region_pool);
+}
+
+static void rh_inc(struct region_hash *rh, region_t region)
+{
+	struct region *reg;
+
+	read_lock(&rh->hash_lock);
+	reg = __rh_find(rh, region);
+	if (reg->state == RH_CLEAN) {
+		rh->log->type->mark_region(rh->log, reg->key);
+
+		spin_lock_irq(&rh->region_lock);
+		reg->state = RH_DIRTY;
+		list_del_init(&reg->list);	/* take off the clean list */
+		spin_unlock_irq(&rh->region_lock);
+	}
+
+	atomic_inc(&reg->pending);
+	read_unlock(&rh->hash_lock);
+}
+
+static void rh_inc_pending(struct region_hash *rh, struct bio_list *bios)
+{
+	struct bio *bio;
+
+	for (bio = bios->head; bio; bio = bio->bi_next)
+		rh_inc(rh, bio_to_region(rh, bio));
+}
+
+static void rh_dec(struct region_hash *rh, region_t region)
+{
+	unsigned long flags;
+	struct region *reg;
+	int should_wake = 0;
+
+	read_lock(&rh->hash_lock);
+	reg = __rh_lookup(rh, region);
+	read_unlock(&rh->hash_lock);
+
+	if (atomic_dec_and_test(&reg->pending)) {
+		spin_lock_irqsave(&rh->region_lock, flags);
+		if (reg->state == RH_RECOVERING) {
+			list_add_tail(&reg->list, &rh->quiesced_regions);
+		} else {
+			reg->state = RH_CLEAN;
+			list_add(&reg->list, &rh->clean_regions);
+		}
+		spin_unlock_irqrestore(&rh->region_lock, flags);
+		should_wake = 1;
+	}
+
+	if (should_wake)
+		wake();
+}
+
+/*
+ * Starts quiescing a region in preparation for recovery.
+ */
+static int __rh_recovery_prepare(struct region_hash *rh)
+{
+	int r;
+	struct region *reg;
+	region_t region;
+
+	/*
+	 * Ask the dirty log what's next.
+	 */
+	r = rh->log->type->get_resync_work(rh->log, &region);
+	if (r <= 0)
+		return r;
+
+	/*
+	 * Get this region, and start it quiescing by setting the
+	 * recovering flag.
+	 */
+	read_lock(&rh->hash_lock);
+	reg = __rh_find(rh, region);
+	read_unlock(&rh->hash_lock);
+
+	spin_lock_irq(&rh->region_lock);
+	reg->state = RH_RECOVERING;
+
+	/* Already quiesced ? */
+	if (atomic_read(&reg->pending))
+		list_del_init(&reg->list);
+
+	else {
+		list_del_init(&reg->list);
+		list_add(&reg->list, &rh->quiesced_regions);
+	}
+	spin_unlock_irq(&rh->region_lock);
+
+	return 1;
+}
+
+static void rh_recovery_prepare(struct region_hash *rh)
+{
+	while (!down_trylock(&rh->recovery_count))
+		if (__rh_recovery_prepare(rh) <= 0) {
+			up(&rh->recovery_count);
+			break;
+		}
+}
+
+/*
+ * Returns any quiesced regions.
+ */
+static struct region *rh_recovery_start(struct region_hash *rh)
+{
+	struct region *reg = NULL;
+
+	spin_lock_irq(&rh->region_lock);
+	if (!list_empty(&rh->quiesced_regions)) {
+		reg = list_entry(rh->quiesced_regions.next,
+				 struct region, list);
+		list_del_init(&reg->list);	/* remove from the quiesced list */
+	}
+	spin_unlock_irq(&rh->region_lock);
+
+	return reg;
+}
+
+/* FIXME: success ignored for now */
+static void rh_recovery_end(struct region *reg, int success)
+{
+	struct region_hash *rh = reg->rh;
+
+	spin_lock_irq(&rh->region_lock);
+	list_add(&reg->list, &reg->rh->recovered_regions);
+	spin_unlock_irq(&rh->region_lock);
+
+	wake();
+}
+
+static void rh_flush(struct region_hash *rh)
+{
+	rh->log->type->flush(rh->log);
+}
+
+static void rh_delay(struct region_hash *rh, struct bio *bio)
+{
+	struct region *reg;
+
+	read_lock(&rh->hash_lock);
+	reg = __rh_find(rh, bio_to_region(rh, bio));
+	bio->bi_next = reg->delayed_bios;
+	reg->delayed_bios = bio;
+	read_unlock(&rh->hash_lock);
+}
+
+static void rh_stop_recovery(struct region_hash *rh)
+{
+	int i;
+
+	/* wait for any recovering regions */
+	for (i = 0; i < MAX_RECOVERY; i++)
+		down(&rh->recovery_count);
+}
+
+static void rh_start_recovery(struct region_hash *rh)
+{
+	int i;
+
+	for (i = 0; i < MAX_RECOVERY; i++)
+		up(&rh->recovery_count);
+
+	wake();
+}
+
+/*-----------------------------------------------------------------
+ * Mirror set structures.
+ *---------------------------------------------------------------*/
+struct mirror {
+	atomic_t error_count;
+	struct dm_dev *dev;
+	sector_t offset;
+};
+
+struct mirror_set {
+	struct dm_target *ti;
+	struct list_head list;
+	struct region_hash rh;
+	struct kcopyd_client *kcopyd_client;
+
+	spinlock_t lock;	/* protects the next two lists */
+	struct bio_list reads;
+	struct bio_list writes;
+
+	/* recovery */
+	region_t nr_regions;
+	int in_sync;
+
+	unsigned int nr_mirrors;
+	struct mirror mirror[0];
+};
+
+/*
+ * Every mirror should look like this one.
+ */
+#define DEFAULT_MIRROR 0
+
+/*
+ * This is yucky.  We squirrel the mirror_set struct away inside
+ * bi_next for write buffers.  This is safe since the bh
+ * doesn't get submitted to the lower levels of block layer.
+ */
+static struct mirror_set *bio_get_ms(struct bio *bio)
+{
+	return (struct mirror_set *) bio->bi_next;
+}
+
+static void bio_set_ms(struct bio *bio, struct mirror_set *ms)
+{
+	bio->bi_next = (struct bio *) ms;
+}
+
+/*-----------------------------------------------------------------
+ * Recovery.
+ *
+ * When a mirror is first activated we may find that some regions
+ * are in the no-sync state.  We have to recover these by
+ * recopying from the default mirror to all the others.
+ *---------------------------------------------------------------*/
+static void recovery_complete(int read_err, unsigned int write_err,
+			      void *context)
+{
+	struct region *reg = (struct region *) context;
+
+	/* FIXME: better error handling */
+	rh_recovery_end(reg, read_err || write_err);
+}
+
+static int recover(struct mirror_set *ms, struct region *reg)
+{
+	int r;
+	unsigned int i;
+	struct io_region from, to[ms->nr_mirrors - 1], *dest;
+	struct mirror *m;
+	unsigned long flags = 0;
+
+	/* fill in the source */
+	m = ms->mirror + DEFAULT_MIRROR;
+	from.bdev = m->dev->bdev;
+	from.sector = m->offset + region_to_sector(reg->rh, reg->key);
+	if (reg->key == (ms->nr_regions - 1)) {
+		/*
+		 * The final region may be smaller than
+		 * region_size.
+		 */
+		from.count = ms->ti->len & (reg->rh->region_size - 1);
+		if (!from.count)
+			from.count = reg->rh->region_size;
+	} else
+		from.count = reg->rh->region_size;
+
+	/* fill in the destinations */
+	for (i = 0, dest = to; i < ms->nr_mirrors; i++) {
+		if (i == DEFAULT_MIRROR)
+			continue;
+
+		m = ms->mirror + i;
+		dest->bdev = m->dev->bdev;
+		dest->sector = m->offset + region_to_sector(reg->rh, reg->key);
+		dest->count = from.count;
+		dest++;
+	}
+
+	/* hand to kcopyd */
+	set_bit(KCOPYD_IGNORE_ERROR, &flags);
+	r = kcopyd_copy(ms->kcopyd_client, &from, ms->nr_mirrors - 1, to, flags,
+			recovery_complete, reg);
+
+	return r;
+}
+
+static void do_recovery(struct mirror_set *ms)
+{
+	int r;
+	struct region *reg;
+	struct dirty_log *log = ms->rh.log;
+
+	/*
+	 * Start quiescing some regions.
+	 */
+	rh_recovery_prepare(&ms->rh);
+
+	/*
+	 * Copy any already quiesced regions.
+	 */
+	while ((reg = rh_recovery_start(&ms->rh))) {
+		r = recover(ms, reg);
+		if (r)
+			rh_recovery_end(reg, 0);
+	}
+
+	/*
+	 * Update the in sync flag.
+	 */
+	if (!ms->in_sync &&
+	    (log->type->get_sync_count(log) == ms->nr_regions)) {
+		/* the sync is complete */
+		dm_table_event(ms->ti->table);
+		ms->in_sync = 1;
+	}
+}
+
+/*-----------------------------------------------------------------
+ * Reads
+ *---------------------------------------------------------------*/
+static struct mirror *choose_mirror(struct mirror_set *ms, sector_t sector)
+{
+	/* FIXME: add read balancing */
+	return ms->mirror + DEFAULT_MIRROR;
+}
+
+/*
+ * remap a buffer to a particular mirror.
+ */
+static void map_bio(struct mirror_set *ms, struct mirror *m, struct bio *bio)
+{
+	bio->bi_bdev = m->dev->bdev;
+	bio->bi_sector = m->offset + (bio->bi_sector - ms->ti->begin);
+}
+
+static void do_reads(struct mirror_set *ms, struct bio_list *reads)
+{
+	region_t region;
+	struct bio *bio;
+	struct mirror *m;
+
+	while ((bio = bio_list_pop(reads))) {
+		region = bio_to_region(&ms->rh, bio);
+
+		/*
+		 * We can only read balance if the region is in sync.
+		 */
+		if (rh_in_sync(&ms->rh, region, 0))
+			m = choose_mirror(ms, bio->bi_sector);
+		else
+			m = ms->mirror + DEFAULT_MIRROR;
+
+		map_bio(ms, m, bio);
+		generic_make_request(bio);
+	}
+}
+
+/*-----------------------------------------------------------------
+ * Writes.
+ *
+ * We do different things with the write io depending on the
+ * state of the region that it's in:
+ *
+ * SYNC: 	increment pending, use kcopyd to write to *all* mirrors
+ * RECOVERING:	delay the io until recovery completes
+ * NOSYNC:	increment pending, just write to the default mirror
+ *---------------------------------------------------------------*/
+static void write_callback(unsigned long error, void *context)
+{
+	unsigned int i;
+	int uptodate = 1;
+	struct bio *bio = (struct bio *) context;
+	struct mirror_set *ms;
+
+	ms = bio_get_ms(bio);
+	bio_set_ms(bio, NULL);
+
+	/*
+	 * NOTE: We don't decrement the pending count here,
+	 * instead it is done by the targets endio function.
+	 * This way we handle both writes to SYNC and NOSYNC
+	 * regions with the same code.
+	 */
+
+	if (error) {
+		/*
+		 * only error the io if all mirrors failed.
+		 * FIXME: bogus
+		 */
+		uptodate = 0;
+		for (i = 0; i < ms->nr_mirrors; i++)
+			if (!test_bit(i, &error)) {
+				uptodate = 1;
+				break;
+			}
+	}
+	bio_endio(bio, bio->bi_size, 0);
+}
+
+static void do_write(struct mirror_set *ms, struct bio *bio)
+{
+	unsigned int i;
+	struct io_region io[ms->nr_mirrors];
+	struct mirror *m;
+
+	for (i = 0; i < ms->nr_mirrors; i++) {
+		m = ms->mirror + i;
+
+		io[i].bdev = m->dev->bdev;
+		io[i].sector = m->offset + (bio->bi_sector - ms->ti->begin);
+		io[i].count = bio->bi_size >> 9;
+	}
+
+	bio_set_ms(bio, ms);
+	dm_io_async_bvec(ms->nr_mirrors, io, WRITE,
+			 bio->bi_io_vec + bio->bi_idx,
+			 write_callback, bio);
+}
+
+static void do_writes(struct mirror_set *ms, struct bio_list *writes)
+{
+	int state;
+	struct bio *bio;
+	struct bio_list sync, nosync, recover, *this_list = NULL;
+
+	if (!writes->head)
+		return;
+
+	/*
+	 * Classify each write.
+	 */
+	bio_list_init(&sync);
+	bio_list_init(&nosync);
+	bio_list_init(&recover);
+
+	while ((bio = bio_list_pop(writes))) {
+		state = rh_state(&ms->rh, bio_to_region(&ms->rh, bio), 1);
+		switch (state) {
+		case RH_CLEAN:
+		case RH_DIRTY:
+			this_list = &sync;
+			break;
+
+		case RH_NOSYNC:
+			this_list = &nosync;
+			break;
+
+		case RH_RECOVERING:
+			this_list = &recover;
+			break;
+		}
+
+		bio_list_add(this_list, bio);
+	}
+
+	/*
+	 * Increment the pending counts for any regions that will
+	 * be written to (writes to recover regions are going to
+	 * be delayed).
+	 */
+	rh_inc_pending(&ms->rh, &sync);
+	rh_inc_pending(&ms->rh, &nosync);
+	rh_flush(&ms->rh);
+
+	/*
+	 * Dispatch io.
+	 */
+	while ((bio = bio_list_pop(&sync)))
+		do_write(ms, bio);
+
+	while ((bio = bio_list_pop(&recover)))
+		rh_delay(&ms->rh, bio);
+
+	while ((bio = bio_list_pop(&nosync))) {
+		map_bio(ms, ms->mirror + DEFAULT_MIRROR, bio);
+		generic_make_request(bio);
+	}
+}
+
+/*-----------------------------------------------------------------
+ * kmirrord
+ *---------------------------------------------------------------*/
+static LIST_HEAD(_mirror_sets);
+static DECLARE_RWSEM(_mirror_sets_lock);
+
+static void do_mirror(struct mirror_set *ms)
+{
+	struct bio_list reads, writes;
+
+	spin_lock(&ms->lock);
+	memcpy(&reads, &ms->reads, sizeof(reads));
+	bio_list_init(&ms->reads);
+	memcpy(&writes, &ms->writes, sizeof(writes));
+	bio_list_init(&ms->writes);
+	spin_unlock(&ms->lock);
+
+	rh_update_states(&ms->rh);
+	do_recovery(ms);
+	do_reads(ms, &reads);
+	do_writes(ms, &writes);
+}
+
+static void do_work(void *ignored)
+{
+	struct mirror_set *ms;
+
+	down_read(&_mirror_sets_lock);
+	list_for_each_entry (ms, &_mirror_sets, list)
+		do_mirror(ms);
+	up_read(&_mirror_sets_lock);
+}
+
+/*-----------------------------------------------------------------
+ * Target functions
+ *---------------------------------------------------------------*/
+static struct mirror_set *alloc_context(unsigned int nr_mirrors,
+					sector_t region_size,
+					struct dm_target *ti,
+					struct dirty_log *dl)
+{
+	size_t len;
+	struct mirror_set *ms = NULL;
+
+	if (array_too_big(sizeof(*ms), sizeof(ms->mirror[0]), nr_mirrors))
+		return NULL;
+
+	len = sizeof(*ms) + (sizeof(ms->mirror[0]) * nr_mirrors);
+
+	ms = kmalloc(len, GFP_KERNEL);
+	if (!ms) {
+		ti->error = "dm-mirror: Cannot allocate mirror context";
+		return NULL;
+	}
+
+	memset(ms, 0, len);
+	spin_lock_init(&ms->lock);
+
+	ms->ti = ti;
+	ms->nr_mirrors = nr_mirrors;
+	ms->nr_regions = dm_div_up(ti->len, region_size);
+	ms->in_sync = 0;
+
+	if (rh_init(&ms->rh, ms, dl, region_size, ms->nr_regions)) {
+		ti->error = "dm-mirror: Error creating dirty region hash";
+		kfree(ms);
+		return NULL;
+	}
+
+	return ms;
+}
+
+static void free_context(struct mirror_set *ms, struct dm_target *ti,
+			 unsigned int m)
+{
+	while (m--)
+		dm_put_device(ti, ms->mirror[m].dev);
+
+	rh_exit(&ms->rh);
+	kfree(ms);
+}
+
+static inline int _check_region_size(struct dm_target *ti, sector_t size)
+{
+	return !(size % (PAGE_SIZE >> 9) || (size & (size - 1)) ||
+		 size > ti->len);
+}
+
+static int get_mirror(struct mirror_set *ms, struct dm_target *ti,
+		      unsigned int mirror, char **argv)
+{
+	sector_t offset;
+
+	if (sscanf(argv[1], SECTOR_FORMAT, &offset) != 1) {
+		ti->error = "dm-mirror: Invalid offset";
+		return -EINVAL;
+	}
+
+	if (dm_get_device(ti, argv[0], offset, ti->len,
+			  dm_table_get_mode(ti->table),
+			  &ms->mirror[mirror].dev)) {
+		ti->error = "dm-mirror: Device lookup failure";
+		return -ENXIO;
+	}
+
+	ms->mirror[mirror].offset = offset;
+
+	return 0;
+}
+
+static int add_mirror_set(struct mirror_set *ms)
+{
+	down_write(&_mirror_sets_lock);
+	list_add_tail(&ms->list, &_mirror_sets);
+	up_write(&_mirror_sets_lock);
+	wake();
+
+	return 0;
+}
+
+static void del_mirror_set(struct mirror_set *ms)
+{
+	down_write(&_mirror_sets_lock);
+	list_del(&ms->list);
+	up_write(&_mirror_sets_lock);
+}
+
+/*
+ * Create dirty log: log_type #log_params <log_params>
+ */
+static struct dirty_log *create_dirty_log(struct dm_target *ti,
+					  unsigned int argc, char **argv,
+					  unsigned int *args_used)
+{
+	unsigned int param_count;
+	struct dirty_log *dl;
+
+	if (argc < 2) {
+		ti->error = "dm-mirror: Insufficient mirror log arguments";
+		return NULL;
+	}
+
+	if (sscanf(argv[1], "%u", &param_count) != 1) {
+		ti->error = "dm-mirror: Invalid mirror log argument count";
+		return NULL;
+	}
+
+	*args_used = 2 + param_count;
+
+	if (argc < *args_used) {
+		ti->error = "dm-mirror: Insufficient mirror log arguments";
+		return NULL;
+	}
+
+	dl = dm_create_dirty_log(argv[0], ti, param_count, argv + 2);
+	if (!dl) {
+		ti->error = "dm-mirror: Error creating mirror dirty log";
+		return NULL;
+	}
+
+	if (!_check_region_size(ti, dl->type->get_region_size(dl))) {
+		ti->error = "dm-mirror: Invalid region size";
+		dm_destroy_dirty_log(dl);
+		return NULL;
+	}
+
+	return dl;
+}
+
+/*
+ * Construct a mirror mapping:
+ *
+ * log_type #log_params <log_params>
+ * #mirrors [mirror_path offset]{2,}
+ *
+ * For now, #log_params = 1, log_type = "core"
+ *
+ */
+#define DM_IO_PAGES 64
+static int mirror_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	int r;
+	unsigned int nr_mirrors, m, args_used;
+	struct mirror_set *ms;
+	struct dirty_log *dl;
+
+	dl = create_dirty_log(ti, argc, argv, &args_used);
+	if (!dl)
+		return -EINVAL;
+
+	argv += args_used;
+	argc -= args_used;
+
+	if (!argc || sscanf(argv[0], "%u", &nr_mirrors) != 1 ||
+	    nr_mirrors < 2) {
+		ti->error = "dm-mirror: Invalid number of mirrors";
+		dm_destroy_dirty_log(dl);
+		return -EINVAL;
+	}
+
+	argv++, argc--;
+
+	if (argc != nr_mirrors * 2) {
+		ti->error = "dm-mirror: Wrong number of mirror arguments";
+		dm_destroy_dirty_log(dl);
+		return -EINVAL;
+	}
+
+	ms = alloc_context(nr_mirrors, dl->type->get_region_size(dl), ti, dl);
+	if (!ms) {
+		dm_destroy_dirty_log(dl);
+		return -ENOMEM;
+	}
+
+	/* Get the mirror parameter sets */
+	for (m = 0; m < nr_mirrors; m++) {
+		r = get_mirror(ms, ti, m, argv);
+		if (r) {
+			free_context(ms, ti, m);
+			return r;
+		}
+		argv += 2;
+		argc -= 2;
+	}
+
+	ti->private = ms;
+
+	r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
+	if (r) {
+		free_context(ms, ti, ms->nr_mirrors);
+		return r;
+	}
+
+	add_mirror_set(ms);
+	return 0;
+}
+
+static void mirror_dtr(struct dm_target *ti)
+{
+	struct mirror_set *ms = (struct mirror_set *) ti->private;
+
+	del_mirror_set(ms);
+	kcopyd_client_destroy(ms->kcopyd_client);
+	free_context(ms, ti, ms->nr_mirrors);
+}
+
+static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw)
+{
+	int should_wake = 0;
+	struct bio_list *bl;
+
+	bl = (rw == WRITE) ? &ms->writes : &ms->reads;
+	spin_lock(&ms->lock);
+	should_wake = !(bl->head);
+	bio_list_add(bl, bio);
+	spin_unlock(&ms->lock);
+
+	if (should_wake)
+		wake();
+}
+
+/*
+ * Mirror mapping function
+ */
+static int mirror_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
+{
+	int r, rw = bio_rw(bio);
+	struct mirror *m;
+	struct mirror_set *ms = ti->private;
+
+	map_context->ll = bio->bi_sector >> ms->rh.region_shift;
+
+	if (rw == WRITE) {
+		queue_bio(ms, bio, rw);
+		return 0;
+	}
+
+	r = ms->rh.log->type->in_sync(ms->rh.log,
+				      bio_to_region(&ms->rh, bio), 0);
+	if (r < 0 && r != -EWOULDBLOCK)
+		return r;
+
+	if (r == -EWOULDBLOCK)	/* FIXME: ugly */
+		r = 0;
+
+	/*
+	 * We don't want to fast track a recovery just for a read
+	 * ahead.  So we just let it silently fail.
+	 * FIXME: get rid of this.
+	 */
+	if (!r && rw == READA)
+		return -EIO;
+
+	if (!r) {
+		/* Pass this io over to the daemon */
+		queue_bio(ms, bio, rw);
+		return 0;
+	}
+
+	m = choose_mirror(ms, bio->bi_sector);
+	if (!m)
+		return -EIO;
+
+	map_bio(ms, m, bio);
+	return 1;
+}
+
+static int mirror_end_io(struct dm_target *ti, struct bio *bio,
+			 int error, union map_info *map_context)
+{
+	int rw = bio_rw(bio);
+	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	region_t region = map_context->ll;
+
+	/*
+	 * We need to dec pending if this was a write.
+	 */
+	if (rw == WRITE)
+		rh_dec(&ms->rh, region);
+
+	return 0;
+}
+
+static void mirror_suspend(struct dm_target *ti)
+{
+	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct dirty_log *log = ms->rh.log;
+	rh_stop_recovery(&ms->rh);
+	if (log->type->suspend && log->type->suspend(log))
+		/* FIXME: need better error handling */
+		DMWARN("log suspend failed");
+}
+
+static void mirror_resume(struct dm_target *ti)
+{
+	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct dirty_log *log = ms->rh.log;
+	if (log->type->resume && log->type->resume(log))
+		/* FIXME: need better error handling */
+		DMWARN("log resume failed");
+	rh_start_recovery(&ms->rh);
+}
+
+static int mirror_status(struct dm_target *ti, status_type_t type,
+			 char *result, unsigned int maxlen)
+{
+	char buffer[32];
+	unsigned int m, sz = 0;
+	struct mirror_set *ms = (struct mirror_set *) ti->private;
+
+#define EMIT(x...) sz += ((sz >= maxlen) ? \
+			  0 : scnprintf(result + sz, maxlen - sz, x))
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		EMIT("%d ", ms->nr_mirrors);
+
+		for (m = 0; m < ms->nr_mirrors; m++) {
+			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
+			EMIT("%s ", buffer);
+		}
+
+		EMIT(SECTOR_FORMAT "/" SECTOR_FORMAT,
+		     ms->rh.log->type->get_sync_count(ms->rh.log),
+		     ms->nr_regions);
+		break;
+
+	case STATUSTYPE_TABLE:
+		EMIT("%s 1 " SECTOR_FORMAT " %d ",
+		     ms->rh.log->type->name, ms->rh.region_size,
+		     ms->nr_mirrors);
+
+		for (m = 0; m < ms->nr_mirrors; m++) {
+			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
+			EMIT("%s " SECTOR_FORMAT " ",
+			     buffer, ms->mirror[m].offset);
+		}
+	}
+
+	return 0;
+}
+
+static struct target_type mirror_target = {
+	.name	 = "mirror",
+	.version = {1, 0, 1},
+	.module	 = THIS_MODULE,
+	.ctr	 = mirror_ctr,
+	.dtr	 = mirror_dtr,
+	.map	 = mirror_map,
+	.end_io	 = mirror_end_io,
+	.suspend = mirror_suspend,
+	.resume	 = mirror_resume,
+	.status	 = mirror_status,
+};
+
+static int __init dm_mirror_init(void)
+{
+	int r;
+
+	r = dm_dirty_log_init();
+	if (r)
+		return r;
+
+	_kmirrord_wq = create_workqueue("kmirrord");
+	if (!_kmirrord_wq) {
+		DMERR("couldn't start kmirrord");
+		dm_dirty_log_exit();
+		return r;
+	}
+	INIT_WORK(&_kmirrord_work, do_work, NULL);
+
+	r = dm_register_target(&mirror_target);
+	if (r < 0) {
+		DMERR("%s: Failed to register mirror target",
+		      mirror_target.name);
+		dm_dirty_log_exit();
+		destroy_workqueue(_kmirrord_wq);
+	}
+
+	return r;
+}
+
+static void __exit dm_mirror_exit(void)
+{
+	int r;
+
+	r = dm_unregister_target(&mirror_target);
+	if (r < 0)
+		DMERR("%s: unregister failed %d", mirror_target.name, r);
+
+	destroy_workqueue(_kmirrord_wq);
+	dm_dirty_log_exit();
+}
+
+/* Module hooks */
+module_init(dm_mirror_init);
+module_exit(dm_mirror_exit);
+
+MODULE_DESCRIPTION(DM_NAME " mirror target");
+MODULE_AUTHOR("Joe Thornber");
+MODULE_LICENSE("GPL");

