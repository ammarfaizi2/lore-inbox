Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSKJVwy>; Sun, 10 Nov 2002 16:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSKJVwy>; Sun, 10 Nov 2002 16:52:54 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:7609 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S265197AbSKJVwm>; Sun, 10 Nov 2002 16:52:42 -0500
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: Re: [PATCH] sysfs stuff for eisa bus [2/3]
References: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 10 Nov 2002 22:59:10 +0100
Message-ID: <wrp65v5gk7l.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Second patch is 3c509 driver ported to the sysfs EISA infrastructure :

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-3c509.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.803   -> 1.804  
#	 drivers/net/3c509.c	1.25    -> 1.26   
#	 drivers/net/Space.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/10	maz@hina.wild-wind.fr.eu.org	1.804
# Ported to sysfs EISA framework.
# Added new style init/cleanup.
# --------------------------------------------
#
diff -Nru a/drivers/net/3c509.c b/drivers/net/3c509.c
--- a/drivers/net/3c509.c	Sun Nov 10 22:49:20 2002
+++ b/drivers/net/3c509.c	Sun Nov 10 22:49:20 2002
@@ -53,11 +53,13 @@
 			- Additional ethtool features
 		v1.19a 28Oct2002 Davud Ruggiero <jdr@farfalle.com>
 			- Increase *read_eeprom udelay to workaround oops with 2 cards.
+		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
+		    - Introduce driver model for EISA cards.
 */
 
 #define DRV_NAME	"3c509"
-#define DRV_VERSION	"1.19a"
-#define DRV_RELDATE	"28Oct2002"
+#define DRV_VERSION	"1.19b"
+#define DRV_RELDATE	"08Nov2002"
 
 /* A few values that may be tweaked. */
 
@@ -85,6 +87,8 @@
 #include <linux/delay.h>	/* for udelay() */
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -169,6 +173,9 @@
 #ifdef CONFIG_PM
 	struct pm_dev *pmdev;
 #endif
+#ifdef CONFIG_EISA
+	struct eisa_device *edev;
+#endif
 };
 static int id_port __initdata = 0x110;	/* Start with 0x110 to avoid new sound cards.*/
 static struct net_device *el3_root_dev;
@@ -193,6 +200,26 @@
 static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
 #endif
 
+#ifdef CONFIG_EISA
+struct eisa_device_id el3_eisa_ids[] = {
+		{ "TCM5092" },
+		{ "TCM5093" },
+		{ "" }
+};
+
+static int el3_eisa_probe (struct device *device);
+static int el3_eisa_remove (struct device *device);
+
+struct eisa_driver el3_eisa_driver = {
+		.id_table = el3_eisa_ids,
+		.driver   = {
+				.name    = "3c509",
+				.probe   = el3_eisa_probe,
+				.remove  = __devexit_p (el3_eisa_remove)
+		}
+};
+#endif
+
 #ifdef CONFIG_MCA
 struct el3_mca_adapters_struct {
 	char* name;
@@ -239,55 +266,102 @@
 #endif /* __ISAPNP__ */
 static int nopnp;
 
-int __init el3_probe(struct net_device *dev, int card_idx)
+/* With the driver model introduction for EISA devices, both init
+ * and cleanup have been split :
+ * - EISA devices probe/remove starts in el3_eisa_probe/el3_eisa_remove
+ * - MCA/ISA still use el3_probe
+ *
+ * Both call el3_common_init/el3_common_remove. */
+
+static int __init el3_common_init (struct net_device *dev)
 {
-	struct el3_private *lp;
-	short lrs_state = 0xff, i;
-	int ioaddr, irq, if_port;
-	u16 phys_addr[3];
-	static int current_tag;
-	int mca_slot = -1;
-#ifdef __ISAPNP__
-	static int pnp_cards;
-#endif /* __ISAPNP__ */
+    struct el3_private *lp = dev->priv;
+	short i;
+  
+#ifdef CONFIG_EISA
+	if (!lp->edev)				/* EISA devices are not chained */
+#endif
+	{
+			lp->next_dev = el3_root_dev;
+			el3_root_dev = dev;
+	}
+	spin_lock_init(&lp->lock);
 
-	if (dev) SET_MODULE_OWNER(dev);
+	if (dev->mem_start & 0x05) { /* xcvr codes 1/3/4/12 */
+		dev->if_port = (dev->mem_start & 0x0f);
+	} else { /* xcvr codes 0/8 */
+		/* use eeprom value, but save user's full-duplex selection */
+		dev->if_port |= (dev->mem_start & 0x08);
+	}
 
-	/* First check all slots of the EISA bus.  The next slot address to
-	   probe is kept in 'eisa_addr' to support multiple probe() calls. */
-	if (EISA_bus) {
-		static int eisa_addr = 0x1000;
-		while (eisa_addr < 0x9000) {
-			int device_id;
+	{
+		const char *if_names[] = {"10baseT", "AUI", "undefined", "BNC"};
+		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
+			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
+	}
 
-			ioaddr = eisa_addr;
-			eisa_addr += 0x1000;
+	/* Read in the station address. */
+	for (i = 0; i < 6; i++)
+		printk(" %2.2x", dev->dev_addr[i]);
+	printk(", IRQ %d.\n", dev->irq);
 
-			/* Check the standard EISA ID register for an encoded '3Com'. */
-			if (inw(ioaddr + 0xC80) != 0x6d50)
-				continue;
+	if (el3_debug > 0)
+		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
 
-			/* Avoid conflict with 3c590, 3c592, 3c597, etc */
-			device_id = (inb(ioaddr + 0xC82)<<8) + inb(ioaddr + 0xC83);
-			if ((device_id & 0xFF00) == 0x5900) {
-				continue;
-			}
+	/* The EL3-specific entries in the device structure. */
+	dev->open = &el3_open;
+	dev->hard_start_xmit = &el3_start_xmit;
+	dev->stop = &el3_close;
+	dev->get_stats = &el3_get_stats;
+	dev->set_multicast_list = &set_multicast_list;
+	dev->tx_timeout = el3_tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+	dev->do_ioctl = netdev_ioctl;
 
-			/* Change the register set to the configuration window 0. */
-			outw(SelectWindow | 0, ioaddr + 0xC80 + EL3_CMD);
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
 
-			irq = inw(ioaddr + WN0_IRQ) >> 12;
-			if_port = inw(ioaddr + 6)>>14;
-			for (i = 0; i < 3; i++)
-				phys_addr[i] = htons(read_eeprom(ioaddr, i));
+	return 0;
+}
 
-			/* Restore the "Product ID" to the EEPROM read register. */
-			read_eeprom(ioaddr, 3);
+static void el3_common_remove (struct net_device *dev)
+{
+		struct el3_private *lp = dev->priv;
 
-			/* Was the EISA code an add-on hack?  Nahhhhh... */
-			goto found;
-		}
-	}
+		(void) lp;				/* Keep gcc quiet... */
+#ifdef CONFIG_MCA		
+		if(lp->mca_slot!=-1)
+			mca_mark_as_unused(lp->mca_slot);
+#endif
+#ifdef CONFIG_PM
+		if (lp->pmdev)
+			pm_unregister(lp->pmdev);
+#endif
+
+		unregister_netdev (dev);
+		release_region(dev->base_addr, EL3_IO_EXTENT);
+		kfree (dev);
+}
+
+static int __init el3_probe(int card_idx)
+{
+    struct net_device *dev;
+	struct el3_private *lp;
+	short lrs_state = 0xff, i;
+	int ioaddr, irq, if_port;
+	u16 phys_addr[3];
+	static int current_tag;
+	int mca_slot = -1;
+#ifdef __ISAPNP__
+	static int pnp_cards;
+#endif /* __ISAPNP__ */
 
 #ifdef CONFIG_MCA
 	/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch, heavily
@@ -464,6 +538,8 @@
 	}
 	irq = id_read_eeprom(9) >> 12;
 
+#if 0							/* Huh ?
+								   Can someone explain what is this for ? */
 	if (dev) {					/* Set passed-in IRQ or I/O Addr. */
 		if (dev->irq > 1  &&  dev->irq < 16)
 			irq = dev->irq;
@@ -476,6 +552,7 @@
 				return -ENODEV;
 		}
 	}
+#endif
 
 	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509"))
 		return -EBUSY;
@@ -495,76 +572,83 @@
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
  found:
+	dev = init_etherdev(NULL, sizeof(struct el3_private));
 	if (dev == NULL) {
-		dev = init_etherdev(dev, sizeof(struct el3_private));
-		if (dev == NULL) {
-			release_region(ioaddr, EL3_IO_EXTENT);
-			return -ENOMEM;
-		}
-		SET_MODULE_OWNER(dev);
+	    release_region(ioaddr, EL3_IO_EXTENT);
+		return -ENOMEM;
 	}
+	SET_MODULE_OWNER(dev);
+
 	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
+	dev->if_port = if_port;
+	lp = dev->priv;
+	lp->mca_slot = mca_slot;
 
-	if (dev->mem_start & 0x05) { /* xcvr codes 1/3/4/12 */
-		dev->if_port = (dev->mem_start & 0x0f);
-	} else { /* xcvr codes 0/8 */
-		/* use eeprom value, but save user's full-duplex selection */
-		dev->if_port = (if_port | (dev->mem_start & 0x08) );
-	}
+	return el3_common_init (dev);
+}
 
-	{
-		const char *if_names[] = {"10baseT", "AUI", "undefined", "BNC"};
-		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
-			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
+#ifdef CONFIG_EISA
+static int __init el3_eisa_probe (struct device *device)
+{
+	struct el3_private *lp;
+	short i;
+	int ioaddr, irq, if_port;
+	u16 phys_addr[3];
+	struct net_device *dev = NULL;
+	struct eisa_device *edev;
+
+	/* Yeepee, The driver framework is calling us ! */
+	edev = to_eisa_device (device);
+	ioaddr = edev->base_addr;
+	
+	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509"))
+		return -EBUSY;
+
+	/* Change the register set to the configuration window 0. */
+	outw(SelectWindow | 0, ioaddr + 0xC80 + EL3_CMD);
+
+	irq = inw(ioaddr + WN0_IRQ) >> 12;
+	if_port = inw(ioaddr + 6)>>14;
+	for (i = 0; i < 3; i++)
+			phys_addr[i] = htons(read_eeprom(ioaddr, i));
+
+	/* Restore the "Product ID" to the EEPROM read register. */
+	read_eeprom(ioaddr, 3);
+
+	dev = init_etherdev(NULL, sizeof(struct el3_private));
+	if (dev == NULL) {
+			release_region(ioaddr, EL3_IO_EXTENT);
+			return -ENOMEM;
 	}
 
-	/* Read in the station address. */
-	for (i = 0; i < 6; i++)
-		printk(" %2.2x", dev->dev_addr[i]);
-	printk(", IRQ %d.\n", dev->irq);
+	SET_MODULE_OWNER(dev);
 
-	/* Make up a EL3-specific-data structure. */
-	if (dev->priv == NULL)
-		dev->priv = kmalloc(sizeof(struct el3_private), GFP_KERNEL);
-	if (dev->priv == NULL)
-		return -ENOMEM;
-	memset(dev->priv, 0, sizeof(struct el3_private));
-	
+	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
+	dev->base_addr = ioaddr;
+	dev->irq = irq;
+	dev->if_port = if_port;
 	lp = dev->priv;
-	lp->mca_slot = mca_slot;
-	lp->next_dev = el3_root_dev;
-	spin_lock_init(&lp->lock);
-	el3_root_dev = dev;
+	lp->mca_slot = -1;
+	lp->edev = edev;
+	edev->driver_data = dev;
 
-	if (el3_debug > 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+	return el3_common_init (dev);
+}
 
-	/* The EL3-specific entries in the device structure. */
-	dev->open = &el3_open;
-	dev->hard_start_xmit = &el3_start_xmit;
-	dev->stop = &el3_close;
-	dev->get_stats = &el3_get_stats;
-	dev->set_multicast_list = &set_multicast_list;
-	dev->tx_timeout = el3_tx_timeout;
-	dev->watchdog_timeo = TX_TIMEOUT;
-	dev->do_ioctl = netdev_ioctl;
+static int __devexit el3_eisa_remove (struct device *device)
+{
+		struct eisa_device *edev;
+		struct net_device *dev;
 
-#ifdef CONFIG_PM
-	/* register power management */
-	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
-	if (lp->pmdev) {
-		struct pm_dev *p;
-		p = lp->pmdev;
-		p->data = (struct net_device *)dev;
-	}
-#endif
+		edev = to_eisa_device (device);
+		dev  = edev->driver_data;
 
-	/* Fill in the generic fields of the device structure. */
-	ether_setup(dev);
-	return 0;
+		el3_common_remove (dev);
+		return 0;
 }
+#endif
 
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
@@ -974,7 +1058,8 @@
 el3_close(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
-
+	struct el3_private *lp = (struct el3_private *)dev->priv;
+	
 	if (el3_debug > 2)
 		printk("%s: Shutting down ethercard.\n", dev->name);
 
@@ -983,8 +1068,12 @@
 	free_irq(dev->irq, dev);
 	/* Switching back to window 0 disables the IRQ. */
 	EL3WINDOW(0);
-	/* But we explicitly zero the IRQ line select anyway. */
-	outw(0x0f00, ioaddr + WN0_IRQ);
+	if (!lp->edev) {
+	    /* But we explicitly zero the IRQ line select anyway. Don't do
+	     * it on EISA cards, it prevents the module from getting an
+	     * IRQ after unload+reload... */
+	    outw(0x0f00, ioaddr + WN0_IRQ);
+	}
 
 	return 0;
 }
@@ -1406,7 +1495,6 @@
 
 #endif /* CONFIG_PM */
 
-#ifdef MODULE
 /* Parameters that may be passed into the module. */
 static int debug = -1;
 static int irq[] = {-1, -1, -1, -1, -1, -1, -1, -1};
@@ -1428,8 +1516,7 @@
 MODULE_DESCRIPTION("3Com Etherlink III (3c509, 3c509B) ISA/PnP ethernet driver");
 MODULE_LICENSE("GPL");
 
-int
-init_module(void)
+static int __init el3_init_module(void)
 {
 	int el3_cards = 0;
 
@@ -1437,7 +1524,7 @@
 		el3_debug = debug;
 
 	el3_root_dev = NULL;
-	while (el3_probe(0, el3_cards) == 0) {
+	while (el3_probe(el3_cards) == 0) {
 		if (irq[el3_cards] > 1)
 			el3_root_dev->irq = irq[el3_cards];
 		if (xcvr[el3_cards] >= 0)
@@ -1445,34 +1532,36 @@
 		el3_cards++;
 	}
 
+#ifdef CONFIG_EISA
+	if (eisa_driver_register (&el3_eisa_driver) < 0) {
+			eisa_driver_unregister (&el3_eisa_driver);
+	}
+	else
+			el3_cards++;				/* Found an eisa card */
+#endif
 	return el3_cards ? 0 : -ENODEV;
 }
 
-void
-cleanup_module(void)
+static void __exit el3_cleanup_module(void)
 {
 	struct net_device *next_dev;
 
 	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
 	while (el3_root_dev) {
 		struct el3_private *lp = (struct el3_private *)el3_root_dev->priv;
-#ifdef CONFIG_MCA		
-		if(lp->mca_slot!=-1)
-			mca_mark_as_unused(lp->mca_slot);
-#endif
 
-#ifdef CONFIG_PM
-		if (lp->pmdev)
-			pm_unregister(lp->pmdev);
-#endif
 		next_dev = lp->next_dev;
-		unregister_netdev(el3_root_dev);
-		release_region(el3_root_dev->base_addr, EL3_IO_EXTENT);
-		kfree(el3_root_dev);
+		el3_common_remove (el3_root_dev);
 		el3_root_dev = next_dev;
 	}
+
+#ifdef CONFIG_EISA
+	eisa_driver_unregister (&el3_eisa_driver);
+#endif
 }
-#endif /* MODULE */
+
+module_init (el3_init_module);
+module_exit (el3_cleanup_module);
 
 /*
  * Local variables:
diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Sun Nov 10 22:49:20 2002
+++ b/drivers/net/Space.c	Sun Nov 10 22:49:20 2002
@@ -56,7 +56,6 @@
 extern int hp_plus_probe(struct net_device *dev);
 extern int express_probe(struct net_device *);
 extern int eepro_probe(struct net_device *);
-extern int el3_probe(struct net_device *);
 extern int at1500_probe(struct net_device *);
 extern int at1700_probe(struct net_device *);
 extern int fmv18x_probe(struct net_device *);
@@ -215,9 +214,6 @@
  * look for EISA/PCI/MCA cards in addition to ISA cards).
  */
 static struct devprobe isa_probes[] __initdata = {
-#ifdef CONFIG_EL3		/* ISA, EISA, MCA 3c5x9 */
-	{el3_probe, 0},
-#endif
 #ifdef CONFIG_HP100 		/* ISA, EISA & PCI */
 	{hp100_probe, 0},
 #endif	

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
