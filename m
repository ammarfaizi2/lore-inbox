Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282294AbRKXAFS>; Fri, 23 Nov 2001 19:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282297AbRKXAFI>; Fri, 23 Nov 2001 19:05:08 -0500
Received: from codepoet.org ([166.70.14.212]:58919 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S282294AbRKXAEr>;
	Fri, 23 Nov 2001 19:04:47 -0500
Date: Fri, 23 Nov 2001 17:04:46 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] fix SCSI non-blocksize reads
Message-ID: <20011123170446.A18275@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20011122102054.A11961@codepoet.org> <Pine.LNX.4.33.0111221039530.1479-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111221039530.1479-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 22, 2001 at 10:40:14AM -0800, Linus Torvalds wrote:
> 
> On Thu, 22 Nov 2001, Erik Andersen wrote:
> >
> > Would you like a patch that also fixes all the other SCSI drivers
> > to use block_size() then, so they will be consistent?
> 
> Eventually yes, although right now I'd like to have the minimal fix.
> 

Thanks for getting the aic7xx fix into 2.4.125-greased-turkey.
Here is the rest of the SCSI non-blocksize read clean up patch to
fix up the other SCSI drivers so they also do the right thing.  I
think this one easily passes the "obviously correct" test.
Please apply (to 2.4.x and to 2.5.x),

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


diff -urN linux/drivers/scsi.virgin/BusLogic.c linux/drivers/scsi/BusLogic.c
--- linux/drivers/scsi.virgin/BusLogic.c	Sun Sep 30 13:26:07 2001
+++ linux/drivers/scsi/BusLogic.c	Fri Nov 23 16:43:52 2001
@@ -4131,7 +4131,7 @@
   /*
     Attempt to read the first 1024 bytes from the disk device.
   */
-  BufferHead = bread(MKDEV(MAJOR(Device), MINOR(Device) & ~0x0F), 0, 1024);
+  BufferHead = bread(MKDEV(MAJOR(Device), MINOR(Device) & ~0x0F), 0, block_size(Device));
   if (BufferHead == NULL) return 0;
   /*
     If the boot sector partition table flag is valid, search for a partition
diff -urN linux/drivers/scsi.virgin/megaraid.c linux/drivers/scsi/megaraid.c
--- linux/drivers/scsi.virgin/megaraid.c	Thu Oct 25 14:53:51 2001
+++ linux/drivers/scsi/megaraid.c	Fri Nov 23 16:47:08 2001
@@ -4296,15 +4296,7 @@
 	int heads, cyls, sectors;
 	int capacity = disk->capacity;
 
-	int ma = MAJOR(dev);
-	int mi = (MINOR(dev) & ~0xf);
-
-	int block = 1024; 
-
-	if(blksize_size[ma])
-		block = blksize_size[ma][mi];
-		
-	if(!(bh = bread(MKDEV(ma,mi), 0, block)))
+	if(!(bh = bread(MKDEV(MAJOR(dev), MINOR(dev)&~0xf), 0, block_size(dev))))
 		return -1;
 
 	if( *(unsigned short *)(bh->b_data + 510) == 0xAA55 ) {
diff -urN linux/drivers/scsi.virgin/scsicam.c linux/drivers/scsi/scsicam.c
--- linux/drivers/scsi.virgin/scsicam.c	Thu Nov 18 20:09:14 1999
+++ linux/drivers/scsi/scsicam.c	Fri Nov 23 16:47:33 2001
@@ -47,15 +47,7 @@
 	int size = disk->capacity;
 	unsigned long temp_cyl;
 
-	int ma = MAJOR(dev);
-	int mi = (MINOR(dev) & ~0xf);
-
-	int block = 1024; 
-
-	if(blksize_size[ma])
-		block = blksize_size[ma][mi];
-		
-	if (!(bh = bread(MKDEV(ma,mi), 0, block)))
+	if (!(bh = bread(MKDEV(MAJOR(dev), MINOR(dev)&~0xf), 0, block_size(dev))))
 		return -1;
 
 	/* try to infer mapping from partition table */
diff -urN linux/drivers/scsi.virgin/tmscsim.c linux/drivers/scsi/tmscsim.c
--- linux/drivers/scsi.virgin/tmscsim.c	Sun Sep 30 13:26:08 2001
+++ linux/drivers/scsi/tmscsim.c	Fri Nov 23 16:48:28 2001
@@ -1450,7 +1450,7 @@
     int ret_code = -1;
     int size = disk->capacity;
 
-    if ((bh = bread(MKDEV(MAJOR(devno), MINOR(devno)&~0xf), 0, 1024)))
+    if ((bh = bread(MKDEV(MAJOR(devno), MINOR(devno)&~0xf), 0, block_size(devno))))
     {
 	/* try to infer mapping from partition table */
 	ret_code = partsize (bh, (unsigned long) size, (unsigned int *) geom + 2,
