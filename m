Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVAKQuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVAKQuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVAKQti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:49:38 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:31104 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262834AbVAKQ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:29:58 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/11] FUSE - mount options
Message-Id: <E1CoOtq-0003LZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:29:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds miscellaneous mount options to the FUSE filesystem.

The following mount options are added:

 o default_permissions:  check permissions with generic_permission()
 o allow_other:          allow other users to access files
 o allow_root:           allow root to access files
 o kernel_cache:         don't invalidate page cache on open

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/dir.c b/fs/fuse/dir.c
--- a/fs/fuse/dir.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/dir.c	2005-01-11 16:28:28.000000000 +0100
@@ -419,7 +419,10 @@ static int fuse_revalidate(struct dentry
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	if (get_node_id(inode) == FUSE_ROOT_ID) {
-		if (current->fsuid != fc->user_id)
+		if (!(fc->flags & FUSE_ALLOW_OTHER) &&
+		    current->fsuid != fc->user_id &&
+		    (!(fc->flags & FUSE_ALLOW_ROOT) ||
+		     current->fsuid != 0))
 			return -EACCES;
 	} else if (time_before_eq(jiffies, fi->i_time))
 		return 0;
@@ -431,9 +434,32 @@ static int fuse_permission(struct inode 
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (current->fsuid != fc->user_id)
+	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id &&
+	    (!(fc->flags & FUSE_ALLOW_ROOT) || current->fsuid != 0))
 		return -EACCES;
-	else {
+	else if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
+		int err = generic_permission(inode, mask, NULL);
+
+		/* If permission is denied, try to refresh file
+		   attributes.  This is also needed, because the root
+		   node will at first have no permissions */
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
+	} else {
 		int mode = inode->i_mode;
 		if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
                     (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
@@ -637,6 +663,12 @@ static int fuse_setattr(struct dentry *e
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
diff -Nurp a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
@@ -61,7 +61,7 @@ static int fuse_open(struct inode *inode
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (!err)
+	if (!err && !(fc->flags & FUSE_KERNEL_CACHE))
 		invalidate_inode_pages(inode->i_mapping);
 	if (err) {
 		fuse_request_free(ff->release_req);
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
@@ -21,6 +21,23 @@
 /** If more requests are outstanding, then the operation will block */
 #define FUSE_MAX_OUTSTANDING 10
 
+/** If the FUSE_DEFAULT_PERMISSIONS flag is given, the filesystem
+    module will check permissions based on the file mode.  Otherwise no
+    permission checking is done in the kernel */
+#define FUSE_DEFAULT_PERMISSIONS (1 << 0)
+
+/** If the FUSE_ALLOW_OTHER flag is given, then not only the user
+    doing the mount will be allowed to access the filesystem */
+#define FUSE_ALLOW_OTHER         (1 << 1)
+
+/** If the FUSE_KERNEL_CACHE flag is given, then cached data will not
+    be flushed on open */
+#define FUSE_KERNEL_CACHE        (1 << 2)
+
+/** Allow root and setuid-root programs to access fuse-mounted
+    filesystems */
+#define FUSE_ALLOW_ROOT		 (1 << 4)
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -182,6 +199,9 @@ struct fuse_conn {
 	/** The user id for this mount */
 	uid_t user_id;
 
+	/** The fuse mount flags for this mount */
+	unsigned flags;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
@@ -27,6 +27,10 @@ spinlock_t fuse_lock;
 static kmem_cache_t *fuse_inode_cachep;
 static int mount_count;
 
+static int user_allow_other;
+module_param(user_allow_other, int, 0644);
+MODULE_PARM_DESC(user_allow_other, "Allow non root user to specify the \"allow_other\" or \"allow_root\" mount options");
+
 static int mount_max = 1000;
 module_param(mount_max, int, 0644);
 MODULE_PARM_DESC(mount_max, "Maximum number of FUSE mounts allowed, if -1 then unlimited (default: 1000)");
@@ -37,6 +41,7 @@ struct fuse_mount_data {
 	int fd;
 	unsigned rootmode;
 	unsigned user_id;
+	unsigned flags;
 };
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
@@ -196,6 +201,7 @@ static void fuse_put_super(struct super_
 	mount_count --;
 	fc->sb = NULL;
 	fc->user_id = 0;
+	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
 	fuse_release_conn(fc);
@@ -295,6 +301,22 @@ static int parse_fuse_opt(char *opt, str
 			d->user_id = value;
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
@@ -310,6 +332,14 @@ static int fuse_show_options(struct seq_
 	struct fuse_conn *fc = get_fuse_conn_super(mnt->mnt_sb);
 
 	seq_printf(m, ",user_id=%u", fc->user_id);
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
 
@@ -341,6 +371,7 @@ static struct fuse_conn *new_conn(void)
 		memset(fc, 0, sizeof(*fc));
 		fc->sb = NULL;
 		fc->file = NULL;
+		fc->flags = 0;
 		fc->user_id = 0;
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
@@ -426,6 +457,11 @@ static int fuse_fill_super(struct super_
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
@@ -441,6 +477,7 @@ static int fuse_fill_super(struct super_
 	if (fc == NULL)
 		return -EINVAL;
 
+	fc->flags = d.flags;
 	fc->user_id = d.user_id;
 
 	*get_fuse_conn_super_p(sb) = fc;
