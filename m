Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUESObY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUESObY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUESO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:29:54 -0400
Received: from [151.38.86.74] ([151.38.86.74]:1552 "EHLO gateway.milesteg.arr")
	by vger.kernel.org with ESMTP id S261300AbUESO3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:29:04 -0400
Date: Wed, 19 May 2004 16:28:52 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
       Dominik Karall <dominik.karall@gmx.net>
Subject: Re: [PATCH] Sis900 bug fixes 3/4
Message-ID: <20040519142852.GC798@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Dominik Karall <dominik.karall@gmx.net>
References: <20040518120237.GC23565@picchio.gall.it> <20040518123020.GF23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20040518123020.GF23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 02:30:20PM +0200, Daniele Venzano wrote:
> Dominik:
> Could you please test this patch ? Thanks.

After further testing with Dominik, I made a new patch that actually
works. So, please disregard patch number 3 I sent before and use this
one instead. The other patches need no changes and can be found here:

http://teg.homeunix.org/sis900.html

They are:
sis900-maintainers
sis900-isa-bridge-id
sis900-phy-detection (attached below)
sis900-header-cleanups

This patch has been tested on a previously working system (keeps
working) and on a before-not-working one (now works as expected).

Please, consider this patchset for inclusion.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-phy-detection.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.6/drivers/net/sis900.c	2004-05-18 21:46:41.000000000 +0200
+++ linux-sis900/drivers/net/sis900.c	2004-05-18 21:44:31.000000000 +0200
@@ -116,6 +116,7 @@
 #define	HOME 	0x0001
 #define LAN	0x0002
 #define MIX	0x0003
+#define UNKNOWN	0x0
 } mii_chip_table[] =3D {
 	{ "SiS 900 Internal MII PHY", 		0x001d, 0x8000, LAN },
 	{ "SiS 7014 Physical Layer Solution", 	0x0016, 0xf830, LAN },
@@ -577,9 +578,11 @@
 				break;
 			}
 		=09
-		if( !mii_chip_table[i].phy_id1 )
+		if( !mii_chip_table[i].phy_id1 ) {
 			printk(KERN_INFO "%s: Unknown PHY transceiver found at address %d.\n",
-			       net_dev->name, phy_addr);		=09
+			       net_dev->name, phy_addr);
+			mii_phy->phy_types =3D UNKNOWN;
+		}
 	}
 =09
 	if (sis_priv->mii =3D=3D NULL) {
@@ -644,15 +647,15 @@
 static u16 sis900_default_phy(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv =3D net_dev->priv;
- 	struct mii_phy *phy =3D NULL, *phy_home =3D NULL, *default_phy =3D NULL;
+ 	struct mii_phy *phy =3D NULL, *phy_home =3D NULL, *default_phy =3D NULL,=
 *phy_lan =3D NULL;
 	u16 status;
=20
         for( phy=3Dsis_priv->first_mii; phy; phy=3Dphy->next ){
 		status =3D mdio_read(net_dev, phy->phy_addr, MII_STATUS);
 		status =3D mdio_read(net_dev, phy->phy_addr, MII_STATUS);
=20
-		/* Link ON & Not select deafalut PHY */
-		 if ( (status & MII_STAT_LINK) && !(default_phy) )
+		/* Link ON & Not select default PHY & not ghost PHY */
+		 if ( (status & MII_STAT_LINK) && !default_phy && (phy->phy_types !=3D U=
NKNOWN) )
 		 	default_phy =3D phy;
 		 else{
 			status =3D mdio_read(net_dev, phy->phy_addr, MII_CONTROL);
@@ -660,12 +663,16 @@
 				status | MII_CNTL_AUTO | MII_CNTL_ISOLATE);
 			if( phy->phy_types =3D=3D HOME )
 				phy_home =3D phy;
+			else if (phy->phy_types =3D=3D LAN)
+				phy_lan =3D phy;
 		 }
 	}
=20
-	if( (!default_phy) && phy_home )
+	if( !default_phy && phy_home )
 		default_phy =3D phy_home;
-	else if(!default_phy)
+	else if( !default_phy && phy_lan )
+		default_phy =3D phy_lan;
+	else if ( !default_phy )
 		default_phy =3D sis_priv->first_mii;
=20
 	if( sis_priv->mii !=3D default_phy ){

--dTy3Mrz/UPE2dbVg--

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq28k2rmHZCWzV+0RAhAGAJwMI6K41FBomhpqaYGKEvkm+LDW7gCgmuFR
v8IVWisWzojsuvL1aBAJu44=
=NHT1
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
