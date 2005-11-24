Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVKXQ1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVKXQ1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKXQ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:27:19 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:44907 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbVKXQ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:26:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=RHACNdrYuWURITELP9NoIusNamTkl95VpMBZJQOmY2epdAn5AbNqbWcwJfSM0D9i531pUb7z+V4hrLNDoU8Gq5T8qcAxwylRHbQGm+CcLgKXBCn9CgtZpBbBqrttPtlILjETsWQ3gtwzbFf4gcQDBUhoLmsVsNHK8kojaec1e60=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/11] blk: implement ide_driver_t->protocol_changed callback
Message-ID: <20051124162449.28818B0D@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:26:26 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09_blk_ide-add-protocol_changed.patch

	This patch implements protocol_changed callback for IDE HL
	drivers.  The callback is called whenever transfer protocol
	changes (DMA / multisector PIO / PIO).  The callback is
	sometimes with context and sometimes without, sometimes with
	queuelock, sometimes not.  So, actual callbacks should be
	written carefully.

	To hook dma setting changes, this function implements
	ide_dma_on() and ide_dma_off_quietly() which notifies protocl
	change and calls low level driver callback.  __ide_dma_off()
	is renamed to ide_dma_off() for consistency.  All dma on/off
	operations must be done by using these wrapper functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/arm/icside.c       |    4 +-
 drivers/ide/cris/ide-cris.c    |    5 +--
 drivers/ide/ide-cd.c           |    6 ++--
 drivers/ide/ide-dma.c          |   60 ++++++++++++++++++++++++++++++++++-------
 drivers/ide/ide-floppy.c       |    4 +-
 drivers/ide/ide-io.c           |    4 +-
 drivers/ide/ide-iops.c         |   38 +++++++++++++++++++++++--
 drivers/ide/ide-probe.c        |   19 +++++++++---
 drivers/ide/ide-tape.c         |    4 +-
 drivers/ide/ide-taskfile.c     |    1 
 drivers/ide/ide.c              |    4 +-
 drivers/ide/pci/aec62xx.c      |    5 +--
 drivers/ide/pci/alim15x3.c     |    6 ++--
 drivers/ide/pci/amd74xx.c      |    4 +-
 drivers/ide/pci/atiixp.c       |    4 +-
 drivers/ide/pci/cmd64x.c       |    5 +--
 drivers/ide/pci/cs5520.c       |    6 +---
 drivers/ide/pci/cs5530.c       |    4 +-
 drivers/ide/pci/cs5535.c       |    5 +--
 drivers/ide/pci/hpt34x.c       |    7 ++--
 drivers/ide/pci/hpt366.c       |    5 +--
 drivers/ide/pci/it8172.c       |    5 +--
 drivers/ide/pci/it821x.c       |    8 ++---
 drivers/ide/pci/ns87415.c      |    2 -
 drivers/ide/pci/pdc202xx_new.c |    4 +-
 drivers/ide/pci/pdc202xx_old.c |    4 +-
 drivers/ide/pci/piix.c         |    4 +-
 drivers/ide/pci/sc1200.c       |    8 ++---
 drivers/ide/pci/serverworks.c  |    5 +--
 drivers/ide/pci/siimage.c      |    5 +--
 drivers/ide/pci/sis5513.c      |    9 ++----
 drivers/ide/pci/sl82c105.c     |    8 ++---
 drivers/ide/pci/slc90e66.c     |    4 +-
 drivers/ide/pci/triflex.c      |    4 +-
 drivers/ide/pci/via82cxxx.c    |    4 +-
 include/linux/ide.h            |   14 ++++++++-
 36 files changed, 183 insertions(+), 105 deletions(-)

Index: work/drivers/ide/cris/ide-cris.c
===================================================================
--- work.orig/drivers/ide/cris/ide-cris.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/cris/ide-cris.c	2005-11-25 00:52:03.000000000 +0900
@@ -1046,17 +1046,16 @@ static ide_startstop_t cris_dma_intr (id
 
 static int cris_dma_check(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
 	struct hd_driveid* id = drive->id;
 
 	if (id && (id->capability & 1)) {
 		if (ide_use_dma(drive)) {
 			if (cris_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 	}
 
-	return hwif->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 static int cris_dma_end(ide_drive_t *drive)
Index: work/drivers/ide/ide-cd.c
===================================================================
--- work.orig/drivers/ide/ide-cd.c	2005-11-25 00:52:01.000000000 +0900
+++ work/drivers/ide/ide-cd.c	2005-11-25 00:52:03.000000000 +0900
@@ -1032,7 +1032,7 @@ static ide_startstop_t cdrom_read_intr (
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive)))
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat))
@@ -1632,7 +1632,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (dma) {
 		if (dma_error) {
 			printk(KERN_ERR "ide-cd: dma error\n");
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 			return ide_error(drive, "dma error", stat);
 		}
 
@@ -1759,7 +1759,7 @@ static ide_startstop_t cdrom_write_intr(
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
 			printk(KERN_ERR "ide-cd: write dma error\n");
-			__ide_dma_off(drive);
+			ide_dma_off(drive);
 		}
 	}
 
Index: work/drivers/ide/ide-dma.c
===================================================================
--- work.orig/drivers/ide/ide-dma.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-dma.c	2005-11-25 00:52:03.000000000 +0900
@@ -363,7 +363,7 @@ static int config_drive_for_dma (ide_dri
 		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
 		 */
 		if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x7f))
-			return hwif->ide_dma_on(drive);
+			return ide_dma_on(drive);
 		/*
 		 * Enable DMA on any drive that has mode2 DMA
 		 * (multi or single) enabled
@@ -371,14 +371,14 @@ static int config_drive_for_dma (ide_dri
 		if (id->field_valid & 2)	/* regular DMA */
 			if ((id->dma_mword & 0x404) == 0x404 ||
 			    (id->dma_1word & 0x404) == 0x404)
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 
 		/* Consult the list of known "good" drives */
 		if (__ide_dma_good_drive(drive))
-			return hwif->ide_dma_on(drive);
+			return ide_dma_on(drive);
 	}
 //	if (hwif->tuneproc != NULL) hwif->tuneproc(drive, 255);
-	return hwif->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 /**
@@ -463,20 +463,62 @@ EXPORT_SYMBOL(__ide_dma_off_quietly);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
- *	__ide_dma_off	-	disable DMA on a device
+ *	ide_dma_on	-	enable DMA on a device
+ *	@drive: drive to enable DMA on
+ *
+ *	Enable IDE DMA for a device on this IDE controller.
+ */
+
+int ide_dma_on (ide_drive_t *drive)
+{
+	int ret;
+
+	ret = drive->hwif->ide_dma_on(drive);
+	if (ret == 0)
+		ide_protocol_changed(drive);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(ide_dma_on);
+
+/**
+ *
+ *	ide_dma_off_quietly	-	disable DMA on a device
+ *	@drive: drive to disable DMA on
+ *
+ *	Disable IDE DMA for a device on this IDE controller.
+ */
+
+int ide_dma_off_quietly (ide_drive_t *drive)
+{
+	int ret;
+
+	ret = drive->hwif->ide_dma_off_quietly(drive);
+
+	/* drive->using_dma is turned off even on failures */
+	ide_protocol_changed(drive);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(ide_dma_off_quietly);
+
+/**
+ *	ide_dma_off	-	disable DMA on a device
  *	@drive: drive to disable DMA on
  *
  *	Disable IDE DMA for a device on this IDE controller.
  *	Inform the user that DMA has been disabled.
  */
 
-int __ide_dma_off (ide_drive_t *drive)
+int ide_dma_off (ide_drive_t *drive)
 {
 	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_off);
+EXPORT_SYMBOL(ide_dma_off);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
@@ -760,7 +802,7 @@ void ide_dma_verbose(ide_drive_t *drive)
 	return;
 bug_dma_off:
 	printk(", BUG DMA OFF");
-	hwif->ide_dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 	return;
 }
 
Index: work/drivers/ide/ide-floppy.c
===================================================================
--- work.orig/drivers/ide/ide-floppy.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-floppy.c	2005-11-25 00:52:03.000000000 +0900
@@ -866,7 +866,7 @@ static ide_startstop_t idefloppy_pc_intr
 	if (test_and_clear_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
 		printk(KERN_ERR "ide-floppy: The floppy wants to issue "
 			"more interrupts in DMA mode\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 
@@ -1101,7 +1101,7 @@ static ide_startstop_t idefloppy_issue_p
 	bcount.all = min(pc->request_transfer, 63 * 1024);
 
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 	}
 	feature.all = 0;
 
Index: work/drivers/ide/ide-io.c
===================================================================
--- work.orig/drivers/ide/ide-io.c	2005-11-25 00:52:03.000000000 +0900
+++ work/drivers/ide/ide-io.c	2005-11-25 00:52:03.000000000 +0900
@@ -78,7 +78,7 @@ int __ide_end_request(ide_drive_t *drive
 	 */
 	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
 		drive->state = 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
+		ide_dma_on(drive);
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
@@ -1270,7 +1270,7 @@ static ide_startstop_t ide_dma_timeout_r
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	(void) hwif->ide_dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
Index: work/drivers/ide/ide-iops.c
===================================================================
--- work.orig/drivers/ide/ide-iops.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-iops.c	2005-11-25 00:52:03.000000000 +0900
@@ -852,7 +852,7 @@ int ide_config_drive_speed (ide_drive_t 
 	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
 	else if (hwif->ide_dma_check)	/* check if host supports DMA */
-		hwif->ide_dma_off_quietly(drive);
+		ide_dma_off_quietly(drive);
 #endif
 
 	switch(speed) {
@@ -1063,12 +1063,12 @@ static void check_dma_crc(ide_drive_t *d
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->crc_count) {
-		(void) HWIF(drive)->ide_dma_off_quietly(drive);
+		ide_dma_off_quietly(drive);
 		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >= XFER_SW_DMA_0)
-			(void) HWIF(drive)->ide_dma_on(drive);
+			ide_dma_on(drive);
 	} else
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 #endif
 }
 
@@ -1085,6 +1085,8 @@ static void ide_disk_pre_reset(ide_drive
 		drive->mult_req = 0;
 	if (drive->mult_req != drive->mult_count)
 		drive->special.b.set_multmode = 1;
+	else
+		ide_protocol_changed(drive);
 }
 
 static void pre_reset(ide_drive_t *drive)
@@ -1249,3 +1251,31 @@ int ide_wait_not_busy(ide_hwif_t *hwif, 
 
 EXPORT_SYMBOL_GPL(ide_wait_not_busy);
 
+void ide_protocol_changed(ide_drive_t *drive)
+{
+	struct device *gendev = &drive->gendev;
+	ide_driver_t *drv;
+
+	if (!drive->initialized)
+		return;
+	smp_rmb();
+
+	/*
+	 * XXX: down() is more correct here but this function can be
+	 * called from interrupt context.  As gendev->sem is used only
+	 * during driver attach/detach, the following should be good
+	 * enough for most cases.
+	 */
+	if (down_trylock(&gendev->sem))
+		return;
+
+	if (gendev->driver) {
+		drv = to_ide_driver(gendev->driver);
+		if (drv->protocol_changed)
+			drv->protocol_changed(drive);
+	}
+
+	up(&gendev->sem);
+}
+
+EXPORT_SYMBOL(ide_protocol_changed);
Index: work/drivers/ide/ide-probe.c
===================================================================
--- work.orig/drivers/ide/ide-probe.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-probe.c	2005-11-25 00:52:03.000000000 +0900
@@ -885,7 +885,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 				 * things, if not checked and cleared.
 				 *   PARANOIA!!!
 				 */
-				hwif->ide_dma_off_quietly(drive);
+				ide_dma_off_quietly(drive);
 #ifdef CONFIG_IDEDMA_ONLYDISK
 				if (drive->media == ide_disk)
 #endif
@@ -918,7 +918,9 @@ int probe_hwif_init_with_fixup(ide_hwif_
 			   want them on default or a new "empty" class
 			   for hotplug reprobing ? */
 			if (drive->present) {
-				device_register(&drive->gendev);
+				device_initialize(&drive->gendev);
+				drive->initialized = 1;
+				device_add(&drive->gendev);
 			}
 		}
 	}
@@ -1317,6 +1319,7 @@ static void drive_release_dev (struct de
 	ide_remove_drive_from_hwgroup(drive);
 	kfree(drive->id);
 	drive->id = NULL;
+	drive->initialized = 0;
 	drive->present = 0;
 	/* Messed up locking ... */
 	spin_unlock_irq(&ide_lock);
@@ -1451,9 +1454,15 @@ int ideprobe_init (void)
 				continue;
 			if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced)
 				hwif->chipset = ide_generic;
-			for (unit = 0; unit < MAX_DRIVES; ++unit)
-				if (hwif->drives[unit].present)
-					device_register(&hwif->drives[unit].gendev);
+			for (unit = 0; unit < MAX_DRIVES; ++unit) {
+				ide_drive_t *drive = &hwif->drives[unit];
+				if (drive->present) {
+					device_initialize(&drive->gendev);
+					smp_wmb();
+					drive->initialized = 1;
+					device_add(&drive->gendev);
+				}
+			}
 		}
 	}
 	return 0;
Index: work/drivers/ide/ide-tape.c
===================================================================
--- work.orig/drivers/ide/ide-tape.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-tape.c	2005-11-25 00:52:03.000000000 +0900
@@ -1970,7 +1970,7 @@ static ide_startstop_t idetape_pc_intr (
 		printk(KERN_ERR "ide-tape: The tape wants to issue more "
 				"interrupts in DMA mode\n");
 		printk(KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 		return ide_do_reset(drive);
 	}
 	/* Get the number of bytes to transfer on this interrupt. */
@@ -2176,7 +2176,7 @@ static ide_startstop_t idetape_issue_pac
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
 				"reverting to PIO\n");
-		(void)__ide_dma_off(drive);
+		ide_dma_off(drive);
 	}
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
 		dma_ok = !hwif->dma_setup(drive);
Index: work/drivers/ide/ide-taskfile.c
===================================================================
--- work.orig/drivers/ide/ide-taskfile.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-taskfile.c	2005-11-25 00:52:03.000000000 +0900
@@ -176,6 +176,7 @@ ide_startstop_t set_multmode_intr (ide_d
 		drive->special.b.recalibrate = 1;
 		(void) ide_dump_status(drive, "set_multmode", stat);
 	}
+	ide_protocol_changed(drive);
 	return ide_stopped;
 }
 
Index: work/drivers/ide/ide.c
===================================================================
--- work.orig/drivers/ide/ide.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide.c	2005-11-25 00:52:03.000000000 +0900
@@ -1136,9 +1136,9 @@ static int set_using_dma (ide_drive_t *d
 		return -EPERM;
 	if (arg) {
 		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
-		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
+		if (ide_dma_on(drive)) return -EIO;
 	} else {
-		if (__ide_dma_off(drive))
+		if (ide_dma_off(drive))
 			return -EIO;
 	}
 	return 0;
Index: work/include/linux/ide.h
===================================================================
--- work.orig/include/linux/ide.h	2005-11-25 00:51:37.000000000 +0900
+++ work/include/linux/ide.h	2005-11-25 00:52:03.000000000 +0900
@@ -697,6 +697,7 @@ typedef struct ide_drive_s {
 	u8	nice1;			/* give potential excess bandwidth */
 
 	unsigned present	: 1;	/* drive is physically present */
+	unsigned initialized	: 1;	/* drive is probed & initialized */
 	unsigned dead		: 1;	/* device ejected hint */
 	unsigned id_read	: 1;	/* 1=id read from disk 0 = synthetic */
 	unsigned noprobe 	: 1;	/* from:  hdx=noprobe */
@@ -1103,9 +1104,12 @@ typedef struct ide_driver_s {
 	ide_proc_entry_t	*proc;
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	void		(*protocol_changed)(ide_drive_t *);
 	struct device_driver	gen_driver;
 } ide_driver_t;
 
+#define to_ide_driver(drv)	container_of(drv, ide_driver_t, gen_driver)
+
 int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);
 
 /*
@@ -1312,6 +1316,8 @@ extern int taskfile_lib_get_identify(ide
 
 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 
+extern void ide_protocol_changed(ide_drive_t *drive);
+
 /*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
  * to the hwgroup by sleeping for timeout jiffies.
@@ -1398,7 +1404,9 @@ void ide_init_sg_cmd(ide_drive_t *, stru
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 int ide_use_dma(ide_drive_t *);
-int __ide_dma_off(ide_drive_t *);
+int ide_dma_on(ide_drive_t *);
+int ide_dma_off_quietly(ide_drive_t *);
+int ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
 
@@ -1423,7 +1431,9 @@ extern int __ide_dma_timeout(ide_drive_t
 
 #else
 static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
-static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
+static inline int ide_dma_on(ide_drive_t *drive) { return 0; }
+static inline int ide_dma_off_quietly(ide_drive_t *drive) { return 0; }
+static inline int ide_dma_off(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
Index: work/drivers/ide/arm/icside.c
===================================================================
--- work.orig/drivers/ide/arm/icside.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/arm/icside.c	2005-11-25 00:52:03.000000000 +0900
@@ -367,9 +367,9 @@ out:
 	on = icside_set_speed(drive, xfer_mode);
 
 	if (on)
-		return icside_dma_on(drive);
+		return ide_dma_on(drive);
 	else
-		return icside_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 }
 
 static int icside_dma_end(ide_drive_t *drive)
Index: work/drivers/ide/pci/aec62xx.c
===================================================================
--- work.orig/drivers/ide/pci/aec62xx.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/aec62xx.c	2005-11-25 00:52:03.000000000 +0900
@@ -231,14 +231,13 @@ static void aec62xx_tune_drive (ide_driv
 
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	if ((id->capability & 1) && drive->autodma) {
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -246,7 +245,7 @@ static int aec62xx_config_drive_xfer_rat
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		aec62xx_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/alim15x3.c
===================================================================
--- work.orig/drivers/ide/pci/alim15x3.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/alim15x3.c	2005-11-25 00:52:03.000000000 +0900
@@ -518,7 +518,7 @@ static int ali15x3_config_drive_for_dma(
 	struct hd_driveid *id	= drive->id;
 
 	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 
 	drive->init_speed = 0;
 
@@ -553,9 +553,9 @@ try_dma_modes:
 ata_pio:
 		hwif->tuneproc(drive, 255);
 no_dma_set:
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
-	return hwif->ide_dma_on(drive);
+	return ide_dma_on(drive);
 }
 
 /**
Index: work/drivers/ide/pci/amd74xx.c
===================================================================
--- work.orig/drivers/ide/pci/amd74xx.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/amd74xx.c	2005-11-25 00:52:03.000000000 +0900
@@ -302,8 +302,8 @@ static int amd74xx_ide_dma_check(ide_dri
 	amd_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return ide_dma_on(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 /*
Index: work/drivers/ide/pci/atiixp.c
===================================================================
--- work.orig/drivers/ide/pci/atiixp.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/atiixp.c	2005-11-25 00:52:03.000000000 +0900
@@ -264,7 +264,7 @@ static int atiixp_dma_check(ide_drive_t 
 
 		if (ide_use_dma(drive)) {
 			if (atiixp_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -274,7 +274,7 @@ fast_ata_pio:
 		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
 		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
 		hwif->speedproc(drive, speed);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/cmd64x.c
===================================================================
--- work.orig/drivers/ide/pci/cmd64x.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/cmd64x.c	2005-11-25 00:52:03.000000000 +0900
@@ -486,14 +486,13 @@ static int config_chipset_for_dma (ide_d
 
 static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -501,7 +500,7 @@ static int cmd64x_config_drive_for_dma (
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		config_chipset_for_pio(drive, 1);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/cs5520.c
===================================================================
--- work.orig/drivers/ide/pci/cs5520.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/cs5520.c	2005-11-25 00:52:03.000000000 +0900
@@ -120,7 +120,7 @@ static int cs5520_tune_chipset(ide_drive
 	error = ide_config_drive_speed(drive, speed);
 	/* ATAPI is harder so leave it for now */
 	if(!error && drive->media == ide_disk)
-		error = hwif->ide_dma_on(drive);
+		error = ide_dma_on(drive);
 
 	return error;
 }	
@@ -133,12 +133,10 @@ static void cs5520_tune_drive(ide_drive_
 
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-
 	/* Tune the drive for PIO modes up to PIO 4 */	
 	cs5520_tune_drive(drive, 4);
 	/* Then tell the core to use DMA operations */
-	return hwif->ide_dma_on(drive);
+	return ide_dma_on(drive);
 }
 
 /*
Index: work/drivers/ide/pci/cs5530.c
===================================================================
--- work.orig/drivers/ide/pci/cs5530.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/cs5530.c	2005-11-25 00:52:03.000000000 +0900
@@ -110,7 +110,7 @@ static int cs5530_config_dma (ide_drive_
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
-	hwif->ide_dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 	/* turn off DMA while we fiddle */
 	hwif->ide_dma_host_off(drive);
 	/* clear DMA_capable bit */
@@ -206,7 +206,7 @@ static int cs5530_config_dma (ide_drive_
 	/*
 	 * Finally, turn DMA on in software, and exit.
 	 */
-	return hwif->ide_dma_on(drive);	/* success */
+	return ide_dma_on(drive);	/* success */
 }
 
 /**
Index: work/drivers/ide/pci/cs5535.c
===================================================================
--- work.orig/drivers/ide/pci/cs5535.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/cs5535.c	2005-11-25 00:52:03.000000000 +0900
@@ -196,7 +196,6 @@ static int cs5535_config_drive_for_dma(i
 
 static int cs5535_dma_check(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
 	struct hd_driveid *id	= drive->id;
 	u8 speed;
 
@@ -205,7 +204,7 @@ static int cs5535_dma_check(ide_drive_t 
 	if ((id->capability & 1) && drive->autodma) {
 		if (ide_use_dma(drive)) {
 			if (cs5535_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -214,7 +213,7 @@ static int cs5535_dma_check(ide_drive_t 
 fast_ata_pio:
 		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
 		cs5535_set_drive(drive, speed);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/hpt34x.c
===================================================================
--- work.orig/drivers/ide/pci/hpt34x.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/hpt34x.c	2005-11-25 00:52:03.000000000 +0900
@@ -125,7 +125,6 @@ static int config_chipset_for_dma (ide_d
 
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
@@ -135,9 +134,9 @@ static int hpt34x_config_drive_xfer_rate
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
 #ifndef CONFIG_HPT34X_AUTODMA
-				return hwif->ide_dma_off_quietly(drive);
+				return ide_dma_off_quietly(drive);
 #else
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 #endif
 		}
 
@@ -146,7 +145,7 @@ static int hpt34x_config_drive_xfer_rate
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		hpt34x_tune_drive(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/hpt366.c
===================================================================
--- work.orig/drivers/ide/pci/hpt366.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/hpt366.c	2005-11-25 00:52:03.000000000 +0900
@@ -811,7 +811,6 @@ static void hpt3xx_maskproc (ide_drive_t
 
 static int hpt366_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
@@ -820,7 +819,7 @@ static int hpt366_config_drive_xfer_rate
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -828,7 +827,7 @@ static int hpt366_config_drive_xfer_rate
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		hpt3xx_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/it8172.c
===================================================================
--- work.orig/drivers/ide/pci/it8172.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/it8172.c	2005-11-25 00:52:03.000000000 +0900
@@ -193,7 +193,6 @@ static int it8172_config_chipset_for_dma
 
 static int it8172_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
@@ -202,7 +201,7 @@ static int it8172_config_drive_xfer_rate
 
 		if (ide_use_dma(drive)) {
 			if (it8172_config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -210,7 +209,7 @@ static int it8172_config_drive_xfer_rate
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		it8172_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/it821x.c
===================================================================
--- work.orig/drivers/ide/pci/it821x.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/it821x.c	2005-11-25 00:52:03.000000000 +0900
@@ -516,14 +516,12 @@ static int config_chipset_for_dma (ide_d
 
 static int it821x_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-
 	if (ide_use_dma(drive)) {
 		if (config_chipset_for_dma(drive))
-			return hwif->ide_dma_on(drive);
+			return ide_dma_on(drive);
 	}
 	config_it821x_chipset_for_pio(drive, 1);
-	return hwif->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 /**
@@ -604,7 +602,7 @@ static void __devinit it821x_fixups(ide_
 				printk(".\n");
 			/* Now the core code will have wrongly decided no DMA
 			   so we need to fix this */
-			hwif->ide_dma_off_quietly(drive);
+			ide_dma_off_quietly(drive);
 #ifdef CONFIG_IDEDMA_ONLYDISK
 			if (drive->media == ide_disk)
 #endif
Index: work/drivers/ide/pci/ns87415.c
===================================================================
--- work.orig/drivers/ide/pci/ns87415.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/ns87415.c	2005-11-25 00:52:03.000000000 +0900
@@ -191,7 +191,7 @@ static int ns87415_ide_dma_setup(ide_dri
 static int ns87415_ide_dma_check (ide_drive_t *drive)
 {
 	if (drive->media != ide_disk)
-		return HWIF(drive)->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	return __ide_dma_check(drive);
 }
 
Index: work/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- work.orig/drivers/ide/pci/pdc202xx_new.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/pdc202xx_new.c	2005-11-25 00:52:03.000000000 +0900
@@ -228,7 +228,7 @@ static int pdcnew_config_drive_xfer_rate
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -236,7 +236,7 @@ static int pdcnew_config_drive_xfer_rate
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- work.orig/drivers/ide/pci/pdc202xx_old.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/pdc202xx_old.c	2005-11-25 00:52:03.000000000 +0900
@@ -389,7 +389,7 @@ static int pdc202xx_config_drive_xfer_ra
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -397,7 +397,7 @@ static int pdc202xx_config_drive_xfer_ra
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/piix.c
===================================================================
--- work.orig/drivers/ide/pci/piix.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/piix.c	2005-11-25 00:52:03.000000000 +0900
@@ -406,7 +406,7 @@ static int piix_config_drive_xfer_rate (
 
 		if (ide_use_dma(drive)) {
 			if (piix_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -415,7 +415,7 @@ static int piix_config_drive_xfer_rate (
 fast_ata_pio:
 		/* Find best PIO mode. */
 		hwif->tuneproc(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/sc1200.c
===================================================================
--- work.orig/drivers/ide/pci/sc1200.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/sc1200.c	2005-11-25 00:52:03.000000000 +0900
@@ -162,7 +162,7 @@ static int sc1200_config_dma2 (ide_drive
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
-	hwif->ide_dma_off_quietly(drive);			/* turn off DMA while we fiddle */
+	ide_dma_off_quietly(drive);			/* turn off DMA while we fiddle */
 	outb(inb(hwif->dma_base+2)&~(unit?0x40:0x20), hwif->dma_base+2); /* clear DMA_capable bit */
 
 	/*
@@ -245,7 +245,7 @@ static int sc1200_config_dma2 (ide_drive
 	/*
 	 * Finally, turn DMA on in software, and exit.
 	 */
-	return hwif->ide_dma_on(drive);	/* success */
+	return ide_dma_on(drive);	/* success */
 }
 
 /*
@@ -444,10 +444,10 @@ printk("%s: SC1200: resume\n", hwif->nam
 			ide_drive_t *drive = &(hwif->drives[d]);
 			if (drive->present && !__ide_dma_bad_drive(drive)) {
 				int was_using_dma = drive->using_dma;
-				hwif->ide_dma_off_quietly(drive);
+				ide_dma_off_quietly(drive);
 				sc1200_config_dma(drive);
 				if (!was_using_dma && drive->using_dma) {
-					hwif->ide_dma_off_quietly(drive);
+					ide_dma_off_quietly(drive);
 				}
 			}
 		}
Index: work/drivers/ide/pci/serverworks.c
===================================================================
--- work.orig/drivers/ide/pci/serverworks.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/serverworks.c	2005-11-25 00:52:03.000000000 +0900
@@ -316,7 +316,6 @@ static int config_chipset_for_dma (ide_d
 
 static int svwks_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
@@ -325,7 +324,7 @@ static int svwks_config_drive_xfer_rate 
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -334,7 +333,7 @@ static int svwks_config_drive_xfer_rate 
 fast_ata_pio:
 		config_chipset_for_pio(drive);
 		//	hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/siimage.c
===================================================================
--- work.orig/drivers/ide/pci/siimage.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/siimage.c	2005-11-25 00:52:03.000000000 +0900
@@ -416,14 +416,13 @@ static int config_chipset_for_dma (ide_d
  
 static int siimage_config_drive_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	if ((id->capability & 1) != 0 && drive->autodma) {
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -431,7 +430,7 @@ static int siimage_config_drive_for_dma 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		config_chipset_for_pio(drive, 1);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/sis5513.c
===================================================================
--- work.orig/drivers/ide/pci/sis5513.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/sis5513.c	2005-11-25 00:52:03.000000000 +0900
@@ -665,7 +665,6 @@ static int config_chipset_for_dma (ide_d
 
 static int sis5513_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
@@ -674,7 +673,7 @@ static int sis5513_config_drive_xfer_rat
 
 		if (ide_use_dma(drive)) {
 			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -682,7 +681,7 @@ static int sis5513_config_drive_xfer_rat
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		sis5513_tune_drive(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
@@ -720,8 +719,8 @@ static int sis5513_config_xfer_rate (ide
 	sis5513_tune_chipset(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return ide_dma_on(drive);
+	return ide_dma_off_quietly(drive);
 }
 */
 
Index: work/drivers/ide/pci/sl82c105.c
===================================================================
--- work.orig/drivers/ide/pci/sl82c105.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/sl82c105.c	2005-11-25 00:52:03.000000000 +0900
@@ -162,14 +162,14 @@ static int sl82c105_check_drive (ide_dri
 		if (id->field_valid & 2) {
 			if ((id->dma_mword & hwif->mwdma_mask) ||
 			    (id->dma_1word & hwif->swdma_mask))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		if (__ide_dma_good_drive(drive))
-			return hwif->ide_dma_on(drive);
+			return ide_dma_on(drive);
 	} while (0);
 
-	return hwif->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 /*
@@ -262,7 +262,7 @@ static int sl82c105_ide_dma_on (ide_driv
 
 	if (config_for_dma(drive)) {
 		config_for_pio(drive, 4, 0, 0);
-		return HWIF(drive)->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	return __ide_dma_on(drive);
Index: work/drivers/ide/pci/slc90e66.c
===================================================================
--- work.orig/drivers/ide/pci/slc90e66.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/slc90e66.c	2005-11-25 00:52:03.000000000 +0900
@@ -181,7 +181,7 @@ static int slc90e66_config_drive_xfer_ra
 
 		if (ide_use_dma(drive)) {
 			if (slc90e66_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 
 		goto fast_ata_pio;
@@ -189,7 +189,7 @@ static int slc90e66_config_drive_xfer_ra
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
 		hwif->tuneproc(drive, 5);
-		return hwif->ide_dma_off_quietly(drive);
+		return ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
 	return 0;
Index: work/drivers/ide/pci/triflex.c
===================================================================
--- work.orig/drivers/ide/pci/triflex.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/triflex.c	2005-11-25 00:52:03.000000000 +0900
@@ -122,12 +122,12 @@ static int triflex_config_drive_xfer_rat
 	if ((id->capability & 1) && drive->autodma) {
 		if (ide_use_dma(drive)) {
 			if (triflex_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
+				return ide_dma_on(drive);
 		}
 	}
 
 	hwif->tuneproc(drive, 255);
-	return hwif->ide_dma_off_quietly(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
Index: work/drivers/ide/pci/via82cxxx.c
===================================================================
--- work.orig/drivers/ide/pci/via82cxxx.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/pci/via82cxxx.c	2005-11-25 00:52:03.000000000 +0900
@@ -402,8 +402,8 @@ static int via82cxxx_ide_dma_check (ide_
 	via_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return ide_dma_on(drive);
+	return ide_dma_off_quietly(drive);
 }
 
 /**

