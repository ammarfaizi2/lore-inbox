Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVCJBKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVCJBKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVCJBHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:07:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:47519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262614AbVCJAm0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:26 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] floppy.c: pass physical device to device registration
In-Reply-To: <1110414884411@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:45 -0800
Message-Id: <11104148852544@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2047, 2005/03/09 09:53:08-08:00, kay.sievers@vrfy.org

[PATCH] floppy.c: pass physical device to device registration

With this patch the floppy driver creates the usual symlink in sysfs to
the physical device backing the block device:

  $tree /sys/block/
  /sys/block/
  |-- fd0
  |   |-- dev
  |   |-- device -> ../../devices/platform/floppy0
  ...

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/block/floppy.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)


diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2005-03-09 16:28:59 -08:00
+++ b/drivers/block/floppy.c	2005-03-09 16:28:59 -08:00
@@ -4370,6 +4370,10 @@
 		goto out_flush_work;
 	}
 
+	err = platform_device_register(&floppy_device);
+	if (err)
+		goto out_flush_work;
+
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if (!(allowed_drive_mask & (1 << drive)))
 			continue;
@@ -4379,23 +4383,12 @@
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
@@ -4600,7 +4593,6 @@
 	int drive;
 
 	init_completion(&device_release);
-	platform_device_unregister(&floppy_device);
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
@@ -4614,6 +4606,7 @@
 		}
 		put_disk(disks[drive]);
 	}
+	platform_device_unregister(&floppy_device);
 	devfs_remove("floppy");
 
 	del_timer_sync(&fd_timeout);

