Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129702AbQKQRoN>; Fri, 17 Nov 2000 12:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbQKQRoD>; Fri, 17 Nov 2000 12:44:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129227AbQKQRn5>; Fri, 17 Nov 2000 12:43:57 -0500
Date: Fri, 17 Nov 2000 12:13:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <3A155E8C.7D345649@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001117114858.19946A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Jeff Garzik wrote:

> Russell King wrote:
> > I've been looking at a number of VGA cards recently, and I've started
> > wondering out the Linux resource management as far as allocation of
> > IO ports.  I've come to the conclusion that it does not contain all
> > information necessary to allow allocations to be made safely.
> > 
> > Thus far, VGA cards that I've looked at scatter extra registers through
> > out the PCI IO memory region without appearing in the PCI BARs.  In fact,
> > for some cards there wouldn't be enough BARs to list them all.
> 
> > For example, S3 cards typically use:
> > 
> >  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
> >  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
> >  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
> >  0xff00 - 0xff44
> [...]
> > Surely we should be reserving these regions before we start to allocate
> > resources to PCI cards?
> 

This can't be. If the IO decode doesn't exist in the BAR, the board
can't access that address if it exists above 0x1000. Some ISA compatibable
ports are decoded by some SVGA boards so that the BIOS can do an
early initialization of compatible boards before the board's ROM bios
is located, shadowed, then executed.

Anything you see above 0x1000, that seems to be coming from a PCI
video board, has got to be an ISA alias and can be ignored.

When you write bits to the base address registers, these turn out
to be the physical bits set into the hardware decoder. That's why,
if you need N kb of address space, it needs to be on a N kb boundary.

If these bits are not set, the board is isolated.

In the same vain, Linux may not have the information available to
properly allocate addresses to PCI and AGP boards. This happens
because some devices will fail if you change their addresses once
they are initialized (Most SCSI controllers). Therefore you
can't change them.

This means that you can't really change anything else.


What the BIOS does:

(1)	Learn the last address occupied by memory.
(2)	Learn the lowest unaliased port address above 0x1000.
(3)	Starting with the bridge, allocate resources both
	ports and memory addresses. 
	The memory addresses start after the last RAM.
	The port addresses start after the last alias.
	The I/O or memory enables are usually left OFF.
(4)	Copy any BIOS found for screen cards and IPL devices,
	shadow them, remove the BIOS decode, then execute
	their initialization code. These I/O or memory enables
	are left ON.

If Linux tries to do this after, say a BusLogic SCSI controller
booted it, it may set a different I/O address for the SCSI controller.
Since the SCSI controller needs a hardware reset to accept new
I/O decodes, you are dead. Several "smart" controllers are like
this. They have processors that "remember" stuff that you'd like
them to forget.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
