Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbTLINGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbTLINGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:06:46 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:26887 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265608AbTLINBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:01:38 -0500
Date: Tue, 9 Dec 2003 12:26:13 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 3/4] dm: core files
Message-ID: <20031209122613.GE472@reti>
References: <20031209115806.GA472@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209115806.GA472@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device-mapper core.
--- diff/Documentation/Configure.help	2003-12-09 10:25:24.000000000 +0000
+++ source/Documentation/Configure.help	2003-12-09 10:39:47.000000000 +0000
@@ -1912,6 +1912,20 @@
   want), say M here and read <file:Documentation/modules.txt>.  The
   module will be called lvm-mod.o.
 
+Device-mapper support
+CONFIG_BLK_DEV_DM
+  Device-mapper is a low level volume manager.  It works by allowing
+  people to specify mappings for ranges of logical sectors.  Various
+  mapping types are available, in addition people may write their own
+  modules containing custom mappings if they wish.
+
+  Higher level volume managers such as LVM2 use this driver.
+
+  If you want to compile this as a module, say M here and read 
+  <file:Documentation/modules.txt>.  The module will be called dm-mod.o.
+
+  If unsure, say N.
+
 Multiple devices driver support (RAID and LVM)
 CONFIG_MD
   Support multiple physical spindles through a single logical device.
--- diff/MAINTAINERS	2003-12-09 10:25:24.000000000 +0000
+++ source/MAINTAINERS	2003-12-09 10:39:47.000000000 +0000
@@ -570,6 +570,13 @@
 W:	http://www.debian.org/~dz/i8k/
 S:	Maintained
 
+DEVICE MAPPER
+P:	Joe Thornber
+M:	dm@uk.sistina.com
+L:	linux-LVM@sistina.com
+W:	http://www.sistina.com/lvm
+S:	Maintained
+
 DEVICE NUMBER REGISTRY
 P:	H. Peter Anvin
 M:	hpa@zytor.com
--- diff/drivers/md/Config.in	2001-09-26 16:15:05.000000000 +0100
+++ source/drivers/md/Config.in	2003-12-09 10:42:38.000000000 +0000
@@ -14,5 +14,6 @@
 dep_tristate '  Multipath I/O support' CONFIG_MD_MULTIPATH $CONFIG_BLK_DEV_MD
 
 dep_tristate ' Logical volume manager (LVM) support' CONFIG_BLK_DEV_LVM $CONFIG_MD
+dep_tristate ' Device-mapper support' CONFIG_BLK_DEV_DM $CONFIG_MD
 
 endmenu
--- diff/drivers/md/Makefile	2002-01-17 10:07:52.000000000 +0000
+++ source/drivers/md/Makefile	2003-12-09 10:43:27.000000000 +0000
@@ -4,24 +4,32 @@
 
 O_TARGET	:= mddev.o
 
-export-objs	:= md.o xor.o
-list-multi	:= lvm-mod.o
+export-objs	:= md.o xor.o dm-table.o dm-target.o dm.o
+
+list-multi	:= lvm-mod.o dm-mod.o dm-mirror-mod.o
 lvm-mod-objs	:= lvm.o lvm-snap.o lvm-fs.o
+dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
 # themselves, and md.o may use the personalities when it 
 # auto-initialised.
 
-obj-$(CONFIG_MD_LINEAR)		+= linear.o
-obj-$(CONFIG_MD_RAID0)		+= raid0.o
-obj-$(CONFIG_MD_RAID1)		+= raid1.o
-obj-$(CONFIG_MD_RAID5)		+= raid5.o xor.o
-obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
-obj-$(CONFIG_BLK_DEV_MD)	+= md.o
-obj-$(CONFIG_BLK_DEV_LVM)	+= lvm-mod.o
+obj-$(CONFIG_MD_LINEAR)			+= linear.o
+obj-$(CONFIG_MD_RAID0)			+= raid0.o
+obj-$(CONFIG_MD_RAID1)			+= raid1.o
+obj-$(CONFIG_MD_RAID5)			+= raid5.o xor.o
+obj-$(CONFIG_MD_MULTIPATH)		+= multipath.o
+obj-$(CONFIG_BLK_DEV_MD)		+= md.o
+
+obj-$(CONFIG_BLK_DEV_LVM)		+= lvm-mod.o
+
+obj-$(CONFIG_BLK_DEV_DM)		+= dm-mod.o
 
 include $(TOPDIR)/Rules.make
 
 lvm-mod.o: $(lvm-mod-objs)
 	$(LD) -r -o $@ $(lvm-mod-objs)
+
+dm-mod.o: $(dm-mod-objs)
+	$(LD) -r -o $@ $(dm-mod-objs)
--- diff/drivers/md/dm-linear.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-linear.c	2003-12-09 10:39:55.000000000 +0000
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+
+/*
+ * Linear: maps a linear range of a device.
+ */
+struct linear_c {
+	struct dm_dev *dev;
+	sector_t start;
+};
+
+/*
+ * Construct a linear mapping: <dev_path> <offset>
+ */
+static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct linear_c *lc;
+
+	if (argc != 2) {
+		ti->error = "dm-linear: Invalid argument count";
+		return -EINVAL;
+	}
+
+	lc = kmalloc(sizeof(*lc), GFP_KERNEL);
+	if (lc == NULL) {
+		ti->error = "dm-linear: Cannot allocate linear context";
+		return -ENOMEM;
+	}
+
+	if (sscanf(argv[1], SECTOR_FORMAT, &lc->start) != 1) {
+		ti->error = "dm-linear: Invalid device sector";
+		goto bad;
+	}
+
+	if (dm_get_device(ti, argv[0], lc->start, ti->len,
+			  dm_table_get_mode(ti->table), &lc->dev)) {
+		ti->error = "dm-linear: Device lookup failed";
+		goto bad;
+	}
+
+	ti->private = lc;
+	return 0;
+
+      bad:
+	kfree(lc);
+	return -EINVAL;
+}
+
+static void linear_dtr(struct dm_target *ti)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	dm_put_device(ti, lc->dev);
+	kfree(lc);
+}
+
+static int linear_map(struct dm_target *ti, struct buffer_head *bh, int rw,
+		      union map_info *map_context)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	bh->b_rdev = lc->dev->dev;
+	bh->b_rsector = lc->start + (bh->b_rsector - ti->begin);
+
+	return 1;
+}
+
+static int linear_status(struct dm_target *ti, status_type_t type,
+			 char *result, unsigned int maxlen)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+	kdev_t kdev;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		kdev = to_kdev_t(lc->dev->bdev->bd_dev);
+		snprintf(result, maxlen, "%s " SECTOR_FORMAT,
+			 dm_kdevname(kdev), lc->start);
+		break;
+	}
+	return 0;
+}
+
+static struct target_type linear_target = {
+	.name   = "linear",
+	.module = THIS_MODULE,
+	.ctr    = linear_ctr,
+	.dtr    = linear_dtr,
+	.map    = linear_map,
+	.status = linear_status,
+};
+
+int __init dm_linear_init(void)
+{
+	int r = dm_register_target(&linear_target);
+
+	if (r < 0)
+		DMERR("linear: register failed %d", r);
+
+	return r;
+}
+
+void dm_linear_exit(void)
+{
+	int r = dm_unregister_target(&linear_target);
+
+	if (r < 0)
+		DMERR("linear: unregister failed %d", r);
+}
--- diff/drivers/md/dm-stripe.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-stripe.c	2003-12-09 10:39:55.000000000 +0000
@@ -0,0 +1,258 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+
+struct stripe {
+	struct dm_dev *dev;
+	sector_t physical_start;
+};
+
+struct stripe_c {
+	uint32_t stripes;
+
+	/* The size of this target / num. stripes */
+	uint32_t stripe_width;
+
+	/* stripe chunk size */
+	uint32_t chunk_shift;
+	sector_t chunk_mask;
+
+	struct stripe stripe[0];
+};
+
+static inline struct stripe_c *alloc_context(unsigned int stripes)
+{
+	size_t len;
+
+	if (array_too_big(sizeof(struct stripe_c), sizeof(struct stripe),
+			  stripes))
+		return NULL;
+
+	len = sizeof(struct stripe_c) + (sizeof(struct stripe) * stripes);
+
+	return kmalloc(len, GFP_KERNEL);
+}
+
+/*
+ * Parse a single <dev> <sector> pair
+ */
+static int get_stripe(struct dm_target *ti, struct stripe_c *sc,
+		      unsigned int stripe, char **argv)
+{
+	sector_t start;
+
+	if (sscanf(argv[1], SECTOR_FORMAT, &start) != 1)
+		return -EINVAL;
+
+	if (dm_get_device(ti, argv[0], start, sc->stripe_width,
+			  dm_table_get_mode(ti->table),
+			  &sc->stripe[stripe].dev))
+		return -ENXIO;
+
+	sc->stripe[stripe].physical_start = start;
+	return 0;
+}
+
+/*
+ * FIXME: Nasty function, only present because we can't link
+ * against __moddi3 and __divdi3.
+ *
+ * returns a == b * n
+ */
+static int multiple(sector_t a, sector_t b, sector_t *n)
+{
+	sector_t acc, prev, i;
+
+	*n = 0;
+	while (a >= b) {
+		for (acc = b, prev = 0, i = 1;
+		     acc <= a;
+		     prev = acc, acc <<= 1, i <<= 1)
+			;
+
+		a -= prev;
+		*n += i >> 1;
+	}
+
+	return a == 0;
+}
+
+/*
+ * Construct a striped mapping.
+ * <number of stripes> <chunk size (2^^n)> [<dev_path> <offset>]+
+ */
+static int stripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct stripe_c *sc;
+	sector_t width;
+	uint32_t stripes;
+	uint32_t chunk_size;
+	char *end;
+	int r;
+	unsigned int i;
+
+	if (argc < 2) {
+		ti->error = "dm-stripe: Not enough arguments";
+		return -EINVAL;
+	}
+
+	stripes = simple_strtoul(argv[0], &end, 10);
+	if (*end) {
+		ti->error = "dm-stripe: Invalid stripe count";
+		return -EINVAL;
+	}
+
+	chunk_size = simple_strtoul(argv[1], &end, 10);
+	if (*end) {
+		ti->error = "dm-stripe: Invalid chunk_size";
+		return -EINVAL;
+	}
+
+	/*
+	 * chunk_size is a power of two
+	 */
+	if (!chunk_size || (chunk_size & (chunk_size - 1))) {
+		ti->error = "dm-stripe: Invalid chunk size";
+		return -EINVAL;
+	}
+
+	if (!multiple(ti->len, stripes, &width)) {
+		ti->error = "dm-stripe: Target length not divisable by "
+		    "number of stripes";
+		return -EINVAL;
+	}
+
+	/*
+	 * Do we have enough arguments for that many stripes ?
+	 */
+	if (argc != (2 + 2 * stripes)) {
+		ti->error = "dm-stripe: Not enough destinations specified";
+		return -EINVAL;
+	}
+
+	sc = alloc_context(stripes);
+	if (!sc) {
+		ti->error = "dm-stripe: Memory allocation for striped context "
+		    "failed";
+		return -ENOMEM;
+	}
+
+	sc->stripes = stripes;
+	sc->stripe_width = width;
+
+	sc->chunk_mask = ((sector_t) chunk_size) - 1;
+	for (sc->chunk_shift = 0; chunk_size; sc->chunk_shift++)
+		chunk_size >>= 1;
+	sc->chunk_shift--;
+
+	/*
+	 * Get the stripe destinations.
+	 */
+	for (i = 0; i < stripes; i++) {
+		argv += 2;
+
+		r = get_stripe(ti, sc, i, argv);
+		if (r < 0) {
+			ti->error = "dm-stripe: Couldn't parse stripe "
+			    "destination";
+			while (i--)
+				dm_put_device(ti, sc->stripe[i].dev);
+			kfree(sc);
+			return r;
+		}
+	}
+
+	ti->private = sc;
+	return 0;
+}
+
+static void stripe_dtr(struct dm_target *ti)
+{
+	unsigned int i;
+	struct stripe_c *sc = (struct stripe_c *) ti->private;
+
+	for (i = 0; i < sc->stripes; i++)
+		dm_put_device(ti, sc->stripe[i].dev);
+
+	kfree(sc);
+}
+
+static int stripe_map(struct dm_target *ti, struct buffer_head *bh, int rw,
+		      union map_info *context)
+{
+	struct stripe_c *sc = (struct stripe_c *) ti->private;
+
+	sector_t offset = bh->b_rsector - ti->begin;
+	uint32_t chunk = (uint32_t) (offset >> sc->chunk_shift);
+	uint32_t stripe = chunk % sc->stripes;	/* 32bit modulus */
+	chunk = chunk / sc->stripes;
+
+	bh->b_rdev = sc->stripe[stripe].dev->dev;
+	bh->b_rsector = sc->stripe[stripe].physical_start +
+	    (chunk << sc->chunk_shift) + (offset & sc->chunk_mask);
+	return 1;
+}
+
+static int stripe_status(struct dm_target *ti, status_type_t type,
+			 char *result, unsigned int maxlen)
+{
+	struct stripe_c *sc = (struct stripe_c *) ti->private;
+	int offset;
+	unsigned int i;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		offset = snprintf(result, maxlen, "%d " SECTOR_FORMAT,
+				  sc->stripes, sc->chunk_mask + 1);
+		for (i = 0; i < sc->stripes; i++) {
+			offset +=
+			    snprintf(result + offset, maxlen - offset,
+				     " %s " SECTOR_FORMAT,
+		       dm_kdevname(to_kdev_t(sc->stripe[i].dev->bdev->bd_dev)),
+				     sc->stripe[i].physical_start);
+		}
+		break;
+	}
+	return 0;
+}
+
+static struct target_type stripe_target = {
+	.name   = "striped",
+	.module = THIS_MODULE,
+	.ctr    = stripe_ctr,
+	.dtr    = stripe_dtr,
+	.map    = stripe_map,
+	.status = stripe_status,
+};
+
+int __init dm_stripe_init(void)
+{
+	int r;
+
+	r = dm_register_target(&stripe_target);
+	if (r < 0)
+		DMWARN("striped target registration failed");
+
+	return r;
+}
+
+void dm_stripe_exit(void)
+{
+	if (dm_unregister_target(&stripe_target))
+		DMWARN("striped target unregistration failed");
+
+	return;
+}
--- diff/drivers/md/dm-table.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-12-09 10:57:20.000000000 +0000
@@ -0,0 +1,696 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/blkdev.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <asm/atomic.h>
+
+#define MAX_DEPTH 16
+#define NODE_SIZE L1_CACHE_BYTES
+#define KEYS_PER_NODE (NODE_SIZE / sizeof(sector_t))
+#define CHILDREN_PER_NODE (KEYS_PER_NODE + 1)
+
+struct dm_table {
+	atomic_t holders;
+
+	/* btree table */
+	unsigned int depth;
+	unsigned int counts[MAX_DEPTH];	/* in nodes */
+	sector_t *index[MAX_DEPTH];
+
+	unsigned int num_targets;
+	unsigned int num_allocated;
+	sector_t *highs;
+	struct dm_target *targets;
+
+	/*
+	 * Indicates the rw permissions for the new logical
+	 * device.  This should be a combination of FMODE_READ
+	 * and FMODE_WRITE.
+	 */
+	int mode;
+
+	/* a list of devices used by this table */
+	struct list_head devices;
+
+	/* events get handed up using this callback */
+	void (*event_fn)(void *);
+	void *event_context;
+};
+
+/*
+ * Similar to ceiling(log_size(n))
+ */
+static unsigned int int_log(unsigned long n, unsigned long base)
+{
+	int result = 0;
+
+	while (n > 1) {
+		n = dm_div_up(n, base);
+		result++;
+	}
+
+	return result;
+}
+
+/*
+ * Calculate the index of the child node of the n'th node k'th key.
+ */
+static inline unsigned int get_child(unsigned int n, unsigned int k)
+{
+	return (n * CHILDREN_PER_NODE) + k;
+}
+
+/*
+ * Return the n'th node of level l from table t.
+ */
+static inline sector_t *get_node(struct dm_table *t, unsigned int l,
+				 unsigned int n)
+{
+	return t->index[l] + (n * KEYS_PER_NODE);
+}
+
+/*
+ * Return the highest key that you could lookup from the n'th
+ * node on level l of the btree.
+ */
+static sector_t high(struct dm_table *t, unsigned int l, unsigned int n)
+{
+	for (; l < t->depth - 1; l++)
+		n = get_child(n, CHILDREN_PER_NODE - 1);
+
+	if (n >= t->counts[l])
+		return (sector_t) - 1;
+
+	return get_node(t, l, n)[KEYS_PER_NODE - 1];
+}
+
+/*
+ * Fills in a level of the btree based on the highs of the level
+ * below it.
+ */
+static int setup_btree_index(unsigned int l, struct dm_table *t)
+{
+	unsigned int n, k;
+	sector_t *node;
+
+	for (n = 0U; n < t->counts[l]; n++) {
+		node = get_node(t, l, n);
+
+		for (k = 0U; k < KEYS_PER_NODE; k++)
+			node[k] = high(t, l + 1, get_child(n, k));
+	}
+
+	return 0;
+}
+
+void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size)
+{
+	unsigned long size;
+	void *addr;
+
+	/*
+	 * Check that we're not going to overflow.
+	 */
+	if (nmemb > (ULONG_MAX / elem_size))
+		return NULL;
+
+	size = nmemb * elem_size;
+	addr = vmalloc(size);
+	if (addr)
+		memset(addr, 0, size);
+
+	return addr;
+}
+
+int dm_table_create(struct dm_table **result, int mode, unsigned num_targets)
+{
+	struct dm_table *t = kmalloc(sizeof(*t), GFP_KERNEL);
+
+	if (!t)
+		return -ENOMEM;
+
+	memset(t, 0, sizeof(*t));
+	INIT_LIST_HEAD(&t->devices);
+	atomic_set(&t->holders, 1);
+
+	num_targets = dm_round_up(num_targets, KEYS_PER_NODE);
+
+	/* Allocate both the target array and offset array at once. */
+	t->highs = (sector_t *) dm_vcalloc(sizeof(struct dm_target) +
+					   sizeof(sector_t), num_targets);
+	if (!t->highs) {
+		kfree(t);
+		return -ENOMEM;
+	}
+
+	memset(t->highs, -1, sizeof(*t->highs) * num_targets);
+
+	t->targets = (struct dm_target *) (t->highs + num_targets);
+	t->num_allocated = num_targets;
+	t->mode = mode;
+	*result = t;
+	return 0;
+}
+
+static void free_devices(struct list_head *devices)
+{
+	struct list_head *tmp, *next;
+
+	for (tmp = devices->next; tmp != devices; tmp = next) {
+		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+		next = tmp->next;
+		kfree(dd);
+	}
+}
+
+void table_destroy(struct dm_table *t)
+{
+	unsigned int i;
+
+	/* free the indexes (see dm_table_complete) */
+	if (t->depth >= 2)
+		vfree(t->index[t->depth - 2]);
+
+	/* free the targets */
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *tgt = t->targets + i;
+
+		if (tgt->type->dtr)
+			tgt->type->dtr(tgt);
+
+		dm_put_target_type(tgt->type);
+	}
+
+	vfree(t->highs);
+
+	/* free the device list */
+	if (t->devices.next != &t->devices) {
+		DMWARN("devices still present during destroy: "
+		       "dm_table_remove_device calls missing");
+
+		free_devices(&t->devices);
+	}
+
+	kfree(t);
+}
+
+void dm_table_get(struct dm_table *t)
+{
+	atomic_inc(&t->holders);
+}
+
+void dm_table_put(struct dm_table *t)
+{
+	if (atomic_dec_and_test(&t->holders))
+		table_destroy(t);
+}
+
+/*
+ * Convert a device path to a dev_t.
+ */
+static int lookup_device(const char *path, kdev_t *dev)
+{
+	int r;
+	struct nameidata nd;
+	struct inode *inode;
+
+	if (!path_init(path, LOOKUP_FOLLOW, &nd))
+		return 0;
+
+	if ((r = path_walk(path, &nd)))
+		goto out;
+
+	inode = nd.dentry->d_inode;
+	if (!inode) {
+		r = -ENOENT;
+		goto out;
+	}
+
+	if (!S_ISBLK(inode->i_mode)) {
+		r = -ENOTBLK;
+		goto out;
+	}
+
+	*dev = inode->i_rdev;
+
+      out:
+	path_release(&nd);
+	return r;
+}
+
+/*
+ * See if we've already got a device in the list.
+ */
+static struct dm_dev *find_device(struct list_head *l, kdev_t dev)
+{
+	struct list_head *tmp;
+
+	list_for_each(tmp, l) {
+		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+		if (kdev_same(dd->dev, dev))
+			return dd;
+	}
+
+	return NULL;
+}
+
+/*
+ * Open a device so we can use it as a map destination.
+ */
+static int open_dev(struct dm_dev *dd)
+{
+	if (dd->bdev)
+		BUG();
+
+	dd->bdev = bdget(kdev_t_to_nr(dd->dev));
+	if (!dd->bdev)
+		return -ENOMEM;
+
+	return blkdev_get(dd->bdev, dd->mode, 0, BDEV_RAW);
+}
+
+/*
+ * Close a device that we've been using.
+ */
+static void close_dev(struct dm_dev *dd)
+{
+	if (!dd->bdev)
+		return;
+
+	blkdev_put(dd->bdev, BDEV_RAW);
+	dd->bdev = NULL;
+}
+
+/*
+ * If possible (ie. blk_size[major] is set), this checks an area
+ * of a destination device is valid.
+ */
+static int check_device_area(kdev_t dev, sector_t start, sector_t len)
+{
+	int *sizes;
+	sector_t dev_size;
+
+	if (!(sizes = blk_size[major(dev)]) || !(dev_size = sizes[minor(dev)]))
+		/* we don't know the device details,
+		 * so give the benefit of the doubt */
+		return 1;
+
+	/* convert to 512-byte sectors */
+	dev_size <<= 1;
+
+	return ((start < dev_size) && (len <= (dev_size - start)));
+}
+
+/*
+ * This upgrades the mode on an already open dm_dev.  Being
+ * careful to leave things as they were if we fail to reopen the
+ * device.
+ */
+static int upgrade_mode(struct dm_dev *dd, int new_mode)
+{
+	int r;
+	struct dm_dev dd_copy;
+
+	memcpy(&dd_copy, dd, sizeof(dd_copy));
+
+	dd->mode |= new_mode;
+	dd->bdev = NULL;
+	r = open_dev(dd);
+	if (!r)
+		close_dev(&dd_copy);
+	else
+		memcpy(dd, &dd_copy, sizeof(dd_copy));
+
+	return r;
+}
+
+/*
+ * Add a device to the list, or just increment the usage count if
+ * it's already present.
+ */
+int dm_get_device(struct dm_target *ti, const char *path, sector_t start,
+		  sector_t len, int mode, struct dm_dev **result)
+{
+	int r;
+	kdev_t dev;
+	struct dm_dev *dd;
+	unsigned major, minor;
+	struct dm_table *t = ti->table;
+
+	if (!t)
+		BUG();
+
+	if (sscanf(path, "%u:%u", &major, &minor) == 2) {
+		/* Extract the major/minor numbers */
+		dev = mk_kdev(major, minor);
+	} else {
+		/* convert the path to a device */
+		if ((r = lookup_device(path, &dev)))
+			return r;
+	}
+
+	dd = find_device(&t->devices, dev);
+	if (!dd) {
+		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+		if (!dd)
+			return -ENOMEM;
+
+		dd->dev = dev;
+		dd->mode = mode;
+		dd->bdev = NULL;
+
+		if ((r = open_dev(dd))) {
+			kfree(dd);
+			return r;
+		}
+
+		atomic_set(&dd->count, 0);
+		list_add(&dd->list, &t->devices);
+
+	} else if (dd->mode != (mode | dd->mode)) {
+		r = upgrade_mode(dd, mode);
+		if (r)
+			return r;
+	}
+	atomic_inc(&dd->count);
+
+	if (!check_device_area(dd->dev, start, len)) {
+		DMWARN("device %s too small for target", path);
+		dm_put_device(ti, dd);
+		return -EINVAL;
+	}
+
+	*result = dd;
+
+	return 0;
+}
+
+/*
+ * Decrement a devices use count and remove it if neccessary.
+ */
+void dm_put_device(struct dm_target *ti, struct dm_dev *dd)
+{
+	if (atomic_dec_and_test(&dd->count)) {
+		close_dev(dd);
+		list_del(&dd->list);
+		kfree(dd);
+	}
+}
+
+/*
+ * Checks to see if the target joins onto the end of the table.
+ */
+static int adjoin(struct dm_table *table, struct dm_target *ti)
+{
+	struct dm_target *prev;
+
+	if (!table->num_targets)
+		return !ti->begin;
+
+	prev = &table->targets[table->num_targets - 1];
+	return (ti->begin == (prev->begin + prev->len));
+}
+
+/*
+ * Used to dynamically allocate the arg array.
+ */
+static char **realloc_argv(unsigned *array_size, char **old_argv)
+{
+	char **argv;
+	unsigned new_size;
+
+	new_size = *array_size ? *array_size * 2 : 64;
+	argv = kmalloc(new_size * sizeof(*argv), GFP_KERNEL);
+	if (argv) {
+		memcpy(argv, old_argv, *array_size * sizeof(*argv));
+		*array_size = new_size;
+	}
+
+	kfree(old_argv);
+	return argv;
+}
+
+/*
+ * Destructively splits up the argument list to pass to ctr.
+ */
+static int split_args(int *argc, char ***argvp, char *input)
+{
+	char *start, *end = input, *out, **argv = NULL;
+	unsigned array_size = 0;
+
+	*argc = 0;
+	argv = realloc_argv(&array_size, argv);
+	if (!argv)
+		return -ENOMEM;
+
+	while (1) {
+		start = end;
+
+		/* Skip whitespace */
+		while (*start && isspace(*start))
+			start++;
+
+		if (!*start)
+			break;	/* success, we hit the end */
+
+		/* 'out' is used to remove any back-quotes */
+		end = out = start;
+		while (*end) {
+			/* Everything apart from '\0' can be quoted */
+			if (*end == '\\' && *(end + 1)) {
+				*out++ = *(end + 1);
+				end += 2;
+				continue;
+			}
+
+			if (isspace(*end))
+				break;	/* end of token */
+
+			*out++ = *end++;
+		}
+
+		/* have we already filled the array ? */
+		if ((*argc + 1) > array_size) {
+			argv = realloc_argv(&array_size, argv);
+			if (!argv)
+				return -ENOMEM;
+		}
+
+		/* we know this is whitespace */
+		if (*end)
+			end++;
+
+		/* terminate the string and put it in the array */
+		*out = '\0';
+		argv[*argc] = start;
+		(*argc)++;
+	}
+
+	*argvp = argv;
+	return 0;
+}
+
+int dm_table_add_target(struct dm_table *t, const char *type,
+			sector_t start, sector_t len, char *params)
+{
+	int r = -EINVAL, argc;
+	char **argv;
+	struct dm_target *tgt;
+
+	if (t->num_targets >= t->num_allocated)
+		return -ENOMEM;
+
+	tgt = t->targets + t->num_targets;
+	memset(tgt, 0, sizeof(*tgt));
+
+	tgt->type = dm_get_target_type(type);
+	if (!tgt->type) {
+		tgt->error = "unknown target type";
+		return -EINVAL;
+	}
+
+	tgt->table = t;
+	tgt->begin = start;
+	tgt->len = len;
+	tgt->error = "Unknown error";
+
+	/*
+	 * Does this target adjoin the previous one ?
+	 */
+	if (!adjoin(t, tgt)) {
+		tgt->error = "Gap in table";
+		r = -EINVAL;
+		goto bad;
+	}
+
+	r = split_args(&argc, &argv, params);
+	if (r) {
+		tgt->error = "couldn't split parameters (insufficient memory)";
+		goto bad;
+	}
+
+	r = tgt->type->ctr(tgt, argc, argv);
+	kfree(argv);
+	if (r)
+		goto bad;
+
+	t->highs[t->num_targets++] = tgt->begin + tgt->len - 1;
+	return 0;
+
+      bad:
+	printk(KERN_ERR DM_NAME ": %s\n", tgt->error);
+	dm_put_target_type(tgt->type);
+	return r;
+}
+
+static int setup_indexes(struct dm_table *t)
+{
+	int i;
+	unsigned int total = 0;
+	sector_t *indexes;
+
+	/* allocate the space for *all* the indexes */
+	for (i = t->depth - 2; i >= 0; i--) {
+		t->counts[i] = dm_div_up(t->counts[i + 1], CHILDREN_PER_NODE);
+		total += t->counts[i];
+	}
+
+	indexes = (sector_t *) dm_vcalloc(total, (unsigned long) NODE_SIZE);
+	if (!indexes)
+		return -ENOMEM;
+
+	/* set up internal nodes, bottom-up */
+	for (i = t->depth - 2, total = 0; i >= 0; i--) {
+		t->index[i] = indexes;
+		indexes += (KEYS_PER_NODE * t->counts[i]);
+		setup_btree_index(i, t);
+	}
+
+	return 0;
+}
+
+/*
+ * Builds the btree to index the map.
+ */
+int dm_table_complete(struct dm_table *t)
+{
+	int r = 0;
+	unsigned int leaf_nodes;
+
+	/* how many indexes will the btree have ? */
+	leaf_nodes = dm_div_up(t->num_targets, KEYS_PER_NODE);
+	t->depth = 1 + int_log(leaf_nodes, CHILDREN_PER_NODE);
+
+	/* leaf layer has already been set up */
+	t->counts[t->depth - 1] = leaf_nodes;
+	t->index[t->depth - 1] = t->highs;
+
+	if (t->depth >= 2)
+		r = setup_indexes(t);
+
+	return r;
+}
+
+static spinlock_t _event_lock = SPIN_LOCK_UNLOCKED;
+void dm_table_event_callback(struct dm_table *t,
+			     void (*fn)(void *), void *context)
+{
+	spin_lock_irq(&_event_lock);
+	t->event_fn = fn;
+	t->event_context = context;
+	spin_unlock_irq(&_event_lock);
+}
+
+void dm_table_event(struct dm_table *t)
+{
+	spin_lock(&_event_lock);
+	if (t->event_fn)
+		t->event_fn(t->event_context);
+	spin_unlock(&_event_lock);
+}
+
+sector_t dm_table_get_size(struct dm_table *t)
+{
+	return t->num_targets ? (t->highs[t->num_targets - 1] + 1) : 0;
+}
+
+struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index)
+{
+	if (index > t->num_targets)
+		return NULL;
+
+	return t->targets + index;
+}
+
+/*
+ * Search the btree for the correct target.
+ */
+struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
+{
+	unsigned int l, n = 0, k = 0;
+	sector_t *node;
+
+	for (l = 0; l < t->depth; l++) {
+		n = get_child(n, k);
+		node = get_node(t, l, n);
+
+		for (k = 0; k < KEYS_PER_NODE; k++)
+			if (node[k] >= sector)
+				break;
+	}
+
+	return &t->targets[(KEYS_PER_NODE * n) + k];
+}
+
+unsigned int dm_table_get_num_targets(struct dm_table *t)
+{
+	return t->num_targets;
+}
+
+struct list_head *dm_table_get_devices(struct dm_table *t)
+{
+	return &t->devices;
+}
+
+int dm_table_get_mode(struct dm_table *t)
+{
+	return t->mode;
+}
+
+void dm_table_suspend_targets(struct dm_table *t)
+{
+	int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
+
+		if (ti->type->suspend)
+			ti->type->suspend(ti);
+	}
+}
+
+void dm_table_resume_targets(struct dm_table *t)
+{
+	int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
+
+		if (ti->type->resume)
+			ti->type->resume(ti);
+	}
+}
+
+EXPORT_SYMBOL(dm_get_device);
+EXPORT_SYMBOL(dm_put_device);
+EXPORT_SYMBOL(dm_table_event);
+EXPORT_SYMBOL(dm_table_get_mode);
--- diff/drivers/md/dm-target.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-target.c	2003-12-09 10:39:55.000000000 +0000
@@ -0,0 +1,188 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/kmod.h>
+#include <linux/slab.h>
+
+struct tt_internal {
+	struct target_type tt;
+
+	struct list_head list;
+	long use;
+};
+
+static LIST_HEAD(_targets);
+static DECLARE_RWSEM(_lock);
+
+#define DM_MOD_NAME_SIZE 32
+
+static inline struct tt_internal *__find_target_type(const char *name)
+{
+	struct list_head *tih;
+	struct tt_internal *ti;
+
+	list_for_each(tih, &_targets) {
+		ti = list_entry(tih, struct tt_internal, list);
+
+		if (!strcmp(name, ti->tt.name))
+			return ti;
+	}
+
+	return NULL;
+}
+
+static struct tt_internal *get_target_type(const char *name)
+{
+	struct tt_internal *ti;
+
+	down_read(&_lock);
+	ti = __find_target_type(name);
+
+	if (ti) {
+		if (ti->use == 0 && ti->tt.module)
+			__MOD_INC_USE_COUNT(ti->tt.module);
+		ti->use++;
+	}
+	up_read(&_lock);
+
+	return ti;
+}
+
+static void load_module(const char *name)
+{
+	char module_name[DM_MOD_NAME_SIZE] = "dm-";
+
+	/* Length check for strcat() below */
+	if (strlen(name) > (DM_MOD_NAME_SIZE - 4))
+		return;
+
+	strcat(module_name, name);
+	request_module(module_name);
+}
+
+struct target_type *dm_get_target_type(const char *name)
+{
+	struct tt_internal *ti = get_target_type(name);
+
+	if (!ti) {
+		load_module(name);
+		ti = get_target_type(name);
+	}
+
+	return ti ? &ti->tt : NULL;
+}
+
+void dm_put_target_type(struct target_type *t)
+{
+	struct tt_internal *ti = (struct tt_internal *) t;
+
+	down_read(&_lock);
+	if (--ti->use == 0 && ti->tt.module)
+		__MOD_DEC_USE_COUNT(ti->tt.module);
+
+	if (ti->use < 0)
+		BUG();
+	up_read(&_lock);
+
+	return;
+}
+
+static struct tt_internal *alloc_target(struct target_type *t)
+{
+	struct tt_internal *ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+
+	if (ti) {
+		memset(ti, 0, sizeof(*ti));
+		ti->tt = *t;
+	}
+
+	return ti;
+}
+
+int dm_register_target(struct target_type *t)
+{
+	int rv = 0;
+	struct tt_internal *ti = alloc_target(t);
+
+	if (!ti)
+		return -ENOMEM;
+
+	down_write(&_lock);
+	if (__find_target_type(t->name)) {
+		kfree(ti);
+		rv = -EEXIST;
+	} else
+		list_add(&ti->list, &_targets);
+
+	up_write(&_lock);
+	return rv;
+}
+
+int dm_unregister_target(struct target_type *t)
+{
+	struct tt_internal *ti;
+
+	down_write(&_lock);
+	if (!(ti = __find_target_type(t->name))) {
+		up_write(&_lock);
+		return -EINVAL;
+	}
+
+	if (ti->use) {
+		up_write(&_lock);
+		return -ETXTBSY;
+	}
+
+	list_del(&ti->list);
+	kfree(ti);
+
+	up_write(&_lock);
+	return 0;
+}
+
+/*
+ * io-err: always fails an io, useful for bringing
+ * up LVs that have holes in them.
+ */
+static int io_err_ctr(struct dm_target *ti, unsigned int argc, char **args)
+{
+	return 0;
+}
+
+static void io_err_dtr(struct dm_target *ti)
+{
+	/* empty */
+}
+
+static int io_err_map(struct dm_target *ti, struct buffer_head *bh, int rw,
+		      union map_info *map_context)
+{
+	return -EIO;
+}
+
+static struct target_type error_target = {
+	.name = "error",
+	.ctr  = io_err_ctr,
+	.dtr  = io_err_dtr,
+	.map  = io_err_map,
+};
+
+int dm_target_init(void)
+{
+	return dm_register_target(&error_target);
+}
+
+void dm_target_exit(void)
+{
+	if (dm_unregister_target(&error_target))
+		DMWARN("error target unregistration failed");
+}
+
+EXPORT_SYMBOL(dm_register_target);
+EXPORT_SYMBOL(dm_unregister_target);
--- diff/drivers/md/dm.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm.c	2003-12-09 10:46:32.000000000 +0000
@@ -0,0 +1,1112 @@
+/*
+ * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/mempool.h>
+#include <linux/slab.h>
+#include <linux/major.h>
+#include <linux/kdev_t.h>
+#include <linux/lvm.h>
+
+#include <asm/uaccess.h>
+
+static const char *_name = DM_NAME;
+#define DEFAULT_READ_AHEAD 64
+
+struct dm_io {
+	struct mapped_device *md;
+
+	struct dm_target *ti;
+	int rw;
+	union map_info map_context;
+	void (*end_io) (struct buffer_head * bh, int uptodate);
+	void *context;
+};
+
+struct deferred_io {
+	int rw;
+	struct buffer_head *bh;
+	struct deferred_io *next;
+};
+
+/*
+ * Bits for the md->flags field.
+ */
+#define DMF_BLOCK_IO 0
+#define DMF_SUSPENDED 1
+
+struct mapped_device {
+	struct rw_semaphore lock;
+	atomic_t holders;
+
+	kdev_t dev;
+	unsigned long flags;
+
+	/*
+	 * A list of ios that arrived while we were suspended.
+	 */
+	atomic_t pending;
+	wait_queue_head_t wait;
+	struct deferred_io *deferred;
+
+	/*
+	 * The current mapping.
+	 */
+	struct dm_table *map;
+
+	/*
+	 * io objects are allocated from here.
+	 */
+	mempool_t *io_pool;
+
+	/*
+	 * Event handling.
+	 */
+	uint32_t event_nr;
+	wait_queue_head_t eventq;
+};
+
+#define MIN_IOS 256
+static kmem_cache_t *_io_cache;
+
+static struct mapped_device *get_kdev(kdev_t dev);
+static int dm_request(request_queue_t *q, int rw, struct buffer_head *bh);
+static int dm_user_bmap(struct inode *inode, struct lv_bmap *lvb);
+
+/*-----------------------------------------------------------------
+ * In order to avoid the 256 minor number limit we are going to
+ * register more major numbers as neccessary.
+ *---------------------------------------------------------------*/
+#define MAX_MINORS (1 << MINORBITS)
+
+struct major_details {
+	unsigned int major;
+
+	int transient;
+	struct list_head transient_list;
+
+	unsigned int first_free_minor;
+	int nr_free_minors;
+
+	struct mapped_device *mds[MAX_MINORS];
+	int blk_size[MAX_MINORS];
+	int blksize_size[MAX_MINORS];
+	int hardsect_size[MAX_MINORS];
+};
+
+static struct rw_semaphore _dev_lock;
+static struct major_details *_majors[MAX_BLKDEV];
+
+/*
+ * This holds a list of majors that non-specified device numbers
+ * may be allocated from.  Only majors with free minors appear on
+ * this list.
+ */
+static LIST_HEAD(_transients_free);
+
+static int __alloc_major(unsigned int major, struct major_details **result)
+{
+	int r;
+	unsigned int transient = !major;
+	struct major_details *maj;
+
+	/* Major already allocated? */
+	if (major && _majors[major])
+		return 0;
+
+	maj = kmalloc(sizeof(*maj), GFP_KERNEL);
+	if (!maj)
+		return -ENOMEM;
+
+	memset(maj, 0, sizeof(*maj));
+	INIT_LIST_HEAD(&maj->transient_list);
+
+	maj->nr_free_minors = MAX_MINORS;
+
+	r = register_blkdev(major, _name, &dm_blk_dops);
+	if (r < 0) {
+		DMERR("register_blkdev failed for %d", major);
+		kfree(maj);
+		return r;
+	}
+	if (r > 0)
+		major = r;
+
+	maj->major = major;
+
+	if (transient) {
+		maj->transient = transient;
+		list_add_tail(&maj->transient_list, &_transients_free);
+	}
+
+	_majors[major] = maj;
+
+	blk_size[major] = maj->blk_size;
+	blksize_size[major] = maj->blksize_size;
+	hardsect_size[major] = maj->hardsect_size;
+	read_ahead[major] = DEFAULT_READ_AHEAD;
+
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(major), dm_request);
+
+	*result = maj;
+	return 0;
+}
+
+static void __free_major(struct major_details *maj)
+{
+	unsigned int major = maj->major;
+
+	list_del(&maj->transient_list);
+
+	read_ahead[major] = 0;
+	blk_size[major] = NULL;
+	blksize_size[major] = NULL;
+	hardsect_size[major] = NULL;
+
+	_majors[major] = NULL;
+	kfree(maj);
+
+	if (unregister_blkdev(major, _name) < 0)
+		DMERR("devfs_unregister_blkdev failed");
+}
+
+static void free_all_majors(void)
+{
+	unsigned int major = ARRAY_SIZE(_majors);
+
+	down_write(&_dev_lock);
+
+	while (major--)
+		if (_majors[major])
+			__free_major(_majors[major]);
+
+	up_write(&_dev_lock);
+}
+
+static void free_dev(kdev_t dev)
+{
+	unsigned int major = major(dev);
+	unsigned int minor = minor(dev);
+	struct major_details *maj;
+
+	down_write(&_dev_lock);
+
+	maj = _majors[major];
+	if (!maj)
+		goto out;
+
+	maj->mds[minor] = NULL;
+	maj->nr_free_minors++;
+
+	if (maj->nr_free_minors == MAX_MINORS) {
+		__free_major(maj);
+		goto out;
+	}
+
+	if (!maj->transient)
+		goto out;
+
+	if (maj->nr_free_minors == 1)
+		list_add_tail(&maj->transient_list, &_transients_free);
+
+	if (minor < maj->first_free_minor)
+		maj->first_free_minor = minor;
+
+      out:
+	up_write(&_dev_lock);
+}
+
+static void __alloc_minor(struct major_details *maj, unsigned int minor,
+			  struct mapped_device *md)
+{
+	maj->mds[minor] = md;
+	md->dev = mk_kdev(maj->major, minor);
+	maj->nr_free_minors--;
+
+	if (maj->transient && !maj->nr_free_minors)
+		list_del_init(&maj->transient_list);
+}
+
+/*
+ * See if requested kdev_t is available.
+ */
+static int specific_dev(kdev_t dev, struct mapped_device *md)
+{
+	int r = 0;
+	unsigned int major = major(dev);
+	unsigned int minor = minor(dev);
+	struct major_details *maj;
+
+	if (!major || (major > MAX_BLKDEV) || (minor >= MAX_MINORS)) {
+		DMWARN("device number requested out of range (%d, %d)",
+		       major, minor);
+		return -EINVAL;
+	}
+
+	down_write(&_dev_lock);
+	maj = _majors[major];
+
+	/* Register requested major? */
+	if (!maj) {
+		r = __alloc_major(major, &maj);
+		if (r)
+			goto out;
+
+		major = maj->major;
+	}
+
+	if (maj->mds[minor]) {
+		r = -EBUSY;
+		goto out;
+	}
+
+	__alloc_minor(maj, minor, md);
+
+      out:
+	up_write(&_dev_lock);
+
+	return r;
+}
+
+/*
+ * Find first unused device number, requesting a new major number if required.
+ */
+static int first_free_dev(struct mapped_device *md)
+{
+	int r = 0;
+	struct major_details *maj;
+
+	down_write(&_dev_lock);
+
+	if (list_empty(&_transients_free)) {
+		r = __alloc_major(0, &maj);
+		if (r)
+			goto out;
+	} else
+		maj = list_entry(_transients_free.next, struct major_details,
+				 transient_list);
+
+	while (maj->mds[maj->first_free_minor++])
+		;
+
+	__alloc_minor(maj, maj->first_free_minor - 1, md);
+
+      out:
+	up_write(&_dev_lock);
+
+	return r;
+}
+
+static struct mapped_device *get_kdev(kdev_t dev)
+{
+	struct mapped_device *md;
+	struct major_details *maj;
+
+	down_read(&_dev_lock);
+	maj = _majors[major(dev)];
+	if (!maj) {
+		md = NULL;
+		goto out;
+	}
+	md = maj->mds[minor(dev)];
+	if (md)
+		dm_get(md);
+      out:
+	up_read(&_dev_lock);
+
+	return md;
+}
+
+/*-----------------------------------------------------------------
+ * init/exit code
+ *---------------------------------------------------------------*/
+
+static __init int local_init(void)
+{
+	init_rwsem(&_dev_lock);
+
+	/* allocate a slab for the dm_ios */
+	_io_cache = kmem_cache_create("dm io",
+				      sizeof(struct dm_io), 0, 0, NULL, NULL);
+
+	if (!_io_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void local_exit(void)
+{
+	kmem_cache_destroy(_io_cache);
+	free_all_majors();
+
+	DMINFO("cleaned up");
+}
+
+/*
+ * We have a lot of init/exit functions, so it seems easier to
+ * store them in an array.  The disposable macro 'xx'
+ * expands a prefix into a pair of function names.
+ */
+static struct {
+	int (*init) (void);
+	void (*exit) (void);
+
+} _inits[] = {
+#define xx(n) {n ## _init, n ## _exit},
+	xx(local)
+	xx(dm_target)
+	xx(dm_linear)
+	xx(dm_stripe)
+	xx(dm_interface)
+#undef xx
+};
+
+static int __init dm_init(void)
+{
+	const int count = ARRAY_SIZE(_inits);
+
+	int r, i;
+
+	for (i = 0; i < count; i++) {
+		r = _inits[i].init();
+		if (r)
+			goto bad;
+	}
+
+	return 0;
+
+      bad:
+	while (i--)
+		_inits[i].exit();
+
+	return r;
+}
+
+static void __exit dm_exit(void)
+{
+	int i = ARRAY_SIZE(_inits);
+
+	while (i--)
+		_inits[i].exit();
+}
+
+/*
+ * Block device functions
+ */
+static int dm_blk_open(struct inode *inode, struct file *file)
+{
+	struct mapped_device *md;
+
+	md = get_kdev(inode->i_rdev);
+	if (!md)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int dm_blk_close(struct inode *inode, struct file *file)
+{
+	struct mapped_device *md;
+
+	md = get_kdev(inode->i_rdev);
+	dm_put(md);		/* put the reference gained by dm_blk_open */
+	dm_put(md);
+	return 0;
+}
+
+static inline struct dm_io *alloc_io(struct mapped_device *md)
+{
+	return mempool_alloc(md->io_pool, GFP_NOIO);
+}
+
+static inline void free_io(struct mapped_device *md, struct dm_io *io)
+{
+	mempool_free(io, md->io_pool);
+}
+
+static inline struct deferred_io *alloc_deferred(void)
+{
+	return kmalloc(sizeof(struct deferred_io), GFP_NOIO);
+}
+
+static inline void free_deferred(struct deferred_io *di)
+{
+	kfree(di);
+}
+
+static inline sector_t volume_size(kdev_t dev)
+{
+	return blk_size[major(dev)][minor(dev)] << 1;
+}
+
+/* FIXME: check this */
+static int dm_blk_ioctl(struct inode *inode, struct file *file,
+			unsigned int command, unsigned long a)
+{
+	kdev_t dev = inode->i_rdev;
+	long size;
+
+	switch (command) {
+	case BLKROSET:
+	case BLKROGET:
+	case BLKRASET:
+	case BLKRAGET:
+	case BLKFLSBUF:
+	case BLKSSZGET:
+		//case BLKRRPART: /* Re-read partition tables */
+		//case BLKPG:
+	case BLKELVGET:
+	case BLKELVSET:
+	case BLKBSZGET:
+	case BLKBSZSET:
+		return blk_ioctl(dev, command, a);
+		break;
+
+	case BLKGETSIZE:
+		size = volume_size(dev);
+		if (copy_to_user((void *) a, &size, sizeof(long)))
+			return -EFAULT;
+		break;
+
+	case BLKGETSIZE64:
+		size = volume_size(dev);
+		if (put_user((u64) ((u64) size) << 9, (u64 *) a))
+			return -EFAULT;
+		break;
+
+	case BLKRRPART:
+		return -ENOTTY;
+
+	case LV_BMAP:
+		return dm_user_bmap(inode, (struct lv_bmap *) a);
+
+	default:
+		DMWARN("unknown block ioctl 0x%x", command);
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+/*
+ * Add the buffer to the list of deferred io.
+ */
+static int queue_io(struct mapped_device *md, struct buffer_head *bh, int rw)
+{
+	struct deferred_io *di;
+
+	di = alloc_deferred();
+	if (!di)
+		return -ENOMEM;
+
+	down_write(&md->lock);
+
+	if (!test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_write(&md->lock);
+		free_deferred(di);
+		return 1;
+	}
+
+	di->bh = bh;
+	di->rw = rw;
+	di->next = md->deferred;
+	md->deferred = di;
+
+	up_write(&md->lock);
+	return 0;		/* deferred successfully */
+}
+
+/*
+ * bh->b_end_io routine that decrements the pending count
+ * and then calls the original bh->b_end_io fn.
+ */
+static void dec_pending(struct buffer_head *bh, int uptodate)
+{
+	int r;
+	struct dm_io *io = bh->b_private;
+	dm_endio_fn endio = io->ti->type->end_io;
+
+	if (endio) {
+		r = endio(io->ti, bh, io->rw, uptodate ? 0 : -EIO,
+			  &io->map_context);
+		if (r < 0)
+			uptodate = 0;
+
+		else if (r > 0)
+			/* the target wants another shot at the io */
+			return;
+	}
+
+	if (atomic_dec_and_test(&io->md->pending))
+		/* nudge anyone waiting on suspend queue */
+		wake_up(&io->md->wait);
+
+	bh->b_end_io = io->end_io;
+	bh->b_private = io->context;
+	free_io(io->md, io);
+
+	bh->b_end_io(bh, uptodate);
+}
+
+/*
+ * Do the bh mapping for a given leaf
+ */
+static inline int __map_buffer(struct mapped_device *md, int rw,
+			       struct buffer_head *bh, struct dm_io *io)
+{
+	struct dm_target *ti;
+
+	if (!md->map)
+		return -EINVAL;
+
+	ti = dm_table_find_target(md->map, bh->b_rsector);
+	if (!ti->type)
+		return -EINVAL;
+
+	/* hook the end io request fn */
+	atomic_inc(&md->pending);
+	io->md = md;
+	io->ti = ti;
+	io->rw = rw;
+	io->end_io = bh->b_end_io;
+	io->context = bh->b_private;
+	bh->b_end_io = dec_pending;
+	bh->b_private = io;
+
+	return ti->type->map(ti, bh, rw, &io->map_context);
+}
+
+/*
+ * Checks to see if we should be deferring io, if so it queues it
+ * and returns 1.
+ */
+static inline int __deferring(struct mapped_device *md, int rw,
+			      struct buffer_head *bh)
+{
+	int r;
+
+	/*
+	 * If we're suspended we have to queue this io for later.
+	 */
+	while (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_read(&md->lock);
+
+		/*
+		 * There's no point deferring a read ahead
+		 * request, just drop it.
+		 */
+		if (rw == READA) {
+			down_read(&md->lock);
+			return -EIO;
+		}
+
+		r = queue_io(md, bh, rw);
+		down_read(&md->lock);
+
+		if (r < 0)
+			return r;
+
+		if (r == 0)
+			return 1;	/* deferred successfully */
+
+	}
+
+	return 0;
+}
+
+static int dm_request(request_queue_t *q, int rw, struct buffer_head *bh)
+{
+	int r;
+	struct dm_io *io;
+	struct mapped_device *md;
+
+	md = get_kdev(bh->b_rdev);
+	if (!md) {
+		buffer_IO_error(bh);
+		return 0;
+	}
+
+	io = alloc_io(md);
+	down_read(&md->lock);
+
+	r = __deferring(md, rw, bh);
+	if (r < 0)
+		goto bad;
+
+	else if (!r) {
+		/* not deferring */
+		r = __map_buffer(md, rw, bh, io);
+		if (r < 0)
+			goto bad;
+	} else
+		r = 0;
+
+	up_read(&md->lock);
+	dm_put(md);
+	return r;
+
+      bad:
+	buffer_IO_error(bh);
+	up_read(&md->lock);
+	dm_put(md);
+	return 0;
+}
+
+static int check_dev_size(kdev_t dev, unsigned long block)
+{
+	unsigned int major = major(dev);
+	unsigned int minor = minor(dev);
+
+	/* FIXME: check this */
+	unsigned long max_sector = (blk_size[major][minor] << 1) + 1;
+	unsigned long sector = (block + 1) * (blksize_size[major][minor] >> 9);
+
+	return (sector > max_sector) ? 0 : 1;
+}
+
+/*
+ * Creates a dummy buffer head and maps it (for lilo).
+ */
+static int __bmap(struct mapped_device *md, kdev_t dev, unsigned long block,
+		  kdev_t *r_dev, unsigned long *r_block)
+{
+	struct buffer_head bh;
+	struct dm_target *ti;
+	union map_info map_context;
+	int r;
+
+	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		return -EPERM;
+	}
+
+	if (!check_dev_size(dev, block)) {
+		return -EINVAL;
+	}
+
+	if (!md->map)
+		return -EINVAL;
+
+	/* setup dummy bh */
+	memset(&bh, 0, sizeof(bh));
+	bh.b_blocknr = block;
+	bh.b_dev = bh.b_rdev = dev;
+	bh.b_size = blksize_size[major(dev)][minor(dev)];
+	bh.b_rsector = block * (bh.b_size >> 9);
+
+	/* find target */
+	ti = dm_table_find_target(md->map, bh.b_rsector);
+
+	/* do the mapping */
+	r = ti->type->map(ti, &bh, READ, &map_context);
+	ti->type->end_io(ti, &bh, READ, 0, &map_context);
+
+	if (!r) {
+		*r_dev = bh.b_rdev;
+		*r_block = bh.b_rsector / (bh.b_size >> 9);
+	}
+
+	return r;
+}
+
+/*
+ * Marshals arguments and results between user and kernel space.
+ */
+static int dm_user_bmap(struct inode *inode, struct lv_bmap *lvb)
+{
+	struct mapped_device *md;
+	unsigned long block, r_block;
+	kdev_t r_dev;
+	int r;
+
+	if (get_user(block, &lvb->lv_block))
+		return -EFAULT;
+
+	md = get_kdev(inode->i_rdev);
+	if (!md)
+		return -ENXIO;
+
+	down_read(&md->lock);
+	r = __bmap(md, inode->i_rdev, block, &r_dev, &r_block);
+	up_read(&md->lock);
+	dm_put(md);
+
+	if (!r && (put_user(kdev_t_to_nr(r_dev), &lvb->lv_dev) ||
+		   put_user(r_block, &lvb->lv_block)))
+		r = -EFAULT;
+
+	return r;
+}
+
+static void free_md(struct mapped_device *md)
+{
+	free_dev(md->dev);
+	mempool_destroy(md->io_pool);
+	kfree(md);
+}
+
+/*
+ * Allocate and initialise a blank device with a given minor.
+ */
+static struct mapped_device *alloc_md(kdev_t dev)
+{
+	int r;
+	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
+
+	if (!md) {
+		DMWARN("unable to allocate device, out of memory.");
+		return NULL;
+	}
+
+	memset(md, 0, sizeof(*md));
+
+	/* Allocate suitable device number */
+	if (!dev)
+		r = first_free_dev(md);
+	else
+		r = specific_dev(dev, md);
+
+	if (r) {
+		kfree(md);
+		return NULL;
+	}
+
+	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+				     mempool_free_slab, _io_cache);
+	if (!md->io_pool) {
+		free_md(md);
+		kfree(md);
+		return NULL;
+	}
+
+	init_rwsem(&md->lock);
+	atomic_set(&md->holders, 1);
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
+	return md;
+}
+
+/*
+ * The hardsect size for a mapped device is the largest hardsect size
+ * from the devices it maps onto.
+ */
+static int __find_hardsect_size(struct list_head *devices)
+{
+	int result = 512, size;
+	struct list_head *tmp;
+
+	list_for_each (tmp, devices) {
+		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+		size = get_hardsect_size(dd->dev);
+		if (size > result)
+			result = size;
+	}
+
+	return result;
+}
+
+/*
+ * Bind a table to the device.
+ */
+static void event_callback(void *context)
+{
+	struct mapped_device *md = (struct mapped_device *) context;
+
+	down_write(&md->lock);
+	md->event_nr++;
+	wake_up_interruptible(&md->eventq);
+	up_write(&md->lock);
+}
+
+static int __bind(struct mapped_device *md, struct dm_table *t)
+{
+	unsigned int minor = minor(md->dev);
+	unsigned int major = major(md->dev);
+	md->map = t;
+
+	/* in k */
+	blk_size[major][minor] = dm_table_get_size(t) >> 1;
+	blksize_size[major][minor] = BLOCK_SIZE;
+	hardsect_size[major][minor] =
+	    __find_hardsect_size(dm_table_get_devices(t));
+	register_disk(NULL, md->dev, 1, &dm_blk_dops, blk_size[major][minor]);
+
+	dm_table_event_callback(md->map, event_callback, md);
+	dm_table_get(t);
+	return 0;
+}
+
+static void __unbind(struct mapped_device *md)
+{
+	unsigned int minor = minor(md->dev);
+	unsigned int major = major(md->dev);
+
+	if (md->map) {
+		dm_table_event_callback(md->map, NULL, NULL);
+		dm_table_put(md->map);
+		md->map = NULL;
+
+	}
+
+	blk_size[major][minor] = 0;
+	blksize_size[major][minor] = 0;
+	hardsect_size[major][minor] = 0;
+}
+
+/*
+ * Constructor for a new device.
+ */
+int dm_create(kdev_t dev, struct mapped_device **result)
+{
+	struct mapped_device *md;
+
+	md = alloc_md(dev);
+	if (!md)
+		return -ENXIO;
+
+	__unbind(md);	/* Ensure zero device size */
+
+	*result = md;
+	return 0;
+}
+
+void dm_get(struct mapped_device *md)
+{
+	atomic_inc(&md->holders);
+}
+
+void dm_put(struct mapped_device *md)
+{
+	if (atomic_dec_and_test(&md->holders)) {
+		if (md->map)
+			dm_table_suspend_targets(md->map);
+		__unbind(md);
+		free_md(md);
+	}
+}
+
+/*
+ * Requeue the deferred io by calling generic_make_request.
+ */
+static void flush_deferred_io(struct deferred_io *c)
+{
+	struct deferred_io *n;
+
+	while (c) {
+		n = c->next;
+		generic_make_request(c->rw, c->bh);
+		free_deferred(c);
+		c = n;
+	}
+}
+
+/*
+ * Swap in a new table (destroying old one).
+ */
+int dm_swap_table(struct mapped_device *md, struct dm_table *table)
+{
+	int r;
+
+	down_write(&md->lock);
+
+	/*
+	 * The device must be suspended, or have no table bound yet.
+	 */
+	if (md->map && !test_bit(DMF_SUSPENDED, &md->flags)) {
+		up_write(&md->lock);
+		return -EPERM;
+	}
+
+	__unbind(md);
+	r = __bind(md, table);
+	if (r)
+		return r;
+
+	up_write(&md->lock);
+	return 0;
+}
+
+/*
+ * We need to be able to change a mapping table under a mounted
+ * filesystem.  For example we might want to move some data in
+ * the background.  Before the table can be swapped with
+ * dm_bind_table, dm_suspend must be called to flush any in
+ * flight io and ensure that any further io gets deferred.
+ */
+int dm_suspend(struct mapped_device *md)
+{
+	int r = 0;
+	DECLARE_WAITQUEUE(wait, current);
+
+	down_write(&md->lock);
+
+	/*
+	 * First we set the BLOCK_IO flag so no more ios will be
+	 * mapped.
+	 */
+	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_write(&md->lock);
+		return -EINVAL;
+	}
+
+	set_bit(DMF_BLOCK_IO, &md->flags);
+	add_wait_queue(&md->wait, &wait);
+	up_write(&md->lock);
+
+	/*
+	 * Then we wait for the already mapped ios to
+	 * complete.
+	 */
+	run_task_queue(&tq_disk);
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (!atomic_read(&md->pending) || signal_pending(current))
+			break;
+
+		schedule();
+	}
+	set_current_state(TASK_RUNNING);
+
+	down_write(&md->lock);
+	remove_wait_queue(&md->wait, &wait);
+
+	/* did we flush everything ? */
+	if (atomic_read(&md->pending)) {
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		r = -EINTR;
+	} else {
+		set_bit(DMF_SUSPENDED, &md->flags);
+		if (md->map)
+			dm_table_suspend_targets(md->map);
+	}
+	up_write(&md->lock);
+
+	return r;
+}
+
+int dm_resume(struct mapped_device *md)
+{
+	struct deferred_io *def;
+
+	down_write(&md->lock);
+	if (!test_bit(DMF_SUSPENDED, &md->flags)) {
+		up_write(&md->lock);
+		return -EINVAL;
+	}
+
+	if (md->map)
+		dm_table_resume_targets(md->map);
+
+	clear_bit(DMF_SUSPENDED, &md->flags);
+	clear_bit(DMF_BLOCK_IO, &md->flags);
+	def = md->deferred;
+	md->deferred = NULL;
+	up_write(&md->lock);
+
+	flush_deferred_io(def);
+	run_task_queue(&tq_disk);
+
+	return 0;
+}
+
+struct dm_table *dm_get_table(struct mapped_device *md)
+{
+	struct dm_table *t;
+
+	down_read(&md->lock);
+	t = md->map;
+	if (t)
+		dm_table_get(t);
+	up_read(&md->lock);
+
+	return t;
+}
+
+/*-----------------------------------------------------------------
+ * Event notification.
+ *---------------------------------------------------------------*/
+uint32_t dm_get_event_nr(struct mapped_device *md)
+{
+	uint32_t r;
+
+	down_read(&md->lock);
+	r = md->event_nr;
+	up_read(&md->lock);
+
+	return r;
+}
+
+int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
+		      uint32_t event_nr)
+{
+	down_write(&md->lock);
+	if (event_nr != md->event_nr) {
+		up_write(&md->lock);
+		return 1;
+	}
+
+	add_wait_queue(&md->eventq, wq);
+	up_write(&md->lock);
+
+	return 0;
+}
+
+const char *dm_kdevname(kdev_t dev)
+{
+	static char buffer[32];
+	sprintf(buffer, "%03d:%03d", MAJOR(dev), MINOR(dev));
+	return buffer;
+}
+
+void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq)
+{
+	down_write(&md->lock);
+	remove_wait_queue(&md->eventq, wq);
+	up_write(&md->lock);
+}
+
+kdev_t dm_kdev(struct mapped_device *md)
+{
+	kdev_t dev;
+
+	down_read(&md->lock);
+	dev = md->dev;
+	up_read(&md->lock);
+
+	return dev;
+}
+
+int dm_suspended(struct mapped_device *md)
+{
+	return test_bit(DMF_SUSPENDED, &md->flags);
+}
+
+struct block_device_operations dm_blk_dops = {
+	.open = dm_blk_open,
+	.release = dm_blk_close,
+	.ioctl = dm_blk_ioctl,
+	.owner = THIS_MODULE
+};
+
+/*
+ * module hooks
+ */
+module_init(dm_init);
+module_exit(dm_exit);
+
+MODULE_DESCRIPTION(DM_NAME " driver");
+MODULE_AUTHOR("Joe Thornber <thornber@sistina.com>");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(dm_kdevname);
--- diff/drivers/md/dm.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm.h	2003-12-09 10:56:38.000000000 +0000
@@ -0,0 +1,172 @@
+/*
+ * Internal header file for device mapper
+ *
+ * Copyright (C) 2001, 2002 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef DM_INTERNAL_H
+#define DM_INTERNAL_H
+
+#include <linux/fs.h>
+#include <linux/device-mapper.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+
+#define DM_NAME "device-mapper"
+#define DMWARN(f, x...) printk(KERN_WARNING DM_NAME ": " f "\n" , ## x)
+#define DMERR(f, x...) printk(KERN_ERR DM_NAME ": " f "\n" , ## x)
+#define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
+
+/*
+ * FIXME: I think this should be with the definition of sector_t
+ * in types.h.
+ */
+#ifdef CONFIG_LBD
+#define SECTOR_FORMAT "%Lu"
+#else
+#define SECTOR_FORMAT "%lu"
+#endif
+
+#define SECTOR_SHIFT 9
+#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+
+extern struct block_device_operations dm_blk_dops;
+
+/*
+ * List of devices that a metadevice uses and should open/close.
+ */
+struct dm_dev {
+	struct list_head list;
+
+	atomic_t count;
+	int mode;
+	kdev_t dev;
+	struct block_device *bdev;
+};
+
+struct dm_table;
+struct mapped_device;
+
+/*-----------------------------------------------------------------
+ * Functions for manipulating a struct mapped_device.
+ * Drop the reference with dm_put when you finish with the object.
+ *---------------------------------------------------------------*/
+int dm_create(kdev_t dev, struct mapped_device **md);
+
+/*
+ * Reference counting for md.
+ */
+void dm_get(struct mapped_device *md);
+void dm_put(struct mapped_device *md);
+
+/*
+ * A device can still be used while suspended, but I/O is deferred.
+ */
+int dm_suspend(struct mapped_device *md);
+int dm_resume(struct mapped_device *md);
+
+/*
+ * The device must be suspended before calling this method.
+ */
+int dm_swap_table(struct mapped_device *md, struct dm_table *t);
+
+/*
+ * Drop a reference on the table when you've finished with the
+ * result.
+ */
+struct dm_table *dm_get_table(struct mapped_device *md);
+
+/*
+ * Event functions.
+ */
+uint32_t dm_get_event_nr(struct mapped_device *md);
+int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
+		      uint32_t event_nr);
+void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq);
+
+/*
+ * Info functions.
+ */
+kdev_t dm_kdev(struct mapped_device *md);
+int dm_suspended(struct mapped_device *md);
+
+/*-----------------------------------------------------------------
+ * Functions for manipulating a table.  Tables are also reference
+ * counted.
+ *---------------------------------------------------------------*/
+int dm_table_create(struct dm_table **result, int mode, unsigned num_targets);
+
+void dm_table_get(struct dm_table *t);
+void dm_table_put(struct dm_table *t);
+
+int dm_table_add_target(struct dm_table *t, const char *type,
+			sector_t start,	sector_t len, char *params);
+int dm_table_complete(struct dm_table *t);
+void dm_table_event_callback(struct dm_table *t,
+			     void (*fn)(void *), void *context);
+void dm_table_event(struct dm_table *t);
+sector_t dm_table_get_size(struct dm_table *t);
+struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index);
+struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector);
+unsigned int dm_table_get_num_targets(struct dm_table *t);
+struct list_head *dm_table_get_devices(struct dm_table *t);
+int dm_table_get_mode(struct dm_table *t);
+void dm_table_suspend_targets(struct dm_table *t);
+void dm_table_resume_targets(struct dm_table *t);
+
+/*-----------------------------------------------------------------
+ * A registry of target types.
+ *---------------------------------------------------------------*/
+int dm_target_init(void);
+void dm_target_exit(void);
+struct target_type *dm_get_target_type(const char *name);
+void dm_put_target_type(struct target_type *t);
+
+
+/*-----------------------------------------------------------------
+ * Useful inlines.
+ *---------------------------------------------------------------*/
+static inline int array_too_big(unsigned long fixed, unsigned long obj,
+				unsigned long num)
+{
+	return (num > (ULONG_MAX - fixed) / obj);
+}
+
+/*
+ * ceiling(n / size) * size
+ */
+static inline unsigned long dm_round_up(unsigned long n, unsigned long size)
+{
+	unsigned long r = n % size;
+	return n + (r ? (size - r) : 0);
+}
+
+/*
+ * Ceiling(n / size)
+ */
+static inline unsigned long dm_div_up(unsigned long n, unsigned long size)
+{
+	return dm_round_up(n, size) / size;
+}
+
+const char *dm_kdevname(kdev_t dev);
+
+/*
+ * The device-mapper can be driven through one of two interfaces;
+ * ioctl or filesystem, depending which patch you have applied.
+ */
+int dm_interface_init(void);
+void dm_interface_exit(void);
+
+/*
+ * Targets for linear and striped mappings
+ */
+int dm_linear_init(void);
+void dm_linear_exit(void);
+
+int dm_stripe_init(void);
+void dm_stripe_exit(void);
+
+#endif
--- diff/include/linux/device-mapper.h	1970-01-01 01:00:00.000000000 +0100
+++ source/include/linux/device-mapper.h	2003-12-09 10:39:56.000000000 +0000
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef _LINUX_DEVICE_MAPPER_H
+#define _LINUX_DEVICE_MAPPER_H
+
+typedef unsigned long sector_t;
+
+struct dm_target;
+struct dm_table;
+struct dm_dev;
+
+typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE } status_type_t;
+
+union map_info {
+	void *ptr;
+	unsigned long long ll;
+};
+
+/*
+ * In the constructor the target parameter will already have the
+ * table, type, begin and len fields filled in.
+ */
+typedef int (*dm_ctr_fn) (struct dm_target * target, unsigned int argc,
+			  char **argv);
+
+/*
+ * The destructor doesn't need to free the dm_target, just
+ * anything hidden ti->private.
+ */
+typedef void (*dm_dtr_fn) (struct dm_target * ti);
+
+/*
+ * The map function must return:
+ * < 0: error
+ * = 0: The target will handle the io by resubmitting it later
+ * > 0: simple remap complete
+ */
+typedef int (*dm_map_fn) (struct dm_target * ti, struct buffer_head * bh,
+			  int rw, union map_info *map_context);
+
+/*
+ * Returns:
+ * < 0 : error (currently ignored)
+ * 0   : ended successfully
+ * 1   : for some reason the io has still not completed (eg,
+ *       multipath target might want to requeue a failed io).
+ */
+typedef int (*dm_endio_fn) (struct dm_target * ti,
+			    struct buffer_head * bh, int rw, int error,
+			    union map_info *map_context);
+typedef void (*dm_suspend_fn) (struct dm_target *ti);
+typedef void (*dm_resume_fn) (struct dm_target *ti);
+typedef int (*dm_status_fn) (struct dm_target * ti, status_type_t status_type,
+			     char *result, unsigned int maxlen);
+
+void dm_error(const char *message);
+
+/*
+ * Constructors should call these functions to ensure destination devices
+ * are opened/closed correctly.
+ * FIXME: too many arguments.
+ */
+int dm_get_device(struct dm_target *ti, const char *path, sector_t start,
+		  sector_t len, int mode, struct dm_dev **result);
+void dm_put_device(struct dm_target *ti, struct dm_dev *d);
+
+/*
+ * Information about a target type
+ */
+struct target_type {
+	const char *name;
+	struct module *module;
+	dm_ctr_fn ctr;
+	dm_dtr_fn dtr;
+	dm_map_fn map;
+	dm_endio_fn end_io;
+	dm_suspend_fn suspend;
+	dm_resume_fn resume;
+	dm_status_fn status;
+};
+
+struct dm_target {
+	struct dm_table *table;
+	struct target_type *type;
+
+	/* target limits */
+	sector_t begin;
+	sector_t len;
+
+	/* target specific data */
+	void *private;
+
+	/* Used to provide an error string from the ctr */
+	char *error;
+};
+
+int dm_register_target(struct target_type *t);
+int dm_unregister_target(struct target_type *t);
+
+#endif				/* _LINUX_DEVICE_MAPPER_H */
