Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266035AbRGCWBN>; Tue, 3 Jul 2001 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266034AbRGCWBD>; Tue, 3 Jul 2001 18:01:03 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:42239 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S266035AbRGCWAx>;
	Tue, 3 Jul 2001 18:00:53 -0400
Message-Id: <200107032159.OAA31434@vr721312.corp.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ollie@sis.com.tw, perex@suse.cz, zab@redhat.com
X-mailer: Gnu emacs 19.34, skk 9.6, mh-e.el 1.14, MH 6.8.4
Subject: [PATCH] 2.4.5 i810_audio.c, ac97_codec.c
Date: Tue, 03 Jul 2001 14:59:39 -0700
From: Collin Park <collin@corp.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Attached is a patch to the above files.  Here's what they do:

1. ac97_codec.c, allow ad1886 to be recognized and brought up
   properly, and sets S/PDIF rate to the 48 kHz rate prescribed by
   ac97 2.2 spec.

   Reference for this is in...

        http://www.alsa-project.org/alsa/ftp/manuals/ad/AD1886.pdf
                (page 20)
                
   and
        ftp://download.intel.com/ial/scalableplatforms/ac97r22.pdf
                (page 62)

   Perhaps someone (Ollie?) would prefer that these changes apply to
   other ac97 codecs, since the ac97r22.pdf spec says that SPDIF bit
   in register 2A shall be 0 when modifying register 3A -- thus this
   is not unique to ad1886?


2. i810_audio.c, turn S/PDIF *on* when bringing up the codec; also
   added comments to explain what [some of] the bits do.

   Descriptions of the bits are [supposed to be] in the above PDF
   files: p.19 of the AD1886.pdf, p.59 of ac97r22.pdf

   There are some other bits whose function I don't understand; I
   didn't alter them, but inserted comments.

   Perhaps someone (Zach, Jaroslav, Alan, ...?) would prefer to look
   more closely at the bits being set in AC97_EXTENDED_STATUS... i.e.,
   the 0x8000 bit, which is not described in the ac97 2.2 spec as
   other than 'x', why we turn on PRL, PRK, and PRI but have PRJ
   turned off (indeed, with PRL=1, the mic adc is off, so why turn on
   VRM?), etc.  I don't know what most of these bits are, but as I
   mentioned just modify the bit[s] that I know I need set.


These patches were tested under 2.4.4 (neither file has changed much
from 2.4.4 to 2.4.5 and indeed a 2.4.4 patch goes cleanly onto 2.4.5).

Comments, corrections, suggestions?  In case TAB characters get
trashed by the mail system, these patches will also be available, for
a while anyway, at

    http://www.sonic.net/~cpark/245-sound-drivers.patch


---------------- cut here -------------------
diff -ru linux-2.4.5-stock/drivers/sound/ac97_codec.c linux-2.4.5_patched/drivers/sound/ac97_codec.c
--- linux-2.4.5-stock/drivers/sound/ac97_codec.c	Thu Apr 19 22:58:20 2001
+++ linux-2.4.5_patched/drivers/sound/ac97_codec.c	Tue Jul  3 11:40:51 2001
@@ -66,6 +66,8 @@
 static int sigmatel_9721_init(struct ac97_codec *codec);
 static int sigmatel_9744_init(struct ac97_codec *codec);
 static int enable_eapd(struct ac97_codec *codec);
+static int setup_ad1886(struct ac97_codec *codec);
+
 
 /* sorted by vendor/device id */
 static const struct {
@@ -77,6 +79,7 @@
 	{0x41445340, "Analog Devices AD1881",	NULL},
 	{0x41445348, "Analog Devices AD1881A",	NULL},
 	{0x41445460, "Analog Devices AD1885",	enable_eapd},
+	{0x41445361, "Analog Devices AD1886"  , setup_ad1886},
 	{0x414B4D00, "Asahi Kasei AK4540",	NULL},
 	{0x414B4D01, "Asahi Kasei AK4542",	NULL},
 	{0x414B4D02, "Asahi Kasei AK4543",	NULL},
@@ -852,6 +855,22 @@
 	codec->codec_write(codec, AC97_POWER_CONTROL,
 		codec->codec_read(codec, AC97_POWER_CONTROL)|0x8000);
 	return 0;
+}
+
+/*
+ *      Bring up an AD1886
+ */
+ 
+static int setup_ad1886(struct ac97_codec * codec)
+{
+        /* The spec says not to mess with other bits unless
+           S/PDIF is turned *off* in reg 2A */
+        codec->codec_write(codec, AC97_EXTENDED_STATUS, 0);
+
+        /* The 1886 spec dated 08/25/00 says default value=0
+           but ac97 2.2 says it should be 0x2000. */
+        codec->codec_write(codec, AC97_RESERVED_3A, 0x2000); /* 48 kHz */
+        return 0;
 }
 
 
diff -ru linux-2.4.5-stock/drivers/sound/i810_audio.c linux-2.4.5_patched/drivers/sound/i810_audio.c
--- linux-2.4.5-stock/drivers/sound/i810_audio.c	Sat May 19 17:43:07 2001
+++ linux-2.4.5_patched/drivers/sound/i810_audio.c	Tue Jul  3 11:40:51 2001
@@ -2001,8 +2001,12 @@
 			printk(KERN_WARNING "i810_audio: only 48Khz playback available.\n");
 		else
 		{
-			/* Enable variable rate mode */
-			i810_ac97_set(codec, AC97_EXTENDED_STATUS, 9);
+			/* Turn on VRA, VRM (enable variable rate mode), turn off DRA.
+                           Turn on SPDIF, set source data to AC-link slots 3&4.
+                           (see AC'97 component specification rev 2.2 from intel) */
+			i810_ac97_set(codec, AC97_EXTENDED_STATUS, 0xD);
+                        /* ac'97 2.2 doesn't say what the 0x8000 bit is, but 0x6800
+                           bits turn PCM center DAC, PCM LFE DACs, and MIC ADC all off */
 			i810_ac97_set(codec,AC97_EXTENDED_STATUS,
 				i810_ac97_get(codec, AC97_EXTENDED_STATUS)|0xE800);
---------------- cut here -------------------

-- 
Neither I nor my employer will accept any liability for any problems
or consequential loss caused by relying on this information.  Sorry.
Collin Park                         Not a statement of my employer.
