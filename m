Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263108AbVALFpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVALFpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVALFdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:33:50 -0500
Received: from ozlabs.org ([203.10.76.45]:1681 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263093AbVALF3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:46 -0500
Date: Wed, 12 Jan 2005 16:24:34 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [1/8] orinoco driver updates
Message-ID: <20050112052434.GB30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112052352.GA30426@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reformats printk()s, comments, labels and other cosmetic strings in
the orinoco driver.  Also moves, removes, and adds ratelimiting in
some places.  Behavioural changes are trivial/cosmetic only.  This
reduces the cosmetic/trivial differences between the current kernel
version, and the CVS version of the driver; one small step towards
full merge.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/hermes.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/hermes.c	2005-01-12 14:47:25.791170120 +1100
@@ -48,6 +48,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/net.h>
 #include <asm/errno.h>
 
 #include "hermes.h"
@@ -232,13 +233,16 @@
 	err = hermes_issue_cmd(hw, cmd, parm0);
 	if (err) {
 		if (! hermes_present(hw)) {
-			printk(KERN_WARNING "hermes @ %p: "
-			       "Card removed while issuing command.\n",
-			       hw->iobase);
+			if (net_ratelimit())
+				printk(KERN_WARNING "hermes @ %p: "
+				       "Card removed while issuing command "
+				       "0x%04x.\n", hw->iobase, cmd);
 			err = -ENODEV;
 		} else 
-			printk(KERN_ERR "hermes @ %p: Error %d issuing command.\n",
-			       hw->iobase, err);
+			if (net_ratelimit())
+				printk(KERN_ERR "hermes @ %p: "
+				       "Error %d issuing command 0x%04x.\n",
+				       hw->iobase, err, cmd);
 		goto out;
 	}
 
@@ -251,17 +255,16 @@
 	}
 
 	if (! hermes_present(hw)) {
-		printk(KERN_WARNING "hermes @ %p: "
-		       "Card removed while waiting for command completion.\n",
-		       hw->iobase);
+		printk(KERN_WARNING "hermes @ %p: Card removed "
+		       "while waiting for command 0x%04x completion.\n",
+		       hw->iobase, cmd);
 		err = -ENODEV;
 		goto out;
 	}
 		
 	if (! (reg & HERMES_EV_CMD)) {
-		printk(KERN_ERR "hermes @ %p: "
-		       "Timeout waiting for command completion.\n",
-		       hw->iobase);
+		printk(KERN_ERR "hermes @ %p: Timeout waiting for "
+		       "command 0x%04x completion.\n", hw->iobase, cmd);
 		err = -ETIMEDOUT;
 		goto out;
 	}
@@ -481,14 +484,13 @@
 		*length = rlength;
 
 	if (rtype != rid)
-		printk(KERN_WARNING "hermes @ %p: "
-		       "hermes_read_ltv(): rid  (0x%04x) does not match type (0x%04x)\n",
-		       hw->iobase, rid, rtype);
+		printk(KERN_WARNING "hermes @ %p: %s(): "
+		       "rid (0x%04x) does not match type (0x%04x)\n",
+		       hw->iobase, __FUNCTION__, rid, rtype);
 	if (HERMES_RECLEN_TO_BYTES(rlength) > bufsize)
 		printk(KERN_WARNING "hermes @ %p: "
 		       "Truncating LTV record from %d to %d bytes. "
-		       "(rid=0x%04x, len=0x%04x)\n",
-		       hw->iobase,
+		       "(rid=0x%04x, len=0x%04x)\n", hw->iobase,
 		       HERMES_RECLEN_TO_BYTES(rlength), bufsize, rid, rlength);
 
 	nwords = min((unsigned)rlength - 1, bufsize / 2);
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2005-01-12 14:47:25.792169968 +1100
@@ -151,24 +151,18 @@
 
 	/* Assert the reset until the card notice */
 	hermes_write_regn(hw, PCI_COR, HERMES_PCI_COR_MASK);
-	printk(KERN_NOTICE "Reset done");
 	timeout = jiffies + (HERMES_PCI_COR_ONT * HZ / 1000);
 	while(time_before(jiffies, timeout)) {
-		printk(".");
 		mdelay(1);
 	}
-	printk(";\n");
 	//mdelay(HERMES_PCI_COR_ONT);
 
 	/* Give time for the card to recover from this hard effort */
 	hermes_write_regn(hw, PCI_COR, 0x0000);
-	printk(KERN_NOTICE "Clear Reset");
 	timeout = jiffies + (HERMES_PCI_COR_OFFT * HZ / 1000);
 	while(time_before(jiffies, timeout)) {
-		printk(".");
 		mdelay(1);
 	}
-	printk(";\n");
 	//mdelay(HERMES_PCI_COR_OFFT);
 
 	/* The card is ready when it's no longer busy */
@@ -183,7 +177,6 @@
 		printk(KERN_ERR PFX "Busy timeout\n");
 		return -ETIMEDOUT;
 	}
-	printk(KERN_NOTICE "pci_cor : reg = 0x%X - %lX - %lX\n", reg, timeout, jiffies);
 
 	return 0;
 }
@@ -202,15 +195,19 @@
 	struct net_device *dev = NULL;
 
 	err = pci_enable_device(pdev);
-	if (err)
-		return -EIO;
+	if (err) {
+		printk(KERN_ERR PFX "Cannot enable PCI device\n");
+		return err;
+	}
 
 	/* Resource 0 is mapped to the hermes registers */
 	pci_iorange = pci_resource_start(pdev, 0);
 	pci_iolen = pci_resource_len(pdev, 0);
 	pci_ioaddr = ioremap(pci_iorange, pci_iolen);
-	if (! pci_iorange)
+	if (! pci_iorange) {
+		printk(KERN_ERR PFX "Cannot remap hardware registers\n");
 		goto fail;
+	}
 
 	/* Allocate network device */
 	dev = alloc_orinocodev(0, NULL);
@@ -226,18 +223,16 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	printk(KERN_DEBUG PFX
-	       "Detected Orinoco/Prism2 PCI device at %s, mem:0x%lX to 0x%lX -> 0x%p, irq:%d\n",
-	       pci_name(pdev), dev->mem_start, dev->mem_end, pci_ioaddr, pdev->irq);
-
 	hermes_struct_init(&priv->hw, pci_ioaddr, HERMES_32BIT_REGSPACING);
 	pci_set_drvdata(pdev, dev);
 
+	printk(KERN_DEBUG PFX "Detected device %s, mem:0x%lx-0x%lx, irq %d\n",
+	       pci_name(pdev), dev->mem_start, dev->mem_end, pdev->irq);
+
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR PFX "Error allocating IRQ %d.\n",
-		       pdev->irq);
+		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
 		err = -EBUSY;
 		goto fail;
 	}
@@ -245,7 +240,7 @@
 
 	/* Perform a COR reset to start the card */
 	if(orinoco_pci_cor_reset(priv) != 0) {
-		printk(KERN_ERR "%s: Failed to start the card\n", dev->name);
+		printk(KERN_ERR PFX "Initial reset failed\n");
 		err = -ETIMEDOUT;
 		goto fail;
 	}
@@ -256,7 +251,7 @@
 
 	err = register_netdev(dev);
 	if (err) {
-		printk(KERN_ERR "%s: Failed to register net device\n", dev->name);
+		printk(KERN_ERR PFX "Failed to register net device\n");
 		goto fail;
 	}
 
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.h	2005-01-12 14:47:25.792169968 +1100
@@ -127,7 +127,7 @@
 {
 	spin_lock_irqsave(&priv->lock, *flags);
 	if (priv->hw_unavailable) {
-		printk(KERN_DEBUG "orinoco_lock() called with hw_unavailable (dev=%p)\n",
+		DEBUG(1, "orinoco_lock() called with hw_unavailable (dev=%p)\n",
 		       priv->ndev);
 		spin_unlock_irqrestore(&priv->lock, *flags);
 		return -EBUSY;
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2005-01-12 14:47:25.793169816 +1100
@@ -92,8 +92,10 @@
 	void __iomem *mem;
 
 	err = pci_enable_device(pdev);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "Cannot enable PCI device\n");
 		return -EIO;
+	}
 
 	printk(KERN_DEBUG PFX "TMD setup\n");
 	pccard_ioaddr = pci_resource_start(pdev, 2);
@@ -117,6 +119,7 @@
 	/* Allocate network device */
 	dev = alloc_orinocodev(0, NULL);
 	if (! dev) {
+		printk(KERN_ERR PFX "Cannot allocate network device\n");
 		err = -ENOMEM;
 		goto out2;
 	}
@@ -132,26 +135,27 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
+	hermes_struct_init(&priv->hw, mem, HERMES_16BIT_REGSPACING);
+	pci_set_drvdata(pdev, dev);
+
 	printk(KERN_DEBUG PFX "Detected Orinoco/Prism2 TMD device "
 	       "at %s irq:%d, io addr:0x%lx\n", pci_name(pdev), pdev->irq,
 	       pccard_ioaddr);
 
-	hermes_struct_init(&(priv->hw), mem, HERMES_16BIT_REGSPACING);
-	pci_set_drvdata(pdev, dev);
-
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR PFX "Error allocating IRQ %d.\n",
-		       pdev->irq);
+		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
 		err = -EBUSY;
 		goto out4;
 	}
 	dev->irq = pdev->irq;
 
 	err = register_netdev(dev);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "Cannot register network device\n");
 		goto out5;
+	}
 
 	return 0;
 
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2005-01-12 14:47:25.793169816 +1100
@@ -405,7 +405,7 @@
 		last_ret = pcmcia_get_next_tuple(handle, &tuple);
 		if (last_ret  == CS_NO_MORE_ITEMS) {
 			printk(KERN_ERR PFX "GetNextTuple(): No matching "
-			       "CIS configuration, maybe you need the "
+			       "CIS configuration.  Maybe you need the "
 			       "ignore_cis_vcc=1 parameter.\n");
 			goto cs_failed;
 		}
Index: working-2.6/drivers/net/wireless/airport.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/airport.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/airport.c	2005-01-12 14:47:25.793169816 +1100
@@ -28,7 +28,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -194,14 +193,14 @@
 	hermes_t *hw;
 
 	if (macio_resource_count(mdev) < 1 || macio_irq_count(mdev) < 1) {
-		printk(KERN_ERR PFX "wrong interrupt/addresses in OF tree\n");
+		printk(KERN_ERR PFX "Wrong interrupt/addresses in OF tree\n");
 		return -ENODEV;
 	}
 
 	/* Allocate space for private device-specific data */
 	dev = alloc_orinocodev(sizeof(*card), airport_hard_reset);
 	if (! dev) {
-		printk(KERN_ERR PFX "can't allocate device datas\n");
+		printk(KERN_ERR PFX "Cannot allocate network device\n");
 		return -ENODEV;
 	}
 	priv = netdev_priv(dev);
@@ -224,11 +223,11 @@
 	/* Setup interrupts & base address */
 	dev->irq = macio_irq(mdev, 0);
 	phys_addr = macio_resource_start(mdev, 0);  /* Physical address */
-	printk(KERN_DEBUG PFX "Airport at physical address %lx\n", phys_addr);
+	printk(KERN_DEBUG PFX "Physical address %lx\n", phys_addr);
 	dev->base_addr = phys_addr;
 	card->vaddr = ioremap(phys_addr, AIRPORT_IO_LEN);
 	if (!card->vaddr) {
-		printk(PFX "ioremap() failed\n");
+		printk(KERN_ERR PFX "ioremap() failed\n");
 		goto failed;
 	}
 
@@ -241,7 +240,7 @@
 	/* Reset it before we get the interrupt */
 	hermes_init(hw);
 
-	if (request_irq(dev->irq, orinoco_interrupt, 0, "Airport", dev)) {
+	if (request_irq(dev->irq, orinoco_interrupt, 0, dev->name, dev)) {
 		printk(KERN_ERR PFX "Couldn't get IRQ %d\n", dev->irq);
 		goto failed;
 	}
@@ -252,7 +251,7 @@
 		printk(KERN_ERR PFX "register_netdev() failed\n");
 		goto failed;
 	}
-	printk(KERN_DEBUG PFX "card registered for interface %s\n", dev->name);
+	printk(KERN_DEBUG PFX "Card registered for interface %s\n", dev->name);
 	card->ndev_registered = 1;
 	return 0;
  failed:
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2005-01-12 14:48:57.890168944 +1100
@@ -167,15 +167,17 @@
 	int i;
 
 	err = pci_enable_device(pdev);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "Cannot enable PCI device\n");
 		return -EIO;
+	}
 
 	/* Resource 2 is mapped to the PCMCIA space */
 	attr_mem = ioremap(pci_resource_start(pdev, 2), PAGE_SIZE);
 	if (!attr_mem)
-		goto out;
+		goto fail_resources;
 
-	printk(KERN_DEBUG "orinoco_plx: CIS: ");
+	printk(KERN_DEBUG PFX "CIS: ");
 	for (i = 0; i < 16; i++) {
 		printk("%02X:", readw(attr_mem+i));
 	}
@@ -185,10 +187,11 @@
 	/* FIXME: we probably need to be smarted about this */
 	memcpy_fromio(magic, attr_mem, 16);
 	if (memcmp(magic, cis_magic, 16) != 0) {
-		printk(KERN_ERR "orinoco_plx: The CIS value of Prism2 PC card is invalid.\n");
+		printk(KERN_ERR PFX "The CIS value of Prism2 PC "
+		       "card is unexpected\n");
 		err = -EIO;
 		iounmap(attr_mem);
-		goto out;
+		goto fail_resources;
 	}
 
 	/* PCMCIA COR is the first byte following CIS: this write should
@@ -199,8 +202,8 @@
 	iounmap(attr_mem);
 
 	if (reg != COR_VALUE) {
-		printk(KERN_ERR "orinoco_plx: Error setting COR value (reg=%x)\n", reg);
-		goto out;
+		printk(KERN_ERR PFX "Error setting COR value (reg=%x)\n", reg);
+		goto fail_resources;
 	}			
 
 	/* bjoern: We need to tell the card to enable interrupts, in
@@ -209,40 +212,39 @@
 	addr = pci_resource_start(pdev, 1);
 	reg = inl(addr+PLX_INTCSR);
 	if (reg & PLX_INTCSR_INTEN)
-		printk(KERN_DEBUG "orinoco_plx: "
-		       "Local Interrupt already enabled\n");
+		printk(KERN_DEBUG PFX "Local Interrupt already enabled\n");
 	else {
 		reg |= PLX_INTCSR_INTEN;
 		outl(reg, addr+PLX_INTCSR);
 		reg = inl(addr+PLX_INTCSR);
 		if(!(reg & PLX_INTCSR_INTEN)) {
-			printk(KERN_ERR "orinoco_plx: "
-			       "Couldn't enable Local Interrupts\n");
-			goto out;
+			printk(KERN_ERR PFX "Couldn't enable Local Interrupts\n");
+			goto fail_resources;
 		}
 	}
 
-	/* and 3 to the PCMCIA slot I/O address space */
+	/* Resource 3 is mapped to the PCMCIA I/O address space */
 	pccard_ioaddr = pci_resource_start(pdev, 3);
 	pccard_iolen = pci_resource_len(pdev, 3);
 	if (! request_region(pccard_ioaddr, pccard_iolen, DRIVER_NAME)) {
-		printk(KERN_ERR "orinoco_plx: I/O resource 0x%lx @ 0x%lx busy\n",
+		printk(KERN_ERR PFX "I/O resource 0x%lx @ 0x%lx busy\n",
 		       pccard_iolen, pccard_ioaddr);
 		err = -EBUSY;
-		goto out;
+		goto fail_resources;
 	}
 
 	mem = pci_iomap(pdev, 3, 0);
 	if (!mem) {
 		err = -ENOMEM;
-		goto out1;
+		goto fail_map;
 	}
 
 	/* Allocate network device */
 	dev = alloc_orinocodev(0, NULL);
 	if (!dev) {
+		printk(KERN_ERR PFX "Cannot allocate network device\n");
 		err = -ENOMEM;
-		goto out2;
+		goto fail_alloc;
 	}
 
 	priv = netdev_priv(dev);
@@ -250,39 +252,41 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
+	hermes_struct_init(&priv->hw, mem, HERMES_16BIT_REGSPACING);
+	pci_set_drvdata(pdev, dev);
+
 	printk(KERN_DEBUG PFX "Detected Orinoco/Prism2 PLX device "
 	       "at %s irq:%d, io addr:0x%lx\n", pci_name(pdev), pdev->irq,
 	       pccard_ioaddr);
 
-	hermes_struct_init(&(priv->hw), mem, HERMES_16BIT_REGSPACING);
-	pci_set_drvdata(pdev, dev);
-
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
-		printk(KERN_ERR PFX "Error allocating IRQ %d.\n", pdev->irq);
+		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
 		err = -EBUSY;
-		goto out3;
+		goto fail_irq;
 	}
 	dev->irq = pdev->irq;
 
 	err = register_netdev(dev);
-	if (err)
-		goto out4;
+	if (err) {
+		printk(KERN_ERR PFX "Cannot register network device\n");
+		goto fail;
+	}
 
 	return 0;
 
-out4:
+ fail:
 	free_irq(dev->irq, dev);
-out3:
+ fail_irq:
 	free_netdev(dev);
-out2:
+ fail_alloc:
 	pci_iounmap(pdev, mem);
-out1:
+ fail_map:
 	release_region(pccard_ioaddr, pccard_iolen);
-out:
+ fail_resources:
 	pci_disable_device(pdev);
-	printk(KERN_DEBUG PFX "init_one(), FAIL!\n");
+
 	return err;
 }
 
Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-01-12 11:13:41.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-01-12 14:47:25.796169360 +1100
@@ -805,8 +805,9 @@
  	desc.tx_control = cpu_to_le16(HERMES_TXCTRL_TX_OK | HERMES_TXCTRL_TX_EX);
 	err = hermes_bap_pwrite(hw, USER_BAP, &desc, sizeof(desc), txfid, 0);
 	if (err) {
-		printk(KERN_ERR "%s: Error %d writing Tx descriptor to BAP\n",
-		       dev->name, err);
+		if (net_ratelimit())
+			printk(KERN_ERR "%s: Error %d writing Tx descriptor "
+			       "to BAP\n", dev->name, err);
 		stats->tx_errors++;
 		goto fail;
 	}
@@ -836,8 +837,9 @@
 		err  = hermes_bap_pwrite(hw, USER_BAP, &hdr, sizeof(hdr),
 					 txfid, HERMES_802_3_OFFSET);
 		if (err) {
-			printk(KERN_ERR "%s: Error %d writing packet header to BAP\n",
-			       dev->name, err);
+			if (net_ratelimit())
+				printk(KERN_ERR "%s: Error %d writing packet "
+				       "header to BAP\n", dev->name, err);
 			stats->tx_errors++;
 			goto fail;
 		}
@@ -1297,8 +1299,8 @@
 	}
 	break;
 	default:
-		printk(KERN_DEBUG "%s: Unknown information frame received "
-		       "(type %04x).\n", dev->name, type);
+		printk(KERN_DEBUG "%s: Unknown information frame received: "
+		       "type 0x%04x, length %d\n", dev->name, type, len);
 		/* We don't actually do anything about it */
 		break;
 	}
@@ -1307,7 +1309,7 @@
 static void __orinoco_ev_infdrop(struct net_device *dev, hermes_t *hw)
 {
 	if (net_ratelimit())
-		printk(KERN_WARNING "%s: Information frame lost.\n", dev->name);
+		printk(KERN_DEBUG "%s: Information frame lost.\n", dev->name);
 }
 
 /********************************************************************/
@@ -1785,7 +1787,8 @@
 		}
 		
 		if (p)
-			printk(KERN_WARNING "Multicast list is longer than mc_count\n");
+			printk(KERN_WARNING "%s: Multicast list is "
+			       "longer than mc_count\n", dev->name);
 
 		err = hermes_write_ltv(hw, USER_BAP, HERMES_RID_CNFGROUPADDRESSES,
 				       HERMES_BYTES_TO_RECLEN(priv->mc_count * ETH_ALEN),
@@ -2053,7 +2056,7 @@
 	le16_to_cpus(&sta_id.variant);
 	le16_to_cpus(&sta_id.major);
 	le16_to_cpus(&sta_id.minor);
-	printk(KERN_DEBUG "%s: Station identity %04x:%04x:%04x:%04x\n",
+	printk(KERN_DEBUG "%s: Station identity  %04x:%04x:%04x:%04x\n",
 	       dev->name, sta_id.id, sta_id.variant,
 	       sta_id.major, sta_id.minor);
 
@@ -3045,8 +3048,9 @@
 			priv->mwo_robust = 0;
 		else {
 			if (frq->fixed)
-				printk(KERN_WARNING "%s: Fixed fragmentation not \
-supported on this firmware. Using MWO robust instead.\n", dev->name);
+				printk(KERN_WARNING "%s: Fixed fragmentation is "
+				       "not supported on this firmware. "
+				       "Using MWO robust instead.\n", dev->name);
 			priv->mwo_robust = 1;
 		}
 	} else {
@@ -3518,7 +3522,7 @@
 		}
 		/* Copy stats */
 		/* In theory, we should disable irqs while copying the stats
-		 * because the rx path migh update it in the middle...
+		 * because the rx path might update it in the middle...
 		 * Bah, who care ? - Jean II */
 		memcpy(&spy_stat, priv->spy_stat,
 		       sizeof(struct iw_quality) * IW_MAX_SPY);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
