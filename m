Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRCAPea>; Thu, 1 Mar 2001 10:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRCAPeU>; Thu, 1 Mar 2001 10:34:20 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:24008 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129660AbRCAPeL>; Thu, 1 Mar 2001 10:34:11 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: The IO problem on multiple PCI busses
Date: Thu, 1 Mar 2001 16:33:37 +0100
Message-Id: <19350124090521.18330@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the return of an oooold problem for which we really need a
solution asap since it's now biting us in real life configurations...

So the problem happens when you have a machine with more than one PCI
host bridge. This is typically the case of all new Apple machines as they
have 3 host bridges in one chip (2 of them are relevant: the AGP and the
PCI). I don't think the problem exist on x86 machines with real IO
cycles, at least in that case, the problem is different.

In order to generate IO cycles, the bridge provides us with a region in
CPU physical memory space (a 16Mb region in our case) that translates
accesses to IO cycles on the PCI bus. Our implementation of inb/outb
currently relies on the kernel ioremap'ing one of these regions (the PCI
one) and using the ioremap result as a base (offset) inside the inb/outb
functions.

So that mean that the current design won't allow access to IOs located on
any bus but the one we arbitrarily choose (the PCI bus). That's fine in
most case, until you decide to put a 3dfx or nvidia card in the AGP slot.
Those cards require some IO accesses to be done to the legacy VGA
addresses, and of course, our inb/outb functions can't do that.

Obviously, we can hack some driver specific thing that would use the
arch-specific code to retreive the proper io base address for a given
host bridge, but that's a hack. I'm looking for a solution that would
cleanly apply to all archs that may potentially face this problem.

The problem potentially exist also for any PCI card that has PCI IOs on
anything but the main PCI bus. 

One possibility is to limit our IO space to 64k per bus (to avoid
bloating) and then use a hacked ioremap to create a single virtually
contiguous kernel region that appends all those IO spaces together.
Accessing IOs on bus N would just be the matter of calculating an address
of the type 64k*N+offset and doing normal inb/outb on the result. The
arch PCI code could then properly fixup PCI IO resources for PCI drivers,
and we could add a function of the kind

 unsigned long pci_bus_io_offset(int busno);

that would return the offset to add to inb/outb when accessing IOs on the
N'th PCI bus.

If we want to go a bit further, and allow ISA drivers that don't have a
pci_dev structure to work on legacy devices on any bus, we could provide
a set of function of the type

 int isa_get_bus_count();
 unsigned long isa_get_bus_io_offset(int busno);

and eventually

 int isa_bus_to_pci_bus(int isa_busno);
 int pci_bus_to_isa_bus(int pci_busno);

If we want to figure out on which PCI bus a given ISA bus is located if
any (-1 beeing no mapping 
exist).

Of course, the same problem exist for ISA memory (used by legacy VGA
modes). It's not a problem in real life currently since no powermac can
produce PCI cycles in the ISA memory range today, and non-powermac PPC
machines currently don't have needs for video cards on anything but the
main bus, but the potential issue is there, and the need for a solution
may pop up too.

I'm, of course open to any comments about this (in fact, I'd really like
some feedback). One thing is that we also need to find a way to pass
those infos to userland. Currently, we implement an arch-specific syscall
that allow to retreive the IO physical base of a given PCI bus. That may
be enough, but we may also want something that match more closely what we
do in the kernel.

Regards,
Ben.

