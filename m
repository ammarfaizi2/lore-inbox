Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTKBOQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 09:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTKBOQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 09:16:25 -0500
Received: from mout2.freenet.de ([194.97.50.155]:8919 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261699AbTKBOQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 09:16:22 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: alsa-devel@alsa-project.org
Subject: [2.6.0-test9 ALSA] ALSA-OSS-emulation unable to register
Date: Sun, 2 Nov 2003 15:01:53 +0100
User-Agent: KMail/1.5.4
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311021458.59759.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

ALSA work's fine for me, but the OSS emulation layer doesn't work.
My configuration is:

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_ENS1371=y
# OSS options
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_BT878=y
CONFIG_SOUND_TVMIXER=y
All other sound options are disabled.
It's a SoundBlaster 128 PCI card.

I've applied the attached patch to display more meaningful
error-messages.

Kernel-log messages are:
Nov  2 15:59:27 lfs kernel: Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Nov  2 15:59:27 lfs kernel: request_module: failed /sbin/modprobe -- snd-card-0. error = -16
* Nov  2 15:59:27 lfs kernel: register1 failed: 35
Nov  2 15:59:27 lfs kernel: ALSA sound/core/oss/pcm_oss.c:2353: unable to register OSS PCM device 0:0
* Nov  2 15:59:27 lfs kernel: ALSA sound/core/oss/pcm_oss.c:2354: error code: -16 == -EBUSY
* Nov  2 15:59:27 lfs kernel: register1 failed: 32
Nov  2 15:59:27 lfs kernel: ALSA sound/core/oss/mixer_oss.c:1210: unable to register OSS mixer device 0:0
Nov  2 15:59:27 lfs kernel: ALSA device list:
Nov  2 15:59:27 lfs kernel:   #0: Ensoniq AudioPCI ENS1371 at 0xb800, irq 19

Lines marked with a * at the beginning are from my patch.

The failed request_module() seems to be triggered by
if (!system_running)
		return -EBUSY;
in call_usermodehelper() which is called by request_module().

Why are we trying to load a module, althought ALSA is completely
compiled into the kernel? We shouldn't do it, should we?

OSS-emulation failes, because something is -EBUSY.
==> ALSA sound/core/oss/pcm_oss.c:2354: error code: -16 == -EBUSY
I've not found out, why it fails. Maybe someone has an idea?

Here's my patch:

diff -urN -X /home/mb/dontdiff linux-2.6.0-test9/sound/core.orig/oss/pcm_oss.c linux-2.6.0-test9/sound/core/oss/pcm_oss.c
- --- linux-2.6.0-test9/sound/core.orig/oss/pcm_oss.c	2003-11-02 14:32:35.000000000 +0100
+++ linux-2.6.0-test9/sound/core/oss/pcm_oss.c	2003-11-02 13:20:49.000000000 +0100
@@ -2343,12 +2343,21 @@

 static void register_oss_dsp(snd_pcm_t *pcm, int index)
 {
+	int ret;
 	char name[128];
 	sprintf(name, "dsp%i%i", pcm->card->number, pcm->device);
- -	if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_PCM,
+	ret = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_PCM,
 				    pcm->card, index, &snd_pcm_oss_reg,
- -				    name) < 0) {
+				    name);
+	if (ret < 0) {
 		snd_printk("unable to register OSS PCM device %i:%i\n", pcm->card->number, pcm->device);
+		snd_printk("error code: %i ", ret);
+		if (ret == -ENOMEM)
+			printk("== -ENOMEM\n");
+		else if (ret == -EBUSY)
+			printk("== -EBUSY\n");
+		else
+			printk("== unknown\n");
 	}
 }

diff -urN -X /home/mb/dontdiff linux-2.6.0-test9/sound/core.orig/sound_oss.c linux-2.6.0-test9/sound/core/sound_oss.c
- --- linux-2.6.0-test9/sound/core.orig/sound_oss.c	2003-11-02 14:31:57.000000000 +0100
+++ linux-2.6.0-test9/sound/core/sound_oss.c	2003-11-02 13:57:17.000000000 +0100
@@ -122,12 +122,16 @@
 		break;
 	}
 	register1 = register_sound_special(reg->f_ops, minor);
- -	if (register1 != minor)
+	if (register1 != minor) {
+		printk("register1 failed: %i\n", register1);
 		goto __end;
+	}
 	if (track2 >= 0) {
 		register2 = register_sound_special(reg->f_ops, track2);
- -		if (register2 != track2)
+		if (register2 != track2) {
+			printk("register2 failed: %i\n", register2);
 			goto __end;
+		}
 	}
 	up(&sound_oss_mutex);
 	return 0;

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/pQ5RoxoigfggmSgRAotoAJwPqKatKtf2X+CeLKQOhyDlpXrPiACdFM7Q
a7bOrRMTgjmhHd70fi1C8l0=
=8kOI
-----END PGP SIGNATURE-----


