Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031266AbWKUWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031266AbWKUWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031294AbWKUWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:52:56 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:21415 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031266AbWKUWwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:52:44 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225243.11710.86941.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 7/11] Mark short-lived and reclaimable kernel allocations
Date: Tue, 21 Nov 2006 22:52:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel makes a number of allocations that are either short-lived such as
network buffers or are reclaimable such as inode allocations. When something
like updatedb is called, long-lived and unmovable kernel allocations tend
to be spread throughout the address space which increases fragmentation.

This patch clusters these allocations together as much as possible. As
it requires another page bit, the suspend bits are reused instead. Three
patches at the end of this set will introduce an alternative to using page
flags allowing suspend to be used again.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 arch/x86_64/kernel/e820.c  |    8 +++++
 fs/buffer.c                |    3 +-
 fs/dcache.c                |    2 -
 fs/ext2/super.c            |    3 +-
 fs/ext3/super.c            |    2 -
 fs/jbd/journal.c           |    6 ++--
 fs/jbd/revoke.c            |    6 ++--
 fs/ntfs/inode.c            |    6 ++--
 fs/proc/base.c             |   13 ++++----
 fs/proc/generic.c          |    2 -
 fs/reiserfs/super.c        |    3 +-
 include/linux/gfp.h        |   16 ++++++++--
 include/linux/mmzone.h     |   14 +++++----
 include/linux/page-flags.h |   50 +++++++++++++++++++++++++++------
 init/Kconfig               |    1 
 lib/radix-tree.c           |    6 ++--
 mm/page_alloc.c            |   59 ++++++++++++++++++++++++++--------------
 mm/shmem.c                 |   10 ++++--
 net/core/skbuff.c          |    1 
 19 files changed, 150 insertions(+), 61 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/arch/x86_64/kernel/e820.c linux-2.6.19-rc5-mm2-008_reclaimable/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc5-mm2-007_movefree/arch/x86_64/kernel/e820.c	2006-11-14 14:01:35.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/arch/x86_64/kernel/e820.c	2006-11-21 10:57:46.000000000 +0000
@@ -217,6 +217,13 @@ void __init e820_reserve_resources(void)
 	}
 }
 
+#ifdef CONFIG_PAGE_CLUSTERING
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/buffer.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/buffer.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/buffer.c	2006-11-21 10:47:11.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/buffer.c	2006-11-21 10:57:46.000000000 +0000
@@ -3004,7 +3004,8 @@ static void recalc_bh_state(void)
 	
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
 {
-	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
+	struct buffer_head *ret = kmem_cache_alloc(bh_cachep,
+				set_migrateflags(gfp_flags, __GFP_RECLAIMABLE));
 	if (ret) {
 		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/dcache.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/dcache.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/dcache.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/dcache.c	2006-11-21 10:57:46.000000000 +0000
@@ -861,7 +861,7 @@ struct dentry *d_alloc(struct dentry * p
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL|__GFP_RECLAIMABLE);
 	if (!dentry)
 		return NULL;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/ext2/super.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/ext2/super.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/ext2/super.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/ext2/super.c	2006-11-21 10:57:46.000000000 +0000
@@ -140,7 +140,8 @@ static kmem_cache_t * ext2_inode_cachep;
 static struct inode *ext2_alloc_inode(struct super_block *sb)
 {
 	struct ext2_inode_info *ei;
-	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
+	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep,
+					SLAB_KERNEL|__GFP_RECLAIMABLE);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/ext3/super.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/ext3/super.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/ext3/super.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/ext3/super.c	2006-11-21 10:57:46.000000000 +0000
@@ -445,7 +445,7 @@ static struct inode *ext3_alloc_inode(st
 {
 	struct ext3_inode_info *ei;
 
-	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
+	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS|__GFP_RECLAIMABLE);
 	if (!ei)
 		return NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/jbd/journal.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/jbd/journal.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/jbd/journal.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/jbd/journal.c	2006-11-21 10:57:46.000000000 +0000
@@ -1735,7 +1735,8 @@ static struct journal_head *journal_allo
 #ifdef CONFIG_JBD_DEBUG
 	atomic_inc(&nr_journal_heads);
 #endif
-	ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
+	ret = kmem_cache_alloc(journal_head_cache,
+			set_migrateflags(GFP_NOFS, __GFP_RECLAIMABLE));
 	if (ret == 0) {
 		jbd_debug(1, "out of memory for journal_head\n");
 		if (time_after(jiffies, last_warning + 5*HZ)) {
@@ -1745,7 +1746,8 @@ static struct journal_head *journal_allo
 		}
 		while (ret == 0) {
 			yield();
-			ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
+			ret = kmem_cache_alloc(journal_head_cache,
+					GFP_NOFS|__GFP_RECLAIMABLE);
 		}
 	}
 	return ret;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/jbd/revoke.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/jbd/revoke.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/jbd/revoke.c	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/jbd/revoke.c	2006-11-21 10:57:46.000000000 +0000
@@ -206,7 +206,8 @@ int journal_init_revoke(journal_t *journ
 	while((tmp >>= 1UL) != 0UL)
 		shift++;
 
-	journal->j_revoke_table[0] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+	journal->j_revoke_table[0] = kmem_cache_alloc(revoke_table_cache,
+					GFP_KERNEL|__GFP_RECLAIMABLE);
 	if (!journal->j_revoke_table[0])
 		return -ENOMEM;
 	journal->j_revoke = journal->j_revoke_table[0];
@@ -229,7 +230,8 @@ int journal_init_revoke(journal_t *journ
 	for (tmp = 0; tmp < hash_size; tmp++)
 		INIT_LIST_HEAD(&journal->j_revoke->hash_table[tmp]);
 
-	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache, GFP_KERNEL);
+	journal->j_revoke_table[1] = kmem_cache_alloc(revoke_table_cache,
+					GFP_KERNEL|__GFP_RECLAIMABLE);
 	if (!journal->j_revoke_table[1]) {
 		kfree(journal->j_revoke_table[0]->hash_table);
 		kmem_cache_free(revoke_table_cache, journal->j_revoke_table[0]);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/ntfs/inode.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/ntfs/inode.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/ntfs/inode.c	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/ntfs/inode.c	2006-11-21 10:57:46.000000000 +0000
@@ -324,7 +324,8 @@ struct inode *ntfs_alloc_big_inode(struc
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_big_inode_cache,
+					SLAB_NOFS|__GFP_RECLAIMABLE);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
@@ -349,7 +350,8 @@ static inline ntfs_inode *ntfs_alloc_ext
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
+	ni = kmem_cache_alloc(ntfs_inode_cache,
+					SLAB_NOFS|__GFP_RECLAIMABLE);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/proc/base.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/proc/base.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/proc/base.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/proc/base.c	2006-11-21 10:57:46.000000000 +0000
@@ -484,7 +484,7 @@ static ssize_t proc_info_read(struct fil
 		count = PROC_BLOCK_SIZE;
 
 	length = -ENOMEM;
-	if (!(page = __get_free_page(GFP_KERNEL)))
+	if (!(page = __get_free_page(GFP_KERNEL|__GFP_RECLAIMABLE)))
 		goto out;
 
 	length = PROC_I(inode)->op.proc_read(task, (char*)page);
@@ -594,7 +594,7 @@ static ssize_t mem_write(struct file * f
 		goto out;
 
 	copied = -ENOMEM;
-	page = (char *)__get_free_page(GFP_USER);
+	page = (char *)__get_free_page(GFP_USER|__GFP_RECLAIMABLE);
 	if (!page)
 		goto out;
 
@@ -751,7 +751,7 @@ static ssize_t proc_loginuid_write(struc
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)__get_free_page(GFP_USER);
+	page = (char*)__get_free_page(GFP_USER|__GFP_RECLAIMABLE);
 	if (!page)
 		return -ENOMEM;
 	length = -EFAULT;
@@ -933,7 +933,8 @@ static int do_proc_readlink(struct dentr
 			    char __user *buffer, int buflen)
 {
 	struct inode * inode;
-	char *tmp = (char*)__get_free_page(GFP_KERNEL), *path;
+	char *tmp = (char*)__get_free_page(GFP_KERNEL|__GFP_RECLAIMABLE);
+	char *path;
 	int len;
 
 	if (!tmp)
@@ -1566,7 +1567,7 @@ static ssize_t proc_pid_attr_read(struct
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 	length = -ENOMEM;
-	if (!(page = __get_free_page(GFP_KERNEL)))
+	if (!(page = __get_free_page(GFP_KERNEL|__GFP_RECLAIMABLE)))
 		goto out;
 
 	length = security_getprocattr(task,
@@ -1601,7 +1602,7 @@ static ssize_t proc_pid_attr_write(struc
 		goto out;
 
 	length = -ENOMEM;
-	page = (char*)__get_free_page(GFP_USER);
+	page = (char*)__get_free_page(GFP_USER|__GFP_RECLAIMABLE);
 	if (!page)
 		goto out;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/proc/generic.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/proc/generic.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/proc/generic.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/proc/generic.c	2006-11-21 10:57:46.000000000 +0000
@@ -73,7 +73,7 @@ proc_file_read(struct file *file, char _
 		nbytes = MAX_NON_LFS - pos;
 
 	dp = PDE(inode);
-	if (!(page = (char*) __get_free_page(GFP_KERNEL)))
+	if (!(page = (char*) __get_free_page(GFP_KERNEL|__GFP_RECLAIMABLE)))
 		return -ENOMEM;
 
 	while ((nbytes > 0) && !eof) {
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/fs/reiserfs/super.c linux-2.6.19-rc5-mm2-008_reclaimable/fs/reiserfs/super.c
--- linux-2.6.19-rc5-mm2-007_movefree/fs/reiserfs/super.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/fs/reiserfs/super.c	2006-11-21 10:57:46.000000000 +0000
@@ -496,7 +496,8 @@ static struct inode *reiserfs_alloc_inod
 {
 	struct reiserfs_inode_info *ei;
 	ei = (struct reiserfs_inode_info *)
-	    kmem_cache_alloc(reiserfs_inode_cachep, SLAB_KERNEL);
+		kmem_cache_alloc(reiserfs_inode_cachep,
+		    			SLAB_KERNEL|__GFP_RECLAIMABLE);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/include/linux/gfp.h linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/gfp.h
--- linux-2.6.19-rc5-mm2-007_movefree/include/linux/gfp.h	2006-11-21 10:47:11.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/gfp.h	2006-11-21 10:57:46.000000000 +0000
@@ -46,9 +46,10 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
-#define __GFP_MOVABLE	((__force gfp_t)0x80000u) /* Page is movable */
+#define __GFP_RECLAIMABLE ((__force gfp_t)0x80000u) /* Page is reclaimable */
+#define __GFP_MOVABLE	((__force gfp_t)0x100000u)  /* Page is movable */
 
-#define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* if you forget to add the bitmask here kernel will crash, period */
@@ -56,7 +57,10 @@ struct vm_area_struct;
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
-			__GFP_MOVABLE)
+			__GFP_RECLAIMABLE|__GFP_MOVABLE)
+
+/* This mask makes up all the page movable related flags */
+#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -102,6 +106,12 @@ static inline enum zone_type gfp_zone(gf
 	return ZONE_NORMAL;
 }
 
+static inline gfp_t set_migrateflags(gfp_t gfp, gfp_t migrate_flags)
+{
+	BUG_ON((gfp & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
+	return (gfp & ~(GFP_MOVABLE_MASK)) | migrate_flags;
+}
+
 /*
  * There is only one page-allocator function, and two main namespaces to
  * it. The alloc_page*() variants return 'struct page *' and as such
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/include/linux/mmzone.h linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/mmzone.h
--- linux-2.6.19-rc5-mm2-007_movefree/include/linux/mmzone.h	2006-11-21 10:52:26.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/mmzone.h	2006-11-21 10:57:46.000000000 +0000
@@ -25,12 +25,14 @@
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 #ifdef CONFIG_PAGE_CLUSTERING
-#define MIGRATE_UNMOVABLE 0
-#define MIGRATE_MOVABLE   1
-#define MIGRATE_TYPES     2
-#else
-#define MIGRATE_UNMOVABLE 0
-#define MIGRATE_MOVABLE   0
+#define MIGRATE_UNMOVABLE   0
+#define MIGRATE_RECLAIMABLE 1
+#define MIGRATE_MOVABLE     2
+#define MIGRATE_TYPES       3
+#else
+#define MIGRATE_UNMOVABLE   0
+#define MIGRATE_RECLAIMABLE 0
+#define MIGRATE_MOVABLE     0
 #define MIGRATE_TYPES     1
 #endif
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/include/linux/page-flags.h linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/page-flags.h
--- linux-2.6.19-rc5-mm2-007_movefree/include/linux/page-flags.h	2006-11-21 10:48:55.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/include/linux/page-flags.h	2006-11-21 10:57:46.000000000 +0000
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
 
-#define PG_movable		21	/* Page may be moved */
+/*
+ * As page clustering requires two flags, it was best to reuse the suspend
+ * flags and make page clustering depend on !SOFTWARE_SUSPEND. This works
+ * on the assumption that machines being suspended do not really care about
+ * large contiguous allocations.
+ */
+#ifndef CONFIG_PAGE_CLUSTERING
+#define PG_nosave		13	/* Used for system suspend/resume */
+#define PG_nosave_free		18	/* Free, should not be written */
+#else
+#define PG_reclaimable		13	/* Page is reclaimable */
+#define PG_movable		18	/* Page is movable */
+#endif
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -211,6 +221,7 @@ static inline void SetPageUptodate(struc
 		ret;							\
 	})
 
+#ifndef CONFIG_PAGE_CLUSTERING
 #define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
 #define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
 #define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
@@ -221,6 +232,33 @@ static inline void SetPageUptodate(struc
 #define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
 #define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
 
+#define PageReclaimable(page)	(0)
+#define SetPageReclaimable(page)	do {} while (0)
+#define ClearPageReclaimable(page)	do {} while (0)
+#define __SetPageReclaimable(page)	do {} while (0)
+#define __ClearPageReclaimable(page) do {} while (0)
+
+#define PageMovable(page)	(0)
+#define SetPageMovable(page)	do {} while (0)
+#define ClearPageMovable(page)	do {} while (0)
+#define __SetPageMovable(page)	do {} while (0)
+#define __ClearPageMovable(page) do {} while (0)
+
+#else
+
+#define PageReclaimable(page)	test_bit(PG_reclaimable, &(page)->flags)
+#define SetPageReclaimable(page)	set_bit(PG_reclaimable, &(page)->flags)
+#define ClearPageReclaimable(page)	clear_bit(PG_reclaimable, &(page)->flags)
+#define __SetPageReclaimable(page)	__set_bit(PG_reclaimable, &(page)->flags)
+#define __ClearPageReclaimable(page) __clear_bit(PG_reclaimable, &(page)->flags)
+
+#define PageMovable(page)	test_bit(PG_movable, &(page)->flags)
+#define SetPageMovable(page)	set_bit(PG_movable, &(page)->flags)
+#define ClearPageMovable(page)	clear_bit(PG_movable, &(page)->flags)
+#define __SetPageMovable(page)	__set_bit(PG_movable, &(page)->flags)
+#define __ClearPageMovable(page) __clear_bit(PG_movable, &(page)->flags)
+#endif /* CONFIG_PAGE_CLUSTERING */
+
 #define PageBuddy(page)		test_bit(PG_buddy, &(page)->flags)
 #define __SetPageBuddy(page)	__set_bit(PG_buddy, &(page)->flags)
 #define __ClearPageBuddy(page)	__clear_bit(PG_buddy, &(page)->flags)
@@ -254,12 +292,6 @@ static inline void SetPageUptodate(struc
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
-#define PageMovable(page)	test_bit(PG_movable, &(page)->flags)
-#define SetPageMovable(page)	set_bit(PG_movable, &(page)->flags)
-#define ClearPageMovable(page)	clear_bit(PG_movable, &(page)->flags)
-#define __SetPageMovable(page)	__set_bit(PG_movable, &(page)->flags)
-#define __ClearPageMovable(page) __clear_bit(PG_movable, &(page)->flags)
-
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/init/Kconfig linux-2.6.19-rc5-mm2-008_reclaimable/init/Kconfig
--- linux-2.6.19-rc5-mm2-007_movefree/init/Kconfig	2006-11-21 10:52:26.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/init/Kconfig	2006-11-21 10:57:46.000000000 +0000
@@ -502,6 +502,7 @@ config SLOB
 
 config PAGE_CLUSTERING
 	bool "Cluster movable pages together in the page allocator"
+	depends on !SOFTWARE_SUSPEND
 	def_bool n
 	help
 	  The standard allocator will fragment memory over time which means
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/lib/radix-tree.c linux-2.6.19-rc5-mm2-008_reclaimable/lib/radix-tree.c
--- linux-2.6.19-rc5-mm2-007_movefree/lib/radix-tree.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/lib/radix-tree.c	2006-11-21 10:57:46.000000000 +0000
@@ -93,7 +93,8 @@ radix_tree_node_alloc(struct radix_tree_
 	struct radix_tree_node *ret;
 	gfp_t gfp_mask = root_gfp_mask(root);
 
-	ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+	ret = kmem_cache_alloc(radix_tree_node_cachep,
+				set_migrateflags(gfp_mask, __GFP_RECLAIMABLE));
 	if (ret == NULL && !(gfp_mask & __GFP_WAIT)) {
 		struct radix_tree_preload *rtp;
 
@@ -137,7 +138,8 @@ int radix_tree_preload(gfp_t gfp_mask)
 	rtp = &__get_cpu_var(radix_tree_preloads);
 	while (rtp->nr < ARRAY_SIZE(rtp->nodes)) {
 		preempt_enable();
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+		node = kmem_cache_alloc(radix_tree_node_cachep,
+				set_migrateflags(gfp_mask, __GFP_RECLAIMABLE));
 		if (node == NULL)
 			goto out;
 		preempt_disable();
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/mm/page_alloc.c linux-2.6.19-rc5-mm2-008_reclaimable/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-007_movefree/mm/page_alloc.c	2006-11-21 10:56:06.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/mm/page_alloc.c	2006-11-21 10:57:46.000000000 +0000
@@ -139,12 +139,15 @@ static unsigned long __initdata dma_rese
 #ifdef CONFIG_PAGE_CLUSTERING
 static inline int get_page_migratetype(struct page *page)
 {
-	return (PageMovable(page) != 0);
+	return ((PageMovable(page) != 0) << 1) | (PageReclaimable(page) != 0);
 }
 
 static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
 {
-	return ((gfp_flags & __GFP_MOVABLE) != 0);
+	WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
+
+	return (((gfp_flags & __GFP_MOVABLE) != 0) << 1) |
+		((gfp_flags & __GFP_RECLAIMABLE) != 0);
 }
 #else
 static inline int get_page_migratetype(struct page *page)
@@ -440,6 +443,7 @@ static inline void __free_one_page(struc
 	 * will result in less bit manipulations
 	 */
 	__SetPageMovable(page);
+	__ClearPageReclaimable(page);
 
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
@@ -717,6 +721,12 @@ int move_freepages_block(struct zone *zo
 	return move_freepages(zone, start_page, end_page, migratetype);
 }
 
+static int fallbacks[MIGRATE_TYPES][MIGRATE_TYPES] = {
+	{ MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE  }, /* UNMOVABLE Fallback */
+	{ MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE  }, /* RECLAIMABLE Fallback */
+	{ MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE}  /* MOVABLE Fallback */
+};
+
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 						int start_migratetype)
@@ -724,30 +734,36 @@ static struct page *__rmqueue_fallback(s
 	struct free_area * area;
 	int current_order;
 	struct page *page;
-	int migratetype = !start_migratetype;
+	int migratetype, i;
 
 	/* Find the largest possible block of pages in the other list */
 	for (current_order = MAX_ORDER-1; current_order >= order;
 						--current_order) {
-		area = &(zone->free_area[current_order]);
-		if (list_empty(&area->free_list[migratetype]))
-			continue;
+		for (i = 0; i < MIGRATE_TYPES - 1; i++) {
+			migratetype = fallbacks[start_migratetype][i];
 
-		page = list_entry(area->free_list[migratetype].next,
-					struct page, lru);
-		area->nr_free--;
+			area = &(zone->free_area[current_order]);
+			if (list_empty(&area->free_list[migratetype]))
+				continue;
 
-		/* Remove the page from the freelists */
-		list_del(&page->lru);
-		rmv_page_order(page);
-		zone->free_pages -= 1UL << order;
-		expand(zone, page, order, current_order, area, migratetype);
+			page = list_entry(area->free_list[migratetype].next,
+					struct page, lru);
+			area->nr_free--;
 
-		/* Move free pages between lists if stealing a large block */
-		if (current_order > MAX_ORDER / 2)
-			move_freepages_block(zone, page, start_migratetype);
+			/* Remove the page from the freelists */
+			list_del(&page->lru);
+			rmv_page_order(page);
+			zone->free_pages -= 1UL << order;
+			expand(zone, page, order, current_order, area,
+							start_migratetype);
+
+			/* Move free pages between lists for large blocks */
+			if (current_order >= MAX_ORDER / 2)
+				move_freepages_block(zone, page,
+							start_migratetype);
 
-		return page;
+			return page;
+		}
 	}
 
 	return NULL;
@@ -802,9 +818,12 @@ static struct page *__rmqueue(struct zon
 	page = __rmqueue_fallback(zone, order, migratetype);
 
 got_page:
-	if (unlikely(migratetype == MIGRATE_UNMOVABLE) && page)
+	if (unlikely(migratetype != MIGRATE_MOVABLE) && page)
 		__ClearPageMovable(page);
 
+	if (migratetype == MIGRATE_RECLAIMABLE && page)
+		__SetPageReclaimable(page);
+
 	return page;
 }
 
@@ -891,7 +910,7 @@ static void __drain_pages(unsigned int c
 }
 #endif /* CONFIG_DRAIN_PERCPU_PAGES */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SOFTWARE_SUSPEND
 
 void mark_free_pages(struct zone *zone)
 {
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/mm/shmem.c linux-2.6.19-rc5-mm2-008_reclaimable/mm/shmem.c
--- linux-2.6.19-rc5-mm2-007_movefree/mm/shmem.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/mm/shmem.c	2006-11-21 10:57:46.000000000 +0000
@@ -94,7 +94,8 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
-	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+	return alloc_pages(set_migrateflags(gfp_mask, __GFP_RECLAIMABLE),
+						PAGE_CACHE_SHIFT-PAGE_SHIFT);
 }
 
 static inline void shmem_dir_free(struct page *page)
@@ -976,7 +977,9 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
+	page = alloc_page_vma(
+			set_migrateflags(gfp | __GFP_ZERO, __GFP_RECLAIMABLE),
+								&pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -996,7 +999,8 @@ shmem_swapin(struct shmem_inode_info *in
 static inline struct page *
 shmem_alloc_page(gfp_t gfp,struct shmem_inode_info *info, unsigned long idx)
 {
-	return alloc_page(gfp | __GFP_ZERO);
+	return alloc_page(
+			set_migrateflags(gfp | __GFP_ZERO, __GFP_RECLAIMABLE));
 }
 #endif
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-007_movefree/net/core/skbuff.c linux-2.6.19-rc5-mm2-008_reclaimable/net/core/skbuff.c
--- linux-2.6.19-rc5-mm2-007_movefree/net/core/skbuff.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-008_reclaimable/net/core/skbuff.c	2006-11-21 10:57:46.000000000 +0000
@@ -169,6 +169,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	u8 *data;
 
 	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
+	gfp_mask = set_migrateflags(gfp_mask, __GFP_RECLAIMABLE);
 
 	/* Get the HEAD */
 	skb = kmem_cache_alloc(cache, gfp_mask & ~__GFP_DMA);
