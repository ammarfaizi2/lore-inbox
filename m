Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUGVUB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUGVUB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUGVUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:01:57 -0400
Received: from av9-2-sn1.fre.skanova.net ([81.228.11.116]:26510 "EHLO
	av9-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267186AbUGVUBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:01:54 -0400
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: Problem with snd_atiixp in 2.6.8-rc2 (and a workaround)
From: Peter Osterlund <petero2@telia.com>
Date: 22 Jul 2004 22:01:49 +0200
Message-ID: <m37jsv3j6a.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_atiixp module in the 2.6.8-rc2 kernel doesn't work on my
Compaq Presario R3000 (R3057EA) computer. When I load the module,
the kernel reports:

ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -13

The reason it fails is that snd_ac97_mixer() fails for the second
codec (ie when i==1). The patch below makes my sound card work, but
that patch was just based on wild guesses and is probably not
correct.

lspci reports:

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller
        Subsystem: Hewlett-Packard Company: Unknown device 006b
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
        Memory at e8003000 (32-bit, non-prefetchable)

Any idea how to fix this the right way?

---

 linux-petero/sound/pci/atiixp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN sound/pci/atiixp.c~r3000-sound-workaround sound/pci/atiixp.c
--- linux/sound/pci/atiixp.c~r3000-sound-workaround	2004-07-22 21:41:18.804609120 +0200
+++ linux-petero/sound/pci/atiixp.c	2004-07-22 21:41:50.549783120 +0200
@@ -1387,12 +1387,13 @@ static int __devinit snd_atiixp_mixer_ne
 		ac97.num = i;
 		ac97.scaps = AC97_SCAP_SKIP_MODEM;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
-			if (chip->codec_not_ready_bits)
+			if (chip->codec_not_ready_bits) {
 				/* codec(s) was detected but not available.
 				 * return the error
 				 */
-				return err;
-			else {
+				chip->ac97[i] = NULL; /* to be sure */
+				continue;
+			} else {
 				/* codec(s) was NOT detected, so just ignore here */
 				chip->ac97[i] = NULL; /* to be sure */
 				snd_printd("atiixp: codec %d not found\n", i);
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
