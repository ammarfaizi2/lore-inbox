Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJYPcs>; Fri, 25 Oct 2002 11:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJYPcs>; Fri, 25 Oct 2002 11:32:48 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:9224 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261449AbSJYPcq>; Fri, 25 Oct 2002 11:32:46 -0400
Date: Fri, 25 Oct 2002 19:37:25 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Scott Murray <scottm@somanetworks.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
       linux-ia64@linuxia64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021025193725.A3300@jurassic.park.msu.ru>
References: <20021024214952.GK25159@kroah.com> <Pine.LNX.4.33.0210241803420.10937-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0210241803420.10937-100000@rancor.yyz.somanetworks.com>; from scottm@somanetworks.com on Thu, Oct 24, 2002 at 06:22:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 06:22:44PM -0400, Scott Murray wrote:
> I hopefully will have something working against 2.5.44 tomorrow.  I think
> the only potentially contentious piece that I'd like to get reviewed and
> maybe integrated before the feature freeze is the resource reservation
> stuff.  There seemed to be no serious objections to the 2.4.x version I
> posted a while back, so maybe this won't be a big deal.  Everything else
> is either __devinit/export tweaks or driver code.

The setup-bus code already does resource reservation, but only for
cardbus. It can be easily extended for any type of hotplug
controller though. Other enhancements (like configurable amount
of reserved IO/memory) also shouldn't be a problem.

Also I have a patch (appended) that allows to use pbus_size_bridges()
for cardbus bridges (which have different resource layout vs. PCI-to-PCI
ones).

BTW, 2.5 setup-* stuff went into 2.4 recently. :-)

Ivan.

--- 2.5.36/drivers/pci/setup-res.c	Wed Sep 18 04:59:13 2002
+++ linux/drivers/pci/setup-res.c	Thu Sep 19 19:31:45 2002
@@ -137,7 +137,7 @@ pci_assign_resource(struct pci_dev *dev,
 }
 
 /* Sort resources by alignment */
-void __init
+void __devinit
 pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
 {
 	int i;
--- 2.5.36/drivers/pci/setup-bus.c	Wed Sep 18 04:58:56 2002
+++ linux/drivers/pci/setup-bus.c	Thu Sep 19 19:29:04 2002
@@ -35,7 +35,7 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
-static int __init
+static int __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
 	struct list_head *ln;
@@ -85,7 +85,7 @@ pbus_assign_resources_sorted(struct pci_
    requires that if there is no I/O ports or memory behind the
    bridge, corresponding range must be turned off by writing base
    value greater than limit to the bridge's base/limit registers.  */
-static void __init
+static void __devinit
 pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pbus_set_ranges_data ranges;
@@ -168,7 +168,7 @@ pci_setup_bridge(struct pci_bus *bus)
 /* Check whether the bridge supports optional I/O and
    prefetchable memory ranges. If not, the respective
    base/limit registers must be read-only and read as 0. */
-static void __init
+static void __devinit
 pci_bridge_check_ranges(struct pci_bus *bus)
 {
 	u16 io;
@@ -206,20 +206,38 @@ pci_bridge_check_ranges(struct pci_bus *
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 }
 
+/* Find first free bus resource of a given type */
+static struct resource * __devinit
+pbus_find_resource(struct pci_bus *bus, unsigned long type)
+{
+	int i;
+	struct resource *r;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		r = bus->resource[i];
+		if (r && !((r->flags ^ type) & type) && !r->parent)
+			return r;
+	}
+	return NULL;
+}
+
 /* Sizing the IO windows of the PCI-PCI bridge is trivial,
    since these windows have 4K granularity and the IO ranges
    of non-bridge PCI devices are limited to 256 bytes.
    We must be careful with the ISA aliasing though. */
-static void __init
+static void __devinit
 pbus_size_io(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	struct resource *b_res = bus->resource[0];
+	struct resource *b_res = pbus_find_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size1 = 0;
 
-	if (!(b_res->flags & IORESOURCE_IO))
+	if (!b_res)
 		return;
 
+	DBGC((KERN_INFO "PCI: found %s resource %ld for IO\n",
+			bus->name, b_res - bus->resource[0]));
+
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		int i;
@@ -259,15 +277,21 @@ pbus_size_io(struct pci_bus *bus)
 
 /* Calculate the size of the bus and minimal alignment which
    guarantees that all child resources fit in this size. */
-static void __init
+static int __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
 	struct list_head *ln;
 	unsigned long min_align, align, size;
 	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
-	struct resource *b_res = (type & IORESOURCE_PREFETCH) ?
-				 bus->resource[2] : bus->resource[1];
+	struct resource *b_res = pbus_find_resource(bus, type);
+
+	if (!b_res)
+		return 0;
+
+	DBGC((KERN_INFO "PCI: found %s resource %ld for %s\n",
+			bus->name, b_res - bus->resource[0],
+			type & IORESOURCE_PREFETCH ? "PREF" : "MEM"));
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -325,17 +349,18 @@ pbus_size_mem(struct pci_bus *bus, unsig
 	size = ROUND_UP(size, min_align);
 	if (!size) {
 		b_res->flags = 0;
-		return;
+		return 1;
 	}
 	b_res->start = min_align;
 	b_res->end = size + min_align - 1;
+	return 1;
 }
 
-void __init
+void __devinit
 pbus_size_bridges(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	unsigned long mask, type;
+	unsigned long mask, prefetch;
 
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
 		pbus_size_bridges(pci_bus_b(ln));
@@ -348,17 +373,15 @@ pbus_size_bridges(struct pci_bus *bus)
 
 	pbus_size_io(bus);
 
-	mask = type = IORESOURCE_MEM;
+	mask = IORESOURCE_MEM;
+	prefetch = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 	/* If the bridge supports prefetchable range, size it separately. */
-	if (bus->resource[2] &&
-	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
-		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
-		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
-	}
-	pbus_size_mem(bus, mask, type);
+	if (pbus_size_mem(bus, prefetch, prefetch))
+		mask = prefetch;		/* Size non-prefetch only. */
+	pbus_size_mem(bus, mask, IORESOURCE_MEM);
 }
 
-void __init
+void __devinit
 pbus_assign_resources(struct pci_bus *bus)
 {
 	struct list_head *ln;
@@ -367,7 +390,8 @@ pbus_assign_resources(struct pci_bus *bu
 	if (found_vga) {
 		struct pci_bus *b;
 
-		/* Propagate presence of the VGA to upstream bridges */
+		/* Propagate presence of the VGA to upstream bridges.
+		   This hack eventually will go away. */
 		for (b = bus; b->parent; b = b->parent) {
 			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
 		}
