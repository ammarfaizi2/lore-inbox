Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTEAQyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEAQyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:54:15 -0400
Received: from verein.lst.de ([212.34.181.86]:24327 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261182AbTEAQyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:54:09 -0400
Date: Thu, 1 May 2003 19:06:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove partition_name()
Message-ID: <20030501190627.A15907@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

partition_name() is a variant of __bdevname() with a slightly more
fancy find-the-name algorithm but with the disadvantage that it returns
a buffer to static allocated data and barfs up when devices are remove
and other reuse the same dev_t.  It's only used by the raid code and
most calls are through a wrapper, bdev_partition_name() that takes
a struct block_device * that maybe be NULL.

The patch below changes the bdev_partition_name() to call bdevname()
if possible and the other calls where we really have nothing more than
a dev_t to __bdevname.

Btw, it would be nice if someone who knows the md code a bit better
than me could remove bdev_partition_name() in favour of direct calls
to bdevname() where possible - that would also get rid of the returns
pointer to string on stack issue that this patch can't fix yet.


--- 1.166/drivers/md/md.c	Fri Apr 25 18:16:28 2003
+++ edited/drivers/md/md.c	Thu May  1 17:15:57 2003
@@ -1111,8 +1111,10 @@
 
 static void print_desc(mdp_disk_t *desc)
 {
+	char b[BDEVNAME_SIZE];
+
 	printk(" DISK<N:%d,%s(%d,%d),R:%d,S:%d>\n", desc->number,
-		partition_name(MKDEV(desc->major,desc->minor)),
+		__bdevname(MKDEV(desc->major, desc->minor), b),
 		desc->major,desc->minor,desc->raid_disk,desc->state);
 }
 
@@ -1294,6 +1296,7 @@
  */
 static mdk_rdev_t *md_import_device(dev_t newdev, int super_format, int super_minor)
 {
+	char b[BDEVNAME_SIZE];
 	int err;
 	mdk_rdev_t *rdev;
 	sector_t size;
@@ -1301,7 +1304,7 @@
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
 		printk(KERN_ERR "md: could not alloc mem for %s!\n", 
-			partition_name(newdev));
+			__bdevname(newdev, b));
 		return ERR_PTR(-ENOMEM);
 	}
 	memset(rdev, 0, sizeof(*rdev));
@@ -1312,7 +1315,7 @@
 	err = lock_rdev(rdev, newdev);
 	if (err) {
 		printk(KERN_ERR "md: could not lock %s.\n",
-			partition_name(newdev));
+			__bdevname(newdev, b));
 		goto abort_free;
 	}
 	rdev->desc_nr = -1;
@@ -1840,6 +1843,7 @@
 
 static int autostart_array(dev_t startdev)
 {
+	char b[BDEVNAME_SIZE];
 	int err = -EINVAL, i;
 	mdp_super_t *sb = NULL;
 	mdk_rdev_t *start_rdev = NULL, *rdev;
@@ -1847,7 +1851,7 @@
 	start_rdev = md_import_device(startdev, 0, 0);
 	if (IS_ERR(start_rdev)) {
 		printk(KERN_WARNING "md: could not import %s!\n",
-			partition_name(startdev));
+			__bdevname(startdev, b));
 		return err;
 	}
 
@@ -1884,7 +1888,7 @@
 		if (IS_ERR(rdev)) {
 			printk(KERN_WARNING "md: could not import %s,"
 				" trying to run array nevertheless.\n",
-				partition_name(dev));
+				__bdevname(dev, b));
 			continue;
 		}
 		list_add(&rdev->same_set, &pending_raid_disks);
@@ -2116,6 +2120,7 @@
 
 static int hot_generate_error(mddev_t * mddev, dev_t dev)
 {
+	char b[BDEVNAME_SIZE];
 	struct request_queue *q;
 	mdk_rdev_t *rdev;
 
@@ -2123,7 +2128,7 @@
 		return -ENODEV;
 
 	printk(KERN_INFO "md: trying to generate %s error in md%d ... \n",
-		partition_name(dev), mdidx(mddev));
+		__bdevname(dev, b), mdidx(mddev));
 
 	rdev = find_rdev(mddev, dev);
 	if (!rdev) {
@@ -2151,13 +2156,14 @@
 
 static int hot_remove_disk(mddev_t * mddev, dev_t dev)
 {
+	char b[BDEVNAME_SIZE];
 	mdk_rdev_t *rdev;
 
 	if (!mddev->pers)
 		return -ENODEV;
 
 	printk(KERN_INFO "md: trying to remove %s from md%d ... \n",
-		partition_name(dev), mdidx(mddev));
+		__bdevname(dev, b), mdidx(mddev));
 
 	rdev = find_rdev(mddev, dev);
 	if (!rdev)
@@ -2178,6 +2184,7 @@
 
 static int hot_add_disk(mddev_t * mddev, dev_t dev)
 {
+	char b[BDEVNAME_SIZE];
 	int err;
 	unsigned int size;
 	mdk_rdev_t *rdev;
@@ -2186,7 +2193,7 @@
 		return -ENODEV;
 
 	printk(KERN_INFO "md: trying to hot-add %s to md%d ... \n",
-		partition_name(dev), mdidx(mddev));
+		__bdevname(dev, b), mdidx(mddev));
 
 	if (mddev->major_version != 0) {
 		printk(KERN_WARNING "md%d: HOT_ADD may only be used with"
@@ -2344,6 +2351,7 @@
 static int md_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
+	char b[BDEVNAME_SIZE];
 	unsigned int minor;
 	int err = 0;
 	struct hd_geometry *loc = (struct hd_geometry *) arg;
@@ -2403,7 +2411,7 @@
 		err = autostart_array(arg);
 		if (err) {
 			printk(KERN_WARNING "md: autostart %s failed!\n",
-				partition_name(arg));
+				__bdevname(arg, b));
 			goto abort;
 		}
 		goto done;
@@ -3516,6 +3524,7 @@
 
 static void autostart_arrays(void)
 {
+	char b[BDEVNAME_SIZE];
 	mdk_rdev_t *rdev;
 	int i;
 
@@ -3527,7 +3536,7 @@
 		rdev = md_import_device(dev,0, 0);
 		if (IS_ERR(rdev)) {
 			printk(KERN_ALERT "md: could not import %s!\n",
-				partition_name(dev));
+				__bdevname(dev, b));
 			continue;
 		}
 		if (rdev->faulty) {
--- 1.108/fs/partitions/check.c	Tue Apr 29 17:42:50 2003
+++ edited/fs/partitions/check.c	Thu May  1 17:05:27 2003
@@ -420,53 +420,3 @@
 	}
 	kobject_del(&disk->kobj);
 }
-
-struct dev_name {
-	struct list_head list;
-	dev_t dev;
-	char namebuf[BDEVNAME_SIZE];
-	char *name;
-};
-
-static LIST_HEAD(device_names);
-
-char *partition_name(dev_t dev)
-{
-	struct gendisk *hd;
-	static char nomem [] = "<nomem>";
-	char b[BDEVNAME_SIZE];
-	struct dev_name *dname;
-	struct list_head *tmp;
-	int part;
-
-	list_for_each(tmp, &device_names) {
-		dname = list_entry(tmp, struct dev_name, list);
-		if (dname->dev == dev)
-			return dname->name;
-	}
-
-	dname = kmalloc(sizeof(*dname), GFP_KERNEL);
-
-	if (!dname)
-		return nomem;
-	/*
-	 * ok, add this new device name to the list
-	 */
-	hd = get_gendisk(dev, &part);
-	dname->name = NULL;
-	if (hd) {
-		dname->name = disk_name(hd, part, dname->namebuf);
-		module_put(hd->fops->owner);
-		put_disk(hd);
-	}
-	if (!dname->name) {
-		sprintf(dname->namebuf, "[dev %s]", __bdevname(dev, b));
-		dname->name = dname->namebuf;
-	}
-
-	dname->dev = dev;
-	list_add(&dname->list, &device_names);
-
-	return dname->name;
-}
-
--- 1.4/include/linux/blkpg.h	Tue Oct 15 16:49:02 2002
+++ edited/include/linux/blkpg.h	Thu May  1 17:04:48 2003
@@ -54,10 +54,4 @@
 	char volname[BLKPG_VOLNAMELTH];	/* volume label */
 };
 
-#ifdef __KERNEL__
-
-extern char * partition_name(dev_t dev);
-
-#endif /* __KERNEL__ */
-
 #endif /* _LINUX_BLKPG_H */
--- 1.26/include/linux/raid/md.h	Thu Apr  3 20:21:33 2003
+++ edited/include/linux/raid/md.h	Thu May  1 17:12:35 2003
@@ -61,9 +61,20 @@
 #define MD_MINOR_VERSION                90
 #define MD_PATCHLEVEL_VERSION           0
 
-extern inline char * bdev_partition_name (struct block_device *bdev)
+/*
+ * XXX(hch): This function is broken.  Someone who understands the md
+ * code needs to go through all callers, check whether bdev could
+ * be NULL and replace it with direct calls to bdevmame.
+ *
+ * This would also fix the returns buffer on stack issue nicely :)
+ */
+static inline const char *bdev_partition_name (struct block_device *bdev)
 {
-	return partition_name(bdev ? bdev->bd_dev : 0);
+	char b[BDEVNAME_SIZE];
+
+	if (!bdev)
+		return __bdevname(0, b);
+	return bdevname(bdev, b);
 }
 extern int register_md_personality (int p_num, mdk_personality_t *p);
 extern int unregister_md_personality (int p_num);
--- 1.195/kernel/ksyms.c	Tue Apr 29 17:42:50 2003
+++ edited/kernel/ksyms.c	Thu May  1 17:05:10 2003
@@ -579,8 +579,6 @@
 EXPORT_SYMBOL(fasync_helper);
 EXPORT_SYMBOL(kill_fasync);
 
-EXPORT_SYMBOL(partition_name);
-
 /* binfmt_aout */
 EXPORT_SYMBOL(get_write_access);
 
