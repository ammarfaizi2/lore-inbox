Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTJFJBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTJFJBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:01:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41149 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262839AbTJFJAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:00:45 -0400
Date: Mon, 6 Oct 2003 14:31:07 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 3/6] sysfs-file.patch
Message-ID: <20031006090107.GH4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090030.GG4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o  This patch modifies the externals sysfs_create_file and 
   sysfs_create_bin_file. Now these don't actually create files but just links
   the attribute to the kobject. There is no change in the definition but
   actual function. These should be actually part of kobject code but as of
   now for not changing the interfaces there are kept as part of sysfs code.
   


 fs/sysfs/bin.c  |   40 +++++++++++++++++-----------------------
 fs/sysfs/file.c |   45 +++++++++++++++++++--------------------------
 2 files changed, 36 insertions(+), 49 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-file fs/sysfs/file.c
--- linux-2.6.0-test6/fs/sysfs/file.c~sysfs-file	2003-10-06 11:58:10.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/file.c	2003-10-06 11:58:50.000000000 +0530
@@ -11,7 +11,7 @@
 
 static struct file_operations sysfs_file_operations;
 
-static int init_file(struct inode * inode)
+int sysfs_init_file(struct inode * inode)
 {
 	inode->i_size = PAGE_SIZE;
 	inode->i_fop = &sysfs_file_operations;
@@ -345,27 +345,6 @@ static struct file_operations sysfs_file
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr)
-{
-	struct dentry * dentry;
-	int error;
-
-	down(&dir->d_inode->i_sem);
-	dentry = sysfs_get_dentry(dir,attr->name);
-	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry,
-				     (attr->mode & S_IALLUGO) | S_IFREG,
-				     init_file);
-		if (!error)
-			dentry->d_fsdata = (void *)attr;
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
-	up(&dir->d_inode->i_sem);
-	return error;
-}
-
-
 /**
  *	sysfs_create_file - create an attribute file for an object.
  *	@kobj:	object we're creating for. 
@@ -374,11 +353,25 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
-	return -EINVAL;
-}
+	struct kobject_attr * k_attr;
+	
+	if (!kobj || !attr)
+		return -EINVAL;
 
+	k_attr = kmalloc(sizeof(k_attr), GFP_KERNEL);
+	if (!k_attr)
+		return -ENOMEM;
+	memset(k_attr, 0, sizeof(k_attr));
+	INIT_LIST_HEAD(&k_attr->list);
+	k_attr->flags |= KOBJ_TEXT_ATTR;
+	k_attr->attr_u.attr = attr;
+
+	down_write(&kobj->k_rwsem);
+	list_add(&k_attr->list, &kobj->attr);
+	up_write(&kobj->k_rwsem);
+	
+	return 0;
+}
 
 /**
  * sysfs_update_file - update the modified timestamp on an object attribute.
diff -puN fs/sysfs/bin.c~sysfs-file fs/sysfs/bin.c
--- linux-2.6.0-test6/fs/sysfs/bin.c~sysfs-file	2003-10-06 11:58:13.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/bin.c	2003-10-06 11:58:50.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 
@@ -131,7 +132,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -148,31 +149,24 @@ static struct file_operations bin_fops =
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	struct dentry * dentry;
-	struct dentry * parent;
-	int error = 0;
+	struct kobject_attr * k_attr;
 
 	if (!kobj || !attr)
 		return -EINVAL;
-
-	parent = kobj->dentry;
-
-	down(&parent->d_inode->i_sem);
-	dentry = sysfs_get_dentry(parent,attr->attr.name);
-	if (!IS_ERR(dentry)) {
-		dentry->d_fsdata = (void *)attr;
-		error = sysfs_create(dentry,
-				     (attr->attr.mode & S_IALLUGO) | S_IFREG,
-				     NULL);
-		if (!error) {
-			dentry->d_inode->i_size = attr->size;
-			dentry->d_inode->i_fop = &bin_fops;
-		}
-		dput(dentry);
-	} else
-		error = PTR_ERR(dentry);
-	up(&parent->d_inode->i_sem);
-	return error;
+	
+	k_attr = kmalloc(sizeof(k_attr), GFP_KERNEL);
+	if (!k_attr)
+		return -ENOMEM;
+	memset(k_attr, 0, sizeof(k_attr));
+	INIT_LIST_HEAD(&k_attr->list);
+	k_attr->flags |= KOBJ_BINARY_ATTR;
+	k_attr->attr_u.bin_attr = attr;
+
+	down_write(&kobj->k_rwsem);
+	list_add(&k_attr->list, &kobj->attr);
+	up_write(&kobj->k_rwsem);
+	
+	return 0;
 }
 
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
