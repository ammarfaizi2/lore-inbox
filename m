Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285025AbRLFHJq>; Thu, 6 Dec 2001 02:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285026AbRLFHJh>; Thu, 6 Dec 2001 02:09:37 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:38290 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285025AbRLFHJ3>; Thu, 6 Dec 2001 02:09:29 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 05 Dec 2001 23:00:24 -0800
Message-Id: <1007622026.2340.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 08:41, John Clemens wrote:
> Sure.. I'll put yours up thought because it's slightly less intrusive.  I
> was hoping to find out a much cleaner way of doing this before I put it
> up for anyone to use.... so i posted it here first... but as they say, the
> silence was deafening...

Tell me about it. I've emailed ALi to ask if they'll provide docs on how
to interperet link numbers. According to Microsoft's "PCI IRQ Routing
Table Specification" at
http://www.microsoft.com/hwdev/archive/BUSBIOS/pciirq.asp, "The non-zero
link values are specific to a chip set and decided by the chip-set
vendor."

> I'm afraid we may both be in over our heads here.  That link number
> sppears to be some sort of code to help routing (see code for "see if
> hard-coded, it checks for 0xf"), and the mask is just what
> you think it is.  However, from my gatherings, pIRQ tables are often wrong
> and thus ignored by Linux a lot of times.  I think the -real- problem here
> is the bios is assigning IRQ's to PCI devices, and assign's 9 to the USB
> on startup, writes that to it's config registers, and Linux is stuck with
> it.  But that's just speculation.

Over my head? I can't even see the surface from where I am...but I'm
learning. :>
See link above. BTW, the only instances I remember hearing about the
PIRQ table being wrong was in SMP machines, where you have an io-apic
anyway.

I think I'm onto something though - in read_config_nybble (called by
pirq_ali_get), the link number (0x59 for the usb device) minus one is
(after a little mangling) added to the "magic offset" 0x48 to generate
the offset at which a nybble is read from the pci configuration space of
the IRQ Router (dev 0:7.0). Since the code is expecting 0x1-0x8, it
doesn't check for wildly larger numbers. On my box, my first nybbles at
0x48 are 9, 9, and 5, which if you pass it through the Captain ALi
decoder ring equals irq's 11, 11, and 5. Therefore, links 0x01-0x03 work
fine, but link 0x59 translates to an offset of 0x74, which (on my
machine, and I bet yours) contains 0x01. The first nybble of 0x01 is
0x1, which on the translation table equals... IRQ 9! I imagine if you
"lspci -vxxx -s 00:07" you'll see something like 0x5009 at offset 0x6b
and 0x01 at offset 0x74. Would you mind sending me a "dump_pirq" and a
"lspci -vxxx -s 00:07"? I'd like to compare them to mine to see if what
I think is happening is really happening.

You're probably right about the BIOS being the root of the problem, but
if Linux is going to use the PIRQ table, it should at least do it
correctly. Hell, maybe the BIOS is reading the same table the same way
and that's where *it's* getting IRQ 9 - it's just bizzare enough to be
possible... :>

So, am I crazy, or does this make any sense to you? I cobbled together
the following mangled perl, adapted from the irq-routing code to test my
hypotheses:

perl -e '$link = 0x59 ; $val = 0x21 ; $link = $link - 1; $offset = 0x48 + ($link >> 1) ; $nyb = (($link & 1) ? ($val >> 4) : ($val & 0xf)); printf("Link %02x, Offset %02x, Val %02x = Nybble %1x\n",$link+1,$offset,$val,$nyb);'

Just give it the link# and it should tell you the offset and nybble to
look at in config space. It may even be correct!

> Yes, they just don't print out anymore (see
> arch/i386/kenrel/dmiscan.c<?>).

I see. I thought linus didn't like c++ style comments in kernel code?

> Who maintains the PCI irq routing code?

According to MAINTAINERS and linux/arch/i386/kernel/pci-irq.c, it's
Martin Mares - mj@ucw.cz, which is why I cc'd him on the first message.
Haven't heard from him, though.

> john.c

Ha. :>

-Cory

