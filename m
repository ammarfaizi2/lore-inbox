Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163505AbWLGWNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163505AbWLGWNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163504AbWLGWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:13:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163500AbWLGWNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:13:14 -0500
Message-ID: <457891F4.8030501@redhat.com>
Date: Thu, 07 Dec 2006 17:13:08 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
 inode numbers (libfs superblock cleanup)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that the inodes allocated by the functions get_sb_pseudo
and simple_fill_super are unique, provided of course, that the filesystems
calling them play by the rules. Currently that isn't the case, but will be
as I get to each of the filesystems.

The patch itself is pretty simple, but I also had to fix up the callers of
simple_fill_super to make sure they passed in the seq flag. For this first
pass, I set it on any filesystem with an empty "files" struct to 0. That may
need to be revised as I review each filesystem, but should be OK for now.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c b/drivers/infiniband/hw/ipath/ipath_fs.c
index d9ff283..c127995 100644
--- a/drivers/infiniband/hw/ipath/ipath_fs.c
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c
@@ -514,7 +514,7 @@ static int ipathfs_fill_super(struct sup
  		{""},
  	};

-	ret = simple_fill_super(sb, IPATHFS_MAGIC, files);
+	ret = simple_fill_super(sb, IPATHFS_MAGIC, files, 1);
  	if (ret) {
  		printk(KERN_ERR "simple_fill_super failed: %d\n", ret);
  		goto bail;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1713c48..7a90112 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -731,7 +731,7 @@ static int bm_fill_super(struct super_bl
  		[2] = {"register", &bm_register_operations, S_IWUSR},
  		/* last one */ {""}
  	};
-	int err = simple_fill_super(sb, 0x42494e4d, bm_files);
+	int err = simple_fill_super(sb, 0x42494e4d, bm_files, 1);
  	if (!err)
  		sb->s_op = &s_ops;
  	return err;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 137d76c..58becfe 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -107,7 +107,7 @@ static int debug_fill_super(struct super
  {
  	static struct tree_descr debug_files[] = {{""}};

-	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
+	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files, 0);
  }

  static int debug_get_sb(struct file_system_type *fs_type,
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 16b39c0..b14daf7 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -163,7 +163,7 @@ static int fuse_ctl_fill_super(struct su
  	struct fuse_conn *fc;
  	int err;

-	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr);
+	err = simple_fill_super(sb, FUSE_CTL_SUPER_MAGIC, &empty_descr, 0);
  	if (err)
  		return err;

diff --git a/fs/libfs.c b/fs/libfs.c
index bd08e0e..4fa7487 100644
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
@@ -356,7 +356,12 @@ int simple_commit_write(struct file *fil
  	return 0;
  }

-int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
+/*
+ * Some filesystems require that particular entries have particular i_ino values. Those
+ * callers need to set the "seq" flag to make sure that i_ino is assigned sequentially
+ * to the files starting with 0.
+ */
+int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files, int seq)
  {
  	static struct super_operations s_ops = {.statfs = simple_statfs};
  	struct inode *inode;
@@ -380,6 +385,9 @@ int simple_fill_super(struct super_block
  	inode->i_op = &simple_dir_inode_operations;
  	inode->i_fop = &simple_dir_operations;
  	inode->i_nlink = 2;
+	/* set this as high as a 32 bit val as possible to avoid collisions. This is also
+	 * well above the highest value that iunique_register will assign to an inode */
+	inode->i_ino = 0xffffffff;
  	root = d_alloc_root(inode);
  	if (!root) {
  		iput(inode);
@@ -399,7 +407,10 @@ int simple_fill_super(struct super_block
  		inode->i_blocks = 0;
  		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
  		inode->i_fop = files->ops;
-		inode->i_ino = i;
+		if (seq)
+			inode->i_ino = i;
+		else if (iunique_register(inode, 0))
+			goto out;
  		d_add(dentry, inode);
  	}
  	s->s_root = root;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 39aed90..9c4f585 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -659,7 +659,7 @@ #ifdef CONFIG_NFSD_V4
  #endif
  		/* last one */ {""}
  	};
-	return simple_fill_super(sb, 0x6e667364, nfsd_files);
+	return simple_fill_super(sb, 0x6e667364, nfsd_files, 1);
  }

  static int nfsd_get_sb(struct file_system_type *fs_type,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 48c416e..5c4513b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1890,7 +1890,7 @@ extern const struct file_operations simp
  extern struct inode_operations simple_dir_inode_operations;
  struct tree_descr { char *name; const struct file_operations *ops; int mode; };
  struct dentry *d_alloc_name(struct dentry *, const char *);
-extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
+extern int simple_fill_super(struct super_block *, int, struct tree_descr *, int);
  extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
  extern void simple_release_fs(struct vfsmount **mount, int *count);

diff --git a/security/inode.c b/security/inode.c
index 9b16e14..76005f5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -130,7 +130,7 @@ static int fill_super(struct super_block
  {
  	static struct tree_descr files[] = {{""}};

-	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
+	return simple_fill_super(sb, SECURITYFS_MAGIC, files, 0);
  }

  static int get_sb(struct file_system_type *fs_type,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index cd24441..ceb4a8e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1285,7 +1285,7 @@ static int sel_fill_super(struct super_b
  		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
  		/* last one */ {""}
  	};
-	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
+	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files, 1);
  	if (ret)
  		goto err;

