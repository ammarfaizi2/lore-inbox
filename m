Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267932AbUHKEYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267932AbUHKEYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUHKEYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:24:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10690 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267930AbUHKEVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:21:54 -0400
Date: Tue, 10 Aug 2004 15:57:39 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] sysfs backing store - updated
Message-ID: <20040810205739.GA3124@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Viro,

I have revised the sysfs backing store patchset. It took some what longer
time due to last minute dentry leak obeserved in intermediate patches. Now
I have verified individual patches work properly and without any leaks.

I have also re-arranged it according to your last comments. The patch set
also fixes the recent uid/gid problem reported om lkml. Now we always create
sysfs files with root uid/gid (i.e 0).

Appended below is the first patch in the series and rest of them follow this
mail.

Andrew, please replace all the sysfs-backing-store-xxx.patch again in -mm. 

Thanks
Maneesh



o The following patch provides dumb helpers to access the corresponding 
  kobject, attribute or binary attribute given a dentry and prepare the
  sysfs_file_operation methods for using sysfs_dirents.


 fs/sysfs/bin.c   |   14 +++++++-------
 fs/sysfs/file.c  |   24 ++++++++++++------------
 fs/sysfs/sysfs.h |   18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 20 deletions(-)

diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-prepare-file_operations fs/sysfs/sysfs.h
--- linux-2.6.8-rc4/fs/sysfs/sysfs.h~sysfs-backing-store-prepare-file_operations	2004-08-10 15:09:10.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/sysfs.h	2004-08-10 15:37:34.000000000 -0500
@@ -16,14 +16,30 @@ extern int sysfs_readlink(struct dentry 
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
 
+static inline struct kobject * to_kobj(struct dentry * dentry)
+{
+	return ((struct kobject *) dentry->d_fsdata);
+}
+
+static inline struct attribute * to_attr(struct dentry * dentry)
+{
+	return ((struct attribute *) dentry->d_fsdata);
+}
+
+static inline struct bin_attribute * to_bin_attr(struct dentry * dentry)
+{
+	return ((struct bin_attribute *) dentry->d_fsdata);
+}
+
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
 	struct kobject * kobj = NULL;
 
 	spin_lock(&dcache_lock);
 	if (!d_unhashed(dentry))
-		kobj = kobject_get(dentry->d_fsdata);
+		kobj = kobject_get(to_kobj(dentry));
 	spin_unlock(&dcache_lock);
 
 	return kobj;
 }
+
diff -puN fs/sysfs/file.c~sysfs-backing-store-prepare-file_operations fs/sysfs/file.c
--- linux-2.6.8-rc4/fs/sysfs/file.c~sysfs-backing-store-prepare-file_operations	2004-08-10 15:09:10.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/file.c	2004-08-10 15:37:34.000000000 -0500
@@ -67,7 +67,7 @@ struct sysfs_buffer {
 
 /**
  *	fill_read_buffer - allocate and fill buffer from object.
- *	@file:		file pointer.
+ *	@dentry:	dentry pointer.
  *	@buffer:	data buffer for file.
  *
  *	Allocate @buffer->page, if it hasn't been already, then call the
@@ -75,10 +75,10 @@ struct sysfs_buffer {
  *	data. 
  *	This is called only once, on the file's first read. 
  */
-static int fill_read_buffer(struct file * file, struct sysfs_buffer * buffer)
+static int fill_read_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = to_attr(dentry);
+	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
 	ssize_t count;
@@ -150,7 +150,7 @@ sysfs_read_file(struct file *file, char 
 	ssize_t retval = 0;
 
 	if (!*ppos) {
-		if ((retval = fill_read_buffer(file,buffer)))
+		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			return retval;
 	}
 	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
@@ -197,10 +197,10 @@ fill_write_buffer(struct sysfs_buffer * 
  */
 
 static int 
-flush_write_buffer(struct file * file, struct sysfs_buffer * buffer, size_t count)
+flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t count)
 {
-	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = to_attr(dentry);
+	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
 
 	return ops->store(kobj,attr,buffer->page,count);
@@ -231,7 +231,7 @@ sysfs_write_file(struct file *file, cons
 
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
-		count = flush_write_buffer(file,buffer,count);
+		count = flush_write_buffer(file->f_dentry,buffer,count);
 	if (count > 0)
 		*ppos += count;
 	return count;
@@ -240,7 +240,7 @@ sysfs_write_file(struct file *file, cons
 static int check_perm(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct attribute * attr = to_attr(file->f_dentry);
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -321,8 +321,8 @@ static int sysfs_open_file(struct inode 
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
-	struct attribute * attr = filp->f_dentry->d_fsdata;
+	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
+	struct attribute * attr = to_attr(filp->f_dentry);
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
diff -puN fs/sysfs/bin.c~sysfs-backing-store-prepare-file_operations fs/sysfs/bin.c
--- linux-2.6.8-rc4/fs/sysfs/bin.c~sysfs-backing-store-prepare-file_operations	2004-08-10 15:09:10.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/bin.c	2004-08-10 15:37:34.000000000 -0500
@@ -17,8 +17,8 @@
 static int
 fill_read(struct dentry *dentry, char *buffer, loff_t off, size_t count)
 {
-	struct bin_attribute * attr = dentry->d_fsdata;
-	struct kobject * kobj = dentry->d_parent->d_fsdata;
+	struct bin_attribute * attr = to_bin_attr(dentry);
+	struct kobject * kobj = to_kobj(dentry->d_parent);
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -60,8 +60,8 @@ read(struct file * file, char __user * u
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = dentry->d_fsdata;
-	struct kobject *kobj = dentry->d_parent->d_fsdata;
+	struct bin_attribute *attr = to_bin_attr(dentry->d_parent);
+	struct kobject *kobj = to_kobj(dentry);
 
 	return attr->write(kobj, buffer, offset, count);
 }
@@ -95,7 +95,7 @@ static ssize_t write(struct file * file,
 static int open(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -130,8 +130,8 @@ static int open(struct inode * inode, st
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct kobject * kobj = to_kobj(file->f_dentry->d_parent);
+	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
 	u8 * buffer = file->private_data;
 
 	if (kobj) 

_
