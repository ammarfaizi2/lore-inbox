Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQLGQsy>; Thu, 7 Dec 2000 11:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbQLGQso>; Thu, 7 Dec 2000 11:48:44 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:11268 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130339AbQLGQsZ>; Thu, 7 Dec 2000 11:48:25 -0500
Date: Thu, 7 Dec 2000 19:05:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: Jay Estabrook <Jay.Estabrook@compaq.com>, linux-kernel@vger.kernel.org
Subject: alpha pci fixes (test12-pre7)
Message-ID: <20001207190549.A784@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix at least some of the boot problems reported recently.

- boot failure on Miata with >1Gb of memory, fixed by Jay Estabrook.
  Address written to the Translated Base Registers of CIA/Pyxis
  must be shifted by 2.

- fix oops on DP264 caused by Cypress quirk. We cannot call
  pci_claim_resource() from the quirk code, otherwise on multi-hose
  machines hose resources would appear to be a sibling, not parent for
  the resource we want to claim - pcibios_fixup_bus() is called _after_
  quirks fixup, thus pci_claim_resource() will always fail.
  Fortunately, another quite simple fix is possible - just disable
  resources for standard IDE ports, and generic IDE code will assume
  legacy addresses.

- off by one check in pci_dma_supported().

- proper calculation of the address space size for 64-bit PCI cards.

- start resource allocation on the root bus from PCIBIOS_MIN_[IO,MEM],
  not from 0. Otherwise if there is a bridge on the root bus, but no I/O
  or memory, the bridge's bases would be set too low. This doesn't matter
  in the I/O case since devices behind the bridge are allocated properly
  anyway, but could be harmful for memory case - the bridge will block
  transfers to the ISA sg window from secondary bus.

- sanity check in pci_dma_supported() for bogus regions.

Ivan.

diff -urp 2.4.0t12p7/arch/alpha/kernel/core_cia.c linux/arch/alpha/kernel/core_cia.c
--- 2.4.0t12p7/arch/alpha/kernel/core_cia.c	Wed Dec  6 15:00:54 2000
+++ linux/arch/alpha/kernel/core_cia.c	Thu Dec  7 13:18:33 2000
@@ -700,11 +700,11 @@ do_init_arch(int is_pyxis)
 
 	*(vip)CIA_IOC_PCI_W1_BASE = 0x40000000 | 1;
 	*(vip)CIA_IOC_PCI_W1_MASK = (0x40000000 - 1) & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = 0;
+	*(vip)CIA_IOC_PCI_T1_BASE = 0 >> 2;
 
 	*(vip)CIA_IOC_PCI_W2_BASE = 0x80000000 | 1;
 	*(vip)CIA_IOC_PCI_W2_MASK = (0x40000000 - 1) & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T2_BASE = 0x40000000;
+	*(vip)CIA_IOC_PCI_T2_BASE = 0x40000000 >> 2;
 
 	*(vip)CIA_IOC_PCI_W3_BASE = 0;
 }
diff -urp 2.4.0t12p7/arch/alpha/kernel/pci.c linux/arch/alpha/kernel/pci.c
--- 2.4.0t12p7/arch/alpha/kernel/pci.c	Wed Dec  6 15:00:54 2000
+++ linux/arch/alpha/kernel/pci.c	Thu Dec  7 13:16:44 2000
@@ -90,10 +90,8 @@ quirk_cypress_ide_ports(struct pci_dev *
 {
 	if (dev->class >> 8 != PCI_CLASS_STORAGE_IDE)
 		return;
-	dev->resource[1].start |= 2;
-	dev->resource[1].end = dev->resource[1].start;
-	pci_claim_resource(dev, 0);
-	pci_claim_resource(dev, 1);
+	dev->resource[0].flags = 0;
+	dev->resource[1].flags = 0;
 }
 
 static void __init
diff -urp 2.4.0t12p7/arch/alpha/kernel/pci_iommu.c linux/arch/alpha/kernel/pci_iommu.c
--- 2.4.0t12p7/arch/alpha/kernel/pci_iommu.c	Sat Sep 23 01:07:43 2000
+++ linux/arch/alpha/kernel/pci_iommu.c	Thu Dec  7 13:17:36 2000
@@ -613,10 +613,10 @@ pci_dma_supported(struct pci_dev *pdev, 
 	/* Check that we have a scatter-gather arena that fits.  */
 	hose = pdev ? pdev->sysdata : pci_isa_hose;
 	arena = hose->sg_isa;
-	if (arena && arena->dma_base + arena->size <= mask)
+	if (arena && arena->dma_base + arena->size - 1 <= mask)
 		return 1;
 	arena = hose->sg_pci;
-	if (arena && arena->dma_base + arena->size <= mask)
+	if (arena && arena->dma_base + arena->size - 1 <= mask)
 		return 1;
 
 	return 0;
diff -urp 2.4.0t12p7/drivers/pci/pci.c linux/drivers/pci/pci.c
--- 2.4.0t12p7/drivers/pci/pci.c	Wed Dec  6 15:00:57 2000
+++ linux/drivers/pci/pci.c	Thu Dec  7 14:46:49 2000
@@ -575,8 +575,9 @@ static void pci_read_bases(struct pci_de
 			pci_write_config_dword(dev, reg+4, ~0);
 			pci_read_config_dword(dev, reg+4, &sz);
 			pci_write_config_dword(dev, reg+4, l);
-			if (sz)
-				res->end = res->start + (((unsigned long) ~sz) << 32);
+			if (~sz)
+				res->end = res->start + 0xffffffff +
+						(((unsigned long) ~sz) << 32);
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", dev->slot_name);
diff -urp 2.4.0t12p7/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- 2.4.0t12p7/drivers/pci/setup-bus.c	Wed Dec  6 15:00:57 2000
+++ linux/drivers/pci/setup-bus.c	Thu Dec  7 13:21:24 2000
@@ -205,7 +205,7 @@ pbus_assign_resources(struct pci_bus *bu
 	}
 }
 
-void __init 
+void __init
 pci_assign_unassigned_resources(void)
 {
 	struct pbus_set_ranges_data ranges;
@@ -215,8 +215,8 @@ pci_assign_unassigned_resources(void)
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
 
-		ranges.io_start = b->resource[0]->start;
-		ranges.mem_start = b->resource[1]->start;
+		ranges.io_start = b->resource[0]->start + PCIBIOS_MIN_IO;
+		ranges.mem_start = b->resource[1]->start + PCIBIOS_MIN_MEM;
 		ranges.io_end = ranges.io_start;
 		ranges.mem_end = ranges.mem_start;
 		ranges.found_vga = 0;
diff -urp 2.4.0t12p7/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- 2.4.0t12p7/drivers/pci/setup-res.c	Wed Dec  6 15:00:57 2000
+++ linux/drivers/pci/setup-res.c	Thu Dec  7 14:05:20 2000
@@ -136,6 +136,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
+		unsigned long r_size;
 
 		/* PCI-PCI bridges may have I/O ports or
 		   memory on the primary bus */
@@ -144,15 +145,23 @@ pdev_sort_resources(struct pci_dev *dev,
 			continue;
 
 		r = &dev->resource[i];
+		r_size = r->end - r->start;
+		
 		if (!(r->flags & type_mask) || r->parent)
 			continue;
+		if (!r_size) {
+			printk(KERN_WARN "PCI: Ignore bogus resource %d "
+					 "[%lx:%lx] of %s\n",
+					  i, r->start, r->end, dev->name);
+			continue;
+		}
 		for (list = head; ; list = list->next) {
 			unsigned long size = 0;
 			struct resource_list *ln = list->next;
 
 			if (ln)
 				size = ln->res->end - ln->res->start;
-			if (r->end - r->start > size) {
+			if (r_size > size) {
 				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 				tmp->next = ln;
 				tmp->res = r;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
