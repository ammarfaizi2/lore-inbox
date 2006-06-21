Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWFUTiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWFUTiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWFUTh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:37:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932706AbWFUThl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:37:41 -0400
Date: Wed, 21 Jun 2006 20:37:36 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] dm: prevent removal if open
Message-ID: <20060621193736.GC4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you misuse the device-mapper interface (or there's a bug in your userspace
tools) it's possible to end up with 'unlinked' mapped devices that cannot be
removed until you reboot (along with uninterruptible processes).

This patch prevents you from removing a device that is still open.

It introduces dm_lock_for_deletion() which is called when a device is about to
be removed to ensure that nothing has it open and nothing further can open it.
It uses a private open_count for this which also lets us remove one of the
problematic bdget_disk() calls elsewhere.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-ioctl.c	2006-06-21 18:32:21.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-ioctl.c	2006-06-21 18:32:42.000000000 +0100
@@ -48,7 +48,7 @@ struct vers_iter {
 static struct list_head _name_buckets[NUM_BUCKETS];
 static struct list_head _uuid_buckets[NUM_BUCKETS];
 
-static void dm_hash_remove_all(void);
+static void dm_hash_remove_all(int keep_open_devices);
 
 /*
  * Guards access to both hash tables.
@@ -73,7 +73,7 @@ static int dm_hash_init(void)
 
 static void dm_hash_exit(void)
 {
-	dm_hash_remove_all();
+	dm_hash_remove_all(0);
 	devfs_remove(DM_DIR);
 }
 
@@ -260,19 +260,41 @@ static void __hash_remove(struct hash_ce
 	free_cell(hc);
 }
 
-static void dm_hash_remove_all(void)
+static void dm_hash_remove_all(int keep_open_devices)
 {
-	int i;
+	int i, dev_skipped, dev_removed;
 	struct hash_cell *hc;
 	struct list_head *tmp, *n;
 
 	down_write(&_hash_lock);
+
+retry:
+	dev_skipped = dev_removed = 0;
 	for (i = 0; i < NUM_BUCKETS; i++) {
 		list_for_each_safe (tmp, n, _name_buckets + i) {
 			hc = list_entry(tmp, struct hash_cell, name_list);
+
+			if (keep_open_devices &&
+			    dm_lock_for_deletion(hc->md)) {
+				dev_skipped++;
+				continue;
+			}
 			__hash_remove(hc);
+			dev_removed = 1;
 		}
 	}
+
+	/*
+	 * Some mapped devices may be using other mapped devices, so if any
+	 * still exist, repeat until we make no further progress.
+	 */
+	if (dev_skipped) {
+		if (dev_removed)
+			goto retry;
+
+		DMWARN("remove_all left %d open device(s)", dev_skipped);
+	}
+
 	up_write(&_hash_lock);
 }
 
@@ -355,7 +377,7 @@ typedef int (*ioctl_fn)(struct dm_ioctl 
 
 static int remove_all(struct dm_ioctl *param, size_t param_size)
 {
-	dm_hash_remove_all();
+	dm_hash_remove_all(1);
 	param->data_size = 0;
 	return 0;
 }
@@ -535,7 +557,6 @@ static int __dev_status(struct mapped_de
 {
 	struct gendisk *disk = dm_disk(md);
 	struct dm_table *table;
-	struct block_device *bdev;
 
 	param->flags &= ~(DM_SUSPEND_FLAG | DM_READONLY_FLAG |
 			  DM_ACTIVE_PRESENT_FLAG);
@@ -545,20 +566,12 @@ static int __dev_status(struct mapped_de
 
 	param->dev = huge_encode_dev(MKDEV(disk->major, disk->first_minor));
 
-	if (!(param->flags & DM_SKIP_BDGET_FLAG)) {
-		bdev = bdget_disk(disk, 0);
-		if (!bdev)
-			return -ENXIO;
-
-		/*
-		 * Yes, this will be out of date by the time it gets back
-		 * to userland, but it is still very useful for
-		 * debugging.
-		 */
-		param->open_count = bdev->bd_openers;
-		bdput(bdev);
-	} else
-		param->open_count = -1;
+	/*
+	 * Yes, this will be out of date by the time it gets back
+	 * to userland, but it is still very useful for
+	 * debugging.
+	 */
+	param->open_count = dm_open_count(md);
 
 	if (disk->policy)
 		param->flags |= DM_READONLY_FLAG;
@@ -661,6 +674,7 @@ static int dev_remove(struct dm_ioctl *p
 {
 	struct hash_cell *hc;
 	struct mapped_device *md;
+	int r;
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
@@ -673,6 +687,17 @@ static int dev_remove(struct dm_ioctl *p
 
 	md = hc->md;
 
+	/*
+	 * Ensure the device is not open and nothing further can open it.
+	 */
+	r = dm_lock_for_deletion(md);
+	if (r) {
+		DMWARN("unable to remove open device %s", hc->name);
+		up_write(&_hash_lock);
+		dm_put(md);
+		return r;
+	}
+
 	__hash_remove(hc);
 	up_write(&_hash_lock);
 	dm_put(md);
Index: linux-2.6.17/drivers/md/dm.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.c	2006-06-21 18:32:25.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.c	2006-06-21 18:32:42.000000000 +0100
@@ -66,12 +66,14 @@ EXPORT_SYMBOL_GPL(dm_get_mapinfo);
 #define DMF_SUSPENDED 1
 #define DMF_FROZEN 2
 #define DMF_FREEING 3
+#define DMF_DELETING 4
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
 	struct semaphore suspend_lock;
 	rwlock_t map_lock;
 	atomic_t holders;
+	atomic_t open_count;
 
 	unsigned long flags;
 
@@ -230,12 +232,14 @@ static int dm_blk_open(struct inode *ino
 	if (!md)
 		goto out;
 
-	if (test_bit(DMF_FREEING, &md->flags)) {
+	if (test_bit(DMF_FREEING, &md->flags) ||
+	    test_bit(DMF_DELETING, &md->flags)) {
 		md = NULL;
 		goto out;
 	}
 
 	dm_get(md);
+	atomic_inc(&md->open_count);
 
 out:
 	spin_unlock(&_minor_lock);
@@ -248,10 +252,35 @@ static int dm_blk_close(struct inode *in
 	struct mapped_device *md;
 
 	md = inode->i_bdev->bd_disk->private_data;
+	atomic_dec(&md->open_count);
 	dm_put(md);
 	return 0;
 }
 
+int dm_open_count(struct mapped_device *md)
+{
+	return atomic_read(&md->open_count);
+}
+
+/*
+ * Guarantees nothing is using the device before it's deleted.
+ */
+int dm_lock_for_deletion(struct mapped_device *md)
+{
+	int r = 0;
+
+	spin_lock(&_minor_lock);
+
+	if (dm_open_count(md))
+		r = -EBUSY;
+	else
+		set_bit(DMF_DELETING, &md->flags);
+
+	spin_unlock(&_minor_lock);
+
+	return r;
+}
+
 static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	struct mapped_device *md = bdev->bd_disk->private_data;
@@ -911,6 +940,7 @@ static struct mapped_device *alloc_dev(i
 	init_MUTEX(&md->suspend_lock);
 	rwlock_init(&md->map_lock);
 	atomic_set(&md->holders, 1);
+	atomic_set(&md->open_count, 0);
 	atomic_set(&md->event_nr, 0);
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
Index: linux-2.6.17/drivers/md/dm.h
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.h	2006-06-21 18:32:25.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.h	2006-06-21 18:32:42.000000000 +0100
@@ -123,5 +123,7 @@ void dm_stripe_exit(void);
 
 void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
 union map_info *dm_get_mapinfo(struct bio *bio);
+int dm_open_count(struct mapped_device *md);
+int dm_lock_for_deletion(struct mapped_device *md);
 
 #endif
Index: linux-2.6.17/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.17.orig/include/linux/dm-ioctl.h	2006-06-21 17:44:41.000000000 +0100
+++ linux-2.6.17/include/linux/dm-ioctl.h	2006-06-21 18:32:42.000000000 +0100
@@ -285,9 +285,9 @@ typedef char ioctl_struct[308];
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	7
+#define DM_VERSION_MINOR	8
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2006-05-30)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-06-08)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
@@ -314,7 +314,7 @@ typedef char ioctl_struct[308];
 #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
 
 /*
- * Set this to improve performance when you aren't going to use open_count.
+ * This flag is now ignored.
  */
 #define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
 
