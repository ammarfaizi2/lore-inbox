Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUFHVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUFHVfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbUFHVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:34:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265339AbUFHVZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:25:07 -0400
Date: Wed, 9 Jun 2004 00:25:06 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082125.i58LP6Fw016218@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (6/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in linux/sound/pci/ with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 ac97/ac97_codec.c      |    8 ++++----
 ac97/ac97_pcm.c        |    2 +-
 ac97/ak4531_codec.c    |    4 ++--
 ali5451/ali5451.c      |    4 ++--
 atiixp.c               |    4 ++--
 au88x0/au88x0.c        |    4 ++--
 azt3328.c              |    4 ++--
 bt87x.c                |    4 ++--
 cmipci.c               |    4 ++--
 cs4281.c               |    4 ++--
 cs46xx/cs46xx_lib.c    |   12 +++++-------
 emu10k1/emu10k1_main.c |    6 +++---
 emu10k1/emufx.c        |   12 ++++++------
 emu10k1/emupcm.c       |   14 +++++++-------
 ens1370.c              |    4 ++--
 es1938.c               |    4 ++--
 es1968.c               |   14 +++++++-------
 fm801.c                |    4 ++--
 ice1712/aureon.c       |    2 +-
 ice1712/ice1712.c      |    4 ++--
 ice1712/ice1724.c      |    4 ++--
 ice1712/prodigy.c      |    2 +-
 ice1712/revo.c         |    2 +-
 intel8x0.c             |    4 ++--
 intel8x0m.c            |    4 ++--
 korg1212/korg1212.c    |    4 ++--
 maestro3.c             |    6 +++---
 mixart/mixart.c        |    8 ++++----
 nm256/nm256.c          |    4 ++--
 sonicvibes.c           |    4 ++--
 trident/trident_main.c |    6 +++---
 via82xx.c              |    4 ++--
 vx222/vx222.c          |    2 +-
 ymfpci/ymfpci_main.c   |   10 +++++-----
 34 files changed, 90 insertions(+), 92 deletions(-)

diff -X dontdiff -purN linux-2.6.6/sound/pci/ac97/ac97_codec.c alsa-2.6.6/sound/pci/ac97/ac97_codec.c
--- linux-2.6.6/sound/pci/ac97/ac97_codec.c	2004-06-08 23:57:20.288361832 +0300
+++ alsa-2.6.6/sound/pci/ac97/ac97_codec.c	2004-06-08 23:35:50.142493816 +0300
@@ -995,7 +995,7 @@ static int snd_ac97_bus_free(ac97_bus_t 
 			kfree(bus->pcms);
 		if (bus->private_free)
 			bus->private_free(bus);
-		snd_magic_kfree(bus);
+		kfree(bus);
 	}
 	return 0;
 }
@@ -1014,7 +1014,7 @@ static int snd_ac97_free(ac97_t *ac97)
 			ac97->bus->codec[ac97->num] = NULL;
 		if (ac97->private_free)
 			ac97->private_free(ac97);
-		snd_magic_kfree(ac97);
+		kfree(ac97);
 	}
 	return 0;
 }
@@ -1677,7 +1677,7 @@ int snd_ac97_bus(snd_card_t * card, ac97
 
 	snd_assert(card != NULL, return -EINVAL);
 	snd_assert(_bus != NULL && rbus != NULL, return -EINVAL);
-	bus = snd_magic_kmalloc(ac97_bus_t, 0, GFP_KERNEL);
+	bus = kmalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return -ENOMEM;
 	*bus = *_bus;
@@ -1732,7 +1732,7 @@ int snd_ac97_mixer(ac97_bus_t * bus, ac9
 	snd_assert(bus != NULL && _ac97 != NULL, return -EINVAL);
 	snd_assert(_ac97->num < 4 && bus->codec[_ac97->num] == NULL, return -EINVAL);
 	card = bus->card;
-	ac97 = snd_magic_kmalloc(ac97_t, 0, GFP_KERNEL);
+	ac97 = kmalloc(sizeof(*ac97), GFP_KERNEL);
 	if (ac97 == NULL)
 		return -ENOMEM;
 	*ac97 = *_ac97;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ac97/ac97_pcm.c alsa-2.6.6/sound/pci/ac97/ac97_pcm.c
--- linux-2.6.6/sound/pci/ac97/ac97_pcm.c	2004-06-08 23:57:20.316357576 +0300
+++ alsa-2.6.6/sound/pci/ac97/ac97_pcm.c	2004-06-05 20:35:56.000000000 +0300
@@ -430,7 +430,7 @@ int snd_ac97_pcm_assign(ac97_bus_t *bus,
 	unsigned int rates;
 	ac97_t *codec;
 
-	rpcms = snd_kcalloc(sizeof(struct ac97_pcm) * pcms_count, GFP_KERNEL);
+	rpcms = kcalloc(sizeof(struct ac97_pcm) * pcms_count, GFP_KERNEL);
 	if (rpcms == NULL)
 		return -ENOMEM;
 	memset(avail_slots, 0, sizeof(avail_slots));
diff -X dontdiff -purN linux-2.6.6/sound/pci/ac97/ak4531_codec.c alsa-2.6.6/sound/pci/ac97/ak4531_codec.c
--- linux-2.6.6/sound/pci/ac97/ak4531_codec.c	2004-06-08 23:57:20.248367912 +0300
+++ alsa-2.6.6/sound/pci/ac97/ak4531_codec.c	2004-06-05 20:36:03.000000000 +0300
@@ -315,7 +315,7 @@ static int snd_ak4531_free(ak4531_t *ak4
 	if (ak4531) {
 		if (ak4531->private_free)
 			ak4531->private_free(ak4531);
-		snd_magic_kfree(ak4531);
+		kfree(ak4531);
 	}
 	return 0;
 }
@@ -367,7 +367,7 @@ int snd_ak4531_mixer(snd_card_t * card, 
 	snd_assert(rak4531 != NULL, return -EINVAL);
 	*rak4531 = NULL;
 	snd_assert(card != NULL && _ak4531 != NULL, return -EINVAL);
-	ak4531 = snd_magic_kcalloc(ak4531_t, 0, GFP_KERNEL);
+	ak4531 = kcalloc(sizeof(*ak4531), GFP_KERNEL);
 	if (ak4531 == NULL)
 		return -ENOMEM;
 	*ak4531 = *_ak4531;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ali5451/ali5451.c alsa-2.6.6/sound/pci/ali5451/ali5451.c
--- linux-2.6.6/sound/pci/ali5451/ali5451.c	2004-06-08 23:57:21.207222144 +0300
+++ alsa-2.6.6/sound/pci/ali5451/ali5451.c	2004-06-05 20:36:54.000000000 +0300
@@ -2008,7 +2008,7 @@ static int snd_ali_free(ali_t * codec)
 	if (codec->image)
 		kfree(codec->image);
 #endif
-	snd_magic_kfree(codec);
+	kfree(codec);
 	return 0;
 }
 
@@ -2113,7 +2113,7 @@ static int __devinit snd_ali_create(snd_
 		return -ENXIO;
 	}
 
-	if ((codec = snd_magic_kcalloc(ali_t, 0, GFP_KERNEL)) == NULL)
+	if ((codec = kcalloc(sizeof(*codec), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
 	spin_lock_init(&codec->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/atiixp.c alsa-2.6.6/sound/pci/atiixp.c
--- linux-2.6.6/sound/pci/atiixp.c	2004-06-08 23:57:21.443186272 +0300
+++ alsa-2.6.6/sound/pci/atiixp.c	2004-06-06 19:51:58.000000000 +0300
@@ -1380,7 +1380,7 @@ static int snd_atiixp_free(atiixp_t *chi
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1406,7 +1406,7 @@ static int __devinit snd_atiixp_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(atiixp_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/au88x0/au88x0.c alsa-2.6.6/sound/pci/au88x0/au88x0.c
--- linux-2.6.6/sound/pci/au88x0/au88x0.c	2004-06-08 23:57:21.469182320 +0300
+++ alsa-2.6.6/sound/pci/au88x0/au88x0.c	2004-06-06 19:52:11.000000000 +0300
@@ -139,7 +139,7 @@ static int snd_vortex_dev_free(snd_devic
 	free_irq(vortex->irq, vortex);
 	pci_release_regions(vortex->pci_dev);
 	pci_disable_device(vortex->pci_dev);
-	snd_magic_kfree(vortex);
+	kfree(vortex);
 
 	return 0;
 }
@@ -166,7 +166,7 @@ snd_vortex_create(snd_card_t * card, str
 	}
 	pci_set_dma_mask(pci, VORTEX_DMA_MASK);
 
-	chip = snd_magic_kcalloc(vortex_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/azt3328.c alsa-2.6.6/sound/pci/azt3328.c
--- linux-2.6.6/sound/pci/azt3328.c	2004-06-08 23:57:20.801283856 +0300
+++ alsa-2.6.6/sound/pci/azt3328.c	2004-06-06 19:52:25.000000000 +0300
@@ -1305,7 +1305,7 @@ static int snd_azf3328_free(azf3328_t *c
         if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 
-        snd_magic_kfree(chip);
+        kfree(chip);
         return 0;
 }
 
@@ -1353,7 +1353,7 @@ static int __devinit snd_azf3328_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(azf3328_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/bt87x.c alsa-2.6.6/sound/pci/bt87x.c
--- linux-2.6.6/sound/pci/bt87x.c	2004-06-08 23:57:21.426188856 +0300
+++ alsa-2.6.6/sound/pci/bt87x.c	2004-06-06 19:52:38.000000000 +0300
@@ -660,7 +660,7 @@ static int snd_bt87x_free(bt87x_t *chip)
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -704,7 +704,7 @@ static int __devinit snd_bt87x_create(sn
 	if (err < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(bt87x_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 	chip->card = card;
diff -X dontdiff -purN linux-2.6.6/sound/pci/cmipci.c alsa-2.6.6/sound/pci/cmipci.c
--- linux-2.6.6/sound/pci/cmipci.c	2004-06-08 23:57:20.917266224 +0300
+++ alsa-2.6.6/sound/pci/cmipci.c	2004-06-06 19:56:19.000000000 +0300
@@ -2950,7 +2950,7 @@ static int snd_cmipci_free(cmipci_t *cm)
 		release_resource(cm->res_iobase);
 		kfree_nocheck(cm->res_iobase);
 	}
-	snd_magic_kfree(cm);
+	kfree(cm);
 	return 0;
 }
 
@@ -2978,7 +2978,7 @@ static int __devinit snd_cmipci_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	cm = snd_magic_kcalloc(cmipci_t, 0, GFP_KERNEL);
+	cm = kcalloc(sizeof(*cm), GFP_KERNEL);
 	if (cm == NULL)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/cs4281.c alsa-2.6.6/sound/pci/cs4281.c
--- linux-2.6.6/sound/pci/cs4281.c	2004-06-08 23:57:21.220220168 +0300
+++ alsa-2.6.6/sound/pci/cs4281.c	2004-06-08 21:44:19.000000000 +0300
@@ -1383,7 +1383,7 @@ static int snd_cs4281_free(cs4281_t *chi
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1413,7 +1413,7 @@ static int __devinit snd_cs4281_create(s
 	*rchip = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	chip = snd_magic_kcalloc(cs4281_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/cs46xx/cs46xx_lib.c alsa-2.6.6/sound/pci/cs46xx/cs46xx_lib.c
--- linux-2.6.6/sound/pci/cs46xx/cs46xx_lib.c	2004-06-08 23:57:20.014403480 +0300
+++ alsa-2.6.6/sound/pci/cs46xx/cs46xx_lib.c	2004-06-08 21:47:17.000000000 +0300
@@ -1383,9 +1383,7 @@ static snd_pcm_hw_constraint_list_t hw_c
 static void snd_cs46xx_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
 	cs46xx_pcm_t * cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return);
-	
-	if (cpcm)
-		snd_magic_kfree(cpcm);
+	kfree(cpcm);
 }
 
 static int _cs46xx_playback_open_channel (snd_pcm_substream_t * substream,int pcm_channel_id)
@@ -1394,11 +1392,11 @@ static int _cs46xx_playback_open_channel
 	cs46xx_pcm_t * cpcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	cpcm = snd_magic_kcalloc(cs46xx_pcm_t, 0, GFP_KERNEL);
+	cpcm = kcalloc(sizeof(*cpcm), GFP_KERNEL);
 	if (cpcm == NULL)
 		return -ENOMEM;
 	if (snd_dma_alloc_pages(&chip->dma_dev, PAGE_SIZE, &cpcm->hw_buf) < 0) {
-		snd_magic_kfree(cpcm);
+		kfree(cpcm);
 		return -ENOMEM;
 	}
 
@@ -3011,7 +3009,7 @@ static int snd_cs46xx_free(cs46xx_t *chi
 	}
 #endif
 	
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -3886,7 +3884,7 @@ int __devinit snd_cs46xx_create(snd_card
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(cs46xx_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/emu10k1/emu10k1_main.c alsa-2.6.6/sound/pci/emu10k1/emu10k1_main.c
--- linux-2.6.6/sound/pci/emu10k1/emu10k1_main.c	2004-06-08 23:57:19.876424456 +0300
+++ alsa-2.6.6/sound/pci/emu10k1/emu10k1_main.c	2004-06-08 23:39:41.691293048 +0300
@@ -561,7 +561,7 @@ static int snd_emu10k1_free(emu10k1_t *e
 	}
 	if (emu->irq >= 0)
 		free_irq(emu->irq, (void *)emu);
-	snd_magic_kfree(emu);
+	kfree(emu);
 	return 0;
 }
 
@@ -595,7 +595,7 @@ int __devinit snd_emu10k1_create(snd_car
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	emu = snd_magic_kcalloc(emu10k1_t, 0, GFP_KERNEL);
+	emu = kcalloc(sizeof(*emu), GFP_KERNEL);
 	if (emu == NULL)
 		return -ENOMEM;
 	/* set the DMA transfer mask */
@@ -603,7 +603,7 @@ int __devinit snd_emu10k1_create(snd_car
 	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
 	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
 		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
-		snd_magic_kfree(emu);
+		kfree(emu);
 		return -ENXIO;
 	}
 	emu->card = card;
diff -X dontdiff -purN linux-2.6.6/sound/pci/emu10k1/emufx.c alsa-2.6.6/sound/pci/emu10k1/emufx.c
--- linux-2.6.6/sound/pci/emu10k1/emufx.c	2004-06-08 23:57:19.841429776 +0300
+++ alsa-2.6.6/sound/pci/emu10k1/emufx.c	2004-06-05 20:26:38.000000000 +0300
@@ -1257,9 +1257,9 @@ static int __devinit _snd_emu10k1_audigy
 	spin_lock_init(&emu->fx8010.irq_lock);
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
 
-	if ((icode = snd_kcalloc(sizeof(emu10k1_fx8010_code_t), GFP_KERNEL)) == NULL)
+	if ((icode = kcalloc(sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	if ((controls = snd_kcalloc(sizeof(emu10k1_fx8010_control_gpr_t) * SND_EMU10K1_GPR_CONTROLS, GFP_KERNEL)) == NULL) {
+	if ((controls = kcalloc(sizeof(emu10k1_fx8010_control_gpr_t) * SND_EMU10K1_GPR_CONTROLS, GFP_KERNEL)) == NULL) {
 		kfree(icode);
 		return -ENOMEM;
 	}
@@ -1669,13 +1669,13 @@ static int __devinit _snd_emu10k1_init_e
 	spin_lock_init(&emu->fx8010.irq_lock);
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
 
-	if ((icode = snd_kcalloc(sizeof(emu10k1_fx8010_code_t), GFP_KERNEL)) == NULL)
+	if ((icode = kcalloc(sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	if ((controls = snd_kcalloc(sizeof(emu10k1_fx8010_control_gpr_t) * SND_EMU10K1_GPR_CONTROLS, GFP_KERNEL)) == NULL) {
+	if ((controls = kcalloc(sizeof(emu10k1_fx8010_control_gpr_t) * SND_EMU10K1_GPR_CONTROLS, GFP_KERNEL)) == NULL) {
 		kfree(icode);
 		return -ENOMEM;
 	}
-	if ((ipcm = snd_kcalloc(sizeof(emu10k1_fx8010_pcm_t), GFP_KERNEL)) == NULL) {
+	if ((ipcm = kcalloc(sizeof(*ipcm), GFP_KERNEL)) == NULL) {
 		kfree(controls);
 		kfree(icode);
 		return -ENOMEM;
@@ -2354,7 +2354,7 @@ static int snd_emu10k1_fx8010_ioctl(snd_
 	case SNDRV_EMU10K1_IOCTL_PCM_PEEK:
 		if (emu->audigy)
 			return -EINVAL;
-		ipcm = (emu10k1_fx8010_pcm_t *)snd_kcalloc(sizeof(*ipcm), GFP_KERNEL);
+		ipcm = kcalloc(sizeof(*ipcm), GFP_KERNEL);
 		if (ipcm == NULL)
 			return -ENOMEM;
 		if (copy_from_user(ipcm, (void *)arg, sizeof(*ipcm))) {
diff -X dontdiff -purN linux-2.6.6/sound/pci/emu10k1/emupcm.c alsa-2.6.6/sound/pci/emu10k1/emupcm.c
--- linux-2.6.6/sound/pci/emu10k1/emupcm.c	2004-06-08 23:57:19.725447408 +0300
+++ alsa-2.6.6/sound/pci/emu10k1/emupcm.c	2004-06-05 21:02:53.000000000 +0300
@@ -770,7 +770,7 @@ static void snd_emu10k1_pcm_free_substre
 	emu10k1_pcm_t *epcm = snd_magic_cast(emu10k1_pcm_t, runtime->private_data, return);
 
 	if (epcm)
-		snd_magic_kfree(epcm);
+		kfree(epcm);
 }
 
 static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
@@ -781,7 +781,7 @@ static int snd_emu10k1_playback_open(snd
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int i, err;
 
-	epcm = snd_magic_kcalloc(emu10k1_pcm_t, 0, GFP_KERNEL);
+	epcm = kcalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -791,11 +791,11 @@ static int snd_emu10k1_playback_open(snd
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_playback;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
-		snd_magic_kfree(epcm);
+		kfree(epcm);
 		return err;
 	}
 	if ((err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 256, UINT_MAX)) < 0) {
-		snd_magic_kfree(epcm);
+		kfree(epcm);
 		return err;
 	}
 	mix = &emu->pcm_mixer[substream->number];
@@ -826,7 +826,7 @@ static int snd_emu10k1_capture_open(snd_
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_t *epcm;
 
-	epcm = snd_magic_kcalloc(emu10k1_pcm_t, 0, GFP_KERNEL);
+	epcm = kcalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -862,7 +862,7 @@ static int snd_emu10k1_capture_mic_open(
 	emu10k1_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	epcm = snd_magic_kcalloc(emu10k1_pcm_t, 0, GFP_KERNEL);
+	epcm = kcalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -903,7 +903,7 @@ static int snd_emu10k1_capture_efx_open(
 	int nefx = emu->audigy ? 64 : 32;
 	int idx;
 
-	epcm = snd_magic_kcalloc(emu10k1_pcm_t, 0, GFP_KERNEL);
+	epcm = kcalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ens1370.c alsa-2.6.6/sound/pci/ens1370.c
--- linux-2.6.6/sound/pci/ens1370.c	2004-06-08 23:57:21.139232480 +0300
+++ alsa-2.6.6/sound/pci/ens1370.c	2004-06-06 19:57:33.000000000 +0300
@@ -1840,7 +1840,7 @@ static int snd_ensoniq_free(ensoniq_t *e
 	}
 	if (ensoniq->irq >= 0)
 		free_irq(ensoniq->irq, (void *)ensoniq);
-	snd_magic_kfree(ensoniq);
+	kfree(ensoniq);
 	return 0;
 }
 
@@ -1893,7 +1893,7 @@ static int __devinit snd_ensoniq_create(
 	*rensoniq = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	ensoniq = snd_magic_kcalloc(ensoniq_t, 0, GFP_KERNEL);
+	ensoniq = kcalloc(sizeof(*ensoniq), GFP_KERNEL);
 	if (ensoniq == NULL)
 		return -ENOMEM;
 	spin_lock_init(&ensoniq->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/es1938.c alsa-2.6.6/sound/pci/es1938.c
--- linux-2.6.6/sound/pci/es1938.c	2004-06-08 23:57:21.073242512 +0300
+++ alsa-2.6.6/sound/pci/es1938.c	2004-06-06 22:23:26.000000000 +0300
@@ -1369,7 +1369,7 @@ static int snd_es1938_free(es1938_t *chi
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1401,7 +1401,7 @@ static int __devinit snd_es1938_create(s
                 return -ENXIO;
         }
 
-	chip = snd_magic_kcalloc(es1938_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/es1968.c alsa-2.6.6/sound/pci/es1968.c
--- linux-2.6.6/sound/pci/es1968.c	2004-06-08 23:57:21.077241904 +0300
+++ alsa-2.6.6/sound/pci/es1968.c	2004-06-06 22:23:15.000000000 +0300
@@ -1622,7 +1622,7 @@ static int snd_es1968_playback_open(snd_
 	if (apu1 < 0)
 		return apu1;
 
-	es = snd_magic_kcalloc(esschan_t, 0, GFP_KERNEL);
+	es = kcalloc(sizeof(*es), GFP_KERNEL);
 	if (!es) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		return -ENOMEM;
@@ -1668,7 +1668,7 @@ static int snd_es1968_capture_open(snd_p
 		return apu2;
 	}
 	
-	es = snd_magic_kcalloc(esschan_t, 0, GFP_KERNEL);
+	es = kcalloc(sizeof(*es), GFP_KERNEL);
 	if (!es) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		snd_es1968_free_apu_pair(chip, apu2);
@@ -1691,7 +1691,7 @@ static int snd_es1968_capture_open(snd_p
 	if ((es->mixbuf = snd_es1968_new_memory(chip, ESM_MIXBUF_SIZE)) == NULL) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		snd_es1968_free_apu_pair(chip, apu2);
-		snd_magic_kfree(es);
+		kfree(es);
                 return -ENOMEM;
         }
 	memset(es->mixbuf->buf, 0, ESM_MIXBUF_SIZE);
@@ -1724,7 +1724,7 @@ static int snd_es1968_playback_close(snd
 	list_del(&es->list);
 	spin_unlock_irqrestore(&chip->substream_lock, flags);
 	snd_es1968_free_apu_pair(chip, es->apu[0]);
-	snd_magic_kfree(es);
+	free(es);
 
 	return 0;
 }
@@ -1744,7 +1744,7 @@ static int snd_es1968_capture_close(snd_
 	snd_es1968_free_memory(chip, es->mixbuf);
 	snd_es1968_free_apu_pair(chip, es->apu[0]);
 	snd_es1968_free_apu_pair(chip, es->apu[2]);
-	snd_magic_kfree(es);
+	kfree(es);
 
 	return 0;
 }
@@ -2518,7 +2518,7 @@ static int snd_es1968_free(es1968_t *chi
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -2571,7 +2571,7 @@ static int __devinit snd_es1968_create(s
 		return -ENXIO;
 	}
 
-	chip = (es1968_t *) snd_magic_kcalloc(es1968_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/fm801.c alsa-2.6.6/sound/pci/fm801.c
--- linux-2.6.6/sound/pci/fm801.c	2004-06-08 23:57:21.122235064 +0300
+++ alsa-2.6.6/sound/pci/fm801.c	2004-06-06 22:22:37.000000000 +0300
@@ -1251,7 +1251,7 @@ static int snd_fm801_free(fm801_t *chip)
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1278,7 +1278,7 @@ static int __devinit snd_fm801_create(sn
 	*rchip = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	chip = snd_magic_kcalloc(fm801_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/ice1712/aureon.c alsa-2.6.6/sound/pci/ice1712/aureon.c
--- linux-2.6.6/sound/pci/ice1712/aureon.c	2004-06-08 23:57:19.437491184 +0300
+++ alsa-2.6.6/sound/pci/ice1712/aureon.c	2004-06-05 20:39:07.000000000 +0300
@@ -418,7 +418,7 @@ static int __devinit aureon_init(ice1712
 	}
 
 	/* to remeber the register values */
-	ice->akm = snd_kcalloc(sizeof(akm4xxx_t), GFP_KERNEL);
+	ice->akm = kcalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ice1712/ice1712.c alsa-2.6.6/sound/pci/ice1712/ice1712.c
--- linux-2.6.6/sound/pci/ice1712/ice1712.c	2004-06-08 23:57:19.436491336 +0300
+++ alsa-2.6.6/sound/pci/ice1712/ice1712.c	2004-06-08 23:42:53.014207544 +0300
@@ -2395,7 +2395,7 @@ static int snd_ice1712_free(ice1712_t *i
 		kfree_nocheck(ice->res_profi_port);
 	}
 	snd_ice1712_akm4xxx_free(ice);
-	snd_magic_kfree(ice);
+	kfree(ice);
 	return 0;
 }
 
@@ -2429,7 +2429,7 @@ static int __devinit snd_ice1712_create(
 		return -ENXIO;
 	}
 
-	ice = snd_magic_kcalloc(ice1712_t, 0, GFP_KERNEL);
+	ice = kcalloc(sizeof(*ice), GFP_KERNEL);
 	if (ice == NULL)
 		return -ENOMEM;
 	ice->omni = omni ? 1 : 0;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ice1712/ice1724.c alsa-2.6.6/sound/pci/ice1712/ice1724.c
--- linux-2.6.6/sound/pci/ice1712/ice1724.c	2004-06-08 23:57:19.488483432 +0300
+++ alsa-2.6.6/sound/pci/ice1712/ice1724.c	2004-06-08 23:41:40.763191368 +0300
@@ -1915,7 +1915,7 @@ static int snd_vt1724_free(ice1712_t *ic
 		kfree_nocheck(ice->res_profi_port);
 	}
 	snd_ice1712_akm4xxx_free(ice);
-	snd_magic_kfree(ice);
+	kfree(ice);
 	return 0;
 }
 
@@ -1942,7 +1942,7 @@ static int __devinit snd_vt1724_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	ice = snd_magic_kcalloc(ice1712_t, 0, GFP_KERNEL);
+	ice = kcalloc(sizeof(*ice), GFP_KERNEL);
 	if (ice == NULL)
 		return -ENOMEM;
 	ice->vt1724 = 1;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ice1712/prodigy.c alsa-2.6.6/sound/pci/ice1712/prodigy.c
--- linux-2.6.6/sound/pci/ice1712/prodigy.c	2004-06-08 23:57:19.543475072 +0300
+++ alsa-2.6.6/sound/pci/ice1712/prodigy.c	2004-06-05 20:40:04.000000000 +0300
@@ -588,7 +588,7 @@ static int __devinit prodigy_init(ice171
 	ice->num_total_adcs = 8;
 
 	/* to remeber the register values */
-	ice->akm = snd_kcalloc(sizeof(akm4xxx_t), GFP_KERNEL);
+	ice->akm = kcalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
diff -X dontdiff -purN linux-2.6.6/sound/pci/ice1712/revo.c alsa-2.6.6/sound/pci/ice1712/revo.c
--- linux-2.6.6/sound/pci/ice1712/revo.c	2004-06-08 23:57:19.502481304 +0300
+++ alsa-2.6.6/sound/pci/ice1712/revo.c	2004-06-05 20:39:00.000000000 +0300
@@ -136,7 +136,7 @@ static int __devinit revo_init(ice1712_t
 	}
 
 	/* second stage of initialization, analog parts and others */
-	ak = ice->akm = snd_kcalloc(sizeof(akm4xxx_t) * 2, GFP_KERNEL);
+	ak = ice->akm = kcalloc(sizeof(akm4xxx_t) * 2, GFP_KERNEL);
 	if (! ak)
 		return -ENOMEM;
 	ice->akm_codecs = 2;
diff -X dontdiff -purN linux-2.6.6/sound/pci/intel8x0.c alsa-2.6.6/sound/pci/intel8x0.c
--- linux-2.6.6/sound/pci/intel8x0.c	2004-06-08 23:57:20.894269720 +0300
+++ alsa-2.6.6/sound/pci/intel8x0.c	2004-06-06 22:22:27.000000000 +0300
@@ -2176,7 +2176,7 @@ static int snd_intel8x0_free(intel8x0_t 
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -2436,7 +2436,7 @@ static int __devinit snd_intel8x0_create
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(intel8x0_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/intel8x0m.c alsa-2.6.6/sound/pci/intel8x0m.c
--- linux-2.6.6/sound/pci/intel8x0m.c	2004-06-08 23:57:21.525173808 +0300
+++ alsa-2.6.6/sound/pci/intel8x0m.c	2004-06-06 22:22:18.000000000 +0300
@@ -1073,7 +1073,7 @@ static int snd_intel8x0_free(intel8x0_t 
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	snd_magic_kfree(chip);
+	free(chip);
 	return 0;
 }
 
@@ -1211,7 +1211,7 @@ static int __devinit snd_intel8x0m_creat
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(intel8x0_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/korg1212/korg1212.c alsa-2.6.6/sound/pci/korg1212/korg1212.c
--- linux-2.6.6/sound/pci/korg1212/korg1212.c	2004-06-08 23:57:20.164380680 +0300
+++ alsa-2.6.6/sound/pci/korg1212/korg1212.c	2004-06-08 23:44:12.614106520 +0300
@@ -2170,7 +2170,7 @@ snd_korg1212_free(korg1212_t *korg1212)
 		korg1212->dma_shared.area = NULL;
         }
         
-        snd_magic_kfree(korg1212);
+        kfree(korg1212);
         return 0;
 }
 
@@ -2200,7 +2200,7 @@ static int __devinit snd_korg1212_create
         if ((err = pci_enable_device(pci)) < 0)
                 return err;
 
-        korg1212 = snd_magic_kcalloc(korg1212_t, 0, GFP_KERNEL);
+        korg1212 = kcalloc(sizeof(*korg1212), GFP_KERNEL);
         if (korg1212 == NULL)
                 return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/maestro3.c alsa-2.6.6/sound/pci/maestro3.c
--- linux-2.6.6/sound/pci/maestro3.c	2004-06-08 23:57:20.811282336 +0300
+++ alsa-2.6.6/sound/pci/maestro3.c	2004-06-08 21:48:18.000000000 +0300
@@ -2401,7 +2401,7 @@ static int snd_m3_free(m3_t *chip)
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -2554,7 +2554,7 @@ snd_m3_create(snd_card_t *card, struct p
 		return -ENXIO;
 	}
 
-	chip = snd_magic_kcalloc(m3_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
@@ -2597,7 +2597,7 @@ snd_m3_create(snd_card_t *card, struct p
 	chip->num_substreams = NR_DSPS;
 	chip->substreams = kmalloc(sizeof(m3_dma_t) * chip->num_substreams, GFP_KERNEL);
 	if (chip->substreams == NULL) {
-		snd_magic_kfree(chip);
+		kfree(chip);
 		return -ENOMEM;
 	}
 	memset(chip->substreams, 0, sizeof(m3_dma_t) * chip->num_substreams);
diff -X dontdiff -purN linux-2.6.6/sound/pci/mixart/mixart.c alsa-2.6.6/sound/pci/mixart/mixart.c
--- linux-2.6.6/sound/pci/mixart/mixart.c	2004-06-08 23:57:21.707146144 +0300
+++ alsa-2.6.6/sound/pci/mixart/mixart.c	2004-06-06 22:21:41.000000000 +0300
@@ -978,7 +978,7 @@ static int snd_mixart_pcm_digital(mixart
 
 static int snd_mixart_chip_free(mixart_t *chip)
 {
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -999,7 +999,7 @@ static int __devinit snd_mixart_create(m
 		.dev_free = snd_mixart_chip_dev_free,
 	};
 
-	mgr->chip[idx] = chip = snd_magic_kcalloc(mixart_t, 0, GFP_KERNEL);
+	mgr->chip[idx] = chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
 		snd_printk(KERN_ERR "cannot allocate chip\n");
 		return -ENOMEM;
@@ -1090,7 +1090,7 @@ static int snd_mixart_free(mixart_mgr_t 
 		mgr->bufferinfo.area = NULL;
 	}
 
-	snd_magic_kfree(mgr);
+	kfree(mgr);
 	return 0;
 }
 
@@ -1296,7 +1296,7 @@ static int __devinit snd_mixart_probe(st
 
 	/*
 	 */
-	mgr = snd_magic_kcalloc(mixart_mgr_t, 0, GFP_KERNEL);
+	mgr = kcalloc(sizeof(*mgr), GFP_KERNEL);
 	if (! mgr)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/nm256/nm256.c alsa-2.6.6/sound/pci/nm256/nm256.c
--- linux-2.6.6/sound/pci/nm256/nm256.c	2004-06-08 23:57:20.699299360 +0300
+++ alsa-2.6.6/sound/pci/nm256/nm256.c	2004-06-06 22:21:25.000000000 +0300
@@ -1372,7 +1372,7 @@ static int snd_nm256_free(nm256_t *chip)
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1400,7 +1400,7 @@ snd_nm256_create(snd_card_t *card, struc
 
 	*chip_ret = NULL;
 
-	chip = snd_magic_kcalloc(nm256_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/sonicvibes.c alsa-2.6.6/sound/pci/sonicvibes.c
--- linux-2.6.6/sound/pci/sonicvibes.c	2004-06-08 23:57:21.121235216 +0300
+++ alsa-2.6.6/sound/pci/sonicvibes.c	2004-06-06 22:21:15.000000000 +0300
@@ -1222,7 +1222,7 @@ static int snd_sonicvibes_free(sonicvibe
 	}
 	if (sonic->irq >= 0)
 		free_irq(sonic->irq, (void *)sonic);
-	snd_magic_kfree(sonic);
+	kfree(sonic);
 	return 0;
 }
 
@@ -1256,7 +1256,7 @@ static int __devinit snd_sonicvibes_crea
                 return -ENXIO;
         }
 
-	sonic = snd_magic_kcalloc(sonicvibes_t, 0, GFP_KERNEL);
+	sonic = kcalloc(sizeof(*sonic), GFP_KERNEL);
 	if (sonic == NULL)
 		return -ENOMEM;
 	spin_lock_init(&sonic->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/pci/trident/trident_main.c alsa-2.6.6/sound/pci/trident/trident_main.c
--- linux-2.6.6/sound/pci/trident/trident_main.c	2004-06-08 23:57:19.642460024 +0300
+++ alsa-2.6.6/sound/pci/trident/trident_main.c	2004-06-08 23:46:41.776430400 +0300
@@ -2967,7 +2967,7 @@ static int __devinit snd_trident_mixer(t
 	snd_ctl_elem_value_t *uctl;
 	int idx, err, retries = 2;
 
-	uctl = (snd_ctl_elem_value_t *)snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return -ENOMEM;
 
@@ -3552,7 +3552,7 @@ int __devinit snd_trident_create(snd_car
 		return -ENXIO;
 	}
 	
-	trident = snd_magic_kcalloc(trident_t, 0, GFP_KERNEL);
+	trident = kcalloc(sizeof(*trident), GFP_KERNEL);
 	if (trident == NULL)
 		return -ENOMEM;
 	trident->device = (pci->vendor << 16) | pci->device;
@@ -3704,7 +3704,7 @@ int snd_trident_free(trident_t *trident)
 		release_resource(trident->res_port);
 		kfree_nocheck(trident->res_port);
 	}
-	snd_magic_kfree(trident);
+	kfree(trident);
 	return 0;
 }
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/via82xx.c alsa-2.6.6/sound/pci/via82xx.c
--- linux-2.6.6/sound/pci/via82xx.c	2004-06-08 23:57:21.165228528 +0300
+++ alsa-2.6.6/sound/pci/via82xx.c	2004-06-06 22:21:06.000000000 +0300
@@ -1897,7 +1897,7 @@ static int snd_via82xx_free(via82xx_t *c
 		pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, chip->old_legacy);
 		pci_write_config_byte(chip->pci, VIA_PNP_CONTROL, chip->old_legacy_cfg);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1923,7 +1923,7 @@ static int __devinit snd_via82xx_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	if ((chip = snd_magic_kcalloc(via82xx_t, 0, GFP_KERNEL)) == NULL)
+	if ((chip = kcalloc(sizeof(*chip), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
 	chip->chip_type = chip_type;
diff -X dontdiff -purN linux-2.6.6/sound/pci/vx222/vx222.c alsa-2.6.6/sound/pci/vx222/vx222.c
--- linux-2.6.6/sound/pci/vx222/vx222.c	2004-06-08 23:57:19.959411840 +0300
+++ alsa-2.6.6/sound/pci/vx222/vx222.c	2004-06-05 21:25:06.000000000 +0300
@@ -129,7 +129,7 @@ static int snd_vx222_free(vx_core_t *chi
 			kfree_nocheck(vx->port_res[i]);
 		}
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
diff -X dontdiff -purN linux-2.6.6/sound/pci/ymfpci/ymfpci_main.c alsa-2.6.6/sound/pci/ymfpci/ymfpci_main.c
--- linux-2.6.6/sound/pci/ymfpci/ymfpci_main.c	2004-06-08 23:57:20.604313800 +0300
+++ alsa-2.6.6/sound/pci/ymfpci/ymfpci_main.c	2004-06-08 23:47:53.404541272 +0300
@@ -833,7 +833,7 @@ static void snd_ymfpci_pcm_free_substrea
 	ymfpci_pcm_t *ypcm = snd_magic_cast(ymfpci_pcm_t, runtime->private_data, return);
 	
 	if (ypcm)
-		snd_magic_kfree(ypcm);
+		kfree(ypcm);
 }
 
 static int snd_ymfpci_playback_open_1(snd_pcm_substream_t * substream)
@@ -842,7 +842,7 @@ static int snd_ymfpci_playback_open_1(sn
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	ymfpci_pcm_t *ypcm;
 
-	ypcm = snd_magic_kcalloc(ymfpci_pcm_t, 0, GFP_KERNEL);
+	ypcm = kcalloc(sizeof(*ypcm), GFP_KERNEL);
 	if (ypcm == NULL)
 		return -ENOMEM;
 	ypcm->chip = chip;
@@ -958,7 +958,7 @@ static int snd_ymfpci_capture_open(snd_p
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	ymfpci_pcm_t *ypcm;
 
-	ypcm = snd_magic_kcalloc(ymfpci_pcm_t, 0, GFP_KERNEL);
+	ypcm = kcalloc(sizeof(*ypcm), GFP_KERNEL);
 	if (ypcm == NULL)
 		return -ENOMEM;
 	ypcm->chip = chip;
@@ -2117,7 +2117,7 @@ static int snd_ymfpci_free(ymfpci_t *chi
 
 	pci_write_config_word(chip->pci, 0x40, chip->old_legacy_ctrl);
 	
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -2245,7 +2245,7 @@ int __devinit snd_ymfpci_create(snd_card
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = snd_magic_kcalloc(ymfpci_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->old_legacy_ctrl = old_legacy_ctrl;
