Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQKRSMQ>; Sat, 18 Nov 2000 13:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbQKRSL4>; Sat, 18 Nov 2000 13:11:56 -0500
Received: from APh-Aug-101-1-3-104.abo.wanadoo.fr ([193.252.111.104]:1284 "EHLO
	sawtooth.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129267AbQKRSLp>; Sat, 18 Nov 2000 13:11:45 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: About IOs, ISA, PCI, and life (WAS: VGA PCI IO port...)
Date: Sat, 18 Nov 2000 18:41:15 +0100
Message-Id: <19341013111259.29171@192.168.1.10>
In-Reply-To: <8v49so$tlt$1@cesium.transmeta.com>
In-Reply-To: <8v49so$tlt$1@cesium.transmeta.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>One way to do this is to treat PCI IO and ISA IO as two separate
>address spaces.  The PCI IO address space is a 14-bit address space
>(bits 9:8 are always zero) ranging from 0x1000 to 0xFCFF.  ISA IO is a
>10-bit space (bits 15:10 are available for the card to use) ranging
>from 0x100 to 0x3FF.
>
>VGA cards may be PCI and AGP, but still have allocations in the ISA
>range.

I'd love to see PCI and ISA IOs treated differently too.

I'm seeing more and more esoteric PCI setups (especially on some huge PPCs
with several host bridges), various different ways to access PCI mem and
ISA, various ways to handle the ISA "special case" for memory, etc...

When you have to deal with various separate PCI IO spaces, each one having
it's own address space, and each one potentially having devices that want
to do IOs or "legacy" ISA IOs, then you are screwed.

Currently, we don't really support IOs on anything but the "primary" PCI bus
(choosen arbitrarily) unless platform-specific driver hacking is done.

We could use the MMU mappings to let the kernel think all those IO spaces
are actually one big contiguous region, and remap them all together. This way,
a simple resource fixup would make PCI drivers using IO resources work at
least.
But in this case, "ISA" IOs will have to be restricted to one of the IO
busses,
decided arbitrarily.

But what about 2 video cards on the AGP port and one PCI slot of a G4 Mac ?

This machine, just an example, have those on different host controllers with
separate IO spaces. If those cards need to be driven with VGA accesses (for
running a BIOS emulator for example, or just because you have no choice),
then you are screwed. All you can do is have one bus support VGA IOs.

Another issue is ISA memory space, for the same reason as above (multiple
busses), but also because a lot of PCI controller setup can't forward
memory cycles below 0x80000000 or such arbitrary physical address. Some
of them (most but not all) provide a way via a separate physical address
to access a 64k "ISA" memory space that generates low-address PCI cycles.

So you can have one or more ISA IO busses, and 0 or more ISA memory busses.

A solution for that would be to have VGA and other legacy ISA drivers in
the kernel change the way they use the IO access macros.

One idea I have, would be to either keep a virtual ISA "bus number" along
with kernel support functions to count them, get virtual base addresses for
IO & memory, query about availability of those, etc...

Another would be to link that more tighly with PCI by adding generic functions
to request the virtual base address of each PCI IO and ISA-memory space.
We already have a syscall on some platforms (PPC, Alpha) to request those
informations from userland (XFree).

I'm not sure about the best way that could fit in the resource
architecture yet. I have different problems with PCI resources for now
(mostly with host bridges that provide several discontiguous decoding
ranges)...

Ben.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
