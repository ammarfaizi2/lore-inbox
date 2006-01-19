Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161392AbWASUMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbWASUMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWASUMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:12:25 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:19677 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161384AbWASUMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:12:22 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 1/5] EFI, /dev/mem: simplify efi_mem_attribute_range()
Date: Thu, 19 Jan 2006 13:12:18 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060118181116.GA5537@lists.us.dell.com> <200601191310.57303.bjorn.helgaas@hp.com>
In-Reply-To: <200601191310.57303.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191312.19027.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the size, not a pointer to the size, to efi_mem_attribute_range().

This function validates memory regions for the /dev/mem read/write/mmap
paths.  The pointer allows arches to reduce the size of the range, but
I think that's unnecessary complexity.  Simplifying it will let me use
efi_mem_attribute_range() to improve the ia64 ioremap() implementation.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/arch/ia64/kernel/efi.c
===================================================================
--- work-mm3.orig/arch/ia64/kernel/efi.c	2006-01-18 13:25:29.000000000 -0700
+++ work-mm3/arch/ia64/kernel/efi.c	2006-01-18 13:27:18.000000000 -0700
@@ -685,27 +685,34 @@
 /*
  * Determines whether the memory at phys_addr supports the desired
  * attribute (WB, UC, etc).  If this returns 1, the caller can safely
- * access *size bytes at phys_addr with the specified attribute.
+ * access size bytes at phys_addr with the specified attribute.
  */
-static int
-efi_mem_attribute_range (unsigned long phys_addr, unsigned long *size, u64 attr)
+int
+efi_mem_attribute_range (unsigned long phys_addr, unsigned long size, u64 attr)
 {
+	unsigned long end = phys_addr + size;
 	efi_memory_desc_t *md = efi_memory_descriptor(phys_addr);
-	unsigned long md_end;
 
-	if (!md || (md->attribute & attr) != attr)
+	/*
+	 * Some firmware doesn't report MMIO regions in the EFI memory
+	 * map.  The Intel BigSur (a.k.a. HP i2000) has this problem.
+	 * On those platforms, we have to assume UC is valid everywhere.
+	 */
+	if (!md || (md->attribute & attr) != attr) {
+		if (attr == EFI_MEMORY_UC && !efi_memmap_has_mmio())
+			return 1;
 		return 0;
+	}
 
 	do {
-		md_end = efi_md_end(md);
-		if (phys_addr + *size <= md_end)
+		unsigned long md_end = efi_md_end(md);
+
+		if (end <= md_end)
 			return 1;
 
 		md = efi_memory_descriptor(md_end);
-		if (!md || (md->attribute & attr) != attr) {
-			*size = md_end - phys_addr;
-			return 1;
-		}
+		if (!md || (md->attribute & attr) != attr)
+			return 0;
 	} while (md);
 	return 0;
 }
@@ -716,7 +723,7 @@
  * control access size.
  */
 int
-valid_phys_addr_range (unsigned long phys_addr, unsigned long *size)
+valid_phys_addr_range (unsigned long phys_addr, unsigned long size)
 {
 	return efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_WB);
 }
@@ -731,7 +738,7 @@
  * because that doesn't appear in the boot-time EFI memory map.
  */
 int
-valid_mmap_phys_addr_range (unsigned long phys_addr, unsigned long *size)
+valid_mmap_phys_addr_range (unsigned long phys_addr, unsigned long size)
 {
 	if (efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_WB))
 		return 1;
@@ -739,14 +746,6 @@
 	if (efi_mem_attribute_range(phys_addr, size, EFI_MEMORY_UC))
 		return 1;
 
-	/*
-	 * Some firmware doesn't report MMIO regions in the EFI memory map.
-	 * The Intel BigSur (a.k.a. HP i2000) has this problem.  In this
-	 * case, we can't use the EFI memory map to validate mmap requests.
-	 */
-	if (!efi_memmap_has_mmio())
-		return 1;
-
 	return 0;
 }
 
Index: work-mm3/drivers/char/mem.c
===================================================================
--- work-mm3.orig/drivers/char/mem.c	2006-01-18 13:25:27.000000000 -0700
+++ work-mm3/drivers/char/mem.c	2006-01-18 13:27:18.000000000 -0700
@@ -88,21 +88,15 @@
 }
 
 #ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
-static inline int valid_phys_addr_range(unsigned long addr, size_t *count)
+static inline int valid_phys_addr_range(unsigned long addr, size_t count)
 {
-	unsigned long end_mem;
-
-	end_mem = __pa(high_memory);
-	if (addr >= end_mem)
+	if (addr + count > __pa(high_memory))
 		return 0;
 
-	if (*count > end_mem - addr)
-		*count = end_mem - addr;
-
 	return 1;
 }
 
-static inline int valid_mmap_phys_addr_range(unsigned long addr, size_t *size)
+static inline int valid_mmap_phys_addr_range(unsigned long addr, size_t size)
 {
 	return 1;
 }
@@ -119,7 +113,7 @@
 	ssize_t read, sz;
 	char *ptr;
 
-	if (!valid_phys_addr_range(p, &count))
+	if (!valid_phys_addr_range(p, count))
 		return -EFAULT;
 	read = 0;
 #ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
@@ -177,7 +171,7 @@
 	unsigned long copied;
 	void *ptr;
 
-	if (!valid_phys_addr_range(p, &count))
+	if (!valid_phys_addr_range(p, count))
 		return -EFAULT;
 
 	written = 0;
@@ -251,7 +245,7 @@
 {
 	size_t size = vma->vm_end - vma->vm_start;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, &size))
+	if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, size))
 		return -EINVAL;
 
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
Index: work-mm3/include/asm-ia64/io.h
===================================================================
--- work-mm3.orig/include/asm-ia64/io.h	2006-01-18 13:25:27.000000000 -0700
+++ work-mm3/include/asm-ia64/io.h	2006-01-18 13:27:18.000000000 -0700
@@ -88,8 +88,8 @@
 }
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
-extern int valid_phys_addr_range (unsigned long addr, size_t *count); /* efi.c */
-extern int valid_mmap_phys_addr_range (unsigned long addr, size_t *count);
+extern int valid_phys_addr_range (unsigned long addr, size_t count); /* efi.c */
+extern int valid_mmap_phys_addr_range (unsigned long addr, size_t count);
 
 /*
  * The following two macros are deprecated and scheduled for removal.
Index: work-mm3/include/linux/efi.h
===================================================================
--- work-mm3.orig/include/linux/efi.h	2006-01-18 13:25:27.000000000 -0700
+++ work-mm3/include/linux/efi.h	2006-01-18 13:27:18.000000000 -0700
@@ -292,6 +292,8 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int efi_mem_attribute_range (unsigned long phys_addr, unsigned long size,
+				    u64 attr);
 extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
