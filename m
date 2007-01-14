Return-Path: <linux-kernel-owner+w=401wt.eu-S1751116AbXANFgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXANFgk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXANFgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:36:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXANFgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:36:37 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 8/11] Add install_special_mapping
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Message-Id: <20070114053634.0FDB21800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:36:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchs adds a utility function install_special_mapping, for creating a
special vma using a fixed set of preallocated pages as backing, such as for
a vDSO.  This consolidates some nearly identical code used for vDSO mapping
reimplemented for different architectures.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/linux/mm.h |    3 ++
 mm/mmap.c          |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d2c08d..bb793a4 100644  
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1030,6 +1030,9 @@ extern struct vm_area_struct *copy_vma(s
 	unsigned long addr, unsigned long len, pgoff_t pgoff);
 extern void exit_mmap(struct mm_struct *);
 extern int may_expand_vm(struct mm_struct *mm, unsigned long npages);
+extern int install_special_mapping(struct mm_struct *mm,
+				   unsigned long addr, unsigned long len,
+				   unsigned long flags, struct page **pages);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 9717337..b540fb2 100644  
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2094,3 +2094,75 @@ int may_expand_vm(struct mm_struct *mm, 
 		return 0;
 	return 1;
 }
+
+
+static struct page *special_mapping_nopage(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	struct page **pages;
+
+	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+
+	address -= vma->vm_start;
+	for (pages = vma->vm_private_data; address > 0 && *pages; ++pages)
+		address -= PAGE_SIZE;
+
+	if (*pages) {
+		struct page *page = *pages;
+		get_page(page);
+		return page;
+	}
+
+	return NOPAGE_SIGBUS;
+}
+
+/*
+ * Having a close hook prevents vma merging regardless of flags.
+ */
+static void special_mapping_close(struct vm_area_struct *vma)
+{
+}
+
+static struct vm_operations_struct special_mapping_vmops = {
+	.close = special_mapping_close,
+	.nopage	= special_mapping_nopage,
+};
+
+/*
+ * Called with mm->mmap_sem held for writing.
+ * Insert a new vma covering the given region, with the given flags.
+ * Its pages are supplied by the given array of struct page *.
+ * The array can be shorter than len >> PAGE_SHIFT if it's null-terminated.
+ * The region past the last page supplied will always produce SIGBUS.
+ * The array pointer and the pages it points to are assumed to stay alive
+ * for as long as this mapping might exist.
+ */
+int install_special_mapping(struct mm_struct *mm,
+			    unsigned long addr, unsigned long len,
+			    unsigned long vm_flags, struct page **pages)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
+	if (unlikely(vma == NULL))
+		return -ENOMEM;
+
+	vma->vm_mm = mm;
+	vma->vm_start = addr;
+	vma->vm_end = addr + len;
+
+	vma->vm_flags = vm_flags | mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+
+	vma->vm_ops = &special_mapping_vmops;
+	vma->vm_private_data = pages;
+
+	if (unlikely(insert_vm_struct(mm, vma))) {
+		kmem_cache_free(vm_area_cachep, vma);
+		return -ENOMEM;
+	}
+
+	mm->total_vm += len >> PAGE_SHIFT;
+
+	return 0;
+}
