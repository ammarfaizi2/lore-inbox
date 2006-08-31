Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWHaVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWHaVfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWHaVft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:35:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932199AbWHaVft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:35:49 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/4] NOMMU: Make mremap() partially work for NOMMU kernels
Date: Thu, 31 Aug 2006 22:35:37 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831213537.29363.83544.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
References: <20060831213530.29363.6372.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make mremap() partially work for NOMMU kernels.  It may resize a VMA provided
that it doesn't exceed the size of the slab object in which the storage is
allocated that the VMA refers to.  Shareable VMAs may not be resized.

Moving VMAs (as permitted by MREMAP_MAYMOVE) is not currently supported.

This patch also makes use of the fact that the VMA list is now ordered to cut
it short when possible.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/nommu-mmap.txt |   24 ++++++++++++++++
 mm/nommu.c                   |   63 +++++++++++++++++++++++++++++++-----------
 2 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index 83f4b08..3ce8906 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -128,6 +128,30 @@ FURTHER NOTES ON NO-MMU MMAP
      error will result if they don't. This is most likely to be encountered
      with character device files, pipes, fifos and sockets.
 
+
+=============
+NO-MMU MREMAP
+=============
+
+The mremap() function is partially supported.  It may change the size of a
+mapping, and may move it[*] if MREMAP_MAYMOVE is specified and if the new size
+of the mapping exceeds the size of the slab object currently occupied by the
+memory to which the mapping refers, or if a smaller slab object could be used.
+
+MREMAP_FIXED is not supported, though it is ignored if there's no change of
+address and the object does not need to be moved.
+
+Shared mappings may not be moved.  Shareable mappings may not be moved either,
+even if they are not currently shared.
+
+The mremap() function must be given an exact match for base address and size of
+a previously mapped object.  It may not be used to create holes in existing
+mappings, move parts of existing mappings or resize parts of mappings.  It must
+act on a complete mapping.
+
+[*] Not currently supported.
+
+
 ============================================
 PROVIDING SHAREABLE CHARACTER DEVICE SUPPORT
 ============================================
diff --git a/mm/nommu.c b/mm/nommu.c
index 20da741..a0ba6ac 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -327,6 +327,26 @@ struct vm_area_struct *find_vma(struct m
 EXPORT_SYMBOL(find_vma);
 
 /*
+ * look up the first VMA exactly that exactly matches addr
+ * - should be called with mm->mmap_sem at least held readlocked
+ */
+static inline struct vm_area_struct *find_vma_exact(struct mm_struct *mm,
+						    unsigned long addr)
+{
+	struct vm_list_struct *vml;
+
+	/* search the vm_start ordered list */
+	for (vml = mm->context.vmlist; vml; vml = vml->next) {
+		if (vml->vma->vm_start == addr)
+			return vml->vma;
+		if (vml->vma->vm_start > addr)
+			break;
+	}
+
+	return NULL;
+}
+
+/*
  * find a VMA in the global tree
  */
 static inline struct vm_area_struct *find_nommu_vma(unsigned long start)
@@ -1048,20 +1068,20 @@ unsigned long do_brk(unsigned long addr,
 }
 
 /*
- * Expand (or shrink) an existing mapping, potentially moving it at the
- * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
+ * expand (or shrink) an existing mapping, potentially moving it at the same
+ * time (controlled by the MREMAP_MAYMOVE flag and available VM space)
  *
- * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
- * This option implies MREMAP_MAYMOVE.
+ * under NOMMU conditions, we only permit changing a mapping's size, and only
+ * as long as it stays within the hole allocated by the kmalloc() call in
+ * do_mmap_pgoff() and the block is not shareable
  *
- * on uClinux, we only permit changing a mapping's size, and only as long as it stays within the
- * hole allocated by the kmalloc() call in do_mmap_pgoff() and the block is not shareable
+ * MREMAP_FIXED is not supported under NOMMU conditions
  */
 unsigned long do_mremap(unsigned long addr,
 			unsigned long old_len, unsigned long new_len,
 			unsigned long flags, unsigned long new_addr)
 {
-	struct vm_list_struct *vml = NULL;
+	struct vm_area_struct *vma;
 
 	/* insanity checks first */
 	if (new_len == 0)
@@ -1070,29 +1090,38 @@ unsigned long do_mremap(unsigned long ad
 	if (flags & MREMAP_FIXED && new_addr != addr)
 		return (unsigned long) -EINVAL;
 
-	for (vml = current->mm->context.vmlist; vml; vml = vml->next)
-		if (vml->vma->vm_start == addr)
-			goto found;
-
-	return (unsigned long) -EINVAL;
+	vma = find_vma_exact(current->mm, addr);
+	if (!vma)
+		return (unsigned long) -EINVAL;
 
- found:
-	if (vml->vma->vm_end != vml->vma->vm_start + old_len)
+	if (vma->vm_end != vma->vm_start + old_len)
 		return (unsigned long) -EFAULT;
 
-	if (vml->vma->vm_flags & VM_MAYSHARE)
+	if (vma->vm_flags & VM_MAYSHARE)
 		return (unsigned long) -EPERM;
 
 	if (new_len > kobjsize((void *) addr))
 		return (unsigned long) -ENOMEM;
 
 	/* all checks complete - do it */
-	vml->vma->vm_end = vml->vma->vm_start + new_len;
+	vma->vm_end = vma->vm_start + new_len;
 
 	askedalloc -= old_len;
 	askedalloc += new_len;
 
-	return vml->vma->vm_start;
+	return vma->vm_start;
+}
+
+asmlinkage unsigned long sys_mremap(unsigned long addr,
+	unsigned long old_len, unsigned long new_len,
+	unsigned long flags, unsigned long new_addr)
+{
+	unsigned long ret;
+
+	down_write(&current->mm->mmap_sem);
+	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
+	up_write(&current->mm->mmap_sem);
+	return ret;
 }
 
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
