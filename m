Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWEXWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWEXWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWEXWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:11:15 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:8545 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964778AbWEXWLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:11:15 -0400
Message-ID: <4474D9EF.8030504@tls.msk.ru>
Date: Thu, 25 May 2006 02:10:55 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: swsusp in 2.6.16: works fine w/o PSE on a VIA C3?
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just feeling lucky and tried suspend-to-disk cycle
on my VIA C3 machine, which lacks PSE which is marked as
being required for swsusp to work.  After commenting out
the PSE check in include/asm-i386/suspend.h and rebooting,
I tried the whole cycle, several times, with real load
(while running 3 kernel compile in parallel) and while
IDLE... And surprizingly, it all worked flawlessly for
me, without a single glitch...

So the question is: is PSE really needed nowadays?

Ok, "w/o a single glitch"...  Actually there are several
of them so far, but I guess they're unrelated to PSE/C3:

 o Suspend after clean boot is sloooow, it takes quite
   alot of time to write all the stuff to the disk (the
   percents are increasing by 1..2 in a sec).  After
   resume, if I suspend again the whole process takes
   only several secs.

 o There's a single 'failed' message, while *suspending*:

Stopping tasks: ===============================================|
Shrinking memory... done (0 pages freed)
pnp: Device 01:01.00 disabled.
pnp: Device 00:09 disabled.
pnp: Device 00:08 disabled.
ACPI: PCI interrupt for device 0000:00:07.5 disabled
ACPI: PCI interrupt for device 0000:00:07.3 disabled
ACPI: PCI interrupt for device 0000:00:07.2 disabled
swsusp: Need to copy 19322 pages
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:07.2, from 9 to 11
usb usb1: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:07.3, from 9 to 11
usb usb2: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
pnp: Device 00:08 activated.
pnp: Device 00:09 activated.
pnp: Failed to activate device 00:0b.   <========= this one
pnp: Device 01:01.00 activated.

   This is all shown while *suspending*, so it looks like
   the kernel is shutting down all the devices and brings
   them up again for some reason.  PNP device 00:0b is my
   keyboard.

 o There's the following sequence of messages in my dmesg:

Restarting tasks...<6>usb 1-1: USB disconnect, address 2
 done
usb 1-1: new low speed USB device using uhci_hcd and address 3

   It looks like either the formatting is wrong (missing \n in some
   printk() or something), or USB device(s) aren't shutting down/
   powered up at the appropriate time, or the connect/powerup
   event interferes with the stuff happening during "Restarting
   tasks...done" time.  For the end-user this is just a cosmetic
   glitch (improper formatting), but it as well may be some
   more serious prob.

Note I never tried swsusp before, so I've no idea how it usually
looks like, or should look like.  We've servers which never suspend,
we've X terminals (no need to suspend, and it will not work anyway
as the network connections will not be restored anyway), and this
my VIA-C3-based machine, which never worked due to the PSE check.

Thanks.

/mjt
