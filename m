Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUIIP2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUIIP2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUIIP2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:28:22 -0400
Received: from asplinux.ru ([195.133.213.194]:39944 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S265817AbUIIP14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:27:56 -0400
Message-ID: <4140791F.8050207@sw.ru>
Date: Thu, 09 Sep 2004 19:39:11 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] adding per sb inode list to make invalidate_inodes() faster
Content-Type: multipart/mixed;
 boundary="------------030901010406060705060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030901010406060705060206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I sent this patch once before for 2.4 kernels, here is the version for 
2.6.8.1.

This patch fixes the problem that huge inode cache
can make invalidate_inodes() calls very long. Meanwhile
lock_kernel() and inode_lock are being held and the system
can freeze for seconds.
I detected this problem on kernel with 4gb split. When inode cache
was 2.5Gb (1,000,000 of inodes in cache) it took seconds to umount
or turn quota off.

So this patch introduces per-super block inode list which makes
possible to scan sb's only inodes when doing umount.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill


--------------030901010406060705060206
Content-Type: text/plain;
 name="diff-inode-invalidate-20040908"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-inode-invalidate-20040908"

--- ./include/linux/fs.h.invl	2004-08-14 14:55:09.000000000 +0400
+++ ./include/linux/fs.h	2004-09-08 18:47:46.989249792 +0400
@@ -419,6 +419,7 @@ static inline int mapping_writably_mappe
 struct inode {
 	struct hlist_node	i_hash;
 	struct list_head	i_list;
+	struct list_head	i_sb_list;
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
 	atomic_t		i_count;
@@ -750,6 +751,7 @@ struct super_block {
 	atomic_t		s_active;
 	void                    *s_security;
 
+	struct list_head	s_inodes;	/* all inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
--- ./fs/hugetlbfs/inode.c.invl	2004-08-14 14:56:14.000000000 +0400
+++ ./fs/hugetlbfs/inode.c	2004-09-08 19:17:05.787871760 +0400
@@ -198,6 +198,7 @@ static void hugetlbfs_delete_inode(struc
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(inode->i_sb);
 
 	hlist_del_init(&inode->i_hash);
+	list_del(&inode->i_sb_list);
 	list_del_init(&inode->i_list);
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -240,6 +241,7 @@ static void hugetlbfs_forget_inode(struc
 	inodes_stat.nr_unused--;
 	hlist_del_init(&inode->i_hash);
 out_truncate:
+	list_del(&inode->i_sb_list);
 	list_del_init(&inode->i_list);
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
--- ./fs/inode.c.invl	2004-09-08 18:35:48.082540224 +0400
+++ ./fs/inode.c	2004-09-08 18:57:45.873205592 +0400
@@ -295,7 +295,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct list_head * dispose)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -308,12 +308,11 @@ static int invalidate_list(struct list_h
 		next = next->next;
 		if (tmp == head)
 			break;
-		inode = list_entry(tmp, struct inode, i_list);
-		if (inode->i_sb != sb)
-			continue;
+		inode = list_entry(tmp, struct inode, i_sb_list);
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
+			list_del(&inode->i_sb_list);
 			list_move(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
 			count++;
@@ -349,10 +348,7 @@ int invalidate_inodes(struct super_block
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
+	busy = invalidate_list(&sb->s_inodes, &throw_away);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
@@ -452,6 +448,7 @@ static void prune_icache(int nr_to_scan)
 				continue;
 		}
 		hlist_del_init(&inode->i_hash);
+		list_del(&inode->i_sb_list);
 		list_move(&inode->i_list, &freeable);
 		inode->i_state |= I_FREEING;
 		nr_pruned++;
@@ -561,6 +558,7 @@ struct inode *new_inode(struct super_blo
 	if (inode) {
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
+		list_add(&inode->i_sb_list, &sb->s_inodes);
 		list_add(&inode->i_list, &inode_in_use);
 		inode->i_ino = ++last_ino;
 		inode->i_state = 0;
@@ -609,6 +607,7 @@ static struct inode * get_new_inode(stru
 				goto set_failed;
 
 			inodes_stat.nr_inodes++;
+			list_add(&inode->i_sb_list, &sb->s_inodes);
 			list_add(&inode->i_list, &inode_in_use);
 			hlist_add_head(&inode->i_hash, head);
 			inode->i_state = I_LOCK|I_NEW;
@@ -657,6 +656,7 @@ static struct inode * get_new_inode_fast
 		if (!old) {
 			inode->i_ino = ino;
 			inodes_stat.nr_inodes++;
+			list_add(&inode->i_sb_list, &sb->s_inodes);
 			list_add(&inode->i_list, &inode_in_use);
 			hlist_add_head(&inode->i_hash, head);
 			inode->i_state = I_LOCK|I_NEW;
@@ -993,6 +993,7 @@ void generic_delete_inode(struct inode *
 {
 	struct super_operations *op = inode->i_sb->s_op;
 
+	list_del(&inode->i_sb_list);
 	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -1038,6 +1039,7 @@ static void generic_forget_inode(struct 
 		inodes_stat.nr_unused--;
 		hlist_del_init(&inode->i_hash);
 	}
+	list_del(&inode->i_sb_list);
 	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -1230,33 +1232,15 @@ int remove_inode_dquot_ref(struct inode 
 void remove_dquot_ref(struct super_block *sb, int type, struct list_head *tofree_head)
 {
 	struct inode *inode;
-	struct list_head *act_head;
 
 	if (!sb->dq_op)
 		return;	/* nothing to do */
-	spin_lock(&inode_lock);	/* This lock is for inodes code */
 
+	spin_lock(&inode_lock);	/* This lock is for inodes code */
 	/* We hold dqptr_sem so we are safe against the quota code */
-	list_for_each(act_head, &inode_in_use) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (inode->i_sb == sb && !IS_NOQUOTA(inode))
-			remove_inode_dquot_ref(inode, type, tofree_head);
-	}
-	list_for_each(act_head, &inode_unused) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (inode->i_sb == sb && !IS_NOQUOTA(inode))
-			remove_inode_dquot_ref(inode, type, tofree_head);
-	}
-	list_for_each(act_head, &sb->s_dirty) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (!IS_NOQUOTA(inode))
-			remove_inode_dquot_ref(inode, type, tofree_head);
-	}
-	list_for_each(act_head, &sb->s_io) {
-		inode = list_entry(act_head, struct inode, i_list);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list)
 		if (!IS_NOQUOTA(inode))
 			remove_inode_dquot_ref(inode, type, tofree_head);
-	}
 	spin_unlock(&inode_lock);
 }
 
--- ./fs/super.c.invl	2004-08-14 14:55:22.000000000 +0400
+++ ./fs/super.c	2004-09-08 18:46:47.227334984 +0400
@@ -65,6 +65,7 @@ static struct super_block *alloc_super(v
 		}
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
+		INIT_LIST_HEAD(&s->s_inodes);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);

--------------030901010406060705060206--

