Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262140AbSJAREM>; Tue, 1 Oct 2002 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJARDP>; Tue, 1 Oct 2002 13:03:15 -0400
Received: from gate.perex.cz ([194.212.165.105]:39431 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262140AbSJAQ5x>;
	Tue, 1 Oct 2002 12:57:53 -0400
Date: Tue, 1 Oct 2002 18:59:24 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [9/12] - 2002/09/11
Message-ID: <Pine.LNX.4.33.0210011858010.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.652, 2002-10-01 15:33:54+02:00, perex@suse.cz
  ALSA update 2002/09/11 :
    - AC'97 codec
      - added support/detection for MC'97 (modem codecs)
      - improved/updated register bit constants
      - AD1980 codec ID with patch code
      - added eMicro and Philips UCB1400 codecs
    - PCM Scatter-Gather support
      - added a function snd_pcm_sgbuf_get_addr()
    - rewritten PCI DMA allocation
    - ENS1371 - fixed IEC958 control index when AC'97 codec has S/PDIF capability, too
    - intel8x0
      - don't break when second codec cannot be initialized
    - via82xx
      - improved sg buffer handling
      - added "Input Source Select" control for via8233
      - fixed the registers for via8233
      - fixed the detection of via8233 chip
      - clean up the configuration of bd arrays
    - USB Audio
      - added the missing initialization of curframesize field (fixes capture)


 include/sound/ac97_codec.h  |   56 ++++++++-
 include/sound/pcm_sgbuf.h   |    7 +
 include/sound/version.h     |    2 
 sound/core/Makefile         |   14 +-
 sound/core/isadma.c         |    4 
 sound/core/memory.c         |   41 +++---
 sound/drivers/dummy.c       |    2 
 sound/pci/ac97/ac97_codec.c |  223 +++++++++++++++++++++++--------------
 sound/pci/ac97/ac97_patch.c |   13 ++
 sound/pci/ac97/ac97_patch.h |    1 
 sound/pci/ens1370.c         |    5 
 sound/pci/intel8x0.c        |    7 -
 sound/pci/maestro3.c        |    3 
 sound/pci/via82xx.c         |  260 ++++++++++++++++++++++++--------------------
 sound/usb/usbaudio.c        |    1 
 15 files changed, 400 insertions(+), 239 deletions(-)


diff -Nru a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h	Tue Oct  1 17:08:58 2002
+++ b/include/sound/ac97_codec.h	Tue Oct  1 17:08:58 2002
@@ -54,7 +54,7 @@
 #define AC97_POWERDOWN		0x26	/* Powerdown control / status */
 /* range 0x28-0x3a - AUDIO AC'97 2.0 extensions */
 #define AC97_EXTENDED_ID	0x28	/* Extended Audio ID */
-#define AC97_EXTENDED_STATUS	0x2a	/* Extended Audio Status */
+#define AC97_EXTENDED_STATUS	0x2a	/* Extended Audio Status and Control */
 #define AC97_PCM_FRONT_DAC_RATE 0x2c	/* PCM Front DAC Rate */
 #define AC97_PCM_SURR_DAC_RATE	0x2e	/* PCM Surround DAC Rate */
 #define AC97_PCM_LFE_DAC_RATE	0x30	/* PCM LFE DAC Rate */
@@ -64,10 +64,40 @@
 #define AC97_SURROUND_MASTER	0x38	/* Surround (Rear) Master Volume */
 #define AC97_SPDIF		0x3a	/* S/PDIF control */
 /* range 0x3c-0x58 - MODEM */
+#define AC97_EXTENDED_MID	0x3c	/* Extended Modem ID */
+#define AC97_EXTENDED_MSTATUS	0x3e	/* Extended Modem Status and Control */
+#define AC97_LINE1_RATE		0x40	/* Line1 DAC/ADC Rate */
+#define AC97_LINE2_RATE		0x42	/* Line2 DAC/ADC Rate */
+#define AC97_HANDSET_RATE	0x44	/* Handset DAC/ADC Rate */
+#define AC97_LINE1_LEVEL	0x46	/* Line1 DAC/ADC Level */
+#define AC97_LINE2_LEVEL	0x48	/* Line2 DAC/ADC Level */
+#define AC97_HANDSET_LEVEL	0x4a	/* Handset DAC/ADC Level */
+#define AC97_GPIO_CFG		0x4c	/* GPIO Configuration */
+#define AC97_GPIO_POLARITY	0x4e	/* GPIO Pin Polarity/Type, 0=low, 1=high active */
+#define AC97_GPIO_STICKY	0x50	/* GPIO Pin Sticky, 0=not, 1=sticky */
+#define AC97_GPIO_WAKEUP	0x52	/* GPIO Pin Wakeup, 0=no int, 1=yes int */
+#define AC97_GPIO_STATUS	0x54	/* GPIO Pin Status, slot 12 */
+#define AC97_MISC_AFE		0x56	/* Miscellaneous Modem AFE Status and Control */
 /* range 0x5a-0x7b - Vendor Specific */
 #define AC97_VENDOR_ID1		0x7c	/* Vendor ID1 */
 #define AC97_VENDOR_ID2		0x7e	/* Vendor ID2 / revision */
 
+/* basic capabilities (reset register) */
+#define AC97_BC_DEDICATED_MIC	0x0001	/* Dedicated Mic PCM In Channel */
+#define AC97_BC_RESERVED1	0x0002	/* Reserved (was Modem Line Codec support) */
+#define AC97_BC_BASS_TREBLE	0x0004	/* Bass & Treble Control */
+#define AC97_BC_SIM_STEREO	0x0008	/* Simulated stereo */
+#define AC97_BC_HEADPHONE	0x0010	/* Headphone Out Support */
+#define AC97_BC_LOUDNESS	0x0020	/* Loudness (bass boost) Supporqt */
+#define AC97_BC_16BIT_DAC	0x0000	/* 16-bit DAC resolution */
+#define AC97_BC_18BIT_DAC	0x0040	/* 18-bit DAC resolution */
+#define AC97_BC_20BIT_DAC	0x0080	/* 20-bit DAC resolution */
+#define AC97_BC_DAC_MASK	0x00c0
+#define AC97_BC_16BIT_ADC	0x0000	/* 16-bit ADC resolution */
+#define AC97_BC_18BIT_ADC	0x0100	/* 18-bit ADC resolution */
+#define AC97_BC_20BIT_ADC	0x0200	/* 20-bit ADC resolution */
+#define AC97_BC_ADC_MASK	0x0300
+
 /* extended audio ID bit defines */
 #define AC97_EI_VRA		0x0001	/* Variable bit rate supported */
 #define AC97_EI_DRA		0x0002	/* Double rate supported */
@@ -80,8 +110,8 @@
 #define AC97_EI_LDAC		0x0100	/* PCM LFE DAC available */
 #define AC97_EI_AMAP		0x0200	/* indicates optional slot/DAC mapping based on codec ID */
 #define AC97_EI_REV_MASK	0x0c00	/* AC'97 revision mask */
-#define AC97_EI_REV_22		0x0100	/* AC'97 revision 2.2 */
-#define AC97_EI_REV_SHIFT	8
+#define AC97_EI_REV_22		0x0400	/* AC'97 revision 2.2 */
+#define AC97_EI_REV_SHIFT	10
 #define AC97_EI_ADDR_MASK	0xc000	/* physical codec ID (address) */
 #define AC97_EI_ADDR_SHIFT	14
 
@@ -112,14 +142,25 @@
 #define AC97_SC_COPY		0x0004	/* Copyright status */
 #define AC97_SC_PRE		0x0008	/* Preemphasis status */
 #define AC97_SC_CC_MASK		0x07f0	/* Category Code mask */
+#define AC97_SC_CC_SHIFT	4
 #define AC97_SC_L		0x0800	/* Generation Level status */
-#define AC97_SC_SPSR_MASK	0xcfff	/* S/PDIF Sample Rate bits */
+#define AC97_SC_SPSR_MASK	0x3000	/* S/PDIF Sample Rate bits */
+#define AC97_SC_SPSR_SHIFT	12
 #define AC97_SC_SPSR_44K	0x0000	/* Use 44.1kHz Sample rate */
 #define AC97_SC_SPSR_48K	0x2000	/* Use 48kHz Sample rate */
 #define AC97_SC_SPSR_32K	0x3000	/* Use 32kHz Sample rate */
 #define AC97_SC_DRS		0x4000	/* Double Rate S/PDIF */
 #define AC97_SC_V		0x8000	/* Validity status */
 
+/* extended modem ID bit defines */
+#define AC97_MEI_LINE1		0x0001	/* Line1 present */
+#define AC97_MEI_LINE2		0x0002	/* Line2 present */
+#define AC97_MEI_HEADSET	0x0004	/* Headset present */
+#define AC97_MEI_CID1		0x0008	/* caller ID decode for Line1 is supported */
+#define AC97_MEI_CID2		0x0010	/* caller ID decode for Line2 is supported */
+#define AC97_MEI_ADDR_MASK	0xc000	/* physical codec ID (address) */
+#define AC97_MEI_ADDR_SHIFT	14
+
 /* specific - SigmaTel */
 #define AC97_SIGMATEL_ANALOG	0x6c	/* Analog Special */
 #define AC97_SIGMATEL_DAC2INVERT 0x6e
@@ -154,8 +195,10 @@
 #define AC97_CXR_SPDIF_AC3	0x2
 
 /* ac97->scaps */
-#define AC97_SCAP_SURROUND_DAC	(1<<0)	/* surround L&R DACs are present */
-#define AC97_SCAP_CENTER_LFE_DAC (1<<1)	/* center and LFE DACs are present */
+#define AC97_SCAP_AUDIO		(1<<0)	/* audio AC'97 codec */
+#define AC97_SCAP_MODEM		(1<<1)	/* modem AC'97 codec */
+#define AC97_SCAP_SURROUND_DAC	(1<<2)	/* surround L&R DACs are present */
+#define AC97_SCAP_CENTER_LFE_DAC (1<<3)	/* center and LFE DACs are present */
 
 /* ac97->flags */
 #define AC97_HAS_PC_BEEP	(1<<0)	/* force PC Speaker usage */
@@ -195,6 +238,7 @@
 	unsigned int id;	/* identification of codec */
 	unsigned short caps;	/* capabilities (register 0) */
 	unsigned short ext_id;	/* extended feature identification (register 28) */
+	unsigned short ext_mid;	/* extended modem ID (register 3C) */
 	unsigned int scaps;	/* driver capabilities */
 	unsigned int flags;	/* specific code */
 	unsigned int clock;	/* AC'97 clock (usually 48000Hz) */
diff -Nru a/include/sound/pcm_sgbuf.h b/include/sound/pcm_sgbuf.h
--- a/include/sound/pcm_sgbuf.h	Tue Oct  1 17:08:58 2002
+++ b/include/sound/pcm_sgbuf.h	Tue Oct  1 17:08:58 2002
@@ -45,6 +45,13 @@
 	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 }
 
+/*
+ * return the physical address at the corresponding offset
+ */
+static inline dma_addr_t snd_pcm_sgbuf_get_addr(struct snd_sg_buf *sgbuf, size_t offset)
+{
+	return sgbuf->table[offset >> PAGE_SHIFT].addr + offset % PAGE_SIZE;
+}
 
 int snd_pcm_sgbuf_init(snd_pcm_substream_t *substream, struct pci_dev *pci, int tblsize);
 int snd_pcm_sgbuf_delete(snd_pcm_substream_t *substream);
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Tue Oct  1 17:08:58 2002
+++ b/include/sound/version.h	Tue Oct  1 17:08:58 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc3"
-#define CONFIG_SND_DATE " (Fri Sep 06 15:06:56 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Sep 11 18:36:14 2002 UTC)"
diff -Nru a/sound/core/Makefile b/sound/core/Makefile
--- a/sound/core/Makefile	Tue Oct  1 17:08:58 2002
+++ b/sound/core/Makefile	Tue Oct  1 17:08:58 2002
@@ -3,17 +3,23 @@
 # Copyright (c) 1999,2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o \
-                pcm_sgbuf.o
+export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o
 
-snd-objs     := sound.o init.o isadma.o memory.o info.o control.o misc.o \
+snd-objs     := sound.o init.o memory.o info.o control.o misc.o \
                 device.o wrappers.o
+ifeq ($(CONFIG_ISA),y)
+snd-objs     += isadma.o
+endif
 ifeq ($(CONFIG_SND_OSSEMUL),y)
 snd-objs     += sound_oss.o info_oss.o
 endif
 
 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
-		pcm_memory.o pcm_sgbuf.o
+		pcm_memory.o
+ifeq ($(CONFIG_PCI),y)
+snd-pcm-objs += pcm_sgbuf.o
+export-objs  += pcm_sgbuf.o
+endif
 
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
diff -Nru a/sound/core/isadma.c b/sound/core/isadma.c
--- a/sound/core/isadma.c	Tue Oct  1 17:08:58 2002
+++ b/sound/core/isadma.c	Tue Oct  1 17:08:58 2002
@@ -30,8 +30,6 @@
 #include <sound/core.h>
 #include <asm/dma.h>
 
-#ifdef CONFIG_ISA
-
 /*
  *
  */
@@ -78,5 +76,3 @@
 	release_dma_lock(flags);
 	return result;
 }
-
-#endif /* CONFIG_ISA */
diff -Nru a/sound/core/memory.c b/sound/core/memory.c
--- a/sound/core/memory.c	Tue Oct  1 17:08:58 2002
+++ b/sound/core/memory.c	Tue Oct  1 17:08:58 2002
@@ -545,35 +545,36 @@
  *
  * since pci_alloc_consistent always tries GFP_DMA when the requested
  * pci memory region is below 32bit, it happens quite often that even
- * 2 order or pages cannot be allocated.
+ * 2 order of pages cannot be allocated.
  *
- * so in the following, GFP_DMA is used only when the first allocation
- * doesn't match the requested region.
+ * so in the following, we allocate at first without dma_mask, so that
+ * allocation will be done without GFP_DMA.  if the area doesn't match
+ * with the requested region, then realloate with the original dma_mask
+ * again.
  */
-#ifdef __i386__
-#define get_phys_addr(x) virt_to_phys(x)
-#else /* ppc and x86-64 */
-#define get_phys_addr(x) virt_to_bus(x)
-#endif
+
+#undef pci_alloc_consistent
+
 void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
 				    dma_addr_t *dma_handle)
 {
 	void *ret;
-	int gfp = GFP_ATOMIC;
+	u64 dma_mask;
+	unsigned long rmask;
 
 	if (hwdev == NULL)
-		gfp |= GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-	if (ret) {
-		if (hwdev && ((get_phys_addr(ret) + size - 1) & ~hwdev->dma_mask)) {
-			free_pages((unsigned long)ret, get_order(size));
-			ret = (void *)__get_free_pages(gfp | GFP_DMA, get_order(size));
-		}
-	}
-	if (ret) {
-		memset(ret, 0, size);
-		*dma_handle = get_phys_addr(ret);
+		return pci_alloc_consistent(hwdev, size, dma_handle);
+	dma_mask = hwdev->dma_mask;
+	rmask = ~((unsigned long)dma_mask);
+	hwdev->dma_mask = 0xffffffff; /* do without masking */
+	ret = pci_alloc_consistent(hwdev, size, dma_handle);
+	if (ret && ((*dma_handle + size - 1) & rmask)) {
+		pci_free_consistent(hwdev, size, ret, *dma_handle);
+		ret = 0;
 	}
+	hwdev->dma_mask = dma_mask; /* restore */
+	if (! ret)
+		ret = pci_alloc_consistent(hwdev, size, dma_handle);
 	return ret;
 }
 #endif /* hack */
diff -Nru a/sound/drivers/dummy.c b/sound/drivers/dummy.c
--- a/sound/drivers/dummy.c	Tue Oct  1 17:08:58 2002
+++ b/sound/drivers/dummy.c	Tue Oct  1 17:08:58 2002
@@ -446,7 +446,7 @@
 	left = ucontrol->value.integer.value[0] % 101;
 	right = ucontrol->value.integer.value[1] % 101;
 	spin_lock_irqsave(&dummy->mixer_lock, flags);
-	change = dummy->mixer_volume[addr][0] != left &&
+	change = dummy->mixer_volume[addr][0] != left ||
 	         dummy->mixer_volume[addr][1] != right;
 	dummy->mixer_volume[addr][0] = left;
 	dummy->mixer_volume[addr][1] = right;
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/ac97/ac97_codec.c	Tue Oct  1 17:08:58 2002
@@ -68,11 +68,13 @@
 { 0x434d4900, 0xffffff00, "C-Media Electronics", NULL },
 { 0x43525900, 0xffffff00, "Cirrus Logic",	NULL },
 { 0x43585400, 0xffffff00, "Conexant",           NULL },
+{ 0x454d4300, 0xffffff00, "eMicro",		NULL },
 { 0x45838300, 0xffffff00, "ESS Technology",	NULL },
 { 0x48525300, 0xffffff00, "Intersil",		NULL },
 { 0x49434500, 0xffffff00, "ICEnsemble",		NULL },
 { 0x49544500, 0xffffff00, "ITE Tech.Inc",	NULL },
 { 0x4e534300, 0xffffff00, "National Semiconductor", NULL },
+{ 0x50534300, 0xffffff00, "Philips",		NULL },
 { 0x53494c00, 0xffffff00, "Silicon Laboratory",	NULL },
 { 0x54524100, 0xffffff00, "TriTech",		NULL },
 { 0x54584e00, 0xffffff00, "Texas Instruments",	NULL },
@@ -97,6 +99,7 @@
 { 0x41445361, 0xffffffff, "AD1886",		patch_ad1886 },
 { 0x41445362, 0xffffffff, "AD1887",		patch_ad1881 },
 { 0x41445363, 0xffffffff, "AD1886A",		patch_ad1881 },
+{ 0x41445370, 0xffffffff, "AD1980",		patch_ad1980 },
 { 0x41445372, 0xffffffff, "AD1981A",		patch_ad1881 },
 { 0x414c4300, 0xfffffff0, "RL5306",	 	NULL },
 { 0x414c4310, 0xfffffff0, "RL5382", 		NULL },
@@ -117,6 +120,7 @@
 { 0x43525958, 0xfffffff8, "CS4205",		patch_cirrus_spdif },
 { 0x43525960, 0xfffffff8, "CS4291",		NULL },
 { 0x43585429, 0xffffffff, "Cx20468",		patch_conexant },
+{ 0x454d4328, 0xffffffff, "28028",		NULL },  // same as TR28028?
 { 0x45838308, 0xffffffff, "ESS1988",		NULL },
 { 0x48525300, 0xffffff00, "HMP9701",		NULL },
 { 0x49434501, 0xffffffff, "ICE1230",		NULL },
@@ -124,6 +128,7 @@
 { 0x49544520, 0xffffffff, "IT2226E",		NULL },
 { 0x4e534300, 0xffffffff, "LM4540/43/45/46/48",	NULL }, // only guess --jk
 { 0x4e534331, 0xffffffff, "LM4549",		NULL },
+{ 0x50534304, 0xffffffff, "UCB1400",		NULL },
 { 0x53494c22, 0xffffffff, "Si3036",		NULL },
 { 0x53494c23, 0xffffffff, "Si3038",		NULL },
 { 0x54524102, 0xffffffff, "TR28022",		NULL },
@@ -1503,57 +1508,83 @@
 		/* the REC_GAIN register is used for tests */
 		end_time = jiffies + HZ;
 		do {
+			unsigned short ext_mid;
+		
 			/* use preliminary reads to settle the communication */
 			snd_ac97_read(ac97, AC97_RESET);
 			snd_ac97_read(ac97, AC97_VENDOR_ID1);
 			snd_ac97_read(ac97, AC97_VENDOR_ID2);
-			/* test if we can write to the PCM volume register */
+			/* modem? */
+			ext_mid = snd_ac97_read(ac97, AC97_EXTENDED_MID);
+			if (ext_mid != 0xffff && (ext_mid & 1) != 0)
+				goto __access_ok;
+			/* test if we can write to the record gain volume register */
 			snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x8a05);
 			if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a05)
 				goto __access_ok;
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(HZ/100);
 		} while (time_after_eq(end_time, jiffies));
-		snd_printd("AC'97 %d:%d does not respond - RESET [REC_GAIN = 0x%x]\n", ac97->num, ac97->addr, err);
+		snd_printk("AC'97 %d:%d does not respond - RESET [REC_GAIN = 0x%x]\n", ac97->num, ac97->addr, err);
 		snd_ac97_free(ac97);
 		return -ENXIO;
 	}
       __access_ok:
-	ac97->caps = snd_ac97_read(ac97, AC97_RESET);
 	ac97->id = snd_ac97_read(ac97, AC97_VENDOR_ID1) << 16;
 	ac97->id |= snd_ac97_read(ac97, AC97_VENDOR_ID2);
-	ac97->ext_id = snd_ac97_read(ac97, AC97_EXTENDED_ID);
-	if (ac97->ext_id == 0xffff)	/* invalid combination */
-		ac97->ext_id = 0;
 	if (ac97->id == 0x00000000 || ac97->id == 0xffffffff) {
 		snd_printk("AC'97 %d:%d access is not valid [0x%x], removing mixer.\n", ac97->num, ac97->addr, ac97->id);
 		snd_ac97_free(ac97);
 		return -EIO;
 	}
+	
+	/* test for AC'97 */
+	/* test if we can write to the record gain volume register */
+	snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x8a06);
+	if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a06) {
+		ac97->scaps |= AC97_SCAP_AUDIO;
+		ac97->caps = snd_ac97_read(ac97, AC97_RESET);
+		ac97->ext_id = snd_ac97_read(ac97, AC97_EXTENDED_ID);
+		if (ac97->ext_id == 0xffff)	/* invalid combination */
+			ac97->ext_id = 0;
+	}
+
+	/* test for MC'97 */
+	ac97->ext_mid = snd_ac97_read(ac97, AC97_EXTENDED_MID);
+	if (ac97->ext_mid == 0xffff)	/* invalid combination */
+		ac97->ext_mid = 0;
+	if (ac97->ext_mid & 1)
+		ac97->scaps |= AC97_SCAP_MODEM;
 
 	if (ac97->reset) // FIXME: always skipping?
 		goto __ready_ok;
 
 	/* FIXME: add powerdown control */
 	/* nothing should be in powerdown mode */
-	snd_ac97_write_cache_test(ac97, AC97_POWERDOWN, 0);
-	snd_ac97_write_cache_test(ac97, AC97_RESET, 0);		/* reset to defaults */
-	udelay(100);
-	/* nothing should be in powerdown mode */
-	snd_ac97_write_cache_test(ac97, AC97_POWERDOWN, 0);
-	snd_ac97_write_cache_test(ac97, AC97_GENERAL_PURPOSE, 0);
-	end_time = jiffies + (HZ / 10);
-	do {
-		if ((snd_ac97_read(ac97, AC97_POWERDOWN) & 0x0f) == 0x0f)
-			goto __ready_ok;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/10);
-	} while (time_after_eq(end_time, jiffies));
-	snd_printk("AC'97 %d:%d analog subsections not ready\n", ac97->num, ac97->addr);
+	if (ac97->scaps & AC97_SCAP_AUDIO) {
+		snd_ac97_write_cache_test(ac97, AC97_POWERDOWN, 0);
+		snd_ac97_write_cache_test(ac97, AC97_RESET, 0);		/* reset to defaults */
+		udelay(100);
+		/* nothing should be in powerdown mode */
+		snd_ac97_write_cache_test(ac97, AC97_POWERDOWN, 0);
+		snd_ac97_write_cache_test(ac97, AC97_GENERAL_PURPOSE, 0);
+		end_time = jiffies + (HZ / 10);
+		do {
+			if ((snd_ac97_read(ac97, AC97_POWERDOWN) & 0x0f) == 0x0f)
+				goto __ready_ok;
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/10);
+		} while (time_after_eq(end_time, jiffies));
+		snd_printk("AC'97 %d:%d analog subsections not ready\n", ac97->num, ac97->addr);
+	}
+
       __ready_ok:
 	if (ac97->clock == 0)
 		ac97->clock = 48000;	/* standard value */
-	ac97->addr = (ac97->ext_id & AC97_EI_ADDR_MASK) >> AC97_EI_ADDR_SHIFT;	
+	if (ac97->scaps & AC97_SCAP_AUDIO)
+		ac97->addr = (ac97->ext_id & AC97_EI_ADDR_MASK) >> AC97_EI_ADDR_SHIFT;
+	else
+		ac97->addr = (ac97->ext_mid & AC97_MEI_ADDR_MASK) >> AC97_MEI_ADDR_SHIFT;
 	if (ac97->ext_id & 0x0189)	/* L/R, MIC, SDAC, LDAC VRA support */
 		snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, ac97->ext_id & 0x0189);
 	if (ac97->ext_id & AC97_EI_VRA) {	/* VRA support */
@@ -1595,9 +1626,17 @@
 			strcat(card->mixername, name);
 		}
 	}
-	if ((err = snd_component_add(card, "AC97")) < 0) {
-		snd_ac97_free(ac97);
-		return err;
+	if (ac97->scaps & AC97_SCAP_AUDIO) {
+		if ((err = snd_component_add(card, "AC97a")) < 0) {
+			snd_ac97_free(ac97);
+			return err;
+		}
+	}
+	if (ac97->scaps & AC97_SCAP_MODEM) {
+		if ((err = snd_component_add(card, "AC97m")) < 0) {
+			snd_ac97_free(ac97);
+			return err;
+		}
 	}
 	if (snd_ac97_mixer_build(card, ac97) < 0) {
 		snd_ac97_free(ac97);
@@ -1620,7 +1659,7 @@
 {
 	char name[64];
 	unsigned int id;
-	unsigned short val, tmp, ext;
+	unsigned short val, tmp, ext, mext;
 	static const char *spdif_slots[4] = { " SPDIF=3/4", " SPDIF=7/8", " SPDIF=6/9", " SPDIF=res" };
 	static const char *spdif_rates[4] = { " Rate=44.1kHz", " Rate=res", " Rate=48kHz", " Rate=32kHz" };
 	static const char *spdif_rates_cs4205[4] = { " Rate=48kHz", " Rate=44.1kHz", " Rate=res", " Rate=res" };
@@ -1631,24 +1670,24 @@
 	snd_iprintf(buffer, "%d-%d/%d: %s\n\n", ac97->addr, ac97->num, subidx, name);
 	val = snd_ac97_read(ac97, AC97_RESET);
 	snd_iprintf(buffer, "Capabilities     :%s%s%s%s%s%s\n",
-	    	    val & 0x0001 ? " -dedicated MIC PCM IN channel-" : "",
-		    val & 0x0002 ? " -reserved1-" : "",
-		    val & 0x0004 ? " -bass & treble-" : "",
-		    val & 0x0008 ? " -simulated stereo-" : "",
-		    val & 0x0010 ? " -headphone out-" : "",
-		    val & 0x0020 ? " -loudness-" : "");
-	tmp = ac97->caps & 0x00c0;
+	    	    val & AC97_BC_DEDICATED_MIC ? " -dedicated MIC PCM IN channel-" : "",
+		    val & AC97_BC_RESERVED1 ? " -reserved1-" : "",
+		    val & AC97_BC_BASS_TREBLE ? " -bass & treble-" : "",
+		    val & AC97_BC_SIM_STEREO ? " -simulated stereo-" : "",
+		    val & AC97_BC_HEADPHONE ? " -headphone out-" : "",
+		    val & AC97_BC_LOUDNESS ? " -loudness-" : "");
+	tmp = ac97->caps & AC97_BC_DAC_MASK;
 	snd_iprintf(buffer, "DAC resolution   : %s%s%s%s\n",
-		    tmp == 0x0000 ? "16-bit" : "",
-		    tmp == 0x0040 ? "18-bit" : "",
-		    tmp == 0x0080 ? "20-bit" : "",
-		    tmp == 0x00c0 ? "???" : "");
-	tmp = ac97->caps & 0x0300;
+		    tmp == AC97_BC_16BIT_DAC ? "16-bit" : "",
+		    tmp == AC97_BC_18BIT_DAC ? "18-bit" : "",
+		    tmp == AC97_BC_20BIT_DAC ? "20-bit" : "",
+		    tmp == AC97_BC_DAC_MASK ? "???" : "");
+	tmp = ac97->caps & AC97_BC_ADC_MASK;
 	snd_iprintf(buffer, "ADC resolution   : %s%s%s%s\n",
-		    tmp == 0x0000 ? "16-bit" : "",
-		    tmp == 0x0100 ? "18-bit" : "",
-		    tmp == 0x0200 ? "20-bit" : "",
-		    tmp == 0x0300 ? "???" : "");
+		    tmp == AC97_BC_16BIT_ADC ? "16-bit" : "",
+		    tmp == AC97_BC_18BIT_ADC ? "18-bit" : "",
+		    tmp == AC97_BC_20BIT_ADC ? "20-bit" : "",
+		    tmp == AC97_BC_ADC_MASK ? "???" : "");
 	snd_iprintf(buffer, "3D enhancement   : %s\n",
 		snd_ac97_stereo_enhancements[(val >> 10) & 0x1f]);
 	snd_iprintf(buffer, "\nCurrent setup\n");
@@ -1669,79 +1708,93 @@
 		    val & 0x0200 ? "Mic" : "MIX",
 		    val & 0x0100 ? "Mic2" : "Mic1",
 		    val & 0x0080 ? "on" : "off");
-	ext = snd_ac97_read(ac97, AC97_EXTENDED_ID);
 
+	ext = snd_ac97_read(ac97, AC97_EXTENDED_ID);
 	if (ext == 0)
-		return;
+		goto __modem;
+		
 	snd_iprintf(buffer, "Extended ID      : codec=%i rev=%i%s%s%s%s DSA=%i%s%s%s%s\n",
-			(ext >> 14) & 3,
-			(ext >> 10) & 3,
-			ext & 0x0200 ? " AMAP" : "",
-			ext & 0x0100 ? " LDAC" : "",
-			ext & 0x0080 ? " SDAC" : "",
-			ext & 0x0040 ? " CDAC" : "",
-			(ext >> 4) & 3,
-			ext & 0x0008 ? " VRM" : "",
-			ext & 0x0004 ? " SPDIF" : "",
-			ext & 0x0002 ? " DRA" : "",
-			ext & 0x0001 ? " VRA" : "");
+			(ext & AC97_EI_ADDR_MASK) >> AC97_EI_ADDR_SHIFT,
+			(ext & AC97_EI_REV_MASK) >> AC97_EI_REV_SHIFT,
+			ext & AC97_EI_AMAP ? " AMAP" : "",
+			ext & AC97_EI_LDAC ? " LDAC" : "",
+			ext & AC97_EI_SDAC ? " SDAC" : "",
+			ext & AC97_EI_CDAC ? " CDAC" : "",
+			(ext & AC97_EI_DACS_SLOT_MASK) >> AC97_EI_DACS_SLOT_SHIFT,
+			ext & AC97_EI_VRM ? " VRM" : "",
+			ext & AC97_EI_SPDIF ? " SPDIF" : "",
+			ext & AC97_EI_DRA ? " DRA" : "",
+			ext & AC97_EI_VRA ? " VRA" : "");
 	val = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
 	snd_iprintf(buffer, "Extended status  :%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
-			val & 0x4000 ? " PRL" : "",
-			val & 0x2000 ? " PRK" : "",
-			val & 0x1000 ? " PRJ" : "",
-			val & 0x0800 ? " PRI" : "",
-			val & 0x0400 ? " SPCV" : "",
-			val & 0x0200 ? " MADC" : "",
-			val & 0x0100 ? " LDAC" : "",
-			val & 0x0080 ? " SDAC" : "",
-			val & 0x0040 ? " CDAC" : "",
-			ext & 0x0004 ? spdif_slots[(val & 0x0030) >> 4] : "",
-			val & 0x0008 ? " VRM" : "",
-			val & 0x0004 ? " SPDIF" : "",
-			val & 0x0002 ? " DRA" : "",
-			val & 0x0001 ? " VRA" : "");
-	if (ext & 1) {	/* VRA */
+			val & AC97_EA_PRL ? " PRL" : "",
+			val & AC97_EA_PRK ? " PRK" : "",
+			val & AC97_EA_PRJ ? " PRJ" : "",
+			val & AC97_EA_PRI ? " PRI" : "",
+			val & AC97_EA_SPCV ? " SPCV" : "",
+			val & AC97_EA_MDAC ? " MADC" : "",
+			val & AC97_EA_LDAC ? " LDAC" : "",
+			val & AC97_EA_SDAC ? " SDAC" : "",
+			val & AC97_EA_CDAC ? " CDAC" : "",
+			ext & AC97_EI_SPDIF ? spdif_slots[(val & AC97_EA_SPSA_SLOT_MASK) >> AC97_EA_SPSA_SLOT_SHIFT] : "",
+			val & AC97_EA_VRM ? " VRM" : "",
+			val & AC97_EA_SPDIF ? " SPDIF" : "",
+			val & AC97_EA_DRA ? " DRA" : "",
+			val & AC97_EA_VRA ? " VRA" : "");
+	if (ext & AC97_EI_VRA) {	/* VRA */
 		val = snd_ac97_read(ac97, AC97_PCM_FRONT_DAC_RATE);
 		snd_iprintf(buffer, "PCM front DAC    : %iHz\n", val);
-		if (ext & 0x0080) {
+		if (ext & AC97_EI_SDAC) {
 			val = snd_ac97_read(ac97, AC97_PCM_SURR_DAC_RATE);
 			snd_iprintf(buffer, "PCM Surr DAC     : %iHz\n", val);
 		}
-		if (ext & 0x0100) {
+		if (ext & AC97_EI_LDAC) {
 			val = snd_ac97_read(ac97, AC97_PCM_LFE_DAC_RATE);
 			snd_iprintf(buffer, "PCM LFE DAC      : %iHz\n", val);
 		}
 		val = snd_ac97_read(ac97, AC97_PCM_LR_ADC_RATE);
 		snd_iprintf(buffer, "PCM ADC          : %iHz\n", val);
 	}
-	if (ext & 0x0008) {
+	if (ext & AC97_EI_VRM) {
 		val = snd_ac97_read(ac97, AC97_PCM_MIC_ADC_RATE);
 		snd_iprintf(buffer, "PCM MIC ADC      : %iHz\n", val);
 	}
-	if ((ext & 0x0004) || (ac97->flags & AC97_CS_SPDIF)) {
+	if ((ext & AC97_EI_SPDIF) || (ac97->flags & AC97_CS_SPDIF)) {
 	        if (ac97->flags & AC97_CS_SPDIF)
 			val = snd_ac97_read(ac97, AC97_CSR_SPDIF);
 		else
 			val = snd_ac97_read(ac97, AC97_SPDIF);
 
 		snd_iprintf(buffer, "SPDIF Control    :%s%s%s%s Category=0x%x Generation=%i%s%s%s\n",
-			val & 0x0001 ? " PRO" : " Consumer",
-			val & 0x0002 ? " Non-audio" : " PCM",
-			val & 0x0004 ? " Copyright" : "",
-			val & 0x0008 ? " Preemph50/15" : "",
-			(val & 0x07f0) >> 4,
-			(val & 0x0800) >> 11,
+			val & AC97_SC_PRO ? " PRO" : " Consumer",
+			val & AC97_SC_NAUDIO ? " Non-audio" : " PCM",
+			val & AC97_SC_COPY ? " Copyright" : "",
+			val & AC97_SC_PRE ? " Preemph50/15" : "",
+			(val & AC97_SC_CC_MASK) >> AC97_SC_CC_SHIFT,
+			(val & AC97_SC_L) >> 11,
 			(ac97->flags & AC97_CS_SPDIF) ?
-			    spdif_rates_cs4205[(val & 0x3000) >> 12] :
-			    spdif_rates[(val & 0x3000) >> 12],
+			    spdif_rates_cs4205[(val & AC97_SC_SPSR_MASK) >> AC97_SC_SPSR_SHIFT] :
+			    spdif_rates[(val & AC97_SC_SPSR_MASK) >> AC97_SC_SPSR_SHIFT],
 			(ac97->flags & AC97_CS_SPDIF) ?
-			    (val & 0x4000 ? " Validity" : "") :
-			    (val & 0x4000 ? " DRS" : ""),
+			    (val & AC97_SC_DRS ? " Validity" : "") :
+			    (val & AC97_SC_DRS ? " DRS" : ""),
 			(ac97->flags & AC97_CS_SPDIF) ?
-			    (val & 0x8000 ? " Enabled" : "") :
-			    (val & 0x8000 ? " Validity" : ""));
+			    (val & AC97_SC_V ? " Enabled" : "") :
+			    (val & AC97_SC_V ? " Validity" : ""));
 	}
+
+      __modem:
+	mext = snd_ac97_read(ac97, AC97_EXTENDED_MID);
+	if (mext == 0)
+		return;
+	
+	snd_iprintf(buffer, "Extended modem ID: codec=%i %s%s%s%s%s\n",
+			(mext & AC97_MEI_ADDR_MASK) >> AC97_MEI_ADDR_SHIFT,
+			mext & AC97_MEI_CID2 ? " CID2" : "",
+			mext & AC97_MEI_CID1 ? " CID1" : "",
+			mext & AC97_MEI_HEADSET ? " HSET" : "",
+			mext & AC97_MEI_LINE2 ? " LIN2" : "",
+			mext & AC97_MEI_LINE1 ? " LIN1" : "");
 }
 
 static void snd_ac97_proc_read(snd_info_entry_t *entry, snd_info_buffer_t * buffer)
diff -Nru a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
--- a/sound/pci/ac97/ac97_patch.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/ac97/ac97_patch.c	Tue Oct  1 17:08:58 2002
@@ -31,6 +31,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
+#include "ac97_patch.h"
 
 /*
  *  Chip specific initialization
@@ -321,5 +322,17 @@
 	/* Presario700 workaround */
 	/* for Jack Sense/SPDIF Register misetting causing */
 	snd_ac97_write_cache(ac97, AC97_AD_JACK_SPDIF, 0x0010);
+	return 0;
+}
+
+int patch_ad1980(ac97_t * ac97)
+{
+	unsigned short misc;
+	
+	patch_ad1881(ac97);
+	/* Switch FRONT/SURROUND LINE-OUT/HP-OUT default connection */
+	/* it seems that most vendors connect line-out connector to headphone out of AC'97 */
+	misc = snd_ac97_read(ac97, AC97_AD_MISC);
+	snd_ac97_write_cache(ac97, AC97_AD_MISC, misc | 0x0420);
 	return 0;
 }
diff -Nru a/sound/pci/ac97/ac97_patch.h b/sound/pci/ac97/ac97_patch.h
--- a/sound/pci/ac97/ac97_patch.h	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/ac97/ac97_patch.h	Tue Oct  1 17:08:58 2002
@@ -37,3 +37,4 @@
 int patch_ad1881(ac97_t * ac97);
 int patch_ad1885(ac97_t * ac97);
 int patch_ad1886(ac97_t * ac97);
+int patch_ad1980(ac97_t * ac97);
diff -Nru a/sound/pci/ens1370.c b/sound/pci/ens1370.c
--- a/sound/pci/ens1370.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/ens1370.c	Tue Oct  1 17:08:58 2002
@@ -1319,7 +1319,10 @@
 		if (ensoniq->pci->vendor == es1371_spdif_present[idx].vid &&
 		    ensoniq->pci->device == es1371_spdif_present[idx].did &&
 		    ensoniq->rev == es1371_spdif_present[idx].rev) {
-			snd_ctl_add(card, snd_ctl_new1(&snd_es1371_mixer_spdif, ensoniq));
+		    	snd_kcontrol_t *kctl = snd_ctl_new1(&snd_es1371_mixer_spdif, ensoniq); 
+		    	if (ensoniq->u.es1371.ac97->ext_id & AC97_EI_SPDIF)
+			    	kctl->id.index = 1;
+			snd_ctl_add(card, kctl);
 			break;
 		}
 	return 0;
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/intel8x0.c	Tue Oct  1 17:08:58 2002
@@ -1580,8 +1580,11 @@
 		goto __skip_secondary;
 	for (i = 1; i < codecs; i++) {
 		ac97.num = i;
-		if ((err = snd_ac97_mixer(chip->card, &ac97, &x97)) < 0)
-			return err;
+		if ((err = snd_ac97_mixer(chip->card, &ac97, &x97)) < 0) {
+			snd_printk("Unable to initialize codec #%i [device = %i, GLOB_STA = 0x%x]\n", i, chip->device_type, glob_sta);
+			codecs = i;
+			break;
+		}
 		chip->ac97[i] = x97;
 		if (chip->device_type == DEVICE_INTEL_ICH4 && chip->ichd[ICHD_PCM2IN].ac97 == NULL)
 			chip->ichd[ICHD_PCM2IN].ac97 = x97;
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/maestro3.c	Tue Oct  1 17:08:58 2002
@@ -1,5 +1,5 @@
 /*
- * Driver for ESS Maestro3/Allegro soundcards.
+ * Driver for ESS Maestro3/Allegro (ES1988) soundcards.
  * Copyright (c) 2000 by Zach Brown <zab@zabbo.net>
  *                       Takashi Iwai <tiwai@suse.de>
  *
@@ -52,6 +52,7 @@
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{ESS,Maestro3 PCI},"
+		"{ESS,ES1988},"
 		"{ESS,Allegro PCI},"
 		"{ESS,Allegro-1 PCI},"
 	        "{ESS,Canyon3D-2/LE PCI}}");
diff -Nru a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	Tue Oct  1 17:08:58 2002
+++ b/sound/pci/via82xx.c	Tue Oct  1 17:08:58 2002
@@ -124,7 +124,7 @@
 #define   VIA8233_REG_TYPE_16BIT	0x00200000	/* RW */
 #define   VIA8233_REG_TYPE_STEREO	0x00100000	/* RW */
 #define VIA_REG_OFFSET_CURR_COUNT	0x0c	/* dword - channel current count (24 bit) */
-#define VIA_REG_OFFSET_CURR_INDEX	0x0f	/* byte - channel current index */
+#define VIA_REG_OFFSET_CURR_INDEX	0x0f	/* byte - channel current index (for via8233 only) */
 
 #define DEFINE_VIA_REGSET(name,val) \
 enum {\
@@ -159,8 +159,8 @@
 #define VIA_REG_SGD_SHADOW		0x84	/* dword */
 
 /* multi-channel and capture registers for via8233 */
-DEFINE_VIA_REGSET(MULTPLAY, 0x20);
-DEFINE_VIA_REGSET(CAPTURE_8233, 0x10);
+DEFINE_VIA_REGSET(MULTPLAY, 0x40);
+DEFINE_VIA_REGSET(CAPTURE_8233, 0x60);
 
 /* via8233-specific registers */
 #define VIA_REG_PLAYBACK_VOLUME_L	0x02	/* byte */
@@ -183,66 +183,83 @@
  * pcm stream
  */
 
+struct snd_via_sg_table {
+	unsigned int offset;
+	unsigned int size;
+} ;
+
+#define VIA_TABLE_SIZE	255
+
 typedef struct {
 	unsigned long reg_offset;
         snd_pcm_substream_t *substream;
 	int running;
-        unsigned int size;
-        unsigned int fragsize;
-	unsigned int frags;
-	unsigned int lastptr;
-	unsigned int lastcount;
-	unsigned int page_per_frag;
-	unsigned int curidx;
-	unsigned int tbl_entries;	/* number of descriptor table entries */
-	unsigned int tbl_size;		/* size of a table entry */
+	unsigned int tbl_entries; /* # descriptors */
 	u32 *table; /* physical address + flag */
 	dma_addr_t table_addr;
+	struct snd_via_sg_table *idx_table;
 } viadev_t;
 
 
 static int build_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
 			   struct pci_dev *pci)
 {
-	int i, size;
+	int i, idx, ofs, rest, fragsize;
+	snd_pcm_runtime_t *runtime = substream->runtime;
 	struct snd_sg_buf *sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
 
-	if (dev->table) {
-		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
-		dev->table = NULL;
-	}
-
-	/* allocate buffer descriptor lists */
-	if (dev->fragsize < PAGE_SIZE) {
-		dev->tbl_size = dev->fragsize;
-		dev->tbl_entries = dev->frags;
-		dev->page_per_frag = 1;
-	} else {
-		dev->tbl_size = PAGE_SIZE;
-		dev->tbl_entries = sgbuf->pages;
-		dev->page_per_frag = dev->fragsize >> PAGE_SHIFT;
-	}
-	/* the start of each lists must be aligned to 8 bytes,
-	 * but the kernel pages are much bigger, so we don't care
-	 */
-	dev->table = (u32*)snd_malloc_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), &dev->table_addr);
-	if (! dev->table)
-		return -ENOMEM;
-
-	if (dev->tbl_size < PAGE_SIZE) {
-		for (i = 0; i < dev->tbl_entries; i++)
-			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[0].addr + dev->fragsize * i);
-	} else {
-		for (i = 0; i < dev->tbl_entries; i++)
-			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[i].addr);
-	}
-	size = dev->size;
-	for (i = 0; i < dev->tbl_entries - 1; i++) {
-		dev->table[(i << 1) + 1] = cpu_to_le32(VIA_TBL_BIT_FLAG | dev->tbl_size);
-		size -= dev->tbl_size;
+	if (! dev->table) {
+		/* the start of each lists must be aligned to 8 bytes,
+		 * but the kernel pages are much bigger, so we don't care
+		 */
+		dev->table = (u32*)snd_malloc_pci_pages(pci, PAGE_ALIGN(VIA_TABLE_SIZE * 2 * 8), &dev->table_addr);
+		if (! dev->table)
+			return -ENOMEM;
+	}
+	if (! dev->idx_table) {
+		dev->idx_table = kmalloc(sizeof(unsigned int) * VIA_TABLE_SIZE, GFP_KERNEL);
+		if (! dev->idx_table)
+			return -ENOMEM;
+	}
+
+	/* fill the entries */
+	fragsize = snd_pcm_lib_period_bytes(substream);
+	idx = 0;
+	ofs = 0;
+	for (i = 0; i < runtime->periods; i++) {
+		rest = fragsize;
+		/* fill descriptors for a period.
+		 * a period can be split to several descriptors if it's
+		 * over page boundary.
+		 */
+		do {
+			int r;
+			unsigned int flag;
+			dev->table[idx << 1] = cpu_to_le32((u32)snd_pcm_sgbuf_get_addr(sgbuf, ofs));
+			r = PAGE_SIZE - (ofs % PAGE_SIZE);
+			if (rest < r)
+				r = rest;
+			rest -= r;
+			if (! rest) {
+				if (i == runtime->periods - 1)
+					flag = VIA_TBL_BIT_EOL; /* buffer boundary */
+				else
+					flag = VIA_TBL_BIT_FLAG; /* period boundary */
+			} else
+				flag = 0; /* period continues to the next */
+			// printk("via: tbl %d: at %d  size %d (rest %d)\n", idx, ofs, r, rest);
+			dev->table[(idx<<1) + 1] = cpu_to_le32(r | flag);
+			dev->idx_table[idx].offset = ofs;
+			dev->idx_table[idx].size = r;
+			ofs += r;
+			idx++;
+			if (idx >= VIA_TABLE_SIZE) {
+				snd_printk(KERN_ERR "via82xx: too much table size!\n");
+				return -EINVAL;
+			}
+		} while (rest > 0);
 	}
-	dev->table[(dev->tbl_entries << 1) - 1] = cpu_to_le32(VIA_TBL_BIT_EOL | size);
-
+	dev->tbl_entries = idx;
 	return 0;
 }
 
@@ -254,13 +271,17 @@
 		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
 		dev->table = NULL;
 	}
+	if (dev->idx_table) {
+		kfree(dev->idx_table);
+		dev->idx_table = NULL;
+	}
 }
 
 
 /*
  */
 
-enum { TYPE_VIA686, TYPE_VIA8233 };
+enum { TYPE_VIA686 = 1, TYPE_VIA8233 };
 
 typedef struct _snd_via82xx via82xx_t;
 #define chip_t via82xx_t
@@ -295,8 +316,8 @@
 };
 
 static struct pci_device_id snd_via82xx_ids[] __devinitdata = {
-	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* 686A */
-	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* VT8233 */
+	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_VIA686, },	/* 686A */
+	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_VIA8233, },	/* VT8233 */
 	{ 0, }
 };
 
@@ -456,21 +477,7 @@
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	unsigned long port = chip->port + viadev->reg_offset;
-	int v, err;
-
-	viadev->size = snd_pcm_lib_buffer_bytes(substream);
-	viadev->fragsize = snd_pcm_lib_period_bytes(substream);
-	viadev->frags = runtime->periods;
-	viadev->lastptr = ~0;
-	viadev->lastcount = ~0;
-	viadev->curidx = 0;
-
-	/* the period size must be in power of 2 */
-	v = ld2(viadev->fragsize);
-	if (viadev->fragsize != (1 << v)) {
-		snd_printd(KERN_ERR "invalid fragment size %d\n", viadev->fragsize);
-		return -EINVAL;
-	}
+	int err;
 
 	snd_via82xx_channel_reset(chip, viadev);
 
@@ -478,7 +485,6 @@
 	if (err < 0)
 		return err;
 
-	runtime->dma_bytes = viadev->size;
 	outl((u32)viadev->table_addr, port + VIA_REG_OFFSET_TABLE_PTR);
 	switch (chip->chip_type) {
 	case TYPE_VIA686:
@@ -524,13 +530,9 @@
 {
 	outb(VIA_REG_STAT_FLAG | VIA_REG_STAT_EOL, VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset);
 	if (viadev->substream && viadev->running) {
-		viadev->curidx++;
-		if (viadev->curidx >= viadev->page_per_frag) {
-			viadev->curidx = 0;
-			spin_unlock(&chip->reg_lock);
-			snd_pcm_period_elapsed(viadev->substream);
-			spin_lock(&chip->reg_lock);
-		}
+		spin_unlock(&chip->reg_lock);
+		snd_pcm_period_elapsed(viadev->substream);
+		spin_lock(&chip->reg_lock);
 	}
 }
 
@@ -613,10 +615,8 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE, runtime->rate);
-	if (chip->chip_type == TYPE_VIA8233) {
-		outb(VIA_REG_CAPTURE_CHANNEL_LINE, VIAREG(chip, CAPTURE_CHANNEL));
+	if (chip->chip_type == TYPE_VIA8233)
 		outb(VIA_REG_CAPTURE_FIFO_ENABLE, VIAREG(chip, CAPTURE_FIFO));
-	}
 	return snd_via82xx_setup_periods(chip, &chip->capture, substream);
 }
 
@@ -624,43 +624,33 @@
 {
 	unsigned int val, ptr, count;
 	
-	ptr = inl(VIAREG(chip, OFFSET_CURR_PTR) + viadev->reg_offset)/* & 0xffffff*/;
+	snd_assert(viadev->tbl_entries, return 0);
+	if (!(inb(VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset) & VIA_REG_STAT_ACTIVE))
+		return 0;
+
+	count = inl(VIAREG(chip, OFFSET_CURR_COUNT) + viadev->reg_offset) & 0xffffff;
 	switch (chip->chip_type) {
 	case TYPE_VIA686:
-		count = inl(VIAREG(chip, OFFSET_CURR_COUNT) + viadev->reg_offset);
-		if (ptr == viadev->lastptr && count > viadev->lastcount)
-			ptr += 8;
-		if (!(inb(VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset) & VIA_REG_STAT_ACTIVE))
-			return 0;
-		snd_assert(viadev->tbl_entries, return 0);
-		/* get index */
+		/* The via686a does not have the current index register,
+		 * so we need to calculate the index from CURR_PTR.
+		 */
+		ptr = inl(VIAREG(chip, OFFSET_CURR_PTR) + viadev->reg_offset);
 		if (ptr <= (unsigned int)viadev->table_addr)
 			val = 0;
-		else
+		else /* CURR_PTR holds the address + 8 */
 			val = ((ptr - (unsigned int)viadev->table_addr) / 8 - 1) % viadev->tbl_entries;
-		viadev->lastptr = ptr;
-		viadev->lastcount = count;
 		break;
 
 	case TYPE_VIA8233:
 	default:
-		count = inl(VIAREG(chip, OFFSET_CURR_COUNT) + viadev->reg_offset) & 0xffffff;
-		/* The via686a does not have this current index register,
-		 * this register makes life easier for us here. */
+		/* ah, this register makes life easier for us here. */
 		val = inb(VIAREG(chip, OFFSET_CURR_INDEX) + viadev->reg_offset) % viadev->tbl_entries;
 		break;
 	}
 
 	/* convert to the linear position */
-	if (val < viadev->tbl_entries - 1) {
-		val *= viadev->tbl_size;
-		val += viadev->tbl_size - count;
-	} else {
-		val *= viadev->tbl_size;
-		val += (viadev->size % viadev->tbl_size) + 1 - count;
-	}
-	// printk("pointer: ptr = 0x%x (%i), count = 0x%x, val = 0x%x\n", ptr, count, val);
-	return val;
+	return viadev->idx_table[val].offset +
+		viadev->idx_table[val].size - count;
 }
 
 static snd_pcm_uframes_t snd_via82xx_playback_pointer(snd_pcm_substream_t * substream)
@@ -691,7 +681,7 @@
 	.period_bytes_min =	32,
 	.period_bytes_max =	128 * 1024,
 	.periods_min =		2,
-	.periods_max =		128,
+	.periods_max =		VIA_TABLE_SIZE / 2,
 	.fifo_size =		0,
 };
 
@@ -710,7 +700,7 @@
 	.period_bytes_min =	32,
 	.period_bytes_max =	128 * 1024,
 	.periods_min =		2,
-	.periods_max =		128,
+	.periods_max =		VIA_TABLE_SIZE / 2,
 	.fifo_size =		0,
 };
 
@@ -739,18 +729,10 @@
 		runtime->hw.rate_min = 48000;
 	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
 		return err;
-	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
-		return err;
 	/* we may remove following constaint when we modify table entries
 	   in interrupt */
-#if 0
-	/* applying the following constraint together with the power-of-2 rule
-	 * above may result in too narrow space.
-	 * this one is not strictly necessary, so let's disable it.
-	 */
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
-#endif
 	if (chip->chip_type == TYPE_VIA8233) {
 		runtime->hw.channels_max = 6;
 		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &hw_constraints_channels);
@@ -771,12 +753,8 @@
 		runtime->hw.rate_min = 48000;
 	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
 		return err;
-	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
-		return err;
-#if 0
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
-#endif
 	return 0;
 }
 
@@ -864,6 +842,52 @@
  *  Mixer part
  */
 
+static int snd_via8233_capture_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[2] = {
+		"Line", "Mic"
+	};
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item >= 2)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_via8233_capture_source_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.enumerated.item[0] = inb(VIAREG(chip, CAPTURE_CHANNEL)) & VIA_REG_CAPTURE_CHANNEL_MIC ? 1 : 0;
+	return 0;
+}
+
+static int snd_via8233_capture_source_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u8 val, oval;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	oval = inb(VIAREG(chip, CAPTURE_CHANNEL));
+	val = oval & ~VIA_REG_CAPTURE_CHANNEL_MIC;
+	if (ucontrol->value.enumerated.item[0])
+		val |= VIA_REG_CAPTURE_CHANNEL_MIC;
+	if (val != oval)
+		outb(val, VIAREG(chip, CAPTURE_CHANNEL));
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	return val != oval;
+}
+
+static snd_kcontrol_new_t snd_via8233_capture_source __devinitdata = {
+	.name = "Input Source Select",
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = snd_via8233_capture_source_info,
+	.get = snd_via8233_capture_source_get,
+	.put = snd_via8233_capture_source_put,
+};
+
 static void snd_via82xx_mixer_free_ac97(ac97_t *ac97)
 {
 	via82xx_t *chip = snd_magic_cast(via82xx_t, ac97->private_data, return);
@@ -1267,6 +1291,14 @@
 	
 		/* card switches */
 		err = snd_ctl_add(card, snd_ctl_new1(&snd_via82xx_joystick_control, chip));
+		if (err < 0) {
+			snd_card_free(card);
+			return err;
+		}
+
+	} else {
+		/* VIA8233 */
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_via8233_capture_source, chip));
 		if (err < 0) {
 			snd_card_free(card);
 			return err;
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	Tue Oct  1 17:08:58 2002
+++ b/sound/usb/usbaudio.c	Tue Oct  1 17:08:58 2002
@@ -766,6 +766,7 @@
 		subs->curpacksize = subs->maxpacksize;
 	else
 		subs->curpacksize = maxsize;
+	subs->curframesize = bytes_to_frames(runtime, subs->curpacksize);
 
 	/* allocate a temporary buffer for playback */
 	if (is_playback) {

===================================================================


This BitKeeper patch contains the following changesets:
1.652
## Wrapped with gzip_uu ##


begin 664 bkpatch23086
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
!````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

