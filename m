Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUBDEpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBDEpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:45:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5621 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265964AbUBDEpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:45:04 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] [IDE] remove ide_dma_queued_* ops from ide_hwif_t
Date: Tue, 3 Feb 2004 21:15:35 +0100
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402032115.35868.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, could you take a look?

--bart

TCQ code is host independent so remove redundant ide_dma_queued_* ops from
ide_hwif_t.  If we ever decide to bring back TCQ support this will fix OOPS
in ide-disk driver with CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y and icside/sgiioc4
host drivers (it will also enable TCQ support for these host drivers).

 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-disk.c     |   20 +++++++----------
 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-dma.c      |   23 ++------------------
 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-taskfile.c |    6 +++--
 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-tcq.c      |    4 +--
 linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c          |    7 ------
 linux-2.6.2-rc3-bk3-root/drivers/ide/ppc/pmac.c     |    7 ------
 linux-2.6.2-rc3-bk3-root/include/linux/ide.h        |   23 --------------------
 7 files changed, 18 insertions(+), 72 deletions(-)

diff -puN drivers/ide/ide.c~ide_dma_queued_cleanup drivers/ide/ide.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide.c~ide_dma_queued_cleanup	2004-02-03 18:59:54.082285872 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c	2004-02-03 19:00:18.410587408 +0100
@@ -848,13 +848,6 @@ void ide_unregister (unsigned int index)
 	hwif->ide_dma_verbose		= old_hwif.ide_dma_verbose;
 	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
 	hwif->ide_dma_timeout		= old_hwif.ide_dma_timeout;
-	hwif->ide_dma_queued_on		= old_hwif.ide_dma_queued_on;
-	hwif->ide_dma_queued_off	= old_hwif.ide_dma_queued_off;
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	hwif->ide_dma_queued_read	= old_hwif.ide_dma_queued_read;
-	hwif->ide_dma_queued_write	= old_hwif.ide_dma_queued_write;
-	hwif->ide_dma_queued_start	= old_hwif.ide_dma_queued_start;
-#endif
 #endif
 
 #if 0
diff -puN drivers/ide/ide-disk.c~ide_dma_queued_cleanup drivers/ide/ide-disk.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-disk.c~ide_dma_queued_cleanup	2004-02-03 19:02:05.932241632 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-disk.c	2004-02-03 20:02:29.251413392 +0100
@@ -470,9 +470,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 	}
 
 	if (rq_data_dir(rq) == READ) {
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
 		if (blk_rq_tagged(rq))
-			return hwif->ide_dma_queued_read(drive);
-
+			return __ide_dma_queued_read(drive);
+#endif
 		if (drive->using_dma && !hwif->ide_dma_read(drive))
 			return ide_started;
 
@@ -483,10 +484,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		return ide_started;
 	} else if (rq_data_dir(rq) == WRITE) {
 		ide_startstop_t startstop;
-
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
 		if (blk_rq_tagged(rq))
-			return hwif->ide_dma_queued_write(drive);
-
+			return __ide_dma_queued_write(drive);
+#endif
 		if (drive->using_dma && !(HWIF(drive)->ide_dma_write(drive)))
 			return ide_started;
 
@@ -1400,13 +1401,10 @@ static int set_acoustic (ide_drive_t *dr
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
 static int set_using_tcq(ide_drive_t *drive, int arg)
 {
-	ide_hwif_t *hwif = HWIF(drive);
 	int ret;
 
 	if (!drive->driver)
 		return -EPERM;
-	if (!hwif->ide_dma_queued_on || !hwif->ide_dma_queued_off)
-		return -ENXIO;
 	if (arg == drive->queue_depth && drive->using_tcq)
 		return 0;
 
@@ -1420,9 +1418,9 @@ static int set_using_tcq(ide_drive_t *dr
 	}
 
 	if (arg)
-		ret = HWIF(drive)->ide_dma_queued_on(drive);
+		ret = __ide_dma_queued_on(drive);
 	else
-		ret = HWIF(drive)->ide_dma_queued_off(drive);
+		ret = __ide_dma_queued_off(drive);
 
 	return ret ? -EIO : 0;
 }
@@ -1673,7 +1671,7 @@ static void idedisk_setup (ide_drive_t *
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
-		HWIF(drive)->ide_dma_queued_on(drive);
+		__ide_dma_queued_on(drive);
 #endif
 }
 
diff -puN drivers/ide/ide-dma.c~ide_dma_queued_cleanup drivers/ide/ide-dma.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-dma.c~ide_dma_queued_cleanup	2004-02-03 19:02:07.698973048 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-dma.c	2004-02-03 19:05:34.933468616 +0100
@@ -512,9 +512,9 @@ int __ide_dma_off_quietly (ide_drive_t *
 
 	if (HWIF(drive)->ide_dma_host_off(drive))
 		return 1;
-
-	HWIF(drive)->ide_dma_queued_off(drive);
-
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	__ide_dma_queued_off(drive);
+#endif
 	return 0;
 }
 
@@ -1091,23 +1091,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	if (!hwif->ide_dma_lostirq)
 		hwif->ide_dma_lostirq = &__ide_dma_lostirq;
 
-	/*
-	 * dma queued ops. if tcq isn't set, queued on and off are just
-	 * dummy functions. cuts down on ifdef hell
-	 */
-	if (!hwif->ide_dma_queued_on)
-		hwif->ide_dma_queued_on = __ide_dma_queued_on;
-	if (!hwif->ide_dma_queued_off)
-		hwif->ide_dma_queued_off = __ide_dma_queued_off;
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	if (!hwif->ide_dma_queued_read)
-		hwif->ide_dma_queued_read = __ide_dma_queued_read;
-	if (!hwif->ide_dma_queued_write)
-		hwif->ide_dma_queued_write = __ide_dma_queued_write;
-	if (!hwif->ide_dma_queued_start)
-		hwif->ide_dma_queued_start = __ide_dma_queued_start;
-#endif
-
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
 		printk(", BIOS settings: %s:%s, %s:%s",
diff -puN drivers/ide/ide-taskfile.c~ide_dma_queued_cleanup drivers/ide/ide-taskfile.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-taskfile.c~ide_dma_queued_cleanup	2004-02-03 19:13:13.781713080 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-taskfile.c	2004-02-03 19:14:23.821065480 +0100
@@ -200,12 +200,14 @@ ide_startstop_t do_rw_taskfile (ide_driv
 			if (!hwif->ide_dma_read(drive))
 				return ide_started;
 			break;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
 		case WIN_READDMA_QUEUED:
 		case WIN_READDMA_QUEUED_EXT:
-			return hwif->ide_dma_queued_read(drive);
+			return __ide_dma_queued_read(drive);
 		case WIN_WRITEDMA_QUEUED:
 		case WIN_WRITEDMA_QUEUED_EXT:
-			return hwif->ide_dma_queued_write(drive);
+			return __ide_dma_queued_write(drive);
+#endif
 		default:
 			if (task->handler == NULL)
 				return ide_stopped;
diff -puN drivers/ide/ide-tcq.c~ide_dma_queued_cleanup drivers/ide/ide-tcq.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-tcq.c~ide_dma_queued_cleanup	2004-02-03 19:55:43.775055168 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-tcq.c	2004-02-03 19:58:10.079813464 +0100
@@ -353,7 +353,7 @@ ide_startstop_t ide_service(ide_drive_t 
 		 */
 		TCQ_PRINTK("ide_service: starting command, stat=%x\n", stat);
 		spin_unlock_irqrestore(&ide_lock, flags);
-		return HWIF(drive)->ide_dma_queued_start(drive);
+		return __ide_dma_queued_start(drive);
 	}
 
 	printk(KERN_ERR "ide_service: missing request for tag %d\n", tag);
@@ -729,7 +729,7 @@ static ide_startstop_t ide_dma_queued_rw
 	feat = hwif->INB(IDE_NSECTOR_REG);
 	if (!(feat & REL)) {
 		TCQ_PRINTK("IMMED in queued_start, feat=%x\n", feat);
-		return hwif->ide_dma_queued_start(drive);
+		return __ide_dma_queued_start(drive);
 	}
 
 	/*
diff -puN drivers/ide/ppc/pmac.c~ide_dma_queued_cleanup drivers/ide/ppc/pmac.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ppc/pmac.c~ide_dma_queued_cleanup	2004-02-03 19:06:49.960062840 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ppc/pmac.c	2004-02-03 19:07:08.131300392 +0100
@@ -2030,13 +2030,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_verbose = &__ide_dma_verbose;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
-	hwif->ide_dma_queued_on = &__ide_dma_queued_on;
-	hwif->ide_dma_queued_off = &__ide_dma_queued_off;
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	hwif->ide_dma_queued_read = __ide_dma_queued_read;
-	hwif->ide_dma_queued_write = __ide_dma_queued_write;
-	hwif->ide_dma_queued_start = __ide_dma_queued_start;
-#endif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
diff -puN include/linux/ide.h~ide_dma_queued_cleanup include/linux/ide.h
--- linux-2.6.2-rc3-bk3/include/linux/ide.h~ide_dma_queued_cleanup	2004-02-03 19:07:26.979435040 +0100
+++ linux-2.6.2-rc3-bk3-root/include/linux/ide.h	2004-02-03 19:12:36.290412624 +0100
@@ -801,12 +801,6 @@ typedef struct ide_dma_ops_s {
 	int (*ide_dma_verbose)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
-	/* dma queued operations */
-	int (*ide_dma_queued_on)(ide_drive_t *drive);
-	int (*ide_dma_queued_off)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_read)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_write)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
 } ide_dma_ops_t;
 
 /*
@@ -947,13 +941,6 @@ typedef struct hwif_s {
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 
-	/* dma queued operations */
-	int (*ide_dma_queued_on)(ide_drive_t *drive);
-	int (*ide_dma_queued_off)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_read)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_write)(ide_drive_t *drive);
-	ide_startstop_t (*ide_dma_queued_start)(ide_drive_t *drive);
-
 	void (*OUTB)(u8 addr, unsigned long port);
 	void (*OUTBSYNC)(ide_drive_t *drive, u8 addr, unsigned long port);
 	void (*OUTW)(u16 addr, unsigned long port);
@@ -1644,16 +1631,6 @@ extern int __ide_dma_queued_off(ide_driv
 extern ide_startstop_t __ide_dma_queued_read(ide_drive_t *drive);
 extern ide_startstop_t __ide_dma_queued_write(ide_drive_t *drive);
 extern ide_startstop_t __ide_dma_queued_start(ide_drive_t *drive);
-#else
-static inline int __ide_dma_queued_on(ide_drive_t *drive)
-{
-	return 1;
-}
-
-static inline int __ide_dma_queued_off(ide_drive_t *drive)
-{
-	return 1;
-}
 #endif
 
 #else

_

