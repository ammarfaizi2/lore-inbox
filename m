Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbREZChG>; Fri, 25 May 2001 22:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbREZCg5>; Fri, 25 May 2001 22:36:57 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:20188 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S262536AbREZCgp>; Fri, 25 May 2001 22:36:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] spin[un]locks revision on new cmpci driver (5.64)
Date: Fri, 25 May 2001 23:35:41 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <E153Rkr-0007I4-00@the-village.bc.nu>
In-Reply-To: <E153Rkr-0007I4-00@the-village.bc.nu>
Cc: cltien@cmedia.com.tw (ChenLi Tien), linux-smp@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01052523354103.04360@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salve,

> > The following patch fixes SMP hangs w/ cmpci v5.64 ( k244-ac17 ).
>
> Let me suggest a different approach
>
> > - -	spin_lock_irqsave(&s->lock, flags);
> >  	set_spdifout(s, rate);
> > +	spin_lock_irqsave(&s->lock, flags);
>
> Split the various locked versions stuff stuff like set_adc_rate out as
> __set_adc_rate which doesnt take the lock, and set_adc_rate which takes the
> lock and calls the other one.
>
> That is how several other drivers were done and avoids messy lock/unlocks
> some of which in your changes I think introduce races
>
> Ditto for enable_dac as the old code and a newer __enable_dac, as well
> I suspect as __set_spdifout (although is that ever called by anyone not
> holding the lock ???)

I tought to implement this, but first I tryied to correct the problem.
The new patch (again revised use of spin*lock*) follows:

--- linux-244ac/drivers/sound/cmpci.c	Fri May 25 05:26:27 2001
+++ linux/drivers/sound/cmpci.c	Fri May 25 22:59:36 2001
@@ -1,5 +1,4 @@
 /****************************************************************************
*/
-
 /*
  *      cmpci.c  --  C-Media PCI audio driver.
  *
@@ -76,6 +75,11 @@
  *    		   was calling prog_dmabuf with s->lock held, call missing
  *    		   unlock_kernel in cm_midi_release
  *
+ *    Fri May 25 2001 - Carlos Eduardo Gorges <carlos@techlinux.com.br>
+ *    - some driver cleanups
+ *    - spin[un]lock* revision ( fix SMP support )
+ *    - cosmetic code changes
+ *
  */
 
 /****************************************************************************
*/
@@ -226,10 +230,6 @@
 
 #define SND_DEV_DSP16   5 
 
-#define	set_dac1_rate	set_adc_rate
-#define	stop_dac1	stop_adc
-#define	get_dmadac1	get_dmaadc
-
 /* --------------------------------------------------------------------- */
 
 struct cm_state {
@@ -342,7 +342,6 @@
 /* --------------------------------------------------------------------- */
 
 static struct cm_state *devs;
-static struct cm_state *devaudio;
 static unsigned long wavetable_mem;
 
 /* --------------------------------------------------------------------- */
@@ -496,15 +495,20 @@
 	return v;
 }
 
-static void set_fmt(struct cm_state *s, unsigned char mask, unsigned char 
data)
+static void set_fmt_unlocked(struct cm_state *s, unsigned char mask, 
unsigned char data)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&s->lock, flags);
 	if (mask)
 		s->fmt = inb(s->iobase + CODEC_CMI_CHFORMAT);
 	s->fmt = (s->fmt & mask) | data;
 	outb(s->fmt, s->iobase + CODEC_CMI_CHFORMAT);
+}
+
+static void set_fmt(struct cm_state *s, unsigned char mask, unsigned char 
data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	set_fmt_unlocked(s,mask,data);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -531,11 +535,8 @@
 	{ 48000,	(44100 + 48000) / 2,	48000,			7 }
 };
 
-static void set_spdifout(struct cm_state *s, unsigned rate)
+static void set_spdifout_unlocked(struct cm_state *s, unsigned rate)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&s->lock, flags);
 	if (rate == 48000 || rate == 44100) {
 		// SPDIFI48K SPDF_ACc97
 		maskl(s->iobase + CODEC_CMI_MISC_CTRL, ~0x01008000, rate == 48000 ? 
0x01008000 : 0);
@@ -554,6 +555,14 @@
 			maskb(s->iobase + CODEC_CMI_MIXER1, ~1, 0);
 		s->status &= ~DO_SPDIF_OUT;
 	}
+}
+
+static void set_spdifout(struct cm_state *s, unsigned rate)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	set_spdifout_unlocked(s,rate);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -573,12 +582,8 @@
 	return parity & 1;
 }
 
-static void set_ac3(struct cm_state *s, unsigned rate)
+static void set_ac3_unlocked(struct cm_state *s, unsigned rate)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&s->lock, flags);
-	set_spdifout(s, rate);
 	/* enable AC3 */
 	if (rate == 48000 || rate == 44100) {
 		// mute DAC
@@ -618,6 +623,16 @@
 		s->status &= ~DO_AC3;
 	}
 	s->spdif_counter = 0;
+
+}
+
+static void set_ac3(struct cm_state *s, unsigned rate)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	set_spdifout_unlocked(s, rate);
+	set_ac3_unlocked(s,rate);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -648,6 +663,28 @@
 	} while (--i);
 }
 
+static void set_adc_rate_unlocked(struct cm_state *s, unsigned rate)
+{
+	unsigned char freq = 4;
+	int	i;
+
+	if (rate > 48000)
+		rate = 48000;
+	if (rate < 8000)
+		rate = 8000;
+	for (i = 0; i < sizeof(rate_lookup) / sizeof(rate_lookup[0]); i++) {
+		if (rate > rate_lookup[i].lower && rate <= rate_lookup[i].upper) {
+			rate = rate_lookup[i].rate;
+			freq = rate_lookup[i].freq;
+			break;
+	    	}
+	}
+	s->rateadc = rate;
+	freq <<= 2;
+
+	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0x1c, freq);
+}
+
 static void set_adc_rate(struct cm_state *s, unsigned rate)
 {
 	unsigned long flags;
@@ -667,6 +704,7 @@
 	}
 	s->rateadc = rate;
 	freq <<= 2;
+
 	spin_lock_irqsave(&s->lock, flags);
 	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0x1c, freq);
 	spin_unlock_irqrestore(&s->lock, flags);
@@ -691,13 +729,17 @@
 	}
 	s->ratedac = rate;
 	freq <<= 5;
+
 	spin_lock_irqsave(&s->lock, flags);
 	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0xe0, freq);
-	spin_unlock_irqrestore(&s->lock, flags);
+
+
 	if (s->curr_channels <=  2)
-		set_spdifout(s, rate);
+		set_spdifout_unlocked(s, rate);
 	if (s->status & DO_DUAL_DAC)
-		set_dac1_rate(s, rate);
+		set_adc_rate_unlocked(s, rate);
+
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 /* --------------------------------------------------------------------- */
@@ -757,7 +799,7 @@
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~4, 0);
 }
 
-extern inline void enable_dac(struct cm_state *s)
+extern inline void enable_dac_unlocked(struct cm_state *s)
 {
 	if (!(s->enable & CM_ENABLE_CH1)) {
 		/* enable channel */
@@ -765,78 +807,114 @@
 		outb(s->enable, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
 	}
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~8, 0);
+
 	if (s->status & DO_DUAL_DAC)
 		enable_adc(s);
 }
 
-extern inline void stop_adc(struct cm_state *s)
+extern inline void enable_dac(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
+	enable_dac_unlocked(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+extern inline void stop_adc_unlocked(struct cm_state *s)
+{
 	if (s->enable & CM_ENABLE_CH0) {
 		/* disable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~1, 0);
 		disable_adc(s);
 	}
-	spin_unlock_irqrestore(&s->lock, flags);
 }
 
-extern inline void stop_dac(struct cm_state *s)
+extern inline void stop_adc(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
+	stop_adc_unlocked(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+
+}
+
+extern inline void stop_dac_unlocked(struct cm_state *s)
+{
 	if (s->enable & CM_ENABLE_CH1) {
 		/* disable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~2, 0);
 		disable_dac(s);
 	}
-	spin_unlock_irqrestore(&s->lock, flags);
 	if (s->status & DO_DUAL_DAC)
-		stop_dac1(s);
+		stop_adc_unlocked(s);
 }
 
-static void start_adc(struct cm_state *s)
+extern inline void stop_dac(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
+	stop_dac_unlocked(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void start_adc_unlocked(struct cm_state *s)
+{
 	if ((s->dma_adc.mapped || s->dma_adc.count < (signed)(s->dma_adc.dmasize - 
2*s->dma_adc.fragsize))
 	    && s->dma_adc.ready) {
 		/* enable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 1);
 		enable_adc(s);
 	}
-	spin_unlock_irqrestore(&s->lock, flags);
-}	
+}
 
-static void start_dac1(struct cm_state *s)
+static void start_adc(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
+	start_adc_unlocked(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+}	
+
+static void start_dac1_unlocked(struct cm_state *s)
+{
 	if ((s->dma_adc.mapped || s->dma_adc.count > 0) && s->dma_adc.ready) {
 		/* enable interrupt */
 //		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 1);
-		enable_dac(s);
+ 		enable_dac_unlocked(s);
 	}
-	spin_unlock_irqrestore(&s->lock, flags);
-}	
+}
 
-static void start_dac(struct cm_state *s)
-{
-	unsigned long flags;
+//static void start_dac1(struct cm_state *s)
+//{
+//	unsigned long flags;
+//
+//	spin_lock_irqsave(&s->lock, flags);
+//	start_dac1_unlocked(s);
+//	spin_unlock_irqrestore(&s->lock, flags);
+//}	
 
-	spin_lock_irqsave(&s->lock, flags);
+static void start_dac_unlocked(struct cm_state *s)
+{
 	if ((s->dma_dac.mapped || s->dma_dac.count > 0) && s->dma_dac.ready) {
 		/* enable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 2);
-		enable_dac(s);
+		enable_dac_unlocked(s);
 	}
+		if (s->status & DO_DUAL_DAC)
+			start_dac1_unlocked(s);
+}
+
+static void start_dac(struct cm_state *s)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	start_dac_unlocked(s);
 	spin_unlock_irqrestore(&s->lock, flags);
-	if (s->status & DO_DUAL_DAC)
-		start_dac1(s);
 }	
 
 static int prog_dmabuf(struct cm_state *s, unsigned rec);
@@ -844,11 +922,11 @@
 static int set_dac_channels(struct cm_state *s, int channels)
 {
 	unsigned long flags;
-
 	spin_lock_irqsave(&s->lock, flags);
+
 	if ((channels > 2) && (channels <= s->max_channels)
 	 && (((s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK) == (CM_CFMT_STEREO | 
CM_CFMT_16BIT))) {
-	    set_spdifout(s, 0);
+	    set_spdifout_unlocked(s, 0);
 	    if (s->capability & CAN_MULTI_CH_HW) {
 		// NXCHG
 		maskb(s->iobase + CODEC_CMI_LEGACY_CTRL + 3, ~0, 0x80);
@@ -868,10 +946,12 @@
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 2, ~0, 0xC0);
 		s->status |= DO_DUAL_DAC;
 		// prepare secondary buffer
+
 		spin_unlock_irqrestore(&s->lock, flags);
 		ret = prog_dmabuf(s, 1);
-		if (ret) return ret;
 		spin_lock_irqsave(&s->lock, flags);
+
+		if (ret) return ret;
 		// copy the hw state
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_DACSHIFT);
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_ADCSHIFT);
@@ -880,8 +960,10 @@
 		fmts |= CM_CFMT_16BIT << CM_CFMT_ADCSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_DACSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_ADCSHIFT;
-		set_fmt(s, fmtm, fmts);
-		set_dac1_rate(s, s->ratedac);
+		
+		set_fmt_unlocked(s, fmtm, fmts);
+		set_adc_rate_unlocked(s, s->ratedac);
+
 	    }
 	    // N4SPK3D, disable 4 speaker mode (analog duplicate)
 	    if (s->speakers > 2)
@@ -901,6 +983,7 @@
 	    s->status &= ~DO_MULTI_CH;
 	    s->curr_channels = s->fmt & (CM_CFMT_STEREO << CM_CFMT_DACSHIFT) ? 2 : 
1;
 	}
+
 	spin_unlock_irqrestore(&s->lock, flags);
 	return s->curr_channels;
 }
@@ -925,7 +1008,6 @@
 	db->mapped = db->ready = 0;
 }
 
-
 /* Ch1 is used for playback, Ch0 is used for recording */
 
 static int prog_dmabuf(struct cm_state *s, unsigned rec)
@@ -939,7 +1021,6 @@
 	unsigned char fmt;
 	unsigned long flags;
 
-	spin_lock_irqsave(&s->lock, flags);
 	fmt = s->fmt;
 	if (rec) {
 		stop_adc(s);
@@ -948,7 +1029,7 @@
 		stop_dac(s);
 		fmt >>= CM_CFMT_DACSHIFT;
 	}
-	spin_unlock_irqrestore(&s->lock, flags);
+
 	fmt &= CM_CFMT_MASK;
 	db->hwptr = db->swptr = db->total_bytes = db->count = db->error = 
db->endcleared = 0;
 	if (!db->rawbuf) {
@@ -1212,6 +1293,7 @@
 	[SOUND_MIXER_CD]     = { DSP_MIX_CDVOLIDX_L,     DSP_MIX_CDVOLIDX_R,     
MT_5MUTE,     0x04, 0x02 },
 	[SOUND_MIXER_LINE]   = { DSP_MIX_LINEVOLIDX_L,   DSP_MIX_LINEVOLIDX_R,   
MT_5MUTE,     0x10, 0x08 },
 	[SOUND_MIXER_MIC]    = { DSP_MIX_MICVOLIDX,      DSP_MIX_MICVOLIDX,      
MT_5MUTEMONO, 0x01, 0x01 },
+
 	[SOUND_MIXER_SYNTH]  = { DSP_MIX_FMVOLIDX_L,  	 DSP_MIX_FMVOLIDX_R,     
MT_5MUTE,     0x40, 0x00 },
 	[SOUND_MIXER_VOLUME] = { DSP_MIX_MASTERVOLIDX_L, DSP_MIX_MASTERVOLIDX_R, 
MT_5MUTE,     0x00, 0x00 },
 	[SOUND_MIXER_PCM]    = { DSP_MIX_VOICEVOLIDX_L,  DSP_MIX_VOICEVOLIDX_R,  
MT_5MUTE,     0x00, 0x00 }
@@ -1607,8 +1689,8 @@
 				printk(KERN_DEBUG "cm: read: chip lockup? dmasz %u fragsz %u count %i 
hwptr %u swptr %u\n",
 				       s->dma_adc.dmasize, s->dma_adc.fragsize, s->dma_adc.count,
 				       s->dma_adc.hwptr, s->dma_adc.swptr);
-				stop_adc(s);
 				spin_lock_irqsave(&s->lock, flags);
+				stop_adc_unlocked(s);
 				set_dmaadc(s, s->dma_adc.rawphys, s->dma_adc.dmasamples);
 				/* program sample counts */
 				set_countadc(s, s->dma_adc.fragsamples);
@@ -1625,11 +1707,11 @@
 		spin_lock_irqsave(&s->lock, flags);
 		s->dma_adc.swptr = swptr;
 		s->dma_adc.count -= cnt;
-		spin_unlock_irqrestore(&s->lock, flags);
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
-		start_adc(s);
+		start_adc_unlocked(s);
+		spin_unlock_irqrestore(&s->lock, flags);
 	}
 	return ret;
 }
@@ -1698,8 +1780,8 @@
 				printk(KERN_DEBUG "cm: write: chip lockup? dmasz %u fragsz %u count %i 
hwptr %u swptr %u\n",
 				       s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count,
 				       s->dma_dac.hwptr, s->dma_dac.swptr);
-				stop_dac(s);
 				spin_lock_irqsave(&s->lock, flags);
+				stop_dac_unlocked(s);
 				set_dmadac(s, s->dma_dac.rawphys, s->dma_dac.dmasamples);
 				/* program sample counts */
 				set_countdac(s, s->dma_dac.fragsamples);
@@ -1870,9 +1952,11 @@
 			return -EFAULT;
 		if (val >= 0) {
 			if (file->f_mode & FMODE_READ) {
-				stop_adc(s);
+			 	spin_lock_irqsave(&s->lock, flags);
+				stop_adc_unlocked(s);
 				s->dma_adc.ready = 0;
-				set_adc_rate(s, val);
+				set_adc_rate_unlocked(s, val);
+				spin_unlock_irqrestore(&s->lock, flags);
 			}
 			if (file->f_mode & FMODE_WRITE) {
 				stop_dac(s);
-- 

	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

