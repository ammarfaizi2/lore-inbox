Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUEWVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUEWVEv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUEWVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:04:51 -0400
Received: from hell.sks3.muni.cz ([147.251.210.31]:6627 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S263565AbUEWVEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:04:41 -0400
Date: Sun, 23 May 2004 23:04:34 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: dawes@tungstengraphics.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: i830-agp
Message-ID: <20040523210434.GJ4212@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

this patch is taken from 2.4.24 Intel original patch for Embeded controlers.
(www.intel.com/design/intarch/swsup/IEGDLinux.htm)
Their patch is GPL'ed so could you please it include in vanilla 2.6.x kernel?

This patch fixes only 852GME/855 and 830 AGP garts with integrated graphics.

-- 
Luká¹ Hejtmánek

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="i830-agp.patch"

--- intel-agp.c.orig	2004-05-10 04:32:36.000000000 +0200
+++ intel-agp.c	2004-05-23 11:54:12.000000000 +0200
@@ -353,6 +353,8 @@
 		       "No pre-allocated video memory detected.\n");
 	gtt_entries /= KB(4);
 
+	atomic_add(gtt_entries, &agp_bridge->current_memory_agp);
+	
 	intel_i830_private.gtt_entries = gtt_entries;
 }
 
@@ -365,6 +367,11 @@
 	struct aper_size_info_fixed *size;
 	int num_entries;
 	u32 temp;
+	u32 page_table_bus_address;
+	char *gtt_table, *gtt_table_end, *gtt_table_entry;
+	struct page *gtt_table_page;
+	u32 gtt_table_order = 5;
+	u32 gtt_table_size = (1<<gtt_table_order)*PAGE_SIZE - 1;
 
 	size = agp_bridge->current_size;
 	page_order = size->page_order;
@@ -379,8 +386,28 @@
 		return (-ENOMEM);
 
 	temp = INREG32(intel_i830_private.registers,I810_PGETBL_CTL) & 0xfffff000;
+	page_table_bus_address = INREG32(intel_i830_private.registers,I810_PGETBL_CTL) & 0xfffff000;
 	global_cache_flush();
 
+	if(!page_table_bus_address) {
+		/* Create GTT table */
+		printk (KERN_INFO PFX "Creating new GTT table.\n");
+		num_entries = intel_i830_sizes[0].num_entries;
+		gtt_table = (char*) __get_free_pages(GFP_KERNEL, gtt_table_order);
+		gtt_table_end = gtt_table + gtt_table_size;
+		for (gtt_table_entry = gtt_table;
+				gtt_table_entry < gtt_table_end;
+				gtt_table_entry += PAGE_SIZE ) {
+			gtt_table_page = virt_to_page(gtt_table_entry);
+			set_bit(PG_reserved, &gtt_table_page->flags);
+		}
+		agp_bridge->gatt_bus_addr = virt_to_phys(gtt_table);
+		agp_bridge->gatt_table = NULL;
+		intel_i830_private.gtt_entries = 0;
+		intel_i830_init_gtt_entries();
+		return 0;
+	}
+
 	/* we have to call this as early as possible after the MMIO base address is known */
 	intel_i830_init_gtt_entries();
 
@@ -525,13 +552,73 @@
 
 static struct agp_memory *intel_i830_alloc_by_type(size_t pg_count,int type)
 {
-	if (type == AGP_PHYS_MEMORY)
-		return(alloc_agpphysmem_i8xx(pg_count, type));
+	struct agp_memory *nw;
 
+	if (type == AGP_DCACHE_MEMORY) return(NULL);
+	
+	if (type == AGP_PHYS_MEMORY) {
+                unsigned long virt;
+                unsigned long order;
+                int i;
+
+                /* The i830 requires a physical address to program
+                 * it's mouse pointer into hardware. However the
+                 * Xserver still writes to it through the agp
+                 * aperture
+                 * NOTE: We canot use alloc_page() here because we may need
+                 * several contiguous pages. We must therefore use
+                 * __get_free_pages() for this case.
+                 */
+
+                if (pg_count == 1) {
+                        order = 0;
+                } else if (pg_count == 8) {
+                        order = 3;
+                } else {
+                        return(NULL);
+                }
+
+                nw = agp_create_memory(pg_count);
+                if (nw == NULL) return(NULL);
+
+                virt = __get_free_pages(GFP_KERNEL, order);
+                nw->physical = virt_to_phys((void *)virt);
+                if (virt == 0) {
+                        /* free this structure */
+                        agp_free_memory(nw);
+                        return(NULL);
+                }
+                for(i=0; i<pg_count; i++) {
+                        /* CHECKME:  Is this right??? */
+                        /* nw->memory[0] = virt_to_phys((void *) nw->memory[0]); */
+                        nw->memory[i] = agp_bridge->driver->mask_memory(nw->physical + 4096*i, type);
+                }
+                nw->page_count = pg_count;
+                nw->num_scratch_pages = pg_count;
+
+                nw->type = AGP_PHYS_MEMORY;
+                return(nw);
+        }
+		
 	/* always return NULL for other allocation types for now */
 	return(NULL);
 }
 
+static void intel_i830_free_by_type(struct agp_memory * curr)
+{
+       agp_free_key(curr->key);
+       if (curr->type == AGP_PHYS_MEMORY) {
+               if (curr->page_count == 1) {
+                       free_pages((unsigned long)phys_to_virt(curr->memory[0] & 0xfffff000), 0);
+               } else if (curr->page_count == 8) {
+                       free_pages((unsigned long)phys_to_virt(curr->memory[0] & 0xfffff000), 3);
+               }
+               vfree(curr->memory);
+       }
+       kfree(curr);
+}
+
 static int intel_fetch_size(void)
 {
 	int i;
@@ -1056,7 +1143,7 @@
 	.insert_memory		= intel_i830_insert_entries,
 	.remove_memory		= intel_i830_remove_entries,
 	.alloc_by_type		= intel_i830_alloc_by_type,
-	.free_by_type		= intel_i810_free_by_type,
+	.free_by_type		= intel_i830_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
 };

--GID0FwUMdk1T2AWN--
