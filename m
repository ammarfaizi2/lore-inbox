Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSKRUQV>; Mon, 18 Nov 2002 15:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKRUQV>; Mon, 18 Nov 2002 15:16:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63177 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264673AbSKRUQS>; Mon, 18 Nov 2002 15:16:18 -0500
Date: Mon, 18 Nov 2002 21:23:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>, Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [2.5 patch] aggregate name -> dev.name patch
Message-ID: <20021118202313.GL11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains name -> dev.name fixes.
It includes all patches I've already sent, a bbtv patch by Petr
Vandrovec plus some more fixes.

Please review and apply it if all fixes are correct.

TIA
Adrian

--- linux-2.5.48/drivers/input/gameport/fm801-gp.c.old	2002-11-18 13:39:24.000000000 +0100
+++ linux-2.5.48/drivers/input/gameport/fm801-gp.c	2002-11-18 13:46:45.000000000 +0100
@@ -116,7 +116,7 @@
 	gameport_register_port(&gp->gameport);
 
 	printk(KERN_INFO "gameport: %s at pci%s speed %d kHz\n",
-		pci->name, pci->slot_name, gp->gameport.speed);
+		pci->dev.name, pci->slot_name, gp->gameport.speed);
 
 	return 0;
 }
--- linux-2.5.48/drivers/input/gameport/ns558.c.old	2002-11-18 13:48:45.000000000 +0100
+++ linux-2.5.48/drivers/input/gameport/ns558.c	2002-11-18 13:49:06.000000000 +0100
@@ -236,7 +236,7 @@
 	port->gameport.id.version = 0x100;
 
 	sprintf(port->phys, "isapnp%d.%d/gameport0", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	sprintf(port->name, "%s", dev->name[0] ? dev->name : "NS558 PnP Gameport");
+	sprintf(port->name, "%s", dev->dev.name[0] ? dev->dev.name : "NS558 PnP Gameport");
 
 	gameport_register_port(&port->gameport);
 
--- linux-2.5.48/drivers/input/gameport/vortex.c.old	2002-11-18 13:51:06.000000000 +0100
+++ linux-2.5.48/drivers/input/gameport/vortex.c	2002-11-18 13:51:25.000000000 +0100
@@ -127,7 +127,7 @@
 	vortex->gameport.cooked_read = vortex_cooked_read;
 	vortex->gameport.open = vortex_open;
 
-	vortex->gameport.name = dev->name;
+	vortex->gameport.name = dev->dev.name;
 	vortex->gameport.phys = vortex->phys;
 	vortex->gameport.id.bustype = BUS_PCI;
 	vortex->gameport.id.vendor = dev->vendor;
@@ -146,7 +146,7 @@
 	gameport_register_port(&vortex->gameport);
 	
 	printk(KERN_INFO "gameport: %s at pci%s speed %d kHz\n",
-		dev->name, dev->slot_name, vortex->gameport.speed);
+		dev->dev.name, dev->slot_name, vortex->gameport.speed);
 
 	return 0;
 }
--- linux-2.5.48/drivers/net/arcnet/com20020-pci.c.old	2002-11-18 14:02:51.000000000 +0100
+++ linux-2.5.48/drivers/net/arcnet/com20020-pci.c	2002-11-18 14:03:06.000000000 +0100
@@ -90,7 +90,7 @@
 	dev->base_addr = ioaddr;
 	dev->irq = pdev->irq;
 	dev->dev_addr[0] = node;
-	lp->card_name = pdev->name;
+	lp->card_name = pdev->dev.name;
 	lp->card_flags = id->driver_data;
 	lp->backplane = backplane;
 	lp->clockp = clockp & 7;
--- linux-2.5.48/drivers/net/irda/vlsi_ir.c.old	2002-11-18 14:11:30.000000000 +0100
+++ linux-2.5.48/drivers/net/irda/vlsi_ir.c	2002-11-18 14:13:07.000000000 +0100
@@ -162,7 +162,7 @@
 		return 0;
 
 	out += sprintf(out, "\n%s (vid/did: %04x/%04x)\n",
-			pdev->name, (int)pdev->vendor, (int)pdev->device);
+			pdev->dev.name, (int)pdev->vendor, (int)pdev->device);
 	out += sprintf(out, "pci-power-state: %u\n", (unsigned) pdev->current_state);
 	out += sprintf(out, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
 			pdev->irq, (unsigned)pci_resource_start(pdev, 0), (u64)pdev->dma_mask);
@@ -1517,7 +1517,7 @@
 
 	if (vlsi_start_hw(idev))
 		printk(KERN_CRIT "%s: failed to restart hw - %s(%s) unusable!\n",
-			__FUNCTION__, idev->pdev->name, ndev->name);
+			__FUNCTION__, idev->pdev->dev.name, ndev->name);
 	else
 		netif_start_queue(ndev);
 }
@@ -1765,7 +1765,7 @@
 		pdev->current_state = 0; /* hw must be running now */
 
 	printk(KERN_INFO "%s: IrDA PCI controller %s detected\n",
-		drivername, pdev->name);
+		drivername, pdev->dev.name);
 
 	if ( !pci_resource_start(pdev,0)
 	     || !(pci_resource_flags(pdev,0) & IORESOURCE_IO) ) {
@@ -1863,7 +1863,7 @@
 	 * ndev->destructor called (if present) when going to free
 	 */
 
-	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->name);
+	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->dev.name);
 }
 
 #ifdef CONFIG_PM
@@ -1879,7 +1879,7 @@
 {
 	if (state < 1 || state > 3 ) {
 		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->name, state);
+			__FUNCTION__, pdev->dev.name, state);
 		return -1;
 	}
 	return 0;
@@ -1892,11 +1892,11 @@
 
 	if (state < 1 || state > 3 ) {
 		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->name, state);
+			__FUNCTION__, pdev->dev.name, state);
 		return 0;
 	}
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	idev = ndev->priv;	
@@ -1908,7 +1908,7 @@
 		}
 		else
 			printk(KERN_ERR "%s - %s: invalid suspend request %u -> %u\n",
-				__FUNCTION__, pdev->name, pdev->current_state, state);
+				__FUNCTION__, pdev->dev.name, pdev->current_state, state);
 		up(&idev->sem);
 		return 0;
 	}
@@ -1935,14 +1935,14 @@
 	vlsi_irda_dev_t	*idev;
 
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	idev = ndev->priv;	
 	down(&idev->sem);
 	if (pdev->current_state == 0) {
 		up(&idev->sem);
-		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->name);
+		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->dev.name);
 		return 0;
 	}
 	
--- linux-2.5.48/drivers/net/tokenring/olympic.c.old	2002-11-18 14:25:16.000000000 +0100
+++ linux-2.5.48/drivers/net/tokenring/olympic.c	2002-11-18 14:25:29.000000000 +0100
@@ -231,7 +231,7 @@
 	dev->irq=pdev->irq;
 	dev->base_addr=pci_resource_start(pdev, 0);
 	dev->init=NULL; /* Must be NULL otherwise we get called twice */
-	olympic_priv->olympic_card_name = (char *)pdev->name ; 
+	olympic_priv->olympic_card_name = (char *)pdev->dev.name ; 
 	olympic_priv->olympic_mmio = ioremap(pci_resource_start(pdev,1),256);
 	olympic_priv->olympic_lap = ioremap(pci_resource_start(pdev,2),2048);
 	olympic_priv->pdev = pdev ; 
--- linux-2.5.48/drivers/net/tokenring/3c359.c.old	2002-11-18 14:32:27.000000000 +0100
+++ linux-2.5.48/drivers/net/tokenring/3c359.c	2002-11-18 14:32:47.000000000 +0100
@@ -316,7 +316,7 @@
 	dev->irq=pdev->irq;
 	dev->base_addr=pci_resource_start(pdev,0) ; 
 	dev->init=NULL ; /* Must be null with new api, otherwise get called twice */
-	xl_priv->xl_card_name = (char *)pdev->name ; 
+	xl_priv->xl_card_name = (char *)pdev->dev.name ; 
 	xl_priv->xl_mmio=ioremap(pci_resource_start(pdev,1), XL_IO_SPACE);
 	xl_priv->pdev = pdev ; 
 		
--- linux-2.5.48/drivers/scsi/eata_pio.c.old	2002-11-18 15:06:38.000000000 +0100
+++ linux-2.5.48/drivers/scsi/eata_pio.c	2002-11-18 15:07:07.000000000 +0100
@@ -805,13 +805,13 @@
 	u32 base, x;
 
 	while ((dev = pci_find_device(PCI_VENDOR_ID_DPT, PCI_DEVICE_ID_DPT, dev)) != NULL) {
-		DBG(DBG_PROBE && DBG_PCI, printk("eata_pio: find_PCI, HBA at %s\n", dev->name));
+		DBG(DBG_PROBE && DBG_PCI, printk("eata_pio: find_PCI, HBA at %s\n", dev->dev.name));
 		if (pci_enable_device(dev))
 			continue;
 		pci_set_master(dev);
 		base = pci_resource_flags(dev, 0);
 		if (base & IORESOURCE_MEM) {
-			printk("eata_pio: invalid base address of device %s\n", dev->name);
+			printk("eata_pio: invalid base address of device %s\n", dev->dev.name);
 			continue;
 		}
 		base = pci_resource_start(dev, 0);
--- linux/drivers/media/video/bttv-cards.c	2002-11-18 13:50:42.000000000 +0000
+++ linux/drivers/media/video/bttv-cards.c	2002-11-18 13:55:51.000000000 +0000
@@ -2990,7 +2990,7 @@
 
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
+		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
 
 	/* print warnings about any quirks found */
 	if (triton1)
