Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262710AbSI1EbO>; Sat, 28 Sep 2002 00:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbSI1E3z>; Sat, 28 Sep 2002 00:29:55 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:1732 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S262703AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] AGPGART 1/5: minor DRM interface cleanup
Message-Id: <E17v9Je-0001mX-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the GART/DRM interface (in a backwards-compatible
way) and gets rid of the bogus assumption that "GATT_entry & ~0xfff"
is a physical address.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.686   -> 1.687  
#	drivers/char/agp/agpgart_be.c	1.35    -> 1.36   
#	drivers/char/agp/agp.h	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/27	bjorn_helgaas@hp.com	1.687
# Make agp_memory.memory[] (exported from agpgart to DRM) contain physical
# addresses, not GATT entries.
# 
# DRM assumes agp_memory contains GATT entries, and it converts them to
# physical addresses with "paddr = agp_memory.memory[i] & mask".  460GX
# requires both a shift and a mask, so exporting plain physical addresses
# and a mask of ~0UL allows agpgart to add 460GX support without requiring
# DRM interface changes.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	Fri Sep 27 20:59:30 2002
+++ b/drivers/char/agp/agp.h	Fri Sep 27 20:59:30 2002
@@ -87,6 +87,7 @@
 	u32 *gatt_table;
 	u32 *gatt_table_real;
 	unsigned long scratch_page;
+	unsigned long scratch_page_real;
 	unsigned long gart_bus_addr;
 	unsigned long gatt_bus_addr;
 	u32 mode;
@@ -99,7 +100,6 @@
 	int needs_scratch_page;
 	int aperture_size_idx;
 	int num_aperture_sizes;
-	int num_of_masks;
 	int capndx;
 	int cant_use_aperture;
 
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Fri Sep 27 20:59:30 2002
+++ b/drivers/char/agp/agpgart_be.c	Fri Sep 27 20:59:30 2002
@@ -209,7 +209,6 @@
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			curr->memory[i] &= ~(0x00000fff);
 			agp_bridge.agp_destroy_page((unsigned long)
 					 phys_to_virt(curr->memory[i]));
 		}
@@ -262,10 +261,7 @@
 			agp_free_memory(new);
 			return NULL;
 		}
-		new->memory[i] =
-		    agp_bridge.mask_memory(
-				   virt_to_phys((void *) new->memory[i]),
-						  type);
+		new->memory[i] = virt_to_phys((void *) new->memory[i]);
 		new->page_count++;
 	}
 
@@ -311,9 +307,6 @@
 
 int agp_copy_info(agp_kern_info * info)
 {
-	unsigned long page_mask = 0;
-	int i;
-
 	memset(info, 0, sizeof(agp_kern_info));
 	if (agp_bridge.type == NOT_SUPPORTED) {
 		info->chipset = agp_bridge.type;
@@ -329,11 +322,7 @@
 	info->max_memory = agp_bridge.max_memory_agp;
 	info->current_memory = atomic_read(&agp_bridge.current_memory_agp);
 	info->cant_use_aperture = agp_bridge.cant_use_aperture;
-
-	for(i = 0; i < agp_bridge.num_of_masks; i++)
-		page_mask |= agp_bridge.mask_memory(page_mask, i);
-
-	info->page_mask = ~page_mask;
+	info->page_mask = ~0UL;
 	return 0;
 }
 
@@ -731,7 +720,8 @@
 		mem->is_flushed = TRUE;
 	}
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge.gatt_table[j] = mem->memory[i];
+		agp_bridge.gatt_table[j] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 
 	agp_bridge.tlb_flush(mem);
@@ -976,7 +966,8 @@
    	CACHE_FLUSH();
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		OUTREG32(intel_i810_private.registers,
-			 I810_PTE_BASE + (j * 4), mem->memory[i]);
+			 I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 	}
 	CACHE_FLUSH();
 
@@ -1042,10 +1033,7 @@
 			agp_free_memory(new);
 			return NULL;
 		}
-		new->memory[0] =
-		    agp_bridge.mask_memory(
-				   virt_to_phys((void *) new->memory[0]),
-						  type);
+		new->memory[0] = virt_to_phys((void *) new->memory[0]);
 		new->page_count = 1;
 	   	new->num_scratch_pages = 1;
 	   	new->type = AGP_PHYS_MEMORY;
@@ -1079,7 +1067,6 @@
 	intel_i810_private.i810_dev = i810_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 2;
 	agp_bridge.aperture_sizes = (void *) intel_i810_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1282,7 +1269,8 @@
 	CACHE_FLUSH();
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++)
-		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 4),mem->memory[i]);
+		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 
 	CACHE_FLUSH();
 
@@ -1343,7 +1331,7 @@
 			return(NULL);
 		}
 
-		nw->memory[0] = agp_bridge.mask_memory(virt_to_phys((void *) nw->memory[0]),type);
+		nw->memory[0] = virt_to_phys((void *) nw->memory[0]);
 		nw->page_count = 1;
 		nw->num_scratch_pages = 1;
 		nw->type = AGP_PHYS_MEMORY;
@@ -1359,7 +1347,6 @@
 	intel_i830_private.i830_dev = i830_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 3;
 	agp_bridge.aperture_sizes = (void *) intel_i830_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1841,7 +1828,6 @@
 static int __init intel_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
 	agp_bridge.size_type = U16_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1874,7 +1860,6 @@
 static int __init intel_815_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_815_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1907,7 +1892,6 @@
 static int __init intel_820_setup (struct pci_dev *pdev)
 {
        agp_bridge.masks = intel_generic_masks;
-       agp_bridge.num_of_masks = 1;
        agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
        agp_bridge.size_type = U8_APER_SIZE;
        agp_bridge.num_aperture_sizes = 7;
@@ -1940,7 +1924,6 @@
 static int __init intel_830mp_setup (struct pci_dev *pdev)
 {
        agp_bridge.masks = intel_generic_masks;
-       agp_bridge.num_of_masks = 1;
        agp_bridge.aperture_sizes = (void *) intel_830mp_sizes;
        agp_bridge.size_type = U8_APER_SIZE;
        agp_bridge.num_aperture_sizes = 4;
@@ -1972,7 +1955,6 @@
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2005,7 +1987,6 @@
 static int __init intel_845_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2038,7 +2019,6 @@
 static int __init intel_850_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2071,7 +2051,6 @@
 static int __init intel_860_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2191,7 +2170,6 @@
 static int __init via_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = via_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) via_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2305,7 +2283,6 @@
 static int __init sis_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = sis_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) sis_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2643,7 +2620,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -2689,7 +2667,6 @@
 static int __init amd_irongate_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = amd_irongate_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) amd_irongate_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2790,7 +2767,7 @@
 	}
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		addr = mem->memory[i];
+		addr = agp_bridge.mask_memory(mem->memory[i], mem->type);
 
 		tmp = addr;
 		BUG_ON(tmp & 0xffffff0000000ffc);
@@ -3155,7 +3132,6 @@
 static int __init amd_8151_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = amd_8151_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) amd_8151_sizes;
 	agp_bridge.size_type = U32_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -3393,7 +3369,6 @@
 static int __init ali_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = ali_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) ali_generic_sizes;
 	agp_bridge.size_type = U32_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -3807,7 +3782,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = SVRWRKS_GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -3964,7 +3940,6 @@
 	serverworks_private.svrwrks_dev = pdev;
 
 	agp_bridge.masks = serverworks_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) serverworks_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -4362,7 +4337,6 @@
 static int __init hp_zx1_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = hp_zx1_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.needs_scratch_page = FALSE;
@@ -5071,17 +5045,17 @@
 	}
 
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page = agp_bridge.agp_alloc_page();
+		unsigned long addr;
+		addr = agp_bridge.agp_alloc_page();
 
-		if (agp_bridge.scratch_page == 0) {
+		if (addr == 0) {
 			printk(KERN_ERR PFX "unable to get memory for "
 			       "scratch page.\n");
 			return -ENOMEM;
 		}
+		agp_bridge.scratch_page_real = virt_to_phys((void *) addr);
 		agp_bridge.scratch_page =
-		    virt_to_phys((void *) agp_bridge.scratch_page);
-		agp_bridge.scratch_page =
-		    agp_bridge.mask_memory(agp_bridge.scratch_page, 0);
+		    agp_bridge.mask_memory(agp_bridge.scratch_page_real, 0);
 	}
 
 	size_value = agp_bridge.fetch_size();
@@ -5123,9 +5097,8 @@
 
 err_out:
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page &= ~(0x00000fff);
 		agp_bridge.agp_destroy_page((unsigned long)
-				 phys_to_virt(agp_bridge.scratch_page));
+				 phys_to_virt(agp_bridge.scratch_page_real));
 	}
 	if (got_gatt)
 		agp_bridge.free_gatt_table();
@@ -5143,9 +5116,8 @@
 	vfree(agp_bridge.key_list);
 
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page &= ~(0x00000fff);
 		agp_bridge.agp_destroy_page((unsigned long)
-				 phys_to_virt(agp_bridge.scratch_page));
+				 phys_to_virt(agp_bridge.scratch_page_real));
 	}
 }
 
