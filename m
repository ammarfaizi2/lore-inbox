Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGMINd>; Sat, 13 Jul 2002 04:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSGMINc>; Sat, 13 Jul 2002 04:13:32 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:55682 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316678AbSGMINc>; Sat, 13 Jul 2002 04:13:32 -0400
Date: Sat, 13 Jul 2002 10:15:19 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Kristian Amlie <k_amlie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Loading module "ide-cd.o" crashes during cd-r/rw burning
Message-Id: <20020713101519.339f9f2a.kristian.peters@korseby.net>
In-Reply-To: <20020713004815.53870.qmail@web10908.mail.yahoo.com>
References: <20020713004815.53870.qmail@web10908.mail.yahoo.com>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristian.

I think the problem here is that ide-cd tries to access /dev/hdd which is already used by ide-scsi. That looks like a forgotten check in ide-cd.

Could you first try 2.4.19-rc1 ? I couldn't reproduce a hang with it. A second "modprobe ide-cd" only stalls linux for 2 seconds and I'm getting:

hdd: set_drive_speed_status: status=0xd0 { Busy }

which means that modprobe is stucking in D state:

root      1288  0.0  2.2  5740 5740 pts/1    SL   09:59   0:00 cdrecord blank=fa
root      1290 14.9  0.2  1712  756 pts/1    D    09:59   0:10 modprobe ide-cd i

After finished burning (hdc is accessible again) it comes back.

Kristian Amlie <k_amlie@yahoo.com> wrote:
> Hi!
> 
> [2.]
> I have a configuration with two CD-ROM drives; they are:
> 1. HL-DT-ST RW/DVD GCC-4120B (Goldstar)
> 2. Pioneer CD-ROM ATAPI Model DR-A04S 0105
> according to "/proc/ide/hdX/model".
> 
> I use drive number one to burn CDs using the scsi interface with
> scsi_mod ide-scsi, sr_mod and sg. The program I use is cdrecord.
> My "modules.conf" file is set up to load "ide-cd ignore=hdc" before the
> sg interface is opened. This way, the ide interface takes care of my
> second CD-ROM (hdd) and the scsi interface takes care of the first
> (hdc).
> This configuration works fine. However, a problem arises because the
> ide-cd module is often autocleaned while a burning is in progress. If I
> then try to access the second CD-ROM (hdd), the ide-cd module hangs on
> initialization (at least that's what lsmod tells me).
> The burning process also stops, and the programs that tried to access
> the second drive are caught in their uninterruptable sleeps.
> Shortly after this (about a minute or two) I get a message that loading
> the module failed.
> And that is almost immediately followed by a complete kernel crash. I
> am afraid I cannot provide any screen output, as it starts printing hex
> values at unlimited speed, and I am unable to read it.
> The kernel doesn't react to any keypresses (like ScrollLock to stop the
> output), not even the Magic SysRq key, which I have activated.

If this still persists:

It could be helpful for the developers to have the oops-output. Try to attach a serial console. First enable CONFIG_SERIAL_CONSOLE in your kernel-config. If done, append the following options to lilo. For example my lilo.conf:

image=/boot/vmlinuz-2.4.19-rc1-kp1
 	label=udmacda
 	append="console=ttyS0,57600n8,vt102 console=tty0"
 	read-only
 	root=/dev/hda1

Then you need a second computer to capture that output (with mingetty or anything similar). Maybe you could redirect the klog output via syslog to another machine. I hope you have the possibilities.

*Kristian

> #!/bin/bash
> 
> modprobe ide-cd ignore=hdc
> modprobe sg
> cdrecord dev=<insert scsi device>  <SomeBigIsoFile> &
> # Give it some time to start the burning.
> sleep 120
> modprobe -r ide-cd
> modprobe ide-cd
> echo "Shouldn't get here! The problem obviously doesn't reveal itself
> under this environment!"


  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
