Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUEQMQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUEQMQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUEQMNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:13:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49625 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264985AbUEQMLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:11:07 -0400
Date: Mon, 17 May 2004 17:37:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.6-mm3] sysfs-leaves-bin.patch
Message-ID: <20040517120715.GF1249@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040517120443.GB1249@in.ibm.com> <20040517120543.GC1249@in.ibm.com> <20040517120615.GD1249@in.ibm.com> <20040517120644.GE1249@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517120644.GE1249@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.6
  o Re-diffed for 2.6.6-mm3

=> changes in version 0.5
  o Changes to accomodate latest changes in sysfs like doing
    module_get/put while open() and release() functions.

=> changes in version 0.4
  o Made necessary changes for checking DCACHE_SYSFS_CONNECTED flag while
    opening the sysfs file in open() and a few changes in variable names.

=> changes in version 0.3
  o Nil, just re-diffed

=> changes in version 0.2
  o Nil, just re-diffed

o This patch contains changes required for bin attribute files.


 fs/sysfs/bin.c |   52 +++++++++++++++++++---------------------------------
 1 files changed, 19 insertions(+), 33 deletions(-)

diff -puN fs/sysfs/bin.c~sysfs-leaves-bin fs/sysfs/bin.c
--- linux-2.6.6-mm3/fs/sysfs/bin.c~sysfs-leaves-bin	2004-05-17 15:29:29.000000000 +0530
+++ linux-2.6.6-mm3-maneesh/fs/sysfs/bin.c	2004-05-17 15:29:29.000000000 +0530
@@ -17,8 +17,10 @@
 static int
 fill_read(struct dentry *dentry, char *buffer, loff_t off, size_t count)
 {
-	struct bin_attribute * attr = dentry->d_fsdata;
-	struct kobject * kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * attr_sd = dentry->d_fsdata;
+	struct bin_attribute * attr = attr_sd->s_element;
+	struct sysfs_dirent * kobj_sd = dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobj_sd->s_element;
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -60,8 +62,10 @@ read(struct file * file, char __user * u
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = dentry->d_fsdata;
-	struct kobject *kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * attr_sd = dentry->d_fsdata;
+	struct bin_attribute * attr = attr_sd->s_element;
+	struct sysfs_dirent * kobj_sd = dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobj_sd->s_element;
 
 	return attr->write(kobj, buffer, offset, count);
 }
@@ -95,7 +99,8 @@ static ssize_t write(struct file * file,
 static int open(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = attr_sd->s_element;
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -130,8 +135,10 @@ static int open(struct inode * inode, st
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * sd = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd->s_element;
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = attr_sd->s_element;
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
@@ -141,7 +148,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -158,31 +165,10 @@ static struct file_operations bin_fops =
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	struct dentry * dentry;
-	struct dentry * parent;
-	int error = 0;
-
-	if (!kobj || !attr)
-		return -EINVAL;
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
+	if (kobj && kobj->dentry && attr) 
+		return sysfs_add_file(kobj->dentry, &attr->attr, 
+					SYSFS_KOBJ_BIN_ATTR);
+	return -EINVAL;
 }
 
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
