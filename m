Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRKHWfB>; Thu, 8 Nov 2001 17:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKHWeo>; Thu, 8 Nov 2001 17:34:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23005 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S278662AbRKHWej>;
	Thu, 8 Nov 2001 17:34:39 -0500
Message-ID: <3BEB0848.735652EF@us.ibm.com>
Date: Thu, 08 Nov 2001 14:33:44 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: [PATCH]Disk IO statisitics gathering for all disks
Content-Type: multipart/mixed;
 boundary="------------D8E5984CAEFAE562A4F813CD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D8E5984CAEFAE562A4F813CD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Attached is a patch to dynamically allocate the data buffers for the
disk statistics, and to extend the gathering of disk statistics to
include major numbers greater than 15.

A disk statistics structure is allocated when a new block device 
is registered.  A global array (kstat.dkdrive_info[]) is used
to hold the address of the statistics structures for all block
devices.  The  disk statistics lookup is the same as before: indexed by
the major number and the disk number.  Note that this patch includes the
changes 
of function disk_index() in genhd.h from linux-2.4.10-ac kernel, in
order to make the disk index lookup work for more disks.

This patch is against 2.4.14 kernel and has been tested.  I greatly
appreciate any feedback from you.  Please take a look and cc you
comments to me.


Have a good day.

-- 
Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc
--------------D8E5984CAEFAE562A4F813CD
Content-Type: text/plain; charset=us-ascii;
 name="dk-scale"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dk-scale"

diff -urN -X dontdiff linux-2.4.13/drivers/block/ll_rw_blk.c /home/ming/linux-13-dk/drivers/block/ll_rw_blk.c
--- linux-2.4.13/drivers/block/ll_rw_blk.c	Sat Oct 13 10:30:30 2001
+++ /home/ming/linux-13-dk/drivers/block/ll_rw_blk.c	Tue Nov  6 15:55:16 2001
@@ -501,20 +501,26 @@
 {
 	unsigned int major = MAJOR(dev);
 	unsigned int index;
+	dk_stat_t * ds;
 
+	ds = kstat.dk_drive_info[major];
+	if (ds == NULL) 
+		return;
+	
 	index = disk_index(dev);
-	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
+	if (index >= DK_MAX_DISK)
 		return;
-
-	kstat.dk_drive[major][index] += new_io;
+	
+	ds += index;
 	if (rw == READ) {
-		kstat.dk_drive_rio[major][index] += new_io;
-		kstat.dk_drive_rblk[major][index] += nr_sectors;
+		ds->dk_drive_rio += new_io;
+		ds->dk_drive_rblk += nr_sectors;
 	} else if (rw == WRITE) {
-		kstat.dk_drive_wio[major][index] += new_io;
-		kstat.dk_drive_wblk[major][index] += nr_sectors;
-	} else
+		ds->dk_drive_wio += new_io;
+		ds->dk_drive_wblk += nr_sectors;
+	} else {
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
+	}
 }
 
 /*
diff -urN -X dontdiff linux-2.4.13/drivers/md/md.c /home/ming/linux-13-dk/drivers/md/md.c
--- linux-2.4.13/drivers/md/md.c	Wed Oct 17 14:21:00 2001
+++ /home/ming/linux-13-dk/drivers/md/md.c	Tue Nov  6 15:55:36 2001
@@ -3301,12 +3301,15 @@
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		int major = MAJOR(rdev->dev);
 		int idx = disk_index(rdev->dev);
+		dk_stat_t * ds;
 
 		if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
 			continue;
 
-		curr_events = kstat.dk_drive_rblk[major][idx] +
-						kstat.dk_drive_wblk[major][idx] ;
+        	if ((ds = kstat.dk_drive_info[major]) == NULL) 
+			continue;
+		ds += idx;
+		curr_events = ds->dk_drive_rblk + ds->dk_drive_wblk;
 		curr_events -= sync_io[major][idx];
 		if ((curr_events - rdev->last_events) > 32) {
 			rdev->last_events = curr_events;
diff -urN -X dontdiff linux-2.4.13/fs/block_dev.c /home/ming/linux-13-dk/fs/block_dev.c
--- linux-2.4.13/fs/block_dev.c	Thu Oct 11 08:32:35 2001
+++ /home/ming/linux-13-dk/fs/block_dev.c	Tue Nov  6 15:20:14 2001
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
+#include <linux/kernel_stat.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/iobuf.h>
@@ -437,11 +438,52 @@
 	return ret;
 }
 
+/*
+ *        Allocate a statistics structure for the give device
+ */
+
+static int alloc_dk_stat(unsigned int major)
+{
+	dk_stat_t * new; 
+	
+	/*allocate space for statistics */
+	if (kstat.dk_drive_info[major] != NULL) {
+		printk(KERN_WARNING "register_blkdev: stat struct"
+			" for device %d exists before register\n",
+			major);
+	} else {
+		int size = sizeof(dk_stat_t) * DK_MAX_DISK;
+		new = (dk_stat_t *)kmalloc(size, GFP_KERNEL);
+		if (new == NULL) {
+			return -ENOMEM;
+		}
+		memset(new, 0, size);
+		kstat.dk_drive_info[major] = new;
+	}
+	return 0;
+}
+
+static void free_dk_stat(unsigned int major)
+{
+	dk_stat_t * ds;
+	
+	ds = kstat.dk_drive_info[major];
+	kstat.dk_drive_info[major] = NULL;
+	
+	if (ds != NULL)
+		kfree(ds);
+}
+
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
+	int err;
+	
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
 			if (blkdevs[major].bdops == NULL) {
+				err = alloc_dk_stat(major);
+				if (err != 0)
+					return err;
 				blkdevs[major].name = name;
 				blkdevs[major].bdops = bdops;
 				return major;
@@ -453,8 +495,13 @@
 		return -EINVAL;
 	if (blkdevs[major].bdops && blkdevs[major].bdops != bdops)
 		return -EBUSY;
+
+	err = alloc_dk_stat(major);
+	if (err != 0)
+		return err;
 	blkdevs[major].name = name;
 	blkdevs[major].bdops = bdops;
+	
 	return 0;
 }
 
@@ -468,6 +515,9 @@
 		return -EINVAL;
 	blkdevs[major].name = NULL;
 	blkdevs[major].bdops = NULL;
+
+	/* free statistic structure */
+	free_dk_stat(major);
 	return 0;
 }
 
diff -urN -X dontdiff linux-2.4.13/fs/proc/proc_misc.c /home/ming/linux-13-dk/fs/proc/proc_misc.c
--- linux-2.4.13/fs/proc/proc_misc.c	Thu Oct 11 10:46:57 2001
+++ /home/ming/linux-13-dk/fs/proc/proc_misc.c	Tue Nov  6 16:16:40 2001
@@ -309,21 +309,26 @@
 
 	len += sprintf(page + len, "\ndisk_io: ");
 
-	for (major = 0; major < DK_MAX_MAJOR; major++) {
+	for (major = 0; major < MAX_BLKDEV; major++) {
+		if ( kstat.dk_drive_info[major] == NULL)
+			continue;
 		for (disk = 0; disk < DK_MAX_DISK; disk++) {
-			int active = kstat.dk_drive[major][disk] +
-				kstat.dk_drive_rblk[major][disk] +
-				kstat.dk_drive_wblk[major][disk];
+			dk_stat_t * ds;
+			int active;
+
+			ds = kstat.dk_drive_info[major] + disk;
+			active = ds->dk_drive_rio + ds->dk_drive_wio +
+				ds->dk_drive_rblk + ds->dk_drive_wblk;
 			if (active)
 				len += sprintf(page + len,
 					"(%u,%u):(%u,%u,%u,%u,%u) ",
 					major, disk,
-					kstat.dk_drive[major][disk],
-					kstat.dk_drive_rio[major][disk],
-					kstat.dk_drive_rblk[major][disk],
-					kstat.dk_drive_wio[major][disk],
-					kstat.dk_drive_wblk[major][disk]
-			);
+					ds->dk_drive_rio + ds->dk_drive_wio,
+					ds->dk_drive_rio,
+					ds->dk_drive_rblk,
+					ds->dk_drive_wio,
+					ds->dk_drive_wblk
+				);
 		}
 	}
 
diff -urN -X dontdiff linux-2.4.13/include/linux/genhd.h /home/ming/linux-13-dk/include/linux/genhd.h
--- linux-2.4.13/include/linux/genhd.h	Tue Oct 23 22:00:42 2001
+++ /home/ming/linux-13-dk/include/linux/genhd.h	Mon Nov  5 16:11:08 2001
@@ -256,21 +256,30 @@
 	unsigned int index;
 
 	switch (major) {
-		case DAC960_MAJOR+0:
-			index = (minor & 0x00f8) >> 3;
-			break;
 		case SCSI_DISK0_MAJOR:
 			index = (minor & 0x00f0) >> 4;
 			break;
 		case IDE0_MAJOR:	/* same as HD_MAJOR */
 		case XT_DISK_MAJOR:
+		case IDE1_MAJOR:
+		case IDE2_MAJOR:
+		case IDE3_MAJOR:
+		case IDE4_MAJOR:
+		case IDE5_MAJOR:
 			index = (minor & 0x0040) >> 6;
 			break;
-		case IDE1_MAJOR:
-			index = ((minor & 0x0040) >> 6) + 2;
+		case SCSI_CDROM_MAJOR:
+			index = minor & 0x000f;
 			break;
 		default:
-			return 0;
+			if (major >= SCSI_DISK1_MAJOR && major <= SCSI_DISK7_MAJOR)
+				index = (minor & 0x00f0) >> 4;
+			else if (major >= DAC960_MAJOR && major <= DAC960_MAJOR + 7)
+				index = (minor & 0x00f8) >> 3;
+			else if (major >= IDE6_MAJOR && major <= IDE9_MAJOR)
+				index = (minor & 0x0040) >> 6;
+			else
+				return 0;
 	}
 	return index;
 }
diff -urN -X dontdiff linux-2.4.13/include/linux/kernel_stat.h /home/ming/linux-13-dk/include/linux/kernel_stat.h
--- linux-2.4.13/include/linux/kernel_stat.h	Tue Oct 23 21:59:06 2001
+++ /home/ming/linux-13-dk/include/linux/kernel_stat.h	Mon Nov  5 16:11:08 2001
@@ -15,15 +15,19 @@
 #define DK_MAX_MAJOR 16
 #define DK_MAX_DISK 16
 
+struct dk_stat{
+	unsigned int dk_drive_rio;
+	unsigned int dk_drive_wio;
+	unsigned int dk_drive_rblk;
+	unsigned int dk_drive_wblk;
+};
+
+typedef struct dk_stat dk_stat_t;
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
 	             per_cpu_system[NR_CPUS];
-	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+	dk_stat_t *dk_drive_info[MAX_BLKDEV];	     
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
 #if !defined(CONFIG_ARCH_S390)


--------------D8E5984CAEFAE562A4F813CD--

