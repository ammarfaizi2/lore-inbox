Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbUKQXuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUKQXuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUKQWEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:04:02 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:12548 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262600AbUKQVEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:04:51 -0500
Date: Wed, 17 Nov 2004 16:01:22 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.10-rc2] 3c59x: reload EEPROM values at rmmod for needy cards
Message-ID: <20041117160122.A4824@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	jgarzik@pobox.com, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable reload of EEPROM values in reset at rmmod for cards that need
it, similar to old EEPROM_NORESET flag but in reverse.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
3c905 cards need an additional bit unmasked in the reset at rmmod or
else they don't get reinitialized properly when the driver is reloaded.

This is a repost -- the previous patch appears to have been lost
in the shuffle.  This is the combination of the two patches posted
previously regarding EEPROM_NORESET.

 drivers/net/3c59x.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- 3c59x-reset-2.6/drivers/net/3c59x.c.orig
+++ 3c59x-reset-2.6/drivers/net/3c59x.c
@@ -417,7 +417,7 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
 	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000,
-	EXTRA_PREAMBLE=0x8000, };
+	EXTRA_PREAMBLE=0x8000, EEPROM_RESET=0x10000, };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -505,9 +505,9 @@ static struct vortex_chip_info {
 	{"3c900B-FL Cyclone 10base-FL",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905 Boomerang 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905 Boomerang 100baseT4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905B Cyclone 100baseTx",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 
@@ -3169,7 +3169,8 @@ static void __devexit vortex_remove_one 
 			pci_restore_state(VORTEX_PCI(vp));
 	}
 	/* Should really use issue_and_wait() here */
-	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
+	outw(TotalReset | ((vp->drv_flags & EEPROM_RESET) ? 0x04 : 0x14),
+	     dev->base_addr + EL3_CMD);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
