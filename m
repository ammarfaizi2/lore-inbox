Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSI2Sal>; Sun, 29 Sep 2002 14:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbSI2Sak>; Sun, 29 Sep 2002 14:30:40 -0400
Received: from gate.perex.cz ([194.212.165.105]:9488 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261733AbSI2SaC>;
	Sun, 29 Sep 2002 14:30:02 -0400
Date: Sun, 29 Sep 2002 20:34:52 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [5/10] - 2002/07/17
Message-ID: <Pine.LNX.4.33.0209292034300.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.16, 2002-09-25 17:10:33+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/07/17:
    - AD1816A - fixed MIC playback volume
    - OPL3SA2 - fixed non-ISA PnP build
    - AC'97 code - 1st version of separated codec specific code


 include/sound/version.h         |    2 
 sound/core/ioctl32/ioctl32.c    |    1 
 sound/isa/ad1816a/ad1816a_lib.c |    2 
 sound/isa/opl3sa2.c             |    2 
 sound/pci/ac97/Makefile         |    2 
 sound/pci/ac97/ac97_codec.c     |  316 ----------------------------------------
 sound/pci/ac97/ac97_id.h        |   44 +++++
 sound/pci/ac97/ac97_patch.c     |  310 +++++++++++++++++++++++++++++++++++++++
 sound/pci/ac97/ac97_patch.h     |   38 ++++
 9 files changed, 401 insertions(+), 316 deletions(-)


diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:21:04 2002
+++ b/include/sound/version.h	Sun Sep 29 20:21:04 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Sun Jul 14 21:30:57 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Jul 17 10:56:41 2002 UTC)"
diff -Nru a/sound/core/ioctl32/ioctl32.c b/sound/core/ioctl32/ioctl32.c
--- a/sound/core/ioctl32/ioctl32.c	Sun Sep 29 20:21:04 2002
+++ b/sound/core/ioctl32/ioctl32.c	Sun Sep 29 20:21:04 2002
@@ -20,6 +20,7 @@
 
 #define __NO_VERSION__
 #include <sound/driver.h>
+#include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/time.h>
diff -Nru a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
--- a/sound/isa/ad1816a/ad1816a_lib.c	Sun Sep 29 20:21:04 2002
+++ b/sound/isa/ad1816a/ad1816a_lib.c	Sun Sep 29 20:21:04 2002
@@ -908,7 +908,7 @@
 AD1816A_DOUBLE("FM Playback Switch", AD1816A_FM_ATT, 15, 7, 1, 1),
 AD1816A_DOUBLE("FM Playback Volume", AD1816A_FM_ATT, 8, 0, 63, 1),
 AD1816A_SINGLE("Mic Playback Switch", AD1816A_MIC_GAIN_ATT, 15, 1, 1),
-AD1816A_SINGLE("Mic Playback Volume", AD1816A_MIC_GAIN_ATT, 8, 63, 1),
+AD1816A_SINGLE("Mic Playback Volume", AD1816A_MIC_GAIN_ATT, 8, 31, 1),
 AD1816A_SINGLE("Mic Boost", AD1816A_MIC_GAIN_ATT, 14, 1, 0),
 AD1816A_DOUBLE("Video Playback Switch", AD1816A_VID_GAIN_ATT, 15, 7, 1, 1),
 AD1816A_DOUBLE("Video Playback Volume", AD1816A_VID_GAIN_ATT, 8, 0, 31, 1),
diff -Nru a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c	Sun Sep 29 20:21:04 2002
+++ b/sound/isa/opl3sa2.c	Sun Sep 29 20:21:04 2002
@@ -71,9 +71,11 @@
 MODULE_PARM(snd_enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_enable, "Enable OPL3-SA soundcard.");
 MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
+#ifdef __ISAPNP__
 MODULE_PARM(snd_isapnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_isapnp, "ISA PnP detection for specified soundcard.");
 MODULE_PARM_SYNTAX(snd_isapnp, SNDRV_ISAPNP_DESC);
+#endif
 MODULE_PARM(snd_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
 MODULE_PARM_DESC(snd_port, "Port # for OPL3-SA driver.");
 MODULE_PARM_SYNTAX(snd_port, SNDRV_ENABLED ",allows:{{0xf86},{0x370},{0x100}},dialog:list");
diff -Nru a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
--- a/sound/pci/ac97/Makefile	Sun Sep 29 20:21:04 2002
+++ b/sound/pci/ac97/Makefile	Sun Sep 29 20:21:04 2002
@@ -5,7 +5,7 @@
 
 export-objs  := ac97_codec.o ak4531_codec.o
 
-snd-ac97-codec-objs := ac97_codec.o
+snd-ac97-codec-objs := ac97_codec.o ac97_patch.o
 snd-ak4531-codec-objs := ak4531_codec.o
 
 # Toplevel Module Dependency
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:21:04 2002
+++ b/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:21:04 2002
@@ -31,6 +31,8 @@
 #include <sound/ac97_codec.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
+#include "ac97_id.h"
+#include "ac97_patch.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Universal interface for Audio Codec '97");
@@ -51,21 +53,6 @@
 static void snd_ac97_proc_init(snd_card_t * card, ac97_t * ac97);
 static void snd_ac97_proc_done(ac97_t * ac97);
 
-static int patch_wolfson00(ac97_t * ac97);
-static int patch_wolfson03(ac97_t * ac97);
-static int patch_wolfson04(ac97_t * ac97);
-static int patch_tritech_tr28028(ac97_t * ac97);
-static int patch_sigmatel_stac9708(ac97_t * ac97);
-static int patch_sigmatel_stac9721(ac97_t * ac97);
-static int patch_sigmatel_stac9744(ac97_t * ac97);
-static int patch_sigmatel_stac9756(ac97_t * ac97);
-static int patch_cirrus_cs4299(ac97_t * ac97);
-static int patch_cirrus_spdif(ac97_t * ac97);
-static int patch_conexant(ac97_t * ac97);
-static int patch_ad1819(ac97_t * ac97);
-static int patch_ad1881(ac97_t * ac97);
-static int patch_ad1886(ac97_t * ac97);
-
 typedef struct {
 	unsigned int id;
 	unsigned int mask;
@@ -107,6 +94,7 @@
 { 0x41445360, 0xffffffff, "AD1885",		patch_ad1881 },
 { 0x41445361, 0xffffffff, "AD1886",		patch_ad1886 },
 { 0x41445362, 0xffffffff, "AD1887",		patch_ad1881 },
+{ 0x41445372, 0xffffffff, "AD1981A",		NULL },
 { 0x414c4300, 0xfffffff0, "RL5306",	 	NULL },
 { 0x414c4310, 0xfffffff0, "RL5382", 		NULL },
 { 0x414c4320, 0xfffffff0, "RL5383", 		NULL },
@@ -151,27 +139,6 @@
 { 0, 	      0,	  NULL,			NULL }
 };
 
-#define AC97_ID_AK4540		0x414b4d00
-#define AC97_ID_AK4542		0x414b4d01
-#define AC97_ID_AD1819		0x41445303
-#define AC97_ID_AD1881		0x41445340
-#define AC97_ID_AD1881A		0x41445348
-#define AC97_ID_AD1885		0x41445360
-#define AC97_ID_AD1886		0x41445361
-#define AC97_ID_AD1887		0x41445362
-#define AC97_ID_TR28028		0x54524108
-#define AC97_ID_STAC9700	0x83847600
-#define AC97_ID_STAC9704	0x83847604
-#define AC97_ID_STAC9705	0x83847605
-#define AC97_ID_STAC9708	0x83847608
-#define AC97_ID_STAC9721	0x83847609
-#define AC97_ID_STAC9744	0x83847644
-#define AC97_ID_STAC9756	0x83847656
-#define AC97_ID_CS4297A		0x43525910
-#define AC97_ID_CS4299		0x43525930
-#define AC97_ID_CS4201		0x43525948
-#define AC97_ID_CS4205		0x43525958
-
 static const char *snd_ac97_stereo_enhancements[] =
 {
   /*   0 */ "No 3D Stereo Enhancement",
@@ -1848,283 +1815,6 @@
 		snd_info_unregister(ac97->proc_entry);
 		ac97->proc_entry = NULL;
 	}
-}
-
-/*
- *  Chip specific initialization
- */
-
-static int patch_wolfson00(ac97_t * ac97)
-{
-	/* This sequence is suspect because it was designed for
-	   the WM9704, and is known to fail when applied to the
-	   WM9707.  If you're having trouble initializing a
-	   WM9700, this is the place to start looking.
-	   Randolph Bentson <bentson@holmsjoen.com> */
-
-	// WM9701A
-	snd_ac97_write_cache(ac97, 0x72, 0x0808);
-	snd_ac97_write_cache(ac97, 0x74, 0x0808);
-
-	// patch for DVD noise
-	snd_ac97_write_cache(ac97, 0x5a, 0x0200);
-
-	// init vol
-	snd_ac97_write_cache(ac97, 0x70, 0x0808);
-
-	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
-	return 0;
-}
-
-static int patch_wolfson03(ac97_t * ac97)
-{
-	/* This is known to work for the ViewSonic ViewPad 1000
-	   Randolph Bentson <bentson@holmsjoen.com> */
-
-	// WM9703/9707
-	snd_ac97_write_cache(ac97, 0x72, 0x0808);
-	snd_ac97_write_cache(ac97, 0x20, 0x8000);
-	return 0;
-}
-
-static int patch_wolfson04(ac97_t * ac97)
-{
-	// WM9704
-	snd_ac97_write_cache(ac97, 0x72, 0x0808);
-	snd_ac97_write_cache(ac97, 0x74, 0x0808);
-
-	// patch for DVD noise
-	snd_ac97_write_cache(ac97, 0x5a, 0x0200);
-
-	// init vol
-	snd_ac97_write_cache(ac97, 0x70, 0x0808);
-
-	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
-	return 0;
-}
-
-static int patch_tritech_tr28028(ac97_t * ac97)
-{
-	snd_ac97_write_cache(ac97, 0x26, 0x0300);
-	snd_ac97_write_cache(ac97, 0x26, 0x0000);
-	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
-	snd_ac97_write_cache(ac97, AC97_SPDIF, 0x0000);
-	return 0;
-}
-
-static int patch_sigmatel_stac9708(ac97_t * ac97)
-{
-	unsigned int codec72, codec6c;
-
-	codec72 = snd_ac97_read(ac97, AC97_SIGMATEL_BIAS2) & 0x8000;
-	codec6c = snd_ac97_read(ac97, AC97_SIGMATEL_ANALOG);
-
-	if ((codec72==0) && (codec6c==0)) {
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x1000);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0007);
-	} else if ((codec72==0x8000) && (codec6c==0)) {
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x1001);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_DAC2INVERT, 0x0008);
-	} else if ((codec72==0x8000) && (codec6c==0x0080)) {
-		/* nothing */
-	}
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
-	return 0;
-}
-
-static int patch_sigmatel_stac9721(ac97_t * ac97)
-{
-	if (snd_ac97_read(ac97, AC97_SIGMATEL_ANALOG) == 0) {
-		// patch for SigmaTel
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x4000);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
-		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
-	}
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
-	return 0;
-}
-
-static int patch_sigmatel_stac9744(ac97_t * ac97)
-{
-	// patch for SigmaTel
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
-	return 0;
-}
-
-static int patch_sigmatel_stac9756(ac97_t * ac97)
-{
-	// patch for SigmaTel
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
-	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
-	return 0;
-}
-
-static int patch_cirrus_spdif(ac97_t * ac97)
-{
-	/* Basically, the cs4201/cs4205/cs4297a has non-standard sp/dif registers.
-	   WHY CAN'T ANYONE FOLLOW THE BLOODY SPEC?  *sigh*
-	   - sp/dif EA ID is not set, but sp/dif is always present.
-	   - enable/disable is spdif register bit 15.
-	   - sp/dif control register is 0x68.  differs from AC97:
-	   - valid is bit 14 (vs 15)
-	   - no DRS
-	   - only 44.1/48k [00 = 48, 01=44,1] (AC97 is 00=44.1, 10=48)
-	   - sp/dif ssource select is in 0x5e bits 0,1.
-	*/
-
-	ac97->flags |= AC97_CS_SPDIF; 
-        ac97->ext_id |= AC97_EA_SPDIF;	/* force the detection of spdif */
-	snd_ac97_write_cache(ac97, AC97_CSR_ACMODE, 0x0080);
-	return 0;
-}
-
-static int patch_cirrus_cs4299(ac97_t * ac97)
-{
-	/* force the detection of PC Beep */
-	ac97->flags |= AC97_HAS_PC_BEEP;
-	
-	return patch_cirrus_spdif(ac97);
-}
-
-static int patch_conexant(ac97_t * ac97)
-{
-	ac97->flags |= AC97_CX_SPDIF;
-        ac97->ext_id |= AC97_EA_SPDIF;	/* force the detection of spdif */
-	return 0;
-}
-
-static int patch_ad1819(ac97_t * ac97)
-{
-	// patch for Analog Devices
-	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, 0x7000); /* select all codecs */
-	return 0;
-}
-
-static unsigned short patch_ad1881_unchained(ac97_t * ac97, int idx, unsigned short mask)
-{
-	unsigned short val;
-
-	// test for unchained codec
-	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, mask);
-	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);	/* ID0C, ID1C, SDIE = off */
-	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
-	if ((val & 0xff40) != 0x5340)
-		return 0;
-	ac97->spec.ad18xx.unchained[idx] = mask;
-	ac97->spec.ad18xx.id[idx] = val;
-	return mask;
-}
-
-static int patch_ad1881_chained1(ac97_t * ac97, int idx, unsigned short codec_bits)
-{
-	static int cfg_bits[3] = { 1<<12, 1<<14, 1<<13 };
-	unsigned short val;
-	
-	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, cfg_bits[idx]);
-	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);	// SDIE
-	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
-	if ((val & 0xff40) != 0x5340)
-		return 0;
-	if (codec_bits)
-		snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, codec_bits);
-	ac97->spec.ad18xx.chained[idx] = cfg_bits[idx];
-	ac97->spec.ad18xx.id[idx] = val;
-	return 1;
-}
-
-static void patch_ad1881_chained(ac97_t * ac97, int unchained_idx, int cidx1, int cidx2)
-{
-	// already detected?
-	if (ac97->spec.ad18xx.unchained[cidx1] || ac97->spec.ad18xx.chained[cidx1])
-		cidx1 = -1;
-	if (ac97->spec.ad18xx.unchained[cidx2] || ac97->spec.ad18xx.chained[cidx2])
-		cidx2 = -1;
-	if (cidx1 < 0 && cidx2 < 0)
-		return;
-	// test for chained codecs
-	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, ac97->spec.ad18xx.unchained[unchained_idx]);
-	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0002);		// ID1C
-	if (cidx1 >= 0) {
-		if (patch_ad1881_chained1(ac97, cidx1, 0x0006))		// SDIE | ID1C
-			patch_ad1881_chained1(ac97, cidx2, 0);
-		else if (patch_ad1881_chained1(ac97, cidx2, 0x0006))	// SDIE | ID1C
-			patch_ad1881_chained1(ac97, cidx1, 0);
-	} else if (cidx2 >= 0) {
-		patch_ad1881_chained1(ac97, cidx2, 0);
-	}
-}
-
-static int patch_ad1881(ac97_t * ac97)
-{
-	static const char cfg_idxs[3][2] = {
-		{2, 1},
-		{0, 2},
-		{0, 1}
-	};
-	
-	// patch for Analog Devices
-	unsigned short codecs[3];
-	int idx, num;
-
-	init_MUTEX(&ac97->spec.ad18xx.mutex);
-
-	codecs[0] = patch_ad1881_unchained(ac97, 0, (1<<12));
-	codecs[1] = patch_ad1881_unchained(ac97, 1, (1<<14));
-	codecs[2] = patch_ad1881_unchained(ac97, 2, (1<<13));
-
-	snd_runtime_check(codecs[0] | codecs[1] | codecs[2], goto __end);
-
-	for (idx = 0; idx < 3; idx++)
-		if (ac97->spec.ad18xx.unchained[idx])
-			patch_ad1881_chained(ac97, idx, cfg_idxs[idx][0], cfg_idxs[idx][1]);
-
-	if (ac97->spec.ad18xx.id[1]) {
-		ac97->flags |= AC97_AD_MULTI;
-		ac97->scaps |= AC97_SCAP_SURROUND_DAC;
-	}
-	if (ac97->spec.ad18xx.id[2]) {
-		ac97->flags |= AC97_AD_MULTI;
-		ac97->scaps |= AC97_SCAP_CENTER_LFE_DAC;
-	}
-
-      __end:
-	/* select all codecs */
-	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, 0x7000);
-	/* check if only one codec is present */
-	for (idx = num = 0; idx < 3; idx++)
-		if (ac97->spec.ad18xx.id[idx])
-			num++;
-	if (num == 1) {
-		/* ok, deselect all ID bits */
-		snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);
-	}
-	/* required for AD1886/AD1885 combination */
-	ac97->ext_id = snd_ac97_read(ac97, AC97_EXTENDED_ID);
-	if (ac97->spec.ad18xx.id[0]) {
-		ac97->id &= 0xffff0000;
-		ac97->id |= ac97->spec.ad18xx.id[0];
-	}
-	return 0;
-}
-
-static int patch_ad1886(ac97_t * ac97)
-{
-	patch_ad1881(ac97);
-	/* Presario700 workaround */
-	/* for Jack Sense/SPDIF Register misetting causing */
-	snd_ac97_write_cache(ac97, AC97_AD_JACK_SPDIF, 0x0010);
-	return 0;
 }
 
 /*
diff -Nru a/sound/pci/ac97/ac97_id.h b/sound/pci/ac97/ac97_id.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/sound/pci/ac97/ac97_id.h	Sun Sep 29 20:21:04 2002
@@ -0,0 +1,44 @@
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
+ *  Universal interface for Audio Codec '97
+ *
+ *  For more details look to AC '97 component specification revision 2.2
+ *  by Intel Corporation (http://developer.intel.com).
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#define AC97_ID_AK4540		0x414b4d00
+#define AC97_ID_AK4542		0x414b4d01
+#define AC97_ID_AD1819		0x41445303
+#define AC97_ID_AD1881		0x41445340
+#define AC97_ID_AD1881A		0x41445348
+#define AC97_ID_AD1885		0x41445360
+#define AC97_ID_AD1886		0x41445361
+#define AC97_ID_AD1887		0x41445362
+#define AC97_ID_TR28028		0x54524108
+#define AC97_ID_STAC9700	0x83847600
+#define AC97_ID_STAC9704	0x83847604
+#define AC97_ID_STAC9705	0x83847605
+#define AC97_ID_STAC9708	0x83847608
+#define AC97_ID_STAC9721	0x83847609
+#define AC97_ID_STAC9744	0x83847644
+#define AC97_ID_STAC9756	0x83847656
+#define AC97_ID_CS4297A		0x43525910
+#define AC97_ID_CS4299		0x43525930
+#define AC97_ID_CS4201		0x43525948
+#define AC97_ID_CS4205		0x43525958
diff -Nru a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/sound/pci/ac97/ac97_patch.c	Sun Sep 29 20:21:04 2002
@@ -0,0 +1,310 @@
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
+ *  Universal interface for Audio Codec '97
+ *
+ *  For more details look to AC '97 component specification revision 2.2
+ *  by Intel Corporation (http://developer.intel.com).
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/asoundef.h>
+#include <sound/initval.h>
+
+/*
+ *  Chip specific initialization
+ */
+
+int patch_wolfson00(ac97_t * ac97)
+{
+	/* This sequence is suspect because it was designed for
+	   the WM9704, and is known to fail when applied to the
+	   WM9707.  If you're having trouble initializing a
+	   WM9700, this is the place to start looking.
+	   Randolph Bentson <bentson@holmsjoen.com> */
+
+	// WM9701A
+	snd_ac97_write_cache(ac97, 0x72, 0x0808);
+	snd_ac97_write_cache(ac97, 0x74, 0x0808);
+
+	// patch for DVD noise
+	snd_ac97_write_cache(ac97, 0x5a, 0x0200);
+
+	// init vol
+	snd_ac97_write_cache(ac97, 0x70, 0x0808);
+
+	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
+	return 0;
+}
+
+int patch_wolfson03(ac97_t * ac97)
+{
+	/* This is known to work for the ViewSonic ViewPad 1000
+	   Randolph Bentson <bentson@holmsjoen.com> */
+
+	// WM9703/9707
+	snd_ac97_write_cache(ac97, 0x72, 0x0808);
+	snd_ac97_write_cache(ac97, 0x20, 0x8000);
+	return 0;
+}
+
+int patch_wolfson04(ac97_t * ac97)
+{
+	// WM9704
+	snd_ac97_write_cache(ac97, 0x72, 0x0808);
+	snd_ac97_write_cache(ac97, 0x74, 0x0808);
+
+	// patch for DVD noise
+	snd_ac97_write_cache(ac97, 0x5a, 0x0200);
+
+	// init vol
+	snd_ac97_write_cache(ac97, 0x70, 0x0808);
+
+	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
+	return 0;
+}
+
+int patch_tritech_tr28028(ac97_t * ac97)
+{
+	snd_ac97_write_cache(ac97, 0x26, 0x0300);
+	snd_ac97_write_cache(ac97, 0x26, 0x0000);
+	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
+	snd_ac97_write_cache(ac97, AC97_SPDIF, 0x0000);
+	return 0;
+}
+
+int patch_sigmatel_stac9708(ac97_t * ac97)
+{
+	unsigned int codec72, codec6c;
+
+	codec72 = snd_ac97_read(ac97, AC97_SIGMATEL_BIAS2) & 0x8000;
+	codec6c = snd_ac97_read(ac97, AC97_SIGMATEL_ANALOG);
+
+	if ((codec72==0) && (codec6c==0)) {
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x1000);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0007);
+	} else if ((codec72==0x8000) && (codec6c==0)) {
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x1001);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_DAC2INVERT, 0x0008);
+	} else if ((codec72==0x8000) && (codec6c==0x0080)) {
+		/* nothing */
+	}
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+int patch_sigmatel_stac9721(ac97_t * ac97)
+{
+	if (snd_ac97_read(ac97, AC97_SIGMATEL_ANALOG) == 0) {
+		// patch for SigmaTel
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x4000);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
+		snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
+	}
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+int patch_sigmatel_stac9744(ac97_t * ac97)
+{
+	// patch for SigmaTel
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+int patch_sigmatel_stac9756(ac97_t * ac97)
+{
+	// patch for SigmaTel
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC1, 0xabba);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_CIC2, 0x0000);	/* is this correct? --jk */
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS1, 0xabba);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_BIAS2, 0x0002);
+	snd_ac97_write_cache(ac97, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+int patch_cirrus_spdif(ac97_t * ac97)
+{
+	/* Basically, the cs4201/cs4205/cs4297a has non-standard sp/dif registers.
+	   WHY CAN'T ANYONE FOLLOW THE BLOODY SPEC?  *sigh*
+	   - sp/dif EA ID is not set, but sp/dif is always present.
+	   - enable/disable is spdif register bit 15.
+	   - sp/dif control register is 0x68.  differs from AC97:
+	   - valid is bit 14 (vs 15)
+	   - no DRS
+	   - only 44.1/48k [00 = 48, 01=44,1] (AC97 is 00=44.1, 10=48)
+	   - sp/dif ssource select is in 0x5e bits 0,1.
+	*/
+
+	ac97->flags |= AC97_CS_SPDIF; 
+        ac97->ext_id |= AC97_EA_SPDIF;	/* force the detection of spdif */
+	snd_ac97_write_cache(ac97, AC97_CSR_ACMODE, 0x0080);
+	return 0;
+}
+
+int patch_cirrus_cs4299(ac97_t * ac97)
+{
+	/* force the detection of PC Beep */
+	ac97->flags |= AC97_HAS_PC_BEEP;
+	
+	return patch_cirrus_spdif(ac97);
+}
+
+int patch_conexant(ac97_t * ac97)
+{
+	ac97->flags |= AC97_CX_SPDIF;
+        ac97->ext_id |= AC97_EA_SPDIF;	/* force the detection of spdif */
+	return 0;
+}
+
+int patch_ad1819(ac97_t * ac97)
+{
+	// patch for Analog Devices
+	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, 0x7000); /* select all codecs */
+	return 0;
+}
+
+static unsigned short patch_ad1881_unchained(ac97_t * ac97, int idx, unsigned short mask)
+{
+	unsigned short val;
+
+	// test for unchained codec
+	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, mask);
+	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);	/* ID0C, ID1C, SDIE = off */
+	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
+	if ((val & 0xff40) != 0x5340)
+		return 0;
+	ac97->spec.ad18xx.unchained[idx] = mask;
+	ac97->spec.ad18xx.id[idx] = val;
+	return mask;
+}
+
+static int patch_ad1881_chained1(ac97_t * ac97, int idx, unsigned short codec_bits)
+{
+	static int cfg_bits[3] = { 1<<12, 1<<14, 1<<13 };
+	unsigned short val;
+	
+	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, cfg_bits[idx]);
+	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);	// SDIE
+	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
+	if ((val & 0xff40) != 0x5340)
+		return 0;
+	if (codec_bits)
+		snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, codec_bits);
+	ac97->spec.ad18xx.chained[idx] = cfg_bits[idx];
+	ac97->spec.ad18xx.id[idx] = val;
+	return 1;
+}
+
+static void patch_ad1881_chained(ac97_t * ac97, int unchained_idx, int cidx1, int cidx2)
+{
+	// already detected?
+	if (ac97->spec.ad18xx.unchained[cidx1] || ac97->spec.ad18xx.chained[cidx1])
+		cidx1 = -1;
+	if (ac97->spec.ad18xx.unchained[cidx2] || ac97->spec.ad18xx.chained[cidx2])
+		cidx2 = -1;
+	if (cidx1 < 0 && cidx2 < 0)
+		return;
+	// test for chained codecs
+	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, ac97->spec.ad18xx.unchained[unchained_idx]);
+	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0002);		// ID1C
+	if (cidx1 >= 0) {
+		if (patch_ad1881_chained1(ac97, cidx1, 0x0006))		// SDIE | ID1C
+			patch_ad1881_chained1(ac97, cidx2, 0);
+		else if (patch_ad1881_chained1(ac97, cidx2, 0x0006))	// SDIE | ID1C
+			patch_ad1881_chained1(ac97, cidx1, 0);
+	} else if (cidx2 >= 0) {
+		patch_ad1881_chained1(ac97, cidx2, 0);
+	}
+}
+
+int patch_ad1881(ac97_t * ac97)
+{
+	static const char cfg_idxs[3][2] = {
+		{2, 1},
+		{0, 2},
+		{0, 1}
+	};
+	
+	// patch for Analog Devices
+	unsigned short codecs[3];
+	int idx, num;
+
+	init_MUTEX(&ac97->spec.ad18xx.mutex);
+
+	codecs[0] = patch_ad1881_unchained(ac97, 0, (1<<12));
+	codecs[1] = patch_ad1881_unchained(ac97, 1, (1<<14));
+	codecs[2] = patch_ad1881_unchained(ac97, 2, (1<<13));
+
+	snd_runtime_check(codecs[0] | codecs[1] | codecs[2], goto __end);
+
+	for (idx = 0; idx < 3; idx++)
+		if (ac97->spec.ad18xx.unchained[idx])
+			patch_ad1881_chained(ac97, idx, cfg_idxs[idx][0], cfg_idxs[idx][1]);
+
+	if (ac97->spec.ad18xx.id[1]) {
+		ac97->flags |= AC97_AD_MULTI;
+		ac97->scaps |= AC97_SCAP_SURROUND_DAC;
+	}
+	if (ac97->spec.ad18xx.id[2]) {
+		ac97->flags |= AC97_AD_MULTI;
+		ac97->scaps |= AC97_SCAP_CENTER_LFE_DAC;
+	}
+
+      __end:
+	/* select all codecs */
+	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, 0x7000);
+	/* check if only one codec is present */
+	for (idx = num = 0; idx < 3; idx++)
+		if (ac97->spec.ad18xx.id[idx])
+			num++;
+	if (num == 1) {
+		/* ok, deselect all ID bits */
+		snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0000);
+	}
+	/* required for AD1886/AD1885 combination */
+	ac97->ext_id = snd_ac97_read(ac97, AC97_EXTENDED_ID);
+	if (ac97->spec.ad18xx.id[0]) {
+		ac97->id &= 0xffff0000;
+		ac97->id |= ac97->spec.ad18xx.id[0];
+	}
+	return 0;
+}
+
+int patch_ad1886(ac97_t * ac97)
+{
+	patch_ad1881(ac97);
+	/* Presario700 workaround */
+	/* for Jack Sense/SPDIF Register misetting causing */
+	snd_ac97_write_cache(ac97, AC97_AD_JACK_SPDIF, 0x0010);
+	return 0;
+}
diff -Nru a/sound/pci/ac97/ac97_patch.h b/sound/pci/ac97/ac97_patch.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/sound/pci/ac97/ac97_patch.h	Sun Sep 29 20:21:04 2002
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
+ *  Universal interface for Audio Codec '97
+ *
+ *  For more details look to AC '97 component specification revision 2.2
+ *  by Intel Corporation (http://developer.intel.com).
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+int patch_wolfson00(ac97_t * ac97);
+int patch_wolfson03(ac97_t * ac97);
+int patch_wolfson04(ac97_t * ac97);
+int patch_tritech_tr28028(ac97_t * ac97);
+int patch_sigmatel_stac9708(ac97_t * ac97);
+int patch_sigmatel_stac9721(ac97_t * ac97);
+int patch_sigmatel_stac9744(ac97_t * ac97);
+int patch_sigmatel_stac9756(ac97_t * ac97);
+int patch_cirrus_cs4299(ac97_t * ac97);
+int patch_cirrus_spdif(ac97_t * ac97);
+int patch_conexant(ac97_t * ac97);
+int patch_ad1819(ac97_t * ac97);
+int patch_ad1881(ac97_t * ac97);
+int patch_ad1886(ac97_t * ac97);

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.16
## Wrapped with gzip_uu ##


begin 664 bkpatch2407
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
6*#/#\?!45BU2LIF:^2\@19N%=E(`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

