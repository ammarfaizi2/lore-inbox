Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUI1Lgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUI1Lgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUI1Lgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:36:44 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:30643 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S267516AbUI1Lgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:36:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Tue, 28 Sep 2004 07:36:38 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Matt Heler <lkml@lpbproductions.com>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409280701.06932.gene.heskett@verizon.net> <20040928110541.GA22436@elte.hu>
In-Reply-To: <20040928110541.GA22436@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409280736.38340.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.46.219] at Tue, 28 Sep 2004 06:36:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 07:05, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> That would I assume need a null modem cable, and what do I run on
>> the firewall?  Minicom?  Or is there something better that can
>> just grab and log without being interactive?  Its a rh7.3 box with
>> a 2.4.18 era kernel.  I'd update that, but its not broken. :)
>
>here's a mini-howto:
>
Printed for future reference, thanks

>to set up serial logging:
>-------------------------
>
>install a null modem cable to one of the serial ports of the server,
>connect the cable to another box, run a terminal program on that
> other box (e.g. "minicom -m" - do Alt-L to switch on logging after
> starting it up) and set up the server's kernel to do serial
> logging: enable CONFIG_SERIAL_8250_CONSOLE and
> CONFIG_SERIAL_CORE_CONSOLE, recompile & reinstall the kernel, add
> "console=ttyS0,38400 console=tty0" to your /etc/grub.conf or
> /etc/lilo.conf kernel boot line, reboot the server with the new
> kernel command line - and configure minicom to run with that speed
> (Alt-S).
>
>e.g. my /etc/grub.conf has:
>
>title test-2.6 (test-2.6)
>        root (hd0,0)
>        kernel /boot/bzImage root=/dev/sda1 console=ttyS0,38400
> console=tty0 nmi_watchdog=1 kernel_preempt=1
>
>if everything is set up correctly then you should see kernel
> messages showing up in the minicom session when you boot up.
>
>When the messages do not show up then typical errors are mismatch
>between the serial port (or speed) and the device names used - if
> it's COM2 then use ttyS1, and dont forget to set up the serial
> speed option of minicom, etc. You can test the serial connection by
> doing:
>
>	echo x > /dev/ttyS0
>
>and that should show up in the minicom session on the other box.
>
>to set up the NMI watchdog:
>---------------------------
>
>add nmi_watchdog=1 to your boot parameters and reboot - that should
> be all to get it active. If all CPU's NMI count increases in
>/proc/interrupts then it's working fine. If the counts do not
> increase (or only one CPU increases it) then try nmi_watchdog=2 -
> this is another type of NMI that might work better. (Very rarely
> there are boxes that dont have reliable NMI counts with 1 and 2
> either - but i dont think your box is one of those.)
>
>once the NMI watchdog is up and running it should catch all hard
> lockups and print backtraces to the serial console - even if you
> are within X while the lockup happens. You can test hard lockups by
> running the attached 'lockupcli' userspace code as root - it turns
> off interrupts and goes into an infinite loop => instant lockup.
> The NMI watchdog should notice this condition after a couple of
> seconds and should abort the task, printing a kernel trace as well.
> Your box should be back in working order after that point.
>
>now for the real lockup your box wont be 'fixed' by the NMI
> watchdog, it will likely stay locked up, but you should get
> messages on the serial console, giving us an idea where the kernel
> locked up and why. (Very rarely it happens that not even the NMI
> watchdog prints anything for a hard lockup - this is often the sign
> of hardware problems.)
>
>	Ingo
>
>--- lockupcli.c
>
>main ()
>{
>	iopl(3);
>	for (;;) asm("cli");
>}

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
