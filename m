Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWGCMaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWGCMaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWGCMaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:30:13 -0400
Received: from mivlgu.ru ([81.18.140.87]:6071 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1750876AbWGCMaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:30:11 -0400
Date: Mon, 3 Jul 2006 16:29:58 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
Message-Id: <20060703162958.d980ee6e.vsu@altlinux.ru>
In-Reply-To: <44A8F8D2.1030101@reub.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44A8F8D2.1030101@reub.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__3_Jul_2006_16_29_58_+0400_Fv3enIcLbi+S6+4/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Jul_2006_16_29_58_+0400_Fv3enIcLbi+S6+4/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Jul 2006 23:00:34 +1200 Reuben Farrelly wrote:

> Allocate Port Service[0000:00:1c.0:pcie0]
> Allocate Port Service[0000:00:1c.0:pcie0]
> kobject_add failed for 0000:00:1c.0:pcie0 with -EEXIST, don't try to regi=
ster=20
> things with the same name in the same directory.

These names are truncated - they should end with two hex digits:

	snprintf(device->bus_id, sizeof(device->bus_id), "%s:pcie%02x",
		 pci_name(parent), get_descriptor_id(port_type, service_type));

Names were truncated at 18 characters, but sizeof(device->bus_id) is 20
currently, so these names should just fit there.  I see that snprintf()
was changed recently - maybe there is some off-by-one bug there?

And if you want, you can blame me for such long names:

commit 8c9ad508c8737ca46a4c55b1062d159b86f7cee2
Author: Sergey Vlasov <vsu@altlinux.ru>
Date:   Mon Nov 14 20:30:50 2005 +0300

    [PATCH] PCIE: make bus_id for PCI Express devices unique
   =20
    The bus_id string must be unique for all devices of that bus in the
    system, not just for devices with the same parent - otherwise multiple
    symlinks with identical names appear in /sys/bus/pci_express/devices.
   =20
    Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_cor=
e.c
index 467a4ce..e4e5f1e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -238,8 +238,8 @@ static void pcie_device_init(struct pci_
 	device->driver =3D NULL;
 	device->driver_data =3D NULL;
 	device->release =3D release_pcie_device;	/* callback to free pcie dev */
-	sprintf(&device->bus_id[0], "pcie%02x",
-		get_descriptor_id(port_type, service_type));
+	snprintf(device->bus_id, sizeof(device->bus_id), "%s:pcie%02x",
+		 pci_name(parent), get_descriptor_id(port_type, service_type));
 	device->parent =3D &parent->dev;
 }
=20


--Signature=_Mon__3_Jul_2006_16_29_58_+0400_Fv3enIcLbi+S6+4/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEqQ3LW82GfkQfsqIRAqgHAJ0bm/rEmIx1x4pBOw5GLyLPiGcFWwCgk3W5
yhlNbKB6KRusK+1ch3VfNjs=
=/mvz
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Jul_2006_16_29_58_+0400_Fv3enIcLbi+S6+4/--
