Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTJMJvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJMJvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:51:06 -0400
Received: from holomorphy.com ([66.224.33.161]:26245 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261309AbTJMJu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:50:59 -0400
Date: Mon, 13 Oct 2003 02:53:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kk@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Message-ID: <20031013095347.GF16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kk@sw.ru>, linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310131318.09234.kk@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 01:18:09PM +0400, Kirill Korotaev wrote:
> I'm not sure whom this patch should be send to, so I'm posting it here.
> this patch fixes the problem that huge inode cache
> can make invalidate_inodes() calls very long. Meanwhile
> lock_kernel() and inode_lock are being held and system
> can freeze for seconds.
> I detected this problem on kernel with 4gb split. When inode cache
> was 2.5Gb (1,000,000 of inodes in cache) it took seconds to umount
> or turn quota off.
> This patch is against 2.4.22 kernel. But as far as I can see the problem
> still exists in 2.6 kernels.
> This patch introduces per-super block inode list which makes
> possible to scan sb's only inodes when doing umount.

Untested brute-force forward port to 2.6.0-test7-bk4. No idea if the
locking is correct or if list movement is done in all needed places.


diff -prauN linux-2.6.0-test7-bk4/fs/inode.c inode-2.6.0-test7-bk4-1/fs/inode.c
--- linux-2.6.0-test7-bk4/fs/inode.c	2003-10-08 12:24:51.000000000 -0700
+++ inode-2.6.0-test7-bk4-1/fs/inode.c	2003-10-13 02:38:59.000000000 -0700
@@ -285,7 +285,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct list_head *dispose)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -298,13 +298,11 @@ static int invalidate_list(struct list_h
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
-			list_del(&inode->i_list);
+			list_del(&inode->i_sb_list);
 			list_add(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
 			count++;
@@ -340,10 +338,7 @@ int invalidate_inodes(struct super_block
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
+	busy = invalidate_list(&sb->s_inodes, &throw_away);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
@@ -443,6 +438,7 @@ static void prune_icache(int nr_to_scan)
 				continue;
 		}
 		hlist_del_init(&inode->i_hash);
+		list_del_init(&inode->i_sb_list);
 		list_move(&inode->i_list, &freeable);
 		inode->i_state |= I_FREEING;
 		nr_pruned++;
@@ -553,6 +549,7 @@ struct inode *new_inode(struct super_blo
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
+		list_add(&inode->i_sb_list, &sb->s_inodes);
 		inode->i_ino = ++last_ino;
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
@@ -601,6 +598,7 @@ static struct inode * get_new_inode(stru
 
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
+			list_add(&inode->i_sb_list, &sb->s_inodes);
 			hlist_add_head(&inode->i_hash, head);
 			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
@@ -984,6 +982,7 @@ void generic_delete_inode(struct inode *
 	struct super_operations *op = inode->i_sb->s_op;
 
 	list_del_init(&inode->i_list);
+	list_del_init(&inode->i_sb_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
@@ -1031,6 +1030,7 @@ static void generic_forget_inode(struct 
 		hlist_del_init(&inode->i_hash);
 	}
 	list_del_init(&inode->i_list);
+	list_del_init(&inode->i_sb_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
@@ -1228,27 +1228,11 @@ void remove_dquot_ref(struct super_block
 		return;	/* nothing to do */
 	spin_lock(&inode_lock);	/* This lock is for inodes code */
 	/* We don't have to lock against quota code - test IS_QUOTAINIT is just for speedup... */
- 
-	list_for_each(act_head, &inode_in_use) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
-	list_for_each(act_head, &inode_unused) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
-	list_for_each(act_head, &sb->s_dirty) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
-	list_for_each(act_head, &sb->s_io) {
-		inode = list_entry(act_head, struct inode, i_list);
+
+	list_for_each_entry(inode, &sb->s_inodes)
 		if (IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
+ 
 	spin_unlock(&inode_lock);
 
 	put_dquot_list(&tofree_head);
diff -prauN linux-2.6.0-test7-bk4/fs/super.c inode-2.6.0-test7-bk4-1/fs/super.c
--- linux-2.6.0-test7-bk4/fs/super.c	2003-10-08 12:24:04.000000000 -0700
+++ inode-2.6.0-test7-bk4-1/fs/super.c	2003-10-13 02:28:22.000000000 -0700
@@ -66,6 +66,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
+		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		down_write(&s->s_umount);
diff -prauN linux-2.6.0-test7-bk4/include/linux/fs.h inode-2.6.0-test7-bk4-1/include/linux/fs.h
--- linux-2.6.0-test7-bk4/include/linux/fs.h	2003-10-08 12:24:03.000000000 -0700
+++ inode-2.6.0-test7-bk4-1/include/linux/fs.h	2003-10-13 02:37:13.000000000 -0700
@@ -369,6 +369,7 @@ struct block_device {
 struct inode {
 	struct hlist_node	i_hash;
 	struct list_head	i_list;
+	struct list_head	i_sb_list;
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
 	atomic_t		i_count;
@@ -687,6 +688,7 @@ struct super_block {
 	atomic_t		s_active;
 	void                    *s_security;
 
+	struct list_head	s_inodes;	/* all inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
