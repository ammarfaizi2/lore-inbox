Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424844AbWLHG6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424844AbWLHG6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424858AbWLHG6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:58:17 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41957 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424844AbWLHG6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:58:16 -0500
Date: Fri, 8 Dec 2006 16:01:42 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: [RFC] [PATCH] virtual memmap on sparsemem v3 [1/4]  map and unmap
Message-Id: <20061208160142.d40cf636.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to map pages into the kernel space by vmalloc()'s routine,
we always need 'struct page' to do that.

There are cases where there is no page struct to use (bootstrap, etc..).
This function is designed to help map any memory to anywhere, anytime.

Users should manage their virtual/physical space by themselves.
Because it's complex and danger to manage virtual address space by
each function's own code, it's better to use fixed address.

Note: My first purpose is supporting virtual mem_map both at boot/hotplug
      sharing the same logic.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---
 include/linux/vmalloc.h |   36 ++++++++
 mm/vmalloc.c            |  200 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)

Index: devel-2.6.19/include/linux/vmalloc.h
===================================================================
--- devel-2.6.19.orig/include/linux/vmalloc.h	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/include/linux/vmalloc.h	2006-12-07 23:04:54.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/page.h>		/* pgprot_t */
+#include <asm/pgtable.h>	/* pud_t */
 
 struct vm_area_struct;
 
@@ -74,4 +75,39 @@
 extern rwlock_t vmlist_lock;
 extern struct vm_struct *vmlist;
 
+/*
+ * map kernel memory with callback routine. this function is designed
+ * for assisting special mappings in the kernel space, in other words,
+ * not managed by standard vmap calls.
+ * The caller has to be responsible to manage his own virtual address space.
+ *
+ * Bootstrap consideration:
+ * you can pass pud/pmd/pte alloc functions to map_generic_kernel().
+ * So you can use bootmem function or something to alloc page tables if
+ * necessary.
+ */
+
+struct gen_map_kern_ops {
+	/* must be defined */
+	int	(*k_pte_set)(pte_t *pte, unsigned long addr, void *data);
+	int	(*k_pte_clear)(pte_t *pte, unsigned long addr, void *data);
+	/* optional */
+	int 	(*k_pud_alloc)(pgd_t *pgd, unsigned long addr, void *data);
+	int 	(*k_pmd_alloc)(pud_t *pud, unsigned long addr, void *data);
+	int 	(*k_pte_alloc)(pmd_t *pmd, unsigned long addr, void *data);
+};
+
+/*
+ * call set_pte for specified address range.
+ */
+extern int map_generic_kernel(unsigned long addr, unsigned long size,
+			      struct gen_map_kern_ops *ops, void *data);
+/*
+ * call clear_pte() callback against all ptes found.
+ * pgtable itself is not freed.
+ */
+extern int unmap_generic_kernel(unsigned long addr, unsigned long size,
+				struct gen_map_kern_ops *ops, void *data);
+
+
 #endif /* _LINUX_VMALLOC_H */
Index: devel-2.6.19/mm/vmalloc.c
===================================================================
--- devel-2.6.19.orig/mm/vmalloc.c	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/mm/vmalloc.c	2006-12-06 16:33:41.000000000 +0900
@@ -747,3 +747,203 @@
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
+
+
+/*
+ * Geneoric VM mapper for kernel routines.
+ * Can be used even in bootstrap (before memory is availabe) if callback
+ * func support it.
+ * for usual use, please use vmalloc/vfree/map_vm_ara/unmap_vm_area.
+ */
+
+static int map_generic_pte_range(pmd_t *pmd, unsigned long addr,
+				 unsigned long end,
+				 struct gen_map_kern_ops *ops, void *data)
+{
+	pte_t *pte;
+	int ret = 0;
+	unsigned long next;
+	if (!pmd_present(*pmd)) {
+		if (ops->k_pte_alloc) {
+			ret = ops->k_pte_alloc(pmd, addr, data);
+			if (ret)
+				return ret;
+		} else {
+			pte = pte_alloc_kernel(pmd, addr);
+			if (!pte)
+				return -ENOMEM;
+		}
+	}
+	pte = pte_offset_kernel(pmd, addr);
+
+	do {
+		WARN_ON(!pte_none(*pte));
+		BUG_ON(!ops->k_pte_set);
+		ret = ops->k_pte_set(pte, addr, data);
+		if (ret)
+			break;
+		next = addr + PAGE_SIZE;
+	} while (pte++, addr = next, addr != end);
+	return ret;
+}
+
+static int map_generic_pmd_range(pud_t *pud, unsigned long addr,
+				 unsigned long end,
+				 struct gen_map_kern_ops *ops, void *data)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	int ret;
+
+	if (pud_none(*pud)) {
+		if (ops->k_pmd_alloc) {
+			ret = ops->k_pmd_alloc(pud, addr, data);
+			if (ret)
+				return ret;
+		} else {
+			pmd = pmd_alloc(&init_mm, pud, addr);
+			if (!pmd)
+				return -ENOMEM;
+		}
+	}
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		ret = map_generic_pte_range(pmd, addr, next, ops, data);
+		if (ret)
+			break;
+	} while (pmd++, addr = next, addr != end);
+	return ret;
+}
+
+static int map_generic_pud_range(pgd_t *pgd, unsigned long addr,
+				 unsigned long end,
+				 struct gen_map_kern_ops *ops, void *data)
+{
+	pud_t *pud;
+	unsigned long next;
+	int ret;
+	if (pgd_none(*pgd)) {
+		if (ops->k_pud_alloc) {
+			ret = ops->k_pud_alloc(pgd, addr, data);
+			if (ret)
+				return ret;
+		} else {
+			pud = pud_alloc(&init_mm, pgd, addr);
+			if (!pud)
+				return -ENOMEM;
+		}
+	}
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		ret = map_generic_pmd_range(pud, addr, next, ops, data);
+		if (ret)
+			break;
+		
+	} while (pud++, addr = next, addr != end);
+	return ret;
+}
+
+int map_generic_kernel(unsigned long addr, unsigned long size,
+		       struct gen_map_kern_ops *ops, void *data)
+{
+	pgd_t *pgd;
+	unsigned long end = addr + size;
+	unsigned long next;
+	int ret;
+
+	do {
+		pgd = pgd_offset_k(addr);
+		next = pgd_addr_end(addr, end);
+		ret = map_generic_pud_range(pgd, addr, next, ops, data);
+		if (ret)
+			break;
+		
+	} while (addr = next, addr != end);
+	flush_cache_vmap(addr, end);
+	return ret;
+}
+
+static int
+unmap_generic_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			struct gen_map_kern_ops *ops, void *data)
+{
+	pte_t *pte;
+	int err = 0;
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		if (!pte_present(*pte))
+			continue;
+		err = ops->k_pte_clear(pte, addr, data);
+		if (err)
+			break;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return err;
+}
+
+static int
+unmap_generic_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+			struct gen_map_kern_ops *ops, void *data)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	int err = 0;
+
+	pmd = pmd_offset(pud, addr);
+	
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		err = unmap_generic_pte_range(pmd, addr, next, ops, data);
+		if (err)
+			break;
+	} while (pmd++, addr = next, addr != end);
+	return err;
+}
+
+static int
+unmap_generic_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+			struct gen_map_kern_ops *ops, void *data)
+{
+	pud_t *pud;
+	unsigned long next;
+	int err = 0;
+
+	pud = pud_offset(pgd, addr);
+	
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		err = unmap_generic_pmd_range(pud, addr, next, ops, data);
+		if (err)
+			break;
+	} while (pud++, addr = next, addr != end);
+	return err;
+}
+
+int unmap_generic_kernel(unsigned long addr, unsigned long size,
+			 struct gen_map_kern_ops *ops, void *data)
+{
+	unsigned long next, end;
+	pgd_t *pgd;
+	int err = 0;
+
+	end = addr + size;
+	flush_cache_vmap(addr, end);
+
+	pgd = pgd_offset_k(addr);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		err = unmap_generic_pud_range(pgd, addr, next, ops, data);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+	flush_tlb_kernel_range((unsigned long)start_addr, end_addr);
+	return err;
+}

