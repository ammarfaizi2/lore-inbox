Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314503AbSDXA6Y>; Tue, 23 Apr 2002 20:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314510AbSDXA6X>; Tue, 23 Apr 2002 20:58:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48067 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314503AbSDXA6U>; Tue, 23 Apr 2002 20:58:20 -0400
Date: Tue, 23 Apr 2002 20:57:49 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: One more approach to fs/partitions/ibm.c
Message-ID: <20020423205749.A14878@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

the failure of our experiment with check_partitions that did
do_open keeps nagging me like a bad tooth. Here's another
way to word around that problem. Observe that we do have
one backdoor already, so I am not making it any worse than
it was. What do you think?

-- Pete

diff -ur -X dontdiff linux-2.4.19-pre7/drivers/s390/block/dasd.c linux-2.4.19-pre7-390/drivers/s390/block/dasd.c
--- linux-2.4.19-pre7/drivers/s390/block/dasd.c	Mon Feb 25 11:38:03 2002
+++ linux-2.4.19-pre7-390/drivers/s390/block/dasd.c	Tue Apr 23 17:13:57 2002
@@ -4187,6 +4187,7 @@
 		goto failed;
 	}
 	genhd_dasd_name = dasd_device_name;
+	genhd_dasd_ioctl = dasd_ioctl;
 
 	if (dasd_autodetect) {	/* update device range to all devices */
 		for (irq = get_irq_first (); irq != -ENODEV;
@@ -4309,7 +4310,9 @@
 	printk (KERN_INFO PRINTK_HEADER
 		"De-Registered ECKD discipline successfully\n");
 #endif /* CONFIG_DASD_ECKD_BUILTIN */
-        
+
+	genhd_dasd_name = NULL;
+	genhd_dasd_ioctl = NULL;
 	dasd_proc_cleanup ();
         
 	list_for_each_safe (l, n, &dasd_major_info[0].list) {
diff -ur -X dontdiff linux-2.4.19-pre7/drivers/s390/block/dasd_int.h linux-2.4.19-pre7-390/drivers/s390/block/dasd_int.h
--- linux-2.4.19-pre7/drivers/s390/block/dasd_int.h	Tue Apr 23 17:08:36 2002
+++ linux-2.4.19-pre7-390/drivers/s390/block/dasd_int.h	Tue Apr 23 17:21:31 2002
@@ -367,6 +367,8 @@
 
 extern debug_info_t *dasd_debug_area;
 extern int (*genhd_dasd_name) (char *, int, int, struct gendisk *);
+extern int (*genhd_dasd_ioctl) (struct inode *inp, struct file *filp,
+                            unsigned int no, unsigned long data);
 
 #endif /* __KERNEL__ */
 
diff -ur -X dontdiff linux-2.4.19-pre7/fs/partitions/Makefile linux-2.4.19-pre7-390/fs/partitions/Makefile
--- linux-2.4.19-pre7/fs/partitions/Makefile	Tue Apr 23 17:08:48 2002
+++ linux-2.4.19-pre7-390/fs/partitions/Makefile	Tue Apr 23 17:14:26 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := partitions.o
 
-export-objs := check.o ibm.o msdos.o
+export-objs := check.o msdos.o
 
 obj-y := check.o
 
diff -ur -X dontdiff linux-2.4.19-pre7/fs/partitions/check.c linux-2.4.19-pre7-390/fs/partitions/check.c
--- linux-2.4.19-pre7/fs/partitions/check.c	Mon Feb 25 11:38:09 2002
+++ linux-2.4.19-pre7-390/fs/partitions/check.c	Tue Apr 23 17:13:57 2002
@@ -77,13 +77,17 @@
 
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
+			    unsigned int no, unsigned long data);
 EXPORT_SYMBOL(genhd_dasd_name);
+EXPORT_SYMBOL(genhd_dasd_ioctl);
 #endif
 
 /*
diff -ur -X dontdiff linux-2.4.19-pre7/fs/partitions/ibm.c linux-2.4.19-pre7-390/fs/partitions/ibm.c
--- linux-2.4.19-pre7/fs/partitions/ibm.c	Mon Oct  1 20:03:26 2001
+++ linux-2.4.19-pre7-390/fs/partitions/ibm.c	Tue Apr 23 17:40:52 2002
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
@@ -92,119 +52,187 @@
 		ptr->b;
 }
 
+/*
+ * We used to use ioctl_by_bdev in early 2.4, but it broke
+ * between 2.4.9 and 2.4.18 somewhere.
+ */
+extern int (*genhd_dasd_ioctl)(struct inode *inp, struct file *filp,
+                            unsigned int no, unsigned long data);
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
+	if (ibm_ioctl_unopened(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
+	    ibm_ioctl_unopened(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
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
