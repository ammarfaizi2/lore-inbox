Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUKJI2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUKJI2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUKJI2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:28:16 -0500
Received: from colino.net ([213.41.131.56]:2811 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261243AbUKJI2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:28:04 -0500
Date: Wed, 10 Nov 2004 09:27:31 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] sungem: Fix stop_phy
Message-ID: <20041110092731.230719cb.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sungem driver's stop_phy differs quite a lot from Darwin's driver:
In darwin, the hack consisting in reading and writing the same 
from/to MII_LPA is applied to every sungem card, not only bcm5201.
Also, it is done before the rest of the stuff, not after. Maybe order
matters.
In Linux sungem's driver, the BCM5221 phy is suspended as the BCM5201.
It is (completely) different in darwin.

The patch following this follows OS X a bit more closely. It works on
iBook G4 with a BCM5221, it would be nice if users of other PHYs could
test it. If I'm correct, stop_phy is called once during boot (I had an
oops from it during boot while hacking on it), so booting and checking
that network works should be enough.

Signed-off-by: Colin Leroy <colin@colino.net>
diff -ur a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	2004-10-18 23:55:28.000000000 +0200
+++ b/drivers/net/sungem.c	2004-11-10 09:16:55.660896544 +0100
@@ -2124,6 +2124,8 @@
 	 */
 	msleep(10);
 
+	/* FIXME OS X starts with disabling interrupts for BCM5201 */
+
 	/* Make sure we aren't polling PHY status change. We
 	 * don't currently use that feature though
 	 */
@@ -2131,6 +2133,8 @@
 	mifcfg &= ~MIF_CFG_POLL;
 	writel(mifcfg, gp->regs + MIF_CFG);
 
+	bcm_link_partner_hack(&gp->phy_mii);
+
 	if (gp->wake_on_lan) {
 		/* Setup wake-on-lan */
 	} else {
@@ -2159,7 +2163,7 @@
 	}
 
 	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
-		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
+		gp->phy_mii.def->ops->suspend(&gp->phy_mii, gp->wake_on_lan);
 
 	if (!gp->wake_on_lan) {
 		/* According to Apple, we must set the MDIO pins to this begnign
diff -ur a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
--- a/drivers/net/sungem_phy.c	2004-10-18 23:53:45.000000000 +0200
+++ b/drivers/net/sungem_phy.c	2004-11-10 08:59:20.000000000 +0100
@@ -101,15 +101,17 @@
 	return 0;
 }
 
-static int bcm5201_suspend(struct mii_phy* phy, int wol_options)
+void bcm_link_partner_hack(struct mii_phy *phy)
 {
-	if (!wol_options)
-		phy_write(phy, MII_BCM5201_INTERRUPT, 0);
-
 	/* Here's a strange hack used by both MacOS 9 and X */
 	phy_write(phy, MII_LPA, phy_read(phy, MII_LPA));
-	
+}
+
+static int bcm5201_suspend(struct mii_phy* phy, int wol_options)
+{
 	if (!wol_options) {
+		phy_write(phy, MII_BCM5201_INTERRUPT, 0);
+
 #if 0 /* Commented out in Darwin... someone has those dawn docs ? */
 		u16 val = phy_read(phy, MII_BCM5201_AUXMODE2)
 		phy_write(phy, MII_BCM5201_AUXMODE2,
@@ -144,6 +146,20 @@
 	return 0;
 }
 
+static int bcm5221_suspend(struct mii_phy* phy, int wol_options)
+{
+	if (!wol_options) {
+		u16 data = phy_read(phy, MII_BCM5221_TEST);
+		phy_write(phy, MII_BCM5221_TEST, 
+			data | MII_BCM5221_TEST_ENABLE_SHADOWS);
+
+		data = phy_read(phy, MII_BCM5221_SHDOW_AUX_MODE4);
+		phy_write(phy, MII_BCM5221_SHDOW_AUX_MODE4, 
+			data | MII_BCM5221_IDDQ);
+	}
+	return 0;
+}
+
 static int bcm5400_init(struct mii_phy* phy)
 {
 	u16 data;
@@ -662,7 +678,7 @@
 
 /* Broadcom BCM 5221 */
 static struct mii_phy_ops bcm5221_phy_ops = {
-	.suspend	= bcm5201_suspend,
+	.suspend	= bcm5221_suspend,
 	.init		= bcm5221_init,
 	.setup_aneg	= genmii_setup_aneg,
 	.setup_forced	= genmii_setup_forced,
diff -ur a/drivers/net/sungem_phy.h b/drivers/net/sungem_phy.h
--- a/drivers/net/sungem_phy.h	2004-10-18 23:54:40.000000000 +0200
+++ b/drivers/net/sungem_phy.h	2004-11-10 08:59:53.000000000 +0100
@@ -53,6 +53,7 @@
  */
 extern int mii_phy_probe(struct mii_phy *phy, int mii_id);
 
+void bcm_link_partner_hack(struct mii_phy *phy);
 
 /* MII definitions missing from mii.h */
 
@@ -81,6 +82,7 @@
 #define MII_BCM5221_SHDOW_AUX_STAT2_APD		0x0020
 #define MII_BCM5221_SHDOW_AUX_MODE4		0x1a
 #define MII_BCM5221_SHDOW_AUX_MODE4_CLKLOPWR	0x0004
+#define MII_BCM5221_IDDQ			0x0001
 
 /* MII BCM5400 1000-BASET Control register */
 #define MII_BCM5400_GB_CONTROL			0x09
