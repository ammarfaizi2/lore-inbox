Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCOS03>; Fri, 15 Mar 2002 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSCOS0L>; Fri, 15 Mar 2002 13:26:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58503 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293048AbSCOSZ5>; Fri, 15 Mar 2002 13:25:57 -0500
Date: Fri, 15 Mar 2002 13:25:51 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: 2.4.9-pre3 s390 patch for partition code
Message-ID: <20020315132551.B24597@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch that I extracted from a tarball received last week.
It is said to be failed by Marcelo for 2.4.18, but something is
need to fix this.

To that end, I considered pulling ioctls and replacing them with
reads, but it is too much work. So, I talked to Al Viro
and secured his help to have ioctl_by_bdev working at check_part()
time with a proper fix. Before it is available, I suggest we
push the fs/block_dev.c change into 2.4.19-preX as a stop-gap.

The fs/partitions/ibm.c change from the tarball was useful, but
I *STRONGLY* disagree with putting so much crap on the stack.
It may explain why we have so much trouble with stacks on s390:
they are simply overused. I changed the code to allocate structures
properly. This should go in regartless of Al's work on ioctl.

-- Pete

diff -ur -X dontdiff linux-2.4.19-pre3/fs/block_dev.c linux-2.4.19-pre3-390/fs/block_dev.c
--- linux-2.4.19-pre3/fs/block_dev.c	Mon Feb 25 11:38:08 2002
+++ linux-2.4.19-pre3-390/fs/block_dev.c	Tue Mar 12 20:32:04 2002
@@ -530,11 +530,18 @@
 {
 	int res;
 	mm_segment_t old_fs = get_fs();
+	const struct block_device_operations *bd_op;
 
-	if (!bdev->bd_op->ioctl)
+	bd_op = bdev->bd_op;
+	if (bd_op == NULL) {
+		bd_op = blkdevs[MAJOR(to_kdev_t(bdev->bd_dev))].bdops;
+		if (bd_op == NULL)
+			return -EINVAL;
+	}
+	if (!bd_op->ioctl)
 		return -EINVAL;
 	set_fs(KERNEL_DS);
-	res = bdev->bd_op->ioctl(bdev->bd_inode, NULL, cmd, arg);
+	res = bd_op->ioctl(bdev->bd_inode, NULL, cmd, arg);
 	set_fs(old_fs);
 	return res;
 }
diff -ur -X dontdiff linux-2.4.19-pre3/fs/partitions/Makefile linux-2.4.19-pre3-390/fs/partitions/Makefile
--- linux-2.4.19-pre3/fs/partitions/Makefile	Thu Jul 26 16:30:04 2001
+++ linux-2.4.19-pre3-390/fs/partitions/Makefile	Tue Mar 12 15:06:34 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := partitions.o
 
-export-objs := check.o ibm.o
+export-objs := check.o
 
 obj-y := check.o
 
diff -ur -X dontdiff linux-2.4.19-pre3/fs/partitions/ibm.c linux-2.4.19-pre3-390/fs/partitions/ibm.c
--- linux-2.4.19-pre3/fs/partitions/ibm.c	Mon Oct  1 20:03:26 2001
+++ linux-2.4.19-pre3-390/fs/partitions/ibm.c	Tue Mar 12 20:23:30 2002
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
@@ -94,117 +54,150 @@
 
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
-	blocksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
-	if ( blocksize <= 0 ) {
-		return 0;
-	}
-	blocksize >>= 9;
-	
-	data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
-	if (!data)
-		return 0;
-
+	if ((info = kmalloc(sizeof(dasd_information_t), GFP_KERNEL)) == NULL)
+		goto out_noinfo;
+	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
+		goto out_nogeo;
+	if ((vlabel = kmalloc(sizeof(volume_label_t), GFP_KERNEL)) == NULL)
+		goto out_novlab;
+
+	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long) info) != 0 ||
+	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long) geo) != 0)
+		goto out_noioctl;
+
+	if ((blocksize = get_hardsect_size(to_kdev_t(bdev->bd_dev))) <= 0)
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
+
+	EBCASC(type, 4);
+	EBCASC(name, 6);
 
-	EBCASC(type,4);
-	EBCASC(name,6);
-	
-	partition_type = get_partition_type(type);
-	printk ( "%4s/%8s:",part_names[partition_type],name);
-	switch ( partition_type ) {
-	case ibm_partition_cms1:
-		if (* ((long *)data + 13) != 0) {
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
-		}
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
+			size = hd->sizes[first_part_minor - 1] << 1;
 		}
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
+		// add_gd_partition(hd, first_part_minor - 1, 0,
+		// 		 hd->sizes[first_part_minor - 1]<<1);
 		
-		while (f1.DS1FMTID == _ascebc['1']) {
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
+			if (counter >= hd->max_p)
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
+		size = hd->sizes[first_part_minor - 1] << 1;
+		// add_gd_partition(hd, first_part_minor - 1, 0, size);
+		add_gd_partition(hd, first_part_minor,
+				 offset*(blocksize >> 9),
+				  size-offset*(blocksize >> 9));
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
