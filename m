Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVAIRQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVAIRQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 12:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVAIRQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 12:16:56 -0500
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:10555 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261652AbVAIRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 12:16:20 -0500
Message-ID: <41E166F9.3070506@ens-lyon.fr>
Date: Sun, 09 Jan 2005 18:16:41 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041221
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac8
Content-Type: multipart/mixed;
 boundary="------------040100020409070206040904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040100020409070206040904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm experiencing some troubles with the patches you included in
2.6.10-ac5 about ALSA : the files open and play ok, but no sound is
actually outputed...

I've found that the patch sound/pci/ac97/ac97_patch.c (hereby
attached) is responsible for that (ie when I boot with the full patch 
minus this one, the sound is ok).

Nothing special is printed in dmesg, so I've only attached my lspci 
output and my .config (along with the patch).

Feel free to CC me if more details are needed, for I'm not on the lkml.

Regards,

Jules


--------------040100020409070206040904
Content-Type: text/plain;
 name="patch.ac97_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.ac97_patch"

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/sound/pci/ac97/ac97_patch.c linux-2.6.10/sound/pci/ac97/ac97_patch.c
--- linux.vanilla-2.6.10/sound/pci/ac97/ac97_patch.c	2004-12-25 21:15:54.000000000 +0000
+++ linux-2.6.10/sound/pci/ac97/ac97_patch.c	2005-01-06 19:29:28.000000000 +0000
@@ -1013,8 +1013,20 @@
  	return patch_build_controls(ac97, &snd_ac97_ad198x_spdif_source, 1);
 }
 
+static const snd_kcontrol_new_t snd_ac97_ad1981x_jack_sense[] = {
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 11, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0),
+};
+
+static int patch_ad1981a_specific(ac97_t * ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_ad1981x_jack_sense,
+				    ARRAY_SIZE(snd_ac97_ad1981x_jack_sense));
+}
+
 static struct snd_ac97_build_ops patch_ad1981a_build_ops = {
-	.build_post_spdif = patch_ad198x_post_spdif
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1981a_specific
 };
 
 int patch_ad1981a(ac97_t *ac97)
@@ -1023,6 +1035,7 @@
 	ac97->build_ops = &patch_ad1981a_build_ops;
 	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
 	ac97->flags |= AC97_STEREO_MUTES;
+	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
 	return 0;
 }
 
@@ -1031,7 +1044,12 @@
 
 static int patch_ad1981b_specific(ac97_t *ac97)
 {
-	return patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1);
+	int err;
+
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
+		return err;
+	return patch_build_controls(ac97, snd_ac97_ad1981x_jack_sense,
+				    ARRAY_SIZE(snd_ac97_ad1981x_jack_sense));
 }
 
 static struct snd_ac97_build_ops patch_ad1981b_build_ops = {
@@ -1045,6 +1063,7 @@
 	ac97->build_ops = &patch_ad1981b_build_ops;
 	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
 	ac97->flags |= AC97_STEREO_MUTES;
+	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
 	return 0;
 }
 


--------------040100020409070206040904
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
02:02.0 Network controller: Intel Corp.: Unknown device 4220 (rev 05)

--------------040100020409070206040904
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------040100020409070206040904--
