Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVLMX4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVLMX4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVLMX4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:56:35 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:20938 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030328AbVLMX4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:56:33 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Tony Luck <tony.luck@intel.com>
Subject: [patch 2/2] /dev/mem validate mmap requests
Date: Tue, 13 Dec 2005 16:56:26 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131656.26722.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Tony, can you ack/nak this please?  It touches both ia64 and generic
code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

 arch/ia64/kernel/efi.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/mem.c     |   14 ++++++++++++--
 include/asm-ia64/io.h  |    1 +
 3 files changed, 57 insertions(+), 2 deletions(-)

Index: work5/arch/ia64/kernel/efi.c
===================================================================
--- work5.orig/arch/ia64/kernel/efi.c	2005-12-09 16:17:50.000000000 -0700
+++ work5/arch/ia64/kernel/efi.c	2005-12-09 16:28:58.000000000 -0700
@@ -636,6 +636,10 @@
 }
 EXPORT_SYMBOL(efi_mem_attributes);
 
+/*
+ * We only allow /dev/mem read & write system calls to write-back memory,
+ * because read & write don't allow the user to control access size.
+ */
 int
 valid_phys_addr_range (unsigned long phys_addr, unsigned long *size)
 {
@@ -662,6 +666,46 @@
 	return 0;
 }
 
+/*
+ * Anything in the EFI memory map can be accessed via /dev/mem mmap.
+ * This may have to be extended eventually for memory hot-plug.
+ */
+int
+valid_mmap_phys_addr_range (unsigned long phys_addr, unsigned long *size)
+{
+	void *efi_map_start, *efi_map_end, *p;
+	efi_memory_desc_t *md;
+	u64 efi_desc_size;
+	int mmio_found = 0;
+
+	efi_map_start = __va(ia64_boot_param->efi_memmap);
+	efi_map_end   = efi_map_start + ia64_boot_param->efi_memmap_size;
+	efi_desc_size = ia64_boot_param->efi_memdesc_size;
+
+	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
+		md = p;
+
+		if (md->type == EFI_MEMORY_MAPPED_IO)
+			mmio_found = 1;
+
+		if (phys_addr - md->phys_addr < (md->num_pages << EFI_PAGE_SHIFT)) {
+			if (*size > md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr)
+				*size = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr;
+			return 1;
+		}
+	}
+
+	/*
+	 * Some firmware doesn't report MMIO regions in the EFI memory map.
+	 * The Intel BigSur (a.k.a. HP i2000) has this problem.  In this
+	 * case, we can't rely on the map to validate mmap requests.
+	 */
+	if (!mmio_found)
+		return 1;
+
+	return 0;
+}
+
 int __init
 efi_uart_console_only(void)
 {
Index: work5/drivers/char/mem.c
===================================================================
--- work5.orig/drivers/char/mem.c	2005-12-09 16:24:07.000000000 -0700
+++ work5/drivers/char/mem.c	2005-12-09 16:33:10.000000000 -0700
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
Index: work5/include/asm-ia64/io.h
===================================================================
--- work5.orig/include/asm-ia64/io.h	2005-12-09 16:17:50.000000000 -0700
+++ work5/include/asm-ia64/io.h	2005-12-09 16:28:58.000000000 -0700
@@ -89,6 +89,7 @@
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range (unsigned long addr, size_t *count); /* efi.c */
+extern int valid_mmap_phys_addr_range (unsigned long addr, size_t *count);
 
 /*
  * The following two macros are deprecated and scheduled for removal.
