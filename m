Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWESPs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWESPs5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWESPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:47:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932365AbWESPrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:47:18 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/14] NFS: Permit filesystem to perform statfs with a known root dentry [try #10]
Date: Fri, 19 May 2006 16:46:47 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060519154647.11791.47486.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch gives the statfs superblock operation a vfsmount pointer
rather than a superblock pointer.

This complements the get_sb() patch.  That reduced the significance of
sb->s_root, allowing NFS to place a fake root there.  However, NFS does require
a dentry to use as a target for the statfs operation.  This permits the root in
the vfsmount to be used instead.

Further changes [try #9] that have been made:

 (*) Inclusions of linux/mount.h have been added where necessary to make
     allyesconfig build successfully.

Further changes [try #10] that have been made:

 (*) Pass a dentry rather than a vfsmount to the statfs() op as the key by
     which to determine the filesystem.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/Locking |    2 +-
 Documentation/filesystems/vfs.txt |    2 +-
 arch/alpha/kernel/osf_sys.c       |    2 +-
 arch/mips/kernel/sysirix.c        |   12 ++++++------
 arch/parisc/hpux/sys_hpux.c       |   10 +++++-----
 arch/sparc64/solaris/fs.c         |    4 ++--
 fs/adfs/super.c                   |    8 ++++----
 fs/affs/super.c                   |    5 +++--
 fs/befs/linuxvfs.c                |    5 +++--
 fs/bfs/inode.c                    |    3 ++-
 fs/cifs/cifsfs.c                  |    3 ++-
 fs/coda/inode.c                   |    6 +++---
 fs/coda/upcall.c                  |    4 ++--
 fs/compat.c                       |    8 ++++----
 fs/cramfs/inode.c                 |    4 +++-
 fs/efs/super.c                    |    6 +++---
 fs/ext2/super.c                   |    5 +++--
 fs/ext3/super.c                   |    5 +++--
 fs/fat/inode.c                    |    8 ++++----
 fs/freevxfs/vxfs_super.c          |   13 +++++++------
 fs/fuse/inode.c                   |    3 ++-
 fs/hfs/super.c                    |    4 +++-
 fs/hfsplus/super.c                |    4 +++-
 fs/hostfs/hostfs_kern.c           |    4 ++--
 fs/hpfs/super.c                   |    3 ++-
 fs/hppfs/hppfs_kern.c             |    2 +-
 fs/hugetlbfs/inode.c              |    4 ++--
 fs/isofs/inode.c                  |    6 ++++--
 fs/jffs/inode-v23.c               |    4 ++--
 fs/jffs2/fs.c                     |    4 ++--
 fs/jffs2/os-linux.h               |    2 +-
 fs/jfs/super.c                    |    4 ++--
 fs/libfs.c                        |    4 ++--
 fs/minix/inode.c                  |   10 +++++-----
 fs/ncpfs/inode.c                  |    5 +++--
 fs/nfs/inode.c                    |    5 +++--
 fs/nfsd/nfs4xdr.c                 |    2 +-
 fs/nfsd/vfs.c                     |    2 +-
 fs/ntfs/super.c                   |    7 ++++---
 fs/ocfs2/super.c                  |   10 +++++-----
 fs/open.c                         |   26 +++++++++++++-------------
 fs/qnx4/inode.c                   |    6 ++++--
 fs/reiserfs/super.c               |    8 ++++----
 fs/romfs/inode.c                  |    4 ++--
 fs/smbfs/inode.c                  |    6 +++---
 fs/smbfs/proc.c                   |    4 ++--
 fs/smbfs/proto.h                  |    2 +-
 fs/super.c                        |    2 +-
 fs/sysv/inode.c                   |    3 ++-
 fs/udf/super.c                    |    6 ++++--
 fs/ufs/super.c                    |    3 ++-
 fs/xfs/linux-2.6/xfs_super.c      |    4 ++--
 include/linux/coda_psdev.h        |    2 +-
 include/linux/fs.h                |    6 +++---
 include/linux/mount.h             |    5 +++++
 include/linux/security.h          |   14 +++++++-------
 kernel/acct.c                     |    2 +-
 mm/shmem.c                        |    4 ++--
 security/dummy.c                  |    2 +-
 security/selinux/hooks.c          |    6 +++---
 60 files changed, 175 insertions(+), 144 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 3abf08f..d31efbb 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -99,7 +99,7 @@ prototypes:
 	int (*sync_fs)(struct super_block *sb, int wait);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
-	int (*statfs) (struct super_block *, struct kstatfs *);
+	int (*statfs) (struct dentry *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index dd7d0dc..9d3aed6 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -211,7 +211,7 @@ struct super_operations {
         int (*sync_fs)(struct super_block *sb, int wait);
         void (*write_super_lockfs) (struct super_block *);
         void (*unlockfs) (struct super_block *);
-        int (*statfs) (struct super_block *, struct kstatfs *);
+        int (*statfs) (struct dentry *, struct kstatfs *);
         int (*remount_fs) (struct super_block *, int *, char *);
         void (*clear_inode) (struct inode *);
         void (*umount_begin) (struct super_block *);
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 31afe3d..e15dcf4 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -244,7 +244,7 @@ do_osf_statfs(struct dentry * dentry, st
 	      unsigned long bufsiz)
 {
 	struct kstatfs linux_stat;
-	int error = vfs_statfs(dentry->d_inode->i_sb, &linux_stat);
+	int error = vfs_statfs(dentry, &linux_stat);
 	if (!error)
 		error = linux_to_osf_statfs(&linux_stat, buffer, bufsiz);
 	return error;	
diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
index 5407b78..19e1ef4 100644
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -694,7 +694,7 @@ asmlinkage int irix_statfs(const char __
 	if (error)
 		goto out;
 
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -732,7 +732,7 @@ asmlinkage int irix_fstatfs(unsigned int
 		goto out;
 	}
 
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 
@@ -1360,7 +1360,7 @@ asmlinkage int irix_statvfs(char __user 
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -1406,7 +1406,7 @@ asmlinkage int irix_fstatvfs(int fd, str
 		error = -EBADF;
 		goto out;
 	}
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 
@@ -1611,7 +1611,7 @@ asmlinkage int irix_statvfs64(char __use
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -1658,7 +1658,7 @@ asmlinkage int irix_fstatvfs64(int fd, s
 		error = -EBADF;
 		goto out;
 	}
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 
diff --git a/arch/parisc/hpux/sys_hpux.c b/arch/parisc/hpux/sys_hpux.c
index 05273cc..cb69727 100644
--- a/arch/parisc/hpux/sys_hpux.c
+++ b/arch/parisc/hpux/sys_hpux.c
@@ -145,7 +145,7 @@ static int hpux_ustat(dev_t dev, struct 
 	s = user_get_super(dev);
 	if (s == NULL)
 		goto out;
-	err = vfs_statfs(s, &sbuf);
+	err = vfs_statfs(s->s_root, &sbuf);
 	drop_super(s);
 	if (err)
 		goto out;
@@ -186,12 +186,12 @@ struct hpux_statfs {
      int16_t f_pad;
 };
 
-static int vfs_statfs_hpux(struct super_block *sb, struct hpux_statfs *buf)
+static int vfs_statfs_hpux(struct dentry *dentry, struct hpux_statfs *buf)
 {
 	struct kstatfs st;
 	int retval;
 	
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -219,7 +219,7 @@ asmlinkage long hpux_statfs(const char _
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct hpux_statfs tmp;
-		error = vfs_statfs_hpux(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs_hpux(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -237,7 +237,7 @@ asmlinkage long hpux_fstatfs(unsigned in
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs_hpux(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs_hpux(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
diff --git a/arch/sparc64/solaris/fs.c b/arch/sparc64/solaris/fs.c
index 4885ca6..0f0eb6a 100644
--- a/arch/sparc64/solaris/fs.c
+++ b/arch/sparc64/solaris/fs.c
@@ -356,7 +356,7 @@ static int report_statvfs(struct vfsmoun
 	int error;
 	struct sol_statvfs __user *ss = A(buf);
 
-	error = vfs_statfs(mnt->mnt_sb, &s);
+	error = vfs_statfs(mnt->mnt_root, &s);
 	if (!error) {
 		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
@@ -392,7 +392,7 @@ static int report_statvfs64(struct vfsmo
 	int error;
 	struct sol_statvfs64 __user *ss = A(buf);
 			
-	error = vfs_statfs(mnt->mnt_sb, &s);
+	error = vfs_statfs(mnt->mnt_root, &s);
 	if (!error) {
 		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 1b58a9b..ba1c88a 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -196,17 +196,17 @@ static int adfs_remount(struct super_blo
 	return parse_options(sb, data);
 }
 
-static int adfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct adfs_sb_info *asb = ADFS_SB(sb);
+	struct adfs_sb_info *asb = ADFS_SB(dentry->d_sb);
 
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = asb->s_namelen;
-	buf->f_bsize   = sb->s_blocksize;
+	buf->f_bsize   = dentry->d_sb->s_blocksize;
 	buf->f_blocks  = asb->s_size;
 	buf->f_files   = asb->s_ids_per_zone * asb->s_map_size;
 	buf->f_bavail  =
-	buf->f_bfree   = adfs_map_free(sb);
+	buf->f_bfree   = adfs_map_free(dentry->d_sb);
 	buf->f_ffree   = (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks;
 
 	return 0;
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 6a52e78..8765cba 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -18,7 +18,7 @@ #include "affs.h"
 
 extern struct timezone sys_tz;
 
-static int affs_statfs(struct super_block *sb, struct kstatfs *buf);
+static int affs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int affs_remount (struct super_block *sb, int *flags, char *data);
 
 static void
@@ -508,8 +508,9 @@ affs_remount(struct super_block *sb, int
 }
 
 static int
-affs_statfs(struct super_block *sb, struct kstatfs *buf)
+affs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	int		 free;
 
 	pr_debug("AFFS: statfs() partsize=%d, reserved=%d\n",AFFS_SB(sb)->s_partition_size,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 6ed07a5..08201fa 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -49,7 +49,7 @@ static int befs_nls2utf(struct super_blo
 			char **out, int *out_len);
 static void befs_put_super(struct super_block *);
 static int befs_remount(struct super_block *, int *, char *);
-static int befs_statfs(struct super_block *, struct kstatfs *);
+static int befs_statfs(struct dentry *, struct kstatfs *);
 static int parse_options(char *, befs_mount_options *);
 
 static const struct super_operations befs_sops = {
@@ -880,8 +880,9 @@ befs_remount(struct super_block *sb, int
 }
 
 static int
-befs_statfs(struct super_block *sb, struct kstatfs *buf)
+befs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 
 	befs_debug(sb, "---> befs_statfs()");
 
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index e7da03f..cf74f3d 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -203,8 +203,9 @@ static void bfs_put_super(struct super_b
 	s->s_fs_info = NULL;
 }
 
-static int bfs_statfs(struct super_block *s, struct kstatfs *buf)
+static int bfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *s = dentry->d_sb;
 	struct bfs_sb_info *info = BFS_SB(s);
 	u64 id = huge_encode_dev(s->s_bdev->bd_dev);
 	buf->f_type = BFS_MAGIC;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 6779837..8b4de6e 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -166,8 +166,9 @@ cifs_put_super(struct super_block *sb)
 }
 
 static int
-cifs_statfs(struct super_block *sb, struct kstatfs *buf)
+cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	int xid; 
 	int rc = -EOPNOTSUPP;
 	struct cifs_sb_info *cifs_sb;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index cba7020..87f1dc8 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -36,7 +36,7 @@ #include "coda_int.h"
 /* VFS super_block ops */
 static void coda_clear_inode(struct inode *);
 static void coda_put_super(struct super_block *);
-static int coda_statfs(struct super_block *sb, struct kstatfs *buf);
+static int coda_statfs(struct dentry *dentry, struct kstatfs *buf);
 
 static kmem_cache_t * coda_inode_cachep;
 
@@ -278,13 +278,13 @@ struct inode_operations coda_file_inode_
 	.setattr	= coda_setattr,
 };
 
-static int coda_statfs(struct super_block *sb, struct kstatfs *buf)
+static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	int error;
 	
 	lock_kernel();
 
-	error = venus_statfs(sb, buf);
+	error = venus_statfs(dentry, buf);
 
 	unlock_kernel();
 
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1bae996..6b0154d 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -611,7 +611,7 @@ int venus_pioctl(struct super_block *sb,
 	return error;
 }
 
-int venus_statfs(struct super_block *sb, struct kstatfs *sfs) 
+int venus_statfs(struct dentry *dentry, struct kstatfs *sfs) 
 { 
         union inputArgs *inp;
         union outputArgs *outp;
@@ -620,7 +620,7 @@ int venus_statfs(struct super_block *sb,
 	insize = max_t(unsigned int, INSIZE(statfs), OUTSIZE(statfs));
 	UPARG(CODA_STATFS);
 
-        error = coda_upcall(coda_sbp(sb), insize, &outsize, inp);
+        error = coda_upcall(coda_sbp(dentry->d_sb), insize, &outsize, inp);
 	
         if (!error) {
 		sfs->f_blocks = outp->coda_statfs.stat.f_blocks;
diff --git a/fs/compat.c b/fs/compat.c
index 970888a..7b2813d 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -197,7 +197,7 @@ asmlinkage long compat_sys_statfs(const 
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct kstatfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs(nd.dentry, &tmp);
 		if (!error)
 			error = put_compat_statfs(buf, &tmp);
 		path_release(&nd);
@@ -215,7 +215,7 @@ asmlinkage long compat_sys_fstatfs(unsig
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs(file->f_dentry, &tmp);
 	if (!error)
 		error = put_compat_statfs(buf, &tmp);
 	fput(file);
@@ -265,7 +265,7 @@ asmlinkage long compat_sys_statfs64(cons
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct kstatfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs(nd.dentry, &tmp);
 		if (!error)
 			error = put_compat_statfs64(buf, &tmp);
 		path_release(&nd);
@@ -286,7 +286,7 @@ asmlinkage long compat_sys_fstatfs64(uns
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs(file->f_dentry, &tmp);
 	if (!error)
 		error = put_compat_statfs64(buf, &tmp);
 	fput(file);
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 37a91a1..8a9d5d3 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -322,8 +322,10 @@ out:
 	return -EINVAL;
 }
 
-static int cramfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int cramfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	buf->f_blocks = CRAMFS_SB(sb)->blocks;
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 1ba5e14..8ac2462 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -15,7 +15,7 @@ #include <linux/slab.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 
-static int efs_statfs(struct super_block *s, struct kstatfs *buf);
+static int efs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int efs_fill_super(struct super_block *s, void *d, int silent);
 
 static int efs_get_sb(struct file_system_type *fs_type,
@@ -322,8 +322,8 @@ out_no_fs:
 	return -EINVAL;
 }
 
-static int efs_statfs(struct super_block *s, struct kstatfs *buf) {
-	struct efs_sb_info *sb = SUPER_INFO(s);
+static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
+	struct efs_sb_info *sb = SUPER_INFO(dentry->d_sb);
 
 	buf->f_type    = EFS_SUPER_MAGIC;	/* efs magic number */
 	buf->f_bsize   = EFS_BLOCKSIZE;		/* blocksize */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index a4dfffa..a6c4d6e 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -39,7 +39,7 @@ #include "xip.h"
 static void ext2_sync_super(struct super_block *sb,
 			    struct ext2_super_block *es);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
-static int ext2_statfs (struct super_block * sb, struct kstatfs * buf);
+static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf);
 
 void ext2_error (struct super_block * sb, const char * function,
 		 const char * fmt, ...)
@@ -1038,8 +1038,9 @@ restore_opts:
 	return err;
 }
 
-static int ext2_statfs (struct super_block * sb, struct kstatfs * buf)
+static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned long overhead;
 	int i;
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 657f8e7..e08b643 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -58,7 +58,7 @@ static int ext3_sync_fs(struct super_blo
 static const char *ext3_decode_error(struct super_block * sb, int errno,
 				     char nbuf[16]);
 static int ext3_remount (struct super_block * sb, int * flags, char * data);
-static int ext3_statfs (struct super_block * sb, struct kstatfs * buf);
+static int ext3_statfs (struct dentry * dentry, struct kstatfs * buf);
 static void ext3_unlockfs(struct super_block *sb);
 static void ext3_write_super (struct super_block * sb);
 static void ext3_write_super_lockfs(struct super_block *sb);
@@ -2318,8 +2318,9 @@ #endif
 	return err;
 }
 
-static int ext3_statfs (struct super_block * sb, struct kstatfs * buf)
+static int ext3_statfs (struct dentry * dentry, struct kstatfs * buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
 	unsigned long overhead;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index c1ce284..7c35d58 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -539,18 +539,18 @@ static int fat_remount(struct super_bloc
 	return 0;
 }
 
-static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
+static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 
 	/* If the count of free cluster is still unknown, counts it here. */
 	if (sbi->free_clusters == -1) {
-		int err = fat_count_free_clusters(sb);
+		int err = fat_count_free_clusters(dentry->d_sb);
 		if (err)
 			return err;
 	}
 
-	buf->f_type = sb->s_magic;
+	buf->f_type = dentry->d_sb->s_magic;
 	buf->f_bsize = sbi->cluster_size;
 	buf->f_blocks = sbi->max_cluster - FAT_START_ENT;
 	buf->f_bfree = sbi->free_clusters;
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index d76eeaa..b74b791 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -40,6 +40,7 @@ #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/vfs.h>
+#include <linux/mount.h>
 
 #include "vxfs.h"
 #include "vxfs_extern.h"
@@ -55,7 +56,7 @@ MODULE_ALIAS("vxfs"); /* makes mount -t 
 
 
 static void		vxfs_put_super(struct super_block *);
-static int		vxfs_statfs(struct super_block *, struct kstatfs *);
+static int		vxfs_statfs(struct dentry *, struct kstatfs *);
 static int		vxfs_remount(struct super_block *, int *, char *);
 
 static struct super_operations vxfs_super_ops = {
@@ -90,12 +91,12 @@ vxfs_put_super(struct super_block *sbp)
 
 /**
  * vxfs_statfs - get filesystem information
- * @sbp:	VFS superblock
+ * @dentry:	VFS dentry to locate superblock
  * @bufp:	output buffer
  *
  * Description:
  *   vxfs_statfs fills the statfs buffer @bufp with information
- *   about the filesystem described by @sbp.
+ *   about the filesystem described by @dentry.
  *
  * Returns:
  *   Zero.
@@ -107,12 +108,12 @@ vxfs_put_super(struct super_block *sbp)
  *   This is everything but complete...
  */
 static int
-vxfs_statfs(struct super_block *sbp, struct kstatfs *bufp)
+vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 {
-	struct vxfs_sb_info		*infp = VXFS_SBI(sbp);
+	struct vxfs_sb_info		*infp = VXFS_SBI(dentry->d_sb);
 
 	bufp->f_type = VXFS_SUPER_MAGIC;
-	bufp->f_bsize = sbp->s_blocksize;
+	bufp->f_bsize = dentry->d_sb->s_blocksize;
 	bufp->f_blocks = infp->vsi_raw->vs_dsize;
 	bufp->f_bfree = infp->vsi_raw->vs_free;
 	bufp->f_bavail = 0;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5c5ab5f..815c824 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -237,8 +237,9 @@ static void convert_fuse_statfs(struct k
 	/* fsid is left zero */
 }
 
-static int fuse_statfs(struct super_block *sb, struct kstatfs *buf)
+static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	struct fuse_req *req;
 	struct fuse_statfs_out outarg;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index ee5b80a..d9227bf 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -80,8 +80,10 @@ static void hfs_put_super(struct super_b
  *
  * changed f_files/f_ffree to reflect the fs_ablock/free_ablocks.
  */
-static int hfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	buf->f_type = HFS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = (u32)HFS_SB(sb)->fs_ablocks * HFS_SB(sb)->fs_div;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 0ed8b7e..0a92fa2 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -212,8 +212,10 @@ static void hfsplus_put_super(struct sup
 	sb->s_fs_info = NULL;
 }
 
-static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
+static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	buf->f_type = HFSPLUS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = HFSPLUS_SB(sb).total_blocks << HFSPLUS_SB(sb).fs_shift;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 04035e0..8e0d377 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -239,7 +239,7 @@ static int read_inode(struct inode *ino)
 	return(err);
 }
 
-int hostfs_statfs(struct super_block *sb, struct kstatfs *sf)
+int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 {
 	/* do_statfs uses struct statfs64 internally, but the linux kernel
 	 * struct statfs still has 32-bit versions for most of these fields,
@@ -252,7 +252,7 @@ int hostfs_statfs(struct super_block *sb
 	long long f_files;
 	long long f_ffree;
 
-	err = do_statfs(HOSTFS_I(sb->s_root->d_inode)->host_filename,
+	err = do_statfs(HOSTFS_I(dentry->d_sb->s_root->d_inode)->host_filename,
 			&sf->f_bsize, &f_blocks, &f_bfree, &f_bavail, &f_files,
 			&f_ffree, &sf->f_fsid, sizeof(sf->f_fsid),
 			&sf->f_namelen, sf->f_spare);
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 3b25cf3..f798480 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -135,8 +135,9 @@ static unsigned count_bitmaps(struct sup
 	return count;
 }
 
-static int hpfs_statfs(struct super_block *s, struct kstatfs *buf)
+static int hpfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *s = dentry->d_sb;
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 	lock_kernel();
 
diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index ec43c22..3a9bdf5 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -616,7 +616,7 @@ static const struct file_operations hppf
 	.fsync		= hppfs_fsync,
 };
 
-static int hppfs_statfs(struct super_block *sb, struct kstatfs *sf)
+static int hppfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 {
 	sf->f_blocks = 0;
 	sf->f_bfree = 0;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4665c26..678fc72 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -467,9 +467,9 @@ static int hugetlbfs_set_page_dirty(stru
 	return 0;
 }
 
-static int hugetlbfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(sb);
+	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
 
 	buf->f_type = HUGETLBFS_MAGIC;
 	buf->f_bsize = HPAGE_SIZE;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 17268da..3f9c8ba 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -56,7 +56,7 @@ #endif
 }
 
 static void isofs_read_inode(struct inode *);
-static int isofs_statfs (struct super_block *, struct kstatfs *);
+static int isofs_statfs (struct dentry *, struct kstatfs *);
 
 static kmem_cache_t *isofs_inode_cachep;
 
@@ -901,8 +901,10 @@ out_freesbi:
 	return -EINVAL;
 }
 
-static int isofs_statfs (struct super_block *sb, struct kstatfs *buf)
+static int isofs_statfs (struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	buf->f_type = ISOFS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = (ISOFS_SB(sb)->s_nzones
diff --git a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
index dd93a09..9e46ea6 100644
--- a/fs/jffs/inode-v23.c
+++ b/fs/jffs/inode-v23.c
@@ -377,9 +377,9 @@ jffs_new_inode(const struct inode * dir,
 
 /* Get statistics of the file system.  */
 static int
-jffs_statfs(struct super_block *sb, struct kstatfs *buf)
+jffs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct jffs_control *c = (struct jffs_control *) sb->s_fs_info;
+	struct jffs_control *c = (struct jffs_control *) dentry->d_sb->s_fs_info;
 	struct jffs_fmcontrol *fmc;
 
 	lock_kernel();
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 09e5d10..2f9e00b 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -183,9 +183,9 @@ int jffs2_setattr(struct dentry *dentry,
 	return jffs2_do_setattr(dentry->d_inode, iattr);
 }
 
-int jffs2_statfs(struct super_block *sb, struct kstatfs *buf)
+int jffs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(dentry->d_sb);
 	unsigned long avail;
 
 	buf->f_type = JFFS2_SUPER_MAGIC;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index d307cf5..3cf57ac 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -182,7 +182,7 @@ void jffs2_clear_inode (struct inode *);
 void jffs2_dirty_inode(struct inode *inode);
 struct inode *jffs2_new_inode (struct inode *dir_i, int mode,
 			       struct jffs2_raw_inode *ri);
-int jffs2_statfs (struct super_block *, struct kstatfs *);
+int jffs2_statfs (struct dentry *, struct kstatfs *);
 void jffs2_write_super (struct super_block *);
 int jffs2_remount_fs (struct super_block *, int *, char *);
 int jffs2_do_fill_super(struct super_block *sb, void *data, int silent);
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 0a81905..c5307e8 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -139,9 +139,9 @@ #endif
 	kmem_cache_free(jfs_inode_cachep, ji);
 }
 
-static int jfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int jfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(sb);
+	struct jfs_sb_info *sbi = JFS_SBI(dentry->d_sb);
 	s64 maxinodes;
 	struct inomap *imap = JFS_IP(sbi->ipimap)->i_imap;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index df55ac9..fc785d8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -20,9 +20,9 @@ int simple_getattr(struct vfsmount *mnt,
 	return 0;
 }
 
-int simple_statfs(struct super_block *sb, struct kstatfs *buf)
+int simple_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	buf->f_type = sb->s_magic;
+	buf->f_type = dentry->d_sb->s_magic;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	buf->f_namelen = NAME_MAX;
 	return 0;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 14f24df..a6fb509 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -19,7 +19,7 @@ #include <linux/vfs.h>
 
 static void minix_read_inode(struct inode * inode);
 static int minix_write_inode(struct inode * inode, int wait);
-static int minix_statfs(struct super_block *sb, struct kstatfs *buf);
+static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int minix_remount (struct super_block * sb, int * flags, char * data);
 
 static void minix_delete_inode(struct inode *inode)
@@ -296,11 +296,11 @@ out_bad_sb:
 	return -EINVAL;
 }
 
-static int minix_statfs(struct super_block *sb, struct kstatfs *buf)
+static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct minix_sb_info *sbi = minix_sb(sb);
-	buf->f_type = sb->s_magic;
-	buf->f_bsize = sb->s_blocksize;
+	struct minix_sb_info *sbi = minix_sb(dentry->d_sb);
+	buf->f_type = dentry->d_sb->s_magic;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
 	buf->f_blocks = (sbi->s_nzones - sbi->s_firstdatazone) << sbi->s_log_zone_size;
 	buf->f_bfree = minix_count_free_blocks(sbi);
 	buf->f_bavail = buf->f_bfree;
diff --git a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
index 8db033f..90d2ea2 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -39,7 +39,7 @@ #include "getopt.h"
 
 static void ncp_delete_inode(struct inode *);
 static void ncp_put_super(struct super_block *);
-static int  ncp_statfs(struct super_block *, struct kstatfs *);
+static int  ncp_statfs(struct dentry *, struct kstatfs *);
 
 static kmem_cache_t * ncp_inode_cachep;
 
@@ -724,13 +724,14 @@ #endif /* CONFIG_NCPFS_NLS */
 	kfree(server);
 }
 
-static int ncp_statfs(struct super_block *sb, struct kstatfs *buf)
+static int ncp_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct dentry* d;
 	struct inode* i;
 	struct ncp_inode_info* ni;
 	struct ncp_server* s;
 	struct ncp_volume_info vi;
+	struct super_block *sb = dentry->d_sb;
 	int err;
 	__u8 dh;
 	
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index c321f71..62e06b9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -67,7 +67,7 @@ static int nfs_write_inode(struct inode 
 static void nfs_delete_inode(struct inode *);
 static void nfs_clear_inode(struct inode *);
 static void nfs_umount_begin(struct vfsmount *, int);
-static int  nfs_statfs(struct super_block *, struct kstatfs *);
+static int  nfs_statfs(struct dentry *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 static int  nfs_show_stats(struct seq_file *, struct vfsmount *);
 static void nfs_zap_acl_cache(struct inode *);
@@ -548,8 +548,9 @@ #endif /* CONFIG_NFS_V3_ACL */
 }
 
 static int
-nfs_statfs(struct super_block *sb, struct kstatfs *buf)
+nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct nfs_server *server = NFS_SB(sb);
 	unsigned char blockbits;
 	unsigned long blockres;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index de3998f..5446a08 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1310,7 +1310,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	if ((bmval0 & (FATTR4_WORD0_FILES_FREE | FATTR4_WORD0_FILES_TOTAL)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
-		status = vfs_statfs(dentry->d_inode->i_sb, &statfs);
+		status = vfs_statfs(dentry, &statfs);
 		if (status)
 			goto out_nfserr;
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6aa92d0..0c2c9d9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1737,7 +1737,7 @@ int
 nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
 {
 	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
-	if (!err && vfs_statfs(fhp->fh_dentry->d_inode->i_sb,stat))
+	if (!err && vfs_statfs(fhp->fh_dentry,stat))
 		err = nfserr_io;
 	return err;
 }
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index d5d5e96..0e14ace 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2601,10 +2601,10 @@ static unsigned long __get_nr_free_mft_r
 
 /**
  * ntfs_statfs - return information about mounted NTFS volume
- * @sb:		super block of mounted volume
+ * @dentry:	dentry from mounted volume
  * @sfs:	statfs structure in which to return the information
  *
- * Return information about the mounted NTFS volume @sb in the statfs structure
+ * Return information about the mounted NTFS volume @dentry in the statfs structure
  * pointed to by @sfs (this is initialized with zeros before ntfs_statfs is
  * called). We interpret the values to be correct of the moment in time at
  * which we are called. Most values are variable otherwise and this isn't just
@@ -2617,8 +2617,9 @@ static unsigned long __get_nr_free_mft_r
  *
  * Return 0 on success or -errno on error.
  */
-static int ntfs_statfs(struct super_block *sb, struct kstatfs *sfs)
+static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
 {
+	struct super_block *sb = dentry->d_sb;
 	s64 size;
 	ntfs_volume *vol = NTFS_SB(sb);
 	ntfs_inode *mft_ni = NTFS_I(vol->mft_ino);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 788b8b5..cdf7339 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -100,7 +100,7 @@ static int ocfs2_initialize_mem_caches(v
 static void ocfs2_free_mem_caches(void);
 static void ocfs2_delete_osb(struct ocfs2_super *osb);
 
-static int ocfs2_statfs(struct super_block *sb, struct kstatfs *buf);
+static int ocfs2_statfs(struct dentry *dentry, struct kstatfs *buf);
 
 static int ocfs2_sync_fs(struct super_block *sb, int wait);
 
@@ -857,7 +857,7 @@ static void ocfs2_put_super(struct super
 	mlog_exit_void();
 }
 
-static int ocfs2_statfs(struct super_block *sb, struct kstatfs *buf)
+static int ocfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ocfs2_super *osb;
 	u32 numbits, freebits;
@@ -866,9 +866,9 @@ static int ocfs2_statfs(struct super_blo
 	struct buffer_head *bh = NULL;
 	struct inode *inode = NULL;
 
-	mlog_entry("(%p, %p)\n", sb, buf);
+	mlog_entry("(%p, %p)\n", dentry->d_sb, buf);
 
-	osb = OCFS2_SB(sb);
+	osb = OCFS2_SB(dentry->d_sb);
 
 	inode = ocfs2_get_system_file_inode(osb,
 					    GLOBAL_BITMAP_SYSTEM_INODE,
@@ -891,7 +891,7 @@ static int ocfs2_statfs(struct super_blo
 	freebits = numbits - le32_to_cpu(bm_lock->id1.bitmap1.i_used);
 
 	buf->f_type = OCFS2_SUPER_MAGIC;
-	buf->f_bsize = sb->s_blocksize;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
 	buf->f_namelen = OCFS2_MAX_FILENAME_LEN;
 	buf->f_blocks = ((sector_t) numbits) *
 			(osb->s_clustersize >> osb->sb->s_blocksize_bits);
diff --git a/fs/open.c b/fs/open.c
index 53ec28c..33fba83 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -31,18 +31,18 @@ #include <linux/audit.h>
 
 #include <asm/unistd.h>
 
-int vfs_statfs(struct super_block *sb, struct kstatfs *buf)
+int vfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	int retval = -ENODEV;
 
-	if (sb) {
+	if (dentry) {
 		retval = -ENOSYS;
-		if (sb->s_op->statfs) {
+		if (dentry->d_sb->s_op->statfs) {
 			memset(buf, 0, sizeof(*buf));
-			retval = security_sb_statfs(sb);
+			retval = security_sb_statfs(dentry);
 			if (retval)
 				return retval;
-			retval = sb->s_op->statfs(sb, buf);
+			retval = dentry->d_sb->s_op->statfs(dentry, buf);
 			if (retval == 0 && buf->f_frsize == 0)
 				buf->f_frsize = buf->f_bsize;
 		}
@@ -52,12 +52,12 @@ int vfs_statfs(struct super_block *sb, s
 
 EXPORT_SYMBOL(vfs_statfs);
 
-static int vfs_statfs_native(struct super_block *sb, struct statfs *buf)
+static int vfs_statfs_native(struct dentry *dentry, struct statfs *buf)
 {
 	struct kstatfs st;
 	int retval;
 
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -95,12 +95,12 @@ static int vfs_statfs_native(struct supe
 	return 0;
 }
 
-static int vfs_statfs64(struct super_block *sb, struct statfs64 *buf)
+static int vfs_statfs64(struct dentry *dentry, struct statfs64 *buf)
 {
 	struct kstatfs st;
 	int retval;
 
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -130,7 +130,7 @@ asmlinkage long sys_statfs(const char __
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs tmp;
-		error = vfs_statfs_native(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs_native(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -149,7 +149,7 @@ asmlinkage long sys_statfs64(const char 
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs64 tmp;
-		error = vfs_statfs64(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs64(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -168,7 +168,7 @@ asmlinkage long sys_fstatfs(unsigned int
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs_native(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs_native(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
@@ -189,7 +189,7 @@ asmlinkage long sys_fstatfs64(unsigned i
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs64(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs64(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e6cca5c..2f24c46 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -128,7 +128,7 @@ static struct inode *qnx4_alloc_inode(st
 static void qnx4_destroy_inode(struct inode *inode);
 static void qnx4_read_inode(struct inode *);
 static int qnx4_remount(struct super_block *sb, int *flags, char *data);
-static int qnx4_statfs(struct super_block *, struct kstatfs *);
+static int qnx4_statfs(struct dentry *, struct kstatfs *);
 
 static struct super_operations qnx4_sops =
 {
@@ -282,8 +282,10 @@ unsigned long qnx4_block_map( struct ino
 	return block;
 }
 
-static int qnx4_statfs(struct super_block *sb, struct kstatfs *buf)
+static int qnx4_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	lock_kernel();
 
 	buf->f_type    = sb->s_magic;
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index f3ff41d..00f1321 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -60,7 +60,7 @@ static int is_any_reiserfs_magic_string(
 }
 
 static int reiserfs_remount(struct super_block *s, int *flags, char *data);
-static int reiserfs_statfs(struct super_block *s, struct kstatfs *buf);
+static int reiserfs_statfs(struct dentry *dentry, struct kstatfs *buf);
 
 static int reiserfs_sync_fs(struct super_block *s, int wait)
 {
@@ -1938,15 +1938,15 @@ #endif
 	return errval;
 }
 
-static int reiserfs_statfs(struct super_block *s, struct kstatfs *buf)
+static int reiserfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct reiserfs_super_block *rs = SB_DISK_SUPER_BLOCK(s);
+	struct reiserfs_super_block *rs = SB_DISK_SUPER_BLOCK(dentry->d_sb);
 
 	buf->f_namelen = (REISERFS_MAX_NAME(s->s_blocksize));
 	buf->f_bfree = sb_free_blocks(rs);
 	buf->f_bavail = buf->f_bfree;
 	buf->f_blocks = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
-	buf->f_bsize = s->s_blocksize;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
 	/* changed to accommodate gcc folks. */
 	buf->f_type = REISERFS_SUPER_MAGIC;
 	return 0;
diff --git a/fs/romfs/inode.c b/fs/romfs/inode.c
index 4d6cd66..283fbc6 100644
--- a/fs/romfs/inode.c
+++ b/fs/romfs/inode.c
@@ -179,12 +179,12 @@ outnobh:
 /* That's simple too. */
 
 static int
-romfs_statfs(struct super_block *sb, struct kstatfs *buf)
+romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_bsize = ROMBSIZE;
 	buf->f_bfree = buf->f_bavail = buf->f_ffree;
-	buf->f_blocks = (romfs_maxsize(sb)+ROMBSIZE-1)>>ROMBSBITS;
+	buf->f_blocks = (romfs_maxsize(dentry->d_sb)+ROMBSIZE-1)>>ROMBSBITS;
 	buf->f_namelen = ROMFS_MAXFN;
 	return 0;
 }
diff --git a/fs/smbfs/inode.c b/fs/smbfs/inode.c
index 4a37c2b..506ff87 100644
--- a/fs/smbfs/inode.c
+++ b/fs/smbfs/inode.c
@@ -48,7 +48,7 @@ #define SMB_TTL_DEFAULT 1000
 
 static void smb_delete_inode(struct inode *);
 static void smb_put_super(struct super_block *);
-static int  smb_statfs(struct super_block *, struct kstatfs *);
+static int  smb_statfs(struct dentry *, struct kstatfs *);
 static int  smb_show_options(struct seq_file *, struct vfsmount *);
 
 static kmem_cache_t *smb_inode_cachep;
@@ -641,13 +641,13 @@ out_no_server:
 }
 
 static int
-smb_statfs(struct super_block *sb, struct kstatfs *buf)
+smb_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	int result;
 	
 	lock_kernel();
 
-	result = smb_proc_dskattr(sb, buf);
+	result = smb_proc_dskattr(dentry, buf);
 
 	unlock_kernel();
 
diff --git a/fs/smbfs/proc.c b/fs/smbfs/proc.c
index b1b878b..c349505 100644
--- a/fs/smbfs/proc.c
+++ b/fs/smbfs/proc.c
@@ -3226,9 +3226,9 @@ smb_proc_settime(struct dentry *dentry, 
 }
 
 int
-smb_proc_dskattr(struct super_block *sb, struct kstatfs *attr)
+smb_proc_dskattr(struct dentry *dentry, struct kstatfs *attr)
 {
-	struct smb_sb_info *server = SMB_SB(sb);
+	struct smb_sb_info *server = SMB_SB(dentry->d_sb);
 	int result;
 	char *p;
 	long unit;
diff --git a/fs/smbfs/proto.h b/fs/smbfs/proto.h
index 4766459..972ed7d 100644
--- a/fs/smbfs/proto.h
+++ b/fs/smbfs/proto.h
@@ -29,7 +29,7 @@ extern int smb_proc_getattr(struct dentr
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, unsigned int major, unsigned int minor);
 extern int smb_proc_settime(struct dentry *dentry, struct smb_fattr *fattr);
-extern int smb_proc_dskattr(struct super_block *sb, struct kstatfs *attr);
+extern int smb_proc_dskattr(struct dentry *dentry, struct kstatfs *attr);
 extern int smb_proc_read_link(struct smb_sb_info *server, struct dentry *d, char *buffer, int len);
 extern int smb_proc_symlink(struct smb_sb_info *server, struct dentry *d, const char *oldpath);
 extern int smb_proc_link(struct smb_sb_info *server, struct dentry *dentry, struct dentry *new_dentry);
diff --git a/fs/super.c b/fs/super.c
index 3daf41e..e0a71d0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -486,7 +486,7 @@ asmlinkage long sys_ustat(unsigned dev, 
         s = user_get_super(new_decode_dev(dev));
         if (s == NULL)
                 goto out;
-	err = vfs_statfs(s, &sbuf);
+	err = vfs_statfs(s->s_root, &sbuf);
 	drop_super(s);
 	if (err)
 		goto out;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 3ff89cc..58b2d22 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -85,8 +85,9 @@ static void sysv_put_super(struct super_
 	kfree(sbi);
 }
 
-static int sysv_statfs(struct super_block *sb, struct kstatfs *buf)
+static int sysv_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
 	buf->f_type = sb->s_magic;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2250774..44fe2cb 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -91,7 +91,7 @@ static void udf_load_partdesc(struct sup
 static void udf_open_lvid(struct super_block *);
 static void udf_close_lvid(struct super_block *);
 static unsigned int udf_count_free(struct super_block *);
-static int udf_statfs(struct super_block *, struct kstatfs *);
+static int udf_statfs(struct dentry *, struct kstatfs *);
 
 /* UDF filesystem type */
 static int udf_get_sb(struct file_system_type *fs_type,
@@ -1779,8 +1779,10 @@ #endif
  *	Written, tested, and released.
  */
 static int
-udf_statfs(struct super_block *sb, struct kstatfs *buf)
+udf_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	buf->f_type = UDF_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = UDF_SB_PARTLEN(sb, UDF_SB_PARTITION(sb));
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 768fb8d..fe5ab2a 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1113,8 +1113,9 @@ #endif
 	return 0;
 }
 
-static int ufs_statfs (struct super_block *sb, struct kstatfs *buf)
+static int ufs_statfs (struct dentry *dentry, struct kstatfs *buf)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block * usb;
diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 7702355..92c0cd4 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -703,10 +703,10 @@ xfs_fs_sync_super(
 
 STATIC int
 xfs_fs_statfs(
-	struct super_block	*sb,
+	struct dentry		*dentry,
 	struct kstatfs		*statp)
 {
-	vfs_t			*vfsp = vfs_from_sb(sb);
+	vfs_t			*vfsp = vfs_from_sb(dentry->d_sb);
 	int			error;
 
 	VFS_STATVFS(vfsp, statp, NULL, error);
diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index d539262..98f6c52 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -70,7 +70,7 @@ int venus_pioctl(struct super_block *sb,
 		 unsigned int cmd, struct PioctlData *data);
 int coda_downcall(int opcode, union outputArgs *out, struct super_block *sb);
 int venus_fsync(struct super_block *sb, struct CodaFid *fid);
-int venus_statfs(struct super_block *sb, struct kstatfs *sfs);
+int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
 
 
 /* messages between coda filesystem in kernel and Venus */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cde3028..1720be7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1097,7 +1097,7 @@ struct super_operations {
 	int (*sync_fs)(struct super_block *sb, int wait);
 	void (*write_super_lockfs) (struct super_block *);
 	void (*unlockfs) (struct super_block *);
-	int (*statfs) (struct super_block *, struct kstatfs *);
+	int (*statfs) (struct dentry *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct vfsmount *, int);
@@ -1326,7 +1326,7 @@ extern struct vfsmount *copy_tree(struct
 extern void mnt_set_mountpoint(struct vfsmount *, struct dentry *,
 				  struct vfsmount *);
 
-extern int vfs_statfs(struct super_block *, struct kstatfs *);
+extern int vfs_statfs(struct dentry *, struct kstatfs *);
 
 /* /sys/fs */
 extern struct subsystem fs_subsys;
@@ -1747,7 +1747,7 @@ extern int dcache_dir_close(struct inode
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, void *, filldir_t);
 extern int simple_getattr(struct vfsmount *, struct dentry *, struct kstat *);
-extern int simple_statfs(struct super_block *, struct kstatfs *);
+extern int simple_statfs(struct dentry *, struct kstatfs *);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 9b4e007..403d1a9 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -17,6 +17,11 @@ #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
+struct super_block;
+struct vfsmount;
+struct dentry;
+struct namespace;
+
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bab48f..5dee28f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -171,9 +171,9 @@ #ifdef CONFIG_SECURITY
  *	Deallocate and clear the sb->s_security field.
  *	@sb contains the super_block structure to be modified.
  * @sb_statfs:
- *	Check permission before obtaining filesystem statistics for the @sb
- *	filesystem.
- *	@sb contains the super_block structure for the filesystem.
+ *	Check permission before obtaining filesystem statistics for the @mnt
+ *	mountpoint.
+ *	@dentry is a handle on the superblock for the filesystem.
  *	Return 0 if permission is granted.  
  * @sb_mount:
  *	Check permission before an object specified by @dev_name is mounted on
@@ -1121,7 +1121,7 @@ struct security_operations {
 	int (*sb_copy_data)(struct file_system_type *type,
 			    void *orig, void *copy);
 	int (*sb_kern_mount) (struct super_block *sb, void *data);
-	int (*sb_statfs) (struct super_block * sb);
+	int (*sb_statfs) (struct dentry *dentry);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
 			 char *type, unsigned long flags, void *data);
 	int (*sb_check_sb) (struct vfsmount * mnt, struct nameidata * nd);
@@ -1442,9 +1442,9 @@ static inline int security_sb_kern_mount
 	return security_ops->sb_kern_mount (sb, data);
 }
 
-static inline int security_sb_statfs (struct super_block *sb)
+static inline int security_sb_statfs (struct dentry *dentry)
 {
-	return security_ops->sb_statfs (sb);
+	return security_ops->sb_statfs (dentry);
 }
 
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
@@ -2154,7 +2154,7 @@ static inline int security_sb_kern_mount
 	return 0;
 }
 
-static inline int security_sb_statfs (struct super_block *sb)
+static inline int security_sb_statfs (struct dentry *dentry)
 {
 	return 0;
 }
diff --git a/kernel/acct.c b/kernel/acct.c
index b327f4d..6802020 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -118,7 +118,7 @@ static int check_free_space(struct file 
 	spin_unlock(&acct_globals.lock);
 
 	/* May block */
-	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
+	if (vfs_statfs(file->f_dentry, &sbuf))
 		return res;
 	suspend = sbuf.f_blocks * SUSPEND;
 	resume = sbuf.f_blocks * RESUME;
diff --git a/mm/shmem.c b/mm/shmem.c
index ad19b6c..88b147d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1654,9 +1654,9 @@ static ssize_t shmem_file_sendfile(struc
 	return desc.error;
 }
 
-static int shmem_statfs(struct super_block *sb, struct kstatfs *buf)
+static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
 
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
diff --git a/security/dummy.c b/security/dummy.c
index 8cccccc..f7441cb 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -191,7 +191,7 @@ static int dummy_sb_kern_mount (struct s
 	return 0;
 }
 
-static int dummy_sb_statfs (struct super_block *sb)
+static int dummy_sb_statfs (struct dentry *dentry)
 {
 	return 0;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d987048..73bb078 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1900,13 +1900,13 @@ static int selinux_sb_kern_mount(struct 
 	return superblock_has_perm(current, sb, FILESYSTEM__MOUNT, &ad);
 }
 
-static int selinux_sb_statfs(struct super_block *sb)
+static int selinux_sb_statfs(struct dentry *dentry)
 {
 	struct avc_audit_data ad;
 
 	AVC_AUDIT_DATA_INIT(&ad,FS);
-	ad.u.fs.dentry = sb->s_root;
-	return superblock_has_perm(current, sb, FILESYSTEM__GETATTR, &ad);
+	ad.u.fs.dentry = dentry->d_sb->s_root;
+	return superblock_has_perm(current, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
 }
 
 static int selinux_mount(char * dev_name,

