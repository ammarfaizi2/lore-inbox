Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946792AbWKALSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946792AbWKALSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946788AbWKALSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:18:45 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:33675 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946792AbWKALSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:18:42 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111840.18798.44019.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 7/11] Introduce the RCLM_KERN allocation type
Date: Wed,  1 Nov 2006 11:18:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some kernel allocations are easily reclaimable such as inode caches and
these reclaimable kernel allocations are by far the most common type of
kernel allocation. This patch marks those type of allocations explicitly
and tries to group them together.

As another page bit would normally be required, it was decided to reuse the
suspend-related page bits and make anti-fragmentation and software suspend
mutually exclusive. A later set of patches introduce a mechanism for setting
flags for a whole block of pages.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 arch/x86_64/kernel/e820.c  |    8 +++++
 fs/buffer.c                |    5 +--
 fs/dcache.c                |    3 +
 fs/ext2/super.c            |    3 +
 fs/ext3/super.c            |    3 +
 fs/jbd/journal.c           |    6 ++-
 fs/jbd/revoke.c            |    6 ++-
 fs/ntfs/inode.c            |    6 ++-
 fs/reiserfs/super.c        |    3 +
 include/linux/gfp.h        |   10 +++---
 include/linux/mmzone.h     |    5 +--
 include/linux/page-flags.h |   51 ++++++++++++++++++++++++++-----
 init/Kconfig               |    1 
 lib/radix-tree.c           |    6 ++-
 mm/page_alloc.c            |   64 ++++++++++++++++++++++++++--------------
 mm/shmem.c                 |    8 +++--
 net/core/skbuff.c          |    1 
 17 files changed, 135 insertions(+), 54 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/arch/x86_64/kernel/e820.c linux-2.6.19-rc4-mm1-007_kernrclm/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc4-mm1-006_movefree/arch/x86_64/kernel/e820.c	2006-10-31 03:37:36.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/arch/x86_64/kernel/e820.c	2006-10-31 13:52:17.000000000 +0000
@@ -217,6 +217,13 @@ void __init e820_reserve_resources(void)
 	}
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
+static void __init
+e820_mark_nosave_range(unsigned long start, unsigned long end)
+{
+	printk("Nosave not set when anti-frag is enabled");
+}
+#else
 /* Mark pages corresponding to given address range as nosave */
 static void __init
 e820_mark_nosave_range(unsigned long start, unsigned long end)
@@ -232,6 +239,7 @@ e820_mark_nosave_range(unsigned long sta
 		if (pfn_valid(pfn))
 			SetPageNosave(pfn_to_page(pfn));
 }
+#endif
 
 /*
  * Find the ranges of physical addresses that do not correspond to
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/buffer.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/buffer.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/buffer.c	2006-10-31 13:29:03.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/buffer.c	2006-10-31 13:52:17.000000000 +0000
@@ -2656,7 +2656,7 @@ int submit_bh(int rw, struct buffer_head
 	 * from here on down, it's all bio -- do the initial mapping,
 	 * submit_bio -> generic_make_request may further map this bio around
 	 */
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(set_rclmflags(GFP_NOIO, __GFP_EASYRCLM), 1);
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
@@ -2936,7 +2936,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+				set_rclmflags(gfp_flags, __GFP_KERNRCLM));
 	if (ret) {
 		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/dcache.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/dcache.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/dcache.c	2006-10-31 13:27:12.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/dcache.c	2006-10-31 13:52:17.000000000 +0000
@@ -861,7 +861,8 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache,
+				set_rclmflags(GFP_KERNEL, __GFP_KERNRCLM));
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/ext2/super.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/ext2/super.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/ext2/super.c	2006-10-31 13:27:12.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/ext2/super.c	2006-10-31 13:52:17.000000000 +0000
@@ -140,7 +140,8 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep,
+				set_rclmflags(SLAB_KERNEL, __GFP_KERNRCLM));
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/ext3/super.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/ext3/super.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/ext3/super.c	2006-10-31 13:27:12.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/ext3/super.c	2006-10-31 13:52:17.000000000 +0000
@@ -445,7 +445,8 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep,
+				set_rclmflags(SLAB_NOFS, __GFP_KERNRCLM));
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/jbd/journal.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/jbd/journal.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/jbd/journal.c	2006-10-31 13:27:12.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/jbd/journal.c	2006-10-31 13:52:17.000000000 +0000
@@ -1735,7 +1735,8 @@ static struct journal_head *journal_allo
 #ifdef CONFIG_JBD_DEBUG
 	atomic_inc(&nr_journal_heads);
 #endif
-	ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
+	ret = kmem_cache_alloc(journal_head_cache,
+				set_rclmflags(GFP_NOFS, __GFP_KERNRCLM));
 	if (ret == 0) {
 		jbd_debug(1, "out of memory for journal_head\n");
 		if (time_after(jiffies, last_warning + 5*HZ)) {
@@ -1745,7 +1746,8 @@ static struct journal_head *journal_allo
 		}
 		while (ret == 0) {
 			yield();
-			ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
+			ret = kmem_cache_alloc(journal_head_cache,
+				set_rclmflags(GFP_NOFS, __GFP_KERNRCLM));
 		}
 	}
 	return ret;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/jbd/revoke.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/jbd/revoke.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/jbd/revoke.c	2006-10-31 03:37:36.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/jbd/revoke.c	2006-10-31 13:52:17.000000000 +0000
@@ -206,7 +206,8 @@ int journal_init_revoke(journal_t *journ
 	while((tmp >>= 1UL) != 0UL)
 		shift++;
 
-	journal->j_revoke_table[0] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+	journal->j_revoke_table[0] = kmem_cache_alloc(revoke_table_cache,
+				set_rclmflags(GFP_KERNEL, __GFP_KERNRCLM));
 	if (!journal->j_revoke_table[0])
 		return -ENOMEM;
 	journal->j_revoke = journal->j_revoke_table[0];
@@ -229,7 +230,8 @@ int journal_init_revoke(journal_t *journ
 	for (tmp = 0; tmp < hash_size; tmp++)
 		INIT_LIST_HEAD(&journal->j_revoke->hash_table[tmp]);
 
-	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache,
+				set_rclmflags(GFP_KERNEL, __GFP_KERNRCLM));
 	if (!journal->j_revoke_table[1]) {
 		kfree(journal->j_revoke_table[0]->hash_table);
 		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/ntfs/inode.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/ntfs/inode.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/ntfs/inode.c	2006-10-31 03:37:36.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/ntfs/inode.c	2006-10-31 13:52:17.000000000 +0000
@@ -324,7 +324,8 @@ struct inode *ntfs_alloc_big_inode(struc
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_big_inode_cache,
+				set_rclmflags(SLAB_NOFS, __GFP_KERNRCLM));
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -349,7 +350,8 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_inode_cache,
+				set_rclmflags(SLAB_NOFS, __GFP_KERNRCLM));
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/fs/reiserfs/super.c linux-2.6.19-rc4-mm1-007_kernrclm/fs/reiserfs/super.c
--- linux-2.6.19-rc4-mm1-006_movefree/fs/reiserfs/super.c	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/fs/reiserfs/super.c	2006-10-31 13:52:17.000000000 +0000
@@ -496,7 +496,8 @@ static struct inode *reiserfs_alloc_inod
 {
 	struct reiserfs_inode_info *ei;
 	ei = (struct reiserfs_inode_info *)
-	    kmem_cache_alloc(reiserfs_inode_cachep, SLAB_KERNEL);
+	    kmem_cache_alloc(reiserfs_inode_cachep,
+			    	set_rclmflags(SLAB_KERNEL, __GFP_KERNRCLM));
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/include/linux/gfp.h linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/gfp.h
--- linux-2.6.19-rc4-mm1-006_movefree/include/linux/gfp.h	2006-10-31 13:29:03.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/gfp.h	2006-10-31 13:52:17.000000000 +0000
@@ -46,9 +46,10 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
-#define __GFP_EASYRCLM	((__force gfp_t)0x80000u) /* Easily reclaimed page */
+#define __GFP_KERNRCLM	((__force gfp_t)0x80000u) /* Kernel reclaimable page */
+#define __GFP_EASYRCLM	((__force gfp_t)0x100000u) /* Easily reclaimed page */
 
-#define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* if you forget to add the bitmask here kernel will crash, period */
@@ -56,10 +57,10 @@ struct vm_area_struct;
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
-			__GFP_EASYRCLM)
+			__GFP_KERNRCLM|__GFP_EASYRCLM)
 
 /* This mask makes up all the RCLM-related flags */
-#define GFP_RECLAIM_MASK (__GFP_EASYRCLM)
+#define GFP_RECLAIM_MASK (__GFP_KERNRCLM|__GFP_EASYRCLM)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -107,6 +108,7 @@ static inline enum zone_type gfp_zone(gf
 
 static inline gfp_t set_rclmflags(gfp_t gfp, gfp_t reclaim_flags)
 {
+	BUG_ON((gfp & GFP_RECLAIM_MASK) == GFP_RECLAIM_MASK);
 	return (gfp & ~(GFP_RECLAIM_MASK)) | reclaim_flags;
 }
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/include/linux/mmzone.h linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/mmzone.h
--- linux-2.6.19-rc4-mm1-006_movefree/include/linux/mmzone.h	2006-10-31 13:35:47.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/mmzone.h	2006-10-31 13:52:17.000000000 +0000
@@ -25,8 +25,9 @@
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 #define RCLM_NORCLM 0
-#define RCLM_EASY   1
-#define RCLM_TYPES  2
+#define RCLM_KERN   1
+#define RCLM_EASY   2
+#define RCLM_TYPES  3
 
 #define for_each_rclmtype(type) \
 	for (type = 0; type < RCLM_TYPES; type++)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/include/linux/page-flags.h linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/page-flags.h
--- linux-2.6.19-rc4-mm1-006_movefree/include/linux/page-flags.h	2006-10-31 13:31:10.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/include/linux/page-flags.h	2006-10-31 13:52:17.000000000 +0000
@@ -82,18 +82,28 @@
 #define PG_private		11	/* If pagecache, has fs-private data */
 
 #define PG_writeback		12	/* Page is under writeback */
-#define PG_nosave		13	/* Used for system suspend/resume */
 #define PG_compound		14	/* Part of a compound page */
 #define PG_swapcache		15	/* Swap page: swp_entry_t in private */
 
 #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
 #define PG_reclaim		17	/* To be reclaimed asap */
-#define PG_nosave_free		18	/* Used for system suspend/resume */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
 #define PG_readahead		20	/* Reminder to do readahead */
 
-#define PG_easyrclm		21	/* Page is an easy reclaim page */
+/*
+ * As anti-fragmentation requires two flags, it was best to reuse the suspend
+ * flags and make anti-fragmentation depend on !SOFTWARE_SUSPEND. This works
+ * on the assumption that machines being suspended do not really care about
+ * large contiguous allocations.
+ */
+#ifndef CONFIG_PAGEALLOC_ANTIFRAG
+#define PG_nosave		13	/* Used for system suspend/resume */
+#define PG_nosave_free		18	/* Free, should not be written */
+#else
+#define PG_kernrclm		13	/* Page is a kernel reclaim page */
+#define PG_easyrclm		18	/* Page is an easy reclaim page */
+#endif
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -211,6 +221,7 @@ static inline void SetPageUptodate(struc
 		ret;							\
 	})
 
+#ifndef CONFIG_PAGEALLOC_ANTIFRAG
 #define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
 #define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
 #define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
@@ -221,6 +232,34 @@ static inline void SetPageUptodate(struc
 #define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
 #define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
 
+#define PageKernRclm(page)	(0)
+#define SetPageKernRclm(page)	do {} while (0)
+#define ClearPageKernRclm(page)	do {} while (0)
+#define __SetPageKernRclm(page)	do {} while (0)
+#define __ClearPageKernRclm(page) do {} while (0)
+
+#define PageEasyRclm(page)	(0)
+#define SetPageEasyRclm(page)	do {} while (0)
+#define ClearPageEasyRclm(page)	do {} while (0)
+#define __SetPageEasyRclm(page)	do {} while (0)
+#define __ClearPageEasyRclm(page) do {} while (0)
+
+#else
+
+#define PageKernRclm(page)	test_bit(PG_kernrclm, &(page)->flags)
+#define SetPageKernRclm(page)	set_bit(PG_kernrclm, &(page)->flags)
+#define ClearPageKernRclm(page)	clear_bit(PG_kernrclm, &(page)->flags)
+#define __SetPageKernRclm(page)	__set_bit(PG_kernrclm, &(page)->flags)
+#define __ClearPageKernRclm(page) __clear_bit(PG_kernrclm, &(page)->flags)
+
+#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
+#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
+#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
+#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
+#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
+
+
 #define PageBuddy(page)		test_bit(PG_buddy, &(page)->flags)
 #define __SetPageBuddy(page)	__set_bit(PG_buddy, &(page)->flags)
 #define __ClearPageBuddy(page)	__clear_bit(PG_buddy, &(page)->flags)
@@ -254,12 +293,6 @@ static inline void SetPageUptodate(struc
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
-#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
-#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
-#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
-#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
-#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
-
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/init/Kconfig linux-2.6.19-rc4-mm1-007_kernrclm/init/Kconfig
--- linux-2.6.19-rc4-mm1-006_movefree/init/Kconfig	2006-10-31 13:42:06.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/init/Kconfig	2006-10-31 13:52:17.000000000 +0000
@@ -494,6 +494,7 @@ config PAGEALLOC_ANTIFRAG
 	  you are interested in working with large pages, say Y and set
 	  /proc/sys/vm/min_free_bytes to be 10% of physical memory. Otherwise
  	  say N
+	depends on !SOFTWARE_SUSPEND
 
 menu "Loadable module support"
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/lib/radix-tree.c linux-2.6.19-rc4-mm1-007_kernrclm/lib/radix-tree.c
--- linux-2.6.19-rc4-mm1-006_movefree/lib/radix-tree.c	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/lib/radix-tree.c	2006-10-31 13:52:17.000000000 +0000
@@ -93,7 +93,8 @@ radix_tree_node_alloc(struct radix_tree_
 	struct radix_tree_node *ret;
 	gfp_t gfp_mask = root_gfp_mask(root);
 
-	ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+	ret = kmem_cache_alloc(radix_tree_node_cachep,
+					set_rclmflags(gfp_mask, __GFP_KERNRCLM));
 	if (ret == NULL && !(gfp_mask & __GFP_WAIT)) {
 		struct radix_tree_preload *rtp;
 
@@ -137,7 +138,8 @@ int radix_tree_preload(gfp_t gfp_mask)
 	rtp = &__get_cpu_var(radix_tree_preloads);
 	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
 		preempt_enable();
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+		node = kmem_cache_alloc(radix_tree_node_cachep,
+					set_rclmflags(gfp_mask, __GFP_KERNRCLM));
 		if (node == NULL)
 			goto out;
 		preempt_disable();
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/mm/page_alloc.c linux-2.6.19-rc4-mm1-007_kernrclm/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-006_movefree/mm/page_alloc.c	2006-10-31 13:50:10.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/mm/page_alloc.c	2006-10-31 13:52:17.000000000 +0000
@@ -138,12 +138,16 @@ static unsigned long __initdata dma_rese
 #ifdef CONFIG_PAGEALLOC_ANTIFRAG
 static inline int get_page_rclmtype(struct page *page)
 {
-	return (PageEasyRclm(page) != 0);
+	return ((PageEasyRclm(page) != 0) << 1) | (PageKernRclm(page) != 0);
 }
 
 static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
 {
-	return ((gfp_flags & __GFP_EASYRCLM) != 0);
+	gfp_t badflags = (__GFP_EASYRCLM | __GFP_KERNRCLM);
+	WARN_ON((gfp_flags & badflags) == badflags);
+
+	return (((gfp_flags & __GFP_EASYRCLM) != 0) << 1) |
+		((gfp_flags & __GFP_KERNRCLM) != 0);
 }
 #else
 static inline int get_page_rclmtype(struct page *page)
@@ -433,6 +437,7 @@ static inline void __free_one_page(struc
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 	__SetPageEasyRclm(page);
+	__ClearPageKernRclm(page);
 
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
@@ -710,6 +715,12 @@ int move_freepages_block(struct zone *zo
 	return move_freepages(zone, start_page, end_page, rclmtype);
 }
 
+static int fallbacks[RCLM_TYPES][RCLM_TYPES] = {
+	{ RCLM_KERN,   RCLM_EASY  }, /* RCLM_NORCLM Fallback */
+	{ RCLM_NORCLM, RCLM_EASY  }, /* RCLM_KERN Fallback */
+	{ RCLM_KERN,   RCLM_NORCLM}  /* RCLM_EASY Fallback */
+};
+
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							gfp_t gfp_flags)
@@ -718,30 +729,36 @@ static struct page *__rmqueue_fallback(s
 	int current_order;
 	struct page *page;
 	int start_rclmtype = gfpflags_to_rclmtype(gfp_flags);
-	int rclmtype = !start_rclmtype;
+	int rclmtype, i;
 
 	/* Find the largest possible block of pages in the other list */
 	for (current_order = MAX_ORDER-1; current_order >= order;
 						--current_order) {
-		area = &(zone->free_area[current_order]);
- 		if (list_empty(&area->free_list[rclmtype]))
- 			continue;
+		for (i = 0; i < RCLM_TYPES - 1; i++) {
+			rclmtype = fallbacks[start_rclmtype][i];
 
-		page = list_entry(area->free_list[rclmtype].next,
-					struct page, lru);
-		area->nr_free--;
+			area = &(zone->free_area[current_order]);
+			if (list_empty(&area->free_list[rclmtype]))
+				continue;
 
-		/* Remove the page from the freelists */
-		list_del(&page->lru);
-		rmv_page_order(page);
-		zone->free_pages -= 1UL << order;
-		expand(zone, page, order, current_order, area, rclmtype);
+			page = list_entry(area->free_list[rclmtype].next,
+					struct page, lru);
+			area->nr_free--;
 
-		/* Move free pages between lists if stealing a large block */
-		if (current_order > MAX_ORDER / 2)
-			move_freepages_block(zone, page, start_rclmtype);
+			/* Remove the page from the freelists */
+			list_del(&page->lru);
+			rmv_page_order(page);
+			zone->free_pages -= 1UL << order;
+			expand(zone, page, order, current_order, area,
+							start_rclmtype);
+
+			/* Move free pages between lists for large blocks */
+			if (current_order >= MAX_ORDER / 2)
+				move_freepages_block(zone, page,
+							start_rclmtype);
 
-		return page;
+			return page;
+		}
 	}
 
 	return NULL;
@@ -797,9 +814,12 @@ static struct page *__rmqueue(struct zon
 	page = __rmqueue_fallback(zone, order, gfp_flags);
 
 got_page:
-	if (unlikely(rclmtype == RCLM_NORCLM) && page)
+	if (unlikely(rclmtype != RCLM_EASY) && page)
 		__ClearPageEasyRclm(page);
 
+	if (rclmtype == RCLM_KERN && page)
+		SetPageKernRclm(page);
+
 	return page;
 }
 
@@ -894,7 +914,7 @@ static void __drain_pages(unsigned int c
 }
 #endif /* CONFIG_DRAIN_PERCPU_PAGES */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SOFTWARE_SUSPEND
 
 void mark_free_pages(struct zone *zone)
 {
@@ -2217,7 +2237,7 @@ inline void setup_pageset(struct per_cpu
 		pcp->counts[rclmtype] = 0;
 		INIT_LIST_HEAD(&pcp->list[rclmtype]);
 	}
-	pcp->high = 6 * batch;
+	pcp->high = 3 * batch;
 	pcp->batch = max(1UL, 1 * batch);
 	INIT_LIST_HEAD(&pcp->list[RCLM_EASY]);
 
@@ -2226,7 +2246,7 @@ inline void setup_pageset(struct per_cpu
 		pcp->counts[rclmtype] = 0;
 		INIT_LIST_HEAD(&pcp->list[rclmtype]);
 	}
-	pcp->high = 2 * batch;
+	pcp->high = batch;
 	pcp->batch = max(1UL, batch/2);
 }
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/mm/shmem.c linux-2.6.19-rc4-mm1-007_kernrclm/mm/shmem.c
--- linux-2.6.19-rc4-mm1-006_movefree/mm/shmem.c	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/mm/shmem.c	2006-10-31 13:52:17.000000000 +0000
@@ -94,7 +94,8 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
-	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+	return alloc_pages(set_rclmflags(gfp_mask, __GFP_KERNRCLM),
+						PAGE_CACHE_SHIFT-PAGE_SHIFT);
 }
 
 static inline void shmem_dir_free(struct page *page)
@@ -976,7 +977,8 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
+	page = alloc_page_vma(set_rclmflags(gfp | __GFP_ZERO, __GFP_KERNRCLM),
+								&pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -996,7 +998,7 @@ shmem_swapin(struct shmem_inode_info *in
 static inline struct page *
 shmem_alloc_page(gfp_t gfp,struct shmem_inode_info *info, unsigned long idx)
 {
-	return alloc_page(gfp | __GFP_ZERO);
+	return alloc_page(set_rclmflags(gfp | __GFP_ZERO, __GFP_KERNRCLM));
 }
 #endif
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-006_movefree/net/core/skbuff.c linux-2.6.19-rc4-mm1-007_kernrclm/net/core/skbuff.c
--- linux-2.6.19-rc4-mm1-006_movefree/net/core/skbuff.c	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-007_kernrclm/net/core/skbuff.c	2006-10-31 13:52:17.000000000 +0000
@@ -148,6 +148,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	u8 *data;
 
 	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
+	gfp_mask |= __GFP_KERNRCLM;
 
 	/* Get the HEAD */
 	skb = kmem_cache_alloc(cache, gfp_mask & ~__GFP_DMA);
