Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262897AbSKBGfV>; Sat, 2 Nov 2002 01:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265883AbSKBGfV>; Sat, 2 Nov 2002 01:35:21 -0500
Received: from thunk.org ([140.239.227.29]:19355 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262897AbSKBGfS>;
	Sat, 2 Nov 2002 01:35:18 -0500
Date: Sat, 2 Nov 2002 01:41:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH]  FIXUP: Orlov block allocator for ext2
Message-ID: <20021102064130.GA15874@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <3DC1C852.E8DB711E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1C852.E8DB711E@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 04:18:26PM -0800, Andrew Morton wrote:
> This is Al's implementation of the Orlov block allocator for ext2.
> 
> At least doubles the throughput for the traverse-a-kernel-tree
> test and is well tested.

I finally had time to look at the Orlov patches, and found a memory
leak; sbi->s_debts wasn't getting freed when the filesystem was
getting unmounted, or in the error path.

This patch also makes the following cleanups/changes:

1) Use sbi->s_debts instead of sbi->debts --- all other fields in
	struct ext2_sb_info are prefixed by "s_", so this makes things
	consistent.

2) Add support for a new inode flag, EXT2_TOPDIR_FL, which tells tells
	the Orlov allocator to treat that directory as the top of
	directory hierarchies, so that new subdirectories created in
	that directory should be spread apart.  System administrators
	should set this flag on directories like /usr/src, /usr/home, etc.

3) Add a mount-time flag, -o oldalloc, which forces the use of the old
	inode (pre-Orlov) allocator.  This makes it easier to do
	comparison benchmarks, and in case people want to use the old
	algorithm.

						- Ted

fs/ext2/ialloc.c           |   27 ++++++++++++++-------------
fs/ext2/super.c            |   17 ++++++++++++-----
include/linux/ext2_fs.h    |    6 ++++--
include/linux/ext2_fs_sb.h |    2 +-
4 files changed, 31 insertions(+), 21 deletions(-)

diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Sat Nov  2 01:32:09 2002
+++ b/fs/ext2/ialloc.c	Sat Nov  2 01:32:09 2002
@@ -209,9 +209,7 @@
  * For other inodes, search forward from the parent directory\'s block
  * group to find a free inode.
  */
-#if 0
-
-static int find_group_dir(struct super_block *sb, int parent_group)
+static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	int ngroups = EXT2_SB(sb)->s_groups_count;
@@ -243,7 +241,6 @@
 	mark_buffer_dirty(best_bh);
 	return best_group;
 }
-#endif
 
 /* 
  * Orlov's allocator for directories. 
@@ -289,7 +286,8 @@
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 
-	if (parent == sb->s_root->d_inode) {
+	if ((parent == sb->s_root->d_inode) ||
+	    (parent->i_flags & EXT2_TOPDIR_FL)) {
 		struct ext2_group_desc *best_desc = NULL;
 		struct buffer_head *best_bh = NULL;
 		int best_ndir = inodes_per_group;
@@ -342,7 +340,7 @@
 		desc = ext2_get_group_desc (sb, group, &bh);
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
-		if (sbi->debts[group] >= max_debt)
+		if (sbi->s_debts[group] >= max_debt)
 			continue;
 		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
 			continue;
@@ -447,9 +445,12 @@
 	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 repeat:
-	if (S_ISDIR(mode))
-		group = find_group_orlov(sb, dir);
-	else 
+	if (S_ISDIR(mode)) {
+		if (test_opt (sb, OLDALLOC))
+			group = find_group_dir(sb, dir);
+		else
+			group = find_group_orlov(sb, dir);
+	} else 
 		group = find_group_other(sb, dir);
 
 	err = -ENOSPC;
@@ -488,11 +489,11 @@
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 
 	if (S_ISDIR(mode)) {
-		if (EXT2_SB(sb)->debts[group] < 255)
-			EXT2_SB(sb)->debts[group]++;
+		if (EXT2_SB(sb)->s_debts[group] < 255)
+			EXT2_SB(sb)->s_debts[group]++;
 	} else {
-		if (EXT2_SB(sb)->debts[group])
-			EXT2_SB(sb)->debts[group]--;
+		if (EXT2_SB(sb)->s_debts[group])
+			EXT2_SB(sb)->s_debts[group]--;
 	}
 
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Sat Nov  2 01:32:09 2002
+++ b/fs/ext2/super.c	Sat Nov  2 01:32:09 2002
@@ -140,6 +140,7 @@
 		if (sbi->s_group_desc[i])
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
+	kfree(sbi->s_debts);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -385,6 +386,10 @@
 				return 0;
 			sbi->s_resuid = v;
 		}
+		else if (!strcmp (this_char, "oldalloc"))
+			set_opt (sbi->s_mount_opt, OLDALLOC);
+		else if (!strcmp (this_char, "orlov"))
+			clear_opt (sbi->s_mount_opt, OLDALLOC);
 		/* Silently ignore the quota options */
 		else if (!strcmp (this_char, "grpquota")
 		         || !strcmp (this_char, "noquota")
@@ -756,13 +761,13 @@
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	sbi->debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->debts),
-			GFP_KERNEL);
-	if (!sbi->debts) {
+	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+			       GFP_KERNEL);
+	if (!sbi->s_debts) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount_group_desc;
 	}
-	memset(sbi->debts, 0, sbi->s_groups_count * sizeof(*sbi->debts));
+	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
@@ -771,7 +776,7 @@
 				brelse (sbi->s_group_desc[j]);
 			kfree(sbi->s_group_desc);
 			printk ("EXT2-fs: unable to read group descriptors\n");
-			goto failed_mount;
+			goto failed_mount_group_desc;
 		}
 	}
 	if (!ext2_check_descriptors (sb)) {
@@ -808,6 +813,8 @@
 		brelse(sbi->s_group_desc[i]);
 failed_mount_group_desc:
 	kfree(sbi->s_group_desc);
+	if (sbi->s_debts)
+		kfree(sbi->s_debts);
 failed_mount:
 	brelse(bh);
 failed_sbi:
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Sat Nov  2 01:32:09 2002
+++ b/include/linux/ext2_fs.h	Sat Nov  2 01:32:09 2002
@@ -191,10 +191,11 @@
 #define EXT2_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
 #define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
-#define EXT2_FL_USER_VISIBLE		0x00011FFF /* User visible flags */
-#define EXT2_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
+#define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
+#define EXT2_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
 
 /*
  * ioctl commands
@@ -300,6 +301,7 @@
  * Mount flags
  */
 #define EXT2_MOUNT_CHECK		0x0001	/* Do mount-time checks */
+#define EXT2_MOUNT_OLDALLOC		0x0002  /* Don't use the new Orlov allocator */
 #define EXT2_MOUNT_GRPID		0x0004	/* Create files with directory's group */
 #define EXT2_MOUNT_DEBUG		0x0008	/* Some debugging messages */
 #define EXT2_MOUNT_ERRORS_CONT		0x0010	/* Continue on errors */
diff -Nru a/include/linux/ext2_fs_sb.h b/include/linux/ext2_fs_sb.h
--- a/include/linux/ext2_fs_sb.h	Sat Nov  2 01:32:09 2002
+++ b/include/linux/ext2_fs_sb.h	Sat Nov  2 01:32:09 2002
@@ -44,7 +44,7 @@
 	int s_first_ino;
 	u32 s_next_generation;
 	unsigned long s_dir_count;
-	u8 *debts;
+	u8 *s_debts;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */
