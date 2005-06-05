Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVFEQrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFEQrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVFEQrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 12:47:42 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:47081 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261599AbVFEQrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 12:47:10 -0400
Date: Sun, 5 Jun 2005 20:46:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050605204645.A28422@jurassic.park.msu.ru>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Sat, Jun 04, 2005 at 05:57:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 05:57:42PM +0200, Andreas Koch wrote:
> 2) The last messages right before the oops are
> 
>   PCI: Bridge 0000:00:1e.0
>     IO window 1000-6fff
>     MEM window: 01000000-0dffffff

Indeed. From your lspci output:
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])

It's the "transparent" bridge. The code in setup-bus.c doesn't handle this
properly.

Please try this patch - it should fix two problems:
- in pci_setup_bridge() use bridge resources directly, instead of
  the resource pointers in struct pci_bus (this fixes an oops);
- [ioport,iomem]_resource must not be touched in the bus setup code,
  otherwise we screw up the whole resource tree.

Ivan.

--- linux/drivers/pci/setup-bus.c.orig	Thu Apr 21 04:03:14 2005
+++ linux/drivers/pci/setup-bus.c	Sun Jun  5 18:37:57 2005
@@ -149,13 +149,14 @@ pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
 	struct pci_bus_region region;
+	struct resource *b_res= &bridge->resource[PCI_BRIDGE_RESOURCES];
 	u32 l, io_upper16;
 
 	DBG(KERN_INFO "PCI: Bridge: %s\n", pci_name(bridge));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
-	pcibios_resource_to_bus(bridge, &region, bus->resource[0]);
-	if (bus->resource[0]->flags & IORESOURCE_IO) {
+	pcibios_resource_to_bus(bridge, &region, &b_res[0]);
+	if (b_res[0].flags & IORESOURCE_IO) {
 		pci_read_config_dword(bridge, PCI_IO_BASE, &l);
 		l &= 0xffff0000;
 		l |= (region.start >> 8) & 0x00f0;
@@ -180,8 +181,8 @@ pci_setup_bridge(struct pci_bus *bus)
 
 	/* Set up the top and bottom of the PCI Memory segment
 	   for this bus. */
-	pcibios_resource_to_bus(bridge, &region, bus->resource[1]);
-	if (bus->resource[1]->flags & IORESOURCE_MEM) {
+	pcibios_resource_to_bus(bridge, &region, &b_res[1]);
+	if (b_res[1].flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		DBG(KERN_INFO "  MEM window: %08lx-%08lx\n",
@@ -199,8 +200,8 @@ pci_setup_bridge(struct pci_bus *bus)
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
 
 	/* Set up PREF base/limit. */
-	pcibios_resource_to_bus(bridge, &region, bus->resource[2]);
-	if (bus->resource[2]->flags & IORESOURCE_PREFETCH) {
+	pcibios_resource_to_bus(bridge, &region, &b_res[2]);
+	if (b_res[2].flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		DBG(KERN_INFO "  PREFETCH window: %08lx-%08lx\n",
@@ -270,6 +271,8 @@ find_free_bus_resource(struct pci_bus *b
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}
