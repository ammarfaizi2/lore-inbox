Return-Path: <linux-kernel-owner+w=401wt.eu-S964974AbWLTMEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWLTMEi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbWLTMEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:04:38 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1620 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971AbWLTMCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:02:14 -0500
Date: Wed, 20 Dec 2006 12:02:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.20-rc1 07/10] declance: Driver model for the PMAD-A
Message-ID: <Pine.LNX.4.64N.0612201117120.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes that converts the PMAD-A support to the driver 
model.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-pmad-a-10
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/declance.c linux-mips-2.6.18-20060920/drivers/net/declance.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/declance.c	2006-12-16 17:25:24.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/declance.c	2006-12-17 02:28:15.000000000 +0000
@@ -5,7 +5,7 @@
  *
  *      adopted from sunlance.c by Richard van den Berg
  *
- *      Copyright (C) 2002, 2003, 2005  Maciej W. Rozycki
+ *      Copyright (C) 2002, 2003, 2005, 2006  Maciej W. Rozycki
  *
  *      additional sources:
  *      - PMAD-AA TURBOchannel Ethernet Module Functional Specification,
@@ -44,6 +44,8 @@
  *      v0.010: Fixes for the PMAD mapping of the LANCE buffer and for the
  *              PMAX requirement to only use halfword accesses to the
  *              buffer. macro
+ *
+ *      v0.011: Converted the PMAD to the driver model. macro
  */
 
 #include <linux/crc32.h>
@@ -58,6 +60,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/tc.h>
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
@@ -69,15 +72,16 @@
 #include <asm/dec/kn01.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/system.h>
-#include <asm/dec/tc.h>
 
 static char version[] __devinitdata =
-"declance.c: v0.010 by Linux MIPS DECstation task force\n";
+"declance.c: v0.011 by Linux MIPS DECstation task force\n";
 
 MODULE_AUTHOR("Linux MIPS DECstation task force");
 MODULE_DESCRIPTION("DEC LANCE (DECstation onboard, PMAD-xx) driver");
 MODULE_LICENSE("GPL");
 
+#define __unused __attribute__ ((unused))
+
 /*
  * card types
  */
@@ -246,7 +250,6 @@ struct lance_init_block {
 struct lance_private {
 	struct net_device *next;
 	int type;
-	int slot;
 	int dma_irq;
 	volatile struct lance_regs *ll;
 
@@ -288,6 +291,7 @@ struct lance_regs {
 
 int dec_lance_debug = 2;
 
+static struct tc_driver dec_lance_tc_driver;
 static struct net_device *root_lance_dev;
 
 static inline void writereg(volatile unsigned short *regptr, short value)
@@ -1025,7 +1029,7 @@ static void lance_set_multicast_retry(un
 	lance_set_multicast(dev);
 }
 
-static int __init dec_lance_init(const int type, const int slot)
+static int __init dec_lance_probe(struct device *bdev, const int type)
 {
 	static unsigned version_printed;
 	static const char fmt[] = "declance%d";
@@ -1033,6 +1037,7 @@ static int __init dec_lance_init(const i
 	struct net_device *dev;
 	struct lance_private *lp;
 	volatile struct lance_regs *ll;
+	resource_size_t start = 0, len = 0;
 	int i, ret;
 	unsigned long esar_base;
 	unsigned char *esar;
@@ -1040,14 +1045,18 @@ static int __init dec_lance_init(const i
 	if (dec_lance_debug && version_printed++ == 0)
 		printk(version);
 
-	i = 0;
-	dev = root_lance_dev;
-	while (dev) {
-		i++;
-		lp = (struct lance_private *)dev->priv;
-		dev = lp->next;
+	if (bdev)
+		snprintf(name, sizeof(name), "%s", bdev->bus_id);
+	else {
+		i = 0;
+		dev = root_lance_dev;
+		while (dev) {
+			i++;
+			lp = (struct lance_private *)dev->priv;
+			dev = lp->next;
+		}
+		snprintf(name, sizeof(name), fmt, i);
 	}
-	snprintf(name, sizeof(name), fmt, i);
 
 	dev = alloc_etherdev(sizeof(struct lance_private));
 	if (!dev) {
@@ -1065,7 +1074,6 @@ static int __init dec_lance_init(const i
 	spin_lock_init(&lp->lock);
 
 	lp->type = type;
-	lp->slot = slot;
 	switch (type) {
 	case ASIC_LANCE:
 		dev->base_addr = CKSEG1ADDR(dec_kn_slot_base + IOASIC_LANCE);
@@ -1112,12 +1120,22 @@ static int __init dec_lance_init(const i
 		break;
 #ifdef CONFIG_TC
 	case PMAD_LANCE:
-		claim_tc_card(slot);
+		dev_set_drvdata(bdev, dev);
 
-		dev->mem_start = CKSEG1ADDR(get_tc_base_addr(slot));
+		start = to_tc_dev(bdev)->resource.start;
+		len = to_tc_dev(bdev)->resource.end - start + 1;
+		if (!request_mem_region(start, len, bdev->bus_id)) {
+			printk(KERN_ERR
+			       "%s: Unable to reserve MMIO resource\n",
+			       bdev->bus_id);
+			ret = -EBUSY;
+			goto err_out_dev;
+		}
+
+		dev->mem_start = CKSEG1ADDR(start);
 		dev->mem_end = dev->mem_start + 0x100000;
 		dev->base_addr = dev->mem_start + 0x100000;
-		dev->irq = get_tc_irq_nr(slot);
+		dev->irq = to_tc_dev(bdev)->interrupt;
 		esar_base = dev->mem_start + 0x1c0002;
 		lp->dma_irq = -1;
 
@@ -1176,7 +1194,7 @@ static int __init dec_lance_init(const i
 		printk(KERN_ERR "%s: declance_init called with unknown type\n",
 			name);
 		ret = -ENODEV;
-		goto err_out_free_dev;
+		goto err_out_dev;
 	}
 
 	ll = (struct lance_regs *) dev->base_addr;
@@ -1190,7 +1208,7 @@ static int __init dec_lance_init(const i
 			"%s: Ethernet station address prom not found!\n",
 			name);
 		ret = -ENODEV;
-		goto err_out_free_dev;
+		goto err_out_resource;
 	}
 	/* Check the prom contents */
 	for (i = 0; i < 8; i++) {
@@ -1200,7 +1218,7 @@ static int __init dec_lance_init(const i
 			printk(KERN_ERR "%s: Something is wrong with the "
 				"ethernet station address prom!\n", name);
 			ret = -ENODEV;
-			goto err_out_free_dev;
+			goto err_out_resource;
 		}
 	}
 
@@ -1257,48 +1275,51 @@ static int __init dec_lance_init(const i
 	if (ret) {
 		printk(KERN_ERR
 			"%s: Unable to register netdev, aborting.\n", name);
-		goto err_out_free_dev;
+		goto err_out_resource;
 	}
 
-	lp->next = root_lance_dev;
-	root_lance_dev = dev;
+	if (!bdev) {
+		lp->next = root_lance_dev;
+		root_lance_dev = dev;
+	}
 
 	printk("%s: registered as %s.\n", name, dev->name);
 	return 0;
 
-err_out_free_dev:
+err_out_resource:
+	if (bdev)
+		release_mem_region(start, len);
+
+err_out_dev:
 	free_netdev(dev);
 
 err_out:
 	return ret;
 }
 
+static void __exit dec_lance_remove(struct device *bdev)
+{
+	struct net_device *dev = dev_get_drvdata(bdev);
+	resource_size_t start, len;
+
+	unregister_netdev(dev);
+	start = to_tc_dev(bdev)->resource.start;
+	len = to_tc_dev(bdev)->resource.end - start + 1;
+	release_mem_region(start, len);
+	free_netdev(dev);
+}
 
 /* Find all the lance cards on the system and initialize them */
-static int __init dec_lance_probe(void)
+static int __init dec_lance_platform_probe(void)
 {
 	int count = 0;
 
-	/* Scan slots for PMAD-AA cards first. */
-#ifdef CONFIG_TC
-	if (TURBOCHANNEL) {
-		int slot;
-
-		while ((slot = search_tc_card("PMAD-AA")) >= 0) {
-			if (dec_lance_init(PMAD_LANCE, slot) < 0)
-				break;
-			count++;
-		}
-	}
-#endif
-
-	/* Then handle onboard devices. */
 	if (dec_interrupt[DEC_IRQ_LANCE] >= 0) {
 		if (dec_interrupt[DEC_IRQ_LANCE_MERR] >= 0) {
-			if (dec_lance_init(ASIC_LANCE, -1) >= 0)
+			if (dec_lance_probe(NULL, ASIC_LANCE) >= 0)
 				count++;
 		} else if (!TURBOCHANNEL) {
-			if (dec_lance_init(PMAX_LANCE, -1) >= 0)
+			if (dec_lance_probe(NULL, PMAX_LANCE) >= 0)
 				count++;
 		}
 	}
@@ -1306,21 +1327,70 @@ static int __init dec_lance_probe(void)
 	return (count > 0) ? 0 : -ENODEV;
 }
 
-static void __exit dec_lance_cleanup(void)
+static void __exit dec_lance_platform_remove(void)
 {
 	while (root_lance_dev) {
 		struct net_device *dev = root_lance_dev;
 		struct lance_private *lp = netdev_priv(dev);
 
 		unregister_netdev(dev);
-#ifdef CONFIG_TC
-		if (lp->slot >= 0)
-			release_tc_card(lp->slot);
-#endif
 		root_lance_dev = lp->next;
 		free_netdev(dev);
 	}
 }
 
-module_init(dec_lance_probe);
-module_exit(dec_lance_cleanup);
+#ifdef CONFIG_TC
+static int __init dec_lance_tc_probe(struct device *dev);
+static int __exit dec_lance_tc_remove(struct device *dev);
+
+static const struct tc_device_id dec_lance_tc_table[] = {
+	{ "DEC     ", "PMAD-AA " },
+	{ }
+};
+MODULE_DEVICE_TABLE(tc, dec_lance_tc_table);
+
+static struct tc_driver dec_lance_tc_driver = {
+	.id_table	= dec_lance_tc_table,
+	.driver		= {
+		.name	= "declance",
+		.bus	= &tc_bus_type,
+		.probe	= dec_lance_tc_probe,
+		.remove	= __exit_p(dec_lance_tc_remove),
+	},
+};
+
+static int __init dec_lance_tc_probe(struct device *dev)
+{
+        int status = dec_lance_probe(dev, PMAD_LANCE);
+        if (!status)
+                get_device(dev);
+        return status;
+}
+
+static int __exit dec_lance_tc_remove(struct device *dev)
+{
+        put_device(dev);
+        dec_lance_remove(dev);
+        return 0;
+}
+#endif
+
+static int __init dec_lance_init(void)
+{
+	int status;
+
+	status = tc_register_driver(&dec_lance_tc_driver);
+	if (!status)
+		dec_lance_platform_probe();
+	return status;
+}
+
+static void __exit dec_lance_exit(void)
+{
+	dec_lance_platform_remove();
+	tc_unregister_driver(&dec_lance_tc_driver);
+}
+
+
+module_init(dec_lance_init);
+module_exit(dec_lance_exit);
