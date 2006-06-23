Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWFWRX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWFWRX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWFWRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:23:26 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:21126 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751809AbWFWRXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:23:25 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fuse: scramble lock owner ID
Message-Id: <E1FtpMu-0002JS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Jun 2006 19:22:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VFS uses current->files pointer as lock owner ID, and it wouldn't be
prudent to expose this value to userspace.  So scramble it with XTEA
using a per connection random key, known only to the kernel.  Only one
direction needs to be implemented, since the ID is never sent in the
reverse direction.

The XTEA algorithm is implemented inline since it's simple enough to
do so, and this adds less complexity than if the crypto API were used.

Thanks to Jesper Juhl for the idea.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-06-19 11:18:36.000000000 +0200
+++ linux/fs/fuse/file.c	2006-06-19 12:32:21.000000000 +0200
@@ -161,15 +161,25 @@ static int fuse_release(struct inode *in
 }
 
 /*
- * It would be nice to scramble the ID space, so that the value of the
- * files_struct pointer is not exposed to userspace.  Symmetric crypto
- * functions are overkill, since the inverse function doesn't need to
- * be implemented (though it does have to exist).  Is there something
- * simpler?
+ * Scramble the ID space with XTEA, so that the value of the files_struct
+ * pointer is not exposed to userspace.
  */
-static inline u64 fuse_lock_owner_id(fl_owner_t id)
+static u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
 {
-	return (unsigned long) id;
+	u32 *k = fc->scramble_key;
+	u64 v = (unsigned long) id;
+	u32 v0 = v;
+	u32 v1 = v >> 32;
+	u32 sum = 0;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		v0 += ((v1 << 4 ^ v1 >> 5) + v1) ^ (sum + k[sum & 3]);
+		sum += 0x9E3779B9;
+		v1 += ((v0 << 4 ^ v0 >> 5) + v0) ^ (sum + k[sum>>11 & 3]);
+	}
+
+	return (u64) v0 + ((u64) v1 << 32);
 }
 
 static int fuse_flush(struct file *file, fl_owner_t id)
@@ -190,7 +200,7 @@ static int fuse_flush(struct file *file,
 	req = fuse_get_req_nofail(fc, file);
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
-	inarg.lock_owner = fuse_lock_owner_id(id);
+	inarg.lock_owner = fuse_lock_owner_id(fc, id);
 	req->in.h.opcode = FUSE_FLUSH;
 	req->in.h.nodeid = get_node_id(inode);
 	req->in.numargs = 1;
@@ -644,11 +654,12 @@ static void fuse_lk_fill(struct fuse_req
 			 const struct file_lock *fl, int opcode, pid_t pid)
 {
 	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_file *ff = file->private_data;
 	struct fuse_lk_in *arg = &req->misc.lk_in;
 
 	arg->fh = ff->fh;
-	arg->owner = fuse_lock_owner_id(fl->fl_owner);
+	arg->owner = fuse_lock_owner_id(fc, fl->fl_owner);
 	arg->lk.start = fl->fl_start;
 	arg->lk.end = fl->fl_end;
 	arg->lk.type = fl->fl_type;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-19 11:53:59.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-19 11:56:39.000000000 +0200
@@ -359,6 +359,9 @@ struct fuse_conn {
 
 	/** O_ASYNC requests */
 	struct fasync_struct *fasync;
+
+	/** Key for lock owner ID scrambling */
+	u32 scramble_key[4];
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-06-19 12:17:16.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-06-19 12:32:39.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/statfs.h>
+#include <linux/random.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -387,6 +388,7 @@ static struct fuse_conn *new_conn(void)
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
 		fc->reqctr = 0;
 		fc->blocked = 1;
+		get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	}
 	return fc;
 }
