Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUGAN4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUGAN4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUGAN4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:56:03 -0400
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:28581 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265285AbUGANyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:54:19 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Nigel Kukard <nkukard@lbsd.net>
Subject: [PATCH] DVD+RW support for 2.6.7-bk13
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jul 2004 15:45:27 +0200
Message-ID: <m2hdsr6du0.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for using DVD+RW drives as writable block
devices under the 2.6.7-bk13 kernel.

The patch is based on work from:

        Andy Polyakov <appro@fy.chalmers.se> - Wrote the 2.4 patch
        Nigel Kukard <nkukard@lbsd.net> - Initial porting to 2.6.x

It works for me using an Iomega Super DVD 8x USB drive.


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/cdrom/cdrom.c |   80 +++++++++++++++++++++++++++++++++++++
 linux-petero/drivers/ide/ide-cd.c  |    2 
 linux-petero/drivers/scsi/sr.c     |    1 
 linux-petero/include/linux/cdrom.h |    2 
 4 files changed, 85 insertions(+)

diff -puN drivers/cdrom/cdrom.c~dvd+rw drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~dvd+rw	2004-07-01 15:10:46.706913160 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-07-01 15:10:46.720911032 +0200
@@ -821,6 +821,41 @@ static int cdrom_ram_open_write(struct c
 	return ret;
 }
 
+static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
+{
+	struct packet_command cgc;
+	char buffer[32];
+	int ret, mmc3_profile;
+
+	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[1] = 0;
+	cgc.cmd[2] = cgc.cmd[3] = 0;		/* Starting Feature Number */
+	cgc.cmd[7] = 0; cgc.cmd [8] = 8;	/* Allocation Length */
+	cgc.quiet = 1;
+
+	if ((ret = cdi->ops->generic_packet(cdi, &cgc))) {
+		mmc3_profile = 0xffff;
+	} else {
+		mmc3_profile = (buffer[6] << 8) | buffer[7];
+		printk(KERN_INFO "cdrom: %s: mmc-3 profile capable, current profile: %Xh\n",
+		       cdi->name, mmc3_profile);
+	}
+	cdi->mmc3_profile = mmc3_profile;
+}
+
+static int cdrom_is_dvd_rw(struct cdrom_device_info *cdi)
+{
+	switch (cdi->mmc3_profile) {
+	case 0x12:	/* DVD-RAM	*/
+	case 0x1A:	/* DVD+RW	*/
+		return 0;
+	default:
+		return 1;
+	}
+}
+
 /*
  * returns 0 for ok to open write, non-0 to disallow
  */
@@ -859,10 +894,50 @@ static int cdrom_open_write(struct cdrom
  		ret = cdrom_ram_open_write(cdi);
 	else if (CDROM_CAN(CDC_MO_DRIVE))
 		ret = mo_open_write(cdi);
+	else if (!cdrom_is_dvd_rw(cdi))
+		ret = 0;
 
 	return ret;
 }
 
+static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
+{
+	struct packet_command cgc;
+
+	if (cdi->mmc3_profile != 0x1a) {
+		cdinfo(CD_CLOSE, "%s: No DVD+RW\n", cdi->name);
+		return;
+	}
+
+	if (!cdi->media_written) {
+		cdinfo(CD_CLOSE, "%s: DVD+RW media clean\n", cdi->name);
+		return;
+	}
+
+	printk(KERN_INFO "cdrom: %s: dirty DVD+RW media, \"finalizing\"\n",
+	       cdi->name);
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_FLUSH_CACHE;
+	cgc.timeout = 30*HZ;
+	cdi->ops->generic_packet(cdi, &cgc);
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_CLOSE_TRACK;
+	cgc.timeout = 3000*HZ;
+	cgc.quiet = 1;
+	cdi->ops->generic_packet(cdi, &cgc);
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.cmd[0] = GPCMD_CLOSE_TRACK;
+	cgc.cmd[2] = 2;	 /* Close session */
+	cgc.quiet = 1;
+	cgc.timeout = 3000*HZ;
+	cdi->ops->generic_packet(cdi, &cgc);
+
+	cdi->media_written = 0;
+}
+
 static int cdrom_close_write(struct cdrom_device_info *cdi)
 {
 #if 0
@@ -895,6 +970,7 @@ int cdrom_open(struct cdrom_device_info 
 		ret = open_for_data(cdi);
 		if (ret)
 			goto err;
+		cdrom_mmc3_profile(cdi);
 		if (fp->f_mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (!CDROM_CAN(CDC_RAM))
@@ -902,6 +978,7 @@ int cdrom_open(struct cdrom_device_info 
 			if (cdrom_open_write(cdi))
 				goto err;
 			ret = 0;
+			cdi->media_written = 0;
 		}
 	}
 
@@ -1093,6 +1170,8 @@ int cdrom_release(struct cdrom_device_in
 		cdi->use_count--;
 	if (cdi->use_count == 0)
 		cdinfo(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n", cdi->name);
+	if (cdi->use_count == 0)
+		cdrom_dvd_rw_close_write(cdi);
 	if (cdi->use_count == 0 &&
 	    (cdo->capability & CDC_LOCK) && !keeplocked) {
 		cdinfo(CD_CLOSE, "Unlocking door!\n");
@@ -1299,6 +1378,7 @@ int media_changed(struct cdrom_device_in
 	if (cdi->ops->media_changed(cdi, CDSL_CURRENT)) {
 		cdi->mc_flags = 0x3;    /* set bit on both queues */
 		ret |= 1;
+		cdi->media_written = 0;
 	}
 	cdi->mc_flags &= ~mask;         /* clear bit */
 	return ret;
diff -puN drivers/scsi/sr.c~dvd+rw drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c~dvd+rw	2004-07-01 15:10:46.708912856 +0200
+++ linux-petero/drivers/scsi/sr.c	2004-07-01 15:10:46.721910880 +0200
@@ -379,6 +379,7 @@ static int sr_init_command(struct scsi_c
 			return 0;
 		SCpnt->cmnd[0] = WRITE_10;
 		SCpnt->sc_data_direction = DMA_TO_DEVICE;
+ 	 	cd->cdi.media_written = 1;
 	} else if (rq_data_dir(SCpnt->request) == READ) {
 		SCpnt->cmnd[0] = READ_10;
 		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
diff -puN drivers/ide/ide-cd.c~dvd+rw drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c~dvd+rw	2004-07-01 15:10:46.711912400 +0200
+++ linux-petero/drivers/ide/ide-cd.c	2004-07-01 15:10:46.724910424 +0200
@@ -1940,6 +1940,8 @@ static ide_startstop_t cdrom_start_write
 	info->dma = drive->using_dma ? 1 : 0;
 	info->cmd = WRITE;
 
+	info->devinfo.media_written = 1;
+
 	/* Start sending the write request to the drive. */
 	return cdrom_start_packet_command(drive, 32768, cdrom_start_write_cont);
 }
diff -puN include/linux/cdrom.h~dvd+rw include/linux/cdrom.h
--- linux/include/linux/cdrom.h~dvd+rw	2004-07-01 15:10:46.713912096 +0200
+++ linux-petero/include/linux/cdrom.h	2004-07-01 15:10:46.725910272 +0200
@@ -947,6 +947,8 @@ struct cdrom_device_info {
         __u8 reserved		: 6;	/* not used yet */
 	int cdda_method;		/* see flags */
 	__u8 last_sense;
+	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
+	unsigned short mmc3_profile;	/* current MMC3 profile */
 	int for_data;
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
