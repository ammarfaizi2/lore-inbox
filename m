Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTDRQFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDRQEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:04:31 -0400
Received: from verein.lst.de ([212.34.181.86]:12813 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263139AbTDRQBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:01:04 -0400
Date: Fri, 18 Apr 2003 18:12:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (4/7) - cleanup devfs use in scsi
Message-ID: <20030418181258.D363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Store the path of it's devfs directory in struct scsi_device.  Use
it in the devfs_register calls instead of the devfs_handle_t
which will go away soon.


diff -Nru a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/osst.c	Fri Apr 18 15:57:20 2003
@@ -47,6 +47,7 @@
 #include <linux/vmalloc.h>
 #include <linux/version.h>
 #include <linux/blk.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -99,6 +100,8 @@
 };
 #endif
 
+static char *osst_formats[ST_NBR_MODES] ={"", "l", "m", "a"};
+
 /* Some default definitions have been moved to osst_options.h */
 #define OSST_BUFFER_SIZE (OSST_BUFFER_BLOCKS * ST_KILOBYTE)
 #define OSST_WRITE_THRESHOLD (OSST_WRITE_THRESHOLD_BLOCKS * ST_KILOBYTE)
@@ -5524,11 +5527,12 @@
 	write_unlock(&os_scsi_tapes_lock);
 
 	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-		char name[8];
-		static char *formats[ST_NBR_MODES] ={"", "l", "m", "a"};
-		
+		char name[8], devfs_name[64];
+
 		/*  Rewind entry  */
-		sprintf (name, "ot%s", formats[mode]);
+		sprintf(name, "ot%s", osst_formats[mode]);
+		sprintf(devfs_name, "%s/ot%s", SDp->devfs_name, osst_formats[mode]);
+
 		sprintf(tpnt->driverfs_dev_r[mode].bus_id, "%s:%s", 
 				SDp->sdev_driverfs_dev.bus_id, name);
 		sprintf(tpnt->driverfs_dev_r[mode].name, "%s%s", 
@@ -5541,13 +5545,14 @@
 		device_create_file(&tpnt->driverfs_dev_r[mode], 
 				&dev_attr_type);
 		device_create_file(&tpnt->driverfs_dev_r[mode], &dev_attr_kdev);
-		tpnt->de_r[mode] =
-			devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
+		devfs_register(NULL, devfs_name, 0,
 					OSST_MAJOR, dev_num + (mode << 5),
 					S_IFCHR | S_IRUGO | S_IWUGO,
 					&osst_fops, NULL);
 		/*  No-rewind entry  */
-		sprintf (name, "ot%sn", formats[mode]);
+		sprintf (name, "ot%sn", osst_formats[mode]);
+		sprintf(devfs_name, "%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
+
 		sprintf(tpnt->driverfs_dev_n[mode].bus_id, "%s:%s", 
 				SDp->sdev_driverfs_dev.bus_id, name);
 		sprintf(tpnt->driverfs_dev_n[mode].name, "%s%s", 
@@ -5561,8 +5566,7 @@
 				&dev_attr_type);
 		device_create_file(&tpnt->driverfs_dev_n[mode], 
 				&dev_attr_kdev);
-		tpnt->de_n[mode] =
-			devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
+		devfs_register(NULL, devfs_name, 0,
 					OSST_MAJOR, dev_num + (mode << 5) + 128,
 					S_IFCHR | S_IRUGO | S_IWUGO,
 					&osst_fops, NULL);
@@ -5595,10 +5599,8 @@
 	if((tpnt = os_scsi_tapes[i]) && (tpnt->device == SDp)) {
 		tpnt->device = NULL;
 		for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-			devfs_unregister (tpnt->de_r[mode]);
-			tpnt->de_r[mode] = NULL;
-			devfs_unregister (tpnt->de_n[mode]);
-			tpnt->de_n[mode] = NULL;
+			devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
+			devfs_remove("%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
 		}
 		devfs_unregister_tape(tpnt->drive->number);
 		put_disk(tpnt->drive);
diff -Nru a/drivers/scsi/osst.h b/drivers/scsi/osst.h
--- a/drivers/scsi/osst.h	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/osst.h	Fri Apr 18 15:57:20 2003
@@ -5,9 +5,7 @@
 #include <asm/byteorder.h>
 #include <linux/config.h>
 #include <linux/completion.h>
-#ifdef CONFIG_DEVFS_FS
-#include <linux/devfs_fs_kernel.h>
-#endif
+
 
 /*	FIXME - rename and use the following two types or delete them!
  *              and the types really should go to st.h anyway...
@@ -557,8 +555,6 @@
   /* Mode characteristics */
   ST_mode modes[ST_NBR_MODES];
   int current_mode;
-  devfs_handle_t de_r[ST_NBR_MODES];  /*  Rewind entries     */
-  devfs_handle_t de_n[ST_NBR_MODES];  /*  No-rewind entries  */
   struct device driverfs_dev_r[ST_NBR_MODES];
   struct device driverfs_dev_n[ST_NBR_MODES];
 
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/scsi.h	Fri Apr 18 15:57:20 2003
@@ -588,7 +588,8 @@
 	int access_count;	/* Count of open channels/mounts */
 
 	void *hostdata;		/* available to low-level driver */
-	devfs_handle_t de;      /* directory for the device      */
+	char devfs_name[256];	/* devfs junk */
+	devfs_handle_t de;	/* will go away soon */
 	char type;
 	char scsi_level;
 	unsigned char inquiry_len;	/* valid bytes in 'inquiry' */
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/scsi_scan.c	Fri Apr 18 15:57:20 2003
@@ -1244,9 +1244,10 @@
 	
 	scsi_device_register(sdev);
 
-	sdev->de = devfs_mk_dir("scsi/host%d/bus%d/target%d/lun%d",
+	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%d",
 				sdev->host->host_no, sdev->channel,
 				sdev->id, sdev->lun);
+	sdev->de = devfs_mk_dir(sdev->devfs_name);
 
 	/*
 	 * End driverfs/devfs code.
@@ -1733,7 +1734,7 @@
 	if (sdev->attached)
 		return -EINVAL;
 
-	devfs_unregister(sdev->de);
+	devfs_remove(sdev->devfs_name);
 	scsi_device_unregister(sdev);
 
 	scsi_free_sdev(sdev);
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/sg.c	Fri Apr 18 15:57:20 2003
@@ -182,7 +182,6 @@
 	wait_queue_head_t o_excl_wait;	/* queue open() when O_EXCL in use */
 	int sg_tablesize;	/* adapter's max scatter-gather table size */
 	Sg_fd *headfp;		/* first open fd belonging to this device */
-	devfs_handle_t de;
 	volatile char detached;	/* 0->attached, 1->detached pending removal */
 	volatile char exclude;	/* opened for exclusive access */
 	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
@@ -1350,6 +1349,7 @@
 	struct gendisk *disk;
 	Sg_device *sdp = NULL;
 	unsigned long iflags;
+	char devfs_name[64];
 	int k, error;
 
 	disk = alloc_disk(1);
@@ -1447,10 +1447,13 @@
 	device_register(&sdp->sg_driverfs_dev);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 	device_create_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-	sdp->de = devfs_register(scsidp->de, "generic", DEVFS_FL_DEFAULT,
-				 SCSI_GENERIC_MAJOR, k,
-				 S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
-				 &sg_fops, sdp);
+
+	sprintf(devfs_name, "%s/generic", scsidp->devfs_name);
+	devfs_register(NULL, devfs_name, 0,
+			SCSI_GENERIC_MAJOR, k,
+			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
+			&sg_fops, sdp);
+
 	switch (scsidp->type) {
 	case TYPE_DISK:
 	case TYPE_MOD:
@@ -1527,8 +1530,7 @@
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 
 	if (sdp) {
-		devfs_unregister(sdp->de);
-		sdp->de = NULL;
+		devfs_remove("%s/generic", scsidp->devfs_name);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
 		device_unregister(&sdp->sg_driverfs_dev);
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/st.c	Fri Apr 18 15:57:20 2003
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/blk.h>
 #include <linux/moduleparam.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -116,6 +117,7 @@
 };
 #endif
 
+static char *st_formats[ST_NBR_MODES] ={"", "l", "m", "a"};
 
 /* The default definitions have been moved to st_options.h */
 
@@ -3863,11 +3865,12 @@
 	write_unlock(&st_dev_arr_lock);
 
 	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-	    char name[8];
-	    static char *formats[ST_NBR_MODES] ={"", "l", "m", "a"};
+	    char name[8], devfs_name[64];
 
 	    /*  Rewind entry  */
-	    sprintf (name, "mt%s", formats[mode]);
+	    sprintf(name, "mt%s", st_formats[mode]);
+	    sprintf(devfs_name, "%s/mt%s", SDp->devfs_name, st_formats[mode]);
+	    
 	    sprintf(tpnt->driverfs_dev_r[mode].bus_id, "%s:%s", 
 		    SDp->sdev_driverfs_dev.bus_id, name);
 	    sprintf(tpnt->driverfs_dev_r[mode].name, "%s%s", 
@@ -3880,13 +3883,14 @@
 	    device_create_file(&tpnt->driverfs_dev_r[mode], 
 			       &dev_attr_type);
 	    device_create_file(&tpnt->driverfs_dev_r[mode], &dev_attr_kdev);
-	    tpnt->de_r[mode] =
-		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
+	    devfs_register(NULL, devfs_name, 0,
 				SCSI_TAPE_MAJOR, dev_num + (mode << 5),
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				&st_fops, NULL);
 	    /*  No-rewind entry  */
-	    sprintf (name, "mt%sn", formats[mode]);
+	    sprintf (name, "mt%sn", st_formats[mode]);
+	    sprintf(devfs_name, "%s/mt%sn", SDp->devfs_name, st_formats[mode]);
+
 	    sprintf(tpnt->driverfs_dev_n[mode].bus_id, "%s:%s", 
 		    SDp->sdev_driverfs_dev.bus_id, name);
 	    sprintf(tpnt->driverfs_dev_n[mode].name, "%s%s", 
@@ -3900,8 +3904,7 @@
 			       &dev_attr_type);
 	    device_create_file(&tpnt->driverfs_dev_n[mode], 
 			       &dev_attr_kdev);
-	    tpnt->de_n[mode] =
-		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
+	    devfs_register(NULL, devfs_name, 0,
 				SCSI_TAPE_MAJOR, dev_num + (mode << 5) + 128,
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				&st_fops, NULL);
@@ -3939,10 +3942,8 @@
 			write_unlock(&st_dev_arr_lock);
 			devfs_unregister_tape(tpnt->disk->number);
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-				devfs_unregister (tpnt->de_r[mode]);
-				tpnt->de_r[mode] = NULL;
-				devfs_unregister (tpnt->de_n[mode]);
-				tpnt->de_n[mode] = NULL;
+				devfs_remove("%s/mt%s", SDp->devfs_name, st_formats[mode]);
+				devfs_remove("%s/mt%sn", SDp->devfs_name, st_formats[mode]);
 				device_remove_file(&tpnt->driverfs_dev_r[mode],
 						   &dev_attr_type);
 				device_remove_file(&tpnt->driverfs_dev_r[mode],
diff -Nru a/drivers/scsi/st.h b/drivers/scsi/st.h
--- a/drivers/scsi/st.h	Fri Apr 18 15:57:20 2003
+++ b/drivers/scsi/st.h	Fri Apr 18 15:57:20 2003
@@ -5,7 +5,6 @@
 #ifndef _SCSI_H
 #include "scsi.h"
 #endif
-#include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
 
 /* The tape buffer descriptor. */
@@ -104,8 +103,6 @@
 	/* Mode characteristics */
 	ST_mode modes[ST_NBR_MODES];
 	int current_mode;
-	devfs_handle_t de_r[ST_NBR_MODES];  /*  Rewind entries     */
-	devfs_handle_t de_n[ST_NBR_MODES];  /*  No-rewind entries  */
 	struct device driverfs_dev_r[ST_NBR_MODES];
 	struct device driverfs_dev_n[ST_NBR_MODES];
 
