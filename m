Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVJ2SZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVJ2SZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVJ2SZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:25:25 -0400
Received: from cassiel.sirena.org.uk ([80.68.93.111]:63250 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1751236AbVJ2SZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:25:24 -0400
Date: Sat, 29 Oct 2005 19:24:56 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] natsemi: Option to use MII port with no PHY
Message-ID: <20051029182456.GE3265@sirena.org.uk>
Mail-Followup-To: Tim Hockin <thockin@hockin.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
X-Cookie: Use only as directed.
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This patch provides a module option which configures 
	the natsemi driver to use the external MII port on the chip but ignore 
	any PHYs that may be attached to it. The link state will be left as it 
	was when the driver started and can be configured via ethtool. Any 
	PHYs that are present can be accessed via the MII ioctl()s. [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch provides a module option which configures the natsemi driver
to use the external MII port on the chip but ignore any PHYs that may be
attached to it.  The link state will be left as it was when the driver
started and can be configured via ethtool.  Any PHYs that are present
can be accessed via the MII ioctl()s.

This is useful for systems where the device is connected without a PHY
or where either information or actions outside the scope of the natsemi
driver are required in order to use the PHYs.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>

diff -uprN linux-2.6.14/drivers/net/natsemi.c linux/drivers/net/natsemi.c
--- linux-2.6.14/drivers/net/natsemi.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/drivers/net/natsemi.c	2005-10-29 15:53:16.000000000 +0100
@@ -264,7 +264,7 @@ MODULE_PARM_DESC(debug, "DP8381x default
 MODULE_PARM_DESC(rx_copybreak,=20
 	"DP8381x copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(options,=20
-	"DP8381x: Bits 0-3: media type, bit 17: full duplex");
+	"DP8381x: Bits 0-3: media type, bit 17: full duplex, bit 18: ignore PHY");
 MODULE_PARM_DESC(full_duplex, "DP8381x full duplex setting(s) (1)");
=20
 /*
@@ -693,6 +693,8 @@ struct netdev_private {
 	int oom;
 	/* Do not touch the nic registers */
 	int hands_off;
+	/* Don't pay attention to the reported link state. */
+	int ignore_phy;
 	/* external phy that is used: only valid if dev->if_port !=3D PORT_TP */
 	int mii;
 	int phy_addr_external;
@@ -880,7 +882,19 @@ static int __devinit natsemi_probe1 (str
 	np->msg_enable =3D (debug >=3D 0) ? (1<<debug)-1 : NATSEMI_DEF_MSG;
 	np->hands_off =3D 0;
=20
+	option =3D find_cnt < MAX_UNITS ? options[find_cnt] : 0;
+	if (dev->mem_start)
+		option =3D dev->mem_start;
+
+	/* Ignore the PHY status? */
+	if (option & 0x400) {
+		np->ignore_phy =3D 1;
+	} else {
+		np->ignore_phy =3D 0;
+	}
+
 	/* Initial port:
+	 * - If configured to ignore the PHY set up for external.
 	 * - If the nic was configured to use an external phy and if find_mii
 	 *   finds a phy: use external port, first phy that replies.
 	 * - Otherwise: internal port.
@@ -888,7 +902,7 @@ static int __devinit natsemi_probe1 (str
 	 * The address would be used to access a phy over the mii bus, but
 	 * the internal phy is accessed through mapped registers.
 	 */
-	if (readl(ioaddr + ChipConfig) & CfgExtPhy)
+	if (np->ignore_phy || readl(ioaddr + ChipConfig) & CfgExtPhy)
 		dev->if_port =3D PORT_MII;
 	else
 		dev->if_port =3D PORT_TP;
@@ -898,7 +912,9 @@ static int __devinit natsemi_probe1 (str
=20
 	if (dev->if_port !=3D PORT_TP) {
 		np->phy_addr_external =3D find_mii(dev);
-		if (np->phy_addr_external =3D=3D PHY_ADDR_NONE) {
+		/* If we're ignoring the PHY it doesn't matter if we can't
+		 * find one. */
+		if (!np->ignore_phy && np->phy_addr_external =3D=3D PHY_ADDR_NONE) {
 			dev->if_port =3D PORT_TP;
 			np->phy_addr_external =3D PHY_ADDR_INTERNAL;
 		}
@@ -906,10 +922,6 @@ static int __devinit natsemi_probe1 (str
 		np->phy_addr_external =3D PHY_ADDR_INTERNAL;
 	}
=20
-	option =3D find_cnt < MAX_UNITS ? options[find_cnt] : 0;
-	if (dev->mem_start)
-		option =3D dev->mem_start;
-
 	/* The lower four bits are the media type. */
 	if (option) {
 		if (option & 0x200)
@@ -940,7 +952,10 @@ static int __devinit natsemi_probe1 (str
 	if (mtu)
 		dev->mtu =3D mtu;
=20
-	netif_carrier_off(dev);
+	if (np->ignore_phy)
+		netif_carrier_on(dev);
+	else
+		netif_carrier_off(dev);
=20
 	/* get the initial settings from hardware */
 	tmp            =3D mdio_read(dev, MII_BMCR);
@@ -988,6 +1003,8 @@ static int __devinit natsemi_probe1 (str
 		printk("%02x, IRQ %d", dev->dev_addr[i], irq);
 		if (dev->if_port =3D=3D PORT_TP)
 			printk(", port TP.\n");
+		else if (np->ignore_phy)
+			printk(", port MII, ignoring PHY\n");
 		else
 			printk(", port MII, phy ad %d.\n", np->phy_addr_external);
 	}
@@ -1643,42 +1660,44 @@ static void check_link(struct net_device
 {
 	struct netdev_private *np =3D netdev_priv(dev);
 	void __iomem * ioaddr =3D ns_ioaddr(dev);
-	int duplex;
+	int duplex =3D np->full_duplex;
 	u16 bmsr;
-      =20
-	/* The link status field is latched: it remains low after a temporary
-	 * link failure until it's read. We need the current link status,
-	 * thus read twice.
-	 */
-	mdio_read(dev, MII_BMSR);
-	bmsr =3D mdio_read(dev, MII_BMSR);
=20
-	if (!(bmsr & BMSR_LSTATUS)) {
-		if (netif_carrier_ok(dev)) {
+	/* If we're not paying attention to the PHY status then don't check. */
+	if (!np->ignore_phy) {      =20
+		/* The link status field is latched: it remains low
+		 * after a temporary link failure until it's read. We
+		 * need the current link status, thus read twice.
+		 */
+		mdio_read(dev, MII_BMSR);
+		bmsr =3D mdio_read(dev, MII_BMSR);
+
+		if (!(bmsr & BMSR_LSTATUS)) {
+			if (netif_carrier_ok(dev)) {
+				if (netif_msg_link(np))
+					printk(KERN_NOTICE "%s: link down.\n",
+					       dev->name);
+				netif_carrier_off(dev);
+				undo_cable_magic(dev);
+			}
+			return;
+		}
+		if (!netif_carrier_ok(dev)) {
 			if (netif_msg_link(np))
-				printk(KERN_NOTICE "%s: link down.\n",
-					dev->name);
-			netif_carrier_off(dev);
-			undo_cable_magic(dev);
+				printk(KERN_NOTICE "%s: link up.\n", dev->name);
+			netif_carrier_on(dev);
+			do_cable_magic(dev);
 		}
-		return;
-	}
-	if (!netif_carrier_ok(dev)) {
-		if (netif_msg_link(np))
-			printk(KERN_NOTICE "%s: link up.\n", dev->name);
-		netif_carrier_on(dev);
-		do_cable_magic(dev);
-	}
-
-	duplex =3D np->full_duplex;
-	if (!duplex) {
-		if (bmsr & BMSR_ANEGCOMPLETE) {
-			int tmp =3D mii_nway_result(
-				np->advertising & mdio_read(dev, MII_LPA));
-			if (tmp =3D=3D LPA_100FULL || tmp =3D=3D LPA_10FULL)
+	=09
+		if (!duplex) {
+			if (bmsr & BMSR_ANEGCOMPLETE) {
+				int tmp =3D mii_nway_result(
+					np->advertising & mdio_read(dev, MII_LPA));
+				if (tmp =3D=3D LPA_100FULL || tmp =3D=3D LPA_10FULL)
+					duplex =3D 1;
+			} else if (mdio_read(dev, MII_BMCR) & BMCR_FULLDPLX)
 				duplex =3D 1;
-		} else if (mdio_read(dev, MII_BMCR) & BMCR_FULLDPLX)
-			duplex =3D 1;
+		}
 	}
=20
 	/* if duplex is set then bit 28 must be set, too */

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ2O+dQ2erOLNe+68AQLL6wP+OC/INVcOW3Nl+SFKJQQ/YRDLUpe5WXV9
lzhDEgTtsW5mX4vNklTinAKD9zyotYozeRYeBnFiiRILA0w8tqw6VlRlXP8+yIiB
QZF0UVAOstVS9nW+4Gy8lBYz4rJEWRMWA+/vANLE6nY3GBZHGRc/QgOY7imVWiDn
UXRMHKOsNiY=
=5mK+
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
