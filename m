Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131035AbRCFRYd>; Tue, 6 Mar 2001 12:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131036AbRCFRYX>; Tue, 6 Mar 2001 12:24:23 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:39941 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131035AbRCFRYN>; Tue, 6 Mar 2001 12:24:13 -0500
Date: Tue, 6 Mar 2001 20:20:25 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support
Message-ID: <20010306202025.A2805@jurassic.park.msu.ru>
In-Reply-To: <20010304151910.A29393@jurassic.park.msu.ru> <200103052216.OAA02847@milano.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103052216.OAA02847@milano.cup.hp.com>; from grundler@cup.hp.com on Mon, Mar 05, 2001 at 02:16:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 02:16:05PM -0800, Grant Grundler wrote:
> > I believe it isn't. ;-) It works on various alphas including
> > configurations with chained PCI-PCI bridges.
> 
> Ok. I overlooked the changes in arch/alpha/kernel/pci.c:pcibios_fixup_bus().
> (As you know, things changed alot between -test10 and -test12)

Yes, all that stuff appeared in -test12, IIRC.
Now ARM port uses it too, BTW.

> > > +** If I/O or MEM ranges are overlapping, that's a BIOS bug.
> > 
> > No. As we reallocate everything, it is quite possible that we'll
> > have temporary overlaps during setup with resources allocated
> > by BIOS. I'm not sure if it is harmful though.
> 
> The other part of the comment I added was:
> +** Disabling *all* devices is bad. Console, root, etc get
> +** disabled this way.
> 
> I can't debug with *all* devices disabled.

What is why I leave VGAs and all sorts of bridges enabled.
If you have some other type of console sitting on the PCI
bus you need this enabled as well, of course.

> Normally, the whole point of resource mgt is to (a) avoid overlaps
> and (b) reflect the state of the HW.  I thought the arch specific code
> was responsible for setting the HW state and resource mgt state congruent.
> If the arch/alpha code wants everything reallocated anyway, why not have
> the arch code disable the HW during the bus walk in pcibios_fixup_bus()
> before calling pci_assign_unassigned_resources()?

It's possible.

> > > +** PCI_BRIDGE_CONTROL and PCI_COMMAND programming need to be revisited
> > > +** to support FBB.  Make all this crud "configurable" by the arch specific
> > > +** (ie "PCI BIOS") support and the ifdef __hppa__ crap can go away then.
> > > +*/
> > 
> > Agreed. Something like pcibios_set_bridge_control().
> 
> possibly...I have another problem I wanted to solve - FBB support.
> 
> I think generic Fast Back-Back support wants a new field in struct pci_bus
> (u32 bridge_ctl) to save and manage the FBB state (and SERR/PERR).
> Arch support would need a way to initialize bridge_ctl *before*
> pci_do_scan_bus() is called to indicate FBB is or is not supported
> by the parent PCI bus controller (either HBA or PCI-PCI Bridge).

Or let pci_do_scan_bus() check the FBB capability of all
devices on the given bus and then arch code will decide whether
enable FBB or not on the bus controller.
Anyway, new member in struct pci_bus makes a sense.

> I think my change in pdev_sort_resources() permitted it to occur in
> generic code. parisc HBA code only calls request_resources for resources
> assigned by firmware to the HBA.

I'm afraid I don't understand how that could affect hppa. PCI-to-PCI
bridge specification allows PCI-PCI bridge to have some device-specific
IO, MEM or ROM resources. If any of these are present, we must allocate
them properly.
 
> > The only thing you need is to set up the root bus resources
> > properly and generic code will do the rest.
> 
> hmmm...Code in alpha's pcibios_fixup_bus() modifies PCI-PCI Bridge
> resources. It wouldn't if your statement were literally true.

Oh, well. That code actually initializes limits of the bridge
windows with the values of the root bus to make a room for
resource allocation. I can't recall now why it was placed in the
arch code. Maybe one of the reasons was that I wasn't sure whether
someone want to use prefetchable memory...

> Should I try to follow alpha's pcibios_fixup_bus() and add the code following
> (linux 2.4.0, arch/alpha/kernel/pci.c line 256)
> 
> 		/* This is a bridge. Do not care how it's initialized,
> 		   just link its resources to the bus ones */
> 
> to the parisc pcibios_fixup_bus() ?
> 
> Or do you want to change how alpha works to follow what you said?

You mean something like this (moving code from arch/alpha to generic)?

--- 2.4.2/drivers/pci/setup-bus.c	Tue Dec 12 00:46:26 2000
+++ linux/drivers/pci/setup-bus.c	Tue Mar  6 19:46:30 2001
@@ -192,9 +192,23 @@ pbus_assign_resources(struct pci_bus *bu
 	}
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
+		struct pci_dev *bridge = b->self;
+		int i;
 
+		for(i=0; i<3; i++) {
+			b->resource[i] =
+				&bridge->resource[PCI_BRIDGE_RESOURCES+i];
+			b->resource[i]->name = bus->name;
+		}
+		b->resource[0]->flags |= pci_bridge_check_io(dev);
+		b->resource[1]->flags |= IORESOURCE_MEM;
 		b->resource[0]->start = ranges->io_start = ranges->io_end;
 		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
+		b->resource[0]->end = bus->resource[0]->end;
+		b->resource[1]->end = bus->resource[1]->end;
+		/* Turn off downstream PF memory address range */
+		bus->resource[2]->start = 1024*1024;
+		bus->resource[2]->end = 0;
 
 		pbus_assign_resources(b, ranges);
 
> I would prefer this but it doesn't matter ATM; just needs to work.

Certainly all this should be cleaned up in 2.5; I'm not sure for 2.4.

Ivan.
