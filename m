Return-Path: <linux-kernel-owner+w=401wt.eu-S1751545AbWLLQpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWLLQpi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWLLQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:45:38 -0500
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:49065 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542AbWLLQph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:45:37 -0500
Message-ID: <457EDCC9.3070409@redhat.com>
Date: Tue, 12 Dec 2006 11:46:01 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
References: <20061210175652.7537.qmail@science.horizon.com>
In-Reply-To: <20061210175652.7537.qmail@science.horizon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
 > I'm very fond of <stdbool.h>, since it explicitly documents that there
 > are exactly two options.  It also allows the compiler a few minor
 > opportunities for optimization, but that's not as big a deal.
 >
 > static int __simple_fill_super(struct super_block *s, int magic,
 > 				struct tree_descr *files, bool sequential)
 >
 > Although "true" and "false" aren't the most meaningful #defines either,
 > at least they indicate that it's one of two choices, and there is no
 > option "2" to sorry about.
 >
 > Given your wrappr function names, "bool registered" is another option.
 >
 > You might want to make simple_fill_super() and registered_fill_super()
 > inline functions or #defines rather than making them separate functions.
 > Or is there a particular need for a function pointer?  The code size
 > is negligible, and it saves stack space.
 >

Good catch on the inlining. I had meant to do that and missed it. The point
about the naming of the flag is a good one too. How about this patch? I've
tested it to see that it builds, but don't have good place to test this one
to see that it works. A similar patch did work on a 2.6.18 derivative kernel.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

--- linux-2.6/fs/debugfs/inode.c.super	2006-12-12 08:46:46.000000000 -0500
+++ linux-2.6/fs/debugfs/inode.c	2006-12-12 08:54:14.000000000 -0500
@@ -107,7 +107,7 @@
  {
  	static struct tree_descr debug_files[] = {{""}};

-	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
+	return registered_fill_super(sb, DEBUGFS_MAGIC, debug_files);
  }

  static int debug_get_sb(struct file_system_type *fs_type,
--- linux-2.6/fs/fuse/control.c.super	2006-12-12 08:46:46.000000000 -0500
+++ linux-2.6/fs/fuse/control.c	2006-12-12 08:54:14.000000000 -0500
@@ -163,7 +163,7 @@
  	struct fuse_conn *fc;
  	int err;

-	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
+	err = registered_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
  	if (err)
  		return err;

--- linux-2.6/fs/libfs.c.super	2006-12-12 08:46:46.000000000 -0500
+++ linux-2.6/fs/libfs.c	2006-12-12 11:31:20.000000000 -0500
@@ -215,7 +215,7 @@
  	s->s_op = ops ? ops : &default_ops;
  	s->s_time_gran = 1;
  	root = new_inode(s);
-	if (!root)
+	if (!root || iunique_register(root, 0))
  		goto Enomem;
  	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
  	root->i_uid = root->i_gid = 0;
@@ -356,7 +356,8 @@
  	return 0;
  }

-int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
+static int __simple_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files, bool registered)
  {
  	static struct super_operations s_ops = {.statfs = simple_statfs};
  	struct inode *inode;
@@ -380,6 +381,12 @@
  	inode->i_op = &simple_dir_inode_operations;
  	inode->i_fop = &simple_dir_operations;
  	inode->i_nlink = 2;
+	/*
+	 * set this as high as a 32 bit val as possible to avoid collisions.
+	 * This is also well above the highest value that iunique_register
+         * will assign to an inode
+	 */
+	inode->i_ino = 0xffffffff;
  	root = d_alloc_root(inode);
  	if (!root) {
  		iput(inode);
@@ -394,12 +401,15 @@
  		inode = new_inode(s);
  		if (!inode)
  			goto out;
+		if (!registered)
+			inode->i_ino = i;
+		else if (iunique_register(inode, 0))
+			goto out;
  		inode->i_mode = S_IFREG | files->mode;
  		inode->i_uid = inode->i_gid = 0;
  		inode->i_blocks = 0;
  		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
  		inode->i_fop = files->ops;
-		inode->i_ino = i;
  		d_add(dentry, inode);
  	}
  	s->s_root = root;
@@ -410,6 +420,30 @@
  	return -ENOMEM;
  }

+/*
+ * Fill a superblock with a standard set of fields, and add the entries in the
+ * "files" struct. Assign i_ino values to the files sequentially. This function
+ * is appropriate for filesystems that need a particular i_ino value assigned
+ * to a particular "files" entry.
+ */
+inline int simple_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, false);
+}
+
+/*
+ * Just like simple_fill_super, but does an iunique_register on the inodes
+ * created for "files" entries. This function is appropriate when you don't
+ * need a particular i_ino value assigned to each files entry, and when the
+ * filesystem will have other registered inodes.
+ */
+inline int registered_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, true);
+}
+
  static DEFINE_SPINLOCK(pin_fs_lock);

  int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
@@ -619,6 +653,7 @@
  EXPORT_SYMBOL(simple_empty);
  EXPORT_SYMBOL(d_alloc_name);
  EXPORT_SYMBOL(simple_fill_super);
+EXPORT_SYMBOL(registered_fill_super);
  EXPORT_SYMBOL(simple_getattr);
  EXPORT_SYMBOL(simple_link);
  EXPORT_SYMBOL(simple_lookup);
--- linux-2.6/include/linux/fs.h.super	2006-12-12 08:53:34.000000000 -0500
+++ linux-2.6/include/linux/fs.h	2006-12-12 08:54:14.000000000 -0500
@@ -1879,7 +1879,10 @@
  extern struct inode_operations simple_dir_inode_operations;
  struct tree_descr { char *name; const struct file_operations *ops; int mode; };
  struct dentry *d_alloc_name(struct dentry *, const char *);
-extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
+extern int simple_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files);
+extern int registered_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files);
  extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
  extern void simple_release_fs(struct vfsmount **mount, int *count);

--- linux-2.6/security/inode.c.super	2006-12-12 08:46:47.000000000 -0500
+++ linux-2.6/security/inode.c	2006-12-12 08:54:14.000000000 -0500
@@ -130,7 +130,7 @@
  {
  	static struct tree_descr files[] = {{""}};

-	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
+	return registered_fill_super(sb, SECURITYFS_MAGIC, files);
  }

  static int get_sb(struct file_system_type *fs_type,


