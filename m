Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVAaVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVAaVIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVAaVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:06:07 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11703 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261362AbVAaVBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:01:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: Re: pci: Arch hook to determine config space size
Date: Mon, 31 Jan 2005 21:51:04 +0100
User-Agent: KMail/1.6.2
Cc: Matthew Wilcox <matthew@wil.cx>, Brian King <brking@us.ibm.com>,
       linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       linux-pci@vger.kernel.org
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <41FE82B6.9060407@us.ibm.com> <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Message-Id: <200501312151.05323.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5op/BZQOoGRTNPl";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5op/BZQOoGRTNPl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Maandag 31 Januar 2005 20:29, Matthew Wilcox wrote:
> Thanks for copying linux-pci. =A0I hate this patch.
>=20
> Basically, ppc64's config ops are broken and need to check the offset
> being read.=20

To make things worse, simply allowing the larger config space will
silently access the wrong device. The least that needs to be done
is to pass the correct address to the firmware.=20
This patch should do the right thing, though I don't have any PCIe
card to test with.

Note that at least for the rtas pci config access, the bus/devfn
values come from the device tree, which makes it somewhat harder
to screw them up, and rtas ought to check for obviously wrong
addresses as well.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

=2D-- linux-mm.orig/arch/ppc64/kernel/pSeries_pci.c	2005-01-28 07:21:15.000=
000000 -0500
+++ linux-mm/arch/ppc64/kernel/pSeries_pci.c	2005-01-31 15:56:10.244983464 =
=2D0500
@@ -63,7 +63,8 @@
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
=20
=2D	addr =3D (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr =3D ((where & 0xf00) << 20) | (dn->busno << 16)=20
+		| (dn->devfn << 8) | (where & 0x0ff);
 	buid =3D dn->phb->buid;
 	if (buid) {
 		ret =3D rtas_call(ibm_read_pci_config, 4, 2, &returnval,
@@ -111,7 +112,8 @@
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
=20
=2D	addr =3D (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr =3D ((where & 0xf00) << 20) | (dn->busno << 16)=20
+		| (dn->devfn << 8) | (where & 0x0ff);
 	buid =3D dn->phb->buid;
 	if (buid) {
 		ret =3D rtas_call(ibm_write_pci_config, 5, 1, NULL, addr, buid >> 32, bu=
id & 0xffffffff, size, (ulong) val);



--Boundary-02=_5op/BZQOoGRTNPl
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/po55t5GS2LDRf4RAgYQAKCOKna2d1KQ/Adr0fitfwfxUpT8dgCeLA3h
7vz/iV+NObjl0INNeD2nuwo=
=v+1m
-----END PGP SIGNATURE-----

--Boundary-02=_5op/BZQOoGRTNPl--
