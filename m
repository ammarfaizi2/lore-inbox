Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbXAIBjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXAIBjO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbXAIBjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:39:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:62909 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbXAIBjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:39:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:from;
        b=mqEgBh9lQvRG+cimpQL4ISLfC2/iRfEQttlHt3jAt90T1YGm06COrHGkvty/FhW5nTA5sQjnGOAktQoYn+vcw6L3E1I/nnLyZ7KtenQCZxIHpMHri8//jN5UJdjAACcBzORrWhm1VRmO69FaIjJ60AcwQcbXadd+cLk9SWY1M8E=
Date: Mon, 8 Jan 2007 17:43:09 -0800 (PST)
To: linux-kernel@vger.kernel.org, hugh@veritas.com, hch@infradead.com,
       kenneth.w.chen@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] support O_DIRECT in tmpfs/ramfs
Message-ID: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago there was a discussion about supporting direct-io on tmpfs.

Here is a simple patch that does it.

1. A new fs flag FS_RAM_BASED is added and the O_DIRECT flag is ignored
   if this flag is set (suggestions on a better name?)

2. Specify FS_RAM_BASED for tmpfs and ramfs.

3. When EINVAL is returned only a fput is done. I changed it to go
   through cleanup_all. But there is still a cleanup problem:

  If a new file is created and then EINVAL is returned due to O_DIRECT,
  the file is still left on the disk. I am not exactly sure how to fix
  it other than adding another fs flag so we could check O_DIRECT
  support at a much earlier stage. Comments on how to fix it?

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/fs/open.c b/fs/open.c
index c989fb4..c03285f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -708,11 +708,13 @@ static struct file *__dentry_open(struct
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops ||
-		    ((!f->f_mapping->a_ops->direct_IO) &&
-		    (!f->f_mapping->a_ops->get_xip_page))) {
-			fput(f);
-			f = ERR_PTR(-EINVAL);
+		if (dentry->d_sb->s_type->fs_flags & FS_RAM_BASED)
+			f->f_flags &= ~O_DIRECT;
+		else if (!f->f_mapping->a_ops ||
+			 ((!f->f_mapping->a_ops->direct_IO) &&
+			  (!f->f_mapping->a_ops->get_xip_page))) {
+			error = -EINVAL;
+			goto cleanup_all;
 		}
 	}
 
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 2faf4cd..0d4bebc 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -199,11 +199,13 @@ static int rootfs_get_sb(struct file_sys
 
 static struct file_system_type ramfs_fs_type = {
 	.name		= "ramfs",
+	.fs_flags	= FS_RAM_BASED,
 	.get_sb		= ramfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
 static struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
+	.fs_flags	= FS_RAM_BASED,	
 	.get_sb		= rootfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 186da81..0d95988 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -91,6 +91,7 @@ extern int dir_notify_enable;
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_RAM_BASED	8192	/* Ignore O_DIRECT */
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move()
 					 * during rename() internally.
diff --git a/mm/shmem.c b/mm/shmem.c
index 70da7a0..5d23e8a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2413,6 +2413,7 @@ static int shmem_get_sb(struct file_syst
 static struct file_system_type tmpfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "tmpfs",
+	.fs_flags	= FS_RAM_BASED,
 	.get_sb		= shmem_get_sb,
 	.kill_sb	= kill_litter_super,
 };
