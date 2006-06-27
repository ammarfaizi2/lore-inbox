Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWF0QiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWF0QiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWF0Qh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:58 -0400
Received: from ns1.suse.de ([195.135.220.2]:25558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161173AbWF0QhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/17] [PATCH] 64bit resource: fix up printks for resources in pci core and hotplug drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:40 -0700
Message-Id: <11514260442539-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <115142604066-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/hotplug/cpcihp_zt5550.c |    9 +++++----
 drivers/pci/hotplug/cpqphp_core.c   |   10 +++++-----
 drivers/pci/hotplug/pciehp_hpc.c    |    5 +++--
 drivers/pci/hotplug/shpchp_sysfs.c  |   18 ++++++++++++------
 drivers/pci/pci.c                   |    6 ++++--
 drivers/pci/proc.c                  |   16 +++++-----------
 drivers/pci/setup-bus.c             |    6 ++++--
 drivers/pci/setup-res.c             |   28 +++++++++++++++++-----------
 8 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index f7cb00d..1ec165d 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
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
diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 9bc1deb..f8658d6 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
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
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d77138e..11f7858 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
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
diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index f5cfbf2..620e113 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 23d3b17..cf57d7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -691,10 +691,12 @@ int pci_request_region(struct pci_dev *p
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
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 54b2ebc..20dfd77 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -302,12 +302,6 @@ #endif /* HAVE_ARCH_PCI_GET_UNMAPPED_ARE
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
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 35086e8..47c1071 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -357,8 +357,10 @@ pbus_size_mem(struct pci_bus *bus, unsig
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
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 577f4b5..f5ff0d3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
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
@@ -213,8 +218,9 @@ pdev_sort_resources(struct pci_dev *dev,
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
-- 
1.4.0

