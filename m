Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUEMTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUEMTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEMTeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:34:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2229 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264218AbUEMTSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:18:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Thu, 13 May 2004 21:16:44 +0200
User-Agent: KMail/1.5.3
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>, Rene Herman <rene.herman@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405132116.44201.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Andrew, please merge this patch in -mm in place of the one you have now. ]

Comments, suggestions, complains?

[PATCH] ide-disk.c: more write cache fixes

- many Maxtor disks incorrectly claim CACHE FLUSH EXT command support,
  fix it by checking both CACHE FLUSH EXT command and LBA48 support
  (thanks to Eric D. Mudama for help in fixing this)

- write_cache() was called with 'drive->id->cfs_enable_2 & 0x3000' as 'int arg'
  argument which was always truncated to zero due to 'u8 drive->wcache = arg'
  assignment so write cache was indeed enabled but drive->wcache was zero
  (thanks to Rene Herman for help in debugging this)

- flush cache in idedisk_start_power_step() only if ATA-6 CACHE FLUSH (EXT)
  bits are present in disk's identify data (prevents sending unknown commands)

- set drive->wcache in idedisk_setup() not idedisk_attach() (no need to check
  id->command_set_2 - we check id->cfs_enable_2 instead in write_cache() call)

- use ide_cacheflush_p() in idedisk_setup()

- minor cleanups

 linux-2.6.6-bk1-bzolnier/drivers/ide/ide-disk.c |   70 +++++++++---------------
 1 files changed, 27 insertions(+), 43 deletions(-)

diff -puN drivers/ide/ide-disk.c~idedisk_wcache drivers/ide/ide-disk.c
--- linux-2.6.6-bk1/drivers/ide/ide-disk.c~idedisk_wcache	2004-05-13 16:42:43.963896336 +0200
+++ linux-2.6.6-bk1-bzolnier/drivers/ide/ide-disk.c	2004-05-13 20:30:34.619640768 +0200
@@ -740,8 +740,6 @@ static ide_startstop_t ide_do_rw_disk (i
 		return __ide_do_rw_disk(drive, rq, block);
 }
 
-static int do_idedisk_flushcache(ide_drive_t *drive);
-
 static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -1359,11 +1357,18 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
+/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
+#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
+
+/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
+#define ide_id_has_flush_cache_ext(id)	\
+	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
+
 static int write_cache (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
 
-	if (!(drive->id->cfs_enable_2 & 0x3000))
+	if (!ide_id_has_flush_cache(drive->id))
 		return 1;
 
 	memset(&args, 0, sizeof(ide_task_t));
@@ -1383,7 +1388,7 @@ static int do_idedisk_flushcache (ide_dr
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	if (drive->id->cfs_enable_2 & 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id))
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
@@ -1513,11 +1518,11 @@ static ide_startstop_t idedisk_start_pow
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) */
 		/* Not supported? Switch to next step now. */
-		if (!drive->wcache) {
+		if (!drive->wcache || !ide_id_has_flush_cache(drive->id)) {
 			idedisk_complete_power_step(drive, rq, 0, 0);
 			return ide_stopped;
 		}
-		if (drive->id->cfs_enable_2 & 0x2400)
+		if (ide_id_has_flush_cache_ext(drive->id))
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
 		else
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
@@ -1678,8 +1683,12 @@ static void idedisk_setup (ide_drive_t *
 #endif	/* CONFIG_IDEDISK_MULTI_MODE */
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
-	if (drive->id->cfs_enable_2 & 0x3000)
-		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
+	/* write cache enabled? */
+	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
+		drive->wcache = 1;
+
+	write_cache(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
@@ -1687,9 +1696,17 @@ static void idedisk_setup (ide_drive_t *
 #endif
 }
 
+static void ide_cacheflush_p(ide_drive_t *drive)
+{
+	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
+		return;
+
+	if (do_idedisk_flushcache(drive))
+		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
+}
+
 static int idedisk_cleanup (ide_drive_t *drive)
 {
-	static int ide_cacheflush_p(ide_drive_t *drive);
 	struct gendisk *g = drive->disk;
 	ide_cacheflush_p(drive);
 	if (ide_unregister_subdriver(drive))
@@ -1740,7 +1757,6 @@ static ide_driver_t idedisk_driver = {
 
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
-	u8 cf;
 	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
 	drive->usage++;
 	if (drive->removable && drive->usage == 1) {
@@ -1758,35 +1774,6 @@ static int idedisk_open(struct inode *in
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
-	drive->wcache = 0;
-	/* Cache enabled? */
-	if (drive->id->csfo & 1)
-		drive->wcache = 1;
-	/* Cache command set available? */
-	if (drive->id->cfs_enable_1 & (1 << 5))
-		drive->wcache = 1;
-	/* ATA6 cache extended commands */
-	cf = drive->id->command_set_2 >> 24;
-	if ((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
-		drive->wcache = 1;
-	return 0;
-}
-
-static int ide_cacheflush_p(ide_drive_t *drive)
-{
-	if (!(drive->id->cfs_enable_2 & 0x3000))
-		return 0;
-
-	if(drive->wcache)
-	{
-		if (do_idedisk_flushcache(drive))
-		{
-			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-				drive->name);
-			return -EIO;
-		}
-		return 1;
-	}
 	return 0;
 }
 
@@ -1867,10 +1854,7 @@ static int idedisk_attach(ide_drive_t *d
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-			if (do_idedisk_flushcache(drive))
-				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-					drive->name);
+		ide_cacheflush_p(drive);
 		ide_unregister_subdriver(drive);
 		DRIVER(drive)->busy--;
 		goto failed;

_

