Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVEVL40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVEVL40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVEVL40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:56:26 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:13519 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261358AbVEVLz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:55:58 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Fix root hole in raw device
References: <11163046682662@kroah.com> <11163046681444@kroah.com>
	<20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk>
	<1116335082.1963.58.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050517165353.GB29811@parcelfarce.linux.theplanet.co.uk>
From: Peter Osterlund <petero2@telia.com>
Date: 22 May 2005 13:55:10 +0200
In-Reply-To: <20050517165353.GB29811@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m3ekbz79wh.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:

> On Tue, May 17, 2005 at 02:04:42PM +0100, Stephen C. Tweedie wrote:
> > 
> > On Tue, 2005-05-17 at 05:57, Al Viro wrote:
> > 
> > > That is not quite correct.  You are passing very odd filp to ->ioctl()...
> > > Old variant gave NULL, which is also not too nice, though.
> > 
> > Which would you prefer?  I guess that if there _are_ going to be
> > problems, we'd be better off finding them early by passing in the NULL
> > value.
> 
> For now I'd rather pass NULL.  Longer term (== post 2.6.12, since There Is No
> 2.7(tm)) - just remove the struct file * argument of bdev ioctl and have
> int flags used instead, with "opened for write" and "opened non-blocking"
> passed in it.  And switch the inode argument to bdev...

Switching the inode argument to bdev would first require doing the
same switch in cdrom_ioctl(), which the patch below does.

-
This patch changes cdrom_ioctl() to take a struct block_device pointer
instead of a struct inode pointer.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/paride/pcd.c |    2 +-
 linux-petero/drivers/cdrom/cdrom.c      |    6 +++---
 linux-petero/drivers/cdrom/cdu31a.c     |    2 +-
 linux-petero/drivers/cdrom/cm206.c      |    2 +-
 linux-petero/drivers/cdrom/mcdx.c       |    2 +-
 linux-petero/drivers/cdrom/sbpcd.c      |    2 +-
 linux-petero/drivers/cdrom/viocd.c      |    2 +-
 linux-petero/drivers/ide/ide-cd.c       |    2 +-
 linux-petero/drivers/scsi/sr.c          |    2 +-
 linux-petero/include/linux/cdrom.h      |    2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff -puN drivers/block/paride/pcd.c~cdrom_ioctl_use_bdev drivers/block/paride/pcd.c
--- linux/drivers/block/paride/pcd.c~cdrom_ioctl_use_bdev	2005-05-22 11:05:25.000000000 +0200
+++ linux-petero/drivers/block/paride/pcd.c	2005-05-22 12:47:07.000000000 +0200
@@ -239,7 +239,7 @@ static int pcd_block_ioctl(struct inode 
 				unsigned cmd, unsigned long arg)
 {
 	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &cd->info, inode, cmd, arg);
+	return cdrom_ioctl(file, &cd->info, inode->i_bdev, cmd, arg);
 }
 
 static int pcd_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/cdrom.c~cdrom_ioctl_use_bdev drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~cdrom_ioctl_use_bdev	2005-05-22 10:58:31.000000000 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2005-05-22 10:59:59.000000000 +0200
@@ -2196,13 +2196,13 @@ retry:
  * mmc_ioct().
  */
 int cdrom_ioctl(struct file * file, struct cdrom_device_info *cdi,
-		struct inode *ip, unsigned int cmd, unsigned long arg)
+		struct block_device *bdev, unsigned int cmd, unsigned long arg)
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
 	int ret;
 
 	/* Try the generic SCSI command ioctl's first.. */
-	ret = scsi_cmd_ioctl(file, ip->i_bdev->bd_disk, cmd, (void __user *)arg);
+	ret = scsi_cmd_ioctl(file, bdev->bd_disk, cmd, (void __user *)arg);
 	if (ret != -ENOTTY)
 		return ret;
 
@@ -2355,7 +2355,7 @@ int cdrom_ioctl(struct file * file, stru
 		cdinfo(CD_DO_IOCTL, "entering CDROM_RESET\n");
 		if (!CDROM_CAN(CDC_RESET))
 			return -ENOSYS;
-		invalidate_bdev(ip->i_bdev, 0);
+		invalidate_bdev(bdev, 0);
 		return cdo->reset(cdi);
 		}
 
diff -puN drivers/cdrom/cdu31a.c~cdrom_ioctl_use_bdev drivers/cdrom/cdu31a.c
--- linux/drivers/cdrom/cdu31a.c~cdrom_ioctl_use_bdev	2005-05-22 11:04:28.000000000 +0200
+++ linux-petero/drivers/cdrom/cdu31a.c	2005-05-22 12:47:07.000000000 +0200
@@ -2937,7 +2937,7 @@ static int scd_block_ioctl(struct inode 
 			retval = scd_tray_move(&scd_info, 0);
 			break;
 		default:
-			retval = cdrom_ioctl(file, &scd_info, inode, cmd, arg);
+			retval = cdrom_ioctl(file, &scd_info, inode->i_bdev, cmd, arg);
 	}
 	return retval;
 }
diff -puN drivers/cdrom/cm206.c~cdrom_ioctl_use_bdev drivers/cdrom/cm206.c
--- linux/drivers/cdrom/cm206.c~cdrom_ioctl_use_bdev	2005-05-22 11:05:04.000000000 +0200
+++ linux-petero/drivers/cdrom/cm206.c	2005-05-22 12:47:07.000000000 +0200
@@ -1363,7 +1363,7 @@ static int cm206_block_release(struct in
 static int cm206_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(file, &cm206_info, inode, cmd, arg);
+	return cdrom_ioctl(file, &cm206_info, inode->i_bdev, cmd, arg);
 }
 
 static int cm206_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/mcdx.c~cdrom_ioctl_use_bdev drivers/cdrom/mcdx.c
--- linux/drivers/cdrom/mcdx.c~cdrom_ioctl_use_bdev	2005-05-22 11:03:49.000000000 +0200
+++ linux-petero/drivers/cdrom/mcdx.c	2005-05-22 12:47:07.000000000 +0200
@@ -228,7 +228,7 @@ static int mcdx_block_ioctl(struct inode
 				unsigned cmd, unsigned long arg)
 {
 	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &p->info, inode, cmd, arg);
+	return cdrom_ioctl(file, &p->info, inode->i_bdev, cmd, arg);
 }
 
 static int mcdx_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/sbpcd.c~cdrom_ioctl_use_bdev drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c~cdrom_ioctl_use_bdev	2005-05-22 11:05:10.000000000 +0200
+++ linux-petero/drivers/cdrom/sbpcd.c	2005-05-22 12:47:07.000000000 +0200
@@ -5373,7 +5373,7 @@ static int sbpcd_block_ioctl(struct inod
 				unsigned cmd, unsigned long arg)
 {
 	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, p->sbpcd_infop, inode, cmd, arg);
+	return cdrom_ioctl(file, p->sbpcd_infop, inode->i_bdev, cmd, arg);
 }
 
 static int sbpcd_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/viocd.c~cdrom_ioctl_use_bdev drivers/cdrom/viocd.c
--- linux/drivers/cdrom/viocd.c~cdrom_ioctl_use_bdev	2005-05-22 11:04:56.000000000 +0200
+++ linux-petero/drivers/cdrom/viocd.c	2005-05-22 12:47:07.000000000 +0200
@@ -201,7 +201,7 @@ static int viocd_blk_ioctl(struct inode 
 		unsigned cmd, unsigned long arg)
 {
 	struct disk_info *di = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &di->viocd_info, inode, cmd, arg);
+	return cdrom_ioctl(file, &di->viocd_info, inode->i_bdev, cmd, arg);
 }
 
 static int viocd_blk_media_changed(struct gendisk *disk)
diff -puN drivers/ide/ide-cd.c~cdrom_ioctl_use_bdev drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c~cdrom_ioctl_use_bdev	2005-05-22 11:01:21.000000000 +0200
+++ linux-petero/drivers/ide/ide-cd.c	2005-05-22 12:47:07.000000000 +0200
@@ -3384,7 +3384,7 @@ static int idecd_ioctl (struct inode *in
 
 	err  = generic_ide_ioctl(info->drive, file, bdev, cmd, arg);
 	if (err == -EINVAL)
-		err = cdrom_ioctl(file, &info->devinfo, inode, cmd, arg);
+		err = cdrom_ioctl(file, &info->devinfo, inode->i_bdev, cmd, arg);
 
 	return err;
 }
diff -puN drivers/scsi/sr.c~cdrom_ioctl_use_bdev drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c~cdrom_ioctl_use_bdev	2005-05-22 11:01:56.000000000 +0200
+++ linux-petero/drivers/scsi/sr.c	2005-05-22 12:47:08.000000000 +0200
@@ -502,7 +502,7 @@ static int sr_block_ioctl(struct inode *
                 case SCSI_IOCTL_GET_BUS_NUMBER:
                         return scsi_ioctl(sdev, cmd, (void __user *)arg);
 	}
-	return cdrom_ioctl(file, &cd->cdi, inode, cmd, arg);
+	return cdrom_ioctl(file, &cd->cdi, inode->i_bdev, cmd, arg);
 }
 
 static int sr_block_media_changed(struct gendisk *disk)
diff -puN include/linux/cdrom.h~cdrom_ioctl_use_bdev include/linux/cdrom.h
--- linux/include/linux/cdrom.h~cdrom_ioctl_use_bdev	2005-05-22 11:00:12.000000000 +0200
+++ linux-petero/include/linux/cdrom.h	2005-05-22 11:00:19.000000000 +0200
@@ -990,7 +990,7 @@ extern int cdrom_open(struct cdrom_devic
 			struct file *fp);
 extern int cdrom_release(struct cdrom_device_info *cdi, struct file *fp);
 extern int cdrom_ioctl(struct file *file, struct cdrom_device_info *cdi,
-		struct inode *ip, unsigned int cmd, unsigned long arg);
+		struct block_device *bdev, unsigned int cmd, unsigned long arg);
 extern int cdrom_media_changed(struct cdrom_device_info *);
 
 extern int register_cdrom(struct cdrom_device_info *cdi);
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
