Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCPLsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCPLsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVCPLsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:48:54 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:56007 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261162AbVCPLsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:48:33 -0500
To: linux-kernel@vger.kernel.org, akpm@osdl.org
cc: riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <8514.1110973709.0@cl.cam.ac.uk>
Date: Wed, 16 Mar 2005 11:48:29 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8514.1110973709.1@cl.cam.ac.uk>

This patch cleans up AGP driver treatment of bus/device memory. Every
use of virt_to_phys/phys_to_virt should properly be converting between
virtual and bus addresses: this distinction really matters for the Xen
hypervisor.

Furthermore, when allocating the GATT, it is necessary to use
dma_alloc_coherent rather than get_free_pages.  Again, not a
distinction that matters for i386, but very important for Xen and
possibly for other architectures too.

Signed-off-by: Keir Fraser <keir@xensource.com>


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="agpgart.patch"; charset="us-ascii"
Content-ID: <8514.1110973709.2@cl.cam.ac.uk>
Content-Description: AGP patch

--- linux-2.6-old/drivers/char/agp/ali-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/ali-agp.c	2005-03-16 10:16:30 +00:00
@@ -150,7 +150,7 @@
 	pci_read_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL, &temp);
 	pci_write_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL,
 			(((temp & ALI_CACHE_FLUSH_ADDR_MASK) |
-			  virt_to_phys(addr)) | ALI_CACHE_FLUSH_EN ));
+			  virt_to_bus(addr)) | ALI_CACHE_FLUSH_EN ));
 	return addr;
 }
 
@@ -174,7 +174,7 @@
 	pci_read_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL, &temp);
 	pci_write_config_dword(agp_bridge->dev, ALI_CACHE_FLUSH_CTRL,
 			(((temp & ALI_CACHE_FLUSH_ADDR_MASK) |
-			  virt_to_phys(addr)) | ALI_CACHE_FLUSH_EN));
+			  virt_to_bus(addr)) | ALI_CACHE_FLUSH_EN));
 	agp_generic_destroy_page(addr);
 }
 
--- linux-2.6-old/drivers/char/agp/amd-k7-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/amd-k7-agp.c	2005-03-16 10:17:18 +00:00
@@ -43,7 +43,7 @@
 
 	SetPageReserved(virt_to_page(page_map->real));
 	global_cache_flush();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
+	page_map->remapped = ioremap_nocache(virt_to_bus(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
 		ClearPageReserved(virt_to_page(page_map->real));
@@ -154,7 +154,7 @@
 
 	agp_bridge->gatt_table_real = (u32 *)page_dir.real;
 	agp_bridge->gatt_table = (u32 __iomem *)page_dir.remapped;
-	agp_bridge->gatt_bus_addr = virt_to_phys(page_dir.real);
+	agp_bridge->gatt_bus_addr = virt_to_bus(page_dir.real);
 
 	/* Get the address for the gart region.
 	 * This is a bus address even on the alpha, b/c its
@@ -167,7 +167,7 @@
 
 	/* Calculate the agp offset */
 	for (i = 0; i < value->num_entries / 1024; i++, addr += 0x00400000) {
-		writel(virt_to_phys(amd_irongate_private.gatt_pages[i]->real) | 1,
+		writel(virt_to_bus(amd_irongate_private.gatt_pages[i]->real) | 1,
 			page_dir.remapped+GET_PAGE_DIR_OFF(addr));
 		readl(page_dir.remapped+GET_PAGE_DIR_OFF(addr));	/* PCI Posting. */
 	}
--- linux-2.6-old/drivers/char/agp/amd64-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/amd64-agp.c	2005-03-16 10:18:00 +00:00
@@ -219,7 +219,7 @@
 
 static int amd_8151_configure(void)
 {
-	unsigned long gatt_bus = virt_to_phys(agp_bridge->gatt_table_real);
+	unsigned long gatt_bus = virt_to_bus(agp_bridge->gatt_table_real);
 
 	/* Configure AGP regs in each x86-64 host bridge. */
 	for_each_nb() {
@@ -591,7 +591,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	release_mem_region(virt_to_phys(bridge->gatt_table_real),
+	release_mem_region(virt_to_bus(bridge->gatt_table_real),
 			   amd64_aperture_sizes[bridge->aperture_size_idx].size);
 	agp_remove_bridge(bridge);
 	agp_put_bridge(bridge);
--- linux-2.6-old/drivers/char/agp/ati-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/ati-agp.c	2005-03-16 10:18:31 +00:00
@@ -61,7 +61,7 @@
 
 	SetPageReserved(virt_to_page(page_map->real));
 	err = map_page_into_agp(virt_to_page(page_map->real));
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
+	page_map->remapped = ioremap_nocache(virt_to_bus(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL || err) {
 		ClearPageReserved(virt_to_page(page_map->real));
--- linux-2.6-old/drivers/char/agp/backend.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/backend.c	2005-03-16 10:23:50 +00:00
@@ -147,7 +147,7 @@
 			return -ENOMEM;
 		}
 
-		bridge->scratch_page_real = virt_to_phys(addr);
+		bridge->scratch_page_real = virt_to_bus(addr);
 		bridge->scratch_page =
 		    bridge->driver->mask_memory(bridge, bridge->scratch_page_real, 0);
 	}
@@ -188,7 +188,7 @@
 err_out:
 	if (bridge->driver->needs_scratch_page)
 		bridge->driver->agp_destroy_page(
-				phys_to_virt(bridge->scratch_page_real));
+				bus_to_virt(bridge->scratch_page_real));
 	if (got_gatt)
 		bridge->driver->free_gatt_table(bridge);
 	if (got_keylist) {
@@ -213,7 +213,7 @@
 	if (bridge->driver->agp_destroy_page &&
 	    bridge->driver->needs_scratch_page)
 		bridge->driver->agp_destroy_page(
-				phys_to_virt(bridge->scratch_page_real));
+				bus_to_virt(bridge->scratch_page_real));
 }
 
 /* When we remove the global variable agp_bridge from all drivers
--- linux-2.6-old/drivers/char/agp/efficeon-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/efficeon-agp.c	2005-03-16 10:19:15 +00:00
@@ -219,7 +219,7 @@
 
 		efficeon_private.l1_table[index] = page;
 
-		value = __pa(page) | pati | present | index;
+		value = virt_to_bus(page) | pati | present | index;
 
 		pci_write_config_dword(agp_bridge->dev,
 			EFFICEON_ATTPAGE, value);
--- linux-2.6-old/drivers/char/agp/generic.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/generic.c	2005-03-16 10:27:34 +00:00
@@ -152,7 +152,7 @@
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			curr->bridge->driver->agp_destroy_page(phys_to_virt(curr->memory[i]));
+			curr->bridge->driver->agp_destroy_page(bus_to_virt(curr->memory[i]));
 		}
 	}
 	agp_free_key(curr->key);
@@ -208,7 +208,7 @@
 			agp_free_memory(new);
 			return NULL;
 		}
-		new->memory[i] = virt_to_phys(addr);
+		new->memory[i] = virt_to_bus(addr);
 		new->page_count++;
 	}
        new->bridge = bridge;
@@ -767,6 +767,7 @@
 	int i;
 	void *temp;
 	struct page *page;
+	dma_addr_t dma;
 
 	/* The generic routines can't handle 2 level gatt's */
 	if (bridge->driver->size_type == LVL2_APER_SIZE)
@@ -805,8 +806,10 @@
 				break;
 			}
 
-			table = (char *) __get_free_pages(GFP_KERNEL,
-							  page_order);
+			table = dma_alloc_coherent(
+					&agp_bridge->dev->dev,
+					PAGE_SIZE << page_order, &dma,
+					GFP_KERNEL);
 
 			if (table == NULL) {
 				i++;
@@ -837,7 +840,9 @@
 		size = ((struct aper_size_info_fixed *) temp)->size;
 		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
 		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
-		table = (char *) __get_free_pages(GFP_KERNEL, page_order);
+		table = dma_alloc_coherent(
+				&agp_bridge->dev->dev,
+				PAGE_SIZE << page_order, &dma, GFP_KERNEL);
 	}
 
 	if (table == NULL)
@@ -852,7 +857,7 @@
 	agp_gatt_table = (void *)table;
 
 	bridge->driver->cache_flush();
-	bridge->gatt_table = ioremap_nocache(virt_to_phys(table),
+	bridge->gatt_table = ioremap_nocache(virt_to_bus(table),
 					(PAGE_SIZE * (1 << page_order)));
 	bridge->driver->cache_flush();
 
@@ -860,11 +865,12 @@
 		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 			ClearPageReserved(page);
 
-		free_pages((unsigned long) table, page_order);
+		dma_free_coherent(&agp_bridge->dev->dev, PAGE_SIZE<<page_order,
+					table, dma);
 
 		return -ENOMEM;
 	}
-	bridge->gatt_bus_addr = virt_to_phys(bridge->gatt_table_real);
+	bridge->gatt_bus_addr = virt_to_bus(bridge->gatt_table_real);
 
 	/* AK: bogus, should encode addresses > 4GB */
 	for (i = 0; i < num_entries; i++) {
@@ -918,7 +924,8 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		ClearPageReserved(page);
 
-	free_pages((unsigned long) bridge->gatt_table_real, page_order);
+	dma_free_coherent(&agp_bridge->dev->dev, PAGE_SIZE<<page_order,
+		agp_bridge->gatt_table_real, agp_bridge->gatt_bus_addr);
 
 	agp_gatt_table = NULL;
 	bridge->gatt_table = NULL;
--- linux-2.6-old/drivers/char/agp/hp-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/hp-agp.c	2005-03-16 10:20:16 +00:00
@@ -110,7 +110,7 @@
 	hp->gart_size = HP_ZX1_GART_SIZE;
 	hp->gatt_entries = hp->gart_size / hp->io_page_size;
 
-	hp->io_pdir = phys_to_virt(readq(hp->ioc_regs+HP_ZX1_PDIR_BASE));
+	hp->io_pdir = bus_to_virt(readq(hp->ioc_regs+HP_ZX1_PDIR_BASE));
 	hp->gatt = &hp->io_pdir[HP_ZX1_IOVA_TO_PDIR(hp->gart_base)];
 
 	if (hp->gatt[0] != HP_ZX1_SBA_IOMMU_COOKIE) {
@@ -248,7 +248,7 @@
 	agp_bridge->mode = readl(hp->lba_regs+hp->lba_cap_offset+PCI_AGP_STATUS);
 
 	if (hp->io_pdir_owner) {
-		writel(virt_to_phys(hp->io_pdir), hp->ioc_regs+HP_ZX1_PDIR_BASE);
+		writel(virt_to_bus(hp->io_pdir), hp->ioc_regs+HP_ZX1_PDIR_BASE);
 		readl(hp->ioc_regs+HP_ZX1_PDIR_BASE);
 		writel(hp->io_tlb_ps, hp->ioc_regs+HP_ZX1_TCNFG);
 		readl(hp->ioc_regs+HP_ZX1_TCNFG);
--- linux-2.6-old/drivers/char/agp/i460-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/i460-agp.c	2005-03-16 10:21:29 +00:00
@@ -372,7 +372,7 @@
 	}
 	memset(lp->alloced_map, 0, map_size);
 
-	lp->paddr = virt_to_phys(lpage);
+	lp->paddr = virt_to_bus(lpage);
 	lp->refcount = 0;
 	atomic_add(I460_KPAGES_PER_IOPAGE, &agp_bridge->current_memory_agp);
 	return 0;
@@ -383,7 +383,7 @@
 	kfree(lp->alloced_map);
 	lp->alloced_map = NULL;
 
-	free_pages((unsigned long) phys_to_virt(lp->paddr), I460_IO_PAGE_SHIFT - PAGE_SHIFT);
+	free_pages((unsigned long) bus_to_virt(lp->paddr), I460_IO_PAGE_SHIFT - PAGE_SHIFT);
 	atomic_sub(I460_KPAGES_PER_IOPAGE, &agp_bridge->current_memory_agp);
 }
 
--- linux-2.6-old/drivers/char/agp/intel-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/intel-agp.c	2005-03-16 10:22:08 +00:00
@@ -286,7 +286,7 @@
 	if (new == NULL)
 		return NULL;
 
-	new->memory[0] = virt_to_phys(addr);
+	new->memory[0] = virt_to_bus(addr);
 	if (pg_count == 4) {
 		/* kludge to get 4 physical pages for ARGB cursor */
 		new->memory[1] = new->memory[0] + PAGE_SIZE;
@@ -329,10 +329,10 @@
 	agp_free_key(curr->key);
 	if(curr->type == AGP_PHYS_MEMORY) {
 		if (curr->page_count == 4)
-			i8xx_destroy_pages(phys_to_virt(curr->memory[0]));
+			i8xx_destroy_pages(bus_to_virt(curr->memory[0]));
 		else
 			agp_bridge->driver->agp_destroy_page(
-				 phys_to_virt(curr->memory[0]));
+				 bus_to_virt(curr->memory[0]));
 		vfree(curr->memory);
 	}
 	kfree(curr);
--- linux-2.6-old/drivers/char/agp/sworks-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/sworks-agp.c	2005-03-16 10:22:49 +00:00
@@ -51,7 +51,7 @@
 	}
 	SetPageReserved(virt_to_page(page_map->real));
 	global_cache_flush();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
+	page_map->remapped = ioremap_nocache(virt_to_bus(page_map->real), 
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
 		ClearPageReserved(virt_to_page(page_map->real));
@@ -162,7 +162,7 @@
 	/* Create a fake scratch directory */
 	for(i = 0; i < 1024; i++) {
 		writel(agp_bridge->scratch_page, serverworks_private.scratch_dir.remapped+i);
-		writel(virt_to_phys(serverworks_private.scratch_dir.real) | 1, page_dir.remapped+i);
+		writel(virt_to_bus(serverworks_private.scratch_dir.real) | 1, page_dir.remapped+i);
 	}
 
 	retval = serverworks_create_gatt_pages(value->num_entries / 1024);
@@ -174,7 +174,7 @@
 
 	agp_bridge->gatt_table_real = (u32 *)page_dir.real;
 	agp_bridge->gatt_table = (u32 __iomem *)page_dir.remapped;
-	agp_bridge->gatt_bus_addr = virt_to_phys(page_dir.real);
+	agp_bridge->gatt_bus_addr = virt_to_bus(page_dir.real);
 
 	/* Get the address for the gart region.
 	 * This is a bus address even on the alpha, b/c its
@@ -187,7 +187,7 @@
 	/* Calculate the agp offset */	
 
 	for(i = 0; i < value->num_entries / 1024; i++)
-		writel(virt_to_phys(serverworks_private.gatt_pages[i]->real)|1, page_dir.remapped+i);
+		writel(virt_to_bus(serverworks_private.gatt_pages[i]->real)|1, page_dir.remapped+i);
 
 	return 0;
 }
--- linux-2.6-old/drivers/char/agp/uninorth-agp.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/uninorth-agp.c	2005-03-16 10:23:03 +00:00
@@ -378,7 +378,7 @@
 
 	bridge->gatt_table_real = (u32 *) table;
 	bridge->gatt_table = (u32 *)table;
-	bridge->gatt_bus_addr = virt_to_phys(table);
+	bridge->gatt_bus_addr = virt_to_bus(table);
 
 	for (i = 0; i < num_entries; i++)
 		bridge->gatt_table[i] = 0;

------- =_aaaaaaaaaa0--
