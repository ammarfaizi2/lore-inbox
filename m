Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVFFOn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFFOn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFFOn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:43:59 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:13952 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261448AbVFFOn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:43:56 -0400
Date: Mon, 6 Jun 2005 18:43:35 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050606184335.A30338@jurassic.park.msu.ru>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Mon, Jun 06, 2005 at 02:27:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 02:27:39AM +0200, Andreas Koch wrote:
> For your reference, at this stage we appear to have a cascade of three
> bridges between a potential device (currently empty CardBus slot) and
> the CPU
> 
>                 1              2      3
> CPU Southbridge -> PCI Express -> PCI -> CardBus
> 
> Note that the messages before this log, e.g., from ohci1394, also indicate
> that the peripherals in the docking station still remain inaccessible due to
> unmapped memory (all reads return 0xff). 

Well, the problem is that bridge 1 in this chain is completely unconfigured
(it seems to be in after-reset state), while bridge 2 (PCIE-to-PCI one)
does have reasonable setup. This leads to "successful" resource allocations
on the bus 3, even though these resources are not accessible due to
incorrect setup of the bridge 1.
On the other hand, pci_assign_unassigned_resources() doesn't touch
already allocated resources, probably leaving them outside of bridge windows.

I think the correct behaviour of pcibios_allocate_bus_resources()
(arch/i386/pci/i386.c) should be as follows:
if some bridge resource cannot be allocated for whatever reason,
don't allow any child resource assignments in that range. Just
clear the resource flags - this prevents building an inconsistent
resource tree.

pci_assign_unassigned_resources() should correctly configure bridge 1
and all subordinate stuff then.

Ivan.

--- linux/arch/i386/pci/i386.c.orig	Sat Mar 19 09:34:53 2005
+++ Linux/arch/i386/pci/i386.c	Mon Jun  6 15:09:18 2005
@@ -106,11 +106,14 @@ static void __init pcibios_allocate_bus_
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->start)
-					continue;
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0)
+				if (!r->start || !pr || request_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
+					/* Something is wrong with the region.
+					   Invalidate the resource to prevent child
+					   resource allocations in this range. */
+					r->flags = 0;
+				}
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
