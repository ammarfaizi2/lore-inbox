Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWJ3MF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWJ3MF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWJ3MF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:05:26 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:3977 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750954AbWJ3MFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:05:23 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 6/7][PATCH] AMBA DMA: Patch to allow ARM PrimeCell Advanced Codec Interface to use AMBA DMA. 
Date: Mon, 30 Oct 2006 12:05:19 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8G6s1n03mWFkqRq2zSwoPKddxCA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA1DxNJgigVR4F00000007@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:05:22.0565 (UTC) FILETIME=[AD222350:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides an example of use of AMBA DMA for audio playback.
Code is targetted at the Versatile development board.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN arm_amba_pl080err/sound/arm/aaci.c arm_amba_aaci/sound/arm/aaci.c
--- arm_amba_pl080err/sound/arm/aaci.c	2006-10-17 13:29:53.000000000 +0100
+++ arm_amba_aaci/sound/arm/aaci.c	2006-10-18 08:35:36.000000000 +0100
@@ -18,6 +18,9 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/amba/bus.h>
+#if defined(CONFIG_ARM_AMBA_DMA) && defined(CONFIG_ARCH_VERSATILE) 
+# include <linux/dma-mapping.h>	
+#endif
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -31,7 +34,7 @@
 #include <sound/pcm_params.h>
 
 #include "aaci.h"
-#include "devdma.h"
+#include "devdma.h" /* DMA memory is used for the buffer even if there is
no DMA for this architecture */ 
 
 #define DRIVER_NAME	"aaci-pl041"
 
@@ -122,10 +125,9 @@ static unsigned short aaci_ac97_read(str
 	} while (v & SLFR_1TXB);
 
 	/*
-	 * Give the AC'97 codec more than enough time
-	 * to respond. (42us = ~2 frames at 48kHz.)
+	 * Allow time for AC'97 codec response
 	 */
-	udelay(42);
+	udelay(TIME_TO_RESPOND);
 
 	/*
 	 * Wait for slot 2 to indicate data.
@@ -164,6 +166,61 @@ static inline void aaci_chan_wait_ready(
 /*
  * Interrupt support.
  */
+#if defined(CONFIG_ARM_AMBA_DMA) && defined(CONFIG_ARCH_VERSATILE) 
+
+/* 
+ * Simple handler for chaining to the DMAC interrupt
+ * - called after each DMA packet (half a fifo depth)
+ * ASSUMES local interrupts disabled
+ */
+static irqreturn_t aaci_dma_irq(int irq, void *devid, struct pt_regs *regs)
+{
+
+	struct amba_device *	client	= devid;
+	struct amba_dma_data *	data 	= &(client->dma_data);
+	snd_card_t *		card 	= amba_get_drvdata(client);
+	struct aaci *		aaci 	= card->private_data;
+	struct aaci_runtime *	tsfr	= &aaci->playback;
+
+	/* e.g. check for errors */
+	data->irq_pre(0);	
+
+	/* Update pointer by one packet */
+	spin_lock(&aaci->lock);
+	{
+		tsfr->ptr += aaci->fifosize/2;
+		if (tsfr->ptr >= tsfr->end) {
+			tsfr->ptr = tsfr->start;
+		}
+		
+		tsfr->bytes -= aaci->fifosize;
+
+		if(tsfr->bytes <= 0){
+			/* Starting another period */
+			tsfr->bytes += tsfr->period;
+			spin_unlock(&aaci->lock);
+			snd_pcm_period_elapsed(tsfr->substream);
+			spin_lock(&aaci->lock);
+		}
+	}
+	spin_unlock(&aaci->lock);
+	
+	/*
+	 * Should we examine the FIFO status
+	 * to ensure we don't re-trigger on same DMABREQ
+	 */
+
+	/* e.g clear interrupt on the DMAC */
+	data->irq_post(tsfr->dma_chan);
+	
+	return IRQ_HANDLED;
+}
+
+#endif
+/*
+ * FIFO interrupt
+ * ASSUMES local interrupts disabled
+ */
 static void aaci_fifo_irq(struct aaci *aaci, u32 mask)
 {
 	if (mask & ISR_URINTR) {
@@ -330,12 +387,27 @@ static struct snd_pcm_hardware aaci_hw_i
 	.periods_max		= PAGE_SIZE / 16,
 };
 
+/*
+ *  Note that the interrupt handler is not attached until we prepare the
transfer
+ */
 static int aaci_pcm_open(struct aaci *aaci, struct snd_pcm_substream
*substream,
 			 struct aaci_runtime *aacirun)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
+#ifdef CONFIG_ARM_AMBA_DMA
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	/* 
+	 * Indicate no channel yet assigned
+	 */
+	aacirun->dma_chan = MAX_DMA_CHANNELS;
+# endif
+
+#endif
+
 	aacirun->substream = substream;
 	runtime->private_data = aacirun;
 	runtime->hw = aaci_hw_info;
@@ -357,17 +429,6 @@ static int aaci_pcm_open(struct aaci *aa
 				  aaci_rule_rate_by_channels, aaci,
 				  SNDRV_PCM_HW_PARAM_CHANNELS,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (ret)
-		goto out;
-
-	ret = request_irq(aaci->dev->irq[0], aaci_irq,
IRQF_SHARED|IRQF_DISABLED,
-			  DRIVER_NAME, aaci);
-	if (ret)
-		goto out;
-
-	return 0;
-
- out:
 	return ret;
 }
 
@@ -383,14 +444,43 @@ static int aaci_pcm_close(struct snd_pcm
 	WARN_ON(aacirun->cr & TXCR_TXEN);
 
 	aacirun->substream = NULL;
-	free_irq(aaci->dev->irq[0], aaci);
 
+#ifdef CONFIG_ARM_AMBA_DMA
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	if(MAX_DMA_CHANNELS != aacirun->dma_chan){
+		/* Free DMA channel & interrupt */
+		unsigned long flags;
+		flags = claim_dma_lock();
+		free_dma(aacirun->dma_chan);
+		aacirun->dma_chan = MAX_DMA_CHANNELS; 
+		free_irq(INT_DMAINT, aaci->dev);
+		release_dma_lock(flags);
+	} else {
+
+# endif 
+#endif	
+	/* Free the fifo interrupt */
+ 	free_irq(aaci->dev->irq[0], aaci);
+	aaci->fifo_irq_attached = 0;
+
+#ifdef CONFIG_ARM_AMBA_DMA
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+	}
+# endif 
+#endif	
+	
+	// TODO:: Should only be done when all transfers complete, not just
the playback...
+	writel(aaci->maincr & ~MAINCR_IE, aaci->base + AACI_MAINCR);
+	
 	return 0;
 }
 
+/* There may be multiple calls during one transfer */
 static int aaci_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct aaci_runtime *aacirun = substream->runtime->private_data;
+	struct aaci *aaci = substream->private_data;
 
 	/*
 	 * This must not be called with the device enabled.
@@ -404,21 +494,24 @@ static int aaci_pcm_hw_free(struct snd_p
 	/*
 	 * Clear out the DMA and any allocated buffers.
 	 */
-	devdma_hw_free(NULL, substream);
+	devdma_hw_free((struct device *)aaci->dev, substream);
+	aacirun->start = NULL;
 
 	return 0;
 }
 
+/* There may be multiple calls during one transfer */
 static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 			      struct aaci_runtime *aacirun,
 			      struct snd_pcm_hw_params *params)
 {
 	int err;
+	struct aaci *aaci = substream->private_data;
 
 	aaci_pcm_hw_free(substream);
 
-	err = devdma_hw_alloc(NULL, substream,
-			      params_buffer_bytes(params));
+	err = devdma_hw_alloc((struct device *)aaci->dev, substream,
+			 params_buffer_bytes(params));
 	if (err < 0)
 		goto out;
 
@@ -434,8 +527,19 @@ static int aaci_pcm_hw_params(struct snd
 	return err;
 }
 
+/*
+ * Setup the AACI for the transfer
+ * 
+ * There may be multiple calls during one transfer
+ *
+ * For DMA :-
+ * Finalize the linked list 
+ * - we dont know the period size until here
+ */
 static int aaci_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	int ret = -EINVAL;
+	struct aaci *aaci = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct aaci_runtime *aacirun = runtime->private_data;
 
@@ -445,9 +549,100 @@ static int aaci_pcm_prepare(struct snd_p
 	aacirun->period	=
 	aacirun->bytes	= frames_to_bytes(runtime, runtime->period_size);
 
-	return 0;
+	if(aaci->fifo_irq_attached){
+		/* 
+		 * Note that we don't try for DMA if we already have the
FIFO interrupt
+		 * TODO:: Drop the fifo, retry for DMA
+		 */
+		ret = 0;
+	} else {
+
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+		/*
+		 *	Try for DMA, if fails fall back to fifo interrrupts
+		 *	- first, attempt to attach our handler to the DMA
interrupt
+		 */
+		/* 
+		 * May be a multiple call
+		 * - if so release any assigned channel & re-acquire:- 
+		 * If using the pl080 controller and a different 
+		 * DMA buffer has been allocated 
+		 * we must set up the LLIs again
+		 */
+		if(MAX_DMA_CHANNELS != aacirun->dma_chan){ 
+			unsigned long flags;
+			flags = claim_dma_lock();
+			free_dma(aacirun->dma_chan);
+			aacirun->dma_chan = MAX_DMA_CHANNELS; 
+			free_irq(INT_DMAINT, aaci->dev);
+			release_dma_lock(flags);
+		}
+
+ 		/* The DMA interrupt is requested as shared, it may be
chained to other devices. */
+		if(!request_irq(IRQ_DMAINT, aaci_dma_irq,
SA_SHIRQ|SA_INTERRUPT,
+				DRIVER_NAME, aaci->dev)){
+
+			/* Acquired the DMA interrupt, now request a channel
for playback */
+			int i;
+			/*
+			 * Transfer half a FIFO's worth of data in each DMA
transfer
+			 * - ensures no overrun
+			 */
+			aaci->dev->dma_data.packet_size = aaci->fifosize/2;
+			/* 
+			 * FIFO register offset - DMA only available on
channel 1
+			 */
+			aaci->dev->dma_data.dmac_data = (void *)AACI_DR1;
+
+			for(i = 0; i < MAX_DMA_CHANNELS; i++){
+
+				if(!dma_channel_active(i)){
+				 	set_dma_mode (i, DMA_TO_DEVICE);
+					set_dma_addr (i,
runtime->dma_buffer_p->addr);
+					set_dma_count(i,
runtime->dma_bytes);
+
+					if(!(ret = request_dma(i,
DRIVER_NAME))){
+						aacirun->dma_chan = i;
+						break;
+					}
+
+				}
+			}
+
+			if(MAX_DMA_CHANNELS == aacirun->dma_chan)
+				free_irq(IRQ_DMAINT, aaci->dev);
+
+		} else {
+			printk(KERN_ERR "aaci.c::aaci_pcm_prepare() Couldn't
attach the interrupt handler\n");
+		}
+
+		if(MAX_DMA_CHANNELS == aacirun->dma_chan){
+			/* No DMA available - use fifo interrupts */
+# endif
+
+#endif
+	 	ret = request_irq(aaci->dev->irq[0], aaci_irq, SA_INTERRUPT,
+	 			DRIVER_NAME, aaci);
+	 	aaci->fifo_irq_attached = !ret;
+
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+		} 
+# endif
+
+#endif
+
+	}
+	return ret;
 }
 
+/*
+ * Must be atomic
+ */
 static snd_pcm_uframes_t aaci_pcm_pointer(struct snd_pcm_substream
*substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -554,9 +749,36 @@ static void aaci_pcm_playback_stop(struc
 {
 	u32 ie;
 
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	if(MAX_DMA_CHANNELS != aacirun->dma_chan){
+		struct aaci* aaci = aacirun->substream->private_data;
+		disable_dma(aacirun->dma_chan);
+		/* 
+		 * Disable DMA on the AACI by clearing the 'DMAEnable' bit. 
+		 */	
+		writel(aaci->maincr & ~MAINCR_DMAEN, aaci->base +
AACI_MAINCR);
+	} else {
+# endif
+
+#endif
+
 	ie = readl(aacirun->base + AACI_IE);
 	ie &= ~(IE_URIE|IE_TXIE);
 	writel(ie, aacirun->base + AACI_IE);
+
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	}
+
+# endif
+
+#endif
+
 	aacirun->cr &= ~TXCR_TXEN;
 	aaci_chan_wait_ready(aacirun);
 	writel(aacirun->cr, aacirun->base + AACI_TXCR);
@@ -569,12 +791,45 @@ static void aaci_pcm_playback_start(stru
 	aaci_chan_wait_ready(aacirun);
 	aacirun->cr |= TXCR_TXEN;
 
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+	/*
+	 * Ensure the DMAC finds a BREQ from the AACI
+	 * as soon as the DMAC is enabled
+	 */
+	writel(aacirun->cr, aacirun->base + AACI_TXCR);
+	if(MAX_DMA_CHANNELS != aacirun->dma_chan){
+		struct aaci* aaci = aacirun->substream->private_data;
+		/*
+		 * Set the 'DMAEnable' bit in the AACI PrimeCell. 
+		 */
+		writel(aaci->maincr | MAINCR_DMAEN, aaci->base +
AACI_MAINCR);
+		enable_dma(aacirun->dma_chan);
+	} else {
+# endif
+
+#endif
+
 	ie = readl(aacirun->base + AACI_IE);
 	ie |= IE_URIE | IE_TXIE;
 	writel(ie, aacirun->base + AACI_IE);
 	writel(aacirun->cr, aacirun->base + AACI_TXCR);
+
+#ifdef CONFIG_ARM_AMBA_DMA 
+
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	}
+
+# endif
+
+#endif
 }
 
+/*
+ * Must be atomic
+ */
 static int aaci_pcm_playback_trigger(struct snd_pcm_substream *substream,
int cmd)
 {
 	struct aaci *aaci = substream->private_data;
@@ -719,11 +974,10 @@ static int __devinit aaci_probe_ac97(str
 	udelay(2);
 	writel(RESET_NRST, aaci->base + AACI_RESET);
 
-	/*
-	 * Give the AC'97 codec more than enough time
-	 * to wake up. (42us = ~2 frames at 48kHz.)
-	 */
-	udelay(42);
+ 	/*
+	 * Allow time for AC'97 codec response
+ 	 */
+	udelay(TIME_TO_RESPOND);
 
 	ret = snd_ac97_bus(aaci->card, 0, &aaci_bus_ops, aaci, &ac97_bus);
 	if (ret)
@@ -789,6 +1043,18 @@ static struct aaci * __devinit aaci_init
 	aaci->card = card;
 	aaci->dev = dev;
 
+#ifdef CONFIG_ARM_AMBA_DMA 
+	
+# if defined(CONFIG_MACH_VERSATILE_AB) || defined
(CONFIG_ARCH_VERSATILE_PB)
+
+	/* Indicate no DMA channel in use */
+	aaci->playback.dma_chan = MAX_DMA_CHANNELS;
+ 	aaci->capture.dma_chan = MAX_DMA_CHANNELS;
+
+# endif
+
+#endif
+
 	/* Set MAINCR to allow slot 1 and 2 data IO */
 	aaci->maincr = MAINCR_IE | MAINCR_SL1RXEN | MAINCR_SL1TXEN |
 		       MAINCR_SL2RXEN | MAINCR_SL2TXEN;
@@ -831,6 +1097,8 @@ static unsigned int __devinit aaci_size_
 	 * Re-initialise the AACI after the FIFO depth test, to
 	 * ensure that the FIFOs are empty.  Unfortunately, merely
 	 * disabling the channel doesn't clear the FIFO.
+	 * PrimeCell PL041 TRM:: "The FIFOs are flushed when the AACIfEN bit

+	 * in the AACIMAINCR is deasserted"
 	 */
 	writel(aaci->maincr & ~MAINCR_IE, aaci->base + AACI_MAINCR);
 	writel(aaci->maincr, aaci->base + AACI_MAINCR);
@@ -860,6 +1128,8 @@ static int __devinit aaci_probe(struct a
 		goto out;
 	}
 
+	aaci->fifo_irq_attached = 0;
+
 	aaci->base = ioremap(dev->res.start, SZ_4K);
 	if (!aaci->base) {
 		ret = -ENOMEM;
@@ -868,6 +1138,7 @@ static int __devinit aaci_probe(struct a
 
 	/*
 	 * Playback uses AACI channel 0
+	 * - known in the PrimeCell PL041 TRM as channel 1
 	 */
 	aaci->playback.base = aaci->base + AACI_CSCH1;
 	aaci->playback.fifo = aaci->base + AACI_DR1;
diff -purN arm_amba_pl080err/sound/arm/aaci.h arm_amba_aaci/sound/arm/aaci.h
--- arm_amba_pl080err/sound/arm/aaci.h	2006-10-17 13:29:53.000000000 +0100
+++ arm_amba_aaci/sound/arm/aaci.h	2006-10-18 08:35:36.000000000 +0100
@@ -12,7 +12,7 @@
 
 /*
  * Control and status register offsets
- *  P39.
+ * - see Programmer's Model in PrimeCell PL041 TRM - ARM DDI10137
  */
 #define AACI_CSCH1	0x000
 #define AACI_CSCH2	0x014
@@ -209,6 +209,10 @@ struct aaci_runtime {
 	u32			cr;
 	struct snd_pcm_substream	*substream;
 
+#ifdef CONFIG_ARM_AMBA_DMA 
+	dmach_t 		dma_chan;
+#endif
+
 	/*
 	 * PIO support
 	 */
@@ -223,8 +227,9 @@ struct aaci_runtime {
 struct aaci {
 	struct amba_device	*dev;
 	struct snd_card		*card;
-	void			__iomem *base;
+	void			__iomem *base;	/* AACI register base */
 	unsigned int		fifosize;
+	unsigned int		fifo_irq_attached;
 
 	/* AC'97 */
 	struct mutex		ac97_sem;
@@ -242,5 +247,16 @@ struct aaci {
 #define ACSTREAM_FRONT		0
 #define ACSTREAM_SURROUND	1
 #define ACSTREAM_LFE		2
+#define TIME_TO_RESPOND		42	/* 42us = ~2 frames at
48kHz. */
+					/* This should give the AC'97 codec
*/
+					/* sufficient time to respond */ 
+#ifdef CONFIG_ARM_AMBA_DMA 
+/* 
+ * DMA only possible on audio channel 1 
+ * - the first of four - see TRM
+ */
+# define AACI_INDEX_DMACHAN	0
+# define AACI_DMACHAN		1
+#endif
 
 #endif


