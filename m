Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281202AbRKLXps>; Mon, 12 Nov 2001 18:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281213AbRKLXpb>; Mon, 12 Nov 2001 18:45:31 -0500
Received: from jalon.able.es ([212.97.163.2]:57072 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281202AbRKLXpW>;
	Mon, 12 Nov 2001 18:45:22 -0500
Date: Tue, 13 Nov 2001 00:45:15 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113004515.E1531@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 20:01:56 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011112 Linus Torvalds wrote:
>
>Ok, this kernel hopefully contains all the high-priority merges with Alan,
>which means that as far as that is concerned, I'm done with 2.4.x and
>ready to pass it on to Marcelo.
>
>Which means that I'd also like people to double-check that there are no
>embarrassing missing pieces due to the merge (or other patches).
>

Many time ago, this was posted in the list as a cleanup-dead-code-removal. Is
still valid for 2.4.15 ?

--- linux/drivers/scsi/tmscsim.c	Fri Apr 27 23:07:19 2001
+++ linux/drivers/scsi/tmscsim.c	Wed Jul  4 02:51:48 2001
@@ -1352,84 +1352,7 @@
     return(0);
 }
 
-/* We ignore mapping problems, as we expect everybody to respect 
- * valid partition tables. Waiting for complaints ;-) */
-
 #ifdef CONFIG_SCSI_DC390T_TRADMAP
-/* 
- * The next function, partsize(), is copied from scsicam.c.
- *
- * This is ugly code duplication, but I didn't find another way to solve it:
- * We want to respect the partition table and if it fails, we apply the 
- * DC390 BIOS heuristic. Too bad, just calling scsicam_bios_param() doesn't do
- * the job, because we don't know, whether the values returned are from
- * the part. table or determined by setsize(). Unfortunately the setsize() 
- * values differ from the ones chosen by the DC390 BIOS.
- *
- * Looking forward to seeing suggestions for a better solution! KG, 98/10/14
- */
-#include <asm/unaligned.h>
-
-/*
- * Function : static int partsize(struct buffer_head *bh, unsigned long 
- *     capacity,unsigned int *cyls, unsigned int *hds, unsigned int *secs);
- *
- * Purpose : to determine the BIOS mapping used to create the partition
- *	table, storing the results in *cyls, *hds, and *secs 
- *
- * Returns : -1 on failure, 0 on success.
- *
- */
-
-static int partsize(struct buffer_head *bh, unsigned long capacity,
-    unsigned int  *cyls, unsigned int *hds, unsigned int *secs) {
-    struct partition *p, *largest = NULL;
-    int i, largest_cyl;
-    int cyl, ext_cyl, end_head, end_cyl, end_sector;
-    unsigned int logical_end, physical_end, ext_physical_end;
-    
-
-    if (*(unsigned short *) (bh->b_data+510) == 0xAA55) {
-	for (largest_cyl = -1, p = (struct partition *) 
-    	    (0x1BE + bh->b_data), i = 0; i < 4; ++i, ++p) {
-    	    if (!p->sys_ind)
-    	    	continue;
-    	    cyl = p->cyl + ((p->sector & 0xc0) << 2);
-    	    if (cyl > largest_cyl) {
-    	    	largest_cyl = cyl;
-    	    	largest = p;
-    	    }
-    	}
-    }
-
-    if (largest) {
-    	end_cyl = largest->end_cyl + ((largest->end_sector & 0xc0) << 2);
-    	end_head = largest->end_head;
-    	end_sector = largest->end_sector & 0x3f;
-
-    	physical_end =  end_cyl * (end_head + 1) * end_sector +
-    	    end_head * end_sector + end_sector;
-
-	/* This is the actual _sector_ number at the end */
-	logical_end = get_unaligned(&largest->start_sect)
-			+ get_unaligned(&largest->nr_sects);
-
-	/* This is for >1023 cylinders */
-        ext_cyl= (logical_end-(end_head * end_sector + end_sector))
-                                        /(end_head + 1) / end_sector;
-	ext_physical_end = ext_cyl * (end_head + 1) * end_sector +
-            end_head * end_sector + end_sector;
-
-    	if ((logical_end == physical_end) ||
-	    (end_cyl==1023 && ext_physical_end==logical_end)) {
-    	    *secs = end_sector;
-    	    *hds = end_head + 1;
-    	    *cyls = capacity / ((end_head + 1) * end_sector);
-    	    return 0;
-    	}
-    }
-    return -1;
-}
 
 /***********************************************************************
  * Function:
@@ -1442,46 +1365,38 @@
  * Note:
  *   In contrary to other externally callable funcs (DC390_), we don't lock
  ***********************************************************************/
-int DC390_bios_param (Disk *disk, kdev_t devno, int geom[])
+int DC390_bios_param (Disk *disk, kdev_t dev, int *geom)
 {
     int heads, sectors, cylinders;
-    PACB pACB = (PACB) disk->device->host->hostdata;
-    struct buffer_head *bh;
-    int ret_code = -1;
-    int size = disk->capacity;
-
-    if ((bh = bread(MKDEV(MAJOR(devno), MINOR(devno)&~0xf), 0, 1024)))
-    {
-	/* try to infer mapping from partition table */
-	ret_code = partsize (bh, (unsigned long) size, (unsigned int *) geom + 2,
-			     (unsigned int *) geom + 0, (unsigned int *) geom + 1);
-	brelse (bh);
-    }
-    if (ret_code == -1)
-    {
-	heads = 64;
-	sectors = 32;
-	cylinders = size / (heads * sectors);
-
-	if ( (pACB->Gmode2 & GREATER_1G) && (cylinders > 1024) )
-	{
-		heads = 255;
-		sectors = 63;
-		cylinders = size / (heads * sectors);
-	}
-
-	geom[0] = heads;
-	geom[1] = sectors;
-	geom[2] = cylinders;
+    PACB pACB;
+    unsigned long size = disk->capacity;
+
+    if (scsi_bios_param_from_MBR(dev, size, geom) == 0)
+	    return 0;
+
+    heads = 64;
+    sectors = 32;
+    cylinders = size / (heads * sectors);
+
+    pACB = (PACB) disk->device->host->hostdata;
+
+    if ( (pACB->Gmode2 & GREATER_1G) && (cylinders > 1024) ) {
+	    heads = 255;
+	    sectors = 63;
+	    cylinders = size / (heads * sectors);
     }
 
-    return (0);
+    geom[0] = heads;
+    geom[1] = sectors;
+    geom[2] = cylinders;
+
+    return 0;
 }
 #else
-int DC390_bios_param (Disk *disk, kdev_t devno, int geom[])
+int DC390_bios_param (Disk *disk, kdev_t dev, int *geom)
 {
-    return scsicam_bios_param (disk, devno, geom);
-};
+    return scsicam_bios_param (disk, dev, geom);
+}
 #endif
 
 
--- linux/drivers/scsi/BusLogic.c	Sun Nov 12 04:01:11 2000
+++ linux/drivers/scsi/BusLogic.c	Wed Jul  4 02:51:48 2001
@@ -4131,7 +4131,7 @@
   /*
     Attempt to read the first 1024 bytes from the disk device.
   */
-  BufferHead = bread(MKDEV(MAJOR(Device), MINOR(Device) & ~0x0F), 0, 1024);
+  BufferHead = scsi_get_block_zero(Device);
   if (BufferHead == NULL) return 0;
   /*
     If the boot sector partition table flag is valid, search for a partition
--- linux/drivers/scsi/aic7xxx_old.c	Tue Jul  3 20:41:38 2001
+++ linux/drivers/scsi/aic7xxx_old.c	Wed Jul  4 02:51:48 2001
@@ -11732,29 +11732,21 @@
  *   Return the disk geometry for the given SCSI device.
  *-F*************************************************************************/
 int
-aic7xxx_biosparam(Disk *disk, kdev_t dev, int geom[])
+aic7xxx_biosparam(Disk *disk, kdev_t dev, int *geom)
 {
-  int heads, sectors, cylinders, ret;
+  int heads, sectors, cylinders;
   struct aic7xxx_host *p;
-  struct buffer_head *bh;
 
-  p = (struct aic7xxx_host *) disk->device->host->hostdata;
-  bh = bread(MKDEV(MAJOR(dev), MINOR(dev)&~0xf), 0, 1024);
-
-  if ( bh )
-  {
-    ret = scsi_partsize(bh, disk->capacity, &geom[2], &geom[0], &geom[1]);
-    brelse(bh);
-    if ( ret != -1 )
-      return(ret);
-  }
+  if (scsi_bios_param_from_MBR(dev, disk->capacity, geom) == 0)
+	  return 0;
   
   heads = 64;
   sectors = 32;
   cylinders = disk->capacity / (heads * sectors);
 
-  if ((p->flags & AHC_EXTEND_TRANS_A) && (cylinders > 1024))
-  {
+  p = (struct aic7xxx_host *) disk->device->host->hostdata;
+
+  if ((p->flags & AHC_EXTEND_TRANS_A) && (cylinders > 1024)) {
     heads = 255;
     sectors = 63;
     cylinders = disk->capacity / (heads * sectors);
@@ -11764,7 +11764,7 @@
   geom[1] = sectors;
   geom[2] = cylinders;
 
-  return (0);
+  return 0;
 }
 
 /*+F*************************************************************************
--- linux/drivers/scsi/scsi.h	Sat May 26 03:02:21 2001
+++ linux/drivers/scsi/scsi.h	Wed Jul  4 02:39:42 2001
@@ -443,9 +443,11 @@
 /*
  * Prototypes for functions in scsicam.c
  */
-extern int  scsi_partsize(struct buffer_head *bh, unsigned long capacity,
-                    unsigned int *cyls, unsigned int *hds,
-                    unsigned int *secs);
+extern struct buffer_head *scsi_get_block_zero(kdev_t dev);
+extern int scsi_bios_param_from_MBR(kdev_t dev, unsigned long size, int *ip);
+extern int scsi_partsize(struct buffer_head *bh, unsigned long capacity,
+			 unsigned int *cyls, unsigned int *hds,
+			 unsigned int *secs);
 
 /*
  * Prototypes for functions in scsi_dma.c
--- linux/drivers/scsi/scsicam.c	Fri Nov 19 04:09:14 1999
+++ linux/drivers/scsi/scsicam.c	Wed Jul  4 02:51:48 2001
@@ -23,60 +23,73 @@
 #include "sd.h"
 #include <scsi/scsicam.h>
 
-static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds,
-		   unsigned int *secs);
+static int setsize(unsigned long capacity, unsigned int *cyls,
+		   unsigned int *hds, unsigned int *secs);
 
+struct buffer_head *
+scsi_get_block_zero(kdev_t dev) {
+	int ma, mi, block;
+
+	ma = MAJOR(dev);
+	mi = (MINOR(dev) & ~0xf);
+
+	block = 1024; 
+	if(blksize_size[ma])
+		block = blksize_size[ma][mi];
+		
+	return bread(MKDEV(ma,mi), 0, block);
+}
 
 /*
- * Function : int scsicam_bios_param (Disk *disk, int dev, int *ip)
+ * Return: 0: OK
+ *        -1: cannot determine geometry
+ *        -2: cannot read disk
+ */
+#define DISK_READ_ERROR	(-2)
+
+int
+scsi_bios_param_from_MBR(kdev_t dev, unsigned long size, int *ip) {
+	int rc = DISK_READ_ERROR;
+	struct buffer_head *bh;
+
+	bh = scsi_get_block_zero(dev);
+	if (bh) {
+		rc = scsi_partsize(bh, size, ip + 2, ip + 0, ip + 1);
+		brelse(bh);
+	}
+	return rc;
+}
+
+/*
+ * Function : int scsicam_bios_param (Disk *disk, kdev_t dev, int *ip)
  *
  * Purpose : to determine the BIOS mapping used for a drive in a 
  *      SCSI-CAM system, storing the results in ip as required
  *      by the HDIO_GETGEO ioctl().
  *
- * Returns : -1 on failure, 0 on success.
- *
+ * Returns : -1 on failure (cannot read MBR), 0 on success
  */
 
-int scsicam_bios_param(Disk * disk,	/* SCSI disk */
-		       kdev_t dev,	/* Device major, minor */
-		  int *ip /* Heads, sectors, cylinders in that order */ )
+int scsicam_bios_param(Disk *disk, kdev_t dev,
+		       int *ip /* heads, sectors, cylinders in that order */ )
 {
-	struct buffer_head *bh;
-	int ret_code;
-	int size = disk->capacity;
-	unsigned long temp_cyl;
-
-	int ma = MAJOR(dev);
-	int mi = (MINOR(dev) & ~0xf);
-
-	int block = 1024; 
+	int rc;
+	unsigned long size = disk->capacity;
 
-	if(blksize_size[ma])
-		block = blksize_size[ma][mi];
-		
-	if (!(bh = bread(MKDEV(ma,mi), 0, block)))
+	rc = scsi_bios_param_from_MBR(dev, size, ip);
+	if (rc == DISK_READ_ERROR)
 		return -1;
 
-	/* try to infer mapping from partition table */
-	ret_code = scsi_partsize(bh, (unsigned long) size, (unsigned int *) ip + 2,
-		       (unsigned int *) ip + 0, (unsigned int *) ip + 1);
-	brelse(bh);
-
-	if (ret_code == -1) {
-		/* pick some standard mapping with at most 1024 cylinders,
-		   and at most 62 sectors per track - this works up to
-		   7905 MB */
-		ret_code = setsize((unsigned long) size, (unsigned int *) ip + 2,
-		       (unsigned int *) ip + 0, (unsigned int *) ip + 1);
-	}
+	/* pick some standard mapping with at most 1024 cylinders,
+	   and at most 62 sectors per track - this works up to 7905 MB */
+	rc = setsize(size, ip + 2, ip + 0, ip + 1);
+
 	/* if something went wrong, then apparently we have to return
 	   a geometry with more than 1024 cylinders */
-	if (ret_code || ip[0] > 255 || ip[1] > 63) {
+	if (rc || ip[0] > 255 || ip[1] > 63) {
 		ip[0] = 64;
 		ip[1] = 32;
-		temp_cyl = size / (ip[0] * ip[1]);
-		if (temp_cyl > 65534) {
+		if (size / (64 * 32) > 65534) {
 			ip[0] = 255;
 			ip[1] = 63;
 		}
@@ -110,10 +123,6 @@
 		     (0x1BE + bh->b_data), i = 0; i < 4; ++i, ++p) {
 			if (!p->sys_ind)
 				continue;
-#ifdef DEBUG
-			printk("scsicam_bios_param : partition %d has system \n",
-			       i);
-#endif
 			cyl = p->cyl + ((p->sector & 0xc0) << 2);
 			if (cyl > largest_cyl) {
 				largest_cyl = cyl;
@@ -128,11 +137,6 @@
 
 		if (end_head + 1 == 0 || end_sector == 0)
 			return -1;
-
-#ifdef DEBUG
-		printk("scsicam_bios_param : end at h = %d, c = %d, s = %d\n",
-		       end_head, end_cyl, end_sector);
-#endif
 
 		physical_end = end_cyl * (end_head + 1) * end_sector +
 		    end_head * end_sector + end_sector;

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre3-beo #1 SMP Mon Nov 12 00:04:41 CET 2001 i686
