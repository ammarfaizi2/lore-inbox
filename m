Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUIELcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUIELcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIELcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:32:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:19205 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266357AbUIELaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:30:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: rewrite the cache for file allocation table lookup
 (2/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 20:30:16 +0900
Message-ID: <878ybpvtpz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the cache stuff for file allocation table (FAT).

This cache stocks the more pieces of FAT-chain by counting the number
of contiguous data blocks. And if cache hit, since a block number can
calculate without looking FAT-chain up, fat_get_block() become more
fast.

But if data blocks was fragmenting, unfortunately this cache is unuseful.

read from block device

[1st]# time dd if=/dev/hda6 of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 229.524189 seconds (9356241 bytes/sec)
real    3m49.557s, user    0m0.026s, sys     1m20.414s
[2nd]# time dd if=/dev/hda6 of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 229.539358 seconds (9355623 bytes/sec)
real    3m49.647s, user    0m0.036s, sys     1m20.144s

read from full contiguous file with this patch

[1st]# time dd if=data of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 337.959477 seconds (6354264 bytes/sec)
real    5m37.970s, user    0m0.031s, sys     1m21.915s
[2nd]# time dd if=data of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 225.401699 seconds (9527362 bytes/sec)
real    3m45.476s, user    0m0.027s, sys     1m19.286s

read from full fragmented file with this patch

[1st]# time dd if=data of=/dev/null bs=1M count=2048
2147483647 bytes transferred in 1146.529081 seconds (1873030 bytes/sec)
real    19m6.538s, user    0m0.020s, sys     1m32.774s
[2nd]# time dd if=data of=/dev/null bs=1M count=2048
2147483647 bytes transferred in 1045.084822 seconds (2054841 bytes/sec)
real    17m25.152s, user    0m0.022s, sys     1m34.801s

read from full contiguous file without this patch

[1st]# time dd if=data of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 348.144707 seconds (6168365 bytes/sec)
real    5m48.169s, user    0m0.019s, sys     1m29.962s
[2nd]# time dd if=data of=/dev/null bs=1M count=2048
2147483648 bytes transferred in 324.017361 seconds (6627681 bytes/sec)
real    5m24.038s, user    0m0.023s, sys     1m20.602s

read from full fragmented file without this patch

[1st]# time dd if=data of=/dev/null bs=1M count=2048
2147483647 bytes transferred in 1156.845693 seconds (1856327 bytes/sec)
real    19m16.855s, user    0m0.031s, sys     1m32.172s
[2nd]# time dd if=data of=/dev/null bs=1M count=2048
2147483647 bytes transferred in 1066.518713 seconds (2013545 bytes/sec)
real    17m46.526s, user    0m0.023s, sys     1m33.630s

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c              |  370 +++++++++++++++++++++++++-------------------
 fs/fat/fatfs_syms.c         |    7 
 fs/fat/inode.c              |    6 
 fs/fat/misc.c               |    2 
 include/linux/msdos_fs.h    |    2 
 include/linux/msdos_fs_i.h  |    5 
 include/linux/msdos_fs_sb.h |   10 -
 7 files changed, 226 insertions(+), 176 deletions(-)

diff -puN fs/fat/cache.c~fat_new-cache fs/fat/cache.c
--- linux-2.6.9-rc1/fs/fat/cache.c~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/cache.c	2004-09-05 18:49:00.000000000 +0900
@@ -12,6 +12,204 @@
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
 
+#if 0
+#define debug_pr(fmt, args...)	printk(fmt, ##args)
+#else
+#define debug_pr(fmt, args...)
+#endif
+
+/* this must be > 0. */
+#define FAT_MAX_CACHE	8
+
+struct fat_cache {
+	struct list_head cache_list;
+	int nr_contig;	/* number of contiguous clusters */
+	int fcluster;	/* cluster number in the file. */
+	int dcluster;	/* cluster number on disk. */
+};
+
+static inline int fat_max_cache(struct inode *inode)
+{
+	return FAT_MAX_CACHE;
+}
+
+static kmem_cache_t *fat_cache_cachep;
+
+static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct fat_cache *cache = (struct fat_cache *)foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		INIT_LIST_HEAD(&cache->cache_list);
+}
+
+int __init fat_cache_init(void)
+{
+	fat_cache_cachep = kmem_cache_create("fat_cache",
+				sizeof(struct fat_cache),
+				0, SLAB_RECLAIM_ACCOUNT,
+				init_once, NULL);
+	if (fat_cache_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+void __exit fat_cache_destroy(void)
+{
+	if (kmem_cache_destroy(fat_cache_cachep))
+		printk(KERN_INFO "fat_cache: not all structures were freed\n");
+}
+
+static inline struct fat_cache *fat_cache_alloc(struct inode *inode)
+{
+	return kmem_cache_alloc(fat_cache_cachep, SLAB_KERNEL);
+}
+
+static inline void fat_cache_free(struct fat_cache *cache)
+{
+	BUG_ON(!list_empty(&cache->cache_list));
+	kmem_cache_free(fat_cache_cachep, cache);
+}
+
+static inline void fat_cache_update_lru(struct inode *inode,
+					struct fat_cache *cache)
+{
+	if (MSDOS_I(inode)->cache_lru.next != &cache->cache_list)
+		list_move(&cache->cache_list, &MSDOS_I(inode)->cache_lru);
+}
+
+static int fat_cache_lookup(struct inode *inode, int fclus,
+			    struct fat_cache *cache,
+			    int *cached_fclus, int *cached_dclus)
+{
+	static struct fat_cache nohit = { .fcluster = 0, };
+
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct fat_cache *hit = &nohit, *p;
+	int offset = -1;
+
+	spin_lock(&sbi->cache_lock);
+	debug_pr("FAT: %s, fclus %d", __FUNCTION__, fclus);
+	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+		if (p->fcluster <= fclus && hit->fcluster < p->fcluster) {
+			hit = p;
+			debug_pr(", fclus %d, dclus %d, cont %d",
+				 p->fcluster, p->dcluster, p->nr_contig);
+			if ((hit->fcluster + hit->nr_contig) < fclus) {
+				offset = hit->nr_contig;
+				debug_pr(" (off %d, hit)", offset);
+			} else {
+				offset = fclus - hit->fcluster;
+				debug_pr(" (off %d, full hit)", offset);
+				break;
+			}
+		}
+	}
+	if (hit != &nohit) {
+		fat_cache_update_lru(inode, hit);
+		*cache = *hit;
+		*cached_fclus = cache->fcluster + offset;
+		*cached_dclus = cache->dcluster + offset;
+	}
+	debug_pr("\n");
+	spin_unlock(&sbi->cache_lock);
+
+	return offset;
+}
+
+static struct fat_cache *fat_cache_merge(struct inode *inode,
+					 struct fat_cache *new)
+{
+	struct fat_cache *p, *hit = NULL;
+
+	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
+		if (p->fcluster == new->fcluster) {
+			BUG_ON(p->dcluster != new->dcluster);
+			debug_pr("FAT: %s: merged fclus %d, dclus %d, "
+				 "cur cont %d => new cont %d\n", __FUNCTION__,
+				 p->fcluster, p->dcluster, p->nr_contig,
+				 new->nr_contig);
+			if (new->nr_contig > p->nr_contig)
+				p->nr_contig = new->nr_contig;
+			hit = p;
+			break;
+		}
+	}
+	return hit;
+}
+
+static void fat_cache_add(struct inode *inode, struct fat_cache *new)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct fat_cache *cache, *tmp;
+
+	debug_pr("FAT: %s: fclus %d, dclus %d, cont %d\n", __FUNCTION__,
+		 new->fcluster, new->dcluster, new->nr_contig);
+
+	if (new->fcluster == -1) /* dummy cache */
+		return;
+
+	spin_lock(&sbi->cache_lock);
+	cache = fat_cache_merge(inode, new);
+	if (cache == NULL) {
+		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
+			MSDOS_I(inode)->nr_caches++;
+			spin_unlock(&sbi->cache_lock);
+
+			tmp = fat_cache_alloc(inode);
+			spin_lock(&sbi->cache_lock);
+			cache = fat_cache_merge(inode, new);
+			if (cache != NULL) {
+				MSDOS_I(inode)->nr_caches--;
+				fat_cache_free(tmp);
+				goto out;
+			}
+			cache = tmp;
+		} else {
+			struct list_head *p = MSDOS_I(inode)->cache_lru.prev;
+			cache = list_entry(p, struct fat_cache, cache_list);
+		}
+		cache->fcluster = new->fcluster;
+		cache->dcluster = new->dcluster;
+		cache->nr_contig = new->nr_contig;
+	}
+out:
+	fat_cache_update_lru(inode, cache);
+
+	debug_pr("FAT: ");
+	list_for_each_entry(cache, &MSDOS_I(inode)->cache_lru, cache_list) {
+		debug_pr("(fclus %d, dclus %d, cont %d), ",
+		       cache->fcluster, cache->dcluster, cache->nr_contig);
+	}
+	debug_pr("\n");
+	spin_unlock(&sbi->cache_lock);
+}
+
+/*
+ * Cache invalidation occurs rarely, thus the LRU chain is not updated. It
+ * fixes itself after a while.
+ */
+static void __fat_cache_inval_inode(struct inode *inode)
+{
+	struct msdos_inode_info *i = MSDOS_I(inode);
+	struct fat_cache *cache;
+	while (!list_empty(&i->cache_lru)) {
+		cache = list_entry(i->cache_lru.next, struct fat_cache, cache_list);
+		list_del_init(&cache->cache_list);
+		MSDOS_I(inode)->nr_caches--;
+		fat_cache_free(cache);
+	}
+	debug_pr("FAT: %s\n", __FUNCTION__);
+}
+
+void fat_cache_inval_inode(struct inode *inode)
+{
+	spin_lock(&MSDOS_SB(inode->i_sb)->cache_lock);
+	__fat_cache_inval_inode(inode);
+	spin_unlock(&MSDOS_SB(inode->i_sb)->cache_lock);
+}
+
 int __fat_access(struct super_block *sb, int nr, int new_value)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -130,170 +328,24 @@ out:
 	return next;
 }
 
-void fat_cache_init(struct super_block *sb)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int count;
-
-	spin_lock_init(&sbi->cache_lock);
-
-	for (count = 0; count < FAT_CACHE_NR - 1; count++) {
-		sbi->cache_array[count].start_cluster = 0;
-		sbi->cache_array[count].next = &sbi->cache_array[count + 1];
-	}
-	sbi->cache_array[count].start_cluster = 0;
-	sbi->cache_array[count].next = NULL;
-	sbi->cache = sbi->cache_array;
-}
-
-static void
-fat_cache_lookup(struct inode *inode, int cluster, int *f_clu, int *d_clu)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	struct fat_cache *walk;
-	int first;
-
-	BUG_ON(cluster == 0);
-	
-	first = MSDOS_I(inode)->i_start;
-	if (!first)
-		return;
-
-	spin_lock(&sbi->cache_lock);
-
-	if (MSDOS_I(inode)->disk_cluster &&
-	    MSDOS_I(inode)->file_cluster <= cluster) {
-		*d_clu = MSDOS_I(inode)->disk_cluster;
-		*f_clu = MSDOS_I(inode)->file_cluster;
-	}
-
-	for (walk = sbi->cache; walk; walk = walk->next) {
-		if (walk->start_cluster == first
-		    && walk->file_cluster <= cluster
-		    && walk->file_cluster > *f_clu) {
-			*d_clu = walk->disk_cluster;
-			*f_clu = walk->file_cluster;
-#ifdef DEBUG
-			printk("cache hit: %d (%d)\n", *f_clu, *d_clu);
-#endif
-			if (*f_clu == cluster)
-				goto out;
-		}
-	}
-#ifdef DEBUG
-	printk("cache miss\n");
-#endif
-out:
-	spin_unlock(&sbi->cache_lock);
-}
-
-#ifdef DEBUG
-static void list_cache(struct super_block *sb)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct fat_cache *walk;
-
-	for (walk = sbi->cache; walk; walk = walk->next) {
-		if (walk->start_cluster)
-			printk("<%s,%d>(%d,%d) ", sb->s_id,
-			       walk->start_cluster, walk->file_cluster,
-			       walk->disk_cluster);
-		else
-			printk("-- ");
-	}
-	printk("\n");
-}
-#endif
-
-/*
- * Cache invalidation occurs rarely, thus the LRU chain is not updated. It
- * fixes itself after a while.
- */
-static void __fat_cache_inval_inode(struct inode *inode)
+static inline int cache_contiguous(struct fat_cache *cache, int dclus)
 {
-	struct fat_cache *walk;
-	int first = MSDOS_I(inode)->i_start;
-	MSDOS_I(inode)->file_cluster = MSDOS_I(inode)->disk_cluster = 0;
-	for (walk = MSDOS_SB(inode->i_sb)->cache; walk; walk = walk->next)
-		if (walk->start_cluster == first)
-			walk->start_cluster = 0;
+	cache->nr_contig++;
+	return ((cache->dcluster + cache->nr_contig) == dclus);
 }
 
-void fat_cache_inval_inode(struct inode *inode)
+static inline void cache_init(struct fat_cache *cache, int fclus, int dclus)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	spin_lock(&sbi->cache_lock);
-	__fat_cache_inval_inode(inode);
-	spin_unlock(&sbi->cache_lock);
-}
-
-void fat_cache_add(struct inode *inode, int f_clu, int d_clu)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	struct fat_cache *walk, *last;
-	int first, prev_f_clu, prev_d_clu;
-
-	if (f_clu == 0)
-		return;
-	first = MSDOS_I(inode)->i_start;
-	if (!first)
-		return;
-
-	last = NULL;
-	spin_lock(&sbi->cache_lock);
-
-	if (MSDOS_I(inode)->file_cluster == f_clu)
-		goto out;
-	else {
-		prev_f_clu = MSDOS_I(inode)->file_cluster;
-		prev_d_clu = MSDOS_I(inode)->disk_cluster;
-		MSDOS_I(inode)->file_cluster = f_clu;
-		MSDOS_I(inode)->disk_cluster = d_clu;
-		if (prev_f_clu == 0)
-			goto out;
-		f_clu = prev_f_clu;
-		d_clu = prev_d_clu;
-	}
-	
-	for (walk = sbi->cache; walk->next; walk = (last = walk)->next) {
-		if (walk->start_cluster == first &&
-		    walk->file_cluster == f_clu) {
-			if (walk->disk_cluster != d_clu) {
-				printk(KERN_ERR "FAT: cache corruption "
-				       "(i_pos %lld)\n", MSDOS_I(inode)->i_pos);
-				__fat_cache_inval_inode(inode);
-				goto out;
-			}
-			if (last == NULL)
-				goto out;
-
-			/* update LRU */
-			last->next = walk->next;
-			walk->next = sbi->cache;
-			sbi->cache = walk;
-#ifdef DEBUG
-			list_cache();
-#endif
-			goto out;
-		}
-	}
-	walk->start_cluster = first;
-	walk->file_cluster = f_clu;
-	walk->disk_cluster = d_clu;
-	last->next = NULL;
-	walk->next = sbi->cache;
-	sbi->cache = walk;
-#ifdef DEBUG
-	list_cache();
-#endif
-out:
-	spin_unlock(&sbi->cache_lock);
+	cache->fcluster = fclus;
+	cache->dcluster = dclus;
+	cache->nr_contig = 0;
 }
 
 int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 {
 	struct super_block *sb = inode->i_sb;
 	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
+	struct fat_cache cache;
 	int nr;
 
 	BUG_ON(MSDOS_I(inode)->i_start == 0);
@@ -303,7 +355,9 @@ int fat_get_cluster(struct inode *inode,
 	if (cluster == 0)
 		return 0;
 
-	fat_cache_lookup(inode, cluster, fclus, dclus);
+	if (fat_cache_lookup(inode, cluster, &cache, fclus, dclus) < 0)
+		cache_init(&cache, -1, -1); /* dummy, always not contiguous */
+
 	while (*fclus < cluster) {
 		/* prevent the infinite loop of cluster chain */
 		if (*fclus > limit) {
@@ -322,13 +376,15 @@ int fat_get_cluster(struct inode *inode,
 				     MSDOS_I(inode)->i_pos);
 			return -EIO;
 		} else if (nr == FAT_ENT_EOF) {
-			fat_cache_add(inode, *fclus, *dclus);
+			fat_cache_add(inode, &cache);
 			return FAT_ENT_EOF;
 		}
 		(*fclus)++;
 		*dclus = nr;
+		if (!cache_contiguous(&cache, *dclus))
+			cache_init(&cache, *fclus, *dclus);
 	}
-	fat_cache_add(inode, *fclus, *dclus);
+	fat_cache_add(inode, &cache);
 	return 0;
 }
 
diff -puN fs/fat/fatfs_syms.c~fat_new-cache fs/fat/fatfs_syms.c
--- linux-2.6.9-rc1/fs/fat/fatfs_syms.c~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/fatfs_syms.c	2004-09-05 18:49:00.000000000 +0900
@@ -33,16 +33,23 @@ EXPORT_SYMBOL(fat_add_entries);
 EXPORT_SYMBOL(fat_dir_empty);
 EXPORT_SYMBOL(fat_truncate);
 
+int __init fat_cache_init(void);
+void __exit fat_cache_destroy(void);
 int __init fat_init_inodecache(void);
 void __exit fat_destroy_inodecache(void);
 static int __init init_fat_fs(void)
 {
+	int ret;
 	fat_hash_init();
+	ret = fat_cache_init();
+	if (ret < 0)
+		return ret;
 	return fat_init_inodecache();
 }
 
 static void __exit exit_fat_fs(void)
 {
+	fat_cache_destroy();
 	fat_destroy_inodecache();
 }
 
diff -puN fs/fat/inode.c~fat_new-cache fs/fat/inode.c
--- linux-2.6.9-rc1/fs/fat/inode.c~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/inode.c	2004-09-05 18:49:00.000000000 +0900
@@ -530,7 +530,6 @@ static int fat_read_root(struct inode *i
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int error;
 
-	MSDOS_I(inode)->file_cluster = MSDOS_I(inode)->disk_cluster = 0;
 	MSDOS_I(inode)->i_pos = 0;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
@@ -733,6 +732,8 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
+		ei->nr_caches = 0;
+		INIT_LIST_HEAD(&ei->cache_lru);
 		INIT_HLIST_NODE(&ei->i_fat_hash);
 		inode_init_once(&ei->vfs_inode);
 	}
@@ -816,7 +817,7 @@ int fat_fill_super(struct super_block *s
 	if (error)
 		goto out_fail;
 
-	fat_cache_init(sb);
+	spin_lock_init(&MSDOS_SB(sb)->cache_lock);
 	/* set up enough so that it can read an inode */
 	init_MUTEX(&sbi->fat_lock);
 
@@ -1161,7 +1162,6 @@ static int fat_fill_inode(struct inode *
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int error;
 
-	MSDOS_I(inode)->file_cluster = MSDOS_I(inode)->disk_cluster = 0;
 	MSDOS_I(inode)->i_pos = 0;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
diff -puN fs/fat/misc.c~fat_new-cache fs/fat/misc.c
--- linux-2.6.9-rc1/fs/fat/misc.c~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/misc.c	2004-09-05 18:49:00.000000000 +0900
@@ -155,7 +155,7 @@ int fat_add_cluster(struct inode *inode)
 		ret = fat_access(sb, last, new_dclus);
 		if (ret < 0)
 			return ret;
-		fat_cache_add(inode, new_fclus, new_dclus);
+//		fat_cache_add(inode, new_fclus, new_dclus);
 	} else {
 		MSDOS_I(inode)->i_start = new_dclus;
 		MSDOS_I(inode)->i_logstart = new_dclus;
diff -puN include/linux/msdos_fs.h~fat_new-cache include/linux/msdos_fs.h
--- linux-2.6.9-rc1/include/linux/msdos_fs.h~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs.h	2004-09-05 18:49:00.000000000 +0900
@@ -232,8 +232,6 @@ static inline void fatwchar_to16(__u8 *d
 extern int fat_access(struct super_block *sb, int nr, int new_value);
 extern int __fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
-extern void fat_cache_init(struct super_block *sb);
-extern void fat_cache_add(struct inode *inode, int f_clu, int d_clu);
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
 			   int *fclus, int *dclus);
diff -puN include/linux/msdos_fs_i.h~fat_new-cache include/linux/msdos_fs_i.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_i.h~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_i.h	2004-09-05 18:49:00.000000000 +0900
@@ -8,9 +8,8 @@
  */
 
 struct msdos_inode_info {
-	/* cache of lastest accessed cluster */
-	int file_cluster;	/* cluster number in the file. */
-	int disk_cluster;	/* cluster number on disk. */
+	struct list_head cache_lru;
+	int nr_caches;
 
 	loff_t mmu_private;
 	int i_start;	/* first cluster or 0 */
diff -puN include/linux/msdos_fs_sb.h~fat_new-cache include/linux/msdos_fs_sb.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_sb.h~fat_new-cache	2004-09-05 18:49:00.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_sb.h	2004-09-05 18:49:00.000000000 +0900
@@ -26,15 +26,6 @@ struct fat_mount_options {
 		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
 };
 
-#define FAT_CACHE_NR	8 /* number of FAT cache */
-
-struct fat_cache {
-	int start_cluster; /* first cluster of the chain. */
-	int file_cluster; /* cluster number in the file. */
-	int disk_cluster; /* cluster number on disk. */
-	struct fat_cache *next; /* next cache entry */
-};
-
 struct msdos_sb_info {
 	unsigned short sec_per_clus; /* sectors/cluster */
 	unsigned short cluster_bits; /* log2(cluster_size) */
@@ -59,7 +50,6 @@ struct msdos_sb_info {
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
 
 	spinlock_t cache_lock;
-	struct fat_cache cache_array[FAT_CACHE_NR], *cache;
 };
 
 #endif
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
