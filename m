Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264678AbUKATGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbUKATGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUKASuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:50:22 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37564 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S285745AbUKASZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:25:06 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Mon, 1 Nov 2004 19:26:40 +0100
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411011926.40316.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus!

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/arm/icside.c   |    5 +++++
 drivers/ide/ide-io.c       |   37 ++++++++-----------------------------
 drivers/ide/ide-iops.c     |   16 ++++------------
 drivers/ide/ide-lib.c      |    2 --
 drivers/ide/ide-proc.c     |    6 ++++++
 drivers/ide/ide-taskfile.c |    4 +---
 drivers/ide/ide.c          |   21 ++++++++++++---------
 drivers/ide/ppc/pmac.c     |    2 --
 drivers/ide/setup-pci.c    |    5 +++++
 include/linux/ide.h        |   10 ----------
 10 files changed, 41 insertions(+), 67 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/11/01 1.2428)
   [ide] obsolete "enable DMA by default" config options
   
   CONFIG_IDEDMA_PCI_AUTO and CONFIG_IDEDMA_ICS_AUTO
   
   Host drivers should deal with broken hardware themselves.
   Warn if DMA support is enabled but "enable DMA by default" is not.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/01 1.2427)
   [ide] obsolete some command line parameters
   
   "hdx=autotune", "hdx=noautotune":
   * should be handled by host drivers needing them
   
   "idex=autotune", "idex=noautotune":
   * should die
   
   "idex=ata66":
   * should be handled by host drivers needing it
   
   "idex=dma":
   * works only for: cs5220.c, generic.c, hpt366.c, triflex.c
   * DMA should be used by default
   
   "idex=reset", "idex=serialize":
   * host drivers should set these settings when needed
   
   "idex=base[,ctl[,irq]]":
   * host drivers should auto-detect correct settings
   * ordering should be controlled by user-space
   
   "ide0=four":
   * should be handled by ide-generic driver
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/01 1.2426)
   [ide] obsolete /proc/ide/hd?/settings
   
   Majority of these settings is also available through ioctls.
   We will deal with the rest during deprecation period.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/01 1.2425)
   [ide] remove more dead ide exports
   
   From: Christoph Hellwig <hch@lst.de>
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/arm/icside.c	2004-11-01 18:51:56 +01:00
@@ -197,6 +197,11 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_ICS
+
+#ifndef CONFIG_IDEDMA_ICS_AUTO
+#warning CONFIG_IDEDMA_ICS_AUTO=n support is obsolete, and will be removed soon.
+#endif
+
 /*
  * SG-DMA support.
  *
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide-io.c	2004-11-01 18:51:56 +01:00
@@ -543,8 +543,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(ide_error);
-
 /**
  *	ide_abort	-	abort pending IDE operatins
  *	@drive: drive the error occurred on
@@ -585,8 +583,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(ide_abort);
-
 /**
  *	ide_cmd		-	issue a simple drive command
  *	@drive: drive the command is for
@@ -598,7 +594,8 @@
  *	The drive must be selected beforehand.
  */
 
-void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, ide_handler_t *handler)
+static void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect,
+		ide_handler_t *handler)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	if (IDE_CONTROL_REG)
@@ -608,8 +605,6 @@
 	ide_execute_command(drive, cmd, handler, WAIT_CMD, NULL);
 }
 
-EXPORT_SYMBOL(ide_cmd);
-
 /**
  *	drive_cmd_intr		- 	drive command completion interrupt
  *	@drive: drive the completion interrupt occurred on
@@ -620,7 +615,7 @@
  *	the request
  */
  
-ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
+static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	ide_hwif_t *hwif = HWIF(drive);
@@ -645,8 +640,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(drive_cmd_intr);
-
 /**
  *	do_special		-	issue some special commands
  *	@drive: drive the command is for
@@ -656,7 +649,7 @@
  *	back.
  */
 
-ide_startstop_t do_special (ide_drive_t *drive)
+static ide_startstop_t do_special (ide_drive_t *drive)
 {
 	special_t *s = &drive->special;
 
@@ -673,8 +666,6 @@
 		return DRIVER(drive)->special(drive);
 }
 
-EXPORT_SYMBOL(do_special);
-
 void ide_map_sg(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -715,7 +706,8 @@
  *	all commands to finish. Don't do this as that is due to change
  */
 
-ide_startstop_t execute_drive_cmd (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
+		struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
@@ -805,8 +797,6 @@
  	return ide_stopped;
 }
 
-EXPORT_SYMBOL(execute_drive_cmd);
-
 /**
  *	start_request	-	start of I/O and command issuing for IDE
  *
@@ -818,7 +808,7 @@
  *	FIXME: this function needs a rename
  */
  
-ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
+static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
 	sector_t block;
@@ -909,8 +899,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(start_request);
-
 /**
  *	ide_stall_queue		-	pause an IDE device
  *	@drive: drive to stall
@@ -1033,10 +1021,7 @@
  * the driver.  This makes the driver much more friendlier to shared IRQs
  * than previous designs, while remaining 100% (?) SMP safe and capable.
  */
-/* --BenH: made non-static as ide-pmac.c uses it to kick the hwgroup back
- *         into life on wakeup from machine sleep.
- */ 
-void ide_do_request (ide_hwgroup_t *hwgroup, int masked_irq)
+static void ide_do_request (ide_hwgroup_t *hwgroup, int masked_irq)
 {
 	ide_drive_t	*drive;
 	ide_hwif_t	*hwif;
@@ -1168,8 +1153,6 @@
 	}
 }
 
-EXPORT_SYMBOL(ide_do_request);
-
 /*
  * Passes the stuff to ide_do_request
  */
@@ -1334,8 +1317,6 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-EXPORT_SYMBOL(ide_timer_expiry);
-
 /**
  *	unexpected_intr		-	handle an unexpected IDE interrupt
  *	@irq: interrupt line
@@ -1532,8 +1513,6 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return IRQ_HANDLED;
 }
-
-EXPORT_SYMBOL(ide_intr);
 
 /**
  *	ide_init_drive_cmd	-	initialize a drive command request
diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide-iops.c	2004-11-01 18:51:56 +01:00
@@ -673,8 +673,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(ide_ata66_check);
-
 /*
  * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
  * 1 : Safe to update drive->id DMA registers.
@@ -693,9 +691,8 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(set_transfer);
-
-u8 ide_auto_reduce_xfer (ide_drive_t *drive)
+#ifdef CONFIG_BLK_DEV_IDEDMA
+static u8 ide_auto_reduce_xfer (ide_drive_t *drive)
 {
 	if (!drive->crc_count)
 		return drive->current_speed;
@@ -719,8 +716,7 @@
 		default:		return XFER_PIO_4;
 	}
 }
-
-EXPORT_SYMBOL(ide_auto_reduce_xfer);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
  * Update the 
@@ -795,8 +791,6 @@
 #endif
 }
 
-EXPORT_SYMBOL(ide_driveid_update);
-
 /*
  * Similar to ide_wait_stat(), except it never calls ide_error internally.
  * This is a kludge to handle the new ide_config_drive_speed() function,
@@ -936,7 +930,7 @@
  *
  * See also ide_execute_command
  */
-void __ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
+static void __ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
 		      unsigned int timeout, ide_expiry_t *expiry)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -951,8 +945,6 @@
 	hwgroup->timer.expires	= jiffies + timeout;
 	add_timer(&hwgroup->timer);
 }
-
-EXPORT_SYMBOL(__ide_set_handler);
 
 void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
 		      unsigned int timeout, ide_expiry_t *expiry)
diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide-lib.c	2004-11-01 18:51:56 +01:00
@@ -421,8 +421,6 @@
 		blk_queue_bounce_limit(drive->queue, addr);
 }
 
-EXPORT_SYMBOL(ide_toggle_bounce);
-
 /**
  *	ide_set_xfer_rate	-	set transfer rate
  *	@drive: drive to set
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide-proc.c	2004-11-01 18:51:56 +01:00
@@ -132,6 +132,9 @@
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
 
+	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
+			    "obsolete, and will be removed soon!\n");
+
 	down(&ide_setting_sem);
 	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
 	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
@@ -167,6 +170,9 @@
 	unsigned long	n;
 	ide_settings_t	*setting;
 	char *buf, *s;
+
+	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
+			    "obsolete, and will be removed soon!\n");
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide-taskfile.c	2004-11-01 18:51:56 +01:00
@@ -419,7 +419,7 @@
 /*
  * Handler for command with PIO data-out phase (Write/Write Multiple).
  */
-ide_startstop_t task_out_intr (ide_drive_t *drive)
+static ide_startstop_t task_out_intr (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -443,8 +443,6 @@
 
 	return ide_started;
 }
-
-EXPORT_SYMBOL(task_out_intr);
 
 ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ide.c	2004-11-01 18:51:56 +01:00
@@ -1882,10 +1882,10 @@
 				goto do_serialize;
 			case -6: /* "autotune" */
 				drive->autotune = IDE_TUNE_AUTO;
-				goto done;
+				goto obsolete_option;
 			case -7: /* "noautotune" */
 				drive->autotune = IDE_TUNE_NOAUTO;
-				goto done;
+				goto obsolete_option;
 			case -9: /* "swapdata" */
 			case -10: /* "bswap" */
 				drive->bswap = 1;
@@ -2017,30 +2017,30 @@
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 				hwif->udma_four = 1;
-				goto done;
+				goto obsolete_option;
 #else
 				goto bad_hwif;
 #endif
 			case -6: /* dma */
 				hwif->autodma = 1;
-				goto done;
+				goto obsolete_option;
 			case -5: /* "reset" */
 				hwif->reset = 1;
-				goto done;
+				goto obsolete_option;
 			case -4: /* "noautotune" */
 				hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
 				hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
-				goto done;
+				goto obsolete_option;
 			case -3: /* "autotune" */
 				hwif->drives[0].autotune = IDE_TUNE_AUTO;
 				hwif->drives[1].autotune = IDE_TUNE_AUTO;
-				goto done;
+				goto obsolete_option;
 			case -2: /* "serialize" */
 			do_serialize:
 				hwif->mate = &ide_hwifs[hw^1];
 				hwif->mate->mate = hwif;
 				hwif->serialized = hwif->mate->serialized = 1;
-				goto done;
+				goto obsolete_option;
 
 			case -1: /* "noprobe" */
 				hwif->noprobe = 1;
@@ -2057,7 +2057,7 @@
 				hwif->irq      = vals[2];
 				hwif->noprobe  = 0;
 				hwif->chipset  = ide_forced;
-				goto done;
+				goto obsolete_option;
 
 			case 0: goto bad_option;
 			default:
@@ -2067,6 +2067,9 @@
 	}
 bad_option:
 	printk(" -- BAD OPTION\n");
+	return 1;
+obsolete_option:
+	printk(" -- OBSOLETE OPTION, WILL BE REMOVED SOON!\n");
 	return 1;
 bad_hwif:
 	printk("-- NOT SUPPORTED ON ide%d", hw);
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/ppc/pmac.c	2004-11-01 18:51:56 +01:00
@@ -52,8 +52,6 @@
 
 #include "ide-timing.h"
 
-extern void ide_do_request(ide_hwgroup_t *hwgroup, int masked_irq);
-
 #define IDE_PMAC_DEBUG
 
 #define DMA_WAIT_TIMEOUT	50
diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2004-11-01 18:51:56 +01:00
+++ b/drivers/ide/setup-pci.c	2004-11-01 18:51:56 +01:00
@@ -494,6 +494,11 @@
 		}
 	}
 }
+
+#ifndef CONFIG_IDEDMA_PCI_AUTO
+#warning CONFIG_IDEDMA_PCI_AUTO=n support is obsolete, and will be removed soon.
+#endif
+
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI*/
 
 /**
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-11-01 18:51:56 +01:00
+++ b/include/linux/ide.h	2004-11-01 18:51:56 +01:00
@@ -1194,14 +1194,6 @@
  */
 extern ide_startstop_t ide_abort(ide_drive_t *, const char *);
 
-/*
- * Issue a simple drive command
- * The drive must be selected beforehand.
- *
- * (drive, command, nsector, handler)
- */
-extern void ide_cmd(ide_drive_t *, u8, u8, ide_handler_t *);
-
 extern void ide_fix_driveid(struct hd_driveid *);
 /*
  * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
@@ -1366,7 +1358,6 @@
 extern ide_startstop_t task_no_data_intr(ide_drive_t *);
 extern ide_startstop_t task_in_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
-extern ide_startstop_t task_out_intr(ide_drive_t *);
 
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
 
@@ -1376,7 +1367,6 @@
 
 extern int system_bus_clock(void);
 
-extern u8 ide_auto_reduce_xfer(ide_drive_t *);
 extern int ide_driveid_update(ide_drive_t *);
 extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
 extern int ide_config_drive_speed(ide_drive_t *, u8);
