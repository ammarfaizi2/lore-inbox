Return-Path: <linux-kernel-owner+w=401wt.eu-S1030608AbWLIMRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbWLIMRX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936958AbWLIMRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:17:22 -0500
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:48449 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936974AbWLIMRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:17:21 -0500
Message-ID: <457AA94E.2030209@poochiereds.net>
Date: Sat, 09 Dec 2006 07:17:18 -0500
From: Jeff Layton <jlayton@poochiereds.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
 inode numbers (libfs superblock cleanup)
References: <457891F4.8030501@redhat.com>
In-Reply-To: <457891F4.8030501@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
 > This patch ensures that the inodes allocated by the functions get_sb_pseudo
 > and simple_fill_super are unique, provided of course, that the filesystems
 > calling them play by the rules. Currently that isn't the case, but will be
 > as I get to each of the filesystems.
 >

This patch is respun based on some suggestions by Josef Sipek. The different
modes of simple_fill_super are different enough that they probably ought to
be different functions. This makes that so.

With this patch it's not necessary to change some of the callers of
simple_fill_super yet, but they'll need to be changed sometime so I left
that in place.

Signed-off-by: Jeff Layton <jlayton@redhat.com>


diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c b/drivers/infiniband/hw/ipath/ipath_fs.c
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 137d76c..3f9dd93 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -107,7 +107,7 @@ static int debug_fill_super(struct super
  {
  	static struct tree_descr debug_files[] = {{""}};

-	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
+	return registered_fill_super(sb, DEBUGFS_MAGIC, debug_files);
  }

  static int debug_get_sb(struct file_system_type *fs_type,
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 8c58bd4..1320066 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -163,7 +163,7 @@ static int fuse_ctl_fill_super(struct su
  	struct fuse_conn *fc;
  	int err;

-	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
+	err = registered_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
  	if (err)
  		return err;

diff --git a/fs/libfs.c b/fs/libfs.c
index 503898d..ba1a887 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -215,7 +215,7 @@ int get_sb_pseudo(struct file_system_typ
  	s->s_op = ops ? ops : &default_ops;
  	s->s_time_gran = 1;
  	root = new_inode(s);
-	if (!root)
+	if (!root || iunique_register(root, 0))
  		goto Enomem;
  	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
  	root->i_uid = root->i_gid = 0;
@@ -356,7 +356,8 @@ int simple_commit_write(struct file *fil
  	return 0;
  }

-int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
+static int __simple_fill_super(struct super_block *s, int magic,
+				struct tree_descr *files, int sequential)
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
+         * will assign to an inode
+	 */
+	inode->i_ino = 0xffffffff;
  	root = d_alloc_root(inode);
  	if (!root) {
  		iput(inode);
@@ -394,12 +401,15 @@ int simple_fill_super(struct super_block
  		inode = new_inode(s);
  		if (!inode)
  			goto out;
+		if (sequential)
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
@@ -410,6 +420,30 @@ out:
  	return -ENOMEM;
  }

+/*
+ * Fill a superblock with a standard set of fields, and add the entries in the
+ * "files" struct. Assign i_ino values to the files sequentially. This function
+ * is appropriate for filesystems that need a particular i_ino value assigned
+ * to a particular "files" entry.
+ */
+int simple_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, 1);
+}
+
+/*
+ * Just like simple_fill_super, but does an iunique_register on the inodes
+ * created for "files" entries. This function is appropriate when you don't
+ * need a particular i_ino value assigned to each files entry, and when the
+ * filesystem will have other registered inodes.
+ */
+int registered_fill_super(struct super_block *s, int magic,
+			struct tree_descr *files)
+{
+	return __simple_fill_super(s, magic, files, 0);
+}
+
  static DEFINE_SPINLOCK(pin_fs_lock);

  int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
@@ -619,6 +653,7 @@ EXPORT_SYMBOL(simple_dir_operations);
  EXPORT_SYMBOL(simple_empty);
  EXPORT_SYMBOL(d_alloc_name);
  EXPORT_SYMBOL(simple_fill_super);
+EXPORT_SYMBOL(registered_fill_super);
  EXPORT_SYMBOL(simple_getattr);
  EXPORT_SYMBOL(simple_link);
  EXPORT_SYMBOL(simple_lookup);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c70f1a..c98bc80 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1879,7 +1879,10 @@ extern const struct file_operations simp
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

diff --git a/security/inode.c b/security/inode.c
index 9b16e14..e3e12b1 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -130,7 +130,7 @@ static int fill_super(struct super_block
  {
  	static struct tree_descr files[] = {{""}};

-	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
+	return registered_fill_super(sb, SECURITYFS_MAGIC, files);
  }

  static int get_sb(struct file_system_type *fs_type,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
