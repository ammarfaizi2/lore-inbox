Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUERWH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUERWH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUERWH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:07:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50346 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263609AbUERWHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:07:16 -0400
Date: Tue, 18 May 2004 23:07:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 35 mmap.c cleanups
In-Reply-To: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405182306240.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before some real vma_merge work in mmap.c in the next patch,
a patch of miscellaneous cleanups to cut down the noise:

- remove rb_parent arg from vma_merge: mm->mmap can do that case
- scatter pgoff_t around to ingratiate myself with the boss
- reorder is_mergeable_vma tests, vm_ops->close is least likely
- can_vma_merge_before take combined pgoff+pglen arg (from Andrea)
- rearrange do_mmap_pgoff's ever-confusing anonymous flags switch
- comment do_mmap_pgoff's mysterious (vm_flags & VM_SHARED) test
- fix ISO C90 warning on browse_rb if building with DEBUG_MM_RB
- stop that long MNT_NOEXEC line wrapping

Yes, buried in amidst these is indeed one pgoff replaced by
"next->vm_pgoff - pglen" (reverting a mod of mine which took pgoff
supplied by user too seriously in the anon case), and another pgoff
replaced by 0 (reverting anon_vma mod which crept in with NUMA API):
neither of them really matters, except perhaps in /proc/pid/maps.

 include/linux/mm.h |    2 -
 mm/mmap.c          |   90 +++++++++++++++++++++++++++--------------------------
 2 files changed, 47 insertions(+), 45 deletions(-)

--- rmap34/include/linux/mm.h	2004-05-16 11:39:23.000000000 +0100
+++ rmap35/include/linux/mm.h	2004-05-18 20:50:45.788661560 +0100
@@ -612,7 +612,7 @@ extern void insert_vm_struct(struct mm_s
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
-	unsigned long addr, unsigned long len, unsigned long pgoff);
+	unsigned long addr, unsigned long len, pgoff_t pgoff);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- rmap34/mm/mmap.c	2004-05-16 11:39:25.000000000 +0100
+++ rmap35/mm/mmap.c	2004-05-18 20:50:45.816657304 +0100
@@ -153,10 +153,10 @@ out:
 }
 
 #ifdef DEBUG_MM_RB
-static int browse_rb(struct rb_root *root) {
-	int i, j;
+static int browse_rb(struct rb_root *root)
+{
+	int i = 0, j;
 	struct rb_node *nd, *pn = NULL;
-	i = 0;
 	unsigned long prev = 0, pend = 0;
 
 	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
@@ -180,10 +180,11 @@ static int browse_rb(struct rb_root *roo
 	return i;
 }
 
-void validate_mm(struct mm_struct * mm) {
+void validate_mm(struct mm_struct *mm)
+{
 	int bug = 0;
 	int i = 0;
-	struct vm_area_struct * tmp = mm->mmap;
+	struct vm_area_struct *tmp = mm->mmap;
 	while (tmp) {
 		tmp = tmp->vm_next;
 		i++;
@@ -406,17 +407,17 @@ void vma_adjust(struct vm_area_struct *v
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
 			struct file *file, unsigned long vm_flags)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (vma->vm_flags != vm_flags)
 		return 0;
 	if (vma->vm_file != file)
 		return 0;
-	if (vma->vm_flags != vm_flags)
+	if (vma->vm_ops && vma->vm_ops->close)
 		return 0;
 	return 1;
 }
 
 /*
- * Return true if we can merge this (vm_flags,file,vm_pgoff,size)
+ * Return true if we can merge this (vm_flags,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
  *
  * We don't check here for the merged mmap wrapping around the end of pagecache
@@ -425,12 +426,12 @@ static inline int is_mergeable_vma(struc
  */
 static int
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-	struct file *file, unsigned long vm_pgoff, unsigned long size)
+	struct file *file, pgoff_t vm_pgoff)
 {
 	if (is_mergeable_vma(vma, file, vm_flags)) {
 		if (!file)
 			return 1;	/* anon mapping */
-		if (vma->vm_pgoff == vm_pgoff + size)
+		if (vma->vm_pgoff == vm_pgoff)
 			return 1;
 	}
 	return 0;
@@ -442,16 +443,16 @@ can_vma_merge_before(struct vm_area_stru
  */
 static int
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-	struct file *file, unsigned long vm_pgoff)
+	struct file *file, pgoff_t vm_pgoff)
 {
 	if (is_mergeable_vma(vma, file, vm_flags)) {
-		unsigned long vma_size;
+		pgoff_t vm_pglen;
 
 		if (!file)
 			return 1;	/* anon mapping */
 
-		vma_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-		if (vma->vm_pgoff + vma_size == vm_pgoff)
+		vm_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
 			return 1;
 	}
 	return 0;
@@ -463,12 +464,12 @@ can_vma_merge_after(struct vm_area_struc
  * both (it neatly fills a hole).
  */
 static struct vm_area_struct *vma_merge(struct mm_struct *mm,
-			struct vm_area_struct *prev,
-			struct rb_node *rb_parent, unsigned long addr, 
+			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
-		     	struct file *file, unsigned long pgoff,
+		     	struct file *file, pgoff_t pgoff,
 		        struct mempolicy *policy)
 {
+	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *next;
 
 	/*
@@ -479,7 +480,7 @@ static struct vm_area_struct *vma_merge(
 		return NULL;
 
 	if (!prev) {
-		next = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
+		next = mm->mmap;
 		goto merge_next;
 	}
 	next = prev->vm_next;
@@ -496,7 +497,7 @@ static struct vm_area_struct *vma_merge(
 		if (next && end == next->vm_start &&
 				mpol_equal(policy, vma_policy(next)) &&
 				can_vma_merge_before(next, vm_flags, file,
-					pgoff, (end - addr) >> PAGE_SHIFT)) {
+							pgoff+pglen)) {
 			vma_adjust(prev, prev->vm_start,
 				next->vm_end, prev->vm_pgoff, next);
 			if (file)
@@ -510,17 +511,18 @@ static struct vm_area_struct *vma_merge(
 		return prev;
 	}
 
+merge_next:
+
 	/*
 	 * Can this new request be merged in front of next?
 	 */
 	if (next) {
- merge_next:
 		if (end == next->vm_start &&
  				mpol_equal(policy, vma_policy(next)) &&
 				can_vma_merge_before(next, vm_flags, file,
-					pgoff, (end - addr) >> PAGE_SHIFT)) {
-			vma_adjust(next, addr,
-				next->vm_end, pgoff, NULL);
+							pgoff+pglen)) {
+			vma_adjust(next, addr, next->vm_end,
+				next->vm_pgoff - pglen, NULL);
 			return next;
 		}
 	}
@@ -553,7 +555,8 @@ unsigned long do_mmap_pgoff(struct file 
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
 
-		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+		if ((prot & PROT_EXEC) &&
+		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
 			return -EPERM;
 	}
 
@@ -635,15 +638,14 @@ unsigned long do_mmap_pgoff(struct file 
 			return -EINVAL;
 		}
 	} else {
-		vm_flags |= VM_SHARED | VM_MAYSHARE;
 		switch (flags & MAP_TYPE) {
-		default:
-			return -EINVAL;
-		case MAP_PRIVATE:
-			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
-			/* fall through */
 		case MAP_SHARED:
+			vm_flags |= VM_SHARED | VM_MAYSHARE;
+			break;
+		case MAP_PRIVATE:
 			break;
+		default:
+			return -EINVAL;
 		}
 	}
 
@@ -682,11 +684,14 @@ munmap_back:
 		}
 	}
 
-	/* Can we just expand an old anonymous mapping? */
-	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
-		if (vma_merge(mm, prev, rb_parent, addr, addr + len,
-					vm_flags, NULL, pgoff, NULL))
-			goto out;
+	/*
+	 * Can we just expand an old private anonymous mapping?
+	 * The VM_SHARED test is necessary because shmem_zero_setup
+	 * will create the file object for a shared anonymous map below.
+	 */
+	if (!file && !(vm_flags & VM_SHARED) &&
+	    vma_merge(mm, prev, addr, addr + len, vm_flags, NULL, 0, NULL))
+		goto out;
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -743,10 +748,8 @@ munmap_back:
 	 */
 	addr = vma->vm_start;
 
-	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr,
-					      vma->vm_end,
-					      vma->vm_flags, file, pgoff,
-					      vma_policy(vma))) {
+	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
+			vma->vm_flags, file, pgoff, vma_policy(vma))) {
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -1429,9 +1432,8 @@ unsigned long do_brk(unsigned long addr,
 
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
-	/* Can we just expand an old anonymous mapping? */
-	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
-					flags, NULL, 0, NULL))
+	/* Can we just expand an old private anonymous mapping? */
+	if (vma_merge(mm, prev, addr, addr + len, flags, NULL, 0, NULL))
 		goto out;
 
 	/*
@@ -1524,7 +1526,7 @@ void insert_vm_struct(struct mm_struct *
  * prior to moving page table entries, to effect an mremap move.
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
-	unsigned long addr, unsigned long len, unsigned long pgoff)
+	unsigned long addr, unsigned long len, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -1534,7 +1536,7 @@ struct vm_area_struct *copy_vma(struct v
 	struct mempolicy *pol;
 
 	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
-	new_vma = vma_merge(mm, prev, rb_parent, addr, addr + len,
+	new_vma = vma_merge(mm, prev, addr, addr + len,
 			vma->vm_flags, vma->vm_file, pgoff, vma_policy(vma));
 	if (new_vma) {
 		/*

