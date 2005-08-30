Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVH3W6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVH3W6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVH3W6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:58:04 -0400
Received: from smtp.istop.com ([66.11.167.126]:5830 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932242AbVH3W6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:58:02 -0400
From: Daniel Phillips <phillips@istop.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 08:57:56 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Greg KH <greg@kroah.com>
References: <200508310854.40482.phillips@istop.com>
In-Reply-To: <200508310854.40482.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310857.57617.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs rearranged as a single file for analysis purposes.

diff -up --recursive 2.6.13-rc5-mm1.clean/fs/sysfs/Makefile 2.6.13-rc5-mm1/fs/sysfs/Makefile
--- 2.6.13-rc5-mm1.clean/fs/sysfs/Makefile 2005-06-17 15:48:29.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/sysfs/Makefile 2005-08-29 17:13:59.000000000 -0400
@@ -2,5 +2,4 @@
 # Makefile for the sysfs virtual filesystem
 #
 
-obj-y  := inode.o file.o dir.o symlink.o mount.o bin.o \
-     group.o
+obj-y := sysfs.o
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/sysfs/sysfs.c 2.6.13-rc5-mm1/fs/sysfs/sysfs.c
--- 2.6.13-rc5-mm1.clean/fs/sysfs/sysfs.c 2005-08-30 17:52:35.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/sysfs/sysfs.c 2005-08-29 21:04:40.000000000 -0400
@@ -0,0 +1,1680 @@
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/backing-dev.h>
+#include <linux/pagemap.h>
+#include <linux/fsnotify.h>
+
+struct sysfs_symlink {
+ char *link_name;
+ struct kobject *sl_target;
+};
+
+static inline struct kobject *to_kobj(struct dentry *dentry)
+{
+ struct sysfs_dirent *sd = dentry->d_fsdata;
+ return ((struct kobject *)sd->s_element);
+}
+
+static inline struct attribute *to_attr(struct dentry *dentry)
+{
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+	return ((struct attribute *)sd->s_element);
+}
+
+static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
+{
+	struct kobject *kobj = NULL;
+
+	spin_lock(&dcache_lock);
+	if (!d_unhashed(dentry)) {
+		struct sysfs_dirent *sd = dentry->d_fsdata;
+		if (sd->s_type & SYSFS_KOBJ_LINK) {
+			struct sysfs_symlink *sl = sd->s_element;
+			kobj = kobject_get(sl->sl_target);
+		} else
+			kobj = kobject_get(sd->s_element);
+	}
+	spin_unlock(&dcache_lock);
+
+	return kobj;
+}
+
+static kmem_cache_t *sysfs_dir_cachep;
+
+static void release_sysfs_dirent(struct sysfs_dirent *sd)
+{
+	if (sd->s_type & SYSFS_KOBJ_LINK) {
+		struct sysfs_symlink *sl = sd->s_element;
+		kfree(sl->link_name);
+		kobject_put(sl->sl_target);
+		kfree(sl);
+	}
+	kfree(sd->s_iattr);
+	kmem_cache_free(sysfs_dir_cachep, sd);
+}
+
+static struct sysfs_dirent *sysfs_get(struct sysfs_dirent *sd)
+{
+ if (sd) {
+  WARN_ON(!atomic_read(&sd->s_count));
+  atomic_inc(&sd->s_count);
+ }
+ return sd;
+}
+
+static void sysfs_put(struct sysfs_dirent *sd)
+{
+ WARN_ON(!atomic_read(&sd->s_count));
+ if (atomic_dec_and_test(&sd->s_count))
+  release_sysfs_dirent(sd);
+}
+
+/*
+ * inode.c - basic inode and dentry operations.
+ */
+
+int sysfs_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+ struct inode *inode = dentry->d_inode;
+ struct sysfs_dirent *sd = dentry->d_fsdata;
+ struct iattr *sd_iattr;
+ unsigned int ia_valid = iattr->ia_valid;
+ int error;
+
+ if (!sd)
+  return -EINVAL;
+
+ sd_iattr = sd->s_iattr;
+
+ error = inode_change_ok(inode, iattr);
+ if (error)
+  return error;
+
+	error = inode_setattr(inode, iattr);
+	if (error)
+		return error;
+
+	if (!sd_iattr) {
+		/* setting attributes for the first time, allocate now */
+		sd_iattr = kmalloc(sizeof(struct iattr), GFP_KERNEL);
+		if (!sd_iattr)
+			return -ENOMEM;
+		/* assign default attributes */
+		memset(sd_iattr, 0, sizeof(struct iattr));
+		sd_iattr->ia_mode = sd->s_mode;
+		sd_iattr->ia_uid = 0;
+		sd_iattr->ia_gid = 0;
+		sd_iattr->ia_atime = sd_iattr->ia_mtime = sd_iattr->ia_ctime =
+		    CURRENT_TIME;
+		sd->s_iattr = sd_iattr;
+	}
+
+	/* attributes were changed atleast once in past */
+
+	if (ia_valid & ATTR_UID)
+		sd_iattr->ia_uid = iattr->ia_uid;
+	if (ia_valid & ATTR_GID)
+		sd_iattr->ia_gid = iattr->ia_gid;
+	if (ia_valid & ATTR_ATIME)
+		sd_iattr->ia_atime = timespec_trunc(iattr->ia_atime,
+						    inode->i_sb->s_time_gran);
+	if (ia_valid & ATTR_MTIME)
+		sd_iattr->ia_mtime = timespec_trunc(iattr->ia_mtime,
+          inode->i_sb->s_time_gran);
+ if (ia_valid & ATTR_CTIME)
+  sd_iattr->ia_ctime = timespec_trunc(iattr->ia_ctime,
+          inode->i_sb->s_time_gran);
+ if (ia_valid & ATTR_MODE) {
+  umode_t mode = iattr->ia_mode;
+
+  if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
+   mode &= ~S_ISGID;
+  sd_iattr->ia_mode = sd->s_mode = mode;
+ }
+
+ return error;
+}
+
+static struct inode_operations sysfs_inode_operations = {
+ .setattr = sysfs_setattr,
+};
+
+static struct super_block *sysfs_sb;
+
+static struct address_space_operations sysfs_aops = {
+ .readpage = simple_readpage,
+ .prepare_write = simple_prepare_write,
+ .commit_write = simple_commit_write
+};
+
+static struct backing_dev_info sysfs_backing_dev_info = {
+ .ra_pages = 0,  /* No readahead */
+ .capabilities = BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
+};
+
+static struct inode *sysfs_new_inode(mode_t mode, struct sysfs_dirent *sd)
+{
+ struct inode *inode = new_inode(sysfs_sb);
+	if (inode) {
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_mapping->a_ops = &sysfs_aops;
+		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
+		inode->i_op = &sysfs_inode_operations;
+
+		if (sd->s_iattr) {
+			/* sysfs_dirent has non-default attributes
+			 * get them for the new inode from persistent copy
+			 * in sysfs_dirent */
+			struct iattr *iattr = sd->s_iattr;
+			inode->i_mode = iattr->ia_mode;
+			inode->i_uid = iattr->ia_uid;
+			inode->i_gid = iattr->ia_gid;
+			inode->i_atime = iattr->ia_atime;
+			inode->i_mtime = iattr->ia_mtime;
+			inode->i_ctime = iattr->ia_ctime;
+		} else {
+			inode->i_mode = mode;
+			inode->i_uid = 0;
+			inode->i_gid = 0;
+			inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		}
+	}
+	return inode;
+}
+
+static int sysfs_create(struct dentry *dentry, int mode, int (*init) (struct inode *))
+{
+ int error = 0;
+ struct inode *inode = NULL;
+ if (dentry) {
+  if (!dentry->d_inode) {
+   struct sysfs_dirent *sd = dentry->d_fsdata;
+   if ((inode = sysfs_new_inode(mode, sd))) {
+    if (dentry->d_parent
+        && dentry->d_parent->d_inode) {
+     struct inode *p_inode =
+         dentry->d_parent->d_inode;
+     p_inode->i_mtime = p_inode->i_ctime =
+         CURRENT_TIME;
+    }
+    goto Proceed;
+   } else
+    error = -ENOMEM;
+  } else
+   error = -EEXIST;
+ } else
+  error = -ENOENT;
+ goto Done;
+
+      Proceed:
+ if (init)
+  error = init(inode);
+ if (!error) {
+  d_instantiate(dentry, inode);
+  if (S_ISDIR(mode)) /* pin only directory dentry in core */
+   dget(dentry);
+ } else
+  iput(inode);
+      Done:
+ return error;
+}
+
+/*
+ * Get the name for corresponding element represented by the given sysfs_dirent
+ */
+static const unsigned char *sysfs_get_name(struct sysfs_dirent *sd)
+{
+ struct attribute *attr;
+ struct bin_attribute *bin_attr;
+ struct sysfs_symlink *sl;
+
+ if (!sd || !sd->s_element)
+  BUG();
+
+ switch (sd->s_type) {
+ case SYSFS_DIR:
+  /* Always have a dentry so use that */
+  return sd->s_dentry->d_name.name;
+
+ case SYSFS_KOBJ_ATTR:
+  attr = sd->s_element;
+  return attr->name;
+
+ case SYSFS_KOBJ_BIN_ATTR:
+  bin_attr = sd->s_element;
+  return bin_attr->attr.name;
+
+ case SYSFS_KOBJ_LINK:
+  sl = sd->s_element;
+  return sl->link_name;
+ }
+ return NULL;
+}
+
+/*
+ * Unhashes the dentry corresponding to given sysfs_dirent
+ * Called with parent inode's i_sem held.
+ */
+static void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent)
+{
+	struct dentry *dentry = sd->s_dentry;
+
+	if (dentry) {
+		spin_lock(&dcache_lock);
+		spin_lock(&dentry->d_lock);
+		if (!(d_unhashed(dentry) && dentry->d_inode)) {
+			dget_locked(dentry);
+			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
+			spin_unlock(&dcache_lock);
+			simple_unlink(parent->d_inode, dentry);
+		} else {
+			spin_unlock(&dentry->d_lock);
+			spin_unlock(&dcache_lock);
+		}
+	}
+}
+
+static void sysfs_hash_and_remove(struct dentry *dir, const char *name)
+{
+	struct sysfs_dirent *sd;
+	struct sysfs_dirent *parent_sd = dir->d_fsdata;
+
+	down(&dir->d_inode->i_sem);
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		if (!strcmp(sysfs_get_name(sd), name)) {
+			list_del_init(&sd->s_sibling);
+			sysfs_drop_dentry(sd, dir);
+			sysfs_put(sd);
+			break;
+		}
+	}
+	up(&dir->d_inode->i_sem);
+}
+
+/*
+ * symlink.c - operations for sysfs symlinks.
+ */
+
+static int object_depth(struct kobject *kobj)
+{
+	struct kobject *p = kobj;
+	int depth = 0;
+	do {
+		depth++;
+	} while ((p = p->parent));
+	return depth;
+}
+
+static int object_path_length(struct kobject *kobj)
+{
+	struct kobject *p = kobj;
+	int length = 1;
+	do {
+  length += strlen(kobject_name(p)) + 1;
+  p = p->parent;
+ } while (p);
+ return length;
+}
+
+static void fill_object_path(struct kobject *kobj, char *buffer, int length)
+{
+ struct kobject *p;
+
+ --length;
+ for (p = kobj; p; p = p->parent) {
+  int cur = strlen(kobject_name(p));
+
+  /* back up enough to print this bus id with '/' */
+  length -= cur;
+  strncpy(buffer + length, kobject_name(p), cur);
+  *(buffer + --length) = '/';
+ }
+}
+
+static int sysfs_get_target_path(struct kobject *kobj, struct kobject *target, char *path)
+{
+ char *s;
+ int depth, size;
+
+ depth = object_depth(kobj);
+ size = object_path_length(target) + depth * 3 - 1;
+ if (size > PATH_MAX)
+  return -ENAMETOOLONG;
+
+ pr_debug("%s: depth = %d, size = %d\n", __FUNCTION__, depth, size);
+
+ for (s = path; depth--; s += 3)
+  strcpy(s, "../");
+
+	fill_object_path(target, path, size);
+	pr_debug("%s: path = '%s'\n", __FUNCTION__, path);
+
+	return 0;
+}
+
+DECLARE_RWSEM(sysfs_rename_sem);
+
+static int sysfs_getlink(struct dentry *dentry, char *path)
+{
+	struct kobject *kobj, *sl_target;
+	int error = 0;
+
+	kobj = sysfs_get_kobject(dentry->d_parent);
+	if (!kobj)
+		return -EINVAL;
+
+	sl_target = sysfs_get_kobject(dentry);
+	if (!sl_target) {
+		kobject_put(kobj);
+		return -EINVAL;
+	}
+
+	down_read(&sysfs_rename_sem);
+	error = sysfs_get_target_path(kobj, sl_target, path);
+	up_read(&sysfs_rename_sem);
+
+	kobject_put(kobj);
+	kobject_put(sl_target);
+	return error;
+
+}
+
+static int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int error = -ENOMEM;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	if (page)
+  error = sysfs_getlink(dentry, (char *)page);
+ nd_set_link(nd, error ? ERR_PTR(error) : (char *)page);
+ return 0;
+}
+
+static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+ char *page = nd_get_link(nd);
+ if (!IS_ERR(page))
+  free_page((unsigned long)page);
+}
+
+static struct inode_operations sysfs_symlink_inode_operations = {
+ .readlink = generic_readlink,
+ .follow_link = sysfs_follow_link,
+ .put_link = sysfs_put_link,
+};
+
+static int init_symlink(struct inode *inode)
+{
+ inode->i_op = &sysfs_symlink_inode_operations;
+ return 0;
+}
+
+/*
+ * file.c - operations for regular (text) files.
+ */
+
+#define to_subsys(k) container_of(k, struct subsystem, kset.kobj)
+#define to_sattr(a) container_of(a, struct subsys_attribute, attr)
+
+/*
+ * Subsystem file operations.
+ * These operations allow subsystems to have files that can be 
+ * read/written. 
+ */
+static ssize_t subsys_attr_show(struct kobject *kobj, struct attribute *attr,
+    char *page)
+{
+ struct subsystem *s = to_subsys(kobj);
+ struct subsys_attribute *sattr = to_sattr(attr);
+ ssize_t ret = -EIO;
+
+ if (sattr->show)
+  ret = sattr->show(s, page);
+ return ret;
+}
+
+static ssize_t subsys_attr_store(struct kobject *kobj, struct attribute *attr,
+     const char *page, size_t count)
+{
+ struct subsystem *s = to_subsys(kobj);
+ struct subsys_attribute *sattr = to_sattr(attr);
+ ssize_t ret = -EIO;
+
+ if (sattr->store)
+  ret = sattr->store(s, page, count);
+ return ret;
+}
+
+static struct sysfs_ops subsys_sysfs_ops = {
+ .show = subsys_attr_show,
+ .store = subsys_attr_store,
+};
+
+/*
+ * file.c - operations for regular (text) files.
+ */
+
+struct sysfs_buffer {
+	size_t count;
+	loff_t pos;
+	char *page;
+	struct sysfs_ops *ops;
+	struct semaphore sem;
+	int needs_read_fill;
+};
+
+/*
+ *	Allocate @buffer->page, if it hasn't been already, then call the
+ *	kobject's show() method to fill the buffer with this attribute's
+ *	data.  This is called only once, on the file's first read.
+ */
+static int fill_read_buffer(struct dentry *dentry, struct sysfs_buffer *buffer)
+{
+	struct attribute *attr = to_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+	struct sysfs_ops *ops = buffer->ops;
+	int ret = 0;
+	ssize_t count;
+
+	if (!buffer->page)
+		buffer->page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!buffer->page)
+		return -ENOMEM;
+
+	count = ops->show(kobj, attr, buffer->page);
+	buffer->needs_read_fill = 0;
+	BUG_ON(count > (ssize_t) PAGE_SIZE);
+	if (count >= 0)
+		buffer->count = count;
+	else
+		ret = count;
+	return ret;
+}
+
+/*
+ *	Copy the buffer we filled in fill_read_buffer() to userspace.
+ * This is done at the reader's leisure, copying and advancing
+ * the amount they specify each time.
+ * This may be called continuously until the buffer is empty.
+ */
+static int flush_read_buffer(struct sysfs_buffer *buffer, char __user *buf,
+        size_t count, loff_t *ppos)
+{
+ int error;
+
+ if (*ppos > buffer->count)
+  return 0;
+
+ if (count > (buffer->count - *ppos))
+  count = buffer->count - *ppos;
+
+ error = copy_to_user(buf, buffer->page + *ppos, count);
+ if (!error)
+  *ppos += count;
+ return error ? -EFAULT : count;
+}
+
+/*
+ * Allocate @buffer->page if it hasn't been already, then
+ * copy the user-supplied buffer into it.
+ */
+static int fill_write_buffer(struct sysfs_buffer *buffer, const char __user *buf,
+        size_t count)
+{
+ int error;
+
+ if (!buffer->page)
+  buffer->page = (char *)get_zeroed_page(GFP_KERNEL);
+ if (!buffer->page)
+  return -ENOMEM;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	error = copy_from_user(buffer->page, buf, count);
+	buffer->needs_read_fill = 1;
+	return error ? -EFAULT : count;
+}
+
+/*
+ *	Get the correct pointers for the kobject and the attribute we're
+ *	dealing with, then call the store method for the attribute,
+ *	passing the buffer that we acquired in fill_write_buffer().
+ */
+static int flush_write_buffer(struct dentry *dentry, struct sysfs_buffer *buffer,
+			      size_t count)
+{
+	struct attribute *attr = to_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+	struct sysfs_ops *ops = buffer->ops;
+
+	return ops->store(kobj, attr, buffer->page, count);
+}
+
+static int check_perm(struct inode *inode, struct file *file)
+{
+	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
+	struct attribute *attr = to_attr(file->f_dentry);
+	struct sysfs_buffer *buffer;
+	struct sysfs_ops *ops = NULL;
+	int error = 0;
+
+	if (!kobj || !attr)
+		goto Einval;
+
+	/* Grab the module reference for this attribute if we have one */
+	if (!try_module_get(attr->owner)) {
+		error = -ENODEV;
+		goto Done;
+	}
+
+	/* if the kobject has no ktype, then we assume that it is a subsystem
+	 * itself, and use ops for it.
+	 */
+	if (kobj->kset && kobj->kset->ktype)
+		ops = kobj->kset->ktype->sysfs_ops;
+	else if (kobj->ktype)
+		ops = kobj->ktype->sysfs_ops;
+	else
+		ops = &subsys_sysfs_ops;
+
+	/* No sysfs operations, either from having no subsystem,
+	 * or the subsystem have no operations.
+	 */
+	if (!ops)
+		goto Eaccess;
+
+	/* File needs write support.
+	 * The inode's perms must say it's ok, and we must have a store method.
+	 */
+	if (file->f_mode & FMODE_WRITE) {
+
+		if (!(inode->i_mode & S_IWUGO) || !ops->store)
+			goto Eaccess;
+
+	}
+
+	/* File needs read support.
+	 * The inode's perms must say it's ok, and we there
+	 * must be a show method for it.
+	 */
+	if (file->f_mode & FMODE_READ) {
+		if (!(inode->i_mode & S_IRUGO) || !ops->show)
+			goto Eaccess;
+	}
+
+	/* No error? Great, allocate a buffer for the file, and store it
+	 * it in file->private_data for easy access.
+	 */
+	buffer = kmalloc(sizeof(struct sysfs_buffer), GFP_KERNEL);
+	if (buffer) {
+		memset(buffer, 0, sizeof(struct sysfs_buffer));
+		init_MUTEX(&buffer->sem);
+  buffer->needs_read_fill = 1;
+  buffer->ops = ops;
+  file->private_data = buffer;
+ } else
+  error = -ENOMEM;
+ goto Done;
+
+      Einval:
+ error = -EINVAL;
+ goto Done;
+      Eaccess:
+ error = -EACCES;
+ module_put(attr->owner);
+      Done:
+ if (error && kobj)
+  kobject_put(kobj);
+ return error;
+}
+
+/*
+ * Userspace wants to read an attribute file. The attribute descriptor
+ * is in the file's ->d_fsdata. The target object is in the directory's
+ * ->d_fsdata.
+ *
+ * We call fill_read_buffer() to allocate and fill the buffer from the
+ * object's show() method exactly once (if the read is happening from
+ * the beginning of the file). That should fill the entire buffer with
+ * all the data the object has to offer for that attribute.
+ * We then call flush_read_buffer() to copy the buffer to userspace
+ * in the increments specified.
+ */
+static ssize_t sysfs_read_file(struct file *file, char __user *buf,
+          size_t count, loff_t *ppos)
+{
+ struct sysfs_buffer *buffer = file->private_data;
+ ssize_t retval = 0;
+
+	down(&buffer->sem);
+	if (buffer->needs_read_fill) {
+		if ((retval = fill_read_buffer(file->f_dentry, buffer)))
+			goto out;
+	}
+	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
+		 __FUNCTION__, count, *ppos, buffer->page);
+	retval = flush_read_buffer(buffer, buf, count, ppos);
+      out:
+	up(&buffer->sem);
+	return retval;
+}
+
+/*
+ *	Similar to sysfs_read_file(), though working in the opposite direction.
+ *	We allocate and fill the data from the user in fill_write_buffer(),
+ *	then push it to the kobject in flush_write_buffer().
+ *	There is no easy way for us to know if userspace is only doing a partial
+ *	write, so we don't support them. We expect the entire buffer to come
+ *	on the first write.
+ *	Hint: if you're writing a value, first read the file, modify only the
+ *	the value you're changing, then write entire buffer back.
+ */
+static ssize_t sysfs_write_file(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct sysfs_buffer *buffer = file->private_data;
+
+	down(&buffer->sem);
+ count = fill_write_buffer(buffer, buf, count);
+ if (count > 0)
+  count = flush_write_buffer(file->f_dentry, buffer, count);
+ if (count > 0)
+  *ppos += count;
+ up(&buffer->sem);
+ return count;
+}
+
+static int sysfs_open_file(struct inode *inode, struct file *filp)
+{
+ return check_perm(inode, filp);
+}
+
+static int sysfs_release(struct inode *inode, struct file *filp)
+{
+ struct kobject *kobj = to_kobj(filp->f_dentry->d_parent);
+ struct attribute *attr = to_attr(filp->f_dentry);
+ struct module *owner = attr->owner;
+ struct sysfs_buffer *buffer = filp->private_data;
+
+ if (kobj)
+  kobject_put(kobj);
+ /* After this point, attr should not be accessed. */
+ module_put(owner);
+
+ if (buffer) {
+  if (buffer->page)
+   free_page((unsigned long)buffer->page);
+  kfree(buffer);
+ }
+ return 0;
+}
+
+static struct file_operations sysfs_file_operations = {
+ .read = sysfs_read_file,
+ .write = sysfs_write_file,
+ .llseek = generic_file_llseek,
+ .open = sysfs_open_file,
+ .release = sysfs_release,
+};
+
+static int init_file(struct inode *inode)
+{
+ inode->i_size = PAGE_SIZE;
+ inode->i_fop = &sysfs_file_operations;
+ return 0;
+}
+
+static void sysfs_d_iput(struct dentry *dentry, struct inode *inode)
+{
+ struct sysfs_dirent *sd = dentry->d_fsdata;
+
+ if (sd) {
+  BUG_ON(sd->s_dentry != dentry);
+  sd->s_dentry = NULL;
+  sysfs_put(sd);
+ }
+ iput(inode);
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+ .d_iput = sysfs_d_iput,
+};
+
+/*
+ * Allocates a new sysfs_dirent and links it to the parent sysfs_dirent
+ */
+static struct sysfs_dirent *sysfs_new_dirent(struct sysfs_dirent *parent_sd,
+					     void *element)
+{
+	struct sysfs_dirent *sd;
+
+ sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
+ if (!sd)
+  return NULL;
+
+ memset(sd, 0, sizeof(*sd));
+ atomic_set(&sd->s_count, 1);
+ INIT_LIST_HEAD(&sd->s_children);
+ list_add(&sd->s_sibling, &parent_sd->s_children);
+ sd->s_element = element;
+
+ return sd;
+}
+
+int sysfs_make_dirent(struct sysfs_dirent *parent_sd, struct dentry *dentry,
+ void *element, umode_t mode, int type)
+{
+ struct sysfs_dirent *sd;
+
+ sd = sysfs_new_dirent(parent_sd, element);
+ if (!sd)
+  return -ENOMEM;
+
+ sd->s_mode = mode;
+ sd->s_type = type;
+ sd->s_dentry = dentry;
+ if (dentry) {
+  dentry->d_fsdata = sysfs_get(sd);
+  dentry->d_op = &sysfs_dentry_ops;
+ }
+
+ return 0;
+}
+
+static int sysfs_add_file(struct dentry *dir, const struct attribute *attr, int type)
+{
+ struct sysfs_dirent *parent_sd = dir->d_fsdata;
+ umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
+ int error = 0;
+
+ down(&dir->d_inode->i_sem);
+ error = sysfs_make_dirent(parent_sd, NULL, (void *)attr, mode, type);
+ up(&dir->d_inode->i_sem);
+
+ return error;
+}
+
+int sysfs_create_file(struct kobject *kobj, const struct attribute *attr)
+{
+ BUG_ON(!kobj || !kobj->dentry || !attr);
+
+ return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
+}
+
+static int sysfs_add_link(struct dentry *parent, const char *name, struct kobject *target)
+{
+ struct sysfs_dirent *parent_sd = parent->d_fsdata;
+ struct sysfs_symlink *sl;
+ int error = 0;
+
+ error = -ENOMEM;
+ sl = kmalloc(sizeof(*sl), GFP_KERNEL);
+ if (!sl)
+  goto exit1;
+
+ sl->link_name = kmalloc(strlen(name) + 1, GFP_KERNEL);
+ if (!sl->link_name)
+  goto exit2;
+
+ strcpy(sl->link_name, name);
+ sl->sl_target = kobject_get(target);
+
+	error = sysfs_make_dirent(parent_sd, NULL, sl, S_IFLNK | S_IRWXUGO,
+				  SYSFS_KOBJ_LINK);
+	if (!error)
+		return 0;
+
+	kfree(sl->link_name);
+      exit2:
+	kfree(sl);
+      exit1:
+ return error;
+}
+
+/*
+ * dir.c - Operations for directories.
+ */
+
+static int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+ struct dentry *dentry = file->f_dentry;
+ struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+
+ down(&dentry->d_inode->i_sem);
+ file->private_data = sysfs_new_dirent(parent_sd, NULL);
+ up(&dentry->d_inode->i_sem);
+
+ return file->private_data ? 0 : -ENOMEM;
+}
+
+static int sysfs_dir_close(struct inode *inode, struct file *file)
+{
+ struct dentry *dentry = file->f_dentry;
+ struct sysfs_dirent *cursor = file->private_data;
+
+ down(&dentry->d_inode->i_sem);
+ list_del_init(&cursor->s_sibling);
+ up(&dentry->d_inode->i_sem);
+
+ release_sysfs_dirent(cursor);
+
+ return 0;
+}
+
+/* Relationship between s_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct sysfs_dirent *sd)
+{
+ return (sd->s_mode >> 12) & 15;
+}
+
+static int sysfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+ struct dentry *dentry = filp->f_dentry;
+ struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+ struct sysfs_dirent *cursor = filp->private_data;
+ struct list_head *p, *q = &cursor->s_sibling;
+ ino_t ino;
+ int i = filp->f_pos;
+
+ switch (i) {
+ case 0:
+  ino = dentry->d_inode->i_ino;
+  if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+   break;
+  filp->f_pos++;
+  i++;
+  /* fallthrough */
+ case 1:
+  ino = parent_ino(dentry);
+  if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+   break;
+  filp->f_pos++;
+  i++;
+  /* fallthrough */
+ default:
+  if (filp->f_pos == 2) {
+   list_del(q);
+   list_add(q, &parent_sd->s_children);
+  }
+  for (p = q->next; p != &parent_sd->s_children; p = p->next) {
+   struct sysfs_dirent *next;
+   const char *name;
+   int len;
+
+   next = list_entry(p, struct sysfs_dirent, s_sibling);
+   if (!next->s_element)
+    continue;
+
+   name = sysfs_get_name(next);
+   len = strlen(name);
+   if (next->s_dentry)
+    ino = next->s_dentry->d_inode->i_ino;
+   else
+    ino = iunique(sysfs_sb, 2);
+
+   if (filldir(dirent, name, len, filp->f_pos, ino,
+        dt_type(next)) < 0)
+    return 0;
+
+   list_del(q);
+   list_add(q, p);
+   p = q;
+   filp->f_pos++;
+  }
+ }
+ return 0;
+}
+
+static loff_t sysfs_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+ struct dentry *dentry = file->f_dentry;
+
+ down(&dentry->d_inode->i_sem);
+ switch (origin) {
+ case 1:
+  offset += file->f_pos;
+ case 0:
+  if (offset >= 0)
+   break;
+ default:
+  up(&file->f_dentry->d_inode->i_sem);
+  return -EINVAL;
+ }
+ if (offset != file->f_pos) {
+  file->f_pos = offset;
+  if (file->f_pos >= 2) {
+			struct sysfs_dirent *sd = dentry->d_fsdata;
+			struct sysfs_dirent *cursor = file->private_data;
+			struct list_head *p;
+			loff_t n = file->f_pos - 2;
+
+			list_del(&cursor->s_sibling);
+			p = sd->s_children.next;
+			while (n && p != &sd->s_children) {
+				struct sysfs_dirent *next;
+				next = list_entry(p, struct sysfs_dirent,
+						  s_sibling);
+				if (next->s_element)
+					n--;
+				p = p->next;
+			}
+			list_add_tail(&cursor->s_sibling, p);
+		}
+	}
+	up(&dentry->d_inode->i_sem);
+	return offset;
+}
+
+static struct file_operations sysfs_dir_operations = {
+	.open = sysfs_dir_open,
+	.release = sysfs_dir_close,
+	.llseek = sysfs_dir_lseek,
+	.read = generic_read_dir,
+	.readdir = sysfs_readdir,
+};
+
+/*
+ * bin.c - binary file operations for sysfs.
+ *
+ * Copyright (c) 2003 Patrick Mochel
+ * Copyright (c) 2003 Matthew Wilcox
+ * Copyright (c) 2004 Silicon Graphics, Inc.
+ */
+
+static inline struct bin_attribute *to_bin_attr(struct dentry *dentry)
+{
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+	return ((struct bin_attribute *)sd->s_element);
+}
+
+static int fill_read(struct dentry *dentry, char *buffer, loff_t off,
+		     size_t count)
+{
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+
+	if (!attr->read)
+  return -EIO;
+
+ return attr->read(kobj, buffer, off, count);
+}
+
+static ssize_t read(struct file *file, char __user *userbuf, size_t count, loff_t *off)
+{
+ char *buffer = file->private_data;
+ struct dentry *dentry = file->f_dentry;
+ int size = dentry->d_inode->i_size;
+ loff_t offs = *off;
+ int ret;
+
+ if (count > PAGE_SIZE)
+  count = PAGE_SIZE;
+
+ if (size) {
+  if (offs > size)
+   return 0;
+  if (offs + count > size)
+   count = size - offs;
+ }
+
+ ret = fill_read(dentry, buffer, offs, count);
+ if (ret < 0)
+  return ret;
+ count = ret;
+
+ if (copy_to_user(userbuf, buffer, count))
+  return -EFAULT;
+
+ pr_debug("offs = %lld, *off = %lld, count = %zd\n", offs, *off, count);
+
+ *off = offs + count;
+
+ return count;
+}
+
+static int flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
+{
+ struct bin_attribute *attr = to_bin_attr(dentry);
+ struct kobject *kobj = to_kobj(dentry->d_parent);
+
+ if (!attr->write)
+  return -EIO;
+
+ return attr->write(kobj, buffer, offset, count);
+}
+
+static ssize_t write(struct file *file, const char __user *userbuf, size_t count, loff_t *off)
+{
+ char *buffer = file->private_data;
+ struct dentry *dentry = file->f_dentry;
+ int size = dentry->d_inode->i_size;
+ loff_t offs = *off;
+
+ if (count > PAGE_SIZE)
+  count = PAGE_SIZE;
+ if (size) {
+  if (offs > size)
+   return 0;
+  if (offs + count > size)
+   count = size - offs;
+ }
+
+ if (copy_from_user(buffer, userbuf, count))
+  return -EFAULT;
+
+ count = flush_write(dentry, buffer, offs, count);
+ if (count > 0)
+  *off = offs + count;
+ return count;
+}
+
+static int mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+
+	if (!attr->mmap)
+		return -EINVAL;
+
+	return attr->mmap(kobj, attr, vma);
+}
+
+static int open(struct inode *inode, struct file *file)
+{
+	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
+	struct bin_attribute *attr = to_bin_attr(file->f_dentry);
+	int error = -EINVAL;
+
+	if (!kobj || !attr)
+  goto Done;
+
+ /* Grab the module reference for this attribute if we have one */
+ error = -ENODEV;
+ if (!try_module_get(attr->attr.owner))
+  goto Done;
+
+ error = -EACCES;
+ if ((file->f_mode & FMODE_WRITE) && !(attr->write || attr->mmap))
+  goto Error;
+ if ((file->f_mode & FMODE_READ) && !(attr->read || attr->mmap))
+  goto Error;
+
+ error = -ENOMEM;
+ file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+ if (!file->private_data)
+  goto Error;
+
+ error = 0;
+ goto Done;
+
+      Error:
+ module_put(attr->attr.owner);
+      Done:
+ if (error && kobj)
+  kobject_put(kobj);
+ return error;
+}
+
+static int release(struct inode *inode, struct file *file)
+{
+ struct kobject *kobj = to_kobj(file->f_dentry->d_parent);
+ struct bin_attribute *attr = to_bin_attr(file->f_dentry);
+ u8 *buffer = file->private_data;
+
+	if (kobj)
+		kobject_put(kobj);
+	module_put(attr->attr.owner);
+	kfree(buffer);
+	return 0;
+}
+
+struct file_operations bin_fops = {
+	.read = read,
+	.write = write,
+	.mmap = mmap,
+	.llseek = generic_file_llseek,
+	.open = open,
+	.release = release,
+};
+
+int sysfs_create_bin_file(struct kobject *kobj, struct bin_attribute *attr)
+{
+	BUG_ON(!kobj || !kobj->dentry || !attr);
+
+	return sysfs_add_file(kobj->dentry, &attr->attr, SYSFS_KOBJ_BIN_ATTR);
+}
+
+int sysfs_remove_bin_file(struct kobject *kobj, struct bin_attribute *attr)
+{
+	sysfs_hash_and_remove(kobj->dentry, attr->attr.name);
+	return 0;
+}
+
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the
+ * attribute file
+ */
+static int sysfs_attach_attr(struct sysfs_dirent *sd, struct dentry *dentry)
+{
+	struct attribute *attr = NULL;
+	struct bin_attribute *bin_attr = NULL;
+	int (*init) (struct inode *) = NULL;
+	int error = 0;
+
+	if (sd->s_type & SYSFS_KOBJ_BIN_ATTR) {
+		bin_attr = sd->s_element;
+		attr = &bin_attr->attr;
+	} else {
+		attr = sd->s_element;
+		init = init_file;
+	}
+
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
+	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
+	if (error) {
+  sysfs_put(sd);
+  return error;
+ }
+
+ if (bin_attr) {
+  dentry->d_inode->i_size = bin_attr->size;
+  dentry->d_inode->i_fop = &bin_fops;
+ }
+ dentry->d_op = &sysfs_dentry_ops;
+ d_rehash(dentry);
+
+ return 0;
+}
+
+static int sysfs_attach_link(struct sysfs_dirent *sd, struct dentry *dentry)
+{
+ int err = 0;
+
+ dentry->d_fsdata = sysfs_get(sd);
+ sd->s_dentry = dentry;
+ err = sysfs_create(dentry, S_IFLNK | S_IRWXUGO, init_symlink);
+ if (!err) {
+  dentry->d_op = &sysfs_dentry_ops;
+  d_rehash(dentry);
+ } else
+  sysfs_put(sd);
+
+ return err;
+}
+
+static struct dentry *sysfs_lookup(struct inode *dir, struct dentry *dentry,
+       struct nameidata *nd)
+{
+ struct sysfs_dirent *parent_sd = dentry->d_parent->d_fsdata;
+ struct sysfs_dirent *sd;
+ int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & SYSFS_NOT_PINNED) {
+			const unsigned char *name = sysfs_get_name(sd);
+
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+
+			if (sd->s_type & SYSFS_KOBJ_LINK)
+				err = sysfs_attach_link(sd, dentry);
+			else
+				err = sysfs_attach_attr(sd, dentry);
+			break;
+		}
+	}
+
+	return ERR_PTR(err);
+}
+
+struct inode_operations sysfs_dir_inode_operations = {
+	.lookup = sysfs_lookup,
+	.setattr = sysfs_setattr,
+};
+
+static int init_dir(struct inode *inode)
+{
+	inode->i_op = &sysfs_dir_inode_operations;
+ inode->i_fop = &sysfs_dir_operations;
+
+ /* directory inodes start off with i_nlink == 2 (for "." entry) */
+ inode->i_nlink++;
+ return 0;
+}
+
+static int create_dir(struct kobject *k, struct dentry *p, const char *n, struct dentry **d)
+{
+ int error;
+ umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+ down(&p->d_inode->i_sem);
+ *d = lookup_one_len(n, p, strlen(n));
+ if (!IS_ERR(*d)) {
+  error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
+  if (!error) {
+   error = sysfs_create(*d, mode, init_dir);
+   if (!error) {
+    p->d_inode->i_nlink++;
+    (*d)->d_op = &sysfs_dentry_ops;
+    d_rehash(*d);
+   }
+  }
+  if (error && (error != -EEXIST)) {
+   sysfs_put((*d)->d_fsdata);
+   d_drop(*d);
+  }
+  dput(*d);
+ } else
+  error = PTR_ERR(*d);
+ up(&p->d_inode->i_sem);
+ return error;
+}
+
+int sysfs_create_subdir(struct kobject *k, const char *n, struct dentry **d)
+{
+	return create_dir(k, k->dentry, n, d);
+}
+
+struct vfsmount *sysfs_mount;
+
+int sysfs_create_dir(struct kobject *kobj)
+{
+	struct dentry *dentry = NULL;
+	struct dentry *parent;
+	int error = 0;
+
+	BUG_ON(!kobj);
+
+	if (kobj->parent)
+		parent = kobj->parent->dentry;
+	else if (sysfs_mount && sysfs_mount->mnt_sb)
+		parent = sysfs_mount->mnt_sb->s_root;
+	else
+		return -EFAULT;
+
+	error = create_dir(kobj, parent, kobject_name(kobj), &dentry);
+	if (!error)
+		kobj->dentry = dentry;
+	return error;
+}
+
+static void remove_dir(struct dentry *d)
+{
+	struct dentry *parent = dget(d->d_parent);
+	struct sysfs_dirent *sd;
+
+	down(&parent->d_inode->i_sem);
+	d_delete(d);
+	sd = d->d_fsdata;
+	list_del_init(&sd->s_sibling);
+	sysfs_put(sd);
+	if (d->d_inode)
+		simple_rmdir(parent->d_inode, d);
+
+	pr_debug(" o %s removing done (%d)\n", d->d_name.name, atomic_read(&d->d_count));
+
+ up(&parent->d_inode->i_sem);
+ dput(parent);
+}
+
+void sysfs_remove_subdir(struct dentry *d)
+{
+ remove_dir(d);
+}
+
+/*
+ * sysfs_remove_dir - remove a kobject's directory.
+ * @kobj: object. 
+ *
+ * The only thing special about this is that we remove any files in 
+ * the directory before we remove the directory.
+ */
+void sysfs_remove_dir(struct kobject *kobj)
+{
+ struct dentry *dentry = dget(kobj->dentry);
+ struct sysfs_dirent *parent_sd;
+ struct sysfs_dirent *sd, *tmp;
+
+ if (!dentry)
+  return;
+
+ pr_debug("sysfs %s: removing dir\n", dentry->d_name.name);
+ down(&dentry->d_inode->i_sem);
+ parent_sd = dentry->d_fsdata;
+ list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+  if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
+   continue;
+  list_del_init(&sd->s_sibling);
+  sysfs_drop_dentry(sd, dentry);
+  sysfs_put(sd);
+ }
+	up(&dentry->d_inode->i_sem);
+
+	remove_dir(dentry);
+	/* Drop reference from dget() on entrance. */
+	dput(dentry);
+}
+
+int sysfs_rename_dir(struct kobject *kobj, const char *new_name)
+{
+ int error = 0;
+ struct dentry *new_dentry, *parent;
+
+ if (!strcmp(kobject_name(kobj), new_name))
+  return -EINVAL;
+
+ if (!kobj->parent)
+  return -EINVAL;
+
+ down_write(&sysfs_rename_sem);
+ parent = kobj->parent->dentry;
+
+ down(&parent->d_inode->i_sem);
+
+ new_dentry = lookup_one_len(new_name, parent, strlen(new_name));
+ if (!IS_ERR(new_dentry)) {
+  if (!new_dentry->d_inode) {
+   error = kobject_set_name(kobj, "%s", new_name);
+   if (!error) {
+    d_add(new_dentry, NULL);
+    d_move(kobj->dentry, new_dentry);
+   } else
+    d_drop(new_dentry);
+  } else
+   error = -EEXIST;
+  dput(new_dentry);
+ }
+ up(&parent->d_inode->i_sem);
+ up_write(&sysfs_rename_sem);
+
+ return error;
+}
+
+/**
+ * sysfs_update_file - update the modified timestamp on an object attribute.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ */
+int sysfs_update_file(struct kobject *kobj, const struct attribute *attr)
+{
+	struct dentry *dir = kobj->dentry;
+	struct dentry *victim;
+	int res = -ENOENT;
+
+	down(&dir->d_inode->i_sem);
+	victim = lookup_one_len(attr->name, dir, strlen(attr->name));
+	if (!IS_ERR(victim)) {
+		/* make sure dentry is really there */
+		if (victim->d_inode &&
+		    (victim->d_parent->d_inode == dir->d_inode)) {
+			victim->d_inode->i_mtime = CURRENT_TIME;
+			fsnotify_modify(victim);
+
+			/**
+			 * Drop reference from initial sysfs_get_dentry().
+			 */
+			dput(victim);
+			res = 0;
+		} else
+			d_drop(victim);
+
+		/**
+		 * Drop the reference acquired from sysfs_get_dentry() above.
+		 */
+		dput(victim);
+	}
+	up(&dir->d_inode->i_sem);
+
+	return res;
+}
+
+/**
+ * sysfs_chmod_file - update the modified mode value on an object attribute.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @mode: file permissions.
+ *
+ */
+int sysfs_chmod_file(struct kobject *kobj, struct attribute *attr, mode_t mode)
+{
+	struct dentry *dir = kobj->dentry;
+	struct dentry *victim;
+	struct inode *inode;
+	struct iattr newattrs;
+	int res = -ENOENT;
+
+	down(&dir->d_inode->i_sem);
+	victim = lookup_one_len(attr->name, dir, strlen(attr->name));
+	if (!IS_ERR(victim)) {
+		if (victim->d_inode &&
+		    (victim->d_parent->d_inode == dir->d_inode)) {
+			inode = victim->d_inode;
+			down(&inode->i_sem);
+			newattrs.ia_mode = (mode & S_IALLUGO) |
+			    (inode->i_mode & ~S_IALLUGO);
+			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
+			res = notify_change(victim, &newattrs);
+			up(&inode->i_sem);
+		}
+		dput(victim);
+	}
+	up(&dir->d_inode->i_sem);
+
+	return res;
+}
+
+/**
+ *	sysfs_remove_file - remove an object attribute.
+ *	@kobj:	object we're acting for.
+ *	@attr:	attribute descriptor.
+ *
+ *	Hash the attribute name and kill the victim.
+ */
+void sysfs_remove_file(struct kobject *kobj, const struct attribute *attr)
+{
+	sysfs_hash_and_remove(kobj->dentry, attr->name);
+}
+
+/*
+ * fs/sysfs/group.c - Operations for adding/removing multiple files at once.
+ *
+ * Copyright (c) 2003 Patrick Mochel
+ * Copyright (c) 2003 Open Source Development Lab
+ *
+ * This file is released undert the GPL v2. 
+ *
+ */
+static void remove_files(struct dentry *dir, const struct attribute_group *grp)
+{
+ struct attribute *const *attr;
+
+ for (attr = grp->attrs; *attr; attr++)
+  sysfs_hash_and_remove(dir, (*attr)->name);
+}
+
+static int create_files(struct dentry *dir, const struct attribute_group *grp)
+{
+ struct attribute *const *attr;
+ int error = 0;
+
+ for (attr = grp->attrs; *attr && !error; attr++) {
+  error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
+ }
+ if (error)
+  remove_files(dir, grp);
+ return error;
+}
+
+int sysfs_create_group(struct kobject *kobj, const struct attribute_group *grp)
+{
+ struct dentry *dir;
+ int error;
+
+	BUG_ON(!kobj || !kobj->dentry);
+
+	if (grp->name) {
+		error = sysfs_create_subdir(kobj, grp->name, &dir);
+		if (error)
+			return error;
+	} else
+		dir = kobj->dentry;
+	dir = dget(dir);
+	if ((error = create_files(dir, grp))) {
+		if (grp->name)
+			sysfs_remove_subdir(dir);
+	}
+	dput(dir);
+	return error;
+}
+
+void sysfs_remove_group(struct kobject *kobj, const struct attribute_group *grp)
+{
+	struct dentry *dir;
+
+	if (grp->name)
+		dir = lookup_one_len(grp->name, kobj->dentry,
+				     strlen(grp->name));
+	else
+		dir = dget(kobj->dentry);
+
+ remove_files(dir, grp);
+ if (grp->name)
+  sysfs_remove_subdir(dir);
+ /* release the ref. taken in this routine */
+ dput(dir);
+}
+
+/*
+ * mount.c - operations for initializing and mounting
+ */
+
+#define SYSFS_MAGIC 0x62656572
+
+static struct super_operations sysfs_ops = {
+ .statfs = simple_statfs,
+ .drop_inode = generic_delete_inode,
+};
+
+static struct sysfs_dirent sysfs_root = {
+ .s_sibling = LIST_HEAD_INIT(sysfs_root.s_sibling),
+ .s_children = LIST_HEAD_INIT(sysfs_root.s_children),
+ .s_type = SYSFS_ROOT,
+};
+
+static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+ struct inode *inode;
+ struct dentry *root;
+
+ sb->s_blocksize = PAGE_CACHE_SIZE;
+ sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+ sb->s_magic = SYSFS_MAGIC;
+ sb->s_op = &sysfs_ops;
+ sb->s_time_gran = 1;
+ sysfs_sb = sb;
+
+ inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO, &sysfs_root);
+ if (inode) {
+  inode->i_op = &sysfs_dir_inode_operations;
+  inode->i_fop = &sysfs_dir_operations;
+  /* directory inodes start off with i_nlink == 2 (for "." entry) */
+  inode->i_nlink++;
+ } else {
+  pr_debug("sysfs: could not get root inode\n");
+  return -ENOMEM;
+ }
+
+ root = d_alloc_root(inode);
+ if (!root) {
+  pr_debug("%s: could not get root dentry!\n", __FUNCTION__);
+  iput(inode);
+  return -ENOMEM;
+ }
+ root->d_fsdata = &sysfs_root;
+ sb->s_root = root;
+ return 0;
+}
+
+static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
+ int flags, const char *dev_name, void *data)
+{
+ return get_sb_single(fs_type, flags, data, sysfs_fill_super);
+}
+
+static struct file_system_type sysfs_fs_type = {
+ .name = "sysfs",
+ .get_sb = sysfs_get_sb,
+ .kill_sb = kill_litter_super,
+};
+
+int __init sysfs_init(void)
+{
+ int err = -ENOMEM;
+
+ sysfs_dir_cachep = kmem_cache_create("sysfs_dir_cache",
+  sizeof(struct sysfs_dirent), 0, 0, NULL, NULL);
+ if (!sysfs_dir_cachep)
+  goto out;
+
+ err = register_filesystem(&sysfs_fs_type);
+ if (err)
+  goto out_err;
+ sysfs_mount = kern_mount(&sysfs_fs_type);
+ if (IS_ERR(sysfs_mount)) {
+  printk(KERN_ERR "sysfs: could not mount!\n");
+  err = PTR_ERR(sysfs_mount);
+  sysfs_mount = NULL;
+  unregister_filesystem(&sysfs_fs_type);
+  goto out_err;
+ }
+      out:
+ return err;
+      out_err:
+ kmem_cache_destroy(sysfs_dir_cachep);
+ sysfs_dir_cachep = NULL;
+ goto out;
+}
+
+/*
+ * sysfs_create_link - create symlink between two objects.
+ * @kobj: object whose directory we're creating the link in.
+ * @target: object we're pointing to.
+ * @name:  name of the symlink.
+ */
+int sysfs_create_link(struct kobject *kobj, struct kobject *target, const char *name)
+{
+ struct dentry *dentry = kobj->dentry;
+ int error = 0;
+
+ BUG_ON(!kobj || !kobj->dentry || !name);
+
+ down(&dentry->d_inode->i_sem);
+ error = sysfs_add_link(dentry, name, target);
+ up(&dentry->d_inode->i_sem);
+ return error;
+}
+
+void sysfs_remove_link(struct kobject *kobj, const char *name)
+{
+ sysfs_hash_and_remove(kobj->dentry, name);
+}
+
+EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
+EXPORT_SYMBOL_GPL(sysfs_remove_bin_file);
+EXPORT_SYMBOL_GPL(sysfs_create_dir);
+EXPORT_SYMBOL_GPL(sysfs_remove_dir);
+EXPORT_SYMBOL_GPL(sysfs_rename_dir);
+EXPORT_SYMBOL_GPL(sysfs_chmod_file);
+EXPORT_SYMBOL_GPL(sysfs_create_file);
+EXPORT_SYMBOL_GPL(sysfs_remove_file);
+EXPORT_SYMBOL_GPL(sysfs_update_file);
+EXPORT_SYMBOL_GPL(sysfs_create_group);
+EXPORT_SYMBOL_GPL(sysfs_remove_group);
+EXPORT_SYMBOL_GPL(sysfs_create_link);
+EXPORT_SYMBOL_GPL(sysfs_remove_link);

