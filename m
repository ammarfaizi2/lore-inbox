Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUBDLg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUBDLg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:36:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57577 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266326AbUBDLf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:35:27 -0500
Date: Wed, 4 Feb 2004 17:10:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC/T 3/6] sysfs backing store (with symlink)
Message-ID: <20040204114003.GD4234@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040204113758.GA4234@in.ibm.com> <20040204113848.GB4234@in.ibm.com> <20040204113920.GC4234@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204113920.GC4234@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




=> Changes:
  > Removed the extra kobject_get from sysfs_release() 

o sysfs_create_file() will just link a new sysfs_dirent() structure representing
  the attribute file to the kobject's s_children list.

o in sysfs_create() we take extra ref. only for dentries corresponding to
  non-regular files or in other words pin only non-leaf dentries.



 fs/sysfs/file.c  |   63 +++++++++++++++++++++++++------------------------------
 fs/sysfs/inode.c |   14 +++++++++---
 2 files changed, 40 insertions(+), 37 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-leaves-file fs/sysfs/file.c
--- linux-2.6.2-rc3/fs/sysfs/file.c~sysfs-leaves-file	2004-02-02 22:17:14.000000000 +0530
+++ linux-2.6.2-rc3-maneesh/fs/sysfs/file.c	2004-02-02 22:21:09.000000000 +0530
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
+	struct kobject * kobj = sd_kobj->s_element;
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
+int sysfs_add_file(struct dentry * parent, const struct attribute * attr, int t)
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
+		return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
 	return -EINVAL;
 }
 
diff -puN fs/sysfs/inode.c~sysfs-leaves-file fs/sysfs/inode.c
--- linux-2.6.2-rc3/fs/sysfs/inode.c~sysfs-leaves-file	2004-02-02 22:17:18.000000000 +0530
+++ linux-2.6.2-rc3-maneesh/fs/sysfs/inode.c	2004-02-02 22:21:09.000000000 +0530
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
+		if (S_ISDIR(mode)) 
+			dget(dentry);  /* pin only directory dentry in core */
 	} else
 		iput(inode);
  Done:
@@ -96,14 +99,19 @@ void sysfs_hash_and_remove(struct dentry
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			d_delete(victim);
-			simple_unlink(dir->d_inode,victim);
+			if (S_ISDIR(victim->d_inode->i_mode)) {
+				d_delete(victim);
+				simple_unlink(dir->d_inode,victim);
+			}
+			else
+				d_drop(victim);
 		}
 		/*
 		 * Drop reference from sysfs_get_dentry() above.
 		 */
 		dput(victim);
 	}
+	sysfs_remove_dirent(dir->d_fsdata, name);
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
