Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUIGNG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUIGNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIGNG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:06:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268024AbUIGNCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:02:49 -0400
Date: Tue, 7 Sep 2004 14:02:37 +0100
Message-Id: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 4/6]: ext3 reservations: Turn ext3 per-sb reservations list into an rbtree.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the per-sb reservations list in an rbtree, instead of a linear
list.  All new reservation requests (eg. for new files) can use an
rbtree search to find the existing reservation nearest the allocation
"goal".  Searching for the next free space is still by linear search
within the block group.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/fs/ext3/balloc.c.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/balloc.c
@@ -110,16 +110,55 @@ error_out:
  * we could easily switch to that without changing too much
  * code.
  */
-static inline void rsv_window_dump(struct reserve_window *head, char *fn)
-{
-	struct reserve_window *rsv;
-
+#if 0
+static void __rsv_window_dump(struct rb_root *root, int verbose, 
+			      const char *fn)
+{
+	struct rb_node *n;
+	struct reserve_window *rsv, *prev;
+	int bad;
+	
+restart:
+	n = rb_first(root);
+	bad = 0;
+	prev = NULL;
+	
 	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
-	list_for_each_entry(rsv, &head->rsv_list, rsv_list) {
-		printk("reservation window 0x%p start:  %d, end:  %d\n",
-			 rsv, rsv->rsv_start, rsv->rsv_end);
+	while (n) {
+		rsv = list_entry(n, struct reserve_window, rsv_node);
+		if (verbose)
+			printk("reservation window 0x%p "
+			       "start:  %d, end:  %d\n",
+			       rsv, rsv->rsv_start, rsv->rsv_end);
+		if (rsv->rsv_start && rsv->rsv_start >= rsv->rsv_end) {
+			printk("Bad reservation %p (start >= end)\n", 
+			       rsv);
+			bad = 1;
+		}
+		if (prev && prev->rsv_end >= rsv->rsv_start) {
+			printk("Bad reservation %p (prev->end >= start)\n",
+			       rsv);
+			bad = 1;
+		}
+		if (bad) {
+			if (!verbose) {
+				printk("Restarting reservation walk in verbose mode\n");
+				verbose = 1;
+				goto restart;
+			}
+		}
+		n = rb_next(n);
+		prev = rsv;
 	}
+	printk("Window map complete.\n");
+	if (bad)
+		BUG();
 }
+#define rsv_window_dump(root, verbose) \
+	__rsv_window_dump((root), (verbose), __FUNCTION__)
+#else
+#define rsv_window_dump(root, verbose) do {} while (0)
+#endif
 
 static int
 goal_in_my_reservation(struct reserve_window *rsv, int goal,
@@ -140,20 +179,79 @@ goal_in_my_reservation(struct reserve_wi
 	return 1;
 }
 
-static inline void rsv_window_add(struct reserve_window *rsv,
-					struct reserve_window *prev)
+/* 
+ * Find the reserved window which includes the goal, or the previous one
+ * if the goal is not in any window.
+ * Returns NULL if there are no windows or if all windows start after the goal.
+ */
+static struct reserve_window *search_reserve_window(struct rb_root *root,
+						    unsigned long goal)
 {
-	/* insert the new reservation window after the head */
-	list_add(&rsv->rsv_list, &prev->rsv_list);
+	struct rb_node *n = root->rb_node;
+	struct reserve_window *rsv;
+
+	if (!n)
+		return NULL;
+	
+	while (n)
+	{
+		rsv = rb_entry(n, struct reserve_window, rsv_node);
+
+		if (goal < rsv->rsv_start)
+			n = n->rb_left;
+		else if (goal > rsv->rsv_end)
+			n = n->rb_right;
+		else
+			return rsv;
+	}
+	/* 
+	 * We've fallen off the end of the tree: the goal wasn't inside
+	 * any particular node.  OK, the previous node must be to one
+	 * side of the interval containing the goal.  If it's the RHS,
+	 * we need to back up one. 
+	 */
+	if (rsv->rsv_start > goal) {
+		n = rb_prev(&rsv->rsv_node);
+		rsv = rb_entry(n, struct reserve_window, rsv_node);
+	}
+	return rsv; 
 }
 
-static inline void rsv_window_remove(struct reserve_window *rsv)
+void rsv_window_add(struct super_block *sb,
+		    struct reserve_window *rsv)
+{
+	struct rb_root *root = &EXT3_SB(sb)->s_rsv_window_root;
+	struct rb_node *node = &rsv->rsv_node;
+	unsigned int start = rsv->rsv_start;
+
+	struct rb_node ** p = &root->rb_node;
+	struct rb_node * parent = NULL;
+	struct reserve_window *this;
+	
+	while (*p)
+	{
+		parent = *p;
+		this = rb_entry(parent, struct reserve_window, rsv_node);
+
+		if (start < this->rsv_start)
+			p = &(*p)->rb_left;
+		else if (start > this->rsv_end)
+			p = &(*p)->rb_right;
+		else
+			BUG();
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, root);
+}
+
+static void rsv_window_remove(struct super_block *sb,
+			      struct reserve_window *rsv)
 {
 	rsv->rsv_start = 0;
 	rsv->rsv_end = 0;
-		rsv->rsv_alloc_hit = 0;
-	list_del(&rsv->rsv_list);
-	INIT_LIST_HEAD(&rsv->rsv_list);
+	rsv->rsv_alloc_hit = 0;
+	rb_erase(&rsv->rsv_node, &EXT3_SB(sb)->s_rsv_window_root);
 }
 
 static inline int rsv_is_empty(struct reserve_window *rsv)
@@ -170,7 +268,7 @@ void ext3_discard_reservation(struct ino
 
 	if (!rsv_is_empty(rsv)) {
 		spin_lock(rsv_lock);
-		rsv_window_remove(rsv);
+		rsv_window_remove(inode->i_sb, rsv);
 		spin_unlock(rsv_lock);
 	}
 }
@@ -583,18 +681,18 @@ fail_access:
  *		but we will shift to the place where start_block is,
  *		then start from there, when looking for a reservable space.
  *
- *	@fs_rsv_head: per-filesystem reservation list head.
- *
  * 	@size: the target new reservation window size
+ *
  * 	@group_first_block: the first block we consider to start
  *			the real search from
  *
  * 	@last_block:
- *		the maxium block number that our goal reservable space
+ *		the maximum block number that our goal reservable space
  *		could start from. This is normally the last block in this
  *		group. The search will end when we found the start of next
- *		possiblereservable space is out of this boundary.
- *		This could handle the cross bounday reservation window request.
+ *		possible reservable space is out of this boundary.
+ *		This could handle the cross boundary reservation window
+ *		request. 
  *
  * 	basically we search from the given range, rather than the whole
  * 	reservation double linked list, (start_block, last_block)
@@ -604,29 +702,23 @@ fail_access:
  *	on succeed, it returns the reservation window to be appended to.
  *	failed, return NULL.
  */
-static inline
-struct reserve_window *find_next_reservable_window(
+static struct reserve_window *find_next_reservable_window(
 				struct reserve_window *search_head,
-				struct reserve_window *fs_rsv_head,
 				unsigned long size, int *start_block,
 				int last_block)
 {
-	struct reserve_window *rsv;
+	struct rb_node *next;
+	struct reserve_window *rsv, *prev;
 	int cur;
 
-	/* TODO:make the start of the reservation window byte-aligned */
+	/* TODO: make the start of the reservation window byte-aligned */
 	/* cur = *start_block & ~7;*/
 	cur = *start_block;
-	rsv = list_entry(search_head->rsv_list.next,
-				struct reserve_window, rsv_list);
-	while (rsv != fs_rsv_head) {
-		if (cur + size <= rsv->rsv_start) {
-	 		/*
-			 * Found a reserveable space big enough.  We could
-			 * have a reservation across the group boundary here
-		 	 */
-			break;
-		}
+	rsv = search_head;
+	if (!rsv) 
+		return NULL;
+	
+	while (1) {
 		if (cur <= rsv->rsv_end)
 			cur = rsv->rsv_end + 1;
 
@@ -639,14 +731,31 @@ struct reserve_window *find_next_reserva
 		 * For now it will fail if we could not find the reservable
 		 * space with expected-size (or more)...
 		 */
-		rsv = list_entry(rsv->rsv_list.next,
-				struct reserve_window, rsv_list);
 		if (cur > last_block)
 			return NULL;		/* fail */
+
+		prev = rsv;
+		next = rb_next(&rsv->rsv_node);
+		rsv = list_entry(next, struct reserve_window, rsv_node);
+
+		/* 
+		 * Reached the last reservation, we can just append to the 
+		 * previous one. 
+		 */
+		if (!next)
+			break;
+
+		if (cur + size <= rsv->rsv_start) {
+			/*
+			 * Found a reserveable space big enough.  We could
+			 * have a reservation across the group boundary here
+		 	 */
+			break;
+		}
 	}
 	/*
 	 * we come here either :
-	 * when we rearch to the end of the whole list,
+	 * when we reach the end of the whole list,
 	 * and there is empty reservable space after last entry in the list.
 	 * append it to the end of the list.
 	 *
@@ -655,7 +764,7 @@ struct reserve_window *find_next_reserva
 	 * succeed.
 	 */
 	*start_block = cur;
-	return list_entry(rsv->rsv_list.prev, struct reserve_window, rsv_list);
+	return prev;
 }
 
 /**
@@ -713,7 +822,7 @@ static int alloc_new_reservation(struct 
 	int first_free_block;
 	int reservable_space_start;
 	struct reserve_window *prev_rsv;
-	struct reserve_window *fs_rsv_head = &EXT3_SB(sb)->s_rsv_window_head;
+	struct rb_root *fs_rsv_root = &EXT3_SB(sb)->s_rsv_window_root;
 	unsigned long size;
 
 	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
@@ -767,7 +876,7 @@ static int alloc_new_reservation(struct 
 		 * we set our goal(start_block) and
 		 * the list head for the search
 		 */
-		search_head = fs_rsv_head;
+		search_head = search_reserve_window(fs_rsv_root, start_block);
 	}
 
 	/*
@@ -778,7 +887,7 @@ static int alloc_new_reservation(struct 
 	 * need to check the bitmap after we found a reservable window.
 	 */
 retry:
-	prev_rsv = find_next_reservable_window(search_head, fs_rsv_head, size,
+	prev_rsv = find_next_reservable_window(search_head, size,
 						&start_block, group_end_block);
 	if (prev_rsv == NULL)
 		goto failed;
@@ -833,11 +942,13 @@ found_rsv_window:
 	 */
 	if (my_rsv != prev_rsv)  {
 		if (!rsv_is_empty(my_rsv))
-			rsv_window_remove(my_rsv);
-		rsv_window_add(my_rsv, prev_rsv);
+			rsv_window_remove(sb, my_rsv);
 	}
 	my_rsv->rsv_start = reservable_space_start;
 	my_rsv->rsv_end = my_rsv->rsv_start + size - 1;
+	if (my_rsv != prev_rsv)  {
+		rsv_window_add(sb, my_rsv);
+	}
 	return 0;		/* succeed */
 failed:
 	return -1;		/* failed */
--- linux-2.6.9-rc1-mm4/fs/ext3/ialloc.c.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/ialloc.c
@@ -586,7 +586,6 @@ got:
 	ei->i_rsv_window.rsv_end = 0;
 	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
 	ei->i_rsv_window.rsv_alloc_hit = 0;
-	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	ei->i_block_group = group;
 
 	ext3_set_inode_flags(inode);
--- linux-2.6.9-rc1-mm4/fs/ext3/inode.c.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/inode.c
@@ -2463,7 +2463,6 @@ void ext3_read_inode(struct inode * inod
 	ei->i_rsv_window.rsv_start = 0;
 	ei->i_rsv_window.rsv_end= 0;
 	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
-	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
--- linux-2.6.9-rc1-mm4/fs/ext3/super.c.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/super.c
@@ -1488,12 +1488,17 @@ static int ext3_fill_super (struct super
 	spin_lock_init(&sbi->s_next_gen_lock);
 	/* per fileystem reservation list head & lock */
 	spin_lock_init(&sbi->s_rsv_window_lock);
-	INIT_LIST_HEAD(&sbi->s_rsv_window_head.rsv_list);
+	sbi->s_rsv_window_root = RB_ROOT;
+	/* Add a single, static dummy reservation to the start of the
+	 * reservation window list --- it gives us a placeholder for
+	 * append-at-start-of-list which makes the allocation logic
+	 * _much_ simpler. */
 	sbi->s_rsv_window_head.rsv_start = 0;
 	sbi->s_rsv_window_head.rsv_end = 0;
 	sbi->s_rsv_window_head.rsv_alloc_hit = 0;
 	atomic_set(&sbi->s_rsv_window_head.rsv_goal_size, 0);
-
+	rsv_window_add(sb, &sbi->s_rsv_window_head);
+	
 	/*
 	 * set up enough so that it can read an inode
 	 */
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h
@@ -720,6 +720,7 @@ extern struct ext3_group_desc * ext3_get
 						    unsigned int block_group,
 						    struct buffer_head ** bh);
 extern int ext3_should_retry_alloc(struct super_block *sb, int *retries);
+extern void rsv_window_add(struct super_block *sb, struct reserve_window *rsv);
 
 /* dir.c */
 extern int ext3_check_dir_entry(const char *, struct inode *,
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h
@@ -17,11 +17,12 @@
 #define _LINUX_EXT3_FS_I
 
 #include <linux/rwsem.h>
+#include <linux/rbtree.h>
 
 struct reserve_window {
-	struct list_head 	rsv_list;
-	__u32			rsv_start;
-	__u32			rsv_end;
+	struct rb_node	 	rsv_node;
+	__u32			rsv_start;	/* First byte reserved */
+	__u32			rsv_end;	/* Last byte reserved or 0 */
 	atomic_t		rsv_goal_size;
 	__u32			rsv_alloc_hit;
 };
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs_sb.h.=K0003=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs_sb.h
@@ -22,6 +22,7 @@
 #include <linux/blockgroup_lock.h>
 #include <linux/percpu_counter.h>
 #endif
+#include <linux/rbtree.h>
 
 /*
  * third extended-fs super-block data in memory
@@ -59,10 +60,11 @@ struct ext3_sb_info {
 	struct percpu_counter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 
-	/* head of the per fs reservation window tree */
+	/* root of the per fs reservation window tree */
 	spinlock_t s_rsv_window_lock;
+	struct rb_root s_rsv_window_root;
 	struct reserve_window s_rsv_window_head;
-
+	
 	/* Journaling */
 	struct inode * s_journal_inode;
 	struct journal_s * s_journal;
