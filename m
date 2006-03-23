Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWCWUBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWCWUBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWCWUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:01:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:41905 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751492AbWCWUBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:01:36 -0500
Date: Thu, 23 Mar 2006 15:01:19 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 2/10] 64 bit resources drivers pci changes
Message-ID: <20060323200119.GF7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323195944.GE7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required in drivers/pci/* to support 64bit resources.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/pci/bus.c                   |    4 ++--
 drivers/pci/hotplug/cpcihp_zt5550.c |    9 +++++----
 drivers/pci/hotplug/cpqphp_core.c   |   10 +++++-----
 drivers/pci/hotplug/pciehp_hpc.c    |    5 +++--
 drivers/pci/hotplug/shpchp_sysfs.c  |   18 ++++++++++++------
 drivers/pci/pci.c                   |    6 ++++--
 drivers/pci/pci.h                   |    6 +++---
 drivers/pci/proc.c                  |   16 +++++-----------
 drivers/pci/rom.c                   |   10 +++++-----
 drivers/pci/setup-bus.c             |    6 ++++--
 drivers/pci/setup-res.c             |   34 ++++++++++++++++++++--------------
 include/linux/pci.h                 |    8 ++++----
 12 files changed, 72 insertions(+), 60 deletions(-)

diff -puN drivers/pci/bus.c~64bit-resources-drivers-pci-changes drivers/pci/bus.c
--- linux-2.6.16-mm1/drivers/pci/bus.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/bus.c	2006-03-23 11:38:58.000000000 -0500
@@ -34,10 +34,10 @@
  */
 int
 pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-	unsigned long size, unsigned long align, unsigned long min,
+	u64 size, u64 align, u64 min,
 	unsigned int type_mask,
 	void (*alignf)(void *, struct resource *,
-			unsigned long, unsigned long),
+			u64, u64),
 	void *alignf_data)
 {
 	int i, ret = -ENOMEM;
diff -puN drivers/pci/hotplug/cpcihp_zt5550.c~64bit-resources-drivers-pci-changes drivers/pci/hotplug/cpcihp_zt5550.c
--- linux-2.6.16-mm1/drivers/pci/hotplug/cpcihp_zt5550.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/hotplug/cpcihp_zt5550.c	2006-03-23 11:38:58.000000000 -0500
@@ -95,8 +95,8 @@ static int zt5550_hc_config(struct pci_d
 
 	hc_dev = pdev;
 	dbg("hc_dev = %p", hc_dev);
-	dbg("pci resource start %lx", pci_resource_start(hc_dev, 1));
-	dbg("pci resource len %lx", pci_resource_len(hc_dev, 1));
+	dbg("pci resource start %llx", (unsigned long long)pci_resource_start(hc_dev, 1));
+	dbg("pci resource len %llx", (unsigned long long)pci_resource_len(hc_dev, 1));
 
 	if(!request_mem_region(pci_resource_start(hc_dev, 1),
 				pci_resource_len(hc_dev, 1), MY_NAME)) {
@@ -108,8 +108,9 @@ static int zt5550_hc_config(struct pci_d
 	hc_registers =
 	    ioremap(pci_resource_start(hc_dev, 1), pci_resource_len(hc_dev, 1));
 	if(!hc_registers) {
-		err("cannot remap MMIO region %lx @ %lx",
-		    pci_resource_len(hc_dev, 1), pci_resource_start(hc_dev, 1));
+		err("cannot remap MMIO region %llx @ %llx",
+			(unsigned long long)pci_resource_len(hc_dev, 1),
+			(unsigned long long)pci_resource_start(hc_dev, 1));
 		ret = -ENODEV;
 		goto exit_release_region;
 	}
diff -puN drivers/pci/hotplug/cpqphp_core.c~64bit-resources-drivers-pci-changes drivers/pci/hotplug/cpqphp_core.c
--- linux-2.6.16-mm1/drivers/pci/hotplug/cpqphp_core.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/hotplug/cpqphp_core.c	2006-03-23 11:38:58.000000000 -0500
@@ -1089,8 +1089,8 @@ static int cpqhpc_probe(struct pci_dev *
 	}
 	
 	dbg("pdev = %p\n", pdev);
-	dbg("pci resource start %lx\n", pci_resource_start(pdev, 0));
-	dbg("pci resource len %lx\n", pci_resource_len(pdev, 0));
+	dbg("pci resource start %llx\n", (unsigned long long)pci_resource_start(pdev, 0));
+	dbg("pci resource len %llx\n", (unsigned long long)pci_resource_len(pdev, 0));
 
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 				pci_resource_len(pdev, 0), MY_NAME)) {
@@ -1102,9 +1102,9 @@ static int cpqhpc_probe(struct pci_dev *
 	ctrl->hpc_reg = ioremap(pci_resource_start(pdev, 0),
 					pci_resource_len(pdev, 0));
 	if (!ctrl->hpc_reg) {
-		err("cannot remap MMIO region %lx @ %lx\n",
-				pci_resource_len(pdev, 0),
-				pci_resource_start(pdev, 0));
+		err("cannot remap MMIO region %llx @ %llx\n",
+		    (unsigned long long)pci_resource_len(pdev, 0),
+		    (unsigned long long)pci_resource_start(pdev, 0));
 		rc = -ENODEV;
 		goto err_free_mem_region;
 	}
diff -puN drivers/pci/hotplug/pciehp_hpc.c~64bit-resources-drivers-pci-changes drivers/pci/hotplug/pciehp_hpc.c
--- linux-2.6.16-mm1/drivers/pci/hotplug/pciehp_hpc.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/hotplug/pciehp_hpc.c	2006-03-23 11:38:58.000000000 -0500
@@ -1398,8 +1398,9 @@ int pcie_init(struct controller * ctrl, 
 
 	for ( rc = 0; rc < DEVICE_COUNT_RESOURCE; rc++)
 		if (pci_resource_len(pdev, rc) > 0)
-			dbg("pci resource[%d] start=0x%lx(len=0x%lx)\n", rc,
-				pci_resource_start(pdev, rc), pci_resource_len(pdev, rc));
+			dbg("pci resource[%d] start=0x%llx(len=0x%llx)\n", rc,
+			    (unsigned long long)pci_resource_start(pdev, rc),
+			    (unsigned long long)pci_resource_len(pdev, rc));
 
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, 
 		pdev->subsystem_vendor, pdev->subsystem_device);
diff -puN drivers/pci/hotplug/shpchp_sysfs.c~64bit-resources-drivers-pci-changes drivers/pci/hotplug/shpchp_sysfs.c
--- linux-2.6.16-mm1/drivers/pci/hotplug/shpchp_sysfs.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/hotplug/shpchp_sysfs.c	2006-03-23 11:38:58.000000000 -0500
@@ -51,8 +51,10 @@ static ssize_t show_ctrl (struct device 
 		res = bus->resource[index];
 		if (res && (res->flags & IORESOURCE_MEM) &&
 				!(res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8lx, length = %8.8lx\n",
-					res->start, (res->end - res->start));
+			out += sprintf(out, "start = %8.8llx, "
+					"length = %8.8llx\n",
+					(unsigned long long)res->start,
+					(unsigned long long)(res->end - res->start));
 		}
 	}
 	out += sprintf(out, "Free resources: prefetchable memory\n");
@@ -60,16 +62,20 @@ static ssize_t show_ctrl (struct device 
 		res = bus->resource[index];
 		if (res && (res->flags & IORESOURCE_MEM) &&
 			       (res->flags & IORESOURCE_PREFETCH)) {
-			out += sprintf(out, "start = %8.8lx, length = %8.8lx\n",
-					res->start, (res->end - res->start));
+			out += sprintf(out, "start = %8.8llx, "
+					"length = %8.8llx\n",
+					(unsigned long long)res->start,
+					(unsigned long long)(res->end - res->start));
 		}
 	}
 	out += sprintf(out, "Free resources: IO\n");
 	for (index = 0; index < PCI_BUS_NUM_RESOURCES; index++) {
 		res = bus->resource[index];
 		if (res && (res->flags & IORESOURCE_IO)) {
-			out += sprintf(out, "start = %8.8lx, length = %8.8lx\n",
-					res->start, (res->end - res->start));
+			out += sprintf(out, "start = %8.8llx, "
+					"length = %8.8llx\n",
+					(unsigned long long)res->start,
+					(unsigned long long)(res->end - res->start));
 		}
 	}
 	out += sprintf(out, "Free resources: bus numbers\n");
diff -puN drivers/pci/pci.c~64bit-resources-drivers-pci-changes drivers/pci/pci.c
--- linux-2.6.16-mm1/drivers/pci/pci.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/pci.c	2006-03-23 11:38:58.000000000 -0500
@@ -669,10 +669,12 @@ int pci_request_region(struct pci_dev *p
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
+	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%llx@%llx "
+		"for device %s\n",
 		pci_resource_flags(pdev, bar) & IORESOURCE_IO ? "I/O" : "mem",
 		bar + 1, /* PCI BAR # */
-		pci_resource_len(pdev, bar), pci_resource_start(pdev, bar),
+		(unsigned long long)pci_resource_len(pdev, bar),
+		(unsigned long long)pci_resource_start(pdev, bar),
 		pci_name(pdev));
 	return -EBUSY;
 }
diff -puN drivers/pci/pci.h~64bit-resources-drivers-pci-changes drivers/pci/pci.h
--- linux-2.6.16-mm1/drivers/pci/pci.h~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/pci.h	2006-03-23 11:38:58.000000000 -0500
@@ -6,10 +6,10 @@ extern int pci_create_sysfs_dev_files(st
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-				  unsigned long size, unsigned long align,
-				  unsigned long min, unsigned int type_mask,
+				  u64 size, u64 align,
+				  u64 min, unsigned int type_mask,
 				  void (*alignf)(void *, struct resource *,
-					  	 unsigned long, unsigned long),
+					  	 u64, u64),
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
diff -puN drivers/pci/proc.c~64bit-resources-drivers-pci-changes drivers/pci/proc.c
--- linux-2.6.16-mm1/drivers/pci/proc.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/proc.c	2006-03-23 11:38:58.000000000 -0500
@@ -302,12 +302,6 @@ static struct file_operations proc_bus_p
 #endif /* HAVE_PCI_MMAP */
 };
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
-
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
@@ -358,16 +352,16 @@ static int show_device(struct seq_file *
 	for (i=0; i<7; i++) {
 		u64 start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
-		seq_printf(m, LONG_FORMAT,
-			((unsigned long)start) |
-			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
+		seq_printf(m, "\t%16llx",
+			(unsigned long long)(start |
+			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
 	}
 	for (i=0; i<7; i++) {
 		u64 start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
-		seq_printf(m, LONG_FORMAT,
+		seq_printf(m, "\t%16llx",
 			dev->resource[i].start < dev->resource[i].end ?
-			(unsigned long)(end - start) + 1 : 0);
+			(unsigned long long)(end - start) + 1 : 0);
 	}
 	seq_putc(m, '\t');
 	if (drv)
diff -puN drivers/pci/rom.c~64bit-resources-drivers-pci-changes drivers/pci/rom.c
--- linux-2.6.16-mm1/drivers/pci/rom.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/rom.c	2006-03-23 11:38:58.000000000 -0500
@@ -80,8 +80,8 @@ void __iomem *pci_map_rom(struct pci_dev
 	} else {
 		if (res->flags & IORESOURCE_ROM_COPY) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-			return (void __iomem *)pci_resource_start(pdev,
-							     PCI_ROM_RESOURCE);
+			return (void __iomem *)(unsigned long)
+				pci_resource_start(pdev, PCI_ROM_RESOURCE);
 		} else {
 			/* assign the ROM an address if it doesn't have one */
 			if (res->parent == NULL &&
@@ -170,11 +170,11 @@ void __iomem *pci_map_rom_copy(struct pc
 		return rom;
 
 	res->end = res->start + *size;
-	memcpy_fromio((void*)res->start, rom, *size);
+	memcpy_fromio((void*)(unsigned long)res->start, rom, *size);
 	pci_unmap_rom(pdev, rom);
 	res->flags |= IORESOURCE_ROM_COPY;
 
-	return (void __iomem *)res->start;
+	return (void __iomem *)(unsigned long)res->start;
 }
 
 /**
@@ -227,7 +227,7 @@ void pci_cleanup_rom(struct pci_dev *pde
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	if (res->flags & IORESOURCE_ROM_COPY) {
-		kfree((void*)res->start);
+		kfree((void*)(unsigned long)res->start);
 		res->flags &= ~IORESOURCE_ROM_COPY;
 		res->start = 0;
 		res->end = 0;
diff -puN drivers/pci/setup-bus.c~64bit-resources-drivers-pci-changes drivers/pci/setup-bus.c
--- linux-2.6.16-mm1/drivers/pci/setup-bus.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/setup-bus.c	2006-03-23 11:38:58.000000000 -0500
@@ -356,8 +356,10 @@ pbus_size_mem(struct pci_bus *bus, unsig
 			order = __ffs(align) - 20;
 			if (order > 11) {
 				printk(KERN_WARNING "PCI: region %s/%d "
-				       "too large: %lx-%lx\n",
-				       pci_name(dev), i, r->start, r->end);
+				       "too large: %llx-%llx\n",
+					pci_name(dev), i,
+					(unsigned long long)r->start,
+					(unsigned long long)r->end);
 				r->flags = 0;
 				continue;
 			}
diff -puN drivers/pci/setup-res.c~64bit-resources-drivers-pci-changes drivers/pci/setup-res.c
--- linux-2.6.16-mm1/drivers/pci/setup-res.c~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pci/setup-res.c	2006-03-23 11:38:58.000000000 -0500
@@ -40,8 +40,9 @@ pci_update_resource(struct pci_dev *dev,
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	pr_debug("  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
-		 "BAR %d of %s\n", res->start, res->end,
+	pr_debug("  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
+		 "BAR %d of %s\n", (unsigned long long)res->start,
+		 (unsigned long long)res->end,
 		 region.start, region.end, res->flags, resno, pci_name(dev));
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
@@ -104,10 +105,12 @@ pci_claim_resource(struct pci_dev *dev, 
 		err = insert_resource(root, res);
 
 	if (err) {
-		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",
-		       root ? "Address space collision on" :
-			      "No parent found for",
-		       resource, dtype, pci_name(dev), res->start, res->end);
+		printk(KERN_ERR "PCI: %s region %d of %s %s [%llx:%llx]\n",
+			root ? "Address space collision on" :
+				"No parent found for",
+			resource, dtype, pci_name(dev),
+			(unsigned long long)res->start,
+			(unsigned long long)res->end);
 	}
 
 	return err;
@@ -118,7 +121,7 @@ int pci_assign_resource(struct pci_dev *
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	unsigned long size, min, align;
+	u64 size, min, align;
 	int ret;
 
 	size = res->end - res->start + 1;
@@ -145,9 +148,11 @@ int pci_assign_resource(struct pci_dev *
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
-		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
-		       resno, size, res->start, pci_name(dev));
+		printk(KERN_ERR "PCI: Failed to allocate %s resource "
+			"#%d:%llx@%llx for %s\n",
+			res->flags & IORESOURCE_IO ? "I/O" : "mem",
+			resno, (unsigned long long)size,
+			(unsigned long long)res->start, pci_name(dev));
 	} else if (resno < PCI_BRIDGE_RESOURCES) {
 		pci_update_resource(dev, res, resno);
 	}
@@ -164,7 +169,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		unsigned long r_align;
+		u64 r_align;
 
 		r = &dev->resource[i];
 		r_align = r->end - r->start;
@@ -173,13 +178,14 @@ pdev_sort_resources(struct pci_dev *dev,
 			continue;
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, pci_name(dev));
+				"[%llx:%llx] of %s\n",
+				i, (unsigned long long)r->start,
+				(unsigned long long)r->end, pci_name(dev));
 			continue;
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
 		for (list = head; ; list = list->next) {
-			unsigned long align = 0;
+			u64 align = 0;
 			struct resource_list *ln = list->next;
 			int idx;
 
diff -puN include/linux/pci.h~64bit-resources-drivers-pci-changes include/linux/pci.h
--- linux-2.6.16-mm1/include/linux/pci.h~64bit-resources-drivers-pci-changes	2006-03-23 11:38:58.000000000 -0500
+++ linux-2.6.16-mm1-root/include/linux/pci.h	2006-03-23 11:38:58.000000000 -0500
@@ -403,7 +403,7 @@ char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
 void pcibios_align_resource(void *, struct resource *,
-			    unsigned long, unsigned long);
+			    u64, u64);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Generic PCI functions used internally */
@@ -528,10 +528,10 @@ void pci_release_region(struct pci_dev *
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   unsigned long size, unsigned long align,
-			   unsigned long min, unsigned int type_mask,
+			   u64 size, u64 align,
+			   u64 min, unsigned int type_mask,
 			   void (*alignf)(void *, struct resource *,
-					  unsigned long, unsigned long),
+					  u64, u64),
 			   void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
_
