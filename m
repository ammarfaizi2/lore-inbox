Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUFGQ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUFGQ35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFGQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:29:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264646AbUFGQ3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:29:41 -0400
Date: Mon, 7 Jun 2004 18:29:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040607162923.GP13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406072008.07176.kernel@kolivas.org> <20040607101732.GI13836@suse.de> <200406072029.09765.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406072029.09765.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

Can you see if this works for you?

===== drivers/cdrom/cdrom.c 1.56 vs edited =====
--- 1.56/drivers/cdrom/cdrom.c	2004-06-05 09:25:29 +02:00
+++ edited/drivers/cdrom/cdrom.c	2004-06-07 18:28:17 +02:00
@@ -508,6 +508,8 @@
 	unsigned char buffer[16];
 	int ret;
 
+	*write = 0;
+
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
@@ -521,8 +523,10 @@
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
 	*write = mfd->write;
 
-	if ((ret = cdrom_mrw_probe_pc(cdi)))
+	if ((ret = cdrom_mrw_probe_pc(cdi))) {
+		*write = 0;
 		return ret;
+	}
 
 	return 0;
 }
@@ -826,8 +830,30 @@
  */
 static int cdrom_open_write(struct cdrom_device_info *cdi)
 {
+	int mrw, mrw_write, ram_write;
 	int ret = 1;
 
+	mrw = 0;
+	if (!cdrom_is_mrw(cdi, &mrw_write))
+		mrw = 1;
+
+	(void) cdrom_is_random_writable(cdi, &ram_write);
+
+	if (mrw)
+		cdi->mask &= ~CDC_MRW;
+	else
+		cdi->mask |= CDC_MRW;
+
+	if (mrw_write)
+		cdi->mask &= ~CDC_MRW_W;
+	else
+		cdi->mask |= CDC_MRW_W;
+
+	if (ram_write)
+		cdi->mask &= ~CDC_RAM;
+	else
+		cdi->mask |= CDC_RAM;
+
 	if (CDROM_CAN(CDC_MRW_W))
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
@@ -870,6 +896,9 @@
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS)) {
 		ret = cdi->ops->open(cdi, 1);
 	} else {
+		ret = open_for_data(cdi);
+		if (ret)
+			goto err;
 		if (fp->f_mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (!CDROM_CAN(CDC_RAM))
@@ -877,7 +906,6 @@
 			if (cdrom_open_write(cdi))
 				goto err;
 		}
-		ret = open_for_data(cdi);
 	}
 
 	if (ret)
===== drivers/ide/ide-cd.c 1.83 vs edited =====
--- 1.83/drivers/ide/ide-cd.c	2004-05-29 19:04:42 +02:00
+++ edited/drivers/ide/ide-cd.c	2004-06-07 18:18:07 +02:00
@@ -2818,7 +2818,6 @@
 	return 0;
 }
 
-
 /*
  * Close down the device.  Invalidate all cached blocks.
  */
@@ -2892,12 +2891,6 @@
 		devinfo->mask |= CDC_CLOSE_TRAY;
 	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		devinfo->mask |= CDC_MO_DRIVE;
-	if (!CDROM_CONFIG_FLAGS(drive)->mrw)
-		devinfo->mask |= CDC_MRW;
-	if (!CDROM_CONFIG_FLAGS(drive)->mrw_w)
-		devinfo->mask |= CDC_MRW_W;
-	if (!CDROM_CONFIG_FLAGS(drive)->ram)
-		devinfo->mask |= CDC_RAM;
 
 	devinfo->disk = drive->disk;
 	return register_cdrom(devinfo);
@@ -2934,7 +2927,7 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
 	struct atapi_capabilities_page cap;
-	int nslots = 1, mrw_write = 0, ram_write = 0;
+	int nslots = 1;
 
 	if (drive->media == ide_optical) {
 		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
@@ -2963,17 +2956,6 @@
 	if (ide_cdrom_get_capabilities(drive, &cap))
 		return 0;
 
-	if (!cdrom_is_mrw(cdi, &mrw_write)) {
-		CDROM_CONFIG_FLAGS(drive)->mrw = 1;
-		if (mrw_write) {
-			CDROM_CONFIG_FLAGS(drive)->mrw_w = 1;
-			CDROM_CONFIG_FLAGS(drive)->ram = 1;
-		}
-	}
-	if (!cdrom_is_random_writable(cdi, &ram_write))
-		if (ram_write)
-			CDROM_CONFIG_FLAGS(drive)->ram = 1;
-
 	if (cap.lock == 0)
 		CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
 	if (cap.eject)
@@ -3052,9 +3034,6 @@
         	printk(" CD%s%s", 
         	(CDROM_CONFIG_FLAGS(drive)->cd_r)? "-R" : "", 
         	(CDROM_CONFIG_FLAGS(drive)->cd_rw)? "/RW" : "");
-
-	if (CDROM_CONFIG_FLAGS(drive)->mrw || CDROM_CONFIG_FLAGS(drive)->mrw_w)
-		printk(" CD-MR%s", CDROM_CONFIG_FLAGS(drive)->mrw_w ? "W" : "");
 
         if (CDROM_CONFIG_FLAGS(drive)->is_changer) 
         	printk(" changer w/%d slots", nslots);
===== drivers/ide/ide-cd.h 1.10 vs edited =====
--- 1.10/drivers/ide/ide-cd.h	2004-04-23 21:09:53 +02:00
+++ edited/drivers/ide/ide-cd.h	2004-06-07 18:17:54 +02:00
@@ -79,8 +79,6 @@
 	__u8 dvd		: 1; /* Drive is a DVD-ROM */
 	__u8 dvd_r		: 1; /* Drive can write DVD-R */
 	__u8 dvd_ram		: 1; /* Drive can write DVD-RAM */
-	__u8 mrw		: 1; /* drive can read mrw */
-	__u8 mrw_w		: 1; /* drive can write mrw */
 	__u8 ram		: 1; /* generic WRITE (dvd-ram/mrw) */
 	__u8 test_write		: 1; /* Drive can fake writes */
 	__u8 supp_disc_present	: 1; /* Changer can report exact contents
===== drivers/scsi/sr.c 1.108 vs edited =====
--- 1.108/drivers/scsi/sr.c	2004-05-29 19:51:09 +02:00
+++ edited/drivers/scsi/sr.c	2004-06-07 18:18:30 +02:00
@@ -754,12 +754,11 @@
 static void get_capabilities(struct scsi_cd *cd)
 {
 	unsigned char *buffer;
-	int rc, n, mrw_write = 0, mrw = 1,ram_write=0;
 	struct scsi_mode_data data;
 	struct scsi_request *SRpnt;
 	unsigned char cmd[MAX_COMMAND_SIZE];
 	unsigned int the_result;
-	int retries;
+	int retries, rc, n;
 
 	static char *loadmech[] =
 	{
@@ -830,19 +829,6 @@
 		printk("%s: scsi-1 drive\n", cd->cdi.name);
 		return;
 	}
-
-	if (cdrom_is_mrw(&cd->cdi, &mrw_write)) {
-		mrw = 0;
-		cd->cdi.mask |= CDC_MRW;
-		cd->cdi.mask |= CDC_MRW_W;
-	}
-	if (!mrw_write)
-		cd->cdi.mask |= CDC_MRW_W;
-
-	if (cdrom_is_random_writable(&cd->cdi, &ram_write))
-		cd->cdi.mask |= CDC_RAM;
-	if (!ram_write)
-		cd->cdi.mask |= CDC_RAM;
 
 	n = data.header_length + data.block_descriptor_length;
 	cd->cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;

-- 
Jens Axboe

