Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRKJHfA>; Sat, 10 Nov 2001 02:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276709AbRKJHel>; Sat, 10 Nov 2001 02:34:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:42507 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275552AbRKJHed>; Sat, 10 Nov 2001 02:34:33 -0500
Message-ID: <3BECD87F.F53234B2@zip.com.au>
Date: Fri, 09 Nov 2001 23:34:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: scsi BLKGETSIZE breakage in -pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sd_ioctl() was changed to pass BLKGETSIZE off to blk_ioctl(),
but blk_ioctl() doesn't implement it.

So `cfdisk /dev/sda' is failing.

Simply copying the -ac version of blkpg.c across fixes
it for me.


--- linux-2.4.15-pre2/drivers/block/blkpg.c	Mon Oct 15 13:27:42 2001
+++ linux-akpm/drivers/block/blkpg.c	Fri Nov  9 23:14:23 2001
@@ -195,8 +195,13 @@ int blkpg_ioctl(kdev_t dev, struct blkpg
 
 int blk_ioctl(kdev_t dev, unsigned int cmd, unsigned long arg)
 {
+	struct gendisk *g;
+	u64 ullval = 0;
 	int intval;
 
+	if (!dev)
+		return -EINVAL;
+
 	switch (cmd) {
 		case BLKROSET:
 			if (!capable(CAP_SYS_ADMIN))
@@ -212,7 +217,7 @@ int blk_ioctl(kdev_t dev, unsigned int c
 		case BLKRASET:
 			if(!capable(CAP_SYS_ADMIN))
 				return -EACCES;
-			if(!dev || arg > 0xff)
+			if(arg > 0xff)
 				return -EINVAL;
 			read_ahead[MAJOR(dev)] = arg;
 			return 0;
@@ -224,8 +229,6 @@ int blk_ioctl(kdev_t dev, unsigned int c
 		case BLKFLSBUF:
 			if(!capable(CAP_SYS_ADMIN))
 				return -EACCES;
-			if (!dev)
-				return -EINVAL;
 			fsync_dev(dev);
 			invalidate_buffers(dev);
 			return 0;
@@ -235,18 +238,16 @@ int blk_ioctl(kdev_t dev, unsigned int c
 			intval = get_hardsect_size(dev);
 			return put_user(intval, (int *) arg);
 
-#if 0
 		case BLKGETSIZE:
-			/* Today get_gendisk() requires a linear scan;
-			   add this when dev has pointer type. */
-			/* add BLKGETSIZE64 too */
+		case BLKGETSIZE64:
 			g = get_gendisk(dev);
-			if (!g)
-				ulongval = 0;
+			if (g)
+				ullval = g->part[MINOR(dev)].nr_sects;
+
+			if (cmd == BLKGETSIZE)
+				return put_user((unsigned long)ullval, (unsigned long *)arg);
 			else
-				ulongval = g->part[MINOR(dev)].nr_sects;
-			return put_user(ulongval, (unsigned long *) arg);
-#endif
+				return put_user(ullval, (u64 *)arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN))
