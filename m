Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVDNAHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVDNAHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDMXuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:50:05 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35848 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261235AbVDMXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:54 -0400
Date: Wed, 13 Apr 2005 19:38:45 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 6/10] tg3: use new TG3_FLG2_5750_PLUS flag
Message-ID: <04132005193845.8656@laptop>
In-Reply-To: <04132005193845.8597@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a number of two-way if statements checking for 5750, and/or
5752 to reference the newly-defined TG3_FLG2_5750_PLUS flag instead.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |   38 +++++++++++++-------------------------
 1 files changed, 13 insertions(+), 25 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 17:57:50.096149244 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 17:57:10.716485067 -0400
@@ -1067,8 +1067,7 @@ static int tg3_set_power_state(struct tg
 			mac_mode = MAC_MODE_PORT_MODE_TBI;
 		}
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
-		    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752)
+		if (!(tp->tg3_flags2 & TG3_FLG2_5750_PLUS))
 			tw32(MAC_LED_CTRL, tp->led_ctrl);
 
 		if (((power_caps & PCI_PM_CAP_PME_D3cold) &&
@@ -3967,8 +3966,7 @@ static int tg3_chip_reset(struct tg3 *tp
 		tg3_read_mem(tp, NIC_SRAM_DATA_CFG, &nic_cfg);
 		if (nic_cfg & NIC_SRAM_DATA_CFG_ASF_ENABLE) {
 			tp->tg3_flags |= TG3_FLAG_ENABLE_ASF;
-			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-			    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+			if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS)
 				tp->tg3_flags2 |= TG3_FLG2_ASF_NEW_HANDSHAKE;
 		}
 	}
@@ -5042,8 +5040,7 @@ static int tg3_reset_hw(struct tg3 *tp)
 	tw32(GRC_MISC_CFG, val);
 
 	/* Initialize MBUF/DESC pool. */
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 		/* Do nothing.  */
 	} else if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705) {
 		tw32(BUFMGR_MB_POOL_ADDR, NIC_SRAM_MBUF_POOL_BASE);
@@ -7032,8 +7029,7 @@ static void __devinit tg3_get_nvram_info
 		tw32(NVRAM_CFG1, nvcfg1);
 	}
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 		switch (nvcfg1 & NVRAM_CFG1_VENDOR_MASK) {
 			case FLASH_VENDOR_ATMEL_FLASH_BUFFERED:
 				tp->nvram_jedecnum = JEDEC_ATMEL;
@@ -7098,8 +7094,7 @@ static void __devinit tg3_nvram_init(str
 	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5701) {
 		tp->tg3_flags |= TG3_FLAG_NVRAM;
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+		if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7108,8 +7103,7 @@ static void __devinit tg3_nvram_init(str
 		tg3_get_nvram_info(tp);
 		tg3_get_nvram_size(tp);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+		if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7202,8 +7196,7 @@ static int tg3_nvram_read(struct tg3 *tp
 
 	tg3_nvram_lock(tp);
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 		u32 nvaccess = tr32(NVRAM_ACCESS);
 
 		tw32_f(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7218,8 +7211,7 @@ static int tg3_nvram_read(struct tg3 *tp
 
 	tg3_nvram_unlock(tp);
 
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+	if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 		u32 nvaccess = tr32(NVRAM_ACCESS);
 
 		tw32_f(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7447,8 +7439,7 @@ static int tg3_nvram_write_block(struct 
 
 		tg3_nvram_lock(tp);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+		if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess | ACCESS_ENABLE);
@@ -7473,8 +7464,7 @@ static int tg3_nvram_write_block(struct 
 		grc_mode = tr32(GRC_MODE);
 		tw32(GRC_MODE, grc_mode & ~GRC_MODE_NVRAM_WR_ENABLE);
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+		if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS) {
 			u32 nvaccess = tr32(NVRAM_ACCESS);
 
 			tw32(NVRAM_ACCESS, nvaccess & ~ACCESS_ENABLE);
@@ -7592,11 +7582,10 @@ static int __devinit tg3_phy_probe(struc
 		} else
 			eeprom_phy_id = 0;
 
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752) {
+		if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS)
 			led_cfg = cfg2 & (NIC_SRAM_DATA_CFG_LED_MODE_MASK |
 				    SHASTA_EXT_LED_MODE_MASK);
-		} else
+		else
 			led_cfg = nic_cfg & NIC_SRAM_DATA_CFG_LED_MODE_MASK;
 
 		switch (led_cfg) {
@@ -7646,8 +7635,7 @@ static int __devinit tg3_phy_probe(struc
 
 		if (nic_cfg & NIC_SRAM_DATA_CFG_ASF_ENABLE) {
 			tp->tg3_flags |= TG3_FLAG_ENABLE_ASF;
-			if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-			    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+			if (tp->tg3_flags2 & TG3_FLG2_5750_PLUS)
 				tp->tg3_flags2 |= TG3_FLG2_ASF_NEW_HANDSHAKE;
 		}
 		if (nic_cfg & NIC_SRAM_DATA_CFG_FIBER_WOL)
