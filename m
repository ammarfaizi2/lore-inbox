Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUBTMte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUBTMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:49:20 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63817 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261189AbUBTMrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:47:02 -0500
Date: Fri, 20 Feb 2004 13:46:47 +0100
Message-Id: <200402201246.i1KCklDC004259@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 405] Amiga Hydra Ethernet new driver model
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hydra Ethernet: Convert to the new driver model

--- linux-2.6.3/drivers/net/hydra.c	2004-02-08 10:19:34.000000000 +0100
+++ linux-m68k-2.6.3/drivers/net/hydra.c	2004-02-08 11:47:55.000000000 +0100
@@ -44,10 +44,10 @@
 
 #define WORDSWAP(a)     ((((a)>>8)&0xff) | ((a)<<8))
 
-static struct net_device *root_hydra_dev;
 
-static int __init hydra_probe(void);
-static int __init hydra_init(unsigned long board);
+static int __devinit hydra_init_one(struct zorro_dev *z,
+				    const struct zorro_device_id *ent);
+static int __devinit hydra_init(struct zorro_dev *z);
 static int hydra_open(struct net_device *dev);
 static int hydra_close(struct net_device *dev);
 static void hydra_reset_8390(struct net_device *dev);
@@ -57,34 +57,38 @@
 			      struct sk_buff *skb, int ring_offset);
 static void hydra_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
-static void __exit hydra_cleanup(void);
+static void __devexit hydra_remove_one(struct zorro_dev *z);
 
-static int __init hydra_probe(void)
-{
-    struct zorro_dev *z = NULL;
-    unsigned long board;
-    int err = -ENODEV;
-
-    while ((z = zorro_find_device(ZORRO_PROD_HYDRA_SYSTEMS_AMIGANET, z))) {
-	board = z->resource.start;
-	if (!request_mem_region(board, 0x10000, "Hydra"))
-	    continue;
-	if ((err = hydra_init(ZTWO_VADDR(board)))) {
-	    release_mem_region(board, 0x10000);
-	    return err;
-	}
-	err = 0;
-    }
+static struct zorro_device_id hydra_zorro_tbl[] __devinitdata = {
+    { ZORRO_PROD_HYDRA_SYSTEMS_AMIGANET },
+    { 0 }
+};
+
+static struct zorro_driver hydra_driver = {
+    .name	= "hydra",
+    .id_table	= hydra_zorro_tbl,
+    .probe	= hydra_init_one,
+    .remove	= __devexit_p(hydra_remove_one),
+};
 
-    if (err == -ENODEV)
-	printk("No Hydra ethernet card found.\n");
+static int __devinit hydra_init_one(struct zorro_dev *z,
+				    const struct zorro_device_id *ent)
+{
+    int err;
 
-    return err;
+    if (!request_mem_region(z->resource.start, 0x10000, "Hydra"))
+	return -EBUSY;
+    if ((err = hydra_init(z))) {
+	release_mem_region(z->resource.start, 0x10000);
+	return -EBUSY;
+    }
+    return 0;
 }
 
-static int __init hydra_init(unsigned long board)
+static int __devinit hydra_init(struct zorro_dev *z)
 {
     struct net_device *dev;
+    unsigned long board = ZTWO_VADDR(z->resource.start);
     unsigned long ioaddr = board+HYDRA_NIC_BASE;
     const char name[] = "NE2000";
     int start_page, stop_page;
@@ -119,7 +123,7 @@
 	return -EAGAIN;
     }
 
-    printk("%s: hydra at 0x%08lx, address %02x:%02x:%02x:%02x:%02x:%02x (hydra.c " HYDRA_VERSION ")\n", dev->name, ZTWO_PADDR(board),
+    printk("%s: hydra at 0x%08lx, address %02x:%02x:%02x:%02x:%02x:%02x (hydra.c " HYDRA_VERSION ")\n", dev->name, z->resource.start,
 	dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 	dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 
@@ -138,18 +142,17 @@
     ei_status.reg_offset = hydra_offsets;
     dev->open = &hydra_open;
     dev->stop = &hydra_close;
-#ifdef MODULE
-    ei_status.priv = (unsigned long)root_hydra_dev;
-    root_hydra_dev = dev;
-#endif
     NS8390_init(dev, 0);
+
     err = register_netdev(dev);
-    if (!err)
-	return 0;
+    if (err) {
+	free_irq(IRQ_AMIGA_PORTS, dev);
+	free_netdev(dev);
+	return err;
+    }
 
-    free_irq(IRQ_AMIGA_PORTS, dev);
-    free_netdev(dev);
-    return err;
+    zorro_set_drvdata(z, dev);
+    return 0;
 }
 
 static int hydra_open(struct net_device *dev)
@@ -220,20 +223,27 @@
     z_memcpy_toio(mem_base+((start_page - NESM_START_PG)<<8), buf, count);
 }
 
-static void __exit hydra_cleanup(void)
+static void __devexit hydra_remove_one(struct zorro_dev *z)
 {
-    struct net_device *dev, *next;
+    struct net_device *dev = zorro_get_drvdata(z);
 
-    while ((dev = root_hydra_dev)) {
-	next = (struct net_device *)(ei_status.priv);
-	unregister_netdev(dev);
-	free_irq(IRQ_AMIGA_PORTS, dev);
-	release_mem_region(ZTWO_PADDR(dev->base_addr)-HYDRA_NIC_BASE, 0x10000);
-	free_netdev(dev);
-	root_hydra_dev = next;
-    }
+    unregister_netdev(dev);
+    free_irq(IRQ_AMIGA_PORTS, dev);
+    release_mem_region(ZTWO_PADDR(dev->base_addr)-HYDRA_NIC_BASE, 0x10000);
+    free_netdev(dev);
+}
+
+static int __init hydra_init_module(void)
+{
+    return zorro_module_init(&hydra_driver);
+}
+
+static void __exit hydra_cleanup_module(void)
+{
+    zorro_unregister_driver(&hydra_driver);
 }
 
-module_init(hydra_probe);
-module_exit(hydra_cleanup);
+module_init(hydra_init_module);
+module_exit(hydra_cleanup_module);
+
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
