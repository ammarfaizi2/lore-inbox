Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRF1BAP>; Wed, 27 Jun 2001 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRF1A74>; Wed, 27 Jun 2001 20:59:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27284 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265464AbRF1A7x>;
	Wed, 27 Jun 2001 20:59:53 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.33158.683289.641171@pizda.ninka.net>
Date: Wed, 27 Jun 2001 17:59:50 -0700 (PDT)
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI 
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Gall writes:
 >   Part one is the following changes to include/linux/pci.h

You've mixed in here changes which already exist in
include/linux/pci.h, namely the PCIIOC_* ioctl values.
Please get your patches straight.

 >   The first part changes number, primary, and secondary to unsigned ints from
 > chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
 > pci controller in with the bus number. In our case we do it like this: 
 > 
 > pci_controller=dev->bus->number>>8) &0xFF0000 
 > bus_number= dev->bus->number&0x0000FF),
 > 
 >   Is this reasonable for everyone?

This is totally unreasonable.

Bus numbers are dictacted by the PCI standard, they cannot exist
larger than 8-bits, so they are char.  This is the end of the story.

What you want are PCI domains.

 >   The following 3 functions are added. Their purpose is a little different than
 > to add support for more than 256 buses but they are important. Skip ahead and
 > I'll explain what they are for....
 > 
 > int (*pci_read_bases)(struct pci_dev *, int cnt,int rom);  /* These optional
 > hooks provide */
 > int (*pci_read_irq)(struct pci_dev *);                     /* the arch dependant
 > code a way*/
 > int (*pci_fixup_registers)(struct pci_dev *);              /* to manage the
 > registers.     */

This seems totally unnecessary to me.  Also your mailreader has
fux0red the patch with linebreaks making most of this unreadable.

 >   The 3 additional functions are hooks so that an architecture has a chance to
 > make sure things are in order beforehand. pci_read_bases is for the management
 > and fixup of the BARs. pci_read_irq is the same but for IRQs.
 > pci_fixup_registers again same idea but for bridge resources.

We have an entire infrastructure for this already.  And if it isn't
sufficient either fix it or control the whole PCI bus probe from arch
specific layers, see arch/sparc64/kernel/pci_common.c for an example.

 > So as Joel from MST3K used to say, "What do you think sirs?"

It's crap.

If the problem is to be fixed, it should be fixed correctly.

First lets look at your bus number expansion.  How do your patches
handle the user interface aspects of this?  The bus number nodes
of /proc/bus/pci/${BUS} are 2 digit hex values.  They are still
2-digit hex values after your patch, so bus numbers >255 simply won't
work with your changes.

This is only the beginning of the list of problems your changes do not
address.

Fact is, we need PCI, actually "system", domains.  Any other attempt
is an outright kludge.  And such outright kludges can be totally
hidden in arch specific code _today_.

It is startling to me that the ppc64 folks looked at this problem and
saw fit to make it some new issue.  It's old as day, and it is solved
for all reasonable cases already by sparc64, alpha, etc.  As long as
you have < 256 _PHYSICAL_ busses allocated on the machine, you can
hide the controller issue by using unique PCI bus numbers throughout
the system.

Sure, this does not handle >=256 busses, but when you hit that point
you must fix it correctly.  And this requires a system bus
abstraction, not some hokey extending of the PCI bus number space.

All of your changes do not provide any new functionality.  Several
other architectures deal with whatever issues your new hooks solve.
They do this all by themselves and without changes to generic code.
Why can't ppc64 do the same?

Later,
David S. Miller
davem@redhat.com

