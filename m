Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCDMC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUCDMC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:02:28 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:16593 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S261851AbUCDMC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:02:26 -0500
Subject: [PATCH] AC97 WM9713 power and audio changes
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-fgLwFz+5/Z/WS0NDtZs3"
Message-Id: <1078401740.3382.270.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Mar 2004 12:02:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fgLwFz+5/Z/WS0NDtZs3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've attached a patch against 2.4.25 that improves performance and power
levels in the WM9713. 

Jeff, this depends on the previous AC97 patch I sent.

Changes:-

  o Lower power consumption
  o Better quality playback and record.
  o Codec specific init() is now done after initialisation of the mixer
channel volumes. This prevents any init settings being clobbered by the
mixer volumes.


Liam  

--=-fgLwFz+5/Z/WS0NDtZs3
Content-Disposition: attachment; filename=wm9713.diff
Content-Type: text/x-patch; name=wm9713.diff; charset=
Content-Transfer-Encoding: 7bit

diff -urN a/drivers/sound/ac97_codec.c b/drivers/sound/ac97_codec.c
--- a/drivers/sound/ac97_codec.c	2004-03-04 10:24:26.000000000 +0000
+++ b/drivers/sound/ac97_codec.c	2004-03-04 10:29:17.000000000 +0000
@@ -932,11 +932,6 @@
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
@@ -947,6 +942,11 @@
 		ac97_set_mixer(codec, md->mixer, md->value);
 	}
 
+	/* codec specific initialization for 4-6 channel output or secondary codec stuff */
+	if (codec->codec_ops->init != NULL) {
+		codec->codec_ops->init(codec);
+	}
+	
 	/*
 	 *	Volume is MUTE only on this device. We have to initialise
 	 *	it but its useless beyond that.
@@ -1104,10 +1104,12 @@
 /* WM9713 */
 static int wolfson_init13(struct ac97_codec * codec)
 {
-	codec->codec_write(codec, AC97_MASTER_VOL_STEREO, 0x0000);
-	codec->codec_write(codec, AC97_HEADPHONE_VOL, 0x0000); 
 	codec->codec_write(codec, AC97_RECORD_GAIN, 0x00a0);	
-	codec->codec_write(codec, AC97_EXTEND_MODEM_STAT, 0x0000);
+	codec->codec_write(codec, AC97_POWER_CONTROL, 0x0000);
+	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0xDA00);
+	codec->codec_write(codec, AC97_EXTEND_MODEM_STAT, 0x3810);
+	codec->codec_write(codec, AC97_PHONE_VOL, 0x0808);
+	codec->codec_write(codec, AC97_PCBEEP_VOL, 0x0808);
 	return 0;
 }

--=-fgLwFz+5/Z/WS0NDtZs3--

