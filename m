Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbVLFAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbVLFAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVLFAA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:00:26 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:62103 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751503AbVLFAAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:00:25 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] /dev/mem validate mmap requests
Date: Mon, 5 Dec 2005 17:00:20 -0700
User-Agent: KMail/1.8.2
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051700.20269.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hook so architectures can validate /dev/mem mmap requests.

This is analogous to validation we already perform in the read/write
paths.

The identity mapping scheme used on ia64 requires that each 16MB or
64MB granule be accessed with exactly one attribute (write-back or
uncacheable).  This avoids "attribute aliasing", which can cause a
machine check.

Sample problem scenario:  Machine supports VGA, so it has an uncacheable
MMIO hole at 640K, which requires that we use UC mappings for the entire
0-16MB granule.  An application (e.g., "hwinfo", which grubs around for
BIOS details) that mmaps the write-back memory in that granule gets a UC
mapping.  Some chipsets do not support UC access to WB memory and raise
a machine check.

Note: this depends on the previous __HAVE_PHYS_MEM_ACCESS_PROT tidy-up.

Tony, please ack/nak so this can go in via akpm.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

 arch/ia64/kernel/efi.c |   31 +++++++++++++++++++++++++++++++
 drivers/char/mem.c     |   14 +++++++++++---
 include/asm-ia64/io.h  |    1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

Index: work4/arch/ia64/kernel/efi.c
===================================================================
--- work4.orig/arch/ia64/kernel/efi.c	2005-12-02 15:40:12.000000000 -0700
+++ work4/arch/ia64/kernel/efi.c	2005-12-05 15:50:52.000000000 -0700
@@ -792,6 +792,10 @@
 }
 EXPORT_SYMBOL(efi_mem_attributes);
 
+/*
+ * We only allow /dev/mem read & write system calls to write-back memory,
+ * because read & write don't allow the user to control access size.
+ */
 int
 valid_phys_addr_range (unsigned long phys_addr, unsigned long *size)
 {
@@ -818,6 +822,33 @@
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
+
+	efi_map_start = __va(ia64_boot_param->efi_memmap);
+	efi_map_end   = efi_map_start + ia64_boot_param->efi_memmap_size;
+	efi_desc_size = ia64_boot_param->efi_memdesc_size;
+
+	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
+		md = p;
+
+		if (phys_addr - md->phys_addr < (md->num_pages << EFI_PAGE_SHIFT)) {
+			if (*size > md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr)
+				*size = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int __init
 efi_uart_console_only(void)
 {
Index: work4/drivers/char/mem.c
===================================================================
--- work4.orig/drivers/char/mem.c	2005-12-02 15:40:35.000000000 -0700
+++ work4/drivers/char/mem.c	2005-12-05 15:49:46.000000000 -0700
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
@@ -243,16 +248,19 @@
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	size_t size = vma->vm_end - vma->vm_start;
+
+	if (!valid_mmap_phys_addr_range(offset, &size))
+		return -EINVAL;
 
-	vma->vm_page_prot = phys_mem_access_prot(file, offset,
-						 vma->vm_end - vma->vm_start,
+	vma->vm_page_prot = phys_mem_access_prot(file, offset, size,
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
Index: work4/include/asm-ia64/io.h
===================================================================
--- work4.orig/include/asm-ia64/io.h	2005-10-12 14:27:18.000000000 -0600
+++ work4/include/asm-ia64/io.h	2005-12-02 15:42:15.000000000 -0700
@@ -89,6 +89,7 @@
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range (unsigned long addr, size_t *count); /* efi.c */
+extern int valid_mmap_phys_addr_range (unsigned long addr, size_t *count);
 
 /*
  * The following two macros are deprecated and scheduled for removal.
