Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129525AbQK0SJQ>; Mon, 27 Nov 2000 13:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129645AbQK0SJI>; Mon, 27 Nov 2000 13:09:08 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:63473 "EHLO ife.ee.ethz.ch")
        by vger.kernel.org with ESMTP id <S129525AbQK0SI4>;
        Mon, 27 Nov 2000 13:08:56 -0500
Date: Mon, 27 Nov 2000 18:38:52 +0100 (MET)
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Message-Id: <200011271738.eARHcqM05977@eldrich.ee.ethz.ch>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH]: 2.4.0-testx: ac97_codec
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current ac97_codec, computation of attenuation values may overflow
the register width, thus resulting in maximum volume when minimum was requested.
This patch adds overflow checks and limitations.

Tom

--- ac97_codec.c.orig	Thu Nov 23 13:13:13 2000
+++ ac97_codec.c	Thu Nov 23 13:20:01 2000
@@ -284,6 +284,10 @@
 			if (oss_channel == SOUND_MIXER_IGAIN) {
 				right = (right * mh->scale) / 100;
 				left = (left * mh->scale) / 100;
+				if (right >= mh->scale)
+					right = mh->scale-1;
+				if (left >= mh->scale)
+					left = mh->scale-1;
 			} else {
 				/* these may have 5 or 6 bit resolution */
 				if (oss_channel == SOUND_MIXER_VOLUME ||
@@ -294,27 +298,49 @@
 
 				right = ((100 - right) * scale) / 100;
 				left = ((100 - left) * scale) / 100;
-			}			
+				if (right >= scale)
+					right = scale-1;
+				if (left >= scale)
+					left = scale-1;
+			}
 			val = (left << 8) | right;
 		}
 	} else if (oss_channel == SOUND_MIXER_BASS) {
 		val = codec->codec_read(codec , mh->offset) & ~0x0f00;
-		val |= ((((100 - left) * mh->scale) / 100) << 8) & 0x0e00;
+		left = ((100 - left) * mh->scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val |= (left << 8) & 0x0e00;
 	} else if (oss_channel == SOUND_MIXER_TREBLE) {
 		val = codec->codec_read(codec , mh->offset) & ~0x000f;
-		val |= (((100 - left) * mh->scale) / 100) & 0x000e;
+		left = ((100 - left) * mh->scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val |= left & 0x000e;
 	} else if(left == 0) {
 		val = AC97_MUTE;
 	} else if (oss_channel == SOUND_MIXER_SPEAKER) {
-		val = (((100 - left) * mh->scale) / 100) << 1;
+		left = ((100 - left) * mh->scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val = left << 1;
 	} else if (oss_channel == SOUND_MIXER_PHONEIN) {
-		val = (((100 - left) * mh->scale) / 100);
+		left = ((100 - left) * mh->scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val = left;
 	} else if (oss_channel == SOUND_MIXER_PHONEOUT) {
 		scale = (1 << codec->bit_resolution);
-		val = (((100 - left) * scale) / 100);
+		left = ((100 - left) * scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val = left;
 	} else if (oss_channel == SOUND_MIXER_MIC) {
 		val = codec->codec_read(codec , mh->offset) & ~0x801f;
-		val |= (((100 - left) * mh->scale) / 100);
+		left = ((100 - left) * mh->scale) / 100;
+		if (left >= mh->scale)
+			left = mh->scale-1;
+		val |= left;
 		/*  the low bit is optional in the tone sliders and masking
 		    it lets us avoid the 0xf 'bypass'.. */
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
