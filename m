Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTI1X0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTI1X0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:26:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7150 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262746AbTI1X01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:26:27 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:26:23 +0200 (MEST)
Message-Id: <UTC200309282326.h8SNQN423602.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] autofs4 sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
--- a/fs/autofs4/autofs_i.h	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs4/autofs_i.h	Mon Sep 29 01:09:24 2003
@@ -132,9 +132,10 @@
 /* Expiration */
 int is_autofs4_dentry(struct dentry *);
 int autofs4_expire_run(struct super_block *, struct vfsmount *,
-			struct autofs_sb_info *, struct autofs_packet_expire *);
+		       struct autofs_sb_info *,
+		       struct autofs_packet_expire __user *);
 int autofs4_expire_multi(struct super_block *, struct vfsmount *,
-			struct autofs_sb_info *, int *);
+			struct autofs_sb_info *, int __user *);
 
 /* Operations structures */
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/expire.c b/fs/autofs4/expire.c
--- a/fs/autofs4/expire.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs4/expire.c	Mon Sep 29 01:09:24 2003
@@ -221,7 +221,7 @@
 int autofs4_expire_run(struct super_block *sb,
 		      struct vfsmount *mnt,
 		      struct autofs_sb_info *sbi,
-		      struct autofs_packet_expire *pkt_p)
+		      struct autofs_packet_expire __user *pkt_p)
 {
 	struct autofs_packet_expire pkt;
 	struct dentry *dentry;
@@ -248,7 +248,7 @@
 /* Call repeatedly until it returns -EAGAIN, meaning there's nothing
    more to be done */
 int autofs4_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			struct autofs_sb_info *sbi, int *arg)
+			struct autofs_sb_info *sbi, int __user *arg)
 {
 	struct dentry *dentry;
 	int ret = -EAGAIN;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/root.c b/fs/autofs4/root.c
--- a/fs/autofs4/root.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs4/root.c	Mon Sep 29 01:09:24 2003
@@ -542,12 +542,13 @@
 
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
-		return autofs4_expire_run(inode->i_sb,filp->f_vfsmnt,sbi,
-					  (struct autofs_packet_expire *)arg);
+		return autofs4_expire_run(inode->i_sb, filp->f_vfsmnt, sbi,
+				(struct autofs_packet_expire __user *) arg);
+
 	/* same as above, but can send multiple expires through pipe */
 	case AUTOFS_IOC_EXPIRE_MULTI:
-		return autofs4_expire_multi(inode->i_sb,filp->f_vfsmnt,sbi,
-					    (int *)arg);
+		return autofs4_expire_multi(inode->i_sb, filp->f_vfsmnt, sbi,
+					    (int __user *) arg);
 
 	default:
 		return -ENOSYS;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/symlink.c b/fs/autofs4/symlink.c
--- a/fs/autofs4/symlink.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs4/symlink.c	Mon Sep 29 01:09:24 2003
@@ -12,7 +12,8 @@
 
 #include "autofs_i.h"
 
-static int autofs4_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int
+autofs4_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
--- a/fs/autofs4/waitq.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs4/waitq.c	Mon Sep 29 01:09:24 2003
@@ -54,6 +54,7 @@
 	mm_segment_t fs;
 	const char *data = (const char *)addr;
 	ssize_t wr = 0;
+        ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
 
 	/** WARNING: this is not safe for writing more than PIPE_BUF bytes! **/
 
@@ -63,8 +64,12 @@
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
+	/* Our write does not write to user space */
+	write = (ssize_t (*)(struct file *, const char *, size_t, loff_t *))
+		file->f_op->write;
+
 	while (bytes &&
-	       (wr = file->f_op->write(file,data,bytes,&file->f_pos)) > 0) {
+	       (wr = write(file,data,bytes,&file->f_pos)) > 0) {
 		data += wr;
 		bytes -= wr;
 	}
