Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268649AbUHLS3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268649AbUHLS3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUHLS3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:29:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40369 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268649AbUHLS3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:29:21 -0400
Date: Thu, 12 Aug 2004 20:29:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812182914.GA16953@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <20040812173532.GD5136@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812173532.GD5136@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2004, Jens Axboe wrote:
> On Thu, Aug 12 2004, Linus Torvalds wrote:
> > 
> > 
> > On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > > 
> > > Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> > 
> > Btw, I think the _right_ thing to check is the write access of the file 
> > descriptor. If you have write access to a block device, you can delete the 
> > data, so you might as well be able to do the raw commands. And that would 
> > allow things like "disk" groups etc to work and burn CD's.
> > 
> > However, right now we don't even pass down the "struct file" to this 
> > function. We probably should. Anybody willing to go through the callers? 
> > (just a few callers, but things like cdrom_command() doesn't even have the 
> > file, so it has to be recursive).
> 
> Precisely, I guess that's a 2.6.9 job then. CDROM_SEND_PACKET works
> directly on top of SG_IO now, so should just work as long as sg_io() is
> translated.
> 
> I have no problem going over this, if somebody beats me to it, fine.
> I'll be gone on vacation next week.

Here's a much better and more complete patch, imho, and doing it was no
more than 20 minutes. It struck me while doing this that you could
possibly get around just checking the data direction given in the
sg_io_hdr. The advantage of that would be that you don't need a command
table at all, the disadvantage is that it would still be possible for a
given user with read-only access to a device to possibly confuse the
device and/or cause bus resets. So it probably wont work. I added it as
an extra check, though.

The table is as complete as cdrom.h is, plus the 6 and 16 byte variants
from scsi.h. There are still commands missing, they can be added along
the way though. Patch is compile tested.

===== drivers/block/scsi_ioctl.c 1.50 vs edited =====
--- 1.50/drivers/block/scsi_ioctl.c	2004-08-12 18:43:03 +02:00
+++ edited/drivers/block/scsi_ioctl.c	2004-08-12 20:22:08 +02:00
@@ -105,8 +105,56 @@
 	return put_user(1, p);
 }
 
+static int sg_allowed_cmd(unsigned char opcode, int may_write)
+{
+	if (capable(CAP_SYS_RAWIO))
+		return 1;
+	if (may_write)
+		return 1;
+
+	switch (opcode) {
+		case GPCMD_GET_CONFIGURATION:
+		case GPCMD_GET_EVENT_STATUS_NOTIFICATION:
+		case GPCMD_GET_PERFORMANCE:
+		case GPCMD_INQUIRY:
+		case GPCMD_MECHANISM_STATUS:
+		case MODE_SENSE:
+		case LOG_SENSE:
+		case GPCMD_MODE_SENSE_10:
+		case GPCMD_PLAY_AUDIO_10:
+		case GPCMD_PLAY_AUDIO_MSF:
+		case GPCMD_PLAY_AUDIO_TI:
+		case GPCMD_PLAY_CD:
+		case READ_6:
+		case GPCMD_READ_10:
+		case GPCMD_READ_12:
+		case READ_16:
+		case GPCMD_READ_CDVD_CAPACITY:
+		case GPCMD_READ_CD:
+		case GPCMD_READ_CD_MSF:
+		case GPCMD_READ_DISC_INFO:
+		case GPCMD_READ_DVD_STRUCTURE:
+		case GPCMD_READ_HEADER:
+		case GPCMD_READ_TRACK_RZONE_INFO:
+		case GPCMD_READ_SUBCHANNEL:
+		case GPCMD_READ_TOC_PMA_ATIP:
+		case GPCMD_REPORT_KEY:
+		case GPCMD_REQUEST_SENSE:
+		case GPCMD_SCAN:
+		case GPCMD_SEEK:
+		case GPCMD_START_STOP_UNIT:
+		case GPCMD_STOP_PLAY_SCAN:
+		case GPCMD_TEST_UNIT_READY:
+		case GPCMD_VERIFY_10:
+		case READ_BUFFER:
+			return 1;
+		default:
+			return 0;
+	}
+}
+
 static int sg_io(request_queue_t *q, struct gendisk *bd_disk,
-		 struct sg_io_hdr *hdr)
+		 struct sg_io_hdr *hdr, int may_write)
 {
 	unsigned long start_time;
 	int reading, writing;
@@ -115,14 +163,14 @@
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	unsigned char cmd[BLK_MAX_CDB];
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
+	if (!sg_allowed_cmd(cmd[0], may_write))
+		return -EPERM;
 
 	/*
 	 * we'll do that later
@@ -149,6 +197,9 @@
 			break;
 		}
 
+		if (writing && !may_write)
+			return -EPERM;
+
 		rq = blk_rq_map_user(q, writing ? WRITE : READ, hdr->dxferp,
 				     hdr->dxfer_len);
 
@@ -229,14 +280,12 @@
 #define OMAX_SB_LEN 16          /* For backward compatibility */
 
 static int sg_scsi_ioctl(request_queue_t *q, struct gendisk *bd_disk,
-			 Scsi_Ioctl_Command __user *sic)
+			 Scsi_Ioctl_Command __user *sic, int may_write)
 {
 	struct request *rq;
 	int err, in_len, out_len, bytes, opcode, cmdlen;
 	char *buffer = NULL, sense[SCSI_SENSE_BUFFERSIZE];
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
 	/*
 	 * get in an out lengths, verify they don't exceed a page worth of data
 	 */
@@ -323,8 +372,10 @@
 	return err;
 }
 
-int scsi_cmd_ioctl(struct gendisk *bd_disk, unsigned int cmd, void __user *arg)
+int scsi_cmd_ioctl(struct gendisk *bd_disk, struct file *file, unsigned int cmd,
+		   void __user *arg)
 {
+	int may_write = file->f_flags & FMODE_WRITE;
 	request_queue_t *q;
 	struct request *rq;
 	int close = 0, err;
@@ -370,7 +421,7 @@
 			err = -EFAULT;
 			if (copy_from_user(&hdr, arg, sizeof(hdr)))
 				break;
-			err = sg_io(q, bd_disk, &hdr);
+			err = sg_io(q, bd_disk, &hdr, may_write);
 			if (err == -EFAULT)
 				break;
 
@@ -418,7 +469,7 @@
 			hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
 			hdr.cmd_len = sizeof(cgc.cmd);
 
-			err = sg_io(q, bd_disk, &hdr);
+			err = sg_io(q, bd_disk, &hdr, may_write);
 			if (err == -EFAULT)
 				break;
 
@@ -441,7 +492,7 @@
 			if (!arg)
 				break;
 
-			err = sg_scsi_ioctl(q, bd_disk, arg);
+			err = sg_scsi_ioctl(q, bd_disk, arg, may_write);
 			break;
 		case CDROMCLOSETRAY:
 			close = 1;
===== drivers/block/paride/pcd.c 1.38 vs edited =====
--- 1.38/drivers/block/paride/pcd.c	2004-07-12 10:01:05 +02:00
+++ edited/drivers/block/paride/pcd.c	2004-08-12 20:26:39 +02:00
@@ -259,7 +259,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&cd->info, inode, cmd, arg);
+	return cdrom_ioctl(&cd->info, inode, file, cmd, arg);
 }
 
 static int pcd_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/cdrom.c 1.65 vs edited =====
--- 1.65/drivers/cdrom/cdrom.c	2004-08-08 08:43:40 +02:00
+++ edited/drivers/cdrom/cdrom.c	2004-08-12 20:23:06 +02:00
@@ -2073,13 +2073,14 @@
  * mmc_ioct().
  */
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct inode *ip,
-		unsigned int cmd, unsigned long arg)
+		struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
+	struct gendisk *disk = ip->i_bdev->bd_disk;
 	int ret;
 
 	/* Try the generic SCSI command ioctl's first.. */
-	ret = scsi_cmd_ioctl(ip->i_bdev->bd_disk, cmd, (void __user *)arg);
+	ret = scsi_cmd_ioctl(disk, file, cmd, (void __user *) arg);
 	if (ret != -ENOTTY)
 		return ret;
 
===== drivers/cdrom/cdu31a.c 1.42 vs edited =====
--- 1.42/drivers/cdrom/cdu31a.c	2004-06-04 01:05:29 +02:00
+++ edited/drivers/cdrom/cdu31a.c	2004-08-12 20:12:01 +02:00
@@ -3179,7 +3179,7 @@
 static int scd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&scd_info, inode, cmd, arg);
+	return cdrom_ioctl(&scd_info, inode, file, cmd, arg);
 }
 
 static int scd_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/cm206.c 1.37 vs edited =====
--- 1.37/drivers/cdrom/cm206.c	2004-03-16 11:29:43 +01:00
+++ edited/drivers/cdrom/cm206.c	2004-08-12 20:12:01 +02:00
@@ -1363,7 +1363,7 @@
 static int cm206_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&cm206_info, inode, cmd, arg);
+	return cdrom_ioctl(&cm206_info, inode, file, cmd, arg);
 }
 
 static int cm206_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/mcd.c 1.35 vs edited =====
--- 1.35/drivers/cdrom/mcd.c	2003-09-04 08:40:13 +02:00
+++ edited/drivers/cdrom/mcd.c	2004-08-12 20:12:01 +02:00
@@ -227,7 +227,7 @@
 static int mcd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&mcd_info, inode, cmd, arg);
+	return cdrom_ioctl(&mcd_info, inode, file, cmd, arg);
 }
 
 static int mcd_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/mcdx.c 1.37 vs edited =====
--- 1.37/drivers/cdrom/mcdx.c	2004-07-14 14:18:48 +02:00
+++ edited/drivers/cdrom/mcdx.c	2004-08-12 20:12:01 +02:00
@@ -233,7 +233,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&p->info, inode, cmd, arg);
+	return cdrom_ioctl(&p->info, inode, file, cmd, arg);
 }
 
 static int mcdx_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/sbpcd.c 1.52 vs edited =====
--- 1.52/drivers/cdrom/sbpcd.c	2004-08-02 10:00:45 +02:00
+++ edited/drivers/cdrom/sbpcd.c	2004-08-12 20:12:01 +02:00
@@ -5372,7 +5372,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(p->sbpcd_infop, inode, cmd, arg);
+	return cdrom_ioctl(p->sbpcd_infop, inode, file, cmd, arg);
 }
 
 static int sbpcd_block_media_changed(struct gendisk *disk)
===== drivers/cdrom/viocd.c 1.6 vs edited =====
--- 1.6/drivers/cdrom/viocd.c	2004-06-29 16:44:46 +02:00
+++ edited/drivers/cdrom/viocd.c	2004-08-12 20:12:01 +02:00
@@ -199,7 +199,7 @@
 		unsigned cmd, unsigned long arg)
 {
 	struct disk_info *di = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&di->viocd_info, inode, cmd, arg);
+	return cdrom_ioctl(&di->viocd_info, inode, file, cmd, arg);
 }
 
 static int viocd_blk_media_changed(struct gendisk *disk)
===== drivers/ide/ide-cd.c 1.88 vs edited =====
--- 1.88/drivers/ide/ide-cd.c	2004-08-03 08:10:56 +02:00
+++ edited/drivers/ide/ide-cd.c	2004-08-12 20:12:01 +02:00
@@ -3395,10 +3395,10 @@
 {
 	struct block_device *bdev = inode->i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
-	int err = generic_ide_ioctl(bdev, cmd, arg);
+	int err = generic_ide_ioctl(bdev, file, cmd, arg);
 	if (err == -EINVAL) {
 		struct cdrom_info *info = drive->driver_data;
-		err = cdrom_ioctl(&info->devinfo, inode, cmd, arg);
+		err = cdrom_ioctl(&info->devinfo, inode, file, cmd, arg);
 	}
 	return err;
 }
===== drivers/ide/ide-disk.c 1.87 vs edited =====
--- 1.87/drivers/ide/ide-disk.c	2004-06-25 18:49:26 +02:00
+++ edited/drivers/ide/ide-disk.c	2004-08-12 20:12:01 +02:00
@@ -1668,7 +1668,7 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	return generic_ide_ioctl(bdev, cmd, arg);
+	return generic_ide_ioctl(bdev, file, cmd, arg);
 }
 
 static int idedisk_media_changed(struct gendisk *disk)
===== drivers/ide/ide-floppy.c 1.39 vs edited =====
--- 1.39/drivers/ide/ide-floppy.c	2004-06-04 06:12:07 +02:00
+++ edited/drivers/ide/ide-floppy.c	2004-08-12 20:12:01 +02:00
@@ -1946,7 +1946,7 @@
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(bdev, cmd, arg);
+	int err = generic_ide_ioctl(bdev, file, cmd, arg);
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
 	if (err != -EINVAL)
===== drivers/ide/ide-tape.c 1.42 vs edited =====
--- 1.42/drivers/ide/ide-tape.c	2004-08-08 04:07:36 +02:00
+++ edited/drivers/ide/ide-tape.c	2004-08-12 20:12:01 +02:00
@@ -4807,7 +4807,7 @@
 {
 	struct block_device *bdev = inode->i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
-	int err = generic_ide_ioctl(bdev, cmd, arg);
+	int err = generic_ide_ioctl(bdev, file, cmd, arg);
 	if (err == -EINVAL)
 		err = idetape_blkdev_ioctl(drive, cmd, arg);
 	return err;
===== drivers/ide/ide.c 1.151 vs edited =====
--- 1.151/drivers/ide/ide.c	2004-06-30 18:22:19 +02:00
+++ edited/drivers/ide/ide.c	2004-08-12 20:23:35 +02:00
@@ -1453,8 +1453,8 @@
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
 
-int generic_ide_ioctl(struct block_device *bdev, unsigned int cmd,
-			unsigned long arg)
+int generic_ide_ioctl(struct block_device *bdev, struct file *file,
+			unsigned int cmd, unsigned long arg)
 {
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	ide_settings_t *setting;
@@ -1603,9 +1603,15 @@
 			return 0;
 		}
 
+		/*
+		 * should just be moved on top and passed first for all
+		 * cmds (needs to be for ide-tape/floppy to work anyways),
+		 * would need to check that there are no overlapping ioctls
+		 * between scsi and ide first
+		 */
 		case CDROMEJECT:
 		case CDROMCLOSETRAY:
-			return scsi_cmd_ioctl(bdev->bd_disk, cmd, p);
+			return scsi_cmd_ioctl(bdev->bd_disk, file, cmd, p);
 
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
===== drivers/scsi/ide-scsi.c 1.42 vs edited =====
--- 1.42/drivers/scsi/ide-scsi.c	2004-06-18 19:06:33 +02:00
+++ edited/drivers/scsi/ide-scsi.c	2004-08-12 20:20:33 +02:00
@@ -735,7 +735,7 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	return generic_ide_ioctl(bdev, cmd, arg);
+	return generic_ide_ioctl(bdev, file, cmd, arg);
 }
 
 static struct block_device_operations idescsi_ops = {
===== drivers/scsi/sd.c 1.154 vs edited =====
--- 1.154/drivers/scsi/sd.c	2004-06-19 16:38:40 +02:00
+++ edited/drivers/scsi/sd.c	2004-08-12 20:24:06 +02:00
@@ -594,7 +594,7 @@
 		case SCSI_IOCTL_GET_BUS_NUMBER:
 			return scsi_ioctl(sdp, cmd, p);
 		default:
-			error = scsi_cmd_ioctl(disk, cmd, p);
+			error = scsi_cmd_ioctl(disk, filp, cmd, p);
 			if (error != -ENOTTY)
 				return error;
 	}
===== drivers/scsi/sr.c 1.113 vs edited =====
--- 1.113/drivers/scsi/sr.c	2004-07-15 22:29:34 +02:00
+++ edited/drivers/scsi/sr.c	2004-08-12 20:21:09 +02:00
@@ -504,7 +504,7 @@
                 case SCSI_IOCTL_GET_BUS_NUMBER:
                         return scsi_ioctl(sdev, cmd, (void __user *)arg);
 	}
-	return cdrom_ioctl(&cd->cdi, inode, cmd, arg);
+	return cdrom_ioctl(&cd->cdi, inode, file, cmd, arg);
 }
 
 static int sr_block_media_changed(struct gendisk *disk)
===== drivers/scsi/st.c 1.92 vs edited =====
--- 1.92/drivers/scsi/st.c	2004-08-08 04:07:36 +02:00
+++ edited/drivers/scsi/st.c	2004-08-12 20:22:42 +02:00
@@ -3408,7 +3408,7 @@
 		case SCSI_IOCTL_GET_BUS_NUMBER:
 			break;
 		default:
-			i = scsi_cmd_ioctl(STp->disk, cmd_in, p);
+			i = scsi_cmd_ioctl(STp->disk, file, cmd_in, p);
 			if (i != -ENOTTY)
 				return i;
 			break;
===== include/linux/blkdev.h 1.149 vs edited =====
--- 1.149/include/linux/blkdev.h	2004-08-03 08:10:56 +02:00
+++ edited/include/linux/blkdev.h	2004-08-12 20:21:28 +02:00
@@ -517,7 +517,7 @@
 extern void blk_recount_segments(request_queue_t *, struct bio *);
 extern int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
-extern int scsi_cmd_ioctl(struct gendisk *, unsigned int, void __user *);
+extern int scsi_cmd_ioctl(struct gendisk *, struct file *, unsigned int, void __user *);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
 extern void __blk_stop_queue(request_queue_t *q);
===== include/linux/cdrom.h 1.20 vs edited =====
--- 1.20/include/linux/cdrom.h	2004-06-04 06:18:16 +02:00
+++ edited/include/linux/cdrom.h	2004-08-12 20:12:01 +02:00
@@ -985,7 +985,7 @@
 			struct file *fp);
 extern int cdrom_release(struct cdrom_device_info *cdi, struct file *fp);
 extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct inode *ip,
-		unsigned int cmd, unsigned long arg);
+		struct file *file, unsigned int cmd, unsigned long arg);
 extern int cdrom_media_changed(struct cdrom_device_info *);
 
 extern int register_cdrom(struct cdrom_device_info *cdi);
===== include/linux/ide.h 1.127 vs edited =====
--- 1.127/include/linux/ide.h	2004-06-19 03:03:39 +02:00
+++ edited/include/linux/ide.h	2004-08-12 20:12:01 +02:00
@@ -1194,7 +1194,7 @@
 
 #define DRIVER(drive)		((drive)->driver)
 
-extern int generic_ide_ioctl(struct block_device *, unsigned, unsigned long);
+extern int generic_ide_ioctl(struct block_device *, struct file *, unsigned, unsigned long);
 
 /*
  * ide_hwifs[] is the master data structure used to keep track

-- 
Jens Axboe

