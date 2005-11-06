Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVKFEpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVKFEpe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVKFEpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:45:34 -0500
Received: from havoc.gtf.org ([69.61.125.42]:46258 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932288AbVKFEpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:45:32 -0500
Date: Sat, 5 Nov 2005 23:45:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net drivers build fix, minor updates
Message-ID: <20051106044528.GA21984@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following build fix (fec_8xx currently breaks allmodconfig),
and minor updates:

 drivers/net/bnx2.c                        |  468 ++-
 drivers/net/bnx2.h                        |  119 
 drivers/net/bnx2_fw.h                     | 4055 ++++++++++++++++++------------
 drivers/net/e1000/e1000_ethtool.c         |    2 
 drivers/net/e1000/e1000_hw.c              |  101 
 drivers/net/e1000/e1000_hw.h              |   42 
 drivers/net/e1000/e1000_main.c            |   31 
 drivers/net/fec_8xx/Kconfig               |    2 
 drivers/net/hamradio/dmascc.c             |   10 
 drivers/net/ixgb/ixgb_ethtool.c           |    2 
 drivers/net/ixgb/ixgb_hw.c                |   31 
 drivers/net/ixgb/ixgb_hw.h                |   17 
 drivers/net/ixgb/ixgb_main.c              |    2 
 drivers/net/phy/cicada.c                  |    1 
 drivers/net/phy/davicom.c                 |    1 
 drivers/net/phy/lxt.c                     |    1 
 drivers/net/phy/marvell.c                 |    1 
 drivers/net/phy/mdio_bus.c                |    1 
 drivers/net/phy/phy.c                     |    1 
 drivers/net/phy/phy_device.c              |    1 
 drivers/net/phy/qsemi.c                   |    1 
 drivers/net/s2io.c                        |   10 
 drivers/net/wireless/airo.c               |    2 
 drivers/net/wireless/airo.h               |    9 
 drivers/net/wireless/airo_cs.c            |    6 
 drivers/net/wireless/prism54/islpci_eth.c |    1 
 include/linux/ethtool.h                   |    3 
 include/linux/pci_ids.h                   |    2 
 net/ieee80211/ieee80211_crypt.c           |    1 
 net/ieee80211/ieee80211_crypt_ccmp.c      |    1 
 net/ieee80211/ieee80211_crypt_tkip.c      |    1 
 net/ieee80211/ieee80211_crypt_wep.c       |    1 
 net/ieee80211/ieee80211_geo.c             |    1 
 net/ieee80211/ieee80211_module.c          |    1 
 net/ieee80211/ieee80211_rx.c              |    1 
 net/ieee80211/ieee80211_tx.c              |    1 
 36 files changed, 3165 insertions(+), 1766 deletions(-)

Adrian Bunk:
      drivers/net/ixgb/: make some code static
      drivers/net/e1000/: possible cleanups
      drivers/net/hamradio/dmascc.c: remove dmascc_setup()
      airo.c/airo_cs.c: correct prototypes

Daniel Drake:
      prism54: Remove redundant assignment

Jeff Garzik:
      Merge git://git.tuxdriver.com/git/netdev-jwl
      Remove linux/version.h include from drivers/net/phy/* and net/ieee80211/*.
      [netdrvr] fac_8xx build fix
      [netdrvr s2io] warning fixes

Michael Chan:
      bnx2: add 5708 support
      bnx2: update firmware for 5708
      bnx2: update nvram code for 5708
      bnx2: update firmware handshake for 5708
      bnx2: refine bnx2_poll
      bnx2: update version and minor fixes

diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
index 11d2523..8f46427 100644
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -14,8 +14,8 @@
 
 #define DRV_MODULE_NAME		"bnx2"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"1.2.21"
-#define DRV_MODULE_RELDATE	"September 7, 2005"
+#define DRV_MODULE_VERSION	"1.4.30"
+#define DRV_MODULE_RELDATE	"October 11, 2005"
 
 #define RUN_AT(x) (jiffies + (x))
 
@@ -26,7 +26,7 @@ static char version[] __devinitdata =
 	"Broadcom NetXtreme II Gigabit Ethernet Driver " DRV_MODULE_NAME " v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("Michael Chan <mchan@broadcom.com>");
-MODULE_DESCRIPTION("Broadcom NetXtreme II BCM5706 Driver");
+MODULE_DESCRIPTION("Broadcom NetXtreme II BCM5706/5708 Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
@@ -41,6 +41,8 @@ typedef enum {
 	NC370I,
 	BCM5706S,
 	NC370F,
+	BCM5708,
+	BCM5708S,
 } board_t;
 
 /* indexed by board_t, above */
@@ -52,6 +54,8 @@ static struct {
 	{ "HP NC370i Multifunction Gigabit Server Adapter" },
 	{ "Broadcom NetXtreme II BCM5706 1000Base-SX" },
 	{ "HP NC370F Multifunction Gigabit Server Adapter" },
+	{ "Broadcom NetXtreme II BCM5708 1000Base-T" },
+	{ "Broadcom NetXtreme II BCM5708 1000Base-SX" },
 	};
 
 static struct pci_device_id bnx2_pci_tbl[] = {
@@ -61,48 +65,102 @@ static struct pci_device_id bnx2_pci_tbl
 	  PCI_VENDOR_ID_HP, 0x3106, 0, 0, NC370I },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5706 },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5708,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5708 },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706S,
 	  PCI_VENDOR_ID_HP, 0x3102, 0, 0, NC370F },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5706S,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5706S },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_5708S,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BCM5708S },
 	{ 0, }
 };
 
 static struct flash_spec flash_table[] =
 {
 	/* Slow EEPROM */
-	{0x00000000, 0x40030380, 0x009f0081, 0xa184a053, 0xaf000400,
+	{0x00000000, 0x40830380, 0x009f0081, 0xa184a053, 0xaf000400,
 	 1, SEEPROM_PAGE_BITS, SEEPROM_PAGE_SIZE,
 	 SEEPROM_BYTE_ADDR_MASK, SEEPROM_TOTAL_SIZE,
 	 "EEPROM - slow"},
-	/* Fast EEPROM */
-	{0x02000000, 0x62008380, 0x009f0081, 0xa184a053, 0xaf000400,
-	 1, SEEPROM_PAGE_BITS, SEEPROM_PAGE_SIZE,
-	 SEEPROM_BYTE_ADDR_MASK, SEEPROM_TOTAL_SIZE,
-	 "EEPROM - fast"},
-	/* ATMEL AT45DB011B (buffered flash) */
-	{0x02000003, 0x6e008173, 0x00570081, 0x68848353, 0xaf000400,
-	 1, BUFFERED_FLASH_PAGE_BITS, BUFFERED_FLASH_PAGE_SIZE,
-	 BUFFERED_FLASH_BYTE_ADDR_MASK, BUFFERED_FLASH_TOTAL_SIZE,
-	 "Buffered flash"},
-	/* Saifun SA25F005 (non-buffered flash) */
-       	/* strap, cfg1, & write1 need updates */
-	{0x01000003, 0x5f008081, 0x00050081, 0x03840253, 0xaf020406,
+	/* Expansion entry 0001 */
+	{0x08000002, 0x4b808201, 0x00050081, 0x03840253, 0xaf020406,
 	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
-	 SAIFUN_FLASH_BYTE_ADDR_MASK, SAIFUN_FLASH_BASE_TOTAL_SIZE,
-	 "Non-buffered flash (64kB)"},
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 0001"},
 	/* Saifun SA25F010 (non-buffered flash) */
 	/* strap, cfg1, & write1 need updates */
-	{0x00000001, 0x47008081, 0x00050081, 0x03840253, 0xaf020406,
+	{0x04000001, 0x47808201, 0x00050081, 0x03840253, 0xaf020406,
 	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
 	 SAIFUN_FLASH_BYTE_ADDR_MASK, SAIFUN_FLASH_BASE_TOTAL_SIZE*2,
 	 "Non-buffered flash (128kB)"},
 	/* Saifun SA25F020 (non-buffered flash) */
 	/* strap, cfg1, & write1 need updates */
-	{0x00000003, 0x4f008081, 0x00050081, 0x03840253, 0xaf020406,
+	{0x0c000003, 0x4f808201, 0x00050081, 0x03840253, 0xaf020406,
 	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
 	 SAIFUN_FLASH_BYTE_ADDR_MASK, SAIFUN_FLASH_BASE_TOTAL_SIZE*4,
 	 "Non-buffered flash (256kB)"},
+	/* Expansion entry 0100 */
+	{0x11000000, 0x53808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 0100"},
+	/* Entry 0101: ST M45PE10 (non-buffered flash, TetonII B0) */
+	{0x19000002, 0x5b808201, 0x000500db, 0x03840253, 0xaf020406,        
+	 0, ST_MICRO_FLASH_PAGE_BITS, ST_MICRO_FLASH_PAGE_SIZE,
+	 ST_MICRO_FLASH_BYTE_ADDR_MASK, ST_MICRO_FLASH_BASE_TOTAL_SIZE*2,
+	 "Entry 0101: ST M45PE10 (128kB non-bufferred)"},
+	/* Entry 0110: ST M45PE20 (non-buffered flash)*/
+	{0x15000001, 0x57808201, 0x000500db, 0x03840253, 0xaf020406,
+	 0, ST_MICRO_FLASH_PAGE_BITS, ST_MICRO_FLASH_PAGE_SIZE,
+	 ST_MICRO_FLASH_BYTE_ADDR_MASK, ST_MICRO_FLASH_BASE_TOTAL_SIZE*4,
+	 "Entry 0110: ST M45PE20 (256kB non-bufferred)"},
+	/* Saifun SA25F005 (non-buffered flash) */
+	/* strap, cfg1, & write1 need updates */
+	{0x1d000003, 0x5f808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, SAIFUN_FLASH_BASE_TOTAL_SIZE,
+	 "Non-buffered flash (64kB)"},
+	/* Fast EEPROM */
+	{0x22000000, 0x62808380, 0x009f0081, 0xa184a053, 0xaf000400,
+	 1, SEEPROM_PAGE_BITS, SEEPROM_PAGE_SIZE,
+	 SEEPROM_BYTE_ADDR_MASK, SEEPROM_TOTAL_SIZE,
+	 "EEPROM - fast"},
+	/* Expansion entry 1001 */
+	{0x2a000002, 0x6b808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 1001"},
+	/* Expansion entry 1010 */
+	{0x26000001, 0x67808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 1010"},
+	/* ATMEL AT45DB011B (buffered flash) */
+	{0x2e000003, 0x6e808273, 0x00570081, 0x68848353, 0xaf000400,
+	 1, BUFFERED_FLASH_PAGE_BITS, BUFFERED_FLASH_PAGE_SIZE,
+	 BUFFERED_FLASH_BYTE_ADDR_MASK, BUFFERED_FLASH_TOTAL_SIZE,
+	 "Buffered flash (128kB)"},
+	/* Expansion entry 1100 */
+	{0x33000000, 0x73808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 1100"},
+	/* Expansion entry 1101 */
+	{0x3b000002, 0x7b808201, 0x00050081, 0x03840253, 0xaf020406,
+	 0, SAIFUN_FLASH_PAGE_BITS, SAIFUN_FLASH_PAGE_SIZE,
+	 SAIFUN_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 1101"},
+	/* Ateml Expansion entry 1110 */
+	{0x37000001, 0x76808273, 0x00570081, 0x68848353, 0xaf000400,
+	 1, BUFFERED_FLASH_PAGE_BITS, BUFFERED_FLASH_PAGE_SIZE,
+	 BUFFERED_FLASH_BYTE_ADDR_MASK, 0,
+	 "Entry 1110 (Atmel)"},
+	/* ATMEL AT45DB021B (buffered flash) */
+	{0x3f000003, 0x7e808273, 0x00570081, 0x68848353, 0xaf000400,
+	 1, BUFFERED_FLASH_PAGE_BITS, BUFFERED_FLASH_PAGE_SIZE,
+	 BUFFERED_FLASH_BYTE_ADDR_MASK, BUFFERED_FLASH_TOTAL_SIZE*2,
+	 "Buffered flash (256kB)"},
 };
 
 MODULE_DEVICE_TABLE(pci, bnx2_pci_tbl);
@@ -379,6 +437,62 @@ alloc_mem_err:
 }
 
 static void
+bnx2_report_fw_link(struct bnx2 *bp)
+{
+	u32 fw_link_status = 0;
+
+	if (bp->link_up) {
+		u32 bmsr;
+
+		switch (bp->line_speed) {
+		case SPEED_10:
+			if (bp->duplex == DUPLEX_HALF)
+				fw_link_status = BNX2_LINK_STATUS_10HALF;
+			else
+				fw_link_status = BNX2_LINK_STATUS_10FULL;
+			break;
+		case SPEED_100:
+			if (bp->duplex == DUPLEX_HALF)
+				fw_link_status = BNX2_LINK_STATUS_100HALF;
+			else
+				fw_link_status = BNX2_LINK_STATUS_100FULL;
+			break;
+		case SPEED_1000:
+			if (bp->duplex == DUPLEX_HALF)
+				fw_link_status = BNX2_LINK_STATUS_1000HALF;
+			else
+				fw_link_status = BNX2_LINK_STATUS_1000FULL;
+			break;
+		case SPEED_2500:
+			if (bp->duplex == DUPLEX_HALF)
+				fw_link_status = BNX2_LINK_STATUS_2500HALF;
+			else
+				fw_link_status = BNX2_LINK_STATUS_2500FULL;
+			break;
+		}
+
+		fw_link_status |= BNX2_LINK_STATUS_LINK_UP;
+
+		if (bp->autoneg) {
+			fw_link_status |= BNX2_LINK_STATUS_AN_ENABLED;
+
+			bnx2_read_phy(bp, MII_BMSR, &bmsr);
+			bnx2_read_phy(bp, MII_BMSR, &bmsr);
+
+			if (!(bmsr & BMSR_ANEGCOMPLETE) ||
+			    bp->phy_flags & PHY_PARALLEL_DETECT_FLAG)
+				fw_link_status |= BNX2_LINK_STATUS_PARALLEL_DET;
+			else
+				fw_link_status |= BNX2_LINK_STATUS_AN_COMPLETE;
+		}
+	}
+	else
+		fw_link_status = BNX2_LINK_STATUS_LINK_DOWN;
+
+	REG_WR_IND(bp, bp->shmem_base + BNX2_LINK_STATUS, fw_link_status);
+}
+
+static void
 bnx2_report_link(struct bnx2 *bp)
 {
 	if (bp->link_up) {
@@ -409,6 +523,8 @@ bnx2_report_link(struct bnx2 *bp)
 		netif_carrier_off(bp->dev);
 		printk(KERN_ERR PFX "%s NIC Link is Down\n", bp->dev->name);
 	}
+
+	bnx2_report_fw_link(bp);
 }
 
 static void
@@ -430,6 +546,18 @@ bnx2_resolve_flow_ctrl(struct bnx2 *bp)
 		return;
 	}
 
+	if ((bp->phy_flags & PHY_SERDES_FLAG) &&
+	    (CHIP_NUM(bp) == CHIP_NUM_5708)) {
+		u32 val;
+
+		bnx2_read_phy(bp, BCM5708S_1000X_STAT1, &val);
+		if (val & BCM5708S_1000X_STAT1_TX_PAUSE)
+			bp->flow_ctrl |= FLOW_CTRL_TX;
+		if (val & BCM5708S_1000X_STAT1_RX_PAUSE)
+			bp->flow_ctrl |= FLOW_CTRL_RX;
+		return;
+	}
+
 	bnx2_read_phy(bp, MII_ADVERTISE, &local_adv);
 	bnx2_read_phy(bp, MII_LPA, &remote_adv);
 
@@ -476,7 +604,36 @@ bnx2_resolve_flow_ctrl(struct bnx2 *bp)
 }
 
 static int
-bnx2_serdes_linkup(struct bnx2 *bp)
+bnx2_5708s_linkup(struct bnx2 *bp)
+{
+	u32 val;
+
+	bp->link_up = 1;
+	bnx2_read_phy(bp, BCM5708S_1000X_STAT1, &val);
+	switch (val & BCM5708S_1000X_STAT1_SPEED_MASK) {
+		case BCM5708S_1000X_STAT1_SPEED_10:
+			bp->line_speed = SPEED_10;
+			break;
+		case BCM5708S_1000X_STAT1_SPEED_100:
+			bp->line_speed = SPEED_100;
+			break;
+		case BCM5708S_1000X_STAT1_SPEED_1G:
+			bp->line_speed = SPEED_1000;
+			break;
+		case BCM5708S_1000X_STAT1_SPEED_2G5:
+			bp->line_speed = SPEED_2500;
+			break;
+	}
+	if (val & BCM5708S_1000X_STAT1_FD)
+		bp->duplex = DUPLEX_FULL;
+	else
+		bp->duplex = DUPLEX_HALF;
+
+	return 0;
+}
+
+static int
+bnx2_5706s_linkup(struct bnx2 *bp)
 {
 	u32 bmcr, local_adv, remote_adv, common;
 
@@ -593,13 +750,27 @@ bnx2_set_mac_link(struct bnx2 *bp)
 	val = REG_RD(bp, BNX2_EMAC_MODE);
 
 	val &= ~(BNX2_EMAC_MODE_PORT | BNX2_EMAC_MODE_HALF_DUPLEX |
-		BNX2_EMAC_MODE_MAC_LOOP | BNX2_EMAC_MODE_FORCE_LINK);
+		BNX2_EMAC_MODE_MAC_LOOP | BNX2_EMAC_MODE_FORCE_LINK |
+		BNX2_EMAC_MODE_25G);
 
 	if (bp->link_up) {
-		if (bp->line_speed != SPEED_1000)
-			val |= BNX2_EMAC_MODE_PORT_MII;
-		else
-			val |= BNX2_EMAC_MODE_PORT_GMII;
+		switch (bp->line_speed) {
+			case SPEED_10:
+				if (CHIP_NUM(bp) == CHIP_NUM_5708) {
+					val |= BNX2_EMAC_MODE_PORT_MII_10;
+					break;
+				}
+				/* fall through */
+			case SPEED_100:
+				val |= BNX2_EMAC_MODE_PORT_MII;
+				break;
+			case SPEED_2500:
+				val |= BNX2_EMAC_MODE_25G;
+				/* fall through */
+			case SPEED_1000:
+				val |= BNX2_EMAC_MODE_PORT_GMII;
+				break;
+		}
 	}
 	else {
 		val |= BNX2_EMAC_MODE_PORT_GMII;
@@ -662,7 +833,10 @@ bnx2_set_link(struct bnx2 *bp)
 		bp->link_up = 1;
 
 		if (bp->phy_flags & PHY_SERDES_FLAG) {
-			bnx2_serdes_linkup(bp);
+			if (CHIP_NUM(bp) == CHIP_NUM_5706)
+				bnx2_5706s_linkup(bp);
+			else if (CHIP_NUM(bp) == CHIP_NUM_5708)
+				bnx2_5708s_linkup(bp);
 		}
 		else {
 			bnx2_copper_linkup(bp);
@@ -755,39 +929,61 @@ bnx2_phy_get_pause_adv(struct bnx2 *bp)
 static int
 bnx2_setup_serdes_phy(struct bnx2 *bp)
 {
-	u32 adv, bmcr;
+	u32 adv, bmcr, up1;
 	u32 new_adv = 0;
 
 	if (!(bp->autoneg & AUTONEG_SPEED)) {
 		u32 new_bmcr;
+		int force_link_down = 0;
+
+		if (CHIP_NUM(bp) == CHIP_NUM_5708) {
+			bnx2_read_phy(bp, BCM5708S_UP1, &up1);
+			if (up1 & BCM5708S_UP1_2G5) {
+				up1 &= ~BCM5708S_UP1_2G5;
+				bnx2_write_phy(bp, BCM5708S_UP1, up1);
+				force_link_down = 1;
+			}
+		}
+
+		bnx2_read_phy(bp, MII_ADVERTISE, &adv);
+		adv &= ~(ADVERTISE_1000XFULL | ADVERTISE_1000XHALF);
 
 		bnx2_read_phy(bp, MII_BMCR, &bmcr);
 		new_bmcr = bmcr & ~BMCR_ANENABLE;
 		new_bmcr |= BMCR_SPEED1000;
 		if (bp->req_duplex == DUPLEX_FULL) {
+			adv |= ADVERTISE_1000XFULL;
 			new_bmcr |= BMCR_FULLDPLX;
 		}
 		else {
+			adv |= ADVERTISE_1000XHALF;
 			new_bmcr &= ~BMCR_FULLDPLX;
 		}
-		if (new_bmcr != bmcr) {
+		if ((new_bmcr != bmcr) || (force_link_down)) {
 			/* Force a link down visible on the other side */
 			if (bp->link_up) {
-				bnx2_read_phy(bp, MII_ADVERTISE, &adv);
-				adv &= ~(ADVERTISE_1000XFULL |
-					ADVERTISE_1000XHALF);
-				bnx2_write_phy(bp, MII_ADVERTISE, adv);
+				bnx2_write_phy(bp, MII_ADVERTISE, adv &
+					       ~(ADVERTISE_1000XFULL |
+						 ADVERTISE_1000XHALF));
 				bnx2_write_phy(bp, MII_BMCR, bmcr |
 					BMCR_ANRESTART | BMCR_ANENABLE);
 
 				bp->link_up = 0;
 				netif_carrier_off(bp->dev);
+				bnx2_write_phy(bp, MII_BMCR, new_bmcr);
 			}
+			bnx2_write_phy(bp, MII_ADVERTISE, adv);
 			bnx2_write_phy(bp, MII_BMCR, new_bmcr);
 		}
 		return 0;
 	}
 
+	if (bp->phy_flags & PHY_2_5G_CAPABLE_FLAG) {
+		bnx2_read_phy(bp, BCM5708S_UP1, &up1);
+		up1 |= BCM5708S_UP1_2G5;
+		bnx2_write_phy(bp, BCM5708S_UP1, up1);
+	}
+
 	if (bp->advertising & ADVERTISED_1000baseT_Full)
 		new_adv |= ADVERTISE_1000XFULL;
 
@@ -952,7 +1148,60 @@ bnx2_setup_phy(struct bnx2 *bp)
 }
 
 static int
-bnx2_init_serdes_phy(struct bnx2 *bp)
+bnx2_init_5708s_phy(struct bnx2 *bp)
+{
+	u32 val;
+
+	bnx2_write_phy(bp, BCM5708S_BLK_ADDR, BCM5708S_BLK_ADDR_DIG3);
+	bnx2_write_phy(bp, BCM5708S_DIG_3_0, BCM5708S_DIG_3_0_USE_IEEE);
+	bnx2_write_phy(bp, BCM5708S_BLK_ADDR, BCM5708S_BLK_ADDR_DIG);
+
+	bnx2_read_phy(bp, BCM5708S_1000X_CTL1, &val);
+	val |= BCM5708S_1000X_CTL1_FIBER_MODE | BCM5708S_1000X_CTL1_AUTODET_EN;
+	bnx2_write_phy(bp, BCM5708S_1000X_CTL1, val);
+
+	bnx2_read_phy(bp, BCM5708S_1000X_CTL2, &val);
+	val |= BCM5708S_1000X_CTL2_PLLEL_DET_EN;
+	bnx2_write_phy(bp, BCM5708S_1000X_CTL2, val);
+
+	if (bp->phy_flags & PHY_2_5G_CAPABLE_FLAG) {
+		bnx2_read_phy(bp, BCM5708S_UP1, &val);
+		val |= BCM5708S_UP1_2G5;
+		bnx2_write_phy(bp, BCM5708S_UP1, val);
+	}
+
+	if ((CHIP_ID(bp) == CHIP_ID_5708_A0) ||
+	    (CHIP_ID(bp) == CHIP_ID_5708_B0)) {
+		/* increase tx signal amplitude */
+		bnx2_write_phy(bp, BCM5708S_BLK_ADDR,
+			       BCM5708S_BLK_ADDR_TX_MISC);
+		bnx2_read_phy(bp, BCM5708S_TX_ACTL1, &val);
+		val &= ~BCM5708S_TX_ACTL1_DRIVER_VCM;
+		bnx2_write_phy(bp, BCM5708S_TX_ACTL1, val);
+		bnx2_write_phy(bp, BCM5708S_BLK_ADDR, BCM5708S_BLK_ADDR_DIG);
+	}
+
+	val = REG_RD_IND(bp, bp->shmem_base + BNX2_PORT_HW_CFG_CONFIG) &
+	      BNX2_PORT_HW_CFG_CFG_TXCTL3_MASK;
+
+	if (val) {
+		u32 is_backplane;
+
+		is_backplane = REG_RD_IND(bp, bp->shmem_base +
+					  BNX2_SHARED_HW_CFG_CONFIG);
+		if (is_backplane & BNX2_SHARED_HW_CFG_PHY_BACKPLANE) {
+			bnx2_write_phy(bp, BCM5708S_BLK_ADDR,
+				       BCM5708S_BLK_ADDR_TX_MISC);
+			bnx2_write_phy(bp, BCM5708S_TX_ACTL3, val);
+			bnx2_write_phy(bp, BCM5708S_BLK_ADDR,
+				       BCM5708S_BLK_ADDR_DIG);
+		}
+	}
+	return 0;
+}
+
+static int
+bnx2_init_5706s_phy(struct bnx2 *bp)
 {
 	bp->phy_flags &= ~PHY_PARALLEL_DETECT_FLAG;
 
@@ -990,6 +1239,8 @@ bnx2_init_serdes_phy(struct bnx2 *bp)
 static int
 bnx2_init_copper_phy(struct bnx2 *bp)
 {
+	u32 val;
+
 	bp->phy_flags |= PHY_CRC_FIX_FLAG;
 
 	if (bp->phy_flags & PHY_CRC_FIX_FLAG) {
@@ -1004,8 +1255,6 @@ bnx2_init_copper_phy(struct bnx2 *bp)
 	}
 
 	if (bp->dev->mtu > 1500) {
-		u32 val;
-
 		/* Set extended packet length bit */
 		bnx2_write_phy(bp, 0x18, 0x7);
 		bnx2_read_phy(bp, 0x18, &val);
@@ -1015,8 +1264,6 @@ bnx2_init_copper_phy(struct bnx2 *bp)
 		bnx2_write_phy(bp, 0x10, val | 0x1);
 	}
 	else {
-		u32 val;
-
 		bnx2_write_phy(bp, 0x18, 0x7);
 		bnx2_read_phy(bp, 0x18, &val);
 		bnx2_write_phy(bp, 0x18, val & ~0x4007);
@@ -1025,6 +1272,10 @@ bnx2_init_copper_phy(struct bnx2 *bp)
 		bnx2_write_phy(bp, 0x10, val & ~0x1);
 	}
 
+	/* ethernet@wirespeed */
+	bnx2_write_phy(bp, 0x18, 0x7007);
+	bnx2_read_phy(bp, 0x18, &val);
+	bnx2_write_phy(bp, 0x18, val | (1 << 15) | (1 << 4));
 	return 0;
 }
 
@@ -1048,7 +1299,10 @@ bnx2_init_phy(struct bnx2 *bp)
 	bp->phy_id |= val & 0xffff;
 
 	if (bp->phy_flags & PHY_SERDES_FLAG) {
-		rc = bnx2_init_serdes_phy(bp);
+		if (CHIP_NUM(bp) == CHIP_NUM_5706)
+			rc = bnx2_init_5706s_phy(bp);
+		else if (CHIP_NUM(bp) == CHIP_NUM_5708)
+			rc = bnx2_init_5708s_phy(bp);
 	}
 	else {
 		rc = bnx2_init_copper_phy(bp);
@@ -1084,13 +1338,13 @@ bnx2_fw_sync(struct bnx2 *bp, u32 msg_da
 	bp->fw_wr_seq++;
 	msg_data |= bp->fw_wr_seq;
 
-	REG_WR_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_DRV_MB, msg_data);
+	REG_WR_IND(bp, bp->shmem_base + BNX2_DRV_MB, msg_data);
 
 	/* wait for an acknowledgement. */
 	for (i = 0; i < (FW_ACK_TIME_OUT_MS * 1000)/5; i++) {
 		udelay(5);
 
-		val = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_FW_MB);
+		val = REG_RD_IND(bp, bp->shmem_base + BNX2_FW_MB);
 
 		if ((val & BNX2_FW_MSG_ACK) == (msg_data & BNX2_DRV_MSG_SEQ))
 			break;
@@ -1103,7 +1357,7 @@ bnx2_fw_sync(struct bnx2 *bp, u32 msg_da
 		msg_data &= ~BNX2_DRV_MSG_CODE;
 		msg_data |= BNX2_DRV_MSG_CODE_FW_TIMEOUT;
 
-		REG_WR_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_DRV_MB, msg_data);
+		REG_WR_IND(bp, bp->shmem_base + BNX2_DRV_MB, msg_data);
 
 		bp->fw_timed_out = 1;
 
@@ -1279,10 +1533,11 @@ bnx2_phy_int(struct bnx2 *bp)
 static void
 bnx2_tx_int(struct bnx2 *bp)
 {
+	struct status_block *sblk = bp->status_blk;
 	u16 hw_cons, sw_cons, sw_ring_cons;
 	int tx_free_bd = 0;
 
-	hw_cons = bp->status_blk->status_tx_quick_consumer_index0;
+	hw_cons = bp->hw_tx_cons = sblk->status_tx_quick_consumer_index0;
 	if ((hw_cons & MAX_TX_DESC_CNT) == MAX_TX_DESC_CNT) {
 		hw_cons++;
 	}
@@ -1337,7 +1592,9 @@ bnx2_tx_int(struct bnx2 *bp)
 
 		dev_kfree_skb_irq(skb);
 
-		hw_cons = bp->status_blk->status_tx_quick_consumer_index0;
+		hw_cons = bp->hw_tx_cons =
+			sblk->status_tx_quick_consumer_index0;
+
 		if ((hw_cons & MAX_TX_DESC_CNT) == MAX_TX_DESC_CNT) {
 			hw_cons++;
 		}
@@ -1382,11 +1639,12 @@ bnx2_reuse_rx_skb(struct bnx2 *bp, struc
 static int
 bnx2_rx_int(struct bnx2 *bp, int budget)
 {
+	struct status_block *sblk = bp->status_blk;
 	u16 hw_cons, sw_cons, sw_ring_cons, sw_prod, sw_ring_prod;
 	struct l2_fhdr *rx_hdr;
 	int rx_pkt = 0;
 
-	hw_cons = bp->status_blk->status_rx_quick_consumer_index0;
+	hw_cons = bp->hw_rx_cons = sblk->status_rx_quick_consumer_index0;
 	if ((hw_cons & MAX_RX_DESC_CNT) == MAX_RX_DESC_CNT) {
 		hw_cons++;
 	}
@@ -1506,6 +1764,15 @@ next_rx:
 
 		if ((rx_pkt == budget))
 			break;
+
+		/* Refresh hw_cons to see if there is new work */
+		if (sw_cons == hw_cons) {
+			hw_cons = bp->hw_rx_cons =
+				sblk->status_rx_quick_consumer_index0;
+			if ((hw_cons & MAX_RX_DESC_CNT) == MAX_RX_DESC_CNT)
+				hw_cons++;
+			rmb();
+		}
 	}
 	bp->rx_cons = sw_cons;
 	bp->rx_prod = sw_prod;
@@ -1573,15 +1840,27 @@ bnx2_interrupt(int irq, void *dev_instan
 	return IRQ_HANDLED;
 }
 
+static inline int
+bnx2_has_work(struct bnx2 *bp)
+{
+	struct status_block *sblk = bp->status_blk;
+
+	if ((sblk->status_rx_quick_consumer_index0 != bp->hw_rx_cons) ||
+	    (sblk->status_tx_quick_consumer_index0 != bp->hw_tx_cons))
+		return 1;
+
+	if (((sblk->status_attn_bits & STATUS_ATTN_BITS_LINK_STATE) != 0) !=
+	    bp->link_up)
+		return 1;
+
+	return 0;
+}
+
 static int
 bnx2_poll(struct net_device *dev, int *budget)
 {
 	struct bnx2 *bp = dev->priv;
-	int rx_done = 1;
-
-	bp->last_status_idx = bp->status_blk->status_idx;
 
-	rmb();
 	if ((bp->status_blk->status_attn_bits &
 		STATUS_ATTN_BITS_LINK_STATE) !=
 		(bp->status_blk->status_attn_bits_ack &
@@ -1592,11 +1871,10 @@ bnx2_poll(struct net_device *dev, int *b
 		spin_unlock(&bp->phy_lock);
 	}
 
-	if (bp->status_blk->status_tx_quick_consumer_index0 != bp->tx_cons) {
+	if (bp->status_blk->status_tx_quick_consumer_index0 != bp->hw_tx_cons)
 		bnx2_tx_int(bp);
-	}
 
-	if (bp->status_blk->status_rx_quick_consumer_index0 != bp->rx_cons) {
+	if (bp->status_blk->status_rx_quick_consumer_index0 != bp->hw_rx_cons) {
 		int orig_budget = *budget;
 		int work_done;
 
@@ -1606,13 +1884,12 @@ bnx2_poll(struct net_device *dev, int *b
 		work_done = bnx2_rx_int(bp, orig_budget);
 		*budget -= work_done;
 		dev->quota -= work_done;
-		
-		if (work_done >= orig_budget) {
-			rx_done = 0;
-		}
 	}
 	
-	if (rx_done) {
+	bp->last_status_idx = bp->status_blk->status_idx;
+	rmb();
+
+	if (!bnx2_has_work(bp)) {
 		netif_rx_complete(dev);
 		REG_WR(bp, BNX2_PCICFG_INT_ACK_CMD,
 			BNX2_PCICFG_INT_ACK_CMD_INDEX_VALID |
@@ -2383,21 +2660,27 @@ bnx2_init_nvram(struct bnx2 *bp)
 
 		/* Flash interface has been reconfigured */
 		for (j = 0, flash = &flash_table[0]; j < entry_count;
-			j++, flash++) {
-
-			if (val == flash->config1) {
+		     j++, flash++) {
+			if ((val & FLASH_BACKUP_STRAP_MASK) ==
+			    (flash->config1 & FLASH_BACKUP_STRAP_MASK)) {
 				bp->flash_info = flash;
 				break;
 			}
 		}
 	}
 	else {
+		u32 mask;
 		/* Not yet been reconfigured */
 
+		if (val & (1 << 23))
+			mask = FLASH_BACKUP_STRAP_MASK;
+		else
+			mask = FLASH_STRAP_MASK;
+
 		for (j = 0, flash = &flash_table[0]; j < entry_count;
 			j++, flash++) {
 
-			if ((val & FLASH_STRAP_MASK) == flash->strapping) {
+			if ((val & mask) == (flash->strapping & mask)) {
 				bp->flash_info = flash;
 
 				/* Request access to the flash interface. */
@@ -2733,7 +3016,7 @@ bnx2_reset_chip(struct bnx2 *bp, u32 res
 
 	/* Deposit a driver reset signature so the firmware knows that
 	 * this is a soft reset. */
-	REG_WR_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_DRV_RESET_SIGNATURE,
+	REG_WR_IND(bp, bp->shmem_base + BNX2_DRV_RESET_SIGNATURE,
 		   BNX2_DRV_RESET_SIGNATURE_MAGIC);
 
 	bp->fw_timed_out = 0;
@@ -2962,6 +3245,7 @@ bnx2_init_tx_ring(struct bnx2 *bp)
 
 	bp->tx_prod = 0;
 	bp->tx_cons = 0;
+	bp->hw_tx_cons = 0;
 	bp->tx_prod_bseq = 0;
 	
 	val = BNX2_L2CTX_TYPE_TYPE_L2;
@@ -2994,6 +3278,7 @@ bnx2_init_rx_ring(struct bnx2 *bp)
 
 	ring_prod = prod = bp->rx_prod = 0;
 	bp->rx_cons = 0;
+	bp->hw_rx_cons = 0;
 	bp->rx_prod_bseq = 0;
 		
 	rxbd = &bp->rx_desc_ring[0];
@@ -3079,7 +3364,7 @@ bnx2_free_rx_skbs(struct bnx2 *bp)
 		struct sw_bd *rx_buf = &bp->rx_buf_ring[i];
 		struct sk_buff *skb = rx_buf->skb;
 
-		if (skb == 0)
+		if (skb == NULL)
 			continue;
 
 		pci_unmap_single(bp->pdev, pci_unmap_addr(rx_buf, mapping),
@@ -3234,7 +3519,7 @@ bnx2_test_registers(struct bnx2 *bp)
 		{ 0x1408, 0, 0x01c00800, 0x00000000 },
 		{ 0x149c, 0, 0x8000ffff, 0x00000000 },
 		{ 0x14a8, 0, 0x00000000, 0x000001ff },
-		{ 0x14ac, 0, 0x4fffffff, 0x10000000 },
+		{ 0x14ac, 0, 0x0fffffff, 0x10000000 },
 		{ 0x14b0, 0, 0x00000002, 0x00000001 },
 		{ 0x14b8, 0, 0x00000000, 0x00000000 },
 		{ 0x14c0, 0, 0x00000000, 0x00000009 },
@@ -3577,7 +3862,7 @@ bnx2_test_memory(struct bnx2 *bp)
 		u32   len;
 	} mem_tbl[] = {
 		{ 0x60000,  0x4000 },
-		{ 0xa0000,  0x4000 },
+		{ 0xa0000,  0x3000 },
 		{ 0xe0000,  0x4000 },
 		{ 0x120000, 0x4000 },
 		{ 0x1a0000, 0x4000 },
@@ -3810,7 +4095,7 @@ bnx2_timer(unsigned long data)
 		goto bnx2_restart_timer;
 
 	msg = (u32) ++bp->fw_drv_pulse_wr_seq;
-	REG_WR_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_DRV_PULSE_MB, msg);
+	REG_WR_IND(bp, bp->shmem_base + BNX2_DRV_PULSE_MB, msg);
 
 	if ((bp->phy_flags & PHY_SERDES_FLAG) &&
 	    (CHIP_NUM(bp) == CHIP_NUM_5706)) {
@@ -4264,7 +4549,8 @@ bnx2_get_stats(struct net_device *dev)
     		(unsigned long) (stats_blk->stat_Dot3StatsExcessiveCollisions +
 		stats_blk->stat_Dot3StatsLateCollisions);
 
-	if (CHIP_NUM(bp) == CHIP_NUM_5706)
+	if ((CHIP_NUM(bp) == CHIP_NUM_5706) ||
+	    (CHIP_ID(bp) == CHIP_ID_5708_A0))
 		net_stats->tx_carrier_errors = 0;
 	else {
 		net_stats->tx_carrier_errors =
@@ -4814,6 +5100,14 @@ static u8 bnx2_5706_stats_len_arr[BNX2_N
 	4,4,4,4,4,
 };
 
+static u8 bnx2_5708_stats_len_arr[BNX2_NUM_STATS] = {
+	8,0,8,8,8,8,8,8,8,8,
+	4,4,4,4,4,4,4,4,4,4,
+	4,4,4,4,4,4,4,4,4,4,
+	4,4,4,4,4,4,4,4,4,4,
+	4,4,4,4,4,
+};
+
 #define BNX2_NUM_TESTS 6
 
 static struct {
@@ -4922,8 +5216,13 @@ bnx2_get_ethtool_stats(struct net_device
 		return;
 	}
 
-	if (CHIP_NUM(bp) == CHIP_NUM_5706)
+	if ((CHIP_ID(bp) == CHIP_ID_5706_A0) ||
+	    (CHIP_ID(bp) == CHIP_ID_5706_A1) ||
+	    (CHIP_ID(bp) == CHIP_ID_5706_A2) ||
+	    (CHIP_ID(bp) == CHIP_ID_5708_A0))
 		stats_len_arr = bnx2_5706_stats_len_arr;
+	else
+		stats_len_arr = bnx2_5708_stats_len_arr;
 
 	for (i = 0; i < BNX2_NUM_STATS; i++) {
 		if (stats_len_arr[i] == 0) {
@@ -5205,8 +5504,6 @@ bnx2_init_board(struct pci_dev *pdev, st
 
 	bp->chip_id = REG_RD(bp, BNX2_MISC_ID);
 
-	bp->phy_addr = 1;
-
 	/* Get bus information. */
 	reg = REG_RD(bp, BNX2_PCICFG_MISC_STATUS);
 	if (reg & BNX2_PCICFG_MISC_STATUS_PCIX_DET) {
@@ -5269,10 +5566,18 @@ bnx2_init_board(struct pci_dev *pdev, st
 
 	bnx2_init_nvram(bp);
 
+	reg = REG_RD_IND(bp, BNX2_SHM_HDR_SIGNATURE);
+
+	if ((reg & BNX2_SHM_HDR_SIGNATURE_SIG_MASK) ==
+	    BNX2_SHM_HDR_SIGNATURE_SIG)
+		bp->shmem_base = REG_RD_IND(bp, BNX2_SHM_HDR_ADDR_0);
+	else
+		bp->shmem_base = HOST_VIEW_SHMEM_BASE;
+
 	/* Get the permanent MAC address.  First we need to make sure the
 	 * firmware is actually running.
 	 */
-	reg = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_DEV_INFO_SIGNATURE);
+	reg = REG_RD_IND(bp, bp->shmem_base + BNX2_DEV_INFO_SIGNATURE);
 
 	if ((reg & BNX2_DEV_INFO_SIGNATURE_MAGIC_MASK) !=
 	    BNX2_DEV_INFO_SIGNATURE_MAGIC) {
@@ -5281,14 +5586,13 @@ bnx2_init_board(struct pci_dev *pdev, st
 		goto err_out_unmap;
 	}
 
-	bp->fw_ver = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE +
-				BNX2_DEV_INFO_BC_REV);
+	bp->fw_ver = REG_RD_IND(bp, bp->shmem_base + BNX2_DEV_INFO_BC_REV);
 
-	reg = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_PORT_HW_CFG_MAC_UPPER);
+	reg = REG_RD_IND(bp, bp->shmem_base + BNX2_PORT_HW_CFG_MAC_UPPER);
 	bp->mac_addr[0] = (u8) (reg >> 8);
 	bp->mac_addr[1] = (u8) reg;
 
-	reg = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE + BNX2_PORT_HW_CFG_MAC_LOWER);
+	reg = REG_RD_IND(bp, bp->shmem_base + BNX2_PORT_HW_CFG_MAC_LOWER);
 	bp->mac_addr[2] = (u8) (reg >> 24);
 	bp->mac_addr[3] = (u8) (reg >> 16);
 	bp->mac_addr[4] = (u8) (reg >> 8);
@@ -5316,10 +5620,19 @@ bnx2_init_board(struct pci_dev *pdev, st
 	bp->timer_interval =  HZ;
 	bp->current_interval =  HZ;
 
+	bp->phy_addr = 1;
+
 	/* Disable WOL support if we are running on a SERDES chip. */
 	if (CHIP_BOND_ID(bp) & CHIP_BOND_ID_SERDES_BIT) {
 		bp->phy_flags |= PHY_SERDES_FLAG;
 		bp->flags |= NO_WOL_FLAG;
+		if (CHIP_NUM(bp) == CHIP_NUM_5708) {
+			bp->phy_addr = 2;
+			reg = REG_RD_IND(bp, bp->shmem_base +
+					 BNX2_SHARED_HW_CFG_CONFIG);
+			if (reg & BNX2_SHARED_HW_CFG_PHY_2_5G)
+				bp->phy_flags |= PHY_2_5G_CAPABLE_FLAG;
+		}
 	}
 
 	if (CHIP_ID(bp) == CHIP_ID_5706_A0) {
@@ -5339,8 +5652,7 @@ bnx2_init_board(struct pci_dev *pdev, st
 	if (bp->phy_flags & PHY_SERDES_FLAG) {
 		bp->advertising = ETHTOOL_ALL_FIBRE_SPEED | ADVERTISED_Autoneg;
 
-		reg = REG_RD_IND(bp, HOST_VIEW_SHMEM_BASE +
-				 BNX2_PORT_HW_CFG_CONFIG);
+		reg = REG_RD_IND(bp, bp->shmem_base + BNX2_PORT_HW_CFG_CONFIG);
 		reg &= BNX2_PORT_HW_CFG_CFG_DFLT_LINK_MASK;
 		if (reg == BNX2_PORT_HW_CFG_CFG_DFLT_LINK_1G) {
 			bp->autoneg = 0;
diff --git a/drivers/net/bnx2.h b/drivers/net/bnx2.h
index 62857b6..76bb5f1 100644
--- a/drivers/net/bnx2.h
+++ b/drivers/net/bnx2.h
@@ -1449,8 +1449,9 @@ struct l2_fhdr {
 #define BNX2_EMAC_MODE_PORT_NONE			 (0L<<2)
 #define BNX2_EMAC_MODE_PORT_MII				 (1L<<2)
 #define BNX2_EMAC_MODE_PORT_GMII			 (2L<<2)
-#define BNX2_EMAC_MODE_PORT_UNDEF			 (3L<<2)
+#define BNX2_EMAC_MODE_PORT_MII_10			 (3L<<2)
 #define BNX2_EMAC_MODE_MAC_LOOP				 (1L<<4)
+#define BNX2_EMAC_MODE_25G				 (1L<<5)
 #define BNX2_EMAC_MODE_TAGGED_MAC_CTL			 (1L<<7)
 #define BNX2_EMAC_MODE_TX_BURST				 (1L<<8)
 #define BNX2_EMAC_MODE_MAX_DEFER_DROP_ENA		 (1L<<9)
@@ -3714,6 +3715,15 @@ struct l2_fhdr {
 #define BNX2_MCP_ROM					0x00150000
 #define BNX2_MCP_SCRATCH				0x00160000
 
+#define BNX2_SHM_HDR_SIGNATURE				BNX2_MCP_SCRATCH
+#define BNX2_SHM_HDR_SIGNATURE_SIG_MASK			 0xffff0000
+#define BNX2_SHM_HDR_SIGNATURE_SIG			 0x53530000
+#define BNX2_SHM_HDR_SIGNATURE_VER_MASK			 0x000000ff
+#define BNX2_SHM_HDR_SIGNATURE_VER_ONE			 0x00000001
+
+#define BNX2_SHM_HDR_ADDR_0				BNX2_MCP_SCRATCH + 4
+#define BNX2_SHM_HDR_ADDR_1				BNX2_MCP_SCRATCH + 8
+
 
 #define NUM_MC_HASH_REGISTERS   8
 
@@ -3724,6 +3734,53 @@ struct l2_fhdr {
 #define PHY_ID(id)                                  ((id) & 0xfffffff0)
 #define PHY_REV_ID(id)                              ((id) & 0xf)
 
+/* 5708 Serdes PHY registers */
+
+#define BCM5708S_UP1				0xb
+
+#define BCM5708S_UP1_2G5			0x1
+
+#define BCM5708S_BLK_ADDR			0x1f
+
+#define BCM5708S_BLK_ADDR_DIG			0x0000
+#define BCM5708S_BLK_ADDR_DIG3			0x0002
+#define BCM5708S_BLK_ADDR_TX_MISC		0x0005
+
+/* Digital Block */
+#define BCM5708S_1000X_CTL1			0x10
+
+#define BCM5708S_1000X_CTL1_FIBER_MODE		0x0001
+#define BCM5708S_1000X_CTL1_AUTODET_EN		0x0010
+
+#define BCM5708S_1000X_CTL2			0x11
+
+#define BCM5708S_1000X_CTL2_PLLEL_DET_EN	0x0001
+
+#define BCM5708S_1000X_STAT1			0x14
+
+#define BCM5708S_1000X_STAT1_SGMII		0x0001
+#define BCM5708S_1000X_STAT1_LINK		0x0002
+#define BCM5708S_1000X_STAT1_FD			0x0004
+#define BCM5708S_1000X_STAT1_SPEED_MASK		0x0018
+#define BCM5708S_1000X_STAT1_SPEED_10		0x0000
+#define BCM5708S_1000X_STAT1_SPEED_100		0x0008
+#define BCM5708S_1000X_STAT1_SPEED_1G		0x0010
+#define BCM5708S_1000X_STAT1_SPEED_2G5		0x0018
+#define BCM5708S_1000X_STAT1_TX_PAUSE		0x0020
+#define BCM5708S_1000X_STAT1_RX_PAUSE		0x0040
+
+/* Digital3 Block */
+#define BCM5708S_DIG_3_0			0x10
+
+#define BCM5708S_DIG_3_0_USE_IEEE		0x0001
+
+/* Tx/Misc Block */
+#define BCM5708S_TX_ACTL1			0x15
+
+#define BCM5708S_TX_ACTL1_DRIVER_VCM		0x30
+
+#define BCM5708S_TX_ACTL3			0x17
+
 #define MIN_ETHERNET_PACKET_SIZE	60
 #define MAX_ETHERNET_PACKET_SIZE	1514
 #define MAX_ETHERNET_JUMBO_PACKET_SIZE	9014
@@ -3799,7 +3856,7 @@ struct sw_bd {
 #define BUFFERED_FLASH_PHY_PAGE_SIZE		(1 << BUFFERED_FLASH_PAGE_BITS)
 #define BUFFERED_FLASH_BYTE_ADDR_MASK		(BUFFERED_FLASH_PHY_PAGE_SIZE-1)
 #define BUFFERED_FLASH_PAGE_SIZE		264
-#define BUFFERED_FLASH_TOTAL_SIZE		131072
+#define BUFFERED_FLASH_TOTAL_SIZE		0x21000
 
 #define SAIFUN_FLASH_PAGE_BITS			8
 #define SAIFUN_FLASH_PHY_PAGE_SIZE		(1 << SAIFUN_FLASH_PAGE_BITS)
@@ -3807,6 +3864,12 @@ struct sw_bd {
 #define SAIFUN_FLASH_PAGE_SIZE			256
 #define SAIFUN_FLASH_BASE_TOTAL_SIZE		65536
 
+#define ST_MICRO_FLASH_PAGE_BITS		8
+#define ST_MICRO_FLASH_PHY_PAGE_SIZE		(1 << ST_MICRO_FLASH_PAGE_BITS)
+#define ST_MICRO_FLASH_BYTE_ADDR_MASK		(ST_MICRO_FLASH_PHY_PAGE_SIZE-1)
+#define ST_MICRO_FLASH_PAGE_SIZE		256
+#define ST_MICRO_FLASH_BASE_TOTAL_SIZE		65536
+
 #define NVRAM_TIMEOUT_COUNT			30000
 
 
@@ -3815,6 +3878,8 @@ struct sw_bd {
 						 BNX2_NVM_CFG1_PROTECT_MODE | \
 						 BNX2_NVM_CFG1_FLASH_SIZE)
 
+#define FLASH_BACKUP_STRAP_MASK			(0xf << 26)
+
 struct flash_spec {
 	u32 strapping;
 	u32 config1;
@@ -3849,6 +3914,9 @@ struct bnx2 {
 	u16			tx_cons;
 	int			tx_ring_size;
 
+	u16			hw_tx_cons;
+	u16			hw_rx_cons;
+
 #ifdef BCM_VLAN 
 	struct			vlan_group *vlgrp;
 #endif
@@ -3893,6 +3961,7 @@ struct bnx2 {
 #define PHY_SERDES_FLAG			1
 #define PHY_CRC_FIX_FLAG		2
 #define PHY_PARALLEL_DETECT_FLAG	4
+#define PHY_2_5G_CAPABLE_FLAG		8
 #define PHY_INT_MODE_MASK_FLAG		0x300
 #define PHY_INT_MODE_AUTO_POLLING_FLAG	0x100
 #define PHY_INT_MODE_LINK_READY_FLAG	0x200
@@ -3901,6 +3970,7 @@ struct bnx2 {
 	/* chip num:16-31, rev:12-15, metal:4-11, bond_id:0-3 */
 #define CHIP_NUM(bp)			(((bp)->chip_id) & 0xffff0000)
 #define CHIP_NUM_5706			0x57060000
+#define CHIP_NUM_5708			0x57080000
 
 #define CHIP_REV(bp)			(((bp)->chip_id) & 0x0000f000)
 #define CHIP_REV_Ax			0x00000000
@@ -3913,6 +3983,9 @@ struct bnx2 {
 #define CHIP_ID(bp)			(((bp)->chip_id) & 0xfffffff0)
 #define CHIP_ID_5706_A0			0x57060000
 #define CHIP_ID_5706_A1			0x57060010
+#define CHIP_ID_5706_A2			0x57060020
+#define CHIP_ID_5708_A0			0x57080000
+#define CHIP_ID_5708_B0			0x57081000
 
 #define CHIP_BOND_ID(bp)		(((bp)->chip_id) & 0xf)
 
@@ -3991,6 +4064,8 @@ struct bnx2 {
 
 	u8			mac_addr[8];
 
+	u32			shmem_base;
+
 	u32			fw_ver;
 
 	int			pm_cap;
@@ -4130,14 +4205,46 @@ struct fw_info {
 #define BNX2_FW_MSG_STATUS_FAILURE		 0x00ff0000
 
 #define BNX2_LINK_STATUS			0x0000000c
+#define BNX2_LINK_STATUS_INIT_VALUE		 0xffffffff 
+#define BNX2_LINK_STATUS_LINK_UP		 0x1 
+#define BNX2_LINK_STATUS_LINK_DOWN		 0x0 
+#define BNX2_LINK_STATUS_SPEED_MASK		 0x1e
+#define BNX2_LINK_STATUS_AN_INCOMPLETE		 (0<<1) 
+#define BNX2_LINK_STATUS_10HALF			 (1<<1) 
+#define BNX2_LINK_STATUS_10FULL			 (2<<1) 
+#define BNX2_LINK_STATUS_100HALF		 (3<<1) 
+#define BNX2_LINK_STATUS_100BASE_T4		 (4<<1) 
+#define BNX2_LINK_STATUS_100FULL		 (5<<1) 
+#define BNX2_LINK_STATUS_1000HALF		 (6<<1) 
+#define BNX2_LINK_STATUS_1000FULL		 (7<<1) 
+#define BNX2_LINK_STATUS_2500HALF		 (8<<1) 
+#define BNX2_LINK_STATUS_2500FULL		 (9<<1) 
+#define BNX2_LINK_STATUS_AN_ENABLED		 (1<<5) 
+#define BNX2_LINK_STATUS_AN_COMPLETE		 (1<<6) 
+#define BNX2_LINK_STATUS_PARALLEL_DET		 (1<<7) 
+#define BNX2_LINK_STATUS_RESERVED		 (1<<8) 
+#define BNX2_LINK_STATUS_PARTNER_AD_1000FULL	 (1<<9) 
+#define BNX2_LINK_STATUS_PARTNER_AD_1000HALF	 (1<<10) 
+#define BNX2_LINK_STATUS_PARTNER_AD_100BT4	 (1<<11) 
+#define BNX2_LINK_STATUS_PARTNER_AD_100FULL	 (1<<12) 
+#define BNX2_LINK_STATUS_PARTNER_AD_100HALF	 (1<<13) 
+#define BNX2_LINK_STATUS_PARTNER_AD_10FULL	 (1<<14) 
+#define BNX2_LINK_STATUS_PARTNER_AD_10HALF	 (1<<15) 
+#define BNX2_LINK_STATUS_TX_FC_ENABLED		 (1<<16) 
+#define BNX2_LINK_STATUS_RX_FC_ENABLED		 (1<<17) 
+#define BNX2_LINK_STATUS_PARTNER_SYM_PAUSE_CAP	 (1<<18) 
+#define BNX2_LINK_STATUS_PARTNER_ASYM_PAUSE_CAP	 (1<<19) 
+#define BNX2_LINK_STATUS_SERDES_LINK		 (1<<20) 
+#define BNX2_LINK_STATUS_PARTNER_AD_2500FULL	 (1<<21) 
+#define BNX2_LINK_STATUS_PARTNER_AD_2500HALF	 (1<<22) 
 
 #define BNX2_DRV_PULSE_MB			0x00000010
-#define BNX2_DRV_PULSE_SEQ_MASK			 0x0000ffff
+#define BNX2_DRV_PULSE_SEQ_MASK			 0x00007fff
 
 /* Indicate to the firmware not to go into the
  * OS absent when it is not getting driver pulse.
  * This is used for debugging. */
-#define BNX2_DRV_MSG_DATA_PULSE_CODE_ALWAYS_ALIVE	 0x00010000
+#define BNX2_DRV_MSG_DATA_PULSE_CODE_ALWAYS_ALIVE	 0x00080000
 
 #define BNX2_DEV_INFO_SIGNATURE			0x00000020
 #define BNX2_DEV_INFO_SIGNATURE_MAGIC		 0x44564900
@@ -4160,6 +4267,8 @@ struct fw_info {
 #define BNX2_SHARED_HW_CFG_DESIGN_LOM		 0x1
 #define BNX2_SHARED_HW_CFG_PHY_COPPER		 0
 #define BNX2_SHARED_HW_CFG_PHY_FIBER		 0x2
+#define BNX2_SHARED_HW_CFG_PHY_2_5G		 0x20
+#define BNX2_SHARED_HW_CFG_PHY_BACKPLANE	 0x40
 #define BNX2_SHARED_HW_CFG_LED_MODE_SHIFT_BITS	 8
 #define BNX2_SHARED_HW_CFG_LED_MODE_MASK	 0x300
 #define BNX2_SHARED_HW_CFG_LED_MODE_MAC		 0
@@ -4173,9 +4282,11 @@ struct fw_info {
 
 #define BNX2_PORT_HW_CFG_MAC_LOWER		0x00000054
 #define BNX2_PORT_HW_CFG_CONFIG			0x00000058
+#define BNX2_PORT_HW_CFG_CFG_TXCTL3_MASK	 0x0000ffff
 #define BNX2_PORT_HW_CFG_CFG_DFLT_LINK_MASK	 0x001f0000
 #define BNX2_PORT_HW_CFG_CFG_DFLT_LINK_AN	 0x00000000
 #define BNX2_PORT_HW_CFG_CFG_DFLT_LINK_1G	 0x00030000
+#define BNX2_PORT_HW_CFG_CFG_DFLT_LINK_2_5G	 0x00040000
 
 #define BNX2_PORT_HW_CFG_IMD_MAC_A_UPPER	0x00000068
 #define BNX2_PORT_HW_CFG_IMD_MAC_A_LOWER	0x0000006c



[snip bnx2 firmware patch, big and obvious]



diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index 9c7feae..8eae8ba 100644
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -1739,7 +1739,7 @@ e1000_get_strings(struct net_device *net
 	}
 }
 
-struct ethtool_ops e1000_ethtool_ops = {
+static struct ethtool_ops e1000_ethtool_ops = {
 	.get_settings           = e1000_get_settings,
 	.set_settings           = e1000_set_settings,
 	.get_drvinfo            = e1000_get_drvinfo,
diff --git a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
index 8fc876d..a267c52 100644
--- a/drivers/net/e1000/e1000_hw.c
+++ b/drivers/net/e1000/e1000_hw.c
@@ -68,6 +68,38 @@ static int32_t e1000_polarity_reversal_w
 static int32_t e1000_set_phy_mode(struct e1000_hw *hw);
 static int32_t e1000_host_if_read_cookie(struct e1000_hw *hw, uint8_t *buffer);
 static uint8_t e1000_calculate_mng_checksum(char *buffer, uint32_t length);
+static uint8_t e1000_arc_subsystem_valid(struct e1000_hw *hw);
+static int32_t e1000_check_downshift(struct e1000_hw *hw);
+static int32_t e1000_check_polarity(struct e1000_hw *hw, uint16_t *polarity);
+static void e1000_clear_hw_cntrs(struct e1000_hw *hw);
+static void e1000_clear_vfta(struct e1000_hw *hw);
+static int32_t e1000_commit_shadow_ram(struct e1000_hw *hw);
+static int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw,
+						  boolean_t link_up);
+static int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
+static int32_t e1000_detect_gig_phy(struct e1000_hw *hw);
+static int32_t e1000_get_auto_rd_done(struct e1000_hw *hw);
+static int32_t e1000_get_cable_length(struct e1000_hw *hw,
+				      uint16_t *min_length,
+				      uint16_t *max_length);
+static int32_t e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw);
+static int32_t e1000_get_phy_cfg_done(struct e1000_hw *hw);
+static int32_t e1000_id_led_init(struct e1000_hw * hw);
+static void e1000_init_rx_addrs(struct e1000_hw *hw);
+static boolean_t e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw);
+static int32_t e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd);
+static void e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw);
+static int32_t e1000_read_eeprom_eerd(struct e1000_hw *hw, uint16_t offset,
+				      uint16_t words, uint16_t *data);
+static int32_t e1000_set_d0_lplu_state(struct e1000_hw *hw, boolean_t active);
+static int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
+static int32_t e1000_wait_autoneg(struct e1000_hw *hw);
+
+static void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset,
+			       uint32_t value);
+
+#define E1000_WRITE_REG_IO(a, reg, val) \
+	    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* IGP cable length table */
 static const
@@ -2035,7 +2067,7 @@ e1000_force_mac_fc(struct e1000_hw *hw)
  * based on the flow control negotiated by the PHY. In TBI mode, the TFCE
  * and RFCE bits will be automaticaly set to the negotiated flow control mode.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_config_fc_after_link_up(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -2537,7 +2569,7 @@ e1000_get_speed_and_duplex(struct e1000_
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_wait_autoneg(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -3021,7 +3053,7 @@ e1000_phy_reset(struct e1000_hw *hw)
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_detect_gig_phy(struct e1000_hw *hw)
 {
     int32_t phy_init_status, ret_val;
@@ -3121,7 +3153,7 @@ e1000_phy_reset_dsp(struct e1000_hw *hw)
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_igp_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -3195,7 +3227,7 @@ e1000_phy_igp_get_info(struct e1000_hw *
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_m88_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -3905,7 +3937,7 @@ e1000_read_eeprom(struct e1000_hw *hw,
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_eeprom_eerd(struct e1000_hw *hw,
                   uint16_t offset,
                   uint16_t words,
@@ -3939,7 +3971,7 @@ e1000_read_eeprom_eerd(struct e1000_hw *
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_write_eeprom_eewr(struct e1000_hw *hw,
                    uint16_t offset,
                    uint16_t words,
@@ -3976,7 +4008,7 @@ e1000_write_eeprom_eewr(struct e1000_hw 
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd)
 {
     uint32_t attempts = 100000;
@@ -4004,7 +4036,7 @@ e1000_poll_eerd_eewr_done(struct e1000_h
 *
 * hw - Struct containing variables accessed by shared code
 ****************************************************************************/
-boolean_t
+static boolean_t
 e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw)
 {
     uint32_t eecd = 0;
@@ -4322,7 +4354,7 @@ e1000_write_eeprom_microwire(struct e100
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_commit_shadow_ram(struct e1000_hw *hw)
 {
     uint32_t attempts = 100000;
@@ -4453,7 +4485,7 @@ e1000_read_mac_addr(struct e1000_hw * hw
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 e1000_init_rx_addrs(struct e1000_hw *hw)
 {
     uint32_t i;
@@ -4481,6 +4513,7 @@ e1000_init_rx_addrs(struct e1000_hw *hw)
     }
 }
 
+#if 0
 /******************************************************************************
  * Updates the MAC's list of multicast addresses.
  *
@@ -4564,6 +4597,7 @@ e1000_mc_addr_list_update(struct e1000_h
     }
     DEBUGOUT("MC Update Complete\n");
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Hashes an address to determine its location in the multicast table
@@ -4705,7 +4739,7 @@ e1000_write_vfta(struct e1000_hw *hw,
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_vfta(struct e1000_hw *hw)
 {
     uint32_t offset;
@@ -4735,7 +4769,7 @@ e1000_clear_vfta(struct e1000_hw *hw)
     }
 }
 
-int32_t
+static int32_t
 e1000_id_led_init(struct e1000_hw * hw)
 {
     uint32_t ledctl;
@@ -4997,7 +5031,7 @@ e1000_led_off(struct e1000_hw *hw)
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_hw_cntrs(struct e1000_hw *hw)
 {
     volatile uint32_t temp;
@@ -5283,6 +5317,8 @@ e1000_get_bus_info(struct e1000_hw *hw)
         break;
     }
 }
+
+#if 0
 /******************************************************************************
  * Reads a value from one of the devices registers using port I/O (as opposed
  * memory mapped I/O). Only 82544 and newer devices support port I/O.
@@ -5300,6 +5336,7 @@ e1000_read_reg_io(struct e1000_hw *hw,
     e1000_io_write(hw, io_addr, offset);
     return e1000_io_read(hw, io_data);
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Writes a value to one of the devices registers using port I/O (as opposed to
@@ -5309,7 +5346,7 @@ e1000_read_reg_io(struct e1000_hw *hw,
  * offset - offset to write to
  * value - value to write
  *****************************************************************************/
-void
+static void
 e1000_write_reg_io(struct e1000_hw *hw,
                    uint32_t offset,
                    uint32_t value)
@@ -5337,7 +5374,7 @@ e1000_write_reg_io(struct e1000_hw *hw,
  * register to the minimum and maximum range.
  * For IGP phy's, the function calculates the range by the AGC registers.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_get_cable_length(struct e1000_hw *hw,
                        uint16_t *min_length,
                        uint16_t *max_length)
@@ -5489,7 +5526,7 @@ e1000_get_cable_length(struct e1000_hw *
  * return 0.  If the link speed is 1000 Mbps the polarity status is in the
  * IGP01E1000_PHY_PCS_INIT_REG.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_polarity(struct e1000_hw *hw,
                      uint16_t *polarity)
 {
@@ -5551,7 +5588,7 @@ e1000_check_polarity(struct e1000_hw *hw
  * Link Health register.  In IGP this bit is latched high, so the driver must
  * read it immediately after link is established.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_downshift(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -5592,7 +5629,7 @@ e1000_check_downshift(struct e1000_hw *h
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_config_dsp_after_link_change(struct e1000_hw *hw,
                                    boolean_t link_up)
 {
@@ -5823,7 +5860,7 @@ e1000_set_phy_mode(struct e1000_hw *hw)
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_set_d3_lplu_state(struct e1000_hw *hw,
                         boolean_t active)
 {
@@ -5936,7 +5973,7 @@ e1000_set_d3_lplu_state(struct e1000_hw 
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_set_d0_lplu_state(struct e1000_hw *hw,
                         boolean_t active)
 {
@@ -6103,7 +6140,7 @@ e1000_host_if_read_cookie(struct e1000_h
  *            timeout
  *          - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_enable_host_if(struct e1000_hw * hw)
 {
     uint32_t hicr;
@@ -6137,7 +6174,7 @@ e1000_mng_enable_host_if(struct e1000_hw
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_host_if_write(struct e1000_hw * hw, uint8_t *buffer,
                         uint16_t length, uint16_t offset, uint8_t *sum)
 {
@@ -6205,7 +6242,7 @@ e1000_mng_host_if_write(struct e1000_hw 
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_write_cmd_header(struct e1000_hw * hw,
                            struct e1000_host_mng_command_header * hdr)
 {
@@ -6243,7 +6280,7 @@ e1000_mng_write_cmd_header(struct e1000_
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_write_commit(
     struct e1000_hw * hw)
 {
@@ -6496,7 +6533,7 @@ e1000_polarity_reversal_workaround(struc
  * returns: - none.
  *
  ***************************************************************************/
-void
+static void
 e1000_set_pci_express_master_disable(struct e1000_hw *hw)
 {
     uint32_t ctrl;
@@ -6511,6 +6548,7 @@ e1000_set_pci_express_master_disable(str
     E1000_WRITE_REG(hw, CTRL, ctrl);
 }
 
+#if 0
 /***************************************************************************
  *
  * Enables PCI-Express master access.
@@ -6534,6 +6572,7 @@ e1000_enable_pciex_master(struct e1000_h
     ctrl &= ~E1000_CTRL_GIO_MASTER_DISABLE;
     E1000_WRITE_REG(hw, CTRL, ctrl);
 }
+#endif  /*  0  */
 
 /*******************************************************************************
  *
@@ -6584,7 +6623,7 @@ e1000_disable_pciex_master(struct e1000_
  *            E1000_SUCCESS at any other case.
  *
  ******************************************************************************/
-int32_t
+static int32_t
 e1000_get_auto_rd_done(struct e1000_hw *hw)
 {
     int32_t timeout = AUTO_READ_DONE_TIMEOUT;
@@ -6623,7 +6662,7 @@ e1000_get_auto_rd_done(struct e1000_hw *
  *            E1000_SUCCESS at any other case.
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_phy_cfg_done(struct e1000_hw *hw)
 {
     int32_t timeout = PHY_CFG_TIMEOUT;
@@ -6666,7 +6705,7 @@ e1000_get_phy_cfg_done(struct e1000_hw *
  *            E1000_SUCCESS at any other case.
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw)
 {
     int32_t timeout;
@@ -6711,7 +6750,7 @@ e1000_get_hw_eeprom_semaphore(struct e10
  * returns: - None.
  *
  ***************************************************************************/
-void
+static void
 e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw)
 {
     uint32_t swsm;
@@ -6747,7 +6786,7 @@ e1000_check_phy_reset_block(struct e1000
 	    E1000_BLK_PHY_RESET : E1000_SUCCESS;
 }
 
-uint8_t
+static uint8_t
 e1000_arc_subsystem_valid(struct e1000_hw *hw)
 {
     uint32_t fwsm;
diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
index 4f2c196..76ce128 100644
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -284,7 +284,6 @@ typedef enum {
 /* Initialization */
 int32_t e1000_reset_hw(struct e1000_hw *hw);
 int32_t e1000_init_hw(struct e1000_hw *hw);
-int32_t e1000_id_led_init(struct e1000_hw * hw);
 int32_t e1000_set_mac_type(struct e1000_hw *hw);
 void e1000_set_media_type(struct e1000_hw *hw);
 
@@ -292,10 +291,8 @@ void e1000_set_media_type(struct e1000_h
 int32_t e1000_setup_link(struct e1000_hw *hw);
 int32_t e1000_phy_setup_autoneg(struct e1000_hw *hw);
 void e1000_config_collision_dist(struct e1000_hw *hw);
-int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
 int32_t e1000_check_for_link(struct e1000_hw *hw);
 int32_t e1000_get_speed_and_duplex(struct e1000_hw *hw, uint16_t * speed, uint16_t * duplex);
-int32_t e1000_wait_autoneg(struct e1000_hw *hw);
 int32_t e1000_force_mac_fc(struct e1000_hw *hw);
 
 /* PHY */
@@ -303,21 +300,11 @@ int32_t e1000_read_phy_reg(struct e1000_
 int32_t e1000_write_phy_reg(struct e1000_hw *hw, uint32_t reg_addr, uint16_t data);
 int32_t e1000_phy_hw_reset(struct e1000_hw *hw);
 int32_t e1000_phy_reset(struct e1000_hw *hw);
-int32_t e1000_detect_gig_phy(struct e1000_hw *hw);
 int32_t e1000_phy_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_phy_m88_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_phy_igp_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_get_cable_length(struct e1000_hw *hw, uint16_t *min_length, uint16_t *max_length);
-int32_t e1000_check_polarity(struct e1000_hw *hw, uint16_t *polarity);
-int32_t e1000_check_downshift(struct e1000_hw *hw);
 int32_t e1000_validate_mdi_setting(struct e1000_hw *hw);
 
 /* EEPROM Functions */
 int32_t e1000_init_eeprom_params(struct e1000_hw *hw);
-boolean_t e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw);
-int32_t e1000_read_eeprom_eerd(struct e1000_hw *hw, uint16_t offset, uint16_t words, uint16_t *data);
-int32_t e1000_write_eeprom_eewr(struct e1000_hw *hw, uint16_t offset, uint16_t words, uint16_t *data);
-int32_t e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd);
 
 /* MNG HOST IF functions */
 uint32_t e1000_enable_mng_pass_thru(struct e1000_hw *hw);
@@ -377,13 +364,6 @@ int32_t e1000_mng_write_dhcp_info(struct
 							uint16_t length);
 boolean_t e1000_check_mng_mode(struct e1000_hw *hw);
 boolean_t e1000_enable_tx_pkt_filtering(struct e1000_hw *hw);
-int32_t e1000_mng_enable_host_if(struct e1000_hw *hw);
-int32_t e1000_mng_host_if_write(struct e1000_hw *hw, uint8_t *buffer,
-                            uint16_t length, uint16_t offset, uint8_t *sum);
-int32_t e1000_mng_write_cmd_header(struct e1000_hw* hw, 
-                                   struct e1000_host_mng_command_header* hdr);
-
-int32_t e1000_mng_write_commit(struct e1000_hw *hw);
 
 int32_t e1000_read_eeprom(struct e1000_hw *hw, uint16_t reg, uint16_t words, uint16_t *data);
 int32_t e1000_validate_eeprom_checksum(struct e1000_hw *hw);
@@ -395,13 +375,10 @@ int32_t e1000_swfw_sync_acquire(struct e
 void e1000_swfw_sync_release(struct e1000_hw *hw, uint16_t mask);
 
 /* Filters (multicast, vlan, receive) */
-void e1000_init_rx_addrs(struct e1000_hw *hw);
-void e1000_mc_addr_list_update(struct e1000_hw *hw, uint8_t * mc_addr_list, uint32_t mc_addr_count, uint32_t pad, uint32_t rar_used_count);
 uint32_t e1000_hash_mc_addr(struct e1000_hw *hw, uint8_t * mc_addr);
 void e1000_mta_set(struct e1000_hw *hw, uint32_t hash_value);
 void e1000_rar_set(struct e1000_hw *hw, uint8_t * mc_addr, uint32_t rar_index);
 void e1000_write_vfta(struct e1000_hw *hw, uint32_t offset, uint32_t value);
-void e1000_clear_vfta(struct e1000_hw *hw);
 
 /* LED functions */
 int32_t e1000_setup_led(struct e1000_hw *hw);
@@ -412,7 +389,6 @@ int32_t e1000_led_off(struct e1000_hw *h
 /* Adaptive IFS Functions */
 
 /* Everything else */
-void e1000_clear_hw_cntrs(struct e1000_hw *hw);
 void e1000_reset_adaptive(struct e1000_hw *hw);
 void e1000_update_adaptive(struct e1000_hw *hw);
 void e1000_tbi_adjust_stats(struct e1000_hw *hw, struct e1000_hw_stats *stats, uint32_t frame_len, uint8_t * mac_addr);
@@ -423,29 +399,11 @@ void e1000_read_pci_cfg(struct e1000_hw 
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 /* Port I/O is only supported on 82544 and newer */
 uint32_t e1000_io_read(struct e1000_hw *hw, unsigned long port);
-uint32_t e1000_read_reg_io(struct e1000_hw *hw, uint32_t offset);
 void e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value);
-void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset, uint32_t value);
-int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw, boolean_t link_up);
-int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
-int32_t e1000_set_d0_lplu_state(struct e1000_hw *hw, boolean_t active);
-void e1000_set_pci_express_master_disable(struct e1000_hw *hw);
-void e1000_enable_pciex_master(struct e1000_hw *hw);
 int32_t e1000_disable_pciex_master(struct e1000_hw *hw);
-int32_t e1000_get_auto_rd_done(struct e1000_hw *hw);
-int32_t e1000_get_phy_cfg_done(struct e1000_hw *hw);
 int32_t e1000_get_software_semaphore(struct e1000_hw *hw);
 void e1000_release_software_semaphore(struct e1000_hw *hw);
 int32_t e1000_check_phy_reset_block(struct e1000_hw *hw);
-int32_t e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw);
-void e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw);
-int32_t e1000_commit_shadow_ram(struct e1000_hw *hw);
-uint8_t e1000_arc_subsystem_valid(struct e1000_hw *hw);
-
-#define E1000_READ_REG_IO(a, reg) \
-    e1000_read_reg_io((a), E1000_##reg)
-#define E1000_WRITE_REG_IO(a, reg, val) \
-    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* PCI Device IDs */
 #define E1000_DEV_ID_82542               0x1000
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index efbbda7..8b207f0 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -37,7 +37,7 @@
  */
 
 char e1000_driver_name[] = "e1000";
-char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 #ifndef CONFIG_E1000_NAPI
 #define DRIVERNAPI
 #else
@@ -45,7 +45,7 @@ char e1000_driver_string[] = "Intel(R) P
 #endif
 #define DRV_VERSION "6.1.16-k2"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
-char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
+static char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
  *
@@ -112,14 +112,14 @@ int e1000_setup_all_tx_resources(struct 
 int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
 void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
 void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
-int e1000_setup_tx_resources(struct e1000_adapter *adapter,
-                             struct e1000_tx_ring *txdr);
-int e1000_setup_rx_resources(struct e1000_adapter *adapter,
-                             struct e1000_rx_ring *rxdr);
-void e1000_free_tx_resources(struct e1000_adapter *adapter,
-                             struct e1000_tx_ring *tx_ring);
-void e1000_free_rx_resources(struct e1000_adapter *adapter,
-                             struct e1000_rx_ring *rx_ring);
+static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
+				    struct e1000_tx_ring *txdr);
+static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
+				    struct e1000_rx_ring *rxdr);
+static void e1000_free_tx_resources(struct e1000_adapter *adapter,
+				    struct e1000_tx_ring *tx_ring);
+static void e1000_free_rx_resources(struct e1000_adapter *adapter,
+				    struct e1000_rx_ring *rx_ring);
 void e1000_update_stats(struct e1000_adapter *adapter);
 
 /* Local Function Prototypes */
@@ -296,7 +296,8 @@ e1000_irq_enable(struct e1000_adapter *a
 		E1000_WRITE_FLUSH(&adapter->hw);
 	}
 }
-void
+
+static void
 e1000_update_mng_vlan(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1141,7 +1142,7 @@ e1000_check_64k_bound(struct e1000_adapt
  * Return 0 on success, negative on failure
  **/
 
-int
+static int
 e1000_setup_tx_resources(struct e1000_adapter *adapter,
                          struct e1000_tx_ring *txdr)
 {
@@ -1359,7 +1360,7 @@ e1000_configure_tx(struct e1000_adapter 
  * Returns 0 on success, negative on failure
  **/
 
-int
+static int
 e1000_setup_rx_resources(struct e1000_adapter *adapter,
                          struct e1000_rx_ring *rxdr)
 {
@@ -1747,7 +1748,7 @@ e1000_configure_rx(struct e1000_adapter 
  * Free all transmit software resources
  **/
 
-void
+static void
 e1000_free_tx_resources(struct e1000_adapter *adapter,
                         struct e1000_tx_ring *tx_ring)
 {
@@ -1858,7 +1859,7 @@ e1000_clean_all_tx_rings(struct e1000_ad
  * Free all receive software resources
  **/
 
-void
+static void
 e1000_free_rx_resources(struct e1000_adapter *adapter,
                         struct e1000_rx_ring *rx_ring)
 {
diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index 4560026..94e7a9a 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && FEC
 	select MII
 
 config FEC_8XX_GENERIC_PHY
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index 3be3f91..c8dc402 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -311,16 +311,6 @@ static void __exit dmascc_exit(void)
 	}
 }
 
-#ifndef MODULE
-void __init dmascc_setup(char *str, int *ints)
-{
-	int i;
-
-	for (i = 0; i < MAX_NUM_DEVS && i < ints[0]; i++)
-		io[i] = ints[i + 1];
-}
-#endif
-
 static int __init dmascc_init(void)
 {
 	int h, i, j, n;
diff --git a/drivers/net/ixgb/ixgb_ethtool.c b/drivers/net/ixgb/ixgb_ethtool.c
index 04e4718..d38ade5 100644
--- a/drivers/net/ixgb/ixgb_ethtool.c
+++ b/drivers/net/ixgb/ixgb_ethtool.c
@@ -694,7 +694,7 @@ ixgb_get_strings(struct net_device *netd
 	}
 }
 
-struct ethtool_ops ixgb_ethtool_ops = {
+static struct ethtool_ops ixgb_ethtool_ops = {
 	.get_settings = ixgb_get_settings,
 	.set_settings = ixgb_set_settings,
 	.get_drvinfo = ixgb_get_drvinfo,
diff --git a/drivers/net/ixgb/ixgb_hw.c b/drivers/net/ixgb/ixgb_hw.c
index 69329c7..620cad4 100644
--- a/drivers/net/ixgb/ixgb_hw.c
+++ b/drivers/net/ixgb/ixgb_hw.c
@@ -47,9 +47,22 @@ static void ixgb_optics_reset(struct ixg
 
 static ixgb_phy_type ixgb_identify_phy(struct ixgb_hw *hw);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw);
+static void ixgb_clear_hw_cntrs(struct ixgb_hw *hw);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
+static void ixgb_clear_vfta(struct ixgb_hw *hw);
+
+static void ixgb_init_rx_addrs(struct ixgb_hw *hw);
+
+static uint16_t ixgb_read_phy_reg(struct ixgb_hw *hw,
+				  uint32_t reg_address,
+				  uint32_t phy_address,
+				  uint32_t device_type);
+
+static boolean_t ixgb_setup_fc(struct ixgb_hw *hw);
+
+static boolean_t mac_addr_valid(uint8_t *mac_addr);
+
+static uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
 
@@ -335,7 +348,7 @@ ixgb_init_hw(struct ixgb_hw *hw)
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 ixgb_init_rx_addrs(struct ixgb_hw *hw)
 {
 	uint32_t i;
@@ -604,7 +617,7 @@ ixgb_write_vfta(struct ixgb_hw *hw,
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_vfta(struct ixgb_hw *hw)
 {
 	uint32_t offset;
@@ -620,7 +633,7 @@ ixgb_clear_vfta(struct ixgb_hw *hw)
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
 
-boolean_t
+static boolean_t
 ixgb_setup_fc(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
@@ -722,7 +735,7 @@ ixgb_setup_fc(struct ixgb_hw *hw)
  * This requires that first an address cycle command is sent, followed by a
  * read command.
  *****************************************************************************/
-uint16_t
+static uint16_t
 ixgb_read_phy_reg(struct ixgb_hw *hw,
 		uint32_t reg_address,
 		uint32_t phy_address,
@@ -815,7 +828,7 @@ ixgb_read_phy_reg(struct ixgb_hw *hw,
  * This requires that first an address cycle command is sent, followed by a
  * write command.
  *****************************************************************************/
-void
+static void
 ixgb_write_phy_reg(struct ixgb_hw *hw,
 			uint32_t reg_address,
 			uint32_t phy_address,
@@ -959,7 +972,7 @@ boolean_t ixgb_check_for_bad_link(struct
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_hw_cntrs(struct ixgb_hw *hw)
 {
 	volatile uint32_t temp_reg;
@@ -1114,7 +1127,7 @@ ixgb_get_bus_info(struct ixgb_hw *hw)
  * mac_addr - pointer to MAC address.
  *
  *****************************************************************************/
-boolean_t
+static boolean_t
 mac_addr_valid(uint8_t *mac_addr)
 {
 	boolean_t is_valid = TRUE;
diff --git a/drivers/net/ixgb/ixgb_hw.h b/drivers/net/ixgb/ixgb_hw.h
index 8bcf31e..382c630 100644
--- a/drivers/net/ixgb/ixgb_hw.h
+++ b/drivers/net/ixgb/ixgb_hw.h
@@ -784,23 +784,8 @@ struct ixgb_hw_stats {
 extern boolean_t ixgb_adapter_stop(struct ixgb_hw *hw);
 extern boolean_t ixgb_init_hw(struct ixgb_hw *hw);
 extern boolean_t ixgb_adapter_start(struct ixgb_hw *hw);
-extern void ixgb_init_rx_addrs(struct ixgb_hw *hw);
 extern void ixgb_check_for_link(struct ixgb_hw *hw);
 extern boolean_t ixgb_check_for_bad_link(struct ixgb_hw *hw);
-extern boolean_t ixgb_setup_fc(struct ixgb_hw *hw);
-extern void ixgb_clear_hw_cntrs(struct ixgb_hw *hw);
-extern boolean_t mac_addr_valid(uint8_t *mac_addr);
-
-extern uint16_t ixgb_read_phy_reg(struct ixgb_hw *hw,
-				uint32_t reg_addr,
-				uint32_t phy_addr,
-				uint32_t device_type);
-
-extern void ixgb_write_phy_reg(struct ixgb_hw *hw,
-				uint32_t reg_addr,
-				uint32_t phy_addr,
-				uint32_t device_type,
-				uint16_t data);
 
 extern void ixgb_rar_set(struct ixgb_hw *hw,
 				uint8_t *addr,
@@ -818,8 +803,6 @@ extern void ixgb_write_vfta(struct ixgb_
 				 uint32_t offset,
 				 uint32_t value);
 
-extern void ixgb_clear_vfta(struct ixgb_hw *hw);
-
 /* Access functions to eeprom data */
 void ixgb_get_ee_mac_addr(struct ixgb_hw *hw, uint8_t *mac_addr);
 uint32_t ixgb_get_ee_pba_number(struct ixgb_hw *hw);
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index 176680c..f9f77e4 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -45,7 +45,7 @@
  */
 
 char ixgb_driver_name[] = "ixgb";
-char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
+static char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
 
 #ifndef CONFIG_IXGB_NAPI
 #define DRIVERNAPI
diff --git a/drivers/net/phy/cicada.c b/drivers/net/phy/cicada.c
index c47fb2e..7d8d534 100644
--- a/drivers/net/phy/cicada.c
+++ b/drivers/net/phy/cicada.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
index 6caf499..5e9002e 100644
--- a/drivers/net/phy/davicom.c
+++ b/drivers/net/phy/davicom.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index 4c84044..bef79e4 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 4a72b02..a2d6386 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 5eab9c4..02940c0 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9209da9..b8686e4 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -30,7 +30,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6da1aa0..16bebe7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -30,7 +30,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/phy/qsemi.c b/drivers/net/phy/qsemi.c
index d461ba4..65d995b 100644
--- a/drivers/net/phy/qsemi.c
+++ b/drivers/net/phy/qsemi.c
@@ -29,7 +29,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 9c49354..0745dd9 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -2110,7 +2110,7 @@ int fill_rxd_3buf(nic_t *nic, RxD_t *rxd
 {
 	struct net_device *dev = nic->dev;
 	struct sk_buff *frag_list;
-	u64 tmp;
+	void *tmp;
 
 	/* Buffer-1 receives L3/L4 headers */
 	((RxD3_t*)rxdp)->Buffer1_ptr = pci_map_single
@@ -2125,11 +2125,9 @@ int fill_rxd_3buf(nic_t *nic, RxD_t *rxd
 	}
 	frag_list = skb_shinfo(skb)->frag_list;
 	frag_list->next = NULL;
-	tmp = (u64) frag_list->data;
-	tmp += ALIGN_SIZE;
-	tmp &= ~ALIGN_SIZE;
-	frag_list->data = (void *) tmp;
-	frag_list->tail = (void *) tmp;
+	tmp = (void *)ALIGN((long)frag_list->data, ALIGN_SIZE + 1);
+	frag_list->data = tmp;
+	frag_list->tail = tmp;
 
 	/* Buffer-2 receives L4 data payload */
 	((RxD3_t*)rxdp)->Buffer2_ptr = pci_map_single(nic->pdev,
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 849ac88..6afc6e5 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -47,6 +47,8 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#include "airo.h"
+
 #ifdef CONFIG_PCI
 static struct pci_device_id card_ids[] = {
 	{ 0x14b9, 1, PCI_ANY_ID, PCI_ANY_ID, },
diff --git a/drivers/net/wireless/airo.h b/drivers/net/wireless/airo.h
new file mode 100644
index 0000000..e480adf
--- /dev/null
+++ b/drivers/net/wireless/airo.h
@@ -0,0 +1,9 @@
+#ifndef _AIRO_H_
+#define _AIRO_H_
+
+struct net_device *init_airo_card(unsigned short irq, int port, int is_pcmcia,
+				  struct device *dmdev);
+int reset_airo_card(struct net_device *dev);
+void stop_airo_card(struct net_device *dev, int freeres);
+
+#endif  /*  _AIRO_H_  */
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index 784de91..96ed8da 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -42,6 +42,8 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
+#include "airo.h"
+
 /*
    All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
    you do not define PCMCIA_DEBUG at all, all the debug code will be
@@ -78,10 +80,6 @@ MODULE_SUPPORTED_DEVICE("Aironet 4500, 4
    event handler. 
 */
 
-struct net_device *init_airo_card( int, int, int, struct device * );
-void stop_airo_card( struct net_device *, int );
-int reset_airo_card( struct net_device * );
-
 static void airo_config(dev_link_t *link);
 static void airo_release(dev_link_t *link);
 static int airo_event(event_t event, int priority,
diff --git a/drivers/net/wireless/prism54/islpci_eth.c b/drivers/net/wireless/prism54/islpci_eth.c
index 3b49efa..fc1eb35 100644
--- a/drivers/net/wireless/prism54/islpci_eth.c
+++ b/drivers/net/wireless/prism54/islpci_eth.c
@@ -244,7 +244,6 @@ islpci_eth_transmit(struct sk_buff *skb,
 	priv->statistics.tx_dropped++;
 	spin_unlock_irqrestore(&priv->slock, flags);
 	dev_kfree_skb(skb);
-	skb = NULL;
 	return err;
 }
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d2c390e..93535f0 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -453,10 +453,11 @@ struct ethtool_ops {
  * it was foced up into this mode or autonegotiated.
  */
 
-/* The forced speed, 10Mb, 100Mb, gigabit, 10GbE. */
+/* The forced speed, 10Mb, 100Mb, gigabit, 2.5Gb, 10GbE. */
 #define SPEED_10		10
 #define SPEED_100		100
 #define SPEED_1000		1000
+#define SPEED_2500		2500
 #define SPEED_10000		10000
 
 /* Duplex, half or full. */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 88de3f8..8cadfde 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1785,6 +1785,7 @@
 #define PCI_DEVICE_ID_TIGON3_5704	0x1648
 #define PCI_DEVICE_ID_TIGON3_5704S_2	0x1649
 #define PCI_DEVICE_ID_NX2_5706		0x164a
+#define PCI_DEVICE_ID_NX2_5708		0x164c
 #define PCI_DEVICE_ID_TIGON3_5702FE	0x164d
 #define PCI_DEVICE_ID_TIGON3_5705	0x1653
 #define PCI_DEVICE_ID_TIGON3_5705_2	0x1654
@@ -1809,6 +1810,7 @@
 #define PCI_DEVICE_ID_TIGON3_5703X	0x16a7
 #define PCI_DEVICE_ID_TIGON3_5704S	0x16a8
 #define PCI_DEVICE_ID_NX2_5706S		0x16aa
+#define PCI_DEVICE_ID_NX2_5708S		0x16ac
 #define PCI_DEVICE_ID_TIGON3_5702A3	0x16c6
 #define PCI_DEVICE_ID_TIGON3_5703A3	0x16c7
 #define PCI_DEVICE_ID_TIGON3_5781	0x16dd
diff --git a/net/ieee80211/ieee80211_crypt.c b/net/ieee80211/ieee80211_crypt.c
index f3b6aa3..20cc580 100644
--- a/net/ieee80211/ieee80211_crypt.c
+++ b/net/ieee80211/ieee80211_crypt.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/net/ieee80211/ieee80211_crypt_ccmp.c b/net/ieee80211/ieee80211_crypt_ccmp.c
index 05a853c..4702217 100644
--- a/net/ieee80211/ieee80211_crypt_ccmp.c
+++ b/net/ieee80211/ieee80211_crypt_ccmp.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/net/ieee80211/ieee80211_crypt_tkip.c b/net/ieee80211/ieee80211_crypt_tkip.c
index 2e34f29..e098832 100644
--- a/net/ieee80211/ieee80211_crypt_tkip.c
+++ b/net/ieee80211/ieee80211_crypt_tkip.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/net/ieee80211/ieee80211_crypt_wep.c b/net/ieee80211/ieee80211_crypt_wep.c
index 7c08ed2..073aebd 100644
--- a/net/ieee80211/ieee80211_crypt_wep.c
+++ b/net/ieee80211/ieee80211_crypt_wep.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/net/ieee80211/ieee80211_geo.c b/net/ieee80211/ieee80211_geo.c
index c4b54ef..610cc5c 100644
--- a/net/ieee80211/ieee80211_geo.c
+++ b/net/ieee80211/ieee80211_geo.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/wireless.h>
 #include <linux/etherdevice.h>
 #include <asm/uaccess.h>
diff --git a/net/ieee80211/ieee80211_module.c b/net/ieee80211/ieee80211_module.c
index f66d792..321287b 100644
--- a/net/ieee80211/ieee80211_module.c
+++ b/net/ieee80211/ieee80211_module.c
@@ -45,7 +45,6 @@
 #include <linux/slab.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/wireless.h>
 #include <linux/etherdevice.h>
 #include <asm/uaccess.h>
diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index ce694cf..6ad8821 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/wireless.h>
 #include <linux/etherdevice.h>
 #include <asm/uaccess.h>
diff --git a/net/ieee80211/ieee80211_tx.c b/net/ieee80211/ieee80211_tx.c
index 95ccbad..445f206 100644
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/wireless.h>
 #include <linux/etherdevice.h>
 #include <asm/uaccess.h>
