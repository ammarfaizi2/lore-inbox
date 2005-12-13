Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVLMIci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVLMIci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVLMIch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:32:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:39555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932550AbVLMIYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:47 -0500
Date: Tue, 13 Dec 2005 00:23:35 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linville@tuxdriver.com, tiwai@suse.de
Subject: [patch 16/26] [ALSA] nm256: reset workaround for Latitude CSx
Message-ID: <20051213082335.GU5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nm256-reset-workaround-for-latitude-csx.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: John W. Linville <linville@tuxdriver.com>

Modules: NM256 driver

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index ebfa38b..d0da9a5 100644
---
 sound/pci/nm256/nm256.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- linux-2.6.14.3.orig/sound/pci/nm256/nm256.c
+++ linux-2.6.14.3/sound/pci/nm256/nm256.c
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

--
