Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUBTM5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUBTMzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:55:31 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:43591 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261220AbUBTMxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:53:19 -0500
Date: Fri, 20 Feb 2004 13:46:45 +0100
Message-Id: <200402201246.i1KCkj7H004247@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 403] Amiga A2065 Ethernet new driver model
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A2065 Ethernet: Convert to the new driver model

--- linux-2.6.3/drivers/net/a2065.c	2004-02-08 10:19:29.000000000 +0100
+++ linux-m68k-2.6.3/drivers/net/a2065.c	2004-02-08 11:51:15.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * Amiga Linux/68k A2065 Ethernet Driver
  *
- * (C) Copyright 1995 by Geert Uytterhoeven <geert@linux-m68k.org>
+ * (C) Copyright 1995-2003 by Geert Uytterhoeven <geert@linux-m68k.org>
  *
  * Fixes and tips by:
  *	- Janos Farkas (CHEXUM@sparta.banki.hu)
@@ -130,14 +130,8 @@
 	int burst_sizes;	      /* ledma SBus burst sizes */
 #endif
 	struct timer_list         multicast_timer;
-	struct net_device *dev;		/* Backpointer */
-	struct lance_private *next_module;
 };
 
-#ifdef MODULE
-static struct lance_private *root_a2065_dev;
-#endif
-
 #define TX_BUFFS_AVAIL ((lp->tx_old<=lp->tx_new)?\
 			lp->tx_old+lp->tx_ring_mod_mask-lp->tx_new:\
 			lp->tx_old - lp->tx_new-1)
@@ -704,133 +698,141 @@
 	netif_wake_queue(dev);
 }
 
-static int __init a2065_probe(void)
+static int __devinit a2065_init_one(struct zorro_dev *z,
+				    const struct zorro_device_id *ent);
+static void __devexit a2065_remove_one(struct zorro_dev *z);
+
+
+static struct zorro_device_id a2065_zorro_tbl[] __devinitdata = {
+	{ ZORRO_PROD_CBM_A2065_1 },
+	{ ZORRO_PROD_CBM_A2065_2 },
+	{ ZORRO_PROD_AMERISTAR_A2065 },
+	{ 0 }
+};
+
+static struct zorro_driver a2065_driver = {
+	.name		= "a2065",
+	.id_table	= a2065_zorro_tbl,
+	.probe		= a2065_init_one,
+	.remove		= __devexit_p(a2065_remove_one),
+};
+
+static int __devinit a2065_init_one(struct zorro_dev *z,
+				    const struct zorro_device_id *ent)
 {
-	struct zorro_dev *z = NULL;
 	struct net_device *dev;
 	struct lance_private *priv;
-	int res = -ENODEV;
-
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		unsigned long board, base_addr, mem_start;
-		struct resource *r1, *r2;
-		int is_cbm;
-
-		if (z->id == ZORRO_PROD_CBM_A2065_1 ||
-		    z->id == ZORRO_PROD_CBM_A2065_2)
-			is_cbm = 1;
-		else if (z->id == ZORRO_PROD_AMERISTAR_A2065)
-			is_cbm = 0;
-		else
-			continue;
-
-		board = z->resource.start;
-		base_addr = board+A2065_LANCE;
-		mem_start = board+A2065_RAM;
-
-		r1 = request_mem_region(base_addr, sizeof(struct lance_regs),
-					"Am7990");
-		if (!r1) continue;
-		r2 = request_mem_region(mem_start, A2065_RAM_SIZE, "RAM");
-		if (!r2) {
-			release_resource(r1);
-			continue;
-		}
+	unsigned long board, base_addr, mem_start;
+	struct resource *r1, *r2;
+	int err;
+
+	board = z->resource.start;
+	base_addr = board+A2065_LANCE;
+	mem_start = board+A2065_RAM;
+
+	r1 = request_mem_region(base_addr, sizeof(struct lance_regs),
+				"Am7990");
+	if (!r1)
+		return -EBUSY;
+	r2 = request_mem_region(mem_start, A2065_RAM_SIZE, "RAM");
+	if (!r2) {
+		release_resource(r1);
+		return -EBUSY;
+	}
+
+	dev = alloc_etherdev(sizeof(struct lance_private));
+	if (dev == NULL) {
+		release_resource(r1);
+		release_resource(r2);
+		return -ENOMEM;
+	}
+
+	SET_MODULE_OWNER(dev);
+	priv = dev->priv;
+
+	r1->name = dev->name;
+	r2->name = dev->name;
+
+	dev->dev_addr[0] = 0x00;
+	if (z->id != ZORRO_PROD_AMERISTAR_A2065) {	/* Commodore */
+		dev->dev_addr[1] = 0x80;
+		dev->dev_addr[2] = 0x10;
+	} else {					/* Ameristar */
+		dev->dev_addr[1] = 0x00;
+		dev->dev_addr[2] = 0x9f;
+	}
+	dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
+	dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
+	dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
+	printk("%s: A2065 at 0x%08lx, Ethernet Address "
+	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
+	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
+	dev->base_addr = ZTWO_VADDR(base_addr);
+	dev->mem_start = ZTWO_VADDR(mem_start);
+	dev->mem_end = dev->mem_start+A2065_RAM_SIZE;
+
+	priv->ll = (volatile struct lance_regs *)dev->base_addr;
+	priv->init_block = (struct lance_init_block *)dev->mem_start;
+	priv->lance_init_block = (struct lance_init_block *)A2065_RAM;
+	priv->auto_select = 0;
+	priv->busmaster_regval = LE_C3_BSWP;
+
+	priv->lance_log_rx_bufs = LANCE_LOG_RX_BUFFERS;
+	priv->lance_log_tx_bufs = LANCE_LOG_TX_BUFFERS;
+	priv->rx_ring_mod_mask = RX_RING_MOD_MASK;
+	priv->tx_ring_mod_mask = TX_RING_MOD_MASK;
+
+	dev->open = &lance_open;
+	dev->stop = &lance_close;
+	dev->hard_start_xmit = &lance_start_xmit;
+	dev->tx_timeout = &lance_tx_timeout;
+	dev->watchdog_timeo = 5*HZ;
+	dev->get_stats = &lance_get_stats;
+	dev->set_multicast_list = &lance_set_multicast;
+	dev->dma = 0;
+
+	init_timer(&priv->multicast_timer);
+	priv->multicast_timer.data = (unsigned long) dev;
+	priv->multicast_timer.function =
+		(void (*)(unsigned long)) &lance_set_multicast;
+
+	err = register_netdev(dev);
+	if (err) {
+		release_resource(r1);
+		release_resource(r2);
+		free_netdev(dev);
+		return err;
+	}
+	zorro_set_drvdata(z, dev);
 
-		dev = alloc_etherdev(sizeof(struct lance_private));
+	return 0;
+}
 
-		if (dev == NULL) {
-			release_resource(r1);
-			release_resource(r2);
-			return -ENOMEM;
-		}
-		SET_MODULE_OWNER(dev);
-		priv = dev->priv;
 
-		r1->name = dev->name;
-		r2->name = dev->name;
+static void __devexit a2065_remove_one(struct zorro_dev *z)
+{
+	struct net_device *dev = zorro_get_drvdata(z);
 
-		priv->dev = dev;
-		dev->dev_addr[0] = 0x00;
-		if (is_cbm) {				/* Commodore */
-			dev->dev_addr[1] = 0x80;
-			dev->dev_addr[2] = 0x10;
-		} else {				/* Ameristar */
-			dev->dev_addr[1] = 0x00;
-			dev->dev_addr[2] = 0x9f;
-		}
-		dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
-		dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
-		dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
-		printk("%s: A2065 at 0x%08lx, Ethernet Address "
-		       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
-		       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-		       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
-		dev->base_addr = ZTWO_VADDR(base_addr);
-		dev->mem_start = ZTWO_VADDR(mem_start);
-		dev->mem_end = dev->mem_start+A2065_RAM_SIZE;
-
-		priv->ll = (volatile struct lance_regs *)dev->base_addr;
-		priv->init_block = (struct lance_init_block *)dev->mem_start;
-		priv->lance_init_block = (struct lance_init_block *)A2065_RAM;
-		priv->auto_select = 0;
-		priv->busmaster_regval = LE_C3_BSWP;
-
-		priv->lance_log_rx_bufs = LANCE_LOG_RX_BUFFERS;
-		priv->lance_log_tx_bufs = LANCE_LOG_TX_BUFFERS;
-		priv->rx_ring_mod_mask = RX_RING_MOD_MASK;
-		priv->tx_ring_mod_mask = TX_RING_MOD_MASK;
-
-		dev->open = &lance_open;
-		dev->stop = &lance_close;
-		dev->hard_start_xmit = &lance_start_xmit;
-		dev->tx_timeout = &lance_tx_timeout;
-		dev->watchdog_timeo = 5*HZ;
-		dev->get_stats = &lance_get_stats;
-		dev->set_multicast_list = &lance_set_multicast;
-		dev->dma = 0;
-
-		init_timer(&priv->multicast_timer);
-		priv->multicast_timer.data = (unsigned long) dev;
-		priv->multicast_timer.function =
-			(void (*)(unsigned long)) &lance_set_multicast;
-
-		res = register_netdev(dev);
-		if (res) {
-			release_resource(r1);
-			release_resource(r2);
-			free_netdev(dev);
-			break;
-		}
-#ifdef MODULE
-		priv->next_module = root_a2065_dev;
-		root_a2065_dev = priv;
-#endif
-	}
-	return res;
+	unregister_netdev(dev);
+	release_mem_region(ZTWO_PADDR(dev->base_addr),
+			   sizeof(struct lance_regs));
+	release_mem_region(ZTWO_PADDR(dev->mem_start), A2065_RAM_SIZE);
+	free_netdev(dev);
 }
 
-
-static void __exit a2065_cleanup(void)
+static int __init a2065_init_module(void)
 {
-#ifdef MODULE
-	struct lance_private *next;
-	struct net_device *dev;
+	return zorro_module_init(&a2065_driver);
+}
 
-	while (root_a2065_dev) {
-		next = root_a2065_dev->next_module;
-		dev = root_a2065_dev->dev;
-		unregister_netdev(dev);
-		release_mem_region(ZTWO_PADDR(dev->base_addr),
-				   sizeof(struct lance_regs));
-		release_mem_region(ZTWO_PADDR(dev->mem_start), A2065_RAM_SIZE);
-		free_netdev(dev);
-		root_a2065_dev = next;
-	}
-#endif
+static void __exit a2065_cleanup_module(void)
+{
+	zorro_unregister_driver(&a2065_driver);
 }
 
-module_init(a2065_probe);
-module_exit(a2065_cleanup);
+module_init(a2065_init_module);
+module_exit(a2065_cleanup_module);
+
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
