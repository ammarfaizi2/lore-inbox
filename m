Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUKTXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUKTXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUKTXj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:39:26 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:16780 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263222AbUKTXNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:13:41 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] Filesystem in Userspace
Message-Id: <E1CVeQA-0007SE-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:13:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for user initiated invalidation of page cache
for a file.

This is useful if the filesystem receives events of file changes and
can inform the kernel that the cached data is no longer valid.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dev.c	2004-11-20 22:56:22.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dev.c	2004-11-20 22:56:21.000000000 +0100
@@ -381,6 +381,51 @@ static inline int copy_out_header(struct
 	return 0;
 }
 
+static int fuse_invalidate(struct fuse_conn *fc, struct fuse_user_header *uh)
+{
+	int err;
+	down(&fc->sb_sem);
+	err = -ENODEV;
+	if (fc->sb) {
+		struct inode *inode;
+		inode = fuse_ilookup(fc->sb, uh->nodeid);
+		err = -ENOENT;
+		if (inode) {
+			invalidate_inode_pages(inode->i_mapping);
+			iput(inode);
+			err = 0;
+		}
+	}
+	up(&fc->sb_sem);
+
+	return err;
+}
+
+static int fuse_user_request(struct fuse_conn *fc, const char __user *buf,
+			     size_t nbytes)
+{
+	struct fuse_user_header uh;
+	int err;
+
+	if (nbytes < sizeof(struct fuse_user_header)) {
+		printk("fuse_dev_write: write is short\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&uh, buf, sizeof(struct fuse_user_header)))
+		return -EFAULT;
+	
+	switch (uh.opcode) {
+	case FUSE_INVALIDATE:
+		err = fuse_invalidate(fc, &uh);
+		break;
+
+	default:
+		err = -ENOSYS;
+	}
+	return err;
+}
+    
 static ssize_t fuse_dev_write(struct file *file, const char __user *buf,
 			      size_t nbytes, loff_t *off)
 {
@@ -397,7 +442,7 @@ static ssize_t fuse_dev_write(struct fil
 		return err;
 
 	if (!oh.unique)	{
-		err = -EINVAL;
+		err = fuse_user_request(fc, buf, nbytes);
 		goto out;
 	}     
 
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:22.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:21.000000000 +0100
@@ -160,6 +160,9 @@ struct fuse_conn {
 	/** Controls the maximum number of outstanding requests */
 	struct semaphore unused_sem;
 
+	/** Semaphore protecting the super block from going away */
+	struct semaphore sb_sem;
+
 	/** The list of unused requests */
 	struct list_head unused_list;
 	
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:22.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:21.000000000 +0100
@@ -95,8 +95,10 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = SB_FC(sb);
 
+	down(&fc->sb_sem);
 	spin_lock(&fuse_lock);
 	fc->sb = NULL;
+	up(&fc->sb_sem);
 	fc->uid = 0;
 	fc->flags = 0;
 	/* Flush all readers on this fs */
@@ -286,6 +288,7 @@ static struct fuse_conn *new_conn(void)
 		INIT_LIST_HEAD(&fc->processing);
 		INIT_LIST_HEAD(&fc->unused_list);
 		sema_init(&fc->unused_sem, FUSE_MAX_OUTSTANDING);
+		sema_init(&fc->sb_sem, 1);
 		for (i = 0; i < FUSE_MAX_OUTSTANDING; i++) {
 			struct fuse_req *req = fuse_request_alloc();
 			if (!req) {
@@ -460,8 +463,10 @@ static int fuse_read_super(struct super_
 	return 0;
 
  err:
+	down(&fc->sb_sem);
 	spin_lock(&fuse_lock);
 	fc->sb = NULL;
+	up(&fc->sb_sem);
 	fuse_release_conn(fc);
 	spin_unlock(&fuse_lock);
 	SB_FC(sb) = NULL;
--- linux-2.6.10-rc2/include/linux/fuse.h	2004-11-20 22:56:22.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:41:37.000000000 +0100
@@ -77,7 +77,7 @@ enum fuse_opcode {
 	FUSE_WRITE	   = 16,
 	FUSE_STATFS	   = 17,
 	FUSE_RELEASE       = 18,
-	/* FUSE_INVALIDATE    = 19, */
+	FUSE_INVALIDATE    = 19, /* user initiated */
 	FUSE_FSYNC         = 20,
 	FUSE_SETXATTR      = 21,
 	FUSE_GETXATTR      = 22,
@@ -212,6 +212,14 @@ struct fuse_out_header {
 	int error;
 };
 
+struct fuse_user_header {
+	int unique; /* zero */
+	enum fuse_opcode opcode;
+	unsigned long nodeid;
+	unsigned long ino;  /* Needed only on 2.4.x where ino is also
+			       used for inode lookup */
+};
+
 struct fuse_dirent {
 	unsigned long ino;
 	unsigned short namelen;
