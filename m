Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUDHW7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUDHW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:59:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32706 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262969AbUDHW66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:58:58 -0400
Date: Thu, 8 Apr 2004 23:58:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: rmk@arm-linux.org.uk, <ralf@linux-mips.org>,
       <James.Bottomley@SteelEye.com>, <davem@redhat.com>, <nathans@sgi.com>,
       <gniibe@m17n.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 3 arches + mapping_mapped
In-Reply-To: <Pine.LNX.4.44.0404082349580.1586-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404082354550.1586-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some arches refer to page->mapping for their dcache flushing:
use page_mapping(page) for safety, to avoid confusion on anon
pages, which will store a different pointer there - though in
most cases flush_dcache_page is being applied to pagecache pages.

arm has a useful mapping_mapped macro: move that to generic,
and add mapping_writably_mapped, to avoid explicit list_empty
checks on i_mmap and i_mmap_shared in several places.

Very tempted to add page_mapped(page) tests, perhaps along
with the mapping_writably_mapped tests in do_generic_mapping_read
and do_shmem_file_read, to cut down on wasted flush_dcache effort;
but the serialization is not obvious, too unsafe to do in a hurry.

 arch/arm/mm/fault-armv.c        |    4 ++--
 arch/mips/mm/cache.c            |    9 +++------
 arch/parisc/kernel/cache.c      |    4 ++--
 arch/sparc64/kernel/smp.c       |    8 ++++----
 arch/sparc64/mm/init.c          |   14 ++++++--------
 fs/locks.c                      |   22 ++++++++--------------
 fs/xfs/linux/xfs_vnode.h        |    4 +---
 include/asm-arm/cacheflush.h    |   12 ++++--------
 include/asm-parisc/cacheflush.h |    3 +--
 include/asm-sh/pgalloc.h        |    4 ++--
 include/linux/fs.h              |   20 ++++++++++++++++++++
 mm/filemap.c                    |    2 +-
 mm/shmem.c                      |    2 +-
 mm/vmscan.c                     |    9 ++-------
 14 files changed, 57 insertions(+), 60 deletions(-)

--- rmap2/arch/arm/mm/fault-armv.c	2003-09-28 01:51:32.000000000 +0100
+++ rmap3/arch/arm/mm/fault-armv.c	2004-04-08 20:56:52.164797632 +0100
@@ -191,7 +191,7 @@ void __flush_dcache_page(struct page *pa
 
 	__cpuc_flush_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 
 	/*
@@ -292,7 +292,7 @@ void update_mmu_cache(struct vm_area_str
 	if (!pfn_valid(pfn))
 		return;
 	page = pfn_to_page(pfn);
-	if (page->mapping) {
+	if (page_mapping(page)) {
 		int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
 
 		if (dirty)
--- rmap2/arch/mips/mm/cache.c	2004-03-11 01:56:08.000000000 +0000
+++ rmap3/arch/mips/mm/cache.c	2004-04-08 20:56:52.165797480 +0100
@@ -57,16 +57,13 @@ void flush_dcache_page(struct page *page
 {
 	unsigned long addr;
 
-	if (page->mapping &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
 		SetPageDcacheDirty(page);
-
 		return;
 	}
 
 	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
+	 * We could delay the flush for the !page_mapping case too.  But that
 	 * case is for exec env/arg pages and those are %99 certainly going to
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
@@ -81,7 +78,7 @@ void __update_cache(struct vm_area_struc
 	unsigned long pfn, addr;
 
 	pfn = pte_pfn(pte);
-	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page->mapping) &&
+	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    Page_dcache_dirty(page)) {
 		if (pages_do_alias((unsigned long)page_address(page),
 		                   address & PAGE_MASK)) {
--- rmap2/arch/parisc/kernel/cache.c	2004-01-09 06:00:23.000000000 +0000
+++ rmap3/arch/parisc/kernel/cache.c	2004-04-08 20:56:52.166797328 +0100
@@ -68,7 +68,7 @@ update_mmu_cache(struct vm_area_struct *
 {
 	struct page *page = pte_page(pte);
 
-	if (VALID_PAGE(page) && page->mapping &&
+	if (VALID_PAGE(page) && page_mapping(page) &&
 	    test_bit(PG_dcache_dirty, &page->flags)) {
 
 		flush_kernel_dcache_page(page_address(page));
@@ -234,7 +234,7 @@ void __flush_dcache_page(struct page *pa
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 	/* check shared list first if it's not empty...it's usually
 	 * the shortest */
--- rmap2/arch/sparc64/kernel/smp.c	2004-04-04 03:38:40.000000000 +0100
+++ rmap3/arch/sparc64/kernel/smp.c	2004-04-08 20:56:52.167797176 +0100
@@ -671,9 +671,9 @@ static __inline__ void __local_flush_dca
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -694,7 +694,7 @@ void smp_flush_dcache_page_impl(struct p
 		if (tlb_type == spitfire) {
 			data0 =
 				((u64)&xcall_flush_dcache_page_spitfire);
-			if (page->mapping != NULL)
+			if (page_mapping(page) != NULL)
 				data0 |= ((u64)1 << 32);
 			spitfire_xcall_deliver(data0,
 					       __pa(page->virtual),
@@ -727,7 +727,7 @@ void flush_dcache_page_all(struct mm_str
 		goto flush_self;
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
-		if (page->mapping != NULL)
+		if (page_mapping(page) != NULL)
 			data0 |= ((u64)1 << 32);
 		spitfire_xcall_deliver(data0,
 				       __pa(page->virtual),
--- rmap2/arch/sparc64/mm/init.c	2004-04-04 03:38:42.000000000 +0100
+++ rmap3/arch/sparc64/mm/init.c	2004-04-08 20:56:52.169796872 +0100
@@ -139,9 +139,9 @@ __inline__ void flush_dcache_page_impl(s
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -203,7 +203,7 @@ void update_mmu_cache(struct vm_area_str
 
 	pfn = pte_pfn(pte);
 	if (pfn_valid(pfn) &&
-	    (page = pfn_to_page(pfn), page->mapping) &&
+	    (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
 		int cpu = ((pg_flags >> 24) & (NR_CPUS - 1UL));
 
@@ -227,9 +227,7 @@ void flush_dcache_page(struct page *page
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page->mapping &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
 		if (dirty) {
 			if (dirty_cpu == smp_processor_id())
 				return;
@@ -237,7 +235,7 @@ void flush_dcache_page(struct page *page
 		}
 		set_dcache_dirty(page);
 	} else {
-		/* We could delay the flush for the !page->mapping
+		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg
 		 * pages and those are %99 certainly going to get
 		 * faulted into the tlb (and thus flushed) anyways.
@@ -279,7 +277,7 @@ static inline void flush_cache_pte_range
 			if (!pfn_valid(pfn))
 				continue;
 			page = pfn_to_page(pfn);
-			if (PageReserved(page) || !page->mapping)
+			if (PageReserved(page) || !page_mapping(page))
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
--- rmap2/fs/locks.c	2004-03-11 01:56:12.000000000 +0000
+++ rmap3/fs/locks.c	2004-04-08 20:56:52.172796416 +0100
@@ -1453,13 +1453,10 @@ int fcntl_setlk(struct file *filp, unsig
 	 * and shared.
 	 */
 	if (IS_MANDLOCK(inode) &&
-	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
-		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
-			error = -EAGAIN;
-			goto out;
-		}
+	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
+	    mapping_writably_mapped(filp->f_mapping)) {
+		error = -EAGAIN;
+		goto out;
 	}
 
 	error = flock_to_posix_lock(filp, file_lock, &flock);
@@ -1591,13 +1588,10 @@ int fcntl_setlk64(struct file *filp, uns
 	 * and shared.
 	 */
 	if (IS_MANDLOCK(inode) &&
-	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID) {
-		struct address_space *mapping = filp->f_mapping;
-
-		if (!list_empty(&mapping->i_mmap_shared)) {
-			error = -EAGAIN;
-			goto out;
-		}
+	    (inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
+	    mapping_writably_mapped(filp->f_mapping)) {
+		error = -EAGAIN;
+		goto out;
 	}
 
 	error = flock64_to_posix_lock(filp, file_lock, &flock);
--- rmap2/fs/xfs/linux/xfs_vnode.h	2004-04-07 08:19:28.000000000 +0100
+++ rmap3/fs/xfs/linux/xfs_vnode.h	2004-04-08 20:56:52.173796264 +0100
@@ -596,9 +596,7 @@ static __inline__ void vn_flagclr(struct
 /*
  * Some useful predicates.
  */
-#define VN_MAPPED(vp)	\
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
-	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
+#define VN_MAPPED(vp)	mapping_mapped(LINVFS_GET_IP(vp)->i_mapping)
 #define VN_CACHED(vp)	(LINVFS_GET_IP(vp)->i_mapping->nrpages)
 #define VN_DIRTY(vp)	mapping_tagged(LINVFS_GET_IP(vp)->i_mapping, \
 					PAGECACHE_TAG_DIRTY)
--- rmap2/include/asm-arm/cacheflush.h	2004-03-11 01:56:12.000000000 +0000
+++ rmap3/include/asm-arm/cacheflush.h	2004-04-08 20:56:52.174796112 +0100
@@ -283,23 +283,19 @@ flush_cache_page(struct vm_area_struct *
  * flush_dcache_page is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
- * If this page isn't mapped (ie, page->mapping = NULL), or it has
- * userspace mappings (page->mapping->i_mmap or page->mapping->i_mmap_shared)
- * then we _must_ always clean + invalidate the dcache entries associated
- * with the kernel mapping.
+ * If this page isn't mapped (ie, page_mapping == NULL), or it might
+ * have userspace mappings, then we _must_ always clean + invalidate
+ * the dcache entries associated with the kernel mapping.
  *
  * Otherwise we can defer the operation, and clean the cache when we are
  * about to change to user space.  This is the same method as used on SPARC64.
  * See update_mmu_cache for the user space part.
  */
-#define mapping_mapped(map)	(!list_empty(&(map)->i_mmap) || \
-				 !list_empty(&(map)->i_mmap_shared))
-
 extern void __flush_dcache_page(struct page *);
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && !mapping_mapped(page->mapping))
+	if (page_mapping(page) && !mapping_mapped(page->mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 		__flush_dcache_page(page);
--- rmap2/include/asm-parisc/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap3/include/asm-parisc/cacheflush.h	2004-04-08 20:56:52.175795960 +0100
@@ -69,8 +69,7 @@ extern void __flush_dcache_page(struct p
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && list_empty(&page->mapping->i_mmap) &&
-			list_empty(&page->mapping->i_mmap_shared)) {
+	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
 		__flush_dcache_page(page);
--- rmap2/include/asm-sh/pgalloc.h	2004-02-04 02:45:26.000000000 +0000
+++ rmap3/include/asm-sh/pgalloc.h	2004-04-08 20:56:52.175795960 +0100
@@ -101,8 +101,8 @@ static inline pte_t ptep_get_and_clear(p
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (!page->mapping
-			    || list_empty(&page->mapping->i_mmap_shared))
+			if (!page_mapping(page) ||
+			    !mapping_writably_mapped(page->mapping))
 				__clear_bit(PG_mapped, &page->flags);
 		}
 	}
--- rmap2/include/linux/fs.h	2004-04-07 08:19:29.000000000 +0100
+++ rmap3/include/linux/fs.h	2004-04-08 20:56:52.177795656 +0100
@@ -372,6 +372,26 @@ struct block_device {
 int mapping_tagged(struct address_space *mapping, int tag);
 
 /*
+ * Might pages of this file be mapped into userspace?
+ */
+static inline int mapping_mapped(struct address_space *mapping)
+{
+	return	!list_empty(&mapping->i_mmap) ||
+		!list_empty(&mapping->i_mmap_shared);
+}
+
+/*
+ * Might pages of this file have been modified in userspace?
+ * Note that i_mmap_shared holds all the VM_SHARED vmas: do_mmap_pgoff
+ * marks vma as VM_SHARED if it is shared, and the file was opened for
+ * writing i.e. vma may be mprotected writable even if now readonly.
+ */
+static inline int mapping_writably_mapped(struct address_space *mapping)
+{
+	return	!list_empty(&mapping->i_mmap_shared);
+}
+
+/*
  * Use sequence counter to get consistent i_size on 32-bit processors.
  */
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
--- rmap2/mm/filemap.c	2004-04-08 20:56:40.937504440 +0100
+++ rmap3/mm/filemap.c	2004-04-08 20:56:52.179795352 +0100
@@ -660,7 +660,7 @@ page_ok:
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
 		 */
-		if (!list_empty(&mapping->i_mmap_shared))
+		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
 		/*
--- rmap2/mm/shmem.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap3/mm/shmem.c	2004-04-08 20:56:52.181795048 +0100
@@ -1339,7 +1339,7 @@ static void do_shmem_file_read(struct fi
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (!list_empty(&mapping->i_mmap_shared))
+			if (mapping_writably_mapped(mapping))
 				flush_dcache_page(page);
 			/*
 			 * Mark the page accessed if we read the beginning.
--- rmap2/mm/vmscan.c	2004-04-08 20:56:40.953502008 +0100
+++ rmap3/mm/vmscan.c	2004-04-08 20:56:52.183794744 +0100
@@ -190,13 +190,8 @@ static inline int page_mapping_inuse(str
 	if (!mapping)
 		return 0;
 
-	/* File is mmap'd by somebody. */
-	if (!list_empty(&mapping->i_mmap))
-		return 1;
-	if (!list_empty(&mapping->i_mmap_shared))
-		return 1;
-
-	return 0;
+	/* File is mmap'd by somebody? */
+	return mapping_mapped(mapping);
 }
 
 static inline int is_page_cache_freeable(struct page *page)

