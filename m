Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbSIZLfl>; Thu, 26 Sep 2002 07:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262503AbSIZLfl>; Thu, 26 Sep 2002 07:35:41 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:47522 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262502AbSIZLfg>; Thu, 26 Sep 2002 07:35:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 3/4] slab reclaim balancing
Date: Thu, 26 Sep 2002 07:39:13 -0400
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D928854.F76986EF@digeo.com>
In-Reply-To: <3D928854.F76986EF@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209260739.13464.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2002 12:08 am, Andrew Morton wrote:
> A patch from Ed Tomlinson which improves the way in which the kernel
> reclaims slab objects.

Thanks Andrew.

Does this looks any better than the last version?   I have moved the shrinking
calls to vmscan from slab.   The idea being that this really vm related, not
necessarily linked directly to any one cache, so why should it be in slab?  This
eliminated an export too...

As it stands now I have not implimented a delete function.   It would be pretty
simple to do so though and may well be needed later.  

Thoughts?
Ed

-------- against 38-mm2
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.549   -> 1.554  
#	  include/linux/mm.h	1.81    -> 1.83   
#	         fs/dcache.c	1.30    -> 1.32   
#	         mm/vmscan.c	1.107   -> 1.111  
#	include/linux/slab.h	1.13    -> 1.16   
#	          fs/dquot.c	1.45    -> 1.47   
#	           mm/slab.c	1.28    -> 1.31   
#	          fs/inode.c	1.69    -> 1.71   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/18	ed@oscar.et.ca	1.550
# slab_callbacks_A2
# --------------------------------------------
# 02/09/18	ed@oscar.et.ca	1.551
# convert ageable slab shrinking to use callbacks.
# --------------------------------------------
# 02/09/19	ed@oscar.et.ca	1.552
# move the shrink functions to vmscan which is where the really do belong
# --------------------------------------------
# 02/09/20	ed@oscar.et.ca	1.553
# small improvements
# --------------------------------------------
# 02/09/20	ed@oscar.et.ca	1.554
# cleanup
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Sep 20 10:35:51 2002
+++ b/fs/dcache.c	Fri Sep 20 10:35:51 2002
@@ -570,9 +570,10 @@
  * This is called from kswapd when we think we need some
  * more memory. 
  */
-int shrink_dcache_memory(int ratio, unsigned int gfp_mask)
+int shrink_dcache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = dentry_stat.nr_dentry / ratio + 1;
+	if (!nr)
+		return dentry_stat.nr_dentry;
 	/*
 	 * Nasty deadlock avoidance.
 	 *
@@ -585,10 +586,10 @@
 	 * block allocations, but for now:
 	 */
 	if (!(gfp_mask & __GFP_FS))
-		return 0;
+		return nr;
 
-	prune_dcache(entries);
-	return entries;
+	prune_dcache(nr);
+	return 0;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -1328,6 +1329,8 @@
 					 NULL, NULL);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
+	
+	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
@@ -1401,6 +1404,8 @@
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
+
+	set_shrinker(DEFAULT_SEEKS, shrink_dquot_memory);
 #endif
 
 	dcache_init(mempages);
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Fri Sep 20 10:35:51 2002
+++ b/fs/dquot.c	Fri Sep 20 10:35:51 2002
@@ -55,6 +55,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -483,14 +484,15 @@
  * more memory
  */
 
-int shrink_dqcache_memory(int ratio, unsigned int gfp_mask)
+int shrink_dqcache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = dqstats.allocated_dquots / ratio + 1;
+	if (!nr)
+		return dqstats.allocated_dquots;
 
 	lock_kernel();
-	prune_dqcache(entries);
+	prune_dqcache(nr);
 	unlock_kernel();
-	return entries;
+	return 0;
 }
 
 /*
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Sep 20 10:35:51 2002
+++ b/fs/inode.c	Fri Sep 20 10:35:51 2002
@@ -419,9 +419,10 @@
  * This is called from kswapd when we think we need some
  * more memory. 
  */
-int shrink_icache_memory(int ratio, unsigned int gfp_mask)
+int shrink_icache_memory(int nr, unsigned int gfp_mask)
 {
-	int entries = inodes_stat.nr_inodes / ratio + 1;
+	if (!nr)
+		return inodes_stat.nr_inodes;
 	/*
 	 * Nasty deadlock avoidance..
 	 *
@@ -430,10 +431,10 @@
 	 * in clear_inode() and friends..
 	 */
 	if (!(gfp_mask & __GFP_FS))
-		return 0;
+		return nr;
 
-	prune_icache(entries);
-	return entries;
+	prune_icache(nr);
+	return 0;
 }
 EXPORT_SYMBOL(shrink_icache_memory);
 
@@ -1098,4 +1099,6 @@
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
+
+	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 }
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Sep 20 10:35:51 2002
+++ b/include/linux/mm.h	Fri Sep 20 10:35:51 2002
@@ -395,6 +395,30 @@
 
 
 /*
+ * Prototype to add a shrinker callback for ageable caches.
+ * 
+ * These functions are passed a count and a gfpmask.  They should
+ * return one of three results.
+ *
+ * when nr = 0 return number of entries in the cache(s)
+ * when nr > 0 and we can age return 0 
+ * when nr > 0 and we cannot age return nr 
+ *
+ * if the cache(s) 'disappears' passing nr = 0 must return 0
+ */
+typedef int (*shrinker_t)(int, unsigned int);
+
+/*
+ * Add an aging callback.  The int is the number of 'seeks' it takes
+ * to recreate one of the objects that these functions age.
+ */
+
+#define DEFAULT_SEEKS 2
+
+extern void set_shrinker(int, shrinker_t);
+
+
+/*
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
  * FIXME: make the method unconditional.
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Sep 20 10:35:51 2002
+++ b/mm/vmscan.c	Fri Sep 20 10:35:51 2002
@@ -73,10 +73,36 @@
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
-#ifndef CONFIG_QUOTA
-#define shrink_dqcache_memory(ratio, gfp_mask) do { } while (0)
-#endif
+/*
+ * The list of shrinker callbacks used by to apply pressure to
+ * ageable caches.
+ */
+struct shrinker_s {
+	shrinker_t		shrinker;
+	struct list_head	next;
+	int			seeks;	/* seeks to recreate an obj */
+	int			nr;	/* objs pending delete */
+};
+
+static LIST_HEAD(shrinker_list);
+static spinlock_t shrinker_lock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * Add a shrinker to be called from the vm
+ */
+void set_shrinker(int seeks, shrinker_t theshrinker)
+{
+        struct shrinker_s *shrinkerp;
+        shrinkerp = kmalloc(sizeof(struct shrinker_s),GFP_KERNEL);
+        BUG_ON(!shrinkerp);
+        shrinkerp->shrinker = theshrinker;
+        shrinkerp->seeks = seeks;
+        shrinkerp->nr = 0;
+        spin_lock(&shrinker_lock);
+        list_add(&shrinkerp->next, &shrinker_list);
+        spin_unlock(&shrinker_lock);
+}
+ 
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
@@ -572,32 +598,6 @@
 }
 
 /*
- * FIXME: don't do this for ZONE_HIGHMEM
- */
-/*
- * Here we assume it costs one seek to replace a lru page and that it also
- * takes a seek to recreate a cache object.  With this in mind we age equal
- * percentages of the lru and ageable caches.  This should balance the seeks
- * generated by these structures.
- *
- * NOTE: for now I do this for all zones.  If we find this is too aggressive
- * on large boxes we may want to exclude ZONE_HIGHMEM.
- *
- * If we're encountering mapped pages on the LRU then increase the pressure on
- * slab to avoid swapping.
- */
-static void shrink_slab(int total_scanned, int gfp_mask)
-{
-	int shrink_ratio;
-	int pages = nr_used_zone_pages();
-
-	shrink_ratio = (pages / (total_scanned + 1)) + 1;
-	shrink_dcache_memory(shrink_ratio, gfp_mask);
-	shrink_icache_memory(shrink_ratio, gfp_mask);
-	shrink_dqcache_memory(shrink_ratio, gfp_mask);
-}
-
-/*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
  * request.
@@ -638,6 +638,45 @@
 			break;
 	}
 	return ret;
+}
+ 
+
+#define SHRINK_BATCH 32
+/*
+ * Call the shrink functions to age shrinkable caches
+ *
+ * Here we assume it costs one seek to replace a lru page and that it also
+ * takes a seek to recreate a cache object.  With this in mind we age equal
+ * percentages of the lru and ageable caches.  This should balance the seeks
+ * generated by these structures.
+ *
+ * If the vm encounted mapped pages on the LRU it increase the pressure on
+ * slab to avoid swapping.
+ *
+ * FIXME: do not do for zone highmem
+ */
+int
+shrink_slab(int scanned,  unsigned int gfp_mask)
+{
+	struct list_head *p, *n;
+	int pages = nr_used_zone_pages();
+
+	spin_lock(&shrinker_lock);
+	list_for_each_safe(p, n, &shrinker_list) {
+		struct shrinker_s *shrinkerp = list_entry(p, struct shrinker_s, next);
+		int entries = (*shrinkerp->shrinker)(0, gfp_mask);
+		if (!entries)
+			continue;
+		shrinkerp->nr += ((unsigned long)scanned*shrinkerp->seeks*entries) / pages + 1;
+		if (shrinkerp->nr > SHRINK_BATCH) {
+			spin_unlock(&shrinker_lock);
+			shrinkerp->nr = (*shrinkerp->shrinker)(shrinkerp->nr, gfp_mask);
+			spin_lock(&shrinker_lock);
+		}
+	}
+	spin_unlock(&shrinker_lock);
+
+	return 0;
 }
 
 /*

--------

