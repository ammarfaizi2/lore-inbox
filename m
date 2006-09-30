Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWI3Rvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWI3Rvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWI3Rvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:51:54 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:52427 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751315AbWI3Rvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:51:53 -0400
Date: Sat, 30 Sep 2006 20:51:48 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: [PATCH] x86-64: Calgary IOMMU: update to work with PCI domains
Message-ID: <20060930175148.GS22787@rhun.haifa.ibm.com>
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com> <451E40DF.30406@garzik.org> <20060930104248.GR22787@rhun.haifa.ibm.com> <451E57FE.5000600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451E57FE.5000600@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 07:41:50AM -0400, Jeff Garzik wrote:

> Muli Ben-Yehuda wrote:
> >The patch I posted earlier is all that's needed, if you could merge it
> >into #pciseg that would be fine. I'm pondering making one small
> >change though: in your pci domains patch, you have this snippet:
> 
> Would you be kind enough to resend the patch with a proper Signed-off-by 
> line?  (and subject/description, etc. while you're at it)

This patch updates Calgary to work with Jeff's PCI domains code by
moving each bus's pointer to its struct iommu_table to struct
pci_sysdata, rather than stashing it in ->sysdata directly.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>

diff -Naurp -X /home/muli/w/dontdiff pci-domains/arch/x86_64/kernel/pci-calgary.c linux/arch/x86_64/kernel/pci-calgary.c
--- pci-domains/arch/x86_64/kernel/pci-calgary.c	2006-09-28 13:31:14.000000000 +0300
+++ linux/arch/x86_64/kernel/pci-calgary.c	2006-09-28 13:14:38.000000000 +0300
@@ -317,7 +317,7 @@ void calgary_unmap_sg(struct device *dev
 		      int nelems, int direction)
 {
 	unsigned long flags;
-	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	struct iommu_table *tbl = pci_iommu(to_pci_dev(dev)->bus);
 
 	if (!translate_phb(to_pci_dev(dev)))
 		return;
@@ -346,7 +346,7 @@ static int calgary_nontranslate_map_sg(s
 int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 	int nelems, int direction)
 {
-	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	struct iommu_table *tbl = pci_iommu(to_pci_dev(dev)->bus);
 	unsigned long flags;
 	unsigned long vaddr;
 	unsigned int npages;
@@ -400,7 +400,7 @@ dma_addr_t calgary_map_single(struct dev
 	dma_addr_t dma_handle = bad_dma_address;
 	unsigned long uaddr;
 	unsigned int npages;
-	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	struct iommu_table *tbl = pci_iommu(to_pci_dev(dev)->bus);
 
 	uaddr = (unsigned long)vaddr;
 	npages = num_dma_pages(uaddr, size);
@@ -416,7 +416,7 @@ dma_addr_t calgary_map_single(struct dev
 void calgary_unmap_single(struct device *dev, dma_addr_t dma_handle,
 	size_t size, int direction)
 {
-	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	struct iommu_table *tbl = pci_iommu(to_pci_dev(dev)->bus);
 	unsigned int npages;
 
 	if (!translate_phb(to_pci_dev(dev)))
@@ -434,7 +434,7 @@ void* calgary_alloc_coherent(struct devi
 	unsigned int npages, order;
 	struct iommu_table *tbl;
 
-	tbl = to_pci_dev(dev)->bus->self->sysdata;
+	tbl = pci_iommu(to_pci_dev(dev)->bus);
 
 	size = PAGE_ALIGN(size); /* size rounded up to full pages */
 	npages = size >> PAGE_SHIFT;
@@ -551,7 +551,7 @@ static void __init calgary_reserve_mem_r
 	limit++;
 
 	numpages = ((limit - start) >> PAGE_SHIFT);
-	iommu_range_reserve(dev->sysdata, start, numpages);
+	iommu_range_reserve(pci_iommu(dev->bus), start, numpages);
 }
 
 static void __init calgary_reserve_peripheral_mem_1(struct pci_dev *dev)
@@ -559,7 +559,7 @@ static void __init calgary_reserve_perip
 	void __iomem *target;
 	u64 low, high, sizelow;
 	u64 start, limit;
-	struct iommu_table *tbl = dev->sysdata;
+	struct iommu_table *tbl = pci_iommu(dev->bus);
 	unsigned char busnum = dev->bus->number;
 	void __iomem *bbar = tbl->bbar;
 
@@ -583,7 +583,7 @@ static void __init calgary_reserve_perip
 	u32 val32;
 	u64 low, high, sizelow, sizehigh;
 	u64 start, limit;
-	struct iommu_table *tbl = dev->sysdata;
+	struct iommu_table *tbl = pci_iommu(dev->bus);
 	unsigned char busnum = dev->bus->number;
 	void __iomem *bbar = tbl->bbar;
 
@@ -621,7 +621,7 @@ static void __init calgary_reserve_regio
 	void __iomem *bbar;
 	unsigned char busnum;
 	u64 start;
-	struct iommu_table *tbl = dev->sysdata;
+	struct iommu_table *tbl = pci_iommu(dev->bus);
 
 	bbar = tbl->bbar;
 	busnum = dev->bus->number;
@@ -652,7 +652,7 @@ static int __init calgary_setup_tar(stru
 	if (ret)
 		return ret;
 
-	tbl = dev->sysdata;
+	tbl = pci_iommu(dev->bus);
 	tbl->it_base = (unsigned long)bus_info[dev->bus->number].tce_space;
 	tce_free(tbl, 0, tbl->it_size);
 
@@ -665,7 +665,7 @@ static int __init calgary_setup_tar(stru
 	/* zero out all TAR bits under sw control */
 	val64 &= ~TAR_SW_BITS;
 
-	tbl = dev->sysdata;
+	tbl = pci_iommu(dev->bus);
 	table_phys = (u64)__pa(tbl->it_base);
 	val64 |= table_phys;
 
@@ -682,7 +682,7 @@ static int __init calgary_setup_tar(stru
 static void __init calgary_free_bus(struct pci_dev *dev)
 {
 	u64 val64;
-	struct iommu_table *tbl = dev->sysdata;
+	struct iommu_table *tbl = pci_iommu(dev->bus);
 	void __iomem *target;
 	unsigned int bitmapsz;
 
@@ -697,7 +697,8 @@ static void __init calgary_free_bus(stru
 	tbl->it_map = NULL;
 
 	kfree(tbl);
-	dev->sysdata = NULL;
+	
+	set_pci_iommu(dev->bus, NULL);
 
 	/* Can't free bootmem allocated memory after system is up :-( */
 	bus_info[dev->bus->number].tce_space = NULL;
@@ -706,7 +707,7 @@ static void __init calgary_free_bus(stru
 static void calgary_watchdog(unsigned long data)
 {
 	struct pci_dev *dev = (struct pci_dev *)data;
-	struct iommu_table *tbl = dev->sysdata;
+	struct iommu_table *tbl = pci_iommu(dev->bus);
 	void __iomem *bbar = tbl->bbar;
 	u32 val32;
 	void __iomem *target;
@@ -742,7 +743,7 @@ static void __init calgary_enable_transl
 	struct iommu_table *tbl;
 
 	busnum = dev->bus->number;
-	tbl = dev->sysdata;
+	tbl = pci_iommu(dev->bus);
 	bbar = tbl->bbar;
 
 	/* enable TCE in PHB Config Register */
@@ -772,7 +773,7 @@ static void __init calgary_disable_trans
 	struct iommu_table *tbl;
 
 	busnum = dev->bus->number;
-	tbl = dev->sysdata;
+	tbl = pci_iommu(dev->bus);
 	bbar = tbl->bbar;
 
 	/* disable TCE in PHB Config Register */
@@ -813,8 +814,7 @@ static inline unsigned int __init locate
 static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
 	pci_dev_get(dev);
-	dev->sysdata = NULL;
-	dev->bus->self = dev;
+	set_pci_iommu(dev->bus, NULL);
 }
 
 static int __init calgary_init_one(struct pci_dev *dev)
diff -Naurp -X /home/muli/w/dontdiff pci-domains/arch/x86_64/kernel/tce.c linux/arch/x86_64/kernel/tce.c
--- pci-domains/arch/x86_64/kernel/tce.c	2006-09-28 13:31:14.000000000 +0300
+++ linux/arch/x86_64/kernel/tce.c	2006-09-28 13:40:52.000000000 +0300
@@ -137,9 +137,9 @@ int build_tce_table(struct pci_dev *dev,
 	struct iommu_table *tbl;
 	int ret;
 
-	if (dev->sysdata) {
-		printk(KERN_ERR "Calgary: dev %p has sysdata %p\n",
-		       dev, dev->sysdata);
+	if (pci_iommu(dev->bus)) {
+		printk(KERN_ERR "Calgary: dev %p has sysdata->iommu %p\n",
+		       dev, pci_iommu(dev->bus));
 		BUG();
 	}
 
@@ -156,11 +156,7 @@ int build_tce_table(struct pci_dev *dev,
 
 	tbl->bbar = bbar;
 
-	/*
-	 * NUMA is already using the bus's sysdata pointer, so we use
-	 * the bus's pci_dev's sysdata instead.
-	 */
-	dev->sysdata = tbl;
+	set_pci_iommu(dev->bus, tbl);
 
 	return 0;
 
diff -Naurp -X /home/muli/w/dontdiff pci-domains/include/asm-x86_64/pci.h linux/include/asm-x86_64/pci.h
--- pci-domains/include/asm-x86_64/pci.h	2006-09-28 13:34:05.000000000 +0300
+++ linux/include/asm-x86_64/pci.h	2006-09-28 15:19:56.000000000 +0300
@@ -8,6 +8,7 @@
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
+	void*		iommu;		/* IOMMU private data */
 };
 
 #ifdef CONFIG_PCI_DOMAINS
@@ -23,6 +24,20 @@ static inline int pci_proc_domain(struct
 }
 #endif /* CONFIG_PCI_DOMAINS */
 
+#ifdef CONFIG_CALGARY_IOMMU
+static inline void* pci_iommu(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->iommu;
+}
+
+static inline void set_pci_iommu(struct pci_bus *bus, void *val)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	sd->iommu = val;
+}
+#endif /* CONFIG_CALGARY_IOMMU */
+
 #include <linux/mm.h> /* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
