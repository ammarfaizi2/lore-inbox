Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKPJES>; Thu, 16 Nov 2000 04:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKPJD5>; Thu, 16 Nov 2000 04:03:57 -0500
Received: from [209.249.10.20] ([209.249.10.20]:63439 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129688AbQKPJD4>; Thu, 16 Nov 2000 04:03:56 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Nov 2000 00:33:09 -0800
Message-Id: <200011160833.AAA06880@adam.yggdrasil.com>
To: willy@meta-x.org
Subject: sunhme.c patch for new PCI interface (UNTESTED)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, wtarreau@yahoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I don't have access to a Sun HME card, but, for some neurotic
reason, I decided to try porting sunhme.c to the new PCI interface.
I believe it has simplified the code slightly.  More importantly, it
causes the module to export a table with the PCI ID's that it cares
about, which is used by depmod to generate /lib/modules/.../modules.pcimap,
which can be used to support automatic loading (I wrote a small
program for this purpose, "pcimodules", which I have submitted
hopefully for inclusion in pciutils, and I'd be glad to provide
that patch if anyone is interested).

	The patch also eliminates some places where a struct netdevice
that was *always* null was being passed around.  Also note that, under
this patch, root_happy_dev has become a list of only the sbus interfaces.

	Anyhow, I know that this compiles without any complaint other
than Dave Miller's built in warning message ("This needs to be corrected
... -DaveM").  I would appreciate it if you or anyone else interested
would test it and, if it works and is generally approved of, then
have Dave bless it and send it to Linus.

	It looks like sunhme was one of only seven drivers remaining
in the drivers/net (excluding subdirectories) that used the old PCI
probing interface.

	This patch is against 2.4.0-test11-pre5, and includes Dave's
changes to make it compile.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.4.0-test11-pre5/drivers/net/sunhme.c	Wed Nov 15 22:07:59 2000
+++ linux/drivers/net/sunhme.c	Thu Nov 16 00:07:15 2000
@@ -38,6 +38,7 @@
 #include <asm/dma.h>
 #include <linux/errno.h>
 #include <asm/byteorder.h>
+#include <asm/uaccess.h>
 
 #ifdef __sparc__
 #include <asm/idprom.h>
@@ -48,7 +49,6 @@
 #ifndef __sparc_v9__
 #include <asm/io-unit.h>
 #endif
-#include <asm/uaccess.h>
 #endif
 
 #include <asm/pgtable.h>
@@ -73,9 +73,8 @@
 /* accept MAC address of the form macaddr=0x08,0x00,0x20,0x30,0x40,0x50 */
 MODULE_PARM(macaddr, "6i");
 
-static struct happy_meal *root_happy_dev = NULL;
-
 #ifdef CONFIG_SBUS
+static struct happy_meal *root_happy_dev = NULL;
 static struct quattro *qfe_sbus_list = NULL;
 #endif
 
@@ -101,6 +100,7 @@
 	unsigned int status;
 };
 #define TX_LOG_LEN	128
+
 static struct hme_tx_logent tx_log[TX_LOG_LEN];
 static int txlog_cur_entry = 0;
 static __inline__ void tx_add_log(struct happy_meal *hp, unsigned int a, unsigned int s)
@@ -1600,6 +1600,10 @@
 	HMD(("happy_meal_init: old[%08x] bursts<",
 	     hme_read32(hp, gregs + GREG_CFG)));
 
+#ifndef __sparc__
+	/* It is always PCI and can handle 64byte bursts. */
+	hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST64);
+#else
 	if ((hp->happy_bursts & DMA_BURST64) &&
 	    ((hp->happy_flags & HFLAG_PCI) != 0
 #ifdef CONFIG_SBUS
@@ -1633,6 +1637,7 @@
 		HMD(("XXX>"));
 		hme_write32(hp, gregs + GREG_CFG, 0);
 	}
+#endif /* __sparc__ */
 
 	/* Turn off interrupts we do not want to hear. */
 	HMD((", enable global interrupts, "));
@@ -2553,10 +2558,9 @@
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_SBUS
-static int __init happy_meal_sbus_init(struct net_device *dev,
-				       struct sbus_dev *sdev,
-				       int is_qfe)
+static int __init happy_meal_sbus_init(struct sbus_dev *sdev, int is_qfe)
 {
+	struct net_device *dev;
 	struct quattro *qp = NULL;
 	struct happy_meal *hp;
 	int i, qfe_slot = -1;
@@ -2571,13 +2575,7 @@
 		if (qfe_slot == 4)
 			return -ENODEV;
 	}
-	if (dev == NULL) {
-		dev = init_etherdev(0, sizeof(struct happy_meal));
-	} else {
-		dev->priv = kmalloc(sizeof(struct happy_meal), GFP_KERNEL);
-		if (dev->priv == NULL)
-			return -ENOMEM;
-	}
+	dev = init_etherdev(0, sizeof(struct happy_meal));
 	if (hme_version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
 
@@ -2741,7 +2739,8 @@
 #endif
 
 #ifdef CONFIG_PCI
-static int __init happy_meal_pci_init(struct net_device *dev, struct pci_dev *pdev)
+static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
+					  const struct pci_device_id *id)
 {
 	struct quattro *qp = NULL;
 #ifdef __sparc__
@@ -2752,6 +2751,10 @@
 	unsigned long hpreg_base;
 	int i, qfe_slot = -1;
 	char prom_name[64];
+	struct net_device *dev;
+
+	if (pci_enable_device(pdev))
+		return -EIO;
 
 	/* Now make sure pci_dev cookie is there. */
 #ifdef __sparc__
@@ -2778,13 +2781,7 @@
 		if (qfe_slot == 4)
 			return -ENODEV;
 	}
-	if (dev == NULL) {
-		dev = init_etherdev(0, sizeof(struct happy_meal));
-	} else {
-		dev->priv = kmalloc(sizeof(struct happy_meal), GFP_KERNEL);
-		if (dev->priv == NULL)
-			return -ENOMEM;
-	}
+	dev = init_etherdev(0, sizeof(struct happy_meal));
 	if (hme_version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
 
@@ -2887,8 +2884,10 @@
 	/* And of course, indicate this is PCI. */
 	hp->happy_flags |= HFLAG_PCI;
 
+#ifdef __sparc__
 	/* Assume PCI happy meals can handle all burst sizes. */
 	hp->happy_bursts = DMA_BURSTBITS;
+#endif
 
 	hp->happy_block = (struct hmeal_init_block *)
 		pci_alloc_consistent(pdev, PAGE_SIZE, &hp->hblock_dvma);
@@ -2926,6 +2925,8 @@
 	hp->write32 = pci_hme_write32;
 #endif
 
+	pdev->driver_data = hp;
+
 	/* Grrr, Happy Meal comes up by default not advertising
 	 * full duplex 100baseT capabilities, fix this.
 	 */
@@ -2937,15 +2938,26 @@
 	 * device list.
 	 */
 	dev->ifindex = dev_new_index();
-	hp->next_module = root_happy_dev;
-	root_happy_dev = hp;
 
 	return 0;
 }
+
+static void __devexit happy_meal_pci_remove (struct pci_dev *pdev)
+{
+	struct happy_meal *hp = pdev->driver_data;
+
+	pci_free_consistent(hp->happy_dev,
+			    PAGE_SIZE,
+			    hp->happy_block,
+			    hp->hblock_dvma);
+	unregister_netdev(hp->dev);
+	kfree(hp->dev);
+}
+
 #endif
 
 #ifdef CONFIG_SBUS
-static int __init happy_meal_sbus_probe(struct net_device *dev)
+static int __init happy_meal_sbus_probe(void)
 {
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
@@ -2959,11 +2971,11 @@
 				dev = NULL;
 			if (!strcmp(name, "SUNW,hme")) {
 				cards++;
-				happy_meal_sbus_init(dev, sdev, 0);
+				happy_meal_sbus_init(sdev, 0);
 			} else if (!strcmp(name, "qfe") ||
 				   !strcmp(name, "SUNW,qfe")) {
 				cards++;
-				happy_meal_sbus_init(dev, sdev, 1);
+				happy_meal_sbus_init(sdev, 1);
 			}
 		}
 	}
@@ -2974,58 +2986,56 @@
 #endif
 
 #ifdef CONFIG_PCI
-static int __init happy_meal_pci_probe(struct net_device *dev)
-{
-	struct pci_dev *pdev = NULL;
-	int cards = 0;
 
-	while ((pdev = pci_find_device(PCI_VENDOR_ID_SUN,
-				       PCI_DEVICE_ID_SUN_HAPPYMEAL, pdev)) != NULL) {
-		if (pci_enable_device(pdev))
-			continue;
-		if (cards)
-			dev = NULL;
-		cards++;
-		happy_meal_pci_init(dev, pdev);
-	}
-	return cards;
-}
+static struct pci_device_id happymeal_pci_ids[] __devinitdata = {
+	{
+	  vendor: PCI_VENDOR_ID_SUN,
+	  device: PCI_DEVICE_ID_SUN_HAPPYMEAL,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(pci, happymeal_pci_ids);
+
+static struct pci_driver happy_meal_pci_driver = {
+	name:		"sunhme",
+	id_table:	happymeal_pci_ids,
+	probe:		happy_meal_pci_probe,
+	remove:		happy_meal_pci_remove,
+};
 #endif
 
 static int __init happy_meal_probe(void)
 {
-	struct net_device *dev = NULL;
 	static int called = 0;
 	int cards;
 
-	root_happy_dev = NULL;
-
 	if (called)
 		return -ENODEV;
 	called++;
 
 	cards = 0;
 #ifdef CONFIG_SBUS
-	cards += happy_meal_sbus_probe(dev);
-	if (cards != 0)
-		dev = NULL;
+	root_happy_dev = NULL;
+	cards += happy_meal_sbus_probe();
 #endif
 #ifdef CONFIG_PCI
-	cards += happy_meal_pci_probe(dev);
+	return pci_module_init(&happy_meal_pci_driver);
+#else
+	return (cards > 0) ? 0 : -ENODEV;
 #endif
-	if (!cards)
-		return -ENODEV;
-	return 0;
 }
 
 
 static void __exit happy_meal_cleanup_module(void)
 {
+#ifdef CONFIG_SBUS
 	while (root_happy_dev) {
 		struct happy_meal *hp = root_happy_dev;
 		struct happy_meal *next = root_happy_dev->next_module;
 
-#ifdef CONFIG_SBUS
 		if (!(hp->happy_flags & HFLAG_PCI)) {
 			sbus_iounmap(hp->gregs, GREG_REG_SIZE);
 			sbus_iounmap(hp->etxregs, ETX_REG_SIZE);
@@ -3037,19 +3047,14 @@
 					     hp->happy_block,
 					     hp->hblock_dvma);
 		}
-#endif
-#ifdef CONFIG_PCI
-		if ((hp->happy_flags & HFLAG_PCI)) {
-			pci_free_consistent(hp->happy_dev,
-					    PAGE_SIZE,
-					    hp->happy_block,
-					    hp->hblock_dvma);
-		}
-#endif
 		unregister_netdev(hp->dev);
 		kfree(hp->dev);
 		root_happy_dev = next;
 	}
+#endif
+#ifdef CONFIG_PCI
+	pci_unregister_driver (&happy_meal_pci_driver);
+#endif
 }
 
 module_init(happy_meal_probe);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
