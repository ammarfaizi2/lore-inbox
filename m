Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263810AbTCUSzF>; Fri, 21 Mar 2003 13:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263822AbTCUSyR>; Fri, 21 Mar 2003 13:54:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30084
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263810AbTCUSwc>; Fri, 21 Mar 2003 13:52:32 -0500
Date: Fri, 21 Mar 2003 20:07:47 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212007.h2LK7lMp026260@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: clean up es968, fix build
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/isa/sb/es968.c linux-2.5.65-ac2/sound/isa/sb/es968.c
--- linux-2.5.65/sound/isa/sb/es968.c	2003-02-10 18:38:37.000000000 +0000
+++ linux-2.5.65-ac2/sound/isa/sb/es968.c	2003-03-20 18:13:41.000000000 +0000
@@ -23,11 +23,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
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
@@ -35,6 +31,8 @@
 
 #define chip_t sb_t
 
+#define PFX "es968: "
+
 MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_DESCRIPTION("ESS AudioDrive ES968");
 MODULE_LICENSE("GPL");
@@ -68,32 +66,18 @@
 MODULE_PARM_SYNTAX(dma8, SNDRV_DMA8_DESC);
 
 struct snd_card_es968 {
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
-#endif	/* __ISAPNP__ */
+	struct pnp_dev *dev;
 };
 
-static snd_card_t *snd_es968_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-static struct isapnp_card *snd_es968_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_es968_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-static struct isapnp_card_id snd_es968_pnpids[] __devinitdata = {
-        {
-                ISAPNP_CARD_ID('E','S','S',0x0968),
-                .devs = { ISAPNP_DEVICE_ID('E','S','S',0x0968), }
-        },
-        { ISAPNP_CARD_END, }
+static struct pnp_card_id snd_es968_pnpids[] __devinitdata = {
+	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
+	{ .id = "", } /* end */
 };
 
-ISAPNP_CARD_TABLE(snd_es968_pnpids);
-
-#endif	/* __ISAPNP__ */
+MODULE_DEVICE_TABLE(pnp_card, snd_es968_pnpids);
 
 #define	DRIVER_NAME	"snd-card-es968"
 
-
 static void snd_card_es968_interrupt(int irq, void *dev_id,
 				     struct pt_regs *regs)
 {
@@ -106,64 +90,50 @@
 	}
 }
 
-#ifdef __ISAPNP__
-static int __init snd_card_es968_isapnp(int dev, struct snd_card_es968 *acard)
-{
-	const struct isapnp_card_id *id = snd_es968_isapnp_id[dev];
-	struct isapnp_card *card = snd_es968_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (acard->dev->active) {
-		acard->dev = NULL;
-		return -EBUSY;
+static int __devinit snd_card_es968_isapnp(int dev, struct snd_card_es968 *acard,
+					struct pnp_card_link *card,
+					const struct pnp_card_id *id)
+{
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
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-
-	if (pdev->activate(pdev)<0) {
-		snd_printk("AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-
-	port[dev] = pdev->resource[0].start;
-	dma8[dev] = pdev->dma_resource[0].start;
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
+	irq[dev] = pnp_irq(pdev, 0);
 
+	kfree(cfg);
 	return 0;
 }
 
-static void snd_card_es968_deactivate(struct snd_card_es968 *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev = NULL;
-	}
-}
-#endif	/* __ISAPNP__ */
-
-static void snd_card_es968_free(snd_card_t *card)
-{
-	struct snd_card_es968 *acard = (struct snd_card_es968 *)card->private_data;
-
-	if (acard) {
-#ifdef __ISAPNP__
-		snd_card_es968_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
-}
-
-static int __init snd_card_es968_probe(int dev)
+static int __init snd_card_es968_probe(int dev,
+					struct pnp_card_link *pcard,
+					const struct pnp_card_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -174,18 +144,10 @@
 				 sizeof(struct snd_card_es968))) == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_es968 *)card->private_data;
-	card->private_free = snd_card_es968_free;
-
-#ifdef __ISAPNP__
-	if ((error = snd_card_es968_isapnp(dev, acard))) {
+	if ((error = snd_card_es968_isapnp(dev, acard, pcard, pid))) {
 		snd_card_free(card);
 		return error;
 	}
-#else
-	snd_printk("you have to enable PnP support ...\n");
-	snd_card_free(card);
-	return -ENOSYS;
-#endif	/* __ISAPNP__ */
 
 	if ((error = snd_sbdsp_create(card, port[dev],
 				      irq[dev],
@@ -221,13 +183,12 @@
 		snd_card_free(card);
 		return error;
 	}
-	snd_es968_cards[dev] = card;
+	pnp_set_card_drvdata(pcard, card);
 	return 0;
 }
 
-#ifdef __ISAPNP__
-static int __init snd_es968_isapnp_detect(struct isapnp_card *card,
-                                          const struct isapnp_card_id *id)
+static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
+                                          const struct pnp_card_id *id)
 {
 	static int dev;
 	int res;
@@ -235,9 +196,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
 			continue;
-		snd_es968_isapnp_cards[dev] = card;
-		snd_es968_isapnp_id[dev] = id;
-		res = snd_card_es968_probe(dev);
+		res = snd_card_es968_probe(dev, card, id);
 		if (res < 0)
 			return res;
 		dev++;
@@ -245,30 +204,31 @@
         }
         return -ENODEV;
 }
-#endif /* __ISAPNP__ */
 
-static int __init alsa_card_es968_init(void)
+static void __devexit snd_es968_pnp_remove(struct pnp_card_link * pcard)
 {
-	int cards = 0;
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
 
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_es968_pnpids, snd_es968_isapnp_detect);
-#else
-	snd_printk("you have to enable ISA PnP support.\n");
-#endif
-#ifdef MODULE
-	if (!cards)
-		snd_printk("no ES968 based soundcards found\n");
-#endif
-	return cards ? 0 : -ENODEV;
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
 }
 
-static void __exit alsa_card_es968_exit(void)
+static struct pnp_card_driver es968_pnpc_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= "es968",
+	.id_table	= snd_es968_pnpids,
+	.probe		= snd_es968_pnp_detect,
+	.remove		= __devexit_p(snd_es968_pnp_remove),
+};
+
+static int __init alsa_card_es968_init(void)
 {
-	int dev;
+	return (pnp_register_card_driver(&es968_pnpc_driver) ? 0 : -ENODEV);
+}
 
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_es968_cards[dev]);
+static void __exit alsa_card_es968_exit(void)
+{
+	pnp_unregister_card_driver(&es968_pnpc_driver);
 }
 
 module_init(alsa_card_es968_init)
