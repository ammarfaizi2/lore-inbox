Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUK1Ce2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUK1Ce2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 21:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUK1Ce2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 21:34:28 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:35042 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbUK1CeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 21:34:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ToXLSV5tPRG4XPbjDf+boIXjMUEi09UBnqqukp0plbsu9+f8kklb7v7a4LfLDgi8YG/nZdZdRMK+Uu/8HllWnNfgXW02wl8xuNveTpxOPZ+hWKWW+FQO42Q55SICIWVKnq+8D+N7MKGzgHRc/krvoArgFoNfC5f4uutOV8YY03Y=
Message-ID: <9dda34920411271834133ae52c@mail.gmail.com>
Date: Sat, 27 Nov 2004 21:34:11 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm3
Cc: greg@kroah.com, linux-hotplug-devel@lists.sourceforge.net,
       diffie@blazebox.homeip.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041127170635.6dbe75cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9dda34920411271434ef00874@mail.gmail.com>
	 <20041127170635.6dbe75cd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004 17:06:35 -0800, Andrew Morton <akpm@osdl.org> wrote: 
> > Nov 27 13:49:23 blaze udev[5385]: creating device node '/dev/sound/mixer'
> > Nov 27 13:49:23 blaze udev[5398]: creating device node '/dev/sound/dsp'
> > Nov 27 13:49:23 blaze udev[5410]: creating device node '/dev/sound/audio'
> > Nov 27 13:49:23 blaze udev[5417]: creating device node '/dev/sound/adsp'
> 
> It's trying to create nodes under /dev/sound/
> 
> >
> > -- ls /dev output --
> >
> > crw-------  1 root root 116, 33 2004-11-27 13:49 /dev/sound
> 
> But your /dev/sound appears to be a character device node, not a directory.
> 
> Did you try rm /dev/sound, mkdir /dev/sound?
> 
> 

Ok, i tried removing /dev/sound char device then making /dev/sound
directory and upon reboot the directory becomes the char device again.
Still no /dev/dsp.

Here is what i have noticed when running the udev startup script
/etc/rc.d/rc.udev on slackware:

When run after startup and udevd is already running it will create the
/dev/sound and friends and symlinks to dsp,mixer,audio under /dev eg.

--> ls -l /dev/sound
total 0
crw-rw--w-  1 root audio 14, 12 2004-11-27 21:13 adsp
crw-rw--w-  1 root audio 14,  4 2004-11-27 21:13 audio
crw-rw--w-  1 root audio 14,  3 2004-11-27 21:13 dsp
crw-rw--w-  1 root audio 14,  0 2004-11-27 21:13 mixer

and 

--> ls -l /dev/{dsp,audio,mixer}
lrwxrwxrwx  1 root root 11 2004-11-27 21:13 /dev/audio -> sound/audio
lrwxrwxrwx  1 root root  9 2004-11-27 21:13 /dev/dsp -> sound/dsp
lrwxrwxrwx  1 root root 11 2004-11-27 21:13 /dev/mixer -> sound/mixer

but since /proc must be mounted before udev is run then invoking udev
for the second time breaks /proc's permissions thus this happens:

--> ut2004
libGL error: failed to open DRM: Operation not permitted

and dmesg prints:

scheduling while atomic: ut2004-bin/0x00000001/6112
 [<c033b9b8>] schedule+0x4f8/0x500
 [<c033bfe3>] schedule_timeout+0x63/0xc0
 [<c0123ce0>] process_timeout+0x0/0x10
 [<c01240bf>] msleep+0x2f/0x40
 [<f8ba102f>] snd_intel8x0_setup_pcm_out+0xbf/0x150 [snd_intel8x0]
 [<f8ba114c>] snd_intel8x0_pcm_prepare+0x8c/0xb0 [snd_intel8x0]
 [<f8bfda84>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<c013d615>] __alloc_pages+0x235/0x3e0
 [<f8bfcdd8>] snd_pcm_action_single+0x38/0x80 [snd_pcm]
 [<f8bfcfd0>] snd_pcm_action_nonatomic+0x80/0x90 [snd_pcm]
 [<f8bfdb37>] snd_pcm_prepare+0x57/0x80 [snd_pcm]
 [<f8c001e2>] snd_pcm_playback_ioctl1+0x52/0x320 [snd_pcm]
 [<f8d3bae9>] snd_pcm_oss_poll+0x49/0x1a0 [snd_pcm_oss]
 [<c016be5a>] poll_freewait+0x3a/0x50
 [<f8c00868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8d39026>] snd_pcm_oss_prepare+0x26/0x60 [snd_pcm_oss]
 [<f8d3909d>] snd_pcm_oss_make_ready+0x3d/0x60 [snd_pcm_oss]
 [<f8d3958d>] snd_pcm_oss_write1+0x3d/0x210 [snd_pcm_oss]
 [<f8d3b9d0>] snd_pcm_oss_write+0x40/0x60 [snd_pcm_oss]
 [<f8d3b990>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
 [<c01589db>] vfs_write+0xbb/0x160
 [<c0158b51>] sys_write+0x51/0x80
 [<c0103133>] syscall_call+0x7/0xb
scheduling while atomic: ut2004-bin/0x00000001/6101
 [<c033b9b8>] schedule+0x4f8/0x500
 [<c033bfe3>] schedule_timeout+0x63/0xc0
 [<c0123ce0>] process_timeout+0x0/0x10
 [<c01240bf>] msleep+0x2f/0x40
 [<f8ba102f>] snd_intel8x0_setup_pcm_out+0xbf/0x150 [snd_intel8x0]
 [<f8ba114c>] snd_intel8x0_pcm_prepare+0x8c/0xb0 [snd_intel8x0]
 [<f8bfda84>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<f8bfcdd8>] snd_pcm_action_single+0x38/0x80 [snd_pcm]
 [<f8bfcfd0>] snd_pcm_action_nonatomic+0x80/0x90 [snd_pcm]
 [<f8bfdb37>] snd_pcm_prepare+0x57/0x80 [snd_pcm]
 [<f8c001e2>] snd_pcm_playback_ioctl1+0x52/0x320 [snd_pcm]
 [<f8bfe0b0>] snd_pcm_drop+0x70/0xf0 [snd_pcm]
 [<f8c00868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8d39026>] snd_pcm_oss_prepare+0x26/0x60 [snd_pcm_oss]
 [<f8d3909d>] snd_pcm_oss_make_ready+0x3d/0x60 [snd_pcm_oss]
 [<f8d39be2>] snd_pcm_oss_sync+0x32/0x290 [snd_pcm_oss]
 [<f8d399fd>] snd_pcm_oss_reset+0x2d/0x70 [snd_pcm_oss]
 [<f8d3b31d>] snd_pcm_oss_ioctl+0xbd/0x710 [snd_pcm_oss]
 [<c0102529>] restore_sigcontext+0x119/0x140
 [<c016b6eb>] sys_ioctl+0xbb/0x250
 [<c0103133>] syscall_call+0x7/0xb
scheduling while atomic: ut2004-bin/0x00000001/6101
 [<c033b9b8>] schedule+0x4f8/0x500
 [<c033bfe3>] schedule_timeout+0x63/0xc0
 [<c0123ce0>] process_timeout+0x0/0x10
 [<c01240bf>] msleep+0x2f/0x40
 [<f8ba102f>] snd_intel8x0_setup_pcm_out+0xbf/0x150 [snd_intel8x0]
 [<f8ba114c>] snd_intel8x0_pcm_prepare+0x8c/0xb0 [snd_intel8x0]
 [<f8bfda84>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<f8bfcdd8>] snd_pcm_action_single+0x38/0x80 [snd_pcm]
 [<f8bfcfd0>] snd_pcm_action_nonatomic+0x80/0x90 [snd_pcm]
 [<f8bfdb37>] snd_pcm_prepare+0x57/0x80 [snd_pcm]
 [<f8c001e2>] snd_pcm_playback_ioctl1+0x52/0x320 [snd_pcm]
 [<f8c001e2>] snd_pcm_playback_ioctl1+0x52/0x320 [snd_pcm]
 [<f8c00868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8d39026>] snd_pcm_oss_prepare+0x26/0x60 [snd_pcm_oss]
 [<f8d3909d>] snd_pcm_oss_make_ready+0x3d/0x60 [snd_pcm_oss]
 [<f8d39be2>] snd_pcm_oss_sync+0x32/0x290 [snd_pcm_oss]
 [<f8d3b1c1>] snd_pcm_oss_release+0x21/0xc0 [snd_pcm_oss]
 [<c0159935>] __fput+0x135/0x150
 [<c0157f39>] filp_close+0x59/0x90
 [<c0157fd1>] sys_close+0x61/0xa0
 [<c0103133>] syscall_call+0x7/0xb

For the record the udev.permissons has these:

# audio devices
dsp*:root:audio:0662
audio*:root:audio:0662
midi*:root:audio:0662
mixer*:root:audio:0666
sequencer*:root:audio:0662
sound/*:root:audio:0662
snd/control*:root:audio:0666
snd/midi*:root:audio:0666
snd/pcm*p:root:audio:0666
snd/seq:root:audio:0666
snd/timer:root:audio:0666
snd/hw*:root:audio:0662
snd/pcm*c:root:audio:0662
beep:root:audio:0664
admm*:root:audio:0662
adsp*:root:audio:0662
aload*:root:audio:0662
amidi*:root:audio:0662
dmfm*:root:audio:0662
dmmidi*:root:audio:0662
sndstat:root:audio:0662

udev.rules has:

# ALSA devices
KERNEL="controlC[0-9]*", NAME="snd/%k"
KERNEL="hw[CD0-9]*",     NAME="snd/%k"
KERNEL="pcm[CD0-9cp]*",  NAME="snd/%k"
KERNEL="midiC[D0-9]*",   NAME="snd/%k"
KERNEL="timer",          NAME="snd/%k"
KERNEL="seq",            NAME="snd/%k"

and

# sound devices
KERNEL="adsp",            NAME="sound/%k", SYMLINK="%k"
KERNEL="adsp[0-9]*",      NAME="sound/%k", SYMLINK="%k"
KERNEL="audio",           NAME="sound/%k", SYMLINK="%k"
KERNEL="audio[0-9]*",     NAME="sound/%k", SYMLINK="%k"
KERNEL="dsp",             NAME="sound/%k", SYMLINK="%k"
KERNEL="dsp[0-9]*",       NAME="sound/%k", SYMLINK="%k"
KERNEL="mixer",           NAME="sound/%k", SYMLINK="%k"
KERNEL="mixer[0-9]*",     NAME="sound/%k", SYMLINK="%k"
KERNEL="sequencer",       NAME="sound/%k", SYMLINK="%k"
KERNEL="sequencer[0-9]*", NAME="sound/%k", SYMLINK="%k"

Paul
-- 
FreeBSD the Power to Serve!
