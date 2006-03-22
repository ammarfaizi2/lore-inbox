Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWCVWMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCVWMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCVWMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:35 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:38805 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932099AbWCVWMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:32 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  4/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:28 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       George Talusan <gstalusan@uwaterloo.ca>, Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.28528.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/cmi8330.c
===================================================================
--- work-mm6.orig/sound/isa/cmi8330.c	2006-03-22 11:24:42.000000000 -0700
+++ work-mm6/sound/isa/cmi8330.c	2006-03-22 12:01:20.000000000 -0700
@@ -175,7 +175,7 @@
 #endif
 
 
-static struct ad1848_mix_elem snd_cmi8330_controls[] __initdata = {
+static struct ad1848_mix_elem snd_cmi8330_controls[] __devinitdata = {
 AD1848_DOUBLE("Master Playback Volume", 0, CMI8330_MASTVOL, CMI8330_MASTVOL, 4, 0, 15, 0),
 AD1848_SINGLE("Loud Playback Switch", 0, CMI8330_MUTEMUX, 6, 1, 1),
 AD1848_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
@@ -204,7 +204,7 @@
 };
 
 #ifdef ENABLE_SB_MIXER
-static struct sbmix_elem cmi8330_sb_mixers[] __initdata = {
+static struct sbmix_elem cmi8330_sb_mixers[] __devinitdata = {
 SB_DOUBLE("SB Master Playback Volume", SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31),
 SB_DOUBLE("Tone Control - Bass", SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
 SB_DOUBLE("Tone Control - Treble", SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15),
@@ -222,7 +222,7 @@
 SB_SINGLE("SB Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1),
 };
 
-static unsigned char cmi8330_sb_init_values[][2] __initdata = {
+static unsigned char cmi8330_sb_init_values[][2] __devinitdata = {
 	{ SB_DSP4_MASTER_DEV + 0, 0 },
 	{ SB_DSP4_MASTER_DEV + 1, 0 },
 	{ SB_DSP4_PCM_DEV + 0, 0 },
@@ -545,7 +545,7 @@
 	return snd_card_register(card);
 }
 
-static int __init snd_cmi8330_nonpnp_probe(struct platform_device *pdev)
+static int __devinit snd_cmi8330_nonpnp_probe(struct platform_device *pdev)
 {
 	struct snd_card *card;
 	int err;
@@ -607,6 +607,8 @@
 
 
 #ifdef CONFIG_PNP
+static unsigned int __devinitdata cmi8330_pnp_devices;
+
 static int __devinit snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
 {
@@ -636,6 +638,7 @@
 	}
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	cmi8330_pnp_devices++;
 	return 0;
 }
 
@@ -706,9 +709,9 @@
 
 #ifdef CONFIG_PNP
 	err = pnp_register_card_driver(&cmi8330_pnpc_driver);
-	if (err >= 0) {
+	if (!err) {
 		pnp_registered = 1;
-		cards += err;
+		cards += cmi8330_pnp_devices;
 	}
 #endif
 
