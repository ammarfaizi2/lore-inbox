Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVDNAHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDNAHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVDMXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:49:41 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35336 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261221AbVDMXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:54 -0400
Date: Wed, 13 Apr 2005 19:38:43 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 1/10] tg3: add basic bcm5752 support
Message-ID: <04132005193843.8351@laptop>
In-Reply-To: <04132005193843.8300@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Track-down all references to ASIC_REV_5750 and mirror them with
references to the newly defined ASIC_REV_5752.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |   63 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 42 insertions(+), 21 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 17:28:59.660670261 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 17:29:05.039934450 -0400
@@ -86,7 +86,8 @@
 #define TG3_MIN_MTU			60
 #define TG3_MAX_MTU(tp)	\
 	((GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 && \
-	  GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750) ? 9000 : 1500)
+	  GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 && \
+	  GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) ? 9000 : 1500)
 
 /* These numbers seem to be hard coded in the NIC firmware somehow.
  * You can't change the ring sizes, but you can change where you place
@@ -861,7 +862,8 @@ out:
 		/* Cannot do read-modify-write on 5401 */
 		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x4c20);
 	} else if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 &&
-		   GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750) {
+		   GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
+		   GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) {
 		u32 phy_reg;
 
 		/* Set bit 14 with read-modify-write to preserve other bits */
@@ -874,7 +876,8 @@ out:
 	 * jumbo frames transmission.
 	 */
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 &&
-	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750) {
+	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
+	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) {
 		u32 phy_reg;
 
 		if (!tg3_readphy(tp, MII_TG3_EXT_CTRL, &phy_reg))
@@ -1068,7 +1071,8 @@ static int tg3_set_power_state(struct tg
 			mac_mode = MAC_MODE_PORT_MODE_TBI;
 		}
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750)
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
+		    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752)
 			tw32(MAC_LED_CTRL, tp->led_ctrl);
 
 		if (((power_caps & PCI_PM_CAP_PME_D3cold) &&
@@ -3967,7 +3971,8 @@ static int tg3_chip_reset(struct tg3 *tp
 		tg3_read_mem(tp, NIC_SRAM_DATA_CFG, &nic_cfg);
 		if (nic_cfg & NIC_SRAM_DATA_CFG_ASF_ENABLE) {
 			tp->tg3_flags |= TG3_FLAG_ENABLE_ASF;
-			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)
+			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+			    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 				tp->tg3_flags2 |= TG3_FLG2_ASF_NEW_HANDSHAKE;
 		}
 	}
@@ -5041,7 +5046,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 	tw32(GRC_MISC_CFG, val);
 
 	/* Initialize MBUF/DESC pool. */
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 		/* Do nothing.  */
 	} else if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
 		tw32(BUFMGR_MB_POOL_ADDR, NIC_SRAM_MBUF_POOL_BASE);
@@ -5240,7 +5246,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 		rdmac_mode |= RDMAC_MODE_SPLIT_ENABLE;
 	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 &&
 	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)) {
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)) {
 		if (tp->tg3_flags2 & TG3_FLG2_TSO_CAPABLE &&
 		    (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 ||
 		     tp->pci_chip_rev_id == CHIPREV_ID_5705_A2)) {
@@ -5355,7 +5362,8 @@ static int tg3_reset_hw(struct tg3 *tp)
 
 	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 &&
 	     tp->pci_chip_rev_id != CHIPREV_ID_5705_A0) ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	     GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)) {
 		if ((tp->tg3_flags & TG3_FLG2_TSO_CAPABLE) &&
 		    (tp->pci_chip_rev_id == CHIPREV_ID_5705_A1 ||
 		     tp->pci_chip_rev_id == CHIPREV_ID_5705_A2)) {
@@ -7028,7 +7036,8 @@ static void __devinit tg3_get_nvram_info
 		tw32(NVRAM_CFG1, nvcfg1);
 	}
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 		switch (nvcfg1 & NVRAM_CFG1_VENDOR_MASK) {
 			case FLASH_VENDOR_ATMEL_FLASH_BUFFERED:
 				tp->nvram_jedecnum = JEDEC_ATMEL;
@@ -7093,7 +7102,8 @@ static void __devinit tg3_nvram_init(str
 	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5701) {
 		tp->tg3_flags |= TG3_FLAG_NVRAM;
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7102,7 +7112,8 @@ static void __devinit tg3_nvram_init(str
 		tg3_get_nvram_info(tp);
 		tg3_get_nvram_size(tp);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7195,7 +7206,8 @@ static int tg3_nvram_read(struct tg3 *tp
 
 	tg3_nvram_lock(tp);
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 		u32 nvaccess = tr32(NVRAM_ACCESS);
 
 		tw32_f(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7210,7 +7222,8 @@ static int tg3_nvram_read(struct tg3 *tp
 
 	tg3_nvram_unlock(tp);
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 		u32 nvaccess = tr32(NVRAM_ACCESS);
 
 		tw32_f(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7438,7 +7451,8 @@ static int tg3_nvram_write_block(struct 
 
 		tg3_nvram_lock(tp);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7463,7 +7477,8 @@ static int tg3_nvram_write_block(struct 
 		grc_mode = tr32(GRC_MODE);
 		tw32(GRC_MODE, grc_mode & ~GRC_MODE_NVRAM_WR_ENABLE);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7581,7 +7596,8 @@ static int __devinit tg3_phy_probe(struc
 		} else
 			eeprom_phy_id = 0;
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) {
+		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
 			led_cfg = cfg2 & (NIC_SRAM_DATA_CFG_LED_MODE_MASK |
 				    SHASTA_EXT_LED_MODE_MASK);
 		} else
@@ -7634,7 +7650,8 @@ static int __devinit tg3_phy_probe(struc
 
 		if (nic_cfg & NIC_SRAM_DATA_CFG_ASF_ENABLE) {
 			tp->tg3_flags |= TG3_FLAG_ENABLE_ASF;
-			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)
+			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+			    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 				tp->tg3_flags2 |= TG3_FLG2_ASF_NEW_HANDSHAKE;
 		}
 		if (nic_cfg & NIC_SRAM_DATA_CFG_FIBER_WOL)
@@ -7932,10 +7949,12 @@ static int __devinit tg3_get_invariants(
 	tp->pci_bist         = (cacheline_sz_reg >> 24) & 0xff;
 
 	if ((GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705) ||
-	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750))
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750) ||
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752))
 		tp->tg3_flags2 |= TG3_FLG2_5705_PLUS;
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 		tp->tg3_flags2 |= TG3_FLG2_HW_TSO;
 
 	if (pci_find_capability(tp->pdev, PCI_CAP_ID_EXP) != 0)
@@ -8066,7 +8085,8 @@ static int __devinit tg3_get_invariants(
 		tp->tg3_flags2 |= TG3_FLG2_PHY_5704_A0_BUG;
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 		tp->tg3_flags2 |= TG3_FLG2_PHY_BER_BUG;
 
 	/* Only 5701 and later support tagged irq status mode.
@@ -8462,7 +8482,8 @@ static int __devinit tg3_test_dma(struct
 		tp->dma_rwctrl |= 0x00180000;
 	} else if (!(tp->tg3_flags & TG3_FLAG_PCIX_MODE)) {
 		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750)
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
+		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
 			tp->dma_rwctrl |= 0x003f0000;
 		else
 			tp->dma_rwctrl |= 0x003f000f;
