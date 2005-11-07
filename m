Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVKGDQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVKGDQc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKGDQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:11 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:2717 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbVKGDQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:01 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>
Subject: [Patch 20/20] V4L (925) Saa7134 alsa is now a standalone module
Date: Mon, 07 Nov 2005 00:58:11 -0200
Message-Id: <1131333341.25215.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Saa7134-alsa is now a standalone module

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-alsa.c    |  110 +++++++++++++++++++++++---
 drivers/media/video/saa7134/saa7134-core.c    |   29 ++++--
 drivers/media/video/saa7134/saa7134-tvaudio.c |    3 
 drivers/media/video/saa7134/saa7134.h         |    8 -
 4 files changed, 121 insertions(+), 29 deletions(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-alsa.c
+++ hg/drivers/media/video/saa7134/saa7134-alsa.c
@@ -1,6 +1,5 @@
 /*
  *   SAA713x ALSA support for V4L
- *   Ricardo Cerqueira <v4l@cerqueira.org>
  *
  *
  *   Caveats:
@@ -37,9 +36,13 @@
 #include "saa7134.h"
 #include "saa7134-reg.h"
 
-static unsigned int alsa_debug  = 0;
-module_param(alsa_debug, int, 0644);
-MODULE_PARM_DESC(alsa_debug,"enable debug messages [alsa]");
+static unsigned int debug  = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug,"enable debug messages [alsa]");
+
+unsigned int dsp_nr = 0;
+module_param(dsp_nr,   int, 0444);
+MODULE_PARM_DESC(dsp_nr,   "alsa device number");
 
 /*
  * Configuration macros
@@ -70,7 +73,7 @@ static int index[SNDRV_CARDS] = SNDRV_DE
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
 
-#define dprintk(fmt, arg...)    if (alsa_debug) \
+#define dprintk(fmt, arg...)    if (debug) \
 	printk(KERN_DEBUG "%s/alsa: " fmt, dev->name, ## arg)
 
 
@@ -110,6 +113,7 @@ typedef struct snd_card_saa7134_pcm {
 
 static snd_card_t *snd_saa7134_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
+
 /*
  * saa7134 DMA audio stop
  *
@@ -192,12 +196,11 @@ void saa7134_irq_alsa_done(struct saa713
 	/* next block addr */
 	next_blk = (dev->oss.dma_blk + 2) % dev->oss.blocks;
 	saa_writel(reg,next_blk * dev->oss.blksize);
-	if (alsa_debug > 2)
+	if (debug > 2)
 		dprintk("irq: ok, %s, next_blk=%d, addr=%x, blocks=%u, size=%u, read=%u\n",
 			(status & 0x10000000) ? "even" : "odd ", next_blk,
 			next_blk * dev->oss.blksize, dev->oss.blocks, dev->oss.blksize, dev->oss.read_count);
 
-
 	/* update status & wake waiting readers */
 	dev->oss.dma_blk = (dev->oss.dma_blk + 1) % dev->oss.blocks;
 	dev->oss.read_count += dev->oss.blksize;
@@ -215,6 +218,41 @@ void saa7134_irq_alsa_done(struct saa713
 }
 
 /*
+ * IRQ request handler
+ *
+ *   Runs along with saa7134's IRQ handler, discards anything that isn't
+ *   DMA sound
+ *
+ */
+
+static irqreturn_t saa7134_alsa_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct saa7134_dev *dev = (struct saa7134_dev*) dev_id;
+	unsigned long report, status;
+	int loop, handled = 0;
+
+	for (loop = 0; loop < 10; loop++) {
+		report = saa_readl(SAA7134_IRQ_REPORT);
+		status = saa_readl(SAA7134_IRQ_STATUS);
+
+		if (report & SAA7134_IRQ_REPORT_DONE_RA3) {
+			handled = 1;
+			saa_writel(SAA7134_IRQ_REPORT,report);
+			saa7134_irq_alsa_done(dev, status);
+		} else {
+			goto out;
+		}
+	}
+
+	if (loop == 10) {
+		dprintk("error! looping IRQ!");
+	}
+
+out:
+	return IRQ_RETVAL(handled);
+}
+
+/*
  * ALSA capture trigger
  *
  *   - One of the ALSA capture callbacks.
@@ -825,11 +863,9 @@ static int snd_saa7134_capsrc_put(snd_kc
 		saa_dsp_writel(dev, SAA7133_DIGITAL_OUTPUT_SEL1, 0xbbbb10);
 
 		if (left || right) { // We've got data, turn the input on
-		  //saa_dsp_writel(dev, SAA7133_DIGITAL_OUTPUT_SEL2, 0x101010);
 		  saa_dsp_writel(dev, SAA7133_DIGITAL_INPUT_XBAR1, xbarin);
 		  saa_writel(SAA7133_ANALOG_IO_SELECT, anabar);
 		} else {
-		  //saa_dsp_writel(dev, SAA7133_DIGITAL_OUTPUT_SEL2, 0x101010);
 		  saa_dsp_writel(dev, SAA7133_DIGITAL_INPUT_XBAR1, 0);
 		  saa_writel(SAA7133_ANALOG_IO_SELECT, 0);
 		}
@@ -892,9 +928,10 @@ static int snd_saa7134_dev_free(snd_devi
  *
  */
 
-int alsa_card_saa7134_create(struct saa7134_dev *saadev, unsigned int devicenum)
+int alsa_card_saa7134_create (struct saa7134_dev *saadev, unsigned int devicenum)
 {
 	static int dev;
+
 	snd_card_t *card;
 	snd_card_saa7134_t *chip;
 	int err;
@@ -902,6 +939,7 @@ int alsa_card_saa7134_create(struct saa7
 		.dev_free =     snd_saa7134_dev_free,
 	};
 
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev])
@@ -909,6 +947,7 @@ int alsa_card_saa7134_create(struct saa7
 
 	if (devicenum) {
 		card = snd_card_new(devicenum, id[dev], THIS_MODULE, 0);
+		dsp_nr++;
 	} else {
 		card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	}
@@ -934,6 +973,15 @@ int alsa_card_saa7134_create(struct saa7
 	chip->irq = saadev->pci->irq;
 	chip->iobase = pci_resource_start(saadev->pci, 0);
 
+	err = request_irq(chip->pci->irq, saa7134_alsa_irq,
+				SA_SHIRQ | SA_INTERRUPT, saadev->name, saadev);
+
+	if (err < 0) {
+		printk(KERN_ERR "%s: can't get IRQ %d for ALSA\n",
+			saadev->name, saadev->pci->irq);
+		return err;
+	}
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_saa7134_free(chip);
 		return err;
@@ -966,10 +1014,48 @@ __nodev:
 	return err;
 }
 
-void alsa_card_saa7134_exit(void)
+/*
+ * Module initializer
+ *
+ * Loops through present saa7134 cards, and assigns an ALSA device
+ * to each one
+ *
+ */
+
+static int saa7134_alsa_init(void)
+{
+        struct saa7134_dev *saadev = NULL;
+        struct list_head *list;
+
+	printk(KERN_INFO "saa7134 ALSA driver for DMA sound loaded\n");
+
+        list_for_each(list,&saa7134_devlist) {
+                saadev = list_entry(list, struct saa7134_dev, devlist);
+		alsa_card_saa7134_create(saadev,dsp_nr);
+        }
+
+	if (saadev == NULL) 
+		printk(KERN_INFO "saa7134 ALSA: no saa7134 cards found\n");
+
+	return 0;
+
+}
+
+/*
+ * Module destructor
+ */
+
+void saa7134_alsa_exit(void)
 {
 	int idx;
-	 for (idx = 0; idx < SNDRV_CARDS; idx++) {
+	for (idx = 0; idx < SNDRV_CARDS; idx++) {
 		snd_card_free(snd_saa7134_cards[idx]);
 	}
+	printk(KERN_INFO "saa7134 ALSA driver for DMA sound unloaded\n");
+	return;
 }
+
+module_init(saa7134_alsa_init);
+module_exit(saa7134_alsa_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ricardo Cerqueira");
--- hg.orig/drivers/media/video/saa7134/saa7134-core.c
+++ hg/drivers/media/video/saa7134/saa7134-core.c
@@ -574,6 +574,17 @@ static irqreturn_t saa7134_irq(int irq, 
 				       dev->name);
 			goto out;
 		}
+
+		/* If alsa support is active and we get a sound report, exit
+		   and let the saa7134-alsa module deal with it */
+
+		if ((report & SAA7134_IRQ_REPORT_DONE_RA3) && alsa)  {
+			if (irq_debug > 1)
+				printk(KERN_DEBUG "%s/irq: ignoring interrupt for ALSA\n",
+				       dev->name);
+			goto out;
+		}
+
 		handled = 1;
 		saa_writel(SAA7134_IRQ_REPORT,report);
 		if (irq_debug)
@@ -598,8 +609,6 @@ static irqreturn_t saa7134_irq(int irq, 
 		if ((report & SAA7134_IRQ_REPORT_DONE_RA3))  {
 			if (oss) {
 				saa7134_irq_oss_done(dev,status);
-			} else if (alsa) {
-				saa7134_irq_alsa_done(dev,status);
 			}
 		}
 
@@ -1029,9 +1038,7 @@ static int __devinit saa7134_initdev(str
 			printk(KERN_INFO "%s: registered device mixer%d\n",
 			       dev->name,dev->oss.minor_mixer >> 4);
 		} else if (alsa) {
-			alsa_card_saa7134_create(dev,dsp_nr[dev->nr]);
-			printk(KERN_INFO "%s: registered ALSA devices\n",
-			       dev->name);
+			request_module("saa7134-alsa");
 		}
 		break;
 	}
@@ -1059,8 +1066,6 @@ static int __devinit saa7134_initdev(str
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		if (oss)
 			unregister_sound_dsp(dev->oss.minor_dsp);
-		else if (alsa)
-			alsa_card_saa7134_exit();
 		break;
 	}
  fail4:
@@ -1120,8 +1125,7 @@ static void __devexit saa7134_finidev(st
 		if (oss) {
 			unregister_sound_mixer(dev->oss.minor_mixer);
 			unregister_sound_dsp(dev->oss.minor_dsp);
-		} else if (alsa)
-			alsa_card_saa7134_exit();
+		}
 		break;
 	}
 	saa7134_unregister_video(dev);
@@ -1214,6 +1218,13 @@ EXPORT_SYMBOL(saa7134_i2c_call_clients);
 EXPORT_SYMBOL(saa7134_devlist);
 EXPORT_SYMBOL(saa7134_boards);
 
+/* ----------------- For ALSA -------------------------------- */
+
+EXPORT_SYMBOL(saa7134_pgtable_free);
+EXPORT_SYMBOL(saa7134_pgtable_build);
+EXPORT_SYMBOL(saa7134_pgtable_alloc);
+EXPORT_SYMBOL(saa7134_set_dmabits);
+
 /* ----------------------------------------------------------- */
 /*
  * Local variables:
--- hg.orig/drivers/media/video/saa7134/saa7134.h
+++ hg/drivers/media/video/saa7134/saa7134.h
@@ -665,14 +665,6 @@ void saa7134_input_fini(struct saa7134_d
 void saa7134_input_irq(struct saa7134_dev *dev);
 void saa7134_set_i2c_ir(struct saa7134_dev *dev, struct IR_i2c *ir);
 
-/* ----------------------------------------------------------- */
-/* saa7134-alsa.c                                              */
-
-int alsa_card_saa7134_create(struct saa7134_dev *saadev, unsigned int devnum);
-void alsa_card_saa7134_exit(void);
-void saa7134_irq_alsa_done(struct saa7134_dev *dev, unsigned long status);
-
-
 /*
  * Local variables:
  * c-basic-offset: 8
--- hg.orig/drivers/media/video/saa7134/saa7134-tvaudio.c
+++ hg/drivers/media/video/saa7134/saa7134-tvaudio.c
@@ -1024,9 +1024,12 @@ int saa7134_tvaudio_do_scan(struct saa71
 	return 0;
 }
 
+EXPORT_SYMBOL(saa_dsp_writel);
+
 /* ----------------------------------------------------------- */
 /*
  * Local variables:
  * c-basic-offset: 8
  * End:
  */
+


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

