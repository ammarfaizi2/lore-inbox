Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQL3BQj>; Fri, 29 Dec 2000 20:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQL3BQa>; Fri, 29 Dec 2000 20:16:30 -0500
Received: from core.federated.com ([199.217.175.51]:53264 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S130290AbQL3BQR>; Fri, 29 Dec 2000 20:16:17 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200012300045.SAA25016@core.federated.com>
Subject: [PATCH] i810 audio fixes for 2.4.0-test13-pre5
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Dec 2000 18:45:45 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses three problems in the i810-audio driver for
2.4.0-test13-pre5.  I will be happy to split it if someone doesn't like
part of it.  (I see pre6 just popped out, there are no changes to this
driver in pre6.)

1) "DMA overrun on send" - this contains a patch from Tjeerd Mulder that
   prevents almost all of this.  I still get an occasional one during
   heavy video activity, the driver was unusable before.  (This is a smaller 
   patch than the previous flamed patch, it does no format conversion.)

2) Enable codec rate adaption - the current rate setting functions attempt 
   to get the codecs to rate adapt, but neglect to turn on the bit in the
   "Extended Audio Status and Control Register" that allows the codec to 
   actually adapt.  (Audio Codec '97, Rev 2.2, Intel, section 5.8.2)
   This allows audio of other than 48kHz if the codec supports it.

3) Add a module parameter to supress powercycling the DACs on rate change -
   This causes a big pop on the outputs at least for the CS4299 codec in
   the emachines etower 700, probably others.  I honestly can't find a 
   reason to power cycle the DACs.  There's nothing in the AC97 spec 
   that suggests it should be done.  The code is common to OSS and ALSA.
   I left the old behavior as the default.  Maybe later the default should
   change if it turns out that everyone wants to force the parameter to 
   zero.

After this is applied I will followup with another patch that 
adds /proc/driver/i810-audio/... support like the via82cxxx driver.
I don't know is user's need it, but it sure helps debugging and 
figuring out what sort of hardware is really in the computer.




--- clean-linux/drivers/sound/i810_audio.c	Wed Nov  8 19:09:50 2000
+++ linux/drivers/sound/i810_audio.c	Fri Dec 29 18:10:19 2000
@@ -102,6 +102,7 @@
 
 static int ftsodell=0;
 static unsigned int clocking=48000;
+static int cycle_power=1;
 
 
 #define ADC_RUNNING	1
@@ -382,7 +383,7 @@
 static unsigned int i810_set_dac_rate(struct i810_state * state, unsigned int rate)
 {	
 	struct dmabuf *dmabuf = &state->dmabuf;
-	u32 dacp;
+	u32 dacp=0;
 	struct ac97_codec *codec=state->card->ac97_codec[0];
 	
 	if(!(state->card->ac97_features&0x0001))
@@ -410,14 +411,23 @@
 
 	if(rate != i810_ac97_get(codec, AC97_PCM_FRONT_DAC_RATE))
 	{
+		u16 extended_status = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
+
+		/* enable variable rate audio */
+		if ( !(extended_status&1)) {
+			i810_ac97_set(codec, AC97_EXTENDED_STATUS, extended_status | 1);
+		}
+
 		/* Power down the DAC */
-		dacp=i810_ac97_get(codec, AC97_POWER_CONTROL);
-		i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0200);
+		if ( cycle_power) {
+			dacp=i810_ac97_get(codec, AC97_POWER_CONTROL);
+			i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0200);
+		}
 		/* Load the rate and read the effective rate */
 		i810_ac97_set(codec, AC97_PCM_FRONT_DAC_RATE, rate);
 		rate=i810_ac97_get(codec, AC97_PCM_FRONT_DAC_RATE);
 		/* Power it back up */
-		i810_ac97_set(codec, AC97_POWER_CONTROL, dacp);
+		if ( cycle_power) i810_ac97_set(codec, AC97_POWER_CONTROL, dacp);
 	}
 	rate=(rate * 48000) / clocking;
 	dmabuf->rate = rate;
@@ -432,7 +442,7 @@
 static unsigned int i810_set_adc_rate(struct i810_state * state, unsigned int rate)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	u32 dacp;
+	u32 dacp=0;
 	struct ac97_codec *codec=state->card->ac97_codec[0];
 	
 	if(!(state->card->ac97_features&0x0001))
@@ -460,14 +470,22 @@
 
 	if(rate != i810_ac97_get(codec, AC97_PCM_LR_DAC_RATE))
 	{
+		u16 extended_status = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
+		/* enable variable rate audio */
+		if ( !(extended_status&1)) {
+			i810_ac97_set(codec, AC97_EXTENDED_STATUS, extended_status | 1);
+		}
+
 		/* Power down the ADC */
-		dacp=i810_ac97_get(codec, AC97_POWER_CONTROL);
-		i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0100);
+		if ( cycle_power) {
+			dacp=i810_ac97_get(codec, AC97_POWER_CONTROL);
+			i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0100);
+		}
 		/* Load the rate and read the effective rate */
 		i810_ac97_set(codec, AC97_PCM_LR_DAC_RATE, rate);
 		rate=i810_ac97_get(codec, AC97_PCM_LR_DAC_RATE);
 		/* Power it back up */
-		i810_ac97_set(codec, AC97_POWER_CONTROL, dacp);
+		if ( cycle_power) i810_ac97_set(codec, AC97_POWER_CONTROL, dacp);
 	}
 	rate = (rate * 48000) / clocking;
 	dmabuf->rate = rate;
@@ -507,21 +525,19 @@
 extern __inline__ unsigned i810_get_dma_addr(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	u32 offset;
+	unsigned int civ, offset;
 	struct i810_channel *c = dmabuf->channel;
 	
 	if (!dmabuf->enable)
 		return 0;
-	offset = inb(state->card->iobase+c->port+OFF_CIV);
-	offset++;
-	offset&=31;
-	/* Offset has to compensate for the fact we finished the segment
-	   on the IRQ so we are at next_segment,0 */
-//	printk("BANK%d ", offset);
-	offset *= (dmabuf->dmasize/SG_LEN);
-//	printk("DMASZ=%d", dmabuf->dmasize);
-//	offset += 1024-(4*inw(state->card->iobase+c->port+OFF_PICB));
-//	printk("OFF%d ", offset);
+	do {
+		civ = inb(state->card->iobase+c->port+OFF_CIV);
+		offset = (civ + 1) * (dmabuf->dmasize/SG_LEN) -
+			      2 * inw(state->card->iobase+c->port+OFF_PICB);
+		/* CIV changed before we read PICB (very seldom) ?
+		 * then PICB was rubbish, so try again */
+	} while (civ != inb(state->card->iobase+c->port+OFF_CIV));
+		 
 	return offset;
 }
 
@@ -730,10 +746,13 @@
 		sg->control|=CON_IOC;
 		sg++;
 	}
+
 	spin_lock_irqsave(&state->card->lock, flags);
+	outb(2, state->card->iobase+dmabuf->channel->port + OFF_CR);   /* reset DMA machine */
 	outl(virt_to_bus(&dmabuf->channel->sg[0]), state->card->iobase+dmabuf->channel->port+OFF_BDBAR);
-	outb(16, state->card->iobase+dmabuf->channel->port+OFF_LVI);
-	outb(0, state->card->iobase+dmabuf->channel->port+OFF_CIV);
+	outb(16, state->card->iobase+dmabuf->channel->port + OFF_LVI);
+	outb(0, state->card->iobase+dmabuf->channel->port + OFF_CIV);
+
 	if (rec) {
 		i810_rec_setup(state);
 	} else {
@@ -753,14 +772,10 @@
 
 	return 0;
 }
-
-/* we are doing quantum mechanics here, the buffer can only be empty, half or full filled i.e.
-   |------------|------------|   or   |xxxxxxxxxxxx|------------|   or   |xxxxxxxxxxxx|xxxxxxxxxxxx|
-   but we almost always get this
-   |xxxxxx------|------------|   or   |xxxxxxxxxxxx|xxxxx-------|
-   so we have to clear the tail space to "silence"
-   |xxxxxx000000|------------|   or   |xxxxxxxxxxxx|xxxxxx000000|
-*/
+/*
+ * Clear the rest of the last i810 dma buffer, normally there is no rest
+ * because the OSS fragment size is the same as the size of this buffer.
+ */
 static void i810_clear_tail(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -773,14 +788,8 @@
 	swptr = dmabuf->swptr;
 	spin_unlock_irqrestore(&state->card->lock, flags);
 
-	if (swptr == 0 || swptr == dmabuf->dmasize / 2 || swptr == dmabuf->dmasize)
-		return;
-
-	if (swptr < dmabuf->dmasize/2)
-		len = dmabuf->dmasize/2 - swptr;
-	else
-		len = dmabuf->dmasize - swptr;
-
+	len = swptr % (dmabuf->dmasize/SG_LEN);
+	
 	memset(dmabuf->rawbuf + swptr, silence, len);
 
 	spin_lock_irqsave(&state->card->lock, flags);
@@ -1908,6 +1917,7 @@
 MODULE_DESCRIPTION("Intel 810 audio support");
 MODULE_PARM(ftsodell, "i");
 MODULE_PARM(clocking, "i");
+MODULE_PARM(cycle_power,"i");
 
 #define I810_MODULE_NAME "intel810_audio"
 

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
