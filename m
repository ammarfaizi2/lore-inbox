Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUBKUL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUBKUL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:11:27 -0500
Received: from proxy.quengel.org ([213.146.113.159]:31873 "EHLO
	gerlin1.hsp-law.de") by vger.kernel.org with ESMTP id S265848AbUBKULR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:11:17 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
	<4029143B.30408@vision.ee> <s5hvfmebvr4.wl@alsa2.suse.de>
	<m3hdxyyar8.fsf-news@hsp-law.de>
	<Pine.LNX.4.58.0402101221210.2128@home.osdl.org>
	<m34qtyslrk.fsf-news@hsp-law.de> <s5hsmhhc2yh.wl@alsa2.suse.de>
From: Ralf Gerbig <rge@quengel.org>
Date: 11 Feb 2004 21:11:08 +0100
In-Reply-To: <s5hsmhhc2yh.wl@alsa2.suse.de>
Message-ID: <m3hdxx5qcj.fsf-news@hsp-law.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

* On Wed, 11 Feb 2004 11:42:14 +0100, Takashi Iwai <tiwai@suse.de> said:

> Ralf Gerbig wrote:

>> * Linus Torvalds said:
>> 
>> > Can you add something like
>> 
>> > 	static int count = 10;
>> > 	if (count) {
>> > 		count--;
>> > 		printk("sound status = %08x (mask %08x)\n", 
>> > 			status, chip->int_sta_mask);
>> > 	}
>> 
>> > to just before the return?
>> 
>> > That should tell what the register contents are, and might be a clue
>> > about what event it thinks is active.
>> 
>> 
>> kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
>> kernel: sound status = 00000000 (mask 00000000)
>> kernel: sound status = 00000000 (mask 00000000)
>> kernel: sound status = 00300100 (mask 000000f0)
>> last message repeated 7 times
>> /sbin/hotplug[18871]: no runnable /etc/hotplug/sound.agent is installed
>> /sbin/hotplug[18886]: no runnable /etc/hotplug/sound.agent is installed
>> /sbin/hotplug[18878]: no runnable /etc/hotplug/sound.agent is installed
>> /sbin/hotplug[18885]: no runnable /etc/hotplug/sound.agent is installed
>> kernel: intel8x0_measure_ac97_clock: measured 49492 usecs
>> kernel: intel8x0: clocking to 47354
>> kernel: ALSA sound/pci/intel8x0.c:2787: joystick(s) found
>> /sbin/hotplug[18901]: no runnable /etc/hotplug/sound.agent is installed
>> 
>> playing a video with mplayer:
>> 
>> kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1108, max jitter = 4456): wrong interrupt acknowledge?

> this is likely a different problem.
> usually this message appears when the interrupt handling is sloppy.

tried this: ( beware I do _not_ know what I'm doing)

--- sound/oss/i810_audio.c.orig 2004-02-11 20:13:45.000000000 +0100
+++ sound/oss/i810_audio.c      2004-02-11 20:48:51.000000000 +0100
@@ -149,7 +149,7 @@
 
 //#define DEBUG
 //#define DEBUG2
-//#define DEBUG_INTERRUPTS
+#define DEBUG_INTERRUPTS
 //#define DEBUG_MMAP
 //#define DEBUG_MMIO
 
@@ -1380,8 +1380,16 @@
 
        if(!(status & INT_MASK)) 
        {
+
+               static int count = 10;
+               if (count) {
+               count--;
+               printk("sound status = %08x (mask %08x)\n",
+               status, INT_MASK);
+               }
+
                spin_unlock(&card->lock);
-               return IRQ_NONE;  /* not for us */
+               return IRQ_RETVAL(status);  /* not for us */
        }
 
        if(status & (INT_PO|INT_PI|INT_MC))

which resulted in:

kernel: Intel 810 + AC97 Audio, version 0.24, 20:51:32 Feb 11 2004
kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
kernel: i810: NVIDIA nForce Audio found at IO 0xd400 and 0xd000, MEM 0x0000 and 0x0000, IRQ 21
kernel: sound status = 00300100 (mask 00000ce7)
last message repeated 9 times
kernel: i810_audio: Audio Controller supports 6 channels.
kernel: i810_audio: Defaulting to base 2 channel mode.
kernel: i810_audio: Resetting connection 0
kernel: ac97_codec: AC97  codec, id: CMI97 (CMedia)
kernel: AC97 codec does not have proper volume support.
kernel: i810_audio: only 48Khz playback available.
kernel: i810_audio: AC'97 codec 0, new EID value = 0x05c6
kernel: i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
/sbin/hotplug[31860]: no runnable /etc/hotplug/sound.agent is installed
kernel: i810_audio: 9472 bytes in 50 milliseconds
kernel: i810_audio: setting clocking to 48648

line in -> line out with xawtv works, 
PCM (echo /usr/share/sounds/alsa/test.wav >/dev/dsp) -> does not hang,
but no sound

and I get ~250,000 ints/s on IRQ 21

thanks,

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
