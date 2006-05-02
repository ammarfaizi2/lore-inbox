Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWEBVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWEBVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWEBVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:47:55 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39397 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S964995AbWEBVry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:47:54 -0400
Date: Tue, 2 May 2006 23:45:20 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: [PATCH 2/2] ipg: redundancy with mii.h
Message-ID: <20060502214520.GC26357@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a bunch of #define with their counterpart from mii.h

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c |   82 ++++++++++++++++++++++-------------------------------
 drivers/net/ipg.h |   29 -------------------
 2 files changed, 34 insertions(+), 77 deletions(-)

ea93e36c70b16ab91340e320ed96df1df14ea608
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index ea7c1f8..5be2af1 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -15,6 +15,7 @@
  * craig_rich@sundanceti.com
  */
 #include <linux/crc32.h>
+#include <linux/mii.h>
 
 #define IPG_RX_RING_BYTES	(sizeof(struct RFD) * IPG_RFDLIST_LENGTH)
 #define IPG_TX_RING_BYTES	(sizeof(struct TFD) * IPG_TFDLIST_LENGTH)
@@ -465,7 +466,7 @@ static int ipg_tmi_fiber_detect(struct n
 
 	IPG_DEBUG_MSG("_tmi_fiber_detect\n");
 
-	phyid = read_phy_register(dev, phyaddr, GMII_PHY_ID_1);
+	phyid = read_phy_register(dev, phyaddr, MII_PHYSID1);
 
 	IPG_DEBUG_MSG("PHY ID = %x\n", phyid);
 
@@ -492,7 +493,7 @@ static int ipg_find_phyaddr(struct net_d
 		   GMII_PHY_ID1
 		 */
 
-		status = read_phy_register(dev, phyaddr, GMII_PHY_STATUS);
+		status = read_phy_register(dev, phyaddr, MII_BMSR);
 
 		if ((status != 0xFFFF) && (status != 0))
 			return phyaddr;
@@ -600,20 +601,18 @@ #endif
 
 	IPG_DEBUG_MSG("GMII/MII PHY address = %x\n", phyaddr);
 
-	status = read_phy_register(dev, phyaddr, GMII_PHY_STATUS);
+	status = read_phy_register(dev, phyaddr, MII_BMSR);
 
 	printk("PHYStatus = %x \n", status);
-	if ((status & GMII_PHY_STATUS_AUTONEG_ABILITY) == 0) {
+	if ((status & BMSR_ANEGCAPABLE) == 0) {
 		printk(KERN_INFO
 		       "%s: Error PHY unable to perform auto-negotiation.\n",
 		       dev->name);
 		return -EILSEQ;
 	}
 
-	advertisement = read_phy_register(dev, phyaddr,
-					  GMII_PHY_AUTONEGADVERTISEMENT);
-	linkpartner_ability = read_phy_register(dev, phyaddr,
-						GMII_PHY_AUTONEGLINKPARTABILITY);
+	advertisement = read_phy_register(dev, phyaddr, MII_ADVERTISE);
+	linkpartner_ability = read_phy_register(dev, phyaddr, MII_LPA);
 
 	printk("PHYadvertisement=%x LinkPartner=%x \n", advertisement,
 	       linkpartner_ability);
@@ -634,20 +633,16 @@ #endif
 		 * bits are logic 1 in both registers, configure the
 		 * IPG for full duplex operation.
 		 */
-		if ((advertisement & GMII_PHY_ADV_FULL_DUPLEX) ==
-		    (linkpartner_ability & GMII_PHY_ADV_FULL_DUPLEX)) {
+		if ((advertisement & ADVERTISE_1000XFULL) ==
+		    (linkpartner_ability & ADVERTISE_1000XFULL)) {
 			fullduplex = 1;
 
 			/* In 1000BASE-X using IPG's internal PCS
 			 * layer, so write to the GMII duplex bit.
 			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   GMII_PHY_CONTROL,
-					   read_phy_register
-					   (dev, phyaddr,
-					    GMII_PHY_CONTROL) |
-					   GMII_PHY_CONTROL_FULL_DUPLEX);
+			write_phy_register(dev, phyaddr, MII_BMCR,
+				read_phy_register(dev, phyaddr, MII_BMCR) |
+					   ADVERTISE_1000HALF); // Typo ?
 
 		} else {
 			fullduplex = 0;
@@ -655,13 +650,9 @@ #endif
 			/* In 1000BASE-X using IPG's internal PCS
 			 * layer, so write to the GMII duplex bit.
 			 */
-			write_phy_register(dev,
-					   phyaddr,
-					   GMII_PHY_CONTROL,
-					   read_phy_register
-					   (dev, phyaddr,
-					    GMII_PHY_CONTROL) &
-					   ~GMII_PHY_CONTROL_FULL_DUPLEX);
+			write_phy_register(dev, phyaddr, MII_BMCR,
+				read_phy_register(dev, phyaddr, MII_BMCR) &
+					   ~ADVERTISE_1000HALF); // Typo ?
 		}
 	}
 
@@ -672,21 +663,18 @@ #endif
 		 * link partner abilities exchanged via next page
 		 * transfers.
 		 */
-		gigadvertisement = read_phy_register(dev,
-						     phyaddr,
-						     GMII_PHY_1000BASETCONTROL);
-		giglinkpartner_ability = read_phy_register(dev,
-							   phyaddr,
-							   GMII_PHY_1000BASETSTATUS);
+		gigadvertisement =
+			read_phy_register(dev, phyaddr, MII_CTRL1000);
+		giglinkpartner_ability =
+			read_phy_register(dev, phyaddr, MII_STAT1000);
 
 		/* Compare the full duplex bits in the 1000BASE-T GMII
 		 * registers for the local device, and the link partner.
 		 * If these bits are logic 1 in both registers, configure
 		 * the IPG for full duplex operation.
 		 */
-		if ((gigadvertisement & GMII_PHY_1000BASETCONTROL_FULL_DUPLEX)
-		    && (giglinkpartner_ability &
-			GMII_PHY_1000BASETSTATUS_FULL_DUPLEX)) {
+		if ((gigadvertisement & ADVERTISE_1000FULL) &&
+		    (giglinkpartner_ability & ADVERTISE_1000FULL)) {
 			fullduplex = 1;
 		} else {
 			fullduplex = 0;
@@ -751,8 +739,12 @@ #endif
 		/* In full duplex mode, resolve PAUSE
 		 * functionality.
 		 */
-		switch (((advertisement & GMII_PHY_ADV_PAUSE) >> 5) |
-			((linkpartner_ability & GMII_PHY_ADV_PAUSE) >> 7)) {
+		u8 flow_ctl;
+#define LPA_PAUSE_ANY	(LPA_1000XPAUSE_ASYM | LPA_1000XPAUSE)
+
+		flow_ctl  = (advertisement & LPA_PAUSE_ANY) >> 5;
+		flow_ctl |= (linkpartner_ability & LPA_PAUSE_ANY) >> 7;
+		switch (flow_ctl) {
 		case 0x7:
 			txflowcontrol = 1;
 			rxflowcontrol = 0;
@@ -2682,26 +2674,20 @@ static int ipg_hw_init(struct net_device
 
 	if (phyaddr != -1) {
 		u16 mii_phyctrl, mii_1000cr;
-		mii_1000cr = read_phy_register(dev,
-					       phyaddr,
-					       GMII_PHY_1000BASETCONTROL);
-		write_phy_register(dev, phyaddr,
-				   GMII_PHY_1000BASETCONTROL,
-				   mii_1000cr |
-				   GMII_PHY_1000BASETCONTROL_FULL_DUPLEX |
-				   GMII_PHY_1000BASETCONTROL_HALF_DUPLEX |
+		mii_1000cr =
+			read_phy_register(dev, phyaddr, MII_CTRL1000);
+		write_phy_register(dev, phyaddr, MII_CTRL1000,
+			mii_1000cr | ADVERTISE_1000FULL | ADVERTISE_1000HALF |
 				   GMII_PHY_1000BASETCONTROL_PreferMaster);
 
-		mii_phyctrl = read_phy_register(dev, phyaddr, GMII_PHY_CONTROL);
+		mii_phyctrl = read_phy_register(dev, phyaddr, MII_BMCR);
 		/* Set default phyparam */
 		pci_read_config_byte(sp->pdev, PCI_REVISION_ID, &revisionid);
 		ipg_set_phy_default_param(revisionid, dev, phyaddr);
 
 		/* reset Phy */
-		write_phy_register(dev,
-				   phyaddr, GMII_PHY_CONTROL,
-				   (mii_phyctrl | GMII_PHY_CONTROL_RESET |
-				    MII_PHY_CONTROL_RESTARTAN));
+		write_phy_register(dev, phyaddr, MII_BMCR,
+			(mii_phyctrl | BMCR_RESET | BMCR_ANRESTART));
 
 	}
 
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index 03bc6f1..cb51b2b 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
@@ -86,38 +86,9 @@ #define         MII_PHY_TECHABILITY_ASM_
 #define         MII_PHY_TECHABILITY_RSVD2       0x1000
 #define         MII_PHY_STATUS_AUTONEG_ABILITY  0x0008
 
-/* NIC Physical Layer Device GMII register addresses. */
-#define         GMII_PHY_CONTROL                 0x00
-#define         GMII_PHY_STATUS                  0x01
-#define			GMII_PHY_ID_1                    0x02
-#define         GMII_PHY_AUTONEGADVERTISEMENT    0x04
-#define         GMII_PHY_AUTONEGLINKPARTABILITY  0x05
-#define         GMII_PHY_AUTONEGEXPANSION        0x06
-#define         GMII_PHY_AUTONEGNEXTPAGE         0x07
-#define         GMII_PHY_AUTONEGLINKPARTNEXTPAGE 0x08
-#define         GMII_PHY_EXTENDEDSTATUS          0x0F
-
-#define         GMII_PHY_1000BASETCONTROL        0x09
-#define         GMII_PHY_1000BASETSTATUS         0x0A
-
 /* GMII_PHY_1000 need to set to prefer master */
 #define         GMII_PHY_1000BASETCONTROL_PreferMaster 0x0400
 
-#define         GMII_PHY_1000BASETCONTROL_FULL_DUPLEX 0x0200
-#define         GMII_PHY_1000BASETCONTROL_HALF_DUPLEX 0x0100
-#define         GMII_PHY_1000BASETSTATUS_FULL_DUPLEX 0x0800
-#define         GMII_PHY_1000BASETSTATUS_HALF_DUPLEX 0x0400
-
-/* NIC Physical Layer Device GMII register Fields. */
-#define         GMII_PHY_CONTROL_RESET          0x8000
-#define         GMII_PHY_CONTROL_FULL_DUPLEX    0x0100
-#define         GMII_PHY_STATUS_AUTONEG_ABILITY 0x0008
-#define         GMII_PHY_ADV_FULL_DUPLEX        0x0020
-#define         GMII_PHY_ADV_HALF_DUPLEX        0x0040
-#define         GMII_PHY_ADV_PAUSE              0x0180
-#define         GMII_PHY_ADV_PAUSE_PS1          0x0080
-#define         GMII_PHY_ADV_ASM_DIR_PS2        0x0100
-
 /* NIC Physical Layer Device GMII constants. */
 #define         GMII_PREAMBLE                    0xFFFFFFFF
 #define         GMII_ST                          0x1
-- 
1.3.1

