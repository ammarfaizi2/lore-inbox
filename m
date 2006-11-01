Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946562AbWKAFpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946562AbWKAFpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946553AbWKAFpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:45:17 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42716 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946524AbWKAFoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:44:44 -0500
Message-Id: <20061101054432.891109000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [PATCH 50/61] SPARC64: Fix PCI memory space root resource on Hummingbird.
Content-Disposition: inline; filename=sparc64-fix-pci-memory-space-root-resource-on-hummingbird.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

For Hummingbird PCI controllers, we should create the root
PCI memory space resource as the full 4GB area, and then
allocate the IOMMU DMA translation window out of there.

The old code just assumed that the IOMMU DMA translation base
to the top of the 4GB area was unusable.  This is not true on
many systems such as SB100 and SB150, where the IOMMU DMA
translation window sits at 0xc0000000->0xdfffffff.

So what would happen is that any device mapped by the firmware
at the top section 0xe0000000->0xffffffff would get remapped
by Linux somewhere else leading to all kinds of problems and
boot failures.

While we're here, report more cases of OBP resource assignment
conflicts.  The only truly valid ones are ROM resource conflicts.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/sparc64/kernel/pci_common.c |   29 ++++++++++-------------------
 arch/sparc64/kernel/pci_sabre.c  |   23 +++++++++++++++++++----
 2 files changed, 29 insertions(+), 23 deletions(-)

--- linux-2.6.18.1.orig/arch/sparc64/kernel/pci_common.c
+++ linux-2.6.18.1/arch/sparc64/kernel/pci_common.c
@@ -330,19 +330,6 @@ __init get_device_resource(struct linux_
 	return res;
 }
 
-static int __init pdev_resource_collisions_expected(struct pci_dev *pdev)
-{
-	if (pdev->vendor != PCI_VENDOR_ID_SUN)
-		return 0;
-
-	if (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS ||
-	    pdev->device == PCI_DEVICE_ID_SUN_RIO_1394 ||
-	    pdev->device == PCI_DEVICE_ID_SUN_RIO_USB)
-		return 1;
-
-	return 0;
-}
-
 static void __init pdev_record_assignments(struct pci_pbm_info *pbm,
 					   struct pci_dev *pdev)
 {
@@ -400,19 +387,23 @@ static void __init pdev_record_assignmen
 		pbm->parent->resource_adjust(pdev, res, root);
 
 		if (request_resource(root, res) < 0) {
+			int rnum;
+
 			/* OK, there is some conflict.  But this is fine
 			 * since we'll reassign it in the fixup pass.
 			 *
-			 * We notify the user that OBP made an error if it
-			 * is a case we don't expect.
+			 * Do not print the warning for ROM resources
+			 * as such a conflict is quite common and
+			 * harmless as the ROM bar is disabled.
 			 */
-			if (!pdev_resource_collisions_expected(pdev)) {
-				printk(KERN_ERR "PCI: Address space collision on region %ld "
+			rnum = (res - &pdev->resource[0]);
+			if (rnum != PCI_ROM_RESOURCE)
+				printk(KERN_ERR "PCI: Resource collision, "
+				       "region %d "
 				       "[%016lx:%016lx] of device %s\n",
-				       (res - &pdev->resource[0]),
+				       rnum,
 				       res->start, res->end,
 				       pci_name(pdev));
-			}
 		}
 	}
 }
--- linux-2.6.18.1.orig/arch/sparc64/kernel/pci_sabre.c
+++ linux-2.6.18.1/arch/sparc64/kernel/pci_sabre.c
@@ -1196,7 +1196,7 @@ static void pbm_register_toplevel_resour
 					    &pbm->mem_space);
 }
 
-static void sabre_pbm_init(struct pci_controller_info *p, struct device_node *dp, u32 dma_begin)
+static void sabre_pbm_init(struct pci_controller_info *p, struct device_node *dp, u32 dma_start, u32 dma_end)
 {
 	struct pci_pbm_info *pbm;
 	struct device_node *node;
@@ -1261,6 +1261,8 @@ static void sabre_pbm_init(struct pci_co
 		node = node->sibling;
 	}
 	if (simbas_found == 0) {
+		struct resource *rp;
+
 		/* No APBs underneath, probably this is a hummingbird
 		 * system.
 		 */
@@ -1302,8 +1304,10 @@ static void sabre_pbm_init(struct pci_co
 		pbm->io_space.end   = pbm->io_space.start + (1UL << 24) - 1UL;
 		pbm->io_space.flags = IORESOURCE_IO;
 
-		pbm->mem_space.start = p->pbm_A.controller_regs + SABRE_MEMSPACE;
-		pbm->mem_space.end   = pbm->mem_space.start + (unsigned long)dma_begin - 1UL;
+		pbm->mem_space.start =
+			(p->pbm_A.controller_regs + SABRE_MEMSPACE);
+		pbm->mem_space.end =
+			(pbm->mem_space.start + ((1UL << 32UL) - 1UL));
 		pbm->mem_space.flags = IORESOURCE_MEM;
 
 		if (request_resource(&ioport_resource, &pbm->io_space) < 0) {
@@ -1315,6 +1319,17 @@ static void sabre_pbm_init(struct pci_co
 			prom_halt();
 		}
 
+		rp = kmalloc(sizeof(*rp), GFP_KERNEL);
+		if (!rp) {
+			prom_printf("Cannot allocate IOMMU resource.\n");
+			prom_halt();
+		}
+		rp->name = "IOMMU";
+		rp->start = pbm->mem_space.start + (unsigned long) dma_start;
+		rp->end = pbm->mem_space.start + (unsigned long) dma_end - 1UL;
+		rp->flags = IORESOURCE_BUSY;
+		request_resource(&pbm->mem_space, rp);
+
 		pci_register_legacy_regions(&pbm->io_space,
 					    &pbm->mem_space);
 	}
@@ -1450,5 +1465,5 @@ void sabre_init(struct device_node *dp, 
 	/*
 	 * Look for APB underneath.
 	 */
-	sabre_pbm_init(p, dp, vdma[0]);
+	sabre_pbm_init(p, dp, vdma[0], vdma[0] + vdma[1]);
 }

--
