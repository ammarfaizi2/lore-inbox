Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUDCBki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDCBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:40:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:49608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261528AbUDCBjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:39:25 -0500
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
	preallocation
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net
In-Reply-To: <20040330014523.6a368a69.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain> 
	<20040330014523.6a368a69.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-inuzF0buoNhtf/FQR9lB"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Apr 2004 17:45:10 -0800
Message-Id: <1080956712.15980.6505.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-inuzF0buoNhtf/FQR9lB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,
Here is the second version of the ext3, mostly bug fixes and made the
changes you have suggested last time.  

It's a stable version now.  We have done overnight fsx tests on a 2 CPU
PIII 700MHz box, did not see any issues. We also run tiobench and untar
tests.

> - Please use u32 for block numbers everywhere.
I tried to make the changes as you suggested: use u32 for block numbers
everywhere.  Then hit a problem: sometimes, especially when doing block
allocation or find a free block on bitmap, on success, it returns the
block number, on fail, it returns -1 to indicate the failure.  I found
we can't use the u32 for those cases. ext3_new_block() and
ext3_free_block() did the same thing.  So I just did wherever I could to
make a block number from int to u32, and keep it int if it also means
failure in the fail case. Hmm...Is there any good way to do this?

>  You should search both bitmaps to find a block
>   which really is allocatable.  Otherwise you'll have
>   ext3_try_to_allocate() failing 20,000 times in succession and much CPU
>   will be burnt.
Done. 

> - I suspect ext3_try_to_allocate_with_rsv() could be reorganised a bit to
>   reduce the goto spaghetti?
Re-organized.  Merged conditions together and put them into a single loop.  Now it does not contains any goto :-) See if the code looks clean and now...

> - Please provide a mount option which enables the feature, defaulting to
>   "off".
Planning to do right after this version. Besides enable/disable the
reservation feature, I am thinking to enable the feature that could set
the the default reservation window size(in blocks) when the fs is
mounted.   just one single mount option:"prealloc_window=n". When n=0,
it means turns off, when n>0, it means on, and the ext3 default
reservation window size for each file is n blocks(or 8 blocks, if 0< n <
8).
 
> - Make sure that you have a many-small-file test.  Say, untar a kernel
>   tree onto a clean filesystem and make sure that reading all the files in
>   the tree is nice and fast.
Yes, have done this: untar linux-2.6.4 kernel tree to a clean ext3
filesystem. Verified the reservation is being discarded and the small
files are contiguous on-disk.

> Apart from that, looking good.  Where are the benchmarks? ;)
One simple dd test, it's 4 times faster with the patch on a 2 way PIII
700Mhz box:

# cat /tmp/dd-large.sh
dd if=/dev/zero of=x1 bs=4k count=5000 &
dd if=/dev/zero of=x2 bs=4k count=5000 &
dd if=/dev/zero of=x3 bs=4k count=5000 &
dd if=/dev/zero of=x4 bs=4k count=5000 &
dd if=/dev/zero of=x5 bs=4k count=5000 &
dd if=/dev/zero of=x6 bs=4k count=5000 &
dd if=/dev/zero of=x7 bs=4k count=5000 &
dd if=/dev/zero of=x8 bs=4k count=5000 &
elm3b92:/mnt # time /tmp/dd-large.sh

# time /tmp/dd-large.sh
real    0m0.431s
user    0m0.001s
sys     0m0.009s

linux-2.6.4 kernel + ext3 reservation patch, window size 128 blocks:
# time /tmp/dd-large.sh
real    0m0.098s
user    0m0.001s
sys     0m0.009s

We also did tiobench sequential write tests on ext2, jfs and ext3 on
different number of threads(1,4,8,16,32 and 64), block size is 4k, file
size is 4000k.  For ext3, we tried different reservation size from 8 to
128 blocks, as well as without any reservation.  The test was done on a
8CPU PIII 700 i386 machine with 4G memory, on linux-2.6.4 kernel+patch
and linux2.6.4-mm1 kernel.  

Attached is a graphic file show the tiobench results. It shows that
before the patch, the sequential write throughput on ext3 is pretty bad
compare with ext2 and jfs; with the patch, it's much better. And the
block allocation on disk for the files created is much less fragmented.

Planning to do dbench and other regression test later. Just what to
share with you the current status. 

Patch attached below.

Thanks!
Mingming

fs/ext3/balloc.c           |  581
+++++++++++++++++++++++++++++++++++++++++----
 fs/ext3/file.c             |    3
 fs/ext3/ialloc.c           |    6
 fs/ext3/inode.c            |   14 -
 fs/ext3/super.c            |    7
 include/linux/ext3_fs.h    |    3
 include/linux/ext3_fs_i.h  |   12
 include/linux/ext3_fs_sb.h |    4
 8 files changed, 578 insertions(+), 52 deletions(-)


--=-inuzF0buoNhtf/FQR9lB
Content-Disposition: attachment; filename=ext3_reservation_9.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_reservation_9.diff; charset=UTF-8

diff -urNp linux-2.6.4/fs/ext3/balloc.c 264-rsv/fs/ext3/balloc.c
--- linux-2.6.4/fs/ext3/balloc.c	2004-03-10 18:55:21.000000000 -0800
+++ 264-rsv/fs/ext3/balloc.c	2004-04-02 02:33:00.327572528 -0800
@@ -96,6 +96,96 @@ read_block_bitmap(struct super_block *sb
 error_out:
 	return bh;
 }
+#define EXT3_RESERVATION_DEBUG2
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
+static inline int goal_in_my_reservation(struct reserve_window *rsv, unsig=
ned long goal)
+{
+	return ((goal >=3D rsv->rsv_start) && (goal <=3D rsv->rsv_end));
+}
+
+/*
+ * find if the given block is within any reservation on the list
+ */
+static inline int rsv_window_find(struct reserve_window *start,=20
+			unsigned long block, unsigned long last_block)
+{
+	struct reserve_window *rsv;
+
+	list_for_each_entry(rsv, &start->rsv_list, rsv_list) {
+		if (goal_in_my_reservation(rsv, block))
+			return 1;		/* found it*/
+		if (rsv->rsv_start > last_block)
+			return 0;
+	}
+	return 0;
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
+#ifdef EXT3_RESERVATION_DEBUG
+	printk(KERN_DEBUG "Reservation Window is removed:"
+		"  0x%p start:  %d, end:  %d \n", rsv, rsv->rsv_start,
+		rsv->rsv_end);
+#endif
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
+#ifdef EXT3_RESERVATION_DEBUG
+	printk(KERN_DEBUG "ext3_discard_reservation:"
+		"  0x%p start:  %d, end:  %d \n", rsv, rsv->rsv_start,
+		rsv->rsv_end);
+#endif
+=09
+	if (!rsv_is_empty(rsv)) {
+		spin_lock(rsv_lock);
+		rsv_window_remove(rsv);
+		spin_unlock(rsv_lock);
+	}
+}
=20
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks (handle_t *handle, struct inode * inode,
@@ -313,6 +403,33 @@ static inline int ext3_test_allocatable(
 	return ret;
 }
=20
+static inline int
+bitmap_search_next_usable_block(unsigned long start, struct buffer_head *b=
h,=20
+					unsigned long maxblocks)
+{
+	unsigned long next;
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
@@ -325,7 +442,6 @@ find_next_usable_block(int start, struct
 {
 	int here, next;
 	char *p, *r;
-	struct journal_head *jh =3D bh2jh(bh);
=20
 	if (start > 0) {
 		/*
@@ -359,19 +475,8 @@ find_next_usable_block(int start, struct
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
@@ -407,62 +512,445 @@ claim_block(spinlock_t *lock, int block,
  */
 static int
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-		struct buffer_head *bitmap_bh, int goal, int *errp)
+		struct buffer_head *bitmap_bh, int goal, struct reserve_window * my_rsv)
 {
-	int i;
-	int fatal;
-	int credits =3D 0;
-
-	*errp =3D 0;
+	unsigned long group_first_block, start, end;
=20
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
+	/* if EXT3_RESERVATION */
+	if (my_rsv) {
+		group_first_block =3D=20
+			le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +=20
+			group * EXT3_BLOCKS_PER_GROUP(sb);
+		if (my_rsv->rsv_start >=3D group_first_block)
+			start =3D my_rsv->rsv_start - group_first_block;
+		else
+			/* reservation window cross group boundary */
+			start =3D group_first_block;
+		end =3D my_rsv->rsv_end - group_first_block;
+		if (end > EXT3_BLOCKS_PER_GROUP(sb))
+			/* reservation window cross group boundary */
+			end =3D EXT3_BLOCKS_PER_GROUP(sb);
+	}
+	else {
+		if (goal > 0)
+			start =3D goal;
+		else
+			start =3D 0;
+		end =3D EXT3_BLOCKS_PER_GROUP(sb);
 	}
=20
 repeat:
 	if (goal < 0 || !ext3_test_allocatable(goal, bitmap_bh)) {
-		goal =3D find_next_usable_block(goal, bitmap_bh,
-					EXT3_BLOCKS_PER_GROUP(sb));
+		goal =3D find_next_usable_block(start, bitmap_bh, end);
 		if (goal < 0)
 			goto fail_access;
=20
-		for (i =3D 0; i < 7 && goal > 0 &&
+		/*for (i =3D 0; i < 7 && goal > 0 &&
 				ext3_test_allocatable(goal - 1, bitmap_bh);
 			i++, goal--);
+                 */
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
+		start++;
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
+			unsigned short size, unsigned long *start_block,
+				unsigned long last_block)
+{
+	struct reserve_window *rsv;
+	unsigned long cur;
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
+	unsigned long group_first_block, group_end_block, start_block;
+	int first_free_block;
+	int reservable_space_start;
+	struct reserve_window *prev_rsv;
+	struct reserve_window *fs_rsv_head =3D &EXT3_SB(sb)->s_rsv_window_head;
+	unsigned short size;
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
+		if (my_rsv->rsv_end >=3D group_end_block)
+			return -1;
+
+		/* remember where we are before we discard the old one */
+		if (my_rsv->rsv_end + 1 > start_block)
+			start_block =3D my_rsv->rsv_end + 1;
+		search_head =3D list_entry(my_rsv->rsv_list.prev,=20
+				struct reserve_window, rsv_list);
+=09
+#ifdef EXT3_RESERVATION_DEBUG
+		printk(KERN_DEBUG "Reservation Window is removed from alloc_new_"
+			"  0x%p start:  %d, end:  %d \n", my_rsv, my_rsv->rsv_start,
+			my_rsv->rsv_end);
+#endif
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
+	size =3D my_rsv->rsv_goal_size;
+retry:
+	prev_rsv =3D find_next_reservable_window(search_head, fs_rsv_head, size,=20
+						&start_block, group_end_block);
+	if (prev_rsv =3D=3D NULL){
+#ifdef EXT3_RESERVATION_DEBUG
+		printk(KERN_DEBUG "NO WINDOW. start_block %d, group_end_block %d,"
+				"search_head %p, fs_rsv_head %p\n",=20
+				start_block, group_end_block, search_head,=20
+				fs_rsv_head);
+#endif
+		goto failed;
+	}=09
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
+#ifdef EXT3_RESERVATION_DEBUG
+		printk(KERN_DEBUG "group_first_block %d, group_end_block %d,"
+			" reservable_space_start %d\n", group_first_block,
+			group_end_block, reservable_space_start);
+#endif
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
+#ifdef EXT3_RESERVATION_DEBUG
+	printk(KERN_DEBUG "New reservation window allocated:"
+		"  0x%p start:  %d, end:  %d \n", my_rsv, my_rsv->rsv_start,
+		my_rsv->rsv_end);
+	rsv_window_dump(fs_rsv_head, "alloc_new_reservation");
+#endif
+
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
 	}
-	return goal;
=20
-fail_access:
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
+			((goal >=3D 0) && !goal_in_my_reservation(my_rsv, goal+group_first_bloc=
k))) {
+			spin_lock(rsv_lock);
+			ret =3D alloc_new_reservation(my_rsv, goal, sb, group, bitmap_bh);
+			spin_unlock(rsv_lock);
+			if (ret < 0)
+				break;			/* failed */
+
+			if ((goal > 0) && !goal_in_my_reservation(my_rsv, goal+group_first_bloc=
k))
+				goal =3D -1;
+		}
+
+		ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,=20
+					my_rsv);
+		if (ret >=3D 0)
+			break;				/* succeed */
+	}
+#else
+	ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+#endif
+=09
+	if (ret >=3D 0) {
+		BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
+		fatal =3D ext3_journal_dirty_metadata(handle, bitmap_bh);
+		if (fatal) {
+			*errp =3D fatal;
+			return -1;
+		}
+		return ret;
+	}
+	return ret;
+
 	BUFFER_TRACE(bitmap_bh, "journal_release_buffer");
 	ext3_journal_release_buffer(handle, bitmap_bh, credits);
-fail:
-	return -1;
+	return ret;
 }
=20
 /*
@@ -490,6 +978,7 @@ ext3_new_block(handle_t *handle, struct=20
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
+	struct reserve_window *my_rsv =3D &EXT3_I(inode)->i_rsv_window;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -540,8 +1029,8 @@ ext3_new_block(handle_t *handle, struct=20
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
@@ -569,8 +1058,8 @@ ext3_new_block(handle_t *handle, struct=20
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
diff -urNp linux-2.6.4/fs/ext3/file.c 264-rsv/fs/ext3/file.c
--- linux-2.6.4/fs/ext3/file.c	2004-03-10 18:55:49.000000000 -0800
+++ 264-rsv/fs/ext3/file.c	2004-03-30 18:21:30.463306312 -0800
@@ -34,7 +34,8 @@
 static int ext3_release_file (struct inode * inode, struct file * filp)
 {
 	if (filp->f_mode & FMODE_WRITE)
-		ext3_discard_prealloc (inode);
+		ext3_discard_reservation(inode);
+		/*ext3_discard_prealloc (inode);*/
 	if (is_dx(inode) && filp->private_data)
 		ext3_htree_free_dir_info(filp->private_data);
=20
diff -urNp linux-2.6.4/fs/ext3/ialloc.c 264-rsv/fs/ext3/ialloc.c
--- linux-2.6.4/fs/ext3/ialloc.c	2004-03-10 18:55:27.000000000 -0800
+++ 264-rsv/fs/ext3/ialloc.c	2004-04-02 22:26:48.615417624 -0800
@@ -29,6 +29,7 @@
 #include "xattr.h"
 #include "acl.h"
=20
+
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
  */
@@ -585,6 +586,11 @@ got:
 	ei->i_prealloc_block =3D 0;
 	ei->i_prealloc_count =3D 0;
 #endif
+	ei->i_rsv_window.rsv_start =3D 0;
+	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
+=09
 	ei->i_block_group =3D group;
=20
 	ext3_set_inode_flags(inode);
diff -urNp linux-2.6.4/fs/ext3/inode.c 264-rsv/fs/ext3/inode.c
--- linux-2.6.4/fs/ext3/inode.c	2004-03-10 18:55:35.000000000 -0800
+++ 264-rsv/fs/ext3/inode.c	2004-04-02 22:26:58.250952800 -0800
@@ -186,7 +186,9 @@ static int ext3_journal_test_restart(han
 void ext3_put_inode(struct inode *inode)
 {
 	if (!is_bad_inode(inode))
-		ext3_discard_prealloc(inode);
+=09
+		ext3_discard_reservation(inode);
+	/*	ext3_discard_prealloc(inode); */
 }
=20
 /*
@@ -2137,8 +2139,9 @@ void ext3_truncate(struct inode * inode)
 		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
-
-	ext3_discard_prealloc(inode);
+=09
+	ext3_discard_reservation(inode);
+	/* ext3_discard_prealloc(inode); */
=20
 	/*
 	 * We have to lock the EOF page here, because lock_page() nests
@@ -2535,7 +2538,10 @@ void ext3_read_inode(struct inode * inod
 	ei->i_prealloc_count =3D 0;
 #endif
 	ei->i_block_group =3D iloc.block_group;
-
+	ei->i_rsv_window.rsv_start =3D 0;
+	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
diff -urNp linux-2.6.4/fs/ext3/super.c 264-rsv/fs/ext3/super.c
--- linux-2.6.4/fs/ext3/super.c	2004-03-10 18:55:44.000000000 -0800
+++ 264-rsv/fs/ext3/super.c	2004-03-29 17:22:18.539077360 -0800
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
diff -urNp linux-2.6.4/include/linux/ext3_fs.h 264-rsv/include/linux/ext3_f=
s.h
--- linux-2.6.4/include/linux/ext3_fs.h	2004-03-10 18:55:33.000000000 -0800
+++ 264-rsv/include/linux/ext3_fs.h	2004-04-02 22:26:23.335260792 -0800
@@ -37,6 +37,8 @@ struct statfs;
  */
 #undef  EXT3_PREALLOCATE /* @@@ Fix this! */
 #define EXT3_DEFAULT_PREALLOC_BLOCKS	8
+#define EXT3_RESERVATION
+#define EXT3_DEFAULT_RESERVE_BLOCKS	8
=20
 /*
  * Always enable hashed directories
@@ -728,6 +730,7 @@ extern void ext3_put_inode (struct inode
 extern void ext3_delete_inode (struct inode *);
 extern int  ext3_sync_inode (handle_t *, struct inode *);
 extern void ext3_discard_prealloc (struct inode *);
+extern void ext3_discard_reservation (struct inode *);
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
diff -urNp linux-2.6.4/include/linux/ext3_fs_i.h 264-rsv/include/linux/ext3=
_fs_i.h
--- linux-2.6.4/include/linux/ext3_fs_i.h	2004-03-10 18:55:21.000000000 -08=
00
+++ 264-rsv/include/linux/ext3_fs_i.h	2004-03-30 18:39:30.556107248 -0800
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
@@ -61,6 +68,9 @@ struct ext3_inode_info {
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
 #endif
+	/* block reservation window */
+	struct reserve_window i_rsv_window;
+
 	__u32	i_dir_start_lookup;
 #ifdef CONFIG_EXT3_FS_XATTR
 	/*
diff -urNp linux-2.6.4/include/linux/ext3_fs_sb.h 264-rsv/include/linux/ext=
3_fs_sb.h
--- linux-2.6.4/include/linux/ext3_fs_sb.h	2004-03-10 18:55:44.000000000 -0=
800
+++ 264-rsv/include/linux/ext3_fs_sb.h	2004-03-29 17:22:18.544076600 -0800
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

--=-inuzF0buoNhtf/FQR9lB
Content-Disposition: attachment; filename=Throughput.png
Content-Type: image/png; name=Throughput.png
Content-Transfer-Encoding: base64

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
x+MAUqkUAMMwACiKksvlNE2LRqPpdDqdTuvrtXzIQVyqqpZ2E9GBbAS6iXR6fyh0euhJ74OpFMJh
JBLuWFoi2hRvN9VIWSc1pTihah4IARoQBpTiV4R11B1OAaY97W4qECoORUkW21BixfEp0eIQWb04
fkqmuZOJd5NrD1Jnu3oISHlmKQWgrf0ldMeqbLo9JQUoxbnIvCfYLfL5fH5tnf+NGzca/iqtDhyW
ZUWj0Ww268YLFOs53H0SiUQ6nc5ms5t/Gee1it+l0zLt11BgYGb50uj2kaHAAABFQSbDCcGImkyy
iHfmA5k0yfTUe7sjYoxiS3y6ONaAnwfan1plIqzY2htzSRhNFCOFvFdrdc+mVV4nHllvLMb8Bs+o
5CUUIAVwSoWtCdiVmjOaxDCMYDBoWZau65lMRqk+03ggEABQu2yBwDqFj8cRCkHLAleiKLyK3/1d
AFO3LkzdvHBy4NjagkFVOfE5UTvJexJJBFCBoGcC1vYZ6UfUjfbu3RuLxY4fP97AY7Z0lEo4HLYs
KxQK5XI5b9pw+4palgUgmUwC0LbczqFpMGXuRTWC+XkYBoDDOw6V9B4tls1TI0JEvtOBSPFDsFSD
54BEcZYFEQWCQNwzL2SWE70TtanWBY5sNitjX7PZbMADgHS8ME1zeHg4EAhIz4zYlifn0jQYBqAD
tzXs3OkOSnly4IlTS0+V7JlIMHMQdQLN018kVUwh7igDBTCKc00CMIuJJL528S0iarnWBQ7pGVqR
qqq5XM7tIqppWiaTCYVC9R666mFhmsUR2J//vNtZY3/fyNF7Hi/ZWTLHlvuNEJGvpCtiotjcrhYT
iTubtSy0EQWixakaTE4uQtQKrQsciUTlUUTyqK7r7jjY6enpracN4bTbSP9kT+/Q8f4DV1bmCvaS
d2dNQ4QNw0RdyZ14W7o3SgdA6aIo7xIyuYhEEMMzuQhn62meYBBBzyJp6TQmJhAIIBDA8DDCYR+6
9Fcrg2UhGsXwsLM9GmV9+CZ01+Jt1UjX99u38elP44MflG2XV+amrp8v6T0KIJ9HNssF3oh6huKJ
I0KGS8hQXrdeJApoxQGcieKj4ApeW+Adh2maiEaBYtW0ZSGbhWUht+6cXI1TowzxONzpKC3L+Z73
iQ1qaafR1lMU5POABuSBD3wAH/mI+1C13qO6Dk1DvCvWAiaizVM88767TTMZz+QQlmdGSAB5IFpc
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

--=-inuzF0buoNhtf/FQR9lB--

