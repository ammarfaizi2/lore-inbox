Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVARPqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVARPqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVARPqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:46:34 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:14555 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261327AbVARPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:35:36 -0500
Date: Tue, 18 Jan 2005 09:35:19 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       netdev@oss.sgi.com
Subject: [PATCH 4/4] ppc32: platform_device conversion from OCP
Message-ID: <Pine.LNX.4.61.0501180933150.11311@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert gianfar ethernet driver from using an OCP to platform_device.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2005-01-17 22:31:44 -06:00
+++ b/drivers/net/gianfar.c	2005-01-17 22:31:44 -06:00
@@ -26,7 +26,7 @@
  *  controllers on the Freescale 8540/8560 integrated processors,
  *  as well as the Fast Ethernet Controller on the 8540.  
  *  
- *  The driver is initialized through OCP.  Structures which
+ *  The driver is initialized through platform_device.  Structures which
  *  define the configuration needed by the board are defined in a
  *  board structure in arch/ppc/platforms (though I do not
  *  discount the possibility that other architectures could one
@@ -85,6 +85,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -130,8 +131,8 @@
 static void adjust_link(struct net_device *dev);
 static void init_registers(struct net_device *dev);
 static int init_phy(struct net_device *dev);
-static int gfar_probe(struct ocp_device *ocpdev);
-static void gfar_remove(struct ocp_device *ocpdev);
+static int gfar_probe(struct device *device);
+static int gfar_remove(struct device *device);
 void free_skb_resources(struct gfar_private *priv);
 static void gfar_set_multi(struct net_device *dev);
 static void gfar_set_hash_for_addr(struct net_device *dev, u8 *addr);
@@ -148,45 +149,27 @@
 MODULE_DESCRIPTION("Gianfar Ethernet Driver");
 MODULE_LICENSE("GPL");
 
-/* Called by the ocp code to initialize device data structures
- * required for bringing up the device
- * returns 0 on success */
-static int gfar_probe(struct ocp_device *ocpdev)
+static int gfar_probe(struct device *device)
 {
 	u32 tempval;
-	struct ocp_device *mdiodev;
 	struct net_device *dev = NULL;
 	struct gfar_private *priv = NULL;
-	struct ocp_gfar_data *einfo;
+	struct platform_device *pdev = to_platform_device(device);
+	struct gianfar_platform_data *einfo;
+	struct resource *r;
 	int idx;
 	int err = 0;
 	int dev_ethtool_ops = 0;
 
-	einfo = (struct ocp_gfar_data *) ocpdev->def->additions;
+	einfo = (struct gianfar_platform_data *) pdev->dev.platform_data;
 
 	if (einfo == NULL) {
 		printk(KERN_ERR "gfar %d: Missing additional data!\n",
-		       ocpdev->def->index);
+		       pdev->id);
 
 		return -ENODEV;
 	}
-
-	/* get a pointer to the register memory which can
-	 * configure the PHYs.  If it's different from this set,
-	 * get the device which has those regs */
-	if ((einfo->phyregidx >= 0) && 
-			(einfo->phyregidx != ocpdev->def->index)) {
-		mdiodev = ocp_find_device(OCP_ANY_ID,
-					  OCP_FUNC_GFAR, einfo->phyregidx);
-
-		/* If the device which holds the MDIO regs isn't
-		 * up, wait for it to come up */
-		if (mdiodev == NULL)
-			return -EAGAIN;
-	} else {
-		mdiodev = ocpdev;
-	}
-
+	
 	/* Create an ethernet device instance */
 	dev = alloc_etherdev(sizeof (*priv));
 
@@ -198,9 +181,19 @@
 	/* Set the info in the priv to the current info */
 	priv->einfo = einfo;
 
+	/* fill out IRQ fields */
+	if (einfo->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
+		priv->interruptTransmit = platform_get_irq_byname(pdev, "tx");
+		priv->interruptReceive = platform_get_irq_byname(pdev, "rx");
+		priv->interruptError = platform_get_irq_byname(pdev, "error");
+	} else {
+		priv->interruptTransmit = platform_get_irq(pdev, 0);
+	}
+
 	/* get a pointer to the register memory */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->regs = (struct gfar *)
-		ioremap(ocpdev->def->paddr, sizeof (struct gfar));
+		ioremap(r->start, sizeof (struct gfar));
 
 	if (priv->regs == NULL) {
 		err = -ENOMEM;
@@ -209,7 +202,7 @@
 
 	/* Set the PHY base address */
 	priv->phyregs = (struct gfar *)
-	    ioremap(mdiodev->def->paddr, sizeof (struct gfar));
+	    ioremap(einfo->phy_reg_addr, sizeof (struct gfar));
 
 	if (priv->phyregs == NULL) {
 		err = -ENOMEM;
@@ -218,7 +211,7 @@
 
 	spin_lock_init(&priv->lock);
 
-	ocp_set_drvdata(ocpdev, dev);
+	dev_set_drvdata(device, dev);
 
 	/* Stop the DMA engine now, in case it was running before */
 	/* (The firmware could have used it, and left it running). */
@@ -255,7 +248,7 @@
 	dev->base_addr = (unsigned long) (priv->regs);
 
 	SET_MODULE_OWNER(dev);
-	SET_NETDEV_DEV(dev, &ocpdev->dev);
+	SET_NETDEV_DEV(dev, device);
 
 	/* Fill in the dev structure */
 	dev->open = gfar_enet_open;
@@ -274,10 +267,10 @@
 
 	/* Index into the array of possible ethtool
 	 * ops to catch all 4 possibilities */
-	if((priv->einfo->flags & GFAR_HAS_RMON) == 0)
+	if((priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_RMON) == 0)
 		dev_ethtool_ops += 1;
 
-	if((priv->einfo->flags & GFAR_HAS_COALESCE) == 0)
+	if((priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_COALESCE) == 0)
 		dev_ethtool_ops += 2;
 
 	dev->ethtool_ops = gfar_op_array[dev_ethtool_ops];
@@ -332,18 +325,21 @@
 	return -ENOMEM;
 }
 
-static void gfar_remove(struct ocp_device *ocpdev)
+static int gfar_remove(struct device *device)
 {
-	struct net_device *dev = ocp_get_drvdata(ocpdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct gfar_private *priv = netdev_priv(dev);
 
-	ocp_set_drvdata(ocpdev, NULL);
+	dev_set_drvdata(device, NULL);
 
 	iounmap((void *) priv->regs);
 	iounmap((void *) priv->phyregs);
 	free_netdev(dev);
+
+	return 0;
 }
 
+
 /* Configure the PHY for dev.
  * returns 0 if success.  -1 if failure
  */
@@ -470,7 +466,7 @@
 	gfar_write(&priv->regs->rctrl, 0x00000000);
 
 	/* Zero out the rmon mib registers if it has them */
-	if (priv->einfo->flags & GFAR_HAS_RMON) {
+	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_RMON) {
 		memset((void *) &(priv->regs->rmon), 0,
 		       sizeof (struct rmon_mib));
 
@@ -536,7 +532,7 @@
 	tempval &= ~(MACCFG1_RX_EN | MACCFG1_TX_EN);
 	gfar_write(&regs->maccfg1, tempval);
 
-	if (priv->einfo->flags & GFAR_HAS_PHY_INTR) {
+	if (priv->einfo->board_flags & FSL_GIANFAR_BRD_HAS_PHY_INTR) {
 		/* Clear any pending interrupts */
 		mii_clear_phy_interrupt(priv->mii_info);
 
@@ -548,15 +544,15 @@
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Free the IRQs */
-	if (priv->einfo->flags & GFAR_HAS_MULTI_INTR) {
-		free_irq(priv->einfo->interruptError, dev);
-		free_irq(priv->einfo->interruptTransmit, dev);
-		free_irq(priv->einfo->interruptReceive, dev);
+	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
+		free_irq(priv->interruptError, dev);
+		free_irq(priv->interruptTransmit, dev);
+		free_irq(priv->interruptReceive, dev);
 	} else {
-		free_irq(priv->einfo->interruptTransmit, dev);
+		free_irq(priv->interruptTransmit, dev);
 	}
 
-	if (priv->einfo->flags & GFAR_HAS_PHY_INTR) {
+	if (priv->einfo->board_flags & FSL_GIANFAR_BRD_HAS_PHY_INTR) {
 		free_irq(priv->einfo->interruptPHY, dev);
 	} else {
 		del_timer_sync(&priv->phy_info_timer);
@@ -727,41 +723,41 @@
 
 	/* If the device has multiple interrupts, register for
 	 * them.  Otherwise, only register for the one */
-	if (priv->einfo->flags & GFAR_HAS_MULTI_INTR) {
+	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
 		/* Install our interrupt handlers for Error, 
 		 * Transmit, and Receive */
-		if (request_irq(priv->einfo->interruptError, gfar_error,
+		if (request_irq(priv->interruptError, gfar_error,
 				0, "enet_error", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptError);
+			       dev->name, priv->interruptError);
 
 			err = -1;
 			goto err_irq_fail;
 		}
 
-		if (request_irq(priv->einfo->interruptTransmit, gfar_transmit,
+		if (request_irq(priv->interruptTransmit, gfar_transmit,
 				0, "enet_tx", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptTransmit);
+			       dev->name, priv->interruptTransmit);
 
 			err = -1;
 
 			goto tx_irq_fail;
 		}
 
-		if (request_irq(priv->einfo->interruptReceive, gfar_receive,
+		if (request_irq(priv->interruptReceive, gfar_receive,
 				0, "enet_rx", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d (receive0)\n",
-			       dev->name, priv->einfo->interruptReceive);
+			       dev->name, priv->interruptReceive);
 
 			err = -1;
 			goto rx_irq_fail;
 		}
 	} else {
-		if (request_irq(priv->einfo->interruptTransmit, gfar_interrupt,
+		if (request_irq(priv->interruptTransmit, gfar_interrupt,
 				0, "gfar_interrupt", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptError);
+			       dev->name, priv->interruptError);
 
 			err = -1;
 			goto err_irq_fail;
@@ -815,9 +811,9 @@
 	return 0;
 
 rx_irq_fail:
-	free_irq(priv->einfo->interruptTransmit, dev);
+	free_irq(priv->interruptTransmit, dev);
 tx_irq_fail:
-	free_irq(priv->einfo->interruptError, dev);
+	free_irq(priv->interruptError, dev);
 err_irq_fail:
 rx_skb_fail:
 	free_skb_resources(priv);
@@ -1490,7 +1486,7 @@
 		adjust_link(dev);
 
 	/* Reenable interrupts, if needed */
-	if (priv->einfo->flags & GFAR_HAS_PHY_INTR)
+	if (priv->einfo->board_flags & FSL_GIANFAR_BRD_HAS_PHY_INTR)
 		mii_configure_phy_interrupt(priv->mii_info,
 				MII_INTERRUPT_ENABLED);
 }
@@ -1547,7 +1543,7 @@
 	del_timer_sync(&priv->phy_info_timer);
 
 	/* Grab the PHY interrupt, if necessary/possible */
-	if (priv->einfo->flags & GFAR_HAS_PHY_INTR) {
+	if (priv->einfo->board_flags & FSL_GIANFAR_BRD_HAS_PHY_INTR) {
 		if (request_irq(priv->einfo->interruptPHY, 
 					phy_interrupt,
 					SA_SHIRQ, 
@@ -1758,7 +1754,7 @@
 	/* Hmm... */
 #if defined (BRIEF_GFAR_ERRORS) || defined (VERBOSE_GFAR_ERRORS)
 	printk(KERN_DEBUG "%s: error interrupt (ievent=0x%08x imask=0x%08x)\n",
-	       dev->name, events, gfar_read(priv->regs->imask));
+	       dev->name, events, gfar_read(&priv->regs->imask));
 #endif
 
 	/* Update the error counters */
@@ -1829,36 +1825,23 @@
 }
 
 /* Structure for a device driver */
-static struct ocp_device_id gfar_ids[] = {
-	{.vendor = OCP_ANY_ID,.function = OCP_FUNC_GFAR},
-	{.vendor = OCP_VENDOR_INVALID}
-};
-
-static struct ocp_driver gfar_driver = {
-	.name = "gianfar",
-	.id_table = gfar_ids,
-
+static struct device_driver gfar_driver = {
+	.name = "fsl-gianfar",
+	.bus = &platform_bus_type,
 	.probe = gfar_probe,
 	.remove = gfar_remove,
 };
 
 static int __init gfar_init(void)
 {
-	int rc;
-
-	rc = ocp_register_driver(&gfar_driver);
-	if (rc != 0) {
-		ocp_unregister_driver(&gfar_driver);
-		return -ENODEV;
-	}
-
-	return 0;
+	return driver_register(&gfar_driver);
 }
 
 static void __exit gfar_exit(void)
 {
-	ocp_unregister_driver(&gfar_driver);
+	driver_unregister(&gfar_driver);
 }
 
 module_init(gfar_init);
 module_exit(gfar_exit);
+
diff -Nru a/drivers/net/gianfar.h b/drivers/net/gianfar.h
--- a/drivers/net/gianfar.h	2005-01-17 22:31:44 -06:00
+++ b/drivers/net/gianfar.h	2005-01-17 22:31:44 -06:00
@@ -37,6 +37,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -47,7 +48,6 @@
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
-#include <asm/ocp.h>
 #include "gianfar_phy.h"
 
 /* The maximum number of packets to be handled in one call of gfar_poll */
@@ -510,7 +510,10 @@
 	unsigned int rxclean;
 
 	/* Info structure initialized by board setup code */
-	struct ocp_gfar_data *einfo;
+	unsigned int interruptTransmit;
+	unsigned int interruptReceive;
+	unsigned int interruptError;
+	struct gianfar_platform_data *einfo;
 
 	struct gfar_mii_info *mii_info;
 	int oldspeed;
diff -Nru a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
--- a/drivers/net/gianfar_ethtool.c	2005-01-17 22:31:44 -06:00
+++ b/drivers/net/gianfar_ethtool.c	2005-01-17 22:31:44 -06:00
@@ -186,9 +186,11 @@
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	uint gigabit_support = 
-		priv->einfo->flags & GFAR_HAS_GIGABIT ? SUPPORTED_1000baseT_Full : 0;
+		priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT ?
+			SUPPORTED_1000baseT_Full : 0;
 	uint gigabit_advert = 
-		priv->einfo->flags & GFAR_HAS_GIGABIT ? ADVERTISED_1000baseT_Full: 0;
+		priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT ?
+			ADVERTISED_1000baseT_Full: 0;
 
 	cmd->supported = (SUPPORTED_10baseT_Half
 			  | SUPPORTED_100baseT_Half
