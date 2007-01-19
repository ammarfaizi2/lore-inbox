Return-Path: <linux-kernel-owner+w=401wt.eu-S932823AbXASA31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbXASA31 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXASA3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:29:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbXASA2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=pbSKZs1yV71lHPYT5U0SYUZrse+gxwBS4nhh3heWF/qjKhi1vU3Bljb5ii7XHUF9CnImStplSser9VzaL6EyDjNYqxRQ+t7YoaPIOXLXWWufbWFQC+Nh+BPk2A9uKsdt+EmDUWjD3GLH4598QUKajE2LeTV52F+DJ6+1nXoxK08=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:40 +0100
Message-Id: <20070119003240.14846.32464.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 15/15] ide: add ide_tune_dma() helper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: add ide_tune_dma() helper

After reworking the code responsible for selecting the best DMA
transfer mode it is now possible to add generic ide_tune_dma() helper.

Convert some IDE PCI host drivers to use it (the ones left need more work).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-dma.c      |   20 ++++++++++++++++++++
 drivers/ide/pci/aec62xx.c  |   13 +------------
 drivers/ide/pci/atiixp.c   |   22 +---------------------
 drivers/ide/pci/cs5535.c   |   15 +--------------
 drivers/ide/pci/hpt34x.c   |   20 +-------------------
 drivers/ide/pci/hpt366.c   |   20 +-------------------
 drivers/ide/pci/it8213.c   |   21 +--------------------
 drivers/ide/pci/jmicron.c  |   21 +--------------------
 drivers/ide/pci/piix.c     |   26 +-------------------------
 drivers/ide/pci/sis5513.c  |   21 +--------------------
 drivers/ide/pci/slc90e66.c |   13 +------------
 drivers/ide/pci/tc86c001.c |   13 +------------
 drivers/ide/pci/triflex.c  |   13 +------------
 include/linux/ide.h        |    2 ++
 14 files changed, 34 insertions(+), 206 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -779,6 +779,26 @@ u8 ide_max_dma_mode(ide_drive_t *drive)
 
 EXPORT_SYMBOL_GPL(ide_max_dma_mode);
 
+int ide_tune_dma(ide_drive_t *drive)
+{
+	u8 speed;
+
+	/* TODO: use only ide_max_dma_mode() */
+	if (!ide_use_dma(drive))
+		return 0;
+
+	speed = ide_max_dma_mode(drive);
+
+	if (!speed)
+		return 0;
+
+	drive->hwif->speedproc(drive, speed);
+
+	return ide_dma_enable(drive);
+}
+
+EXPORT_SYMBOL_GPL(ide_tune_dma);
+
 void ide_dma_verbose(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -154,17 +154,6 @@ static int aec62xx_tune_chipset (ide_dri
 	}
 }
 
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!(speed))
-		return 0;
-
-	(void) aec62xx_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
 	u8 speed = 0;
@@ -183,7 +172,7 @@ static void aec62xx_tune_drive (ide_driv
 
 static int aec62xx_config_drive_xfer_rate (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -207,26 +207,6 @@ static int atiixp_speedproc(ide_drive_t 
 }
 
 /**
- *	atiixp_config_drive_for_dma	-	configure drive for DMA
- *	@drive: IDE drive to configure
- *
- *	Set up a ATIIXP interface channel for the best available speed.
- *	We prefer UDMA if it is available and then MWDMA. If DMA is
- *	not available we switch to PIO and return 0.
- */
-
-static int atiixp_config_drive_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) atiixp_speedproc(drive, speed);
-	return ide_dma_enable(drive);
-}
-
-/**
  *	atiixp_dma_check	-	set up an IDE device
  *	@drive: IDE drive to configure
  *
@@ -240,7 +220,7 @@ static int atiixp_dma_check(ide_drive_t 
 
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && atiixp_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive)) {
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -164,26 +164,13 @@ static void cs5535_tuneproc(ide_drive_t 
 	cs5535_set_speed(drive, xferspeed);
 }
 
-static int cs5535_config_drive_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	/* If no DMA speed was available then let dma_check hit pio */
-	if (!speed) {
-		return 0;
-	}
-
-	cs5535_set_drive(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int cs5535_dma_check(ide_drive_t *drive)
 {
 	u8 speed;
 
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && cs5535_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive)) {
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -84,29 +84,11 @@ static void hpt34x_tune_drive (ide_drive
 	(void) hpt34x_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
-/*
- * This allows the configuration of ide_pci chipset registers
- * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.  Initially for designed for
- * HPT343 UDMA chipset by HighPoint|Triones Technologies, Inc.
- */
-
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!(speed))
-		return 0;
-
-	(void) hpt34x_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int hpt34x_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 #ifndef CONFIG_HPT34X_AUTODMA
 		return -1;
 #else
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -668,24 +668,6 @@ static void hpt3xx_tune_drive(ide_drive_
 	(void) hpt3xx_tune_chipset (drive, XFER_PIO_0 + pio);
 }
 
-/*
- * This allows the configuration of ide_pci chipset registers
- * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.  Initially designed for
- * HPT366 UDMA chipset by HighPoint|Triones Technologies, Inc.
- *
- */
-static int config_chipset_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) hpt3xx_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int hpt3xx_quirkproc(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
@@ -740,7 +722,7 @@ static int hpt366_config_drive_xfer_rate
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -197,25 +197,6 @@ static int it8213_tune_chipset (ide_driv
 	return ide_config_drive_speed(drive, speed);
 }
 
-/*
- *	config_chipset_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	Called by the IDE layer when it wants the timings set up.
- */
-
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	it8213_tune_chipset(drive, speed);
-
-	return ide_dma_enable(drive);
-}
-
 /**
  *	it8213_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
@@ -230,7 +211,7 @@ static int it8213_config_drive_for_dma (
 {
 	u8 pio;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -119,25 +119,6 @@ static int jmicron_tune_chipset (ide_dri
 }
 
 /**
- *	config_chipset_for_dma	-	configure for DMA
- *	@drive: drive to configure
- *
- *	As the JMicron snoops for timings all we actually need to do is
- *	make sure we don't set an invalid mode.
- */
-
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	jmicron_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
-/**
  *	jmicron_configure_drive_for_dma	-	set up for DMA transfers
  *	@drive: drive we are going to set up
  *
@@ -147,7 +128,7 @@ static int config_chipset_for_dma (ide_d
 
 static int jmicron_config_drive_for_dma (ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	config_jmicron_chipset_for_pio(drive, 1);
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -291,30 +291,6 @@ static int piix_tune_chipset (ide_drive_
 }
 
 /**
- *	piix_config_drive_for_dma	-	configure drive for DMA
- *	@drive: IDE drive to configure
- *
- *	Set up a PIIX interface channel for the best available speed.
- *	We prefer UDMA if it is available and then MWDMA.  If DMA is
- *	not available we switch to PIO and return 0.
- */
- 
-static int piix_config_drive_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	/*
-	 * If no DMA speed was available or the chipset has DMA bugs
-	 * then disable DMA and use PIO
-	 */
-	if (!speed)
-		return 0;
-
-	(void) piix_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
-/**
  *	piix_config_drive_xfer_rate	-	set up an IDE device
  *	@drive: IDE drive to configure
  *
@@ -326,7 +302,7 @@ static int piix_config_drive_xfer_rate (
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive)) {
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -638,32 +638,13 @@ static void sis5513_tune_drive (ide_driv
 	(void) config_chipset_for_pio(drive, pio);
 }
 
-/*
- * ((id->hw_config & 0x4000|0x2000) && (HWIF(drive)->udma_four))
- */
-static int config_chipset_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-#ifdef DEBUG
-	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %x\n",
-	       drive->dn, drive->id->dma_ultra);
-#endif
-
-	if (!(speed))
-		return 0;
-
-	sis5513_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int sis5513_config_xfer_rate(ide_drive_t *drive)
 {
 	config_art_rwp_pio(drive, 5);
 
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -157,22 +157,11 @@ static int slc90e66_tune_chipset (ide_dr
 	return (ide_config_drive_speed(drive, speed));
 }
 
-static int slc90e66_config_drive_for_dma (ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) slc90e66_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int slc90e66_config_drive_xfer_rate (ide_drive_t *drive)
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive)) {
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -167,20 +167,9 @@ static int tc86c001_busproc(ide_drive_t 
 	return 0;
 }
 
-static int config_chipset_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) tc86c001_tune_chipset(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int tc86c001_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -100,20 +100,9 @@ static void triflex_tune_drive(ide_drive
 	(void) triflex_tune_chipset(drive, (XFER_PIO_0 + use_pio));
 }
 
-static int triflex_config_drive_for_dma(ide_drive_t *drive)
-{
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) triflex_tune_chipset(drive, speed);
-	 return ide_dma_enable(drive);
-}
-
 static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	if (ide_use_dma(drive) && triflex_config_drive_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	triflex_tune_drive(drive, 255);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1275,6 +1275,7 @@ int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
 int ide_use_dma(ide_drive_t *);
 u8 ide_max_dma_mode(ide_drive_t *);
+int ide_tune_dma(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
@@ -1302,6 +1303,7 @@ extern int __ide_dma_timeout(ide_drive_t
 #else
 static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
+static inline int ide_tune_dma(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
