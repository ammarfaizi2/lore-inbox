Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbREZAGB>; Fri, 25 May 2001 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262097AbREZAFw>; Fri, 25 May 2001 20:05:52 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:20955 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S262087AbREZAFj>; Fri, 25 May 2001 20:05:39 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: ChenLi Tien <cltien@cmedia.com.tw>
Subject: [PATCH] spin[un]locks revision on new cmpci driver (5.64)
Date: Fri, 25 May 2001 21:02:06 -0400
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-smp@vger.kernel.org,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01052520370200.01716@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160


HI all,

Finally I discovered my problem :-)

The following patch fixes SMP hangs w/ cmpci v5.64 ( k244-ac17 ).

- --- linux-244ac/drivers/sound/cmpci.c	Fri May 25 05:26:27 2001
+++ linux/drivers/sound/cmpci.c	Fri May 25 20:14:49 2001
@@ -1,5 +1,4 @@
 /****************************************************************************
*/
- -
 /*
  *      cmpci.c  --  C-Media PCI audio driver.
  *
@@ -76,6 +75,10 @@
  *    		   was calling prog_dmabuf with s->lock held, call missing
  *    		   unlock_kernel in cm_midi_release
  *
+ *    Fri May 25 2001 - Carlos Eduardo Gorges <carlos@techlinux.com.br>
+ *    - some drivers cleanups
+ *    - spin[un]locks revision ( fix SMP support )
+ *
  */
 
 /****************************************************************************
*/
@@ -226,10 +229,6 @@
 
 #define SND_DEV_DSP16   5 
 
- -#define	set_dac1_rate	set_adc_rate
- -#define	stop_dac1	stop_adc
- -#define	get_dmadac1	get_dmaadc
- -
 /* --------------------------------------------------------------------- */
 
 struct cm_state {
@@ -342,7 +341,6 @@
 /* --------------------------------------------------------------------- */
 
 static struct cm_state *devs;
- -static struct cm_state *devaudio;
 static unsigned long wavetable_mem;
 
 /* --------------------------------------------------------------------- */
@@ -577,8 +575,8 @@
 {
 	unsigned long flags;
 
- -	spin_lock_irqsave(&s->lock, flags);
 	set_spdifout(s, rate);
+	spin_lock_irqsave(&s->lock, flags);
 	/* enable AC3 */
 	if (rate == 48000 || rate == 44100) {
 		// mute DAC
@@ -697,7 +695,7 @@
 	if (s->curr_channels <=  2)
 		set_spdifout(s, rate);
 	if (s->status & DO_DUAL_DAC)
- -		set_dac1_rate(s, rate);
+		set_adc_rate(s, rate);
 }
 
 /* --------------------------------------------------------------------- */
@@ -759,12 +757,16 @@
 
 extern inline void enable_dac(struct cm_state *s)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
 	if (!(s->enable & CM_ENABLE_CH1)) {
 		/* enable channel */
 		s->enable |= CM_ENABLE_CH1;
 		outb(s->enable, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
 	}
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~8, 0);
+	spin_unlock_irqrestore(&s->lock, flags);
 	if (s->status & DO_DUAL_DAC)
 		enable_adc(s);
 }
@@ -794,7 +796,7 @@
 	}
 	spin_unlock_irqrestore(&s->lock, flags);
 	if (s->status & DO_DUAL_DAC)
- -		stop_dac1(s);
+		stop_adc(s);
 }
 
 static void start_adc(struct cm_state *s)
@@ -819,7 +821,9 @@
 	if ((s->dma_adc.mapped || s->dma_adc.count > 0) && s->dma_adc.ready) {
 		/* enable interrupt */
 //		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 1);
- -		enable_dac(s);
+		spin_unlock_irqrestore(&s->lock, flags);
+ 		enable_dac(s);
+		spin_lock_irqsave(&s->lock, flags);
 	}
 	spin_unlock_irqrestore(&s->lock, flags);
 }	
@@ -832,7 +836,9 @@
 	if ((s->dma_dac.mapped || s->dma_dac.count > 0) && s->dma_dac.ready) {
 		/* enable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 2);
+		spin_unlock_irqrestore(&s->lock, flags);
 		enable_dac(s);
+		spin_lock_irqsave(&s->lock, flags);
 	}
 	spin_unlock_irqrestore(&s->lock, flags);
 	if (s->status & DO_DUAL_DAC)
@@ -848,7 +854,11 @@
 	spin_lock_irqsave(&s->lock, flags);
 	if ((channels > 2) && (channels <= s->max_channels)
 	 && (((s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK) == (CM_CFMT_STEREO | 
CM_CFMT_16BIT))) {
+
+ 	    spin_unlock_irqrestore(&s->lock, flags);
 	    set_spdifout(s, 0);
+	    spin_lock_irqsave(&s->lock, flags);
+
 	    if (s->capability & CAN_MULTI_CH_HW) {
 		// NXCHG
 		maskb(s->iobase + CODEC_CMI_LEGACY_CTRL + 3, ~0, 0x80);
@@ -880,8 +890,11 @@
 		fmts |= CM_CFMT_16BIT << CM_CFMT_ADCSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_DACSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_ADCSHIFT;
+
+		spin_unlock_irqrestore(&s->lock, flags);
 		set_fmt(s, fmtm, fmts);
- -		set_dac1_rate(s, s->ratedac);
+		set_adc_rate(s, s->ratedac);
+		spin_lock_irqsave(&s->lock, flags);
 	    }
 	    // N4SPK3D, disable 4 speaker mode (analog duplicate)
 	    if (s->speakers > 2)
@@ -925,7 +938,6 @@
 	db->mapped = db->ready = 0;
 }
 
- -
 /* Ch1 is used for playback, Ch0 is used for recording */
 
 static int prog_dmabuf(struct cm_state *s, unsigned rec)
@@ -939,7 +951,6 @@
 	unsigned char fmt;
 	unsigned long flags;
 
- -	spin_lock_irqsave(&s->lock, flags);
 	fmt = s->fmt;
 	if (rec) {
 		stop_adc(s);
@@ -948,7 +959,7 @@
 		stop_dac(s);
 		fmt >>= CM_CFMT_DACSHIFT;
 	}
- -	spin_unlock_irqrestore(&s->lock, flags);
+
 	fmt &= CM_CFMT_MASK;
 	db->hwptr = db->swptr = db->total_bytes = db->count = db->error = 
db->endcleared = 0;
 	if (!db->rawbuf) {
@@ -1212,6 +1223,7 @@
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
@@ -2546,7 +2558,11 @@
 		init_timer(&s->midi.timer);
 		s->midi.timer.expires = jiffies+1;
 		s->midi.timer.data = (unsigned long)s;
+
+		spin_unlock_irqrestore(&s->lock, flags);
 		s->midi.timer.function = cm_midi_timer;
+		spin_lock_irqsave(&s->lock, flags);
+
 		add_timer(&s->midi.timer);
 	}
 	if (file->f_mode & FMODE_READ) {
- --
	 _________________________
	 Carlos E Gorges
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil
	 _________________________




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQIXAwUBOw8AkhfQA3nqPEsZFAO5+wgAx8Dkg/n3OAFF0Hp5pBmwe8rIoOMXo+sH
HZfMdeNUHMXCGy+MZhdufzj6CpVs8pgYILZqXS/cWsn2a+nAJFvBTECL70IdPUFE
bQCyDWhsaOK8jLdQEq/xOChDy4rww72XcupCWLF8KC9o3hZSxZGgDyOdltbk+//l
3sqThWQusoAkjTZjWfhpf3t5k54p3GNH2wKG5RXxLaI+r9Ef8YlYk8UGDlEhrbCW
S5SWkTShrS3iighe6I05XAJsBN5x6BSOAIODH+/tPOSXsJcR7gVmyzvKoPbLXeeT
auvnExxfeFQ7jyT08smeCXh11OxJUe1aRlAkAqcIIIgiCzLgGvt+Gwf/QzYycCuo
nmU2t81OvP95N0u8mbJwDNWxVCtWen4glir2VUfLc2GH83n3+LCEMmtKpZOviIfs
A6oON9l2uO2CfACTH/tW6PaCzEz1sZ5yZ79d1Rdf3d5qbZfAVgQFLF+Oqfthvbbe
8xj1i94rkLM/TZw/vbmLTK+DCzXI3GrXE+RI2kDa8I4hYbt6WksorABamjVKGR9v
imyMkmGyScvVtO6PM1zKbfGiOaC6GFuUjTPNNP4/CaVg66z4/3WIGfVNJkj0Ppn2
r9qdq6V39hs4xsP+gQfFsZka46/RnpGg431ZjwxmOxWnOdgerenRRpd/Wpp+PQx+
1Esxgt7dNTeWJw==
=vypo
-----END PGP SIGNATURE-----
