Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWDNULI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWDNULI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWDNULH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:1677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965134AbWDNULF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:05 -0400
Cc: Kay Sievers <kay.sievers@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/7] BLOCK: delay all uevents until partition table is scanned
In-Reply-To: <11450453961549-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:56 -0700
Message-Id: <11450453961808-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BLOCK] delay all uevents until partition table is scanned

Here we delay the annoucement of all block device events until the
disk's partition table is scanned and all partition devices are already
created and sysfs is populated.

We have a bunch of old bugs for removable storage handling where we
probe successfully for a filesystem on the raw disk, but at the
same time the kernel recognizes a partition table and creates partition
devices.
Currently there is no sane way to tell if partitions will show up or not
at the time the disk device is announced to userspace. With the delayed
events we can simply skip any probe for a filesystem on the raw disk when
we find already present partitions.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/partitions/check.c |   38 ++++++++++++++++++++++++++++++--------
 include/linux/genhd.h |    1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

d4d7e5dffc4844ef51fe11f497bd774c04413a00
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index af0cb4b..f3b6af0 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -331,7 +331,9 @@ void delete_partition(struct gendisk *di
 	devfs_remove("%s/part%d", disk->devfs_name, part);
 	if (p->holder_dir)
 		kobject_unregister(p->holder_dir);
-	kobject_unregister(&p->kobj);
+	kobject_uevent(&p->kobj, KOBJ_REMOVE);
+	kobject_del(&p->kobj);
+	kobject_put(&p->kobj);
 }
 
 void add_partition(struct gendisk *disk, int part, sector_t start, sector_t len)
@@ -357,7 +359,10 @@ void add_partition(struct gendisk *disk,
 		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
-	kobject_register(&p->kobj);
+	kobject_init(&p->kobj);
+	kobject_add(&p->kobj);
+	if (!disk->part_uevent_suppress)
+		kobject_uevent(&p->kobj, KOBJ_ADD);
 	partition_sysfs_add_subdir(p);
 	disk->part[part-1] = p;
 }
@@ -395,6 +400,8 @@ void register_disk(struct gendisk *disk)
 {
 	struct block_device *bdev;
 	char *s;
+	int i;
+	struct hd_struct *p;
 	int err;
 
 	strlcpy(disk->kobj.name,disk->disk_name,KOBJ_NAME_LEN);
@@ -406,13 +413,12 @@ void register_disk(struct gendisk *disk)
 		return;
 	disk_sysfs_symlinks(disk);
  	disk_sysfs_add_subdirs(disk);
-	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
 	if (disk->minors == 1) {
 		if (disk->devfs_name[0] != '\0')
 			devfs_add_disk(disk);
-		return;
+		goto exit;
 	}
 
 	/* always add handle for the whole disk */
@@ -420,16 +426,32 @@ void register_disk(struct gendisk *disk)
 
 	/* No such device (e.g., media were just removed) */
 	if (!get_capacity(disk))
-		return;
+		goto exit;
 
 	bdev = bdget_disk(disk, 0);
 	if (!bdev)
-		return;
+		goto exit;
 
+	/* scan partition table, but suppress uevents */
 	bdev->bd_invalidated = 1;
-	if (blkdev_get(bdev, FMODE_READ, 0) < 0)
-		return;
+	disk->part_uevent_suppress = 1;
+	err = blkdev_get(bdev, FMODE_READ, 0);
+	disk->part_uevent_suppress = 0;
+	if (err < 0)
+		goto exit;
 	blkdev_put(bdev);
+
+exit:
+	/* announce disk after possible partitions are already created */
+	kobject_uevent(&disk->kobj, KOBJ_ADD);
+
+	/* announce possible partitions */
+	for (i = 1; i < disk->minors; i++) {
+		p = disk->part[i-1];
+		if (!p || !p->nr_sects)
+			continue;
+		kobject_uevent(&p->kobj, KOBJ_ADD);
+	}
 }
 
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 10a27f2..2ef845b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -105,6 +105,7 @@ struct gendisk {
                                          * disks that can't be partitioned. */
 	char disk_name[32];		/* name of major driver */
 	struct hd_struct **part;	/* [indexed by minor] */
+	int part_uevent_suppress;
 	struct block_device_operations *fops;
 	struct request_queue *queue;
 	void *private_data;
-- 
1.2.6


