Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbTLaL0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTLaL0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:26:00 -0500
Received: from alhya.freenux.org ([213.41.137.38]:39814 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S265260AbTLaLZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:25:48 -0500
From: Mickael Marchand <marchand@kde.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] adaptec 1210sa
Date: Wed, 31 Dec 2003 12:25:39 +0100
User-Agent: KMail/1.5.94
References: <200312220305.29955.marchand@kde.org> <3FF21648.8030604@pobox.com>
In-Reply-To: <3FF21648.8030604@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Hugo Mills <hugo-lkml@carfax.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0Ir8/FX9CVfIvsW"
Message-Id: <200312311225.43794.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0Ir8/FX9CVfIvsW
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I can't test atm, I will test it in a few days.

here is the patch I used (the previous one was incomplete - diffed against =
the=20
wrong file-), it includes the PCI ids you need.

Cheers,
Mik

Le Wednesday 31 December 2003 01:20, vous avez =E9crit :
> Mickael Marchand wrote:
> > reading linux-scsi I found a suggestion by Justin to make adaptec's 1210
> > sa working. I made the corresponding patch for libata, and it actually
> > works :)
> >
> > it needs  some redesign to only apply to aar1210 (as standard sil3112
> > does not need it) and I guess some testing before inclusion.
>
> Here is the patch I'm applying.  Please test and let me know how it goes.
>
> Also, someone please send me a patch for the PCI ids :)
>
> 	Jeff
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8rI2yOYzc4nQ8j0RAkLnAJ9PuvWKuQNTszOEajMBOKrDiR1WiwCaA2Wl
ASO6sogwJ696le2lvrwZyhI=3D
=3DbLBK
=2D----END PGP SIGNATURE-----

--Boundary-00=_0Ir8/FX9CVfIvsW
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="aar1210sa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aar1210sa.diff"

--- linux-2.4.23/drivers/scsi/sata_sil.c	2003-12-31 12:22:36.000000000 +0100
+++ linux-2.4.23.moria/drivers/scsi/sata_sil.c	2003-12-22 12:03:57.000000000 +0100
@@ -39,6 +39,7 @@
 
 enum {
 	sil_3112		= 0,
+	aar1210sa		= 1,
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -62,6 +63,7 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, aar1210sa },
 	{ }	/* terminate list */
 };
 
@@ -122,6 +124,15 @@
 		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
 		.port_ops	= &sil_ops,
 	},
+	/* aar1210sa */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03,			/* pio3-4 */
+		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.port_ops	= &sil_ops,
+	},
 };
 
 MODULE_AUTHOR("Jeff Garzik");
@@ -263,6 +274,15 @@
 		goto err_out_regions;
 	}
 
+	u8 v;
+	pci_read_config_byte(pdev, 0x8a, &v);
+	int mask = 0x3f; //clear 6 and 7 bits
+	if (v & ~mask) {
+		printk("Reenabling interrupts because Adaptec's BIOS disables them\n" );
+		v &= mask;
+		pci_write_config_byte(pdev, 0x8a, v);
+	}
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->pdev = pdev;

--Boundary-00=_0Ir8/FX9CVfIvsW--
