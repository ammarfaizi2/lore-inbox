Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUBRNDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUBRNC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:02:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:65513 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266204AbUBRNBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:01:11 -0500
Date: Wed, 18 Feb 2004 18:35:42 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC][4/6] Sysfs backing store release 0.1
Message-ID: <20040218130542.GF1255@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040218130211.GB1255@in.ibm.com> <20040218130306.GC1255@in.ibm.com> <20040218130411.GD1255@in.ibm.com> <20040218130501.GE1255@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218130501.GE1255@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 fs/sysfs/bin.c |   52 +++++++++++++++++++---------------------------------
 1 files changed, 19 insertions(+), 33 deletions(-)

diff -puN fs/sysfs/bin.c~sysfs-leaves-bin fs/sysfs/bin.c
--- linux-2.6.3-mm1/fs/sysfs/bin.c~sysfs-leaves-bin	2004-02-18 15:26:53.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/fs/sysfs/bin.c	2004-02-18 15:27:02.000000000 +0530
@@ -17,8 +17,10 @@
 static int
 fill_read(struct dentry *dentry, char *buffer, loff_t off, size_t count)
 {
-	struct bin_attribute * attr = dentry->d_fsdata;
-	struct kobject * kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd_attr = dentry->d_fsdata;
+	struct bin_attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd_kobj->s_element;
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -60,8 +62,10 @@ read(struct file * file, char __user * u
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = dentry->d_fsdata;
-	struct kobject *kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd_attr = dentry->d_fsdata;
+	struct bin_attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd_kobj->s_element;
 
 	return attr->write(kobj, buffer, offset, count);
 }
@@ -94,8 +98,10 @@ static ssize_t write(struct file * file,
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * sd_kobj = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobject_get(sd_kobj->s_element);
+	struct sysfs_dirent * sd_attr = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = sd_attr->s_element;
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -122,7 +128,8 @@ static int open(struct inode * inode, st
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd->s_element;
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
@@ -131,7 +138,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -148,31 +155,10 @@ static struct file_operations bin_fops =
 
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
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
