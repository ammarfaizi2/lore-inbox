Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTJMJRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTJMJRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:17:19 -0400
Received: from asplinux.ru ([195.133.213.194]:16659 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261586AbTJMJRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:17:07 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 13:18:09 +0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R3mi/A18QWdLK7k"
Message-Id: <200310131318.09234.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_R3mi/A18QWdLK7k
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm not sure whom this patch should be send to, so I'm posting it here.

this patch fixes the problem that huge inode cache
can make invalidate_inodes() calls very long. Meanwhile
lock_kernel() and inode_lock are being held and system
can freeze for seconds.
I detected this problem on kernel with 4gb split. When inode cache
was 2.5Gb (1,000,000 of inodes in cache) it took seconds to umount
or turn quota off.
This patch is against 2.4.22 kernel. But as far as I can see the problem
still exists in 2.6 kernels.
This patch introduces per-super block inode list which makes
possible to scan sb's only inodes when doing umount.

Kirill

--Boundary-00=_R3mi/A18QWdLK7k
Content-Type: text/plain;
  charset="us-ascii";
  name="diff-invlinodes-20031013"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff-invlinodes-20031013"

--- ./fs/super.c.ii	2003-08-25 15:44:43.000000000 +0400
+++ ./fs/super.c	2003-10-13 12:08:43.000000000 +0400
@@ -271,6 +271,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
+		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		down_write(&s->s_umount);
--- ./fs/inode.c.ii	2003-08-25 15:44:43.000000000 +0400
+++ ./fs/inode.c	2003-10-13 12:18:25.000000000 +0400
@@ -604,7 +604,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct list_head * dispose)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -617,12 +617,11 @@ static int invalidate_list(struct list_h
 		next = next->next;
 		if (tmp == head)
 			break;
-		inode = list_entry(tmp, struct inode, i_list);
-		if (inode->i_sb != sb)
-			continue;
+		inode = list_entry(tmp, struct inode, i_sb_list);
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			list_del_init(&inode->i_hash);
+			list_del(&inode->i_sb_list);
 			list_del(&inode->i_list);
 			list_add(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
@@ -659,10 +658,7 @@ int invalidate_inodes(struct super_block
 	LIST_HEAD(throw_away);
 
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_locked_inodes, sb, &throw_away);
+	busy = invalidate_list(&sb->s_inodes, &throw_away);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
@@ -738,6 +734,7 @@ void prune_icache(int goal)
 		list_del(tmp);
 		list_del(&inode->i_hash);
 		INIT_LIST_HEAD(&inode->i_hash);
+		list_del(&inode->i_sb_list);
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
@@ -827,6 +824,7 @@ struct inode * new_inode(struct super_bl
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
+		list_add(&inode->i_sb_list, &sb->s_inodes);
 		inode->i_ino = ++last_ino;
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
@@ -854,6 +852,7 @@ static struct inode * get_new_inode(stru
 		if (!old) {
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
+			list_add(&inode->i_sb_list, &sb->s_inodes);
 			list_add(&inode->i_hash, head);
 			inode->i_ino = ino;
 			inode->i_state = I_LOCK;
@@ -1046,6 +1045,7 @@ void iput(struct inode *inode)
 			INIT_LIST_HEAD(&inode->i_hash);
 			list_del(&inode->i_list);
 			INIT_LIST_HEAD(&inode->i_list);
+			list_del(&inode->i_sb_list);
 			inode->i_state|=I_FREEING;
 			inodes_stat.nr_inodes--;
 			spin_unlock(&inode_lock);
@@ -1079,6 +1079,7 @@ void iput(struct inode *inode)
 				list_del_init(&inode->i_hash);
 			}
 			list_del_init(&inode->i_list);
+			list_del(&inode->i_sb_list);
 			inode->i_state|=I_FREEING;
 			inodes_stat.nr_inodes--;
 			spin_unlock(&inode_lock);
@@ -1239,26 +1240,10 @@ void remove_dquot_ref(struct super_block
 	lock_kernel();		/* This lock is for quota code */
 	spin_lock(&inode_lock);	/* This lock is for inodes code */
  
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
+	list_for_each_entry(inode, act_head, &sb->s_inodes)
 		if (IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
-	list_for_each(act_head, &sb->s_locked_inodes) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
+
 	spin_unlock(&inode_lock);
 	unlock_kernel();
 
--- ./include/linux/fs.h.ii	2003-08-25 15:44:44.000000000 +0400
+++ ./include/linux/fs.h	2003-10-13 12:23:53.000000000 +0400
@@ -438,6 +438,7 @@ struct block_device {
 struct inode {
 	struct list_head	i_hash;
 	struct list_head	i_list;
+	struct list_head	i_sb_list;
 	struct list_head	i_dentry;
 	
 	struct list_head	i_dirty_buffers;
@@ -756,6 +757,7 @@ struct super_block {
 	int			s_count;
 	atomic_t		s_active;
 
+	struct list_head	s_inodes;	/* all inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_locked_inodes;/* inodes being synced */
 	struct list_head	s_files;

--Boundary-00=_R3mi/A18QWdLK7k--

