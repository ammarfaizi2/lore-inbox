Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbUKYAAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUKYAAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUKXX7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:59:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49101 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262950AbUKXXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:46:42 -0500
Date: Wed, 24 Nov 2004 17:15:30 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, tridge@samba.org
Cc: uweigand@de.ibm.com
Subject: [PATCH] Sync in core time granuality with filesystems
Message-ID: <20041124161530.GD2729@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch corrects a problem that was originally added with the 
nanosecond timestamps in stat patch. The problem is that some file systems
don't have enough space in their on disk inode to save nanosecond
timestamps, so they truncate the c/a/mtime to seconds when flushing
an dirty node.  In core the inode would have full jiffies granuality.

This can be observed by programs as a timestamp that jumps backwards
under specific loads when an inode is flushed and then reloaded 
from disk.

The problem was already known when the original patch went in, but
it wasn't deemed important enough at that time. So far there
has been only one report of it causing problems. Now Tridge is worried
that it will break running Excel over samba4 because Excel seems
to do very anal timestamp checking and samba4 will supply 100ns 
timestamps over the network.

This patch solves it by putting the time resolution into the 
superblock of a fs and always rounding the in core timestamps
to that granuality.

This also supercedes some previous ext2/3 hacks to flush the inode less
often when only the subsecond timestamp changes.

I tried to keep the overhead low, in particular it tries to keep
divisions out of fast paths as far as possible.

The patch is quite big but 99% of it is just relatively straight
forward search'n'replace in a lot of fs. Unconverted filesystems
will default to a 1ns granuality, but may still show the problem
if they continue to use CURRENT_TIME. I converted all in tree
fs.

One possible future extension of this would be to have two
time granualities per superblock - one that specifies the
visible resolution, and the other to specify how often
timestamps should be flushed to disk, which could be tuned
with a mount option per fs (e.g. often m/atimes don't need to be flushed 
every second). Would be easy to do as an addon if someone is interested.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/char/qtronix.c linux-2.6.10rc2-time/drivers/char/qtronix.c
--- linux-2.6.10rc2/drivers/char/qtronix.c	2004-11-15 12:34:33.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/char/qtronix.c	2004-11-21 16:57:24.000000000 +0100
@@ -537,7 +537,8 @@ repeat:
 		i--;
 	}
 	if (count-i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		struct inode *inode = file->f_dentry->d_inode;
+		inode->i_atime = current_fs_time(inode->i_sb);
 		return count-i;
 	}
 	if (signal_pending(current))
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/char/random.c linux-2.6.10rc2-time/drivers/char/random.c
--- linux-2.6.10rc2/drivers/char/random.c	2004-11-15 12:34:33.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/char/random.c	2004-11-21 16:35:00.000000000 +0100
@@ -1721,8 +1721,9 @@ random_write(struct file * file, const c
 	if (p == buffer) {
 		return (ssize_t)ret;
 	} else {
-		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(file->f_dentry->d_inode);
+		struct inode *inode = file->f_dentry->d_inode;
+	        inode->i_mtime = current_fs_time(inode->i_sb);
+		mark_inode_dirty(inode);
 		return (ssize_t)(p - buffer);
 	}
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/char/sonypi.c linux-2.6.10rc2-time/drivers/char/sonypi.c
--- linux-2.6.10rc2/drivers/char/sonypi.c	2004-11-15 12:34:33.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/char/sonypi.c	2004-11-21 17:07:31.000000000 +0100
@@ -566,7 +566,7 @@ static ssize_t sonypi_misc_read(struct f
 	}
 
 	if (ret > 0)
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		inode->i_atime = current_fs_time(inode->i_sb);
 
 	return ret;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/char/tty_io.c linux-2.6.10rc2-time/drivers/char/tty_io.c
--- linux-2.6.10rc2/drivers/char/tty_io.c	2004-11-15 12:34:33.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/char/tty_io.c	2004-11-21 17:07:31.000000000 +0100
@@ -1011,7 +1011,7 @@ static ssize_t tty_read(struct file * fi
 	tty_ldisc_deref(ld);
 	unlock_kernel();
 	if (i > 0)
-		inode->i_atime = CURRENT_TIME;
+		inode->i_atime = current_fs_time(inode->i_sb);
 	return i;
 }
 
@@ -1088,7 +1088,8 @@ static inline ssize_t do_tty_write(
 		cond_resched();
 	}
 	if (written) {
-		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		struct inode *inode = file->f_dentry->d_inode;
+		inode->i_mtime = current_fs_time(inode->i_sb);
 		ret = written;
 	}
 	up(&tty->atomic_write);
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/isdn/capi/capifs.c linux-2.6.10rc2-time/drivers/isdn/capi/capifs.c
--- linux-2.6.10rc2/drivers/isdn/capi/capifs.c	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/isdn/capi/capifs.c	2004-11-21 23:05:14.000000000 +0100
@@ -93,6 +93,7 @@ capifs_fill_super(struct super_block *s,
 	s->s_blocksize_bits = 10;
 	s->s_magic = CAPIFS_SUPER_MAGIC;
 	s->s_op = &capifs_sops;
+	s->s_time_gran = 1;
 
 	inode = new_inode(s);
 	if (!inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/misc/ibmasm/ibmasmfs.c linux-2.6.10rc2-time/drivers/misc/ibmasm/ibmasmfs.c
--- linux-2.6.10rc2/drivers/misc/ibmasm/ibmasmfs.c	2004-11-15 12:34:36.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/misc/ibmasm/ibmasmfs.c	2004-11-21 23:35:15.000000000 +0100
@@ -131,6 +131,7 @@ static int ibmasmfs_fill_super (struct s
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = IBMASMFS_MAGIC;
 	sb->s_op = &ibmasmfs_s_ops;
+	sb->s_time_gran = 1;
 
 	root = ibmasmfs_make_inode (sb, S_IFDIR | 0500);
 	if (!root)
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/oprofile/oprofilefs.c linux-2.6.10rc2-time/drivers/oprofile/oprofilefs.c
--- linux-2.6.10rc2/drivers/oprofile/oprofilefs.c	2004-11-15 12:34:40.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/oprofile/oprofilefs.c	2004-11-21 23:05:14.000000000 +0100
@@ -250,6 +250,7 @@ static int oprofilefs_fill_super(struct 
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = OPROFILEFS_MAGIC;
 	sb->s_op = &s_ops;
+	sb->s_time_gran = 1;
 
 	root_inode = oprofilefs_get_inode(sb, S_IFDIR | 0755);
 	if (!root_inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/usb/core/inode.c linux-2.6.10rc2-time/drivers/usb/core/inode.c
--- linux-2.6.10rc2/drivers/usb/core/inode.c	2004-11-15 12:34:46.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/usb/core/inode.c	2004-11-21 23:09:09.000000000 +0100
@@ -434,6 +434,7 @@ static int usbfs_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = USBDEVICE_SUPER_MAGIC;
 	sb->s_op = &usbfs_ops;
+	sb->s_time_gran = 1;
 	inode = usbfs_get_inode(sb, S_IFDIR | 0755, 0);
 
 	if (!inode) {
diff -urpN -X ../KDIFX linux-2.6.10rc2/drivers/usb/gadget/inode.c linux-2.6.10rc2-time/drivers/usb/gadget/inode.c
--- linux-2.6.10rc2/drivers/usb/gadget/inode.c	2004-11-15 12:34:46.000000000 +0100
+++ linux-2.6.10rc2-time/drivers/usb/gadget/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -2022,6 +2022,7 @@ gadgetfs_fill_super (struct super_block 
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = GADGETFS_MAGIC;
 	sb->s_op = &gadget_fs_operations;
+	sb->s_time_gran = 1;
 
 	/* root inode */
 	inode = gadgetfs_make_inode (sb,
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/adfs/inode.c linux-2.6.10rc2-time/fs/adfs/inode.c
--- linux-2.6.10rc2/fs/adfs/inode.c	2004-10-19 01:55:26.000000000 +0200
+++ linux-2.6.10rc2-time/fs/adfs/inode.c	2004-11-21 23:28:02.000000000 +0100
@@ -210,7 +210,7 @@ adfs_adfs2unix_time(struct timespec *tv,
 	return;
 
  cur_time:
-	*tv = CURRENT_TIME;
+	*tv = CURRENT_TIME_SEC;
 	return;
 
  too_early:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/affs/amigaffs.c linux-2.6.10rc2-time/fs/affs/amigaffs.c
--- linux-2.6.10rc2/fs/affs/amigaffs.c	2004-10-19 01:55:26.000000000 +0200
+++ linux-2.6.10rc2-time/fs/affs/amigaffs.c	2004-11-21 23:28:02.000000000 +0100
@@ -68,7 +68,7 @@ affs_insert_hash(struct inode *dir, stru
 	mark_buffer_dirty_inode(dir_bh, dir);
 	affs_brelse(dir_bh);
 
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	dir->i_version++;
 	mark_inode_dirty(dir);
 
@@ -121,7 +121,7 @@ affs_remove_hash(struct inode *dir, stru
 
 	affs_brelse(bh);
 
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	dir->i_version++;
 	mark_inode_dirty(dir);
 
@@ -319,7 +319,7 @@ affs_remove_header(struct dentry *dentry
 	else
 		inode->i_nlink = 0;
 	affs_unlock_link(inode);
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 
 done:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/affs/file.c linux-2.6.10rc2-time/fs/affs/file.c
--- linux-2.6.10rc2/fs/affs/file.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/affs/file.c	2004-11-21 23:28:02.000000000 +0100
@@ -499,7 +499,7 @@ affs_file_write(struct file *file, const
 	retval = generic_file_write (file, buf, count, ppos);
 	if (retval >0) {
 		struct inode *inode = file->f_dentry->d_inode;
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 	}
 	return retval;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/affs/inode.c linux-2.6.10rc2-time/fs/affs/inode.c
--- linux-2.6.10rc2/fs/affs/inode.c	2004-10-19 01:55:26.000000000 +0200
+++ linux-2.6.10rc2-time/fs/affs/inode.c	2004-11-21 23:28:01.000000000 +0100
@@ -322,7 +322,7 @@ affs_new_inode(struct inode *dir)
 	inode->i_gid     = current->fsgid;
 	inode->i_ino     = block;
 	inode->i_nlink   = 1;
-	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	AFFS_I(inode)->i_opencnt = 0;
 	AFFS_I(inode)->i_blkcnt = 0;
 	AFFS_I(inode)->i_lc = NULL;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/attr.c linux-2.6.10rc2-time/fs/attr.c
--- linux-2.6.10rc2/fs/attr.c	2004-08-15 19:45:40.000000000 +0200
+++ linux-2.6.10rc2-time/fs/attr.c	2004-11-21 18:26:17.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
+#include <linux/time.h>
 
 /* Taken over from the old code... */
 
@@ -87,11 +88,14 @@ int inode_setattr(struct inode * inode, 
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode->i_atime = timespec_trunc(attr->ia_atime,
+						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
+		inode->i_mtime = timespec_trunc(attr->ia_mtime,
+						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode->i_ctime = timespec_trunc(attr->ia_ctime,
+						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -133,7 +137,7 @@ int notify_change(struct dentry * dentry
 	struct inode *inode = dentry->d_inode;
 	mode_t mode = inode->i_mode;
 	int error;
-	struct timespec now = CURRENT_TIME;
+	struct timespec now = current_fs_time(inode->i_sb);
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/autofs/inode.c linux-2.6.10rc2-time/fs/autofs/inode.c
--- linux-2.6.10rc2/fs/autofs/inode.c	2004-11-15 12:35:16.000000000 +0100
+++ linux-2.6.10rc2-time/fs/autofs/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -147,6 +147,7 @@ int autofs_fill_super(struct super_block
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
 	s->s_op = &autofs_sops;
+	s->s_time_gran = 1;
 
 	root_inode = iget(s, AUTOFS_ROOT_INO);
 	root = d_alloc_root(root_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/autofs4/inode.c linux-2.6.10rc2-time/fs/autofs4/inode.c
--- linux-2.6.10rc2/fs/autofs4/inode.c	2004-11-15 12:35:16.000000000 +0100
+++ linux-2.6.10rc2-time/fs/autofs4/inode.c	2004-11-21 23:28:01.000000000 +0100
@@ -211,6 +211,7 @@ int autofs4_fill_super(struct super_bloc
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
 	s->s_op = &autofs4_sops;
+	s->s_time_gran = 1;
 
 	/*
 	 * Get the root inode and dentry, but defer checking for errors.
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/bad_inode.c linux-2.6.10rc2-time/fs/bad_inode.c
--- linux-2.6.10rc2/fs/bad_inode.c	2004-08-15 19:45:40.000000000 +0200
+++ linux-2.6.10rc2-time/fs/bad_inode.c	2004-11-21 17:28:40.000000000 +0100
@@ -105,7 +105,8 @@ void make_bad_inode(struct inode * inode
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = 
+		current_fs_time(inode->i_sb);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_fop = &bad_file_ops;	
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/bfs/dir.c linux-2.6.10rc2-time/fs/bfs/dir.c
--- linux-2.6.10rc2/fs/bfs/dir.c	2004-06-16 12:23:18.000000000 +0200
+++ linux-2.6.10rc2-time/fs/bfs/dir.c	2004-11-21 23:28:01.000000000 +0100
@@ -100,7 +100,7 @@ static int bfs_create(struct inode * dir
 	info->si_freei--;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blocks = inode->i_blksize = 0;
 	inode->i_op = &bfs_file_inops;
 	inode->i_fop = &bfs_file_operations;
@@ -164,7 +164,7 @@ static int bfs_link(struct dentry * old,
 		return err;
 	}
 	inode->i_nlink++;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	atomic_inc(&inode->i_count);
 	d_instantiate(new, inode);
@@ -193,7 +193,7 @@ static int bfs_unlink(struct inode * dir
 	}
 	de->ino = 0;
 	mark_buffer_dirty(bh);
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	inode->i_nlink--;
 	inode->i_ctime = dir->i_ctime;
@@ -245,11 +245,11 @@ static int bfs_rename(struct inode * old
 			goto end_rename;
 	}
 	old_de->ino = 0;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(new_inode);
 	}
 	mark_buffer_dirty(old_bh);
@@ -300,9 +300,9 @@ static int bfs_add_entry(struct inode * 
 			if (!de->ino) {
 				if ((block-sblock)*BFS_BSIZE + off >= dir->i_size) {
 					dir->i_size += BFS_DIRENT_SIZE;
-					dir->i_ctime = CURRENT_TIME;
+					dir->i_ctime = CURRENT_TIME_SEC;
 				}
-				dir->i_mtime = CURRENT_TIME;
+				dir->i_mtime = CURRENT_TIME_SEC;
 				mark_inode_dirty(dir);
 				de->ino = ino;
 				for (i=0; i<BFS_NAMELEN; i++)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/bfs/inode.c linux-2.6.10rc2-time/fs/bfs/inode.c
--- linux-2.6.10rc2/fs/bfs/inode.c	2004-10-19 01:55:26.000000000 +0200
+++ linux-2.6.10rc2-time/fs/bfs/inode.c	2004-11-21 23:28:01.000000000 +0100
@@ -149,7 +149,7 @@ static void bfs_delete_inode(struct inod
 	}
 	
 	inode->i_size = 0;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	lock_kernel();
 	mark_inode_dirty(inode);
 	block = (ino - BFS_ROOT_INO)/BFS_INODES_PER_BLOCK + 1;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/binfmt_misc.c linux-2.6.10rc2-time/fs/binfmt_misc.c
--- linux-2.6.10rc2/fs/binfmt_misc.c	2004-08-15 19:45:40.000000000 +0200
+++ linux-2.6.10rc2-time/fs/binfmt_misc.c	2004-11-21 17:29:08.000000000 +0100
@@ -509,7 +509,8 @@ static struct inode *bm_get_inode(struct
 		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = 
+			current_fs_time(inode->i_sb);
 	}
 	return inode;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/cifs/connect.c linux-2.6.10rc2-time/fs/cifs/connect.c
--- linux-2.6.10rc2/fs/cifs/connect.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/cifs/connect.c	2004-11-21 16:36:59.000000000 +0100
@@ -1444,6 +1444,8 @@ cifs_mount(struct super_block *sb, struc
 			sb->s_maxbytes = (u64) 1 << 31;	/* 2 GB */
 	}
 
+	sb->s_time_gran = 100;
+
 /* on error free sesinfo and tcon struct if needed */
 	if (rc) {
 		/* if session setup failed, use count is zero but
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/cifs/file.c linux-2.6.10rc2-time/fs/cifs/file.c
--- linux-2.6.10rc2/fs/cifs/file.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/cifs/file.c	2004-11-21 17:40:38.000000000 +0100
@@ -681,8 +681,9 @@ cifs_write(struct file * file, const cha
 	/* since the write may have blocked check these pointers again */
 	if(file->f_dentry) {
 		if(file->f_dentry->d_inode) {
-			file->f_dentry->d_inode->i_ctime = file->f_dentry->d_inode->i_mtime =
-				CURRENT_TIME;
+			struct inode *inode = file->f_dentry->d_inode;
+			inode->i_ctime = inode->i_mtime =
+				current_fs_time(inode->i_sb);
 			if (total_written > 0) {
 				if (*poffset > file->f_dentry->d_inode->i_size)
 					i_size_write(file->f_dentry->d_inode, *poffset);
@@ -756,7 +757,7 @@ cifs_partialpagewrite(struct page *page,
 					to-from, &offset);
 			read_lock(&GlobalSMBSeslock);
 		/* Does mm or vfs already set times? */
-			inode->i_atime = inode->i_mtime = CURRENT_TIME;
+			inode->i_atime = inode->i_mtime = current_fs_time(inode->i_sb);
 			if ((bytes_written > 0) && (offset)) {
 				rc = 0;
 			} else if(bytes_written < 0) {
@@ -1260,7 +1261,8 @@ static int cifs_readpage_worker(struct f
 		cFYI(1,("Bytes read %d ",rc));
 	}
                                                                                                                            
-	file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+	file->f_dentry->d_inode->i_atime = 
+		current_fs_time(file->f_dentry->d_inode->i_sb);
                                                                                                                            
 	if(PAGE_CACHE_SIZE > rc) {
 		memset(read_data+rc, 0, PAGE_CACHE_SIZE - rc);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/cifs/inode.c linux-2.6.10rc2-time/fs/cifs/inode.c
--- linux-2.6.10rc2/fs/cifs/inode.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/cifs/inode.c	2004-11-21 17:07:30.000000000 +0100
@@ -429,7 +429,7 @@ cifs_unlink(struct inode *inode, struct 
 	cifsInode = CIFS_I(direntry->d_inode);
 	cifsInode->time = 0;	/* will force revalidate to get info when needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
-	    CURRENT_TIME;
+	    current_fs_time(inode->i_sb);
 	cifsInode = CIFS_I(inode);
 	cifsInode->time = 0;	/* force revalidate of dir as well */
 
@@ -542,7 +542,7 @@ cifs_rmdir(struct inode *inode, struct d
 	cifsInode = CIFS_I(direntry->d_inode);
 	cifsInode->time = 0;	/* force revalidate to go get info when needed */
 	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
-	    CURRENT_TIME;
+	    current_fs_time(inode->i_sb);
 
 	if (full_path)
 		kfree(full_path);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/coda/dir.c linux-2.6.10rc2-time/fs/coda/dir.c
--- linux-2.6.10rc2/fs/coda/dir.c	2004-04-06 13:12:16.000000000 +0200
+++ linux-2.6.10rc2-time/fs/coda/dir.c	2004-11-21 23:12:44.000000000 +0100
@@ -183,7 +183,7 @@ static inline void coda_dir_changed(stru
 	/* optimistically we can also act as if our nose bleeds. The
          * granularity of the mtime is coarse anyways so we might actually be
          * right most of the time. Note: we only do this for directories. */
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 #endif
 	if (link)
 		dir->i_nlink += link;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/coda/file.c linux-2.6.10rc2-time/fs/coda/file.c
--- linux-2.6.10rc2/fs/coda/file.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/coda/file.c	2004-11-21 23:28:01.000000000 +0100
@@ -83,7 +83,7 @@ coda_file_write(struct file *coda_file, 
 
 	coda_inode->i_size = host_inode->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
-	coda_inode->i_mtime = coda_inode->i_ctime = CURRENT_TIME;
+	coda_inode->i_mtime = coda_inode->i_ctime = CURRENT_TIME_SEC;
 	up(&coda_inode->i_sem);
 
 	return ret;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/coda/inode.c linux-2.6.10rc2-time/fs/coda/inode.c
--- linux-2.6.10rc2/fs/coda/inode.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/coda/inode.c	2004-11-21 23:28:01.000000000 +0100
@@ -253,7 +253,7 @@ int coda_setattr(struct dentry *de, stru
 	
 	memset(&vattr, 0, sizeof(vattr)); 
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	coda_iattr_to_vattr(iattr, &vattr);
 	vattr.va_type = C_VNON; /* cannot set type */
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/devfs/base.c linux-2.6.10rc2-time/fs/devfs/base.c
--- linux-2.6.10rc2/fs/devfs/base.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/devfs/base.c	2004-11-21 23:05:14.000000000 +0100
@@ -2533,6 +2533,7 @@ static int devfs_fill_super(struct super
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = DEVFS_SUPER_MAGIC;
 	sb->s_op = &devfs_sops;
+	sb->s_time_gran = 1;
 	if ((root_inode = _devfs_get_vfs_inode(sb, root_entry, NULL)) == NULL)
 		goto out_no_root;
 	sb->s_root = d_alloc_root(root_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/devpts/inode.c linux-2.6.10rc2-time/fs/devpts/inode.c
--- linux-2.6.10rc2/fs/devpts/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/devpts/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -103,6 +103,7 @@ devpts_fill_super(struct super_block *s,
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
 	s->s_xattr = devpts_xattr_handlers;
+	s->s_time_gran = 1;
 
 	inode = new_inode(s);
 	if (!inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/dir.c linux-2.6.10rc2-time/fs/ext2/dir.c
--- linux-2.6.10rc2/fs/ext2/dir.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext2/dir.c	2004-11-21 23:28:01.000000000 +0100
@@ -426,7 +426,7 @@ void ext2_set_link(struct inode *dir, st
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
 	ext2_put_page(page);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 }
@@ -516,7 +516,7 @@ got_it:
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
@@ -564,7 +564,7 @@ int ext2_delete_entry (struct ext2_dir_e
 		pde->rec_len = cpu_to_le16(to-from);
 	dir->inode = 0;
 	err = ext2_commit_chunk(page, from, to);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
 out:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/ialloc.c linux-2.6.10rc2-time/fs/ext2/ialloc.c
--- linux-2.6.10rc2/fs/ext2/ialloc.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/ext2/ialloc.c	2004-11-21 23:28:00.000000000 +0100
@@ -577,7 +577,7 @@ got:
 	inode->i_ino = ino;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_flags = EXT2_I(dir)->i_flags & ~EXT2_BTREE_FL;
 	if (S_ISLNK(mode))
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/inode.c linux-2.6.10rc2-time/fs/ext2/inode.c
--- linux-2.6.10rc2/fs/ext2/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext2/inode.c	2004-11-21 23:28:00.000000000 +0100
@@ -493,7 +493,7 @@ static inline int ext2_splice_branch(str
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -953,7 +953,7 @@ do_indirects:
 		case EXT2_TIND_BLOCK:
 			;
 	}
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	if (inode_needs_sync(inode)) {
 		sync_mapping_buffers(inode->i_mapping);
 		ext2_sync_inode (inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/ioctl.c linux-2.6.10rc2-time/fs/ext2/ioctl.c
--- linux-2.6.10rc2/fs/ext2/ioctl.c	2004-06-16 12:23:19.000000000 +0200
+++ linux-2.6.10rc2-time/fs/ext2/ioctl.c	2004-11-21 23:28:00.000000000 +0100
@@ -59,7 +59,7 @@ int ext2_ioctl (struct inode * inode, st
 		ei->i_flags = flags;
 
 		ext2_set_inode_flags(inode);
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		return 0;
 	}
@@ -72,7 +72,7 @@ int ext2_ioctl (struct inode * inode, st
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		return 0;
 	default:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/namei.c linux-2.6.10rc2-time/fs/ext2/namei.c
--- linux-2.6.10rc2/fs/ext2/namei.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext2/namei.c	2004-11-21 23:28:00.000000000 +0100
@@ -211,7 +211,7 @@ static int ext2_link (struct dentry * ol
 	if (inode->i_nlink >= EXT2_LINK_MAX)
 		return -EMLINK;
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	ext2_inc_count(inode);
 	atomic_inc(&inode->i_count);
 
@@ -337,7 +337,7 @@ static int ext2_rename (struct inode * o
 			goto out_dir;
 		ext2_inc_count(old_inode);
 		ext2_set_link(new_dir, new_de, new_page, old_inode);
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
 		ext2_dec_count(new_inode);
@@ -362,7 +362,7 @@ static int ext2_rename (struct inode * o
  	 * rename.
 	 * ext2_dec_count() will mark the inode dirty.
 	 */
-	old_inode->i_ctime = CURRENT_TIME;
+	old_inode->i_ctime = CURRENT_TIME_SEC;
 
 	ext2_delete_entry (old_de, old_page);
 	ext2_dec_count(old_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/super.c linux-2.6.10rc2-time/fs/ext2/super.c
--- linux-2.6.10rc2/fs/ext2/super.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext2/super.c	2004-11-21 16:35:01.000000000 +0100
@@ -592,7 +592,6 @@ static int ext2_fill_super(struct super_
 	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
-	sb->s_flags |= MS_ONE_SECOND;
 
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext2/xattr.c linux-2.6.10rc2-time/fs/ext2/xattr.c
--- linux-2.6.10rc2/fs/ext2/xattr.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext2/xattr.c	2004-11-21 23:28:00.000000000 +0100
@@ -697,7 +697,7 @@ ext2_xattr_set2(struct inode *inode, str
 
 	/* Update the inode. */
 	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode)) {
 		error = ext2_sync_inode (inode);
 		if (error)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/ialloc.c linux-2.6.10rc2-time/fs/ext3/ialloc.c
--- linux-2.6.10rc2/fs/ext3/ialloc.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/ialloc.c	2004-11-21 23:28:00.000000000 +0100
@@ -558,7 +558,7 @@ got:
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_next_alloc_block = 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/inode.c linux-2.6.10rc2-time/fs/ext3/inode.c
--- linux-2.6.10rc2/fs/ext3/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/inode.c	2004-11-21 23:28:00.000000000 +0100
@@ -626,7 +626,7 @@ static int ext3_splice_branch(handle_t *
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
 
 	/* had we spliced it onto indirect block? */
@@ -2199,7 +2199,7 @@ do_indirects:
 			;
 	}
 	up(&ei->truncate_sem);
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
 
 	/* In a multi-transaction truncate, we only make the final
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/ioctl.c linux-2.6.10rc2-time/fs/ext3/ioctl.c
--- linux-2.6.10rc2/fs/ext3/ioctl.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/ioctl.c	2004-11-21 23:28:00.000000000 +0100
@@ -87,7 +87,7 @@ int ext3_ioctl (struct inode * inode, st
 		ei->i_flags = flags;
 
 		ext3_set_inode_flags(inode);
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 
 		err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
@@ -121,7 +121,7 @@ flags_err:
 			return PTR_ERR(handle);
 		err = ext3_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
-			inode->i_ctime = CURRENT_TIME;
+			inode->i_ctime = CURRENT_TIME_SEC;
 			inode->i_generation = generation;
 			err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 		}
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/namei.c linux-2.6.10rc2-time/fs/ext3/namei.c
--- linux-2.6.10rc2/fs/ext3/namei.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/namei.c	2004-11-21 23:27:59.000000000 +0100
@@ -1251,7 +1251,7 @@ static int add_dirent_to_buf(handle_t *h
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	ext3_update_dx_flag(dir);
 	dir->i_version++;
 	ext3_mark_inode_dirty(handle, dir);
@@ -2029,7 +2029,7 @@ static int ext3_rmdir (struct inode * di
 	 * recovery. */
 	inode->i_size = 0;
 	ext3_orphan_add(handle, inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
 	dir->i_nlink--;
 	ext3_update_dx_flag(dir);
@@ -2079,7 +2079,7 @@ static int ext3_unlink(struct inode * di
 	retval = ext3_delete_entry(handle, dir, de, bh);
 	if (retval)
 		goto end_unlink;
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	inode->i_nlink--;
@@ -2169,7 +2169,7 @@ retry:
 	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
 
@@ -2270,7 +2270,7 @@ static int ext3_rename (struct inode * o
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old_inode->i_ctime = CURRENT_TIME;
+	old_inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, old_inode);
 
 	/*
@@ -2303,9 +2303,9 @@ static int ext3_rename (struct inode * o
 
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 	}
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	ext3_update_dx_flag(old_dir);
 	if (dir_bh) {
 		BUFFER_TRACE(dir_bh, "get_write_access");
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/super.c linux-2.6.10rc2-time/fs/ext3/super.c
--- linux-2.6.10rc2/fs/ext3/super.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/super.c	2004-11-21 16:35:01.000000000 +0100
@@ -1310,7 +1310,6 @@ static int ext3_fill_super (struct super
 	if (!parse_options ((char *) data, sb, &journal_inum, NULL, 0))
 		goto failed_mount;
 
-	sb->s_flags |= MS_ONE_SECOND;
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ext3/xattr.c linux-2.6.10rc2-time/fs/ext3/xattr.c
--- linux-2.6.10rc2/fs/ext3/xattr.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ext3/xattr.c	2004-11-21 23:27:59.000000000 +0100
@@ -718,7 +718,7 @@ getblk_failed:
 
 	/* Update the inode. */
 	EXT3_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/fat/dir.c linux-2.6.10rc2-time/fs/fat/dir.c
--- linux-2.6.10rc2/fs/fat/dir.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/fat/dir.c	2004-11-21 23:27:59.000000000 +0100
@@ -761,7 +761,7 @@ int fat_new_dir(struct inode *dir, struc
 	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart>>16);
 	mark_buffer_dirty(bh);
 	brelse(bh);
-	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 
 	return 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/fat/file.c linux-2.6.10rc2-time/fs/fat/file.c
--- linux-2.6.10rc2/fs/fat/file.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/fat/file.c	2004-11-21 23:27:59.000000000 +0100
@@ -77,7 +77,7 @@ static ssize_t fat_file_write(struct fil
 
 	retval = generic_file_write(filp, buf, count, ppos);
 	if (retval > 0) {
-		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
 	}
@@ -103,6 +103,6 @@ void fat_truncate(struct inode *inode)
 	fat_free(inode, nr_clusters);
 	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 	unlock_kernel();
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfs/catalog.c linux-2.6.10rc2-time/fs/hfs/catalog.c
--- linux-2.6.10rc2/fs/hfs/catalog.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/hfs/catalog.c	2004-11-21 23:27:59.000000000 +0100
@@ -121,7 +121,7 @@ int hfs_cat_create(u32 cnid, struct inod
 		goto err1;
 
 	dir->i_size++;
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	hfs_find_exit(&fd);
 	return 0;
@@ -248,7 +248,7 @@ int hfs_cat_delete(u32 cnid, struct inod
 	}
 
 	dir->i_size--;
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	res = 0;
 out:
@@ -301,7 +301,7 @@ int hfs_cat_move(u32 cnid, struct inode 
 	if (err)
 		goto out;
 	dst_dir->i_size++;
-	dst_dir->i_mtime = dst_dir->i_ctime = CURRENT_TIME;
+	dst_dir->i_mtime = dst_dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dst_dir);
 
 	/* finally remove the old entry */
@@ -313,7 +313,7 @@ int hfs_cat_move(u32 cnid, struct inode 
 	if (err)
 		goto out;
 	src_dir->i_size--;
-	src_dir->i_mtime = src_dir->i_ctime = CURRENT_TIME;
+	src_dir->i_mtime = src_dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(src_dir);
 
 	type = entry.type;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfs/dir.c linux-2.6.10rc2-time/fs/hfs/dir.c
--- linux-2.6.10rc2/fs/hfs/dir.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/hfs/dir.c	2004-11-21 23:27:58.000000000 +0100
@@ -248,7 +248,7 @@ int hfs_unlink(struct inode *dir, struct
 
 	inode->i_nlink--;
 	hfs_delete_inode(inode);
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 
 	return res;
@@ -274,7 +274,7 @@ int hfs_rmdir(struct inode *dir, struct 
 	if (res)
 		return res;
 	inode->i_nlink = 0;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	hfs_delete_inode(inode);
 	mark_inode_dirty(inode);
 	return 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfs/inode.c linux-2.6.10rc2-time/fs/hfs/inode.c
--- linux-2.6.10rc2/fs/hfs/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/hfs/inode.c	2004-11-21 23:27:58.000000000 +0100
@@ -169,7 +169,7 @@ struct inode *hfs_new_inode(struct inode
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_nlink = 1;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blksize = HFS_SB(sb)->alloc_blksz;
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfsplus/catalog.c linux-2.6.10rc2-time/fs/hfsplus/catalog.c
--- linux-2.6.10rc2/fs/hfsplus/catalog.c	2004-10-19 01:55:27.000000000 +0200
+++ linux-2.6.10rc2-time/fs/hfsplus/catalog.c	2004-11-21 23:27:58.000000000 +0100
@@ -187,7 +187,7 @@ int hfsplus_create_cat(u32 cnid, struct 
 		goto err1;
 
 	dir->i_size++;
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	hfs_find_exit(&fd);
 	return 0;
@@ -269,7 +269,7 @@ int hfsplus_delete_cat(u32 cnid, struct 
 		goto out;
 
 	dir->i_size--;
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 out:
 	hfs_find_exit(&fd);
@@ -315,7 +315,7 @@ int hfsplus_rename_cat(u32 cnid,
 	if (err)
 		goto out;
 	dst_dir->i_size++;
-	dst_dir->i_mtime = dst_dir->i_ctime = CURRENT_TIME;
+	dst_dir->i_mtime = dst_dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dst_dir);
 
 	/* finally remove the old entry */
@@ -327,7 +327,7 @@ int hfsplus_rename_cat(u32 cnid,
 	if (err)
 		goto out;
 	src_dir->i_size--;
-	src_dir->i_mtime = src_dir->i_ctime = CURRENT_TIME;
+	src_dir->i_mtime = src_dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(src_dir);
 
 	/* remove old thread entry */
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfsplus/dir.c linux-2.6.10rc2-time/fs/hfsplus/dir.c
--- linux-2.6.10rc2/fs/hfsplus/dir.c	2004-06-16 12:23:19.000000000 +0200
+++ linux-2.6.10rc2-time/fs/hfsplus/dir.c	2004-11-21 23:27:58.000000000 +0100
@@ -294,7 +294,7 @@ int hfsplus_link(struct dentry *src_dent
 	inode->i_nlink++;
 	hfsplus_instantiate(dst_dentry, inode, cnid);
 	atomic_inc(&inode->i_count);
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	HFSPLUS_SB(sb).file_count++;
 	sb->s_dirt = 1;
@@ -340,7 +340,7 @@ int hfsplus_unlink(struct inode *dir, st
 		} else
 			inode->i_flags |= S_DEAD;
 	}
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 
 	return res;
@@ -379,7 +379,7 @@ int hfsplus_rmdir(struct inode *dir, str
 	if (res)
 		return res;
 	inode->i_nlink = 0;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
 	return 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfsplus/inode.c linux-2.6.10rc2-time/fs/hfsplus/inode.c
--- linux-2.6.10rc2/fs/hfsplus/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/hfsplus/inode.c	2004-11-21 23:27:58.000000000 +0100
@@ -334,7 +334,7 @@ struct inode *hfsplus_new_inode(struct s
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_nlink = 1;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blksize = HFSPLUS_SB(sb).alloc_blksz;
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
 	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hfsplus/ioctl.c linux-2.6.10rc2-time/fs/hfsplus/ioctl.c
--- linux-2.6.10rc2/fs/hfsplus/ioctl.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/hfsplus/ioctl.c	2004-11-21 23:27:58.000000000 +0100
@@ -73,7 +73,7 @@ int hfsplus_ioctl(struct inode *inode, s
 		else
 			HFSPLUS_I(inode).userflags &= ~HFSPLUS_FLG_NODUMP;
 
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		return 0;
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hpfs/file.c linux-2.6.10rc2-time/fs/hpfs/file.c
--- linux-2.6.10rc2/fs/hpfs/file.c	2004-04-06 13:12:17.000000000 +0200
+++ linux-2.6.10rc2-time/fs/hpfs/file.c	2004-11-21 23:27:58.000000000 +0100
@@ -116,7 +116,7 @@ static ssize_t hpfs_file_write(struct fi
 	retval = generic_file_write(file, buf, count, ppos);
 	if (retval > 0) {
 		struct inode *inode = file->f_dentry->d_inode;
-		inode->i_mtime = CURRENT_TIME;
+		inode->i_mtime = CURRENT_TIME_SEC;
 		hpfs_i(inode)->i_dirty = 1;
 	}
 	return retval;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/hugetlbfs/inode.c linux-2.6.10rc2-time/fs/hugetlbfs/inode.c
--- linux-2.6.10rc2/fs/hugetlbfs/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/hugetlbfs/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -670,6 +670,7 @@ hugetlbfs_fill_super(struct super_block 
 	sb->s_blocksize_bits = HPAGE_SHIFT;
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
+	sb->s_time_gran = 1;
 	inode = hugetlbfs_get_inode(sb, config.uid, config.gid,
 					S_IFDIR | config.mode, 0);
 	if (!inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/inode.c linux-2.6.10rc2-time/fs/inode.c
--- linux-2.6.10rc2/fs/inode.c	2004-11-15 12:35:17.000000000 +0100
+++ linux-2.6.10rc2-time/fs/inode.c	2004-11-21 17:42:38.000000000 +0100
@@ -1130,19 +1130,6 @@ sector_t bmap(struct inode * inode, sect
 
 EXPORT_SYMBOL(bmap);
 
-/*
- * Return true if the filesystem which backs this inode considers the two
- * passed timespecs to be sufficiently different to warrant flushing the
- * altered time out to disk.
- */
-static int inode_times_differ(struct inode *inode,
-			struct timespec *old, struct timespec *new)
-{
-	if (IS_ONE_SECOND(inode))
-		return old->tv_sec != new->tv_sec;
-	return !timespec_equal(old, new);
-}
-
 /**
  *	update_atime	-	update the access time
  *	@inode: inode accessed
@@ -1162,8 +1149,8 @@ void update_atime(struct inode *inode)
 	if (IS_RDONLY(inode))
 		return;
 
-	now = current_kernel_time();
-	if (inode_times_differ(inode, &inode->i_atime, &now)) {
+	now = current_fs_time(inode->i_sb);
+	if (!timespec_equal(&inode->i_atime, &now)) {
 		inode->i_atime = now;
 		mark_inode_dirty_sync(inode);
 	} else {
@@ -1193,14 +1180,13 @@ void inode_update_time(struct inode *ino
 	if (IS_RDONLY(inode))
 		return;
 
-	now = current_kernel_time();
-
-	if (inode_times_differ(inode, &inode->i_mtime, &now))
+	now = current_fs_time(inode->i_sb);
+	if (!timespec_equal(&inode->i_mtime, &now))
 		sync_it = 1;
 	inode->i_mtime = now;
 
 	if (ctime_too) {
-		if (inode_times_differ(inode, &inode->i_ctime, &now))
+		if (!timespec_equal(&inode->i_ctime, &now))
 			sync_it = 1;
 		inode->i_ctime = now;
 	}
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jffs/inode-v23.c linux-2.6.10rc2-time/fs/jffs/inode-v23.c
--- linux-2.6.10rc2/fs/jffs/inode-v23.c	2004-08-15 19:45:42.000000000 +0200
+++ linux-2.6.10rc2-time/fs/jffs/inode-v23.c	2004-11-21 23:27:52.000000000 +0100
@@ -298,7 +298,7 @@ jffs_setattr(struct dentry *dentry, stru
 		if (len) {
 			invalidate_inode_pages(inode->i_mapping);
 		}
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		inode->i_mtime = inode->i_ctime;
 	}
 	if (update_all || iattr->ia_valid & ATTR_ATIME) {
@@ -548,7 +548,7 @@ jffs_rename(struct inode *old_dir, struc
 	/* This is a kind of update of the inode we're about to make
 	   here.  This is what they do in ext2fs.  Kind of.  */
 	if ((inode = iget(new_dir->i_sb, f->ino))) {
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		iput(inode);
 	}
@@ -1051,7 +1051,7 @@ jffs_remove(struct inode *dir, struct de
 	   from the in-memory file system structures.  */
 	jffs_insert_node(c, del_f, &raw_inode, NULL, del_node);
 
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	inode->i_nlink--;
 	inode->i_ctime = dir->i_ctime;
@@ -1518,7 +1518,7 @@ jffs_file_write(struct file *filp, const
 		inode->i_size = pos;
 		inode->i_blocks = (inode->i_size + 511) >> 9;
 	}
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	invalidate_inode_pages(inode->i_mapping);
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jffs2/fs.c linux-2.6.10rc2-time/fs/jffs2/fs.c
--- linux-2.6.10rc2/fs/jffs2/fs.c	2004-08-15 19:45:42.000000000 +0200
+++ linux-2.6.10rc2-time/fs/jffs2/fs.c	2004-11-21 23:27:58.000000000 +0100
@@ -426,7 +426,7 @@ struct inode *jffs2_new_inode (struct in
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	inode->i_gid = je16_to_cpu(ri->gid);
 	inode->i_uid = je16_to_cpu(ri->uid);
-	inode->i_atime = inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_atime = inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
 
 	inode->i_blksize = PAGE_SIZE;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jfs/namei.c linux-2.6.10rc2-time/fs/jfs/namei.c
--- linux-2.6.10rc2/fs/jfs/namei.c	2004-10-19 01:55:28.000000000 +0200
+++ linux-2.6.10rc2-time/fs/jfs/namei.c	2004-11-21 23:27:52.000000000 +0100
@@ -1233,7 +1233,7 @@ static int jfs_rename(struct inode *old_
 	old_ip->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(old_ip);
 
-	new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
+	new_dir->i_ctime = new_dir->i_mtime = current_fs_time(new_dir->i_sb);
 	mark_inode_dirty(new_dir);
 
 	/* Build list of inodes modified by this transaction */
@@ -1245,7 +1245,7 @@ static int jfs_rename(struct inode *old_
 
 	if (old_dir != new_dir) {
 		iplist[ipcount++] = new_dir;
-		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+		old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME; 
 		mark_inode_dirty(old_dir);
 	}
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/jfs/super.c linux-2.6.10rc2-time/fs/jfs/super.c
--- linux-2.6.10rc2/fs/jfs/super.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/jfs/super.c	2004-11-21 16:36:20.000000000 +0100
@@ -464,7 +464,7 @@ static int jfs_fill_super(struct super_b
 	 */
 	sb->s_maxbytes = min(((u64) PAGE_CACHE_SIZE << 32) - 1, sb->s_maxbytes);
 #endif
-
+	sb->s_time_gran = 1;
 	return 0;
 
 out_no_root:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/libfs.c linux-2.6.10rc2-time/fs/libfs.c
--- linux-2.6.10rc2/fs/libfs.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/libfs.c	2004-11-21 23:05:14.000000000 +0100
@@ -212,6 +212,7 @@ get_sb_pseudo(struct file_system_type *f
 	s->s_blocksize_bits = 10;
 	s->s_magic = magic;
 	s->s_op = ops ? ops : &default_ops;
+	s->s_time_gran = 1;
 	root = new_inode(s);
 	if (!root)
 		goto Enomem;
@@ -374,6 +375,7 @@ int simple_fill_super(struct super_block
 	s->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	s->s_magic = magic;
 	s->s_op = &s_ops;
+	s->s_time_gran = 1;
 
 	inode = new_inode(s);
 	if (!inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/locks.c linux-2.6.10rc2-time/fs/locks.c
--- linux-2.6.10rc2/fs/locks.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/locks.c	2004-11-21 13:32:00.000000000 +0100
@@ -1228,7 +1228,7 @@ void lease_get_mtime(struct inode *inode
 {
 	struct file_lock *flock = inode->i_flock;
 	if (flock && IS_LEASE(flock) && (flock->fl_type & F_WRLCK))
-		*time = CURRENT_TIME;
+		*time = current_fs_time(inode->i_sb);
 	else
 		*time = inode->i_mtime;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/minix/bitmap.c linux-2.6.10rc2-time/fs/minix/bitmap.c
--- linux-2.6.10rc2/fs/minix/bitmap.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/minix/bitmap.c	2004-11-21 23:27:52.000000000 +0100
@@ -253,7 +253,7 @@ struct inode * minix_new_inode(const str
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_ino = j;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blocks = inode->i_blksize = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
 	insert_inode_hash(inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/minix/dir.c linux-2.6.10rc2-time/fs/minix/dir.c
--- linux-2.6.10rc2/fs/minix/dir.c	2004-04-06 13:12:17.000000000 +0200
+++ linux-2.6.10rc2-time/fs/minix/dir.c	2004-11-21 23:27:51.000000000 +0100
@@ -246,7 +246,7 @@ got_it:
 	memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
 	de->inode = inode->i_ino;
 	err = dir_commit_chunk(page, from, to);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 out_put:
 	dir_put_page(page);
@@ -275,7 +275,7 @@ int minix_delete_entry(struct minix_dir_
 		unlock_page(page);
 	}
 	dir_put_page(page);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	return err;
 }
@@ -378,7 +378,7 @@ void minix_set_link(struct minix_dir_ent
 		unlock_page(page);
 	}
 	dir_put_page(page);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/minix/itree_common.c linux-2.6.10rc2-time/fs/minix/itree_common.c
--- linux-2.6.10rc2/fs/minix/itree_common.c	2004-10-19 01:55:28.000000000 +0200
+++ linux-2.6.10rc2-time/fs/minix/itree_common.c	2004-11-21 23:27:51.000000000 +0100
@@ -124,7 +124,7 @@ static inline int splice_branch(struct i
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -342,7 +342,7 @@ do_indirects:
 		}
 		first_whole++;
 	}
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/minix/namei.c linux-2.6.10rc2-time/fs/minix/namei.c
--- linux-2.6.10rc2/fs/minix/namei.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/minix/namei.c	2004-11-21 23:27:51.000000000 +0100
@@ -138,7 +138,7 @@ static int minix_link(struct dentry * ol
 	if (inode->i_nlink >= minix_sb(inode->i_sb)->s_link_max)
 		return -EMLINK;
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	inc_count(inode);
 	atomic_inc(&inode->i_count);
 	return add_nondir(dentry, inode);
@@ -259,7 +259,7 @@ static int minix_rename(struct inode * o
 			goto out_dir;
 		inc_count(old_inode);
 		minix_set_link(new_de, new_page, old_inode);
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
 		dec_count(new_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/msdos/namei.c linux-2.6.10rc2-time/fs/msdos/namei.c
--- linux-2.6.10rc2/fs/msdos/namei.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/msdos/namei.c	2004-11-21 23:27:50.000000000 +0100
@@ -243,7 +243,7 @@ static int msdos_add_entry(struct inode 
 	/*
 	 * XXX all times should be set by caller upon successful completion.
 	 */
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 
 	memcpy((*de)->name, name, MSDOS_NAME);
@@ -296,7 +296,7 @@ static int msdos_create(struct inode *di
 		unlock_kernel();
 		return res;
 	}
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	d_instantiate(dentry, inode);
 	unlock_kernel();
@@ -330,7 +330,7 @@ static int msdos_rmdir(struct inode *dir
 	mark_buffer_dirty(bh);
 	fat_detach(inode);
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	dir->i_nlink--;
 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);
@@ -392,7 +392,7 @@ out_unlock:
 
 mkdir_error:
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	dir->i_nlink--;
 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);
@@ -430,7 +430,7 @@ static int msdos_unlink(struct inode *di
 	fat_detach(inode);
 	brelse(bh);
 	inode->i_nlink = 0;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);
 	res = 0;
@@ -493,11 +493,11 @@ static int do_msdos_rename(struct inode 
 		MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
 	mark_inode_dirty(old_inode);
 	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(new_inode);
 	}
 	if (dotdot_bh) {
@@ -530,7 +530,7 @@ degenerate_case:
 		MSDOS_I(old_inode)->i_attrs &= ~ATTR_HIDDEN;
 	mark_inode_dirty(old_inode);
 	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
 	return 0;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/nfs/inode.c linux-2.6.10rc2-time/fs/nfs/inode.c
--- linux-2.6.10rc2/fs/nfs/inode.c	2004-10-19 01:55:28.000000000 +0200
+++ linux-2.6.10rc2-time/fs/nfs/inode.c	2004-11-21 16:44:02.000000000 +0100
@@ -457,6 +457,7 @@ nfs_fill_super(struct super_block *sb, s
 	if (server->flags & NFS_MOUNT_VER3) {
 		if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
 			server->namelen = NFS3_MAXNAMLEN;
+		sb->s_time_gran = 1; 
 	} else {
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
@@ -1653,6 +1654,8 @@ static int nfs4_fill_super(struct super_
 		}
 	}
 
+	sb->s_time_gran = 1;
+
 	sb->s_op = &nfs4_sops;
 	err = nfs_sb_init(sb, authflavour);
 	if (err == 0)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ntfs/mft.c linux-2.6.10rc2-time/fs/ntfs/mft.c
--- linux-2.6.10rc2/fs/ntfs/mft.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ntfs/mft.c	2004-11-21 16:34:48.000000000 +0100
@@ -2605,7 +2605,8 @@ mft_rec_already_initialized:
 			vi->i_mode &= ~S_IWUGO;
 
 		/* Set the inode times to the current time. */
-		vi->i_atime = vi->i_mtime = vi->i_ctime = current_kernel_time();
+		vi->i_atime = vi->i_mtime = vi->i_ctime = 
+			current_fs_time(vi->i_sb);
 		/*
 		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
 		 * the call to ntfs_init_big_inode() below.
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ntfs/super.c linux-2.6.10rc2-time/fs/ntfs/super.c
--- linux-2.6.10rc2/fs/ntfs/super.c	2004-11-15 12:35:18.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ntfs/super.c	2004-11-21 16:36:39.000000000 +0100
@@ -2392,6 +2392,8 @@ static int ntfs_fill_super(struct super_
 	 */
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 
+	sb->s_time_gran = 100; 
+
 	/*
 	 * Now load the metadata required for the page cache and our address
 	 * space operations to function. We do this by setting up a specialised
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/openpromfs/inode.c linux-2.6.10rc2-time/fs/openpromfs/inode.c
--- linux-2.6.10rc2/fs/openpromfs/inode.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/openpromfs/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -1039,6 +1039,7 @@ static int openprom_fill_super(struct su
 	s->s_blocksize_bits = 10;
 	s->s_magic = OPENPROM_SUPER_MAGIC;
 	s->s_op = &openprom_sops;
+	s->s_time_gran = 1;
 	root_inode = iget(s, OPENPROM_ROOT_INO);
 	if (!root_inode)
 		goto out_no_root;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/proc/inode.c linux-2.6.10rc2-time/fs/proc/inode.c
--- linux-2.6.10rc2/fs/proc/inode.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/proc/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -240,6 +240,7 @@ int proc_fill_super(struct super_block *
 	s->s_blocksize_bits = 10;
 	s->s_magic = PROC_SUPER_MAGIC;
 	s->s_op = &proc_sops;
+	s->s_time_gran = 1;
 	
 	root_inode = proc_get_inode(s, PROC_ROOT_INO, &proc_root);
 	if (!root_inode)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/qnx4/inode.c linux-2.6.10rc2-time/fs/qnx4/inode.c
--- linux-2.6.10rc2/fs/qnx4/inode.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/qnx4/inode.c	2004-11-21 23:27:50.000000000 +0100
@@ -189,7 +189,7 @@ struct buffer_head *qnx4_getblk(struct i
 	}
 	tst = tmp;
 #endif
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	return result;
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/qnx4/namei.c linux-2.6.10rc2-time/fs/qnx4/namei.c
--- linux-2.6.10rc2/fs/qnx4/namei.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/qnx4/namei.c	2004-11-21 23:27:50.000000000 +0100
@@ -189,7 +189,7 @@ int qnx4_rmdir(struct inode *dir, struct
 	mark_buffer_dirty(bh);
 	inode->i_nlink = 0;
 	mark_inode_dirty(inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	dir->i_nlink--;
 	mark_inode_dirty(dir);
 	retval = 0;
@@ -233,7 +233,7 @@ int qnx4_unlink(struct inode *dir, struc
 	memset(de->di_fname, 0, sizeof de->di_fname);
 	de->di_mode = 0;
 	mark_buffer_dirty(bh);
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 	inode->i_nlink--;
 	inode->i_ctime = dir->i_ctime;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/qnx4/truncate.c linux-2.6.10rc2-time/fs/qnx4/truncate.c
--- linux-2.6.10rc2/fs/qnx4/truncate.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/qnx4/truncate.c	2004-11-21 23:27:50.000000000 +0100
@@ -31,7 +31,7 @@ void qnx4_truncate(struct inode *inode)
 		/* TODO */
 	}
 	QNX4DEBUG(("qnx4: qnx4_truncate called\n"));
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	unlock_kernel();
 }
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ramfs/inode.c linux-2.6.10rc2-time/fs/ramfs/inode.c
--- linux-2.6.10rc2/fs/ramfs/inode.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/ramfs/inode.c	2004-11-21 23:05:14.000000000 +0100
@@ -186,6 +186,7 @@ static int ramfs_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RAMFS_MAGIC;
 	sb->s_op = &ramfs_ops;
+	sb->s_time_gran = 1;
 	inode = ramfs_get_inode(sb, S_IFDIR | 0755, 0);
 	if (!inode)
 		return -ENOMEM;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/reiserfs/inode.c linux-2.6.10rc2-time/fs/reiserfs/inode.c
--- linux-2.6.10rc2/fs/reiserfs/inode.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/reiserfs/inode.c	2004-11-21 23:27:50.000000000 +0100
@@ -1734,7 +1734,8 @@ int reiserfs_new_inode (struct reiserfs_
     if( S_ISLNK( inode -> i_mode ) )
 	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
 
-    inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+    inode->i_mtime = inode->i_atime = inode->i_ctime = 
+	    CURRENT_TIME_SEC;
     inode->i_size = i_size;
     inode->i_blocks = 0;
     inode->i_bytes = 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/reiserfs/ioctl.c linux-2.6.10rc2-time/fs/reiserfs/ioctl.c
--- linux-2.6.10rc2/fs/reiserfs/ioctl.c	2004-06-16 12:23:21.000000000 +0200
+++ linux-2.6.10rc2-time/fs/reiserfs/ioctl.c	2004-11-21 23:27:49.000000000 +0100
@@ -61,7 +61,7 @@ int reiserfs_ioctl (struct inode * inode
 		}
 		sd_attrs_to_i_attrs( flags, inode );
 		REISERFS_I(inode) -> i_attrs = flags;
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		return 0;
 	}
@@ -74,7 +74,7 @@ int reiserfs_ioctl (struct inode * inode
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = CURRENT_TIME_SEC;
 		mark_inode_dirty(inode);
 		return 0;
 	default:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/reiserfs/namei.c linux-2.6.10rc2-time/fs/reiserfs/namei.c
--- linux-2.6.10rc2/fs/reiserfs/namei.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/reiserfs/namei.c	2004-11-21 23:27:49.000000000 +0100
@@ -534,7 +534,7 @@ static int reiserfs_add_entry (struct re
     }
 
     dir->i_size += paste_size;
-    dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+    dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
     if (!S_ISDIR (inode->i_mode) && visible)
 	// reiserfs_mkdir or reiserfs_rename will do that by itself
 	reiserfs_update_sd (th, dir);
@@ -881,7 +881,7 @@ static int reiserfs_rmdir (struct inode 
 			  "!= 2 (%d)", __FUNCTION__, inode->i_nlink);
 
     inode->i_nlink = 0;
-    inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+    inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
     reiserfs_update_sd (&th, inode);
 
     DEC_DIR_INODE_NLINK(dir)
@@ -969,11 +969,11 @@ static int reiserfs_unlink (struct inode
 	inode->i_nlink++;
 	goto end_unlink;
     }
-    inode->i_ctime = CURRENT_TIME;
+    inode->i_ctime = CURRENT_TIME_SEC;
     reiserfs_update_sd (&th, inode);
 
     dir->i_size -= (de.de_entrylen + DEH_SIZE);
-    dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+    dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
     reiserfs_update_sd (&th, dir);
 
     if (!savelink)
@@ -1121,7 +1121,7 @@ static int reiserfs_link (struct dentry 
 	return err ? err : retval;
     }
 
-    inode->i_ctime = CURRENT_TIME;
+    inode->i_ctime = CURRENT_TIME_SEC;
     reiserfs_update_sd (&th, inode);
 
     atomic_inc(&inode->i_count) ;
@@ -1368,7 +1368,7 @@ static int reiserfs_rename (struct inode
 
     mark_de_hidden (old_de.de_deh + old_de.de_entry_num);
     journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
-    ctime = CURRENT_TIME;
+    ctime = CURRENT_TIME_SEC;
     old_dir->i_ctime = old_dir->i_mtime = ctime;
     new_dir->i_ctime = new_dir->i_mtime = ctime;
     /* thanks to Alex Adriaanse <alex_a@caltech.edu> for patch which adds ctime update of
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/reiserfs/stree.c linux-2.6.10rc2-time/fs/reiserfs/stree.c
--- linux-2.6.10rc2/fs/reiserfs/stree.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/reiserfs/stree.c	2004-11-21 23:27:49.000000000 +0100
@@ -1922,7 +1922,7 @@ int reiserfs_do_truncate (struct reiserf
 	  decrement_counters_in_path(&s_search_path) ;
 
 	  if (update_timestamps) {
-	      p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME;
+	      p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME_SEC;
 	  } 
 	  reiserfs_update_sd(th, p_s_inode) ;
 
@@ -1945,7 +1945,7 @@ int reiserfs_do_truncate (struct reiserf
 update_and_out:
     if (update_timestamps) {
 	// this is truncate, not file closing
-	p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME;
+	    p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME_SEC;
     }
     reiserfs_update_sd (th, p_s_inode);
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/reiserfs/xattr.c linux-2.6.10rc2-time/fs/reiserfs/xattr.c
--- linux-2.6.10rc2/fs/reiserfs/xattr.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/reiserfs/xattr.c	2004-11-21 23:27:48.000000000 +0100
@@ -594,7 +594,7 @@ open_file:
      * gets marked dirty, but won't (ever) make it onto the dirty list until
      * it's synced explicitly to clear I_DIRTY. This is bad. */
     if (!hlist_unhashed(&inode->i_hash)) {
-        inode->i_ctime = CURRENT_TIME;
+        inode->i_ctime = CURRENT_TIME_SEC;
         mark_inode_dirty (inode);
     }
 
@@ -768,7 +768,7 @@ reiserfs_xattr_del (struct inode *inode,
     dput (dir);
 
     if (!err) {
-        inode->i_ctime = CURRENT_TIME;
+        inode->i_ctime = CURRENT_TIME_SEC;
         mark_inode_dirty (inode);
     }
 
@@ -1040,7 +1040,7 @@ reiserfs_removexattr (struct dentry *den
 
     err = reiserfs_xattr_del (dentry->d_inode, name);
 
-    dentry->d_inode->i_ctime = CURRENT_TIME;
+    dentry->d_inode->i_ctime = CURRENT_TIME_SEC;
     mark_inode_dirty (dentry->d_inode);
 
 out:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/smbfs/file.c linux-2.6.10rc2-time/fs/smbfs/file.c
--- linux-2.6.10rc2/fs/smbfs/file.c	2004-08-15 19:45:44.000000000 +0200
+++ linux-2.6.10rc2-time/fs/smbfs/file.c	2004-11-21 17:43:53.000000000 +0100
@@ -78,7 +78,8 @@ smb_readpage_sync(struct dentry *dentry,
 		count -= result;
 		offset += result;
 		buffer += result;
-		dentry->d_inode->i_atime = CURRENT_TIME;
+		dentry->d_inode->i_atime = 
+			current_fs_time(dentry->d_inode->i_sb);
 		if (result < rsize)
 			break;
 	} while (count);
@@ -152,7 +153,7 @@ smb_writepage_sync(struct inode *inode, 
 		/*
 		 * Update the inode now rather than waiting for a refresh.
 		 */
-		inode->i_mtime = inode->i_atime = CURRENT_TIME;
+		inode->i_mtime = inode->i_atime = current_fs_time(inode->i_sb);
 		SMB_I(inode)->flags |= SMB_F_LOCALWRITE;
 		if (offset > inode->i_size)
 			inode->i_size = offset;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/smbfs/inode.c linux-2.6.10rc2-time/fs/smbfs/inode.c
--- linux-2.6.10rc2/fs/smbfs/inode.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/smbfs/inode.c	2004-11-21 23:28:27.000000000 +0100
@@ -516,7 +516,8 @@ int smb_fill_super(struct super_block *s
 	sb->s_blocksize_bits = 10;
 	sb->s_magic = SMB_SUPER_MAGIC;
 	sb->s_op = &smb_sops;
-
+	sb->s_time_gran = 100;
+	
 	server = smb_kmalloc(sizeof(struct smb_sb_info), GFP_KERNEL);
 	if (!server)
 		goto out_no_server;
@@ -601,7 +602,7 @@ int smb_fill_super(struct super_block *s
 	/*
 	 * Keep the super block locked while we get the root inode.
 	 */
-	smb_init_root_dirent(server, &root);
+	smb_init_root_dirent(server, &root, sb);
 	root_inode = smb_iget(sb, &root);
 	if (!root_inode)
 		goto out_no_root;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/smbfs/proc.c linux-2.6.10rc2-time/fs/smbfs/proc.c
--- linux-2.6.10rc2/fs/smbfs/proc.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/smbfs/proc.c	2004-11-21 17:42:36.000000000 +0100
@@ -1852,12 +1852,13 @@ smb_finish_dirent(struct smb_sb_info *se
 }
 
 void
-smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr)
+smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr,
+		     struct super_block *sb)
 {
 	smb_init_dirent(server, fattr);
 	fattr->attr = aDIR;
 	fattr->f_ino = 2; /* traditional root inode number */
-	fattr->f_mtime = CURRENT_TIME;
+	fattr->f_mtime = current_fs_time(sb);
 	smb_finish_dirent(server, fattr);
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/smbfs/proto.h linux-2.6.10rc2-time/fs/smbfs/proto.h
--- linux-2.6.10rc2/fs/smbfs/proto.h	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/smbfs/proto.h	2004-11-21 17:42:32.000000000 +0100
@@ -23,7 +23,8 @@ extern int smb_proc_mkdir(struct dentry 
 extern int smb_proc_rmdir(struct dentry *dentry);
 extern int smb_proc_unlink(struct dentry *dentry);
 extern int smb_proc_flush(struct smb_sb_info *server, __u16 fileid);
-extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
+extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr,
+				 struct super_block *sb);
 extern void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/super.c linux-2.6.10rc2-time/fs/super.c
--- linux-2.6.10rc2/fs/super.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/super.c	2004-11-21 23:03:19.000000000 +0100
@@ -84,6 +84,7 @@ static struct super_block *alloc_super(v
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
+		s->s_time_gran = 1000000000; 
 	}
 out:
 	return s;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/sysfs/mount.c linux-2.6.10rc2-time/fs/sysfs/mount.c
--- linux-2.6.10rc2/fs/sysfs/mount.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/sysfs/mount.c	2004-11-21 22:54:00.000000000 +0100
@@ -38,6 +38,7 @@ static int sysfs_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = SYSFS_MAGIC;
 	sb->s_op = &sysfs_ops;
+	sb->s_time_gran = 1;
 	sysfs_sb = sb;
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/sysv/dir.c linux-2.6.10rc2-time/fs/sysv/dir.c
--- linux-2.6.10rc2/fs/sysv/dir.c	2004-04-06 13:12:18.000000000 +0200
+++ linux-2.6.10rc2-time/fs/sysv/dir.c	2004-11-21 23:27:48.000000000 +0100
@@ -231,7 +231,7 @@ got_it:
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 out_page:
 	dir_put_page(page);
@@ -258,7 +258,7 @@ int sysv_delete_entry(struct sysv_dir_en
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
 	dir_put_page(page);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	return err;
 }
@@ -358,7 +358,7 @@ void sysv_set_link(struct sysv_dir_entry
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
 	dir_put_page(page);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/sysv/ialloc.c linux-2.6.10rc2-time/fs/sysv/ialloc.c
--- linux-2.6.10rc2/fs/sysv/ialloc.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/sysv/ialloc.c	2004-11-21 23:27:48.000000000 +0100
@@ -169,7 +169,7 @@ struct inode * sysv_new_inode(const stru
 
 	inode->i_uid = current->fsuid;
 	inode->i_ino = fs16_to_cpu(sbi, ino);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blocks = inode->i_blksize = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
 	SYSV_I(inode)->i_dir_start_lookup = 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/sysv/itree.c linux-2.6.10rc2-time/fs/sysv/itree.c
--- linux-2.6.10rc2/fs/sysv/itree.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/sysv/itree.c	2004-11-21 23:27:48.000000000 +0100
@@ -178,7 +178,7 @@ static inline int splice_branch(struct i
 	*where->p = where->key;
 	write_unlock(&pointers_lock);
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -418,7 +418,7 @@ do_indirects:
 		}
 		n++;
 	}
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode))
 		sysv_sync_inode (inode);
 	else
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/sysv/namei.c linux-2.6.10rc2-time/fs/sysv/namei.c
--- linux-2.6.10rc2/fs/sysv/namei.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/sysv/namei.c	2004-11-21 23:27:47.000000000 +0100
@@ -137,7 +137,7 @@ static int sysv_link(struct dentry * old
 	if (inode->i_nlink >= SYSV_SB(inode->i_sb)->s_link_max)
 		return -EMLINK;
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	inc_count(inode);
 	atomic_inc(&inode->i_count);
 
@@ -260,7 +260,7 @@ static int sysv_rename(struct inode * ol
 			goto out_dir;
 		inc_count(old_inode);
 		sysv_set_link(new_de, new_page, old_inode);
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
 		dec_count(new_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/udf/ialloc.c linux-2.6.10rc2-time/fs/udf/ialloc.c
--- linux-2.6.10rc2/fs/udf/ialloc.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/udf/ialloc.c	2004-11-21 16:34:43.000000000 +0100
@@ -157,7 +157,7 @@ struct inode * udf_new_inode (struct ino
 	else
 		UDF_I_ALLOCTYPE(inode) = ICBTAG_FLAG_AD_LONG;
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
-		UDF_I_CRTIME(inode) = CURRENT_TIME;
+		UDF_I_CRTIME(inode) = current_fs_time(inode->i_sb);
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/udf/inode.c linux-2.6.10rc2-time/fs/udf/inode.c
--- linux-2.6.10rc2/fs/udf/inode.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/udf/inode.c	2004-11-21 17:07:59.000000000 +0100
@@ -568,7 +568,7 @@ static struct buffer_head * inode_getblk
 	*new = 1;
 	UDF_I_NEXT_ALLOC_BLOCK(inode) = block;
 	UDF_I_NEXT_ALLOC_GOAL(inode) = newblocknum;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = current_fs_time(inode->i_sb);
 
 	if (IS_SYNC(inode))
 		udf_sync_inode(inode);
@@ -912,7 +912,7 @@ void udf_truncate(struct inode * inode)
 		udf_truncate_extents(inode);
 	}	
 
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = current_fs_time(inode->i_sb);
 	if (IS_SYNC(inode))
 		udf_sync_inode (inode);
 	else
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/udf/namei.c linux-2.6.10rc2-time/fs/udf/namei.c
--- linux-2.6.10rc2/fs/udf/namei.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/udf/namei.c	2004-11-21 17:07:59.000000000 +0100
@@ -887,7 +887,7 @@ static int udf_rmdir(struct inode * dir,
 	inode->i_size = 0;
 	mark_inode_dirty(inode);
 	dir->i_nlink --;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_fs_time(dir->i_sb);
 	mark_inode_dirty(dir);
 
 end_rmdir:
@@ -928,7 +928,7 @@ static int udf_unlink(struct inode * dir
 	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
 	if (retval)
 		goto end_unlink;
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = current_fs_time(dir->i_sb);
 	mark_inode_dirty(dir);
 	inode->i_nlink--;
 	mark_inode_dirty(inode);
@@ -1158,7 +1158,7 @@ static int udf_link(struct dentry * old_
 		udf_release_data(fibh.ebh);
 	udf_release_data(fibh.sbh);
 	inode->i_nlink ++;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = current_fs_time(inode->i_sb);
 	mark_inode_dirty(inode);
 	atomic_inc(&inode->i_count);
 	d_instantiate(dentry, inode);
@@ -1251,7 +1251,7 @@ static int udf_rename (struct inode * ol
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old_inode->i_ctime = CURRENT_TIME;
+	old_inode->i_ctime = current_fs_time(old_inode->i_sb);
 	mark_inode_dirty(old_inode);
 
 	/*
@@ -1269,10 +1269,10 @@ static int udf_rename (struct inode * ol
 	if (new_inode)
 	{
 		new_inode->i_nlink--;
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = current_fs_time(new_inode->i_sb);
 		mark_inode_dirty(new_inode);
 	}
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = current_fs_time(old_dir->i_sb);
 	mark_inode_dirty(old_dir);
 
 	if (dir_fi)
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/udf/super.c linux-2.6.10rc2-time/fs/udf/super.c
--- linux-2.6.10rc2/fs/udf/super.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/udf/super.c	2004-11-21 17:08:53.000000000 +0100
@@ -1567,6 +1567,7 @@ static int udf_fill_super(struct super_b
 	sb->dq_op = NULL;
 	sb->s_dirt = 0;
 	sb->s_magic = UDF_SUPER_MAGIC;
+	sb->s_time_gran = 1000;
 
 	if (udf_load_partition(sb, &fileset))
 	{
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ufs/dir.c linux-2.6.10rc2-time/fs/ufs/dir.c
--- linux-2.6.10rc2/fs/ufs/dir.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/ufs/dir.c	2004-11-21 23:27:46.000000000 +0100
@@ -462,7 +462,7 @@ int ufs_add_link(struct dentry *dentry, 
 	if (IS_DIRSYNC(dir))
 		sync_dirty_buffer(bh);
 	brelse (bh);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	dir->i_version++;
 	mark_inode_dirty(dir);
 
@@ -505,7 +505,7 @@ int ufs_delete_entry (struct inode * ino
 					fs16_to_cpu(sb, dir->d_reclen));
 			dir->d_ino = 0;
 			inode->i_version++;
-			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+			inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 			mark_inode_dirty(inode);
 			mark_buffer_dirty(bh);
 			if (IS_DIRSYNC(inode))
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ufs/ialloc.c linux-2.6.10rc2-time/fs/ufs/ialloc.c
--- linux-2.6.10rc2/fs/ufs/ialloc.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ufs/ialloc.c	2004-11-21 23:27:46.000000000 +0100
@@ -267,7 +267,7 @@ cg_found:
 	inode->i_ino = cg * uspi->s_ipg + bit;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	ufsi->i_flags = UFS_I(dir)->i_flags;
 	ufsi->i_lastfrag = 0;
 	ufsi->i_gen = 0;
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ufs/inode.c linux-2.6.10rc2-time/fs/ufs/inode.c
--- linux-2.6.10rc2/fs/ufs/inode.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ufs/inode.c	2004-11-21 23:27:45.000000000 +0100
@@ -272,7 +272,7 @@ repeat:
 		*new = 1;
 	}
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode))
 		ufs_sync_inode (inode);
 	mark_inode_dirty(inode);
@@ -363,7 +363,7 @@ repeat:
 	mark_buffer_dirty(bh);
 	if (IS_SYNC(inode))
 		sync_dirty_buffer(bh);
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 out:
 	brelse (bh);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ufs/namei.c linux-2.6.10rc2-time/fs/ufs/namei.c
--- linux-2.6.10rc2/fs/ufs/namei.c	2004-11-15 12:35:19.000000000 +0100
+++ linux-2.6.10rc2-time/fs/ufs/namei.c	2004-11-21 23:27:45.000000000 +0100
@@ -190,7 +190,7 @@ static int ufs_link (struct dentry * old
 		return -EMLINK;
 	}
 
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME_SEC;
 	ufs_inc_count(inode);
 	atomic_inc(&inode->i_count);
 
@@ -321,7 +321,7 @@ static int ufs_rename (struct inode * ol
 			goto out_dir;
 		ufs_inc_count(old_inode);
 		ufs_set_link(new_dir, new_de, new_bh, old_inode);
-		new_inode->i_ctime = CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
 		ufs_dec_count(new_inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/ufs/truncate.c linux-2.6.10rc2-time/fs/ufs/truncate.c
--- linux-2.6.10rc2/fs/ufs/truncate.c	2004-10-19 01:55:30.000000000 +0200
+++ linux-2.6.10rc2-time/fs/ufs/truncate.c	2004-11-21 23:35:17.000000000 +0100
@@ -469,7 +469,7 @@ void ufs_truncate (struct inode * inode)
 			brelse (bh);
 		}
 	}
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	ufsi->i_lastfrag = DIRECT_FRAGMENT;
 	unlock_kernel();
 	mark_inode_dirty(inode);
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/umsdos/emd.c linux-2.6.10rc2-time/fs/umsdos/emd.c
--- linux-2.6.10rc2/fs/umsdos/emd.c	2004-03-21 21:12:02.000000000 +0100
+++ linux-2.6.10rc2-time/fs/umsdos/emd.c	2004-11-21 23:35:17.000000000 +0100
@@ -295,7 +295,7 @@ int umsdos_writeentry (struct dentry *pa
 	unlock_page(page);
 	page_cache_release(page);
 		
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 
 out_dput:
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/vfat/namei.c linux-2.6.10rc2-time/fs/vfat/namei.c
--- linux-2.6.10rc2/fs/vfat/namei.c	2004-10-19 01:55:31.000000000 +0200
+++ linux-2.6.10rc2-time/fs/vfat/namei.c	2004-11-21 23:35:16.000000000 +0100
@@ -735,10 +735,11 @@ static int vfat_add_entry(struct inode *
 
 	res = 0;
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
 	mark_inode_dirty(dir);
 
 	fat_date_unix2dos(dir->i_mtime.tv_sec, &(*de)->time, &(*de)->date);
+	dir->i_mtime.tv_nsec = 0;
 	(*de)->ctime = (*de)->time;
 	(*de)->adate = (*de)->cdate = (*de)->date;
 
@@ -848,7 +849,7 @@ static int vfat_create(struct inode *dir
 	if (!inode)
 		goto out;
 	res = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	inode->i_version++;
 	dir->i_version++;
@@ -866,7 +867,7 @@ static void vfat_remove_entry(struct ino
 	int i;
 
 	/* remove the shortname */
-	dir->i_mtime = dir->i_atime = CURRENT_TIME;
+	dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
 	dir->i_version++;
 	mark_inode_dirty(dir);
 	de->name[0] = DELETED_FLAG;
@@ -900,7 +901,7 @@ static int vfat_rmdir(struct inode *dir,
 		goto out;
 	res = 0;
 	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
+	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
 	/* releases bh */
@@ -923,7 +924,7 @@ static int vfat_unlink(struct inode *dir
 	if (res < 0)
 		goto out;
 	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME;
+	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(dentry->d_inode);
 	mark_inode_dirty(dentry->d_inode);
 	/* releases bh */
@@ -950,7 +951,7 @@ static int vfat_mkdir(struct inode *dir,
 	inode = fat_build_inode(sb, de, sinfo.i_pos, &res);
 	if (!inode)
 		goto out_brelse;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	inode->i_version++;
 	dir->i_version++;
@@ -969,7 +970,7 @@ out:
 
 mkdir_failed:
 	inode->i_nlink = 0;
-	inode->i_mtime = inode->i_atime = CURRENT_TIME;
+	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh */
@@ -1038,11 +1039,11 @@ static int vfat_rename(struct inode *old
 	mark_inode_dirty(old_inode);
 
 	old_dir->i_version++;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
 		new_inode->i_nlink--;
-		new_inode->i_ctime=CURRENT_TIME;
+		new_inode->i_ctime = CURRENT_TIME_SEC;
 	}
 
 	if (is_dir) {
diff -urpN -X ../KDIFX linux-2.6.10rc2/fs/xfs/linux-2.6/xfs_super.c linux-2.6.10rc2-time/fs/xfs/linux-2.6/xfs_super.c
--- linux-2.6.10rc2/fs/xfs/linux-2.6/xfs_super.c	2004-10-19 01:55:31.000000000 +0200
+++ linux-2.6.10rc2-time/fs/xfs/linux-2.6/xfs_super.c	2004-11-21 16:35:58.000000000 +0100
@@ -825,6 +825,7 @@ linvfs_fill_super(
 	sb->s_blocksize = statvfs.f_bsize;
 	sb->s_blocksize_bits = ffs(statvfs.f_bsize) - 1;
 	sb->s_maxbytes = xfs_max_file_offset(sb->s_blocksize_bits);
+	sb->s_time_gran = 1; 
 	set_posix_acl_flag(sb);
 
 	VFS_ROOT(vfsp, &rootvp, error);
diff -urpN -X ../KDIFX linux-2.6.10rc2/include/linux/fs.h linux-2.6.10rc2-time/include/linux/fs.h
--- linux-2.6.10rc2/include/linux/fs.h	2004-11-15 12:35:29.000000000 +0100
+++ linux-2.6.10rc2-time/include/linux/fs.h	2004-11-21 16:53:41.000000000 +0100
@@ -123,7 +123,6 @@ extern int dir_notify_enable;
 #define MS_REC		16384
 #define MS_VERBOSE	32768
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_ONE_SECOND	(1<<17)	/* fs has 1 sec a/m/ctime resolution */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -179,7 +178,6 @@ extern int dir_notify_enable;
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
-#define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
@@ -797,8 +795,14 @@ struct super_block {
 	 * even looking at it. You had been warned.
 	 */
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
+	
+	/* Granuality of c/m/atime in ns.
+	   Cannot be worse than a second */
+	u32		   s_time_gran;
 };
 
+extern struct timespec current_fs_time(struct super_block *sb);
+
 /*
  * Snapshotting support.
  */
diff -urpN -X ../KDIFX linux-2.6.10rc2/include/linux/time.h linux-2.6.10rc2-time/include/linux/time.h
--- linux-2.6.10rc2/include/linux/time.h	2004-11-15 12:35:30.000000000 +0100
+++ linux-2.6.10rc2-time/include/linux/time.h	2004-11-21 23:07:46.000000000 +0100
@@ -90,6 +90,7 @@ static inline unsigned long get_seconds(
 struct timespec current_kernel_time(void);
 
 #define CURRENT_TIME (current_kernel_time())
+#define CURRENT_TIME_SEC ((struct timespec) { xtime.tv_sec, 0 })
 
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
@@ -103,6 +104,8 @@ extern int do_setitimer(int which, struc
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday (struct timespec *tv);
 
+extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
+
 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
 {
diff -urpN -X ../KDIFX linux-2.6.10rc2/kernel/time.c linux-2.6.10rc2-time/kernel/time.c
--- linux-2.6.10rc2/kernel/time.c	2004-11-15 12:35:31.000000000 +0100
+++ linux-2.6.10rc2-time/kernel/time.c	2004-11-21 23:48:37.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/security.h>
+#include <linux/fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -417,7 +418,7 @@ asmlinkage long sys_adjtimex(struct time
 	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
 }
 
-struct timespec current_kernel_time(void)
+inline struct timespec current_kernel_time(void)
 {
         struct timespec now;
         unsigned long seq;
@@ -433,6 +434,50 @@ struct timespec current_kernel_time(void
 
 EXPORT_SYMBOL(current_kernel_time);
 
+/**
+ * current_fs_time - Return FS time
+ * @sb: Superblock.
+ * 
+ * Return the current time truncated to the time granuality supported by 
+ * the fs.
+ */
+struct timespec current_fs_time(struct super_block *sb)
+{
+	struct timespec now = current_kernel_time();
+	return timespec_trunc(now, sb->s_time_gran);
+}
+EXPORT_SYMBOL(current_fs_time);
+
+/**
+ * timespec_trunc - Truncate timespec to a granuality 
+ * @t: Timespec
+ * @gran: Granuality in ns. 
+ *
+ * Truncate a timespec to a granuality. gran must be smaller than a second.
+ * Always rounds down. 
+ *
+ * This function should be only used for timestamps returned by
+ * current_kernel_time() or CURRENT_TIME, not with do_gettimeofday() because
+ * it doesn't handle the better resolution of the later.
+ */
+struct timespec timespec_trunc(struct timespec t, unsigned gran)
+{
+	/* 
+	 * Division is pretty slow so avoid it for common cases.
+	 * Currently current_kernel_time() never returns better than
+	 * jiffies resolution. Exploit that. 
+	 */
+	if (gran <= jiffies_to_usecs(1) * 1000) { 
+		/* nothing */
+	} else if (gran == 1000000000) { 
+		t.tv_nsec = 0; 
+	} else { 
+		t.tv_nsec -= t.tv_nsec % gran; 
+	} 
+	return t; 
+} 
+EXPORT_SYMBOL(timespec_trunc);
+
 #ifdef CONFIG_TIME_INTERPOLATION
 void getnstimeofday (struct timespec *tv)
 {
diff -urpN -X ../KDIFX linux-2.6.10rc2/net/sunrpc/rpc_pipe.c linux-2.6.10rc2-time/net/sunrpc/rpc_pipe.c
--- linux-2.6.10rc2/net/sunrpc/rpc_pipe.c	2004-11-15 12:35:33.000000000 +0100
+++ linux-2.6.10rc2-time/net/sunrpc/rpc_pipe.c	2004-11-21 23:35:16.000000000 +0100
@@ -769,6 +769,7 @@ rpc_fill_super(struct super_block *sb, v
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RPCAUTH_GSSMAGIC;
 	sb->s_op = &s_ops;
+	sb->s_time_gran = 1;
 
 	inode = rpc_get_inode(sb, S_IFDIR | 0755);
 	if (!inode)
