Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVFJOsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVFJOsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVFJOsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:48:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:9619 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262569AbVFJOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:48:36 -0400
Date: Fri, 10 Jun 2005 18:48:15 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050610184815.A13999@jurassic.park.msu.ru>
References: <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston> <20050609175441.C9187@jurassic.park.msu.ru> <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de> <20050609223835.GB26023@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Jun 09, 2005 at 04:20:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:20:59PM -0700, Linus Torvalds wrote:
> I wonder whether the bridge is effectively a negative decode thing, and 
> the only "real" problem is that because the kernel doesn't know that, it 
> doesn't know that it can allocate just about any resource at all on the 
> other end..

No, I'm 99% sure it's not. Otherwise the damned thing would work without
any patches, since all devices in the dock have reasonable addresses.
It's just one bridge in the middle that hasn't.

> It would be pretty strange, since the PCI spec (afaik, and for pretty
> obvious reasons) disallows two negative bridges on the same bus (and you
> already have the other mobile bridge there), but it's technically possible
> if they just have different priorities for how fast they react to a PCI
> address cycle and claim it.

True, especially since it's possible to have a lot of devices including
bridges on a single chip, so that limitations mentioned in the PCI spec
do not work anymore. But I hope hardware engineers are sensible enough
not to break rules...

> Ivan, can you cook up some silly patch that just marks that one device 
> transparent, and see if that "just fixes it".

Appended, but hopefully not quite silly. :-)
Though, the reason why the devices in the dock are still inaccessible
is indeed ridiculous - pci_enable_bridges() doesn't work on i386.
It ends up calling pcibios_enable_resources(), which only test first 6
resources and therefore ignores bridge resources completely.
So, even if the bridge ranges have been assigned correctly (according to
Andreas' dmesg), we left the bridge with IO and MEM enable bits
turned off...

The patch applies to clean 2.6.12-rc6. It includes 2 patches from
gregkh-2.6 tree (to pci.h and probe.c). Initially these patches were
intended for ACPI and "cardbus behind subtractive bridge" improvements,
but as it turns out they make setup-bus.c code a lot more happier with
transparent bridges, so many of previous hacks aren't needed.

I'm still not sure if it boots though...

Ivan.

diff -urpN linux-2.6.12-rc6/arch/i386/pci/common.c linux/arch/i386/pci/common.c
--- linux-2.6.12-rc6/arch/i386/pci/common.c	Mon Jun  6 19:22:29 2005
+++ linux/arch/i386/pci/common.c	Fri Jun 10 15:21:20 2005
@@ -164,6 +164,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
diff -urpN linux-2.6.12-rc6/arch/i386/pci/i386.c linux/arch/i386/pci/i386.c
--- linux-2.6.12-rc6/arch/i386/pci/i386.c	Mon Jun  6 19:22:29 2005
+++ linux/arch/i386/pci/i386.c	Fri Jun 10 15:52:05 2005
@@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->start)
+				if (!r->flags)
 					continue;
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
@@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
+	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
diff -urpN linux-2.6.12-rc6/drivers/pci/probe.c linux/drivers/pci/probe.c
--- linux-2.6.12-rc6/drivers/pci/probe.c	Mon Jun  6 19:22:29 2005
+++ linux/drivers/pci/probe.c	Fri Jun 10 15:24:03 2005
@@ -239,9 +239,8 @@ void __devinit pci_read_bridge_bases(str
 
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
+		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i - 3];
 	}
 
 	for(i=0; i<3; i++)
diff -urpN linux-2.6.12-rc6/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- linux-2.6.12-rc6/drivers/pci/setup-bus.c	Mon Jun  6 19:22:29 2005
+++ linux/drivers/pci/setup-bus.c	Fri Jun 10 15:16:50 2005
@@ -270,6 +270,8 @@ find_free_bus_resource(struct pci_bus *b
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}
diff -urpN linux-2.6.12-rc6/include/linux/pci.h linux/include/linux/pci.h
--- linux-2.6.12-rc6/include/linux/pci.h	Mon Jun  6 19:22:29 2005
+++ linux/include/linux/pci.h	Fri Jun 10 15:24:29 2005
@@ -586,7 +586,7 @@ struct pci_dev {
 #define PCI_NUM_RESOURCES 11
 
 #ifndef PCI_BUS_NUM_RESOURCES
-#define PCI_BUS_NUM_RESOURCES 4
+#define PCI_BUS_NUM_RESOURCES 8
 #endif
   
 #define PCI_REGION_FLAG_MASK 0x0fU	/* These bits of resource flags tell us the PCI region flags */
