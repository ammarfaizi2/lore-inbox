Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130730AbRCEWNr>; Mon, 5 Mar 2001 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130732AbRCEWNj>; Mon, 5 Mar 2001 17:13:39 -0500
Received: from palrel3.hp.com ([156.153.255.226]:48398 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S130730AbRCEWNV>;
	Mon, 5 Mar 2001 17:13:21 -0500
Message-Id: <200103052216.OAA02847@milano.cup.hp.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support 
In-Reply-To: Your message of "Sun, 04 Mar 2001 15:19:10 PST."
             <20010304151910.A29393@jurassic.park.msu.ru> 
Date: Mon, 05 Mar 2001 14:16:05 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Fri, Mar 02, 2001 at 11:32:35AM -0800, Grant Grundler wrote:
> > Code in parisc-linux CVS (based on 2.4.0) does boot on my OB800
> > (133Mhz Pentium), C3000, and A500 with PCI-PCI bridge support
> > working. I'm quite certain PCI-PCI bridge configuration (ie BIOS
> > didn't configure the bridge) support was broken.
> 
> I believe it isn't. ;-) It works on various alphas including
> configurations with chained PCI-PCI bridges.

Ok. I overlooked the changes in arch/alpha/kernel/pci.c:pcibios_fixup_bus().
(As you know, things changed alot between -test10 and -test12)


> Some comments on the patch:
> 
> > +** If I/O or MEM ranges are overlapping, that's a BIOS bug.
> 
> No. As we reallocate everything, it is quite possible that we'll
> have temporary overlaps during setup with resources allocated
> by BIOS. I'm not sure if it is harmful though.

The other part of the comment I added was:
+** Disabling *all* devices is bad. Console, root, etc get
+** disabled this way.

I can't debug with *all* devices disabled.

Normally, the whole point of resource mgt is to (a) avoid overlaps
and (b) reflect the state of the HW.  I thought the arch specific code
was responsible for setting the HW state and resource mgt state congruent.
If the arch/alpha code wants everything reallocated anyway, why not have
the arch code disable the HW during the bus walk in pcibios_fixup_bus()
before calling pci_assign_unassigned_resources()?

(I'm looking at 2.4.0 linux/arch/alpha/kernel/pci.c:common_init_pci() )

FYI, under PDC PAT (eg A500), unused devices are left in the "power
on" state (which AFAIK, implies disabled).


> > +#ifdef __hppa__
> > +/* XXX FIXME
> > +** PCI_BRIDGE_CONTROL and PCI_COMMAND programming need to be revisited
> > +** to support FBB.  Make all this crud "configurable" by the arch specific
> > +** (ie "PCI BIOS") support and the ifdef __hppa__ crap can go away then.
> > +*/
> 
> Agreed. Something like pcibios_set_bridge_control().

possibly...I have another problem I wanted to solve - FBB support.

I think generic Fast Back-Back support wants a new field in struct pci_bus
(u32 bridge_ctl) to save and manage the FBB state (and SERR/PERR).
Arch support would need a way to initialize bridge_ctl *before*
pci_do_scan_bus() is called to indicate FBB is or is not supported
by the parent PCI bus controller (either HBA or PCI-PCI Bridge).

Originally I was thinking of seperating the "root" bus allocation
from pci_scan_bus(). But calling pcibios_set_bridge_control()
before the bus walk would work too  if it passes struct pci_bus *
as the parameter. And that could allow arch specific control over
SERR/PERR bits as well.

In pcibios_fixup_bus(), the arch code could check FBB state to see
if it should be enabled on that HBA or not. Ideally, generic code
would fully handle FBB for PCI-PCI secondary busses. Perhaps the FBB
test could be in pci_setup_bridge() but I'm not sure if that would work
for all arches (ie not sure off hand which uses pci_setup_bridge()).


[ deleted code changes in
	drivers/pci/setup-bus.c:pbus_assign_resources()
	driver/pci/setup-res.c:pdev_sort_resources()
]

> This change totally breaks PCI allocation logic.
> Probably you assign PCI-PCI bridge windows in arch specific code - why?

I think my change in pdev_sort_resources() permitted it to occur in
generic code. parisc HBA code only calls request_resources for resources
assigned by firmware to the HBA.


> The only thing you need is to set up the root bus resources
> properly and generic code will do the rest.

hmmm...Code in alpha's pcibios_fixup_bus() modifies PCI-PCI Bridge
resources. It wouldn't if your statement were literally true.


I reversed the two changes in my tree to see what breaks on A500:

| lba version TR4.0 (0x5) found at 0xfffffffffed3c000
| lba_fixup_bus(0x0000000018b4b780) bus 48 sysdata 0x0000000018b4a800
| lba_fixup_bus() LBA I/O Port [30000/3ffff]/100
| lba_fixup_bus() LBA LMMIO [fffffffffb000000/fffffffffb7fffff]/200
| lba_fixup_bus(0x0000000018b4b880) bus 49 sysdata 0x0000000018b4a800
| lba_fixup_bus(0x0000000018b4b980) bus 50 sysdata 0x0000000018b4a800
| PCI: Failed to allocate resource 0 for 31:04.0
| PCI: Failed to allocate resource 0 for 31:04.1

[ I have a 4-port 100BT card and a 2-port 100BT/896 SCSI "combo" card
  installed in bus 48 - both have PCI-PCI bridges.
  No resources are available for any devices under either PPB.
]


...
| tulip: eth1: I/O region (0xfffffffffffd0000@0x31000) unavailable, aborting
...
| sym53c896-6: rev 0x5 on pci bus 49 device 4 function 0 irq 320
| sym53c896-6: ID 7, Fast-40, Parity Checking
| sym53c896-6: on-chip RAM at 0xfffffffffb100000
| CACHE TEST FAILED: reg dstat-sstat2 readback ffffffff.
| CACHE INCORRECTLY CONFIGURED.
...

Should I try to follow alpha's pcibios_fixup_bus() and add the code following
(linux 2.4.0, arch/alpha/kernel/pci.c line 256)

		/* This is a bridge. Do not care how it's initialized,
		   just link its resources to the bus ones */

to the parisc pcibios_fixup_bus() ?

Or do you want to change how alpha works to follow what you said?
I would prefer this but it doesn't matter ATM; just needs to work.

thanks!
grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
