Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbSK2Wqv>; Fri, 29 Nov 2002 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSK2Wqv>; Fri, 29 Nov 2002 17:46:51 -0500
Received: from verein.lst.de ([212.34.181.86]:34058 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267171AbSK2Wqq>;
	Fri, 29 Nov 2002 17:46:46 -0500
Date: Fri, 29 Nov 2002 23:53:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] remove IDESCSI_SG_TRANSFORM (compile fix)
Message-ID: <20021129235353.A13377@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current 2.5 scsi-misc tree Scsi_Device_Template.tag is gone.

ide-scsi is still using it in should_transform() to decide whether
to test IDESCSI_SG_TRANSFORM or IDESCSI_TRANSFORM.

The obvious compile fix is to just kill that check, which makes
IDESCSI_SG_TRANSFORM superflous.  Of course the question remains
what the actual point of IDESCSI_SG_TRANSFORM was and if we still
need it.


--- 1.17/drivers/scsi/ide-scsi.c	Mon Nov 18 08:10:40 2002
+++ edited/drivers/scsi/ide-scsi.c	Fri Nov 29 23:14:21 2002
@@ -82,7 +82,6 @@
  *	SCSI command transformation layer
  */
 #define IDESCSI_TRANSFORM		0	/* Enable/Disable transformation */
-#define IDESCSI_SG_TRANSFORM		1	/* /dev/sg transformation */
 
 /*
  *	Log flags
@@ -532,7 +531,6 @@
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
 		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
-	clear_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 #if IDESCSI_DEBUG_LOG
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
@@ -666,22 +664,6 @@
 	return "SCSI host adapter emulation for IDE ATAPI devices";
 }
 
-int idescsi_ioctl (Scsi_Device *dev, int cmd, void *arg)
-{
-	ide_drive_t *drive = idescsi_drives[dev->id];
-	idescsi_scsi_t *scsi = drive->driver_data;
-
-	if (cmd == SG_SET_TRANSFORM) {
-		if (arg)
-			set_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
-		else
-			clear_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
-		return 0;
-	} else if (cmd == SG_GET_TRANSFORM)
-		return put_user(test_bit(IDESCSI_SG_TRANSFORM, &scsi->transform), (int *) arg);
-	return -EINVAL;
-}
-
 static inline struct bio *idescsi_kmalloc_bio (int count)
 {
 	struct bio *bh, *bhp, *first_bh;
@@ -760,13 +742,7 @@
 static inline int should_transform(ide_drive_t *drive, Scsi_Cmnd *cmd)
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
-	struct gendisk *disk = cmd->request->rq_disk;
 
-	if (disk) {
-		struct Scsi_Device_Template **p = disk->private_data;
-		if (strcmp((*p)->tag, "sg") == 0)
-			return test_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
-	}
 	return test_bit(IDESCSI_TRANSFORM, &scsi->transform);
 }
 
@@ -864,7 +840,6 @@
 	.detect		= idescsi_detect,
 	.release	= idescsi_release,
 	.info		= idescsi_info,
-	.ioctl		= idescsi_ioctl,
 	.queuecommand	= idescsi_queue,
 	.bios_param	= idescsi_bios,
 	.can_queue	= 10,
