Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVGGNMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVGGNMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVGGNMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:12:45 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25521 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261453AbVGGNMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:12:01 -0400
Date: Thu, 7 Jul 2005 15:11:29 +0200 (MEST)
Message-Id: <200507071311.j67DBT71014045@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: gregkh@suse.de, ink@jurassic.park.msu.ru, teanropo@cc.jyu.fi
Subject: Re: 2.6.13-rc2 hangs at boot
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 16:47:28 +0300 (EEST), Tero Roponen wrote:
>my computer (a ThinkPad 380XD laptop) hangs at boot in 2.6.13-rc2.
>When I revert the patch below everything seems to be fine.

Same here: my Targa Visionary 811 Athlon64 laptop
hangs during boot with 2.6.13-rc2, unless I revert
the patch below. -rc1 worked OK.

/Mikael

>thanks,
>Tero Roponen
>
>
>Patch to revert:
>
>Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>Date: Wed, 15 Jun 2005 14:59:27 +0000 (+0400)
>Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=299de0343c7d18448a69c635378342e9214b14af
>
>  [PATCH] PCI: pci_assign_unassigned_resources() on x86
>
>  - Add sanity check for io[port,mem]_resource in setup-bus.c. These
>    resources look like "free" as they have no parents, but obviously
>    we must not touch them.
>  - In i386.c:pci_allocate_bus_resources(), if a bridge resource cannot be
>    allocated for some reason, then clear its flags. This prevents any child
>    allocations in this range, so the setup-bus code will work with a clean
>    resource sub-tree.
>  - i386.c:pcibios_enable_resources() doesn't enable bridges, as it checks
>    only resources 0-5, which looks like a clear bug to me. I suspect it
>    might break hotplug as well in some cases.
>
>  From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>  Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
>--- a/arch/i386/pci/common.c
>+++ b/arch/i386/pci/common.c
>@@ -165,6 +165,7 @@ static int __init pcibios_init(void)
> 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
> 		pcibios_sort();
> #endif
>+	pci_assign_unassigned_resources();
> 	return 0;
> }
>
>--- a/arch/i386/pci/i386.c
>+++ b/arch/i386/pci/i386.c
>@@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
> 		if ((dev = bus->self)) {
> 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
> 				r = &dev->resource[idx];
>-				if (!r->start)
>+				if (!r->flags)
> 					continue;
> 				pr = pci_find_parent_resource(dev, r);
>-				if (!pr || request_resource(pr, r) < 0)
>+				if (!r->start || !pr || request_resource(pr, r) < 0) {
> 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
>+					/* Something is wrong with the region.
>+					   Invalidate the resource to prevent child
>+					   resource allocations in this range. */
>+					r->flags = 0;
>+				}
> 			}
> 		}
> 		pcibios_allocate_bus_resources(&bus->children);
>@@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
>
> 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> 	old_cmd = cmd;
>-	for(idx=0; idx<6; idx++) {
>+	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
> 		/* Only set up the requested stuff */
> 		if (!(mask & (1<<idx)))
> 			continue;
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -273,6 +273,8 @@ find_free_bus_resource(struct pci_bus *b
>
> 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
> 		r = bus->resource[i];
>+		if (r == &ioport_resource || r == &iomem_resource)
>+			continue;
> 		if (r && (r->flags & type_mask) == type && !r->parent)
> 			return r;
> 	}
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
