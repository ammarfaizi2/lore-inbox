Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTL2JhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTL2JhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:37:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:29345 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263062AbTL2JgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:36:00 -0500
Date: Mon, 29 Dec 2003 15:05:19 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 3/5] sysfs backing store (leaves only) - sysfs-leaves-file.patch
Message-ID: <20031229093519.GD1649@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031229093213.GA1649@in.ibm.com> <20031229093354.GB1649@in.ibm.com> <20031229093434.GC1649@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229093434.GC1649@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o sysfs_create_file() will just link a new sysfs_dirent() structure representing
  the attribute file to the kobject's s_children list.

o in sysfs_create() we take extra ref. only for dentries corresponding to
  non-regular files or in other words pin only non-leaf dentries.

 fs/sysfs/file.c  |   63 +++++++++++++++++++++++++------------------------------
 fs/sysfs/inode.c |   19 +++++++++++++---
 2 files changed, 45 insertions(+), 37 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-leaves-file fs/sysfs/file.c
--- linux-2.6.0/fs/sysfs/file.c~sysfs-leaves-file	2003-12-29 12:43:44.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/file.c	2003-12-29 12:43:44.000000000 +0530
@@ -9,14 +9,6 @@
 
 #include "sysfs.h"
 
-static struct file_operations sysfs_file_operations;
-
-static int init_file(struct inode * inode)
-{
-	inode->i_size = PAGE_SIZE;
-	inode->i_fop = &sysfs_file_operations;
-	return 0;
-}
 
 #define to_subsys(k) container_of(k,struct subsystem,kset.kobj)
 #define to_sattr(a) container_of(a,struct subsys_attribute,attr)
@@ -77,8 +69,10 @@ struct sysfs_buffer {
  */
 static int fill_read_buffer(struct file * file, struct sysfs_buffer * buffer)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd_attr = file->f_dentry->d_fsdata;
+	struct attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd_kobj->s_element;
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
 	ssize_t count;
@@ -198,8 +192,10 @@ fill_write_buffer(struct sysfs_buffer * 
 static int 
 flush_write_buffer(struct file * file, struct sysfs_buffer * buffer, size_t count)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * sd_attr = file->f_dentry->d_fsdata;
+	struct attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = sd_kobj->s_element;
 	struct sysfs_ops * ops = buffer->ops;
 
 	return ops->store(kobj,attr,buffer->page,count);
@@ -238,8 +234,10 @@ sysfs_write_file(struct file *file, cons
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * sd_attr = file->f_dentry->d_fsdata;
+	struct attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobject_get(sd_kobj->s_element);
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -320,8 +318,10 @@ static int sysfs_open_file(struct inode 
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
-	struct attribute * attr = filp->f_dentry->d_fsdata;
+	struct sysfs_dirent * sd_attr = filp->f_dentry->d_fsdata;
+	struct attribute * attr = sd_attr->s_element;
+	struct sysfs_dirent * sd_kobj = filp->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobject_get(sd_kobj->s_element);
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
@@ -336,7 +336,7 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
-static struct file_operations sysfs_file_operations = {
+struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
@@ -345,23 +345,18 @@ static struct file_operations sysfs_file
 };
 
 
-int sysfs_add_file(struct dentry * dir, const struct attribute * attr)
+int sysfs_add_file(struct dentry * parent, int t, const struct attribute * attr)
 {
-	struct dentry * dentry;
-	int error;
+	struct sysfs_dirent * sd;
+	struct sysfs_dirent * parent_sd = parent->d_fsdata;
+	int error = 0;
 
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
+	down(&parent->d_inode->i_sem);			
+	sd = sysfs_new_dirent(parent_sd, (void *) attr, t);
+	if (!sd)
+		error =  -ENOMEM;
+	up(&parent->d_inode->i_sem);			
+	
 	return error;
 }
 
@@ -374,8 +369,8 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
+	if (kobj && kobj->dentry && attr) 
+		return sysfs_add_file(kobj->dentry, SYSFS_KOBJ_ATTR, attr);
 	return -EINVAL;
 }
 
diff -puN fs/sysfs/inode.c~sysfs-leaves-file fs/sysfs/inode.c
--- linux-2.6.0/fs/sysfs/inode.c~sysfs-leaves-file	2003-12-29 12:43:44.000000000 +0530
+++ linux-2.6.0-maneesh/fs/sysfs/inode.c	2003-12-29 12:43:44.000000000 +0530
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include "sysfs.h"
+
 extern struct super_block * sysfs_sb;
 
 static struct address_space_operations sysfs_aops = {
@@ -61,7 +63,8 @@ int sysfs_create(struct dentry * dentry,
 		error = init(inode);
 	if (!error) {
 		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
+		if (!S_ISREG(inode->i_mode)) 
+			dget(dentry);  /* pin non-leaf dentry in core */
 	} else
 		iput(inode);
  Done:
@@ -96,14 +99,24 @@ void sysfs_hash_and_remove(struct dentry
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			d_delete(victim);
-			simple_unlink(dir->d_inode,victim);
+			if (S_ISREG(victim->d_inode->i_mode)) {
+				spin_lock(&dcache_lock);
+				spin_lock(&victim->d_lock);
+				__d_drop(victim);
+				spin_unlock(&dcache_lock);
+				spin_unlock(&victim->d_lock);
+			}
+			else {
+				d_delete(victim);
+				simple_unlink(dir->d_inode,victim);
+			}
 		}
 		/*
 		 * Drop reference from sysfs_get_dentry() above.
 		 */
 		dput(victim);
 	}
+	sysfs_remove_attr_dirent(dir->d_fsdata, name);
 	up(&dir->d_inode->i_sem);
 }
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
