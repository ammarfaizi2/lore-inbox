Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVGWKZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVGWKZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGWKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 06:25:57 -0400
Received: from mail1.nwe.de ([195.226.126.83]:18365 "EHLO mail1.nwe.de")
	by vger.kernel.org with ESMTP id S261427AbVGWKZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 06:25:53 -0400
Date: Sat, 23 Jul 2005 12:25:18 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH 2.6: tms380tr update: move to DMA API
Message-ID: <Pine.LNX.4.58.0507231218440.15622@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

this patch makes tms380tr use the new DMA API. Now that on Alpha, this API
also supports bus master DMA for ISA (platform) devices, i changed the
driver to use this new API.

This also works around a bug in the firmware loader: The example provided
in Documentation/firmware_class no longer works, as the firmware loader
now calls get_kobj_path_length() and the kernel promptly oopses, as the
home-grown device doesn't have a parent. Of course, this doesn't happen
with a "real" device which has its bus (or pseudo bus in the case of
platform) as parent.

Signed-off-by: Jochen Friedrich <jochen@scram.de>

Converted tms380tr to use new DMA API:
  - proteon.c, skisa.c: use platform pseudo bus to create a struct device
  - Space.c: delete init hooks
  - abyss.c, tmspci.c: pass struct device to tms380tr.c
  - tms380tr.c, tms380tr.h: new DMA API, use real device fo firmware loader

---
commit 776158cf2f3ce514c6001869dfdcf0bd3911760d
tree 6194d993401e8afb990f23568dc23e314d150832
parent f60f700876cd51de9de69f3a3c865d95e287a24d
author Jochen Friedrich <jochen@scram.de> Sat, 23 Jul 2005 11:48:50 +0200
committer Jochen Friedrich <jochen@scram.de> Sat, 23 Jul 2005 11:48:50 +0200

 drivers/net/Space.c              |    6 --
 drivers/net/tokenring/abyss.c    |    2 -
 drivers/net/tokenring/proteon.c  |  104 ++++++++++++++++++--------------------
 drivers/net/tokenring/skisa.c    |  104 ++++++++++++++++++--------------------
 drivers/net/tokenring/tms380tr.c |   37 ++++++--------
 drivers/net/tokenring/tms380tr.h |    8 +--
 drivers/net/tokenring/tmspci.c   |    4 +
 7 files changed, 122 insertions(+), 143 deletions(-)

diff --git a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -323,12 +323,6 @@ extern struct net_device *proteon_probe(
 extern struct net_device *smctr_probe(int unit);

 static struct devprobe2 tr_probes2[] __initdata = {
-#ifdef CONFIG_SKISA
-	{sk_isa_probe, 0},
-#endif
-#ifdef CONFIG_PROTEON
-	{proteon_probe, 0},
-#endif
 #ifdef CONFIG_SMCTR
 	{smctr_probe, 0},
 #endif
diff --git a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
--- a/drivers/net/tokenring/abyss.c
+++ b/drivers/net/tokenring/abyss.c
@@ -139,7 +139,7 @@ static int __devinit abyss_attach(struct
 	 */
 	dev->base_addr += 0x10;

-	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, pdev);
+	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, &pdev->dev);
 	if (ret) {
 		printk("%s: unable to get memory for dev->priv.\n",
 		       dev->name);
diff --git a/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
--- a/drivers/net/tokenring/proteon.c
+++ b/drivers/net/tokenring/proteon.c
@@ -62,8 +62,7 @@ static int dmalist[] __initdata = {
 };

 static char cardname[] = "Proteon 1392\0";
-
-struct net_device *proteon_probe(int unit);
+static u64 dma_mask = ISA_MAX_ADDRESS;
 static int proteon_open(struct net_device *dev);
 static void proteon_read_eeprom(struct net_device *dev);
 static unsigned short proteon_setnselout_pins(struct net_device *dev);
@@ -116,7 +115,7 @@ nodev:
 	return -ENODEV;
 }

-static int __init setup_card(struct net_device *dev)
+static int __init setup_card(struct net_device *dev, struct device *pdev)
 {
 	struct net_local *tp;
         static int versionprinted;
@@ -137,7 +136,7 @@ static int __init setup_card(struct net_
 		}
 	}
 	if (err)
-		goto out4;
+		goto out5;

 	/* At this point we have found a valid card. */

@@ -145,14 +144,15 @@ static int __init setup_card(struct net_
 		printk(KERN_DEBUG "%s", version);

 	err = -EIO;
-	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
+	pdev->dma_mask = &dma_mask;
+	if (tmsdev_init(dev, ISA_MAX_ADDRESS, pdev))
 		goto out4;

 	dev->base_addr &= ~3;

 	proteon_read_eeprom(dev);

-	printk(KERN_DEBUG "%s:    Ring Station Address: ", dev->name);
+	printk(KERN_DEBUG "proteon.c:    Ring Station Address: ");
 	printk("%2.2x", dev->dev_addr[0]);
 	for (j = 1; j < 6; j++)
 		printk(":%2.2x", dev->dev_addr[j]);
@@ -185,7 +185,7 @@ static int __init setup_card(struct net_

                 if(irqlist[j] == 0)
                 {
-                        printk(KERN_INFO "%s: AutoSelect no IRQ available\n", dev->name);
+                        printk(KERN_INFO "proteon.c: AutoSelect no IRQ available\n");
 			goto out3;
 		}
 	}
@@ -196,15 +196,15 @@ static int __init setup_card(struct net_
 				break;
 		if (irqlist[j] == 0)
 		{
-			printk(KERN_INFO "%s: Illegal IRQ %d specified\n",
-				dev->name, dev->irq);
+			printk(KERN_INFO "proteon.c: Illegal IRQ %d specified\n",
+				dev->irq);
 			goto out3;
 		}
 		if (request_irq(dev->irq, tms380tr_interrupt, 0,
 			cardname, dev))
 		{
-                        printk(KERN_INFO "%s: Selected IRQ %d not available\n",
-				dev->name, dev->irq);
+                        printk(KERN_INFO "proteon.c: Selected IRQ %d not available\n",
+				dev->irq);
 			goto out3;
 		}
 	}
@@ -220,7 +220,7 @@ static int __init setup_card(struct net_

 		if(dmalist[j] == 0)
 		{
-			printk(KERN_INFO "%s: AutoSelect no DMA available\n", dev->name);
+			printk(KERN_INFO "proteon.c: AutoSelect no DMA available\n");
 			goto out2;
 		}
 	}
@@ -231,25 +231,25 @@ static int __init setup_card(struct net_
 				break;
 		if (dmalist[j] == 0)
 		{
-                        printk(KERN_INFO "%s: Illegal DMA %d specified\n",
-				dev->name, dev->dma);
+                        printk(KERN_INFO "proteon.c: Illegal DMA %d specified\n",
+				dev->dma);
 			goto out2;
 		}
 		if (request_dma(dev->dma, cardname))
 		{
-                        printk(KERN_INFO "%s: Selected DMA %d not available\n",
-				dev->name, dev->dma);
+                        printk(KERN_INFO "proteon.c: Selected DMA %d not available\n",
+				dev->dma);
 			goto out2;
 		}
 	}

-	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
-	       dev->name, dev->base_addr, dev->irq, dev->dma);
-
 	err = register_netdev(dev);
 	if (err)
 		goto out;

+	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
+	       dev->name, dev->base_addr, dev->irq, dev->dma);
+
 	return 0;
 out:
 	free_dma(dev->dma);
@@ -258,34 +258,11 @@ out2:
 out3:
 	tmsdev_term(dev);
 out4:
-	release_region(dev->base_addr, PROTEON_IO_EXTENT);
+	release_region(dev->base_addr, PROTEON_IO_EXTENT);
+out5:
 	return err;
 }

-struct net_device * __init proteon_probe(int unit)
-{
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
-	int err = 0;
-
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0) {
-		sprintf(dev->name, "tr%d", unit);
-		netdev_boot_setup_check(dev);
-	}
-
-	err = setup_card(dev);
-	if (err)
-		goto out;
-
-	return dev;
-
-out:
-	free_netdev(dev);
-	return ERR_PTR(err);
-}
-
 /*
  * Reads MAC address from adapter RAM, which should've read it from
  * the onboard ROM.
@@ -352,8 +329,6 @@ static int proteon_open(struct net_devic
 	return tms380tr_open(dev);
 }

-#ifdef MODULE
-
 #define ISATR_MAX_ADAPTERS 3

 static int io[ISATR_MAX_ADAPTERS];
@@ -366,13 +341,23 @@ module_param_array(io, int, NULL, 0);
 module_param_array(irq, int, NULL, 0);
 module_param_array(dma, int, NULL, 0);

-static struct net_device *proteon_dev[ISATR_MAX_ADAPTERS];
+static struct platform_device *proteon_dev[ISATR_MAX_ADAPTERS];
+
+static struct device_driver proteon_driver = {
+	.name		= "proteon",
+	.bus		= &platform_bus_type,
+};

-int init_module(void)
+static int __init proteon_init(void)
 {
 	struct net_device *dev;
+	struct platform_device *pdev;
 	int i, num = 0, err = 0;

+	err = driver_register(&proteon_driver);
+	if (err)
+		return err;
+
 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
 		dev = alloc_trdev(sizeof(struct net_local));
 		if (!dev)
@@ -381,11 +366,15 @@ int init_module(void)
 		dev->base_addr = io[i];
 		dev->irq = irq[i];
 		dev->dma = dma[i];
-		err = setup_card(dev);
+		pdev = platform_device_register_simple("proteon",
+			i, NULL, 0);
+		err = setup_card(dev, &pdev->dev);
 		if (!err) {
-			proteon_dev[i] = dev;
+			proteon_dev[i] = pdev;
+			dev_set_drvdata(&pdev->dev, dev);
 			++num;
 		} else {
+			platform_device_unregister(pdev);
 			free_netdev(dev);
 		}
 	}
@@ -399,23 +388,28 @@ int init_module(void)
 	return (0);
 }

-void cleanup_module(void)
+static void __exit proteon_cleanup(void)
 {
+	struct net_device *dev;
 	int i;

 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
-		struct net_device *dev = proteon_dev[i];
+		struct platform_device *pdev = proteon_dev[i];

-		if (!dev)
+		if (!pdev)
 			continue;
-
+		dev = dev_get_drvdata(&pdev->dev);
 		unregister_netdev(dev);
 		release_region(dev->base_addr, PROTEON_IO_EXTENT);
 		free_irq(dev->irq, dev);
 		free_dma(dev->dma);
 		tmsdev_term(dev);
 		free_netdev(dev);
+		dev_set_drvdata(&pdev->dev, NULL);
+		platform_device_unregister(pdev);
 	}
+	driver_unregister(&proteon_driver);
 }
-#endif /* MODULE */

+module_init(proteon_init);
+module_exit(proteon_cleanup);
diff --git a/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- a/drivers/net/tokenring/skisa.c
+++ b/drivers/net/tokenring/skisa.c
@@ -68,8 +68,7 @@ static int dmalist[] __initdata = {
 };

 static char isa_cardname[] = "SK NET TR 4/16 ISA\0";
-
-struct net_device *sk_isa_probe(int unit);
+static u64 dma_mask = ISA_MAX_ADDRESS;
 static int sk_isa_open(struct net_device *dev);
 static void sk_isa_read_eeprom(struct net_device *dev);
 static unsigned short sk_isa_setnselout_pins(struct net_device *dev);
@@ -133,7 +132,7 @@ static int __init sk_isa_probe1(struct n
 	return 0;
 }

-static int __init setup_card(struct net_device *dev)
+static int __init setup_card(struct net_device *dev, struct device *pdev)
 {
 	struct net_local *tp;
         static int versionprinted;
@@ -154,7 +153,7 @@ static int __init setup_card(struct net_
 		}
 	}
 	if (err)
-		goto out4;
+		goto out5;

 	/* At this point we have found a valid card. */

@@ -162,14 +161,15 @@ static int __init setup_card(struct net_
 		printk(KERN_DEBUG "%s", version);

 	err = -EIO;
-	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
+	pdev->dma_mask = &dma_mask;
+	if (tmsdev_init(dev, ISA_MAX_ADDRESS, pdev))
 		goto out4;

 	dev->base_addr &= ~3;

 	sk_isa_read_eeprom(dev);

-	printk(KERN_DEBUG "%s:    Ring Station Address: ", dev->name);
+	printk(KERN_DEBUG "skisa.c:    Ring Station Address: ");
 	printk("%2.2x", dev->dev_addr[0]);
 	for (j = 1; j < 6; j++)
 		printk(":%2.2x", dev->dev_addr[j]);
@@ -202,7 +202,7 @@ static int __init setup_card(struct net_

                 if(irqlist[j] == 0)
                 {
-                        printk(KERN_INFO "%s: AutoSelect no IRQ available\n", dev->name);
+                        printk(KERN_INFO "skisa.c: AutoSelect no IRQ available\n");
 			goto out3;
 		}
 	}
@@ -213,15 +213,15 @@ static int __init setup_card(struct net_
 				break;
 		if (irqlist[j] == 0)
 		{
-			printk(KERN_INFO "%s: Illegal IRQ %d specified\n",
-				dev->name, dev->irq);
+			printk(KERN_INFO "skisa.c: Illegal IRQ %d specified\n",
+				dev->irq);
 			goto out3;
 		}
 		if (request_irq(dev->irq, tms380tr_interrupt, 0,
 			isa_cardname, dev))
 		{
-                        printk(KERN_INFO "%s: Selected IRQ %d not available\n",
-				dev->name, dev->irq);
+                        printk(KERN_INFO "skisa.c: Selected IRQ %d not available\n",
+				dev->irq);
 			goto out3;
 		}
 	}
@@ -237,7 +237,7 @@ static int __init setup_card(struct net_

 		if(dmalist[j] == 0)
 		{
-			printk(KERN_INFO "%s: AutoSelect no DMA available\n", dev->name);
+			printk(KERN_INFO "skisa.c: AutoSelect no DMA available\n");
 			goto out2;
 		}
 	}
@@ -248,25 +248,25 @@ static int __init setup_card(struct net_
 				break;
 		if (dmalist[j] == 0)
 		{
-                        printk(KERN_INFO "%s: Illegal DMA %d specified\n",
-				dev->name, dev->dma);
+                        printk(KERN_INFO "skisa.c: Illegal DMA %d specified\n",
+				dev->dma);
 			goto out2;
 		}
 		if (request_dma(dev->dma, isa_cardname))
 		{
-                        printk(KERN_INFO "%s: Selected DMA %d not available\n",
-				dev->name, dev->dma);
+                        printk(KERN_INFO "skisa.c: Selected DMA %d not available\n",
+				dev->dma);
 			goto out2;
 		}
 	}

-	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
-	       dev->name, dev->base_addr, dev->irq, dev->dma);
-
 	err = register_netdev(dev);
 	if (err)
 		goto out;

+	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
+	       dev->name, dev->base_addr, dev->irq, dev->dma);
+
 	return 0;
 out:
 	free_dma(dev->dma);
@@ -275,33 +275,11 @@ out2:
 out3:
 	tmsdev_term(dev);
 out4:
-	release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+	release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+out5:
 	return err;
 }

-struct net_device * __init sk_isa_probe(int unit)
-{
-	struct net_device *dev = alloc_trdev(sizeof(struct net_local));
-	int err = 0;
-
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0) {
-		sprintf(dev->name, "tr%d", unit);
-		netdev_boot_setup_check(dev);
-	}
-
-	err = setup_card(dev);
-	if (err)
-		goto out;
-
-	return dev;
-out:
-	free_netdev(dev);
-	return ERR_PTR(err);
-}
-
 /*
  * Reads MAC address from adapter RAM, which should've read it from
  * the onboard ROM.
@@ -361,8 +339,6 @@ static int sk_isa_open(struct net_device
 	return tms380tr_open(dev);
 }

-#ifdef MODULE
-
 #define ISATR_MAX_ADAPTERS 3

 static int io[ISATR_MAX_ADAPTERS];
@@ -375,13 +351,23 @@ module_param_array(io, int, NULL, 0);
 module_param_array(irq, int, NULL, 0);
 module_param_array(dma, int, NULL, 0);

-static struct net_device *sk_isa_dev[ISATR_MAX_ADAPTERS];
+static struct platform_device *sk_isa_dev[ISATR_MAX_ADAPTERS];

-int init_module(void)
+static struct device_driver sk_isa_driver = {
+	.name		= "skisa",
+	.bus		= &platform_bus_type,
+};
+
+static int __init sk_isa_init(void)
 {
 	struct net_device *dev;
+	struct platform_device *pdev;
 	int i, num = 0, err = 0;

+	err = driver_register(&sk_isa_driver);
+	if (err)
+		return err;
+
 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
 		dev = alloc_trdev(sizeof(struct net_local));
 		if (!dev)
@@ -390,12 +376,15 @@ int init_module(void)
 		dev->base_addr = io[i];
 		dev->irq = irq[i];
 		dev->dma = dma[i];
-		err = setup_card(dev);
-
+		pdev = platform_device_register_simple("skisa",
+			i, NULL, 0);
+		err = setup_card(dev, &pdev->dev);
 		if (!err) {
-			sk_isa_dev[i] = dev;
+			sk_isa_dev[i] = pdev;
+			dev_set_drvdata(&sk_isa_dev[i]->dev, dev);
 			++num;
 		} else {
+			platform_device_unregister(pdev);
 			free_netdev(dev);
 		}
 	}
@@ -409,23 +398,28 @@ int init_module(void)
 	return (0);
 }

-void cleanup_module(void)
+static void __exit sk_isa_cleanup(void)
 {
+	struct net_device *dev;
 	int i;

 	for (i = 0; i < ISATR_MAX_ADAPTERS ; i++) {
-		struct net_device *dev = sk_isa_dev[i];
+		struct platform_device *pdev = sk_isa_dev[i];

-		if (!dev)
+		if (!pdev)
 			continue;
-
+		dev = dev_get_drvdata(&pdev->dev);
 		unregister_netdev(dev);
 		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
 		free_irq(dev->irq, dev);
 		free_dma(dev->dma);
 		tmsdev_term(dev);
 		free_netdev(dev);
+		dev_set_drvdata(&pdev->dev, NULL);
+		platform_device_unregister(pdev);
 	}
+	driver_unregister(&sk_isa_driver);
 }
-#endif /* MODULE */

+module_init(sk_isa_init);
+module_exit(sk_isa_cleanup);
diff --git a/drivers/net/tokenring/tms380tr.c b/drivers/net/tokenring/tms380tr.c
--- a/drivers/net/tokenring/tms380tr.c
+++ b/drivers/net/tokenring/tms380tr.c
@@ -62,6 +62,7 @@
  *				normal operation.
  *	30-Dec-02	JF	Removed incorrect __init from
  *				tms380tr_init_card.
+ *	22-Jul-05	JF	Converted to dma-mapping.
  *
  *  To do:
  *    1. Multi/Broadcast packet handling (this may have fixed itself)
@@ -89,7 +90,7 @@ static const char version[] = "tms380tr.
 #include <linux/time.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -114,8 +115,6 @@ static const char version[] = "tms380tr.
 #endif
 static unsigned int tms380tr_debug = TMS380TR_DEBUG;

-static struct device tms_device;
-
 /* Index to functions, as function prototypes.
  * Alphabetical by function name.
  */
@@ -434,7 +433,7 @@ static void tms380tr_init_net_local(stru
 			skb_put(tp->Rpl[i].Skb, tp->MaxPacketSize);

 			/* data unreachable for DMA ? then use local buffer */
-			dmabuf = pci_map_single(tp->pdev, tp->Rpl[i].Skb->data, tp->MaxPacketSize, PCI_DMA_FROMDEVICE);
+			dmabuf = dma_map_single(tp->pdev, tp->Rpl[i].Skb->data, tp->MaxPacketSize, DMA_FROM_DEVICE);
 			if(tp->dmalimit && (dmabuf + tp->MaxPacketSize > tp->dmalimit))
 			{
 				tp->Rpl[i].SkbStat = SKB_DATA_COPY;
@@ -638,10 +637,10 @@ static int tms380tr_hardware_send_packet
 	/* Is buffer reachable for Busmaster-DMA? */

 	length	= skb->len;
-	dmabuf = pci_map_single(tp->pdev, skb->data, length, PCI_DMA_TODEVICE);
+	dmabuf = dma_map_single(tp->pdev, skb->data, length, DMA_TO_DEVICE);
 	if(tp->dmalimit && (dmabuf + length > tp->dmalimit)) {
 		/* Copy frame to local buffer */
-		pci_unmap_single(tp->pdev, dmabuf, length, PCI_DMA_TODEVICE);
+		dma_unmap_single(tp->pdev, dmabuf, length, DMA_TO_DEVICE);
 		dmabuf  = 0;
 		i 	= tp->TplFree->TPLIndex;
 		buf 	= tp->LocalTxBuffers[i];
@@ -1284,9 +1283,7 @@ static int tms380tr_reset_adapter(struct
 	unsigned short count, c, count2;
 	const struct firmware *fw_entry = NULL;

-	strncpy(tms_device.bus_id,dev->name, BUS_ID_SIZE);
-
-	if (request_firmware(&fw_entry, "tms380tr.bin", &tms_device) != 0) {
+	if (request_firmware(&fw_entry, "tms380tr.bin", tp->pdev) != 0) {
 		printk(KERN_ALERT "%s: firmware %s is missing, cannot start.\n",
 			dev->name, "tms380tr.bin");
 		return (-1);
@@ -2021,7 +2018,7 @@ static void tms380tr_cancel_tx_queue(str

 		printk(KERN_INFO "Cancel tx (%08lXh).\n", (unsigned long)tpl);
 		if (tpl->DMABuff)
-			pci_unmap_single(tp->pdev, tpl->DMABuff, tpl->Skb->len, PCI_DMA_TODEVICE);
+			dma_unmap_single(tp->pdev, tpl->DMABuff, tpl->Skb->len, DMA_TO_DEVICE);
 		dev_kfree_skb_any(tpl->Skb);
 	}

@@ -2090,7 +2087,7 @@ static void tms380tr_tx_status_irq(struc

 		tp->MacStat.tx_packets++;
 		if (tpl->DMABuff)
-			pci_unmap_single(tp->pdev, tpl->DMABuff, tpl->Skb->len, PCI_DMA_TODEVICE);
+			dma_unmap_single(tp->pdev, tpl->DMABuff, tpl->Skb->len, DMA_TO_DEVICE);
 		dev_kfree_skb_irq(tpl->Skb);
 		tpl->BusyFlag = 0;	/* "free" TPL */
 	}
@@ -2209,7 +2206,7 @@ static void tms380tr_rcv_status_irq(stru
 				tp->MacStat.rx_errors++;
 		}
 		if (rpl->DMABuff)
-			pci_unmap_single(tp->pdev, rpl->DMABuff, tp->MaxPacketSize, PCI_DMA_TODEVICE);
+			dma_unmap_single(tp->pdev, rpl->DMABuff, tp->MaxPacketSize, DMA_TO_DEVICE);
 		rpl->DMABuff = 0;

 		/* Allocate new skb for rpl */
@@ -2227,7 +2224,7 @@ static void tms380tr_rcv_status_irq(stru
 			skb_put(rpl->Skb, tp->MaxPacketSize);

 			/* Data unreachable for DMA ? then use local buffer */
-			dmabuf = pci_map_single(tp->pdev, rpl->Skb->data, tp->MaxPacketSize, PCI_DMA_FROMDEVICE);
+			dmabuf = dma_map_single(tp->pdev, rpl->Skb->data, tp->MaxPacketSize, DMA_FROM_DEVICE);
 			if(tp->dmalimit && (dmabuf + tp->MaxPacketSize > tp->dmalimit))
 			{
 				rpl->SkbStat = SKB_DATA_COPY;
@@ -2332,12 +2329,12 @@ void tmsdev_term(struct net_device *dev)
 	struct net_local *tp;

 	tp = netdev_priv(dev);
-	pci_unmap_single(tp->pdev, tp->dmabuffer, sizeof(struct net_local),
-		PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_single(tp->pdev, tp->dmabuffer, sizeof(struct net_local),
+		DMA_BIDIRECTIONAL);
 }

 int tmsdev_init(struct net_device *dev, unsigned long dmalimit,
-		struct pci_dev *pdev)
+		struct device *pdev)
 {
 	struct net_local *tms_local;

@@ -2346,8 +2343,8 @@ int tmsdev_init(struct net_device *dev,
 	init_waitqueue_head(&tms_local->wait_for_tok_int);
 	tms_local->dmalimit = dmalimit;
 	tms_local->pdev = pdev;
-	tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
-	    sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
+	tms_local->dmabuffer = dma_map_single(pdev, (void *)tms_local,
+	    sizeof(struct net_local), DMA_BIDIRECTIONAL);
 	if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
 	{
 		printk(KERN_INFO "%s: Memory not accessible for DMA\n",
@@ -2370,8 +2367,6 @@ int tmsdev_init(struct net_device *dev,
 	return 0;
 }

-#ifdef MODULE
-
 EXPORT_SYMBOL(tms380tr_open);
 EXPORT_SYMBOL(tms380tr_close);
 EXPORT_SYMBOL(tms380tr_interrupt);
@@ -2379,6 +2374,8 @@ EXPORT_SYMBOL(tmsdev_init);
 EXPORT_SYMBOL(tmsdev_term);
 EXPORT_SYMBOL(tms380tr_wait);

+#ifdef MODULE
+
 static struct module *TMS380_module = NULL;

 int init_module(void)
diff --git a/drivers/net/tokenring/tms380tr.h b/drivers/net/tokenring/tms380tr.h
--- a/drivers/net/tokenring/tms380tr.h
+++ b/drivers/net/tokenring/tms380tr.h
@@ -18,7 +18,7 @@ int tms380tr_open(struct net_device *dev
 int tms380tr_close(struct net_device *dev);
 irqreturn_t tms380tr_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 int tmsdev_init(struct net_device *dev, unsigned long dmalimit,
-		struct pci_dev *pdev);
+		struct device *pdev);
 void tmsdev_term(struct net_device *dev);
 void tms380tr_wait(unsigned long time);

@@ -719,7 +719,7 @@ struct s_TPL {	/* Transmit Parameter Lis
 	struct sk_buff *Skb;
 	unsigned char TPLIndex;
 	volatile unsigned char BusyFlag;/* Flag: TPL busy? */
-	dma_addr_t DMABuff;		/* DMA IO bus address from pci_map */
+	dma_addr_t DMABuff;		/* DMA IO bus address from dma_map */
 };

 /* ---------------------Receive Functions-------------------------------*
@@ -1060,7 +1060,7 @@ struct s_RPL {	/* Receive Parameter List
 	struct sk_buff *Skb;
 	SKB_STAT SkbStat;
 	int RPLIndex;
-	dma_addr_t DMABuff;		/* DMA IO bus address from pci_map */
+	dma_addr_t DMABuff;		/* DMA IO bus address from dma_map */
 };

 /* Information that need to be kept for each board. */
@@ -1091,7 +1091,7 @@ typedef struct net_local {
 	RPL *RplTail;
 	unsigned char LocalRxBuffers[RPL_NUM][DEFAULT_PACKET_SIZE];

-	struct pci_dev *pdev;
+	struct device *pdev;
 	int DataRate;
 	unsigned char ScbInUse;
 	unsigned short CMDqueue;
diff --git a/drivers/net/tokenring/tmspci.c b/drivers/net/tokenring/tmspci.c
--- a/drivers/net/tokenring/tmspci.c
+++ b/drivers/net/tokenring/tmspci.c
@@ -100,7 +100,7 @@ static int __devinit tms_pci_attach(stru
 	unsigned int pci_irq_line;
 	unsigned long pci_ioaddr;
 	struct card_info *cardinfo = &card_info_table[ent->driver_data];
-
+
 	if (versionprinted++ == 0)
 		printk("%s", version);

@@ -143,7 +143,7 @@ static int __devinit tms_pci_attach(stru
 		printk(":%2.2x", dev->dev_addr[i]);
 	printk("\n");

-	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, pdev);
+	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, &pdev->dev);
 	if (ret) {
 		printk("%s: unable to get memory for dev->priv.\n", dev->name);
 		goto err_out_irq;
-- 
Bug, n.:
An aspect of a computer program which exists because the
programmer was thinking about girls or stock options when he
wrote the program.

