Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTLWQ7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLWQ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:59:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261758AbTLWQ6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:58:51 -0500
Date: Tue, 23 Dec 2003 17:58:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223165829.GF1601@suse.de>
References: <Pine.LNX.4.44.0312231732001.926-100000@neptune.local> <20031223163913.GC23184@suse.de> <20031223165428.GD1601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223165428.GD1601@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Jens Axboe wrote:
> -				rq->errors = 1;
> +					info->write_timeout = jiffies + ATAPI_WAIT_WRITE_BUSY;
> +				++rq->errors;

Didn't mean to change the = 1, here's an updated one.

diff -urp linux-2.6.0-mm1.virgin/drivers/cdrom/cdrom.c linux-2.6.0-mm1/drivers/cdrom/cdrom.c
--- linux-2.6.0-mm1.virgin/drivers/cdrom/cdrom.c	2003-12-23 17:44:54.000000000 +0100
+++ linux-2.6.0-mm1/drivers/cdrom/cdrom.c	2003-12-23 17:50:56.320349076 +0100
@@ -497,7 +497,7 @@ int cdrom_mrw_probe_pc(struct cdrom_devi
 	printk(KERN_ERR "cdrom: %s: unknown mrw mode page\n", cdi->name);
 	return 1;
 }
-
+	
 int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 {
 	struct cdrom_generic_command cgc;
@@ -708,6 +708,11 @@ static int cdrom_open_write(struct cdrom
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
+	/*
+	 * needs to really check whether media is writeable
+	 */
+	else if (CDROM_CAN(CDC_MO_DRIVE))
+		ret = 0;
 
 	return ret;
 }
@@ -737,7 +742,7 @@ int cdrom_open(struct cdrom_device_info 
 	cdi->use_count++;
 	ret = -EROFS;
 	if (fp->f_mode & FMODE_WRITE) {
-		if (!(CDROM_CAN(CDC_RAM) || CDROM_CAN(CDC_MO_DRIVE)))
+		if (!CDROM_CAN(CDC_RAM))
 			goto out;
 		if (cdrom_open_write(cdi))
 			goto out;
@@ -750,8 +755,6 @@ int cdrom_open(struct cdrom_device_info 
 	else
 		ret = open_for_data(cdi);
 
-	if (!ret) cdi->use_count++;
-
 	cdinfo(CD_OPEN, "Use count for \"/dev/%s\" now %d\n", cdi->name, cdi->use_count);
 	/* Do this on open.  Don't wait for mount, because they might
 	    not be mounting, but opening with O_NONBLOCK */
diff -urp linux-2.6.0-mm1.virgin/drivers/ide/ide-cd.c linux-2.6.0-mm1/drivers/ide/ide-cd.c
--- linux-2.6.0-mm1.virgin/drivers/ide/ide-cd.c	2003-12-23 17:44:54.000000000 +0100
+++ linux-2.6.0-mm1/drivers/ide/ide-cd.c	2003-12-23 17:57:26.326859551 +0100
@@ -790,7 +790,7 @@ static int cdrom_decode_status(ide_drive
 				 * devices will return this error while flushing
 				 * data from cache */
 				if (!rq->errors)
-					info->write_timeout = jiffies + ATAPI_WAIT_BUSY;
+					info->write_timeout = jiffies + ATAPI_WAIT_WRITE_BUSY;
 				rq->errors = 1;
 				if (time_after(jiffies, info->write_timeout))
 					do_end_request = 1;
@@ -2950,6 +2950,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 
 	if (drive->media == ide_optical) {
 		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
+		CDROM_CONFIG_FLAGS(drive)->ram = 1;
 		printk("%s: ATAPI magneto-optical drive\n", drive->name);
 		return nslots;
 	}
@@ -3281,9 +3282,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	/*
 	 * set correct block size and read-only for non-ram media
 	 */
-	set_disk_ro(drive->disk,
-		!(CDROM_CONFIG_FLAGS(drive)->ram ||
-			CDROM_CONFIG_FLAGS(drive)->mo_drive));
+	set_disk_ro(drive->disk, !CDROM_CONFIG_FLAGS(drive)->ram);
 	blk_queue_hardsect_size(drive->queue, CD_FRAMESIZE);
 
 #if 0
diff -urp linux-2.6.0-mm1.virgin/drivers/ide/ide-cd.h linux-2.6.0-mm1/drivers/ide/ide-cd.h
--- linux-2.6.0-mm1.virgin/drivers/ide/ide-cd.h	2003-12-23 17:44:54.000000000 +0100
+++ linux-2.6.0-mm1/drivers/ide/ide-cd.h	2003-12-23 17:48:19.939386898 +0100
@@ -39,7 +39,7 @@
  * typical timeout for packet command
  */
 #define ATAPI_WAIT_PC		(60 * HZ)
-#define ATAPI_WAIT_BUSY		(5 * HZ)
+#define ATAPI_WAIT_WRITE_BUSY	(10 * HZ)
 
 /************************************************************************/
 

-- 
Jens Axboe

