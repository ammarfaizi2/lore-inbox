Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSHENao>; Mon, 5 Aug 2002 09:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318459AbSHENao>; Mon, 5 Aug 2002 09:30:44 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:64161 "EHLO
	teapot.home.test") by vger.kernel.org with ESMTP id <S318458AbSHENan>;
	Mon, 5 Aug 2002 09:30:43 -0400
Subject: PROBLEM: I/O ports allocation bug in Linux kernel 2.4.18-3
From: Felipe Alfaro Solana <falfaro@borak.es>
To: linux-kernel@vger.kernel.org
Cc: dhinds@zen.stanford.edu, mj@ucw.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 15:30:15 +0200
Message-Id: <1028554215.1309.58.camel@teapot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
=======

Linux kernel 2.4.18-3 fails to allocate resources for a 3Com 3CCFE575CT
CardBus 10/100 Ethernet Controller.

Full description
================

I have found a very strange problem with my new 3Com 3CCFE575CT 10/100
CardBus Ethernet adapter on my NEC Chrom@ laptop, using a Texas
Instruments PCI4450 PC card Cardbus Controller.

When I use the kernel stock PCMCIA/CardBus support and 3Com NIC drivers
(3c59x.o) modules, during system boot, the kernel is unable to
successfully assign 0x100 ports for the 3Com card. The PCMCIA subsystems
tries to assign an I/O port starting at 0x1000, but for some misterious
reason, the PCI resource allocation algorithm (in
drivers/pci/setup-res.c) fails at the very end. The problem is that the
starting I/O port is set to 0x1000, but the ending port number is not
found to be 0x1100, but 0x2c3. Curiously, 0x2c0-0x2c3 is the I/O ports
range used by the Texas Instruments CardBus host bridge, and I don't
understand why the pci_assign_bus_resource() function ends up with I/O
ports 0x1000->0x2c3. Of course, the allocation fails because the ending
port is lower than the starting port and also, 0x2c3 is already being
used by the Texas Instruments CardBus bridge.

I have solved the problem by using the pcmcia-cs from sourceforge.net.
The PCMCIA/CardBus support from this package works flawlessly. Now, I'm
using the cb_enabler.o module (which seems to correctly assign the I/O
ports for my 3Com card at 0x200->0x2ff) and the "3c575_cb.o" module.
Curiously, the 0x200->0x2ff I/O range (as listed by /proc/ioports) is
assigned to the "cb_enabler.o" module and not the 3Com (3c575_cb.o)
driver itself.

Why does the kernel fail when attempting to reserve resources for my
3Com card? I think it's an interaction problem between the PCI
allocation algorithm and my Texas Instruments CardBus bridge, because I
have plugged the card on another machine (with a different CardBus
bridge controller) and it works with stock kernel support. Also, it
works flawlessly on my computer on Windows XP with no additional
support, changes or drivers.

Why does it work correctly when using pcmcia-cs from sourceforge.net and
use its own PCMCIA/CardBus drivers? Why is "cb_enabler.o" able to
allocate 0x100 ports for my NIC, but the kernel is not? Why is the PCI
resource allocation algorithm trying to take an I/O port which is
assigned to a device (the TI controller)? Is this a bug?

I'm willing to help you as much as possible to find the culprit of this
strange behavior. Please, help me out!

Sincerely,

   Felipe Alfaro Solana
   Ocassionally playing with the kernel

PS: Please, CC to me as I'm not subscribed to the list.
