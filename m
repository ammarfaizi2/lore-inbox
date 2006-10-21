Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992871AbWJUHQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992871AbWJUHQr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992875AbWJUHOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:52 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:30855 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992871AbWJUHOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 02 of 23] sysfs: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <6ecdf36e14de08c8fa3e.1161411447@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:27 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, gregkh@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the sysfs filesystem code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

3 files changed, 20 insertions(+), 20 deletions(-)
fs/sysfs/bin.c  |   14 +++++++-------
fs/sysfs/dir.c  |   10 +++++-----
fs/sysfs/file.c |   16 ++++++++--------

diff --git a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c
+++ b/fs/sysfs/bin.c
@@ -35,7 +35,7 @@ read(struct file * file, char __user * u
 read(struct file * file, char __user * userbuf, size_t count, loff_t * off)
 {
 	char *buffer = file->private_data;
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	int size = dentry->d_inode->i_size;
 	loff_t offs = *off;
 	int ret;
@@ -81,7 +81,7 @@ static ssize_t write(struct file * file,
 		     size_t count, loff_t * off)
 {
 	char *buffer = file->private_data;
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	int size = dentry->d_inode->i_size;
 	loff_t offs = *off;
 
@@ -105,7 +105,7 @@ static ssize_t write(struct file * file,
 
 static int mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	struct bin_attribute *attr = to_bin_attr(dentry);
 	struct kobject *kobj = to_kobj(dentry->d_parent);
 
@@ -117,8 +117,8 @@ static int mmap(struct file *file, struc
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
+	struct kobject *kobj = sysfs_get_kobject(file->f_path.dentry->d_parent);
+	struct bin_attribute * attr = to_bin_attr(file->f_path.dentry);
 	int error = -EINVAL;
 
 	if (!kobj || !attr)
@@ -153,8 +153,8 @@ static int open(struct inode * inode, st
 
 static int release(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = to_kobj(file->f_dentry->d_parent);
-	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
+	struct kobject * kobj = to_kobj(file->f_path.dentry->d_parent);
+	struct bin_attribute * attr = to_bin_attr(file->f_path.dentry);
 	u8 * buffer = file->private_data;
 
 	if (kobj) 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -374,7 +374,7 @@ int sysfs_rename_dir(struct kobject * ko
 
 static int sysfs_dir_open(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
@@ -387,7 +387,7 @@ static int sysfs_dir_open(struct inode *
 
 static int sysfs_dir_close(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct sysfs_dirent * cursor = file->private_data;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
@@ -407,7 +407,7 @@ static inline unsigned char dt_type(stru
 
 static int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
 	struct sysfs_dirent *cursor = filp->private_data;
 	struct list_head *p, *q = &cursor->s_sibling;
@@ -464,7 +464,7 @@ static int sysfs_readdir(struct file * f
 
 static loff_t sysfs_dir_lseek(struct file * file, loff_t offset, int origin)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
 	switch (origin) {
@@ -474,7 +474,7 @@ static loff_t sysfs_dir_lseek(struct fil
 			if (offset >= 0)
 				break;
 		default:
-			mutex_unlock(&file->f_dentry->d_inode->i_mutex);
+			mutex_unlock(&file->f_path.dentry->d_inode->i_mutex);
 			return -EINVAL;
 	}
 	if (offset != file->f_pos) {
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -154,7 +154,7 @@ sysfs_read_file(struct file *file, char 
 
 	down(&buffer->sem);
 	if (buffer->needs_read_fill) {
-		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
+		if ((retval = fill_read_buffer(file->f_path.dentry,buffer)))
 			goto out;
 	}
 	pr_debug("%s: count = %zd, ppos = %lld, buf = %s\n",
@@ -242,7 +242,7 @@ sysfs_write_file(struct file *file, cons
 	down(&buffer->sem);
 	len = fill_write_buffer(buffer, buf, count);
 	if (len > 0)
-		len = flush_write_buffer(file->f_dentry, buffer, len);
+		len = flush_write_buffer(file->f_path.dentry, buffer, len);
 	if (len > 0)
 		*ppos += len;
 	up(&buffer->sem);
@@ -251,8 +251,8 @@ sysfs_write_file(struct file *file, cons
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
-	struct attribute * attr = to_attr(file->f_dentry);
+	struct kobject *kobj = sysfs_get_kobject(file->f_path.dentry->d_parent);
+	struct attribute * attr = to_attr(file->f_path.dentry);
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -334,8 +334,8 @@ static int sysfs_open_file(struct inode 
 
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
-	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
-	struct attribute * attr = to_attr(filp->f_dentry);
+	struct kobject * kobj = to_kobj(filp->f_path.dentry->d_parent);
+	struct attribute * attr = to_attr(filp->f_path.dentry);
 	struct module * owner = attr->owner;
 	struct sysfs_buffer * buffer = filp->private_data;
 
@@ -369,8 +369,8 @@ static unsigned int sysfs_poll(struct fi
 static unsigned int sysfs_poll(struct file *filp, poll_table *wait)
 {
 	struct sysfs_buffer * buffer = filp->private_data;
-	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
-	struct sysfs_dirent * sd = filp->f_dentry->d_fsdata;
+	struct kobject * kobj = to_kobj(filp->f_path.dentry->d_parent);
+	struct sysfs_dirent * sd = filp->f_path.dentry->d_fsdata;
 	int res = 0;
 
 	poll_wait(filp, &kobj->poll, wait);


