Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282941AbRLFPMd>; Thu, 6 Dec 2001 10:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283274AbRLFPMV>; Thu, 6 Dec 2001 10:12:21 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:52485 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S282242AbRLFPLb>; Thu, 6 Dec 2001 10:11:31 -0500
Date: Thu, 6 Dec 2001 10:11:24 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Cory Bell <cory.bell@usa.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <1007622026.2340.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 Dec 2001, Cory Bell wrote:

> http://www.microsoft.com/hwdev/archive/BUSBIOS/pciirq.asp, "The non-zero
> link values are specific to a chip set and decided by the chip-set
> vendor."

My reference has been a borrowed book at my work, "PCI Hardware and
Software, Architecture and Design. 4th ed", Appendix I "IRQ Routing Table
Example.".. it also says it's motherboard and chipset specific.

> I think I'm onto something though - in read_config_nybble (called by
> pirq_ali_get), the link number (0x59 for the usb device) minus one is
> (after a little mangling) added to the "magic offset" 0x48 to generate
> the offset at which a nybble is read from the pci configuration space of
> the IRQ Router (dev 0:7.0). Since the code is expecting 0x1-0x8, it
> doesn't check for wildly larger numbers. On my box, my first nybbles at
> 0x48 are 9, 9, and 5, which if you pass it through the Captain ALi
> decoder ring equals irq's 11, 11, and 5. Therefore, links 0x01-0x03 work
> fine, but link 0x59 translates to an offset of 0x74, which (on my
> machine, and I bet yours) contains 0x01. The first nybble of 0x01 is
> 0x1, which on the translation table equals... IRQ 9! I imagine if you
> "lspci -vxxx -s 00:07" you'll see something like 0x5009 at offset 0x6b
> and 0x01 at offset 0x74. Would you mind sending me a "dump_pirq" and a
> "lspci -vxxx -s 00:07"? I'd like to compare them to mine to see if what
> I think is happening is really happening.

You are absolutely correct :) I did the same thing a few weeks ago (when i
was really working on it), and traced the lspci -vvxxx output and
interpreted everything linux was saying about it.  I was looking at it
from the acpect of maybe just changing the PCI router in config space as
well as the PCI irq from user space without requiring kernel changes at
all.  The reason why I didn't try that was because i chickened out and
didn't know wether changing the PIRQ table woudl a) work or b) permanently
screw up my machine.  This may still be the "correct way" however...

The other reason I stopped was that USB works, on IRQ 9, under windows
(although, it does reset the bus about once every 5 minutes or so...
highly annoying when playing games).  So maybe, just maybe, the IRQ table
is right, and maybe its linux's acpi implementation that's not playing
nice.

> You're probably right about the BIOS being the root of the problem, but
> if Linux is going to use the PIRQ table, it should at least do it
> correctly. Hell, maybe the BIOS is reading the same table the same way
> and that's where *it's* getting IRQ 9 - it's just bizzare enough to be
> possible... :>

Actually, i think the BIOS might "adjust" the pIRQ table at boot to match
it's view of the world.  I don't know.

> According to MAINTAINERS and linux/arch/i386/kernel/pci-irq.c, it's
> Martin Mares - mj@ucw.cz, which is why I cc'd him on the first message.
> Haven't heard from him, though.

I would really appreciate comments from someone who'se had more experience
than us with pIRQ problems...

I guess the question is where to we proceed from here.  Our "best option"
may be to, at DMI scan time, recognise our laptops and change both PCI
config space and the routing table to point to irq 11.  And then we just
have to be brave enough to try it.  PCI config spae I don't mind mucking
with... internal chipset registers on the ISA bridge, that scares me
without proper documentation.  Maybe we should ask ALi for it?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


