Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154230-219>; Fri, 11 Dec 1998 18:24:59 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:4199 "EHLO smtp1.cern.ch" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <154714-219>; Fri, 11 Dec 1998 04:58:10 -0500
To: Linux Lists <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.rutgers.edu>
Subject: Re: Access to I/O-mapped / Memory-mapped resources
References: <Pine.LNX.3.96.981209151147.10129A-100000@main.cyclades.com>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 11 Dec 1998 11:11:59 +0100
In-Reply-To: Linux Lists's message of "Wed, 9 Dec 1998 15:19:10 -0800 (PST)"
Message-ID: <d3iufjyols.fsf@valhall.cern.ch>
X-Mailer: Quassia Gnus v0.37/Emacs 20.2
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Ivan" == Linux Lists <lists@cyclades.com> writes:

Ivan> Hi, there,

Ivan> I have a question: is there any reference in regards to how /
Ivan> when to use the virt_to_phys, virt_to_bus, ioremap,
Ivan> etc. ... functions, other than
Ivan> /usr/src/linux/Documentation/IO-mapping.txt ?!? I'd like to
Ivan> understand it better, but this text has not been enough (for me,
Ivan> of course).

It's really quite simple:

When you want to map shared memory provided by a device, in most cases
this will PCI shared memory, use ioremap() (or equivalent on other
archs) to map it into kernel shared memory. By doing this the kernel
can directly access this memory, though you really want to use the
read[bwl]()/write[bwl]() macros to access it to ensure portabillity of
your code (ie. Alphas with this wicked sparse memory).

Use virt_to_bus()/bus_to_virt() when you want to convert memory
addresses from/to kernel virtual address and the addresses as seen
from your bus(ses). Ie. on some machines, the physical memory layout
looks different from the CPU as it does from devices on the PCI (or
other) bus(ses). Thus you will normally use these functions to convert
addresses when filling ring descriptors for things like Ethernet
interfaces and other bus master devices (I just use network interfaces
as an example as this is what I hack the most).

virt_to_phys()/phys_to_virt() converts between kernel virtual and
physical addresses, the physical addresses as seen by the main system
that it. These functions are mainly used by the memory management
code. An example is conversion of virtual addresses to physical ones
on architectures that has the cache physically mapped and needs to do
deal with cache coherency in software and the cache management
functions requiring physical addresses (like the m68k).

Conclusion, for most driver related stuff you want to use
virt_to_bus()/bus_to_virt(). However you don't need to deal with any
of this when dealing with non bus mastering devices that only uses
traditional PC ISA I/O (all the inb()/outb() crap).

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
