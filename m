Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVIROXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVIROXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVIROX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:26 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:31667 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932076AbVIROXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:11 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/12] HPPFS: fix access to ppos and file->f_pos
Date: Sun, 18 Sep 2005 16:09:51 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918140951.31461.78736.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro

Access to ->f_pos is racy, and it's not the fs task to update it.

Also, this code is still in the pre-2.6.8 world, when ppos was compared
against &file->f_pos to distinguish between normal reads and pread()s for
unseekable files, and so it performs dirty stuff to follow this rule for
the underlying procfs. (see http://lwn.net/Articles/96662/ - safe seeks).

For inner "struct file"s opened with dentry_open(), we can access safely
their ->f_pos field inside dentry_open(), when we are called by
hppfs_open() - in fact, there's one of them per file descriptor, and
there's no race as the fd has not yet been returned to userspace. See new
read_proc() comment.

Instead, we use the VFS readdir locking on inode->i_sem in hppfs_readdir.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -216,6 +216,15 @@ static struct dentry *hppfs_lookup(struc
 static struct inode_operations hppfs_file_iops = {
 };
 
+/* Pass down ppos when you're being called from userspace.
+ *
+ * Otherwise, if you pass NULL, we'll store the file position in file->f_pos,
+ * and you must have a lock on it. Since we're called only by hppfs_open ->
+ * hppfs_get_data, and open is serialized by the VFS, we're safe.
+ *
+ * We also know if we're called from userspace from is_user, which is used for
+ * set_fs(). I'm leaving this redundancy to bite any wrong caller.
+ */
 static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
 			 loff_t *ppos, int is_user)
 {
@@ -228,17 +237,21 @@ static ssize_t read_proc(struct file *fi
 	if (read == NULL)
 		return -EINVAL;
 
+	WARN_ON(is_user != (ppos != NULL));
+
 	if (!is_user) {
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 	}
 
-	n = (*read)(file, buf, count, &file->f_pos);
+	if (!ppos)
+		ppos = &file->f_pos;
+
+	n = (*read)(file, buf, count, ppos);
 
 	if (!is_user)
 		set_fs(old_fs);
 
-	if(ppos) *ppos = file->f_pos;
 	return n;
 }
 
@@ -330,9 +343,7 @@ static ssize_t hppfs_write(struct file *
 	if (write == NULL)
 		return -EINVAL;
 
-	proc_file->f_pos = file->f_pos;
-	err = (*write)(proc_file, buf, len, &proc_file->f_pos);
-	file->f_pos = proc_file->f_pos;
+	err = (*write)(proc_file, buf, len, ppos);
 
 	return(err);
 }
@@ -613,6 +624,7 @@ static int hppfs_readdir(struct file *fi
 	if (readdir == NULL)
 		return -ENOTDIR;
 
+	/* XXX: race on f_pos? Should be safe because we hold inode->i_sem. */
 	proc_file->f_pos = file->f_pos;
 	err = (*readdir)(proc_file, &dirent, hppfs_filldir);
 	file->f_pos = proc_file->f_pos;

