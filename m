Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUKOXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUKOXto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUKOXto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:49:44 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30928 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261679AbUKOXq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:46:28 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Timothy Miller <miller@techsource.com>
Date: Tue, 16 Nov 2004 10:46:23 +1100
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
Message-ID: <20041115234623.GA19452@cse.unsw.EDU.AU>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <419914F9.7050509@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419914F9.7050509@techsource.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timothy

On Mon, 15 Nov 2004, Timothy Miller wrote:

> When I do 'lspci | grep -i audio', I get this:
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 
> Audio (rev 04)
> 
> Unfortunately, every effort has failed to get the slightest peep out.  I 
> have tried following the instructions on the Gentoo site (with my own 
> guesses about what to do differently for 2.6 kernels), but I don't get 
> any sound.  Also, the "alsaconf" utility says it doesn't find any audio 
> devices.
> 
> Can anyone help me with this?

* Is the module loaded try /sbin/lsmod
 snd_intel8x0           29704  2
 snd_ac97_codec         65028  1 snd_intel8x0
 snd_pcm_oss            48040  0
 snd_mixer_oss          17280  3 snd_pcm_oss
 snd_pcm                82852  2 snd_intel8x0,snd_pcm_oss
 snd_timer              20868  1 snd_pcm
 snd_page_alloc          8968  2 snd_intel8x0,snd_pcm
 snd_mpu401_uart         6272  1 snd_intel8x0
 snd_rawmidi            20032  1 snd_mpu401_uart
 snd_seq_device          6536  1 snd_rawmidi
 snd                    46180  9 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

* Check permission 
ls -l /dev/snd/
 total 0
 crw-rw----    1 root     audio    116,   0 Nov 11 15:55 controlC0
 crw-rw----    1 root     audio    116,  24 Nov 11 15:55 pcmC0D0c
 crw-rw----    1 root     audio    116,  16 Nov 11 15:55 pcmC0D0p
 crw-rw----    1 root     audio    116,  25 Nov 11 15:55 pcmC0D1c
 crw-rw----    1 root     audio    116,  26 Nov 11 15:55 pcmC0D2c
 crw-rw----    1 root     audio    116,  27 Nov 11 15:55 pcmC0D3c
 crw-rw----    1 root     audio    116,  20 Nov 11 15:55 pcmC0D4p
 crw-rw----    1 root     audio    116,  33 Nov 11 15:55 timer

just set them ugo+rw and try alsamixer again

* Strace
or tried to strace alsamixer to see what it is looking for and what it
cannot find a quick trace here shows:

 open("/dev/snd/controlC0", O_RDONLY)    = 3
 close(3)                                = 0
 open("/dev/snd/controlC0", O_RDWR)      = 3
 ioctl(3, USBDEVFS_CONTROL, 0xbffff46c)  = 0
 ioctl(3, 0x81785501, 0xbffff6f0)        = 0
 close(3)                                = 0
 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8007, ...}) = 0
 open("/dev/snd/controlC0", O_RDONLY)    = 3
 close(3)                                = 0
 open("/dev/snd/controlC0", O_RDWR)      = 3

try
 strace alsamixer > alsa.strace 2>&1

you will have to kill it after about 20 sec or so with
^C

then serach over the output alsa.strace and look for
dev entries if there are a lot of errors at the open
calls I would suggest

> 
> Thanks!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
