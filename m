Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRIHRmd>; Sat, 8 Sep 2001 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271788AbRIHRmY>; Sat, 8 Sep 2001 13:42:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:14583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271787AbRIHRmU>;
	Sat, 8 Sep 2001 13:42:20 -0400
Message-ID: <3B9A588B.EA0762D2@gmx.at>
Date: Sat, 08 Sep 2001 19:42:35 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan van de Ven <arjanv@redhat.com>
Subject: [PATCH] ataraid-hpt370: multiple raid volumes
Content-Type: multipart/mixed;
 boundary="------------6C4E9A2ACDCC2F66A7397FCB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6C4E9A2ACDCC2F66A7397FCB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

Appended is a short patch that allows you to have more than one raid
volume. The same thing should probably be also done to the promise code.
I had no time to check. :(
I just needed this for moveing my data from the wracky IBM DLTA disks to
the new ones. It is a quick hack, but appears to work.

greetings,
Wilfried
--------------6C4E9A2ACDCC2F66A7397FCB
Content-Type: text/plain; charset=us-ascii;
 name="multiple-raid-hpt370.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multiple-raid-hpt370.diff"

diff -Nur linux-2.4.8-ac11/drivers/ide/hptraid.c linux-2.4.8-ac11-raid/drivers/ide/hptraid.c
--- linux-2.4.8-ac11/drivers/ide/hptraid.c	Sun Aug 26 18:32:29 2001
+++ linux-2.4.8-ac11-raid/drivers/ide/hptraid.c	Sat Sep  8 19:32:14 2001
@@ -58,6 +58,25 @@
 	unsigned int cutoff_disks[8];	
 };
 
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
+	{IDE3_MAJOR, 64, -1}
+};
+
 static struct raid_device_operations hptraid_ops = {
 	open:                   hptraid_open,
 	release:                hptraid_release,
@@ -274,16 +293,23 @@
 	return lba;
 }
 
-static void __init probedisk(int major, int minor,int device)
+static u_int32_t magiccookie;
+static char magicpresent;
+static void __init probedisk(struct hptraid_dev *disk, int device)
 {
 	int i;
         struct highpoint_raid_conf *prom;
 	static unsigned char block[4096];
+
+	if (disk->device != -1)	/* disk is occupied? */
+		return;
+
+	printk(KERN_INFO "probeing 0x%.2X%.2X...\n", disk->major, disk->minor);
 	
-	if (maxsectors(major,minor)==0)
+	if (maxsectors(disk->major,disk->minor)==0)
 		return;
 	
-        if (read_disk_sb(major,minor,(unsigned char*)&block,sizeof(block)))
+        if (read_disk_sb(disk->major,disk->minor,(unsigned char*)&block,sizeof(block)))
         	return;
                                                                                                                  
         prom = (struct highpoint_raid_conf*)&block[512];
@@ -295,25 +321,30 @@
         	return;
         }
 
+		/* disk from another array */
+	if(magicpresent && prom->magic_0 != magiccookie)
+		return;
+
 	i = prom->disk_number;
 	if (i<0)
 		return;
 	if (i>8) 
 		return;
 
-	raid[device].disk[i].bdev = bdget(MKDEV(major,minor));
+	raid[device].disk[i].bdev = bdget(MKDEV(disk->major,disk->minor));
         if (raid[device].disk[i].bdev != NULL) {
         	int j=0;
         	struct gendisk *gd;
         	/* This is supposed to prevent others from stealing our underlying disks */
 		blkdev_get(raid[device].disk[i].bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_RAW);
+
 		/* now blank the /proc/partitions table for the wrong partition table,
 		   so that scripts don't accidentally mount it and crash the kernel */
 		lock_kernel();
 		gd=gendisk_head;
 		while (gd!=NULL) {
-			if (gd->major==major) {
-				for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) {
+			if (gd->major==disk->major) {
+				for (j=1+(disk->minor<<gd->minor_shift);j<((disk->minor+1)<<gd->minor_shift);j++) {
 					gd->part[j].nr_sects=0;
 				}
 			}
@@ -322,11 +353,14 @@
 		}
 		unlock_kernel();
         }
-	raid[device].disk[i].device = MKDEV(major,minor);
-	raid[device].disk[i].sectors = maxsectors(major,minor);
+	raid[device].disk[i].device = MKDEV(disk->major,disk->minor);
+	raid[device].disk[i].sectors = maxsectors(disk->major,disk->minor);
 	raid[device].stride = (1<<prom->raid0_shift);
 	raid[device].disks = prom->raid_disks;
 	raid[device].sectors = prom->total_secs;
+	magicpresent=1;
+	magiccookie=prom->magic_0;
+	disk->device=device;
 			
 }
 
@@ -361,14 +395,10 @@
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
+	magicpresent=0;
+	for(i=0; i < 8; i++) {
+		probedisk(devlist+i, device);
+	}
                                                                 	
 	fill_cutoff(device);
 	
@@ -398,15 +428,20 @@
 
 static __init int hptraid_init(void)
 {
-	int retval,device;
+	int retval,device,count=0;
 	
-	device=ataraid_get_device(&hptraid_ops);
-	if (device<0)
-		return -ENODEV;
-	retval = hptraid_init_one(device);
-	if (retval)
-		ataraid_release_device(device);
-	return retval;
+	do
+	{
+		device=ataraid_get_device(&hptraid_ops);
+		if (device<0)
+			return (count?0:-ENODEV);
+		retval = hptraid_init_one(device);
+		if (retval)
+			ataraid_release_device(device);
+		else
+			count++;
+	} while(!retval);
+	return (count?0:retval);
 }
 
 static void __exit hptraid_exit (void)

--------------6C4E9A2ACDCC2F66A7397FCB--

