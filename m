Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFOO7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTFOO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:59:49 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:40358 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262288AbTFOO7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:59:45 -0400
Date: Sun, 15 Jun 2003 16:13:26 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [PATCH] siimage.c: two problems in init_hwif_siimage()
Message-ID: <20030615151326.GI32730@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="STPqjqpCrtky8aYs"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Alan - 

   Two issues with the init_hwif_siimage function in
drivers/ide/pci/siimage.c:

1) is_sata returns 0 or 1, not a PCI_DEVICE_ID_.

2) In the same function, there is:

        if (hwif->pci_dev->device != PCI_DEVICE_ID_SII_3112)
                hwif->atapi_dma = 1;

   This doesn't initialise the 1210SA in the same way as the 3112. I
think the line should read:

	if(!is_sata(hwif))
                hwif->atapi_dma = 1;

   Patches below fix both separately.

   Hugo.

diff -ru --exclude-from patch-help/ignore linux-2.4.21-ac1/drivers/ide/pci/siimage.c linux-test/drivers/ide/pci/siimage.c
--- linux-2.4.21-ac1/drivers/ide/pci/siimage.c	2003-06-15 13:08:58.000000000 +0100
+++ linux-test/drivers/ide/pci/siimage.c	2003-06-15 13:29:10.000000000 +0100
@@ -1114,7 +1114,7 @@
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 
-	if(is_sata(hwif) == PCI_DEVICE_ID_SII_3112)
+	if(is_sata(hwif))
 		hwif->busproc   = &siimage_busproc;
 
 	if (!hwif->dma_base) {



diff -ru --exclude-from patch-help/ignore linux-2.4.21-ac1/drivers/ide/pci/siimage.c linux-test/drivers/ide/pci/siimage.c
--- linux-2.4.21-ac1/drivers/ide/pci/siimage.c	2003-06-15 13:08:58.000000000 +0100
+++ linux-test/drivers/ide/pci/siimage.c	2003-06-15 13:52:41.000000000 +0100
@@ -1127,7 +1127,7 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (hwif->pci_dev->device != PCI_DEVICE_ID_SII_3112)
+	if (!is_sata(hwif))
 		hwif->atapi_dma = 1;
 
 	hwif->ide_dma_check = &siimage_config_drive_for_dma;


-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
        --- Great oxymorons of the world, no. 2: Common Sense ---        

--STPqjqpCrtky8aYs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7I0WssJ7whwzWGARAj4tAKCxBQ0j92Z8oWlTAPK3XRQ6ne0BnQCdFogR
Sy8Jh2KiZ684RqaYoyfI2Zs=
=JGo1
-----END PGP SIGNATURE-----

--STPqjqpCrtky8aYs--
