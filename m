Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSEZUog>; Sun, 26 May 2002 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316424AbSEZUng>; Sun, 26 May 2002 16:43:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316416AbSEZUmd>;
	Sun, 26 May 2002 16:42:33 -0400
Message-ID: <3CF14973.B61EF771@zip.com.au>
Date: Sun, 26 May 2002 13:45:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch 11/18] dirsync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



An implementation of directory-synchronous mounts.

I sent this out some months ago and it didn't generate a lot of
interest.  Later we had one of the usual cheery exchanges with Wietse
Venema (postfix development) and he agreed that directory synchronous
mounts were something that he could use, and that there was benefit in
implementing them in Linux.  If you choose to apply this I'll push the
2.4 patch.



Patch against e2fsprogs-1.26:
        http://www.zip.com.au/~akpm/linux/dirsync/e2fsprogs-1.26.patch

Patch against util-linux-2.11n:
        http://www.zip.com.au/~akpm/linux/dirsync/util-linux-2.11n.patch


The kernel patch includes implementations for ext2 and ext3. It's
pretty simple.

- When dirsync is in operation against a directory, the following operations
  are synchronous within that directory:  create, link, unlink, symlink,
  mkdir, rmdir, mknod, rename (synchronous if either the source or dest
  directory is dirsync).

- dirsync is a subset of sync.  So `mount -o sync' or `chattr +S'
  give you everything which `mount -o dirsync' or `chattr +D' gives,
  plus synchronous file writes.

- ext2's inode.i_attr_flags is unused, and is removed.

- mount /dev/foo /mnt/bar -o dirsync  works as expected.

- An ext2 or ext3 directory tree can be set dirsync with `chattr +D -R'.

- dirsync is maintained as new directories are created under
  a `chattr +D' directory.  Like `chattr +S'.

- Other filesystems can trivially be taught about dirsync.  It's just
  a matter of replacing `IS_SYNC(inode)' with `IS_DIRSYNC(inode)' in
  the directory update functions.  IS_SYNC will still be honoured when
  IS_DIRSYNC is used.

- Non-directory files do not have their dirsync flag propagated.  So
  an S_ISREG file which is created inside a dirsync directory will not
  have its dirsync bit set.  chattr needs to do this as well.

- There was a bit of version skew between e2fsprogs' idea of the
  inode flags and the kernel's.  That is sorted out here.

- `lsattr' shows the dirsync flag as "D".  The letter "D" was
  previously being used for Compressed_Dirty_File.  I changed
  Compressed_Dirty_File to use "Z".  Is that OK?

The mount(2) manpage needs to be taught about MS_DIRSYNC.


=====================================

--- 2.5.18/include/linux/fs.h~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/include/linux/fs.h	Sun May 26 12:37:57 2002
@@ -107,6 +107,7 @@ extern int leases_enable, dir_notify_ena
 #define MS_SYNCHRONOUS	16	/* Writes are synced at once */
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
@@ -137,6 +138,7 @@ extern int leases_enable, dir_notify_ena
 #define S_IMMUTABLE	16	/* Immutable file */
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
+#define S_DIRSYNC	128	/* Directory modifications are synchronous */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -154,7 +156,10 @@ extern int leases_enable, dir_notify_ena
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
 #define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || ((inode)->i_flags & S_SYNC))
+#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
+					((inode)->i_flags & S_SYNC))
+#define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
+					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
@@ -398,7 +403,6 @@ struct inode {
 	unsigned char		i_sock;
 
 	atomic_t		i_writecount;
-	unsigned int		i_attr_flags;
 	__u32			i_generation;
 	union {
 		void				*generic_ip;
@@ -1184,6 +1188,7 @@ extern void iput(struct inode *);
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+extern int inode_needs_sync(struct inode *inode);
 
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
--- 2.5.18/include/linux/ext2_fs.h~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/include/linux/ext2_fs.h	Sun May 26 12:37:57 2002
@@ -211,10 +211,15 @@ struct ext2_group_desc
 #define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
 /* End compression flags --- maybe not all used */	
 #define EXT2_BTREE_FL			0x00001000 /* btree format dir */
+#define EXT2_INDEX_FL			0x00001000 /* hash-indexed directory */
+#define EXT2_IMAGIC_FL			0x00002000 /* AFS directory */
+#define EXT2_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
+#define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
-#define EXT2_FL_USER_VISIBLE		0x00001FFF /* User visible flags */
-#define EXT2_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
+#define EXT2_FL_USER_VISIBLE		0x00011FFF /* User visible flags */
+#define EXT2_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
 
 /*
  * ioctl commands
--- 2.5.18/include/linux/ext3_fs.h~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/include/linux/ext3_fs.h	Sun May 26 12:37:57 2002
@@ -203,10 +203,12 @@ struct ext3_group_desc
 #define EXT3_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define EXT3_IMAGIC_FL			0x00002000 /* AFS directory */
 #define EXT3_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
+#define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
-#define EXT3_FL_USER_VISIBLE		0x00005FFF /* User visible flags */
-#define EXT3_FL_USER_MODIFIABLE		0x000000FF /* User modifiable flags */
+#define EXT3_FL_USER_VISIBLE		0x00015FFF /* User visible flags */
+#define EXT3_FL_USER_MODIFIABLE		0x000100FF /* User modifiable flags */
 
 /*
  * Inode dynamic state flags
--- 2.5.18/fs/namespace.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/namespace.c	Sun May 26 12:37:57 2002
@@ -197,6 +197,7 @@ static int show_vfsmnt(struct seq_file *
 		char *str;
 	} fs_info[] = {
 		{ MS_SYNCHRONOUS, ",sync" },
+		{ MS_DIRSYNC, ",dirsync" },
 		{ MS_MANDLOCK, ",mand" },
 		{ MS_NOATIME, ",noatime" },
 		{ MS_NODIRATIME, ",nodiratime" },
--- 2.5.18/fs/ext2/dir.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext2/dir.c	Sun May 26 12:37:57 2002
@@ -68,7 +68,7 @@ static int ext2_commit_chunk(struct page
 	int err = 0;
 	dir->i_version = ++event;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		err = write_one_page(page, 1);
 	else
 		unlock_page(page);
--- 2.5.18/fs/ext2/inode.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext2/inode.c	Sun May 26 12:37:57 2002
@@ -58,7 +58,7 @@ void ext2_delete_inode (struct inode * i
 		goto no_delete;
 	EXT2_I(inode)->i_dtime	= CURRENT_TIME;
 	mark_inode_dirty(inode);
-	ext2_update_inode(inode, IS_SYNC(inode));
+	ext2_update_inode(inode, inode_needs_sync(inode));
 
 	inode->i_size = 0;
 	if (inode->i_blocks)
@@ -905,7 +905,7 @@ do_indirects:
 			;
 	}
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	if (IS_SYNC(inode)) {
+	if (inode_needs_sync(inode)) {
 		sync_mapping_buffers(inode->i_mapping);
 		ext2_sync_inode (inode);
 	} else {
@@ -1039,23 +1039,14 @@ void ext2_read_inode (struct inode * ino
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
-	inode->i_attr_flags = 0;
-	if (ei->i_flags & EXT2_SYNC_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
+	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	}
-	if (ei->i_flags & EXT2_APPEND_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_APPEND;
+	if (ei->i_flags & EXT2_APPEND_FL)
 		inode->i_flags |= S_APPEND;
-	}
-	if (ei->i_flags & EXT2_IMMUTABLE_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
+	if (ei->i_flags & EXT2_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (ei->i_flags & EXT2_NOATIME_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
+	if (ei->i_flags & EXT2_NOATIME_FL)
 		inode->i_flags |= S_NOATIME;
-	}
 	return;
 	
 bad_inode:
--- 2.5.18/fs/inode.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/inode.c	Sun May 26 12:37:57 2002
@@ -981,6 +981,15 @@ void update_atime (struct inode *inode)
 	do_atime_update(inode);
 }   /*  End Function update_atime  */
 
+int inode_needs_sync(struct inode *inode)
+{
+	if (IS_SYNC(inode))
+		return 1;
+	if (S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode))
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(inode_needs_sync);
 
 /*
  *	Quota functions that want to walk the inode lists..
--- 2.5.18/fs/ext2/ialloc.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext2/ialloc.c	Sun May 26 12:37:57 2002
@@ -429,6 +429,9 @@ repeat:
 	ei->i_flags = EXT2_I(dir)->i_flags;
 	if (S_ISLNK(mode))
 		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
+	/* dirsync is only applied to directories */
+	if (!S_ISDIR(mode))
+		ei->i_flags &= ~EXT2_DIRSYNC_FL;
 	ei->i_faddr = 0;
 	ei->i_frag_no = 0;
 	ei->i_frag_size = 0;
@@ -443,6 +446,8 @@ repeat:
 	ei->i_dir_start_lookup = 0;
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
+	if (ei->i_flags & EXT2_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
--- 2.5.18/fs/ext2/ioctl.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext2/ioctl.c	Sun May 26 12:37:57 2002
@@ -36,6 +36,9 @@ int ext2_ioctl (struct inode * inode, st
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
+		if (!S_ISDIR(inode->i_mode))
+			flags &= ~EXT2_DIRSYNC_FL;
+
 		oldflags = ei->i_flags;
 
 		/*
--- 2.5.18/fs/ext3/ialloc.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext3/ialloc.c	Sun May 26 12:37:57 2002
@@ -490,6 +490,9 @@ repeat:
 	ei->i_flags = EXT3_I(dir)->i_flags & ~EXT3_INDEX_FL;
 	if (S_ISLNK(mode))
 		ei->i_flags &= ~(EXT3_IMMUTABLE_FL|EXT3_APPEND_FL);
+	/* dirsync only applies to directories */
+	if (!S_ISDIR(mode))
+		ei->i_flags &= ~EXT3_DIRSYNC_FL;
 #ifdef EXT3_FRAGMENTS
 	ei->i_faddr = 0;
 	ei->i_frag_no = 0;
@@ -506,7 +509,9 @@ repeat:
 	
 	if (ei->i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	if (IS_SYNC(inode))
+	if (ei->i_flags & EXT3_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+	if (IS_DIRSYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
 	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
--- 2.5.18/fs/ext3/inode.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext3/inode.c	Sun May 26 12:37:57 2002
@@ -2160,23 +2160,14 @@ void ext3_read_inode(struct inode * inod
 	} else 
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
-	/* inode->i_attr_flags = 0;				unused */
-	if (ei->i_flags & EXT3_SYNC_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS; unused */
+	if (ei->i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
-	}
-	if (ei->i_flags & EXT3_APPEND_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_APPEND;	unused */
+	if (ei->i_flags & EXT3_APPEND_FL)
 		inode->i_flags |= S_APPEND;
-	}
-	if (ei->i_flags & EXT3_IMMUTABLE_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;	unused */
+	if (ei->i_flags & EXT3_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (ei->i_flags & EXT3_NOATIME_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
+	if (ei->i_flags & EXT3_NOATIME_FL)
 		inode->i_flags |= S_NOATIME;
-	}
 	return;
 	
 bad_inode:
--- 2.5.18/fs/ext3/namei.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext3/namei.c	Sun May 26 12:37:57 2002
@@ -502,7 +502,7 @@ static int ext3_create (struct inode * d
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, mode);
@@ -533,7 +533,7 @@ static int ext3_mknod (struct inode * di
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, mode);
@@ -566,7 +566,7 @@ static int ext3_mkdir(struct inode * dir
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, S_IFDIR);
@@ -860,7 +860,7 @@ static int ext3_rmdir (struct inode * di
 	if (!bh)
 		goto end_rmdir;
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = dentry->d_inode;
@@ -916,7 +916,7 @@ static int ext3_unlink(struct inode * di
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	retval = -ENOENT;
@@ -975,7 +975,7 @@ static int ext3_symlink (struct inode * 
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode = ext3_new_inode (handle, dir, S_IFLNK|S_IRWXUGO);
@@ -1033,7 +1033,7 @@ static int ext3_link (struct dentry * ol
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
 	inode->i_ctime = CURRENT_TIME;
@@ -1073,7 +1073,7 @@ static int ext3_rename (struct inode * o
 		return PTR_ERR(handle);
 	}
 
-	if (IS_SYNC(old_dir) || IS_SYNC(new_dir))
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		handle->h_sync = 1;
 
 	old_bh = ext3_find_entry (old_dentry, &old_de);
--- 2.5.18/fs/ext3/ioctl.c~dirsync	Sun May 26 12:37:57 2002
+++ 2.5.18-akpm/fs/ext3/ioctl.c	Sun May 26 12:37:57 2002
@@ -43,6 +43,9 @@ int ext3_ioctl (struct inode * inode, st
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
+		if (!S_ISDIR(inode->i_mode))
+			flags &= ~EXT3_DIRSYNC_FL;
+
 		oldflags = ei->i_flags;
 
 		/* The JOURNAL_DATA flag is modifiable only by root */

-
