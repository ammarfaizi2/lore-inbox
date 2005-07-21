Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVGUWhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVGUWhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVGUWhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:37:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57745 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261910AbVGUWhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:37:45 -0400
Message-ID: <42E023B2.5030900@us.ibm.com>
Date: Thu, 21 Jul 2005 15:37:38 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
CC: AJ Johnson <blujuice@us.ibm.com>
Subject: [PATCH] serverworks should not take ahold of megaraid'd controllers
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D4648A981B3A7BA646483D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D4648A981B3A7BA646483D0
Content-Type: multipart/mixed;
 boundary="------------020904050004010507030005"

This is a multi-part message in MIME format.
--------------020904050004010507030005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I've noticed what might be a small bug with the serverworks driver in
2.6.12.3.  The IBM HS20 blade has a ServerWorks CSB6 IDE controller with
an optional LSI MegaIDE RAID BIOS (BIOS assisted software raid, iow).
When this megaide BIOS is enabled on the HS20, the PCI
subvendor/subdevice IDs on the CSB6 are changed from the default
(ServerWorks) to IBM.  However, the serverworks driver doesn't notice
this and will attach to the controller anyway, thus allowing raw access
to the disks in the RAID.  An unsuspecting user can then read and write
whatever they want to the drive, which could very well degrade or
destroy the array, which is clearly not desirable behavior.

The attached patch against 2.6.12.3 makes the serverworks driver ignore
a megaraided CSB6.  If desired, I can respin this patch with a debugging
knob to force the serverworks driver to use the old behavior.  This
patch has been tested on the HS20 mentioned above, and I haven't seen
any problems with it.

Please let me know what you think of this patch; I'm not cc'd on lkml or
linux-ide.

--Darrick

--------------020904050004010507030005
Content-Type: text/x-patch;
 name="megaraid_svwks_blacklist-2.6.12.3-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="megaraid_svwks_blacklist-2.6.12.3-2.patch"

diff -Naur linux-2.6.12.3_0/drivers/ide/pci/serverworks.c linux-2.6.12.3_1/drivers/ide/pci/serverworks.c
--- linux-2.6.12.3_0/drivers/ide/pci/serverworks.c	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.12.3_1/drivers/ide/pci/serverworks.c	2005-07-21 13:02:54.469552989 -0700
@@ -645,6 +647,15 @@
 {
 	ide_pci_device_t *d = &serverworks_chipsets[id->driver_data];
 
+	/* Refuse to acknowledge CSB6 in MegaRAID mode on IBM HS20/40 blade. */
+	if (	dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
+		dev->subsystem_device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE)
+	{
+		printk(KERN_INFO "svwks: MegaRAID detected; ignoring.\n");
+		return -ENODEV;
+	}
+
+
 	return d->init_setup(dev, d);
 }
 

--------------020904050004010507030005--

--------------enig9D4648A981B3A7BA646483D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4CO3a6vRYYgWQuURAty/AJ959wv2qob8arVEEOiYK/o/7SI/BwCfZ02j
y736393c853mf42E6l92lEY=
=nvtN
-----END PGP SIGNATURE-----

--------------enig9D4648A981B3A7BA646483D0--
