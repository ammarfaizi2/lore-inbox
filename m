Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWFNWWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWFNWWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFNWWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:22:13 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:16189 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932415AbWFNWWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:22:11 -0400
Message-ID: <44909A3F.4090905@oracle.com>
Date: Wed, 14 Jun 2006 16:22:39 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
CC: mb@bu3sch.de, akpm <akpm@osdl.org>
Subject: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Broadcom wireless patch, PCIE/Mactel support

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc

This patch adds support for PCIE cores to the bcm43xx driver. This is
needed for wireless to work on the Intel imacs. I've submitted it to
bcm43xx upstream.

(cherry picked from d88edf6a433074323a1805365a8dfc9c26fceae3 commit)
(cherry picked from 7dbd83ed3255fde4371edcbb6ad1d30f3e6ddf08 commit)
---

--- a/drivers/net/wireless/bcm43xx/bcm43xx.h
+++ b/drivers/net/wireless/bcm43xx/bcm43xx.h
@@ -202,6 +202,8 @@
 #define BCM43xx_COREID_USB20_HOST       0x819
 #define BCM43xx_COREID_USB20_DEV        0x81a
 #define BCM43xx_COREID_SDIO_HOST        0x81b
+#define BCM43xx_COREID_PCIE		0x820
+#define BCM43xx_COREID_CHIPCOMMON_NEW	0x900
 
 /* Core Information Registers */
 #define BCM43xx_CIR_BASE		0xf00
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -130,6 +130,8 @@ MODULE_PARM_DESC(fwpostfix, "Postfix for
 	{ PCI_VENDOR_ID_BROADCOM, 0x4301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	/* Broadcom 4307 802.11b */
 	{ PCI_VENDOR_ID_BROADCOM, 0x4307, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	/* Broadcom 4312 80211a/b/g */
+	{ PCI_VENDOR_ID_BROADCOM, 0x4312, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	/* Broadcom 4318 802.11b/g */
 	{ PCI_VENDOR_ID_BROADCOM, 0x4318, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	/* Broadcom 4319 802.11a/b/g */
@@ -2580,7 +2582,8 @@ static int bcm43xx_probe_cores(struct bc
 	core_vendor = (sb_id_hi & 0xFFFF0000) >> 16;
 
 	/* if present, chipcommon is always core 0; read the chipid from it */
-	if (core_id == BCM43xx_COREID_CHIPCOMMON) {
+	if (core_id == BCM43xx_COREID_CHIPCOMMON || 
+	    core_id == BCM43xx_COREID_CHIPCOMMON_NEW) {
 		chip_id_32 = bcm43xx_read32(bcm, 0);
 		chip_id_16 = chip_id_32 & 0xFFFF;
 		bcm->core_chipcommon.available = 1;
@@ -2614,7 +2617,8 @@ static int bcm43xx_probe_cores(struct bc
 
 	/* ChipCommon with Core Rev >=4 encodes number of cores,
 	 * otherwise consult hardcoded table */
-	if ((core_id == BCM43xx_COREID_CHIPCOMMON) && (core_rev >= 4)) {
+	if (((core_id == BCM43xx_COREID_CHIPCOMMON) && (core_rev >= 4)) ||
+	     core_id == BCM43xx_COREID_CHIPCOMMON_NEW) {
 		core_count = (chip_id_32 & 0x0F000000) >> 24;
 	} else {
 		switch (chip_id_16) {
@@ -2686,6 +2690,7 @@ static int bcm43xx_probe_cores(struct bc
 		core = NULL;
 		switch (core_id) {
 		case BCM43xx_COREID_PCI:
+		case BCM43xx_COREID_PCIE:
 			core = &bcm->core_pci;
 			if (core->available) {
 				printk(KERN_WARNING PFX "Multiple PCI cores found.\n");
@@ -2724,6 +2729,7 @@ static int bcm43xx_probe_cores(struct bc
 			case 6:
 			case 7:
 			case 9:
+			case 10:
 				break;
 			default:
 				printk(KERN_ERR PFX "Error: Unsupported 80211 core revision %u\n",
@@ -3002,7 +3008,7 @@ static int bcm43xx_setup_backplane_pci_c
 	if (err)
 		goto out;
 
-	if (bcm->core_pci.rev < 6) {
+	if (bcm->core_pci.rev < 6 && bcm->core_pci.id != BCM43xx_COREID_PCIE) {
 		value = bcm43xx_read32(bcm, BCM43xx_CIR_SBINTVEC);
 		value |= (1 << backplane_flag_nr);
 		bcm43xx_write32(bcm, BCM43xx_CIR_SBINTVEC, value);
@@ -3024,7 +3030,7 @@ static int bcm43xx_setup_backplane_pci_c
 	value |= BCM43xx_SBTOPCI2_PREFETCH | BCM43xx_SBTOPCI2_BURST;
 	bcm43xx_write32(bcm, BCM43xx_PCICORE_SBTOPCI2, value);
 
-	if (bcm->core_pci.rev < 5) {
+	if (bcm->core_pci.rev < 5 && bcm->core_pci.id != BCM43xx_COREID_PCIE) {
 		value = bcm43xx_read32(bcm, BCM43xx_CIR_SBIMCONFIGLOW);
 		value |= (2 << BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_SHIFT)
 			 & BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_MASK;
@@ -3351,7 +3357,7 @@ static int bcm43xx_read_phyinfo(struct b
 		bcm->ieee->freq_band = IEEE80211_24GHZ_BAND;
 		break;
 	case BCM43xx_PHYTYPE_G:
-		if (phy_rev > 7)
+		if (phy_rev > 8)
 			phy_rev_ok = 0;
 		bcm->ieee->modulation = IEEE80211_OFDM_MODULATION |
 					IEEE80211_CCK_MODULATION;

