Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268508AbUKAXRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268508AbUKAXRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276555AbUKAXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:17:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:10148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323714AbUKAV7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:23 -0500
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041101215418.GA16500@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:55 -0800
Message-Id: <10993462752326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2439, 2004/11/01 13:02:34-08:00, akpm@osdl.org

[PATCH] sysfs backing store - prepare sysfs_file_operations helpers

From: Maneesh Soni <maneesh@in.ibm.com>

o The following patch provides dumb helpers to access the corresponding
  kobject, attribute or binary attribute given a dentry and prepare the
  sysfs_file_operation methods for using sysfs_dirents.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/bin.c   |   14 +++++++-------
 fs/sysfs/file.c  |   24 ++++++++++++------------
 fs/sysfs/sysfs.h |   18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 20 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	2004-11-01 13:37:33 -08:00
+++ b/fs/sysfs/bin.c	2004-11-01 13:37:33 -08:00
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
@@ -60,8 +60,8 @@
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = dentry->d_fsdata;
-	struct kobject *kobj = dentry->d_parent->d_fsdata;
+	struct bin_attribute *attr = to_bin_attr(dentry->d_parent);
+	struct kobject *kobj = to_kobj(dentry);
 
 	return attr->write(kobj, buffer, offset, count);
 }
@@ -95,7 +95,7 @@
 static int open(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -130,8 +130,8 @@
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
-	struct bin_attribute * attr = file->f_dentry->d_fsdata;
+	struct kobject * kobj = to_kobj(file->f_dentry->d_parent);
+	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-01 13:37:33 -08:00
+++ b/fs/sysfs/file.c	2004-11-01 13:37:33 -08:00
@@ -67,7 +67,7 @@
 
 /**
  *	fill_read_buffer - allocate and fill buffer from object.
- *	@file:		file pointer.
+ *	@dentry:	dentry pointer.
  *	@buffer:	data buffer for file.
  *
  *	Allocate @buffer->page, if it hasn't been already, then call the
@@ -75,10 +75,10 @@
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
@@ -150,7 +150,7 @@
 	ssize_t retval = 0;
 
 	if (!*ppos) {
-		if ((retval = fill_read_buffer(file,buffer)))
+		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			return retval;
 	}
 	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
@@ -197,10 +197,10 @@
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
@@ -231,7 +231,7 @@
 
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
-		count = flush_write_buffer(file,buffer,count);
+		count = flush_write_buffer(file->f_dentry,buffer,count);
 	if (count > 0)
 		*ppos += count;
 	return count;
@@ -240,7 +240,7 @@
 static int check_perm(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct attribute * attr = to_attr(file->f_dentry);
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -321,8 +321,8 @@
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
-	struct attribute * attr = filp->f_dentry->d_fsdata;
+	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
+	struct attribute * attr = to_attr(filp->f_dentry);
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-01 13:37:33 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-01 13:37:33 -08:00
@@ -16,14 +16,30 @@
 extern void sysfs_put_link(struct dentry *, struct nameidata *);
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

