Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319785AbSIMUvI>; Fri, 13 Sep 2002 16:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319786AbSIMUvI>; Fri, 13 Sep 2002 16:51:08 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:54710 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S319785AbSIMUuv>;
	Fri, 13 Sep 2002 16:50:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: marcelo@conectiva.com.br
Subject: [PATCH] agpgart cleanup
Date: Fri, 13 Sep 2002 14:54:10 -0600
User-Agent: KMail/1.4.1
Cc: "dri-devel" <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209131454.10218.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to see the attached patch in 2.4.x.  It cleans up the
agpgart/DRM interface a bit and makes it easier to support
the 460GX GART.  We've been running similar code in the ia64
patch for several months, and I've also tested it on ia32 with
a Serverworks HE and Radeon.

I don't know who's maintaining agpgart these days, but this
was discussed on dri-devel on March 4/5, and Jeff Hartmann
thought it looked reasonable (sorry no URL, I can't find it in
the crappy SourceForge archives).

This patch is against 2.4.20-pre7.

Bjorn


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.661  
#	drivers/char/agp/agpgart_be.c	1.34    -> 1.36   
#	drivers/char/agp/agp.h	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	bjorn_helgaas@hp.com	1.661
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
--- a/drivers/char/agp/agp.h	Fri Sep 13 11:37:02 2002
+++ b/drivers/char/agp/agp.h	Fri Sep 13 11:37:02 2002
@@ -87,6 +87,7 @@
 	unsigned long *gatt_table;
 	unsigned long *gatt_table_real;
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
--- a/drivers/char/agp/agpgart_be.c	Fri Sep 13 11:37:02 2002
+++ b/drivers/char/agp/agpgart_be.c	Fri Sep 13 11:37:02 2002
@@ -207,7 +207,6 @@
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			curr->memory[i] &= ~(0x00000fff);
 			agp_bridge.agp_destroy_page((unsigned long)
 					 phys_to_virt(curr->memory[i]));
 		}
@@ -260,10 +259,7 @@
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
 
@@ -307,9 +303,6 @@
 
 void agp_copy_info(agp_kern_info * info)
 {
-	unsigned long page_mask = 0;
-	int i;
-
 	memset(info, 0, sizeof(agp_kern_info));
 	if (agp_bridge.type == NOT_SUPPORTED) {
 		info->chipset = agp_bridge.type;
@@ -325,11 +318,7 @@
 	info->max_memory = agp_bridge.max_memory_agp;
 	info->current_memory = atomic_read(&agp_bridge.current_memory_agp);
 	info->cant_use_aperture = agp_bridge.cant_use_aperture;
-
-	for(i = 0; i < agp_bridge.num_of_masks; i++)
-		page_mask |= agp_bridge.mask_memory(page_mask, i);
-
-	info->page_mask = ~page_mask;
+	info->page_mask = ~0UL;
 }
 
 /* End - Routine to copy over information structure */
@@ -722,7 +711,8 @@
 		mem->is_flushed = TRUE;
 	}
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge.gatt_table[j] = mem->memory[i];
+		agp_bridge.gatt_table[j] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 
 	agp_bridge.tlb_flush(mem);
@@ -967,7 +957,8 @@
    	CACHE_FLUSH();
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		OUTREG32(intel_i810_private.registers,
-			 I810_PTE_BASE + (j * 4), mem->memory[i]);
+			 I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 	}
 	CACHE_FLUSH();
 
@@ -1033,10 +1024,7 @@
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
@@ -1070,7 +1058,6 @@
 	intel_i810_private.i810_dev = i810_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 2;
 	agp_bridge.aperture_sizes = (void *) intel_i810_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1273,7 +1260,8 @@
 	CACHE_FLUSH();
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++)
-		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 4),mem->memory[i]);
+		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 
 	CACHE_FLUSH();
 
@@ -1334,7 +1322,7 @@
 			return(NULL);
 		}
 
-		nw->memory[0] = agp_bridge.mask_memory(virt_to_phys((void *) nw->memory[0]),type);
+		nw->memory[0] = virt_to_phys((void *) nw->memory[0]);
 		nw->page_count = 1;
 		nw->num_scratch_pages = 1;
 		nw->type = AGP_PHYS_MEMORY;
@@ -1350,7 +1338,6 @@
 	intel_i830_private.i830_dev = i830_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 3;
 	agp_bridge.aperture_sizes = (void *) intel_i830_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1832,7 +1819,6 @@
 static int __init intel_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
 	agp_bridge.size_type = U16_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1865,7 +1851,6 @@
 static int __init intel_815_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_815_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1898,7 +1883,6 @@
 static int __init intel_820_setup (struct pci_dev *pdev)
 {
        agp_bridge.masks = intel_generic_masks;
-       agp_bridge.num_of_masks = 1;
        agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
        agp_bridge.size_type = U8_APER_SIZE;
        agp_bridge.num_aperture_sizes = 7;
@@ -1931,7 +1915,6 @@
 static int __init intel_830mp_setup (struct pci_dev *pdev)
 {
        agp_bridge.masks = intel_generic_masks;
-       agp_bridge.num_of_masks = 1;
        agp_bridge.aperture_sizes = (void *) intel_830mp_sizes;
        agp_bridge.size_type = U8_APER_SIZE;
        agp_bridge.num_aperture_sizes = 4;
@@ -1963,7 +1946,6 @@
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1996,7 +1978,6 @@
 static int __init intel_845_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2029,7 +2010,6 @@
 static int __init intel_850_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2062,7 +2042,6 @@
 static int __init intel_860_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2182,7 +2161,6 @@
 static int __init via_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = via_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) via_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2296,7 +2274,6 @@
 static int __init sis_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = sis_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) sis_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2634,7 +2611,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -2680,7 +2658,6 @@
 static int __init amd_irongate_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = amd_irongate_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) amd_irongate_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2918,7 +2895,6 @@
 static int __init ali_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = ali_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) ali_generic_sizes;
 	agp_bridge.size_type = U32_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -3332,7 +3308,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = SVRWRKS_GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -3489,7 +3466,6 @@
 	serverworks_private.svrwrks_dev = pdev;
 
 	agp_bridge.masks = serverworks_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) serverworks_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -3887,7 +3863,6 @@
 static int __init hp_zx1_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = hp_zx1_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.dev_private_data = NULL;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.needs_scratch_page = FALSE;
@@ -4587,17 +4562,17 @@
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
@@ -4639,9 +4614,8 @@
 
 err_out:
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page &= ~(0x00000fff);
 		agp_bridge.agp_destroy_page((unsigned long)
-				 phys_to_virt(agp_bridge.scratch_page));
+				 phys_to_virt(agp_bridge.scratch_page_real));
 	}
 	if (got_gatt)
 		agp_bridge.free_gatt_table();
@@ -4659,9 +4633,8 @@
 	vfree(agp_bridge.key_list);
 
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page &= ~(0x00000fff);
 		agp_bridge.agp_destroy_page((unsigned long)
-				 phys_to_virt(agp_bridge.scratch_page));
+				 phys_to_virt(agp_bridge.scratch_page_real));
 	}
 }
 

