Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbRCDT4X>; Sun, 4 Mar 2001 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbRCDT4O>; Sun, 4 Mar 2001 14:56:14 -0500
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:62099 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130498AbRCDT4F>; Sun, 4 Mar 2001 14:56:05 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
Date: Sun, 4 Mar 2001 20:55:33 +0100
Message-Id: <19350127132717.21015@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.10.10103031601260.455-100000@cassiopeia.home>
In-Reply-To: <Pine.LNX.4.10.10103031601260.455-100000@cassiopeia.home>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So once again I vote for the introduction of
>isa_{request,release}_mem_region(), just like we already have isa_readb() and
>friends.

Well, it's the same problem as the IO, there may be more than one ISA mem
region,
especially when you put 2 video cards on 2 different PCI hosts (even without a
PCI-ISA bridge).

In fact, with a PCI-ISA bridge, I can imagine a config where you need 2 ISA IO
regions and 2 ISA mem regions on the same PCI bus if that bridge does address 
translation.

My concern for now is mostly to get video cards fixed, I don't care much about
legacy ISA hardware as in those case, I guess we can limit ourselves to a
single
ISA bus and inb/oub beeing happy to cope with it.

The problem is that we use the same macros (inb/outb) to access that ISA bus,
and to access any PCI IO bus. Well, I would suggest the following:

 - inb/outb without offset -> the ISA bus if any, or the IO space of the
   first PCI host
 - inb/outb with offset (or encoded HBA number) -> IO space of an other bus
 - pci_get_bus_io_base() returns the IO offset for accessing the Nth PCI
   bus IO space so that the fb devs can do VGA IOs on the bus that holds
   their card.
 - pci_get_bus_isa_mem_base() returns the base address at which isa mem
   is available for a given PCI bus (that is the address that generates
   mem cycles in the range 0->64k). This is a physical address, the driver
   still have to ioremap it. Some PCI cards can have a BAR mapping the
   VGA memory elsewhere, drivers for those cards should prefer the BAR
   mapping of course.

All IO ranges can be mapped via kernel VM tricks into a single contiguous
space
with the offset beeing something like a 64k increment, or we can have the
inb/outb
do a lookup of the host bus like on parisc. That's an arch implementation
detail.

Is that ok ? I know it's not perfect, but it would allow to solve the most
important problem for now. The PCI cards in need of IOs (like PCI IDE cards)
can have their resources fixed up by the arch code in order to tap the correct
bus. Only the real legacy ISA drivers will be limited to the fixed (default)
ISA bus.

Ben.

