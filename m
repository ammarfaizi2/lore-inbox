Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUBCA5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbUBCA5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:57:46 -0500
Received: from mail.onairusa.com ([64.2.100.242]:24570 "EHLO
	host21.onairusa.com") by vger.kernel.org with ESMTP id S265502AbUBCA5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:57:19 -0500
Message-Id: <200402030057.i130v763003677@host21.onairusa.com>
Subject: [PATCH] es1371.c - 8 bit stereo (kernel version 2.4.24)
To: sailer@ife.ee.ethz.ch
Date: Mon, 2 Feb 2004 18:57:06 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, pcervasio@onairusa.com (Pete Cervasio)
Reply-To: bnelson@onairusa.com
From: "Bob Nelson" <bnelson@onairusa.com>
X-Mailer: Elm 2.5 PL3 running on Linux 2.4.20
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: Thomas Sailer <sailer@ife.ee.ethz.ch>
    cc: Pete Cervasio <pcervasio@onairusa.com>
        <linux-kernel@vger.kernel.org>
Fr: Bob Nelson <bnelson@onairusa.com>
Dt: 2 February 2004
Re: [PATCH] es1371.c - 8 bit stereo (kernel version 2.4.24)

This patch for ``es1371.c'' corrects an obscure condition -- but one that
can be readily replicated.

Pre-conditions
--------------

0). An Ensoniq ES-1371 sound card (or a variant thereof) must be
    installed with the ``es1371'' module loaded.

1). An 8-bit PCM audio file recorded at a sampling rate of 44100 Hz
    in stereo.

2). The key to duplicating the error is to ensure that the audio is
    recorded ONLY on the left channel. The right channel must be
    silent.

Duplication of problem
----------------------

0). Play the audio file described above (using ``sox'', for example)
    through /dev/dsp0. The result will be a ``buzzing'' sound as
    the audio plays. Furthermore, the audio will be heard on both the
    left and right channels, in spite of the audio file having been
    recorded with audio on only the left channel.

1). Play that same audio file through /dev/dsp1. Through this DSP, the
    audio will NOT have the ``buzzing'' sound and it will be audible
    on just the left channel, as expected.

Rationale for the patch
-----------------------

Although the code in the ``es1371.c'' source is not lavishly commented,
it appears that the intent of the author is to use 1 as the operand
of the shift for 8-bit audio. However, the original code does not take
into account ``SCTRL_P2SMB'', 8-bit stereo. The patch results in 1 being
used as the operand for any 8-bit audio file, stereo or mono.

* The patch itself (using stock sources from kernel 2.4.24):

--- drivers/sound/es1371.c-orig	2004-02-02 18:38:00.000000000 -0600
+++ drivers/sound/es1371.c	2004-02-02 18:38:58.000000000 -0600
@@ -841,9 +841,14 @@
 	if (!(s->ctrl & CTRL_DAC2_EN) && (s->dma_dac2.mapped || s->dma_dac2.count > 0)
 	    && s->dma_dac2.ready) {
 		s->ctrl |= CTRL_DAC2_EN;
-		s->sctrl = (s->sctrl & ~(SCTRL_P2LOOPSEL | SCTRL_P2PAUSE | SCTRL_P2DACSEN | 
+		/*
+		 * 28 JAN 2004: [bnelson@onairusa.com] - Modified to use 1 as left
+		 * shift operand of SCTRL_SH_P2ENDINC for any 8-bit file, stereo and
+		 * mono. Eliminates buzz on playback under certain conditions.
+		 */
+		s->sctrl = (s->sctrl & ~(SCTRL_P2LOOPSEL | SCTRL_P2PAUSE | SCTRL_P2DACSEN |
 					 SCTRL_P2ENDINC | SCTRL_P2STINC)) | SCTRL_P2INTEN |
-			(((s->sctrl & SCTRL_P2FMT) ? 2 : 1) << SCTRL_SH_P2ENDINC) | 
+			((((s->sctrl & SCTRL_P2FMT) > 0x04) ? 2 : 1) << SCTRL_SH_P2ENDINC) |
 			(0 << SCTRL_SH_P2STINC);
 		outl(s->sctrl, s->io+ES1371_REG_SERIAL_CONTROL);
 		fragremain = ((- s->dma_dac2.hwptr) & (s->dma_dac2.fragsize-1));



