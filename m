Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUCOFOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCOFOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:14:21 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:45953 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262257AbUCOFOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:14:06 -0500
Date: Mon, 15 Mar 2004 00:10:30 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315001029.GB5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315000615.GA5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PARPORT] Update PC Parport Detection Code

This patch updates the parport_pc driver's probing code to better detect PnP
devices.  It also removes an extra MODULE_AUTHOR etc.

--- a/drivers/parport/parport_pc.c	2004-03-11 02:55:49.000000000 +0000
+++ b/drivers/parport/parport_pc.c	2004-03-13 23:43:58.000000000 +0000
@@ -13,6 +13,7 @@
  * Many ECP bugs fixed.  Fred Barnes & Jamie Lokier, 1999
  * More PCI support now conditional on CONFIG_PCI, 03/2001, Paul G. 
  * Various hacks, Fred Barnes, 04/2001
+ * Updated probing logic - Adam Belay <ambx1@neo.rr.com>
  */
 
 /* This driver should work with any hardware that is broadly compatible
@@ -98,7 +99,8 @@
        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
 static int verbose_probing;
 #endif
-static int registered_parport;
+static int pci_registered_parport;
+static int pnp_registered_parport;
 
 /* frob_control, but for ECR */
 static void frob_econtrol (struct parport *pb, unsigned char m,
@@ -2771,10 +2773,11 @@
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
 
-static int __devinit parport_pc_pci_probe (struct pci_dev *dev,
+static int parport_pc_pci_probe (struct pci_dev *dev,
 					   const struct pci_device_id *id)
 {
 	int err, count, n, i = id->driver_data;
+
 	if (i < last_sio)
 		/* This is an onboard Super-IO and has already been probed */
 		return 0;
@@ -2847,23 +2850,72 @@
 static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_PNP
-static const struct pnp_device_id pnp_dev_table[] = {
+
+static const struct pnp_device_id parport_pc_pnp_tbl[] = {
 	/* Standard LPT Printer Port */
 	{.id = "PNP0400", .driver_data = 0},
 	/* ECP Printer Port */
 	{.id = "PNP0401", .driver_data = 0},
-	{.id = ""}
+	{ }
 };
 
+MODULE_DEVICE_TABLE(pnp,parport_pc_pnp_tbl);
+
+static int parport_pc_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *id)
+{
+	struct parport *pdata;
+	unsigned long io_lo, io_hi;
+	int dma, irq;
+
+	if (pnp_port_valid(dev,0) &&
+		!(pnp_port_flags(dev,0) & IORESOURCE_DISABLED)) {
+		io_lo = pnp_port_start(dev,0);
+	} else
+		return -EINVAL;
+
+	if (pnp_port_valid(dev,1) &&
+		!(pnp_port_flags(dev,1) & IORESOURCE_DISABLED)) {
+		io_hi = pnp_port_start(dev,1);
+	} else
+		io_hi = 0;
+
+	if (pnp_irq_valid(dev,0) &&
+		!(pnp_irq_flags(dev,0) & IORESOURCE_DISABLED)) {
+		irq = pnp_irq(dev,0);
+	} else
+		irq = PARPORT_IRQ_NONE;
+
+	if (pnp_dma_valid(dev,0) &&
+		!(pnp_dma_flags(dev,0) & IORESOURCE_DISABLED)) {
+		dma = pnp_dma(dev,0);
+	} else
+		dma = PARPORT_DMA_NONE;
+
+	printk(KERN_INFO "parport: PnPBIOS parport detected.\n");
+	if (!(pdata = parport_pc_probe_port (io_lo, io_hi, irq, dma, NULL)))
+		return -ENODEV;
+
+	pnp_set_drvdata(dev,pdata);
+	return 0;
+}
+
+static void parport_pc_pnp_remove(struct pnp_dev *dev)
+{
+	struct parport *pdata = (struct parport *)pnp_get_drvdata(dev);
+	if (!pdata)
+		return;
+
+	parport_pc_unregister_port(pdata);
+}
+
 /* we only need the pnp layer to activate the device, at least for now */
 static struct pnp_driver parport_pc_pnp_driver = {
 	.name		= "parport_pc",
-	.id_table	= pnp_dev_table,
+	.id_table	= parport_pc_pnp_tbl,
+	.probe		= parport_pc_pnp_probe,
+	.remove		= parport_pc_pnp_remove,
 };
-#else
-static struct pnp_driver parport_pc_pnp_driver;
-#endif
+
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
 static int __init __attribute__((unused))
@@ -2903,12 +2955,18 @@
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
 	count += parport_pc_init_superio (autoirq, autodma);
 
+	r = pnp_register_driver (&parport_pc_pnp_driver);
+	if (r >= 0) {
+		pnp_registered_parport = 1;
+		count += r;
+	}
+
 	/* ISA ports and whatever (see asm/parport.h). */
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
 	if (r >= 0) {
-		registered_parport = 1;
+		pci_registered_parport = 1;
 		count += r;
 	}
 
@@ -3104,9 +3162,6 @@
 	if (parse_parport_params())
 		return -EINVAL;
 
-	/* try to activate any PnP parports first */
-	pnp_register_driver(&parport_pc_pnp_driver);
-
 	if (io[0]) {
 		int i;
 		/* Only probe the ports we were given. */
@@ -3120,24 +3175,18 @@
 						  irqval[i], dmaval[i], NULL))
 				count++;
 		}
-	} else {
+	} else
 		count += parport_pc_find_ports (irqval[0], dmaval[0]);
-		if (!count && registered_parport)
-			pci_unregister_driver (&parport_pc_pci_driver);
-	}
-
-	if (!count) {
-		pnp_unregister_driver (&parport_pc_pnp_driver);
-		return -ENODEV;
-	}
 
 	return 0;
 }
 
 static void __exit parport_pc_exit(void)
 {
-	if (registered_parport)
+	if (pci_registered_parport)
 		pci_unregister_driver (&parport_pc_pci_driver);
+	if (pnp_registered_parport)
+		pnp_unregister_driver (&parport_pc_pnp_driver);
 
 	spin_lock(&ports_lock);
 	while (!list_empty(&ports_list)) {
@@ -3151,13 +3200,8 @@
 		spin_lock(&ports_lock);
 	}
 	spin_unlock(&ports_lock);
-	pnp_unregister_driver (&parport_pc_pnp_driver);
 }
 
-
-MODULE_AUTHOR("Phil Blundell, Tim Waugh, others");
-MODULE_DESCRIPTION("PC-style parallel port driver");
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Phil Blundell, Tim Waugh, others");
 MODULE_DESCRIPTION("PC-style parallel port driver");
 MODULE_LICENSE("GPL");
