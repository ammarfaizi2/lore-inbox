Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVF1GSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVF1GSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVF1GRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:17:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:36332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261906AbVF1Fdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:54 -0400
Cc: davem@davemloft.net
Subject: [PATCH] PCI: DMA bursting advice
In-Reply-To: <11199367742637@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <1119936774843@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: DMA bursting advice

After seeing, at best, "guesses" as to the following kind
of information in several drivers, I decided that we really
need a way for platforms to specifically give advice in this
area for what works best with their PCI controller implementation.

Basically, this new interface gives DMA bursting advice on
PCI.  There are three forms of the advice:

1) Burst as much as possible, it is not necessary to end bursts
   on some particular boundary for best performance.

2) Burst on some byte count multiple.  A DMA burst to some multiple of
   number of bytes may be done, but it is important to end the burst
   on an exact multiple for best performance.

   The best example of this I am aware of are the PPC64 PCI
   controllers, where if you end a burst mid-cacheline then
   chip has to refetch the data and the IOMMU translations
   which hurts performance a lot.

3) Burst on a single byte count multiple.  Bursts shall end
   exactly on the next multiple boundary for best performance.

   Sparc64 and Alpha's PCI controllers operate this way.  They
   disconnect any device which tries to burst across a cacheline
   boundary.

   Actually, newer sparc64 PCI controllers do not have this behavior.
   That is why the "pdev" is passed into the interface, so I can
   add code later to check which PCI controller the system is using
   and give advice accordingly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e24c2d963a604d9eaa560c90371fa387d3eec8f1
tree 66be193d59dd22fac0b62980769c4f19e045b5a2
parent 2311b1f2bbd36fa5f366a7448c718b2556e0f02c
author David S. Miller <davem@davemloft.net> Thu, 02 Jun 2005 12:55:50 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:45 -0700

 include/asm-alpha/pci.h   |   17 +++++++++++++++++
 include/asm-arm/pci.h     |    8 ++++++++
 include/asm-frv/pci.h     |    8 ++++++++
 include/asm-i386/pci.h    |    8 ++++++++
 include/asm-ia64/pci.h    |   17 +++++++++++++++++
 include/asm-mips/pci.h    |    8 ++++++++
 include/asm-parisc/pci.h  |   17 +++++++++++++++++
 include/asm-ppc/pci.h     |    8 ++++++++
 include/asm-ppc64/pci.h   |   17 +++++++++++++++++
 include/asm-sh/pci.h      |    8 ++++++++
 include/asm-sh64/pci.h    |    8 ++++++++
 include/asm-sparc/pci.h   |    8 ++++++++
 include/asm-sparc64/pci.h |   17 +++++++++++++++++
 include/asm-v850/pci.h    |    8 ++++++++
 include/asm-x86_64/pci.h  |    8 ++++++++
 include/linux/pci.h       |    9 +++++++++
 16 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h
+++ b/include/asm-alpha/pci.h
@@ -223,6 +223,23 @@ pci_dac_dma_sync_single_for_device(struc
 	/* Nothing to do. */
 }
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	unsigned long cacheline_size;
+	u8 byte;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
+	if (byte == 0)
+		cacheline_size = 1024;
+	else
+		cacheline_size = (int) byte * 4;
+
+	*strat = PCI_DMA_BURST_BOUNDARY;
+	*strategy_parameter = cacheline_size;
+}
+
 /* TODO: integrate with include/asm-generic/pci.h ? */
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/include/asm-arm/pci.h b/include/asm-arm/pci.h
--- a/include/asm-arm/pci.h
+++ b/include/asm-arm/pci.h
@@ -42,6 +42,14 @@ static inline void pcibios_penalize_isa_
 #define pci_unmap_len(PTR, LEN_NAME)		((PTR)->LEN_NAME)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	(((PTR)->LEN_NAME) = (VAL))
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
                                enum pci_mmap_state mmap_state, int write_combine);
diff --git a/include/asm-frv/pci.h b/include/asm-frv/pci.h
--- a/include/asm-frv/pci.h
+++ b/include/asm-frv/pci.h
@@ -57,6 +57,14 @@ extern void pci_free_consistent(struct p
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 /*
  *	These are pretty much arbitary with the CoMEM implementation.
  *	We have the whole address space to ourselves.
diff --git a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -99,6 +99,14 @@ static inline void pcibios_add_platform_
 {
 }
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
diff --git a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h
+++ b/include/asm-ia64/pci.h
@@ -82,6 +82,23 @@ extern int pcibios_prep_mwi (struct pci_
 #define sg_dma_len(sg)		((sg)->dma_length)
 #define sg_dma_address(sg)	((sg)->dma_address)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	unsigned long cacheline_size;
+	u8 byte;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
+	if (byte == 0)
+		cacheline_size = 1024;
+	else
+		cacheline_size = (int) byte * 4;
+
+	*strat = PCI_DMA_BURST_MULTIPLE;
+	*strategy_parameter = cacheline_size;
+}
+
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -130,6 +130,14 @@ extern void pci_dac_dma_sync_single_for_
 extern void pci_dac_dma_sync_single_for_device(struct pci_dev *pdev,
 	dma64_addr_t dma_addr, size_t len, int direction);
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 	struct pci_bus_region *region, struct resource *res);
 
diff --git a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h
+++ b/include/asm-parisc/pci.h
@@ -230,6 +230,23 @@ extern inline void pcibios_register_hba(
 /* export the pci_ DMA API in terms of the dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	unsigned long cacheline_size;
+	u8 byte;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
+	if (byte == 0)
+		cacheline_size = 1024;
+	else
+		cacheline_size = (int) byte * 4;
+
+	*strat = PCI_DMA_BURST_MULTIPLE;
+	*strategy_parameter = cacheline_size;
+}
+
 extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -69,6 +69,14 @@ extern unsigned long pci_bus_to_phys(uns
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 /*
  * At present there are very few 32-bit PPC machines that can have
  * memory above the 4GB point, and we don't support that.
diff --git a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h
+++ b/include/asm-ppc64/pci.h
@@ -78,6 +78,23 @@ static inline int pci_dac_dma_supported(
 	return 0;
 }
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	unsigned long cacheline_size;
+	u8 byte;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
+	if (byte == 0)
+		cacheline_size = 1024;
+	else
+		cacheline_size = (int) byte * 4;
+
+	*strat = PCI_DMA_BURST_MULTIPLE;
+	*strategy_parameter = cacheline_size;
+}
+
 extern int pci_domain_nr(struct pci_bus *bus);
 
 /* Decide whether to display the domain number in /proc */
diff --git a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h
+++ b/include/asm-sh/pci.h
@@ -96,6 +96,14 @@ static inline void pcibios_penalize_isa_
 #define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))
 #define sg_dma_len(sg)		((sg)->length)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 /* Board-specific fixup routines. */
 extern void pcibios_fixup(void);
 extern void pcibios_fixup_irqs(void);
diff --git a/include/asm-sh64/pci.h b/include/asm-sh64/pci.h
--- a/include/asm-sh64/pci.h
+++ b/include/asm-sh64/pci.h
@@ -86,6 +86,14 @@ static inline void pcibios_penalize_isa_
 #define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 /* Board-specific fixup routines. */
 extern void pcibios_fixup(void);
 extern void pcibios_fixup_irqs(void);
diff --git a/include/asm-sparc/pci.h b/include/asm-sparc/pci.h
--- a/include/asm-sparc/pci.h
+++ b/include/asm-sparc/pci.h
@@ -144,6 +144,14 @@ extern inline int pci_dma_supported(stru
 
 #define pci_dac_dma_supported(dev, mask)	(0)
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
diff --git a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h
+++ b/include/asm-sparc64/pci.h
@@ -220,6 +220,23 @@ static inline int pci_dma_mapping_error(
 	return (dma_addr == PCI_DMA_ERROR_CODE);
 }
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	unsigned long cacheline_size;
+	u8 byte;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
+	if (byte == 0)
+		cacheline_size = 1024;
+	else
+		cacheline_size = (int) byte * 4;
+
+	*strat = PCI_DMA_BURST_BOUNDARY;
+	*strategy_parameter = cacheline_size;
+}
+
 /* Return the index of the PCI controller for device PDEV. */
 
 extern int pci_domain_nr(struct pci_bus *bus);
diff --git a/include/asm-v850/pci.h b/include/asm-v850/pci.h
--- a/include/asm-v850/pci.h
+++ b/include/asm-v850/pci.h
@@ -81,6 +81,14 @@ extern void
 pci_free_consistent (struct pci_dev *pdev, size_t size, void *cpu_addr,
 		     dma_addr_t dma_addr);
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -123,6 +123,14 @@ pci_dac_dma_sync_single_for_device(struc
 	flush_write_buffers();
 }
 
+static inline void pci_dma_burst_advice(struct pci_dev *pdev,
+					enum pci_dma_burst_strategy *strat,
+					unsigned long *strategy_parameter)
+{
+	*strat = PCI_DMA_BURST_INFINITY;
+	*strategy_parameter = ~0UL;
+}
+
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -874,6 +874,15 @@ int pci_scan_bridge(struct pci_bus *bus,
 #define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
 #define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
+enum pci_dma_burst_strategy {
+	PCI_DMA_BURST_INFINITY,	/* make bursts as large as possible,
+				   strategy_parameter is N/A */
+	PCI_DMA_BURST_BOUNDARY, /* disconnect at every strategy_parameter
+				   byte boundaries */
+	PCI_DMA_BURST_MULTIPLE, /* disconnect at some multiple of
+				   strategy_parameter byte boundaries */
+};
+
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 extern struct pci_dev *isa_bridge;
 #endif

