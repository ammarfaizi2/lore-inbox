Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVDZQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVDZQES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDZQER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:04:17 -0400
Received: from mailgate.quadrics.com ([194.202.174.11]:19344 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S261636AbVDZP4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:56:36 -0400
Message-ID: <426E62ED.5090803@quadrics.com>
Date: Tue, 26 Apr 2005 16:49:01 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
Content-Type: multipart/mixed;
 boundary="------------070806030407050808080605"
X-OriginalArrivalTime: 26 Apr 2005 15:43:03.0296 (UTC) FILETIME=[A1E98800:01C54A76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070806030407050808080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

here is a patch we use to integrate the Quadrics NICs into the Linux kernel.
The patch adds hooks to the Linux VM subsystem so that registered 'IOPROC'
devices can be informed of page table changes.
This allows the Quadrics NICs to perform user RDMAs safely, without requiring
page pinning. Looking through some of the recent IB and Ammasso discussions,
it may also prove useful to those NICs too.

This patch has been deployed in many large (1000+ CPUs) production Linux
clusters at high profile HPC sites such as LLNL and PNL. It has also been
incorporated in Linux kernel releases from HP, SGI and Bull.

I have discussed this patch with Andrew Morton and Andrea Arcangeli and they
believe now is the time to encourage further comments on whether it's
suitable to be incorporated into the mainline kernel.

Cheers,

David Addison
Quadrics Ltd


--------------070806030407050808080605
Content-Type: text/x-patch;
 name="ioproc-2.6.12-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioproc-2.6.12-rc3.patch"

diff -ruN linux-2.6.12-rc3.orig/include/linux/ioproc.h linux-2.6.12-rc3.ioproc/include/linux/ioproc.h
--- linux-2.6.12-rc3.orig/include/linux/ioproc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/include/linux/ioproc.h	2005-04-26 15:55:14.000000000 +0100
@@ -0,0 +1,271 @@
+/* -*- linux-c -*-
+ *
+ *    Copyright (C) 2002-2005 Quadrics Ltd.
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ */
+
+/*
+ * Callbacks for IO processor page table updates.
+ */
+
+#ifndef __LINUX_IOPROC_H__
+#define __LINUX_IOPROC_H__
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+typedef struct ioproc_ops {
+	struct ioproc_ops *next;
+	void *arg;
+
+	void (*release)(void *arg, struct mm_struct *mm);
+	void (*sync_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+	void (*invalidate_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+	void (*update_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+
+	void (*change_protection)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end, pgprot_t newprot);
+
+	void (*sync_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+	void (*invalidate_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+	void (*update_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+
+} ioproc_ops_t;
+
+/* IOPROC Registration
+ *
+ * Called by the IOPROC device driver to register its interest in page table
+ * changes for the process associated with the supplied mm_struct
+ *
+ * The caller should first allocate and fill out an ioproc_ops structure with
+ * the function pointers initialised to the device driver specific code for
+ * each callback. If the device driver doesn't have code for a particular
+ * callback then it should set the function pointer to be NULL.
+ * The ioproc_ops arg parameter will be passed unchanged as the first argument
+ * to each callback function invocation.
+ *
+ * The ioproc registration is not inherited across fork() and should be called
+ * once for each process that the IOPROC device driver is interested in.
+ *
+ * Must be called holding the mm->page_table_lock
+ */
+extern int ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip);
+
+
+/* IOPROC De-registration
+ *
+ * Called by the IOPROC device driver when it is no longer interested in page
+ * table changes for the process associated with the supplied mm_struct
+ *
+ * Normally this is not needed to be called as the ioproc_release() code will
+ * automatically unlink the ioproc_ops struct from the mm_struct as the
+ * process exits
+ *
+ * Must be called holding the mm->page_table_lock
+ */
+extern int ioproc_unregister_ops(struct mm_struct *mm, struct ioproc_ops *ip);
+
+#ifdef CONFIG_IOPROC
+
+/* IOPROC Release
+ *
+ * Called during exit_mmap() as all vmas are torn down and unmapped.
+ *
+ * Also unlinks the ioproc_ops structure from the mm list as it goes.
+ *
+ * No need for locks as the mm can no longer be accessed at this point
+ *
+ */
+static inline void
+ioproc_release(struct mm_struct *mm)
+{
+	struct ioproc_ops *cp;
+
+	while ((cp = mm->ioproc_ops) != NULL) {
+		mm->ioproc_ops = cp->next;
+
+		if (cp->release)
+			cp->release(cp->arg, mm);
+	}
+}
+
+/* IOPROC SYNC RANGE
+ *
+ * Called when a memory map is synchronised with its disk image i.e. when the
+ * msync() syscall is invoked. Any future read or write to the associated
+ * pages by the IOPROC should cause the page to be marked as referenced or
+ * modified.
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_sync_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->sync_range)
+			cp->sync_range(cp->arg, vma, start, end);
+}
+
+/* IOPROC INVALIDATE RANGE
+ *
+ * Called whenever a valid PTE is unloaded e.g. when a page is unmapped by the
+ * user or paged out by the kernel.
+ *
+ * After this call the IOPROC must not access the physical memory again unless
+ * a new translation is loaded.
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_invalidate_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	struct ioproc_ops *cp;
+	
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->invalidate_range)
+			cp->invalidate_range(cp->arg, vma, start, end);
+}
+
+/* IOPROC UPDATE RANGE
+ *
+ * Called whenever a valid PTE is loaded e.g. mmaping memory, moving the brk
+ * up, when breaking COW or faulting in an anonymous page of memory.
+ *
+ * These give the IOPROC device driver the opportunity to load translations
+ * speculatively, which can improve performance by avoiding device translation
+ * faults.
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_update_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->update_range)
+			cp->update_range(cp->arg, vma, start, end);
+}
+
+
+/* IOPROC CHANGE PROTECTION
+ *
+ * Called when the protection on a region of memory is changed i.e. when the
+ * mprotect() syscall is invoked.
+ *
+ * The IOPROC must not be able to write to a read-only page, so if the
+ * permissions are downgraded then it must honour them. If they are upgraded
+ * it can treat this in the same way as the ioproc_update_[range|sync]() calls
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_change_protection(struct vm_area_struct *vma, unsigned long start, unsigned long end, pgprot_t newprot)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->change_protection)
+			cp->change_protection(cp->arg, vma, start, end, newprot);
+}
+
+/* IOPROC SYNC PAGE
+ *
+ * Called when a memory map is synchronised with its disk image i.e. when the
+ * msync() syscall is invoked. Any future read or write to the associated page
+ * by the IOPROC should cause the page to be marked as referenced or modified.
+ *
+ * Not currently called as msync() calls ioproc_sync_range() instead
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_sync_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->sync_page)
+			cp->sync_page(cp->arg, vma, addr);
+}
+
+/* IOPROC INVALIDATE PAGE
+ *
+ * Called whenever a valid PTE is unloaded e.g. when a page is unmapped by the
+ * user or paged out by the kernel.
+ *
+ * After this call the IOPROC must not access the physical memory again unless
+ * a new translation is loaded.
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_invalidate_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->invalidate_page)
+			cp->invalidate_page(cp->arg, vma, addr);
+}
+
+/* IOPROC UPDATE PAGE
+ *
+ * Called whenever a valid PTE is loaded e.g. mmaping memory, moving the brk
+ * up, when breaking COW or faulting in an anonymous page of memory.
+ *
+ * These give the IOPROC device the opportunity to load translations
+ * speculatively, which can improve performance by avoiding device translation
+ * faults.
+ *
+ * Called holding the mm->page_table_lock
+ */
+static inline void
+ioproc_update_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct ioproc_ops *cp;
+
+	for (cp = vma->vm_mm->ioproc_ops; cp; cp = cp->next)
+		if (cp->update_page)
+			cp->update_page(cp->arg, vma, addr);
+}
+
+#else
+
+/* ! CONFIG_IOPROC so make all hooks empty */
+
+#define ioproc_release(mm)			do { } while (0)
+
+#define ioproc_sync_range(vma, start, end)	do { } while (0)
+
+#define ioproc_invalidate_range(vma, start,end)	do { } while (0)
+
+#define ioproc_update_range(vma, start, end)	do { } while (0)
+
+#define ioproc_change_protection(vma, start, end, prot)	do { } while (0)
+
+#define ioproc_sync_page(vma, addr)		do { } while (0)
+
+#define ioproc_invalidate_page(vma, addr)	do { } while (0)
+
+#define ioproc_update_page(vma, addr)		do { } while (0)
+
+#endif /* CONFIG_IOPROC */
+
+#endif /* __LINUX_IOPROC_H__ */
diff -ruN linux-2.6.12-rc3.orig/include/linux/sched.h linux-2.6.12-rc3.ioproc/include/linux/sched.h
--- linux-2.6.12-rc3.orig/include/linux/sched.h	2005-04-26 09:02:29.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/include/linux/sched.h	2005-04-26 15:55:14.000000000 +0100
@@ -186,6 +186,9 @@
 asmlinkage void schedule(void);
 
 struct namespace;
+#ifdef CONFIG_IOPROC
+struct ioproc_ops;
+#endif
 
 /* Maximum number of active map areas.. This is a random (large) number */
 #define DEFAULT_MAX_MAP_COUNT	65536
@@ -267,6 +270,11 @@
 
 	unsigned long hiwater_rss;	/* High-water RSS usage */
 	unsigned long hiwater_vm;	/* High-water virtual memory usage */
+
+#ifdef CONFIG_IOPROC
+	/* hooks for io devices with advanced RDMA capabilities */
+	struct ioproc_ops       *ioproc_ops;
+#endif
 };
 
 struct sighand_struct {
diff -ruN linux-2.6.12-rc3.orig/kernel/fork.c linux-2.6.12-rc3.ioproc/kernel/fork.c
--- linux-2.6.12-rc3.orig/kernel/fork.c	2005-04-26 09:02:36.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/kernel/fork.c	2005-04-26 15:55:14.000000000 +0100
@@ -320,6 +320,9 @@
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
 	mm->ioctx_list = NULL;
+#ifdef CONFIG_IOPROC
+	mm->ioproc_ops = NULL;
+#endif
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 
diff -ruN linux-2.6.12-rc3.orig/mm/fremap.c linux-2.6.12-rc3.ioproc/mm/fremap.c
--- linux-2.6.12-rc3.orig/mm/fremap.c	2005-04-26 09:02:39.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/fremap.c	2005-04-26 15:55:14.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
+#include <linux/ioproc.h>
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
@@ -30,6 +31,7 @@
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
 
+		ioproc_invalidate_page(vma, addr);
 		flush_cache_page(vma, addr, pfn);
 		pte = ptep_clear_flush(vma, addr, ptep);
 		if (pfn_valid(pfn)) {
@@ -99,6 +101,7 @@
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
+	ioproc_update_page(vma, addr);
 
 	err = 0;
 err_unlock:
@@ -143,6 +146,7 @@
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
+	ioproc_update_page(vma, addr);
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 
diff -ruN linux-2.6.12-rc3.orig/mm/hugetlb.c linux-2.6.12-rc3.ioproc/mm/hugetlb.c
--- linux-2.6.12-rc3.orig/mm/hugetlb.c	2005-03-02 07:38:12.000000000 +0000
+++ linux-2.6.12-rc3.ioproc/mm/hugetlb.c	2005-04-26 15:55:14.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/sysctl.h>
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
+#include <linux/ioproc.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
@@ -255,6 +256,7 @@
 	struct mm_struct *mm = vma->vm_mm;
 
 	spin_lock(&mm->page_table_lock);
+	ioproc_invalidate_range(vma, start, start + length);
 	unmap_hugepage_range(vma, start, start + length);
 	spin_unlock(&mm->page_table_lock);
 }
diff -ruN linux-2.6.12-rc3.orig/mm/ioproc.c linux-2.6.12-rc3.ioproc/mm/ioproc.c
--- linux-2.6.12-rc3.orig/mm/ioproc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/ioproc.c	2005-04-26 15:55:14.000000000 +0100
@@ -0,0 +1,58 @@
+/* -*- linux-c -*-
+ *
+ *    Copyright (C) 2002-2005 Quadrics Ltd.
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ */
+
+/*
+ * Registration for IO processor page table updates.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/mm.h>
+#include <linux/ioproc.h>
+
+int
+ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip)
+{
+	ip->next = mm->ioproc_ops;
+	mm->ioproc_ops = ip;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ioproc_register_ops);
+
+int
+ioproc_unregister_ops(struct mm_struct *mm, struct ioproc_ops *ip)
+{
+	struct ioproc_ops **tmp;
+
+	for (tmp = &mm->ioproc_ops; *tmp && *tmp != ip; tmp= &(*tmp)->next)
+		;
+	if (*tmp) {
+		*tmp = ip->next;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL_GPL(ioproc_unregister_ops);
diff -ruN linux-2.6.12-rc3.orig/mm/Kconfig linux-2.6.12-rc3.ioproc/mm/Kconfig
--- linux-2.6.12-rc3.orig/mm/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/Kconfig	2005-04-26 15:55:14.000000000 +0100
@@ -0,0 +1,15 @@
+#
+# VM subsystem specific config
+#
+
+# Support for IO processors which have advanced RDMA capabilities
+#
+config IOPROC
+	bool "Enable IOPROC VM hooks"
+	depends on MMU
+	default y
+	help
+	This option enables hooks in the VM subsystem so that IO devices which
+	incorporate advanced RDMA capabilities can be kept in sync with CPU
+	page table changes.
+	See Documentation/vm/ioproc.txt for more details.
diff -ruN linux-2.6.12-rc3.orig/mm/Makefile linux-2.6.12-rc3.ioproc/mm/Makefile
--- linux-2.6.12-rc3.orig/mm/Makefile	2005-03-02 07:38:12.000000000 +0000
+++ linux-2.6.12-rc3.ioproc/mm/Makefile	2005-04-26 15:55:14.000000000 +0100
@@ -17,4 +17,5 @@
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_IOPROC)	+= ioproc.o
 
diff -ruN linux-2.6.12-rc3.orig/mm/memory.c linux-2.6.12-rc3.ioproc/mm/memory.c
--- linux-2.6.12-rc3.orig/mm/memory.c	2005-04-26 09:02:39.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/memory.c	2005-04-26 15:55:14.000000000 +0100
@@ -45,6 +45,7 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/ioproc.h>
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -765,6 +766,7 @@
 
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
+ 	ioproc_invalidate_range(vma, address, end);
 	tlb = tlb_gather_mmu(mm, 0);
 	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
@@ -1076,6 +1078,7 @@
 {
 	pgd_t *pgd;
 	unsigned long next;
+	unsigned long beg = addr;
 	unsigned long end = addr + size;
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
@@ -1084,12 +1087,14 @@
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
+	ioproc_invalidate_range(vma, beg, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = zeromap_pud_range(mm, pgd, addr, next, prot);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
+	ioproc_update_range(vma, beg, end);
 	spin_unlock(&mm->page_table_lock);
 	return err;
 }
@@ -1164,6 +1169,7 @@
 {
 	pgd_t *pgd;
 	unsigned long next;
+	unsigned long beg = addr;
 	unsigned long end = addr + size;
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
@@ -1183,6 +1189,7 @@
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
+	ioproc_invalidate_range(vma, beg, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = remap_pud_range(mm, pgd, addr, next,
@@ -1190,6 +1197,7 @@
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
+	ioproc_update_range(vma, beg, end);
 	spin_unlock(&mm->page_table_lock);
 	return err;
 }
@@ -1218,8 +1226,10 @@
 
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
 			      vma);
+	ioproc_invalidate_page(vma, address);
 	ptep_establish(vma, address, page_table, entry);
 	update_mmu_cache(vma, address, entry);
+	ioproc_update_page(vma, address);
 	lazy_mmu_prot_update(entry);
 }
 
@@ -1273,6 +1283,7 @@
 					      vma);
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
+			ioproc_update_page(vma, address);
 			lazy_mmu_prot_update(entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
@@ -1736,6 +1747,7 @@
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
+	ioproc_update_page(vma, address);
 	lazy_mmu_prot_update(pte);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1794,6 +1806,7 @@
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
+	ioproc_update_page(vma, addr);
 	lazy_mmu_prot_update(entry);
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -1920,6 +1933,7 @@
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
+	ioproc_update_page(vma, address);
 	lazy_mmu_prot_update(entry);
 	spin_unlock(&mm->page_table_lock);
 out:
diff -ruN linux-2.6.12-rc3.orig/mm/mmap.c linux-2.6.12-rc3.ioproc/mm/mmap.c
--- linux-2.6.12-rc3.orig/mm/mmap.c	2005-04-26 09:02:39.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/mmap.c	2005-04-26 15:55:15.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/ioproc.h>
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
@@ -1627,6 +1628,7 @@
 
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
+	ioproc_invalidate_range(vma, start, end);
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
@@ -1905,6 +1907,7 @@
 
 	spin_lock(&mm->page_table_lock);
 
+	ioproc_release(mm);
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
diff -ruN linux-2.6.12-rc3.orig/mm/mprotect.c linux-2.6.12-rc3.ioproc/mm/mprotect.c
--- linux-2.6.12-rc3.orig/mm/mprotect.c	2005-04-26 09:02:40.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/mprotect.c	2005-04-26 15:55:15.000000000 +0100
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/ioproc.h>
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
@@ -89,6 +90,7 @@
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
+	ioproc_change_protection(vma, start, end, newprot);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
diff -ruN linux-2.6.12-rc3.orig/mm/mremap.c linux-2.6.12-rc3.ioproc/mm/mremap.c
--- linux-2.6.12-rc3.orig/mm/mremap.c	2005-04-26 09:02:40.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/mremap.c	2005-04-26 15:55:15.000000000 +0100
@@ -9,6 +9,7 @@
 
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/ioproc.h>
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
@@ -161,6 +162,8 @@
 {
 	unsigned long offset;
 
+	ioproc_invalidate_range(vma, old_addr, old_addr + len);
+	ioproc_invalidate_range(vma, new_addr, new_addr + len);
 	flush_cache_range(vma, old_addr, old_addr + len);
 
 	/*
diff -ruN linux-2.6.12-rc3.orig/mm/msync.c linux-2.6.12-rc3.ioproc/mm/msync.c
--- linux-2.6.12-rc3.orig/mm/msync.c	2005-04-26 09:02:40.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/msync.c	2005-04-26 15:55:15.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/mman.h>
 #include <linux/hugetlb.h>
 #include <linux/syscalls.h>
+#include <linux/ioproc.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -95,6 +96,7 @@
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
+	ioproc_sync_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
diff -ruN linux-2.6.12-rc3.orig/mm/rmap.c linux-2.6.12-rc3.ioproc/mm/rmap.c
--- linux-2.6.12-rc3.orig/mm/rmap.c	2005-04-26 09:02:40.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/mm/rmap.c	2005-04-26 15:55:15.000000000 +0100
@@ -53,6 +53,7 @@
 #include <linux/init.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
+#include <linux/ioproc.h>
 
 #include <asm/tlbflush.h>
 
@@ -573,6 +574,7 @@
 	}
 
 	/* Nuke the page table entry. */
+	ioproc_invalidate_page(vma, address);
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
 
@@ -690,6 +692,7 @@
 			continue;
 
 		/* Nuke the page table entry. */
+		ioproc_invalidate_page(vma, address);
 		flush_cache_page(vma, address, pfn);
 		pteval = ptep_clear_flush(vma, address, pte);
 
diff -ruN linux-2.6.12-rc3.orig/arch/i386/defconfig linux-2.6.12-rc3.ioproc/arch/i386/defconfig
--- linux-2.6.12-rc3.orig/arch/i386/defconfig	2005-04-26 08:59:33.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/arch/i386/defconfig	2005-04-26 15:55:15.000000000 +0100
@@ -120,6 +120,7 @@
 CONFIG_IRQBALANCE=y
 CONFIG_HAVE_DEC_LOCK=y
 # CONFIG_REGPARM is not set
+CONFIG_IOPROC=y
 
 #
 # Power management options (ACPI, APM)
diff -ruN linux-2.6.12-rc3.orig/arch/i386/Kconfig linux-2.6.12-rc3.ioproc/arch/i386/Kconfig
--- linux-2.6.12-rc3.orig/arch/i386/Kconfig	2005-04-26 08:59:33.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/arch/i386/Kconfig	2005-04-26 15:55:15.000000000 +0100
@@ -923,6 +923,8 @@
 
 	  If unsure, say Y. Only embedded should say N here.
 
+source "mm/Kconfig"
+
 endmenu
 
 
diff -ruN linux-2.6.12-rc3.orig/arch/ia64/defconfig linux-2.6.12-rc3.ioproc/arch/ia64/defconfig
--- linux-2.6.12-rc3.orig/arch/ia64/defconfig	2005-03-02 07:37:48.000000000 +0000
+++ linux-2.6.12-rc3.ioproc/arch/ia64/defconfig	2005-04-26 15:55:15.000000000 +0100
@@ -92,6 +92,7 @@
 CONFIG_PERFMON=y
 CONFIG_IA64_PALINFO=y
 CONFIG_ACPI_DEALLOCATE_IRQ=y
+CONFIG_IOPROC=y
 
 #
 # Firmware Drivers
diff -ruN linux-2.6.12-rc3.orig/arch/ia64/Kconfig linux-2.6.12-rc3.ioproc/arch/ia64/Kconfig
--- linux-2.6.12-rc3.orig/arch/ia64/Kconfig	2005-04-26 08:59:38.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/arch/ia64/Kconfig	2005-04-26 15:55:15.000000000 +0100
@@ -319,6 +319,8 @@
 	depends on IOSAPIC && EXPERIMENTAL
 	default y
 
+source "mm/Kconfig"
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
diff -ruN linux-2.6.12-rc3.orig/arch/x86_64/defconfig linux-2.6.12-rc3.ioproc/arch/x86_64/defconfig
--- linux-2.6.12-rc3.orig/arch/x86_64/defconfig	2005-04-26 09:00:10.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/arch/x86_64/defconfig	2005-04-26 15:55:15.000000000 +0100
@@ -100,6 +100,7 @@
 CONFIG_SECCOMP=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_IOPROC=y
 
 #
 # Power management options
diff -ruN linux-2.6.12-rc3.orig/arch/x86_64/Kconfig linux-2.6.12-rc3.ioproc/arch/x86_64/Kconfig
--- linux-2.6.12-rc3.orig/arch/x86_64/Kconfig	2005-04-26 09:00:10.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/arch/x86_64/Kconfig	2005-04-26 15:55:15.000000000 +0100
@@ -458,6 +458,8 @@
 	depends on IA32_EMULATION
 	default y
 
+source "mm/Kconfig"
+
 endmenu
 
 source drivers/Kconfig
diff -ruN linux-2.6.12-rc3.orig/Documentation/vm/ioproc.txt linux-2.6.12-rc3.ioproc/Documentation/vm/ioproc.txt
--- linux-2.6.12-rc3.orig/Documentation/vm/ioproc.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc3.ioproc/Documentation/vm/ioproc.txt	2005-04-26 15:55:15.000000000 +0100
@@ -0,0 +1,500 @@
+Linux IOPROC patch overview
+===========================
+
+The network interface for an HPC network differs significantly from
+network interfaces for traditional IP networks. HPC networks tend to
+be used directly from user processes and perform large RDMA transfers
+between the process address spaces. They also have a requirement
+for low latency communication, and typically achieve this by OS bypass
+techniques.  This then requires a different model to traditional
+interconnects, in that a process may need to expose a large amount of
+it's address space to the network RDMA.
+
+Locking down of memory has been a common mechanism for performing
+this, together with a pin-down cache implemented in user
+libraries. The disadvantage of this method is that large portions of
+the physical memory can be locked down for a single process, even if
+it's working set changes over the different phases of it's
+execution. This leads to inefficient memory utilisation - akin to the
+disadvantage of swapping compared to paging.
+
+This model also has problems where memory is being dynamically
+allocated and freed, since the pin down cache is unaware that memory
+may have been released by a call to munmap() and so it will still be
+locking down the now unused pages.
+
+Some modern HPC network interfaces implement their own MMU and are
+able to handle a translation fault during a network access. The
+Quadrics (http://www.quadrics.com) devices (Elan3 and Elan4) have done
+this for some time, and the Infiniband standard also allows for the
+case where memory has been deregistered when an RDMA occurs.
+These NICs are able to operate in an environment where paging occurs
+and do not require memory to be locked down. The advantage of this is
+that the user process can expose large portions of its address space
+without having to worry about physical memory constraints.
+
+However should the operating system decide to swap a page to disk,
+then the NIC must be made aware that it should no longer read/write
+from this memory, but should generate a translation fault instead.
+
+The ioproc patch has been developed to provide a mechanism whereby the
+device driver for a NIC can be made aware of when a user process's
+address translations change, either by paging or by explicitly mapping
+or unmapping of memory.
+
+The patch involves inserting callbacks where translations are being
+invalidated to notify the NIC that the memory behind those
+translations is no longer visible to the application (and so should
+not be visible to the NIC). This callback is then responsible for
+ensuring that the NIC will not access the physical memory that was
+being mapped.
+
+An ioproc invalidate callback in the kswapd code could be utilised to
+prevent memory from being paged out if the NIC is unable to support
+RDMA page faulting. This has not yet been implemented in this patch.
+
+For NICs which support RDMA page faulting, there is no requirement
+for a user level pin down cache, since they are able to page-in their
+translations on the first communication using a buffer. However this
+is likely to be inefficient, resulting in slow first use of the
+buffer. If the communication buffers were continually allocated and
+freed using mmap() based malloc() calls then this would lead to all
+communications being slower than desirable.
+
+To optimise these warm-up cases the ioproc patch adds calls to
+ioproc_update wherever the kernel is creating translations for a user
+process. These then allow the device driver to preload translations
+so that they are already present for the first network communication
+from a buffer.
+
+Linux 2.6 IOPROC implementation details
+=======================================
+
+The Linux IOPROC patch adds hooks to the Linux VM code whenever page
+table entries are being created and/or invalidated. IOPROC device
+drivers can register their interest in being informed of such changes
+by registering an ioproc_ops structure which is defined as follows;
+
+extern int ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip);
+extern int ioproc_unregister_ops(struct mm_struct *mm, struct ioproc_ops *ip);
+
+typedef struct ioproc_ops {
+	struct ioproc_ops *next;
+	void *arg;
+
+	void (*release)(void *arg, struct mm_struct *mm);
+	void (*sync_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+	void (*invalidate_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+	void (*update_range)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end);
+
+	void (*change_protection)(void *arg, struct vm_area_struct *vma, unsigned long start, unsigned long end, pgprot_t newprot);
+
+	void (*sync_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+	void (*invalidate_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+	void (*update_page)(void *arg, struct vm_area_struct *vma, unsigned long address);
+
+} ioproc_ops_t;
+
+ioproc_register_ops
+===================
+This function should be called by the IOPROC device driver to register
+its interest in PTE changes for the process associated with the passed
+in mm_struct.
+
+The ioproc registration is not inherited across fork() and should be
+called once for each process that IOPROC is interested in.
+
+This function must be called whilst holding the mm->page_table_lock.
+
+ioproc_unregister_ops
+=====================
+This function should be called by the IOPROC device driver when it no
+longer requires informing of PTE changes in the process associated
+with the supplied mm_struct.
+
+This function is not normally needed to be called as the ioproc_ops
+struct is unlinked from the associated mm_struct during the
+ioproc_release() call.
+
+This function must be called whilst holding the mm->page_table_lock.
+
+ioproc_ops struct
+=================
+A linked list ioproc_ops structures is hung off the user process
+mm_struct (linux/sched.h). At each hook point in the patched kernel
+the ioproc patch will call the associated ioproc_ops callback function
+pointer in turn for each registered structure.
+
+The intention of the callbacks is to allow the IOPROC device driver to
+inspect the new or modified PTE entry via the Linux kernel
+(e.g. find_pte_map()). These callbacks should not modify the Linux
+kernel VM state or PTE entries.
+
+The ioproc_ops callback function pointers are defined as follows;
+
+ioproc_release
+==============
+The release hook is called when a program exits and all its vma areas
+are torn down and unmapped. i.e. during exit_mmap(). Before each
+release hook is called the ioproc_ops structure is unlinked from the
+mm_struct.
+
+No locks are required as the process has the only reference to the mm
+at this point.
+
+ioproc_sync_[range|page]
+========================
+The sync hooks are called when a memory map is synchronised with its
+disk image i.e. when the msync() syscall is invoked. Any future read
+or write by the IOPROC device to the associated pages should cause the
+page to be marked as referenced or modified.
+
+Called holding the mm->page_table_lock
+
+ioproc_invalidate_[range|page]
+==============================
+The invalidate hooks are called whenever a valid PTE is unloaded
+e.g. when a page is unmapped by the user or paged out by the
+kernel. After this call the IOPROC must not access the physical memory
+again unless a new translation is loaded.
+
+Called holding the mm->page_table_lock
+
+ioproc_update_[range|page]
+==========================
+The update hooks are called whenever a valid PTE is loaded
+e.g. mmaping memory, moving the brk up, when breaking COW or faulting
+in an anonymous page of memory. These give the IOPROC device the
+opportunity to load translations speculatively, which can improve
+performance by avoiding device translation faults.
+
+Called holding the mm->page_table_lock
+
+ioproc_change_protection
+========================
+This hook is called when the protection on a region of memory is
+changed i.e. when the mprotect() syscall is invoked.
+
+The IOPROC must not be able to write to a read-only page, so if the
+permissions are downgraded then it must honour them. If they are
+upgraded it can treat this in the same way as the
+ioproc_update_[range|page]() calls
+
+Called holding the mm->page_table_lock
+
+
+Linux 2.6 IOPROC patch details
+==============================
+
+Here are the specific details of each ioproc hook added to the Linux
+2.6 VM system and the reasons for doing so;
+
+===============================================================================
+++++ FILE
+	mm/fremap.c
+
+==== FUNCTION
+	zap_pte
+
+CALLED FROM
+	install_page
+	install_file_pte
+
+PTE MODIFICATION
+	ptep_clear_flush
+
+ADDED HOOKS
+	ioproc_invalidate_page
+
+==== FUNCTION
+	install_page
+
+CALLED FROM
+	filemap_populate, shmem_populate
+
+PTE MODIFICATION
+	set_pte_at
+
+ADDED HOOKS
+	ioproc_update_page
+
+==== FUNCTION
+	install_file_pte
+
+CALLED FROM
+	filemap_populate, shmem_populate
+
+PTE MODIFICATION
+	set_pte_at
+
+ADDED HOOKS
+	ioproc_update_page
+
+
+===============================================================================
+++++ FILE
+	mm/memory.c
+
+==== FUNCTION
+	copy_page_range
+
+CALLED FROM
+       dup_mmap (fork.c)
+
+PTE MODIFICATION
+	set_pte_at (copy_one_pte)
+
+ADDED HOOKS
+	None necessary as its creating a new process
+
+==== FUNCTION
+	zap_page_range
+
+CALLED FROM
+	read_zero_pagealigned, madvise_dontneed, unmap_mapping_range,
+	unmap_mapping_range_list, do_mmap_pgoff
+
+PTE MODIFICATION
+	set_pte_at (unmap_vmas)
+
+ADDED HOOKS
+	ioproc_invalidate_range
+
+
+==== FUNCTION
+	zeromap_page_range
+
+CALLED FROM
+	read_zero_pagealigned, mmap_zero
+
+PTE MODIFICATION
+	set_pte_at (zeromap_pte_range via zeromap_[pud|pmd|pte]_range)
+
+ADDED HOOKS
+	ioproc_invalidate_range
+	ioproc_update_range
+
+
+==== FUNCTION
+	remap_pfn_range
+
+CALLED FROM
+	many device drivers
+
+PTE MODIFICATION
+	set_pte_at (remap_pte_range via remap_[pud|pmd|pte]_range)
+
+ADDED HOOKS
+	ioproc_invalidate_range
+	ioproc_update_range
+
+
+==== FUNCTION
+	break_cow
+
+CALLED FROM
+	do_wp_page
+
+PTE MODIFICATION
+	ptep_establish
+
+ADDED HOOKS
+	ioproc_invalidate_page
+	ioproc_update_page
+
+
+==== FUNCTION
+	do_wp_page
+
+CALLED FROM
+       do_swap_page, handle_pte_fault
+
+PTE MODIFICATION
+	ptep_set_access_flags, break_cow
+
+ADDED HOOKS
+	ioproc_update_page
+
+
+==== FUNCTION
+	do_swap_page
+
+CALLED FROM
+	handle_pte_fault
+
+PTE MODIFICATION
+	set_pte_at
+
+ADDED HOOKS
+	ioproc_update_page
+
+
+==== FUNCTION
+	do_anonymous_page
+
+CALLED FROM
+	do_no_page
+
+PTE MODIFICATION
+	set_pte_at
+
+ADDED HOOKS
+	ioproc_update_page
+
+
+==== FUNCTION
+	do_no_page
+
+CALLED FROM
+	do_file_page, handle_pte_fault
+
+PTE MODIFICATION
+	set_pte_at
+
+ADDED HOOKS
+	ioproc_update_page
+
+
+==== FUNCTION
+	handle_pte_fault
+
+CALLED FROM
+	handle_mm_fault
+
+PTE MODIFICATION
+	ptep_set_access_flags, do_no_page, do_file_page, do_swap_page
+
+ADDED HOOKS
+	Handled in called functions and not necessary for minor fault
+
+
+===============================================================================
+++++ FILE
+	mm/mmap.c
+
+==== FUNCTION
+	unmap_region
+
+CALLED FROM
+	do_munmap
+
+PTE MODIFICATION
+	set_pte_at (unmap_vmas)
+
+ADDED HOOKS
+	ioproc_invalidate_range
+
+
+==== FUNCTION
+	exit_mmap
+
+CALLED FROM
+	mmput
+
+PTE MODIFICATION
+	set_pte_at (unmap_vmas)
+
+ADDED HOOKS
+	ioproc_release
+
+
+===============================================================================
+++++ FILE
+	mm/mprotect.c
+
+==== FUNCTION
+	change_protection
+
+CALLED FROM
+	mprotect_fixup
+
+PTE MODIFICATION
+	set_pte_at (change_pte_range via change_[pud|pmd|pte]_range)
+
+ADDED HOOKS
+	ioproc_change_protection
+
+
+===============================================================================
+++++ FILE
+	mm/mremap.c
+
+==== FUNCTION
+	move_page_tables
+
+CALLED FROM
+	move_vma
+
+PTE MODIFICATION
+	ptep_clear_flush (move_one_page)
+
+ADDED HOOKS
+	ioproc_invalidate_range
+	ioproc_invalidate_range
+
+
+===============================================================================
+++++ FILE
+	mm/rmap.c
+
+==== FUNCTION
+	try_to_unmap_one
+
+CALLED FROM
+	try_to_unmap_anon, try_to_unmap_file
+
+PTE MODIFICATION
+	ptep_clear_flush
+
+ADDED HOOKS
+	ioproc_invalidate_page
+
+
+==== FUNCTION
+	try_to_unmap_cluster
+
+CALLED FROM
+	try_to_unmap_file
+
+PTE MODIFICATION
+	ptep_clear_flush
+
+ADDED HOOKS
+	ioproc_invalidate_page
+
+
+===============================================================================
+++++ FILE
+	mm/msync.c
+
+==== FUNCTION
+	filemap_sync
+
+CALLED FROM
+	msync_interval
+
+PTE MODIFICATION
+	ptep_clear_flush_dirty (filemap_sync_pte)
+
+ADDED HOOKS
+	ioproc_sync_range
+
+
+===============================================================================
+++++ FILE
+	mm/hugetlb.c
+
+==== FUNCTION
+	zap_hugepage_range
+
+CALLED FROM
+	hugetlb_vmtruncate_list
+
+PTE MODIFICATION
+	ptep_get_and_clear (unmap_hugepage_range)
+
+ADDED HOOK
+	ioproc_invalidate_range
+
+
+-- Last update DavidAddison - 26 Apr 2005

--------------070806030407050808080605--
