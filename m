Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbTCJEyS>; Sun, 9 Mar 2003 23:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbTCJExj>; Sun, 9 Mar 2003 23:53:39 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:8834 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262722AbTCJEwV>;
	Sun, 9 Mar 2003 23:52:21 -0500
Date: Mon, 10 Mar 2003 00:07:05 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000705.GD2118@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030310000521.GA2118@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000521.GA2118@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1081  -> 1.1082 
#	  sound/isa/als100.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/09	ambx1@neo.rr.com	1.1082
# ALS100 Updates
# 
# Updates the als100 driver to use the pnp apis.  Includes resource config
# templates.
# --------------------------------------------
#
diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Sun Mar  9 23:47:46 2003
+++ b/sound/isa/als100.c	Sun Mar  9 23:47:46 2003
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
@@ -96,167 +92,126 @@
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
+static struct pnp_card_id snd_als100_pnpids[] __devinitdata = {
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
 
+static struct pnp_card_driver als100_pnpc_driver;
 
-#ifdef __ISAPNP__
-static int __init snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard)
+static int __devinit snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard,
+					    struct pnp_card *card,
+					    const struct pnp_card_id *id)
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
+	struct pnp_dev *pdev;
+	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	int err;
+	if (!cfg)
+		return -ENOMEM;
+	acard->dev = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[0].id, NULL);
+	if (acard->dev == NULL) {
+		kfree(cfg);
+		return -ENODEV;
 	}
+	acard->devmpu = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[1].id, acard->dev);
+	acard->devopl = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[2].id, acard->devmpu);
 
 	pdev = acard->dev;
-	if (pdev->prepare(pdev)<0)
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
 	if (dma16[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma16[dev],
-			1);
+		pnp_resource_change(&cfg->dma_resource[1], dma16[dev], 1);
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
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
+	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+		printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
+	err = pnp_activate_dev(pdev);
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
+		pnp_init_resource_table(cfg);
+		if (fm_port[dev] != SNDRV_AUTO_PORT)
+			pnp_resource_change(&cfg->port_resource[0], fm_port[dev], 4);
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0)
+			printk(KERN_ERR PFX "OPL3 the requested resources are invalid, using auto config\n");
+		err = pnp_activate_dev(pdev);
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
 
+	kfree(cfg);
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
+					const struct pnp_card_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -268,18 +223,11 @@
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
@@ -336,13 +284,12 @@
 		snd_card_free(card);
 		return error;
 	}
-	snd_als100_cards[dev] = card;
+	pnp_set_card_drvdata(pcard, card);
 	return 0;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_als100_isapnp_detect(struct isapnp_card *card,
-					   const struct isapnp_card_id *id)
+static int __devinit snd_als100_pnp_detect(struct pnp_card *card,
+					   const struct pnp_card_id *id)
 {
 	static int dev;
 	int res;
@@ -350,9 +297,7 @@
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
@@ -360,17 +305,28 @@
 	}
 	return -ENODEV;
 }
-#endif
+
+static void __devexit snd_als100_pnp_remove(struct pnp_card * pcard)
+{
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
+
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
+}
+
+static struct pnp_card_driver als100_pnpc_driver = {
+	.flags          = PNP_DRIVER_RES_DISABLE,
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
+	cards += pnp_register_card_driver(&als100_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
 		printk(KERN_ERR "no ALS100 based soundcards found\n");
@@ -380,10 +336,7 @@
 
 static void __exit alsa_card_als100_exit(void)
 {
-	int dev;
-
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_als100_cards[dev]);
+	pnp_unregister_card_driver(&als100_pnpc_driver);
 }
 
 module_init(alsa_card_als100_init)
