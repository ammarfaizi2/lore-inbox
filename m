Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSH1EQN>; Wed, 28 Aug 2002 00:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSH1EQN>; Wed, 28 Aug 2002 00:16:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318690AbSH1EQK>;
	Wed, 28 Aug 2002 00:16:10 -0400
Message-ID: <3D6C5238.8EC212A@zip.com.au>
Date: Tue, 27 Aug 2002 21:31:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] write() throttling fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch fixes a few problems in the writer throttling code.  Mainly
in the situation where a single large file is being written out.

That file could be parked on sb->locked_inodes due to pdflush
writeback, and the writer throttling path coming out of
balance_dirty_pages() forgot to look for inodes on ->locked_inodes.

The net effect was that the amount of dirty memory was exceeding the
limit set in /proc/sys/vm/dirty_async_ratio, possibly to the point
where the system gets seriously choked.

The patch removes sb->locked_inodes altogether and teaches the
throttling code to look or inodes on sb->s_io as well as sb->s_dirty.

Also, just leave unwritten dirty pages on mapping->io_pages, and
unwritten dirty inodes on sb->s_io.  Putting them back onto
->dirty_pages and ->dirty_inodes was fairly pointless, given that both
lists need to be looked at.



 fs/fs-writeback.c  |   42 +++++++++++++++---------------------------
 fs/inode.c         |    6 ------
 fs/mpage.c         |    3 +--
 fs/super.c         |    1 -
 include/linux/fs.h |    1 -
 5 files changed, 16 insertions(+), 37 deletions(-)

--- 2.5.32/fs/fs-writeback.c~throttling-fix	Tue Aug 27 21:30:51 2002
+++ 2.5.32-akpm/fs/fs-writeback.c	Tue Aug 27 21:30:51 2002
@@ -134,8 +134,6 @@ static void __sync_single_inode(struct i
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 
-	list_move(&inode->i_list, &sb->s_locked_inodes);
-
 	BUG_ON(inode->i_state & I_LOCK);
 
 	/* Set I_LOCK, reset I_DIRTY */
@@ -163,12 +161,12 @@ static void __sync_single_inode(struct i
 		if (inode->i_state & I_DIRTY) {		/* Redirtied */
 			list_add(&inode->i_list, &sb->s_dirty);
 		} else {
-			if (!list_empty(&mapping->dirty_pages)) {
+			if (!list_empty(&mapping->dirty_pages) ||
+					!list_empty(&mapping->io_pages)) {
 			 	/* Not a whole-file writeback */
 				mapping->dirtied_when = orig_dirtied_when;
 				inode->i_state |= I_DIRTY_PAGES;
-				list_add_tail(&inode->i_list,
-						&sb->s_dirty);
+				list_add_tail(&inode->i_list, &sb->s_dirty);
 			} else if (atomic_read(&inode->i_count)) {
 				list_add(&inode->i_list, &inode_in_use);
 			} else {
@@ -205,7 +203,7 @@ __writeback_single_inode(struct inode *i
  * If older_than_this is non-NULL, then only write out mappings which
  * had their first dirtying at a time earlier than *older_than_this.
  *
- * If we're a pdlfush thread, then implement pdlfush collision avoidance
+ * If we're a pdlfush thread, then implement pdflush collision avoidance
  * against the entire list.
  *
  * WB_SYNC_HOLD is a hack for sys_sync(): reattach the inode to sb->s_dirty so
@@ -221,6 +219,11 @@ __writeback_single_inode(struct inode *i
  * FIXME: this linear search could get expensive with many fileystems.  But
  * how to fix?  We need to go from an address_space to all inodes which share
  * a queue with that address_space.
+ *
+ * The inodes to be written are parked on sb->s_io.  They are moved back onto
+ * sb->s_dirty as they are selected for writing.  This way, none can be missed
+ * on the writer throttling path, and we get decent balancing between many
+ * thrlttled threads: we don't want them all piling up on __wait_on_inode.
  */
 static void
 sync_sb_inodes(struct backing_dev_info *single_bdi, struct super_block *sb,
@@ -241,7 +244,7 @@ sync_sb_inodes(struct backing_dev_info *
 		if (single_bdi && mapping->backing_dev_info != single_bdi) {
 			if (sb != blockdev_superblock)
 				break;		/* inappropriate superblock */
-			list_move(&inode->i_list, &inode->i_sb->s_dirty);
+			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* not this blockdev */
 		}
 
@@ -263,10 +266,11 @@ sync_sb_inodes(struct backing_dev_info *
 
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
+		list_move(&inode->i_list, &sb->s_dirty);
 		__writeback_single_inode(inode, really_sync, nr_to_write);
 		if (sync_mode == WB_SYNC_HOLD) {
 			mapping->dirtied_when = jiffies;
-			list_move(&inode->i_list, &inode->i_sb->s_dirty);
+			list_move(&inode->i_list, &sb->s_dirty);
 		}
 		if (current_is_pdflush())
 			writeback_release(bdi);
@@ -278,9 +282,8 @@ sync_sb_inodes(struct backing_dev_info *
 	}
 out:
 	/*
-	 * Put the rest back, in the correct order.
+	 * Leave any unwritten inodes on s_io.
 	 */
-	list_splice_init(&sb->s_io, sb->s_dirty.prev);
 	return;
 }
 
@@ -302,7 +305,7 @@ __writeback_unlocked_inodes(struct backi
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.prev);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
-		if (!list_empty(&sb->s_dirty)) {
+		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
 			spin_unlock(&sb_lock);
 			sync_sb_inodes(bdi, sb, sync_mode, nr_to_write,
 					older_than_this);
@@ -321,7 +324,7 @@ __writeback_unlocked_inodes(struct backi
  * Note:
  * We don't need to grab a reference to superblock here. If it has non-empty
  * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
- * past sync_inodes_sb() until both ->s_dirty and ->s_locked_inodes are
+ * past sync_inodes_sb() until both the ->s_dirty and ->s_io lists are
  * empty. Since __sync_single_inode() regains inode_lock before it finally moves
  * inode from superblock lists we are OK.
  *
@@ -352,19 +355,6 @@ void writeback_backing_dev(struct backin
 				sync_mode, older_than_this);
 }
 
-static void __wait_on_locked(struct list_head *head)
-{
-	struct list_head * tmp;
-	while ((tmp = head->prev) != head) {
-		struct inode *inode = list_entry(tmp, struct inode, i_list);
-		__iget(inode);
-		spin_unlock(&inode_lock);
-		__wait_on_inode(inode);
-		iput(inode);
-		spin_lock(&inode_lock);
-	}
-}
-
 /*
  * writeback and wait upon the filesystem's dirty inodes.  The caller will
  * do this in two passes - one to write, and one to wait.  WB_SYNC_HOLD is
@@ -384,8 +374,6 @@ void sync_inodes_sb(struct super_block *
 	spin_lock(&inode_lock);
 	sync_sb_inodes(NULL, sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 				&nr_to_write, NULL);
-	if (wait)
-		__wait_on_locked(&sb->s_locked_inodes);
 	spin_unlock(&inode_lock);
 }
 
--- 2.5.32/fs/mpage.c~throttling-fix	Tue Aug 27 21:30:51 2002
+++ 2.5.32-akpm/fs/mpage.c	Tue Aug 27 21:30:51 2002
@@ -599,9 +599,8 @@ mpage_writepages(struct address_space *m
 		write_lock(&mapping->page_lock);
 	}
 	/*
-	 * Put the rest back, in the correct order.
+	 * Leave any remaining dirty pages on ->io_pages
 	 */
-	list_splice_init(&mapping->io_pages, mapping->dirty_pages.prev);
 	write_unlock(&mapping->page_lock);
 	pagevec_deactivate_inactive(&pvec);
 	if (bio)
--- 2.5.32/include/linux/fs.h~throttling-fix	Tue Aug 27 21:30:51 2002
+++ 2.5.32-akpm/include/linux/fs.h	Tue Aug 27 21:30:51 2002
@@ -655,7 +655,6 @@ struct super_block {
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
-	struct list_head	s_locked_inodes;/* inodes being synced */
 	struct list_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
 
--- 2.5.32/fs/inode.c~throttling-fix	Tue Aug 27 21:30:51 2002
+++ 2.5.32-akpm/fs/inode.c	Tue Aug 27 21:30:51 2002
@@ -323,7 +323,6 @@ int invalidate_inodes(struct super_block
 	busy |= invalidate_list(&inode_unused, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_locked_inodes, sb, &throw_away);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
@@ -1000,11 +999,6 @@ void remove_dquot_ref(struct super_block
 		inode = list_entry(act_head, struct inode, i_list);
 		if (IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);
-	}
-	list_for_each(act_head, &sb->s_locked_inodes) {
-		inode = list_entry(act_head, struct inode, i_list);
-		if (IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
 	spin_unlock(&inode_lock);
 	unlock_kernel();
--- 2.5.32/fs/super.c~throttling-fix	Tue Aug 27 21:30:51 2002
+++ 2.5.32-akpm/fs/super.c	Tue Aug 27 21:30:51 2002
@@ -58,7 +58,6 @@ static struct super_block *alloc_super(v
 		}
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
-		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_LIST_HEAD(&s->s_anon);

.
