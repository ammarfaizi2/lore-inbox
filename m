Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbTCWOlj>; Sun, 23 Mar 2003 09:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbTCWOlj>; Sun, 23 Mar 2003 09:41:39 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:33855 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S263078AbTCWOlb>; Sun, 23 Mar 2003 09:41:31 -0500
Date: Sun, 23 Mar 2003 09:51:07 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.65-bk3] pnp api changes to sound/isa/dt019x.c
Message-ID: <Pine.LNX.4.53.0303230941130.10913@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch is to make DT019x driver to work with PNP API.

John Kim


diff -Nau linux-2.5.65-bk3/sound/isa/dt019x.c 
linux-2.5.65-bk3-new/sound/isa/dt019x.c
--- linux-2.5.65-bk3/sound/isa/dt019x.c	2003-03-22 08:21:28.000000000 -0500
+++ linux-2.5.65-bk3-new/sound/isa/dt019x.c	2003-03-23 09:30:43.000000000 -0500
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
@@ -87,159 +83,117 @@
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
+static struct pnp_card_id snd_dt019x_pnpids[] __devinitdata = {
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
-};
-
-ISAPNP_CARD_TABLE(snd_dt019x_pnpids);
+	{ .id = "ALS0007", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
+	{ .id = "", } /* end */
+}
 
-#endif	/* __ISAPNP__ */
+MODULE_DEVICE_TABLE(pnp_card, snd_dt019x_pnpids);
 
 #define DRIVER_NAME	"snd-card-dt019x"
 
-
-#ifdef __ISAPNP__
-static int __init snd_card_dt019x_isapnp(int dev, struct snd_card_dt019x *acard)
+static int __init snd_card_dt019x_pnp(int dev, struct snd_card_dt019x *acard,
+					struct pnp_card_link *card,
+					const struct pnp_card_id *id)
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
+	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	int err;
+	if (!cfg)
+		return -ENOMEM;
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (acard->dev == NULL) {
+		kfree(cfg);
+		return -ENODEV;
 	}
+	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, acard->dev);
+	acard->devopl = pnp_request_card_device(card, id->devs[2].id, acard->devmpu);
 
 	pdev = acard->dev;
-	if (!pdev || pdev->prepare(pdev)<0)
-		return -EAGAIN;
 
+	pnp_init_resource_table(cfg);
+
+	/* override resources */
 	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
 	if (dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev],
-			1);
+		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "DT-019X AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-	port[dev] = pdev->resource[0].start;
-	dma8[dev] = pdev->dma_resource[0].start;
-	irq[dev] = pdev->irq_resource[0].start;
-	snd_printdd("dt019x: found audio interface: port=0x%lx, irq=0x%lx, dma=0x%lx\n",
-			port[dev],irq[dev],dma8[dev]);
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
+	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+		printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		kfree(cfg);
+		return err;
+	}
+	port[dev] = pnp_port_start(pdev, 0);
+	dma8[dev] = pnp_dma(pdev, 0);
+	irq[dev] = pnp_irq(pdev, 0);
 
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
-
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
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "MPU-401 the requested resource are invalid, using auto config\n");
+		err = pnp_activate_dev(pdev);
+		if (err < 0)
+			goto __mpu_error;
+		mpu_port[dev] = pnp_port_start(pdev, 0);
+		mpu_irq[dev] = pnp_irq(pdev, 0);
 		snd_printdd("dt019x: found MPU-401: port=0x%lx, irq=0x%lx\n",
-			 	mpu_port[dev],mpu_irq[dev]);
+				mpu_port[dev],mpu_irq[dev]);
+	} else {
+		__mpu_error:
+		if (pdev) {
+			pnp_release_card_device(pdev);
+			printk(KERN_ERR PFX "MPU-401 pnp configure failure, skipping\n");
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
+	if (pdev != NULL) {
+		pnp_init_resource_table(cfg);
+		if (fm_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg->port_resource[0], fm_port[dev], 4);
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "OPL3 the requested resource are invalid, using auto config\n");
+		err = pnp_activate_dev(pdev);
+		if (err < 0)
+			goto __fm_error;
+		fm_port[dev] = pnp_port_start(pdev, 0);
 	} else {
-		fm_port[dev] = pdev->resource[0].start;
-		snd_printdd("dt019x: found OPL3 synth: port=0x%lx\n",fm_port[dev]);
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
+		__fm_error:
+		if (pdev) {
+			pnp_release_card_device(pdev);
+			printk(KERN_ERR PFX "OPL3 pnp configure failure, skipping\n");
+		}
 		acard->devopl = NULL;
+		fm_port[dev] = -1;
 	}
-}
-#endif	/* __ISAPNP__ */
-
-static void snd_card_dt019x_free(snd_card_t *card)
-{
-	struct snd_card_dt019x *acard = (struct snd_card_dt019x *)card->private_data;
 
-	if (acard != NULL) {
-#ifdef __ISAPNP__
-		snd_card_dt019x_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
+	kfree(cfg);
+	return 0;
 }
 
-static int __init snd_card_dt019x_probe(int dev)
+static int __init snd_card_dt019x_probe(int dev,
+					struct pnp_card_link *pcard,
+					const struct pnp_card_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -251,18 +205,10 @@
 				 sizeof(struct snd_card_dt019x))) == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_dt019x *)card->private_data;
-	card->private_free = snd_card_dt019x_free;
-
-#ifdef __ISAPNP__
-	if ((error = snd_card_dt019x_isapnp(dev, acard))) {
+	if ((error = snd_card_dt019x_pnp(dev, acard, pcard, pid))) {
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
@@ -324,13 +270,12 @@
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
+static int __init snd_dt019x_pnp_detect(struct pnp_card_link *card,
+				    const struct pnp_card_id *id)
 {
 	static int dev;
 	int res;
@@ -338,9 +283,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-		snd_dt019x_isapnp_cards[dev] = card;
-		snd_dt019x_isapnp_id[dev] = id;
-		res = snd_card_dt019x_probe(dev);
+		res = snd_card_dt019x_probe(dev, card, id);
 		if (res < 0)
 			return res;
 		dev++;
@@ -348,30 +291,31 @@
         }
         return -ENODEV;
 }
-#endif /* __ISAPNP__ */
 
-static int __init alsa_card_dt019x_init(void)
+static void __exit snd_dt019x_pnp_remove(struct pnp_card_link *pcard)
 {
-	int cards = 0;
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
 
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_dt019x_pnpids, snd_dt019x_isapnp_detect);
-#else
-	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
-#endif
-#ifdef MODULE
-	if (!cards)
-		printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
-#endif
-	return cards ? 0 : -ENODEV;
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
 }
 
-static void __exit alsa_card_dt019x_exit(void)
+static struct pnp_card_driver dt019x_pnpc_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= "dt019x",
+	.id_table	= snd_dt019x_pnpids,
+	.probe		= snd_dt019x_pnp_detect,
+	.remove		= __devexit_p(snd_dt019x_pnp_remove),
+};
+
+static int __init alsa_card_dt019x_init(void)
 {
-	int dev;
+	return (pnp_register_card_driver(&dt019x_pnpc_driver) ? 0 : -ENODEV);
+}
 
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_dt019x_cards[dev]);
+static void __exit alsa_card_dt019x_exit(void)
+{
+	pnp_unregister_card_driver(&dt019x_pnpc_driver);
 }
 
 module_init(alsa_card_dt019x_init)
