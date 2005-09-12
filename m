Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVILO4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVILO4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVILOzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:55:52 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3591 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751286AbVILOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:55:48 -0400
Date: Mon, 12 Sep 2005 10:48:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13] 3c59x: enable use of memory-mapped PCI I/O
Message-ID: <09122005104852.31405@bilbo.tuxdriver.com>
In-Reply-To: <20050906161330.0138f5a2.akpm@osdl.org>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add capability for 3c59x driver to use memory-mapped PCI I/O
resources. This may improve performance for those devices so
equipped. This will be the default behaviour for IS_CYCLONE
and IS_TORNADO devices. Additionally, it can be enabled/disabled
individually for up to MAX_UNITS number of devices via the use_mmio
module option or for all units via the global_use_mmio option. The
use_mmio option overrides the global_use_mmio option for those
devices specified.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/3c59x.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -908,9 +908,11 @@ static int full_duplex[MAX_UNITS] = {-1,
 static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int use_mmio[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int global_options = -1;
 static int global_full_duplex = -1;
 static int global_enable_wol = -1;
+static int global_use_mmio = -1;
 
 /* #define dev_alloc_skb dev_alloc_skb_debug */
 
@@ -935,6 +937,8 @@ module_param(compaq_ioaddr, int, 0);
 module_param(compaq_irq, int, 0);
 module_param(compaq_device_id, int, 0);
 module_param(watchdog, int, 0);
+module_param(global_use_mmio, int, 0);
+module_param_array(use_mmio, int, NULL, 0);
 MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
 MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
@@ -950,6 +954,8 @@ MODULE_PARM_DESC(compaq_ioaddr, "3c59x P
 MODULE_PARM_DESC(compaq_irq, "3c59x PCI IRQ number (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(compaq_device_id, "3c59x PCI device ID (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(watchdog, "3c59x transmit timeout in milliseconds");
+MODULE_PARM_DESC(global_use_mmio, "3c59x: same as use_mmio, but applies to all NICs if options is unset");
+MODULE_PARM_DESC(use_mmio, "3c59x: use memory-mapped PCI I/O resource (0-1)");
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_vortex(struct net_device *dev)
@@ -1109,15 +1115,32 @@ static int __init vortex_eisa_init (void
 static int __devinit vortex_init_one (struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
-	int rc;
+	int rc, unit, pci_bar;
+	struct vortex_chip_info *vci;
+	void __iomem *ioaddr;
 
 	/* wake up and enable device */		
 	rc = pci_enable_device (pdev);
 	if (rc < 0)
 		goto out;
 
-	rc = vortex_probe1 (&pdev->dev, pci_iomap(pdev, 0, 0),
-			    pdev->irq, ent->driver_data, vortex_cards_found);
+	unit = vortex_cards_found;
+
+	if (global_use_mmio < 0 && (unit >= MAX_UNITS || use_mmio[unit] < 0)) {
+		/* Determine the default if the user didn't override us */
+		vci = &vortex_info_tbl[ent->driver_data];
+		pci_bar = vci->drv_flags & (IS_CYCLONE | IS_TORNADO) ? 1 : 0;
+	} else if (unit < MAX_UNITS && use_mmio[unit] >= 0) 
+		pci_bar = use_mmio[unit] ? 1 : 0;
+	else
+		pci_bar = global_use_mmio ? 1 : 0;
+
+	ioaddr = pci_iomap(pdev, pci_bar, 0);
+	if (!ioaddr) /* If mapping fails, fall-back to BAR 0... */
+		ioaddr = pci_iomap(pdev, 0, 0);
+
+	rc = vortex_probe1(&pdev->dev, ioaddr, pdev->irq,
+			   ent->driver_data, unit);
 	if (rc < 0) {
 		pci_disable_device (pdev);
 		goto out;
