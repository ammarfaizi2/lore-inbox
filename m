Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTANNyW>; Tue, 14 Jan 2003 08:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTANNyW>; Tue, 14 Jan 2003 08:54:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35206 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263137AbTANNyU>; Tue, 14 Jan 2003 08:54:20 -0500
Date: Tue, 14 Jan 2003 09:04:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Ross Biro <rossb@google.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
In-Reply-To: <1042535166.587.36.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.3.95.1030114090204.1522A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2003, Benjamin Herrenschmidt wrote:

> On Tue, 2003-01-14 at 02:20, Richard B. Johnson wrote:
> 
> > It is not, as you say; "obviously wrong". It is, in fact correct.
> > If you think you will get, as previously stated, the current status
> > by reading the status register of a device, while a posted-write
> > is in-progress, the code is broken. There are warnings all over
> > PCI device hardware specifications about this. 
> 
> Can you point me to such a warning in the PCI2.1 or 2.2 spec please ?
> 
> Ben.


Ok. The "bible" that most of us use is PCI SYSTEM ARCHITECTURE,
Fourth Edition, MindShare, Inc. ISBN 0-201-30974-2
Page 94, "Posting Improves Memory Write Performance", General,
second paragraph;

"When a bridge implements a posted-write buffer, a potential problem exists.
Another bus master (or the same one) may initiate a memory read from the tar-
get of the posted write before the data is actually written to the memory
target. If this were permitted, the master performing the read would not
receive the freshest copy of the information. In order to prevent this
from occurring, before permitting a read to occur on the target bus, the
bridge designer must first flush all posted writes to their destination
targets. A device driver can ensure that all memory data has been written
to its device by performing a read from the device. This will force the
flushing of all posted write buffers in bridges that reside between the
master performing the read and the target device before the read is
permitted to complete."

Now, some persons think that a "memory target" is RAM. Not so. It
is "memory-mapped I/O" that they are taking about. No bridge is
allowed to post writes to devices in I/O space. In other words any
'out' and 'in' instructions are assured, in their words; "real-time
communication". That's in the last sentence of the quoted reference.

There is at least one other such warning in this book, but I
can't locate it at the moment. However, in the AMD Elan SC520
Micro-controller User's manual (the SC520 embeds a PCI bridge),
Page 9-21, pp 9.5.4.8, fourth paragraph; "The PCI bus specification
recommends that the CPU perform a read to the interrupting PCI bus
device, to force all system posted write buffers to flush (including
PCI bus bridges)".

Most of my other references are at home because I finished the
successful design of some fairly complex stuff using PCI devices.
I even wrote the BIOS to initialize everything from scratch.
I brought most of my reference material, necessary to design
the product, home.

When writing a device driver, it is not always necessary to
perform an extra read of the device. It all depends upon the
device. If you are writing to I/O registers, you never have
any problem. But suppose your device is going to produce an
interrupt as soon as it has written a data-packet from a SNIC
(Serial Network Interface Controller) hardware to a memory-mapped
buffer. When your ISR gets control, it MUST read from the
device first to make sure that the posted writes complete
before it actually uses the data.  This usually happens from
normal programming practice because you usually copy (read)
the data. But, if you decided to write the data back to the
device (you wrote a new hardware destination address) and
transmitted the modified packet, all bets are off. The same
problem occurs with hardware data that is used as a semaphore.

A similar problem occurs when an I/O bit is used to show that
a memory-mapped I/O operation has occurred. The I/O mapped bit
may show that data are available long before it is. Many
Network device drivers expose this potential problem by looping
in the ISR, so-called interrupt mitigation. This is one of the
reasons for some PCI SNICs locking up and having to be restarted
by a timer.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


