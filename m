Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbTB1SHX>; Fri, 28 Feb 2003 13:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268051AbTB1SHX>; Fri, 28 Feb 2003 13:07:23 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:22779 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S268047AbTB1SHV>; Fri, 28 Feb 2003 13:07:21 -0500
Date: Fri, 28 Feb 2003 11:17:29 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>, linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228181729.GA8366@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228155841.GA4678@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228155841.GA4678@gtf.org>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28 2003, at 10:58, Jeff Garzik was caught saying:
> On Fri, Feb 28, 2003 at 09:44:14PM +0600, Dmitry A. Fedorov wrote:
> > 
> > But why drivers of ISA bus devices with DMA should use pci_* functions?
> > 
> > I'm personally wouldn't have too much pain with GFP_DMA because I have
> > compatibility headers and proposed change for them is tiny.
> 
> Do not let the name "pci_" distract, it works for ISA too :)
> 
> We can #define pci_xxx isa_xxx if you like :)
> 
> 	Jeff

This discussion raises an issue that I've been meaning to bring up for a bit.
Currently, the DMA-API is defined as returning a cpu physical address [1],
but should the API be redefined as returning an address which is valid on 
the bus which the device sits on? For example, on most xscale systems I 
deal with, there's not a 1:1 mapping from physical to PCI memory space,
so the address which is valid on the bus is not a valid CPU physical
address.  Imagine an SOC system with on-chip Ethernets and such that
that have direct access to the physical bus, plus non-1:1 PCI translation. 
In such a case, I would need a physical address for the on-chip devices and 
a PCI bus address for the PCI devices.  We can extend this case to a SOC 
which has on-chip peripherals on some custom FooBus with non-1:1 translation 
into physical memory. Now, depending on whether my device is on
the PCI bus or on said FooBus, my dma_addr needs to have a different
meaning.

One easy answer is to provide bus-specific bus_map/unmap/etc functions
such as is done with PCI, but this seems rather ugly to me as now every
custom bus needs a new set of functions which IMNHO defeats the purpose
of a Generic DMA API.  I think it would be a much cleaner solution to 
define the DMA API itself to return an address that is valid on the
the bus pointed to by dev->bus. I don't think this would require any 
implementation changes at the moment, but it would be a more flexible 
definition of the API allowing for easy addition of new bus types with DMA
capabilities. All the bus-specific magic would be hidden in the
architecture-specific implementations on platforms that require different
mappings for different buses, making the life of driver writers much
simpler. On systems in which everything is 1:1 mapped between physical,
PCI, and FooBuses, no changes would be required.

~Deepak


[1] From Documentation/DMA-API.txt in the 2.5 BK tree:

    dma_addr_t
    dma_map_single(struct device *dev, void *cpu_addr, size_t size,
                      enum dma_data_direction direction)
    dma_addr_t
    pci_map_single(struct device *dev, void *cpu_addr, size_t size,
                      int direction)

    Maps a piece of processor virtual memory so it can be accessed by the
    device and returns the _physical_ handle of the memory.


-- 
Deepak Saxena, Code Monkey - Ph:480.517.0372 Fax:480.517.0262 
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

