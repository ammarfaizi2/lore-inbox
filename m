Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVALFln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVALFln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVALFlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:41:07 -0500
Received: from ozlabs.org ([203.10.76.45]:3729 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263105AbVALF3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:48 -0500
Date: Wed, 12 Jan 2005 16:29:35 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [8/8] orinoco: PCI/PLX/TMD driver updates
Message-ID: <20050112052935.GI30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain> <20050112052434.GB30426@localhost.localdomain> <20050112052543.GC30426@localhost.localdomain> <20050112052630.GD30426@localhost.localdomain> <20050112052711.GE30426@localhost.localdomain> <20050112052741.GF30426@localhost.localdomain> <20050112052814.GG30426@localhost.localdomain> <20050112052848.GH30426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112052848.GH30426@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the initialization code in the various PCI incarnations of the
orinoco driver.  This applies similar initialization and shutdown
cleanups to the orinoco_pci, orinoco_plx and orinoco_tmd drivers.  It
also adds COR reset support to the orinoco_plx and orinoco_tmd
drivers, improves PCI power management support in the orinoco_pci
driver and adds a couple of extra supported cards to the ID tables.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2005-01-12 15:47:48.215477920 +1100
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2005-01-12 16:10:57.324301280 +1100
@@ -129,6 +129,11 @@
 #define HERMES_PCI_COR_OFFT	(500)		/* ms */
 #define HERMES_PCI_COR_BUSYT	(500)		/* ms */
 
+/* Orinoco PCI specific data */
+struct orinoco_pci_card {
+	void __iomem *pci_ioaddr;
+};
+
 /*
  * Do a soft reset of the PCI card using the Configuration Option Register
  * We need this to get going...
@@ -164,8 +169,9 @@
 		mdelay(1);
 		reg = hermes_read_regn(hw, CMD);
 	}
-	/* Did we timeout ? */
-	if(time_after_eq(jiffies, timeout)) {
+
+	/* Still busy? */
+	if (reg & HERMES_CMD_BUSY) {
 		printk(KERN_ERR PFX "Busy timeout\n");
 		return -ETIMEDOUT;
 	}
@@ -184,6 +190,7 @@
 	u16 __iomem *pci_ioaddr = NULL;
 	unsigned long pci_iolen;
 	struct orinoco_private *priv = NULL;
+	struct orinoco_pci_card *card;
 	struct net_device *dev = NULL;
 
 	err = pci_enable_device(pdev);
@@ -192,24 +199,31 @@
 		return err;
 	}
 
+	err = pci_request_regions(pdev, DRIVER_NAME);
+	if (err != 0) {
+		printk(KERN_ERR PFX "Cannot obtain PCI resources\n");
+		goto fail_resources;
+	}
+
 	/* Resource 0 is mapped to the hermes registers */
 	pci_iorange = pci_resource_start(pdev, 0);
 	pci_iolen = pci_resource_len(pdev, 0);
 	pci_ioaddr = ioremap(pci_iorange, pci_iolen);
-	if (! pci_iorange) {
+	if (!pci_iorange) {
 		printk(KERN_ERR PFX "Cannot remap hardware registers\n");
-		goto fail;
+		goto fail_map;
 	}
 
 	/* Allocate network device */
-	dev = alloc_orinocodev(0, NULL);
+	dev = alloc_orinocodev(sizeof(*card), orinoco_pci_cor_reset);
 	if (! dev) {
 		err = -ENOMEM;
-		goto fail;
+		goto fail_alloc;
 	}
 
 	priv = netdev_priv(dev);
-	dev->base_addr = (unsigned long) pci_ioaddr;
+	card = priv->card;
+	card->pci_ioaddr = pci_ioaddr;
 	dev->mem_start = pci_iorange;
 	dev->mem_end = pci_iorange + pci_iolen - 1;
 	SET_MODULE_OWNER(dev);
@@ -226,14 +240,14 @@
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
 		err = -EBUSY;
-		goto fail;
+		goto fail_irq;
 	}
 	dev->irq = pdev->irq;
 
 	/* Perform a COR reset to start the card */
-	if(orinoco_pci_cor_reset(priv) != 0) {
+	err = orinoco_pci_cor_reset(priv);
+	if (err) {
 		printk(KERN_ERR PFX "Initial reset failed\n");
-		err = -ETIMEDOUT;
 		goto fail;
 	}
 
@@ -250,16 +264,19 @@
 	return 0;
 
  fail:
-	if (dev) {
-		if (dev->irq)
-			free_irq(dev->irq, dev);
+	free_irq(pdev->irq, dev);
 
-		free_orinocodev(dev);
-	}
+ fail_irq:
+	pci_set_drvdata(pdev, NULL);
+	free_orinocodev(dev);
+
+ fail_alloc:
+	iounmap(pci_ioaddr);
 
-	if (pci_ioaddr)
-		iounmap(pci_ioaddr);
+ fail_map:
+	pci_release_regions(pdev);
 
+ fail_resources:
 	pci_disable_device(pdev);
 
 	return err;
@@ -269,18 +286,14 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct orinoco_private *priv = netdev_priv(dev);
+	struct orinoco_pci_card *card = priv->card;
 
 	unregister_netdev(dev);
-
-	if (dev->irq)
-		free_irq(dev->irq, dev);
-
-	if (priv->hw.iobase)
-		iounmap(priv->hw.iobase);
-
+	free_irq(dev->irq, dev);
 	pci_set_drvdata(pdev, NULL);
 	free_orinocodev(dev);
-
+	iounmap(card->pci_ioaddr);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
@@ -312,6 +325,9 @@
 	
 	orinoco_unlock(priv, &flags);
 
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, 3);
+
 	return 0;
 }
 
@@ -324,6 +340,9 @@
 
 	printk(KERN_DEBUG "%s: Orinoco-PCI waking up\n", dev->name);
 
+	pci_set_power_state(pdev, 0);
+	pci_restore_state(pdev);
+
 	err = orinoco_reinit_firmware(dev);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d re-initializing firmware on orinoco_pci_resume()\n",
@@ -354,6 +373,8 @@
 	{0x1260, 0x3872, PCI_ANY_ID, PCI_ANY_ID,},
 	/* Intersil Prism 2.5 */
 	{0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
+	/* Samsung MagicLAN SWL-2210P */
+	{0x167d, 0xa000, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
 
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2005-01-12 15:47:48.216477768 +1100
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-11-05 14:20:30.000000000 +1100
@@ -142,26 +142,68 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-#define COR_OFFSET	(0x3e0/2) /* COR attribute offset of Prism2 PC card */
+#define COR_OFFSET	(0x3e0)	/* COR attribute offset of Prism2 PC card */
 #define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
+#define COR_RESET     (0x80)	/* reset bit in the COR register */
+#define PLX_RESET_TIME	(500)	/* milliseconds */
 
 #define PLX_INTCSR		0x4c /* Interrupt Control & Status Register */
 #define PLX_INTCSR_INTEN	(1<<6) /* Interrupt Enable bit */
 
-static const u16 cis_magic[] = {
-	0x0001, 0x0003, 0x0000, 0x0000, 0x00ff, 0x0017, 0x0004, 0x0067
+static const u8 cis_magic[] = {
+	0x01, 0x03, 0x00, 0x00, 0xff, 0x17, 0x04, 0x67
 };
 
+/* Orinoco PLX specific data */
+struct orinoco_plx_card {
+	void __iomem *attr_mem;
+};
+
+/*
+ * Do a soft reset of the card using the Configuration Option Register
+ */
+static int orinoco_plx_cor_reset(struct orinoco_private *priv)
+{
+	hermes_t *hw = &priv->hw;
+	struct orinoco_plx_card *card = priv->card;
+	u8 __iomem *attr_mem = card->attr_mem;
+	unsigned long timeout;
+	u16 reg;
+
+	writeb(COR_VALUE | COR_RESET, attr_mem + COR_OFFSET);
+	mdelay(1);
+
+	writeb(COR_VALUE, attr_mem + COR_OFFSET);
+	mdelay(1);
+
+	/* Just in case, wait more until the card is no longer busy */
+	timeout = jiffies + (PLX_RESET_TIME * HZ / 1000);
+	reg = hermes_read_regn(hw, CMD);
+	while (time_before(jiffies, timeout) && (reg & HERMES_CMD_BUSY)) {
+		mdelay(1);
+		reg = hermes_read_regn(hw, CMD);
+	}
+
+	/* Did we timeout ? */
+	if (reg & HERMES_CMD_BUSY) {
+		printk(KERN_ERR PFX "Busy timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+
 static int orinoco_plx_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int err = 0;
-	u16 __iomem *attr_mem = NULL;
-	u32 reg, addr;
+	u8 __iomem *attr_mem = NULL;
+	u32 csr_reg, plx_addr;
 	struct orinoco_private *priv = NULL;
+	struct orinoco_plx_card *card;
 	unsigned long pccard_ioaddr = 0;
 	unsigned long pccard_iolen = 0;
-	u16 magic[8];
 	struct net_device *dev = NULL;
 	void __iomem *mem;
 	int i;
@@ -169,78 +211,38 @@
 	err = pci_enable_device(pdev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot enable PCI device\n");
-		return -EIO;
+		return err;
 	}
 
-	/* Resource 2 is mapped to the PCMCIA space */
-	attr_mem = ioremap(pci_resource_start(pdev, 2), PAGE_SIZE);
-	if (!attr_mem)
+	err = pci_request_regions(pdev, DRIVER_NAME);
+	if (err != 0) {
+		printk(KERN_ERR PFX "Cannot obtain PCI resources\n");
 		goto fail_resources;
-
-	printk(KERN_DEBUG PFX "CIS: ");
-	for (i = 0; i < 16; i++) {
-		printk("%02X:", readw(attr_mem+i));
 	}
-	printk("\n");
-
-	/* Verify whether PC card is present */
-	/* FIXME: we probably need to be smarted about this */
-	memcpy_fromio(magic, attr_mem, 16);
-	if (memcmp(magic, cis_magic, 16) != 0) {
-		printk(KERN_ERR PFX "The CIS value of Prism2 PC "
-		       "card is unexpected\n");
-		err = -EIO;
-		iounmap(attr_mem);
-		goto fail_resources;
-	}
-
-	/* PCMCIA COR is the first byte following CIS: this write should
-	 * enable I/O mode and select level-triggered interrupts */
-	writew(COR_VALUE, attr_mem + COR_OFFSET);
-	mdelay(1);
-	reg = readw(attr_mem + COR_OFFSET);
-	iounmap(attr_mem);
 
-	if (reg != COR_VALUE) {
-		printk(KERN_ERR PFX "Error setting COR value (reg=%x)\n", reg);
-		goto fail_resources;
-	}			
+	/* Resource 1 is mapped to PLX-specific registers */
+	plx_addr = pci_resource_start(pdev, 1);
 
-	/* bjoern: We need to tell the card to enable interrupts, in
-	   case the serial eprom didn't do this already. See the
-	   PLX9052 data book, p8-1 and 8-24 for reference. */
-	addr = pci_resource_start(pdev, 1);
-	reg = inl(addr+PLX_INTCSR);
-	if (reg & PLX_INTCSR_INTEN)
-		printk(KERN_DEBUG PFX "Local Interrupt already enabled\n");
-	else {
-		reg |= PLX_INTCSR_INTEN;
-		outl(reg, addr+PLX_INTCSR);
-		reg = inl(addr+PLX_INTCSR);
-		if(!(reg & PLX_INTCSR_INTEN)) {
-			printk(KERN_ERR PFX "Couldn't enable Local Interrupts\n");
-			goto fail_resources;
-		}
+	/* Resource 2 is mapped to the PCMCIA attribute memory */
+	attr_mem = ioremap(pci_resource_start(pdev, 2),
+			   pci_resource_len(pdev, 2));
+	if (!attr_mem) {
+		printk(KERN_ERR PFX "Cannot remap PCMCIA space\n");
+		goto fail_map_attr;
 	}
 
 	/* Resource 3 is mapped to the PCMCIA I/O address space */
 	pccard_ioaddr = pci_resource_start(pdev, 3);
 	pccard_iolen = pci_resource_len(pdev, 3);
-	if (! request_region(pccard_ioaddr, pccard_iolen, DRIVER_NAME)) {
-		printk(KERN_ERR PFX "I/O resource 0x%lx @ 0x%lx busy\n",
-		       pccard_iolen, pccard_ioaddr);
-		err = -EBUSY;
-		goto fail_resources;
-	}
 
 	mem = pci_iomap(pdev, 3, 0);
 	if (!mem) {
 		err = -ENOMEM;
-		goto fail_map;
+		goto fail_map_io;
 	}
 
 	/* Allocate network device */
-	dev = alloc_orinocodev(0, NULL);
+	dev = alloc_orinocodev(sizeof(*card), orinoco_plx_cor_reset);
 	if (!dev) {
 		printk(KERN_ERR PFX "Cannot allocate network device\n");
 		err = -ENOMEM;
@@ -248,6 +250,8 @@
 	}
 
 	priv = netdev_priv(dev);
+	card = priv->card;
+	card->attr_mem = attr_mem;
 	dev->base_addr = pccard_ioaddr;
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -268,6 +272,43 @@
 	}
 	dev->irq = pdev->irq;
 
+	/* bjoern: We need to tell the card to enable interrupts, in
+	   case the serial eprom didn't do this already.  See the
+	   PLX9052 data book, p8-1 and 8-24 for reference. */
+	csr_reg = inl(plx_addr + PLX_INTCSR);
+	if (!(csr_reg & PLX_INTCSR_INTEN)) {
+		csr_reg |= PLX_INTCSR_INTEN;
+		outl(csr_reg, plx_addr + PLX_INTCSR);
+		csr_reg = inl(plx_addr + PLX_INTCSR);
+		if (!(csr_reg & PLX_INTCSR_INTEN)) {
+			printk(KERN_ERR PFX "Cannot enable interrupts\n");
+			goto fail;
+		}
+	}
+
+	err = orinoco_plx_cor_reset(priv);
+	if (err) {
+		printk(KERN_ERR PFX "Initial reset failed\n");
+		goto fail;
+	}
+
+	printk(KERN_DEBUG PFX "CIS: ");
+	for (i = 0; i < 16; i++) {
+		printk("%02X:", readb(attr_mem + 2*i));
+	}
+	printk("\n");
+
+	/* Verify whether a supported PC card is present */
+	/* FIXME: we probably need to be smarted about this */
+	for (i = 0; i < sizeof(cis_magic); i++) {
+		if (cis_magic[i] != readb(attr_mem +2*i)) {
+			printk(KERN_ERR PFX "The CIS value of Prism2 PC "
+			       "card is unexpected\n");
+			err = -EIO;
+			goto fail;
+		}
+	}
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot register network device\n");
@@ -277,13 +318,21 @@
 	return 0;
 
  fail:
-	free_irq(dev->irq, dev);
+	free_irq(pdev->irq, dev);
+
  fail_irq:
+	pci_set_drvdata(pdev, NULL);
 	free_orinocodev(dev);
+
  fail_alloc:
 	pci_iounmap(pdev, mem);
- fail_map:
-	release_region(pccard_ioaddr, pccard_iolen);
+
+ fail_map_io:
+	iounmap(attr_mem);
+
+ fail_map_attr:
+	pci_release_regions(pdev);
+
  fail_resources:
 	pci_disable_device(pdev);
 
@@ -294,20 +343,18 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct orinoco_private *priv = netdev_priv(dev);
+	struct orinoco_plx_card *card = priv->card;
+	u8 __iomem *attr_mem = card->attr_mem;
 
-	unregister_netdev(dev);
-		
-	if (dev->irq)
-		free_irq(dev->irq, dev);
+	BUG_ON(! dev);
 
-	pci_iounmap(pdev, priv->hw.iobase);
-		
+	unregister_netdev(dev);
+	free_irq(dev->irq, dev);
 	pci_set_drvdata(pdev, NULL);
-
 	free_orinocodev(dev);
-
-	release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
-
+	pci_iounmap(pdev, priv->hw.iobase);
+	iounmap(attr_mem);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2005-01-12 15:47:48.216477768 +1100
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-11-05 14:37:35.000000000 +1100
@@ -79,59 +79,89 @@
 #include "orinoco.h"
 
 #define COR_VALUE	(COR_LEVEL_REQ | COR_FUNC_ENA) /* Enable PC card with interrupt in level trigger */
+#define COR_RESET     (0x80)	/* reset bit in the COR register */
+#define TMD_RESET_TIME	(500)	/* milliseconds */
+
+/* Orinoco TMD specific data */
+struct orinoco_tmd_card {
+	u32 tmd_io;
+};
+
+
+/*
+ * Do a soft reset of the card using the Configuration Option Register
+ */
+static int orinoco_tmd_cor_reset(struct orinoco_private *priv)
+{
+	hermes_t *hw = &priv->hw;
+	struct orinoco_tmd_card *card = priv->card;
+	u32 addr = card->tmd_io;
+	unsigned long timeout;
+	u16 reg;
+
+	outb(COR_VALUE | COR_RESET, addr);
+	mdelay(1);
+
+	outb(COR_VALUE, addr);
+	mdelay(1);
+
+	/* Just in case, wait more until the card is no longer busy */
+	timeout = jiffies + (TMD_RESET_TIME * HZ / 1000);
+	reg = hermes_read_regn(hw, CMD);
+	while (time_before(jiffies, timeout) && (reg & HERMES_CMD_BUSY)) {
+		mdelay(1);
+		reg = hermes_read_regn(hw, CMD);
+	}
+
+	/* Did we timeout ? */
+	if (reg & HERMES_CMD_BUSY) {
+		printk(KERN_ERR PFX "Busy timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 
 static int orinoco_tmd_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int err = 0;
-	u32 reg, addr;
 	struct orinoco_private *priv = NULL;
-	unsigned long pccard_ioaddr = 0;
-	unsigned long pccard_iolen = 0;
+	struct orinoco_tmd_card *card;
 	struct net_device *dev = NULL;
 	void __iomem *mem;
 
 	err = pci_enable_device(pdev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot enable PCI device\n");
-		return -EIO;
+		return err;
 	}
 
-	printk(KERN_DEBUG PFX "TMD setup\n");
-	pccard_ioaddr = pci_resource_start(pdev, 2);
-	pccard_iolen = pci_resource_len(pdev, 2);
-	if (! request_region(pccard_ioaddr, pccard_iolen, DRIVER_NAME)) {
-		printk(KERN_ERR PFX "I/O resource at 0x%lx len 0x%lx busy\n",
-			pccard_ioaddr, pccard_iolen);
-		err = -EBUSY;
-		goto out;
+	err = pci_request_regions(pdev, DRIVER_NAME);
+	if (err != 0) {
+		printk(KERN_ERR PFX "Cannot obtain PCI resources\n");
+		goto fail_resources;
 	}
-	addr = pci_resource_start(pdev, 1);
-	outb(COR_VALUE, addr);
-	mdelay(1);
-	reg = inb(addr);
-	if (reg != COR_VALUE) {
-		printk(KERN_ERR PFX "Error setting TMD COR values %x should be %x\n", reg, COR_VALUE);
-		err = -EIO;
-		goto out2;
+
+	mem = pci_iomap(pdev, 2, 0);
+	if (! mem) {
+		err = -ENOMEM;
+		goto fail_iomap;
 	}
 
 	/* Allocate network device */
-	dev = alloc_orinocodev(0, NULL);
+	dev = alloc_orinocodev(sizeof(*card), orinoco_tmd_cor_reset);
 	if (! dev) {
 		printk(KERN_ERR PFX "Cannot allocate network device\n");
 		err = -ENOMEM;
-		goto out2;
-	}
-
-	mem = pci_iomap(pdev, 2, 0);
-	if (!mem) {
-		err = -ENOMEM;
-		goto out3;
+		goto fail_alloc;
 	}
 
 	priv = netdev_priv(dev);
-	dev->base_addr = pccard_ioaddr;
+	card = priv->card;
+	card->tmd_io = pci_resource_start(pdev, 1);
+	dev->base_addr = pci_resource_start(pdev, 2);
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -140,36 +170,46 @@
 
 	printk(KERN_DEBUG PFX "Detected Orinoco/Prism2 TMD device "
 	       "at %s irq:%d, io addr:0x%lx\n", pci_name(pdev), pdev->irq,
-	       pccard_ioaddr);
+	       dev->base_addr);
 
 	err = request_irq(pdev->irq, orinoco_interrupt, SA_SHIRQ,
 			  dev->name, dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot allocate IRQ %d\n", pdev->irq);
 		err = -EBUSY;
-		goto out4;
+		goto fail_irq;
 	}
 	dev->irq = pdev->irq;
 
+	err = orinoco_tmd_cor_reset(priv);
+	if (err) {
+		printk(KERN_ERR PFX "Initial reset failed\n");
+		goto fail;
+	}
+
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_ERR PFX "Cannot register network device\n");
-		goto out5;
+		goto fail;
 	}
 
 	return 0;
 
-out5:
-	free_irq(dev->irq, dev);
-out4:
-	pci_iounmap(pdev, mem);
-out3:
+ fail:
+	free_irq(pdev->irq, dev);
+
+ fail_irq:
+	pci_set_drvdata(pdev, NULL);
 	free_orinocodev(dev);
-out2:
-	release_region(pccard_ioaddr, pccard_iolen);
-out:
+
+ fail_alloc:
+	pci_iounmap(pdev, mem);
+
+ fail_iomap:
+	pci_release_regions(pdev);
+
+ fail_resources:
 	pci_disable_device(pdev);
-	printk(KERN_DEBUG PFX "init_one(), FAIL!\n");
 
 	return err;
 }
@@ -177,21 +217,16 @@
 static void __devexit orinoco_tmd_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = netdev_priv(dev);
+	struct orinoco_private *priv = dev->priv;
 
-	unregister_netdev(dev);
-		
-	if (dev->irq)
-		free_irq(dev->irq, dev);
-
-	pci_iounmap(pdev, priv->hw.iobase);
+	BUG_ON(! dev);
 
+	unregister_netdev(dev);
+	free_irq(dev->irq, dev);
 	pci_set_drvdata(pdev, NULL);
-
 	free_orinocodev(dev);
-
-	release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
-
+	pci_iounmap(pdev, priv->hw.iobase);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
