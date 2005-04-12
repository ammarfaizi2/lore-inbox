Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVDLUK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVDLUK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVDLUID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:08:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:33480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262106AbVDLKbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:40 -0400
Message-Id: <200504121031.j3CAVQIT005312@shell0.pdx.osdl.net>
Subject: [patch 047/198] ppc64: very basic desktop g5 sound support
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch hacks the current PowerMac Alsa driver to add some basic support
of analog sound output to some desktop G5s.  It has severe limitations
though:

 - Only 44100Khz 16 bits
 - Only work on G5 models using a TAS3004 analog code, that is early
   single CPU desktops and all dual CPU desktops at this date, but none
   of the more recent ones like iMac G5.
 - It does analog only, no digital/SPDIF support at all, no native
   AC3 support

Better support would require a complete rewrite of the driver (which I am
working on, but don't hold your breath), to properly support the diversity
of apple sound HW setup, including dual codecs, several i2s busses, all the
new codecs used in the new machines, proper clock switching with digital,
etc etc etc...

This patch applies on top of the other PowerMac sound patches I posted in
the past couple of days (new powerbook support and sleep fixes).  

Note: This is a FAQ entry for PowerMac sound support with TI codecs: They
have a feature called "DRC" which is automatically enabled for the internal
speaker (at least when auto mute control is enabled) which will cause your
sound to fade out to nothing after half a second of playback if you don't
set a proper "DRC Range" in the mixer.  So if you have a problem like that,
check alsamixer and raise your DRC Range to something reasonable.

Note2: This patch will also add auto-mute of the speaker when line-out jack
is used on some earlier desktop G4s (and on the G5) in addition to the
headphone jack.  If that behaviour isn't what you want, just disable
auto-muting and use the manual mute controls in alsamixer.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/pmac_feature.c |    4 
 25-akpm/arch/ppc64/kernel/pmac_feature.c  |   29 +++
 25-akpm/include/asm-ppc/dbdma.h           |    2 
 25-akpm/include/asm-ppc/keylargo.h        |    5 
 25-akpm/sound/ppc/beep.c                  |   15 -
 25-akpm/sound/ppc/pmac.c                  |  177 +++++++++++++-------
 25-akpm/sound/ppc/pmac.h                  |    6 
 25-akpm/sound/ppc/tumbler.c               |  259 ++++++++++++++++++++++--------
 8 files changed, 360 insertions(+), 137 deletions(-)

diff -puN arch/ppc64/kernel/pmac_feature.c~ppc64-very-basic-desktop-g5-sound-support arch/ppc64/kernel/pmac_feature.c
--- 25/arch/ppc64/kernel/pmac_feature.c~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.712900200 -0700
+++ 25-akpm/arch/ppc64/kernel/pmac_feature.c	2005-04-12 03:21:14.726898072 -0700
@@ -64,8 +64,7 @@ static DEFINE_SPINLOCK(feature_lock  __p
  */
 struct macio_chip macio_chips[MAX_MACIO_CHIPS]  __pmacdata;
 
-struct macio_chip* __pmac
-macio_find(struct device_node* child, int type)
+struct macio_chip* __pmac macio_find(struct device_node* child, int type)
 {
 	while(child) {
 		int	i;
@@ -78,6 +77,7 @@ macio_find(struct device_node* child, in
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(macio_find);
 
 static const char* macio_names[] __pmacdata =
 {
@@ -250,6 +250,30 @@ static long __pmac g5_eth_phy_reset(stru
 	return 0;
 }
 
+static long __pmac g5_i2s_enable(struct device_node *node, long param, long value)
+{
+	/* Very crude implementation for now */
+	struct macio_chip* macio = &macio_chips[0];
+	unsigned long flags;
+
+	if (value == 0)
+		return 0; /* don't disable yet */
+
+	LOCK(flags);
+	MACIO_BIS(KEYLARGO_FCR3, KL3_CLK45_ENABLE | KL3_CLK49_ENABLE |
+		  KL3_I2S0_CLK18_ENABLE);
+	udelay(10);
+	MACIO_BIS(KEYLARGO_FCR1, K2_FCR1_I2S0_CELL_ENABLE |
+		  K2_FCR1_I2S0_CLK_ENABLE_BIT | K2_FCR1_I2S0_ENABLE);
+	udelay(10);
+	MACIO_BIC(KEYLARGO_FCR1, K2_FCR1_I2S0_RESET);
+	UNLOCK(flags);
+	udelay(10);
+
+	return 0;
+}
+
+
 #ifdef CONFIG_SMP
 static long __pmac g5_reset_cpu(struct device_node* node, long param, long value)
 {
@@ -337,6 +361,7 @@ static struct feature_table_entry g5_fea
 	{ PMAC_FTR_READ_GPIO,		g5_read_gpio },
 	{ PMAC_FTR_WRITE_GPIO,		g5_write_gpio },
 	{ PMAC_FTR_GMAC_PHY_RESET,	g5_eth_phy_reset },
+	{ PMAC_FTR_SOUND_CHIP_ENABLE,	g5_i2s_enable },
 #ifdef CONFIG_SMP
 	{ PMAC_FTR_RESET_CPU,		g5_reset_cpu },
 #endif /* CONFIG_SMP */
diff -puN arch/ppc/platforms/pmac_feature.c~ppc64-very-basic-desktop-g5-sound-support arch/ppc/platforms/pmac_feature.c
--- 25/arch/ppc/platforms/pmac_feature.c~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.714899896 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_feature.c	2005-04-12 03:21:14.728897768 -0700
@@ -74,8 +74,7 @@ static DEFINE_SPINLOCK(feature_lock  __p
  */
 struct macio_chip macio_chips[MAX_MACIO_CHIPS]  __pmacdata;
 
-struct macio_chip* __pmac
-macio_find(struct device_node* child, int type)
+struct macio_chip* __pmac macio_find(struct device_node* child, int type)
 {
 	while(child) {
 		int	i;
@@ -88,6 +87,7 @@ macio_find(struct device_node* child, in
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(macio_find);
 
 static const char* macio_names[] __pmacdata =
 {
diff -puN include/asm-ppc/dbdma.h~ppc64-very-basic-desktop-g5-sound-support include/asm-ppc/dbdma.h
--- 25/include/asm-ppc/dbdma.h~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.715899744 -0700
+++ 25-akpm/include/asm-ppc/dbdma.h	2005-04-12 03:21:14.728897768 -0700
@@ -88,7 +88,7 @@ struct dbdma_cmd {
 #define WAIT_ALWAYS	3	/* always wait */
 
 /* Align an address for a DBDMA command structure */
-#define DBDMA_ALIGN(x)	(((unsigned)(x) + sizeof(struct dbdma_cmd) - 1) \
+#define DBDMA_ALIGN(x)	(((unsigned long)(x) + sizeof(struct dbdma_cmd) - 1) \
 			 & -sizeof(struct dbdma_cmd))
 
 /* Useful macros */
diff -puN include/asm-ppc/keylargo.h~ppc64-very-basic-desktop-g5-sound-support include/asm-ppc/keylargo.h
--- 25/include/asm-ppc/keylargo.h~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.716899592 -0700
+++ 25-akpm/include/asm-ppc/keylargo.h	2005-04-12 03:21:14.729897616 -0700
@@ -228,6 +228,11 @@
 
 #define K2_FCR1_PCI1_BUS_RESET_N	0x00000010
 #define K2_FCR1_PCI1_SLEEP_RESET_EN	0x00000020
+#define K2_FCR1_I2S0_CELL_ENABLE	0x00000400
+#define K2_FCR1_I2S0_RESET		0x00000800
+#define K2_FCR1_I2S0_CLK_ENABLE_BIT	0x00001000
+#define K2_FCR1_I2S0_ENABLE    		0x00002000
+
 #define K2_FCR1_PCI1_CLK_ENABLE		0x00004000
 #define K2_FCR1_FW_CLK_ENABLE		0x00008000
 #define K2_FCR1_FW_RESET_N		0x00010000
diff -puN sound/ppc/beep.c~ppc64-very-basic-desktop-g5-sound-support sound/ppc/beep.c
--- 25/sound/ppc/beep.c~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.718899288 -0700
+++ 25-akpm/sound/ppc/beep.c	2005-04-12 03:21:14.729897616 -0700
@@ -24,6 +24,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include "pmac.h"
@@ -35,7 +37,7 @@ struct snd_pmac_beep {
 	int hz;
 	int nsamples;
 	short *buf;		/* allocated wave buffer */
-	unsigned long addr;	/* physical address of buffer */
+	dma_addr_t addr;	/* physical address of buffer */
 	struct input_dev dev;
 };
 
@@ -217,12 +219,8 @@ int __init snd_pmac_attach_beep(pmac_t *
 		return -ENOMEM;
 
 	memset(beep, 0, sizeof(*beep));
-	beep->buf = (short *) kmalloc(BEEP_BUFLEN * 4, GFP_KERNEL);
-	if (! beep->buf) {
-		kfree(beep);
-		return -ENOMEM;
-	}
-	beep->addr = virt_to_bus(beep->buf);
+	beep->buf = dma_alloc_coherent(&chip->pdev->dev, BEEP_BUFLEN * 4,
+					&beep->addr, GFP_KERNEL);
 
 	beep->dev.evbit[0] = BIT(EV_SND);
 	beep->dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
@@ -255,7 +253,8 @@ void snd_pmac_detach_beep(pmac_t *chip)
 {
 	if (chip->beep) {
 		input_unregister_device(&chip->beep->dev);
-		kfree(chip->beep->buf);
+		dma_free_coherent(&chip->pdev->dev, BEEP_BUFLEN * 4,
+				  chip->beep->buf, chip->beep->addr);
 		kfree(chip->beep);
 		chip->beep = NULL;
 	}
diff -puN sound/ppc/pmac.c~ppc64-very-basic-desktop-g5-sound-support sound/ppc/pmac.c
--- 25/sound/ppc/pmac.c~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.719899136 -0700
+++ 25-akpm/sound/ppc/pmac.c	2005-04-12 03:21:14.732897160 -0700
@@ -27,14 +27,13 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include "pmac.h"
 #include <sound/pcm_params.h>
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 #include <asm/pmac_feature.h>
-#else
-#include <asm/feature.h>
-#endif
+#include <asm/pci-bridge.h>
 
 
 #if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
@@ -57,22 +56,29 @@ static int tumbler_freqs[1] = {
 /*
  * allocate DBDMA command arrays
  */
-static int snd_pmac_dbdma_alloc(pmac_dbdma_t *rec, int size)
+static int snd_pmac_dbdma_alloc(pmac_t *chip, pmac_dbdma_t *rec, int size)
 {
-	rec->space = kmalloc(sizeof(struct dbdma_cmd) * (size + 1), GFP_KERNEL);
+	unsigned int rsize = sizeof(struct dbdma_cmd) * (size + 1);
+
+	rec->space = dma_alloc_coherent(&chip->pdev->dev, rsize,
+					&rec->dma_base, GFP_KERNEL);
 	if (rec->space == NULL)
 		return -ENOMEM;
 	rec->size = size;
-	memset(rec->space, 0, sizeof(struct dbdma_cmd) * (size + 1));
+	memset(rec->space, 0, rsize);
 	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
-	rec->addr = virt_to_bus(rec->cmds);
+	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
+
 	return 0;
 }
 
-static void snd_pmac_dbdma_free(pmac_dbdma_t *rec)
+static void snd_pmac_dbdma_free(pmac_t *chip, pmac_dbdma_t *rec)
 {
-	if (rec)
-		kfree(rec->space);
+	if (rec) {
+		unsigned int rsize = sizeof(struct dbdma_cmd) * (rec->size + 1);
+
+		dma_free_coherent(&chip->pdev->dev, rsize, rec->space, rec->dma_base);
+	}
 }
 
 
@@ -237,7 +243,7 @@ static int snd_pmac_pcm_prepare(pmac_t *
 	/* continuous DMA memory type doesn't provide the physical address,
 	 * so we need to resolve the address here...
 	 */
-	offset = virt_to_bus(runtime->dma_area);
+	offset = runtime->dma_addr;
 	for (i = 0, cp = rec->cmd.cmds; i < rec->nperiods; i++, cp++) {
 		st_le32(&cp->phy_addr, offset);
 		st_le16(&cp->req_count, rec->period_size);
@@ -664,8 +670,8 @@ int __init snd_pmac_pcm_new(pmac_t *chip
 	chip->capture.cur_freqs = chip->freqs_ok;
 
 	/* preallocate 64k buffer */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS, 
-					      snd_dma_continuous_data(GFP_KERNEL),
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      &chip->pdev->dev,
 					      64 * 1024, 64 * 1024);
 
 	return 0;
@@ -757,28 +763,10 @@ snd_pmac_ctrl_intr(int irq, void *devid,
 /*
  * a wrapper to feature call for compatibility
  */
-#if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
 static void snd_pmac_sound_feature(pmac_t *chip, int enable)
 {
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 	ppc_md.feature_call(PMAC_FTR_SOUND_CHIP_ENABLE, chip->node, 0, enable);
-#else
-	if (chip->is_pbook_G3) {
-		pmu_suspend();
-		feature_clear(chip->node, FEATURE_Sound_power);
-		feature_clear(chip->node, FEATURE_Sound_CLK_enable);
-		big_mdelay(1000); /* XXX */
-		pmu_resume();
-	}
-	if (chip->is_pbook_3400) {
-		feature_set(chip->node, FEATURE_IOBUS_enable);
-		udelay(10);
-	}
-#endif
 }
-#else /* CONFIG_PM && CONFIG_PMAC_PBOOK */
-#define snd_pmac_sound_feature(chip,enable) /**/
-#endif /* CONFIG_PM && CONFIG_PMAC_PBOOK */
 
 /*
  * release resources
@@ -786,8 +774,6 @@ static void snd_pmac_sound_feature(pmac_
 
 static int snd_pmac_free(pmac_t *chip)
 {
-	int i;
-
 	/* stop sounds */
 	if (chip->initialized) {
 		snd_pmac_dbdma_reset(chip);
@@ -813,9 +799,9 @@ static int snd_pmac_free(pmac_t *chip)
 		free_irq(chip->tx_irq, (void*)chip);
 	if (chip->rx_irq >= 0)
 		free_irq(chip->rx_irq, (void*)chip);
-	snd_pmac_dbdma_free(&chip->playback.cmd);
-	snd_pmac_dbdma_free(&chip->capture.cmd);
-	snd_pmac_dbdma_free(&chip->extra_dma);
+	snd_pmac_dbdma_free(chip, &chip->playback.cmd);
+	snd_pmac_dbdma_free(chip, &chip->capture.cmd);
+	snd_pmac_dbdma_free(chip, &chip->extra_dma);
 	if (chip->macio_base)
 		iounmap(chip->macio_base);
 	if (chip->latch_base)
@@ -826,12 +812,23 @@ static int snd_pmac_free(pmac_t *chip)
 		iounmap(chip->playback.dma);
 	if (chip->capture.dma)
 		iounmap(chip->capture.dma);
+#ifndef CONFIG_PPC64
 	if (chip->node) {
+		int i;
+
 		for (i = 0; i < 3; i++) {
-			if (chip->of_requested & (1 << i))
-				release_OF_resource(chip->node, i);
+			if (chip->of_requested & (1 << i)) {
+				if (chip->is_k2)
+					release_OF_resource(chip->node->parent,
+							    i);
+				else
+					release_OF_resource(chip->node, i);
+			}
 		}
 	}
+#endif /* CONFIG_PPC64 */
+	if (chip->pdev)
+		pci_dev_put(chip->pdev);
 	kfree(chip);
 	return 0;
 }
@@ -881,6 +878,8 @@ static int __init snd_pmac_detect(pmac_t
 {
 	struct device_node *sound;
 	unsigned int *prop, l;
+	struct macio_chip* macio;
+
 	u32 layout_id = 0;
 
 	if (_machine != _MACH_Pmac)
@@ -918,10 +917,17 @@ static int __init snd_pmac_detect(pmac_t
 	 * if we didn't find a davbus device, try 'i2s-a' since
 	 * this seems to be what iBooks have
 	 */
-	if (! chip->node)
+	if (! chip->node) {
 		chip->node = find_devices("i2s-a");
+		if (chip->node && chip->node->parent && chip->node->parent->parent) {
+			if (device_is_compatible(chip->node->parent->parent,
+						 "K2-Keylargo"))
+				chip->is_k2 = 1;
+		}
+	}
 	if (! chip->node)
 		return -ENODEV;
+
 	sound = find_devices("sound");
 	while (sound && sound->parent != chip->node)
 		sound = sound->next;
@@ -966,7 +972,8 @@ static int __init snd_pmac_detect(pmac_t
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
 	if (device_is_compatible(sound, "AOAKeylargo") ||
-	    device_is_compatible(sound, "AOAbase")) {
+	    device_is_compatible(sound, "AOAbase") ||
+	    device_is_compatible(sound, "AOAK2")) {
 		/* For now, only support very basic TAS3004 based machines with
 		 * single frequency until proper i2s control is implemented
 		 */
@@ -975,6 +982,7 @@ static int __init snd_pmac_detect(pmac_t
 		case 0x46:
 		case 0x33:
 		case 0x29:
+		case 0x24:
 			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
 			chip->model = PMAC_SNAPPER;
 			chip->can_byte_swap = 0; /* FIXME: check this */
@@ -987,6 +995,26 @@ static int __init snd_pmac_detect(pmac_t
 		chip->device_id = *prop;
 	chip->has_iic = (find_devices("perch") != NULL);
 
+	/* We need the PCI device for DMA allocations, let's use a crude method
+	 * for now ...
+	 */
+	macio = macio_find(chip->node, macio_unknown);
+	if (macio == NULL)
+		printk(KERN_WARNING "snd-powermac: can't locate macio !\n");
+	else {
+		struct pci_dev *pdev = NULL;
+
+		for_each_pci_dev(pdev) {
+			struct device_node *np = pci_device_to_OF_node(pdev);
+			if (np && np == macio->of_node) {
+				chip->pdev = pdev;
+				break;
+			}
+		}
+	}
+	if (chip->pdev == NULL)
+		printk(KERN_WARNING "snd-powermac: can't locate macio PCI device !\n");
+
 	detect_byte_swap(chip);
 
 	/* look for a property saying what sample rates
@@ -1091,8 +1119,10 @@ int __init snd_pmac_add_automute(pmac_t 
 	int err;
 	chip->auto_mute = 1;
 	err = snd_ctl_add(chip->card, snd_ctl_new1(&auto_mute_controls[0], chip));
-	if (err < 0)
+	if (err < 0) {
+		printk(KERN_ERR "snd-powermac: Failed to add automute control\n");
 		return err;
+	}
 	chip->hp_detect_ctl = snd_ctl_new1(&auto_mute_controls[1], chip);
 	return snd_ctl_add(chip->card, chip->hp_detect_ctl);
 }
@@ -1106,6 +1136,7 @@ int __init snd_pmac_new(snd_card_t *card
 	pmac_t *chip;
 	struct device_node *np;
 	int i, err;
+	unsigned long ctrl_addr, txdma_addr, rxdma_addr;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_pmac_dev_free,
 	};
@@ -1127,32 +1158,59 @@ int __init snd_pmac_new(snd_card_t *card
 	if ((err = snd_pmac_detect(chip)) < 0)
 		goto __error;
 
-	if (snd_pmac_dbdma_alloc(&chip->playback.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
-	    snd_pmac_dbdma_alloc(&chip->capture.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
-	    snd_pmac_dbdma_alloc(&chip->extra_dma, 2) < 0) {
+	if (snd_pmac_dbdma_alloc(chip, &chip->playback.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
+	    snd_pmac_dbdma_alloc(chip, &chip->capture.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
+	    snd_pmac_dbdma_alloc(chip, &chip->extra_dma, 2) < 0) {
 		err = -ENOMEM;
 		goto __error;
 	}
 
 	np = chip->node;
-	if (np->n_addrs < 3 || np->n_intrs < 3) {
-		err = -ENODEV;
-		goto __error;
-	}
+	if (chip->is_k2) {
+		if (np->parent->n_addrs < 2 || np->n_intrs < 3) {
+			err = -ENODEV;
+			goto __error;
+		}
+		for (i = 0; i < 2; i++) {
+#ifndef CONFIG_PPC64
+			static char *name[2] = { "- Control", "- DMA" };
+			if (! request_OF_resource(np->parent, i, name[i])) {
+				snd_printk(KERN_ERR "pmac: can't request resource %d!\n", i);
+				err = -ENODEV;
+				goto __error;
+			}
+			chip->of_requested |= (1 << i);
+#endif /* CONFIG_PPC64 */
+			ctrl_addr = np->parent->addrs[0].address;
+			txdma_addr = np->parent->addrs[1].address;
+			rxdma_addr = txdma_addr + 0x100;
+		}
 
-	for (i = 0; i < 3; i++) {
-		static char *name[3] = { NULL, "- Tx DMA", "- Rx DMA" };
-		if (! request_OF_resource(np, i, name[i])) {
-			snd_printk(KERN_ERR "pmac: can't request resource %d!\n", i);
+	} else {
+		if (np->n_addrs < 3 || np->n_intrs < 3) {
 			err = -ENODEV;
 			goto __error;
 		}
-		chip->of_requested |= (1 << i);
+
+		for (i = 0; i < 3; i++) {
+#ifndef CONFIG_PPC64
+			static char *name[3] = { "- Control", "- Tx DMA", "- Rx DMA" };
+			if (! request_OF_resource(np, i, name[i])) {
+				snd_printk(KERN_ERR "pmac: can't request resource %d!\n", i);
+				err = -ENODEV;
+				goto __error;
+			}
+			chip->of_requested |= (1 << i);
+#endif /* CONFIG_PPC64 */
+			ctrl_addr = np->addrs[0].address;
+			txdma_addr = np->addrs[1].address;
+			rxdma_addr = np->addrs[2].address;
+		}
 	}
 
-	chip->awacs = ioremap(np->addrs[0].address, 0x1000);
-	chip->playback.dma = ioremap(np->addrs[1].address, 0x100);
-	chip->capture.dma = ioremap(np->addrs[2].address, 0x100);
+	chip->awacs = ioremap(ctrl_addr, 0x1000);
+	chip->playback.dma = ioremap(txdma_addr, 0x100);
+	chip->capture.dma = ioremap(rxdma_addr, 0x100);
 	if (chip->model <= PMAC_BURGUNDY) {
 		if (request_irq(np->intrs[0].line, snd_pmac_ctrl_intr, 0,
 				"PMac", (void*)chip)) {
@@ -1180,7 +1238,8 @@ int __init snd_pmac_new(snd_card_t *card
 	snd_pmac_sound_feature(chip, 1);
 
 	/* reset */
-	out_le32(&chip->awacs->control, 0x11);
+	if (chip->model == PMAC_AWACS)
+		out_le32(&chip->awacs->control, 0x11);
 
 	/* Powerbooks have odd ways of enabling inputs such as
 	   an expansion-bay CD or sound from an internal modem
@@ -1232,6 +1291,8 @@ int __init snd_pmac_new(snd_card_t *card
 	return 0;
 
  __error:
+	if (chip->pdev)
+		pci_dev_put(chip->pdev);
 	snd_pmac_free(chip);
 	return err;
 }
diff -puN sound/ppc/pmac.h~ppc64-very-basic-desktop-g5-sound-support sound/ppc/pmac.h
--- 25/sound/ppc/pmac.h~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.720898984 -0700
+++ 25-akpm/sound/ppc/pmac.h	2005-04-12 03:21:14.733897008 -0700
@@ -60,7 +60,8 @@ typedef struct snd_pmac_dbdma pmac_dbdma
  * DBDMA space
  */
 struct snd_pmac_dbdma {
-	unsigned long addr;
+	dma_addr_t dma_base;
+	dma_addr_t addr;
 	struct dbdma_cmd __iomem *cmds;
 	void *space;
 	int size;
@@ -101,6 +102,7 @@ struct snd_pmac {
 
 	/* h/w info */
 	struct device_node *node;
+	struct pci_dev *pdev;
 	unsigned int revision;
 	unsigned int manufacturer;
 	unsigned int subframe;
@@ -110,6 +112,7 @@ struct snd_pmac {
 	unsigned int has_iic : 1;
 	unsigned int is_pbook_3400 : 1;
 	unsigned int is_pbook_G3 : 1;
+	unsigned int is_k2 : 1;
 
 	unsigned int can_byte_swap : 1;
 	unsigned int can_duplex : 1;
@@ -157,6 +160,7 @@ struct snd_pmac {
 	snd_kcontrol_t *speaker_sw_ctl;
 	snd_kcontrol_t *drc_sw_ctl;	/* only used for tumbler -ReneR */
 	snd_kcontrol_t *hp_detect_ctl;
+	snd_kcontrol_t *lineout_sw_ctl;
 
 	/* lowlevel callbacks */
 	void (*set_format)(pmac_t *chip);
diff -puN sound/ppc/tumbler.c~ppc64-very-basic-desktop-g5-sound-support sound/ppc/tumbler.c
--- 25/sound/ppc/tumbler.c~ppc64-very-basic-desktop-g5-sound-support	2005-04-12 03:21:14.722898680 -0700
+++ 25-akpm/sound/ppc/tumbler.c	2005-04-12 03:21:14.736896552 -0700
@@ -35,14 +35,19 @@
 #include <sound/core.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
+#include <asm/machdep.h>
 #include <asm/pmac_feature.h>
-#else
-#error old crap
-#endif
 #include "pmac.h"
 #include "tumbler_volume.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
 /* i2c address for tumbler */
 #define TAS_I2C_ADDR	0x34
 
@@ -78,21 +83,22 @@ enum {
 };
 
 typedef struct pmac_gpio {
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 	unsigned int addr;
-#else
-	void __iomem *addr;
-#endif
-	int active_state;
+	u8 active_val;
+	u8 inactive_val;
+	u8 active_state;
 } pmac_gpio_t;
 
 typedef struct pmac_tumbler_t {
 	pmac_keywest_t i2c;
 	pmac_gpio_t audio_reset;
 	pmac_gpio_t amp_mute;
+	pmac_gpio_t line_mute;
+	pmac_gpio_t line_detect;
 	pmac_gpio_t hp_mute;
 	pmac_gpio_t hp_detect;
 	int headphone_irq;
+	int lineout_irq;
 	unsigned int master_vol[2];
 	unsigned int save_master_switch[2];
 	unsigned int master_switch[2];
@@ -120,6 +126,7 @@ static int send_init_client(pmac_keywest
 							regs[0], regs[1]);
 			if (err >= 0)
 				break;
+			DBG("(W) i2c error %d\n", err);
 			mdelay(10);
 		} while (count--);
 		if (err < 0)
@@ -137,6 +144,7 @@ static int tumbler_init_client(pmac_keyw
 		TAS_REG_MCS, (1<<6)|(2<<4)|(2<<2)|0,
 		0, /* terminator */
 	};
+	DBG("(I) tumbler init client\n");
 	return send_init_client(i2c, regs);
 }
 
@@ -151,36 +159,27 @@ static int snapper_init_client(pmac_keyw
 		TAS_REG_ACS, 0,
 		0, /* terminator */
 	};
+	DBG("(I) snapper init client\n");
 	return send_init_client(i2c, regs);
 }
 	
 /*
  * gpio access
  */
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 #define do_gpio_write(gp, val) \
 	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, (gp)->addr, val)
 #define do_gpio_read(gp) \
 	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, (gp)->addr, 0)
 #define tumbler_gpio_free(gp) /* NOP */
-#else
-#define do_gpio_write(gp, val)	writeb(val, (gp)->addr)
-#define do_gpio_read(gp)	readb((gp)->addr)
-static inline void tumbler_gpio_free(pmac_gpio_t *gp)
-{
-	if (gp->addr) {
-		iounmap(gp->addr);
-		gp->addr = NULL;
-	}
-}
-#endif /* CONFIG_PPC_HAS_FEATURE_CALLS */
 
 static void write_audio_gpio(pmac_gpio_t *gp, int active)
 {
 	if (! gp->addr)
 		return;
-	active = active ? gp->active_state : !gp->active_state;
-	do_gpio_write(gp, active ? 0x05 : 0x04);
+	active = active ? gp->active_val : gp->inactive_val;
+
+	do_gpio_write(gp, active);
+	DBG("(I) gpio %x write %d\n", gp->addr, active);
 }
 
 static int read_audio_gpio(pmac_gpio_t *gp)
@@ -663,7 +662,7 @@ static int snapper_put_mix(snd_kcontrol_
  * to avoid codec reset on ibook M7
  */
 
-enum { TUMBLER_MUTE_HP, TUMBLER_MUTE_AMP };
+enum { TUMBLER_MUTE_HP, TUMBLER_MUTE_AMP, TUMBLER_MUTE_LINE };
 
 static int tumbler_get_mute_switch(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
@@ -672,7 +671,18 @@ static int tumbler_get_mute_switch(snd_k
 	pmac_gpio_t *gp;
 	if (! (mix = chip->mixer_data))
 		return -ENODEV;
-	gp = (kcontrol->private_value == TUMBLER_MUTE_HP) ? &mix->hp_mute : &mix->amp_mute;
+	switch(kcontrol->private_value) {
+	case TUMBLER_MUTE_HP:
+		gp = &mix->hp_mute;	break;
+	case TUMBLER_MUTE_AMP:
+		gp = &mix->amp_mute;	break;
+	case TUMBLER_MUTE_LINE:
+		gp = &mix->line_mute;	break;
+	default:
+		gp = NULL;
+	}
+	if (gp == NULL)
+		return -EINVAL;
 	ucontrol->value.integer.value[0] = ! read_audio_gpio(gp);
 	return 0;
 }
@@ -689,7 +699,18 @@ static int tumbler_put_mute_switch(snd_k
 #endif	
 	if (! (mix = chip->mixer_data))
 		return -ENODEV;
-	gp = (kcontrol->private_value == TUMBLER_MUTE_HP) ? &mix->hp_mute : &mix->amp_mute;
+	switch(kcontrol->private_value) {
+	case TUMBLER_MUTE_HP:
+		gp = &mix->hp_mute;	break;
+	case TUMBLER_MUTE_AMP:
+		gp = &mix->amp_mute;	break;
+	case TUMBLER_MUTE_LINE:
+		gp = &mix->line_mute;	break;
+	default:
+		gp = NULL;
+	}
+	if (gp == NULL)
+		return -EINVAL;
 	val = ! read_audio_gpio(gp);
 	if (val != ucontrol->value.integer.value[0]) {
 		write_audio_gpio(gp, ! ucontrol->value.integer.value[0]);
@@ -833,6 +854,14 @@ static snd_kcontrol_new_t tumbler_speake
 	.put = tumbler_put_mute_switch,
 	.private_value = TUMBLER_MUTE_AMP,
 };
+static snd_kcontrol_new_t tumbler_lineout_sw __initdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Line Out Playback Switch",
+	.info = snd_pmac_boolean_mono_info,
+	.get = tumbler_get_mute_switch,
+	.put = tumbler_put_mute_switch,
+	.private_value = TUMBLER_MUTE_LINE,
+};
 static snd_kcontrol_new_t tumbler_drc_sw __initdata = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DRC Switch",
@@ -849,7 +878,21 @@ static snd_kcontrol_new_t tumbler_drc_sw
 static int tumbler_detect_headphone(pmac_t *chip)
 {
 	pmac_tumbler_t *mix = chip->mixer_data;
-	return read_audio_gpio(&mix->hp_detect);
+	int detect = 0;
+
+	if (mix->hp_detect.addr)
+		detect |= read_audio_gpio(&mix->hp_detect);
+	return detect;
+}
+
+static int tumbler_detect_lineout(pmac_t *chip)
+{
+	pmac_tumbler_t *mix = chip->mixer_data;
+	int detect = 0;
+
+	if (mix->line_detect.addr)
+		detect |= read_audio_gpio(&mix->line_detect);
+	return detect;
 }
 
 static void check_mute(pmac_t *chip, pmac_gpio_t *gp, int val, int do_notify, snd_kcontrol_t *sw)
@@ -868,6 +911,7 @@ static void device_change_handler(void *
 {
 	pmac_t *chip = (pmac_t*) self;
 	pmac_tumbler_t *mix;
+	int headphone, lineout;
 
 	if (!chip)
 		return;
@@ -875,23 +919,35 @@ static void device_change_handler(void *
 	mix = chip->mixer_data;
 	snd_assert(mix, return);
 
-	if (tumbler_detect_headphone(chip)) {
-		/* mute speaker */
-		check_mute(chip, &mix->hp_mute, 0, mix->auto_mute_notify,
-			   chip->master_sw_ctl);
+	headphone = tumbler_detect_headphone(chip);
+	lineout = tumbler_detect_lineout(chip);
+
+	DBG("headphone: %d, lineout: %d\n", headphone, lineout);
+
+	if (headphone || lineout) {
+		/* unmute headphone/lineout & mute speaker */
+		if (headphone)
+			check_mute(chip, &mix->hp_mute, 0, mix->auto_mute_notify,
+				   chip->master_sw_ctl);
+		if (lineout && mix->line_mute.addr != 0)
+			check_mute(chip, &mix->line_mute, 0, mix->auto_mute_notify,
+				   chip->lineout_sw_ctl);
 		if (mix->anded_reset)
 			big_mdelay(10);
 		check_mute(chip, &mix->amp_mute, 1, mix->auto_mute_notify,
 			   chip->speaker_sw_ctl);
 		mix->drc_enable = 0;
 	} else {
-		/* unmute speaker */
+		/* unmute speaker, mute others */
 		check_mute(chip, &mix->amp_mute, 0, mix->auto_mute_notify,
 			   chip->speaker_sw_ctl);
 		if (mix->anded_reset)
 			big_mdelay(10);
 		check_mute(chip, &mix->hp_mute, 1, mix->auto_mute_notify,
 			   chip->master_sw_ctl);
+		if (mix->line_mute.addr != 0)
+			check_mute(chip, &mix->line_mute, 1, mix->auto_mute_notify,
+				   chip->lineout_sw_ctl);
 		mix->drc_enable = 1;
 	}
 	if (mix->auto_mute_notify) {
@@ -967,7 +1023,7 @@ static struct device_node *find_compatib
 }
 
 /* find an audio device and get its address */
-static long tumbler_find_device(const char *device, pmac_gpio_t *gp, int is_compatible)
+static long tumbler_find_device(const char *device, const char *platform, pmac_gpio_t *gp, int is_compatible)
 {
 	struct device_node *node;
 	u32 *base, addr;
@@ -977,6 +1033,7 @@ static long tumbler_find_device(const ch
 	else
 		node = find_audio_device(device);
 	if (! node) {
+		DBG("(W) cannot find audio device %s !\n", device);
 		snd_printdd("cannot find device %s\n", device);
 		return -ENODEV;
 	}
@@ -985,29 +1042,48 @@ static long tumbler_find_device(const ch
 	if (! base) {
 		base = (u32 *)get_property(node, "reg", NULL);
 		if (!base) {
+			DBG("(E) cannot find address for device %s !\n", device);
 			snd_printd("cannot find address for device %s\n", device);
 			return -ENODEV;
 		}
-		/* this only work if PPC_HAS_FEATURE_CALLS is set as we
-		 * are only getting the low part of the address
-		 */
 		addr = *base;
 		if (addr < 0x50)
 			addr += 0x50;
 	} else
 		addr = *base;
 
-#ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 	gp->addr = addr & 0x0000ffff;
-#else
-	gp->addr = ioremap((unsigned long)addr, 1);
-#endif
 	/* Try to find the active state, default to 0 ! */
 	base = (u32 *)get_property(node, "audio-gpio-active-state", NULL);
-	if (base)
+	if (base) {
 		gp->active_state = *base;
-	else
+		gp->active_val = (*base) ? 0x5 : 0x4;
+		gp->inactive_val = (*base) ? 0x4 : 0x5;
+	} else {
+		u32 *prop = NULL;
 		gp->active_state = 0;
+		gp->active_val = 0x4;
+		gp->inactive_val = 0x5;
+		/* Here are some crude hacks to extract the GPIO polarity and
+		 * open collector informations out of the do-platform script
+		 * as we don't yet have an interpreter for these things
+		 */
+		if (platform)
+			prop = (u32 *)get_property(node, platform, NULL);
+		if (prop) {
+			if (prop[3] == 0x9 && prop[4] == 0x9) {
+				gp->active_val = 0xd;
+				gp->inactive_val = 0xc;
+			}
+			if (prop[3] == 0x1 && prop[4] == 0x1) {
+				gp->active_val = 0x5;
+				gp->inactive_val = 0x4;
+			}
+		}
+	}
+
+	DBG("(I) GPIO device %s found, offset: %x, active state: %d !\n",
+	    device, gp->addr, gp->active_state);
 
 	return (node->n_intrs > 0) ? node->intrs[0].line : 0;
 }
@@ -1018,6 +1094,7 @@ static void tumbler_reset_audio(pmac_t *
 	pmac_tumbler_t *mix = chip->mixer_data;
 
 	if (mix->anded_reset) {
+		DBG("(I) codec anded reset !\n");
 		write_audio_gpio(&mix->hp_mute, 0);
 		write_audio_gpio(&mix->amp_mute, 0);
 		big_mdelay(200);
@@ -1028,6 +1105,8 @@ static void tumbler_reset_audio(pmac_t *
 		write_audio_gpio(&mix->amp_mute, 0);
 		big_mdelay(100);
 	} else {
+		DBG("(I) codec normal reset !\n");
+
 		write_audio_gpio(&mix->audio_reset, 0);
 		big_mdelay(200);
 		write_audio_gpio(&mix->audio_reset, 1);
@@ -1045,6 +1124,8 @@ static void tumbler_suspend(pmac_t *chip
 
 	if (mix->headphone_irq >= 0)
 		disable_irq(mix->headphone_irq);
+	if (mix->lineout_irq >= 0)
+		disable_irq(mix->lineout_irq);
 	mix->save_master_switch[0] = mix->master_switch[0];
 	mix->save_master_switch[1] = mix->master_switch[1];
 	mix->master_switch[0] = mix->master_switch[1] = 0;
@@ -1099,41 +1180,59 @@ static void tumbler_resume(pmac_t *chip)
 		chip->update_automute(chip, 0);
 	if (mix->headphone_irq >= 0)
 		enable_irq(mix->headphone_irq);
+	if (mix->lineout_irq >= 0)
+		enable_irq(mix->lineout_irq);
 }
 #endif
 
 /* initialize tumbler */
 static int __init tumbler_init(pmac_t *chip)
 {
-	int irq, err;
+	int irq;
 	pmac_tumbler_t *mix = chip->mixer_data;
 	snd_assert(mix, return -EINVAL);
 
-	if (tumbler_find_device("audio-hw-reset", &mix->audio_reset, 0) < 0)
-		tumbler_find_device("hw-reset", &mix->audio_reset, 1);
-	if (tumbler_find_device("amp-mute", &mix->amp_mute, 0) < 0)
-		tumbler_find_device("amp-mute", &mix->amp_mute, 1);
-	if (tumbler_find_device("headphone-mute", &mix->hp_mute, 0) < 0)
-		tumbler_find_device("headphone-mute", &mix->hp_mute, 1);
-	irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 0);
+	if (tumbler_find_device("audio-hw-reset",
+				"platform-do-hw-reset",
+				&mix->audio_reset, 0) < 0)
+		tumbler_find_device("hw-reset",
+				    "platform-do-hw-reset",
+				    &mix->audio_reset, 1);
+	if (tumbler_find_device("amp-mute",
+				"platform-do-amp-mute",
+				&mix->amp_mute, 0) < 0)
+		tumbler_find_device("amp-mute",
+				    "platform-do-amp-mute",
+				    &mix->amp_mute, 1);
+	if (tumbler_find_device("headphone-mute",
+				"platform-do-headphone-mute",
+				&mix->hp_mute, 0) < 0)
+		tumbler_find_device("headphone-mute",
+				    "platform-do-headphone-mute",
+				    &mix->hp_mute, 1);
+	if (tumbler_find_device("line-output-mute",
+				"platform-do-lineout-mute",
+				&mix->line_mute, 0) < 0)
+		tumbler_find_device("line-output-mute",
+				   "platform-do-lineout-mute",
+				    &mix->line_mute, 1);
+	irq = tumbler_find_device("headphone-detect",
+				  NULL, &mix->hp_detect, 0);
 	if (irq < 0)
-		irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 1);
+		irq = tumbler_find_device("headphone-detect",
+					  NULL, &mix->hp_detect, 1);
 	if (irq < 0)
-		irq = tumbler_find_device("keywest-gpio15", &mix->hp_detect, 1);
+		irq = tumbler_find_device("keywest-gpio15",
+					  NULL, &mix->hp_detect, 1);
+	mix->headphone_irq = irq;
+ 	irq = tumbler_find_device("line-output-detect",
+				  NULL, &mix->line_detect, 0);
+ 	if (irq < 0)
+		irq = tumbler_find_device("line-output-detect",
+					  NULL, &mix->line_detect, 1);
+	mix->lineout_irq = irq;
 
 	tumbler_reset_audio(chip);
-
-	/* activate headphone status interrupts */
-  	if (irq >= 0) {
-		unsigned char val;
-		if ((err = request_irq(irq, headphone_intr, 0,
-				       "Tumbler Headphone Detection", chip)) < 0)
-			return err;
-		/* activate headphone status interrupts */
-		val = do_gpio_read(&mix->hp_detect);
-		do_gpio_write(&mix->hp_detect, val | 0x80);
-	}
-	mix->headphone_irq = irq;
   
 	return 0;
 }
@@ -1146,6 +1245,8 @@ static void tumbler_cleanup(pmac_t *chip
 
 	if (mix->headphone_irq >= 0)
 		free_irq(mix->headphone_irq, chip);
+	if (mix->lineout_irq >= 0)
+		free_irq(mix->lineout_irq, chip);
 	tumbler_gpio_free(&mix->audio_reset);
 	tumbler_gpio_free(&mix->amp_mute);
 	tumbler_gpio_free(&mix->hp_mute);
@@ -1207,6 +1308,8 @@ int __init snd_pmac_tumbler_init(pmac_t 
 	else
 		mix->i2c.addr = TAS_I2C_ADDR;
 
+	DBG("(I) TAS i2c address is: %x\n", mix->i2c.addr);
+
 	if (chip->model == PMAC_TUMBLER) {
 		mix->i2c.init_client = tumbler_init_client;
 		mix->i2c.name = "TAS3001c";
@@ -1242,6 +1345,11 @@ int __init snd_pmac_tumbler_init(pmac_t 
 	chip->speaker_sw_ctl = snd_ctl_new1(&tumbler_speaker_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 		return err;
+	if (mix->line_mute.addr != 0) {
+		chip->lineout_sw_ctl = snd_ctl_new1(&tumbler_lineout_sw, chip);
+		if ((err = snd_ctl_add(chip->card, chip->lineout_sw_ctl)) < 0)
+			return err;
+	}
 	chip->drc_sw_ctl = snd_ctl_new1(&tumbler_drc_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->drc_sw_ctl)) < 0)
 		return err;
@@ -1254,11 +1362,32 @@ int __init snd_pmac_tumbler_init(pmac_t 
 	INIT_WORK(&device_change, device_change_handler, (void *)chip);
 
 #ifdef PMAC_SUPPORT_AUTOMUTE
-	if (mix->headphone_irq >=0 && (err = snd_pmac_add_automute(chip)) < 0)
+	if ((mix->headphone_irq >=0 || mix->lineout_irq >= 0)
+	    && (err = snd_pmac_add_automute(chip)) < 0)
 		return err;
 	chip->detect_headphone = tumbler_detect_headphone;
 	chip->update_automute = tumbler_update_automute;
 	tumbler_update_automute(chip, 0); /* update the status only */
+
+	/* activate headphone status interrupts */
+  	if (mix->headphone_irq >= 0) {
+		unsigned char val;
+		if ((err = request_irq(mix->headphone_irq, headphone_intr, 0,
+				       "Sound Headphone Detection", chip)) < 0)
+			return 0;
+		/* activate headphone status interrupts */
+		val = do_gpio_read(&mix->hp_detect);
+		do_gpio_write(&mix->hp_detect, val | 0x80);
+	}
+  	if (mix->lineout_irq >= 0) {
+		unsigned char val;
+		if ((err = request_irq(mix->lineout_irq, headphone_intr, 0,
+				       "Sound Lineout Detection", chip)) < 0)
+			return 0;
+		/* activate headphone status interrupts */
+		val = do_gpio_read(&mix->line_detect);
+		do_gpio_write(&mix->line_detect, val | 0x80);
+	}
 #endif
 
 	return 0;
_
