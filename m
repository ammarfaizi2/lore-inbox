Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTANOZ7>; Tue, 14 Jan 2003 09:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTANOZ4>; Tue, 14 Jan 2003 09:25:56 -0500
Received: from [217.167.51.129] ([217.167.51.129]:5824 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S262812AbTANOZw>;
	Tue, 14 Jan 2003 09:25:52 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: root@chaos.analogic.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Ross Biro <rossb@google.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030114090204.1522A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030114090204.1522A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042554928.587.57.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Jan 2003 15:35:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 15:04, Richard B. Johnson wrote:

> "When a bridge implements a posted-write buffer, a potential problem exists.
> Another bus master (or the same one) may initiate a memory read from the tar-
> get of the posted write before the data is actually written to the memory
> target. If this were permitted, the master performing the read would not
> receive the freshest copy of the information. In order to prevent this
> from occurring, before permitting a read to occur on the target bus, the
> bridge designer must first flush all posted writes to their destination
> targets. A device driver can ensure that all memory data has been written
> to its device by performing a read from the device. This will force the
> flushing of all posted write buffers in bridges that reside between the
> master performing the read and the target device before the read is
> permitted to complete."

That is ok. What you read is also in the PCI spec, that is the PCI
bridge doing write buffering has to flush it's write buffer before
letting any read go. This is why we can use a read from the same bus
path to flush the write buffer, but nowhere in the above text it says
that the actual data read would be incorrect. It would have been _if_
the bridge didn't respect the described behaviour, but this behaviour is
quite an important part of PCI spec and I yet to encounter a bridge not
doing it properly.

> Now, some persons think that a "memory target" is RAM. Not so. It
> is "memory-mapped I/O" that they are taking about. No bridge is
> allowed to post writes to devices in I/O space. In other words any
> 'out' and 'in' instructions are assured, in their words; "real-time
>communication". That's in the last sentence of the quoted reference.

Good. That means that in theory, as Alan pointed out, IO is safe from
PCI posting issues. Unfortunately, regarding the IDE code, we still have
to deal with MMIO controllers (ide-pmac like or just new MMIO PCI
controllers that tend to appear on the PC market). We also have to deal
with platforms that don't do IO at the CPU level (all non-x86 afaik) and
have a write buffer on the bus path before reaching the PCI host. So the
problem remains for a bunch of controllers.

> There is at least one other such warning in this book, but I
> can't locate it at the moment. However, in the AMD Elan SC520
> Micro-controller User's manual (the SC520 embeds a PCI bridge),
> Page 9-21, pp 9.5.4.8, fourth paragraph; "The PCI bus specification
> recommends that the CPU perform a read to the interrupting PCI bus
> device, to force all system posted write buffers to flush (including
> PCI bus bridges)".

Again, that doesn't mention the fact that data read then would be
incorrect. Beleive me, it is correct ;)

> Most of my other references are at home because I finished the
> successful design of some fairly complex stuff using PCI devices.
> I even wrote the BIOS to initialize everything from scratch.
> I brought most of my reference material, necessary to design
> the product, home.
> 
> When writing a device driver, it is not always necessary to
> perform an extra read of the device. It all depends upon the
> device. If you are writing to I/O registers, you never have
> any problem. But suppose your device is going to produce an
> interrupt as soon as it has written a data-packet from a SNIC
> (Serial Network Interface Controller) hardware to a memory-mapped
> buffer. When your ISR gets control, it MUST read from the
> device first to make sure that the posted writes complete
> before it actually uses the data.  This usually happens from
> normal programming practice because you usually copy (read)
> the data. But, if you decided to write the data back to the
> device (you wrote a new hardware destination address) and
> transmitted the modified packet, all bets are off. The same
> problem occurs with hardware data that is used as a semaphore.

Yah; that's a typical issue with posted write on PCI, though not the
only one. Also don't forget that interrupt are basically asynchronous.
That is disabling IRQ emission on your device, even with the proper read
to flush posted writes, doesn't gurarantee that you won't get an
interrupt right after. The interrupt may well have been issues previous
to your write and been buffered for a few ns in it's path up to your CPU
(interrupt controller, CPU itself has asynchronous IRQ handling, etc...)

> A similar problem occurs when an I/O bit is used to show that
> a memory-mapped I/O operation has occurred. The I/O mapped bit
> may show that data are available long before it is. Many
> Network device drivers expose this potential problem by looping
> in the ISR, so-called interrupt mitigation. This is one of the
> reasons for some PCI SNICs locking up and having to be restarted
> by a timer.

