Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUH2VGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUH2VGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUH2VGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:06:24 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:29962 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268305AbUH2VEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:04:35 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
Date: Sun, 29 Aug 2004 23:04:24 +0200
User-Agent: KMail/1.7
Cc: Pekka Pietikainen <pp@ee.oulu.fi>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org> <41324158.4020709@pobox.com>
In-Reply-To: <41324158.4020709@pobox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZTkMBiulVZrCu7i"
Message-Id: <200408292304.25447.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZTkMBiulVZrCu7i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
 
> Your mailer is mangling the patches.  Can you please resend without this?
> The patches need to be apply-able without MIME massaging.
 
Sorry for that. KMail seems to mangle the message as soon as you sign it. Please find the non broken versions attached to this mail.

Sorry,
  Florian



--Boundary-00=_ZTkMBiulVZrCu7i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44-1-broken-carrier-lost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44-1-broken-carrier-lost.patch"

--- linux/drivers/net/b44.c-old1	2004-08-29 16:29:08.000000000 +0200
+++ linux/drivers/net/b44.c	2004-08-29 16:27:00.000000000 +0200
@@ -1347,7 +1347,10 @@ static struct net_device_stats *b44_get_
 				   hwstat->rx_symbol_errs);
 
 	nstat->tx_aborted_errors = hwstat->tx_underruns;
+#if 0
+	/* Carrier lost counter seems to be broken for some devices */
 	nstat->tx_carrier_errors = hwstat->tx_carrier_lost;
+#endif
 
 	return nstat;
 }

--Boundary-00=_ZTkMBiulVZrCu7i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44-2-remove-dead-ssb-crap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44-2-remove-dead-ssb-crap.patch"

--- linux/drivers/net/b44.c-old2	2004-08-29 16:27:00.000000000 +0200
+++ linux/drivers/net/b44.c	2004-08-29 16:59:24.000000000 +0200
@@ -130,41 +130,8 @@ static int b44_wait_bit(struct b44 *bp, 
  * interrupts disabled.
  */
 
-#define SBID_SDRAM		0
-#define SBID_PCI_MEM		1
-#define SBID_PCI_CFG		2
-#define SBID_PCI_DMA		3
-#define	SBID_SDRAM_SWAPPED	4
-#define SBID_ENUM		5
-#define SBID_REG_SDRAM		6
-#define SBID_REG_ILINE20	7
-#define SBID_REG_EMAC		8
-#define SBID_REG_CODEC		9
-#define SBID_REG_USB		10
-#define SBID_REG_PCI		11
-#define SBID_REG_MIPS		12
-#define SBID_REG_EXTIF		13
-#define	SBID_EXTIF		14
-#define	SBID_EJTAG		15
-#define	SBID_MAX		16
-
-static u32 ssb_get_addr(struct b44 *bp, u32 id, u32 instance)
-{
-	switch (id) {
-	case SBID_PCI_DMA:
-		return 0x40000000;
-	case SBID_ENUM:
-		return 0x18000000;
-	case SBID_REG_EMAC:
-		return 0x18000000;
-	case SBID_REG_CODEC:
-		return 0x18001000;
-	case SBID_REG_PCI:
-		return 0x18002000;
-	default:
-		return 0;
-	};
-}
+#define SB_PCI_DMA             0x40000000      /* Client Mode PCI memory access space (1 GB) */
+#define BCM4400_PCI_CORE_ADDR  0x18002000      /* Address of PCI core on BCM4400 cards */
 
 static u32 ssb_get_core_rev(struct b44 *bp)
 {
@@ -176,8 +143,7 @@ static u32 ssb_pci_setup(struct b44 *bp,
 	u32 bar_orig, pci_rev, val;
 
 	pci_read_config_dword(bp->pdev, SSB_BAR0_WIN, &bar_orig);
-	pci_write_config_dword(bp->pdev, SSB_BAR0_WIN,
-			       ssb_get_addr(bp, SBID_REG_PCI, 0));
+	pci_write_config_dword(bp->pdev, SSB_BAR0_WIN, BCM4400_PCI_CORE_ADDR);
 	pci_rev = ssb_get_core_rev(bp);
 
 	val = br32(B44_SBINTVEC);
@@ -1676,7 +1642,6 @@ static int __devinit b44_get_invariants(
 	bp->dev->dev_addr[5] = eeprom[82];
 
 	bp->phy_addr = eeprom[90] & 0x1f;
-	bp->mdc_port = (eeprom[90] >> 14) & 0x1;
 
 	/* With this, plus the rx_header prepended to the data by the
 	 * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -1686,7 +1651,7 @@ static int __devinit b44_get_invariants(
 	bp->imask = IMASK_DEF;
 
 	bp->core_unit = ssb_core_unit(bp);
-	bp->dma_offset = ssb_get_addr(bp, SBID_PCI_DMA, 0);
+	bp->dma_offset = SB_PCI_DMA;
 
 	/* XXX - really required? 
 	   bp->flags |= B44_FLAG_BUGGY_TXPTR;
--- linux/drivers/net/b44.h-old2	2004-08-29 16:25:36.000000000 +0200
+++ linux/drivers/net/b44.h	2004-08-29 17:06:44.000000000 +0200
@@ -223,21 +223,8 @@
 #define B44_RX_SYM	0x05D0UL /* MIB RX Symbol Errors */
 #define B44_RX_PAUSE	0x05D4UL /* MIB RX Pause Packets */
 #define B44_RX_NPAUSE	0x05D8UL /* MIB RX Non-Pause Packets */
-#define B44_SBIPSFLAG	0x0F08UL /* SB Initiator Port OCP Slave Flag */
-#define  SBIPSFLAG_IMASK1	0x0000003f /* Which sbflags --> mips interrupt 1 */
-#define  SBIPSFLAG_ISHIFT1	0
-#define  SBIPSFLAG_IMASK2	0x00003f00 /* Which sbflags --> mips interrupt 2 */
-#define  SBIPSFLAG_ISHIFT2	8
-#define  SBIPSFLAG_IMASK3	0x003f0000 /* Which sbflags --> mips interrupt 3 */
-#define  SBIPSFLAG_ISHIFT3	16
-#define  SBIPSFLAG_IMASK4	0x3f000000 /* Which sbflags --> mips interrupt 4 */
-#define  SBIPSFLAG_ISHIFT4	24
-#define B44_SBTPSFLAG	0x0F18UL /* SB Target Port OCP Slave Flag */
-#define  SBTPS_NUM0_MASK	0x0000003f
-#define  SBTPS_F0EN0		0x00000040
-#define B44_SBADMATCH3	0x0F60UL /* SB Address Match 3 */
-#define B44_SBADMATCH2	0x0F68UL /* SB Address Match 2 */
-#define B44_SBADMATCH1	0x0F70UL /* SB Address Match 1 */
+
+/* Silicon backplane register definitions */
 #define B44_SBIMSTATE	0x0F90UL /* SB Initiator Agent State */
 #define  SBIMSTATE_PC		0x0000000f /* Pipe Count */
 #define  SBIMSTATE_AP_MASK	0x00000030 /* Arbitration Priority */
@@ -269,86 +256,6 @@
 #define  SBTMSHIGH_GCR		0x20000000 /* Gated Clock Request */
 #define  SBTMSHIGH_BISTF	0x40000000 /* BIST Failed */
 #define  SBTMSHIGH_BISTD	0x80000000 /* BIST Done */
-#define B44_SBBWA0	0x0FA0UL /* SB Bandwidth Allocation Table 0 */
-#define  SBBWA0_TAB0_MASK	0x0000ffff /* Lookup Table 0 */
-#define  SBBWA0_TAB0_SHIFT	0
-#define  SBBWA0_TAB1_MASK	0xffff0000 /* Lookup Table 0 */
-#define  SBBWA0_TAB1_SHIFT	16
-#define B44_SBIMCFGLOW	0x0FA8UL /* SB Initiator Configuration Low */
-#define  SBIMCFGLOW_STO_MASK	0x00000003 /* Service Timeout */
-#define  SBIMCFGLOW_RTO_MASK	0x00000030 /* Request Timeout */
-#define  SBIMCFGLOW_RTO_SHIFT	4
-#define  SBIMCFGLOW_CID_MASK	0x00ff0000 /* Connection ID */
-#define  SBIMCFGLOW_CID_SHIFT	16
-#define B44_SBIMCFGHIGH	0x0FACUL /* SB Initiator Configuration High */
-#define  SBIMCFGHIGH_IEM_MASK	0x0000000c /* Inband Error Mode */
-#define  SBIMCFGHIGH_TEM_MASK	0x00000030 /* Timeout Error Mode */
-#define  SBIMCFGHIGH_TEM_SHIFT	4
-#define  SBIMCFGHIGH_BEM_MASK	0x000000c0 /* Bus Error Mode */
-#define  SBIMCFGHIGH_BEM_SHIFT	6
-#define B44_SBADMATCH0	0x0FB0UL /* SB Address Match 0 */
-#define  SBADMATCH0_TYPE_MASK	0x00000003 /* Address Type */
-#define  SBADMATCH0_AD64	0x00000004 /* Reserved */
-#define  SBADMATCH0_AI0_MASK	0x000000f8 /* Type0 Size */
-#define  SBADMATCH0_AI0_SHIFT	3
-#define  SBADMATCH0_AI1_MASK	0x000001f8 /* Type1 Size */
-#define  SBADMATCH0_AI1_SHIFT	3
-#define  SBADMATCH0_AI2_MASK	0x000001f8 /* Type2 Size */
-#define  SBADMATCH0_AI2_SHIFT	3
-#define  SBADMATCH0_ADEN	0x00000400 /* Enable */
-#define  SBADMATCH0_ADNEG	0x00000800 /* Negative Decode */
-#define  SBADMATCH0_BS0_MASK	0xffffff00 /* Type0 Base Address */
-#define  SBADMATCH0_BS0_SHIFT	8
-#define  SBADMATCH0_BS1_MASK	0xfffff000 /* Type1 Base Address */
-#define  SBADMATCH0_BS1_SHIFT	12
-#define  SBADMATCH0_BS2_MASK	0xffff0000 /* Type2 Base Address */
-#define  SBADMATCH0_BS2_SHIFT	16
-#define B44_SBTMCFGLOW	0x0FB8UL /* SB Target Configuration Low */
-#define  SBTMCFGLOW_CD_MASK	0x000000ff /* Clock Divide Mask */
-#define  SBTMCFGLOW_CO_MASK	0x0000f800 /* Clock Offset Mask */
-#define  SBTMCFGLOW_CO_SHIFT	11
-#define  SBTMCFGLOW_IF_MASK	0x00fc0000 /* Interrupt Flags Mask */
-#define  SBTMCFGLOW_IF_SHIFT	18
-#define  SBTMCFGLOW_IM_MASK	0x03000000 /* Interrupt Mode Mask */
-#define  SBTMCFGLOW_IM_SHIFT	24
-#define B44_SBTMCFGHIGH	0x0FBCUL /* SB Target Configuration High */
-#define  SBTMCFGHIGH_BM_MASK	0x00000003 /* Busy Mode */
-#define  SBTMCFGHIGH_RM_MASK	0x0000000C /* Retry Mode */
-#define  SBTMCFGHIGH_RM_SHIFT	2
-#define  SBTMCFGHIGH_SM_MASK	0x00000030 /* Stop Mode */
-#define  SBTMCFGHIGH_SM_SHIFT	4
-#define  SBTMCFGHIGH_EM_MASK	0x00000300 /* Error Mode */
-#define  SBTMCFGHIGH_EM_SHIFT	8
-#define  SBTMCFGHIGH_IM_MASK	0x00000c00 /* Interrupt Mode */
-#define  SBTMCFGHIGH_IM_SHIFT	10
-#define B44_SBBCFG	0x0FC0UL /* SB Broadcast Configuration */
-#define  SBBCFG_LAT_MASK	0x00000003 /* SB Latency */
-#define  SBBCFG_MAX0_MASK	0x000f0000 /* MAX Counter 0 */
-#define  SBBCFG_MAX0_SHIFT	16
-#define  SBBCFG_MAX1_MASK	0x00f00000 /* MAX Counter 1 */
-#define  SBBCFG_MAX1_SHIFT	20
-#define B44_SBBSTATE	0x0FC8UL /* SB Broadcast State */
-#define  SBBSTATE_SRD		0x00000001 /* ST Reg Disable */
-#define  SBBSTATE_HRD		0x00000002 /* Hold Reg Disable */
-#define B44_SBACTCNFG	0x0FD8UL /* SB Activate Configuration */
-#define B44_SBFLAGST	0x0FE8UL /* SB Current SBFLAGS */
-#define B44_SBIDLOW	0x0FF8UL /* SB Identification Low */
-#define  SBIDLOW_CS_MASK	0x00000003 /* Config Space Mask */
-#define  SBIDLOW_AR_MASK	0x00000038 /* Num Address Ranges Supported */
-#define  SBIDLOW_AR_SHIFT	3
-#define  SBIDLOW_SYNCH		0x00000040 /* Sync */
-#define  SBIDLOW_INIT		0x00000080 /* Initiator */
-#define  SBIDLOW_MINLAT_MASK	0x00000f00 /* Minimum Backplane Latency */
-#define  SBIDLOW_MINLAT_SHIFT	8
-#define  SBIDLOW_MAXLAT_MASK	0x0000f000 /* Maximum Backplane Latency */
-#define  SBIDLOW_MAXLAT_SHIFT	12
-#define  SBIDLOW_FIRST		0x00010000 /* This Initiator is First */
-#define  SBIDLOW_CW_MASK	0x000c0000 /* Cycle Counter Width */
-#define  SBIDLOW_CW_SHIFT	18
-#define  SBIDLOW_TP_MASK	0x00f00000 /* Target Ports */
-#define  SBIDLOW_TP_SHIFT	20
-#define  SBIDLOW_IP_MASK	0x0f000000 /* Initiator Ports */
-#define  SBIDLOW_IP_SHIFT	24
 #define B44_SBIDHIGH	0x0FFCUL /* SB Identification High */
 #define  SBIDHIGH_RC_MASK	0x0000000f /* Revision Code */
 #define  SBIDHIGH_CC_MASK	0x0000fff0 /* Core Code */
@@ -356,23 +263,13 @@
 #define  SBIDHIGH_VC_MASK	0xffff0000 /* Vendor Code */
 #define  SBIDHIGH_VC_SHIFT	16
 
-#define  CORE_CODE_ILINE20	0x801
-#define  CORE_CODE_SDRAM	0x803
-#define  CORE_CODE_PCI		0x804
-#define  CORE_CODE_MIPS		0x805
-#define  CORE_CODE_ENET		0x806
-#define  CORE_CODE_CODEC	0x807
-#define  CORE_CODE_USB		0x808
-#define  CORE_CODE_ILINE100	0x80a
-#define  CORE_CODE_EXTIF	0x811
-
 /* SSB PCI config space registers.  */
 #define	SSB_BAR0_WIN		0x80
 #define	SSB_BAR1_WIN		0x84
 #define	SSB_SPROM_CONTROL	0x88
 #define	SSB_BAR1_CONTROL	0x8c
 
-/* SSB core and hsot control registers.  */
+/* SSB core and host control registers.  */
 #define SSB_CONTROL		0x0000UL
 #define SSB_ARBCONTROL		0x0010UL
 #define SSB_ISTAT		0x0020UL
@@ -540,7 +437,6 @@ struct b44 {
 	u32			tx_pending;
 	u32			pci_cfg_state[64 / sizeof(u32)];
 	u8			phy_addr;
-	u8			mdc_port;
 	u8			core_unit;
 
 	struct mii_if_info	mii_if;

--Boundary-00=_ZTkMBiulVZrCu7i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44-3-phy-less-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44-3-phy-less-mode.patch"

--- linux/drivers/net/b44.c-old3	2004-08-29 16:59:24.000000000 +0200
+++ linux/drivers/net/b44.c	2004-08-29 17:24:23.000000000 +0200
@@ -273,6 +273,9 @@ static int b44_readphy(struct b44 *bp, i
 {
 	int err;
 
+	if (bp->phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+
 	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_READ << MDIO_DATA_OP_SHIFT) |
@@ -287,6 +290,9 @@ static int b44_readphy(struct b44 *bp, i
 
 static int b44_writephy(struct b44 *bp, int reg, u32 val)
 {
+	if (bp->phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+
 	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_WRITE << MDIO_DATA_OP_SHIFT) |
@@ -325,6 +331,9 @@ static int b44_phy_reset(struct b44 *bp)
 	u32 val;
 	int err;
 
+	if (bp->phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+
 	err = b44_writephy(bp, MII_BMCR, BMCR_RESET);
 	if (err)
 		return err;
@@ -395,6 +404,9 @@ static int b44_setup_phy(struct b44 *bp)
 	u32 val;
 	int err;
 
+	if (bp->phy_addr == B44_PHY_ADDR_NO_PHY)
+		return 0;
+
 	if ((err = b44_readphy(bp, B44_MII_ALEDCTRL, &val)) != 0)
 		goto out;
 	if ((err = b44_writephy(bp, B44_MII_ALEDCTRL,
@@ -487,6 +499,19 @@ static void b44_check_phy(struct b44 *bp
 {
 	u32 bmsr, aux;
 
+	if (bp->phy_addr == B44_PHY_ADDR_NO_PHY) {
+		bp->flags |= B44_FLAG_100_BASE_T;
+		bp->flags |= B44_FLAG_FULL_DUPLEX;
+		if (!netif_carrier_ok(bp->dev)) {
+			u32 val = br32(B44_TX_CTRL);
+			val |= TX_CTRL_DUPLEX;
+			bw32(B44_TX_CTRL, val);
+			netif_carrier_on(bp->dev);
+			b44_link_report(bp);
+		}
+		return;
+	}
+
 	if (!b44_readphy(bp, MII_BMSR, &bmsr) &&
 	    !b44_readphy(bp, B44_MII_AUXCTRL, &aux) &&
 	    (bmsr != 0xffff)) {
--- linux/drivers/net/b44.h-old3	2004-08-29 17:06:44.000000000 +0200
+++ linux/drivers/net/b44.h	2004-08-29 17:24:53.000000000 +0200
@@ -362,6 +362,7 @@ struct ring_info {
 };
 
 #define B44_MCAST_TABLE_SIZE	32
+#define B44_PHY_ADDR_NO_PHY	30
 
 /* SW copy of device statistics, kept up to date by periodic timer
  * which probes HW values.  Must have same relative layout as HW

--Boundary-00=_ZTkMBiulVZrCu7i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44-4-bcm47xx-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44-4-bcm47xx-support.patch"

--- linux/drivers/net/b44.c-old4	2004-08-29 17:24:23.000000000 +0200
+++ linux/drivers/net/b44.c	2004-08-29 18:48:45.000000000 +0200
@@ -1,7 +1,8 @@
-/* b44.c: Broadcom 4400 device driver.
+/* b44.c: Broadcom 4400/47xx device driver.
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
- * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
+ * Copyright (C) 2004 Pekka Pietikainen (pp@ee.oulu.fi)
+ * Copyright (C) 2004 Florian Schirmer (jolt@tuxbox.org)
  *
  * Distribute under GPL.
  */
@@ -75,7 +76,7 @@ static char version[] __devinitdata =
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
-MODULE_DESCRIPTION("Broadcom 4400 10/100 PCI ethernet driver");
+MODULE_DESCRIPTION("Broadcom 4400/47xx 10/100 PCI ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM(b44_debug, "i");
 MODULE_PARM_DESC(b44_debug, "B44 bitmapped debugging message enable value");
@@ -89,6 +90,8 @@ static struct pci_device_id b44_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4713,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
 };
 
@@ -202,29 +205,14 @@ static void ssb_core_reset(struct b44 *b
 	udelay(1);
 }
 
+static int b44_4713_instance;
+
 static int ssb_core_unit(struct b44 *bp)
 {
-#if 0
-	u32 val = br32(B44_SBADMATCH0);
-	u32 base;
-
-	type = val & SBADMATCH0_TYPE_MASK;
-	switch (type) {
-	case 0:
-		base = val & SBADMATCH0_BS0_MASK;
-		break;
-
-	case 1:
-		base = val & SBADMATCH0_BS1_MASK;
-		break;
-
-	case 2:
-	default:
-		base = val & SBADMATCH0_BS2_MASK;
-		break;
-	};
-#endif
-	return 0;
+	if (bp->pdev->device == PCI_DEVICE_ID_BCM4713)
+		return b44_4713_instance++;
+	else
+		return 0;
 }
 
 static int ssb_is_core_up(struct b44 *bp)
@@ -233,6 +221,28 @@ static int ssb_is_core_up(struct b44 *bp
 		== SBTMSLOW_CLOCK);
 }
 
+static void __b44_cam_read(struct b44 *bp, unsigned char *data, int index)
+{
+	u32 val;
+
+	bw32(B44_CAM_CTRL, (CAM_CTRL_READ |
+			    (index << CAM_CTRL_INDEX_SHIFT)));
+
+	b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);	
+
+	val = br32(B44_CAM_DATA_LO);
+
+	data[2] = (val >> 24) & 0xFF;
+	data[3] = (val >> 16) & 0xFF;
+	data[4] = (val >> 8) & 0xFF;
+	data[5] = (val >> 0) & 0xFF;
+
+	val = br32(B44_CAM_DATA_HI);
+	
+	data[0] = (val >> 8) & 0xFF;
+	data[1] = (val >> 0) & 0xFF;
+}
+
 static void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
 {
 	u32 val;
@@ -1110,6 +1120,8 @@ static void b44_clear_stats(struct b44 *
 /* bp->lock is held. */
 static void b44_chip_reset(struct b44 *bp)
 {
+	unsigned int sb_clock;
+
 	if (ssb_is_core_up(bp)) {
 		bw32(B44_RCV_LAZY, 0);
 		bw32(B44_ENET_CTRL, ENET_CTRL_DISABLE);
@@ -1123,9 +1135,10 @@ static void b44_chip_reset(struct b44 *b
 		bw32(B44_DMARX_CTRL, 0);
 		bp->rx_prod = bp->rx_cons = 0;
 	} else {
-		ssb_pci_setup(bp, (bp->core_unit == 0 ?
-				   SBINTVEC_ENET0 :
-				   SBINTVEC_ENET1));
+		if (bp->pdev->device != PCI_DEVICE_ID_BCM4713)
+			ssb_pci_setup(bp, (bp->core_unit == 0 ?
+					   SBINTVEC_ENET0 :
+					   SBINTVEC_ENET1));
 	}
 
 	ssb_core_reset(bp);
@@ -1133,8 +1146,14 @@ static void b44_chip_reset(struct b44 *b
 	b44_clear_stats(bp);
 
 	/* Make PHY accessible. */
+	if (bp->pdev->device == PCI_DEVICE_ID_BCM4713)
+		sb_clock = 100000000; /* 100 MHz */
+	else
+		sb_clock = 62500000; /* 62.5 MHz */
+
 	bw32(B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
-			     (0x0d & MDIO_CTRL_MAXF_MASK)));
+			     (((sb_clock + (B44_MDC_RATIO / 2)) / B44_MDC_RATIO)
+			     & MDIO_CTRL_MAXF_MASK)));
 	br32(B44_MDIO_CTRL);
 
 	if (!(br32(B44_DEVCTRL) & DEVCTRL_IPP)) {
@@ -1654,19 +1673,41 @@ static int __devinit b44_get_invariants(
 {
 	u8 eeprom[128];
 	int err;
+	unsigned long flags;
 
-	err = b44_read_eeprom(bp, &eeprom[0]);
-	if (err)
-		goto out;
-
-	bp->dev->dev_addr[0] = eeprom[79];
-	bp->dev->dev_addr[1] = eeprom[78];
-	bp->dev->dev_addr[2] = eeprom[81];
-	bp->dev->dev_addr[3] = eeprom[80];
-	bp->dev->dev_addr[4] = eeprom[83];
-	bp->dev->dev_addr[5] = eeprom[82];
-
-	bp->phy_addr = eeprom[90] & 0x1f;
+	if (bp->pdev->device == PCI_DEVICE_ID_BCM4713) {
+		/* 
+		 * BCM47xx boards don't have a EEPROM. The MAC is stored in
+		 * a NVRAM area somewhere in the flash memory. As we don't
+		 * know the location and/or the format of the NVRAM area
+		 * here, we simply rely on the bootloader to write the
+		 * MAC into the CAM.
+		 */
+		spin_lock_irqsave(&bp->lock, flags);
+		__b44_cam_read(bp, bp->dev->dev_addr, 0);
+		spin_unlock_irqrestore(&bp->lock, flags);
+
+		/* 
+		 * BCM47xx boards don't have a PHY. Usually there is a switch
+		 * chip with multiple PHYs connected to the PHY port.
+		 */
+		bp->phy_addr = B44_PHY_ADDR_NO_PHY;
+		bp->dma_offset = 0;
+	} else {
+		err = b44_read_eeprom(bp, &eeprom[0]);
+		if (err)
+			return err;
+
+		bp->dev->dev_addr[0] = eeprom[79];
+		bp->dev->dev_addr[1] = eeprom[78];
+		bp->dev->dev_addr[2] = eeprom[81];
+		bp->dev->dev_addr[3] = eeprom[80];
+		bp->dev->dev_addr[4] = eeprom[83];
+		bp->dev->dev_addr[5] = eeprom[82];
+
+		bp->phy_addr = eeprom[90] & 0x1f;
+		bp->dma_offset = SB_PCI_DMA;
+	} 
 
 	/* With this, plus the rx_header prepended to the data by the
 	 * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -1676,13 +1717,12 @@ static int __devinit b44_get_invariants(
 	bp->imask = IMASK_DEF;
 
 	bp->core_unit = ssb_core_unit(bp);
-	bp->dma_offset = SB_PCI_DMA;
 
 	/* XXX - really required? 
 	   bp->flags |= B44_FLAG_BUGGY_TXPTR;
          */
-out:
-	return err;
+
+	return 0;
 }
 
 static int __devinit b44_init_one(struct pci_dev *pdev,
@@ -1811,7 +1851,8 @@ static int __devinit b44_init_one(struct
 
 	pci_save_state(bp->pdev, bp->pci_cfg_state);
 
-	printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev->name);
+	printk(KERN_INFO "%s: Broadcom %s 10/100BaseT Ethernet ", dev->name,
+		(pdev->device == PCI_DEVICE_ID_BCM4713) ? "47xx" : "4400");
 	for (i = 0; i < 6; i++)
 		printk("%2.2x%c", dev->dev_addr[i],
 		       i == 5 ? '\n' : ':');
--- linux/drivers/net/b44.h-old4	2004-08-29 17:24:53.000000000 +0200
+++ linux/drivers/net/b44.h	2004-08-29 18:42:56.000000000 +0200
@@ -363,6 +363,7 @@ struct ring_info {
 
 #define B44_MCAST_TABLE_SIZE	32
 #define B44_PHY_ADDR_NO_PHY	30
+#define B44_MDC_RATIO		5000000
 
 /* SW copy of device statistics, kept up to date by periodic timer
  * which probes HW values.  Must have same relative layout as HW

--Boundary-00=_ZTkMBiulVZrCu7i--
