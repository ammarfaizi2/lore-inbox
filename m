Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289415AbSA1U1G>; Mon, 28 Jan 2002 15:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289388AbSA1UZZ>; Mon, 28 Jan 2002 15:25:25 -0500
Received: from mail.sonytel.be ([193.74.243.200]:39102 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S289386AbSA1UY5>;
	Mon, 28 Jan 2002 15:24:57 -0500
Date: Mon, 28 Jan 2002 21:24:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adam Kowalczyk <akowalczyk@cogeco.ca>
cc: Linux/PPC on APUS development 
	<linux-apus-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prometheus PCI Driver
In-Reply-To: <038401c1a784$4eb019d0$9865fea9@WORK>
Message-ID: <Pine.GSO.4.21.0201282058510.2836-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Note for the non-APUS readers: The Prometheus is a Zorro-PCI bridge for
  Amiga ]

On Sun, 27 Jan 2002, Adam Kowalczyk wrote:
> So far so good on the 2.4.17 version of the Prometheus PCI driver.  I'm down
> to one message during the PCI initialization that I'm not too sure of what
> it means.  I'm not sure what the following is telling me:
> 
> > PCI: Cannot allocate resource region 1 of PCI bridge 0

So the PCI bus init code couldn't add the bus resource to the resource tree
(i.e. that region was already occupied).

> If I take a look at /proc/iomem, there are clearly entries for the resource
> that I've set up for the PCI memory and entries for the Voodoo 3 card show
> up as well.  Similarly, /proc/ioports shows the I/O port listing for the
> Voodoo 3 I/O port.  Here is the dmesg file for reference.  Any ideas what
> the message means?

Can you post the contents of /proc/iomem and /proc/ioports as well?
And lspci -vv?

I guess the Prometheus bus resources show up in /proc/ioports but not in
/proc/iomem?

> > Zorro: Probing AutoConfig expansion devices: 4 devices
> > Start: 0x40000000 End: 0x5fffffff
> > Prometheus PCI bridge detected.
> > About to do a zorro_request_device()
> > I made it here!
> > prom_setup_pci_ptrs: PCI mem resource requested
> > About to perform ioremap().
> > ioremap: 400f0000 (00010000) -> c8000000
> > Check out this Data 0xc8000000
> > About to leave prom_pci_setup_ptrs()
> > PCI: Probing PCI hardware
> > About to INIT_LIST_HEAD
> > Inside prom_pcibios_fixup_bus()
> > PCI: Cannot allocate resource region 1 of PCI bridge 0
> > PCI: resource is 40100000..5fffffff (200), parent c01e9c38

That's the PCI memory space of the Prometheus?
(http://prometheus.amiga.pl/developer.html is refusing connections right now,
so I can't verify).

The error message is printed in pcibios_allocate_bus_resources()
(arch/ppc/kernel/pci.c). That routine tries to find the parent resources for
the resources of your PCI host bridge.

Did you fill in bus->parent? 

  - If no (I guess so), the code will use &iomem_resource as the parent
    resource. Then request_resource() will fail because the Zorro part of the
    Prometheus already has requested that region (you should see the Zorro part
    in /proc/iomem).

  - If yes (very unlikely), pci_find_parent_resource() did not find a correct
    resource to use as a parent for the region 40100000..5fffffff.

So you should tell the bus setup code that your bus parent is the Prometheus
Zorro device. Unfortunately that's not as simple as it sounds, since
bus->parent is of type struct pci_bus *, which is not compatible with the Zorro
bus ;-(

The problem is that the PCI code assumes that PCI busses always hang off of
nothing (i.e. the CPU) or other PCI busses, while in the Prometheus' case we
don't have a PCI host bridge (bus->parent is NULL) or a PCI-PCI bridge
(bus->parent is non-NULL), but a Zorro-PCI bridge. (Once we'll have had the
generic device driver framework rewrite, I guess that'll be fixed)

I think the best solution is to copy the pcibios_allocate_bus_resources() code
to your Prometheus driver and modify it to always use &ioport_resource as the
parent resource for PCI I/O resources, and zorro_dev.resource of the Prometheus
Zorro device for PCI memory resources.

It might still break other code that assumes bus->parent contains something
valid, though. But since it works for normal PCI host bridges where bus->parent
is NULL as well, I think everything will be fine.

Question: Are there any other machines where the PCI subsystem doesn't hang off
of the CPU, but of some other sufficiently intelligent bus (so VESA Local Bus
doesn't count)?

> > PCI:00:01.0: Resource 0: 42000000-43ffffff (f=200)
> > PCI:00:01.0: Resource 1: 44000000-45ffffff (f=1208)
> > PCI:00:01.0: Resource 2: 40000000-400000ff (f=101)
> > PCI: Switching off ROM of 00:01.0

So your PCI devices are found and hooked up in the resource tree.

> > ioremap: 42000000 (01000000) -> c801e000
> > ioremap: 44000000 (01000000) -> c901f000
> > ioremap: 40000000 (00001000) -> ca020000
> > fb: Voodoo3 memory = 16384K
> > Console: switching to colour frame buffer device 100x37
> > fb0: 3Dfx Voodoo3 frame buffer device

And the Voodoo3 is working! Very nice!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

