Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDCB0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUDCB0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:26:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53677
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261505AbUDCB0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:26:13 -0500
Date: Sat, 3 Apr 2004 03:26:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: anon-vma (and now filebacked-mappings too) mprotect vma merging [Re: 2.6.5-rc2-aa vma merging]
Message-ID: <20040403012612.GY21341@dualathlon.random>
References: <Pine.LNX.4.44.0403292044530.19124-100000@localhost.localdomain> <Pine.LNX.4.44.0404021208500.4414-100000@localhost.localdomain> <20040402153522.GC21341@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402153522.GC21341@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:35:22PM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 02, 2004 at 12:34:29PM +0100, Hugh Dickins wrote:
> > Sorry to be boring, Andrea, but 2.6.5-rc3-aa2 is now out, and you
> > have still not fixed the vma merging issue: I don't believe you can.
> 
> Hugh, it will get fixed perfectly, so please give me the time to fix
> swap suspend, then I can care about minor issues.

here we go with the mprotect merging, try this on top of 2.6.5-rc3-aa2.

Your testcase output:

[..]
 981140 kB
 981144 kB
 981148 kB
 981152 kB
 981156 kB
 981160 kB
 981164 kB
 981168 kB
 981172 kB
 981176 kB
 981180 kB
 981184 kB
 981188 kB
 981192 kB
 981196 kB

hanging now in a oom condition (it's 1G box) because I had no swap
(looks like the VM is totally broken w/o swap, nothing gets killed in a
obvious oom scenario that would be resolved by the 2.4 vm in a second [I
mean, without swap!], anyways I could break it with C^c after waiting
half a minute with some faith in the vm not being completely locked up
w/o swap).

Now I did mkswap /dev/sda1 and swapon -a, so I'll try again now with
swap (it didn't get swap because a previous swap-restore crashed).

2095720 kB
2095724 kB
2095728 kB
2095732 kB
2095736 kB
2095740 kB
2095744 kB
2095748 kB
2095752 kB
2095756 kB
2095760 kB
2095764 kB
2095768 kB
2095772 kB
2095776 kB
2095780 kB
2095784 kB
2095788 kB
2095792 kB
2095796 kB
2095800 kB
2095804 kB
2095808 kB
2095812 kB
mmap: Cannot allocate memory
Type <Return> to exit
xeon:~ # 

it worked better this time after some swap, the oom was because the
address space was finished.

I run it another time stopping it in the middle to verify the number of
mappings and the merging:

[..]
 1315 pts/0    T      0:03 ./mprotect-merge
 1316 pts/0    R      0:00 ps x
xeon:~ # cat /proc/1315/maps 
08048000-08049000 r-xp 00000000 08:02 611014     /root/mprotect-merge
08049000-0804a000 rw-p 00000000 08:02 611014     /root/mprotect-merge
40000000-40014000 r-xp 00000000 08:02 443256     /lib/ld-2.3.2.so
40014000-40015000 rw-p 00014000 08:02 443256     /lib/ld-2.3.2.so
40015000-40016000 r--p 40015000 00:00 0 
40016000-40017000 rw-p 40016000 00:00 0 
40017000-40028000 r--p 40017000 00:00 0 
40028000-40157000 r-xp 00000000 08:02 443262     /lib/libc.so.6
40157000-4015b000 rw-p 0012f000 08:02 443262     /lib/libc.so.6
4015b000-4015e000 rw-p 4015b000 00:00 0 
4015e000-6f80d000 r--p 4015e000 00:00 0 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 1 vma for all
bfffd000-c0000000 rwxp bfffd000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 
xeon:~ # 

here the last seconds of swapout before I press the key to exit after
the address space is finished:

 1  3 1101252   9860    740   5280    0 33224     0 33228 2231  2193  3  8  8 80
 4  1 1120564   4360    744   5368  340 18960   476 19164 1730  3866  2  8 44 45
 0  0 1143692   6220    588   4544   88 23912   156 23912 2820  2160  1  5 54 41
 0  0 1143692   6296    588   4544    0    0     0     0 1064    23  0  0 100  0
 0  0 1143692   6296    596   4536    0    0     0    32 1008    37  0  0 100  0
 0  0 1143692   6296    596   4536    0    0     0     0 1004    27  0  0 100  0
 0  0 1143692   6308    596   4536    0    0     0     0 1005    29  0  0 100  0
 0  0 1143692   6308    596   4536    0    0     0     0 1004    31  0  0 100  0
 0  0 1143692   6308    596   4536    0    0     0     0 1005    29  0  0 100  0
 0  0 1143692   6308    596   4536    0    0     0     0 1004    31  0  0 100  0
 0  0 1143692   6388    596   4536    0    0     0     0 1005    33  0  0 100  0
 0  0 1143692   6388    596   4536    0    0     0     0 1004    29  0  0 100  0
 0  0  13268 998296    596   4476  132    0   152     0 1023    59  0  7 92  1
 0  0  13268 998296    596   4476    0    0     0     0 1004    25  0  0 100  0
 0  0  13268 998336    612   4444   16    0    56     0 1013    51  0  0 99  1


Ok now that the basic testing is over and it's all running successful on the
test box I'll load the thing on my desktop. Note: I will keep this at the very
end of my patchset (if you see it's also incremental with prio-tree) because
this is an add-on and it had zero testing yet, kernel is perfectly
stable even without this (partly new for file mappings) merging-feature.
I encountered no bugs while writing this. However I did some cleanup
in the process of creating some better helper API to use in common with
mmap.c.

Most important: now file mappings gets merged perfectly through mprotect
too (still untested though, but if anon-vma merging works file merging
will most certainly too), that has never been possible in any linux yet
(I believe this is more useful than the anon-vma merging infact, I know
some big app using mprotect on filebacked mappings).

The spinlocking is cleaned up as well, compared to mainline, now only
the mmap_sem semaphore (in write mode) protects the vma merging, no need
of page_table_lock spinlock anymore except while walking the pagetables.

--- x/include/linux/mm.h.~1~	2004-04-02 20:37:14.000000000 +0200
+++ x/include/linux/mm.h	2004-04-03 03:02:07.362304072 +0200
@@ -751,6 +751,7 @@ extern int do_munmap(struct mm_struct *,
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
+/* vma merging helpers */
 static inline void
 __vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev)
@@ -761,14 +762,48 @@ __vma_unlink(struct mm_struct *mm, struc
 		mm->mmap_cache = prev;
 }
 
-static inline int
-can_vma_merge(struct vm_area_struct *vma, unsigned long vm_flags)
+extern void __remove_shared_vm_struct(struct vm_area_struct *, struct inode *,
+				      struct address_space *);
+
+/*
+ * If the vma has a ->close operation then the driver probably needs to release
+ * per-vma resources, so we don't attempt to merge those.
+ */
+#define VM_SPECIAL (VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_RESERVED)
+
+static inline int is_mergeable_vma(struct vm_area_struct *vma,
+				   struct file *file,
+				   unsigned long vm_flags,
+				   unsigned long pgoff,
+				   anon_vma_t ** anon_vma_cache)
 {
-#ifdef CONFIG_MMU
-	if (!vma->vm_file && vma->vm_flags == vm_flags)
-		return 1;
-#endif
-	return 0;
+	if (vma->vm_ops && vma->vm_ops->close)
+		return 0;
+	if (vma->vm_file != file)
+		return 0;
+	if (vma->vm_pgoff != pgoff)
+		return 0;
+	if (vma->vm_private_data)
+		return 0;
+	if (vma->vm_flags != vm_flags) {
+		/*
+		 * If the only difference between two adiacent
+		 * vmas is the page protection we try to
+		 * share the same anon_vma to maximize the
+		 * merging in mprotect.
+		 */
+		if (anon_vma_cache && !*anon_vma_cache)
+			*anon_vma_cache = vma->anon_vma;
+		return 0;
+	}
+	return 1;
+}
+
+static inline int is_mergeable_anon_vma(struct vm_area_struct *prev,
+					struct vm_area_struct *next)
+{
+	return ((!next->anon_vma || !prev->anon_vma) ||
+		(next->anon_vma == prev->anon_vma));
 }
 
 /* filemap.c */
--- x/mm/mmap.c.~1~	2004-04-02 20:37:14.000000000 +0200
+++ x/mm/mmap.c	2004-04-03 02:59:15.959361280 +0200
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(vm_committed_space);
 /*
  * Requires inode->i_mapping->i_shared_sem
  */
-static void
+void
 __remove_shared_vm_struct(struct vm_area_struct *vma, struct inode *inode,
 			  struct address_space * mapping)
 {
@@ -343,26 +343,6 @@ __insert_vm_struct(struct mm_struct * mm
 }
 
 /*
- * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those.
- */
-#define VM_SPECIAL (VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_RESERVED)
-
-static inline int is_mergeable_vma(struct vm_area_struct *vma,
-			struct file *file, unsigned long vm_flags)
-{
-	if (vma->vm_ops && vma->vm_ops->close)
-		return 0;
-	if (vma->vm_file != file)
-		return 0;
-	if (vma->vm_flags != vm_flags)
-		return 0;
-	if (vma->vm_private_data)
-		return 0;
-	return 1;
-}
-
-/*
  * Return true if we can merge this (vm_flags,file,vm_pgoff,size)
  * in front of (at a lower virtual address and file offset than) the vma.
  *
@@ -373,26 +353,25 @@ static inline int is_mergeable_vma(struc
 static int
 can_vma_merge_before(struct vm_area_struct *prev,
 		     struct vm_area_struct *vma, unsigned long vm_flags,
-		     struct file *file, unsigned long vm_pgoff, unsigned long size)
+		     struct file *file, unsigned long vm_pgoff,
+		     anon_vma_t ** anon_vma_cache)
 {
-	if (is_mergeable_vma(vma, file, vm_flags))
-		if (vma->vm_pgoff == vm_pgoff + size) {
-			if (prev) {
-				/*
-				 * We can fill an hole only if the two
-				 * anonymous mappings are queued in the same
-				 * anon_vma, or if one of them is "direct"
-				 * and it can be queued in the existing
-				 * anon_vma.
-				 *
-				 * Must check this even if file != NULL
-				 * for MAP_PRIVATE mappings.
-				 */
-				return ((!vma->anon_vma || !prev->anon_vma) ||
-					(vma->anon_vma == prev->anon_vma));
-			}
-			return 1;
+	if (is_mergeable_vma(vma, file, vm_flags, vm_pgoff, anon_vma_cache)) {
+		if (prev) {
+			/*
+			 * We can fill an hole only if the two
+			 * anonymous mappings are queued in the same
+			 * anon_vma, or if one of them is "direct"
+			 * and it can be queued in the existing
+			 * anon_vma.
+			 *
+			 * Must check this even if file != NULL
+			 * for MAP_PRIVATE mappings.
+			 */
+			return is_mergeable_anon_vma(prev, vma);
 		}
+		return 1;
+	}
 	return 0;
 }
 
@@ -402,16 +381,11 @@ can_vma_merge_before(struct vm_area_stru
  */
 static int
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-	struct file *file, unsigned long vm_pgoff)
+		    struct file *file, unsigned long vm_pgoff,
+		    anon_vma_t ** anon_vma_cache)
 {
-	if (is_mergeable_vma(vma, file, vm_flags)) {
-		unsigned long vma_size;
-
-		vma_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-		if (vma->vm_pgoff + vma_size == vm_pgoff)
-			return 1;
-	}
-	return 0;
+	unsigned long vma_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	return is_mergeable_vma(vma, file, vm_flags, vm_pgoff - vma_size, anon_vma_cache);
 }
 
 /*
@@ -420,14 +394,15 @@ can_vma_merge_after(struct vm_area_struc
  * both (it neatly fills a hole).
  */
 static int vma_merge(struct mm_struct *mm, struct vm_area_struct *prev,
-			struct rb_node *rb_parent, unsigned long addr, 
-			unsigned long end, unsigned long vm_flags,
-			struct file *file, unsigned long pgoff)
+		     struct rb_node *rb_parent, unsigned long addr, 
+		     unsigned long end, unsigned long vm_flags,
+		     struct file *file, unsigned long pgoff,
+		     anon_vma_t ** anon_vma_cache)
 {
-	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
-	struct address_space *mapping = file ? file->f_mapping : NULL;
+	struct inode *inode;
+	struct address_space *mapping;
 	struct semaphore *i_shared_sem;
-	struct prio_tree_root *root = NULL;
+	struct prio_tree_root *root;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags, so this tests
@@ -436,14 +411,24 @@ static int vma_merge(struct mm_struct *m
 	if (vm_flags & VM_SPECIAL)
 		return 0;
 
-	i_shared_sem = file ? &file->f_mapping->i_shared_sem : NULL;
+	/*
+	 * Only "root" and "inode" have to be NULL too if "file" is null,
+	 * however mapping and i_shared_sem would cause gcc to warn about
+	 * uninitialized usage so we set them to NULL too.
+	 */
+	inode = NULL;
+	root = NULL;
+	i_shared_sem = NULL;
+	mapping = NULL;
+	if (file) {
+		inode = file->f_dentry->d_inode;
+		mapping = file->f_mapping;
+		i_shared_sem = &mapping->i_shared_sem;
 
-	if (mapping) {
 		if (vm_flags & VM_SHARED) {
 			if (likely(!(vm_flags & VM_NONLINEAR)))
 				root = &mapping->i_mmap_shared;
-		}
-		else
+		} else
 			root = &mapping->i_mmap;
 	}
 
@@ -456,7 +441,7 @@ static int vma_merge(struct mm_struct *m
 	 * Can it merge with the predecessor?
 	 */
 	if (prev->vm_end == addr &&
-			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
+	    can_vma_merge_after(prev, vm_flags, file, pgoff, anon_vma_cache)) {
 		struct vm_area_struct *next;
 
 		/*
@@ -465,8 +450,9 @@ static int vma_merge(struct mm_struct *m
 		next = prev->vm_next;
 		/* next cannot change under us, it's serialized by the mmap_sem */
 		if (next && end == next->vm_start &&
-				can_vma_merge_before(prev, next, vm_flags, file,
-					pgoff, (end - addr) >> PAGE_SHIFT)) {
+		    can_vma_merge_before(prev, next, vm_flags, file,
+					 pgoff + ((end - addr) >> PAGE_SHIFT),
+					 anon_vma_cache)) {
 			/* serialized by the mmap_sem */
 			__vma_unlink(mm, next, prev);
 
@@ -516,10 +502,10 @@ static int vma_merge(struct mm_struct *m
 	prev = prev->vm_next;
 	if (prev) {
  merge_next:
-		if (!can_vma_merge_before(NULL, prev, vm_flags, file,
-				pgoff, (end - addr) >> PAGE_SHIFT))
-			return 0;
-		if (end == prev->vm_start) {
+		if (end == prev->vm_start &&
+		    can_vma_merge_before(NULL, prev, vm_flags, file,
+					 pgoff + ((end - addr) >> PAGE_SHIFT),
+					 anon_vma_cache)) {
 			if (file)
 				down(i_shared_sem);
 			anon_vma_lock(prev);
@@ -551,6 +537,7 @@ unsigned long do_mmap_pgoff(struct file 
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged = 0;
+	anon_vma_t * anon_vma_cache;
 
 	if (file) {
 		if (!file->f_op || !file->f_op->mmap)
@@ -686,9 +673,10 @@ munmap_back:
 	}
 
 	/* Can we just expand an old anonymous mapping? */
+	anon_vma_cache = NULL;
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
 		if (vma_merge(mm, prev, rb_parent, addr, addr + len,
-					vm_flags, NULL, pgoff))
+					vm_flags, NULL, pgoff, &anon_vma_cache))
 			goto out;
 
 	/*
@@ -712,7 +700,6 @@ munmap_back:
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
 	INIT_VMA_SHARED(vma);
-	vma->anon_vma = NULL;
 
 	if (file) {
 		error = -EINVAL;
@@ -751,7 +738,9 @@ munmap_back:
 	addr = vma->vm_start;
 
 	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr,
-				addr + len, vma->vm_flags, file, pgoff)) {
+					      addr + len, vma->vm_flags, file, pgoff,
+					      &anon_vma_cache)) {
+		vma->anon_vma = anon_vma_cache;
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -1409,6 +1398,7 @@ unsigned long do_brk(unsigned long addr,
 	unsigned long flags;
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long pgoff;
+	anon_vma_t * anon_vma_cache;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1454,8 +1444,9 @@ unsigned long do_brk(unsigned long addr,
 	pgoff = addr >> PAGE_SHIFT;
 
 	/* Can we just expand an old anonymous mapping? */
+	anon_vma_cache = NULL;
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
-					flags, NULL, pgoff))
+				   flags, NULL, pgoff, &anon_vma_cache))
 		goto out;
 
 	/*
@@ -1477,7 +1468,7 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	INIT_VMA_SHARED(vma);
-	vma->anon_vma = NULL;
+	vma->anon_vma = anon_vma_cache;
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 
--- x/mm/fremap.c.~1~	2004-04-02 20:37:14.000000000 +0200
+++ x/mm/fremap.c	2004-04-02 20:51:11.873652616 +0200
@@ -61,9 +61,8 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, addr);
-
+	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
 		goto err_unlock;
@@ -103,9 +102,8 @@ int install_file_pte(struct mm_struct *m
 	pmd_t *pmd;
 	pte_t pte_val;
 
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, addr);
-
+	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
 		goto err_unlock;
--- x/mm/mprotect.c.~1~	2004-04-02 20:37:13.928039712 +0200
+++ x/mm/mprotect.c	2004-04-03 01:46:44.987809496 +0200
@@ -16,6 +16,8 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/objrmap.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -107,7 +109,6 @@ change_protection(struct vm_area_struct 
 	return;
 }
 
-#if VMA_MERGING_FIXUP
 /*
  * Try to merge a vma with the previous flag, return 1 if successful or 0 if it
  * was impossible.
@@ -116,42 +117,174 @@ static int
 mprotect_attempt_merge(struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long end, int newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	unsigned long prev_pgoff;
+	struct file *file;
+	struct inode *inode;
+	struct address_space *mapping;
+	struct semaphore *i_shared_sem;
+	struct prio_tree_root *root;
 
-	if (!prev || !vma)
+	if (newflags & VM_SPECIAL)
+		return 0;
+	if (!prev)
 		return 0;
 	if (prev->vm_end != vma->vm_start)
 		return 0;
-	if (!can_vma_merge(prev, newflags))
+
+	prev_pgoff = vma->vm_pgoff - ((prev->vm_end - prev->vm_start) >> PAGE_SHIFT);
+	file = vma->vm_file;
+	if (!is_mergeable_vma(prev, file, newflags, prev_pgoff, NULL))
 		return 0;
-	if (vma->vm_file || (vma->vm_flags & VM_SHARED))
+	if (!is_mergeable_anon_vma(prev, vma))
 		return 0;
 
 	/*
+	 * Only "root" and "inode" have to be NULL too if "file" is null,
+	 * however mapping and i_shared_sem would cause gcc to warn about
+	 * uninitialized usage so we set them to NULL too.
+	 */
+	inode = NULL;
+	root = NULL;
+	i_shared_sem = NULL;
+	mapping = NULL;
+	if (file) {
+		inode = file->f_dentry->d_inode;
+		mapping = file->f_mapping;
+		i_shared_sem = &mapping->i_shared_sem;
+
+		if (vma->vm_flags & VM_SHARED) {
+			if (likely(!(vma->vm_flags & VM_NONLINEAR)))
+				root = &mapping->i_mmap_shared;
+		} else
+			root = &mapping->i_mmap;
+	}
+
+	/*
 	 * If the whole area changes to the protection of the previous one
 	 * we can just get rid of it.
 	 */
 	if (end == vma->vm_end) {
-		spin_lock(&mm->page_table_lock);
-		prev->vm_end = end;
+		struct mm_struct * mm = vma->vm_mm;
+
+		/* serialized by the mmap_sem */
 		__vma_unlink(mm, vma, prev);
-		spin_unlock(&mm->page_table_lock);
 
-		kmem_cache_free(vm_area_cachep, vma);
+		if (file)
+			down(i_shared_sem);
+		__vma_modify(root, prev, prev->vm_start,
+			     end, prev->vm_pgoff);
+
+		__remove_shared_vm_struct(vma, inode, mapping);
+		if (file)
+			up(i_shared_sem);
+
+		/*
+		 * The anon_vma_lock is taken inside and
+		 * we can race with the vm_end move on the right,
+		 * that will not be a problem, moves on the right
+		 * of vm_end are controlled races.
+		 */
+		anon_vma_merge(prev, vma);
+
+		if (file)
+			fput(file);
+
 		mm->map_count--;
+		kmem_cache_free(vm_area_cachep, vma);
 		return 1;
 	} 
 
 	/*
 	 * Otherwise extend it.
 	 */
-	spin_lock(&mm->page_table_lock);
-	prev->vm_end = end;
-	vma->vm_start = end;
-	spin_unlock(&mm->page_table_lock);
+	if (file)
+		down(i_shared_sem);
+	__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
+	__vma_modify(root, vma, end, vma->vm_end,
+		     vma->vm_pgoff + ((end - vma->vm_start) >> PAGE_SHIFT));
+	if (file)
+		up(i_shared_sem);
 	return 1;
 }
-#endif
+
+static void
+mprotect_attempt_merge_final(struct vm_area_struct *prev,
+			     struct vm_area_struct *next)
+{
+	unsigned long next_pgoff;
+	struct file * file;
+	struct inode *inode;
+	struct address_space *mapping;
+	struct semaphore *i_shared_sem;
+	struct prio_tree_root *root;
+	struct mm_struct * mm;
+	unsigned int newflags;
+
+	if (!next)
+		return;
+	if (prev->vm_end != next->vm_start)
+		return;
+	newflags = prev->vm_flags;
+	if (newflags & VM_SPECIAL)
+		return;
+
+	next_pgoff = prev->vm_pgoff + ((prev->vm_end - prev->vm_start) >> PAGE_SHIFT);
+	file = prev->vm_file;
+	if (!is_mergeable_vma(next, file, newflags, next_pgoff, NULL))
+		return;
+	if (!is_mergeable_anon_vma(prev, next))
+		return;
+
+
+	/*
+	 * Only "root" and "inode" have to be NULL too if "file" is null,
+	 * however mapping and i_shared_sem would cause gcc to warn about
+	 * uninitialized usage so we set them to NULL too.
+	 */
+	inode = NULL;
+	root = NULL;
+	i_shared_sem = NULL;
+	mapping = NULL;
+	if (file) {
+		inode = file->f_dentry->d_inode;
+		mapping = file->f_mapping;
+		i_shared_sem = &mapping->i_shared_sem;
+
+		if (next->vm_flags & VM_SHARED) {
+			if (likely(!(next->vm_flags & VM_NONLINEAR)))
+				root = &mapping->i_mmap_shared;
+		} else
+			root = &mapping->i_mmap;
+	}
+
+	mm = next->vm_mm;
+
+	/* serialized by the mmap_sem */
+	__vma_unlink(mm, next, prev);
+
+	if (file)
+		down(i_shared_sem);
+	__vma_modify(root, prev, prev->vm_start,
+		     next->vm_end, prev->vm_pgoff);
+
+	__remove_shared_vm_struct(next, inode, mapping);
+	if (file)
+		up(i_shared_sem);
+
+	/*
+	 * The anon_vma_lock is taken inside and
+	 * we can race with the vm_end move on the right,
+	 * that will not be a problem, moves on the right
+	 * of vm_end are controlled races.
+	 */
+	anon_vma_merge(prev, next);
+
+	if (file)
+		fput(file);
+
+	mm->map_count--;
+	kmem_cache_free(vm_area_cachep, next);
+}
 
 static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
@@ -187,7 +320,6 @@ mprotect_fixup(struct vm_area_struct *vm
 	newprot = protection_map[newflags & 0xf];
 
 	if (start == vma->vm_start) {
-#if VMA_MERGING_FIXUP
 		/*
 		 * Try to merge with the previous vma.
 		 */
@@ -195,7 +327,6 @@ mprotect_fixup(struct vm_area_struct *vm
 			vma = *pprev;
 			goto success;
 		}
-#endif
 	} else {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
@@ -213,13 +344,13 @@ mprotect_fixup(struct vm_area_struct *vm
 			goto fail;
 	}
 
-	spin_lock(&mm->page_table_lock);
+	/*
+	 * vm_flags and vm_page_prot are protected by the mmap_sem
+	 * hold in write mode.
+	 */
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
-	spin_unlock(&mm->page_table_lock);
-#if VMA_MERGING_FIXUP
 success:
-#endif
 	change_protection(vma, start, end, newprot);
 	return 0;
 
@@ -321,19 +452,7 @@ sys_mprotect(unsigned long start, size_t
 		}
 	}
 
-#if VMA_MERGING_FIXUP
-	if (next && prev->vm_end == next->vm_start &&
-			can_vma_merge(next, prev->vm_flags) &&
-			!prev->vm_file && !(prev->vm_flags & VM_SHARED)) {
-		spin_lock(&prev->vm_mm->page_table_lock);
-		prev->vm_end = next->vm_end;
-		__vma_unlink(prev->vm_mm, next, prev);
-		spin_unlock(&prev->vm_mm->page_table_lock);
-
-		kmem_cache_free(vm_area_cachep, next);
-		prev->vm_mm->map_count--;
-	}
-#endif
+	mprotect_attempt_merge_final(prev, next);
 out:
 	up_write(&current->mm->mmap_sem);
 	return error;

