Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbTLIS4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266087AbTLIS4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:56:23 -0500
Received: from alhya.freenux.org ([213.41.137.38]:38051 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S266069AbTLISyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:54:15 -0500
From: Mickael Marchand <marchand@kde.org>
To: Aron Rubin <arubin@atl.lmco.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Tue, 9 Dec 2003 19:54:26 +0100
User-Agent: KMail/1.5.94
References: <20031203204445.GA26987@gtf.org> <200312051907.13727.marchand@kde.org> <3FD612E2.90607@atl.lmco.com>
In-Reply-To: <3FD612E2.90607@atl.lmco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iph1/UZkKS12Ff8"
Message-Id: <200312091954.28224.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iph1/UZkKS12Ff8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le Tuesday 09 December 2003 19:22, Aron Rubin a =E9crit :
> Mickael Marchand wrote:
> > here it is ;) (for 2.6.0-test11)
> > it includes patches in siimage.c but it did not work IIRC (lost
> > interrupt). (don't compile siimage inside the kernel, it would not boot)
>
> Your messages seem to be conflicting. Does this work or not or just
> enough to see messages? I am dealing with the same exact thing for the
> 3512 chipset.
>
> Aron

Hi,

there are 2 drivers in the kernel for SATA drives.
first one is the IDE way in drivers/ide/pci/siimage.c (sata drives appears =
as=20
hde,hdf etc ).=20
the second drive is in libata in drivers/scsi/sata_sil.c (sata drives appea=
rs=20
as sda,sdb etc ...) (the one I use daily)

the attached patch makes _both_ drivers work (whereas the previous one made=
=20
only the libata one working)

I have not yet tested if the 4 sata ports works. I think I need to change t=
he=20
"channels" setting to have support for all ports (at least 2 ports work for=
=20
me). I will try that later.

Cheers,
Mik
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1hpiyOYzc4nQ8j0RAjGTAJsETf+ARzNoIEuHbrakP/6p/jb+hwCgifj0
f9SZw9X2/1i6sYTx72MpEcE=3D
=3DdoIM
=2D----END PGP SIGNATURE-----

--Boundary-00=_iph1/UZkKS12Ff8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sil3114.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sil3114.patch"

diff -u -r linux-2.6.0-test11.orig/drivers/ide/pci/siimage.c linux-2.6.0-test11/drivers/ide/pci/siimage.c
--- linux-2.6.0-test11.orig/drivers/ide/pci/siimage.c	2003-11-26 21:43:35.000000000 +0100
+++ linux-2.6.0-test11/drivers/ide/pci/siimage.c	2003-12-06 13:56:30.000000000 +0100
@@ -55,6 +55,7 @@
 	switch(pdev->device)
 	{
 		case PCI_DEVICE_ID_SII_3112:
+		case PCI_DEVICE_ID_SII_3114:
 		case PCI_DEVICE_ID_SII_1210SA:
 			return 1;
 		case PCI_DEVICE_ID_SII_680:
@@ -1178,7 +1179,8 @@
 static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ 0, },
 };
 
diff -u -r linux-2.6.0-test11.orig/drivers/ide/pci/siimage.h linux-2.6.0-test11/drivers/ide/pci/siimage.h
--- linux-2.6.0-test11.orig/drivers/ide/pci/siimage.h	2003-11-26 21:44:17.000000000 +0100
+++ linux-2.6.0-test11/drivers/ide/pci/siimage.h	2003-12-05 16:46:50.000000000 +0100
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
diff -u -r linux-2.6.0-test11.orig/drivers/scsi/Kconfig linux-2.6.0-test11/drivers/scsi/Kconfig
--- linux-2.6.0-test11.orig/drivers/scsi/Kconfig	2003-11-26 21:45:32.000000000 +0100
+++ linux-2.6.0-test11/drivers/scsi/Kconfig	2003-12-05 16:54:20.000000000 +0100
@@ -441,7 +441,7 @@
 
 config SCSI_SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && BROKEN
+	depends on SCSI_SATA && PCI
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
diff -u -r linux-2.6.0-test11.orig/drivers/scsi/sata_sil.c linux-2.6.0-test11/drivers/scsi/sata_sil.c
--- linux-2.6.0-test11.orig/drivers/scsi/sata_sil.c	2003-11-26 21:42:46.000000000 +0100
+++ linux-2.6.0-test11/drivers/scsi/sata_sil.c	2003-12-05 16:50:32.000000000 +0100
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
 
diff -u -r linux-2.6.0-test11.orig/include/linux/pci_ids.h linux-2.6.0-test11/include/linux/pci_ids.h
--- linux-2.6.0-test11.orig/include/linux/pci_ids.h	2003-11-26 21:43:39.000000000 +0100
+++ linux-2.6.0-test11/include/linux/pci_ids.h	2003-12-06 13:59:45.000000000 +0100
@@ -882,6 +882,7 @@
 
 #define PCI_DEVICE_ID_SII_680		0x0680
 #define PCI_DEVICE_ID_SII_3112		0x3112
+#define PCI_DEVICE_ID_SII_3114		0x3114
 #define PCI_DEVICE_ID_SII_1210SA	0x0240
 
 #define PCI_VENDOR_ID_VISION		0x1098


--Boundary-00=_iph1/UZkKS12Ff8--
