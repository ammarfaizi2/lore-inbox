Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWJGF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWJGF4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWJGFzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:55:54 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:65200 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932618AbWJGFzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:55:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 23] Unionfs: Internal include file
Message-Id: <4a0655b52aef552fe558.1160197659@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:39 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains an internal Unionfs include file. The include file is
specific to kernel code only, and therefore is separate from
include/linux/unionfs.h.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 536 insertions(+)
fs/unionfs/union.h |  536 ++++++++++++++++++++++++++++++++++++++++++++++++++++

diff -r d7b005418bfc -r 4a0655b52aef fs/unionfs/union.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/fs/unionfs/union.h	Sat Oct 07 00:46:19 2006 -0400
@@ -0,0 +1,536 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef Sipek
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UNION_H_
+#define _UNION_H_
+
+#include <asm/mman.h>
+#include <asm/system.h>
+#include <linux/dcache.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/page-flags.h>
+#include <linux/pagemap.h>
+#include <linux/poll.h>
+#include <linux/security.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+#include <linux/statfs.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include <linux/writeback.h>
+
+#include <linux/union_fs.h>
+/* the file system name */
+#define UNIONFS_NAME "unionfs"
+
+/* unionfs file systems superblock magic */
+#define UNIONFS_SUPER_MAGIC 0xf15f083d
+
+/* unionfs root inode number */
+#define UNIONFS_ROOT_INO     1
+
+/* Mount time flags */
+#define MOUNT_FLAG(sb)     (stopd(sb)->usi_mount_flag)
+
+/* number of characters while generating unique temporary file names */
+#define	UNIONFS_TMPNAM_LEN	12
+
+/* number of times we try to get a unique temporary file name */
+#define GET_TMPNAM_MAX_RETRY	5
+
+/* Operations vectors defined in specific files. */
+extern struct file_operations unionfs_main_fops;
+extern struct file_operations unionfs_dir_fops;
+extern struct inode_operations unionfs_main_iops;
+extern struct inode_operations unionfs_dir_iops;
+extern struct inode_operations unionfs_symlink_iops;
+extern struct super_operations unionfs_sops;
+extern struct dentry_operations unionfs_dops;
+
+/* How long should an entry be allowed to persist */
+#define RDCACHE_JIFFIES 5*HZ
+
+/* file private data. */
+struct unionfs_file_info {
+	int b_start;
+	int b_end;
+	atomic_t ufi_generation;
+
+	struct unionfs_dir_state *rdstate;
+	struct file **ufi_file;
+};
+
+/* unionfs inode data in memory */
+struct unionfs_inode_info {
+	int b_start;
+	int b_end;
+	atomic_t uii_generation;
+	int uii_stale;
+	/* Stuff for readdir over NFS. */
+	spinlock_t uii_rdlock;
+	struct list_head uii_readdircache;
+	int uii_rdcount;
+	int uii_hashsize;
+	int uii_cookie; /* The hidden inodes */
+	struct inode **uii_inode;
+	/* to keep track of reads/writes for unlinks before closes */
+	atomic_t uii_totalopens;
+};
+
+struct unionfs_inode_container {
+	struct unionfs_inode_info info;
+	struct inode vfs_inode;
+};
+
+/* unionfs dentry data in memory */
+struct unionfs_dentry_info {
+	/* The semaphore is used to lock the dentry as soon as we get into a
+	 * unionfs function from the VFS.  Our lock ordering is that children
+	 * go before their parents. */
+	struct semaphore udi_sem;
+	int udi_bstart;
+	int udi_bend;
+	int udi_bopaque;
+	int udi_bcount;
+	atomic_t udi_generation;
+	struct dentry **udi_dentry;
+	struct vfsmount **udi_mnt;
+};
+
+/* These are the pointers to our various objects. */
+struct unionfs_usi_data {
+	struct super_block *sb;
+	struct vfsmount *hidden_mnt;
+	atomic_t sbcount;
+	int branchperms;
+};
+
+/* unionfs super-block data in memory */
+struct unionfs_sb_info {
+	int b_end;
+
+	atomic_t usi_generation;
+	unsigned long usi_mount_flag;
+	struct rw_semaphore usi_rwsem;
+
+	struct unionfs_usi_data *usi_data;
+};
+
+/*
+ * structure for making the linked list of entries by readdir on left branch
+ * to compare with entries on right branch
+ */
+struct filldir_node {
+	struct list_head file_list;	// list for directory entries
+	char *name;		// name entry
+	int hash;		// name hash
+	int namelen;		// name len since name is not 0 terminated
+	int bindex;		// we can check for duplicate whiteouts and files in the same branch in order to return -EIO.
+	int whiteout;		// is this a whiteout entry?
+	char iname[DNAME_INLINE_LEN_MIN];	// Inline name, so we don't need to separately kmalloc small ones
+};
+
+/* Directory hash table. */
+struct unionfs_dir_state {
+	unsigned int uds_cookie;	/* The cookie, which is based off of uii_rdversion */
+	unsigned int uds_offset;	/* The entry we have returned. */
+	int uds_bindex;
+	loff_t uds_dirpos;	/* The offset within the lower level directory. */
+	int uds_size;		/* How big is the hash table? */
+	int uds_hashentries;	/* How many entries have been inserted? */
+	unsigned long uds_access;
+	/* This cache list is used when the inode keeps us around. */
+	struct list_head uds_cache;
+	struct list_head uds_list[0];
+};
+
+/* include miscellaneous macros */
+#include "fanout.h"
+#include "sioq.h"
+
+/* Cache creation/deletion routines. */
+void destroy_filldir_cache(void);
+int init_filldir_cache(void);
+int init_inode_cache(void);
+void destroy_inode_cache(void);
+int init_dentry_cache(void);
+void destroy_dentry_cache(void);
+
+/* Initialize and free readdir-specific  state. */
+int init_rdstate(struct file *file);
+struct unionfs_dir_state *alloc_rdstate(struct inode *inode, int bindex);
+struct unionfs_dir_state *find_rdstate(struct inode *inode, loff_t fpos);
+void free_rdstate(struct unionfs_dir_state *state);
+int add_filldir_node(struct unionfs_dir_state *rdstate, const char *name,
+		     int namelen, int bindex, int whiteout);
+struct filldir_node *find_filldir_node(struct unionfs_dir_state *rdstate,
+				       const char *name, int namelen);
+
+struct dentry **alloc_new_dentries(int objs);
+struct unionfs_usi_data *alloc_new_data(int objs);
+
+/* We can only use 32-bits of offset for rdstate --- blech! */
+#define DIREOF (0xfffff)
+#define RDOFFBITS 20		/* This is the number of bits in DIREOF. */
+#define MAXRDCOOKIE (0xfff)
+/* Turn an rdstate into an offset. */
+static inline off_t rdstate2offset(struct unionfs_dir_state *buf)
+{
+	off_t tmp;
+	tmp = ((buf->uds_cookie & MAXRDCOOKIE) << RDOFFBITS)
+		| (buf->uds_offset & DIREOF);
+	return tmp;
+}
+
+#define unionfs_read_lock(sb) down_read(&stopd(sb)->usi_rwsem)
+#define unionfs_read_unlock(sb) up_read(&stopd(sb)->usi_rwsem)
+#define unionfs_write_lock(sb) down_write(&stopd(sb)->usi_rwsem)
+#define unionfs_write_unlock(sb) up_write(&stopd(sb)->usi_rwsem)
+
+/* The double lock function needs to go after the debugmacros, so that
+ * dtopd is defined.  */
+static inline void double_lock_dentry(struct dentry *d1, struct dentry *d2)
+{
+	if (d2 < d1) {
+		struct dentry *tmp = d1;
+		d1 = d2;
+		d2 = tmp;
+	}
+	lock_dentry(d1);
+	lock_dentry(d2);
+}
+
+extern int new_dentry_private_data(struct dentry *dentry);
+void free_dentry_private_data(struct unionfs_dentry_info *udi);
+void update_bstart(struct dentry *dentry);
+#define sbt(sb) ((sb)->s_type->name)
+
+/*
+ * EXTERNALS:
+ */
+/* replicates the directory structure upto given dentry in given branch */
+extern struct dentry *create_parents(struct inode *dir, struct dentry *dentry,
+				     int bindex);
+struct dentry *create_parents_named(struct inode *dir, struct dentry *dentry,
+				    const char *name, int bindex);
+
+/* check if two branches overlap */
+extern int is_branch_overlap(struct dentry *dent1, struct dentry *dent2);
+
+/* partial lookup */
+extern int unionfs_partial_lookup(struct dentry *dentry);
+
+/* Pass an unionfs dentry and an index and it will try to create a whiteout in branch 'index'.
+   On error, it will proceed to a branch to the left */
+extern int create_whiteout(struct dentry *dentry, int start);
+/* copies a file from dbstart to newbindex branch */
+extern int copyup_file(struct inode *dir, struct file *file, int bstart,
+		       int newbindex, loff_t size);
+extern int copyup_named_file(struct inode *dir, struct file *file,
+			     char *name, int bstart, int new_bindex,
+			     loff_t len);
+/* copies a dentry from dbstart to newbindex branch */
+extern int copyup_dentry(struct inode *dir, struct dentry *dentry, int bstart,
+			 int new_bindex, struct file **copyup_file, loff_t len);
+extern int copyup_named_dentry(struct inode *dir, struct dentry *dentry,
+			       int bstart, int new_bindex, const char *name,
+			       int namelen, struct file **copyup_file,
+			       loff_t len);
+
+extern int remove_whiteouts(struct dentry *dentry, struct dentry *hidden_dentry,
+			    int bindex);
+
+extern int do_delete_whiteouts(struct dentry *dentry, int bindex,
+		     struct unionfs_dir_state *namelist);
+
+/* Is this directory empty: 0 if it is empty, -ENOTEMPTY if not. */
+extern int check_empty(struct dentry *dentry,
+		       struct unionfs_dir_state **namelist);
+/* Delete whiteouts from this directory in branch bindex. */
+extern int delete_whiteouts(struct dentry *dentry, int bindex,
+			    struct unionfs_dir_state *namelist);
+
+/* Re-lookup a hidden dentry. */
+extern int unionfs_refresh_hidden_dentry(struct dentry *dentry, int bindex);
+
+extern void unionfs_reinterpose(struct dentry *this_dentry);
+extern struct super_block *unionfs_duplicate_super(struct super_block *sb);
+
+/* Locking functions. */
+extern int unionfs_setlk(struct file *file, int cmd, struct file_lock *fl);
+extern int unionfs_getlk(struct file *file, struct file_lock *fl);
+
+/* Common file operations. */
+extern int unionfs_file_revalidate(struct file *file, int willwrite);
+extern int unionfs_open(struct inode *inode, struct file *file);
+extern int unionfs_file_release(struct inode *inode, struct file *file);
+extern int unionfs_flush(struct file *file, fl_owner_t id);
+extern long unionfs_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg);
+
+/* Inode operations */
+extern int unionfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+			  struct inode *new_dir, struct dentry *new_dentry);
+int unionfs_unlink(struct inode *dir, struct dentry *dentry);
+int unionfs_rmdir(struct inode *dir, struct dentry *dentry);
+
+int unionfs_d_revalidate(struct dentry *dentry, struct nameidata *nd);
+
+/* The values for unionfs_interpose's flag. */
+#define INTERPOSE_DEFAULT	0
+#define INTERPOSE_LOOKUP	1
+#define INTERPOSE_REVAL		2
+#define INTERPOSE_REVAL_NEG	3
+#define INTERPOSE_PARTIAL	4
+
+extern int unionfs_interpose(struct dentry *this_dentry, struct super_block *sb,
+			     int flag);
+
+/* Branch management ioctls. */
+int unionfs_ioctl_incgen(struct file *file, unsigned int cmd,
+			 unsigned long arg);
+int unionfs_ioctl_queryfile(struct file *file, unsigned int cmd,
+			    unsigned long arg);
+
+/* Verify that a branch is valid. */
+int check_branch(struct nameidata *nd);
+
+/* The root directory is unhashed, but isn't deleted. */
+static inline int d_deleted(struct dentry *d)
+{
+	return d_unhashed(d) && (d != d->d_sb->s_root);
+}
+
+/* returns the sum of the n_link values of all the underlying inodes of the passed inode */
+static inline int get_nlinks(struct inode *inode)
+{
+	int sum_nlinks = 0;
+	int dirs = 0;
+	int bindex;
+	struct inode *hidden_inode;
+
+	if (!S_ISDIR(inode->i_mode))
+		return itohi(inode)->i_nlink;
+
+	for (bindex = ibstart(inode); bindex <= ibend(inode); bindex++) {
+		hidden_inode = itohi_index(inode, bindex);
+		if (!hidden_inode || !S_ISDIR(hidden_inode->i_mode))
+			continue;
+		BUG_ON(hidden_inode->i_nlink < 0);
+
+		/* A deleted directory. */
+		if (hidden_inode->i_nlink == 0)
+			continue;
+		dirs++;
+		/* A broken directory (e.g., squashfs). */
+		if (hidden_inode->i_nlink == 1)
+			sum_nlinks += 2;
+		else
+			sum_nlinks += (hidden_inode->i_nlink - 2);
+	}
+
+	if (!dirs)
+		return 0;
+	return sum_nlinks + 2;
+}
+
+static inline void fist_copy_attr_atime(struct inode *dest,
+					const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+}
+
+static inline void fist_copy_attr_times(struct inode *dest,
+					const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+}
+
+static inline void fist_copy_attr_timesizes(struct inode *dest,
+					    const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	dest->i_size = src->i_size;
+	dest->i_blocks = src->i_blocks;
+}
+
+static inline void fist_copy_attr_all(struct inode *dest,
+				      const struct inode *src)
+{
+	dest->i_mode = src->i_mode;
+	/* we do not need to copy if the file is a deleted file */
+	if (dest->i_nlink > 0)
+		dest->i_nlink = get_nlinks(dest);
+	dest->i_uid = src->i_uid;
+	dest->i_gid = src->i_gid;
+	dest->i_rdev = src->i_rdev;
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	dest->i_blkbits = src->i_blkbits;
+	dest->i_size = src->i_size;
+	dest->i_blocks = src->i_blocks;
+	dest->i_flags = src->i_flags;
+}
+
+struct dentry *unionfs_lookup_backend(struct dentry *dentry, struct nameidata *nd, int lookupmode);
+int is_stale_inode(struct inode *inode);
+void make_stale_inode(struct inode *inode);
+
+#define IS_SET(sb, check_flag) (check_flag & MOUNT_FLAG(sb))
+
+/* unionfs_permission, check if we should bypass error to facilitate copyup */
+#define IS_COPYUP_ERR(err) ((err) == -EROFS)
+
+/* unionfs_open, check if we need to copyup the file */
+#define OPEN_WRITE_FLAGS (O_WRONLY | O_RDWR | O_APPEND)
+#define IS_WRITE_FLAG(flag) ((flag) & (OPEN_WRITE_FLAGS))
+
+static inline int branchperms(struct super_block *sb, int index)
+{
+	BUG_ON(index < 0);
+
+	return stopd(sb)->usi_data[index].branchperms;
+}
+static inline int set_branchperms(struct super_block *sb, int index, int perms)
+{
+	BUG_ON(index < 0);
+
+	stopd(sb)->usi_data[index].branchperms = perms;
+
+	return perms;
+}
+
+/* Is this file on a read-only branch? */
+static inline int __is_robranch_super(struct super_block *sb, int index,
+				      char *file, const char *function,
+				      int line)
+{
+	int err = 0;
+
+	if (!(branchperms(sb, index) & MAY_WRITE))
+		err = -EROFS;
+
+	return err;
+}
+
+/* Is this file on a read-only branch? */
+static inline int __is_robranch_index(struct dentry *dentry, int index,
+				      char *file, const char *function,
+				      int line)
+{
+	int err = 0;
+	int perms;
+
+	BUG_ON(index < 0);
+
+	perms = stopd(dentry->d_sb)->usi_data[index].branchperms;
+
+	if ((!(perms & MAY_WRITE))
+	    || (IS_RDONLY(dtohd_index(dentry, index)->d_inode)))
+		err = -EROFS;
+
+	return err;
+}
+static inline int __is_robranch(struct dentry *dentry, char *file,
+				const char *function, int line)
+{
+	int index;
+	int err;
+
+	index = dtopd(dentry)->udi_bstart;
+	BUG_ON(index < 0);
+
+	err = __is_robranch_index(dentry, index, file, function, line);
+
+	return err;
+}
+
+#define is_robranch(d) __is_robranch(d, __FILE__, __FUNCTION__, __LINE__)
+#define is_robranch_super(s, n) __is_robranch_super(s, n, __FILE__, __FUNCTION__, __LINE__)
+
+/* What do we use for whiteouts. */
+#define UNIONFS_WHPFX ".wh."
+#define UNIONFS_WHLEN 4
+/* If a directory contains this file, then it is opaque.  We start with the
+ * .wh. flag so that it is blocked by lookup.
+ */
+#define UNIONFS_DIR_OPAQUE_NAME "__dir_opaque"
+#define UNIONFS_DIR_OPAQUE UNIONFS_WHPFX UNIONFS_DIR_OPAQUE_NAME
+
+/* construct whiteout filename */
+static inline char *alloc_whname(const char *name, int len)
+{
+	char *buf;
+
+	buf = kmalloc(len + UNIONFS_WHLEN + 1, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	strcpy(buf, UNIONFS_WHPFX);
+	strlcat(buf, name, len + UNIONFS_WHLEN + 1);
+
+	return buf;
+}
+
+#define VALID_MOUNT_FLAGS (0)
+
+/*
+ * MACROS:
+ */
+
+#ifndef DEFAULT_POLLMASK
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
+#endif
+
+/*
+ * EXTERNALS:
+ */
+
+/* These two functions are here because it is kind of daft to copy and paste the
+ * contents of the two functions to 32+ places in unionfs
+ */
+static inline struct dentry *lock_parent(struct dentry *dentry)
+{
+	struct dentry *dir = dget(dentry->d_parent);
+
+	mutex_lock(&dir->d_inode->i_mutex);
+	return dir;
+}
+
+static inline void unlock_dir(struct dentry *dir)
+{
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(dir);
+}
+
+extern int make_dir_opaque(struct dentry *dir, int bindex);
+
+#endif	/* not _UNION_H_ */
+


