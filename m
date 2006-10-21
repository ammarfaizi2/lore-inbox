Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992840AbWJUHVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992840AbWJUHVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992845AbWJUHVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:21:11 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:22151 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992844AbWJUHNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:47 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 23] configfs: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <5b7b2321b65bc7f5ab04.1161411465@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:45 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, joel.becker@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the configfs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 11 insertions(+), 11 deletions(-)
fs/configfs/dir.c  |   10 +++++-----
fs/configfs/file.c |   12 ++++++------

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -980,7 +980,7 @@ int configfs_rename_dir(struct config_it
 
 static int configfs_dir_open(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct configfs_dirent * parent_sd = dentry->d_fsdata;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
@@ -993,7 +993,7 @@ static int configfs_dir_open(struct inod
 
 static int configfs_dir_close(struct inode *inode, struct file *file)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 	struct configfs_dirent * cursor = file->private_data;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
@@ -1013,7 +1013,7 @@ static inline unsigned char dt_type(stru
 
 static int configfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct configfs_dirent * parent_sd = dentry->d_fsdata;
 	struct configfs_dirent *cursor = filp->private_data;
 	struct list_head *p, *q = &cursor->s_sibling;
@@ -1070,7 +1070,7 @@ static int configfs_readdir(struct file 
 
 static loff_t configfs_dir_lseek(struct file * file, loff_t offset, int origin)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = file->f_path.dentry;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
 	switch (origin) {
@@ -1080,7 +1080,7 @@ static loff_t configfs_dir_lseek(struct 
 			if (offset >= 0)
 				break;
 		default:
-			mutex_unlock(&file->f_dentry->d_inode->i_mutex);
+			mutex_unlock(&file->f_path.dentry->d_inode->i_mutex);
 			return -EINVAL;
 	}
 	if (offset != file->f_pos) {
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -134,7 +134,7 @@ configfs_read_file(struct file *file, ch
 
 	down(&buffer->sem);
 	if (buffer->needs_read_fill) {
-		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
+		if ((retval = fill_read_buffer(file->f_path.dentry,buffer)))
 			goto out;
 	}
 	pr_debug("%s: count = %zd, ppos = %lld, buf = %s\n",
@@ -222,7 +222,7 @@ configfs_write_file(struct file *file, c
 	down(&buffer->sem);
 	len = fill_write_buffer(buffer, buf, count);
 	if (len > 0)
-		len = flush_write_buffer(file->f_dentry, buffer, count);
+		len = flush_write_buffer(file->f_path.dentry, buffer, count);
 	if (len > 0)
 		*ppos += len;
 	up(&buffer->sem);
@@ -231,8 +231,8 @@ configfs_write_file(struct file *file, c
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct config_item *item = configfs_get_config_item(file->f_dentry->d_parent);
-	struct configfs_attribute * attr = to_attr(file->f_dentry);
+	struct config_item *item = configfs_get_config_item(file->f_path.dentry->d_parent);
+	struct configfs_attribute * attr = to_attr(file->f_path.dentry);
 	struct configfs_buffer * buffer;
 	struct configfs_item_operations * ops = NULL;
 	int error = 0;
@@ -305,8 +305,8 @@ static int configfs_open_file(struct ino
 
 static int configfs_release(struct inode * inode, struct file * filp)
 {
-	struct config_item * item = to_item(filp->f_dentry->d_parent);
-	struct configfs_attribute * attr = to_attr(filp->f_dentry);
+	struct config_item * item = to_item(filp->f_path.dentry->d_parent);
+	struct configfs_attribute * attr = to_attr(filp->f_path.dentry);
 	struct module * owner = attr->ca_owner;
 	struct configfs_buffer * buffer = filp->private_data;
 


