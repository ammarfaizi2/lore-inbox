Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSGCP7o>; Wed, 3 Jul 2002 11:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSGCP7n>; Wed, 3 Jul 2002 11:59:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46854 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317059AbSGCP7k>;
	Wed, 3 Jul 2002 11:59:40 -0400
Date: Wed, 3 Jul 2002 17:02:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use list_* functions better in dcache.c
Message-ID: <20020703170211.N27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes how dentry_unused is managed.  It used to be that it
was walked in reverse order, but there's no convenient list macro to do
that safely.  So I changed it to walk forwards.  I've also included a
few list_move / list_move_tail macros, where they made sense.

shrink_dcache_sb had different behavior to prune_dcache -- it ignored
dentries on the dentry_unused with an active d_count, whereas prune_dcache
did a BUG().  shrink_dcache_sb now does a BUG() too on the basis that
prune_dcache would get to that dentry at some point too.  It also doesn't
seem necessary to make two passes over this list any more.

Comments?

--- linux-2.5.24/fs/dcache.c	Thu Jun 20 16:53:45 2002
+++ linux-2.5.24-flock/fs/dcache.c	Wed Jul  3 09:46:16 2002
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
 #include <linux/module.h>
+#include <linux/compiler.h>
 
 #include <asm/uaccess.h>
 
@@ -48,6 +49,14 @@ static kmem_cache_t *dentry_cache; 
 static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
 static struct list_head *dentry_hashtable;
+
+/*
+ * dentry_unused is a double ended queue.  prune_dcache walks the list
+ * forwards, removing items from it as it deletes them.  other functions add
+ * to the head if they want their dentries deleted early (eg shrink_*)
+ * and to the tail if they want them deleted late (eg dput).  It's
+ * protected by the dcache_lock.
+ */
 static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
@@ -135,7 +144,7 @@ repeat:
 	/* Unreachable? Get rid of it */
 	if (list_empty(&dentry->d_hash))
 		goto kill_it;
-	list_add(&dentry->d_lru, &dentry_unused);
+	list_add_tail(&dentry->d_lru, &dentry_unused);
 	dentry_stat.nr_unused++;
 	spin_unlock(&dcache_lock);
 	return;
@@ -327,24 +336,22 @@ static inline void prune_one_dentry(stru
  
 void prune_dcache(int count)
 {
+	struct list_head *entry, *next;
 	spin_lock(&dcache_lock);
-	for (;;) {
-		struct dentry *dentry;
-		struct list_head *tmp;
-
-		tmp = dentry_unused.prev;
-
-		if (tmp == &dentry_unused)
-			break;
-		list_del_init(tmp);
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	list_for_each_safe(entry, next, &dentry_unused) {
+		struct dentry *dentry = list_entry(entry, struct dentry, d_lru);
 
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
-			list_add(&dentry->d_lru, &dentry_unused);
-			continue;
+			if (likely(entry->next != &dentry_unused)) {
+				list_move_tail(&dentry->d_lru, &dentry_unused);
+				continue;
+			}
 		}
+
+		list_del_init(entry);
+
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
@@ -382,42 +389,18 @@ void prune_dcache(int count)
 
 void shrink_dcache_sb(struct super_block * sb)
 {
-	struct list_head *tmp, *next;
-	struct dentry *dentry;
-
-	/*
-	 * Pass one ... move the dentries for the specified
-	 * superblock to the most recent end of the unused list.
-	 */
-	spin_lock(&dcache_lock);
-	next = dentry_unused.next;
-	while (next != &dentry_unused) {
-		tmp = next;
-		next = tmp->next;
-		dentry = list_entry(tmp, struct dentry, d_lru);
-		if (dentry->d_sb != sb)
-			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
-	}
-
-	/*
-	 * Pass two ... free the dentries for this superblock.
-	 */
-repeat:
-	next = dentry_unused.next;
-	while (next != &dentry_unused) {
-		tmp = next;
-		next = tmp->next;
-		dentry = list_entry(tmp, struct dentry, d_lru);
+	struct list_head *entry, *next;
+	
+	list_for_each_safe(entry, next, &dentry_unused) {
+		struct dentry *dentry = list_entry(entry, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
+		/* Unused dentry with a count? */
 		if (atomic_read(&dentry->d_count))
-			continue;
+			BUG();
 		dentry_stat.nr_unused--;
-		list_del_init(tmp);
+		list_del_init(entry);
 		prune_one_dentry(dentry);
-		goto repeat;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -476,8 +459,8 @@ positive:
 
 /*
  * Search the dentry child list for the specified parent,
- * and move any unused dentries to the end of the unused
- * list for prune_dcache(). We descend to the next level
+ * and move any unused dentries to where prune_dcache()
+ * will find them first. We descend to the next level
  * whenever the d_subdirs list is non-empty and continue
  * searching.
  */
@@ -496,8 +479,7 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 		if (!atomic_read(&dentry->d_count)) {
-			list_del(&dentry->d_lru);
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_move(&dentry->d_lru, &dentry_unused);
 			found++;
 		}
 		/*
@@ -560,8 +542,7 @@ void shrink_dcache_anon(struct list_head
 		list_for_each(lp, head) {
 			struct dentry *this = list_entry(lp, struct dentry, d_hash);
 			if (!atomic_read(&this->d_count)) {
-				list_del(&this->d_lru);
-				list_add_tail(&this->d_lru, &dentry_unused);
+				list_move(&this->d_lru, &dentry_unused);
 				found++;
 			}
 		}

-- 
Revolutions do not require corporate support.
