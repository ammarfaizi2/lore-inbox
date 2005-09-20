Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVITIzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVITIzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVITIzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:55:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15519 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964938AbVITIzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:55:04 -0400
Date: Tue, 20 Sep 2005 10:55:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT bug with 2.6.13-rt4 and 3c905c tornado
Message-ID: <20050920085532.GA19807@elte.hu>
References: <200509201046.17818.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509201046.17818.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Hi
> 
> 	This driver works perfectly if you insert the physical card on a 
> PCI slot. If you insert this same card on a PCI-X slot, we got the 
> following problem : When you type "modprobe 3c59x", the system freeze.
> 
> Has someone already test this ?
> 
> This card works perfectly on the same PCI-X slot with a non RT kernel. 
> Do you need some more info ?

use serial logging and the NMI watchdog to debug hard lockups (see the 
info below). Use CONFIG_DETECT_SOFTLOCKUP=y to detect soft lockups. 
Generally the use of debugging options can help as well. Here's a 'full' 
debugging kernel:

 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_PREEMPT=y
 CONFIG_DEBUG_IRQ_FLAGS=y
 CONFIG_WAKEUP_TIMING=y
 CONFIG_WAKEUP_LATENCY_HIST=y
 CONFIG_PREEMPT_TRACE=y
 CONFIG_CRITICAL_PREEMPT_TIMING=y
 CONFIG_PREEMPT_OFF_HIST=y
 CONFIG_CRITICAL_IRQSOFF_TIMING=y
 CONFIG_INTERRUPT_OFF_HIST=y
 CONFIG_CRITICAL_TIMING=y
 CONFIG_LATENCY_TIMING=y
 CONFIG_CRITICAL_LATENCY_HIST=y
 CONFIG_LATENCY_HIST=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 CONFIG_RT_DEADLOCK_DETECT=y
 CONFIG_DEBUG_RT_LOCKING_MODE=y
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_KPROBES is not set
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_4KSTACKS=y

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

