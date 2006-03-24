Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWCXTRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWCXTRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWCXTRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:17:50 -0500
Received: from soundwarez.org ([217.160.171.123]:32710 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751074AbWCXTRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:17:50 -0500
Date: Fri, 24 Mar 2006 20:17:48 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@ftp.linux.org.uk>
Subject: [BLOCK] delay all uevents until partition table is scanned
Message-ID: <20060324191748.GA13654@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@suse.de>

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
---

 fs/partitions/check.c |   40 +++++++++++++++++++++++++++++++---------
 include/linux/genhd.h |    1 +
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index f924f45..54f054c 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -310,7 +310,9 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
-	kobject_unregister(&p->kobj);
+	kobject_uevent(&p->kobj, KOBJ_REMOVE);
+	kobject_del(&p->kobj);
+	kobject_put(&p->kobj);
 }
 
 void add_partition(struct gendisk *disk, int part, sector_t start, sector_t len)
@@ -336,7 +338,10 @@ void add_partition(struct gendisk *disk,
 		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
-	kobject_register(&p->kobj);
+	kobject_init(&p->kobj);
+	kobject_add(&p->kobj);
+	if (!disk->part_uevent_supress)
+		kobject_uevent(&p->kobj, KOBJ_ADD);
 	disk->part[part-1] = p;
 }
 
@@ -373,6 +378,8 @@ void register_disk(struct gendisk *disk)
 {
 	struct block_device *bdev;
 	char *s;
+	int i;
+	struct hd_struct *p;
 	int err;
 
 	strlcpy(disk->kobj.name,disk->disk_name,KOBJ_NAME_LEN);
@@ -382,14 +389,13 @@ void register_disk(struct gendisk *disk)
 		*s = '!';
 	if ((err = kobject_add(&disk->kobj)))
 		return;
-	disk_sysfs_symlinks(disk);
-	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
+	disk_sysfs_symlinks(disk);
 	/* No minors to use for partitions */
 	if (disk->minors == 1) {
 		if (disk->devfs_name[0] != '\0')
 			devfs_add_disk(disk);
-		return;
+		goto exit;
 	}
 
 	/* always add handle for the whole disk */
@@ -397,16 +403,32 @@ void register_disk(struct gendisk *disk)
 
 	/* No such device (e.g., media were just removed) */
 	if (!get_capacity(disk))
-		return;
+		goto exit;
 
 	bdev = bdget_disk(disk, 0);
 	if (!bdev)
-		return;
+		goto exit;
 
+	/* scan partition table, but supress uevents */
 	bdev->bd_invalidated = 1;
-	if (blkdev_get(bdev, FMODE_READ, 0) < 0)
-		return;
+	disk->part_uevent_supress = 1;
+	err = blkdev_get(bdev, FMODE_READ, 0);
+	disk->part_uevent_supress = 0;
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
index eef5ccd..089bb01 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -104,6 +104,7 @@ struct gendisk {
                                          * disks that can't be partitioned. */
 	char disk_name[32];		/* name of major driver */
 	struct hd_struct **part;	/* [indexed by minor] */
+	int part_uevent_supress;
 	struct block_device_operations *fops;
 	struct request_queue *queue;
 	void *private_data;

