Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWHaVgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHaVgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWHaVgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:36:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932338AbWHaVfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:35:55 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] NOMMU: Order the per-mm_struct VMA list
Date: Thu, 31 Aug 2006 22:35:35 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831213535.29363.10894.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
References: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Order the per-mm_struct VMA list by address so that searching it can be cut
short when the appropriate address has been exceeded.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |  105 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 9d57c2a..20da741 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -286,6 +286,49 @@ static void show_process_blocks(void)
 }
 #endif /* DEBUG */
 
+/*
+ * add a VMA into a process's mm_struct in the appropriate place in the list
+ * - should be called with mm->mmap_sem held writelocked
+ */
+static void add_vma_to_mm(struct mm_struct *mm, struct vm_list_struct *vml)
+{
+	struct vm_list_struct **ppv;
+
+	for (ppv = &current->mm->context.vmlist; *ppv; ppv = &(*ppv)->next)
+		if ((*ppv)->vma->vm_start > vml->vma->vm_start)
+			break;
+
+	vml->next = *ppv;
+	*ppv = vml;
+}
+
+/*
+ * look up the first VMA in which addr resides, NULL if none
+ * - should be called with mm->mmap_sem at least held readlocked
+ */
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_list_struct *loop, *vml;
+
+	/* search the vm_start ordered list */
+	vml = NULL;
+	for (loop = mm->context.vmlist; loop; loop = loop->next) {
+		if (loop->vma->vm_start > addr)
+			break;
+		vml = loop;
+	}
+
+	if (vml && vml->vma->vm_end > addr)
+		return vml->vma;
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(find_vma);
+
+/*
+ * find a VMA in the global tree
+ */
 static inline struct vm_area_struct *find_nommu_vma(unsigned long start)
 {
 	struct vm_area_struct *vma;
@@ -305,6 +348,9 @@ static inline struct vm_area_struct *fin
 	return NULL;
 }
 
+/*
+ * add a VMA in the global tree
+ */
 static void add_nommu_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *pvma;
@@ -351,6 +397,9 @@ static void add_nommu_vma(struct vm_area
 	rb_insert_color(&vma->vm_rb, &nommu_vma_tree);
 }
 
+/*
+ * delete a VMA from the global list
+ */
 static void delete_nommu_vma(struct vm_area_struct *vma)
 {
 	struct address_space *mapping;
@@ -828,8 +877,7 @@ unsigned long do_mmap_pgoff(struct file 
 	realalloc += kobjsize(vml);
 	askedalloc += sizeof(*vml);
 
-	vml->next = current->mm->context.vmlist;
-	current->mm->context.vmlist = vml;
+	add_vma_to_mm(current->mm, vml);
 
 	up_write(&nommu_vma_sem);
 
@@ -908,6 +956,11 @@ static void put_vma(struct vm_area_struc
 	}
 }
 
+/*
+ * release a mapping
+ * - under NOMMU conditions the parameters must match exactly to the mapping to
+ *   be removed
+ */
 int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
 {
 	struct vm_list_struct *vml, **parent;
@@ -917,10 +970,13 @@ #ifdef DEBUG
 	printk("do_munmap:\n");
 #endif
 
-	for (parent = &mm->context.vmlist; *parent; parent = &(*parent)->next)
+	for (parent = &mm->context.vmlist; *parent; parent = &(*parent)->next) {
+		if ((*parent)->vma->vm_start > addr)
+			break;
 		if ((*parent)->vma->vm_start == addr &&
 		    ((len == 0) || ((*parent)->vma->vm_end == end)))
 			goto found;
+	}
 
 	printk("munmap of non-mmaped memory by process %d (%s): %p\n",
 	       current->pid, current->comm, (void *) addr);
@@ -946,7 +1002,20 @@ #endif
 	return 0;
 }
 
-/* Release all mmaps. */
+asmlinkage long sys_munmap(unsigned long addr, size_t len)
+{
+	int ret;
+	struct mm_struct *mm = current->mm;
+
+	down_write(&mm->mmap_sem);
+	ret = do_munmap(mm, addr, len);
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * Release all mappings
+ */
 void exit_mmap(struct mm_struct * mm)
 {
 	struct vm_list_struct *tmp;
@@ -973,17 +1042,6 @@ #endif
 	}
 }
 
-asmlinkage long sys_munmap(unsigned long addr, size_t len)
-{
-	int ret;
-	struct mm_struct *mm = current->mm;
-
-	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len);
-	up_write(&mm->mmap_sem);
-	return ret;
-}
-
 unsigned long do_brk(unsigned long addr, unsigned long len)
 {
 	return -ENOMEM;
@@ -1037,23 +1095,6 @@ unsigned long do_mremap(unsigned long ad
 	return vml->vma->vm_start;
 }
 
-/*
- * Look up the first VMA which satisfies  addr < vm_end,  NULL if none
- * - should be called with mm->mmap_sem at least readlocked
- */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_list_struct *vml;
-
-	for (vml = mm->context.vmlist; vml; vml = vml->next)
-		if (addr >= vml->vma->vm_start && addr < vml->vma->vm_end)
-			return vml->vma;
-
-	return NULL;
-}
-
-EXPORT_SYMBOL(find_vma);
-
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			unsigned int foll_flags)
 {
