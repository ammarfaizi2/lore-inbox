Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVLISUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVLISUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVLISUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:42991 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964857AbVLISUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:20:01 -0500
Message-Id: <20051209182054.342686000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:20 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jens.Osterkamp@de.ibm.com, Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 6/8] cell: add iommu support for larger memory
Content-Disposition: inline; filename=iommu-new-firmware-7.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far, the iommu code was hardwired to a linear mapping
between 0x20000000 and 0x40000000, so it could only support
512MB of RAM.

This patch still keeps the linear mapping, but looks for
proper ibm,dma-window properties to set up larger windows,
this makes the maximum supported RAM size 2GB.

If there is anything unusual about the dma-window properties,
we fall back to the old behavior.

We also support switching off the iommu completely now
with the regular iommu=off command line option.

From: Jens.Osterkamp@de.ibm.com
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/iommu.c
@@ -29,6 +29,8 @@
 #include <linux/bootmem.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
 
 #include <asm/sections.h>
 #include <asm/iommu.h>
@@ -40,6 +42,7 @@
 #include <asm/abs_addr.h>
 #include <asm/system.h>
 #include <asm/ppc-pci.h>
+#include <asm/udbg.h>
 
 #include "iommu.h"
 
@@ -220,8 +223,6 @@ set_iopt_cache(void __iomem *base, unsig
 {
 	unsigned long __iomem *tags = base + IOC_PT_CACHE_DIR;
 	unsigned long __iomem *p = base + IOC_PT_CACHE_REG;
-	pr_debug("iopt %02lx was v%016lx/t%016lx, store v%016lx/t%016lx\n",
-		index, get_iopt_cache(base, index, &oldtag), oldtag, val, tag);
 
 	out_be64(p, val);
 	out_be64(&tags[index], tag);
@@ -248,67 +249,176 @@ set_iocmd_config(void __iomem *base)
 	out_be64(p, conf | IOCMD_CONF_TE);
 }
 
-/* FIXME: get these from the device tree */
-#define ioc_base	0x20000511000ull
-#define ioc_mmio_base	0x20000510000ull
-#define ioid		0x48a
-#define iopt_phys_offset (- 0x20000000) /* We have a 512MB offset from the SB */
-#define io_page_size	0x1000000
-
-static unsigned long map_iopt_entry(unsigned long address)
-{
-	switch (address >> 20) {
-	case 0x600:
-		address = 0x24020000000ull; /* spider i/o */
-		break;
-	default:
-		address += iopt_phys_offset;
-		break;
-	}
-
-	return get_iopt_entry(address, ioid, IOPT_PROT_RW);
+static void enable_mapping(void __iomem *base, void __iomem *mmio_base)
+{
+	set_iocmd_config(base);
+	set_iost_origin(mmio_base);
 }
 
-static void iommu_bus_setup_null(struct pci_bus *b) { }
 static void iommu_dev_setup_null(struct pci_dev *d) { }
+static void iommu_bus_setup_null(struct pci_bus *b) { }
+
+struct cell_iommu {
+	unsigned long base;
+	unsigned long mmio_base;
+	void __iomem *mapped_base;
+	void __iomem *mapped_mmio_base;
+};
+
+static struct cell_iommu cell_iommus[NR_CPUS];
 
 /* initialize the iommu to support a simple linear mapping
  * for each DMA window used by any device. For now, we
  * happen to know that there is only one DMA window in use,
  * starting at iopt_phys_offset. */
-static void cell_map_iommu(void)
+static void cell_do_map_iommu(struct cell_iommu *iommu,
+			      unsigned int ioid,
+			      unsigned long map_start,
+			      unsigned long map_size)
 {
-	unsigned long address;
-	void __iomem *base;
+	unsigned long io_address, real_address;
+	void __iomem *ioc_base, *ioc_mmio_base;
 	ioste ioste;
 	unsigned long index;
 
-	base = __ioremap(ioc_base, 0x1000, _PAGE_NO_CACHE);
-	pr_debug("%lx mapped to %p\n", ioc_base, base);
-	set_iocmd_config(base);
-	iounmap(base);
+	/* we pretend the io page table was at a very high address */
+	const unsigned long fake_iopt = 0x10000000000ul;
+	const unsigned long io_page_size = 0x1000000; /* use 16M pages */
+	const unsigned long io_segment_size = 0x10000000; /* 256M */
+
+	ioc_base = iommu->mapped_base;
+	ioc_mmio_base = iommu->mapped_mmio_base;
+
+	for (real_address = 0, io_address = 0;
+	     io_address <= map_start + map_size;
+	     real_address += io_page_size, io_address += io_page_size) {
+		ioste = get_iost_entry(fake_iopt, io_address, io_page_size);
+		if ((real_address % io_segment_size) == 0) /* segment start */
+			set_iost_cache(ioc_mmio_base,
+				       io_address >> 28, ioste);
+		index = get_ioc_hash_1way(ioste, io_address);
+		pr_debug("addr %08lx, index %02lx, ioste %016lx\n",
+					 io_address, index, ioste.val);
+		set_iopt_cache(ioc_mmio_base,
+			get_ioc_hash_1way(ioste, io_address),
+			get_ioc_tag(ioste, io_address),
+			get_iopt_entry(real_address-map_start, ioid, IOPT_PROT_RW));
+	}
+}
 
-	base = __ioremap(ioc_mmio_base, 0x1000, _PAGE_NO_CACHE);
-	pr_debug("%lx mapped to %p\n", ioc_mmio_base, base);
+static void iommu_devnode_setup(struct device_node *d)
+{
+	unsigned int *ioid;
+	unsigned long *dma_window, map_start, map_size, token;
+	struct cell_iommu *iommu;
 
-	set_iost_origin(base);
+	ioid = (unsigned int *)get_property(d, "ioid", NULL);
+	if (!ioid)
+		pr_debug("No ioid entry found !\n");
 
-	for (address = 0; address < 0x100000000ul; address += io_page_size) {
-		ioste = get_iost_entry(0x10000000000ul, address, io_page_size);
-		if ((address & 0xfffffff) == 0) /* segment start */
-			set_iost_cache(base, address >> 28, ioste);
-		index = get_ioc_hash_1way(ioste, address);
-		pr_debug("addr %08lx, index %02lx, ioste %016lx\n",
-					 address, index, ioste.val);
-		set_iopt_cache(base,
-			get_ioc_hash_1way(ioste, address),
-			get_ioc_tag(ioste, address),
-			map_iopt_entry(address));
-	}
-	iounmap(base);
+	dma_window = (unsigned long *)get_property(d, "ibm,dma-window", NULL);
+	if (!dma_window)
+		pr_debug("No ibm,dma-window entry found !\n");
+
+	map_start = dma_window[1];
+	map_size = dma_window[2];
+	token = dma_window[0] >> 32;
+
+	iommu = &cell_iommus[token];
+
+	cell_do_map_iommu(iommu, *ioid, map_start, map_size);
+}
+
+static void iommu_bus_setup(struct pci_bus *b)
+{
+	struct device_node *d = (struct device_node *)b->sysdata;
+	iommu_devnode_setup(d);
+}
+
+
+static int cell_map_iommu_hardcoded(int num_nodes)
+{
+	struct cell_iommu *iommu = NULL;
+
+	pr_debug("%s(%d): Using hardcoded defaults\n", __FUNCTION__, __LINE__);
+
+	/* node 0 */
+	iommu = &cell_iommus[0];
+	iommu->mapped_base = __ioremap(0x20000511000, 0x1000, _PAGE_NO_CACHE);
+	iommu->mapped_mmio_base = __ioremap(0x20000510000, 0x1000, _PAGE_NO_CACHE);
+
+	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
+
+	cell_do_map_iommu(iommu, 0x048a,
+			  0x20000000ul,0x20000000ul);
+
+	if (num_nodes < 2)
+		return 0;
+
+	/* node 1 */
+	iommu = &cell_iommus[1];
+	iommu->mapped_base = __ioremap(0x30000511000, 0x1000, _PAGE_NO_CACHE);
+	iommu->mapped_mmio_base = __ioremap(0x30000510000, 0x1000, _PAGE_NO_CACHE);
+
+	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
+
+	cell_do_map_iommu(iommu, 0x048a,
+			  0x20000000,0x20000000ul);
+
+	return 0;
 }
 
 
+static int cell_map_iommu(void)
+{
+	unsigned int num_nodes = 0, *node_id;
+	unsigned long *base, *mmio_base;
+	struct device_node *dn;
+	struct cell_iommu *iommu = NULL;
+
+	/* determine number of nodes (=iommus) */
+	pr_debug("%s(%d): determining number of nodes...", __FUNCTION__, __LINE__);
+	for(dn = of_find_node_by_type(NULL, "cpu");
+	    dn;
+	    dn = of_find_node_by_type(dn, "cpu")) {
+		node_id = (unsigned int *)get_property(dn, "node-id", NULL);
+
+		if (num_nodes < *node_id)
+			num_nodes = *node_id;
+		}
+
+	num_nodes++;
+	pr_debug("%i found.\n", num_nodes);
+
+	/* map the iommu registers for each node */
+	pr_debug("%s(%d): Looping through nodes\n", __FUNCTION__, __LINE__);
+	for(dn = of_find_node_by_type(NULL, "cpu");
+	    dn;
+	    dn = of_find_node_by_type(dn, "cpu")) {
+
+		node_id = (unsigned int *)get_property(dn, "node-id", NULL);
+		base = (unsigned long *)get_property(dn, "ioc-cache", NULL);
+		mmio_base = (unsigned long *)get_property(dn, "ioc-translation", NULL);
+
+		if (!base || !mmio_base || !node_id)
+			return cell_map_iommu_hardcoded(num_nodes);
+
+		iommu = &cell_iommus[*node_id];
+		iommu->base = *base;
+		iommu->mmio_base = *mmio_base;
+
+		iommu->mapped_base = __ioremap(*base, 0x1000, _PAGE_NO_CACHE);
+		iommu->mapped_mmio_base = __ioremap(*mmio_base, 0x1000, _PAGE_NO_CACHE);
+
+		enable_mapping(iommu->mapped_base,
+			       iommu->mapped_mmio_base);
+
+		/* everything else will be done in iommu_bus_setup */
+	}
+
+	return 1;
+}
+
 static void *cell_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
@@ -365,11 +475,28 @@ static int cell_dma_supported(struct dev
 
 void cell_init_iommu(void)
 {
-	cell_map_iommu();
+	int setup_bus = 0;
 
-	/* Direct I/O, IOMMU off */
-	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
-	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+	if (of_find_node_by_path("/mambo")) {
+		pr_info("Not using iommu on systemsim\n");
+	} else {
+
+		if (!(of_chosen &&
+		      get_property(of_chosen, "linux,iommu-off", NULL)))
+			setup_bus = cell_map_iommu();
+
+		if (setup_bus) {
+			pr_debug("%s: IOMMU mapping activated\n", __FUNCTION__);
+			ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+			ppc_md.iommu_bus_setup = iommu_bus_setup;
+		} else {
+			pr_debug("%s: IOMMU mapping activated, "
+				 "no device action necessary\n", __FUNCTION__);
+			/* Direct I/O, IOMMU off */
+			ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+			ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+		}
+	}
 
 	pci_dma_ops.alloc_coherent = cell_alloc_coherent;
 	pci_dma_ops.free_coherent = cell_free_coherent;

--

