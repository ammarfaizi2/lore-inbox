Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVHDSrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVHDSrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVHDSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:47:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61917 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262583AbVHDSrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:47:03 -0400
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: rddunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 04 Aug 2005 12:43:44 -0600
In-Reply-To: <42F219B3.6090502@gmail.com> (Luca Falavigna's message of "Thu,
 04 Aug 2005 13:35:47 +0000")
Message-ID: <m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna <dktrkranz@gmail.com> writes:

> I made three experiments regarding kexec with frame buffer support (vesafb). For
> each of them I gathered dmesg messages from original and relocated kernel, in
> order to easily compare them later on. These tests were run on a virtual machine
> in order to provide the same environment for each experiment.
>
> Here are my tests and related results:
>
>
>
> 	1) Frame buffer not enabled
>
> Original kernel command line: root=/dev/hda1 ro
> Relocated kernel command line: root=/dev/hda1 ro
>
> Everything went well, as supposed to be. I was able to read boot messages and to
> see login prompts.
>
>
> 	2) Frame buffer enabled in the relocated kernel
>
> Original kernel command line: root=/dev/hda1 ro
> Relocated kernel command line: root=/dev/hda1 ro vga=791
>
> This time I was able to read boot messages and so on, but I couldn't be able to
> load vesafb in the relocated kernel. dmesg showed nothing about vesafb.
>
>
> 	3) Frame buffer enabled in the original kernel
>
> Original kernel command line: root=/dev/hda1 ro vga=791
> Relocated kernel command line: root=/dev/hda1 ro {vga=791,}
>
> This time I wasn't able to read boot messages in the relocated kernel, whether
> vga parameter was set or not. I looked at dmesg in order to get some useful
> informations:
>
> Linux version 2.6.13-rc5 (dktrkranz@gandalf) (gcc version 3.3.4 (Debian
> 1:3.3.4-13)) #3 Wed Aug 3 13:39:11 UTC 2005
> [...]
> -Console: colour dummy device 80x25
> +Console: colour VGA+ 80x25
> [...]
> -vesafb: framebuffer at 0xf0000000, mapped to 0xc2880000, using 3072k, total
> 16384k
> -vesafb: mode is 1024x768x16, linelength=2048, pages=0
> -vesafb: protected mode interface info at 00ff:44f0
> -vesafb: scrolling: redraw
> -vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> -mtrr: your processor doesn't support write-combining
> -Console: switching to colour frame buffer device 128x48
> -fb0: VESA VGA frame buffer device
> [...]
>
> It seems relocated kernel doesn't (or can't) load vesafb. Is frame buffer
> supported in kexec or there is some work-in-progress?

So without doing passing --real-mode the vga= parameter currently
cannot work.  The vga= parameter is processed by vga.S which
make BIOS calls and we bypass all of the BIOS calls.

So you can try with the --real-mode option and you have
a chance of the code working.  Or you can figure out which
information video.S passes to the kernel figure out how
to get that same information out of a running kernel
and then /sbin/kexec can be tweaked to pass the current
video mode.  Changing frame buffer modes shouldn't work
but you should at least be able to preserve the existing
ones.

Eric
