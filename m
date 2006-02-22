Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWBVQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBVQLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBVQLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:11:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16087 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932340AbWBVQLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:11:48 -0500
Message-ID: <43FC8D8C.1060904@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 11:13:00 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 1/3] sysfs representation of stacked devices (common) (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com>
In-Reply-To: <43FC8C00.5020600@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------070700030507020902080804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070700030507020902080804
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch adds bd_claim_by_kobject and bd_release_from_kobject
which create/remove symlinks between the claimed bdev and
the holder.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------070700030507020902080804
Content-Type: text/x-patch;
 name="common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="common.patch"

Adding bd_claim_by_kobject/bd_release_from_kobject for use by
stacked device drivers (dm and md)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15/include/linux/fs.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/fs.h	2006-02-21 19:04:46.000000000 -0500
@@ -373,6 +373,8 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+	struct kobject		bd_holder_dir;
+	struct list_head	bd_holder_list;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1351,6 +1353,8 @@ extern int blkdev_get(struct block_devic
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+extern int bd_claim_by_kobject(struct block_device *, void *, struct kobject *);
+extern void bd_release_from_kobject(struct block_device *, struct kobject *);
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
--- linux-2.6.15/include/linux/genhd.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/genhd.h	2006-02-21 11:38:01.000000000 -0500
@@ -114,6 +114,7 @@ struct gendisk {
 	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
+	struct kobject slave_dir;
 
 	struct timer_rand_state *random;
 	int policy;
--- linux-2.6.15/fs/block_dev.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/block_dev.c	2006-02-22 09:48:37.000000000 -0500
@@ -443,7 +443,159 @@ void bd_forget(struct inode *inode)
 	spin_unlock(&bdev_lock);
 }
 
-int bd_claim(struct block_device *bdev, void *holder)
+/*
+ * Functions for bd_claim_by_kobject / bd_release_from_kobject
+ *
+ *     If a kobject is passed to bd_claim_by_kobject() 
+ *     and the kobject has a parent directory,
+ *     following symlinks are created:
+ *        o from the kobject to the claimed bdev
+ *        o from "holders" directory of the bdev to the parent of the kobject
+ *     bd_release_from_kobject() removes these symlinks.
+ *
+ *     Example:
+ *        If /dev/dm-0 maps to /dev/sda, kobject corresponding to
+ *        /sys/block/dm-0/slaves is passed to bd_claim_by_kobject(), then:
+ *           /sys/block/dm-0/slaves/sda --> /sys/block/sda
+ *           /sys/block/sda/holders/dm-0 --> /sys/block/dm-0
+ */
+
+static inline struct kobject * bdev_get_kobj(struct block_device *bdev)
+{
+	if (!bdev)
+		return NULL;
+	else if (bdev->bd_contains != bdev)
+		return kobject_get(&bdev->bd_part->kobj);
+	else
+		return kobject_get(&bdev->bd_disk->kobj);
+}
+
+static inline void add_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_create_link(from, to, kobject_name(to));
+}
+
+static inline void del_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_remove_link(from, kobject_name(to));
+}
+
+static void link_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *kobj;
+
+	if (!holder->parent)
+		return;
+
+	kobj = bdev_get_kobj(bdev);
+	add_symlink(holder, kobj);
+	add_symlink(&bdev->bd_holder_dir, holder->parent);
+	kobject_put(kobj);
+}
+
+static void unlink_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *kobj;
+
+	if (!holder->parent)
+		return;
+
+	kobj = bdev_get_kobj(bdev);
+	del_symlink(holder, kobj);
+	del_symlink(&bdev->bd_holder_dir, holder->parent);
+	kobject_put(kobj);
+}
+
+/* This is a mere directory in sysfs. No methods are needed. */
+static struct kobj_type bd_holder_ktype = {
+	.release	= NULL,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
+static inline void add_holder_dir(struct block_device *bdev)
+{
+	struct kobject *kobj = &bdev->bd_holder_dir;
+
+	kobj->ktype = &bd_holder_ktype;
+	kobject_set_name(kobj, "holders");
+	kobj->parent = bdev_get_kobj(bdev);
+	kobject_init(kobj);
+	kobject_add(kobj);
+	kobject_put(kobj->parent);
+}
+
+static inline void del_holder_dir(struct block_device *bdev)
+{
+	/*
+	 * Don't kobject_unregister to avoid memory allocation
+	 * in kobject_hotplug.
+	 */
+	kobject_del(&bdev->bd_holder_dir);
+	kobject_put(&bdev->bd_holder_dir);
+}
+
+/* bd_holder_list is protected by bdev_lock */
+struct bd_holder {
+	struct list_head list;	/* chain of holders of the bdev */
+	int count;		/* references from the holder */
+	struct kobject *kobj;	/* holder kobject */
+};
+
+static int add_bd_holder(struct block_device *bdev, struct kobject *kobj)
+{
+        struct bd_holder *bo;
+
+	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
+		if (bo->kobj == kobj) {
+			bo->count++;
+			return 0;
+		}
+	}
+
+	if (list_empty(&bdev->bd_holder_list))
+		add_holder_dir(bdev);
+
+	bo = kmalloc(sizeof(*bo), GFP_KERNEL);
+	if (!bo)
+		return -ENOMEM;
+
+	bo->count = 1;
+	bo->kobj = kobj;
+	list_add_tail(&bo->list, &bdev->bd_holder_list);
+	link_bd_holder(bdev, kobj);
+
+	return 0;
+}
+
+static int del_bd_holder(struct block_device *bdev, struct kobject *kobj)
+{
+	struct bd_holder *bo;
+
+	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
+		if (bo->kobj == kobj) {
+			bo->count--;
+			BUG_ON(bo->count < 0);
+			if (!bo->count) {
+				unlink_bd_holder(bdev, kobj);
+				list_del(&bo->list);
+				kfree(bo);
+			}
+			break;
+		}
+	}
+
+	if (list_empty(&bdev->bd_holder_list))
+		del_holder_dir(bdev);
+
+	return 0;
+}
+
+int bd_claim_by_kobject(struct block_device *bdev, void *holder, struct kobject *kobj)
 {
 	int res;
 	spin_lock(&bdev_lock);
@@ -464,6 +616,9 @@ int bd_claim(struct block_device *bdev, 
 		res = 0;	 /* is a partition of an un-held device */
 
 	/* now impose change */
+	if (res == 0 && kobj)
+		res = add_bd_holder(bdev, kobj);
+
 	if (res==0) {
 		/* note that for a whole device bd_holders
 		 * will be incremented twice, and bd_holder will
@@ -478,11 +633,20 @@ int bd_claim(struct block_device *bdev, 
 	return res;
 }
 
+EXPORT_SYMBOL(bd_claim_by_kobject);
+
+int bd_claim(struct block_device *bdev, void *holder)
+{
+	return bd_claim_by_kobject(bdev, holder, NULL);
+}
+
 EXPORT_SYMBOL(bd_claim);
 
-void bd_release(struct block_device *bdev)
+void bd_release_from_kobject(struct block_device *bdev, struct kobject *kobj)
 {
 	spin_lock(&bdev_lock);
+	if (kobj)
+		del_bd_holder(bdev, kobj);
 	if (!--bdev->bd_contains->bd_holders)
 		bdev->bd_contains->bd_holder = NULL;
 	if (!--bdev->bd_holders)
@@ -490,6 +654,13 @@ void bd_release(struct block_device *bde
 	spin_unlock(&bdev_lock);
 }
 
+EXPORT_SYMBOL(bd_release_from_kobject);
+
+void bd_release(struct block_device *bdev)
+{
+	bd_release_from_kobject(bdev, NULL);
+}
+
 EXPORT_SYMBOL(bd_release);
 
 /*
@@ -578,6 +749,7 @@ static int do_open(struct block_device *
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
+		INIT_LIST_HEAD(&bdev->bd_holder_list);
 		if (!part) {
 			struct backing_dev_info *bdi;
 			if (disk->fops->open) {
--- linux-2.6.15/fs/partitions/check.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/fs/partitions/check.c	2006-02-21 14:30:23.000000000 -0500
@@ -293,6 +293,13 @@ struct kobj_type ktype_part = {
 	.sysfs_ops	= &part_sysfs_ops,
 };
 
+/* This is a mere directory in sysfs. No methods are needed. */
+static struct kobj_type slave_ktype = {
+	.release	= NULL,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
 void delete_partition(struct gendisk *disk, int part)
 {
 	struct hd_struct *p = disk->part[part-1];
@@ -343,6 +350,12 @@ static void disk_sysfs_symlinks(struct g
 		sysfs_create_link(&disk->kobj,&target->kobj,"device");
 		sysfs_create_link(&target->kobj,&disk->kobj,"block");
 	}
+
+	/* create subdirectory for symlinks to underlying device */
+	disk->slave_dir.ktype = &slave_ktype;
+	kobject_set_name(&disk->slave_dir, "slaves");
+	disk->slave_dir.parent = &disk->kobj;
+	kobject_register(&disk->slave_dir);
 }
 
 /* Not exported, helper to add_disk(). */
@@ -460,6 +473,7 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
+	kobject_unregister(&disk->slave_dir);
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");

--------------070700030507020902080804--
