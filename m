Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUIEL3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUIEL3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIEL3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:29:47 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:12293 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266351AbUIEL3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:29:42 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: use hlist_head for fat_inode_hashtable (1/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 20:29:29 +0900
Message-ID: <87d611vtra.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c             |   22 ++++++++++------------
 include/linux/msdos_fs_i.h |    2 +-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff -puN fs/fat/inode.c~fat_hlist-for-inodehash fs/fat/inode.c
--- linux-2.6.9-rc1/fs/fat/inode.c~fat_hlist-for-inodehash	2004-09-05 18:33:08.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/fs/fat/inode.c	2004-09-05 18:43:37.000000000 +0900
@@ -58,15 +58,14 @@ static char fat_default_iocharset[] = CO
 #define FAT_HASH_BITS	8
 #define FAT_HASH_SIZE	(1UL << FAT_HASH_BITS)
 #define FAT_HASH_MASK	(FAT_HASH_SIZE-1)
-static struct list_head fat_inode_hashtable[FAT_HASH_SIZE];
+static struct hlist_head fat_inode_hashtable[FAT_HASH_SIZE];
 static spinlock_t fat_inode_lock = SPIN_LOCK_UNLOCKED;
 
 void fat_hash_init(void)
 {
 	int i;
-	for(i = 0; i < FAT_HASH_SIZE; i++) {
-		INIT_LIST_HEAD(&fat_inode_hashtable[i]);
-	}
+	for (i = 0; i < FAT_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&fat_inode_hashtable[i]);
 }
 
 static inline unsigned long fat_hash(struct super_block *sb, loff_t i_pos)
@@ -80,7 +79,7 @@ void fat_attach(struct inode *inode, lof
 {
 	spin_lock(&fat_inode_lock);
 	MSDOS_I(inode)->i_pos = i_pos;
-	list_add(&MSDOS_I(inode)->i_fat_hash,
+	hlist_add_head(&MSDOS_I(inode)->i_fat_hash,
 		fat_inode_hashtable + fat_hash(inode->i_sb, i_pos));
 	spin_unlock(&fat_inode_lock);
 }
@@ -89,20 +88,19 @@ void fat_detach(struct inode *inode)
 {
 	spin_lock(&fat_inode_lock);
 	MSDOS_I(inode)->i_pos = 0;
-	list_del_init(&MSDOS_I(inode)->i_fat_hash);
+	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
 	spin_unlock(&fat_inode_lock);
 }
 
 struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
-	struct list_head *p = fat_inode_hashtable + fat_hash(sb, i_pos);
-	struct list_head *walk;
+	struct hlist_head *head = fat_inode_hashtable + fat_hash(sb, i_pos);
+	struct hlist_node *_p;
 	struct msdos_inode_info *i;
 	struct inode *inode = NULL;
 
 	spin_lock(&fat_inode_lock);
-	list_for_each(walk, p) {
-		i = list_entry(walk, struct msdos_inode_info, i_fat_hash);
+	hlist_for_each_entry(i, _p, head, i_fat_hash) {
 		if (i->vfs_inode.i_sb != sb)
 			continue;
 		if (i->i_pos != i_pos)
@@ -159,7 +157,7 @@ void fat_clear_inode(struct inode *inode
 	lock_kernel();
 	spin_lock(&fat_inode_lock);
 	fat_cache_inval_inode(inode);
-	list_del_init(&MSDOS_I(inode)->i_fat_hash);
+	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
 	spin_unlock(&fat_inode_lock);
 	unlock_kernel();
 }
@@ -735,7 +733,7 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		INIT_LIST_HEAD(&ei->i_fat_hash);
+		INIT_HLIST_NODE(&ei->i_fat_hash);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
diff -puN include/linux/msdos_fs_i.h~fat_hlist-for-inodehash include/linux/msdos_fs_i.h
--- linux-2.6.9-rc1/include/linux/msdos_fs_i.h~fat_hlist-for-inodehash	2004-09-05 18:33:08.000000000 +0900
+++ linux-2.6.9-rc1-hirofumi/include/linux/msdos_fs_i.h	2004-09-05 18:43:37.000000000 +0900
@@ -18,7 +18,7 @@ struct msdos_inode_info {
 	int i_attrs;	/* unused attribute bits */
 	int i_ctime_ms;	/* unused change time in milliseconds */
 	loff_t i_pos;	/* on-disk position of directory entry or 0 */
-	struct list_head i_fat_hash;	/* hash by i_location */
+	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct inode vfs_inode;
 };
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
