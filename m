Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWG0Vsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWG0Vsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWG0Vsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:48:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62130 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751319AbWG0Vsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:48:45 -0400
From: Dan Smith <danms@us.ibm.com>
To: "Alasdair G. Kergon" <agk@redhat.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       Ryan Grimm <grimm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: Add userspace target
Date: Thu, 27 Jul 2006 14:48:40 -0700
Message-ID: <m3irlik9c7.fsf@guaranine.beaverton.ibm.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a userspace target to device-mapper.  This version
includes the following changes as requested:

 - Removed debug messages
 - Block device targets must be registered at table creation time
 - Chardev operations check for root capabilities
 - Eliminate the *need* to allocate memory on the critical IO path
 - Broke up the interface between the kernel and the userspace library
 - Insulated the consumer of libdevmapper from the details of
   dm-userspace kernel interface, allowing for future expansion
   without breaking compatibility
 - Split dm-userspace.c into separate chunks (along the line between
   the target-specific and userspace-transport pieces)
 - Added synchronous IO completion notification and control to allow
   userspace to enforce metadata consistency where needed.

A patch to libdevmapper for dm-userspace support will be sent to
dm-devel.

Signed-off-by: Dan Smith <danms@us.ibm.com>
Signed-off-by: Ryan Grimm <grimm@us.ibm.com>

diff -Naur linux-2.6.17.6-orig/drivers/md/dm-user.h linux-2.6.17.6-dmu/drivers/md/dm-user.h
--- linux-2.6.17.6-orig/drivers/md/dm-user.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.6-dmu/drivers/md/dm-user.h	2006-07-27 14:32:05.000000000 -0700
@@ -0,0 +1,208 @@
+/*
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Dan Smith <danms@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __DM_USER_H
+#define __DM_USER_H
+
+#define DMU_KEY_LEN 256
+
+extern struct target_type userspace_target;
+extern mempool_t *request_pool;
+extern dev_t dmu_dev;
+extern spinlock_t devices_lock;
+extern struct list_head devices;
+
+/*
+ * A hash table of remaps
+ */
+struct hash_table {
+	struct list_head *table;      /* Array of lists (buckets)           */
+	uint64_t size;                /* Number of buckets                  */
+	uint32_t mask;                /* Mask used to determine bucket      */
+	uint64_t count;               /* Number of remaps in entire table   */
+};
+
+/*
+ * A block device that we can send bios to
+ */
+struct target_device {
+	struct list_head list;        /* Our place in the targets list      */
+	struct block_device *bdev;    /* The target block_device            */
+	struct kref users;            /* Self-destructing reference count   */
+};
+
+/*
+ * A dm-userspace device, which consists of multiple targets sharing a
+ * common key
+ */
+struct dmu_device {
+	struct list_head list;        /* Our place in the devices list     */
+
+	spinlock_t lock;              /* Protects all the fields below     */
+
+	struct list_head requests;    /* List of pending requests          */
+	struct list_head target_devs; /* List of devices we can target     */
+	struct list_head in_flight;   /* List of pending remaps            */
+	struct hash_table remaps;     /* Hash table of all our maps        */
+
+	void *transport_private;      /* Private data for userspace comms  */
+
+	char key[DMU_KEY_LEN];        /* Unique name string for device     */
+	struct kref users;            /* Self-destructing reference count  */
+
+	wait_queue_head_t wqueue;     /* To block while waiting for reqs   */
+
+	uint64_t block_size;          /* Block size for this device        */
+	uint64_t block_mask;          /* Mask for offset in block          */
+	unsigned int block_shift;     /* Shift to convert to/from block    */
+
+	struct kcopyd_client *kcopy;  /* Interface to kcopyd               */
+
+	uint32_t id_counter;          /* Used to generate request IDs      */
+};
+
+struct userspace_request {
+	struct list_head list;        /* Our place on the request queue    */
+
+	spinlock_t lock;              /* Protects all the fields below     */
+
+	struct dmu_device *dev;       /* The DMU device that owns us       */
+
+	int type;                     /* Type of request                   */
+	int sent;                     /* Non-zero if we've been sent       */
+	uint32_t flags;               /* Attribute flags                   */
+	uint32_t id;                  /* Unique ID for sync with userspace */
+	union {
+		struct bio_list bios; /* Bios waiting on this request      */
+		uint64_t block;       /* The block in question             */
+	} u;
+	atomic_t refcnt;              /* Reference count                   */
+};
+
+struct dmu_map {
+	struct list_head list;        /* Our place in a remap bucket chain */
+	struct list_head mru_list;    /* Our place on the MRU list         */
+	struct list_head in_flight;   /* Our place on the                  */
+
+	spinlock_t lock;              /* Protects all the fields below     */
+
+	uint64_t org_block;           /* Original block                    */
+	uint64_t new_block;           /* Destination block                 */
+	int64_t offset;               /* Sectors to offset remapped block  */
+	uint32_t flags;               /* Attribute flags                   */
+	uint32_t id;                  /* Unique ID for sync with userspace */
+
+	struct target_device *src;    /* Source blkdev for COPY_FIRST      */
+	struct target_device *dest;   /* Where the remapped block is       */
+
+	struct bio_list bios;         /* Bios queued for remapping         */
+	struct bio_list bios_waiting; /* Bios waiting for endio sync       */
+
+	struct dmu_device *dev;       /* The DMU device that owns us       */
+	struct dmu_map *next;         /* Next remap that depends on us     */
+};
+
+/* Find and grab a reference to a target device */
+struct target_device *find_target(struct dmu_device *dev,
+				  dev_t devno);
+
+/* Object allocation, destruction, and initialization routines */
+void init_remap(struct dmu_device *dev, struct dmu_map *remap);
+void init_request(struct dmu_device *dev,
+		  int type,
+		  struct userspace_request *req);
+void free_remap(struct dmu_map *remap);
+void __free_remap(struct dmu_map *remap);
+struct dmu_map *alloc_remap_atomic(struct dmu_device *dev);
+
+/* Hash table manipulation */
+struct dmu_map *ht_find_map(struct hash_table *ht, uint64_t block);
+void ht_insert_map(struct hash_table *ht, struct dmu_map *map);
+struct dmu_map *ht_find_map_dev(struct dmu_device *dev, uint64_t block);
+void ht_delete_map(struct hash_table *ht, struct dmu_map *map);
+
+/* Character device transport functions */
+int register_chardev_transport(struct dmu_device *dev);
+void unregister_chardev_transport(struct dmu_device *dev);
+int init_chardev_transport(void);
+void cleanup_chardev_transport(void);
+void write_chardev_transport_info(struct dmu_device *dev,
+				  char *buf, unsigned int maxlen);
+
+/* Return the block number for @sector */
+static inline u64 dmu_block(struct dmu_device *dev,
+			    sector_t sector)
+{
+	return sector >> dev->block_shift;
+}
+
+/* Return the sector offset in a block for @sector */
+static inline u64 dmu_sector_offset(struct dmu_device *dev,
+				    sector_t sector)
+{
+	return sector & dev->block_mask;
+}
+
+/* Return the starting sector for @block */
+static inline u64 dmu_sector(struct dmu_device *dev,
+			     uint64_t block)
+{
+	return block << dev->block_shift;
+}
+
+/* Add a request to a device's request queue */
+static void add_request(struct dmu_device *dev,
+			struct userspace_request *req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	list_add_tail(&req->list, &dev->requests);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	wake_up(&dev->wqueue);
+}
+
+/* Remap @bio based on the information in @remap */
+static void __bio_remap(struct bio *bio,
+			struct dmu_map *remap)
+{
+	BUG_ON(remap->dest == NULL);
+
+	bio->bi_sector = dmu_sector(remap->dev, remap->new_block) +
+		dmu_sector_offset(remap->dev, bio->bi_sector) +
+		remap->offset;
+
+	bio->bi_bdev = remap->dest->bdev;
+}
+
+/* Increase the usage count for @dev */
+static inline void get_dev(struct dmu_device *dev)
+{
+	kref_get(&dev->users);
+}
+
+/* Decrease the usage count for @dev */
+void destroy_dmu_device(struct kref *ref);
+static inline void put_dev(struct dmu_device *dev)
+{
+	kref_put(&dev->users, destroy_dmu_device);
+}
+
+#endif
diff -Naur linux-2.6.17.6-orig/drivers/md/dm-userspace.c linux-2.6.17.6-dmu/drivers/md/dm-userspace.c
--- linux-2.6.17.6-orig/drivers/md/dm-userspace.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.6-dmu/drivers/md/dm-userspace.c	2006-07-27 14:32:05.000000000 -0700
@@ -0,0 +1,1090 @@
+/*
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Dan Smith <danms@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/types.h>
+#include <linux/poll.h>
+
+#include <linux/dm-userspace.h>
+
+#include "dm.h"
+#include "dm-bio-list.h"
+#include "kcopyd.h"
+#include "dm-user.h"
+
+#define DMU_COPY_PAGES    256
+#define DMU_REMAP_RESERVE 128
+
+#define DM_MSG_PREFIX     "dm-userspace"
+
+static kmem_cache_t *request_cache;
+static kmem_cache_t *remap_cache;
+
+mempool_t *request_pool;
+
+static int enable_watchdog = 0;
+static struct work_struct wd;
+
+spinlock_t devices_lock;
+LIST_HEAD(devices);
+
+static spinlock_t mru_list_lock;
+static LIST_HEAD(mru_list);
+
+/* Device number for the control device */
+dev_t dmu_dev;
+
+static int error_bios(struct bio_list *bios)
+{
+	struct bio *bio;
+	int count = 0;
+
+	while ((bio = bio_list_pop(bios)) != NULL) {
+		bio_io_error(bio, bio->bi_size);
+		count++;
+	}
+
+	if (count)
+		DMERR("*** Failed %i requests", count);
+
+	return count;
+}
+
+static void remap_hit(struct dmu_map *remap)
+{
+	spin_lock(&mru_list_lock);
+
+	list_del_init(&remap->mru_list);
+	list_add(&remap->mru_list, &mru_list);
+
+	spin_unlock(&mru_list_lock);
+}
+
+struct dmu_map *alloc_remap_atomic(struct dmu_device *dev)
+{
+	struct dmu_map *remap = NULL;
+
+	/* Try to allocate one from the cache */
+	remap = kmem_cache_alloc(remap_cache, GFP_NOIO);
+	if (remap) {
+
+		INIT_LIST_HEAD(&remap->mru_list);
+
+		spin_lock(&mru_list_lock);
+		list_add_tail(&remap->mru_list, &mru_list);
+		spin_unlock(&mru_list_lock);
+
+		goto out;
+	}
+
+	/* Unable to alloc one, so get the LRU item off the list */
+	spin_lock(&mru_list_lock);
+	remap = list_entry(mru_list.prev, struct dmu_map, mru_list);
+	spin_unlock(&mru_list_lock);
+
+	if (remap) {
+		struct dmu_device *dev = remap->dev;
+		unsigned long flags;
+
+		DMINFO("Memory is low.  Stealing the LRU remap...");
+
+		spin_lock_irqsave(&dev->lock, flags);
+		spin_lock(&remap->lock);
+		if (dmu_get_flag(&remap->flags, DMU_FLAG_INUSE)) {
+			/* Remove it from whatever device owns it */
+
+			if (!list_empty(&remap->list))
+				list_del_init(&remap->list);
+
+			remap->flags &= (~DMU_FLAG_INUSE);
+
+			if (!dmu_get_flag(&remap->flags, DMU_FLAG_VALID)) {
+				/* If the LRU remap is not valid,
+				   we're in trouble */
+				spin_unlock(&remap->lock);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				printk(KERN_EMERG
+				       "dm-userspace: Unable to allocate "
+				       "or steal a remap!\n");
+				goto out;
+			}
+		}
+
+		spin_unlock(&remap->lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
+
+		remap_hit(remap);
+	}
+
+ out:
+	return remap;
+}
+
+void free_remap(struct dmu_map *remap)
+{
+	unsigned long flags;
+
+	if (error_bios(&remap->bios))
+		DMERR("Freed a map with in-flight data!");
+
+	spin_lock_irqsave(&remap->lock, flags);
+	remap->flags &= (~DMU_FLAG_INUSE);
+	spin_unlock_irqrestore(&remap->lock, flags);
+
+	spin_lock(&mru_list_lock);
+	list_del_init(&remap->mru_list);
+	list_add_tail(&remap->mru_list, &mru_list);
+	spin_unlock(&mru_list_lock);
+}
+
+void __free_remap(struct dmu_map *remap)
+{
+	if (error_bios(&remap->bios))
+		DMERR("Freed a map with in-flight data!");
+
+	remap->flags &= (~DMU_FLAG_INUSE);
+
+	spin_lock(&mru_list_lock);
+	list_del_init(&remap->mru_list);
+	list_add_tail(&remap->mru_list, &mru_list);
+	spin_unlock(&mru_list_lock);
+}
+
+void init_remap(struct dmu_device *dev, struct dmu_map *remap)
+{
+	spin_lock_init(&remap->lock);
+	remap->org_block = remap->new_block = 0;
+	remap->offset = 0;
+	remap->flags = DMU_FLAG_INUSE;
+	remap->src = remap->dest = NULL;
+	bio_list_init(&remap->bios);
+	bio_list_init(&remap->bios_waiting);
+	INIT_LIST_HEAD(&remap->list);
+	INIT_LIST_HEAD(&remap->in_flight);
+	remap->dev = dev;
+	remap->next = NULL;
+}
+
+void init_request(struct dmu_device *dev,
+		  int type,
+		  struct userspace_request *req)
+{
+	spin_lock_init(&req->lock);
+	INIT_LIST_HEAD(&req->list);
+	req->dev = dev;
+	req->type = type;
+	req->sent = 0;
+	req->flags = 0;
+	if (type == DM_USERSPACE_SYNC_COMPLETE) {
+		req->u.block = 0;
+		req->id = 0;
+	} else {
+		unsigned long flags;
+
+		bio_list_init(&req->u.bios);
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->id_counter++;
+		if (dev->id_counter == 0)
+			dev->id_counter = 1;
+		req->id = dev->id_counter;
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+	atomic_set(&req->refcnt, 0);
+}
+
+/*
+ * For an even block distribution, this is not too bad, but it could
+ * probably be better
+ */
+static uint32_t ht_hash(struct hash_table *ht, uint64_t block)
+{
+	return (uint32_t)block & ht->mask;
+}
+
+static int ht_init(struct hash_table *ht, unsigned long size)
+{
+	uint64_t i;
+	unsigned long pages;
+	unsigned int order = ffs((size * sizeof(struct list_head *)) /
+				 PAGE_SIZE);
+
+	pages = __get_free_pages(GFP_ATOMIC, order);
+	if (!pages)
+		return 0;
+
+	ht->table = (void *)pages;
+	ht->size = size;
+	ht->count = 0;
+	ht->mask = size - 1;
+
+	for (i = 0; i < size; i++)
+		INIT_LIST_HEAD(&ht->table[i]);
+
+	return 1;
+}
+
+static void ht_insert_bucket(struct dmu_map *map, struct list_head *list)
+{
+	list_add_tail(&map->list, list);
+}
+
+/*
+ * I'm sure this is quite dumb, but it works for now
+ */
+static int ht_should_grow(struct hash_table *ht)
+{
+	return ht->count > (2 * (ht->size / 4));
+}
+
+static void ht_grow_table(struct hash_table *ht);
+void ht_insert_map(struct hash_table *ht, struct dmu_map *map)
+{
+	uint32_t addr;
+
+	addr = ht_hash(ht, map->org_block) & ht->mask;
+
+	BUG_ON(addr >= ht->size);
+
+	ht_insert_bucket(map, &ht->table[addr]);
+	ht->count++;
+
+	if (ht_should_grow(ht))
+		ht_grow_table(ht);
+}
+
+void ht_delete_map(struct hash_table *ht, struct dmu_map *map)
+{
+	list_del_init(&map->list);
+	BUG_ON(ht->count == 0);
+	ht->count--;
+}
+
+struct dmu_map *ht_find_map(struct hash_table *ht, uint64_t block)
+{
+	uint32_t addr;
+	struct dmu_map *m;
+
+	addr = ht_hash(ht, block) & ht->mask;
+
+	BUG_ON(addr >= ht->size);
+
+	list_for_each_entry(m, &ht->table[addr], list) {
+		if (m->org_block == block) {
+			remap_hit(m);
+			return m;
+		}
+	}
+
+	return NULL;
+}
+
+struct dmu_map *ht_find_map_dev(struct dmu_device *dev, uint64_t block)
+{
+	struct dmu_map *remap;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	remap = ht_find_map(&dev->remaps, block);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return remap;
+}
+
+static void ht_grow_table(struct hash_table *ht)
+{
+	struct hash_table old_table;
+	uint64_t i;
+
+	old_table = *ht;
+
+	if (!ht_init(ht, old_table.size * 2))
+		return;
+
+	for (i = 0; i < old_table.size; i++ ) {
+		struct dmu_map *m, *n;
+		list_for_each_entry_safe(m, n, &old_table.table[i],
+					 list) {
+			list_del_init(&m->list);
+			ht_insert_map(ht, m);
+		}
+	}
+
+	free_pages((unsigned long)old_table.table,
+		   ffs((old_table.size * sizeof(struct list_head *))
+		       / PAGE_SIZE));
+}
+
+static uint64_t ht_destroy_table(struct hash_table *ht)
+{
+	uint64_t i, count = 0;
+	struct dmu_map *m, *n;
+
+	for (i = 0; i < ht->size; i++) {
+		list_for_each_entry_safe(m, n, &ht->table[i], list) {
+			ht_delete_map(ht, m);
+			free_remap(m);
+			count++;
+		}
+	}
+
+	return count;
+}
+
+struct target_device *find_target(struct dmu_device *dev,
+					 dev_t devno)
+{
+	struct target_device *target, *match = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	list_for_each_entry(target, &dev->target_devs, list) {
+		if (target->bdev->bd_dev == devno) {
+			match = target;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return match;
+}
+
+static struct target_device *get_target(struct dmu_device *dev,
+					dev_t devno)
+{
+
+	struct target_device *target;
+	struct block_device *bdev;
+	unsigned long flags;
+
+	target = find_target(dev, devno);
+	if (target)
+		return target;
+
+	bdev = open_by_devnum(devno, FMODE_READ | FMODE_WRITE);
+	if (IS_ERR(bdev)) {
+		DMERR("Unable to lookup device %x", devno);
+		return NULL;
+	}
+
+	target = kmalloc(sizeof(*target), GFP_KERNEL);
+	if (!target) {
+		DMERR("Unable to alloc new target device");
+		return NULL;
+	}
+
+	target->bdev = bdev;
+	INIT_LIST_HEAD(&target->list);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	list_add_tail(&target->list, &dev->target_devs);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return target;
+}
+
+/* Caller must hold dev->lock */
+static void put_target(struct dmu_device *dev,
+		       struct target_device *target)
+{
+	list_del(&target->list);
+
+	bd_release(target->bdev);
+	blkdev_put(target->bdev);
+
+	kfree(target);
+}
+
+/*
+ * This periodically dumps out some debug information.  It's really
+ * only useful while developing.
+ */
+static void watchdog(void *data)
+{
+	unsigned int v_remaps, i_remaps, reqs, s_reqs, devs = 0;
+	struct dmu_device *dev;
+	struct dmu_map *map;
+	struct userspace_request *req;
+	uint64_t i;
+
+	spin_lock(&devices_lock);
+
+	list_for_each_entry(dev, &devices, list) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev->lock, flags);
+
+		v_remaps = i_remaps = reqs = s_reqs = 0;
+
+		for (i = 0; i < dev->remaps.size; i++) {
+			list_for_each_entry(map, &dev->remaps.table[i], list)
+				if (dmu_get_flag(&map->flags, DMU_FLAG_VALID))
+					v_remaps++;
+				else
+					i_remaps++;
+		}
+
+		list_for_each_entry(req, &dev->requests, list)
+			if (req->sent)
+				s_reqs++;
+			else
+				reqs++;
+
+		printk("Device "
+		       "  reqs: %u/%u "
+		       "  inv maps: %u "
+		       "  val maps: %u\n",
+		       reqs, s_reqs, i_remaps, v_remaps);
+		devs++;
+
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+
+	spin_unlock(&devices_lock);
+
+	schedule_delayed_work(&wd, HZ);
+}
+
+void destroy_dmu_device(struct kref *ref)
+{
+	struct dmu_device *dev;
+	struct list_head *cursor, *next;
+	uint64_t remaps;
+
+	dev = container_of(ref, struct dmu_device, users);
+
+	spin_lock(&devices_lock);
+	list_del(&dev->list);
+	spin_unlock(&devices_lock);
+
+	list_for_each_safe(cursor, next, &dev->target_devs) {
+		struct target_device *target;
+
+		target = list_entry(cursor,
+				    struct target_device,
+				    list);
+
+		put_target(dev, target);
+	}
+
+	remaps = ht_destroy_table(&dev->remaps);
+
+	list_for_each_safe(cursor, next, &dev->requests) {
+		struct userspace_request *req;
+
+		req = list_entry(cursor,
+				 struct userspace_request,
+				 list);
+
+		list_del(&req->list);
+
+		error_bios(&req->u.bios);
+
+		mempool_free(req, request_pool);
+	}
+
+	kcopyd_client_destroy(dev->kcopy);
+	unregister_chardev_transport(dev);
+
+	kfree(dev);
+}
+
+static int init_dmu_device(struct dmu_device *dev, u32 block_size)
+{
+	int ret;
+
+	init_waitqueue_head(&dev->wqueue);
+	INIT_LIST_HEAD(&dev->list);
+	INIT_LIST_HEAD(&dev->requests);
+	INIT_LIST_HEAD(&dev->target_devs);
+	INIT_LIST_HEAD(&dev->in_flight);
+	kref_init(&dev->users);
+	spin_lock_init(&dev->lock);
+
+	dev->id_counter = 1; /* reserve 0 for unsolicited maps */
+
+	if (!ht_init(&dev->remaps, 2048)) {
+		DMERR("Unable to allocate hash table");
+		return 0;
+	}
+
+	dev->block_size  = block_size;
+	dev->block_mask  = block_size - 1;
+	dev->block_shift = ffs(block_size) - 1;
+
+	ret = kcopyd_client_create(DMU_COPY_PAGES, &dev->kcopy);
+	if (ret) {
+		DMERR("Failed to initialize kcopyd client");
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct dmu_device *new_dmu_device(char *key,
+					 struct dm_target *ti,
+					 u32 block_size)
+{
+	struct dmu_device *dev;
+	int                ret;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev == NULL) {
+		DMERR("Failed to allocate new userspace device");
+		return NULL;
+	}
+
+	if (!init_dmu_device(dev, block_size))
+		goto bad1;
+
+	snprintf(dev->key, DMU_KEY_LEN, "%s", key);
+
+	ret = register_chardev_transport(dev);
+	if (!ret)
+		goto bad2;
+
+	spin_lock(&devices_lock);
+	list_add(&dev->list, &devices);
+	spin_unlock(&devices_lock);
+
+	return dev;
+
+ bad2:
+	put_dev(dev);
+ bad1:
+	kfree(dev);
+	DMERR("Failed to create device");
+	return NULL;
+}
+
+static struct dmu_device *find_dmu_device(const char *key)
+{
+	struct dmu_device *dev;
+	struct dmu_device *match = NULL;
+
+	spin_lock(&devices_lock);
+
+	list_for_each_entry(dev, &devices, list) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev->lock, flags);
+		if (strncmp(dev->key, key, DMU_KEY_LEN) == 0) {
+			match = dev;
+			spin_unlock(&dev->lock);
+			break;
+		}
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+
+	spin_unlock(&devices_lock);
+
+	return match;
+}
+
+static int dmu_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	uint64_t block_size;
+	struct dmu_device *dev;
+	char *device_key;
+	char *block_size_param;
+	int target_idx = 2;
+	unsigned long flags;
+
+	if (argc < 3) {
+		ti->error = "Invalid argument count";
+		return -EINVAL;
+	}
+
+	device_key = argv[0];
+	block_size_param = argv[1];
+
+	block_size = simple_strtoul(block_size_param, NULL, 10) / 512;
+
+	dev = find_dmu_device(device_key);
+	if (dev == NULL) {
+		dev = new_dmu_device(device_key,
+				     ti,
+				     block_size);
+		if (dev == NULL) {
+			ti->error = "Failed to create device";
+			goto bad;
+		}
+	} else {
+		get_dev(dev);
+	}
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->block_size != block_size) {
+		ti->error = "Invalid block size";
+		goto bad;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	/* Resolve target devices */
+	do {
+		int maj, min;
+		sscanf(argv[target_idx], "%i:%i", &maj, &min);
+		if (!get_target(dev, MKDEV(maj, min))) {
+			DMERR("Failed to find target device %i:%i (%s)",
+			      maj, min, argv[target_idx]);
+			goto out;
+		}
+	} while (++target_idx < argc);
+
+	ti->private  = dev;
+	ti->split_io = block_size;
+
+	return 0;
+
+ bad:
+	if (dev) {
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+ out:
+	if (dev) {
+		put_dev(dev);
+	}
+
+	return -EINVAL;
+}
+
+static void dmu_dtr(struct dm_target *ti)
+{
+	struct dmu_device *dev = (struct dmu_device *) ti->private;
+
+	put_dev(dev);
+}
+
+/* Search @dev for an outstanding request for remapping @block */
+static struct userspace_request *find_existing_req(struct dmu_device *dev,
+						   uint64_t block)
+{
+	struct userspace_request *req;
+	struct userspace_request *maybe = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	list_for_each_entry(req, &dev->requests, list) {
+		if ((req->type == DM_USERSPACE_MAP_BLOCK_REQ) &&
+		    (dmu_block(dev, req->u.bios.head->bi_sector) == block)) {
+			if (maybe) {
+				atomic_dec(&maybe->refcnt);
+			}
+			maybe = req;
+			atomic_inc(&maybe->refcnt);
+		}
+	}
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return maybe;
+}
+
+static int make_new_request(struct dmu_device *dev, struct bio *bio)
+{
+	struct userspace_request *req;
+
+	req = mempool_alloc(request_pool, GFP_NOIO);
+	if (req == NULL)
+		goto bad;
+
+	init_request(dev, DM_USERSPACE_MAP_BLOCK_REQ, req);
+
+	dmu_set_flag(&req->flags, DMU_FLAG_RD);
+	if (bio_rw(bio))
+		dmu_set_flag(&req->flags, DMU_FLAG_WR);
+	else
+		dmu_clr_flag(&req->flags, DMU_FLAG_WR);
+	bio_list_add(&req->u.bios, bio);
+
+	add_request(dev, req);
+
+	return 0;
+
+ bad:
+	DMERR("Failed to queue bio!");
+	return -1;
+}
+
+static int dmu_map_remap_case(struct dmu_device *dev,
+			      struct dmu_map *remap,
+			      struct bio *bio)
+{
+	int ret = 0;
+	int rw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&remap->lock, flags);
+
+	/*
+	 * We've got it locked, so make sure the info is still valid
+	 * before we use it
+	 */
+	if (!dmu_get_flag(&remap->flags, DMU_FLAG_INUSE)) {
+		ret = -1;
+		goto unlock;
+	} else if (remap->org_block != dmu_block(dev, bio->bi_sector)) {
+		ret = -1;
+		goto unlock;
+	}
+
+	rw = dmu_get_flag(&remap->flags, DMU_FLAG_WR);
+
+	if (bio_rw(bio) && !rw) {
+		ret = -1;
+	} else {
+		if (dmu_get_flag(&remap->flags, DMU_FLAG_VALID)) {
+			__bio_remap(bio, remap);
+			ret = 1;
+		} else {
+			bio_list_add(&remap->bios, bio);
+		}
+	}
+
+ unlock:
+	spin_unlock_irqrestore(&remap->lock, flags);
+
+	return ret;
+}
+
+static int dmu_map_request_case(struct dmu_device *dev,
+				struct userspace_request *req,
+				struct bio *bio)
+{
+	int ret = 0;
+	int req_rw = dmu_get_flag(&req->flags, DMU_FLAG_WR);
+
+	spin_lock(&req->lock);
+
+	if (!req_rw && bio_rw(bio) && !req->sent) {
+		/* Convert to R/W and Queue */
+		dmu_set_flag(&req->flags, DMU_FLAG_WR);
+		bio_list_add(&req->u.bios, bio);
+	} else if (!req_rw && bio_rw(bio) && req->sent) {
+		/* Can't convert, must re-request */
+		ret = -1;
+	} else {
+		/* Queue */
+		bio_list_add(&req->u.bios, bio);
+	}
+
+	spin_unlock(&req->lock);
+
+	return ret;
+}
+
+static int dmu_map(struct dm_target *ti, struct bio *bio,
+		   union map_info *map_context)
+{
+	struct dmu_device *dev = (struct dmu_device *) ti->private;
+	struct dmu_map *remap;
+	struct userspace_request *req;
+	int ret = 0;
+	u64 block;
+
+	block = dmu_block(dev, bio->bi_sector);
+
+	remap = ht_find_map_dev(dev, block);
+	if (remap) {
+		ret = dmu_map_remap_case(dev, remap, bio);
+		if (ret >= 0)
+			goto done;
+	}
+
+	req = find_existing_req(dev, block);
+	if (req) {
+		ret = dmu_map_request_case(dev, req, bio);
+		atomic_dec(&req->refcnt);
+		if (ret >= 0)
+			goto done;
+	}
+
+	ret = make_new_request(dev, bio);
+
+ done:
+	return ret;
+}
+
+static int dmu_status(struct dm_target *ti, status_type_t type,
+		      char *result, unsigned int maxlen)
+{
+	struct dmu_device *dev = (struct dmu_device *) ti->private;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		write_chardev_transport_info(dev, result, maxlen);
+		break;
+
+	case STATUSTYPE_TABLE:
+		snprintf(result, maxlen, "%s %llu",
+			 dev->key,
+			 dev->block_size * 512);
+		break;
+	}
+
+	return 0;
+}
+
+static struct userspace_request *make_sync_req(struct dmu_device
+							 *dev,
+							 uint32_t id)
+{
+       struct userspace_request *req;
+       req = mempool_alloc(request_pool, GFP_ATOMIC);
+       if (!req) {
+	       printk(KERN_ERR  "Failed to allocate copy response\n");
+	       return NULL;
+       }
+       init_request(dev, DM_USERSPACE_SYNC_COMPLETE, req);
+       req->id = id;
+
+       return req;
+}
+
+static int __handle_bio_endio(struct dmu_map *remap,
+			      struct bio *bio,
+			      struct userspace_request **req)
+{
+	int ret = 0;
+
+	spin_lock(&remap->lock); /* IRQs already disabled */
+	if (dmu_get_flag(&remap->flags, DMU_FLAG_WAITING) &&
+	    remap->bios_waiting.head == NULL) {
+		/* First endio and waiting for resp from userspace */
+		bio_list_add(&remap->bios_waiting, bio);
+		*req = make_sync_req(remap->dev, remap->id);
+		if (*req)
+			ret = 1;
+		else
+			ret = 0; /* Failed to alloc, allow retry */
+	} else if (dmu_get_flag(&remap->flags,
+				DMU_FLAG_WAITING)) {
+		/* Still waiting for resp from userspace */
+		bio_list_add(&remap->bios_waiting, bio);
+		ret = 1;
+	} else if (remap->bios_waiting.head != NULL) {
+		/* Got resp from userspace but bios waiting list nonempty */
+		if (bio->bi_sector == remap->bios_waiting.head->bi_sector) {
+			bio_list_pop(&remap->bios_waiting);
+			ret = 0;
+		} else {
+			bio_list_add(&remap->bios_waiting, bio);
+			ret = 1;
+		}
+	} else {
+		/* no waiting, list empty, remove from remap */
+		list_del(&remap->in_flight);
+		ret = 0;
+	}
+	spin_unlock(&remap->lock);
+
+	return ret;
+}
+
+static int dmu_end_io(struct dm_target *ti, struct bio *bio,
+                        int error, union map_info *map_context)
+{
+	struct dmu_device *dev = (struct dmu_device *) ti->private;
+	struct dmu_map *p;
+	struct userspace_request *req = NULL;
+	u64 block;
+	int ret = 0;
+	unsigned long flags;
+
+	if (error) {
+		DMERR("Error in dmu_end_io\n");
+		return -1;
+	}
+
+	block = dmu_block(dev, bio->bi_sector);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	list_for_each_entry(p, &dev->in_flight, in_flight) {
+		if (p->new_block == block) {
+			ret = __handle_bio_endio(p, bio, &req);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (req)
+		add_request(dev, req);
+
+	return ret;
+}
+
+struct target_type userspace_target = {
+	.name    = "userspace",
+	.version = {0, 1, 0},
+	.module  = THIS_MODULE,
+	.ctr     = dmu_ctr,
+	.dtr     = dmu_dtr,
+	.map     = dmu_map,
+	.status  = dmu_status,
+	.end_io   = dmu_end_io
+};
+
+static int destroy_mru_list(void)
+{
+	struct dmu_map *map, *next;
+	int count = 0;
+
+	spin_lock(&mru_list_lock);
+
+	list_for_each_entry_safe(map, next, &mru_list, mru_list) {
+		list_del(&map->mru_list);
+		kmem_cache_free(remap_cache, map);
+		count++;
+	}
+
+	spin_unlock(&mru_list_lock);
+
+	return count;
+}
+
+int __init dm_userspace_init(void)
+{
+	int i;
+	int r = dm_register_target(&userspace_target);
+	if (r < 0) {
+		DMERR("Register failed %d", r);
+		return 0;
+	}
+
+	spin_lock_init(&devices_lock);
+	spin_lock_init(&mru_list_lock);
+
+	if (enable_watchdog) {
+		INIT_WORK(&wd, watchdog, NULL);
+		schedule_delayed_work(&wd, HZ);
+	}
+
+	request_cache =
+		kmem_cache_create("dm-userspace-requests",
+				  sizeof(struct userspace_request),
+				  __alignof__ (struct userspace_request),
+				  0, NULL, NULL);
+	if (!request_cache) {
+		DMERR("Failed to allocate request cache");
+		goto bad;
+	}
+
+	remap_cache =
+		kmem_cache_create("dm-userspace-remaps",
+				  sizeof(struct dmu_map),
+				  __alignof__ (struct dmu_map),
+				  0, NULL, NULL);
+	if (!remap_cache) {
+		DMERR("Failed to allocate remap cache");
+		goto bad2;
+	}
+
+	request_pool = mempool_create(64,
+				      mempool_alloc_slab, mempool_free_slab,
+				      request_cache);
+	if (!request_pool) {
+		DMERR("Failed to allocate request pool");
+		goto bad3;
+	}
+
+	r = init_chardev_transport();
+	if (!r)
+		goto bad4;
+
+	for (i = 0; i < DMU_REMAP_RESERVE; i++) {
+		struct dmu_map *remap;
+
+		remap = alloc_remap_atomic(NULL);
+		if (!remap) {
+			DMERR("Failed to allocate %i/%i reserve remap",
+			      i, DMU_REMAP_RESERVE);
+			goto bad5;
+		}
+		init_remap(NULL, remap);
+		remap_hit(remap);
+	}
+
+	return 1;
+
+ bad5:
+	destroy_mru_list();
+ bad4:
+	mempool_destroy(request_pool);
+ bad3:
+	kmem_cache_destroy(remap_cache);
+ bad2:
+	kmem_cache_destroy(request_cache);
+ bad:
+	dm_unregister_target(&userspace_target);
+
+	return 0;
+}
+
+void __exit dm_userspace_exit(void)
+{
+	int r;
+	struct list_head *cursor, *next;
+	struct dmu_device *dev;
+
+	if (enable_watchdog)
+		if (!cancel_delayed_work(&wd))
+			flush_scheduled_work();
+
+	spin_lock(&devices_lock);
+
+	list_for_each_safe(cursor, next, &devices) {
+		dev = list_entry(cursor, struct dmu_device, list);
+		list_del(cursor);
+		destroy_dmu_device(&dev->users);
+		DMERR("Destroying hanging device %s", dev->key);
+	}
+
+	spin_unlock(&devices_lock);
+
+	cleanup_chardev_transport();
+
+	r = destroy_mru_list();
+
+	mempool_destroy(request_pool);
+	kmem_cache_destroy(request_cache);
+	kmem_cache_destroy(remap_cache);
+
+	r = dm_unregister_target(&userspace_target);
+	if (r < 0)
+		DMERR("unregister failed %d", r);
+}
+
+module_init(dm_userspace_init);
+module_exit(dm_userspace_exit);
+
+module_param(enable_watchdog, int, S_IRUGO);
+
+MODULE_DESCRIPTION(DM_NAME " userspace target");
+MODULE_AUTHOR("Dan Smith");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.17.6-orig/drivers/md/dm-userspace-chardev.c linux-2.6.17.6-dmu/drivers/md/dm-userspace-chardev.c
--- linux-2.6.17.6-orig/drivers/md/dm-userspace-chardev.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.6-dmu/drivers/md/dm-userspace-chardev.c	2006-07-27 14:32:05.000000000 -0700
@@ -0,0 +1,856 @@
+/*
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Dan Smith <danms@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/mempool.h>
+#include <linux/dm-userspace.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <asm/uaccess.h>
+
+#include "dm.h"
+#include "dm-bio-list.h"
+#include "kcopyd.h"
+#include "dm-user.h"
+
+#define DM_MSG_PREFIX "dm-userspace"
+
+/* This allows for a cleaner separation between the dm-userspace
+ * device-mapper target, and the userspace transport used.  Right now,
+ * only a chardev transport exists, but it's possible that there could
+ * be more in the future
+ */
+struct chardev_transport {
+	struct cdev cdev;
+	dev_t ctl_dev;
+	struct dmu_device *parent;
+};
+
+static void remap_flusher(struct dmu_map *remap);
+
+static int have_pending_requests(struct dmu_device *dev)
+{
+	struct userspace_request *req;
+	int ret = 0;
+	unsigned long flags;
+
+	/* FIXME: We should keep a count of how many waiting reqs
+	 * there are, eliminating the need to count, and possibly the
+	 * need to lock
+	 */
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	list_for_each_entry(req, &dev->requests, list) {
+		if (!req->sent) {
+			ret = 1;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return ret;
+}
+
+static void copy_callback(int read_err,
+                          unsigned int write_err,
+                          void *data)
+{
+	remap_flusher((struct dmu_map *)data);
+}
+
+static void copy_block(struct dmu_map *remap)
+{
+	struct io_region src, dst;
+	struct kcopyd_client *client;
+	unsigned long flags;
+
+	spin_lock_irqsave(&remap->lock, flags);
+
+	src.bdev = remap->src->bdev;
+	src.sector = remap->org_block << remap->dev->block_shift;
+	src.count = remap->dev->block_size;
+
+	dst.bdev = remap->dest->bdev;
+	dst.sector = (remap->new_block << remap->dev->block_shift);
+	dst.sector += remap->offset;
+	dst.count = remap->dev->block_size;
+
+	client = remap->dev->kcopy;
+
+	spin_unlock_irqrestore(&remap->lock, flags);
+
+	kcopyd_copy(client, &src, 1, &dst, 0, copy_callback, remap);
+}
+
+static void copy_or_flush(struct dmu_map *remap)
+{
+	int copy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&remap->lock, flags);
+	copy = dmu_get_flag(&remap->flags, DMU_FLAG_COPY_FIRST);
+	spin_unlock_irqrestore(&remap->lock, flags);
+
+	if (copy)
+		copy_block(remap);
+	else
+		remap_flusher(remap);
+}
+
+static struct bio *pop_and_remap(struct dmu_map *remap)
+{
+	struct bio *bio = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&remap->lock, flags);
+
+	bio = bio_list_pop(&remap->bios);
+	if (bio)
+		__bio_remap(bio, remap);
+	else {
+		/* If there are no more bios, we must set the VALID
+		 * flag before we release the lock
+		 */
+		dmu_set_flag(&remap->flags, DMU_FLAG_VALID);
+	}
+
+	spin_unlock_irqrestore(&remap->lock, flags);
+
+	return bio;
+}
+
+static void get_remap_attrs(struct dmu_map *remap,
+			    int *copy_first,
+			    int *temporary,
+			    struct dmu_map **next)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&remap->lock, flags);
+
+	*copy_first = dmu_get_flag(&remap->flags, DMU_FLAG_COPY_FIRST);
+	*temporary = dmu_get_flag(&remap->flags, DMU_FLAG_TEMPORARY);
+	*next = remap->next;
+	remap->next = NULL;
+
+	spin_unlock_irqrestore(&remap->lock, flags);
+}
+
+static void remap_flusher(struct dmu_map *remap)
+{
+	struct bio *bio;
+	int copy_first = 0, temporary = 0;
+	struct dmu_map *next;
+
+	while (1) {
+
+		bio = pop_and_remap(remap);
+
+		if (bio)
+			generic_make_request(bio);
+		else
+			break;
+	}
+
+	get_remap_attrs(remap, &copy_first, &temporary, &next);
+
+	if (next)
+		copy_or_flush(next);
+
+	if (temporary)
+		free_remap(remap);
+}
+
+static int send_userspace_message(uint8_t __user *buffer,
+				  struct userspace_request *req)
+{
+	int ret = 0;
+	struct dmu_msg_header hdr;
+	union {
+		struct dmu_msg_map_request map_req;
+		struct dmu_msg_status status_req;
+		struct dmu_msg_version ver_req;
+	} msgs;
+
+	spin_lock(&req->lock);
+
+	hdr.id = req->id;
+
+	switch (req->type) {
+	case DM_USERSPACE_GET_VERSION:
+		hdr.msg_type = req->type;
+		hdr.payload_len = sizeof(msgs.ver_req);
+		msgs.ver_req.kernel_ver =
+			userspace_target.version[0] << 16 |
+			userspace_target.version[1] << 8  |
+			userspace_target.version[2];
+
+		break;
+
+	case DM_USERSPACE_MAP_BLOCK_REQ:
+		hdr.msg_type = req->type;
+		hdr.payload_len = sizeof(msgs.map_req);
+		msgs.map_req.org_block =
+			dmu_block(req->dev, req->u.bios.head->bi_sector);
+		dmu_cpy_flag(&msgs.map_req.flags, req->flags, DMU_FLAG_RD);
+		dmu_cpy_flag(&msgs.map_req.flags, req->flags, DMU_FLAG_WR);
+
+		break;
+
+	case DM_USERSPACE_SYNC_COMPLETE:
+	case DM_USERSPACE_INVAL_COMPLETE:
+	case DM_USERSPACE_INVAL_FAILED:
+		hdr.msg_type = DM_USERSPACE_STATUS;
+		hdr.payload_len = sizeof(msgs.status_req);
+		msgs.status_req.status = req->type;
+		msgs.status_req.id_of_op = req->id;
+
+		break;
+
+	default:
+		DMWARN("Unknown message type %i", req->type);
+		ret = 0;
+	}
+
+	spin_unlock(&req->lock);
+
+	if (copy_to_user(buffer, &hdr, sizeof(hdr)))
+		return -EFAULT;
+	if (copy_to_user(buffer + sizeof(hdr), &msgs, hdr.payload_len))
+		return -EFAULT;
+
+	ret = sizeof(hdr) + hdr.payload_len;
+
+	if (req->type != DM_USERSPACE_MAP_BLOCK_REQ) {
+		unsigned long flags;
+		/* Only map requests get responses, so we take others
+		 * off the request queue here
+		 */
+		spin_lock_irqsave(&req->dev->lock, flags);
+		list_del(&req->list);
+		spin_unlock_irqrestore(&req->dev->lock, flags);
+		mempool_free(req, request_pool);
+	}
+
+	return ret;
+}
+
+struct userspace_request *pluck_next_request(struct dmu_device *dev,
+					     int size_available)
+{
+	struct userspace_request *req, *match = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	list_for_each_entry(req, &dev->requests, list) {
+		spin_lock(&req->lock);
+		if (!req->sent) {
+			if (dmu_get_msg_len(req->type) < size_available) {
+				req->sent = 1;
+				match = req;
+			} else {
+				/* Must break here to preserve order */
+				spin_unlock(&req->lock);
+				break;
+			}
+		}
+		spin_unlock(&req->lock);
+
+		if (match)
+			break;
+	}
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return match;
+}
+
+ssize_t dmu_ctl_read(struct file *file, char __user *buffer,
+		     size_t size, loff_t *offset)
+{
+
+	struct dmu_device *dev = (struct dmu_device *)file->private_data;
+	struct userspace_request *req = NULL;
+	int ret = 0, r;
+
+        if (!capable(CAP_SYS_ADMIN))
+                return -EACCES;
+
+	while (!have_pending_requests(dev)) {
+		if (file->f_flags & O_NONBLOCK) {
+			return 0;
+		}
+
+		if (wait_event_interruptible(dev->wqueue,
+					     have_pending_requests(dev)))
+			return -ERESTARTSYS;
+	}
+
+	while(ret < size) {
+		req = pluck_next_request(dev, size - ret);
+		if (!req)
+			/* One or more of the following conditions is true:
+			 * 1. No more requests available for sending
+			 * 2. No more room in the outgoing buffer
+			 */
+			break;
+
+		r = send_userspace_message((void *)(buffer + ret), req);
+		if (r == 0)
+			continue;
+		else if (r < 0)
+			return r;
+
+		ret += r;
+	}
+
+	return ret;
+}
+
+static int remap_request(struct dmu_msg_map_response *msg,
+			 struct dmu_device *dev, uint32_t id)
+{
+	struct dmu_map *remap = NULL, *parent = NULL;
+	struct target_device *s_dev = NULL, *d_dev = NULL;
+	int is_chained = 0;
+	struct bio_list bio_holder;
+	struct userspace_request *cursor, *next, *req = NULL;
+	unsigned long flags;
+
+	/* See if we have a pending request that matches */
+	spin_lock_irqsave(&dev->lock, flags);
+	list_for_each_entry_safe(cursor, next, &dev->requests, list) {
+		if ((cursor->type == DM_USERSPACE_MAP_BLOCK_REQ) &&
+		    (cursor->id == msg->id_of_req)) {
+			req = cursor;
+			list_del(&req->list);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (dmu_get_flag(&msg->flags, DMU_FLAG_COPY_FIRST)) {
+		s_dev = find_target(dev, MKDEV(msg->src_maj, msg->src_min));
+		if (!s_dev) {
+			DMERR("Failed to find src device %i:%i",
+			       msg->src_maj, msg->src_min);
+			goto bad;
+		}
+	}
+
+	d_dev = find_target(dev, MKDEV(msg->dst_maj, msg->dst_min));
+	if (!d_dev) {
+		DMERR("Failed to find dest device %i:%i",
+		       msg->dst_maj, msg->dst_min);
+		goto bad;
+	}
+
+	if (req) {
+		while (atomic_read(&req->refcnt) != 0)
+			/* Wait for exclusive use of request.  Even
+			 * though we have removed it from the list,
+			 * someone still has a pointer to it, which
+			 * means we must wait for them to finish with
+			 * it before continuing.
+			 */
+			schedule();
+
+		bio_holder = req->u.bios;
+		mempool_free(req, request_pool);
+	} else {
+		bio_list_init(&bio_holder);
+	}
+
+	/* Allocate a new remap early (before grabbing locks), since
+	 * we will most likely need it
+	 */
+	remap = alloc_remap_atomic(dev);
+	if (!remap) {
+		DMERR("Failed to alloc remap!");
+		goto bad;
+	}
+
+	init_remap(dev, remap);
+
+	/* We don't need IRQ protection here, because we just created
+	 * this
+	 */
+	spin_lock(&remap->lock);
+	remap->org_block = msg->org_block;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	/* Here, we insert the new remap into the table, and remove
+	 * the existing map, if present, all in one locked operation
+	 */
+
+	parent = ht_find_map(&dev->remaps, msg->org_block);
+	if (parent) {
+
+		spin_lock(&parent->lock); /* IRQs already disabled */
+
+		if (!dmu_get_flag(&parent->flags, DMU_FLAG_INUSE)) {
+			/* This is in the process of being destroyed,
+			 * so we can't use it
+			*/
+			goto end_parent;
+		}
+
+		if (!dmu_get_flag(&parent->flags, DMU_FLAG_VALID)) {
+			if (dmu_get_flag(&parent->flags, DMU_FLAG_WR) ==
+			    dmu_get_flag(&msg->flags, DMU_FLAG_WR) &&
+			    (parent->new_block == msg->new_block)) {
+				/* Perms match for this not-yet-valid remap,
+				   so tag our bios on to it and bail */
+				bio_list_merge(&parent->bios,
+					       &bio_holder);
+
+				spin_unlock(&parent->lock);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				__free_remap(remap);
+				return 1;
+			} else {
+				/* Remove parent from remap table, and
+				 * chain our new remap to this one so
+				 * it will fire when parent goes
+				 * valid
+				 */
+				list_del_init(&parent->list);
+				if (parent->next) {
+					DMERR("Parent already chained!");
+					BUG();
+				}
+				parent->next = remap;
+				dmu_set_flag(&parent->flags,
+					     DMU_FLAG_TEMPORARY);
+				is_chained = 1;
+			}
+		} else {
+			/* Remove existing valid remap */
+			__free_remap(parent);
+		}
+
+	end_parent:
+		spin_unlock(&parent->lock);
+	}
+
+	ht_insert_map(&dev->remaps, remap);
+
+	if (dmu_get_flag(&msg->flags, DMU_FLAG_SYNC)) {
+		list_add_tail(&remap->in_flight, &dev->in_flight);
+		dmu_set_flag(&remap->flags, DMU_FLAG_WAITING);
+	}
+
+	remap->new_block  = msg->new_block;
+	remap->offset     = msg->offset;
+	remap->src        = s_dev;
+	remap->dest       = d_dev;
+	remap->dev        = dev;
+	remap->id         = id;
+
+	dmu_cpy_flag(&remap->flags, msg->flags, DMU_FLAG_COPY_FIRST);
+	dmu_cpy_flag(&remap->flags, msg->flags, DMU_FLAG_TEMPORARY);
+	dmu_cpy_flag(&remap->flags, msg->flags, DMU_FLAG_SYNC);
+	dmu_cpy_flag(&remap->flags, msg->flags, DMU_FLAG_WR);
+	dmu_cpy_flag(&remap->flags, msg->flags, DMU_FLAG_RD);
+	dmu_clr_flag(&remap->flags, DMU_FLAG_VALID);
+
+	remap->bios = bio_holder;
+
+	spin_unlock(&remap->lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (! is_chained)
+		copy_or_flush(remap);
+
+	return 1;
+
+ bad:
+	DMERR("Remap error: chaos may ensue");
+
+	return 0;
+}
+
+static int version_request(struct dmu_msg_version *msg,
+			   struct dmu_device *dev, uint32_t id)
+{
+	struct userspace_request *req;
+
+	req = mempool_alloc(request_pool, GFP_NOIO);
+	if (!req) {
+		DMERR("Failed to alloc version response");
+		return 0;
+	}
+
+	init_request(dev, DM_USERSPACE_GET_VERSION, req);
+	add_request(dev, req);
+
+	return 1;
+}
+
+static int invalidate_request(struct dmu_msg_invalidate_map *msg,
+			      struct dmu_device *dev, uint32_t id)
+{
+	struct dmu_map *remap;
+	struct userspace_request *req;
+	int ret = 1;
+	unsigned long flags;
+
+	remap = ht_find_map_dev(dev, msg->org_block);
+	if (!remap)
+		ret = 0;
+	else {
+		spin_lock_irqsave(&dev->lock, flags);
+		spin_lock(&remap->lock); /* IRQs already disabled */
+		if (dmu_get_flag(&remap->flags, DMU_FLAG_VALID))
+			ht_delete_map(&dev->remaps, remap);
+		else
+			ret = 0;
+		spin_unlock(&remap->lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+
+	req = mempool_alloc(request_pool, GFP_NOIO);
+	if (!req) {
+		DMERR("Failed to allocate request");
+		return 0;
+	}
+
+	if (ret)
+		init_request(dev, DM_USERSPACE_INVAL_COMPLETE, req);
+	else
+		init_request(dev, DM_USERSPACE_INVAL_FAILED, req);
+
+	req->u.block = msg->org_block;
+	req->id = id;
+
+	add_request(dev, req);
+
+	return ret;
+}
+
+static void sync_complete(struct dmu_device *dev, uint32_t id_of_op) {
+	struct dmu_map *p, *match = NULL;
+	struct bio *bio;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	list_for_each_entry(p, &dev->in_flight, in_flight) {
+		if (p->id == id_of_op) {
+			match = p;
+			break;
+		}
+
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (match) {
+		spin_lock(&match->lock);
+		dmu_clr_flag(&match->flags, DMU_FLAG_WAITING);
+		spin_unlock(&match->lock);
+		while(1) {
+			spin_lock(&match->lock);
+			bio = match->bios_waiting.head;
+			spin_unlock(&match->lock);
+			if (!bio)
+				break;
+			bio->bi_end_io(bio, 0, 0);
+		}
+	} else {
+		DMERR("Unable to complete unknown request %u\n", id_of_op);
+	}
+}
+
+
+ssize_t dmu_ctl_write(struct file *file, const char __user *buffer,
+		      size_t size, loff_t *offset)
+{
+	struct dmu_device *dev = (struct dmu_device *)file->private_data;
+	int ret = 0;
+	struct dmu_msg_header hdr;
+	union {
+		struct dmu_msg_map_response map_rsp;
+		struct dmu_msg_invalidate_map inval_rsp;
+		struct dmu_msg_version ver_req;
+		struct dmu_msg_status status_rsp;
+	} msgs;
+
+        if (!capable(CAP_SYS_ADMIN))
+                return -EACCES;
+
+	while ((ret + sizeof(hdr)) < size) {
+		if (copy_from_user(&hdr, buffer+ret, sizeof(hdr))) {
+			DMERR("%s copy_from_user failed!", __FUNCTION__);
+			ret = -EFAULT;
+			goto out;
+		}
+
+		ret += sizeof(hdr);
+
+		switch (hdr.msg_type) {
+
+		case DM_USERSPACE_GET_VERSION:
+			if (hdr.payload_len != sizeof(msgs.ver_req)) {
+				DMERR("Malformed version request");
+				break;
+			}
+
+			if (copy_from_user(&msgs.ver_req, buffer+ret,
+					   sizeof(msgs.ver_req))) {
+				DMERR("%s copy_from_user failed!",
+				      __FUNCTION__);
+				ret = -EFAULT;
+				goto out;
+			}
+
+			version_request(&msgs.ver_req, dev, hdr.id);
+			break;
+
+		case DM_USERSPACE_MAP_BLOCK_RESP:
+			if (hdr.payload_len != sizeof(msgs.map_rsp)) {
+				DMERR("Malformed block response");
+				break;
+			}
+
+			if (copy_from_user(&msgs.map_rsp, buffer+ret,
+					   sizeof(msgs.map_rsp))) {
+				DMERR("%s copy_from_user failed!",
+				      __FUNCTION__);
+				ret = -EFAULT;
+				goto out;
+			}
+
+			remap_request(&msgs.map_rsp, dev,
+				      msgs.map_rsp.id_of_req);
+			break;
+
+		case DM_USERSPACE_MAP_FAILED:
+			if (hdr.payload_len != sizeof(msgs.map_rsp)) {
+				DMERR("Malformed block failed response");
+				break;
+			}
+
+			if (copy_from_user(&msgs.map_rsp, buffer+ret,
+					   sizeof(msgs.map_rsp))) {
+				DMERR("%s copy_from_user failed",
+				      __FUNCTION__);
+				ret = -EFAULT;
+				goto out;
+			}
+
+			DMERR("Userspace map failed");
+			break;
+
+		case DM_USERSPACE_MAP_INVALIDATE:
+			if (hdr.payload_len != sizeof(msgs.inval_rsp)) {
+				DMERR("Malformed invalidate request");
+				break;
+			}
+
+			if (copy_from_user(&msgs.inval_rsp, buffer+ret,
+					   sizeof(msgs.inval_rsp))) {
+				DMERR("%s copy_from_user failed",
+				      __FUNCTION__);
+				ret = -EFAULT;
+				goto out;
+			}
+
+			invalidate_request(&msgs.inval_rsp, dev, hdr.id);
+			break;
+
+		case DM_USERSPACE_STATUS:
+			if (hdr.payload_len != sizeof(msgs.status_rsp)) {
+				DMERR("Malformed invalidate request");
+				break;
+			}
+
+			if (copy_from_user(&msgs.status_rsp, buffer+ret,
+					   sizeof(msgs.status_rsp))) {
+				DMERR("%s copy_from_user failed",
+				      __FUNCTION__);
+				ret = -EFAULT;
+				goto out;
+			}
+
+			if (msgs.status_rsp.status ==
+			    DM_USERSPACE_SYNC_COMPLETE) {
+				sync_complete(dev, msgs.status_rsp.id_of_op);
+			}
+			break;
+
+		default:
+			DMWARN("Unknown request type: %i", hdr.msg_type);
+		}
+
+		ret += hdr.payload_len;
+	}
+ out:
+	return ret;
+}
+
+int dmu_ctl_open(struct inode *inode, struct file *file)
+{
+	struct chardev_transport *t;
+	struct dmu_device *dev;
+
+        if (!capable(CAP_SYS_ADMIN))
+                return -EACCES;
+
+	t = container_of(inode->i_cdev, struct chardev_transport, cdev);
+	dev = t->parent;
+
+	get_dev(dev);
+
+	file->private_data = dev;
+
+	return 0;
+}
+
+int dmu_ctl_release(struct inode *inode, struct file *file)
+{
+	struct dmu_device *dev;
+
+	dev = (struct dmu_device *)file->private_data;
+
+	put_dev(dev);
+
+	return 0;
+}
+
+unsigned dmu_ctl_poll(struct file *file, poll_table *wait)
+{
+	struct dmu_device *dev = (struct dmu_device *)file->private_data;
+	unsigned mask = 0;
+
+	poll_wait(file, &dev->wqueue, wait);
+
+	if (have_pending_requests(dev))
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static struct file_operations ctl_fops = {
+	.open    = dmu_ctl_open,
+	.release = dmu_ctl_release,
+	.read    = dmu_ctl_read,
+	.write   = dmu_ctl_write,
+	.poll    = dmu_ctl_poll,
+	.owner   = THIS_MODULE,
+};
+
+static int get_free_minor(void)
+{
+	struct dmu_device *dev;
+	int minor = 0;
+
+	spin_lock(&devices_lock);
+
+	while (1) {
+		list_for_each_entry(dev, &devices, list) {
+			struct chardev_transport *t = dev->transport_private;
+			if (MINOR(t->ctl_dev) == minor)
+				goto dupe;
+		}
+		break;
+	dupe:
+		minor++;
+	}
+
+	spin_unlock(&devices_lock);
+
+	return minor;
+}
+
+int register_chardev_transport(struct dmu_device *dev)
+{
+	struct chardev_transport *t;
+	int ret;
+
+	dev->transport_private = kmalloc(sizeof(struct chardev_transport),
+					 GFP_KERNEL);
+	t = dev->transport_private;
+
+	if (!t) {
+		DMERR("Failed to allocate chardev transport");
+		goto bad;
+	}
+
+	t->ctl_dev = MKDEV(MAJOR(dmu_dev), get_free_minor());
+	t->parent = dev;
+
+	cdev_init(&t->cdev, &ctl_fops);
+	t->cdev.owner = THIS_MODULE;
+	t->cdev.ops = &ctl_fops;
+
+	ret = cdev_add(&t->cdev, t->ctl_dev, 1);
+	if (ret < 0) {
+		DMERR("Failed to register control device %d:%d",
+		       MAJOR(t->ctl_dev), MINOR(t->ctl_dev));
+		goto bad;
+	}
+
+	return 1;
+
+ bad:
+	kfree(t);
+	return 0;
+}
+
+void unregister_chardev_transport(struct dmu_device *dev)
+{
+	struct chardev_transport *t = dev->transport_private;
+
+	cdev_del(&t->cdev);
+	kfree(t);
+}
+
+int init_chardev_transport(void)
+{
+	int r;
+
+	r = alloc_chrdev_region(&dmu_dev, 0, 10, "dm-userspace");
+	if (r) {
+		DMERR("Failed to allocate chardev region");
+		return 0;
+	} else
+		return 1;
+}
+
+void cleanup_chardev_transport(void)
+{
+	unregister_chrdev_region(dmu_dev, 10);
+}
+
+void write_chardev_transport_info(struct dmu_device *dev,
+			char *buf, unsigned int maxlen)
+{
+	struct chardev_transport *t = dev->transport_private;
+
+	snprintf(buf, maxlen, "%x:%x",
+		 MAJOR(t->ctl_dev), MINOR(t->ctl_dev));
+}
diff -Naur linux-2.6.17.6-orig/drivers/md/Kconfig linux-2.6.17.6-dmu/drivers/md/Kconfig
--- linux-2.6.17.6-orig/drivers/md/Kconfig	2006-07-15 12:00:43.000000000 -0700
+++ linux-2.6.17.6-dmu/drivers/md/Kconfig	2006-07-27 14:32:05.000000000 -0700
@@ -237,6 +237,12 @@
        ---help---
          Allow volume managers to take writeable snapshots of a device.
 
+config DM_USERSPACE
+       tristate "Userspace target (EXPERIMENTAL)"
+       depends on BLK_DEV_DM && EXPERIMENTAL
+       ---help---
+	 A target that provides a userspace interface to device-mapper
+
 config DM_MIRROR
        tristate "Mirror target (EXPERIMENTAL)"
        depends on BLK_DEV_DM && EXPERIMENTAL
diff -Naur linux-2.6.17.6-orig/drivers/md/Makefile linux-2.6.17.6-dmu/drivers/md/Makefile
--- linux-2.6.17.6-orig/drivers/md/Makefile	2006-07-15 12:00:43.000000000 -0700
+++ linux-2.6.17.6-dmu/drivers/md/Makefile	2006-07-27 14:32:05.000000000 -0700
@@ -14,6 +14,7 @@
 		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
 		   raid6altivec8.o \
 		   raid6mmx.o raid6sse1.o raid6sse2.o
+dm-user-objs    := dm-userspace.o dm-userspace-chardev.o
 hostprogs-y	:= mktables
 
 # Note: link order is important.  All raid personalities
@@ -37,6 +38,7 @@
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
+obj-$(CONFIG_DM_USERSPACE)      += dm-user.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
diff -Naur linux-2.6.17.6-orig/include/linux/dm-userspace.h linux-2.6.17.6-dmu/include/linux/dm-userspace.h
--- linux-2.6.17.6-orig/include/linux/dm-userspace.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.6-dmu/include/linux/dm-userspace.h	2006-07-27 14:32:05.000000000 -0700
@@ -0,0 +1,147 @@
+/*
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Dan Smith <danms@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __DM_USERSPACE_H
+#define __DM_USERSPACE_H
+
+#include <linux/types.h>
+
+/*
+ * Message Types
+ */
+#define DM_USERSPACE_GET_VERSION      1
+#define DM_USERSPACE_MAP_BLOCK_REQ    2
+#define DM_USERSPACE_MAP_BLOCK_RESP   3
+#define DM_USERSPACE_MAP_FAILED       4
+#define DM_USERSPACE_MAP_INVALIDATE   5
+#define DM_USERSPACE_STATUS           6
+
+/*
+ * Status codes
+ */
+#define DM_USERSPACE_INVAL_COMPLETE   101
+#define DM_USERSPACE_INVAL_FAILED     102
+#define DM_USERSPACE_SYNC_COMPLETE    103
+
+/*
+ * Flags and associated macros
+ */
+#define DMU_FLAG_VALID       1
+#define DMU_FLAG_RD          2
+#define DMU_FLAG_WR          4
+#define DMU_FLAG_COPY_FIRST  8
+#define DMU_FLAG_TEMPORARY  16
+#define DMU_FLAG_INUSE      32
+#define DMU_FLAG_SYNC       64
+#define DMU_FLAG_WAITING   128
+
+static int dmu_get_flag(uint32_t *flags, uint32_t flag)
+{
+	return (*flags & flag) != 0;
+}
+
+static void dmu_set_flag(uint32_t *flags, uint32_t flag)
+{
+	*flags |= flag;
+}
+
+static void dmu_clr_flag(uint32_t *flags, uint32_t flag)
+{
+	*flags &= (~flag);
+}
+
+static void dmu_cpy_flag(uint32_t *flags, uint32_t src, uint32_t flag)
+{
+	*flags = (*flags & ~flag) | (src & flag);
+}
+
+/*
+ * This message header is sent in front of every message, in both
+ * directions
+ */
+struct dmu_msg_header {
+	uint32_t msg_type;
+	uint32_t payload_len;
+	uint32_t id;
+};
+
+/* DM_USERSPACE_GET_VERSION */
+struct dmu_msg_version {
+	uint32_t userspace_ver;
+	uint32_t kernel_ver;
+};
+
+/* For status codes */
+struct dmu_msg_status {
+	uint32_t id_of_op;
+	uint32_t status;
+};
+
+/* DM_USERSPACE_MAP_BLOCK_REQ */
+struct dmu_msg_map_request {
+	uint64_t org_block;
+
+	uint32_t flags;
+};
+
+/* DM_USERSPACE_MAP_BLOCK_RESP
+ * DM_USERSPACE_MAP_BLOCK_FAILED
+ */
+struct dmu_msg_map_response {
+	uint64_t org_block;
+	uint64_t new_block;
+	int64_t offset;
+
+	uint32_t id_of_req;
+	uint32_t flags;
+
+	uint32_t src_maj;
+	uint32_t src_min;
+
+	uint32_t dst_maj;
+	uint32_t dst_min;
+};
+
+/* DM_USERSPACE_MAP_INVALIDATE */
+struct dmu_msg_invalidate_map {
+	uint64_t org_block;
+};
+
+static inline int dmu_get_msg_len(int type)
+{
+	switch (type) {
+	case DM_USERSPACE_GET_VERSION:
+		return sizeof(struct dmu_msg_version);
+	case DM_USERSPACE_INVAL_COMPLETE:
+	case DM_USERSPACE_INVAL_FAILED:
+	case DM_USERSPACE_STATUS:
+		return sizeof(struct dmu_msg_status);
+	case DM_USERSPACE_MAP_BLOCK_REQ:
+		return sizeof(struct dmu_msg_map_request);
+	case DM_USERSPACE_MAP_BLOCK_RESP:
+	case DM_USERSPACE_MAP_FAILED:
+		return sizeof(struct dmu_msg_map_response);
+	case DM_USERSPACE_MAP_INVALIDATE:
+		return sizeof(struct dmu_msg_invalidate_map);
+	default:
+		return -1;
+	};
+}
+
+#endif

-- 
Dan Smith
IBM Linux Technology Center
Open Hypervisor Team
email: danms@us.ibm.com

