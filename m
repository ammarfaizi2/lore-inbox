Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTKVAxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbTKVAxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 19:53:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24016 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261776AbTKVAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 19:52:53 -0500
Message-ID: <3FBEB27D.5010007@us.ibm.com>
Date: Fri, 21 Nov 2003 16:49:01 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com,
       Andrew Morton <akpm@digeo.com>
Subject: [RFC] Make balance_dirty_pages zone aware (1/2)
Content-Type: multipart/mixed;
 boundary="------------070907060800030008030803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907060800030008030803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently the VM decides to start doing background writeback of pages if 
10% of the systems pages are dirty, and starts doing synchronous 
writeback of pages if 40% are dirty.  This is great for smaller memory 
systems, but in larger memory systems (>2GB or so), a process can dirty 
ALL of lowmem (ZONE_NORMAL, 896MB) without hitting the 40% dirty page 
ratio needed to force the process to do writeback.  For this and other 
reasons, it'd be nice to have a zone aware dirty page balancer.  That is 
precisely what these 2 patches try to achieve.

Patch 1/2 - setup_perzone_counters.patch:

This patch does the following things:
	1) balance_dirty_pages uses the first 6 statistics in struct page_state 
(nr_dirty, nr_writeback, nr_unstable, nr_page_table_pages, nr_mapped, 
and nr_slab) to determine when to start writeback.  These stats must 
therefore be maintained on a per-zone basis.  Create a new struct 
perzone_page_state which contains these statistics and embed an array of 
length NR_CPUS of these structures in struct zone.
	2) Add a set of macros mirroring the (mod|inc|dec)_page_state macros 
called (mod|inc|dec)_perzone_page_state to update the per-zone page 
state stats.
	3) Replace all occurences(*) of (mod|inc|dec)_page_state calls that 
modify the per-zone stats with the per-zone versions of the macros.
	4) Modify the get_page_state and get_full_page_state calls to correctly 
gather all the page stats.
	5) Add a get_page_state_zone call to get the page stats for a specific 
zone.

(*) The (mod|inc|dec)_page_state calls in the NFS code have given me 
some trouble.  To determine which zone's statistics to modify, we must 
have a struct page handy, but the NFS code does it's statistics updates 
in bulk, without reference in most cases to the pages.  Thus, the NFS 
code still needs updating, and is noted in the patch.

Comments/criticism requested! :)

Cheers!

-Matt

--------------070907060800030008030803
Content-Type: text/plain;
 name="setup_perzone_counters.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup_perzone_counters.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/fs/buffer.c linux-2.6.0-test9-setup_perzone_counters/fs/buffer.c
--- linux-2.6.0-test9-mm4/fs/buffer.c	Wed Nov 19 15:22:46 2003
+++ linux-2.6.0-test9-setup_perzone_counters/fs/buffer.c	Wed Nov 19 15:26:22 2003
@@ -888,7 +888,7 @@ int __set_page_dirty_buffers(struct page
 		spin_lock(&mapping->page_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (!mapping->backing_dev_info->memory_backed)
-				inc_page_state(nr_dirty);
+				inc_perzone_page_state(nr_dirty, page);
 			list_del(&page->list);
 			list_add(&page->list, &mapping->dirty_pages);
 		}
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/fs/nfs/write.c linux-2.6.0-test9-setup_perzone_counters/fs/nfs/write.c
--- linux-2.6.0-test9-mm4/fs/nfs/write.c	Sat Oct 25 11:44:12 2003
+++ linux-2.6.0-test9-setup_perzone_counters/fs/nfs/write.c	Thu Nov 20 13:40:18 2003
@@ -368,6 +368,7 @@ nfs_mark_request_dirty(struct nfs_page *
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfs_wreq_lock);
+	/* FIXME - NFS perzone page accounting broken! */
 	inc_page_state(nr_dirty);
 	mark_inode_dirty(inode);
 }
@@ -396,6 +397,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfs_wreq_lock);
+	/* FIXME - NFS perzone page accounting broken! */
 	inc_page_state(nr_unstable);
 	mark_inode_dirty(inode);
 }
@@ -464,7 +466,8 @@ nfs_scan_dirty(struct inode *inode, stru
 	int	res;
 	res = nfs_scan_list(&nfsi->dirty, dst, file, idx_start, npages);
 	nfsi->ndirty -= res;
-	sub_page_state(nr_dirty,res);
+	/* FIXME - NFS perzone page accounting broken! */
+	mod_page_state(nr_dirty, 0UL - res);
 	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	return res;
@@ -1006,7 +1009,6 @@ nfs_commit_done(struct rpc_task *task)
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *)task->tk_calldata;
 	struct nfs_page		*req;
-	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1040,10 +1042,10 @@ nfs_commit_done(struct rpc_task *task)
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 	next:
+		/* FIXME - NFS perzone page accounting broken! */
+		dec_page_state(nr_unstable);
 		nfs_unlock_request(req);
-		res++;
 	}
-	sub_page_state(nr_unstable,res);
 }
 #endif
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/include/asm-arm26/rmap.h linux-2.6.0-test9-setup_perzone_counters/include/asm-arm26/rmap.h
--- linux-2.6.0-test9-mm4/include/asm-arm26/rmap.h	Sat Oct 25 11:43:29 2003
+++ linux-2.6.0-test9-setup_perzone_counters/include/asm-arm26/rmap.h	Wed Nov 19 15:26:22 2003
@@ -16,14 +16,14 @@ static inline void pgtable_add_rmap(stru
 {
         page->mapping = (void *)mm;
         page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-        inc_page_state(nr_page_table_pages);
+        inc_perzone_page_state(nr_page_table_pages, page);
 }
 
 static inline void pgtable_remove_rmap(struct page *page)
 {
         page->mapping = NULL;
         page->index = 0;
-        dec_page_state(nr_page_table_pages);
+        dec_perzone_page_state(nr_page_table_pages, page);
 }
 
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/include/asm-generic/rmap.h linux-2.6.0-test9-setup_perzone_counters/include/asm-generic/rmap.h
--- linux-2.6.0-test9-mm4/include/asm-generic/rmap.h	Sat Oct 25 11:43:56 2003
+++ linux-2.6.0-test9-setup_perzone_counters/include/asm-generic/rmap.h	Wed Nov 19 15:26:22 2003
@@ -37,14 +37,14 @@ static inline void pgtable_add_rmap(stru
 #endif
 	page->mapping = (void *)mm;
 	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-	inc_page_state(nr_page_table_pages);
+	inc_perzone_page_state(nr_page_table_pages, page);
 }
 
 static inline void pgtable_remove_rmap(struct page * page)
 {
 	page->mapping = NULL;
 	page->index = 0;
-	dec_page_state(nr_page_table_pages);
+	dec_perzone_page_state(nr_page_table_pages, page);
 }
 
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/include/linux/mmzone.h linux-2.6.0-test9-setup_perzone_counters/include/linux/mmzone.h
--- linux-2.6.0-test9-mm4/include/linux/mmzone.h	Wed Nov 19 15:22:48 2003
+++ linux-2.6.0-test9-setup_perzone_counters/include/linux/mmzone.h	Fri Nov 21 14:21:34 2003
@@ -55,6 +55,21 @@ struct per_cpu_pageset {
 } ____cacheline_aligned_in_smp;
 
 /*
+ * Per-zone page accounting.  One instance per-zone per-CPU.  This structure 
+ * should mirror the fields of struct page_state (from in linux/page-flags.h) 
+ * that are used by balance_dirty_pages_ratelimited (currently all the 'nr_' 
+ * fields).  Only unsigned longs are allowed.
+ */
+struct perzone_page_state {
+	unsigned long nr_dirty;
+	unsigned long nr_writeback;
+	unsigned long nr_unstable;
+	unsigned long nr_page_table_pages;
+	unsigned long nr_mapped;
+	unsigned long nr_slab;
+} ____cacheline_aligned_in_smp;
+
+/*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
  *
@@ -140,6 +155,8 @@ struct zone {
 
 	struct per_cpu_pageset	pageset[NR_CPUS];
 
+	struct perzone_page_state page_state[NR_CPUS];
+
 	/*
 	 * Discontig memory support fields.
 	 */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/include/linux/page-flags.h linux-2.6.0-test9-setup_perzone_counters/include/linux/page-flags.h
--- linux-2.6.0-test9-mm4/include/linux/page-flags.h	Sat Oct 25 11:44:06 2003
+++ linux-2.6.0-test9-setup_perzone_counters/include/linux/page-flags.h	Fri Nov 21 15:12:42 2003
@@ -88,7 +88,6 @@ struct page_state {
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
@@ -117,12 +116,16 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 } ____cacheline_aligned;
-
 DECLARE_PER_CPU(struct page_state, page_states);
 
+extern void get_page_state_zone(struct page_state *ret, struct zone *zone);
 extern void get_page_state(struct page_state *ret);
 extern void get_full_page_state(struct page_state *ret);
 
+/*
+ * Use these macros to modify the page statistics that don't start with 'nr_' 
+ * which are maintained solely on a per-cpu basis.
+ */
 #define mod_page_state(member, delta)					\
 	do {								\
 		unsigned long flags;					\
@@ -130,10 +133,22 @@ extern void get_full_page_state(struct p
 		__get_cpu_var(page_states).member += (delta);		\
 		local_irq_restore(flags);				\
 	} while (0)
-
 #define inc_page_state(member)	mod_page_state(member, 1UL)
 #define dec_page_state(member)	mod_page_state(member, 0UL - 1)
-#define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
+
+/*
+ * Use these macros to modify the 'nr_' page statistics which are maintained
+ * on a per-zone per-cpu basis.
+ */
+#define mod_perzone_page_state(member, page, delta)					\
+	do {										\
+		unsigned long flags;							\
+		local_irq_save(flags);							\
+		page_zone(page)->page_state[smp_processor_id()].member += (delta);	\
+		local_irq_restore(flags);						\
+	} while (0)
+#define inc_perzone_page_state(member, page)	mod_perzone_page_state(member, page, 1UL)
+#define dec_perzone_page_state(member, page)	mod_perzone_page_state(member, page, 0UL - 1)
 
 
 /*
@@ -217,7 +232,7 @@ extern void get_full_page_state(struct p
 	do {								\
 		if (!test_and_set_bit(PG_writeback,			\
 				&(page)->flags))			\
-			inc_page_state(nr_writeback);			\
+			inc_perzone_page_state(nr_writeback, page);	\
 	} while (0)
 #define TestSetPageWriteback(page)					\
 	({								\
@@ -225,14 +240,14 @@ extern void get_full_page_state(struct p
 		ret = test_and_set_bit(PG_writeback,			\
 					&(page)->flags);		\
 		if (!ret)						\
-			inc_page_state(nr_writeback);			\
+			inc_perzone_page_state(nr_writeback, page);	\
 		ret;							\
 	})
 #define ClearPageWriteback(page)					\
 	do {								\
 		if (test_and_clear_bit(PG_writeback,			\
 				&(page)->flags))			\
-			dec_page_state(nr_writeback);			\
+			dec_perzone_page_state(nr_writeback, page);	\
 	} while (0)
 #define TestClearPageWriteback(page)					\
 	({								\
@@ -240,7 +255,7 @@ extern void get_full_page_state(struct p
 		ret = test_and_clear_bit(PG_writeback,			\
 				&(page)->flags);			\
 		if (ret)						\
-			dec_page_state(nr_writeback);			\
+			dec_perzone_page_state(nr_writeback, page);	\
 		ret;							\
 	})
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/mm/page-writeback.c linux-2.6.0-test9-setup_perzone_counters/mm/page-writeback.c
--- linux-2.6.0-test9-mm4/mm/page-writeback.c	Wed Nov 19 15:22:49 2003
+++ linux-2.6.0-test9-setup_perzone_counters/mm/page-writeback.c	Wed Nov 19 15:26:22 2003
@@ -524,7 +524,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (page->mapping) {	/* Race with truncate? */
 				BUG_ON(page->mapping != mapping);
 				if (!mapping->backing_dev_info->memory_backed)
-					inc_page_state(nr_dirty);
+					inc_perzone_page_state(nr_dirty, page);
 				list_del(&page->list);
 				list_add(&page->list, &mapping->dirty_pages);
 			}
@@ -569,7 +569,7 @@ int test_clear_page_dirty(struct page *p
 		struct address_space *mapping = page->mapping;
 
 		if (mapping && !mapping->backing_dev_info->memory_backed)
-			dec_page_state(nr_dirty);
+			dec_perzone_page_state(nr_dirty, page);
 		return 1;
 	}
 	return 0;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/mm/page_alloc.c linux-2.6.0-test9-setup_perzone_counters/mm/page_alloc.c
--- linux-2.6.0-test9-mm4/mm/page_alloc.c	Wed Nov 19 15:22:49 2003
+++ linux-2.6.0-test9-setup_perzone_counters/mm/page_alloc.c	Fri Nov 21 14:27:51 2003
@@ -859,11 +859,47 @@ EXPORT_SYMBOL(nr_pagecache);
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
 
-void __get_page_state(struct page_state *ret, int nr)
+/*
+ * Get the zone-specific page stats for @zone, summed across all cpus.
+ * Make sure you zero @ret before passing it in!
+ */
+void get_page_state_zone(struct page_state *ret, struct zone *zone)
 {
 	int cpu = 0;
 
+	for (; cpu < NR_CPUS; cpu++) {
+		ret->nr_dirty		+= zone->page_state[cpu].nr_dirty;
+		ret->nr_writeback	+= zone->page_state[cpu].nr_writeback;
+		ret->nr_unstable	+= zone->page_state[cpu].nr_unstable;
+		ret->nr_page_table_pages+= zone->page_state[cpu].nr_page_table_pages;
+		ret->nr_mapped		+= zone->page_state[cpu].nr_mapped;
+		ret->nr_slab		+= zone->page_state[cpu].nr_slab;
+	}
+}
+
+/*
+ * Get the zone-specific page stats, summed across all zones/cpus.
+ */
+void get_page_state(struct page_state *ret)
+{
+	struct zone *zone;
+
 	memset(ret, 0, sizeof(*ret));
+	for_each_zone(zone) {
+		get_page_state_zone(ret, zone);
+	}
+}
+
+/*
+ * Get system-wide page stats, summed across all cpus.
+ */
+void get_full_page_state(struct page_state *ret)
+{
+	int cpu = 0;
+
+	/* Get the per-zone stats */
+	get_page_state(ret);
+
 	while (cpu < NR_CPUS) {
 		unsigned long *in, *out, off;
 
@@ -877,26 +913,11 @@ void __get_page_state(struct page_state 
 		if (cpu < NR_CPUS && cpu_online(cpu))
 			prefetch(&per_cpu(page_states, cpu));
 		out = (unsigned long *)ret;
-		for (off = 0; off < nr; off++)
+		for (off = 0; off < sizeof(*ret)/sizeof(unsigned long); off++)
 			*out++ += *in++;
 	}
 }
 
-void get_page_state(struct page_state *ret)
-{
-	int nr;
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr + 1);
-}
-
-void get_full_page_state(struct page_state *ret)
-{
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long));
-}
-
 void get_zone_counts(unsigned long *active,
 		unsigned long *inactive, unsigned long *free)
 {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/mm/rmap.c linux-2.6.0-test9-setup_perzone_counters/mm/rmap.c
--- linux-2.6.0-test9-mm4/mm/rmap.c	Sat Oct 25 11:44:44 2003
+++ linux-2.6.0-test9-setup_perzone_counters/mm/rmap.c	Wed Nov 19 15:26:22 2003
@@ -178,7 +178,7 @@ page_add_rmap(struct page *page, pte_t *
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
-		inc_page_state(nr_mapped);
+		inc_perzone_page_state(nr_mapped, page);
 		goto out;
 	}
 
@@ -272,7 +272,7 @@ void page_remove_rmap(struct page *page,
 	}
 out:
 	if (!page_mapped(page))
-		dec_page_state(nr_mapped);
+		dec_perzone_page_state(nr_mapped, page);
 out_unlock:
 	pte_chain_unlock(page);
 	return;
@@ -453,7 +453,7 @@ int try_to_unmap(struct page * page)
 	}
 out:
 	if (!page_mapped(page))
-		dec_page_state(nr_mapped);
+		dec_perzone_page_state(nr_mapped, page);
 	return ret;
 }
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-mm4/mm/slab.c linux-2.6.0-test9-setup_perzone_counters/mm/slab.c
--- linux-2.6.0-test9-mm4/mm/slab.c	Wed Nov 19 15:22:49 2003
+++ linux-2.6.0-test9-setup_perzone_counters/mm/slab.c	Wed Nov 19 15:26:22 2003
@@ -832,9 +832,9 @@ static inline void kmem_freepages(kmem_c
 	while (i--) {
 		if (!TestClearPageSlab(page))
 			BUG();
+		dec_perzone_page_state(nr_slab, page);
 		page++;
 	}
-	sub_page_state(nr_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
@@ -1620,7 +1620,7 @@ static int cache_grow (kmem_cache_t * ca
 	do {
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
-		inc_page_state(nr_slab);
+		inc_perzone_page_state(nr_slab, page);
 		page++;
 	} while (--i);
 

--------------070907060800030008030803--

