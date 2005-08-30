Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVH3W77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVH3W77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVH3W77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:59:59 -0400
Received: from smtp.istop.com ([66.11.167.126]:8390 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932264AbVH3W76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:59:58 -0400
From: Daniel Phillips <phillips@istop.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 08:59:55 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Greg KH <greg@kroah.com>
References: <200508310854.40482.phillips@istop.com> <200508310857.57617.phillips@istop.com>
In-Reply-To: <200508310857.57617.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310859.55746.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configfs rewritten as a single file and updated to use kobjects instead of its
own clone of kobjects (config_items).

diff -up --recursive 2.6.13-rc5-mm1.clean/fs/configfs/Makefile 2.6.13-rc5-mm1/fs/configfs/Makefile
--- 2.6.13-rc5-mm1.clean/fs/configfs/Makefile 2005-08-09 18:23:30.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/configfs/Makefile 2005-08-29 17:26:02.000000000 -0400
@@ -2,6 +2,5 @@
 # Makefile for the configfs virtual filesystem
 #
 
-obj-$(CONFIG_CONFIGFS_FS) += configfs.o
+obj-$(CONFIG_CONFIGFS_FS) += configfs.o ddbond.config.o
 
-configfs-objs := inode.o file.o dir.o symlink.o mount.o item.o
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/configfs/configfs.c 2.6.13-rc5-mm1/fs/configfs/configfs.c
--- 2.6.13-rc5-mm1.clean/fs/configfs/configfs.c 2005-08-30 17:50:30.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/configfs/configfs.c 2005-08-29 21:36:47.000000000 -0400
@@ -0,0 +1,1897 @@
+/*
+ * Based on sysfs:
+ *  sysfs Copyright (C) 2001, 2002, 2003 Patrick Mochel
+ *
+ * configfs Copyright (C) 2005 Oracle.  All rights reserved.
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/backing-dev.h>
+#include <linux/pagemap.h>
+#include <linux/configfs.h>
+
+#define CONFIGFS_ROOT  0x0001
+#define CONFIGFS_DIR  0x0002
+#define CONFIGFS_ITEM_ATTR 	0x0004
+#define CONFIGFS_ITEM_LINK 	0x0020
+#define CONFIGFS_USET_DIR	0x0040
+#define CONFIGFS_USET_DEFAULT	0x0080
+#define CONFIGFS_USET_DROPPING	0x0100
+#define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR)
+
+struct sysfs_symlink {
+	struct list_head sl_list;
+	struct kobject *sl_target;
+};
+
+static inline struct kobject *to_kobj(struct dentry *dentry)
+{
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+	return ((struct kobject *)sd->s_element);
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
+		if (sd->s_type & CONFIGFS_ITEM_LINK) {
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
+	if ((sd->s_type & CONFIGFS_ROOT))
+		return;
+	kmem_cache_free(sysfs_dir_cachep, sd);
+}
+
+static struct sysfs_dirent *sysfs_get(struct sysfs_dirent *sd)
+{
+	if (sd) {
+		WARN_ON(!atomic_read(&sd->s_count));
+		atomic_inc(&sd->s_count);
+	}
+	return sd;
+}
+
+static void sysfs_put(struct sysfs_dirent *sd)
+{
+	WARN_ON(!atomic_read(&sd->s_count));
+	if (atomic_dec_and_test(&sd->s_count))
+		release_sysfs_dirent(sd);
+}
+
+/*
+ * inode.c - basic inode and dentry operations.
+ */
+
+static struct super_block *sysfs_sb;
+
+static struct address_space_operations sysfs_aops = {
+	.readpage = simple_readpage,
+	.prepare_write = simple_prepare_write,
+	.commit_write = simple_commit_write
+};
+
+static struct backing_dev_info sysfs_backing_dev_info = {
+	.ra_pages = 0,		/* No readahead */
+	.capabilities = BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
+};
+
+static struct inode *sysfs_new_inode(mode_t mode)
+{
+	struct inode *inode = new_inode(sysfs_sb);
+	if (inode) {
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_mode = mode;
+		inode->i_uid = 0;
+		inode->i_gid = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mapping->a_ops = &sysfs_aops;
+		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
+	}
+	return inode;
+}
+
+static int sysfs_create(struct dentry *dentry, int mode, int (*init) (struct inode *))
+{
+	int error = 0;
+	struct inode *inode = NULL;
+	if (dentry) {
+		if (!dentry->d_inode) {
+			if ((inode = sysfs_new_inode(mode))) {
+				if (dentry->d_parent
+				    && dentry->d_parent->d_inode) {
+					struct inode *p_inode =
+					    dentry->d_parent->d_inode;
+					p_inode->i_mtime = p_inode->i_ctime =
+					    CURRENT_TIME;
+				}
+				goto Proceed;
+			} else
+				error = -ENOMEM;
+		} else
+			error = -EEXIST;
+	} else
+		error = -ENOENT;
+	goto Done;
+
+      Proceed:
+	if (init)
+		error = init(inode);
+	if (!error) {
+		d_instantiate(dentry, inode);
+		if (S_ISDIR(mode) || S_ISLNK(mode)) /* pin link and directory dentries */
+			dget(dentry);
+	} else
+		iput(inode);
+      Done:
+	return error;
+}
+
+/*
+ * Get the name for corresponding element represented by the given sysfs_dirent
+ */
+static const unsigned char *sysfs_get_name(struct sysfs_dirent *sd)
+{
+	if (!sd || !sd->s_element)
+		BUG();
+
+	/* These always have a dentry, so use that */
+	if (sd->s_type & (CONFIGFS_DIR | CONFIGFS_ITEM_LINK))
+		return sd->s_dentry->d_name.name;
+
+	if (sd->s_type & CONFIGFS_ITEM_ATTR)
+		return ((struct attribute *)sd->s_element)->name;
+	return NULL;
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
+		if (!(d_unhashed(dentry) && dentry->d_inode)) {
+			dget_locked(dentry);
+			__d_drop(dentry);
+			spin_unlock(&dcache_lock);
+			simple_unlink(parent->d_inode, dentry);
+		} else {
+			spin_unlock(&dcache_lock);
+		}
+	}
+}
+
+#if 0
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
+#endif
+
+static struct kset sysfs_root_group = {
+	.kobj = {
+		.name = "root",
+		.k_name = sysfs_root_group.kobj.name,
+	},
+};
+
+static int is_root(struct kobject *kobj)
+{
+	return kobj == &sysfs_root_group.kobj;
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
+	} while ((p = p->parent) && !is_root(p));
+	return depth;
+}
+
+static int object_path_length(struct kobject *kobj)
+{
+	struct kobject *p = kobj;
+	int length = 1;
+	do {
+		length += strlen(kobject_name(p)) + 1;
+		p = p->parent;
+	} while (p && !is_root(p));
+	return length;
+}
+
+static void fill_object_path(struct kobject *kobj, char *buffer, int length)
+{
+	struct kobject *p;
+
+	--length;
+	for (p = kobj; p && !is_root(p); p = p->parent) {
+		int cur = strlen(kobject_name(p));
+
+		/* back up enough to print this bus id with '/' */
+		length -= cur;
+		strncpy(buffer + length, kobject_name(p), cur);
+		*(buffer + --length) = '/';
+	}
+}
+
+static int sysfs_get_target_path(struct kobject *kobj, struct kobject *target, char *path)
+{
+	char *s;
+	int depth, size;
+
+	depth = object_depth(kobj);
+	size = object_path_length(target) + depth * 3 - 1;
+	if (size > PATH_MAX)
+		return -ENAMETOOLONG;
+
+	pr_debug("%s: depth = %d, size = %d\n", __FUNCTION__, depth, size);
+
+	for (s = path; depth--; s += 3)
+		strcpy(s, "../");
+
+	fill_object_path(target, path, size);
+	pr_debug("%s: path = '%s'\n", __FUNCTION__, path);
+
+	return 0;
+}
+
+static DECLARE_RWSEM(sysfs_rename_sem);
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
+		error = sysfs_getlink(dentry, (char *)page);
+	nd_set_link(nd, error ? ERR_PTR(error) : (char *)page);
+	return 0;
+}
+
+static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *page = nd_get_link(nd);
+	if (!IS_ERR(page))
+		free_page((unsigned long)page);
+}
+
+static struct inode_operations sysfs_symlink_inode_operations = {
+	.readlink = generic_readlink,
+	.follow_link = sysfs_follow_link,
+	.put_link = sysfs_put_link,
+};
+
+static int init_symlink(struct inode *inode)
+{
+	inode->i_op = &sysfs_symlink_inode_operations;
+	return 0;
+}
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
+ *	This is done at the reader's leisure, copying and advancing
+ *	the amount they specify each time.
+ *	This may be called continuously until the buffer is empty.
+ */
+static int flush_read_buffer(struct sysfs_buffer *buffer, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	int error;
+
+	if (*ppos > buffer->count)
+		return 0;
+
+	if (count > (buffer->count - *ppos))
+		count = buffer->count - *ppos;
+
+	error = copy_to_user(buf, buffer->page + *ppos, count);
+	if (!error)
+		*ppos += count;
+	return error ? -EFAULT : count;
+}
+
+/*
+ *	Allocate @buffer->page if it hasn't been already, then
+ *	copy the user-supplied buffer into it.
+ */
+static int fill_write_buffer(struct sysfs_buffer *buffer, const char __user *buf,
+			     size_t count)
+{
+	int error;
+
+	if (!buffer->page)
+		buffer->page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!buffer->page)
+		return -ENOMEM;
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
+	if (!kobj->ktype)
+		goto Eaccess;
+
+	ops = kobj->ktype->sysfs_ops;
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
+		buffer->needs_read_fill = 1;
+		buffer->ops = ops;
+		file->private_data = buffer;
+	} else
+		error = -ENOMEM;
+	goto Done;
+
+      Einval:
+	error = -EINVAL;
+	goto Done;
+      Eaccess:
+	error = -EACCES;
+	module_put(attr->owner);
+      Done:
+	if (error && kobj)
+		kobject_put(kobj);
+	return error;
+}
+
+/*
+ *	Userspace wants to read an attribute file. The attribute descriptor
+ *	is in the file's ->d_fsdata. The target object is in the directory's
+ *	->d_fsdata.
+ *
+ *	We call fill_read_buffer() to allocate and fill the buffer from the
+ *	object's show() method exactly once (if the read is happening from
+ *	the beginning of the file). That should fill the entire buffer with
+ *	all the data the object has to offer for that attribute.
+ *	We then call flush_read_buffer() to copy the buffer to userspace
+ *	in the increments specified.
+ */
+static ssize_t sysfs_read_file(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct sysfs_buffer *buffer = file->private_data;
+	ssize_t retval = 0;
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
+	count = fill_write_buffer(buffer, buf, count);
+	if (count > 0)
+		count = flush_write_buffer(file->f_dentry, buffer, count);
+	if (count > 0)
+		*ppos += count;
+	up(&buffer->sem);
+	return count;
+}
+
+static int sysfs_open_file(struct inode *inode, struct file *filp)
+{
+	return check_perm(inode, filp);
+}
+
+static int sysfs_release(struct inode *inode, struct file *filp)
+{
+	struct kobject *kobj = to_kobj(filp->f_dentry->d_parent);
+	struct attribute *attr = to_attr(filp->f_dentry);
+	struct module *owner = attr->owner;
+	struct sysfs_buffer *buffer = filp->private_data;
+
+	if (kobj)
+		kobject_put(kobj);
+	/* After this point, attr should not be accessed. */
+	module_put(owner);
+
+	if (buffer) {
+		if (buffer->page)
+			free_page((unsigned long)buffer->page);
+		kfree(buffer);
+	}
+	return 0;
+}
+
+static struct file_operations sysfs_file_operations = {
+	.read = sysfs_read_file,
+	.write = sysfs_write_file,
+	.llseek = generic_file_llseek,
+	.open = sysfs_open_file,
+	.release = sysfs_release,
+};
+
+static int init_file(struct inode *inode)
+{
+	inode->i_size = PAGE_SIZE;
+	inode->i_fop = &sysfs_file_operations;
+	return 0;
+}
+
+static void sysfs_d_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+
+	if (sd) {
+		BUG_ON(sd->s_dentry != dentry);
+		sd->s_dentry = NULL;
+		sysfs_put(sd);
+	}
+	iput(inode);
+}
+
+/*
+ * We _must_ delete our dentries on last dput, as the chain-to-parent
+ * behavior is required to clear the parents of default_groups.
+ */
+static int sysfs_d_delete(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations sysfs_dentry_ops = {
+	.d_iput = sysfs_d_iput,
+	.d_delete = sysfs_d_delete,
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
+	sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
+	if (!sd)
+		return NULL;
+
+	memset(sd, 0, sizeof(*sd));
+	atomic_set(&sd->s_count, 1);
+	INIT_LIST_HEAD(&sd->s_links);
+	INIT_LIST_HEAD(&sd->s_children);
+	list_add(&sd->s_sibling, &parent_sd->s_children);
+	sd->s_element = element;
+
+	return sd;
+}
+
+static int sysfs_make_dirent(struct sysfs_dirent *parent_sd, struct dentry *dentry,
+	void *element, umode_t mode, int type)
+{
+	struct sysfs_dirent *sd;
+
+	sd = sysfs_new_dirent(parent_sd, element);
+	if (!sd)
+		return -ENOMEM;
+
+	sd->s_mode = mode;
+	sd->s_type = type;
+	sd->s_dentry = dentry;
+	if (dentry) {
+		dentry->d_fsdata = sysfs_get(sd);
+		dentry->d_op = &sysfs_dentry_ops;
+	}
+
+	return 0;
+}
+
+static int sysfs_add_file(struct dentry *dir, const struct attribute *attr, int type)
+{
+	struct sysfs_dirent *parent_sd = dir->d_fsdata;
+	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
+	int error = 0;
+
+	down(&dir->d_inode->i_sem);
+	error = sysfs_make_dirent(parent_sd, NULL, (void *)attr, mode, type);
+	up(&dir->d_inode->i_sem);
+
+	return error;
+}
+
+static int configfs_create_file(struct kobject *kobj, const struct attribute *attr)
+{
+	BUG_ON(!kobj || !kobj->dentry || !attr);
+
+	return sysfs_add_file(kobj->dentry, attr, CONFIGFS_ITEM_ATTR);
+}
+
+static int configfs_add_link(struct sysfs_symlink *sl, struct dentry *parent, struct dentry *dentry)
+{
+	int err = 0;
+	umode_t mode = S_IFLNK | S_IRWXUGO;
+
+	err = sysfs_create(dentry, mode, init_symlink);
+	if (!err) {
+		err = sysfs_make_dirent(parent->d_fsdata, dentry, sl,
+					   mode, CONFIGFS_ITEM_LINK);
+		if (!err)
+			dentry->d_op = &sysfs_dentry_ops;
+	}
+	return err;
+}
+
+static int create_link(struct kobject *parent_kobj, struct kobject *kobj, struct dentry *dentry)
+{
+	struct sysfs_dirent *target_sd = kobj->dentry->d_fsdata;
+	struct sysfs_symlink *sl;
+	int ret;
+
+	ret = -ENOMEM;
+	sl = kmalloc(sizeof(struct sysfs_symlink), GFP_KERNEL);
+	if (sl) {
+		sl->sl_target = kobject_get(kobj);
+		/* FIXME: needs a lock, I'd bet */
+		list_add(&sl->sl_list, &target_sd->s_links);
+		ret = configfs_add_link(sl, parent_kobj->dentry, dentry);
+		if (ret) {
+			list_del_init(&sl->sl_list);
+			kobject_put(kobj);
+			kfree(sl);
+		}
+	}
+
+	return ret;
+}
+
+static int get_target(const char *symname, struct nameidata *nd, struct kobject **target)
+{
+	int ret;
+
+	ret = path_lookup(symname, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, nd);
+	if (!ret) {
+		if (nd->dentry->d_sb == sysfs_sb) {
+			*target = sysfs_get_kobject(nd->dentry);
+			if (!*target) {
+				ret = -ENOENT;
+				path_release(nd);
+			}
+		} else
+			ret = -EPERM;
+	}
+
+	return ret;
+}
+
+/*
+ * dir.c - Operations for directories.
+ */
+
+static int sysfs_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+
+	down(&dentry->d_inode->i_sem);
+	file->private_data = sysfs_new_dirent(parent_sd, NULL);
+	up(&dentry->d_inode->i_sem);
+
+	return file->private_data ? 0 : -ENOMEM;
+}
+
+static int sysfs_dir_close(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct sysfs_dirent *cursor = file->private_data;
+
+	down(&dentry->d_inode->i_sem);
+	list_del_init(&cursor->s_sibling);
+	up(&dentry->d_inode->i_sem);
+
+	release_sysfs_dirent(cursor);
+
+	return 0;
+}
+
+/* Relationship between s_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct sysfs_dirent *sd)
+{
+	return (sd->s_mode >> 12) & 15;
+}
+
+static int sysfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->s_sibling;
+	ino_t ino;
+	int i = filp->f_pos;
+
+	switch (i) {
+	case 0:
+		ino = dentry->d_inode->i_ino;
+		if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+			break;
+		filp->f_pos++;
+		i++;
+		/* fallthrough */
+	case 1:
+		ino = parent_ino(dentry);
+		if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+			break;
+		filp->f_pos++;
+		i++;
+		/* fallthrough */
+	default:
+		if (filp->f_pos == 2) {
+			list_del(q);
+			list_add(q, &parent_sd->s_children);
+		}
+		for (p = q->next; p != &parent_sd->s_children; p = p->next) {
+			struct sysfs_dirent *next;
+			const char *name;
+			int len;
+
+			next = list_entry(p, struct sysfs_dirent, s_sibling);
+			if (!next->s_element)
+				continue;
+
+			name = sysfs_get_name(next);
+			len = strlen(name);
+			if (next->s_dentry)
+				ino = next->s_dentry->d_inode->i_ino;
+			else
+				ino = iunique(sysfs_sb, 2);
+
+			if (filldir(dirent, name, len, filp->f_pos, ino,
+				    dt_type(next)) < 0)
+				return 0;
+
+			list_del(q);
+			list_add(q, p);
+			p = q;
+			filp->f_pos++;
+		}
+	}
+	return 0;
+}
+
+static loff_t sysfs_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+	struct dentry *dentry = file->f_dentry;
+
+	down(&dentry->d_inode->i_sem);
+	switch (origin) {
+	case 1:
+		offset += file->f_pos;
+	case 0:
+		if (offset >= 0)
+			break;
+	default:
+		up(&file->f_dentry->d_inode->i_sem);
+		return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
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
+/* attaches attribute's sysfs_dirent to the dentry corresponding to the
+ * attribute file
+ */
+static int sysfs_attach_attr(struct sysfs_dirent *sd, struct dentry *dentry)
+{
+	struct attribute *attr = sd->s_element;
+	int error;
+
+	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init_file);
+	if (error)
+		return error;
+
+	dentry->d_op = &sysfs_dentry_ops;
+	dentry->d_fsdata = sysfs_get(sd);
+	sd->s_dentry = dentry;
+	d_rehash(dentry);
+
+	return 0;
+}
+
+static struct dentry *sysfs_lookup(struct inode *dir, struct dentry *dentry,
+				   struct nameidata *nd)
+{
+	struct sysfs_dirent *parent_sd = dentry->d_parent->d_fsdata;
+	struct sysfs_dirent *sd;
+	int found = 0;
+	int err = 0;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & CONFIGFS_NOT_PINNED) {
+			const unsigned char *name = sysfs_get_name(sd);
+
+			if (strcmp(name, dentry->d_name.name))
+				continue;
+
+			found = 1;
+			err = sysfs_attach_attr(sd, dentry);
+			break;
+		}
+	}
+
+	if (!found) {
+		/*
+		 * If it doesn't exist and it isn't a NOT_PINNED item,
+		 * it must be negative.
+		 */
+		return simple_lookup(dir, dentry, nd);
+	}
+
+	return ERR_PTR(err);
+}
+
+static struct inode_operations sysfs_dir_inode_operations;
+
+static int init_dir(struct inode *inode)
+{
+	inode->i_op = &sysfs_dir_inode_operations;
+	inode->i_fop = &sysfs_dir_operations;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inode->i_nlink++;
+	return 0;
+}
+
+static int create_dir(struct kobject *k, struct dentry *p, struct dentry *d)
+{
+	int error;
+	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+
+	error = sysfs_create(d, mode, init_dir);
+	if (!error) {
+		error = sysfs_make_dirent(p->d_fsdata, d, k, mode, CONFIGFS_DIR);
+		if (!error) {
+			p->d_inode->i_nlink++;
+			(d)->d_op = &sysfs_dentry_ops;
+		}
+	}
+	return error;
+}
+
+static struct vfsmount *sysfs_mount = NULL;
+
+static int configfs_create_dir(struct kobject *kobj, struct dentry *dentry)
+{
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
+	error = create_dir(kobj, parent, dentry);
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
+	sd = d->d_fsdata;
+	list_del_init(&sd->s_sibling);
+	sysfs_put(sd);
+	if (d->d_inode)
+		simple_rmdir(parent->d_inode, d);
+
+	pr_debug(" o %s removing done (%d)\n", d->d_name.name, atomic_read(&d->d_count));
+
+	dput(parent);
+}
+
+/*
+ *	sysfs_remove_dir - remove a kobject's directory.
+ *	@kobj:	kobject we're removing.
+ *
+ *	The only thing special about this is that we remove any files in
+ *	the directory before we remove the directory
+ */
+static void configfs_remove_dir(struct kobject *kobj)
+{
+	struct dentry *dentry = dget(kobj->dentry);
+
+	if (!dentry)
+		return;
+
+	remove_dir(dentry);
+	/* Drop reference from dget() on entrance. */
+	dput(dentry);
+}
+
+#if 0
+int sysfs_rename_dir(struct kobject *kobj, const char *new_name)
+{
+	int error = 0;
+	struct dentry *new_dentry, *parent;
+
+	if (!strcmp(kobject_name(kobj), new_name))
+		return -EINVAL;
+
+	if (!kobj->parent)
+		return -EINVAL;
+
+	down_write(&sysfs_rename_sem);
+	parent = kobj->parent->dentry;
+
+	down(&parent->d_inode->i_sem);
+
+	new_dentry = lookup_one_len(new_name, parent, strlen(new_name));
+	if (!IS_ERR(new_dentry)) {
+		if (!new_dentry->d_inode) {
+			error = kobject_set_name(kobj, "%s", new_name);
+			if (!error) {
+				d_add(new_dentry, NULL);
+				d_move(kobj->dentry, new_dentry);
+			} else
+				d_delete(new_dentry);
+		} else
+			error = -EEXIST;
+		dput(new_dentry);
+	}
+	up(&parent->d_inode->i_sem);
+	up_write(&sysfs_rename_sem);
+
+	return error;
+}
+#endif
+
+/*
+ * Only subdirectories count here.  Files (CONFIGFS_NOT_PINNED) are
+ * attributes and are removed by rmdir().  We recurse, taking i_sem
+ * on all children that are candidates for default detach.  If the
+ * result is clean, then sysfs_detach_group() will handle dropping
+ * i_sem.  If there is an error, the caller will clean up the i_sem
+ * holders via sysfs_detach_rollback().
+ */
+static int sysfs_detach_prep(struct dentry *dentry)
+{
+	struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent *sd;
+	int ret = 0;
+
+	if (!list_empty(&parent_sd->s_links))
+		return -EBUSY;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & CONFIGFS_NOT_PINNED)
+			continue;
+		if (sd->s_type & CONFIGFS_USET_DEFAULT) {
+			down(&sd->s_dentry->d_inode->i_sem);
+			/* Mark that we've taken i_sem */
+			sd->s_type |= CONFIGFS_USET_DROPPING;
+
+			ret = sysfs_detach_prep(sd->s_dentry);
+			if (!ret)
+				continue;
+		} else
+			ret = -ENOTEMPTY;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Walk the tree, dropping i_sem wherever CONFIGFS_USET_DROPPING is
+ * set.
+ */
+static void sysfs_detach_rollback(struct dentry *dentry)
+{
+	struct sysfs_dirent *parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent *sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_type & CONFIGFS_USET_DEFAULT) {
+			sysfs_detach_rollback(sd->s_dentry);
+
+			if (sd->s_type & CONFIGFS_USET_DROPPING) {
+				sd->s_type &= ~CONFIGFS_USET_DROPPING;
+				up(&sd->s_dentry->d_inode->i_sem);
+			}
+		}
+	}
+}
+
+static void detach_attrs(struct kobject *kobj)
+{
+	struct dentry *dentry = dget(kobj->dentry);
+	struct sysfs_dirent *parent_sd;
+	struct sysfs_dirent *sd, *tmp;
+
+	if (!dentry)
+		return;
+
+	pr_debug("configfs %s: dropping attrs for  dir\n", dentry->d_name.name);
+
+	parent_sd = dentry->d_fsdata;
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
+			continue;
+		list_del_init(&sd->s_sibling);
+		sysfs_drop_dentry(sd, dentry);
+		sysfs_put(sd);
+	}
+
+	/* Drop reference from dget() on entrance. */
+	dput(dentry);
+}
+
+/*
+ * All of link_obj/unlink_obj/link_group/unlink_group require that
+ * subsys->su_sem is held.
+ */
+
+static void sysfs_detach_group(struct kobject *kobj);
+
+static void detach_groups(struct kset *group)
+{
+	struct dentry *dentry = dget(group->kobj.dentry);
+	struct dentry *child;
+	struct sysfs_dirent *parent_sd;
+	struct sysfs_dirent *sd, *tmp;
+
+	if (!dentry)
+		return;
+
+	parent_sd = dentry->d_fsdata;
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element || !(sd->s_type & CONFIGFS_USET_DEFAULT))
+			continue;
+
+		child = sd->s_dentry;
+
+		sysfs_detach_group(sd->s_element);
+		child->d_inode->i_flags |= S_DEAD;
+
+		/*
+		 * From rmdir/unregister, a sysfs_detach_prep() pass
+		 * has taken our i_sem for us.  Drop it.
+		 * From mkdir/register cleanup, there is no sem held.
+		 */
+		if (sd->s_type & CONFIGFS_USET_DROPPING)
+			up(&child->d_inode->i_sem);
+
+		d_delete(child);
+		dput(child);
+	}
+
+	/**
+	 * Drop reference from dget() on entrance.
+	 */
+	dput(dentry);
+}
+
+static void sysfs_detach_item(struct kobject *kobj)
+{
+	detach_attrs(kobj);
+	configfs_remove_dir(kobj);
+}
+
+static void unlink_obj(struct kobject *kobj)
+{
+	struct kset *group;
+
+	group = kobj->kset;
+	if (group) {
+		list_del_init(&kobj->entry);
+
+		kobj->kset = NULL;
+		kobj->parent = NULL;
+		kobject_put(kobj);
+
+		config_group_put(group);
+	}
+}
+
+static void unlink_group(struct kset *group)
+{
+	int i;
+	struct kset *new_group;
+
+	if (group->default_groups) {
+		for (i = 0; group->default_groups[i]; i++) {
+			new_group = group->default_groups[i];
+			unlink_group(new_group);
+		}
+	}
+
+	group->subsys = NULL;
+	unlink_obj(&group->kobj);
+}
+
+static void sysfs_detach_group(struct kobject *kobj)
+{
+	detach_groups(to_config_group(kobj));
+	sysfs_detach_item(kobj);
+}
+
+/*
+ * Drop the initial reference from make_item()/make_group()
+ * This function assumes that reference is held on item
+ * and that item holds a valid reference to the parent.  Also, it
+ * assumes the caller has validated type.
+ */
+static void client_drop_item(struct kobject *parent_kobj, struct kobject *kobj)
+{
+	struct kobj_type *type;
+
+	type = parent_kobj->ktype;
+	BUG_ON(!type);
+
+	if (type->ct_group_ops && type->ct_group_ops->drop_item)
+		type->ct_group_ops->drop_item(to_config_group(parent_kobj), kobj);
+	else
+		kobject_put(kobj);
+}
+
+static int sysfs_attach_group(struct kobject *parent_kobj, struct kobject *kobj, struct dentry *dentry);
+
+static int populate_attrs(struct kobject *kobj)
+{
+	struct kobj_type *t = kobj->ktype;
+	struct attribute *attr;
+	int error = 0;
+	int i;
+
+	if (!t)
+		return -EINVAL;
+	if (t->default_attrs) {
+		for (i = 0; (attr = t->default_attrs[i]) != NULL; i++) {
+			if ((error = configfs_create_file(kobj, attr)))
+				break;
+		}
+	}
+
+	if (error)
+		detach_attrs(kobj);
+
+	return error;
+}
+
+/*
+ * The goal is that sysfs_attach_item() (and
+ * sysfs_attach_group()) can be called from either the VFS or this
+ * module.  That is, they assume that the items have been created,
+ * the dentry allocated, and the dcache is all ready to go.
+ *
+ * If they fail, they must clean up after themselves as if they
+ * had never been called.  The caller (VFS or local function) will
+ * handle cleaning up the dcache bits.
+ *
+ * sysfs_detach_group() and sysfs_detach_item() behave similarly on
+ * the way out.  They assume that the proper semaphores are held, they
+ * clean up the configfs items, and they expect their callers will
+ * handle the dcache bits.
+ */
+static int sysfs_attach_item(struct kobject *parent_kobj, struct kobject *kobj, struct dentry *dentry)
+{
+	int ret;
+
+	ret = configfs_create_dir(kobj, dentry);
+	if (!ret) {
+		ret = populate_attrs(kobj);
+		if (ret) {
+			configfs_remove_dir(kobj);
+			d_delete(dentry);
+		}
+	}
+	return ret;
+}
+
+/*
+ * This fakes mkdir(2) on a default_groups[] entry.  It
+ * creates a dentry, attachs it, and then does fixup
+ * on the sd->s_type.
+ *
+ * We could, perhaps, tweak our parent's ->mkdir for a minute and
+ * try using vfs_mkdir.  Just a thought.
+ */
+static int create_default_group(struct kset *parent_group, struct kset *group)
+{
+	int ret;
+	struct qstr name;
+	struct sysfs_dirent *sd;
+	/* We trust the caller holds a reference to parent */
+	struct dentry *child, *parent = parent_group->kobj.dentry;
+
+	if (!group->kobj.k_name)
+		group->kobj.k_name = group->kobj.name;
+	name.name = group->kobj.k_name;
+	name.len = strlen(name.name);
+	name.hash = full_name_hash(name.name, name.len);
+
+	ret = -ENOMEM;
+	child = d_alloc(parent, &name);
+	if (child) {
+		d_add(child, NULL);
+
+		ret = sysfs_attach_group(&parent_group->kobj,
+			&group->kobj, child);
+		if (!ret) {
+			sd = child->d_fsdata;
+			sd->s_type |= CONFIGFS_USET_DEFAULT;
+		} else {
+			d_delete(child);
+			dput(child);
+		}
+	}
+	return ret;
+}
+
+static int populate_groups(struct kset *group)
+{
+	struct kset *new_group;
+	struct dentry *dentry = group->kobj.dentry;
+	int ret = 0;
+	int i;
+
+	if (group && group->default_groups) {
+		/* FYI, we're faking mkdir here
+		 * I'm not sure we need this semaphore, as we're called
+		 * from our parent's mkdir.  That holds our parent's
+		 * i_sem, so afaik lookup cannot continue through our
+		 * parent to find us, let alone mess with our tree.
+		 * That said, taking our i_sem is closer to mkdir
+		 * emulation, and shouldn't hurt. */
+		down(&dentry->d_inode->i_sem);
+
+		for (i = 0; group->default_groups[i]; i++) {
+			new_group = group->default_groups[i];
+
+			ret = create_default_group(group, new_group);
+			if (ret)
+				break;
+		}
+
+		up(&dentry->d_inode->i_sem);
+	}
+
+	if (ret)
+		detach_groups(group);
+	return ret;
+}
+
+static int sysfs_attach_group(struct kobject *parent_kobj, struct kobject *kobj, struct dentry *dentry)
+{
+	int ret;
+	struct sysfs_dirent *sd;
+
+	ret = sysfs_attach_item(parent_kobj, kobj, dentry);
+	if (!ret) {
+		sd = dentry->d_fsdata;
+		sd->s_type |= CONFIGFS_USET_DIR;
+
+		ret = populate_groups(to_config_group(kobj));
+		if (ret) {
+			sysfs_detach_item(kobj);
+			d_delete(dentry);
+		}
+	}
+	return ret;
+}
+
+static void link_obj(struct kobject *parent_kobj, struct kobject *kobj)
+{
+	/* Parent seems redundant with group, but it makes certain
+	 * traversals much nicer. */
+	kobj->parent = parent_kobj;
+	kobj->kset = config_group_get(to_config_group(parent_kobj));
+	list_add_tail(&kobj->entry, &kobj->kset->cg_children);
+
+	kobject_get(kobj);
+}
+
+static void link_group(struct kset *parent_group, struct kset *group)
+{
+	int i;
+	struct kset *new_group;
+	struct subsystem *subsys = NULL;	/* gcc is a turd */
+
+	link_obj(&parent_group->kobj, &group->kobj);
+
+	if (parent_group->subsys)
+		subsys = parent_group->subsys;
+	else if (is_root(&parent_group->kobj))
+		subsys = to_configfs_subsystem(group);
+	else
+		BUG();
+	group->subsys = subsys;
+
+	if (group->default_groups) {
+		for (i = 0; group->default_groups[i]; i++) {
+			new_group = group->default_groups[i];
+			link_group(group, new_group);
+		}
+	}
+}
+
+static int sysfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int ret;
+	struct kset *group;
+	struct kobject *kobj;
+	struct kobject *parent_kobj;
+	struct subsystem *subsys;
+	struct sysfs_dirent *sd;
+	struct kobj_type *type;
+	struct module *owner;
+	char *name;
+
+	if (dentry->d_parent == sysfs_sb->s_root)
+		return -EPERM;
+
+	sd = dentry->d_parent->d_fsdata;
+	if (!(sd->s_type & CONFIGFS_USET_DIR))
+		return -EPERM;
+
+	parent_kobj = sysfs_get_kobject(dentry->d_parent);
+	type = parent_kobj->ktype;
+	subsys = to_config_group(parent_kobj)->subsys;
+	BUG_ON(!subsys);
+
+	if (!type || !type->ct_group_ops ||
+	    (!type->ct_group_ops->make_group &&
+	     !type->ct_group_ops->make_item)) {
+		kobject_put(parent_kobj);
+		return -EPERM;	/* What lack-of-mkdir returns */
+	}
+
+	name = kmalloc(dentry->d_name.len + 1, GFP_KERNEL);
+	if (!name) {
+		kobject_put(parent_kobj);
+		return -ENOMEM;
+	}
+	snprintf(name, dentry->d_name.len + 1, "%s", dentry->d_name.name);
+
+	down_write(&subsys->rwsem);
+	group = NULL;
+	kobj = NULL;
+	if (type->ct_group_ops->make_group) {
+		group = type->ct_group_ops->make_group(to_config_group(parent_kobj), name);
+		if (group) {
+			link_group(to_config_group(parent_kobj), group);
+			kobj = &group->kobj;
+		}
+	} else {
+		kobj = type->ct_group_ops->make_item(to_config_group(parent_kobj), name);
+		if (kobj)
+			link_obj(parent_kobj, kobj);
+	}
+	up_write(&subsys->rwsem);
+
+	kfree(name);
+	if (!kobj) {
+		kobject_put(parent_kobj);
+		return -ENOMEM;
+	}
+
+	ret = -EINVAL;
+	type = kobj->ktype;
+	if (type) {
+		owner = type->ct_owner;
+		if (try_module_get(owner)) {
+			ret = group ?
+			    sysfs_attach_group(parent_kobj, kobj, dentry) :
+			    sysfs_attach_item(parent_kobj, kobj, dentry);
+
+			if (ret) {
+				down_write(&subsys->rwsem);
+				if (group)
+					unlink_group(group);
+				else
+					unlink_obj(kobj);
+				client_drop_item(parent_kobj, kobj);
+				up_write(&subsys->rwsem);
+
+				kobject_put(parent_kobj);
+				module_put(owner);
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int sysfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct kobject *parent_kobj;
+	struct kobject *kobj;
+	struct subsystem *subsys;
+	struct sysfs_dirent *sd;
+	struct module *owner = NULL;
+	int ret;
+
+	if (dentry->d_parent == sysfs_sb->s_root)
+		return -EPERM;
+
+	sd = dentry->d_fsdata;
+	if (sd->s_type & CONFIGFS_USET_DEFAULT)
+		return -EPERM;
+
+	parent_kobj = sysfs_get_kobject(dentry->d_parent);
+	subsys = to_config_group(parent_kobj)->subsys;
+	BUG_ON(!subsys);
+
+	if (!parent_kobj->ktype) {
+		kobject_put(parent_kobj);
+		return -EINVAL;
+	}
+
+	ret = sysfs_detach_prep(dentry);
+	if (ret) {
+		sysfs_detach_rollback(dentry);
+		kobject_put(parent_kobj);
+		return ret;
+	}
+
+	kobj = sysfs_get_kobject(dentry);
+
+	/* Drop reference from above, item already holds one. */
+	kobject_put(parent_kobj);
+
+	if (kobj->ktype)
+		owner = kobj->ktype->ct_owner;
+
+	if (sd->s_type & CONFIGFS_USET_DIR) {
+		sysfs_detach_group(kobj);
+
+		down_write(&subsys->rwsem);
+		unlink_group(to_config_group(kobj));
+	} else {
+		sysfs_detach_item(kobj);
+
+		down_write(&subsys->rwsem);
+		unlink_obj(kobj);
+	}
+
+	client_drop_item(parent_kobj, kobj);
+	up_write(&subsys->rwsem);
+
+	/* Drop our reference from above */
+	kobject_put(kobj);
+
+	module_put(owner);
+
+	return 0;
+}
+
+int sysfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	int ret;
+	struct nameidata nd;
+	struct kobject *parent_kobj;
+	struct kobject *sl_target;
+	struct kobj_type *type;
+
+	ret = -EPERM;		/* What lack-of-symlink returns */
+	if (dentry->d_parent == sysfs_sb->s_root)
+		goto out;
+
+	parent_kobj = sysfs_get_kobject(dentry->d_parent);
+	type = parent_kobj->ktype;
+
+	if (!type || !type->sysfs_ops || !type->sysfs_ops->allow_link)
+		goto out_put;
+
+	ret = get_target(symname, &nd, &sl_target);
+	if (ret)
+		goto out_put;
+
+	ret = type->sysfs_ops->allow_link(parent_kobj, sl_target);
+	if (!ret)
+		ret = create_link(parent_kobj, sl_target, dentry);
+
+	kobject_put(sl_target);
+	path_release(&nd);
+
+      out_put:
+	kobject_put(parent_kobj);
+
+      out:
+	return ret;
+}
+
+static int sysfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct sysfs_dirent *sd = dentry->d_fsdata;
+	struct sysfs_symlink *sl;
+	struct kobject *parent_kobj;
+	struct kobj_type *type;
+	int ret;
+
+	ret = -EPERM;		/* What lack-of-symlink returns */
+	if (!(sd->s_type & CONFIGFS_ITEM_LINK))
+		goto out;
+
+	if (dentry->d_parent == sysfs_sb->s_root)
+		BUG();
+
+	sl = sd->s_element;
+
+	parent_kobj = sysfs_get_kobject(dentry->d_parent);
+	type = parent_kobj->ktype;
+
+	list_del_init(&sd->s_sibling);
+	sysfs_drop_dentry(sd, dentry->d_parent);
+	dput(dentry);
+	sysfs_put(sd);
+
+	/*
+	 * drop_link() must be called before
+	 * list_del_init(&sl->sl_list), so that the order of
+	 * drop_link(this, target) and drop_item(target) is preserved.
+	 */
+	if (type && type->sysfs_ops && type->sysfs_ops->drop_link)
+		type->sysfs_ops->drop_link(parent_kobj, sl->sl_target);
+
+	/* FIXME: Needs lock */
+	list_del_init(&sl->sl_list);
+
+	/* Put reference from create_link() */
+	kobject_put(sl->sl_target);
+	kfree(sl);
+
+	kobject_put(parent_kobj);
+
+	ret = 0;
+
+      out:
+	return ret;
+}
+
+static struct inode_operations sysfs_dir_inode_operations = {
+	.lookup = sysfs_lookup,
+	.mkdir = sysfs_mkdir,
+	.rmdir = sysfs_rmdir,
+	.symlink = sysfs_symlink,
+	.unlink = sysfs_unlink,
+};
+
+static int sysfs_mnt_count = 0;
+
+int sysfs_pin_fs(void)
+{
+	return simple_pin_fs("configfs", &sysfs_mount, &sysfs_mnt_count);
+}
+
+void sysfs_release_fs(void)
+{
+	simple_release_fs(&sysfs_mount, &sysfs_mnt_count);
+}
+
+int configfs_register_subsystem(struct subsystem *subsys)
+{
+	int err;
+	struct kset *group = &subsys->kset;
+	struct qstr name;
+	struct dentry *dentry;
+	struct sysfs_dirent *sd;
+
+	err = sysfs_pin_fs();
+	if (err)
+		return err;
+
+	if (!group->kobj.k_name)
+		group->kobj.k_name = group->kobj.name;
+
+	sd = sysfs_sb->s_root->d_fsdata;
+	link_group(to_config_group(sd->s_element), group);
+
+	down(&sysfs_sb->s_root->d_inode->i_sem);
+
+	name.name = group->kobj.k_name;
+	name.len = strlen(name.name);
+	name.hash = full_name_hash(name.name, name.len);
+
+	err = -ENOMEM;
+	dentry = d_alloc(sysfs_sb->s_root, &name);
+	if (!dentry)
+		goto out_release;
+
+	d_add(dentry, NULL);
+
+	err = sysfs_attach_group(sd->s_element, &group->kobj, dentry);
+	if (!err)
+		dentry = NULL;
+	else
+		d_delete(dentry);
+
+	up(&sysfs_sb->s_root->d_inode->i_sem);
+
+	if (dentry) {
+		dput(dentry);
+	      out_release:
+		unlink_group(group);
+		sysfs_release_fs();
+	}
+
+	return err;
+}
+
+void configfs_unregister_subsystem(struct subsystem *subsys)
+{
+	struct kset *group = &subsys->kset;
+	struct dentry *dentry = group->kobj.dentry;
+
+	if (dentry->d_parent != sysfs_sb->s_root) {
+		printk(KERN_ERR
+		       "configfs: Tried to unregister non-subsystem!\n");
+		return;
+	}
+
+	down(&sysfs_sb->s_root->d_inode->i_sem);
+	down(&dentry->d_inode->i_sem);
+	if (sysfs_detach_prep(dentry)) {
+		printk(KERN_ERR
+		       "configfs: Tried to unregister non-empty subsystem!\n");
+	}
+	sysfs_detach_group(&group->kobj);
+	dentry->d_inode->i_flags |= S_DEAD;
+	up(&dentry->d_inode->i_sem);
+
+	d_delete(dentry);
+
+	up(&sysfs_sb->s_root->d_inode->i_sem);
+
+	dput(dentry);
+
+	unlink_group(group);
+	sysfs_release_fs();
+}
+
+/*
+ * mount.c - operations for initializing and mounting
+ */
+
+#define CONFIGFS_MAGIC 0x62656570
+
+static struct super_operations sysfs_ops = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static struct sysfs_dirent sysfs_root = {
+	.s_sibling = LIST_HEAD_INIT(sysfs_root.s_sibling),
+	.s_children = LIST_HEAD_INIT(sysfs_root.s_children),
+	.s_element = &sysfs_root_group.kobj,
+	.s_type = CONFIGFS_ROOT,
+};
+
+static int sysfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = CONFIGFS_MAGIC;
+	sb->s_op = &sysfs_ops;
+	sysfs_sb = sb;
+
+	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	if (inode) {
+		inode->i_op = &sysfs_dir_inode_operations;
+		inode->i_fop = &sysfs_dir_operations;
+		/* directory inodes start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+	} else {
+		pr_debug("configfs: could not get root inode\n");
+		return -ENOMEM;
+	}
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		pr_debug("%s: could not get root dentry!\n", __FUNCTION__);
+		iput(inode);
+		return -ENOMEM;
+	}
+	config_group_init(&sysfs_root_group);
+	sysfs_root_group.kobj.dentry = root;
+	root->d_fsdata = &sysfs_root;
+	sb->s_root = root;
+	return 0;
+}
+
+static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
+}
+
+static struct file_system_type sysfs_fs_type = {
+	.name = "configfs",
+	.owner = THIS_MODULE,
+	.get_sb = sysfs_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+static int __init sysfs_init(void)
+{
+	int err = -ENOMEM;
+
+	sysfs_dir_cachep = kmem_cache_create("configfs_dir_cache",
+		sizeof(struct sysfs_dirent), 0, 0, NULL, NULL);
+	if (!sysfs_dir_cachep)
+		goto out;
+
+	err = register_filesystem(&sysfs_fs_type);
+	if (err)
+		goto out_err;
+      out:
+	return err;
+      out_err:
+	kmem_cache_destroy(sysfs_dir_cachep);
+	sysfs_dir_cachep = NULL;
+	goto out;
+}
+
+static void __exit sysfs_exit(void)
+{
+	unregister_filesystem(&sysfs_fs_type);
+}
+
+MODULE_AUTHOR("Oracle");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.0.1");
+MODULE_DESCRIPTION
+    ("Simple RAM filesystem for user driven kernel subsystem configuration.");
+
+module_init(sysfs_init);
+module_exit(sysfs_exit);
+
+/* 
+ * configfs client helpers
+ */
+
+void config_group_init_type_name(struct kset *group, const char *name, struct kobj_type *type)
+{
+ kobject_set_name(&group->kobj, name);
+ group->kobj.ktype = type;
+ config_group_init(group);
+}
+
+void config_group_init(struct kset *group)
+{
+ kobject_init(&group->kobj);
+ INIT_LIST_HEAD(&group->cg_children);
+}
+
+void kobject_init_type_name(struct kobject *kobj, const char *name, struct kobj_type *type)
+{
+ kobject_set_name(kobj, name);
+ kobj->ktype = type;
+ kobject_init(kobj);
+}
+
+EXPORT_SYMBOL(configfs_register_subsystem);
+EXPORT_SYMBOL(configfs_unregister_subsystem);
+EXPORT_SYMBOL(config_group_init_type_name);
+EXPORT_SYMBOL(config_group_init);
+EXPORT_SYMBOL(kobject_init_type_name);

