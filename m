Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUBHWsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUBHWsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:48:54 -0500
Received: from mail2.scram.de ([195.226.127.112]:17168 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S264283AbUBHWse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:48:34 -0500
Date: Sun, 8 Feb 2004 23:48:08 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tms380tr patch 1/3 (bug fix)
Message-ID: <Pine.LNX.4.58.0402082342300.1327@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

this fixes some problems partly introduced in the latest token ring
update:
- mix of alloc_trdev(0) and alloc_trdev(sizeof(struct net_local)) confused
  memory management.
- initialization of proteon and sknet cards was broken.
- proteon_close() and skisa_close() deleted.

--jochen

 abyss.c    |    2 -
 madgemc.c  |    2 -
 proteon.c  |   91 ++++++++++++++++++++++++-------------------------------
 skisa.c    |  100 +++++++++++++++++++++++++------------------------------------
 tms380tr.c |   41 +++++++++----------------
 tmspci.c   |    2 -
 6 files changed, 100 insertions(+), 138 deletions(-)


diff -u -p -r1.17 tms380tr.c
--- drivers/net/tokenring/tms380tr.c	7 Feb 2004 03:16:12 -0000	1.17
+++ drivers/net/tokenring/tms380tr.c	8 Feb 2004 22:24:43 -0000
@@ -246,6 +246,7 @@ int tms380tr_open(struct net_device *dev

 	/* init the spinlock */
 	spin_lock_init(&tp->lock);
+	init_timer(&tp->timer);

 	/* Reset the hardware here. Don't forget to set the station address. */

@@ -266,7 +267,6 @@ int tms380tr_open(struct net_device *dev
 		return (-1);
 	}

-	init_timer(&tp->timer);
 	tp->timer.expires	= jiffies + 30*HZ;
 	tp->timer.function	= tms380tr_timer_end_wait;
 	tp->timer.data		= (unsigned long)dev;
@@ -2342,37 +2342,26 @@ void tmsdev_term(struct net_device *dev)
 	tp = (struct net_local *) dev->priv;
 	pci_unmap_single(tp->pdev, tp->dmabuffer, sizeof(struct net_local),
 		PCI_DMA_BIDIRECTIONAL);
-	kfree(dev->priv);
 }

 int tmsdev_init(struct net_device *dev, unsigned long dmalimit,
 		struct pci_dev *pdev)
 {
-	if (dev->priv == NULL)
+	struct net_local *tms_local;
+
+	memset(dev->priv, 0, sizeof(struct net_local));
+	tms_local = (struct net_local *)dev->priv;
+	init_waitqueue_head(&tms_local->wait_for_tok_int);
+	tms_local->dmalimit = dmalimit;
+	tms_local->pdev = pdev;
+	tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
+	    sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
+	if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
 	{
-		struct net_local *tms_local;
-
-		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL | GFP_DMA);
-		if (dev->priv == NULL)
-		{
-                        printk(KERN_INFO "%s: Out of memory for DMA\n",
-                                dev->name);
-			return -ENOMEM;
-		}
-		memset(dev->priv, 0, sizeof(struct net_local));
-		tms_local = (struct net_local *)dev->priv;
-		init_waitqueue_head(&tms_local->wait_for_tok_int);
-		tms_local->dmalimit = dmalimit;
-		tms_local->pdev = pdev;
-                tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
-                        sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
-                if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
-                {
-			printk(KERN_INFO "%s: Memory not accessible for DMA\n",
-				dev->name);
-			tmsdev_term(dev);
-			return -ENOMEM;
-		}
+		printk(KERN_INFO "%s: Memory not accessible for DMA\n",
+			dev->name);
+		tmsdev_term(dev);
+		return -ENOMEM;
 	}

 	/* These can be overridden by the card driver if needed */
diff -u -p -r1.8 proteon.c
--- drivers/net/tokenring/proteon.c	5 Feb 2004 21:07:47 -0000	1.8
+++ drivers/net/tokenring/proteon.c	8 Feb 2004 10:31:36 -0000
@@ -65,7 +65,6 @@ static char cardname[] = "Proteon 1392\0

 struct net_device *proteon_probe(int unit);
 static int proteon_open(struct net_device *dev);
-static int proteon_close(struct net_device *dev);
 static void proteon_read_eeprom(struct net_device *dev);
 static unsigned short proteon_setnselout_pins(struct net_device *dev);

@@ -117,21 +116,15 @@ nodev:
 	return -ENODEV;
 }

-struct net_device * __init proteon_probe(int unit)
+static int __init setup_card(struct net_device *dev)
 {
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
 	struct net_local *tp;
         static int versionprinted;
 	const unsigned *port;
 	int j,err = 0;

 	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0) {
-		sprintf(dev->name, "tr%d", unit);
-		netdev_boot_setup_check(dev);
-	}
+		return -ENOMEM;

 	SET_MODULE_OWNER(dev);
 	if (dev->base_addr)	/* probe specific location */
@@ -178,7 +171,7 @@ struct net_device * __init proteon_probe
 	tp->tmspriv = NULL;

 	dev->open = proteon_open;
-	dev->stop = proteon_close;
+	dev->stop = tms380tr_close;

 	if (dev->irq == 0)
 	{
@@ -257,7 +250,7 @@ struct net_device * __init proteon_probe
 	if (err)
 		goto out;

-	return dev;
+	return 0;
 out:
 	free_dma(dev->dma);
 out2:
@@ -266,6 +259,29 @@ out3:
 	tmsdev_term(dev);
 out4:
 	release_region(dev->base_addr, PROTEON_IO_EXTENT);
+	return err;
+}
+
+struct net_device * __init proteon_probe(int unit)
+{
+	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
+	int err = 0;
+
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	if (unit >= 0) {
+		sprintf(dev->name, "tr%d", unit);
+		netdev_boot_setup_check(dev);
+	}
+
+	err = setup_card(dev);
+	if (err)
+		goto out;
+
+	return dev;
+
+out:
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -333,14 +349,7 @@ static int proteon_open(struct net_devic
 	val |= i;
 	outb(val, dev->base_addr + 0x13);

-	tms380tr_open(dev);
-	return 0;
-}
-
-static int proteon_close(struct net_device *dev)
-{
-	tms380tr_close(dev);
-	return 0;
+	return tms380tr_open(dev);
 }

 #ifdef MODULE
@@ -359,45 +368,25 @@ MODULE_PARM(dma, "1-" __MODULE_STRING(IS

 static struct net_device *proteon_dev[ISATR_MAX_ADAPTERS];

-static struct net_device * __init setup_card(unsigned long io, unsigned irq, unsigned char dma)
-{
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
-	int err;
-
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->irq = irq;
-	dev->dma = dma;
-	err = proteon_probe1(dev, io);
-	if (err)
-		goto out;
-
-	err = register_netdev(dev);
-	if (err)
-		goto out1;
-	return dev;
- out1:
-	release_region(dev->base_addr, PROTEON_IO_EXTENT);
-	free_irq(dev->irq, dev);
-	free_dma(dev->dma);
-	tmsdev_term(dev);
- out:
-	free_netdev(dev);
-	return ERR_PTR(err);
-}
-
 int init_module(void)
 {
 	struct net_device *dev;
-	int i, num = 0;
+	int i, num = 0, err = 0;

 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
-		dev = io[0] ? setup_card(io[i], irq[i], dma[i])
-			: proteon_probe(-1);
-		if (!IS_ERR(dev)) {
+		dev = alloc_trdev(sizeof(struct net_local));
+		if (!dev)
+			continue;
+
+		dev->base_addr = io[i];
+		dev->irq = irq[i];
+		dev->dma = dma[i];
+		err = setup_card(dev);
+		if (!err) {
 			proteon_dev[i] = dev;
 			++num;
+		} else {
+			free_netdev(dev);
 		}
 	}

diff -u -p -r1.7 skisa.c
--- drivers/net/tokenring/skisa.c	5 Feb 2004 21:07:47 -0000	1.7
+++ drivers/net/tokenring/skisa.c	8 Feb 2004 10:31:23 -0000
@@ -69,8 +69,8 @@ static int dmalist[] __initdata = {

 static char isa_cardname[] = "SK NET TR 4/16 ISA\0";

+struct net_device *sk_isa_probe(int unit);
 static int sk_isa_open(struct net_device *dev);
-static int sk_isa_close(struct net_device *dev);
 static void sk_isa_read_eeprom(struct net_device *dev);
 static unsigned short sk_isa_setnselout_pins(struct net_device *dev);

@@ -133,21 +133,15 @@ static int __init sk_isa_probe1(struct n
 	return 0;
 }

-struct net_device * __init sk_isa_probe(int unit)
+static int __init setup_card(struct net_device *dev)
 {
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
 	struct net_local *tp;
         static int versionprinted;
 	const unsigned *port;
 	int j, err = 0;

 	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0) {
-		sprintf(dev->name, "tr%d", unit);
-		netdev_boot_setup_check(dev);
-	}
+		return -ENOMEM;

 	SET_MODULE_OWNER(dev);
 	if (dev->base_addr)	/* probe specific location */
@@ -194,7 +188,7 @@ struct net_device * __init sk_isa_probe(
 	tp->tmspriv = NULL;

 	dev->open = sk_isa_open;
-	dev->stop = sk_isa_close;
+	dev->stop = tms380tr_close;

 	if (dev->irq == 0)
 	{
@@ -273,7 +267,7 @@ struct net_device * __init sk_isa_probe(
 	if (err)
 		goto out;

-	return dev;
+	return 0;
 out:
 	free_dma(dev->dma);
 out2:
@@ -282,6 +276,28 @@ out3:
 	tmsdev_term(dev);
 out4:
 	release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+	return err;
+}
+
+struct net_device * __init sk_isa_probe(int unit)
+{
+	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
+	int err = 0;
+
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	if (unit >= 0) {
+		sprintf(dev->name, "tr%d", unit);
+		netdev_boot_setup_check(dev);
+	}
+
+	err = setup_card(dev);
+	if (err)
+		goto out;
+
+	return dev;
+out:
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -342,22 +358,13 @@ static int sk_isa_open(struct net_device
 	val &= oldval;
 	sk_isa_sifwriteb(dev, val, POSREG);

-	tms380tr_open(dev);
-	return 0;
-}
-
-static int sk_isa_close(struct net_device *dev)
-{
-	tms380tr_close(dev);
-	return 0;
+	return tms380tr_open(dev);
 }

 #ifdef MODULE

 #define ISATR_MAX_ADAPTERS 3

-static struct net_device *sk_isa_dev[ISATR_MAX_ADAPTERS];
-
 static int io[ISATR_MAX_ADAPTERS];
 static int irq[ISATR_MAX_ADAPTERS];
 static int dma[ISATR_MAX_ADAPTERS];
@@ -368,51 +375,28 @@ MODULE_PARM(io, "1-" __MODULE_STRING(ISA
 MODULE_PARM(irq, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
 MODULE_PARM(dma, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");

-static struct net_device * __init setup_card(unsigned long io, unsigned irq, unsigned char dma)
-{
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
-	int err;
-
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->base_addr = io;
-	dev->irq       = irq;
-	dev->dma       = dma;
-
-	err = sk_isa_probe1(dev, io);
-	if (err)
-		goto out;
-
-	err = register_netdev(dev);
-	if (err)
-		goto out1;
-	return dev;
-
- out1:
-	release_region(dev->base_addr, SK_ISA_IO_EXTENT);
-	free_irq(dev->irq, dev);
-	free_dma(dev->dma);
-	tmsdev_term(dev);
- out:
-	free_netdev(dev);
-	return ERR_PTR(err);
-}
+static struct net_device *sk_isa_dev[ISATR_MAX_ADAPTERS];

 int init_module(void)
 {
 	struct net_device *dev;
-	int i, num;
+	int i, num = 0, err = 0;

-	num = 0;
 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
-		if (io[0])  /* Only probe addresses from command line */
-			dev = setup_card(io[i], irq[i], dma[i]);
-		else
-			dev = sk_isa_probe(-1);
-		if (!IS_ERR(dev)) {
+		dev = alloc_trdev(sizeof(struct net_local));
+		if (!dev)
+			continue;
+
+		dev->base_addr = io[i];
+		dev->irq = irq[i];
+		dev->dma = dma[i];
+		err = setup_card(dev);
+
+		if (!err) {
 			sk_isa_dev[i] = dev;
 			++num;
+		} else {
+			free_netdev(dev);
 		}
 	}

diff -u -p -r1.17 tmspci.c
--- drivers/net/tokenring/tmspci.c	5 Feb 2004 21:07:47 -0000	1.17
+++ drivers/net/tokenring/tmspci.c	25 Jan 2004 18:40:51 -0000
@@ -112,7 +112,7 @@ static int __devinit tms_pci_attach(stru
 	pci_ioaddr = pci_resource_start (pdev, 0);

 	/* At this point we have found a valid card. */
-	dev = alloc_trdev(0);
+	dev = alloc_trdev(sizeof(struct net_local));
 	if (!dev)
 		return -ENOMEM;
 	SET_MODULE_OWNER(dev);
diff -u -p -r1.14 abyss.c
--- drivers/net/tokenring/abyss.c	5 Feb 2004 21:07:47 -0000	1.14
+++ drivers/net/tokenring/abyss.c	8 Feb 2004 22:31:38 -0000
@@ -112,7 +112,7 @@ static int __devinit abyss_attach(struct

 	/* At this point we have found a valid card. */

-	dev = alloc_trdev(0);
+	dev = alloc_trdev(sizeof(struct net_local));
 	if (!dev)
 		return -ENOMEM;

diff -u -p -r1.19 madgemc.c
--- drivers/net/tokenring/madgemc.c	5 Feb 2004 21:07:47 -0000	1.19
+++ drivers/net/tokenring/madgemc.c	8 Feb 2004 22:32:01 -0000
@@ -177,7 +177,7 @@ static int __init madgemc_probe(void)
 		if (versionprinted++ == 0)
 			printk("%s", version);

-		dev = alloc_trdev(0);
+		dev = alloc_trdev(sizeof(struct net_local));
 		if (dev == NULL) {
 			printk("madgemc: unable to allocate dev space\n");
 			if (madgemc_card_list)
