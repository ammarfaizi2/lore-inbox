Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWEMDpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWEMDpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWEMDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:45:46 -0400
Received: from c-67-177-57-20.hsd1.co.comcast.net ([67.177.57.20]:28916 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932273AbWEMDpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:45:45 -0400
Date: Fri, 12 May 2006 21:45:46 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 8/13: eCryptfs] File operations
Message-ID: <20060513034546.GH18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 8th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

eCryptfs file operations. Includes code to read header information
from the underyling file when needed.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 file.c |  620 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 620 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/file.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/file.c	2006-05-12 20:00:27.000000000 -0600
@@ -0,0 +1,620 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (C) 1997-2004 Erez Zadok
+ * Copyright (C) 2001-2004 Stony Brook University
+ * Copyright (C) 2004-2006 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
+ *   		Michael C. Thompson <mcthomps@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/security.h>
+#include <linux/smp_lock.h>
+#include <linux/compat.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * ecryptfs_llseek
+ * @file: File we are seeking in
+ * @offset: The offset to seek to
+ * @origin: 2 - offset from i_size; 1 - offset from f_pos
+ * 
+ * Returns the position we have seeked to, or negative on error
+ */
+static loff_t ecryptfs_llseek(struct file *file, loff_t offset, int origin)
+{
+	loff_t rv;
+	loff_t new_end_pos;
+	int rc;
+	int expanding_file = 0;
+	struct inode *inode = file->f_mapping->host;
+
+	/* If our offset is past the end of our file, we're going to
+	 * need to grow it so we have a valid length of 0's */
+	new_end_pos = offset;
+	switch (origin) {
+	case 2:
+		new_end_pos += i_size_read(inode);
+		expanding_file = 1;
+		break;
+	case 1:
+		new_end_pos += file->f_pos;
+		if (new_end_pos > i_size_read(inode)) {
+			ecryptfs_printk(KERN_DEBUG, "new_end_pos(=[0x%.16x]) "
+					"> i_size_read(inode)(=[0x%.16x])\n",
+					new_end_pos, i_size_read(inode));
+			expanding_file = 1;
+		}
+		break;
+	default:
+		if (new_end_pos > i_size_read(inode)) {
+			ecryptfs_printk(KERN_DEBUG, "new_end_pos(=[0x%.16x]) "
+					"> i_size_read(inode)(=[0x%.16x])\n",
+					new_end_pos, i_size_read(inode));
+			expanding_file = 1;
+		}
+	}
+	ecryptfs_printk(KERN_DEBUG, "new_end_pos = [0x%.16x]\n", new_end_pos);
+	if (expanding_file) {
+		rc = ecryptfs_truncate(file->f_dentry, new_end_pos);
+		if (rc) {
+			rv = rc;
+			ecryptfs_printk(KERN_ERR, "Error on attempt to "
+					"truncate to (higher) offset [0x%.16x];"
+					" rc = [%d]\n", rc, new_end_pos);
+			goto out;
+		}
+	}
+	rv = generic_file_llseek(file, offset, origin);
+out:
+	return rv;
+}
+
+/**
+ * ecryptfs_read_update_atime
+ *
+ * generic_file_read updates the atime of upper layer inode.  But, it
+ * doesn't give us a chance to update the atime of the lower layer
+ * inode.  This function is a wrapper to generic_file_read.  It
+ * updates the atime of the lower level inode if generic_file_read
+ * returns without any errors. This is to be used only for file reads.
+ * The function to be used for directory reads is ecryptfs_read.
+ */
+static ssize_t ecryptfs_read_update_atime(struct file *file, char __user * buf,
+					  size_t count, loff_t * ppos)
+{
+	int rc;
+	struct dentry *lower_dentry;
+	struct vfsmount *lower_vfsmount;
+
+	rc = generic_file_read(file, buf, count, ppos);
+	if (rc >= 0) {
+		lower_dentry = ecryptfs_dentry_to_lower(file->f_dentry);
+		lower_vfsmount = ecryptfs_superblock_to_private(
+			file->f_dentry->d_inode->i_sb)->lower_mnt;
+		touch_atime(lower_vfsmount, lower_dentry);
+	}
+	return rc;
+}
+
+struct ecryptfs_getdents_callback {
+	void *dirent;
+	struct dentry *dentry;
+	filldir_t filldir;
+	int err;
+	int filldir_called;
+	int entries_written;
+};
+
+/* Inspired by generic filldir in fs/readir.c */
+static int
+ecryptfs_filldir(void *dirent, const char *name, int namelen, loff_t offset,
+		 ino_t ino, unsigned int d_type)
+{
+	struct ecryptfs_crypt_stat *crypt_stat;
+	struct ecryptfs_getdents_callback *buf =
+	    (struct ecryptfs_getdents_callback *)dirent;
+	int rc;
+	int decoded_length;
+	char *decoded_name;
+
+
+	crypt_stat = ecryptfs_dentry_to_private(buf->dentry)->crypt_stat;
+	buf->filldir_called++;
+	decoded_length = ecryptfs_decode_filename(crypt_stat, name, namelen,
+						  &decoded_name);
+	if (decoded_length < 0) {
+		rc = decoded_length;
+		goto out;
+	}
+	rc = buf->filldir(buf->dirent, decoded_name, decoded_length, offset,
+			  ino, d_type);
+	kfree(decoded_name);
+	if (rc >= 0)
+		buf->entries_written++;
+out:
+	return rc;
+}
+
+/**
+ * ecryptfs_readdir
+ * @file: The ecryptfs file struct
+ * @dirent: Directory entry
+ * @filldir: The filldir callback function
+ */
+static int ecryptfs_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	int rc;
+	struct file *lower_file;
+	struct inode *inode;
+	struct ecryptfs_getdents_callback buf;
+
+	lower_file = ecryptfs_file_to_lower(file);
+	inode = file->f_dentry->d_inode;
+	memset(&buf, 0, sizeof(buf));
+	buf.dirent = dirent;
+	buf.dentry = file->f_dentry;
+	buf.filldir = filldir;
+retry:
+	buf.filldir_called = 0;
+	buf.entries_written = 0;
+	buf.err = 0;
+	rc = vfs_readdir(lower_file, ecryptfs_filldir, (void *)&buf);
+	if (buf.err)
+		rc = buf.err;
+	if (buf.filldir_called && !buf.entries_written)
+		goto retry;
+	file->f_pos = lower_file->f_pos;
+	if (rc >= 0)
+		ecryptfs_copy_attr_atime(inode, lower_file->f_dentry->d_inode);
+	return rc;
+}
+
+/**
+ * read_inode_size_from_header
+ * @lower_file: The lower file struct
+ * @lower_inode: The lower inode
+ * @inode: The ecryptfs inode
+ * 
+ * Returns zero on success; non-zero otherwise
+ */
+static int
+read_inode_size_from_header(struct file *lower_file,
+			    struct inode *lower_inode, struct inode *inode)
+{
+	int rc;
+	struct page *header_page;
+	unsigned char *header_virt;
+	u64 data_size;
+
+	header_page = grab_cache_page(lower_inode->i_mapping, 0);
+	if (!header_page) {
+		rc = -EINVAL;
+		ecryptfs_printk(KERN_ERR, "grab_cache_page for header page "
+				"failed\n");
+		goto out;
+	}
+	header_virt = kmap(header_page);
+	rc = lower_inode->i_mapping->a_ops->readpage(lower_file, header_page);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error reading header page\n");
+		goto out_unmap;
+	}
+	memcpy(&data_size, header_virt, sizeof(data_size));
+	data_size = be64_to_cpu(data_size);
+	i_size_write(inode, (loff_t)data_size);
+	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
+			"size: [0x%.16x]\n", inode, inode->i_ino,
+			i_size_read(inode));
+out_unmap:
+	kunmap(header_page);
+	page_cache_release(header_page);
+out:
+	return rc;
+}
+
+struct kmem_cache *ecryptfs_file_info_cache;
+
+/**
+ * ecryptfs_open
+ * @inode: inode speciying file to open
+ * @file: Structure to return filled in
+ *
+ * Opens the file specified by inode.
+ * 
+ * Returns zero on success; non-zero otherwise
+ */
+static int ecryptfs_open(struct inode *inode, struct file *file)
+{
+	int rc = 0;
+	struct ecryptfs_crypt_stat *crypt_stat = NULL;
+	struct dentry *ecryptfs_dentry = file->f_dentry;
+	/* Private value of ecryptfs_dentry allocated in
+	 * ecryptfs_lookup() */
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	struct inode *lower_inode = NULL;
+	struct file *lower_file = NULL;
+	struct vfsmount *lower_mnt;
+	int lower_flags;
+
+	/* Released in ecryptfs_release or end of function if failure */
+	ecryptfs_set_file_private(file,
+				  kmem_cache_alloc(ecryptfs_file_info_cache,
+						   SLAB_KERNEL));
+	if (!ecryptfs_file_to_private(file)) {
+		ecryptfs_printk(KERN_ERR,
+				"Error attempting to allocate memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED)) {
+		ecryptfs_printk(KERN_DEBUG, "Setting flags for stat...\n");
+		/* Policy code enabled in future release */
+		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED);
+		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+	}
+	/* This mntget & dget is undone via fput when the file is released */
+	dget(lower_dentry);
+	lower_flags = file->f_flags;
+	if ((lower_flags & O_ACCMODE) == O_WRONLY)
+		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
+	if (file->f_flags & O_APPEND)
+		lower_flags &= ~O_APPEND;
+	lower_mnt = ecryptfs_superblock_to_private(inode->i_sb)->lower_mnt;
+	mntget(lower_mnt);
+	/* Corresponding fput() in ecryptfs_release() */
+	lower_file = dentry_open(lower_dentry, lower_mnt, lower_flags);
+	if (IS_ERR(lower_file)) {
+		rc = PTR_ERR(lower_file);
+		ecryptfs_printk(KERN_ERR, "Error opening lower file\n");
+		goto out_puts;
+	}
+	ecryptfs_set_file_lower(file, lower_file);
+	/* Isn't this check the same as the one in lookup? */
+	lower_inode = lower_dentry->d_inode;
+	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
+		ecryptfs_printk(KERN_DEBUG, "This is a directory\n");
+		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+		rc = 0;
+		goto out;
+	}
+	if (i_size_read(lower_inode) == 0) {
+		ecryptfs_printk(KERN_EMERG, "Zero-length lower file; "
+				"ecryptfs_create() had a problem?\n");
+		rc = -ENOENT;
+		goto out_puts;
+	} else if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
+					ECRYPTFS_POLICY_APPLIED)
+		   || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
+					   ECRYPTFS_KEY_VALID)) {
+		rc = ecryptfs_read_headers(ecryptfs_dentry, lower_file);
+		if (rc) {
+			ecryptfs_printk(KERN_DEBUG,
+					"Valid headers not found\n");
+			ECRYPTFS_CLEAR_FLAG(crypt_stat->flags,
+					    ECRYPTFS_ENCRYPTED);
+			/* At this point, we could just move on and
+			 * have the encrypted data passed through
+			 * as-is to userspace. For release 0.1, we are
+			 * going to default to -EIO. */
+			rc = -EIO;
+			goto out_puts;
+		} else
+			read_inode_size_from_header(lower_file, lower_inode,
+						    inode);
+	}
+	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
+			"size: [0x%.16x]\n", inode, inode->i_ino,
+			i_size_read(inode));
+	ecryptfs_set_file_lower(file, lower_file);
+	goto out;
+out_puts:
+	mntput(lower_mnt);
+	dput(lower_dentry);
+	kmem_cache_free(ecryptfs_file_info_cache,
+			ecryptfs_file_to_private(file));
+out:
+	return rc;
+}
+
+static int ecryptfs_flush(struct file *file, fl_owner_t td)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+
+	lower_file = ecryptfs_file_to_lower(file);
+	if (lower_file->f_op && lower_file->f_op->flush)
+		rc = lower_file->f_op->flush(lower_file, td);
+	return rc;
+}
+
+static int ecryptfs_release(struct inode *ecryptfs_inode, struct file *file)
+{
+	struct file *lower_file;
+	struct ecryptfs_file_info *file_info;
+	struct inode *lower_inode;
+
+	file_info = ecryptfs_file_to_private(file);
+	kmem_cache_free(ecryptfs_file_info_cache, file_info);
+	lower_file = ecryptfs_file_to_lower(file);
+	fput(lower_file);
+	lower_inode = ecryptfs_inode_to_lower(ecryptfs_inode);
+	ecryptfs_inode->i_blocks = lower_inode->i_blocks;
+	return 0;
+}
+
+static int
+ecryptfs_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	int rc = -EINVAL;
+	struct file *lower_file = NULL;
+	struct dentry *lower_dentry;
+
+	if (NULL == file) {
+		lower_dentry = ecryptfs_dentry_to_lower(dentry);
+		if (lower_dentry->d_inode->i_fop
+		    && lower_dentry->d_inode->i_fop->fsync) {
+			mutex_lock(&lower_dentry->d_inode->i_mutex);
+			rc = lower_dentry->d_inode->i_fop->fsync(lower_file,
+								 lower_dentry,
+								 datasync);
+			mutex_unlock(&lower_dentry->d_inode->i_mutex);
+		}
+	} else {
+		if (!ecryptfs_file_to_private(file)) {
+			rc = -EINVAL;
+			ecryptfs_printk(KERN_ERR, "ecryptfs_file_to_private"
+					"(file=[%p]) is NULL\n", file);
+			goto out;
+		}
+		lower_file = ecryptfs_file_to_lower(file);
+		lower_dentry = ecryptfs_dentry_to_lower(dentry);
+		if (lower_file->f_op && lower_file->f_op->fsync) {
+			mutex_lock(&lower_dentry->d_inode->i_mutex);
+			rc = lower_file->f_op->fsync(lower_file, lower_dentry,
+						     datasync);
+			mutex_unlock(&lower_dentry->d_inode->i_mutex);
+		}
+	}
+out:
+	return rc;
+}
+
+static void locks_delete_block(struct file_lock *waiter)
+{
+	lock_kernel();
+	list_del_init(&waiter->fl_block);
+	list_del_init(&waiter->fl_link);
+	waiter->fl_next = NULL;
+	unlock_kernel();
+}
+
+static int ecryptfs_posix_lock(struct file *file, struct file_lock *fl, int cmd)
+{
+	int rc;
+
+lock_file:
+	rc = posix_lock_file(file, fl);
+	if ((rc != -EAGAIN) || (cmd == F_SETLK))
+		goto out;
+	rc = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+	if (!rc)
+		goto lock_file;
+	locks_delete_block(fl);
+out:
+	return rc;
+}
+
+static int ecryptfs_setlk(struct file *file, int cmd, struct file_lock *fl)
+{
+	int rc = -EINVAL;
+	struct inode *inode, *lower_inode;
+	struct file *lower_file = NULL;
+
+	lower_file = ecryptfs_file_to_lower(file);
+	inode = file->f_dentry->d_inode;
+	lower_inode = lower_file->f_dentry->d_inode;
+	/* Don't allow mandatory locks on files that may be memory mapped
+	 * and shared. */
+	if (IS_MANDLOCK(lower_inode) &&
+	    (lower_inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
+	    mapping_writably_mapped(lower_file->f_mapping)) {
+		rc = -EAGAIN;
+		goto out;
+	}
+	if (cmd == F_SETLKW)
+		fl->fl_flags |= FL_SLEEP;
+	rc = -EBADF;
+	switch (fl->fl_type) {
+	case F_RDLCK:
+		if (!(lower_file->f_mode & FMODE_READ))
+			goto out;
+		break;
+	case F_WRLCK:
+		if (!(lower_file->f_mode & FMODE_WRITE))
+			goto out;
+		break;
+	case F_UNLCK:
+		break;
+	default:
+		rc = -EINVAL;
+		goto out;
+	}
+	fl->fl_file = lower_file;
+	rc = security_file_lock(lower_file, fl->fl_type);
+	if (rc)
+		goto out;
+	if (lower_file->f_op && lower_file->f_op->lock) {
+		rc = lower_file->f_op->lock(lower_file, cmd, fl);
+		if (rc)
+			goto out;
+		goto upper_lock;
+	}
+	rc = ecryptfs_posix_lock(lower_file, fl, cmd);
+	if (rc)
+		goto out;
+upper_lock:
+	fl->fl_file = file;
+	rc = ecryptfs_posix_lock(file, fl, cmd);
+	if (rc) {
+		fl->fl_type = F_UNLCK;
+		fl->fl_file = lower_file;
+		ecryptfs_posix_lock(lower_file, fl, cmd);
+	}
+out:
+	return rc;
+}
+
+static int ecryptfs_getlk(struct file *file, struct file_lock *fl)
+{
+	struct file_lock cfl;
+	struct file_lock *tempfl = NULL;
+	int rc = 0;
+
+	if (file->f_op && file->f_op->lock) {
+		rc = file->f_op->lock(file, F_GETLK, fl);
+		if (rc < 0)
+			goto out;
+	} else
+		tempfl = (posix_test_lock(file, fl, &cfl) ? &cfl : NULL);
+	if (!tempfl)
+		fl->fl_type = F_UNLCK;
+	else
+		memcpy(fl, tempfl, sizeof(struct file_lock));
+out:
+	return rc;
+}
+
+static int ecryptfs_fasync(int fd, struct file *file, int flag)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+
+	if (NULL != ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+	else {
+		rc = -EINVAL;
+		goto out;
+	}
+	if (lower_file->f_op && lower_file->f_op->fasync)
+		rc = lower_file->f_op->fasync(fd, lower_file, flag);
+out:
+	return rc;
+}
+
+static int ecryptfs_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+
+	if (ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+	ASSERT(lower_file);
+	rc = -EINVAL;
+	if (!fl)
+		goto out;
+	fl->fl_file = lower_file;
+	switch (cmd) {
+	case F_GETLK:
+	case F_GETLK64:
+		rc = ecryptfs_getlk(lower_file, fl);
+		break;
+	case F_SETLK:
+	case F_SETLKW:
+	case F_SETLK64:
+	case F_SETLKW64:
+		fl->fl_file = file;
+		rc = ecryptfs_setlk(file, cmd, fl);
+		break;
+	default:
+		rc = -EINVAL;
+	}
+	fl->fl_file = file;
+out:
+	return rc;
+}
+
+static ssize_t ecryptfs_sendfile(struct file *file, loff_t * ppos,
+				 size_t count, read_actor_t actor, void *target)
+{
+	struct file *lower_file = NULL;
+	int rc = -EINVAL;
+
+	if (ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+	ASSERT(lower_file);
+	if (lower_file->f_op && lower_file->f_op->sendfile)
+		rc = lower_file->f_op->sendfile(lower_file, ppos, count,
+						actor, target);
+
+	return rc;
+}
+
+static int ecryptfs_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, unsigned long arg);
+
+const struct file_operations ecryptfs_dir_fops = {
+	.readdir = ecryptfs_readdir,
+	.ioctl = ecryptfs_ioctl,
+	.mmap = generic_file_mmap,
+	.open = ecryptfs_open,
+	.flush = ecryptfs_flush,
+	.release = ecryptfs_release,
+	.fsync = ecryptfs_fsync,
+	.fasync = ecryptfs_fasync,
+	.lock = ecryptfs_lock,
+	.sendfile = ecryptfs_sendfile,
+};
+
+const struct file_operations ecryptfs_main_fops = {
+	.llseek = ecryptfs_llseek,
+	.read = ecryptfs_read_update_atime,
+	.write = generic_file_write,
+	.readdir = ecryptfs_readdir,
+	.ioctl = ecryptfs_ioctl,
+	.mmap = generic_file_mmap,
+	.open = ecryptfs_open,
+	.flush = ecryptfs_flush,
+	.release = ecryptfs_release,
+	.fsync = ecryptfs_fsync,
+	.fasync = ecryptfs_fasync,
+	.lock = ecryptfs_lock,
+	.sendfile = ecryptfs_sendfile,
+};
+
+static int
+ecryptfs_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	       unsigned long arg)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	if (ecryptfs_file_to_private(file))
+		lower_file = ecryptfs_file_to_lower(file);
+	if (lower_file && lower_file->f_op && lower_file->f_op->ioctl)
+		rc = lower_file->f_op->ioctl(ecryptfs_inode_to_lower(inode),
+					     lower_file, cmd, arg);
+	else
+		rc = -ENOTTY;
+	return rc;
+}
