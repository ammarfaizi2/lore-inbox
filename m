Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbRAAUY2>; Mon, 1 Jan 2001 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRAAUYS>; Mon, 1 Jan 2001 15:24:18 -0500
Received: from sm8.texas.rr.com ([24.93.35.220]:1809 "EHLO sm8.texas.rr.com")
	by vger.kernel.org with ESMTP id <S130349AbRAAUYC>;
	Mon, 1 Jan 2001 15:24:02 -0500
Message-ID: <3A50E0BC.ADD9BEDB@austin.rr.com>
Date: Mon, 01 Jan 2001 13:55:40 -0600
From: Anwar <anwar@austin.rr.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i810_audio.c in 2.4.0-prerelease (fixes RealPlayer for one)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch from Tjeerd Mulder that is already in 2.4.0-prerelease fixes a 
lot of issues with i810_audio, but it still does not seem to enable
variable rates 
(non 48K rates).  I am not sure if VRA works for everybody else with the
current
code, but I needed the patch below for VRA to work on my Dell Optiplex
GX110.

So the patch below specifically enables VRA during rate 
change requests (based on code from Jim Studt, posted to LKML on Dec
29).  This
is needed for things like Real Player to work , because the first thing
RealPlayer 
does is to set the DAC rate to 44100Hz.

Also, the patch already in 2.4.0.-prerelease introduced a bug in the
driver that we 
get a divide-by-zero error if we just do "fd=open("/dev/dsp", O_WRONLY)
; close (fd);".  
This is also fixed below (the last hunk).

--- linux/drivers/sound/i810_audio.c.old        Sat Dec 30 13:23:14 2000
+++ linux/drivers/sound/i810_audio.c    Mon Jan  1 13:24:36 2001
@@ -383,6 +383,7 @@
 {
        struct dmabuf *dmabuf = &state->dmabuf;
        u32 dacp;
+       u16 extended_status;
        struct ac97_codec *codec=state->card->ac97_codec[0];

        if(!(state->card->ac97_features&0x0001))
@@ -410,6 +411,10 @@

        if(rate != i810_ac97_get(codec, AC97_PCM_FRONT_DAC_RATE))
        {
+               /* Reset variable rate mode */
+               extended_status = i810_ac97_get(codec,
AC97_EXTENDED_STATUS);
                i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0200);
@@ -433,6 +438,7 @@
 {
        struct dmabuf *dmabuf = &state->dmabuf;
        u32 dacp;
+       u16 extended_status;
        struct ac97_codec *codec=state->card->ac97_codec[0];
 
        if(!(state->card->ac97_features&0x0001))
@@ -460,6 +466,10 @@
 
        if(rate != i810_ac97_get(codec, AC97_PCM_LR_DAC_RATE))
        {
+               /* Reset variable rate mode */
+               extended_status = i810_ac97_get(codec,
AC97_EXTENDED_STATUS);
+               if (!(extended_status&1))
+                       i810_ac97_set(codec, AC97_EXTENDED_STATUS,
extended_status|1);
                /* Power down the ADC */
                dacp=i810_ac97_get(codec, AC97_POWER_CONTROL);
                i810_ac97_set(codec, AC97_POWER_CONTROL, dacp|0x0100);
@@ -770,7 +780,10 @@
        swptr = dmabuf->swptr;
        spin_unlock_irqrestore(&state->card->lock, flags);
 
-       len = swptr % (dmabuf->dmasize/SG_LEN);
+       if (dmabuf->dmasize)
+               len = swptr % (dmabuf->dmasize/SG_LEN);
+       else
+               len = 0;
 
        memset(dmabuf->rawbuf + swptr, silence, len);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
