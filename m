Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267099AbUBFADo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267100AbUBFADo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:03:44 -0500
Received: from www.trustcorps.com ([213.165.226.2]:45584 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S267099AbUBFADN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:03:13 -0500
Message-ID: <4022D921.9090402@hcunix.net>
Date: Fri, 06 Feb 2004 00:00:33 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Valdis.Kletnieks@vt.edu, Bill Davidsen <davidsen@tmr.com>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <20040204062936.GA2663@thunk.org> <4020EEB0.50002@hcunix.net> <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu> <20040205033511.GA4452@thunk.org>
In-Reply-To: <20040205033511.GA4452@thunk.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070708020007080208020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708020007080208020002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I've update the secure delete patch to now check

is_secure_delete(inode)

to see if either the chattr +s bit is set, or if the superblock has 
EXT2FS_MOUNT_SECRM (which I've added) set.

I believe I've correctly modified the super.c to support a "secrm" mount 
option, but I haven't tested it so I can't say for sure. That is to say 
it compiles, but I haven't tried to run it. This rev of the patch is to 
see if the direction (and logic) of the secure delete functionality is 
in line with what people are thinking.

There is some complexity around directory files. If a directory file has 
chattr +s set, then any directory entry within that file will be erased 
when the entry is removed. If a file has chattr +s set, or the fs was 
mounted with SECRM then the directory entry is removed. I would like 
people to pay particular attention to this part of the patch, its the 
area I'm least confident with.

A directory entry's rec_len is preserved, in case we are removing the 
first entry for a directory block.

The rest of the patch is basicly unchanged from the previous patchs. I 
haven't done a patch for ext3, when this one is agreed on then I'll it 
port acroos to ext3.


peace,

--gq

--------------070708020007080208020002
Content-Type: text/x-troff-man;
 name="secrm_ext2-2.6.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="secrm_ext2-2.6.2"

--- linux-2.6.2/include/linux/ext2_fs.h	2004-02-04 03:43:12.000000000 +0000
+++ linux-2.6.2/include/linux/ext2_fs.h-secrm	2004-02-05 22:08:59.000000000 +0000
@@ -310,6 +310,7 @@
 #define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
 #define EXT2_MOUNT_NOBH			0x0100	/* No buffer_heads */
 #define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
+#define	EXT2_MOUNT_SECRM		0x0400  /* Securely delete files */
 #define EXT2_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
 #define EXT2_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
 
--- linux-2.6.2/fs/ext2/balloc.c	2004-02-04 03:43:42.000000000 +0000
+++ linux-2.6.2/fs/ext2-secrm/balloc.c	2004-02-05 21:02:10.000000000 +0000
@@ -173,6 +173,21 @@
 	}
 }
 
+static inline void delete_block(struct super_block *sb, unsigned long block)
+{
+	struct buffer_head	* bh;
+
+	bh = sb_getblk(sb, block);
+
+	memset(bh->b_data, 0, bh->b_size);
+
+	mark_buffer_dirty(bh);
+	wait_on_buffer(bh); /* XXX is this necessary? */
+	brelse(bh);
+
+	return;
+}
+
 /* Free given blocks, update quota and i_blocks field */
 void ext2_free_blocks (struct inode * inode, unsigned long block,
 		       unsigned long count)
@@ -240,8 +255,11 @@
 			ext2_error (sb, "ext2_free_blocks",
 				      "bit already cleared for block %lu",
 				      block + i);
-		else
+		else {
+			if (is_secure_delete(inode))
+				delete_block(inode->i_sb, block + i);
 			group_freed++;
+		}
 	}
 
 	mark_buffer_dirty(bitmap_bh);
--- linux-2.6.2/fs/ext2/dir.c	2004-02-04 03:43:56.000000000 +0000
+++ linux-2.6.2/fs/ext2-secrm/dir.c	2004-02-05 22:01:00.000000000 +0000
@@ -530,6 +530,7 @@
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
+	struct inode *dino;
 	char *kaddr = page_address(page);
 	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
 	unsigned to = ((char*)dir - kaddr) + le16_to_cpu(dir->rec_len);
@@ -555,9 +556,24 @@
 		BUG();
 	if (pde)
 		pde->rec_len = cpu_to_le16(to-from);
-	dir->inode = 0;
+
+	dino = iget(inode->i_sb, dir->inode);
+	if (!dino || (!is_secure_delete(dino) && !is_secure_delete(inode))) {
+		dir->inode = 0;
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	} else {
+		unsigned short rec_len = dir->rec_len;
+
+		memset(dir, 0, dir->rec_len);
+		dir->rec_len = rec_len;
+	}
+
+	if (dino)
+		iput(dino);
+
 	err = ext2_commit_chunk(page, from, to);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+
+ 	/* XXX should this be in the if (!is_secure_delete()) above? */
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
 out:
--- linux-2.6.2/fs/ext2/ext2.h	2004-02-05 20:46:40.000000000 +0000
+++ linux-2.6.2/fs/ext2-secrm/ext2.h	2004-02-05 20:45:25.000000000 +0000
@@ -79,6 +79,16 @@
 	return container_of(inode, struct ext2_inode_info, vfs_inode);
 }
 
+static inline int is_secure_delete(struct inode *inode)
+{
+	/* expanded for readibility */
+	if (EXT2_I(inode)->i_flags & EXT2_SECRM_FL)
+		return 1;
+	if (test_opt(inode->i_sb, SECRM))
+		return 1;
+	return 0;
+}
+
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
--- linux-2.6.2/fs/ext2/inode.c	2004-02-04 03:43:09.000000000 +0000
+++ linux-2.6.2/fs/ext2-secrm/inode.c	2004-02-05 22:18:56.000000000 +0000
@@ -64,6 +64,36 @@
 		ext2_discard_prealloc(inode);
 }
 
+static inline void delete_inode(struct inode *inode)
+{
+	if (!is_secure_delete(inode))
+		EXT2_I(inode)->i_dtime = get_seconds();
+	else {
+		inode->i_mode   = 0;
+		inode->i_uid    = 0;
+		inode->i_gid    = 0;
+		inode->i_nlink  = 0;
+		inode->i_atime.tv_sec  = 0;
+		inode->i_atime.tv_nsec  = 0;
+		inode->i_ctime.tv_sec  = 0;
+		inode->i_ctime.tv_nsec  = 0;
+		inode->i_mtime.tv_sec  = 0;
+		inode->i_mtime.tv_nsec  = 0;
+		EXT2_I(inode)->i_dtime = 0;
+		EXT2_I(inode)->i_faddr = 0;
+		EXT2_I(inode)->i_frag_no       = 0;
+		EXT2_I(inode)->i_frag_size     = 0;
+		EXT2_I(inode)->i_file_acl      = 0;
+		inode->i_generation     = 0;
+	}
+}
+
+static inline void delete_blocks(struct inode *inode)
+{
+	inode->i_blocks = 0;
+	memset(EXT2_I(inode)->i_data, 0, sizeof(EXT2_I(inode)->i_data));
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -71,13 +101,21 @@
 {
 	if (is_bad_inode(inode))
 		goto no_delete;
-	EXT2_I(inode)->i_dtime	= get_seconds();
+	delete_inode(inode);
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, inode_needs_sync(inode));
 
 	inode->i_size = 0;
 	if (inode->i_blocks)
 		ext2_truncate (inode);
+
+	if (is_secure_delete(inode)) {
+		EXT2_I(inode)->i_flags = 0;
+
+		delete_blocks(inode);
+		mark_inode_dirty(inode);
+		ext2_update_inode(inode, inode_needs_sync(inode));
+	}
 	ext2_free_inode (inode);
 
 	return;
--- linux-2.6.2/fs/ext2/super.c	2004-02-04 03:44:04.000000000 +0000
+++ linux-2.6.2/fs/ext2-secrm/super.c	2004-02-05 22:04:17.000000000 +0000
@@ -270,7 +270,7 @@
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov, Opt_nobh,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
+	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_secrm,
 	Opt_ignore, Opt_err,
 };
 
@@ -299,6 +299,7 @@
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
+	{Opt_secrm, "secrm"},
 	{Opt_ignore, "grpquota"},
 	{Opt_ignore, "noquota"},
 	{Opt_ignore, "quota"},
@@ -410,6 +411,9 @@
 			printk("EXT2 (no)acl options not supported\n");
 			break;
 #endif
+		case Opt_secrm:
+			set_opt(sbi->s_mount_opt, SECRM);
+			break;
 		case Opt_ignore:
 			break;
 		default:

--------------070708020007080208020002--
