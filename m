Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTARVO0>; Sat, 18 Jan 2003 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbTARVO0>; Sat, 18 Jan 2003 16:14:26 -0500
Received: from gate.perex.cz ([194.212.165.105]:62729 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265081AbTARVOR>;
	Sat, 18 Jan 2003 16:14:17 -0500
Date: Sat, 18 Jan 2003 22:23:06 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.58][PnP] Some small points.
In-Reply-To: <20030117111838.GB26108@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301182220430.3993-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Adam Belay wrote:

> > 4) Have we got ALSA driver that work absolutly and use PnP layer in
> > right ways?
> 
> I believe Jaroslav is working on that now.  Jaroslav, if you would like me to 
> convert ALSA drivers please let me know.

I'm working on it. Your converted drivers still misses one feature: force
resources via module options. Two complete drivers using configuration 
templates follow.

                                                Jaroslav

===== als100.c 1.7 vs edited =====
--- 1.7/sound/isa/als100.c	Tue Oct 22 15:04:00 2002
+++ edited/als100.c	Sat Jan 18 20:57:17 2003
@@ -24,11 +24,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/time.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
@@ -96,167 +92,116 @@
 MODULE_PARM_SYNTAX(dma16, SNDRV_DMA16_DESC);
 
 struct snd_card_als100 {
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
-	struct isapnp_dev *devmpu;
-	struct isapnp_dev *devopl;
-#endif	/* __ISAPNP__ */
+	int dev_no;
+	struct pnp_dev *dev;
+	struct pnp_dev *devmpu;
+	struct pnp_dev *devopl;
 };
 
-static snd_card_t *snd_als100_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-static struct isapnp_card *snd_als100_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_als100_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-#define ISAPNP_ALS100(_va, _vb, _vc, _device, _audio, _mpu401, _opl) \
-        { \
-                ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-                devs : { ISAPNP_DEVICE_ID('@', '@', '@', _audio), \
-                         ISAPNP_DEVICE_ID('@', 'X', '@', _mpu401), \
-			 ISAPNP_DEVICE_ID('@', 'H', '@', _opl) } \
-        }
-
-static struct isapnp_card_id snd_als100_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_als100_pnpids[] __devinitdata = {
 	/* ALS100 - PRO16PNP */
-	ISAPNP_ALS100('A','L','S',0x0001,0x0001,0x0001,0x0001),
+	{ .id = "ALS0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
 	/* ALS110 - MF1000 - Digimate 3D Sound */
-	ISAPNP_ALS100('A','L','S',0x0110,0x1001,0x1001,0x1001),
+	{ .id = "ALS0110", .devs = { { "@@@1001" }, { "@X@1001" }, { "@H@1001" }, } },
 	/* ALS120 */
-	ISAPNP_ALS100('A','L','S',0x0120,0x2001,0x2001,0x2001),
+	{ .id = "ALS0120", .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" }, } },
 	/* ALS200 */
-	ISAPNP_ALS100('A','L','S',0x0200,0x0020,0x0020,0x0001),
+	{ .id = "ALS0200", .devs = { { "@@@0020" }, { "@X@0020" }, { "@H@0001" }, } },
 	/* RTL3000 */
-	ISAPNP_ALS100('R','T','L',0x3000,0x2001,0x2001,0x2001),
-	{ ISAPNP_CARD_END, }
+	{ .id = "RTL3000", .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" }, } },
+	{ .id = "", } /* end */
 };
 
-ISAPNP_CARD_TABLE(snd_als100_pnpids);
-
-#endif	/* __ISAPNP__ */
+MODULE_DEVICE_TABLE(pnp_card, snd_als100_pnpids);
 
 #define DRIVER_NAME	"snd-card-als100"
 
 
-#ifdef __ISAPNP__
-static int __init snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard)
+static int __devinit snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard,
+					    struct pnp_card *card,
+					    const struct pnp_card_device_id *id)
 {
-	const struct isapnp_card_id *id = snd_als100_isapnp_id[dev];
-	struct isapnp_card *card = snd_als100_isapnp_cards[dev];
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
-	}
+	struct pnp_dev *pdev;
+	struct pnp_res_cfg cfg;
+	int err;
+
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (acard->dev == NULL)
+		return -ENODEV;
+	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, acard->dev);
+	acard->devopl = pnp_request_card_device(card, id->devs[2].id, acard->devmpu);
 
 	pdev = acard->dev;
-	if (pdev->prepare(pdev)<0)
-		return -EAGAIN;
-
+	if (pnp_init_res_cfg(&cfg) < 0)
+		return -ENOMEM;
+	/* override resources */
 	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+		pnp_resource_change(&cfg.io_resource[0], port[dev], 16);
 	if (dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev],
-			1);
+		pnp_resource_change(&cfg.dma_resource[0], dma8[dev], 1);
 	if (dma16[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma16[dev],
-			1);
+		pnp_resource_change(&cfg.dma_resource[1], dma16[dev], 1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-
-	port[dev] = pdev->resource[0].start;
-	dma8[dev] = pdev->dma_resource[1].start;
-	dma16[dev] = pdev->dma_resource[0].start;
-	irq[dev] = pdev->irq_resource[0].start;
+		pnp_resource_change(&cfg.irq_resource[0], irq[dev], 1);
+	err = pnp_activate_dev(pdev, &cfg);
+	if (err < 0) {
+		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		return err;
+	}
+	port[dev] = pnp_port_start(pdev, 0);
+	dma8[dev] = pnp_dma(pdev, 1);
+	dma16[dev] = pnp_dma(pdev, 0);
+	irq[dev] = pnp_irq(pdev, 0);
 
 	pdev = acard->devmpu;
-	if (pdev == NULL || pdev->prepare(pdev)<0) {
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
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "MPU-401 isapnp configure failure\n");
-		mpu_port[dev] = -1;
-		acard->devmpu = NULL;
+	if (pdev != NULL) {
+		if (pnp_init_res_cfg(&cfg) < 0)
+			goto __mpu_error;
+		if (mpu_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg.io_resource[0], mpu_port[dev], 2);
+		if (mpu_irq[dev] != SNDRV_AUTO_IRQ)
+			pnp_resource_change(&cfg.irq_resource[0], mpu_irq[dev], 1);
+		err = pnp_activate_dev(pdev, &cfg);
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
 
 	pdev = acard->devopl;
-	if (pdev == NULL || pdev->prepare(pdev)<0) {
-		fm_port[dev] = -1;
-		return 0;
-	}
-
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], fm_port[dev], 4);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "OPL isapnp configure failure\n");
-		fm_port[dev] = -1;
-		acard->devopl = NULL;
+	if (pdev != NULL) {
+		if (pnp_init_res_cfg(&cfg) < 0)
+			goto __fm_error;
+		if (fm_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg.io_resource[0], fm_port[dev], 4);
+		err = pnp_activate_dev(pdev, &cfg);
+		if (err < 0)
+			goto __fm_error;
+		fm_port[dev] = pnp_port_start(pdev, 0);
 	} else {
-		fm_port[dev] = pdev->resource[0].start;
+	      __fm_error:
+	     	if (pdev) {
+		     	pnp_release_card_device(pdev);
+	     		printk(KERN_ERR PFX "OPL3 pnp configure failure, skipping\n");
+	     	}
+	     	acard->devopl = NULL;
+	     	fm_port[dev] = -1;
 	}
 
 	return 0;
 }
 
-static void snd_card_als100_deactivate(struct snd_card_als100 *acard)
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
-		acard->devopl = NULL;
-	}
-}
-#endif	/* __ISAPNP__ */
-
-static void snd_card_als100_free(snd_card_t *card)
-{
-	struct snd_card_als100 *acard = (struct snd_card_als100 *)card->private_data;
-
-	if (acard) {
-#ifdef __ISAPNP__
-		snd_card_als100_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
-}
-
-static int __init snd_card_als100_probe(int dev)
+static int __init snd_card_als100_probe(int dev,
+					struct pnp_card *pcard,
+					const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -268,18 +213,11 @@
 				 sizeof(struct snd_card_als100))) == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_als100 *)card->private_data;
-	card->private_free = snd_card_als100_free;
 
-#ifdef __ISAPNP__
-	if ((error = snd_card_als100_isapnp(dev, acard))) {
+	if ((error = snd_card_als100_isapnp(dev, acard, pcard, pid))) {
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
@@ -336,13 +274,12 @@
 		snd_card_free(card);
 		return error;
 	}
-	snd_als100_cards[dev] = card;
+	pnpc_set_drvdata(pcard, card);
 	return 0;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_als100_isapnp_detect(struct isapnp_card *card,
-					   const struct isapnp_card_id *id)
+static int __devinit snd_als100_pnp_detect(struct pnp_card *card,
+					   const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
@@ -350,9 +287,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-		snd_als100_isapnp_cards[dev] = card;
-		snd_als100_isapnp_id[dev] = id;
-		res = snd_card_als100_probe(dev);
+		res = snd_card_als100_probe(dev, card, id);
 		if (res < 0)
 			return res;
 		dev++;
@@ -360,17 +295,28 @@
 	}
 	return -ENODEV;
 }
-#endif
+
+static void __devexit snd_als100_pnp_remove(struct pnp_card * pcard)
+{
+	snd_card_t *card = (snd_card_t *) pnpc_get_drvdata(pcard);
+
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
+}
+
+static struct pnpc_driver als100_pnpc_driver = {
+	.flags          = PNPC_DRIVER_DO_NOT_ACTIVATE,
+        .name           = "als100",
+        .id_table       = snd_als100_pnpids,
+        .probe          = snd_als100_pnp_detect,
+        .remove         = __devexit_p(snd_als100_pnp_remove),
+};
 
 static int __init alsa_card_als100_init(void)
 {
 	int cards = 0;
 
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_als100_pnpids, snd_als100_isapnp_detect);
-#else
-	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
-#endif
+	cards += pnpc_register_driver(&als100_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
 		printk(KERN_ERR "no ALS100 based soundcards found\n");
@@ -380,10 +326,7 @@
 
 static void __exit alsa_card_als100_exit(void)
 {
-	int dev;
-
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_als100_cards[dev]);
+	pnpc_unregister_driver(&als100_pnpc_driver);
 }
 
 module_init(alsa_card_als100_init)
===== opl3sa2.c 1.14 vs edited =====
--- 1.14/sound/isa/opl3sa2.c	Sat Dec  7 17:11:30 2002
+++ edited/opl3sa2.c	Sat Jan 18 21:00:37 2003
@@ -134,6 +134,7 @@
 
 struct snd_opl3sa2 {
 	snd_card_t *card;
+	int dev_no;		/* device / slot index */
 	int version;		/* 2 or 3 */
 	unsigned long port;	/* control port */
 	struct resource *res_port; /* control port resource */
@@ -161,23 +162,20 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-static const struct pnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-static struct pnp_card_id snd_opl3sa2_pnpids[] = {
+static struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
-	{.id = "YMH0020", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0020", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-	{.id = "YMH0030", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0030", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA2 */
-	{.id = "YMH0800", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0800", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* NeoMagic MagicWave 3DX */
-	{.id = "NMX2200", .driver_data = 0, devs : { {.id="NMX2210"}, } },
+	{.id = "NMX2200", .driver_data = 0, .devs = { {.id="NMX2210"}, } },
 	/* --- */
 	{.id = "", } /* end */
 };
 
-/*PNP_CARD_TABLE(snd_opl3sa2_pnpids);*/
+MODULE_DEVICE_TABLE(pnp_card, snd_opl3sa2_pnpids);
 
 #endif /* CONFIG_PNP */
 
@@ -625,40 +623,69 @@
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PNP
-static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
+static int __devinit snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip,
+					struct pnp_card *card,
+					const struct pnp_card_device_id *id)
 {
-        const struct pnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
-        struct pnp_card *card = snd_opl3sa2_isapnp_cards[dev];
 	struct pnp_dev *pdev;
+	struct pnp_res_cfg cfg;
+	int err;
 
-	chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	pdev = chip->dev;
+	pdev = chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (!pdev){
 		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the needed devices\n");
 		return -ENODEV;
 	}
-	sb_port[dev] = pdev->resource[0].start;
-	wss_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
-	midi_port[dev] = pdev->resource[3].start;
-	port[dev] = pdev->resource[4].start;
-	dma1[dev] = pdev->dma_resource[0].start;
-	dma2[dev] = pdev->dma_resource[1].start;
-	irq[dev] = pdev->irq_resource[0].start;
+	if (pnp_init_res_cfg(&cfg) < 0)
+		return -ENOMEM;
+	/* override resources */
+	if (sb_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[0], sb_port[dev], 16);
+	if (wss_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[1], wss_port[dev], 8);
+	if (fm_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[2], fm_port[dev], 4);
+	if (midi_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[3], midi_port[dev], 2);
+	if (port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[4], port[dev], 2);
+	if (dma1[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg.dma_resource[0], dma1[dev], 1);
+	if (dma2[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg.dma_resource[1], dma2[dev], 1);
+	if (irq[dev] != SNDRV_AUTO_IRQ)
+		pnp_resource_change(&cfg.irq_resource[0], irq[dev], 1);
+	err = pnp_activate_dev(pdev, &cfg);
+	if (err < 0) {
+		snd_printk(KERN_ERR "cannot activate pnp device (out of resources?)\n");
+		return err;
+	}
+	sb_port[dev] = pnp_port_start(pdev, 0);
+	wss_port[dev] = pnp_port_start(pdev, 1);
+	fm_port[dev] = pnp_port_start(pdev, 2);
+	midi_port[dev] = pnp_port_start(pdev, 3);
+	port[dev] = pnp_port_start(pdev, 4);
+	dma1[dev] = pnp_dma(pdev, 0);
+	dma2[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
 	snd_printdd("isapnp OPL3-SA: sb port=0x%lx, wss port=0x%lx, fm port=0x%lx, midi port=0x%lx\n",
 		sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
 	snd_printdd("isapnp OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, irq=%i\n",
 		port[dev], dma1[dev], dma2[dev], irq[dev]);
 	return 0;
 }
-
+#else
+static int __devinit snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip,
+					struct pnp_card *card,
+					const struct pnp_card_device_id *id)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_PNP */
 
 static int snd_opl3sa2_free(opl3sa2_t *chip)
 {
-#ifdef CONFIG_PNP
-	chip->dev = NULL;
-#endif
+	snd_opl3sa2_cards[chip->dev_no] = NULL;
 #ifdef CONFIG_PM
 	if (chip->pm_dev)
 		pm_unregister(chip->pm_dev);
@@ -679,7 +706,9 @@
 	return snd_opl3sa2_free(chip);
 }
 
-static int __init snd_opl3sa2_probe(int dev)
+static int __devinit snd_opl3sa2_probe(int dev, int _isapnp,
+				       struct pnp_card *pcard,
+				       const struct pnp_card_device_id *pid)
 {
 	int xirq, xdma1, xdma2;
 	snd_card_t *card;
@@ -691,9 +720,7 @@
 	};
 	int err;
 
-#ifdef CONFIG_PNP
-	if (!isapnp[dev]) {
-#endif
+	if (!_isapnp) {
 		if (port[dev] == SNDRV_AUTO_PORT) {
 			snd_printk("specify port\n");
 			return -EINVAL;
@@ -710,9 +737,7 @@
 			snd_printk("specify midi_port\n");
 			return -EINVAL;
 		}
-#ifdef CONFIG_PNP
 	}
-#endif
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
@@ -723,13 +748,12 @@
 		err = -ENOMEM;
 		goto __error;
 	}
+	chip->dev_no = dev;
 	chip->irq = -1;
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
-#ifdef CONFIG_PNP
-	if (isapnp[dev] && (err = snd_opl3sa2_isapnp(dev, chip)) < 0)
+	if (_isapnp && (err = snd_opl3sa2_isapnp(dev, chip, pcard, pid)) < 0)
 		goto __error;
-#endif
 	chip->ymode = opl3sa3_ymode[dev] & 0x03 ; /* initialise this card from supplied (or default) parameter*/ 
 	chip->card = card;
 	chip->port = port[dev];
@@ -806,6 +830,7 @@
 	if ((err = snd_card_register(card)) < 0)
 		goto __error;
 
+	pnpc_set_drvdata(pcard, card);
 	snd_opl3sa2_cards[dev] = card;
 	return 0;
 
@@ -815,18 +840,16 @@
 }
 
 #ifdef CONFIG_PNP
-static int __init snd_opl3sa2_isapnp_detect(struct pnp_card *card,
-					    const struct pnp_card_id *id)
+static int __devinit snd_opl3sa2_isapnp_detect(struct pnp_card *card,
+					    const struct pnp_card_device_id *id)
 {
         static int dev;
         int res;
 
         for ( ; dev < SNDRV_CARDS; dev++) {
-                if (!enable[dev])
+                if (!enable[dev] || !isapnp[dev])
                         continue;
-                snd_opl3sa2_isapnp_cards[dev] = card;
-                snd_opl3sa2_isapnp_id[dev] = id;
-                res = snd_opl3sa2_probe(dev);
+                res = snd_opl3sa2_probe(dev, 1, card, id);
                 if (res < 0)
                         return res;
                 dev++;
@@ -835,18 +858,21 @@
         return -ENODEV;
 }
 
-static void snd_opl3sa2_isapnp_remove(struct pnp_card * card)
+static void __devexit snd_opl3sa2_isapnp_remove(struct pnp_card * pcard)
 {
-/* FIXME */
+	snd_card_t * card = (snd_card_t *) pnpc_get_drvdata(pcard);
+	
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
 }
 
 static struct pnpc_driver opl3sa2_pnpc_driver = {
+	.flags		= PNPC_DRIVER_DO_NOT_ACTIVATE,
 	.name		= "opl3sa2",
 	.id_table	= snd_opl3sa2_pnpids,
 	.probe		= snd_opl3sa2_isapnp_detect,
-	.remove		= snd_opl3sa2_isapnp_remove,
+	.remove		= __devexit_p(snd_opl3sa2_isapnp_remove),
 };
-
 #endif /* CONFIG_PNP */
 
 static int __init alsa_card_opl3sa2_init(void)
@@ -860,7 +886,7 @@
 		if (isapnp[dev])
 			continue;
 #endif
-		if (snd_opl3sa2_probe(dev) >= 0)
+		if (snd_opl3sa2_probe(dev, 0, NULL, NULL) >= 0)
 			cards++;
 	}
 #ifdef CONFIG_PNP
@@ -877,10 +903,11 @@
 
 static void __exit alsa_card_opl3sa2_exit(void)
 {
-	int idx;
+        int dev;
 
-	for (idx = 0; idx < SNDRV_CARDS; idx++)
-		snd_card_free(snd_opl3sa2_cards[idx]);
+	pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+	for (dev = 0; dev < SNDRV_CARDS; dev++)
+		snd_card_free(snd_opl3sa2_cards[dev]);
 }
 
 module_init(alsa_card_opl3sa2_init)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

