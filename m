Return-Path: <linux-kernel-owner+w=401wt.eu-S932525AbWLLWpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWLLWpv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWLLWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:45:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbWLLWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:45:49 -0500
Message-ID: <457F311A.2090501@redhat.com>
Date: Tue, 12 Dec 2006 17:45:46 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
References: <20061212194708.8359.qmail@science.horizon.com> <457F0BB1.4090806@redhat.com> <457F12CA.9050907@redhat.com>
In-Reply-To: <457F12CA.9050907@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach wrote:
 >
 > If iunique_register() fails, does not this create a memory leak
 > because root will need to get iput()'d?
 >

Good point, and now that we have a wrapper for new_inode that handles this
error transparently, both places are easy to fix. This patch should do it:

Signed-off-by: Jeff Layton <jlayton@redhat.com>

--- linux-2.6/fs/debugfs/inode.c.super
+++ linux-2.6/fs/debugfs/inode.c
@@ -107,7 +107,7 @@ static int debug_fill_super(struct super
  {
  	static struct tree_descr debug_files[] = {{""}};

-	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
+	return registered_fill_super(sb, DEBUGFS_MAGIC, debug_files);
  }

  static int debug_get_sb(struct file_system_type *fs_type,
--- linux-2.6/fs/fuse/control.c.super
+++ linux-2.6/fs/fuse/control.c
@@ -163,7 +163,7 @@ static int fuse_ctl_fill_super(struct su
  	struct fuse_conn *fc;
  	int err;

-	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
+	err = registered_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
  	if (err)
  		return err;

--- linux-2.6/fs/libfs.c.super
+++ linux-2.6/fs/libfs.c
@@ -214,7 +214,7 @@ int get_sb_pseudo(struct file_system_typ
  	s->s_magic = magic;
  	s->s_op = ops ? ops : &default_ops;
  	s->s_time_gran = 1;
-	root = new_inode(s);
+	root = new_registered_inode(s, 0);
  	if (!root)
  		goto Enomem;
  	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
@@ -356,7 +356,8 @@ int simple_commit_write(struct file *fil
  	return 0;
  }

-int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
+int __simple_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files, bool registered)
  {
  	static struct super_operations s_ops = {.statfs = simple_statfs};
  	struct inode *inode;
@@ -380,6 +381,12 @@ int simple_fill_super(struct super_block
  	inode->i_op = &simple_dir_inode_operations;
  	inode->i_fop = &simple_dir_operations;
  	inode->i_nlink = 2;
+	/*
+	 * set this as high as a 32 bit val as possible to avoid collisions.
+	 * This is also well above the highest value that iunique_register
+	 * will assign to an inode
+	 */
+	inode->i_ino = 0xffffffff;
  	root = d_alloc_root(inode);
  	if (!root) {
  		iput(inode);
@@ -391,7 +398,12 @@ int simple_fill_super(struct super_block
  		dentry = d_alloc_name(root, files->name);
  		if (!dentry)
  			goto out;
-		inode = new_inode(s);
+		if (registered)
+			inode = new_registered_inode(s, 0);
+		else {
+			inode = new_inode(s);
+			inode->i_ino = i;
+		}
  		if (!inode)
  			goto out;
  		inode->i_mode = S_IFREG | files->mode;
@@ -399,7 +411,6 @@ int simple_fill_super(struct super_block
  		inode->i_blocks = 0;
  		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
  		inode->i_fop = files->ops;
-		inode->i_ino = i;
  		d_add(dentry, inode);
  	}
  	s->s_root = root;
@@ -618,7 +629,7 @@ EXPORT_SYMBOL(simple_dir_inode_operation
  EXPORT_SYMBOL(simple_dir_operations);
  EXPORT_SYMBOL(simple_empty);
  EXPORT_SYMBOL(d_alloc_name);
-EXPORT_SYMBOL(simple_fill_super);
+EXPORT_SYMBOL(__simple_fill_super);
  EXPORT_SYMBOL(simple_getattr);
  EXPORT_SYMBOL(simple_link);
  EXPORT_SYMBOL(simple_lookup);
--- linux-2.6/include/linux/fs.h.super
+++ linux-2.6/include/linux/fs.h
@@ -1879,10 +1879,35 @@ extern const struct file_operations simp
  extern struct inode_operations simple_dir_inode_operations;
  struct tree_descr { char *name; const struct file_operations *ops; int mode; };
  struct dentry *d_alloc_name(struct dentry *, const char *);
-extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
+extern int __simple_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files, bool registered);
  extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
  extern void simple_release_fs(struct vfsmount **mount, int *count);

+/*
+ * Fill a superblock with a standard set of fields, and add the entries in the
+ * "files" struct. Assign i_ino values to the files sequentially. This function
+ * is appropriate for filesystems that need a particular i_ino value assigned
+ * to a particular "files" entry.
+ */
+static inline int simple_fill_super(struct super_block *s, int magic,
+					struct tree_descr *files)
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
+static inline int registered_fill_super(struct super_block *s, int magic,
+						struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, true);
+}
+
  extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t *, const void *, size_t);

  #ifdef CONFIG_MIGRATION
--- linux-2.6/security/inode.c.super
+++ linux-2.6/security/inode.c
@@ -130,7 +130,7 @@ static int fill_super(struct super_block
  {
  	static struct tree_descr files[] = {{""}};

-	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
+	return registered_fill_super(sb, SECURITYFS_MAGIC, files);
  }

  static int get_sb(struct file_system_type *fs_type,
