Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTDDFDu (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDDFDk (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:03:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:23429 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263357AbTDDE5h (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:57:37 -0500
Date: Fri, 4 Apr 2003 00:12:47 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404001247.GJ11574@neo.rr.com>
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

diff -Nru a/sound/isa/dt019x.c b/sound/isa/dt019x.c
--- a/sound/isa/dt019x.c	Thu Apr  3 23:40:39 2003
+++ b/sound/isa/dt019x.c	Thu Apr  3 23:40:39 2003
@@ -25,11 +25,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
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
@@ -87,159 +83,124 @@
 MODULE_PARM_SYNTAX(dma8, SNDRV_DMA8_DESC);
 
 struct snd_card_dt019x {
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
-	struct isapnp_dev *devmpu;
-	struct isapnp_dev *devopl;
-#endif	/* __ISAPNP__ */
+	struct pnp_dev *dev;
+	struct pnp_dev *devmpu;
+	struct pnp_dev *devopl;
 };
 
-static snd_card_t *snd_dt019x_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-static struct isapnp_card *snd_dt019x_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_dt019x_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-static struct isapnp_card_id snd_dt019x_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_dt019x_pnpids[] __devinitdata = {
 	/* DT197A30 */
-	{
-		ISAPNP_CARD_ID('R','W','B',0x1688),
-		.devs = { ISAPNP_DEVICE_ID('@','@','@',0x0001),
-			ISAPNP_DEVICE_ID('@','X','@',0x0001),
-			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
-	},
+	{ .id = "RWB1688", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
 	/* DT0196 / ALS-007 */
-	{
-		ISAPNP_CARD_ID('A','L','S',0x0007),
-		.devs = { ISAPNP_DEVICE_ID('@','@','@',0x0001),
-			ISAPNP_DEVICE_ID('@','X','@',0x0001),
-			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
-	},
-	{ ISAPNP_CARD_END, }
+	{ .id = "ALS0007", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
+	{ .id = "",  }
 };
 
-ISAPNP_CARD_TABLE(snd_dt019x_pnpids);
+MODULE_DEVICE_TABLE(pnp_card, snd_dt019x_pnpids);
 
-#endif	/* __ISAPNP__ */
 
 #define DRIVER_NAME	"snd-card-dt019x"
 
 
-#ifdef __ISAPNP__
-static int __init snd_card_dt019x_isapnp(int dev, struct snd_card_dt019x *acard)
+static int __init snd_card_dt019x_isapnp(int dev, struct snd_card_dt019x *acard,
+							   struct pnp_card_link *card,
+							   const struct pnp_card_device_id *pid)
 {
-	const struct isapnp_card_id *id = snd_dt019x_isapnp_id[dev];
-	struct isapnp_card *card = snd_dt019x_isapnp_cards[dev];
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
-	}
-	acard->devopl = isapnp_find_dev(card, id->devs[2].vendor, id->devs[2].function, NULL);
-	if (acard->devopl->active) {
-		acard->dev = acard->devmpu = acard->devopl = NULL;
-		return -EBUSY;
+	struct pnp_dev *pdev;
+	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
+	int err;
+
+	if (!cfg)
+		return -ENOMEM;
+
+	acard->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
+	if (acard->dev == NULL) {
+		kfree (cfg);
+		return -ENODEV;
 	}
+	acard->devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
+	acard->devopl = pnp_request_card_device(card, pid->devs[2].id, NULL);
 
 	pdev = acard->dev;
-	if (!pdev || pdev->prepare(pdev)<0)
-		return -EAGAIN;
+	pnp_init_resource_table(cfg);
 
 	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
 	if (dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev],
+		pnp_resource_change(&cfg->dma_resource[0], dma8[dev],
 			1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
 
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "DT-019X AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-	port[dev] = pdev->resource[0].start;
-	dma8[dev] = pdev->dma_resource[0].start;
-	irq[dev] = pdev->irq_resource[0].start;
+	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+		printk(KERN_ERR PFX "DT-019X AUDIO the requested resources are invalid, using auto config\n");
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		printk(KERN_ERR PFX "DT-019X AUDIO pnp configure failure\n");
+		kfree(cfg);
+		return err;
+	}
+
+	port[dev] = pnp_port_start(pdev, 0);
+	dma8[dev] = pnp_dma(pdev, 0);
+	irq[dev] = pnp_irq(pdev, 0);
 	snd_printdd("dt019x: found audio interface: port=0x%lx, irq=0x%lx, dma=0x%lx\n",
 			port[dev],irq[dev],dma8[dev]);
 
 	pdev = acard->devmpu;
-	if (!pdev || pdev->prepare(pdev)<0) 
-		return 0;
-
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], mpu_port[dev],
-			2);
-	if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], mpu_irq[dev],
-			1);
 
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "DT-019X MPU-401 isapnp configure failure\n");
-		mpu_port[dev] = -1;
-		acard->devmpu = NULL;
-	} else {
-		mpu_port[dev] = pdev->resource[0].start;
-		mpu_irq[dev] = pdev->irq_resource[0].start;
+	if (pdev != NULL) {
+		pnp_init_resource_table(cfg);
+		if (mpu_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg->port_resource[0], mpu_port[dev], 2);
+		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
+			pnp_resource_change(&cfg->irq_resource[0], mpu_irq[dev], 1);
+			if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "DT-019X MPU401 the requested resources are invalid, using auto config\n");
+			err = pnp_activate_dev(pdev);
+			if (err < 0)
+				goto __mpu_error;
+		mpu_port[dev] = pnp_port_start(pdev, 0);
+		mpu_irq[dev] = pnp_irq(pdev, 0);
 		snd_printdd("dt019x: found MPU-401: port=0x%lx, irq=0x%lx\n",
 			 	mpu_port[dev],mpu_irq[dev]);
+	} else {
+		__mpu_error:
+		if (pdev) {
+			pnp_release_card_device(pdev);
+			printk(KERN_ERR PFX "DT-019X MPU401 pnp configure failure, skipping\n");
+		}
+		acard->devmpu = NULL;
+		mpu_port[dev] = -1;
 	}
 
 	pdev = acard->devopl;
-	if (!pdev || pdev->prepare(pdev)<0)
-		return 0;
-
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], fm_port[dev], 4);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "DT-019X OPL3 isapnp configure failure\n");
-		fm_port[dev] = -1;
-		acard->devopl = NULL;
-	} else {
-		fm_port[dev] = pdev->resource[0].start;
+	if (pdev != NULL) {
+		pnp_init_resource_table(cfg);
+		if (fm_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg->port_resource[0], fm_port[dev], 4);
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "DT-019X OPL3 the requested resources are invalid, using auto config\n");
+		err = pnp_activate_dev(pdev);
+		if (err < 0)
+			goto __fm_error;
+		fm_port[dev] = pnp_port_start(pdev, 0);
 		snd_printdd("dt019x: found OPL3 synth: port=0x%lx\n",fm_port[dev]);
-	}
-
-	return 0;
-}
-
-static void snd_card_dt019x_deactivate(struct snd_card_dt019x *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev = NULL;
-	}
-	if (acard->devmpu) {
-		acard->devmpu->deactivate(acard->devmpu);
-		acard->devmpu = NULL;
-	}
-	if (acard->devopl) {
-		acard->devopl->deactivate(acard->devopl);
+	} else {
+		__fm_error:
+		if (pdev) {
+			pnp_release_card_device(pdev);
+			printk(KERN_ERR PFX "DT-019X OPL3 pnp configure failure, skipping\n");
+		}
 		acard->devopl = NULL;
+		fm_port[dev] = -1;
 	}
-}
-#endif	/* __ISAPNP__ */
 
-static void snd_card_dt019x_free(snd_card_t *card)
-{
-	struct snd_card_dt019x *acard = (struct snd_card_dt019x *)card->private_data;
-
-	if (acard != NULL) {
-#ifdef __ISAPNP__
-		snd_card_dt019x_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
+	kfree(cfg);
+	return 0;
 }
 
-static int __init snd_card_dt019x_probe(int dev)
+static int __init snd_card_dt019x_probe(int dev, struct pnp_card_link *pcard, const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -251,18 +212,11 @@
 				 sizeof(struct snd_card_dt019x))) == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_dt019x *)card->private_data;
-	card->private_free = snd_card_dt019x_free;
 
-#ifdef __ISAPNP__
-	if ((error = snd_card_dt019x_isapnp(dev, acard))) {
+	if ((error = snd_card_dt019x_isapnp(dev, acard, pcard, pid))) {
 		snd_card_free(card);
 		return error;
 	}
-#else
-	printk(KERN_ERR PFX "you have to enable PnP support ...\n");
-	snd_card_free(card);
-	return -ENOSYS;
-#endif	/* __ISAPNP__ */
 
 	if ((error = snd_sbdsp_create(card, port[dev],
 				      irq[dev],
@@ -324,13 +278,12 @@
 		snd_card_free(card);
 		return error;
 	}
-	snd_dt019x_cards[dev] = card;
+	pnp_set_card_drvdata(pcard, card);
 	return 0;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_dt019x_isapnp_detect(struct isapnp_card *card,
-					    const struct isapnp_card_id *id)
+static int __init snd_dt019x_pnp_probe(struct pnp_card_link *card,
+					    const struct pnp_card_device_id *pid)
 {
 	static int dev;
 	int res;
@@ -338,9 +291,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-		snd_dt019x_isapnp_cards[dev] = card;
-		snd_dt019x_isapnp_id[dev] = id;
-		res = snd_card_dt019x_probe(dev);
+		res = snd_card_dt019x_probe(dev, card, pid);
 		if (res < 0)
 			return res;
 		dev++;
@@ -348,17 +299,28 @@
         }
         return -ENODEV;
 }
-#endif /* __ISAPNP__ */
+
+static void __devexit snd_dt019x_pnp_remove(struct pnp_card_link * pcard)
+{
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
+}
+
+static struct pnp_card_driver dt019x_pnpc_driver = {
+	.flags          = PNP_DRIVER_RES_DISABLE,
+	.name           = "dt019x",
+	.id_table       = snd_dt019x_pnpids,
+	.probe          = snd_dt019x_pnp_probe,
+	.remove         = __devexit_p(snd_dt019x_pnp_remove),
+};
 
 static int __init alsa_card_dt019x_init(void)
 {
 	int cards = 0;
 
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_dt019x_pnpids, snd_dt019x_isapnp_detect);
-#else
-	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
-#endif
+	cards += pnp_register_card_driver(&dt019x_pnpc_driver);
+
 #ifdef MODULE
 	if (!cards)
 		printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
@@ -368,10 +330,7 @@
 
 static void __exit alsa_card_dt019x_exit(void)
 {
-	int dev;
-
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_dt019x_cards[dev]);
+	pnp_unregister_card_driver(&dt019x_pnpc_driver);
 }
 
 module_init(alsa_card_dt019x_init)
