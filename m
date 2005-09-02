Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbVIBVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVIBVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVIBVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:22:29 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:36620 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161049AbVIBVW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:22:26 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: more flexible caching
Message-Id: <E1EBIyt-0006Bk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 02 Sep 2005 23:21:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make data caching behavior selectable on a per-open basis instead of
per-mount.  Compatibility for the old mount options 'kernel_cache' and
'direct_io' is retained in the userspace library (version 2.4.0-pre1
or later).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2005-08-23 20:25:17.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2005-09-02 20:37:12.000000000 +0200
@@ -80,32 +80,6 @@ Mount options
   allowed to root, but this restriction can be removed with a
   (userspace) configuration option.
 
-'kernel_cache'
-
-  This option disables flushing the cache of the file contents on
-  every open().  This should only be enabled on filesystems, where the
-  file data is never changed externally (not through the mounted FUSE
-  filesystem).  Thus it is not suitable for network filesystems and
-  other "intermediate" filesystems.
-
-  NOTE: if this option is not specified (and neither 'direct_io') data
-  is still cached after the open(), so a read() system call will not
-  always initiate a read operation.
-
-'direct_io'
-
-  This option disables the use of page cache (file content cache) in
-  the kernel for this filesystem.  This has several affects:
-
-     - Each read() or write() system call will initiate one or more
-       read or write operations, data will not be cached in the
-       kernel.
-
-     - The return value of the read() and write() system calls will
-       correspond to the return values of the read and write
-       operations.  This is useful for example if the file size is not
-       known in advance (before reading it).
-
 'max_read=N'
 
   With this option the maximum size of read operations can be set.
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2005-08-23 21:46:34.000000000 +0200
+++ linux/fs/fuse/file.c	2005-09-02 20:37:34.000000000 +0200
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 
+static struct file_operations fuse_direct_io_file_operations;
+
 int fuse_open_common(struct inode *inode, struct file *file, int isdir)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -61,12 +63,14 @@ int fuse_open_common(struct inode *inode
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err && !(fc->flags & FUSE_KERNEL_CACHE))
-		invalidate_inode_pages(inode->i_mapping);
 	if (err) {
 		fuse_request_free(ff->release_req);
 		kfree(ff);
 	} else {
+		if (!isdir && (outarg.open_flags & FOPEN_DIRECT_IO))
+			file->f_op = &fuse_direct_io_file_operations;
+		if (!(outarg.open_flags & FOPEN_KEEP_CACHE))
+			invalidate_inode_pages(inode->i_mapping);
 		ff->fh = outarg.fh;
 		file->private_data = ff;
 	}
@@ -546,12 +550,6 @@ static struct address_space_operations f
 
 void fuse_init_file_inode(struct inode *inode)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	if (fc->flags & FUSE_DIRECT_IO)
-		inode->i_fop = &fuse_direct_io_file_operations;
-	else {
-		inode->i_fop = &fuse_file_operations;
-		inode->i_data.a_ops = &fuse_file_aops;
-	}
+	inode->i_fop = &fuse_file_operations;
+	inode->i_data.a_ops = &fuse_file_aops;
 }
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2005-08-23 21:46:34.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2005-09-02 20:37:12.000000000 +0200
@@ -30,12 +30,6 @@
     doing the mount will be allowed to access the filesystem */
 #define FUSE_ALLOW_OTHER         (1 << 1)
 
-/** If the FUSE_KERNEL_CACHE flag is given, then cached data will not
-    be flushed on open */
-#define FUSE_KERNEL_CACHE        (1 << 2)
-
-/** Bypass the page cache for read and write operations  */
-#define FUSE_DIRECT_IO           (1 << 3)
 
 /** FUSE inode */
 struct fuse_inode {
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2005-08-23 20:25:52.000000000 +0200
+++ linux/fs/fuse/inode.c	2005-09-02 20:37:12.000000000 +0200
@@ -258,8 +258,6 @@ enum {
 	OPT_GROUP_ID,
 	OPT_DEFAULT_PERMISSIONS,
 	OPT_ALLOW_OTHER,
-	OPT_KERNEL_CACHE,
-	OPT_DIRECT_IO,
 	OPT_MAX_READ,
 	OPT_ERR
 };
@@ -271,8 +269,6 @@ static match_table_t tokens = {
 	{OPT_GROUP_ID,			"group_id=%u"},
 	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
 	{OPT_ALLOW_OTHER,		"allow_other"},
-	{OPT_KERNEL_CACHE,		"kernel_cache"},
-	{OPT_DIRECT_IO,			"direct_io"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_ERR,			NULL}
 };
@@ -328,14 +324,6 @@ static int parse_fuse_opt(char *opt, str
 			d->flags |= FUSE_ALLOW_OTHER;
 			break;
 
-		case OPT_KERNEL_CACHE:
-			d->flags |= FUSE_KERNEL_CACHE;
-			break;
-
-		case OPT_DIRECT_IO:
-			d->flags |= FUSE_DIRECT_IO;
-			break;
-
 		case OPT_MAX_READ:
 			if (match_int(&args[0], &value))
 				return 0;
@@ -364,10 +352,6 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",default_permissions");
 	if (fc->flags & FUSE_ALLOW_OTHER)
 		seq_puts(m, ",allow_other");
-	if (fc->flags & FUSE_KERNEL_CACHE)
-		seq_puts(m, ",kernel_cache");
-	if (fc->flags & FUSE_DIRECT_IO)
-		seq_puts(m, ",direct_io");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	return 0;
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-08-23 21:46:34.000000000 +0200
+++ linux/include/linux/fuse.h	2005-09-02 20:37:12.000000000 +0200
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 1
+#define FUSE_KERNEL_MINOR_VERSION 2
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -63,6 +63,15 @@ struct fuse_kstatfs {
 #define FATTR_MTIME	(1 << 5)
 #define FATTR_CTIME	(1 << 6)
 
+/**
+ * Flags returned by the OPEN request
+ *
+ * FOPEN_DIRECT_IO: bypass page cache for this open file
+ * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
+ */
+#define FOPEN_DIRECT_IO		(1 << 0)
+#define FOPEN_KEEP_CACHE	(1 << 1)
+
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
 	FUSE_FORGET	   = 2,  /* no reply */
