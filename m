Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUG2Utq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUG2Utq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUG2UtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:49:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:44202 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265354AbUG2UnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:43:14 -0400
Date: Thu, 29 Jul 2004 15:43:59 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] Change sysfs_file_operations 
Message-ID: <20040729204359.GF4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com> <20040729204031.GE4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729204031.GE4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch modifies the sysfs_file_operations methods so as to get the
  kobject and attribute pointers via corresponding sysfs_dirent.


 fs/sysfs/bin.c  |   21 ++++++++++++++-------
 fs/sysfs/file.c |   24 +++++++++++++++++-------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff -puN fs/sysfs/file.c~sysfs-backing-store-file_operations fs/sysfs/file.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/file.c~sysfs-backing-store-file_operations	2004-07-29 15:30:40.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/file.c	2004-07-29 15:31:07.000000000 -0500
@@ -77,8 +77,10 @@ struct sysfs_buffer {
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
@@ -135,6 +137,9 @@ static int flush_read_buffer(struct sysf
  *	is in the file's ->d_fsdata. The target object is in the directory's
  *	->d_fsdata.
  *
+ *	It is safe to use ->d_parent->d_fsdata as both dentry and the kobject
+ *	are pinned in ->open().
+ *
  *	We call fill_read_buffer() to allocate and fill the buffer from the
  *	object's show() method exactly once (if the read is happening from
  *	the beginning of the file). That should fill the entire buffer with
@@ -199,8 +204,10 @@ fill_write_buffer(struct sysfs_buffer * 
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
@@ -240,7 +247,8 @@ sysfs_write_file(struct file *file, cons
 static int check_perm(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_dirent * attr_sd = file->f_dentry->d_fsdata;
+	struct attribute * attr = attr_sd->s_element;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -321,8 +329,10 @@ static int sysfs_open_file(struct inode 
 
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
diff -puN fs/sysfs/bin.c~sysfs-backing-store-file_operations fs/sysfs/bin.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/bin.c~sysfs-backing-store-file_operations	2004-07-29 15:30:40.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/bin.c	2004-07-29 15:31:07.000000000 -0500
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

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
