Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271628AbRHPTaG>; Thu, 16 Aug 2001 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271626AbRHPT3u>; Thu, 16 Aug 2001 15:29:50 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:24234 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S271628AbRHPT3c>; Thu, 16 Aug 2001 15:29:32 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cmpci cleanups (repost)
Date: Thu, 16 Aug 2001 16:29:18 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081321022800.01012@estacao_grafica>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, please apply.

--- linux-2.4.8-ac3/drivers/sound/cmpci.c	Mon Aug 13 20:39:53 2001
+++ linux-me/drivers/sound/cmpci.c	Mon Aug 13 20:36:04 2001
@@ -75,13 +75,14 @@
  *    		   was calling prog_dmabuf with s->lock held, call missing
  *    		   unlock_kernel in cm_midi_release
  *
- *    Fri May 25 2001 - Carlos Eduardo Gorges <carlos@techlinux.com.br>
- *    - some driver cleanups
- *    - spin[un]lock* revision ( fix SMP support )
- *    - cosmetic code changes
+ *	Carlos Eduardo Gorges <carlos@techlinux.com.br>
+ *	Fri May 25 2001 
+ *	- SMP support ( spin[un]lock* revision )
+ *	- speaker mixer support 
+ *	Mon Aug 13 2001
+ *	- optimizations and cleanups
  *
  */
-
 /*****************************************************************************/
       
 #include <linux/version.h>
@@ -104,119 +105,98 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
+#include <linux/bitops.h>
 
 #include "dm.h"
 
 /* --------------------------------------------------------------------- */
-
 #undef OSS_DOCUMENTED_MIXER_SEMANTICS
-
+#undef DMABYTEIO
 /* --------------------------------------------------------------------- */
 
-#ifndef PCI_VENDOR_ID_CMEDIA
-#define PCI_VENDOR_ID_CMEDIA         0x13F6
-#endif
-#ifndef PCI_DEVICE_ID_CMEDIA_CM8338A
-#define PCI_DEVICE_ID_CMEDIA_CM8338A 0x0100
-#endif
-#ifndef PCI_DEVICE_ID_CMEDIA_CM8338B
-#define PCI_DEVICE_ID_CMEDIA_CM8338B 0x0101
-#endif
-#ifndef PCI_DEVICE_ID_CMEDIA_CM8738
-#define PCI_DEVICE_ID_CMEDIA_CM8738  0x0111
-#endif
-#ifndef PCI_DEVICE_ID_CMEDIA_CM8738B
-#define PCI_DEVICE_ID_CMEDIA_CM8738B 0x0112
-#endif
-
 #define CM_MAGIC  ((PCI_VENDOR_ID_CMEDIA<<16)|PCI_DEVICE_ID_CMEDIA_CM8338A)
 
-/*
- * CM8338 registers definition
- */
+/* CM8338 registers definition ****************/
 
-#define CODEC_CMI_FUNCTRL0      (0x00)
-#define CODEC_CMI_FUNCTRL1      (0x04)
-#define CODEC_CMI_CHFORMAT      (0x08)
-#define CODEC_CMI_INT_HLDCLR    (0x0C)
-#define CODEC_CMI_INT_STATUS    (0x10)
-#define CODEC_CMI_LEGACY_CTRL   (0x14)
-#define CODEC_CMI_MISC_CTRL     (0x18)
-#define CODEC_CMI_TDMA_POS      (0x1C)
-#define CODEC_CMI_MIXER         (0x20)
-#define CODEC_SB16_DATA         (0x22)
-#define CODEC_SB16_ADDR         (0x23)
-#define CODEC_CMI_MIXER1        (0x24)
-#define CODEC_CMI_MIXER2        (0x25)
-#define CODEC_CMI_AUX_VOL       (0x26)
-#define CODEC_CMI_MISC          (0x27)
-#define CODEC_CMI_AC97          (0x28)
-
-#define CODEC_CMI_CH0_FRAME1    (0x80)
-#define CODEC_CMI_CH0_FRAME2    (0x84)
-#define CODEC_CMI_CH1_FRAME1    (0x88)
-#define CODEC_CMI_CH1_FRAME2    (0x8C)
-
-#define CODEC_CMI_EXT_REG       (0xF0)
-#define UCHAR	unsigned char
-/*
-**  Mixer registers for SB16
-*/
-
-#define DSP_MIX_DATARESETIDX    ((UCHAR)(0x00))
-
-#define DSP_MIX_MASTERVOLIDX_L  ((UCHAR)(0x30))
-#define DSP_MIX_MASTERVOLIDX_R  ((UCHAR)(0x31))
-#define DSP_MIX_VOICEVOLIDX_L   ((UCHAR)(0x32))
-#define DSP_MIX_VOICEVOLIDX_R   ((UCHAR)(0x33))
-#define DSP_MIX_FMVOLIDX_L      ((UCHAR)(0x34))
-#define DSP_MIX_FMVOLIDX_R      ((UCHAR)(0x35))
-#define DSP_MIX_CDVOLIDX_L      ((UCHAR)(0x36))
-#define DSP_MIX_CDVOLIDX_R      ((UCHAR)(0x37))
-#define DSP_MIX_LINEVOLIDX_L    ((UCHAR)(0x38))
-#define DSP_MIX_LINEVOLIDX_R    ((UCHAR)(0x39))
-
-#define DSP_MIX_MICVOLIDX       ((UCHAR)(0x3A))
-#define DSP_MIX_SPKRVOLIDX      ((UCHAR)(0x3B))
-
-#define DSP_MIX_OUTMIXIDX       ((UCHAR)(0x3C))
-
-#define DSP_MIX_ADCMIXIDX_L     ((UCHAR)(0x3D))
-#define DSP_MIX_ADCMIXIDX_R     ((UCHAR)(0x3E))
-
-#define DSP_MIX_INGAINIDX_L     ((UCHAR)(0x3F))
-#define DSP_MIX_INGAINIDX_R     ((UCHAR)(0x40))
-#define DSP_MIX_OUTGAINIDX_L    ((UCHAR)(0x41))
-#define DSP_MIX_OUTGAINIDX_R    ((UCHAR)(0x42))
-
-#define DSP_MIX_AGCIDX          ((UCHAR)(0x43))
-
-#define DSP_MIX_TREBLEIDX_L     ((UCHAR)(0x44))
-#define DSP_MIX_TREBLEIDX_R     ((UCHAR)(0x45))
-#define DSP_MIX_BASSIDX_L       ((UCHAR)(0x46))
-#define DSP_MIX_BASSIDX_R       ((UCHAR)(0x47))
-#define CM_CH0_RESET	  0x04
-#define CM_CH1_RESET	  0x08
-#define CM_EXTENT_CODEC	  0x100
-#define CM_EXTENT_MIDI	  0x2
-#define CM_EXTENT_SYNTH	  0x4
-#define CM_INT_CH0	  1
-#define CM_INT_CH1	  2
-
-#define CM_CFMT_STEREO     0x01
-#define CM_CFMT_16BIT      0x02
-#define CM_CFMT_MASK       0x03
-#define CM_CFMT_DACSHIFT   2
-#define CM_CFMT_ADCSHIFT   0
+#define CODEC_CMI_FUNCTRL0		(0x00)
+#define CODEC_CMI_FUNCTRL1		(0x04)
+#define CODEC_CMI_CHFORMAT		(0x08)
+#define CODEC_CMI_INT_HLDCLR		(0x0C)
+#define CODEC_CMI_INT_STATUS		(0x10)
+#define CODEC_CMI_LEGACY_CTRL		(0x14)
+#define CODEC_CMI_MISC_CTRL		(0x18)
+#define CODEC_CMI_TDMA_POS		(0x1C)
+#define CODEC_CMI_MIXER			(0x20)
+#define CODEC_SB16_DATA			(0x22)
+#define CODEC_SB16_ADDR			(0x23)
+#define CODEC_CMI_MIXER1		(0x24)
+#define CODEC_CMI_MIXER2		(0x25)
+#define CODEC_CMI_AUX_VOL		(0x26)
+#define CODEC_CMI_MISC			(0x27)
+#define CODEC_CMI_AC97			(0x28)
+
+#define CODEC_CMI_CH0_FRAME1		(0x80)
+#define CODEC_CMI_CH0_FRAME2		(0x84)
+#define CODEC_CMI_CH1_FRAME1		(0x88)
+#define CODEC_CMI_CH1_FRAME2		(0x8C)
+
+#define CODEC_CMI_EXT_REG		(0xF0)
+
+/*  Mixer registers for SB16 ******************/
+
+#define DSP_MIX_DATARESETIDX		((unsigned char)(0x00))
+
+#define DSP_MIX_MASTERVOLIDX_L		((unsigned char)(0x30))
+#define DSP_MIX_MASTERVOLIDX_R		((unsigned char)(0x31))
+#define DSP_MIX_VOICEVOLIDX_L		((unsigned char)(0x32))
+#define DSP_MIX_VOICEVOLIDX_R		((unsigned char)(0x33))
+#define DSP_MIX_FMVOLIDX_L		((unsigned char)(0x34))
+#define DSP_MIX_FMVOLIDX_R		((unsigned char)(0x35))
+#define DSP_MIX_CDVOLIDX_L		((unsigned char)(0x36))
+#define DSP_MIX_CDVOLIDX_R		((unsigned char)(0x37))
+#define DSP_MIX_LINEVOLIDX_L		((unsigned char)(0x38))
+#define DSP_MIX_LINEVOLIDX_R		((unsigned char)(0x39))
+
+#define DSP_MIX_MICVOLIDX		((unsigned char)(0x3A))
+#define DSP_MIX_SPKRVOLIDX		((unsigned char)(0x3B))
+
+#define DSP_MIX_OUTMIXIDX		((unsigned char)(0x3C))
+
+#define DSP_MIX_ADCMIXIDX_L		((unsigned char)(0x3D))
+#define DSP_MIX_ADCMIXIDX_R		((unsigned char)(0x3E))
+
+#define DSP_MIX_INGAINIDX_L		((unsigned char)(0x3F))
+#define DSP_MIX_INGAINIDX_R		((unsigned char)(0x40))
+#define DSP_MIX_OUTGAINIDX_L		((unsigned char)(0x41))
+#define DSP_MIX_OUTGAINIDX_R		((unsigned char)(0x42))
+
+#define DSP_MIX_AGCIDX			((unsigned char)(0x43))
+
+#define DSP_MIX_TREBLEIDX_L		((unsigned char)(0x44))
+#define DSP_MIX_TREBLEIDX_R		((unsigned char)(0x45))
+#define DSP_MIX_BASSIDX_L		((unsigned char)(0x46))
+#define DSP_MIX_BASSIDX_R		((unsigned char)(0x47))
+
+#define CM_CH0_RESET			0x04
+#define CM_CH1_RESET			0x08
+#define CM_EXTENT_CODEC			0x100
+#define CM_EXTENT_MIDI			0x2
+#define CM_EXTENT_SYNTH			0x4
+#define CM_INT_CH0			1
+#define CM_INT_CH1			2
+
+#define CM_CFMT_STEREO			0x01
+#define CM_CFMT_16BIT			0x02
+#define CM_CFMT_MASK			0x03
+#define CM_CFMT_DACSHIFT		2
+#define CM_CFMT_ADCSHIFT		0
 
-static const unsigned sample_size[] = { 1, 2, 2, 4 };
-static const unsigned sample_shift[] = { 0, 1, 1, 2 };
+static const unsigned sample_shift[]	= { 0, 1, 1, 2 };
 
 #define CM_ENABLE_CH1      0x2
 #define CM_ENABLE_CH0      0x1
 
-
-/* MIDI buffer sizes */
+/* MIDI buffer sizes **************************/
 
 #define MIDIINBUF  256
 #define MIDIOUTBUF 256
@@ -229,35 +209,29 @@
 
 #define SND_DEV_DSP16   5 
 
-/* --------------------------------------------------------------------- */
+#define NR_DEVICE 3		/* maximum number of devices */
 
-struct cm_state {
-	/* magic */
-	unsigned int magic;
+/*********************************************/
 
-	/* we keep cm cards in a linked list */
-	struct cm_state *next;
+struct cm_state {
+	unsigned int magic;		/* magic */
+	struct cm_state *next;		/* we keep cm cards in a linked list */
 
-	/* soundcore stuff */
-	int dev_audio;
+	int dev_audio;			/* soundcore stuff */
 	int dev_mixer;
 	int dev_midi;
 	int dev_dmfm;
 
-	/* hardware resources */
-	unsigned int iosb, iobase, iosynth, iomidi, iogame, irq;
-	unsigned short deviceid;
+	unsigned int iosb, iobase, iosynth,
+			 iomidi, iogame, irq;	/* hardware resources */
+	unsigned short deviceid;		/* pci_id */
 
-        /* mixer stuff */
-        struct {
+        struct {				/* mixer stuff */
                 unsigned int modcnt;
-#ifndef OSS_DOCUMENTED_MIXER_SEMANTICS
 		unsigned short vol[13];
-#endif /* OSS_DOCUMENTED_MIXER_SEMANTICS */
         } mix;
 
-	/* wave stuff */
-	unsigned int rateadc, ratedac;
+	unsigned int rateadc, ratedac;		/* wave stuff */
 	unsigned char fmt, enable;
 
 	spinlock_t lock;
@@ -274,15 +248,15 @@
 		unsigned hwptr, swptr;
 		unsigned total_bytes;
 		int count;
-		unsigned error; /* over/underrun */
+		unsigned error;		/* over/underrun */
 		wait_queue_head_t wait;
-		/* redundant, but makes calculations easier */
-		unsigned fragsize;
+		
+		unsigned fragsize;	/* redundant, but makes calculations easier */
 		unsigned dmasize;
 		unsigned fragsamples;
 		unsigned dmasamples;
-		/* OSS stuff */
-		unsigned mapped:1;
+		
+		unsigned mapped:1;	/* OSS stuff */
 		unsigned ready:1;
 		unsigned endcleared:1;
 		unsigned ossfragshift;
@@ -290,8 +264,7 @@
 		unsigned subdivision;
 	} dma_dac, dma_adc;
 
-	/* midi stuff */
-	struct {
+	struct {			/* midi stuff */
 		unsigned ird, iwr, icnt;
 		unsigned ord, owr, ocnt;
 		wait_queue_head_t iwait;
@@ -301,44 +274,41 @@
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 	
-	/* misc stuff */
-	int	chip_version;
+	int	chip_version;		
 	int	max_channels;
-	int	curr_channels;
-	int	speakers;	// number of speakers
-	int	capability;	// HW capability, various for chip versions
-	int	status;		// HW or SW state
+	int	curr_channels;		
+	int	speakers;		/* number of speakers */
+	int	capability;		/* HW capability, various for chip versions */
+
+	int	status;			/* HW or SW state */
 	
-	/* spdif frame counter */
-	int	spdif_counter;
+	int	spdif_counter;		/* spdif frame counter */
 };
 
 /* flags used for capability */
-#define	CAN_AC3_HW	0x00000001	// 037 or later
-#define	CAN_AC3_SW	0x00000002	// 033 or later
-#define	CAN_AC3		(CAN_AC3_HW | CAN_AC3_SW)
-#define CAN_DUAL_DAC	0x00000004	// 033 or later
-#define	CAN_MULTI_CH_HW	0x00000008	// 039 or later
-#define	CAN_MULTI_CH	(CAN_MULTI_CH_HW | CAN_DUAL_DAC)
-#define	CAN_LINE_AS_REAR	0x00000010	// 033 or later
-#define	CAN_LINE_AS_BASS	0x00000020	// 039 or later
-#define	CAN_MIC_AS_BASS		0x00000040	// 039 or later
+#define	CAN_AC3_HW		0x00000001		/* 037 or later */
+#define	CAN_AC3_SW		0x00000002		/* 033 or later */
+#define	CAN_AC3			(CAN_AC3_HW | CAN_AC3_SW)
+#define CAN_DUAL_DAC		0x00000004		/* 033 or later */
+#define	CAN_MULTI_CH_HW		0x00000008		/* 039 or later */
+#define	CAN_MULTI_CH		(CAN_MULTI_CH_HW | CAN_DUAL_DAC)
+#define	CAN_LINE_AS_REAR	0x00000010		/* 033 or later */
+#define	CAN_LINE_AS_BASS	0x00000020		/* 039 or later */
+#define	CAN_MIC_AS_BASS		0x00000040		/* 039 or later */
 
 /* flags used for status */
-#define	DO_AC3_HW	0x00000001
-#define	DO_AC3_SW	0x00000002
-#define	DO_AC3		(DO_AC3_HW | DO_AC3_SW)
-#define	DO_DUAL_DAC	0x00000004
-#define	DO_MULTI_CH_HW	0x00000008
-#define	DO_MULTI_CH	(DO_MULTI_CH_HW | DO_DUAL_DAC)
-#define	DO_LINE_AS_REAR	0x00000010	// 033 or later
-#define	DO_LINE_AS_BASS	0x00000020	// 039 or later
-#define	DO_MIC_AS_BASS	0x00000040	// 039 or later
-#define	DO_SPDIF_OUT	0x00000100
-#define	DO_SPDIF_IN	0x00000200
-#define	DO_SPDIF_LOOP	0x00000400
-
-/* --------------------------------------------------------------------- */
+#define	DO_AC3_HW		0x00000001
+#define	DO_AC3_SW		0x00000002
+#define	DO_AC3			(DO_AC3_HW | DO_AC3_SW)
+#define	DO_DUAL_DAC		0x00000004
+#define	DO_MULTI_CH_HW		0x00000008
+#define	DO_MULTI_CH		(DO_MULTI_CH_HW | DO_DUAL_DAC)
+#define	DO_LINE_AS_REAR		0x00000010		/* 033 or later */
+#define	DO_LINE_AS_BASS		0x00000020		/* 039 or later */
+#define	DO_MIC_AS_BASS		0x00000040		/* 039 or later */
+#define	DO_SPDIF_OUT		0x00000100
+#define	DO_SPDIF_IN		0x00000200
+#define	DO_SPDIF_LOOP		0x00000400
 
 static struct cm_state *devs;
 static unsigned long wavetable_mem;
@@ -347,55 +317,25 @@
 
 static inline unsigned ld2(unsigned int x)
 {
-	unsigned r = 0;
+	unsigned exp=16,l=5,r=0;
+	static const unsigned num[]={0x2,0x4,0x10,0x100,0x10000};
+
+	/* num: 2, 4, 16, 256, 65536 */
+	/* exp: 1, 2,  4,   8,    16 */
 	
-	if (x >= 0x10000) {
-		x >>= 16;
-		r += 16;
-	}
-	if (x >= 0x100) {
-		x >>= 8;
-		r += 8;
-	}
-	if (x >= 0x10) {
-		x >>= 4;
-		r += 4;
-	}
-	if (x >= 4) {
-		x >>= 2;
-		r += 2;
+	while(l--) {
+		if( x >= num[l] ) {
+			if(num[l]>2) x >>= exp;
+			r+=exp;
+		}
+		exp>>=1;
 	}
-	if (x >= 2)
-		r++;
-	return r;
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#ifdef hweight32
-#undef hweight32
-#endif
 
-static inline unsigned int hweight32(unsigned int w)
-{
-        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
-        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
-        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
-        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
-        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+	return r;
 }
 
 /* --------------------------------------------------------------------- */
 
-/*
- * Why use byte IO? Nobody knows, but S3 does it also in their Windows driver.
- */
-
-#undef DMABYTEIO
-
 static void maskb(unsigned int addr, unsigned int mask, unsigned int value)
 {
 	outb((inb(addr) & mask) | value, addr);
@@ -451,15 +391,10 @@
 {
 	unsigned int curr_addr;
 
-#if 1
 	curr_addr = inw(s->iobase + CODEC_CMI_CH1_FRAME2) + 1;
 	curr_addr <<= sample_shift[(s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK];
 	curr_addr = s->dma_dac.dmasize - curr_addr;
-#else
-	curr_addr = inl(s->iobase + CODEC_CMI_CH1_FRAME1);
-	curr_addr &= ~(sample_size[(s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK]-1);
-	curr_addr -= s->dma_dac.rawphys;
-#endif
+
 	return curr_addr;
 }
 
@@ -467,15 +402,10 @@
 {
 	unsigned int curr_addr;
 
-#if 1
 	curr_addr = inw(s->iobase + CODEC_CMI_CH0_FRAME2) + 1;
 	curr_addr <<= sample_shift[(s->fmt >> CM_CFMT_ADCSHIFT) & CM_CFMT_MASK];
 	curr_addr = s->dma_adc.dmasize - curr_addr;
-#else
-	curr_addr = inl(s->iobase + CODEC_CMI_CH0_FRAME1);
-	curr_addr &= ~(sample_size[(s->fmt >> CM_CFMT_ADCSHIFT) & CM_CFMT_MASK]-1);
-	curr_addr -= s->dma_adc.rawphys;
-#endif
+
 	return curr_addr;
 }
 
@@ -488,9 +418,12 @@
 static unsigned char rdmixer(struct cm_state *s, unsigned char idx)
 {
 	unsigned char v;
-
+	unsigned long flags;
+	
+	spin_lock_irqsave(&s->lock, flags);
 	outb(idx, s->iobase + CODEC_SB16_ADDR);
 	v = inb(s->iobase + CODEC_SB16_DATA);
+	spin_unlock_irqrestore(&s->lock, flags);
 	return v;
 }
 
@@ -887,15 +820,6 @@
 	}
 }
 
-//static void start_dac1(struct cm_state *s)
-//{
-//	unsigned long flags;
-//
-//	spin_lock_irqsave(&s->lock, flags);
-//	start_dac1_unlocked(s);
-//	spin_unlock_irqrestore(&s->lock, flags);
-//}	
-
 static void start_dac_unlocked(struct cm_state *s)
 {
 	if ((s->dma_dac.mapped || s->dma_dac.count > 0) && s->dma_dac.ready) {
@@ -964,7 +888,7 @@
 		set_adc_rate_unlocked(s, s->ratedac);
 
 	    }
-	    // N4SPK3D, disable 4 speaker mode (analog duplicate)
+
 	    if (s->speakers > 2)
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 3, ~0x04, 0);
 	    s->curr_channels = channels;
@@ -1041,10 +965,10 @@
 		db->buforder = order;
 		db->rawphys = virt_to_bus(db->rawbuf);
 		if ((db->rawphys ^ (db->rawphys + (PAGE_SIZE << db->buforder) - 1)) & ~0xffff)
-			printk(KERN_DEBUG "cm: DMA buffer crosses 64k boundary: busaddr 0x%lx  size %ld\n", 
+			printk(KERN_DEBUG "cmpci: DMA buffer crosses 64k boundary: busaddr 0x%lx  size %ld\n", 
 			       (long) db->rawphys, PAGE_SIZE << db->buforder);
 		if ((db->rawphys + (PAGE_SIZE << db->buforder) - 1) & ~0xffffff)
-			printk(KERN_DEBUG "cm: DMA buffer beyond 16MB: busaddr 0x%lx  size %ld\n", 
+			printk(KERN_DEBUG "cmpci: DMA buffer beyond 16MB: busaddr 0x%lx  size %ld\n", 
 			       (long) db->rawphys, PAGE_SIZE << db->buforder);
 		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
@@ -1260,7 +1184,7 @@
 
 /* --------------------------------------------------------------------- */
 
-static const char invalid_magic[] = KERN_CRIT "cm: invalid magic value\n";
+static const char invalid_magic[] = KERN_CRIT "cmpci: invalid magic value\n";
 
 #ifdef CONFIG_SOUND_CMPCI	/* support multiple chips */
 #define VALIDATE_STATE(s)
@@ -1298,59 +1222,6 @@
 	[SOUND_MIXER_SPEAKER]= { DSP_MIX_SPKRVOLIDX,	 DSP_MIX_SPKRVOLIDX,	 MT_5MUTEMONO, 0x01, 0x01 }
 };
 
-#ifdef OSS_DOCUMENTED_MIXER_SEMANTICS
-
-static int return_mixval(struct cm_state *s, unsigned i, int *arg)
-{
-	unsigned long flags;
-	unsigned char l, r, rl, rr;
-
-	spin_lock_irqsave(&s->lock, flags);
-	l = rdmixer(s, mixtable[i].left);
-	r = rdmixer(s, mixtable[i].right);
-	spin_unlock_irqrestore(&s->lock, flags);
-	switch (mixtable[i].type) {
-	case MT_4:
-		r &= 0xf;
-		l &= 0xf;
-		rl = 10 + 6 * (l & 15);
-		rr = 10 + 6 * (r & 15);
-		break;
-
-	case MT_4MUTEMONO:
-		rl = 55 - 3 * (l & 15);
-		if (r & 0x10)
-			rl += 45;
-		rr = rl;
-		r = l;
-		break;
-
-	case MT_5MUTEMONO:
-		r = l;
-		rl = 100 - 3 * ((l >> 3) & 31);
-		rr = rl;
-		break;
-				
-	case MT_5MUTE:
-	default:
-		rl = 100 - 3 * ((l >> 3) & 31);
-		rr = 100 - 3 * ((r >> 3) & 31);
-		break;
-				
-	case MT_6MUTE:
-		rl = 100 - 3 * (l & 63) / 2;
-		rr = 100 - 3 * (r & 63) / 2;
-		break;
-	}
-	if (l & 0x80)
-		rl = 0;
-	if (r & 0x80)
-		rr = 0;
-	return put_user((rr << 8) | rl, arg);
-}
-
-#else /* OSS_DOCUMENTED_MIXER_SEMANTICS */
-
 static const unsigned char volidx[SOUND_MIXER_NRDEVICES] = 
 {
 	[SOUND_MIXER_CD]     = 1,
@@ -1362,16 +1233,11 @@
 	[SOUND_MIXER_SPEAKER]= 7
 };
 
-#endif /* OSS_DOCUMENTED_MIXER_SEMANTICS */
-
 static unsigned mixer_recmask(struct cm_state *s)
 {
-	unsigned long flags;
 	int i, j, k;
 
-	spin_lock_irqsave(&s->lock, flags);
 	j = rdmixer(s, DSP_MIX_ADCMIXIDX_L);
-	spin_unlock_irqrestore(&s->lock, flags);
 	j &= 0x7f;
 	for (k = i = 0; i < SOUND_MIXER_NRDEVICES; i++)
 		if (j & mixtable[i].rec)
@@ -1446,13 +1312,9 @@
 			i = _IOC_NR(cmd);
                         if (i >= SOUND_MIXER_NRDEVICES || !mixtable[i].type)
                                 return -EINVAL;
-#ifdef OSS_DOCUMENTED_MIXER_SEMANTICS
-			return return_mixval(s, i, (int *)arg);
-#else /* OSS_DOCUMENTED_MIXER_SEMANTICS */
 			if (!volidx[i])
 				return -EINVAL;
 			return put_user(s->mix.vol[volidx[i]-1], (int *)arg);
-#endif /* OSS_DOCUMENTED_MIXER_SEMANTICS */
 		}
 	}
         if (_IOC_DIR(cmd) != (_IOC_READ|_IOC_WRITE)) 
@@ -1462,7 +1324,7 @@
 	case SOUND_MIXER_RECSRC: /* Arg contains a bit for each recording source */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-		i = hweight32(val);
+		i = generic_hweight32(val);
 		for (j = i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
 			if (!(val & (1 << i)))
 				continue;
@@ -1554,14 +1416,11 @@
 			break;
 		}
 		spin_unlock_irqrestore(&s->lock, flags);
-#ifdef OSS_DOCUMENTED_MIXER_SEMANTICS
-                return return_mixval(s, i, (int *)arg);
-#else /* OSS_DOCUMENTED_MIXER_SEMANTICS */
+
 		if (!volidx[i])
 			return -EINVAL;
 		s->mix.vol[volidx[i]-1] = val;
 		return put_user(s->mix.vol[volidx[i]-1], (int *)arg);
-#endif /* OSS_DOCUMENTED_MIXER_SEMANTICS */
 	}
 }
 
@@ -1631,7 +1490,7 @@
 		tmo = 3 * HZ * (count + s->dma_dac.fragsize) / 2 / s->ratedac;
 		tmo >>= sample_shift[(s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK];
 		if (!schedule_timeout(tmo + 1))
-			printk(KERN_DEBUG "cm: dma timed out??\n");
+			printk(KERN_DEBUG "cmpci: dma timed out??\n");
         }
         remove_wait_queue(&s->dma_dac.wait, &wait);
         current->state = TASK_RUNNING;
@@ -1660,11 +1519,7 @@
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
 	ret = 0;
-#if 0
-   spin_lock_irqsave(&s->lock, flags);
-   cm_update_ptr(s);
-   spin_unlock_irqrestore(&s->lock, flags);
-#endif
+
 	while (count > 0) {
 		spin_lock_irqsave(&s->lock, flags);
 		swptr = s->dma_adc.swptr;
@@ -1679,7 +1534,7 @@
 			if (file->f_flags & O_NONBLOCK)
 				return ret ? ret : -EAGAIN;
 			if (!interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ)) {
-				printk(KERN_DEBUG "cm: read: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
+				printk(KERN_DEBUG "cmpci: read: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_adc.dmasize, s->dma_adc.fragsize, s->dma_adc.count,
 				       s->dma_adc.hwptr, s->dma_adc.swptr);
 				spin_lock_irqsave(&s->lock, flags);
@@ -1735,11 +1590,7 @@
 			return -EFAULT;
 	}
 	ret = 0;
-#if 0
-   spin_lock_irqsave(&s->lock, flags);
-   cm_update_ptr(s);
-   spin_unlock_irqrestore(&s->lock, flags);
-#endif                                                        
+
 	while (count > 0) {
 		spin_lock_irqsave(&s->lock, flags);
 		if (s->dma_dac.count < 0) {
@@ -1770,7 +1621,7 @@
 			if (file->f_flags & O_NONBLOCK)
 				return ret ? ret : -EAGAIN;
 			if (!interruptible_sleep_on_timeout(&s->dma_dac.wait, HZ)) {
-				printk(KERN_DEBUG "cm: write: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
+				printk(KERN_DEBUG "cmpci: write: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count,
 				       s->dma_dac.hwptr, s->dma_dac.swptr);
 				spin_lock_irqsave(&s->lock, flags);
@@ -2387,11 +2238,11 @@
 	down(&s->open_sem);
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac(s);
-#ifndef FIXEDDMA
+
 		dealloc_dmabuf(&s->dma_dac);
 		if (s->status & DO_DUAL_DAC)
 			dealloc_dmabuf(&s->dma_adc);
-#endif
+
 		if (s->status & DO_MULTI_CH)
 			set_dac_channels(s, 0);
 		if (s->status & DO_AC3)
@@ -2401,9 +2252,7 @@
 	}
 	if (file->f_mode & FMODE_READ) {
 		stop_adc(s);
-#ifndef FIXEDDMA
 		dealloc_dmabuf(&s->dma_adc);
-#endif
 	}
 	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
 	up(&s->open_sem);
@@ -2668,7 +2517,7 @@
 			}
 			tmo = (count * HZ) / 3100;
 			if (!schedule_timeout(tmo ? : 1) && tmo)
-				printk(KERN_DEBUG "cm: midi timed out??\n");
+				printk(KERN_DEBUG "cmpci: midi timed out??\n");
 		}
 		remove_wait_queue(&s->midi.owait, &wait);
 		set_current_state(TASK_RUNNING);
@@ -2867,18 +2716,7 @@
 };
 #endif /* CONFIG_SOUND_CMPCI_FM */
 
-/* --------------------------------------------------------------------- */
 
-/* maximum number of devices */
-#define NR_DEVICE 5
-
-#if 0
-static int reverb[NR_DEVICE] = { 0, };
-
-static int wavetable[NR_DEVICE] = { 0, };
-#endif
-
-/* --------------------------------------------------------------------- */
 
 static struct initvol {
 	int mixch;
@@ -2941,14 +2779,14 @@
 }
 
 #ifdef CONFIG_SOUND_CMPCI_MIDI
-static	int	mpu_io = CONFIG_SOUND_CMPCI_MPUIO;
+static	int	mpuio = CONFIG_SOUND_CMPCI_MPUIO;
 #else
-static	int	mpu_io;
+static	int	mpuio;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_FM
-static	int	fm_io = CONFIG_SOUND_CMPCI_FMIO;
+static	int	fmio = CONFIG_SOUND_CMPCI_FMIO;
 #else
-static	int	fm_io;
+static	int	fmio;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_SPDIFINVERSE
 static	int	spdif_inverse = 1;
@@ -2980,16 +2818,16 @@
 #else
 static	int	joystick;
 #endif
-MODULE_PARM(mpu_io, "i");
-MODULE_PARM(fm_io, "i");
+MODULE_PARM(mpuio, "i");
+MODULE_PARM(fmio, "i");
 MODULE_PARM(spdif_inverse, "i");
 MODULE_PARM(spdif_loop, "i");
 MODULE_PARM(speakers, "i");
 MODULE_PARM(use_line_as_rear, "i");
 MODULE_PARM(use_line_as_bass, "i");
 MODULE_PARM(joystick, "i");
-MODULE_PARM_DESC(mpu_io, "(0x330, 0x320, 0x310, 0x300) Base of MPU-401, 0 to disable");
-MODULE_PARM_DESC(fm_io, "(0x388, 0x3C8, 0x3E0) Base of OPL3, 0 to disable");
+MODULE_PARM_DESC(mpuio, "(0x330, 0x320, 0x310, 0x300) Base of MPU-401, 0 to disable");
+MODULE_PARM_DESC(fmio, "(0x388, 0x3C8, 0x3E0) Base of OPL3, 0 to disable");
 MODULE_PARM_DESC(spdif_inverse, "(1/0) Invert S/PDIF-in signal");
 MODULE_PARM_DESC(spdif_loop, "(1/0) Route S/PDIF-in to S/PDIF-out directly");
 MODULE_PARM_DESC(speakers, "(2-6) Number of speakers you connect");
@@ -3021,7 +2859,7 @@
 			return;
 		s = kmalloc(sizeof(*s), GFP_KERNEL);
 		if (!s) {
-			printk(KERN_WARNING "cm: out of memory\n");
+			printk(KERN_WARNING "cmpci: out of memory\n");
 			return;
 		}
 		/* search device name */
@@ -3042,8 +2880,8 @@
 		spin_lock_init(&s->lock);
 		s->magic = CM_MAGIC;
 		s->iobase = pci_resource_start(pcidev, 0);
-		s->iosynth = fm_io;
-		s->iomidi = mpu_io;
+		s->iosynth = fmio;
+		s->iomidi = mpuio;
 		s->status = 0;
 		/* range check */
 		if (speakers < 2)
@@ -3056,7 +2894,7 @@
 		s->irq = pcidev->irq;
 
 		if (!request_region(s->iobase, CM_EXTENT_CODEC, "cmpci")) {
-			printk(KERN_ERR "cm: io ports %#x-%#x in use\n", s->iobase, s->iobase+CM_EXTENT_CODEC-1);
+			printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iobase, s->iobase+CM_EXTENT_CODEC-1);
 			goto err_region5;
 		}
 #ifdef CONFIG_SOUND_CMPCI_MIDI
@@ -3064,7 +2902,7 @@
 		maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0x04, 0);
 		if (s->iomidi) {
 		    if (!request_region(s->iomidi, CM_EXTENT_MIDI, "cmpci Midi")) {
-			printk(KERN_ERR "cm: io ports %#x-%#x in use\n", s->iomidi, s->iomidi+CM_EXTENT_MIDI-1);
+			printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iomidi, s->iomidi+CM_EXTENT_MIDI-1);
 			s->iomidi = 0;
 		    } else {
 		        /* set IO based at 0x330 */
@@ -3098,7 +2936,7 @@
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 2, ~8, 0);
 		if (s->iosynth) {
 		    if (!request_region(s->iosynth, CM_EXTENT_SYNTH, "cmpci FM")) {
-			printk(KERN_ERR "cm: io ports %#x-%#x in use\n", s->iosynth, s->iosynth+CM_EXTENT_SYNTH-1);
+			printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iosynth, s->iosynth+CM_EXTENT_SYNTH-1);
 			s->iosynth = 0;
 		    } else {
 		        /* set IO based at 0x388 */
@@ -3140,10 +2978,10 @@
 
 		/* request irq */
 		if (request_irq(s->irq, cm_interrupt, SA_SHIRQ, "cmpci", s)) {
-			printk(KERN_ERR "cm: irq %u in use\n", s->irq);
+			printk(KERN_ERR "cmpci: irq %u in use\n", s->irq);
 			goto err_irq;
 		}
-		printk(KERN_INFO "cm: found %s adapter at io %#06x irq %u\n",
+		printk(KERN_INFO "cmpci: found %s adapter at io %#06x irq %u\n",
 		       devicename, s->iobase, s->irq);
 		/* register devices */
 		if ((s->dev_audio = register_sound_dsp(&cm_audio_fops, -1)) < 0)
@@ -3174,15 +3012,18 @@
 		/* use channel 0 for record, channel 1 for play */
 		maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~2, 1);
 		s->deviceid = pcidev->device;
+
 		if (pcidev->device == PCI_DEVICE_ID_CMEDIA_CM8738) {
+
 			/* chip version and hw capability check */
 			s->chip_version = query_chip(s);
-			printk(KERN_INFO "chip version = 0%d\n", s->chip_version);
+			printk(KERN_INFO "cmpci: chip version = 0%d\n", s->chip_version);
+
 			/* seet SPDIF-in inverse before enable SPDIF loop */
 			if (spdif_inverse) {
 				/* turn on spdif-in inverse */
 				maskb(s->iobase + CODEC_CMI_CHFORMAT + 2, ~0, 1);
-				printk(KERN_INFO "cm: Inverse SPDIF-in\n");
+				printk(KERN_INFO "cmpci: Inverse SPDIF-in\n");
 			} else {
 				/* turn off spdif-ininverse */
 				maskb(s->iobase + CODEC_CMI_CHFORMAT + 2, ~1, 0);
@@ -3193,7 +3034,7 @@
 				s->status |= DO_SPDIF_LOOP;
 				/* turn on spdif-in to spdif-out */
 				maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0, 0x80);
-				printk(KERN_INFO "cm: Enable SPDIF loop\n");
+				printk(KERN_INFO "cmpci: Enable SPDIF loop\n");
 			} else {
 				s->status &= ~DO_SPDIF_LOOP;
 				/* turn off spdif-in to spdif-out */
@@ -3234,7 +3075,7 @@
 	err_dev2:
 		unregister_sound_dsp(s->dev_audio);
 	err_dev1:
-		printk(KERN_ERR "cm: cannot register misc device\n");
+		printk(KERN_ERR "cmpci: cannot register misc device\n");
 		free_irq(s->irq, s);
 	err_irq:
 #ifdef CONFIG_SOUND_CMPCI_FM
@@ -3264,11 +3105,8 @@
 	if (!pci_present())   /* No PCI bus in this machine! */
 #endif
 		return -ENODEV;
-	printk(KERN_INFO "cm: version $Revision: 5.64 $ time " __TIME__ " " __DATE__ "\n");
-#if 0
-	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
-		printk(KERN_INFO "cm: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
-#endif
+	printk(KERN_INFO "cmpci: version $Revision: 5.64 $ time " __TIME__ " " __DATE__ "\n");
+
 	while (index < NR_DEVICE && (
 	       (pcidev = pci_find_device(PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738, pcidev)))) { 
 		initialize_chip(pcidev);
@@ -3302,10 +3140,6 @@
 		synchronize_irq();
 		outb(0, s->iobase + CODEC_CMI_FUNCTRL0 + 2); /* disable channels */
 		free_irq(s->irq, s);
-#ifdef FIXEDDMA
-    		dealloc_dmabuf(&s->dma_dac);
-    		dealloc_dmabuf(&s->dma_adc);
-#endif
 
 		/* reset mixer */
 		wrmixer(s, DSP_MIX_DATARESETIDX, 0);
@@ -3329,7 +3163,7 @@
 	}
 	if (wavetable_mem)
 		free_pages(wavetable_mem, 20-PAGE_SHIFT);
-	printk(KERN_INFO "cm: unloading\n");
+	printk(KERN_INFO "cmpci: unloading\n");
 }
 
 module_init(init_cmpci);
--- linux-2.4.8-ac3/Documentation/sound/CMI8338	Mon Aug 13 20:39:42 2001
+++ linux-me/Documentation/sound/CMI8338	Mon Aug 13 20:32:51 2001
@@ -69,8 +69,8 @@
   Some functions for the cm8738 can be configured in Kernel Configuration
   or modules parameters. Set these parameters to 1 to enable.
 
-  mpu_io:	I/O ports base for MPU-401, 0 if disabled.
-  fm_io:	I/O ports base for OPL-3, 0 if disabled.
+  mpuio:	I/O ports base for MPU-401, 0 if disabled.
+  fmio:		I/O ports base for OPL-3, 0 if disabled.
   spdif_inverse:Inverse the S/PDIF-in signal, this depends on your
 		CD-ROM or DVD-ROM.
   spdif_loop:   Enable S/PDIF loop, this route S/PDIF-in to S/PDIF-out
@@ -80,8 +80,6 @@
                 rear-out.
   use_line_as_bass:Enable this if you want to use line-in as
                 bass-out.
-  modem:	You will need to set this parameter if you want to use
-		the HSP modem. You need install the pctel.o, the modem
-		driver itself.
   joystick:	Enable joystick. You will need to install Linux joystick
 		driver.
+
--


-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________





