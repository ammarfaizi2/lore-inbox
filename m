Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVGKWZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVGKWZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVGKWXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:23:45 -0400
Received: from isilmar.linta.de ([213.239.214.66]:55256 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262948AbVGKWVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:21:40 -0400
Date: Tue, 12 Jul 2005 00:21:38 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: akpm@osdl.org
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com
Subject: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource
Message-ID: <20050711222138.GH30827@isilmar.linta.de>
Mail-Followup-To: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In yenta_socket, we default to using the resource setting of the CardBus
bridge. However, this is a PCI-bus-centric view of resources and thus
needs to be converted to generic resources first. Therefore, add a call
to pcibios_bus_to_resource() call in between. This function is a mere
wrapper on x86 and friends, however on some others it already exists, is
added in this patch (alpha, arm, ppc, ppc64) or still needs to be 
provided (parisc -- where is its pcibios_resource_to_bus() ?).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---

 arch/alpha/kernel/pci.c       |   16 ++++++++++++++++
 arch/arm/kernel/bios32.c      |   17 +++++++++++++++++
 arch/ppc/kernel/pci.c         |   15 +++++++++++++++
 arch/ppc64/kernel/pci.c       |   20 ++++++++++++++++++++
 drivers/pcmcia/yenta_socket.c |   15 ++++++---------
 include/asm-alpha/pci.h       |    3 +++
 include/asm-arm/pci.h         |    4 ++++
 include/asm-generic/pci.h     |    8 ++++++++
 include/asm-parisc/pci.h      |    4 ++++
 include/asm-ppc/pci.h         |    4 ++++
 include/asm-ppc64/pci.h       |    4 ++++
 11 files changed, 101 insertions(+), 9 deletions(-)

Index: 2.6.13-rc2-git3/include/asm-generic/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-generic/pci.h
+++ 2.6.13-rc2-git3/include/asm-generic/pci.h
@@ -22,6 +22,14 @@ pcibios_resource_to_bus(struct pci_dev *
 	region->end = res->end;
 }
 
+static inline void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region)
+{
+	res->start = region->start;
+	res->end = region->end;
+}
+
 #define pcibios_scan_all_fns(a, b)	0
 
 #ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
Index: 2.6.13-rc2-git3/drivers/pcmcia/yenta_socket.c
===================================================================
--- 2.6.13-rc2-git3.orig/drivers/pcmcia/yenta_socket.c
+++ 2.6.13-rc2-git3/drivers/pcmcia/yenta_socket.c
@@ -605,9 +605,8 @@ static int yenta_search_res(struct yenta
 
 static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type, int addr_start, int addr_end)
 {
-	struct pci_bus *bus;
 	struct resource *root, *res;
-	u32 start, end;
+	struct pci_bus_region region;
 	unsigned mask;
 
 	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
@@ -620,15 +619,13 @@ static int yenta_allocate_res(struct yen
 	if (type & IORESOURCE_IO)
 		mask = ~3;
 
-	bus = socket->dev->subordinate;
-	res->name = bus->name;
+	res->name = socket->dev->subordinate->name;
 	res->flags = type;
 
-	start = config_readl(socket, addr_start) & mask;
-	end = config_readl(socket, addr_end) | ~mask;
-	if (start && end > start && !override_bios) {
-		res->start = start;
-		res->end = end;
+	region.start = config_readl(socket, addr_start) & mask;
+	region.end = config_readl(socket, addr_end) | ~mask;
+	if (region.start && region.end > region.start && !override_bios) {
+		pcibios_bus_to_resource(socket->dev, res, &region);
 		root = pci_find_parent_resource(socket->dev, res);
 		if (root && (request_resource(root, res) == 0))
 			return 0;
Index: 2.6.13-rc2-git3/arch/arm/kernel/bios32.c
===================================================================
--- 2.6.13-rc2-git3.orig/arch/arm/kernel/bios32.c
+++ 2.6.13-rc2-git3/arch/arm/kernel/bios32.c
@@ -447,9 +447,26 @@ pcibios_resource_to_bus(struct pci_dev *
 	region->end   = res->end - offset;
 }
 
+void __devinit
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region)
+{
+	struct pci_sys_data *root = dev->sysdata;
+	unsigned long offset = 0;
+
+	if (res->flags & IORESOURCE_IO)
+		offset = root->io_offset;
+	if (res->flags & IORESOURCE_MEM)
+		offset = root->mem_offset;
+
+	res->start = region->start + offset;
+	res->end   = region->end + offset;
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_fixup_bus);
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(pcibios_bus_to_resources);
 #endif
 
 /*
Index: 2.6.13-rc2-git3/include/asm-alpha/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-alpha/pci.h
+++ 2.6.13-rc2-git3/include/asm-alpha/pci.h
@@ -251,6 +251,9 @@ static inline int pci_get_legacy_ide_irq
 extern void pcibios_resource_to_bus(struct pci_dev *, struct pci_bus_region *,
 				    struct resource *);
 
+extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+				    struct pci_bus_region *region);
+
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
Index: 2.6.13-rc2-git3/include/asm-arm/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-arm/pci.h
+++ 2.6.13-rc2-git3/include/asm-arm/pci.h
@@ -60,6 +60,10 @@ extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+extern void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region);
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
Index: 2.6.13-rc2-git3/arch/alpha/kernel/pci.c
===================================================================
--- 2.6.13-rc2-git3.orig/arch/alpha/kernel/pci.c
+++ 2.6.13-rc2-git3/arch/alpha/kernel/pci.c
@@ -350,8 +350,24 @@ pcibios_resource_to_bus(struct pci_dev *
 	region->end = res->end - offset;
 }
 
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
+	unsigned long offset = 0;
+
+	if (res->flags & IORESOURCE_IO)
+		offset = hose->io_space->start;
+	else if (res->flags & IORESOURCE_MEM)
+		offset = hose->mem_space->start;
+
+	res->start = region->start + offset;
+	res->end = region->end + offset;
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 #endif
 
 int
Index: 2.6.13-rc2-git3/include/asm-parisc/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-parisc/pci.h
+++ 2.6.13-rc2-git3/include/asm-parisc/pci.h
@@ -253,6 +253,10 @@ extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+extern void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region);
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
Index: 2.6.13-rc2-git3/include/asm-ppc/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-ppc/pci.h
+++ 2.6.13-rc2-git3/include/asm-ppc/pci.h
@@ -105,6 +105,10 @@ extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res);
 
+extern void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region);
+
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
 
 struct file;
Index: 2.6.13-rc2-git3/arch/ppc/kernel/pci.c
===================================================================
--- 2.6.13-rc2-git3.orig/arch/ppc/kernel/pci.c
+++ 2.6.13-rc2-git3/arch/ppc/kernel/pci.c
@@ -160,6 +160,21 @@ void pcibios_resource_to_bus(struct pci_
 }
 EXPORT_SYMBOL(pcibios_resource_to_bus);
 
+void pcibios_resource_to_bus(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	unsigned long offset = 0;
+	struct pci_controller *hose = dev->sysdata;
+
+	if (hose && res->flags & IORESOURCE_IO)
+		offset = (unsigned long)hose->io_base_virt - isa_io_base;
+	else if (hose && res->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+	res->start = region->start + offset;
+	res->end = region->end + offset;
+}
+EXPORT_SYMBOL(pcibios_bus_to_resource);
+
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
Index: 2.6.13-rc2-git3/include/asm-ppc64/pci.h
===================================================================
--- 2.6.13-rc2-git3.orig/include/asm-ppc64/pci.h
+++ 2.6.13-rc2-git3/include/asm-ppc64/pci.h
@@ -134,6 +134,10 @@ extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res);
 
+extern void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region);
+
 extern int
 unmap_bus_range(struct pci_bus *bus);
 
Index: 2.6.13-rc2-git3/arch/ppc64/kernel/pci.c
===================================================================
--- 2.6.13-rc2-git3.orig/arch/ppc64/kernel/pci.c
+++ 2.6.13-rc2-git3/arch/ppc64/kernel/pci.c
@@ -108,8 +108,28 @@ void  pcibios_resource_to_bus(struct pci
 	region->end = res->end - offset;
 }
 
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			      struct pci_bus_region *region)
+{
+	unsigned long offset = 0;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (!hose)
+		return;
+
+	if (res->flags & IORESOURCE_IO)
+	        offset = (unsigned long)hose->io_base_virt - pci_io_base;
+
+	if (res->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+
+	res->start = region->start + offset;
+	res->end = region->end + offset;
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 #endif
 
 /*
