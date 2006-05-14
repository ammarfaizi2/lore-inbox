Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWENCUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWENCUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 22:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWENCT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 22:19:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:9148 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932350AbWENCT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 22:19:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GMDuxg8CqrEHRnrzP8P8xZ84T+jTtQpBAKQ82I2XXifvzDRY9GnTD/ZZcLw4nRdtFnRa7mWpkWPSBl3ox4X/mnf+PfyFR7g5ryspCqUksvsQgqIbC6IA3MZWfvOBrIiI8EzXRDqoXuuxYP8EVeaMmLbV88RE8TNMW5jZOPH1sqA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential NULL pointer deref in snd_sb8dsp_midi_interrupt()
Date: Sun, 14 May 2006 04:20:52 +0200
User-Agent: KMail/1.9.1
Cc: perex@suse.cz, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140420.52710.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First testing if a pointer is NULL and if it is (or might be), proceeding
with code that dereferences that same pointer is clearly a mistake.
This happens in sound/isa/sb/sb8_midi.c::snd_sb8dsp_midi_interrupt()
The patch below reworks the code so this unfortunate case doesn't happen.
Also remove some blank comments.

Found by the Coverity checker as bug #367

Patch is compile testted only due to lack of hardware.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/isa/sb/sb8_midi.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)


--- linux-2.6.17-rc4-git2-orig/sound/isa/sb/sb8_midi.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4-git2/sound/isa/sb/sb8_midi.c	2006-05-14 04:12:33.000000000 +0200
@@ -32,20 +32,22 @@
 #include <sound/core.h>
 #include <sound/sb.h>
 
-/*
 
- */
-
-irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb * chip)
+irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb *chip)
 {
 	struct snd_rawmidi *rmidi;
 	int max = 64;
 	char byte;
 
-	if (chip == NULL || (rmidi = chip->rmidi) == NULL) {
+	if (!chip)
+		return IRQ_NONE;
+	
+	rmidi = chip->rmidi;
+	if (!rmidi) {
 		inb(SBP(chip, DATA_AVAIL));	/* ack interrupt */
 		return IRQ_NONE;
 	}
+
 	spin_lock(&chip->midi_input_lock);
 	while (max-- > 0) {
 		if (inb(SBP(chip, DATA_AVAIL)) & 0x80) {
@@ -59,10 +61,6 @@ irqreturn_t snd_sb8dsp_midi_interrupt(st
 	return IRQ_HANDLED;
 }
 
-/*
-
- */
-
 static int snd_sb8dsp_midi_input_open(struct snd_rawmidi_substream *substream)
 {
 	unsigned long flags;
@@ -252,10 +250,6 @@ static void snd_sb8dsp_midi_output_trigg
 		snd_sb8dsp_midi_output_write(substream);
 }
 
-/*
-
- */
-
 static struct snd_rawmidi_ops snd_sb8dsp_midi_output =
 {
 	.open =		snd_sb8dsp_midi_output_open,


