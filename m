Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVIFUug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVIFUug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVIFUug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:50:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:52996 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750918AbVIFUuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:50:35 -0400
Date: Tue, 6 Sep 2005 16:44:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [patch 2.6.13 2/2] 3c59x: add option for using memory-mapped PCI I/O resources
Message-ID: <20050906204400.GD20145@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	akpm@osdl.org, jgarzik@pobox.com
References: <20050906204147.GC20145@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906204147.GC20145@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add module option to enable 3c59x driver to use memory-mapped PCI I/O
resources.  This may improve performance for those devices so equipped.

Add "use_mmio=1" to the 3c59x module options in order to enable this
functionality.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Ideally this option will eventually go away.  First we need a good list
of which devices "work" and which ones do not.

 drivers/net/3c59x.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -918,6 +918,9 @@ static int global_enable_wol = -1;
 static int compaq_ioaddr, compaq_irq, compaq_device_id = 0x5900;
 static struct net_device *compaq_net_device;
 
+/* Flag to enable use of memory-mapped PCI I/O resource */
+static int use_mmio;
+
 static int vortex_cards_found;
 
 module_param(debug, int, 0);
@@ -935,6 +938,7 @@ module_param(compaq_ioaddr, int, 0);
 module_param(compaq_irq, int, 0);
 module_param(compaq_device_id, int, 0);
 module_param(watchdog, int, 0);
+module_param(use_mmio, int, 0);
 MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
 MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
@@ -950,6 +954,7 @@ MODULE_PARM_DESC(compaq_ioaddr, "3c59x P
 MODULE_PARM_DESC(compaq_irq, "3c59x PCI IRQ number (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(compaq_device_id, "3c59x PCI device ID (Compaq BIOS problem workaround)");
 MODULE_PARM_DESC(watchdog, "3c59x transmit timeout in milliseconds");
+MODULE_PARM_DESC(use_mmio, "3c59x: use memory-mapped PCI I/O resource");
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_vortex(struct net_device *dev)
@@ -1093,14 +1098,16 @@ static int __init vortex_eisa_init (void
 static int __devinit vortex_init_one (struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
-	int rc;
+	int rc, pci_bar;
 
 	/* wake up and enable device */		
 	rc = pci_enable_device (pdev);
 	if (rc < 0)
 		goto out;
 
-	rc = vortex_probe1 (&pdev->dev, pci_iomap(pdev, 0, 0),
+	pci_bar = use_mmio ? 1 : 0;
+
+	rc = vortex_probe1 (&pdev->dev, pci_iomap(pdev, pci_bar, 0),
 			    pdev->irq, ent->driver_data, vortex_cards_found);
 	if (rc < 0) {
 		pci_disable_device (pdev);
-- 
John W. Linville
linville@tuxdriver.com
