Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTKLM2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTKLM2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:28:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64504 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262050AbTKLM1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:27:12 -0500
Date: Wed, 12 Nov 2003 17:55:49 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 3/5] sysfs-file.patch
Message-ID: <20031112122549.GG14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <20031112122503.GE14580@in.ibm.com> <20031112122529.GF14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122529.GF14580@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o  This patch modifies the sysfs_create_file and sysfs_create_bin_file keeping 
   the same signature. Now these don't actually create files but allocates 
   a sysfs_dirent representing the attribute and links it to the kobject's
   sysfs_dirent

o  Now dentry->d_fsdata does not point to the attribute structure but points
   to the sysfs_dirent representing the attribute. The attribute pointer
   is saved in the sysfs_dirent's s_element field.

o  At the time of actually creating the dentry for sysfs entries we don't do
   the dreaded "Extra dget"


 fs/sysfs/bin.c   |   47 +++++++++++++++------------------------
 fs/sysfs/file.c  |   66 +++++++++++++++++++++++++------------------------------
 fs/sysfs/inode.c |   41 ++++++++++++++++++++++++----------
 3 files changed, 78 insertions(+), 76 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-file fs/sysfs/file.c
--- linux-2.6.0-test9/fs/sysfs/file.c~sysfs-file	2003-11-12 16:24:20.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/file.c	2003-11-12 16:24:20.000000000 +0530
@@ -11,7 +11,7 @@
 
 static struct file_operations sysfs_file_operations;
 
-static int init_file(struct inode * inode)
+int sysfs_init_file(struct inode * inode)
 {
 	inode->i_size = PAGE_SIZE;
 	inode->i_fop = &sysfs_file_operations;
@@ -77,12 +77,13 @@ struct sysfs_buffer {
  */
 static int fill_read_buffer(struct file * file, struct sysfs_buffer * buffer)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = sysfs_get_file_attr(file);
+	struct kobject * kobj;
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
 	ssize_t count;
 
+	kobj = sysfs_get_file_kobject(file->f_dentry);
 	if (!buffer->page)
 		buffer->page = (char *) get_zeroed_page(GFP_KERNEL);
 	if (!buffer->page)
@@ -131,8 +132,8 @@ static int flush_read_buffer(struct sysf
  *	@ppos:	starting offset in file.
  *
  *	Userspace wants to read an attribute file. The attribute descriptor
- *	is in the file's ->d_fsdata. The target object is in the directory's
- *	->d_fsdata.
+ *	is in the file's sysfs_dirent which is present in ->d_fsdata. The 
+ *      target object is in the directory's sysfs_dirent.
  *
  *	We call fill_read_buffer() to allocate and fill the buffer from the
  *	object's show() method exactly once (if the read is happening from
@@ -198,8 +199,8 @@ fill_write_buffer(struct sysfs_buffer * 
 static int 
 flush_write_buffer(struct file * file, struct sysfs_buffer * buffer, size_t count)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = sysfs_get_file_attr(file);
+	struct kobject * kobj = sysfs_get_file_kobject(file->f_dentry);
 	struct sysfs_ops * ops = buffer->ops;
 
 	return ops->store(kobj,attr,buffer->page,count);
@@ -238,8 +239,8 @@ sysfs_write_file(struct file *file, cons
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct kobject * kobj = kobject_get(sysfs_get_file_kobject(file->f_dentry));
+	struct attribute * attr = sysfs_get_file_attr(file);
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -320,8 +321,8 @@ static int sysfs_open_file(struct inode 
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
-	struct attribute * attr = filp->f_dentry->d_fsdata;
+	struct kobject * kobj = sysfs_get_file_kobject(filp->f_dentry);
+	struct attribute * attr = sysfs_get_file_attr(filp);
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
@@ -345,24 +346,16 @@ static struct file_operations sysfs_file
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr)
+int sysfs_add_file(struct sysfs_dirent * parent_sd, 
+			const struct attribute * attr)
 {
-	struct dentry * dentry;
-	int error;
+	struct sysfs_dirent * sd;
 
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
+	sd = sysfs_alloc_dirent(parent_sd, (void *) attr, SYSFS_KOBJ_ATTR);
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
+
+	return 0;
 }
 
 
@@ -375,7 +368,7 @@ int sysfs_add_file(struct dentry * dir, 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
 	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
+		return sysfs_add_file(kobj->s_dirent, attr);
 	return -EINVAL;
 }
 
@@ -390,10 +383,17 @@ int sysfs_create_file(struct kobject * k
  */
 int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
 {
-	struct dentry * dir = kobj->dentry;
+	struct dentry * dir = kobj->s_dirent->s_dentry;
 	struct dentry * victim;
 	int res = -ENOENT;
 
+	if (!dir)
+		return res;
+
+	spin_lock(&dcache_lock);
+	dget_locked(dir);
+	spin_unlock(&dcache_lock);
+
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir, attr->name);
 	if (!IS_ERR(victim)) {
@@ -402,11 +402,6 @@ int sysfs_update_file(struct kobject * k
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
 			dnotify_parent(victim, DN_MODIFY);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
 			res = 0;
 		}
 		
@@ -416,6 +411,7 @@ int sysfs_update_file(struct kobject * k
 		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
+	dput(dir);
 
 	return res;
 }
@@ -431,7 +427,7 @@ int sysfs_update_file(struct kobject * k
 
 void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->name);
+	sysfs_hash_and_remove(kobj->s_dirent, attr->name);
 }
 
 
diff -puN fs/sysfs/bin.c~sysfs-file fs/sysfs/bin.c
--- linux-2.6.0-test9/fs/sysfs/bin.c~sysfs-file	2003-11-12 16:24:20.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/bin.c	2003-11-12 16:24:20.000000000 +0530
@@ -17,8 +17,9 @@
 static int
 fill_read(struct dentry *dentry, char *buffer, loff_t off, size_t count)
 {
-	struct bin_attribute * attr = dentry->d_fsdata;
-	struct kobject * kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	struct bin_attribute * attr = sd->s_element;
+	struct kobject * kobj = sysfs_get_file_kobject(dentry);
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -60,8 +61,9 @@ read(struct file * file, char __user * u
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = dentry->d_fsdata;
-	struct kobject *kobj = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd = dentry->d_fsdata;
+	struct bin_attribute * attr = sd->s_element;
+	struct kobject * kobj = sysfs_get_file_kobject(dentry);
 
 	return attr->write(kobj, buffer, offset, count);
 }
@@ -94,8 +96,9 @@ static ssize_t write(struct file * file,
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct kobject * kobj = kobject_get(sysfs_get_file_kobject(file->f_dentry));
+	struct sysfs_dirent * sd = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = sd->s_element;
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -122,7 +125,7 @@ static int open(struct inode * inode, st
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sysfs_get_file_kobject(file->f_dentry);
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
@@ -131,7 +134,7 @@ static int release(struct inode * inode,
 	return 0;
 }
 
-static struct file_operations bin_fops = {
+struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
 	.llseek		= generic_file_llseek,
@@ -148,31 +151,17 @@ static struct file_operations bin_fops =
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	struct dentry * dentry;
-	struct dentry * parent;
-	int error = 0;
+	struct sysfs_dirent * sd;
 
 	if (!kobj || !attr)
 		return -EINVAL;
 
-	parent = kobj->dentry;
+	sd = sysfs_alloc_dirent(kobj->s_dirent, attr, SYSFS_KOBJ_BIN_ATTR);
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
+
+	return 0;
 
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
 }
 
 
@@ -185,7 +174,7 @@ int sysfs_create_bin_file(struct kobject
 
 int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->attr.name);
+	sysfs_hash_and_remove(kobj->s_dirent, attr->attr.name);
 	return 0;
 }
 
diff -puN fs/sysfs/inode.c~sysfs-file fs/sysfs/inode.c
--- linux-2.6.0-test9/fs/sysfs/inode.c~sysfs-file	2003-11-12 16:24:20.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/inode.c	2003-11-12 16:24:20.000000000 +0530
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include "sysfs.h"
+
 extern struct super_block * sysfs_sb;
 
 static struct address_space_operations sysfs_aops = {
@@ -59,10 +61,9 @@ int sysfs_create(struct dentry * dentry,
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error) {
-		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
-	} else
+	if (!error)
+		d_add(dentry, inode);
+	else
 		iput(inode);
  Done:
 	return error;
@@ -83,9 +84,17 @@ struct dentry * sysfs_get_dentry(struct 
 	return lookup_hash(&qstr,parent);
 }
 
-void sysfs_hash_and_remove(struct dentry * dir, const char * name)
+void sysfs_hash_and_remove(struct sysfs_dirent * parent_sd, const char * name)
 {
 	struct dentry * victim;
+	struct dentry * dir = parent_sd->s_dentry;
+
+	if (!dir)
+		goto exit;
+
+	spin_lock(&dcache_lock);
+	dget_locked(dir);
+	spin_unlock(&dcache_lock);
 
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir,name);
@@ -93,18 +102,26 @@ void sysfs_hash_and_remove(struct dentry
 		/* make sure dentry is really there */
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
-			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
+			printk("sysfs:Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
-
-			d_delete(victim);
+			d_drop(victim);
 			simple_unlink(dir->d_inode,victim);
 		}
-		/*
-		 * Drop reference from sysfs_get_dentry() above.
-		 */
-		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
+	dput(dir);
+exit:
+	sysfs_free_dirent(parent_sd, name);
+
 }
 
+int sysfs_get_link_count(struct sysfs_dirent * sd)
+{
+	int count = 1; 
+	struct sysfs_dirent *tmp_sd;
+
+	list_for_each_entry(tmp_sd, &sd->s_children, s_sibling)
+		count++;
 
+	return count;
+}

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
