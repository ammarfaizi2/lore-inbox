Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVKSUsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKSUsL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVKSUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:48:10 -0500
Received: from verein.lst.de ([213.95.11.210]:43433 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750821AbVKSUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:48:09 -0500
Date: Sat, 19 Nov 2005 21:47:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add ->getgeo block device method
Message-ID: <20051119204754.GA30990@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HDIO_GETGEO is implemented in most block drivers, and all of them have
to duplicate the code to copy the structure to userspace, aswell as
getting the start sector.  This patch moves that to common code [1]
and adds a ->getgeo method to fill out the raw kernel hd_geometry
structure.  For many drivers this means ->ioctl can go away now.

[1] the s390 block drivers are odd in this respect.  xpram sets ->start
    to 4 always which seems more than odd, and the dasd driver shifts
    the start offset around, probably because of it's non-standard
    sector size.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/ubd_kern.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/arch/um/drivers/ubd_kern.c	2005-11-19 19:52:06.000000000 +0100
@@ -117,6 +117,7 @@
 static int ubd_release(struct inode * inode, struct file * file);
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg);
+static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 #define MAX_DEV (8)
 
@@ -125,6 +126,7 @@
         .open		= ubd_open,
         .release	= ubd_release,
         .ioctl		= ubd_ioctl,
+	.getgeo		= ubd_getgeo,
 };
 
 /* Protected by the queue_lock */
@@ -1058,6 +1060,16 @@
 	}
 }
 
+static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct ubd *dev = bdev->bd_disk->private_data;
+
+	geo->heads = 128;
+	geo->sectors = 32;
+	geo->cylinders = dev->size / (128 * 32 * 512);
+	return 0;
+}
+
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -1070,16 +1082,7 @@
 	};
 
 	switch (cmd) {
-	        struct hd_geometry g;
 		struct cdrom_volctrl volume;
-	case HDIO_GETGEO:
-		if(!loc) return(-EINVAL);
-		g.heads = 128;
-		g.sectors = 32;
-		g.cylinders = dev->size / (128 * 32 * 512);
-		g.start = get_start_sect(inode->i_bdev);
-		return(copy_to_user(loc, &g, sizeof(g)) ? -EFAULT : 0);
-
 	case HDIO_GET_IDENTITY:
 		ubd_id.cyls = dev->size / (128 * 32 * 512);
 		if(copy_to_user((char __user *) arg, (char *) &ubd_id,
Index: linux-2.6/block/ioctl.c
===================================================================
--- linux-2.6.orig/block/ioctl.c	2005-11-19 19:51:58.000000000 +0100
+++ linux-2.6/block/ioctl.c	2005-11-19 19:52:25.000000000 +0100
@@ -1,6 +1,7 @@
 #include <linux/sched.h>		/* for capable() */
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
+#include <linux/hdreg.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
@@ -245,6 +246,27 @@
 		set_device_ro(bdev, n);
 		unlock_kernel();
 		return 0;
+	case HDIO_GETGEO: {
+		struct hd_geometry geo;
+
+		if (!arg)
+			return -EINVAL;
+		if (!disk->fops->getgeo)
+			return -ENOTTY;
+
+		/*
+		 * We need to set the startsect first, the driver may
+		 * want to override it.
+		 */
+		geo.start = get_start_sect(bdev);
+		ret = disk->fops->getgeo(bdev, &geo);
+		if (ret)
+			return ret;
+		if (copy_to_user((struct hd_geometry __user *)arg, &geo,
+					sizeof(geo)))
+			return -EFAULT;
+		return 0;
+	}
 	}
 
 	lock_kernel();
Index: linux-2.6/drivers/acorn/block/mfmhd.c
===================================================================
--- linux-2.6.orig/drivers/acorn/block/mfmhd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/acorn/block/mfmhd.c	2005-11-19 19:52:06.000000000 +0100
@@ -129,19 +129,6 @@
 #define MAJOR_NR	MFM_ACORN_MAJOR
 #define QUEUE (mfm_queue)
 #define CURRENT elv_next_request(mfm_queue)
-/*
- * This sort of stuff should be in a header file shared with ide.c, hd.c, xd.c etc
- */
-#ifndef HDIO_GETGEO
-#define HDIO_GETGEO 0x301
-struct hd_geometry {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned short cylinders;
-	unsigned long start;
-};
-#endif
-
 
 /*
  * Configuration section
@@ -1153,22 +1140,13 @@
  * The 'front' end of the mfm driver follows...
  */
 
-static int mfm_ioctl(struct inode *inode, struct file *file, u_int cmd, u_long arg)
+static int mfm_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct mfm_info *p = inode->i_bdev->bd_disk->private_data;
-	struct hd_geometry *geo = (struct hd_geometry *) arg;
-	if (cmd != HDIO_GETGEO)
-		return -EINVAL;
-	if (!arg)
-		return -EINVAL;
-	if (put_user (p->heads, &geo->heads))
-		return -EFAULT;
-	if (put_user (p->sectors, &geo->sectors))
-		return -EFAULT;
-	if (put_user (p->cylinders, &geo->cylinders))
-		return -EFAULT;
-	if (put_user (get_start_sect(inode->i_bdev), &geo->start))
-		return -EFAULT;
+	struct mfm_info *p = bdev->bd_disk->private_data;
+
+	geo->heads = p->heads;
+	geo->sectors = p->sectors;
+	geo->cylinders = p->cylinders;
 	return 0;
 }
 
@@ -1219,7 +1197,7 @@
 static struct block_device_operations mfm_fops =
 {
 	.owner		= THIS_MODULE,
-	.ioctl		= mfm_ioctl,
+	.getgeo		= mfm_getgeo,
 };
 
 /*
Index: linux-2.6/drivers/block/DAC960.c
===================================================================
--- linux-2.6.orig/drivers/block/DAC960.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/DAC960.c	2005-11-19 19:52:06.000000000 +0100
@@ -92,34 +92,28 @@
 	return 0;
 }
 
-static int DAC960_ioctl(struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg)
+static int DAC960_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	DAC960_Controller_T *p = disk->queue->queuedata;
 	int drive_nr = (long)disk->private_data;
-	struct hd_geometry g;
-	struct hd_geometry __user *loc = (struct hd_geometry __user *)arg;
-
-	if (cmd != HDIO_GETGEO || !loc)
-		return -EINVAL;
 
 	if (p->FirmwareType == DAC960_V1_Controller) {
-		g.heads = p->V1.GeometryTranslationHeads;
-		g.sectors = p->V1.GeometryTranslationSectors;
-		g.cylinders = p->V1.LogicalDriveInformation[drive_nr].
-			LogicalDriveSize / (g.heads * g.sectors);
+		geo->heads = p->V1.GeometryTranslationHeads;
+		geo->sectors = p->V1.GeometryTranslationSectors;
+		geo->cylinders = p->V1.LogicalDriveInformation[drive_nr].
+			LogicalDriveSize / (geo->heads * geo->sectors);
 	} else {
 		DAC960_V2_LogicalDeviceInfo_T *i =
 			p->V2.LogicalDeviceInformation[drive_nr];
 		switch (i->DriveGeometry) {
 		case DAC960_V2_Geometry_128_32:
-			g.heads = 128;
-			g.sectors = 32;
+			geo->heads = 128;
+			geo->sectors = 32;
 			break;
 		case DAC960_V2_Geometry_255_63:
-			g.heads = 255;
-			g.sectors = 63;
+			geo->heads = 255;
+			geo->sectors = 63;
 			break;
 		default:
 			DAC960_Error("Illegal Logical Device Geometry %d\n",
@@ -127,12 +121,11 @@
 			return -EINVAL;
 		}
 
-		g.cylinders = i->ConfigurableDeviceSize / (g.heads * g.sectors);
+		geo->cylinders = i->ConfigurableDeviceSize /
+			(geo->heads * geo->sectors);
 	}
 	
-	g.start = get_start_sect(inode->i_bdev);
-
-	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
+	return 0;
 }
 
 static int DAC960_media_changed(struct gendisk *disk)
@@ -157,7 +150,7 @@
 static struct block_device_operations DAC960_BlockDeviceOperations = {
 	.owner			= THIS_MODULE,
 	.open			= DAC960_open,
-	.ioctl			= DAC960_ioctl,
+	.getgeo			= DAC960_getgeo,
 	.media_changed		= DAC960_media_changed,
 	.revalidate_disk	= DAC960_revalidate_disk,
 };
Index: linux-2.6/drivers/block/acsi.c
===================================================================
--- linux-2.6.orig/drivers/block/acsi.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/acsi.c	2005-11-19 19:52:06.000000000 +0100
@@ -1079,6 +1079,19 @@
  *
  ***********************************************************************/
 
+static int acsi_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct acsi_info_struct *aip = bdev->bd_disk->private_data;
+
+	/*
+	 * Just fake some geometry here, it's nonsense anyway
+	 * To make it easy, use Adaptec's usual 64/32 mapping
+	 */
+	geo->heads = 64;
+	geo->sectors = 32;
+	geo->cylinders = aip->size >> 11;
+	return 0;
+}
 
 static int acsi_ioctl( struct inode *inode, struct file *file,
 					   unsigned int cmd, unsigned long arg )
@@ -1086,18 +1099,6 @@
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct acsi_info_struct *aip = disk->private_data;
 	switch (cmd) {
-	  case HDIO_GETGEO:
-		/* HDIO_GETGEO is supported more for getting the partition's
-		 * start sector... */
-	  { struct hd_geometry *geo = (struct hd_geometry *)arg;
-	    /* just fake some geometry here, it's nonsense anyway; to make it
-		 * easy, use Adaptec's usual 64/32 mapping */
-	    put_user( 64, &geo->heads );
-	    put_user( 32, &geo->sectors );
-	    put_user( aip->size >> 11, &geo->cylinders );
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
-		return 0;
-	  }
 	  case SCSI_IOCTL_GET_IDLUN:
 		/* SCSI compatible GET_IDLUN call to get target's ID and LUN number */
 		put_user( aip->target | (aip->lun << 8),
@@ -1592,6 +1593,7 @@
 	.open		= acsi_open,
 	.release	= acsi_release,
 	.ioctl		= acsi_ioctl,
+	.getgeo		= acsi_getgeo,
 	.media_changed	= acsi_media_change,
 	.revalidate_disk= acsi_revalidate,
 };
Index: linux-2.6/drivers/block/amiflop.c
===================================================================
--- linux-2.6.orig/drivers/block/amiflop.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/amiflop.c	2005-11-19 19:52:06.000000000 +0100
@@ -1424,6 +1424,16 @@
 	redo_fd_request();
 }
 
+static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	int drive = minor(bdev->bd_dev) & 3;
+
+	geo->heads = unit[drive].type->heads;
+	geo->sectors = unit[drive].dtype->sects * unit[drive].type->sect_mult;
+	geo->cylinders = unit[drive].type->tracks;
+	return 0;
+}
+
 static int fd_ioctl(struct inode *inode, struct file *filp,
 		    unsigned int cmd, unsigned long param)
 {
@@ -1431,18 +1441,6 @@
 	static struct floppy_struct getprm;
 
 	switch(cmd){
-	case HDIO_GETGEO:
-	{
-		struct hd_geometry loc;
-		loc.heads = unit[drive].type->heads;
-		loc.sectors = unit[drive].dtype->sects * unit[drive].type->sect_mult;
-		loc.cylinders = unit[drive].type->tracks;
-		loc.start = 0;
-		if (copy_to_user((void *)param, (void *)&loc,
-				 sizeof(struct hd_geometry)))
-			return -EFAULT;
-		break;
-	}
 	case FDFMTBEG:
 		get_fdc(drive);
 		if (fd_ref[drive] > 1) {
@@ -1652,6 +1650,7 @@
 	.open		= floppy_open,
 	.release	= floppy_release,
 	.ioctl		= fd_ioctl,
+	.getgeo		= fd_getgeo,
 	.media_changed	= amiga_floppy_change,
 };
 
Index: linux-2.6/drivers/block/aoe/aoeblk.c
===================================================================
--- linux-2.6.orig/drivers/block/aoe/aoeblk.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/aoe/aoeblk.c	2005-11-19 19:52:06.000000000 +0100
@@ -169,38 +169,26 @@
 	return 0;
 }
 
-/* This ioctl implementation expects userland to have the device node
- * permissions set so that only priviledged users can open an aoe
- * block device directly.
- */
 static int
-aoeblk_ioctl(struct inode *inode, struct file *filp, uint cmd, ulong arg)
+aoeblk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct aoedev *d;
+	struct aoedev *d = bdev->bd_disk->private_data;
 
-	if (!arg)
-		return -EINVAL;
-
-	d = inode->i_bdev->bd_disk->private_data;
 	if ((d->flags & DEVFL_UP) == 0) {
 		printk(KERN_ERR "aoe: aoeblk_ioctl: disk not up\n");
 		return -ENODEV;
 	}
 
-	if (cmd == HDIO_GETGEO) {
-		d->geo.start = get_start_sect(inode->i_bdev);
-		if (!copy_to_user((void __user *) arg, &d->geo, sizeof d->geo))
-			return 0;
-		return -EFAULT;
-	}
-	printk(KERN_INFO "aoe: aoeblk_ioctl: unknown ioctl %d\n", cmd);
-	return -EINVAL;
+	geo->cylinders = d->geo.cylinders;
+	geo->heads = d->geo.heads;
+	geo->sectors = d->geo.sectors;
+	return 0;
 }
 
 static struct block_device_operations aoe_bdops = {
 	.open = aoeblk_open,
 	.release = aoeblk_release,
-	.ioctl = aoeblk_ioctl,
+	.getgeo = aoeblk_getgeo,
 	.owner = THIS_MODULE,
 };
 
Index: linux-2.6/drivers/block/cciss.c
===================================================================
--- linux-2.6.orig/drivers/block/cciss.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/cciss.c	2005-11-19 19:52:06.000000000 +0100
@@ -153,6 +153,7 @@
 static int cciss_release(struct inode *inode, struct file *filep);
 static int cciss_ioctl(struct inode *inode, struct file *filep, 
 		unsigned int cmd, unsigned long arg);
+static int cciss_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static int revalidate_allvol(ctlr_info_t *host);
 static int cciss_revalidate(struct gendisk *disk);
@@ -194,6 +195,7 @@
 	.open		= cciss_open, 
 	.release       	= cciss_release,
         .ioctl		= cciss_ioctl,
+        .getgeo		= cciss_getgeo,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = cciss_compat_ioctl,
 #endif
@@ -633,6 +635,20 @@
 	return err;
 }
 #endif
+
+static int cciss_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	drive_info_struct *drv = get_drv(bdev->bd_disk);
+
+	if (!drv->cylinders)
+		return -ENXIO;
+
+	geo->heads = drv->heads;
+	geo->sectors = drv->sectors;
+	geo->cylinders = drv->cylinders;
+	return 0;
+}
+
 /*
  * ioctl 
  */
@@ -651,21 +667,6 @@
 #endif /* CCISS_DEBUG */ 
 	
 	switch(cmd) {
-	case HDIO_GETGEO:
-	{
-                struct hd_geometry driver_geo;
-                if (drv->cylinders) {
-                        driver_geo.heads = drv->heads;
-                        driver_geo.sectors = drv->sectors;
-                        driver_geo.cylinders = drv->cylinders;
-                } else
-			return -ENXIO;
-                driver_geo.start= get_start_sect(inode->i_bdev);
-                if (copy_to_user(argp, &driver_geo, sizeof(struct hd_geometry)))
-                        return  -EFAULT;
-                return(0);
-	}
-
 	case CCISS_GETPCIINFO:
 	{
 		cciss_pci_info_struct pciinfo;
Index: linux-2.6/drivers/block/cpqarray.c
===================================================================
--- linux-2.6.orig/drivers/block/cpqarray.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/cpqarray.c	2005-11-19 20:30:43.000000000 +0100
@@ -160,6 +160,7 @@
 static int ida_open(struct inode *inode, struct file *filep);
 static int ida_release(struct inode *inode, struct file *filep);
 static int ida_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg);
+static int ida_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 static int ida_ctlr_ioctl(ctlr_info_t *h, int dsk, ida_ioctl_t *io);
 
 static void do_ida_request(request_queue_t *q);
@@ -199,6 +200,7 @@
 	.open		= ida_open,
 	.release	= ida_release,
 	.ioctl		= ida_ioctl,
+	.getgeo		= ida_getgeo,
 	.revalidate_disk= ida_revalidate,
 };
 
@@ -1124,6 +1126,23 @@
 	h->misc_tflags = 0;
 }
 
+static int ida_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	drv_info_t *drv = get_drv(bdev->bd_disk);
+
+	if (drv->cylinders) {
+		geo->heads = drv->heads;
+		geo->sectors = drv->sectors;
+		geo->cylinders = drv->cylinders;
+	} else {
+		geo->heads = 0xff;
+		geo->sectors = 0x3f;
+		geo->cylinders = drv->nr_blks / (0xff*0x3f);
+	}
+
+	return 0;
+}
+
 /*
  *  ida_ioctl does some miscellaneous stuff like reporting drive geometry,
  *  setting readahead and submitting commands from userspace to the controller.
@@ -1133,27 +1152,10 @@
 	drv_info_t *drv = get_drv(inode->i_bdev->bd_disk);
 	ctlr_info_t *host = get_host(inode->i_bdev->bd_disk);
 	int error;
-	int diskinfo[4];
-	struct hd_geometry __user *geo = (struct hd_geometry __user *)arg;
 	ida_ioctl_t __user *io = (ida_ioctl_t __user *)arg;
 	ida_ioctl_t *my_io;
 
 	switch(cmd) {
-	case HDIO_GETGEO:
-		if (drv->cylinders) {
-			diskinfo[0] = drv->heads;
-			diskinfo[1] = drv->sectors;
-			diskinfo[2] = drv->cylinders;
-		} else {
-			diskinfo[0] = 0xff;
-			diskinfo[1] = 0x3f;
-			diskinfo[2] = drv->nr_blks / (0xff*0x3f);
-		}
-		put_user(diskinfo[0], &geo->heads);
-		put_user(diskinfo[1], &geo->sectors);
-		put_user(diskinfo[2], &geo->cylinders);
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
-		return 0;
 	case IDAGETDRVINFO:
 		if (copy_to_user(&io->c.drv, drv, sizeof(drv_info_t)))
 			return -EFAULT;
Index: linux-2.6/drivers/block/floppy.c
===================================================================
--- linux-2.6.orig/drivers/block/floppy.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/floppy.c	2005-11-19 19:52:07.000000000 +0100
@@ -3445,6 +3445,23 @@
 	return 0;
 }
 
+static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	int drive = (long)bdev->bd_disk->private_data;
+	int type = ITYPE(drive_state[drive].fd_device);
+	struct floppy_struct *g;
+	int ret;
+
+	ret = get_floppy_geometry(drive, type, &g);
+	if (ret)
+		return ret;
+
+	geo->heads = g->head;
+	geo->sectors = g->sect;
+	geo->cylinders = g->track;
+	return 0;
+}
+
 static int fd_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
 		    unsigned long param)
 {
@@ -3474,23 +3491,6 @@
 		cmd = FDEJECT;
 	}
 
-	/* generic block device ioctls */
-	switch (cmd) {
-		/* the following have been inspired by the corresponding
-		 * code for other block devices. */
-		struct floppy_struct *g;
-	case HDIO_GETGEO:
-		{
-			struct hd_geometry loc;
-			ECALL(get_floppy_geometry(drive, type, &g));
-			loc.heads = g->head;
-			loc.sectors = g->sect;
-			loc.cylinders = g->track;
-			loc.start = 0;
-			return _COPYOUT(loc);
-		}
-	}
-
 	/* convert the old style command into a new style command */
 	if ((cmd & 0xff00) == 0x0200) {
 		ECALL(normalize_ioctl(&cmd, &size));
@@ -3944,6 +3944,7 @@
 	.open		= floppy_open,
 	.release	= floppy_release,
 	.ioctl		= fd_ioctl,
+	.getgeo		= fd_getgeo,
 	.media_changed	= check_floppy_change,
 	.revalidate_disk = floppy_revalidate,
 };
Index: linux-2.6/drivers/block/paride/pd.c
===================================================================
--- linux-2.6.orig/drivers/block/paride/pd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/paride/pd.c	2005-11-19 19:52:07.000000000 +0100
@@ -747,32 +747,33 @@
 	return 0;
 }
 
+static int pd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct pd_unit *disk = bdev->bd_disk->private_data;
+
+	if (disk->alt_geom) {
+		geo->heads = PD_LOG_HEADS;
+		geo->sectors = PD_LOG_SECTS;
+		geo->cylinders = disk->capacity / (geo->heads * geo->sectors);
+	} else {
+		geo->heads = disk->heads;
+		geo->sectors = disk->sectors;
+		geo->cylinders = disk->cylinders;
+	}
+
+	return 0;
+}
+
 static int pd_ioctl(struct inode *inode, struct file *file,
 	 unsigned int cmd, unsigned long arg)
 {
 	struct pd_unit *disk = inode->i_bdev->bd_disk->private_data;
-	struct hd_geometry __user *geo = (struct hd_geometry __user *) arg;
-	struct hd_geometry g;
 
 	switch (cmd) {
 	case CDROMEJECT:
 		if (disk->access == 1)
 			pd_special_command(disk, pd_eject);
 		return 0;
-	case HDIO_GETGEO:
-		if (disk->alt_geom) {
-			g.heads = PD_LOG_HEADS;
-			g.sectors = PD_LOG_SECTS;
-			g.cylinders = disk->capacity / (g.heads * g.sectors);
-		} else {
-			g.heads = disk->heads;
-			g.sectors = disk->sectors;
-			g.cylinders = disk->cylinders;
-		}
-		g.start = get_start_sect(inode->i_bdev);
-		if (copy_to_user(geo, &g, sizeof(struct hd_geometry)))
-			return -EFAULT;
-		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -815,6 +816,7 @@
 	.open		= pd_open,
 	.release	= pd_release,
 	.ioctl		= pd_ioctl,
+	.getgeo		= pd_getgeo,
 	.media_changed	= pd_check_media,
 	.revalidate_disk= pd_revalidate
 };
Index: linux-2.6/drivers/block/paride/pf.c
===================================================================
--- linux-2.6.orig/drivers/block/paride/pf.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/paride/pf.c	2005-11-19 19:52:07.000000000 +0100
@@ -205,6 +205,7 @@
 static void do_pf_request(request_queue_t * q);
 static int pf_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg);
+static int pf_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static int pf_release(struct inode *inode, struct file *file);
 
@@ -266,6 +267,7 @@
 	.open		= pf_open,
 	.release	= pf_release,
 	.ioctl		= pf_ioctl,
+	.getgeo		= pf_getgeo,
 	.media_changed	= pf_check_media,
 };
 
@@ -313,34 +315,34 @@
 	return 0;
 }
 
-static int pf_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int pf_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
-	struct hd_geometry __user *geo = (struct hd_geometry __user *) arg;
-	struct hd_geometry g;
-	sector_t capacity;
-
-	if (cmd == CDROMEJECT) {
-		if (pf->access == 1) {
-			pf_eject(pf);
-			return 0;
-		}
-		return -EBUSY;
-	}
-	if (cmd != HDIO_GETGEO)
-		return -EINVAL;
-	capacity = get_capacity(pf->disk);
+	struct pf_unit *pf = bdev->bd_disk->private_data;
+	sector_t capacity = get_capacity(pf->disk);
+
 	if (capacity < PF_FD_MAX) {
-		g.cylinders = sector_div(capacity, PF_FD_HDS * PF_FD_SPT);
-		g.heads = PF_FD_HDS;
-		g.sectors = PF_FD_SPT;
+		geo->cylinders = sector_div(capacity, PF_FD_HDS * PF_FD_SPT);`
+		geo->heads = PF_FD_HDS;
+		geo->sectors = PF_FD_SPT;
 	} else {
-		g.cylinders = sector_div(capacity, PF_HD_HDS * PF_HD_SPT);
-		g.heads = PF_HD_HDS;
-		g.sectors = PF_HD_SPT;
+		geo->cylinders = sector_div(capacity, PF_HD_HDS * PF_HD_SPT);
+		geo->heads = PF_HD_HDS;
+		geo->sectors = PF_HD_SPT;
 	}
-	if (copy_to_user(geo, &g, sizeof(g)))
-		return -EFAULT;
+
+	return 0;
+}
+
+static int pf_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
+
+	if (cmd != CDROMEJECT)
+		return -EINVAL;
+
+	if (pf->access != 1)
+		return -EBUSY;
+	pf_eject(pf);
 	return 0;
 }
 
Index: linux-2.6/drivers/block/ps2esdi.c
===================================================================
--- linux-2.6.orig/drivers/block/ps2esdi.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/ps2esdi.c	2005-11-19 19:52:07.000000000 +0100
@@ -81,8 +81,7 @@
 static void ps2esdi_normal_interrupt_handler(u_int);
 static void ps2esdi_initial_reset_int_handler(u_int);
 static void ps2esdi_geometry_int_handler(u_int);
-static int ps2esdi_ioctl(struct inode *inode, struct file *file,
-			 u_int cmd, u_long arg);
+static int ps2esdi_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static int ps2esdi_read_status_words(int num_words, int max_words, u_short * buffer);
 
@@ -132,7 +131,7 @@
 static struct block_device_operations ps2esdi_fops =
 {
 	.owner		= THIS_MODULE,
-	.ioctl		= ps2esdi_ioctl,
+	.getgeo		= ps2esdi_getgeo,
 };
 
 static struct gendisk *ps2esdi_gendisk[2];
@@ -1058,21 +1057,13 @@
 
 }
 
-static int ps2esdi_ioctl(struct inode *inode,
-			 struct file *file, u_int cmd, u_long arg)
+static int ps2esdi_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct ps2esdi_i_struct *p = inode->i_bdev->bd_disk->private_data;
-	struct ps2esdi_geometry geom;
+	struct ps2esdi_i_struct *p = bdev->bd_disk->private_data;
 
-	if (cmd != HDIO_GETGEO)
-		return -EINVAL;
-	memset(&geom, 0, sizeof(geom));
-	geom.heads = p->head;
-	geom.sectors = p->sect;
-	geom.cylinders = p->cyl;
-	geom.start = get_start_sect(inode->i_bdev);
-	if (copy_to_user((void __user *)arg, &geom, sizeof(geom)))
-		return -EFAULT;
+	geo->heads = p->head;
+	geo->sectors = p->sect;
+	geo->cylinders = p->cyl;
 	return 0;
 }
 
Index: linux-2.6/drivers/block/sx8.c
===================================================================
--- linux-2.6.orig/drivers/block/sx8.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/sx8.c	2005-11-19 20:31:11.000000000 +0100
@@ -407,8 +407,7 @@
 
 static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_ioctl(struct inode *ino, struct file *fil,
-			   unsigned int cmd, unsigned long arg);
+static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static struct pci_device_id carm_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x8000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
@@ -426,7 +425,7 @@
 
 static struct block_device_operations carm_bd_ops = {
 	.owner		= THIS_MODULE,
-	.ioctl		= carm_bdev_ioctl,
+	.getgeo		= carm_bdev_getgeo,
 };
 
 static unsigned int carm_host_id;
@@ -434,32 +433,14 @@
 
 
 
-static int carm_bdev_ioctl(struct inode *ino, struct file *fil,
-			   unsigned int cmd, unsigned long arg)
+static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	void __user *usermem = (void __user *) arg;
-	struct carm_port *port = ino->i_bdev->bd_disk->private_data;
-	struct hd_geometry geom;
-
-	switch (cmd) {
-	case HDIO_GETGEO:
-		if (!usermem)
-			return -EINVAL;
-
-		geom.heads = (u8) port->dev_geom_head;
-		geom.sectors = (u8) port->dev_geom_sect;
-		geom.cylinders = port->dev_geom_cyl;
-		geom.start = get_start_sect(ino->i_bdev);
-
-		if (copy_to_user(usermem, &geom, sizeof(geom)))
-			return -EFAULT;
-		return 0;
+	struct carm_port *port = bdev->bd_disk->private_data;
 
-	default:
-		break;
-	}
-
-	return -EOPNOTSUPP;
+	geo->heads = (u8) port->dev_geom_head;
+	geo->sectors = (u8) port->dev_geom_sect;
+	geo->cylinders = port->dev_geom_cyl;
+	return 0;
 }
 
 static const u32 msg_sizes[] = { 32, 64, 128, CARM_MSG_SIZE };
Index: linux-2.6/drivers/block/umem.c
===================================================================
--- linux-2.6.orig/drivers/block/umem.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/umem.c	2005-11-19 19:52:07.000000000 +0100
@@ -809,34 +809,23 @@
 	set_capacity(disk, card->mm_size << 1);
 	return 0;
 }
-/*
------------------------------------------------------------------------------------
---                            mm_ioctl
------------------------------------------------------------------------------------
-*/
-static int mm_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
+
+static int mm_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	if (cmd == HDIO_GETGEO) {
-		struct cardinfo *card = i->i_bdev->bd_disk->private_data;
-		int size = card->mm_size * (1024 / MM_HARDSECT);
-		struct hd_geometry geo;
-		/*
-		 * get geometry: we have to fake one...  trim the size to a
-		 * multiple of 2048 (1M): tell we have 32 sectors, 64 heads,
-		 * whatever cylinders.
-		 */
-		geo.heads     = 64;
-		geo.sectors   = 32;
-		geo.start     = get_start_sect(i->i_bdev);
-		geo.cylinders = size / (geo.heads * geo.sectors);
-
-		if (copy_to_user((void __user *) arg, &geo, sizeof(geo)))
-			return -EFAULT;
-		return 0;
-	}
+	struct cardinfo *card = bdev->bd_disk->private_data;
+	int size = card->mm_size * (1024 / MM_HARDSECT);
 
-	return -EINVAL;
+	/*
+	 * get geometry: we have to fake one...  trim the size to a
+	 * multiple of 2048 (1M): tell we have 32 sectors, 64 heads,
+	 * whatever cylinders.
+	 */
+	geo->heads     = 64;
+	geo->sectors   = 32;
+	geo->cylinders = size / (geo->heads * geo->sectors);
+	return 0;
 }
+
 /*
 -----------------------------------------------------------------------------------
 --                                mm_check_change
@@ -855,7 +844,7 @@
 */
 static struct block_device_operations mm_fops = {
 	.owner		= THIS_MODULE,
-	.ioctl		= mm_ioctl,
+	.getgeo		= mm_getgeo,
 	.revalidate_disk= mm_revalidate,
 	.media_changed	= mm_check_change,
 };
Index: linux-2.6/drivers/block/viodasd.c
===================================================================
--- linux-2.6.orig/drivers/block/viodasd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/viodasd.c	2005-11-19 21:43:49.000000000 +0100
@@ -247,43 +247,17 @@
 
 /* External ioctl entry point.
  */
-static int viodasd_ioctl(struct inode *ino, struct file *fil,
-			 unsigned int cmd, unsigned long arg)
+static int viodasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	unsigned char sectors;
-	unsigned char heads;
-	unsigned short cylinders;
-	struct hd_geometry *geo;
-	struct gendisk *gendisk;
-	struct viodasd_device *d;
+	struct gendisk *disk = bdev->bd_disk;
+	struct viodasd_device *d = disk->private_data;
 
-	switch (cmd) {
-	case HDIO_GETGEO:
-		geo = (struct hd_geometry *)arg;
-		if (geo == NULL)
-			return -EINVAL;
-		if (!access_ok(VERIFY_WRITE, geo, sizeof(*geo)))
-			return -EFAULT;
-		gendisk = ino->i_bdev->bd_disk;
-		d = gendisk->private_data;
-		sectors = d->sectors;
-		if (sectors == 0)
-			sectors = 32;
-		heads = d->tracks;
-		if (heads == 0)
-			heads = 64;
-		cylinders = d->cylinders;
-		if (cylinders == 0)
-			cylinders = get_capacity(gendisk) / (sectors * heads);
-		if (__put_user(sectors, &geo->sectors) ||
-		    __put_user(heads, &geo->heads) ||
-		    __put_user(cylinders, &geo->cylinders) ||
-		    __put_user(get_start_sect(ino->i_bdev), &geo->start))
-			return -EFAULT;
-		return 0;
-	}
+	geo->sectors = d->sectors ? d->sectors : 0;
+	geo->heads = d->tracks ? d->tracks  : 64;
+	geo->cylinders = d->cylinders ? d->cylinders :
+		get_capacity(disk) / (geo->cylinders * geo->heads);
 
-	return -EINVAL;
+	return 0;
 }
 
 /*
@@ -293,7 +267,7 @@
 	.owner = THIS_MODULE,
 	.open = viodasd_open,
 	.release = viodasd_release,
-	.ioctl = viodasd_ioctl,
+	.getgeo = viodasd_getgeo,
 };
 
 /*
Index: linux-2.6/drivers/block/xd.c
===================================================================
--- linux-2.6.orig/drivers/block/xd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/block/xd.c	2005-11-19 19:52:07.000000000 +0100
@@ -128,9 +128,12 @@
 
 static struct gendisk *xd_gendisk[2];
 
+static int xd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+
 static struct block_device_operations xd_fops = {
 	.owner	= THIS_MODULE,
 	.ioctl	= xd_ioctl,
+	.getgeo = xd_getgeo,
 };
 static DECLARE_WAIT_QUEUE_HEAD(xd_wait_int);
 static u_char xd_drives, xd_irq = 5, xd_dma = 3, xd_maxsectors;
@@ -330,22 +333,22 @@
 	}
 }
 
+static int xd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	XD_INFO *p = bdev->bd_disk->private_data;
+
+	geo->heads = p->heads;
+	geo->sectors = p->sectors;
+	geo->cylinders = p->cylinders;
+	return 0;
+}
+
 /* xd_ioctl: handle device ioctl's */
 static int xd_ioctl (struct inode *inode,struct file *file,u_int cmd,u_long arg)
 {
 	XD_INFO *p = inode->i_bdev->bd_disk->private_data;
 
 	switch (cmd) {
-		case HDIO_GETGEO:
-		{
-			struct hd_geometry g;
-			struct hd_geometry __user *geom= (void __user *)arg;
-			g.heads = p->heads;
-			g.sectors = p->sectors;
-			g.cylinders = p->cylinders;
-			g.start = get_start_sect(inode->i_bdev);
-			return copy_to_user(geom, &g, sizeof(g)) ? -EFAULT : 0;
-		}
 		case HDIO_SET_DMA:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 			if (xdc_busy) return -EBUSY;
Index: linux-2.6/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/ide/ide-disk.c	2005-11-19 19:52:07.000000000 +0100
@@ -1161,6 +1161,17 @@
 	return 0;
 }
 
+static int idedisk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct ide_disk_obj *idkp = ide_disk_g(bdev->bd_disk);
+	ide_drive_t *drive = idkp->drive;
+
+	geo->heads = drive->bios_head;
+	geo->sectors = drive->bios_sect;
+	geo->cylinders = (u16)drive->bios_cyl; /* truncate */
+	return 0;
+}
+
 static int idedisk_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
@@ -1195,6 +1206,7 @@
 	.open		= idedisk_open,
 	.release	= idedisk_release,
 	.ioctl		= idedisk_ioctl,
+	.getgeo		= idedisk_getgeo,
 	.media_changed	= idedisk_media_changed,
 	.revalidate_disk= idedisk_revalidate_disk
 };
Index: linux-2.6/drivers/ide/ide-floppy.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-floppy.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/ide/ide-floppy.c	2005-11-19 19:52:07.000000000 +0100
@@ -2031,6 +2031,17 @@
 	return 0;
 }
 
+static int idefloppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
+	ide_drive_t *drive = floppy->drive;
+
+	geo->heads = drive->bios_head;
+	geo->sectors = drive->bios_sect;
+	geo->cylinders = (u16)drive->bios_cyl; /* truncate */
+	return 0;
+}
+
 static int idefloppy_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
@@ -2120,6 +2131,7 @@
 	.open		= idefloppy_open,
 	.release	= idefloppy_release,
 	.ioctl		= idefloppy_ioctl,
+	.getgeo		= idefloppy_getgeo,
 	.media_changed	= idefloppy_media_changed,
 	.revalidate_disk= idefloppy_revalidate_disk
 };
Index: linux-2.6/drivers/ide/ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/ide/ide.c	2005-11-19 19:52:07.000000000 +0100
@@ -1278,19 +1278,6 @@
 	up(&ide_setting_sem);
 
 	switch (cmd) {
-		case HDIO_GETGEO:
-		{
-			struct hd_geometry geom;
-			if (!p || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
-			geom.heads = drive->bios_head;
-			geom.sectors = drive->bios_sect;
-			geom.cylinders = (u16)drive->bios_cyl; /* truncate */
-			geom.start = get_start_sect(bdev);
-			if (copy_to_user(p, &geom, sizeof(struct hd_geometry)))
-				return -EFAULT;
-			return 0;
-		}
-
 		case HDIO_OBSOLETE_IDENTITY:
 		case HDIO_GET_IDENTITY:
 			if (bdev != bdev->bd_contains)
Index: linux-2.6/drivers/ide/legacy/hd.c
===================================================================
--- linux-2.6.orig/drivers/ide/legacy/hd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/ide/legacy/hd.c	2005-11-19 19:52:07.000000000 +0100
@@ -658,22 +658,14 @@
 	enable_irq(HD_IRQ);
 }
 
-static int hd_ioctl(struct inode * inode, struct file * file,
-	unsigned int cmd, unsigned long arg)
+static int hd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct hd_i_struct *disk = inode->i_bdev->bd_disk->private_data;
-	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
-	struct hd_geometry g; 
-
-	if (cmd != HDIO_GETGEO)
-		return -EINVAL;
-	if (!loc)
-		return -EINVAL;
-	g.heads = disk->head;
-	g.sectors = disk->sect;
-	g.cylinders = disk->cyl;
-	g.start = get_start_sect(inode->i_bdev);
-	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
+	struct hd_i_struct *disk = bdev->bd_disk->private_data;
+
+	geo->heads = disk->head;
+	geo->sectors = disk->sect;
+	geo->cylinders = disk->cyl;
+	return 0;
 }
 
 /*
@@ -695,7 +687,7 @@
 }
 
 static struct block_device_operations hd_fops = {
-	.ioctl =	hd_ioctl,
+	.getgeo =	hd_getgeo,
 };
 
 /*
Index: linux-2.6/drivers/md/md.c
===================================================================
--- linux-2.6.orig/drivers/md/md.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/md/md.c	2005-11-19 19:52:51.000000000 +0100
@@ -3101,12 +3101,21 @@
 	return 0;
 }
 
+static int md_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	mddev_t *mddev = bdev->bd_disk->private_data;
+
+	geo->heads = 2;
+	geo->sectors = 4;
+	geo->cylinders = get_capacity(mddev->gendisk) / 8;
+	return 0;
+}
+
 static int md_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
 	void __user *argp = (void __user *)arg;
-	struct hd_geometry __user *loc = argp;
 	mddev_t *mddev = NULL;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -3268,24 +3277,6 @@
 	 * 4 sectors (with a BIG number of cylinders...). This drives
 	 * dosfs just mad... ;-)
 	 */
-		case HDIO_GETGEO:
-			if (!loc) {
-				err = -EINVAL;
-				goto abort_unlock;
-			}
-			err = put_user (2, (char __user *) &loc->heads);
-			if (err)
-				goto abort_unlock;
-			err = put_user (4, (char __user *) &loc->sectors);
-			if (err)
-				goto abort_unlock;
-			err = put_user(get_capacity(mddev->gendisk)/8,
-					(short __user *) &loc->cylinders);
-			if (err)
-				goto abort_unlock;
-			err = put_user (get_start_sect(inode->i_bdev),
-						(long __user *) &loc->start);
-			goto done_unlock;
 	}
 
 	/*
@@ -3414,6 +3405,7 @@
 	.open		= md_open,
 	.release	= md_release,
 	.ioctl		= md_ioctl,
+	.getgeo		= md_getgeo,
 	.media_changed	= md_media_changed,
 	.revalidate_disk= md_revalidate,
 };
Index: linux-2.6/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_block.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/message/i2o/i2o_block.c	2005-11-19 20:32:03.000000000 +0100
@@ -660,6 +660,13 @@
 	return 0;
 }
 
+static int i2o_block_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	i2o_block_biosparam(get_capacity(bdev->bd_disk),
+			    &geo->cylinders, &geo->heads, &geo->sectors);
+	return 0;
+}
+
 /**
  *	i2o_block_ioctl - Issue device specific ioctl calls.
  *	@cmd: ioctl command
@@ -674,7 +681,6 @@
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct i2o_block_device *dev = disk->private_data;
-	void __user *argp = (void __user *)arg;
 
 	/* Anyone capable of this syscall can do *real bad* things */
 
@@ -682,15 +688,6 @@
 		return -EPERM;
 
 	switch (cmd) {
-	case HDIO_GETGEO:
-		{
-			struct hd_geometry g;
-			i2o_block_biosparam(get_capacity(disk),
-					    &g.cylinders, &g.heads, &g.sectors);
-			g.start = get_start_sect(inode->i_bdev);
-			return copy_to_user(argp, &g, sizeof(g)) ? -EFAULT : 0;
-		}
-
 	case BLKI2OGRSTRAT:
 		return put_user(dev->rcache, (int __user *)arg);
 	case BLKI2OGWSTRAT:
@@ -959,6 +956,7 @@
 	.open = i2o_block_open,
 	.release = i2o_block_release,
 	.ioctl = i2o_block_ioctl,
+	.getgeo = i2o_block_getgeo,
 	.media_changed = i2o_block_media_changed
 };
 
Index: linux-2.6/drivers/mmc/mmc_block.c
===================================================================
--- linux-2.6.orig/drivers/mmc/mmc_block.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/mmc/mmc_block.c	2005-11-19 19:52:07.000000000 +0100
@@ -119,31 +119,18 @@
 }
 
 static int
-mmc_blk_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct block_device *bdev = inode->i_bdev;
-
-	if (cmd == HDIO_GETGEO) {
-		struct hd_geometry geo;
-
-		memset(&geo, 0, sizeof(struct hd_geometry));
-
-		geo.cylinders	= get_capacity(bdev->bd_disk) / (4 * 16);
-		geo.heads	= 4;
-		geo.sectors	= 16;
-		geo.start	= get_start_sect(bdev);
-
-		return copy_to_user((void __user *)arg, &geo, sizeof(geo))
-			? -EFAULT : 0;
-	}
-
-	return -ENOTTY;
+	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
+	geo->heads = 4;
+	geo->sectors = 16;
+	return 0;
 }
 
 static struct block_device_operations mmc_bdops = {
 	.open			= mmc_blk_open,
 	.release		= mmc_blk_release,
-	.ioctl			= mmc_blk_ioctl,
+	.getgeo			= mmc_blk_getgeo,
 	.owner			= THIS_MODULE,
 };
 
Index: linux-2.6/drivers/mtd/mtd_blkdevs.c
===================================================================
--- linux-2.6.orig/drivers/mtd/mtd_blkdevs.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/mtd/mtd_blkdevs.c	2005-11-19 20:32:25.000000000 +0100
@@ -194,6 +194,14 @@
 	return ret;
 }
 
+static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
+
+	if (dev->tr->getgeo)
+		return dev->tr->getgeo(dev, geo);
+	return -ENOTTY;
+}
 
 static int blktrans_ioctl(struct inode *inode, struct file *file,
 			      unsigned int cmd, unsigned long arg)
@@ -207,22 +215,6 @@
 			return tr->flush(dev);
 		/* The core code did the work, we had nothing to do. */
 		return 0;
-
-	case HDIO_GETGEO:
-		if (tr->getgeo) {
-			struct hd_geometry g;
-			int ret;
-
-			memset(&g, 0, sizeof(g));
-			ret = tr->getgeo(dev, &g);
-			if (ret)
-				return ret;
-
-			g.start = get_start_sect(inode->i_bdev);
-			if (copy_to_user((void __user *)arg, &g, sizeof(g)))
-				return -EFAULT;
-			return 0;
-		} /* else */
 	default:
 		return -ENOTTY;
 	}
@@ -233,6 +225,7 @@
 	.open		= blktrans_open,
 	.release	= blktrans_release,
 	.ioctl		= blktrans_ioctl,
+	.getgeo		= blktrans_getgeo,
 };
 
 int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
Index: linux-2.6/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd.c	2005-11-19 19:52:07.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/hdreg.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -1717,12 +1718,34 @@
 	return 0;
 }
 
+/*
+ * Return disk geometry.
+ */
+static int
+dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct dasd_device *device;
+
+	device = bdev->bd_disk->private_data;
+	if (!device)
+		return -ENODEV;
+
+	if (!device->discipline ||
+	    !device->discipline->fill_geometry)
+		return -EINVAL;
+
+	device->discipline->fill_geometry(device, geo);
+	geo->start = get_start_sect(bdev) >> device->s2b_shift;
+	return 0;
+}
+
 struct block_device_operations
 dasd_device_operations = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_open,
 	.release	= dasd_release,
 	.ioctl		= dasd_ioctl,
+	.getgeo		= dasd_getgeo,
 };
 
 
Index: linux-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_ioctl.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/s390/block/dasd_ioctl.c	2005-11-19 19:52:07.000000000 +0100
@@ -483,33 +483,6 @@
 }
 
 /*
- * Return disk geometry.
- */
-static int
-dasd_ioctl_getgeo(struct block_device *bdev, int no, long args)
-{
-	struct hd_geometry geo = { 0, };
-	struct dasd_device *device;
-
-	device =  bdev->bd_disk->private_data;
-	if (device == NULL)
-		return -ENODEV;
-
-	if (device == NULL || device->discipline == NULL ||
-	    device->discipline->fill_geometry == NULL)
-		return -EINVAL;
-
-	geo = (struct hd_geometry) {};
-	device->discipline->fill_geometry(device, &geo);
-	geo.start = get_start_sect(bdev) >> device->s2b_shift;
-	if (copy_to_user((struct hd_geometry __user *) args, &geo,
-			 sizeof (struct hd_geometry)))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
  * List of static ioctls.
  */
 static struct { int no; dasd_ioctl_fn_t fn; } dasd_ioctls[] =
@@ -525,7 +498,6 @@
 	{ BIODASDPRRST, dasd_ioctl_reset_profile },
 	{ BLKROSET, dasd_ioctl_set_ro },
 	{ DASDAPIVER, dasd_ioctl_api_version },
-	{ HDIO_GETGEO, dasd_ioctl_getgeo },
 	{ -1, NULL }
 };
 
Index: linux-2.6/drivers/s390/block/xpram.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/xpram.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/s390/block/xpram.c	2005-11-19 19:52:07.000000000 +0100
@@ -328,31 +328,27 @@
 	return 0;
 }
 
-static int xpram_ioctl (struct inode *inode, struct file *filp,
-		 unsigned int cmd, unsigned long arg)
+static int xpram_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct hd_geometry __user *geo;
 	unsigned long size;
-	if (cmd != HDIO_GETGEO)
-		return -EINVAL;
+
 	/*
 	 * get geometry: we have to fake one...  trim the size to a
 	 * multiple of 64 (32k): tell we have 16 sectors, 4 heads,
 	 * whatever cylinders. Tell also that data starts at sector. 4.
 	 */
-	geo = (struct hd_geometry __user *) arg;
 	size = (xpram_pages * 8) & ~0x3f;
-	put_user(size >> 6, &geo->cylinders);
-	put_user(4, &geo->heads);
-	put_user(16, &geo->sectors);
-	put_user(4, &geo->start);
+	geo->cylinders = size >> 6;
+	geo->heads = 4;
+	geo->sectors = 16;
+	geo->start = 4;
 	return 0;
 }
 
 static struct block_device_operations xpram_devops =
 {
 	.owner	= THIS_MODULE,
-	.ioctl	= xpram_ioctl,
+	.getgeo	= xpram_getgeo,
 };
 
 /*
Index: linux-2.6/drivers/scsi/sd.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sd.c	2005-11-19 19:51:41.000000000 +0100
+++ linux-2.6/drivers/scsi/sd.c	2005-11-19 19:52:07.000000000 +0100
@@ -530,7 +530,7 @@
 	return 0;
 }
 
-static int sd_hdio_getgeo(struct block_device *bdev, struct hd_geometry __user *loc)
+static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
 	struct scsi_device *sdp = sdkp->device;
@@ -548,15 +548,9 @@
 	else
 		scsicam_bios_param(bdev, sdkp->capacity, diskinfo);
 
-	if (put_user(diskinfo[0], &loc->heads))
-		return -EFAULT;
-	if (put_user(diskinfo[1], &loc->sectors))
-		return -EFAULT;
-	if (put_user(diskinfo[2], &loc->cylinders))
-		return -EFAULT;
-	if (put_user((unsigned)get_start_sect(bdev),
-	             (unsigned long __user *)&loc->start))
-		return -EFAULT;
+	geo->heads = diskinfo[0];
+	geo->sectors = diskinfo[1];
+	geo->cylinders = diskinfo[2];
 	return 0;
 }
 
@@ -596,12 +590,6 @@
 	if (!scsi_block_when_processing_errors(sdp) || !error)
 		return error;
 
-	if (cmd == HDIO_GETGEO) {
-		if (!arg)
-			return -EINVAL;
-		return sd_hdio_getgeo(bdev, p);
-	}
-
 	/*
 	 * Send SCSI addressing ioctls directly to mid level, send other
 	 * ioctls to block level and then onto mid level if they can't be
@@ -832,6 +820,7 @@
 	.open			= sd_open,
 	.release		= sd_release,
 	.ioctl			= sd_ioctl,
+	.getgeo			= sd_getgeo,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= sd_compat_ioctl,
 #endif
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h	2005-11-19 19:51:58.000000000 +0100
+++ linux-2.6/include/linux/fs.h	2005-11-19 19:52:07.000000000 +0100
@@ -225,6 +225,7 @@
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
+struct hd_geometry;
 struct iovec;
 struct nameidata;
 struct kiocb;
@@ -932,6 +933,7 @@
 	int (*direct_access) (struct block_device *, sector_t, unsigned long *);
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
+	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	struct module *owner;
 };
 
