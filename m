Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136921AbREJUyP>; Thu, 10 May 2001 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136922AbREJUyG>; Thu, 10 May 2001 16:54:06 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:62202 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S136921AbREJUxz>; Thu, 10 May 2001 16:53:55 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105102053.f4AKrEke004120@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: "from (env: adilger) at May 10, 2001 01:21:50 am"
To: phillips@bonn-fries.net
Date: Thu, 10 May 2001 14:53:14 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM989527987-528-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM989527987-528-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

I previously wrote:
> I have changed the code to do the following:
> - If the COMPAT_DIR_INDEX flag is set at mount/remount time, set the
>   INDEX mount option (the same as "mount -o index").  This removes
>   the need to specify the "-o index" option each time for filesystems
>   which already have indexed directories.
> - New directories NEVER have the INDEX flag set on them.
> - If the INDEX mount option is set, then when directories grow past 1
>   block (and have the index added) they will get the directory INDEX
>   flag set and turn on the superblock COMPAT_DIR_INDEX flag (if off).
> 
> This means that you can have common code for indexed and non-indexed ext2
> filesystems, and the admin either needs to explicitly set COMPAT_DIR_INDEX
> in the superblock or mount with "-o index" (and create a directory > 1 block).
> 
> I have also added some tricks to ext2_inc_count() and ext2_dec_count() so
> that indexed directories are not subject to the EXT2_LINK_MAX.  I've done
> the same as reiserfs, and set i_nlink = 1 if we overflow EXT2_LINK_MAX
> (which has been increased to 65500 for indexed directories). Apparently
> i_nlink = 1 is the right think to do w.r.t. find and other user tools.

OK, here are the patches described above.

The first one changes the use of the various INDEX flags, so that they
only appear when we have mounted with "-o index" (or COMPAT_DIR_INDEX)
and actually created an indexed directory.

The second one changes the i_nlink counting on indexed dirs so that if
it overflows the 16-bit i_link_count field it is set to 1 and we no
longer track link counts on this directory.

Unfortunately, they haven't been tested.  I've given them several
eyeballings and they appear OK, but when I try to run the ext2 index code
(even without "-o index" mount option) my system deadlocks somwhere
inside my ext2i module (tight loop, but SysRQ still works).  I doubt
it is due to these patches, but possibly because I am also working on
ext3 code in the same kernel.  I'm just in the process of getting kdb
installed into that kernel so I can find out just where it is looping.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

--ELM989527987-528-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=ext2-2.4.5-indexflag.diff
Content-Description: 

diff -u linux/ext2.orig/dir.c linux/ext2/dir.c
--- linux/ext2.orig/dir.c	Thu May 10 12:10:22 2001
+++ linux/ext2/dir.c	Thu May 10 11:09:51 2001
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/locks.h>
+#include <asm/smplock.h>
 #include <linux/pagemap.h>
 
 #ifndef assert
@@ -201,6 +204,21 @@
 	return hash0;
 }
 
+static void ext2_update_to_indexed(struct inode *dir)
+{
+	struct super_block *sb = dir->i_sb;
+
+	if (test_opt(sb, INDEX) && !EXT2_HAS_COMPAT_FEATURE(sb, DIR_INDEX)) {
+		dxtrace_on(printk("Adding COMPAT_DIR_INDEX feature flag\n"));
+		ext2_update_dynamic_rev(sb);
+		lock_kernel();
+		EXT2_SET_COMPAT_FEATURE(sb, DIR_INDEX);
+		unlock_kernel();
+		ext2_write_super(dir->i_sb);
+	}
+	dir->u.ext2_i.i_flags |= EXT2_INDEX_FL;
+}
+
 /*
  * Debug
  */
@@ -696,8 +720,7 @@
 	char *data, *top;
 	*result = NULL;
 	if (namelen > EXT2_NAME_LEN) return NULL;
-	if (ext2_dx && is_dx(dir))
-	{
+	if (is_dx(dir)) {
 		u32 hash = dx_hash (name, namelen);
 		struct dx_frame frames[2], *frame;
 		if (!(frame = dx_probe (dir, hash, frames)))
@@ -818,8 +860,7 @@
 	char *data1;
 
 	if (!namelen) return -EINVAL;
-	if (ext2_dx && is_dx(dir))
-	{
+	if (is_dx(dir)) {
 		unsigned count, split, hash2, block2;
 		struct buffer_head *bh2;
 		char *data2;
@@ -989,7 +1032,7 @@
 			if ((de->inode? rlen - nlen: rlen) >= reclen) goto add;
 			de = (ext2_dirent *) ((char *) de + rlen);
 		}
-		if (ext2_dx && blocks == 1 && dir->u.ext2_i.i_flags & EXT2_INDEX_FL)
+		if (ext2_dx && blocks == 1 && test_opt(dir->i_sb, INDEX))
 		{
 			struct dx_root *root;
 			struct buffer_head *newbh, *rootbh = bh;
@@ -1029,6 +1072,7 @@
 			dx_set_block (entries, 1);
 			dx_set_count (entries, 1);
			dx_set_limit (entries, dx_root_limit(dir, sizeof(struct dx_root_info)));
+			ext2_update_to_indexed(dir);
 
 			/* Initialize as for dx_probe */
 			hash = dx_hash (name, namelen);
@@ -1107,26 +1154,11 @@
 
 int ext2_make_empty(struct inode *dir, struct inode *parent)
 {
-	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
-	int make_dx = test_opt (sb, INDEX);
-	dir->i_size = sb->s_blocksize;
+
+	dir->i_size = dir->i_sb->s_blocksize;
 	if (IS_ERR(bh = ext2_bread (dir, 0, 1)))
 		return PTR_ERR(bh);
-	if (ext2_dx && make_dx)
-	{
-		// this is a common sequence, need to generalize it
-		if (!EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX))
-		{
-			dxtrace_on(printk("Adding COMPAT_DIR_INDEX feature\n"));
-			lock_super(sb);
-			ext2_update_dynamic_rev(sb);
-			EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX);
-			unlock_super(sb);
-			ext2_write_super(sb);
-		}
-		dir->u.ext2_i.i_flags |= EXT2_INDEX_FL;
-	}
 	makedots ((ext2_dirent *) bh->b_data, dir, parent);
 	mark_buffer_dirty_inode(bh, parent);
 	brelse (bh);
diff -u linux/ext2.orig/super.c linux/ext2/super.c
--- linux/ext2.orig/super.c	Thu May 10 12:10:22 2001
+++ linux/ext2/super.c	Thu May 10 00:16:31 2001
@@ -330,6 +330,10 @@
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
 			sb->u.ext2_sb.s_mount_opt);
+
+	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX))
+		set_opt (EXT2_SB(sb)->s_mount_opt, INDEX);
+
 #ifdef CONFIG_EXT2_CHECK
 	if (test_opt (sb, CHECK)) {
 		ext2_check_blocks_bitmap (sb);
diff -ru linux/include/linux/ext2_fs.h.orig linux/include/linux/ext2_fs.h
--- include/linux/ext2_fs.h.orig	Thu May 10 12:10:22 2001
+++ include/linux/ext2_fs.h	Thu May 10 12:50:15 2001
@@ -529,7 +549,7 @@
 #ifdef CONFIG_EXT2_INDEX
   enum {ext2_dx = 1};
   #define dx_static static
-  #define is_dx(dir) (dir->u.ext2_i.i_flags & EXT2_INDEX_FL && dir->i_size > dir->i_sb->s_blocksize)
+  #define is_dx(dir) ((dir)->u.ext2_i.i_flags & EXT2_INDEX_FL)
 #else
   enum {ext2_dx = 0};
   #define dx_static

--ELM989527987-528-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=ext2-2.4.5-dirlink.diff
Content-Description: 

diff -u linux/ext2.orig/dir.c linux/ext2/dir.c
--- linux/ext2.orig/dir.c	Thu May 10 12:10:22 2001
+++ linux/ext2/dir.c	Thu May 10 11:09:51 2001
@@ -1171,6 +1203,10 @@
 		}
 		ext2_put_page(page);
 	}
+	if (!EXT2_DIR_LINK_EMPTY(inode))
+		ext2_warning(inode->i_sb, __FUNCTION__,
+			     "empty directory has too many links (%d)",
+			     inode->i_nlink);
 	return 1;
 
 not_empty:
diff -u linux/ext2.orig/namei.c linux/ext2/namei.c
--- linux/ext2.orig/namei.c	Thu May 10 12:10:22 2001
+++ linux/ext2/namei.c	Thu May 10 01:06:42 2001
@@ -41,6 +41,25 @@
  * Couple of helper functions - make the code slightly cleaner.
  */
 
+static inline void ext2_inc_count_dir(struct inode *dir)
+{
+	if (is_dx(dir)) {
+		if (dir->i_nlink > 1) {
+			dir->i_nlink++;
+			if (dir->i_nlink >= EXT2_LINK_MAX * 2)
+				dir->i_nlink = 1;
+		}
+	} else
+		dir->i_nlink++;
+	mark_inode_dirty(dir);
+}
+
+static inline void ext2_dec_count_dir(struct inode *dir)
+{
+	if (!is_dx(dir) || dir->i_nlink > 2) dir->i_nlink--;
+	mark_inode_dirty(dir);
+}
+
 static inline void ext2_inc_count(struct inode *inode)
 {
 	inode->i_nlink++;
@@ -186,10 +210,10 @@
 	struct inode * inode;
 	int err = -EMLINK;
 
-	if (dir->i_nlink >= EXT2_LINK_MAX)
+	if (EXT2_DIR_LINK_MAX(dir))
 		goto out;
 
-	ext2_inc_count(dir);
+	ext2_inc_count_dir(dir);
 
 	inode = ext2_new_inode (dir, S_IFDIR | mode);
 	err = PTR_ERR(inode);
@@ -219,7 +243,7 @@
 	ext2_dec_count(inode);
 	iput(inode);
 out_dir:
-	ext2_dec_count(dir);
+	ext2_dec_count_dir(dir);
 	goto out;
 }
 
@@ -255,7 +278,7 @@
 		if (!err) {
 			inode->i_size = 0;
 			ext2_dec_count(inode);
-			ext2_dec_count(dir);
+			ext2_dec_count_dir(dir);
 		}
 	}
 	return err;
@@ -302,10 +325,9 @@
 			new_inode->i_nlink--;
 		ext2_dec_count(new_inode);
 	} else {
-		if (dir_de) {
+		if (dir_de && EXT2_DIR_LINK_MAX(new_dir)) {
 			err = -EMLINK;
-			if (new_dir->i_nlink >= EXT2_LINK_MAX)
-				goto out_dir;
+			goto out_dir;
 		}
 		ext2_inc_count(old_inode);
 		err = ext2_add_link(new_dentry, old_inode);
@@ -314,7 +336,7 @@
 			goto out_dir;
 		}
 		if (dir_de)
-			ext2_inc_count(new_dir);
+			ext2_inc_count_dir(new_dir);
 	}
 
 	ext2_delete_entry (old_dir, old_de, old_bh);
@@ -322,7 +344,7 @@
 
 	if (dir_de) {
 		ext2_set_link(old_inode, dir_de, dir_bh, new_dir);
-		ext2_dec_count(old_dir);
+		ext2_dec_count_dir(old_dir);
 	}
 	return 0;
 
diff -ru linux/include/linux/ext2_fs.h.orig linux/include/linux/ext2_fs.h
--- include/linux/ext2_fs.h.dx	Thu May 10 12:10:22 2001
+++ include/linux/ext2_fs.h	Thu May 10 12:50:15 2001
@@ -529,11 +549,15 @@
 #ifdef CONFIG_EXT2_INDEX
   enum {ext2_dx = 1};
   #define dx_static static
   #define is_dx(dir) ((dir)->u.ext2_i.i_flags & EXT2_INDEX_FL)
+#define EXT2_DIR_LINK_MAX(dir) (!is_dx(dir) && (dir)->i_nlink >= EXT2_LINK_MAX)
+#define EXT2_DIR_LINK_EMPTY(dir) ((dir)->i_nlink == 2 || (dir)->i_nlink == 1)
 #else
   enum {ext2_dx = 0};
   #define dx_static
   #define is_dx(dir) 0
+#define EXT2_DIR_LINK_MAX(dir) ((dir)->i_nlink >= EXT2_LINK_MAX)
+#define EXT2_DIR_LINK_EMPTY(dir) ((dir)->i_nlink == 2)
 #endif
 
 #ifdef __KERNEL__
 extern void ext2_put_inode (struct inode *);

--ELM989527987-528-0_--
