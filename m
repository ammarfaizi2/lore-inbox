Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291259AbSBLXRG>; Tue, 12 Feb 2002 18:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291254AbSBLXQv>; Tue, 12 Feb 2002 18:16:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5637 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291258AbSBLXPP>;
	Tue, 12 Feb 2002 18:15:15 -0500
Message-ID: <3C69A1CF.14D4AB62@zip.com.au>
Date: Tue, 12 Feb 2002 15:14:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] dirsync support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch which implements the `dirsync' mount option.
Also, `chattr +D' for ext2 and ext3.  This is designed 
to make the MTA folks happy.  Comments and testing would
be appreciated.

This patch will conflict with the synchronous mounts speedup
patch (which isn't needed if you're running dirsync).

The chattr extension needs an e2fsprogs-1.26 patch:
        http://www.zip.com.au/~akpm/linux/dirsync/e2fsprogs-1.26.patch

The 'mount -o dirsync' extension requires a util-linux-2.11n patch:
        http://www.zip.com.au/~akpm/linux/dirsync/util-linux-2.11n.patch


The kernel patch includes implementations for ext2 and ext3. It's
pretty simple.

- When dirsync is in operation against a directory, the following operations
  are synchronous within that directory:  create, link, unlink, symlink,
  mkdir, rmdir, mknod, rename (synchronous if either the source or dest
  directory is dirsync).   Did I miss anything?

- dirsync is a subset of sync.

- The ext2 implementation has a bit of footwork in the block allocator
  which is there to ensure that directory growth which includes indirect
  block instantiation is synchronous.

- inode.i_attr_flags was unused, and I killed it.

- mount /dev/foo /mnt/bar -o dirsync  works as expected.

- An ext2 or ext3 directory tree can be set dirsync with `chattr +D -R'.

- dirsync is maintained as new directories are created under
  a `chattr +D' directory.

- Non-directory files also have their dirsync flag propagated.  This
  doesn't make a lot of sense, but it matches `chattr -R' behaviour.

- There was a bit of version skew between e2fsprogs' idea of the
  inode flags and the kernel's.  I sorted that out.

- `lsattr' shows the dirsync flag as "D".  The letter "D" was
  previously being used for Compressed_Dirty_File.  I changed
  Compressed_Dirty_File to use "Z".  Is that OK?

The mount(2) manpage needs to be taught about MS_DIRSYNC.


--- linux-2.4.18-pre9/include/linux/fs.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/linux/fs.h	Sun Feb 10 21:53:33 2002
@@ -105,6 +105,7 @@ extern int leases_enable, dir_notify_ena
 #define MS_SYNCHRONOUS	16	/* Writes are synced at once */
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
@@ -135,7 +136,7 @@ extern int leases_enable, dir_notify_ena
 #define S_IMMUTABLE	16	/* Immutable file */
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
-
+#define S_DIRSYNC	128	/* Directory modifications are synchronous */
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
@@ -152,7 +153,10 @@ extern int leases_enable, dir_notify_ena
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
 #define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || ((inode)->i_flags & S_SYNC))
+#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
+					((inode)->i_flags & S_SYNC))
+#define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
+					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
@@ -475,7 +479,6 @@ struct inode {
 	unsigned char		i_sock;
 
 	atomic_t		i_writecount;
-	unsigned int		i_attr_flags;
 	__u32			i_generation;
 	union {
 		struct minix_inode_info		minix_i;
--- linux-2.4.18-pre9/include/linux/ext2_fs.h	Tue Oct 23 21:59:31 2001
+++ linux-akpm/include/linux/ext2_fs.h	Sun Feb 10 21:53:33 2002
@@ -198,10 +198,16 @@ struct ext2_group_desc
 #define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
 /* End compression flags --- maybe not all used */	
 #define EXT2_BTREE_FL			0x00001000 /* btree format dir */
+#define EXT2_INDEX_FL			0x00001000 /* hash-indexed directory */
+#define EXT2_IMAGIC_FL			0x00002000 /* AFS directory */
+#define EXT2_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
+#define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories
+						      only) */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
-#define EXT2_FL_USER_VISIBLE		0x00001FFF /* User visible flags */
-#define EXT2_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
+#define EXT2_FL_USER_VISIBLE		0x00011FFF /* User visible flags */
+#define EXT2_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
 
 /*
  * ioctl commands
--- linux-2.4.18-pre9/include/linux/ext3_fs.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/linux/ext3_fs.h	Sun Feb 10 21:53:33 2002
@@ -203,10 +203,13 @@ struct ext3_group_desc
 #define EXT3_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define EXT3_IMAGIC_FL			0x00002000 /* AFS directory */
 #define EXT3_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
+#define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories
+						      only) */
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
-#define EXT3_FL_USER_VISIBLE		0x00005FFF /* User visible flags */
-#define EXT3_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
+#define EXT3_FL_USER_VISIBLE		0x00015FFF /* User visible flags */
+#define EXT3_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
 
 /*
  * Inode dynamic state flags
--- linux-2.4.18-pre9/fs/namespace.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/namespace.c	Sun Feb 10 21:53:33 2002
@@ -204,6 +204,7 @@ static int show_vfsmnt(struct seq_file *
 		char *str;
 	} fs_info[] = {
 		{ MS_SYNCHRONOUS, ",sync" },
+		{ MS_DIRSYNC, ",dirsync" },
 		{ MS_MANDLOCK, ",mand" },
 		{ MS_NOATIME, ",noatime" },
 		{ MS_NODIRATIME, ",nodiratime" },
--- linux-2.4.18-pre9/fs/ext2/dir.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/ext2/dir.c	Sun Feb 10 21:53:33 2002
@@ -53,7 +53,7 @@ static int ext2_commit_chunk(struct page
 	int err = 0;
 	dir->i_version = ++event;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir)) {
+	if (IS_DIRSYNC(dir)) {
 		int err2;
 		err = writeout_one_page(page);
 		err2 = waitfor_one_page(page);
--- linux-2.4.18-pre9/fs/ext2/inode.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/ext2/inode.c	Sun Feb 10 21:53:33 2002
@@ -407,7 +407,8 @@ static int ext2_alloc_branch(struct inod
 		mark_buffer_uptodate(bh, 1);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
+		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync ||
+			(S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode))) {
 			ll_rw_block (WRITE, 1, &bh);
 			wait_on_buffer (bh);
 		}
@@ -471,13 +472,15 @@ static inline int ext2_splice_branch(str
 	/* had we spliced it onto indirect block? */
 	if (where->bh) {
 		mark_buffer_dirty_inode(where->bh, inode);
-		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
+		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync ||
+			(S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode))) {
 			ll_rw_block (WRITE, 1, &where->bh);
 			wait_on_buffer(where->bh);
 		}
 	}
 
-	if (IS_SYNC(inode) || inode->u.ext2_i.i_osync)
+	if (IS_SYNC(inode) || inode->u.ext2_i.i_osync ||
+		(S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode)))
 		ext2_sync_inode (inode);
 	else
 		mark_inode_dirty(inode);
@@ -997,23 +1000,16 @@ void ext2_read_inode (struct inode * ino
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
-	inode->i_attr_flags = 0;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
+	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_APPEND;
+	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL)
 		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
+	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
+	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL)
 		inode->i_flags |= S_NOATIME;
-	}
+	if (inode->u.ext2_i.i_flags & EXT2_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
 	return;
 	
 bad_inode:
--- linux-2.4.18-pre9/fs/ext2/ialloc.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/ext2/ialloc.c	Sun Feb 10 21:53:33 2002
@@ -389,9 +389,14 @@ repeat:
 	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags;
 	if (S_ISLNK(mode))
 		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
+	/* dirsync is only applied to directories */
+	if (!S_ISDIR(mode))
+		inode->u.ext2_i.i_flags &= ~EXT2_DIRSYNC_FL;
 	inode->u.ext2_i.i_block_group = group;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
+	if (inode->u.ext2_i.i_flags & EXT2_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
 	insert_inode_hash(inode);
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
--- linux-2.4.18-pre9/fs/ext2/ioctl.c	Wed Sep 27 13:41:33 2000
+++ linux-akpm/fs/ext2/ioctl.c	Sun Feb 10 21:53:33 2002
@@ -36,6 +36,9 @@ int ext2_ioctl (struct inode * inode, st
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
+		if (!S_ISDIR(inode->i_mode))
+			flags &= ~EXT2_DIRSYNC_FL;
+
 		oldflags = inode->u.ext2_i.i_flags;
 
 		/*
--- linux-2.4.18-pre9/fs/ext3/ialloc.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/ext3/ialloc.c	Sun Feb 10 21:53:33 2002
@@ -485,7 +485,10 @@ repeat:
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->u.ext3_i.i_flags = dir->u.ext3_i.i_flags & ~EXT3_INDEX_FL;
 	if (S_ISLNK(mode))
-		inode->u.ext3_i.i_flags &= ~(EXT3_IMMUTABLE_FL|EXT3_APPEND_FL);
+		EXT3_I(inode)->i_flags &= ~(EXT3_IMMUTABLE_FL|EXT3_APPEND_FL);
+	/* dirsync only applies to directories */
+	if (!S_ISDIR(mode))
+		EXT3_I(inode)->i_flags &= ~EXT3_DIRSYNC_FL;
 #ifdef EXT3_FRAGMENTS
 	inode->u.ext3_i.i_faddr = 0;
 	inode->u.ext3_i.i_frag_no = 0;
@@ -500,9 +503,11 @@ repeat:
 #endif
 	inode->u.ext3_i.i_block_group = i;
 	
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL)
+	if (EXT3_I(inode)->i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	if (IS_SYNC(inode))
+	if (EXT3_I(inode)->i_flags & EXT3_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+	if (IS_DIRSYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
 	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
--- linux-2.4.18-pre9/fs/ext3/inode.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/ext3/inode.c	Sun Feb 10 21:53:33 2002
@@ -2140,23 +2140,16 @@ void ext3_read_inode(struct inode * inod
 	} else 
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
-	/* inode->i_attr_flags = 0;				unused */
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS; unused */
+	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_APPEND_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_APPEND;	unused */
+	if (inode->u.ext3_i.i_flags & EXT3_APPEND_FL)
 		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_IMMUTABLE_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;	unused */
+	if (inode->u.ext3_i.i_flags & EXT3_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_NOATIME_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
+	if (inode->u.ext3_i.i_flags & EXT3_NOATIME_FL)
 		inode->i_flags |= S_NOATIME;
-	}
+	if (inode->u.ext3_i.i_flags & EXT3_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
 	return;
 	
 bad_inode:
--- linux-2.4.18-pre9/fs/ext3/namei.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/ext3/namei.c	Sun Feb 10 21:53:33 2002
@@ -455,7 +455,7 @@ static int ext3_create (struct inode * d
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, mode);
@@ -482,7 +482,7 @@ static int ext3_mknod (struct inode * di
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, mode);
@@ -511,7 +511,7 @@ static int ext3_mkdir(struct inode * dir
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, S_IFDIR);
@@ -801,7 +801,7 @@ static int ext3_rmdir (struct inode * di
 	if (!bh)
 		goto end_rmdir;
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = dentry->d_inode;
@@ -853,7 +853,7 @@ static int ext3_unlink(struct inode * di
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	retval = -ENOENT;
@@ -908,7 +908,7 @@ static int ext3_symlink (struct inode * 
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, S_IFLNK|S_IRWXUGO);
@@ -963,7 +963,7 @@ static int ext3_link (struct dentry * ol
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode->i_ctime = CURRENT_TIME;
@@ -999,7 +999,7 @@ static int ext3_rename (struct inode * o
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (IS_SYNC(old_dir) || IS_SYNC(new_dir))
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		handle->h_sync = 1;
 
 	old_bh = ext3_find_entry (old_dentry, &old_de);
--- linux-2.4.18-pre9/fs/ext3/ioctl.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/ext3/ioctl.c	Sun Feb 10 21:53:33 2002
@@ -42,6 +42,9 @@ int ext3_ioctl (struct inode * inode, st
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
+		if (!S_ISDIR(inode->i_mode))
+			flags &= ~EXT3_DIRSYNC_FL;
+
 		oldflags = inode->u.ext3_i.i_flags;
 
 		/* The JOURNAL_DATA flag is modifiable only by root */


-
