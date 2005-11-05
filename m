Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVKESxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVKESxW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVKESxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:53:22 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:1675 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S932201AbVKESxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:53:20 -0500
Date: Sat, 5 Nov 2005 18:52:52 +0000
From: Jon Masters <jonathan@jonmasters.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix readonly "policy" use in gendisk/hd_struct and drivers
Message-ID: <20051105185252.GE27767@apogee.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This modifies the gendisk and hd_struct structs to replace "policy"
with "readonly" (as that's the only use for this field). It also introduces a
new function disk_read_only, which behaves like the corresponding device
functions do.

Signed-off-by: Jon Masters <jcm@jonmasters.org>

diff -urN linux-2.6.14/drivers/block/genhd.c linux-2.6.14_new/drivers/block/genhd.c
--- linux-2.6.14/drivers/block/genhd.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14_new/drivers/block/genhd.c	2005-11-05 16:17:18.000000000 +0000
@@ -655,22 +655,22 @@
 
 EXPORT_SYMBOL(put_disk);
 
-void set_device_ro(struct block_device *bdev, int flag)
+void set_device_ro(struct block_device *bdev, int state)
 {
 	if (bdev->bd_contains != bdev)
-		bdev->bd_part->policy = flag;
+		bdev->bd_part->readonly = state;
 	else
-		bdev->bd_disk->policy = flag;
+		bdev->bd_disk->readonly = state;
 }
 
 EXPORT_SYMBOL(set_device_ro);
 
-void set_disk_ro(struct gendisk *disk, int flag)
+void set_disk_ro(struct gendisk *disk, int state)
 {
 	int i;
-	disk->policy = flag;
+	disk->readonly = state;
 	for (i = 0; i < disk->minors - 1; i++)
-		if (disk->part[i]) disk->part[i]->policy = flag;
+		if (disk->part[i]) disk->part[i]->readonly = state;
 }
 
 EXPORT_SYMBOL(set_disk_ro);
@@ -680,13 +680,23 @@
 	if (!bdev)
 		return 0;
 	else if (bdev->bd_contains != bdev)
-		return bdev->bd_part->policy;
+		return bdev->bd_part->readonly;
 	else
-		return bdev->bd_disk->policy;
+		return bdev->bd_disk->readonly;
 }
 
 EXPORT_SYMBOL(bdev_read_only);
 
+int disk_read_only(struct gendisk *disk)
+{
+	if (!disk)
+		return 0;
+
+	return (disk->readonly);
+}
+
+EXPORT_SYMBOL(disk_read_only);
+
 int invalidate_partition(struct gendisk *disk, int index)
 {
 	int res = 0;
diff -urN linux-2.6.14/drivers/ide/ide-cd.c linux-2.6.14_new/drivers/ide/ide-cd.c
--- linux-2.6.14/drivers/ide/ide-cd.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14_new/drivers/ide/ide-cd.c	2005-11-05 17:27:58.000000000 +0000
@@ -313,7 +313,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/completion.h>
-
+ 
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
 
 #include <asm/irq.h>
@@ -1873,7 +1873,8 @@
 	/*
 	 * disk has become write protected
 	 */
-	if (g->policy) {
+
+	if (disk_read_only(g)) {
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
diff -urN linux-2.6.14/drivers/md/dm-ioctl.c linux-2.6.14_new/drivers/md/dm-ioctl.c
--- linux-2.6.14/drivers/md/dm-ioctl.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14_new/drivers/md/dm-ioctl.c	2005-11-05 17:27:37.000000000 +0000
@@ -538,7 +538,7 @@
 	} else
 		param->open_count = -1;
 
-	if (disk->policy)
+	if (disk_read_only(disk))
 		param->flags |= DM_READONLY_FLAG;
 
 	param->event_nr = dm_get_event_nr(md);
diff -urN linux-2.6.14/include/linux/genhd.h linux-2.6.14_new/include/linux/genhd.h
--- linux-2.6.14/include/linux/genhd.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14_new/include/linux/genhd.h	2005-11-05 16:19:48.000000000 +0000
@@ -79,7 +79,7 @@
 	sector_t nr_sects;
 	struct kobject kobj;
 	unsigned reads, read_sectors, writes, write_sectors;
-	int policy, partno;
+	int readonly, partno;
 };
 
 #define GENHD_FL_REMOVABLE			1
@@ -116,7 +116,7 @@
 	struct kobject kobj;
 
 	struct timer_rand_state *random;
-	int policy;
+	int readonly;			/* needed for underlying media */
 
 	atomic_t sync_io;		/* RAID */
 	unsigned long stamp, stamp_idle;
@@ -230,8 +230,9 @@
 extern void unlink_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *part);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
-extern void set_disk_ro(struct gendisk *disk, int flag);
+extern void set_device_ro(struct block_device *bdev, int state);
+extern void set_disk_ro(struct gendisk *disk, int state);
+extern int disk_read_only(struct gendisk *disk);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
