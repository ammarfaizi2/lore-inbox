Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSJ2RM5>; Tue, 29 Oct 2002 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSJ2RM5>; Tue, 29 Oct 2002 12:12:57 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:17933 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262414AbSJ2RMx>; Tue, 29 Oct 2002 12:12:53 -0500
Date: Tue, 29 Oct 2002 17:19:20 +0000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm update 2/3
Message-ID: <20021029171920.GB1779@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.  Remove the kdev_t member from struct mapped device, instead
   we can make use of the major/first_minor fields of the gendisk.

.  New fns dm_set_ro()/dm_get_ro(), simpler than the new set_device_ro, 
   or set_disk_ro.

--- diff/drivers/md/dm-ioctl.c	2002-10-29 16:18:16.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2002-10-29 16:22:14.000000000 +0000
@@ -176,10 +176,9 @@
  */
 static int register_with_devfs(struct hash_cell *hc)
 {
-	kdev_t dev = dm_kdev(hc->md);
 	hc->devfs_entry =
 	    devfs_register(_dev_dir, hc->name, DEVFS_FL_CURRENT_OWNER,
-			   major(dev), minor(dev),
+			   dm_major(hc->md), dm_minor(hc->md),
 			   S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 			   &dm_blk_dops, NULL);
 
@@ -453,17 +452,17 @@
 	if (dm_suspended(md))
 		param->flags |= DM_SUSPEND_FLAG;
 
-	param->dev = kdev_t_to_nr(dm_kdev(md));
+	param->dev = MKDEV(dm_major(md), dm_minor(md));
 	bdev = bdget(param->dev);
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_read_only(bdev))
-		param->flags |= DM_READONLY_FLAG;
-
 	param->open_count = bdev->bd_openers;
 	bdput(bdev);
 
+	if (dm_get_ro(md))
+		param->flags |= DM_READONLY_FLAG;
+
 	table = dm_get_table(md);
 	param->target_count = dm_table_get_num_targets(table);
 	dm_table_put(table);
@@ -585,7 +584,7 @@
 	}
 	dm_table_put(t);	/* md will have grabbed its own reference */
 
-	set_device_ro(dm_kdev(md), (param->flags & DM_READONLY_FLAG));
+	dm_set_ro(md, (param->flags & DM_READONLY_FLAG));
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	dm_put(md);
 
@@ -871,7 +870,7 @@
 		return r;
 	}
 
-	set_device_ro(dm_kdev(md), (param->flags & DM_READONLY_FLAG));
+	dm_set_ro(md, (param->flags & DM_READONLY_FLAG));
 	dm_put(md);
 
 	r = info(param, user);
--- diff/drivers/md/dm.h	2002-10-29 16:18:16.000000000 +0000
+++ source/drivers/md/dm.h	2002-10-29 16:22:14.000000000 +0000
@@ -77,7 +77,10 @@
 /*
  * Info functions.
  */
-kdev_t dm_kdev(struct mapped_device *md);
+int dm_major(struct mapped_device *md);
+int dm_minor(struct mapped_device *md);
+int dm_get_ro(struct mapped_device *md);
+void dm_set_ro(struct mapped_device *md, int ro);
 int dm_suspended(struct mapped_device *md);
 
 /*-----------------------------------------------------------------
--- diff/drivers/md/dm.c	2002-10-29 16:18:16.000000000 +0000
+++ source/drivers/md/dm.c	2002-10-29 16:22:36.000000000 +0000
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
@@ -749,15 +746,42 @@
 	return 0;
 }
 
-kdev_t dm_kdev(struct mapped_device *md)
+int dm_major(struct mapped_device *md)
 {
-	kdev_t dev;
+	int r;
+	down_read(&md->lock);
+	r = md->disk->major;
+	up_read(&md->lock);
 
+	return r;
+}
+
+int dm_minor(struct mapped_device *md)
+{
+	int r;
 	down_read(&md->lock);
-	dev = md->kdev;
+	r = md->disk->first_minor;
 	up_read(&md->lock);
 
-	return dev;
+	return r;
+}
+
+int dm_get_ro(struct mapped_device *md)
+{
+	int ro;
+
+	down_read(&md->lock);
+	ro = md->disk->policy;
+	up_read(&md->lock);
+
+	return ro;
+}
+
+void dm_set_ro(struct mapped_device *md, int ro)
+{
+	down_write(&md->lock);
+	set_disk_ro(md->disk, ro);
+	up_write(&md->lock);
 }
 
 struct dm_table *dm_get_table(struct mapped_device *md)
