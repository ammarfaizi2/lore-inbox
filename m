Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSC1QxG>; Thu, 28 Mar 2002 11:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSC1Qws>; Thu, 28 Mar 2002 11:52:48 -0500
Received: from [206.124.139.154] ([206.124.139.154]:34318 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP
	id <S312031AbSC1Qwl>; Thu, 28 Mar 2002 11:52:41 -0500
Date: Thu, 28 Mar 2002 08:52:38 -0800
From: Randolph Bentson <bentson@grieg.holmsjoen.com>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Wolfson codec (AC97 sound)
Message-ID: <20020328085238.A2224@grieg.holmsjoen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done some work getting sound out of a ViewSonic ViewPad
1000.  In the end, I got it to work once I removed some of the
initialization code for Wolfson codecs.  After searching back
through the archives, and corresponding with folks whose addresses
appeared in the source, I was told that code was dropped in from
the ALSA drivers.

It seems that someone (whom I'd like to hear from) developed the
code for the Wolfson WM9704Q, then used the same initialization
for other Wolfson codecs.  This was an error.  The WM9707 doesn't
take kindly to initialization suited for the WM9704Q.

I think I've properly split up the code, but I'd really like
feedback from folks who can test the other flavors of Wolfson
codecs.

I've attached a patch which applies to 2.4.18, and I believe
will work on 2.4.19xxx and 2.5.xx as well.

-- 
Randolph Bentson
bentson@holmsjoen.com
randy@votehere.net


--- linux/drivers/sound/ac97_codec.c	2002/03/26 23:00:39	1.1
+++ linux/drivers/sound/ac97_codec.c	2002/03/28 00:12:29
@@ -31,6 +31,8 @@
  **************************************************************************
  *
  * History
+ * Mar 28, 2002 Randolph Bentson <bentson@holmsjoen.com>
+ *	corrections to support WM9707 in ViewPad 1000
  * v0.4 Mar 15 2000 Ollie Lho
  *	dual codecs support verified with 4 channels output
  * v0.3 Feb 22 2000 Ollie Lho
@@ -59,7 +61,9 @@
 
 static int ac97_init_mixer(struct ac97_codec *codec);
 
-static int wolfson_init(struct ac97_codec * codec);
+static int wolfson_init00(struct ac97_codec * codec);
+static int wolfson_init03(struct ac97_codec * codec);
+static int wolfson_init04(struct ac97_codec * codec);
 static int tritech_init(struct ac97_codec * codec);
 static int tritech_maestro_init(struct ac97_codec * codec);
 static int sigmatel_9708_init(struct ac97_codec *codec);
@@ -87,7 +91,9 @@
  
 static struct ac97_ops null_ops = { NULL, NULL, NULL };
 static struct ac97_ops default_ops = { NULL, eapd_control, NULL };
-static struct ac97_ops wolfson_ops = { wolfson_init, NULL, NULL };
+static struct ac97_ops wolfson_ops00 = { wolfson_init00, NULL, NULL };
+static struct ac97_ops wolfson_ops03 = { wolfson_init03, NULL, NULL };
+static struct ac97_ops wolfson_ops04 = { wolfson_init04, NULL, NULL };
 static struct ac97_ops tritech_ops = { tritech_init, NULL, NULL };
 static struct ac97_ops tritech_m_ops = { tritech_maestro_init, NULL, NULL };
 static struct ac97_ops sigmatel_9708_ops = { sigmatel_9708_init, NULL, NULL };
@@ -131,9 +137,9 @@
 	{0x54524106, "TriTech TR28026",		&null_ops},
 	{0x54524108, "TriTech TR28028",		&tritech_ops},
 	{0x54524123, "TriTech TR A5",		&null_ops},
-	{0x574D4C00, "Wolfson WM9704",		&wolfson_ops},
-	{0x574D4C03, "Wolfson WM9703/9704",	&wolfson_ops},
-	{0x574D4C04, "Wolfson WM9704 (quad)",	&wolfson_ops},
+	{0x574D4C00, "Wolfson WM9700A",		&wolfson_ops00},
+	{0x574D4C03, "Wolfson WM9703/WM9707",	&wolfson_ops03},
+	{0x574D4C04, "Wolfson WM9704M/WM9704Q",	&wolfson_ops04},
 	{0x83847600, "SigmaTel STAC????",	&null_ops},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
 	{0x83847605, "SigmaTel STAC9704",	&null_ops},
@@ -833,7 +839,38 @@
 }
 
 
-static int wolfson_init(struct ac97_codec * codec)
+static int wolfson_init00(struct ac97_codec * codec)
+{
+	/* This initialization is suspect, but not known to be wrong.
+	   It was copied from the initialization for the WM9704Q, but
+	   that same sequence is known to fail for the WM9707.  Thus
+	   this warning may help someone with hardware to test
+	   this code. */
+	codec->codec_write(codec, 0x72, 0x0808);
+	codec->codec_write(codec, 0x74, 0x0808);
+
+	// patch for DVD noise
+	codec->codec_write(codec, 0x5a, 0x0200);
+
+	// init vol as PCM vol
+	codec->codec_write(codec, 0x70,
+		codec->codec_read(codec, AC97_PCMOUT_VOL));
+
+	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	return 0;
+}
+
+
+static int wolfson_init03(struct ac97_codec * codec)
+{
+	/* this is known to work for the ViewSonic ViewPad 1000 */
+	codec->codec_write(codec, 0x72, 0x0808);
+	codec->codec_write(codec, 0x20, 0x8000);
+	return 0;
+}
+
+
+static int wolfson_init04(struct ac97_codec * codec)
 {
 	codec->codec_write(codec, 0x72, 0x0808);
 	codec->codec_write(codec, 0x74, 0x0808);
