Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262470AbTCROpA>; Tue, 18 Mar 2003 09:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbTCROpA>; Tue, 18 Mar 2003 09:45:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28138
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262470AbTCROov>; Tue, 18 Mar 2003 09:44:51 -0500
Subject: Re: HPT372N not supported?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henning Schroeder <schroeder@psychologie.uni-wuerzburg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <151527905177.20030317182838@psychologie.uni-wuerzburg.de>
References: <151527905177.20030317182838@psychologie.uni-wuerzburg.de>
Content-Type: multipart/mixed; boundary="=-vE8YqYAdkuP4lbE4H4zR"
Organization: 
Message-Id: <1048003567.27370.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 16:06:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vE8YqYAdkuP4lbE4H4zR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-17 at 17:28, Henning Schroeder wrote:
> I don=C5=BDt like that solution very much, though, because the highpoint
> driver uses the scsi subsystem. Looking through highpoints hpt.c file
> I could not find very much differences in the way the HPT372N is
> accessed from the HPT372-way. Maybe somebody (Andre Hedrick?) could
> look through the code and integrate the HPT372N into
> linux/drivers/ide/pci/hpt366.c? This feat is regrettably way beyound
> my own programming capability.

Try the patch attached below. The 372N doesn't seem to be that different
except that we have to use different pci timing thresholds. The patch
below isn't tested as I don't have a 372N.

> I would love to hear about the current status of that chip. I do not
> need the RAID capability, just the extra IDE ports.

hptraid should already support the raid bits



--=-vE8YqYAdkuP4lbE4H4zR
Content-Disposition: attachment; filename=a1
Content-Type: text/plain; name=a1; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- ../linux.21pre5/drivers/ide/pci/hpt366.c	2003-02-27 19:13:39.000000000 =
+0000
+++ drivers/ide/pci/hpt366.c	2003-03-18 15:56:34.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.34	Sept 17, 2002
+ * linux/drivers/ide/pci/hpt366.c		Version 0.35	March 18, 2003
  *
  * Copyright (C) 1999-2002		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -9,6 +9,10 @@
  * donation of an ABit BP6 mainboard, processor, and memory acellerated
  * development and support.
  *
+ * Highpoint have their own driver (source except for the raid part)
+ * available from http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz
+ * This may be useful to anyone wanting to work on the mainstream hpt IDE.
+ *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
  * - add function for getting/setting power status of drive
@@ -96,7 +100,10 @@
 		u8 c0, c1;
=20
 		p +=3D sprintf(p, "\nController: %d\n", i);
-		p +=3D sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		if(class_rev < 9)
+			p +=3D sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		else
+			p +=3D sprintf(p, "Chipset: HPT revision %d\n", class_rev);
 		p +=3D sprintf(p, "--------------- Primary Channel "
 				"--------------- Secondary Channel "
 				"--------------\n");
@@ -158,6 +165,13 @@
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
=20
+/*
+ *	This wants fixing so that we do everything not by classrev
+ *	(which breaks on the newest chips) but by creating an
+ *	enumeration of chip variants and using that
+ */
+=20
+
 static u32 hpt_revision (struct pci_dev *dev)
 {
 	u32 class_rev;
@@ -165,6 +179,9 @@
 	class_rev &=3D 0xff;
=20
 	switch(dev->device) {
+		/* Remap new 372N onto 372 */
+		case PCI_DEVICE_ID_TTI_HPT372N:
+			class_rev =3D PCI_DEVICE_ID_TTI_HPT372; break;
 		case PCI_DEVICE_ID_TTI_HPT374:
 			class_rev =3D PCI_DEVICE_ID_TTI_HPT374; break;
 		case PCI_DEVICE_ID_TTI_HPT371:
@@ -214,6 +231,11 @@
 	return mode;
 }
=20
+/*
+ *	Note for the future; the SATA hpt37x we must set
+ *	either PIO or UDMA modes 0,4,5
+ */
+=20
 static u8 hpt3xx_ratefilter (ide_drive_t *drive, u8 speed)
 {
 	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
@@ -386,7 +408,6 @@
 	u8 drive_fast	=3D 0, drive_pci =3D 0x40 + (drive->dn * 4);
 	u32 list_conf	=3D 0, drive_conf =3D 0;
 	u32 conf_mask	=3D (speed >=3D XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
-
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 * don't holdoff on interrupts. (=3D=3D 0x01 despite what the docs say)
@@ -509,7 +530,7 @@
=20
 	drive->init_speed =3D 0;
=20
-	if (id && (id->capability & 1) && drive->autodma) {
+	if ((id->capability & 1) && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
@@ -684,14 +705,20 @@
 	pci_read_config_byte(dev, 0x59, &reg59h);
 	pci_read_config_byte(dev, state_reg, &regXXh);
=20
-	if (state) {
-		(void) ide_do_reset(drive);
-		pci_write_config_byte(dev, state_reg, regXXh|0x80);
-		pci_write_config_byte(dev, 0x59, reg59h|reset);
-	} else {
-		pci_write_config_byte(dev, 0x59, reg59h & ~(reset));
-		pci_write_config_byte(dev, state_reg, regXXh & ~(0x80));
-		(void) ide_do_reset(drive);
+	switch(state)
+	{
+		case BUSSTATE_ON:
+			(void) ide_do_reset(drive);
+			pci_write_config_byte(dev, state_reg, regXXh|0x80);
+			pci_write_config_byte(dev, 0x59, reg59h|reset);
+			break;
+		case BUSSTATE_OFF:
+			pci_write_config_byte(dev, 0x59, reg59h & ~(reset));
+			pci_write_config_byte(dev, state_reg, regXXh & ~(0x80));
+			(void) ide_do_reset(drive);
+			break;
+		default:
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -758,6 +785,8 @@
 		tri_reg |=3D TRISTATE_BIT;
 		bus_reg |=3D resetmask;
 		break;
+	default:
+		return -EINVAL;
 	}
 	pci_write_config_byte(dev, 0x59, bus_reg);
 	pci_write_config_word(dev, tristate, tri_reg);
@@ -771,72 +800,121 @@
 	u16 freq;
 	u32 pll;
 	u8 reg5bh;
-
+	u8 reg5ah;
+	unsigned long dmabase =3D pci_resource_start(dev, 4);
+	u8 did, rid;=09
+	int is_372n =3D 0;
 #if 1
-	u8 reg5ah =3D 0;
 	pci_read_config_byte(dev, 0x5a, &reg5ah);
 	/* interrupt force enable */
 	pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));
 #endif
=20
+	did =3D inb(dmabase + 0x22);
+	rid =3D inb(dmabase + 0x28);
+=09
+	if((did =3D=3D 4 && rid =3D=3D 6) || (did =3D=3D 5 && rid > 1))
+		is_372n =3D 1;
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
-	 * to prevent drives having problems with 40-pin cables.
+	 * to prevent drives having problems with 40-pin cables. Needed
+	 * for some drives such as IBM-DTLA which will not enter ready
+	 * state on reset when PDIAG is a input.
+	 *
+	 * ToDo: should we set 0x21 when using PLL mode ?
 	 */
 	pci_write_config_byte(dev, 0x5b, 0x23);
=20
 	/*
 	 * set up the PLL. we need to adjust it so that it's stable.=20
 	 * freq =3D Tpll * 192 / Tpci
+	 *
+	 * Todo. For non x86 should probably check the dword is
+	 * set to 0xABCDExxx indicating the BIOS saved f_CNT
 	 */
 	pci_read_config_word(dev, 0x78, &freq);
 	freq &=3D 0x1FF;
-	if (freq < 0x9c) {
-		pll =3D F_LOW_PCI_33;
-		if (hpt_minimum_revision(dev,8))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt370a);
+=09
+	/*
+	 * The 372N uses different PCI clock information and has
+	 * some other complications
+	 *	On PCI33 timing we must clock switch
+	 *	On PCI66 timing we must NOT use the PCI clock
+	 *
+	 * Currently we always set up the PLL for the 372N
+	 */
+	=20
+	if(is_372n)
+	{
+		printk(KERN_INFO "hpt: HPT372N detected, using 372N timing.\n");
+		if(freq < 0x55)
+			pll =3D F_LOW_PCI_33;
+		else if(freq < 0x70)
+			pll =3D F_LOW_PCI_40;
+		else if(freq < 0x7F)
+			pll =3D F_LOW_PCI_50;
 		else
-			pci_set_drvdata(dev, (void *) thirty_three_base_hpt370);
-		printk("HPT37X: using 33MHz PCI clock\n");
-	} else if (freq < 0xb0) {
-		pll =3D F_LOW_PCI_40;
-	} else if (freq < 0xc8) {
-		pll =3D F_LOW_PCI_50;
-		if (hpt_minimum_revision(dev,8))
-			return -EOPNOTSUPP;
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) fifty_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			pll =3D F_LOW_PCI_66;
+		=09
+		/* We always use the pll not the PCI clock on 372N */
+	}
+	else
+	{
+		if(freq < 0x9C)
+			pll =3D F_LOW_PCI_33;
+		else if(freq < 0xb0)
+			pll =3D F_LOW_PCI_40;
+		else if(freq <0xc8)
+			pll =3D F_LOW_PCI_50;
 		else
-			pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
-		printk("HPT37X: using 50MHz PCI clock\n");
-	} else {
-		pll =3D F_LOW_PCI_66;
-		if (hpt_minimum_revision(dev,8))
-		{
-			printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
-			return -EOPNOTSUPP;
+			pll =3D F_LOW_PCI_66;
+=09
+		if (pll =3D=3D F_LOW_PCI_33) {
+			if (hpt_minimum_revision(dev,8))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) thirty_three_base_hpt370);
+			printk("HPT37X: using 33MHz PCI clock\n");
+		} else if (pll =3D=3D F_LOW_PCI_40) {
+		} else if (pll =3D=3D F_LOW_PCI_50) {
+			if (hpt_minimum_revision(dev,8))
+				pci_set_drvdata(dev, NULL);
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) fifty_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) fifty_base_hpt370a);
+			printk("HPT37X: using 50MHz PCI clock\n");
+		} else {
+			if (hpt_minimum_revision(dev,8))
+			{
+				printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
+				pci_set_drvdata(dev, NULL);
+			}
+			else if (hpt_minimum_revision(dev,5))
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
+			else if (hpt_minimum_revision(dev,4))
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370a);
+			else
+				pci_set_drvdata(dev, (void *) sixty_six_base_hpt370);
+			printk("HPT37X: using 66MHz PCI clock\n");
 		}
-		else if (hpt_minimum_revision(dev,5))
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
-		else if (hpt_minimum_revision(dev,4))
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt370a);
-		else
-			pci_set_drvdata(dev, (void *) sixty_six_base_hpt370);
-		printk("HPT37X: using 66MHz PCI clock\n");
 	}
-=09
+		=09
 	/*
 	 * only try the pll if we don't have a table for the clock
 	 * speed that we're running at. NOTE: the internal PLL will
 	 * result in slow reads when using a 33MHz PCI clock. we also
 	 * don't like to use the PLL because it will cause glitches
 	 * on PRST/SRST when the HPT state engine gets reset.
+	 *
+	 * ToDo: Use 66MHz PLL when ATA133 devices are present on a
+	 * 372 device so we can get ATA133 support
 	 */
 	if (pci_get_drvdata(dev))=20
 		goto init_hpt37X_done;
@@ -923,7 +1001,7 @@
 	if (!pci_get_drvdata(dev))
 	{
 		printk(KERN_ERR "hpt366: unknown bus timing.\n");
-		return -EOPNOTSUPP;
+		pci_set_drvdata(dev, NULL);
 	}
 	return 0;
 }
@@ -1061,6 +1139,12 @@
=20
 	if (!dmabase)
 		return;
+	=09
+	if(pci_get_drvdata(hwif->pci_dev) =3D=3D NULL)
+	{
+		printk(KERN_WARNING "hpt: no known IDE timings, disabling DMA.\n");
+		return;
+	}
=20
 	dma_old =3D hwif->INB(dmabase+2);
=20
@@ -1131,6 +1215,12 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &=3D 0xff;
=20
+	/* New ident 372N reports revision 1. We could do the=20
+	   io port based type identification instead perhaps (DID, RID) */
+	  =20
+	if(d->device =3D=3D PCI_DEVICE_ID_TTI_HPT372N)
+		class_rev =3D 5;
+	=09
 	strcpy(d->name, chipset_names[class_rev]);
=20
 	switch(class_rev) {
@@ -1190,6 +1280,7 @@
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302, PCI_ANY_ID, PCI_ANY_ID, 0,=
 0, 2},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT371, PCI_ANY_ID, PCI_ANY_ID, 0,=
 0, 3},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, PCI_ANY_ID, PCI_ANY_ID, 0,=
 0, 4},
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372N, PCI_ANY_ID, PCI_ANY_ID, 0=
, 0, 5},
 	{ 0, },
 };
=20
--- ../linux.21pre5/drivers/ide/pci/hpt366.h	2003-02-27 19:13:39.000000000 =
+0000
+++ drivers/ide/pci/hpt366.h	2003-03-18 15:30:26.000000000 +0000
@@ -512,6 +512,20 @@
 		.enablebits	=3D {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	=3D OFF_BOARD,
 		.extra		=3D 0
+	},{	/* 5 */
+		.vendor		=3D PCI_VENDOR_ID_TTI,
+		.device		=3D PCI_DEVICE_ID_TTI_HPT372N,
+		.name		=3D "HPT372N",
+		.init_setup	=3D init_setup_hpt37x,
+		.init_chipset	=3D init_chipset_hpt366,
+		.init_iops	=3D NULL,
+		.init_hwif	=3D init_hwif_hpt366,
+		.init_dma	=3D init_dma_hpt366,
+		.channels	=3D 2,	/* 4 */
+		.autodma	=3D AUTODMA,
+		.enablebits	=3D {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	=3D OFF_BOARD,
+		.extra		=3D 0
 	},{
 		.vendor		=3D 0,
 		.device		=3D 0,

--=-vE8YqYAdkuP4lbE4H4zR--
