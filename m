Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUBJLWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbUBJLWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:22:30 -0500
Received: from math.ut.ee ([193.40.5.125]:49341 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265823AbUBJLW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:22:28 -0500
Date: Tue, 10 Feb 2004 13:22:25 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hhdy02is7.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402101256450.4333-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Today mplayer was OK when I tested, didn't retry KDE login. But the
> > kernel is the same, I have not rebooted inbetween.
>
> weird...  cpufreq is running?

No, it's a desktop Celeron 900.

> > Did try twice:
> >
> > intel8x0_measure_ac97_clock: measured 50040 usecs
> > intel8x0: clocking to 41146
> >
> > intel8x0_measure_ac97_clock: measured 49395 usecs
> > intel8x0: clocking to 41145
>
> and now you got the correct output?
> if so, you can pass the value via ac97_clock option.

I did retest things more toroughly today after I booted up 2.6.3-rc2. I
focused on testing KDE login since this is known to break. Startup
scripts (discover) loaded also i810_audio, I unloaded it.

Plain bootup gave
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49671 usecs
intel8x0: clocking to 41136

and it did not work. Unloading and reloading snd-intel8x0 gave
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49281 usecs
intel8x0: clocking to 41139

and it still did not work (way too fast, probably even more than twice).
Now I tried
modprobe snd-intel8x0 ac97_clock=41140
It loads silently but still does not work.

Now I started to suspect that loading i810_audio might screw things up.
Removed the module and rebooted, no i810_audio loaded, still the same.

Reproduced the problem with mplayer too. It depends on the input file
bitrate!

mplayer /usr/share/sounds/KDE_Startup.wav
gives the same very fast sound since it's a 22 KHz mono sample.

mplayer -srate 48000 /usr/share/sounds/KDE_Startup.wav
works fine. Same applies to all files.

So maybe it's a userspace resampling issue? I see that the hardware
talks 44 KHz.

-- 
Meelis Roos (mroos@linux.ee)


