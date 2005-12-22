Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVLVVtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVLVVtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVLVVtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:49:19 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:36333 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030327AbVLVVtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:49:18 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2/2] /dev/mem validate mmap requests
Date: Thu, 22 Dec 2005 14:49:10 -0700
User-Agent: KMail/1.8.3
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0531E4BB@scsmsx401.amr.corp.intel.com> <20051215220640.GA8967@agluck-lia64.sc.intel.com> <200512201353.51236.bjorn.helgaas@hp.com>
In-Reply-To: <200512201353.51236.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221449.10457.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you replace dev-mem-validate-mmap-requests.patch
with the patch below?  This addresses Tony's request that
the checking handle regions that span EFI memory descriptors.




Add a hook so architectures can validate /dev/mem mmap requests.

This is analogous to validation we already perform in the read/write
paths.

The identity mapping scheme used on ia64 requires that each 16MB or
64MB granule be accessed with exactly one attribute (write-back or
uncacheable).  This avoids "attribute aliasing", which can cause a
machine check.

Sample problem scenario:
  - Machine supports VGA, so it has uncacheable (UC) MMIO at 640K-768K
  - efi_memmap_init() discards any write-back (WB) memory in the first granule
  - Application (e.g., "hwinfo") mmaps /dev/mem, offset 0
  - hwinfo receives UC mapping (the default, since memmap says "no WB here")
  - Machine check abort (on chipsets that don't support UC access to WB
    memory, e.g., sx1000)

In the scenario above, the only choices are
  - Use WB for hwinfo mmap.  Can't do this because it causes attribute
    aliasing with the UC mapping for the VGA MMIO space.
  - Use UC for hwinfo mmap.  Can't do this because the chipset may not
    support UC for that region.
  - Disallow the hwinfo mmap with -EINVAL.  That's what this patch does.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

 arch/ia64/kernel/efi.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/mem.c     |   14 ++++++++++++--
 include/asm-ia64/io.h  |    1 +
 3 files changed, 57 insertions(+), 2 deletions(-)

Index: work6/arch/ia64/kernel/efi.c
===================================================================
--- work6.orig/arch/ia64/kernel/efi.c	2005-12-19 12:50:52.000000000 -0700
+++ work6/arch/ia64/kernel/efi.c	2005-12-20 10:32:49.000000000 -0700
@@ -247,6 +247,32 @@
 
 static kern_memdesc_t *kern_memmap;
 
+#define efi_md_size(md)	(md->num_pages << EFI_PAGE_SHIFT)
+
+static inline u64
+kmd_end(kern_memdesc_t *kmd)
+{
+	return (kmd->start + (kmd->num_pages << EFI_PAGE_SHIFT));
+}
+
+static inline u64
+efi_md_end(efi_memory_desc_t *md)
+{
+	return (md->phys_addr + efi_md_size(md));
+}
+
+static inline int
+efi_wb(efi_memory_desc_t *md)
+{
+	return (md->attribute & EFI_MEMORY_WB);
+}
+
+static inline int
+efi_uc(efi_memory_desc_t *md)
+{
+	return (md->attribute & EFI_MEMORY_UC);
+}
+
 static void
 walk (efi_freemem_callback_t callback, void *arg, u64 attr)
 {
@@ -595,8 +621,8 @@
 	return 0;
 }
 
-u32
-efi_mem_type (unsigned long phys_addr)
+static efi_memory_desc_t *
+efi_memory_descriptor (unsigned long phys_addr)
 {
 	void *efi_map_start, *efi_map_end, *p;
 	efi_memory_desc_t *md;
@@ -610,13 +636,13 @@
 		md = p;
 
 		if (phys_addr - md->phys_addr < (md->num_pages << EFI_PAGE_SHIFT))
-			 return md->type;
+			 return md;
 	}
 	return 0;
 }
 
-u64
-efi_mem_attributes (unsigned long phys_addr)
+static int
+efi_memmap_has_mmio (void)
 {
 	void *efi_map_start, *efi_map_end, *p;
 	efi_memory_desc_t *md;
@@ -629,36 +655,98 @@
 	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
 		md = p;
 
-		if (phys_addr - md->phys_addr < (md->num_pages << EFI_PAGE_SHIFT))
-			return md->attribute;
+		if (md->type == EFI_MEMORY_MAPPED_IO)
+			return 1;
 	}
 	return 0;
 }
+
+u32
+efi_mem_type (unsigned long phys_addr)
+{
+	efi_memory_desc_t *md = efi_memory_descriptor(phys_addr);
+
+	if (md)
+		return md->type;
+	return 0;
+}
+
+u64
+efi_mem_attributes (unsigned long phys_addr)
+{
+	efi_memory_desc_t *md = efi_memory_descriptor(phys_addr);
+
+	if (md)
+		return md->attribute;
+	return 0;
+}
 EXPORT_SYMBOL(efi_mem_attributes);
 
+/*
+ * Determines whether the memory at phys_addr supports the desired
+ * attribute (WB, UC, etc).  If this returns 1, the caller can safely
+ * access *size bytes at phys_addr with the specified attribute.
+ */
+static int
+efi_mem_attribute_range (unsigned long phys_addr, unsigned long *size, u64 attr)
+{
+	efi_memory_desc_t *md = efi_memory_descriptor(phys_addr);
+	unsigned long md_end;
+
+	if (!md || (md->attribute & attr) != attr)
+		return 0;
+
+	do {
+		md_end = efi_md_end(md);
+		if (phys_addr + *size <= md_end)
+			return 1;
+
+		md = efi_memory_descriptor(md_end);
+		if (!md || (md->attribute & attr) != attr) {
+			*size = md_end - phys_addr;
+			return 1;
+		}
+	} while (md);
+	return 0;
+}
+
+/*
+ * For /dev/mem, we only allow read & write system calls to access
+ * write-back memory, because read & write don't allow the user to
+ * control access size.
+ */
 int
 valid_phys_addr_range (unsigned long phys_addr, unsigned long *size)
 {
-	void *efi_map_start, *efi_map_end, *p;
-	efi_memory_desc_t *md;
-	u64 efi_desc_size;
+	return efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_WB);
+}
 
-	efi_map_start = __va(ia64_boot_param->efi_memmap);
-	efi_map_end   = efi_map_start + ia64_boot_param->efi_memmap_size;
-	efi_desc_size = ia64_boot_param->efi_memdesc_size;
+/*
+ * We allow mmap of anything in the EFI memory map that supports
+ * either write-back or uncacheable access.  For uncacheable regions,
+ * the supported access sizes are system-dependent, and the user is
+ * responsible for using the correct size.
+ *
+ * Note that this doesn't currently allow access to hot-added memory,
+ * because that doesn't appear in the boot-time EFI memory map.
+ */
+int
+valid_mmap_phys_addr_range (unsigned long phys_addr, unsigned long *size)
+{
+	if (efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_WB))
+		return 1;
 
-	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
-		md = p;
+	if (efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_UC))
+		return 1;
 
-		if (phys_addr - md->phys_addr < (md->num_pages << EFI_PAGE_SHIFT)) {
-			if (!(md->attribute & EFI_MEMORY_WB))
-				return 0;
+	/*
+	 * Some firmware doesn't report MMIO regions in the EFI memory map.
+	 * The Intel BigSur (a.k.a. HP i2000) has this problem.  In this
+	 * case, we can't use the EFI memory map to validate mmap requests.
+	 */
+	if (!efi_memmap_has_mmio())
+		return 1;
 
-			if (*size > md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr)
-				*size = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr;
-			return 1;
-		}
-	}
 	return 0;
 }
 
@@ -707,32 +795,6 @@
 	return 0;
 }
 
-#define efi_md_size(md)	(md->num_pages << EFI_PAGE_SHIFT)
-
-static inline u64
-kmd_end(kern_memdesc_t *kmd)
-{
-	return (kmd->start + (kmd->num_pages << EFI_PAGE_SHIFT));
-}
-
-static inline u64
-efi_md_end(efi_memory_desc_t *md)
-{
-	return (md->phys_addr + efi_md_size(md));
-}
-
-static inline int
-efi_wb(efi_memory_desc_t *md)
-{
-	return (md->attribute & EFI_MEMORY_WB);
-}
-
-static inline int
-efi_uc(efi_memory_desc_t *md)
-{
-	return (md->attribute & EFI_MEMORY_UC);
-}
-
 /*
  * Look for the first granule aligned memory descriptor memory
  * that is big enough to hold EFI memory map. Make sure this
Index: work6/drivers/char/mem.c
===================================================================
--- work6.orig/drivers/char/mem.c	2005-12-19 12:50:52.000000000 -0700
+++ work6/drivers/char/mem.c	2005-12-20 10:32:49.000000000 -0700
@@ -101,6 +101,11 @@
 
 	return 1;
 }
+
+static inline int valid_mmap_phys_addr_range(unsigned long addr, size_t *size)
+{
+	return 1;
+}
 #endif
 
 /*
@@ -244,15 +249,20 @@
 
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
+	size_t size = vma->vm_end - vma->vm_start;
+
+	if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, &size))
+		return -EINVAL;
+
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
-						 vma->vm_end - vma->vm_start,
+						 size,
 						 vma->vm_page_prot);
 
 	/* Remap-pfn-range will mark the range VM_IO and VM_RESERVED */
 	if (remap_pfn_range(vma,
 			    vma->vm_start,
 			    vma->vm_pgoff,
-			    vma->vm_end-vma->vm_start,
+			    size,
 			    vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
Index: work6/include/asm-ia64/io.h
===================================================================
--- work6.orig/include/asm-ia64/io.h	2005-12-19 12:50:52.000000000 -0700
+++ work6/include/asm-ia64/io.h	2005-12-20 10:32:49.000000000 -0700
@@ -89,6 +89,7 @@
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range (unsigned long addr, size_t *count); /* efi.c */
+extern int valid_mmap_phys_addr_range (unsigned long addr, size_t *count);
 
 /*
  * The following two macros are deprecated and scheduled for removal.
