Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263345AbSJORlW>; Tue, 15 Oct 2002 13:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264718AbSJORlV>; Tue, 15 Oct 2002 13:41:21 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:39186 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263345AbSJORj3>; Tue, 15 Oct 2002 13:39:29 -0400
Date: Tue, 15 Oct 2002 18:45:25 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] Device-mapper submission 3/7
Message-ID: <20021015174525.GC27753@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Device-mapper]
The core of the device-mapper driver.  No interface or target types
included as yet.

--- a/MAINTAINERS	Tue Oct 15 18:24:34 2002
+++ b/MAINTAINERS	Tue Oct 15 18:24:34 2002
@@ -996,6 +996,13 @@
 W:	http://www.sistina.com/lvm
 S:	Maintained 
 
+DEVICE-MAPPER
+P:	Joe Thornber
+M:	dm@uk.sistina.com
+L:	linux-lvm@sistina.com
+W:	http://www.sistina.com/lvm
+S:	Maintained
+
 LSILOGIC/SYMBIOS/NCR 53C8XX and 53C1010 PCI-SCSI drivers
 P:	Gerard Roudier
 M:	groudier@free.fr
--- a/drivers/md/Config.help	Tue Oct 15 18:24:34 2002
+++ b/drivers/md/Config.help	Tue Oct 15 18:24:34 2002
@@ -122,3 +122,15 @@
 
   If unsure, say N.
 
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
--- a/drivers/md/Config.in	Tue Oct 15 18:24:34 2002
+++ b/drivers/md/Config.in	Tue Oct 15 18:24:34 2002
@@ -14,5 +14,6 @@
 dep_tristate '  Multipath I/O support' CONFIG_MD_MULTIPATH $CONFIG_BLK_DEV_MD
 
 dep_tristate ' Logical volume manager (LVM) support' CONFIG_BLK_DEV_LVM $CONFIG_MD
+dep_tristate ' Device mapper support' CONFIG_BLK_DEV_DM $CONFIG_MD
 
 endmenu
--- a/drivers/md/Makefile	Tue Oct 15 18:24:34 2002
+++ b/drivers/md/Makefile	Tue Oct 15 18:24:34 2002
@@ -2,8 +2,9 @@
 # Makefile for the kernel software RAID and LVM drivers.
 #
 
-export-objs	:= md.o xor.o
+export-objs	:= md.o xor.o dm-table.o dm-target.o
 lvm-mod-objs	:= lvm.o lvm-snap.o lvm-fs.o
+dm-mod-objs	:= dm.o dm-hash.o dm-table.o dm-target.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
@@ -17,6 +18,7 @@
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_LVM)	+= lvm-mod.o
+obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 
 include $(TOPDIR)/Rules.make
 
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-hash.c	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,402 @@
+/*
+ * Copyright (C) 2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+/*
+ * We need to be able to quickly return the struct mapped_device,
+ * whether it is looked up by name, uuid or by kdev_t.  Note that
+ * multiple major numbers are now supported, so we cannot keep
+ * things simple by putting them in an array.
+ *
+ * Instead this will be implemented as a trio of closely coupled
+ * hash tables.
+ */
+
+#include <linux/list.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+
+#include "dm.h"
+
+struct hash_cell {
+	struct list_head list;
+	struct mapped_device *md;
+};
+
+#define NUM_BUCKETS 64
+#define MASK_BUCKETS (NUM_BUCKETS - 1)
+#define HASH_MULT 2654435387U
+static struct list_head *_dev_buckets;
+static struct list_head *_name_buckets;
+static struct list_head *_uuid_buckets;
+
+/*
+ * Guards access to all three tables.
+ */
+static DECLARE_RWSEM(_hash_lock);
+
+
+/*-----------------------------------------------------------------
+ * Init/exit code
+ *---------------------------------------------------------------*/
+void dm_hash_exit(void)
+{
+	kfree(_dev_buckets);
+	kfree(_name_buckets);
+	kfree(_uuid_buckets);
+}
+
+static struct list_head *alloc_buckets(void)
+{
+	struct list_head *buckets;
+	unsigned int i, len;
+
+	len = NUM_BUCKETS * sizeof(struct list_head);
+	buckets = kmalloc(len, GFP_KERNEL);
+	if (buckets)
+		for (i = 0; i < NUM_BUCKETS; i++)
+			INIT_LIST_HEAD(buckets + i);
+
+	return buckets;
+}
+
+int dm_hash_init(void)
+{
+	_dev_buckets = alloc_buckets();
+	if (!_dev_buckets)
+		goto bad;
+
+	_name_buckets = alloc_buckets();
+	if (!_name_buckets)
+		goto bad;
+
+	_uuid_buckets = alloc_buckets();
+	if (!_uuid_buckets)
+		goto bad;
+
+	return 0;
+
+ bad:
+	dm_hash_exit();
+	return -ENOMEM;
+}
+
+
+/*-----------------------------------------------------------------
+ * Hash functions
+ *---------------------------------------------------------------*/
+static inline unsigned int hash_dev(kdev_t dev)
+{
+	return (HASHDEV(dev) * HASH_MULT) & MASK_BUCKETS;
+}
+
+/*
+ * We're not really concerned with the str hash function being
+ * fast since it's only used by the ioctl interface.
+ */
+static unsigned int hash_str(const char *str)
+{
+	unsigned int h = 0;
+
+	while (*str)
+		h = (h + (unsigned int) *str++) * HASH_MULT;
+
+	return h & MASK_BUCKETS;
+}
+
+
+/*-----------------------------------------------------------------
+ * Code for looking up the device by kdev_t.
+ *---------------------------------------------------------------*/
+static struct hash_cell *__get_dev_cell(kdev_t dev)
+{
+	struct list_head *tmp;
+	struct hash_cell *hc;
+	unsigned int h = hash_dev(dev);
+
+	list_for_each (tmp, _dev_buckets + h) {
+		hc = list_entry(tmp, struct hash_cell, list);
+		if (kdev_same(hc->md->dev, dev))
+			return hc;
+	}
+
+	return NULL;
+}
+
+struct mapped_device *dm_get_r(kdev_t dev)
+{
+	struct hash_cell *hc;
+	struct mapped_device *md = NULL;
+
+	down_read(&_hash_lock);
+	hc = __get_dev_cell(dev);
+	if (hc && test_bit(DMF_VALID, &hc->md->flags)) {
+		md = hc->md;
+		down_read(&md->lock);
+	}
+	up_read(&_hash_lock);
+
+	return md;
+}
+
+struct mapped_device *dm_get_w(kdev_t dev)
+{
+	struct hash_cell *hc;
+	struct mapped_device *md = NULL;
+
+	down_read(&_hash_lock);
+	hc = __get_dev_cell(dev);
+	if (hc && test_bit(DMF_VALID, &hc->md->flags)) {
+		md = hc->md;
+		down_write(&md->lock);
+	}
+	up_read(&_hash_lock);
+
+	return md;
+}
+
+
+/*-----------------------------------------------------------------
+ * Code for looking up a device by name
+ *---------------------------------------------------------------*/
+static int namecmp(struct mapped_device *md, const char *str, int uuid)
+{
+	if (!uuid)
+		return strcmp(md->name, str);
+
+	if (!md->uuid)
+		return -1;	/* never equal */
+
+	return strcmp(md->uuid, str);
+}
+
+static struct hash_cell *__get_str_cell(const char *str, int uuid)
+{
+	struct list_head *tmp, *buckets;
+	struct hash_cell *hc;
+	unsigned int h = hash_str(str);
+
+	buckets = uuid ? _uuid_buckets : _name_buckets;
+	list_for_each (tmp, buckets + h) {
+		hc = list_entry(tmp, struct hash_cell, list);
+		if (!namecmp(hc->md, str, uuid))
+			return hc;
+	}
+
+	return NULL;
+}
+
+static inline struct mapped_device *get_name(const char *str,
+					     int uuid, int write)
+{
+	struct hash_cell *hc;
+	struct mapped_device *md = NULL;
+
+	down_read(&_hash_lock);
+	hc = __get_str_cell(str, uuid);
+	if (hc && test_bit(DMF_VALID, &hc->md->flags)) {
+		md = hc->md;
+		if (write)
+			down_write(&md->lock);
+		else
+			down_read(&md->lock);
+	}
+	up_read(&_hash_lock);
+
+	return md;
+}
+
+struct mapped_device *dm_get_name_r(const char *name)
+{
+	return get_name(name, 0, 0);
+}
+
+struct mapped_device *dm_get_name_w(const char *name)
+{
+	return get_name(name, 0, 1);
+}
+
+struct mapped_device *dm_get_uuid_r(const char *uuid)
+{
+	return get_name(uuid, 1, 0);
+}
+
+struct mapped_device *dm_get_uuid_w(const char *uuid)
+{
+	return get_name(uuid, 1, 1);
+}
+
+/*-----------------------------------------------------------------
+ * Inserting and removing and renaming a device.
+ *---------------------------------------------------------------*/
+static struct hash_cell *alloc_cell(struct mapped_device *md)
+{
+	struct hash_cell *hc = kmalloc(sizeof(*hc), GFP_KERNEL);
+	if (hc) {
+		INIT_LIST_HEAD(&hc->list);
+		hc->md = md;
+	}
+
+	return hc;
+}
+
+/*
+ * The kdev_t and uuid of a device can never change once it is
+ * initially inserted.
+ */
+int dm_hash_insert(struct mapped_device *md)
+{
+	struct hash_cell *dev_cell, *name_cell, *uuid_cell;
+
+	/*
+	 * Allocate the new cells.
+	 */
+	dev_cell = name_cell = uuid_cell = NULL;
+	if (!(dev_cell = alloc_cell(md)) ||
+	    !(name_cell = alloc_cell(md)) ||
+	    !(uuid_cell = alloc_cell(md))) {
+		kfree(uuid_cell);
+		kfree(name_cell);
+		kfree(dev_cell);
+
+		return -ENOMEM;
+	}
+
+	/*
+	 * Insert the cell into all three hash tables.
+	 */
+	down_write(&_hash_lock);
+	if (__get_dev_cell(md->dev))
+		goto bad;
+
+	list_add(&dev_cell->list, _dev_buckets + hash_dev(md->dev));
+
+	if (__get_str_cell(md->name, 0)) {
+		list_del(&dev_cell->list);
+		goto bad;
+	}
+	list_add(&name_cell->list, _name_buckets + hash_str(md->name));
+
+	if (md->uuid) {
+		if (__get_str_cell(md->uuid, 1)) {
+			list_del(&name_cell->list);
+			list_del(&dev_cell->list);
+			goto bad;
+		}
+		list_add(&uuid_cell->list, _uuid_buckets + hash_str(md->uuid));
+	}
+	up_write(&_hash_lock);
+
+	if (!md->uuid)
+		kfree(uuid_cell);
+
+	return 0;
+
+ bad:
+	up_write(&_hash_lock);
+	kfree(uuid_cell);
+	kfree(name_cell);
+	kfree(dev_cell);
+	return -EBUSY;
+}
+
+static void dispose_cell(struct hash_cell *hc)
+{
+	list_del(&hc->list);
+	kfree(hc);
+}
+
+/*
+ * md should already have the write lock.
+ */
+void dm_hash_remove(struct mapped_device *md)
+{
+	struct hash_cell *hc;
+
+	/*
+	 * This looks nasty, but is neccessary to avoid a
+	 * deadlock.  If some other process (eg, the main request
+	 * loop), is blocking on a down of md->lock, this will
+	 * let them get it and finish their stuff.
+	 */
+	up_write(&md->lock);
+	down_write(&_hash_lock);
+	down_write(&md->lock);
+
+	/* remove from the dev hash */
+	hc = __get_dev_cell(md->dev);
+	if (!hc)
+		DMWARN("device doesn't appear to be in the dev hash table.");
+	else
+		dispose_cell(hc);
+
+	/* remove from the name hash */
+	hc = __get_str_cell(md->name, 0);
+	if (!hc)
+		DMWARN("device doesn't appear to be in the name hash table.");
+	else
+		dispose_cell(hc);
+
+	/* remove from the uuid hash, if it has a uuid */
+	if (md->uuid) {
+		hc = __get_str_cell(md->uuid, 1);
+		if (!hc)
+			DMWARN("device doesn't appear to be in the uuid "
+			       "hash table.");
+		else
+			dispose_cell(hc);
+	}
+
+	up_write(&_hash_lock);
+}
+
+int dm_hash_rename(const char *old, const char *new)
+{
+	char *new_name, *old_name;
+	struct hash_cell *hc;
+
+	/*
+	 * duplicate new.
+	 */
+	new_name = dm_strdup(new);
+	if (!new_name)
+		return -ENOMEM;
+
+	down_write(&_hash_lock);
+
+	/*
+	 * Is new free ?
+	 */
+	hc = __get_str_cell(new, 0);
+	if (hc) {
+		DMWARN("asked to rename to an already existing name %s -> %s",
+		       old, new);
+		up_write(&_hash_lock);
+		return -EBUSY;
+	}
+
+	/*
+	 * Is there such a device as 'old' ?
+	 */
+	hc = __get_str_cell(old, 0);
+	if (!hc) {
+		DMWARN("asked to rename a non existent device %s -> %s",
+		       old, new);
+		up_write(&_hash_lock);
+		return -ENXIO;
+	}
+
+	/*
+	 * rename and move the name cell.
+	 */
+	list_del(&hc->list);
+	old_name = hc->md->name;
+	hc->md->name = new_name;
+	list_add(&hc->list, _name_buckets + hash_str(new_name));
+
+	up_write(&_hash_lock);
+	kfree(old_name);
+	return 0;
+}
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-table.c	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,524 @@
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
+#include <linux/namei.h>
+
+/*
+ * Ceiling(n / size)
+ */
+static inline unsigned long div_up(unsigned long n, unsigned long size)
+{
+	return dm_round_up(n, size) / size;
+}
+
+/*
+ * Similar to ceiling(log_size(n))
+ */
+static unsigned int int_log(unsigned long n, unsigned long base)
+{
+	int result = 0;
+
+	while (n > 1) {
+		n = div_up(n, base);
+		result++;
+	}
+
+	return result;
+}
+
+#define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
+#define __LOW(l, r) if (*(l) < (r)) *(l) = (r)
+
+/*
+ * Combine two io_restrictions, always taking the lower value.
+ */
+
+static void combine_restrictions_low(struct io_restrictions *lhs,
+				     struct io_restrictions *rhs)
+{
+   __LOW(&lhs->max_sectors, rhs->max_sectors);
+   __LOW(&lhs->max_phys_segments, rhs->max_phys_segments);
+   __LOW(&lhs->max_hw_segments, rhs->max_hw_segments);
+   __HIGH(&lhs->hardsect_size, rhs->hardsect_size);
+   __LOW(&lhs->max_segment_size, rhs->max_segment_size);
+   __LOW(&lhs->seg_boundary_mask, rhs->seg_boundary_mask);
+}
+
+/*
+ * Return the highest key that you could lookup from the n'th
+ * node on level l of the btree.
+ */
+static sector_t high(struct dm_table *t, int l, int n)
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
+static int setup_btree_index(int l, struct dm_table *t)
+{
+	int n, k;
+	sector_t *node;
+
+	for (n = 0; n < t->counts[l]; n++) {
+		node = get_node(t, l, n);
+
+		for (k = 0; k < KEYS_PER_NODE; k++)
+			node[k] = high(t, l + 1, get_child(n, k));
+	}
+
+	return 0;
+}
+
+/*
+ * highs, and targets are managed as dynamic arrays during a
+ * table load.
+ */
+static int alloc_targets(struct dm_table *t, int num)
+{
+	sector_t *n_highs;
+	struct dm_target *n_targets;
+	int n = t->num_targets;
+
+	/*
+	 * Allocate both the target array and offset array at once.
+	 */
+	n_highs = (sector_t *) vcalloc(sizeof(struct dm_target) +
+				       sizeof(sector_t),
+				       num);
+	if (!n_highs)
+		return -ENOMEM;
+
+	n_targets = (struct dm_target *) (n_highs + num);
+
+	if (n) {
+		memcpy(n_highs, t->highs, sizeof(*n_highs) * n);
+		memcpy(n_targets, t->targets, sizeof(*n_targets) * n);
+	}
+
+	memset(n_highs + n, -1, sizeof(*n_highs) * (num - n));
+	vfree(t->highs);
+
+	t->num_allocated = num;
+	t->highs = n_highs;
+	t->targets = n_targets;
+
+	return 0;
+}
+
+int dm_table_create(struct dm_table **result, int mode)
+{
+	struct dm_table *t = kmalloc(sizeof(*t), GFP_NOIO);
+
+	if (!t)
+		return -ENOMEM;
+
+	memset(t, 0, sizeof(*t));
+	INIT_LIST_HEAD(&t->devices);
+
+	/* allocate a single nodes worth of targets to begin with */
+	if (alloc_targets(t, KEYS_PER_NODE)) {
+		kfree(t);
+		t = NULL;
+		return -ENOMEM;
+	}
+
+	init_waitqueue_head(&t->eventq);
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
+void dm_table_destroy(struct dm_table *t)
+{
+	int i;
+
+	/* destroying the table counts as an event */
+	dm_table_event(t);
+
+	/* free the indexes (see dm_table_complete) */
+	if (t->depth >= 2)
+		vfree(t->index[t->depth - 2]);
+
+	/* free the targets */
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *tgt = &t->targets[i];
+
+		dm_put_target_type(t->targets[i].type);
+
+		if (tgt->type->dtr)
+			tgt->type->dtr(tgt);
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
+/*
+ * Checks to see if we need to extend highs or targets.
+ */
+static inline int check_space(struct dm_table *t)
+{
+	if (t->num_targets >= t->num_allocated)
+		return alloc_targets(t, t->num_allocated * 2);
+
+	return 0;
+}
+
+/*
+ * Convert a device path to a kdev_t.
+ */
+static int lookup_device(const char *path, kdev_t *dev)
+{
+	int r;
+	struct nameidata nd;
+	struct inode *inode;
+
+	if ((r = path_lookup(path, LOOKUP_FOLLOW, &nd)))
+		return r;
+
+	inode = nd.dentry->d_inode;
+	if (!inode) {
+		r = -ENOENT;
+		goto out;
+	}
+
+	if (!S_ISBLK(inode->i_mode)) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	*dev = inode->i_rdev;
+
+ out:
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
+static int open_dev(struct dm_dev *d)
+{
+	static char *_claim_ptr = "I belong to device-mapper";
+
+	int r;
+
+	if (d->bdev)
+		BUG();
+
+	if (!(d->bdev = bdget(kdev_t_to_nr(d->dev))))
+		return -ENOMEM;
+
+	r = blkdev_get(d->bdev, d->mode, 0, BDEV_RAW);
+	if (!r)
+		return r;
+
+	r = bd_claim(d->bdev, _claim_ptr);
+	if (r) {
+		blkdev_put(d->bdev, BDEV_RAW);
+		d->bdev = NULL;
+	}
+
+	return r;
+}
+
+/*
+ * Close a device that we've been using.
+ */
+static void close_dev(struct dm_dev *d)
+{
+	if (!d->bdev)
+		return;
+
+	bd_release(d->bdev);
+	blkdev_put(d->bdev, BDEV_RAW);
+	d->bdev = NULL;
+}
+
+/*
+ * If possible (ie. blk_size[major] is set), this checks an area
+ * of a destination device is valid.
+ */
+static int check_device_area(struct dm_dev *dd, sector_t start, sector_t len)
+{
+	sector_t dev_size;
+	dev_size = dd->bdev->bd_inode->i_size;
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
+static int __table_get_device(struct dm_table *t, struct dm_target *ti,
+			      const char *path, sector_t start, sector_t len,
+			      int mode, struct dm_dev **result)
+{
+	int r;
+	kdev_t dev;
+	struct dm_dev *dd;
+	int major, minor;
+
+	if (!t)
+		BUG();
+
+	if (sscanf(path, "%x:%x", &major, &minor) == 2) {
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
+		dd->mode = mode;
+		dd->dev = dev;
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
+	if (!check_device_area(dd, start, len)) {
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
+
+int dm_get_device(struct dm_target *ti, const char *path, sector_t start,
+		  sector_t len, int mode, struct dm_dev **result)
+{
+	int r = __table_get_device(ti->table, ti, path,
+				   start, len, mode, result);
+	if (!r) {
+		request_queue_t *q = bdev_get_queue((*result)->bdev);
+		struct io_restrictions *rs = &ti->limits;
+
+		/* combine the device limits low */
+		__LOW(&rs->max_sectors, q->max_sectors);
+		__LOW(&rs->max_phys_segments, q->max_phys_segments);
+		__LOW(&rs->max_hw_segments, q->max_hw_segments);
+		__HIGH(&rs->hardsect_size, q->hardsect_size);
+		__LOW(&rs->max_segment_size, q->max_segment_size);
+		__LOW(&rs->seg_boundary_mask, q->seg_boundary_mask);
+	}
+
+	return r;
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
+ * Adds a target to the map.
+ */
+int dm_table_add_target(struct dm_table *t, struct dm_target *ti)
+{
+	int r, n;
+
+	/*
+	 * Does this target adjoin the previous one ?
+	 */
+	if (!adjoin(t, ti)) {
+		DMERR("Gap in table");
+		return -EINVAL;
+	}
+
+	/*
+	 * All targets must be multiples of the page size in length.
+	 */
+	if (ti->len & ((PAGE_SIZE / SECTOR_SIZE) - 1)) {
+		DMERR("Target is not page size (%lu) aligned.", PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	if ((r = check_space(t)))
+		return r;
+
+	n = t->num_targets++;
+	t->highs[n] = ti->begin + ti->len - 1;
+	memcpy(t->targets + n, ti, sizeof(*ti));
+
+	/* FIXME: the plan is to combine high here and then have
+	 * the merge fn apply the target level restrictions. */
+	combine_restrictions_low(&t->limits, &ti->limits);
+
+	return 0;
+}
+
+static int setup_indexes(struct dm_table *t)
+{
+	int i, total = 0;
+	sector_t *indexes;
+
+	/* allocate the space for *all* the indexes */
+	for (i = t->depth - 2; i >= 0; i--) {
+		t->counts[i] = div_up(t->counts[i + 1], CHILDREN_PER_NODE);
+		total += t->counts[i];
+	}
+
+	indexes = (sector_t *) vcalloc(total, (unsigned long) NODE_SIZE);
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
+	int leaf_nodes, r = 0;
+
+	/* how many indexes will the btree have ? */
+	leaf_nodes = div_up(t->num_targets, KEYS_PER_NODE);
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
+void dm_table_event(struct dm_table *t)
+{
+	wake_up_interruptible(&t->eventq);
+}
+
+EXPORT_SYMBOL(dm_get_device);
+EXPORT_SYMBOL(dm_put_device);
+EXPORT_SYMBOL(dm_table_event);
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-target.c	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,242 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/kmod.h>
+#include <linux/bio.h>
+
+struct tt_internal {
+	struct target_type tt;
+
+	struct list_head list;
+	long use;
+};
+
+static LIST_HEAD(_targets);
+static rwlock_t _lock = RW_LOCK_UNLOCKED;
+
+#define DM_MOD_NAME_SIZE 32
+
+/*
+ * Destructively splits up the argument list to pass to ctr.
+ */
+int split_args(int max, int *argc, char **argv, char *input)
+{
+	char *start, *end = input, *out;
+	*argc = 0;
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
+		if ((*argc + 1) > max)
+			return -EINVAL;
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
+	return 0;
+}
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
+	read_lock(&_lock);
+	ti = __find_target_type(name);
+
+	if (ti) {
+		if (ti->use == 0 && ti->tt.module)
+			__MOD_INC_USE_COUNT(ti->tt.module);
+		ti->use++;
+	}
+	read_unlock(&_lock);
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
+
+	return;
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
+	read_lock(&_lock);
+	if (--ti->use == 0 && ti->tt.module)
+		__MOD_DEC_USE_COUNT(ti->tt.module);
+
+	if (ti->use < 0)
+		BUG();
+	read_unlock(&_lock);
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
+	write_lock(&_lock);
+	if (__find_target_type(t->name))
+		rv = -EEXIST;
+	else
+		list_add(&ti->list, &_targets);
+
+	write_unlock(&_lock);
+	return rv;
+}
+
+int dm_unregister_target(struct target_type *t)
+{
+	struct tt_internal *ti;
+
+	write_lock(&_lock);
+	if (!(ti = __find_target_type(t->name))) {
+		write_unlock(&_lock);
+		return -EINVAL;
+	}
+
+	if (ti->use) {
+		write_unlock(&_lock);
+		return -ETXTBSY;
+	}
+
+	list_del(&ti->list);
+	kfree(ti);
+
+	write_unlock(&_lock);
+	return 0;
+}
+
+/*
+ * io-err: always fails an io, useful for bringing
+ * up LVs that have holes in them.
+ */
+static int io_err_ctr(struct dm_target *ti, int argc, char **args)
+{
+	return 0;
+}
+
+static void io_err_dtr(struct dm_target *ti)
+{
+	/* empty */
+	return;
+}
+
+static int io_err_map(struct dm_target *ti, struct bio *bio)
+{
+	bio_io_error(bio, 0);
+	return 0;
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
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm.c	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,970 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
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
+#include <linux/bio.h>
+#include <linux/mempool.h>
+
+#define DEFAULT_READ_AHEAD 64
+
+static const char *_name = DM_NAME;
+
+static int major = 0;
+static int _major = 0;
+
+struct dm_io {
+	struct mapped_device *md;
+	int error;
+	struct bio *bio;
+	atomic_t io_count;
+};
+
+#define MIN_IOS 256
+static kmem_cache_t *_io_cache;
+static mempool_t *_io_pool;
+
+static devfs_handle_t _dev_dir;
+
+static inline kdev_t bd_to_kdev(struct block_device *bdev)
+{
+	return bdev->bd_inode->i_rdev;
+}
+
+static request_queue_t *dm_get_queue(kdev_t dev)
+{
+	request_queue_t *q = NULL;
+	struct mapped_device *md = dm_get_r(dev);
+
+	if (md) {
+		q = &md->queue;
+		dm_put_r(md);
+	}
+
+	return q;
+}
+
+static __init int local_init(void)
+{
+	int r;
+
+	/* allocate a slab for the dm_ios */
+	_io_cache = kmem_cache_create("dm io",
+				      sizeof(struct dm_io), 0, 0, NULL, NULL);
+	if (!_io_cache)
+		return -ENOMEM;
+
+	_io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+				  mempool_free_slab, _io_cache);
+	if (!_io_pool) {
+		kmem_cache_destroy(_io_cache);
+		return -ENOMEM;
+	}
+
+	_major = major;
+	r = register_blkdev(_major, _name, &dm_blk_dops);
+	if (r < 0) {
+		DMERR("register_blkdev failed");
+		mempool_destroy(_io_pool);
+		kmem_cache_destroy(_io_cache);
+		return r;
+	}
+
+	if (!_major)
+		_major = r;
+
+	blk_dev[_major].queue = dm_get_queue;
+	_dev_dir = devfs_mk_dir(0, DM_DIR, NULL);
+
+	return 0;
+}
+
+static void local_exit(void)
+{
+	mempool_destroy(_io_pool);
+	kmem_cache_destroy(_io_cache);
+
+	if (unregister_blkdev(_major, _name) < 0)
+		DMERR("devfs_unregister_blkdev failed");
+
+	_major = 0;
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
+	xx(dm_hash)
+	xx(dm_target)
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
+	dm_destroy_all();
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
+	md = dm_get_w(inode->i_rdev);
+	if (!md)
+		return -ENXIO;
+
+	md->use_count++;
+	dm_put_w(md);
+	return 0;
+}
+
+static int dm_blk_close(struct inode *inode, struct file *file)
+{
+	struct mapped_device *md;
+
+	md = dm_get_w(inode->i_rdev);
+	if (!md)
+		return -ENXIO;
+
+	if (md->use_count < 1)
+		DMWARN("incorrect reference count found in mapped_device");
+
+	md->use_count--;
+	dm_put_w(md);
+
+	return 0;
+}
+
+static inline struct dm_io *alloc_io(void)
+{
+	return mempool_alloc(_io_pool, GFP_NOIO);
+}
+
+static inline void free_io(struct dm_io *io)
+{
+	mempool_free(io, _io_pool);
+}
+
+/*
+ * FIXME: We need to decide if deferred_ios need
+ * their own slab, I say no for now since they are
+ * only used when the device is suspended.
+ */
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
+/*
+ * Add the bio to the list of deferred io.
+ */
+static int queue_io(struct bio *bio)
+{
+	struct deferred_io *di = alloc_deferred();
+	struct mapped_device *md;
+
+	if (!di)
+		return -ENOMEM;
+
+	md = dm_get_w(bd_to_kdev(bio->bi_bdev));
+	if (!md) {
+		free_deferred(di);
+		return -ENXIO;
+	}
+
+	if (!test_bit(DMF_SUSPENDED, &md->flags)) {
+		dm_put_w(md);
+		free_deferred(di);
+		return 1;
+	}
+
+	di->bio = bio;
+	di->next = md->deferred;
+	md->deferred = di;
+
+	dm_put_w(md);
+	return 0;		/* deferred successfully */
+}
+
+/*
+ * Search the btree for the correct target.
+ */
+static inline int __find_node(struct dm_table *t, sector_t sector)
+{
+	int l, n = 0, k = 0;
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
+	return (KEYS_PER_NODE * n) + k;
+}
+
+/*-----------------------------------------------------------------
+ * CRUD START:
+ *   A more elegant soln is in the works that uses the queue
+ *   merge fn, unfortunately there are a couple of changes to
+ *   the block layer that I want to make for this.  So in the
+ *   interests of getting something for people to use I give
+ *   you this clearly demarcated crap.
+ *---------------------------------------------------------------*/
+
+/*
+ * Decrements the number of outstanding ios that a bio has been
+ * cloned into, completing the original io if necc.
+ */
+static inline void dec_pending(struct dm_io *io, int error)
+{
+	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long flags;
+
+	spin_lock_irqsave(&_uptodate_lock, flags);
+	if (error)
+		io->error = error;
+	spin_unlock_irqrestore(&_uptodate_lock, flags);
+
+	if (atomic_dec_and_test(&io->io_count)) {
+		if (atomic_dec_and_test(&io->md->pending))
+			/* nudge anyone waiting on suspend queue */
+			wake_up(&io->md->wait);
+
+		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
+		free_io(io);
+	}
+}
+
+static int clone_endio(struct bio *bio, unsigned int done, int error)
+{
+	struct dm_io *io = bio->bi_private;
+
+	/*
+	 * Only call dec_pending if the clone has completely
+	 * finished.  If a partial io errors I'm assuming it won't
+	 * be requeued.  FIXME: check this.
+	 */
+	if (error || !bio->bi_size)
+		dec_pending(io, error);
+
+	return 0;
+}
+
+
+static sector_t max_io_len(struct mapped_device *md,
+			   sector_t sector, struct dm_target *ti)
+{
+	sector_t len = ti->len;
+
+	/* FIXME: obey io_restrictions ! */
+
+	/*
+	 * Does the target need to split even further ?
+	 */
+	if (ti->split_io) {
+		sector_t boundary;
+		sector_t offset = sector - ti->begin;
+		boundary = dm_round_up(offset + 1, ti->split_io) - offset;
+
+		if (len > boundary)
+			len = boundary;
+	}
+
+	return len;
+}
+
+static void __map_bio(struct dm_target *ti, struct bio *clone)
+{
+	struct dm_io *io = (struct dm_io *) clone->bi_private;
+	int r;
+
+	/*
+	 * Sanity checks.
+	 */
+	if (!clone->bi_size)
+		BUG();
+
+	/*
+	 * Map the clone.  If r == 0 we don't need to do
+	 * anything, the target has assumed ownership of
+	 * this io.
+	 */
+	atomic_inc(&io->md->pending);
+	atomic_inc(&io->io_count);
+	r = ti->type->map(ti, clone);
+	if (r > 0)
+		/* the bio has been remapped so dispatch it */
+		generic_make_request(clone);
+
+	else if (r < 0)
+		/* error the io and bail out */
+		dec_pending(io, -EIO);
+}
+
+struct clone_info {
+	struct mapped_device *md;
+	struct bio *bio;
+	struct dm_io *io;
+	sector_t sector;
+	sector_t sector_count;
+	unsigned short idx;
+};
+
+/*
+ * Issues a little bio that just does the back end of a split page.
+ */
+static void __split_page(struct clone_info *ci, unsigned int len)
+{
+	struct dm_target *ti = dm_get_target(ci->md->map,
+			     __find_node(ci->md->map, ci->sector));
+	struct bio *clone, *bio = ci->bio;
+	struct bio_vec *bv = bio->bi_io_vec + (bio->bi_vcnt - 1);
+
+	DMWARN("splitting page");
+
+	if (len > ci->sector_count)
+		len = ci->sector_count;
+
+	clone = bio_alloc(GFP_NOIO, 1);
+	memcpy(clone->bi_io_vec, bv, sizeof(*bv));
+
+	clone->bi_sector = ci->sector;
+	clone->bi_bdev = bio->bi_bdev;
+	clone->bi_flags = bio->bi_flags | (1 << BIO_SEG_VALID);
+	clone->bi_rw = bio->bi_rw;
+	clone->bi_size = len << SECTOR_SHIFT;
+	clone->bi_end_io = clone_endio;
+	clone->bi_private = ci->io;
+
+	ci->sector += len;
+	ci->sector_count -= len;
+
+	__map_bio(ti, clone);
+}
+
+static void __clone_and_map(struct clone_info *ci)
+{
+	struct bio *clone, *bio = ci->bio;
+	struct dm_target *ti = dm_get_target(ci->md->map,
+			     __find_node(ci->md->map, ci->sector));
+	sector_t len = max_io_len(ci->md, bio->bi_sector, ti);
+
+	/* shorter than current target ? */
+	if (ci->sector_count < len)
+		len = ci->sector_count;
+
+	/* create the clone */
+	clone = bio_clone(ci->bio, GFP_NOIO);
+	clone->bi_sector = ci->sector;
+	clone->bi_idx = ci->idx;
+	clone->bi_size = len << SECTOR_SHIFT;
+	clone->bi_end_io = clone_endio;
+	clone->bi_private = ci->io;
+
+	/* adjust the remaining io */
+	ci->sector += len;
+	ci->sector_count -= len;
+	__map_bio(ti, clone);
+
+	/*
+	 * If we are not performing all remaining io in this
+	 * clone then we need to calculate ci->idx for the next
+	 * time round.
+	 */
+	if (ci->sector_count) {
+		while (len) {
+			struct bio_vec *bv = clone->bi_io_vec + ci->idx;
+			sector_t bv_len = bv->bv_len >> SECTOR_SHIFT;
+			if (bv_len <= len)
+				len -= bv_len;
+
+			else {
+				__split_page(ci, bv_len - len);
+				len = 0;
+			}
+			ci->idx++;
+		}
+	}
+}
+
+/*
+ * Split the bio into several clones.
+ */
+static void __split_bio(struct mapped_device *md, struct bio *bio)
+{
+	struct clone_info ci;
+
+	ci.md = md;
+	ci.bio = bio;
+	ci.io = alloc_io();
+	ci.io->error = 0;
+	atomic_set(&ci.io->io_count, 1);
+	ci.io->bio = bio;
+	ci.io->md = md;
+	ci.sector = bio->bi_sector;
+	ci.sector_count = bio_sectors(bio);
+	ci.idx = 0;
+
+	while (ci.sector_count)
+		__clone_and_map(&ci);
+
+	/* drop the extra reference count */
+	dec_pending(ci.io, 0);
+}
+/*-----------------------------------------------------------------
+ * CRUD END
+ *---------------------------------------------------------------*/
+
+
+/*
+ * The request function that just remaps the bio built up by
+ * dm_merge_bvec.
+ */
+static int dm_request(request_queue_t *q, struct bio *bio)
+{
+	int r;
+	struct mapped_device *md = (struct mapped_device *) q->queuedata;
+
+	down_read(&md->lock);
+	/*
+	 * If we're suspended we have to queue
+	 * this io for later.
+	 */
+	while (test_bit(DMF_SUSPENDED, &md->flags)) {
+		dm_put_r(md);
+
+		if (bio_rw(bio) == READA) {
+			bio_io_error(bio, 0);
+			return 0;
+		}
+
+		r = queue_io(bio);
+		if (r < 0) {
+			bio_io_error(bio, 0);
+			return 0;
+
+		} else if (r == 0)
+			return 0;	/* deferred successfully */
+
+		/*
+		 * We're in a while loop, because someone could suspend
+		 * before we get to the following read lock.
+		 */
+		down_read(&md->lock);
+	}
+
+	__split_bio(md, bio);
+	up_read(&md->lock);
+	return 0;
+}
+
+/*
+ * See if the device with a specific minor # is free.  Inserts
+ * the device into the hashes.
+ */
+static inline int specific_dev(int minor, struct mapped_device *md)
+{
+	if (minor >= MAX_DEVICES) {
+		DMWARN("request for a mapped_device beyond MAX_DEVICES (%d)",
+		       MAX_DEVICES);
+		return -EINVAL;
+	}
+
+	md->dev = mk_kdev(_major, minor);
+	if (dm_hash_insert(md))
+		/* in use */
+		return -EBUSY;
+
+	return minor;
+}
+
+/*
+ * Find the first free device.
+ */
+static int any_old_dev(struct mapped_device *md)
+{
+	int i;
+
+	for (i = 0; i < MAX_DEVICES; i++)
+		if (specific_dev(i, md) >= 0)
+			return i;
+
+	return -EBUSY;
+}
+
+/*
+ * Allocate and initialise a blank device, then insert it into
+ * the hash tables.  Caller must ensure uuid is null-terminated.
+ * Device is returned with a write lock held.
+ */
+static struct mapped_device *
+alloc_dev(const char *name, const char *uuid, int minor)
+{
+	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
+
+	if (!md) {
+		DMWARN("unable to allocate device, out of memory.");
+		return NULL;
+	}
+
+	memset(md, 0, sizeof(*md));
+	set_bit(DMF_VALID, &md->flags);
+	atomic_set(&md->pending, 0);
+	init_rwsem(&md->lock);
+	down_write(&md->lock);
+
+	/*
+	 * Copy in the name.
+	 */
+	md->name = dm_strdup(name);
+	if (!md->name)
+		goto bad;
+
+	/*
+	 * Copy in the uuid.
+	 */
+	if (uuid && *uuid) {
+		md->uuid = dm_strdup(uuid);
+		if (!md->uuid) {
+			DMWARN("unable to allocate uuid - out of memory.");
+			goto bad;
+		}
+	}
+
+	/*
+	 * This will have inserted the device into the hashes iff
+	 * it succeeded.
+	 */
+	minor = (minor < 0) ? any_old_dev(md) : specific_dev(minor, md);
+	if (minor < 0)
+		goto bad;
+
+	clear_bit(DMF_SUSPENDED, &md->flags);
+
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	return md;
+
+      bad:
+	kfree(md->name);
+	kfree(md->uuid);
+	kfree(md);
+
+	return NULL;
+}
+
+static void free_dev(struct mapped_device *md)
+{
+	dm_hash_remove(md);
+	kfree(md->name);
+
+	kfree(md->uuid);
+	kfree(md);
+}
+
+static int __register_device(struct mapped_device *md)
+{
+	md->devfs_entry =
+	    devfs_register(_dev_dir, md->name, DEVFS_FL_CURRENT_OWNER,
+			   major(md->dev), minor(md->dev),
+			   S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
+			   &dm_blk_dops, NULL);
+
+	return 0;
+}
+
+static int __unregister_device(struct mapped_device *md)
+{
+	devfs_unregister(md->devfs_entry);
+	return 0;
+}
+
+/*
+ * Bind a table to the device.
+ */
+static int __bind(struct mapped_device *md, struct dm_table *t)
+{
+	request_queue_t *q = &md->queue;
+	md->map = t;
+
+	if (!t->num_targets) {
+		set_capacity(&md->disk, 0);
+		return 0;
+	}
+
+	/*
+	 * Make sure we obey the optimistic sub devices
+	 * restrictions.
+	 */
+	q->max_sectors = t->limits.max_sectors;
+	q->max_phys_segments = t->limits.max_phys_segments;
+	q->max_hw_segments = t->limits.max_hw_segments;
+	q->hardsect_size = t->limits.hardsect_size;
+	q->max_segment_size = t->limits.max_segment_size;
+	q->seg_boundary_mask = t->limits.seg_boundary_mask;
+
+	/* setup gendisk */
+	set_capacity(&md->disk, t->highs[t->num_targets - 1] + 1);
+	return 0;
+}
+
+static void __unbind(struct mapped_device *md)
+{
+	dm_table_destroy(md->map);
+	md->map = NULL;
+
+	set_capacity(&md->disk, 0);
+}
+
+static int check_name(const char *name)
+{
+	if (strchr(name, '/')) {
+		DMWARN("invalid device name");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int get_block_device(struct mapped_device *md)
+{
+	/* FIXME: remove paranoia */
+	if (md->bdev)
+		BUG();
+
+	md->bdev = bdget(kdev_t_to_nr(md->dev));
+	if (!md->bdev)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void put_block_device(struct mapped_device *md)
+{
+	bdput(md->bdev);
+	md->bdev = NULL;
+}
+
+/*
+ * Constructor for a new device.
+ */
+int dm_create(const char *name, const char *uuid, int minor, int ro,
+	      struct dm_table *table)
+{
+	int r;
+	struct mapped_device *md;
+
+	r = check_name(name);
+	if (r)
+		return r;
+
+	md = alloc_dev(name, uuid, minor);
+	if (!md)
+		return -ENXIO;
+
+	blk_queue_make_request(&md->queue, dm_request);
+	blk_queue_bounce_limit(&md->queue, BLK_BOUNCE_HIGH);
+	md->queue.queuedata = md;
+
+	r = get_block_device(md);
+	if (r)
+		goto bad;
+
+	r = __register_device(md);
+	if (r)
+		goto bad;
+
+	r = __bind(md, table);
+	if (r)
+		goto bad;
+
+	md->disk.major = _major;
+	md->disk.first_minor = minor(md->dev);
+	md->disk.minor_shift = 0;
+	md->disk.fops = &dm_blk_dops;
+	sprintf(md->disk.disk_name, "dm-%d", minor(md->dev));
+	add_disk(&md->disk);
+
+	if (ro)
+		dm_set_ro(md);
+	else
+		dm_set_rw(md);
+
+	dm_put_w(md);
+	return 0;
+
+      bad:
+	dm_put_w(md);
+	free_dev(md);
+	return r;
+}
+
+/*
+ * Renames the device.  No lock held.
+ */
+int dm_set_name(const char *name, const char *new_name)
+{
+	int r;
+	struct mapped_device *md;
+
+	r = dm_hash_rename(name, new_name);
+	if (r)
+		return r;
+
+	md = dm_get_name_w(new_name);
+	r = __unregister_device(md);
+	if (!r)
+		r = __register_device(md);
+	dm_put_w(md);
+	return r;
+}
+
+/*
+ * Destructor for the device.  You cannot destroy an open device.
+ * Write lock must be held before calling.  md will have been
+ * freed if call was successful.
+ */
+int dm_destroy(struct mapped_device *md)
+{
+	int r;
+
+	if (md->use_count)
+		return -EPERM;
+
+	/*
+	 * Clearing the valid flag prevents anyone using the
+	 * dm_get* functions accessing this device (the write
+	 * lock is dropped briefly as part of the hash removal).
+	 * The only code that doesn't go through the hash to get
+	 * locks on an md is in the request chain, and since we
+	 * know the device isn't open there can't be any io.
+	 */
+	clear_bit(DMF_VALID, &md->flags);
+
+	r = __unregister_device(md);
+	if (r)
+		return r;
+
+	del_gendisk(&md->disk);
+	__unbind(md);
+	put_block_device(md);
+	free_dev(md);
+
+	return 0;
+}
+
+/*
+ * Destroy all devices - except open ones
+ */
+void dm_destroy_all(void)
+{
+	int i, some_destroyed, r;
+	struct mapped_device *md;
+
+	do {
+		some_destroyed = 0;
+		for (i = 0; i < MAX_DEVICES; i++) {
+			md = dm_get_w(mk_kdev(_major, i));
+			if (!md)
+				continue;
+
+			r = dm_destroy(md);
+			if (r)
+				dm_put_w(md);
+			else
+				some_destroyed = 1;
+		}
+	} while (some_destroyed);
+}
+
+/*
+ * Sets or clears the read-only flag for the device.  Write lock
+ * must be held.
+ */
+void dm_set_ro(struct mapped_device *md)
+{
+	set_bit(DMF_RO, &md->flags);
+	set_device_ro(md->dev, 1);
+}
+
+void dm_set_rw(struct mapped_device *md)
+{
+	set_bit(DMF_RO, &md->flags);
+	set_device_ro(md->dev, 0);
+}
+
+/*
+ * Requeue the deferred bios by calling generic_make_request.
+ */
+static void flush_deferred_io(struct deferred_io *c)
+{
+	struct deferred_io *n;
+
+	while (c) {
+		n = c->next;
+		generic_make_request(c->bio);
+		free_deferred(c);
+		c = n;
+	}
+}
+
+/*
+ * Swap in a new table (destroying old one).  Write lock must be
+ * held.
+ */
+int dm_swap_table(struct mapped_device *md, struct dm_table *table)
+{
+	int r;
+
+	/* device must be suspended */
+	if (!test_bit(DMF_SUSPENDED, &md->flags) || atomic_read(&md->pending))
+		return -EPERM;
+
+	__unbind(md);
+
+	r = __bind(md, table);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+/*
+ * We need to be able to change a mapping table under a mounted
+ * filesystem.  For example we might want to move some data in
+ * the background.  Before the table can be swapped with
+ * dm_bind_table, dm_suspend must be called to flush any in
+ * flight bios and ensure that any further io gets deferred.
+ * Write lock must be held, this function will drop the lock.
+ */
+int dm_suspend(struct mapped_device *md)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	/*
+	 * First we set the suspend flag so no more ios will be
+	 * mapped.
+	 */
+	if (test_bit(DMF_SUSPENDED, &md->flags)) {
+		dm_put_w(md);
+		return -EINVAL;
+	}
+
+	set_bit(DMF_SUSPENDED, &md->flags);
+	dm_put_w(md);
+
+	/*
+	 * Then we wait for wait for the already mapped ios to
+	 * complete.
+	 */
+	md = dm_get_r(md->dev);
+	if (!md)
+		return -ENXIO;
+
+	add_wait_queue(&md->wait, &wait);
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (!atomic_read(&md->pending))
+			break;
+
+		yield();
+	}
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&md->wait, &wait);
+	dm_put_r(md);
+
+	return 0;
+}
+
+int dm_resume(struct mapped_device *md)
+{
+	struct deferred_io *def;
+
+	if (!test_bit(DMF_SUSPENDED, &md->flags) || !md->map->num_targets) {
+		dm_put_w(md);
+		return -EINVAL;
+	}
+
+	clear_bit(DMF_SUSPENDED, &md->flags);
+	def = md->deferred;
+	md->deferred = NULL;
+	dm_put_w(md);
+
+	flush_deferred_io(def);
+	blk_run_queues();
+
+	return 0;
+}
+
+struct block_device_operations dm_blk_dops = {
+	.open = dm_blk_open,
+	.release = dm_blk_close,
+	.owner = THIS_MODULE
+};
+
+/*
+ * module hooks
+ */
+module_init(dm_init);
+module_exit(dm_exit);
+
+MODULE_PARM(major, "i");
+MODULE_PARM_DESC(major, "The major number of the device mapper");
+MODULE_DESCRIPTION(DM_NAME " driver");
+MODULE_AUTHOR("Joe Thornber <thornber@sistina.com>");
+MODULE_LICENSE("GPL");
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm.h	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,282 @@
+/*
+ * Internal header file for device mapper
+ *
+ * Copyright (C) 2001 Sistina Software
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef DM_INTERNAL_H
+#define DM_INTERNAL_H
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/device-mapper.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+
+#define DM_NAME "device-mapper"	/* Name for messaging */
+#define DM_DRIVER_EMAIL "lvm-devel@lists.sistina.com"
+#define MAX_DEPTH 16
+#define NODE_SIZE L1_CACHE_BYTES
+#define KEYS_PER_NODE (NODE_SIZE / sizeof(sector_t))
+#define CHILDREN_PER_NODE (KEYS_PER_NODE + 1)
+#define MAX_ARGS 32
+#define MAX_DEVICES 256
+#define SECTOR_SIZE 512
+#define SECTOR_SHIFT 9
+
+/*
+ * FIXME: I think this should be with the definition of sector_t
+ * in types.h.
+ */
+#ifdef CONFIG_LBD
+#define SECTOR_FORMAT "%llu"
+#else
+#define SECTOR_FORMAT "%lu"
+#endif
+
+/*
+ * List of devices that a metadevice uses and should open/close.
+ */
+struct dm_dev {
+	struct list_head list;
+
+	atomic_t count;
+	int mode;
+	kdev_t dev;		/* FIXME: get rid of this */
+	struct block_device *bdev;
+};
+
+/*
+ * I/O that had to be deferred while we were suspended
+ */
+struct deferred_io {
+	struct bio *bio;
+	struct deferred_io *next;
+};
+
+/*
+ * The btree
+ */
+struct dm_table {
+	/* btree table */
+	int depth;
+	int counts[MAX_DEPTH];	/* in nodes */
+	sector_t *index[MAX_DEPTH];
+
+	int num_targets;
+	int num_allocated;
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
+	/*
+	 * These are optimistic limits taken from all the
+	 * targets, some targets will need smaller limits.
+	 */
+	struct io_restrictions limits;
+
+	/*
+	 * A waitqueue for processes waiting for something
+	 * interesting to happen to this table.
+	 */
+	wait_queue_head_t eventq;
+};
+
+#define DMF_VALID     0
+#define DMF_SUSPENDED 1
+#define DMF_RO        2
+
+/*
+ * The actual device struct
+ */
+struct mapped_device {
+	struct rw_semaphore lock;
+	unsigned long flags;
+
+	kdev_t dev;		/* FIXME: can we get rid of this ? */
+	struct block_device *bdev;
+	request_queue_t queue;
+	char *name;
+	char *uuid;
+
+	int use_count;
+
+	/*
+	 * A list of ios that arrived while we were suspended.
+	 */
+	atomic_t pending;
+	wait_queue_head_t wait;
+	struct deferred_io *deferred;
+
+	struct dm_table *map;
+
+	/* used by dm-fs.c */
+	devfs_handle_t devfs_entry;
+	struct gendisk disk;
+};
+
+extern struct block_device_operations dm_blk_dops;
+
+/* dm-target.c */
+int dm_target_init(void);
+struct target_type *dm_get_target_type(const char *name);
+void dm_put_target_type(struct target_type *t);
+void dm_target_exit(void);
+
+/*
+ * Destructively splits argument list to pass to ctr.
+ */
+int split_args(int max, int *argc, char **argv, char *input);
+
+/*
+ * dm-hash manages the lookup of devices by dev/name/uuid.
+ */
+int dm_hash_init(void);
+void dm_hash_exit(void);
+
+int dm_hash_insert(struct mapped_device *md);
+void dm_hash_remove(struct mapped_device *md);
+int dm_hash_rename(const char *old, const char *new);
+
+
+/*
+ * There are three ways to lookup a device: by kdev_t, by name
+ * and by uuid.  A code path (eg an ioctl) should only ever get
+ * one device at any time.
+ */
+struct mapped_device *dm_get_r(kdev_t dev);
+struct mapped_device *dm_get_w(kdev_t dev);
+
+struct mapped_device *dm_get_name_r(const char *name);
+struct mapped_device *dm_get_name_w(const char *name);
+
+struct mapped_device *dm_get_uuid_r(const char *uuid);
+struct mapped_device *dm_get_uuid_w(const char *uuid);
+
+static inline void dm_put_r(struct mapped_device *md)
+{
+	up_read(&md->lock);
+}
+
+static inline void dm_put_w(struct mapped_device *md)
+{
+	up_write(&md->lock);
+}
+
+/*
+ * Call with no lock.
+ */
+int dm_create(const char *name, const char *uuid, int minor, int ro,
+	      struct dm_table *table);
+int dm_set_name(const char *name, const char *newname);
+void dm_destroy_all(void);
+
+/*
+ * You must have the write lock before calling the remaining md
+ * methods.
+ */
+int dm_destroy(struct mapped_device *md);
+void dm_set_ro(struct mapped_device *md);
+void dm_set_rw(struct mapped_device *md);
+
+/*
+ * The device must be suspended before calling this method.
+ */
+int dm_swap_table(struct mapped_device *md, struct dm_table *t);
+
+/*
+ * A device can still be used while suspended, but I/O is deferred.
+ */
+int dm_suspend(struct mapped_device *md);
+int dm_resume(struct mapped_device *md);
+
+/* dm-table.c */
+int dm_table_create(struct dm_table **result, int mode);
+void dm_table_destroy(struct dm_table *t);
+
+int dm_table_add_target(struct dm_table *t, struct dm_target *ti);
+int dm_table_complete(struct dm_table *t);
+
+/*
+ * Event handling
+ */
+void dm_table_event(struct dm_table *t);
+
+#define DMWARN(f, x...) printk(KERN_WARNING DM_NAME ": " f "\n" , ## x)
+#define DMERR(f, x...) printk(KERN_ERR DM_NAME ": " f "\n" , ## x)
+#define DMINFO(f, x...) printk(KERN_INFO DM_NAME ": " f "\n" , ## x)
+
+/*
+ * Calculate the index of the child node of the n'th node k'th key.
+ */
+static inline int get_child(int n, int k)
+{
+	return (n * CHILDREN_PER_NODE) + k;
+}
+
+/*
+ * Return the n'th node of level l from table t.
+ */
+static inline sector_t *get_node(struct dm_table *t, int l, int n)
+{
+	return t->index[l] + (n * KEYS_PER_NODE);
+}
+
+
+static inline struct dm_target *dm_get_target(struct dm_table *t, int leaf)
+{
+	return t->targets + leaf;
+}
+
+static inline int array_too_big(unsigned long fixed, unsigned long obj,
+				unsigned long num)
+{
+	return (num > (ULONG_MAX - fixed) / obj);
+}
+
+static inline char *dm_strdup(const char *str)
+{
+	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
+	if (r)
+		strcpy(r, str);
+	return r;
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
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/device-mapper.h	Tue Oct 15 18:24:34 2002
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef _LINUX_DEVICE_MAPPER_H
+#define _LINUX_DEVICE_MAPPER_H
+
+#define DM_DIR "mapper"	/* Slashes not supported */
+#define DM_MAX_TYPE_NAME 16
+#define DM_NAME_LEN 128
+#define DM_UUID_LEN 129
+
+#ifdef __KERNEL__
+
+struct dm_target;
+struct dm_table;
+struct dm_dev;
+
+typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE } status_type_t;
+
+/*
+ * In the constructor the target parameter will already have the
+ * table, type, begin and len fields filled in.
+ */
+typedef int (*dm_ctr_fn) (struct dm_target *target, int argc, char **argv);
+
+/*
+ * The destructor doesn't need to free the dm_target, just
+ * anything hidden ti->private.
+ */
+typedef void (*dm_dtr_fn) (struct dm_target *ti);
+
+/*
+ * The map function must return:
+ * < 0: error
+ * = 0: The target will handle the io by resubmitting it later
+ * > 0: simple remap complete
+ */
+typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
+			     char *result, int maxlen);
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
+	dm_status_fn status;
+};
+
+struct io_restrictions {
+	unsigned short		max_sectors;
+	unsigned short		max_phys_segments;
+	unsigned short		max_hw_segments;
+	unsigned short		hardsect_size;
+	unsigned int		max_segment_size;
+	unsigned long		seg_boundary_mask;
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
+	/* FIXME: turn this into a mask, and merge with io_restrictions */
+	sector_t split_io;
+
+	/*
+	 * These are automaticall filled in by
+	 * dm_table_get_device.
+	 */
+	struct io_restrictions limits;
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
+#endif				/* __KERNEL__ */
+
+#endif				/* _LINUX_DEVICE_MAPPER_H */
