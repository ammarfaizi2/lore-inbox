Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbSI2S15>; Sun, 29 Sep 2002 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSI2S14>; Sun, 29 Sep 2002 14:27:56 -0400
Received: from gate.perex.cz ([194.212.165.105]:7696 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261720AbSI2S1l>;
	Sun, 29 Sep 2002 14:27:41 -0400
Date: Sun, 29 Sep 2002 20:32:33 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [3/10] - 2002/07/03
Message-ID: <Pine.LNX.4.33.0209292031430.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.14, 2002-09-25 15:45:01+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/07/03:
    - added support for spdif on coexant cx20468 chip
    - fixed compilation without CONFIG_PROC_FS
    - YMFPCI driver
      - fixed GPIO read/write
      - a new module option snd_rear_switch
    - ioctl32 - added support for old hw_params ioctl
    - ES1968 driver
      - enabled hw control IRQ
      - calling es1968_reset() in free()
    - VIA8233 driver - fixes for mono playback


 include/sound/ac97_codec.h     |    9 +++++++++
 include/sound/info.h           |    4 ++--
 include/sound/version.h        |    2 +-
 include/sound/ymfpci.h         |    2 +-
 sound/core/ioctl32/pcm32.c     |    2 ++
 sound/isa/gus/gus_mem_proc.c   |    4 ++--
 sound/pci/ac97/ac97_codec.c    |   31 +++++++++++++++++++++++++++++++
 sound/pci/es1968.c             |   10 ++++++----
 sound/pci/via8233.c            |    2 +-
 sound/pci/ymfpci/ymfpci.c      |    6 +++++-
 sound/pci/ymfpci/ymfpci_main.c |   39 +++++++++++++++++++++++----------------
 11 files changed, 83 insertions(+), 28 deletions(-)


diff -Nru a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h	Sun Sep 29 20:20:29 2002
+++ b/include/sound/ac97_codec.h	Sun Sep 29 20:20:29 2002
@@ -127,6 +127,14 @@
 #define AC97_CSR_SPECF_DATA	0x6e	/* Special Feature Data */
 #define AC97_CSR_BDI_STATUS	0x7a	/* BDI Status */
 
+/* specific - Conexant */
+#define AC97_CXR_AUDIO_MISC	0x5c
+#define AC97_CXR_SPDIFEN	(1<<3)
+#define AC97_CXR_COPYRGT	(1<<2)
+#define AC97_CXR_SPDIF_MASK	(3<<0)
+#define AC97_CXR_SPDIF_PCM	0x0
+#define AC97_CXR_SPDIF_AC3	0x2
+
 /* ac97->scaps */
 #define AC97_SCAP_SURROUND_DAC	(1<<0)	/* surround L&R DACs are present */
 #define AC97_SCAP_CENTER_LFE_DAC (1<<1)	/* center and LFE DACs are present */
@@ -135,6 +143,7 @@
 #define AC97_HAS_PC_BEEP	(1<<0)	/* force PC Speaker usage */
 #define AC97_AD_MULTI		(1<<1)	/* Analog Devices - multi codecs */
 #define AC97_CS_SPDIF		(1<<2)	/* Cirrus Logic uses funky SPDIF */
+#define AC97_CX_SPDIF		(1<<3)	/* Conexant's spdif interface */
 
 /*
 
diff -Nru a/include/sound/info.h b/include/sound/info.h
--- a/include/sound/info.h	Sun Sep 29 20:20:29 2002
+++ b/include/sound/info.h	Sun Sep 29 20:20:29 2002
@@ -151,8 +151,8 @@
 
 static inline int snd_info_get_line(snd_info_buffer_t * buffer, char *line, int len) { return 0; }
 static inline char *snd_info_get_str(char *dest, char *src, int len) { return NULL; }
-static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name) { return NULL; }
-static inline snd_info_entry_t *snd_info_create_card_entry(snd_card_t * card, const char *name) { return NULL; }
+static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name, snd_info_entry_t *parent) { return NULL; }
+static inline snd_info_entry_t *snd_info_create_card_entry(snd_card_t * card, const char *name, snd_info_entry_t *parent) { return NULL; }
 static inline void snd_info_free_entry(snd_info_entry_t * entry) { ; }
 static inline snd_info_entry_t *snd_info_create_device(const char *name,
 						       unsigned int number,
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:20:29 2002
+++ b/include/sound/version.h	Sun Sep 29 20:20:29 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Wed Jun 26 18:12:42 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Jul 03 16:51:35 2002 UTC)"
diff -Nru a/include/sound/ymfpci.h b/include/sound/ymfpci.h
--- a/include/sound/ymfpci.h	Sun Sep 29 20:20:29 2002
+++ b/include/sound/ymfpci.h	Sun Sep 29 20:20:29 2002
@@ -358,7 +358,7 @@
 int snd_ymfpci_pcm2(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm_spdif(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm_4ch(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
-int snd_ymfpci_mixer(ymfpci_t *chip);
+int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
 int snd_ymfpci_joystick(ymfpci_t *chip);
 
 int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice);
diff -Nru a/sound/core/ioctl32/pcm32.c b/sound/core/ioctl32/pcm32.c
--- a/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:20:29 2002
+++ b/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:20:29 2002
@@ -55,7 +55,9 @@
 struct sndrv_pcm_hw_params32 {
 	u32 flags;
 	struct sndrv_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - SNDRV_PCM_HW_PARAM_FIRST_MASK + 1]; /* this must be identical */
+	struct sndrv_mask mres[5];	/* reserved masks */
 	struct sndrv_interval32 intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
+	struct sndrv_interval ires[9];	/* reserved intervals */
 	u32 rmask;
 	u32 cmask;
 	u32 info;
diff -Nru a/sound/isa/gus/gus_mem_proc.c b/sound/isa/gus/gus_mem_proc.c
--- a/sound/isa/gus/gus_mem_proc.c	Sun Sep 29 20:20:29 2002
+++ b/sound/isa/gus/gus_mem_proc.c	Sun Sep 29 20:20:29 2002
@@ -68,8 +68,8 @@
 	case 1:	/* SEEK_CUR */
 		file->f_pos += offset;
 		break;
-	case 2: /* SEEK_END */
-		file->f_pos = priv->size - offset;
+	case 2: /* SEEK_END, offset is negative */
+		file->f_pos = priv->size + offset;
 		break;
 	default:
 		return -EINVAL;
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:20:29 2002
+++ b/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:20:29 2002
@@ -61,6 +61,7 @@
 static int patch_sigmatel_stac9756(ac97_t * ac97);
 static int patch_cirrus_cs4299(ac97_t * ac97);
 static int patch_cirrus_spdif(ac97_t * ac97);
+static int patch_conexant(ac97_t * ac97);
 static int patch_ad1819(ac97_t * ac97);
 static int patch_ad1881(ac97_t * ac97);
 static int patch_ad1886(ac97_t * ac97);
@@ -143,6 +144,7 @@
 { 0x83847644, 0xffffffff, "STAC9744",		patch_sigmatel_stac9744 },
 { 0x83847656, 0xffffffff, "STAC9756/57",	patch_sigmatel_stac9756 },
 { 0x45838308, 0xffffffff, "ESS1988",		NULL },
+{ 0x43585429, 0xffffffff, "Cx20468",		patch_conexant },
 { 0, 	      0,	  NULL,			NULL }
 };
 
@@ -766,6 +768,13 @@
 		default: x = 0; break; // illegal.
 		}
 		change = snd_ac97_update_bits(ac97, AC97_CSR_SPDIF, 0x3fff, ((val & 0xcfff) | (x << 12)));
+	} else if (ac97->flags & AC97_CX_SPDIF) {
+		int v;
+		v = ucontrol->value.iec958.status[0] & (IEC958_AES0_CON_EMPHASIS_5015|IEC958_AES0_CON_NOT_COPYRIGHT) ? 0 : AC97_CXR_COPYRGT;
+		v |= ucontrol->value.iec958.status[0] & IEC958_AES0_NONAUDIO ? AC97_CXR_SPDIF_AC3 : AC97_CXR_SPDIF_PCM;
+		change = snd_ac97_update_bits(ac97, AC97_CXR_AUDIO_MISC, 
+					      AC97_CXR_SPDIF_MASK | AC97_CXR_COPYRGT,
+					      v);
 	} else {
 		change = snd_ac97_update_bits(ac97, AC97_SPDIF, 0x3fff, val);
 	}
@@ -808,6 +817,10 @@
     AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "AC97-SPSA", AC97_CSR_ACMODE, 0, 3, 0)
 };
 
+static const snd_kcontrol_new_t snd_ac97_conexant_controls_spdif[2] = {
+    AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH), AC97_CXR_AUDIO_MISC, 3, 1, 0),
+};
+
 #define AD18XX_PCM_BITS(xname, codec, shift, mask) \
 { iface: SNDRV_CTL_ELEM_IFACE_MIXER, name: xname, info: snd_ac97_ad18xx_pcm_info_bits, \
   get: snd_ac97_ad18xx_pcm_get_bits, put: snd_ac97_ad18xx_pcm_put_bits, \
@@ -1342,6 +1355,17 @@
 			/* set default PCM S/PDIF params */
 			/* consumer,PCM audio,no copyright,no preemphasis,PCM coder,original,48000Hz */
 			snd_ac97_write_cache(ac97, AC97_CSR_SPDIF, 0x0a20);
+		} else if (ac97->flags & AC97_CX_SPDIF) {
+			for (idx = 0; idx < 3; idx++)
+				if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_spdif[idx], ac97))) < 0)
+					return err;
+			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_conexant_controls_spdif[0], ac97))) < 0)
+				return err;
+			/* set default PCM S/PDIF params */
+			/* consumer,PCM audio,no copyright,no preemphasis,PCM coder,original,48000Hz */
+			snd_ac97_write_cache(ac97, AC97_CXR_AUDIO_MISC,
+					     snd_ac97_read(ac97, AC97_CXR_AUDIO_MISC) & ~(AC97_CXR_SPDIFEN|AC97_CXR_COPYRGT|AC97_CXR_SPDIF_MASK));
+			
 		} else {
 			for (idx = 0; idx < 5; idx++)
 				if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_spdif[idx], ac97))) < 0)
@@ -1968,6 +1992,13 @@
 	ac97->flags |= AC97_HAS_PC_BEEP;
 	
 	return patch_cirrus_spdif(ac97);
+}
+
+static int patch_conexant(ac97_t * ac97)
+{
+	ac97->flags |= AC97_CX_SPDIF;
+        ac97->ext_id |= AC97_EA_SPDIF;	/* force the detection of spdif */
+	return 0;
 }
 
 static int patch_ad1819(ac97_t * ac97)
diff -Nru a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	Sun Sep 29 20:20:29 2002
+++ b/sound/pci/es1968.c	Sun Sep 29 20:20:30 2002
@@ -1129,7 +1129,7 @@
 	/* clear WP interupts */
 	outw(1, chip->io_port + 0x04);
 	/* enable WP ints */
-	outw(inw(chip->io_port + 0x18) | 4, chip->io_port + 0x18);
+	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	freq = runtime->rate;
@@ -1260,7 +1260,7 @@
 	/* clear WP interupts */
 	outw(1, chip->io_port + 0x04);
 	/* enable WP ints */
-	outw(inw(chip->io_port + 0x18) | 4, chip->io_port + 0x18);
+	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	freq = runtime->rate;
@@ -1821,7 +1821,7 @@
 	apu_set_register(chip, apu, 11, 0x0000);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	outw(1, chip->io_port + 0x04); /* clear WP interupts */
-	outw(inw(chip->io_port + 0x18) | 4, chip->io_port + 0x18); /* enable WP ints */
+	outw(inw(chip->io_port + ESM_PORT_HOST_IRQ) | ESM_HIRQ_DSIE, chip->io_port + ESM_PORT_HOST_IRQ); /* enable WP ints */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	snd_es1968_apu_set_freq(chip, apu, ((unsigned int)48000 << 16) / chip->clock); /* 48000 Hz */
@@ -2328,9 +2328,10 @@
 	outb(0, iobase + ASSP_CONTROL_C);	/* M: Disable ASSP, ASSP IRQ's and FM Port */
 
 	/* Enable IRQ's */
-	w = ESM_HIRQ_DSIE | ESM_HIRQ_MPU401;
+	w = ESM_HIRQ_DSIE | ESM_HIRQ_MPU401 | ESM_HIRQ_HW_VOLUME;
 	outw(w, iobase + ESM_PORT_HOST_IRQ);
 
+
 	/*
 	 * set up wavecache
 	 */
@@ -2502,6 +2503,7 @@
 	chip->master_switch = NULL;
 	chip->master_volume = NULL;
 	if (chip->res_io_port) {
+		snd_es1968_reset(chip);
 		release_resource(chip->res_io_port);
 		kfree_nocheck(chip->res_io_port);
 	}
diff -Nru a/sound/pci/via8233.c b/sound/pci/via8233.c
--- a/sound/pci/via8233.c	Sun Sep 29 20:20:29 2002
+++ b/sound/pci/via8233.c	Sun Sep 29 20:20:29 2002
@@ -364,7 +364,7 @@
 		outb(fmt, chip->port + VIA_REG_MULTPLAY_FORMAT);
 		/* set sample number to slot 3, 4, 7, 8, 6, 9 */
 		switch (runtime->channels) {
-		case 1: slots = (1<<0); break;
+		case 1: slots = (1<<0) | (1<<4); break;
 		case 2: slots = (1<<0) | (2<<4); break;
 		case 4: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12); break;
 		case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
diff -Nru a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
--- a/sound/pci/ymfpci/ymfpci.c	Sun Sep 29 20:20:29 2002
+++ b/sound/pci/ymfpci/ymfpci.c	Sun Sep 29 20:20:29 2002
@@ -46,6 +46,7 @@
 static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static long snd_fm_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
 static long snd_mpu_port[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -1};
+static int snd_rear_switch[SNDRV_CARDS];
 
 MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_index, "Index value for the Yamaha DS-XG PCI soundcard.");
@@ -62,6 +63,9 @@
 MODULE_PARM(snd_fm_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
 MODULE_PARM_DESC(snd_fm_port, "FM OPL-3 Port.");
 MODULE_PARM_SYNTAX(snd_fm_port, SNDRV_ENABLED);
+MODULE_PARM(snd_rear_switch, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_rear_switch, "Enable shared rear/line-in switch");
+MODULE_PARM_SYNTAX(snd_rear_switch, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 
 static struct pci_device_id snd_ymfpci_ids[] __devinitdata = {
         { 0x1073, 0x0004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* YMF724 */
@@ -189,7 +193,7 @@
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ymfpci_mixer(chip)) < 0) {
+	if ((err = snd_ymfpci_mixer(chip, snd_rear_switch[dev])) < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff -Nru a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
--- a/sound/pci/ymfpci/ymfpci_main.c	Sun Sep 29 20:20:30 2002
+++ b/sound/pci/ymfpci/ymfpci_main.c	Sun Sep 29 20:20:30 2002
@@ -1560,30 +1560,36 @@
 
 static int snd_ymfpci_get_gpio_out(ymfpci_t *chip, int pin)
 {
-	u16 reg, ctrl;
+	u16 reg, mode;
 	unsigned long flags;
 
-	reg = ~(1 << pin) & 0xff;
-	ctrl = 0xff00 | reg;
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, ctrl);
-	ctrl = snd_ymfpci_readw(chip, YDSXGR_GPIOINSTATUS);
+	reg = snd_ymfpci_readw(chip, YDSXGR_GPIOFUNCENABLE);
+	reg &= ~(1 << (pin + 8));
+	reg |= (1 << pin);
+	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, reg);
+	/* set the level mode for input line */
+	mode = snd_ymfpci_readw(chip, YDSXGR_GPIOTYPECONFIG);
+	mode &= ~(3 << (pin * 2));
+	snd_ymfpci_writew(chip, YDSXGR_GPIOTYPECONFIG, mode);
+	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, reg | (1 << (pin + 8)));
+	mode = snd_ymfpci_readw(chip, YDSXGR_GPIOINSTATUS);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	return (ctrl >> pin) & 1;
+	return (mode >> pin) & 1;
 }
 
 static int snd_ymfpci_set_gpio_out(ymfpci_t *chip, int pin, int enable)
 {
-	u16 reg, ctrl;
+	u16 reg;
 	unsigned long flags;
 
-	reg = ~(1 << pin) & 0xff;
-	ctrl = (reg << 8) | reg;
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, ctrl);
+	reg = snd_ymfpci_readw(chip, YDSXGR_GPIOFUNCENABLE);
+	reg &= ~(1 << pin);
+	reg &= ~(1 << (pin + 8));
+	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, reg);
 	snd_ymfpci_writew(chip, YDSXGR_GPIOOUTCTRL, enable << pin);
-	ctrl = 0xff00 | reg;
-	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, ctrl);
+	snd_ymfpci_writew(chip, YDSXGR_GPIOFUNCENABLE, reg | (1 << (pin + 8)));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	return 0;
@@ -1639,7 +1645,7 @@
 	chip->ac97 = NULL;
 }
 
-int __devinit snd_ymfpci_mixer(ymfpci_t *chip)
+int __devinit snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch)
 {
 	ac97_t ac97;
 	snd_kcontrol_t *kctl;
@@ -1673,10 +1679,11 @@
 
 	/*
 	 * shared rear/line-in
-	 * FIXME: should be only on supported models - checking subdevice
 	 */
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_ymfpci_rear_shared, chip))) < 0)
-		return err;
+	if (rear_switch) {
+		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_ymfpci_rear_shared, chip))) < 0)
+			return err;
+	}
 
 	return 0;
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.14
## Wrapped with gzip_uu ##


begin 664 bkpatch2341
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
KF'PC#?8,>6*HN3!TW"J'3_X@Q^ERYSX<]5\K&$(X37.R_P'D[+RO"S0`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

