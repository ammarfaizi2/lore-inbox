Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTDDFFj (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTDDFFU (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:05:20 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:22661 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263269AbTDDE5I (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:57:08 -0500
Date: Fri, 4 Apr 2003 00:12:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404001220.GI11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/sound/isa/azt2320.c b/sound/isa/azt2320.c
--- a/sound/isa/azt2320.c	Thu Apr  3 23:40:45 2003
+++ b/sound/isa/azt2320.c	Thu Apr  3 23:40:45 2003
@@ -36,11 +36,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/wait.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
@@ -109,134 +105,112 @@
 MODULE_PARM_SYNTAX(dma2, SNDRV_DMA_DESC);
 
 struct snd_card_azt2320 {
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
-	struct isapnp_dev *devmpu;
-#endif	/* __ISAPNP__ */
+#ifdef CONFIG_PNP
+	int dev_no;
+	struct pnp_dev *dev;
+	struct pnp_dev *devmpu;
+#endif	/* CONFIG_PNP */
 };
 
-static snd_card_t *snd_azt2320_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-
-static struct isapnp_card *snd_azt2320_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_azt2320_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-#define ISAPNP_AZT2320(_va, _vb, _vc, _device, _audio, _mpu401) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-			  ISAPNP_DEVICE_ID(_va, _vb, _vc, _mpu401), } \
-	}
-
-static struct isapnp_card_id snd_azt2320_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_azt2320_pnpids[] __devinitdata = {
 	/* PRO16V */
-	ISAPNP_AZT2320('A','Z','T',0x1008,0x1008,0x2001),
+	{ .id = "AZT1008", .devs = { { "AZT1008" }, { "AZT2001" }, } },
 	/* Aztech Sound Galaxy 16 */
-	ISAPNP_AZT2320('A','Z','T',0x2320,0x0001,0x0002),
+	{ .id = "AZT2320", .devs = { { "AZT0001" }, { "AZT0002" }, } },
 	/* Packard Bell Sound III 336 AM/SP */
-	ISAPNP_AZT2320('A','Z','T',0x3000,0x1003,0x2001),
+	{ .id = "AZT3000", .devs = { { "AZT1003" }, { "AZT2001" }, } },
 	/* AT3300 */
-	ISAPNP_AZT2320('A','Z','T',0x3002,0x1004,0x2001),
+	{ .id = "AZT3002", .devs = { { "AZT1004" }, { "AZT2001" }, } },
 	/* --- */
-	ISAPNP_AZT2320('A','Z','T',0x3005,0x1003,0x2001),
+	{ .id = "AZT3005", .devs = { { "AZT1003" }, { "AZT2001" }, } },
 	/* --- */
-	ISAPNP_AZT2320('A','Z','T',0x3011,0x1003,0x2001),
-	{ ISAPNP_CARD_END, }	/* end */
+	{ .id = "AZT3011", .devs = { { "AZT1003" }, { "AZT2001" }, } },
+	{ .id = "" }	/* end */
 };
 
-ISAPNP_CARD_TABLE(snd_azt2320_pnpids);
-
-#endif	/* __ISAPNP__ */
+MODULE_DEVICE_TABLE(pnp_card, snd_azt2320_pnpids);
 
 #define	DRIVER_NAME	"snd-card-azt2320"
 
-
-#ifdef __ISAPNP__
-static int __init snd_card_azt2320_isapnp(int dev, struct snd_card_azt2320 *acard)
+static int __init snd_card_azt2320_isapnp(int dev, struct snd_card_azt2320 *acard,
+							     struct pnp_card_link *card,
+							     const struct pnp_card_device_id *id)
 {
-	const struct isapnp_card_id *id = snd_azt2320_isapnp_id[dev];
-	struct isapnp_card *card = snd_azt2320_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (acard->dev->active) {
-		acard->dev = NULL;
-		return -EBUSY;
-	}
-	acard->devmpu = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, NULL);
-	if (acard->devmpu->active) {
-		acard->dev = acard->devmpu = NULL;
-		return -EBUSY;
+	struct pnp_dev *pdev;
+	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
+	int err;
+
+	if (!cfg)
+		return -ENOMEM;
+
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (acard->dev == NULL) {
+		kfree(cfg);
+		return -ENODEV;
 	}
 
+	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, NULL);
+
 	pdev = acard->dev;
-	if (pdev->prepare(pdev) < 0)
-		return -EAGAIN;
+	pnp_init_resource_table(cfg);
 
+	/* override resources */
 	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
 	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[1], fm_port[dev], 4);
+		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
 	if (wss_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[2], wss_port[dev],
-			4);
+		pnp_resource_change(&cfg->port_resource[2], wss_port[dev], 4);
 	if (dma1[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma1[dev],
-			1);
+		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
 	if (dma2[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma2[dev],
-			1);
+		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-
-	if (pdev->activate(pdev) < 0) {
-		printk(KERN_ERR PFX "AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-
-	port[dev] = pdev->resource[0].start;
-	fm_port[dev] = pdev->resource[1].start;
-	wss_port[dev] = pdev->resource[2].start;
-	dma1[dev] = pdev->dma_resource[0].start;
-	dma2[dev] = pdev->dma_resource[1].start;
-	irq[dev] = pdev->irq_resource[0].start;
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
+	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+		printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
+
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		kfree(cfg);
+		return err;
+	}
+	port[dev] = pnp_port_start(pdev, 0);
+	fm_port[dev] = pnp_port_start(pdev, 1);
+	wss_port[dev] = pnp_port_start(pdev, 2);
+	dma1[dev] = pnp_dma(pdev, 0);
+	dma2[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
 
 	pdev = acard->devmpu;
-	if (pdev == NULL || pdev->prepare(pdev) < 0) {
-		mpu_port[dev] = -1;
-		return 0;
-	}
-
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], mpu_port[dev],
-			2);
-	if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], mpu_irq[dev],
-			1);
-
-	if (pdev->activate(pdev) < 0) {
-		/* not fatal error */
-		printk(KERN_ERR PFX "MPU-401 isapnp configure failure\n");
-		mpu_port[dev] = -1;
-		acard->devmpu = NULL;
+	if (pdev != NULL) {
+		pnp_init_resource_table(cfg);
+		if (mpu_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
+		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
+			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "MPU401 the requested resources are invalid, using auto config\n");
+		err = pnp_activate_dev(pdev);
+		if (err < 0)
+			goto __mpu_error;
+		mpu_port[dev] = pnp_port_start(pdev, 0);
+		mpu_irq[dev] = pnp_irq(pdev, 0);
 	} else {
-		mpu_port[dev] = pdev->resource[0].start;
-		mpu_irq[dev] = pdev->irq_resource[0].start;
+	     __mpu_error:
+	     	if (pdev) {
+		     	pnp_release_card_device(pdev);
+	     		printk(KERN_ERR PFX "MPU401 pnp configure failure, skipping\n");
+	     	}
+	     	acard->devmpu = NULL;
+	     	mpu_port[dev] = -1;
 	}
 
+	kfree (cfg);
 	return 0;
 }
 
-static void snd_card_azt2320_deactivate(struct snd_card_azt2320 *acard)
-{
-	if (acard->dev)
-		acard->dev->deactivate(acard->dev);
-	if (acard->devmpu)
-		acard->devmpu->deactivate(acard->devmpu);
-}
-#endif	/* __ISAPNP__ */
-
 /* same of snd_sbdsp_command by Jaroslav Kysela */
 static int __init snd_card_azt2320_command(unsigned long port, unsigned char val)
 {
@@ -265,18 +239,9 @@
 	return 0;
 }
 
-static void snd_card_azt2320_free(snd_card_t *card)
-{
-	struct snd_card_azt2320 *acard = (struct snd_card_azt2320 *)card->private_data;
-
-	if (acard) {
-#ifdef __ISAPNP__
-		snd_card_azt2320_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
-}
-
-static int __init snd_card_azt2320_probe(int dev)
+static int __init snd_card_azt2320_probe(int dev,
+							   struct pnp_card_link *pcard,
+							   const struct pnp_card_device_id *pid)
 {
 	int error;
 	snd_card_t *card;
@@ -288,14 +253,11 @@
 				 sizeof(struct snd_card_azt2320))) == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_azt2320 *)card->private_data;
-	card->private_free = snd_card_azt2320_free;
 
-#ifdef __ISAPNP__
-	if ((error = snd_card_azt2320_isapnp(dev, acard))) {
+	if ((error = snd_card_azt2320_isapnp(dev, acard, pcard, pid))) {
 		snd_card_free(card);
 		return error;
 	}
-#endif	/* __ISAPNP__ */
 
 	if ((error = snd_card_azt2320_enable_wss(port[dev]))) {
 		snd_card_free(card);
@@ -360,13 +322,12 @@
 		snd_card_free(card);
 		return error;
 	}
-	snd_azt2320_cards[dev] = card;
+	pnp_set_card_drvdata(pcard, card);
 	return 0;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_azt2320_isapnp_detect(struct isapnp_card *card,
-                                            const struct isapnp_card_id *id)
+static int __init snd_azt2320_pnp_detect(struct pnp_card_link *card,
+                                            const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
@@ -374,9 +335,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-		snd_azt2320_isapnp_cards[dev] = card;
-		snd_azt2320_isapnp_id[dev] = id;
-                res = snd_card_azt2320_probe(dev);
+		res = snd_card_azt2320_probe(dev,card,id);
 		if (res < 0)
 			return res;
 		dev++;
@@ -384,7 +343,22 @@
 	}
         return -ENODEV;
 }
-#endif
+
+static void __devexit snd_azt2320_pnp_remove(struct pnp_card_link * pcard)
+{
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
+
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
+}
+
+static struct pnp_card_driver azt2320_pnpc_driver = {
+	.flags          = PNP_DRIVER_RES_DISABLE,
+	.name           = "azt2320",
+	.id_table       = snd_azt2320_pnpids,
+	.probe          = snd_azt2320_pnp_detect,
+	.remove         = __devexit_p(snd_azt2320_pnp_remove),
+};
 
 static int __init alsa_card_azt2320_init(void)
 {
@@ -395,6 +369,7 @@
 #else
 	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
 #endif
+	cards += pnp_register_card_driver(&azt2320_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
 		printk(KERN_ERR "no AZT2320 based soundcards found\n");
@@ -404,10 +379,7 @@
 
 static void __exit alsa_card_azt2320_exit(void)
 {
-	int dev;
-
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_azt2320_cards[dev]);
+	pnp_unregister_card_driver(&azt2320_pnpc_driver);
 }
 
 module_init(alsa_card_azt2320_init)
