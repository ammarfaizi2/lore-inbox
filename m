Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbUAAVGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbUAAVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:00:32 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:12852 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264899AbUAAUD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:28 -0500
Date: Thu, 1 Jan 2004 21:03:26 +0100
Message-Id: <200401012003.i01K3Qgq031876@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 373] Amiga Zorro8390 Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro8390 Ethernet: Convert to the new driver model

--- linux-2.6.0/drivers/net/zorro8390.c	2003-08-24 09:49:31.000000000 +0200
+++ linux-m68k-2.6.0/drivers/net/zorro8390.c	2003-10-26 22:09:06.000000000 +0100
@@ -59,9 +59,6 @@
 
 #define WORDSWAP(a)	((((a)>>8)&0xff) | ((a)<<8))
 
-#ifdef MODULE
-static struct net_device *root_zorro8390_dev;
-#endif
 
 static const struct card_info {
     zorro_id id;
@@ -72,7 +69,8 @@
     { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, "X-Surf", 0x8600 },
 };
 
-static int __init zorro8390_probe(void);
+static int __devinit zorro8390_init_one(struct zorro_dev *z,
+					const struct zorro_device_id *ent);
 static int __init zorro8390_init(struct net_device *dev, unsigned long board,
 				 const char *name, unsigned long ioaddr);
 static int zorro8390_open(struct net_device *dev);
@@ -85,44 +83,49 @@
 static void zorro8390_block_output(struct net_device *dev, const int count,
 				   const unsigned char *buf,
 				   const int start_page);
-static void __exit zorro8390_cleanup(void);
+static void __devexit zorro8390_remove_one(struct zorro_dev *z);
+
+static struct zorro_device_id zorro8390_zorro_tbl[] = {
+    { ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2, },
+    { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
+    { 0 }
+};
 
-static int __init zorro8390_probe(void)
+static struct zorro_driver zorro8390_driver = {
+    .name	= "zorro8390",
+    .id_table	= zorro8390_zorro_tbl,
+    .probe	= zorro8390_init_one,
+    .remove	= __devexit_p(zorro8390_remove_one),
+};
+
+static int __devinit zorro8390_init_one(struct zorro_dev *z,
+					const struct zorro_device_id *ent)
 {
     struct net_device *dev;
-    struct zorro_dev *z = NULL;
     unsigned long board, ioaddr;
-    int err = -ENODEV;
-    int i;
+    int err, i;
 
-    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-	for (i = ARRAY_SIZE(cards)-1; i >= 0; i--)
-	    if (z->id == cards[i].id)
-		break;
-	if (i < 0)
-	    continue;
-	board = z->resource.start;
-	ioaddr = board+cards[i].offset;
-	dev = init_etherdev(0, 0);
-	SET_MODULE_OWNER(dev);
-	if (!dev)
-	    return -ENOMEM;
-	if (!request_mem_region(ioaddr, NE_IO_EXTENT*2, dev->name)) {
-	    kfree(dev);
-	    continue;
-	}
-	if ((err = zorro8390_init(dev, board, cards[i].name,
-				  ZTWO_VADDR(ioaddr)))) {
-	    release_mem_region(ioaddr, NE_IO_EXTENT*2);
-	    kfree(dev);
-	    return err;
-	}
-	err = 0;
+    for (i = ARRAY_SIZE(cards)-1; i >= 0; i--)
+	if (z->id == cards[i].id)
+	    break;
+    board = z->resource.start;
+    ioaddr = board+cards[i].offset;
+    dev = init_etherdev(0, 0);
+    SET_MODULE_OWNER(dev);
+    if (!dev)
+	return -ENOMEM;
+    if (!request_mem_region(ioaddr, NE_IO_EXTENT*2, dev->name)) {
+	kfree(dev);
+	return -EBUSY;
     }
-
-    if (err == -ENODEV)
-	printk("No Ariadne II or X-Surf ethernet card found.\n");
-    return err;
+    if ((err = zorro8390_init(dev, board, cards[i].name,
+			      ZTWO_VADDR(ioaddr)))) {
+	release_mem_region(ioaddr, NE_IO_EXTENT*2);
+	kfree(dev);
+	return err;
+    }
+    zorro_set_drvdata(z, dev);
+    return 0;
 }
 
 static int __init zorro8390_init(struct net_device *dev, unsigned long board,
@@ -227,10 +230,6 @@
     ei_status.reg_offset = zorro8390_offsets;
     dev->open = &zorro8390_open;
     dev->stop = &zorro8390_close;
-#ifdef MODULE
-    ei_status.priv = (unsigned long)root_zorro8390_dev;
-    root_zorro8390_dev = dev;
-#endif
     NS8390_init(dev, 0);
     return 0;
 }
@@ -403,23 +402,27 @@
     return;
 }
 
-static void __exit zorro8390_cleanup(void)
+static void __devexit zorro8390_remove_one(struct zorro_dev *z)
 {
-#ifdef MODULE
-    struct net_device *dev, *next;
+    struct net_device *dev = zorro_get_drvdata(z);
 
-    while ((dev = root_zorro8390_dev)) {
-	next = (struct net_device *)(ei_status.priv);
-	unregister_netdev(dev);
-	free_irq(IRQ_AMIGA_PORTS, dev);
-	release_mem_region(ZTWO_PADDR(dev->base_addr), NE_IO_EXTENT*2);
-	free_netdev(dev);
-	root_zorro8390_dev = next;
-    }
-#endif
+    unregister_netdev(dev);
+    free_irq(IRQ_AMIGA_PORTS, dev);
+    release_mem_region(ZTWO_PADDR(dev->base_addr), NE_IO_EXTENT*2);
+    free_netdev(dev);
+}
+
+static int __init zorro8390_init_module(void)
+{
+    return zorro_module_init(&zorro8390_driver);
+}
+
+static void __exit zorro8390_cleanup_module(void)
+{
+    zorro_unregister_driver(&zorro8390_driver);
 }
 
-module_init(zorro8390_probe);
-module_exit(zorro8390_cleanup);
+module_init(zorro8390_init_module);
+module_exit(zorro8390_cleanup_module);
 
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
