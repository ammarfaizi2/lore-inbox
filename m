Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280909AbRKCBF1>; Fri, 2 Nov 2001 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280907AbRKCBFI>; Fri, 2 Nov 2001 20:05:08 -0500
Received: from cogito.cam.org ([198.168.100.2]:56592 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S280906AbRKCBFE>;
	Fri, 2 Nov 2001 20:05:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix nr_pages reported by shrink_caches
Date: Fri, 2 Nov 2001 20:00:14 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011103010015.3960B817A@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The shrink_caches call in vmscan can return a bogus nr_pages due to 
the shrink_dcache_memory and friends not returning the number of 
pages they free.  This patch corrects this.

I add a kmem_cache_empty funtion and modify kmem_cache_shrink to 
return the number of pages shrunk.  I audited the kernel tree to
see if any code depended on kmem_cache_shrink returning zero and
replaced these calls with !kmem_cache_empty.

Comments?

Ed Tomlinson

---------------------------
--- linux/fs/inode.c.orig	Fri Nov  2 18:40:42 2001
+++ linux/fs/inode.c	Fri Nov  2 18:42:27 2001
@@ -724,8 +724,7 @@
 	count = inodes_stat.nr_unused / priority;
 
 	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	return kmem_cache_shrink(inode_cachep);
 }
 
 /*
--- linux/fs/dcache.c.orig	Fri Nov  2 18:40:27 2001
+++ linux/fs/dcache.c	Fri Nov  2 18:41:52 2001
@@ -568,8 +568,7 @@
 	count = dentry_stat.nr_unused / priority;
 
 	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	return kmem_cache_shrink(dentry_cache);
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
--- linux/fs/dquot.c.orig	Fri Nov  2 18:41:12 2001
+++ linux/fs/dquot.c	Fri Nov  2 18:43:11 2001
@@ -429,8 +429,7 @@
 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
 	prune_dqcache(nr_free_dquots / (priority + 1));
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return kmem_cache_shrink(dquot_cachep);
 }
 
 /* NOTE: If you change this function please check whether dqput_blocks() works right... */
--- linux/include/linux/slab.h.orig	Fri Nov  2 18:45:25 2001
+++ linux/include/linux/slab.h	Fri Nov  2 18:46:08 2001
@@ -54,6 +54,7 @@
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+extern int kmem_cache_empty(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
--- linux/mm/slab.c.orig	Fri Nov  2 18:48:11 2001
+++ linux/mm/slab.c	Fri Nov  2 19:16:14 2001
@@ -912,7 +912,7 @@
 static int __kmem_cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
-	int ret;
+	int ret = 0;
 
 	drain_cpu_caches(cachep);
 
@@ -936,8 +936,19 @@
 		spin_unlock_irq(&cachep->spinlock);
 		kmem_slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
+		ret += 1;
 	}
-	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
+	spin_unlock_irq(&cachep->spinlock);
+	return ret<<(cachep->gfporder);
+}
+
+int kmem_cache_empty(kmem_cache_t *cachep)
+{
+	slab_t *slabp;
+	int ret;
+
+	spin_lock_irq(&cachep->spinlock);
+	ret = list_empty(&cachep->slabs_full) && list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
@@ -947,7 +958,7 @@
  * @cachep: The cache to shrink.
  *
  * Releases as many slabs as possible for a cache.
- * To help debugging, a zero exit status indicates all slabs were released.
+ * To aid the vm the number of pages released is returned.
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
@@ -986,7 +997,8 @@
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
 
-	if (__kmem_cache_shrink(cachep)) {
+	__kmem_cache_shrink(cachep);
+	if (!kmem_cache_empty(cachep)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
 		       cachep);
 		down(&cache_chain_sem);
--- linux/mm/vmscan.c.orig	Fri Nov  2 18:58:25 2001
+++ linux/mm/vmscan.c	Fri Nov  2 19:00:04 2001
@@ -564,11 +564,13 @@
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
+	if (nr_pages <= 0)
+		return 0;
 
 	return nr_pages;
 }
--- linux/drivers/s390/ccwcache.c.orig	Fri Nov  2 19:02:54 2001
+++ linux/drivers/s390/ccwcache.c	Fri Nov  2 19:03:57 2001
@@ -291,7 +291,8 @@
 	/* Shrink the caches, if available */
 	for ( cachind = 0; cachind < CCW_NUMBER_CACHES; cachind ++ ) {
 		if ( ccw_cache[cachind] ) {
-			if ( kmem_cache_shrink(ccw_cache[cachind]) == 0 ) {
+			kmem_cache_shrink(ccw_cache[cachind]);
+			if ( kmem_cache_empty(ccw_cache[cachind]) ) {
 				ccw_cache[cachind] = NULL;
 			}
 			kmem_cache_destroy(ccw_cache[cachind]);
---------------------
