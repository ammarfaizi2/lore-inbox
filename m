Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVADLed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVADLed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVADLed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:34:33 -0500
Received: from [212.20.225.142] ([212.20.225.142]:42801 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261162AbVADLeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:34:12 -0500
Subject: [PATCH] AC97 support for low power codecs
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-KSJQiI3J/nNRK+nWyhZY"
Message-Id: <1104838450.9143.81.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 11:34:10 +0000
X-OriginalArrivalTime: 04 Jan 2005 11:34:10.0824 (UTC) FILETIME=[4F332080:01C4F251]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KSJQiI3J/nNRK+nWyhZY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan,

This is a resend of a patch that has been applied to 2.4.

I've attached a patch against 2.6.10 that checks the codec ID before
doing an AC97 register reset. This allows the kernel to support low
power codecs that are powered down by a reset command. This patch also
fixes some other minor issues.

A similar patch for ALSA will follow soon.

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

--=-KSJQiI3J/nNRK+nWyhZY
Content-Disposition: attachment; filename=ac97_codec.diff
Content-Type: text/x-patch; name=ac97_codec.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/sound/oss/ac97_codec.c	2004-12-24 21:34:00.000000000 +0000
+++ b/sound/oss/ac97_codec.c	2004-12-08 17:08:42.000000000 +0000
@@ -30,6 +30,9 @@
  **************************************************************************
  *
  * History
+ * Feb 25, 2004 Liam Girdwood
+ *  Added support for codecs that require a warm reset to power up.
+ *  Support for WM9713
  * May 02, 2003 Liam Girdwood <liam.girdwood@wolfsonmicro.com>
  *	Removed non existant WM9700
  *	Added support for WM9705, WM9708, WM9709, WM9710, WM9711
@@ -70,6 +73,7 @@
 static int wolfson_init04(struct ac97_codec * codec);
 static int wolfson_init05(struct ac97_codec * codec);
 static int wolfson_init11(struct ac97_codec * codec);
+static int wolfson_init13(struct ac97_codec * codec);
 static int tritech_init(struct ac97_codec * codec);
 static int tritech_maestro_init(struct ac97_codec * codec);
 static int sigmatel_9708_init(struct ac97_codec *codec);
@@ -106,6 +110,7 @@
 static struct ac97_ops wolfson_ops04 = { wolfson_init04, NULL, NULL };
 static struct ac97_ops wolfson_ops05 = { wolfson_init05, NULL, NULL };
 static struct ac97_ops wolfson_ops11 = { wolfson_init11, NULL, NULL };
+static struct ac97_ops wolfson_ops13 = { wolfson_init13, NULL, NULL };
 static struct ac97_ops tritech_ops = { tritech_init, NULL, NULL };
 static struct ac97_ops tritech_m_ops = { tritech_maestro_init, NULL, NULL };
 static struct ac97_ops sigmatel_9708_ops = { sigmatel_9708_init, NULL, NULL };
@@ -167,6 +172,7 @@
 	{0x574D4C05, "Wolfson WM9705/WM9710",   &wolfson_ops05},
 	{0x574D4C09, "Wolfson WM9709",		&null_ops},
 	{0x574D4C12, "Wolfson WM9711/9712",	&wolfson_ops11},
+	{0x574D4C13, "Wolfson WM9713",	&wolfson_ops13, AC97_DEFAULT_POWER_OFF},
 	{0x83847600, "SigmaTel STAC????",	&null_ops},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
 	{0x83847605, "SigmaTel STAC9704",	&null_ops},
@@ -793,6 +799,9 @@
  *	Currently codec_wait is used to wait for AC97 codec
  *	reset to complete. 
  *
+ *  Some codecs will power down when a register reset is
+ *  performed. We now check for such codecs.
+ *
  *	Returns 1 (true) on success, or 0 (false) on failure.
  */
  
@@ -806,34 +815,17 @@
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
@@ -845,9 +837,34 @@
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
@@ -916,11 +933,6 @@
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
@@ -930,6 +942,11 @@
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
@@ -1086,6 +1103,19 @@
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
--- a/include/linux/ac97_codec.h	2004-12-24 21:33:50.000000000 +0000
+++ b/include/linux/ac97_codec.h	2004-12-08 13:28:42.000000000 +0000
@@ -290,6 +290,7 @@
 	
 #define AC97_DELUDED_MODEM	1	/* Audio codec reports its a modem */
 #define AC97_NO_PCM_VOLUME	2	/* Volume control is missing 	   */
+#define AC97_DEFAULT_POWER_OFF 4 	/* Needs warm reset to power up */
 };
 
 extern int ac97_read_proc (char *page_out, char **start, off_t off,

--=-KSJQiI3J/nNRK+nWyhZY--

