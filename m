Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWEJQCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWEJQCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWEJQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:02:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964908AbWEJQB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:59 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/14] NFS: Permit filesystem to override root dentry on mount [try #8]
Date: Wed, 10 May 2006 17:01:21 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160120.9058.70635.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch extends the get_sb() filesystem operation to take an extra
argument that permits the VFS to pass in the target vfsmount that defines the
mountpoint.

The filesystem is then required to manually set the superblock and root dentry
pointers. For most filesystems, this should be done with simple_set_mnt() which
will set the superblock pointer and then set the root dentry to the
superblock's s_root (as per the old default behaviour).

This patch permits a superblock to be implicitly shared amongst several mount
points, such as can be done with NFS to avoid potential inode aliasing (see
patch #5). In such a case, simple_set_mnt() would not be called, and instead
the mnt_root and mnt_sb would be set directly.

This patch also changes the superblock cleanup routine to make it use
shrink_dcache_sb() instead of shrink_dcache_anon(). This required is because
the superblock may now have multiple trees that aren't actually bound to
s_root, but that still need to be cleaned up. The currently called functions
assume that the whole tree is rooted at s_root, and that anonymous dentries are
not the roots of trees which results in dentries being left unculled.


Following discussion with Al Viro, the following changes [try #2] were
made to the previous attempt at this set of patches:

 (*) The vfsmount is now passed into the get_sb() method for a filesystem
     instead of passing a pointer to a pointer to a dentry into which get_sb()
     could stick a root dentry if it wanted. get_sb() now instantiates the
     superblock and root dentry pointers in the vfsmount itself.

 (*) The get_sb() method now returns an integer (0 or -ve error number) rather
     than the superblock pointer or cast error number.

 (*) the get_sb_*() convenience functions in the core kernel now take a
     vfsmount pointer argument and return an integer, so most filesystems have
     to change very little.

 (*) If one of the convenience function is not used, then get_sb() should
     normally call simple_set_mnt() to instantiate the vfsmount. This will
     always return 0, and so can be tail-called from get_sb().

 (*) generic_shutdown_super() now calls shrink_dcache_sb() to clean up the
     dcache upon superblock destruction rather than shrink_dcache_parent() and
     shrink_dcache_anon(). This is because, as far as I can tell, the current
     code assumes that all the dentries will be linked into a tree depending
     from sb->s_root, and that anonymous dentries won't have children.

     However, with the way these patches implement NFS superblock sharing,
     these assumptions are violated: the root of the filesystem is simply a
     dummy dentry and inode (the real inode for '/' may well be inaccessible),
     and all the vfsmounts are rooted on anonymous[*] dentries with child
     trees.

     [*] Anonymous until discovered from another tree.

Further changes [try #3] that have been made:

 (*) The patches are now against Trond's NFS git tree, so won't apply to
     Linus's tree.

 (*) Core documentation changes have been moved to the first patch.

Further changes [try #4]:

 (*) shrink_dcache_parent() has been reintroduced to handle final cleanup of
     filesystem types such as nfsd and binfmt_misc that have pinned dentries.

 (*) get_sb_bdev() has been fixed to handle the superblock sharing case
     correctly (it should not go down the error path).

Further changes [try #5]:

 (*) Make futex_get_sb() static once again.

 (*) Fold together the patch that changes the core and the patch that modifies
     all the filesystems to cope with the core change as some people are unable
     to cope with two interdependent patches.


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/Locking         |    7 +
 Documentation/filesystems/porting         |    7 +
 Documentation/filesystems/vfs.txt         |    4 -
 arch/ia64/kernel/perfmon.c                |    7 +
 arch/powerpc/platforms/cell/spufs/inode.c |    6 +
 drivers/infiniband/core/uverbs_main.c     |    7 +
 drivers/isdn/capi/capifs.c                |    6 +
 drivers/misc/ibmasm/ibmasmfs.c            |    7 +
 drivers/oprofile/oprofilefs.c             |    6 +
 drivers/usb/core/inode.c                  |    6 +
 drivers/usb/gadget/inode.c                |    6 +
 fs/9p/vfs_super.c                         |   21 ++--
 fs/adfs/super.c                           |    7 +
 fs/affs/super.c                           |    7 +
 fs/afs/super.c                            |   24 +++--
 fs/autofs/init.c                          |    6 +
 fs/autofs4/init.c                         |    6 +
 fs/befs/linuxvfs.c                        |    7 +
 fs/bfs/inode.c                            |    6 +
 fs/binfmt_misc.c                          |    6 +
 fs/block_dev.c                            |    6 +
 fs/cifs/cifsfs.c                          |   10 +-
 fs/coda/inode.c                           |    6 +
 fs/configfs/mount.c                       |    6 +
 fs/cramfs/inode.c                         |    7 +
 fs/debugfs/inode.c                        |    8 +-
 fs/devfs/base.c                           |    8 +-
 fs/devpts/inode.c                         |    6 +
 fs/efs/super.c                            |    6 +
 fs/eventpoll.c                            |   13 +--
 fs/ext2/super.c                           |    6 +
 fs/ext3/super.c                           |    6 +
 fs/freevxfs/vxfs_super.c                  |    7 +
 fs/fuse/inode.c                           |    8 +-
 fs/hfs/super.c                            |    7 +
 fs/hfsplus/super.c                        |    8 +-
 fs/hostfs/hostfs_kern.c                   |    8 +-
 fs/hpfs/super.c                           |    7 +
 fs/hppfs/hppfs_kern.c                     |    8 +-
 fs/hugetlbfs/inode.c                      |    6 +
 fs/inotify.c                              |    6 +
 fs/isofs/inode.c                          |    7 +
 fs/jffs/inode-v23.c                       |    7 +
 fs/jffs2/super.c                          |   49 +++++-----
 fs/jfs/super.c                            |    7 +
 fs/libfs.c                                |   12 +-
 fs/minix/inode.c                          |    7 +
 fs/msdos/namei.c                          |    9 +-
 fs/namespace.c                            |    9 ++
 fs/ncpfs/inode.c                          |    6 +
 fs/nfs/inode.c                            |  146 ++++++++++++++++++-----------
 fs/nfsd/nfsctl.c                          |    6 +
 fs/ntfs/super.c                           |    7 +
 fs/ocfs2/dlm/dlmfs.c                      |    6 +
 fs/ocfs2/super.c                          |   12 +-
 fs/openpromfs/inode.c                     |    6 +
 fs/pipe.c                                 |    9 +-
 fs/proc/root.c                            |    6 +
 fs/qnx4/inode.c                           |    7 +
 fs/ramfs/inode.c                          |   13 +--
 fs/reiserfs/super.c                       |    9 +-
 fs/romfs/inode.c                          |    7 +
 fs/smbfs/inode.c                          |    6 +
 fs/super.c                                |   97 +++++++++++--------
 fs/sysfs/mount.c                          |    6 +
 fs/sysv/super.c                           |   13 +--
 fs/udf/super.c                            |    6 +
 fs/ufs/super.c                            |    6 +
 fs/vfat/namei.c                           |    9 +-
 fs/xfs/linux-2.6/xfs_super.c              |    8 +-
 include/linux/fs.h                        |   25 +++--
 include/linux/ramfs.h                     |    4 -
 ipc/mqueue.c                              |    8 +-
 kernel/cpuset.c                           |    8 +-
 kernel/futex.c                            |    8 +-
 mm/shmem.c                                |    6 +
 net/socket.c                              |    7 +
 net/sunrpc/rpc_pipe.c                     |    6 +
 security/inode.c                          |    8 +-
 security/selinux/selinuxfs.c              |    7 +
 80 files changed, 498 insertions(+), 399 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 1045da5..3abf08f 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -142,15 +142,16 @@ see also dquot_operations section.
 
 --------------------------- file_system_type ---------------------------
 prototypes:
-	struct super_block *(*get_sb) (struct file_system_type *, int,
-			const char *, void *);
+	struct int (*get_sb) (struct file_system_type *, int,
+			const char *, void *, struct vfsmount *);
 	void (*kill_sb) (struct super_block *);
 locking rules:
 		may block	BKL
 get_sb		yes		yes
 kill_sb		yes		yes
 
-->get_sb() returns error or a locked superblock (exclusive on ->s_umount).
+->get_sb() returns error or 0 with locked superblock attached to the vfsmount
+(exclusive on ->s_umount).
 ->kill_sb() takes a write-locked superblock, does all shutdown work on it,
 unlocks and drops the reference.
 
diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 2f38846..ae8db97 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -50,10 +50,11 @@ Turn your foo_read_super() into a functi
 success and negative number in case of error (-EINVAL unless you have more
 informative error value to report).  Call it foo_fill_super().  Now declare
 
-struct super_block foo_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+int foo_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super,
+			   mnt);
 }
 
 (or similar with s/bdev/nodev/ or s/bdev/single/, depending on the kind of
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 3a2e552..dd7d0dc 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -113,8 +113,8 @@ members are defined:
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-        struct super_block *(*get_sb) (struct file_system_type *, int,
-                                       const char *, void *);
+        struct int (*get_sb) (struct file_system_type *, int,
+                              const char *, void *, struct vfsmount *);
         void (*kill_sb) (struct super_block *);
         struct module *owner;
         struct file_system_type * next;
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 077f212..2359e28 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -595,10 +595,11 @@ pfm_get_unmapped_area(struct file *file,
 }
 
 
-static struct super_block *
-pfmfs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name, void *data)
+static int
+pfmfs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name, void *data,
+	     struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "pfm:", NULL, PFMFS_MAGIC);
+	return get_sb_pseudo(fs_type, "pfm:", NULL, PFMFS_MAGIC, mnt);
 }
 
 static struct file_system_type pfm_fs_type = {
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index d955419..45cbd05 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -428,11 +428,11 @@ spufs_fill_super(struct super_block *sb,
 	return spufs_create_root(sb, data);
 }
 
-static struct super_block *
+static int
 spufs_get_sb(struct file_system_type *fstype, int flags,
-		const char *name, void *data)
+		const char *name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fstype, flags, data, spufs_fill_super);
+	return get_sb_single(fstype, flags, data, spufs_fill_super, mnt);
 }
 
 static struct file_system_type spufs_type = {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index ff092a0..7a05783 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -820,11 +820,12 @@ static void ib_uverbs_remove_one(struct 
 	kref_put(&uverbs_dev->ref, ib_uverbs_release_dev);
 }
 
-static struct super_block *uverbs_event_get_sb(struct file_system_type *fs_type, int flags,
-					       const char *dev_name, void *data)
+static int uverbs_event_get_sb(struct file_system_type *fs_type, int flags,
+			       const char *dev_name, void *data,
+			       struct vfsmount *mnt)
 {
 	return get_sb_pseudo(fs_type, "infinibandevent:", NULL,
-			     INFINIBANDEVENTFS_MAGIC);
+			     INFINIBANDEVENTFS_MAGIC, mnt);
 }
 
 static struct file_system_type uverbs_event_fs = {
diff --git a/drivers/isdn/capi/capifs.c b/drivers/isdn/capi/capifs.c
index 0a37ade..9ea6bd0 100644
--- a/drivers/isdn/capi/capifs.c
+++ b/drivers/isdn/capi/capifs.c
@@ -121,10 +121,10 @@ fail:
 	return -ENOMEM;
 }
 
-static struct super_block *capifs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int capifs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, capifs_fill_super);
+	return get_sb_single(fs_type, flags, data, capifs_fill_super, mnt);
 }
 
 static struct file_system_type capifs_fs_type = {
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index 26a230b..4a35caf 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -90,10 +90,11 @@ static void ibmasmfs_create_files (struc
 static int ibmasmfs_fill_super (struct super_block *sb, void *data, int silent);
 
 
-static struct super_block *ibmasmfs_get_super(struct file_system_type *fst,
-			int flags, const char *name, void *data)
+static int ibmasmfs_get_super(struct file_system_type *fst,
+			int flags, const char *name, void *data,
+			struct vfsmount *mnt)
 {
-	return get_sb_single(fst, flags, data, ibmasmfs_fill_super);
+	return get_sb_single(fst, flags, data, ibmasmfs_fill_super, mnt);
 }
 
 static struct super_operations ibmasmfs_s_ops = {
diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index b62da9b..71c2da2 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -272,10 +272,10 @@ static int oprofilefs_fill_super(struct 
 }
 
 
-static struct super_block *oprofilefs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int oprofilefs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, oprofilefs_fill_super);
+	return get_sb_single(fs_type, flags, data, oprofilefs_fill_super, mnt);
 }
 
 
diff --git a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
index 695b90a..bfc9b28 100644
--- a/drivers/usb/core/inode.c
+++ b/drivers/usb/core/inode.c
@@ -543,10 +543,10 @@ static void fs_remove_file (struct dentr
 
 /* --------------------------------------------------------------------- */
 
-static struct super_block *usb_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int usb_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, usbfs_fill_super);
+	return get_sb_single(fs_type, flags, data, usbfs_fill_super, mnt);
 }
 
 static struct file_system_type usb_fs_type = {
diff --git a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
index 0eb010a..6b64986 100644
--- a/drivers/usb/gadget/inode.c
+++ b/drivers/usb/gadget/inode.c
@@ -2064,11 +2064,11 @@ gadgetfs_fill_super (struct super_block 
 }
 
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
-static struct super_block *
+static int
 gadgetfs_get_sb (struct file_system_type *t, int flags,
-		const char *path, void *opts)
+		const char *path, void *opts, struct vfsmount *mnt)
 {
-	return get_sb_single (t, flags, opts, gadgetfs_fill_super);
+	return get_sb_single (t, flags, opts, gadgetfs_fill_super, mnt);
 }
 
 static void
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 00c1f6b..8b15bb2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -99,12 +99,13 @@ v9fs_fill_super(struct super_block *sb, 
  * @flags: mount flags
  * @dev_name: device name that was mounted
  * @data: mount options
+ * @mnt: mountpoint record to be instantiated
  *
  */
 
-static struct super_block *v9fs_get_sb(struct file_system_type
-				       *fs_type, int flags,
-				       const char *dev_name, void *data)
+static int v9fs_get_sb(struct file_system_type *fs_type, int flags,
+		       const char *dev_name, void *data,
+		       struct vfsmount *mnt)
 {
 	struct super_block *sb = NULL;
 	struct v9fs_fcall *fcall = NULL;
@@ -123,17 +124,19 @@ static struct super_block *v9fs_get_sb(s
 
 	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
 	if (!v9ses)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
-		sb = ERR_PTR(newfid);
+		retval = newfid;
 		goto out_free_session;
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		retval = PTR_ERR(sb);
 		goto out_close_session;
+	}
 	v9fs_fill_super(sb, v9ses, flags);
 
 	inode = v9fs_get_inode(sb, S_IFDIR | mode);
@@ -184,19 +187,19 @@ static struct super_block *v9fs_get_sb(s
 		goto put_back_sb;
 	}
 
-	return sb;
+	return simple_set_mnt(mnt, sb);
 
 out_close_session:
 	v9fs_session_close(v9ses);
 out_free_session:
 	kfree(v9ses);
-	return sb;
+	return retval;
 
 put_back_sb:
 	/* deactivate_super calls v9fs_kill_super which will frees the rest */
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-	return ERR_PTR(retval);
+	return retval;
 }
 
 /**
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 252abda..1b58a9b 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -470,10 +470,11 @@ error:
 	return -EINVAL;
 }
 
-static struct super_block *adfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int adfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, adfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type adfs_fs_type = {
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 4d7e5b1..6a52e78 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -524,10 +524,11 @@ affs_statfs(struct super_block *sb, stru
 	return 0;
 }
 
-static struct super_block *affs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int affs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, affs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, affs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type affs_fs_type = {
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 93a7821..67d1f5c 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -38,9 +38,9 @@ struct afs_mount_params {
 static void afs_i_init_once(void *foo, kmem_cache_t *cachep,
 			    unsigned long flags);
 
-static struct super_block *afs_get_sb(struct file_system_type *fs_type,
-				      int flags, const char *dev_name,
-				      void *data);
+static int afs_get_sb(struct file_system_type *fs_type,
+		      int flags, const char *dev_name,
+		      void *data, struct vfsmount *mnt);
 
 static struct inode *afs_alloc_inode(struct super_block *sb);
 
@@ -294,10 +294,11 @@ static int afs_fill_super(struct super_b
  * get an AFS superblock
  * - TODO: don't use get_sb_nodev(), but rather call sget() directly
  */
-static struct super_block *afs_get_sb(struct file_system_type *fs_type,
-				      int flags,
-				      const char *dev_name,
-				      void *options)
+static int afs_get_sb(struct file_system_type *fs_type,
+		      int flags,
+		      const char *dev_name,
+		      void *options,
+		      struct vfsmount *mnt)
 {
 	struct afs_mount_params params;
 	struct super_block *sb;
@@ -311,7 +312,7 @@ static struct super_block *afs_get_sb(st
 	ret = afscm_start();
 	if (ret < 0) {
 		_leave(" = %d", ret);
-		return ERR_PTR(ret);
+		return ret;
 	}
 
 	/* parse the options */
@@ -348,18 +349,19 @@ static struct super_block *afs_get_sb(st
 		goto error;
 	}
 	sb->s_flags |= MS_ACTIVE;
+	simple_set_mnt(mnt, sb);
 
 	afs_put_volume(params.volume);
 	afs_put_cell(params.default_cell);
-	_leave(" = %p", sb);
-	return sb;
+	_leave(" = 0 [%p]", 0, sb);
+	return 0;
 
  error:
 	afs_put_volume(params.volume);
 	afs_put_cell(params.default_cell);
 	afscm_stop();
 	_leave(" = %d", ret);
-	return ERR_PTR(ret);
+	return ret;
 } /* end afs_get_sb() */
 
 /*****************************************************************************/
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index b977ece..aca1237 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -14,10 +14,10 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include "autofs_i.h"
 
-static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int autofs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, autofs_fill_super);
+	return get_sb_nodev(fs_type, flags, data, autofs_fill_super, mnt);
 }
 
 static struct file_system_type autofs_fs_type = {
diff --git a/fs/autofs4/init.c b/fs/autofs4/init.c
index acecec8..5d91933 100644
--- a/fs/autofs4/init.c
+++ b/fs/autofs4/init.c
@@ -14,10 +14,10 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include "autofs_i.h"
 
-static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int autofs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, autofs4_fill_super);
+	return get_sb_nodev(fs_type, flags, data, autofs4_fill_super, mnt);
 }
 
 static struct file_system_type autofs_fs_type = {
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 68ebd10..6ed07a5 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -899,11 +899,12 @@ befs_statfs(struct super_block *sb, stru
 	return 0;
 }
 
-static struct super_block *
+static int
 befs_get_sb(struct file_system_type *fs_type, int flags, const char *dev_name,
-	    void *data)
+	    void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, befs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, befs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type befs_fs_type = {
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 55a7a78..e7da03f 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -410,10 +410,10 @@ out:
 	return -EINVAL;
 }
 
-static struct super_block *bfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, bfs_fill_super, mnt);
 }
 
 static struct file_system_type bfs_fs_type = {
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c0a909e..692cca9 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -741,10 +741,10 @@ static int bm_fill_super(struct super_bl
 	return err;
 }
 
-static struct super_block *bm_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bm_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, bm_fill_super);
+	return get_sb_single(fs_type, flags, data, bm_fill_super, mnt);
 }
 
 static struct linux_binfmt misc_format = {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f5958f4..38a2a66 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -300,10 +300,10 @@ static struct super_operations bdev_sops
 	.clear_inode = bdev_clear_inode,
 };
 
-static struct super_block *bd_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bd_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "bdev:", &bdev_sops, 0x62646576);
+	return get_sb_pseudo(fs_type, "bdev:", &bdev_sops, 0x62646576, mnt);
 }
 
 static struct file_system_type bd_type = {
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 3fdc225..6779837 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -462,9 +462,9 @@ #endif
 	.remount_fs = cifs_remount,
 };
 
-static struct super_block *
+static int
 cifs_get_sb(struct file_system_type *fs_type,
-	    int flags, const char *dev_name, void *data)
+	    int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
 	int rc;
 	struct super_block *sb = sget(fs_type, NULL, set_anon_super, NULL);
@@ -472,7 +472,7 @@ cifs_get_sb(struct file_system_type *fs_
 	cFYI(1, ("Devname: %s flags: %d ", dev_name, flags));
 
 	if (IS_ERR(sb))
-		return sb;
+		return PTR_ERR(sb);
 
 	sb->s_flags = flags;
 
@@ -480,10 +480,10 @@ cifs_get_sb(struct file_system_type *fs_
 	if (rc) {
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
-		return ERR_PTR(rc);
+		return rc;
 	}
 	sb->s_flags |= MS_ACTIVE;
-	return sb;
+	return simple_set_mnt(mnt, sb);
 }
 
 static ssize_t cifs_file_writev(struct file *file, const struct iovec *iov,
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index ada1a81..cba7020 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -307,10 +307,10 @@ static int coda_statfs(struct super_bloc
 
 /* init_coda: used by filesystems.c to register coda */
 
-static struct super_block *coda_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int coda_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, coda_fill_super);
+	return get_sb_nodev(fs_type, flags, data, coda_fill_super, mnt);
 }
 
 struct file_system_type coda_fs_type = {
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index be5d86a..3e5fe84 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -103,10 +103,10 @@ static int configfs_fill_super(struct su
 	return 0;
 }
 
-static struct super_block *configfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int configfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, configfs_fill_super);
+	return get_sb_single(fs_type, flags, data, configfs_fill_super, mnt);
 }
 
 static struct file_system_type configfs_fs_type = {
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9efcc3a..37a91a1 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -528,10 +528,11 @@ static struct super_operations cramfs_op
 	.statfs		= cramfs_statfs,
 };
 
-static struct super_block *cramfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int cramfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, cramfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, cramfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type cramfs_fs_type = {
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 579e1b6..5cd8500 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -110,11 +110,11 @@ static int debug_fill_super(struct super
 	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
 }
 
-static struct super_block *debug_get_sb(struct file_system_type *fs_type,
-				        int flags, const char *dev_name,
-					void *data)
+static int debug_get_sb(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, debug_fill_super);
+	return get_sb_single(fs_type, flags, data, debug_fill_super, mnt);
 }
 
 static struct file_system_type debug_fs_type = {
diff --git a/fs/devfs/base.c b/fs/devfs/base.c
index 52f5059..51a97f1 100644
--- a/fs/devfs/base.c
+++ b/fs/devfs/base.c
@@ -2549,11 +2549,11 @@ static int devfs_fill_super(struct super
 	return -EINVAL;
 }				/*  End Function devfs_fill_super  */
 
-static struct super_block *devfs_get_sb(struct file_system_type *fs_type,
-					int flags, const char *dev_name,
-					void *data)
+static int devfs_get_sb(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, devfs_fill_super);
+	return get_sb_single(fs_type, flags, data, devfs_fill_super, mnt);
 }
 
 static struct file_system_type devfs_fs_type = {
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 14c5620..f7aef5b 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -130,10 +130,10 @@ fail:
 	return -ENOMEM;
 }
 
-static struct super_block *devpts_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int devpts_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, devpts_fill_super);
+	return get_sb_single(fs_type, flags, data, devpts_fill_super, mnt);
 }
 
 static struct file_system_type devpts_fs_type = {
diff --git a/fs/efs/super.c b/fs/efs/super.c
index dff623e..1ba5e14 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -18,10 +18,10 @@ #include <linux/vfs.h>
 static int efs_statfs(struct super_block *s, struct kstatfs *buf);
 static int efs_fill_super(struct super_block *s, void *d, int silent);
 
-static struct super_block *efs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int efs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, efs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, efs_fill_super, mnt);
 }
 
 static struct file_system_type efs_fs_type = {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b4491c..63d857b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -268,9 +268,9 @@ static int ep_poll(struct eventpoll *ep,
 		   int maxevents, long timeout);
 static int eventpollfs_delete_dentry(struct dentry *dentry);
 static struct inode *ep_eventpoll_inode(void);
-static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
-					      int flags, const char *dev_name,
-					      void *data);
+static int eventpollfs_get_sb(struct file_system_type *fs_type,
+			      int flags, const char *dev_name,
+			      void *data, struct vfsmount *mnt);
 
 /*
  * This semaphore is used to serialize ep_free() and eventpoll_release_file().
@@ -1595,11 +1595,12 @@ eexit_1:
 }
 
 
-static struct super_block *
+static int
 eventpollfs_get_sb(struct file_system_type *fs_type, int flags,
-		   const char *dev_name, void *data)
+		   const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC);
+	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC,
+			     mnt);
 }
 
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 7e30bae..a4dfffa 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1087,10 +1087,10 @@ static int ext2_statfs (struct super_blo
 	return 0;
 }
 
-static struct super_block *ext2_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ext2_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super, mnt);
 }
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index f8a5266..657f8e7 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -2646,10 +2646,10 @@ out:
 
 #endif
 
-static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ext3_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ext3_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ext3_fill_super, mnt);
 }
 
 static struct file_system_type ext3_fs_type = {
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index b44c916..d76eeaa 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -241,10 +241,11 @@ out:
 /*
  * The usual module blurb.
  */
-static struct super_block *vxfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int vxfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, vxfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type vxfs_fs_type = {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 13ebe57..5c5ab5f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -570,11 +570,11 @@ static int fuse_fill_super(struct super_
 	return err;
 }
 
-static struct super_block *fuse_get_sb(struct file_system_type *fs_type,
-				       int flags, const char *dev_name,
-				       void *raw_data)
+static int fuse_get_sb(struct file_system_type *fs_type,
+		       int flags, const char *dev_name,
+		       void *raw_data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super);
+	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super, mnt);
 }
 
 static struct file_system_type fuse_fs_type = {
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 1181d11..ee5b80a 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -413,10 +413,11 @@ bail:
 	return res;
 }
 
-static struct super_block *hfs_get_sb(struct file_system_type *fs_type,
-				      int flags, const char *dev_name, void *data)
+static int hfs_get_sb(struct file_system_type *fs_type,
+		      int flags, const char *dev_name, void *data,
+		      struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, hfs_fill_super, mnt);
 }
 
 static struct file_system_type hfs_fs_type = {
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7843f79..0ed8b7e 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -450,10 +450,12 @@ static void hfsplus_destroy_inode(struct
 
 #define HFSPLUS_INODE_SIZE	sizeof(struct hfsplus_inode_info)
 
-static struct super_block *hfsplus_get_sb(struct file_system_type *fs_type,
-					  int flags, const char *dev_name, void *data)
+static int hfsplus_get_sb(struct file_system_type *fs_type,
+			  int flags, const char *dev_name, void *data,
+			  struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super,
+			   mnt);
 }
 
 static struct file_system_type hfsplus_fs_type = {
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index bf0f8e1..04035e0 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -993,11 +993,11 @@ static int hostfs_fill_sb_common(struct 
 	return(err);
 }
 
-static struct super_block *hostfs_read_sb(struct file_system_type *type,
-					     int flags, const char *dev_name,
-					     void *data)
+static int hostfs_read_sb(struct file_system_type *type,
+			  int flags, const char *dev_name,
+			  void *data, struct vfsmount *mnt)
 {
-	return(get_sb_nodev(type, flags, data, hostfs_fill_sb_common));
+	return get_sb_nodev(type, flags, data, hostfs_fill_sb_common, mnt);
 }
 
 static struct file_system_type hostfs_type = {
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index d72d8c8..3b25cf3 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -662,10 +662,11 @@ bail0:
 	return -EINVAL;
 }
 
-static struct super_block *hpfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int hpfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, hpfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type hpfs_fs_type = {
diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index 5e6363b..ec43c22 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -769,11 +769,11 @@ static int hppfs_fill_super(struct super
 	return(err);
 }
 
-static struct super_block *hppfs_read_super(struct file_system_type *type,
-					     int flags, const char *dev_name,
-					     void *data)
+static int hppfs_read_super(struct file_system_type *type,
+			    int flags, const char *dev_name,
+			    void *data, struct vfsmount *mnt)
 {
-	return(get_sb_nodev(type, flags, data, hppfs_fill_super));
+	return get_sb_nodev(type, flags, data, hppfs_fill_super, mnt);
 }
 
 static struct file_system_type hppfs_type = {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a5b4e9..4665c26 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -723,10 +723,10 @@ void hugetlb_put_quota(struct address_sp
 	}
 }
 
-static struct super_block *hugetlbfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int hugetlbfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, hugetlbfs_fill_super);
+	return get_sb_nodev(fs_type, flags, data, hugetlbfs_fill_super, mnt);
 }
 
 static struct file_system_type hugetlbfs_fs_type = {
diff --git a/fs/inotify.c b/fs/inotify.c
index 1f50302..d3ae18d 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -1098,11 +1098,11 @@ out:
 	return ret;
 }
 
-static struct super_block *
+static int
 inotify_get_sb(struct file_system_type *fs_type, int flags,
-	       const char *dev_name, void *data)
+	       const char *dev_name, void *data, struct vfsmount *mnt)
 {
-    return get_sb_pseudo(fs_type, "inotify", NULL, 0xBAD1DEA);
+	return get_sb_pseudo(fs_type, "inotify", NULL, 0xBAD1DEA, mnt);
 }
 
 static struct file_system_type inotify_fs_type = {
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 70adbb9..17268da 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1399,10 +1399,11 @@ struct inode *isofs_iget(struct super_bl
 	return inode;
 }
 
-static struct super_block *isofs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int isofs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, isofs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type iso9660_fs_type = {
diff --git a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
index 020cc09..dd93a09 100644
--- a/fs/jffs/inode-v23.c
+++ b/fs/jffs/inode-v23.c
@@ -1785,10 +1785,11 @@ static struct super_operations jffs_ops 
 	.remount_fs	= jffs_remount,
 };
 
-static struct super_block *jffs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int jffs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, jffs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, jffs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type jffs_fs_type = {
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index ffd8e84..03053f3 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -111,9 +111,10 @@ static int jffs2_sb_set(struct super_blo
 	return 0;
 }
 
-static struct super_block *jffs2_get_sb_mtd(struct file_system_type *fs_type,
-					      int flags, const char *dev_name,
-					      void *data, struct mtd_info *mtd)
+static int jffs2_get_sb_mtd(struct file_system_type *fs_type,
+			    int flags, const char *dev_name,
+			    void *data, struct mtd_info *mtd,
+			    struct vfsmount *mnt)
 {
 	struct super_block *sb;
 	struct jffs2_sb_info *c;
@@ -121,19 +122,20 @@ static struct super_block *jffs2_get_sb_
 
 	c = kmalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	memset(c, 0, sizeof(*c));
 	c->mtd = mtd;
 
 	sb = sget(fs_type, jffs2_sb_compare, jffs2_sb_set, c);
 
 	if (IS_ERR(sb))
-		goto out_put;
+		goto out_error;
 
 	if (sb->s_root) {
 		/* New mountpoint for JFFS2 which is already mounted */
 		D1(printk(KERN_DEBUG "jffs2_get_sb_mtd(): Device %d (\"%s\") is already mounted\n",
 			  mtd->index, mtd->name));
+		ret = simple_set_mnt(mnt, sb);
 		goto out_put;
 	}
 
@@ -158,44 +160,47 @@ static struct super_block *jffs2_get_sb_
 		/* Failure case... */
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
-		return ERR_PTR(ret);
+		return ret;
 	}
 
 	sb->s_flags |= MS_ACTIVE;
-	return sb;
+	return simple_set_mnt(mnt, sb);
 
+out_error:
+	ret = PTR_ERR(sb);
  out_put:
 	kfree(c);
 	put_mtd_device(mtd);
 
-	return sb;
+	return ret;
 }
 
-static struct super_block *jffs2_get_sb_mtdnr(struct file_system_type *fs_type,
-					      int flags, const char *dev_name,
-					      void *data, int mtdnr)
+static int jffs2_get_sb_mtdnr(struct file_system_type *fs_type,
+			      int flags, const char *dev_name,
+			      void *data, int mtdnr,
+			      struct vfsmount *mnt)
 {
 	struct mtd_info *mtd;
 
 	mtd = get_mtd_device(NULL, mtdnr);
 	if (!mtd) {
 		D1(printk(KERN_DEBUG "jffs2: MTD device #%u doesn't appear to exist\n", mtdnr));
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	return jffs2_get_sb_mtd(fs_type, flags, dev_name, data, mtd);
+	return jffs2_get_sb_mtd(fs_type, flags, dev_name, data, mtd, mnt);
 }
 
-static struct super_block *jffs2_get_sb(struct file_system_type *fs_type,
-					int flags, const char *dev_name,
-					void *data)
+static int jffs2_get_sb(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data, struct vfsmount *mnt)
 {
 	int err;
 	struct nameidata nd;
 	int mtdnr;
 
 	if (!dev_name)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	D1(printk(KERN_DEBUG "jffs2_get_sb(): dev_name \"%s\"\n", dev_name));
 
@@ -217,7 +222,7 @@ static struct super_block *jffs2_get_sb(
 				mtd = get_mtd_device(NULL, mtdnr);
 				if (mtd) {
 					if (!strcmp(mtd->name, dev_name+4))
-						return jffs2_get_sb_mtd(fs_type, flags, dev_name, data, mtd);
+						return jffs2_get_sb_mtd(fs_type, flags, dev_name, data, mtd, mnt);
 					put_mtd_device(mtd);
 				}
 			}
@@ -230,7 +235,7 @@ static struct super_block *jffs2_get_sb(
 			if (!*endptr) {
 				/* It was a valid number */
 				D1(printk(KERN_DEBUG "jffs2_get_sb(): mtd%%d, mtdnr %d\n", mtdnr));
-				return jffs2_get_sb_mtdnr(fs_type, flags, dev_name, data, mtdnr);
+				return jffs2_get_sb_mtdnr(fs_type, flags, dev_name, data, mtdnr, mnt);
 			}
 		}
 	}
@@ -244,7 +249,7 @@ static struct super_block *jffs2_get_sb(
 		  err, nd.dentry->d_inode));
 
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	err = -EINVAL;
 
@@ -266,11 +271,11 @@ static struct super_block *jffs2_get_sb(
 	mtdnr = iminor(nd.dentry->d_inode);
 	path_release(&nd);
 
-	return jffs2_get_sb_mtdnr(fs_type, flags, dev_name, data, mtdnr);
+	return jffs2_get_sb_mtdnr(fs_type, flags, dev_name, data, mtdnr, mnt);
 
 out:
 	path_release(&nd);
-	return ERR_PTR(err);
+	return err;
 }
 
 static void jffs2_put_super (struct super_block *sb)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index db6f41d..0a81905 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -565,10 +565,11 @@ static void jfs_unlockfs(struct super_bl
 	}
 }
 
-static struct super_block *jfs_get_sb(struct file_system_type *fs_type, 
-	int flags, const char *dev_name, void *data)
+static int jfs_get_sb(struct file_system_type *fs_type, 
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, jfs_fill_super,
+			   mnt);
 }
 
 static int jfs_sync_fs(struct super_block *sb, int wait)
diff --git a/fs/libfs.c b/fs/libfs.c
index 4a3ec9a..df55ac9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -196,9 +196,9 @@ struct inode_operations simple_dir_inode
  * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
  * will never be mountable)
  */
-struct super_block *
-get_sb_pseudo(struct file_system_type *fs_type, char *name,
-	struct super_operations *ops, unsigned long magic)
+int get_sb_pseudo(struct file_system_type *fs_type, char *name,
+	struct super_operations *ops, unsigned long magic,
+	struct vfsmount *mnt)
 {
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
 	static struct super_operations default_ops = {.statfs = simple_statfs};
@@ -207,7 +207,7 @@ get_sb_pseudo(struct file_system_type *f
 	struct qstr d_name = {.name = name, .len = strlen(name)};
 
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 
 	s->s_flags = MS_NOUSER;
 	s->s_maxbytes = ~0ULL;
@@ -232,12 +232,12 @@ get_sb_pseudo(struct file_system_type *f
 	d_instantiate(dentry, root);
 	s->s_root = dentry;
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
 
 Enomem:
 	up_write(&s->s_umount);
 	deactivate_super(s);
-	return ERR_PTR(-ENOMEM);
+	return -ENOMEM;
 }
 
 int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 2dcccf1..14f24df 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -559,10 +559,11 @@ void minix_truncate(struct inode * inode
 		V2_minix_truncate(inode);
 }
 
-static struct super_block *minix_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int minix_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, minix_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, minix_fill_super,
+			   mnt);
 }
 
 static struct file_system_type minix_fs_type = {
diff --git a/fs/msdos/namei.c b/fs/msdos/namei.c
index 5b76ccd..9e44158 100644
--- a/fs/msdos/namei.c
+++ b/fs/msdos/namei.c
@@ -661,11 +661,12 @@ static int msdos_fill_super(struct super
 	return 0;
 }
 
-static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
-					int flags, const char *dev_name,
-					void *data)
+static int msdos_get_sb(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super,
+			   mnt);
 }
 
 static struct file_system_type msdos_fs_type = {
diff --git a/fs/namespace.c b/fs/namespace.c
index b21c5c2..84a3bec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -86,6 +86,15 @@ struct vfsmount *alloc_vfsmnt(const char
 	return mnt;
 }
 
+int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb)
+{
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = dget(sb->s_root);
+	return 0;
+}
+
+EXPORT_SYMBOL(simple_set_mnt);
+
 void free_vfsmnt(struct vfsmount *mnt)
 {
 	kfree(mnt->mnt_devname);
diff --git a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
index a1f3e97..8db033f 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -957,10 +957,10 @@ out:
 	return result;
 }
 
-static struct super_block *ncp_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ncp_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, ncp_fill_super);
+	return get_sb_nodev(fs_type, flags, data, ncp_fill_super, mnt);
 }
 
 static struct file_system_type ncp_fs_type = {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index c0fa6e8..c321f71 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1743,14 +1743,15 @@ struct nfs_clone_mount {
 	rpc_authflavor_t authflavor;
 };
 
-static struct super_block *nfs_clone_generic_sb(struct nfs_clone_mount *data,
-		struct super_block *(*fill_sb)(struct nfs_server *, struct nfs_clone_mount *),
-		struct nfs_server *(*fill_server)(struct super_block *, struct nfs_clone_mount *))
+static int nfs_clone_generic_sb(struct nfs_clone_mount *data,
+	struct super_block *(*fill_sb)(struct nfs_server *, struct nfs_clone_mount *),
+	struct nfs_server *(*fill_server)(struct super_block *, struct nfs_clone_mount *),
+	struct vfsmount *mnt)
 {
 	struct nfs_server *server;
 	struct nfs_server *parent = NFS_SB(data->sb);
 	struct super_block *sb = ERR_PTR(-EINVAL);
-	void *err = ERR_PTR(-ENOMEM);
+	int err = -ENOMEM;
 	char *hostname;
 	int len;
 
@@ -1768,17 +1769,28 @@ static struct super_block *nfs_clone_gen
 		goto free_hostname;
 
 	sb = fill_sb(server, data);
-	if (IS_ERR((err = sb)) || sb->s_root)
+	if (IS_ERR(sb) < 0) {
+		err = PTR_ERR(sb);
 		goto kill_rpciod;
+	}
 
-	server = fill_server(sb, data);
-	if (IS_ERR((err = server)))
+	if (sb->s_root) {
+		rpciod_down();
+		kfree(server->hostname);
+		kfree(server);
+		return simple_set_mnt(mnt, sb);
+	}
+
+	server = fill_server(mnt->mnt_sb, data);
+	if (IS_ERR(server)) {
+		err = PTR_ERR(server);
 		goto out_deactivate;
-	return sb;
+	}
+	return simple_set_mnt(mnt, sb);
 out_deactivate:
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-	return (struct super_block *)err;
+	return err;
 kill_rpciod:
 	rpciod_down();
 free_hostname:
@@ -1786,7 +1798,7 @@ free_hostname:
 free_server:
 	kfree(server);
 out_err:
-	return (struct super_block *)err;
+	return err;
 }
 
 static int nfs_set_super(struct super_block *s, void *data)
@@ -1807,8 +1819,8 @@ static int nfs_compare_super(struct supe
 	return !nfs_compare_fh(&old->fh, &server->fh);
 }
 
-static struct super_block *nfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
+static int nfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *raw_data, struct vfsmount *mnt)
 {
 	int error;
 	struct nfs_server *server = NULL;
@@ -1816,14 +1828,14 @@ static struct super_block *nfs_get_sb(st
 	struct nfs_fh *root;
 	struct nfs_mount_data *data = raw_data;
 
-	s = ERR_PTR(-EINVAL);
+	error = -EINVAL;
 	if (data == NULL) {
 		dprintk("%s: missing data argument\n", __FUNCTION__);
-		goto out_err;
+		goto out_err_noserver;
 	}
 	if (data->version <= 0 || data->version > NFS_MOUNT_VERSION) {
 		dprintk("%s: bad mount version\n", __FUNCTION__);
-		goto out_err;
+		goto out_err_noserver;
 	}
 	switch (data->version) {
 		case 1:
@@ -1835,7 +1847,7 @@ static struct super_block *nfs_get_sb(st
 				dprintk("%s: mount structure version %d does not support NFSv3\n",
 						__FUNCTION__,
 						data->version);
-				goto out_err;
+				goto out_err_noserver;
 			}
 			data->root.size = NFS2_FHSIZE;
 			memcpy(data->root.data, data->old_root.data, NFS2_FHSIZE);
@@ -1844,24 +1856,24 @@ static struct super_block *nfs_get_sb(st
 				dprintk("%s: mount structure version %d does not support strong security\n",
 						__FUNCTION__,
 						data->version);
-				goto out_err;
+				goto out_err_noserver;
 			}
 		case 5:
 			memset(data->context, 0, sizeof(data->context));
 	}
 #ifndef CONFIG_NFS_V3
 	/* If NFSv3 is not compiled in, return -EPROTONOSUPPORT */
-	s = ERR_PTR(-EPROTONOSUPPORT);
+	error = -EPROTONOSUPPORT;
 	if (data->flags & NFS_MOUNT_VER3) {
 		dprintk("%s: NFSv3 not compiled into kernel\n", __FUNCTION__);
-		goto out_err;
+		goto out_err_noserver;
 	}
 #endif /* CONFIG_NFS_V3 */
 
-	s = ERR_PTR(-ENOMEM);
+	error = -ENOMEM;
 	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
-		goto out_err;
+		goto out_err_noserver;
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
@@ -1871,7 +1883,7 @@ #endif /* CONFIG_NFS_V3 */
 		root->size = data->root.size;
 	else
 		root->size = NFS2_FHSIZE;
-	s = ERR_PTR(-EINVAL);
+	error = -EINVAL;
 	if (root->size > sizeof(root->data)) {
 		dprintk("%s: invalid root filehandle\n", __FUNCTION__);
 		goto out_err;
@@ -1887,15 +1899,20 @@ #endif /* CONFIG_NFS_V3 */
 	}
 
 	/* Fire up rpciod if not yet running */
-	s = ERR_PTR(rpciod_up());
-	if (IS_ERR(s)) {
-		dprintk("%s: couldn't start rpciod! Error = %ld\n",
-				__FUNCTION__, PTR_ERR(s));
+	error = rpciod_up();
+	if (error < 0) {
+		dprintk("%s: couldn't start rpciod! Error = %d\n",
+				__FUNCTION__, error);
 		goto out_err;
 	}
 
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
-	if (IS_ERR(s) || s->s_root)
+	if (IS_ERR(s)) {
+		error = PTR_ERR(s);
+		goto out_err_rpciod;
+	}
+
+	if (s->s_root)
 		goto out_rpciod_down;
 
 	s->s_flags = flags;
@@ -1904,15 +1921,22 @@ #endif /* CONFIG_NFS_V3 */
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
-		return ERR_PTR(error);
+		return error;
 	}
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
+
 out_rpciod_down:
 	rpciod_down();
+	kfree(server);
+	return simple_set_mnt(mnt, s);
+
+out_err_rpciod:
+	rpciod_down();
 out_err:
 	kfree(server);
-	return s;
+out_err_noserver:
+	return error;
 }
 
 static void nfs_kill_super(struct super_block *s)
@@ -2009,11 +2033,11 @@ out:
 	return err;
 }
 
-static struct super_block *nfs_clone_nfs_sb(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+static int nfs_clone_nfs_sb(struct file_system_type *fs_type,
+		int flags, const char *dev_name, void *raw_data, struct vfsmount *mnt)
 {
 	struct nfs_clone_mount *data = raw_data;
-	return nfs_clone_generic_sb(data, nfs_clone_sb, nfs_clone_server);
+	return nfs_clone_generic_sb(data, nfs_clone_sb, nfs_clone_server, mnt);
 }
 
 static struct file_system_type clone_nfs_fs_type = {
@@ -2244,8 +2268,8 @@ nfs_copy_user_string(char *dst, struct n
 	return dst;
 }
 
-static struct super_block *nfs4_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
+static int nfs4_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *raw_data, struct vfsmount *mnt)
 {
 	int error;
 	struct nfs_server *server;
@@ -2255,16 +2279,16 @@ static struct super_block *nfs4_get_sb(s
 
 	if (data == NULL) {
 		dprintk("%s: missing data argument\n", __FUNCTION__);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 	if (data->version <= 0 || data->version > NFS4_MOUNT_VERSION) {
 		dprintk("%s: bad mount version\n", __FUNCTION__);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
@@ -2286,33 +2310,41 @@ static struct super_block *nfs4_get_sb(s
 
 	/* We now require that the mount process passes the remote address */
 	if (data->host_addrlen != sizeof(server->addr)) {
-		s = ERR_PTR(-EINVAL);
+		error = -EINVAL;
 		goto out_free;
 	}
 	if (copy_from_user(&server->addr, data->host_addr, sizeof(server->addr))) {
-		s = ERR_PTR(-EFAULT);
+		error = -EFAULT;
 		goto out_free;
 	}
 	if (server->addr.sin_family != AF_INET ||
 	    server->addr.sin_addr.s_addr == INADDR_ANY) {
 		dprintk("%s: mount program didn't pass remote IP address!\n",
 				__FUNCTION__);
-		s = ERR_PTR(-EINVAL);
+		error = -EINVAL;
 		goto out_free;
 	}
 
 	/* Fire up rpciod if not yet running */
-	s = ERR_PTR(rpciod_up());
-	if (IS_ERR(s)) {
-		dprintk("%s: couldn't start rpciod! Error = %ld\n",
-				__FUNCTION__, PTR_ERR(s));
+	error = rpciod_up();
+	if (error < 0) {
+		dprintk("%s: couldn't start rpciod! Error = %d\n",
+				__FUNCTION__, error);
 		goto out_free;
 	}
 
 	s = sget(fs_type, nfs4_compare_super, nfs_set_super, server);
-
-	if (IS_ERR(s) || s->s_root)
+	if (IS_ERR(s)) {
+		error = PTR_ERR(s);
 		goto out_free;
+	}
+
+	if (s->s_root) {
+		kfree(server->mnt_path);
+		kfree(server->hostname);
+		kfree(server);
+		return simple_set_mnt(mnt, s);
+	}
 
 	s->s_flags = flags;
 
@@ -2320,17 +2352,17 @@ static struct super_block *nfs4_get_sb(s
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
-		return ERR_PTR(error);
+		return error;
 	}
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
 out_err:
-	s = (struct super_block *)p;
+	error = PTR_ERR(p);
 out_free:
 	kfree(server->mnt_path);
 	kfree(server->hostname);
 	kfree(server);
-	return s;
+	return error;
 }
 
 static void nfs4_kill_super(struct super_block *sb)
@@ -2448,11 +2480,11 @@ err:
 	return sb;
 }
 
-static struct super_block *nfs_clone_nfs4_sb(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+static int nfs_clone_nfs4_sb(struct file_system_type *fs_type,
+		int flags, const char *dev_name, void *raw_data, struct vfsmount *mnt)
 {
 	struct nfs_clone_mount *data = raw_data;
-	return nfs_clone_generic_sb(data, nfs4_clone_sb, nfs_clone_server);
+	return nfs_clone_generic_sb(data, nfs4_clone_sb, nfs_clone_server, mnt);
 }
 
 static struct file_system_type clone_nfs4_fs_type = {
@@ -2652,11 +2684,11 @@ out_err:
 	return (struct nfs_server *)err;
 }
 
-static struct super_block *nfs_referral_nfs4_sb(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+static int nfs_referral_nfs4_sb(struct file_system_type *fs_type,
+		int flags, const char *dev_name, void *raw_data, struct vfsmount *mnt)
 {
 	struct nfs_clone_mount *data = raw_data;
-	return nfs_clone_generic_sb(data, nfs4_referral_sb, nfs4_referral_server);
+	return nfs_clone_generic_sb(data, nfs4_referral_sb, nfs4_referral_server, mnt);
 }
 
 static struct file_system_type nfs_referral_nfs4_fs_type = {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3ef017b..a1810e6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -494,10 +494,10 @@ #endif
 	return simple_fill_super(sb, 0x6e667364, nfsd_files);
 }
 
-static struct super_block *nfsd_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int nfsd_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, nfsd_fill_super);
+	return get_sb_single(fs_type, flags, data, nfsd_fill_super, mnt);
 }
 
 static struct file_system_type nfsd_fs_type = {
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 27833f6..d5d5e96 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3093,10 +3093,11 @@ struct kmem_cache *ntfs_index_ctx_cache;
 /* Driver wide mutex. */
 DEFINE_MUTEX(ntfs_lock);
 
-static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ntfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ntfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type ntfs_fs_type = {
diff --git a/fs/ocfs2/dlm/dlmfs.c b/fs/ocfs2/dlm/dlmfs.c
index 7e88e24..7273d9f 100644
--- a/fs/ocfs2/dlm/dlmfs.c
+++ b/fs/ocfs2/dlm/dlmfs.c
@@ -574,10 +574,10 @@ static struct inode_operations dlmfs_fil
 	.getattr	= simple_getattr,
 };
 
-static struct super_block *dlmfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int dlmfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, dlmfs_fill_super);
+	return get_sb_nodev(fs_type, flags, data, dlmfs_fill_super, mnt);
 }
 
 static struct file_system_type dlmfs_fs_type = {
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 949b3da..788b8b5 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -672,12 +672,14 @@ read_super_error:
 	return status;
 }
 
-static struct super_block *ocfs2_get_sb(struct file_system_type *fs_type,
-					int flags,
-					const char *dev_name,
-					void *data)
+static int ocfs2_get_sb(struct file_system_type *fs_type,
+			int flags,
+			const char *dev_name,
+			void *data,
+			struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ocfs2_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ocfs2_fill_super,
+			   mnt);
 }
 
 static struct file_system_type ocfs2_fs_type = {
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 0f14276..464e2bc 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -1054,10 +1054,10 @@ out_no_root:
 	return -ENOMEM;
 }
 
-static struct super_block *openprom_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int openprom_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, openprom_fill_super);
+	return get_sb_single(fs_type, flags, data, openprom_fill_super, mnt);
 }
 
 static struct file_system_type openprom_fs_type = {
diff --git a/fs/pipe.c b/fs/pipe.c
index 5acd895..2035257 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -979,12 +979,11 @@ no_files:
  * any operations on the root directory. However, we need a non-trivial
  * d_name - pipe: will go nicely and kill the special-casing in procfs.
  */
-
-static struct super_block *
-pipefs_get_sb(struct file_system_type *fs_type, int flags,
-	      const char *dev_name, void *data)
+static int pipefs_get_sb(struct file_system_type *fs_type,
+			 int flags, const char *dev_name, void *data,
+			 struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC);
+	return get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC, mnt);
 }
 
 static struct file_system_type pipe_fs_type = {
diff --git a/fs/proc/root.c b/fs/proc/root.c
index c3fd361..9995356 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -26,10 +26,10 @@ #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
 #endif
 
-static struct super_block *proc_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int proc_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, proc_fill_super);
+	return get_sb_single(fs_type, flags, data, proc_fill_super, mnt);
 }
 
 static struct file_system_type proc_fs_type = {
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 2ecd46f..e6cca5c 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -561,10 +561,11 @@ static void destroy_inodecache(void)
 		       "qnx4_inode_cache: not all structures were freed\n");
 }
 
-static struct super_block *qnx4_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int qnx4_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, qnx4_fill_super,
+			   mnt);
 }
 
 static struct file_system_type qnx4_fs_type = {
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 14bd224..b967733 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -185,16 +185,17 @@ static int ramfs_fill_super(struct super
 	return 0;
 }
 
-struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+int ramfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
+	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super, mnt);
 }
 
-static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int rootfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
+	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super,
+			    mnt);
 }
 
 static struct file_system_type ramfs_fs_type = {
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index cae2abb..f3ff41d 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2249,11 +2249,12 @@ static ssize_t reiserfs_quota_write(stru
 
 #endif
 
-static struct super_block *get_super_block(struct file_system_type *fs_type,
-					   int flags, const char *dev_name,
-					   void *data)
+static int get_super_block(struct file_system_type *fs_type,
+			   int flags, const char *dev_name,
+			   void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super,
+			   mnt);
 }
 
 static int __init init_reiserfs_fs(void)
diff --git a/fs/romfs/inode.c b/fs/romfs/inode.c
index 9b9eda7..4d6cd66 100644
--- a/fs/romfs/inode.c
+++ b/fs/romfs/inode.c
@@ -607,10 +607,11 @@ static struct super_operations romfs_ops
 	.remount_fs	= romfs_remount,
 };
 
-static struct super_block *romfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int romfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, romfs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, romfs_fill_super,
+			   mnt);
 }
 
 static struct file_system_type romfs_fs_type = {
diff --git a/fs/smbfs/inode.c b/fs/smbfs/inode.c
index fdeabc0..4a37c2b 100644
--- a/fs/smbfs/inode.c
+++ b/fs/smbfs/inode.c
@@ -782,10 +782,10 @@ out:
 	return error;
 }
 
-static struct super_block *smb_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int smb_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, smb_fill_super);
+	return get_sb_nodev(fs_type, flags, data, smb_fill_super, mnt);
 }
 
 static struct file_system_type smb_fs_type = {
diff --git a/fs/super.c b/fs/super.c
index 15f2afd..3daf41e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -231,7 +231,7 @@ void generic_shutdown_super(struct super
 	if (root) {
 		sb->s_root = NULL;
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
@@ -676,9 +676,10 @@ static void bdev_uevent(struct block_dev
 	}
 }
 
-struct super_block *get_sb_bdev(struct file_system_type *fs_type,
+int get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	struct block_device *bdev;
 	struct super_block *s;
@@ -686,7 +687,7 @@ struct super_block *get_sb_bdev(struct f
 
 	bdev = open_bdev_excl(dev_name, flags, fs_type);
 	if (IS_ERR(bdev))
-		return (struct super_block *)bdev;
+		return PTR_ERR(bdev);
 
 	/*
 	 * once the super is inserted into the list by sget, s_umount
@@ -697,15 +698,17 @@ struct super_block *get_sb_bdev(struct f
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
 	mutex_unlock(&bdev->bd_mount_mutex);
 	if (IS_ERR(s))
-		goto out;
+		goto error_s;
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & MS_RDONLY) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			s = ERR_PTR(-EBUSY);
+			error = -EBUSY;
+			goto error_bdev;
 		}
-		goto out;
+
+		close_bdev_excl(bdev);
 	} else {
 		char b[BDEVNAME_SIZE];
 
@@ -716,18 +719,21 @@ struct super_block *get_sb_bdev(struct f
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			s = ERR_PTR(error);
-		} else {
-			s->s_flags |= MS_ACTIVE;
-			bdev_uevent(bdev, KOBJ_MOUNT);
+			goto error;
 		}
+
+		s->s_flags |= MS_ACTIVE;
+		bdev_uevent(bdev, KOBJ_MOUNT);
 	}
 
-	return s;
+	return simple_set_mnt(mnt, s);
 
-out:
+error_s:
+	error = PTR_ERR(s);
+error_bdev:
 	close_bdev_excl(bdev);
-	return s;
+error:
+	return error;
 }
 
 EXPORT_SYMBOL(get_sb_bdev);
@@ -744,15 +750,16 @@ void kill_block_super(struct super_block
 
 EXPORT_SYMBOL(kill_block_super);
 
-struct super_block *get_sb_nodev(struct file_system_type *fs_type,
+int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	int error;
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
 
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 
 	s->s_flags = flags;
 
@@ -760,10 +767,10 @@ struct super_block *get_sb_nodev(struct 
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
-		return ERR_PTR(error);
+		return error;
 	}
 	s->s_flags |= MS_ACTIVE;
-	return s;
+	return simple_set_mnt(mnt, s);
 }
 
 EXPORT_SYMBOL(get_sb_nodev);
@@ -773,28 +780,29 @@ static int compare_single(struct super_b
 	return 1;
 }
 
-struct super_block *get_sb_single(struct file_system_type *fs_type,
+int get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt)
 {
 	struct super_block *s;
 	int error;
 
 	s = sget(fs_type, compare_single, set_anon_super, NULL);
 	if (IS_ERR(s))
-		return s;
+		return PTR_ERR(s);
 	if (!s->s_root) {
 		s->s_flags = flags;
 		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
-			return ERR_PTR(error);
+			return error;
 		}
 		s->s_flags |= MS_ACTIVE;
 	}
 	do_remount_sb(s, flags, data, 0);
-	return s;
+	return simple_set_mnt(mnt, s);
 }
 
 EXPORT_SYMBOL(get_sb_single);
@@ -802,52 +810,55 @@ EXPORT_SYMBOL(get_sb_single);
 struct vfsmount *
 vfs_kern_mount(struct file_system_type *type, int flags, const char *name, void *data)
 {
-	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
-	int error;
 	char *secdata = NULL;
+	int error;
 
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	error = -ENOMEM;
 	mnt = alloc_vfsmnt(name);
 	if (!mnt)
 		goto out;
 
 	if (data) {
 		secdata = alloc_secdata();
-		if (!secdata) {
-			sb = ERR_PTR(-ENOMEM);
+		if (!secdata)
 			goto out_mnt;
-		}
 
 		error = security_sb_copy_data(type, data, secdata);
-		if (error) {
-			sb = ERR_PTR(error);
+		if (error)
 			goto out_free_secdata;
-		}
 	}
 
-	sb = type->get_sb(type, flags, name, data);
-	if (IS_ERR(sb))
+	error = type->get_sb(type, flags, name, data, mnt);
+	if (error < 0)
 		goto out_free_secdata;
- 	error = security_sb_kern_mount(sb, secdata);
+
+	BUG_ON(!mnt->mnt_sb);
+	BUG_ON(!mnt->mnt_sb->s_root);
+	BUG_ON(!mnt->mnt_root);
+
+ 	error = security_sb_kern_mount(mnt->mnt_sb, secdata);
  	if (error)
  		goto out_sb;
-	mnt->mnt_sb = sb;
-	mnt->mnt_root = dget(sb->s_root);
-	mnt->mnt_mountpoint = sb->s_root;
+
+	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
-	up_write(&sb->s_umount);
+	up_write(&mnt->mnt_sb->s_umount);
 	free_secdata(secdata);
 	return mnt;
 out_sb:
-	up_write(&sb->s_umount);
-	deactivate_super(sb);
-	sb = ERR_PTR(error);
+	dput(mnt->mnt_root);
+	up_write(&mnt->mnt_sb->s_umount);
+	deactivate_super(mnt->mnt_sb);
 out_free_secdata:
 	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
-	return (struct vfsmount *)sb;
+	return ERR_PTR(error);
 }
 
 EXPORT_SYMBOL_GPL(vfs_kern_mount);
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index f1117e8..40190c4 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -66,10 +66,10 @@ static int sysfs_fill_super(struct super
 	return 0;
 }
 
-static struct super_block *sysfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int sysfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, sysfs_fill_super);
+	return get_sb_single(fs_type, flags, data, sysfs_fill_super, mnt);
 }
 
 static struct file_system_type sysfs_fs_type = {
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index e92b991..876639b 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -506,16 +506,17 @@ failed:
 
 /* Every kernel module contains stuff like this. */
 
-static struct super_block *sysv_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int sysv_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, sysv_fill_super,
+			   mnt);
 }
 
-static struct super_block *v7_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int v7_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, v7_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, v7_fill_super, mnt);
 }
 
 static struct file_system_type sysv_fs_type = {
diff --git a/fs/udf/super.c b/fs/udf/super.c
index e45789f..2250774 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -94,10 +94,10 @@ static unsigned int udf_count_free(struc
 static int udf_statfs(struct super_block *, struct kstatfs *);
 
 /* UDF filesystem type */
-static struct super_block *udf_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int udf_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, udf_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, udf_fill_super, mnt);
 }
 
 static struct file_system_type udf_fstype = {
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index db98a4c..768fb8d 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1311,10 +1311,10 @@ out:
 
 #endif
 
-static struct super_block *ufs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ufs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, ufs_fill_super, mnt);
 }
 
 static struct file_system_type ufs_fs_type = {
diff --git a/fs/vfat/namei.c b/fs/vfat/namei.c
index a56cec3..9a8f48b 100644
--- a/fs/vfat/namei.c
+++ b/fs/vfat/namei.c
@@ -1023,11 +1023,12 @@ static int vfat_fill_super(struct super_
 	return 0;
 }
 
-static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
-				       int flags, const char *dev_name,
-				       void *data)
+static int vfat_get_sb(struct file_system_type *fs_type,
+		       int flags, const char *dev_name,
+		       void *data, struct vfsmount *mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super,
+			   mnt);
 }
 
 static struct file_system_type vfat_fs_type = {
diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 68f4793..7702355 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -900,14 +900,16 @@ fail_vfsop:
 	return -error;
 }
 
-STATIC struct super_block *
+STATIC int
 xfs_fs_get_sb(
 	struct file_system_type	*fs_type,
 	int			flags,
 	const char		*dev_name,
-	void			*data)
+	void			*data,
+	struct vfsmount		*mnt)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, xfs_fs_fill_super);
+	return get_sb_bdev(fs_type, flags, dev_name, data, xfs_fs_fill_super,
+			   mnt);
 }
 
 STATIC struct super_operations xfs_super_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e40a02e..cde3028 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1270,23 +1270,26 @@ find_exported_dentry(struct super_block 
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-	struct super_block *(*get_sb) (struct file_system_type *, int,
-				       const char *, void *);
+	int (*get_sb) (struct file_system_type *, int,
+		       const char *, void *, struct vfsmount *);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
 	struct list_head fs_supers;
 };
 
-struct super_block *get_sb_bdev(struct file_system_type *fs_type,
+extern int get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
-struct super_block *get_sb_single(struct file_system_type *fs_type,
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
+extern int get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
-struct super_block *get_sb_nodev(struct file_system_type *fs_type,
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
+extern int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
+	int (*fill_super)(struct super_block *, void *, int),
+	struct vfsmount *mnt);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
@@ -1297,8 +1300,10 @@ struct super_block *sget(struct file_sys
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			void *data);
-struct super_block *get_sb_pseudo(struct file_system_type *, char *,
-			struct super_operations *ops, unsigned long);
+extern int get_sb_pseudo(struct file_system_type *, char *,
+	struct super_operations *ops, unsigned long,
+	struct vfsmount *mnt);
+extern int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb);
 int __put_super(struct super_block *sb);
 int __put_super_and_need_restart(struct super_block *sb);
 void unnamed_dev_init(void);
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index 78ecfa2..00b340b 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -2,8 +2,8 @@ #ifndef _LINUX_RAMFS_H
 #define _LINUX_RAMFS_H
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
-struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
-	 int flags, const char *dev_name, void *data);
+extern int ramfs_get_sb(struct file_system_type *fs_type,
+	 int flags, const char *dev_name, void *data, struct vfsmount *mnt);
 
 #ifndef CONFIG_MMU
 extern unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 41ecbd4..332b590 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -202,11 +202,11 @@ static int mqueue_fill_super(struct supe
 	return 0;
 }
 
-static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
-					 int flags, const char *dev_name,
-					 void *data)
+static int mqueue_get_sb(struct file_system_type *fs_type,
+			 int flags, const char *dev_name,
+			 void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, mqueue_fill_super);
+	return get_sb_single(fs_type, flags, data, mqueue_fill_super, mnt);
 }
 
 static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 72248d1..d1217aa 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -392,11 +392,11 @@ static int cpuset_fill_super(struct supe
 	return 0;
 }
 
-static struct super_block *cpuset_get_sb(struct file_system_type *fs_type,
-					int flags, const char *unused_dev_name,
-					void *data)
+static int cpuset_get_sb(struct file_system_type *fs_type,
+			 int flags, const char *unused_dev_name,
+			 void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, cpuset_fill_super);
+	return get_sb_single(fs_type, flags, data, cpuset_fill_super, mnt);
 }
 
 static struct file_system_type cpuset_fs_type = {
diff --git a/kernel/futex.c b/kernel/futex.c
index 5699c51..e1a380c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1056,11 +1056,11 @@ asmlinkage long sys_futex(u32 __user *ua
 			(unsigned long)uaddr2, val2, val3);
 }
 
-static struct super_block *
-futexfs_get_sb(struct file_system_type *fs_type,
-	       int flags, const char *dev_name, void *data)
+static int futexfs_get_sb(struct file_system_type *fs_type,
+			  int flags, const char *dev_name, void *data,
+			  struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA);
+	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA, mnt);
 }
 
 static struct file_system_type futex_fs_type = {
diff --git a/mm/shmem.c b/mm/shmem.c
index 8184342..ad19b6c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2231,10 +2231,10 @@ #endif
 };
 
 
-static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int shmem_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_nodev(fs_type, flags, data, shmem_fill_super);
+	return get_sb_nodev(fs_type, flags, data, shmem_fill_super, mnt);
 }
 
 static struct file_system_type tmpfs_fs_type = {
diff --git a/net/socket.c b/net/socket.c
index 02948b6..565f5e8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -335,10 +335,11 @@ static struct super_operations sockfs_op
 	.statfs =	simple_statfs,
 };
 
-static struct super_block *sockfs_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int sockfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_pseudo(fs_type, "socket:", &sockfs_ops, SOCKFS_MAGIC);
+	return get_sb_pseudo(fs_type, "socket:", &sockfs_ops, SOCKFS_MAGIC,
+			     mnt);
 }
 
 static struct vfsmount *sock_mnt __read_mostly;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index a5226df..dafe793 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -815,11 +815,11 @@ out:
 	return -ENOMEM;
 }
 
-static struct super_block *
+static int
 rpc_get_sb(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+		int flags, const char *dev_name, void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, rpc_fill_super);
+	return get_sb_single(fs_type, flags, data, rpc_fill_super, mnt);
 }
 
 static struct file_system_type rpc_pipe_fs_type = {
diff --git a/security/inode.c b/security/inode.c
index 8bf4062..98a0df5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -135,11 +135,11 @@ static int fill_super(struct super_block
 	return simple_fill_super(sb, SECURITYFS_MAGIC, files);
 }
 
-static struct super_block *get_sb(struct file_system_type *fs_type,
-				        int flags, const char *dev_name,
-					void *data)
+static int get_sb(struct file_system_type *fs_type,
+		  int flags, const char *dev_name,
+		  void *data, struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, fill_super);
+	return get_sb_single(fs_type, flags, data, fill_super, mnt);
 }
 
 static struct file_system_type fs_type = {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a4efc96..b3501f7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1279,10 +1279,11 @@ err:
 	goto out;
 }
 
-static struct super_block *sel_get_sb(struct file_system_type *fs_type,
-				      int flags, const char *dev_name, void *data)
+static int sel_get_sb(struct file_system_type *fs_type,
+		      int flags, const char *dev_name, void *data,
+		      struct vfsmount *mnt)
 {
-	return get_sb_single(fs_type, flags, data, sel_fill_super);
+	return get_sb_single(fs_type, flags, data, sel_fill_super, mnt);
 }
 
 static struct file_system_type sel_fs_type = {

