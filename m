Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275023AbTHQGM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275024AbTHQGM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:12:58 -0400
Received: from codepoet.org ([166.70.99.138]:53135 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275023AbTHQGMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:12:38 -0400
Date: Sun, 17 Aug 2003 00:12:39 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061238.GB17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates HDIO_GETGEO_BIG and HDIO_GETGEO_BIG_RAW,
where are entirely unused and unnecessary.  They were also
removed from 2.6.x,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- orig/arch/ppc64/kernel/ioctl32.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/arch/ppc64/kernel/ioctl32.c	2003-08-16 21:09:11.000000000 -0600
@@ -856,28 +856,6 @@
 	u32 start;
 };
 
-static int hdio_getgeo_big(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct hd_big_geometry geo;
-	int err;
-	
-	set_fs (KERNEL_DS);
-	err = sys_ioctl(fd, HDIO_GETGEO_BIG, (unsigned long)&geo);
-	set_fs (old_fs);
-	if (err)
-		return err;
-	else {
-		struct hd_big_geometry32 *user_geo = (struct hd_big_geometry32 *)arg;
-		err = __put_user (geo.heads, &(user_geo->heads));
-		err |= __put_user (geo.sectors, &(user_geo->sectors));
-		err |= __put_user (geo.cylinders, &(user_geo->cylinders));
-		err |= __put_user (geo.start, &(user_geo->start));
-	}
-	return err ? -EFAULT : 0;
-}
-
-
 static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -4490,8 +4468,6 @@
 HANDLE_IOCTL(SIOCRTMSG, ret_einval),
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp),
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo),
-HANDLE_IOCTL(HDIO_GETGEO_BIG, hdio_getgeo_big),
-HANDLE_IOCTL(HDIO_GETGEO_BIG_RAW, hdio_getgeo_big),
 HANDLE_IOCTL(BLKRAGET, w_long),
 HANDLE_IOCTL(BLKGETSIZE, w_long),
 HANDLE_IOCTL(0x1260, broken_blkgetsize),
--- orig/arch/sparc64/kernel/ioctl32.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/arch/sparc64/kernel/ioctl32.c	2003-08-16 21:09:11.000000000 -0600
@@ -850,27 +850,6 @@
 	u32 start;
 };
                         
-static int hdio_getgeo_big(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct hd_big_geometry geo;
-	int err;
-	
-	set_fs (KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)&geo);
-	set_fs (old_fs);
-	if (!err) {
-		struct hd_big_geometry32 *up = (struct hd_big_geometry32 *) arg;
-
-		if (put_user(geo.heads, &up->heads) ||
-		    __put_user(geo.sectors, &up->sectors) ||
-		    __put_user(geo.cylinders, &up->cylinders) ||
-		    __put_user(((u32) geo.start), &up->start))
-			err = -EFAULT;
-	}
-	return err;
-}
-
 struct  fbcmap32 {
 	int             index;          /* first element (0 origin) */
 	int             count;
@@ -5160,8 +5139,6 @@
 HANDLE_IOCTL(SIOCRTMSG, ret_einval)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
-HANDLE_IOCTL(HDIO_GETGEO_BIG, hdio_getgeo_big)
-HANDLE_IOCTL(HDIO_GETGEO_BIG_RAW, hdio_getgeo_big)
 HANDLE_IOCTL(BLKRAGET, w_long)
 HANDLE_IOCTL(BLKGETSIZE, w_long)
 HANDLE_IOCTL(0x1260, broken_blkgetsize)
--- orig/drivers/block/cciss.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/block/cciss.c	2003-08-16 21:09:11.000000000 -0600
@@ -489,26 +489,6 @@
 			return  -EFAULT;
 		return 0;
 	   }
-	case HDIO_GETGEO_BIG:
-	{
-		struct hd_big_geometry driver_geo;
-		if (hba[ctlr]->drv[dsk].cylinders) {
-			driver_geo.heads = hba[ctlr]->drv[dsk].heads;
-			driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
-			driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
-		} else {
-			driver_geo.heads = 0xff;
-			driver_geo.sectors = 0x3f;
-			driver_geo.cylinders = 
-				hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
-		}
-		driver_geo.start= 
-		hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect;
-		if (copy_to_user((void *) arg, &driver_geo,  
-				sizeof( struct hd_big_geometry)))
-			return  -EFAULT;
-		return 0;
-	}
 	case BLKRRPART:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
--- orig/drivers/block/cpqarray.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/block/cpqarray.c	2003-08-16 21:09:11.000000000 -0600
@@ -1251,27 +1251,6 @@
 			return  -EFAULT;
 		return(0);
 	}
-	case HDIO_GETGEO_BIG:
-	{
-		struct hd_big_geometry driver_geo;
-
-		if (hba[ctlr]->drv[dsk].cylinders) {
-			driver_geo.heads = hba[ctlr]->drv[dsk].heads;
-			driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
-			driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
-		} else {
-			driver_geo.heads = 0xff;
-			driver_geo.sectors = 0x3f;
-			driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blks 
-				/ (0xff*0x3f);
-		}
-		driver_geo.start=
-			hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect;
-		if (copy_to_user((void *) arg, &driver_geo,
-				sizeof( struct hd_big_geometry)))
-			return  -EFAULT;
-		return(0);
-	}
 
 	case IDAGETDRVINFO:
 	{
--- orig/drivers/ide/ide.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/ide/ide.c	2003-08-16 21:09:11.000000000 -0600
@@ -1573,30 +1573,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
-			if (put_user(drive->bios_head, (u8 *) &loc->heads)) return -EFAULT;
-			if (put_user(drive->bios_sect, (u8 *) &loc->sectors)) return -EFAULT;
-			if (put_user(drive->bios_cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)drive->part[MINOR(inode->i_rdev)&PARTN_MASK].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
-		case HDIO_GETGEO_BIG_RAW:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
-			if (put_user(drive->head, (u8 *) &loc->heads)) return -EFAULT;
-			if (put_user(drive->sect, (u8 *) &loc->sectors)) return -EFAULT;
-			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)drive->part[MINOR(inode->i_rdev)&PARTN_MASK].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
 	 	case BLKGETSIZE:   /* Return device size */
 			return put_user(drive->part[MINOR(inode->i_rdev)&PARTN_MASK].nr_sects, (unsigned long *) arg);
 	 	case BLKGETSIZE64:
--- orig/drivers/ide/raid/hptraid.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/ide/raid/hptraid.c	2003-08-16 21:09:11.000000000 -0600
@@ -199,22 +199,6 @@
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
-			if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-			
 		default:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 	};
--- orig/drivers/ide/raid/pdcraid.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/ide/raid/pdcraid.c	2003-08-16 21:09:11.000000000 -0600
@@ -132,18 +132,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc) return -EINVAL;
-			if (put_user(raid[minor].geom.heads, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(raid[minor].geom.sectors, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(raid[minor].geom.cylinders, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
 		default:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 	};
--- orig/drivers/ide/raid/silraid.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/ide/raid/silraid.c	2003-08-16 21:09:11.000000000 -0600
@@ -130,19 +130,6 @@
 			return 0;
 		}
 
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc) return -EINVAL;
-			if (put_user(raid[minor].geom.heads, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(raid[minor].geom.sectors, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(raid[minor].geom.cylinders, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
-			
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
--- orig/drivers/md/lvm.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/md/lvm.c	2003-08-16 21:09:11.000000000 -0600
@@ -893,13 +893,14 @@
 } /* lvm_blk_open() */
 
 /* Deliver "hard disk geometry" */
-static int _hdio_getgeo(ulong a, lv_t *lv_ptr, int what)
+static int _hdio_getgeo(ulong a, lv_t *lv_ptr)
 {
 	int ret = 0;
 	uchar heads = 128;
 	uchar sectors = 128;
 	ulong start = 0;
 	uint cylinders;
+	struct hd_geometry *hd = (struct hd_geometry *) a;
 
 	while ( heads * sectors > lv_ptr->lv_size) {
 		heads >>= 1;
@@ -907,35 +908,11 @@
 	}
 	cylinders = lv_ptr->lv_size / heads / sectors;
 
-	switch (what) {
-		case 0:
-		{
-			struct hd_geometry *hd = (struct hd_geometry *) a;
-
-			if (put_user(heads, &hd->heads) ||
-	    		    put_user(sectors, &hd->sectors) ||
-	    		    put_user((ushort) cylinders, &hd->cylinders) ||
-			    put_user(start, &hd->start))
-				return -EFAULT;
-			break;
-		}
-
-#ifdef HDIO_GETGEO_BIG
-		case 1:
-		{
-			struct hd_big_geometry *hd =
-				(struct hd_big_geometry *) a;
-
-			if (put_user(heads, &hd->heads) ||
-	    		    put_user(sectors, &hd->sectors) ||
-	    		    put_user(cylinders, &hd->cylinders) ||
-			    put_user(start, &hd->start))
-				return -EFAULT;
-			break;
-		}
-#endif
-
-	}
+	if (put_user(heads, &hd->heads) ||
+		put_user(sectors, &hd->sectors) ||
+		put_user((ushort) cylinders, &hd->cylinders) ||
+		put_user(start, &hd->start))
+	    return -EFAULT;
 
 	P_IOCTL("%s -- lvm_blk_ioctl -- cylinders: %d\n",
 		lvm_name, cylinders);
@@ -970,23 +947,12 @@
 			break;
 	
 		case HDIO_GETGEO:
-#ifdef HDIO_GETGEO_BIG
-		case HDIO_GETGEO_BIG:
-#endif
 			/* get disk geometry */
 			P_IOCTL("%s -- lvm_blk_ioctl -- HDIO_GETGEO\n",
 				lvm_name);
 			if (!a)
 				return -EINVAL;
-
-			switch (cmd) {
-				case HDIO_GETGEO:
-					return _hdio_getgeo(a, lv_ptr, 0);
-#ifdef HDIO_GETGEO_BIG
-				case HDIO_GETGEO_BIG:
-					return _hdio_getgeo(a, lv_ptr, 1);
-#endif
-			}
+			return _hdio_getgeo(a, lv_ptr);
 	
 		case LV_BMAP:
 			/* turn logical block into (dev_t, block). non privileged. */
--- orig/drivers/scsi/sd.c	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/drivers/scsi/sd.c	2003-08-16 21:09:11.000000000 -0600
@@ -205,39 +205,6 @@
 				return -EFAULT;
 			return 0;
 		}
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-
-			if(!loc)
-				return -EINVAL;
-
-			host = rscsi_disks[DEVICE_NR(dev)].device->host;
-
-			/* default to most commonly used values */
-
-			diskinfo[0] = 0x40;
-			diskinfo[1] = 0x20;
-			diskinfo[2] = rscsi_disks[DEVICE_NR(dev)].capacity >> 11;
-
-			/* override with calculated, extended default, or driver values */
-
-			if(host->hostt->bios_param != NULL)
-				host->hostt->bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					    dev,
-					    &diskinfo[0]);
-			else scsicam_bios_param(&rscsi_disks[DEVICE_NR(dev)],
-					dev, &diskinfo[0]);
-
-			if (put_user(diskinfo[0], &loc->heads) ||
-				put_user(diskinfo[1], &loc->sectors) ||
-				put_user(diskinfo[2], (unsigned int *) &loc->cylinders) ||
-				put_user(sd_gendisks[SD_MAJOR_IDX(
-				    inode->i_rdev)].part[MINOR(
-				    inode->i_rdev)].start_sect, &loc->start))
-				return -EFAULT;
-			return 0;
-		}
 		case BLKGETSIZE:
 		case BLKGETSIZE64:
 		case BLKROSET:
--- orig/include/linux/hdreg.h	2003-08-16 21:09:11.000000000 -0600
+++ linux-2.4.21/include/linux/hdreg.h	2003-08-16 21:09:11.000000000 -0600
@@ -361,7 +361,7 @@
 #define SETFEATURES_DIS_MSN	0x31	/* Disable Media Status Notification */
 #define SETFEATURES_DIS_RETRY	0x33	/* Disable Retry */
 #define SETFEATURES_EN_AAM	0x42	/* Enable Automatic Acoustic Management */
-#define SETFEATURES_RW_LONG	0x44	/* Set Lenght of VS bytes */
+#define SETFEATURES_RW_LONG	0x44	/* Set Length of VS bytes */
 #define SETFEATURES_SET_CACHE	0x54	/* Set Cache segments to SC Reg. Val */
 #define SETFEATURES_DIS_RLA	0x55	/* Disable read look-ahead feature */
 #define SETFEATURES_EN_RI	0x5D	/* Enable release interrupt */
@@ -401,14 +401,6 @@
       unsigned long start;
 };
 
-/* BIG GEOMETRY */
-struct hd_big_geometry {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned int cylinders;
-	unsigned long start;
-};
-
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x030n/0x031n */
 #define HDIO_GETGEO		0x0301	/* get device geometry */
 #define HDIO_GET_UNMASKINTR	0x0302	/* get current unmask setting */
@@ -462,8 +454,8 @@
 };
 
 /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x033n/0x033n */
-#define HDIO_GETGEO_BIG		0x0330	/* */
-#define HDIO_GETGEO_BIG_RAW	0x0331	/* */
+/* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
+/* 0x331 is reserved - used to be HDIO_GETGEO_BIG_RAW */
 
 #define HDIO_SET_IDE_SCSI	0x0338
 #define HDIO_SET_SCSI_IDE	0x0339
