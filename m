Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTJWVMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJWVMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:12:52 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:23955 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261796AbTJWVMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:12:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: David Mosberger <davidm@hpl.hp.com>
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Date: Thu, 23 Oct 2003 15:05:34 -0600
User-Agent: KMail/1.5.3
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org> <200310201142.26676.bjorn.helgaas@hp.com>
In-Reply-To: <200310201142.26676.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310231505.34320.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/char/mem.c change was accepted, so here's the
ia64-specific part.

===== arch/ia64/kernel/efi.c 1.26 vs edited =====
--- 1.26/arch/ia64/kernel/efi.c	Tue Oct 21 18:52:48 2003
+++ edited/arch/ia64/kernel/efi.c	Thu Oct 23 14:35:08 2003
@@ -711,6 +711,32 @@
 	return 0;
 }
 
+int
+valid_phys_addr_range (unsigned long phys_addr, unsigned long *size)
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
+			if (!(md->attribute & EFI_MEMORY_WB))
+				return 0;
+
+			if (*size > md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr)
+				*size = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - phys_addr;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static void __exit
 efivars_exit (void)
 {
===== include/asm-ia64/io.h 1.17 vs edited =====
--- 1.17/include/asm-ia64/io.h	Wed Aug 20 00:13:39 2003
+++ edited/include/asm-ia64/io.h	Thu Oct 23 14:32:42 2003
@@ -72,6 +72,9 @@
 	return (void *) (address + PAGE_OFFSET);
 }
 
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range (unsigned long addr, size_t *count); /* efi.c */
+
 /*
  * The following two macros are deprecated and scheduled for removal.
  * Please use the PCI-DMA interface defined in <asm/pci.h> instead.

