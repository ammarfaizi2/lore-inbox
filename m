Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWEAXLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWEAXLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWEAXLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:11:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48026 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932312AbWEAXLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:11:50 -0400
Date: Tue, 2 May 2006 01:10:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: [PATCH 2/3] ipg: leaks in ipg_probe
Message-ID: <20060501231050.GC7419@electric-eye.fr.zoreil.com>
References: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146506939.23931.2.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error paths are badly broken.

Bonus:
- remove duplicate initialization of sp;
- remove useless NULL initialization of dev;
- USE_IO_OPS is not used (and the driver does not seem to care about
  posted writes, rejoice).

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c |   93 ++++++++++++++++++++++++-----------------------------
 1 files changed, 42 insertions(+), 51 deletions(-)

5ea54e95a2319311aaae857ecf2adb7fbe068c92
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 42396ca..da0fa22 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -2914,11 +2914,8 @@ static void ipg_remove(struct pci_dev *p
 	/* Un-register Ethernet device. */
 	unregister_netdev(dev);
 
-#ifdef USE_IO_OPS
-	ioport_unmap(ioaddr);
-#else
-	iounmap(sp->ioaddr);
-#endif
+	pci_iounmap(pdev, sp->ioaddr);
+
 	pci_release_regions(pdev);
 
 	free_netdev(dev);
@@ -2929,19 +2926,15 @@ #endif
 static int __devinit ipg_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
-	int err, i;
-	struct net_device *dev = NULL;
+	unsigned int i = id->driver_data;
 	struct ipg_nic_private *sp;
+	struct net_device *dev;
 	void __iomem *ioaddr;
-	unsigned long pio_start, pio_len;
-	unsigned long mmio_start;
+	int rc;
 
-	err = pci_enable_device(pdev);
-	if (err)
-		return err;
-
-	/* Get the index for the driver description string. */
-	i = id->driver_data;
+	rc = pci_enable_device(pdev);
+	if (rc < 0)
+		goto out;
 
 	printk(KERN_INFO "%s found.\n", nics_supported[i].NICname);
 	printk(KERN_INFO "Bus %x Slot %x\n",
@@ -2949,10 +2942,14 @@ static int __devinit ipg_probe(struct pc
 
 	pci_set_master(pdev);
 
-	if (!pci_dma_supported(pdev, 0xFFFFFFFF)) {
-		printk(KERN_INFO "pci_dma_supported out.\n");
-		err = -ENODEV;
-		goto out;
+	rc = pci_set_dma_mask(pdev, DMA_40BIT_MASK);
+	if (rc < 0) {
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc < 0) {
+			printk(KERN_ERR "%s: DMA config failed.\n",
+			       pci_name(pdev));
+			goto err_disable_0;
+		}
 	}
 
 	/*
@@ -2960,9 +2957,9 @@ static int __devinit ipg_probe(struct pc
 	 */
 	dev = alloc_etherdev(sizeof(struct ipg_nic_private));
 	if (!dev) {
-		printk(KERN_ERR "ipg: alloc_etherdev failed\n");
-		err = -ENOMEM;
-		goto out;
+		printk(KERN_ERR "%s: alloc_etherdev failed\n", pci_name(pdev));
+		rc = -ENOMEM;
+		goto err_disable_0;
 	}
 
 	sp = netdev_priv(dev);
@@ -2981,50 +2978,44 @@ static int __devinit ipg_probe(struct pc
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	err = pci_request_regions(pdev, DRV_NAME);
-	if (err)
-		goto out;
-
-	pio_start = pci_resource_start(pdev, 0) & 0xffffff80;
-	pio_len = pci_resource_len(pdev, 0);
-	mmio_start = pci_resource_start(pdev, 1) & 0xffffff80;
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_free_dev_1;
 
-#ifdef USE_IO_OPS
-	ioaddr = ioport_map(pio_start, pio_len);
-	if (!ioaddr) {
-		printk(KERN_ERR "%s cannot map PIO\n", pci_name(pdev));
-		err = -EIO;
-		goto out;
-	}
-#else
-	ioaddr = ioremap(mmio_start, netdev_io_size);
+	ioaddr = pci_iomap(pdev, 1, pci_resource_len(pdev, 1));
 	if (!ioaddr) {
 		printk(KERN_ERR "%s cannot map MMIO\n", pci_name(pdev));
-		err = -EIO;
-		goto out;
+		rc = -EIO;
+		goto err_release_regions_2;
 	}
-#endif
-	sp = netdev_priv(dev);
+
 	/* Save the pointer to the PCI device information. */
 	sp->ioaddr = ioaddr;
 	sp->pdev = pdev;
 
 	pci_set_drvdata(pdev, dev);
 
-	err = ipg_hw_init(dev);
-	if (err)
-		goto out;
+	rc = ipg_hw_init(dev);
+	if (rc < 0)
+		goto err_unmap_3;
 
-	err = register_netdev(dev);
-	if (err)
-		goto out;
+	rc = register_netdev(dev);
+	if (rc < 0)
+		goto err_unmap_3;
 
 	printk(KERN_INFO "Ethernet device registered as: %s\n", dev->name);
-	return 0;
+out:
+	return rc;
 
-      out:
+err_unmap_3:
+	pci_iounmap(pdev, ioaddr);
+err_release_regions_2:
+	pci_release_regions(pdev);
+err_free_dev_1:
+	free_netdev(dev);
+err_disable_0:
 	pci_disable_device(pdev);
-	return err;
+	goto out;
 }
 
 static void ipg_set_phy_default_param(unsigned char rev,
-- 
1.3.1

