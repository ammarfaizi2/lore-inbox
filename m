Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261655AbTCQMUf>; Mon, 17 Mar 2003 07:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCQMUf>; Mon, 17 Mar 2003 07:20:35 -0500
Received: from mail8.home.nl ([213.51.128.30]:7356 "EHLO mail8-sh.home.nl")
	by vger.kernel.org with ESMTP id <S261655AbTCQMUd>;
	Mon, 17 Mar 2003 07:20:33 -0500
Subject: Re: ALSA + mmap or OSS emulation + mmap producing stutering sound
From: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047904319.2797.4.camel@CC75757-A.groni1.gr.home.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-1mdk 
Date: 17 Mar 2003 13:32:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is due to a broken ALSA update patch for the cs46xx code.  Apply
>> the included patch which unbreaks the update.
>>
>> David
>>

>>dean . wrote:

This does not seem to be the case. The problems described below are 
replicable in 2.5.64-mm8 which has the suggested patch applied.

Luuk


 

> Kernel versions 2.5.61-64 (Havnt tried 60) produce stuttering sound 
> when using alsa and mmap (xmms alsa output plugin) or oss emu and mmap 
> (quake3?) produce stuttering sound happening after around the first 
> half second of playing. This is with the kernels alsa cs46xx module 
> and a Turtle beach Santa Cruz soundcard. Works fine with 2.5.59 though.


diff -Nru a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	Mon Feb 17 14:57:26 2003
+++ b/sound/pci/cs46xx/cs46xx_lib.c	Mon Feb 17 14:57:26 2003
@@ -677,6 +677,7 @@
 {
 	/* cs46xx_t *chip = snd_pcm_substream_chip(substream); */
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
 	snd_pcm_sframes_t diff;
 	cs46xx_pcm_t * cpcm;
 	int buffer_size;
@@ -685,14 +686,14 @@
 
 	buffer_size = runtime->period_size * CS46XX_FRAGS << cpcm->shift;
 
-	diff = runtime->control->appl_ptr - cpcm->appl_ptr;
+	diff = appl_ptr - cpcm->appl_ptr;
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
-		cpcm->sw_ready += diff << cpcm->shift;
+		frames += diff;
 	}
 	cpcm->sw_ready += frames << cpcm->shift;
-	cpcm->appl_ptr = runtime->control->appl_ptr + frames;
+	cpcm->appl_ptr = appl_ptr + frames;
 	while (cpcm->hw_ready < buffer_size && 
 	       cpcm->sw_ready > 0) {
 		size_t hw_to_end = buffer_size - cpcm->hw_data;
@@ -724,15 +725,16 @@
 {
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_pcm_sframes_t diff = runtime->control->appl_ptr - chip->capt.appl_ptr;
+	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
+	snd_pcm_sframes_t diff = appl_ptr - chip->capt.appl_ptr;
 	int buffer_size = runtime->period_size * CS46XX_FRAGS << chip->capt.shift;
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
-		chip->capt.sw_ready -= diff << chip->capt.shift;
+		frames += diff;
 	}
 	chip->capt.sw_ready -= frames << chip->capt.shift;
-	chip->capt.appl_ptr = runtime->control->appl_ptr + frames;
+	chip->capt.appl_ptr = appl_ptr + frames;
 	while (chip->capt.hw_ready > 0 && 
 	       chip->capt.sw_ready < (int)chip->capt.sw_bufsize) {
 		size_t hw_to_end = buffer_size - chip->capt.hw_data;


