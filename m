Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315563AbSEHXpl>; Wed, 8 May 2002 19:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315565AbSEHXpk>; Wed, 8 May 2002 19:45:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9186 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315563AbSEHXpi>;
	Wed, 8 May 2002 19:45:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 9 May 2002 01:45:35 +0200 (MEST)
Message-Id: <UTC200205082345.g48NjZX24244.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com, torvalds@transmeta.com
Subject: [PATCH] hdreg.h
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Martin:

People complain that fdisk doesn't compile under 2.5.14
because hdreg.h has acquired stuff that cannot be included
from userspace. Will release util-linux 2.11r later tonight
with a local copy.
But now that I look at this file: it still contains
struct hd_big_geometry and HDIO_GETGEO_BIG.
Please remove them.

Andries

diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/block/cciss.c ./linux/drivers/block/cciss.c
--- ../linux-2.5.14/linux/drivers/block/cciss.c	Sat May  4 00:52:47 2002
+++ ./linux/drivers/block/cciss.c	Thu May  9 01:24:55 2002
@@ -436,25 +436,7 @@
                         return  -EFAULT;
                 return(0);
 	}
-	case HDIO_GETGEO_BIG:
-        {
-		struct hd_big_geometry driver_geo;
-                if (hba[ctlr]->drv[dsk].cylinders) {
-                        driver_geo.heads = hba[ctlr]->drv[dsk].heads;
-                        driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
-                        driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
-                } else {
-                        driver_geo.heads = 0xff;
-                        driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
-              	}
-	      	driver_geo.start= 
-			hba[ctlr]->hd[minor(inode->i_rdev)].start_sect;
-		if (copy_to_user((void *) arg, &driver_geo,  
-				sizeof( struct hd_big_geometry)))
-                        return  -EFAULT;
-                return(0);
-        }
+
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case BLKGETSIZE:
diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/ide/hptraid.c ./linux/drivers/ide/hptraid.c
--- ../linux-2.5.14/linux/drivers/ide/hptraid.c	Mon Mar 18 21:37:15 2002
+++ ./linux/drivers/ide/hptraid.c	Thu May  9 01:24:45 2002
@@ -107,22 +107,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			unsigned int bios_cyl;
-			if (!loc) return -EINVAL;
-			val = 255;
-			if (put_user(val, (byte *) &loc->heads)) return -EFAULT;
-			val = 63;
-			if (put_user(val, (byte *) &loc->sectors)) return -EFAULT;
-			bios_cyl = raid[minor].sectors/63/255;
-			if (put_user(bios_cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[minor(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-			
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/ide/ide-geometry.c ./linux/drivers/ide/ide-geometry.c
--- ../linux-2.5.14/linux/drivers/ide/ide-geometry.c	Mon Apr 29 01:36:42 2002
+++ ./linux/drivers/ide/ide-geometry.c	Tue May  7 21:59:51 2002
@@ -2,7 +2,7 @@
  * linux/drivers/ide/ide-geometry.c
  *
  * Sun Feb 24 23:13:03 CET 2002: Patch by Andries Brouwer to remove the
- * confused CMOS probe applied. This is solving more problems then it my
+ * confused CMOS probe applied. This is solving more problems than it may
  * (unexpectedly) introduce.
  */
 
diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/ide/ide.c ./linux/drivers/ide/ide.c
--- ../linux-2.5.14/linux/drivers/ide/ide.c	Thu May  9 01:08:27 2002
+++ ./linux/drivers/ide/ide.c	Thu May  9 01:24:23 2002
@@ -2511,21 +2511,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-
-			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
-				return -EINVAL;
-
-			if (put_user(drive->bios_head, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(drive->bios_sect, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(drive->bios_cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)drive->part[minor(inode->i_rdev)&PARTN_MASK].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
 		case HDIO_GETGEO_BIG_RAW:
 		{
 			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/ide/pdcraid.c ./linux/drivers/ide/pdcraid.c
--- ../linux-2.5.14/linux/drivers/ide/pdcraid.c	Mon Mar 18 21:37:14 2002
+++ ./linux/drivers/ide/pdcraid.c	Thu May  9 01:24:35 2002
@@ -132,19 +132,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc) return -EINVAL;
-			if (put_user(raid[minor].geom.heads, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(raid[minor].geom.sectors, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(raid[minor].geom.cylinders, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[minor(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
-			
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
diff -u --recursive --new-file ../linux-2.5.14/linux/drivers/scsi/sd.c ./linux/drivers/scsi/sd.c
--- ../linux-2.5.14/linux/drivers/scsi/sd.c	Thu May  9 01:08:27 2002
+++ ./linux/drivers/scsi/sd.c	Thu May  9 01:23:38 2002
@@ -242,38 +242,7 @@
 				return -EFAULT;
 			return 0;
 		}
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = 
-					(struct hd_big_geometry *) arg;
 
-			if(!loc)
-				return -EINVAL;
-			host = sdp->host;
-
-			/* default to most commonly used values */
-			diskinfo[0] = 0x40;
-			diskinfo[1] = 0x20;
-			diskinfo[2] = sdkp->capacity >> 11;
-
-			/* override with calculated, extended default, 
-			   or driver values */
-			if(host->hostt->bios_param != NULL) 
-				host->hostt->bios_param(sdkp, dev,
-							&diskinfo[0]);
-			else
-				scsicam_bios_param(sdkp, dev, &diskinfo[0]);
-
-			if (put_user(diskinfo[0], &loc->heads) ||
-				put_user(diskinfo[1], &loc->sectors) ||
-				put_user(diskinfo[2], 
-					 (unsigned int *) &loc->cylinders) ||
-				put_user((unsigned)
-					   get_start_sect(inode->i_rdev),
-					 (unsigned long *)&loc->start))
-				return -EFAULT;
-			return 0;
-		}
 		case BLKGETSIZE:
 		case BLKGETSIZE64:
 		case BLKROSET:
diff -u --recursive --new-file ../linux-2.5.14/linux/include/linux/hdreg.h ./linux/include/linux/hdreg.h
--- ../linux-2.5.14/linux/include/linux/hdreg.h	Thu May  2 21:08:00 2002
+++ ./linux/include/linux/hdreg.h	Thu May  9 01:41:50 2002
@@ -280,7 +280,7 @@
       unsigned long start;
 };
 
-/* BIG GEOMETRY */
+/* BIG GEOMETRY - dying, used only by HDIO_GETGEO_BIG_RAW */
 struct hd_big_geometry {
 	unsigned char heads;
 	unsigned char sectors;
@@ -327,7 +327,7 @@
 };
 
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x033n/0x033n */
-#define HDIO_GETGEO_BIG		0x0330	/* */
+/* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
 #define HDIO_GETGEO_BIG_RAW	0x0331	/* */
 
 #define __NEW_HD_DRIVE_ID
