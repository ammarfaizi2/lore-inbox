Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbUKTXgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUKTXgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUKTXd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:33:58 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:53131 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263215AbUKTXLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:11:42 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/13] Filesystem in Userspace
Message-Id: <E1CVeO9-0007Qg-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:11:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds miscellaneous mount options to the FUSE filesystem.

The following mount options are added:

 o default_permissions:  check permissions with generic_permission()
 o allow_other:          allow other users to access files
 o allow_root:           allow root to access files
 o kernel_cache:         don't invalidate page cache on open

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:23.000000000 +0100
@@ -519,7 +519,10 @@ static int fuse_revalidate(struct dentry
 	struct fuse_conn *fc = INO_FC(inode);
 
 	if (fi->nodeid == FUSE_ROOT_ID) {
-		if (current->fsuid != fc->uid)
+		if (!(fc->flags & FUSE_ALLOW_OTHER) &&
+		    current->fsuid != fc->uid &&
+		    (!(fc->flags & FUSE_ALLOW_ROOT) ||
+		     current->fsuid != 0))
 			return -EACCES;
 	} else if (!fi->i_time || time_before_eq(jiffies, fi->i_time))
 		return 0;
@@ -531,9 +534,34 @@ static int fuse_permission(struct inode 
 {
 	struct fuse_conn *fc = INO_FC(inode);
 
-	if (current->fsuid != fc->uid)
+	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->uid &&
+	    (!(fc->flags & FUSE_ALLOW_ROOT) || current->fsuid != 0))
 		return -EACCES;
-	else
+	else if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
+		int err;
+		err = generic_permission(inode, mask, NULL);
+
+		/* If permission is denied, try to refresh file
+		   attributes.  This is also needed, because the root
+		   node will at first have no permissions */
+
+		if (err == -EACCES) {
+		 	err = fuse_do_getattr(inode);
+			if (!err)
+				err = generic_permission(inode, mask, NULL);
+		}
+
+		/* FIXME: Need some mechanism to revoke permissions:
+		   currently if the filesystem suddenly changes the
+		   file mode, we will not be informed about it, and
+		   continue to allow access to the file/directory.
+		   
+		   This is actually not so grave, since the user can
+		   simply keep access to the file/directory anyway by
+		   keeping it open... */
+
+		return err;
+	} else
 		return 0;
 }
 
@@ -750,6 +778,12 @@ static int fuse_setattr(struct dentry *e
 	int err;
 	int is_truncate = 0;
 	
+	if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
+		err = inode_change_ok(inode, attr);
+		if (err)
+			return err;
+	}
+
 	if (attr->ia_valid & ATTR_SIZE) {
 		unsigned long limit;
 		is_truncate = 1;
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:23.000000000 +0100
@@ -17,6 +17,24 @@
 /* If more requests are outstanding, then the operation will block */
 #define FUSE_MAX_OUTSTANDING 10
 
+
+/** If the FUSE_DEFAULT_PERMISSIONS flag is given, the filesystem
+module will check permissions based on the file mode.  Otherwise no
+permission checking is done in the kernel */
+#define FUSE_DEFAULT_PERMISSIONS (1 << 0)
+
+/** If the FUSE_ALLOW_OTHER flag is given, then not only the user
+    doing the mount will be allowed to access the filesystem */
+#define FUSE_ALLOW_OTHER         (1 << 1)
+
+/** If the FUSE_KERNEL_CACHE flag is given, then files will be cached
+    until the INVALIDATE operation is invoked */
+#define FUSE_KERNEL_CACHE        (1 << 2)
+
+/** Allow root and setuid-root programs to access fuse-mounted
+    filesystems */
+#define FUSE_ALLOW_ROOT		 (1 << 4)
+
 /** FUSE specific inode data */
 struct fuse_inode {
 	unsigned long nodeid;
@@ -108,6 +126,9 @@ struct fuse_conn {
 	/** The user id for this mount */
 	uid_t uid;
 
+	/** The fuse mount flags for this mount */
+	unsigned int flags;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:23.000000000 +0100
@@ -20,12 +20,17 @@
 
 static kmem_cache_t *fuse_inode_cachep;
 
+static int user_allow_other;
+module_param(user_allow_other, int, 0644);
+MODULE_PARM_DESC(user_allow_other, "Allow non root user to specify the \"allow_other\" or \"allow_root\" mount options");
+
 #define FUSE_SUPER_MAGIC 0x65735546
 
 struct fuse_mount_data {
 	int fd;
 	unsigned int rootmode;
 	unsigned int uid;
+	unsigned int flags;
 };
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
@@ -92,6 +97,7 @@ static void fuse_put_super(struct super_
 	spin_lock(&fuse_lock);
 	fc->sb = NULL;
 	fc->uid = 0;
+	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
 	fuse_release_conn(fc);
@@ -140,6 +146,10 @@ enum {
 	OPT_FD,
 	OPT_ROOTMODE,
 	OPT_UID,
+	OPT_DEFAULT_PERMISSIONS, 
+	OPT_ALLOW_OTHER,
+	OPT_ALLOW_ROOT,
+	OPT_KERNEL_CACHE,
 	OPT_ERR 
 };
 
@@ -147,6 +157,10 @@ static match_table_t tokens = {
 	{OPT_FD,			"fd=%u"},
 	{OPT_ROOTMODE,			"rootmode=%o"},
 	{OPT_UID,			"uid=%u"},
+	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
+	{OPT_ALLOW_OTHER,		"allow_other"},
+	{OPT_ALLOW_ROOT,		"allow_root"},
+	{OPT_KERNEL_CACHE,		"kernel_cache"},
 	{OPT_ERR,			NULL}
 };
 
@@ -183,6 +197,22 @@ static int parse_fuse_opt(char *opt, str
 			d->uid = value;
 			break;
 			
+		case OPT_DEFAULT_PERMISSIONS:
+			d->flags |= FUSE_DEFAULT_PERMISSIONS;
+			break;
+
+		case OPT_ALLOW_OTHER:
+			d->flags |= FUSE_ALLOW_OTHER;
+			break;
+
+		case OPT_ALLOW_ROOT:
+			d->flags |= FUSE_ALLOW_ROOT;
+			break;
+
+		case OPT_KERNEL_CACHE:
+			d->flags |= FUSE_KERNEL_CACHE;
+			break;
+
 		default:
 			return 0;
 		}
@@ -198,6 +228,14 @@ static int fuse_show_options(struct seq_
 	struct fuse_conn *fc = SB_FC(mnt->mnt_sb);
 
 	seq_printf(m, ",uid=%u", fc->uid);
+	if (fc->flags & FUSE_DEFAULT_PERMISSIONS)
+		seq_puts(m, ",default_permissions");
+	if (fc->flags & FUSE_ALLOW_OTHER)
+		seq_puts(m, ",allow_other");
+	if (fc->flags & FUSE_ALLOW_ROOT)
+		seq_puts(m, ",allow_root");
+	if (fc->flags & FUSE_KERNEL_CACHE)
+		seq_puts(m, ",kernel_cache");
 	return 0;
 }
 
@@ -229,6 +267,7 @@ static struct fuse_conn *new_conn(void)
 		memset(fc, 0, sizeof(*fc));
 		fc->sb = NULL;
 		fc->file = NULL;
+		fc->flags = 0;
 		fc->uid = 0;
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
@@ -306,6 +345,11 @@ static int fuse_read_super(struct super_
 	if (!parse_fuse_opt((char *) data, &d))
 		return -EINVAL;
 
+	if (!user_allow_other &&
+	    (d.flags & (FUSE_ALLOW_OTHER | FUSE_ALLOW_ROOT)) &&
+	    current->uid != 0)
+		return -EPERM;
+
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = FUSE_SUPER_MAGIC;
@@ -321,6 +365,7 @@ static int fuse_read_super(struct super_
 	if (fc == NULL)
 		return -EINVAL;
 
+	fc->flags = d.flags;
 	fc->uid = d.uid;
 	
 	SB_FC(sb) = fc;
--- linux-2.6.10-rc2/fs/fuse/file.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/file.c	2004-11-20 22:56:23.000000000 +0100
@@ -63,7 +63,7 @@ static int fuse_open(struct inode *inode
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err) {
+	if (!err && !(fc->flags & FUSE_KERNEL_CACHE)) {
 		invalidate_inode_pages(inode->i_mapping);
 	}
 	if (err) {
