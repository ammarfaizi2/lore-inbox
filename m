Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbUCXQdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUCXQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:33:52 -0500
Received: from mivlgu.ru ([81.18.140.87]:41384 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S263760AbUCXQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:33:43 -0500
Date: Wed, 24 Mar 2004 19:33:40 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] sata_via broken by recent libata updates
Message-ID: <20040324163340.GD23503@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

After updating from 2.4.25-libata1 to 2.4.25-libata9 the sata_via
driver stopped working.  The module loads and even seems to detect
the presense of drives, but the SCSI-emulation devices are not
registered:

===== messages hand-copied from screen =====
sata_via (00:0f.0) routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 20
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 20
ata1: dev 0 ATA, max UDMA7, 234493056 sectors (lba48)
ata2: no device found (phy stat 00000000)
===== end of messages from sata_via =====

The machine does not hang - booting fails later, because the root
device is not accessible.

2.4.25-libata1 worked fine on the same hardware:

===== log from a successful boot ======
libata version 1.00 loaded.
sata_via version 0.11
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 20
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:80ff
ata1: dev 0 ATA, max UDMA7, 234493056 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ATA: abnormal status 0x7F on port 0xC007
ata2: thread exiting
scsi0 : sata_via
scsi1 : sata_via
  Vendor: ATA       Model: SAMSUNG SP1213C    Rev: 1.00
  Type:   Direct-Access     ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
===== end =====

Seems that the problem is caused by changes in the device
initialization - calling ata_device_add() from svia_init_one() does
not work (at least with the 2.4.x SCSI layer).  The following patch
solves the initialization problem:

--- kernel-source-2.4.25/drivers/scsi/sata_via.c.sata_via-init-fix	2004-03-22 14:03:31 +0300
+++ kernel-source-2.4.25/drivers/scsi/sata_via.c	2004-03-24 16:27:50 +0300
@@ -264,9 +264,7 @@ static int svia_init_one (struct pci_dev
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	ata_add_to_probe_list(probe_ent);
 
 	return 0;
 

-- 
Sergey Vlasov

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYbhkW82GfkQfsqIRAtQ0AJ0Ry49ITca3Q5YYZilcIoyKQ9KudwCfV3+4
n+HL8nr+RL9BU3GqpoShIPQ=
=XUyT
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
