Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313090AbSDEQuG>; Fri, 5 Apr 2002 11:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313091AbSDEQt4>; Fri, 5 Apr 2002 11:49:56 -0500
Received: from chuleta.newphoenixsrl.com ([200.49.68.228]:39685 "EHLO
	chuleta.newphoenixsrl.com") by vger.kernel.org with ESMTP
	id <S313090AbSDEQtk>; Fri, 5 Apr 2002 11:49:40 -0500
Date: Fri, 5 Apr 2002 13:46:47 -0300
From: Santiago Nullo <sn@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Compaq Presario 700 Sound Fix (Patch)
Message-Id: <20020405134647.34320c34.sn@softhome.net>
Organization: Newphoenix SRL
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem regarding the Compaq Presario series 700 sound (no sound output, driver working properly) has been solved by initializing the JackSense JSM register.
This properly sets the AD1886 on Compaq Presario 700 series and alows audio to actually came out.
Sometimes a saturated sound cames out from PCM playback...adjusting volume seems to solve it. But this is at least a beggining of support for the 700 sound. I'll post again when I solve this minos issue.



diff -u --new-file --recursive linux-2.4.18/drivers/sound/ac97_codec.c linux/drivers/sound/ac97_codec.c
--- linux-2.4.18/drivers/sound/ac97_codec.c	Mon Nov 12 15:02:54 2001
+++ linux/drivers/sound/ac97_codec.c	Fri Apr  5 03:12:56 2002
@@ -65,6 +65,7 @@
 static int sigmatel_9708_init(struct ac97_codec *codec);
 static int sigmatel_9721_init(struct ac97_codec *codec);
 static int sigmatel_9744_init(struct ac97_codec *codec);
+static int ad1886_init(struct ac97_codec *codec);
 static int eapd_control(struct ac97_codec *codec, int);
 static int crystal_digital_control(struct ac97_codec *codec, int mode);
 
@@ -94,6 +95,7 @@
 static struct ac97_ops sigmatel_9721_ops = { sigmatel_9721_init, NULL, NULL };
 static struct ac97_ops sigmatel_9744_ops = { sigmatel_9744_init, NULL, NULL };
 static struct ac97_ops crystal_digital_ops = { NULL, eapd_control, crystal_digital_control };
+static struct ac97_ops ad1886_ops = { ad1886_init, eapd_control, NULL };
 
 /* sorted by vendor/device id */
 static const struct {
@@ -106,6 +108,7 @@
 	{0x41445348, "Analog Devices AD1881A",	&null_ops},
 	{0x41445360, "Analog Devices AD1885",	&default_ops},
 	{0x41445460, "Analog Devices AD1885",	&default_ops},
+	{0x41445361, "Analog Devices AD1886",	&ad1886_ops},
 	{0x414B4D00, "Asahi Kasei AK4540",	&null_ops},
 	{0x414B4D01, "Asahi Kasei AK4542",	&null_ops},
 	{0x414B4D02, "Asahi Kasei AK4543",	&null_ops},
@@ -869,6 +872,26 @@
 	codec->codec_write(codec, 0x2C, 0XFFFF);
 	return 0;
 }
+
+
+
+/* 
+ *	Presario700 workaround 
+ * 	for Jack Sense/SPDIF Register misetting causing
+ *	no audible output
+ *	by Santiago Nullo 04/05/2002
+ */
+
+#define AC97_AD1886_JACK_SENSE 0x72
+
+static int ad1886_init(struct ac97_codec * codec)
+{
+	/* from AD1886 Specs */
+	codec->codec_write(codec, AC97_AD1886_JACK_SENSE, 0x0010);
+	return 0;
+}
+
+
 
 
 /*

