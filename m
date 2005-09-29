Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVI2KdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVI2KdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVI2KdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 06:33:23 -0400
Received: from joel.tallye.com ([216.99.199.78]:64425 "EHLO hosea.tallye.com")
	by vger.kernel.org with ESMTP id S1750715AbVI2KdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 06:33:23 -0400
Date: Thu, 29 Sep 2005 03:33:09 -0700
From: "Loren M. Lang" <lorenl@alzatex.com>
To: linux-kernel@vger.kernel.org
Subject: RocketPoint 1520 [hpt366] fails clock stabilization
Message-ID: <20050929103309.GA12361@alzatex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
X-GPG-Fingerprint: B3B9 D669 69C9 09EC 1BCD  835A FAF3 7A46 E4A3 280C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please CC me as I'm not on the list.

I just purchased a HighPoint Rocket 1520 SATA controller.  There seems
to be no libata driver (yet), but there is an ide driver, hpt366.  When
the driver gets loaded, it causes a kernel NULL pointer dereference in
pci_bus_clock_list.  It seems to be because the driver is waiting for
clock stabilization in init_hpt37x() which never comes.  The driver just
continues on with the pci drvdata set to NULL, instead of a valid clock
entry.  The following patch prevents the NULL dereference from
happening, but instead exit with an error.

--- drivers/ide/pci/hpt366.c.orig       2005-09-29 01:00:12.000000000
+++ drivers/ide/pci/hpt366.c    2005-09-29 01:00:17.000000000 -0700
-0700
@@ -1310,10 +1310,6 @@
                                goto init_hpt37X_done;
                        }
                }
+               if (!pci_get_drvdata(dev)) {
+                       printk("No Clock Stabilization!!!\n");
+                       return -1;
+               }
 pll_recal:
                if (adjust & 1)
                        pll -=3D (adjust >> 1);

I am using Gentoo linux with a gentoo patched kernel 2.6.12-r10.  The
dmesg of the driver attempting to attach is:

HPT372A: IDE controller at PCI slot 0000:02:0c.0
PCI: Enabling device 0000:02:0c.0 (0105 -> 0107)
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
HPT372A: chipset revision 2
hpt: HPT372N detected, using 372N timing.
FREQ: 125 PLL: 45
No Clock Stabilization!!!
HPT366_IDE: probe of 0000:02:0c.0 failed with error -1

I have seen a post from last year of someone with a similar problem.

http://readlist.com/lists/vger.kernel.org/linux-kernel/10/50990.html

Seems to be the same oops I was seeing.

--=20
I sense much NT in you.
NT leads to Bluescreen.
Bluescreen leads to downtime.
Downtime leads to suffering.
NT is the path to the darkside.
Powerful Unix is.

Public Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
Fingerprint: CEE1 AAE2 F66C 59B5 34CA  C415 6D35 E847 0118 A3D2
=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFDO8LlbTXoRwEYo9IRAlMKAJ41on6+6h6UWfZlPfafcnsvqNxcZwCbB0BJ
9rzfRFpYDYP8TPtIjcpUfQM=
=KAZn
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
