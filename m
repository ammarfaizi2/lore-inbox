Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUIELci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUIELci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIELci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:32:38 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:23813 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266362AbUIELaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:30:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: cache lock from per sb to per inode (3/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 20:30:48 +0900
Message-ID: <874qmdvtp3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c              |   18 ++++++++----------
 fs/fat/inode.c              |    2 +-
 include/linux/msdos_fs_i.h  |    1 +
 include/linux/msdos_fs_sb.h |    2 --
 4 files changed, 10 insertions(+), 13 deletions(-)

diff -puN fs/fat/cache.c~fat_per-inode-lock fs/fat/cache.c
--- linux-2.6.9-rc1/fs/fat/cache.c~fat_per-inode-lock	2004-09-05 18:52:18.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/cache.c	2004-09-05 18:52:18.000000000 +0900
@@ -85,11 +85,10 @@ static int fat_cache_lookup(struct inode
 {
 	static struct fat_cache nohit = { .fcluster = 0, };
 
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	struct fat_cache *hit = &nohit, *p;
 	int offset = -1;
 
-	spin_lock(&sbi->cache_lock);
+	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
 	debug_pr("FAT: %s, fclus %d", __FUNCTION__, fclus);
 	list_for_each_entry(p, &MSDOS_I(inode)->cache_lru, cache_list) {
 		if (p->fcluster <= fclus && hit->fcluster < p->fcluster) {
@@ -113,7 +112,7 @@ static int fat_cache_lookup(struct inode
 		*cached_dclus = cache->dcluster + offset;
 	}
 	debug_pr("\n");
-	spin_unlock(&sbi->cache_lock);
+	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 
 	return offset;
 }
@@ -141,7 +140,6 @@ static struct fat_cache *fat_cache_merge
 
 static void fat_cache_add(struct inode *inode, struct fat_cache *new)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	struct fat_cache *cache, *tmp;
 
 	debug_pr("FAT: %s: fclus %d, dclus %d, cont %d\n", __FUNCTION__,
@@ -150,15 +148,15 @@ static void fat_cache_add(struct inode *
 	if (new->fcluster == -1) /* dummy cache */
 		return;
 
-	spin_lock(&sbi->cache_lock);
+	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
 	cache = fat_cache_merge(inode, new);
 	if (cache == NULL) {
 		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
 			MSDOS_I(inode)->nr_caches++;
-			spin_unlock(&sbi->cache_lock);
+			spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 
 			tmp = fat_cache_alloc(inode);
-			spin_lock(&sbi->cache_lock);
+			spin_lock(&MSDOS_I(inode)->cache_lru_lock);
 			cache = fat_cache_merge(inode, new);
 			if (cache != NULL) {
 				MSDOS_I(inode)->nr_caches--;
@@ -183,7 +181,7 @@ out:
 		       cache->fcluster, cache->dcluster, cache->nr_contig);
 	}
 	debug_pr("\n");
-	spin_unlock(&sbi->cache_lock);
+	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 }
 
 /*
@@ -205,9 +203,9 @@ static void __fat_cache_inval_inode(stru
 
 void fat_cache_inval_inode(struct inode *inode)
 {
-	spin_lock(&MSDOS_SB(inode->i_sb)->cache_lock);
+	spin_lock(&MSDOS_I(inode)->cache_lru_lock);
 	__fat_cache_inval_inode(inode);
-	spin_unlock(&MSDOS_SB(inode->i_sb)->cache_lock);
+	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 }
 
 int __fat_access(struct super_block *sb, int nr, int new_value)
diff -puN fs/fat/inode.c~fat_per-inode-lock fs/fat/inode.c
--- linux-2.6.9-rc1/fs/fat/inode.c~fat_per-inode-lock	2004-09-05 18:52:18.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/inode.c	2004-09-05 18:52:18.000000000 +0900
@@ -732,6 +732,7 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
+		spin_lock_init(&ei->cache_lru_lock);
 		ei->nr_caches = 0;
 		INIT_LIST_HEAD(&ei->cache_lru);
 		INIT_HLIST_NODE(&ei->i_fat_hash);
@@ -817,7 +818,6 @@ int fat_fill_super(struct super_block *s
 	if (error)
 		goto out_fail;
 
-	spin_lock_init(&MSDOS_SB(sb)->cache_lock);
 	/* set up enough so that it can read an inode */
 	init_MUTEX(&sbi->fat_lock);
 
diff -puN include/linux/msdos_fs_i.h~fat_per-inode-lock include/linux/msdos_fs_i.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_i.h~fat_per-inode-lock	2004-09-05 18:52:18.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_i.h	2004-09-05 18:52:18.000000000 +0900
@@ -8,6 +8,7 @@
  */
 
 struct msdos_inode_info {
+	spinlock_t cache_lru_lock;
 	struct list_head cache_lru;
 	int nr_caches;
 
diff -puN include/linux/msdos_fs_sb.h~fat_per-inode-lock include/linux/msdos_fs_sb.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_sb.h~fat_per-inode-lock	2004-09-05 18:52:18.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_sb.h	2004-09-05 18:52:18.000000000 +0900
@@ -48,8 +48,6 @@ struct msdos_sb_info {
 	void *dir_ops;		     /* Opaque; default directory operations */
 	int dir_per_block;	     /* dir entries per block */
 	int dir_per_block_bits;	     /* log2(dir_per_block) */
-
-	spinlock_t cache_lock;
 };
 
 #endif
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
