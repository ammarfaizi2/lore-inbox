Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRECTzQ>; Thu, 3 May 2001 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRECTzD>; Thu, 3 May 2001 15:55:03 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26319 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S133095AbRECTyl>;
	Thu, 3 May 2001 15:54:41 -0400
Message-ID: <3AF1B777.C407C5AA@mandrakesoft.com>
Date: Thu, 03 May 2001 15:54:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Mathieu Arnold <arn_mat@club-internet.fr>,
        Marcus Meissner <Marcus.Meissner@caldera.de>,
        Danny ter Haar <dth@trinity.hoho.nl>
Subject: PATCH 2.4.4: nm256 audio use ac97_codec (alternative)
Content-Type: multipart/mixed;
 boundary="------------DBA96DE5AC889F7DC78B7920"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DBA96DE5AC889F7DC78B7920
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch against 2.4.4 which updates nm256_audio driver to
use the newer, and maintained, ac97 codec driver.

I'm interested in feedback and testing on this patch -- it includes
additional changes to the ac97_codec driver which may fix some problems
with certain nm256 AC97 chipsets.

Note this patch includes changes found in the 'ac' tree, notably Marcus'
update to the new PCI API.

Note this patch is labelled "alternate" because the previous patch will
go out Alan if testing proves it is ok.  This patch still needs a bit of
work to be perfect for a select few ac97 codecs...

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------DBA96DE5AC889F7DC78B7920
Content-Type: text/plain; charset=us-ascii;
 name="nm2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nm2.patch"

diff -urN linux-2.4.4/drivers/sound/Makefile linux-nm-ac97/drivers/sound/Makefile
--- linux-2.4.4/drivers/sound/Makefile	Fri Apr 13 23:26:07 2001
+++ linux-nm-ac97/drivers/sound/Makefile	Thu May  3 15:44:39 2001
@@ -54,7 +54,7 @@
 obj-$(CONFIG_SOUND_MSNDCLAS)	+= msnd.o msnd_classic.o
 obj-$(CONFIG_SOUND_MSNDPIN)	+= msnd.o msnd_pinnacle.o
 obj-$(CONFIG_SOUND_VWSND)	+= vwsnd.o
-obj-$(CONFIG_SOUND_NM256)	+= nm256_audio.o ac97.o
+obj-$(CONFIG_SOUND_NM256)	+= nm256_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_ICH)		+= i810_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_SONICVIBES)	+= sonicvibes.o
 obj-$(CONFIG_SOUND_CMPCI)	+= cmpci.o
diff -urN linux-2.4.4/drivers/sound/ac97_codec.c linux-nm-ac97/drivers/sound/ac97_codec.c
--- linux-2.4.4/drivers/sound/ac97_codec.c	Fri Apr 20 01:58:20 2001
+++ linux-nm-ac97/drivers/sound/ac97_codec.c	Thu May  3 15:30:13 2001
@@ -31,31 +31,29 @@
  **************************************************************************
  *
  * History
+ * v1.0 Oct 31 2000 Jeff Garzik
+ *	Codec init sequence update, detect bit resolution.
  * v0.4 Mar 15 2000 Ollie Lho
  *	dual codecs support verified with 4 channels output
  * v0.3 Feb 22 2000 Ollie Lho
  *	bug fix for record mask setting
  * v0.2 Feb 10 2000 Ollie Lho
  *	add ac97_read_proc for /proc/driver/{vendor}/ac97
- * v0.1 Jan 14 2000 Ollie Lho <ollie@sis.com.tw> 
+ * v0.1 Jan 14 2000 Ollie Lho <ollie@sis.com.tw>
  *	Isolated from trident.c to support multiple ac97 codec
  */
+
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/soundcard.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
 
-static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel);
-static void ac97_write_mixer(struct ac97_codec *codec, int oss_channel, 
-			     unsigned int left, unsigned int right);
-static void ac97_set_mixer(struct ac97_codec *codec, unsigned int oss_mixer, unsigned int val );
-static int ac97_recmask_io(struct ac97_codec *codec, int rw, int mask);
-static int ac97_mixer_ioctl(struct ac97_codec *codec, unsigned int cmd, unsigned long arg);
+#undef DEBUG
 
 static int ac97_init_mixer(struct ac97_codec *codec);
 
@@ -70,7 +68,7 @@
 /* sorted by vendor/device id */
 static const struct {
 	u32 id;
-	char *name;
+	const char *name;
 	int  (*init)  (struct ac97_codec *codec);
 } ac97_codec_ids[] = {
 	{0x41445303, "Analog Devices AD1819",	NULL},
@@ -83,14 +81,21 @@
 	{0x414C4710, "ALC200/200P",		NULL},
 	{0x43525900, "Cirrus Logic CS4297",	enable_eapd},
 	{0x43525903, "Cirrus Logic CS4297",	enable_eapd},
-	{0x43525913, "Cirrus Logic CS4297A rev A", enable_eapd},
-	{0x43525914, "Cirrus Logic CS4297A rev B", NULL},
+	{0x43525911, "Cirrus Logic CS4297A rev A", NULL},
+	{0x43525912, "Cirrus Logic CS4297A rev B", NULL},
+	{0x43525913, "Cirrus Logic CS4297A rev C", enable_eapd},
+	{0x43525914, "Cirrus Logic CS4297A rev D/E/F/G/H", NULL},
+	{0x43525915, "Cirrus Logic CS4297A rev K", NULL},
+	{0x43525916, "Cirrus Logic CS4297A rev L", NULL},
 	{0x43525923, "Cirrus Logic CS4298",	NULL},
 	{0x4352592B, "Cirrus Logic CS4294",	NULL},
 	{0x4352592D, "Cirrus Logic CS4294",	NULL},
 	{0x43525931, "Cirrus Logic CS4299 rev A", NULL},
+	{0x43525932, "Cirrus Logic CS4299 rev B", NULL},
 	{0x43525933, "Cirrus Logic CS4299 rev C", NULL},
-	{0x43525934, "Cirrus Logic CS4299 rev D", NULL},
+	{0x43525934, "Cirrus Logic CS4299 rev D/E/F/G/H", NULL},
+	{0x43525935, "Cirrus Logic CS4299 rev K", NULL},
+	{0x43525936, "Cirrus Logic CS4299 rev L", NULL},
 	{0x45838308, "ESS Allegro ES1988",	NULL},
 	{0x49434511, "ICE1232",			NULL}, /* I hope --jk */
 	{0x4e534331, "National Semiconductor LM4549", NULL},
@@ -152,48 +157,30 @@
 	/*  31 */ "Reserved 31"
 };
 
-/* this table has default mixer values for all OSS mixers. */
-static struct mixer_defaults {
-	int mixer;
-	unsigned int value;
-} mixer_defaults[SOUND_MIXER_NRDEVICES] = {
-	/* all values 0 -> 100 in bytes */
-	{SOUND_MIXER_VOLUME,	0x4343},
-	{SOUND_MIXER_BASS,	0x4343},
-	{SOUND_MIXER_TREBLE,	0x4343},
-	{SOUND_MIXER_PCM,	0x4343},
-	{SOUND_MIXER_SPEAKER,	0x4343},
-	{SOUND_MIXER_LINE,	0x4343},
-	{SOUND_MIXER_MIC,	0x0000},
-	{SOUND_MIXER_CD,	0x4343},
-	{SOUND_MIXER_ALTPCM,	0x4343},
-	{SOUND_MIXER_IGAIN,	0x4343},
-	{SOUND_MIXER_LINE1,	0x4343},
-	{SOUND_MIXER_PHONEIN,	0x4343},
-	{SOUND_MIXER_PHONEOUT,	0x4343},
-	{SOUND_MIXER_VIDEO,	0x4343},
-	{-1,0}
-};
+static const int ac97_def_mix_val = 0x4343;
 
-/* table to scale scale from OSS mixer value to AC97 mixer register value */	
-static struct ac97_mixer_hw {
-	unsigned char offset;
-	int scale;
+static const struct ac97_mixer_hw {
+	unsigned char reg;	/* AC97 mixer register */
+	int offset;		/* bit offset from start of register to value */
+	int def_mix_val;	/* 0 == use 'ac97_def_mix_val', >0, use this val */
+	int stereo : 1;		/* 1 == stereo (total_res == bit_res * 2) */
+	int mute : 1;		/* 1 == can use bit 15 (mute) */
+	int bits;		/* maximum bit resolution (from AC97 docs) */
 } ac97_hw[SOUND_MIXER_NRDEVICES]= {
-	[SOUND_MIXER_VOLUME]	=	{AC97_MASTER_VOL_STEREO,64},
-	[SOUND_MIXER_BASS]	=	{AC97_MASTER_TONE,	16},
-	[SOUND_MIXER_TREBLE]	=	{AC97_MASTER_TONE,	16},
-	[SOUND_MIXER_PCM]	=	{AC97_PCMOUT_VOL,	32},
-	[SOUND_MIXER_SPEAKER]	=	{AC97_PCBEEP_VOL,	16},
-	[SOUND_MIXER_LINE]	=	{AC97_LINEIN_VOL,	32},
-	[SOUND_MIXER_MIC]	=	{AC97_MIC_VOL,		32},
-	[SOUND_MIXER_CD]	=	{AC97_CD_VOL,		32},
-	[SOUND_MIXER_ALTPCM]	=	{AC97_HEADPHONE_VOL,	64},
-	[SOUND_MIXER_IGAIN]	=	{AC97_RECORD_GAIN,	16},
-	[SOUND_MIXER_LINE1]	=	{AC97_AUX_VOL,		32},
-	[SOUND_MIXER_PHONEIN]	= 	{AC97_PHONE_VOL,	32},
-	[SOUND_MIXER_PHONEOUT]	= 	{AC97_MASTER_VOL_MONO,	64},
-	[SOUND_MIXER_VIDEO]	=	{AC97_VIDEO_VOL,	32},
+	[SOUND_MIXER_VOLUME]	= {AC97_MASTER_VOL_STEREO, 0, 0, 1, 1, 6},
+	[SOUND_MIXER_BASS]	= {AC97_MASTER_TONE,	   8, 0, 0, 0, 4},
+	[SOUND_MIXER_TREBLE]	= {AC97_MASTER_TONE,	   0, 0, 0, 0, 4},
+	[SOUND_MIXER_PCM]	= {AC97_PCMOUT_VOL,	   0, 0, 1, 1, 5},
+	[SOUND_MIXER_SPEAKER]	= {AC97_PCBEEP_VOL,	   1, 0, 0, 0, 4},
+	[SOUND_MIXER_LINE]	= {AC97_LINEIN_VOL,	   0, 0, 1, 1, 5},
+	[SOUND_MIXER_MIC]	= {AC97_MIC_VOL,	   0, 0x8000, 0, 1, 5},
+	[SOUND_MIXER_CD]	= {AC97_CD_VOL,		   0, 0, 1, 1, 5},
+	[SOUND_MIXER_ALTPCM]	= {AC97_HEADPHONE_VOL,	   0, 0, 1, 1, 6},
+	[SOUND_MIXER_IGAIN]	= {AC97_RECORD_GAIN,	   0, 0, 1, 1, 4},
+	[SOUND_MIXER_LINE1]	= {AC97_AUX_VOL,	   0, 0, 1, 1, 5},
+	[SOUND_MIXER_PHONEIN]	= {AC97_PHONE_VOL,	   0, 0, 0, 1, 5},
+	[SOUND_MIXER_PHONEOUT]	= {AC97_MASTER_VOL_MONO,   0, 0, 0, 1, 6},
+	[SOUND_MIXER_VIDEO]	= {AC97_VIDEO_VOL,	   0, 0, 1, 1, 5},
 };
 
 /* the following tables allow us to go from OSS <-> ac97 quickly. */
@@ -229,62 +216,88 @@
 	[SOUND_MIXER_PHONEIN] 	= AC97_REC_PHONE
 };
 
+
+static int ac97_valid_reg (struct ac97_codec *codec, u8 reg)
+{
+	switch (codec->type) {
+	case 0x414B4D00:	/* AK4540 */
+	case 0x414B4D01:	/* AK4542 */
+		if (reg <= 0x1c || reg == 0x20 || reg == 0x26 || reg >= 0x7c)
+			return 1;
+		return 0;
+	case 0x41445303:	/* AD1819 */
+	case 0x41445340:	/* AD1881 */
+	case 0x41445348:	/* AD1881A */
+	case 0x41445460:	/* AD1885 */
+		if (reg >= 0x3a && reg <= 0x59)
+			return 0;
+		return 1;
+	}
+	return 1;
+}
+
+
+u16 ac97_codec_read (struct ac97_codec *codec, u8 reg)
+{
+	if (!ac97_valid_reg(codec, reg) || !codec->codec_read)
+		return 0;
+	return codec->codec_read (codec, reg);
+}
+
+
+void ac97_codec_write (struct ac97_codec *codec, u8 reg, u16 val)
+{
+	if (!ac97_valid_reg(codec, reg) || !codec->codec_write)
+		return;
+	codec->codec_write (codec, reg, val);
+}
+
+
 /* reads the given OSS mixer from the ac97 the caller must have insured that the ac97 knows
    about that given mixer, and should be holding a spinlock for the card */
-static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel) 
+int ac97_read_mixer(struct ac97_codec *codec, int oss_channel)
 {
 	u16 val;
 	int ret = 0;
 	int scale;
-	struct ac97_mixer_hw *mh = &ac97_hw[oss_channel];
+	const struct ac97_mixer_hw *mh = &ac97_hw[oss_channel];
 
-	val = codec->codec_read(codec , mh->offset);
+	val = ac97_codec_read(codec , mh->reg);
 
-	if (val & AC97_MUTE) {
+	/* muted channels are easy */
+	if (mh->mute && (val & AC97_MUTE))
 		ret = 0;
-	} else if (AC97_STEREO_MASK & (1 << oss_channel)) {
-		/* nice stereo mixers .. */
+
+	/* stereo channels */
+	else if (mh->stereo) {
 		int left,right;
 
+		if (mh->offset > 0)
+			BUG();
+
 		left = (val >> 8)  & 0x7f;
 		right = val  & 0x7f;
 
-		if (oss_channel == SOUND_MIXER_IGAIN) {
-			right = (right * 100) / mh->scale;
-			left = (left * 100) / mh->scale;
-		} else {
-			/* these may have 5 or 6 bit resolution */
-			if(oss_channel == SOUND_MIXER_VOLUME || oss_channel == SOUND_MIXER_ALTPCM)
-				scale = (1 << codec->bit_resolution);
-			else
-				scale = mh->scale;
+		scale = (1 << codec->mixer[oss_channel].bits);
+
+		right = 100 - ((right * 100) / scale);
+		left = 100 - ((left * 100) / scale);
 
-			right = 100 - ((right * 100) / scale);
-			left = 100 - ((left * 100) / scale);
-		}
 		ret = left | (right << 8);
-	} else if (oss_channel == SOUND_MIXER_SPEAKER) {
-		ret = 100 - ((((val & 0x1e)>>1) * 100) / mh->scale);
-	} else if (oss_channel == SOUND_MIXER_PHONEIN) {
-		ret = 100 - (((val & 0x1f) * 100) / mh->scale);
-	} else if (oss_channel == SOUND_MIXER_PHONEOUT) {
-		scale = (1 << codec->bit_resolution);
+	}
+
+	/* mono channels */
+	else {
+		scale = (1 << codec->mixer[oss_channel].bits);
+		val >>= mh->offset;
 		ret = 100 - (((val & 0x1f) * 100) / scale);
-	} else if (oss_channel == SOUND_MIXER_MIC) {
-		ret = 100 - (((val & 0x1f) * 100) / mh->scale);
-		/*  the low bit is optional in the tone sliders and masking
-		    it lets us avoid the 0xf 'bypass'.. */
-	} else if (oss_channel == SOUND_MIXER_BASS) {
-		ret = 100 - ((((val >> 8) & 0xe) * 100) / mh->scale);
-	} else if (oss_channel == SOUND_MIXER_TREBLE) {
-		ret = 100 - (((val & 0xe) * 100) / mh->scale);
 	}
 
 #ifdef DEBUG
 	printk("ac97_codec: read OSS mixer %2d (%s ac97 register 0x%02x), "
 	       "0x%04x -> 0x%04x\n",
 	       oss_channel, codec->id ? "Secondary" : "Primary",
-	       mh->offset, val, ret);
+	       mh->reg, val, ret);
 #endif
 
 	return ret;
@@ -292,102 +305,76 @@
 
 /* write the OSS encoded volume to the given OSS encoded mixer, again caller's job to
    make sure all is well in arg land, call with spinlock held */
-static void ac97_write_mixer(struct ac97_codec *codec, int oss_channel,
+void ac97_write_mixer(struct ac97_codec *codec, int oss_channel,
 		      unsigned int left, unsigned int right)
 {
 	u16 val = 0;
 	int scale;
-	struct ac97_mixer_hw *mh = &ac97_hw[oss_channel];
+	const struct ac97_mixer_hw *mh = &ac97_hw[oss_channel];
 
 #ifdef DEBUG
-	printk("ac97_codec: wrote OSS mixer %2d (%s ac97 register 0x%02x), "
+	printk("ac97_codec: wrote OSS mixer %2d (%s ac97 register 0x%02x bitres %d), "
 	       "left vol:%2d, right vol:%2d:",
 	       oss_channel, codec->id ? "Secondary" : "Primary",
-	       mh->offset, left, right);
+	       mh->reg, codec->mixer[oss_channel].bits, left, right);
 #endif
 
-	if (AC97_STEREO_MASK & (1 << oss_channel)) {
-		/* stereo mixers */
-		if (left == 0 && right == 0) {
+	scale = (1 << codec->mixer[oss_channel].bits);
+
+	/* mic vol has a special bit to preserve, special case */
+	if (oss_channel == SOUND_MIXER_MIC) {
+		val = ac97_codec_read(codec, mh->reg) & (1<<6);
+		if (left == 0)
+			val |= AC97_MUTE;
+		else
+			val |= (((100 - left) * scale) / 100);
+	}
+
+	/* bass shares a register with treble, special case */
+	else if (oss_channel == SOUND_MIXER_BASS) {
+		val = ac97_codec_read(codec, mh->reg) & 0x000F;
+		val |= ((((100 - left) * scale) / 100) << 8) & 0x0E00;
+	}
+
+	/* treble shares a register with bass, special case */
+	else if (oss_channel == SOUND_MIXER_TREBLE) {
+		val = ac97_codec_read(codec, mh->reg) & 0x0F00;
+		val |= (((100 - left) * scale) / 100) & 0x000E;
+	}
+
+	/* handle stereo channel */
+	else if (mh->stereo) {
+		if (left == 0 && right == 0)
 			val = AC97_MUTE;
-		} else {
-			if (oss_channel == SOUND_MIXER_IGAIN) {
-				right = (right * mh->scale) / 100;
-				left = (left * mh->scale) / 100;
-				if (right >= mh->scale)
-					right = mh->scale-1;
-				if (left >= mh->scale)
-					left = mh->scale-1;
-			} else {
-				/* these may have 5 or 6 bit resolution */
-				if (oss_channel == SOUND_MIXER_VOLUME ||
-				    oss_channel == SOUND_MIXER_ALTPCM)
-					scale = (1 << codec->bit_resolution);
-				else
-					scale = mh->scale;
-
-				right = ((100 - right) * scale) / 100;
-				left = ((100 - left) * scale) / 100;
-				if (right >= scale)
-					right = scale-1;
-				if (left >= scale)
-					left = scale-1;
-			}
+		else {
+			right = ((100 - right) * scale) / 100;
+			left = ((100 - left) * scale) / 100;
 			val = (left << 8) | right;
 		}
-	} else if (oss_channel == SOUND_MIXER_BASS) {
-		val = codec->codec_read(codec , mh->offset) & ~0x0f00;
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val |= (left << 8) & 0x0e00;
-	} else if (oss_channel == SOUND_MIXER_TREBLE) {
-		val = codec->codec_read(codec , mh->offset) & ~0x000f;
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val |= left & 0x000e;
-	} else if(left == 0) {
-		val = AC97_MUTE;
-	} else if (oss_channel == SOUND_MIXER_SPEAKER) {
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val = left << 1;
-	} else if (oss_channel == SOUND_MIXER_PHONEIN) {
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val = left;
-	} else if (oss_channel == SOUND_MIXER_PHONEOUT) {
-		scale = (1 << codec->bit_resolution);
-		left = ((100 - left) * scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val = left;
-	} else if (oss_channel == SOUND_MIXER_MIC) {
-		val = codec->codec_read(codec , mh->offset) & ~0x801f;
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val |= left;
-		/*  the low bit is optional in the tone sliders and masking
-		    it lets us avoid the 0xf 'bypass'.. */
 	}
+
+	/* handle mono channel */
+	else {
+		if (left == 0)
+			val = AC97_MUTE;
+		else
+			val = (((100 - left) * scale) / 100);
+	}
+
 #ifdef DEBUG
 	printk(" 0x%04x", val);
 #endif
 
-	codec->codec_write(codec, mh->offset, val);
+	ac97_codec_write(codec, mh->reg, val);
 
 #ifdef DEBUG
-	val = codec->codec_read(codec, mh->offset);
+	val = ac97_codec_read(codec, mh->reg);
 	printk(" -> 0x%04x\n", val);
 #endif
 }
 
 /* a thin wrapper for write_mixer */
-static void ac97_set_mixer(struct ac97_codec *codec, unsigned int oss_mixer, unsigned int val ) 
+static void ac97_set_mixer(struct ac97_codec *codec, unsigned int oss_mixer, unsigned int val)
 {
 	unsigned int left,right;
 
@@ -398,21 +385,20 @@
 	if (right > 100) right = 100;
 	if (left > 100) left = 100;
 
-	codec->mixer_state[oss_mixer] = (right << 8) | left;
-	codec->write_mixer(codec, oss_mixer, left, right);
+	codec->mixer[oss_mixer].mixer_state = (right << 8) | left;
+	ac97_write_mixer(codec, oss_mixer, left, right);
 }
 
 /* read or write the recmask, the ac97 can really have left and right recording
    inputs independantly set, but OSS doesn't seem to want us to express that to
-   the user. the caller guarantees that we have a supported bit set, and they
-   must be holding the card's spinlock */
-static int ac97_recmask_io(struct ac97_codec *codec, int rw, int mask) 
+   the user. the caller guarantees that we have a supported bit set */
+static int ac97_recmask_io(struct ac97_codec *codec, int rw, int mask)
 {
 	unsigned int val;
 
 	if (rw) {
 		/* read it from the card */
-		val = codec->codec_read(codec, AC97_RECORD_SELECT);
+		val = ac97_codec_read(codec, AC97_RECORD_SELECT);
 #ifdef DEBUG
 		printk("ac97_codec: ac97 recmask to set to 0x%04x\n", val);
 #endif
@@ -420,13 +406,13 @@
 	}
 
 	/* else, write the first set in the mask as the
-	   output */	
+	   output */
 	/* clear out current set value first (AC97 supports only 1 input!) */
-	val = (1 << ac97_rm2oss[codec->codec_read(codec, AC97_RECORD_SELECT) & 0x07]);
+	val = (1 << ac97_rm2oss[ac97_codec_read(codec, AC97_RECORD_SELECT) & 0x07]);
 	if (mask != val)
 	    mask &= ~val;
-       
-	val = ffs(mask); 
+
+	val = ffs(mask);
 	val = ac97_oss_rm[val-1];
 	val |= val << 8;  /* set both channels */
 
@@ -434,7 +420,7 @@
 	printk("ac97_codec: setting ac97 recmask to 0x%04x\n", val);
 #endif
 
-	codec->codec_write(codec, AC97_RECORD_SELECT, val);
+	ac97_codec_write(codec, AC97_RECORD_SELECT, val);
 
 	return 0;
 };
@@ -496,12 +482,12 @@
 		default: /* read a specific mixer */
 			i = _IOC_NR(cmd);
 
-			if (!supported_mixer(codec, i)) 
+			if (!supported_mixer(codec, i))
 				return -EINVAL;
 
 			/* do we ever want to touch the hardware? */
-		        /* val = codec->read_mixer(codec, i); */
-			val = codec->mixer_state[i];
+		        /* val = ac97_read_mixer(codec, i); */
+			val = codec->mixer[i].mixer_state;
  			break;
 		}
 		return put_user(val, (int *)arg);
@@ -524,7 +510,7 @@
 		default: /* write a specific mixer */
 			i = _IOC_NR(cmd);
 
-			if (!supported_mixer(codec, i)) 
+			if (!supported_mixer(codec, i))
 				return -EINVAL;
 
 			ac97_set_mixer(codec, i, val);
@@ -546,18 +532,18 @@
 	if ((codec = data) == NULL)
 		return -ENODEV;
 
-	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
-	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
+	id1 = ac97_codec_read(codec, AC97_VENDOR_ID1);
+	id2 = ac97_codec_read(codec, AC97_VENDOR_ID2);
 	len += sprintf (page+len, "Vendor name      : %s\n", codec->name);
 	len += sprintf (page+len, "Vendor id        : %04X %04X\n", id1, id2);
 
-	extid = codec->codec_read(codec, AC97_EXTENDED_ID);
+	extid = ac97_codec_read(codec, AC97_EXTENDED_ID);
 	extid &= ~((1<<2)|(1<<4)|(1<<5)|(1<<10)|(1<<11)|(1<<12)|(1<<13));
 	len += sprintf (page+len, "AC97 Version     : %s\n",
 			extid ? "2.0 or later" : "1.0");
 	if (extid) is_ac97_20 = 1;
 
-	cap = codec->codec_read(codec, AC97_RESET);
+	cap = ac97_codec_read(codec, AC97_RESET);
 	len += sprintf (page+len, "Capabilities     :%s%s%s%s%s%s\n",
 			cap & 0x0001 ? " -dedicated MIC PCM IN channel-" : "",
 			cap & 0x0002 ? " -reserved1-" : "",
@@ -578,7 +564,7 @@
 	len += sprintf (page+len, "3D enhancement   : %s\n",
 			ac97_stereo_enhancements[(cap >> 10) & 0x1f]);
 
-	val = codec->codec_read(codec, AC97_GENERAL_PURPOSE);
+	val = ac97_codec_read(codec, AC97_GENERAL_PURPOSE);
 	len += sprintf (page+len, "POP path         : %s 3D\n"
 			"Sim. stereo      : %s\n"
 			"3D enhancement   : %s\n"
@@ -594,7 +580,7 @@
 			val & 0x0100 ? "MIC2" : "MIC1",
 			val & 0x0080 ? "on" : "off");
 
-	extid = codec->codec_read(codec, AC97_EXTENDED_ID);
+	extid = ac97_codec_read(codec, AC97_EXTENDED_ID);
 	cap = extid;
 	len += sprintf (page+len, "Ext Capabilities :%s%s%s%s%s%s%s\n",
 			cap & 0x0001 ? " -var rate PCM audio-" : "",
@@ -606,7 +592,7 @@
 			cap & 0x0200 ? " -slot/DAC mappings-" : "");
 	if (is_ac97_20) {
 		len += sprintf (page+len, "Front DAC rate   : %d\n",
-				codec->codec_read(codec, AC97_PCM_FRONT_DAC_RATE));
+				ac97_codec_read(codec, AC97_PCM_FRONT_DAC_RATE));
 	}
 
 	return len;
@@ -630,48 +616,42 @@
  *	codec-ready state.  If codec_wait is %NULL, then
  *	the default behavior is to call schedule_timeout.
  *	Currently codec_wait is used to wait for AC97 codec
- *	reset to complete. 
+ *	reset to complete.
  *
  *	Returns 1 (true) on success, or 0 (false) on failure.
  */
- 
+
 int ac97_probe_codec(struct ac97_codec *codec)
 {
 	u16 id1, id2;
-	u16 audio, modem;
 	int i;
 
-	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
-	 * be read zero.
-	 *
-	 * FIXME: is the following comment outdated?  -jgarzik 
-	 * Probing of AC97 in this way is not reliable, it is not even SAFE !!
-	 */
-	codec->codec_write(codec, AC97_RESET, 0L);
+	ac97_codec_write(codec, AC97_RESET, 0L);
 
-	/* also according to spec, we wait for codec-ready state */	
+	/* according to spec, we wait for codec-ready state */
 	if (codec->codec_wait)
 		codec->codec_wait(codec);
-	else
-		udelay(10);
+	else {
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout((5*HZ)/100);
+	}
 
-	if ((audio = codec->codec_read(codec, AC97_RESET)) & 0x8000) {
-		printk(KERN_ERR "ac97_codec: %s ac97 codec not present\n",
-		       codec->id ? "Secondary" : "Primary");
+	/* spec sez, we can always mute Master Vol */
+	ac97_codec_write(codec, AC97_MASTER_VOL_STEREO, 0x8000);
+	i = ac97_codec_read(codec, AC97_MASTER_VOL_STEREO);
+	if (i != 0x8000) {
+		printk(KERN_ERR "AC97 codec does not respond (0x%04X)\n", i);
 		return 0;
 	}
 
-	/* probe for Modem Codec */
-	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
-	modem = codec->codec_read(codec, AC97_EXTENDED_MODEM_ID);
-
 	codec->name = NULL;
 	codec->codec_init = NULL;
 
-	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
-	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
+	id1 = ac97_codec_read(codec, AC97_VENDOR_ID1);
+	id2 = ac97_codec_read(codec, AC97_VENDOR_ID2);
 	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
 		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
+			codec->idx = i;
 			codec->type = ac97_codec_ids[i].id;
 			codec->name = ac97_codec_ids[i].name;
 			codec->codec_init = ac97_codec_ids[i].init;
@@ -680,60 +660,110 @@
 	}
 	if (codec->name == NULL)
 		codec->name = "Unknown";
-	printk(KERN_INFO "ac97_codec: AC97 %s codec, id: 0x%04x:"
-	       "0x%04x (%s)\n", audio ? "Audio" : (modem ? "Modem" : ""),
-	       id1, id2, codec->name);
+	printk(KERN_INFO "ac97_codec: AC97 codec, id: 0x%04x:"
+	       "0x%04x (%s)\n", id1, id2, codec->name);
 
-	return ac97_init_mixer(codec);
+	return ac97_init_mixer(codec) ? 0 : 1;
 }
 
 static int ac97_init_mixer(struct ac97_codec *codec)
 {
 	u16 cap;
+	u32 val;
 	int i;
 
-	cap = codec->codec_read(codec, AC97_RESET);
+	cap = ac97_codec_read(codec, AC97_RESET);
 
 	/* mixer masks */
-	codec->supported_mixers = AC97_SUPPORTED_MASK;
 	codec->stereo_mixers = AC97_STEREO_MASK;
 	codec->record_sources = AC97_RECORD_MASK;
+
+	val = 0;
+	for (i = SOUND_MIXER_NRDEVICES; i >= 0; i--)
+		val |= (1 << i);
+
+	if (codec->supported_mixers == 0) /* 0 == autodetect */
+		codec->supported_mixers = val;
 	if (!(cap & 0x04))
 		codec->supported_mixers &= ~(SOUND_MASK_BASS|SOUND_MASK_TREBLE);
 	if (!(cap & 0x10))
 		codec->supported_mixers &= ~SOUND_MASK_ALTPCM;
 
-	/* detect bit resolution */
-	codec->codec_write(codec, AC97_MASTER_VOL_STEREO, 0x2020);
-	if(codec->codec_read(codec, AC97_MASTER_VOL_STEREO) == 0x1f1f)
-		codec->bit_resolution = 5;
-	else
-		codec->bit_resolution = 6;
-
 	/* generic OSS to AC97 wrapper */
-	codec->read_mixer = ac97_read_mixer;
-	codec->write_mixer = ac97_write_mixer;
 	codec->recmask_io = ac97_recmask_io;
 	codec->mixer_ioctl = ac97_mixer_ioctl;
 
 	/* codec specific initialization for 4-6 channel output or secondary codec stuff */
-	if (codec->codec_init != NULL) {
-		codec->codec_init(codec);
+	if (codec->codec_init) {
+		i = codec->codec_init(codec);
+		if (i)
+			return i;
 	}
 
-	/* initialize mixer channel volumes */
+	/* detect mixer channels, initilize mixer channel volumes */
 	for (i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
-		struct mixer_defaults *md = &mixer_defaults[i];
-		if (md->mixer == -1) 
-			break;
-		if (!supported_mixer(codec, md->mixer)) 
+		const struct ac97_mixer_hw *mhw = &ac97_hw[i];
+		u16 orig, test;
+
+#ifdef DEBUG
+		{
+		char *oss_mix_names[] = SOUND_DEVICE_NAMES;
+		printk("ac97_codec:  init OSS mixer %d (%s): ", i, oss_mix_names[i]);
+		}
+#endif
+
+		if (!supported_mixer(codec, i)) {
+#ifdef DEBUG
+			printk("not supported\n");
+#endif
+			continue;
+		}
+
+		if (!mhw->reg) {
+#ifdef DEBUG
+			printk("not supported by AC97\n");
+#endif
+			codec->supported_mixers &= ~(1 << i);
 			continue;
-		ac97_set_mixer(codec, md->mixer, md->value);
+		}
+
+		/* detect mixer channel existence and bit resolution */
+		orig = ac97_codec_read(codec, mhw->reg);
+		ac97_codec_write(codec, mhw->reg, 0x3F);
+		test = ac97_codec_read(codec, mhw->reg);
+		ac97_codec_write(codec, mhw->reg, orig);
+
+		if (test) {
+			int bitcnt = 1;
+
+			while ((bitcnt < mhw->bits) && ((1 << bitcnt) & test))
+				bitcnt++;
+			codec->mixer[i].bits = bitcnt;
+
+#ifdef DEBUG
+			printk("bit res. %d\n", bitcnt);
+#endif
+
+			if (mhw->def_mix_val)
+				ac97_set_mixer(codec, i, mhw->def_mix_val);
+			else
+				ac97_set_mixer(codec, i, ac97_def_mix_val);
+
+			codec->supported_mixers |= (1 << i);
+		} else {
+#ifdef DEBUG
+			printk("mixer read failed, ignoring\n");
+#endif
+
+			codec->mixer[i].bits = 0;
+			codec->supported_mixers &= ~(1 << i);
+		}
 	}
 
-	return 1;
+	return 0;
 }
 
+
 #define AC97_SIGMATEL_ANALOG    0x6c	/* Analog Special */
 #define AC97_SIGMATEL_DAC2INVERT 0x6e
 #define AC97_SIGMATEL_BIAS1     0x70
@@ -747,22 +777,22 @@
 {
 	u16 codec72, codec6c;
 
-	codec72 = codec->codec_read(codec, AC97_SIGMATEL_BIAS2) & 0x8000;
-	codec6c = codec->codec_read(codec, AC97_SIGMATEL_ANALOG);
+	codec72 = ac97_codec_read(codec, AC97_SIGMATEL_BIAS2) & 0x8000;
+	codec6c = ac97_codec_read(codec, AC97_SIGMATEL_ANALOG);
 
 	if ((codec72==0) && (codec6c==0)) {
-		codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
-		codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x1000);
-		codec->codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
-		codec->codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0007);
+		ac97_codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+		ac97_codec_write(codec, AC97_SIGMATEL_CIC2, 0x1000);
+		ac97_codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
+		ac97_codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0007);
 	} else if ((codec72==0x8000) && (codec6c==0)) {
-		codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
-		codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x1001);
-		codec->codec_write(codec, AC97_SIGMATEL_DAC2INVERT, 0x0008);
+		ac97_codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+		ac97_codec_write(codec, AC97_SIGMATEL_CIC2, 0x1001);
+		ac97_codec_write(codec, AC97_SIGMATEL_DAC2INVERT, 0x0008);
 	} else if ((codec72==0x8000) && (codec6c==0x0080)) {
 		/* nothing */
 	}
-	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
+	ac97_codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
 	return 0;
 }
 
@@ -773,60 +803,59 @@
 	if (codec->id == 0)
 		return 0;
 
-	codec->codec_write(codec, AC97_SURROUND_MASTER, 0L);
+	ac97_codec_write(codec, AC97_SURROUND_MASTER, 0L);
 
 	/* initialize SigmaTel STAC9721/23 as secondary codec, decoding AC link
 	   sloc 3,4 = 0x01, slot 7,8 = 0x00, */
-	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x00);
+	ac97_codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x00);
 
 	/* we don't have the crystal when we are on an AMR card, so use
 	   BIT_CLK as our clock source. Write the magic word ABBA and read
 	   back to enable register 0x78 */
-	codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
-	codec->codec_read(codec, AC97_SIGMATEL_CIC1);
+	ac97_codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+	ac97_codec_read(codec, AC97_SIGMATEL_CIC1);
 
 	/* sync all the clocks*/
-	codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x3802);
+	ac97_codec_write(codec, AC97_SIGMATEL_CIC2, 0x3802);
 
 	return 0;
 }
 
-
 static int sigmatel_9744_init(struct ac97_codec * codec)
 {
 	// patch for SigmaTel
-	codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
-	codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x0000); // is this correct? --jk
-	codec->codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
-	codec->codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0002);
-	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
+	ac97_codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+	ac97_codec_write(codec, AC97_SIGMATEL_CIC2, 0x0000); // is this correct? --jk
+	ac97_codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
+	ac97_codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0002);
+	ac97_codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
 	return 0;
 }
 
 
 static int wolfson_init(struct ac97_codec * codec)
 {
-	codec->codec_write(codec, 0x72, 0x0808);
-	codec->codec_write(codec, 0x74, 0x0808);
+	ac97_codec_write(codec, 0x72, 0x0808);
+	ac97_codec_write(codec, 0x74, 0x0808);
 
 	// patch for DVD noise
-	codec->codec_write(codec, 0x5a, 0x0200);
+	ac97_codec_write(codec, 0x5a, 0x0200);
 
 	// init vol as PCM vol
-	codec->codec_write(codec, 0x70,
-		codec->codec_read(codec, AC97_PCMOUT_VOL));
+	ac97_codec_write(codec, 0x70,
+		ac97_codec_read(codec, AC97_PCMOUT_VOL));
 
-	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	ac97_codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
 	return 0;
 }
 
 
 static int tritech_init(struct ac97_codec * codec)
 {
-	codec->codec_write(codec, 0x26, 0x0300);
-	codec->codec_write(codec, 0x26, 0x0000);
-	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
-	codec->codec_write(codec, AC97_RESERVED_3A, 0x0000);
+	ac97_codec_write(codec, 0x26, 0x0300);
+	ac97_codec_write(codec, 0x26, 0x0000);
+	ac97_codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	ac97_codec_write(codec, AC97_RESERVED_3A, 0x0000);
 	return 0;
 }
 
@@ -835,9 +864,9 @@
 static int tritech_maestro_init(struct ac97_codec * codec)
 {
 	/* no idea what this does */
-	codec->codec_write(codec, 0x2A, 0x0001);
-	codec->codec_write(codec, 0x2C, 0x0000);
-	codec->codec_write(codec, 0x2C, 0XFFFF);
+	ac97_codec_write(codec, 0x2A, 0x0001);
+	ac97_codec_write(codec, 0x2C, 0x0000);
+	ac97_codec_write(codec, 0x2C, 0XFFFF);
 	return 0;
 }
 
@@ -849,8 +878,8 @@
 
 static int enable_eapd(struct ac97_codec * codec)
 {
-	codec->codec_write(codec, AC97_POWER_CONTROL,
-		codec->codec_read(codec, AC97_POWER_CONTROL)|0x8000);
+	ac97_codec_write(codec, AC97_POWER_CONTROL,
+		ac97_codec_read(codec, AC97_POWER_CONTROL)|0x8000);
 	return 0;
 }
 
@@ -862,24 +891,28 @@
 {
 	printk(KERN_INFO "ac97_codec: PT101 Codec detected, initializing but _not_ installing mixer device.\n");
 	/* who knows.. */
-	codec->codec_write(codec, 0x2A, 0x0001);
-	codec->codec_write(codec, 0x2C, 0x0000);
-	codec->codec_write(codec, 0x2C, 0xFFFF);
-	codec->codec_write(codec, 0x10, 0x9F1F);
-	codec->codec_write(codec, 0x12, 0x0808);
-	codec->codec_write(codec, 0x14, 0x9F1F);
-	codec->codec_write(codec, 0x16, 0x9F1F);
-	codec->codec_write(codec, 0x18, 0x0404);
-	codec->codec_write(codec, 0x1A, 0x0000);
-	codec->codec_write(codec, 0x1C, 0x0000);
-	codec->codec_write(codec, 0x02, 0x0404);
-	codec->codec_write(codec, 0x04, 0x0808);
-	codec->codec_write(codec, 0x0C, 0x801F);
-	codec->codec_write(codec, 0x0E, 0x801F);
+	ac97_codec_write(codec, 0x2A, 0x0001);
+	ac97_codec_write(codec, 0x2C, 0x0000);
+	ac97_codec_write(codec, 0x2C, 0xFFFF);
+	ac97_codec_write(codec, 0x10, 0x9F1F);
+	ac97_codec_write(codec, 0x12, 0x0808);
+	ac97_codec_write(codec, 0x14, 0x9F1F);
+	ac97_codec_write(codec, 0x16, 0x9F1F);
+	ac97_codec_write(codec, 0x18, 0x0404);
+	ac97_codec_write(codec, 0x1A, 0x0000);
+	ac97_codec_write(codec, 0x1C, 0x0000);
+	ac97_codec_write(codec, 0x02, 0x0404);
+	ac97_codec_write(codec, 0x04, 0x0808);
+	ac97_codec_write(codec, 0x0C, 0x801F);
+	ac97_codec_write(codec, 0x0E, 0x801F);
 	return 0;
 }
 #endif
-	
+
 
 EXPORT_SYMBOL(ac97_read_proc);
 EXPORT_SYMBOL(ac97_probe_codec);
+EXPORT_SYMBOL(ac97_read_mixer);
+EXPORT_SYMBOL(ac97_write_mixer);
+EXPORT_SYMBOL(ac97_codec_read);
+EXPORT_SYMBOL(ac97_codec_write);
diff -urN linux-2.4.4/drivers/sound/nm256.h linux-nm-ac97/drivers/sound/nm256.h
--- linux-2.4.4/drivers/sound/nm256.h	Mon Dec 11 16:02:32 2000
+++ linux-nm-ac97/drivers/sound/nm256.h	Thu May  3 15:30:10 2001
@@ -1,7 +1,6 @@
 #ifndef _NM256_H_
 #define _NM256_H_
 
-#include "ac97.h"
 
 /* The revisions that we currently handle.  */
 enum nm256rev {
@@ -18,7 +17,7 @@
     /* Revision number */
     enum nm256rev rev;
 
-    struct ac97_hwint mdev;
+    struct ac97_codec ac97;
 
     /* Our audio device numbers. */
     int dev[2];
@@ -32,9 +31,6 @@
        these are the actual device numbers. */
     int dev_for_play;
     int dev_for_record;
-
-    /* The mixer device. */
-    int mixer_oss_dev;
 
     /* 
      * Can only be opened once for each operation.  These aren't set
diff -urN linux-2.4.4/drivers/sound/nm256_audio.c linux-nm-ac97/drivers/sound/nm256_audio.c
--- linux-2.4.4/drivers/sound/nm256_audio.c	Sat Nov 11 21:33:14 2000
+++ linux-nm-ac97/drivers/sound/nm256_audio.c	Thu May  3 15:31:47 2001
@@ -15,6 +15,8 @@
  * Changes:
  * 11-10-2000	Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *		Added some __init
+ * 19-04-2001	Marcus Meissner <mm@caldera.de>
+ *		Ported to 2.4 PCI API.
  */
 
 #define __NO_VERSION__
@@ -23,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/soundcard.h>
+#include <linux/ac97_codec.h>
 #include "sound_config.h"
 #include "nm256.h"
 #include "nm256_coeff.h"
@@ -49,8 +53,6 @@
 #define PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO 0x8005
 #define PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO 0x8006
 
-#define RSRCADDRESS(dev,num) ((dev)->resource[(num)].start)
-
 /* List of cards.  */
 static struct nm256_info *nmcard_list;
 
@@ -125,7 +127,7 @@
     struct nm256_info *card;
 
     for (card = nmcard_list; card != NULL; card = card->next_card)
-	if (card->mixer_oss_dev == dev)
+	if (card->ac97.dev_mixer == dev)
 	    return card;
 
     return NULL;
@@ -753,9 +755,9 @@
  */
 
 static int
-nm256_isReady (struct ac97_hwint *dev)
+nm256_isReady (struct ac97_codec *ac97)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
     int t2 = 10;
     u32 testaddr;
     u16 testb;
@@ -783,48 +785,46 @@
 
 /*
  * Return the contents of the AC97 mixer register REG.  Returns a positive
- * value if successful, or a negative error code.
+ * value if successful, or zero.
  */
-static int
-nm256_readAC97Reg (struct ac97_hwint *dev, u8 reg)
+static u16
+nm256_readAC97Reg (struct ac97_codec *ac97, u8 reg)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
 
     if (card->magsig != NM_MAGIC_SIG) {
 	printk (KERN_ERR "NM256: Bad magic signature in readAC97Reg!\n");
-	return -EINVAL;
+	return 0;
     }
 
     if (reg < 128) {
 	int res;
 
-	nm256_isReady (dev);
+	nm256_isReady (ac97);
 	res = nm256_readPort16 (card, 2, card->mixer + reg);
 	/* Magic delay.  Bleah yucky.  */
         udelay (1000);
 	return res;
     }
-    else
-	return -EINVAL;
+    return 0;
 }
 
 /* 
  * Writes VALUE to AC97 mixer register REG.  Returns 0 if successful, or
  * a negative error code. 
  */
-static int
-nm256_writeAC97Reg (struct ac97_hwint *dev, u8 reg, u16 value)
+static void
+nm256_writeAC97Reg (struct ac97_codec *ac97, u8 reg, u16 value)
 {
     unsigned long flags;
     int tries = 2;
     int done = 0;
     u32 base;
-
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
 
     if (card->magsig != NM_MAGIC_SIG) {
 	printk (KERN_ERR "NM256: Bad magic signature in writeAC97Reg!\n");
-	return -EINVAL;
+	return;
     }
 
     base = card->mixer;
@@ -832,12 +832,12 @@
     save_flags (flags);
     cli ();
 
-    nm256_isReady (dev);
+    nm256_isReady (ac97);
 
     /* Wait for the write to take, too. */
     while ((tries-- > 0) && !done) {
 	nm256_writePort16 (card, 2, base + reg, value);
-	if (nm256_isReady (dev)) {
+	if (nm256_isReady (ac97)) {
 	    done = 1;
 	    break;
 	}
@@ -846,8 +846,6 @@
 
     restore_flags (flags);
     udelay (1000);
-
-    return ! done;
 }
 
 /* 
@@ -884,9 +882,9 @@
 
 /* Initialize the AC97 into a known state.  */
 static int
-nm256_resetAC97 (struct ac97_hwint *dev)
+nm256_resetAC97 (struct ac97_codec *ac97)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
     int x;
 
     if (card->magsig != NM_MAGIC_SIG) {
@@ -902,9 +900,8 @@
 
     if (! card->mixer_values_init) {
 	for (x = 0; nm256_ac97_initial_values[x].port != 0xffff; x++) {
-	    ac97_put_register (dev,
-			       nm256_ac97_initial_values[x].port,
-			       nm256_ac97_initial_values[x].value);
+	    ac97_codec_write (ac97, nm256_ac97_initial_values[x].port,
+			      nm256_ac97_initial_values[x].value);
 	    card->mixer_values_init = 1;
 	}
     }
@@ -912,41 +909,50 @@
     return 0;
 }
 
-/*
- * We don't do anything particularly special here; it just passes the
- * mixer ioctl to the AC97 driver.
- */
-static int
-nm256_default_mixer_ioctl (int dev, unsigned int cmd, caddr_t arg)
+static int nm256_mixer_open (struct inode *inode, struct file *file)
 {
-    struct nm256_info *card = nm256_find_card_for_mixer (dev);
-    if (card != NULL)
-	return ac97_mixer_ioctl (&(card->mdev), cmd, arg);
-    else
+	int minor = MINOR(inode->i_rdev);
+	struct nm256_info *card;
+	
+	MOD_INC_USE_COUNT;
+
+	card = nm256_find_card_for_mixer (minor);
+	if (card)
+		goto match;
+
+	MOD_DEC_USE_COUNT;
 	return -ENODEV;
+
+match:
+	file->private_data = &card->ac97;
+	return 0;
 }
 
-static struct mixer_operations nm256_mixer_operations = {
-    owner:	THIS_MODULE,
-    id:		"NeoMagic",
-    name:	"NM256AC97Mixer",
-    ioctl:	nm256_default_mixer_ioctl
-};
+static int nm256_mixer_release (struct inode *inode, struct file *file)
+{
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
 
-/*
- * Default settings for the OSS mixer.  These are set last, after the
- * mixer is initialized.
- *
- * I "love" C sometimes.  Got braces?
- */
-static struct ac97_mixer_value_list mixer_defaults[] = {
-    { SOUND_MIXER_VOLUME,  { { 85, 85 } } },
-    { SOUND_MIXER_SPEAKER, { { 100 } } },
-    { SOUND_MIXER_PCM,     { { 65, 65 } } },
-    { SOUND_MIXER_CD,      { { 65, 65 } } },
-    { -1,                  {  { 0,  0 } } }
-};
+static int nm256_mixer_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct ac97_codec *codec = file->private_data;
+
+	return codec->mixer_ioctl(codec, cmd, arg);
+}
+
+static loff_t nm256_llseek(struct file *file, loff_t offset, int origin)
+{
+	return -ESPIPE;
+}
 
+static struct file_operations nm256_mixer_fops = {
+	open:		nm256_mixer_open,
+	release:	nm256_mixer_release,
+	llseek:		nm256_llseek,
+	ioctl:		nm256_mixer_ioctl,
+};
 
 /* Installs the AC97 mixer into CARD.  */
 static int __init
@@ -954,28 +960,36 @@
 {
     int mixer;
 
-    card->mdev.reset_device = nm256_resetAC97;
-    card->mdev.read_reg = nm256_readAC97Reg;
-    card->mdev.write_reg = nm256_writeAC97Reg;
-    card->mdev.driver_private = (void *)card;
-
-    if (ac97_init (&(card->mdev)))
-	return -1;
-
-    mixer = sound_alloc_mixerdev();
-    if (num_mixers >= MAX_MIXER_DEV) {
-	printk ("NM256 mixer: Unable to alloc mixerdev\n");
-	return -1;
+    memset (&card->ac97, 0, sizeof (card->ac97));
+    card->ac97.private_data = (void *)card;
+    card->ac97.codec_read = nm256_readAC97Reg;
+    card->ac97.codec_write = nm256_writeAC97Reg;
+    
+    mixer = register_sound_mixer (&nm256_mixer_fops, -1);
+    if (mixer < 0) {
+	printk (KERN_ERR "NM256 mixer: Unable to alloc mixerdev\n");
+	goto err_out;
+    }
+    
+    card->ac97.dev_mixer = mixer;
+    
+    if (nm256_resetAC97 (&card->ac97)) {
+	printk (KERN_ERR "NM256 mixer: Unable to reset AC97 codec\n");
+    	goto err_out_mixer;
+    }
+
+    if (!ac97_probe_codec(&card->ac97)) {
+	printk (KERN_ERR "NM256 mixer: Unable to probe AC97 codec\n");
+	goto err_out_mixer;
     }
 
-    mixer_devs[mixer] = &nm256_mixer_operations;
-    card->mixer_oss_dev = mixer;
-
-    /* Some reasonable default values.  */
-    ac97_set_values (&(card->mdev), mixer_defaults);
-
     printk(KERN_INFO "Initialized AC97 mixer\n");
     return 0;
+
+err_out_mixer:
+    unregister_sound_mixer (mixer);
+err_out:
+    return -1;
 }
 
 /* Perform a full reset on the hardware; this is invoked when an APM
@@ -984,7 +998,10 @@
 nm256_full_reset (struct nm256_info *card)
 {
     nm256_initHw (card);
-    ac97_reset (&(card->mdev));
+    
+    /* note! this depends on ac97_probe_codec not allocating
+     * or registering anything... */
+    ac97_probe_codec (&card->ac97);
 }
 
 /* 
@@ -1042,6 +1059,9 @@
     struct pm_dev *pmdev;
     int x;
 
+    if (pci_enable_device(pcidev))
+	    return 0;
+
     card = kmalloc (sizeof (struct nm256_info), GFP_KERNEL);
     if (card == NULL) {
 	printk (KERN_ERR "NM256: out of memory!\n");
@@ -1055,7 +1075,7 @@
 
     /* Init the memory port info.  */
     for (x = 0; x < 2; x++) {
-	card->port[x].physaddr = RSRCADDRESS (pcidev, x);
+	card->port[x].physaddr = pci_resource_start (pcidev, x);
 	card->port[x].ptr = NULL;
 	card->port[x].start_offset = 0;
 	card->port[x].end_offset = 0;
@@ -1201,6 +1221,8 @@
 	}
     }
 
+    pci_set_drvdata(pcidev,card);
+
     /* Insert the card in the list.  */
     card->next_card = nmcard_list;
     nmcard_list = card;
@@ -1212,7 +1234,7 @@
      * And our mixer.  (We should allow support for other mixers, maybe.)
      */
 
-    nm256_install_mixer (card);
+    nm256_install_mixer (card); /* XXX check return value */
 
     pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), handle_pm_event);
     if (pmdev)
@@ -1251,37 +1273,38 @@
     return 0;
 }
 
-/*
- * 	This loop walks the PCI configuration database and finds where
- *	the sound cards are.
- */
- 
-int __init
-init_nm256(void)
+static int __devinit
+nm256_probe(struct pci_dev *pcidev,const struct pci_device_id *pciid)
 {
-    struct pci_dev *pcidev = NULL;
-    int count = 0;
-
-    if(! pci_present())
-	return -ENODEV;
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256AV, "256AV");
-    }
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO)
+	return nm256_install(pcidev, REV_NM256AV, "256AV");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO)
+	return nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    return -1; /* should not come here ... */
+}
+
+static void __devinit
+nm256_remove(struct pci_dev *pcidev) {
+    struct nm256_info *xcard = pci_get_drvdata(pcidev);
+    struct nm256_info *card,*next_card = NULL;
+
+    for (card = nmcard_list; card != NULL; card = next_card) {
+	next_card = card->next_card;
+	if (card == xcard) {
+	    stopPlay (card);
+	    stopRecord (card);
+	    if (card->has_irq)
+		free_irq (card->irq, card);
+	    nm256_release_ports (card);
+	    unregister_sound_mixer (card->ac97.dev_mixer);
+	    sound_unload_audiodev (card->dev[0]);
+	    sound_unload_audiodev (card->dev[1]);
+	    kfree (card);
+	    break;
+	}
     }
-
-    if (count == 0)
-	return -ENODEV;
-
-    printk (KERN_INFO "Done installing NM256 audio driver.\n");
-    return 0;
+    if (nmcard_list == card)
+    	nmcard_list = next_card;
 }
 
 /*
@@ -1639,9 +1662,21 @@
     local_qlen:		nm256_audio_local_qlen,
 };
 
-EXPORT_SYMBOL(init_nm256);
+static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, nm256_pci_tbl);
 
-static int loaded = 0;
+struct pci_driver nm256_pci_driver = {
+	name:"nm256_audio",
+	id_table:nm256_pci_tbl,
+	probe:nm256_probe,
+	remove:nm256_remove,
+};
 
 MODULE_PARM (usecache, "i");
 MODULE_PARM (buffertop, "i");
@@ -1650,37 +1685,13 @@
 
 static int __init do_init_nm256(void)
 {
-    nmcard_list = NULL;
-    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1\n");
-
-    if (init_nm256 () == 0) {
-	loaded = 1;
-	return 0;
-    }
-    else
-	return -ENODEV;
+    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1p\n");
+    return pci_module_init(&nm256_pci_driver);
 }
 
 static void __exit cleanup_nm256 (void)
 {
-    if (loaded) {
-	struct nm256_info *card;
-	struct nm256_info *next_card;
-
-	for (card = nmcard_list; card != NULL; card = next_card) {
-	    stopPlay (card);
-	    stopRecord (card);
-	    if (card->has_irq)
-		free_irq (card->irq, card);
-	    nm256_release_ports (card);
-	    sound_unload_mixerdev (card->mixer_oss_dev);
-	    sound_unload_audiodev (card->dev[0]);
-	    sound_unload_audiodev (card->dev[1]);
-	    next_card = card->next_card;
-	    kfree (card);
-	}
-	nmcard_list = NULL;
-    }
+    pci_unregister_driver(&nm256_pci_driver);
     pm_unregister_all (&handle_pm_event);
 }
 
diff -urN linux-2.4.4/include/linux/ac97_codec.h linux-nm-ac97/include/linux/ac97_codec.h
--- linux-2.4.4/include/linux/ac97_codec.h	Fri Apr 27 18:49:28 2001
+++ linux-nm-ac97/include/linux/ac97_codec.h	Thu May  3 15:30:13 2001
@@ -1,9 +1,6 @@
 #ifndef _AC97_CODEC_H_
 #define _AC97_CODEC_H_
 
-#include <linux/types.h>
-#include <linux/soundcard.h>
-
 /* AC97 1.0 */
 #define  AC97_RESET               0x0000      //
 #define  AC97_MASTER_VOL_STEREO   0x0002      // Line Out
@@ -133,24 +130,20 @@
 	SOUND_MASK_LINE1| SOUND_MASK_LINE|\
 	SOUND_MASK_PHONEIN)
 
-/* original check is not good enough in case FOO is greater than
- * SOUND_MIXER_NRDEVICES because the supported_mixers has exactly
- * SOUND_MIXER_NRDEVICES elements.
- * before matching the given mixer against the bitmask in supported_mixers we
- * check if mixer number exceeds maximum allowed size which is as mentioned
- * above SOUND_MIXER_NRDEVICES */
-#define supported_mixer(CODEC,FOO) ((FOO >= 0) && \
-                                    (FOO < SOUND_MIXER_NRDEVICES) && \
-                                    (CODEC)->supported_mixers & (1<<FOO) )
+struct ac97_mixer_entry {
+	unsigned int bits : 4;		/* bit resolution of mixer register */
+	unsigned int mixer_state;	/* saved OSS mixer state */
+};
 
 struct ac97_codec {
 	/* AC97 controller connected with */
 	void *private_data;
 
-	char *name;
-	int id;
-	int dev_mixer; 
-	int type;
+	const char *name;	/* codec vendor+device name */
+	int id;			/* codec id, 0==primary, 1==secondary, etc. */
+	int dev_mixer; 		/* Mixer device minor, from register_sound_mixer() */
+	u32 type;		/* AC97 codec vendor+device id */
+	int idx;		/* index into ac97_codec_id[] array */
 
 	/* codec specific init/reset routines, used mainly for 4 or 6 channel support */
 	int  (*codec_init)  (struct ac97_codec *codec);
@@ -164,28 +157,37 @@
 
 	/* OSS mixer masks */
 	int modcnt;
-	int supported_mixers;
-	int stereo_mixers;
-	int record_sources;
-
-	int bit_resolution;
+	u32 supported_mixers;
+	u32 stereo_mixers;
+	u32 record_sources;
 
 	/* OSS mixer interface */
-	int  (*read_mixer) (struct ac97_codec *codec, int oss_channel);
-	void (*write_mixer)(struct ac97_codec *codec, int oss_channel,
-			    unsigned int left, unsigned int right);
 	int  (*recmask_io) (struct ac97_codec *codec, int rw, int mask);
 	int  (*mixer_ioctl)(struct ac97_codec *codec, unsigned int cmd, unsigned long arg);
 
 	/* saved OSS mixer states */
-	unsigned int mixer_state[SOUND_MIXER_NRDEVICES];
-
-	/* Software Modem interface */
-	int  (*modem_ioctl)(struct ac97_codec *codec, unsigned int cmd, unsigned long arg);
+	struct ac97_mixer_entry mixer[SOUND_MIXER_NRDEVICES];
 };
 
+static inline int supported_mixer (struct ac97_codec *codec, int mixer)
+{
+	if (!codec)
+		return 0;
+	if (mixer < 0 || mixer >= SOUND_MIXER_NRDEVICES)
+		return 0;
+	return codec->supported_mixers & (1 << mixer);
+}
+
 extern int ac97_read_proc (char *page_out, char **start, off_t off,
 			   int count, int *eof, void *data);
-extern int ac97_probe_codec(struct ac97_codec *);
+extern int ac97_probe_codec(struct ac97_codec *codec);
+
+extern int ac97_read_mixer(struct ac97_codec *codec, int oss_channel);
+extern void ac97_write_mixer(struct ac97_codec *codec, int oss_channel,
+			     unsigned int left, unsigned int right);
+
+extern u16 ac97_codec_read (struct ac97_codec *codec, u8 reg);
+extern void ac97_codec_write (struct ac97_codec *codec, u8 reg, u16 val);
+
 
 #endif /* _AC97_CODEC_H_ */

--------------DBA96DE5AC889F7DC78B7920--

