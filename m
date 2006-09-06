Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWIFXJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWIFXJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWIFXJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:09:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:24781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964971AbWIFXDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:00 -0400
Date: Wed, 6 Sep 2006 15:58:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 36/37] sky2: fix fiber support
Message-ID: <20060906225808.GK15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-fiber.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

Fix support for fiber based devices.  Needed to keep track of PMD type to
add workaround in setup. Add support for gigabit half duplex fiber.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |   81 ++++++++++++++++++++++++++++++++---------------------
 drivers/net/sky2.h |   15 +++++++++
 2 files changed, 63 insertions(+), 33 deletions(-)

--- linux-2.6.17.11.orig/drivers/net/sky2.c
+++ linux-2.6.17.11/drivers/net/sky2.c
@@ -321,7 +321,7 @@ static void sky2_phy_init(struct sky2_hw
 	}
 
 	ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
-	if (hw->copper) {
+	if (sky2_is_copper(hw)) {
 		if (hw->chip_id == CHIP_ID_YUKON_FE) {
 			/* enable automatic crossover */
 			ctrl |= PHY_M_PC_MDI_XMODE(PHY_M_PC_ENA_AUTO) >> 1;
@@ -338,25 +338,37 @@ static void sky2_phy_init(struct sky2_hw
 				ctrl |= PHY_M_PC_DSC(2) | PHY_M_PC_DOWN_S_ENA;
 			}
 		}
-		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
 	} else {
 		/* workaround for deviation #4.88 (CRC errors) */
 		/* disable Automatic Crossover */
 
 		ctrl &= ~PHY_M_PC_MDIX_MSK;
-		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+	}
 
-		if (hw->chip_id == CHIP_ID_YUKON_XL) {
-			/* Fiber: select 1000BASE-X only mode MAC Specific Ctrl Reg. */
-			gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 2);
-			ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
-			ctrl &= ~PHY_M_MAC_MD_MSK;
-			ctrl |= PHY_M_MAC_MODE_SEL(PHY_M_MAC_MD_1000BX);
-			gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+	gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+
+	/* special setup for PHY 88E1112 Fiber */
+	if (hw->chip_id == CHIP_ID_YUKON_XL && !sky2_is_copper(hw)) {
+		pg = gm_phy_read(hw, port, PHY_MARV_EXT_ADR);
 
+		/* Fiber: select 1000BASE-X only mode MAC Specific Ctrl Reg. */
+		gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 2);
+		ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
+		ctrl &= ~PHY_M_MAC_MD_MSK;
+		ctrl |= PHY_M_MAC_MODE_SEL(PHY_M_MAC_MD_1000BX);
+		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+
+		if (hw->pmd_type  == 'P') {
 			/* select page 1 to access Fiber registers */
 			gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 1);
+
+			/* for SFP-module set SIGDET polarity to low */
+			ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
+			ctrl |= PHY_M_FIB_SIGD_POL;
+			gm_phy_write(hw, port, PHY_MARV_CTRL, ctrl);
 		}
+
+		gm_phy_write(hw, port, PHY_MARV_EXT_ADR, pg);
 	}
 
 	ctrl = gm_phy_read(hw, port, PHY_MARV_CTRL);
@@ -373,7 +385,7 @@ static void sky2_phy_init(struct sky2_hw
 	adv = PHY_AN_CSMA;
 
 	if (sky2->autoneg == AUTONEG_ENABLE) {
-		if (hw->copper) {
+		if (sky2_is_copper(hw)) {
 			if (sky2->advertising & ADVERTISED_1000baseT_Full)
 				ct1000 |= PHY_M_1000C_AFD;
 			if (sky2->advertising & ADVERTISED_1000baseT_Half)
@@ -386,8 +398,12 @@ static void sky2_phy_init(struct sky2_hw
 				adv |= PHY_M_AN_10_FD;
 			if (sky2->advertising & ADVERTISED_10baseT_Half)
 				adv |= PHY_M_AN_10_HD;
-		} else		/* special defines for FIBER (88E1011S only) */
-			adv |= PHY_M_AN_1000X_AHD | PHY_M_AN_1000X_AFD;
+		} else {	/* special defines for FIBER (88E1040S only) */
+			if (sky2->advertising & ADVERTISED_1000baseT_Full)
+				adv |= PHY_M_AN_1000X_AFD;
+			if (sky2->advertising & ADVERTISED_1000baseT_Half)
+				adv |= PHY_M_AN_1000X_AHD;
+		}
 
 		/* Set Flow-control capabilities */
 		if (sky2->tx_pause && sky2->rx_pause)
@@ -1497,7 +1513,7 @@ static int sky2_down(struct net_device *
 
 static u16 sky2_phy_speed(const struct sky2_hw *hw, u16 aux)
 {
-	if (!hw->copper)
+	if (!sky2_is_copper(hw))
 		return SPEED_1000;
 
 	if (hw->chip_id == CHIP_ID_YUKON_FE)
@@ -2287,7 +2303,7 @@ static inline u32 sky2_clk2us(const stru
 static int __devinit sky2_reset(struct sky2_hw *hw)
 {
 	u16 status;
-	u8 t8, pmd_type;
+	u8 t8;
 	int i;
 
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
@@ -2333,9 +2349,7 @@ static int __devinit sky2_reset(struct s
 		sky2_pci_write32(hw, PEX_UNC_ERR_STAT, 0xffffffffUL);
 
 
-	pmd_type = sky2_read8(hw, B2_PMD_TYP);
-	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
-
+	hw->pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->ports = 1;
 	t8 = sky2_read8(hw, B2_Y2_HW_RES);
 	if ((t8 & CFG_DUAL_MAC_MSK) == CFG_DUAL_MAC_MSK) {
@@ -2432,21 +2446,22 @@ static int __devinit sky2_reset(struct s
 
 static u32 sky2_supported_modes(const struct sky2_hw *hw)
 {
-	u32 modes;
-	if (hw->copper) {
-		modes = SUPPORTED_10baseT_Half
-		    | SUPPORTED_10baseT_Full
-		    | SUPPORTED_100baseT_Half
-		    | SUPPORTED_100baseT_Full
-		    | SUPPORTED_Autoneg | SUPPORTED_TP;
+	if (sky2_is_copper(hw)) {
+		u32 modes = SUPPORTED_10baseT_Half
+			| SUPPORTED_10baseT_Full
+			| SUPPORTED_100baseT_Half
+			| SUPPORTED_100baseT_Full
+			| SUPPORTED_Autoneg | SUPPORTED_TP;
 
 		if (hw->chip_id != CHIP_ID_YUKON_FE)
 			modes |= SUPPORTED_1000baseT_Half
-			    | SUPPORTED_1000baseT_Full;
+				| SUPPORTED_1000baseT_Full;
+		return modes;
 	} else
-		modes = SUPPORTED_1000baseT_Full | SUPPORTED_FIBRE
-		    | SUPPORTED_Autoneg;
-	return modes;
+		return  SUPPORTED_1000baseT_Half
+			| SUPPORTED_1000baseT_Full
+			| SUPPORTED_Autoneg
+			| SUPPORTED_FIBRE;
 }
 
 static int sky2_get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
@@ -2457,7 +2472,7 @@ static int sky2_get_settings(struct net_
 	ecmd->transceiver = XCVR_INTERNAL;
 	ecmd->supported = sky2_supported_modes(hw);
 	ecmd->phy_address = PHY_ADDR_MARV;
-	if (hw->copper) {
+	if (sky2_is_copper(hw)) {
 		ecmd->supported = SUPPORTED_10baseT_Half
 		    | SUPPORTED_10baseT_Full
 		    | SUPPORTED_100baseT_Half
@@ -2466,12 +2481,14 @@ static int sky2_get_settings(struct net_
 		    | SUPPORTED_1000baseT_Full
 		    | SUPPORTED_Autoneg | SUPPORTED_TP;
 		ecmd->port = PORT_TP;
-	} else
+		ecmd->speed = sky2->speed;
+	} else {
+		ecmd->speed = SPEED_1000;
 		ecmd->port = PORT_FIBRE;
+	}
 
 	ecmd->advertising = sky2->advertising;
 	ecmd->autoneg = sky2->autoneg;
-	ecmd->speed = sky2->speed;
 	ecmd->duplex = sky2->duplex;
 	return 0;
 }
--- linux-2.6.17.11.orig/drivers/net/sky2.h
+++ linux-2.6.17.11/drivers/net/sky2.h
@@ -1318,6 +1318,14 @@ enum {
 };
 
 /* for Yukon-2 Gigabit Ethernet PHY (88E1112 only) */
+/*****  PHY_MARV_PHY_CTRL (page 1)		16 bit r/w	Fiber Specific Ctrl *****/
+enum {
+	PHY_M_FIB_FORCE_LNK	= 1<<10,/* Force Link Good */
+	PHY_M_FIB_SIGD_POL	= 1<<9,	/* SIGDET Polarity */
+	PHY_M_FIB_TX_DIS	= 1<<3,	/* Transmitter Disable */
+};
+
+/* for Yukon-2 Gigabit Ethernet PHY (88E1112 only) */
 /*****  PHY_MARV_PHY_CTRL (page 2)		16 bit r/w	MAC Specific Ctrl *****/
 enum {
 	PHY_M_MAC_MD_MSK	= 7<<7, /* Bit  9.. 7: Mode Select Mask */
@@ -1879,7 +1887,7 @@ struct sky2_hw {
 	int		     pm_cap;
 	u8	     	     chip_id;
 	u8		     chip_rev;
-	u8		     copper;
+	u8		     pmd_type;
 	u8		     ports;
 
 	struct sky2_status_le *st_le;
@@ -1891,6 +1899,11 @@ struct sky2_hw {
 	wait_queue_head_t    msi_wait;
 };
 
+static inline int sky2_is_copper(const struct sky2_hw *hw)
+{
+	return !(hw->pmd_type == 'L' || hw->pmd_type == 'S' || hw->pmd_type == 'P');
+}
+
 /* Register accessor for memory mapped device */
 static inline u32 sky2_read32(const struct sky2_hw *hw, unsigned reg)
 {

--
