Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbTDAS2C>; Tue, 1 Apr 2003 13:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTDAS2C>; Tue, 1 Apr 2003 13:28:02 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:32817
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S262713AbTDAS1o>; Tue, 1 Apr 2003 13:27:44 -0500
Message-ID: <3E89DBFD.8040101@rogers.com>
Date: Tue, 01 Apr 2003 13:35:41 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 3/3] NE2000 driver updates
References: <3E89DB3C.7020909@rogers.com>
In-Reply-To: <3E89DB3C.7020909@rogers.com>
Content-Type: multipart/mixed;
 boundary="------------090706030904040404080706"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Tue, 1 Apr 2003 13:38:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090706030904040404080706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090706030904040404080706
Content-Type: text/plain;
 name="ne-legacy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-legacy.patch"

diff -u linux-2.5.66-nepnpid/drivers/net/ne.c linux-2.5.66-nelist/drivers/net/ne.c
--- linux-2.5.66-nepnpid/drivers/net/ne.c	2003-03-29 21:39:29.000000000 -0500
+++ linux-2.5.66-nelist/drivers/net/ne.c	2003-03-29 21:39:38.000000000 -0500
@@ -36,7 +36,7 @@
 /* Routines for the NatSemi-based designs (NE[12]000). */
 
 static const char version[] =
-"ne.c:v1.10a 1/26/03 Donald Becker (becker@scyld.com)\n";
+"ne.c:v1.10b 4/1/03 Donald Becker (becker@scyld.com)\n";
 
 
 #include <linux/module.h>
@@ -134,7 +134,6 @@
 #ifdef CONFIG_PNP
 static int ne_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id);
 static void ne_pnp_remove(struct pnp_dev *dev);
-
 static struct pnp_driver ne_pnp_driver = {
 	.name		= "ne",
 	.id_table 	= ne_pnp_table,
@@ -143,9 +142,14 @@
 };
 #endif
 
-int ne_probe(struct net_device *dev);
+static int ne_legacy_probe(unsigned long base_addr, unsigned long irq, unsigned long bad);
+
 static int ne_probe1(struct net_device *dev, int ioaddr);
 
+static int ne_create(struct net_device **ndev, unsigned long base_addr, 
+		unsigned long irq, unsigned long bad);
+static void ne_remove(struct net_device *dev);
+
 static int ne_open(struct net_device *dev);
 static int ne_close(struct net_device *dev);
 
@@ -179,82 +183,90 @@
 	E2010	 starts at 0x100 and ends at 0x4000.
 	E2010-x starts at 0x100 and ends at 0xffff.  */
 
-int __init ne_probe(struct net_device *dev)
+#ifdef CONFIG_PNP
+static int ne_pnp_probe(struct pnp_dev *idev, const struct pnp_device_id *dev_id)
 {
-	unsigned int base_addr = dev->base_addr;
-
-	SET_MODULE_OWNER(dev);
-
-	/* First check any supplied i/o locations. User knows best. <cough> */
-	if (base_addr > 0x1ff)	/* Check a single specified location. */
-		return ne_probe1(dev, base_addr);
-	else if (base_addr != 0)	/* Don't probe at all. */
-		return -ENXIO;
+	struct net_device *dev = NULL;
+	int err;
+	printk(KERN_INFO "ne.c: PnP reports %s at i/o %#lx, irq %ld\n",
+			idev->dev.name, pnp_port_start(idev, 0), pnp_irq(idev, 0));
+	err = ne_create(&dev, pnp_port_start(idev, 0), pnp_irq(idev, 0), 0);
+	if(dev)
+		pnp_set_drvdata(idev, dev);
+	return err;
+}
 
-#ifndef MODULE
-	/* Last resort. The semi-risky ISA auto-probe. */
-	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
-		int ioaddr = netcard_portlist[base_addr];
-		if (ne_probe1(dev, ioaddr) == 0)
-			return 0;
-	}
+static void ne_pnp_remove(struct pnp_dev *idev)
+{
+	struct net_device *dev = pnp_get_drvdata(idev);	
+	ne_remove(dev);
+}
 #endif
+struct list_head ne_legacy_devs = LIST_HEAD_INIT(ne_legacy_devs);
 
-	return -ENODEV;
+struct ne_legacy{
+	struct net_device *dev;
+	struct list_head list;
+};
+
+static int ne_legacy_probe(unsigned long base_addr, unsigned long irq, unsigned long bad)
+{
+	struct ne_legacy *ne_card;
+	int err;
+	ne_card = kmalloc(sizeof(struct ne_legacy), GFP_KERNEL);
+	err = ne_create(&ne_card->dev, base_addr, irq,  bad);
+	if (!err) 
+		list_add(&ne_card->list, &ne_legacy_devs);
+	else
+		kfree(ne_card);
+	return err;
 }
 
-#ifdef CONFIG_PNP
-static int ne_pnp_probe(struct pnp_dev *idev, const struct pnp_device_id *dev_id)
+static int ne_create(struct net_device **ndev, unsigned long base_addr, unsigned long irq, unsigned long bad)
 {
-	struct net_device *dev;
 	int err;
 	
-	if ( !(dev = alloc_etherdev(0)) ){
+	if (!(*ndev = alloc_etherdev(0)) ){
 		err = -ENOMEM;
 		goto alloc_fail;
 	}
 	
-	dev->base_addr = pnp_port_start(idev, 0);
-	dev->irq = pnp_irq(idev, 0);
-	printk(KERN_INFO "ne.c: PnP reports %s at i/o %#lx, irq %d\n",
-			idev->dev.name, dev->base_addr, dev->irq);
+	(*ndev)->base_addr = base_addr;
+	(*ndev)->irq = irq;
+	(*ndev)->mem_end = bad;
+	SET_MODULE_OWNER(*ndev);
 	
-	SET_MODULE_OWNER(dev);
-	
-	if (ne_probe1(dev, dev->base_addr) != 0) {	/* Shouldn't happen. */
-		printk(KERN_ERR "ne.c: Probe of PnP card at %#lx failed\n", dev->base_addr);
+	if (ne_probe1(*ndev, (*ndev)->base_addr) != 0) {	/* Shouldn't happen. */
+		printk(KERN_ERR "ne.c: Probe at %#lx failed\n", (*ndev)->base_addr);
 		err = -ENXIO;
 		goto probe_fail;
 	}
 	
-	if ( (err = register_netdev(dev)) != 0)
+	if ( (err = register_netdev(*ndev)) != 0)
 		goto register_fail;
-
-	pnp_set_drvdata(idev, dev);
 	
 	return 0;
 	
 register_fail:
-		kfree(dev->priv);
-		release_region(dev->base_addr, NE_IO_EXTENT);
+		kfree((*ndev)->priv);
+		release_region((*ndev)->base_addr, NE_IO_EXTENT);
 probe_fail:
-		kfree(dev);
+		kfree(*ndev);
 alloc_fail:
 		return err;
 }
 
-static void ne_pnp_remove(struct pnp_dev *idev)
+static void ne_remove(struct net_device *dev)
 {
-	struct net_device *dev = pnp_get_drvdata(idev);	
 	if (dev) {
 		unregister_netdev(dev);
 		free_irq(dev->irq, dev);
 		release_region(dev->base_addr, NE_IO_EXTENT);
-		kfree(dev->priv);
+		if(dev->priv)
+			kfree(dev->priv);
 		kfree(dev);
 	}
 }
-#endif
 
 static int __init ne_probe1(struct net_device *dev, int ioaddr)
 {
@@ -751,10 +763,7 @@
 	return;
 }
 
-
-#ifdef MODULE
 #define MAX_NE_CARDS	4	/* Max number of NE cards per module */
-static struct net_device dev_ne[MAX_NE_CARDS];
 static int io[MAX_NE_CARDS];
 static int irq[MAX_NE_CARDS];
 static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
@@ -773,60 +782,71 @@
 is at boot) and so the probe will get confused by any other 8390 cards.
 ISA device autoprobes on a running machine are not recommended anyway. */
 
-int init_module(void)
-{
-	int this_dev, found = 0;
 
+
+static int __init ne_init(void)
+{
+	int i, found = 0;
+	int err;
 #ifdef CONFIG_PNP	
-	found = pnp_register_driver(&ne_pnp_driver);
-	if (found < 0) {
-		return found;
+	err = pnp_register_driver(&ne_pnp_driver);
+	if (err < 0) {
+		goto pnp_fail;
 	}
+	else found += err;
 #endif
+	/* First check any supplied i/o locations. User knows best. <cough> */
+	for (i = 0; i < MAX_NE_CARDS; i++) {
+		if (io[i] > 0x1ff) {
+			err = ne_legacy_probe(io[i], irq[i], bad[i]);
+			if (!err)
+				found++;
+			else
+				printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[i]);
+		}
+	}
 
-	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ne[this_dev];
-		dev->irq = irq[this_dev];
-		dev->mem_end = bad[this_dev];
-		dev->base_addr = io[this_dev];
-		dev->init = ne_probe;
-		if (register_netdev(dev) == 0) {
+#ifndef MODULE
+	/* Last resort. The semi-risky ISA auto-probe. */
+	printk(KERN_INFO "ne.c: auto-probing...\m");
+	for (i = 0; netcard_portlist[i] != 0; i++) {
+		err = ne_legacy_probe(netcard_portlist[i], 0,  0);
+		if (!err) {
 			found++;
-			continue;
-		}
-		if (found != 0) { 	/* Got at least one. */
-			return 0;
-		}
-		if (io[this_dev] != 0)
-			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
-		else
-			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
+		} 
+	}
+#endif
+	if (found > 0) 	/* Got at least one. */
+		return 0;
+	else
+		printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
+
 #ifdef CONFIG_PNP
-		pnp_unregister_driver(&ne_pnp_driver);
+	pnp_unregister_driver(&ne_pnp_driver);
+pnp_fail:
 #endif
-		return -ENXIO;
-	}
-	return 0;
+	return -ENODEV;
 }
 
-void cleanup_module(void)
+static void __exit ne_cleanup(void)
 {
-	int this_dev;
-
+	struct list_head *entry;
+	struct list_head *tmp;
 #ifdef CONFIG_PNP	
 	pnp_unregister_driver(&ne_pnp_driver);
 #endif
-	for (this_dev = 0; this_dev < MAX_NE_CARDS; this_dev++) {
-		struct net_device *dev = &dev_ne[this_dev];
-		if (dev->priv != NULL) {
-			unregister_netdev(dev);
-			free_irq(dev->irq, dev);
-			release_region(dev->base_addr, NE_IO_EXTENT);
-			kfree(dev->priv);
-		}
+	/* Cleanup legacy devices */
+	list_for_each_safe(entry, tmp, &ne_legacy_devs) {
+		struct ne_legacy *card;
+		card = list_entry(entry, struct ne_legacy, list);
+		ne_remove(card->dev);
+		list_del(entry);
+		kfree(card);
 	}
 }
-#endif /* MODULE */
+
+module_init(ne_init);
+module_exit(ne_cleanup);
 
 
 /*
diff -u linux-2.5.66-nepnpid/drivers/net/Space.c linux-2.5.66-nelist/drivers/net/Space.c
--- linux-2.5.66-nepnpid/drivers/net/Space.c	2003-04-01 12:54:54.000000000 -0500
+++ linux-2.5.66-nelist/drivers/net/Space.c	2003-04-01 12:53:40.000000000 -0500
@@ -233,7 +233,7 @@
 #ifdef CONFIG_E2100		/* Cabletron E21xx series. */
 	{e2100_probe, 0},
 #endif
-#if defined(CONFIG_NE2000) || defined(CONFIG_NE2K_CBUS)	/* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
+#ifdef CONFIG_NE2K_CBUS	/* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
 #endif
 #ifdef CONFIG_LANCE		/* ISA/VLB (use pcnet32 for PCI cards) */

--------------090706030904040404080706--

