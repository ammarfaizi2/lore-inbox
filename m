Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVFXHID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVFXHID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbVFXHID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:08:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13755 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262744AbVFXHHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:07:45 -0400
Date: Fri, 24 Jun 2005 09:06:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050624070639.GB5941@elte.hu>
References: <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org> <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org> <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.012, required 5.9,
	BAYES_00 -4.90, PORN_4 1.89
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> > http://sysex.net/testing/2.6.12-RT-V0.7.50-17/xeonht/
> 
> OK... Running on -50-17 with all RT debug except CONFIG_WAKEUP_TIMING 
> and CONFIG_LATENCY_TIMING disabled.  Max wakeup latency is 59us now, 
> with a couple erroneous values of 2533412143us.  VLC performance 
> (streaming from a multicast UDP source) was great with one instance of 
> burnP6 running.  Running a second burnP6 along with VLC locks up the 
> box (reproduceable) in about a minute.  Running two or more instances 
> of burnP6 without VLC does not result in any odd behavior or 
> noticeably impact GUI performance.  I rebuilt with 
> CONFIG_DETECT_SOFTLOCKUP enabled, but couldn't catch a trace.

do you have the NMI watchdog enabled? Find below 
serial-logging-earlyprintk-nmi.txt.

	Ingo

to set up serial logging:
-------------------------

install a null modem cable (== serial cable) to one of the serial ports
of the server, connect the cable to another box, run a terminal program
on that other box (e.g. "minicom -m" - do Alt-L to switch on logging
after starting it up) and set up the server's kernel to do serial
logging: enable CONFIG_SERIAL_8250_CONSOLE and
CONFIG_SERIAL_CORE_CONSOLE, recompile & reinstall the kernel, add
"console=ttyS0,38400 console=tty0" to your /etc/grub.conf or
/etc/lilo.conf kernel boot line, reboot the server with the new kernel
command line - and configure minicom to run with that speed (Alt-S).

e.g. my /etc/grub.conf has:

title test-2.6 (test-2.6)
        root (hd0,0)
        kernel /boot/bzImage root=/dev/sda1 console=ttyS0,38400 console=tty0 nmi_watchdog=1 kernel_preempt=1

if everything is set up correctly then you should see kernel messages
showing up in the minicom session when you boot up.

When the messages do not show up then typical errors are mismatch
between the serial port (or speed) and the device names used - if it's
COM2 then use ttyS1, and dont forget to set up the serial speed option
of minicom, etc. You can test the serial connection by doing:

	echo x > /dev/ttyS0

and that should show up in the minicom session on the other box.

to set up early-printk:
-----------------------

occasionally lockups/crashes happen so early in the bootup that nothing
makes it even to the serial log. In that case the 'earlyprintk' feature
is most useful. It is default-enabled on all 2.6 kernels, you only need
to add one more boot parameter to activate it over the serial console:

   earlyprintk=serial,ttyS0,38400

to set up the NMI watchdog:
---------------------------

add nmi_watchdog=1 to your boot parameters and reboot - that should be
all to get it active. If all CPU's NMI count increases in
/proc/interrupts then it's working fine. If the counts do not increase
(or only one CPU increases it) then try nmi_watchdog=2 - this is another
type of NMI that might work better. (Very rarely there are boxes that
dont have reliable NMI counts with 1 and 2 either - but i dont think
your box is one of those.)

once the NMI watchdog is up and running it should catch all hard lockups
and print backtraces to the serial console - even if you are within X
while the lockup happens. You can test hard lockups by running the
attached 'lockupcli' userspace code as root - it turns off interrupts
and goes into an infinite loop => instant lockup. The NMI watchdog
should notice this condition after a couple of seconds and should abort
the task, printing a kernel trace as well. Your box should be back in
working order after that point.

now for the real lockup your box wont be 'fixed' by the NMI watchdog, it
will likely stay locked up, but you should get messages on the serial
console, giving us an idea where the kernel locked up and why. (Very
rarely it happens that not even the NMI watchdog prints anything for a
hard lockup - this is often the sign of hardware problems.)

	Ingo

--- lockupcli.c

main ()
{
        iopl(3);
        for (;;) asm("cli");
}

