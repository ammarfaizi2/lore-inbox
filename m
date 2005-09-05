Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVIEAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVIEAqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIEAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:46:32 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4620 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S932146AbVIEAqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:46:31 -0400
Message-ID: <431B9558.1070900@baanhofman.nl>
Date: Mon, 05 Sep 2005 02:46:16 +0200
From: Wilco Baan Hofman <wilco@baanhofman.nl>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RAID1 ramdisk patch
Content-Type: multipart/mixed;
 boundary="------------050505050106080801020906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505050106080801020906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have written a small patch for use with a HDD-backed ramdisk in the md 
raid1 driver. The raid1 driver usually does read balancing on the disks, 
but I feel that if it encounters a single ram disk in the array that 
should be the preferred read disk. The application of this would be for 
example a 2GB ram disk in raid1 with a 2GB partition, where the ram disk 
is used for reading and both 'disks' used for writing.

Attached is a bit of code which checks for a ram-disk and sets it as 
preferred disk. It also checks if the ram disk is in sync before 
allowing the read.

PS. I am not this list, please CC me if a reply were to be made.

Regards,

Wilco Baan Hofman

--------------050505050106080801020906
Content-Type: text/plain;
 name="syn-raid1ramdisk-20050905.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syn-raid1ramdisk-20050905.patch"

diff -urN linux-2.6.13-rc6.orig/include/linux/raid/raid1.h linux-2.6.13-rc6/include/linux/raid/raid1.h
--- linux-2.6.13-rc6.orig/include/linux/raid/raid1.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6/include/linux/raid/raid1.h	2005-09-04 11:41:24.000000000 +0200
@@ -32,6 +32,7 @@
 	int			raid_disks;
 	int			working_disks;
 	int			last_used;
+	int			preferred_read_disk;
 	sector_t		next_seq_sect;
 	spinlock_t		device_lock;
diff -urN linux-2.6.13-rc6.orig/drivers/md/raid1.c linux-2.6.13-rc6/drivers/md/raid1.c 
--- linux-2.6.13-rc6.orig/drivers/md/raid1.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6/drivers/md/raid1.c	2005-09-05 01:54:26.000000000 +0200
@@ -21,6 +21,8 @@
  * Additions to bitmap code, (C) 2003-2004 Paul Clements, SteelEye Technology:
  * - persistent bitmap code
  *
+ * Special handling of ramdisk (C) 2005 Wilco Baan Hofman <wilco@baanhofman.nl>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
@@ -399,8 +401,6 @@
 			goto rb_out;
 		}
 	}
-	disk = new_disk;
-	/* now disk == new_disk == starting point for search */
 
 	/*
 	 * Don't change to another disk for sequential reads:
@@ -409,7 +409,18 @@
 		goto rb_out;
 	if (this_sector == conf->mirrors[new_disk].head_position)
 		goto rb_out;
-
+	
+	/* [SYN] If the preferred disk exists, return it */
+	if (conf->preferred_read_disk != -1 &&
+			(new_rdev=conf->mirrors[conf->preferred_read_disk].rdev) != NULL &&
+		        new_rdev->in_sync) {
+		new_disk = conf->preferred_read_disk;
+		goto rb_out;
+	}
+	
+	disk = new_disk;
+	/* now disk == new_disk == starting point for search */
+	
 	current_distance = abs(this_sector - conf->mirrors[disk].head_position);
 
 	/* Find the disk whose head is closest */
@@ -1292,10 +1303,11 @@
 static int run(mddev_t *mddev)
 {
 	conf_t *conf;
-	int i, j, disk_idx;
+	int i, j, disk_idx, ram_count;
 	mirror_info_t *disk;
 	mdk_rdev_t *rdev;
 	struct list_head *tmp;
+	char b[BDEVNAME_SIZE];
 
 	if (mddev->level != 1) {
 		printk("raid1: %s: raid level not set to mirroring (%d)\n",
@@ -1417,6 +1429,30 @@
 	mddev->queue->unplug_fn = raid1_unplug;
 	mddev->queue->issue_flush_fn = raid1_issue_flush;
 
+	/* [SYN] if there is a ram disk, that will be the preferred disk.
+	 * .. unless there are multiple ram disks. */
+	conf->preferred_read_disk = -1;
+	for (i = 0,
+	     ram_count = 0; 
+	     i < mddev->raid_disks; 
+	     i++) {
+	
+		bdevname(conf->mirrors[i].rdev->bdev, b);
+		if (strncmp(b, "ram", 3) == 0) {
+			if (ram_count) {
+				conf->preferred_read_disk = -1;
+				break;
+			}
+			conf->preferred_read_disk = i;
+			ram_count++;
+		}
+	}
+	if (conf->preferred_read_disk >= 0) {
+		printk(KERN_INFO 
+			"raid1: One ram disk (%s) found, setting it preferred read disk.\n", b);
+	}
+
+	
 	return 0;
 
 out_no_mem:

--------------050505050106080801020906--
