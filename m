Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752545AbWAFU0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbWAFU0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbWAFU0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:26:49 -0500
Received: from gate.perex.cz ([85.132.177.35]:31681 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1752541AbWAFU0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:26:48 -0500
Date: Fri, 6 Jan 2006 21:26:42 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Olivier Galibert <galibert@pobox.com>
Cc: Diego Calleja <diegocg@gmail.com>, Marcin Dalecki <martin@dalecki.de>,
       rlrevell@joe-job.com, jengelh@linux01.gwdg.de,
       Takashi Iwai <tiwai@suse.de>, jesper.juhl@gmail.com, bunk@stusta.de,
       zdzichu@irc.pl, s0348365@sms.ed.ac.uk, ak@suse.de,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       linux@thorsten-knabe.de, zwane@commfireservices.com, zaitcev@yahoo.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060106145723.GA73361@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0601061938390.10811@tm8103.perex-int.cz>
References: <20060103215654.GH3831@stusta.de>
 <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
 <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
 <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe>
 <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <20060106034026.c37c1ed9.diegocg@gmail.com>
 <20060106145723.GA73361@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Olivier Galibert wrote:

> On Fri, Jan 06, 2006 at 03:40:26AM +0100, Diego Calleja wrote:
> > Amazing - even windows is getting sound mixing out of the kernel
> > in windows vista because they've learnt (the hard way) that it's
> > the Right Thing and linux people is trying to get it in?
> 
> You misread.  Most people just want to have things work like they
> should have for years.  Technical people, at least Marcin and I, want
> a documented kernel interface with optional libraries over it (think
> libX11 vs. the X Protocol, or glibc/klibc/uclibc/libc5 vs. the system
> calls), and then behind that have the kernel route the data to
> userspace demon(s) or the hardware depending on root-level setup and
> configuration.

I got the point, but the audio is very specific that it requires realtime 
scheduling. Even graphics is not so tied with realtime, because a 
scheduling gap does not end with error or very ugly misbehaviour (pops) 
like in audio.

You're proposing to add more content switches versus current ALSA 
implementation:

user space <-> kernel

While your daemon requires:

user space <-> kernel <-> user space (daemon)

So your solution is even more realtime and proper scheduling dependant.
Unfortunately, Linux kernels still do not have perfect realtime behaviour 
(mostly due to broken drivers etc.).

Also, the API is completely irrelevant from this scheme. If daemon does 
everything, the ALSA kernel API can go public and documented (altough I 
still does not agree with it - see bellow).

> ALSA does not have a documented kernel interface nor an optional
> library but a mandatory library.  A highly complex, ipc-using library

It's also not very true. You can create your own ALSA library, but this 
library will not be supported with our team. The ALSA from 1.0 version is 
binary compatible (even 0.9.0rc4+ linked applications should work) and old 
ioctls are emulated.

> with no security audit that I could find with google.  A library for
> which people do not seem to care about compatibility with previous or
> future kernel versions, which means it _has_ to be shared.  And shared
> libraries are just unacceptable in some contexts, like distributing
> binaries outside of a specific linux distribution[1].

I'd like to point that this code runs with standard user priviledges. I 
think that the security things are and should be in a different place (in 
the kernel). If IPC is broken, other applications (not only using sound) 
might be broken. If administrator (root) creates wrong configuration files 
for alsa-lib - we cannot do anything. It's a human error. The same problem 
is if you have this code in kernel. It can be bad (even more than in the 
user space - you can shutdown whole system) too.

> At least OSS, with all its flaws, is a documented kernel interface.
> You can static link a oss-using program, whether it uses it directly
> or through interfaces like sdl-audio, and it will just work.

Please, see your words. You're simply anarchistic. You replaced 
flexibility of dynamic library with a possibility to have static binary.

ALSA library can be also compiled as static library, so it's not a 
problem. The ALSA kernel API is stable. Also, we use symbol versions for 
all exported functions, so all old binaries linked with the dynamic alsa 
library will work. Of course, the drivers might change some universal 
control names, then different configuration files for alsa-lib should be 
used, but it's a different point and we're working also on this 
compatibility to avoid these problems in future. But the standard stereo 
sound work all the time (I speak about 5.1, S/PDIF devices).

Also note, that if OSS had the API in userspace from the first days,
the emulation or redirection of this API to another API or user space 
drivers wouldn't be so much complicated nowadays. Bummer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
