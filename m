Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRCFUyH>; Tue, 6 Mar 2001 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129438AbRCFUx7>; Tue, 6 Mar 2001 15:53:59 -0500
Received: from palrel1.hp.com ([156.153.255.242]:32778 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129419AbRCFUxr>;
	Tue, 6 Mar 2001 15:53:47 -0500
Message-Id: <200103062057.MAA03915@milano.cup.hp.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support 
In-Reply-To: Your message of "Tue, 06 Mar 2001 20:20:25 PST."
             <20010306202025.A2805@jurassic.park.msu.ru> 
Date: Tue, 06 Mar 2001 12:57:00 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> Yes, all that stuff appeared in -test12, IIRC.
> Now ARM port uses it too, BTW.

ok. I'll keep that in mind.


> > I can't debug with *all* devices disabled.
> 
> What is why I leave VGAs and all sorts of bridges enabled.
> If you have some other type of console sitting on the PCI
> bus you need this enabled as well, of course.

My A500 console is a "regular" PCI serial device.

[ I use quotes because linux sees the device as a 16550.
But I'm told it's fully emulated in firmware on a special card called
the "GSP" (Guardian Service Processor). ]
 

> > If the arch/alpha code wants everything reallocated anyway, why not have
> > the arch code disable the HW during the bus walk in pcibios_fixup_bus()
> > before calling pci_assign_unassigned_resources()?
> 
> It's possible.

Ok. I can't implement/test this since I don't have an Alpha box.
I'm not going to submit patches to l-k for code I can't test.
If someone has an old alpha box I can use to test PCI developement
(if a jensen is suitable, fine), I could easily trade for a 712 or 715
workstation (128MB mem, 2GB SCSI).


[ re FBB proposal ]

> Or let pci_do_scan_bus() check the FBB capability of all
> devices on the given bus and then arch code will decide whether
> enable FBB or not on the bus controller.

Yes - that's the part I ommitted to keep my proposal shorter. :^)
So it's not "Or" - I intended "And let..."

Initializing the FBB bit in bridge_ctl before pci_do_scan_bus() gets
called would allow pci_do_scan_bus() to clear FBB bit if any device
on that bus does not support FBB. Arch support can then program
the HBA's FBB capability to match in pcibios_fixup_bus().

The advantage here is: 
o arch's not looking at or setting FBB would continue to work as before.
o pci_do_scan_bus() can treat secondary busses (ie below PCI-PCI Bridge)
  the same since it doesn't need to worry about who uses the FBB state.
  (pci_setup_bridge() could deal with it for PCI-PCI bridges.)

> Anyway, new member in struct pci_bus makes a sense.

Ok. I was hoping to work on an FBB patch this week but I first
need to get parisc-linux support with linus' generic PCI tree.
I'd like to have parisc linux in sync with some version of
AC's or Linus' tree before starting that.


[ re patch to pdev_sort_resources() ]

> I'm afraid I don't understand how that could affect hppa. PCI-to-PCI
> bridge specification allows PCI-PCI bridge to have some device-specific
> IO, MEM or ROM resources. If any of these are present, we must allocate
> them properly.

Agreed. Removing the following "if/continue" statement doesn't
affect device-specific (aka "built-in") IO/MEM/ROM resources.


|	if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI &&
|				i >= PCI_BRIDGE_RESOURCES)
|		continue;

This code causes the outer loop to not link the &dev->resource[i] into
the "sorted list" for the *secondary* bus.
(ie PCI_BRIDGE_RESOURCES <= i < PCI_NUM_RESOURCES)

By including the secondary bus "window" resources in the sorted list,
the resources for the PCI-PCI Bridge window registers are allocated
too. Thus the change in pbus_assign_resources() to avoid clobbering
the contents already placed in the sorted list.

I worked this out before but right now am not 100% certain some
details haven't escaped me. But I still think I'm on the right track.
I know it works on an A500. I've reviewed the resulting resource tree
and am certain it was correct for the configuration I tested.


[ re arch/alpha code ]

> Oh, well. That code actually initializes limits of the bridge
> windows with the values of the root bus to make a room for
> resource allocation. I can't recall now why it was placed in the
> arch code. Maybe one of the reasons was that I wasn't sure whether
> someone want to use prefetchable memory...

Ok. If it can be removed, I'd be happier since it means I wouldn't
need similar code in arch/parisc.


> You mean something like this (moving code from arch/alpha to generic)?
> 
> --- 2.4.2/drivers/pci/setup-bus.c	Tue Dec 12 00:46:26 2000
> +++ linux/drivers/pci/setup-bus.c	Tue Mar  6 19:46:30 2001
> @@ -192,9 +192,23 @@ pbus_assign_resources(struct pci_bus *bu
>  	}
>  	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
>  		struct pci_bus *b = pci_bus_b(ln);
> +		struct pci_dev *bridge = b->self;
> +		int i;
>  
> +		for(i=0; i<3; i++) {
> +			b->resource[i] =
> +				&bridge->resource[PCI_BRIDGE_RESOURCES+i];
> +			b->resource[i]->name = bus->name;
> +		}
> +		b->resource[0]->flags |= pci_bridge_check_io(dev);
> +		b->resource[1]->flags |= IORESOURCE_MEM;
>  		b->resource[0]->start = ranges->io_start = ranges->io_end;
>  		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
> +		b->resource[0]->end = bus->resource[0]->end;
> +		b->resource[1]->end = bus->resource[1]->end;
> +		/* Turn off downstream PF memory address range */
> +		bus->resource[2]->start = 1024*1024;
> +		bus->resource[2]->end = 0;
>  
>  		pbus_assign_resources(b, ranges);
>  

Yes, sort of. If my patch to pdev_sort_resources() makes sense now,
I'm not sure this is needed either.

My first reaction was initialization of b->resource pointer would have
to happen earlier in order to match arch code in pcibios_fixup_bus().
The idea being generic PCI code *in general* do the same things for
primary bus resources as secondary bus resources (ie window registers).


> > I would prefer this but it doesn't matter ATM; just needs to work.
> 
> Certainly all this should be cleaned up in 2.5; I'm not sure for 2.4.

I don't think existing PCI code is very "dirty". Understanding
the interactions between generic and arch PCI code is non-trivial.
But it's not that bad. Understanding how various arches use the
code is the hard part.

parisc support is mostly in place in 2.4.0. It would be quite
frustrating to not have it fully working in a 2.4.x release because
of 10 or 20 lines of code change. FBB support will cause more change
than what I've proposed for in the patch parisc support.

thanks again,
grant

ps. Ivan - this has been a good exchange since it's forcing me to revisit
    code I haven't looked at in a few monthes with a fresh perspective.
    This (and my previous) reply took me about 4 hours to write.
    I have to keep looking at code. :^)

> 
> Ivan.

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
