Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263896AbTDGXxe (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTDGXv4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:51:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12944 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263896AbTDGXa3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:30:29 -0400
Date: Tue, 8 Apr 2003 00:42:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: [PATCH] [1/3] sysfs bin file fixes
Message-ID: <20030407234203.GR23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Completely rewrite sysfs' handling of binary files:
 - Remove sysfs_bin_buffer.  It's a security hole.
 - Remove checks for permissions; the VFS does that.
 - Validate offset & count at the top level.
 - Allow lower levels to return less data than was asked for.
 - Allocate buffer at open & free it at close, not on each read/write.

diff -urpNX dontdiff linux-2.5.66/fs/sysfs/bin.c linux-2.5.66-laptop/fs/sysfs/bin.c
--- linux-2.5.66/fs/sysfs/bin.c	2003-04-07 09:59:08.000000000 -0500
+++ linux-2.5.66-laptop/fs/sysfs/bin.c	2003-04-07 11:01:19.000000000 -0500
@@ -2,168 +2,116 @@
  * bin.c - binary file operations for sysfs.
  */
 
+#include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/module.h>
 #include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 #include "sysfs.h"
 
-static struct file_operations bin_fops;
-
-static int fill_read(struct file * file, struct sysfs_bin_buffer * buffer)
+static int
+fill_read(struct dentry *dentry, char *buffer, loff_t off, size_t count)
 {
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct bin_attribute * attr = dentry->d_fsdata;
+	struct kobject * kobj = dentry->d_parent->d_fsdata;
 
-	if (!buffer->data)
-		attr->read(kobj,buffer);
-	return buffer->size ? 0 : -ENOENT;
-}
-
-static int flush_read(struct file * file, char * userbuf, 
-		      struct sysfs_bin_buffer * buffer)
-{
-	return copy_to_user(userbuf,buffer->data + buffer->offset,buffer->count) ? 
-		-EFAULT : 0;
+	return attr->read(kobj, buffer, off, count);
 }
 
 static ssize_t
 read(struct file * file, char * userbuf, size_t count, loff_t * off)
 {
-	struct sysfs_bin_buffer * buffer = file->private_data;
+	char *buffer = file->private_data;
+	struct dentry *dentry = file->f_dentry;
+	int size = dentry->d_inode->i_size;
+	loff_t offs = *off;
 	int ret;
 
-	ret = fill_read(file,buffer);
-	if (ret) 
-		goto Done;
+	if (offs > size)
+		return 0;
+	if (offs + count > size)
+		count = size - offs;
 
-	buffer->offset = *off;
+	ret = fill_read(dentry, buffer, offs, count);
+	if (ret < 0) 
+		goto Done;
+	count = ret;
 
-	if (count > (buffer->size - *off))
-		count = buffer->size - *off;
+	ret = -EFAULT;
+	if (copy_to_user(userbuf, buffer + offs, count) != 0)
+		goto Done;
 
-	buffer->count = count;
+	*off = offs + count;
+	ret = count;
 
-	ret = flush_read(file,userbuf,buffer);
-	if (!ret) {
-		*off += count;
-		ret = count;
-	}
  Done:
-	if (buffer && buffer->data) {
-		kfree(buffer->data);
-		buffer->data = NULL;
-	}
 	return ret;
 }
 
-int alloc_buf_data(struct sysfs_bin_buffer * buffer)
-{
-	buffer->data = kmalloc(buffer->count,GFP_KERNEL);
-	if (buffer->data) {
-		memset(buffer->data,0,buffer->count);
-		return 0;
-	} else
-		return -ENOMEM;
-}
-
-static int fill_write(struct file * file, const char * userbuf, 
-		      struct sysfs_bin_buffer * buffer)
-{
-	return copy_from_user(buffer->data,userbuf,buffer->count) ?
-		-EFAULT : 0;
-}
-
-static int flush_write(struct file * file, const char * userbuf, 
-		       struct sysfs_bin_buffer * buffer)
+static int
+flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct bin_attribute *attr = dentry->d_fsdata;
+	struct kobject *kobj = dentry->d_parent->d_fsdata;
 
-	return attr->write(kobj,buffer);
+	return attr->write(kobj, buffer, offset, count);
 }
 
 static ssize_t write(struct file * file, const char * userbuf,
 		     size_t count, loff_t * off)
 {
-	struct sysfs_bin_buffer * buffer = file->private_data;
+	char *buffer = file->private_data;
+	struct dentry *dentry = file->f_dentry;
+	int size = dentry->d_inode->i_size;
+	loff_t offs = *off;
 	int ret;
 
-	if (count > PAGE_SIZE)
-		count = PAGE_SIZE;
-	buffer->count = count;
-
-	ret = alloc_buf_data(buffer);
-	if (ret)
-		goto Done;
+	if (offs > size)
+		return 0;
+	if (offs + count > size)
+		count = size - offs;
 
-	ret = fill_write(file,userbuf,buffer);
-	if (ret)
+	ret = -EFAULT;
+	if (copy_from_user(buffer + offs, userbuf, count))
 		goto Done;
 
-	ret = flush_write(file,userbuf,buffer);
-	if (ret > 0)
-		*off += count;
+	count = flush_write(dentry, buffer, offs, count);
+	if (count > 0)
+		*off = offs + count;
+	ret = 0;
  Done:
-	if (buffer->data) {
-		kfree(buffer->data);
-		buffer->data = NULL;
-	}
 	return ret;
 }
 
-static int check_perm(struct inode * inode, struct file * file)
+static int open(struct inode * inode, struct file * file)
 {
 	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
 	struct bin_attribute * attr = file->f_dentry->d_fsdata;
-	struct sysfs_bin_buffer * buffer;
-	int error = 0;
+	int error = -EINVAL;
 
 	if (!kobj || !attr)
-		goto Einval;
-
-	/* File needs write support.
-	 * The inode's perms must say it's ok, 
-	 * and we must have a store method.
-	 */
-	if (file->f_mode & FMODE_WRITE) {
-		if (!(inode->i_mode & S_IWUGO) || !attr->write)
-			goto Eaccess;
-	}
-
-	/* File needs read support.
-	 * The inode's perms must say it's ok, and we there
-	 * must be a show method for it.
-	 */
-	if (file->f_mode & FMODE_READ) {
-		if (!(inode->i_mode & S_IRUGO) || !attr->read)
-			goto Eaccess;
-	}
-
-	buffer = kmalloc(sizeof(struct sysfs_bin_buffer),GFP_KERNEL);
-	if (buffer) {
-		memset(buffer,0,sizeof(struct sysfs_bin_buffer));
-		file->private_data = buffer;
-	} else
-		error = -ENOMEM;
-	goto Done;
+		goto Done;
 
- Einval:
-	error = -EINVAL;
-	goto Done;
- Eaccess:
 	error = -EACCES;
+	if ((file->f_mode & FMODE_WRITE) && !attr->write)
+		goto Done;
+	if ((file->f_mode & FMODE_READ) && !attr->read)
+		goto Done;
+
+	error = -ENOMEM;
+	file->private_data = kmalloc(attr->size, GFP_KERNEL);
+	if (!file->private_data)
+		goto Done;
+
+	error = 0;
+
  Done:
 	if (error && kobj)
 		kobject_put(kobj);
 	return error;
 }
 
-static int open(struct inode * inode, struct file * file)
-{
-	return check_perm(inode,file);
-}
-
 static int release(struct inode * inode, struct file * file)
 {
 	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
@@ -171,8 +119,7 @@ static int release(struct inode * inode,
 
 	if (kobj) 
 		kobject_put(kobj);
-	if (buffer)
-		kfree(buffer);
+	kfree(buffer);
 	return 0;
 }
 
diff -urpNX dontdiff linux-2.5.66/include/linux/sysfs.h linux-2.5.66-laptop/include/linux/sysfs.h
--- linux-2.5.66/include/linux/sysfs.h	2003-04-04 08:42:19.000000000 -0600
+++ linux-2.5.66-laptop/include/linux/sysfs.h	2003-04-07 09:54:50.000000000 -0500
@@ -16,18 +16,11 @@ struct attribute {
 	mode_t			mode;
 };
 
-struct sysfs_bin_buffer {
-	u8 * 	data;
-	size_t	size;
-	size_t	count;
-	loff_t	offset;
-};
-
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
-	ssize_t (*read)(struct kobject *, struct sysfs_bin_buffer *);
-	ssize_t (*write)(struct kobject *, struct sysfs_bin_buffer *);
+	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
+	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
 struct sysfs_ops {

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
