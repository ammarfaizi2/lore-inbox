Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVEWWgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEWWgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEWWgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 18:36:01 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:29181 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261161AbVEWW0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:26:33 -0400
Message-Id: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Mon, 23 May 2005 17:25:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 3/7] v9fs: VFS inode operations (2.0-rc6)
Cc: v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [3/7] of the v9fs-2.0-rc6 patch against Linux v2.6.12-rc4.

This part of the patch contains the VFS inode interfaces.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

 vfs_inode.c | 1534 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1534 insertions(+)

-------------


Index: fs/9p/vfs_inode.c
===================================================================
--- /dev/null  (tree:0bf32353105286a5624aeea862d35a4bbae09851)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/9p/vfs_inode.c  (mode:100644)
@@ -0,0 +1,1534 @@
+/*
+ *  linux/fs/9p/vfs_inode.c
+ *
+ * This file contians vfs inode ops for the 9P2000 protocol.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/pagemap.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+#include <linux/namei.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "conv.h"
+#include "fid.h"
+
+static struct inode_operations v9fs_dir_inode_operations;
+static struct inode_operations v9fs_file_inode_operations;
+static struct inode_operations v9fs_symlink_inode_operations;
+
+/**
+ * unixmode2p9mode - convert unix mode bits to plan 9
+ * @v9ses: v9fs session information
+ * @mode: mode to convert
+ *
+ */
+
+static inline int unixmode2p9mode(struct v9fs_session_info *v9ses, int mode)
+{
+	int res;
+	res = mode & 0777;
+	if (S_ISDIR(mode))
+		res |= V9FS_DMDIR;
+	if (v9ses->extended) {
+		if (S_ISLNK(mode))
+			res |= V9FS_DMSYMLINK;
+		if (v9ses->nodev == 0) {
+			if (S_ISSOCK(mode))
+				res |= V9FS_DMSOCKET;
+			if (S_ISFIFO(mode))
+				res |= V9FS_DMNAMEDPIPE;
+			if (S_ISBLK(mode))
+				res |= V9FS_DMDEVICE;
+			if (S_ISCHR(mode))
+				res |= V9FS_DMDEVICE;
+		}
+
+		if ((mode & S_ISUID) == S_ISUID)
+			res |= V9FS_DMSETUID;
+		if ((mode & S_ISGID) == S_ISGID)
+			res |= V9FS_DMSETGID;
+		if ((mode & V9FS_DMLINK))
+			res |= V9FS_DMLINK;
+	}
+
+	return res;
+}
+
+/**
+ * p9mode2unixmode- convert plan9 mode bits to unix mode bits
+ * @v9ses: v9fs session information
+ * @mode: mode to convert
+ *
+ */
+
+static inline int p9mode2unixmode(struct v9fs_session_info *v9ses, int mode)
+{
+	int res;
+
+	res = mode & 0777;
+
+	if ((mode & V9FS_DMDIR) == V9FS_DMDIR)
+		res |= S_IFDIR;
+	else if ((mode & V9FS_DMSYMLINK) && (v9ses->extended))
+		res |= S_IFLNK;
+	else if ((mode & V9FS_DMSOCKET) && (v9ses->extended)
+		 && (v9ses->nodev == 0))
+		res |= S_IFSOCK;
+	else if ((mode & V9FS_DMNAMEDPIPE) && (v9ses->extended)
+		 && (v9ses->nodev == 0))
+		res |= S_IFIFO;
+	else if ((mode & V9FS_DMDEVICE) && (v9ses->extended)
+		 && (v9ses->nodev == 0))
+		res |= S_IFBLK;
+	else
+		res |= S_IFREG;
+
+	if (v9ses->extended) {
+		if ((mode & V9FS_DMSETUID) == V9FS_DMSETUID)
+			res |= S_ISUID;
+
+		if ((mode & V9FS_DMSETGID) == V9FS_DMSETGID)
+			res |= S_ISGID;
+	}
+
+	return res;
+}
+
+/**
+ * v9fs_blank_mistat - helper function to setup a 9P stat structure
+ * @v9ses: 9P session info (for determining extended mode)
+ * @mistat: structure to initialize
+ *
+ */
+
+static inline void
+v9fs_blank_mistat(struct v9fs_session_info *v9ses, struct v9fs_stat *mistat)
+{
+	mistat->type = ~0;
+	mistat->qid.type = ~0;
+	mistat->qid.version = ~0;
+	*((long long *)&mistat->qid.path) = ~0;
+	mistat->mode = ~0;
+	mistat->atime = ~0;
+	mistat->mtime = ~0;
+	mistat->length = ~0;
+	mistat->name = mistat->data;
+	mistat->uid = mistat->data;
+	mistat->gid = mistat->data;
+	mistat->muid = mistat->data;
+	if (v9ses->extended) {
+		mistat->n_uid = ~0;
+		mistat->n_gid = ~0;
+		mistat->n_muid = ~0;
+		mistat->extension = mistat->data;
+	}
+	*mistat->data = 0;
+}
+
+/**
+ * v9fs_mistat2unix - convert mistat to unix stat
+ * @mistat: Plan 9 metadata (mistat) structure
+ * @stat: unix metadata (stat) structure to populate 
+ * @sb: superblock
+ *
+ */
+
+static void
+v9fs_mistat2unix(struct v9fs_stat *mistat, struct stat *buf,
+		 struct super_block *sb)
+{
+	struct v9fs_session_info *v9ses = sb ? sb->s_fs_info : NULL;
+
+	buf->st_nlink = 1;
+
+	buf->st_atime = mistat->atime;
+	buf->st_mtime = mistat->mtime;
+	buf->st_ctime = mistat->mtime;
+
+	if (v9ses && v9ses->extended) {
+		/* TODO: string to uid mapping via user-space daemon */
+		buf->st_uid = mistat->n_uid;
+		buf->st_gid = mistat->n_gid;
+
+		sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
+		sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
+	} else {
+		buf->st_uid = v9ses->uid;
+		buf->st_gid = v9ses->gid;
+	}
+
+	buf->st_uid = (unsigned short)-1;
+	buf->st_gid = (unsigned short)-1;
+
+	if (v9ses && v9ses->extended) {
+		if (mistat->n_uid != -1)
+			sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
+
+		if (mistat->n_gid != -1)
+			sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
+	}
+
+	if (buf->st_uid == (unsigned short)-1)
+		buf->st_uid = v9ses->uid;
+	if (buf->st_gid == (unsigned short)-1)
+		buf->st_gid = v9ses->gid;
+
+	buf->st_mode = p9mode2unixmode(v9ses, mistat->mode);
+	if ((S_ISBLK(buf->st_mode)) || (S_ISCHR(buf->st_mode))) {
+		char type = 0;
+		int major = -1;
+		int minor = -1;
+		sscanf(mistat->extension, "%c %u %u", &type, &major, &minor);
+		switch (type) {
+		case 'c':
+			buf->st_mode &= ~S_IFBLK;
+			buf->st_mode |= S_IFCHR;
+			break;
+		case 'b':
+			break;
+		default:
+			dprintk(DEBUG_ERROR, "Unknown special type %c (%s)\n",
+				type, mistat->extension);
+		};
+		buf->st_rdev = MKDEV(major, minor);
+	} else
+		buf->st_rdev = 0;
+
+	buf->st_size = mistat->length;
+
+	buf->st_blksize = sb->s_blocksize;
+	buf->st_blocks =
+	    (buf->st_size + buf->st_blksize - 1) >> sb->s_blocksize_bits;
+}
+
+/**
+ * v9fs_get_inode - helper function to setup an inode
+ * @sb: superblock
+ * @mode: mode to setup inode with
+ *
+ */
+
+struct inode *v9fs_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode = NULL;
+
+	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
+	switch (mode & S_IFMT) {
+	default:
+		dprintk(DEBUG_ERROR, "BAD mode 0x%x S_IFMT 0x%x\n", mode,
+			mode & S_IFMT);
+		return ERR_PTR(-EINVAL);
+		break;
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFLNK:
+	case S_IFIFO:
+	case S_IFBLK:
+	case S_IFCHR:
+	case S_IFSOCK:
+		break;
+	}
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = sb->s_blocksize;
+		inode->i_blocks = 0;
+		inode->i_rdev = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+
+		switch (mode & S_IFMT) {
+		default:
+			panic("Can't happen");
+			break;
+		case S_IFIFO:
+		case S_IFBLK:
+		case S_IFCHR:
+		case S_IFSOCK:
+		case S_IFREG:
+			inode->i_op = &v9fs_file_inode_operations;
+			inode->i_fop = &v9fs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_nlink++;
+			inode->i_op = &v9fs_dir_inode_operations;
+			inode->i_fop = &v9fs_dir_operations;
+			break;
+		case S_IFLNK:
+			inode->i_op = &v9fs_symlink_inode_operations;
+			break;
+		}
+	} else {
+		eprintk(KERN_WARNING, "Problem allocating inode\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	return inode;
+}
+
+/**
+ * v9fs_create - helper function to create files and directories
+ * @dir: directory inode file is being created in
+ * @file_dentry: dentry file is being created in 
+ * @perm: permissions file is being created with
+ * @open_mode: resulting open mode for file ???
+ * 
+ */
+
+static int
+v9fs_create(struct inode *dir,
+	    struct dentry *file_dentry,
+	    unsigned int perm, unsigned int open_mode)
+{
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
+	struct super_block *sb = dir ? dir->i_sb : NULL;
+	struct v9fs_fid *dirfid =
+	    v9fs_fid_lookup(file_dentry->d_parent, FID_WALK);
+	struct v9fs_fid *fid = NULL;
+	struct inode *file_inode = NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_qid qid;
+	struct stat newstat;
+	int dirfidnum = -1;
+	long newfid = -1;
+	int result = 0;
+	unsigned int iounit = 0;
+
+	perm = unixmode2p9mode(v9ses, perm);
+
+	dprintk(DEBUG_VFS, "dir: %p dentry: %p perm: %o mode: %o\n", dir,
+		file_dentry, perm, open_mode);
+
+	if ((!dirfid) || (!sb) || (!v9ses)) {
+		dprintk(DEBUG_ERROR, "problem with arguments\n");
+		return -EBADF;
+	}
+
+	dirfidnum = dirfid->fid;
+	if (dirfidnum < 0) {
+		dprintk(DEBUG_ERROR, "No fid for the directory #%lu\n",
+			dir->i_ino);
+		return -EBADF;
+	}
+
+	if (file_dentry->d_inode) {
+		dprintk(DEBUG_ERROR,
+			"Odd. There is an inode for dir %lu, name :%s:\n",
+			dir->i_ino, file_dentry->d_name.name);
+		return -EEXIST;
+	}
+
+	newfid = v9fs_get_idpool(&v9ses->fidpool);
+	if (newfid < 0) {
+		eprintk(KERN_WARNING, "no free fids available\n");
+		return -ENOSPC;
+	}
+
+	result = v9fs_t_walk(v9ses, dirfidnum, newfid, NULL, &fcall);
+	if (result < 0) {
+		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
+		v9fs_put_idpool(newfid, &v9ses->fidpool);
+		newfid = 0;
+		goto CleanUpFid;
+	}
+
+	safe_cache_free(v9ses->slab, fcall);
+
+	result = v9fs_t_create(v9ses, newfid, (char *)file_dentry->d_name.name,
+			       perm, open_mode, &fcall);
+	if (result < 0) {
+		dprintk(DEBUG_ERROR, "create fails: %s(%d)\n",
+			FCALL_ERROR(fcall), result);
+
+		goto CleanUpFid;
+	}
+
+	iounit = fcall->params.rcreate.iounit;
+	qid = fcall->params.rcreate.qid;
+	safe_cache_free(v9ses->slab, fcall);
+
+	fid = v9fs_fid_create(file_dentry);
+	if (!fid) {
+		result = -ENOMEM;
+		goto CleanUpFid;
+	}
+
+	fid->fid = newfid;
+	fid->fidopen = 0;
+	fid->fidcreate = 1;
+	fid->qid = qid;
+	fid->iounit = iounit;
+	fid->rdir_pos = 0;
+	fid->rdir_fcall = NULL;
+	fid->v9ses = v9ses;
+
+	if ((perm & V9FS_DMSYMLINK) || (perm & V9FS_DMLINK) ||
+	    (perm & V9FS_DMNAMEDPIPE) || (perm & V9FS_DMSOCKET) ||
+	    (perm & V9FS_DMDEVICE))
+		return 0;
+
+	result = v9fs_t_stat(v9ses, newfid, &fcall);
+	if (result < 0) {
+		dprintk(DEBUG_ERROR, "stat error: %s(%d)\n", FCALL_ERROR(fcall),
+			result);
+		goto CleanUpFid;
+	}
+
+	v9fs_mistat2unix(fcall->params.rstat.stat, &newstat, sb);
+
+	file_inode = v9fs_get_inode(sb, newstat.st_mode);
+	if ((!file_inode) || IS_ERR(file_inode)) {
+		dprintk(DEBUG_ERROR, "create inode failed\n");
+		result = -EBADF;
+		goto CleanUpFid;
+	}
+
+	v9fs_mistat2inode(fcall->params.rstat.stat, file_inode, sb);
+	safe_cache_free(v9ses->slab, fcall);
+	d_instantiate(file_dentry, file_inode);
+
+	if (perm & V9FS_DMDIR) {
+		if (v9fs_t_clunk(v9ses, newfid, &fcall))
+			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %s\n",
+				FCALL_ERROR(fcall));
+
+		v9fs_put_idpool(newfid, &v9ses->fidpool);
+		safe_cache_free(v9ses->slab, fcall);
+		fid->fidopen = 0;
+		fid->fidcreate = 0;
+		d_drop(file_dentry);
+	}
+
+	return 0;
+
+      CleanUpFid:
+	safe_cache_free(v9ses->slab, fcall);
+
+	if (newfid) {
+		if (v9fs_t_clunk(v9ses, newfid, &fcall))
+			dprintk(DEBUG_ERROR, "clunk failed: %s\n",
+				FCALL_ERROR(fcall));
+
+		v9fs_put_idpool(newfid, &v9ses->fidpool);
+		safe_cache_free(v9ses->slab, fcall);
+	}
+	return result;
+}
+
+/**
+ * v9fs_remove - helper function to remove files and directories
+ * @inode: directory inode that is being deleted
+ * @dentry:  dentry that is being deleted
+ * @rmdir: where we are a file or a directory
+ *
+ */
+
+static int v9fs_remove(struct inode *dir, struct dentry *file, int rmdir)
+{
+	struct v9fs_fcall *fcall = NULL;
+	struct super_block *sb = NULL;
+	struct v9fs_session_info *v9ses = NULL;
+	struct v9fs_fid *v9fid = NULL;
+	struct inode *file_inode = NULL;
+	int fid = -1;
+	int result = 0;
+
+	dprintk(DEBUG_VFS, "inode: %p dentry: %p rmdir: %d\n", dir, file,
+		rmdir);
+
+	if (!dir || !S_ISDIR(dir->i_mode)) {
+		dprintk(DEBUG_ERROR, "dir inode is NULL or not a directory\n");
+		return -ENOENT;
+	}
+
+	if (!file) {
+		dprintk(DEBUG_ERROR, "NO dentry for file to remove\n");
+		return -EBADF;
+	}
+
+	if (!file->d_inode) {
+		dprintk(DEBUG_ERROR,
+			"dentry %p NO INODE for file to remove!\n", file);
+		return -EBADF;
+	}
+
+	file_inode = file->d_inode;
+	sb = file_inode->i_sb;
+	v9ses = v9fs_inode2v9ses(file_inode);
+	v9fid = v9fs_fid_lookup(file, FID_OP);
+
+	if (!sb || !v9ses || !v9fid) {
+		dprintk(DEBUG_ERROR,
+			"no superblock or v9session or v9fs_fid\n");
+		return -EBADF;
+	}
+
+	fid = v9fid->fid;
+	if (fid < 0) {
+		dprintk(DEBUG_ERROR, "inode #%lu, no fid!\n",
+			file_inode->i_ino);
+		return -EBADF;
+	}
+
+	if (rmdir && (!S_ISDIR(file_inode->i_mode))) {
+		dprintk(DEBUG_ERROR, "trying to remove non-directory\n");
+		return -ENOTDIR;
+	} else if ((!rmdir) && S_ISDIR(file_inode->i_mode)) {
+		dprintk(DEBUG_ERROR, "trying to remove directory\n");
+		return -EISDIR;
+	}
+
+	result = v9fs_t_remove(v9ses, fid, &fcall);
+	if (result < 0)
+		dprintk(DEBUG_ERROR, "remove of file fails: %s(%d)\n",
+			FCALL_ERROR(fcall), result);
+	else {
+		v9fs_put_idpool(fid, &v9ses->fidpool);
+		v9fs_fid_destroy(v9fid);
+	}
+
+	safe_cache_free(v9ses->slab, fcall);
+
+	return result;
+}
+
+/**
+ * v9fs_vfs_create - VFS hook to create files
+ * @inode: directory inode that is being deleted
+ * @dentry:  dentry that is being deleted
+ * @perm: create permissions
+ * @nd: path information
+ *
+ */
+
+static int
+v9fs_vfs_create(struct inode *inode, struct dentry *dentry, int perm,
+		struct nameidata *nd)
+{
+	int retval = -EPERM;
+	int open_mode = O_RDWR;
+
+	retval = v9fs_create(inode, dentry, perm, open_mode);
+
+	return retval;
+}
+
+/**
+ * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
+ * @i:  inode that is being unlinked
+ * @dentry: dentry that is being unlinked
+ * @mode: mode for new directory
+ *
+ */
+
+static int v9fs_vfs_mkdir(struct inode *inode, struct dentry *dentry, int mode)
+{
+	int retval = -EPERM;
+	int open_mode = O_RDONLY;
+
+	retval = v9fs_create(inode, dentry, mode | S_IFDIR, open_mode);
+
+	return retval;
+}
+
+/**
+ * v9fs_dentry_validate - VFS dcache hook to validate cache
+ * @dentry:  dentry that is being validated
+ * @nd: path data
+ *
+ * dcache really shouldn't be used for 9P2000 as at all due to
+ * potential attached semantics to directory traversal (walk).
+ *
+ * FUTURE: look into how to use dcache to allow multi-stage
+ * walks in Plan 9 & potential for better dcache operation which
+ * would remain valid for Plan 9 semantics.  Older versions 
+ * had validation via stat for those interested.  However, since
+ * stat has the same approximate overhead as walk there really
+ * is no difference.  The only improvement would be from a 
+ * time-decay cache like NFS has and that undermines the
+ * synchronous nature of 9P2000.
+ *
+ */
+
+static int v9fs_dentry_validate(struct dentry *dentry, struct nameidata *nd)
+{
+	struct dentry *dc = current->fs->pwd;
+
+	dprintk(DEBUG_VFS, "dentry: %s (%p)\n", dentry->d_iname, dentry);
+	if (v9fs_fid_lookup(dentry, FID_OP)) {
+		dprintk(DEBUG_VFS, "VALID\n");
+		return 1;
+	}
+
+	while (dc != NULL) {
+		if (dc == dentry) {
+			dprintk(DEBUG_VFS, "VALID\n");
+			return 1;
+		}
+		if (dc == dc->d_parent)
+			break;
+
+		dc = dc->d_parent;
+	}
+
+	dprintk(DEBUG_VFS, "INVALID\n");
+	return 0;
+}
+
+/**
+ * v9fs_dentry_delete - called when dentry refcount reaches 0
+* @dentry:  dentry that is being deleted
+ *
+ */
+
+static int v9fs_dentry_delete(struct dentry *dentry)
+{
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+	return 1;
+}
+
+/*
+ * v9fs_dentry_release - called when dentry is going to be freed
+* @dentry:  dentry that is being release
+ *
+ */
+
+void v9fs_dentry_release(struct dentry *dentry)
+{
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+
+	if (dentry->d_fsdata != NULL) {
+		struct list_head *fid_list =
+		    (struct list_head *)dentry->d_fsdata;
+		struct list_head *temp;
+		struct v9fs_fid *current_fid = NULL;
+		struct list_head *p;
+		struct v9fs_fcall *fcall = NULL;
+
+		list_for_each_safe(p, temp, fid_list) {
+			current_fid = list_entry(p, struct v9fs_fid, list);
+			if (v9fs_t_clunk
+			    (current_fid->v9ses, current_fid->fid, &fcall))
+				dprintk(DEBUG_ERROR, "clunk failed: %s\n",
+					FCALL_ERROR(fcall));
+
+			v9fs_put_idpool(current_fid->fid,
+					&current_fid->v9ses->fidpool);
+
+			safe_cache_free(current_fid->v9ses->slab, fcall);
+			v9fs_fid_destroy(current_fid);
+		}
+
+		kfree(dentry->d_fsdata);	/* free the list_head */
+	}
+}
+
+static struct dentry_operations v9fs_dentry_operations = {
+	.d_revalidate = v9fs_dentry_validate,
+	.d_delete = v9fs_dentry_delete,
+	.d_release = v9fs_dentry_release,
+};
+
+/**
+ * v9fs_vfs_lookup - VFS lookup hook to "walk" to a new inode
+ * @dir:  inode that is being walked from
+ * @dentry: dentry that is being walked to?
+ * @nameidata: path data
+ *
+ */
+
+static struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
+				      struct nameidata *nameidata)
+{
+	struct super_block *sb = NULL;
+	struct v9fs_session_info *v9ses = NULL;
+	struct v9fs_fid *dirfid = NULL;
+	struct v9fs_fid *fid = NULL;
+	struct inode *inode = NULL;
+	struct dentry *retval = NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct stat newstat;
+	int dirfidnum = -1;
+	int newfid = -1;
+	int result = 0;
+
+	dprintk(DEBUG_VFS, "dir: %p dentry: (%s) %p nameidata: %p\n",
+		dir, dentry->d_iname, dentry, nameidata);
+
+	if (!dir) {
+		dprintk(DEBUG_ERROR, "no dir inode\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	sb = dir->i_sb;
+	v9ses = v9fs_inode2v9ses(dir);
+	dirfid = v9fs_fid_lookup(dentry->d_parent, FID_WALK);
+
+	if (!sb || !v9ses || !dirfid) {
+		dprintk(DEBUG_ERROR, "no superblock, v9ses, or dirfid\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	dirfidnum = dirfid->fid;
+
+	if (dirfidnum < 0) {
+		dprintk(DEBUG_ERROR, "no dirfid for inode %p, #%lu\n",
+			dir, dir->i_ino);
+		return ERR_PTR(-EBADF);
+	}
+
+	newfid = v9fs_get_idpool(&v9ses->fidpool);
+	if (newfid < 0) {
+		eprintk(KERN_WARNING, "newfid fails!\n");
+		return ERR_PTR(-ENOSPC);
+	}
+
+	result =
+	    v9fs_t_walk(v9ses, dirfidnum, newfid, (char *)dentry->d_name.name,
+			NULL);
+	if (result < 0) {
+		v9fs_put_idpool(newfid, &v9ses->fidpool);
+		if (result == -ENOENT) {
+			d_add(dentry, NULL);
+			dprintk(DEBUG_ERROR,
+				"Return negative dentry %p count %d\n",
+				dentry, atomic_read(&dentry->d_count));
+			return NULL;
+		}
+		dprintk(DEBUG_ERROR, "walk error:%d\n", result);
+		goto FreeFcall;
+	}
+
+	result = v9fs_t_stat(v9ses, newfid, &fcall);
+	if (result < 0) {
+		dprintk(DEBUG_ERROR, "stat error\n");
+		goto FreeFcall;
+	}
+
+	v9fs_mistat2unix(fcall->params.rstat.stat, &newstat, sb);
+	inode = v9fs_get_inode(sb, newstat.st_mode);
+
+	if (IS_ERR(inode) && (PTR_ERR(inode) == -ENOSPC)) {
+		eprintk(KERN_WARNING, "inode alloc failes, returns %ld\n",
+			PTR_ERR(inode));
+
+		result = -ENOSPC;
+		goto FreeFcall;
+	}
+
+	inode->i_ino = v9fs_qid2ino(&fcall->params.rstat.stat->qid);
+
+	fid = v9fs_fid_create(dentry);
+	if (fid == NULL) {
+		dprintk(DEBUG_ERROR, "couldn't insert\n");
+		result = -ENOMEM;
+		goto FreeFcall;
+	}
+
+	fid->fid = newfid;
+	fid->fidopen = 0;
+	fid->v9ses = v9ses;
+	fid->qid = fcall->params.rstat.stat->qid;
+
+	dentry->d_op = &v9fs_dentry_operations;
+	v9fs_mistat2inode(fcall->params.rstat.stat, inode, inode->i_sb);
+
+	d_add(dentry, inode);
+	safe_cache_free(v9ses->slab, fcall);
+
+	return retval;
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, fcall);
+	return ERR_PTR(result);
+}
+
+/**
+ * v9fs_vfs_unlink - VFS unlink hook to delete an inode
+ * @i:  inode that is being unlinked
+ * @dentry: dentry that is being unlinked
+ *
+ */
+
+static int v9fs_vfs_unlink(struct inode *i, struct dentry *d)
+{
+	int retval = -EPERM;
+
+	retval = v9fs_remove(i, d, 0);
+	return retval;
+}
+
+/**
+ * v9fs_vfs_rmdir - VFS unlink hook to delete a directory
+ * @i:  inode that is being unlinked
+ * @dentry: dentry that is being unlinked
+ *
+ */
+
+static int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
+{
+	int retval = -EPERM;
+
+	retval = v9fs_remove(i, d, 1);
+	return retval;
+}
+
+/**
+ * v9fs_vfs_rename - VFS hook to rename an inode
+ * @old_dir:  old dir inode
+ * @old_dentry: old dentry
+ * @new_dir: new dir inode
+ * @new_dentry: new dentry
+ * 
+ */
+
+static int
+v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *old_inode = old_dentry ? old_dentry->d_inode : NULL;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(old_inode);
+	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_WALK);
+	struct v9fs_fid *olddirfid =
+	    v9fs_fid_lookup(old_dentry->d_parent, FID_WALK);
+	struct v9fs_fid *newdirfid =
+	    v9fs_fid_lookup(new_dentry->d_parent, FID_WALK);
+	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
+	struct v9fs_fcall *fcall = NULL;
+	int fid = -1;
+	int olddirfidnum = -1;
+	int newdirfidnum = -1;
+	int retval = 0;
+
+	dprintk(DEBUG_VFS, "\n");
+
+	if ((!oldfid) || (!olddirfid) || (!newdirfid)) {
+		dprintk(DEBUG_ERROR, "problem with arguments\n");
+		return -EPERM;
+	}
+
+	/* 9P can only handle file rename in the same directory */
+	if (memcmp(&olddirfid->qid, &newdirfid->qid, sizeof(newdirfid->qid))) {
+		dprintk(DEBUG_ERROR, "old dir and new dir are different\n");
+		retval = -EPERM;
+		goto FreeFcall;
+	}
+
+	fid = oldfid->fid;
+	olddirfidnum = olddirfid->fid;
+	newdirfidnum = newdirfid->fid;
+
+	if (fid < 0) {
+		dprintk(DEBUG_ERROR, "no fid for old file #%lu\n",
+			old_inode->i_ino);
+		retval = -EBADF;
+		goto FreeFcall;
+	}
+
+	v9fs_blank_mistat(v9ses, mistat);
+
+	strcpy(mistat->data + 1, v9ses->name);
+	mistat->name = mistat->data + 1 + strlen(v9ses->name);
+
+	if (new_dentry->d_name.len >
+	    (v9ses->maxdata - strlen(v9ses->name) - sizeof(struct v9fs_stat))) {
+		dprintk(DEBUG_ERROR, "new name too long\n");
+		goto FreeFcall;
+	}
+
+	strcpy(mistat->name, new_dentry->d_name.name);
+	retval = v9fs_t_wstat(v9ses, fid, mistat, &fcall);
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, mistat);
+
+	if (retval < 0)
+		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
+			FCALL_ERROR(fcall));
+
+	safe_cache_free(v9ses->slab, fcall);
+	return retval;
+}
+
+/**
+ * v9fs_vfs_getattr - retreive file metadata
+ * @mnt - mount information
+ * @dentry - file to get attributes on
+ * @stat - metadata structure to populate
+ *
+ */
+
+static int
+v9fs_vfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
+		 struct kstat *stat)
+{
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+	int err = -EPERM;
+
+	dprintk(DEBUG_VFS, "dentry: %p\n", dentry);
+	if (!fid) {
+		dprintk(DEBUG_ERROR,
+			"couldn't find fid associated with dentry\n");
+		return -EBADF;
+	}
+
+	err = v9fs_t_stat(v9ses, fid->fid, &fcall);
+
+	if (err < 0)
+		dprintk(DEBUG_ERROR, "stat error\n");
+	else {
+		v9fs_mistat2inode(fcall->params.rstat.stat, dentry->d_inode,
+				  dentry->d_inode->i_sb);
+		generic_fillattr(dentry->d_inode, stat);
+	}
+
+	safe_cache_free(v9ses->slab, fcall);
+	return err;
+}
+
+/**
+ * v9fs_vfs_setattr - set file metadata
+ * @dentry: file whose metadata to set
+ * @iattr: metadata assignment structure
+ *
+ */
+
+static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
+	struct v9fs_fcall *fcall = NULL;
+	int res = -EPERM;
+
+	dprintk(DEBUG_VFS, "\n");
+	if (!fid) {
+		dprintk(DEBUG_ERROR,
+			"Couldn't find fid associated with dentry\n");
+		return -EBADF;
+	}
+
+	if (!mistat)
+		return -ENOMEM;
+
+	v9fs_blank_mistat(v9ses, mistat);
+	if (iattr->ia_valid & ATTR_MODE)
+		mistat->mode = unixmode2p9mode(v9ses, iattr->ia_mode);
+
+	if (iattr->ia_valid & ATTR_MTIME)
+		mistat->mtime = iattr->ia_mtime.tv_sec;
+
+	if (iattr->ia_valid & ATTR_ATIME)
+		mistat->atime = iattr->ia_atime.tv_sec;
+
+	if (iattr->ia_valid & ATTR_SIZE)
+		mistat->length = iattr->ia_size;
+
+	if (v9ses->extended) {
+		char *uid = NULL;
+		char *gid = NULL;
+		char *muid = NULL;
+		char *name = NULL;
+		char *extension = NULL;
+
+		uid = kmalloc(strlen(mistat->uid), GFP_KERNEL);
+		gid = kmalloc(strlen(mistat->gid), GFP_KERNEL);
+		muid = kmalloc(strlen(mistat->muid), GFP_KERNEL);
+		name = kmalloc(strlen(mistat->name), GFP_KERNEL);
+		extension = kmalloc(strlen(mistat->extension), GFP_KERNEL);
+
+		strcpy(uid, mistat->uid);
+		strcpy(gid, mistat->gid);
+		strcpy(muid, mistat->muid);
+		strcpy(name, mistat->name);
+		strcpy(extension, mistat->extension);
+
+		if (iattr->ia_valid & ATTR_UID) {
+			if (strlen(uid) != 8) {
+				dprintk(DEBUG_ERROR, "uid strlen is %u not 8\n",
+					(unsigned int)strlen(uid));
+				sprintf(uid, "%08x", iattr->ia_uid);
+			} else {
+				kfree(uid);
+				uid = kmalloc(9, GFP_KERNEL);
+			}
+
+			sprintf(uid, "%08x", iattr->ia_uid);
+			mistat->n_uid = iattr->ia_uid;
+		}
+
+		if (iattr->ia_valid & ATTR_GID) {
+			if (strlen(gid) != 8)
+				dprintk(DEBUG_ERROR, "gid strlen is %u not 8\n",
+					(unsigned int)strlen(gid));
+			else {
+				kfree(gid);
+				gid = kmalloc(9, GFP_KERNEL);
+			}
+
+			sprintf(gid, "%08x", iattr->ia_gid);
+			mistat->n_gid = iattr->ia_gid;
+		}
+
+		mistat->uid = mistat->data;
+		strcpy(mistat->uid, uid);
+		mistat->gid = mistat->data + strlen(uid) + 1;
+		strcpy(mistat->gid, gid);
+		mistat->muid = mistat->gid + strlen(gid) + 1;
+		strcpy(mistat->muid, muid);
+		mistat->name = mistat->muid + strlen(muid) + 1;
+		strcpy(mistat->name, name);
+		mistat->extension = mistat->name + strlen(name) + 1;
+		strcpy(mistat->extension, extension);
+
+		kfree(uid);
+		kfree(gid);
+		kfree(muid);
+		kfree(name);
+		kfree(extension);
+	}
+
+	res = v9fs_t_wstat(v9ses, fid->fid, mistat, &fcall);
+
+	if (res < 0)
+		dprintk(DEBUG_ERROR, "wstat error: %s\n", FCALL_ERROR(fcall));
+
+	safe_cache_free(v9ses->slab, mistat);
+	safe_cache_free(v9ses->slab, fcall);
+
+	if (res >= 0)
+		res = inode_setattr(dentry->d_inode, iattr);
+
+	return res;
+}
+
+/**
+ * v9fs_mistat2inode - populate an inode structure with mistat info
+ * @mistat: Plan 9 metadata (mistat) structure
+ * @inode: inode to populate
+ * @sb: superblock of filesystem
+ *
+ */
+
+void
+v9fs_mistat2inode(struct v9fs_stat *mistat, struct inode *inode,
+		  struct super_block *sb)
+{
+	struct v9fs_session_info *v9ses = sb ? sb->s_fs_info : NULL;
+
+	inode->i_nlink = 1;
+
+	inode->i_atime.tv_sec = mistat->atime;
+	inode->i_mtime.tv_sec = mistat->mtime;
+	inode->i_ctime.tv_sec = mistat->mtime;
+
+	inode->i_uid = -1;
+	inode->i_gid = -1;
+
+	if (v9ses && v9ses->extended) {
+		/* TODO: string to uid mapping via user-space daemon */
+		inode->i_uid = mistat->n_uid;
+		inode->i_gid = mistat->n_gid;
+
+		if (mistat->n_uid == -1)
+			sscanf(mistat->uid, "%x", &inode->i_uid);
+
+		if (mistat->n_gid == -1)
+			sscanf(mistat->gid, "%x", &inode->i_gid);
+	}
+
+	if (inode->i_uid == -1)
+		inode->i_uid = v9ses->uid;
+	if (inode->i_gid == -1)
+		inode->i_gid = v9ses->gid;
+
+	inode->i_mode = p9mode2unixmode(v9ses, mistat->mode);
+	if ((S_ISBLK(inode->i_mode)) || (S_ISCHR(inode->i_mode))) {
+		char type = 0;
+		int major = -1;
+		int minor = -1;
+		sscanf(mistat->extension, "%c %u %u", &type, &major, &minor);
+		switch (type) {
+		case 'c':
+			inode->i_mode &= ~S_IFBLK;
+			inode->i_mode |= S_IFCHR;
+			break;
+		case 'b':
+			break;
+		default:
+			dprintk(DEBUG_ERROR, "Unknown special type %c (%s)\n",
+				type, mistat->extension);
+		};
+		inode->i_rdev = MKDEV(major, minor);
+	} else
+		inode->i_rdev = 0;
+
+	inode->i_size = mistat->length;
+
+	inode->i_blksize = sb->s_blocksize;
+	inode->i_blocks =
+	    (inode->i_size + inode->i_blksize - 1) >> sb->s_blocksize_bits;
+}
+
+/**
+ * v9fs_qid2ino - convert qid into inode number
+ * @qid: qid to hash
+ *
+ * BUG: potential for inode number collisions?
+ */
+
+ino_t v9fs_qid2ino(struct v9fs_qid *qid)
+{
+	ino_t i = 0;
+
+	if (sizeof(ino_t) == sizeof(qid->path))
+		memcpy(&i, &qid->path, sizeof(ino_t));
+	else {
+		/* there is no perfect solution for this case */
+		i = (ino_t) (qid->path ^ (qid->path >> 32));
+	}
+
+	return i;
+}
+
+/**
+ * v9fs_vfs_symlink - helper function to create symlinks
+ * @dir: directory inode containing symlink
+ * @dentry: dentry for symlink
+ * @symname: symlink data
+ * 
+ * See 9P2000.u RFC for more information
+ *
+ */
+
+static int
+v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	int retval = -EPERM;
+	struct v9fs_fid *newfid;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
+	struct super_block *sb = dir ? dir->i_sb : NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
+
+	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
+		symname);
+
+	if ((!dentry) || (!sb) || (!v9ses)) {
+		dprintk(DEBUG_ERROR, "problem with arguments\n");
+		return -EBADF;
+	}
+
+	if (!v9ses->extended) {
+		dprintk(DEBUG_ERROR, "not extended\n");
+		goto FreeFcall;
+	}
+
+	/* issue a create */
+	retval = v9fs_create(dir, dentry, S_IFLNK, 0);
+	if (retval != 0)
+		goto FreeFcall;
+
+	newfid = v9fs_fid_lookup(dentry, FID_OP);
+
+	/* issue a twstat */
+	v9fs_blank_mistat(v9ses, mistat);
+	strcpy(mistat->data + 1, symname);
+	mistat->extension = mistat->data + 1;
+	retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
+	if (retval < 0) {
+		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
+			FCALL_ERROR(fcall));
+		goto FreeFcall;
+	}
+
+	/* need to update dcache so we show up */
+	safe_cache_free(v9ses->slab, fcall);
+	fcall = NULL;
+
+	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
+			FCALL_ERROR(fcall));
+		goto FreeFcall;
+	}
+
+	d_drop(dentry);		/* FID - will this also clunk? */
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, mistat);
+	safe_cache_free(v9ses->slab, fcall);
+
+	return retval;
+}
+
+/**
+ * v9fs_readlink - read a symlink's location (internal version)
+ * @dentry: dentry for symlink
+ * @buf: buffer to load symlink location into
+ * @buflen: length of buffer
+ * 
+ */
+
+static int v9fs_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	int retval = -EPERM;
+
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+
+	if (!fid) {
+		dprintk(DEBUG_ERROR, "could not resolve fid from dentry\n");
+		retval = -EBADF;
+		goto FreeFcall;
+	}
+
+	if (!v9ses->extended) {
+		retval = -EBADF;
+		dprintk(DEBUG_ERROR, "not extended\n");
+		goto FreeFcall;
+	}
+
+	dprintk(DEBUG_VFS, " %s\n", dentry->d_name.name);
+	retval = v9fs_t_stat(v9ses, fid->fid, &fcall);
+
+	if (!(fcall->params.rstat.stat->mode & V9FS_DMSYMLINK)) {
+		retval = -EINVAL;
+		goto FreeFcall;
+	}
+
+	if (retval < 0) {
+		dprintk(DEBUG_ERROR, "stat error\n");
+		goto FreeFcall;
+	}
+
+	/* copy extension buffer into buffer */
+	if (strlen(fcall->params.rstat.stat->extension) < buflen)
+		buflen = strlen(fcall->params.rstat.stat->extension);
+
+	memcpy(buffer, fcall->params.rstat.stat->extension, buflen + 1);
+
+	retval = buflen;
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, fcall);
+
+	return retval;
+}
+
+/**
+ * v9fs_vfs_readlink - read a symlink's location
+ * @dentry: dentry for symlink
+ * @buf: buffer to load symlink location into
+ * @buflen: length of buffer
+ * 
+ */
+
+static int v9fs_vfs_readlink(struct dentry *dentry, char __user * buffer,
+			     int buflen)
+{
+	int retval;
+	int ret;
+	char *link = __getname();
+
+	if (strlen(link) < buflen)
+		buflen = strlen(link);
+
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+
+	retval = v9fs_readlink(dentry, link, buflen);
+
+	if (retval > 0) {
+		if ((ret = copy_to_user(buffer, link, retval)) != 0) {
+			dprintk(DEBUG_ERROR, "problem copying to user: %d\n", ret);
+			retval = ret;
+		}
+	}
+
+	putname(link);
+	return retval;
+}
+
+/**
+ * v9fs_vfs_follow_link - follow a symlink path
+ * @dentry: dentry for symlink
+ * @nd: nameidata
+ * 
+ */
+
+static int v9fs_vfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int len = 0;
+	char *link = __getname();
+
+	dprintk(DEBUG_VFS, "%s n", dentry->d_name.name);
+
+	if (!link)
+		link = ERR_PTR(-ENOMEM);
+	else {
+		len = v9fs_readlink(dentry, link, strlen(link));
+
+		if (len < 0) {
+			putname(link);
+			link = ERR_PTR(len);
+		} else
+			link[len] = 0;
+	}
+	nd_set_link(nd, link);
+
+	return 0;
+}
+
+/**
+ * v9fs_vfs_put_link - release a symlink path
+ * @dentry: dentry for symlink
+ * @nd: nameidata
+ * 
+ */
+
+static void v9fs_vfs_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+
+	dprintk(DEBUG_VFS, " %s %s\n", dentry->d_name.name, s);
+	if (!IS_ERR(s))
+		putname(s);
+}
+
+/**
+ * v9fs_vfs_link - create a hardlink
+ * @old_dentry: dentry for file to link to
+ * @dir: inode destination for new link
+ * @new_dentry: dentry for link
+ * 
+ */
+
+/* XXX - lots of code dup'd from symlink and creates, 
+ * figure out a better reuse strategy 
+ */
+
+static int
+v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
+	      struct dentry *dentry)
+{
+	int retval = -EPERM;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
+	struct super_block *sb = dir ? dir->i_sb : NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
+	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_OP);
+	struct v9fs_fid *newfid = NULL;
+	char symname[255];	/* just going to store hardlinkfid(%x) */
+
+	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
+		old_dentry->d_name.name);
+
+	if ((!dentry) || (!sb) || (!v9ses) || (!oldfid)) {
+		dprintk(DEBUG_ERROR, "problem with arguments\n");
+		return -EBADF;
+	}
+
+	if (!v9ses->extended) {
+		dprintk(DEBUG_ERROR, "not extended\n");
+		goto FreeFcall;
+	}
+
+	/* get fid of old_dentry */
+	sprintf(symname, "hardlink(%d)\n", oldfid->fid);
+
+	/* issue a create */
+	retval = v9fs_create(dir, dentry, V9FS_DMLINK, 0);
+	if (retval != 0)
+		goto FreeFcall;
+
+	newfid = v9fs_fid_lookup(dentry, FID_OP);
+	if (!newfid) {
+		dprintk(DEBUG_ERROR, "couldn't resolve fid from dentry\n");
+		goto FreeFcall;
+	}
+
+	/* issue a twstat */
+	v9fs_blank_mistat(v9ses, mistat);
+	strcpy(mistat->data + 1, symname);
+	mistat->extension = mistat->data + 1;
+	retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
+	if (retval < 0) {
+		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
+			FCALL_ERROR(fcall));
+		goto FreeFcall;
+	}
+
+	/* need to update dcache so we show up */
+	safe_cache_free(v9ses->slab, fcall);
+	fcall = NULL;
+
+	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
+			FCALL_ERROR(fcall));
+		goto FreeFcall;
+	}
+
+	d_drop(dentry);		/* FID - will this also clunk? */
+
+	safe_cache_free(v9ses->slab, fcall);
+	fcall = NULL;
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, mistat);
+	safe_cache_free(v9ses->slab, fcall);
+
+	return retval;
+}
+
+/**
+ * v9fs_vfs_mknod - create a special file
+ * @dir: inode destination for new link
+ * @dentry: dentry for file
+ * @mode: mode for creation
+ * @dev_t: device associated with special file
+ * 
+ */
+
+static int
+v9fs_vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
+{
+	int retval = -EPERM;
+	struct v9fs_fid *newfid;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
+	struct super_block *sb = dir ? dir->i_sb : NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_stat *mistat = kmem_cache_alloc(v9ses->slab, GFP_KERNEL);
+	char symname[255];
+
+	dprintk(DEBUG_VFS, " %lu,%s mode: %x MAJOR: %u MINOR: %u\n", dir->i_ino,
+		dentry->d_name.name, mode, MAJOR(rdev), MINOR(rdev));
+
+	if (!new_valid_dev(rdev))
+		return -EINVAL;
+
+	if ((!dentry) || (!sb) || (!v9ses)) {
+		dprintk(DEBUG_ERROR, "problem with arguments\n");
+		return -EBADF;
+	}
+
+	if (!v9ses->extended) {
+		dprintk(DEBUG_ERROR, "not extended\n");
+		goto FreeFcall;
+	}
+
+	/* issue a create */
+	retval = v9fs_create(dir, dentry, mode, 0);
+
+	if (retval != 0)
+		goto FreeFcall;
+
+	newfid = v9fs_fid_lookup(dentry, FID_OP);
+	if (!newfid) {
+		dprintk(DEBUG_ERROR, "coudn't resove fid from dentry\n");
+		retval = -EINVAL;
+		goto FreeFcall;
+	}
+
+	/* build extension */
+	if (S_ISBLK(mode))
+		sprintf(symname, "b %u %u", MAJOR(rdev), MINOR(rdev));
+	else if (S_ISCHR(mode))
+		sprintf(symname, "c %u %u", MAJOR(rdev), MINOR(rdev));
+	else if (S_ISFIFO(mode)) ;	/* DO NOTHING */
+	else {
+		retval = -EINVAL;
+		goto FreeFcall;
+	}
+
+	if (!S_ISFIFO(mode)) {
+		/* issue a twstat */
+		v9fs_blank_mistat(v9ses, mistat);
+		strcpy(mistat->data + 1, symname);
+		mistat->extension = mistat->data + 1;
+		retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
+		if (retval < 0) {
+			dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
+				FCALL_ERROR(fcall));
+			goto FreeFcall;
+		}
+
+		safe_cache_free(v9ses->slab, fcall);
+	}
+
+	/* need to update dcache so we show up */
+	safe_cache_free(v9ses->slab, fcall);
+
+	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
+			FCALL_ERROR(fcall));
+		goto FreeFcall;
+	}
+
+	d_drop(dentry);		/* FID - will this also clunk? */
+
+      FreeFcall:
+	safe_cache_free(v9ses->slab, mistat);
+	safe_cache_free(v9ses->slab, fcall);
+
+	return retval;
+}
+
+static struct inode_operations v9fs_dir_inode_operations = {
+	.create = v9fs_vfs_create,
+	.lookup = v9fs_vfs_lookup,
+	.symlink = v9fs_vfs_symlink,
+	.link = v9fs_vfs_link,
+	.unlink = v9fs_vfs_unlink,
+	.mkdir = v9fs_vfs_mkdir,
+	.rmdir = v9fs_vfs_rmdir,
+	.mknod = v9fs_vfs_mknod,
+	.rename = v9fs_vfs_rename,
+	.readlink = v9fs_vfs_readlink,
+	.getattr = v9fs_vfs_getattr,
+	.setattr = v9fs_vfs_setattr,
+};
+
+static struct inode_operations v9fs_file_inode_operations = {
+	.getattr = v9fs_vfs_getattr,
+	.setattr = v9fs_vfs_setattr,
+};
+
+static struct inode_operations v9fs_symlink_inode_operations = {
+	.readlink = v9fs_vfs_readlink,
+	.follow_link = v9fs_vfs_follow_link,
+	.put_link = v9fs_vfs_put_link,
+	.getattr = v9fs_vfs_getattr,
+	.setattr = v9fs_vfs_setattr,
+};

