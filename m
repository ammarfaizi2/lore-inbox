Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTDWRlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbTDWRlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:41:18 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:44807 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264181AbTDWRkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:40:36 -0400
Message-ID: <3EA6D2C2.89D17AD3@SteelEye.com>
Date: Wed, 23 Apr 2003 13:52:02 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.68] eliminate interdependency between fs/partitions and md 
 driver and enable persistent superblocks/raidautorun with modular md
References: <3EA595D9.E4CBB684@SteelEye.com> <16037.55226.267006.507998@notabene.cse.unsw.edu.au>
Content-Type: multipart/mixed;
 boundary="------------67413B1D5980079ED2C466D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------67413B1D5980079ED2C466D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch allows the md driver to be built as a module, and
still use the raidautorun feature (basically, using RAID partition
tagging (0xfd) and persistent RAID superblocks to autorun detected
arrays at boot time). This was previously not possible. In the process,
the patch also cleans up some unnecessary, and ugly, interdependencies
between the partitioning code and the md driver. 

The patch should allow vendors to compile md as a module (saving roughly
50k in their default kernel images) without any loss in functionality.
It would also allow other volume managers to use the RAID partition
tagging to autodetect arrays (if desired).

This patch has been tested for several days against 2.5.67/68 with an
md/RAID5 root partition, which gets autorun at boot time (in the
initrd). 

Feedback welcome. Please test, if you're interested. If the patch looks
good, please apply.


Thanks,
Paul


P.S., If anyone is interested, I've also got a patch for UnitedLinux
mk_initrd to make it work properly with modular md and the 2.5 kernel
(look for .ko modules, etc.).
--------------67413B1D5980079ED2C466D0
Content-Type: text/plain; charset=us-ascii;
 name="md_modular_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md_modular_patch.diff"

diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/drivers/md/md.c linux-2.5.68-md_mod/drivers/md/md.c
--- linux-2.5.68/drivers/md/md.c	2003-04-22 12:59:37.000000000 -0400
+++ linux-2.5.68-md_mod/drivers/md/md.c	2003-04-22 12:57:15.000000000 -0400
@@ -34,6 +34,7 @@
 #include <linux/raid/md.h>
 #include <linux/sysctl.h>
 #include <linux/bio.h>
+#include <linux/blkpg.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
 #include <linux/suspend.h>
@@ -59,9 +60,7 @@
 #define dprintk(x...) ((void)(DEBUG && printk(x)))
 
 
-#ifndef MODULE
 static void autostart_arrays (void);
-#endif
 
 static mdk_personality_t *pers[MAX_PERSONALITY];
 static spinlock_t pers_lock = SPIN_LOCK_UNLOCKED;
@@ -1071,7 +1070,6 @@ static void unlock_rdev(mdk_rdev_t *rdev
 	blkdev_put(bdev, BDEV_RAW);
 }
 
-void md_autodetect_dev(dev_t dev);
 
 static void export_rdev(mdk_rdev_t * rdev)
 {
@@ -1081,9 +1079,7 @@ static void export_rdev(mdk_rdev_t * rde
 		MD_BUG();
 	free_disk_sb(rdev);
 	list_del_init(&rdev->same_set);
-#ifndef MODULE
-	md_autodetect_dev(rdev->bdev->bd_dev);
-#endif
+	raid_autodetect_dev(rdev->bdev->bd_dev);
 	unlock_rdev(rdev);
 	kfree(rdev);
 }
@@ -2378,12 +2374,10 @@ static int md_ioctl(struct inode *inode,
 			md_print_devices();
 			goto done;
 
-#ifndef MODULE
 		case RAID_AUTORUN:
 			err = 0;
 			autostart_arrays();
 			goto done;
-#endif
 		default:;
 	}
 
@@ -3497,23 +3491,8 @@ int __init md_init(void)
 	raid_table_header = register_sysctl_table(raid_root_table, 1);
 
 	md_geninit();
-	return (0);
-}
-
-
-#ifndef MODULE
 
-/*
- * Searches all registered partitions for autorun RAID arrays
- * at boot time.
- */
-static dev_t detected_devices[128];
-static int dev_cnt;
-
-void md_autodetect_dev(dev_t dev)
-{
-	if (dev_cnt >= 0 && dev_cnt < 127)
-		detected_devices[dev_cnt++] = dev;
+	return (0);
 }
 
 
@@ -3524,8 +3503,8 @@ static void autostart_arrays(void)
 
 	printk(KERN_INFO "md: Autodetecting RAID arrays.\n");
 
-	for (i = 0; i < dev_cnt; i++) {
-		dev_t dev = detected_devices[i];
+	for (i = 0; i < raid_num_detected_devs(); i++) {
+		dev_t dev = raid_get_detected_dev(i);
 
 		rdev = md_import_device(dev,0, 0);
 		if (IS_ERR(rdev)) {
@@ -3539,13 +3518,10 @@ static void autostart_arrays(void)
 		}
 		list_add(&rdev->same_set, &pending_raid_disks);
 	}
-	dev_cnt = 0;
 
 	autorun_devices();
 }
 
-#endif
-
 static __exit void md_exit(void)
 {
 	int i;
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/fs/partitions/Makefile linux-2.5.68-md_mod/fs/partitions/Makefile
--- linux-2.5.68/fs/partitions/Makefile	2003-04-19 22:49:14.000000000 -0400
+++ linux-2.5.68-md_mod/fs/partitions/Makefile	2003-04-22 14:31:44.000000000 -0400
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := check.o
+obj-y := check.o raid.o
 
 obj-$(CONFIG_ACORN_PARTITION) += acorn.o
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/fs/partitions/check.c linux-2.5.68-md_mod/fs/partitions/check.c
--- linux-2.5.68/fs/partitions/check.c	2003-04-19 22:50:49.000000000 -0400
+++ linux-2.5.68-md_mod/fs/partitions/check.c	2003-04-22 14:32:45.000000000 -0400
@@ -21,6 +21,7 @@
 #include <linux/ctype.h>
 
 #include "check.h"
+#include "raid.h"
 
 #include "acorn.h"
 #include "amiga.h"
@@ -36,10 +37,6 @@
 #include "ultrix.h"
 #include "efi.h"
 
-#if CONFIG_BLK_DEV_MD
-extern void md_autodetect_dev(dev_t dev);
-#endif
-
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
 static int (*check_part[])(struct parsed_partitions *, struct block_device *) = {
@@ -307,11 +304,9 @@ void register_disk(struct gendisk *disk)
 			if (!size)
 				continue;
 			add_partition(disk, j, from, size);
-#if CONFIG_BLK_DEV_MD
 			if (!state->parts[j].flags)
 				continue;
-			md_autodetect_dev(bdev->bd_dev+j);
-#endif
+			raid_autodetect_dev(bdev->bd_dev+j);
 		}
 		kfree(state);
 	}
@@ -342,10 +337,8 @@ int rescan_partitions(struct gendisk *di
 		if (!size)
 			continue;
 		add_partition(disk, p, from, size);
-#if CONFIG_BLK_DEV_MD
 		if (state->parts[p].flags)
-			md_autodetect_dev(bdev->bd_dev+p);
-#endif
+			raid_autodetect_dev(bdev->bd_dev+p);
 	}
 	kfree(state);
 	return res;
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/fs/partitions/raid.c linux-2.5.68-md_mod/fs/partitions/raid.c
--- linux-2.5.68/fs/partitions/raid.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.68-md_mod/fs/partitions/raid.c	2003-04-22 15:21:25.000000000 -0400
@@ -0,0 +1,31 @@
+/*
+ * Save registered partitions that are marked as autorun RAID arrays.
+ *
+ * check.c saves the partitions by calling raid_autodetect_dev at boot time
+ * md.c uses the partition list to do its autostart_arrays 
+ *
+ * code taken from md.c and new code added - 2003, Paul Clements
+ */
+
+#include <linux/fs.h>
+
+static dev_t detected_devices[128];
+static int dev_cnt;
+
+void raid_autodetect_dev(dev_t dev)
+{
+        if (dev_cnt >= 0 && dev_cnt < 128)
+                detected_devices[dev_cnt++] = dev;
+}
+
+dev_t raid_get_detected_dev(int i)
+{
+	if (i >= 0 && i < dev_cnt)
+		return detected_devices[i];
+	return (dev_t) 0;
+}
+
+int raid_num_detected_devs(void)
+{
+	return dev_cnt;
+}
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/fs/partitions/raid.h linux-2.5.68-md_mod/fs/partitions/raid.h
--- linux-2.5.68/fs/partitions/raid.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.68-md_mod/fs/partitions/raid.h	2003-04-22 14:31:45.000000000 -0400
@@ -0,0 +1,5 @@
+/*
+ *  fs/partitions/raid.h
+ */
+
+void raid_autodetect_dev(dev_t dev);
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/include/linux/blkpg.h linux-2.5.68-md_mod/include/linux/blkpg.h
--- linux-2.5.68/include/linux/blkpg.h	2003-04-19 22:49:25.000000000 -0400
+++ linux-2.5.68-md_mod/include/linux/blkpg.h	2003-04-22 15:35:50.000000000 -0400
@@ -57,6 +57,9 @@ struct blkpg_partition {
 #ifdef __KERNEL__
 
 extern char * partition_name(dev_t dev);
+extern void raid_autodetect_dev(dev_t dev);
+extern dev_t raid_get_detected_dev(int i);
+extern int raid_num_detected_devs(void);
 
 #endif /* __KERNEL__ */
 
diff -purN --exclude-from /export/public/clemep/tmp/dontdiff linux-2.5.68/kernel/ksyms.c linux-2.5.68-md_mod/kernel/ksyms.c
--- linux-2.5.68/kernel/ksyms.c	2003-04-19 22:48:49.000000000 -0400
+++ linux-2.5.68-md_mod/kernel/ksyms.c	2003-04-22 15:36:23.000000000 -0400
@@ -576,7 +576,11 @@ EXPORT_SYMBOL(fs_overflowgid);
 EXPORT_SYMBOL(fasync_helper);
 EXPORT_SYMBOL(kill_fasync);
 
+/* partition stuff */
 EXPORT_SYMBOL(partition_name);
+EXPORT_SYMBOL(raid_autodetect_dev);
+EXPORT_SYMBOL(raid_get_detected_dev);
+EXPORT_SYMBOL(raid_num_detected_devs);
 
 /* binfmt_aout */
 EXPORT_SYMBOL(get_write_access);

--------------67413B1D5980079ED2C466D0--

