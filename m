Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVBDHiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVBDHiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbVBDHiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:38:04 -0500
Received: from [211.58.254.17] ([211.58.254.17]:36009 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263254AbVBDHNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:20 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 01/14] ide_pci: Remove lousy macros from aec62xx.
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071317.A06E013264C@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:17 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01_ide_pci_aec62xx_cleanup.patch

	Removes SPLIT_BYTE, MAKE_WORD and BUSCLOCK macros which are
	just better off directly coded from ide/pci/aec62xx driver.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/aec62xx.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/aec62xx.c	2005-02-04 16:07:37.175314620 +0900
+++ linux-idepci-export/drivers/ide/pci/aec62xx.c	2005-02-04 16:08:23.966693938 +0900
@@ -89,10 +89,11 @@ static u8 aec62xx_ratemask (ide_drive_t 
 
 static int aec6210_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u16 d_conf		= 0;
-	u8 speed	= ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	struct chipset_bus_clock_list_entry *busclock = pci_get_drvdata(dev);
+	u16 d_conf = 0;
+	u8 speed = ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
 	u8 ultra = 0, ultra_conf = 0;
 	u8 tmp0 = 0, tmp1 = 0, tmp2 = 0;
 	unsigned long flags;
@@ -100,16 +101,15 @@ static int aec6210_tune_chipset (ide_dri
 	local_irq_save(flags);
 	/* 0x40|(2*drive->dn): Active, 0x41|(2*drive->dn): Recovery */
 	pci_read_config_word(dev, 0x40|(2*drive->dn), &d_conf);
-	tmp0 = pci_bus_clock_list(speed, BUSCLOCK(dev));
-	SPLIT_BYTE(tmp0,tmp1,tmp2);
-	MAKE_WORD(d_conf,tmp1,tmp2);
+	tmp0 = pci_bus_clock_list(speed, busclock);
+	d_conf = ((tmp0 & 0xf0) << 4) | (tmp0 & 0xf);
 	pci_write_config_word(dev, 0x40|(2*drive->dn), d_conf);
 
 	tmp1 = 0x00;
 	tmp2 = 0x00;
 	pci_read_config_byte(dev, 0x54, &ultra);
 	tmp1 = ((0x00 << (2*drive->dn)) | (ultra & ~(3 << (2*drive->dn))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, BUSCLOCK(dev));
+	ultra_conf = pci_bus_clock_list_ultra(speed, busclock);
 	tmp2 = ((ultra_conf << (2*drive->dn)) | (tmp1 & ~(3 << (2*drive->dn))));
 	pci_write_config_byte(dev, 0x54, tmp2);
 	local_irq_restore(flags);
@@ -118,10 +118,11 @@ static int aec6210_tune_chipset (ide_dri
 
 static int aec6260_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed	= ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
-	u8 unit		= (drive->select.b.unit & 0x01);
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	struct chipset_bus_clock_list_entry *busclock = pci_get_drvdata(dev);
+	u8 speed = ide_rate_filter(aec62xx_ratemask(drive), xferspeed);
+	u8 unit = (drive->select.b.unit & 0x01);
 	u8 tmp1 = 0, tmp2 = 0;
 	u8 ultra = 0, drive_conf = 0, ultra_conf = 0;
 	unsigned long flags;
@@ -129,12 +130,12 @@ static int aec6260_tune_chipset (ide_dri
 	local_irq_save(flags);
 	/* high 4-bits: Active, low 4-bits: Recovery */
 	pci_read_config_byte(dev, 0x40|drive->dn, &drive_conf);
-	drive_conf = pci_bus_clock_list(speed, BUSCLOCK(dev));
+	drive_conf = pci_bus_clock_list(speed, busclock);
 	pci_write_config_byte(dev, 0x40|drive->dn, drive_conf);
 
 	pci_read_config_byte(dev, (0x44|hwif->channel), &ultra);
 	tmp1 = ((0x00 << (4*unit)) | (ultra & ~(7 << (4*unit))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, BUSCLOCK(dev));
+	ultra_conf = pci_bus_clock_list_ultra(speed, busclock);
 	tmp2 = ((ultra_conf << (4*unit)) | (tmp1 & ~(7 << (4*unit))));
 	pci_write_config_byte(dev, (0x44|hwif->channel), tmp2);
 	local_irq_restore(flags);
Index: linux-idepci-export/drivers/ide/pci/aec62xx.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/aec62xx.h	2005-02-04 16:07:37.175314620 +0900
+++ linux-idepci-export/drivers/ide/pci/aec62xx.h	2005-02-04 16:08:23.967693775 +0900
@@ -51,16 +51,6 @@ static struct chipset_bus_clock_list_ent
 	{	0,		0x00,	0x00	}
 };
 
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-#ifndef MAKE_WORD
-#define MAKE_WORD(W,HB,LB)	((W)=((HB<<8)+LB))
-#endif
-
-#define BUSCLOCK(D)	\
-	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
-
 static int init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
 static int init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_aec62xx(struct pci_dev *, const char *);
