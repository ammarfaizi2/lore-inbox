Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVKURsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVKURsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKURsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:48:41 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:56760 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932412AbVKURsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:48:40 -0500
Date: Mon, 21 Nov 2005 18:47:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 2/5] s390: cms volume label definitions.
Message-ID: <20051121174759.GB9638@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 2/5] s390: cms volume label definitions.

Moved definition of CMS volume label to vtoc.h and modify
partitions/ibm.c to use this volume label definition instead
of anonymous array.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/block/dasd_diag.c |    7 ++++---
 drivers/s390/block/dasd_diag.h |   23 +----------------------
 fs/partitions/ibm.c            |   30 +++++++++++++++---------------
 include/asm-s390/vtoc.h        |   24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 40 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-11-21 18:40:05.000000000 +0100
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.51 $
+ * $Revision: 1.52 $
  */
 
 #include <linux/config.h>
@@ -25,6 +25,7 @@
 #include <asm/io.h>
 #include <asm/s390_ext.h>
 #include <asm/todclk.h>
+#include <asm/vtoc.h>
 
 #include "dasd_int.h"
 #include "dasd_diag.h"
@@ -329,7 +330,7 @@ dasd_diag_check_device(struct dasd_devic
 	struct dasd_diag_private *private;
 	struct dasd_diag_characteristics *rdc_data;
 	struct dasd_diag_bio bio;
-	struct dasd_diag_cms_label *label;
+	struct vtoc_cms_label *label;
 	blocknum_t end_block;
 	unsigned int sb, bsize;
 	int rc;
@@ -380,7 +381,7 @@ dasd_diag_check_device(struct dasd_devic
 	mdsk_term_io(device);
 
 	/* figure out blocksize of device */
-	label = (struct dasd_diag_cms_label *) get_zeroed_page(GFP_KERNEL);
+	label = (struct vtoc_cms_label *) get_zeroed_page(GFP_KERNEL);
 	if (label == NULL)  {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
 			    "No memory to allocate initialization request");
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2005-11-21 18:40:05.000000000 +0100
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.8 $
+ * $Revision: 1.9 $
  */
 
 #define MDSK_WRITE_REQ 0x01
@@ -44,27 +44,6 @@ struct dasd_diag_characteristics {
 	u8 rdev_features;
 } __attribute__ ((packed, aligned(4)));
 
-struct dasd_diag_cms_label {
-	u8 label_id[4];
-	u8 vol_id[6];
-	u16 version_id;
-	u32 block_size;
-	u32 origin_ptr;
-	u32 usable_count;
-	u32 formatted_count;
-	u32 block_count;
-	u32 used_count;
-	u32 fst_size;
-	u32 fst_count;
-	u8 format_date[6];
-	u8 reserved1[2];
-	u32 disk_offset;
-	u32 map_block;
-	u32 hblk_disp;
-	u32 user_disp;
-	u8 reserved2[4];
-	u8 segment_name[8];
-} __attribute__ ((packed));
 
 #ifdef CONFIG_ARCH_S390X
 #define DASD_DIAG_FLAGA_DEFAULT		DASD_DIAG_FLAGA_FORMAT_64BIT
diff -urpN linux-2.6/fs/partitions/ibm.c linux-2.6-patched/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	2005-11-21 18:39:49.000000000 +0100
+++ linux-2.6-patched/fs/partitions/ibm.c	2005-11-21 18:40:05.000000000 +0100
@@ -56,7 +56,10 @@ ibm_partition(struct parsed_partitions *
 	struct hd_geometry *geo;
 	char type[5] = {0,};
 	char name[7] = {0,};
-	struct vtoc_volume_label *vlabel;
+	union label_t {
+		struct vtoc_volume_label vol;
+		struct vtoc_cms_label cms;
+	} *label;
 	unsigned char *data;
 	Sector sect;
 
@@ -64,9 +67,8 @@ ibm_partition(struct parsed_partitions *
 		goto out_noinfo;
 	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
 		goto out_nogeo;
-	if ((vlabel = kmalloc(sizeof(struct vtoc_volume_label),
-			      GFP_KERNEL)) == NULL)
-		goto out_novlab;
+	if ((label = kmalloc(sizeof(union label_t), GFP_KERNEL)) == NULL)
+		goto out_nolab;
 	
 	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
 	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
@@ -87,7 +89,7 @@ ibm_partition(struct parsed_partitions *
 		strncpy(name, data + 8, 6);
 	else
 		strncpy(name, data + 4, 6);
-	memcpy (vlabel, data, sizeof(struct vtoc_volume_label));
+	memcpy(label, data, sizeof(union label_t));
 	put_dev_sector(sect);
 
 	EBCASC(type, 4);
@@ -100,14 +102,12 @@ ibm_partition(struct parsed_partitions *
 		/*
 		 * VM style CMS1 labeled disk
 		 */
-		int *label = (int *) vlabel;
-
-		if (label[13] != 0) {
+		if (label->cms.disk_offset != 0) {
 			printk("CMS1/%8s(MDSK):", name);
 			/* disk is reserved minidisk */
-			blocksize = label[3];
-			offset = label[13];
-			size = (label[7] - 1)*(blocksize >> 9);
+			blocksize = label->cms.block_size;
+			offset = label->cms.disk_offset;
+			size = (label->cms.block_count - 1) * (blocksize >> 9);
 		} else {
 			printk("CMS1/%8s:", name);
 			offset = (info->label_block + 1);
@@ -126,7 +126,7 @@ ibm_partition(struct parsed_partitions *
 		printk("VOL1/%8s:", name);
 
 		/* get block number and read then go through format1 labels */
-		blk = cchhb2blk(&vlabel->vtoc, geo) + 1;
+		blk = cchhb2blk(&label->vol.vtoc, geo) + 1;
 		counter = 0;
 		while ((data = read_dev_sector(bdev, blk*(blocksize/512),
 					       &sect)) != NULL) {
@@ -174,7 +174,7 @@ ibm_partition(struct parsed_partitions *
 	}
 
 	printk("\n");
-	kfree(vlabel);
+	kfree(label);
 	kfree(geo);
 	kfree(info);
 	return 1;
@@ -182,8 +182,8 @@ ibm_partition(struct parsed_partitions *
 out_readerr:
 out_badsect:
 out_noioctl:
-	kfree(vlabel);
-out_novlab:
+	kfree(label);
+out_nolab:
 	kfree(geo);
 out_nogeo:
 	kfree(info);
diff -urpN linux-2.6/include/asm-s390/vtoc.h linux-2.6-patched/include/asm-s390/vtoc.h
--- linux-2.6/include/asm-s390/vtoc.h	2005-11-21 18:39:53.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/vtoc.h	2005-11-21 18:40:05.000000000 +0100
@@ -176,4 +176,28 @@ struct vtoc_format7_label
 	struct vtoc_cchhb DS7PTRDS; /* pointer to next FMT7 DSCB */
 } __attribute__ ((packed));
 
+struct vtoc_cms_label {
+	u8 label_id[4];		/* Label identifier */
+	u8 vol_id[6];		/* Volid */
+	u16 version_id;		/* Version identifier */
+	u32 block_size;		/* Disk block size */
+	u32 origin_ptr;		/* Disk origin pointer */
+	u32 usable_count;	/* Number of usable cylinders/blocks */
+	u32 formatted_count;	/* Maximum number of formatted cylinders/
+				 * blocks */
+	u32 block_count;	/* Disk size in CMS blocks */
+	u32 used_count;		/* Number of CMS blocks in use */
+	u32 fst_size;		/* File Status Table (FST) size */
+	u32 fst_count;		/* Number of FSTs per CMS block */
+	u8 format_date[6];	/* Disk FORMAT date */
+	u8 reserved1[2];
+	u32 disk_offset;	/* Disk offset when reserved*/
+	u32 map_block;		/* Allocation Map Block with next hole */
+	u32 hblk_disp;		/* Displacement into HBLK data of next hole */
+	u32 user_disp;		/* Displacement into user part of Allocation
+				 * map */
+	u8 reserved2[4];
+	u8 segment_name[8];	/* Name of shared segment */
+} __attribute__ ((packed));
+
 #endif /* _ASM_S390_VTOC_H */
