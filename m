Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTLVCFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 21:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLVCFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 21:05:38 -0500
Received: from alhya.freenux.org ([213.41.137.38]:5504 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S263639AbTLVCFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 21:05:35 -0500
From: Mickael Marchand <marchand@kde.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] adaptec 1210sa
Date: Mon, 22 Dec 2003 03:05:28 +0100
User-Agent: KMail/1.5.94
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oFl5/UXITMcRaYH"
Message-Id: <200312220305.29955.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oFl5/UXITMcRaYH
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

reading linux-scsi I found a suggestion by Justin to make adaptec's 1210 sa=
=20
working. I made the corresponding patch for libata, and it actually works :)

it needs  some redesign to only apply to aar1210 (as standard sil3112 does =
not=20
need it) and I guess some testing before inclusion.

the idea suggested by Justin was to clear bits 6 and 7 at 0x8a of pci=20
configuration space. (which I hope did fine :)

Thanks Justin :)

Cheers,
Mik
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5lFoyOYzc4nQ8j0RAo9LAJ90CMeKb8wcE9ZgGULpUmep2wScdQCfYQ7B
fjiz1d2FE1+HTxFXSG2Pc6s=3D
=3Daott
=2D----END PGP SIGNATURE-----

--Boundary-00=_oFl5/UXITMcRaYH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aar1210sa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aar1210sa.patch"

--- /usr/src/linux-2.6.0/drivers/scsi/sata_sil.c	2003-12-21 13:30:58.000000000 +0100
+++ linux-2.6.0/drivers/scsi/sata_sil.c	2003-12-22 02:46:32.000000000 +0100
@@ -276,6 +276,16 @@
 		goto err_out_regions;
 	}
 
+	//let's have fun
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

--Boundary-00=_oFl5/UXITMcRaYH--
