Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCaRyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCaRyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWCaRyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:54:38 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:22235 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932162AbWCaRyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:54:37 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 5/10] fuse: simplify locking
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNpE-0005cM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:54:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is in preparation for removing the global spinlock in favor of a
per-mount one.

The only critical part is the interaction between fuse_dev_release()
and fuse_fill_super(): fuse_dev_release() must see the assignment to
file->private_data, otherwise it will leak the reference to fuse_conn.

This is ensured by the fput() operation, which will synchronize the
assignment with other CPU's that may do a final fput() soon after
this.

Also redundant locking is removed from fuse_fill_super(), where
exclusion is already ensured by the BKL held for this function by the
VFS.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
@@ -23,13 +23,11 @@ static kmem_cache_t *fuse_req_cachep;
 
 static struct fuse_conn *fuse_get_conn(struct file *file)
 {
-	struct fuse_conn *fc;
-	spin_lock(&fuse_lock);
-	fc = file->private_data;
-	if (fc && !fc->connected)
-		fc = NULL;
-	spin_unlock(&fuse_lock);
-	return fc;
+	/*
+	 * Lockless access is OK, because file->private data is set
+	 * once during mount and is valid until the file is released.
+	 */
+	return file->private_data;
 }
 
 static void fuse_request_init(struct fuse_req *req)
@@ -607,19 +605,16 @@ static ssize_t fuse_dev_readv(struct fil
 			      unsigned long nr_segs, loff_t *off)
 {
 	int err;
-	struct fuse_conn *fc;
 	struct fuse_req *req;
 	struct fuse_in *in;
 	struct fuse_copy_state cs;
 	unsigned reqsize;
+	struct fuse_conn *fc = fuse_get_conn(file);
+	if (!fc)
+		return -EPERM;
 
  restart:
 	spin_lock(&fuse_lock);
-	fc = file->private_data;
-	err = -EPERM;
-	if (!fc)
-		goto err_unlock;
-
 	err = -EAGAIN;
 	if((file->f_flags & O_NONBLOCK) && fc->connected &&
 	   list_empty(&fc->pending))
@@ -915,17 +910,13 @@ void fuse_abort_conn(struct fuse_conn *f
 
 static int fuse_dev_release(struct inode *inode, struct file *file)
 {
-	struct fuse_conn *fc;
-
-	spin_lock(&fuse_lock);
-	fc = file->private_data;
+	struct fuse_conn *fc = fuse_get_conn(file);
 	if (fc) {
+		spin_lock(&fuse_lock);
 		fc->connected = 0;
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
-	}
-	spin_unlock(&fuse_lock);
-	if (fc) {
+		spin_unlock(&fuse_lock);
 		fasync_helper(-1, file, 0, &fc->fasync);
 		kobject_put(&fc->kobj);
 	}
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
@@ -414,37 +414,6 @@ static struct fuse_conn *new_conn(void)
 	return fc;
 }
 
-static struct fuse_conn *get_conn(struct file *file, struct super_block *sb)
-{
-	struct fuse_conn *fc;
-	int err;
-
-	err = -EINVAL;
-	if (file->f_op != &fuse_dev_operations)
-		goto out_err;
-
-	err = -ENOMEM;
-	fc = new_conn();
-	if (!fc)
-		goto out_err;
-
-	spin_lock(&fuse_lock);
-	err = -EINVAL;
-	if (file->private_data)
-		goto out_unlock;
-
-	kobject_get(&fc->kobj);
-	file->private_data = fc;
-	spin_unlock(&fuse_lock);
-	return fc;
-
- out_unlock:
-	spin_unlock(&fuse_lock);
-	kobject_put(&fc->kobj);
- out_err:
-	return ERR_PTR(err);
-}
-
 static struct inode *get_root_inode(struct super_block *sb, unsigned mode)
 {
 	struct fuse_attr attr;
@@ -526,12 +495,9 @@ static void fuse_send_init(struct fuse_c
 
 static unsigned long long conn_id(void)
 {
+	/* BKL is held for ->get_sb() */
 	static unsigned long long ctr = 1;
-	unsigned long long val;
-	spin_lock(&fuse_lock);
-	val = ctr++;
-	spin_unlock(&fuse_lock);
-	return val;
+	return ctr++;
 }
 
 static int fuse_fill_super(struct super_block *sb, void *data, int silent)
@@ -556,10 +522,17 @@ static int fuse_fill_super(struct super_
 	if (!file)
 		return -EINVAL;
 
-	fc = get_conn(file, sb);
-	fput(file);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
+	if (file->f_op != &fuse_dev_operations)
+		return -EINVAL;
+
+	/* Setting file->private_data can't race with other mount()
+	   instances, since BKL is held for ->get_sb() */
+	if (file->private_data)
+		return -EINVAL;
+
+	fc = new_conn();
+	if (!fc)
+		return -ENOMEM;
 
 	fc->flags = d.flags;
 	fc->user_id = d.user_id;
@@ -589,10 +562,16 @@ static int fuse_fill_super(struct super_
 		goto err_put_root;
 
 	sb->s_root = root_dentry;
-	spin_lock(&fuse_lock);
 	fc->mounted = 1;
 	fc->connected = 1;
-	spin_unlock(&fuse_lock);
+	kobject_get(&fc->kobj);
+	file->private_data = fc;
+	/*
+	 * atomic_dec_and_test() in fput() provides the necessary
+	 * memory barrier for file->private_data to be visible on all
+	 * CPUs after this
+	 */
+	fput(file);
 
 	fuse_send_init(fc);
 
@@ -601,6 +580,7 @@ static int fuse_fill_super(struct super_
  err_put_root:
 	dput(root_dentry);
  err:
+	fput(file);
 	kobject_put(&fc->kobj);
 	return err;
 }
