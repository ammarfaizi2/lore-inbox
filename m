Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTDNUHW (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTDNUHW (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:07:22 -0400
Received: from pop.gmx.de ([213.165.64.20]:33183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263905AbTDNUGx (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:06:53 -0400
Message-ID: <3E9B179A.6050706@gmx.at>
Date: Mon, 14 Apr 2003 22:18:34 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Arjan van de Ven <arjanv@redhat.com>
Subject: HPT370 Raid - SPAN&RAID1 Patch
Content-Type: multipart/mixed;
 boundary="------------020206000703050609070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206000703050609070401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings HPT370 owners,

After I messed up my harddisk I had no more reasons for not doing some 
work on the raid implementation. So here is an update that does the 
disk-spanning and raid1 (sorry, no real redundancy implemented yet, just 
clone of pdcraid1). It also correct the total sector length (round down 
to 1k blocks). The patch applies against linux-2.4.21-pre7. The PCI-ID 
of HPT372N is also added so that HPT[67]X supports compiles. Enjoy...

bye,
Wilfried

--------------020206000703050609070401
Content-Type: text/plain;
 name="linux-2.4.21-pre7-hptraid-0.1-ww1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-pre7-hptraid-0.1-ww1.patch"

Index: linux/drivers/ide/raid/hptraid.c
===================================================================
RCS file: /home/rayn/src/cvsroot/linux/drivers/ide/raid/Attic/hptraid.c,v
retrieving revision 1.1.2.1
retrieving revision 1.1.2.1.6.2
diff -a -u -r1.1.2.1 -r1.1.2.1.6.2
--- linux/drivers/ide/raid/hptraid.c	12 Apr 2003 21:57:31 -0000	1.1.2.1
+++ linux/drivers/ide/raid/hptraid.c	14 Apr 2003 19:37:52 -0000	1.1.2.1.6.2
@@ -38,7 +38,9 @@
 static int hptraid_open(struct inode * inode, struct file * filp);
 static int hptraid_release(struct inode * inode, struct file * filp);
 static int hptraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
-static int hptraid_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
+static int hptraidspan_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
+static int hptraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
+static int hptraid1_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
 
 
 
@@ -46,28 +48,68 @@
 	kdev_t	device;
 	unsigned long sectors;
 	struct block_device *bdev;
+	unsigned long last_pos;
 };
 
 struct hptraid {
 	unsigned int stride;
 	unsigned int disks;
 	unsigned long sectors;
+        u_int32_t magic_0;
 	struct geom geom;
 	
 	struct hptdisk disk[8];
-	
 	unsigned long cutoff[8];
 	unsigned int cutoff_disks[8];	
 };
 
-static struct raid_device_operations hptraid_ops = {
+struct hptraid_dev {
+	int major;
+	int minor;
+	int device;
+};
+
+static struct hptraid_dev devlist[]=
+{
+
+	{IDE0_MAJOR,  0, -1},
+	{IDE0_MAJOR, 64, -1},
+	{IDE1_MAJOR,  0, -1},
+	{IDE1_MAJOR, 64, -1},
+	{IDE2_MAJOR,  0, -1},
+	{IDE2_MAJOR, 64, -1},
+	{IDE3_MAJOR,  0, -1},
+	{IDE3_MAJOR, 64, -1},
+	{IDE4_MAJOR,  0, -1},
+	{IDE4_MAJOR, 64, -1},
+	{IDE5_MAJOR,  0, -1},
+	{IDE5_MAJOR, 64, -1},
+	{IDE6_MAJOR,  0, -1},
+	{IDE6_MAJOR, 64, -1}
+};
+
+static struct raid_device_operations hptraidspan_ops = {
+	open:                   hptraid_open,
+	release:                hptraid_release,
+	ioctl:			hptraid_ioctl,
+	make_request:		hptraidspan_make_request
+};
+
+static struct raid_device_operations hptraid0_ops = {
+	open:                   hptraid_open,
+	release:                hptraid_release,
+	ioctl:			hptraid_ioctl,
+	make_request:		hptraid0_make_request
+};
+
+static struct raid_device_operations hptraid1_ops = {
 	open:                   hptraid_open,
 	release:                hptraid_release,
 	ioctl:			hptraid_ioctl,
-	make_request:		hptraid_make_request
+	make_request:		hptraid1_make_request
 };
 
-static struct hptraid raid[16];
+static struct hptraid raid[14];
 
 static int hptraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -131,7 +173,50 @@
 }
 
 
-static int hptraid_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
+static int hptraidspan_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	unsigned long rsect;
+	unsigned int disk;
+	int device;
+	struct hptraid *thisraid;
+
+	rsect = bh->b_rsector;
+
+	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
+	thisraid = &raid[device];
+
+	/* Partitions need adding of the start sector of the partition to the requested sector */
+	
+	rsect += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
+
+	for (disk=0;disk<thisraid->disks;disk++) {
+		if (disk==1)
+			rsect+=10;
+			// the "on next disk" contition check is a bit odd
+		if (thisraid->disk[disk].sectors > rsect+1)
+			break;
+		rsect-=thisraid->disk[disk].sectors-(disk?11:1);
+	}
+
+		// request spans over 2 disks => request must be split
+	if(rsect+bh->b_size/512 >= thisraid->disk[disk].sectors)
+		return -1;
+	
+	/*
+	 * The new BH_Lock semantics in ll_rw_blk.c guarantee that this
+	 * is the only IO operation happening on this bh.
+	 */
+	 
+	bh->b_rdev = thisraid->disk[disk].device;
+	bh->b_rsector = rsect;
+
+	/*
+	 * Let the main block layer submit the IO and resolve recursion:
+	 */
+	return 1;
+}
+
+static int hptraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
 {
 	unsigned long rsect;
 	unsigned long rsect_left,rsect_accum = 0;
@@ -218,6 +303,106 @@
 	return 1;
 }
 
+static int hptraid1_read_request (request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	int device;
+	int dist;
+	int bestsofar,bestdist,i;
+	static int previous;
+
+	/* Reads are simple in principle. Pick a disk and go. 
+	   Initially I cheat by just picking the one which the last known
+	   head position is closest by.
+	   Later on, online/offline checking and performance needs adding */
+	
+	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
+	bh->b_rsector += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
+
+	bestsofar = 0; 
+	bestdist = raid[device].disk[0].last_pos - bh->b_rsector;
+	if (bestdist<0) 
+		bestdist=-bestdist;
+	if (bestdist>4095)
+		bestdist=4095;
+
+	for (i=1 ; i<raid[device].disks; i++) {
+		dist = raid[device].disk[i].last_pos - bh->b_rsector;
+		if (dist<0) 
+			dist = -dist;
+		if (dist>4095)
+			dist=4095;
+		
+		if (bestdist==dist) {  /* it's a tie; try to do some read balancing */
+			if ((previous>bestsofar)&&(previous<=i))  
+				bestsofar = i;
+			previous = (previous + 1) % raid[device].disks;
+		} else if (bestdist>dist) {
+			bestdist = dist;
+			bestsofar = i;
+		}
+	
+	}
+	
+	bh->b_rsector += bestsofar?10:0;
+	bh->b_rdev = raid[device].disk[bestsofar].device; 
+	raid[device].disk[bestsofar].last_pos = bh->b_rsector+(bh->b_size>>9);
+
+	/*
+	 * Let the main block layer submit the IO and resolve recursion:
+	 */
+                          	
+	return 1;
+}
+
+static int hptraid1_write_request(request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	struct buffer_head *bh1;
+	struct ataraid_bh_private *private;
+	int device;
+	int i;
+
+	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
+	private = ataraid_get_private();
+	if (private==NULL)
+		BUG();
+
+	private->parent = bh;
+	
+	atomic_set(&private->count,raid[device].disks);
+
+
+	for (i = 0; i< raid[device].disks; i++) { 
+		bh1=ataraid_get_bhead();
+		/* If this ever fails we're doomed */
+		if (!bh1)
+			BUG();
+	
+		/* dupe the bufferhead and update the parts that need to be different */
+		memcpy(bh1, bh, sizeof(*bh));
+		
+		bh1->b_end_io = ataraid_end_request;
+		bh1->b_private = private;
+		bh1->b_rsector += ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect+(i==0?0:10); /* partition offset */
+		bh1->b_rdev = raid[device].disk[i].device;
+
+		/* update the last known head position for the drive */
+		raid[device].disk[i].last_pos = bh1->b_rsector+(bh1->b_size>>9);
+
+		generic_make_request(rw,bh1);
+	}
+	return 0;
+}
+
+static int hptraid1_make_request (request_queue_t *q, int rw, struct buffer_head * bh) {
+	/* Read and Write are totally different cases; split them totally here */
+	if (rw==READA)
+		rw = READ;
+	
+	if (rw==READ)
+		return hptraid1_read_request(q,rw,bh);
+	else
+		return hptraid1_write_request(q,rw,bh);
+}
 
 #include "hptraid.h"
 
@@ -271,35 +456,49 @@
 	return lba;
 }
 
-static void __init probedisk(int major, int minor,int device)
+static void __init probedisk(struct hptraid_dev *disk, int device, u_int8_t type)
 {
 	int i;
         struct highpoint_raid_conf *prom;
 	static unsigned char block[4096];
 	struct block_device *bdev;
 	
-	if (maxsectors(major,minor)==0)
+ 	if (disk->device != -1)	/* disk is occupied? */
+ 		return;
+ 
+ 	if (maxsectors(disk->major,disk->minor)==0)
 		return;
 	
-        if (read_disk_sb(major,minor,(unsigned char*)&block,sizeof(block)))
+        if (read_disk_sb(disk->major,disk->minor,(unsigned char*)&block,sizeof(block)))
         	return;
                                                                                                                  
         prom = (struct highpoint_raid_conf*)&block[512];
                 
         if (prom->magic!=  0x5a7816f0)
         	return;
-        if (prom->type) {
-        	printk(KERN_INFO "hptraid: only RAID0 is supported currently\n");
-        	return;
+        switch (prom->type) {
+		case HPT_T_SPAN:
+		case HPT_T_RAID_0:
+		case HPT_T_RAID_1:
+			if(prom->type != type)
+				return;
+			break;
+		default:
+			printk(KERN_INFO "hptraid: only SPAN, RAID0 and RAID1 is currently supported \n");
+			return;
         }
 
+ 		/* disk from another array? */
+ 	if(raid[device].disks && prom->magic_0 != raid[device].magic_0)
+ 		return;
+
 	i = prom->disk_number;
 	if (i<0)
 		return;
 	if (i>8) 
 		return;
 
-	bdev = bdget(MKDEV(major,minor));
+	bdev = bdget(MKDEV(disk->major,disk->minor));
 	if (bdev && blkdev_get(bdev,FMODE_READ|FMODE_WRITE,0,BDEV_RAW) == 0) {
         	int j=0;
         	struct gendisk *gd;
@@ -308,17 +507,22 @@
 		/* now blank the /proc/partitions table for the wrong partition table,
 		   so that scripts don't accidentally mount it and crash the kernel */
 		 /* XXX: the 0 is an utter hack  --hch */
-		gd=get_gendisk(MKDEV(major, 0));
+		gd=get_gendisk(MKDEV(disk->major, 0));
 		if (gd!=NULL) {
-			for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) 
-				gd->part[j].nr_sects=0;					
+ 			if (gd->major==disk->major)
+ 				for (j=1+(disk->minor<<gd->minor_shift);
+					j<((disk->minor+1)<<gd->minor_shift);
+					j++) gd->part[j].nr_sects=0;					
 		}
         }
-	raid[device].disk[i].device = MKDEV(major,minor);
-	raid[device].disk[i].sectors = maxsectors(major,minor);
+	raid[device].disk[i].device = MKDEV(disk->major,disk->minor);
+	raid[device].disk[i].sectors = maxsectors(disk->major,disk->minor);
 	raid[device].stride = (1<<prom->raid0_shift);
 	raid[device].disks = prom->raid_disks;
-	raid[device].sectors = prom->total_secs;
+	raid[device].sectors = prom->total_secs-(prom->total_secs%(255*63));
+	raid[device].sectors += raid[device].sectors&1?1:0;
+	raid[device].magic_0=prom->magic_0;
+	disk->device=device;
 			
 }
 
@@ -349,31 +553,23 @@
 }
 
 
-static __init int hptraid_init_one(int device)
+static __init int hptraid_init_one(int device, u_int8_t type)
 {
 	int i,count;
 
-	probedisk(IDE0_MAJOR,  0, device);
-	probedisk(IDE0_MAJOR, 64, device);
-	probedisk(IDE1_MAJOR,  0, device);
-	probedisk(IDE1_MAJOR, 64, device);
-	probedisk(IDE2_MAJOR,  0, device);
-	probedisk(IDE2_MAJOR, 64, device);
-	probedisk(IDE3_MAJOR,  0, device);
-	probedisk(IDE3_MAJOR, 64, device);
-	probedisk(IDE4_MAJOR,  0, device);
-	probedisk(IDE4_MAJOR, 64, device);
-	probedisk(IDE5_MAJOR,  0, device);
-	probedisk(IDE5_MAJOR, 64, device);
+	memset(raid+device, 0, sizeof(struct hptraid));
+	for(i=0; i < 14; i++) {
+		probedisk(devlist+i, device, type);
+	}
 
-	fill_cutoff(device);
+	if(type == HPT_T_RAID_0)
+		fill_cutoff(device);
 	
 	/* Initialize the gendisk structure */
 	
 	ataraid_register_disk(device,raid[device].sectors);
 
 	count=0;
-	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.01\n");
 		
 	for (i=0;i<8;i++) {
 		if (raid[device].disk[i].device!=0) {
@@ -394,15 +590,44 @@
 
 static __init int hptraid_init(void)
 {
-	int retval,device;
-	
-	device=ataraid_get_device(&hptraid_ops);
-	if (device<0)
-		return -ENODEV;
-	retval = hptraid_init_one(device);
-	if (retval)
-		ataraid_release_device(device);
-	return retval;
+ 	int retval,device,count=0;
+  	
+	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.01-ww1\n");
+
+ 	do
+ 	{
+ 		device=ataraid_get_device(&hptraid0_ops);
+ 		if (device<0)
+ 			return (count?0:-ENODEV);
+ 		retval = hptraid_init_one(device, HPT_T_RAID_0);
+ 		if (retval)
+ 			ataraid_release_device(device);
+ 		else
+ 			count++;
+ 	} while(!retval);
+ 	do
+ 	{
+ 		device=ataraid_get_device(&hptraid1_ops);
+ 		if (device<0)
+ 			return (count?0:-ENODEV);
+ 		retval = hptraid_init_one(device, HPT_T_RAID_1);
+ 		if (retval)
+ 			ataraid_release_device(device);
+ 		else
+ 			count++;
+ 	} while(!retval);
+ 	do
+ 	{
+ 		device=ataraid_get_device(&hptraidspan_ops);
+ 		if (device<0)
+ 			return (count?0:-ENODEV);
+ 		retval = hptraid_init_one(device, HPT_T_SPAN);
+ 		if (retval)
+ 			ataraid_release_device(device);
+ 		else
+ 			count++;
+ 	} while(!retval);
+ 	return (count?0:retval);
 }
 
 static void __exit hptraid_exit (void)
Index: linux/include/linux/pci_ids.h
===================================================================
RCS file: /home/rayn/src/cvsroot/linux/include/linux/pci_ids.h,v
retrieving revision 1.1.1.3
retrieving revision 1.1.1.3.2.1
diff -a -u -r1.1.1.3 -r1.1.1.3.2.1
--- linux/include/linux/pci_ids.h	12 Apr 2003 21:58:17 -0000	1.1.1.3
+++ linux/include/linux/pci_ids.h	13 Apr 2003 20:55:02 -0000	1.1.1.3.2.1
@@ -983,6 +983,7 @@
 #define PCI_DEVICE_ID_TTI_HPT302	0x0006
 #define PCI_DEVICE_ID_TTI_HPT371	0x0007
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009
 
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305

--------------020206000703050609070401--

