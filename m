Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWIXWDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWIXWDN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIXWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:03:13 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:19585 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751229AbWIXWDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:03:12 -0400
Date: Mon, 25 Sep 2006 00:03:59 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
In-Reply-To: <20060924135417.c0c18b76.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609242256540.4950@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
 <20060924135417.c0c18b76.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006, Andrew Morton wrote:

>> I keep a crash dump from kdump,
>
> Whoa.  Impressed.  Which distro are you using and how did you go about this
> and how much fuss was it to set up?

Well, it sure didn't work right out of the box... But it's not that hard, 
really: the main problems are lack of proper end-user docs and packaging, 
as usual. A serial console on another PC very much helped in 
troubleshooting problems (eg. my kdump kernel's initrd was initially too 
large), but it's not required (though it's always a nice thing to have 
anyway).

The basic instructions for setting up kdump are here:
   http://lse.sourceforge.net/kdump/kdump-test-reports/test-plan.txt

I followed them, and also had to:
  - reduce the uncompressed size of my initramfs (was 50+ MB initially, now 
ca. 22MB), by listing only the required modules (lsmod w/ some hand 
picking), see /etc/initramfs-tools/initramfs.conf
  - reserve more RAM for the kdump kernel (now I use "crashkernel=96M@16M")

The distro is the AMD64 Debian etch, with two vanilla 2.6.18 kernels: one 
"regular" SMP kernel with CONFIG_KEXEC=y, which is what I use, and one UP 
kernel with CONFIG_PROC_VMCORE=y and a different load address, which is 
activated on a crash; other than that they are the same.

The crude script below is run at boot time and configures kdump properly 
for me. All oopses invoke panic ("kernel.panic_on_oops = 1" in 
/etc/sysctl.conf), and thus the kdump kernel is activated. This kernel 
boots on the very same root fs, runs the script below again, this time to 
save the dump and reboot to the regular kernel. I did not try to have the 
kdump kernel reset the vga console, so it stays in graphic mode and shows 
garbage until the final reboot.

Now from an oops to being back to work, I would say it takes about 2-3 
minutes (the longer part is the cold reboot, then the 30" timeout on the 
Windows loader ;-)). I would certainly not do kernel development on my 
desktop (backups? what backups?), but oopses do occur from time to time 
(oh the joys of SMP on a desktop), and it's great to have a dump the first 
time I see one.

>> Oh and I wish I could use gdb on a kdump core. :-)
>
> Would be nice, but this is much better than what we usually get, no?

I'm used to having LKCD for debugging at work (on IA64), it has raised my 
expectations. :-)

But using gdb would be so much nicer, and I'm sure we're close to being 
able to use it, it's probably only a matter of messing a bit with the ELF 
image provided by kdump (it's really a good old core dump): ie. remapping 
vmalloc'ed memory pages, so modules can be accessed, and ideally adding 
processor context for each task (currently there is one per CPU). Crash 
does all this stuff internally and has other nice commands, but I don't 
find it quite as comfortable as gdb (with a few good scripts gdb would 
certainly be on par with crash).

Now I hope you're converted!


Cheers,

-- 
saffroy@gmail.com

#! /bin/bash
#
### BEGIN INIT INFO
# Provides:          kdump
# Required-Start:
# Required-Stop:
# Default-Start:     S
# Default-Stop:
### END INIT INFO
#
# This script configures a kdump kernel, or saves a dump and reboot.
#

_echo() {
 	echo "kdump: $@"
 	logger -p daemon.notice "kdump: $@"
 	echo "$(date) $@" >> /var/log/kdump.log
}

if grep -q crashkernel /proc/cmdline ; then
 	_echo "Configuring kdump kernel..."
 	_opts="$(sed -e 's,crashkernel=[^ ]*,,' /proc/cmdline)"
 	if kexec -p -t elf-x86_64 --args-linux \
 		--append="${_opts} init 1 irqpoll maxcpus=1" \
 		--initrd=/boot/initrd.img-kdump \
 		/boot/vmlinux-kdump
 	then
 		_echo "Successfully configured kdump kernel."
 	else
 		_echo "Failed to configure kdump kernel!"
 	fi
fi

if grep -q irqpoll /proc/cmdline ; then
 	_dump=/var/dump/dump-$(date +%F_%T)
 	_echo "Saving kernel dump under ${_dump}..."
 	cp /proc/vmcore "${_dump}"
 	rc=$?
 	ls -l /proc/vmcore "${_dump}"
 	chgrp adm "${_dump}"
 	chmod g+r "${_dump}"
 	_echo "Done saving kernel dump (rc=$rc), rebooting..."
 	reboot
fi

