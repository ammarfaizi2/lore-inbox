Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVDLUSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVDLUSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVDLUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:16:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:25288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262138AbVDLKba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:30 -0400
Message-Id: <200504121031.j3CAVNe2005304@shell0.pdx.osdl.net>
Subject: [patch 045/198] pmac: sound support for latest laptops
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch hacks the current Alsa snd-powermac driver to add support for
recent machine models with the tas3004 chip, that is basically new laptop
models.  The Mac Mini is _NOT_ yet supported by this patch (soon soon ...).
 The G5s (iMac or Desktop) will need the rewritten sound driver on which
I'm working on (I _might_ get a hack for analog only on some G5s on the
current driver, but no promise).

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/ppc/pmac.c    |   26 +++++++++++++++++++-----
 25-akpm/sound/ppc/tumbler.c |   46 +++++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff -puN sound/ppc/pmac.c~pmac-sound-support-for-latest-laptops sound/ppc/pmac.c
--- 25/sound/ppc/pmac.c~pmac-sound-support-for-latest-laptops	2005-04-12 03:21:14.213976048 -0700
+++ 25-akpm/sound/ppc/pmac.c	2005-04-12 03:21:14.219975136 -0700
@@ -881,6 +881,7 @@ static int __init snd_pmac_detect(pmac_t
 {
 	struct device_node *sound;
 	unsigned int *prop, l;
+	u32 layout_id = 0;
 
 	if (_machine != _MACH_Pmac)
 		return -ENODEV;
@@ -929,6 +930,9 @@ static int __init snd_pmac_detect(pmac_t
 	prop = (unsigned int *) get_property(sound, "sub-frame", NULL);
 	if (prop && *prop < 16)
 		chip->subframe = *prop;
+	prop = (unsigned int *) get_property(sound, "layout-id", NULL);
+	if (prop)
+		layout_id = *prop;
 	/* This should be verified on older screamers */
 	if (device_is_compatible(sound, "screamer")) {
 		chip->model = PMAC_SCREAMER;
@@ -961,12 +965,22 @@ static int __init snd_pmac_detect(pmac_t
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "AOAKeylargo")) {
-		/* Seems to support the stock AWACS frequencies, but has
-		   a snapper mixer */
-		chip->model = PMAC_SNAPPER;
-		// chip->can_byte_swap = 0; /* FIXME: check this */
-		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
+	if (device_is_compatible(sound, "AOAKeylargo") ||
+	    device_is_compatible(sound, "AOAbase")) {
+		/* For now, only support very basic TAS3004 based machines with
+		 * single frequency until proper i2s control is implemented
+		 */
+		switch(layout_id) {
+		case 0x48:
+		case 0x46:
+		case 0x33:
+		case 0x29:
+			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
+			chip->model = PMAC_SNAPPER;
+			chip->can_byte_swap = 0; /* FIXME: check this */
+			chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
+			break;
+		}
 	}
 	prop = (unsigned int *)get_property(sound, "device-id", NULL);
 	if (prop)
diff -puN sound/ppc/tumbler.c~pmac-sound-support-for-latest-laptops sound/ppc/tumbler.c
--- 25/sound/ppc/tumbler.c~pmac-sound-support-for-latest-laptops	2005-04-12 03:21:14.215975744 -0700
+++ 25-akpm/sound/ppc/tumbler.c	2005-04-12 03:21:14.220974984 -0700
@@ -37,6 +37,8 @@
 #include <asm/irq.h>
 #ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 #include <asm/pmac_feature.h>
+#else
+#error old crap
 #endif
 #include "pmac.h"
 #include "tumbler_volume.h"
@@ -950,10 +952,10 @@ static struct device_node *find_compatib
 }
 
 /* find an audio device and get its address */
-static unsigned long tumbler_find_device(const char *device, pmac_gpio_t *gp, int is_compatible)
+static long tumbler_find_device(const char *device, pmac_gpio_t *gp, int is_compatible)
 {
 	struct device_node *node;
-	u32 *base;
+	u32 *base, addr;
 
 	if (is_compatible)
 		node = find_compatible_audio_device(device);
@@ -966,21 +968,31 @@ static unsigned long tumbler_find_device
 
 	base = (u32 *)get_property(node, "AAPL,address", NULL);
 	if (! base) {
-		snd_printd("cannot find address for device %s\n", device);
-		return -ENODEV;
-	}
+		base = (u32 *)get_property(node, "reg", NULL);
+		if (!base) {
+			snd_printd("cannot find address for device %s\n", device);
+			return -ENODEV;
+		}
+		/* this only work if PPC_HAS_FEATURE_CALLS is set as we
+		 * are only getting the low part of the address
+		 */
+		addr = *base;
+		if (addr < 0x50)
+			addr += 0x50;
+	} else
+		addr = *base;
 
 #ifdef CONFIG_PPC_HAS_FEATURE_CALLS
-	gp->addr = (*base) & 0x0000ffff;
+	gp->addr = addr & 0x0000ffff;
 #else
-	gp->addr = ioremap((unsigned long)(*base), 1);
+	gp->addr = ioremap((unsigned long)addr, 1);
 #endif
+	/* Try to find the active state, default to 0 ! */
 	base = (u32 *)get_property(node, "audio-gpio-active-state", NULL);
 	if (base)
 		gp->active_state = *base;
 	else
-		gp->active_state = 1;
-
+		gp->active_state = 0;
 
 	return (node->n_intrs > 0) ? node->intrs[0].line : 0;
 }
@@ -1039,11 +1051,16 @@ static int __init tumbler_init(pmac_t *c
 	pmac_tumbler_t *mix = chip->mixer_data;
 	snd_assert(mix, return -EINVAL);
 
-	tumbler_find_device("audio-hw-reset", &mix->audio_reset, 0);
-	tumbler_find_device("amp-mute", &mix->amp_mute, 0);
-	tumbler_find_device("headphone-mute", &mix->hp_mute, 0);
+	if (tumbler_find_device("audio-hw-reset", &mix->audio_reset, 0) < 0)
+		tumbler_find_device("hw-reset", &mix->audio_reset, 1);
+	if (tumbler_find_device("amp-mute", &mix->amp_mute, 0) < 0)
+		tumbler_find_device("amp-mute", &mix->amp_mute, 1);
+	if (tumbler_find_device("headphone-mute", &mix->hp_mute, 0) < 0)
+		tumbler_find_device("headphone-mute", &mix->hp_mute, 1);
 	irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 0);
 	if (irq < 0)
+		irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 1);
+	if (irq < 0)
 		irq = tumbler_find_device("keywest-gpio15", &mix->hp_detect, 1);
 
 	tumbler_reset_audio(chip);
@@ -1109,9 +1126,13 @@ int __init snd_pmac_tumbler_init(pmac_t 
 	/* set up TAS */
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
+		tas_node = find_devices("codec");
+	if (tas_node == NULL)
 		return -ENODEV;
 
 	paddr = (u32 *)get_property(tas_node, "i2c-address", NULL);
+	if (paddr == NULL)
+		paddr = (u32 *)get_property(tas_node, "reg", NULL);
 	if (paddr)
 		mix->i2c.addr = (*paddr) >> 1;
 	else
@@ -1156,7 +1177,6 @@ int __init snd_pmac_tumbler_init(pmac_t 
 	if ((err = snd_ctl_add(chip->card, chip->drc_sw_ctl)) < 0)
 		return err;
 
-
 #ifdef CONFIG_PMAC_PBOOK
 	chip->resume = tumbler_resume;
 #endif
_
