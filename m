Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTAQQRp>; Fri, 17 Jan 2003 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbTAQQRp>; Fri, 17 Jan 2003 11:17:45 -0500
Received: from [213.171.53.133] ([213.171.53.133]:28690 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267581AbTAQQRc>;
	Fri, 17 Jan 2003 11:17:32 -0500
Date: Fri, 17 Jan 2003 19:26:19 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: linux-kernel@vger.kernel.org, matt@mh.dropbear.id.au, ambx1@neo.rr.com
Subject: Re: ALSA and isapnp cards
In-Reply-To: <200301171447.h0HElsAR011463@ibe.miee.ru>
Message-ID: <Pine.BSF.4.05.10301171909150.71917-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Samium Gromoff wrote:

>        As of 2.5.58, and since no related changes were introduced, in 2.5.59
>  the build process of alsa/sb16pnp is broken.
> 
>        Obviously some callbacks are still unimplemented due to the 
>  transition to the new 2.5 isapnp subsystem.
> 
>        The thing which made me to write this, is the fact that the situation
>  persists since early 2.5.5x.
> 
>    (as of myself, it is the last thing which keeps me from using 2.5)
> 
> with regards and sincere hopes, Samium Gromoff

Hello Samium and other!
Here is patch against 2.5.59, can you try it?
And what card do you have SB16/SBAWE32 and pnp/not pnp?
I've try to test it as module and it works for me.
But PnP layer still have some bugs.
	Best regards, Ruslan.

PS: Samium, look at my e-mail :)

--- sound/isa/sb/sb16.c~	2003-01-15 01:27:44.000000000 +0300
+++ sound/isa/sb/sb16.c	2003-01-17 18:25:23.000000000 +0300
@@ -23,11 +23,7 @@
 #include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/sb16_csp.h>
@@ -77,7 +73,7 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260,0x280 */
@@ -106,7 +102,7 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable SoundBlaster 16 soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 MODULE_PARM(isapnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
 MODULE_PARM_SYNTAX(isapnp, SNDRV_ISAPNP_DESC);
@@ -150,164 +146,134 @@
 
 struct snd_sb16 {
 	struct resource *fm_res;	/* used to block FM i/o region for legacy cards */
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
+#ifdef CONFIG_PNP
+	struct pnp_dev *dev;
 #ifdef SNDRV_SBAWE_EMU8000
-	struct isapnp_dev *devwt;
+	struct pnp_dev *devwt;
 #endif
 #endif
 };
 
 static snd_card_t *snd_sb16_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-#ifdef __ISAPNP__
-
-static struct isapnp_card *snd_sb16_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_sb16_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#define ISAPNP_SB16(_va, _vb, _vc, _device, _audio) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
-	}
-#define ISAPNP_SBAWE(_va, _vb, _vc, _device, _audio, _awe) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _awe), } \
-	}
+#ifdef CONFIG_PNP
 
-static struct isapnp_card_id snd_sb16_pnpids[] __devinitdata = {
+static struct pnp_card *snd_sb16_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+static const struct pnp_card_device_id *snd_sb16_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+static struct pnpc_driver sb16_pnpc_driver;
+static struct pnp_card_device_id snd_sb16_pnpids[] = {
 #ifndef SNDRV_SBAWE
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0024,0x0031),
+	{.id = "CTL0024", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0025,0x0031),
+	{.id = "CTL0025", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0026,0x0031),
+	{.id = "CTL0026", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0027,0x0031),
+	{.id = "CTL0027", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0028,0x0031),
+	{.id = "CTL0028", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0029,0x0031),
+	{.id = "CTL0029", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002a,0x0031),
+	{.id = "CTL002a", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SB16('C','T','L',0x002b,0x0031),
+	/* Note: This card has also a CTL0051:StereoEnhance devsice!!! */
+	{.id = "CTL002b", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002c,0x0031),	
+	{.id = "CTL002c", .driver_data=0, .devs = { {.id="CTL0031"}, }},
 	/* Sound Blaster Vibra16S */
-	ISAPNP_SB16('C','T','L',0x0051,0x0001),
+	{.id = "CTL0051", .driver_data=0, .devs = { {.id="CTL0001"}, }},
 	/* Sound Blaster Vibra16C */
-	ISAPNP_SB16('C','T','L',0x0070,0x0001),
+	{.id = "CTL0070", .driver_data=0, .devs = { {.id="CTL0001"}, }},
 	/* Sound Blaster Vibra16CL - added by ctm@ardi.com */
-	ISAPNP_SB16('C','T','L',0x0080,0x0041),
+	{.id = "CTL0080", .driver_data=0, .devs = { {.id="CTL0041"}, }},
 	/* Sound Blaster Vibra16X */
-	ISAPNP_SB16('C','T','L',0x00f0,0x0043),
+	{.id = "CTL00f0", .driver_data=0, .devs = { {.id="CTL0043"}, }}
 #else  /* SNDRV_SBAWE defined */
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0035,0x0031,0x0021),
+	{.id = "CTL0035", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0039,0x0031,0x0021),
+	{.id = "CTL0039", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0042,0x0031,0x0021),
+	{.id = "CTL0042", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0043,0x0031,0x0021),
+	{.id = "CTL0043", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0044,0x0031,0x0021),
+	/* Note: This card has also a CTL0051:StereoEnhance devsice!!! */
+	{.id = "CTL0044", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0045,0x0031,0x0021),
+	/* Note: This card has also a CTL0051:StereoEnhance devsice!!! */
+	{.id = "CTL0045", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0046,0x0031,0x0021),
+	{.id = "CTL0046", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0047,0x0031,0x0021),
+	{.id = "CTL0047", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0048,0x0031,0x0021),
+	{.id = "CTL0048", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0054,0x0031,0x0021),
+	{.id = "CTL0054", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009a,0x0041,0x0021),
+	{.id = "CTL009a", .driver_data=0, .devs = { {.id="CTL0041"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009c,0x0041,0x0021),
+	{.id = "CTL009c", .driver_data=0, .devs = { {.id="CTL0041"}, {.id="CTL0021"}, }},
 	/* Sound Blaster 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009f,0x0041,0x0021),
+	{.id = "CTL009f", .driver_data=0, .devs = { {.id="CTL0041"}, {.id="CTL0021"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009d,0x0042,0x0022),
+	{.id = "CTL009d", .driver_data=0, .devs = { {.id="CTL0042"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x009e,0x0044,0x0023),
+	{.id = "CTL009e", .driver_data=0, .devs = { {.id="CTL0044"}, {.id="CTL0023"}, }},
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x00b2,0x0044,0x0023),
+	{.id = "CTL00b2", .driver_data=0, .devs = { {.id="CTL0044"}, {.id="CTL0023"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c1,0x0042,0x0022),
+	{.id = "CTL00c1", .driver_data=0, .devs = { {.id="CTL0042"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c3,0x0045,0x0022),
+	{.id = "CTL00c3", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c5,0x0045,0x0022),
+	{.id = "CTL00c5", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c7,0x0045,0x0022),
+	{.id = "CTL00c7", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e4,0x0045,0x0022),
+	{.id = "CTL00e4", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e9,0x0045,0x0022),
-	/* Sound Blaster 16 PnP (AWE) */
-	ISAPNP_SBAWE('C','T','L',0x00ed,0x0041,0x0070),
+	{.id = "CTL00e9", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
+	/* Sound Blaster 16 PnP (AWE} */
+	{.id = "CTL00ed", .driver_data=0, .devs = { {.id="CTL0041"}, {.id="CTL0070"}, }},
 	/* Generic entries */
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0031,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0041,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0042,0x0022),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0044,0x0023),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0045,0x0022),
+	{.id = "CTLXXXX", .driver_data=0, .devs = { {.id="CTL0031"}, {.id="CTL0021"}, }},
+	{.id = "CTLXXXX", .driver_data=0, .devs = { {.id="CTL0041"}, {.id="CTL0021"}, }},
+	{.id = "CTLXXXX", .driver_data=0, .devs = { {.id="CTL0042"}, {.id="CTL0022"}, }},
+	{.id = "CTLXXXX", .driver_data=0, .devs = { {.id="CTL0044"}, {.id="CTL0023"}, }},
+	{.id = "CTLXXXX", .driver_data=0, .devs = { {.id="CTL0045"}, {.id="CTL0022"}, }},
 #endif /* SNDRV_SBAWE */
-	{ ISAPNP_CARD_END, }
+	{.id="", }
 };
 
-ISAPNP_CARD_TABLE(snd_sb16_pnpids);
+/*ISAPNP_CARD_TABLE(snd_sb16_pnpids);*/
+MODULE_DEVICE_TABLE(pnp_card,snd_sb16_pnpids);
 
 static int __init snd_sb16_isapnp(int dev, struct snd_sb16 *acard)
 {
-	const struct isapnp_card_id *id = snd_sb16_isapnp_id[dev];
-	struct isapnp_card *card = snd_sb16_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (acard->dev->active) {
-		acard->dev = NULL;
-		return -EBUSY;
+	const struct pnp_card_device_id *id = snd_sb16_isapnp_id[dev];
+	struct pnp_card *card = snd_sb16_isapnp_cards[dev];
+	struct pnp_dev *pdev;
+
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (!acard->dev) {
+		printk(KERN_ERR PFX "isapnp configure failure Audio(no device or busy)\n");
+		return -ENODEV;
 	}
 #ifdef SNDRV_SBAWE_EMU8000
-	acard->devwt = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, NULL);
-	if (acard->devwt->active) {
-		acard->dev = acard->devwt = NULL;
-		return -EBUSY;
+	acard->devwt = pnp_request_card_device(card, id->devs[1].id, NULL);
+	if (!acard->devwt) {
+		printk(KERN_ERR PFX "isapnp configure failure WaveTable(no device or busy)\n");
+		return -ENODEV;
 	}
 #endif	
-	/* Audio initialization */
 	pdev = acard->dev;
-	if (pdev->prepare(pdev) < 0)
-		return -EAGAIN;
-	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[1], mpu_port[dev], 2);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[2], fm_port[dev], 4);
-	if (dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev], 1);
-	if (dma16[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma16[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-	if (pdev->activate(pdev) < 0) {
-		printk(KERN_ERR PFX "isapnp configure failure (out of resources?)\n");
-		return -EBUSY;
-	}
-	port[dev] = pdev->resource[0].start;
-	mpu_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
+	port[dev] = pdev->io_resource[0].start;
+	mpu_port[dev] = pdev->io_resource[1].start;
+	fm_port[dev] = pdev->io_resource[2].start;
 	dma8[dev] = pdev->dma_resource[0].start;
 	dma16[dev] = pdev->dma_resource[1].start;
 	irq[dev] = pdev->irq_resource[0].start;
@@ -318,41 +284,12 @@
 #ifdef SNDRV_SBAWE_EMU8000
 	/* WaveTable initialization */
 	pdev = acard->devwt;
-	if (pdev->prepare(pdev)<0) {
-		acard->dev->deactivate(acard->dev);
-		return -EAGAIN;
-	}
-	if (awe_port[dev] != SNDRV_AUTO_PORT) {
-		isapnp_resource_change(&pdev->resource[0], awe_port[dev], 4);
-		isapnp_resource_change(&pdev->resource[1], awe_port[dev] + 0x400, 4);
-		isapnp_resource_change(&pdev->resource[2], awe_port[dev] + 0x800, 4);
-	}
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "WaveTable isapnp configure failure (out of resources?)\n");
-		acard->dev->deactivate(acard->dev);		
-		return -EBUSY;
-	}
-	awe_port[dev] = pdev->resource[0].start;
-	snd_printdd("isapnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+	awe_port[dev] = pdev->io_resource[0].start;
+	snd_printdd("isapnp SB16: wavetable port=0x%lx\n", awe_port[dev]);
 #endif
 	return 0;
 }
-
-static void snd_sb16_deactivate(struct snd_sb16 *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev = NULL;
-	}
-#ifdef SNDRV_SBAWE_EMU8000
-	if (acard->devwt) {
-		acard->devwt->deactivate(acard->devwt);
-		acard->devwt = NULL;
-	}
-#endif
-}
-
-#endif /* __ISAPNP__ */
+#endif /* CONFIG_PNP */
 
 static void snd_sb16_free(snd_card_t *card)
 {
@@ -364,8 +301,9 @@
 		release_resource(acard->fm_res);
 		kfree_nocheck(acard->fm_res);
 	}
-#ifdef __ISAPNP__
-	snd_sb16_deactivate(acard);
+#ifdef CONFIG_PNP
+	acard->devwt=NULL;
+	acard->dev=NULL;
 #endif
 }
 
@@ -392,7 +330,7 @@
 		return -ENOMEM;
 	acard = (struct snd_sb16 *) card->private_data;
 	card->private_free = snd_sb16_free;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (isapnp[dev] && snd_sb16_isapnp(dev, acard) < 0) {
 		snd_card_free(card);
 		return -EBUSY;
@@ -402,7 +340,7 @@
 	xirq = irq[dev];
 	xdma8 = dma8[dev];
 	xdma16 = dma16[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev]) {
 #endif
 	if (xirq == SNDRV_AUTO_IRQ) {
@@ -434,7 +372,7 @@
 	/* non-PnP AWE port address is hardwired with base port address */
 	awe_port[dev] = port[dev] + 0x400;
 #endif
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	}
 #endif
 
@@ -455,7 +393,7 @@
 		return -ENODEV;
 	}
 	chip->mpu_port = mpu_port[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev] && (err = snd_sb16dsp_configure(chip)) < 0) {
 #else
 	if ((err = snd_sb16dsp_configure(chip)) < 0) {
@@ -563,7 +501,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] != SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
@@ -576,10 +514,10 @@
 	return -ENODEV;
 }
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 
-static int __init snd_sb16_isapnp_detect(struct isapnp_card *card,
-					 const struct isapnp_card_id *id)
+static int __init snd_sb16_isapnp_detect(struct pnp_card *card,
+					 const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
@@ -599,7 +537,26 @@
 	return -ENODEV;
 }
 
-#endif /* __ISAPNP__ */
+static void snd_sb16_isapnp_remove(struct pnp_card * card)
+{
+	/*FIX ME*/
+	int dev;
+
+	for (dev = 0; dev < SNDRV_CARDS; dev++)
+		snd_card_free(snd_sb16_cards[dev]);
+}
+
+static struct pnpc_driver sb16_pnpc_driver = {
+#ifndef SNDRV_SBAWE
+	.name		= "sb16",
+#else
+	.name		= "sbawe",
+#endif
+	.id_table	= snd_sb16_pnpids,
+	.probe		= snd_sb16_isapnp_detect,
+	.remove		= snd_sb16_isapnp_remove
+};
+#endif /* CONFIG_PNP */
 
 static int __init alsa_card_sb16_init(void)
 {
@@ -610,7 +567,7 @@
 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] == SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
@@ -624,9 +581,9 @@
 	}
 	/* legacy auto configured cards */
 	cards += snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	/* ISA PnP cards at last */
-	cards += isapnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
+	cards += pnpc_register_driver(&sb16_pnpc_driver);
 #endif
 
 	if (!cards) {
@@ -645,10 +602,14 @@
 
 static void __exit alsa_card_sb16_exit(void)
 {
+#ifdef CONFIG_PNP
+	pnpc_unregister_driver(&sb16_pnpc_driver);
+#else
 	int dev;
 
 	for (dev = 0; dev < SNDRV_CARDS; dev++)
 		snd_card_free(snd_sb16_cards[dev]);
+#endif
 }
 
 module_init(alsa_card_sb16_init)
@@ -691,7 +652,7 @@
 	       get_option(&str,&seq_ports[nr_dev]) == 2
 #endif
 	       );
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (pnp != INT_MAX)
 		isapnp[nr_dev] = pnp;
 #endif
--- drivers/pnp/driver.c~	2003-01-17 18:08:00.000000000 +0300
+++ drivers/pnp/driver.c	2003-01-17 18:08:15.000000000 +0300
@@ -37,7 +37,7 @@
 
 int compare_pnp_id(struct pnp_id *pos, const char *id)
 {
-	if (!pos || !id || (strlen(id) != 7))
+	if (!pos || !id)
 		return 0;
 	if (memcmp(id,"ANYDEVS",7)==0)
 		return 1;
________________________________________________


