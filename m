Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277974AbRJRSyV>; Thu, 18 Oct 2001 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277983AbRJRSyM>; Thu, 18 Oct 2001 14:54:12 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:64265 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S277974AbRJRSyC>;
	Thu, 18 Oct 2001 14:54:02 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Thu, 18 Oct 2001 19:39:44 +0100
From: Alan Swanson <swanson@uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix disk statistics in /proc/stat
Message-ID: <20011018193944.A1620@zeus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes /proc/stat to report on all drives with majors or
minors above 15.

More useful for ordinary users, but possible timing impact for servers
from extra loops in drive_stat_acct(). Another patch was discussed last
year (Aug 2000) to change to using the queue structure instead of kstat
but nothing happened.

PRO: Less memory required, faster /proc/stat, all block devices recorded.

CON: Timing critical section of code? Depends on how many drives you
     have. Okay for average desktop user but a server with umpteen SCSI
     drives, maybe not?

Just wondering if this is worth submitting? (Please CC: me, cheers)

Alan.

--- linux-2.4.12/include/linux/kernel_stat.h	Thu Oct 11 22:04:51 2001
+++ linux/include/linux/kernel_stat.h	Tue Oct 16 11:12:27 2001
@@ -12,18 +12,20 @@
  * used by rstatd/perfmeter
  */
 
-#define DK_MAX_MAJOR 16
-#define DK_MAX_DISK 16
+#define DK_DISK_MAX 16
+#define DK_ARRAY 6
+#define DK_MAJOR 0
+#define DK_MINOR 1
+#define DK_RIO 2
+#define DK_RBLK 3
+#define DK_WIO 4
+#define DK_WBLK 5
 
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
 	             per_cpu_system[NR_CPUS];
-	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+	unsigned int dk_drive[DK_DISK_MAX][DK_ARRAY];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
 #if !defined(CONFIG_ARCH_S390)
--- linux-2.4.12/include/linux/genhd.h	Thu Oct 11 22:04:47 2001
+++ linux/include/linux/genhd.h	Tue Oct 16 00:20:31 2001
@@ -259,15 +259,23 @@
 		case DAC960_MAJOR+0:
 			index = (minor & 0x00f8) >> 3;
 			break;
+		case SCSI_CDROM_MAJOR:
+		case SCSI_GENERIC_MAJOR:
+		case MD_MAJOR:
+		case FLOPPY_MAJOR:
+			index = (minor & 0x000f);
+			break;
 		case SCSI_DISK0_MAJOR:
 			index = (minor & 0x00f0) >> 4;
 			break;
 		case IDE0_MAJOR:	/* same as HD_MAJOR */
+		case IDE1_MAJOR:
+		case IDE2_MAJOR:
+		case IDE3_MAJOR:
+		case IDE4_MAJOR:
+		case IDE5_MAJOR:
 		case XT_DISK_MAJOR:
 			index = (minor & 0x0040) >> 6;
-			break;
-		case IDE1_MAJOR:
-			index = ((minor & 0x0040) >> 6) + 2;
 			break;
 		default:
 			return 0;
--- linux-2.4.12/fs/proc/proc_misc.c	Mon Sep 24 22:28:24 2001
+++ linux/fs/proc/proc_misc.c	Sun Oct 14 14:51:14 2001
@@ -264,7 +264,6 @@
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
-	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;
@@ -306,22 +305,20 @@
 
 	len += sprintf(page + len, "\ndisk_io: ");
 
-	for (major = 0; major < DK_MAX_MAJOR; major++) {
-		for (disk = 0; disk < DK_MAX_DISK; disk++) {
-			int active = kstat.dk_drive[major][disk] +
-				kstat.dk_drive_rblk[major][disk] +
-				kstat.dk_drive_wblk[major][disk];
-			if (active)
-				len += sprintf(page + len,
-					"(%u,%u):(%u,%u,%u,%u,%u) ",
-					major, disk,
-					kstat.dk_drive[major][disk],
-					kstat.dk_drive_rio[major][disk],
-					kstat.dk_drive_rblk[major][disk],
-					kstat.dk_drive_wio[major][disk],
-					kstat.dk_drive_wblk[major][disk]
+	for (i = 0; i < DK_DISK_MAX; i++) {
+		if (kstat.dk_drive[i][DK_MAJOR]) {
+			len += sprintf(page + len,
+				"(%u,%u):(%u,%u,%u,%u,%u) ",
+				kstat.dk_drive[i][DK_MAJOR],
+				kstat.dk_drive[i][DK_MINOR],
+				kstat.dk_drive[i][DK_RIO] + kstat.dk_drive[i][DK_WIO],
+				kstat.dk_drive[i][DK_RIO],
+				kstat.dk_drive[i][DK_RBLK],
+				kstat.dk_drive[i][DK_WIO],
+				kstat.dk_drive[i][DK_WBLK]
 			);
-		}
+		} else
+			break;
 	}
 
 	len += sprintf(page + len,
--- linux-2.4.12/drivers/block/ll_rw_blk.c	Mon Sep 24 22:28:02 2001
+++ linux/drivers/block/ll_rw_blk.c	Mon Oct 15 01:22:42 2001
@@ -501,20 +501,27 @@
 {
 	unsigned int major = MAJOR(dev);
 	unsigned int index;
+	int i;
 
 	index = disk_index(dev);
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
-		return;
 
-	kstat.dk_drive[major][index] += new_io;
-	if (rw == READ) {
-		kstat.dk_drive_rio[major][index] += new_io;
-		kstat.dk_drive_rblk[major][index] += nr_sectors;
-	} else if (rw == WRITE) {
-		kstat.dk_drive_wio[major][index] += new_io;
-		kstat.dk_drive_wblk[major][index] += nr_sectors;
-	} else
-		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
+	for (i = 0; i < DK_DISK_MAX; i++){
+		if (kstat.dk_drive[i][DK_MAJOR] == major && kstat.dk_drive[i][DK_MINOR] == index) {
+			if (rw == READ) {
+				kstat.dk_drive[i][DK_RIO] += new_io;
+				kstat.dk_drive[i][DK_RBLK] += nr_sectors;
+			} else if (rw == WRITE) {
+				kstat.dk_drive[i][DK_WIO] += new_io;
+				kstat.dk_drive[i][DK_WBLK] += nr_sectors;
+			} else
+				printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
+			break;
+		} else if (kstat.dk_drive[i][DK_MAJOR] == 0) {
+			kstat.dk_drive[i][DK_MAJOR] = major;
+			kstat.dk_drive[i][DK_MINOR] = index;
+			i--;
+		}
+	}
 }
 
 /*
--- linux-2.4.12/drivers/md/md.c	Wed Oct 10 22:43:12 2001
+++ linux/drivers/md/md.c	Mon Oct 15 23:11:14 2001
@@ -3275,17 +3275,21 @@
 	return NULL;
 }
 
-static unsigned int sync_io[DK_MAX_MAJOR][DK_MAX_DISK];
+static unsigned int sync_io[DK_DISK_MAX];
 void md_sync_acct(kdev_t dev, unsigned long nr_sectors)
 {
 	unsigned int major = MAJOR(dev);
 	unsigned int index;
+	int i;
 
 	index = disk_index(dev);
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
-		return;
 
-	sync_io[major][index] += nr_sectors;
+	for (i = 0; i < DK_DISK_MAX; i++) {
+		if (kstat.dk_drive[i][DK_MAJOR] == major && kstat.dk_drive[i][DK_MINOR] == index)
+			sync_io[i] += nr_sectors;
+		else if (kstat.dk_drive[i][DK_MAJOR] == 0)
+			break;
+	}
 }
 
 static int is_mddev_idle(mddev_t *mddev)
@@ -3300,15 +3304,16 @@
 		int major = MAJOR(rdev->dev);
 		int idx = disk_index(rdev->dev);
 
-		if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
-			continue;
-
-		curr_events = kstat.dk_drive_rblk[major][idx] +
-						kstat.dk_drive_wblk[major][idx] ;
-		curr_events -= sync_io[major][idx];
-		if ((curr_events - rdev->last_events) > 32) {
-			rdev->last_events = curr_events;
-			idle = 0;
+		for (i = 0; i < DK_DISK_MAX; i++) {
+			if (kstat.dk_drive[i][DK_MAJOR] == major && kstat.dk_drive[i][DK_MINOR] == idx) {
+				curr_events = kstat.dk_drive[i][DK_RBLK] + kstat.dk_drive[i][DK_WBLK] ;
+				curr_events -= sync_io[i];
+				if ((curr_events - rdev->last_events) > 32) {
+					rdev->last_events = curr_events;
+					idle = 0;
+				}
+			} else if (kstat.dk_drive[i][DK_MAJOR] == 0)
+				break;
 		}
 	}
 	return idle;
