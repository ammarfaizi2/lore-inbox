Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281069AbRKVIlz>; Thu, 22 Nov 2001 03:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281064AbRKVIlo>; Thu, 22 Nov 2001 03:41:44 -0500
Received: from codepoet.org ([166.70.14.212]:23922 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S281069AbRKVIlc>;
	Thu, 22 Nov 2001 03:41:32 -0500
Date: Thu, 22 Nov 2001 01:41:31 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix SCSI non-blocksize reads
Message-ID: <20011122014131.A16981@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111212241430.1038-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111212241430.1038-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 21, 2001 at 10:44:30PM -0800, Linus Torvalds wrote:
> 
> David Mosberger noticed that SCHED_FIFO has been broken for a while, and
> obviously very few people really cared, but it should be fixed now.
> 
> The USB update that I had originally documented as being part of pre8 was
> actually in my in-file, and is _really_ there in pre9, along with a bonus
> usbnet update.
> 
> I think I'm ready to hand this over to Marcelo.

Several SCSI drivers blindly do reads of size 1024 when trying to read
the partition table.   This fails on Magneto Optical drives and similar
odd devices with 2048 byte native sector sizes.  This patch fixes that
so I can have partitions on my MO drive again (it lives on an Adaptec 
card at present and has 2048 byte sectors),

Please apply,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


diff -urN linux/drivers/scsi.orig/BusLogic.c linux/drivers/scsi/BusLogic.c
--- linux/drivers/scsi.orig/BusLogic.c	Sun Sep 30 13:26:07 2001
+++ linux/drivers/scsi/BusLogic.c	Thu Nov 22 01:32:56 2001
@@ -4103,10 +4103,16 @@
 int BusLogic_BIOSDiskParameters(SCSI_Disk_T *Disk, KernelDevice_T Device,
 				int *Parameters)
 {
-  BusLogic_HostAdapter_T *HostAdapter =
-    (BusLogic_HostAdapter_T *) Disk->device->host->hostdata;
+  BusLogic_HostAdapter_T *HostAdapter = (BusLogic_HostAdapter_T *) Disk->device->host->hostdata;
   BIOS_DiskParameters_T *DiskParameters = (BIOS_DiskParameters_T *) Parameters;
   struct buffer_head *BufferHead;
+  int ma = MAJOR(Device);
+  int mi = (MINOR(Device) & ~0xf);
+  int block = 1024; 
+
+  if(blksize_size[ma])
+      block = blksize_size[ma][mi];
+
   if (HostAdapter->ExtendedTranslationEnabled &&
       Disk->capacity >= 2*1024*1024 /* 1 GB in 512 byte sectors */)
     {
@@ -4131,8 +4137,9 @@
   /*
     Attempt to read the first 1024 bytes from the disk device.
   */
-  BufferHead = bread(MKDEV(MAJOR(Device), MINOR(Device) & ~0x0F), 0, 1024);
-  if (BufferHead == NULL) return 0;
+  if (!(BufferHead = bread(MKDEV(ma,mi), 0, block)))
+      return 0;
+
   /*
     If the boot sector partition table flag is valid, search for a partition
     table entry whose end_head matches one of the standard BusLogic geometry
diff -urN linux/drivers/scsi.orig/aic7xxx/aic7xxx_linux.c linux/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linux/drivers/scsi.orig/aic7xxx/aic7xxx_linux.c	Thu Oct 25 14:53:49 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Thu Nov 22 01:29:02 2001
@@ -2740,13 +2740,17 @@
 	int	extended;
 	struct	ahc_softc *ahc;
 	struct	buffer_head *bh;
-
+	int ma = MAJOR(dev);
+	int mi = (MINOR(dev) & ~0xf);
+	int block = 1024; 
 	ahc = *((struct ahc_softc **)disk->device->host->hostdata);
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, 1024);
 
+	if(blksize_size[ma])
+		block = blksize_size[ma][mi];
+		
+	bh = bread(MKDEV(ma,mi), 0, block);
 	if (bh) {
-		ret = scsi_partsize(bh, disk->capacity,
-				    &geom[2], &geom[0], &geom[1]);
+		ret = scsi_partsize(bh, disk->capacity, &geom[2], &geom[0], &geom[1]);
 		brelse(bh);
 		if (ret != -1)
 			return (ret);
diff -urN linux/drivers/scsi.orig/aic7xxx_old.c linux/drivers/scsi/aic7xxx_old.c
--- linux/drivers/scsi.orig/aic7xxx_old.c	Thu Oct 11 10:43:30 2001
+++ linux/drivers/scsi/aic7xxx_old.c	Thu Nov 22 01:30:24 2001
@@ -11737,10 +11737,15 @@
   int heads, sectors, cylinders, ret;
   struct aic7xxx_host *p;
   struct buffer_head *bh;
-
+  int ma = MAJOR(dev);
+  int mi = (MINOR(dev) & ~0xf);
+  int block = 1024; 
   p = (struct aic7xxx_host *) disk->device->host->hostdata;
-  bh = bread(MKDEV(MAJOR(dev), MINOR(dev)&~0xf), 0, 1024);
 
+  if(blksize_size[ma])
+      block = blksize_size[ma][mi];
+
+  bh = bread(MKDEV(ma,mi), 0, block);
   if ( bh )
   {
     ret = scsi_partsize(bh, disk->capacity, &geom[2], &geom[0], &geom[1]);
diff -urN linux/drivers/scsi.orig/tmscsim.c linux/drivers/scsi/tmscsim.c
--- linux/drivers/scsi.orig/tmscsim.c	Sun Sep 30 13:26:08 2001
+++ linux/drivers/scsi/tmscsim.c	Thu Nov 22 01:31:56 2001
@@ -1449,8 +1449,15 @@
     struct buffer_head *bh;
     int ret_code = -1;
     int size = disk->capacity;
+    int ma = MAJOR(devno);
+    int mi = (MINOR(devno) & ~0xf);
+    int block = 1024; 
 
-    if ((bh = bread(MKDEV(MAJOR(devno), MINOR(devno)&~0xf), 0, 1024)))
+    if(blksize_size[ma])
+	block = blksize_size[ma][mi];
+
+    bh = bread(MKDEV(ma,mi), 0, block);
+    if (bh)
     {
 	/* try to infer mapping from partition table */
 	ret_code = partsize (bh, (unsigned long) size, (unsigned int *) geom + 2,
