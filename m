Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUITXti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUITXti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUITXte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:49:34 -0400
Received: from [207.168.29.180] ([207.168.29.180]:14464 "EHLO
	tugboat.mwwireless.net") by vger.kernel.org with ESMTP
	id S261234AbUITXs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:48:58 -0400
Message-ID: <414F6C69.8060406@mwwireless.net>
Date: Mon, 20 Sep 2004 16:48:57 -0700
From: Steve Longerbeam <stevel@mwwireless.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm <linux-mm@kvack.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de>
In-Reply-To: <20040920205509.GF4242@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------000706040208050705030902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706040208050705030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Andi Kleen wrote:

>On Mon, Sep 20, 2004 at 12:00:33PM -0700, Ray Bryant wrote:
>  
>
>>Background
>>----------
>>
>>Last month, Jesse Barnes proposed a patch to do round robin
>>allocation of page cache pages on NUMA machines.  This got shot down
>>for a number of reasons (see
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=109235420329360&w=2
>>and the related thread), but it seemed to me that one of the most
>>significant issues was that this was a workload dependent optimization.
>>That is, for an Altix running an HPC workload, it was a good thing,
>>but for web servers or file servers it was not such a good idea.
>>
>>So the idea of this patch is the following:  it creates a new memory
>>policy structure (default_pagecache_policy) that is used to control
>>how storage for page cache pages is allocated.  So, for a large Altix
>>running HPC workloads, we can specify a policy that does round robin
>>allocations, and for other workloads you can specify the default policy
>>(which results in page cache pages being allocated locally).
>>
>>The default_pagecache_policy is overrideable on a per process basis, so
>>that if your application prefers to allocate page cache pages locally,
>>it can.
>>    
>>
>
>I'm not sure this really makes sense. Do you have some clear use 
>case where having so much flexibility is needed? 
>
>I would prefer to have a global setting somewhere for the page
>cache (sysctl or sysfs or what you prefer) and some special handling for 
>text pages. 
>
>This would keep the per thread bloat low. 
>
>Also I must say I got a patch submitted to do policy per
>file from Steve Longerbeam. 
>
>It so far only supports this for ELF executables, but
>it has most of the infrastructure to do individual policy
>per file. Maybe it would be better to go into this direction,
>only thing missing is a nice way to declare policy for 
>arbitary files. Even in this case a global default would be useful.
>
>I haven't done anything with this patch yet due to missing time 
>and there were a few small issues to resolve, but i hope it 
>can be eventually integrated.
>
>[Steve, perhaps you can repost the patch to lse-tech for more
>wider review?]
>  
>

Sure, patch is attached. Also, here is a reposting of my original email to
you (Andi) describing the patch. Btw, I received your comments on the
patch, I will reply to your points seperately. Sorry I haven't replied 
sooner,
I'm in the middle of switching jobs  :-)


-------- original email follows ----------

Hi Andi,

I'm working on adding the features to NUMA mempolicy
necessary to support MontaVista's MTA.

Attached is the first of those features, support for
global page allocation policy for mapped files. Here's
what the patch is doing:

1. add a shared_policy tree to the address_space object in fs.h.
2. modify page_cache_alloc() in pagemap.h to take an address_space
    object and page offset, and use those to allocate a page for the
    page cache using the policy in the address_space object.
3. modify filemap.c to pass the additional {mapping, page offset} pair
    to page_cache_alloc().
4. Also in filemap.c, implement generic file {set|get}_policy() methods and
    add those to generic_file_vm_ops.
5. In filemap_nopage(), verify that any existing page located in the cache
    is located in a node that satisfies the file's policy. If it's not 
in a node that
    satisfies the policy, it must be because the page was allocated 
before the
    file had any policies. If it's unused, free it and goto retry_find 
(will allocate
    a new page using the file's policy). Note that a similar operation 
is done in
    exec.c:setup_arg_pages() for stack pages.
6. Init the file's shared policy in alloc_inode(), and free the shared 
policy in
    destroy_inode().

I'm working on the remaining features needed for MTA. They are:

- support for policies contained in ELF images, for text and data regions.
- support for do_mmap_mempolicy() and do_brk_mempolicy(). Do_mmap()
   can allocate pages to the region before the function exits, such as 
when pages
   are locked for the region. So it's necessary in that case to set the 
VMA's policy
   within do_mmap() before those pages are allocated.
- system calls for mmap_mempolicy and brk_mempolicy.

Let me know your thoughts on the filemap policy patch.

Thanks,
Steve


--------------000706040208050705030902
Content-Type: text/plain;
 name="filemap-policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filemap-policy.patch"

diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/fs/exec.c 2.6.8-rc3/fs/exec.c
--- 2.6.8-rc3.orig/fs/exec.c	2004-08-10 15:18:07.000000000 -0700
+++ 2.6.8-rc3/fs/exec.c	2004-09-01 21:53:25.000000000 -0700
@@ -439,6 +439,25 @@
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		struct page *page = bprm->page[i];
 		if (page) {
+#ifdef CONFIG_NUMA
+			if (!mpol_node_valid(page_to_nid(page), mpnt, 0)) {
+				void *from, *to;
+				struct page * new_page =
+					alloc_pages_current(GFP_HIGHUSER, 0);
+				if (!new_page) {
+					up_write(&mm->mmap_sem);
+					kmem_cache_free(vm_area_cachep, mpnt);
+					return -ENOMEM;
+				}
+				from = kmap(page);
+				to = kmap(new_page);
+				copy_page(to, from);
+				kunmap(page);
+				kunmap(new_page);
+				put_page(page);
+				page = new_page;
+			}
+#endif
 			bprm->page[i] = NULL;
 			install_arg_page(mpnt, page, stack_base);
 		}
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/fs/inode.c 2.6.8-rc3/fs/inode.c
--- 2.6.8-rc3.orig/fs/inode.c	2004-08-10 15:18:07.000000000 -0700
+++ 2.6.8-rc3/fs/inode.c	2004-09-01 11:40:44.000000000 -0700
@@ -150,6 +150,7 @@
 		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+ 		mpol_shared_policy_init(&mapping->policy);
 
 		/*
 		 * If the block_device provides a backing_dev_info for client
@@ -177,11 +178,12 @@
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
-	else
+	else {
+		mpol_free_shared_policy(&inode->i_mapping->policy);
 		kmem_cache_free(inode_cachep, (inode));
+	}
 }
 
-
 /*
  * These are initializations that only need to be done
  * once, because the fields are idempotent across use
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/fs.h 2.6.8-rc3/include/linux/fs.h
--- 2.6.8-rc3.orig/include/linux/fs.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/fs.h	2004-09-01 21:08:37.000000000 -0700
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
+++ 2.6.8-rc3/include/linux/mempolicy.h	2004-09-01 21:54:34.000000000 -0700
@@ -152,6 +152,8 @@
 void mpol_free_shared_policy(struct shared_policy *p);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
+struct page *alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+				      unsigned long idx);
 
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
diff -Nuar -X /home/stevel/dontdiff 2.6.8-rc3.orig/include/linux/pagemap.h 2.6.8-rc3/include/linux/pagemap.h
--- 2.6.8-rc3.orig/include/linux/pagemap.h	2004-08-10 15:18:31.000000000 -0700
+++ 2.6.8-rc3/include/linux/pagemap.h	2004-09-01 11:04:24.000000000 -0700
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
+++ 2.6.8-rc3/mm/filemap.c	2004-09-01 21:52:06.000000000 -0700
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
 
@@ -1070,6 +1071,7 @@
 	return error == -EEXIST ? 0 : error;
 }
 
+
 #define MMAP_LOTSAMISS  (100)
 
 /*
@@ -1090,7 +1092,7 @@
 	struct page *page;
 	unsigned long size, pgoff, endoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
-
+	
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
@@ -1162,6 +1164,38 @@
 			goto no_cached_page;
 	}
 
+#ifdef CONFIG_NUMA
+	if (!mpol_node_valid(page_to_nid(page), area, 0)) {
+		/*
+		 * the page in the cache is not in any of the nodes this
+		 * VMA's policy wants it to be in. Can we remove it?
+		 */
+		lock_page(page);
+		if (page_count(page) - !!PagePrivate(page) == 2) {
+			/*
+			 * This page isn't being used by any mappings,
+			 * so we can safely remove it. It must be left
+			 * over from an earlier file IO readahead when
+			 * there was no page allocation policy associated
+			 * with the file.
+			 */
+			spin_lock(&mapping->tree_lock);
+			__remove_from_page_cache(page);
+			spin_unlock(&mapping->tree_lock);
+			page_cache_release(page);  /* pagecache ref */
+			unlock_page(page);
+			page_cache_release(page);  /* us */
+			goto retry_find;
+		} else {
+			/*
+			 * darn, the page is being used by other mappings.
+			 * We'll just have to leave the page in this node.
+			 */
+			unlock_page(page);
+		}
+	}
+#endif
+	
 	if (!did_readaround)
 		ra->mmap_hit++;
 
@@ -1431,9 +1465,35 @@
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
@@ -1483,7 +1543,7 @@
 	page = find_get_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
+			cached_page = page_cache_alloc_cold(mapping, index);
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
@@ -1565,7 +1625,7 @@
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
+++ 2.6.8-rc3/mm/mempolicy.c	2004-09-01 21:49:14.000000000 -0700
@@ -638,6 +638,7 @@
 	return page;
 }
 
+
 /**
  * 	alloc_page_vma	- Allocate a page for a VMA.
  *
@@ -683,6 +684,7 @@
 	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
 }
 
+
 /**
  * 	alloc_pages_current - Allocate pages.
  *
@@ -1003,6 +1005,28 @@
 	up(&p->sem);
 }
 
+struct page *
+alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+			 unsigned long idx)
+{
+	struct page *page;
+	
+	if (sp) {
+		struct vm_area_struct pvma;
+		/* Create a pseudo vma that just contains the policy */
+		memset(&pvma, 0, sizeof(struct vm_area_struct));
+		pvma.vm_end = PAGE_SIZE;
+		pvma.vm_pgoff = idx;
+		pvma.vm_policy = mpol_shared_policy_lookup(sp, idx);
+		page = alloc_page_vma(gfp, &pvma, 0);
+		mpol_free(pvma.vm_policy);
+	} else {
+		page = alloc_pages(gfp, 0);
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
+++ 2.6.8-rc3/mm/readahead.c	2004-09-01 20:39:14.000000000 -0700
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
+++ 2.6.8-rc3/mm/shmem.c	2004-09-01 11:14:48.000000000 -0700
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

--------------000706040208050705030902--
