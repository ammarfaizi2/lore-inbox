Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUHCQSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUHCQSC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUHCQSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:18:02 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:63220 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266692AbUHCQRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:17:51 -0400
Date: Tue, 3 Aug 2004 11:17:47 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040803161747.GA16293@bliss>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <1091490870.1649.23.camel@localhost.localdomain> <20040803055337.GA23504@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20040803055337.GA23504@suse.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2004 at 07:53:40AM +0200, Jens Axboe wrote:
> On Tue, Aug 03 2004, Alan Cox wrote:
> > On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
> > > If you want it to work that way, you have the have a pass-through filter
> > > in the kernel knowing what commands are out there (including vendor
> > > specific ones). That's just too ugly and not really doable or
> > > maintainable, sorry.
> > 
> > I disagree providing you turn it the other way around. The majority of
> > scsi commands have to be protected because you can destroy the drive
> > with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
> > to raw disk to bypass auditing layers)
> > 
> > So you need CAP_SYS_RAWIO for most commands. You can easily build a list
> > of sane commands for a given media type that are harmless and it fits
> > the kernel role of a gatekeeper to do that.
> 
> So that's where we vehemently disagree - it fits the kernel role, if you
> allow it to control policy all of a sudden. And it's not easy, unless
> you do it per specific device (not just type, make and model).
> 

Vendor commands would be tricky (it would probably be best to limit
vendor commands to well-established ones, and just disallow the rest
without CAP_SYS_RAWIO or such), but standard commands wouldn't have a
problem, and those don't get added very often.

> > Providing the 'allowed' function is driver level and we also honour
> > read/write properly for that case (so it doesnt bypass block I/O
> > restrictions and fail the least suprise test) then it seems quite
> > doable.
> > 
> > For such I/O you'd then do
> > 
> > 	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))
> > 
> > If the allowed function filters positively "unknown is not allowed" and
> > the default allowed function is simply "no" it works.
> 
> Until there's a new valid command for some device, in which case you
> have to update your kernel?
> 

As standard commands don't get added very often, that's not a huge
problem, but.. see the attached patch.

> > We'd end up with a list of allowed commands for all sorts of operations
> > that don't threaten the machine while blocking vendor specific wonders
> > and also cases where users can do stuff like firmware erase.
> 
> Sorry, I think this model is totally bogus and I'd absolutely refuse to
> merge any such beast into the block layer sg code.
> 

Well, would something like this patch be acceptable?  It just makes
SG_IO require write access to the device (cdrecord and cdrdao both
open it this way already, so users shouldn't have a problem with it).
I probably forgot some stuff, etc.  I'm not terribly familiar with the
code in question.

-- 
Zinx Verituse                                    http://zinx.xmms.org/

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.8-rc2-cdrom-access.diff"

Only in linux-2.6.8-rc2: .config
diff -ru linux-2.6.8-rc2.orig/drivers/block/paride/pcd.c linux-2.6.8-rc2/drivers/block/paride/pcd.c
--- linux-2.6.8-rc2.orig/drivers/block/paride/pcd.c	2004-08-02 19:58:12.000000000 -0500
+++ linux-2.6.8-rc2/drivers/block/paride/pcd.c	2004-08-02 20:17:37.000000000 -0500
@@ -259,7 +259,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&cd->info, inode, cmd, arg);
+	return cdrom_ioctl(&cd->info, inode, file, cmd, arg);
 }
 
 static int pcd_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/cdrom.c linux-2.6.8-rc2/drivers/cdrom/cdrom.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/cdrom.c	2004-08-02 19:58:12.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/cdrom.c	2004-08-02 20:18:22.000000000 -0500
@@ -2065,15 +2065,18 @@
  * mmc_ioct().
  */
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct inode *ip,
-		unsigned int cmd, unsigned long arg)
+		struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
 	int ret;
 
 	/* Try the generic SCSI command ioctl's first.. */
-	ret = scsi_cmd_ioctl(ip->i_bdev->bd_disk, cmd, (void __user *)arg);
-	if (ret != -ENOTTY)
-		return ret;
+	/* But only if the user has write access: open(,O_RDWR | O_NONBLOCK) */
+	if (file->f_mode & FMODE_WRITE) {
+		ret = scsi_cmd_ioctl(ip->i_bdev->bd_disk, cmd, (void __user *)arg);
+		if (ret != -ENOTTY)
+			return ret;
+	}
 
 	/* the first few commands do not deal with audio drive_info, but
 	   only with routines in cdrom device operations. */
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/cdu31a.c linux-2.6.8-rc2/drivers/cdrom/cdu31a.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/cdu31a.c	2004-06-16 00:19:42.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/cdu31a.c	2004-08-02 20:19:06.000000000 -0500
@@ -3179,7 +3179,7 @@
 static int scd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&scd_info, inode, cmd, arg);
+	return cdrom_ioctl(&scd_info, inode, file, cmd, arg);
 }
 
 static int scd_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/cm206.c linux-2.6.8-rc2/drivers/cdrom/cm206.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/cm206.c	2004-06-16 00:20:03.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/cm206.c	2004-08-02 20:19:21.000000000 -0500
@@ -1363,7 +1363,7 @@
 static int cm206_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&cm206_info, inode, cmd, arg);
+	return cdrom_ioctl(&cm206_info, inode, file, cmd, arg);
 }
 
 static int cm206_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/mcd.c linux-2.6.8-rc2/drivers/cdrom/mcd.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/mcd.c	2004-06-16 00:19:37.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/mcd.c	2004-08-02 20:18:57.000000000 -0500
@@ -227,7 +227,7 @@
 static int mcd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(&mcd_info, inode, cmd, arg);
+	return cdrom_ioctl(&mcd_info, inode, file, cmd, arg);
 }
 
 static int mcd_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/mcdx.c linux-2.6.8-rc2/drivers/cdrom/mcdx.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/mcdx.c	2004-08-02 19:58:12.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/mcdx.c	2004-08-02 20:18:46.000000000 -0500
@@ -233,7 +233,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&p->info, inode, cmd, arg);
+	return cdrom_ioctl(&p->info, inode, file, cmd, arg);
 }
 
 static int mcdx_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/sbpcd.c linux-2.6.8-rc2/drivers/cdrom/sbpcd.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/sbpcd.c	2004-06-16 00:18:59.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/sbpcd.c	2004-08-02 20:18:37.000000000 -0500
@@ -5372,7 +5372,7 @@
 				unsigned cmd, unsigned long arg)
 {
 	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(p->sbpcd_infop, inode, cmd, arg);
+	return cdrom_ioctl(p->sbpcd_infop, inode, file, cmd, arg);
 }
 
 static int sbpcd_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/cdrom/viocd.c linux-2.6.8-rc2/drivers/cdrom/viocd.c
--- linux-2.6.8-rc2.orig/drivers/cdrom/viocd.c	2004-08-02 19:58:12.000000000 -0500
+++ linux-2.6.8-rc2/drivers/cdrom/viocd.c	2004-08-02 20:19:35.000000000 -0500
@@ -199,7 +199,7 @@
 		unsigned cmd, unsigned long arg)
 {
 	struct disk_info *di = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(&di->viocd_info, inode, cmd, arg);
+	return cdrom_ioctl(&di->viocd_info, inode, file, cmd, arg);
 }
 
 static int viocd_blk_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/drivers/ide/ide-cd.c linux-2.6.8-rc2/drivers/ide/ide-cd.c
--- linux-2.6.8-rc2.orig/drivers/ide/ide-cd.c	2004-08-02 19:58:13.000000000 -0500
+++ linux-2.6.8-rc2/drivers/ide/ide-cd.c	2004-08-02 20:16:59.000000000 -0500
@@ -3394,7 +3394,7 @@
 	int err = generic_ide_ioctl(bdev, cmd, arg);
 	if (err == -EINVAL) {
 		struct cdrom_info *info = drive->driver_data;
-		err = cdrom_ioctl(&info->devinfo, inode, cmd, arg);
+		err = cdrom_ioctl(&info->devinfo, inode, file, cmd, arg);
 	}
 	return err;
 }
diff -ru linux-2.6.8-rc2.orig/drivers/scsi/sr.c linux-2.6.8-rc2/drivers/scsi/sr.c
--- linux-2.6.8-rc2.orig/drivers/scsi/sr.c	2004-08-02 19:58:24.000000000 -0500
+++ linux-2.6.8-rc2/drivers/scsi/sr.c	2004-08-02 20:17:23.000000000 -0500
@@ -504,7 +504,7 @@
                 case SCSI_IOCTL_GET_BUS_NUMBER:
                         return scsi_ioctl(sdev, cmd, (void __user *)arg);
 	}
-	return cdrom_ioctl(&cd->cdi, inode, cmd, arg);
+	return cdrom_ioctl(&cd->cdi, inode, file, cmd, arg);
 }
 
 static int sr_block_media_changed(struct gendisk *disk)
diff -ru linux-2.6.8-rc2.orig/include/linux/cdrom.h linux-2.6.8-rc2/include/linux/cdrom.h
--- linux-2.6.8-rc2.orig/include/linux/cdrom.h	2004-06-16 00:18:52.000000000 -0500
+++ linux-2.6.8-rc2/include/linux/cdrom.h	2004-08-02 20:20:09.000000000 -0500
@@ -985,7 +985,7 @@
 			struct file *fp);
 extern int cdrom_release(struct cdrom_device_info *cdi, struct file *fp);
 extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct inode *ip,
-		unsigned int cmd, unsigned long arg);
+		struct file *file, unsigned int cmd, unsigned long arg);
 extern int cdrom_media_changed(struct cdrom_device_info *);
 
 extern int register_cdrom(struct cdrom_device_info *cdi);

--9jxsPFA5p3P2qPhR--
