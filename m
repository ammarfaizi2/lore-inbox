Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbSJOTqa>; Tue, 15 Oct 2002 15:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSJOTq3>; Tue, 15 Oct 2002 15:46:29 -0400
Received: from h-64-105-136-201.SNVACAID.covad.net ([64.105.136.201]:55744
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263319AbSJOTq2>; Tue, 15 Oct 2002 15:46:28 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 15 Oct 2002 12:52:07 -0700
Message-Id: <200210151952.MAA04189@adam.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org, mochel@osdl.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:

>> >If there is non-trivial work to detect if a card is present it
>> >probably makes sense to factor remove into
>> >->quiet() and ->remove()
>> >Where quiet would put the device into a quiescent state, and
>> >remove would simply clean up the driver state.
>> 
>>         Splitting into ->quiet() and ->removed() would be helpful
>> in any case, where removed() would normally not touch the hardware,
>> since it is quite possible the device has already been removed,
>> since the callers of these routines generally know if they are
>> calling because the device has been removed or because they want
>> just want to turn it off, while ->remove() currently has to guess,
>> which not only wastes time but also can be difficult to do safely
>> when you don't know if the device that you're talking to is even
>> present anymore.

>Except for the case when a device is physically swapped before ->remove()
>which is really, really, nasty.  But it is quiet unlikely anyone will
>actually be that fast.  Whatever talks to the hardware has to check to
>see if it's device  is present.  But if usb is anything like PCI it 
>should be a very inexpensive check to see if a driver is present.  And
>writes to a non-existent device should be safe.

	I am not aware of any hotplug bus where removing a device and
inserting a new one leads to the new device being in a state where the
driver for the old device could accidentally talk to it without the
kernel actively doing something in the meantime like turning the
affected socket back on.

	For example, for USB, the hub port will the new device will be
plugged in (and the computer will be notified of this by the hub) but
the hub port will not remain connected.  The computer has to turn the
hub port back on.  The whole USB initialization process is documented
extremely well in the USB 2.0 standards which you can download for
free at http://www.usb.org, and it is also documented in the MindShare
books (_Universal Serail Bus System Architecture_ by Don Anderson and
Dave Dzatko, both 1st and 2nd Edition), although it is just as clear in
the standards document.

	For FireWire, both the removal and the insertion cause cause
all addresses of all devices to be reassigned, and the new device will
not have an address before that is complete, at least if I am
correclty reading _FireWire Sytem Architecure, 2nd Edition_ by Don
Anderson, as I haven't read the standard.

	I know that PCMCIA can power down a socket.  I assume that the
interrupt that detects card removal does this or otherwise disconnects
the socket when a card is removed and that the kernel does not turn
the socket back on until the remove routine for the card has
completed.  [From the manaul page for cardctl and looking at the
CardServices interface described in _PCMCIA System Architecture_,
2nd Edition by Don Anderson.]

	For CardBus, I assume that PCMCIA's protections apply, and I
suspect the PCI base address registers are defined to be clear at
insertion, so the device-specific IO ports and memory regions will not
be mapped.  In addition, the kernel does book keeping on which IO
ports and memory regions are currently allocated with
request_region(), so I assume it would assign the newly plugged in
card's IO and memory elsewhere if even if it were, so it may even be
safe for the kernel to map the new card and start its initialization
before the clean up for the old card has completed.

	For hotplug PCI, CompactPCI and PCI Mezzanine Cards, it seems
the user actually has to ask permission to insert and remove cards,
but, even so, a newly inserted card is initially electrically isolated
from the PCI bus, and the computer uses special hardware that allows
it to provide power and assert the PCI RST# signal for that card only
before deasserting RST# and then connecting it to the rest of the bus.
This clears the newly inserted card's PCI base address
registers. [_PCI System Architecture_, 4th edition by Tom Shanley and
Don Anderson, Chapter 22: Hot-Plug PCI, pages 464-465, 753-754.  Alas,
the pcisig.org standards are propritary.]  What I said about the
request_region() bookkeeping for CardBus applies here too.

	Besides, you have not identified a safe way that a combined
->remove() function can detect such situations more reliably than
separate ->quiet() and ->removed(), which at least have the benefit of
knowing what the kernel currently thinks the situation is.  So, you
really have no basis for saying "Splitting ->remove() into quiet() and
->removed() will be racy."

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
