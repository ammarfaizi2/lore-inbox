Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbUDNAv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbUDNAv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:51:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4744 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263843AbUDNAua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:50:30 -0400
Subject: [PATCH 2/4] ext3 block reservation patch set --ext3 block
	reservation
From: Mingming Cao <cmm@us.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <1081903949.3548.6837.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain> 
	<20040402185007.7d41e1a2.akpm@osdl.org> 
	<1081903949.3548.6837.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-LQYm1kXIPvJblTS1CvAI"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Apr 2004 17:57:04 -0700
Message-Id: <1081904225.3548.6844.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LQYm1kXIPvJblTS1CvAI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [patch 2]ext3_rsv_base.patch: Implements the base of in-memory block
> reservation and block allocation from reservation window.
	-basic reservation structure and operations
	-reservation based ext3 block allocation 

diffstat ext3_rsv_base.patch
 fs/ext3/balloc.c           |  548
++++++++++++++++++++++++++++++++++++++++-----
 fs/ext3/file.c             |    2
 fs/ext3/ialloc.c           |    5
 fs/ext3/inode.c            |    9
 fs/ext3/super.c            |    7
 include/linux/ext3_fs.h    |    6
 include/linux/ext3_fs_i.h  |   12
 include/linux/ext3_fs_sb.h |    4
 8 files changed, 542 insertions(+), 51 deletions(-)


--=-LQYm1kXIPvJblTS1CvAI
Content-Disposition: attachment; filename=ext3_rsv_base.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_rsv_base.patch; charset=UTF-8

diff -urNp -X dontdiff 264-rsv-cleanup/fs/ext3/balloc.c 264-rsv-cleanup-bas=
e/fs/ext3/balloc.c
--- 264-rsv-cleanup/fs/ext3/balloc.c	2004-04-06 01:49:11.000000000 -0700
+++ 264-rsv-cleanup-base/fs/ext3/balloc.c	2004-04-13 01:42:40.352200376 -07=
00
@@ -96,6 +96,79 @@ read_block_bitmap(struct super_block *sb
 error_out:
 	return bh;
 }
+/*
+ * The reservation window structure operations
+ * --------------------------------------------
+ * Operations include:
+ * dump, find, add, remove, is_empty, find_next_reservable_window, etc.
+ *
+ * We use sorted double linked list for the per-filesystem reservation
+ * window list. (like in vm_region).
+ *=20
+ * Initially, we keep those small operations in the abstract functions,=20
+ * so later if we need a better searching tree than double linked-list,
+ * we could easily switch to that without changing too much
+ * code.
+ */
+static inline void rsv_window_dump(struct reserve_window *head, char *fn)
+{
+	struct reserve_window *rsv;
+	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
+	list_for_each_entry(rsv, &head->rsv_list, rsv_list) {
+		printk("reservation window 0x%p start:  %d, end:  %d\n",
+			 rsv, rsv->rsv_start, rsv->rsv_end);
+	}
+}
+
+static inline int goal_in_my_reservation(struct reserve_window *rsv, int g=
oal,=20
+					unsigned int group, struct super_block * sb)
+{
+	unsigned long group_first_block, group_last_block;
+
+	group_first_block =3D le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) =
+
+				group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_last_block =3D group_first_block + EXT3_BLOCKS_PER_GROUP(sb) -1 ;
+
+	if ((rsv->rsv_start > group_last_block) || (rsv->rsv_end < group_first_bl=
ock))
+		return 0;
+	if ((goal >=3D 0) && ((goal + group_first_block < rsv->rsv_start)=20
+		|| (goal + group_first_block > rsv->rsv_end)))
+		return 0;
+	return 1;
+}
+
+static inline void rsv_window_add(struct reserve_window *rsv,=20
+					struct reserve_window *prev)
+{
+	/* insert the new reservation window after the head */
+	list_add(&rsv->rsv_list, &prev->rsv_list);
+}
+
+static inline void rsv_window_remove(struct reserve_window *rsv)
+{
+		rsv->rsv_start =3D 0;
+		rsv->rsv_end =3D 0;
+		list_del(&rsv->rsv_list);
+		INIT_LIST_HEAD(&rsv->rsv_list);
+}
+static inline int rsv_is_empty(struct reserve_window *rsv)
+{
+	/* a valid reservation end block could not be 0 */
+	return (rsv->rsv_end =3D=3D 0);=20
+}
+
+void ext3_discard_reservation(struct inode *inode)
+{
+	struct ext3_inode_info *ei =3D EXT3_I(inode);
+	struct reserve_window *rsv =3D &ei->i_rsv_window;
+	spinlock_t *rsv_lock =3D &EXT3_SB(inode->i_sb)->s_rsv_window_lock;
+
+	if (!rsv_is_empty(rsv)) {
+		spin_lock(rsv_lock);
+		rsv_window_remove(rsv);
+		spin_unlock(rsv_lock);
+	}
+}
=20
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks (handle_t *handle, struct inode * inode,
@@ -313,6 +386,33 @@ static inline int ext3_test_allocatable(
 	return ret;
 }
=20
+static inline int
+bitmap_search_next_usable_block(int start, struct buffer_head *bh,=20
+					int maxblocks)
+{
+	int next;
+	struct journal_head *jh =3D bh2jh(bh);
+
+	/*
+	 * The bitmap search --- search forward alternately through the actual
+	 * bitmap and the last-committed copy until we find a bit free in
+	 * both
+	 */
+	while (start < maxblocks) {
+		next =3D ext3_find_next_zero_bit(bh->b_data, maxblocks, start);
+		if (next >=3D maxblocks)
+			return -1;
+		if (ext3_test_allocatable(next, bh))
+			return next;
+		jbd_lock_bh_state(bh);
+		if (jh->b_committed_data)
+			start =3D ext3_find_next_zero_bit(jh->b_committed_data,
+						 	maxblocks, next);
+		jbd_unlock_bh_state(bh);
+	}
+	return -1;
+}
+
 /*
  * Find an allocatable block in a bitmap.  We honour both the bitmap and
  * its last-committed copy (if that exists), and perform the "most
@@ -325,7 +425,6 @@ find_next_usable_block(int start, struct
 {
 	int here, next;
 	char *p, *r;
-	struct journal_head *jh =3D bh2jh(bh);
=20
 	if (start > 0) {
 		/*
@@ -337,6 +436,8 @@ find_next_usable_block(int start, struct
 		 * next 64-bit boundary is simple..
 		 */
 		int end_goal =3D (start + 63) & ~63;
+		if (end_goal > maxblocks)
+			end_goal =3D maxblocks;
 		here =3D ext3_find_next_zero_bit(bh->b_data, end_goal, start);
 		if (here < end_goal && ext3_test_allocatable(here, bh))
 			return here;
@@ -359,19 +460,8 @@ find_next_usable_block(int start, struct
 	 * bitmap and the last-committed copy until we find a bit free in
 	 * both
 	 */
-	while (here < maxblocks) {
-		next =3D ext3_find_next_zero_bit(bh->b_data, maxblocks, here);
-		if (next >=3D maxblocks)
-			return -1;
-		if (ext3_test_allocatable(next, bh))
-			return next;
-		jbd_lock_bh_state(bh);
-		if (jh->b_committed_data)
-			here =3D ext3_find_next_zero_bit(jh->b_committed_data,
-						 	maxblocks, next);
-		jbd_unlock_bh_state(bh);
-	}
-	return -1;
+	here =3D bitmap_search_next_usable_block(here, bh, maxblocks);
+	return here;
 }
=20
 /*
@@ -407,62 +497,421 @@ claim_block(spinlock_t *lock, int block,
  */
 static int
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-		struct buffer_head *bitmap_bh, int goal, int *errp)
+		struct buffer_head *bitmap_bh, int goal, struct reserve_window * my_rsv)
 {
-	int i;
-	int fatal;
-	int credits =3D 0;
+	int group_first_block, start, end;
=20
-	*errp =3D 0;
-
-	/*
-	 * Make sure we use undo access for the bitmap, because it is critical
-	 * that we do the frozen_data COW on bitmap buffers in all cases even
-	 * if the buffer is in BJ_Forget state in the committing transaction.
-	 */
-	BUFFER_TRACE(bitmap_bh, "get undo access for new block");
-	fatal =3D ext3_journal_get_undo_access(handle, bitmap_bh, &credits);
-	if (fatal) {
-		*errp =3D fatal;
-		goto fail;
+	/* we do allocation within the reservation window if we have a window */
+	if (my_rsv) {
+		group_first_block =3D
+			le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
+			group * EXT3_BLOCKS_PER_GROUP(sb);
+		if (my_rsv->rsv_start >=3D group_first_block)
+			start =3D my_rsv->rsv_start - group_first_block;
+		else
+			/* reservation window cross group boundary */
+			start =3D 0;
+		end =3D my_rsv->rsv_end - group_first_block + 1;
+		if (end > EXT3_BLOCKS_PER_GROUP(sb))
+			/* reservation window cross group boundary */
+			end =3D EXT3_BLOCKS_PER_GROUP(sb);
+		if ((start <=3D goal) && (goal < end))
+			start =3D goal;
+		else=20
+			goal =3D -1;
+	}
+	else {
+		if (goal > 0)
+			start =3D goal;
+		else
+			start =3D 0;
+		end =3D EXT3_BLOCKS_PER_GROUP(sb);
 	}
=20
+	if (start > EXT3_BLOCKS_PER_GROUP(sb)) BUG();
+
 repeat:
 	if (goal < 0 || !ext3_test_allocatable(goal, bitmap_bh)) {
-		goal =3D find_next_usable_block(goal, bitmap_bh,
-					EXT3_BLOCKS_PER_GROUP(sb));
+		goal =3D find_next_usable_block(start, bitmap_bh, end);
 		if (goal < 0)
 			goto fail_access;
-
-		for (i =3D 0; i < 7 && goal > 0 &&
-				ext3_test_allocatable(goal - 1, bitmap_bh);
-			i++, goal--);
 	}
+	start =3D goal;
=20
 	if (!claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
 		/*
 		 * The block was allocated by another thread, or it was
 		 * allocated and then freed by another thread
 		 */
-		goal++;
-		if (goal >=3D EXT3_BLOCKS_PER_GROUP(sb))
+		start++; goal++;
+		if (start >=3D end)
 			goto fail_access;
 		goto repeat;
 	}
=20
-	BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
-	fatal =3D ext3_journal_dirty_metadata(handle, bitmap_bh);
+	return goal;
+fail_access:
+	return -1;
+}
+/**
+ * 	find_next_reservable_window():=20
+ *		find a reservable space within the given range
+ *		It does not allocate the reservation window for now
+ *		alloc_new_reservation() will do the work later.
+ *
+ * 	@search_head: the head of the searching list;
+ *		This is not necessary the list head of the whole filesystem
+ *	=09
+ *		we have both head and start_block to assist the search=20
+ *		for the reservable space. The list start from head,=20
+ *		but we will shift to the place where start_block is,
+ *		then start from there, we looking for a resevable space.
+ *
+ *	@fs_rsv_head: per-filesystem reervation list head.
+ *=09
+ * 	@size: the target new reservation window size
+ * 	@group_first_block: the first block we consider to start=20
+ *			the real search from
+ *
+ * 	@last_block:=20
+ *		the maxium block number that our goal reservable space
+ *		could start from. This is normally the last block in this=20
+ *		group. The search will end when we found the start of next=20
+ *		possiblereservable space is out of this boundary.
+ *		This could handle the cross bounday reservation window request.
+ *
+ * 	basically we search from the given range, rather than the whole
+ * 	reservation double linked list, (start_block, last_block)=20
+ * 	to find a free region that of of my size and has not=20
+ * 	been reserved.
+ * =09
+ *	on succeed, it returns the reservation window to be append to.
+ *	failed, return NULL.
+ */
+static inline=20
+struct reserve_window* find_next_reservable_window(
+				struct reserve_window *search_head,
+				struct reserve_window *fs_rsv_head,
+			unsigned long size, int *start_block,
+				int last_block)
+{
+	struct reserve_window *rsv;
+	int cur;
+=09
+	/* TODO:make the start of the reservation window byte alligned */
+	/*cur =3D *start_block & 8;*/
+	cur =3D *start_block;
+	rsv =3D list_entry(search_head->rsv_list.next, struct reserve_window, rsv=
_list);
+	while (rsv !=3D fs_rsv_head) {
+		if (cur + size <=3D rsv->rsv_start) {
+	 		/*
+			 * found a reserable space big enough
+			 * we could have a reservation cross
+			 * the group boundary here
+		 	 */
+			break;
+		}
+		if (cur <=3D rsv->rsv_end)=20
+			cur =3D rsv->rsv_end + 1;
+
+		/* TODO? =20
+		 * in the case we could not find a reservable space
+		 * that is what is expected, during the research, we could
+		 * remember what's the largest reservable space we could have
+		 * and return that on.
+		 *
+		 * for now it will fail if we could not find the reservable
+		 * space with expected-size (or more)...
+		 */
+		rsv =3D list_entry(rsv->rsv_list.next, struct reserve_window, rsv_list);
+		if (cur > last_block)
+			return NULL;		/* fail */
+	}
+	/*=20
+	 * we come here either :
+	 * when we rearch to the end of the whole list,
+	 * and there is empty reservable space after last entry in the list.
+	 * append it to the end of the list.
+	 *
+	 * or we found one reservable space in the middle of the list,
+	 * return the reservation window that we could append to.
+	 * succeed.
+	 */
+	*start_block =3D cur;
+	return list_entry(rsv->rsv_list.prev, struct reserve_window, rsv_list);
+}
+
+/**
+ * 	alloc_new_reservation()--allocate a new reservation window
+ *		if there is an existing reservation, discard it first
+ *		then allocate the new one from there
+ *		otherwise allocate the new reservation from the given
+ *		start block, or the beginning of the group, if a goal
+ *		is not given.
+ *
+ *		To make a new reservation, we search part of the filesystem
+ *		reservation list(the list that inside the group).
+ *=09
+ *		If we have a old reservation, the search goal is the end of
+ *		last reservation. If we do not have a old reservatio, then we
+ *		start from a given goal, or the first block of the group, if
+ *		the goal is not given.
+ *	=09
+ *		We first find a reservable space after the goal, then from=20
+ *		there,we check the bitmap for the first free block after
+ *		it. If there is no free block until the end of group, then the=20
+ *		whole group is full, we failed. Otherwise, check if the free block
+ *		is inside the expected reservable space, if so, we succeed.
+ *		If the first free block is outside the reseravle space, then
+ *		start from the first free block, we search for next avalibale
+ *		space, and go on.
+ *
+ *	on succeed, a new reservation will be found and inserted into the list
+ *	It contains at least one free block, and it is not overlap with other
+ *	reservation window.
+ *
+ *	failed: we failed to found a reservation window in this group
+ *=09
+ *	@rsv: the reservation
+ *
+ *	@goal: The goal.  It is where the search for a=20
+ *		free reservable space should start from.
+ *		if we have a old reservation, start_block is the end of
+ *		old reservation. Otherwise,
+ *		if we have a goal(goal >0 ), then start from there,
+ *		no goal(goal =3D -1), we start from the first block=20
+ *		of the group.
+ *
+ *	@sb: the super block
+ *	@group: the group we are trying to do allocate in
+ *	@bitmap_bh: the block group block bitmap
+ */
+static int alloc_new_reservation(struct reserve_window *my_rsv,=20
+		int goal, struct super_block *sb,
+		unsigned int group, struct buffer_head *bitmap_bh)
+{
+	struct reserve_window *search_head;
+	int group_first_block, group_end_block, start_block;
+	int first_free_block;
+	int reservable_space_start;
+	struct reserve_window *prev_rsv;
+	struct reserve_window *fs_rsv_head =3D &EXT3_SB(sb)->s_rsv_window_head;
+	unsigned long size;
+
+	group_first_block =3D le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) =
+=20
+				group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_end_block =3D group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+
+	if (goal < 0)
+		start_block =3D group_first_block;
+	else
+		start_block =3D goal + group_first_block;
+
+	size =3D my_rsv->rsv_goal_size;
+	/* if we have a old reservation, discard it first */
+	if (!rsv_is_empty(my_rsv)) {
+		/*
+		 * if the old reservation is cross group boundary
+		 * we will come here when we just failed to allocate from
+		 * the first part of the window. We still have another part
+		 * that belongs to the next group. In this case, there is no=20
+		 * point to discard our window and try to allocate a new one
+		 * in this group(which will fail). we should
+		 * keep the reservation window, just simply move on.
+		 *
+		 * Maybe we could shift the start block of the reservation window
+		 * to the first block of next group...
+		 */
+	=09
+		if ((my_rsv->rsv_start <=3D group_end_block) && (my_rsv->rsv_end > group=
_end_block))
+			return -1;
+
+		/* remember where we are before we discard the old one */
+		if (my_rsv->rsv_end + 1 > start_block)
+			start_block =3D my_rsv->rsv_end + 1;
+		search_head =3D list_entry(my_rsv->rsv_list.prev,=20
+				struct reserve_window, rsv_list);
+		rsv_window_remove(my_rsv);
+	}
+	else {
+		/*
+		 * we don't have a reservation,=20
+		 * we set our goal(start_block) and=20
+		 * the list head for the search
+		 */=20
+		search_head =3D fs_rsv_head;
+	}
+=09
+	/*
+	 * find_next_reservable_window() simply find a reservable window=20
+	 * inside the given range(start_block, group_end_block).=20
+	 *
+	 * To make sure the reservation window has a free bit inside it, we need
+	 * to check the bitmap after we found a reservable window.
+	 */
+retry:
+	prev_rsv =3D find_next_reservable_window(search_head, fs_rsv_head, size,=20
+						&start_block, group_end_block);
+	if (prev_rsv =3D=3D NULL)
+		goto failed;
+	reservable_space_start =3D start_block;
+	/*
+	 * on succeed, find_next_reservable_window() returns the=20
+	 * reservation window where there is a reservable space after it.
+	 * Before we reserve this reservable space, we need=20
+	 * to make sure there is at least a free block inside this region.
+	 *
+	 * searching the first free bit on the block bitmap and copy of
+	 * last committed bitmap alternatively, until we found a allocatable=20
+	 * block. Search start from the start block of the reservable space=20
+	 * we just found.
+	 */
+	first_free_block =3D bitmap_search_next_usable_block(
+			reservable_space_start - group_first_block,
+			bitmap_bh, group_end_block - group_first_block + 1);
+=09
+	if (first_free_block < 0) {
+		/*
+		 * no free block left on the bitmap, no point
+		 * to reserve the space. return failed.
+		 */
+		goto failed;
+	}
+	start_block =3D first_free_block + group_first_block;
+	/*
+	 * check if the first free block is within the=20
+	 * free space we just found
+	 */
+	if ((start_block >=3D reservable_space_start) &&
+	  (start_block < reservable_space_start + size))
+		goto found_rsv_window;
+	/*
+	 * if the first free bit we found is out of the reservable space
+	 * this means there is no free block on the reservable space
+	 * we should continue search for next reservable space,=20
+	 * start from where the free block is,
+	 * we also shift the list head to where we stopped last time
+	 */
+	search_head =3D prev_rsv;
+	goto retry;
+
+found_rsv_window:
+	/*=20
+	 * great! the reservable space contains some free blocks.
+	 * Insert it to the list.
+	 */
+	rsv_window_add(my_rsv, prev_rsv);
+	my_rsv->rsv_start =3D reservable_space_start;
+	my_rsv->rsv_end =3D my_rsv->rsv_start + size - 1;
+	return 0;		/* succeed */
+failed:
+	return -1;		/* failed */
+}
+/*
+ *	This is the main function used to allocate a new block and=20
+ *	it's reservation window.
+ *	each time when a new block allocation is need, first try to allocate
+ * 	from it's own reservation.
+ *	If it does not have a reservation window, instead of looking
+ *	for a free bit on bitmap first, then look up the reservation list to se=
e if
+ * 	it is inside somebody else's reservation window,
+ *	we try to allocate a reservation window for it start from the goal firs=
t.=20
+ *	Then do the block allocation within the reservation window.
+ *=20
+ *	This will aviod keep searching the reservation list again and again
+ *	when someboday is looking for a free block(without reservation),=20
+ *	and there are lots of free blocks, but they are all being reserved
+ *
+ *	We use a sorted double linked list for the per-filesystem reservation l=
ist.
+ *	The insert, remove and find a free space(non-reserved) operations for t=
he=20
+ *	sorted double linked list should be fast.
+ *
+ */
+static int
+ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
+			unsigned int group, struct buffer_head *bitmap_bh,=20
+			int goal, struct reserve_window * my_rsv,
+			int *errp)
+{
+	spinlock_t *rsv_lock;
+	unsigned long group_first_block;
+	int ret =3D 0;
+	int fatal;
+	int credits =3D 0;
+
+	*errp =3D 0;
+=09
+	/*
+	 * Make sure we use undo access for the bitmap, because it is critical
+	 * that we do the frozen_data COW on bitmap buffers in all cases even
+	 * if the buffer is in BJ_Forget state in the committing transaction.
+	 */
+	BUFFER_TRACE(bitmap_bh, "get undo access for new block");
+	fatal =3D ext3_journal_get_undo_access(handle, bitmap_bh, &credits);
 	if (fatal) {
 		*errp =3D fatal;
-		goto fail;
+		return -1;
+	}
+
+#ifdef EXT3_RESERVATION
+	rsv_lock =3D &EXT3_SB(sb)->s_rsv_window_lock;
+	/*=20
+	 * goal is a group relative block number (if there is a goal)
+	 * 0 < goal < EXT3_BLOCKS_PER_GROUP(sb)
+	 * first block is a filesystem wide block number
+	 * first block is the block number of the first block in this group
+	 */
+	group_first_block =3D le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) =
+=20
+			group * EXT3_BLOCKS_PER_GROUP(sb);
+
+	/*
+	 * Basically we will allocate a new block from inode's reservation window=
.
+	 *
+	 * We need to allocate a new reservation window, if:
+	 * a) inode does not have a reservation window; or
+	 * b) last attemp of allocating a block from existing reservation failed;=
 or
+	 * c) we come here with a goal and with a reservation window
+	 *=20
+	 * we do not need to allocate a new reservation window if
+	 * we come here at the beginning with a goal and the goal is inside the w=
indow, or
+	 * or we don't have a goal but already have a reservation window.
+	 * then we could go to allocate from the reservation window directly.
+	 */
+	while (1) {
+		if (rsv_is_empty(my_rsv) || (ret < 0) ||
+			!goal_in_my_reservation(my_rsv, goal, group, sb)) {
+			spin_lock(rsv_lock);
+			ret =3D alloc_new_reservation(my_rsv, goal, sb, group, bitmap_bh);
+			spin_unlock(rsv_lock);
+			if (ret < 0)
+				break;			/* failed */
+
+			if (!goal_in_my_reservation(my_rsv, goal, group, sb)) {
+				goal =3D -1;
+			}
+		}
+		ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,=20
+					my_rsv);
+		if (ret >=3D 0)
+			break;				/* succeed */
+	}
+#else
+	ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+#endif
+
+	if (ret >=3D 0) {
+		BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
+		fatal =3D ext3_journal_dirty_metadata(handle, bitmap_bh);
+		if (fatal) {
+			*errp =3D fatal;
+			return -1;
+		}
+		return ret;
 	}
-	return goal;
=20
-fail_access:
 	BUFFER_TRACE(bitmap_bh, "journal_release_buffer");
 	ext3_journal_release_buffer(handle, bitmap_bh, credits);
-fail:
-	return -1;
+	return ret;
 }
=20
 /*
@@ -489,6 +938,7 @@ ext3_new_block(handle_t *handle, struct=20
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
+	struct reserve_window *my_rsv =3D &EXT3_I(inode)->i_rsv_window;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -539,8 +989,8 @@ ext3_new_block(handle_t *handle, struct=20
 		bitmap_bh =3D read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block =3D ext3_try_to_allocate(sb, handle, group_no,
-					bitmap_bh, ret_block, &fatal);
+		ret_block =3D ext3_try_to_allocate_with_rsv(sb, handle, group_no,
+					bitmap_bh, ret_block, my_rsv, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >=3D 0)
@@ -568,8 +1018,8 @@ ext3_new_block(handle_t *handle, struct=20
 		bitmap_bh =3D read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block =3D ext3_try_to_allocate(sb, handle, group_no,
-						bitmap_bh, -1, &fatal);
+		ret_block =3D ext3_try_to_allocate_with_rsv(sb, handle, group_no,
+					bitmap_bh, -1, my_rsv, &fatal);	=09
 		if (fatal)
 			goto out;
 		if (ret_block >=3D 0)=20
diff -urNp -X dontdiff 264-rsv-cleanup/fs/ext3/file.c 264-rsv-cleanup-base/=
fs/ext3/file.c
--- 264-rsv-cleanup/fs/ext3/file.c	2004-04-06 01:49:11.000000000 -0700
+++ 264-rsv-cleanup-base/fs/ext3/file.c	2004-04-06 02:25:44.000000000 -0700
@@ -33,6 +33,8 @@
  */
 static int ext3_release_file (struct inode * inode, struct file * filp)
 {
+	if (filp->f_mode & FMODE_WRITE)
+		ext3_discard_reservation(inode);
 	if (is_dx(inode) && filp->private_data)
 		ext3_htree_free_dir_info(filp->private_data);
=20
diff -urNp -X dontdiff 264-rsv-cleanup/fs/ext3/ialloc.c 264-rsv-cleanup-bas=
e/fs/ext3/ialloc.c
--- 264-rsv-cleanup/fs/ext3/ialloc.c	2004-04-06 01:49:11.000000000 -0700
+++ 264-rsv-cleanup-base/fs/ext3/ialloc.c	2004-04-06 01:54:16.000000000 -07=
00
@@ -29,6 +29,7 @@
 #include "xattr.h"
 #include "acl.h"
=20
+
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
  */
@@ -581,6 +582,10 @@ got:
 	ei->i_file_acl =3D 0;
 	ei->i_dir_acl =3D 0;
 	ei->i_dtime =3D 0;
+	ei->i_rsv_window.rsv_start =3D 0;
+	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	ei->i_block_group =3D group;
=20
 	ext3_set_inode_flags(inode);
diff -urNp -X dontdiff 264-rsv-cleanup/fs/ext3/inode.c 264-rsv-cleanup-base=
/fs/ext3/inode.c
--- 264-rsv-cleanup/fs/ext3/inode.c	2004-04-06 01:49:11.000000000 -0700
+++ 264-rsv-cleanup-base/fs/ext3/inode.c	2004-04-06 01:56:16.000000000 -070=
0
@@ -185,6 +185,8 @@ static int ext3_journal_test_restart(han
  */
 void ext3_put_inode(struct inode *inode)
 {
+	if (!is_bad_inode(inode))
+		ext3_discard_reservation(inode);
 }
=20
 /*
@@ -2053,6 +2055,8 @@ void ext3_truncate(struct inode * inode)
 		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
+=09
+	ext3_discard_reservation(inode);
=20
 	/*
 	 * We have to lock the EOF page here, because lock_page() nests
@@ -2446,7 +2450,10 @@ void ext3_read_inode(struct inode * inod
 	ei->i_disksize =3D inode->i_size;
 	inode->i_generation =3D le32_to_cpu(raw_inode->i_generation);
 	ei->i_block_group =3D iloc.block_group;
-
+	ei->i_rsv_window.rsv_start =3D 0;
+	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
diff -urNp -X dontdiff 264-rsv-cleanup/fs/ext3/super.c 264-rsv-cleanup-base=
/fs/ext3/super.c
--- 264-rsv-cleanup/fs/ext3/super.c	2004-04-06 01:49:11.000000000 -0700
+++ 264-rsv-cleanup-base/fs/ext3/super.c	2004-04-06 01:50:03.000000000 -070=
0
@@ -1291,6 +1291,13 @@ static int ext3_fill_super (struct super
 	sbi->s_gdb_count =3D db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
+	/* per fileystem reservation list head & lock */
+	spin_lock_init(&sbi->s_rsv_window_lock);
+	INIT_LIST_HEAD(&sbi->s_rsv_window_head.rsv_list);
+	sbi->s_rsv_window_head.rsv_start =3D 0;
+	sbi->s_rsv_window_head.rsv_end =3D 0;
+	sbi->s_rsv_window_head.rsv_goal_size =3D 0;
+
 	/*
 	 * set up enough so that it can read an inode
 	 */
diff -urNp -X dontdiff 264-rsv-cleanup/include/linux/ext3_fs.h 264-rsv-clea=
nup-base/include/linux/ext3_fs.h
--- 264-rsv-cleanup/include/linux/ext3_fs.h	2004-04-06 01:49:13.000000000 -=
0700
+++ 264-rsv-cleanup-base/include/linux/ext3_fs.h	2004-04-06 01:59:01.000000=
000 -0700
@@ -33,6 +33,11 @@ struct statfs;
 #undef EXT3FS_DEBUG
=20
 /*
+ * Define EXT3_RESERVATION to reserve data blocks for expanding files
+ */
+#define EXT3_RESERVATION
+#define EXT3_DEFAULT_RESERVE_BLOCKS     8
+/*
  * Always enable hashed directories
  */
 #define CONFIG_EXT3_INDEX
@@ -721,6 +726,7 @@ extern void ext3_put_inode (struct inode
 extern void ext3_delete_inode (struct inode *);
 extern int  ext3_sync_inode (handle_t *, struct inode *);
 extern void ext3_discard_prealloc (struct inode *);
+extern void ext3_discard_reservation (struct inode *);
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
diff -urNp -X dontdiff 264-rsv-cleanup/include/linux/ext3_fs_i.h 264-rsv-cl=
eanup-base/include/linux/ext3_fs_i.h
--- 264-rsv-cleanup/include/linux/ext3_fs_i.h	2004-04-06 01:49:13.000000000=
 -0700
+++ 264-rsv-cleanup-base/include/linux/ext3_fs_i.h	2004-04-06 02:00:35.0000=
00000 -0700
@@ -18,8 +18,15 @@
=20
 #include <linux/rwsem.h>
=20
+struct reserve_window{
+	struct list_head 	rsv_list;
+	__u32			rsv_start;
+	__u32			rsv_end;
+	unsigned short		rsv_goal_size;
+};
+
 /*
- * second extended file system inode data in memory
+ * third extended file system inode data in memory
  */
 struct ext3_inode_info {
 	__u32	i_data[15];
@@ -57,6 +64,9 @@ struct ext3_inode_info {
 	 * allocation when we detect linearly ascending requests.
 	 */
 	__u32	i_next_alloc_goal;
+	/* block reservation window */
+	struct reserve_window i_rsv_window;
+
 	__u32	i_dir_start_lookup;
 #ifdef CONFIG_EXT3_FS_XATTR
 	/*
diff -urNp -X dontdiff 264-rsv-cleanup/include/linux/ext3_fs_sb.h 264-rsv-c=
leanup-base/include/linux/ext3_fs_sb.h
--- 264-rsv-cleanup/include/linux/ext3_fs_sb.h	2004-04-06 01:49:13.00000000=
0 -0700
+++ 264-rsv-cleanup-base/include/linux/ext3_fs_sb.h	2004-04-06 01:50:04.000=
000000 -0700
@@ -59,6 +59,10 @@ struct ext3_sb_info {
 	struct percpu_counter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
=20
+	/* head of the per fs reservation window tree */
+	spinlock_t s_rsv_window_lock;
+	struct reserve_window s_rsv_window_head;
+=09
 	/* Journaling */
 	struct inode * s_journal_inode;
 	struct journal_s * s_journal;

--=-LQYm1kXIPvJblTS1CvAI--

