Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTFQQ6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTFQQ6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:58:42 -0400
Received: from imap.gmx.net ([213.165.64.20]:7873 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264850AbTFQQ6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:58:21 -0400
Message-ID: <3EEF4BE9.4030904@gmx.at>
Date: Tue, 17 Jun 2003 19:12:09 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hptraid v0.02 raid 0+1 support
References: <3EEE04AC.9040802@gmx.at>
Content-Type: multipart/mixed;
 boundary="------------060305050100040201040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305050100040201040806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attachment was missing :/

Wilfried Weissmann wrote:
 > Hello,
 >
 > This release fixes some bugs and adds support for raid 0+1. I have also
 > done some minor code clean-ups.
 >
 > Changelog since 0.01-ww1:
 > =========================
 > * correct values of raid-1 superbock
 > * check for availability of all disks
 > * fixup for raid-1 disknumbering
 > * do _NOT_ align size to 255*63 boundary
 > * raid 0+1 support
 > * bump version number
 > * release no more devices than available on unload
 > * remove static variables in raid-1 read path
 >
 > Notes:
 > ======
 > I raid 1 and raid 0+1 does not provide support for redundancy. It just
 > adds a compatibility layer to support the HPT37X raid volumes.
 > As far as I can tell, the new raid 0+1 implementation of the HPT374
 > (BIOS 3.X) is not supported. The same controller also has raid 5. But
 > due to lack of hardware I cannot implement these (Unless I can persuade
 > a friend of mine to trash his windows installation.).
 >
 > Any comments are welcome...
 >
 > Bye,
 > Wilfried
 >


--------------060305050100040201040806
Content-Type: text/plain;
 name="hptraid-0.02.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hptraid-0.02.patch"

Index: linux/drivers/ide/raid/hptraid.c
===================================================================
RCS file: /home/rayn/src/cvsroot/linux/drivers/ide/raid/Attic/hptraid.c,v
retrieving revision 1.1.2.2
retrieving revision 1.1.2.1.6.11
diff -u -p -r1.1.2.2 -r1.1.2.1.6.11
--- linux/drivers/ide/raid/hptraid.c	13 Jun 2003 20:40:31 -0000	1.1.2.2
+++ linux/drivers/ide/raid/hptraid.c	15 Jun 2003 18:22:42 -0000	1.1.2.1.6.11
@@ -17,7 +17,30 @@
 	Copyright (C) 1994-96 Marc ZYNGIER <zyngier@ufr-info-p7.ibp.fr>
    Based on work done by Søren Schmidt for FreeBSD
 
-   
+   Changelog:
+   15.06.2003 wweissmann@gmx.at
+   	* correct values of raid-1 superbock
+	* re-add check for availability of all disks
+	* fix offset bug in raid-1 (introduced in raid 0+1 implementation)
+
+   14.06.2003 wweissmann@gmx.at
+   	* superblock has wrong "disks" value on raid-1
+   	* fixup for raid-1 disknumbering
+	* do _NOT_ align size to 255*63 boundary
+		I WILL NOT USE FDISK TO DETERMINE THE VOLUME SIZE.
+		I WILL NOT USE FDISK TO DETERMINE THE VOLUME SIZE.
+		I WILL NOT USE FDISK TO DETERMINE THE VOLUME SIZE.
+		I WILL NOT ...
+
+   13.06.2003 wweissmann@gmx.at
+   	* raid 0+1 support
+	* check if all disks of an array are available
+	* bump version number
+
+   29.05.2003 wweissmann@gmx.at
+   	* release no more devices than available on unload
+	* remove static variables in raid-1 read path
+
 */
 
 #include <linux/module.h>
@@ -34,6 +57,8 @@
 #include <asm/uaccess.h>
 
 #include "ataraid.h"
+#include "hptraid.h"
+
 
 static int hptraid_open(struct inode * inode, struct file * filp);
 static int hptraid_release(struct inode * inode, struct file * filp);
@@ -41,26 +66,30 @@ static int hptraid_ioctl(struct inode *i
 static int hptraidspan_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
 static int hptraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
 static int hptraid1_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
+static int hptraid01_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
 
 
 
 struct hptdisk {
-	kdev_t	device;
+	kdev_t	device;		/* disk-ID/raid 0+1 volume-ID */
 	unsigned long sectors;
 	struct block_device *bdev;
 	unsigned long last_pos;
 };
 
 struct hptraid {
-	unsigned int stride;
-	unsigned int disks;
-	unsigned long sectors;
+	unsigned int stride;	/* stripesize */
+	unsigned int disks;	/* number of disks in array */
+	unsigned long sectors;	/* disksize in sectors */
         u_int32_t magic_0;
+        u_int32_t magic_1;
 	struct geom geom;
 	
+	int previous;		/* most recently accessed disk in mirror */
 	struct hptdisk disk[8];
-	unsigned long cutoff[8];
+	unsigned long cutoff[8];	/* raid 0 cutoff */
 	unsigned int cutoff_disks[8];	
+	struct hptraid * raid01;	/* sub arrays for raid 0+1 */
 };
 
 struct hptraid_dev {
@@ -109,9 +138,30 @@ static struct raid_device_operations hpt
 	make_request:		hptraid1_make_request
 };
 
+
+static struct raid_device_operations hptraid01_ops = {
+	open:                   hptraid_open,
+	release:                hptraid_release,
+	ioctl:			hptraid_ioctl,
+	make_request:		hptraid01_make_request
+};
+
+static __init struct {
+	struct raid_device_operations *op;
+	u_int8_t type;
+	char label[8];
+} oplist[] = {
+	{&hptraid0_ops, HPT_T_RAID_0, "RAID 0"},
+	{&hptraid1_ops, HPT_T_RAID_1, "RAID 1"},
+	{&hptraidspan_ops, HPT_T_SPAN, "SPAN"},
+	{&hptraid01_ops, HPT_T_RAID_01_RAID_0, "RAID 0+1"},
+	{0, 0}
+};
+
 static struct hptraid raid[14];
 
-static int hptraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int hptraid_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
 {
 	unsigned int minor;
 	unsigned char val;
@@ -185,7 +235,10 @@ static int hptraidspan_make_request (req
 	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
 	thisraid = &raid[device];
 
-	/* Partitions need adding of the start sector of the partition to the requested sector */
+	/*
+	 * Partitions need adding of the start sector of the partition to the
+	 * requested sector
+	 */
 	
 	rsect += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
 
@@ -216,58 +269,58 @@ static int hptraidspan_make_request (req
 	return 1;
 }
 
-static int hptraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
+static int hptraid0_compute_request (struct hptraid *thisraid,
+		request_queue_t *q,
+		int rw, struct buffer_head * bh)
 {
-	unsigned long rsect;
 	unsigned long rsect_left,rsect_accum = 0;
 	unsigned long block;
 	unsigned int disk=0,real_disk=0;
 	int i;
-	int device;
-	struct hptraid *thisraid;
-
-	rsect = bh->b_rsector;
 
-	/* Ok. We need to modify this sector number to a new disk + new sector number. 
+	/* Ok. We need to modify this sector number to a new disk + new sector
+	 * number. 
 	 * If there are disks of different sizes, this gets tricky. 
 	 * Example with 3 disks (1Gb, 4Gb and 5 GB):
 	 * The first 3 Gb of the "RAID" are evenly spread over the 3 disks.
-	 * Then things get interesting. The next 2Gb (RAID view) are spread across disk 2 and 3
-	 * and the last 1Gb is disk 3 only.
+	 * Then things get interesting. The next 2Gb (RAID view) are spread
+	 * across disk 2 and 3 and the last 1Gb is disk 3 only.
 	 *
-	 * the way this is solved is like this: We have a list of "cutoff" points where everytime
-	 * a disk falls out of the "higher" count, we mark the max sector. So once we pass a cutoff
-	 * point, we have to divide by one less.
+	 * the way this is solved is like this: We have a list of "cutoff"
+	 * points where everytime a disk falls out of the "higher" count, we
+	 * mark the max sector. So once we pass a cutoff point, we have to
+	 * divide by one less.
 	 */
 	
-	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
-	thisraid = &raid[device];
 	if (thisraid->stride==0)
 		thisraid->stride=1;
 
-	/* Partitions need adding of the start sector of the partition to the requested sector */
-	
-	rsect += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
-
-	/* Woops we need to split the request to avoid crossing a stride barrier */
-	if ((rsect/thisraid->stride) != ((rsect+(bh->b_size/512)-1)/thisraid->stride)) {
+	/*
+	 * Woops we need to split the request to avoid crossing a stride
+	 * barrier
+	 */
+	if ((bh->b_rsector/thisraid->stride) !=
+			((bh->b_rsector+(bh->b_size/512)-1)/thisraid->stride)) {
 		return -1;
 	}
 			
-	rsect_left = rsect;
+	rsect_left = bh->b_rsector;;
 	
 	for (i=0;i<8;i++) {
 		if (thisraid->cutoff_disks[i]==0)
 			break;
-		if (rsect > thisraid->cutoff[i]) {
+		if (bh->b_rsector > thisraid->cutoff[i]) {
 			/* we're in the wrong area so far */
 			rsect_left -= thisraid->cutoff[i];
-			rsect_accum += thisraid->cutoff[i]/thisraid->cutoff_disks[i];
+			rsect_accum += thisraid->cutoff[i] /
+				thisraid->cutoff_disks[i];
 		} else {
 			block = rsect_left / thisraid->stride;
 			disk = block % thisraid->cutoff_disks[i];
-			block = (block / thisraid->cutoff_disks[i]) * thisraid->stride;
-			rsect = rsect_accum + (rsect_left % thisraid->stride) + block;
+			block = (block / thisraid->cutoff_disks[i]) *
+				thisraid->stride;
+			bh->b_rsector = rsect_accum +
+				(rsect_left % thisraid->stride) + block;
 			break;
 		}
 	}
@@ -286,7 +339,7 @@ static int hptraid0_make_request (reques
 	
 	/* All but the first disk have a 10 sector offset */
 	if (i>0)
-		rsect+=10;
+		bh->b_rsector+=10;
 		
 	
 	/*
@@ -295,7 +348,6 @@ static int hptraid0_make_request (reques
 	 */
 	 
 	bh->b_rdev = thisraid->disk[disk].device;
-	bh->b_rsector = rsect;
 
 	/*
 	 * Let the main block layer submit the IO and resolve recursion:
@@ -303,12 +355,39 @@ static int hptraid0_make_request (reques
 	return 1;
 }
 
+static int hptraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	unsigned long rsect;
+	int device;
+
+	/*
+	 * save the sector, it must be restored before a request-split
+	 * is performed
+	 */
+	rsect = bh->b_rsector;
+
+	/*
+	 * Partitions need adding of the start sector of the partition to the
+	 * requested sector
+	 */
+	
+	bh->b_rsector += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
+
+	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
+	if( hptraid0_compute_request(raid+device, q, rw, bh) != 1 ) {
+			/* request must be split => restore sector */
+		bh->b_rsector = rsect;
+		return -1;
+	}
+
+	return 1;
+}
+
 static int hptraid1_read_request (request_queue_t *q, int rw, struct buffer_head * bh)
 {
 	int device;
 	int dist;
 	int bestsofar,bestdist,i;
-	static int previous;
 
 	/* Reads are simple in principle. Pick a disk and go. 
 	   Initially I cheat by just picking the one which the last known
@@ -331,11 +410,15 @@ static int hptraid1_read_request (reques
 			dist = -dist;
 		if (dist>4095)
 			dist=4095;
-		
-		if (bestdist==dist) {  /* it's a tie; try to do some read balancing */
-			if ((previous>bestsofar)&&(previous<=i))  
+
+		  /* it's a tie; try to do some read balancing */
+		if (bestdist==dist) {
+			if ( (raid[device].previous>bestsofar) &&
+					(raid[device].previous<=i) )  
 				bestsofar = i;
-			previous = (previous + 1) % raid[device].disks;
+			raid[device].previous =
+				(raid[device].previous + 1) %
+				raid[device].disks;
 		} else if (bestdist>dist) {
 			bestdist = dist;
 			bestsofar = i;
@@ -343,7 +426,6 @@ static int hptraid1_read_request (reques
 	
 	}
 	
-	bh->b_rsector += bestsofar?10:0;
 	bh->b_rdev = raid[device].disk[bestsofar].device; 
 	raid[device].disk[bestsofar].last_pos = bh->b_rsector+(bh->b_size>>9);
 
@@ -377,24 +459,49 @@ static int hptraid1_write_request(reques
 		if (!bh1)
 			BUG();
 	
-		/* dupe the bufferhead and update the parts that need to be different */
+		/*
+		 * dupe the bufferhead and update the parts that need to be
+		 * different
+		 */
 		memcpy(bh1, bh, sizeof(*bh));
 		
 		bh1->b_end_io = ataraid_end_request;
 		bh1->b_private = private;
-		bh1->b_rsector += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect+(i==0?0:10); /* partition offset */
+		bh1->b_rsector += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect; /* partition offset */
 		bh1->b_rdev = raid[device].disk[i].device;
 
 		/* update the last known head position for the drive */
 		raid[device].disk[i].last_pos = bh1->b_rsector+(bh1->b_size>>9);
 
+		if( raid[device].raid01 ) {
+			if( hptraid0_compute_request(
+						raid[device].raid01 +
+							(bh1->b_rdev-1),
+						q, rw, bh1) != 1 ) {
+				/*
+				 * If a split is requested then it is requested
+				 * in the first iteration. This is true because
+				 * of the cutoff is not used in raid 0+1.
+				 */
+				if(unlikely(i)) {
+					BUG();
+				}
+				else {
+					kfree(private);
+					return -1;
+				}
+			}
+		}
 		generic_make_request(rw,bh1);
 	}
 	return 0;
 }
 
 static int hptraid1_make_request (request_queue_t *q, int rw, struct buffer_head * bh) {
-	/* Read and Write are totally different cases; split them totally here */
+	/*
+	 * Read and Write are totally different cases; split them totally
+	 * here
+	 */
 	if (rw==READA)
 		rw = READ;
 	
@@ -404,7 +511,43 @@ static int hptraid1_make_request (reques
 		return hptraid1_write_request(q,rw,bh);
 }
 
-#include "hptraid.h"
+static int hptraid01_read_request (request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	int rsector=bh->b_rsector;
+	int rdev=bh->b_rdev;
+
+		/* select mirror volume */
+	hptraid1_read_request(q, rw, bh);
+
+		/* stripe volume is selected by "bh->b_rdev" */
+	if( hptraid0_compute_request(
+				raid[(bh->b_rdev >> SHIFT)&MAJOR_MASK].
+					raid01 + (bh->b_rdev-1) ,
+				q, rw, bh) != 1 ) {
+
+			/* request must be split => restore sector and device */
+		bh->b_rsector = rsector;
+		bh->b_rdev = rdev;
+		return -1;
+
+	}
+
+	return 1;
+}
+
+static int hptraid01_make_request (request_queue_t *q, int rw, struct buffer_head * bh) {
+	/*
+	 * Read and Write are totally different cases; split them totally
+	 * here
+	 */
+	if (rw==READA)
+		rw = READ;
+	
+	if (rw==READ)
+		return hptraid01_read_request(q,rw,bh);
+	else
+		return hptraid1_write_request(q,rw,bh);
+}
 
 static int read_disk_sb (int major, int minor, unsigned char *buffer,int bufsize)
 {
@@ -456,77 +599,140 @@ static unsigned long maxsectors (int maj
 	return lba;
 }
 
-static void __init probedisk(struct hptraid_dev *disk, int device, u_int8_t type)
+static void writeentry(struct hptraid * raid, struct hptraid_dev * disk,
+		int index, struct highpoint_raid_conf * prom) {
+
+	int j=0;
+	struct gendisk *gd;
+	struct block_device *bdev;
+
+	bdev = bdget(MKDEV(disk->major,disk->minor));
+	if (bdev && blkdev_get(bdev,FMODE_READ|FMODE_WRITE,0,BDEV_RAW) == 0) {
+		raid->disk[index].bdev = bdev;
+        	/*
+		 * This is supposed to prevent others from stealing our
+		 * underlying disks now blank the /proc/partitions table for 
+		 * the wrong partition table, so that scripts don't
+		 * accidentally mount it and crash the kernel
+		 */
+		 /* XXX: the 0 is an utter hack  --hch */
+		gd=get_gendisk(MKDEV(disk->major, 0));
+		if (gd!=NULL) {
+ 			if (gd->major==disk->major)
+ 				for (j=1+(disk->minor<<gd->minor_shift);
+					j<((disk->minor+1)<<gd->minor_shift);
+					j++) gd->part[j].nr_sects=0;					
+		}
+        }
+	raid->disk[index].device = MKDEV(disk->major,disk->minor);
+	raid->disk[index].sectors = maxsectors(disk->major,disk->minor);
+	raid->stride = (1<<prom->raid0_shift);
+	raid->disks = prom->raid_disks;
+	raid->sectors = prom->total_secs;
+	raid->sectors += raid->sectors&1?1:0;
+	raid->magic_0=prom->magic_0;
+	raid->magic_1=prom->magic_1;
+
+}
+
+static int probedisk(struct hptraid_dev *disk, int device, u_int8_t type)
 {
-	int i;
+	int i, j;
         struct highpoint_raid_conf *prom;
 	static unsigned char block[4096];
-	struct block_device *bdev;
 	
  	if (disk->device != -1)	/* disk is occupied? */
- 		return;
+ 		return 0;
  
  	if (maxsectors(disk->major,disk->minor)==0)
-		return;
+		return 0;
 	
         if (read_disk_sb(disk->major,disk->minor,(unsigned char*)&block,sizeof(block)))
-        	return;
+        	return 0;
                                                                                                                  
         prom = (struct highpoint_raid_conf*)&block[512];
                 
         if (prom->magic!=  0x5a7816f0)
-        	return;
+        	return 0;
         switch (prom->type) {
 		case HPT_T_SPAN:
 		case HPT_T_RAID_0:
 		case HPT_T_RAID_1:
+		case HPT_T_RAID_01_RAID_0:
 			if(prom->type != type)
-				return;
+				return 0;
 			break;
 		default:
-			printk(KERN_INFO "hptraid: only SPAN, RAID0 and RAID1 is currently supported \n");
-			return;
+			printk(KERN_INFO "hptraid: unknown raid level-id %i\n",
+					prom->type);
+			return 0;
         }
 
  		/* disk from another array? */
- 	if(raid[device].disks && prom->magic_0 != raid[device].magic_0)
- 		return;
+	if (raid[device].disks) {	/* only check if raid is not empty */
+		if (type == HPT_T_RAID_01_RAID_0 ) {
+			if( prom->magic_1 != raid[device].magic_1) {
+				return 0;
+			}
+		}
+		else if (prom->magic_0 != raid[device].magic_0) {
+				return 0;
+		}
+	}
 
 	i = prom->disk_number;
 	if (i<0)
-		return;
+		return 0;
 	if (i>8) 
-		return;
+		return 0;
 
-	bdev = bdget(MKDEV(disk->major,disk->minor));
-	if (bdev && blkdev_get(bdev,FMODE_READ|FMODE_WRITE,0,BDEV_RAW) == 0) {
-        	int j=0;
-        	struct gendisk *gd;
-		raid[device].disk[i].bdev = bdev;
-        	/* This is supposed to prevent others from stealing our underlying disks */
-		/* now blank the /proc/partitions table for the wrong partition table,
-		   so that scripts don't accidentally mount it and crash the kernel */
-		 /* XXX: the 0 is an utter hack  --hch */
-		gd=get_gendisk(MKDEV(disk->major, 0));
-		if (gd!=NULL) {
- 			if (gd->major==disk->major)
- 				for (j=1+(disk->minor<<gd->minor_shift);
-					j<((disk->minor+1)<<gd->minor_shift);
-					j++) gd->part[j].nr_sects=0;					
+	if ( type == HPT_T_RAID_01_RAID_0 ) {
+
+			/* allocate helper raid devices for level 0+1 */
+		if (raid[device].raid01 == NULL ) {
+
+			raid[device].raid01=
+				kmalloc(2 * sizeof(struct hptraid),GFP_KERNEL);
+			if ( raid[device].raid01 == NULL ) {
+				printk(KERN_ERR "hptraid: out of memory\n");
+				raid[device].disks=-1;
+				return -ENOMEM;
+			}
+			memset(raid[device].raid01, 0,
+					2 * sizeof(struct hptraid));
 		}
-        }
-	raid[device].disk[i].device = MKDEV(disk->major,disk->minor);
-	raid[device].disk[i].sectors = maxsectors(disk->major,disk->minor);
-	raid[device].stride = (1<<prom->raid0_shift);
-	raid[device].disks = prom->raid_disks;
-	raid[device].sectors = prom->total_secs-(prom->total_secs%(255*63));
-	raid[device].sectors += raid[device].sectors&1?1:0;
-	raid[device].magic_0=prom->magic_0;
+
+			/* find free sub-stucture */
+		for (j=0; j<2; j++) {
+			if ( raid[device].raid01[j].disks == 0 ||
+			     raid[device].raid01[j].magic_0 == prom->magic_0 )
+			{
+				writeentry(raid[device].raid01+j, disk,
+						i, prom);
+				break;
+			}
+		}
+
+			/* no free slot */
+		if(j == 2)
+			return 0;
+
+		raid[device].stride=raid[device].raid01[j].stride;
+		raid[device].disks=j+1;
+		raid[device].sectors=raid[device].raid01[j].sectors;
+		raid[device].disk[j].sectors=raid[device].raid01[j].sectors;
+		raid[device].magic_1=prom->magic_1;
+	}
+	else {
+		writeentry(raid+device, disk, i, prom);
+	}
+
 	disk->device=device;
 			
+	return 1;
 }
 
-static void __init fill_cutoff(int device)
+static void fill_cutoff(struct hptraid * device)
 {
 	int i,j;
 	unsigned long smallest;
@@ -537,111 +743,154 @@ static void __init fill_cutoff(int devic
 	for (i=0;i<8;i++) {
 		smallest = ~0;
 		for (j=0;j<8;j++) 
-			if ((raid[device].disk[j].sectors < smallest) && (raid[device].disk[j].sectors>bar))
-				smallest = raid[device].disk[j].sectors;
+			if ((device->disk[j].sectors < smallest) && (device->disk[j].sectors>bar))
+				smallest = device->disk[j].sectors;
 		count = 0;
 		for (j=0;j<8;j++) 
-			if (raid[device].disk[j].sectors >= smallest)
+			if (device->disk[j].sectors >= smallest)
 				count++;
 		
 		smallest = smallest * count;		
 		bar = smallest;
-		raid[device].cutoff[i] = smallest;
-		raid[device].cutoff_disks[i] = count;
+		device->cutoff[i] = smallest;
+		device->cutoff_disks[i] = count;
 		
 	}
 }
 
+static int count_disks(struct hptraid * raid) {
+	int i, count=0;
+	for (i=0;i<8;i++) {
+		if (raid->disk[i].device!=0) {
+			printk(KERN_INFO "Drive %i is %li Mb \n",
+				i,raid->disk[i].sectors/2048);
+			count++;
+		}
+	}
+	return count;
+}
+
+static void raid1_fixup(struct hptraid * raid) {
+	int i, count=0;
+	for (i=0;i<8;i++) {
+			/* disknumbers and total disks values are bogus */
+		if (raid->disk[i].device!=0) {
+			raid->disk[count]=raid->disk[i];
+			if(i > count) {
+				memset(raid->disk+i, 0, sizeof(struct hptdisk));
+			}
+			count++;
+		}
+	}
+	raid->disks=count;
+}
 
-static __init int hptraid_init_one(int device, u_int8_t type)
+static int hptraid_init_one(int device, u_int8_t type, const char * label)
 {
 	int i,count;
-
 	memset(raid+device, 0, sizeof(struct hptraid));
-	for(i=0; i < 14; i++) {
-		probedisk(devlist+i, device, type);
+	for (i=0; i < 14; i++) {
+		if( probedisk(devlist+i, device, type) < 0 )
+			return -EINVAL;
+	}
+
+	/* Initialize raid levels */
+	switch (type) {
+		case HPT_T_RAID_0:
+			fill_cutoff(raid+device);
+			break;
+
+		case HPT_T_RAID_1:
+			raid1_fixup(raid+device);
+			break;
+
+		case HPT_T_RAID_01_RAID_0:
+			for(i=0; i < 2 && raid[device].raid01 && 
+					raid[device].raid01[i].disks; i++) {
+				fill_cutoff(raid[device].raid01+i);
+					/* initialize raid 0+1 volumes */
+				raid[device].disk[i].device=i+1;
+			}
+			break;
 	}
 
-	if(type == HPT_T_RAID_0)
-		fill_cutoff(device);
-	
 	/* Initialize the gendisk structure */
 	
 	ataraid_register_disk(device,raid[device].sectors);
 
-	count=0;
+	/* Verify that we have all disks */
+
+	count=count_disks(raid+device);
 		
-	for (i=0;i<8;i++) {
-		if (raid[device].disk[i].device!=0) {
-			printk(KERN_INFO "Drive %i is %li Mb \n",
-				i,raid[device].disk[i].sectors/2048);
-			count++;
-		}
+	if (count != raid[device].disks) {
+		printk(KERN_INFO "%s consists of %i drives but found %i drives\n",
+				label, raid[device].disks, count);
+		return -ENODEV;
 	}
-	if (count) {
-		printk(KERN_INFO "Raid array consists of %i drives. \n",count);
+	else if (count) {
+		printk(KERN_INFO "%s consists of %i drives.\n",
+				label, count);
+		if (type == HPT_T_RAID_01_RAID_0 ) {
+			for(i=0;i<raid[device].disks;i++) {
+				count=count_disks(raid[device].raid01+i);
+				if(count == raid[device].raid01[i].disks) {
+					printk(KERN_ERR "Sub-Raid %i array consists of %i drives.\n",
+							i, count);
+				}
+				else {
+					printk(KERN_ERR "Sub-Raid %i array consists of %i drives but found %i disk members.\n",
+							i, raid[device].raid01[i].disks,
+							count);
+					return -ENODEV;
+				}
+			}
+		}
 		return 0;
-	} else {
-		printk(KERN_INFO "No raid array found\n");
-		return -ENODEV;
 	}
 	
+	return -ENODEV; /* No more raid volumes */
 }
 
-static __init int hptraid_init(void)
+static int hptraid_init(void)
 {
- 	int retval,device,count=0;
+ 	int retval=-ENODEV;
+	int device,i,count=0;
   	
-	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.01-ww1\n");
+	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.02\n");
 
- 	do
- 	{
- 		device=ataraid_get_device(&hptraid0_ops);
- 		if (device<0)
- 			return (count?0:-ENODEV);
- 		retval = hptraid_init_one(device, HPT_T_RAID_0);
- 		if (retval)
- 			ataraid_release_device(device);
- 		else
- 			count++;
- 	} while(!retval);
- 	do
- 	{
- 		device=ataraid_get_device(&hptraid1_ops);
- 		if (device<0)
- 			return (count?0:-ENODEV);
- 		retval = hptraid_init_one(device, HPT_T_RAID_1);
- 		if (retval)
- 			ataraid_release_device(device);
- 		else
- 			count++;
- 	} while(!retval);
- 	do
- 	{
- 		device=ataraid_get_device(&hptraidspan_ops);
- 		if (device<0)
- 			return (count?0:-ENODEV);
- 		retval = hptraid_init_one(device, HPT_T_SPAN);
- 		if (retval)
- 			ataraid_release_device(device);
- 		else
- 			count++;
- 	} while(!retval);
+	for(i=0; oplist[i].op; i++) {
+		do
+		{
+			device=ataraid_get_device(oplist[i].op);
+			if (device<0)
+				return (count?0:-ENODEV);
+			retval = hptraid_init_one(device, oplist[i].type,
+					oplist[i].label);
+			if (retval)
+				ataraid_release_device(device);
+			else
+				count++;
+		} while(!retval);
+	}
  	return (count?0:retval);
 }
 
 static void __exit hptraid_exit (void)
 {
 	int i,device;
-	for (device = 0; device<16; device++) {
+	for (device = 0; device<14; device++) {
 		for (i=0;i<8;i++)  {
 			struct block_device *bdev = raid[device].disk[i].bdev;
 			raid[device].disk[i].bdev = NULL;
 			if (bdev)
 				blkdev_put(bdev, BDEV_RAW);
 		}       
-		if (raid[device].sectors)
+		if (raid[device].sectors) {
 			ataraid_release_device(device);
+			if( raid[device].raid01 ) {
+				kfree(raid[device].raid01);
+			}
+		}
 	}
 }
 


--------------060305050100040201040806--


