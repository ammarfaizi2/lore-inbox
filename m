Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUCES60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbUCES60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:58:26 -0500
Received: from av11-2-sn4.m-sp.skanova.net ([81.228.10.105]:40627 "EHLO
	av11-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262675AbUCES6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:58:22 -0500
Date: Fri, 5 Mar 2004 19:58:21 +0100 (CET)
Message-Id: <200403051858.i25IwLa12467@d1o404.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [217.208.132.234] 2004-03-05 19:58:21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-03 12:25:06 Jens Axboe wrote:
> On Wed, Mar 03 2004, Alistair John Strachan wrote:
>> On Wednesday 03 March 2004 11:37, you wrote:
[...]
>> Is this a general optimisation, i.e. will the rip methods used by
>> cdda2wav and cdparanoia, etc. be optimised, or do you need some
>> specific userspace tools to utilise it?

> The patch only affects CDROMREADAUDIO ioctl. cdda2wav (with recent
> libscg) will use SG_IO, which works equally well already. cdparanoia
> uses CDROMREADAUDIO as well iirc, if it can use /dev/sg* sg v2
> interface. I'm not completely sure, if you send me an strace of the
> process in question I can tell you for sure :)

Here the patch boosted cdparanoia, but it is far from cdda2wav results
(don't understand the tech talk so just reporting on outcome)

Celeron 800MHz @ 1075MHz, 360Meg mem.  Hewlett-Packard CD-Writer Plus 9100
cdparanoia III release 9.8 (March 23, 2001)
cdda2wav Version 2.01a18

_2.6.4-rc2_ (unpatched)

# time cdda2wav -D /dev/cdrom
[...]
samplefile size will be 52190924 bytes.
recording 295.8666 seconds stereo with 16 bits @ 44100.0 Hz ->'audio'...
overlap:min/max/cur, jitter, percent_done:
 0/ 0/ 1/      0  99%EnableCdda_cooked (CDIOCSETCDDA) is not available...
 0/ 0/ 1/      0 100%  track  1 successfully recorded

real    0m37.923s
user    0m0.144s
sys     0m0.796s

--- (reboot)

# time cdparanoia 1
[...]
real    2m43.071s
user    0m9.039s
sys     0m1.798s

+++

_2.6.4-rc2-cddaDMA_ (patched)

# time cdda2wav -D /dev/cdrom
[same results as unpatched]

--- (reboot)

# time cdparanoia 1
[...]
real    1m54.289s
user    0m6.538s
sys     0m1.381s

# md5sum *.wav
510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-audio.wav
510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cdda.wav
510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cddaDMA-audio.wav
510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cddaDMA-cdda.wav

(and yes, they all play correctly ;-)

PS. Something really strange happened when I wanted to confirm the
playability - which I did _after_ the whole ripping, booting, ripping. I
had lost sound... Total silence from the speaker jack. Alsa was loaded,
/dev/dsp* /dev/audio* was still correct. Every player software acted as
if everything was ok. Speakers functional (confirmed with another
computer). Rebooted with older kernels, shut down completely to give the
hardware a rest. Still silence. Deleted /etc/asound.state and
reconfigured with alsamixer. No change. Perplexed as I've never lost
sound like this, I booted into an old Slackware partition (OSS sound
based). No sound problem there. Booting back out I suddenly had working
sound in my normal environment 2.6.4-rc2. Might be a fluke, space xray
thing, but I would feel more stupid not mentioning it than I do with
these words. DS

Mvh
Mats Johannesson

