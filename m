Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945923AbWANAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWANAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWANAmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:16 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:18606 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945906AbWANAl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:56 -0500
Message-Id: <20060114004108.804850000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:58 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] fuse: make fuse connection a kobject
Content-Disposition: inline; filename=fuse_sys.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kobjectify fuse_conn, and make it visible under
/sys/fs/fuse/connections.  Lacking any natural naming, connections are
numbered.

This patch doesn't add any attributes, just the infrastructure.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-14 00:04:52.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-14 00:09:47.000000000 +0100
@@ -852,9 +852,11 @@ static int fuse_dev_release(struct inode
 		fc->connected = 0;
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
-		fuse_release_conn(fc);
 	}
 	spin_unlock(&fuse_lock);
+	if (fc)
+		kobject_put(&fc->kobj);
+
 	return 0;
 }
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:04:52.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:09:47.000000000 +0100
@@ -196,9 +196,6 @@ struct fuse_req {
  * unmounted.
  */
 struct fuse_conn {
-	/** Reference count */
-	int count;
-
 	/** The user id for this mount */
 	uid_t user_id;
 
@@ -288,6 +285,9 @@ struct fuse_conn {
 
 	/** Backing dev info */
 	struct backing_dev_info bdi;
+
+	/** kobject */
+	struct kobject kobj;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -300,6 +300,11 @@ static inline struct fuse_conn *get_fuse
 	return get_fuse_conn_super(inode->i_sb);
 }
 
+static inline struct fuse_conn *get_fuse_conn_kobj(struct kobject *obj)
+{
+	return container_of(obj, struct fuse_conn, kobj);
+}
+
 static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
@@ -400,12 +405,6 @@ void fuse_init_symlink(struct inode *ino
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr);
 
 /**
- * Check if the connection can be released, and if yes, then free the
- * connection structure
- */
-void fuse_release_conn(struct fuse_conn *fc);
-
-/**
  * Initialize the client device
  */
 int fuse_dev_init(void);
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-14 00:04:52.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-14 00:09:47.000000000 +0100
@@ -24,6 +24,13 @@ MODULE_LICENSE("GPL");
 
 spinlock_t fuse_lock;
 static kmem_cache_t *fuse_inode_cachep;
+static struct subsystem connections_subsys;
+
+struct fuse_conn_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct fuse_conn *, char *);
+	ssize_t (*store)(struct fuse_conn *, const char *, size_t);
+};
 
 #define FUSE_SUPER_MAGIC 0x65735546
 
@@ -201,11 +208,12 @@ static void fuse_put_super(struct super_
 	spin_lock(&fuse_lock);
 	fc->mounted = 0;
 	fc->connected = 0;
+	spin_unlock(&fuse_lock);
+	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
-	up_write(&fc->sbput_sem);
-	fuse_release_conn(fc);
-	spin_unlock(&fuse_lock);
+	kobject_del(&fc->kobj);
+	kobject_put(&fc->kobj);
 }
 
 static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
@@ -354,8 +362,10 @@ static int fuse_show_options(struct seq_
 	return 0;
 }
 
-static void free_conn(struct fuse_conn *fc)
+static void fuse_conn_release(struct kobject *kobj)
 {
+	struct fuse_conn *fc = get_fuse_conn_kobj(kobj);
+
 	while (!list_empty(&fc->unused_list)) {
 		struct fuse_req *req;
 		req = list_entry(fc->unused_list.next, struct fuse_req, list);
@@ -365,20 +375,12 @@ static void free_conn(struct fuse_conn *
 	kfree(fc);
 }
 
-/* Must be called with the fuse lock held */
-void fuse_release_conn(struct fuse_conn *fc)
-{
-	fc->count--;
-	if (!fc->count)
-		free_conn(fc);
-}
-
 static struct fuse_conn *new_conn(void)
 {
 	struct fuse_conn *fc;
 
 	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
-	if (fc != NULL) {
+	if (fc) {
 		int i;
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
@@ -388,10 +390,12 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->background);
 		sema_init(&fc->outstanding_sem, 1); /* One for INIT */
 		init_rwsem(&fc->sbput_sem);
+		kobj_set_kset_s(fc, connections_subsys);
+		kobject_init(&fc->kobj);
 		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
 			struct fuse_req *req = fuse_request_alloc();
 			if (!req) {
-				free_conn(fc);
+				kobject_put(&fc->kobj);
 				return NULL;
 			}
 			list_add(&req->list, &fc->unused_list);
@@ -406,25 +410,32 @@ static struct fuse_conn *new_conn(void)
 static struct fuse_conn *get_conn(struct file *file, struct super_block *sb)
 {
 	struct fuse_conn *fc;
+	int err;
 
+	err = -EINVAL;
 	if (file->f_op != &fuse_dev_operations)
-		return ERR_PTR(-EINVAL);
+		goto out_err;
+
+	err = -ENOMEM;
 	fc = new_conn();
-	if (fc == NULL)
-		return ERR_PTR(-ENOMEM);
+	if (!fc)
+		goto out_err;
+
 	spin_lock(&fuse_lock);
-	if (file->private_data) {
-		free_conn(fc);
-		fc = ERR_PTR(-EINVAL);
-	} else {
-		file->private_data = fc;
-		sb->s_fs_info = fc;
-		fc->mounted = 1;
-		fc->connected = 1;
-		fc->count = 2;
-	}
+	err = -EINVAL;
+	if (file->private_data)
+		goto out_unlock;
+
+	kobject_get(&fc->kobj);
+	file->private_data = fc;
 	spin_unlock(&fuse_lock);
 	return fc;
+
+ out_unlock:
+	spin_unlock(&fuse_lock);
+	kobject_put(&fc->kobj);
+ out_err:
+	return ERR_PTR(err);
 }
 
 static struct inode *get_root_inode(struct super_block *sb, unsigned mode)
@@ -447,12 +458,23 @@ static struct super_operations fuse_supe
 	.show_options	= fuse_show_options,
 };
 
+static unsigned long long conn_id(void)
+{
+	static unsigned long long ctr = 1;
+	unsigned long long val;
+	spin_lock(&fuse_lock);
+	val = ctr++;
+	spin_unlock(&fuse_lock);
+	return val;
+}
+
 static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct fuse_conn *fc;
 	struct inode *root;
 	struct fuse_mount_data d;
 	struct file *file;
+	struct dentry *root_dentry;
 	int err;
 
 	if (!parse_fuse_opt((char *) data, &d))
@@ -480,23 +502,42 @@ static int fuse_fill_super(struct super_
 	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
 
+	/* Used by get_root_inode() */
+	sb->s_fs_info = fc;
+
 	err = -ENOMEM;
 	root = get_root_inode(sb, d.rootmode);
-	if (root == NULL)
+	if (!root)
 		goto err;
 
-	sb->s_root = d_alloc_root(root);
-	if (!sb->s_root) {
+	root_dentry = d_alloc_root(root);
+	if (!root_dentry) {
 		iput(root);
 		goto err;
 	}
+
+	err = kobject_set_name(&fc->kobj, "%llu", conn_id());
+	if (err)
+		goto err_put_root;
+
+	err = kobject_add(&fc->kobj);
+	if (err)
+		goto err_put_root;
+
+	sb->s_root = root_dentry;
+	spin_lock(&fuse_lock);
+	fc->mounted = 1;
+	fc->connected = 1;
+	spin_unlock(&fuse_lock);
+
 	fuse_send_init(fc);
+
 	return 0;
 
+ err_put_root:
+	dput(root_dentry);
  err:
-	spin_lock(&fuse_lock);
-	fuse_release_conn(fc);
-	spin_unlock(&fuse_lock);
+	kobject_put(&fc->kobj);
 	return err;
 }
 
@@ -514,6 +555,50 @@ static struct file_system_type fuse_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
+static struct attribute *fuse_conn_attrs[] = {
+	NULL,
+};
+
+static ssize_t fuse_conn_attr_show(struct kobject *kobj,
+				   struct attribute *attr,
+				   char *page)
+{
+	struct fuse_conn_attr *fca =
+		container_of(attr, struct fuse_conn_attr, attr);
+
+	if (fca->show)
+		return fca->show(get_fuse_conn_kobj(kobj), page);
+	else
+		return -EACCES;
+}
+
+static ssize_t fuse_conn_attr_store(struct kobject *kobj,
+				    struct attribute *attr,
+				    const char *page, size_t count)
+{
+	struct fuse_conn_attr *fca =
+		container_of(attr, struct fuse_conn_attr, attr);
+
+	if (fca->store)
+		return fca->store(get_fuse_conn_kobj(kobj), page, count);
+	else
+		return -EACCES;
+}
+
+static struct sysfs_ops fuse_conn_sysfs_ops = {
+	.show	= &fuse_conn_attr_show,
+	.store	= &fuse_conn_attr_store,
+};
+
+static struct kobj_type ktype_fuse_conn = {
+	.release	= fuse_conn_release,
+	.sysfs_ops	= &fuse_conn_sysfs_ops,
+	.default_attrs	= fuse_conn_attrs,
+};
+
+static decl_subsys(fuse, NULL, NULL);
+static decl_subsys(connections, &ktype_fuse_conn, NULL);
+
 static void fuse_inode_init_once(void *foo, kmem_cache_t *cachep,
 				 unsigned long flags)
 {
@@ -551,6 +636,34 @@ static void fuse_fs_cleanup(void)
 	kmem_cache_destroy(fuse_inode_cachep);
 }
 
+static int fuse_sysfs_init(void)
+{
+	int err;
+
+	kset_set_kset_s(&fuse_subsys, fs_subsys);
+	err = subsystem_register(&fuse_subsys);
+	if (err)
+		goto out_err;
+
+	kset_set_kset_s(&connections_subsys, fuse_subsys);
+	err = subsystem_register(&connections_subsys);
+	if (err)
+		goto out_fuse_unregister;
+
+	return 0;
+
+ out_fuse_unregister:
+	subsystem_unregister(&fuse_subsys);
+ out_err:
+	return err;
+}
+
+static void fuse_sysfs_cleanup(void)
+{
+	subsystem_unregister(&connections_subsys);
+	subsystem_unregister(&fuse_subsys);
+}
+
 static int __init fuse_init(void)
 {
 	int res;
@@ -567,8 +680,14 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_fs_cleanup;
 
+	res = fuse_sysfs_init();
+	if (res)
+		goto err_dev_cleanup;
+
 	return 0;
 
+ err_dev_cleanup:
+	fuse_dev_cleanup();
  err_fs_cleanup:
 	fuse_fs_cleanup();
  err:
@@ -579,6 +698,7 @@ static void __exit fuse_exit(void)
 {
 	printk(KERN_DEBUG "fuse exit\n");
 
+	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
 	fuse_dev_cleanup();
 }

--
