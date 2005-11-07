Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVKGVQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVKGVQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVKGVQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:16:43 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:4739 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964925AbVKGVQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:16:41 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>, takashi Iwai <tiwai@suse.de>,
       rlrevell@joe-job.com, mchehab@brturbo.com.br,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nshmyrev@yandex.ru, v4l@cerqueira.org
Subject: [Patch 1/1] V4L (926) Saa7134 alsa can only be autoloaded after
	saa7134 is active
Date: Mon, 07 Nov 2005 18:48:18 -0200
Message-Id: <1131397121.6632.127.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Saa7134-alsa can only be autoloaded after saa7134 is active
- Applied pertinent changes proposed by the ALSA team
- dsp_nr replaced by ALSA's index[]

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-alsa.c |  240 ++++++++++------------
 drivers/media/video/saa7134/saa7134-core.c |   27 +-
 drivers/media/video/saa7134/saa7134-oss.c  |  308 ++++++++++++++---------------
 drivers/media/video/saa7134/saa7134.h      |    6 
 4 files changed, 289 insertions(+), 292 deletions(-)

--- hg.old.orig/drivers/media/video/saa7134/saa7134-core.c
+++ hg.old/drivers/media/video/saa7134/saa7134-core.c
@@ -194,6 +194,7 @@ void saa7134_track_gpio(struct saa7134_d
 
 static int need_empress;
 static int need_dvb;
+static int need_alsa;
 
 static int pending_call(struct notifier_block *self, unsigned long state,
 			void *module)
@@ -205,6 +206,8 @@ static int pending_call(struct notifier_
 		request_module("saa7134-empress");
 	if (need_dvb)
 		request_module("saa7134-dvb");
+	if (need_alsa)
+		request_module("saa7134-alsa");
 	return NOTIFY_DONE;
 }
 
@@ -469,7 +472,7 @@ int saa7134_set_dmabits(struct saa7134_d
 	}
 
 	/* audio capture -- dma 3 */
-	if (dev->oss.dma_running) {
+	if (dev->dmasound.dma_running) {
 		ctrl |= SAA7134_MAIN_CTRL_TE6;
 		irq  |= SAA7134_IRQ1_INTE_RA3_1 |
 			SAA7134_IRQ1_INTE_RA3_0;
@@ -983,6 +986,12 @@ static int __devinit saa7134_initdev(str
 	if (card_is_dvb(dev))
 		request_module_depend("saa7134-dvb",&need_dvb);
 
+	if (!oss && alsa) {
+		dprintk("Requesting ALSA module\n");
+		request_module_depend("saa7134-alsa",&need_alsa);
+	}
+
+
 	v4l2_prio_init(&dev->prio);
 
 	/* register v4l devices */
@@ -1021,24 +1030,22 @@ static int __devinit saa7134_initdev(str
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		if (oss) {
-			err = dev->oss.minor_dsp =
+			err = dev->dmasound.minor_dsp =
 				register_sound_dsp(&saa7134_dsp_fops,
 						   dsp_nr[dev->nr]);
 			if (err < 0) {
 				goto fail4;
 			}
 			printk(KERN_INFO "%s: registered device dsp%d\n",
-			       dev->name,dev->oss.minor_dsp >> 4);
+			       dev->name,dev->dmasound.minor_dsp >> 4);
 
-			err = dev->oss.minor_mixer =
+			err = dev->dmasound.minor_mixer =
 				register_sound_mixer(&saa7134_mixer_fops,
 						     mixer_nr[dev->nr]);
 			if (err < 0)
 				goto fail5;
 			printk(KERN_INFO "%s: registered device mixer%d\n",
-			       dev->name,dev->oss.minor_mixer >> 4);
-		} else if (alsa) {
-			request_module("saa7134-alsa");
+			       dev->name,dev->dmasound.minor_mixer >> 4);
 		}
 		break;
 	}
@@ -1065,7 +1072,7 @@ static int __devinit saa7134_initdev(str
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		if (oss)
-			unregister_sound_dsp(dev->oss.minor_dsp);
+			unregister_sound_dsp(dev->dmasound.minor_dsp);
 		break;
 	}
  fail4:
@@ -1123,8 +1130,8 @@ static void __devexit saa7134_finidev(st
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		if (oss) {
-			unregister_sound_mixer(dev->oss.minor_mixer);
-			unregister_sound_dsp(dev->oss.minor_dsp);
+			unregister_sound_mixer(dev->dmasound.minor_mixer);
+			unregister_sound_dsp(dev->dmasound.minor_dsp);
 		}
 		break;
 	}
--- hg.old.orig/drivers/media/video/saa7134/saa7134-alsa.c
+++ hg.old/drivers/media/video/saa7134/saa7134-alsa.c
@@ -30,7 +30,6 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
-#include <sound/rawmidi.h>
 #include <sound/initval.h>
 
 #include "saa7134.h"
@@ -40,29 +39,11 @@ static unsigned int debug  = 0;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug,"enable debug messages [alsa]");
 
-unsigned int dsp_nr = 0;
-module_param(dsp_nr,   int, 0444);
-MODULE_PARM_DESC(dsp_nr,   "alsa device number");
-
 /*
  * Configuration macros
  */
 
 /* defaults */
-#define MAX_BUFFER_SIZE		(256*1024)
-#define USE_FORMATS 		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE
-#define USE_RATE		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000
-#define USE_RATE_MIN		32000
-#define USE_RATE_MAX		48000
-#define USE_CHANNELS_MIN 	1
-#define USE_CHANNELS_MAX 	2
-#ifndef USE_PERIODS_MIN
-#define USE_PERIODS_MIN 	2
-#endif
-#ifndef USE_PERIODS_MAX
-#define USE_PERIODS_MAX 	1024
-#endif
-
 #define MIXER_ADDR_TVTUNER	0
 #define MIXER_ADDR_LINE1	1
 #define MIXER_ADDR_LINE2	2
@@ -73,10 +54,14 @@ static int index[SNDRV_CARDS] = SNDRV_DE
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
 
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
+
 #define dprintk(fmt, arg...)    if (debug) \
 	printk(KERN_DEBUG "%s/alsa: " fmt, dev->name, ## arg)
 
 
+
 /*
  * Main chip structure
  */
@@ -111,7 +96,7 @@ typedef struct snd_card_saa7134_pcm {
 	snd_pcm_substream_t *substream;
 } snd_card_saa7134_pcm_t;
 
-static snd_card_t *snd_saa7134_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+static snd_card_t *snd_saa7134_cards[SNDRV_CARDS];
 
 
 /*
@@ -127,8 +112,8 @@ static snd_card_t *snd_saa7134_cards[SND
 static void saa7134_dma_stop(struct saa7134_dev *dev)
 
 {
-	dev->oss.dma_blk     = -1;
-	dev->oss.dma_running = 0;
+	dev->dmasound.dma_blk     = -1;
+	dev->dmasound.dma_running = 0;
 	saa7134_set_dmabits(dev);
 }
 
@@ -144,8 +129,8 @@ static void saa7134_dma_stop(struct saa7
 
 static void saa7134_dma_start(struct saa7134_dev *dev)
 {
-	dev->oss.dma_blk     = 0;
-	dev->oss.dma_running = 1;
+	dev->dmasound.dma_blk     = 0;
+	dev->dmasound.dma_running = 1;
 	saa7134_set_dmabits(dev);
 }
 
@@ -165,7 +150,7 @@ void saa7134_irq_alsa_done(struct saa713
 	int next_blk, reg = 0;
 
 	spin_lock(&dev->slock);
-	if (UNSET == dev->oss.dma_blk) {
+	if (UNSET == dev->dmasound.dma_blk) {
 		dprintk("irq: recording stopped\n");
 		goto done;
 	}
@@ -173,11 +158,11 @@ void saa7134_irq_alsa_done(struct saa713
 		dprintk("irq: lost %ld\n", (status >> 24) & 0x0f);
 	if (0 == (status & 0x10000000)) {
 		/* odd */
-		if (0 == (dev->oss.dma_blk & 0x01))
+		if (0 == (dev->dmasound.dma_blk & 0x01))
 			reg = SAA7134_RS_BA1(6);
 	} else {
 		/* even */
-		if (1 == (dev->oss.dma_blk & 0x01))
+		if (1 == (dev->dmasound.dma_blk & 0x01))
 			reg = SAA7134_RS_BA2(6);
 	}
 	if (0 == reg) {
@@ -186,30 +171,31 @@ void saa7134_irq_alsa_done(struct saa713
 		goto done;
 	}
 
-	if (dev->oss.read_count >= dev->oss.blksize * (dev->oss.blocks-2)) {
-		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->oss.read_count,
-			dev->oss.bufsize, dev->oss.blocks);
+	if (dev->dmasound.read_count >= dev->dmasound.blksize * (dev->dmasound.blocks-2)) {
+		dprintk("irq: overrun [full=%d/%d] - Blocks in %d\n",dev->dmasound.read_count,
+			dev->dmasound.bufsize, dev->dmasound.blocks);
+		snd_pcm_stop(dev->dmasound.substream,SNDRV_PCM_STATE_XRUN);
 		saa7134_dma_stop(dev);
 		goto done;
 	}
 
 	/* next block addr */
-	next_blk = (dev->oss.dma_blk + 2) % dev->oss.blocks;
-	saa_writel(reg,next_blk * dev->oss.blksize);
+	next_blk = (dev->dmasound.dma_blk + 2) % dev->dmasound.blocks;
+	saa_writel(reg,next_blk * dev->dmasound.blksize);
 	if (debug > 2)
 		dprintk("irq: ok, %s, next_blk=%d, addr=%x, blocks=%u, size=%u, read=%u\n",
 			(status & 0x10000000) ? "even" : "odd ", next_blk,
-			next_blk * dev->oss.blksize, dev->oss.blocks, dev->oss.blksize, dev->oss.read_count);
+			next_blk * dev->dmasound.blksize, dev->dmasound.blocks, dev->dmasound.blksize, dev->dmasound.read_count);
 
 	/* update status & wake waiting readers */
-	dev->oss.dma_blk = (dev->oss.dma_blk + 1) % dev->oss.blocks;
-	dev->oss.read_count += dev->oss.blksize;
+	dev->dmasound.dma_blk = (dev->dmasound.dma_blk + 1) % dev->dmasound.blocks;
+	dev->dmasound.read_count += dev->dmasound.blksize;
 
-	dev->oss.recording_on = reg;
+	dev->dmasound.recording_on = reg;
 
-	if (dev->oss.read_count >= snd_pcm_lib_period_bytes(dev->oss.substream)) {
+	if (dev->dmasound.read_count >= snd_pcm_lib_period_bytes(dev->dmasound.substream)) {
 		spin_unlock(&dev->slock);
-		snd_pcm_period_elapsed(dev->oss.substream);
+		snd_pcm_period_elapsed(dev->dmasound.substream);
 		spin_lock(&dev->slock);
 	}
  done:
@@ -265,7 +251,24 @@ out:
 static int snd_card_saa7134_capture_trigger(snd_pcm_substream_t * substream,
 					  int cmd)
 {
-	return 0;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
+	struct saa7134_dev *dev=saapcm->saadev;
+	int err = 0;
+
+	spin_lock_irq(&dev->slock);
+        if (cmd == SNDRV_PCM_TRIGGER_START) {
+		/* start dma */
+		saa7134_dma_start(dev);
+        } else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
+		/* stop dma */
+		saa7134_dma_stop(dev);
+        } else {
+                err = -EINVAL;
+        }
+	spin_unlock_irq(&dev->slock);
+
+        return err;
 }
 
 /*
@@ -292,9 +295,9 @@ static int dsp_buffer_conf(struct saa713
 	if ((blksize * blocks) > 1024*1024)
 		blocks = 1024*1024 / blksize;
 
-	dev->oss.blocks  = blocks;
-	dev->oss.blksize = blksize;
-	dev->oss.bufsize = blksize * blocks;
+	dev->dmasound.blocks  = blocks;
+	dev->dmasound.blksize = blksize;
+	dev->dmasound.bufsize = blksize * blocks;
 
 	dprintk("buffer config: %d blocks / %d bytes, %d kB total\n",
 		blocks,blksize,blksize * blocks / 1024);
@@ -316,11 +319,11 @@ static int dsp_buffer_init(struct saa713
 {
 	int err;
 
-	if (!dev->oss.bufsize)
+	if (!dev->dmasound.bufsize)
 		BUG();
-	videobuf_dma_init(&dev->oss.dma);
-	err = videobuf_dma_init_kernel(&dev->oss.dma, PCI_DMA_FROMDEVICE,
-				       (dev->oss.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
+	videobuf_dma_init(&dev->dmasound.dma);
+	err = videobuf_dma_init_kernel(&dev->dmasound.dma, PCI_DMA_FROMDEVICE,
+				       (dev->dmasound.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
 	if (0 != err)
 		return err;
 	return 0;
@@ -343,7 +346,6 @@ static int snd_card_saa7134_capture_prep
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err, bswap, sign;
 	u32 fmt, control;
-	unsigned long flags;
 	snd_card_saa7134_t *saa7134 = snd_pcm_substream_chip(substream);
 	struct saa7134_dev *dev;
 	snd_card_saa7134_pcm_t *saapcm = runtime->private_data;
@@ -354,7 +356,7 @@ static int snd_card_saa7134_capture_prep
 	size = snd_pcm_lib_buffer_bytes(substream);
 	count = snd_pcm_lib_period_bytes(substream);
 
-	saapcm->saadev->oss.substream = substream;
+	saapcm->saadev->dmasound.substream = substream;
 	bps = runtime->rate * runtime->channels;
 	bps *= snd_pcm_format_width(runtime->format);
 	bps /= 8;
@@ -374,13 +376,13 @@ static int snd_card_saa7134_capture_prep
 		goto fail2;
 
 	/* prepare buffer */
-	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->oss.dma)))
+	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->dmasound.dma)))
 		return err;
-	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->oss.pt)))
+	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->dmasound.pt)))
 		goto fail1;
-	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->oss.pt,
-					      dev->oss.dma.sglist,
-					      dev->oss.dma.sglen,
+	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->dmasound.pt,
+					      dev->dmasound.dma.sglist,
+					      dev->dmasound.dma.sglen,
 					      0)))
 		goto fail2;
 
@@ -430,10 +432,10 @@ static int snd_card_saa7134_capture_prep
 		if (sign)
 			fmt |= 0x04;
 
-		fmt |= (MIXER_ADDR_TVTUNER == dev->oss.input) ? 0xc0 : 0x80;
-		saa_writeb(SAA7134_NUM_SAMPLES0, ((dev->oss.blksize - 1) & 0x0000ff));
-		saa_writeb(SAA7134_NUM_SAMPLES1, ((dev->oss.blksize - 1) & 0x00ff00) >>  8);
-		saa_writeb(SAA7134_NUM_SAMPLES2, ((dev->oss.blksize - 1) & 0xff0000) >> 16);
+		fmt |= (MIXER_ADDR_TVTUNER == dev->dmasound.input) ? 0xc0 : 0x80;
+		saa_writeb(SAA7134_NUM_SAMPLES0, ((dev->dmasound.blksize - 1) & 0x0000ff));
+		saa_writeb(SAA7134_NUM_SAMPLES1, ((dev->dmasound.blksize - 1) & 0x00ff00) >>  8);
+		saa_writeb(SAA7134_NUM_SAMPLES2, ((dev->dmasound.blksize - 1) & 0xff0000) >> 16);
 		saa_writeb(SAA7134_AUDIO_FORMAT_CTRL, fmt);
 
 		break;
@@ -445,7 +447,7 @@ static int snd_card_saa7134_capture_prep
 			fmt |= (2 << 4);
 		if (!sign)
 			fmt |= 0x04;
-		saa_writel(SAA7133_NUM_SAMPLES, dev->oss.blksize -1);
+		saa_writel(SAA7133_NUM_SAMPLES, dev->dmasound.blksize -1);
 		saa_writel(SAA7133_AUDIO_CHANNEL, 0x543210 | (fmt << 24));
 		//saa_writel(SAA7133_AUDIO_CHANNEL, 0x543210);
 		break;
@@ -457,7 +459,7 @@ static int snd_card_saa7134_capture_prep
 	/* dma: setup channel 6 (= AUDIO) */
 	control = SAA7134_RS_CONTROL_BURST_16 |
 		SAA7134_RS_CONTROL_ME |
-		(dev->oss.pt.dma >> 12);
+		(dev->dmasound.pt.dma >> 12);
 	if (bswap)
 		control |= SAA7134_RS_CONTROL_BSWAP;
 
@@ -465,24 +467,20 @@ static int snd_card_saa7134_capture_prep
 	   byte, but it doesn't work. So I allocate the DMA using the
 	   V4L functions, and force ALSA to use that as the DMA area */
 
-	runtime->dma_area = dev->oss.dma.vmalloc;
+	runtime->dma_area = dev->dmasound.dma.vmalloc;
 
 	saa_writel(SAA7134_RS_BA1(6),0);
-	saa_writel(SAA7134_RS_BA2(6),dev->oss.blksize);
+	saa_writel(SAA7134_RS_BA2(6),dev->dmasound.blksize);
 	saa_writel(SAA7134_RS_PITCH(6),0);
 	saa_writel(SAA7134_RS_CONTROL(6),control);
 
-	dev->oss.rate = runtime->rate;
-	/* start dma */
-	spin_lock_irqsave(&dev->slock,flags);
-	saa7134_dma_start(dev);
-	spin_unlock_irqrestore(&dev->slock,flags);
+	dev->dmasound.rate = runtime->rate;
 
 	return 0;
  fail2:
-	saa7134_pgtable_free(dev->pci,&dev->oss.pt);
+	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
  fail1:
-	videobuf_dma_pci_unmap(dev->pci,&dev->oss.dma);
+	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
 	return err;
 
 
@@ -507,14 +505,14 @@ static snd_pcm_uframes_t snd_card_saa713
 
 
 
-	if (dev->oss.read_count) {
-		dev->oss.read_count  -= snd_pcm_lib_period_bytes(substream);
-		dev->oss.read_offset += snd_pcm_lib_period_bytes(substream);
-		if (dev->oss.read_offset == dev->oss.bufsize)
-			dev->oss.read_offset = 0;
+	if (dev->dmasound.read_count) {
+		dev->dmasound.read_count  -= snd_pcm_lib_period_bytes(substream);
+		dev->dmasound.read_offset += snd_pcm_lib_period_bytes(substream);
+		if (dev->dmasound.read_offset == dev->dmasound.bufsize)
+			dev->dmasound.read_offset = 0;
 	}
 
-	return bytes_to_frames(runtime, dev->oss.read_offset);
+	return bytes_to_frames(runtime, dev->dmasound.read_offset);
 }
 
 /*
@@ -526,18 +524,22 @@ static snd_pcm_hardware_t snd_card_saa71
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =		USE_FORMATS,
-	.rates =		USE_RATE,
-	.rate_min =		USE_RATE_MIN,
-	.rate_max =		USE_RATE_MAX,
-	.channels_min =		USE_CHANNELS_MIN,
-	.channels_max =		USE_CHANNELS_MAX,
-	.buffer_bytes_max =	MAX_BUFFER_SIZE,
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S16_BE | \
+				SNDRV_PCM_FMTBIT_S8 | \
+				SNDRV_PCM_FMTBIT_U8 | \
+				SNDRV_PCM_FMTBIT_U16_LE | \
+				SNDRV_PCM_FMTBIT_U16_BE,
+	.rates =		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000,
+	.rate_min =		32000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	(256*1024),
 	.period_bytes_min =	64,
-	.period_bytes_max =	MAX_BUFFER_SIZE,
-	.periods_min =		USE_PERIODS_MIN,
-	.periods_max =		USE_PERIODS_MAX,
-	.fifo_size =		0x08070503,
+	.period_bytes_max =	(256*1024),
+	.periods_min =		2,
+	.periods_max =		1024,
 };
 
 static void snd_card_saa7134_runtime_free(snd_pcm_runtime_t *runtime)
@@ -593,14 +595,14 @@ static int snd_card_saa7134_hw_free(snd_
 
 static int dsp_buffer_free(struct saa7134_dev *dev)
 {
-	if (!dev->oss.blksize)
+	if (!dev->dmasound.blksize)
 		BUG();
 
-	videobuf_dma_free(&dev->oss.dma);
+	videobuf_dma_free(&dev->dmasound.dma);
 
-	dev->oss.blocks  = 0;
-	dev->oss.blksize = 0;
-	dev->oss.bufsize = 0;
+	dev->dmasound.blocks  = 0;
+	dev->dmasound.blksize = 0;
+	dev->dmasound.bufsize = 0;
 
 	return 0;
 }
@@ -619,16 +621,10 @@ static int snd_card_saa7134_capture_clos
 {
 	snd_card_saa7134_t *chip = snd_pcm_substream_chip(substream);
 	struct saa7134_dev *dev = chip->saadev;
-	unsigned long flags;
-
-	/* stop dma */
-	spin_lock_irqsave(&dev->slock,flags);
-	saa7134_dma_stop(dev);
-	spin_unlock_irqrestore(&dev->slock,flags);
 
 	/* unlock buffer */
-	saa7134_pgtable_free(dev->pci,&dev->oss.pt);
-	videobuf_dma_pci_unmap(dev->pci,&dev->oss.dma);
+	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
+	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
 
 	dsp_buffer_free(dev);
 	return 0;
@@ -652,16 +648,16 @@ static int snd_card_saa7134_capture_open
 	struct saa7134_dev *dev = saa7134->saadev;
 	int err;
 
-	down(&dev->oss.lock);
+	down(&dev->dmasound.lock);
 
-	dev->oss.afmt        = SNDRV_PCM_FORMAT_U8;
-	dev->oss.channels    = 2;
-	dev->oss.read_count  = 0;
-	dev->oss.read_offset = 0;
+	dev->dmasound.afmt        = SNDRV_PCM_FORMAT_U8;
+	dev->dmasound.channels    = 2;
+	dev->dmasound.read_count  = 0;
+	dev->dmasound.read_offset = 0;
 
-	up(&dev->oss.lock);
+	up(&dev->dmasound.lock);
 
-	saapcm = kcalloc(1, sizeof(*saapcm), GFP_KERNEL);
+	saapcm = kzalloc(sizeof(*saapcm), GFP_KERNEL);
 	if (saapcm == NULL)
 		return -ENOMEM;
 	saapcm->saadev=saa7134->saadev;
@@ -734,13 +730,10 @@ static int snd_saa7134_volume_info(snd_k
 static int snd_saa7134_volume_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	snd_card_saa7134_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long flags;
 	int addr = kcontrol->private_value;
 
-	spin_lock_irqsave(&chip->mixer_lock, flags);
 	ucontrol->value.integer.value[0] = chip->mixer_volume[addr][0];
 	ucontrol->value.integer.value[1] = chip->mixer_volume[addr][1];
-	spin_unlock_irqrestore(&chip->mixer_lock, flags);
 	return 0;
 }
 
@@ -818,7 +811,7 @@ static int snd_saa7134_capsrc_put(snd_kc
 		 chip->capture_source[addr][1] != right;
 	chip->capture_source[addr][0] = left;
 	chip->capture_source[addr][1] = right;
-	dev->oss.input=addr;
+	dev->dmasound.input=addr;
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);
 
 
@@ -834,7 +827,7 @@ static int snd_saa7134_capsrc_put(snd_kc
 			case MIXER_ADDR_LINE1:
 			case MIXER_ADDR_LINE2:
 				analog_io = (MIXER_ADDR_LINE1 == addr) ? 0x00 : 0x08;
-				rate = (32000 == dev->oss.rate) ? 0x01 : 0x03;
+				rate = (32000 == dev->dmasound.rate) ? 0x01 : 0x03;
 				saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x08, analog_io);
 				saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, 0x80);
 				saa_andorb(SAA7134_SIF_SAMPLE_FREQ,   0x03, rate);
@@ -928,7 +921,7 @@ static int snd_saa7134_dev_free(snd_devi
  *
  */
 
-int alsa_card_saa7134_create (struct saa7134_dev *saadev, unsigned int devicenum)
+int alsa_card_saa7134_create (struct saa7134_dev *saadev)
 {
 	static int dev;
 
@@ -945,12 +938,8 @@ int alsa_card_saa7134_create (struct saa
 	if (!enable[dev])
 		return -ENODEV;
 
-	if (devicenum) {
-		card = snd_card_new(devicenum, id[dev], THIS_MODULE, 0);
-		dsp_nr++;
-	} else {
-		card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	}
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+
 	if (card == NULL)
 		return -ENOMEM;
 
@@ -964,6 +953,7 @@ int alsa_card_saa7134_create (struct saa
 	}
 
 	spin_lock_init(&chip->lock);
+	spin_lock_init(&chip->mixer_lock);
 
 	chip->saadev = saadev;
 
@@ -973,18 +963,17 @@ int alsa_card_saa7134_create (struct saa
 	chip->irq = saadev->pci->irq;
 	chip->iobase = pci_resource_start(saadev->pci, 0);
 
-	err = request_irq(chip->pci->irq, saa7134_alsa_irq,
+	err = request_irq(saadev->pci->irq, saa7134_alsa_irq,
 				SA_SHIRQ | SA_INTERRUPT, saadev->name, saadev);
 
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d for ALSA\n",
 			saadev->name, saadev->pci->irq);
-		return err;
+		goto __nodev;
 	}
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_saa7134_free(chip);
-		return err;
+		goto __nodev;
 	}
 
 	if ((err = snd_card_saa7134_new_mixer(chip)) < 0)
@@ -993,8 +982,6 @@ int alsa_card_saa7134_create (struct saa
 	if ((err = snd_card_saa7134_pcm(chip, 0)) < 0)
 		goto __nodev;
 
-	spin_lock_init(&chip->mixer_lock);
-
 	snd_card_set_dev(card, &chip->pci->dev);
 
 	/* End of "creation" */
@@ -1010,7 +997,7 @@ int alsa_card_saa7134_create (struct saa
 
 __nodev:
 	snd_card_free(card);
-	kfree(card);
+	kfree(chip);
 	return err;
 }
 
@@ -1031,7 +1018,7 @@ static int saa7134_alsa_init(void)
 
         list_for_each(list,&saa7134_devlist) {
                 saadev = list_entry(list, struct saa7134_dev, devlist);
-		alsa_card_saa7134_create(saadev,dsp_nr);
+		alsa_card_saa7134_create(saadev);
         }
 
 	if (saadev == NULL) 
@@ -1048,10 +1035,13 @@ static int saa7134_alsa_init(void)
 void saa7134_alsa_exit(void)
 {
 	int idx;
+
 	for (idx = 0; idx < SNDRV_CARDS; idx++) {
 		snd_card_free(snd_saa7134_cards[idx]);
 	}
+
 	printk(KERN_INFO "saa7134 ALSA driver for DMA sound unloaded\n");
+
 	return;
 }
 
--- hg.old.orig/drivers/media/video/saa7134/saa7134-oss.c
+++ hg.old/drivers/media/video/saa7134/saa7134-oss.c
@@ -59,9 +59,9 @@ static int dsp_buffer_conf(struct saa713
 	if ((blksize * blocks) > 1024*1024)
 		blocks = 1024*1024 / blksize;
 
-	dev->oss.blocks  = blocks;
-	dev->oss.blksize = blksize;
-	dev->oss.bufsize = blksize * blocks;
+	dev->dmasound.blocks  = blocks;
+	dev->dmasound.blksize = blksize;
+	dev->dmasound.bufsize = blksize * blocks;
 
 	dprintk("buffer config: %d blocks / %d bytes, %d kB total\n",
 		blocks,blksize,blksize * blocks / 1024);
@@ -72,11 +72,11 @@ static int dsp_buffer_init(struct saa713
 {
 	int err;
 
-	if (!dev->oss.bufsize)
+	if (!dev->dmasound.bufsize)
 		BUG();
-	videobuf_dma_init(&dev->oss.dma);
-	err = videobuf_dma_init_kernel(&dev->oss.dma, PCI_DMA_FROMDEVICE,
-				       (dev->oss.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
+	videobuf_dma_init(&dev->dmasound.dma);
+	err = videobuf_dma_init_kernel(&dev->dmasound.dma, PCI_DMA_FROMDEVICE,
+				       (dev->dmasound.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
 	if (0 != err)
 		return err;
 	return 0;
@@ -84,26 +84,26 @@ static int dsp_buffer_init(struct saa713
 
 static int dsp_buffer_free(struct saa7134_dev *dev)
 {
-	if (!dev->oss.blksize)
+	if (!dev->dmasound.blksize)
 		BUG();
-	videobuf_dma_free(&dev->oss.dma);
-	dev->oss.blocks  = 0;
-	dev->oss.blksize = 0;
-	dev->oss.bufsize = 0;
+	videobuf_dma_free(&dev->dmasound.dma);
+	dev->dmasound.blocks  = 0;
+	dev->dmasound.blksize = 0;
+	dev->dmasound.bufsize = 0;
 	return 0;
 }
 
 static void dsp_dma_start(struct saa7134_dev *dev)
 {
-	dev->oss.dma_blk     = 0;
-	dev->oss.dma_running = 1;
+	dev->dmasound.dma_blk     = 0;
+	dev->dmasound.dma_running = 1;
 	saa7134_set_dmabits(dev);
 }
 
 static void dsp_dma_stop(struct saa7134_dev *dev)
 {
-	dev->oss.dma_blk     = -1;
-	dev->oss.dma_running = 0;
+	dev->dmasound.dma_blk     = -1;
+	dev->dmasound.dma_running = 0;
 	saa7134_set_dmabits(dev);
 }
 
@@ -114,18 +114,18 @@ static int dsp_rec_start(struct saa7134_
 	unsigned long flags;
 
 	/* prepare buffer */
-	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->oss.dma)))
+	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->dmasound.dma)))
 		return err;
-	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->oss.pt)))
+	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->dmasound.pt)))
 		goto fail1;
-	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->oss.pt,
-					      dev->oss.dma.sglist,
-					      dev->oss.dma.sglen,
+	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->dmasound.pt,
+					      dev->dmasound.dma.sglist,
+					      dev->dmasound.dma.sglen,
 					      0)))
 		goto fail2;
 
 	/* sample format */
-	switch (dev->oss.afmt) {
+	switch (dev->dmasound.afmt) {
 	case AFMT_U8:
 	case AFMT_S8:     fmt = 0x00;  break;
 	case AFMT_U16_LE:
@@ -137,14 +137,14 @@ static int dsp_rec_start(struct saa7134_
 		goto fail2;
 	}
 
-	switch (dev->oss.afmt) {
+	switch (dev->dmasound.afmt) {
 	case AFMT_S8:
 	case AFMT_S16_LE:
 	case AFMT_S16_BE: sign = 1; break;
 	default:          sign = 0; break;
 	}
 
-	switch (dev->oss.afmt) {
+	switch (dev->dmasound.afmt) {
 	case AFMT_U16_BE:
 	case AFMT_S16_BE: bswap = 1; break;
 	default:          bswap = 0; break;
@@ -152,58 +152,58 @@ static int dsp_rec_start(struct saa7134_
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-		if (1 == dev->oss.channels)
+		if (1 == dev->dmasound.channels)
 			fmt |= (1 << 3);
-		if (2 == dev->oss.channels)
+		if (2 == dev->dmasound.channels)
 			fmt |= (3 << 3);
 		if (sign)
 			fmt |= 0x04;
-		fmt |= (TV == dev->oss.input) ? 0xc0 : 0x80;
+		fmt |= (TV == dev->dmasound.input) ? 0xc0 : 0x80;
 
-		saa_writeb(SAA7134_NUM_SAMPLES0, ((dev->oss.blksize - 1) & 0x0000ff));
-		saa_writeb(SAA7134_NUM_SAMPLES1, ((dev->oss.blksize - 1) & 0x00ff00) >>  8);
-		saa_writeb(SAA7134_NUM_SAMPLES2, ((dev->oss.blksize - 1) & 0xff0000) >> 16);
+		saa_writeb(SAA7134_NUM_SAMPLES0, ((dev->dmasound.blksize - 1) & 0x0000ff));
+		saa_writeb(SAA7134_NUM_SAMPLES1, ((dev->dmasound.blksize - 1) & 0x00ff00) >>  8);
+		saa_writeb(SAA7134_NUM_SAMPLES2, ((dev->dmasound.blksize - 1) & 0xff0000) >> 16);
 		saa_writeb(SAA7134_AUDIO_FORMAT_CTRL, fmt);
 
 		break;
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		if (1 == dev->oss.channels)
+		if (1 == dev->dmasound.channels)
 			fmt |= (1 << 4);
-		if (2 == dev->oss.channels)
+		if (2 == dev->dmasound.channels)
 			fmt |= (2 << 4);
 		if (!sign)
 			fmt |= 0x04;
-		saa_writel(SAA7133_NUM_SAMPLES, dev->oss.blksize -4);
+		saa_writel(SAA7133_NUM_SAMPLES, dev->dmasound.blksize -4);
 		saa_writel(SAA7133_AUDIO_CHANNEL, 0x543210 | (fmt << 24));
 		break;
 	}
 	dprintk("rec_start: afmt=%d ch=%d  =>  fmt=0x%x swap=%c\n",
-		dev->oss.afmt, dev->oss.channels, fmt,
+		dev->dmasound.afmt, dev->dmasound.channels, fmt,
 		bswap ? 'b' : '-');
 
 	/* dma: setup channel 6 (= AUDIO) */
 	control = SAA7134_RS_CONTROL_BURST_16 |
 		SAA7134_RS_CONTROL_ME |
-		(dev->oss.pt.dma >> 12);
+		(dev->dmasound.pt.dma >> 12);
 	if (bswap)
 		control |= SAA7134_RS_CONTROL_BSWAP;
 	saa_writel(SAA7134_RS_BA1(6),0);
-	saa_writel(SAA7134_RS_BA2(6),dev->oss.blksize);
+	saa_writel(SAA7134_RS_BA2(6),dev->dmasound.blksize);
 	saa_writel(SAA7134_RS_PITCH(6),0);
 	saa_writel(SAA7134_RS_CONTROL(6),control);
 
 	/* start dma */
-	dev->oss.recording_on = 1;
+	dev->dmasound.recording_on = 1;
 	spin_lock_irqsave(&dev->slock,flags);
 	dsp_dma_start(dev);
 	spin_unlock_irqrestore(&dev->slock,flags);
 	return 0;
 
  fail2:
-	saa7134_pgtable_free(dev->pci,&dev->oss.pt);
+	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
  fail1:
-	videobuf_dma_pci_unmap(dev->pci,&dev->oss.dma);
+	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
 	return err;
 }
 
@@ -211,17 +211,17 @@ static int dsp_rec_stop(struct saa7134_d
 {
 	unsigned long flags;
 
-	dprintk("rec_stop dma_blk=%d\n",dev->oss.dma_blk);
+	dprintk("rec_stop dma_blk=%d\n",dev->dmasound.dma_blk);
 
 	/* stop dma */
-	dev->oss.recording_on = 0;
+	dev->dmasound.recording_on = 0;
 	spin_lock_irqsave(&dev->slock,flags);
 	dsp_dma_stop(dev);
 	spin_unlock_irqrestore(&dev->slock,flags);
 
 	/* unlock buffer */
-	saa7134_pgtable_free(dev->pci,&dev->oss.pt);
-	videobuf_dma_pci_unmap(dev->pci,&dev->oss.dma);
+	saa7134_pgtable_free(dev->pci,&dev->dmasound.pt);
+	videobuf_dma_pci_unmap(dev->pci,&dev->dmasound.dma);
 	return 0;
 }
 
@@ -236,35 +236,35 @@ static int dsp_open(struct inode *inode,
 
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->oss.minor_dsp == minor)
+		if (h->dmasound.minor_dsp == minor)
 			dev = h;
 	}
 	if (NULL == dev)
 		return -ENODEV;
 
-	down(&dev->oss.lock);
+	down(&dev->dmasound.lock);
 	err = -EBUSY;
-	if (dev->oss.users_dsp)
+	if (dev->dmasound.users_dsp)
 		goto fail1;
-	dev->oss.users_dsp++;
+	dev->dmasound.users_dsp++;
 	file->private_data = dev;
 
-	dev->oss.afmt        = AFMT_U8;
-	dev->oss.channels    = 1;
-	dev->oss.read_count  = 0;
-	dev->oss.read_offset = 0;
+	dev->dmasound.afmt        = AFMT_U8;
+	dev->dmasound.channels    = 1;
+	dev->dmasound.read_count  = 0;
+	dev->dmasound.read_offset = 0;
 	dsp_buffer_conf(dev,PAGE_SIZE,64);
 	err = dsp_buffer_init(dev);
 	if (0 != err)
 		goto fail2;
 
-	up(&dev->oss.lock);
+	up(&dev->dmasound.lock);
 	return 0;
 
  fail2:
-	dev->oss.users_dsp--;
+	dev->dmasound.users_dsp--;
  fail1:
-	up(&dev->oss.lock);
+	up(&dev->dmasound.lock);
 	return err;
 }
 
@@ -272,13 +272,13 @@ static int dsp_release(struct inode *ino
 {
 	struct saa7134_dev *dev = file->private_data;
 
-	down(&dev->oss.lock);
-	if (dev->oss.recording_on)
+	down(&dev->dmasound.lock);
+	if (dev->dmasound.recording_on)
 		dsp_rec_stop(dev);
 	dsp_buffer_free(dev);
-	dev->oss.users_dsp--;
+	dev->dmasound.users_dsp--;
 	file->private_data = NULL;
-	up(&dev->oss.lock);
+	up(&dev->dmasound.lock);
 	return 0;
 }
 
@@ -291,12 +291,12 @@ static ssize_t dsp_read(struct file *fil
 	unsigned long flags;
 	int err,ret = 0;
 
-	add_wait_queue(&dev->oss.wq, &wait);
-	down(&dev->oss.lock);
+	add_wait_queue(&dev->dmasound.wq, &wait);
+	down(&dev->dmasound.lock);
 	while (count > 0) {
 		/* wait for data if needed */
-		if (0 == dev->oss.read_count) {
-			if (!dev->oss.recording_on) {
+		if (0 == dev->dmasound.read_count) {
+			if (!dev->dmasound.recording_on) {
 				err = dsp_rec_start(dev);
 				if (err < 0) {
 					if (0 == ret)
@@ -304,8 +304,8 @@ static ssize_t dsp_read(struct file *fil
 					break;
 				}
 			}
-			if (dev->oss.recording_on &&
-			    !dev->oss.dma_running) {
+			if (dev->dmasound.recording_on &&
+			    !dev->dmasound.dma_running) {
 				/* recover from overruns */
 				spin_lock_irqsave(&dev->slock,flags);
 				dsp_dma_start(dev);
@@ -316,12 +316,12 @@ static ssize_t dsp_read(struct file *fil
 					ret = -EAGAIN;
 				break;
 			}
-			up(&dev->oss.lock);
+			up(&dev->dmasound.lock);
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (0 == dev->oss.read_count)
+			if (0 == dev->dmasound.read_count)
 				schedule();
 			set_current_state(TASK_RUNNING);
-			down(&dev->oss.lock);
+			down(&dev->dmasound.lock);
 			if (signal_pending(current)) {
 				if (0 == ret)
 					ret = -EINTR;
@@ -331,12 +331,12 @@ static ssize_t dsp_read(struct file *fil
 
 		/* copy data to userspace */
 		bytes = count;
-		if (bytes > dev->oss.read_count)
-			bytes = dev->oss.read_count;
-		if (bytes > dev->oss.bufsize - dev->oss.read_offset)
-			bytes = dev->oss.bufsize - dev->oss.read_offset;
+		if (bytes > dev->dmasound.read_count)
+			bytes = dev->dmasound.read_count;
+		if (bytes > dev->dmasound.bufsize - dev->dmasound.read_offset)
+			bytes = dev->dmasound.bufsize - dev->dmasound.read_offset;
 		if (copy_to_user(buffer + ret,
-				 dev->oss.dma.vmalloc + dev->oss.read_offset,
+				 dev->dmasound.dma.vmalloc + dev->dmasound.read_offset,
 				 bytes)) {
 			if (0 == ret)
 				ret = -EFAULT;
@@ -345,13 +345,13 @@ static ssize_t dsp_read(struct file *fil
 
 		ret   += bytes;
 		count -= bytes;
-		dev->oss.read_count  -= bytes;
-		dev->oss.read_offset += bytes;
-		if (dev->oss.read_offset == dev->oss.bufsize)
-			dev->oss.read_offset = 0;
+		dev->dmasound.read_count  -= bytes;
+		dev->dmasound.read_offset += bytes;
+		if (dev->dmasound.read_offset == dev->dmasound.bufsize)
+			dev->dmasound.read_offset = 0;
 	}
-	up(&dev->oss.lock);
-	remove_wait_queue(&dev->oss.wq, &wait);
+	up(&dev->dmasound.lock);
+	remove_wait_queue(&dev->dmasound.wq, &wait);
 	return ret;
 }
 
@@ -382,35 +382,35 @@ static int dsp_ioctl(struct inode *inode
 			return -EFAULT;
 		/* fall through */
 	case SOUND_PCM_READ_RATE:
-		return put_user(dev->oss.rate, p);
+		return put_user(dev->dmasound.rate, p);
 
 	case SNDCTL_DSP_STEREO:
 		if (get_user(val, p))
 			return -EFAULT;
-		down(&dev->oss.lock);
-		dev->oss.channels = val ? 2 : 1;
-		if (dev->oss.recording_on) {
+		down(&dev->dmasound.lock);
+		dev->dmasound.channels = val ? 2 : 1;
+		if (dev->dmasound.recording_on) {
 			dsp_rec_stop(dev);
 			dsp_rec_start(dev);
 		}
-		up(&dev->oss.lock);
-		return put_user(dev->oss.channels-1, p);
+		up(&dev->dmasound.lock);
+		return put_user(dev->dmasound.channels-1, p);
 
 	case SNDCTL_DSP_CHANNELS:
 		if (get_user(val, p))
 			return -EFAULT;
 		if (val != 1 && val != 2)
 			return -EINVAL;
-		down(&dev->oss.lock);
-		dev->oss.channels = val;
-		if (dev->oss.recording_on) {
+		down(&dev->dmasound.lock);
+		dev->dmasound.channels = val;
+		if (dev->dmasound.recording_on) {
 			dsp_rec_stop(dev);
 			dsp_rec_start(dev);
 		}
-		up(&dev->oss.lock);
+		up(&dev->dmasound.lock);
 		/* fall through */
 	case SOUND_PCM_READ_CHANNELS:
-		return put_user(dev->oss.channels, p);
+		return put_user(dev->dmasound.channels, p);
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask */
 		return put_user(AFMT_U8     | AFMT_S8     |
@@ -430,20 +430,20 @@ static int dsp_ioctl(struct inode *inode
 		case AFMT_U16_BE:
 		case AFMT_S16_LE:
 		case AFMT_S16_BE:
-			down(&dev->oss.lock);
-			dev->oss.afmt = val;
-			if (dev->oss.recording_on) {
+			down(&dev->dmasound.lock);
+			dev->dmasound.afmt = val;
+			if (dev->dmasound.recording_on) {
 				dsp_rec_stop(dev);
 				dsp_rec_start(dev);
 			}
-			up(&dev->oss.lock);
-			return put_user(dev->oss.afmt, p);
+			up(&dev->dmasound.lock);
+			return put_user(dev->dmasound.afmt, p);
 		default:
 			return -EINVAL;
 		}
 
 	case SOUND_PCM_READ_BITS:
-		switch (dev->oss.afmt) {
+		switch (dev->dmasound.afmt) {
 		case AFMT_U8:
 		case AFMT_S8:
 			return put_user(8, p);
@@ -461,18 +461,18 @@ static int dsp_ioctl(struct inode *inode
 		return 0;
 
 	case SNDCTL_DSP_RESET:
-		down(&dev->oss.lock);
-		if (dev->oss.recording_on)
+		down(&dev->dmasound.lock);
+		if (dev->dmasound.recording_on)
 			dsp_rec_stop(dev);
-		up(&dev->oss.lock);
+		up(&dev->dmasound.lock);
 		return 0;
 	case SNDCTL_DSP_GETBLKSIZE:
-		return put_user(dev->oss.blksize, p);
+		return put_user(dev->dmasound.blksize, p);
 
 	case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, p))
 			return -EFAULT;
-		if (dev->oss.recording_on)
+		if (dev->dmasound.recording_on)
 			return -EBUSY;
 		dsp_buffer_free(dev);
 		/* used to be arg >> 16 instead of val >> 16; fixed */
@@ -487,9 +487,9 @@ static int dsp_ioctl(struct inode *inode
 	case SNDCTL_DSP_GETISPACE:
 	{
 		audio_buf_info info;
-		info.fragsize   = dev->oss.blksize;
-		info.fragstotal = dev->oss.blocks;
-		info.bytes      = dev->oss.read_count;
+		info.fragsize   = dev->dmasound.blksize;
+		info.fragstotal = dev->dmasound.blocks;
+		info.bytes      = dev->dmasound.read_count;
 		info.fragments  = info.bytes / info.fragsize;
 		if (copy_to_user(argp, &info, sizeof(info)))
 			return -EFAULT;
@@ -505,13 +505,13 @@ static unsigned int dsp_poll(struct file
 	struct saa7134_dev *dev = file->private_data;
 	unsigned int mask = 0;
 
-	poll_wait(file, &dev->oss.wq, wait);
+	poll_wait(file, &dev->dmasound.wq, wait);
 
-	if (0 == dev->oss.read_count) {
-		down(&dev->oss.lock);
-		if (!dev->oss.recording_on)
+	if (0 == dev->dmasound.read_count) {
+		down(&dev->dmasound.lock);
+		if (!dev->dmasound.recording_on)
 			dsp_rec_start(dev);
-		up(&dev->oss.lock);
+		up(&dev->dmasound.lock);
 	} else
 		mask |= (POLLIN | POLLRDNORM);
 	return mask;
@@ -535,7 +535,7 @@ mixer_recsrc_7134(struct saa7134_dev *de
 {
 	int analog_io,rate;
 
-	switch (dev->oss.input) {
+	switch (dev->dmasound.input) {
 	case TV:
 		saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, 0xc0);
 		saa_andorb(SAA7134_SIF_SAMPLE_FREQ,   0x03, 0x00);
@@ -543,8 +543,8 @@ mixer_recsrc_7134(struct saa7134_dev *de
 	case LINE1:
 	case LINE2:
 	case LINE2_LEFT:
-		analog_io = (LINE1 == dev->oss.input) ? 0x00 : 0x08;
-		rate = (32000 == dev->oss.rate) ? 0x01 : 0x03;
+		analog_io = (LINE1 == dev->dmasound.input) ? 0x00 : 0x08;
+		rate = (32000 == dev->dmasound.rate) ? 0x01 : 0x03;
 		saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x08, analog_io);
 		saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, 0x80);
 		saa_andorb(SAA7134_SIF_SAMPLE_FREQ,   0x03, rate);
@@ -560,7 +560,7 @@ mixer_recsrc_7133(struct saa7134_dev *de
 
 	xbarin = 0x03; // adc
     anabar = 0;
-	switch (dev->oss.input) {
+	switch (dev->dmasound.input) {
 	case TV:
 		xbarin = 0; // Demodulator
 	anabar = 2; // DACs
@@ -586,9 +586,9 @@ mixer_recsrc(struct saa7134_dev *dev, en
 {
 	static const char *iname[] = { "Oops", "TV", "LINE1", "LINE2" };
 
-	dev->oss.count++;
-	dev->oss.input = src;
-	dprintk("mixer input = %s\n",iname[dev->oss.input]);
+	dev->dmasound.count++;
+	dev->dmasound.input = src;
+	dprintk("mixer input = %s\n",iname[dev->dmasound.input]);
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
@@ -640,7 +640,7 @@ static int mixer_open(struct inode *inod
 
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->oss.minor_mixer == minor)
+		if (h->dmasound.minor_mixer == minor)
 			dev = h;
 	}
 	if (NULL == dev)
@@ -676,7 +676,7 @@ static int mixer_ioctl(struct inode *ino
 		memset(&info,0,sizeof(info));
 		strlcpy(info.id,   "TV audio", sizeof(info.id));
 		strlcpy(info.name, dev->name,  sizeof(info.name));
-		info.modify_counter = dev->oss.count;
+		info.modify_counter = dev->dmasound.count;
 		if (copy_to_user(argp, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
@@ -698,26 +698,26 @@ static int mixer_ioctl(struct inode *ino
 	case MIXER_READ(SOUND_MIXER_RECMASK):
 	case MIXER_READ(SOUND_MIXER_DEVMASK):
 		val = SOUND_MASK_LINE1 | SOUND_MASK_LINE2;
-		if (32000 == dev->oss.rate)
+		if (32000 == dev->dmasound.rate)
 			val |= SOUND_MASK_VIDEO;
 		return put_user(val, p);
 
 	case MIXER_WRITE(SOUND_MIXER_RECSRC):
 		if (get_user(val, p))
 			return -EFAULT;
-		input = dev->oss.input;
-		if (32000 == dev->oss.rate  &&
-		    val & SOUND_MASK_VIDEO  &&  dev->oss.input != TV)
+		input = dev->dmasound.input;
+		if (32000 == dev->dmasound.rate  &&
+		    val & SOUND_MASK_VIDEO  &&  dev->dmasound.input != TV)
 			input = TV;
-		if (val & SOUND_MASK_LINE1  &&  dev->oss.input != LINE1)
+		if (val & SOUND_MASK_LINE1  &&  dev->dmasound.input != LINE1)
 			input = LINE1;
-		if (val & SOUND_MASK_LINE2  &&  dev->oss.input != LINE2)
+		if (val & SOUND_MASK_LINE2  &&  dev->dmasound.input != LINE2)
 			input = LINE2;
-		if (input != dev->oss.input)
+		if (input != dev->dmasound.input)
 			mixer_recsrc(dev,input);
 		/* fall throuth */
 	case MIXER_READ(SOUND_MIXER_RECSRC):
-		switch (dev->oss.input) {
+		switch (dev->dmasound.input) {
 		case TV:    ret = SOUND_MASK_VIDEO; break;
 		case LINE1: ret = SOUND_MASK_LINE1; break;
 		case LINE2: ret = SOUND_MASK_LINE2; break;
@@ -727,7 +727,7 @@ static int mixer_ioctl(struct inode *ino
 
 	case MIXER_WRITE(SOUND_MIXER_VIDEO):
 	case MIXER_READ(SOUND_MIXER_VIDEO):
-		if (32000 != dev->oss.rate)
+		if (32000 != dev->dmasound.rate)
 			return -EINVAL;
 		return put_user(100 | 100 << 8, p);
 
@@ -736,22 +736,22 @@ static int mixer_ioctl(struct inode *ino
 			return -EFAULT;
 		val &= 0xff;
 		val = (val <= 50) ? 50 : 100;
-		dev->oss.line1 = val;
-		mixer_level(dev,LINE1,dev->oss.line1);
+		dev->dmasound.line1 = val;
+		mixer_level(dev,LINE1,dev->dmasound.line1);
 		/* fall throuth */
 	case MIXER_READ(SOUND_MIXER_LINE1):
-		return put_user(dev->oss.line1 | dev->oss.line1 << 8, p);
+		return put_user(dev->dmasound.line1 | dev->dmasound.line1 << 8, p);
 
 	case MIXER_WRITE(SOUND_MIXER_LINE2):
 		if (get_user(val, p))
 			return -EFAULT;
 		val &= 0xff;
 		val = (val <= 50) ? 50 : 100;
-		dev->oss.line2 = val;
-		mixer_level(dev,LINE2,dev->oss.line2);
+		dev->dmasound.line2 = val;
+		mixer_level(dev,LINE2,dev->dmasound.line2);
 		/* fall throuth */
 	case MIXER_READ(SOUND_MIXER_LINE2):
-		return put_user(dev->oss.line2 | dev->oss.line2 << 8, p);
+		return put_user(dev->dmasound.line2 | dev->dmasound.line2 << 8, p);
 
 	default:
 		return -EINVAL;
@@ -771,8 +771,8 @@ struct file_operations saa7134_mixer_fop
 int saa7134_oss_init1(struct saa7134_dev *dev)
 {
 	/* general */
-	init_MUTEX(&dev->oss.lock);
-	init_waitqueue_head(&dev->oss.wq);
+	init_MUTEX(&dev->dmasound.lock);
+	init_waitqueue_head(&dev->dmasound.wq);
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
@@ -784,17 +784,17 @@ int saa7134_oss_init1(struct saa7134_dev
 	}
 
 	/* dsp */
-	dev->oss.rate = 32000;
+	dev->dmasound.rate = 32000;
 	if (oss_rate)
-		dev->oss.rate = oss_rate;
-	dev->oss.rate = (dev->oss.rate > 40000) ? 48000 : 32000;
+		dev->dmasound.rate = oss_rate;
+	dev->dmasound.rate = (dev->dmasound.rate > 40000) ? 48000 : 32000;
 
 	/* mixer */
-	dev->oss.line1 = 50;
-	dev->oss.line2 = 50;
-	mixer_level(dev,LINE1,dev->oss.line1);
-	mixer_level(dev,LINE2,dev->oss.line2);
-	mixer_recsrc(dev, (dev->oss.rate == 32000) ? TV : LINE2);
+	dev->dmasound.line1 = 50;
+	dev->dmasound.line2 = 50;
+	mixer_level(dev,LINE1,dev->dmasound.line1);
+	mixer_level(dev,LINE2,dev->dmasound.line2);
+	mixer_recsrc(dev, (dev->dmasound.rate == 32000) ? TV : LINE2);
 
 	return 0;
 }
@@ -810,7 +810,7 @@ void saa7134_irq_oss_done(struct saa7134
 	int next_blk, reg = 0;
 
 	spin_lock(&dev->slock);
-	if (UNSET == dev->oss.dma_blk) {
+	if (UNSET == dev->dmasound.dma_blk) {
 		dprintk("irq: recording stopped\n");
 		goto done;
 	}
@@ -818,11 +818,11 @@ void saa7134_irq_oss_done(struct saa7134
 		dprintk("irq: lost %ld\n", (status >> 24) & 0x0f);
 	if (0 == (status & 0x10000000)) {
 		/* odd */
-		if (0 == (dev->oss.dma_blk & 0x01))
+		if (0 == (dev->dmasound.dma_blk & 0x01))
 			reg = SAA7134_RS_BA1(6);
 	} else {
 		/* even */
-		if (1 == (dev->oss.dma_blk & 0x01))
+		if (1 == (dev->dmasound.dma_blk & 0x01))
 			reg = SAA7134_RS_BA2(6);
 	}
 	if (0 == reg) {
@@ -830,25 +830,25 @@ void saa7134_irq_oss_done(struct saa7134
 			(status & 0x10000000) ? "even" : "odd");
 		goto done;
 	}
-	if (dev->oss.read_count >= dev->oss.blksize * (dev->oss.blocks-2)) {
-		dprintk("irq: overrun [full=%d/%d]\n",dev->oss.read_count,
-			dev->oss.bufsize);
+	if (dev->dmasound.read_count >= dev->dmasound.blksize * (dev->dmasound.blocks-2)) {
+		dprintk("irq: overrun [full=%d/%d]\n",dev->dmasound.read_count,
+			dev->dmasound.bufsize);
 		dsp_dma_stop(dev);
 		goto done;
 	}
 
 	/* next block addr */
-	next_blk = (dev->oss.dma_blk + 2) % dev->oss.blocks;
-	saa_writel(reg,next_blk * dev->oss.blksize);
+	next_blk = (dev->dmasound.dma_blk + 2) % dev->dmasound.blocks;
+	saa_writel(reg,next_blk * dev->dmasound.blksize);
 	if (oss_debug > 2)
 		dprintk("irq: ok, %s, next_blk=%d, addr=%x\n",
 			(status & 0x10000000) ? "even" : "odd ", next_blk,
-			next_blk * dev->oss.blksize);
+			next_blk * dev->dmasound.blksize);
 
 	/* update status & wake waiting readers */
-	dev->oss.dma_blk = (dev->oss.dma_blk + 1) % dev->oss.blocks;
-	dev->oss.read_count += dev->oss.blksize;
-	wake_up(&dev->oss.wq);
+	dev->dmasound.dma_blk = (dev->dmasound.dma_blk + 1) % dev->dmasound.blocks;
+	dev->dmasound.read_count += dev->dmasound.blksize;
+	wake_up(&dev->dmasound.wq);
 
  done:
 	spin_unlock(&dev->slock);
--- hg.old.orig/drivers/media/video/saa7134/saa7134.h
+++ hg.old/drivers/media/video/saa7134/saa7134.h
@@ -355,8 +355,8 @@ struct saa7134_fh {
 	struct saa7134_pgtable     pt_vbi;
 };
 
-/* oss dsp status */
-struct saa7134_oss {
+/* dmasound dsp status */
+struct saa7134_dmasound {
 	struct semaphore           lock;
 	int                        minor_mixer;
 	int                        minor_dsp;
@@ -431,7 +431,7 @@ struct saa7134_dev {
 	struct video_device        *video_dev;
 	struct video_device        *radio_dev;
 	struct video_device        *vbi_dev;
-	struct saa7134_oss         oss;
+	struct saa7134_dmasound    dmasound;
 
 	/* infrared remote */
 	int                        has_remote;


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

