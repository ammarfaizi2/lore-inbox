Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWASUM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWASUM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161397AbWASUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:12:55 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:59783 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1161389AbWASUMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:12:48 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 2/5] ia64: ioremap: check EFI for valid memory attributes
Date: Thu, 19 Jan 2006 13:12:44 -0700
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
Message-Id: <200601191312.44564.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the EFI memory map so we can use the correct memory attributes
for ioremap().  Previously, we always used uncacheable access, which
blows up on some machines for regular system memory.

Depends on the previous efi_mem_attribute_range() patch.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/arch/ia64/mm/ioremap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work-mm3/arch/ia64/mm/ioremap.c	2006-01-18 17:04:42.000000000 -0700
@@ -0,0 +1,40 @@
+/*
+ * (c) Copyright 2006 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/compiler.h>
+#include <linux/efi.h>
+#include <asm/io.h>
+
+static inline void __iomem *
+__ioremap (unsigned long offset, unsigned long size)
+{
+	return (void __iomem *) (__IA64_UNCACHED_OFFSET | offset);
+}
+
+void __iomem *
+ioremap (unsigned long offset, unsigned long size)
+{
+	if (efi_mem_attribute_range(offset, size, EFI_MEMORY_UC))
+		return __ioremap(offset, size);
+
+	if (efi_mem_attribute_range(offset, size, EFI_MEMORY_WB))
+		return phys_to_virt(offset);
+
+	/*
+	 * Someday this should check ACPI resources so we
+	 * can do the right thing for hot-plugged regions.
+	 */
+	return __ioremap(offset, size);
+}
+
+void __iomem *
+ioremap_nocache (unsigned long offset, unsigned long size)
+{
+	return __ioremap(offset, size);
+}
Index: work-mm3/include/asm-ia64/io.h
===================================================================
--- work-mm3.orig/include/asm-ia64/io.h	2006-01-18 13:33:06.000000000 -0700
+++ work-mm3/include/asm-ia64/io.h	2006-01-18 16:50:54.000000000 -0700
@@ -416,25 +416,14 @@
 # define outl_p		outl
 #endif
 
-/*
- * An "address" in IO memory space is not clearly either an integer or a pointer. We will
- * accept both, thus the casts.
- *
- * On ia-64, we access the physical I/O memory space through the uncached kernel region.
- */
-static inline void __iomem *
-ioremap (unsigned long offset, unsigned long size)
-{
-	return (void __iomem *) (__IA64_UNCACHED_OFFSET | (offset));
-}
+extern void __iomem * ioremap(unsigned long offset, unsigned long size);
+extern void __iomem * ioremap_nocache (unsigned long offset, unsigned long size);
 
 static inline void
 iounmap (volatile void __iomem *addr)
 {
 }
 
-#define ioremap_nocache(o,s)	ioremap(o,s)
-
 /* Use normal IO mappings for DMI */
 #define dmi_ioremap ioremap
 #define dmi_iounmap(x,l) iounmap(x)
Index: work-mm3/arch/ia64/mm/Makefile
===================================================================
--- work-mm3.orig/arch/ia64/mm/Makefile	2006-01-18 13:33:06.000000000 -0700
+++ work-mm3/arch/ia64/mm/Makefile	2006-01-18 13:33:34.000000000 -0700
@@ -2,7 +2,7 @@
 # Makefile for the ia64-specific parts of the memory manager.
 #
 
-obj-y := init.o fault.o tlb.o extable.o
+obj-y := init.o fault.o tlb.o extable.o ioremap.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_NUMA)	   += numa.o
