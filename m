Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSKHCCU>; Thu, 7 Nov 2002 21:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSKHCCU>; Thu, 7 Nov 2002 21:02:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11712 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266708AbSKHCCQ>;
	Thu, 7 Nov 2002 21:02:16 -0500
Message-Id: <200211080208.gA828nD24150@eng4.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: duplicate statistics being gathered
Date: Thu, 07 Nov 2002 18:08:48 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.46, there are now disk statistics being collected twice: once
for gendisk/hd_struct, and once for dkstat.  They are collecting the
same thing.  This patch removes dkstat, which also had the disadvantage
of being limited by DK_MAX_MAJOR and DK_MAX_DISK. (Those #defines are
removed too.)

In addition, this patch removes disk statistics from /proc/stat since
they are now available via sysfs and there seems to have been a general
preference in previous discussions to "clean up" /proc/stat.  Too many
disks being reported in /proc/stat also caused buffer overflows when
trying to print out the data.

The code in led.c from the parisc architecture has not apparently been
recompiled under recent versions of 2.5, since it references
kstat.dk_drive which doesn't exist in later versions.  Accordingly,
I've added an #ifdef 0 and a comment to that code so that it may at
least compile, albeit without one feature -- a step up from its state
now.  If it is preferable to keep the broken code in, that patch may
easily be excised from below.

Rick

diff -ru stat-2.5.46/drivers/block/ll_rw_blk.c stat-2.5.46-rl1/drivers/block/ll_rw_blk.c
--- stat-2.5.46/drivers/block/ll_rw_blk.c	Mon Nov  4 14:30:06 2002
+++ stat-2.5.46-rl1/drivers/block/ll_rw_blk.c	Thu Nov  7 16:52:12 2002
@@ -28,11 +28,6 @@
 #include <linux/slab.h>
 
 /*
- * Disk stats 
- */
-struct disk_stat dkstat;
-
-/*
  * For the allocated request tables
  */
 static kmem_cache_t *request_cachep;
@@ -1433,19 +1428,6 @@
 
 	major = rq->rq_disk->major;
 	index = rq->rq_disk->first_minor >> rq->rq_disk->minor_shift;
-
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
-		return;
-
-	dkstat.drive[major][index] += new_io;
-	if (rw == READ) {
-		dkstat.drive_rio[major][index] += new_io;
-		dkstat.drive_rblk[major][index] += nr_sectors;
-	} else if (rw == WRITE) {
-		dkstat.drive_wio[major][index] += new_io;
-		dkstat.drive_wblk[major][index] += nr_sectors;
-	} else
-		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
 
 /*
diff -ru stat-2.5.46/drivers/parisc/led.c stat-2.5.46-rl1/drivers/parisc/led.c
--- stat-2.5.46/drivers/parisc/led.c	Mon Nov  4 14:30:17 2002
+++ stat-2.5.46-rl1/drivers/parisc/led.c	Thu Nov  7 17:29:09 2002
@@ -403,6 +403,14 @@
 	int major, disk, total;
 	
 	total = 0;
+#ifdef 0
+	/*
+	 * this section will no longer work in 2.5, as we no longer
+	 * have either kstat.dk_drive nor DK_MAX_*.  It can probably
+	 * be rewritten to use the per-disk statistics now kept in the
+	 * gendisk, but since I have no HP machines to test it on, I'm
+	 * not really up to that.  ricklind@us.ibm.com 11/7/02
+	 */
 	for (major = 0; major < DK_MAX_MAJOR; major++) {
 	    for (disk = 0; disk < DK_MAX_DISK; disk++)
 		total += kstat.dk_drive[major][disk];
@@ -416,6 +424,7 @@
 	    } else
 		led_diskio_counter += CALC_ADD(total, diskio_max, addvalue);
 	}
+#endif
 	
 	diskio_total_last += total; 
 }
diff -ru stat-2.5.46/fs/proc/proc_misc.c stat-2.5.46-rl1/fs/proc/proc_misc.c
--- stat-2.5.46/fs/proc/proc_misc.c	Mon Nov  4 14:30:07 2002
+++ stat-2.5.46-rl1/fs/proc/proc_misc.c	Thu Nov  7 16:52:38 2002
@@ -381,26 +381,6 @@
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
 
-	len += sprintf(page + len, "\ndisk_io: ");
-
-	for (major = 0; major < DK_MAX_MAJOR; major++) {
-		for (disk = 0; disk < DK_MAX_DISK; disk++) {
-			int active = dkstat.drive[major][disk] +
-				dkstat.drive_rblk[major][disk] +
-				dkstat.drive_wblk[major][disk];
-			if (active)
-				len += sprintf(page + len,
-					"(%u,%u):(%u,%u,%u,%u,%u) ",
-					major, disk,
-					dkstat.drive[major][disk],
-					dkstat.drive_rio[major][disk],
-					dkstat.drive_rblk[major][disk],
-					dkstat.drive_wio[major][disk],
-					dkstat.drive_wblk[major][disk]
-			);
-		}
-	}
-
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
diff -ru stat-2.5.46/include/linux/blkdev.h stat-2.5.46-rl1/include/linux/blkdev.h
--- stat-2.5.46/include/linux/blkdev.h	Mon Nov  4 14:30:14 2002
+++ stat-2.5.46-rl1/include/linux/blkdev.h	Thu Nov  7 16:54:42 2002
@@ -11,22 +11,6 @@
 
 #include <asm/scatterlist.h>
 
-/*
- * Disk stats ...
- */
-
-#define DK_MAX_MAJOR 16
-#define DK_MAX_DISK 16
- 
-struct disk_stat {
-        unsigned int drive[DK_MAX_MAJOR][DK_MAX_DISK];
-        unsigned int drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
-        unsigned int drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
-        unsigned int drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
-        unsigned int drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
-};
-extern struct disk_stat dkstat;
-
 struct request_queue;
 typedef struct request_queue request_queue_t;
 struct elevator_s;
