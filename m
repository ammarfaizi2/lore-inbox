Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUERWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUERWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUERWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:17:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13078 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263671AbUERWLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:11:24 -0400
Date: Tue, 18 May 2004 23:11:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 39 add anon_vma rmap
In-Reply-To: <Pine.LNX.4.44.0405182304150.3416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405182310200.3416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli's anon_vma object-based reverse mapping scheme for
anonymous pages.  Instead of tracking anonymous pages by pte_chains
or by mm, this tracks them by vma.  But because vmas are frequently
split and merged (particularly by mprotect), a page cannot point
directly to its vma(s), but instead to an anon_vma list of those
vmas likely to contain the page - a list on which vmas can easily
be linked and unlinked as they come and go.  The vmas on one list
are all related, either by forking or by splitting.

This has three particular advantages over anonmm: that it can cope
effortlessly with mremap moves; and no longer needs page_table_lock
to protect an mm's vma tree, since try_to_unmap finds vmas via page
-> anon_vma -> vma instead of using find_vma; and should use less
cpu for swapout since it can locate its anonymous vmas more quickly.

It does have disadvantages too: a lot more change in mmap.c to deal
with anon_vmas, though small straightforward additions now that the
vma merging has been refactored there; more lowmem needed for each
anon_vma and vma structure; an additional restriction on the merging
of vmas (cannot be merged if already assigned different anon_vmas,
since then their pages will be pointing to different heads).

(There would be no need to enlarge the vma structure if anonymous pages
belonged only to anonymous vmas; but private file mappings accumulate
anonymous pages by copy-on-write, so need to be listed in both anon_vma
and prio_tree at the same time.  A different implementation could avoid
that by using anon_vmas only for purely anonymous vmas, and use the
existing prio_tree to locate cow pages - but that would involve a
long search for each single private copy, probably not a good idea.)

Where before the vm_pgoff of a purely anonymous (not file-backed) vma
was meaningless, now it represents the virtual start address at which
that vma is mapped - which the standard file pgoff manipulations treat
linearly as vmas are split and merged.  But if mremap moves the vma,
then it generally carries its original vm_pgoff to the new location,
so pages shared with the old location can still be found.  Magic.

Hugh has massaged it somewhat: building on the earlier rmap patches,
this patch is a fifth of the size of Andrea's original anon_vma patch.
Please note that this posting will be his first sight of this patch,
which he may or may not approve.

 fs/exec.c            |    4 
 include/linux/mm.h   |   20 +++
 include/linux/rmap.h |   63 +++++++++++-
 init/main.c          |    2 
 kernel/fork.c        |    3 
 mm/memory.c          |   10 +
 mm/mmap.c            |  159 ++++++++++++++++++++++--------
 mm/mprotect.c        |    2 
 mm/rmap.c            |  265 +++++++++++++++++++++++++++++++++++++++++++--------
 9 files changed, 439 insertions(+), 89 deletions(-)

--- rmap38/fs/exec.c	2004-05-18 20:51:12.074665480 +0100
+++ rmap39/fs/exec.c	2004-05-18 20:51:40.069409632 +0100
@@ -302,6 +302,9 @@ void install_arg_page(struct vm_area_str
 	pmd_t * pmd;
 	pte_t * pte;
 
+	if (unlikely(anon_vma_prepare(vma)))
+		goto out_sig;
+
 	flush_dcache_page(page);
 	pgd = pgd_offset(mm, address);
 
@@ -328,6 +331,7 @@ void install_arg_page(struct vm_area_str
 	return;
 out:
 	spin_unlock(&mm->page_table_lock);
+out_sig:
 	__free_page(page);
 	force_sig(SIGKILL, current);
 }
--- rmap38/include/linux/mm.h	2004-05-18 20:50:58.875672032 +0100
+++ rmap39/include/linux/mm.h	2004-05-18 20:51:40.071409328 +0100
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 
 struct mempolicy;
+struct anon_vma;
 
 #ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
@@ -78,6 +79,15 @@ struct vm_area_struct {
 		struct prio_tree_node prio_tree_node;
 	} shared;
 
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.  A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_node;	/* Serialized by anon_vma->lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
 
@@ -201,7 +211,12 @@ struct page {
 					 * if PagePrivate set; used for
 					 * swp_entry_t if PageSwapCache
 					 */
-	struct address_space *mapping;	/* The inode (or ...) we belong to. */
+	struct address_space *mapping;	/* If PG_anon clear, points to
+					 * inode address_space, or NULL.
+					 * If page mapped as anonymous
+					 * memory, PG_anon is set, and
+					 * it points to anon_vma object.
+					 */
 	pgoff_t index;			/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list
 					 * protected by zone->lru_lock !
@@ -610,7 +625,8 @@ extern void vma_adjust(struct vm_area_st
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert);
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct file *, pgoff_t, struct mempolicy *);
+	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
+	struct mempolicy *);
 extern int split_vma(struct mm_struct *,
 	struct vm_area_struct *, unsigned long addr, int new_below);
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
--- rmap38/include/linux/rmap.h	2004-05-18 20:51:27.664295496 +0100
+++ rmap39/include/linux/rmap.h	2004-05-18 20:51:40.072409176 +0100
@@ -2,18 +2,75 @@
 #define _LINUX_RMAP_H
 /*
  * Declarations for Reverse Mapping functions in mm/rmap.c
- * Its structures are declared within that file.
  */
 
 #include <linux/config.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define page_map_lock(page) \
 	bit_spin_lock(PG_maplock, (unsigned long *)&(page)->flags)
 #define page_map_unlock(page) \
 	bit_spin_unlock(PG_maplock, (unsigned long *)&(page)->flags)
 
+/*
+ * The anon_vma heads a list of private "related" vmas, to scan if
+ * an anonymous page pointing to this anon_vma needs to be unmapped:
+ * the vmas on the list will be related by forking, or by splitting.
+ *
+ * Since vmas come and go as they are split and merged (particularly
+ * in mprotect), the mapping field of an anonymous page cannot point
+ * directly to a vma: instead it points to an anon_vma, on whose list
+ * the related vmas can be easily linked or unlinked.
+ *
+ * After unlinking the last vma on the list, we must garbage collect
+ * the anon_vma object itself: we're guaranteed no page can be
+ * pointing to this anon_vma once its vma list is empty.
+ */
+struct anon_vma {
+	spinlock_t lock;	/* Serialize access to vma list */
+	struct list_head head;	/* List of private "related" vmas */
+};
+
 #ifdef CONFIG_MMU
 
+extern kmem_cache_t *anon_vma_cachep;
+
+static inline struct anon_vma *anon_vma_alloc(void)
+{
+	return kmem_cache_alloc(anon_vma_cachep, SLAB_KERNEL);
+}
+
+static inline void anon_vma_free(struct anon_vma *anon_vma)
+{
+	kmem_cache_free(anon_vma_cachep, anon_vma);
+}
+
+static inline void anon_vma_lock(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+	if (anon_vma)
+		spin_lock(&anon_vma->lock);
+}
+
+static inline void anon_vma_unlock(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+	if (anon_vma)
+		spin_unlock(&anon_vma->lock);
+}
+
+/*
+ * anon_vma helper functions.
+ */
+void anon_vma_init(void);	/* create anon_vma_cachep */
+int  anon_vma_prepare(struct vm_area_struct *);
+void __anon_vma_merge(struct vm_area_struct *, struct vm_area_struct *);
+void anon_vma_unlink(struct vm_area_struct *);
+void anon_vma_link(struct vm_area_struct *);
+void __anon_vma_link(struct vm_area_struct *);
+
 /*
  * rmap interfaces called when adding or removing pte of page
  */
@@ -43,6 +100,10 @@ int try_to_unmap(struct page *);
 
 #else	/* !CONFIG_MMU */
 
+#define anon_vma_init()		do {} while (0)
+#define anon_vma_prepare(vma)	(0)
+#define anon_vma_link(vma)	do {} while (0)
+
 #define page_referenced(page)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
--- rmap38/init/main.c	2004-05-16 11:39:22.000000000 +0100
+++ rmap39/init/main.c	2004-05-18 20:51:40.073409024 +0100
@@ -42,6 +42,7 @@
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/unistd.h>
+#include <linux/rmap.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -466,6 +467,7 @@ asmlinkage void __init start_kernel(void
 	pidmap_init();
 	pgtable_cache_init();
 	prio_tree_init();
+	anon_vma_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
--- rmap38/kernel/fork.c	2004-05-18 20:51:27.667295040 +0100
+++ rmap39/kernel/fork.c	2004-05-18 20:51:40.074408872 +0100
@@ -322,8 +322,9 @@ static inline int dup_mmap(struct mm_str
 		tmp->vm_flags &= ~VM_LOCKED;
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
-		file = tmp->vm_file;
+		anon_vma_link(tmp);
 		vma_prio_tree_init(tmp);
+		file = tmp->vm_file;
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
--- rmap38/mm/memory.c	2004-05-18 20:51:27.703289568 +0100
+++ rmap39/mm/memory.c	2004-05-18 20:51:40.076408568 +0100
@@ -1082,6 +1082,8 @@ static int do_wp_page(struct mm_struct *
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
+	if (unlikely(anon_vma_prepare(vma)))
+		goto no_new_page;
 	new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 	if (!new_page)
 		goto no_new_page;
@@ -1416,6 +1418,8 @@ do_anonymous_page(struct mm_struct *mm, 
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 
+		if (unlikely(anon_vma_prepare(vma)))
+			goto no_mem;
 		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
 		if (!page)
 			goto no_mem;
@@ -1498,7 +1502,11 @@ retry:
 	 * Should we do an early C-O-W break?
 	 */
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
-		struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		struct page *page;
+
+		if (unlikely(anon_vma_prepare(vma)))
+			goto oom;
+		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
--- rmap38/mm/mmap.c	2004-05-18 20:50:58.878671576 +0100
+++ rmap39/mm/mmap.c	2004-05-18 20:51:40.080407960 +0100
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -99,6 +100,7 @@ static void remove_vm_struct(struct vm_a
 		vma->vm_ops->close(vma);
 	if (file)
 		fput(file);
+	anon_vma_unlink(vma);
 	mpol_free(vma_policy(vma));
 	kmem_cache_free(vm_area_cachep, vma);
 }
@@ -294,6 +296,7 @@ __vma_link(struct mm_struct *mm, struct 
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	__vma_link_file(vma);
+	__anon_vma_link(vma);
 }
 
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -307,9 +310,9 @@ static void vma_link(struct mm_struct *m
 
 	if (mapping)
 		spin_lock(&mapping->i_mmap_lock);
-	spin_lock(&mm->page_table_lock);
+	anon_vma_lock(vma);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
-	spin_unlock(&mm->page_table_lock);
+	anon_vma_unlock(vma);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 
@@ -320,7 +323,7 @@ static void vma_link(struct mm_struct *m
 
 /*
  * Insert vm structure into process list sorted by address and into the
- * inode's i_mmap tree. The caller should hold mm->page_table_lock and
+ * inode's i_mmap tree. The caller should hold mm->mmap_sem and
  * ->f_mappping->i_mmap_lock if vm_file is non-NULL.
  */
 static void
@@ -363,6 +366,7 @@ void vma_adjust(struct vm_area_struct *v
 	struct address_space *mapping = NULL;
 	struct prio_tree_root *root = NULL;
 	struct file *file = vma->vm_file;
+	struct anon_vma *anon_vma = NULL;
 	long adjust_next = 0;
 	int remove_next = 0;
 
@@ -370,6 +374,7 @@ void vma_adjust(struct vm_area_struct *v
 		if (end >= next->vm_end) {
 again:			remove_next = 1 + (end > next->vm_end);
 			end = next->vm_end;
+			anon_vma = next->anon_vma;
 		} else if (end < vma->vm_end || end > next->vm_start) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -381,6 +386,7 @@ again:			remove_next = 1 + (end > next->
 			 */
 			BUG_ON(vma->vm_end != next->vm_start);
 			adjust_next = end - next->vm_start;
+			anon_vma = next->anon_vma;
 		}
 	}
 
@@ -390,7 +396,15 @@ again:			remove_next = 1 + (end > next->
 			root = &mapping->i_mmap;
 		spin_lock(&mapping->i_mmap_lock);
 	}
-	spin_lock(&mm->page_table_lock);
+
+	/*
+	 * When changing only vma->vm_end, we don't really need
+	 * anon_vma lock: but is that case worth optimizing out?
+	 */
+	if (vma->anon_vma)
+		anon_vma = vma->anon_vma;
+	if (anon_vma)
+		spin_lock(&anon_vma->lock);
 
 	if (root) {
 		flush_dcache_mmap_lock(mapping);
@@ -425,6 +439,8 @@ again:			remove_next = 1 + (end > next->
 		__vma_unlink(mm, next, vma);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
+		if (next->anon_vma)
+			__anon_vma_merge(vma, next);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -434,7 +450,8 @@ again:			remove_next = 1 + (end > next->
 		__insert_vm_struct(mm, insert);
 	}
 
-	spin_unlock(&mm->page_table_lock);
+	if (anon_vma)
+		spin_unlock(&anon_vma->lock);
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 
@@ -476,21 +493,29 @@ static inline int is_mergeable_vma(struc
 	return 1;
 }
 
+static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
+					struct anon_vma *anon_vma2)
+{
+	return !anon_vma1 || !anon_vma2 || (anon_vma1 == anon_vma2);
+}
+
 /*
- * Return true if we can merge this (vm_flags,file,vm_pgoff)
+ * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
  *
+ * We cannot merge two vmas if they have differently assigned (non-NULL)
+ * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
+ *
  * We don't check here for the merged mmap wrapping around the end of pagecache
  * indices (16TB on ia32) because do_mmap_pgoff() does not permit mmap's which
  * wrap, nor mmaps which cover the final page at index -1UL.
  */
 static int
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-	struct file *file, pgoff_t vm_pgoff)
+	struct anon_vma *anon_vma, struct file *file, pgoff_t vm_pgoff)
 {
-	if (is_mergeable_vma(vma, file, vm_flags)) {
-		if (!file)
-			return 1;	/* anon mapping */
+	if (is_mergeable_vma(vma, file, vm_flags) &&
+	    is_mergeable_anon_vma(anon_vma, vma->anon_vma)) {
 		if (vma->vm_pgoff == vm_pgoff)
 			return 1;
 	}
@@ -498,19 +523,19 @@ can_vma_merge_before(struct vm_area_stru
 }
 
 /*
- * Return true if we can merge this (vm_flags,file,vm_pgoff)
+ * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * beyond (at a higher virtual address and file offset than) the vma.
+ *
+ * We cannot merge two vmas if they have differently assigned (non-NULL)
+ * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
  */
 static int
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-	struct file *file, pgoff_t vm_pgoff)
+	struct anon_vma *anon_vma, struct file *file, pgoff_t vm_pgoff)
 {
-	if (is_mergeable_vma(vma, file, vm_flags)) {
+	if (is_mergeable_vma(vma, file, vm_flags) &&
+	    is_mergeable_anon_vma(anon_vma, vma->anon_vma)) {
 		pgoff_t vm_pglen;
-
-		if (!file)
-			return 1;	/* anon mapping */
-
 		vm_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
 			return 1;
@@ -550,8 +575,8 @@ can_vma_merge_after(struct vm_area_struc
 struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
-		     	struct file *file, pgoff_t pgoff,
-		        struct mempolicy *policy)
+		     	struct anon_vma *anon_vma, struct file *file,
+			pgoff_t pgoff, struct mempolicy *policy)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
@@ -576,14 +601,17 @@ struct vm_area_struct *vma_merge(struct 
 	 */
 	if (prev && prev->vm_end == addr &&
   			mpol_equal(vma_policy(prev), policy) &&
-			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
+			can_vma_merge_after(prev, vm_flags,
+						anon_vma, file, pgoff)) {
 		/*
 		 * OK, it can.  Can we now merge in the successor as well?
 		 */
 		if (next && end == next->vm_start &&
 				mpol_equal(policy, vma_policy(next)) &&
-				can_vma_merge_before(next, vm_flags, file,
-							pgoff+pglen)) {
+				can_vma_merge_before(next, vm_flags,
+					anon_vma, file, pgoff+pglen) &&
+				is_mergeable_anon_vma(prev->anon_vma,
+						      next->anon_vma)) {
 							/* cases 1, 6 */
 			vma_adjust(prev, prev->vm_start,
 				next->vm_end, prev->vm_pgoff, NULL);
@@ -598,8 +626,8 @@ struct vm_area_struct *vma_merge(struct 
 	 */
 	if (next && end == next->vm_start &&
  			mpol_equal(policy, vma_policy(next)) &&
-			can_vma_merge_before(next, vm_flags, file,
-							pgoff+pglen)) {
+			can_vma_merge_before(next, vm_flags,
+					anon_vma, file, pgoff+pglen)) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			vma_adjust(prev, prev->vm_start,
 				addr, prev->vm_pgoff, NULL);
@@ -725,6 +753,10 @@ unsigned long do_mmap_pgoff(struct file 
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			break;
 		case MAP_PRIVATE:
+			/*
+			 * Set pgoff according to addr for anon_vma.
+			 */
+			pgoff = addr >> PAGE_SHIFT;
 			break;
 		default:
 			return -EINVAL;
@@ -772,7 +804,8 @@ munmap_back:
 	 * will create the file object for a shared anonymous map below.
 	 */
 	if (!file && !(vm_flags & VM_SHARED) &&
-	    vma_merge(mm, prev, addr, addr + len, vm_flags, NULL, 0, NULL))
+	    vma_merge(mm, prev, addr, addr + len, vm_flags,
+					NULL, NULL, pgoff, NULL))
 		goto out;
 
 	/*
@@ -831,7 +864,7 @@ munmap_back:
 	addr = vma->vm_start;
 
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
-			vma->vm_flags, file, pgoff, vma_policy(vma))) {
+			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -1062,25 +1095,32 @@ int expand_stack(struct vm_area_struct *
 		return -EFAULT;
 
 	/*
+	 * We must make sure the anon_vma is allocated
+	 * so that the anon_vma locking is not a noop.
+	 */
+	if (unlikely(anon_vma_prepare(vma)))
+		return -ENOMEM;
+	anon_vma_lock(vma);
+
+	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_sem in read mode. We need to get
-	 * the spinlock only before relocating the vma range ourself.
+	 * is required to hold the mmap_sem in read mode.  We need the
+	 * anon_vma lock to serialize against concurrent expand_stacks.
 	 */
 	address += 4 + PAGE_SIZE - 1;
 	address &= PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
+		anon_vma_unlock(vma);
 		return -ENOMEM;
 	}
 	
 	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
+		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -1088,7 +1128,7 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	anon_vma_unlock(vma);
 	return 0;
 }
 
@@ -1117,24 +1157,31 @@ int expand_stack(struct vm_area_struct *
 	unsigned long grow;
 
 	/*
+	 * We must make sure the anon_vma is allocated
+	 * so that the anon_vma locking is not a noop.
+	 */
+	if (unlikely(anon_vma_prepare(vma)))
+		return -ENOMEM;
+	anon_vma_lock(vma);
+
+	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_sem in read mode. We need to get
-	 * the spinlock only before relocating the vma range ourself.
+	 * is required to hold the mmap_sem in read mode.  We need the
+	 * anon_vma lock to serialize against concurrent expand_stacks.
 	 */
 	address &= PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
+		anon_vma_unlock(vma);
 		return -ENOMEM;
 	}
 	
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
+		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -1143,7 +1190,7 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	anon_vma_unlock(vma);
 	return 0;
 }
 
@@ -1304,8 +1351,6 @@ static void unmap_region(struct mm_struc
 /*
  * Create a list of vma's touched by the unmap, removing them from the mm's
  * vma list as we go..
- *
- * Called with the page_table_lock held.
  */
 static void
 detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -1437,8 +1482,8 @@ int do_munmap(struct mm_struct *mm, unsi
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
-	spin_lock(&mm->page_table_lock);
 	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
+	spin_lock(&mm->page_table_lock);
 	unmap_region(mm, mpnt, prev, start, end);
 	spin_unlock(&mm->page_table_lock);
 
@@ -1472,6 +1517,7 @@ unsigned long do_brk(unsigned long addr,
 	struct vm_area_struct * vma, * prev;
 	unsigned long flags;
 	struct rb_node ** rb_link, * rb_parent;
+	pgoff_t pgoff = addr >> PAGE_SHIFT;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1515,7 +1561,8 @@ unsigned long do_brk(unsigned long addr,
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
 	/* Can we just expand an old private anonymous mapping? */
-	if (vma_merge(mm, prev, addr, addr + len, flags, NULL, 0, NULL))
+	if (vma_merge(mm, prev, addr, addr + len, flags,
+					NULL, NULL, pgoff, NULL))
 		goto out;
 
 	/*
@@ -1531,6 +1578,7 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
+	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = protection_map[flags & 0x0f];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
@@ -1597,6 +1645,22 @@ void insert_vm_struct(struct mm_struct *
 	struct vm_area_struct * __vma, * prev;
 	struct rb_node ** rb_link, * rb_parent;
 
+	/*
+	 * The vm_pgoff of a purely anonymous vma should be irrelevant
+	 * until its first write fault, when page's anon_vma and index
+	 * are set.  But now set the vm_pgoff it will almost certainly
+	 * end up with (unless mremap moves it elsewhere before that
+	 * first wfault), so /proc/pid/maps tells a consistent story.
+	 *
+	 * By setting it to reflect the virtual start address of the
+	 * vma, merges and splits can happen in a seamless way, just
+	 * using the existing file pgoff checks and manipulations.
+	 * Similarly in do_mmap_pgoff and in do_brk.
+	 */
+	if (!vma->vm_file) {
+		BUG_ON(vma->anon_vma);
+		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
+	}
 	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
 		BUG();
@@ -1617,9 +1681,16 @@ struct vm_area_struct *copy_vma(struct v
 	struct rb_node **rb_link, *rb_parent;
 	struct mempolicy *pol;
 
+	/*
+	 * If anonymous vma has not yet been faulted, update new pgoff
+	 * to match new location, to increase its chance of merging.
+	 */
+	if (!vma->vm_file && !vma->anon_vma)
+		pgoff = addr >> PAGE_SHIFT;
+
 	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
-	new_vma = vma_merge(mm, prev, addr, addr + len,
-			vma->vm_flags, vma->vm_file, pgoff, vma_policy(vma));
+	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
--- rmap38/mm/mprotect.c	2004-05-18 20:50:58.879671424 +0100
+++ rmap39/mm/mprotect.c	2004-05-18 20:51:40.081407808 +0100
@@ -146,7 +146,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	 */
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*pprev = vma_merge(mm, *pprev, start, end, newflags,
-				vma->vm_file, pgoff, vma_policy(vma));
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma));
 	if (*pprev) {
 		vma = *pprev;
 		goto success;
--- rmap38/mm/rmap.c	2004-05-18 20:51:27.706289112 +0100
+++ rmap39/mm/rmap.c	2004-05-18 20:51:40.083407504 +0100
@@ -6,6 +6,15 @@
  *
  * Simple, low overhead reverse mapping scheme.
  * Please try to keep this thing as modular as possible.
+ *
+ * Provides methods for unmapping each kind of mapped page:
+ * the anon methods track anonymous pages, and
+ * the file methods track pages belonging to an inode.
+ *
+ * Original design by Rik van Riel <riel@conectiva.com.br> 2001
+ * File methods by Dave McCracken <dmccr@us.ibm.com> 2003, 2004
+ * Anonymous methods by Andrea Arcangeli <andrea@suse.de> 2004
+ * Contributions by Hugh Dickins <hugh@veritas.com> 2003, 2004
  */
 
 /*
@@ -27,6 +36,128 @@
 
 #include <asm/tlbflush.h>
 
+//#define RMAP_DEBUG /* can be enabled only for debugging */
+
+kmem_cache_t *anon_vma_cachep;
+
+static inline void validate_anon_vma(struct vm_area_struct *find_vma)
+{
+#ifdef RMAP_DEBUG
+	struct anon_vma *anon_vma = find_vma->anon_vma;
+	struct vm_area_struct *vma;
+	unsigned int mapcount = 0;
+	int found = 0;
+
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+		mapcount++;
+		BUG_ON(mapcount > 100000);
+		if (vma == find_vma)
+			found = 1;
+	}
+	BUG_ON(!found);
+#endif
+}
+
+/* This must be called under the mmap_sem. */
+int anon_vma_prepare(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+
+	might_sleep();
+	if (unlikely(!anon_vma)) {
+		struct mm_struct *mm = vma->vm_mm;
+
+		anon_vma = anon_vma_alloc();
+		if (unlikely(!anon_vma))
+			return -ENOMEM;
+
+		/* page_table_lock to protect against threads */
+		spin_lock(&mm->page_table_lock);
+		if (likely(!vma->anon_vma)) {
+			vma->anon_vma = anon_vma;
+			list_add(&vma->anon_vma_node, &anon_vma->head);
+			anon_vma = NULL;
+		}
+		spin_unlock(&mm->page_table_lock);
+		if (unlikely(anon_vma))
+			anon_vma_free(anon_vma);
+	}
+	return 0;
+}
+
+void __anon_vma_merge(struct vm_area_struct *vma, struct vm_area_struct *next)
+{
+	if (!vma->anon_vma) {
+		BUG_ON(!next->anon_vma);
+		vma->anon_vma = next->anon_vma;
+		list_add(&vma->anon_vma_node, &next->anon_vma_node);
+	} else {
+		/* if they're both non-null they must be the same */
+		BUG_ON(vma->anon_vma != next->anon_vma);
+	}
+	list_del(&next->anon_vma_node);
+}
+
+void __anon_vma_link(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+
+	if (anon_vma) {
+		list_add(&vma->anon_vma_node, &anon_vma->head);
+		validate_anon_vma(vma);
+	}
+}
+
+void anon_vma_link(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+
+	if (anon_vma) {
+		spin_lock(&anon_vma->lock);
+		list_add(&vma->anon_vma_node, &anon_vma->head);
+		validate_anon_vma(vma);
+		spin_unlock(&anon_vma->lock);
+	}
+}
+
+void anon_vma_unlink(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = vma->anon_vma;
+	int empty;
+
+	if (!anon_vma)
+		return;
+
+	spin_lock(&anon_vma->lock);
+	validate_anon_vma(vma);
+	list_del(&vma->anon_vma_node);
+
+	/* We must garbage collect the anon_vma if it's empty */
+	empty = list_empty(&anon_vma->head);
+	spin_unlock(&anon_vma->lock);
+
+	if (empty)
+		anon_vma_free(anon_vma);
+}
+
+static void anon_vma_ctor(void *data, kmem_cache_t *cachep, unsigned long flags)
+{
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+						SLAB_CTOR_CONSTRUCTOR) {
+		struct anon_vma *anon_vma = data;
+
+		spin_lock_init(&anon_vma->lock);
+		INIT_LIST_HEAD(&anon_vma->head);
+	}
+}
+
+void __init anon_vma_init(void)
+{
+	anon_vma_cachep = kmem_cache_create("anon_vma",
+		sizeof(struct anon_vma), 0, SLAB_PANIC, anon_vma_ctor, NULL);
+}
+
+/* this needs the page->flags PG_maplock held */
 static inline void clear_page_anon(struct page *page)
 {
 	BUG_ON(!page->mapping);
@@ -35,15 +166,20 @@ static inline void clear_page_anon(struc
 }
 
 /*
- * At what user virtual address is pgoff expected in file-backed vma?
+ * At what user virtual address is page expected in vma?
  */
 static inline unsigned long
-vma_address(struct vm_area_struct *vma, pgoff_t pgoff)
+vma_address(struct page *page, struct vm_area_struct *vma)
 {
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	unsigned long address;
 
 	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		/* page should be within any vma from prio_tree_next */
+		BUG_ON(!PageAnon(page));
+		return -EFAULT;
+	}
 	return address;
 }
 
@@ -52,21 +188,28 @@ vma_address(struct vm_area_struct *vma, 
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct mm_struct *mm, unsigned long address,
-	unsigned int *mapcount, int *failed)
+	struct vm_area_struct *vma, unsigned int *mapcount, int *failed)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 	int referenced = 0;
 
+	if (!mm->rss)
+		goto out;
+	address = vma_address(page, vma);
+	if (address == -EFAULT)
+		goto out;
+
 	if (!spin_trylock(&mm->page_table_lock)) {
 		/*
 		 * For debug we're currently warning if not all found,
 		 * but in this case that's expected: suppress warning.
 		 */
 		(*failed)++;
-		return 0;
+		goto out;
 	}
 
 	pgd = pgd_offset(mm, address);
@@ -91,15 +234,32 @@ static int page_referenced_one(struct pa
 
 out_unmap:
 	pte_unmap(pte);
-
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
+out:
 	return referenced;
 }
 
 static inline int page_referenced_anon(struct page *page)
 {
-	return 1;	/* until next patch */
+	unsigned int mapcount = page->mapcount;
+	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
+	struct vm_area_struct *vma;
+	int referenced = 0;
+	int failed = 0;
+
+	spin_lock(&anon_vma->lock);
+	BUG_ON(list_empty(&anon_vma->head));
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+		referenced += page_referenced_one(page, vma,
+						  &mapcount, &failed);
+		if (!mapcount)
+			goto out;
+	}
+	WARN_ON(!failed);
+out:
+	spin_unlock(&anon_vma->lock);
+	return referenced;
 }
 
 /**
@@ -123,7 +283,6 @@ static inline int page_referenced_file(s
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma = NULL;
 	struct prio_tree_iter iter;
-	unsigned long address;
 	int referenced = 0;
 	int failed = 0;
 
@@ -137,13 +296,10 @@ static inline int page_referenced_file(s
 			referenced++;
 			goto out;
 		}
-		if (vma->vm_mm->rss) {
-			address = vma_address(vma, pgoff);
-			referenced += page_referenced_one(page,
-				vma->vm_mm, address, &mapcount, &failed);
-			if (!mapcount)
-				goto out;
-		}
+		referenced += page_referenced_one(page, vma,
+						  &mapcount, &failed);
+		if (!mapcount)
+			goto out;
 	}
 
 	if (list_empty(&mapping->i_mmap_nonlinear))
@@ -191,15 +347,39 @@ int page_referenced(struct page *page)
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
+	struct anon_vma *anon_vma = vma->anon_vma;
+	pgoff_t index;
+
 	BUG_ON(PageReserved(page));
+	BUG_ON(!anon_vma);
+
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	index += vma->vm_pgoff;
+	index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
+	/*
+	 * Setting and clearing PG_anon must always happen inside
+	 * page_map_lock to avoid races between mapping and
+	 * unmapping on different processes of the same
+	 * shared cow swapcache page. And while we take the
+	 * page_map_lock PG_anon cannot change from under us.
+	 * Actually PG_anon cannot change under fork either
+	 * since fork holds a reference on the page so it cannot
+	 * be unmapped under fork and in turn copy_page_range is
+	 * allowed to read PG_anon outside the page_map_lock.
+	 */
 	page_map_lock(page);
 	if (!page->mapcount) {
+		BUG_ON(PageAnon(page));
 		BUG_ON(page->mapping);
 		SetPageAnon(page);
-		page->index = address & PAGE_MASK;
-		page->mapping = (void *) vma;	/* until next patch */
+		page->index = index;
+		page->mapping = (struct address_space *) anon_vma;
 		inc_page_state(nr_mapped);
+	} else {
+		BUG_ON(!PageAnon(page));
+		BUG_ON(page->index != index);
+		BUG_ON(page->mapping != (struct address_space *) anon_vma);
 	}
 	page->mapcount++;
 	page_map_unlock(page);
@@ -251,15 +431,22 @@ void page_remove_rmap(struct page *page)
  * Subfunctions of try_to_unmap: try_to_unmap_one called
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  */
-static int try_to_unmap_one(struct page *page, struct mm_struct *mm,
-		unsigned long address, struct vm_area_struct *vma)
+static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long address;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
 	int ret = SWAP_AGAIN;
 
+	if (!mm->rss)
+		goto out;
+	address = vma_address(page, vma);
+	if (address == -EFAULT)
+		goto out;
+
 	/*
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
@@ -282,13 +469,6 @@ static int try_to_unmap_one(struct page 
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	if (!vma) {
-		vma = find_vma(mm, address);
-		/* unmap_vmas drops page_table_lock with vma unlinked */
-		if (!vma)
-			goto out_unmap;
-	}
-
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
 	 * If it's recently referenced (perhaps page_referenced
@@ -327,10 +507,8 @@ static int try_to_unmap_one(struct page 
 
 out_unmap:
 	pte_unmap(pte);
-
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
-
 out:
 	return ret;
 }
@@ -361,9 +539,10 @@ out:
 #endif
 #define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
 
-static int try_to_unmap_cluster(struct mm_struct *mm, unsigned long cursor,
+static int try_to_unmap_cluster(unsigned long cursor,
 	unsigned int *mapcount, struct vm_area_struct *vma)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -440,7 +619,19 @@ out_unlock:
 
 static inline int try_to_unmap_anon(struct page *page)
 {
-	return SWAP_FAIL;	/* until next patch */
+	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
+	struct vm_area_struct *vma;
+	int ret = SWAP_AGAIN;
+
+	spin_lock(&anon_vma->lock);
+	BUG_ON(list_empty(&anon_vma->head));
+	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+		ret = try_to_unmap_one(page, vma);
+		if (ret == SWAP_FAIL || !page->mapcount)
+			break;
+	}
+	spin_unlock(&anon_vma->lock);
+	return ret;
 }
 
 /**
@@ -461,7 +652,6 @@ static inline int try_to_unmap_file(stru
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma = NULL;
 	struct prio_tree_iter iter;
-	unsigned long address;
 	int ret = SWAP_AGAIN;
 	unsigned long cursor;
 	unsigned long max_nl_cursor = 0;
@@ -473,12 +663,9 @@ static inline int try_to_unmap_file(stru
 
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
-		if (vma->vm_mm->rss) {
-			address = vma_address(vma, pgoff);
-			ret = try_to_unmap_one(page, vma->vm_mm, address, vma);
-			if (ret == SWAP_FAIL || !page->mapcount)
-				goto out;
-		}
+		ret = try_to_unmap_one(page, vma);
+		if (ret == SWAP_FAIL || !page->mapcount)
+			goto out;
 	}
 
 	if (list_empty(&mapping->i_mmap_nonlinear))
@@ -523,7 +710,7 @@ static inline int try_to_unmap_file(stru
 			while (vma->vm_mm->rss &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
-				ret = try_to_unmap_cluster(vma->vm_mm,
+				ret = try_to_unmap_cluster(
 						cursor, &mapcount, vma);
 				if (ret == SWAP_FAIL)
 					break;

