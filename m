Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTELWoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbTELWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:44:12 -0400
Received: from continuum.cm.nu ([216.113.193.225]:41959 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S262820AbTELWoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:44:10 -0400
Date: Mon, 12 May 2003 15:56:54 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4 ac97_codec micboost control
Message-ID: <20030512225654.GA27358@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a small patch to enable the built-in mic boost
of the ac97_codec.  On my SB-live, it needs this to get
decent mic volume and I imagine this is the case for some
other cards as well.  It maps the micboost to
SOUND_MIXER_AGC which, well, isn't used for anything else
at present that I know of.

Applies to 2.4.21-rc2.

S

diff -urN linux.orig/drivers/sound/ac97_codec.c linux/drivers/sound/ac97_codec.c
--- linux.orig/drivers/sound/ac97_codec.c	2003-05-12 15:50:07.000000000 -0700
+++ linux/drivers/sound/ac97_codec.c	2003-05-12 15:50:52.000000000 -0700
@@ -400,6 +400,18 @@
 		if (left >= mh->scale)
 			left = mh->scale-1;
 		val |= left & 0x000e;
+	} else if (oss_channel == SOUND_MIXER_MIC) {
+		val = codec->codec_read(codec , mh->offset) & ~0x801f;
+		if (!left)
+			val |= AC97_MUTE;
+	 else {
+			left = ((100 - left) * mh->scale) / 100;
+			if (left >= mh->scale)
+				left = mh->scale-1;
+			val |= left;
+			/*  the low bit is optional in the tone sliders and masking
+			    it lets us avoid the 0xf 'bypass'.. */
+		}
 	} else if(left == 0) {
 		val = AC97_MUTE;
 	} else if (oss_channel == SOUND_MIXER_SPEAKER) {
@@ -418,14 +430,6 @@
 		if (left >= mh->scale)
 			left = mh->scale-1;
 		val = left;
-	} else if (oss_channel == SOUND_MIXER_MIC) {
-		val = codec->codec_read(codec , mh->offset) & ~0x801f;
-		left = ((100 - left) * mh->scale) / 100;
-		if (left >= mh->scale)
-			left = mh->scale-1;
-		val |= left;
-		/*  the low bit is optional in the tone sliders and masking
-		    it lets us avoid the 0xf 'bypass'.. */
 	}
 #ifdef DEBUG
 	printk(" 0x%04x", val);
@@ -574,6 +578,15 @@
 			codec->recmask_io(codec, 0, val);
 
 			return 0;
+		case _IOC_NR(SOUND_MIXER_AGC): {
+			u16 r = codec->codec_read(codec, AC97_MIC_VOL);
+			if (val)
+				r |= AC97_MICBOOST;
+			else
+				r &= ~AC97_MICBOOST;
+		codec->codec_write(codec, AC97_MIC_VOL, r);
+		return 0;
+		}
 		default: /* write a specific mixer */
 			i = _IOC_NR(cmd);
 
