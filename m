Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270046AbUJHSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270046AbUJHSPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJHSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:15:16 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:52235 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270046AbUJHRmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:42:21 -0400
Date: Fri, 8 Oct 2004 12:39:55 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, akpm@osdl.org, jgarzik@pobox.com,
       Donald Becker <becker@scyld.com>
Subject: [patch 2.6.9-rc3] 3c59x: reload EEPROM values at rmmod for needy cards
Message-ID: <20041008123955.E14378@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	akpm@osdl.org, jgarzik@pobox.com, Donald Becker <becker@scyld.com>
References: <20040928145455.C12480@tuxdriver.com> <Pine.LNX.4.44.0409291253510.1746-100000@training.scyld.com> <20040930091407.A10417@tuxdriver.com> <20041007134601.B29517@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041007134601.B29517@tuxdriver.com>; from linville@tuxdriver.com on Thu, Oct 07, 2004 at 01:46:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable reload of EEPROM values in reset at rmmod for cards that need
it, similar to old EEPROM_NORESET flag but in reverse.

Signed-of-by: John W. Linville <linville@tuxdriver.com>
---
(Most?) 3c905 and (some?) 3c905B cards need an additional bit unmasked
in the reset at rmmod or else they don't get reinitialized properly when
the driver is reloaded.

 drivers/net/3c59x.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

I didn't get any guidance on which way to go, so I decided to try the
version which I thought would be least offensive and see if it gets
shot-down... :-)

--- linux-2.6/drivers/net/3c59x.c.orig
+++ linux-2.6/drivers/net/3c59x.c
@@ -416,7 +416,7 @@ enum {	IS_VORTEX=1, IS_BOOMERANG=2, IS_C
 	HAS_PWR_CTRL=0x20, HAS_MII=0x40, HAS_NWAY=0x80, HAS_CB_FNS=0x100,
 	INVERT_MII_PWR=0x200, INVERT_LED_PWR=0x400, MAX_COLLISION_RESET=0x800,
 	EEPROM_OFFSET=0x1000, HAS_HWCKSM=0x2000, WNO_XCVR_PWR=0x4000,
-	EXTRA_PREAMBLE=0x8000, };
+	EXTRA_PREAMBLE=0x8000, EEPROM_RESET=0x10000, };
 
 enum vortex_chips {
 	CH_3C590 = 0,
@@ -504,16 +504,16 @@ static struct vortex_chip_info {
 	{"3c900B-FL Cyclone 10base-FL",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905 Boomerang 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905 Boomerang 100baseT4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905B Cyclone 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE|EEPROM_RESET, 128, },
 
 	{"3c905B Cyclone 10/100/BNC",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EEPROM_RESET, 128, },
 	{"3c905B-FX Cyclone 100baseFx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM|EEPROM_RESET, 128, },
 	{"3c905C Tornado",
 	PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM (ATI Radeon 9100 IGP)",
@@ -564,7 +564,7 @@ static struct vortex_chip_info {
 	{"3c982 Hydra Dual Port B",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
 	{"3c905B-T4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE|EEPROM_RESET, 128, },
 	{"3c920B-EMB-WNM Tornado",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 
@@ -3169,7 +3169,8 @@ static void __devexit vortex_remove_one 
 			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 	/* Should really use issue_and_wait() here */
-	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
+	outw(TotalReset | ((vp->drv_flags & EEPROM_RESET) ? 0x04 : 0x14),
+	     dev->base_addr + EL3_CMD);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
