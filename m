Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbUDNAws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUDNAws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:52:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54155 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263843AbUDNAwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:52:10 -0400
Subject: [PATCH 3/4] ext3 block reservation patch set --mount and ioctl
	feature
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
Content-Type: multipart/mixed; boundary="=-fZ4dPUU4UjoBIuASjSdl"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Apr 2004 17:58:53 -0700
Message-Id: <1081904335.4714.6847.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fZ4dPUU4UjoBIuASjSdl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [patch 3]ext3_rsv_mount.patch: Adds features on top of the
> ext3_rsv_base.patch: 
> 	- deal with earlier bogus -ENOSPC error
> 	- do block reservation only for regular file 
> 	- make the ext3 reservation feature as a mount option:
> 		new mount option added: reservation
> 	- A pair of file ioctl commands are added for application to 	control
> the block reservation window size.
> 
diffstat ext3_rsv_mount.patch
 fs/ext3/balloc.c          |   49
++++++++++++++++++++++++++++++++++++----------
 fs/ext3/ialloc.c          |    2 -
 fs/ext3/inode.c           |    2 -
 fs/ext3/ioctl.c           |   23 +++++++++++++++++++++
 fs/ext3/super.c           |   20 ++++++++++++++++--
 include/linux/ext3_fs.h   |   42
++++++++++++++++++++++-----------------
 include/linux/ext3_fs_i.h |    2 -
 7 files changed, 107 insertions(+), 33 deletions(-)


--=-fZ4dPUU4UjoBIuASjSdl
Content-Disposition: attachment; filename=ext3_rsv_mount.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_rsv_mount.patch; charset=UTF-8

diff -urNp 264-rsv-cleanup-base/fs/ext3/balloc.c 264-rsv-cleanup-base-mount=
/fs/ext3/balloc.c
--- 264-rsv-cleanup-base/fs/ext3/balloc.c	2004-04-13 01:42:40.352200376 -07=
00
+++ 264-rsv-cleanup-base-mount/fs/ext3/balloc.c	2004-04-13 01:44:50.0914770=
08 -0700
@@ -707,7 +707,7 @@ static int alloc_new_reservation(struct=20
 	else
 		start_block =3D goal + group_first_block;
=20
-	size =3D my_rsv->rsv_goal_size;
+	size =3D atomic_read(&my_rsv->rsv_goal_size);
 	/* if we have a old reservation, discard it first */
 	if (!rsv_is_empty(my_rsv)) {
 		/*
@@ -853,7 +853,16 @@ ext3_try_to_allocate_with_rsv(struct sup
 		return -1;
 	}
=20
-#ifdef EXT3_RESERVATION
+	/*=20
+	 * we don't deal with reservation when
+	 * filesystem is mounted without reservation
+	 * or the file is not a regular file
+	 * of last attemp of allocating a block with reservation turn on failed
+	 */
+	if (my_rsv =3D=3D NULL ) {
+		ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
+		goto out;
+	}
 	rsv_lock =3D &EXT3_SB(sb)->s_rsv_window_lock;
 	/*=20
 	 * goal is a group relative block number (if there is a goal)
@@ -895,10 +904,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 		if (ret >=3D 0)
 			break;				/* succeed */
 	}
-#else
-	ret =3D ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
-#endif
-
+out:
 	if (ret >=3D 0) {
 		BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
 		fatal =3D ext3_journal_dirty_metadata(handle, bitmap_bh);
@@ -927,7 +933,7 @@ ext3_new_block(handle_t *handle, struct=20
 {
 	struct buffer_head *bitmap_bh =3D NULL;	/* bh */
 	struct buffer_head *gdp_bh;		/* bh2 */
-	int group_no;				/* i */
+	int group_no, goal_group;		/* i */
 	int ret_block;				/* j */
 	int bgi;				/* blockgroup iteration index */
 	int target_block;			/* tmp */
@@ -938,7 +944,7 @@ ext3_new_block(handle_t *handle, struct=20
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
-	struct reserve_window *my_rsv =3D &EXT3_I(inode)->i_rsv_window;
+	struct reserve_window *my_rsv =3D NULL;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -960,7 +966,10 @@ ext3_new_block(handle_t *handle, struct=20
 	sbi =3D EXT3_SB(sb);
 	es =3D EXT3_SB(sb)->s_es;
 	ext3_debug("goal=3D%lu.\n", goal);
-
+#ifdef EXT3_RESERVATION
+	if (test_opt(sb, RESERVATION) && S_ISREG(inode->i_mode))
+		my_rsv =3D &EXT3_I(inode)->i_rsv_window;
+#endif
 	free_blocks =3D percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks =3D le32_to_cpu(es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
@@ -982,6 +991,8 @@ ext3_new_block(handle_t *handle, struct=20
 	if (!gdp)
 		goto io_error;
=20
+	goal_group =3D group_no;
+retry:
 	free_blocks =3D le16_to_cpu(gdp->bg_free_blocks_count);
 	if (free_blocks > 0) {
 		ret_block =3D ((goal - le32_to_cpu(es->s_first_data_block)) %
@@ -1025,7 +1036,25 @@ ext3_new_block(handle_t *handle, struct=20
 		if (ret_block >=3D 0)=20
 			goto allocated;
 	}
-
+#ifdef EXT3_RESERVATION
+	/*=20
+	 * We may end up a bogus ealier ENOSPC error due to
+	 * filesystem is "full" of reservations, but
+	 * there maybe indeed free blocks avaliable on disk
+	 * In this case, we just forget about the reservations
+	 * just do block allocation as without reservations.
+	 */
+	if (my_rsv) {
+#ifdef EXT3_RESERVATION_DEBUG
+		printk("filesystem is full reserved. Actual free blocks is %d. "
+			"Try to do allocation without reservation, goal_group is %d\n",=20
+			free_blocks, goal_group);
+#endif
+		my_rsv =3D NULL;
+		group_no =3D goal_group;
+		goto retry;
+	}
+#endif
 	/* No space left on the device */
 	*errp =3D -ENOSPC;
 	goto out;
diff -urNp 264-rsv-cleanup-base/fs/ext3/ialloc.c 264-rsv-cleanup-base-mount=
/fs/ext3/ialloc.c
--- 264-rsv-cleanup-base/fs/ext3/ialloc.c	2004-04-06 01:54:16.000000000 -07=
00
+++ 264-rsv-cleanup-base-mount/fs/ext3/ialloc.c	2004-04-10 01:19:52.7055037=
44 -0700
@@ -584,7 +584,7 @@ got:
 	ei->i_dtime =3D 0;
 	ei->i_rsv_window.rsv_start =3D 0;
 	ei->i_rsv_window.rsv_end=3D 0;
-	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
 	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	ei->i_block_group =3D group;
=20
diff -urNp 264-rsv-cleanup-base/fs/ext3/inode.c 264-rsv-cleanup-base-mount/=
fs/ext3/inode.c
--- 264-rsv-cleanup-base/fs/ext3/inode.c	2004-04-06 01:56:16.000000000 -070=
0
+++ 264-rsv-cleanup-base-mount/fs/ext3/inode.c	2004-04-10 01:19:52.71250268=
0 -0700
@@ -2452,7 +2452,7 @@ void ext3_read_inode(struct inode * inod
 	ei->i_block_group =3D iloc.block_group;
 	ei->i_rsv_window.rsv_start =3D 0;
 	ei->i_rsv_window.rsv_end=3D 0;
-	ei->i_rsv_window.rsv_goal_size =3D EXT3_DEFAULT_RESERVE_BLOCKS;
+	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
 	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
diff -urNp 264-rsv-cleanup-base/fs/ext3/ioctl.c 264-rsv-cleanup-base-mount/=
fs/ext3/ioctl.c
--- 264-rsv-cleanup-base/fs/ext3/ioctl.c	2004-04-06 00:30:07.000000000 -070=
0
+++ 264-rsv-cleanup-base-mount/fs/ext3/ioctl.c	2004-04-10 01:19:52.71350252=
8 -0700
@@ -20,6 +20,7 @@ int ext3_ioctl (struct inode * inode, st
 {
 	struct ext3_inode_info *ei =3D EXT3_I(inode);
 	unsigned int flags;
+	unsigned short rsv_window_size;
=20
 	ext3_debug ("cmd =3D %u, arg =3D %lu\n", cmd, arg);
=20
@@ -151,6 +152,28 @@ flags_err:
 			return ret;
 		}
 #endif
+#ifdef EXT3_RESERVATION
+	case EXT3_IOC_GETRSVSZ:
+		rsv_window_size =3D atomic_read(&ei->i_rsv_window.rsv_goal_size);
+		return put_user(rsv_window_size, (int *) arg);
+		return 0;
+	case EXT3_IOC_SETRSVSZ:=20
+		{
+			if (IS_RDONLY(inode))
+				return -EROFS;
+
+			if ((current->fsuid !=3D inode->i_uid) && !capable(CAP_FOWNER))
+				return -EACCES;
+
+			if (get_user(rsv_window_size, (int *) arg))
+				return -EFAULT;
+	=09
+			if (rsv_window_size > EXT3_MAX_RESERVE_BLOCKS)
+				rsv_window_size =3D EXT3_MAX_RESERVE_BLOCKS;
+			atomic_set(&ei->i_rsv_window.rsv_goal_size, rsv_window_size);
+			return 0;
+		}
+#endif
 	default:
 		return -ENOTTY;
 	}
diff -urNp 264-rsv-cleanup-base/fs/ext3/super.c 264-rsv-cleanup-base-mount/=
fs/ext3/super.c
--- 264-rsv-cleanup-base/fs/ext3/super.c	2004-04-06 01:50:03.000000000 -070=
0
+++ 264-rsv-cleanup-base-mount/fs/ext3/super.c	2004-04-10 01:19:52.71950161=
6 -0700
@@ -533,7 +533,8 @@ enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_noload,
+	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,=20
+	Opt_reservation, Opt_noreservation, Opt_noload,=20
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_ignore, Opt_err,
@@ -563,6 +564,8 @@ static match_table_t tokens =3D {
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
+	{Opt_reservation, "reservation"},
+	{Opt_noreservation, "noreservation"},
 	{Opt_noload, "noload"},
 	{Opt_commit, "commit=3D%u"},
 	{Opt_journal_update, "journal=3Dupdate"},
@@ -706,6 +709,19 @@ static int parse_options (char * options
 			printk("EXT3 (no)acl options not supported\n");
 			break;
 #endif
+#ifdef EXT3_RESERVATION
+		case Opt_reservation:
+			set_opt(sbi->s_mount_opt, RESERVATION);
+			break;
+		case Opt_noreservation:
+			clear_opt(sbi->s_mount_opt, RESERVATION);
+			break;
+#else
+		case Opt_reservation:
+		case Opt_noreservation:
+			printk("EXT3 block reservation options not supported\n");
+			break;
+#endif
 		case Opt_journal_update:
 			/* @@@ FIXME */
 			/* Eventually we will want to be able to create
@@ -1296,7 +1312,7 @@ static int ext3_fill_super (struct super
 	INIT_LIST_HEAD(&sbi->s_rsv_window_head.rsv_list);
 	sbi->s_rsv_window_head.rsv_start =3D 0;
 	sbi->s_rsv_window_head.rsv_end =3D 0;
-	sbi->s_rsv_window_head.rsv_goal_size =3D 0;
+	atomic_set(&sbi->s_rsv_window_head.rsv_goal_size, 0);
=20
 	/*
 	 * set up enough so that it can read an inode
diff -urNp 264-rsv-cleanup-base/include/linux/ext3_fs.h 264-rsv-cleanup-bas=
e-mount/include/linux/ext3_fs.h
--- 264-rsv-cleanup-base/include/linux/ext3_fs.h	2004-04-06 01:59:01.000000=
000 -0700
+++ 264-rsv-cleanup-base-mount/include/linux/ext3_fs.h	2004-04-13 01:43:53.=
159132040 -0700
@@ -37,6 +37,7 @@ struct statfs;
  */
 #define EXT3_RESERVATION
 #define EXT3_DEFAULT_RESERVE_BLOCKS     8
+#define EXT3_MAX_RESERVE_BLOCKS         1024
 /*
  * Always enable hashed directories
  */
@@ -207,6 +208,10 @@ struct ext3_group_desc
 #ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC_WAIT_FOR_READONLY	_IOR('f', 99, long)
 #endif
+#ifdef EXT3_RESERVATION
+#define EXT3_IOC_GETRSVSZ		_IOR('r', 1, long)
+#define EXT3_IOC_SETRSVSZ		_IOW('r', 2, long)
+#endif
=20
 /*
  * Structure of an inode on the disk
@@ -305,24 +310,25 @@ struct ext3_inode {
 /*
  * Mount flags
  */
-#define EXT3_MOUNT_CHECK		0x0001	/* Do mount-time checks */
-#define EXT3_MOUNT_OLDALLOC		0x0002  /* Don't use the new Orlov allocator =
*/
-#define EXT3_MOUNT_GRPID		0x0004	/* Create files with directory's group */
-#define EXT3_MOUNT_DEBUG		0x0008	/* Some debugging messages */
-#define EXT3_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
-#define EXT3_MOUNT_ERRORS_RO		0x0020	/* Remount fs ro on errors */
-#define EXT3_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
-#define EXT3_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
-#define EXT3_MOUNT_NOLOAD		0x0100	/* Don't use existing journal*/
-#define EXT3_MOUNT_ABORT		0x0200	/* Fatal error detected */
-#define EXT3_MOUNT_DATA_FLAGS		0x0C00	/* Mode for data writes: */
-  #define EXT3_MOUNT_JOURNAL_DATA	0x0400	/* Write data to journal */
-  #define EXT3_MOUNT_ORDERED_DATA	0x0800	/* Flush data before commit */
-  #define EXT3_MOUNT_WRITEBACK_DATA	0x0C00	/* No data ordering */
-#define EXT3_MOUNT_UPDATE_JOURNAL	0x1000	/* Update the journal format */
-#define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
-#define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
-#define EXT3_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
+#define EXT3_MOUNT_CHECK		0x00001	/* Do mount-time checks */
+#define EXT3_MOUNT_OLDALLOC		0x00002  /* Don't use the new Orlov allocator=
 */
+#define EXT3_MOUNT_GRPID		0x00004	/* Create files with directory's group *=
/
+#define EXT3_MOUNT_DEBUG		0x00008	/* Some debugging messages */
+#define EXT3_MOUNT_ERRORS_CONT		0x00010	/* Continue on errors */
+#define EXT3_MOUNT_ERRORS_RO		0x00020	/* Remount fs ro on errors */
+#define EXT3_MOUNT_ERRORS_PANIC		0x00040	/* Panic on errors */
+#define EXT3_MOUNT_MINIX_DF		0x00080	/* Mimics the Minix statfs */
+#define EXT3_MOUNT_NOLOAD		0x00100	/* Don't use existing journal*/
+#define EXT3_MOUNT_ABORT		0x00200	/* Fatal error detected */
+#define EXT3_MOUNT_DATA_FLAGS		0x00C00	/* Mode for data writes: */
+#define EXT3_MOUNT_JOURNAL_DATA		0x00400	/* Write data to journal */
+#define EXT3_MOUNT_ORDERED_DATA		0x00800	/* Flush data before commit */
+#define EXT3_MOUNT_WRITEBACK_DATA	0x00C00	/* No data ordering */
+#define EXT3_MOUNT_UPDATE_JOURNAL	0x01000	/* Update the journal format */
+#define EXT3_MOUNT_NO_UID32		0x02000  /* Disable 32-bit UIDs */
+#define EXT3_MOUNT_XATTR_USER		0x04000	/* Extended user attributes */
+#define EXT3_MOUNT_POSIX_ACL		0x08000	/* POSIX Access Control Lists */
+#define EXT3_MOUNT_RESERVATION		0x10000	/* Preallocation */
=20
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once=
 */
 #ifndef _LINUX_EXT2_FS_H
diff -urNp 264-rsv-cleanup-base/include/linux/ext3_fs_i.h 264-rsv-cleanup-b=
ase-mount/include/linux/ext3_fs_i.h
--- 264-rsv-cleanup-base/include/linux/ext3_fs_i.h	2004-04-06 02:00:35.0000=
00000 -0700
+++ 264-rsv-cleanup-base-mount/include/linux/ext3_fs_i.h	2004-04-10 01:19:5=
2.723501008 -0700
@@ -22,7 +22,7 @@ struct reserve_window{
 	struct list_head 	rsv_list;
 	__u32			rsv_start;
 	__u32			rsv_end;
-	unsigned short		rsv_goal_size;
+	atomic_t		rsv_goal_size;
 };
=20
 /*

--=-fZ4dPUU4UjoBIuASjSdl--

