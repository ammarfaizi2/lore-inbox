Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUBTMt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUBTMs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:48:59 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:2325 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261179AbUBTMrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:47:01 -0500
Date: Fri, 20 Feb 2004 13:46:46 +0100
Message-Id: <200402201246.i1KCkkWq004253@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 404] Amiga Ariadne Ethernet new driver model
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariadne Ethernet: Convert to the new driver model

--- linux-2.6.3/drivers/net/ariadne.c	2004-02-08 10:19:29.000000000 +0100
+++ linux-m68k-2.6.3/drivers/net/ariadne.c	2004-02-08 11:50:11.000000000 +0100
@@ -1,9 +1,8 @@
 /*
  *  Amiga Linux/m68k Ariadne Ethernet Driver
  *
- *  © Copyright 1995 by Geert Uytterhoeven (geert@linux-m68k.org)
- *			Peter De Schrijver
- *		       (Peter.DeSchrijver@linux.cc.kuleuven.ac.be)
+ *  © Copyright 1995-2003 by Geert Uytterhoeven (geert@linux-m68k.org)
+ *			     Peter De Schrijver (p2@mind.be)
  *
  *  ---------------------------------------------------------------------------
  *
@@ -101,8 +100,6 @@
     int dirty_tx;			/* The ring entries to be free()ed. */
     struct net_device_stats stats;
     char tx_full;
-    struct net_device *dev;		/* Backpointer */
-    struct ariadne_private *next_module;
 };
 
 
@@ -117,10 +114,6 @@
     u_short rx_buff[RX_RING_SIZE][PKT_BUF_SIZE/sizeof(u_short)];
 };
 
-#ifdef MODULE
-static struct ariadne_private *root_ariadne_dev;
-#endif
-
 static int ariadne_open(struct net_device *dev);
 static void ariadne_init_ring(struct net_device *dev);
 static int ariadne_start_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -146,78 +139,89 @@
 }
 
 
-static int __init ariadne_probe(void)
-{
-    struct zorro_dev *z = NULL;
-    struct net_device *dev;
-    struct ariadne_private *priv;
-    int res = -ENODEV;
+static int __devinit ariadne_init_one(struct zorro_dev *z,
+				      const struct zorro_device_id *ent);
+static void __devexit ariadne_remove_one(struct zorro_dev *z);
 
-    while ((z = zorro_find_device(ZORRO_PROD_VILLAGE_TRONIC_ARIADNE, z))) {
-	unsigned long board = z->resource.start;
-	unsigned long base_addr = board+ARIADNE_LANCE;
-	unsigned long mem_start = board+ARIADNE_RAM;
-	struct resource *r1, *r2;
-
-	r1 = request_mem_region(base_addr, sizeof(struct Am79C960),
-		    		"Am79C960");
-	if (!r1) continue;
-	r2 = request_mem_region(mem_start, ARIADNE_RAM_SIZE, "RAM");
-	if (!r2) {
-	    release_resource(r1);
-	    continue;
-	}
 
-	dev = alloc_etherdev(sizeof(struct ariadne_private));
+static struct zorro_device_id ariadne_zorro_tbl[] __devinitdata = {
+    { ZORRO_PROD_VILLAGE_TRONIC_ARIADNE },
+    { 0 }
+};
 
-	if (dev == NULL) {
-	    release_resource(r1);
-	    release_resource(r2);
-	    return -ENOMEM;
-	}
-	SET_MODULE_OWNER(dev);
-	priv = dev->priv;
+static struct zorro_driver ariadne_driver = {
+    .name	= "ariadne",
+    .id_table	= ariadne_zorro_tbl,
+    .probe	= ariadne_init_one,
+    .remove	= __devexit_p(ariadne_remove_one),
+};
 
-	r1->name = dev->name;
-	r2->name = dev->name;
+static int __devinit ariadne_init_one(struct zorro_dev *z,
+				      const struct zorro_device_id *ent)
+{
+    unsigned long board = z->resource.start;
+    unsigned long base_addr = board+ARIADNE_LANCE;
+    unsigned long mem_start = board+ARIADNE_RAM;
+    struct resource *r1, *r2;
+    struct net_device *dev;
+    struct ariadne_private *priv;
+    int err;
 
-	priv->dev = dev;
-	dev->dev_addr[0] = 0x00;
-	dev->dev_addr[1] = 0x60;
-	dev->dev_addr[2] = 0x30;
-	dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
-	dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
-	dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
-	printk("%s: Ariadne at 0x%08lx, Ethernet Address "
-	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
-	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
-	dev->base_addr = ZTWO_VADDR(base_addr);
-	dev->mem_start = ZTWO_VADDR(mem_start);
-	dev->mem_end = dev->mem_start+ARIADNE_RAM_SIZE;
-
-	dev->open = &ariadne_open;
-	dev->stop = &ariadne_close;
-	dev->hard_start_xmit = &ariadne_start_xmit;
-	dev->tx_timeout = &ariadne_tx_timeout;
-	dev->watchdog_timeo = 5*HZ;
-	dev->get_stats = &ariadne_get_stats;
-	dev->set_multicast_list = &set_multicast_list;
-
-	res = register_netdev(dev);
-	if (res) {
-	    release_resource(r1);
-	    release_resource(r2);
-	    free_netdev(dev);
-	    break;
-	}
-#ifdef MODULE
-	priv->next_module = root_ariadne_dev;
-	root_ariadne_dev = priv;
-#endif
+    r1 = request_mem_region(base_addr, sizeof(struct Am79C960), "Am79C960");
+    if (!r1)
+	return -EBUSY;
+    r2 = request_mem_region(mem_start, ARIADNE_RAM_SIZE, "RAM");
+    if (!r2) {
+	release_resource(r1);
+	return -EBUSY;
+    }
+
+    dev = alloc_etherdev(sizeof(struct ariadne_private));
+    if (dev == NULL) {
+	release_resource(r1);
+	release_resource(r2);
+	return -ENOMEM;
+    }
+
+    SET_MODULE_OWNER(dev);
+    priv = dev->priv;
+
+    r1->name = dev->name;
+    r2->name = dev->name;
+
+    dev->dev_addr[0] = 0x00;
+    dev->dev_addr[1] = 0x60;
+    dev->dev_addr[2] = 0x30;
+    dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
+    dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
+    dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
+    printk("%s: Ariadne at 0x%08lx, Ethernet Address "
+	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
+	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
+    dev->base_addr = ZTWO_VADDR(base_addr);
+    dev->mem_start = ZTWO_VADDR(mem_start);
+    dev->mem_end = dev->mem_start+ARIADNE_RAM_SIZE;
+
+    dev->open = &ariadne_open;
+    dev->stop = &ariadne_close;
+    dev->hard_start_xmit = &ariadne_start_xmit;
+    dev->tx_timeout = &ariadne_tx_timeout;
+    dev->watchdog_timeo = 5*HZ;
+    dev->get_stats = &ariadne_get_stats;
+    dev->set_multicast_list = &set_multicast_list;
+
+    err = register_netdev(dev);
+    if (err) {
+	release_resource(r1);
+	release_resource(r2);
+	free_netdev(dev);
+	return err;
     }
-    return res;
+    zorro_set_drvdata(z, dev);
+
+    return 0;
 }
 
 
@@ -846,25 +850,27 @@
 }
 
 
-static void __exit ariadne_cleanup(void)
+static void __devexit ariadne_remove_one(struct zorro_dev *z)
 {
-#ifdef MODULE
-    struct ariadne_private *next;
-    struct net_device *dev;
+    struct net_device *dev = zorro_get_drvdata(z);
 
-    while (root_ariadne_dev) {
-	next = root_ariadne_dev->next_module;
-	dev = root_ariadne_dev->dev;
-	unregister_netdev(dev);
-	release_mem_region(ZTWO_PADDR(dev->base_addr), sizeof(struct Am79C960));
-	release_mem_region(ZTWO_PADDR(dev->mem_start), ARIADNE_RAM_SIZE);
-	free_netdev(dev);
-	root_ariadne_dev = next;
-    }
-#endif
+    unregister_netdev(dev);
+    release_mem_region(ZTWO_PADDR(dev->base_addr), sizeof(struct Am79C960));
+    release_mem_region(ZTWO_PADDR(dev->mem_start), ARIADNE_RAM_SIZE);
+    free_netdev(dev);
+}
+
+static int __init ariadne_init_module(void)
+{
+    return zorro_module_init(&ariadne_driver);
+}
+
+static void __exit ariadne_cleanup_module(void)
+{
+    zorro_unregister_driver(&ariadne_driver);
 }
 
-module_init(ariadne_probe);
-module_exit(ariadne_cleanup);
+module_init(ariadne_init_module);
+module_exit(ariadne_cleanup_module);
 
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
