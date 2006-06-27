Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWF0QnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWF0QnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWF0QnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:43:12 -0400
Received: from mail.suse.de ([195.135.220.2]:24022 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161178AbWF0QhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:13 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/17] [PATCH] 64bit resource: fix up printks for resources in networks drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:39 -0700
Message-Id: <115142604066-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260373971-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/3c59x.c            |    6 ++++--
 drivers/net/8139cp.c           |    9 +++++----
 drivers/net/8139too.c          |    6 +++---
 drivers/net/e100.c             |    4 ++--
 drivers/net/skge.c             |    4 ++--
 drivers/net/sky2.c             |    6 +++---
 drivers/net/tulip/de2104x.c    |    9 +++++----
 drivers/net/tulip/tulip_core.c |    6 +++---
 drivers/net/typhoon.c          |    5 +++--
 drivers/net/wan/dscc4.c        |   12 ++++++------
 drivers/net/wan/pc300_drv.c    |    4 ++--
 11 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/3c59x.c b/drivers/net/3c59x.c
index e277789..c735c4d 100644
--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -1408,8 +1408,10 @@ static int __devinit vortex_probe1(struc
 		}
 
 		if (print_info) {
-			printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
-				print_name, pci_resource_start(pdev, 2),
+			printk(KERN_INFO "%s: CardBus functions mapped "
+				"%16.16llx->%p\n",
+				print_name,
+				(unsigned long long)pci_resource_start(pdev, 2),
 				vp->cb_fn_base);
 		}
 		EL3WINDOW(2);
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index 0cdc830..c1e1dc5 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1883,8 +1883,8 @@ #endif
 	}
 	if (pci_resource_len(pdev, 1) < CP_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -1916,8 +1916,9 @@ #endif
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%llx) on pci dev %s\n",
+			(unsigned long long)pci_resource_len(pdev, 1),
+			(unsigned long long)pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index abd6261..ed2e3c0 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -1341,9 +1341,9 @@ static int rtl8139_open (struct net_devi
 	netif_start_queue (dev);
 
 	if (netif_msg_ifup(tp))
-		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#lx IRQ %d"
-			" GP Pins %2.2x %s-duplex.\n",
-			dev->name, pci_resource_start (tp->pci_dev, 1),
+		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#llx IRQ %d"
+			" GP Pins %2.2x %s-duplex.\n", dev->name,
+			(unsigned long long)pci_resource_start (tp->pci_dev, 1),
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->mii.full_duplex ? "full" : "half");
 
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index f37170c..93a2865 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2678,9 +2678,9 @@ #endif
 		goto err_out_free;
 	}
 
-	DPRINTK(PROBE, INFO, "addr 0x%lx, irq %d, "
+	DPRINTK(PROBE, INFO, "addr 0x%llx, irq %d, "
 		"MAC addr %02X:%02X:%02X:%02X:%02X:%02X\n",
-		pci_resource_start(pdev, 0), pdev->irq,
+		(unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 		netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
 		netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
 
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 19a4a16..1608efa 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3354,8 +3354,8 @@ #endif
 	if (err)
 		goto err_out_free_irq;
 
-	printk(KERN_INFO PFX DRV_VERSION " addr 0x%lx irq %d chip %s rev %d\n",
-	       pci_resource_start(pdev, 0), pdev->irq,
+	printk(KERN_INFO PFX DRV_VERSION " addr 0x%llx irq %d chip %s rev %d\n",
+	       (unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 	       skge_board_name(hw), hw->chip_rev);
 
 	if ((dev = skge_devinit(hw, 0, using_dac)) == NULL)
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index d357787..e122007 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -3311,9 +3311,9 @@ #endif
 	if (err)
 		goto err_out_iounmap;
 
-	printk(KERN_INFO PFX "v%s addr 0x%lx irq %d Yukon-%s (0x%x) rev %d\n",
-	       DRV_VERSION, pci_resource_start(pdev, 0), pdev->irq,
-	       yukon2_name[hw->chip_id - CHIP_ID_YUKON_XL],
+	printk(KERN_INFO PFX "v%s addr 0x%llx irq %d Yukon-%s (0x%x) rev %d\n",
+	       DRV_VERSION, (unsigned long long)pci_resource_start(pdev, 0),
+	       pdev->irq, yukon2_name[hw->chip_id - CHIP_ID_YUKON_XL],
 	       hw->chip_id, hw->chip_rev);
 
 	dev = sky2_init_netdev(hw, 0, using_dac);
diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index 5f743b9..fc2468e 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -2007,8 +2007,8 @@ #endif
 	}
 	if (pci_resource_len(pdev, 1) < DE_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -2016,8 +2016,9 @@ #endif
 	regs = ioremap_nocache(pciaddr, DE_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%lx) on pci dev %s\n",
+			(unsigned long long)pci_resource_len(pdev, 1),
+			pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index e0de667..53fd9b5 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1350,10 +1350,10 @@ #endif
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
-		printk (KERN_ERR PFX "%s: I/O region (0x%lx@0x%lx) too small, "
+		printk (KERN_ERR PFX "%s: I/O region (0x%llx@0x%llx) too small, "
 			"aborting\n", pci_name(pdev),
-			pci_resource_len (pdev, 0),
-			pci_resource_start (pdev, 0));
+			(unsigned long long)pci_resource_len (pdev, 0),
+			(unsigned long long)pci_resource_start (pdev, 0));
 		goto err_out_free_netdev;
 	}
 
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index e49e8b5..e24d2da 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -2568,9 +2568,10 @@ typhoon_init_one(struct pci_dev *pdev, c
 
 	pci_set_drvdata(pdev, dev);
 
-	printk(KERN_INFO "%s: %s at %s 0x%lx, ",
+	printk(KERN_INFO "%s: %s at %s 0x%llx, ",
 	       dev->name, typhoon_card_info[card_id].name,
-	       use_mmio ? "MMIO" : "IO", pci_resource_start(pdev, use_mmio));
+	       use_mmio ? "MMIO" : "IO",
+	       (unsigned long long)pci_resource_start(pdev, use_mmio));
 	for(i = 0; i < 5; i++)
 		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x\n", dev->dev_addr[i]);
diff --git a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
index 4505540..04a376e 100644
--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -732,15 +732,15 @@ static int __devinit dscc4_init_one(stru
 	ioaddr = ioremap(pci_resource_start(pdev, 0),
 					pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk(KERN_ERR "%s: cannot remap MMIO region %lx @ %lx\n",
-			DRV_NAME, pci_resource_len(pdev, 0),
-			pci_resource_start(pdev, 0));
+		printk(KERN_ERR "%s: cannot remap MMIO region %llx @ %llx\n",
+			DRV_NAME, (unsigned long long)pci_resource_len(pdev, 0),
+			(unsigned long long)pci_resource_start(pdev, 0));
 		rc = -EIO;
 		goto err_free_mmio_regions_2;
 	}
-	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#lx (regs), %#lx (lbi), IRQ %d\n",
-	        pci_resource_start(pdev, 0),
-	        pci_resource_start(pdev, 1), pdev->irq);
+	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#llx (regs), %#llx (lbi), IRQ %d\n",
+	        (unsigned long long)pci_resource_start(pdev, 0),
+	        (unsigned long long)pci_resource_start(pdev, 1), pdev->irq);
 
 	/* Cf errata DS5 p.2 */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xf8);
diff --git a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
index a3e65d1..d7897ae 100644
--- a/drivers/net/wan/pc300_drv.c
+++ b/drivers/net/wan/pc300_drv.c
@@ -3445,9 +3445,9 @@ #endif
 
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
-		printk("PC300 found at RAM 0x%08lx, "
+		printk("PC300 found at RAM 0x%016llx, "
 		       "but could not allocate card structure.\n",
-		       pci_resource_start(pdev, 3));
+		       (unsigned long long)pci_resource_start(pdev, 3));
 		err = -ENOMEM;
 		goto err_disable_dev;
 	}
-- 
1.4.0

