Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVCUOAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVCUOAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVCUOAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:00:41 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:40616 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261796AbVCUN4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:56:30 -0500
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org, paulus@samba.org,
       jbarnes@engr.sgi.com, riel@redhat.com, kurt@garloff.de,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH] AGP fix for Xen VMM
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <17103.1111413378.0@cl.cam.ac.uk>
Date: Mon, 21 Mar 2005 13:56:23 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DDNOM-0003fn-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17103.1111413378.1@cl.cam.ac.uk>

(A second patch attempt, after my screw-up last week.)

When Linux is running on the Xen virtual machine monitor, physical
addresses are virtualised and cannot be directly referenced by the
AGP GART. This patch fixes the GART driver for Xen by adding a layer
of abstraction between physical addresses and 'GART addresses'.

Architecture-specific functions are also defined for allocating and
freeing the GATT. Xen requires this to ensure that table really is
contiguous from the point of view of the GART.

These extra interface functions are defined as 'no-ops' for all
existing architectures that use the GART driver.

Signed-off-by: Keir Fraser <keir@xensource.com>


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="agpgart.patch"; charset="us-ascii"
Content-ID: <17103.1111413378.2@cl.cam.ac.uk>
Content-Description: AGP patch

--- linux-2.6-old/drivers/char/agp/agp.h	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/agp.h	2005-03-21 13:24:24 +00:00
@@ -278,6 +278,8 @@
 #define AGP_GENERIC_SIZES_ENTRIES 11
 extern struct aper_size_info_16 agp3_generic_sizes[];
 
+#define virt_to_gart(x) (phys_to_gart(virt_to_phys(x)))
+#define gart_to_virt(x) (phys_to_virt(gart_to_phys(x)))
 
 extern int agp_off;
 extern int agp_try_unsupported_boot;
--- linux-2.6-old/drivers/char/agp/ali-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/ali-agp.c	2005-03-21 13:25:17 +00:00
@@ -150,7 +150,7 @@
 	pci_read_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL, &temp);
 	pci_write_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL,
 			(((temp & ALI_CACHE_FLUSH_ADDR_MASK) |
-			  virt_to_phys(addr)) | ALI_CACHE_FLUSH_EN ));
+			  virt_to_gart(addr)) | ALI_CACHE_FLUSH_EN ));
 	return addr;
 }
 
@@ -174,7 +174,7 @@
 	pci_read_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL, &temp);
 	pci_write_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL,
 			(((temp & ALI_CACHE_FLUSH_ADDR_MASK) |
-			  virt_to_phys(addr)) | ALI_CACHE_FLUSH_EN));
+			  virt_to_gart(addr)) | ALI_CACHE_FLUSH_EN));
 	agp_generic_destroy_page(addr);
 }
 
--- linux-2.6-old/drivers/char/agp/amd-k7-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/amd-k7-agp.c	2005-03-21 13:25:54 +00:00
@@ -43,7 +43,7 @@
 
 	SetPageReserved(virt_to_page(page_map->real));
 	global_cache_flush();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
+	page_map->remapped = ioremap_nocache(virt_to_gart(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
 		ClearPageReserved(virt_to_page(page_map->real));
@@ -154,7 +154,7 @@
 
 	agp_bridge->gatt_table_real = (u32 *)page_dir.real;
 	agp_bridge->gatt_table = (u32 __iomem *)page_dir.remapped;
-	agp_bridge->gatt_bus_addr = virt_to_phys(page_dir.real);
+	agp_bridge->gatt_bus_addr = virt_to_gart(page_dir.real);
 
 	/* Get the address for the gart region.
 	 * This is a bus address even on the alpha, b/c its
@@ -167,7 +167,7 @@
 
 	/* Calculate the agp offset */
 	for (i = 0; i < value->num_entries / 1024; i++, addr += 0x00400000) {
-		writel(virt_to_phys(amd_irongate_private.gatt_pages[i]->real) | 1,
+		writel(virt_to_gart(amd_irongate_private.gatt_pages[i]->real) | 1,
 			page_dir.remapped+GET_PAGE_DIR_OFF(addr));
 		readl(page_dir.remapped+GET_PAGE_DIR_OFF(addr));	/* PCI Posting. */
 	}
--- linux-2.6-old/drivers/char/agp/amd64-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/amd64-agp.c	2005-03-21 13:26:21 +00:00
@@ -219,7 +219,7 @@
 
 static int amd_8151_configure(void)
 {
-	unsigned long gatt_bus = virt_to_phys(agp_bridge->gatt_table_real);
+	unsigned long gatt_bus = virt_to_gart(agp_bridge->gatt_table_real);
 
 	/* Configure AGP regs in each x86-64 host bridge. */
 	for_each_nb() {
@@ -591,7 +591,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	release_mem_region(virt_to_phys(bridge->gatt_table_real),
+	release_mem_region(virt_to_gart(bridge->gatt_table_real),
 			   amd64_aperture_sizes[bridge->aperture_size_idx].size);
 	agp_remove_bridge(bridge);
 	agp_put_bridge(bridge);
--- linux-2.6-old/drivers/char/agp/ati-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/ati-agp.c	2005-03-21 13:27:42 +00:00
@@ -61,7 +61,7 @@
 
 	SetPageReserved(virt_to_page(page_map->real));
 	err = map_page_into_agp(virt_to_page(page_map->real));
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
+	page_map->remapped = ioremap_nocache(virt_to_gart(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL || err) {
 		ClearPageReserved(virt_to_page(page_map->real));
@@ -343,7 +343,7 @@
 
 	agp_bridge->gatt_table_real = (u32 *)page_dir.real;
 	agp_bridge->gatt_table = (u32 __iomem *) page_dir.remapped;
-	agp_bridge->gatt_bus_addr = virt_to_bus(page_dir.real);
+	agp_bridge->gatt_bus_addr = virt_to_gart(page_dir.real);
 
 	/* Write out the size register */
 	current_size = A_SIZE_LVL2(agp_bridge->current_size);
@@ -373,7 +373,7 @@
 
 	/* Calculate the agp offset */
 	for(i = 0; i < value->num_entries / 1024; i++, addr += 0x00400000) {
-		writel(virt_to_bus(ati_generic_private.gatt_pages[i]->real) | 1,
+		writel(virt_to_gart(ati_generic_private.gatt_pages[i]->real) | 1,
 			page_dir.remapped+GET_PAGE_DIR_OFF(addr));
 		readl(page_dir.remapped+GET_PAGE_DIR_OFF(addr));	/* PCI Posting. */
 	}
--- linux-2.6-old/drivers/char/agp/backend.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/backend.c	2005-03-21 13:28:17 +00:00
@@ -147,7 +147,7 @@
 			return -ENOMEM;
 		}
 
-		bridge->scratch_page_real = virt_to_phys(addr);
+		bridge->scratch_page_real = virt_to_gart(addr);
 		bridge->scratch_page =
 		    bridge->driver->mask_memory(bridge, bridge->scratch_page_real, 0);
 	}
@@ -188,7 +188,7 @@
 err_out:
 	if (bridge->driver->needs_scratch_page)
 		bridge->driver->agp_destroy_page(
-				phys_to_virt(bridge->scratch_page_real));
+				gart_to_virt(bridge->scratch_page_real));
 	if (got_gatt)
 		bridge->driver->free_gatt_table(bridge);
 	if (got_keylist) {
@@ -213,7 +213,7 @@
 	if (bridge->driver->agp_destroy_page &&
 	    bridge->driver->needs_scratch_page)
 		bridge->driver->agp_destroy_page(
-				phys_to_virt(bridge->scratch_page_real));
+				gart_to_virt(bridge->scratch_page_real));
 }
 
 /* When we remove the global variable agp_bridge from all drivers
--- linux-2.6-old/drivers/char/agp/efficeon-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/efficeon-agp.c	2005-03-21 13:29:15 +00:00
@@ -219,7 +219,7 @@
 
 		efficeon_private.l1_table[index] = page;
 
-		value = __pa(page) | pati | present | index;
+		value = virt_to_gart(page) | pati | present | index;
 
 		pci_write_config_dword(agp_bridge->dev,
 			EFFICEON_ATTPAGE, value);
--- linux-2.6-old/drivers/char/agp/generic.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/generic.c	2005-03-21 13:31:35 +00:00
@@ -152,7 +152,7 @@
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			curr->bridge->driver->agp_destroy_page(phys_to_virt(curr->memory[i]));
+			curr->bridge->driver->agp_destroy_page(gart_to_virt(curr->memory[i]));
 		}
 	}
 	agp_free_key(curr->key);
@@ -208,7 +208,7 @@
 			agp_free_memory(new);
 			return NULL;
 		}
-		new->memory[i] = virt_to_phys(addr);
+		new->memory[i] = virt_to_gart(addr);
 		new->page_count++;
 	}
        new->bridge = bridge;
@@ -805,8 +805,7 @@
 				break;
 			}
 
-			table = (char *) __get_free_pages(GFP_KERNEL,
-							  page_order);
+			table = alloc_gatt_pages(page_order);
 
 			if (table == NULL) {
 				i++;
@@ -837,7 +836,7 @@
 		size = ((struct aper_size_info_fixed *) temp)->size;
 		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
 		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
-		table = (char *) __get_free_pages(GFP_KERNEL, page_order);
+		table = alloc_gatt_pages(page_order);
 	}
 
 	if (table == NULL)
@@ -852,7 +851,7 @@
 	agp_gatt_table = (void *)table;
 
 	bridge->driver->cache_flush();
-	bridge->gatt_table = ioremap_nocache(virt_to_phys(table),
+	bridge->gatt_table = ioremap_nocache(virt_to_gart(table),
 					(PAGE_SIZE * (1 << page_order)));
 	bridge->driver->cache_flush();
 
@@ -860,11 +859,11 @@
 		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 			ClearPageReserved(page);
 
-		free_pages((unsigned long) table, page_order);
+		free_gatt_pages(table, page_order);
 
 		return -ENOMEM;
 	}
-	bridge->gatt_bus_addr = virt_to_phys(bridge->gatt_table_real);
+	bridge->gatt_bus_addr = virt_to_gart(bridge->gatt_table_real);
 
 	/* AK: bogus, should encode addresses > 4GB */
 	for (i = 0; i < num_entries; i++) {
@@ -918,7 +917,7 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		ClearPageReserved(page);
 
-	free_pages((unsigned long) bridge->gatt_table_real, page_order);
+	free_gatt_pages(bridge->gatt_table_real, page_order);
 
 	agp_gatt_table = NULL;
 	bridge->gatt_table = NULL;
--- linux-2.6-old/drivers/char/agp/hp-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/hp-agp.c	2005-03-21 13:32:16 +00:00
@@ -110,7 +110,7 @@
 	hp->gart_size = HP_ZX1_GART_SIZE;
 	hp->gatt_entries = hp->gart_size / hp->io_page_size;
 
-	hp->io_pdir = phys_to_virt(readq(hp->ioc_regs+HP_ZX1_PDIR_BASE));
+	hp->io_pdir = gart_to_virt(readq(hp->ioc_regs+HP_ZX1_PDIR_BASE));
 	hp->gatt = &hp->io_pdir[HP_ZX1_IOVA_TO_PDIR(hp->gart_base)];
 
 	if (hp->gatt[0] != HP_ZX1_SBA_IOMMU_COOKIE) {
@@ -248,7 +248,7 @@
 	agp_bridge->mode = readl(hp->lba_regs+hp->lba_cap_offset+PCI_AGP_STATUS);
 
 	if (hp->io_pdir_owner) {
-		writel(virt_to_phys(hp->io_pdir), hp->ioc_regs+HP_ZX1_PDIR_BASE);
+		writel(virt_to_gart(hp->io_pdir), hp->ioc_regs+HP_ZX1_PDIR_BASE);
 		readl(hp->ioc_regs+HP_ZX1_PDIR_BASE);
 		writel(hp->io_tlb_ps, hp->ioc_regs+HP_ZX1_TCNFG);
 		readl(hp->ioc_regs+HP_ZX1_TCNFG);
--- linux-2.6-old/drivers/char/agp/i460-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/i460-agp.c	2005-03-21 13:32:34 +00:00
@@ -372,7 +372,7 @@
 	}
 	memset(lp->alloced_map, 0, map_size);
 
-	lp->paddr = virt_to_phys(lpage);
+	lp->paddr = virt_to_gart(lpage);
 	lp->refcount = 0;
 	atomic_add(I460_KPAGES_PER_IOPAGE, &agp_bridge->current_memory_agp);
 	return 0;
@@ -383,7 +383,7 @@
 	kfree(lp->alloced_map);
 	lp->alloced_map = NULL;
 
-	free_pages((unsigned long) phys_to_virt(lp->paddr), I460_IO_PAGE_SHIFT - PAGE_SHIFT);
+	free_pages((unsigned long) gart_to_virt(lp->paddr), I460_IO_PAGE_SHIFT - PAGE_SHIFT);
 	atomic_sub(I460_KPAGES_PER_IOPAGE, &agp_bridge->current_memory_agp);
 }
 
--- linux-2.6-old/drivers/char/agp/intel-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/intel-agp.c	2005-03-21 13:32:57 +00:00
@@ -286,7 +286,7 @@
 	if (new == NULL)
 		return NULL;
 
-	new->memory[0] = virt_to_phys(addr);
+	new->memory[0] = virt_to_gart(addr);
 	if (pg_count == 4) {
 		/* kludge to get 4 physical pages for ARGB cursor */
 		new->memory[1] = new->memory[0] + PAGE_SIZE;
@@ -329,10 +329,10 @@
 	agp_free_key(curr->key);
 	if(curr->type == AGP_PHYS_MEMORY) {
 		if (curr->page_count == 4)
-			i8xx_destroy_pages(phys_to_virt(curr->memory[0]));
+			i8xx_destroy_pages(gart_to_virt(curr->memory[0]));
 		else
 			agp_bridge->driver->agp_destroy_page(
-				 phys_to_virt(curr->memory[0]));
+				 gart_to_virt(curr->memory[0]));
 		vfree(curr->memory);
 	}
 	kfree(curr);
--- linux-2.6-old/drivers/char/agp/sworks-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/sworks-agp.c	2005-03-21 13:33:21 +00:00
@@ -51,7 +51,7 @@
 	}
 	SetPageReserved(virt_to_page(page_map->real));
 	global_cache_flush();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
+	page_map->remapped = ioremap_nocache(virt_to_gart(page_map->real), 
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
 		ClearPageReserved(virt_to_page(page_map->real));
@@ -162,7 +162,7 @@
 	/* Create a fake scratch directory */
 	for(i = 0; i < 1024; i++) {
 		writel(agp_bridge->scratch_page, serverworks_private.scratch_dir.remapped+i);
-		writel(virt_to_phys(serverworks_private.scratch_dir.real) | 1, page_dir.remapped+i);
+		writel(virt_to_gart(serverworks_private.scratch_dir.real) | 1, page_dir.remapped+i);
 	}
 
 	retval = serverworks_create_gatt_pages(value->num_entries / 1024);
@@ -174,7 +174,7 @@
 
 	agp_bridge->gatt_table_real = (u32 *)page_dir.real;
 	agp_bridge->gatt_table = (u32 __iomem *)page_dir.remapped;
-	agp_bridge->gatt_bus_addr = virt_to_phys(page_dir.real);
+	agp_bridge->gatt_bus_addr = virt_to_gart(page_dir.real);
 
 	/* Get the address for the gart region.
 	 * This is a bus address even on the alpha, b/c its
@@ -187,7 +187,7 @@
 	/* Calculate the agp offset */	
 
 	for(i = 0; i < value->num_entries / 1024; i++)
-		writel(virt_to_phys(serverworks_private.gatt_pages[i]->real)|1, page_dir.remapped+i);
+		writel(virt_to_gart(serverworks_private.gatt_pages[i]->real)|1, page_dir.remapped+i);
 
 	return 0;
 }
--- linux-2.6-old/drivers/char/agp/uninorth-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/uninorth-agp.c	2005-03-21 13:33:31 +00:00
@@ -378,7 +378,7 @@
 
 	bridge->gatt_table_real = (u32 *) table;
 	bridge->gatt_table = (u32 *)table;
-	bridge->gatt_bus_addr = virt_to_phys(table);
+	bridge->gatt_bus_addr = virt_to_gart(table);
 
 	for (i = 0; i < num_entries; i++)
 		bridge->gatt_table[i] = 0;
--- linux-2.6-old/include/asm-alpha/agp.h	2005-03-16 10:30:54 +00:00
+++ linux-2.6-new/include/asm-alpha/agp.h	2005-03-21 13:22:01 +00:00
@@ -10,4 +10,14 @@
 #define flush_agp_mappings() 
 #define flush_agp_cache() mb()
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif
--- linux-2.6-old/include/asm-i386/agp.h	2005-03-16 10:30:56 +00:00
+++ linux-2.6-new/include/asm-i386/agp.h	2005-03-21 13:22:22 +00:00
@@ -21,4 +21,14 @@
    worth it. Would need a page for it. */
 #define flush_agp_cache() asm volatile("wbinvd":::"memory")
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif
--- linux-2.6-old/include/asm-ia64/agp.h	2005-03-16 10:30:58 +00:00
+++ linux-2.6-new/include/asm-ia64/agp.h	2005-03-21 13:22:28 +00:00
@@ -18,4 +18,14 @@
 #define flush_agp_mappings()		/* nothing */
 #define flush_agp_cache()		mb()
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif /* _ASM_IA64_AGP_H */
--- linux-2.6-old/include/asm-ppc/agp.h	2005-03-16 10:31:01 +00:00
+++ linux-2.6-new/include/asm-ppc/agp.h	2005-03-21 13:22:37 +00:00
@@ -10,4 +10,14 @@
 #define flush_agp_mappings()
 #define flush_agp_cache() mb()
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif
--- linux-2.6-old/include/asm-ppc64/agp.h	2005-03-16 10:31:01 +00:00
+++ linux-2.6-new/include/asm-ppc64/agp.h	2005-03-21 13:22:13 +00:00
@@ -10,4 +10,14 @@
 #define flush_agp_mappings()
 #define flush_agp_cache() mb()
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif
--- linux-2.6-old/include/asm-sparc64/agp.h	2005-03-16 10:31:04 +00:00
+++ linux-2.6-new/include/asm-sparc64/agp.h	2005-03-21 13:22:44 +00:00
@@ -8,4 +8,14 @@
 #define flush_agp_mappings() 
 #define flush_agp_cache() mb()
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif
--- linux-2.6-old/include/asm-x86_64/agp.h	2005-03-16 10:31:05 +00:00
+++ linux-2.6-new/include/asm-x86_64/agp.h	2005-03-21 13:21:37 +00:00
@@ -19,4 +19,14 @@
    worth it. Would need a page for it. */
 #define flush_agp_cache() asm volatile("wbinvd":::"memory")
 
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 #endif

------- =_aaaaaaaaaa0--
