Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbULUReN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbULUReN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULUReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:34:13 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:52712 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261817AbULURc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:32:57 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] add mmap support to struct bin_attribute files
Date: Tue, 21 Dec 2004 09:32:54 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G5FyB/QTHydXiET"
Message-Id: <200412210932.54961.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_G5FyB/QTHydXiET
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds an mmap method and some more error checking to struct 
bin_attribute--good for things like exporting PCI resources directly.  I 
wasn't sure about the return values for the case where an attribute is 
missing a given method, and it looks like mm.h can't be included in sysfs.h, 
so I had to forward declare struct vm_area_struct.  Other than that, it works 
fine for my test cases.

 fs/sysfs/bin.c        |   27 +++++++++++++++++++++++++--
 include/linux/sysfs.h |    6 ++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_G5FyB/QTHydXiET
Content-Type: text/plain;
  charset="us-ascii";
  name="bin-file-mmap-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bin-file-mmap-support.patch"

===== include/linux/sysfs.h 1.38 vs edited =====
--- 1.38/include/linux/sysfs.h	2004-11-01 12:47:02 -08:00
+++ edited/include/linux/sysfs.h	2004-12-21 09:31:01 -08:00
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
 
+struct vm_area_struct; /* circular dependencies? */
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
===== fs/sysfs/bin.c 1.19 vs edited =====
--- 1.19/fs/sysfs/bin.c	2004-11-01 12:46:46 -08:00
+++ edited/fs/sysfs/bin.c	2004-12-21 09:32:08 -08:00
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

--Boundary-00=_G5FyB/QTHydXiET--
