Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVJMH36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVJMH36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 03:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVJMH36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 03:29:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:27013 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750822AbVJMH36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 03:29:58 -0400
Date: Thu, 13 Oct 2005 09:30:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault at boot
Message-ID: <20051013073029.GA12801@elte.hu>
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> Config file attached. The only change was to enable IRQ-off latency 
> tracing using make menuconfig. Rebuild and reboot. I got a message 
> about the kernel not syncing, lots of stuff above that message about 
> do_futex, etc.

i cannot reproduce your problems - your .config works fine on my x64 
box. A log of the crash would be needed - do you have a null-modem cable 
to connect this box to some other nearby box to do serial logging? If 
yes then there is a mini-howto below. (for x86, but it works the same 
for x64)

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

