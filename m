Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTI1XZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTI1XZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:25:36 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58093 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262609AbTI1XZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:25:23 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:25:19 +0200 (MEST)
Message-Id: <UTC200309282325.h8SNPJT21048.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] autofs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs/root.c b/fs/autofs/root.c
--- a/fs/autofs/root.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs/root.c	Mon Sep 29 01:08:23 2003
@@ -468,7 +468,7 @@
 
 /* Get/set timeout ioctl() operation */
 static inline int autofs_get_set_timeout(struct autofs_sb_info *sbi,
-					 unsigned long *p)
+					 unsigned long __user *p)
 {
 	unsigned long ntimeout;
 
@@ -494,7 +494,7 @@
 static inline int autofs_expire_run(struct super_block *sb,
 				    struct autofs_sb_info *sbi,
 				    struct vfsmount *mnt,
-				    struct autofs_packet_expire *pkt_p)
+				    struct autofs_packet_expire __user *pkt_p)
 {
 	struct autofs_dir_ent *ent;
 	struct autofs_packet_expire pkt;
@@ -547,10 +547,10 @@
 	case AUTOFS_IOC_PROTOVER: /* Get protocol version */
 		return autofs_get_protover((int *)arg);
 	case AUTOFS_IOC_SETTIMEOUT:
-		return autofs_get_set_timeout(sbi,(unsigned long *)arg);
+		return autofs_get_set_timeout(sbi,(unsigned long __user *)arg);
 	case AUTOFS_IOC_EXPIRE:
 		return autofs_expire_run(inode->i_sb, sbi, filp->f_vfsmnt,
-					 (struct autofs_packet_expire *)arg);
+				 (struct autofs_packet_expire __user *)arg);
 	default:
 		return -ENOSYS;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs/symlink.c b/fs/autofs/symlink.c
--- a/fs/autofs/symlink.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs/symlink.c	Mon Sep 29 01:08:23 2003
@@ -12,7 +12,8 @@
 
 #include "autofs_i.h"
 
-static int autofs_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int
+autofs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
 	return vfs_readlink(dentry, buffer, buflen, s);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/autofs/waitq.c b/fs/autofs/waitq.c
--- a/fs/autofs/waitq.c	Mon Sep 29 01:05:41 2003
+++ b/fs/autofs/waitq.c	Mon Sep 29 01:08:23 2003
@@ -44,12 +44,16 @@
 	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
 }
 
+/*
+ * Note: addr not in user space
+ */
 static int autofs_write(struct file *file, const void *addr, int bytes)
 {
 	unsigned long sigpipe, flags;
 	mm_segment_t fs;
 	const char *data = (const char *)addr;
 	ssize_t wr = 0;
+	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
 
 	/** WARNING: this is not safe for writing more than PIPE_BUF bytes! **/
 
@@ -59,8 +63,12 @@
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
