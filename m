Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTIBSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTIBSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:35:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35222 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261170AbTIBSfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:35:53 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide: remove supports_dma field from ide_driver_t
Date: Tue, 2 Sep 2003 20:36:16 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309022036.16612.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ide: remove supports_dma field from ide_driver_t

driver->supports_dma was used together with CONFIG_IDEDMA_ONLYDISK to limit
DMA access to disk devices only.  However Alan introduced new scheme in 2.5.63
and this field is not needed any longer because all ide drivers support DMA.

 drivers/ide/ide-cd.c      |    1 -
 drivers/ide/ide-default.c |    6 ------
 drivers/ide/ide-disk.c    |    1 -
 drivers/ide/ide-floppy.c  |    1 -
 drivers/ide/ide-tape.c    |    1 -
 drivers/ide/ide.c         |    5 -----
 drivers/scsi/ide-scsi.c   |    1 -
 include/linux/ide.h       |    1 -
 8 files changed, 17 deletions(-)

diff -puN drivers/ide/ide.c~ide-supports-dma drivers/ide/ide.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide.c~ide-supports-dma	2003-09-02 18:03:17.925980888 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide.c	2003-09-02 18:03:17.955976328 +0200
@@ -1359,8 +1359,6 @@ static int set_io_32bit(ide_drive_t *dri
 
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
-	if (!DRIVER(drive)->supports_dma)
-		return -EPERM;
 	if (!drive->id || !(drive->id->capability & 1))
 		return -EPERM;
 	if (HWIF(drive)->ide_dma_check == NULL)
@@ -2443,9 +2441,6 @@ int ide_register_subdriver (ide_drive_t 
 	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
 		(drive->autotune == IDE_TUNE_AUTO)) {
 		/* DMA timings and setup moved to ide-probe.c */
-		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
-//			HWIF(drive)->ide_dma_off_quietly(drive);
-			HWIF(drive)->ide_dma_off(drive);
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
 	}
diff -puN drivers/ide/ide-cd.c~ide-supports-dma drivers/ide/ide-cd.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-cd.c~ide-supports-dma	2003-09-02 18:03:17.929980280 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-cd.c	2003-09-02 18:03:17.958975872 +0200
@@ -3318,7 +3318,6 @@ static ide_driver_t ide_cdrom_driver = {
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
diff -puN drivers/ide/ide-default.c~ide-supports-dma drivers/ide/ide-default.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-default.c~ide-supports-dma	2003-09-02 18:03:17.932979824 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-default.c	2003-09-02 18:03:17.958975872 +0200
@@ -40,18 +40,12 @@ static int idedefault_attach(ide_drive_t
 
 /*
  *	IDE subdriver functions, registered with ide.c
- *
- *	idedefault *must* support DMA because it will be
- *	attached before the other drivers are loaded and
- *	we don't want to lose the DMA status at probe
- *	time.
  */
 
 ide_driver_t idedefault_driver = {
 	.name		=	"ide-default",
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
-	.supports_dma	=	1,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };
 
diff -puN drivers/ide/ide-disk.c~ide-supports-dma drivers/ide/ide-disk.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-disk.c~ide-supports-dma	2003-09-02 18:03:17.935979368 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-disk.c	2003-09-02 18:03:17.960975568 +0200
@@ -1716,7 +1716,6 @@ static ide_driver_t idedisk_driver = {
 	.version		= IDEDISK_VERSION,
 	.media			= ide_disk,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.flushcache		= do_idedisk_flushcache,
diff -puN drivers/ide/ide-floppy.c~ide-supports-dma drivers/ide/ide-floppy.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-floppy.c~ide-supports-dma	2003-09-02 18:03:17.939978760 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-floppy.c	2003-09-02 18:03:17.961975416 +0200
@@ -1854,7 +1854,6 @@ static ide_driver_t idefloppy_driver = {
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
diff -puN drivers/ide/ide-tape.c~ide-supports-dma drivers/ide/ide-tape.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-tape.c~ide-supports-dma	2003-09-02 18:03:17.943978152 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-tape.c	2003-09-02 18:03:17.966974656 +0200
@@ -6316,7 +6316,6 @@ static ide_driver_t idetape_driver = {
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
 	.busy			= 1,
-	.supports_dma		= 1,
 	.supports_dsc_overlap 	= 1,
 	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
diff -puN drivers/scsi/ide-scsi.c~ide-supports-dma drivers/scsi/ide-scsi.c
--- linux-2.6.0-test4-bk3/drivers/scsi/ide-scsi.c~ide-supports-dma	2003-09-02 18:03:17.946977696 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/scsi/ide-scsi.c	2003-09-02 18:03:17.967974504 +0200
@@ -627,7 +627,6 @@ static ide_driver_t idescsi_driver = {
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.attach			= idescsi_attach,
 	.cleanup		= idescsi_cleanup,
diff -puN include/linux/ide.h~ide-supports-dma include/linux/ide.h
--- linux-2.6.0-test4-bk3/include/linux/ide.h~ide-supports-dma	2003-09-02 18:03:17.949977240 +0200
+++ linux-2.6.0-test4-bk3-root/include/linux/ide.h	2003-09-02 18:03:17.968974352 +0200
@@ -1216,7 +1216,6 @@ typedef struct ide_driver_s {
 	const char			*version;
 	u8				media;
 	unsigned busy			: 1;
-	unsigned supports_dma		: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
 	int		(*shutdown)(ide_drive_t *);

_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

ide: remove supports_dma field from ide_driver_t

driver->supports_dma was used together with CONFIG_IDEDMA_ONLYDISK to limit
DMA access to disk devices only.  However Alan introduced new scheme in 2.5.63
and this field is not needed any longer because all ide drivers support DMA.

 drivers/ide/ide-cd.c      |    1 -
 drivers/ide/ide-default.c |    6 ------
 drivers/ide/ide-disk.c    |    1 -
 drivers/ide/ide-floppy.c  |    1 -
 drivers/ide/ide-tape.c    |    1 -
 drivers/ide/ide.c         |    5 -----
 drivers/scsi/ide-scsi.c   |    1 -
 include/linux/ide.h       |    1 -
 8 files changed, 17 deletions(-)

diff -puN drivers/ide/ide.c~ide-supports-dma drivers/ide/ide.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide.c~ide-supports-dma	2003-09-02 18:03:17.925980888 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide.c	2003-09-02 18:03:17.955976328 +0200
@@ -1359,8 +1359,6 @@ static int set_io_32bit(ide_drive_t *dri
 
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
-	if (!DRIVER(drive)->supports_dma)
-		return -EPERM;
 	if (!drive->id || !(drive->id->capability & 1))
 		return -EPERM;
 	if (HWIF(drive)->ide_dma_check == NULL)
@@ -2443,9 +2441,6 @@ int ide_register_subdriver (ide_drive_t 
 	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
 		(drive->autotune == IDE_TUNE_AUTO)) {
 		/* DMA timings and setup moved to ide-probe.c */
-		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
-//			HWIF(drive)->ide_dma_off_quietly(drive);
-			HWIF(drive)->ide_dma_off(drive);
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
 	}
diff -puN drivers/ide/ide-cd.c~ide-supports-dma drivers/ide/ide-cd.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-cd.c~ide-supports-dma	2003-09-02 18:03:17.929980280 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-cd.c	2003-09-02 18:03:17.958975872 +0200
@@ -3318,7 +3318,6 @@ static ide_driver_t ide_cdrom_driver = {
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
diff -puN drivers/ide/ide-default.c~ide-supports-dma drivers/ide/ide-default.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-default.c~ide-supports-dma	2003-09-02 18:03:17.932979824 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-default.c	2003-09-02 18:03:17.958975872 +0200
@@ -40,18 +40,12 @@ static int idedefault_attach(ide_drive_t
 
 /*
  *	IDE subdriver functions, registered with ide.c
- *
- *	idedefault *must* support DMA because it will be
- *	attached before the other drivers are loaded and
- *	we don't want to lose the DMA status at probe
- *	time.
  */
 
 ide_driver_t idedefault_driver = {
 	.name		=	"ide-default",
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
-	.supports_dma	=	1,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };
 
diff -puN drivers/ide/ide-disk.c~ide-supports-dma drivers/ide/ide-disk.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-disk.c~ide-supports-dma	2003-09-02 18:03:17.935979368 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-disk.c	2003-09-02 18:03:17.960975568 +0200
@@ -1716,7 +1716,6 @@ static ide_driver_t idedisk_driver = {
 	.version		= IDEDISK_VERSION,
 	.media			= ide_disk,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.flushcache		= do_idedisk_flushcache,
diff -puN drivers/ide/ide-floppy.c~ide-supports-dma drivers/ide/ide-floppy.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-floppy.c~ide-supports-dma	2003-09-02 18:03:17.939978760 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-floppy.c	2003-09-02 18:03:17.961975416 +0200
@@ -1854,7 +1854,6 @@ static ide_driver_t idefloppy_driver = {
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
diff -puN drivers/ide/ide-tape.c~ide-supports-dma drivers/ide/ide-tape.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-tape.c~ide-supports-dma	2003-09-02 18:03:17.943978152 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-tape.c	2003-09-02 18:03:17.966974656 +0200
@@ -6316,7 +6316,6 @@ static ide_driver_t idetape_driver = {
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
 	.busy			= 1,
-	.supports_dma		= 1,
 	.supports_dsc_overlap 	= 1,
 	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
diff -puN drivers/scsi/ide-scsi.c~ide-supports-dma drivers/scsi/ide-scsi.c
--- linux-2.6.0-test4-bk3/drivers/scsi/ide-scsi.c~ide-supports-dma	2003-09-02 18:03:17.946977696 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/scsi/ide-scsi.c	2003-09-02 18:03:17.967974504 +0200
@@ -627,7 +627,6 @@ static ide_driver_t idescsi_driver = {
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
 	.busy			= 0,
-	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.attach			= idescsi_attach,
 	.cleanup		= idescsi_cleanup,
diff -puN include/linux/ide.h~ide-supports-dma include/linux/ide.h
--- linux-2.6.0-test4-bk3/include/linux/ide.h~ide-supports-dma	2003-09-02 18:03:17.949977240 +0200
+++ linux-2.6.0-test4-bk3-root/include/linux/ide.h	2003-09-02 18:03:17.968974352 +0200
@@ -1216,7 +1216,6 @@ typedef struct ide_driver_s {
 	const char			*version;
 	u8				media;
 	unsigned busy			: 1;
-	unsigned supports_dma		: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
 	int		(*shutdown)(ide_drive_t *);

_

