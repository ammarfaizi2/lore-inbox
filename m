Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWBWTOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWBWTOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWBWTOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:14:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49846 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750933AbWBWTOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:14:40 -0500
Message-ID: <43FE09E1.4080907@ce.jp.nec.com>
Date: Thu, 23 Feb 2006 14:15:45 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (common)
 (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D8C.1060904@ce.jp.nec.com> <20060222184853.GB13638@suse.de> <43FCE40A.1010206@ce.jp.nec.com> <20060222222846.GA14249@suse.de>
In-Reply-To: <20060222222846.GA14249@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060004010804090403080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060004010804090403080906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Greg,

>>>>+/* This is a mere directory in sysfs. No methods are needed. */
>>>>+static struct kobj_type bd_holder_ktype = {
>>>>+	.release	= NULL,
>>>>+	.sysfs_ops	= NULL,
>>>>+	.default_attrs	= NULL,
>>>>+};
>>>
>>>That doesn't look right.  You always need a release function.

I updated the patch based your comments.
Could you take a look at this version whether there's
any problematic use of sysfs/kobjects?

   - I removed embedded child-kobjects from struct block_device
     and struct gendisk which I added in my previous patch.
     Kobject registration occurs when gendisk or hd_struct is
     registered. Release function of the kobject type is added.
   - Reference counting of kobjects is done in much symmetric
     manner than before.
   - Added bd_claim_by_disk/bd_release_from_disk inline functions
     to help proper reference counting.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------060004010804090403080906
Content-Type: text/x-patch;
 name="common-2.6.16-rc4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="common-2.6.16-rc4.patch"

This patch provides a common functions/structures for
sysfs representation of dependencies between stacked devices (dm and md).

Variants of bd_claim/bd_release are added to accept a kobject
(or a gendisk containing it) and create symlinks between the claimed bdev
and the holder.
Other patches for dm/md will make use of these functions.

For example, if dm-0 maps to sda, we have the following symlinks;
    /sys/block/dm-0/slaves/sda --> /sys/block/sda
    /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 fs/block_dev.c        |  196 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/partitions/check.c |   55 ++++++++++++++
 include/linux/fs.h    |    3
 include/linux/genhd.h |   16 ++++
 4 files changed, 268 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc4/include/linux/fs.h	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/fs.h	2006-02-22 22:37:52.000000000 -0500
@@ -401,6 +401,7 @@ struct block_device {
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
+	struct list_head	bd_holder_list;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	struct hd_struct *	bd_part;
@@ -1380,6 +1381,8 @@ extern int blkdev_get(struct block_devic
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+extern int bd_claim_by_kobject(struct block_device *, void *, struct kobject *);
+extern void bd_release_from_kobject(struct block_device *, struct kobject *);
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
--- linux-2.6.16-rc4/include/linux/genhd.h	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/genhd.h	2006-02-22 22:37:50.000000000 -0500
@@ -78,6 +78,7 @@ struct hd_struct {
 	sector_t start_sect;
 	sector_t nr_sects;
 	struct kobject kobj;
+	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
 	int policy, partno;
 };
@@ -114,6 +115,8 @@ struct gendisk {
 	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
+	struct kobject *holder_dir;
+	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
 	int policy;
@@ -421,6 +424,19 @@ static inline struct block_device *bdget
 	return bdget(MKDEV(disk->major, disk->first_minor) + index);
 }
 
+static inline int bd_claim_by_disk(struct block_device *bdev,
+					void *holder, struct gendisk *disk)
+{
+	return bd_claim_by_kobject(bdev, holder, kobject_get(disk->slave_dir));
+}
+
+static inline void bd_release_from_disk(struct block_device *bdev,
+					struct gendisk *disk)
+{
+	bd_release_from_kobject(bdev, disk->slave_dir);
+	kobject_put(disk->slave_dir);
+}
+
 #endif
 
 #endif
--- linux-2.6.16-rc4/fs/block_dev.c	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/fs/block_dev.c	2006-02-22 23:50:20.000000000 -0500
@@ -269,6 +269,7 @@ static void init_once(void * foo, kmem_c
 		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
+		INIT_LIST_HEAD(&bdev->bd_holder_list);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -443,7 +444,179 @@ void bd_forget(struct inode *inode)
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
+static inline struct kobject * bdev_get_holder(struct block_device *bdev)
+{
+	if (!bdev)
+		return NULL;
+	else if (bdev->bd_contains != bdev)
+		return kobject_get(bdev->bd_part->holder_dir);
+	else
+		return kobject_get(bdev->bd_disk->holder_dir);
+}
+
+static inline void add_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	kobject_get(from);
+	kobject_get(to);
+	sysfs_create_link(from, to, kobject_name(to));
+}
+
+static inline void del_symlink(struct kobject *from, struct kobject *to)
+{
+	if (!from || !to)
+		return;
+	sysfs_remove_link(from, kobject_name(to));
+	kobject_put(from);
+	kobject_put(to);
+}
+
+static inline int bd_claim_grab_dirs(struct block_device *bdev,
+			struct kobject *holder,
+			struct kobject **sdir, struct kobject **sdev,
+			struct kobject **hdir, struct kobject **hdev)
+{
+	*sdir = kobject_get(holder);
+	if (!*sdir)
+		return 0;
+
+	*hdev = kobject_get((*sdir)->parent);
+	if (!*hdev)
+		goto fail_put_sdir;
+
+	*sdev = bdev_get_kobj(bdev);
+	if (!*sdev)
+		goto fail_put_hdev;
+
+	*hdir = bdev_get_holder(bdev);
+	if (!*hdir)
+		goto fail_put_sdev;
+
+	return 1;
+
+fail_put_sdev:
+	kobject_put(*sdev);
+fail_put_hdev:
+	kobject_put(*hdev);
+fail_put_sdir:
+	kobject_put(*sdir);
+
+	return 0;
+}
+
+static inline void bd_claim_release_dirs(
+			struct kobject *sdir, struct kobject *sdev,
+			struct kobject *hdir, struct kobject *hdev)
+{
+	kobject_put(hdir);
+	kobject_put(sdev);
+	kobject_put(hdev);
+	kobject_put(sdir);
+}
+
+static void link_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *sdir, *sdev, *hdir, *hdev;
+
+	if (bd_claim_grab_dirs(bdev, holder, &sdir, &sdev, &hdir, &hdev)) {
+		add_symlink(sdir, sdev);
+		add_symlink(hdir, hdev);
+		bd_claim_release_dirs(sdir, sdev, hdir, hdev);
+	}
+
+	return;
+}
+
+static void unlink_bd_holder(struct block_device *bdev, struct kobject *holder)
+{
+	struct kobject *sdir, *sdev, *hdir, *hdev;
+
+	if (bd_claim_grab_dirs(bdev, holder, &sdir, &sdev, &hdir, &hdev)) {
+		del_symlink(sdir, sdev);
+		del_symlink(hdir, hdev);
+		bd_claim_release_dirs(sdir, sdev, hdir, hdev);
+	}
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
+	return 0;
+}
+
+int bd_claim_by_kobject(struct block_device *bdev, void *holder, struct kobject *kobj)
 {
 	int res;
 	spin_lock(&bdev_lock);
@@ -464,6 +637,9 @@ int bd_claim(struct block_device *bdev, 
 		res = 0;	 /* is a partition of an un-held device */
 
 	/* now impose change */
+	if (res == 0 && kobj)
+		res = add_bd_holder(bdev, kobj);
+
 	if (res==0) {
 		/* note that for a whole device bd_holders
 		 * will be incremented twice, and bd_holder will
@@ -478,11 +654,20 @@ int bd_claim(struct block_device *bdev, 
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
@@ -490,6 +675,13 @@ void bd_release(struct block_device *bde
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
--- linux-2.6.16-rc4/fs/partitions/check.c	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4/fs/partitions/check.c	2006-02-22 23:18:06.000000000 -0500
@@ -297,6 +297,56 @@ struct kobj_type ktype_part = {
 	.sysfs_ops	= &part_sysfs_ops,
 };
 
+static void dir_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static struct kobj_type dir_ktype = {
+	.release	= dir_release,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
+static inline struct kobject *add_dir(struct kobject *parent, const char *name)
+{
+	struct kobject *k;
+
+	if (!parent)
+		return NULL;
+
+	k = kmalloc(sizeof(*k), GFP_KERNEL);
+	if (!k)
+		return NULL;
+
+	memset(k, 0, sizeof(*k));
+	k->parent = parent;
+	k->ktype = &dir_ktype;
+	kobject_set_name(k, name);
+	kobject_register(k);
+
+	return k;
+}
+
+static inline void partition_sysfs_add_subdir(struct hd_struct *p)
+{
+	struct kobject *k;
+
+	k = kobject_get(&p->kobj);
+	p->holder_dir = add_dir(k, "holders");
+	kobject_put(k);
+}
+
+static inline void disk_sysfs_add_subdirs(struct gendisk *disk)
+{
+	struct kobject *k;
+
+	k = kobject_get(&disk->kobj);
+	disk->holder_dir = add_dir(k, "holders");
+	disk->slave_dir = add_dir(k, "slaves");
+	kobject_put(k);
+}
+
 void delete_partition(struct gendisk *disk, int part)
 {
 	struct hd_struct *p = disk->part[part-1];
@@ -310,6 +360,7 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+	kobject_unregister(p->holder_dir);
 	kobject_unregister(&p->kobj);
 }
 
@@ -337,6 +388,7 @@ void add_partition(struct gendisk *disk,
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+	partition_sysfs_add_subdir(p);
 	disk->part[part-1] = p;
 }
 
@@ -383,6 +435,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+ 	disk_sysfs_add_subdirs(disk);
 	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -483,6 +536,8 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
+	kobject_unregister(disk->holder_dir);
+	kobject_unregister(disk->slave_dir);
 	if (disk->driverfs_dev) {
 		char *disk_name = make_block_name(disk);
 		sysfs_remove_link(&disk->kobj, "device");

--------------060004010804090403080906--
