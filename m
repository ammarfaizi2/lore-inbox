Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJAQiV>; Tue, 1 Oct 2002 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbSJAQiV>; Tue, 1 Oct 2002 12:38:21 -0400
Received: from gate.perex.cz ([194.212.165.105]:29447 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262139AbSJAQhr>;
	Tue, 1 Oct 2002 12:37:47 -0400
Date: Tue, 1 Oct 2002 18:39:25 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [1/12] - 2002/08/09
Message-ID: <Pine.LNX.4.33.0210011832130.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	this second set of ALSA update patches contains all our changes 
since 2002/08/09 up to 2002/10/01 (today). The most of patches are around 
200kB (mostly new USB code and merging / spliting old code), so I will not 
send them to this list (except changelog and download location). Bellow 
is the first patch.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.644, 2002-10-01 08:18:44+02:00, perex@suse.cz
  ALSA update 2002/08/09 :
    - Corrections for PCM sample silence (24-bits)
    - OPL3 code fixes (delays)
    - CS4281
      - added the power management code
      - added mixer controls for internal FM and PCM volumes
    - EMU10K1
      - fixed the dma mask
    - ICE1712
      - replaced EREMOTE with EIO
      - check the return value from ews88mt_chip_select()
    - Maestro3
      - corrected the wrong pci id for inspiron 8000
      - use the quirk list for gpio workarounds


 include/sound/version.h          |    2 
 sound/arm/sa11xx-uda1341.c       |    2 
 sound/core/ioctl32/ioctl32.c     |    1 
 sound/core/pcm_misc.c            |   30 ++-
 sound/core/pcm_native.c          |    1 
 sound/drivers/opl3/opl3_lib.c    |    2 
 sound/pci/Config.in              |    2 
 sound/pci/cs4281.c               |  385 ++++++++++++++++++++++++++++++++++-----
 sound/pci/emu10k1/emu10k1_main.c |   30 +--
 sound/pci/ice1712.c              |   53 +++--
 sound/pci/maestro3.c             |   84 ++++++--
 11 files changed, 477 insertions(+), 115 deletions(-)


diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Tue Oct  1 17:05:36 2002
+++ b/include/sound/version.h	Tue Oct  1 17:05:36 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Mon Aug 05 14:24:05 2002 UTC)"
+#define CONFIG_SND_DATE " (Fri Aug 09 11:49:03 2002 UTC)"
diff -Nru a/sound/arm/sa11xx-uda1341.c b/sound/arm/sa11xx-uda1341.c
--- a/sound/arm/sa11xx-uda1341.c	Tue Oct  1 17:05:36 2002
+++ b/sound/arm/sa11xx-uda1341.c	Tue Oct  1 17:05:36 2002
@@ -15,7 +15,7 @@
  * 2002-04-04   Tomas Kasparek  better rates handling (allow non-standard rates)
  */
 
-/* $Id: sa11xx-uda1341.c,v 1.3 2002/05/25 10:26:06 perex Exp $ */
+/* $Id: sa11xx-uda1341.c,v 1.4 2002/08/06 18:03:25 perex Exp $ */
 
 #include <sound/driver.h>
 #include <linux/module.h>
diff -Nru a/sound/core/ioctl32/ioctl32.c b/sound/core/ioctl32/ioctl32.c
--- a/sound/core/ioctl32/ioctl32.c	Tue Oct  1 17:05:36 2002
+++ b/sound/core/ioctl32/ioctl32.c	Tue Oct  1 17:05:36 2002
@@ -460,7 +460,6 @@
 		return err;
 	}
 #endif
-
 	return 0;
 }
 
diff -Nru a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
--- a/sound/core/pcm_misc.c	Tue Oct  1 17:05:36 2002
+++ b/sound/core/pcm_misc.c	Tue Oct  1 17:05:36 2002
@@ -329,6 +329,18 @@
 		return 0x0000800000008000ULL;
 	case SNDRV_PCM_FORMAT_U32_BE:
 		return 0x0000008000000080ULL;
+	case SNDRV_PCM_FORMAT_U24_3LE:
+		return 0x0000800000800000ULL;
+	case SNDRV_PCM_FORMAT_U24_3BE:
+		return 0x0080000080000080ULL;
+	case SNDRV_PCM_FORMAT_U20_3LE:
+		return 0x0000080000080000ULL;
+	case SNDRV_PCM_FORMAT_U20_3BE:
+		return 0x0008000008000008ULL;
+	case SNDRV_PCM_FORMAT_U18_3LE:
+		return 0x0000020000020000ULL;
+	case SNDRV_PCM_FORMAT_U18_3BE:
+		return 0x0002000002000002ULL;
 #else
 	case SNDRV_PCM_FORMAT_U16_LE:
 		return 0x0080008000800080ULL;
@@ -342,16 +354,19 @@
 		return 0x0080000000800000ULL;
 	case SNDRV_PCM_FORMAT_U32_BE:
 		return 0x8000000080000000ULL;
-#endif
 	case SNDRV_PCM_FORMAT_U24_3LE:
+		return 0x0080000080000080ULL;
 	case SNDRV_PCM_FORMAT_U24_3BE:
 		return 0x0000800000800000ULL;
 	case SNDRV_PCM_FORMAT_U20_3LE:
+		return 0x0008000008000008ULL;
 	case SNDRV_PCM_FORMAT_U20_3BE:
 		return 0x0000080000080000ULL;
 	case SNDRV_PCM_FORMAT_U18_3LE:
+		return 0x0002000002000002ULL;
 	case SNDRV_PCM_FORMAT_U18_3BE:
 		return 0x0000020000020000ULL;
+#endif
 	case SNDRV_PCM_FORMAT_FLOAT_LE:
 	{
 		union {
@@ -471,11 +486,16 @@
 		if (! silence)
 			memset(data, 0, samples * 3);
 		else {
-			/* FIXME: rewrite in the more better way.. */
-			int i;
 			while (samples-- > 0) {
-				for (i = 0; i < 3; i++)
-					*((u_int8_t *)data)++ = silence >> (i * 8);
+#ifdef SNDRV_LITTLE_ENDIAN
+				*((u_int8_t *)data)++ = silence >> 0;
+				*((u_int8_t *)data)++ = silence >> 8;
+				*((u_int8_t *)data)++ = silence >> 16;
+#else
+				*((u_int8_t *)data)++ = silence >> 16;
+				*((u_int8_t *)data)++ = silence >> 8;
+				*((u_int8_t *)data)++ = silence >> 0;
+#endif
 			}
 		}
 	}
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Tue Oct  1 17:05:36 2002
+++ b/sound/core/pcm_native.c	Tue Oct  1 17:05:36 2002
@@ -1616,7 +1616,6 @@
 	snd_assert(err >= 0, return -EINVAL);
 
 	err = snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT, hw->formats);
-	//err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_FORMAT, hw->formats);
 	snd_assert(err >= 0, return -EINVAL);
 
 	err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_SUBFORMAT, 1 << SNDRV_PCM_SUBFORMAT_STD);
diff -Nru a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
--- a/sound/drivers/opl3/opl3_lib.c	Tue Oct  1 17:05:36 2002
+++ b/sound/drivers/opl3/opl3_lib.c	Tue Oct  1 17:05:36 2002
@@ -101,8 +101,10 @@
 	spin_lock_irqsave(&opl3->reg_lock, flags);
 
 	writel((unsigned int)cmd, port << 2);
+	udelay(10);
 
 	writel((unsigned int)val, (port + 1) << 2);
+	udelay(30);
 
 	spin_unlock_irqrestore(&opl3->reg_lock, flags);
 }
diff -Nru a/sound/pci/Config.in b/sound/pci/Config.in
--- a/sound/pci/Config.in	Tue Oct  1 17:05:36 2002
+++ b/sound/pci/Config.in	Tue Oct  1 17:05:36 2002
@@ -6,7 +6,7 @@
 dep_tristate 'ALi PCI Audio M5451' CONFIG_SND_ALI5451 $CONFIG_SND
 dep_tristate 'Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x' CONFIG_SND_CS46XX $CONFIG_SND
 dep_mbool '  Cirrus Logic (Sound Fusion) New DSP support (EXPERIMENTAL)' CONFIG_SND_CS46XX_NEW_DSP $CONFIG_SND_CS46XX $CONFIG_EXPERIMENTAL
-dep_tristate 'Cirrus Logic CS4281' CONFIG_SND_CS4281 $CONFIG_SND
+dep_tristate 'Cirrus Logic (Sound Fusion) CS4281' CONFIG_SND_CS4281 $CONFIG_SND
 dep_tristate 'EMU10K1 (SB Live!, E-mu APS)' CONFIG_SND_EMU10K1 $CONFIG_SND
 dep_tristate 'Korg 1212 IO' CONFIG_SND_KORG1212 $CONFIG_SND
 dep_tristate 'NeoMagic NM256AV/ZX' CONFIG_SND_NM256 $CONFIG_SND
diff -Nru a/sound/pci/cs4281.c b/sound/pci/cs4281.c
--- a/sound/pci/cs4281.c	Tue Oct  1 17:05:36 2002
+++ b/sound/pci/cs4281.c	Tue Oct  1 17:05:36 2002
@@ -362,6 +362,8 @@
 #define BA0_SRCSA		0x075c	/* SRC Slot Assignments */
 #define BA0_PPLVC		0x0760	/* PCM Playback Left Volume Control */
 #define BA0_PPRVC		0x0764	/* PCM Playback Right Volume Control */
+#define BA0_PASR		0x0768	/* playback sample rate */
+#define BA0_CASR		0x076C	/* capture sample rate */
 
 /* Source Slot Numbers - Playback */
 #define SRCSLOT_LEFT_PCM_PLAYBACK		0
@@ -465,6 +467,8 @@
 	int frag;			/* period number */
 };
 
+#define SUSPEND_REGISTERS	20
+
 struct snd_cs4281 {
 	int irq;
 
@@ -506,6 +510,11 @@
 	snd_info_entry_t *proc_entry;
 
 	struct snd_cs4281_gameport *gameport;
+
+#ifdef CONFIG_PM
+	u32 suspend_regs[SUSPEND_REGISTERS];
+#endif
+
 };
 
 static void snd_cs4281_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -527,23 +536,35 @@
  *  common I/O routines
  */
 
-static void snd_cs4281_delay(unsigned int delay)
+static void snd_cs4281_delay(unsigned int delay, int can_schedule)
 {
 	if (delay > 999) {
-		signed long end_time;
-		delay = (delay * HZ) / 1000000;
-		if (delay < 1)
-			delay = 1;
-		end_time = jiffies + delay;
-		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-	        } while (end_time - (signed long)jiffies >= 0);
+		if (can_schedule) {
+			signed long end_time;
+			delay = (delay * HZ) / 1000000;
+			if (delay < 1)
+				delay = 1;
+			end_time = jiffies + delay;
+			do {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(1);
+			} while (end_time - (signed long)jiffies >= 0);
+		} else
+			mdelay(delay);
 	} else {
 		udelay(delay);
 	}
 }
 
+inline static void snd_cs4281_delay_long(int can_schedule)
+{
+	if (can_schedule) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	} else
+		mdelay(1999 / HZ);
+}
+
 static inline void snd_cs4281_pokeBA0(cs4281_t *chip, unsigned long offset, unsigned int val)
 {
         writel(val, chip->ba0 + offset);
@@ -717,6 +738,9 @@
 		dma->valDMR &= ~(BA0_DMR_DMA|BA0_DMR_POLL);
 		dma->valDCR |= BA0_DCR_MSK;
 		dma->valFCR &= ~BA0_FCR_FEN;
+		/* Leave wave playback FIFO enabled for FM */
+		if (dma->regFCR != BA0_FCR0)
+			dma->valFCR &= ~BA0_FCR_FEN;
 		break;
 	default:
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -800,12 +824,18 @@
 		}
 	}
       __skip_src:
+	/* Deactivate wave playback FIFO before changing slot assignments */
+	if (dma->regFCR == BA0_FCR0)
+		snd_cs4281_pokeBA0(chip, dma->regFCR, snd_cs4281_peekBA0(chip, dma->regFCR) & ~BA0_FCR_FEN);
 	/* Initialize FIFO */
 	dma->valFCR = BA0_FCR_LS(dma->left_slot) |
 		      BA0_FCR_RS(capture && (dma->valDMR & BA0_DMR_MONO) ? 31 : dma->right_slot) |
 		      BA0_FCR_SZ(CS4281_FIFO_SIZE) |
 		      BA0_FCR_OF(dma->fifo_offset);
 	snd_cs4281_pokeBA0(chip, dma->regFCR, dma->valFCR | (capture ? BA0_FCR_PSH : 0));
+	/* Activate FIFO again for FM playback */
+	if (dma->regFCR == BA0_FCR0)
+		snd_cs4281_pokeBA0(chip, dma->regFCR, dma->valFCR | BA0_FCR_FEN);
 	/* Clear FIFO Status and Interrupt Control Register */
 	snd_cs4281_pokeBA0(chip, dma->regFSIC, 0);
 }
@@ -855,7 +885,7 @@
 
 	// printk("DCC = 0x%x, buffer_size = 0x%x, jiffies = %li\n", snd_cs4281_peekBA0(chip, dma->regDCC), runtime->buffer_size, jiffies);
 	return runtime->buffer_size -
-	       snd_cs4281_peekBA0(chip, dma->regDCC);
+	       snd_cs4281_peekBA0(chip, dma->regDCC) - 1;
 }
 
 static snd_pcm_hardware_t snd_cs4281_playback =
@@ -1024,6 +1054,76 @@
  *  Mixer section
  */
 
+#define CS_VOL_MASK	0x1f
+
+static int snd_cs4281_info_volume(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type              = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count             = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = CS_VOL_MASK;
+	return 0;
+}
+ 
+static int snd_cs4281_get_volume(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs4281_t *chip = snd_kcontrol_chip(kcontrol);
+	int regL = (kcontrol->private_value >> 16) & 0xffff;
+	int regR = kcontrol->private_value & 0xffff;
+	int volL, volR;
+
+	volL = CS_VOL_MASK - (snd_cs4281_peekBA0(chip, regL) & CS_VOL_MASK);
+	volR = CS_VOL_MASK - (snd_cs4281_peekBA0(chip, regR) & CS_VOL_MASK);
+
+	ucontrol->value.integer.value[0] = volL;
+	ucontrol->value.integer.value[1] = volR;
+	return 0;
+}
+
+static int snd_cs4281_put_volume(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	cs4281_t *chip = snd_kcontrol_chip(kcontrol);
+	int change = 0;
+	int regL = (kcontrol->private_value >> 16) & 0xffff;
+	int regR = kcontrol->private_value & 0xffff;
+	int volL, volR;
+
+	volL = CS_VOL_MASK - (snd_cs4281_peekBA0(chip, regL) & CS_VOL_MASK);
+	volR = CS_VOL_MASK - (snd_cs4281_peekBA0(chip, regR) & CS_VOL_MASK);
+
+	if (ucontrol->value.integer.value[0] != volL) {
+		volL = CS_VOL_MASK - (ucontrol->value.integer.value[0] & CS_VOL_MASK);
+		snd_cs4281_pokeBA0(chip, regL, volL);
+		change = 1;
+	}
+	if (ucontrol->value.integer.value[0] != volL) {
+		volR = CS_VOL_MASK - (ucontrol->value.integer.value[1] & CS_VOL_MASK);
+		snd_cs4281_pokeBA0(chip, regR, volR);
+		change = 1;
+	}
+	return change;
+}
+
+static snd_kcontrol_new_t snd_cs4281_fm_vol = 
+{
+	iface: SNDRV_CTL_ELEM_IFACE_MIXER,
+	name: "Synth Playback Volume",
+	info: snd_cs4281_info_volume, 
+	get: snd_cs4281_get_volume,
+	put: snd_cs4281_put_volume, 
+	private_value: ((BA0_FMLVC << 16) | BA0_FMRVC),
+};
+
+static snd_kcontrol_new_t snd_cs4281_pcm_vol = 
+{
+	iface: SNDRV_CTL_ELEM_IFACE_MIXER,
+	name: "PCM Stream Playback Volume",
+	info: snd_cs4281_info_volume, 
+	get: snd_cs4281_get_volume,
+	put: snd_cs4281_put_volume, 
+	private_value: ((BA0_PPLVC << 16) | BA0_PPRVC),
+};
+
 static void snd_cs4281_mixer_free_ac97(ac97_t *ac97)
 {
 	cs4281_t *chip = snd_magic_cast(cs4281_t, ac97->private_data, return);
@@ -1051,11 +1151,16 @@
 		if ((err = snd_ac97_mixer(card, &ac97, &chip->ac97_secondary)) < 0)
 			return err;
 	}
+	if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_fm_vol, chip))) < 0)
+		return err;
+	if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_pcm_vol, chip))) < 0)
+		return err;
 	return 0;
 }
 
-/*
 
+/*
+ * proc interface
  */
 
 static void snd_cs4281_proc_read(snd_info_entry_t *entry, 
@@ -1337,14 +1442,18 @@
 	return snd_cs4281_free(chip);
 }
 
+static int snd_cs4281_chip_init(cs4281_t *chip, int can_schedule); /* defined below */
+#ifdef CONFIG_PM
+static int snd_cs4281_set_power_state(snd_card_t *card, unsigned int power_state);
+#endif
+
 static int __devinit snd_cs4281_create(snd_card_t * card,
-				    struct pci_dev *pci,
-				    cs4281_t ** rchip,
+				       struct pci_dev *pci,
+				       cs4281_t ** rchip,
 				       int dual_codec)
 {
 	cs4281_t *chip;
 	unsigned int tmp;
-	signed long end_time;
 	int err;
 	static snd_device_ops_t ops = {
 		dev_free:	snd_cs4281_dev_free,
@@ -1393,13 +1502,39 @@
 		return -ENOMEM;
 	}
 	
+	tmp = snd_cs4281_chip_init(chip, 0);
+	if (tmp) {
+		snd_cs4281_free(chip);
+		return tmp;
+	}
+
+	snd_cs4281_proc_init(chip);
+
+#ifdef CONFIG_PM
+	card->set_power_state = snd_cs4281_set_power_state;
+	card->power_state_private_data = chip;
+#endif
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+		snd_cs4281_free(chip);
+		return err;
+	}
+
+	*rchip = chip;
+	return 0;
+}
+
+static int snd_cs4281_chip_init(cs4281_t *chip, int can_schedule)
+{
+	unsigned int tmp;
+	int timeout;
+
 	tmp = snd_cs4281_peekBA0(chip, BA0_CFLR);
 	if (tmp != BA0_CFLR_DEFAULT) {
 		snd_cs4281_pokeBA0(chip, BA0_CFLR, BA0_CFLR_DEFAULT);
 		tmp = snd_cs4281_peekBA0(chip, BA0_CFLR);
 		if (tmp != BA0_CFLR_DEFAULT) {
 			snd_printk(KERN_ERR "CFLR setup failed (0x%x)\n", tmp);
-			snd_cs4281_free(chip);
 			return -EIO;
 		}
 	}
@@ -1411,12 +1546,10 @@
 	
 	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC1)) != (BA0_SERC1_SO1EN | BA0_SERC1_AC97)) {
 		snd_printk(KERN_ERR "SERC1 AC'97 check failed (0x%x)\n", tmp);
-		snd_cs4281_free(chip);
 		return -EIO;
 	}
 	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC2)) != (BA0_SERC2_SI1EN | BA0_SERC2_AC97)) {
 		snd_printk(KERN_ERR "SERC2 AC'97 check failed (0x%x)\n", tmp);
-		snd_cs4281_free(chip);
 		return -EIO;
 	}
 
@@ -1445,7 +1578,7 @@
 	snd_cs4281_pokeBA0(chip, BA0_SPMC, 0);
 	udelay(50);
 	snd_cs4281_pokeBA0(chip, BA0_SPMC, BA0_SPMC_RSTN);
-	snd_cs4281_delay(50000);
+	snd_cs4281_delay(50000, can_schedule);
 
 	if (chip->dual_codec)
 		snd_cs4281_pokeBA0(chip, BA0_SPMC, BA0_SPMC_RSTN | BA0_SPMC_ASDI2E);
@@ -1461,13 +1594,13 @@
 	 *  Start the DLL Clock logic.
 	 */
 	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, BA0_CLKCR1_DLLP);
-	snd_cs4281_delay(50000);
+	snd_cs4281_delay(50000, can_schedule);
 	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, BA0_CLKCR1_SWCE | BA0_CLKCR1_DLLP);
 
 	/*
 	 * Wait for the DLL ready signal from the clock logic.
 	 */
-	end_time = (jiffies + HZ / 4) + 1;
+	timeout = HZ;
 	do {
 		/*
 		 *  Read the AC97 status register to see if we've seen a CODEC
@@ -1475,12 +1608,10 @@
 		 */
 		if (snd_cs4281_peekBA0(chip, BA0_CLKCR1) & BA0_CLKCR1_DLLRDY)
 			goto __ok0;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-        } while (end_time - (signed long)jiffies >= 0);
+		snd_cs4281_delay_long(can_schedule);
+	} while (timeout-- > 0);
 
 	snd_printk(KERN_ERR "DLLRDY not seen\n");
-	snd_cs4281_free(chip);
 	return -EIO;
 
       __ok0:
@@ -1495,7 +1626,7 @@
 	/*
 	 * Wait for the codec ready signal from the AC97 codec.
 	 */
-	end_time = (jiffies + (3 * HZ) / 4) + 1;
+	timeout = HZ;
 	do {
 		/*
 		 *  Read the AC97 status register to see if we've seen a CODEC
@@ -1503,23 +1634,20 @@
 		 */
 		if (snd_cs4281_peekBA0(chip, BA0_ACSTS) & BA0_ACSTS_CRDY)
 			goto __ok1;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-        } while (end_time - (signed long)jiffies >= 0);
+		snd_cs4281_delay_long(can_schedule);
+	} while (timeout-- > 0);
 
 	snd_printk(KERN_ERR "never read codec ready from AC'97 (0x%x)\n", snd_cs4281_peekBA0(chip, BA0_ACSTS));
-	snd_cs4281_free(chip);
 	return -EIO;
 
       __ok1:
 	if (chip->dual_codec) {
-		end_time = (jiffies + (3 * HZ) / 4) + 1;
+		timeout = HZ;
 		do {
 			if (snd_cs4281_peekBA0(chip, BA0_ACSTS2) & BA0_ACSTS_CRDY)
 				goto __codec2_ok;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-		} while (end_time - (signed long)jiffies >= 0);
+			snd_cs4281_delay_long(can_schedule);
+		} while (timeout-- > 0);
 		snd_printk(KERN_INFO "secondary codec doesn't respond. disable it...\n");
 		chip->dual_codec = 0;
 	__codec2_ok: ;
@@ -1537,7 +1665,7 @@
 	 *  the codec is pumping ADC data across the AC-link.
 	 */
 
-	end_time = (jiffies + (5 * HZ) / 4) + 1;
+	timeout = HZ;
 	do {
 		/*
 		 *  Read the input slot valid register and see if input slots 3
@@ -1545,12 +1673,10 @@
 		 */
                 if ((snd_cs4281_peekBA0(chip, BA0_ACISV) & (BA0_ACISV_SLV(3) | BA0_ACISV_SLV(4))) == (BA0_ACISV_SLV(3) | BA0_ACISV_SLV(4)))
                         goto __ok2;
-                set_current_state(TASK_UNINTERRUPTIBLE);
-                schedule_timeout(1);
-        } while (end_time - (signed long)jiffies >= 0);
+		snd_cs4281_delay_long(can_schedule);
+	} while (timeout-- > 0);
 
 	snd_printk(KERN_ERR "never read ISV3 and ISV4 from AC'97\n");
-	snd_cs4281_free(chip);
 	return -EIO;
 
       __ok2:
@@ -1588,12 +1714,21 @@
 	chip->src_left_rec_slot = 10;	/* AC'97 left PCM record (3) */
 	chip->src_right_rec_slot = 11;	/* AC'97 right PCM record (4) */
 
+	/* Activate wave playback FIFO for FM playback */
+	chip->dma[0].valFCR = BA0_FCR_FEN | BA0_FCR_LS(0) |
+		              BA0_FCR_RS(1) |
+ 	  	              BA0_FCR_SZ(CS4281_FIFO_SIZE) |
+		              BA0_FCR_OF(chip->dma[0].fifo_offset);
+	snd_cs4281_pokeBA0(chip, chip->dma[0].regFCR, chip->dma[0].valFCR);
+	snd_cs4281_pokeBA0(chip, BA0_SRCSA, (chip->src_left_play_slot << 0) |
+					    (chip->src_right_play_slot << 8) |
+					    (chip->src_left_rec_slot << 16) |
+					    (chip->src_right_rec_slot << 24));
+
 	/* Initialize digital volume */
 	snd_cs4281_pokeBA0(chip, BA0_PPLVC, 0);
 	snd_cs4281_pokeBA0(chip, BA0_PPRVC, 0);
 
-	snd_cs4281_proc_init(chip);
-
 	/* Enable IRQs */
 	snd_cs4281_pokeBA0(chip, BA0_HICR, BA0_HICR_EOI);
 	/* Unmask interrupts */
@@ -1606,12 +1741,6 @@
 					BA0_HISR_DMA(3)));
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_cs4281_free(chip);
-		return err;
-	}
-
-	*rchip = chip;
 	return 0;
 }
 
@@ -1917,22 +2046,180 @@
 		return err;
 	}
 
-	pci_set_drvdata(pci, card);
+	pci_set_drvdata(pci, chip);
 	dev++;
 	return 0;
 }
 
 static void __devexit snd_cs4281_remove(struct pci_dev *pci)
 {
-	snd_card_free(pci_get_drvdata(pci));
+	cs4281_t *chip = pci_get_drvdata(pci);
+	snd_card_free(chip->card);
 	pci_set_drvdata(pci, NULL);
 }
 
+/*
+ * Power Management
+ */
+#ifdef CONFIG_PM
+
+static int saved_regs[SUSPEND_REGISTERS] = {
+	BA0_JSCTL,
+	BA0_GPIOR,
+	BA0_SSCR,
+	BA0_MIDCR,
+	BA0_SRCSA,
+	BA0_PASR,
+	BA0_CASR,
+	BA0_DACSR,
+	BA0_ADCSR,
+	BA0_FMLVC,
+	BA0_FMRVC,
+	BA0_PPLVC,
+	BA0_PPRVC,
+};
+
+#define number_of(array)	(sizeof(array) / sizeof(array[0]))
+
+#define CLKCR1_CKRA                             0x00010000L
+
+static void cs4281_suspend(cs4281_t *chip)
+{
+	snd_card_t *card = chip->card;
+	u32 ulCLK;
+	int i;
+
+	snd_power_lock(card);
+	if (card->power_state == SNDRV_CTL_POWER_D3hot)
+		goto __skip;
+
+	snd_pcm_suspend_all(chip->pcm);
+
+	ulCLK = snd_cs4281_peekBA0(chip, BA0_CLKCR1);
+	ulCLK |= CLKCR1_CKRA;
+	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, ulCLK);
+
+	/* Disable interrupts. */
+	snd_cs4281_pokeBA0(chip, BA0_HICR, BA0_HICR_CHGM);
+
+	/* remember the status registers */
+	for (i = 0; number_of(saved_regs); i++)
+		chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, saved_regs[i]);
+
+	/* Turn off the serial ports. */
+	snd_cs4281_pokeBA0(chip, BA0_SERMC, 0);
+
+	/* Power off FM, Joystick, AC link, */
+	snd_cs4281_pokeBA0(chip, BA0_SSPM, 0);
+
+	/* DLL off. */
+	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, 0);
+
+	/* AC link off. */
+	snd_cs4281_pokeBA0(chip, BA0_SPMC, 0);
+
+	ulCLK = snd_cs4281_peekBA0(chip, BA0_CLKCR1);
+	ulCLK &= ~CLKCR1_CKRA;
+	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, ulCLK);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+ __skip:
+      	snd_power_unlock(card);
+}
+
+static void cs4281_resume(cs4281_t *chip)
+{
+	snd_card_t *card = chip->card;
+	int i;
+	u32 ulCLK;
+
+	snd_power_lock(card);
+	if (card->power_state == SNDRV_CTL_POWER_D0)
+		goto __skip;
+
+	pci_enable_device(chip->pci);
+
+	ulCLK = snd_cs4281_peekBA0(chip, BA0_CLKCR1);
+	ulCLK |= CLKCR1_CKRA;
+	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, ulCLK);
+
+	snd_cs4281_chip_init(chip, 0);
+
+	/* restore the status registers */
+	for (i = 0; number_of(saved_regs); i++)
+		snd_cs4281_pokeBA0(chip, saved_regs[i], chip->suspend_regs[i]);
+
+	if (chip->ac97)
+		snd_ac97_resume(chip->ac97);
+	if (chip->ac97_secondary)
+		snd_ac97_resume(chip->ac97_secondary);
+
+	ulCLK = snd_cs4281_peekBA0(chip, BA0_CLKCR1);
+	ulCLK &= ~CLKCR1_CKRA;
+	snd_cs4281_pokeBA0(chip, BA0_CLKCR1, ulCLK);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+      __skip:
+      	snd_power_unlock(card);
+}
+
+#ifndef PCI_OLD_SUSPEND
+static int snd_cs4281_suspend(struct pci_dev *dev, u32 state)
+{
+	cs4281_t *chip = snd_magic_cast(cs4281_t, pci_get_drvdata(dev), return -ENXIO);
+	cs4281_suspend(chip);
+	return 0;
+}
+static int snd_cs4281_resume(struct pci_dev *dev)
+{
+	cs4281_t *chip = snd_magic_cast(cs4281_t, pci_get_drvdata(dev), return -ENXIO);
+	cs4281_resume(chip);
+	return 0;
+}
+#else
+static void snd_cs4281_suspend(struct pci_dev *dev)
+{
+	cs4281_t *chip = snd_magic_cast(cs4281_t, pci_get_drvdata(dev), return);
+	cs4281_suspend(chip);
+}
+static void snd_cs4281_resume(struct pci_dev *dev)
+{
+	cs4281_t *chip = snd_magic_cast(cs4281_t, pci_get_drvdata(dev), return);
+	cs4281_resume(chip);
+}
+#endif
+
+/* callback */
+static int snd_cs4281_set_power_state(snd_card_t *card, unsigned int power_state)
+{
+	cs4281_t *chip = snd_magic_cast(cs4281_t, card->power_state_private_data, return -ENXIO);
+	switch (power_state) {
+	case SNDRV_CTL_POWER_D0:
+	case SNDRV_CTL_POWER_D1:
+	case SNDRV_CTL_POWER_D2:
+		cs4281_resume(chip);
+		break;
+	case SNDRV_CTL_POWER_D3hot:
+	case SNDRV_CTL_POWER_D3cold:
+		cs4281_suspend(chip);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static struct pci_driver driver = {
 	name: "CS4281",
 	id_table: snd_cs4281_ids,
 	probe: snd_cs4281_probe,
 	remove: __devexit_p(snd_cs4281_remove),
+#ifdef CONFIG_PM
+	suspend: snd_cs4281_suspend,
+	resume: snd_cs4281_resume,
+#endif
 };
 	
 static int __init alsa_card_cs4281_init(void)
diff -Nru a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
--- a/sound/pci/emu10k1/emu10k1_main.c	Tue Oct  1 17:05:36 2002
+++ b/sound/pci/emu10k1/emu10k1_main.c	Tue Oct  1 17:05:36 2002
@@ -534,24 +534,31 @@
 {
 	emu10k1_t *emu;
 	int err;
+	int is_audigy;
 	static snd_device_ops_t ops = {
 		dev_free:	snd_emu10k1_dev_free,
 	};
 	
 	*remu = NULL;
 
+	// is_audigy = (int)pci->driver_data;
+	is_audigy = (pci->device == 0x0004);
+
 	/* enable PCI device */
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	/* check, if we can restrict PCI DMA transfers to 31 bits */
-	if (!pci_dma_supported(pci, 0x7fffffff)) {
-		snd_printk("architecture does not support 31bit PCI busmaster DMA\n");
-		return -ENXIO;
+	/* set the DMA transfer mask */
+	if (is_audigy) {
+		if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+			snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
+			return -ENXIO;
+		}
+	} else {
+		if (pci_set_dma_mask(pci, 0x1fffffff) < 0) {
+			snd_printk(KERN_ERR "architecture does not support 29bit PCI busmaster DMA\n");
+			return -ENXIO;
+		}
 	}
-	if (pci_get_drvdata(pci))
-		pci_set_dma_mask(pci, 0xffffffff); /* audigy */
-	else
-		pci_set_dma_mask(pci, 0x7fffffff);
 
 	emu = snd_magic_kcalloc(emu10k1_t, 0, GFP_KERNEL);
 	if (emu == NULL)
@@ -572,11 +579,8 @@
 	emu->get_synth_voice = NULL;
 	emu->port = pci_resource_start(pci, 0);
 
-	// emu->audigy = (int)pci->driver_data;
-	if (pci->device == 0x0004)
-		emu->audigy = 1;
-
-	if (emu->audigy)
+	emu->audigy = is_audigy;
+	if (is_audigy)
 		emu->gpr_base = A_FXGPREGBASE;
 	else
 		emu->gpr_base = FXGPREGBASE;
diff -Nru a/sound/pci/ice1712.c b/sound/pci/ice1712.c
--- a/sound/pci/ice1712.c	Tue Oct  1 17:05:36 2002
+++ b/sound/pci/ice1712.c	Tue Oct  1 17:05:36 2002
@@ -960,17 +960,25 @@
 };
 
 /* AK4524 chip select; address 0x48 bit 0-3 */
-static void snd_ice1712_ews88mt_chip_select(ice1712_t *ice, int chip_mask)
+static int snd_ice1712_ews88mt_chip_select(ice1712_t *ice, int chip_mask)
 {
 	unsigned char data, ndata;
 
-	snd_assert(chip_mask >= 0 && chip_mask <= 0x0f, return);
+	snd_assert(chip_mask >= 0 && chip_mask <= 0x0f, return -EINVAL);
 	snd_i2c_lock(ice->i2c);
-	snd_runtime_check(snd_i2c_readbytes(ice->pcf8574[1], &data, 1) == 1, snd_i2c_unlock(ice->i2c); return);
+	if (snd_i2c_readbytes(ice->pcf8574[1], &data, 1) != 1)
+		goto __error;
 	ndata = (data & 0xf0) | chip_mask;
 	if (ndata != data)
-		snd_runtime_check(snd_i2c_sendbytes(ice->pcf8574[1], &ndata, 1) == 1, snd_i2c_unlock(ice->i2c); return);
+		if (snd_i2c_sendbytes(ice->pcf8574[1], &ndata, 1) != 1)
+			goto __error;
 	snd_i2c_unlock(ice->i2c);
+	return 0;
+
+     __error:
+	snd_i2c_unlock(ice->i2c);
+	snd_printk(KERN_ERR "AK4524 chip select failed, check cable to the front module\n");
+	return -EIO;
 }
 
 /*
@@ -988,7 +996,8 @@
 
 	if (ice->eeprom.subvendor == ICE1712_SUBDEVICE_EWS88MT) {
 		/* assert AK4524 CS */
-		snd_ice1712_ews88mt_chip_select(ice, ~(1 << chip) & 0x0f);
+		if (snd_ice1712_ews88mt_chip_select(ice, ~(1 << chip) & 0x0f) < 0)
+			return;
 		//snd_ice1712_ews88mt_chip_select(ice, 0x0f);
 	}
 
@@ -1147,11 +1156,11 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_sendbytes(ice->cs8427, reg, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	if (snd_i2c_readbytes(ice->cs8427, &val, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	nval = val & 0xf0;
 	if (spdif_clock)
@@ -1161,7 +1170,7 @@
 	if (val != nval) {
 		reg[1] = nval;
 		if (snd_i2c_sendbytes(ice->cs8427, reg, 2) != 2) {
-			res = -EREMOTE;
+			res = -EIO;
 		} else {
 			res++;
 		}
@@ -3187,7 +3196,7 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8574[1], &data, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	ucontrol->value.enumerated.item[0] = data & ICE1712_EWS88MT_OUTPUT_SENSE ? 1 : 0; /* high = -10dBV, low = +4dBu */
@@ -3203,12 +3212,12 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8574[1], &data, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	ndata = (data & ~ICE1712_EWS88MT_OUTPUT_SENSE) | (ucontrol->value.enumerated.item[0] ? ICE1712_EWS88MT_OUTPUT_SENSE : 0);
 	if (ndata != data && snd_i2c_sendbytes(ice->pcf8574[1], &ndata, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	return ndata != data;
@@ -3225,7 +3234,7 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8574[0], &data, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	/* reversed; high = +4dBu, low = -10dBV */
 	ucontrol->value.enumerated.item[0] = data & (1 << channel) ? 0 : 1;
@@ -3243,12 +3252,12 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8574[0], &data, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	ndata = (data & ~(1 << channel)) | (ucontrol->value.enumerated.item[0] ? 0 : (1 << channel));
 	if (ndata != data && snd_i2c_sendbytes(ice->pcf8574[0], &ndata, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	return ndata != data;
@@ -3294,7 +3303,7 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8575, data, 2) != 2) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	data[0] = (data[shift >> 3] >> (shift & 7)) & 0x01;
@@ -3315,7 +3324,7 @@
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(ice->pcf8575, data, 2) != 2) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	ndata[shift >> 3] = data[shift >> 3] & ~(1 << (shift & 7));
 	if (invert) {
@@ -3328,7 +3337,7 @@
 	change = (data[shift >> 3] != ndata[shift >> 3]);
 	if (change && snd_i2c_sendbytes(ice->pcf8575, data, 2) != 2) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	return change;
@@ -3366,7 +3375,7 @@
 	snd_i2c_sendbytes(ice->pcf8575, &byte, 1);
 	if (snd_i2c_readbytes(ice->pcf8575, &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	return byte;
@@ -3380,7 +3389,7 @@
 	bytes[1] = data;
 	if (snd_i2c_sendbytes(ice->pcf8575, bytes, 2) != 2) {
 		snd_i2c_unlock(ice->i2c);
-		return -EREMOTE;
+		return -EIO;
 	}
 	snd_i2c_unlock(ice->i2c);
 	return 0;
@@ -3836,11 +3845,15 @@
 	}
 	/* second stage of initialization, analog parts and others */
 	switch (ice->eeprom.subvendor) {
+	case ICE1712_SUBDEVICE_EWS88MT:
+		/* Check if the front module is connected */
+		if ((err = snd_ice1712_ews88mt_chip_select(ice, 0x0f)) < 0)
+			return err;
+		/* Fall through */
 	case ICE1712_SUBDEVICE_DELTA66:
 	case ICE1712_SUBDEVICE_DELTA44:
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
 	case ICE1712_SUBDEVICE_EWX2496:
-	case ICE1712_SUBDEVICE_EWS88MT:
 	case ICE1712_SUBDEVICE_DMX6FIRE:
 		snd_ice1712_ak4524_init(ice);
 		break;
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Tue Oct  1 17:05:36 2002
+++ b/sound/pci/maestro3.c	Tue Oct  1 17:05:36 2002
@@ -776,6 +776,14 @@
 #define chip_t m3_t
 
 
+/* quirk lists */
+struct m3_quirk {
+	u16 vendor, device;	/* subsystem ids */
+	int amp_gpio;		/* gpio pin #  for external amp, -1 = default */
+	int irda_workaround;	/* non-zero if avoid to touch 0x10 on GPIO_DIRECTION
+				   (e.g. for IrDA on Dell Inspirons) */
+};
+
 struct m3_list {
 	int curlen;
 	int mem_addr;
@@ -825,9 +833,7 @@
 	snd_pcm_t *pcm;
 
 	struct pci_dev *pci;
-	/* pci_dev in 2.2 kernel doesn't have them, so we keep them private */
-	u16 subsystem_vendor;
-	u16 subsystem_device;
+	struct m3_quirk *quirk;
 
 	int dacs_active;
 	int timer_users;
@@ -908,6 +914,33 @@
 
 MODULE_DEVICE_TABLE(pci, snd_m3_ids);
 
+static struct m3_quirk m3_quirk_list[] = {
+	/* panasonic CF-28 "toughbook" */
+	{
+		vendor: 0x10f7,
+		device: 0x833e,
+		amp_gpio: 0x0d,
+	},
+	/* Dell Inspiron 4000 */
+	{
+		vendor: 0x1028,
+		device: 0x00b0,
+		amp_gpio: -1,
+		irda_workaround: 1,
+	},
+	/* Dell Inspiron 8000 */
+	{
+		vendor: 0x1028,
+		device: 0x00a4,
+		amp_gpio: -1,
+		irda_workaround: 1,
+	},
+	/* FIXME: Inspiron 8100 and 8200 ids should be here, too */
+	/* END */
+	{ 0 }
+};
+
+
 /*
  * lowlevel functions
  */
@@ -1859,10 +1892,7 @@
 
 	for (i = 0; i < 5; i++) {
 		dir = inw(io + GPIO_DIRECTION);
-		if (chip->subsystem_vendor == 0x1028 &&
-		    chip->subsystem_device == 0x00b0) /* Dell Inspiron 4000 */
-			; /* seems conflicting with IrDA */
-		else
+		if (! chip->quirk || ! chip->quirk->irda_workaround)
 			dir |= 0x10; /* assuming pci bus master? */
 
 		snd_m3_remote_codec_config(io, 0);
@@ -2470,6 +2500,8 @@
 {
 	m3_t *chip;
 	int i, err;
+	struct m3_quirk *quirk;
+	u16 subsystem_vendor, subsystem_device;
 	static snd_device_ops_t ops = {
 		dev_free:	snd_m3_dev_free,
 	};
@@ -2500,29 +2532,35 @@
 		break;
 	}
 
+	chip->card = card;
+	chip->pci = pci;
+	chip->irq = -1;
+
 #ifndef LINUX_2_2
-	chip->subsystem_vendor = pci->subsystem_vendor;
-	chip->subsystem_device = pci->subsystem_device;
+	subsystem_vendor = pci->subsystem_vendor;
+	subsystem_device = pci->subsystem_device;
 #else
-	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->subsystem_vendor);
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->subsystem_device);
+	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vendor);
+	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);
 #endif
+	for (quirk = m3_quirk_list; quirk->vendor; quirk++) {
+		if (subsystem_vendor == quirk->vendor &&
+		    subsystem_device == quirk->device) {
+			chip->quirk = quirk;
+			break;
+		}
+	}
 
-	chip->card = card;
-	chip->pci = pci;
-	chip->irq = -1;
 	chip->external_amp = enable_amp;
 	if (amp_gpio >= 0 && amp_gpio <= 0x0f)
 		chip->amp_gpio = amp_gpio;
-	else if (chip->allegro_flag) {
-		/* panasonic CF-28 "toughbook" has different GPIO connection.. */
-		if (chip->subsystem_vendor == 0x10f7 &&
-		    chip->subsystem_device == 0x833e)
-			chip->amp_gpio = 0x0d;
-		else
-			chip->amp_gpio = GPO_EXT_AMP_ALLEGRO;
-	} else
-		chip->amp_gpio = GPO_EXT_AMP_M3; /* presumably this is for all 'maestro3's.. */
+	else if (chip->quirk && chip->quirk->amp_gpio >= 0)
+		chip->amp_gpio = chip->quirk->amp_gpio;
+	else if (chip->allegro_flag)
+		chip->amp_gpio = GPO_EXT_AMP_ALLEGRO;
+	else /* presumably this is for all 'maestro3's.. */
+		chip->amp_gpio = GPO_EXT_AMP_M3;
+
 	chip->num_substreams = NR_DSPS;
 	chip->substreams = kmalloc(sizeof(m3_dma_t) * chip->num_substreams, GFP_KERNEL);
 	if (chip->substreams == NULL) {

===================================================================


This BitKeeper patch contains the following changesets:
1.644
## Wrapped with gzip_uu ##


begin 664 bkpatch22803
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
-2U90_0.B1CD`J5@`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

