Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUGWVhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUGWVhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUGWVhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:37:02 -0400
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:17933 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S268086AbUGWVfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:35:46 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: jgarzik@pobox.com
Subject: b44: add 47xx support
Date: Fri, 23 Jul 2004 23:35:30 +0200
User-Agent: KMail/1.6.1
Cc: pp@ee.oulu.fi, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iSYAB8dJI0zLw5S"
Message-Id: <200407232335.37809.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iSYAB8dJI0zLw5S
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

this patch adds support for the BCM47xx device to the b44 driver. Please=20
apply.

BTW what happened to the 1GB DMA fix? The SiliconBackplane cores _are_ limi=
ted=20
to a 1GB DMA window so we need to take that into account. Any reason why=20
those patches where dropped?

Regards,
  Florian

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAYSlXRF2vHoIlBsRAu+YAKCGzT01hW+yW5SMCbFGOCqx89uIxwCguwZT
zeDLpFVyILUSnaYNJe2A4YU=3D
=3D6269
=2D----END PGP SIGNATURE-----

--Boundary-00=_iSYAB8dJI0zLw5S
Content-Type: text/x-diff;
  charset="us-ascii";
  name="b44-47xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44-47xx.patch"

Index: include/linux/pci_ids.h
===================================================================
RCS file: /home/cvs/linux/include/linux/pci_ids.h,v
retrieving revision 1.124
diff -a -u -p -r1.124 pci_ids.h
--- mips/include/linux/pci_ids.h	20 Jul 2004 20:21:26 -0000	1.124
+++ mips/include/linux/pci_ids.h	23 Jul 2004 21:10:45 -0000
@@ -1913,6 +1913,7 @@
 #define PCI_DEVICE_ID_BCM4401		0x4401
 #define PCI_DEVICE_ID_BCM4401B0		0x4402
 #define PCI_DEVICE_ID_BCM4401B1		0x170c
+#define PCI_DEVICE_ID_BCM4713		0x4713
 
 #define PCI_VENDOR_ID_ENE		0x1524
 #define PCI_DEVICE_ID_ENE_1211		0x1211
Index: drivers/net/b44.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/b44.c,v
retrieving revision 1.14
diff -a -u -p -r1.14 b44.c
--- mips/drivers/net/b44.c	9 Jun 2004 14:12:09 -0000	1.14
+++ mips/drivers/net/b44.c	23 Jul 2004 21:10:47 -0000
@@ -75,7 +75,7 @@ static char version[] __devinitdata =
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
-MODULE_DESCRIPTION("Broadcom 4400 10/100 PCI ethernet driver");
+MODULE_DESCRIPTION("Broadcom 4400/47xx 10/100 PCI ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM(b44_debug, "i");
 MODULE_PARM_DESC(b44_debug, "B44 bitmapped debugging message enable value");
@@ -89,6 +89,8 @@ static struct pci_device_id b44_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4713,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
 };
 
@@ -130,41 +132,8 @@ static int b44_wait_bit(struct b44 *bp, 
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
+#define SB_PCI_DMA		0x40000000	/* Client Mode PCI memory access space (1 GB) */
+#define BCM4400_PCI_CORE_ADDR	0x18002000	/* Address of PCI core on BCM4400 cards */
 
 static u32 ssb_get_core_rev(struct b44 *bp)
 {
@@ -176,8 +145,7 @@ static u32 ssb_pci_setup(struct b44 *bp,
 	u32 bar_orig, pci_rev, val;
 
 	pci_read_config_dword(bp->pdev, SSB_BAR0_WIN, &bar_orig);
-	pci_write_config_dword(bp->pdev, SSB_BAR0_WIN,
-			       ssb_get_addr(bp, SBID_REG_PCI, 0));
+	pci_write_config_dword(bp->pdev, SSB_BAR0_WIN, BCM4400_PCI_CORE_ADDR);
 	pci_rev = ssb_get_core_rev(bp);
 
 	val = br32(B44_SBINTVEC);
@@ -307,6 +275,9 @@ static int b44_readphy(struct b44 *bp, i
 {
 	int err;
 
+	if (bp->flags & B44_FLAG_NO_PHY)
+		return 0;
+
 	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_READ << MDIO_DATA_OP_SHIFT) |
@@ -321,6 +292,9 @@ static int b44_readphy(struct b44 *bp, i
 
 static int b44_writephy(struct b44 *bp, int reg, u32 val)
 {
+	if (bp->flags & B44_FLAG_NO_PHY)
+		return 0;
+
 	bw32(B44_EMAC_ISTAT, EMAC_INT_MII);
 	bw32(B44_MDIO_DATA, (MDIO_DATA_SB_START |
 			     (MDIO_OP_WRITE << MDIO_DATA_OP_SHIFT) |
@@ -359,6 +333,9 @@ static int b44_phy_reset(struct b44 *bp)
 	u32 val;
 	int err;
 
+	if (bp->flags & B44_FLAG_NO_PHY)
+		return 0;
+
 	err = b44_writephy(bp, MII_BMCR, BMCR_RESET);
 	if (err)
 		return err;
@@ -429,6 +406,9 @@ static int b44_setup_phy(struct b44 *bp)
 	u32 val;
 	int err;
 
+	if (bp->flags & B44_FLAG_NO_PHY)
+		return 0;
+
 	if ((err = b44_readphy(bp, B44_MII_ALEDCTRL, &val)) != 0)
 		goto out;
 	if ((err = b44_writephy(bp, B44_MII_ALEDCTRL,
@@ -521,6 +501,19 @@ static void b44_check_phy(struct b44 *bp
 {
 	u32 bmsr, aux;
 
+	if (bp->flags & B44_FLAG_NO_PHY) {
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
@@ -1132,18 +1125,28 @@ static void b44_chip_reset(struct b44 *b
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
 
 	b44_clear_stats(bp);
 
-	/* Make PHY accessible. */
-	bw32(B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
-			     (0x0d & MDIO_CTRL_MAXF_MASK)));
+	if (bp->pdev->device == PCI_DEVICE_ID_BCM4713) {
+		/* 
+		 * BCM47xx boards don't have a PHY. Usually there is a switch
+		 * chip with multiple PHYs conntected to the PHY port.
+		 */
+		bp->flags |= B44_FLAG_NO_PHY;
+		bw32(B44_MDIO_CTRL, 0x94);
+	} else {
+		/* Make PHY accessible. */
+		bw32(B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
+				     (0x0d & MDIO_CTRL_MAXF_MASK)));
+	}
 	br32(B44_MDIO_CTRL);
 
 	if (!(br32(B44_DEVCTRL) & DEVCTRL_IPP)) {
@@ -1659,21 +1662,38 @@ static int b44_read_eeprom(struct b44 *b
 static int __devinit b44_get_invariants(struct b44 *bp)
 {
 	u8 eeprom[128];
-	int err;
+	int err = 0;
+	static int instance = 0;
 
-	err = b44_read_eeprom(bp, &eeprom[0]);
-	if (err)
-		goto out;
+	if (bp->pdev->device == PCI_DEVICE_ID_BCM4713) {
+		bp->dev->dev_addr[0] = 0x01;
+		bp->dev->dev_addr[1] = 0x01;
+		bp->dev->dev_addr[2] = 0x02;
+		bp->dev->dev_addr[3] = 0x02;
+		bp->dev->dev_addr[4] = 0x01;
+		bp->dev->dev_addr[5] = 0x01 + instance;
+
+		bp->phy_addr = 30;
+		bp->mdc_port = instance++;
+		
+		bp->dma_offset = 0;
+	} else {
+		err = b44_read_eeprom(bp, &eeprom[0]);
+		if (err)
+			goto out;
 
-	bp->dev->dev_addr[0] = eeprom[79];
-	bp->dev->dev_addr[1] = eeprom[78];
-	bp->dev->dev_addr[2] = eeprom[81];
-	bp->dev->dev_addr[3] = eeprom[80];
-	bp->dev->dev_addr[4] = eeprom[83];
-	bp->dev->dev_addr[5] = eeprom[82];
+		bp->dev->dev_addr[0] = eeprom[79];
+		bp->dev->dev_addr[1] = eeprom[78];
+		bp->dev->dev_addr[2] = eeprom[81];
+		bp->dev->dev_addr[3] = eeprom[80];
+		bp->dev->dev_addr[4] = eeprom[83];
+		bp->dev->dev_addr[5] = eeprom[82];
 
-	bp->phy_addr = eeprom[90] & 0x1f;
-	bp->mdc_port = (eeprom[90] >> 14) & 0x1;
+		bp->phy_addr = eeprom[90] & 0x1f;
+		bp->mdc_port = (eeprom[90] >> 14) & 0x1;
+		
+		bp->dma_offset = SB_PCI_DMA;
+	}
 
 	/* With this, plus the rx_header prepended to the data by the
 	 * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -1683,7 +1703,6 @@ static int __devinit b44_get_invariants(
 	bp->imask = IMASK_DEF;
 
 	bp->core_unit = ssb_core_unit(bp);
-	bp->dma_offset = ssb_get_addr(bp, SBID_PCI_DMA, 0);
 
 	/* XXX - really required? 
 	   bp->flags |= B44_FLAG_BUGGY_TXPTR;
@@ -1818,7 +1837,8 @@ static int __devinit b44_init_one(struct
 
 	pci_save_state(bp->pdev, bp->pci_cfg_state);
 
-	printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev->name);
+	printk(KERN_INFO "%s: Broadcom %s 10/100BaseT Ethernet ", dev->name,
+		(pdev->device == PCI_DEVICE_ID_BCM4713) ? "47xx" : "4400");
 	for (i = 0; i < 6; i++)
 		printk("%2.2x%c", dev->dev_addr[i],
 		       i == 5 ? '\n' : ':');
Index: drivers/net/b44.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/b44.h,v
retrieving revision 1.5
diff -a -u -p -r1.5 b44.h
--- mips/drivers/net/b44.h	6 Jun 2004 02:12:45 -0000	1.5
+++ mips/drivers/net/b44.h	23 Jul 2004 21:10:51 -0000
@@ -356,16 +356,6 @@
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
@@ -520,6 +510,7 @@ struct b44 {
 #define B44_FLAG_ADV_100HALF	0x04000000
 #define B44_FLAG_ADV_100FULL	0x08000000
 #define B44_FLAG_INTERNAL_PHY	0x10000000
+#define B44_FLAG_NO_PHY		0x20000000
 
 	u32			rx_offset;
 

--Boundary-00=_iSYAB8dJI0zLw5S--
