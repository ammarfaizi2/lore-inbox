Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVCPX41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVCPX41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCPXzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:55:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:46737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262884AbVCPXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:21 -0500
Date: Wed, 16 Mar 2005 15:54:15 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: dsd@gentoo.org, tiwai@suse.de, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [1/9] [ALSA] Fix stereo mutes on Surround volume control
Message-ID: <20050316235415.GZ5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Daniel Drake <dsd@gentoo.org>

As of 2.6.11, I have no output out of the rear right speaker of my 4.1 
surround sound setup. I am using snd-intel8x0 based on a Realtek ALC650F chip 
on an nvidia motherboard.

A gentoo user with completely different hardware also ran into this:
http://bugs.gentoo.org/84276

2.6.11-mm3 fixes this problem and I've identified the specific fix, which is 
already in the ALSA development tree. An ALSA developer asked me to submit the 
fix for 2.6.11.x when I'd found it, so here it is :)

--
AC97 Codec
Fix stereo mutes on Surround volume control.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Naru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	2005-03-14 08:24:04 -08:00
+++ b/sound/pci/ac97/ac97_codec.c	2005-03-14 08:24:04 -08:00
@@ -1184,7 +1184,7 @@
 /*
  * create mute switch(es) for normal stereo controls
  */
-static int snd_ac97_cmute_new(snd_card_t *card, char *name, int reg, ac97_t *ac97)
+static int snd_ac97_cmute_new_stereo(snd_card_t *card, char *name, int reg, int check_stereo, ac97_t *ac97)
 {
 	snd_kcontrol_t *kctl;
 	int err;
@@ -1195,7 +1195,7 @@
 
 	mute_mask = 0x8000;
 	val = snd_ac97_read(ac97, reg);
-	if (ac97->flags & AC97_STEREO_MUTES) {
+	if (check_stereo || (ac97->flags & AC97_STEREO_MUTES)) {
 		/* check whether both mute bits work */
 		val1 = val | 0x8080;
 		snd_ac97_write(ac97, reg, val1);
@@ -1253,7 +1253,7 @@
 /*
  * create a mute-switch and a volume for normal stereo/mono controls
  */
-static int snd_ac97_cmix_new(snd_card_t *card, const char *pfx, int reg, ac97_t *ac97)
+static int snd_ac97_cmix_new_stereo(snd_card_t *card, const char *pfx, int reg, int check_stereo, ac97_t *ac97)
 {
 	int err;
 	char name[44];
@@ -1264,7 +1264,7 @@
 
 	if (snd_ac97_try_bit(ac97, reg, 15)) {
 		sprintf(name, "%s Switch", pfx);
-		if ((err = snd_ac97_cmute_new(card, name, reg, ac97)) < 0)
+		if ((err = snd_ac97_cmute_new_stereo(card, name, reg, check_stereo, ac97)) < 0)
 			return err;
 	}
 	check_volume_resolution(ac97, reg, &lo_max, &hi_max);
@@ -1276,6 +1276,8 @@
 	return 0;
 }
 
+#define snd_ac97_cmix_new(card, pfx, reg, ac97)	snd_ac97_cmix_new_stereo(card, pfx, reg, 0, ac97)
+#define snd_ac97_cmute_new(card, name, reg, ac97)	snd_ac97_cmute_new_stereo(card, name, reg, 0, ac97)
 
 static unsigned int snd_ac97_determine_spdif_rates(ac97_t *ac97);
 
@@ -1326,7 +1328,8 @@
 
 	/* build surround controls */
 	if (snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER)) {
-		if ((err = snd_ac97_cmix_new(card, "Surround Playback", AC97_SURROUND_MASTER, ac97)) < 0)
+		/* Surround Master (0x38) is with stereo mutes */
+		if ((err = snd_ac97_cmix_new_stereo(card, "Surround Playback", AC97_SURROUND_MASTER, 1, ac97)) < 0)
 			return err;
 	}
 

