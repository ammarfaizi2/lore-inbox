Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbTCOX7v>; Sat, 15 Mar 2003 18:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbTCOX7u>; Sat, 15 Mar 2003 18:59:50 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:19664 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S261635AbTCOX7t>; Sat, 15 Mar 2003 18:59:49 -0500
Message-ID: <3E73C0F9.3000203@blue-labs.org>
Date: Sat, 15 Mar 2003 19:10:33 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030307
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "dean ." <ioooioiiooi@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ALSA + mmap or OSS emulation + mmap producing stutering sound
References: <F18MhvqgStMVhEUsebm00002883@hotmail.com>
In-Reply-To: <F18MhvqgStMVhEUsebm00002883@hotmail.com>
Content-Type: multipart/mixed;
 boundary="------------090806060609050402040104"
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 912; timestamp 2003-03-16 00:10:38, message serial number 797013
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806060609050402040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is due to a broken ALSA update patch for the cs46xx code.  Apply 
the included patch which unbreaks the update.

David

dean . wrote:

> Kernel versions 2.5.61-64 (Havnt tried 60) produce stuttering sound 
> when using alsa and mmap (xmms alsa output plugin) or oss emu and mmap 
> (quake3?) produce stuttering sound happening after around the first 
> half second of playing. This is with the kernels alsa cs46xx module 
> and a Turtle beach Santa Cruz soundcard. Works fine with 2.5.59 though.


--------------090806060609050402040104
Content-Type: text/plain;
 name="cs46.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46.patch"

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

--------------090806060609050402040104--

