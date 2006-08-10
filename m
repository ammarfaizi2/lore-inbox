Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161377AbWHJQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377AbWHJQEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161375AbWHJQEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:14 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:34536 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161360AbWHJQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:11 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/14] Generic ioremap_page_range: implementation
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:33 +0200
Message-Id: <1155225827754-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1155225826761-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic implementation of ioremap_page_range() in
lib/ioremap.c based on the i386 implementation. It differs from the
i386 version in the following ways:

  * The PTE flags are passed as a pgprot_t argument and must be
    determined up front by the arch-specific code. No additional
    PTE flags are added.
  * Uses set_pte_at() instead of set_pte()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/linux/io.h |    4 ++
 lib/Makefile       |    2 +
 lib/ioremap.c      |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 420e2fd..aa3f5af 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -19,8 +19,12 @@ #ifndef _LINUX_IO_H
 #define _LINUX_IO_H
 
 #include <asm/io.h>
+#include <asm/page.h>
 
 void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
+int ioremap_page_range(unsigned long addr, unsigned long end,
+		       unsigned long phys_addr, pgprot_t prot);
+
 #endif /* _LINUX_IO_H */
diff --git a/lib/Makefile b/lib/Makefile
index be9719a..a4dcb07 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o ioremap.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
diff --git a/lib/ioremap.c b/lib/ioremap.c
new file mode 100644
index 0000000..6419101
--- /dev/null
+++ b/lib/ioremap.c
@@ -0,0 +1,93 @@
+/*
+ * Re-map IO memory to kernel address space so that we can access it.
+ * This is needed for high PCI addresses that aren't mapped in the
+ * 640k-1MB IO memory area on PC's
+ *
+ * (C) Copyright 1995 1996 Linus Torvalds
+ */
+#include <linux/io.h>
+#include <linux/vmalloc.h>
+
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+
+static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pte_t *pte;
+	unsigned long pfn;
+
+	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel(pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		BUG_ON(!pte_none(*pte));
+		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+		pfn++;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	phys_addr -= addr;
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int ioremap_pud_range(pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	phys_addr -= addr;
+	pud = pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+int ioremap_page_range(unsigned long addr,
+		       unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pgd_t *pgd;
+	unsigned long start;
+	unsigned long next;
+	int err;
+
+	BUG_ON(addr >= end);
+
+	flush_cache_all();
+
+	start = addr;
+	phys_addr -= addr;
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, prot);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+
+	flush_tlb_all();
+
+	return err;
+}
-- 
1.4.0

