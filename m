Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWB0Wqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWB0Wqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWB0Wqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:46:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63360 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751640AbWB0WbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:19 -0500
Message-Id: <20060227223403.034304000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:31 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 31/39] [PATCH] skge: genesis phy initialization fix
Content-Disposition: inline; filename=skge-genesis-phy-initialization-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The SysKonnect Genesis based board would fail on initialization
with phy_read errors caused by not waiting for last phy write.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/skge.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

--- linux-2.6.15.4.orig/drivers/net/skge.c
+++ linux-2.6.15.4/drivers/net/skge.c
@@ -880,13 +880,12 @@ static int __xm_phy_read(struct skge_hw 
 	int i;
 
 	xm_write16(hw, port, XM_PHY_ADDR, reg | hw->phy_addr);
-	xm_read16(hw, port, XM_PHY_DATA);
+	*val = xm_read16(hw, port, XM_PHY_DATA);
 
-	/* Need to wait for external PHY */
 	for (i = 0; i < PHY_RETRIES; i++) {
-		udelay(1);
 		if (xm_read16(hw, port, XM_MMU_CMD) & XM_MMU_PHY_RDY)
 			goto ready;
+		udelay(1);
 	}
 
 	return -ETIMEDOUT;
@@ -919,7 +918,12 @@ static int xm_phy_write(struct skge_hw *
 
  ready:
 	xm_write16(hw, port, XM_PHY_DATA, val);
-	return 0;
+	for (i = 0; i < PHY_RETRIES; i++) {
+		if (!(xm_read16(hw, port, XM_MMU_CMD) & XM_MMU_PHY_BUSY))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
 }
 
 static void genesis_init(struct skge_hw *hw)
@@ -1169,13 +1173,17 @@ static void genesis_mac_init(struct skge
 	u32 r;
 	const u8 zero[6]  = { 0 };
 
-	/* Clear MIB counters */
-	xm_write16(hw, port, XM_STAT_CMD,
-			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
-	/* Clear two times according to Errata #3 */
-	xm_write16(hw, port, XM_STAT_CMD,
-			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+	for (i = 0; i < 10; i++) {
+		skge_write16(hw, SK_REG(port, TX_MFF_CTRL1),
+			     MFF_SET_MAC_RST);
+		if (skge_read16(hw, SK_REG(port, TX_MFF_CTRL1)) & MFF_SET_MAC_RST)
+			goto reset_ok;
+		udelay(1);
+	}
 
+	printk(KERN_WARNING PFX "%s: genesis reset failed\n", dev->name);
+
+ reset_ok:
 	/* Unreset the XMAC. */
 	skge_write16(hw, SK_REG(port, TX_MFF_CTRL1), MFF_CLR_MAC_RST);
 
@@ -1192,7 +1200,7 @@ static void genesis_mac_init(struct skge
 		r |= GP_DIR_2|GP_IO_2;
 
 	skge_write32(hw, B2_GP_IO, r);
-	skge_read32(hw, B2_GP_IO);
+
 
 	/* Enable GMII interface */
 	xm_write16(hw, port, XM_HW_CFG, XM_HW_GMII_MD);
@@ -1206,6 +1214,13 @@ static void genesis_mac_init(struct skge
 	for (i = 1; i < 16; i++)
 		xm_outaddr(hw, port, XM_EXM(i), zero);
 
+	/* Clear MIB counters */
+	xm_write16(hw, port, XM_STAT_CMD,
+			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+	/* Clear two times according to Errata #3 */
+	xm_write16(hw, port, XM_STAT_CMD,
+			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+
 	/* configure Rx High Water Mark (XM_RX_HI_WM) */
 	xm_write16(hw, port, XM_RX_HI_WM, 1450);
 

--
