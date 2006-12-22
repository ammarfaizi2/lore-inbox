Return-Path: <linux-kernel-owner+w=401wt.eu-S1752749AbWLVVK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbWLVVK1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbWLVVK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:10:27 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:35609 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752749AbWLVVJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:09:50 -0500
X-Greylist: delayed 2746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 16:09:46 EST
From: Alex Tomas <alex@clusterfs.com>
Subject: [RFC] ext4-block-reservation.patch
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
TO: linux-ext4@vger.kernel.org
CC: <linux-kernel@vger.kernel.org>, alex@clusterfs.com
Date: Fri, 22 Dec 2006 23:25:16 +0300
In-Reply-To: <m37iwjwumf.fsf@bzzz.home.net> (Alex Tomas's message of "Fri\, 22
	Dec 2006 23\:20\:08 +0300")
Message-ID: <m3y7ozvftf.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Index: linux-2.6.20-rc1/include/linux/ext4_fs.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs.h	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs.h	2006-12-22 20:21:12.000000000 +0300
@@ -201,6 +201,7 @@ struct ext4_group_desc
 #define EXT4_STATE_JDATA		0x00000001 /* journaled data exists */
 #define EXT4_STATE_NEW			0x00000002 /* inode is newly created */
 #define EXT4_STATE_XATTR		0x00000004 /* has in-inode xattrs */
+#define EXT4_STATE_BLOCKS_RESERVED	0x00000008 /* blocks reserved */
 
 /* Used to pass group descriptor data when online resize is done */
 struct ext4_new_group_input {
@@ -808,6 +809,10 @@ extern struct ext4_group_desc * ext4_get
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 extern void ext4_init_block_alloc_info(struct inode *);
 extern void ext4_rsv_window_add(struct super_block *sb, struct ext4_reserve_window_node *rsv);
+int ext4_reserve_init(struct super_block *sb);
+void ext4_reserve_release(struct super_block *sb);
+void ext4_release_blocks(struct super_block *sb, int blocks);
+int ext4_reserve_blocks(struct super_block *sb, int blocks);
 
 /* dir.c */
 extern int ext4_check_dir_entry(const char *, struct inode *,
Index: linux-2.6.20-rc1/include/linux/ext4_fs_sb.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/ext4_fs_sb.h	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/include/linux/ext4_fs_sb.h	2006-12-22 20:20:10.000000000 +0300
@@ -24,6 +24,8 @@
 #endif
 #include <linux/rbtree.h>
 
+struct ext4_reservation_slot;
+
 /*
  * third extended-fs super-block data in memory
  */
@@ -65,6 +67,9 @@ struct ext4_sb_info {
 	struct rb_root s_rsv_window_root;
 	struct ext4_reserve_window_node s_rsv_window_head;
 
+	/* global reservation structures */
+	struct ext4_reservation_slot *s_reservation_slots;
+
 	/* Journaling */
 	struct inode * s_journal_inode;
 	struct journal_s * s_journal;
Index: linux-2.6.20-rc1/fs/ext4/super.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/super.c	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/super.c	2006-12-22 20:20:10.000000000 +0300
@@ -439,6 +439,7 @@ static void ext4_put_super (struct super
 	struct ext4_super_block *es = sbi->s_es;
 	int i;
 
+	ext4_reserve_release(sb);
 	ext4_ext_release(sb);
 	ext4_xattr_put_super(sb);
 	jbd2_journal_destroy(sbi->s_journal);
@@ -1867,6 +1868,7 @@ static int ext4_fill_super (struct super
 		"writeback");
 
 	ext4_ext_init(sb);
+	ext4_reserve_init(sb);
 
 	lock_kernel();
 	return 0;
Index: linux-2.6.20-rc1/fs/ext4/balloc.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext4/balloc.c	2006-12-14 04:14:23.000000000 +0300
+++ linux-2.6.20-rc1/fs/ext4/balloc.c	2006-12-22 20:32:11.000000000 +0300
@@ -630,8 +630,10 @@ void ext4_free_blocks(handle_t *handle, 
 		return;
 	}
 	ext4_free_blocks_sb(handle, sb, block, count, &dquot_freed_blocks);
-	if (dquot_freed_blocks)
+	if (dquot_freed_blocks) {
+		ext4_release_blocks(sb, dquot_freed_blocks);
 		DQUOT_FREE_BLOCK(inode, dquot_freed_blocks);
+	}
 	return;
 }
 
@@ -1440,7 +1442,7 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 	struct ext4_sb_info *sbi;
 	struct ext4_reserve_window_node *my_rsv = NULL;
 	struct ext4_block_alloc_info *block_i;
-	unsigned short windowsz = 0;
+	unsigned short windowsz = 0, reserved = 0;
 #ifdef EXT4FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -1462,6 +1464,13 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 		return 0;
 	}
 
+	if (!(EXT4_I(inode)->i_state & EXT4_STATE_BLOCKS_RESERVED)) {
+		*errp = ext4_reserve_blocks(sb, num);
+		if (*errp)
+			return 0;
+		reserved = num;
+	}
+
 	sbi = EXT4_SB(sb);
 	es = EXT4_SB(sb)->s_es;
 	ext4_debug("goal=%lu.\n", goal);
@@ -1674,8 +1683,11 @@ out:
 	/*
 	 * Undo the block allocation
 	 */
-	if (!performed_allocation)
+	if (!performed_allocation) {
 		DQUOT_FREE_BLOCK(inode, *count);
+		if (reserved)
+			ext4_release_blocks(sb, reserved);
+	}
 	brelse(bitmap_bh);
 	return 0;
 }
@@ -1834,3 +1846,161 @@ unsigned long ext4_bg_num_gdb(struct sup
 	return ext4_bg_num_gdb_meta(sb,group);
 
 }
+
+/*
+ * reservation.c contains routines to reserve blocks.
+ * we need this for delayed allocation, otherwise we
+ * could meet -ENOSPC at flush time
+ */
+
+/*
+ * as ->commit_write() where we're going to reserve
+ * non-allocated-yet blocks is well known hotpath,
+ * we have to make it scalable and avoid global
+ * data as much as possible
+ *
+ * there is per-sb array
+ */
+
+struct ext4_reservation_slot {
+	__u64		rs_reserved;
+	spinlock_t	rs_lock;
+} ____cacheline_aligned;
+
+
+int ext4_reserve_local(struct super_block *sb, int blocks)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_reservation_slot *rs;
+	int rc = -ENOSPC;
+
+	preempt_disable();
+	rs = sbi->s_reservation_slots + smp_processor_id();
+
+	spin_lock(&rs->rs_lock);
+	if (likely(rs->rs_reserved >= blocks)) {
+		rs->rs_reserved -= blocks;
+		rc = 0;
+	}
+	spin_unlock(&rs->rs_lock);
+
+	preempt_enable();
+	return rc;
+}
+
+
+void ext4_rebalance_reservation(struct ext4_reservation_slot *rs, __u64 free)
+{
+	int i, used_slots = 0;
+	__u64 chunk;
+
+	/* let's know what slots have been used */
+	for (i = 0; i < NR_CPUS; i++)
+		if (rs[i].rs_reserved || i == smp_processor_id())
+			used_slots++;
+
+	/* chunk is a number of block every used
+	 * slot will get. make sure it isn't 0 */
+	chunk = free + used_slots - 1;
+	do_div(chunk, used_slots);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (free < chunk)
+			chunk = free;
+		if (rs[i].rs_reserved || i == smp_processor_id()) {
+			rs[i].rs_reserved = chunk;
+			free -= chunk;
+			BUG_ON(free < 0);
+		}
+	}
+	BUG_ON(free);
+}
+
+int ext4_reserve_global(struct super_block *sb, int blocks)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_reservation_slot *rs;
+	int i, rc = -ENOENT;
+	__u64 free = 0;
+
+	rs = sbi->s_reservation_slots;
+
+	/* lock all slots */
+	for (i = 0; i < NR_CPUS; i++) {
+		spin_lock(&rs[i].rs_lock);
+		free += rs[i].rs_reserved;
+	}
+
+	if (free >= blocks) {
+		free -= blocks;
+		ext4_rebalance_reservation(rs, free);
+		rc = 0;
+	}
+
+	for (i = 0; i < NR_CPUS; i++)
+		spin_unlock(&rs[i].rs_lock);
+
+	return rc;
+}
+
+int ext4_reserve_blocks(struct super_block *sb, int blocks)
+{
+	int ret;
+
+	BUG_ON(blocks <= 0);
+
+	ret = ext4_reserve_local(sb, blocks);
+	if (likely(ret == 0))
+		return 0;
+
+	return ext4_reserve_global(sb, blocks);
+}
+
+void ext4_release_blocks(struct super_block *sb, int blocks)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_reservation_slot *rs;
+
+	BUG_ON(blocks <= 0);
+
+	preempt_disable();
+	rs = sbi->s_reservation_slots + smp_processor_id();
+
+	spin_lock(&rs->rs_lock);
+	rs->rs_reserved += blocks;
+	spin_unlock(&rs->rs_lock);
+
+	preempt_enable();
+}
+
+int ext4_reserve_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_reservation_slot *rs;
+	int i;
+
+	rs = kmalloc(sizeof(struct ext4_reservation_slot) * NR_CPUS, GFP_KERNEL);
+	if (rs == NULL)
+		return -ENOMEM;
+	sbi->s_reservation_slots = rs;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		spin_lock_init(&rs[i].rs_lock);
+		rs[i].rs_reserved = 0;
+	}
+	rs[0].rs_reserved = percpu_counter_sum(&sbi->s_freeblocks_counter);
+
+	return 0;
+}
+
+void ext4_reserve_release(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_reservation_slot *rs;
+
+	rs = sbi->s_reservation_slots;
+	BUG_ON(sbi->s_reservation_slots == NULL);
+	kfree(sbi->s_reservation_slots);
+	sbi->s_reservation_slots = NULL;
+}
+
