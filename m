Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVAZNnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVAZNnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVAZNnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:43:09 -0500
Received: from [212.20.225.142] ([212.20.225.142]:37561 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S262294AbVAZNmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:42:43 -0500
Subject: [PATCH] OSS Support for AC97 low power codecs
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-NL15Gp2rxlLsuRBEn8UI"
Message-Id: <1106746962.3998.1652.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 26 Jan 2005 13:42:42 +0000
X-OriginalArrivalTime: 26 Jan 2005 13:42:42.0423 (UTC) FILETIME=[E8C24070:01C503AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NL15Gp2rxlLsuRBEn8UI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

This is a resend of a patch that has been applied to 2.4. The low power
codec functionality has also now been included in ALSA.

I've attached a patch against 2.6.11-rc2 that checks the codec ID before
doing an AC97 register reset. This allows the kernel to support low
power codecs that are powered down by a reset command. This patch also
fixes some other minor issues.

Changes:-

 o Added AC97_DEFAULT_POWER_OFF to ac97_codec_ids[]
 o ac97_probe now checks hardwired codec ID's before sending a reset
 o Added support for WM9713
 o Moved the codec specific inits after the mixer setup as some init
settings were being clobbered.
 o Added extra check so that default_digital_ops doesn't overwrite a
valid codec_ops. (SPDIF)

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-NL15Gp2rxlLsuRBEn8UI
Content-Disposition: attachment; filename=ac97-oss.diff
Content-Type: text/x-patch; name=ac97-oss.diff; charset=
Content-Transfer-Encoding: 7bit

diff -ur a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
--- a/sound/oss/ac97_codec.c	2005-01-22 01:47:15.000000000 +0000
+++ b/sound/oss/ac97_codec.c	2005-01-26 13:22:23.000000000 +0000
@@ -71,6 +71,7 @@
 static int wolfson_init04(struct ac97_codec * codec);
 static int wolfson_init05(struct ac97_codec * codec);
 static int wolfson_init11(struct ac97_codec * codec);
+static int wolfson_init13(struct ac97_codec * codec);
 static int tritech_init(struct ac97_codec * codec);
 static int tritech_maestro_init(struct ac97_codec * codec);
 static int sigmatel_9708_init(struct ac97_codec *codec);
@@ -107,6 +108,7 @@
 static struct ac97_ops wolfson_ops04 = { wolfson_init04, NULL, NULL };
 static struct ac97_ops wolfson_ops05 = { wolfson_init05, NULL, NULL };
 static struct ac97_ops wolfson_ops11 = { wolfson_init11, NULL, NULL };
+static struct ac97_ops wolfson_ops13 = { wolfson_init13, NULL, NULL };
 static struct ac97_ops tritech_ops = { tritech_init, NULL, NULL };
 static struct ac97_ops tritech_m_ops = { tritech_maestro_init, NULL, NULL };
 static struct ac97_ops sigmatel_9708_ops = { sigmatel_9708_init, NULL, NULL };
@@ -171,6 +173,7 @@
 	{0x574D4C05, "Wolfson WM9705/WM9710",   &wolfson_ops05},
 	{0x574D4C09, "Wolfson WM9709",		&null_ops},
 	{0x574D4C12, "Wolfson WM9711/9712",	&wolfson_ops11},
+	{0x574D4C13, "Wolfson WM9713",	&wolfson_ops13, AC97_DEFAULT_POWER_OFF},
 	{0x83847600, "SigmaTel STAC????",	&null_ops},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
 	{0x83847605, "SigmaTel STAC9704",	&null_ops},
@@ -797,6 +800,9 @@
  *	Currently codec_wait is used to wait for AC97 codec
  *	reset to complete. 
  *
+ *     Some codecs will power down when a register reset is
+ *     performed. We now check for such codecs.
+ *
  *	Returns 1 (true) on success, or 0 (false) on failure.
  */
  
@@ -810,34 +816,17 @@
 	struct list_head *l;
 	struct ac97_driver *d;
 	
-	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
-	 * be read zero.
-	 *
-	 * FIXME: is the following comment outdated?  -jgarzik 
-	 * Probing of AC97 in this way is not reliable, it is not even SAFE !!
-	 */
-	codec->codec_write(codec, AC97_RESET, 0L);
-
-	/* also according to spec, we wait for codec-ready state */	
+	/* wait for codec-ready state */	
 	if (codec->codec_wait)
 		codec->codec_wait(codec);
 	else
 		udelay(10);
-
-	if ((audio = codec->codec_read(codec, AC97_RESET)) & 0x8000) {
-		printk(KERN_ERR "ac97_codec: %s ac97 codec not present\n",
-		       (codec->id & 0x2) ? (codec->id&1 ? "4th" : "Tertiary") 
-		       : (codec->id&1 ? "Secondary":  "Primary"));
-		return 0;
-	}
-
-	/* probe for Modem Codec */
-	codec->modem = ac97_check_modem(codec);
-	codec->name = NULL;
-	codec->codec_ops = &default_ops;
-
+	
+	/* will the codec power down if register reset ? */
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
+	codec->name = NULL;
+	codec->codec_ops = &null_ops;
 	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
 		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
 			codec->type = ac97_codec_ids[i].id;
@@ -849,9 +838,34 @@
 	}
 
 	codec->model = (id1 << 16) | id2;
+	if ((codec->flags & AC97_DEFAULT_POWER_OFF) == 0) {
+		/* reset codec and wait for the ready bit before we continue */
+		codec->codec_write(codec, AC97_RESET, 0L);
+		if (codec->codec_wait)
+			codec->codec_wait(codec);
+		else
+			udelay(10);
+	}
 	
+	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
+	 * be read zero.
+	 *
+	 * FIXME: is the following comment outdated?  -jgarzik 
+	 * Probing of AC97 in this way is not reliable, it is not even SAFE !!
+	 */
+	if ((audio = codec->codec_read(codec, AC97_RESET)) & 0x8000) {
+		printk(KERN_ERR "ac97_codec: %s ac97 codec not present\n",
+		       (codec->id & 0x2) ? (codec->id&1 ? "4th" : "Tertiary") 
+		       : (codec->id&1 ? "Secondary":  "Primary"));
+		return 0;
+	}
+	
+	/* probe for Modem Codec */
+	codec->modem = ac97_check_modem(codec);
+	
+	/* enable SPDIF */
 	f = codec->codec_read(codec, AC97_EXTENDED_STATUS);
-	if(f & 4)
+	if((codec->codec_ops == &null_ops) && (f & 4))
 		codec->codec_ops = &default_digital_ops;
 	
 	/* A device which thinks its a modem but isnt */
@@ -920,11 +934,6 @@
 	codec->recmask_io = ac97_recmask_io;
 	codec->mixer_ioctl = ac97_mixer_ioctl;
 
-	/* codec specific initialization for 4-6 channel output or secondary codec stuff */
-	if (codec->codec_ops->init != NULL) {
-		codec->codec_ops->init(codec);
-	}
-
 	/* initialize mixer channel volumes */
 	for (i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
 		struct mixer_defaults *md = &mixer_defaults[i];
@@ -934,6 +943,11 @@
 			continue;
 		ac97_set_mixer(codec, md->mixer, md->value);
 	}
+	
+	/* codec specific initialization for 4-6 channel output or secondary codec stuff */
+	if (codec->codec_ops->init != NULL) {
+		codec->codec_ops->init(codec);
+	}
 
 	/*
 	 *	Volume is MUTE only on this device. We have to initialise
@@ -1090,6 +1104,19 @@
 	return 0;
 }
 
+/* WM9713 */
+static int wolfson_init13(struct ac97_codec * codec)
+{
+	codec->codec_write(codec, AC97_RECORD_GAIN, 0x00a0);	
+	codec->codec_write(codec, AC97_POWER_CONTROL, 0x0000);
+	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0xDA00);
+	codec->codec_write(codec, AC97_EXTEND_MODEM_STAT, 0x3810);
+	codec->codec_write(codec, AC97_PHONE_VOL, 0x0808);
+	codec->codec_write(codec, AC97_PCBEEP_VOL, 0x0808);
+
+	return 0;
+}
+
 static int tritech_init(struct ac97_codec * codec)
 {
 	codec->codec_write(codec, 0x26, 0x0300);
+++ b/include/linux/ac97_codec.h	2005-01-26 13:22:50.000000000 +0000
@@ -290,6 +290,7 @@
 	
 #define AC97_DELUDED_MODEM	1	/* Audio codec reports its a modem */
 #define AC97_NO_PCM_VOLUME	2	/* Volume control is missing 	   */
+#define AC97_DEFAULT_POWER_OFF 4 /* Needs warm reset to power up */
 };
 
 extern int ac97_read_proc (char *page_out, char **start, off_t off,
@@ -299,6 +300,8 @@
 extern unsigned int ac97_set_dac_rate(struct ac97_codec *codec, unsigned int rate);
 extern int ac97_save_state(struct ac97_codec *codec);
 extern int ac97_restore_state(struct ac97_codec *codec);
+extern int ac97_suspend(struct ac97_codec *codec, int state);
+extern void ac97_resume(struct ac97_codec *codec);
 
 extern struct ac97_codec *ac97_alloc_codec(void);
 extern void ac97_release_codec(struct ac97_codec *codec);
@@ -310,6 +313,8 @@
 	u32 codec_mask;
 	int (*probe) (struct ac97_codec *codec, struct ac97_driver *driver);
 	void (*remove) (struct ac97_codec *codec, struct ac97_driver *driver);
+	int (*suspend) (struct ac97_codec *codec, int state);
+	void (*resume) (struct ac97_codec *codec);
 };
 
 extern int ac97_register_driver(struct ac97_driver *driver);

--=-NL15Gp2rxlLsuRBEn8UI--

