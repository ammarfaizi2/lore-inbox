Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFDPYM>; Tue, 4 Jun 2002 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSFDPYL>; Tue, 4 Jun 2002 11:24:11 -0400
Received: from air-2.osdl.org ([65.201.151.6]:18566 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S313181AbSFDPYI>;
	Tue, 4 Jun 2002 11:24:08 -0400
Date: Tue, 4 Jun 2002 08:19:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: <axp-kernel-list@redhat.com>,
        "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
        <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
In-Reply-To: <000101c20bd5$b8f24560$010b10ac@sbp.uptime.at>
Message-ID: <Pine.LNX.4.33.0206040749530.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I apologize for answering this so late, and being so tardy in releasing 
docs explaining all this. I'll be sending docs to the list soon... ]

On Tue, 4 Jun 2002, Oliver Pitzeier wrote:

> Can anybody tell me what's wrong within this line:
> 
> linux-2.5.20/include/linux/device.h:
> [ ... ]
>      73 static inline struct bus_type * get_bus(struct bus_type * bus)
>      74 {
> -->> 75         BUG_ON(!atomic_read(&bus->refcount));
>      76         atomic_inc(&bus->refcount);
>      77         return bus;
>      78 }
> [ ... ]
> 
> I guess BUG_ON always produces an error? But why is my kernel
> jumping there and why is BUG_ON there?

The short of it: 2.5.19 introduced a struct bus_type that describes each
bus type in the system. It holds lists of all the devices and drivers that
are found for that bus type.

When a bus is probed and devices are discovered, they are inserted into
the bus's list of devices (as well as their place in the global
hierarchy).

The problem: bus_types are registered with the system, which intializes 
all the internal fields, making them ready for use. The PCI bus is being 
probed before the PCI bus type has been registered. 

device_register() calls bus_add_device(), which does get_bus(). With a
refcount == 0, you hit the BUG().

The PCI bus type is registered in 
drivers/pci/pci-driver.c::pci_driver_init(), which is a subsys_initcall. 

pci_scan_bus() is called from arch/alpha/kernel/pci.c::common_init_pci().  
It appears that this is called from pcibios_init(), which is also a
subsys_initcall. The arch/ objects are probably linked before the driver/
objects on alpha, so the bus ends up being scanned before the bus type is
registered.

Can pcibios_init() be demoted to a device_initcall? This would delay 
probing until all the subsystems could be setup...

	-pat

