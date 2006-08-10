Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWHJTg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWHJTg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWHJTg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49387 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932530AbWHJTg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:26 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [69/145] x86_64: Disable DAC on VIA PCI bridges
Message-Id: <20060810193625.3605D13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:25 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Because of several reports that it doesn't work

TBD needs a real confirmation this fixes the problem
TBD needs more testing

Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/x86_64/boot-options.txt |    4 +++
 arch/x86_64/kernel/pci-dma.c          |   42 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

Index: linux/Documentation/x86_64/boot-options.txt
===================================================================
--- linux.orig/Documentation/x86_64/boot-options.txt
+++ linux/Documentation/x86_64/boot-options.txt
@@ -199,6 +199,10 @@ IOMMU
    allowed  overwrite iommu off workarounds for specific chipsets.
    soft	 Use software bounce buffering (default for Intel machines)
    noaperture Don't touch the aperture for AGP.
+   allowdac Allow DMA >4GB - default selected based on chipset bugs
+	    When off all DMA over >4GB is forced through an IOMMU or bounce
+	    buffering.
+   nodac    Forbid DMA >4GB
 
   swiotlb=pages[,force]
 
Index: linux/arch/x86_64/kernel/pci-dma.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-dma.c
+++ linux/arch/x86_64/kernel/pci-dma.c
@@ -170,11 +170,47 @@ void dma_free_coherent(struct device *de
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
+static int allow_dac;
+
+static int bridge_from_vendor(struct device *dev, u16 vendor)
+{
+#ifdef CONFIG_PCI
+	struct pci_bus *bus;
+	if (dev->bus != &pci_bus_type)
+		return 0;
+	bus = to_pci_dev(dev)->bus;
+	/* RED-PEN
+	   Assumes no locking is needed on these lists because someone
+	   should hold a reference count on the target device.
+	   Correct assumption? */
+	while (bus != NULL) {
+		if (bus->self && bus->self->vendor == vendor)
+			return 1;
+		bus = bus->parent;
+	}
+#endif
+	return 0;
+}
+
 int dma_supported(struct device *dev, u64 mask)
 {
 	if (dma_ops->dma_supported)
 		return dma_ops->dma_supported(dev, mask);
 
+	if (mask > DMA_32BIT_MASK) {
+		/* Some VIA bridges seem to have trouble with Double Address
+		   Cycle.  Disable it behind them all for now. The driver
+		   should fall back to non DAC. */
+		if (bridge_from_vendor(dev, PCI_VENDOR_ID_VIA) && !allow_dac) {
+			printk(KERN_INFO
+			"PCI: %s disallowing DAC because of VIA bridge.\n",
+				dev->bus_id);
+			return 0;
+		}
+		if (allow_dac < 0)
+			return 0;
+	}
+
 	/* Copied from i386. Doesn't make much sense, because it will
 	   only work for pci_alloc_coherent.
 	   The caller just has to use GFP_DMA in this case. */
@@ -231,6 +267,8 @@ EXPORT_SYMBOL(dma_set_mask);
    allowed  overwrite iommu off workarounds for specific chipsets.
    soft	 Use software bounce buffering (default for Intel machines)
    noaperture Don't touch the aperture for AGP.
+   allowdac Allow DMA >4GB - default selected based on chipset bugs
+   nodac    Forbid DMA >4GB
 */
 __init int iommu_setup(char *p)
 {
@@ -264,6 +302,10 @@ __init int iommu_setup(char *p)
 		    iommu_merge = 0;
 	    if (!strncmp(p, "forcesac",8))
 		    iommu_sac_force = 1;
+	    if (!strncmp(p, "allowdac", 8))
+		    allow_dac = 1;
+	    if (!strncmp(p, "nodac", 5))
+		    allow_dac = -1;
 
 #ifdef CONFIG_SWIOTLB
 	    if (!strncmp(p, "soft",4))
