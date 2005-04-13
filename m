Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVDMXsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVDMXsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDMXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:48:53 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:34824 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261217AbVDMXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:54 -0400
Date: Wed, 13 Apr 2005 19:38:44 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 4/10] tg3: use TG3_FLG2_5705_PLUS instead of multi-way if's
Message-ID: <04132005193844.8539@laptop>
In-Reply-To: <04132005193844.8474@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a number of three-way if statements checking for 5705, 5750,
and 5752 to reference the equivalent TG3_FLG2_5705_PLUS flag instead.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/tg3.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 17:42:28.059553796 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 17:42:16.584131525 -0400
@@ -85,9 +85,7 @@
 /* hardware minimum and maximum for a single frame's data payload */
 #define TG3_MIN_MTU			60
 #define TG3_MAX_MTU(tp)	\
-	((GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 && \
-	  GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 && \
-	  GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) ? 9000 : 1500)
+	(!(tp->tg3_flags2 & TG3_FLG2_5705_PLUS) ? 9000 : 1500)
 
 /* These numbers seem to be hard coded in the NIC firmware somehow.
  * You can't change the ring sizes, but you can change where you place
@@ -863,9 +861,7 @@ out:
 	if ((tp->phy_id & PHY_ID_MASK) == PHY_ID_BCM5401) {
 		/* Cannot do read-modify-write on 5401 */
 		tg3_writephy(tp, MII_TG3_AUX_CTRL, 0x4c20);
-	} else if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 &&
-		   GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
-		   GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) {
+	} else if (!(tp->tg3_flags2 & TG3_FLG2_5705_PLUS)) {
 		u32 phy_reg;
 
 		/* Set bit 14 with read-modify-write to preserve other bits */
@@ -877,9 +873,7 @@ out:
 	/* Set phy register 0x10 bit 0 to high fifo elasticity to support
 	 * jumbo frames transmission.
 	 */
-	if (GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5705 &&
-	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5750 &&
-	    GET_ASIC_REV(tp->pci_chip_rev_id) != ASIC_REV_5752) {
+	if (!(tp->tg3_flags2 & TG3_FLG2_5705_PLUS)) {
 		u32 phy_reg;
 
 		if (!tg3_readphy(tp, MII_TG3_EXT_CTRL, &phy_reg))
@@ -8483,9 +8477,7 @@ static int __devinit tg3_test_dma(struct
 		/* DMA read watermark not used on PCIE */
 		tp->dma_rwctrl |= 0x00180000;
 	} else if (!(tp->tg3_flags & TG3_FLAG_PCIX_MODE)) {
-		if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5705 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 ||
-		    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5752)
+		if (tp->tg3_flags2 & TG3_FLG2_5705_PLUS)
 			tp->dma_rwctrl |= 0x003f0000;
 		else
 			tp->dma_rwctrl |= 0x003f000f;
