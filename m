Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbVKXFvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVKXFvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbVKXFvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:51:00 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:7572 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161009AbVKXFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:50:59 -0500
Date: Thu, 24 Nov 2005 05:50:54 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add new quirk for devices with mute LEDs and separate headphone volume
Message-ID: <20051124055053.GD28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new quirk for ac97 hardware that combines the existing 
AC97_TUNE_MUTE_LED and AC97_TUNE_HP_ONLY quirks. This is needed for 
several current HP laptops. Additionally, it adds the HP nx6125 to the 
AC97_TUNE_MUTE_LED list.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- a/sound/pci/atiixp.c.orig	2005-09-16 15:38:21 +0100
+++ b/sound/pci/atiixp.c	2005-09-16 15:38:59 +0100
@@ -1339,6 +1339,12 @@
 		.name = "HP Pavilion ZV5030US",
 		.type = AC97_TUNE_MUTE_LED
 	},
+	{
+		.subvendor = 0x103c,
+		.subdevice = 0x308b,
+		.name = "HP nx6125",
+		.type = AC97_TUNE_MUTE_LED
+	},
 	{ } /* terminator */
 };
 
--- a/sound/pci/intel8x0.c.orig	2005-09-16 15:34:18 +0100
+++ b/sound/pci/intel8x0.c	2005-09-16 15:37:13 +0100
@@ -1822,6 +1822,30 @@
 	},
 	{
 		.subvendor = 0x103c,
+		.subdevice = 0x0938,
+		.name = "HP nc4200",
+		.type = AC97_TUNE_HP_MUTE_LED
+	},
+	{
+		.subvendor = 0x103c,
+		.subdevice = 0x099c,
+		.name = "HP nc6120",
+		.type = AC97_TUNE_HP_MUTE_LED
+	},
+	{
+		.subvendor = 0x103c,
+		.subdevice = 0x0944,
+		.name = "HP nc6220",
+		.type = AC97_TUNE_HP_MUTE_LED
+	},
+	{
+		.subvendor = 0x103c,
+		.subdevice = 0x0934,
+		.name = "HP nc8220",
+		.type = AC97_TUNE_HP_MUTE_LED
+	},
+	{
+		.subvendor = 0x103c,
 		.subdevice = 0x12f1,
 		.name = "HP xw8200",	/* AD1981B*/
 		.type = AC97_TUNE_HP_ONLY
--- a/include/sound/ac97_codec.h.orig	2005-09-15 19:05:14.000000000 +0100
+++ b/include/sound/ac97_codec.h	2005-09-15 19:05:47.000000000 +0100
@@ -570,6 +570,7 @@
 	AC97_TUNE_ALC_JACK,	/* for Realtek, enable JACK detection */
 	AC97_TUNE_INV_EAPD,	/* inverted EAPD implementation */
 	AC97_TUNE_MUTE_LED,	/* EAPD bit works as mute LED */
+	AC97_TUNE_HP_MUTE_LED,  /* EAPD bit works as mute LED, use headphone control as master */
 };
 
 struct ac97_quirk {
--- a/sound/pci/ac97/ac97_codec.c.orig	2005-09-15 21:25:24.000000000 +0100
+++ b/sound/pci/ac97/ac97_codec.c	2005-09-15 19:09:55.000000000 +0100
@@ -2470,6 +2470,40 @@
 	return 0;
 }
 
+static int hp_master_mute_sw_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	int err = bind_hp_volsw_put(kcontrol, ucontrol);
+	if (err > 0) {
+		ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+		int shift = (kcontrol->private_value >> 8) & 0x0f;
+		int rshift = (kcontrol->private_value >> 12) & 0x0f;
+		unsigned short mask;
+		if (shift != rshift)
+			mask = 0x8080;
+		else
+			mask = 0x8000;
+		snd_ac97_update_bits(ac97, AC97_POWERDOWN, 0x8000,
+				     (ac97->regs[AC97_MASTER] & mask) == mask ?
+				     0x8000 : 0);
+	}
+	return err;
+}
+
+static int tune_hp_mute_led(ac97_t *ac97)
+{
+	snd_kcontrol_t *msw = ctl_find(ac97, "Master Playback Switch", NULL);
+	snd_kcontrol_t *mvol = ctl_find(ac97, "Master Playback Volume", NULL);
+	if (! msw || ! mvol)
+		return -ENOENT;
+	msw->put = hp_master_mute_sw_put;
+	mvol->put = bind_hp_volsw_put;
+	snd_ac97_remove_ctl(ac97, "External Amplifier", NULL);
+	snd_ac97_remove_ctl(ac97, "Headphone Playback", "Switch");
+	snd_ac97_remove_ctl(ac97, "Headphone Playback", "Volume");
+	snd_ac97_update_bits(ac97, AC97_POWERDOWN, 0x8000, 0x8000); /* mute LED on */
+	return 0;
+}
+
 struct quirk_table {
 	const char *name;
 	int (*func)(ac97_t *);
@@ -2484,6 +2518,7 @@
 	{ "alc_jack", tune_alc_jack },
 	{ "inv_eapd", tune_inv_eapd },
 	{ "mute_led", tune_mute_led },
+	{ "hp_mute_led", tune_hp_mute_led },
 };
 
 /* apply the quirk with the given type */

-- 
Matthew Garrett | mjg59@srcf.ucam.org
