Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbSI1EbR>; Sat, 28 Sep 2002 00:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbSI1Eap>; Sat, 28 Sep 2002 00:30:45 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:5855 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S262708AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART 5/5: Intel 460GX support
Message-Id: <E17v9Je-0001my-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Intel 460GX GART support.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.692   -> 1.693  
#	drivers/char/drm/drm_agpsupport.h	1.10    -> 1.11   
#	drivers/char/agp/agpgart_be.c	1.39    -> 1.40   
#	drivers/char/drm/r128_cce.c	1.6     -> 1.7    
#	drivers/char/drm/radeon_cp.c	1.7     -> 1.8    
#	drivers/char/Config.in	1.36    -> 1.37   
#	drivers/char/drm-4.0/radeon_cp.c	1.2     -> 1.3    
#	include/linux/agp_backend.h	1.14    -> 1.15   
#	drivers/char/agp/agp.h	1.19    -> 1.20   
#	drivers/char/drm-4.0/r128_cce.c	1.2     -> 1.3    
#	drivers/char/drm-4.0/agpsupport.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/27	bjorn_helgaas@hp.com	1.693
# Intel 460GX GART support.  Originally due to Chris Ahna
# (christopher.j.ahna@intel.com).
# --------------------------------------------
#
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/Config.in	Fri Sep 27 13:24:23 2002
@@ -284,6 +284,7 @@
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
    if [ "$CONFIG_IA64" = "y" ]; then
+      bool '  Intel 460GX support' CONFIG_AGP_I460
       bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
    fi
 fi
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/agp/agp.h	Fri Sep 27 13:24:23 2002
@@ -229,6 +229,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_82443GX_1
 #define PCI_DEVICE_ID_INTEL_82443GX_1   0x71a1
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_460GX
+#define PCI_DEVICE_ID_INTEL_460GX       0x84ea
+#endif
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
 #define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
 #endif
@@ -279,6 +282,15 @@
 #define INTEL_AGPCTRL   0xb0
 #define INTEL_NBXCFG    0x50
 #define INTEL_ERRSTS    0x91
+
+/* Intel 460GX Registers */
+#define INTEL_I460_APBASE		0x10
+#define INTEL_I460_BAPBASE		0x98
+#define INTEL_I460_GXBCTL		0xa0
+#define INTEL_I460_AGPSIZ		0xa2
+#define INTEL_I460_ATTBASE		0xfe200000
+#define INTEL_I460_GATT_VALID		(1UL << 24)
+#define INTEL_I460_GATT_COHERENT	(1UL << 25)
 
 /* intel i830 registers */
 #define I830_GMCH_CTRL             0x52
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/agp/agpgart_be.c	Fri Sep 27 13:24:23 2002
@@ -1445,9 +1445,605 @@
 
 #endif /* CONFIG_AGP_I810 */
  
- #ifdef CONFIG_AGP_INTEL
+#ifdef CONFIG_AGP_I460
 
-#endif /* CONFIG_AGP_I810 */
+/* BIOS configures the chipset so that one of two apbase registers are used */
+static u8 intel_i460_dynamic_apbase = 0x10;
+
+/* 460 supports multiple GART page sizes, so GART pageshift is dynamic */ 
+static u8 intel_i460_pageshift = 12;
+static u32 intel_i460_pagesize;
+
+/* Keep track of which is larger, chipset or kernel page size. */
+static u32 intel_i460_cpk = 1;
+
+/* Structure for tracking partial use of 4MB GART pages */
+static u32 **i460_pg_detail = NULL;
+static u32 *i460_pg_count = NULL;
+
+#define I460_CPAGES_PER_KPAGE (PAGE_SIZE >> intel_i460_pageshift)
+#define I460_KPAGES_PER_CPAGE ((1 << intel_i460_pageshift) >> PAGE_SHIFT)
+
+#define I460_SRAM_IO_DISABLE		(1 << 4)
+#define I460_BAPBASE_ENABLE		(1 << 3)
+#define I460_AGPSIZ_MASK		0x7
+#define I460_4M_PS			(1 << 1)
+
+#define log2(x)				ffz(~(x))
+
+static gatt_mask intel_i460_masks[] =
+{
+	{ INTEL_I460_GATT_VALID | INTEL_I460_GATT_COHERENT, 0 }
+};
+
+static unsigned long intel_i460_mask_memory(unsigned long addr, int type) 
+{
+	/* Make sure the returned address is a valid GATT entry */
+	return (agp_bridge.masks[0].mask | (((addr & 
+		     ~((1 << intel_i460_pageshift) - 1)) & 0xffffff000) >> 12));
+}
+
+static unsigned long intel_i460_unmask_memory(unsigned long addr)
+{
+	/* Turn a GATT entry into a physical address */
+	return ((addr & 0xffffff) << 12);
+}
+
+static int intel_i460_fetch_size(void)
+{
+	int i;
+	u8 temp;
+	aper_size_info_8 *values;
+
+	/* Determine the GART page size */
+	pci_read_config_byte(agp_bridge.dev, INTEL_I460_GXBCTL, &temp);
+	intel_i460_pageshift = (temp & I460_4M_PS) ? 22 : 12;
+	intel_i460_pagesize = 1UL << intel_i460_pageshift;
+
+	values = A_SIZE_8(agp_bridge.aperture_sizes);
+
+	pci_read_config_byte(agp_bridge.dev, INTEL_I460_AGPSIZ, &temp);
+
+	/* Exit now if the IO drivers for the GART SRAMS are turned off */
+	if (temp & I460_SRAM_IO_DISABLE) {
+		printk(KERN_WARNING PFX "GART SRAMS disabled on 460GX chipset\n");
+		printk(KERN_WARNING PFX "AGPGART operation not possible\n");
+		return 0;
+	}
+
+	/* Make sure we don't try to create an 2 ^ 23 entry GATT */
+	if ((intel_i460_pageshift == 0) && ((temp & I460_AGPSIZ_MASK) == 4)) {
+		printk(KERN_WARNING PFX "We can't have a 32GB aperture with 4KB"
+			" GART pages\n");
+		return 0;
+	}
+
+	/* Determine the proper APBASE register */
+	if (temp & I460_BAPBASE_ENABLE)
+		intel_i460_dynamic_apbase = INTEL_I460_BAPBASE;
+	else
+		intel_i460_dynamic_apbase = INTEL_I460_APBASE;
+
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+
+		/*
+		 * Dynamically calculate the proper num_entries and page_order 
+		 * values for the define aperture sizes. Take care not to
+		 * shift off the end of values[i].size.
+		 */	
+		values[i].num_entries = (values[i].size << 8) >>
+						(intel_i460_pageshift - 12);
+		values[i].page_order = log2((sizeof(u32)*values[i].num_entries)
+						>> PAGE_SHIFT);
+	}
+
+	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
+		/* Neglect control bits when matching up size_value */
+		if ((temp & I460_AGPSIZ_MASK) == values[i].size_value) {
+			agp_bridge.previous_size =
+			    agp_bridge.current_size = (void *) (values + i);
+			agp_bridge.aperture_size_idx = i;
+			return values[i].size;
+		}
+	}
+
+	return 0;
+}
+
+/* There isn't anything to do here since 460 has no GART TLB. */ 
+static void intel_i460_tlb_flush(agp_memory * mem)
+{
+	return;
+}
+
+/*
+ * This utility function is needed to prevent corruption of the control bits
+ * which are stored along with the aperture size in 460's AGPSIZ register
+ */
+static void intel_i460_write_agpsiz(u8 size_value)
+{
+	u8 temp;
+
+	pci_read_config_byte(agp_bridge.dev, INTEL_I460_AGPSIZ, &temp);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I460_AGPSIZ,
+		((temp & ~I460_AGPSIZ_MASK) | size_value));
+}
+
+static void intel_i460_cleanup(void)
+{
+	aper_size_info_8 *previous_size;
+
+	previous_size = A_SIZE_8(agp_bridge.previous_size);
+	intel_i460_write_agpsiz(previous_size->size_value);
+
+	if (intel_i460_cpk == 0) {
+		vfree(i460_pg_detail);
+		vfree(i460_pg_count);
+	}
+}
+
+
+/* Control bits for Out-Of-GART coherency and Burst Write Combining */
+#define I460_GXBCTL_OOG		(1UL << 0)
+#define I460_GXBCTL_BWC		(1UL << 2)
+
+static int intel_i460_configure(void)
+{
+	union {
+		u32 small[2];
+		u64 large;
+	} temp;
+	u8 scratch;
+	int i;
+
+	aper_size_info_8 *current_size;
+
+	temp.large = 0;
+
+	current_size = A_SIZE_8(agp_bridge.current_size);
+	intel_i460_write_agpsiz(current_size->size_value);	
+
+	/*
+	 * Do the necessary rigmarole to read all eight bytes of APBASE.
+	 * This has to be done since the AGP aperture can be above 4GB on
+	 * 460 based systems.
+	 */
+	pci_read_config_dword(agp_bridge.dev, intel_i460_dynamic_apbase, 
+		&(temp.small[0]));
+	pci_read_config_dword(agp_bridge.dev, intel_i460_dynamic_apbase + 4,
+		&(temp.small[1]));
+
+	/* Clear BAR control bits */
+	agp_bridge.gart_bus_addr = temp.large & ~((1UL << 3) - 1); 
+
+	pci_read_config_byte(agp_bridge.dev, INTEL_I460_GXBCTL, &scratch);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I460_GXBCTL,
+			  (scratch & 0x02) | I460_GXBCTL_OOG | I460_GXBCTL_BWC);
+
+	/* 
+	 * Initialize partial allocation trackers if a GART page is bigger than
+	 * a kernel page.
+	 */
+	if (I460_CPAGES_PER_KPAGE >= 1) {
+		intel_i460_cpk = 1;
+	} else {
+		intel_i460_cpk = 0;
+
+		i460_pg_detail = (void *) vmalloc(sizeof(*i460_pg_detail) *
+					current_size->num_entries);
+		i460_pg_count = (void *) vmalloc(sizeof(*i460_pg_count) *
+					current_size->num_entries);
+	
+		for (i = 0; i < current_size->num_entries; i++) {
+			i460_pg_count[i] = 0;
+			i460_pg_detail[i] = NULL;
+		}
+	}
+
+	return 0;
+}
+
+static int intel_i460_create_gatt_table(void) {
+
+	char *table;
+	int i;
+	int page_order;
+	int num_entries;
+	void *temp;
+	unsigned int read_back;
+
+	/*
+	 * Load up the fixed address of the GART SRAMS which hold our
+	 * GATT table.
+	 */
+	table = (char *) __va(INTEL_I460_ATTBASE);
+
+	temp = agp_bridge.current_size;
+	page_order = A_SIZE_8(temp)->page_order;
+	num_entries = A_SIZE_8(temp)->num_entries;
+
+	agp_bridge.gatt_table_real = (u32 *) table;
+	agp_bridge.gatt_table = ioremap_nocache(virt_to_phys(table),
+		 			     (PAGE_SIZE * (1 << page_order)));
+	agp_bridge.gatt_bus_addr = virt_to_phys(agp_bridge.gatt_table_real);
+
+	for (i = 0; i < num_entries; i++) {
+		agp_bridge.gatt_table[i] = 0;
+	}
+
+	/* 
+	 * The 460 spec says we have to read the last location written to 
+	 * make sure that all writes have taken effect
+	 */
+	read_back = agp_bridge.gatt_table[i - 1];
+
+	return 0;
+}
+
+static int intel_i460_free_gatt_table(void)
+{
+	int num_entries;
+	int i;
+	void *temp;
+	unsigned int read_back;
+
+	temp = agp_bridge.current_size;
+
+	num_entries = A_SIZE_8(temp)->num_entries;
+
+	for (i = 0; i < num_entries; i++) {
+		agp_bridge.gatt_table[i] = 0;
+	}
+	
+	/* 
+	 * The 460 spec says we have to read the last location written to 
+	 * make sure that all writes have taken effect
+	 */
+	read_back = agp_bridge.gatt_table[i - 1];
+
+	iounmap(agp_bridge.gatt_table);
+
+	return 0;
+}
+
+/* These functions are called when PAGE_SIZE exceeds the GART page size */	
+
+static int intel_i460_insert_memory_cpk(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	int i, j, k, num_entries;
+	void *temp;
+	unsigned long paddr;
+	unsigned int read_back;
+
+	/* 
+	 * The rest of the kernel will compute page offsets in terms of
+	 * PAGE_SIZE.
+	 */
+	pg_start = I460_CPAGES_PER_KPAGE * pg_start;
+
+	temp = agp_bridge.current_size;
+	num_entries = A_SIZE_8(temp)->num_entries;
+
+	if ((pg_start + I460_CPAGES_PER_KPAGE * mem->page_count) > num_entries) {
+		printk(KERN_WARNING PFX "Looks like we're out of AGP memory\n");
+		return -EINVAL;
+	}
+
+	j = pg_start;
+	while (j < (pg_start + I460_CPAGES_PER_KPAGE * mem->page_count)) {
+		if (!PGE_EMPTY(agp_bridge.gatt_table[j])) {
+			return -EBUSY;
+		}
+		j++;
+	}
+
+	for (i = 0, j = pg_start; i < mem->page_count; i++) {
+
+		paddr = mem->memory[i];
+
+		for (k = 0; k < I460_CPAGES_PER_KPAGE; k++, j++, paddr += intel_i460_pagesize)
+			agp_bridge.gatt_table[j] = (unsigned int)
+			    agp_bridge.mask_memory(paddr, mem->type);
+	}
+
+	/* 
+	 * The 460 spec says we have to read the last location written to 
+	 * make sure that all writes have taken effect
+	 */
+	read_back = agp_bridge.gatt_table[j - 1];
+
+	return 0;
+}
+
+static int intel_i460_remove_memory_cpk(agp_memory * mem, off_t pg_start,
+				     int type)
+{
+	int i;
+	unsigned int read_back;
+
+	pg_start = I460_CPAGES_PER_KPAGE * pg_start;
+
+	for (i = pg_start; i < (pg_start + I460_CPAGES_PER_KPAGE * 
+							mem->page_count); i++) 
+		agp_bridge.gatt_table[i] = 0;
+
+	/* 
+	 * The 460 spec says we have to read the last location written to 
+	 * make sure that all writes have taken effect
+	 */
+	read_back = agp_bridge.gatt_table[i - 1];
+
+	return 0;
+}
+
+/*
+ * These functions are called when the GART page size exceeds PAGE_SIZE.
+ *
+ * This situation is interesting since AGP memory allocations that are
+ * smaller than a single GART page are possible.  The structures i460_pg_count
+ * and i460_pg_detail track partial allocation of the large GART pages to
+ * work around this issue.
+ *
+ * i460_pg_count[pg_num] tracks the number of kernel pages in use within
+ * GART page pg_num.  i460_pg_detail[pg_num] is an array containing a
+ * psuedo-GART entry for each of the aforementioned kernel pages.  The whole
+ * of i460_pg_detail is equivalent to a giant GATT with page size equal to
+ * that of the kernel.
+ */	
+
+static void *intel_i460_alloc_large_page(int pg_num)
+{
+	int i;
+	void *bp, *bp_end;
+	struct page *page;
+
+	i460_pg_detail[pg_num] = (void *) vmalloc(sizeof(u32) * 
+							I460_KPAGES_PER_CPAGE);
+	if (i460_pg_detail[pg_num] == NULL) {
+		printk(KERN_WARNING PFX "Out of memory, we're in trouble...\n");
+		return NULL;
+	}
+
+	for (i = 0; i < I460_KPAGES_PER_CPAGE; i++)
+		i460_pg_detail[pg_num][i] = 0;
+
+	bp = (void *) __get_free_pages(GFP_KERNEL, 
+					intel_i460_pageshift - PAGE_SHIFT);
+	if (bp == NULL) {
+		printk(KERN_WARNING PFX "Couldn't alloc 4M GART page...\n");
+		return NULL;
+	}
+
+	bp_end = bp + ((PAGE_SIZE * 
+			    (1 << (intel_i460_pageshift - PAGE_SHIFT))) - 1);
+
+	for (page = virt_to_page(bp); page <= virt_to_page(bp_end); page++) {
+		atomic_inc(&page->count);
+		set_bit(PG_locked, &page->flags);
+		atomic_inc(&agp_bridge.current_memory_agp);
+	}
+
+	return bp;		
+}
+
+static void intel_i460_free_large_page(int pg_num, unsigned long addr)
+{
+	struct page *page;
+	void *bp, *bp_end;
+
+	bp = (void *) __va(addr);
+	bp_end = bp + (PAGE_SIZE * 
+			(1 << (intel_i460_pageshift - PAGE_SHIFT)));
+
+	vfree(i460_pg_detail[pg_num]);
+	i460_pg_detail[pg_num] = NULL;
+
+	for (page = virt_to_page(bp); page < virt_to_page(bp_end); page++) {
+		put_page(page);
+		UnlockPage(page);
+		atomic_dec(&agp_bridge.current_memory_agp);
+	}
+
+	free_pages((unsigned long) bp, intel_i460_pageshift - PAGE_SHIFT);
+}
+	
+static int intel_i460_insert_memory_kpc(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	int i, pg, start_pg, end_pg, start_offset, end_offset, idx;
+	int num_entries;	
+	void *temp;
+	unsigned int read_back;
+	unsigned long paddr;
+
+	temp = agp_bridge.current_size;
+	num_entries = A_SIZE_8(temp)->num_entries;
+
+	/* Figure out what pg_start means in terms of our large GART pages */
+	start_pg 	= pg_start / I460_KPAGES_PER_CPAGE;
+	start_offset 	= pg_start % I460_KPAGES_PER_CPAGE;
+	end_pg 		= (pg_start + mem->page_count - 1) / 
+							I460_KPAGES_PER_CPAGE;
+	end_offset 	= (pg_start + mem->page_count - 1) % 
+							I460_KPAGES_PER_CPAGE;
+
+	if (end_pg > num_entries) {
+		printk(KERN_WARNING PFX "Looks like we're out of AGP memory\n");
+		return -EINVAL;
+	}
+
+	/* Check if the requested region of the aperture is free */
+	for (pg = start_pg; pg <= end_pg; pg++) {
+		/* Allocate new GART pages if necessary */
+		if (i460_pg_detail[pg] == NULL) {
+			temp = intel_i460_alloc_large_page(pg);
+			if (temp == NULL)
+				return -ENOMEM;
+			agp_bridge.gatt_table[pg] = agp_bridge.mask_memory(
+			    			       (unsigned long) temp, 0);
+			read_back = agp_bridge.gatt_table[pg];
+		}
+
+		for (idx = ((pg == start_pg) ? start_offset : 0);
+		     idx < ((pg == end_pg) ? (end_offset + 1) 
+				       : I460_KPAGES_PER_CPAGE);
+		     idx++) {
+			if(i460_pg_detail[pg][idx] != 0)
+				return -EBUSY;
+		}
+	}
+		
+	for (pg = start_pg, i = 0; pg <= end_pg; pg++) {
+		paddr = intel_i460_unmask_memory(agp_bridge.gatt_table[pg]);
+		for (idx = ((pg == start_pg) ? start_offset : 0);
+		     idx < ((pg == end_pg) ? (end_offset + 1)
+				       : I460_KPAGES_PER_CPAGE);
+		     idx++, i++) {
+			mem->memory[i] = paddr + (idx * PAGE_SIZE);
+			i460_pg_detail[pg][idx] =
+			    agp_bridge.mask_memory(mem->memory[i], mem->type);
+			    
+			i460_pg_count[pg]++;
+		}
+	}
+
+	return 0;
+}
+	
+static int intel_i460_remove_memory_kpc(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	int i, pg, start_pg, end_pg, start_offset, end_offset, idx;
+	int num_entries;
+	void *temp;
+	unsigned int read_back;
+	unsigned long paddr;
+
+	temp = agp_bridge.current_size;
+	num_entries = A_SIZE_8(temp)->num_entries;
+
+	/* Figure out what pg_start means in terms of our large GART pages */
+	start_pg 	= pg_start / I460_KPAGES_PER_CPAGE;
+	start_offset 	= pg_start % I460_KPAGES_PER_CPAGE;
+	end_pg 		= (pg_start + mem->page_count - 1) / 
+						I460_KPAGES_PER_CPAGE;
+	end_offset 	= (pg_start + mem->page_count - 1) % 
+						I460_KPAGES_PER_CPAGE;
+
+	for (i = 0, pg = start_pg; pg <= end_pg; pg++) {
+		for (idx = ((pg == start_pg) ? start_offset : 0);
+		     idx < ((pg == end_pg) ? (end_offset + 1)
+				       : I460_KPAGES_PER_CPAGE);
+		     idx++, i++) {
+			mem->memory[i] = 0;
+			i460_pg_detail[pg][idx] = 0;
+			i460_pg_count[pg]--;
+		}
+
+		/* Free GART pages if they are unused */
+		if (i460_pg_count[pg] == 0) {
+			paddr = intel_i460_unmask_memory(agp_bridge.gatt_table[pg]);
+			agp_bridge.gatt_table[pg] = agp_bridge.scratch_page;
+			read_back = agp_bridge.gatt_table[pg];
+
+			intel_i460_free_large_page(pg, paddr);
+		}
+	}
+		
+	return 0;
+}
+
+/* Dummy routines to call the approriate {cpk,kpc} function */
+
+static int intel_i460_insert_memory(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	if (intel_i460_cpk)
+		return intel_i460_insert_memory_cpk(mem, pg_start, type);
+	else
+		return intel_i460_insert_memory_kpc(mem, pg_start, type);
+}
+
+static int intel_i460_remove_memory(agp_memory * mem,
+				     off_t pg_start, int type)
+{
+	if (intel_i460_cpk)
+		return intel_i460_remove_memory_cpk(mem, pg_start, type);
+	else
+		return intel_i460_remove_memory_kpc(mem, pg_start, type);
+}
+
+/*
+ * If the kernel page size is smaller that the chipset page size, we don't
+ * want to allocate memory until we know where it is to be bound in the
+ * aperture (a multi-kernel-page alloc might fit inside of an already
+ * allocated GART page).  Consequently, don't allocate or free anything
+ * if i460_cpk (meaning chipset pages per kernel page) isn't set.
+ *
+ * Let's just hope nobody counts on the allocated AGP memory being there
+ * before bind time (I don't think current drivers do)...
+ */ 
+static unsigned long intel_i460_alloc_page(void)
+{
+	if (intel_i460_cpk)
+		return agp_generic_alloc_page();
+
+	/* Returning NULL would cause problems */
+	return ((unsigned long) ~0UL);
+}
+
+static void intel_i460_destroy_page(unsigned long page)
+{
+	if (intel_i460_cpk)
+		agp_generic_destroy_page(page);
+}
+
+static aper_size_info_8 intel_i460_sizes[3] =
+{
+	/* 
+	 * The 32GB aperture is only available with a 4M GART page size.
+	 * Due to the dynamic GART page size, we can't figure out page_order
+	 * or num_entries until runtime.
+	 */
+	{32768, 0, 0, 4},
+	{1024, 0, 0, 2},
+	{256, 0, 0, 1}
+};
+
+static int __init intel_i460_setup(struct pci_dev *pdev)
+{
+        agp_bridge.masks = intel_i460_masks;
+        agp_bridge.aperture_sizes = (void *) intel_i460_sizes;
+        agp_bridge.size_type = U8_APER_SIZE;
+        agp_bridge.num_aperture_sizes = 3;
+        agp_bridge.dev_private_data = NULL;
+        agp_bridge.needs_scratch_page = FALSE;
+        agp_bridge.configure = intel_i460_configure;
+        agp_bridge.fetch_size = intel_i460_fetch_size;
+        agp_bridge.cleanup = intel_i460_cleanup;
+        agp_bridge.tlb_flush = intel_i460_tlb_flush;
+        agp_bridge.mask_memory = intel_i460_mask_memory;
+        agp_bridge.agp_enable = agp_generic_agp_enable;
+        agp_bridge.cache_flush = global_cache_flush;
+        agp_bridge.create_gatt_table = intel_i460_create_gatt_table;
+        agp_bridge.free_gatt_table = intel_i460_free_gatt_table;
+        agp_bridge.insert_memory = intel_i460_insert_memory;
+        agp_bridge.remove_memory = intel_i460_remove_memory;
+        agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+        agp_bridge.free_by_type = agp_generic_free_by_type;
+        agp_bridge.agp_alloc_page = intel_i460_alloc_page;
+        agp_bridge.agp_destroy_page = intel_i460_destroy_page;
+        agp_bridge.suspend = agp_generic_suspend;
+        agp_bridge.resume = agp_generic_resume;
+        agp_bridge.cant_use_aperture = 1;
+
+        return 0;
+
+        (void) pdev; /* unused */
+}
+
+#endif		/* CONFIG_AGP_I460 */
 
 #ifdef CONFIG_AGP_INTEL
 
@@ -4608,6 +5204,15 @@
 
 #endif /* CONFIG_AGP_INTEL */
 
+#ifdef CONFIG_AGP_I460
+	{ PCI_DEVICE_ID_INTEL_460GX,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_460GX,
+		"Intel",
+		"460GX",
+		intel_i460_setup },
+#endif
+
 #ifdef CONFIG_AGP_SIS
 	{ PCI_DEVICE_ID_SI_740,
 		PCI_VENDOR_ID_SI,
diff -Nru a/drivers/char/drm/drm_agpsupport.h b/drivers/char/drm/drm_agpsupport.h
--- a/drivers/char/drm/drm_agpsupport.h	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm/drm_agpsupport.h	Fri Sep 27 13:24:23 2002
@@ -270,6 +270,7 @@
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 		case INTEL_I845:	head->chipset = "Intel i845";    break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
+		case INTEL_460GX:	head->chipset = "Intel 460GX";	 break;
 
 		case VIA_GENERIC:	head->chipset = "VIA";           break;
 		case VIA_VP3:		head->chipset = "VIA VP3";       break;
diff -Nru a/drivers/char/drm/r128_cce.c b/drivers/char/drm/r128_cce.c
--- a/drivers/char/drm/r128_cce.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm/r128_cce.c	Fri Sep 27 13:24:23 2002
@@ -316,7 +316,7 @@
 static void r128_cce_init_ring_buffer( drm_device_t *dev,
 				       drm_r128_private_t *dev_priv )
 {
-	u32 ring_start;
+	u32 ring_start, rptr_addr;
 	u32 tmp;
 
 	DRM_DEBUG( "%s\n", __FUNCTION__ );
@@ -340,8 +340,24 @@
 	SET_RING_HEAD( &dev_priv->ring, 0 );
 
 	if ( !dev_priv->is_pci ) {
-		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
-			    dev_priv->ring_rptr->offset );
+		/*
+		 * 460GX doesn't claim PCI writes from the card into
+		 * the AGP aperture, so we have to get space outside
+		 * the aperture for RPTR_ADDR.
+		 */
+		if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off;
+
+			alt_rh_off = __get_free_page(GFP_KERNEL | GFP_DMA);
+			atomic_inc(&virt_to_page(alt_rh_off)->count);
+			set_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+
+			dev_priv->ring.head = (__volatile__ u32 *) alt_rh_off;
+			SET_RING_HEAD( &dev_priv->ring, 0 );
+			rptr_addr = __pa( dev_priv->ring.head );
+		} else
+			rptr_addr = dev_priv->ring_rptr->offset;
+		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR, rptr_addr );
 	} else {
 		drm_sg_mem_t *entry = dev->sg;
 		unsigned long tmp_ofs, page_ofs;
@@ -633,6 +649,19 @@
 				DRM_ERROR( "failed to cleanup PCI GART!\n" );
 		}
 
+		/*
+		 * Free the page we grabbed for RPTR_ADDR
+		 */
+		if ( !dev_priv->is_pci && dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off =
+				(unsigned long) dev_priv->ring.head;
+
+			atomic_dec(&virt_to_page(alt_rh_off)->count);
+			clear_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+			wake_up(&virt_to_page(alt_rh_off)->wait);
+			free_page(alt_rh_off);
+		}
+	
 		DRM(free)( dev->dev_private, sizeof(drm_r128_private_t),
 			   DRM_MEM_DRIVER );
 		dev->dev_private = NULL;
diff -Nru a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
--- a/drivers/char/drm/radeon_cp.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm/radeon_cp.c	Fri Sep 27 13:24:23 2002
@@ -574,7 +574,7 @@
 static void radeon_cp_init_ring_buffer( drm_device_t *dev,
 				        drm_radeon_private_t *dev_priv )
 {
-	u32 ring_start, cur_read_ptr;
+	u32 ring_start, cur_read_ptr, rptr_addr;
 	u32 tmp;
 
 	/* Initialize the memory controller */
@@ -611,8 +611,24 @@
 	dev_priv->ring.tail = cur_read_ptr;
 
 	if ( !dev_priv->is_pci ) {
-		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
-			      dev_priv->ring_rptr->offset );
+		/*
+		 * 460GX doesn't claim PCI writes from the card into
+		 * the AGP aperture, so we have to get space outside
+		 * the aperture for RPTR_ADDR.
+		 */
+		if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off;
+
+			alt_rh_off = __get_free_page(GFP_KERNEL | GFP_DMA);
+			atomic_inc(&virt_to_page(alt_rh_off)->count);
+			set_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+
+			dev_priv->ring.head = (__volatile__ u32 *) alt_rh_off;
+			*dev_priv->ring.head = cur_read_ptr;
+			rptr_addr = __pa( dev_priv->ring.head );
+		} else
+			rptr_addr = dev_priv->ring_rptr->offset;
+		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR, rptr_addr );
 	} else {
 		drm_sg_mem_t *entry = dev->sg;
 		unsigned long tmp_ofs, page_ofs;
@@ -992,6 +1008,19 @@
 				DRM_ERROR( "failed to cleanup PCI GART!\n" );
 		}
 
+		/*
+		 * Free the page we grabbed for RPTR_ADDR
+		 */
+		if ( !dev_priv->is_pci && dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off =
+				(unsigned long) dev_priv->ring.head;
+
+			atomic_dec(&virt_to_page(alt_rh_off)->count);
+			clear_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+			wake_up(&virt_to_page(alt_rh_off)->wait);
+			free_page(alt_rh_off);
+		}
+	
 		DRM(free)( dev->dev_private, sizeof(drm_radeon_private_t),
 			   DRM_MEM_DRIVER );
 		dev->dev_private = NULL;
diff -Nru a/drivers/char/drm-4.0/agpsupport.c b/drivers/char/drm-4.0/agpsupport.c
--- a/drivers/char/drm-4.0/agpsupport.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm-4.0/agpsupport.c	Fri Sep 27 13:24:23 2002
@@ -265,6 +265,7 @@
 #if LINUX_VERSION_CODE >= 0x020400
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 #endif
+		case INTEL_460GX:	head->chipset = "Intel 460GX";	 break;
 
 		case VIA_GENERIC:	head->chipset = "VIA";           break;
 		case VIA_VP3:		head->chipset = "VIA VP3";       break;
diff -Nru a/drivers/char/drm-4.0/r128_cce.c b/drivers/char/drm-4.0/r128_cce.c
--- a/drivers/char/drm-4.0/r128_cce.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm-4.0/r128_cce.c	Fri Sep 27 13:24:23 2002
@@ -331,7 +344,7 @@
 static void r128_cce_init_ring_buffer( drm_device_t *dev )
 {
 	drm_r128_private_t *dev_priv = dev->dev_private;
-	u32 ring_start;
+	u32 ring_start, rptr_addr;
 	u32 tmp;
 
 	/* The manual (p. 2) says this address is in "VM space".  This
@@ -343,10 +356,27 @@
 	R128_WRITE( R128_PM4_BUFFER_DL_WPTR, 0 );
 	R128_WRITE( R128_PM4_BUFFER_DL_RPTR, 0 );
 
+	/*
+	 * 460GX doesn't claim PCI writes from the card into the AGP
+	 * aperture, so we have to get space outside the aperture for
+	 * RPTR_ADDR.
+	 */
+	if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+		unsigned long alt_rh_off;
+
+		alt_rh_off = __get_free_page(GFP_KERNEL | GFP_DMA);
+		atomic_inc(&virt_to_page(alt_rh_off)->count);
+		set_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+
+		dev_priv->ring.head = (__volatile__ u32 *) alt_rh_off;
+		rptr_addr = __pa( dev_priv->ring.head );
+	} else {
+		rptr_addr = dev_priv->ring_rptr->offset;
+	}
+
 	/* DL_RPTR_ADDR is a physical address in AGP space. */
 	*dev_priv->ring.head = 0;
-	R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
-		    dev_priv->ring_rptr->offset );
+	R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR, rptr_addr );
 
 	/* Set watermark control */
 	R128_WRITE( R128_PM4_BUFFER_WM_CNTL,
@@ -530,6 +560,19 @@
 			DO_REMAPFREE( dev_priv->agp_textures, dev );
 		}
 #endif
+
+		/*
+		 * Free the page we grabbed for RPTR_ADDR
+		 */
+		if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off =
+				(unsigned long) dev_priv->ring.head;
+
+			atomic_dec(&virt_to_page(alt_rh_off)->count);
+			clear_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+			wake_up(&virt_to_page(alt_rh_off)->wait);
+			free_page(alt_rh_off);
+		}
 
 		drm_free( dev->dev_private, sizeof(drm_r128_private_t),
 			  DRM_MEM_DRIVER );
diff -Nru a/drivers/char/drm-4.0/radeon_cp.c b/drivers/char/drm-4.0/radeon_cp.c
--- a/drivers/char/drm-4.0/radeon_cp.c	Fri Sep 27 13:24:23 2002
+++ b/drivers/char/drm-4.0/radeon_cp.c	Fri Sep 27 13:24:23 2002
@@ -570,7 +570,7 @@
 static void radeon_cp_init_ring_buffer( drm_device_t *dev )
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
-	u32 ring_start, cur_read_ptr;
+	u32 ring_start, cur_read_ptr, rptr_addr;
 	u32 tmp;
 
 	/* Initialize the memory controller */
@@ -593,10 +593,29 @@
 	/* Initialize the ring buffer's read and write pointers */
 	cur_read_ptr = RADEON_READ( RADEON_CP_RB_RPTR );
 	RADEON_WRITE( RADEON_CP_RB_WPTR, cur_read_ptr );
+
 	*dev_priv->ring.head = cur_read_ptr;
 	dev_priv->ring.tail = cur_read_ptr;
 
-	RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR, dev_priv->ring_rptr->offset );
+	/*
+	 * 460GX doesn't claim PCI writes from the card into the AGP
+	 * aperture, so we have to get space outside the aperture for
+	 * RPTR_ADDR.
+	 */
+	if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+		unsigned long alt_rh_off;
+
+		alt_rh_off = __get_free_page(GFP_KERNEL | GFP_DMA);
+		atomic_inc(&virt_to_page(alt_rh_off)->count);
+		set_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+
+		dev_priv->ring.head = (__volatile__ u32 *) alt_rh_off;
+		*dev_priv->ring.head = cur_read_ptr;
+		rptr_addr = __pa( dev_priv->ring.head );
+	} else
+		rptr_addr = dev_priv->ring_rptr->offset;
+
+	RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR, rptr_addr);
 
 	/* Set ring buffer size */
 	RADEON_WRITE( RADEON_CP_RB_CNTL, dev_priv->ring.size_l2qw );
@@ -837,6 +856,19 @@
 			DO_IOREMAPFREE( dev_priv->agp_textures, dev );
 		}
 #endif
+
+		/*
+		 * Free the page we grabbed for RPTR_ADDR.
+		 */
+		if ( dev->agp->agp_info.chipset == INTEL_460GX ) {
+			unsigned long alt_rh_off =
+				(unsigned long) dev_priv->ring.head;
+
+			atomic_dec(&virt_to_page(alt_rh_off)->count);
+			clear_bit(PG_locked, &virt_to_page(alt_rh_off)->flags);
+			wake_up(&virt_to_page(alt_rh_off)->wait);
+			free_page(alt_rh_off);
+		}
 
 		drm_free( dev->dev_private, sizeof(drm_radeon_private_t),
 			  DRM_MEM_DRIVER );
diff -Nru a/include/linux/agp_backend.h b/include/linux/agp_backend.h
--- a/include/linux/agp_backend.h	Fri Sep 27 13:24:23 2002
+++ b/include/linux/agp_backend.h	Fri Sep 27 13:24:23 2002
@@ -53,6 +53,7 @@
 	INTEL_I845,
 	INTEL_I850,
 	INTEL_I860,
+	INTEL_460GX,
 	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,
