Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUEEMx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUEEMx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUEEMx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:53:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59308 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264637AbUEEMvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:51:41 -0400
Date: Wed, 5 May 2004 18:28:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>
Subject: [RFC 3/6] sysfs backing store ver 0.5
Message-ID: <20040505125833.GD1244@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040505125702.GA1244@in.ibm.com> <20040505125755.GB1244@in.ibm.com> <20040505125815.GC1244@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505125815.GC1244@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.5
  o Cahnges to accomodate latest sysfs changes basically using
    sysfs_get_kobject() while opening sysfs files.

=> changes in version 0.4
  o Made necessary changes for checking DCACHE_SYSFS_CONNECTED flag while
    opening the sysfs file in check_perm() and a few changes in variable names

=> changes in version 0.3
  o Nil, just re-diffed

=> changes in version 0.2
  o Nil, just re-diffed

=> Changes:
  o Removed the extra kobject_get from sysfs_release() 

=======================================================
o sysfs_create_file() will just link a new sysfs_dirent() structure representing
  the attribute file to the kobject's s_children list.

o in sysfs_create() we take extra ref. only for dentries corresponding to
  non-regular files or in other words pin only non-leaf dentries.



 fs/sysfs/file.c  |   65 +++++++++++++++++++++++++++----------------------------
 fs/sysfs/inode.c |   14 +++++------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-leaves-file fs/sysfs/file.c
--- linux-2.6.6-rc3-mm1/fs/sysfs/file.c~sysfs-leaves-file	2004-05-05 10:55:13.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/file.c	2004-05-05 10:55:13.000000000 +0530
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
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct attribute * attr = attr_sd->s_element;
+	struct sysfs_dirent * kobj_sd = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobj_sd->s_element;
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
 	ssize_t count;
@@ -134,6 +128,9 @@ static int flush_read_buffer(struct sysf
  *	is in the file's ->d_fsdata. The target object is in the directory's
  *	->d_fsdata.
  *
+ *	It is safe to use ->d_parent->d_fsdata as both dentry and the kobject 
+ *	are pinned in ->open().
+ *	
  *	We call fill_read_buffer() to allocate and fill the buffer from the
  *	object's show() method exactly once (if the read is happening from
  *	the beginning of the file). That should fill the entire buffer with
@@ -198,8 +195,10 @@ fill_write_buffer(struct sysfs_buffer * 
 static int 
 flush_write_buffer(struct file * file, struct sysfs_buffer * buffer, size_t count)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct attribute * attr = attr_sd->s_element;
+	struct sysfs_dirent * kobj_sd = file->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobj_sd->s_element;
 	struct sysfs_ops * ops = buffer->ops;
 
 	return ops->store(kobj,attr,buffer->page,count);
@@ -239,7 +238,8 @@ sysfs_write_file(struct file *file, cons
 static int check_perm(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct attribute * attr = attr_sd->s_element;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -320,8 +320,10 @@ static int sysfs_open_file(struct inode 
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
-	struct attribute * attr = filp->f_dentry->d_fsdata;
+	struct sysfs_dirent * attr_sd = filp->f_dentry->d_fsdata;
+	struct attribute * attr = attr_sd->s_element;
+	struct sysfs_dirent * kobj_sd = filp->f_dentry->d_parent->d_fsdata;
+	struct kobject * kobj = kobj_sd->s_element;
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
@@ -336,7 +338,7 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
-static struct file_operations sysfs_file_operations = {
+struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
@@ -345,23 +347,20 @@ static struct file_operations sysfs_file
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
+	else
+		sd->s_mode =  (attr->mode & S_IALLUGO) | S_IFREG ;
+	up(&parent->d_inode->i_sem);			
+	
 	return error;
 }
 
@@ -374,8 +373,8 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
-	if (kobj && attr)
-		return sysfs_add_file(kobj->dentry,attr);
+	if (kobj && kobj->dentry && attr)
+		return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
 	return -EINVAL;
 }
 
diff -puN fs/sysfs/inode.c~sysfs-leaves-file fs/sysfs/inode.c
--- linux-2.6.6-rc3-mm1/fs/sysfs/inode.c~sysfs-leaves-file	2004-05-05 10:55:13.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/inode.c	2004-05-05 10:55:14.000000000 +0530
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
@@ -97,18 +100,15 @@ void sysfs_hash_and_remove(struct dentry
 				 atomic_read(&victim->d_count));
 
 			d_drop(victim);
-			/* release the target kobject in case of 
-			 * a symlink
-			 */
-			if (S_ISLNK(victim->d_inode->i_mode))
-				kobject_put(victim->d_fsdata);
-			simple_unlink(dir->d_inode,victim);
+			if (S_ISDIR(victim->d_inode->i_mode))
+ 				simple_unlink(dir->d_inode,victim);
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
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
