Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUDNAsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbUDNAsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:48:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55480 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263625AbUDNAsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:48:07 -0400
Subject: [PATCH 1/4] ext3 block reservation patch set -- ext3 preallocation
	cleanup
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
Content-Type: multipart/mixed; boundary="=-a53Lf3WqcQcY1+7Fpp6V"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Apr 2004 17:54:51 -0700
Message-Id: <1081904093.4714.6840.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a53Lf3WqcQcY1+7Fpp6V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [patch 1]ext3_rsv_cleanup.patch: Cleans up the old ext3 preallocation
> code carried from ext2 but turned off.

diffstat ext3_rsv_cleanup.patch
 fs/ext3/balloc.c          |    3 -
 fs/ext3/file.c            |    2 -
 fs/ext3/ialloc.c          |    4 --
 fs/ext3/inode.c           |   91
----------------------------------------------
 fs/ext3/xattr.c           |    2 -
 include/linux/ext3_fs.h   |    9 ----
 include/linux/ext3_fs_i.h |    4 --
 7 files changed, 4 insertions(+), 111 deletions(-)



--=-a53Lf3WqcQcY1+7Fpp6V
Content-Disposition: attachment; filename=ext3_rsv_cleanup.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_rsv_cleanup.patch; charset=UTF-8

diff -urNp linux-2.6.4/fs/ext3/balloc.c 264-rsv-cleanup/fs/ext3/balloc.c
--- linux-2.6.4/fs/ext3/balloc.c	2004-03-10 18:55:21.000000000 -0800
+++ 264-rsv-cleanup/fs/ext3/balloc.c	2004-04-06 01:13:25.560544680 -0700
@@ -474,8 +474,7 @@ fail:
  * This function also updates quota and i_blocks field.
  */
 int
-ext3_new_block(handle_t *handle, struct inode *inode, unsigned long goal,
-		u32 *prealloc_count, u32 *prealloc_block, int *errp)
+ext3_new_block(handle_t *handle, struct inode *inode, unsigned long goal, =
int *errp)
 {
 	struct buffer_head *bitmap_bh =3D NULL;	/* bh */
 	struct buffer_head *gdp_bh;		/* bh2 */
diff -urNp linux-2.6.4/fs/ext3/file.c 264-rsv-cleanup/fs/ext3/file.c
--- linux-2.6.4/fs/ext3/file.c	2004-03-10 18:55:49.000000000 -0800
+++ 264-rsv-cleanup/fs/ext3/file.c	2004-04-06 01:12:49.136082040 -0700
@@ -33,8 +33,6 @@
  */
 static int ext3_release_file (struct inode * inode, struct file * filp)
 {
-	if (filp->f_mode & FMODE_WRITE)
-		ext3_discard_prealloc (inode);
 	if (is_dx(inode) && filp->private_data)
 		ext3_htree_free_dir_info(filp->private_data);
=20
diff -urNp linux-2.6.4/fs/ext3/ialloc.c 264-rsv-cleanup/fs/ext3/ialloc.c
--- linux-2.6.4/fs/ext3/ialloc.c	2004-03-10 18:55:27.000000000 -0800
+++ 264-rsv-cleanup/fs/ext3/ialloc.c	2004-04-06 01:09:26.834836504 -0700
@@ -581,10 +581,6 @@ got:
 	ei->i_file_acl =3D 0;
 	ei->i_dir_acl =3D 0;
 	ei->i_dtime =3D 0;
-#ifdef EXT3_PREALLOCATE
-	ei->i_prealloc_block =3D 0;
-	ei->i_prealloc_count =3D 0;
-#endif
 	ei->i_block_group =3D group;
=20
 	ext3_set_inode_flags(inode);
diff -urNp linux-2.6.4/fs/ext3/inode.c 264-rsv-cleanup/fs/ext3/inode.c
--- linux-2.6.4/fs/ext3/inode.c	2004-03-10 18:55:35.000000000 -0800
+++ 264-rsv-cleanup/fs/ext3/inode.c	2004-04-06 01:13:44.307694680 -0700
@@ -185,8 +185,6 @@ static int ext3_journal_test_restart(han
  */
 void ext3_put_inode(struct inode *inode)
 {
-	if (!is_bad_inode(inode))
-		ext3_discard_prealloc(inode);
 }
=20
 /*
@@ -244,62 +242,12 @@ no_delete:
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
=20
-void ext3_discard_prealloc (struct inode * inode)
-{
-#ifdef EXT3_PREALLOCATE
-	struct ext3_inode_info *ei =3D EXT3_I(inode);
-	/* Writer: ->i_prealloc* */
-	if (ei->i_prealloc_count) {
-		unsigned short total =3D ei->i_prealloc_count;
-		unsigned long block =3D ei->i_prealloc_block;
-		ei->i_prealloc_count =3D 0;
-		ei->i_prealloc_block =3D 0;
-		/* Writer: end */
-		ext3_free_blocks (inode, block, total);
-	}
-#endif
-}
-
 static int ext3_alloc_block (handle_t *handle,
 			struct inode * inode, unsigned long goal, int *err)
 {
 	unsigned long result;
=20
-#ifdef EXT3_PREALLOCATE
-#ifdef EXT3FS_DEBUG
-	static unsigned long alloc_hits, alloc_attempts;
-#endif
-	struct ext3_inode_info *ei =3D EXT3_I(inode);
-	/* Writer: ->i_prealloc* */
-	if (ei->i_prealloc_count &&
-	    (goal =3D=3D ei->i_prealloc_block ||
-	     goal + 1 =3D=3D ei->i_prealloc_block))
-	{
-		result =3D ei->i_prealloc_block++;
-		ei->i_prealloc_count--;
-		/* Writer: end */
-		ext3_debug ("preallocation hit (%lu/%lu).\n",
-			    ++alloc_hits, ++alloc_attempts);
-	} else {
-		ext3_discard_prealloc (inode);
-		ext3_debug ("preallocation miss (%lu/%lu).\n",
-			    alloc_hits, ++alloc_attempts);
-		if (S_ISREG(inode->i_mode))
-			result =3D ext3_new_block (inode, goal,=20
-				 &ei->i_prealloc_count,
-				 &ei->i_prealloc_block, err);
-		else
-			result =3D ext3_new_block (inode, goal, 0, 0, err);
-		/*
-		 * AKPM: this is somewhat sticky.  I'm not surprised it was
-		 * disabled in 2.2's ext3.  Need to integrate b_committed_data
-		 * guarding with preallocation, if indeed preallocation is
-		 * effective.
-		 */
-	}
-#else
-	result =3D ext3_new_block (handle, inode, goal, 0, 0, err);
-#endif
+	result =3D ext3_new_block (handle, inode, goal, err);
 	return result;
 }
=20
@@ -966,38 +914,6 @@ struct buffer_head *ext3_bread(handle_t=20
 	bh =3D ext3_getblk (handle, inode, block, create, err);
 	if (!bh)
 		return bh;
-#ifdef EXT3_PREALLOCATE
-	/*
-	 * If the inode has grown, and this is a directory, then use a few
-	 * more of the preallocated blocks to keep directory fragmentation
-	 * down.  The preallocated blocks are guaranteed to be contiguous.
-	 */
-	if (create &&
-	    S_ISDIR(inode->i_mode) &&
-	    inode->i_blocks > prev_blocks &&
-	    EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
-				    EXT3_FEATURE_COMPAT_DIR_PREALLOC)) {
-		int i;
-		struct buffer_head *tmp_bh;
-
-		for (i =3D 1;
-		     EXT3_I(inode)->i_prealloc_count &&
-		     i < EXT3_SB(inode->i_sb)->s_es->s_prealloc_dir_blocks;
-		     i++) {
-			/*
-			 * ext3_getblk will zero out the contents of the
-			 * directory for us
-			 */
-			tmp_bh =3D ext3_getblk(handle, inode,
-						block+i, create, err);
-			if (!tmp_bh) {
-				brelse (bh);
-				return 0;
-			}
-			brelse (tmp_bh);
-		}
-	}
-#endif
 	if (buffer_uptodate(bh))
 		return bh;
 	ll_rw_block (READ, 1, &bh);
@@ -2138,8 +2054,6 @@ void ext3_truncate(struct inode * inode)
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
=20
-	ext3_discard_prealloc(inode);
-
 	/*
 	 * We have to lock the EOF page here, because lock_page() nests
 	 * outside journal_start().
@@ -2531,9 +2445,6 @@ void ext3_read_inode(struct inode * inod
 	}
 	ei->i_disksize =3D inode->i_size;
 	inode->i_generation =3D le32_to_cpu(raw_inode->i_generation);
-#ifdef EXT3_PREALLOCATE
-	ei->i_prealloc_count =3D 0;
-#endif
 	ei->i_block_group =3D iloc.block_group;
=20
 	/*
diff -urNp linux-2.6.4/fs/ext3/xattr.c 264-rsv-cleanup/fs/ext3/xattr.c
--- linux-2.6.4/fs/ext3/xattr.c	2004-03-10 18:55:28.000000000 -0800
+++ 264-rsv-cleanup/fs/ext3/xattr.c	2004-04-06 01:14:03.397792544 -0700
@@ -787,7 +787,7 @@ ext3_xattr_set_handle2(handle_t *handle,
 				EXT3_I(inode)->i_block_group *
 				EXT3_BLOCKS_PER_GROUP(sb);
 			int block =3D ext3_new_block(handle,
-				inode, goal, 0, 0, &error);
+				inode, goal, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
diff -urNp linux-2.6.4/include/linux/ext3_fs.h 264-rsv-cleanup/include/linu=
x/ext3_fs.h
--- linux-2.6.4/include/linux/ext3_fs.h	2004-03-10 18:55:33.000000000 -0800
+++ 264-rsv-cleanup/include/linux/ext3_fs.h	2004-04-06 01:15:11.343463232 -=
0700
@@ -33,12 +33,6 @@ struct statfs;
 #undef EXT3FS_DEBUG
=20
 /*
- * Define EXT3_PREALLOCATE to preallocate data blocks for expanding files
- */
-#undef  EXT3_PREALLOCATE /* @@@ Fix this! */
-#define EXT3_DEFAULT_PREALLOC_BLOCKS	8
-
-/*
  * Always enable hashed directories
  */
 #define CONFIG_EXT3_INDEX
@@ -680,8 +674,7 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long,
-					    __u32 *, __u32 *, int *);
+extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int =
*);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern unsigned long ext3_count_free_blocks (struct super_block *);
diff -urNp linux-2.6.4/include/linux/ext3_fs_i.h 264-rsv-cleanup/include/li=
nux/ext3_fs_i.h
--- linux-2.6.4/include/linux/ext3_fs_i.h	2004-03-10 18:55:21.000000000 -08=
00
+++ 264-rsv-cleanup/include/linux/ext3_fs_i.h	2004-04-06 00:38:28.684318320=
 -0700
@@ -57,10 +57,6 @@ struct ext3_inode_info {
 	 * allocation when we detect linearly ascending requests.
 	 */
 	__u32	i_next_alloc_goal;
-#ifdef EXT3_PREALLOCATE
-	__u32	i_prealloc_block;
-	__u32	i_prealloc_count;
-#endif
 	__u32	i_dir_start_lookup;
 #ifdef CONFIG_EXT3_FS_XATTR
 	/*

--=-a53Lf3WqcQcY1+7Fpp6V--

