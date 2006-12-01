Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162138AbWLAWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162138AbWLAWmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162145AbWLAWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:42:04 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:12521 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1162138AbWLAWmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:42:01 -0500
From: Oliver Neukum <oliver@neukum.org>
To: maneesh@in.ibm.com, gregkh@suse.com,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: race in sysfs between sysfs_remove_file() and read()/write() #2
User-Agent: KMail/1.8
MIME-Version: 1.0
Date: Fri, 1 Dec 2006 23:43:06 +0100
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7/KcF1FfIOJoAf9"
Message-Id: <200612012343.07251.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_7/KcF1FfIOJoAf9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Alan Stern has discovered a race in sysfs, whereby driver callbacks could be
called after sysfs_remove_file() has run. The attached patch should fix it.

It introduces a new data structure acting as a collection of all sysfs_buffers
associated with an attribute. Upon removal of an attribute the buffers are
marked orphaned and IO on them returns -ENODEV. Thus sysfs_remove_file()
makes sure that sysfs won't bother a driver after that call, making it safe
to free the associated data structures and to unload the driver.

	Regards
		Oliver

--Boundary-00=_7/KcF1FfIOJoAf9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sysfs2race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs2race.diff"

--- linux-2.6.19-rc6/fs/sysfs/file.c	2006-11-25 23:49:07.000000000 +0100
+++ sysfs/fs/sysfs/file.c	2006-12-01 09:47:24.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/poll.h>
+#include <linux/list.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -50,17 +51,29 @@
 	.store	= subsys_attr_store,
 };
 
+/**
+ *	add_to_collection - add buffer to a collection
+ *	@buffer:	buffer to be added
+ *	@node		inode of set to add to
+ */
 
-struct sysfs_buffer {
-	size_t			count;
-	loff_t			pos;
-	char			* page;
-	struct sysfs_ops	* ops;
-	struct semaphore	sem;
-	int			needs_read_fill;
-	int			event;
-};
+static inline void
+add_to_collection(struct sysfs_buffer *buffer, struct inode *node)
+{
+	struct sysfs_buffer_collection *set = node->i_private;
+
+	mutex_lock(&node->i_mutex);
+	list_add(&buffer->associates, &set->associates);
+	mutex_unlock(&node->i_mutex);
+}
 
+static inline void
+remove_from_collection(struct sysfs_buffer *buffer, struct inode *node)
+{
+	mutex_lock(&node->i_mutex);
+	list_del(&buffer->associates);
+	mutex_unlock(&node->i_mutex);
+}
 
 /**
  *	fill_read_buffer - allocate and fill buffer from object.
@@ -153,6 +166,10 @@
 	ssize_t retval = 0;
 
 	down(&buffer->sem);
+	if (buffer->orphaned) {
+		retval = -ENODEV;
+		goto out;
+	}
 	if (buffer->needs_read_fill) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
@@ -165,7 +182,6 @@
 	return retval;
 }
 
-
 /**
  *	fill_write_buffer - copy buffer from userspace.
  *	@buffer:	data buffer for file.
@@ -240,19 +256,25 @@
 	ssize_t len;
 
 	down(&buffer->sem);
+	if (buffer->orphaned) {
+		len = -ENODEV;
+		goto out;
+	}
 	len = fill_write_buffer(buffer, buf, count);
 	if (len > 0)
 		len = flush_write_buffer(file->f_dentry, buffer, len);
 	if (len > 0)
 		*ppos += len;
+out:
 	up(&buffer->sem);
 	return len;
 }
 
-static int check_perm(struct inode * inode, struct file * file)
+static int sysfs_open_file(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
 	struct attribute * attr = to_attr(file->f_dentry);
+	struct sysfs_buffer_collection *set;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
 	int error = 0;
@@ -282,6 +304,18 @@
 	if (!ops)
 		goto Eaccess;
 
+	/* make sure we have a collection to add our buffers to */
+	mutex_lock(&inode->i_mutex);
+	if (!(set = inode->i_private)) {
+		if (!(set = inode->i_private = kmalloc(sizeof(struct sysfs_buffer_collection), GFP_KERNEL))) {
+			error = -ENOMEM;
+			goto Done;
+		} else {
+			INIT_LIST_HEAD(&set->associates);
+		}
+	}
+	mutex_unlock(&inode->i_mutex);
+
 	/* File needs write support.
 	 * The inode's perms must say it's ok, 
 	 * and we must have a store method.
@@ -307,9 +341,11 @@
 	 */
 	buffer = kzalloc(sizeof(struct sysfs_buffer), GFP_KERNEL);
 	if (buffer) {
+		INIT_LIST_HEAD(&buffer->associates);
 		init_MUTEX(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
+		add_to_collection(buffer, inode);
 		file->private_data = buffer;
 	} else
 		error = -ENOMEM;
@@ -327,11 +363,6 @@
 	return error;
 }
 
-static int sysfs_open_file(struct inode * inode, struct file * filp)
-{
-	return check_perm(inode,filp);
-}
-
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
 	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
@@ -339,6 +370,8 @@
 	struct module * owner = attr->owner;
 	struct sysfs_buffer * buffer = filp->private_data;
 
+	if (buffer)
+		remove_from_collection(buffer, inode);
 	if (kobj) 
 		kobject_put(kobj);
 	/* After this point, attr should not be accessed. */
@@ -545,7 +578,9 @@
 
 void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr)
 {
-	sysfs_hash_and_remove(kobj->dentry,attr->name);
+	struct dentry *d = kobj->dentry;
+
+	sysfs_hash_and_remove(d, attr->name);
 }
 
 
--- linux-2.6.19-rc6/fs/sysfs/sysfs.h	2006-11-16 05:03:40.000000000 +0100
+++ sysfs/fs/sysfs/sysfs.h	2006-12-01 09:47:44.000000000 +0100
@@ -33,6 +33,22 @@
 	struct kobject * target_kobj;
 };
 
+struct sysfs_buffer {
+	struct list_head		associates;
+	size_t				count;
+	loff_t				pos;
+	char				* page;
+	struct sysfs_ops		* ops;
+	struct semaphore		sem;
+	int				orphaned;
+	int				needs_read_fill;
+	int				event;
+};
+
+struct sysfs_buffer_collection {
+	struct list_head	associates;
+};
+
 static inline struct kobject * to_kobj(struct dentry * dentry)
 {
 	struct sysfs_dirent * sd = dentry->d_fsdata;
@@ -95,4 +111,3 @@
 	if (atomic_dec_and_test(&sd->s_count))
 		release_sysfs_dirent(sd);
 }
-
--- linux-2.6.19-rc6/fs/sysfs/mount.c	2006-11-16 05:03:40.000000000 +0100
+++ sysfs/fs/sysfs/mount.c	2006-11-26 14:00:13.000000000 +0100
@@ -18,9 +18,12 @@
 struct super_block * sysfs_sb = NULL;
 kmem_cache_t *sysfs_dir_cachep;
 
+static void sysfs_clear_inode(struct inode *inode);
+
 static struct super_operations sysfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
+	.clear_inode	= sysfs_clear_inode,
 };
 
 static struct sysfs_dirent sysfs_root = {
@@ -31,6 +34,11 @@
 	.s_iattr	= NULL,
 };
 
+static void sysfs_clear_inode(struct inode *inode)
+{
+	kfree(inode->i_private);
+}
+
 static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
--- linux-2.6.19-rc6/fs/sysfs/inode.c	2006-11-16 05:03:40.000000000 +0100
+++ sysfs/fs/sysfs/inode.c	2006-12-01 09:48:11.000000000 +0100
@@ -209,6 +209,22 @@
 	return NULL;
 }
 
+static inline void orphan_all_buffers(struct inode *node)
+{
+	struct sysfs_buffer_collection *set = node->i_private;
+	struct sysfs_buffer *buf;
+
+	mutex_lock(&node->i_mutex);
+	if (node->i_private) {
+		list_for_each_entry(buf, &set->associates, associates) {
+			down(&buf->sem);
+			buf->orphaned = 1;
+			up(&buf->sem);
+		}
+	}
+	mutex_unlock(&node->i_mutex);
+}
+
 
 /*
  * Unhashes the dentry corresponding to given sysfs_dirent
@@ -217,16 +233,23 @@
 void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 {
 	struct dentry * dentry = sd->s_dentry;
+	struct inode *inode;
 
 	if (dentry) {
 		spin_lock(&dcache_lock);
 		spin_lock(&dentry->d_lock);
 		if (!(d_unhashed(dentry) && dentry->d_inode)) {
+			inode = dentry->d_inode;
+			spin_lock(&inode->i_lock);
+			__iget(inode);
+			spin_unlock(&inode->i_lock);
 			dget_locked(dentry);
 			__d_drop(dentry);
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			simple_unlink(parent->d_inode, dentry);
+			orphan_all_buffers(inode);
+			iput(inode);
 		} else {
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);

--Boundary-00=_7/KcF1FfIOJoAf9--
