Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVAPT6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVAPT6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPT6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:58:16 -0500
Received: from soundwarez.org ([217.160.171.123]:51331 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262591AbVAPTzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:55:39 -0500
Date: Sun, 16 Jan 2005 20:55:39 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] floppy.c: pass physical device to device registration
Message-ID: <20050116195539.GA29057@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch the floppy driver creates the usual symlink in sysfs to
the physical device backing the block device:

  $tree /sys/block/
  /sys/block/
  |-- fd0
  |   |-- dev
  |   |-- device -> ../../devices/platform/floppy0
  ...

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/block/floppy.c 1.111 vs edited =====
--- 1.111/drivers/block/floppy.c	2005-01-08 06:44:29 +01:00
+++ edited/drivers/block/floppy.c	2005-01-16 20:24:56 +01:00
@@ -4370,6 +4370,10 @@ int __init floppy_init(void)
 		goto out_flush_work;
 	}
 
+	err = platform_device_register(&floppy_device);
+	if (err)
+		goto out_flush_work;
+
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if (!(allowed_drive_mask & (1 << drive)))
 			continue;
@@ -4379,23 +4383,12 @@ int __init floppy_init(void)
 		disks[drive]->private_data = (void *)(long)drive;
 		disks[drive]->queue = floppy_queue;
 		disks[drive]->flags |= GENHD_FL_REMOVABLE;
+		disks[drive]->driverfs_dev = &floppy_device.dev;
 		add_disk(disks[drive]);
 	}
 
-	err = platform_device_register(&floppy_device);
-	if (err)
-		goto out_del_disk;
-
 	return 0;
 
-out_del_disk:
-	for (drive = 0; drive < N_DRIVE; drive++) {
-		if (!(allowed_drive_mask & (1 << drive)))
-			continue;
-		if (fdc_state[FDC(drive)].version == FDC_NONE)
-			continue;
-		del_gendisk(disks[drive]);
-	}
 out_flush_work:
 	flush_scheduled_work();
 	if (usage_count)
@@ -4600,7 +4593,6 @@ void cleanup_module(void)
 	int drive;
 
 	init_completion(&device_release);
-	platform_device_unregister(&floppy_device);
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
@@ -4614,6 +4606,7 @@ void cleanup_module(void)
 		}
 		put_disk(disks[drive]);
 	}
+	platform_device_unregister(&floppy_device);
 	devfs_remove("floppy");
 
 	del_timer_sync(&fd_timeout);

