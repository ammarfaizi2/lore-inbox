Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUCOT1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUCOT1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:27:41 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:11484 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262676AbUCOT1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:24 -0500
Date: Mon, 15 Mar 2004 19:27:06 GMT
Message-Id: <200403151927.i2FJR64Q015682@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][1/6] gusextreme error path cleanups.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst chasing an oops, I shortened some error paths.
(Also sets card to NULL when something goes wrong).

		Dave

--- linux-2.6.4/sound/isa/gus/gusextreme.c~	2004-03-15 16:35:51.000000000 +0000
+++ linux-2.6.4/sound/isa/gus/gusextreme.c	2004-03-15 16:42:48.000000000 +0000
@@ -210,7 +210,7 @@
 	snd_gus_card_t *gus;
 	es1688_t *es1688;
 	opl3_t *opl3;
-	int err;
+	int err=0;
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
@@ -220,17 +220,17 @@
 	xgf1_irq = gf1_irq[dev];
 	if (xgf1_irq == SNDRV_AUTO_IRQ) {
 		if ((xgf1_irq = snd_legacy_find_free_irq(possible_gf1_irqs)) < 0) {
-			snd_card_free(card);
 			snd_printk("unable to find a free IRQ for GF1\n");
-			return -EBUSY;
+			err = -EBUSY;
+			goto out;
 		}
 	}
 	xess_irq = irq[dev];
 	if (xess_irq == SNDRV_AUTO_IRQ) {
 		if ((xess_irq = snd_legacy_find_free_irq(possible_ess_irqs)) < 0) {
-			snd_card_free(card);
 			snd_printk("unable to find a free IRQ for ES1688\n");
-			return -EBUSY;
+			err = -EBUSY;
+			goto out;
 		}
 	}
 	if (mpu_port[dev] == SNDRV_AUTO_PORT)
@@ -241,25 +241,24 @@
 	xgf1_dma = dma1[dev];
 	if (xgf1_dma == SNDRV_AUTO_DMA) {
 		if ((xgf1_dma = snd_legacy_find_free_dma(possible_gf1_dmas)) < 0) {
-			snd_card_free(card);
 			snd_printk("unable to find a free DMA for GF1\n");
-			return -EBUSY;
+			err = -EBUSY;
+			goto out;
 		}
 	}
 	xess_dma = dma8[dev];
 	if (xess_dma == SNDRV_AUTO_DMA) {
 		if ((xess_dma = snd_legacy_find_free_dma(possible_ess_dmas)) < 0) {
-			snd_card_free(card);
 			snd_printk("unable to find a free DMA for ES1688\n");
-			return -EBUSY;
+			err = -EBUSY;
+			goto out;
 		}
 	}
 
 	if ((err = snd_es1688_create(card, port[dev], mpu_port[dev],
 				     xess_irq, xmpu_irq, xess_dma,
 				     ES1688_HW_1688, &es1688)) < 0) {
-		snd_card_free(card);
-		return err;
+		goto out;
 	}
 	if (gf1_port[dev] < 0)
 		gf1_port[dev] = port[dev] + 0x20;
@@ -270,56 +269,44 @@
 				  -1,
 				  0, channels[dev],
 				  pcm_channels[dev], 0,
-				  &gus)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_gusextreme_detect(dev, card, gus, es1688)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+				  &gus)) < 0)
+		goto out;
+
+	if ((err = snd_gusextreme_detect(dev, card, gus, es1688)) < 0)
+		goto out;
+
 	snd_gusextreme_init(dev, gus);
-	if ((err = snd_gus_initialize(gus)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_gus_initialize(gus)) < 0)
+		goto out;
+
 	if (!gus->ess_flag) {
 		snd_printdd("GUS Extreme soundcard was not detected at 0x%lx\n", gus->gf1.port);
-		snd_card_free(card);
-		return -ENODEV;
-	}
-	if ((err = snd_es1688_pcm(es1688, 0, NULL)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_es1688_mixer(es1688)) < 0) {
-		snd_card_free(card);
-		return err;
+		err = -ENODEV;
+		goto out;
 	}
+	if ((err = snd_es1688_pcm(es1688, 0, NULL)) < 0)
+		goto out;
+
+	if ((err = snd_es1688_mixer(es1688)) < 0)
+		goto out;
+
 	snd_component_add(card, "ES1688");
 	if (pcm_channels[dev] > 0) {
-		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0) {
-			snd_card_free(card);
-			return err;
-		}
-	}
-	if ((err = snd_gf1_new_mixer(gus)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_gusextreme_mixer(es1688)) < 0) {
-		snd_card_free(card);
-		return err;
+		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0)
+			goto out;
 	}
+	if ((err = snd_gf1_new_mixer(gus)) < 0)
+		goto out;
+
+	if ((err = snd_gusextreme_mixer(es1688)) < 0)
+		goto out;
 
 	if (snd_opl3_create(card, es1688->port, es1688->port + 2,
 			    OPL3_HW_OPL3, 0, &opl3) < 0) {
 		printk(KERN_ERR "gusextreme: opl3 not detected at 0x%lx\n", es1688->port);
 	} else {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 2, NULL)) < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if ((err = snd_opl3_hwdep_new(opl3, 0, 2, NULL)) < 0)
+			goto out;
 	}
 
 	if (es1688->mpu_port >= 0x300) {
@@ -327,20 +314,22 @@
 					       es1688->mpu_port, 0,
 					       xmpu_irq,
 					       SA_INTERRUPT,
-					       NULL)) < 0) {
-			snd_card_free(card);
-			return err;
-		}
+					       NULL)) < 0)
+			goto out;
 	}
 
 	sprintf(card->longname, "Gravis UltraSound Extreme at 0x%lx, irq %i&%i, dma %i&%i",
 		es1688->port, xgf1_irq, xess_irq, xgf1_dma, xess_dma);
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_card_register(card)) < 0)
+		goto out;
+
 	snd_gusextreme_cards[dev] = card;
 	return 0;
+
+out:
+	snd_card_free(card);
+	card = NULL;
+	return err;
 }
 
 static int __init snd_gusextreme_legacy_auto_probe(unsigned long xport)


