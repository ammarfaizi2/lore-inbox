Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268308AbUH2Umo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbUH2Umo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUH2Ukn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:40:43 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:37127 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268306AbUH2UkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:40:21 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Subject: [PATCH][3/4] b44: Add support for PHY-less cards
Date: Sun, 29 Aug 2004 22:36:47 +0200
User-Agent: KMail/1.7
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200408292218.00756.jolt@tuxbox.org>
In-Reply-To: <200408292218.00756.jolt@tuxbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12312557.6IaqflfA8j";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408292236.49864.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12312557.6IaqflfA8j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

add support for PHY-less cards by using a special magic PHY address. This i=
s compatible with the way Broadcom drivers handle that. We don't have to wa=
ste a flags bit for that.

Regards,
   Florian

Signed-off-by: Florian Schirmer <jolt@tuxbox.org>

=2D-- linux/drivers/net/b44.c-old3 2004-08-29 16:59:24.000000000 +0200
+++ linux/drivers/net/b44.c 2004-08-29 17:24:23.000000000 +0200
@@ -273,6 +273,9 @@ static int b44_readphy(struct b44 *bp, i
 {
  int err;
=20
+ if (bp->phy_addr =3D=3D B44_PHY_ADDR_NO_PHY)
+  return 0;
+
  bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
  bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
         (MDIO_OP_READ << MDIO_DATA_OP_SHIFT) |
@@ -287,6 +290,9 @@ static int b44_readphy(struct b44 *bp, i
=20
 static int b44_writephy(struct b44 *bp, int reg, u32 val)
 {
+ if (bp->phy_addr =3D=3D B44_PHY_ADDR_NO_PHY)
+  return 0;
+
  bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
  bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
         (MDIO_OP_WRITE << MDIO_DATA_OP_SHIFT) |
@@ -325,6 +331,9 @@ static int b44_phy_reset(struct b44 *bp)
  u32 val;
  int err;
=20
+ if (bp->phy_addr =3D=3D B44_PHY_ADDR_NO_PHY)
+  return 0;
+
  err =3D b44_writephy(bp, MII_BMCR, BMCR_RESET);
  if (err)
   return err;
@@ -395,6 +404,9 @@ static int b44_setup_phy(struct b44 *bp)
  u32 val;
  int err;
=20
+ if (bp->phy_addr =3D=3D B44_PHY_ADDR_NO_PHY)
+  return 0;
+
  if ((err =3D b44_readphy(bp, B44_MII_ALEDCTRL, &val)) !=3D 0)
   goto out;
  if ((err =3D b44_writephy(bp, B44_MII_ALEDCTRL,
@@ -487,6 +499,19 @@ static void b44_check_phy(struct b44 *bp
 {
  u32 bmsr, aux;
=20
+ if (bp->phy_addr =3D=3D B44_PHY_ADDR_NO_PHY) {
+  bp->flags |=3D B44_FLAG_100_BASE_T;
+  bp->flags |=3D B44_FLAG_FULL_DUPLEX;
+  if (!netif_carrier_ok(bp->dev)) {
+   u32 val =3D br32(B44_TX_CTRL);
+   val |=3D TX_CTRL_DUPLEX;
+   bw32(B44_TX_CTRL, val);
+   netif_carrier_on(bp->dev);
+   b44_link_report(bp);
+  }
+  return;
+ }
+
  if (!b44_readphy(bp, MII_BMSR, &bmsr) &&
      !b44_readphy(bp, B44_MII_AUXCTRL, &aux) &&
      (bmsr !=3D 0xffff)) {
=2D-- linux/drivers/net/b44.h-old3 2004-08-29 17:06:44.000000000 +0200
+++ linux/drivers/net/b44.h 2004-08-29 17:24:53.000000000 +0200
@@ -362,6 +362,7 @@ struct ring_info {
 };
=20
 #define B44_MCAST_TABLE_SIZE 32
+#define B44_PHY_ADDR_NO_PHY 30
=20
 /* SW copy of device statistics, kept up to date by periodic timer
  * which probes HW values.  Must have same relative layout as HW


--nextPart12312557.6IaqflfA8j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMj5hXRF2vHoIlBsRAttxAJ4zmhJ2mzkKRYQod8/VBf+rSl7pjwCgnY9m
usmukrWJH1G5rPOy1iEnJKA=
=/mCv
-----END PGP SIGNATURE-----

--nextPart12312557.6IaqflfA8j--
