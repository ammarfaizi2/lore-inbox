Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRAGXxi>; Sun, 7 Jan 2001 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbRAGXx3>; Sun, 7 Jan 2001 18:53:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130870AbRAGXxL>; Sun, 7 Jan 2001 18:53:11 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Related VIA PCI crazyness?
Date: 7 Jan 2001 15:52:41 -0800
Organization: Transmeta Corporation
Message-ID: <93avg9$rlk$1@penguin.transmeta.com>
In-Reply-To: <20010107122800.A636@kantaka.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010107122800.A636@kantaka.co.uk>,
Philip Armstrong  <phil@kantaka.co.uk> wrote:
>In supplement to Evan Thompson's emails with the subject "Additional
>info. for PCI VIA IDE crazyness. Please read." I've noticed the
>following message with recent 2.4.0 test + release kernels:
>
>IRQ routing conflict in pirq table! Try 'pci=autoirq'

But the machine still works fine, ie the SCSI driver and the network
driver still seem happy?

If so, it sounds like maybe the VIA pirq router functions are buggy (it
looks like the sense of pirq 01 and pirq 03 are reversed).

The problem Evan Thompson saw was apparently simply due to the magic
meaning of the 0xfe and 0xff pirq entries, and has apparently been fixed
by handling those correctly in the final 2.4.0.

Christian Engstler seems to have a problem much like yours, where it
gets a different irq line than the one that is apparently in use.  It
looks like Christian, too, has a working machine, and that the only bad
result of this all is an annoying printk message.  Can you confirm that
things actually work for you too, and you'd just like to get rid of the
unnerving message?

If the VIA logic for getting/setting the irq is wrong, it should only be
a problem if there are devices that _haven't_ been routed by the BIOS. 
Usually these devices are limited to things like USB, ACPI and CardBus
controllers, and getting the irq routing wrong in that case can be
deadly (infinite irq streams on the wrong irq line). 

The case where you get an annoying message are the cases where Linux
knows something is wrong, but decides to take the safe approach - it
seems to be working for you, as far as I can tell, but that message
_does_ mean that we may have problems on other machines with the VIA
chipset. 

I _think_ the VIA routing functions were done by Jeff Garzik, Cc'd.

Looking at the VIA irq routing, it looks a bit strange. We have pirqa in
the high nybble of config sparce port 55h, then we have pirqb and c in
56h (low and high nybbles respectively), and then we have pirqd in the
high nybble of 57h.

The reason this is strange is that it's not consecutive nybbles.  I'd
have expected pirqd to show up in the _low_ nybble of 57h.  But as the
pirq routing fields are pure software convention, it's hard to know
whether this is already taken into account in the pirq routing table or
what the magic is. 

Could anybody with a VIA chip who has the energy please do something for
me:
 - enable DEBUG in arch/i386/kernel/pci-i386.h
 - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
   "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
   numbers for them are 1106:0586 and 1106:0596, I think)
 - do a cat /proc/pci

With that, I and Jeff can probably match up the interrupt routing table
entries with the devices, and check what the routing information in the
config space of the actual router chip is, to verify what the pirq
translation really should be.

It's entirely possible that the Linux irq routing is already correct,
and that the warning is due to a bug in the pirq table itself (and
nobody has cared, because Windows works fine and picks up the value that
the BIOS wrote to the device config spaces the same way Linux does - and
Windows probably doesn't warn about the pirq table issue at all).

		Linus

----
>PCI: Interrupt Routing Table found at 0xc00fdf00
>00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
>00:09 slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
>00:0a slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
>00:0b slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
>00:0c slot=05 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
>00:07 slot=00 0:00/deb8 1:00/deb8 2:00/deb8 3:00/deb8
>PCI: Using IRQ router VIA [1106/0586] at 00:07.0
>...
>SCSI subsystem driver Revision: 1.00
>IRQ for 00:08.0:0 -> PIRQ 01, mask deb8, excl 0e00 -> newirq=11 -> got IRQ 9
>IRQ routing conflict in pirq table! Try 'pci=autoirq'
>scsi0 : AdvanSys SCSI 3.2M: PCI Ultra 240 CDB: IO E800/F, IRQ 11
>...
>8139too Fast Ethernet driver 0.9.13 loaded
>IRQ for 00:0a.0:0 -> PIRQ 03, mask deb8, excl 0e00 -> newirq=9 -> got IRQ 11
>IRQ routing conflict in pirq table! Try 'pci=autoirq'
>eth0: RealTek RTL8139 Fast Ethernet at 0xc8c39000, 00:40:95:33:7a:51, IRQ 9
>eth0:  Identified 8139 chip type 'RTL-8139B'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
