Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTDNS2S (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDNSOv (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:14:51 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:21775 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263631AbTDNSAo (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:00:44 -0400
Date: Mon, 14 Apr 2003 20:12:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <UTC200304132245.h3DMjaT25518.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304142000460.12110-100000@serv>
References: <UTC200304132245.h3DMjaT25518.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003 Andries.Brouwer@cwi.nl wrote:

> Below a kdev_t.h diff. I suppose it can be applied.
> (For myself I prefer a complete check of all code involved
> but I can see that people are somewhat impatient.)
> This is the part that changes MAJOR/MINOR/MKDEV,
> that is, the structure of dev_t.

Linus, if you still want to go for a single block device major, this patch 
is bad idea (at least in this form).
The patch below demonstrates how we can use the space above 0x10000 as one 
big major. Drivers only have to set disk->major to 0 and it gets a device 
number. 
Simply expanding the dev_t number does not solve the problems, e.g. 
changing the number of partitions is still a problem. Below I added a 
GENHD_FL_DYNAMIC flag so the upper layer knows, that some values are only 
a hint and that it can change them (e.g. when the user requests it).

bye, Roman

diff -ur linux-2.5.67-cdev4/drivers/block/genhd.c linux-2.5.67-cdev5/drivers/block/genhd.c
--- linux-2.5.67-cdev4/drivers/block/genhd.c	2003-04-04 19:29:33.000000000 +0200
+++ linux-2.5.67-cdev5/drivers/block/genhd.c	2003-04-13 22:56:26.000000000 +0200
@@ -244,6 +244,12 @@
 	return 0;
 }
 
+#define DISK_NR		16384
+
+static unsigned long disk_index_bits[DISK_NR / BITS_PER_LONG];
+static spinlock_t disk_index_lock = SPIN_LOCK_UNLOCKED;
+int force_dyndisks = 1;
+
 /**
  * add_gendisk - add partitioning information to kernel list
  * @disk: per-device partitioning information
@@ -251,13 +257,40 @@
  * This function registers the partitioning information in @disk
  * with the kernel.
  */
-void add_disk(struct gendisk *disk)
+int add_disk(struct gendisk *disk)
 {
+	if (!disk->major || (force_dyndisks && disk->flags & GENHD_FL_DYNAMIC)) {
+		char name[8], *p = name + 7;
+		int index;
+
+		spin_lock(&disk_index_lock);
+		index = find_first_zero_bit(disk_index_bits, DISK_NR);
+		if (index == DISK_NR) {
+			spin_unlock(&disk_index_lock);
+			return -EBUSY;
+		}
+		__set_bit(index, disk_index_bits);
+		spin_unlock(&disk_index_lock);
+
+		disk->major = 256 + index;
+		disk->first_minor = 0;
+
+		*p-- = 0;
+		while (index > 25) {
+			*p-- = 'a' + index % 26;
+			index = index / 26 - 1;
+		}
+		*p = 'a' + index;
+		sprintf(disk->disk_name, "disk%s", p);
+	}
+
 	disk->flags |= GENHD_FL_UP;
 	blk_register_region(MKDEV(disk->major, disk->first_minor),
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	elv_register_queue(disk);
+
+	return 0;
 }
 
 EXPORT_SYMBOL(add_disk);
@@ -265,6 +298,11 @@
 
 void unlink_gendisk(struct gendisk *disk)
 {
+	if (disk->major >= 256 && disk->major < 256 + DISK_NR) {
+		spin_lock(&disk_index_lock);
+		clear_bit(disk->major - 256, disk_index_bits);
+		spin_unlock(&disk_index_lock);
+	}
 	elv_unregister_queue(disk);
 	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
 			      disk->minors);
diff -ur linux-2.5.67-cdev4/drivers/scsi/sd.c linux-2.5.67-cdev5/drivers/scsi/sd.c
--- linux-2.5.67-cdev4/drivers/scsi/sd.c	2003-03-19 02:16:32.000000000 +0100
+++ linux-2.5.67-cdev5/drivers/scsi/sd.c	2003-04-13 22:56:26.000000000 +0200
@@ -1314,12 +1314,8 @@
 
 	spin_lock(&sd_index_lock);
 	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
-	if (index == SD_DISKS) {
-		spin_unlock(&sd_index_lock);
-		error = -EBUSY;
-		goto out_put;
-	}
-	__set_bit(index, sd_index_bits);
+	if (index != SD_DISKS)
+		__set_bit(index, sd_index_bits);
 	spin_unlock(&sd_index_lock);
 
 	sdkp->device = sdp;
@@ -1328,22 +1324,24 @@
 	sdkp->index = index;
 
 	gd->de = sdp->de;
-	gd->major = sd_major(index >> 4);
-	gd->first_minor = (index & 15) << 4;
 	gd->minors = 16;
 	gd->fops = &sd_fops;
-
-	if (index >= 26) {
-		sprintf(gd->disk_name, "sd%c%c",
-			'a' + index/26-1,'a' + index % 26);
-	} else {
-		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
+	if (index != SD_DISKS) {
+		gd->major = sd_major(index >> 4);
+		gd->first_minor = (index & 15) << 4;
+
+		if (index >= 26) {
+			sprintf(gd->disk_name, "sd%c%c",
+				'a' + index/26-1,'a' + index % 26);
+		} else {
+			sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
+		}
 	}
 
 	sd_init_onedisk(sdkp, gd);
 
 	gd->driverfs_dev = &sdp->sdev_driverfs_dev;
-	gd->flags = GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
+	gd->flags = GENHD_FL_DRIVERFS | GENHD_FL_DEVFS | GENHD_FL_DYNAMIC;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
 	gd->private_data = &sdkp->driver;
@@ -1351,7 +1349,9 @@
 
 	sd_devlist_insert(sdkp);
 	set_capacity(gd, sdkp->capacity);
-	add_disk(gd);
+	error = add_disk(gd);
+	if (error)
+		goto out_put;
 
 	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
 	       "id %d, lun %d\n", sdp->removable ? "removable " : "",
diff -ur linux-2.5.67-cdev4/include/linux/genhd.h linux-2.5.67-cdev5/include/linux/genhd.h
--- linux-2.5.67-cdev4/include/linux/genhd.h	2003-03-19 02:17:32.000000000 +0100
+++ linux-2.5.67-cdev5/include/linux/genhd.h	2003-04-13 22:56:26.000000000 +0200
@@ -71,6 +71,7 @@
 #define GENHD_FL_DEVFS	4
 #define GENHD_FL_CD	8
 #define GENHD_FL_UP	16
+#define GENHD_FL_DYNAMIC 32
 
 struct disk_stats {
 	unsigned read_sectors, write_sectors;
@@ -190,7 +191,7 @@
 extern void disk_round_stats(struct gendisk *disk);
 
 /* drivers/block/genhd.c */
-extern void add_disk(struct gendisk *disk);
+extern int add_disk(struct gendisk *disk);
 extern void del_gendisk(struct gendisk *gp);
 extern void unlink_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *part);

