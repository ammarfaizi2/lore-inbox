Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292313AbSBBQTd>; Sat, 2 Feb 2002 11:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292314AbSBBQTY>; Sat, 2 Feb 2002 11:19:24 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:34944 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292313AbSBBQTP>; Sat, 2 Feb 2002 11:19:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] improved free page accounting 
Date: Sat, 2 Feb 2002 11:19:12 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202161912.D41D615CF1@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch improves the free page accounting.  It does 
this by creating variants of the shrink functions used by the
inode, dentry, dquota caches that return the number of pages 
they free.  Current interfaces are not modified.  A variant
of this code is in the rmap patch and was reduced the number 
of false oom triggers.

I have been running versions of this since 2.4.14.

Patch is against 2.4.17pre7

Comments,
Ed Tomlinson

--- linux/fs/inode.c.orig	Sat Jan  5 17:35:17 2002
+++ linux/fs/inode.c	Sat Jan  5 17:36:06 2002
@@ -725,8 +725,7 @@
 	count = inodes_stat.nr_unused / priority;
 
 	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	return kmem_cache_shrink_nr(inode_cachep);
 }
 
 /*
--- linux/fs/dcache.c.orig	Sat Jan  5 17:37:02 2002
+++ linux/fs/dcache.c	Sat Jan  5 17:37:57 2002
@@ -568,8 +568,7 @@
 	count = dentry_stat.nr_unused / priority;
 
 	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	return kmem_cache_shrink_nr(dentry_cache);
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
--- linux/fs/dquot.c.orig	Sat Jan  5 17:38:21 2002
+++ linux/fs/dquot.c	Sat Jan  5 17:38:57 2002
@@ -413,8 +413,7 @@
 	lock_kernel();
 	prune_dqcache(nr_free_dquots / (priority + 1));
 	unlock_kernel();
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return kmem_cache_shrink_nr(dquot_cachep);
 }
 
 /* NOTE: If you change this function please check whether dqput_blocks() works right... */
--- linux/include/linux/slab.h.orig	Sat Jan  5 17:27:13 2002
+++ linux/include/linux/slab.h	Sat Jan  5 17:27:49 2002
@@ -55,6 +55,7 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+extern int kmem_cache_shrink_nr(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
--- linux/mm/slab.c.orig	Sat Jan  5 15:06:40 2002
+++ linux/mm/slab.c	Sat Jan  5 18:54:40 2002
@@ -911,34 +911,45 @@
 #define drain_cpu_caches(cachep)	do { } while (0)
 #endif
 
+/**
+ * Called with the &cachep->spinlock held, returns number of slabs released
+ */
+static int __kmem_cache_shrink_locked(kmem_cache_t *cachep)
+{
+        slab_t *slabp;
+        int ret = 0;
+
+        /* If the cache is growing, stop shrinking. */
+        while (!cachep->growing) {
+                struct list_head *p;
+
+                p = cachep->slabs_free.prev;
+                if (p == &cachep->slabs_free)
+                        break;
+
+                slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
+#if DEBUG
+                if (slabp->inuse)
+                        BUG();
+#endif
+                list_del(&slabp->list);
+
+                spin_unlock_irq(&cachep->spinlock);
+                kmem_slab_destroy(cachep, slabp);
+		ret++;
+                spin_lock_irq(&cachep->spinlock);
+        }
+        return ret;
+}
+
 static int __kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	slab_t *slabp;
 	int ret;
 
 	drain_cpu_caches(cachep);
 
 	spin_lock_irq(&cachep->spinlock);
-
-	/* If the cache is growing, stop shrinking. */
-	while (!cachep->growing) {
-		struct list_head *p;
-
-		p = cachep->slabs_free.prev;
-		if (p == &cachep->slabs_free)
-			break;
-
-		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
-		list_del(&slabp->list);
-
-		spin_unlock_irq(&cachep->spinlock);
-		kmem_slab_destroy(cachep, slabp);
-		spin_lock_irq(&cachep->spinlock);
-	}
+	__kmem_cache_shrink_locked(cachep);
 	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
@@ -957,6 +968,24 @@
 		BUG();
 
 	return __kmem_cache_shrink(cachep);
+}
+
+/**
+ * kmem_cache_shrink_nr - Shrink a cache returning pages released
+ */
+int kmem_cache_shrink_nr(kmem_cache_t *cachep)
+{
+        int ret;
+
+        if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
+                BUG();
+
+	drain_cpu_caches(cachep);
+
+	spin_lock_irq(&cachep->spinlock);
+	ret = __kmem_cache_shrink_locked(cachep);
+	spin_unlock_irq(&cachep->spinlock);
+	return ret<<(cachep->gfporder);
 }
 
 /**
--- linux/mm/vmscan.c.orig	Sun Jan 13 08:47:58 2002
+++ linux/mm/vmscan.c	Sun Jan 13 08:48:27 2002
@@ -567,7 +567,6 @@
 	if (nr_pages <= 0)
 		return 0;
 
-	nr_pages = chunk_size;
 	/* try to keep the active list 2/3 of the size of the cache */
 	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
 	refill_inactive(ratio);
@@ -576,13 +575,13 @@
 	if (nr_pages <= 0)
 		return 0;
 
-	shrink_dcache_memory(priority, gfp_mask);
-	shrink_icache_memory(priority, gfp_mask);
+	nr_pages -= shrink_dcache_memory(priority, gfp_mask);
+	nr_pages -= shrink_icache_memory(priority, gfp_mask);
 #ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
+	nr_pages -= shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif
 
-	return nr_pages;
+	return (nr_pages<=0 ? 0 : nr_pages);
 }
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
