Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbSJOEkr>; Tue, 15 Oct 2002 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJOEkr>; Tue, 15 Oct 2002 00:40:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:51148 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262355AbSJOEkp>;
	Tue, 15 Oct 2002 00:40:45 -0400
Message-ID: <3DAB9DA5.42008138@digeo.com>
Date: Mon, 14 Oct 2002 21:46:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
References: <E181IS8-0001DQ-00@snap.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 04:46:29.0513 (UTC) FILETIME=[D3B24790:01C27405]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 
>...
> This first patch creates a generic interface for registering caches with
> the VM subsystem so that they can react appropriately to memory
> pressure.
> 

Seems our patches passed in the night - Linus already has one of
those APIs.

I've converted xattr to use the set_shrinker/remove_shrinker API.
I'd appreciate it if you could pass an eye over that and give it
a test.  I'll roll it into 2.5.42-mm3 if that makes it easier.

btw, gcc-2.91.66 is saying:

fs/ext2/xattr.c: In function `ext2_xattr_set':
fs/ext2/xattr.c:612: warning: `block' might be used uninitialized in this function

But the code is:

                int block = EXT2_I(inode)->i_file_acl;

which is rather bizarre.  Never seen it do that before.

The patching order becomes:

xattr 2/4
xattr-shrinker
xattr 3/4
xattr 4/4


 fs/mbcache.c |   57 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

--- 2.5.42/fs/mbcache.c~xattr-shrinker	Mon Oct 14 21:17:59 2002
+++ 2.5.42-akpm/fs/mbcache.c	Mon Oct 14 21:30:25 2002
@@ -29,9 +29,9 @@
 #include <linux/module.h>
 
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/cache_def.h>
 #include <linux/version.h>
 #include <linux/init.h>
 #include <linux/mbcache.h>
@@ -85,6 +85,7 @@ EXPORT_SYMBOL(mb_cache_entry_find_next);
 static LIST_HEAD(mb_cache_list);
 static LIST_HEAD(mb_cache_lru_list);
 static spinlock_t mb_cache_spinlock = SPIN_LOCK_UNLOCKED;
+static struct shrinker *mb_shrinker;
 
 static inline void
 mb_cache_lock(void)
@@ -112,14 +113,7 @@ mb_cache_indexes(struct mb_cache *cache)
  * What the mbcache registers as to get shrunk dynamically.
  */
 
-static void
-mb_cache_memory_pressure(int priority, unsigned int gfp_mask);
-
-static struct cache_definition mb_cache_definition = {
-	"mb_cache",
-	mb_cache_memory_pressure
-};
-
+static int mb_cache_shrink_fn(int nr_to_scan, unsigned int gfp_mask);
 
 static inline void
 __mb_cache_entry_takeout_lru(struct mb_cache_entry *ce)
@@ -226,16 +220,18 @@ __mb_cache_entry_release_unlock(struct m
 
 
 /*
- * mb_cache_memory_pressure()  memory pressure callback
+ * mb_cache_shrink_fn()  memory pressure callback
  *
  * This function is called by the kernel memory management when memory
  * gets low.
  *
- * @priority: Amount by which to shrink the cache (0 = highes priority)
+ * @nr_to_scan: Number of objects to scan
  * @gfp_mask: (ignored)
+ *
+ * Returns the number of objects which are present in the cache.
  */
-static void
-mb_cache_memory_pressure(int priority, unsigned int gfp_mask)
+static int
+mb_cache_shrink_fn(int nr_to_scan, unsigned int gfp_mask)
 {
 	LIST_HEAD(free_list);
 	struct list_head *l;
@@ -249,11 +245,12 @@ mb_cache_memory_pressure(int priority, u
 			  atomic_read(&cache->c_entry_count));
 		count += atomic_read(&cache->c_entry_count);
 	}
-	mb_debug("trying to free %d of %d entries",
-		  count / (priority ? priority : 1), count);
-	if (priority)
-		count /= priority;
-	while (count && !list_empty(&mb_cache_lru_list)) {
+	mb_debug("trying to free %d entries", nr_to_scan);
+	if (nr_to_scan == 0) {
+		mb_cache_unlock();
+		goto out;
+	}
+	while (nr_to_scan && !list_empty(&mb_cache_lru_list)) {
 		struct mb_cache_entry *ce =
 			list_entry(mb_cache_lru_list.prev,
 				   struct mb_cache_entry, e_lru_list);
@@ -261,7 +258,7 @@ mb_cache_memory_pressure(int priority, u
 		list_add(&ce->e_lru_list, &free_list);
 		if (__mb_cache_entry_is_linked(ce))
 			__mb_cache_entry_unlink(ce);
-		count--;
+		nr_to_scan--;
 	}
 	mb_cache_unlock();
 	l = free_list.prev;
@@ -270,9 +267,11 @@ mb_cache_memory_pressure(int priority, u
 			struct mb_cache_entry, e_lru_list);
 		l = l->prev;
 		__mb_cache_entry_forget(ce);
+		count--;
 	}
-	if (count)
-		mb_debug("%d fewer entries freed", count);
+out:
+	mb_debug("%d remaining entries ", count);
+	return count;
 }
 
 
@@ -342,8 +341,14 @@ mb_cache_create(const char *name, struct
 		goto fail;
 
 	mb_cache_lock();
-	if (list_empty(&mb_cache_list))
-		register_cache(&mb_cache_definition);
+	if (list_empty(&mb_cache_list)) {
+		if (mb_shrinker) {
+			printk(KERN_ERR "%s: already have a shrinker!\n",
+					__FUNCTION__);
+			remove_shrinker(mb_shrinker);
+		}
+		mb_shrinker = set_shrinker(DEFAULT_SEEKS, mb_cache_shrink_fn);
+	}
 	list_add(&cache->c_cache_list, &mb_cache_list);
 	mb_cache_unlock();
 	return cache;
@@ -429,8 +434,10 @@ mb_cache_destroy(struct mb_cache *cache)
 		}
 	}
 	list_del(&cache->c_cache_list);
-	if (list_empty(&mb_cache_list))
-		unregister_cache(&mb_cache_definition);
+	if (list_empty(&mb_cache_list) && mb_shrinker) {
+		remove_shrinker(mb_shrinker);
+		mb_shrinker = 0;
+	}
 	mb_cache_unlock();
 
 	l = free_list.prev;

.
