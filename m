Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269912AbUJMXNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269912AbUJMXNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269911AbUJMXMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:12:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25078 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269909AbUJMXK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:10:27 -0400
Message-ID: <416DB5DD.3010005@mwwireless.net>
Date: Wed, 13 Oct 2004 16:10:21 -0700
From: Steve Longerbeam <stevel@mwwireless.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
CC: Andi Kleen <ak@suse.de>
Subject: [PATCH] NUMA policy support for file mappings
Content-Type: multipart/mixed;
 boundary="------------000502050102080308020605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000502050102080308020605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch to 2.6.8-rc3 that adds NUMA mem policy
support for file mappings. With the patch, mbind() will "do the right thing"
for file mapped regions, ie. page cache pages for the region will be
allocated using the given policy, and all other vma's mapping the same
region of the file will use the same policy. It does this by adding a 
shared_policy
Red-Black tree to address_space. In more detail, the patch is doing the
following:

1. add a shared_policy tree to the address_space object in fs.h.

2. modify page_cache_alloc() in pagemap.h to take a page index in
    addition to a mapping object, and use those to allocate a page for
    the page cache using the appopriate policy found in the mapping->policy
    tree.

3. modify filemap.c to pass the additional page offset to 
page_cache_alloc().

4. Also in filemap.c, implement generic file {set|get}_policy() methods and
    add those to generic_file_vm_ops.

5. In filemap_nopage(), verify that any existing page located in the cache
    is located in a node that satisfies the file's policy. If it's not 
in a node that
    satisfies the policy, it must be because the page was allocated 
before the
    file had any policies. If it's unused, free it and goto retry_find 
(replace with
    a new page using the file's policy). In addition to the page being 
unused, the
    replace is qualified with a new page flag, signifying that this page was
    allocated without the guidance of a shared policy. A similar 
replacement is
    done in exec.c:setup_arg_pages() for arg pages that were allocated 
before any
    policy was known for the stack region.

6. Init the file's shared policy in alloc_inode(), and free the shared 
policy in
   destroy_inode().

This patch also paves the way for executable images to contain policy info,
so that their text and initialized data regions can be bound to specific
nodes. I'm working on a utility ("elfmembind") that tags ELF
executables and shared libs with policy info for text and data. A kernel
patch to fs/binfmt_elf.c parses a new ELF section added by the tool, and
generates a policy for the file's text and initialized data regions. The 
policies
are then inserted into the file mapping's shared_policy tree via 
sys_mbind().

But I'm not sure a post-link time tool is the right approach for 
applying policies
to executable loadable segments. ELF sections are really not supposed to 
be used
at load time, only the PT_LOAD segments are applicable for program loading.
Maybe a good long-term solution is to add policy support to the linker, 
ld. That
way the policy info can be folded into the loadable segments (a NOTE segment
might be the right approach). It's very difficult to modify loadable 
segments post-link
time, unless there are some free bits or fields that can be hijacked. 
Then again,
a post-link utility is more convenient than having to rebuild an app. 
Comments?
Are there already plans afoot to add NUMA mem policies to ELF executables,
and if so how?

Steve



--------------000502050102080308020605
Content-Type: text/plain;
 name="mempol-2.6.8-rc3.filemap-policy.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempol-2.6.8-rc3.filemap-policy.3.patch"

diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/fs/exec.c 2.6.8-rc3/fs/exec.c
--- 2.6.8-rc3.orig/fs/exec.c	2004-08-10 15:18:07.000000000 -0700
+++ 2.6.8-rc3/fs/exec.c	2004-10-13 13:08:39.684591831 -0700
@@ -439,6 +439,12 @@
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
+			page = mpol_replace_invalid_anon_page(page, mpnt, 0);
+			if (!page) {
+				up_write(&mm->mmap_sem);
+				kmem_cache_free(vm_area_cachep, mpnt);
+				return -ENOMEM;
+			}
 			bprm->page[i] = NULL;
 			install_arg_page(mpnt, page, stack_base);
 		}
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/fs/inode.c 2.6.8-rc3/fs/inode.c
--- 2.6.8-rc3.orig/fs/inode.c	2004-08-10 15:18:07.000000000 -0700
+++ 2.6.8-rc3/fs/inode.c	2004-10-13 11:42:04.029720636 -0700
@@ -150,6 +150,7 @@
 		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+ 		mpol_shared_policy_init(&mapping->policy);
 
 		/*
 		 * If the block_device provides a backing_dev_info for client
@@ -177,8 +178,10 @@
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
-	else
+	else {
+		mpol_free_shared_policy(&inode->i_mapping->policy);
 		kmem_cache_free(inode_cachep, (inode));
+	}
 }
 
 
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/fs.h 2.6.8-rc3/include/linux/fs.h
--- 2.6.8-rc3.orig/include/linux/fs.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/fs.h	2004-10-12 09:53:14.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/mempolicy.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -339,6 +340,7 @@
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
+	struct shared_policy    policy;         /* page alloc policy */
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/mempolicy.h 2.6.8-rc3/include/linux/mempolicy.h
--- 2.6.8-rc3.orig/include/linux/mempolicy.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/mempolicy.h	2004-10-13 13:06:57.861137412 -0700
@@ -120,6 +120,12 @@
 extern int mpol_first_node(struct vm_area_struct *vma, unsigned long addr);
 extern int mpol_node_valid(int nid, struct vm_area_struct *vma,
 			unsigned long addr);
+extern struct page * mpol_replace_invalid_anon_page(struct page * page,
+						    struct vm_area_struct *vma,
+						    unsigned long addr);
+extern int mpol_remove_invalid_filemap_page(struct page * page,
+					    struct vm_area_struct *vma,
+					    unsigned long addr);
 
 /*
  * Tree of shared policies for a shared memory region.
@@ -152,7 +158,8 @@
 void mpol_free_shared_policy(struct shared_policy *p);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
-
+struct page *alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+				      unsigned long idx);
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 
@@ -192,6 +199,22 @@
 	return 1;
 }
 
+static inline struct page *
+mpol_replace_invalid_anon_page(struct page * page,
+			       struct vm_area_struct *vma,
+			       unsigned long addr)
+{
+	return page;
+}
+
+static inline int
+mpol_remove_invalid_filemap_page(struct page * page,
+				 struct vm_area_struct *vma,
+				 unsigned long addr)
+{
+	return 0;
+}
+
 struct shared_policy {};
 
 static inline int mpol_set_shared_policy(struct shared_policy *info,
@@ -218,6 +241,13 @@
 #define vma_policy(vma) NULL
 #define vma_set_policy(vma, pol) do {} while(0)
 
+static inline struct page *
+alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+			 unsigned long idx)
+{
+	return alloc_pages(gfp, 0);
+}
+
 static inline void numa_policy_init(void)
 {
 }
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/page-flags.h 2.6.8-rc3/include/linux/page-flags.h
--- 2.6.8-rc3.orig/include/linux/page-flags.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/page-flags.h	2004-10-12 09:53:16.000000000 -0700
@@ -77,6 +77,8 @@
 #define PG_compound		19	/* Part of a compound page */
 
 #define PG_anon			20	/* Anonymous: anon_vma in mapping */
+#define PG_sharedpolicy		21	/* Page was allocated for a file
+					   mapping using a shared_policy */
 
 
 /*
@@ -296,6 +298,10 @@
 #define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
 #define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
 
+#define PageSharedPolicy(page)      test_bit(PG_sharedpolicy, &(page)->flags)
+#define SetPageSharedPolicy(page)   set_bit(PG_sharedpolicy, &(page)->flags)
+#define ClearPageSharedPolicy(page) clear_bit(PG_sharedpolicy, &(page)->flags)
+
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/pagemap.h 2.6.8-rc3/include/linux/pagemap.h
--- 2.6.8-rc3.orig/include/linux/pagemap.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/pagemap.h	2004-10-12 09:53:16.000000000 -0700
@@ -50,14 +50,24 @@
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
-static inline struct page *page_cache_alloc(struct address_space *x)
+
+static inline struct page *__page_cache_alloc(struct address_space *x,
+					      unsigned long idx,
+					      unsigned int gfp_mask)
+{
+	return alloc_page_shared_policy(gfp_mask, &x->policy, idx);
+}
+
+static inline struct page *page_cache_alloc(struct address_space *x,
+					    unsigned long idx)
 {
-	return alloc_pages(mapping_gfp_mask(x), 0);
+	return __page_cache_alloc(x, idx, mapping_gfp_mask(x));
 }
 
-static inline struct page *page_cache_alloc_cold(struct address_space *x)
+static inline struct page *page_cache_alloc_cold(struct address_space *x,
+						 unsigned long idx)
 {
-	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
+	return __page_cache_alloc(x, idx, mapping_gfp_mask(x)|__GFP_COLD);
 }
 
 typedef int filler_t(void *, struct page *);
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/mm/filemap.c 2.6.8-rc3/mm/filemap.c
--- 2.6.8-rc3.orig/mm/filemap.c	2004-08-10 15:18:35.000000000 -0700
+++ 2.6.8-rc3/mm/filemap.c	2004-10-13 13:07:26.730013385 -0700
@@ -534,7 +534,8 @@
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = alloc_page(gfp_mask);
+			cached_page = __page_cache_alloc(mapping, index,
+							 gfp_mask);
 			if (!cached_page)
 				return NULL;
 		}
@@ -627,7 +628,7 @@
 		return NULL;
 	}
 	gfp_mask = mapping_gfp_mask(mapping) & ~__GFP_FS;
-	page = alloc_pages(gfp_mask, 0);
+	page = __page_cache_alloc(mapping, index, gfp_mask);
 	if (page && add_to_page_cache_lru(page, mapping, index, gfp_mask)) {
 		page_cache_release(page);
 		page = NULL;
@@ -789,7 +790,7 @@
 		 * page..
 		 */
 		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
+			cached_page = page_cache_alloc_cold(mapping, index);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
 				goto out;
@@ -1050,7 +1051,7 @@
 	struct page *page; 
 	int error;
 
-	page = page_cache_alloc_cold(mapping);
+	page = page_cache_alloc_cold(mapping, offset);
 	if (!page)
 		return -ENOMEM;
 
@@ -1162,6 +1163,9 @@
 			goto no_cached_page;
 	}
 
+	if (mpol_remove_invalid_filemap_page(page, area, address))
+		goto retry_find;
+
 	if (!did_readaround)
 		ra->mmap_hit++;
 
@@ -1431,9 +1435,35 @@
 	return 0;
 }
 
+
+#ifdef CONFIG_NUMA
+int generic_file_set_policy(struct vm_area_struct *vma,
+			    struct mempolicy *new)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	return mpol_set_shared_policy(&mapping->policy, vma, new);
+}
+
+struct mempolicy *
+generic_file_get_policy(struct vm_area_struct *vma,
+			unsigned long addr)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	unsigned long idx;
+
+	idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	return mpol_shared_policy_lookup(&mapping->policy, idx);
+}
+#endif
+
+
 static struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
+#ifdef CONFIG_NUMA
+	.set_policy     = generic_file_set_policy,
+	.get_policy     = generic_file_get_policy,
+#endif
 };
 
 /* This is used for a general mmap of a disk file */
@@ -1483,7 +1513,7 @@
 	page = find_get_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
+			cached_page = page_cache_alloc_cold(mapping, index);
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
@@ -1565,7 +1595,7 @@
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!*cached_page) {
-			*cached_page = page_cache_alloc(mapping);
+			*cached_page = page_cache_alloc(mapping, index);
 			if (!*cached_page)
 				return NULL;
 		}
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/mm/mempolicy.c 2.6.8-rc3/mm/mempolicy.c
--- 2.6.8-rc3.orig/mm/mempolicy.c	2004-08-10 15:18:35.000000000 -0700
+++ 2.6.8-rc3/mm/mempolicy.c	2004-10-13 13:08:20.241369254 -0700
@@ -66,6 +66,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -817,6 +818,93 @@
 	}
 }
 
+
+/*
+ * If the given page doesn't match an anonymous VMA's policy, allocate
+ * a new page using the VMA policy, copy contents from old to new, free
+ * the old page, and return the new page. But if the page matches the
+ * policy, just return it.
+ */
+struct page *
+mpol_replace_invalid_anon_page(struct page * page,
+			       struct vm_area_struct *vma,
+			       unsigned long addr)
+{
+	struct page * new_page = page;
+	
+	if (!mpol_node_valid(page_to_nid(page), vma, addr)) {
+		void *from, *to;
+		new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		if (!new_page)
+			return NULL;
+		from = kmap(page);
+		to = kmap(new_page);
+		copy_page(to, from);
+		kunmap(page);
+		kunmap(new_page);
+		put_page(page);
+	}
+
+	return new_page;
+}
+
+
+/*
+ * If the given page doesn't match a file mapped VMA's policy, and the
+ * page is unused, remove it from the page cache, so that a new page
+ * can be later reallocated to the cache using the correct policy.
+ * Returns 1 if the page was removed from the cache, 0 otherwise.
+ */
+int
+mpol_remove_invalid_filemap_page(struct page * page,
+				 struct vm_area_struct *vma,
+				 unsigned long addr)
+{
+	int removed = 0;
+	
+	if (!mpol_node_valid(page_to_nid(page), vma, addr)) {
+		/*
+		 * the page in the cache is not in any of the nodes this
+		 * VMA's policy wants it to be in. Can we remove it?
+		 */
+		lock_page(page);
+		if (page_count(page) - !!PagePrivate(page) == 2 &&
+		    !PageSharedPolicy(page)) {
+			struct address_space *mapping =
+				vma->vm_file->f_mapping;
+			/*
+			 * This page isn't being used by any mappings,
+			 * so we can safely remove it. It must be left
+			 * over from an earlier file IO readahead when
+			 * there was no page allocation policy associated
+			 * with the file.
+			 */
+			PDprintk("removing page in node %d, "
+				 "pgoff=%lu, for %s\n",
+				 page_to_nid(page),
+				 vma->vm_pgoff +
+				 (addr - vma->vm_start) >> PAGE_CACHE_SHIFT,
+				 vma->vm_file->f_dentry->d_name.name);
+			spin_lock(&mapping->tree_lock);
+			__remove_from_page_cache(page);
+			spin_unlock(&mapping->tree_lock);
+			page_cache_release(page);  /* pagecache ref */
+			unlock_page(page);
+			page_cache_release(page);  /* us */
+			removed = 1;
+		} else {
+			/*
+			 * the page is being used by other mappings.
+			 * We'll just have to keep it.
+			 */
+			unlock_page(page);
+		}
+	}
+
+	return removed;
+}
+
+
 /*
  * Shared memory backing store policy support.
  *
@@ -932,10 +1020,14 @@
 	/* Take care of old policies in the same range. */
 	while (n && n->start < end) {
 		struct rb_node *next = rb_next(&n->nd);
-		if (n->start >= start) {
-			if (n->end <= end)
+		if (n->start == start && n->end == end &&
+		    mpol_equal(n->policy, new->policy)) {
+			/* the same shared policy already exists, just exit */
+			goto out;
+		} else if (n->start >= start) {
+			if (n->end <= end) {
 				sp_delete(sp, n);
-			else
+			} else
 				n->start = end;
 		} else {
 			/* Old policy spanning whole new range. */
@@ -958,6 +1050,7 @@
 	}
 	if (new)
 		sp_insert(sp, new);
+ out:
 	up(&sp->sem);
 	return 0;
 }
@@ -1003,6 +1096,37 @@
 	up(&p->sem);
 }
 
+struct page *
+alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+			 unsigned long idx)
+{
+	struct page *page;
+	struct mempolicy * shared_pol = NULL;
+
+	if (sp->root.rb_node) {
+		struct vm_area_struct pvma;
+		/* Create a pseudo vma that just contains the policy */
+		memset(&pvma, 0, sizeof(struct vm_area_struct));
+		pvma.vm_end = PAGE_SIZE;
+		pvma.vm_pgoff = idx;
+		shared_pol = mpol_shared_policy_lookup(sp, idx);
+		pvma.vm_policy = shared_pol;
+		page = alloc_page_vma(gfp, &pvma, 0);
+		mpol_free(pvma.vm_policy);
+	} else {
+		page = alloc_pages(gfp, 0);
+	}
+
+	if (page) {
+		if (shared_pol)
+			SetPageSharedPolicy(page);
+		else
+			ClearPageSharedPolicy(page);
+	}
+	
+	return page;
+}
+
 /* assumes fs == KERNEL_DS */
 void __init numa_policy_init(void)
 {
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/mm/readahead.c 2.6.8-rc3/mm/readahead.c
--- 2.6.8-rc3.orig/mm/readahead.c	2004-08-10 15:18:35.000000000 -0700
+++ 2.6.8-rc3/mm/readahead.c	2004-10-12 09:53:18.000000000 -0700
@@ -246,7 +246,7 @@
 			continue;
 
 		spin_unlock_irq(&mapping->tree_lock);
-		page = page_cache_alloc_cold(mapping);
+		page = page_cache_alloc_cold(mapping, page_offset);
 		spin_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/mm/shmem.c 2.6.8-rc3/mm/shmem.c
--- 2.6.8-rc3.orig/mm/shmem.c	2004-08-10 15:18:35.000000000 -0700
+++ 2.6.8-rc3/mm/shmem.c	2004-10-12 09:53:18.000000000 -0700
@@ -824,16 +824,7 @@
 shmem_alloc_page(unsigned long gfp, struct shmem_inode_info *info,
 		 unsigned long idx)
 {
-	struct vm_area_struct pvma;
-	struct page *page;
-
-	memset(&pvma, 0, sizeof(struct vm_area_struct));
-	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
-	pvma.vm_pgoff = idx;
-	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp, &pvma, 0);
-	mpol_free(pvma.vm_policy);
-	return page;
+	return alloc_page_shared_policy(gfp, &info->policy, idx);
 }
 #else
 static inline struct page *

--------------000502050102080308020605--
