Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbULLJqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbULLJqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 04:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbULLJqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 04:46:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12512 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262060AbULLJqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 04:46:04 -0500
Date: Sun, 12 Dec 2004 10:45:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041212094551.GA16651@elte.hu>
References: <1102776772.2968.4.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102776772.2968.4.camel@rousalka.dyndns.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Mailhot <Nicolas.Mailhot@laPoste.net> wrote:

> Hi,
> 
> Just FYI real-time kernels do not boot on my Fedora Devel (Rawhide)
> system, including -RT-2.6.10-rc2-mm3-V0.7.32-12. 2.6.10-rc2-mm4 OTOH
> boots fine. It freezes just after initial hardware init before going
> into gfx mode.

so it freezes hard still in textmode? There wasnt any particular freeze
fixed since -32-12 (-19 is the latest), but you might want to try -19 if
it's simple to do.

> (kernel config available on demand, it's almost the same - 2.6.10-rc2-
> mm4 was generated using a make oldconfig on the -RT-2.6.10-rc2-mm3-
> V0.7.32-12 file)

please send the .config to me in private mail, along with a bootlog if
available. Does nmi_watchdog=1 (if the system has an IO-APIC) or
nmi_watchdog=2 (if it doesnt) produce any stackdumps from the lockup? 
(but those usually only make it to a serial log, not to the syslog.) 
Find below the mini-howto on how to set up serial logging and how to
debug lockups with the NMI watchdog.

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

