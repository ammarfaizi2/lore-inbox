Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSJ3KId>; Wed, 30 Oct 2002 05:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSJ3KIc>; Wed, 30 Oct 2002 05:08:32 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:20999 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261333AbSJ3KIa>; Wed, 30 Oct 2002 05:08:30 -0500
Date: Wed, 30 Oct 2002 10:14:57 +0000
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm update 2/3
Message-ID: <20021030101457.GA10815@fib011235813.fsnet.co.uk>
References: <20021029171920.GB1779@fib011235813.fsnet.co.uk> <Pine.GSO.4.21.0210291234160.9171-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210291234160.9171-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 12:39:51PM -0500, Alexander Viro wrote:
> Please, just do dm_disk(dm) and for now use its ->major/->first_minor.


--- diff/drivers/md/dm-ioctl.c	2002-10-30 09:24:36.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2002-10-30 09:34:51.000000000 +0000
@@ -176,10 +176,11 @@
  */
 static int register_with_devfs(struct hash_cell *hc)
 {
-	kdev_t dev = dm_kdev(hc->md);
+	struct gendisk *disk = dm_disk(hc->md);
+
 	hc->devfs_entry =
 	    devfs_register(_dev_dir, hc->name, DEVFS_FL_CURRENT_OWNER,
-			   major(dev), minor(dev),
+			   disk->major, disk->first_minor,
 			   S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 			   &dm_blk_dops, NULL);
 
@@ -447,23 +448,24 @@
 static int __info(struct mapped_device *md, struct dm_ioctl *param)
 {
 	struct dm_table *table;
+	struct gendisk *disk = dm_disk(md);
 	struct block_device *bdev;
 
 	param->flags = DM_EXISTS_FLAG;
 	if (dm_suspended(md))
 		param->flags |= DM_SUSPEND_FLAG;
 
-	param->dev = kdev_t_to_nr(dm_kdev(md));
+	param->dev = MKDEV(disk->major, disk->first_minor);
 	bdev = bdget(param->dev);
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_read_only(bdev))
-		param->flags |= DM_READONLY_FLAG;
-
 	param->open_count = bdev->bd_openers;
 	bdput(bdev);
 
+	if (disk->policy)
+		param->flags |= DM_READONLY_FLAG;
+
 	table = dm_get_table(md);
 	param->target_count = dm_table_get_num_targets(table);
 	dm_table_put(table);
@@ -558,6 +560,7 @@
 {
 	int r;
 	struct dm_table *t;
+	struct gendisk *disk;
 	struct mapped_device *md;
 	int minor;
 
@@ -585,7 +588,8 @@
 	}
 	dm_table_put(t);	/* md will have grabbed its own reference */
 
-	set_device_ro(dm_kdev(md), (param->flags & DM_READONLY_FLAG));
+	disk = dm_disk(md);
+	set_disk_ro(disk, (param->flags & DM_READONLY_FLAG));
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	dm_put(md);
 
@@ -845,6 +849,7 @@
 static int reload(struct dm_ioctl *param, struct dm_ioctl *user)
 {
 	int r;
+	struct gendisk *disk;
 	struct mapped_device *md;
 	struct dm_table *t;
 
@@ -871,7 +876,8 @@
 		return r;
 	}
 
-	set_device_ro(dm_kdev(md), (param->flags & DM_READONLY_FLAG));
+	disk = dm_disk(md);
+	set_disk_ro(disk, (param->flags & DM_READONLY_FLAG));
 	dm_put(md);
 
 	r = info(param, user);
--- diff/drivers/md/dm.h	2002-10-30 09:24:36.000000000 +0000
+++ source/drivers/md/dm.h	2002-10-30 09:31:07.000000000 +0000
@@ -77,7 +77,7 @@
 /*
  * Info functions.
  */
-kdev_t dm_kdev(struct mapped_device *md);
+struct gendisk *dm_disk(struct mapped_device *md);
 int dm_suspended(struct mapped_device *md);
 
 /*-----------------------------------------------------------------
--- diff/drivers/md/dm.c	2002-10-30 09:24:36.000000000 +0000
+++ source/drivers/md/dm.c	2002-10-30 09:38:39.000000000 +0000
@@ -41,8 +41,6 @@
 
 struct mapped_device {
 	struct rw_semaphore lock;
-
-	kdev_t kdev;
 	atomic_t holders;
 
 	unsigned long flags;
@@ -542,7 +540,6 @@
 
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
-	md->kdev = mk_kdev(_major, minor);
 	atomic_set(&md->holders, 1);
 
 	md->queue.queuedata = md;
@@ -749,15 +746,13 @@
 	return 0;
 }
 
-kdev_t dm_kdev(struct mapped_device *md)
+/*
+ * The gendisk is only valid as long as you have a reference
+ * count on 'md'.
+ */
+struct gendisk *dm_disk(struct mapped_device *md)
 {
-	kdev_t dev;
-
-	down_read(&md->lock);
-	dev = md->kdev;
-	up_read(&md->lock);
-
-	return dev;
+	return md->disk;
 }
 
 struct dm_table *dm_get_table(struct mapped_device *md)
