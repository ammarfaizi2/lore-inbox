Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVKCDvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVKCDvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVKCDvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:51:51 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:39918
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030327AbVKCDvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:51:48 -0500
Date: Wed, 2 Nov 2005 20:52:10 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 7/12: eCryptfs] File operations
Message-ID: <20051103035210.GG3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs file operations. Includes code to read header information
from the underyling file when needed.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 file.c |  708 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 708 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/file.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/file.c	2005-11-01 14:40:10.000000000 -0600
@@ -0,0 +1,708 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2004 Erez Zadok
+ * Copyright (c) 2001-2004 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
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
+#ifdef HAVE_CONFIG_H
+# include <config.h>
+#endif				/* HAVE_CONFIG_H */
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/security.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * @param file		File we are seeking in
+ * @param offset	The offset to seek to
+ * @param origin	Where to start seek from
+ * 			(0=beginning,1=cur pos,2=end of file)
+ * @return		The position we have seeked to, or negative on error
+ */
+static loff_t ecryptfs_llseek(struct file *file, loff_t offset, int origin)
+{
+	loff_t ret;
+	int rc;
+	struct file *lower_file = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; offset = [%lld] origin = [%d]",
+			"\n", offset, origin);
+	if (NULL != FILE_TO_PRIVATE(file)) {
+		lower_file = FILE_TO_LOWER(file);
+	}
+	/* Intent: If our offset is past the end of our file, we're going to
+	 * need to grow it so we have a valid length of 0s
+	 */
+	if (offset > i_size_read(file->f_dentry->d_inode)) {
+		rc = ecryptfs_truncate(file->f_dentry, offset);
+		if (rc) {
+			ret = rc;
+			goto out;
+		}
+	}
+	ret = generic_file_llseek(file, offset, origin);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; ret = [%lld]\n", ret);
+	return ret;
+}
+
+/**
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
+	int err = 0;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	err = generic_file_read(file, buf, count, ppos);
+	if (err >= 0)
+		update_atime(INODE_TO_LOWER(file->f_dentry->d_inode));
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return err;
+}
+
+static ssize_t
+ecryptfs_read(struct file *file, char __user * buf, size_t count, loff_t * ppos)
+{
+	int rc = -EINVAL;
+	struct file *lower_file = NULL;
+	loff_t pos = *ppos;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; file = [%p]\n", file);
+	ASSERT(lower_file = FILE_TO_LOWER(file));
+	if (!lower_file->f_op || !lower_file->f_op->read)
+		goto out;
+	rc = lower_file->f_op->read(lower_file, buf, count, &pos);
+	if (rc >= 0) {
+		/* atime should also be updated for reads of size zero
+		 * or more */
+		ecryptfs_copy_attr_atime(file->f_dentry->d_inode,
+					 lower_file->f_dentry->d_inode);
+	}
+	lower_file->f_pos = *ppos = pos;
+	memcpy(&(file->f_ra), &(lower_file->f_ra),
+	       sizeof(struct file_ra_state));
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Directory write operation.
+ *
+ * TODO: Encrypt the directory pages also if policy calls for it
+ */
+static ssize_t ecryptfs_dir_write(struct file *file, const char __user * buf,
+				  size_t count, loff_t * ppos)
+{
+	int rc = -EINVAL;
+	struct file *lower_file = NULL;
+	struct inode *inode;
+	struct inode *lower_inode;
+	loff_t pos = *ppos;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; file = [%p]\n", file);
+	ASSERT(lower_file = FILE_TO_LOWER(file));
+	inode = file->f_dentry->d_inode;
+	lower_inode = INODE_TO_LOWER(inode);
+	if (!lower_file->f_op || !lower_file->f_op->write)
+		goto out;
+	/* adjust for append -- seek to the end of the file */
+	if ((file->f_flags & O_APPEND) && (count != 0))
+		pos = i_size_read(inode);
+	if (count != 0)
+		rc = lower_file->f_op->write(lower_file, buf, count, &pos);
+	else
+		rc = 0;
+	/* copy ctime and mtime from lower layer attributes
+	 * atime is unchanged for both layers
+	 */
+	if (rc >= 0)
+		ecryptfs_copy_attr_times(inode, lower_inode);
+	/* because pwrite() does not have any way to tell us that it
+	 * is our caller, then we don't know for sure if we have to
+	 * update the file positions.  This hack relies on write()
+	 * having passed us the "real" pointer of its struct file's
+	 * f_pos field. */
+	lower_file->f_pos = *ppos = pos;
+	/* update this inode's size */
+	if (pos > i_size_read(inode))
+		i_size_write(inode, pos);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
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
+/* copied from generic filldir in fs/readir.c */
+static int
+ecryptfs_filldir(void *dirent, const char *name, int namelen, loff_t offset,
+		 ino_t ino, unsigned int d_type)
+{
+	struct ecryptfs_crypt_stats *crypt_stats;
+	struct ecryptfs_getdents_callback *buf =
+	    (struct ecryptfs_getdents_callback *)dirent;
+	int rc;
+	char *decoded_name;
+	int decoded_length;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter w/ name = [%.*s]\n", namelen,
+			name);
+	/* Get the crypto stats for this file */
+	/* TODO: If filldir oopses, look here ... */
+	crypt_stats = DENTRY_TO_PRIVATE(buf->dentry)->crypt_stats;
+	buf->filldir_called++;
+	/* TODO: Halcrow: Check the headers of the file to determine
+	 * if the filename needs decryption (or hiding, or
+	 * obfuscation, etc.) */
+	decoded_length = ecryptfs_decode_filename(name, namelen, &decoded_name,
+						  ECRYPTFS_SKIP_DOTS,
+						  crypt_stats);
+	if (decoded_length < 0)
+		return 0;
+	rc = buf->filldir(buf->dirent, decoded_name, decoded_length, offset,
+			  ino, d_type);
+	ecryptfs_kfree(decoded_name);
+	if (rc >= 0)
+		buf->entries_written++;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * @param file The ecryptfs file struct
+ * @param filldir The filldir callback function
+ */
+static int ecryptfs_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	int rc = -ENOTDIR;
+	struct file *lower_file = NULL;
+	struct inode *inode;
+	struct ecryptfs_getdents_callback buf;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; file = [%p]\n", file);
+	ASSERT(lower_file = FILE_TO_LOWER(file));
+	inode = file->f_dentry->d_inode;
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
+	if (buf.filldir_called && !buf.entries_written) {
+		goto retry;
+	}
+	file->f_pos = lower_file->f_pos;
+	if (rc >= 0)
+		ecryptfs_copy_attr_atime(inode, lower_file->f_dentry->d_inode);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static unsigned int ecryptfs_poll(struct file *file, poll_table * wait)
+{
+	unsigned int mask = DEFAULT_POLLMASK;
+	struct file *lower_file = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; file = [%p]\n", file);
+	ASSERT(lower_file = FILE_TO_LOWER(file));
+	if (!lower_file->f_op || !lower_file->f_op->poll)
+		goto out;
+	mask = lower_file->f_op->poll(lower_file, wait);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; mask = [%x]\n", mask);
+	return mask;
+}
+
+/**
+ * @return Zero on success; non-zero otherwise
+ */
+static int
+read_inode_size_from_header(struct file *lower_file,
+			    struct inode *lower_inode, struct inode *inode)
+{
+	int rc = 0;
+	struct page *header_page;
+	unsigned char *header_virt;
+	u64 data_size;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter w/ lower_inode = [%p]; inode = "
+			"[%p]\n", lower_inode, inode);
+	header_page = grab_cache_page(lower_inode->i_mapping, 0);
+	if (!header_page) {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "grab_cache_page for header page "
+				"failed\n");
+		goto out;
+	}
+	header_virt = kmap(header_page);
+	rc = lower_inode->i_mapping->a_ops->readpage(lower_file, header_page);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error reading header page\n");
+		goto out_unmap;
+	}
+	memcpy(&data_size, header_virt, sizeof(data_size));
+	i_size_write(inode, (loff_t) data_size);
+	ecryptfs_printk(1, KERN_NOTICE, "Read inode size from header: [%llu]\n",
+			i_size_read(inode));
+out_unmap:
+	kunmap(header_page);
+	page_cache_release(header_page);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+kmem_cache_t *ecryptfs_file_info_cache;
+
+/**
+ * Opens the file specified by inode.
+ *
+ * @param inode	inode speciying file to open
+ * @param file	Structure to return filled in
+ * @return Zero on success; non-zero otherwise
+ */
+static int ecryptfs_open(struct inode *inode, struct file *file)
+{
+	int rc = 0;
+	struct ecryptfs_crypt_stats *crypt_stats = NULL;
+	struct dentry *ecryptfs_dentry = file->f_dentry;
+	struct dentry *lower_dentry = DENTRY_TO_LOWER(ecryptfs_dentry);
+	struct inode *lower_inode = NULL;
+	struct file *lower_file = NULL;
+	struct vfsmount *lower_mnt;
+	int lower_flags;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; i_ino = [%lu] inode = [%p] "
+			"inode->i_size = [%lld] inode->i_count = [%d] file->"
+			"f_dentry = [%p] file->f_dentry->d_name.name = [%s] "
+			"file->f_dentry->d_name.len = [%d]\n", inode->i_ino,
+			inode, atomic_read(&inode->i_count), i_size_read(inode),
+			ecryptfs_dentry, ecryptfs_dentry->d_name.name,
+			ecryptfs_dentry->d_name.len);
+
+	/* DENTRY_TO_PRIVATE(ecryptfs_dentry) Allocated in
+	 * ecryptfs_lookup() */
+	ASSERT(DENTRY_TO_PRIVATE(ecryptfs_dentry));
+	/* Released in ecryptfs_release or end of function if failure */
+	FILE_TO_PRIVATE_SM(file) =
+	    ecryptfs_kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	if (!FILE_TO_PRIVATE_SM(file)) {
+		ecryptfs_printk(0, KERN_ERR,
+				"Error attempting to allocate memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_dentry = DENTRY_TO_LOWER(ecryptfs_dentry);
+	ASSERT(lower_dentry);
+	crypt_stats = &(INODE_TO_PRIVATE(inode)->crypt_stats);
+	if (!crypt_stats->policy_applied) {
+		ecryptfs_printk(1, KERN_NOTICE, "Setting flags for stats...\n");
+		/* Policy code enabled in future release */
+		crypt_stats->policy_applied = 1;
+		crypt_stats->encrypted = 1;
+	}
+	/* This mntget & dget is undone via fput when the file is released */
+	ecryptfs_dget(lower_dentry);
+	lower_flags = file->f_flags;
+	if ((lower_flags & O_ACCMODE) == O_WRONLY)
+		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
+	if (file->f_flags & O_APPEND)
+		lower_flags &= ~O_APPEND;
+	lower_mnt = SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
+	mntget(lower_mnt);
+	/* Corresponding fput() in ecryptfs_release() */
+	lower_file = ecryptfs_dentry_open(lower_dentry, lower_mnt, lower_flags);
+	if (IS_ERR(lower_file)) {
+		rc = PTR_ERR(lower_file);
+		ecryptfs_printk(0, KERN_ERR, "Error opening lower file\n");
+		goto out_puts;
+	}
+	FILE_TO_LOWER(file) = lower_file;
+	/* Isn't this check the same as the one in lookup? */
+	lower_inode = lower_dentry->d_inode;
+	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
+		ecryptfs_printk(1, KERN_NOTICE, "This is a directory\n");
+		crypt_stats->encrypted = 0;
+		rc = 0;
+		goto out;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "(file->f_flags & O_CREAT) = [%d] "
+			"lower_inode->i_size = [%llu] crypt_stats->struct_"
+			"initialized = [%d] crypt_stats->key_valid = [%d]\n",
+			(file->f_flags & O_CREAT),
+			(unsigned long long)lower_inode->i_size,
+			crypt_stats->struct_initialized,
+			crypt_stats->key_valid);
+	/* TODO: This was originally used to determine if it was a new file,
+	 * but if we are allowing pass-through mode, then we couldbe opening
+	 * a 0-length normal file.. in which case, this can't cause an error
+	 * So.... what do we want to do? */
+	if (lower_inode->i_size == 0) {
+		ecryptfs_printk(0, KERN_EMERG, "Zero-length lower file; "
+				"ecryptfs_create() had a problem?\n");
+		rc = -ENOENT;
+		goto out_puts;
+	} else if (!crypt_stats->policy_applied || !crypt_stats->key_valid) {
+		/* crypto.c */
+		rc = ecryptfs_read_headers(ecryptfs_dentry, lower_file);
+		if (rc) {
+			ecryptfs_printk(1, KERN_NOTICE,
+					"Valid headers not found\n");
+			crypt_stats->encrypted = 0;
+		} else {
+			read_inode_size_from_header(lower_file, lower_inode,
+						    inode);
+		}
+	} else {
+		ecryptfs_printk(1, KERN_NOTICE, "crypt_stats->struct_"
+				"initialized = [%d]; crypt_stats->key_valid = "
+				"[%d]\n", crypt_stats->struct_initialized,
+				crypt_stats->key_valid);
+	}
+	FILE_TO_LOWER(file) = lower_file;
+	goto out;
+out_puts:
+	mntput(lower_mnt);
+	ecryptfs_dput(lower_dentry);
+	ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
+				 FILE_TO_PRIVATE(file));
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static int ecryptfs_flush(struct file *file)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; file = [%p]\n", file);
+	ASSERT(lower_file = FILE_TO_LOWER(file));
+	if (lower_file->f_op && lower_file->f_op->flush) {
+		rc = lower_file->f_op->flush(lower_file);
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static int ecryptfs_release(struct inode *ecryptfs_inode, struct file *file)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	struct inode *lower_inode;
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Enter; ecryptfs_inode->i_count = [%d]\n",
+			ecryptfs_inode->i_count);
+	if (FILE_TO_PRIVATE(file) != NULL)
+		lower_file = FILE_TO_LOWER(file);
+	ASSERT(lower_file);
+	ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
+				 FILE_TO_PRIVATE(file));
+	lower_inode = INODE_TO_LOWER(ecryptfs_inode);
+	fput(lower_file);
+	ecryptfs_inode->i_blocks = lower_inode->i_blocks;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static int
+ecryptfs_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	int rc = -EINVAL;
+	struct file *lower_file = NULL;
+	struct dentry *lower_dentry;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (NULL == file) {
+		lower_dentry = ecryptfs_lower_dentry(dentry);
+		if (lower_dentry->d_inode->i_fop
+		    && lower_dentry->d_inode->i_fop->fsync) {
+			down(&lower_dentry->d_inode->i_sem);
+			rc = lower_dentry->d_inode->i_fop->fsync(lower_file,
+								 lower_dentry,
+								 datasync);
+			up(&lower_dentry->d_inode->i_sem);
+		}
+	} else {
+		if (NULL == FILE_TO_PRIVATE(file)) {
+			rc = -EINVAL;
+			ecryptfs_printk(0, KERN_ERR, "FILE_TO_PRIVATE(file="
+					"[%p]) == NULL\n", file);
+			goto out;
+		}
+		lower_file = FILE_TO_LOWER(file);
+		lower_dentry = ecryptfs_lower_dentry(dentry);
+		if (lower_file->f_op && lower_file->f_op->fsync) {
+			down(&lower_dentry->d_inode->i_sem);
+			rc = lower_file->f_op->fsync(lower_file, lower_dentry,
+						     datasync);
+			up(&lower_dentry->d_inode->i_sem);
+		}
+	}
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
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
+lock_file:
+	rc = posix_lock_file(file, fl);
+	if ((rc != -EAGAIN) || (cmd == F_SETLK)) {
+		goto out;
+	}
+	rc = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+	if (!rc) {
+		goto lock_file;
+	}
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
+	if (FILE_TO_PRIVATE(file) != NULL)
+		lower_file = FILE_TO_LOWER(file);
+	ASSERT(lower_file != NULL);
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
+	if (cmd == F_SETLKW) {
+		fl->fl_flags |= FL_SLEEP;
+	}
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
+	if (rc) {
+		goto out;
+	}
+	if (lower_file->f_op && lower_file->f_op->lock != NULL) {
+		rc = lower_file->f_op->lock(lower_file, cmd, fl);
+		if (rc)
+			goto out;
+		goto upper_lock;
+	}
+	rc = ecryptfs_posix_lock(lower_file, fl, cmd);
+	if (rc) {
+		goto out;
+	}
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
+	int rc = 0;
+	struct file_lock *tempfl = NULL;
+	if (file->f_op && file->f_op->lock) {
+		rc = file->f_op->lock(file, F_GETLK, fl);
+		if (rc < 0)
+			goto out;
+	} else {
+		tempfl = posix_test_lock(file, fl);
+	}
+	if (!tempfl) {
+		fl->fl_type = F_UNLCK;
+	} else {
+		memcpy(fl, tempfl, sizeof(struct file_lock));
+	}
+out:
+	return rc;
+}
+
+static int ecryptfs_fasync(int fd, struct file *file, int flag)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (NULL != FILE_TO_PRIVATE(file))
+		lower_file = FILE_TO_LOWER(file);
+	else {
+		rc = -EINVAL;
+		goto out;
+	}
+	if (lower_file->f_op && lower_file->f_op->fasync)
+		rc = lower_file->f_op->fasync(fd, lower_file, flag);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return rc;
+}
+
+static int ecryptfs_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (FILE_TO_PRIVATE(file) != NULL)
+		lower_file = FILE_TO_LOWER(file);
+	ASSERT(lower_file != NULL);
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
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return rc;
+}
+
+static ssize_t ecryptfs_sendfile(struct file *file, loff_t * ppos,
+				 size_t count, read_actor_t actor, void *target)
+{
+	struct file *lower_file = NULL;
+	int rc = -EINVAL;
+	if (FILE_TO_PRIVATE(file) != NULL)
+		lower_file = FILE_TO_LOWER(file);
+	ASSERT(lower_file != NULL);
+	/* TODO: Is this a superfluous check for f_op? */
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
+struct file_operations ecryptfs_dir_fops = {
+	.read = ecryptfs_read,
+	.write = ecryptfs_dir_write,
+	.readdir = ecryptfs_readdir,
+	.poll = ecryptfs_poll,
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
+struct file_operations ecryptfs_main_fops = {
+	.llseek = ecryptfs_llseek,
+	.read = ecryptfs_read_update_atime,
+	.write = generic_file_write,
+	.readdir = ecryptfs_readdir,
+	.poll = ecryptfs_poll,
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
+/**
+ * TODO: sysfs
+ */
+static int
+ecryptfs_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	       unsigned long arg)
+{
+	int rc = 0;
+	struct file *lower_file = NULL;
+	if (FILE_TO_PRIVATE(file) != NULL) {
+		lower_file = FILE_TO_LOWER(file);
+	}
+	if (lower_file && lower_file->f_op && lower_file->f_op->ioctl) {
+		rc = lower_file->f_op->ioctl(INODE_TO_LOWER(inode),
+					     lower_file, cmd, arg);
+	} else {
+		rc = -ENOTTY;
+	}
+	return rc;
+}
