Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVGFSpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVGFSpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVGFSpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:45:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22232 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261836AbVGFNj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:39:28 -0400
Date: Wed, 6 Jul 2005 15:39:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706133915.GB19467@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061351.18410.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061351.18410.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Then it continues to boot. I'm getting periodic lockups under high 
> network load, however, though I suspect that might be the ipw2200 
> driver I compiled against the realtime-preempt kernel. Are there any 
> known issues with external modules versus PREEMPT-RT?

you should keep an eye on compile-time warnings, but otherwise, most of 
the API deviations should be runtime detected and should be reported in 
one way or another (if you have all debugging options enabled).

> Any way to debug these problems?

Is it a hard lockup? One good way to debug it is via serial logging and 
the NMI watchdog. I've attached a QuickStart below. Another method to 
debug hard lockups is to enable 'direct keyboard interrupts', via:

  echo 1 > /proc/sys/kernel/debug_direct_keyboard

note that with that switch activated you can use SysRq even when the 
system is otherwise locked up, but the keyboard IRQ might crash. So the 
best tactic is to not use the keyboard from that point on, only for the 
short period of time when you try to get info out of a crashed system, 
via SysRq. There's more about this flag in this post:

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0411.2/0936.html

	Ingo

-------------------------
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

