Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbUC3Iuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbUC3Iuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:50:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:8369 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263511AbUC3Ito (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:49:44 -0500
Subject: [RFC, PATCH] Reservation based ext3 preallocation
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, tytso@mit.edu
Cc: Badari Pulavarty <pbadari@us.ibm.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com
In-Reply-To: <20040321015746.14b3c0dc.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com> 
	<20040321015746.14b3c0dc.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-eFQjQHqaCJ8xWE4vpbNy"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Mar 2004 00:55:23 -0800
Message-Id: <1080636930.3548.4549.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eFQjQHqaCJ8xWE4vpbNy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Andrew, Ted, All,

Ext3 preallocation is currently missing. This is the first cut of the
prototype for the reservation based ext3 preallocation based on the
ideas suggested by Andrew and Ted. The implementation is incomplete, but
I want to hear your valuable opinion about the current design. 

What I have done in this version of prototype:
1)basic reservation structure and operations
2)reservation based ext3 block allocation 
3)and reservation window allocations
4)block allocation when fs reservation is turned off

For 1) Use a sorted double linked list for the per-filesystem
reservation list, like the vm_region does. The operations on double
linked list are abstract so later if necessary we could replace it with
other sohpysicated tree easily. 

Each inode have a reservation structure inside it's ext3_inode_info
structure. Each reservation structure contains(start, end, list_head,
goal_window_size)

For 2) The basic idea is: When we try to allocate a new block for a
inode, if there is a reservation window for it, it will try to do
allocation from there. 

If it does not have a reservation window, we will allocate a block and
make a reservation window for it. Instead of doing the block allocation
first then do the reservation window allocation second, we make the
reservation window first, then allocate a block within the window. The
new reservation window has at least one free block and does not overlap
with other reservation windows. This way we avoid keeping looking up the
reservation list again and again when we found a free bit on bitmap and
not sure if it belongs to any body's reservation window.

For 3) To allocate a new reservation window, we search the part of
filesystem reservation list that fall into the group which we are trying
to allocate a block from. We will have a goal block to guide where we
want the new reservation window start from. If we already have a old
reservation, we will discard it first, then search the part of list that
after the old reservation window. Otherwise the sub-list start from the
beginning of the group. The new reservation window could cross group
boundary. The reservation window has contains at least one free block.

For 4) If the filesystem has reservation turned off, all the code/path
for new block allocation is the same as the current code-- just call
ext3_try_to_allocate() with a NULL reservation window pointer.

Above logic has been verified on a user level simulation program. 
Attached prototype patch (against 2.6.4 kernel) compiles and boots. I
have done initial test of the patch on a 2way PIII 700Mhz box.

Below is the debugfs output after running a simple test. The test has 8
threads sequentially write 20M on different files at the same time, in
the same directory, on a fresh created ext3 filesystem. Basically, after
the apply the patch, the filesystem is much lest fragmented:

before(2.6.4 kernel):

Inode: 12   Type: regular    Mode:  0644   Flags: 0x0   Generation:
3375236196
.....
BLOCKS:
(0):8716, (1):8718, (2):8720, (3):8722, (4):8724, (5):8726, (6):8728,
(7):8730, (8):8732, (9):8734, (10):8736, (11):8738, (IND):8741,
(12):8742, (13):8744, (14):8746, (15):8748, (16):8750, (17):8752,
(18):8754, (19):8756, (20):8758, (21):8760, (22):8762, (23):8764,
(24):8766, (25):8768, (26):8770, (27):8772, (28):8774, (29):8776,
(30):8778, (31):8780, (32):8782, (33):8784, (34):8786, (35):8788,
(36):8790, (37):8792, (38):8794, (39):8796, (40):8798, (41):8800,
(42):8802, (43):8804, (44):8806, (45):8808, (46):8810, (47):8812,
(48):8814, (49):8816, (50):8818, (51):8820, (52):8822, (53):8824,
(54):8826, (55):8828, (56):8830, (57):8832, (58):8834, (59):8836, (6
0):8838, (61):8840, (62):8842, (63):8844, (64):8846, (65):8848,
(66):8850, (67):8852, (68):8854, (69):8856, (70):8858, (71):8860,
(72):8862, (73):8864, (74):8866, (75):8868, (76):8870, (77):8872,
(78):8874, (79):8876, (80):8878, (81):8880,
......
......
......

after apply the patch(reservation window size is 128 blocks):
Inode: 15   Type: regular    Mode:  0644   Flags: 0x0   Generation:
2351221293
......
BLOCKS:
(0-11):24576-24587, (IND):24588, (12-1035):24592-25615, (DIND):25616,
(IND):25624,(1036-2027):25632-26623, (2028-2059):37116-37147,
(IND):37148, (2060-2151):37152-37243, (2152-2279):37372-37499,
(2280-2407):37756-37883, (2408-2535):38012-38139,
(2536-2663):38268-38395, (2664-2791):38524-38651,
(2792-2919):38780-38907, (2920-3083):43132-43295, (IND):43296,
(3084-3167):43304-43387, (3168-3551):43516-43899,
(3552-3679):44028-44155, (3680-3807):44284-44411,
(3808-3935):44540-44667, (3936-4063):44924-45051,
(4064-4107):45180-45223, (IND):45224, (4108-4183):45232-45307, (4184-456
7):45436-45819, (4568-4695):45948-46075, (4696-4823):46204-46331,
(4824-4828):46875-46879, (4829-4956):48380-48507,
(4957-4999):48636-48678

TOTAL: 5006

Things to do:
1) Dynamic increase the reservation window for individual files.
2) Prevent bogus early ENOSPC error when filesystem is being full
reserved.
3) Preserve the reservation window on file/close on some files which
frequently append
4) Play with other tree structures to replace sorted double linked list
for the reservation tree/list if necessary.

Before working on above todos,  I would like to hear you valuable
comments, suggestions, ideas on current design of this reservation based
ext3 preallocation. Patch is attached and against 2.6.4 kernel.

Thanks!

Mingming

diffstat ext3_reservation-7.diff
 fs/ext3/balloc.c           |  485
+++++++++++++++++++++++++++++++++++++++++++--
 fs/ext3/ialloc.c           |    6
 fs/ext3/inode.c            |    9
 fs/ext3/super.c            |    7
 include/linux/ext3_fs.h    |    4
 include/linux/ext3_fs_i.h  |   12 +
 include/linux/ext3_fs_sb.h |    4
 7 files changed, 511 insertions(+), 16 deletions(-)


--=-eFQjQHqaCJ8xWE4vpbNy
Content-Disposition: attachment; filename=ext3_reservation-7.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_reservation-7.diff; charset=UTF-8

diff -urNp linux-2.6.4/fs/ext3/balloc.c 264-rsv-no_debug/fs/ext3/balloc.c
--- linux-2.6.4/fs/ext3/balloc.c	2004-03-10 18:55:21.000000000 -0800
+++ 264-rsv-no_debug/fs/ext3/balloc.c	2004-03-30 07:29:58.559179056 -0800
@@ -96,6 +96,332 @@ read_block_bitmap(struct super_block *sb
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
+#ifdef LATER=20
+static inline void rsv_window_dump(struct reserve_window *head, char *fn)
+{
+	struct reserve_window *rsv;
+	printk("Block Allocation Reservation Windows Map (%s):\n", fn);
+	list_for_each_entry(rsv, &head->rsv_list, rsv_list) {
+		printk("reservation window 0x%x start:  %ld, end:  %ld(%d)\n",
+			 rsv, rsv->rsv_start, rsv->rsv_end,=20
+			rsv->rsv_end-c->rsv_start);
+	}
+}
+#endif
+
+static inline int goal_in_my_reservation(struct reserve_window *rsv, int g=
oal)
+{
+	return ((goal >=3D rsv->rsv_start) && (goal <=3D rsv->rsv_end));
+}
+
+/*
+ * find if the given block is within any reservation on the list
+ */
+static inline int rsv_window_find(struct reserve_window *start, int block,=
 int last_block)
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
+static inline void rsv_window_add(struct reserve_window *rsv, struct reser=
ve_window *prev)
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
+	spinlock_t * rsv_lock =3D &EXT3_SB(inode->i_sb)->s_rsv_window_lock;
+
+		if (!rsv_is_empty(rsv)) {
+			spin_lock(rsv_lock);
+			rsv_window_remove(rsv);
+			spin_unlock(rsv_lock);
+		}
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
+ *	@fs_rsv_head: per-filesystem reservation list head
+ *=09
+ * 	@size: the target new reservation window size
+ * 	@group_first_block: the first block we consider to start the real sear=
ch from
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
+				struct reserve_window *search_head,=20
+				struct reserve_window *fs_rsv_head,=20
+				int size, int *start_block, int last_block)
+{
+	struct reserve_window *rsv;
+	int cur;
+=09
+	/* TODO: make the start of the reservation window byte alligned */
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
+			goto found;
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
+			goto out;
+	}
+found:=09
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
+out:
+	return NULL;			/* failed */
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
+ *	@start_block: The goal.  It is where the search for a=20
+ *		free reservable space should start from.
+ *		if we have a old reservation, start_block is the end of
+ *		old reservation. Otherwise,
+ *		if we have a goal(start_block >0 ), then start from there,
+ *		no goal(start_block =3D -1-, we start from the first block=20
+ *		of the group.
+ *
+ *	@sb: the super block
+ *	@group: the group we are trying to do allocate in
+ *	@bitmap_bh: the block group block bitmap
+ */
+static int alloc_new_reservation(struct reserve_window *my_rsv, int start_=
block,
+		struct super_block *sb, int group, struct buffer_head *bitmap_bh)
+{
+	struct reserve_window *search_head;
+	int group_first_block, group_end_block, first_free_block;
+	int reservable_space_start;
+	struct reserve_window *prev_rsv;
+	struct reserve_window *fs_rsv_head =3D &EXT3_SB(sb)->s_rsv_window_head;
+	int size;
+
+	group_first_block =3D le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) =
+=20
+				group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_end_block =3D group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+
+	if (start_block < 0)
+		start_block =3D 0;
+	start_block +=3D group_first_block;
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
+	if (prev_rsv =3D=3D NULL)
+		goto failed;
+=09
+	reservable_space_start =3D start_block;
+	/*
+	 * on succeed, find_next_reservable_window() returns the=20
+	 * reservation window where there is a reservable space after it.
+	 * Before we reserve this reservable space, we need=20
+	 * to make sure there is at least a free block inside this region.
+	 *
+	 * searching the first free bit on the block bitmap, start from
+	 * the start block of the reservable space we just found.
+	 */
+	first_free_block =3D ext3_find_next_zero_bit(bitmap_bh->b_data,=20
+				group_end_block - group_first_block + 1,=20
+				reservable_space_start - group_first_block);
+	if (first_free_block < 0)
+		/*
+		 * no free block left on the bitmap, no point
+		 * to reserve the space. return failed.
+		 */
+		goto failed;
+
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
=20
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks (handle_t *handle, struct inode * inode,
@@ -407,11 +733,12 @@ claim_block(spinlock_t *lock, int block,
  */
 static int
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-		struct buffer_head *bitmap_bh, int goal, int *errp)
+				struct buffer_head *bitmap_bh, int goal,
+				struct reserve_window * my_rsv, int *errp)
 {
-	int i;
 	int fatal;
 	int credits =3D 0;
+	int group_first_block, start, end;
=20
 	*errp =3D 0;
=20
@@ -426,26 +753,49 @@ ext3_try_to_allocate(struct super_block=20
 		*errp =3D fatal;
 		goto fail;
 	}
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
+	}
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
@@ -466,6 +816,118 @@ fail:
 }
=20
 /*
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
+			int group, struct buffer_head *bitmap_bh,=20
+			int goal, struct reserve_window * my_rsv,int *errp)
+{
+	spinlock_t *rsv_lock;
+	int group_first_block;
+	int ret;
+#ifdef EXT3_RESERVATION=09
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
+	/*=20
+	 * if we don't have a reservation, get a reservation first
+	 * then try to allocation from the reservation
+	 */
+	if (rsv_is_empty(my_rsv)) {
+		spin_lock(rsv_lock);
+		ret =3D alloc_new_reservation(my_rsv, goal, sb, group, bitmap_bh);
+		spin_unlock(rsv_lock);
+		if (ret < 0)
+			/*
+			 * alloc_new_reservation() failed when there is
+			 * no "free" window for reservation in this group
+			 * from the start point.
+			 * In that case, we should move onto next group
+			 */
+			return -1;
+		if (!goal_in_my_reservation(my_rsv, goal))
+			goal =3D -1;
+		goto alloc_from_rsv;
+	}
+	/*=20
+	 * we already have a reservation
+	 * if we come here with a goal, and the goal is inside the reservation
+	 * then try to allocate from the reservation, start from the goal
+	 * if we donot have a goal here,
+	 * then try to allocate from reservation, start from the beginning
+	 */
+	if ((goal < 0 ) || (goal_in_my_reservation(my_rsv, goal+group_first_block=
)))
+		goto alloc_from_rsv;
+
+	/*
+	 * here, we have a reservation, but our goal is outside of the
+	 * reservation, we should discard the reservation,=20
+	 * get a new reservation based on the goal,=20
+	 * then try to allocate from the new reservation.
+	 *
+	 * there is another way to deal with this case,
+	 * we could keep the old reservation, give up the goal,
+	 * try to allocate from the old reservation
+	 * in the normal case, we already allocated all blocks=20
+	 * in our reservation, going back may just waste of time
+	 * and also, the goal already indicate that the reservation
+	 * window is out-dated. so...
+	 */=09
+	spin_lock(rsv_lock);
+	ret =3D alloc_new_reservation(my_rsv, goal, sb, group, bitmap_bh);
+	spin_unlock(rsv_lock);
+	if (ret < 0)
+		return -1;
+	goal =3D -1;
+
+alloc_from_rsv:=09
+	ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,=20
+					my_rsv, errp);
+	if (ret < 0) {
+		spin_lock(rsv_lock);
+		ret =3D alloc_new_reservation(my_rsv, goal, sb, group, bitmap_bh);
+		spin_unlock(rsv_lock);
+
+		if (ret < 0 )
+			return -1;
+
+		goal =3D -1;
+		goto alloc_from_rsv;
+	}
+	/*=20
+	 * okey, we successfully allocate a block from my reservation
+	 */
+	return ret;			/* succeed */
+#else
+	return ext3_try_to_allocate(sb, handle, group, bitmap, goal, NULL, errp);
+#endif
+}
+
+/*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
  * is allocated.  Otherwise a forward search is made for a free block; wit=
hin=20
@@ -490,6 +952,7 @@ ext3_new_block(handle_t *handle, struct=20
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
+	struct reserve_window *my_rsv =3D &EXT3_I(inode)->i_rsv_window;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -540,8 +1003,8 @@ ext3_new_block(handle_t *handle, struct=20
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
@@ -569,8 +1032,8 @@ ext3_new_block(handle_t *handle, struct=20
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
diff -urNp linux-2.6.4/fs/ext3/ialloc.c 264-rsv-no_debug/fs/ext3/ialloc.c
--- linux-2.6.4/fs/ext3/ialloc.c	2004-03-10 18:55:27.000000000 -0800
+++ 264-rsv-no_debug/fs/ext3/ialloc.c	2004-03-29 19:42:06.664888408 -0800
@@ -585,6 +585,12 @@ got:
 	ei->i_prealloc_block =3D 0;
 	ei->i_prealloc_count =3D 0;
 #endif
+#ifdef EXT3_RESERVATION
+	ei->i_rsv_window.rsv_start =3D 0;
+	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
+#endif
 	ei->i_block_group =3D group;
=20
 	ext3_set_inode_flags(inode);
diff -urNp linux-2.6.4/fs/ext3/inode.c 264-rsv-no_debug/fs/ext3/inode.c
--- linux-2.6.4/fs/ext3/inode.c	2004-03-10 18:55:35.000000000 -0800
+++ 264-rsv-no_debug/fs/ext3/inode.c	2004-03-29 19:42:06.672887192 -0800
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
diff -urNp linux-2.6.4/fs/ext3/super.c 264-rsv-no_debug/fs/ext3/super.c
--- linux-2.6.4/fs/ext3/super.c	2004-03-10 18:55:44.000000000 -0800
+++ 264-rsv-no_debug/fs/ext3/super.c	2004-03-29 19:42:06.677886432 -0800
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
diff -urNp linux-2.6.4/include/linux/ext3_fs.h 264-rsv-no_debug/include/lin=
ux/ext3_fs.h
--- linux-2.6.4/include/linux/ext3_fs.h	2004-03-10 18:55:33.000000000 -0800
+++ 264-rsv-no_debug/include/linux/ext3_fs.h	2004-03-30 07:42:26.299505248 =
-0800
@@ -37,7 +37,8 @@ struct statfs;
  */
 #undef  EXT3_PREALLOCATE /* @@@ Fix this! */
 #define EXT3_DEFAULT_PREALLOC_BLOCKS	8
-
+#define EXT3_RESERVATION
+#define EXT3_DEFAULT_RESERVE_BLOCKS	8
 /*
  * Always enable hashed directories
  */
@@ -728,6 +729,7 @@ extern void ext3_put_inode (struct inode
 extern void ext3_delete_inode (struct inode *);
 extern int  ext3_sync_inode (handle_t *, struct inode *);
 extern void ext3_discard_prealloc (struct inode *);
+extern void ext3_discard_reservation (struct inode *);
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
diff -urNp linux-2.6.4/include/linux/ext3_fs_i.h 264-rsv-no_debug/include/l=
inux/ext3_fs_i.h
--- linux-2.6.4/include/linux/ext3_fs_i.h	2004-03-10 18:55:21.000000000 -08=
00
+++ 264-rsv-no_debug/include/linux/ext3_fs_i.h	2004-03-29 19:42:06.68188582=
4 -0800
@@ -18,8 +18,15 @@
=20
 #include <linux/rwsem.h>
=20
+struct reserve_window{
+	struct list_head 	rsv_list;
+	__u32			rsv_start;
+	__u32			rsv_end;
+	int			rsv_goal_size;
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
diff -urNp linux-2.6.4/include/linux/ext3_fs_sb.h 264-rsv-no_debug/include/=
linux/ext3_fs_sb.h
--- linux-2.6.4/include/linux/ext3_fs_sb.h	2004-03-10 18:55:44.000000000 -0=
800
+++ 264-rsv-no_debug/include/linux/ext3_fs_sb.h	2004-03-29 19:42:06.6828856=
72 -0800
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

--=-eFQjQHqaCJ8xWE4vpbNy--

