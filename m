Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSALBeF>; Fri, 11 Jan 2002 20:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSALBd5>; Fri, 11 Jan 2002 20:33:57 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:32224 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S279798AbSALBdt>;
	Fri, 11 Jan 2002 20:33:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: agpgart interface cleanup (enables new IA64 box)
Date: Fri, 11 Jan 2002 18:34:08 -0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net,
        Chris Ahna <christopher.j.ahna@intel.com>,
        David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020112013343.E2CE7402D@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DRM needs to know the physical addresses of pages bound into the AGP
aperture, and today that information is communicated from agpgart to DRM
in the memory[] array of the agp_memory structure.  The problem is that
the values in the array are not simple physical addresses.  Rather, they
are the physical addresses mangled to be suitable for direct insertion
into the GATT (the hardware-visible translation table).

Hence, DRM needs a way to unmangle these values to get the physical
address back.  Today, agpgart exports a "page_mask" value, so DRM does the
equivalent of this:

    paddr = agpmem->memory->memory[offset] & dev->agp->page_mask;

This isn't sufficient for the 460GX, because its mangling function
requires a shift as well as a mask.  The 460GX code (which is still in the
ia64 patch, not in the mainstream kernel) looks like this:

    paddr = (agpmem->memory->memory[offset] & 0xffffff) << 12;

So DRM currently has chipset-specific code in it to unmangle the values in 
memory[], while there's no reason for the mangled values to ever be 
exported from agpgart.  Worse, at least one soon-to-be-released IA64 box 
has an unmangling function different from the 460GX.

The attached patch against 2.5.2-pre11 remedies all this by leaving the 
plain physical addresses in memory[].  The chipset-specific mangling is 
then done at the point where it is needed, when those values are inserted 
into the GATT.

The patch is done so that agpgart still exports a page_mask; it's just 
~0UL, so that old DRM modules will continue to work with new kernels.  
These places are marked with "#ifdef EXPORT_PAGE_MASK" so it can be pulled 
out eventually.  New DRM modules will also work with old kernels, because 
they still use page_mask (under "#ifdef USE_PAGE_MASK").

-- 
Bjorn Helgaas - bjorn_helgaas@hp.com
Linux Systems Operation R&D
Hewlett-Packard


diff -u -ur -X /home/helgaas/exclude 
linux-2.5.2-pre11/include/linux/agp_backend.h 
linux-2.5.2-pre11+pagemask/include/linux/agp_backend.h
--- linux-2.5.2-pre11/include/linux/agp_backend.h	Fri Nov  9 15:11:15 2001
+++ linux-2.5.2-pre11+pagemask/include/linux/agp_backend.h	Fri Jan 11 
11:02:15 2002
@@ -38,6 +38,13 @@
 #define AGPGART_VERSION_MAJOR 0
 #define AGPGART_VERSION_MINOR 99
 
+/*
+ * Old kernels exported mangled page addresses to DRM, which used
+ * page_mask to unmangle them.  Old DRM, such as that distributed with
+ * XFree86, requires the page_mask.
+ */
+#define EXPORT_PAGE_MASK 1
+
 enum chipset_type {
 	NOT_SUPPORTED,
 	INTEL_GENERIC,
@@ -92,7 +99,9 @@
 	int max_memory;		/* In pages */
 	int current_memory;
 	int cant_use_aperture;
+#ifdef EXPORT_PAGE_MASK
 	unsigned long page_mask;
+#endif
 } agp_kern_info;
 
 /* 
diff -u -ur -X /home/helgaas/exclude 
linux-2.5.2-pre11/drivers/char/agp/agpgart_be.c 
linux-2.5.2-pre11+pagemask/drivers/char/agp/agpgart_be.c
--- linux-2.5.2-pre11/drivers/char/agp/agpgart_be.c	Fri Nov 30 09:52:41 
2001
+++ linux-2.5.2-pre11+pagemask/drivers/char/agp/agpgart_be.c	Fri Jan 11 
11:20:36 2002
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
@@ -325,11 +318,9 @@
 	info->max_memory = agp_bridge.max_memory_agp;
 	info->current_memory = atomic_read(&agp_bridge.current_memory_agp);
 	info->cant_use_aperture = agp_bridge.cant_use_aperture;
-
-	for(i = 0; i < agp_bridge.num_of_masks; i++)
-		page_mask |= agp_bridge.mask_memory(page_mask, i);
-
-	info->page_mask = ~page_mask;
+#ifdef EXPORT_PAGE_MASK
+	info->page_mask = ~0UL;
+#endif
 }
 
 /* End - Routine to copy over information structure */
@@ -746,7 +737,8 @@
 		mem->is_flushed = TRUE;
 	}
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge.gatt_table[j] = mem->memory[i];
+		agp_bridge.gatt_table[j] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 
 	agp_bridge.tlb_flush(mem);
@@ -983,7 +975,8 @@
    	CACHE_FLUSH();
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		OUTREG32(intel_i810_private.registers,
-			 I810_PTE_BASE + (j * 4), mem->memory[i]);
+			 I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 	}
 	CACHE_FLUSH();
 
@@ -1049,10 +1042,7 @@
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
@@ -1086,7 +1076,6 @@
 	intel_i810_private.i810_dev = i810_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 2;
 	agp_bridge.aperture_sizes = (void *) intel_i810_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1288,7 +1277,8 @@
 	CACHE_FLUSH();
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++)
-		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 
4),mem->memory[i]);
+		OUTREG32(intel_i830_private.registers,I810_PTE_BASE + (j * 4),
+			 agp_bridge.mask_memory(mem->memory[i], mem->type));
 
 	CACHE_FLUSH();
 
@@ -1349,7 +1339,7 @@
 			return(NULL);
 		}
 
-		nw->memory[0] = agp_bridge.mask_memory(virt_to_phys((void *) 
nw->memory[0]),type);
+		nw->memory[0] = virt_to_phys((void *) nw->memory[0]);
 		nw->page_count = 1;
 		nw->num_scratch_pages = 1;
 		nw->type = AGP_PHYS_MEMORY;
@@ -1365,7 +1355,6 @@
 	intel_i830_private.i830_dev = i830_dev;
 
 	agp_bridge.masks = intel_i810_masks;
-	agp_bridge.num_of_masks = 3;
 	agp_bridge.aperture_sizes = (void *) intel_i830_sizes;
 	agp_bridge.size_type = FIXED_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 2;
@@ -1784,7 +1773,6 @@
 static int __init intel_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
 	agp_bridge.size_type = U16_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1818,7 +1806,6 @@
 static int __init intel_820_setup (struct pci_dev *pdev)
 {
        agp_bridge.masks = intel_generic_masks;
-       agp_bridge.num_of_masks = 1;
        agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
        agp_bridge.size_type = U8_APER_SIZE;
        agp_bridge.num_aperture_sizes = 7;
@@ -1878,7 +1865,6 @@
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1911,7 +1897,6 @@
 static int __init intel_845_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1944,7 +1929,6 @@
 static int __init intel_850_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -1977,7 +1961,6 @@
 static int __init intel_860_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) intel_8xx_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2097,7 +2080,6 @@
 static int __init via_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = via_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) via_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2211,7 +2193,6 @@
 static int __init sis_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = sis_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) sis_generic_sizes;
 	agp_bridge.size_type = U8_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2543,7 +2524,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -2589,7 +2571,6 @@
 static int __init amd_irongate_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = amd_irongate_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) amd_irongate_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -2837,7 +2818,6 @@
 static int __init ali_generic_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = ali_generic_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) ali_generic_sizes;
 	agp_bridge.size_type = U32_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
@@ -3245,7 +3225,8 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
 		cur_gatt = SVRWRKS_GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
+		cur_gatt[GET_GATT_OFF(addr)] =
+			agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 	agp_bridge.tlb_flush(mem);
 	return 0;
@@ -3425,7 +3406,6 @@
 	serverworks_private.svrwrks_dev = pdev;
 
 	agp_bridge.masks = serverworks_masks;
-	agp_bridge.num_of_masks = 1;
 	agp_bridge.aperture_sizes = (void *) serverworks_sizes;
 	agp_bridge.size_type = LVL2_APER_SIZE;
 	agp_bridge.num_aperture_sizes = 7;
diff -u -ur -X /home/helgaas/exclude 
linux-2.5.2-pre11/drivers/char/drm/drmP.h 
linux-2.5.2-pre11+pagemask/drivers/char/drm/drmP.h
--- linux-2.5.2-pre11/drivers/char/drm/drmP.h	Sun Dec 16 16:43:58 2001
+++ linux-2.5.2-pre11+pagemask/drivers/char/drm/drmP.h	Fri Jan 11 11:07:28 
2002
@@ -76,6 +76,11 @@
 #include <asm/pgalloc.h>
 #include "drm.h"
 
+/* page_mask required for old kernels that export mangled page addrs */
+/* when the mainline kernel no longer exports mangled addrs, this can be
+ * under "#if LINUX_VERSION_CODE < ..." */
+#define USE_PAGE_MASK		1
+
 /* page_to_bus for earlier kernels, not optimal in all cases */
 #ifndef page_to_bus
 #define page_to_bus(page)	((unsigned 
int)(virt_to_bus(page_address(page))))
@@ -628,7 +633,9 @@
 	unsigned long      base;
    	int 		   agp_mtrr;
 	int		   cant_use_aperture;
+#ifdef USE_PAGE_MASK
 	unsigned long	   page_mask;
+#endif
 } drm_agp_head_t;
 #endif
 
diff -u -ur -X /home/helgaas/exclude 
linux-2.5.2-pre11/drivers/char/drm/drm_agpsupport.h 
linux-2.5.2-pre11+pagemask/drivers/char/drm/drm_agpsupport.h
--- linux-2.5.2-pre11/drivers/char/drm/drm_agpsupport.h	Sun Dec 16 
16:43:58 2001
+++ linux-2.5.2-pre11+pagemask/drivers/char/drm/drm_agpsupport.h	Fri Jan 
11 11:01:11 2002
@@ -323,7 +323,9 @@
 		head->page_mask = ~(0xfff);
 #else
 		head->cant_use_aperture = head->agp_info.cant_use_aperture;
+#ifdef USE_PAGE_MASK
 		head->page_mask = head->agp_info.page_mask;
+#endif
 #endif
 
 		DRM_INFO("AGP %d.%d on %s @ 0x%08lx %ZuMB\n",
diff -u -ur -X /home/helgaas/exclude 
linux-2.5.2-pre11/drivers/char/drm/drm_vm.h 
linux-2.5.2-pre11+pagemask/drivers/char/drm/drm_vm.h
--- linux-2.5.2-pre11/drivers/char/drm/drm_vm.h	Sun Dec 16 16:43:58 2001
+++ linux-2.5.2-pre11+pagemask/drivers/char/drm/drm_vm.h	Fri Jan 11 
11:01:24 2002
@@ -115,7 +115,9 @@
                  * Get the page, inc the use count, and return it
                  */
 		offset = (baddr - agpmem->bound) >> PAGE_SHIFT;
+#ifdef USE_PAGE_MASK
 		agpmem->memory->memory[offset] &= dev->agp->page_mask;
+#endif
 		page = virt_to_page(__va(agpmem->memory->memory[offset]));
 		get_page(page);
 
