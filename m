Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLESHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLESHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:07:21 -0500
Received: from alhya.freenux.org ([213.41.137.38]:24721 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S264333AbTLESHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:07:07 -0500
From: Mickael Marchand <marchand@kde.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Fri, 5 Dec 2003 19:07:11 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org
References: <20031203204445.GA26987@gtf.org> <200312051842.26599.marchand@kde.org> <3FD0C4B0.8020106@pobox.com>
In-Reply-To: <3FD0C4B0.8020106@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PlM0/k02Hf0FTQY"
Message-Id: <200312051907.13727.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PlM0/k02Hf0FTQY
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

here it is ;) (for 2.6.0-test11)
it includes patches in siimage.c but it did not work IIRC (lost interrupt).
(don't compile siimage inside the kernel, it would not boot)

enjoy,

cheers,
Mik

Le Friday 05 December 2003 18:47, Jeff Garzik a =E9crit :
> Mickael Marchand wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi,
> >
> > as I was too impatient, I wrote a quick hack for it.
> > Now I can see my drives on the 3114 controller.
> > RAID does not seem to work but I can access my SATA drives in normal
> > mode.
> >
> > hdparm gives a 57 Mb/s output.
> > I had no error/crash/corruption, it appears to work correctly.
> >
> > It works on 2.4.23 and 2.6.0-test11 with libata.
> > basically, you just need to add the PCI id for 3114 just like 3112 in
> > sata_sil.c, load the module and enjoy.
> > I presume 3112 and 3114 chips are mostly identical.
> >
> > I have tested this on 2 Tyan motherboards with Sil 3114 inside
> >
> > I can generate a patch in a few moments if you want it.
>
> Yes, a tested patch would be great, thanks!
>
> 	Jeff
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0MlPyOYzc4nQ8j0RAtFpAJ4hemZoIMnFcBjBXYjGD/uCXJ3d/QCfbjT6
KigiRN0fY1PPveJIiJyKCdE=3D
=3DKemZ
=2D----END PGP SIGNATURE-----

--Boundary-00=_PlM0/k02Hf0FTQY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sil3114.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sil3114.patch"

diff -ru linux-2.6.0-test11.orig/drivers/ide/pci/siimage.c linux-2.6.0-test11/drivers/ide/pci/siimage.c
--- linux-2.6.0-test11.orig/drivers/ide/pci/siimage.c	2003-11-26 20:43:35.000000000 +0000
+++ linux-2.6.0-test11/drivers/ide/pci/siimage.c	2003-12-05 15:44:28.000000000 +0000
@@ -55,6 +55,7 @@
 	switch(pdev->device)
 	{
 		case PCI_DEVICE_ID_SII_3112:
+		case PCI_DEVICE_ID_SII_3114:
 		case PCI_DEVICE_ID_SII_1210SA:
 			return 1;
 		case PCI_DEVICE_ID_SII_680:
@@ -1178,6 +1179,7 @@
 static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
diff -ru linux-2.6.0-test11.orig/drivers/ide/pci/siimage.h linux-2.6.0-test11/drivers/ide/pci/siimage.h
--- linux-2.6.0-test11.orig/drivers/ide/pci/siimage.h	2003-11-26 20:44:17.000000000 +0000
+++ linux-2.6.0-test11/drivers/ide/pci/siimage.h	2003-12-05 15:46:50.000000000 +0000
@@ -13,7 +13,7 @@
 #undef SIIMAGE_BUFFERED_TASKFILE
 #undef SIIMAGE_LARGE_DMA
 
-#define SII_DEBUG 0
+#define SII_DEBUG 1
 
 #if SII_DEBUG
 #define siiprintk(x...)	printk(x)
@@ -72,6 +72,18 @@
 		.extra		= 0,
 	},{	/* 2 */
 		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_SII_3114,
+		.name		= "SiI3114 Serial ATA",
+		.init_chipset	= init_chipset_siimage,
+		.init_iops	= init_iops_siimage,
+		.init_hwif	= init_hwif_siimage,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 3 */
+		.vendor		= PCI_VENDOR_ID_CMD,
 		.device		= PCI_DEVICE_ID_SII_1210SA,
 		.name		= "Adaptec AAR-1210SA",
 		.init_chipset	= init_chipset_siimage,
diff -ru linux-2.6.0-test11.orig/drivers/scsi/Kconfig linux-2.6.0-test11/drivers/scsi/Kconfig
--- linux-2.6.0-test11.orig/drivers/scsi/Kconfig	2003-11-26 20:45:32.000000000 +0000
+++ linux-2.6.0-test11/drivers/scsi/Kconfig	2003-12-05 15:54:20.000000000 +0000
@@ -441,7 +441,7 @@
 
 config SCSI_SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && BROKEN
+	depends on SCSI_SATA && PCI
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
diff -ru linux-2.6.0-test11.orig/drivers/scsi/sata_sil.c linux-2.6.0-test11/drivers/scsi/sata_sil.c
--- linux-2.6.0-test11.orig/drivers/scsi/sata_sil.c	2003-11-26 20:42:46.000000000 +0000
+++ linux-2.6.0-test11/drivers/scsi/sata_sil.c	2003-12-05 15:50:32.000000000 +0000
@@ -39,6 +39,7 @@
 
 enum {
 	sil_3112		= 0,
+	sil_3114		= 1,
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -62,6 +63,7 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ }	/* terminate list */
 };
 
@@ -119,6 +121,14 @@
 		.pio_mask	= 0x03,			/* pio3-4 */
 		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
 		.port_ops	= &sil_ops,
+	}, /* sil_3114 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03,			/* pio3-4 */
+		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.port_ops	= &sil_ops,
 	},
 };
 
diff -ru linux-2.6.0-test11.orig/include/linux/pci_ids.h linux-2.6.0-test11/include/linux/pci_ids.h
--- linux-2.6.0-test11.orig/include/linux/pci_ids.h	2003-11-26 20:43:39.000000000 +0000
+++ linux-2.6.0-test11/include/linux/pci_ids.h	2003-12-05 15:48:28.000000000 +0000
@@ -882,6 +882,7 @@
 
 #define PCI_DEVICE_ID_SII_680		0x0680
 #define PCI_DEVICE_ID_SII_3112		0x3112
+#define PCI_DEVICE_ID_SII_3114		0x3114
 #define PCI_DEVICE_ID_SII_1210SA	0x0240
 
 #define PCI_VENDOR_ID_VISION		0x1098

--Boundary-00=_PlM0/k02Hf0FTQY--
