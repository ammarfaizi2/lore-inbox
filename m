Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUJITwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUJITwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUJITwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:52:30 -0400
Received: from gw.anda.ru ([212.57.164.72]:44553 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S267338AbUJITwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:52:19 -0400
Date: Sun, 10 Oct 2004 01:52:06 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
Message-ID: <20041010015206.A30047@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm transiting myself to the 2.6 kernel base.  And I have a persisting
problem with my ISA Courier modem.  It is set into the PnP mode thru
its jumpers and it works just fine under 2.4 kernels.  And under
2.6.8.1 it doesn't work for the set of reasons.

First.  The new kernel detects it thru the startup:

        isapnp: Scanning for PnP cards...
        isapnp: Card 'USRobotics Courier V.Everything'
        isapnp: 1 Plug & Play card detected total

But the modem isn't activated.  After a boot I have:

        cat /sys/devices/pnp1/01:01/01:01.00/resources
        state = disabled

and /dev/tts/2 device is just died (I'm using devfs for a while).

Then I try to activate it as described in the Documentation/pnp.txt:

        echo auto > /sys/devices/pnp1/01:01/01:01.00/resources

        cat /sys/devices/pnp1/01:01/01:01.00/resources
        state = disabled
        io 0x3e8-0x3ef
        irq 5

So, both the irq and io have been assigned correctly, but the card is
still disabled.

Then I try:

        echo activate > /sys/devices/pnp1/01:01/01:01.00/resources

        cat /sys/devices/pnp1/01:01/01:01.00/resources
        state = active
        io 0x3e8-0x3ef
        irq 5

Ok, some result has been achieved.  Then I load the serial modules:
8250 and 8250_pnp (in that order).  If I load them before the
activating of the card, I have nothing (of course?).  So, I load them
after that, but some interesting things happen here too: 8250 module
finds the modem, but 8250_pnp finds the other two serial ports which
are in the motherboard.  I wonder: these ports are the embedded ones,
they are not PnP, so why they are detected by the pnp module?  And,
from the other hand, why the PnP card is detected by the non-pnp
module?

But nevertheless, some result are already here: it seems that
/dev/tts/2 has come to life - stty -F /dev/tts/2 starts to work.

But after that nobody can conversate with the modem: mgetty, ppp's
chat, minicom - all of them have a timeouts waiting for a respond from
the modem.  And what else do I have:

        cat /proc/tty/driver/serial
        serinfo:1.0 driver revision:
        0: uart:16550A port:000003F8 irq:4 tx:8 rx:208 fe:4 brk:7
        1: uart:16550A port:000002F8 irq:3 tx:1959289 rx:11505900 RTS|CTS|DTR|DSR|CD
        2: uart:16550A port:000003E8 irq:4 tx:0 rx:0 CTS|DSR
        3: uart:unknown port:000002E8 irq:3
        4: uart:unknown port:00000000 irq:0
        5: uart:unknown port:00000000 irq:0
        6: uart:unknown port:00000000 irq:0
        7: uart:unknown port:00000000 irq:0

According to this info, the ttyS2 device have an irq 4 assigned
vs. irq 5 from the /sys/.../resources.  I don't know, may be it is the
problem itself.  BTW, the first two serial ports work - there is a
mouse at the ttyS0 and the external modem at the ttyS1.

So, this all looks like some error in the PnP-sysfs-serial chain, but
I'm absolutely unsure.  May be it is the devfs-related problem?


And all the above in short:

1) The 2.6 kernel doesn't activate the ISA PnP modem at the boot,
   while the 2.4 one always does.

2) The 8250 driver finds the PnP card's port, while the 8250_pnp finds
   the non-PnP ports.

3) The /proc/tty/driver/serial file contains an incorrect information
   about the IRQ assigned to the PnP port.
