Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWIABsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWIABsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWIABsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:48:32 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:15751 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964889AbWIABsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:48:31 -0400
Date: Thu, 31 Aug 2006 21:48:19 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 09/22][RFC] Unionfs: File operations
Message-ID: <20060901014818.GJ5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch provides the file operations for Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/file.c |  279 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/file.c linux-2.6-git-unionfs/fs/unionfs/file.c
--- linux-2.6-git/fs/unionfs/file.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/file.c	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,279 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * For specific licensing information, see the COPYING file distributed with
+ * this package.
+ *
+ * This Copyright notice must be kept intact and distributed with all sources.
+ */
+
+#include "union.h"
+
+/* declarations for sparse */
+extern ssize_t unionfs_read(struct file *, char __user *, size_t, loff_t *);
+extern ssize_t unionfs_write(struct file *, const char __user *, size_t,
+			     loff_t *);
+
+/*******************
+ * File Operations *
+ *******************/
+
+static loff_t unionfs_llseek(struct file *file, loff_t offset, int origin)
+{
+	loff_t err;
+	struct file *hidden_file = NULL;
+
+	if ((err = unionfs_file_revalidate(file, 0)))
+		goto out;
+
+	hidden_file = ftohf(file);
+	/* always set hidden position to this one */
+	hidden_file->f_pos = file->f_pos;
+
+	memcpy(&(hidden_file->f_ra), &(file->f_ra),
+	       sizeof(struct file_ra_state));
+
+	if (hidden_file->f_op && hidden_file->f_op->llseek)
+		err = hidden_file->f_op->llseek(hidden_file, offset, origin);
+	else
+		err = generic_file_llseek(hidden_file, offset, origin);
+
+	if (err < 0)
+		goto out;
+	if (err != file->f_pos) {
+		file->f_pos = err;
+		// ION maybe this?
+		//      file->f_pos = hidden_file->f_pos;
+
+		file->f_version++;
+	}
+out:
+	return err;
+}
+
+ssize_t __unionfs_read(struct file * file, char __user * buf, size_t count,
+		       loff_t * ppos)
+{
+	int err = -EINVAL;
+	struct file *hidden_file = NULL;
+	loff_t pos = *ppos;
+
+	hidden_file = ftohf(file);
+	if (!hidden_file->f_op || !hidden_file->f_op->read)
+		goto out;
+
+	err = hidden_file->f_op->read(hidden_file, buf, count, &pos);
+	*ppos = pos;
+
+out:
+	return err;
+}
+
+ssize_t unionfs_read(struct file * file, char __user * buf, size_t count,
+		     loff_t * ppos)
+{
+	int err = -EINVAL;
+
+	if ((err = unionfs_file_revalidate(file, 0)))
+		goto out;
+
+	err = __unionfs_read(file, buf, count, ppos);
+
+out:
+	return err;
+}
+
+ssize_t __unionfs_write(struct file * file, const char __user * buf,
+			size_t count, loff_t * ppos)
+{
+	int err = -EINVAL;
+	struct file *hidden_file = NULL;
+	struct inode *inode;
+	struct inode *hidden_inode;
+	loff_t pos = *ppos;
+	int bstart, bend;
+
+	inode = file->f_dentry->d_inode;
+
+	bstart = fbstart(file);
+	bend = fbend(file);
+
+	BUG_ON(bstart == -1);
+
+	hidden_file = ftohf(file);
+	hidden_inode = hidden_file->f_dentry->d_inode;
+
+	if (!hidden_file->f_op || !hidden_file->f_op->write)
+		goto out;
+
+	/* adjust for append -- seek to the end of the file */
+	if (file->f_flags & O_APPEND)
+		pos = inode->i_size;
+
+	err = hidden_file->f_op->write(hidden_file, buf, count, &pos);
+
+	/*
+	 * copy ctime and mtime from lower layer attributes
+	 * atime is unchanged for both layers
+	 */
+	if (err >= 0)
+		fist_copy_attr_times(inode, hidden_inode);
+
+	*ppos = pos;
+
+	/* update this inode's size */
+	if (pos > inode->i_size)
+		inode->i_size = pos;
+out:
+	return err;
+}
+
+ssize_t unionfs_write(struct file * file, const char __user * buf, size_t count,
+		      loff_t * ppos)
+{
+	int err = 0;
+
+	if ((err = unionfs_file_revalidate(file, 1)))
+		goto out;
+
+	err = __unionfs_write(file, buf, count, ppos);
+
+out:
+	return err;
+}
+
+static int unionfs_file_readdir(struct file *file, void *dirent,
+				filldir_t filldir)
+{
+	int err = -ENOTDIR;
+	return err;
+}
+
+static unsigned int unionfs_poll(struct file *file, poll_table * wait)
+{
+	unsigned int mask = DEFAULT_POLLMASK;
+	struct file *hidden_file = NULL;
+
+	if (unionfs_file_revalidate(file, 0)) {
+		/* We should pretend an error happend. */
+		mask = POLLERR | POLLIN | POLLOUT;
+		goto out;
+	}
+
+	hidden_file = ftohf(file);
+
+	if (!hidden_file->f_op || !hidden_file->f_op->poll)
+		goto out;
+
+	mask = hidden_file->f_op->poll(hidden_file, wait);
+
+out:
+	return mask;
+}
+
+static int __do_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int err;
+	struct file *hidden_file;
+
+	hidden_file = ftohf(file);
+
+	err = -ENODEV;
+	if (!hidden_file->f_op || !hidden_file->f_op->mmap)
+		goto out;
+
+	vma->vm_file = hidden_file;
+	err = hidden_file->f_op->mmap(hidden_file, vma);
+	get_file(hidden_file);	/* make sure it doesn't get freed on us */
+	fput(file);		/* no need to keep extra ref on ours */
+out:
+	return err;
+}
+
+/* SP: mmap code now maps upper file
+ * like old code, will only copyup at this point, it's possible to copyup
+ * in writepage(), but I haven't bothered with that, as only apt-get seem
+ * to want to write to a shared/write mapping
+ */
+static int unionfs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int err = 0;
+	int willwrite;
+
+	/* This might could be deferred to mmap's writepage. */
+	willwrite = ((vma->vm_flags | VM_SHARED | VM_WRITE) == vma->vm_flags);
+	if ((err = unionfs_file_revalidate(file, willwrite)))
+		goto out;
+
+	err = __do_mmap(file, vma);
+
+out:
+	return err;
+}
+
+static int unionfs_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	int err;
+	struct file *hidden_file = NULL;
+
+	if ((err = unionfs_file_revalidate(file, 1)))
+		goto out;
+
+	hidden_file = ftohf(file);
+
+	err = -EINVAL;
+	if (!hidden_file->f_op || !hidden_file->f_op->fsync)
+		goto out;
+
+	mutex_lock(&hidden_file->f_dentry->d_inode->i_mutex);
+	err = hidden_file->f_op->fsync(hidden_file, hidden_file->f_dentry,
+				       datasync);
+	mutex_unlock(&hidden_file->f_dentry->d_inode->i_mutex);
+
+out:
+	return err;
+}
+
+/* SP: disabled as none of the other in kernel fs's seem to use it */
+static int unionfs_fasync(int fd, struct file *file, int flag)
+{
+	int err = 0;
+	struct file *hidden_file = NULL;
+
+	if ((err = unionfs_file_revalidate(file, 1)))
+		goto out;
+
+	hidden_file = ftohf(file);
+
+	if (hidden_file->f_op && hidden_file->f_op->fasync)
+		err = hidden_file->f_op->fasync(fd, hidden_file, flag);
+
+out:
+	return err;
+}
+
+struct file_operations unionfs_main_fops = {
+	.llseek = unionfs_llseek,
+	.read = unionfs_read,
+	.write = unionfs_write,
+	.readdir = unionfs_file_readdir,
+	.poll = unionfs_poll,
+	.unlocked_ioctl = unionfs_ioctl,
+	.mmap = unionfs_mmap,
+	.open = unionfs_open,
+	.flush = unionfs_flush,
+	.release = unionfs_file_release,
+	.fsync = unionfs_fsync,
+	.fasync = unionfs_fasync,
+};
+
