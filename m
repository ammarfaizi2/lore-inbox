Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUDUX2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUDUX2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 19:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUDUX2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 19:28:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20639 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263019AbUDUX2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 19:28:00 -0400
Subject: [PATCH] Lazy discard ext3 reservation window patch
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040414160714.30e34753.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain>
	<20040402185007.7d41e1a2.akpm@osdl.org>
	<1081903949.3548.6837.camel@localhost.localdomain>
	<20040413194734.3a08c80f.akpm@osdl.org>
	<1081963850.4714.6888.camel@localhost.localdomain> 
	<20040414160714.30e34753.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-NyvryUOx1UD8zlXFst6L"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Apr 2004 16:34:09 -0700
Message-Id: <1082590452.3548.9855.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NyvryUOx1UD8zlXFst6L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

This patch contains several changes against the ext3 reservation code in
265-mm6 tree:

Lazy Discard Reservation Window:
  This patch is trying to do lazy discard: keep the old reservation 
window temporally until we find the new reservation window, only do
remove/add if the new reservation window locate different than the old
one. (The reservation code in mm6 tree will discard the old one first,
then search the new one). Two reasons:
  - If the ext3_find_goal() does a good job, the reservation windows on
the list should not very close to each other.  So a inode's new
reservation window is likely located just next to it's old one, it's
position in the whole list is unchanged, no need to do remove and then
add the new one to the list in the same location. Just update the start
block and end block.
  - If we failed to find a new reservation in the goal group and move on
the search to the next group, having the old reservation around
temporally could allow us to search the list directly after the old
window.  Otherwise we lost where we were and has to start from the
beginning of the list. Eventually the old window will be discard when we
found a new one.

Other changes:
 - Add check to force maximum when dynamically increase window size.
 - ext3_discard_reservation() should not be called on every iput(). Now
it is moved to ext3_delete_inode(), so it is only called on the last
iput() if i_nlink is 0
 - remove #ifdef EXT3_RESERVATION since we made reservation an mount
option
 - Only allow application to modify the file's reservation window size
when fs is mounted with reservation and the operation is performed on
regular files.

This patch should apply to 2.6.5-mm6. Have tested it through many dd
test, untar test,dbench and tiobench.

Thanks!

Mingming

--=-NyvryUOx1UD8zlXFst6L
Content-Disposition: attachment; filename=ext3_reservation_lazydiscard.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_reservation_lazydiscard.patch; charset=UTF-8

diff -urNP -X dontdiff 265-mm6-regression-fix/fs/ext3/balloc.c 265-mm6-fix2=
/fs/ext3/balloc.c
--- 265-mm6-regression-fix/fs/ext3/balloc.c	2004-04-21 18:35:21.916666616 -=
0700
+++ 265-mm6-fix2/fs/ext3/balloc.c	2004-04-21 18:28:47.621608576 -0700
@@ -723,7 +723,7 @@
 		start_block =3D goal + group_first_block;
=20
 	size =3D atomic_read(&my_rsv->rsv_goal_size);
-	/* if we have a old reservation, discard it first */
+	/* if we have a old reservation, start the search from the old rsv */
 	if (!rsv_is_empty(my_rsv)) {
 		/*
 		 * if the old reservation is cross group boundary
@@ -745,8 +745,7 @@
 		/* remember where we are before we discard the old one */
 		if (my_rsv->rsv_end + 1 > start_block)
 			start_block =3D my_rsv->rsv_end + 1;
-		search_head =3D list_entry(my_rsv->rsv_list.prev,
-				struct reserve_window, rsv_list);
+		search_head =3D my_rsv;
 		if ((my_rsv->rsv_alloc_hit > (my_rsv->rsv_end - my_rsv->rsv_start + 1) /=
 2)) {
 			/*
 			 * if we previously allocation hit ration is greater than half
@@ -754,9 +753,10 @@
 			 * otherwise keep the same
 			 */
 			size =3D size * 2;
+			if (size > EXT3_MAX_RESERVE_BLOCKS)
+				size =3D EXT3_MAX_RESERVE_BLOCKS;
 			atomic_set(&my_rsv->rsv_goal_size, size);
 		}
-		rsv_window_remove(my_rsv);
 	}
 	else {
 		/*
@@ -823,9 +823,17 @@
 found_rsv_window:
 	/*
 	 * great! the reservable space contains some free blocks.
-	 * Insert it to the list.
-	 */
-	rsv_window_add(my_rsv, prev_rsv);
+	 *
+	 * if the search returns that we should add the new
+	 * window just next to where the old window, we don't
+	 * need to remove the old window first then add it to the
+	 * same place, just update the new start and new end.
+	 */
+	if (my_rsv !=3D prev_rsv)  {
+		if (!rsv_is_empty(my_rsv))
+			rsv_window_remove(my_rsv);
+		rsv_window_add(my_rsv, prev_rsv);
+	}
 	my_rsv->rsv_start =3D reservable_space_start;
 	my_rsv->rsv_end =3D my_rsv->rsv_start + size - 1;
 	return 0;		/* succeed */
@@ -927,6 +935,10 @@
 			if (!goal_in_my_reservation(my_rsv, goal, group, sb))
 				goal =3D -1;
 		}
+		if ((my_rsv->rsv_start >=3D group_first_block + EXT3_BLOCKS_PER_GROUP(sb=
))
+			|| (my_rsv->rsv_end < group_first_block))
+			BUG();
+
 		ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
 					my_rsv);
 		if (ret >=3D 0)
@@ -996,10 +1008,10 @@
 	sbi =3D EXT3_SB(sb);
 	es =3D EXT3_SB(sb)->s_es;
 	ext3_debug("goal=3D%lu.\n", goal);
-#ifdef EXT3_RESERVATION
+
 	if (test_opt(sb, RESERVATION) && S_ISREG(inode->i_mode))
 		my_rsv =3D &EXT3_I(inode)->i_rsv_window;
-#endif
+
 	free_blocks =3D percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks =3D le32_to_cpu(es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
@@ -1066,7 +1078,6 @@
 		if (ret_block >=3D 0)=20
 			goto allocated;
 	}
-#ifdef EXT3_RESERVATION
 	/*
 	 * We may end up a bogus ealier ENOSPC error due to
 	 * filesystem is "full" of reservations, but
@@ -1075,17 +1086,11 @@
 	 * just do block allocation as without reservations.
 	 */
 	if (my_rsv) {
-#ifdef EXT3_RESERVATION_DEBUG
-		printk("filesystem is fully reserved. Actual free blocks: %d. "
-			"Try to do allocation without reservation, goal_group "
-			"is %d\n",
-			free_blocks, goal_group);
-#endif
 		my_rsv =3D NULL;
 		group_no =3D goal_group;
 		goto retry;
 	}
-#endif
+
 	/* No space left on the device */
 	*errp =3D -ENOSPC;
 	goto out;
diff -urNP -X dontdiff 265-mm6-regression-fix/fs/ext3/inode.c 265-mm6-fix2/=
fs/ext3/inode.c
--- 265-mm6-regression-fix/fs/ext3/inode.c	2004-04-21 18:34:45.393219024 -0=
700
+++ 265-mm6-fix2/fs/ext3/inode.c	2004-04-21 18:21:35.747263456 -0700
@@ -177,19 +177,6 @@
 }
=20
 /*
- * Called at each iput()
- *
- * The inode may be "bad" if ext3_read_inode() saw an error from
- * ext3_get_inode(), so we need to check that to avoid freeing random disk
- * blocks.
- */
-void ext3_put_inode(struct inode *inode)
-{
-	if (!is_bad_inode(inode))
-		ext3_discard_reservation(inode);
-}
-
-/*
  * Called at the last iput() if i_nlink is zero.
  */
 void ext3_delete_inode (struct inode * inode)
@@ -199,6 +186,9 @@
 	if (is_bad_inode(inode))
 		goto no_delete;
=20
+	/* discard the block reservation */
+	ext3_discard_reservation(inode);
+
 	handle =3D start_transaction(inode);
 	if (IS_ERR(handle)) {
 		/* If we're going to skip the normal cleanup, we still
diff -urNP -X dontdiff 265-mm6-regression-fix/fs/ext3/ioctl.c 265-mm6-fix2/=
fs/ext3/ioctl.c
--- 265-mm6-regression-fix/fs/ext3/ioctl.c	2004-04-21 18:34:45.389219632 -0=
700
+++ 265-mm6-fix2/fs/ext3/ioctl.c	2004-04-21 18:22:28.196289992 -0700
@@ -152,11 +152,16 @@
 			return ret;
 		}
 #endif
-#ifdef EXT3_RESERVATION
 	case EXT3_IOC_GETRSVSZ:
-		rsv_window_size =3D atomic_read(&ei->i_rsv_window.rsv_goal_size);
-		return put_user(rsv_window_size, (int *)arg);
+		if (test_opt(inode->i_sb, RESERVATION) && S_ISREG(inode->i_mode)) {
+			rsv_window_size =3D atomic_read(&ei->i_rsv_window.rsv_goal_size);
+			return put_user(rsv_window_size, (int *)arg);
+		}
+		return -ENOTTY;
 	case EXT3_IOC_SETRSVSZ:
+		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
+			return -ENOTTY;
+
 		if (IS_RDONLY(inode))
 			return -EROFS;
=20
@@ -170,7 +175,6 @@
 			rsv_window_size =3D EXT3_MAX_RESERVE_BLOCKS;
 		atomic_set(&ei->i_rsv_window.rsv_goal_size, rsv_window_size);
 		return 0;
-#endif
 	default:
 		return -ENOTTY;
 	}
diff -urNP -X dontdiff 265-mm6-regression-fix/fs/ext3/super.c 265-mm6-fix2/=
fs/ext3/super.c
--- 265-mm6-regression-fix/fs/ext3/super.c	2004-04-21 18:34:45.394218872 -0=
700
+++ 265-mm6-fix2/fs/ext3/super.c	2004-04-21 18:21:35.755262240 -0700
@@ -551,7 +551,6 @@
 	.read_inode	=3D ext3_read_inode,
 	.write_inode	=3D ext3_write_inode,
 	.dirty_inode	=3D ext3_dirty_inode,
-	.put_inode	=3D ext3_put_inode,
 	.delete_inode	=3D ext3_delete_inode,
 	.put_super	=3D ext3_put_super,
 	.write_super	=3D ext3_write_super,
@@ -760,19 +759,12 @@
 			printk("EXT3 (no)acl options not supported\n");
 			break;
 #endif
-#ifdef EXT3_RESERVATION
 		case Opt_reservation:
 			set_opt(sbi->s_mount_opt, RESERVATION);
 			break;
 		case Opt_noreservation:
 			clear_opt(sbi->s_mount_opt, RESERVATION);
 			break;
-#else
-		case Opt_reservation:
-		case Opt_noreservation:
-			printk("EXT3 block reservation options not supported\n");
-			break;
-#endif
 		case Opt_journal_update:
 			/* @@@ FIXME */
 			/* Eventually we will want to be able to create
diff -urNP -X dontdiff 265-mm6-regression-fix/include/linux/ext3_fs.h 265-m=
m6-fix2/include/linux/ext3_fs.h
--- 265-mm6-regression-fix/include/linux/ext3_fs.h	2004-04-21 18:34:43.5464=
99768 -0700
+++ 265-mm6-fix2/include/linux/ext3_fs.h	2004-04-21 18:21:35.769260112 -070=
0
@@ -35,7 +35,6 @@
 /*
  * Define EXT3_RESERVATION to reserve data blocks for expanding files
  */
-#define EXT3_RESERVATION
 #define EXT3_DEFAULT_RESERVE_BLOCKS     8
 #define EXT3_MAX_RESERVE_BLOCKS         1024
 /*
@@ -208,10 +207,8 @@
 #ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC_WAIT_FOR_READONLY	_IOR('f', 99, long)
 #endif
-#ifdef EXT3_RESERVATION
 #define EXT3_IOC_GETRSVSZ		_IOR('r', 1, long)
 #define EXT3_IOC_SETRSVSZ		_IOW('r', 2, long)
-#endif
=20
 /*
  * Structure of an inode on the disk

--=-NyvryUOx1UD8zlXFst6L--

