Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUADNN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 08:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265519AbUADNN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 08:13:26 -0500
Received: from alhya.freenux.org ([213.41.137.38]:51385 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S265517AbUADNNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 08:13:14 -0500
From: Mickael Marchand <marchand@kde.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update : Silicon Image 3114, 4 ports support
Date: Sun, 4 Jan 2004 14:12:56 +0100
User-Agent: KMail/1.5.94
Cc: Jeff Garzik <jgarzik@pobox.com>, "B. Gajdos" <brian@chem.sk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YFB+/U3KQYyQhCx"
Message-Id: <200401041413.20573.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YFB+/U3KQYyQhCx
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Thanks to the info Brian provided, I was able to set up the 4 ports of the=
=20
sil3114.
Attached is the patch for sata_sil.c, tested on a 2.6.1-rc1-mm1 and tested =
by=20
Brian too.

I used=20
if (ent->driver_data =3D=3D sil_3114)   { ... }

to ensure the 4 ports are probed only for sil3114 , I am not sure this is t=
he=20
correct way to do it (so that sil3112 support is not broken). I guess Jeff=
=20
will review that :)

Cheers,
Mik
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+BFcyOYzc4nQ8j0RAttHAJ4gUBQt6tgTQp4m2pxBhGq+y2tqwgCbBRPU
p9u5AR+f22MEqlB5kxhM/zc=3D
=3DjPSE
=2D----END PGP SIGNATURE-----

--Boundary-00=_YFB+/U3KQYyQhCx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sil3114-4ports.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sil3114-4ports.diff"

--- sata_sil.c.orig	2004-01-03 12:23:37.000000000 +0100
+++ sata_sil.c	2004-01-04 13:51:28.000000000 +0100
@@ -39,6 +39,7 @@
 
 enum {
 	sil_3112		= 0,
+	sil_3114		= 1,
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -49,6 +50,16 @@
 	SIL_IDE1_CTL		= 0xCA,
 	SIL_IDE1_BMDMA		= 0x08,
 	SIL_IDE1_SCR		= 0x180,
+
+	SIL_IDE2_TF		= 0x280,
+	SIL_IDE2_CTL		= 0x28A,
+	SIL_IDE2_BMDMA		= 0x200,
+	SIL_IDE2_SCR		= 0x300,
+
+	SIL_IDE3_TF		= 0x2C0,
+	SIL_IDE3_CTL		= 0x2CA,
+	SIL_IDE3_BMDMA		= 0x208,
+	SIL_IDE3_SCR		= 0x380,
 };
 
 static void sil_set_piomode (struct ata_port *ap, struct ata_device *adev,
@@ -62,6 +73,7 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ }	/* terminate list */
 };
 
@@ -120,6 +132,14 @@
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
 
@@ -267,7 +287,7 @@
 	probe_ent->pdev = pdev;
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
-	probe_ent->n_ports = 2;
+	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2; //4 ports for a sil_3114
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
@@ -296,6 +316,20 @@
 	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
 	ata_std_ports(&probe_ent->port[1]);
 
+	if (ent->driver_data == sil_3114) {
+		probe_ent->port[2].cmd_addr = base + SIL_IDE2_TF;
+		probe_ent->port[2].ctl_addr = base + SIL_IDE2_CTL;
+		probe_ent->port[2].bmdma_addr = base + SIL_IDE2_BMDMA;
+		probe_ent->port[2].scr_addr = base + SIL_IDE2_SCR;
+		ata_std_ports(&probe_ent->port[2]);
+
+		probe_ent->port[3].cmd_addr = base + SIL_IDE3_TF;
+		probe_ent->port[3].ctl_addr = base + SIL_IDE3_CTL;
+		probe_ent->port[3].bmdma_addr = base + SIL_IDE3_BMDMA;
+		probe_ent->port[3].scr_addr = base + SIL_IDE3_SCR;
+		ata_std_ports(&probe_ent->port[3]);
+	}
+
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return value */

--Boundary-00=_YFB+/U3KQYyQhCx--
