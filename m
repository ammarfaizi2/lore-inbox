Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWFLM26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWFLM26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWFLM26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:28:58 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:43496 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751909AbWFLM25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:28:57 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 3/7] fuse: add control filesystem
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplWy-000620-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:28:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control filesystem to fuse, replacing the attributes currently
exported through sysfs.  An empty directory '/sys/fs/fuse/connections'
is still created in sysfs, and mounting the control filesystem here
provides backward compatibility.

Advantages of the control filesystem over the previous solution:

  - allows the object directory and the attributes to be owned by the
    filesystem owner, hence letting unpriviled users abort the
    filesystem connection

  - does not suffer from module unload race

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/control.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/fs/fuse/control.c	2006-06-12 14:09:57.000000000 +0200
@@ -0,0 +1,204 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU GPL.
+  See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+#define FUSE_CTL_SUPER_MAGIC 0x65735543
+
+static struct super_block *fuse_control_sb;
+
+static struct fuse_conn *fuse_ctl_file_conn_get(struct file *file)
+{
+	struct fuse_conn *fc;
+	mutex_lock(&fuse_mutex);
+	fc = file->f_dentry->d_inode->u.generic_ip;
+	if (fc)
+		fc = fuse_conn_get(fc);
+	mutex_unlock(&fuse_mutex);
+	return fc;
+}
+
+static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+	if (fc) {
+		fuse_abort_conn(fc);
+		fuse_conn_put(fc);
+	}
+	return count;
+}
+
+static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
+				      size_t len, loff_t *ppos)
+{
+	char tmp[32];
+	size_t size;
+
+	if (!*ppos) {
+		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+		if (!fc)
+			return 0;
+
+		file->private_data = (void *) atomic_read(&fc->num_waiting);
+		fuse_conn_put(fc);
+	}
+	size = sprintf(tmp, "%i\n", (int) file->private_data);
+	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+}
+
+static const struct file_operations fuse_ctl_abort_ops = {
+	.open = nonseekable_open,
+	.write = fuse_conn_abort_write,
+};
+
+static const struct file_operations fuse_ctl_waiting_ops = {
+	.open = nonseekable_open,
+	.read = fuse_conn_waiting_read,
+};
+
+static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
+					  struct fuse_conn *fc,
+					  const char *name,
+					  int mode, int nlink,
+					  struct inode_operations *iop,
+					  const struct file_operations *fop)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	BUG_ON(fc->ctl_ndents >= FUSE_CTL_NUM_DENTRIES);
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		return NULL;
+
+	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
+	inode = new_inode(fuse_control_sb);
+	if (!inode)
+		return NULL;
+
+	inode->i_mode = mode;
+	inode->i_uid = fc->user_id;
+	inode->i_gid = fc->group_id;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	if (iop)
+		inode->i_op = iop;
+	inode->i_fop = fop;
+	inode->i_nlink = nlink;
+	inode->u.generic_ip = fc;
+	d_add(dentry, inode);
+	return dentry;
+}
+
+int fuse_ctl_add_conn(struct fuse_conn *fc)
+{
+	struct dentry *parent;
+	char name[32];
+
+	if (!fuse_control_sb)
+		return 0;
+
+	parent = fuse_control_sb->s_root;
+	parent->d_inode->i_nlink++;
+	sprintf(name, "%llu", (unsigned long long) fc->id);
+	parent = fuse_ctl_add_dentry(parent, fc, name, S_IFDIR | 0500, 2,
+				     &simple_dir_inode_operations,
+				     &simple_dir_operations);
+	if (!parent)
+		goto err;
+
+	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
+				NULL, &fuse_ctl_waiting_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
+				 NULL, &fuse_ctl_abort_ops))
+		goto err;
+
+	return 0;
+
+ err:
+	fuse_ctl_remove_conn(fc);
+	return -ENOMEM;
+}
+
+void fuse_ctl_remove_conn(struct fuse_conn *fc)
+{
+	int i;
+
+	if (!fuse_control_sb)
+		return;
+
+	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
+		struct dentry *dentry = fc->ctl_dentry[i];
+		dentry->d_inode->u.generic_ip = NULL;
+		d_drop(dentry);
+		dput(dentry);
+	}
+	fuse_control_sb->s_root->d_inode->i_nlink--;
+}
+
+static int fuse_ctl_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct tree_descr empty_descr = {""};
+	struct fuse_conn *fc;
+	int err;
+
+	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
+	if (err)
+		return err;
+
+	mutex_lock(&fuse_mutex);
+	BUG_ON(fuse_control_sb);
+	fuse_control_sb = sb;
+	list_for_each_entry(fc, &fuse_conn_list, entry) {
+		err = fuse_ctl_add_conn(fc);
+		if (err) {
+			fuse_control_sb = NULL;
+			mutex_unlock(&fuse_mutex);
+			return err;
+		}
+	}
+	mutex_unlock(&fuse_mutex);
+
+	return 0;
+}
+
+static struct super_block *fuse_ctl_get_sb(struct file_system_type *fs_type,
+					   int flags, const char *dev_name,
+					   void *raw_data)
+{
+	return get_sb_single(fs_type, flags, raw_data, fuse_ctl_fill_super);
+}
+
+static void fuse_ctl_kill_sb(struct super_block *sb)
+{
+	mutex_lock(&fuse_mutex);
+	fuse_control_sb = NULL;
+	mutex_unlock(&fuse_mutex);
+
+	kill_litter_super(sb);
+}
+
+static struct file_system_type fuse_ctl_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "fusectl",
+	.get_sb		= fuse_ctl_get_sb,
+	.kill_sb	= fuse_ctl_kill_sb,
+};
+
+int __init fuse_ctl_init(void)
+{
+	return register_filesystem(&fuse_ctl_fs_type);
+}
+
+void fuse_ctl_cleanup(void)
+{
+	unregister_filesystem(&fuse_ctl_fs_type);
+}
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-06-12 14:09:56.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-06-12 14:09:57.000000000 +0200
@@ -22,13 +22,8 @@ MODULE_DESCRIPTION("Filesystem in Usersp
 MODULE_LICENSE("GPL");
 
 static kmem_cache_t *fuse_inode_cachep;
-static struct subsystem connections_subsys;
-
-struct fuse_conn_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct fuse_conn *, char *);
-	ssize_t (*store)(struct fuse_conn *, const char *, size_t);
-};
+struct list_head fuse_conn_list;
+DEFINE_MUTEX(fuse_mutex);
 
 #define FUSE_SUPER_MAGIC 0x65735546
 
@@ -212,8 +207,11 @@ static void fuse_put_super(struct super_
 	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
 	wake_up_all(&fc->blocked_waitq);
-	kobject_del(&fc->kobj);
-	kobject_put(&fc->kobj);
+	mutex_lock(&fuse_mutex);
+	list_del(&fc->entry);
+	fuse_ctl_remove_conn(fc);
+	mutex_unlock(&fuse_mutex);
+	fuse_conn_put(fc);
 }
 
 static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
@@ -362,11 +360,6 @@ static int fuse_show_options(struct seq_
 	return 0;
 }
 
-static void fuse_conn_release(struct kobject *kobj)
-{
-	kfree(get_fuse_conn_kobj(kobj));
-}
-
 static struct fuse_conn *new_conn(void)
 {
 	struct fuse_conn *fc;
@@ -374,13 +367,12 @@ static struct fuse_conn *new_conn(void)
 	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc) {
 		spin_lock_init(&fc->lock);
+		atomic_set(&fc->count, 1);
 		init_waitqueue_head(&fc->waitq);
 		init_waitqueue_head(&fc->blocked_waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->io);
-		kobj_set_kset_s(fc, connections_subsys);
-		kobject_init(&fc->kobj);
 		atomic_set(&fc->num_waiting, 0);
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
@@ -390,6 +382,18 @@ static struct fuse_conn *new_conn(void)
 	return fc;
 }
 
+void fuse_conn_put(struct fuse_conn *fc)
+{
+	if (atomic_dec_and_test(&fc->count))
+		kfree(fc);
+}
+
+struct fuse_conn *fuse_conn_get(struct fuse_conn *fc)
+{
+	atomic_inc(&fc->count);
+	return fc;
+}
+
 static struct inode *get_root_inode(struct super_block *sb, unsigned mode)
 {
 	struct fuse_attr attr;
@@ -459,10 +463,9 @@ static void fuse_send_init(struct fuse_c
 	request_send_background(fc, req);
 }
 
-static unsigned long long conn_id(void)
+static u64 conn_id(void)
 {
-	/* BKL is held for ->get_sb() */
-	static unsigned long long ctr = 1;
+	static u64 ctr = 1;
 	return ctr++;
 }
 
@@ -519,24 +522,21 @@ static int fuse_fill_super(struct super_
 	if (!init_req)
 		goto err_put_root;
 
-	err = kobject_set_name(&fc->kobj, "%llu", conn_id());
-	if (err)
-		goto err_free_req;
-
-	err = kobject_add(&fc->kobj);
-	if (err)
-		goto err_free_req;
-
-	/* Setting file->private_data can't race with other mount()
-	   instances, since BKL is held for ->get_sb() */
+	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
 	if (file->private_data)
-		goto err_kobject_del;
+		goto err_unlock;
 
+	fc->id = conn_id();
+	err = fuse_ctl_add_conn(fc);
+	if (err)
+		goto err_unlock;
+
+	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
 	fc->connected = 1;
-	kobject_get(&fc->kobj);
-	file->private_data = fc;
+	file->private_data = fuse_conn_get(fc);
+	mutex_unlock(&fuse_mutex);
 	/*
 	 * atomic_dec_and_test() in fput() provides the necessary
 	 * memory barrier for file->private_data to be visible on all
@@ -548,15 +548,14 @@ static int fuse_fill_super(struct super_
 
 	return 0;
 
- err_kobject_del:
-	kobject_del(&fc->kobj);
- err_free_req:
+ err_unlock:
+	mutex_unlock(&fuse_mutex);
 	fuse_request_free(init_req);
  err_put_root:
 	dput(root_dentry);
  err:
 	fput(file);
-	kobject_put(&fc->kobj);
+	fuse_conn_put(fc);
 	return err;
 }
 
@@ -574,68 +573,8 @@ static struct file_system_type fuse_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
-static ssize_t fuse_conn_waiting_show(struct fuse_conn *fc, char *page)
-{
-	return sprintf(page, "%i\n", atomic_read(&fc->num_waiting));
-}
-
-static ssize_t fuse_conn_abort_store(struct fuse_conn *fc, const char *page,
-				     size_t count)
-{
-	fuse_abort_conn(fc);
-	return count;
-}
-
-static struct fuse_conn_attr fuse_conn_waiting =
-	__ATTR(waiting, 0400, fuse_conn_waiting_show, NULL);
-static struct fuse_conn_attr fuse_conn_abort =
-	__ATTR(abort, 0600, NULL, fuse_conn_abort_store);
-
-static struct attribute *fuse_conn_attrs[] = {
-	&fuse_conn_waiting.attr,
-	&fuse_conn_abort.attr,
-	NULL,
-};
-
-static ssize_t fuse_conn_attr_show(struct kobject *kobj,
-				   struct attribute *attr,
-				   char *page)
-{
-	struct fuse_conn_attr *fca =
-		container_of(attr, struct fuse_conn_attr, attr);
-
-	if (fca->show)
-		return fca->show(get_fuse_conn_kobj(kobj), page);
-	else
-		return -EACCES;
-}
-
-static ssize_t fuse_conn_attr_store(struct kobject *kobj,
-				    struct attribute *attr,
-				    const char *page, size_t count)
-{
-	struct fuse_conn_attr *fca =
-		container_of(attr, struct fuse_conn_attr, attr);
-
-	if (fca->store)
-		return fca->store(get_fuse_conn_kobj(kobj), page, count);
-	else
-		return -EACCES;
-}
-
-static struct sysfs_ops fuse_conn_sysfs_ops = {
-	.show	= &fuse_conn_attr_show,
-	.store	= &fuse_conn_attr_store,
-};
-
-static struct kobj_type ktype_fuse_conn = {
-	.release	= fuse_conn_release,
-	.sysfs_ops	= &fuse_conn_sysfs_ops,
-	.default_attrs	= fuse_conn_attrs,
-};
-
 static decl_subsys(fuse, NULL, NULL);
-static decl_subsys(connections, &ktype_fuse_conn, NULL);
+static decl_subsys(connections, NULL, NULL);
 
 static void fuse_inode_init_once(void *foo, kmem_cache_t *cachep,
 				 unsigned long flags)
@@ -709,6 +648,7 @@ static int __init fuse_init(void)
 	printk("fuse init (API version %i.%i)\n",
 	       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
 
+	INIT_LIST_HEAD(&fuse_conn_list);
 	res = fuse_fs_init();
 	if (res)
 		goto err;
@@ -721,8 +661,14 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_dev_cleanup;
 
+	res = fuse_ctl_init();
+	if (res)
+		goto err_sysfs_cleanup;
+
 	return 0;
 
+ err_sysfs_cleanup:
+	fuse_sysfs_cleanup();
  err_dev_cleanup:
 	fuse_dev_cleanup();
  err_fs_cleanup:
@@ -735,6 +681,7 @@ static void __exit fuse_exit(void)
 {
 	printk(KERN_DEBUG "fuse exit\n");
 
+	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
 	fuse_dev_cleanup();
Index: linux/fs/fuse/Makefile
===================================================================
--- linux.orig/fs/fuse/Makefile	2006-06-12 14:09:21.000000000 +0200
+++ linux/fs/fuse/Makefile	2006-06-12 14:09:57.000000000 +0200
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 
-fuse-objs := dev.o dir.o file.o inode.o
+fuse-objs := dev.o dir.o file.o inode.o control.o
Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-06-12 14:09:56.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-06-12 14:09:57.000000000 +0200
@@ -833,7 +833,7 @@ static int fuse_dev_release(struct inode
 		end_requests(fc, &fc->processing);
 		spin_unlock(&fc->lock);
 		fasync_helper(-1, file, 0, &fc->fasync);
-		kobject_put(&fc->kobj);
+		fuse_conn_put(fc);
 	}
 
 	return 0;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:09:56.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:09:57.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
+#include <linux/mutex.h>
 
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
@@ -24,6 +25,9 @@
 /** It could be as large as PATH_MAX, but would that have any uses? */
 #define FUSE_NAME_MAX 1024
 
+/** Number of dentries for each connection in the control filesystem */
+#define FUSE_CTL_NUM_DENTRIES 3
+
 /** If the FUSE_DEFAULT_PERMISSIONS flag is given, the filesystem
     module will check permissions based on the file mode.  Otherwise no
     permission checking is done in the kernel */
@@ -33,6 +37,11 @@
     doing the mount will be allowed to access the filesystem */
 #define FUSE_ALLOW_OTHER         (1 << 1)
 
+/** List of active connections */
+extern struct list_head fuse_conn_list;
+
+/** Global mutex protecting fuse_conn_list and the control filesystem */
+extern struct mutex fuse_mutex;
 
 /** FUSE inode */
 struct fuse_inode {
@@ -216,6 +225,9 @@ struct fuse_conn {
 	/** Lock protecting accessess to  members of this structure */
 	spinlock_t lock;
 
+	/** Refcount */
+	atomic_t count;
+
 	/** The user id for this mount */
 	uid_t user_id;
 
@@ -310,8 +322,17 @@ struct fuse_conn {
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 
-	/** kobject */
-	struct kobject kobj;
+	/** Entry on the fuse_conn_list */
+	struct list_head entry;
+
+	/** Unique ID */
+	u64 id;
+
+	/** Dentries in the control filesystem */
+	struct dentry *ctl_dentry[FUSE_CTL_NUM_DENTRIES];
+
+	/** number of dentries used in the above array */
+	int ctl_ndents;
 
 	/** O_ASYNC requests */
 	struct fasync_struct *fasync;
@@ -327,11 +348,6 @@ static inline struct fuse_conn *get_fuse
 	return get_fuse_conn_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn_kobj(struct kobject *obj)
-{
-	return container_of(obj, struct fuse_conn, kobj);
-}
-
 static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
@@ -422,6 +438,9 @@ int fuse_dev_init(void);
  */
 void fuse_dev_cleanup(void);
 
+int fuse_ctl_init(void);
+void fuse_ctl_cleanup(void);
+
 /**
  * Allocate a request
  */
@@ -470,3 +489,23 @@ int fuse_do_getattr(struct inode *inode)
  * Invalidate inode attributes
  */
 void fuse_invalidate_attr(struct inode *inode);
+
+/**
+ * Acquire reference to fuse_conn
+ */
+struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
+
+/**
+ * Release reference to fuse_conn
+ */
+void fuse_conn_put(struct fuse_conn *fc);
+
+/**
+ * Add connection to control filesystem
+ */
+int fuse_ctl_add_conn(struct fuse_conn *fc);
+
+/**
+ * Remove connection from control filesystem
+ */
+void fuse_ctl_remove_conn(struct fuse_conn *fc);
Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-06-12 14:09:56.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2006-06-12 14:09:57.000000000 +0200
@@ -18,6 +18,14 @@ Non-privileged mount (or user mount):
   user.  NOTE: this is not the same as mounts allowed with the "user"
   option in /etc/fstab, which is not discussed here.
 
+Filesystem connection:
+
+  A connection between the filesystem daemon and the kernel.  The
+  connection exists until either the daemon dies, or the filesystem is
+  umounted.  Note that detaching (or lazy umounting) the filesystem
+  does _not_ break the connection, in this case it will exist until
+  the last reference to the filesystem is released.
+
 Mount owner:
 
   The user who does the mounting.
@@ -86,16 +94,20 @@ Mount options
   The default is infinite.  Note that the size of read requests is
   limited anyway to 32 pages (which is 128kbyte on i386).
 
-Sysfs
-~~~~~
+Control filesystem
+~~~~~~~~~~~~~~~~~~
+
+There's a control filesystem for FUSE, which can be mounted by:
 
-FUSE sets up the following hierarchy in sysfs:
+  mount -t fusectl none /sys/fs/fuse/connections
 
-  /sys/fs/fuse/connections/N/
+Mounting it under the '/sys/fs/fuse/connections' directory makes it
+backwards compatible with earlier versions.
 
-where N is an increasing number allocated to each new connection.
+Under the fuse control filesystem each connection has a directory
+named by a unique number.
 
-For each connection the following attributes are defined:
+For each connection the following files exist within this directory:
 
  'waiting'
 
@@ -110,7 +122,7 @@ For each connection the following attrib
   connection.  This means that all waiting requests will be aborted an
   error returned for all aborted and new requests.
 
-Only a privileged user may read or write these attributes.
+Only the owner of the mount may read or write these files.
 
 Aborting a filesystem connection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -139,8 +151,8 @@ the filesystem.  There are several ways 
   - Use forced umount (umount -f).  Works in all cases but only if
     filesystem is still attached (it hasn't been lazy unmounted)
 
-  - Abort filesystem through the sysfs interface.  Most powerful
-    method, always works.
+  - Abort filesystem through the FUSE control filesystem.  Most
+    powerful method, always works.
 
 How do non-privileged mounts work?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
