Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWJUWvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWJUWvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWJUWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 18:51:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:3284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422851AbWJUWuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 18:50:55 -0400
From: Andi Kleen <ak@suse.de>
References: <200610221250.493223000@suse.de>
In-Reply-To: <200610221250.493223000@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [2/2] x86_64: increase PHB1 split transaction timeout
Message-Id: <20061021225053.A213913B62@wotan.suse.de>
Date: Sun, 22 Oct 2006 00:50:53 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Muli Ben-Yehuda <muli@il.ibm.com>
This patch increases the timeout for PCI split transactions on PHB1 on
the first Calgary to work around an issue with the aic94xx
adapter. Fixes kernel.org bugzilla #7180
(http://bugzilla.kernel.org/show_bug.cgi?id=7180)

Based on excellent debugging and a patch by Darrick J. Wong
<djwong@us.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Andi Kleen <ak@suse.de>
Acked-by: Darrick J. Wong <djwong@us.ibm.com>

---
 arch/x86_64/kernel/pci-calgary.c |   44 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -52,7 +52,8 @@
 #define ONE_BASED_CHASSIS_NUM   1
 
 /* register offsets inside the host bridge space */
-#define PHB_CSR_OFFSET		0x0110
+#define CALGARY_CONFIG_REG	0x0108
+#define PHB_CSR_OFFSET		0x0110 /* Channel Status */
 #define PHB_PLSSR_OFFSET	0x0120
 #define PHB_CONFIG_RW_OFFSET	0x0160
 #define PHB_IOBASE_BAR_LOW	0x0170
@@ -83,6 +84,8 @@
 #define TAR_VALID		0x0000000000000008UL
 /* CSR (Channel/DMA Status Register) */
 #define CSR_AGENT_MASK		0xffe0ffff
+/* CCR (Calgary Configuration Register) */
+#define CCR_2SEC_TIMEOUT        0x000000000000000EUL
 
 #define MAX_NUM_OF_PHBS		8 /* how many PHBs in total? */
 #define MAX_NUM_CHASSIS		8 /* max number of chassis */
@@ -732,6 +735,38 @@ static void calgary_watchdog(unsigned lo
 	}
 }
 
+static void __init calgary_increase_split_completion_timeout(void __iomem *bbar,
+	unsigned char busnum)
+{
+	u64 val64;
+	void __iomem *target;
+	unsigned long phb_shift = -1;
+	u64 mask;
+
+	switch (busno_to_phbid(busnum)) {
+	case 0: phb_shift = (63 - 19);
+		break;
+	case 1: phb_shift = (63 - 23);
+		break;
+	case 2: phb_shift = (63 - 27);
+		break;
+	case 3: phb_shift = (63 - 35);
+		break;
+	default:
+		BUG_ON(busno_to_phbid(busnum));
+	}
+
+	target = calgary_reg(bbar, CALGARY_CONFIG_REG);
+	val64 = be64_to_cpu(readq(target));
+
+	/* zero out this PHB's timer bits */
+	mask = ~(0xFUL << phb_shift);
+	val64 &= mask;
+	val64 |= (CCR_2SEC_TIMEOUT << phb_shift);
+	writeq(cpu_to_be64(val64), target);
+	readq(target); /* flush */
+}
+
 static void __init calgary_enable_translation(struct pci_dev *dev)
 {
 	u32 val32;
@@ -756,6 +791,13 @@ static void __init calgary_enable_transl
 	writel(cpu_to_be32(val32), target);
 	readl(target); /* flush */
 
+	/*
+	 * Give split completion a longer timeout on bus 1 for aic94xx
+	 * http://bugzilla.kernel.org/show_bug.cgi?id=7180
+	 */
+	if (busnum == 1)
+		calgary_increase_split_completion_timeout(bbar, busnum);
+
 	init_timer(&tbl->watchdog_timer);
 	tbl->watchdog_timer.function = &calgary_watchdog;
 	tbl->watchdog_timer.data = (unsigned long)dev;
