Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUIGNIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUIGNIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUIGNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:08:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268019AbUIGNCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:02:52 -0400
Date: Tue, 7 Sep 2004 14:02:43 +0100
Message-Id: <200409071302.i87D2h7p030930@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 5/6]: ext3 reservations: Split the "reserve_window" struct into two
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split the "reserve_window" struct into two parts: a small
"reserve_window" describing the reservation itself, and a
"reserve_window_node" which contains the reservation plus all the data
needed to link it into the per-sb reservations tree.  

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/fs/ext3/balloc.c.=K0004=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/balloc.c
@@ -115,7 +115,7 @@ static void __rsv_window_dump(struct rb_
 			      const char *fn)
 {
 	struct rb_node *n;
-	struct reserve_window *rsv, *prev;
+	struct reserve_window_node *rsv, *prev;
 	int bad;
 	
 restart:
@@ -125,7 +125,7 @@ restart:
 	
 	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
 	while (n) {
-		rsv = list_entry(n, struct reserve_window, rsv_node);
+		rsv = list_entry(n, struct reserve_window_node, rsv_node);
 		if (verbose)
 			printk("reservation window 0x%p "
 			       "start:  %d, end:  %d\n",
@@ -170,11 +170,11 @@ goal_in_my_reservation(struct reserve_wi
 				group * EXT3_BLOCKS_PER_GROUP(sb);
 	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
 
-	if ((rsv->rsv_start > group_last_block) ||
-	    (rsv->rsv_end < group_first_block))
+	if ((rsv->_rsv_start > group_last_block) ||
+	    (rsv->_rsv_end < group_first_block))
 		return 0;
-	if ((goal >= 0) && ((goal + group_first_block < rsv->rsv_start)
-		|| (goal + group_first_block > rsv->rsv_end)))
+	if ((goal >= 0) && ((goal + group_first_block < rsv->_rsv_start)
+		|| (goal + group_first_block > rsv->_rsv_end)))
 		return 0;
 	return 1;
 }
@@ -184,18 +184,18 @@ goal_in_my_reservation(struct reserve_wi
  * if the goal is not in any window.
  * Returns NULL if there are no windows or if all windows start after the goal.
  */
-static struct reserve_window *search_reserve_window(struct rb_root *root,
-						    unsigned long goal)
+static struct reserve_window_node *search_reserve_window(struct rb_root *root,
+							 unsigned long goal)
 {
 	struct rb_node *n = root->rb_node;
-	struct reserve_window *rsv;
+	struct reserve_window_node *rsv;
 
 	if (!n)
 		return NULL;
 	
 	while (n)
 	{
-		rsv = rb_entry(n, struct reserve_window, rsv_node);
+		rsv = rb_entry(n, struct reserve_window_node, rsv_node);
 
 		if (goal < rsv->rsv_start)
 			n = n->rb_left;
@@ -212,13 +212,13 @@ static struct reserve_window *search_res
 	 */
 	if (rsv->rsv_start > goal) {
 		n = rb_prev(&rsv->rsv_node);
-		rsv = rb_entry(n, struct reserve_window, rsv_node);
+		rsv = rb_entry(n, struct reserve_window_node, rsv_node);
 	}
 	return rsv; 
 }
 
 void rsv_window_add(struct super_block *sb,
-		    struct reserve_window *rsv)
+		    struct reserve_window_node *rsv)
 {
 	struct rb_root *root = &EXT3_SB(sb)->s_rsv_window_root;
 	struct rb_node *node = &rsv->rsv_node;
@@ -226,12 +226,12 @@ void rsv_window_add(struct super_block *
 
 	struct rb_node ** p = &root->rb_node;
 	struct rb_node * parent = NULL;
-	struct reserve_window *this;
+	struct reserve_window_node *this;
 	
 	while (*p)
 	{
 		parent = *p;
-		this = rb_entry(parent, struct reserve_window, rsv_node);
+		this = rb_entry(parent, struct reserve_window_node, rsv_node);
 
 		if (start < this->rsv_start)
 			p = &(*p)->rb_left;
@@ -246,7 +246,7 @@ void rsv_window_add(struct super_block *
 }
 
 static void rsv_window_remove(struct super_block *sb,
-			      struct reserve_window *rsv)
+			      struct reserve_window_node *rsv)
 {
 	rsv->rsv_start = 0;
 	rsv->rsv_end = 0;
@@ -257,16 +257,16 @@ static void rsv_window_remove(struct sup
 static inline int rsv_is_empty(struct reserve_window *rsv)
 {
 	/* a valid reservation end block could not be 0 */
-	return (rsv->rsv_end == 0);
+	return (rsv->_rsv_end == 0);
 }
 
 void ext3_discard_reservation(struct inode *inode)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
-	struct reserve_window *rsv = &ei->i_rsv_window;
+	struct reserve_window_node *rsv = &ei->i_rsv_window;
 	spinlock_t *rsv_lock = &EXT3_SB(inode->i_sb)->s_rsv_window_lock;
 
-	if (!rsv_is_empty(rsv)) {
+	if (!rsv_is_empty(&rsv->rsv_window)) {
 		spin_lock(rsv_lock);
 		rsv_window_remove(inode->i_sb, rsv);
 		spin_unlock(rsv_lock);
@@ -609,12 +609,12 @@ ext3_try_to_allocate(struct super_block 
 		group_first_block =
 			le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
 			group * EXT3_BLOCKS_PER_GROUP(sb);
-		if (my_rsv->rsv_start >= group_first_block)
-			start = my_rsv->rsv_start - group_first_block;
+		if (my_rsv->_rsv_start >= group_first_block)
+			start = my_rsv->_rsv_start - group_first_block;
 		else
 			/* reservation window cross group boundary */
 			start = 0;
-		end = my_rsv->rsv_end - group_first_block + 1;
+		end = my_rsv->_rsv_end - group_first_block + 1;
 		if (end > EXT3_BLOCKS_PER_GROUP(sb))
 			/* reservation window crosses group boundary */
 			end = EXT3_BLOCKS_PER_GROUP(sb);
@@ -660,8 +660,6 @@ repeat:
 			goto fail_access;
 		goto repeat;
 	}
-	if (my_rsv)
-		my_rsv->rsv_alloc_hit++;
 	return goal;
 fail_access:
 	return -1;
@@ -702,13 +700,13 @@ fail_access:
  *	on succeed, it returns the reservation window to be appended to.
  *	failed, return NULL.
  */
-static struct reserve_window *find_next_reservable_window(
-				struct reserve_window *search_head,
+static struct reserve_window_node *find_next_reservable_window(
+				struct reserve_window_node *search_head,
 				unsigned long size, int *start_block,
 				int last_block)
 {
 	struct rb_node *next;
-	struct reserve_window *rsv, *prev;
+	struct reserve_window_node *rsv, *prev;
 	int cur;
 
 	/* TODO: make the start of the reservation window byte-aligned */
@@ -736,7 +734,7 @@ static struct reserve_window *find_next_
 
 		prev = rsv;
 		next = rb_next(&rsv->rsv_node);
-		rsv = list_entry(next, struct reserve_window, rsv_node);
+		rsv = list_entry(next, struct reserve_window_node, rsv_node);
 
 		/* 
 		 * Reached the last reservation, we can just append to the 
@@ -813,15 +811,15 @@ static struct reserve_window *find_next_
  *	@group: the group we are trying to allocate in
  *	@bitmap_bh: the block group block bitmap
  */
-static int alloc_new_reservation(struct reserve_window *my_rsv,
+static int alloc_new_reservation(struct reserve_window_node *my_rsv,
 		int goal, struct super_block *sb,
 		unsigned int group, struct buffer_head *bitmap_bh)
 {
-	struct reserve_window *search_head;
+	struct reserve_window_node *search_head;
 	int group_first_block, group_end_block, start_block;
 	int first_free_block;
 	int reservable_space_start;
-	struct reserve_window *prev_rsv;
+	struct reserve_window_node *prev_rsv;
 	struct rb_root *fs_rsv_root = &EXT3_SB(sb)->s_rsv_window_root;
 	unsigned long size;
 
@@ -836,7 +834,7 @@ static int alloc_new_reservation(struct 
 
 	size = atomic_read(&my_rsv->rsv_goal_size);
 	/* if we have a old reservation, start the search from the old rsv */
-	if (!rsv_is_empty(my_rsv)) {
+	if (!rsv_is_empty(&my_rsv->rsv_window)) {
 		/*
 		 * if the old reservation is cross group boundary
 		 * we will come here when we just failed to allocate from
@@ -941,7 +939,7 @@ found_rsv_window:
 	 * same place, just update the new start and new end.
 	 */
 	if (my_rsv != prev_rsv)  {
-		if (!rsv_is_empty(my_rsv))
+		if (!rsv_is_empty(&my_rsv->rsv_window))
 			rsv_window_remove(sb, my_rsv);
 	}
 	my_rsv->rsv_start = reservable_space_start;
@@ -978,7 +976,7 @@ failed:
 static int
 ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
 			unsigned int group, struct buffer_head *bitmap_bh,
-			int goal, struct reserve_window * my_rsv,
+			int goal, struct reserve_window_node * my_rsv,
 			int *errp)
 {
 	spinlock_t *rsv_lock;
@@ -1037,8 +1035,9 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * then we could go to allocate from the reservation window directly.
 	 */
 	while (1) {
-		if (rsv_is_empty(my_rsv) || (ret < 0) ||
-			!goal_in_my_reservation(my_rsv, goal, group, sb)) {
+		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
+			!goal_in_my_reservation(&my_rsv->rsv_window, 
+						goal, group, sb)) {
 			spin_lock(rsv_lock);
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
@@ -1046,16 +1045,19 @@ ext3_try_to_allocate_with_rsv(struct sup
 			if (ret < 0)
 				break;			/* failed */
 
-			if (!goal_in_my_reservation(my_rsv, goal, group, sb))
+			if (!goal_in_my_reservation(&my_rsv->rsv_window,
+						    goal, group, sb))
 				goal = -1;
 		}
 		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
 			|| (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					my_rsv);
-		if (ret >= 0)
+					   &my_rsv->rsv_window);
+		if (ret >= 0) {
+			my_rsv->rsv_alloc_hit++;
 			break;				/* succeed */
+		}
 	}
 out:
 	if (ret >= 0) {
@@ -1129,7 +1131,7 @@ int ext3_new_block(handle_t *handle, str
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
-	struct reserve_window *my_rsv = NULL;
+	struct reserve_window_node *my_rsv = NULL;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h.=K0004=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h
@@ -720,7 +720,7 @@ extern struct ext3_group_desc * ext3_get
 						    unsigned int block_group,
 						    struct buffer_head ** bh);
 extern int ext3_should_retry_alloc(struct super_block *sb, int *retries);
-extern void rsv_window_add(struct super_block *sb, struct reserve_window *rsv);
+extern void rsv_window_add(struct super_block *sb, struct reserve_window_node *rsv);
 
 /* dir.c */
 extern int ext3_check_dir_entry(const char *, struct inode *,
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h.=K0004=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h
@@ -20,13 +20,20 @@
 #include <linux/rbtree.h>
 
 struct reserve_window {
+	__u32			_rsv_start;	/* First byte reserved */
+	__u32			_rsv_end;	/* Last byte reserved or 0 */
+};
+
+struct reserve_window_node {
 	struct rb_node	 	rsv_node;
-	__u32			rsv_start;	/* First byte reserved */
-	__u32			rsv_end;	/* Last byte reserved or 0 */
 	atomic_t		rsv_goal_size;
 	__u32			rsv_alloc_hit;
+	struct reserve_window	rsv_window;
 };
 
+#define rsv_start rsv_window._rsv_start
+#define rsv_end rsv_window._rsv_end
+
 /*
  * third extended file system inode data in memory
  */
@@ -67,7 +74,7 @@ struct ext3_inode_info {
 	 */
 	__u32	i_next_alloc_goal;
 	/* block reservation window */
-	struct reserve_window i_rsv_window;
+	struct reserve_window_node i_rsv_window;
 
 	__u32	i_dir_start_lookup;
 #ifdef CONFIG_EXT3_FS_XATTR
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs_sb.h.=K0004=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs_sb.h
@@ -63,7 +63,7 @@ struct ext3_sb_info {
 	/* root of the per fs reservation window tree */
 	spinlock_t s_rsv_window_lock;
 	struct rb_root s_rsv_window_root;
-	struct reserve_window s_rsv_window_head;
+	struct reserve_window_node s_rsv_window_head;
 	
 	/* Journaling */
 	struct inode * s_journal_inode;
