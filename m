Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbSK3Ltq>; Sat, 30 Nov 2002 06:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbSK3Ltq>; Sat, 30 Nov 2002 06:49:46 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:59239
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267235AbSK3Ltm>; Sat, 30 Nov 2002 06:49:42 -0500
Date: Sat, 30 Nov 2002 07:00:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
Message-ID: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISAPNP/ALSA hasn't been working for a while now (cards didn't get
detected), here is a patch to update OPL3SA2 to the new PnP layer.

ALSA device list:
  #0: Yamaha OPL3-SA23 at 0x100, irq 5, dma 1&3

Driver tested in kernel and modular, i have tried to maintain
detection/resource override semantics and general detection code
paths.

Regards,
	Zwane Mwaikambo

Index: linux-2.5.50/sound/isa/opl3sa2.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.50/sound/isa/opl3sa2.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opl3sa2.c
--- linux-2.5.50/sound/isa/opl3sa2.c	28 Nov 2002 01:36:04 -0000	1.1.1.1
+++ linux-2.5.50/sound/isa/opl3sa2.c	30 Nov 2002 11:51:30 -0000
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/pnp.h>
 #ifndef LINUX_ISAPNP_H
 #include <linux/isapnp.h>
 #define isapnp_card pci_bus
@@ -135,6 +136,7 @@

 typedef struct snd_opl3sa2 opl3sa2_t;
 #define chip_t opl3sa2_t
+int nr_cards;

 struct snd_opl3sa2 {
 	snd_card_t *card;
@@ -148,7 +150,7 @@
 	snd_rawmidi_t *rmidi;
 	cs4231_t *cs4231;
 #ifdef __ISAPNP__
-	struct isapnp_dev *dev;
+	struct pnp_dev *dev;
 #endif
 	unsigned char ctlregs[0x20];
 	int ymode;		/* SL added */
@@ -164,30 +166,28 @@
 static snd_card_t *snd_opl3sa2_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;

 #ifdef __ISAPNP__
+static struct pnp_dev *snd_opl3sa2_isapnp_devs[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;

-static struct isapnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-#define ISAPNP_OPL3SA2(_va, _vb, _vc, _device, _function) \
-        { \
-                ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-                devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _function), } \
-        }
-
-static struct isapnp_card_id snd_opl3sa2_pnpids[] __devinitdata = {
+/* Please try and keep the 1:1 mapping with the dev listing below */
+static const struct pnp_id pnp_opl3sa2_cards[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
-	ISAPNP_OPL3SA2('Y','M','H',0x0020,0x0021),
+	{.id = "YMH0020",	.driver_data = 0},
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-	ISAPNP_OPL3SA2('Y','M','H',0x0030,0x0021),
+	{.id = "YMH0030",	.driver_data = 0},
 	/* Yamaha OPL3-SA2 */
-	ISAPNP_OPL3SA2('Y','M','H',0x0800,0x0021),
+	{.id = "YMH0800",	.driver_data = 0},
 	/* NeoMagic MagicWave 3DX */
-	ISAPNP_OPL3SA2('N','M','X',0x2200,0x2210),
-	/* --- */
-	{ ISAPNP_CARD_END, }	/* end */
+	{.id = "NMX2200",	.driver_data = 0},
+	{"", 0}
 };

-ISAPNP_CARD_TABLE(snd_opl3sa2_pnpids);
+static const struct pnp_id pnp_opl3sa2_devs[] = {
+	{.id = "YMH0021",	.driver_data = 0},
+	{.id = "YMH0021",	.driver_data = 0},
+	{.id = "YMH0021",	.driver_data = 0},
+	{.id = "NMX2210",	.driver_data = 0},
+	{"", 0}
+};

 #endif /* __ISAPNP__ */

@@ -634,22 +634,42 @@

 #endif /* CONFIG_PM */

+static int snd_opl3sa2_free(opl3sa2_t *chip)
+{
+#ifdef __ISAPNP__
+	pnp_disable_dev(chip->dev);
+	pnp_remove_device(chip->dev);
+#endif
+#ifdef CONFIG_PM
+	if (chip->pm_dev)
+		pm_unregister(chip->pm_dev);
+#endif
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
+	if (chip->res_port) {
+		release_resource(chip->res_port);
+		kfree_nocheck(chip->res_port);
+	}
+
+	snd_magic_kfree(chip);
+	return 0;
+}
+
+static int snd_opl3sa2_dev_free(snd_device_t *device)
+{
+	opl3sa2_t *chip = snd_magic_cast(opl3sa2_t, device->device_data, return -ENXIO);
+	return snd_opl3sa2_free(chip);
+}
+
 #ifdef __ISAPNP__
 static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
 {
-        const struct isapnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
-        struct isapnp_card *card = snd_opl3sa2_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
+	int res = 0;
+	struct pnp_dev *pdev = snd_opl3sa2_isapnp_devs[dev];
+
+	if (!enable[dev])
+		return -ENODEV;

-	chip->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (chip->dev->active) {
-		chip->dev = NULL;
-		return -EBUSY;
-	}
-	/* PnP initialization */
-	pdev = chip->dev;
-	if (pdev->prepare(pdev)<0)
-		return -EAGAIN;
 	if (sb_port[dev] != SNDRV_AUTO_PORT)
 		isapnp_resource_change(&pdev->resource[0], sb_port[dev], 16);
 	if (wss_port[dev] != SNDRV_AUTO_PORT)
@@ -666,59 +686,27 @@
 		isapnp_resource_change(&pdev->dma_resource[1], dma2[dev], 1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
 		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-	if (pdev->activate(pdev)<0) {
-		snd_printk("isapnp configure failure (out of resources?)\n");
-		return -EBUSY;
-	}
-	sb_port[dev] = pdev->resource[0].start;
-	wss_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
-	midi_port[dev] = pdev->resource[3].start;
-	port[dev] = pdev->resource[4].start;
+
+	sb_port[dev] = pci_resource_start(pdev, 0);
+	wss_port[dev] = pci_resource_start(pdev, 1);
+	fm_port[dev] = pci_resource_start(pdev, 2);
+	midi_port[dev] = pci_resource_start(pdev, 3);
+	port[dev] = pci_resource_start(pdev, 4);
 	dma1[dev] = pdev->dma_resource[0].start;
 	dma2[dev] = pdev->dma_resource[1].start;
 	irq[dev] = pdev->irq_resource[0].start;
+
 	snd_printdd("isapnp OPL3-SA: sb port=0x%lx, wss port=0x%lx, fm port=0x%lx, midi port=0x%lx\n",
 		sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
 	snd_printdd("isapnp OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, irq=%i\n",
 		port[dev], dma1[dev], dma2[dev], irq[dev]);
-	return 0;
-}
-
-static void snd_opl3sa2_deactivate(opl3sa2_t *chip)
-{
-	if (chip->dev) {
-		chip->dev->deactivate(chip->dev);
-		chip->dev = NULL;
-	}
+	chip->dev = pdev;
+
+out_error:
+	return res;
 }
 #endif /* __ISAPNP__ */

-static int snd_opl3sa2_free(opl3sa2_t *chip)
-{
-#ifdef __ISAPNP__
-	snd_opl3sa2_deactivate(chip);
-#endif
-#ifdef CONFIG_PM
-	if (chip->pm_dev)
-		pm_unregister(chip->pm_dev);
-#endif
-	if (chip->irq >= 0)
-		free_irq(chip->irq, (void *)chip);
-	if (chip->res_port) {
-		release_resource(chip->res_port);
-		kfree_nocheck(chip->res_port);
-	}
-	snd_magic_kfree(chip);
-	return 0;
-}
-
-static int snd_opl3sa2_dev_free(snd_device_t *device)
-{
-	opl3sa2_t *chip = snd_magic_cast(opl3sa2_t, device->device_data, return -ENXIO);
-	return snd_opl3sa2_free(chip);
-}
-
 static int __init snd_opl3sa2_probe(int dev)
 {
 	int xirq, xdma1, xdma2;
@@ -763,7 +751,9 @@
 		err = -ENOMEM;
 		goto __error;
 	}
+	spin_lock_init(&chip->reg_lock);
 	chip->irq = -1;
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
 #ifdef __ISAPNP__
@@ -855,30 +845,47 @@
 }

 #ifdef __ISAPNP__
-static int __init snd_opl3sa2_isapnp_detect(struct isapnp_card *card,
-					    const struct isapnp_card_id *id)
+static int pnp_opl3sa2_probe(struct pnp_dev *pdev, const struct pnp_id *card_id,
+				const struct pnp_id *dev_id)
 {
-        static int dev;
+	static int dev;
         int res;

         for ( ; dev < SNDRV_CARDS; dev++) {
                 if (!enable[dev])
                         continue;
-                snd_opl3sa2_isapnp_cards[dev] = card;
-                snd_opl3sa2_isapnp_id[dev] = id;
+                snd_opl3sa2_isapnp_devs[dev] = pdev;
                 res = snd_opl3sa2_probe(dev);
                 if (res < 0)
                         return res;
                 dev++;
+		nr_cards++;
                 return 0;
         }
         return -ENODEV;
 }
+
+static void pnp_opl3sa2_remove(struct pnp_dev *pdev)
+{
+	opl3sa2_t *chip = pdev->driver_data;
+	if (chip)
+		chip->dev = NULL;
+	nr_cards--;
+}
+
+static struct pnp_driver snd_opl3sa2_pnp_driver = {
+	.name		= "opl3sa2",
+	.card_id_table	= pnp_opl3sa2_cards,
+	.id_table	= pnp_opl3sa2_devs,
+	.probe		= pnp_opl3sa2_probe,
+	.remove		= pnp_opl3sa2_remove,
+};
+
 #endif /* __ISAPNP__ */

 static int __init alsa_card_opl3sa2_init(void)
 {
-	int dev, cards = 0;
+	int dev;

 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
@@ -888,15 +895,19 @@
 			continue;
 #endif
 		if (snd_opl3sa2_probe(dev) >= 0)
-			cards++;
+			nr_cards++;
 	}
+
 #ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_opl3sa2_pnpids, snd_opl3sa2_isapnp_detect);
+	/* upon registration the probe function will increment nr_cards */
+	pnp_register_driver(&snd_opl3sa2_pnp_driver);
 #endif
-	if (!cards) {
+
+	if (nr_cards == 0) {
 #ifdef MODULE
 		printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
+		pnp_unregister_driver(&snd_opl3sa2_pnp_driver);
 		return -ENODEV;
 	}
 	return 0;
-- 
function.linuxpower.ca
