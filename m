Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSFQU3N>; Mon, 17 Jun 2002 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSFQU2l>; Mon, 17 Jun 2002 16:28:41 -0400
Received: from psmtp2.dnsg.net ([193.168.128.42]:26547 "HELO psmtp2.dnsg.net")
	by vger.kernel.org with SMTP id <S316991AbSFQU1K>;
	Mon, 17 Jun 2002 16:27:10 -0400
Subject: [PATCH] 2.5.22: ibm partition support.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2002 00:25:52 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17K4wb-0000Kn-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
another resend of the partition patch for ibm.c. Nobody sent a veto so far
so please add it.

blues skies,
  Martin.

diff -urN linux-2.5.22/fs/partitions/Makefile linux-2.5.22-s390/fs/partitions/Makefile
--- linux-2.5.22/fs/partitions/Makefile	Mon Jun 17 04:31:30 2002
+++ linux-2.5.22-s390/fs/partitions/Makefile	Mon May 27 14:33:09 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-export-objs := check.o ibm.o msdos.o
+export-objs := check.o msdos.o
 
 obj-y := check.o
 
diff -urN linux-2.5.22/fs/partitions/check.c linux-2.5.22-s390/fs/partitions/check.c
--- linux-2.5.22/fs/partitions/check.c	Mon Jun 17 04:31:30 2002
+++ linux-2.5.22-s390/fs/partitions/check.c	Mon Jun 17 14:18:23 2002
@@ -83,13 +83,17 @@
 
 /*
  *	This is ucking fugly but its probably the best thing for 2.4.x
- *	Take it as a clear reminder than we should put the device name
+ *	Take it as a clear reminder that: 1) we should put the device name
  *	generation in the object kdev_t points to in 2.5.
+ *	and 2) ioctls better work on half-opened devices.
  */
  
 #ifdef CONFIG_ARCH_S390
 int (*genhd_dasd_name)(char*,int,int,struct gendisk*) = NULL;
+int (*genhd_dasd_ioctl)(struct inode *inp, struct file *filp,
+			unsigned int no, unsigned long data);
 EXPORT_SYMBOL(genhd_dasd_name);
+EXPORT_SYMBOL(genhd_dasd_ioctl);
 #endif
 
 /*
diff -urN linux-2.5.22/fs/partitions/ibm.c linux-2.5.22-s390/fs/partitions/ibm.c
--- linux-2.5.22/fs/partitions/ibm.c	Mon Jun 17 04:31:36 2002
+++ linux-2.5.22-s390/fs/partitions/ibm.c	Mon May 27 14:33:09 2002
@@ -8,6 +8,7 @@
  * History of changes (starts July 2000)
  * 07/10/00 Fixed detection of CMS formatted disks     
  * 02/13/00 VTOC partition support added
+ * 12/27/01 fixed PL030593 (CMS reserved minidisk not detected on 64 bit)
  */
 
 #include <linux/config.h>
@@ -29,47 +30,6 @@
 #include "check.h"
 #include <asm/vtoc.h>
 
-typedef enum {
-  ibm_partition_lnx1 = 0,
-  ibm_partition_vol1 = 1,
-  ibm_partition_cms1 = 2,
-  ibm_partition_none = 3
-} ibm_partition_t;
-
-static char* part_names[] = {   [ibm_partition_lnx1] = "LNX1",
-			     [ibm_partition_vol1] = "VOL1",
-			     [ibm_partition_cms1] = "CMS1",
-			     [ibm_partition_none] = "(nonl)"
-};
-
-static ibm_partition_t
-get_partition_type ( char * type )
-{
-	int i;
-	for ( i = 0; i < 3; i ++) {
-		if ( ! strncmp (type,part_names[i],4) ) 
-			break;
-	}
-        return i;
-}
-
-/*
- * add the two default partitions
- * - whole dasd
- * - whole dasd without "offset"
- */
-static inline void
-two_partitions(struct gendisk *hd,
-	       int minor,
-	       int blocksize,
-	       int offset,
-	       int size) {
-
-        add_gd_partition( hd, minor, 0, size);
-	add_gd_partition( hd, minor+1, offset*blocksize, size-offset*blocksize);
-}
-
-
 /*
  * compute the block number from a 
  * cyl-cyl-head-head structure
@@ -92,115 +52,186 @@
 		ptr->b;
 }
 
+/*
+ * We used to use ioctl_by_bdev in early 2.4, but it broke
+ * between 2.4.9 and 2.4.18 somewhere.
+ */
+extern int (*genhd_dasd_ioctl)(struct inode *inp, struct file *filp,
+			       unsigned int no, unsigned long data);
+
+static int
+ibm_ioctl_unopened(struct block_device *bdev, unsigned cmd, unsigned long arg)
+{
+	int res;
+	mm_segment_t old_fs = get_fs();
+	
+	if (genhd_dasd_ioctl == NULL)
+		return -ENODEV;
+#if 0
+	lock_kernel();
+	if (bd_ops->owner)
+		__MOD_INC_USE_COUNT(bdev->bd_op->owner);
+	unlock_kernel();
+#endif
+	set_fs(KERNEL_DS);
+	res = (*genhd_dasd_ioctl)(bdev->bd_inode, NULL, cmd, arg);
+	set_fs(old_fs);
+#if 0
+	lock_kernel();
+	if (bd_ops->owner)
+		__MOD_DEV_USE_COUNT(bd_ops->owner);
+	unlock_kernel();
+#endif
+	return res;
+}
+
+/*
+ */
 int 
 ibm_partition(struct gendisk *hd, struct block_device *bdev,
-		unsigned long first_sector, int first_part_minor)
+	      unsigned long first_sector, int first_part_minor)
 {
-	Sector sect, sect2;
-	unsigned char *data;
-	ibm_partition_t partition_type;
+	int blocksize, offset, size;
+	dasd_information_t *info;
+	struct hd_geometry *geo;
 	char type[5] = {0,};
 	char name[7] = {0,};
-	struct hd_geometry *geo;
-	int blocksize;
-	int offset=0, size=0, psize=0, counter=0;
-	unsigned int blk;
-	format1_label_t f1;
-	volume_label_t vlabel;
-	dasd_information_t *info;
-	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	volume_label_t *vlabel;
+	unsigned char *data;
+	Sector sect;
 
 	if ( first_sector != 0 )
 		BUG();
 
-	info = (struct dasd_information_t *)kmalloc(sizeof(dasd_information_t),
-						    GFP_KERNEL);
-	if ( info == NULL )
-		return 0;
-	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)(info)))
-		return 0;
-	geo = (struct hd_geometry *)kmalloc(sizeof(struct hd_geometry),
-					    GFP_KERNEL);
-	if ( geo == NULL )
-		return 0;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
-		return 0;
-	blocksize = bdev_hardsect_size(bdev) >> 9;
+	if ((info = kmalloc(sizeof(dasd_information_t), GFP_KERNEL)) == NULL)
+		goto out_noinfo;
+	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
+		goto out_nogeo;
+	if ((vlabel = kmalloc(sizeof(volume_label_t), GFP_KERNEL)) == NULL)
+		goto out_novlab;
+	
+	if (ibm_ioctl_unopened(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
+	    ibm_ioctl_unopened(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+		goto out_noioctl;
 	
-	data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
-	if (!data)
-		return 0;
+	if ((blocksize = bdev_hardsect_size(bdev)) <= 0)
+		goto out_badsect;
+
+	/*
+	 * Get volume label, extract name and type.
+	 */
+	data = read_dev_sector(bdev, info->label_block*(blocksize/512), &sect);
+	if (data == NULL)
+		goto out_readerr;
 
 	strncpy (type, data, 4);
-	if ((!info->FBA_layout) && (!strcmp(info->type,"ECKD"))) {
-		strncpy ( name, data + 8, 6);
-	} else {
-		strncpy ( name, data + 4, 6);
-	}
-	memcpy (&vlabel, data, sizeof(volume_label_t));
+	if ((!info->FBA_layout) && (!strcmp(info->type, "ECKD")))
+		strncpy(name, data + 8, 6);
+	else
+		strncpy(name, data + 4, 6);
+	memcpy (vlabel, data, sizeof(volume_label_t));
+	put_dev_sector(sect);
 
-	EBCASC(type,4);
-	EBCASC(name,6);
-	
-	partition_type = get_partition_type(type);
-	printk ( "%4s/%8s:",part_names[partition_type],name);
-	switch ( partition_type ) {
-	case ibm_partition_cms1:
-		if (* ((long *)data + 13) != 0) {
+	EBCASC(type, 4);
+	EBCASC(name, 6);
+
+	/*
+	 * Three different types: CMS1, VOL1 and LNX1/unlabeled
+	 */
+	if (strncmp(type, "CMS1", 4) == 0) {
+		/*
+		 * VM style CMS1 labeled disk
+		 */
+		int *label = (int *) data;
+
+		if (label[13] != 0) {
+			printk("CMS1/%8s(MDSK):", name);
 			/* disk is reserved minidisk */
-			long *label=(long*)data;
-			blocksize = label[3]>>9;
+			blocksize = label[3];
 			offset = label[13];
-			size = (label[7]-1)*blocksize; 
-			printk ("(MDSK)");
+			size = (label[7] - 1)*(blocksize >> 9);
 		} else {
+			printk("CMS1/%8s:", name);
 			offset = (info->label_block + 1);
-			size = hd -> sizes[MINOR(dev)]<<1;
+			size = bdev->bd_inode->i_size >> 9;
 		}
-		two_partitions( hd, MINOR(dev), blocksize, offset, size);
-		break;
-	case ibm_partition_lnx1: 
-	case ibm_partition_none:
-		offset = (info->label_block + 1);
-		size = hd -> sizes[MINOR(dev)]<<1;
-		two_partitions( hd, MINOR(dev), blocksize, offset, size);
-		break;
-	case ibm_partition_vol1: 
-		size = hd -> sizes[MINOR(dev)]<<1;
-		add_gd_partition(hd, MINOR(dev), 0, size);
-		
-		/* get block number and read then first format1 label */
-		blk = cchhb2blk(&vlabel.vtoc, geo) + 1;
-		data = read_dev_sector(bdev, blk * blocksize, &sect2);
-		if (data) {
-		        memcpy (&f1, data, sizeof(format1_label_t));
-			put_dev_sector(sect2);
-		}
-		
-		while (f1.DS1FMTID == _ascebc['1']) {
+		// add_gd_partition(hd, first_part_minor - 1, 0, size);
+		add_gd_partition(hd, first_part_minor,
+				 offset*(blocksize >> 9),
+				 size-offset*(blocksize >> 9));
+	} else if (strncmp(type, "VOL1", 4) == 0) {
+		/*
+		 * New style VOL1 labeled disk
+		 */
+		unsigned int blk;
+		int counter;
+
+		printk("VOL1/%8s:", name);
+
+		/* get block number and read then go through format1 labels */
+		blk = cchhb2blk(&vlabel->vtoc, geo) + 1;
+		counter = 0;
+		while ((data = read_dev_sector(bdev, blk*(blocksize/512),
+					       &sect)) != NULL) {
+			format1_label_t f1;
+
+			memcpy(&f1, data, sizeof(format1_label_t));
+			put_dev_sector(sect);
+
+			/* skip FMT4 / FMT5 / FMT7 labels */
+			if (f1.DS1FMTID == _ascebc['4']
+			    || f1.DS1FMTID == _ascebc['5']
+			    || f1.DS1FMTID == _ascebc['7']) {
+			        blk++;
+				continue;
+			}
+
+			/* only FMT1 valid at this point */
+			if (f1.DS1FMTID != _ascebc['1'])
+				break;
+
+			/* OK, we got valid partition data */
 		        offset = cchh2blk(&f1.DS1EXT1.llimit, geo);
-			psize  = cchh2blk(&f1.DS1EXT1.ulimit, geo) - 
+			size  = cchh2blk(&f1.DS1EXT1.ulimit, geo) - 
 				offset + geo->sectors;
-			
+			if (counter >= (1 << hd->minor_shift))
+				break;
+			add_gd_partition(hd, first_part_minor + counter, 
+					 offset * (blocksize >> 9),
+					 size * (blocksize >> 9));
 			counter++;
-			add_gd_partition(hd, MINOR(dev) + counter, 
-					 offset * blocksize,
-					 psize * blocksize);
-			
 			blk++;
-			data = read_dev_sector(bdev, blk * blocksize, &sect2);
-			if (data) {
-			        memcpy (&f1, data, sizeof(format1_label_t));
-				put_dev_sector(sect2);
-			}
 		}
-		break;
-	default:
-		add_gd_partition( hd, MINOR(dev), 0, 0);
-		add_gd_partition( hd, MINOR(dev) + 1, 0, 0);
+	} else {
+		/*
+		 * Old style LNX1 or unlabeled disk
+		 */
+		if (strncmp(type, "LNX1", 4) == 0)
+			printk ("LNX1/%8s:", name);
+		else
+			printk("(nonl)/%8s:", name);
+		offset = (info->label_block + 1);
+		size = (bdev->bd_inode->i_size >> 9);
+		// add_gd_partition(hd, first_part_minor - 1, 0, size);
+		add_gd_partition(hd, first_part_minor,
+				 offset*(blocksize >> 9),
+				 size-offset*(blocksize >> 9));
 	}
-	
-	printk ( "\n" );
-	put_dev_sector(sect);
+
+	printk("\n");
+	kfree(vlabel);
+	kfree(geo);
+	kfree(info);
 	return 1;
+	
+out_readerr:
+out_badsect:
+out_noioctl:
+	kfree(vlabel);
+out_novlab:
+	kfree(geo);
+out_nogeo:
+	kfree(info);
+out_noinfo:
+	return 0;
 }
