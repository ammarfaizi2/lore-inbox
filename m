Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVJSBfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVJSBfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVJSBfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:35:08 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:5380 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932452AbVJSBeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:34:05 -0400
Date: Tue, 18 Oct 2005 21:31:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
Subject: [patch 2.6.14-rc4] nm256: reset workaround for Latitude CSx
Message-ID: <10182005213102.13024@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current snd-nm256 driver can cause Dell Latitude CSx laptops to
lock-up during module (un)load.  I have isolated this to the writes to
the control port register at offset 0x6cc which were not already
protected by the existing reset_workaround.

I tried grouping these writes with the existing reset_workaround
clause, but that caused the driver to have (un)load problems on the
Dell Latitude LS laptops.  So, I have implemented a reset_workaround_2
clause (please feel free to suggest a better name!) to cover this
situation and added a quirk entry for the CSx laptops.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/nm256/nm256.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -62,6 +62,7 @@ static int buffer_top[SNDRV_CARDS] = {[0
 static int use_cache[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0}; /* disabled */
 static int vaio_hack[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0}; /* disabled */
 static int reset_workaround[SNDRV_CARDS];
+static int reset_workaround_2[SNDRV_CARDS];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
@@ -83,6 +84,8 @@ module_param_array(vaio_hack, bool, NULL
 MODULE_PARM_DESC(vaio_hack, "Enable workaround for Sony VAIO notebooks.");
 module_param_array(reset_workaround, bool, NULL, 0444);
 MODULE_PARM_DESC(reset_workaround, "Enable AC97 RESET workaround for some laptops.");
+module_param_array(reset_workaround_2, bool, NULL, 0444);
+MODULE_PARM_DESC(reset_workaround_2, "Enable extended AC97 RESET workaround for some other laptops.");
 
 /*
  * hw definitions
@@ -226,6 +229,7 @@ struct snd_nm256 {
 	unsigned int coeffs_current: 1;	/* coeff. table is loaded? */
 	unsigned int use_cache: 1;	/* use one big coef. table */
 	unsigned int reset_workaround: 1; /* Workaround for some laptops to avoid freeze */
+	unsigned int reset_workaround_2: 1; /* Extended workaround for some other laptops to avoid freeze */
 
 	int mixer_base;			/* register offset of ac97 mixer */
 	int mixer_status_offset;	/* offset of mixer status reg. */
@@ -1199,8 +1203,11 @@ snd_nm256_ac97_reset(ac97_t *ac97)
 		/* Dell latitude LS will lock up by this */
 		snd_nm256_writeb(chip, 0x6cc, 0x87);
 	}
-	snd_nm256_writeb(chip, 0x6cc, 0x80);
-	snd_nm256_writeb(chip, 0x6cc, 0x0);
+	if (! chip->reset_workaround_2) {
+		/* Dell latitude CSx will lock up by this */
+		snd_nm256_writeb(chip, 0x6cc, 0x80);
+		snd_nm256_writeb(chip, 0x6cc, 0x0);
+	}
 }
 
 /* create an ac97 mixer interface */
@@ -1542,7 +1549,7 @@ struct nm256_quirk {
 	int type;
 };
 
-enum { NM_BLACKLISTED, NM_RESET_WORKAROUND };
+enum { NM_BLACKLISTED, NM_RESET_WORKAROUND, NM_RESET_WORKAROUND_2 };
 
 static struct nm256_quirk nm256_quirks[] __devinitdata = {
 	/* HP omnibook 4150 has cs4232 codec internally */
@@ -1551,6 +1558,8 @@ static struct nm256_quirk nm256_quirks[]
 	{ .vendor = 0x104d, .device = 0x8041, .type = NM_RESET_WORKAROUND },
 	/* Dell Latitude LS */
 	{ .vendor = 0x1028, .device = 0x0080, .type = NM_RESET_WORKAROUND },
+	/* Dell Latitude CSx */
+	{ .vendor = 0x1028, .device = 0x0091, .type = NM_RESET_WORKAROUND_2 },
 	{ } /* terminator */
 };
 
@@ -1582,6 +1591,9 @@ static int __devinit snd_nm256_probe(str
 			case NM_BLACKLISTED:
 				printk(KERN_INFO "nm256: The device is blacklisted.  Loading stopped\n");
 				return -ENODEV;
+			case NM_RESET_WORKAROUND_2:
+				reset_workaround_2[dev] = 1;
+				/* Fall-through */
 			case NM_RESET_WORKAROUND:
 				reset_workaround[dev] = 1;
 				break;
@@ -1638,6 +1650,11 @@ static int __devinit snd_nm256_probe(str
 		chip->reset_workaround = 1;
 	}
 
+	if (reset_workaround_2[dev]) {
+		snd_printdd(KERN_INFO "nm256: reset_workaround_2 activated\n");
+		chip->reset_workaround_2 = 1;
+	}
+
 	if ((err = snd_nm256_pcm(chip, 0)) < 0 ||
 	    (err = snd_nm256_mixer(chip)) < 0) {
 		snd_card_free(card);
