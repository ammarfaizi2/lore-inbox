Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290635AbSAYLTA>; Fri, 25 Jan 2002 06:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290640AbSAYLSr>; Fri, 25 Jan 2002 06:18:47 -0500
Received: from ns01.vbnet.com.br ([200.230.208.6]:30685 "EHLO ron.vbnet.com.br")
	by vger.kernel.org with ESMTP id <S290635AbSAYLSe>;
	Fri, 25 Jan 2002 06:18:34 -0500
Message-Id: <200201251412.g0PECTh12413@g0PECTh12413ron.vbnet.com.br>
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cmpci update ( 5.68LK-SMP ) (repost)
Date: Fri, 25 Jan 2002 09:19:12 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160


Maintainers, please apply.

- - --- cmpci-5.64.c	Fri Jan 25 06:51:33 2002
+++ cmpci.c	Fri Jan 25 05:55:15 2002
@@ -1,5 +1,5 @@
- - -/*****************************************************************************/
- - -/*
+/*****************************************************************************
+ *
  *      cmpci.c  --  C-Media PCI audio driver.
  *
  *      Copyright (C) 1999  ChenLi Tien (cltien@cmedia.com.tw)
@@ -8,8 +8,8 @@
  *      Based on the PCI drivers by Thomas Sailer (sailer@ife.ee.ethz.ch)
  *
  * 	For update, visit:
- - - * 		http://members.home.net/puresoft/cmedia.html
  * 		http://www.cmedia.com.tw
+ *		http://www.sourceforge.net/projects/cmedia/
  * 	
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -68,7 +68,6 @@
  *                     Add support for modem, S/PDIF loop and 4 channels.
  *                     (8738 only)
  *                     Fix bug cause x11amp cannot play.
- - - *
  *    Fixes:
  *    Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *    18/05/2001 - .bss nitpicks, fix a bug in set_dac_channels where it
@@ -76,16 +75,24 @@
  *    		   unlock_kernel in cm_midi_release
  *    08/10/2001 - use set_current_state in some more places
  *
+ *
  *	Carlos Eduardo Gorges <carlos@techlinux.com.br>
  *	Fri May 25 2001 
  *	- SMP support ( spin[un]lock* revision )
  *	- speaker mixer support 
  *	Mon Aug 13 2001
  *	- optimizations and cleanups
+ *	Thu Jan 24 2002
+ *	- sync w/ last C-media driver ( 5.68 )
+ * 	- better mixer stuff
+ *	- reference for cmpci driver at sourceforge
+ *	- change version to 5.68LK-SMP
+ *	- spin[un]lock*'s use reviewed again
  *
- - - */
- - -/*****************************************************************************/
+ *****************************************************************************/
       
+#define EXPORT_SYMTAB
+
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
@@ -106,133 +113,153 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
- - -#include <linux/bitops.h>
 
 #include "dm.h"
 
+#define __CMVERSION__	"5.68LK-SMP"	/* version */
+#define NR_DEVICE	 5		/* maximum number of devices */
+
+/* supported devices */
+#if 0
+#define PCI_VENDOR_ID_CMEDIA            0x13f6
+#define PCI_DEVICE_ID_CMEDIA_CM8338A    0x0100
+#define PCI_DEVICE_ID_CMEDIA_CM8338B    0x0101
+#define PCI_DEVICE_ID_CMEDIA_CM8738     0x0111
+#define PCI_DEVICE_ID_CMEDIA_CM8738B    0x0112
+#endif
+
 /* --------------------------------------------------------------------- */
+
 #undef OSS_DOCUMENTED_MIXER_SEMANTICS
 #undef DMABYTEIO
+
 /* --------------------------------------------------------------------- */
 
 #define CM_MAGIC  ((PCI_VENDOR_ID_CMEDIA<<16)|PCI_DEVICE_ID_CMEDIA_CM8338A)
+#define UCHAR	unsigned char
 
- - -/* CM8338 registers definition ****************/
- - -
- - -#define CODEC_CMI_FUNCTRL0		(0x00)
- - -#define CODEC_CMI_FUNCTRL1		(0x04)
- - -#define CODEC_CMI_CHFORMAT		(0x08)
- - -#define CODEC_CMI_INT_HLDCLR		(0x0C)
- - -#define CODEC_CMI_INT_STATUS		(0x10)
- - -#define CODEC_CMI_LEGACY_CTRL		(0x14)
- - -#define CODEC_CMI_MISC_CTRL		(0x18)
- - -#define CODEC_CMI_TDMA_POS		(0x1C)
- - -#define CODEC_CMI_MIXER			(0x20)
- - -#define CODEC_SB16_DATA			(0x22)
- - -#define CODEC_SB16_ADDR			(0x23)
- - -#define CODEC_CMI_MIXER1		(0x24)
- - -#define CODEC_CMI_MIXER2		(0x25)
- - -#define CODEC_CMI_AUX_VOL		(0x26)
- - -#define CODEC_CMI_MISC			(0x27)
- - -#define CODEC_CMI_AC97			(0x28)
- - -
- - -#define CODEC_CMI_CH0_FRAME1		(0x80)
- - -#define CODEC_CMI_CH0_FRAME2		(0x84)
- - -#define CODEC_CMI_CH1_FRAME1		(0x88)
- - -#define CODEC_CMI_CH1_FRAME2		(0x8C)
- - -
- - -#define CODEC_CMI_EXT_REG		(0xF0)
- - -
- - -/*  Mixer registers for SB16 ******************/
- - -
- - -#define DSP_MIX_DATARESETIDX		((unsigned char)(0x00))
- - -
- - -#define DSP_MIX_MASTERVOLIDX_L		((unsigned char)(0x30))
- - -#define DSP_MIX_MASTERVOLIDX_R		((unsigned char)(0x31))
- - -#define DSP_MIX_VOICEVOLIDX_L		((unsigned char)(0x32))
- - -#define DSP_MIX_VOICEVOLIDX_R		((unsigned char)(0x33))
- - -#define DSP_MIX_FMVOLIDX_L		((unsigned char)(0x34))
- - -#define DSP_MIX_FMVOLIDX_R		((unsigned char)(0x35))
- - -#define DSP_MIX_CDVOLIDX_L		((unsigned char)(0x36))
- - -#define DSP_MIX_CDVOLIDX_R		((unsigned char)(0x37))
- - -#define DSP_MIX_LINEVOLIDX_L		((unsigned char)(0x38))
- - -#define DSP_MIX_LINEVOLIDX_R		((unsigned char)(0x39))
- - -
- - -#define DSP_MIX_MICVOLIDX		((unsigned char)(0x3A))
- - -#define DSP_MIX_SPKRVOLIDX		((unsigned char)(0x3B))
- - -
- - -#define DSP_MIX_OUTMIXIDX		((unsigned char)(0x3C))
- - -
- - -#define DSP_MIX_ADCMIXIDX_L		((unsigned char)(0x3D))
- - -#define DSP_MIX_ADCMIXIDX_R		((unsigned char)(0x3E))
- - -
- - -#define DSP_MIX_INGAINIDX_L		((unsigned char)(0x3F))
- - -#define DSP_MIX_INGAINIDX_R		((unsigned char)(0x40))
- - -#define DSP_MIX_OUTGAINIDX_L		((unsigned char)(0x41))
- - -#define DSP_MIX_OUTGAINIDX_R		((unsigned char)(0x42))
- - -
- - -#define DSP_MIX_AGCIDX			((unsigned char)(0x43))
- - -
- - -#define DSP_MIX_TREBLEIDX_L		((unsigned char)(0x44))
- - -#define DSP_MIX_TREBLEIDX_R		((unsigned char)(0x45))
- - -#define DSP_MIX_BASSIDX_L		((unsigned char)(0x46))
- - -#define DSP_MIX_BASSIDX_R		((unsigned char)(0x47))
- - -
- - -#define CM_CH0_RESET			0x04
- - -#define CM_CH1_RESET			0x08
- - -#define CM_EXTENT_CODEC			0x100
- - -#define CM_EXTENT_MIDI			0x2
- - -#define CM_EXTENT_SYNTH			0x4
- - -#define CM_INT_CH0			1
- - -#define CM_INT_CH1			2
- - -
- - -#define CM_CFMT_STEREO			0x01
- - -#define CM_CFMT_16BIT			0x02
- - -#define CM_CFMT_MASK			0x03
- - -#define CM_CFMT_DACSHIFT		2
- - -#define CM_CFMT_ADCSHIFT		0
- - -
- - -static const unsigned sample_shift[]	= { 0, 1, 1, 2 };
- - -
- - -#define CM_ENABLE_CH1      0x2
- - -#define CM_ENABLE_CH0      0x1
- - -
- - -/* MIDI buffer sizes **************************/
- - -
- - -#define MIDIINBUF  256
- - -#define MIDIOUTBUF 256
- - -
- - -#define FMODE_MIDI_SHIFT 2
- - -#define FMODE_MIDI_READ  (FMODE_READ << FMODE_MIDI_SHIFT)
- - -#define FMODE_MIDI_WRITE (FMODE_WRITE << FMODE_MIDI_SHIFT)
+/* CM8338 registers definition */
 
- - -#define FMODE_DMFM 0x10
+#define CODEC_CMI_FUNCTRL0      (0x00)
+#define CODEC_CMI_FUNCTRL1      (0x04)
+#define CODEC_CMI_CHFORMAT      (0x08)
+#define CODEC_CMI_INT_HLDCLR    (0x0C)
+#define CODEC_CMI_INT_STATUS    (0x10)
+#define CODEC_CMI_LEGACY_CTRL   (0x14)
+#define CODEC_CMI_MISC_CTRL     (0x18)
+#define CODEC_CMI_TDMA_POS      (0x1C)
+#define CODEC_CMI_MIXER         (0x20)
+#define CODEC_SB16_DATA         (0x22)
+#define CODEC_SB16_ADDR         (0x23)
+#define CODEC_CMI_MIXER1        (0x24)
+#define CODEC_CMI_MIXER2        (0x25)
+#define CODEC_CMI_AUX_VOL       (0x26)
+#define CODEC_CMI_MISC          (0x27)
+#define CODEC_CMI_AC97          (0x28)
+
+#define CODEC_CMI_CH0_FRAME1    (0x80)
+#define CODEC_CMI_CH0_FRAME2    (0x84)
+#define CODEC_CMI_CH1_FRAME1    (0x88)
+#define CODEC_CMI_CH1_FRAME2    (0x8C)
+
+#define CODEC_CMI_EXT_REG       (0xF0)
+
+/*  Mixer registers for SB16 */
+
+#define DSP_MIX_DATARESETIDX    ((UCHAR)(0x00))
+
+#define DSP_MIX_MASTERVOLIDX_L  ((UCHAR)(0x30))
+#define DSP_MIX_MASTERVOLIDX_R  ((UCHAR)(0x31))
+#define DSP_MIX_VOICEVOLIDX_L   ((UCHAR)(0x32))
+#define DSP_MIX_VOICEVOLIDX_R   ((UCHAR)(0x33))
+#define DSP_MIX_FMVOLIDX_L      ((UCHAR)(0x34))
+#define DSP_MIX_FMVOLIDX_R      ((UCHAR)(0x35))
+#define DSP_MIX_CDVOLIDX_L      ((UCHAR)(0x36))
+#define DSP_MIX_CDVOLIDX_R      ((UCHAR)(0x37))
+#define DSP_MIX_LINEVOLIDX_L    ((UCHAR)(0x38))
+#define DSP_MIX_LINEVOLIDX_R    ((UCHAR)(0x39))
+
+#define DSP_MIX_MICVOLIDX       ((UCHAR)(0x3A))
+#define DSP_MIX_SPKRVOLIDX      ((UCHAR)(0x3B))
+
+#define DSP_MIX_OUTMIXIDX       ((UCHAR)(0x3C))
+
+#define DSP_MIX_ADCMIXIDX_L     ((UCHAR)(0x3D))
+#define DSP_MIX_ADCMIXIDX_R     ((UCHAR)(0x3E))
+
+#define DSP_MIX_INGAINIDX_L     ((UCHAR)(0x3F))
+#define DSP_MIX_INGAINIDX_R     ((UCHAR)(0x40))
+#define DSP_MIX_OUTGAINIDX_L    ((UCHAR)(0x41))
+#define DSP_MIX_OUTGAINIDX_R    ((UCHAR)(0x42))
+
+#define DSP_MIX_AGCIDX          ((UCHAR)(0x43))
+
+#define DSP_MIX_TREBLEIDX_L     ((UCHAR)(0x44))
+#define DSP_MIX_TREBLEIDX_R     ((UCHAR)(0x45))
+#define DSP_MIX_BASSIDX_L       ((UCHAR)(0x46))
+#define DSP_MIX_BASSIDX_R       ((UCHAR)(0x47))
+// pseudo register for AUX
+#define	DSP_MIX_AUXVOL_L	((UCHAR)(0x50))
+#define	DSP_MIX_AUXVOL_R	((UCHAR)(0x51))
+#define CM_CH0_RESET	 	0x04
+#define CM_CH1_RESET	  	0x08
+#define CM_EXTENT_CODEC	  	0x100
+#define CM_EXTENT_MIDI	  	0x2
+#define CM_EXTENT_SYNTH	  	0x4
+#define CM_INT_CH0	  	1
+#define CM_INT_CH1	  	2
+
+#define CM_CFMT_STEREO     	0x01
+#define CM_CFMT_16BIT      	0x02
+#define CM_CFMT_MASK       	0x03
+#define CM_CFMT_DACSHIFT   	2
+#define CM_CFMT_ADCSHIFT   	0
+
+static const unsigned sample_shift[] = { 0, 1, 1, 2 };
+
+#define CM_ENABLE_CH1      	0x2
+#define CM_ENABLE_CH0      	0x1
+
+/* MIDI buffer sizes */
+
+#define MIDIINBUF  		256
+#define MIDIOUTBUF 		256
+
+#define FMODE_MIDI_SHIFT 	2
+#define FMODE_MIDI_READ  	(FMODE_READ << FMODE_MIDI_SHIFT)
+#define FMODE_MIDI_WRITE 	(FMODE_WRITE << FMODE_MIDI_SHIFT)
 
- - -#define SND_DEV_DSP16   5 
+#define FMODE_DMFM 		0x10
 
- - -#define NR_DEVICE 3		/* maximum number of devices */
+#define SND_DEV_DSP16   	5 
 
- - -/*********************************************/
+/* --------------------------------------------------------------------- */
 
 struct cm_state {
- - -	unsigned int magic;		/* magic */
- - -	struct cm_state *next;		/* we keep cm cards in a linked list */
+	/* magic */
+	unsigned int magic;
 
- - -	int dev_audio;			/* soundcore stuff */
+	/* we keep cm cards in a linked list */
+	struct cm_state *next;
+
+	/* soundcore stuff */
+	int dev_audio;
 	int dev_mixer;
 	int dev_midi;
 	int dev_dmfm;
 
- - -	unsigned int iosb, iobase, iosynth,
- - -			 iomidi, iogame, irq;	/* hardware resources */
- - -	unsigned short deviceid;		/* pci_id */
+	/* hardware resources */
+	unsigned int iosb, iobase, iosynth, iomidi, iogame, irq;
+	unsigned short deviceid;
 
- - -        struct {				/* mixer stuff */
+        /* mixer stuff */
+        struct {
                 unsigned int modcnt;
 		unsigned short vol[13];
         } mix;
 
- - -	unsigned int rateadc, ratedac;		/* wave stuff */
+	/* wave stuff */
+	unsigned int rateadc, ratedac;
 	unsigned char fmt, enable;
 
 	spinlock_t lock;
@@ -249,15 +276,16 @@
 		unsigned hwptr, swptr;
 		unsigned total_bytes;
 		int count;
- - -		unsigned error;		/* over/underrun */
+		unsigned error; /* over/underrun */
 		wait_queue_head_t wait;
- - -		
- - -		unsigned fragsize;	/* redundant, but makes calculations easier */
+
+		/* redundant, but makes calculations easier */
+		unsigned fragsize;
 		unsigned dmasize;
 		unsigned fragsamples;
 		unsigned dmasamples;
- - -		
- - -		unsigned mapped:1;	/* OSS stuff */
+		/* OSS stuff */
+		unsigned mapped:1;
 		unsigned ready:1;
 		unsigned endcleared:1;
 		unsigned ossfragshift;
@@ -265,37 +293,41 @@
 		unsigned subdivision;
 	} dma_dac, dma_adc;
 
- - -	struct {			/* midi stuff */
+	/* midi stuff */
+	struct {
 		unsigned ird, iwr, icnt;
 		unsigned ord, owr, ocnt;
 		wait_queue_head_t iwait;
 		wait_queue_head_t owait;
+
 		struct timer_list timer;
 		unsigned char ibuf[MIDIINBUF];
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 	
- - -	int	chip_version;		
+	/* misc stuff */
+	int	modem;
+	int	chip_version;
 	int	max_channels;
- - -	int	curr_channels;		
- - -	int	speakers;		/* number of speakers */
- - -	int	capability;		/* HW capability, various for chip versions */
- - -
- - -	int	status;			/* HW or SW state */
+	int	curr_channels;
+	int	speakers;	// number of speakers
+	int	capability;	// HW capability, various for chip versions
+	int	status;		// HW or SW state
 	
- - -	int	spdif_counter;		/* spdif frame counter */
+	/* spdif frame counter */
+	int	spdif_counter;
 };
 
 /* flags used for capability */
- - -#define	CAN_AC3_HW		0x00000001		/* 037 or later */
- - -#define	CAN_AC3_SW		0x00000002		/* 033 or later */
+#define	CAN_AC3_HW		0x00000001	// 037 or later
+#define	CAN_AC3_SW		0x00000002	// 033 or later
 #define	CAN_AC3			(CAN_AC3_HW | CAN_AC3_SW)
- - -#define CAN_DUAL_DAC		0x00000004		/* 033 or later */
- - -#define	CAN_MULTI_CH_HW		0x00000008		/* 039 or later */
+#define CAN_DUAL_DAC		0x00000004	// 033 or later
+#define	CAN_MULTI_CH_HW		0x00000008	// 039 or later
 #define	CAN_MULTI_CH		(CAN_MULTI_CH_HW | CAN_DUAL_DAC)
- - -#define	CAN_LINE_AS_REAR	0x00000010		/* 033 or later */
- - -#define	CAN_LINE_AS_BASS	0x00000020		/* 039 or later */
- - -#define	CAN_MIC_AS_BASS		0x00000040		/* 039 or later */
+#define	CAN_LINE_AS_REAR	0x00000010	// 033 or later
+#define	CAN_LINE_AS_BASS	0x00000020	// 039 or later
+#define	CAN_MIC_AS_BASS		0x00000040	// 039 or later
 
 /* flags used for status */
 #define	DO_AC3_HW		0x00000001
@@ -304,25 +336,26 @@
 #define	DO_DUAL_DAC		0x00000004
 #define	DO_MULTI_CH_HW		0x00000008
 #define	DO_MULTI_CH		(DO_MULTI_CH_HW | DO_DUAL_DAC)
- - -#define	DO_LINE_AS_REAR		0x00000010		/* 033 or later */
- - -#define	DO_LINE_AS_BASS		0x00000020		/* 039 or later */
- - -#define	DO_MIC_AS_BASS		0x00000040		/* 039 or later */
+#define	DO_LINE_AS_REAR		0x00000010	// 033 or later
+#define	DO_LINE_AS_BASS		0x00000020	// 039 or later
+#define	DO_MIC_AS_BASS		0x00000040	// 039 or later
 #define	DO_SPDIF_OUT		0x00000100
 #define	DO_SPDIF_IN		0x00000200
 #define	DO_SPDIF_LOOP		0x00000400
 
- - -static struct cm_state *devs;
- - -static unsigned long wavetable_mem;
+/* --------------------------------------------------------------------- */
+
+static struct cm_state *devs = NULL;
+static unsigned long wavetable_mem = 0;
 
 /* --------------------------------------------------------------------- */
 
- - -static inline unsigned ld2(unsigned int x)
+extern __inline__ unsigned ld2(unsigned int x)
 {
 	unsigned exp=16,l=5,r=0;
 	static const unsigned num[]={0x2,0x4,0x10,0x100,0x10000};
- - -
- - -	/* num: 2, 4, 16, 256, 65536 */
- - -	/* exp: 1, 2,  4,   8,    16 */
+	/* num: 2, 4, 16, 256, 65536
+	   exp: 1, 2,  4,   8,    16 */
 	
 	while(l--) {
 		if( x >= num[l] ) {
@@ -331,12 +364,15 @@
 		}
 		exp>>=1;
 	}
- - -
 	return r;
 }
 
 /* --------------------------------------------------------------------- */
 
+/*
+ * Why use byte IO? Nobody knows, but S3 does it also in their Windows driver.
+ */
+
 static void maskb(unsigned int addr, unsigned int mask, unsigned int value)
 {
 	outb((inb(addr) & mask) | value, addr);
@@ -352,7 +388,7 @@
 	outl((inl(addr) & mask) | value, addr);
 }
 
- - -static void set_dmadac1(struct cm_state *s, unsigned int addr, unsigned int count)
+static void __set_dmadac1(struct cm_state *s, unsigned int addr, unsigned int count)
 {
 	if (addr)
 	    outl(addr, s->iobase + CODEC_CMI_CH0_FRAME1);
@@ -360,60 +396,92 @@
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~1, 0);
 }
 
- - -static void set_dmaadc(struct cm_state *s, unsigned int addr, unsigned int count)
+static void __set_dmaadc(struct cm_state *s, unsigned int addr, unsigned int count)
 {
 	outl(addr, s->iobase + CODEC_CMI_CH0_FRAME1);
 	outw(count - 1, s->iobase + CODEC_CMI_CH0_FRAME2);
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~0, 1);
 }
 
- - -static void set_dmadac(struct cm_state *s, unsigned int addr, unsigned int count)
+static void __set_dmadac(struct cm_state *s, unsigned int addr, unsigned int count)
 {
 	outl(addr, s->iobase + CODEC_CMI_CH1_FRAME1);
 	outw(count - 1, s->iobase + CODEC_CMI_CH1_FRAME2);
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~2, 0);
 	if (s->status & DO_DUAL_DAC)
- - -		set_dmadac1(s, 0, count);
+		__set_dmadac1(s, 0, count);
 }
 
- - -static void set_countadc(struct cm_state *s, unsigned count)
+static void __set_countadc(struct cm_state *s, unsigned count)
 {
 	outw(count - 1, s->iobase + CODEC_CMI_CH0_FRAME2 + 2);
 }
 
- - -static void set_countdac(struct cm_state *s, unsigned count)
+static void __set_countdac(struct cm_state *s, unsigned count)
 {
 	outw(count - 1, s->iobase + CODEC_CMI_CH1_FRAME2 + 2);
 	if (s->status & DO_DUAL_DAC)
- - -	    set_countadc(s, count);
+	    __set_countadc(s, count);
 }
 
- - -static inline unsigned get_dmadac(struct cm_state *s)
+extern __inline__ unsigned get_dmadac(struct cm_state *s)
 {
 	unsigned int curr_addr;
 
 	curr_addr = inw(s->iobase + CODEC_CMI_CH1_FRAME2) + 1;
 	curr_addr <<= sample_shift[(s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK];
 	curr_addr = s->dma_dac.dmasize - curr_addr;
- - -
 	return curr_addr;
 }
 
- - -static inline unsigned get_dmaadc(struct cm_state *s)
+extern __inline__ unsigned get_dmaadc(struct cm_state *s)
 {
 	unsigned int curr_addr;
 
 	curr_addr = inw(s->iobase + CODEC_CMI_CH0_FRAME2) + 1;
 	curr_addr <<= sample_shift[(s->fmt >> CM_CFMT_ADCSHIFT) & CM_CFMT_MASK];
 	curr_addr = s->dma_adc.dmasize - curr_addr;
- - -
 	return curr_addr;
 }
 
 static void wrmixer(struct cm_state *s, unsigned char idx, unsigned char data)
 {
+	unsigned char regval, pseudo;
+
+	// pseudo register
+	if (idx == DSP_MIX_AUXVOL_L) {
+		data >>= 4;
+		data &= 0x0f;
+		regval = inb(s->iobase + CODEC_CMI_AUX_VOL) & ~0x0f;
+		outb(regval | data, s->iobase + CODEC_CMI_AUX_VOL);
+		return;
+	}
+	if (idx == DSP_MIX_AUXVOL_R) {
+		data &= 0xf0;
+		regval = inb(s->iobase + CODEC_CMI_AUX_VOL) & ~0xf0;
+		outb(regval | data, s->iobase + CODEC_CMI_AUX_VOL);
+		return;
+	}
 	outb(idx, s->iobase + CODEC_SB16_ADDR);
 	udelay(10);
+	// pseudo bits
+	if (idx == DSP_MIX_OUTMIXIDX) {
+		pseudo = data & ~0x1f;
+		pseudo >>= 1;	
+		regval = inb(s->iobase + CODEC_CMI_MIXER2) & ~0x30;
+		outb(regval | pseudo, s->iobase + CODEC_CMI_MIXER2);
+	}
+	if (idx == DSP_MIX_ADCMIXIDX_L) {
+		pseudo = data & 0x80;
+		pseudo >>= 1;
+		regval = inb(s->iobase + CODEC_CMI_MIXER2) & ~0x40;
+		outb(regval | pseudo, s->iobase + CODEC_CMI_MIXER2);
+	}
+	if (idx == DSP_MIX_ADCMIXIDX_R) {
+		pseudo = data & 0x80;
+		regval = inb(s->iobase + CODEC_CMI_MIXER2) & ~0x80;
+		outb(regval | pseudo, s->iobase + CODEC_CMI_MIXER2);
+	}
 	outb(data, s->iobase + CODEC_SB16_DATA);
 	udelay(10);
 }
@@ -421,21 +489,43 @@
 static unsigned char rdmixer(struct cm_state *s, unsigned char idx)
 {
 	unsigned char v;
- - -	unsigned long flags;
- - -	
- - -	spin_lock_irqsave(&s->lock, flags);
+	unsigned char pseudo;
+
+	// pseudo register
+	if (idx == DSP_MIX_AUXVOL_L) {
+		v = inb(s->iobase + CODEC_CMI_AUX_VOL) & 0x0f;
+		v <<= 4;
+		return v;
+	}
+	if (idx == DSP_MIX_AUXVOL_L) {
+		v = inb(s->iobase + CODEC_CMI_AUX_VOL) & 0xf0;
+		return v;
+	}
 	outb(idx, s->iobase + CODEC_SB16_ADDR);
 	udelay(10);
 	v = inb(s->iobase + CODEC_SB16_DATA);
 	udelay(10);
- - -	spin_unlock_irqrestore(&s->lock, flags);
+	// pseudo bits
+	if (idx == DSP_MIX_OUTMIXIDX) {
+		pseudo = inb(s->iobase + CODEC_CMI_MIXER2) & 0x30;
+		pseudo <<= 1;
+		v |= pseudo;
+	}
+	if (idx == DSP_MIX_ADCMIXIDX_L) {
+		pseudo = inb(s->iobase + CODEC_CMI_MIXER2) & 0x40;
+		pseudo <<= 1;
+		v |= pseudo;
+	}
+	if (idx == DSP_MIX_ADCMIXIDX_R) {
+		pseudo = inb(s->iobase + CODEC_CMI_MIXER2) & 0x80;
+		v |= pseudo;
+	}
 	return v;
 }
 
- - -static void set_fmt_unlocked(struct cm_state *s, unsigned char mask, unsigned char data)
+static void __set_fmt(struct cm_state *s, unsigned char mask, unsigned char data)
 {
- - -	if (mask)
- - -	{
+	if (mask) {
 		s->fmt = inb(s->iobase + CODEC_CMI_CHFORMAT);
 		udelay(10);
 	}
@@ -449,7 +539,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	set_fmt_unlocked(s,mask,data);
+	__set_fmt(s,mask,data);	
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -478,7 +568,7 @@
 	{ 48000,	(44100 + 48000) / 2,	48000,			7 }
 };
 
- - -static void set_spdifout_unlocked(struct cm_state *s, unsigned rate)
+static void __set_spdifout(struct cm_state *s, unsigned rate)
 {
 	if (rate == 48000 || rate == 44100) {
 		// SPDIFI48K SPDF_ACc97
@@ -505,7 +595,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	set_spdifout_unlocked(s,rate);
+	__set_spdifout(s, rate);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -525,8 +615,9 @@
 	return parity & 1;
 }
 
- - -static void set_ac3_unlocked(struct cm_state *s, unsigned rate)
+static void __set_ac3(struct cm_state *s, unsigned rate)
 {
+	__set_spdifout(s, rate);
 	/* enable AC3 */
 	if (rate == 48000 || rate == 44100) {
 		// mute DAC
@@ -566,7 +657,6 @@
 		s->status &= ~DO_AC3;
 	}
 	s->spdif_counter = 0;
- - -
 }
 
 static void set_ac3(struct cm_state *s, unsigned rate)
@@ -574,8 +664,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	set_spdifout_unlocked(s, rate);
- - -	set_ac3_unlocked(s,rate);
+	__set_ac3(s, rate);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
@@ -606,7 +695,7 @@
 	} while (--i);
 }
 
- - -static void set_adc_rate_unlocked(struct cm_state *s, unsigned rate)
+static void __set_adc_rate(struct cm_state *s, unsigned rate)
 {
 	unsigned char freq = 4;
 	int	i;
@@ -624,38 +713,20 @@
 	}
 	s->rateadc = rate;
 	freq <<= 2;
- - -
 	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0x1c, freq);
 }
 
 static void set_adc_rate(struct cm_state *s, unsigned rate)
 {
 	unsigned long flags;
- - -	unsigned char freq = 4;
- - -	int	i;
- - -
- - -	if (rate > 48000)
- - -		rate = 48000;
- - -	if (rate < 8000)
- - -		rate = 8000;
- - -	for (i = 0; i < sizeof(rate_lookup) / sizeof(rate_lookup[0]); i++) {
- - -		if (rate > rate_lookup[i].lower && rate <= rate_lookup[i].upper) {
- - -			rate = rate_lookup[i].rate;
- - -			freq = rate_lookup[i].freq;
- - -			break;
- - -	    	}
- - -	}
- - -	s->rateadc = rate;
- - -	freq <<= 2;
- - -
+	
 	spin_lock_irqsave(&s->lock, flags);
- - -	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0x1c, freq);
+	__set_adc_rate(s, rate);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
- - -static void set_dac_rate(struct cm_state *s, unsigned rate)
+static void __set_dac_rate(struct cm_state *s, unsigned rate)
 {
- - -	unsigned long flags;
 	unsigned char freq = 4;
 	int	i;
 
@@ -673,18 +744,14 @@
 	s->ratedac = rate;
 	freq <<= 5;
 
- - -	spin_lock_irqsave(&s->lock, flags);
 	maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0xe0, freq);
- - -
- - -
 	if (s->curr_channels <=  2)
- - -		set_spdifout_unlocked(s, rate);
+		__set_spdifout(s, rate);
 	if (s->status & DO_DUAL_DAC)
- - -		set_adc_rate_unlocked(s, rate);
- - -
- - -	spin_unlock_irqrestore(&s->lock, flags);
+		__set_adc_rate(s, rate);
 }
 
+
 /* --------------------------------------------------------------------- */
 static inline void reset_adc(struct cm_state *s)
 {
@@ -692,13 +759,16 @@
 	outb(s->enable | CM_CH0_RESET, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
 	udelay(10);
 	outb(s->enable & ~CM_CH0_RESET, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
+	udelay(10);
 }
 
 static inline void reset_dac(struct cm_state *s)
 {
 	/* reset bus master */
 	outb(s->enable | CM_CH1_RESET, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
+	udelay(10);
 	outb(s->enable & ~CM_CH1_RESET, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
+	udelay(10);
 	if (s->status & DO_DUAL_DAC)
 		reset_adc(s);
 }
@@ -715,7 +785,7 @@
 		pause_adc(s);
 }
 
- - -static inline void disable_adc(struct cm_state *s)
+extern inline void disable_adc(struct cm_state *s)
 {
 	/* disable channel */
 	s->enable &= ~CM_ENABLE_CH0;
@@ -723,7 +793,7 @@
 	reset_adc(s);
 }
 
- - -static inline void disable_dac(struct cm_state *s)
+extern inline void __disable_dac(struct cm_state *s)
 {
 	/* disable channel */
 	s->enable &= ~CM_ENABLE_CH1;
@@ -733,7 +803,7 @@
 		disable_adc(s);
 }
 
- - -static inline void enable_adc(struct cm_state *s)
+extern inline void __enable_adc(struct cm_state *s)
 {
 	if (!(s->enable & CM_ENABLE_CH0)) {
 		/* enable channel */
@@ -743,7 +813,7 @@
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~4, 0);
 }
 
- - -static inline void enable_dac_unlocked(struct cm_state *s)
+extern inline void __enable_dac(struct cm_state *s)
 {
 	if (!(s->enable & CM_ENABLE_CH1)) {
 		/* enable channel */
@@ -751,21 +821,11 @@
 		outb(s->enable, s->iobase + CODEC_CMI_FUNCTRL0 + 2);
 	}
 	maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~8, 0);
- - -
 	if (s->status & DO_DUAL_DAC)
- - -		enable_adc(s);
+		__enable_adc(s);
 }
 
- - -static inline void enable_dac(struct cm_state *s)
- - -{
- - -	unsigned long flags;
- - -
- - -	spin_lock_irqsave(&s->lock, flags);
- - -	enable_dac_unlocked(s);
- - -	spin_unlock_irqrestore(&s->lock, flags);
- - -}
- - -
- - -static inline void stop_adc_unlocked(struct cm_state *s)
+extern inline void __stop_adc(struct cm_state *s)
 {
 	if (s->enable & CM_ENABLE_CH0) {
 		/* disable interrupt */
@@ -774,73 +834,73 @@
 	}
 }
 
- - -static inline void stop_adc(struct cm_state *s)
+extern inline void stop_adc(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	stop_adc_unlocked(s);
+	__stop_adc(s);
 	spin_unlock_irqrestore(&s->lock, flags);
- - -
 }
 
- - -static inline void stop_dac_unlocked(struct cm_state *s)
+extern inline void __stop_dac(struct cm_state *s)
 {
 	if (s->enable & CM_ENABLE_CH1) {
 		/* disable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~2, 0);
- - -		disable_dac(s);
+		__disable_dac(s);
 	}
 	if (s->status & DO_DUAL_DAC)
- - -		stop_adc_unlocked(s);
+		__stop_adc(s);
 }
 
- - -static inline void stop_dac(struct cm_state *s)
+extern inline void stop_dac(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	stop_dac_unlocked(s);
+	__stop_dac(s);
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
- - -static void start_adc_unlocked(struct cm_state *s)
+static void __start_adc(struct cm_state *s)
 {
 	if ((s->dma_adc.mapped || s->dma_adc.count < (signed)(s->dma_adc.dmasize - 2*s->dma_adc.fragsize))
 	    && s->dma_adc.ready) {
 		/* enable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 1);
- - -		enable_adc(s);
+		__enable_adc(s);
 	}
- - -}
+
+}	
 
 static void start_adc(struct cm_state *s)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	start_adc_unlocked(s);
+	__start_adc(s);
 	spin_unlock_irqrestore(&s->lock, flags);
- - -}	
+}
 
- - -static void start_dac1_unlocked(struct cm_state *s)
+static void __start_dac1(struct cm_state *s)
 {
 	if ((s->dma_adc.mapped || s->dma_adc.count > 0) && s->dma_adc.ready) {
 		/* enable interrupt */
 //		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 1);
- - - 		enable_dac_unlocked(s);
+		__enable_dac(s);
 	}
 }
 
- - -static void start_dac_unlocked(struct cm_state *s)
+static void __start_dac(struct cm_state *s)
 {
 	if ((s->dma_dac.mapped || s->dma_dac.count > 0) && s->dma_dac.ready) {
 		/* enable interrupt */
 		maskb(s->iobase + CODEC_CMI_INT_HLDCLR + 2, ~0, 2);
- - -		enable_dac_unlocked(s);
+		__enable_dac(s);
 	}
- - -		if (s->status & DO_DUAL_DAC)
- - -			start_dac1_unlocked(s);
+	if (s->status & DO_DUAL_DAC)
+		__start_dac1(s);
 }
 
 static void start_dac(struct cm_state *s)
@@ -848,20 +908,18 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
- - -	start_dac_unlocked(s);
+	__start_dac(s);
 	spin_unlock_irqrestore(&s->lock, flags);
- - -}	
+}
 
 static int prog_dmabuf(struct cm_state *s, unsigned rec);
+static int __prog_dmabuf(struct cm_state *s, unsigned rec);
 
- - -static int set_dac_channels(struct cm_state *s, int channels)
+static int __set_dac_channels(struct cm_state *s, int channels)
 {
- - -	unsigned long flags;
- - -	spin_lock_irqsave(&s->lock, flags);
- - -
 	if ((channels > 2) && (channels <= s->max_channels)
 	 && (((s->fmt >> CM_CFMT_DACSHIFT) & CM_CFMT_MASK) == (CM_CFMT_STEREO | CM_CFMT_16BIT))) {
- - -	    set_spdifout_unlocked(s, 0);
+	    __set_spdifout(s, 0);
 	    if (s->capability & CAN_MULTI_CH_HW) {
 		// NXCHG
 		maskb(s->iobase + CODEC_CMI_LEGACY_CTRL + 3, ~0, 0x80);
@@ -881,12 +939,8 @@
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 2, ~0, 0xC0);
 		s->status |= DO_DUAL_DAC;
 		// prepare secondary buffer
- - -
- - -		spin_unlock_irqrestore(&s->lock, flags);
- - -		ret = prog_dmabuf(s, 1);
+		ret = __prog_dmabuf(s, 1);
 		if (ret) return ret;
- - -		spin_lock_irqsave(&s->lock, flags);
- - -
 		// copy the hw state
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_DACSHIFT);
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_ADCSHIFT);
@@ -895,12 +949,10 @@
 		fmts |= CM_CFMT_16BIT << CM_CFMT_ADCSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_DACSHIFT;
 		fmts |= CM_CFMT_STEREO << CM_CFMT_ADCSHIFT;
- - -		
- - -		set_fmt_unlocked(s, fmtm, fmts);
- - -		set_adc_rate_unlocked(s, s->ratedac);
- - -
+		__set_fmt(s, fmtm, fmts);
+		__set_adc_rate(s, s->ratedac);
 	    }
- - -
+	    // N4SPK3D, disable 4 speaker mode (analog duplicate)
 	    if (s->speakers > 2)
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 3, ~0x04, 0);
 	    s->curr_channels = channels;
@@ -918,11 +970,20 @@
 	    s->status &= ~DO_MULTI_CH;
 	    s->curr_channels = s->fmt & (CM_CFMT_STEREO << CM_CFMT_DACSHIFT) ? 2 : 1;
 	}
- - -
- - -	spin_unlock_irqrestore(&s->lock, flags);
 	return s->curr_channels;
 }
 
+static int set_dac_channels(struct cm_state *s, int channels)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&s->lock, flags);
+	ret = __set_dac_channels(s, channels);
+	spin_unlock_irqrestore(&s->lock, flags);
+	return ret;
+}	
+
 /* --------------------------------------------------------------------- */
 
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
@@ -943,9 +1004,10 @@
 	db->mapped = db->ready = 0;
 }
 
+
 /* Ch1 is used for playback, Ch0 is used for recording */
 
- - -static int prog_dmabuf(struct cm_state *s, unsigned rec)
+static int __prog_dmabuf(struct cm_state *s, unsigned rec)
 {
 	struct dmabuf *db = rec ? &s->dma_adc : &s->dma_dac;
 	unsigned rate = rec ? s->rateadc : s->ratedac;
@@ -954,17 +1016,15 @@
 	unsigned bufs;
 	struct page *pstart, *pend;
 	unsigned char fmt;
- - -	unsigned long flags;
 
 	fmt = s->fmt;
 	if (rec) {
- - -		stop_adc(s);
+		__stop_adc(s);
 		fmt >>= CM_CFMT_ADCSHIFT;
 	} else {
- - -		stop_dac(s);
+		__stop_dac(s);
 		fmt >>= CM_CFMT_DACSHIFT;
 	}
- - -
 	fmt &= CM_CFMT_MASK;
 	db->hwptr = db->swptr = db->total_bytes = db->count = db->error = db->endcleared = 0;
 	if (!db->rawbuf) {
@@ -1008,29 +1068,45 @@
 	if (db->ossmaxfrags >= 4 && db->ossmaxfrags < db->numfrag)
 		db->numfrag = db->ossmaxfrags;
  	/* to make fragsize >= 4096 */
+	if (s->modem) {
+	 	while (db->fragsize < 4096 && db->numfrag >= 4) {
+ 			db->fragsize *= 2;
+ 			db->fragshift++;
+ 			db->numfrag /= 2;
+ 		}
+	}
 	db->fragsamples = db->fragsize >> sample_shift[fmt];
 	db->dmasize = db->numfrag << db->fragshift;
 	db->dmasamples = db->dmasize >> sample_shift[fmt];
 	memset(db->rawbuf, (fmt & CM_CFMT_16BIT) ? 0 : 0x80, db->dmasize);
- - -	spin_lock_irqsave(&s->lock, flags);
 	if (rec) {
 		if (s->status & DO_DUAL_DAC)
- - -		    set_dmadac1(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
+		    __set_dmadac1(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
 		else
- - -		    set_dmaadc(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
+		    __set_dmaadc(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
 		/* program sample counts */
- - -		set_countdac(s, db->fragsamples);
+		__set_countdac(s, db->fragsamples);
 	} else {
- - -		set_dmadac(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
+		__set_dmadac(s, db->rawphys, db->dmasize >> sample_shift[fmt]);
 		/* program sample counts */
- - -		set_countdac(s, db->fragsamples);
+		__set_countdac(s, db->fragsamples);
 	}
- - -	spin_unlock_irqrestore(&s->lock, flags);
 	db->ready = 1;
 	return 0;
 }
 
- - -static inline void clear_advance(struct cm_state *s)
+static int prog_dmabuf(struct cm_state *s, unsigned rec)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&s->lock, flags);
+	ret = __prog_dmabuf(s, rec);
+	spin_unlock_irqrestore(&s->lock, flags);
+	return ret;
+}	
+
+extern __inline__ void clear_advance(struct cm_state *s)
 {
 	unsigned char c = (s->fmt & (CM_CFMT_16BIT << CM_CFMT_DACSHIFT)) ? 0 : 0x80;
 	unsigned char *buf = s->dma_dac.rawbuf;
@@ -1231,7 +1307,10 @@
 	[SOUND_MIXER_SYNTH]  = { DSP_MIX_FMVOLIDX_L,  	 DSP_MIX_FMVOLIDX_R,     MT_5MUTE,     0x40, 0x00 },
 	[SOUND_MIXER_VOLUME] = { DSP_MIX_MASTERVOLIDX_L, DSP_MIX_MASTERVOLIDX_R, MT_5MUTE,     0x00, 0x00 },
 	[SOUND_MIXER_PCM]    = { DSP_MIX_VOICEVOLIDX_L,  DSP_MIX_VOICEVOLIDX_R,  MT_5MUTE,     0x00, 0x00 },
- - -	[SOUND_MIXER_SPEAKER]= { DSP_MIX_SPKRVOLIDX,	 DSP_MIX_SPKRVOLIDX,	 MT_5MUTEMONO, 0x01, 0x01 }
+	[SOUND_MIXER_LINE1]  = { DSP_MIX_AUXVOL_L,       DSP_MIX_AUXVOL_R,       MT_5MUTE,     0x80, 0x20 },
+	[SOUND_MIXER_SPEAKER]= { DSP_MIX_SPKRVOLIDX,	 DSP_MIX_SPKRVOLIDX,	 MT_5MUTEMONO, 0x00, 0x01 },
+	[SOUND_MIXER_TREBLE] = { DSP_MIX_TREBLEIDX_L,	 DSP_MIX_TREBLEIDX_R,	 MT_5MUTE,     0x00, 0x01 },
+	[SOUND_MIXER_BASS]   = { DSP_MIX_BASSIDX_L,	 DSP_MIX_BASSIDX_L,	 MT_5MUTE,     0x00, 0x01 }
 };
 
 static const unsigned char volidx[SOUND_MIXER_NRDEVICES] = 
@@ -1242,15 +1321,34 @@
 	[SOUND_MIXER_SYNTH]  = 4,
 	[SOUND_MIXER_VOLUME] = 5,
 	[SOUND_MIXER_PCM]    = 6,
- - -	[SOUND_MIXER_SPEAKER]= 7
+	[SOUND_MIXER_LINE1]  = 7,
+	[SOUND_MIXER_SPEAKER]= 8,
+	[SOUND_MIXER_TREBLE] = 9,
+	[SOUND_MIXER_BASS]   = 10
 };
 
+static unsigned mixer_outmask(struct cm_state *s)
+{
+	unsigned long flags;
+	int i, j, k;
+
+	spin_lock_irqsave(&s->lock, flags);
+	j = rdmixer(s, DSP_MIX_OUTMIXIDX);
+	spin_unlock_irqrestore(&s->lock, flags);
+	for (k = i = 0; i < SOUND_MIXER_NRDEVICES; i++)
+		if (j & mixtable[i].play)
+			k |= 1 << i;
+	return k;
+}
+
 static unsigned mixer_recmask(struct cm_state *s)
 {
+	unsigned long flags;
 	int i, j, k;
 
+	spin_lock_irqsave(&s->lock, flags);
 	j = rdmixer(s, DSP_MIX_ADCMIXIDX_L);
- - -	j &= 0x7f;
+	spin_unlock_irqrestore(&s->lock, flags);
 	for (k = i = 0; i < SOUND_MIXER_NRDEVICES; i++)
 		if (j & mixtable[i].rec)
 			k |= 1 << i;
@@ -1291,7 +1389,7 @@
 			return put_user(mixer_recmask(s), (int *)arg);
 			
                 case SOUND_MIXER_OUTSRC: /* Arg contains a bit for each recording source */
- - -			return put_user(mixer_recmask(s), (int *)arg);//need fix
+			return put_user(mixer_outmask(s), (int *)arg);
 			
                 case SOUND_MIXER_DEVMASK: /* Arg contains a bit for each supported device */
 			for (val = i = 0; i < SOUND_MIXER_NRDEVICES; i++)
@@ -1348,7 +1446,7 @@
 		}
 		spin_lock_irqsave(&s->lock, flags);
 		wrmixer(s, DSP_MIX_ADCMIXIDX_L, j);
- - -		wrmixer(s, DSP_MIX_ADCMIXIDX_R, (j & 1) | (j>>1));
+		wrmixer(s, DSP_MIX_ADCMIXIDX_R, (j & 1) | (j>>1) | (j & 0x80));
 		spin_unlock_irqrestore(&s->lock, flags);
 		return 0;
 
@@ -1365,7 +1463,7 @@
 			j |= mixtable[i].play;
 		}
 		spin_lock_irqsave(&s->lock, flags);
- - -		frobindir(s, DSP_MIX_OUTMIXIDX, 0x1f, j);
+		wrmixer(s, DSP_MIX_OUTMIXIDX, j);
 		spin_unlock_irqrestore(&s->lock, flags);
 		return 0;
 
@@ -1428,7 +1526,6 @@
 			break;
 		}
 		spin_unlock_irqrestore(&s->lock, flags);
- - -
 		if (!volidx[i])
 			return -EINVAL;
 		s->mix.vol[volidx[i]-1] = val;
@@ -1438,6 +1535,13 @@
 
 /* --------------------------------------------------------------------- */
 
+static loff_t cm_llseek(struct file *file, loff_t offset, int origin)
+{
+	return -ESPIPE;
+}
+
+/* --------------------------------------------------------------------- */
+
 static int cm_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
@@ -1467,13 +1571,12 @@
 
 static /*const*/ struct file_operations cm_mixer_fops = {
 	owner:		THIS_MODULE,
- - -	llseek:		no_llseek,
+	llseek:		cm_llseek,
 	ioctl:		cm_ioctl_mixdev,
 	open:		cm_open_mixdev,
 	release:	cm_release_mixdev,
 };
 
- - -
 /* --------------------------------------------------------------------- */
 
 static int drain_dac(struct cm_state *s, int nonblock)
@@ -1543,6 +1646,7 @@
 			cnt = count;
 		if (cnt <= 0) {
 			start_adc(s);
+			udelay(10);
 			if (file->f_flags & O_NONBLOCK)
 				return ret ? ret : -EAGAIN;
 			if (!interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ)) {
@@ -1550,10 +1654,10 @@
 				       s->dma_adc.dmasize, s->dma_adc.fragsize, s->dma_adc.count,
 				       s->dma_adc.hwptr, s->dma_adc.swptr);
 				spin_lock_irqsave(&s->lock, flags);
- - -				stop_adc_unlocked(s);
- - -				set_dmaadc(s, s->dma_adc.rawphys, s->dma_adc.dmasamples);
+				__stop_adc(s);
+				__set_dmaadc(s, s->dma_adc.rawphys, s->dma_adc.dmasamples);
 				/* program sample counts */
- - -				set_countadc(s, s->dma_adc.fragsamples);
+				__set_countadc(s, s->dma_adc.fragsamples);
 				s->dma_adc.count = s->dma_adc.hwptr = s->dma_adc.swptr = 0;
 				spin_unlock_irqrestore(&s->lock, flags);
 			}
@@ -1570,7 +1674,7 @@
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
- - -		start_adc_unlocked(s);
+		__start_adc(s);
 		spin_unlock_irqrestore(&s->lock, flags);
 	}
 	return ret;
@@ -1636,14 +1740,14 @@
 				printk(KERN_DEBUG "cmpci: write: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count,
 				       s->dma_dac.hwptr, s->dma_dac.swptr);
+				stop_dac(s);
 				spin_lock_irqsave(&s->lock, flags);
- - -				stop_dac_unlocked(s);
- - -				set_dmadac(s, s->dma_dac.rawphys, s->dma_dac.dmasamples);
+				__set_dmadac(s, s->dma_dac.rawphys, s->dma_dac.dmasamples);
 				/* program sample counts */
- - -				set_countdac(s, s->dma_dac.fragsamples);
+				__set_countdac(s, s->dma_dac.fragsamples);
 				s->dma_dac.count = s->dma_dac.hwptr = s->dma_dac.swptr = 0;
 				if (s->status & DO_DUAL_DAC)  {
- - -					set_dmadac1(s, s->dma_adc.rawphys, s->dma_adc.dmasamples);
+					__set_dmadac1(s, s->dma_adc.rawphys, s->dma_adc.dmasamples);
 					s->dma_adc.count = s->dma_adc.hwptr = s->dma_adc.swptr = 0;
 				}
 				spin_unlock_irqrestore(&s->lock, flags);
@@ -1735,6 +1839,7 @@
 
 	VALIDATE_STATE(s);
 	lock_kernel();
+
 	if (vma->vm_flags & VM_WRITE) {
 		if ((ret = prog_dmabuf(s, 0)) != 0)
 			goto out;
@@ -1747,6 +1852,7 @@
 		goto out;
 	ret = -EINVAL;
 	if (vma->vm_pgoff != 0)
+
 		goto out;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
@@ -1757,10 +1863,12 @@
 	db->mapped = 1;
 	ret = 0;
 out:
- - -	unlock_kernel();
+	unlock_kernel();    
 	return ret;
 }
 
+#define SNDCTL_SPDIF_PROTECT	      _SIOW('S',  0, int)       // set/reset S/PDIF copy protection
+
 static int cm_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cm_state *s = (struct cm_state *)file->private_data;
@@ -1807,20 +1915,21 @@
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
 		if (val >= 0) {
+			spin_lock_irqsave(&s->lock, flags);
 			if (file->f_mode & FMODE_READ) {
- - -			 	spin_lock_irqsave(&s->lock, flags);
- - -				stop_adc_unlocked(s);
+				__stop_adc(s);
 				s->dma_adc.ready = 0;
- - -				set_adc_rate_unlocked(s, val);
- - -				spin_unlock_irqrestore(&s->lock, flags);
+				__set_adc_rate(s, val);
+
 			}
 			if (file->f_mode & FMODE_WRITE) {
- - -				stop_dac(s);
+				__stop_dac(s);
 				s->dma_dac.ready = 0;
 				if (s->status & DO_DUAL_DAC)
 					s->dma_adc.ready = 0;
- - -				set_dac_rate(s, val);
+				__set_dac_rate(s, val);
 			}
+			spin_unlock_irqrestore(&s->lock, flags);			
 		}
 		return put_user((file->f_mode & FMODE_READ) ? s->rateadc : s->ratedac, (int *)arg);
 
@@ -1900,11 +2009,16 @@
 	case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+
 		if (val != AFMT_QUERY) {
+			unsigned long flags;
+			
+			spin_lock_irqsave(&s->lock, flags);
 			fmtd = 0;
 			fmtm = ~0;
+			
 			if (file->f_mode & FMODE_READ) {
- - -				stop_adc(s);
+				__stop_adc(s);
 				s->dma_adc.ready = 0;
 				if (val == AFMT_S16_LE)
 					fmtd |= CM_CFMT_16BIT << CM_CFMT_ADCSHIFT;
@@ -1912,7 +2026,7 @@
 					fmtm &= ~(CM_CFMT_16BIT << CM_CFMT_ADCSHIFT);
 			}
 			if (file->f_mode & FMODE_WRITE) {
- - -				stop_dac(s);
+				__stop_dac(s);
 				s->dma_dac.ready = 0;
 				if (val == AFMT_S16_LE || val == AFMT_AC3)
 					fmtd |= CM_CFMT_16BIT << CM_CFMT_DACSHIFT;
@@ -1920,9 +2034,9 @@
 					fmtm &= ~(CM_CFMT_16BIT << CM_CFMT_DACSHIFT);
 				if (val == AFMT_AC3) {
 					fmtd |= CM_CFMT_STEREO << CM_CFMT_DACSHIFT;
- - -					set_ac3(s, s->ratedac);
+					__set_ac3(s, s->ratedac);
 				} else
- - -					set_ac3(s, 0);
+					__set_ac3(s, 0);
 				if (s->status & DO_DUAL_DAC) {
 					s->dma_adc.ready = 0;
 					if (val == AFMT_S16_LE)
@@ -1931,7 +2045,8 @@
 						fmtm &= ~(CM_CFMT_STEREO << CM_CFMT_ADCSHIFT);
 				}
 			}
- - -			set_fmt(s, fmtm, fmtd);
+			__set_fmt(s, fmtm, fmtd);
+			spin_unlock_irqrestore(&s->lock, flags);
 		}
 		if (s->status & DO_AC3) return put_user(AFMT_AC3, (int *)arg);
 		return put_user((s->fmt & ((file->f_mode & FMODE_READ) ? (CM_CFMT_16BIT << CM_CFMT_ADCSHIFT)
@@ -1958,6 +2073,7 @@
 	case SNDCTL_DSP_SETTRIGGER:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+
 		if (file->f_mode & FMODE_READ) {
 			if (val & PCM_ENABLE_INPUT) {
 				if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
@@ -2069,6 +2185,7 @@
         case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+
 		if (file->f_mode & FMODE_READ) {
 			s->dma_adc.ossfragshift = val & 0xffff;
 			s->dma_adc.ossmaxfrags = (val >> 16) & 0xffff;
@@ -2183,7 +2300,11 @@
 	case SNDCTL_DSP_MAPOUTBUF:
         case SNDCTL_DSP_SETSYNCRO:
                 return -EINVAL;
- - -		
+        case SNDCTL_SPDIF_PROTECT:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+	        maskb(s->iobase + CODEC_CMI_LEGACY_CTRL + 2, ~0x40, val ? 0x40 : 0);
+                return 0;
 	}
 	return mixer_ioctl(s, cmd, arg);
 }
@@ -2221,13 +2342,19 @@
 		set_adc_rate(s, 8000);
 	}
 	if (file->f_mode & FMODE_WRITE) {
+		unsigned long flags;
+		
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_DACSHIFT);
 		if ((minor & 0xf) == SND_DEV_DSP16)
 			fmts |= CM_CFMT_16BIT << CM_CFMT_DACSHIFT;
 		s->dma_dac.ossfragshift = s->dma_dac.ossmaxfrags = s->dma_dac.subdivision = 0;
- - -		set_dac_rate(s, 8000);
+
+		spin_lock_irqsave(&s->lock, flags);
+		__set_dac_rate(s, 8000);
 		// clear previous multichannel, spdif, ac3 state
- - -		set_spdifout(s, 0);
+		__set_spdifout(s, 0);
+		spin_unlock_irqrestore(&s->lock, flags);
+
 		if (s->deviceid == PCI_DEVICE_ID_CMEDIA_CM8738) {
 			set_ac3(s, 0);
 			set_dac_channels(s, 1);
@@ -2245,22 +2372,28 @@
 
 	VALIDATE_STATE(s);
 	lock_kernel();
+
 	if (file->f_mode & FMODE_WRITE)
 		drain_dac(s, file->f_flags & O_NONBLOCK);
 	down(&s->open_sem);
 	if (file->f_mode & FMODE_WRITE) {
- - -		stop_dac(s);
+		unsigned long flags;
+		
+		spin_lock_irqsave(&s->lock, flags);
+		__stop_dac(s);
 
 		dealloc_dmabuf(&s->dma_dac);
 		if (s->status & DO_DUAL_DAC)
 			dealloc_dmabuf(&s->dma_adc);
 
 		if (s->status & DO_MULTI_CH)
- - -			set_dac_channels(s, 0);
+			__set_dac_channels(s, 0);
 		if (s->status & DO_AC3)
- - -			set_ac3(s, 0);
+			__set_ac3(s, 0);
 		if (s->status & DO_SPDIF_OUT)
- - -			set_spdifout(s, 0);
+			__set_spdifout(s, 0);
+		
+		spin_unlock_irqrestore(&s->lock, flags);
 	}
 	if (file->f_mode & FMODE_READ) {
 		stop_adc(s);
@@ -2275,7 +2408,7 @@
 
 static /*const*/ struct file_operations cm_audio_fops = {
 	owner:		THIS_MODULE,
- - -	llseek:		no_llseek,
+	llseek:		cm_llseek,
 	read:		cm_read,
 	write:		cm_write,
 	poll:		cm_poll,
@@ -2369,6 +2502,7 @@
 		return 0;
 	ret = 0;
 	add_wait_queue(&s->midi.owait, &wait);
+
 	while (count > 0) {
 		spin_lock_irqsave(&s->lock, flags);
 		ptr = s->midi.owr;
@@ -2524,7 +2658,6 @@
 			if (file->f_flags & O_NONBLOCK) {
 				remove_wait_queue(&s->midi.owait, &wait);
 				set_current_state(TASK_RUNNING);
- - -				unlock_kernel();
 				return -EBUSY;
 			}
 			tmo = (count * HZ) / 3100;
@@ -2554,7 +2687,7 @@
 
 static /*const*/ struct file_operations cm_midi_fops = {
 	owner:		THIS_MODULE,
- - -	llseek:		no_llseek,
+	llseek:		cm_llseek,
 	read:		cm_midi_read,
 	write:		cm_midi_write,
 	poll:		cm_midi_poll,
@@ -2657,8 +2790,10 @@
 		outb(5, s->iosynth+2);
 		outb(arg & 1, s->iosynth+3);
 		return 0;
+
+	default:
+		return -EINVAL;
 	}
- - -	return -EINVAL;
 }
 
 static int cm_dmfm_open(struct inode *inode, struct file *file)
@@ -2721,7 +2856,7 @@
 
 static /*const*/ struct file_operations cm_dmfm_fops = {
 	owner:		THIS_MODULE,
- - -	llseek:		no_llseek,
+	llseek:		cm_llseek,
 	ioctl:		cm_dmfm_ioctl,
 	open:		cm_dmfm_open,
 	release:	cm_dmfm_release,
@@ -2825,6 +2960,11 @@
 #else
 static	int	use_line_as_bass;
 #endif
+#ifdef CONFIG_SOUND_CMPCI_PCTEL
+static	int	modem = 1;
+#else
+static	int	modem;
+#endif
 #ifdef CONFIG_SOUND_CMPCI_JOYSTICK
 static	int	joystick = 1;
 #else
@@ -2837,6 +2977,7 @@
 MODULE_PARM(speakers, "i");
 MODULE_PARM(use_line_as_rear, "i");
 MODULE_PARM(use_line_as_bass, "i");
+MODULE_PARM(modem, "i");
 MODULE_PARM(joystick, "i");
 MODULE_PARM_DESC(mpuio, "(0x330, 0x320, 0x310, 0x300) Base of MPU-401, 0 to disable");
 MODULE_PARM_DESC(fmio, "(0x388, 0x3C8, 0x3E0) Base of OPL3, 0 to disable");
@@ -2845,15 +2986,18 @@
 MODULE_PARM_DESC(speakers, "(2-6) Number of speakers you connect");
 MODULE_PARM_DESC(use_line_as_rear, "(1/0) Use line-in jack as rear-out");
 MODULE_PARM_DESC(use_line_as_bass, "(1/0) Use line-in jack as bass/center");
+MODULE_PARM_DESC(modem, "(1/0) Use HSP modem, still need PCTel modem driver");
 MODULE_PARM_DESC(joystick, "(1/0) Enable joystick interface, still need joystick driver");
 
 static struct pci_device_id cmpci_pci_tbl[] = {
- - -	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738, 
- - -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
  	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338A, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8338B, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738, 
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	  
+	{ PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738B, 
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, cmpci_pci_tbl);
@@ -2863,7 +3007,9 @@
 	struct cm_state *s;
 	mm_segment_t fs;
 	int i, val;
+#ifdef CONFIG_SOUND_CMPCI_MIDI
 	unsigned char reg_mask = 0;
+#endif
 	struct {
 		unsigned short	deviceid;
 		char		*devicename;
@@ -2878,10 +3024,10 @@
 	{
 		if (pci_enable_device(pcidev))
 			return;
+
 		if (pcidev->irq == 0)
 			return;
- - -		s = kmalloc(sizeof(*s), GFP_KERNEL);
- - -		if (!s) {
+		if (!(s = kmalloc(sizeof(struct cm_state), GFP_KERNEL))) {
 			printk(KERN_WARNING "cmpci: out of memory\n");
 			return;
 		}
@@ -2900,6 +3046,7 @@
 		init_waitqueue_head(&s->midi.iwait);
 		init_waitqueue_head(&s->midi.owait);
 		init_MUTEX(&s->open_sem);
+
 		spin_lock_init(&s->lock);
 		s->magic = CM_MAGIC;
 		s->iobase = pci_resource_start(pcidev, 0);
@@ -3004,7 +3151,7 @@
 			printk(KERN_ERR "cmpci: irq %u in use\n", s->irq);
 			goto err_irq;
 		}
- - -		printk(KERN_INFO "cmpci: found %s adapter at io %#06x irq %u\n",
+		printk(KERN_INFO "cmpci: found %s adapter at io %#06x irq %u ",
 		       devicename, s->iobase, s->irq);
 		/* register devices */
 		if ((s->dev_audio = register_sound_dsp(&cm_audio_fops, -1)) < 0)
@@ -3024,7 +3171,7 @@
 		fs = get_fs();
 		set_fs(KERNEL_DS);
 		/* set mixer output */
- - -		frobindir(s, DSP_MIX_OUTMIXIDX, 0x1f, 0x1f);
+		wrmixer(s, DSP_MIX_OUTMIXIDX, 0x7f);
 		/* set mixer input */
 		val = SOUND_MASK_LINE|SOUND_MASK_SYNTH|SOUND_MASK_CD|SOUND_MASK_MIC;
 		mixer_ioctl(s, SOUND_MIXER_WRITE_RECSRC, (unsigned long)&val);
@@ -3034,14 +3181,18 @@
 		}
 		/* use channel 0 for record, channel 1 for play */
 		maskb(s->iobase + CODEC_CMI_FUNCTRL0, ~2, 1);
- - -		s->deviceid = pcidev->device;
 
+		s->deviceid = pcidev->device;
 		if (pcidev->device == PCI_DEVICE_ID_CMEDIA_CM8738) {
- - -
 			/* chip version and hw capability check */
 			s->chip_version = query_chip(s);
- - -			printk(KERN_INFO "cmpci: chip version = 0%d\n", s->chip_version);
- - -
+			printk(KERN_INFO ", chip version = 0%d\n", s->chip_version);
+			s->modem = modem;
+			if (modem) {
+				/* enable FLINKON and disable FLINKOFF */
+				maskb(s->iobase + CODEC_CMI_MISC_CTRL, ~0x40, 0x80);
+				printk(KERN_INFO "cmpci: modem function supported\n");
+			}
 			/* seet SPDIF-in inverse before enable SPDIF loop */
 			if (spdif_inverse) {
 				/* turn on spdif-in inverse */
@@ -3128,7 +3279,7 @@
 	if (!pci_present())   /* No PCI bus in this machine! */
 #endif
 		return -ENODEV;
- - -	printk(KERN_INFO "cmpci: version $Revision: 5.64 $ time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "cmpci: version $Revision: " __CMVERSION__ " $time " __TIME__ " " __DATE__ "\n");
 
 	while (index < NR_DEVICE && (
 	       (pcidev = pci_find_device(PCI_VENDOR_ID_CMEDIA, PCI_DEVICE_ID_CMEDIA_CM8738, pcidev)))) { 
@@ -3154,7 +3305,6 @@
 MODULE_DESCRIPTION("CM8x38 Audio Driver");
 MODULE_LICENSE("GPL");
 
- - -
 static void __exit cleanup_cmpci(void)
 {
 	struct cm_state *s;
@@ -3188,6 +3338,7 @@
 	}
 	if (wavetable_mem)
 		free_pages(wavetable_mem, 20-PAGE_SHIFT);
+
 	printk(KERN_INFO "cmpci: unloading\n");
 }
 
- - --
 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQIXAwUBPFE/OBfQA3nqPEsZFANV4ggAyyzs3bANcMf8zLJSKTSF+fBSR0w8+tv/
1wVueUsBpb+nzaOIpicithkmjsuQbKFbJb2hss0a3orgQJi3tjf6VlcW7MeQYao4
k7VbVhQzPXNW6ytZdTTl99v64U6ORJRKCiIq5fZbGFMaTKQUzTnriKnR1Tq1nqdA
ARI1U4lcy4GpW8OnErpehAYWGm9JEyWzZ4JVuRfnSMp+MUGFw0/qYeargj5hfY1y
NzVxs9XpfjQ6vC1Stae9zeZUbsVHMt2ksfZc90kyC/8Iwh38D+dO7EIpwwhEk4Ua
nN3ghr/29s3dkCW6Y3/5YcTvoDoi506NIqZWm0TPZ34Qp760WoV3ewf+IxWvODuH
p0Sw3qmeNof634gp4RYW0H9HxMDXi12MMlzZL7qgIvHYpue2tAQ+Z1Xn184U6FRR
jDCUFtqK47eJBBxxM9MNivYAsHda5/1hsIGHClaPFrt9aQyWlhbxEiTSYXkySPfz
PgufyiB64Z2kHwa09vlkQbFnZexlG4nUHU0YIUDWpEIQ1g2VZzwcQG8N0Xsz7oAN
DgeHld1K4Drb1CU3xoClIc5EtqHRE/j8/tc69TFJzT58bNERwbqJp/cWXzJfw7nS
aKpgr5tvfp3Y2tc2mEYOo0nLndGPHYiDK9kOov3mjuOfXprIyhTa/mvXtoJGyOFP
/zF9VZll7uQHFw==
=oaWe
-----END PGP SIGNATURE-----
