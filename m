Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVAHHtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVAHHtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVAHHsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:48:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:48005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261871AbVAHFsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:19 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632611402@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:41 -0800
Message-Id: <11051632613305@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.22, 2004/12/21 10:37:07-08:00, jbarnes@engr.sgi.com

[PATCH] sysfs: add mmap support to struct bin_attribute files

This patch adds an mmap method and some more error checking to struct
bin_attribute--good for things like exporting PCI resources directly.  I
wasn't sure about the return values for the case where an attribute is
missing a given method, and it looks like mm.h can't be included in sysfs.h,
so I had to forward declare struct vm_area_struct.  Other than that, it works
fine for my test cases.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/bin.c        |   27 +++++++++++++++++++++++++--
 include/linux/sysfs.h |    6 ++++++
 2 files changed, 31 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	2005-01-07 15:41:17 -08:00
+++ b/fs/sysfs/bin.c	2005-01-07 15:41:17 -08:00
@@ -1,5 +1,9 @@
 /*
  * bin.c - binary file operations for sysfs.
+ *
+ * Copyright (c) 2003 Patrick Mochel
+ * Copyright (c) 2003 Matthew Wilcox
+ * Copyright (c) 2004 Silicon Graphics, Inc.
  */
 
 #undef DEBUG
@@ -20,6 +24,9 @@
 	struct bin_attribute * attr = to_bin_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 
+	if (!attr->read)
+		return -EINVAL;
+
 	return attr->read(kobj, buffer, off, count);
 }
 
@@ -63,6 +70,9 @@
 	struct bin_attribute *attr = to_bin_attr(dentry);
 	struct kobject *kobj = to_kobj(dentry->d_parent);
 
+	if (!attr->write)
+		return -EINVAL;
+
 	return attr->write(kobj, buffer, offset, count);
 }
 
@@ -92,6 +102,18 @@
 	return count;
 }
 
+static int mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+
+	if (!attr->mmap)
+		return -EINVAL;
+
+	return attr->mmap(kobj, attr, vma);
+}
+
 static int open(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
@@ -107,9 +129,9 @@
 		goto Done;
 
 	error = -EACCES;
-	if ((file->f_mode & FMODE_WRITE) && !attr->write)
+	if ((file->f_mode & FMODE_WRITE) && !(attr->write || attr->mmap))
 		goto Error;
-	if ((file->f_mode & FMODE_READ) && !attr->read)
+	if ((file->f_mode & FMODE_READ) && !(attr->read || attr->mmap))
 		goto Error;
 
 	error = -ENOMEM;
@@ -144,6 +166,7 @@
 struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
+	.mmap		= mmap,
 	.llseek		= generic_file_llseek,
 	.open		= open,
 	.release	= release,
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	2005-01-07 15:41:17 -08:00
+++ b/include/linux/sysfs.h	2005-01-07 15:41:17 -08:00
@@ -2,6 +2,7 @@
  * sysfs.h - definitions for the device driver filesystem
  *
  * Copyright (c) 2001,2002 Patrick Mochel
+ * Copyright (c) 2004 Silicon Graphics, Inc.
  *
  * Please see Documentation/filesystems/sysfs.txt for more information.
  */
@@ -47,11 +48,16 @@
 
 #define attr_name(_attr) (_attr).attr.name
 
+struct vm_area_struct;
+
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
+	void			*private;
 	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	int (*mmap)(struct kobject *, struct bin_attribute *attr,
+		    struct vm_area_struct *vma);
 };
 
 struct sysfs_ops {

