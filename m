Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWF0Ovu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWF0Ovu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWF0Ovu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:51:50 -0400
Received: from havoc.gtf.org ([69.61.125.42]:33258 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030643AbWF0Ovr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:51:47 -0400
Date: Tue, 27 Jun 2006 10:51:45 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use dev_printk() in some net drivers
Message-ID: <20060627145145.GA30053@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit 25a0324ef1c1b181c9d00f09837e8757875ee2a4
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jun 27 10:47:51 2006 -0400

    [netdrvr] Use dev_printk() when ethernet interface isn't available

    For messages prior to register_netdev(), prefer dev_printk() because
    that prints out both our driver name and our [PCI | whatever] bus id.

    Updates: 8139{cp,too}, b44, bnx2, cassini, {eepro,epic}100, fealnx,
         hamachi, ne2k-pci, ns83820, pci-skeleton, r8169.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/net/8139cp.c       |   36 +++++++++++++++++++++---------------
 drivers/net/8139too.c      |   41 +++++++++++++++++++++++++----------------
 drivers/net/b44.c          |   28 +++++++++++++++-------------
 drivers/net/bnx2.c         |   37 ++++++++++++++++++++++---------------
 drivers/net/cassini.c      |   20 ++++++++++----------
 drivers/net/eepro100.c     |    8 +++++---
 drivers/net/epic100.c      |   23 ++++++++++++-----------
 drivers/net/fealnx.c       |   17 +++++++++--------
 drivers/net/hamachi.c      |    3 ++-
 drivers/net/ne2k-pci.c     |   12 ++++++++----
 drivers/net/ns83820.c      |   14 +++++++++-----
 drivers/net/pci-skeleton.c |   24 +++++++++++++++---------
 drivers/net/r8169.c        |   43 +++++++++++++++++++------------------------
 13 files changed, 172 insertions(+), 134 deletions(-)

25a0324ef1c1b181c9d00f09837e8757875ee2a4
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index 0cdc830..c38e352 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1837,9 +1837,11 @@ #endif
 
 	if (pdev->vendor == PCI_VENDOR_ID_REALTEK &&
 	    pdev->device == PCI_DEVICE_ID_REALTEK_8139 && pci_rev < 0x20) {
-		printk(KERN_ERR PFX "pci dev %s (id %04x:%04x rev %02x) is not an 8139C+ compatible chip\n",
-		       pci_name(pdev), pdev->vendor, pdev->device, pci_rev);
-		printk(KERN_ERR PFX "Try the \"8139too\" driver instead.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "This (id %04x:%04x rev %02x) is not an 8139C+ compatible chip\n",
+		           pdev->vendor, pdev->device, pci_rev);
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "Try the \"8139too\" driver instead.\n");
 		return -ENODEV;
 	}
 
@@ -1877,14 +1879,14 @@ #endif
 	pciaddr = pci_resource_start(pdev, 1);
 	if (!pciaddr) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "no MMIO resource for pci dev %s\n",
-		       pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev, "no MMIO resource\n");
 		goto err_out_res;
 	}
 	if (pci_resource_len(pdev, 1) < CP_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "MMIO resource (%lx) too small\n",
+		       pci_resource_len(pdev, 1));
 		goto err_out_res;
 	}
 
@@ -1898,14 +1900,15 @@ #endif
 
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR PFX "No usable DMA configuration, "
-			       "aborting.\n");
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "No usable DMA configuration, aborting.\n");
 			goto err_out_res;
 		}
 		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
-			printk(KERN_ERR PFX "No usable consistent DMA configuration, "
-			       "aborting.\n");
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "No usable consistent DMA configuration, "
+			           "aborting.\n");
 			goto err_out_res;
 		}
 	}
@@ -1916,8 +1919,9 @@ #endif
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "Cannot map PCI MMIO (%lx@%lx)\n",
+		       pci_resource_len(pdev, 1), pciaddr);
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
@@ -1986,7 +1990,8 @@ #endif
 	/* enable busmastering and memory-write-invalidate */
 	pci_set_master(pdev);
 
-	if (cp->wol_enabled) cp_set_d3_state (cp);
+	if (cp->wol_enabled)
+		cp_set_d3_state (cp);
 
 	return 0;
 
@@ -2011,7 +2016,8 @@ static void cp_remove_one (struct pci_de
 	BUG_ON(!dev);
 	unregister_netdev(dev);
 	iounmap(cp->regs);
-	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);
+	if (cp->wol_enabled)
+		pci_set_power_state (pdev, PCI_D0);
 	pci_release_regions(pdev);
 	pci_clear_mwi(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index abd6261..b2592c4 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -769,7 +769,8 @@ static int __devinit rtl8139_init_board 
 	/* dev and priv zeroed in alloc_etherdev */
 	dev = alloc_etherdev (sizeof (*tp));
 	if (dev == NULL) {
-		printk (KERN_ERR PFX "%s: Unable to alloc new net device\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "Unable to alloc new net device\n");
 		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);
@@ -801,31 +802,35 @@ static int __devinit rtl8139_init_board 
 #ifdef USE_IO_OPS
 	/* make sure PCI base addr 0 is PIO */
 	if (!(pio_flags & IORESOURCE_IO)) {
-		printk (KERN_ERR PFX "%s: region #0 not a PIO resource, aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "region #0 not a PIO resource, aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 	/* check for weird/broken PCI region reporting */
 	if (pio_len < RTL_MIN_IO_SIZE) {
-		printk (KERN_ERR PFX "%s: Invalid PCI I/O region size(s), aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "Invalid PCI I/O region size(s), aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 #else
 	/* make sure PCI base addr 1 is MMIO */
 	if (!(mmio_flags & IORESOURCE_MEM)) {
-		printk (KERN_ERR PFX "%s: region #1 not an MMIO resource, aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "region #1 not an MMIO resource, aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 	if (mmio_len < RTL_MIN_IO_SIZE) {
-		printk (KERN_ERR PFX "%s: Invalid PCI mem region size(s), aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "Invalid PCI mem region size(s), aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 #endif
 
-	rc = pci_request_regions (pdev, "8139too");
+	rc = pci_request_regions (pdev, DRV_NAME);
 	if (rc)
 		goto err_out;
 	disable_dev_on_err = 1;
@@ -836,7 +841,7 @@ #endif
 #ifdef USE_IO_OPS
 	ioaddr = ioport_map(pio_start, pio_len);
 	if (!ioaddr) {
-		printk (KERN_ERR PFX "%s: cannot map PIO, aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev, "cannot map PIO, aborting\n");
 		rc = -EIO;
 		goto err_out;
 	}
@@ -847,7 +852,8 @@ #else
 	/* ioremap MMIO region */
 	ioaddr = pci_iomap(pdev, 1, 0);
 	if (ioaddr == NULL) {
-		printk (KERN_ERR PFX "%s: cannot remap MMIO, aborting\n", pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "cannot remap MMIO, aborting\n");
 		rc = -EIO;
 		goto err_out;
 	}
@@ -861,8 +867,8 @@ #endif /* USE_IO_OPS */
 
 	/* check for missing/broken hardware */
 	if (RTL_R32 (TxConfig) == 0xFFFFFFFF) {
-		printk (KERN_ERR PFX "%s: Chip not responding, ignoring board\n",
-			pci_name(pdev));
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "Chip not responding, ignoring board\n");
 		rc = -EIO;
 		goto err_out;
 	}
@@ -876,9 +882,10 @@ #endif /* USE_IO_OPS */
 		}
 
 	/* if unknown chip, assume array element #0, original RTL-8139 in this case */
-	printk (KERN_DEBUG PFX "%s: unknown chip version, assuming RTL-8139\n",
-		pci_name(pdev));
-	printk (KERN_DEBUG PFX "%s: TxConfig = 0x%lx\n", pci_name(pdev), RTL_R32 (TxConfig));
+	dev_printk (KERN_DEBUG, &pdev->dev,
+		    "unknown chip version, assuming RTL-8139\n");
+	dev_printk (KERN_DEBUG, &pdev->dev,
+		    "TxConfig = 0x%lx\n", RTL_R32 (TxConfig));
 	tp->chipset = 0;
 
 match:
@@ -955,9 +962,11 @@ #endif
 
 	if (pdev->vendor == PCI_VENDOR_ID_REALTEK &&
 	    pdev->device == PCI_DEVICE_ID_REALTEK_8139 && pci_rev >= 0x20) {
-		printk(KERN_INFO PFX "pci dev %s (id %04x:%04x rev %02x) is an enhanced 8139C+ chip\n",
-		       pci_name(pdev), pdev->vendor, pdev->device, pci_rev);
-		printk(KERN_INFO PFX "Use the \"8139cp\" driver for improved performance and stability.\n");
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "This (id %04x:%04x rev %02x) is an enhanced 8139C+ chip\n",
+		       	   pdev->vendor, pdev->device, pci_rev);
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "Use the \"8139cp\" driver for improved performance and stability.\n");
 	}
 
 	i = rtl8139_init_board (pdev, &dev);
diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index a7e4ba5..6d7748d 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2120,13 +2120,14 @@ static int __devinit b44_init_one(struct
 
 	err = pci_enable_device(pdev);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot enable PCI device, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot enable PCI device, "
 		       "aborting.\n");
 		return err;
 	}
 
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
-		printk(KERN_ERR PFX "Cannot find proper PCI device "
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot find proper PCI device "
 		       "base address, aborting.\n");
 		err = -ENODEV;
 		goto err_out_disable_pdev;
@@ -2134,8 +2135,8 @@ static int __devinit b44_init_one(struct
 
 	err = pci_request_regions(pdev, DRV_MODULE_NAME);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot obtain PCI resources, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot obtain PCI resources, aborting.\n");
 		goto err_out_disable_pdev;
 	}
 
@@ -2143,15 +2144,15 @@ static int __devinit b44_init_one(struct
 
 	err = pci_set_dma_mask(pdev, (u64) B44_DMA_MASK);
 	if (err) {
-		printk(KERN_ERR PFX "No usable DMA configuration, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"No usable DMA configuration, aborting.\n");
 		goto err_out_free_res;
 	}
 
 	err = pci_set_consistent_dma_mask(pdev, (u64) B44_DMA_MASK);
 	if (err) {
-		printk(KERN_ERR PFX "No usable DMA configuration, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"No usable DMA configuration, aborting.\n");
 		goto err_out_free_res;
 	}
 
@@ -2160,7 +2161,8 @@ static int __devinit b44_init_one(struct
 
 	dev = alloc_etherdev(sizeof(*bp));
 	if (!dev) {
-		printk(KERN_ERR PFX "Etherdev alloc failed, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Etherdev alloc failed, aborting.\n");
 		err = -ENOMEM;
 		goto err_out_free_res;
 	}
@@ -2181,7 +2183,7 @@ static int __devinit b44_init_one(struct
 
 	bp->regs = ioremap(b44reg_base, b44reg_len);
 	if (bp->regs == 0UL) {
-		printk(KERN_ERR PFX "Cannot map device registers, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot map device registers, "
 		       "aborting.\n");
 		err = -ENOMEM;
 		goto err_out_free_dev;
@@ -2212,8 +2214,8 @@ #endif
 
 	err = b44_get_invariants(bp);
 	if (err) {
-		printk(KERN_ERR PFX "Problem fetching invariants of chip, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Problem fetching invariants of chip, aborting.\n");
 		goto err_out_iounmap;
 	}
 
@@ -2233,7 +2235,7 @@ #endif
 
 	err = register_netdev(dev);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot register net device, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot register net device, "
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
index 7635736..171e498 100644
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -5566,20 +5566,22 @@ bnx2_init_board(struct pci_dev *pdev, st
 	/* enable device (incl. PCI PM wakeup), and bus-mastering */
 	rc = pci_enable_device(pdev);
 	if (rc) {
-		printk(KERN_ERR PFX "Cannot enable PCI device, aborting.");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot enable PCI device, aborting.");
 		goto err_out;
 	}
 
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
-		printk(KERN_ERR PFX "Cannot find PCI device base address, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot find PCI device base address, aborting.\n");
 		rc = -ENODEV;
 		goto err_out_disable;
 	}
 
 	rc = pci_request_regions(pdev, DRV_MODULE_NAME);
 	if (rc) {
-		printk(KERN_ERR PFX "Cannot obtain PCI resources, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot obtain PCI resources, aborting.\n");
 		goto err_out_disable;
 	}
 
@@ -5587,15 +5589,16 @@ bnx2_init_board(struct pci_dev *pdev, st
 
 	bp->pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	if (bp->pm_cap == 0) {
-		printk(KERN_ERR PFX "Cannot find power management capability, "
-			       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot find power management capability, aborting.\n");
 		rc = -EIO;
 		goto err_out_release;
 	}
 
 	bp->pcix_cap = pci_find_capability(pdev, PCI_CAP_ID_PCIX);
 	if (bp->pcix_cap == 0) {
-		printk(KERN_ERR PFX "Cannot find PCIX capability, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot find PCIX capability, aborting.\n");
 		rc = -EIO;
 		goto err_out_release;
 	}
@@ -5603,14 +5606,15 @@ bnx2_init_board(struct pci_dev *pdev, st
 	if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) == 0) {
 		bp->flags |= USING_DAC_FLAG;
 		if (pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK) != 0) {
-			printk(KERN_ERR PFX "pci_set_consistent_dma_mask "
-			       "failed, aborting.\n");
+			dev_printk(KERN_ERR, &pdev->dev,
+				"pci_set_consistent_dma_mask failed, aborting.\n");
 			rc = -EIO;
 			goto err_out_release;
 		}
 	}
 	else if (pci_set_dma_mask(pdev, DMA_32BIT_MASK) != 0) {
-		printk(KERN_ERR PFX "System does not support DMA, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"System does not support DMA, aborting.\n");
 		rc = -EIO;
 		goto err_out_release;
 	}
@@ -5630,7 +5634,8 @@ bnx2_init_board(struct pci_dev *pdev, st
 	bp->regview = ioremap_nocache(dev->base_addr, mem_len);
 
 	if (!bp->regview) {
-		printk(KERN_ERR PFX "Cannot map register space, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot map register space, aborting.\n");
 		rc = -ENOMEM;
 		goto err_out_release;
 	}
@@ -5702,8 +5707,8 @@ bnx2_init_board(struct pci_dev *pdev, st
 	else if ((CHIP_ID(bp) == CHIP_ID_5706_A1) &&
 		!(bp->flags & PCIX_FLAG)) {
 
-		printk(KERN_ERR PFX "5706 A1 can only be used in a PCIX bus, "
-		       "aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"5706 A1 can only be used in a PCIX bus, aborting.\n");
 		goto err_out_unmap;
 	}
 
@@ -5724,7 +5729,8 @@ bnx2_init_board(struct pci_dev *pdev, st
 
 	if ((reg & BNX2_DEV_INFO_SIGNATURE_MAGIC_MASK) !=
 	    BNX2_DEV_INFO_SIGNATURE_MAGIC) {
-		printk(KERN_ERR PFX "Firmware not running, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Firmware not running, aborting.\n");
 		rc = -ENODEV;
 		goto err_out_unmap;
 	}
@@ -5886,7 +5892,8 @@ #if defined(HAVE_POLL_CONTROLLER) || def
 #endif
 
 	if ((rc = register_netdev(dev))) {
-		printk(KERN_ERR PFX "Cannot register net device\n");
+		dev_printk(KERN_ERR, &pdev->dev,
+			"Cannot register net device\n");
 		if (bp->regview)
 			iounmap(bp->regview);
 		pci_release_regions(pdev);
diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
index 565a54f..ccff239 100644
--- a/drivers/net/cassini.c
+++ b/drivers/net/cassini.c
@@ -4888,13 +4888,13 @@ static int __devinit cas_init_one(struct
 
 	err = pci_enable_device(pdev);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot enable PCI device, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot enable PCI device, "
 		       "aborting.\n");
 		return err;
 	}
 
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
-		printk(KERN_ERR PFX "Cannot find proper PCI device "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot find proper PCI device "
 		       "base address, aborting.\n");
 		err = -ENODEV;
 		goto err_out_disable_pdev;
@@ -4902,7 +4902,7 @@ static int __devinit cas_init_one(struct
 
 	dev = alloc_etherdev(sizeof(*cp));
 	if (!dev) {
-		printk(KERN_ERR PFX "Etherdev alloc failed, aborting.\n");
+		dev_printk(KERN_ERR, &pdev->dev, "Etherdev alloc failed, aborting.\n");
 		err = -ENOMEM;
 		goto err_out_disable_pdev;
 	}
@@ -4911,7 +4911,7 @@ static int __devinit cas_init_one(struct
 
 	err = pci_request_regions(pdev, dev->name);
 	if (err) {
-		printk(KERN_ERR PFX "Cannot obtain PCI resources, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot obtain PCI resources, "
 		       "aborting.\n");
 		goto err_out_free_netdev;
 	}
@@ -4942,7 +4942,7 @@ #if 1
 		if (pci_write_config_byte(pdev, 
 					  PCI_CACHE_LINE_SIZE, 
 					  cas_cacheline_size)) {
-			printk(KERN_ERR PFX "Could not set PCI cache "
+			dev_printk(KERN_ERR, &pdev->dev, "Could not set PCI cache "
 			       "line size\n");
 			goto err_write_cacheline;
 		}
@@ -4956,7 +4956,7 @@ #endif
 		err = pci_set_consistent_dma_mask(pdev,
 						  DMA_64BIT_MASK);
 		if (err < 0) {
-			printk(KERN_ERR PFX "Unable to obtain 64-bit DMA "
+			dev_printk(KERN_ERR, &pdev->dev, "Unable to obtain 64-bit DMA "
 			       "for consistent allocations\n");
 			goto err_out_free_res;
 		}
@@ -4964,7 +4964,7 @@ #endif
 	} else {
 		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
-			printk(KERN_ERR PFX "No usable DMA configuration, "
+			dev_printk(KERN_ERR, &pdev->dev, "No usable DMA configuration, "
 			       "aborting.\n");
 			goto err_out_free_res;
 		}
@@ -5024,7 +5024,7 @@ #endif
 	/* give us access to cassini registers */
 	cp->regs = pci_iomap(pdev, 0, casreg_len);
 	if (cp->regs == 0UL) {
-		printk(KERN_ERR PFX "Cannot map device registers, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot map device registers, "
 		       "aborting.\n");
 		goto err_out_free_res;
 	}
@@ -5041,7 +5041,7 @@ #endif
 		pci_alloc_consistent(pdev, sizeof(struct cas_init_block),
 				     &cp->block_dvma);
 	if (!cp->init_block) {
-		printk(KERN_ERR PFX "Cannot allocate init block, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot allocate init block, "
 		       "aborting.\n");
 		goto err_out_iounmap;
 	}
@@ -5086,7 +5086,7 @@ #endif
 		dev->features |= NETIF_F_HIGHDMA;
 
 	if (register_netdev(dev)) {
-		printk(KERN_ERR PFX "Cannot register net device, "
+		dev_printk(KERN_ERR, &pdev->dev, "Cannot register net device, "
 		       "aborting.\n");
 		goto err_out_free_consistent;
 	}
diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
index ecf5ad8..0b65a31 100644
--- a/drivers/net/eepro100.c
+++ b/drivers/net/eepro100.c
@@ -556,12 +556,14 @@ #endif
 
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"eepro100: cannot reserve I/O ports\n");
 		goto err_out_none;
 	}
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 			pci_resource_len(pdev, 0), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"eepro100: cannot reserve MMIO region\n");
 		goto err_out_free_pio_region;
 	}
 
@@ -574,7 +576,7 @@ #endif
 
 	ioaddr = pci_iomap(pdev, pci_bar, 0);
 	if (!ioaddr) {
-		printk (KERN_ERR "eepro100: cannot remap IO\n");
+		dev_printk (KERN_ERR, &pdev->dev, "eepro100: cannot remap IO\n");
 		goto err_out_free_mmio_region;
 	}
 
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index 8dacd0d..1ec06a5 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -423,8 +423,7 @@ #endif
 		((u16 *)dev->dev_addr)[i] = le16_to_cpu(inw(ioaddr + LAN0 + i*4));
 
 	if (debug > 2) {
-		printk(KERN_DEBUG DRV_NAME "(%s): EEPROM contents\n",
-		       pci_name(pdev));
+		dev_printk(KERN_DEBUG, &pdev->dev, "EEPROM contents:\n");
 		for (i = 0; i < 64; i++)
 			printk(" %4.4x%s", read_eeprom(ioaddr, i),
 				   i % 16 == 15 ? "\n" : "");
@@ -446,21 +445,23 @@ #endif
 			int mii_status = mdio_read(dev, phy, MII_BMSR);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				ep->phys[phy_idx++] = phy;
-				printk(KERN_INFO DRV_NAME "(%s): MII transceiver #%d control "
-					   "%4.4x status %4.4x.\n",
-					   pci_name(pdev), phy, mdio_read(dev, phy, 0), mii_status);
+				dev_printk(KERN_INFO, &pdev->dev,
+					"MII transceiver #%d control "
+					"%4.4x status %4.4x.\n",
+					phy, mdio_read(dev, phy, 0), mii_status);
 			}
 		}
 		ep->mii_phy_cnt = phy_idx;
 		if (phy_idx != 0) {
 			phy = ep->phys[0];
 			ep->mii.advertising = mdio_read(dev, phy, MII_ADVERTISE);
-			printk(KERN_INFO DRV_NAME "(%s): Autonegotiation advertising %4.4x link "
+			dev_printk(KERN_INFO, &pdev->dev,
+				"Autonegotiation advertising %4.4x link "
 				   "partner %4.4x.\n",
-				   pci_name(pdev), ep->mii.advertising, mdio_read(dev, phy, 5));
+				   ep->mii.advertising, mdio_read(dev, phy, 5));
 		} else if ( ! (ep->chip_flags & NO_MII)) {
-			printk(KERN_WARNING DRV_NAME "(%s): ***WARNING***: No MII transceiver found!\n",
-			       pci_name(pdev));
+			dev_printk(KERN_WARNING, &pdev->dev,
+				"***WARNING***: No MII transceiver found!\n");
 			/* Use the known PHY address of the EPII. */
 			ep->phys[0] = 3;
 		}
@@ -475,8 +476,8 @@ #endif
 	/* The lower four bits are the media type. */
 	if (duplex) {
 		ep->mii.force_media = ep->mii.full_duplex = 1;
-		printk(KERN_INFO DRV_NAME "(%s):  Forced full duplex operation requested.\n",
-		       pci_name(pdev));
+		dev_printk(KERN_INFO, &pdev->dev,
+			"Forced full duplex operation requested.\n");
 	}
 	dev->if_port = ep->default_port = option;
 
diff --git a/drivers/net/fealnx.c b/drivers/net/fealnx.c
index 958ea51..9369082 100644
--- a/drivers/net/fealnx.c
+++ b/drivers/net/fealnx.c
@@ -578,9 +578,9 @@ #endif
 
 			if (mii_status != 0xffff && mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
-				printk(KERN_INFO
-				       "%s: MII PHY found at address %d, status "
-				       "0x%4.4x.\n", dev->name, phy, mii_status);
+				dev_printk(KERN_INFO, &pdev->dev,
+				       "MII PHY found at address %d, status "
+				       "0x%4.4x.\n", phy, mii_status);
 				/* get phy type */
 				{
 					unsigned int data;
@@ -603,10 +603,10 @@ #endif
 		}
 
 		np->mii_cnt = phy_idx;
-		if (phy_idx == 0) {
-			printk(KERN_WARNING "%s: MII PHY not found -- this device may "
-			       "not operate correctly.\n", dev->name);
-		}
+		if (phy_idx == 0)
+			dev_printk(KERN_WARNING, &pdev->dev,
+				"MII PHY not found -- this device may "
+			       "not operate correctly.\n");
 	} else {
 		np->phys[0] = 32;
 /* 89/6/23 add, (begin) */
@@ -632,7 +632,8 @@ #endif
 		np->mii.full_duplex = full_duplex[card_idx];
 
 	if (np->mii.full_duplex) {
-		printk(KERN_INFO "%s: Media type forced to Full Duplex.\n", dev->name);
+		dev_printk(KERN_INFO, &pdev->dev,
+			"Media type forced to Full Duplex.\n");
 /* 89/6/13 add, (begin) */
 //      if (np->PHYType==MarvellPHY)
 		if ((np->PHYType == MarvellPHY) || (np->PHYType == LevelOnePHY)) {
diff --git a/drivers/net/hamachi.c b/drivers/net/hamachi.c
index 2b91099..168eb4e 100644
--- a/drivers/net/hamachi.c
+++ b/drivers/net/hamachi.c
@@ -601,7 +601,8 @@ #endif
 	pci_set_master(pdev);
 
 	i = pci_request_regions(pdev, DRV_NAME);
-	if (i) return i;
+	if (i)
+		return i;
 
 	irq = pdev->irq;
 	ioaddr = ioremap(base, 0x400);
diff --git a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
index ced9fdb..b5bf53f 100644
--- a/drivers/net/ne2k-pci.c
+++ b/drivers/net/ne2k-pci.c
@@ -231,12 +231,14 @@ #endif
 	irq = pdev->irq;
 
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_IO) == 0)) {
-		printk (KERN_ERR PFX "no I/O resource at PCI BAR #0\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"no I/O resource at PCI BAR #0\n");
 		return -ENODEV;
 	}
 
 	if (request_region (ioaddr, NE_IO_EXTENT, DRV_NAME) == NULL) {
-		printk (KERN_ERR PFX "I/O resource 0x%x @ 0x%lx busy\n",
+		dev_printk (KERN_ERR, &pdev->dev,
+			"I/O resource 0x%x @ 0x%lx busy\n",
 			NE_IO_EXTENT, ioaddr);
 		return -EBUSY;
 	}
@@ -263,7 +265,8 @@ #endif
 	/* Allocate net_device, dev->priv; fill in 8390 specific dev fields. */
 	dev = alloc_ei_netdev();
 	if (!dev) {
-		printk (KERN_ERR PFX "cannot allocate ethernet device\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"cannot allocate ethernet device\n");
 		goto err_out_free_res;
 	}
 	SET_MODULE_OWNER(dev);
@@ -281,7 +284,8 @@ #endif
 		while ((inb(ioaddr + EN0_ISR) & ENISR_RESET) == 0)
 			/* Limit wait: '2' avoids jiffy roll-over. */
 			if (jiffies - reset_start_time > 2) {
-				printk(KERN_ERR PFX "Card failure (no reset ack).\n");
+				dev_printk(KERN_ERR, &pdev->dev,
+					"Card failure (no reset ack).\n");
 				goto err_out_free_netdev;
 			}
 
diff --git a/drivers/net/ns83820.c b/drivers/net/ns83820.c
index 706aed7..916ec99 100644
--- a/drivers/net/ns83820.c
+++ b/drivers/net/ns83820.c
@@ -1833,7 +1833,8 @@ static int __devinit ns83820_init_one(st
 	} else if (!pci_set_dma_mask(pci_dev, DMA_32BIT_MASK)) {
 		using_dac = 0;
 	} else {
-		printk(KERN_WARNING "ns83820.c: pci_set_dma_mask failed!\n");
+		dev_printk(KERN_WARNING, &pci_dev->dev,
+			"pci_set_dma_mask failed!\n");
 		return -ENODEV;
 	}
 
@@ -1856,7 +1857,8 @@ static int __devinit ns83820_init_one(st
 
 	err = pci_enable_device(pci_dev);
 	if (err) {
-		printk(KERN_INFO "ns83820: pci_enable_dev failed: %d\n", err);
+		dev_printk(KERN_INFO, &pci_dev->dev,
+			"pci_enable_dev failed: %d\n", err);
 		goto out_free;
 	}
 
@@ -1885,8 +1887,9 @@ static int __devinit ns83820_init_one(st
 	err = request_irq(pci_dev->irq, ns83820_irq, SA_SHIRQ,
 			  DRV_NAME, ndev);
 	if (err) {
-		printk(KERN_INFO "ns83820: unable to register irq %d\n",
-			pci_dev->irq);
+		dev_printk(KERN_INFO, &pci_dev->dev,
+			"unable to register irq %d, err %d\n",
+			pci_dev->irq, err);
 		goto out_disable;
 	}
 
@@ -1900,7 +1903,8 @@ static int __devinit ns83820_init_one(st
 	rtnl_lock();
 	err = dev_alloc_name(ndev, ndev->name);
 	if (err < 0) {
-		printk(KERN_INFO "ns83820: unable to get netdev name: %d\n", err);
+		dev_printk(KERN_INFO, &pci_dev->dev,
+			"unable to get netdev name: %d\n", err);
 		goto out_free_irq;
 	}
 
diff --git a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
index a7bb54d..2754fad 100644
--- a/drivers/net/pci-skeleton.c
+++ b/drivers/net/pci-skeleton.c
@@ -602,7 +602,8 @@ static int __devinit netdrv_init_board (
 	/* dev zeroed in alloc_etherdev */
 	dev = alloc_etherdev (sizeof (*tp));
 	if (dev == NULL) {
-		printk (KERN_ERR PFX "unable to alloc new ethernet\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			    "unable to alloc new ethernet\n");
 		DPRINTK ("EXIT, returning -ENOMEM\n");
 		return -ENOMEM;
 	}
@@ -632,14 +633,16 @@ static int __devinit netdrv_init_board (
 
 	/* make sure PCI base addr 0 is PIO */
 	if (!(pio_flags & IORESOURCE_IO)) {
-		printk (KERN_ERR PFX "region #0 not a PIO resource, aborting\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"region #0 not a PIO resource, aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 
 	/* make sure PCI base addr 1 is MMIO */
 	if (!(mmio_flags & IORESOURCE_MEM)) {
-		printk (KERN_ERR PFX "region #1 not an MMIO resource, aborting\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"region #1 not an MMIO resource, aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
@@ -647,12 +650,13 @@ static int __devinit netdrv_init_board (
 	/* check for weird/broken PCI region reporting */
 	if ((pio_len < NETDRV_MIN_IO_SIZE) ||
 	    (mmio_len < NETDRV_MIN_IO_SIZE)) {
-		printk (KERN_ERR PFX "Invalid PCI region size(s), aborting\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"Invalid PCI region size(s), aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
 
-	rc = pci_request_regions (pdev, "pci-skeleton");
+	rc = pci_request_regions (pdev, MODNAME);
 	if (rc)
 		goto err_out;
 
@@ -664,7 +668,8 @@ #else
 	/* ioremap MMIO region */
 	ioaddr = ioremap (mmio_start, mmio_len);
 	if (ioaddr == NULL) {
-		printk (KERN_ERR PFX "cannot remap MMIO, aborting\n");
+		dev_printk (KERN_ERR, &pdev->dev,
+			"cannot remap MMIO, aborting\n");
 		rc = -EIO;
 		goto err_out_free_res;
 	}
@@ -700,9 +705,10 @@ #endif /* !USE_IO_OPS */
 		}
 
 	/* if unknown chip, assume array element #0, original RTL-8139 in this case */
-	printk (KERN_DEBUG PFX "PCI device %s: unknown chip version, assuming RTL-8139\n",
-		pci_name(pdev));
-	printk (KERN_DEBUG PFX "PCI device %s: TxConfig = 0x%lx\n", pci_name(pdev), NETDRV_R32 (TxConfig));
+	dev_printk (KERN_DEBUG, &pdev->dev,
+		"unknown chip version, assuming RTL-8139\n");
+	dev_printk (KERN_DEBUG, &pdev->dev, "TxConfig = 0x%lx\n",
+		NETDRV_R32 (TxConfig));
 	tp->chipset = 0;
 
 match:
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 12d1cb2..24a5b31 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -1406,7 +1406,8 @@ rtl8169_init_board(struct pci_dev *pdev,
 	dev = alloc_etherdev(sizeof (*tp));
 	if (dev == NULL) {
 		if (netif_msg_drv(&debug))
-			printk(KERN_ERR PFX "unable to alloc new ethernet\n");
+			dev_printk(KERN_ERR, &pdev->dev,
+				"unable to alloc new ethernet\n");
 		goto err_out;
 	}
 
@@ -1418,10 +1419,8 @@ rtl8169_init_board(struct pci_dev *pdev,
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pci_enable_device(pdev);
 	if (rc < 0) {
-		if (netif_msg_probe(tp)) {
-			printk(KERN_ERR PFX "%s: enable failure\n",
-			       pci_name(pdev));
-		}
+		if (netif_msg_probe(tp))
+			dev_printk(KERN_ERR, &pdev->dev, "enable failure\n");
 		goto err_out_free_dev;
 	}
 
@@ -1437,37 +1436,33 @@ rtl8169_init_board(struct pci_dev *pdev,
 		pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pwr_command);
 		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
 	} else {
-		if (netif_msg_probe(tp)) {
-			printk(KERN_ERR PFX
+		if (netif_msg_probe(tp))
+			dev_printk(KERN_ERR, &pdev->dev,
 			       "PowerManagement capability not found.\n");
-		}
 	}
 
 	/* make sure PCI base addr 1 is MMIO */
 	if (!(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
-		if (netif_msg_probe(tp)) {
-			printk(KERN_ERR PFX
+		if (netif_msg_probe(tp))
+			dev_printk(KERN_ERR, &pdev->dev,
 			       "region #1 not an MMIO resource, aborting\n");
-		}
 		rc = -ENODEV;
 		goto err_out_mwi;
 	}
 	/* check for weird/broken PCI region reporting */
 	if (pci_resource_len(pdev, 1) < R8169_REGS_SIZE) {
-		if (netif_msg_probe(tp)) {
-			printk(KERN_ERR PFX
+		if (netif_msg_probe(tp))
+			dev_printk(KERN_ERR, &pdev->dev,
 			       "Invalid PCI region size(s), aborting\n");
-		}
 		rc = -ENODEV;
 		goto err_out_mwi;
 	}
 
 	rc = pci_request_regions(pdev, MODULENAME);
 	if (rc < 0) {
-		if (netif_msg_probe(tp)) {
-			printk(KERN_ERR PFX "%s: could not request regions.\n",
-			       pci_name(pdev));
-		}
+		if (netif_msg_probe(tp))
+			dev_printk(KERN_ERR, &pdev->dev,
+				"could not request regions.\n");
 		goto err_out_mwi;
 	}
 
@@ -1480,10 +1475,9 @@ rtl8169_init_board(struct pci_dev *pdev,
 	} else {
 		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc < 0) {
-			if (netif_msg_probe(tp)) {
-				printk(KERN_ERR PFX
+			if (netif_msg_probe(tp))
+				dev_printk(KERN_ERR, &pdev->dev,
 				       "DMA configuration failed.\n");
-			}
 			goto err_out_free_res;
 		}
 	}
@@ -1494,7 +1488,8 @@ rtl8169_init_board(struct pci_dev *pdev,
 	ioaddr = ioremap(pci_resource_start(pdev, 1), R8169_REGS_SIZE);
 	if (ioaddr == NULL) {
 		if (netif_msg_probe(tp))
-			printk(KERN_ERR PFX "cannot remap MMIO, aborting\n");
+			dev_printk(KERN_ERR, &pdev->dev,
+				"cannot remap MMIO, aborting\n");
 		rc = -EIO;
 		goto err_out_free_res;
 	}
@@ -1526,9 +1521,9 @@ rtl8169_init_board(struct pci_dev *pdev,
 	if (i < 0) {
 		/* Unknown chip: assume array element #0, original RTL-8169 */
 		if (netif_msg_probe(tp)) {
-			printk(KERN_DEBUG PFX "PCI device %s: "
+			dev_printk(KERN_DEBUG, &pdev->dev,
 			       "unknown chip version, assuming %s\n",
-			       pci_name(pdev), rtl_chip_info[0].name);
+			       rtl_chip_info[0].name);
 		}
 		i++;
 	}
