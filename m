Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSKTKyW>; Wed, 20 Nov 2002 05:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSKTKyV>; Wed, 20 Nov 2002 05:54:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:47095 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265249AbSKTKyN>;
	Wed, 20 Nov 2002 05:54:13 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 20 Nov 2002 12:01:14 +0100 (MET)
Message-Id: <UTC200211201101.gAKB1EF24845.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] foo_mknod prototype
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_t argument of sys_mknod is passed to vfs_mknod,
and is then cast to int when foo_mknod is called,
and is subsequently very often cast back to dev_t.
(For example, minix_mknod() calls minix_set_inode()
that takes a dev_t.)

The 2.5.48 patch below is a cleanup that avoids this back-and-forth
casting by giving foo_mknod a prototype with dev_t.
In most cases now the dev_t is transmitted untouched
until init_special_inode.

It also makes the two routines hugetlbfs_get_inode()
and shmem_get_inode() static.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	Sat Jul 20 21:39:32 2002
+++ b/Documentation/filesystems/Locking	Wed Nov 20 11:19:02 2002
@@ -35,7 +35,7 @@
 	int (*symlink) (struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct inode *,struct dentry *,int);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,int,int);
+	int (*mknod) (struct inode *,struct dentry *,int,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char *,int);
diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
--- a/Documentation/filesystems/vfs.txt	Sun Jun  9 07:27:24 2002
+++ b/Documentation/filesystems/vfs.txt	Wed Nov 20 11:19:02 2002
@@ -258,7 +258,7 @@
 	int (*symlink) (struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct inode *,struct dentry *,int);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,int,int);
+	int (*mknod) (struct inode *,struct dentry *,int,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char *,int);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Mon Nov 18 10:57:13 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Nov 20 11:19:02 2002
@@ -121,7 +121,7 @@
 static const char *slotdir_name = "slots";
 #endif
 
-static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, int dev)
+static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -153,7 +153,7 @@
 }
 
 /* SMP-safe */
-static int pcihpfs_mknod (struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int pcihpfs_mknod (struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode *inode = pcihpfs_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c	Mon Nov 18 10:57:17 2002
+++ b/drivers/usb/core/inode.c	Wed Nov 20 11:19:02 2002
@@ -143,7 +143,7 @@
 
 /* --------------------------------------------------------------------- */
 
-static struct inode *usbfs_get_inode (struct super_block *sb, int mode, int dev)
+static struct inode *usbfs_get_inode (struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -176,7 +176,7 @@
 
 /* SMP-safe */
 static int usbfs_mknod (struct inode *dir, struct dentry *dentry, int mode,
-			int dev)
+			dev_t dev)
 {
 	struct inode *inode = usbfs_get_inode(dir->i_sb, mode, dev);
 	int error = -EPERM;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/coda/dir.c b/fs/coda/dir.c
--- a/fs/coda/dir.c	Sat Oct 12 19:28:47 2002
+++ b/fs/coda/dir.c	Wed Nov 20 11:19:02 2002
@@ -29,7 +29,7 @@
 
 /* dir inode-ops */
 static int coda_create(struct inode *dir, struct dentry *new, int mode);
-static int coda_mknod(struct inode *dir, struct dentry *new, int mode, int rdev);
+static int coda_mknod(struct inode *dir, struct dentry *new, int mode, dev_t rdev);
 static struct dentry *coda_lookup(struct inode *dir, struct dentry *target);
 static int coda_link(struct dentry *old_dentry, struct inode *dir_inode, 
 		     struct dentry *entry);
@@ -230,7 +230,7 @@
         return 0;
 }
 
-static int coda_mknod(struct inode *dir, struct dentry *de, int mode, int rdev)
+static int coda_mknod(struct inode *dir, struct dentry *de, int mode, dev_t rdev)
 {
         int error=0;
 	const char *name=de->d_name.name;
@@ -740,4 +740,3 @@
 	unlock_kernel();
 	return -EIO;
 }
-
diff -u --recursive --new-file -X /linux/dontdiff a/fs/coda/upcall.c b/fs/coda/upcall.c
--- a/fs/coda/upcall.c	Sat Oct 12 19:28:47 2002
+++ b/fs/coda/upcall.c	Wed Nov 20 11:19:02 2002
@@ -310,8 +310,8 @@
 }
 
 int venus_create(struct super_block *sb, struct ViceFid *dirfid, 
-		    const char *name, int length, int excl, int mode, int rdev,
-		    struct ViceFid *newfid, struct coda_vattr *attrs) 
+		 const char *name, int length, int excl, int mode, dev_t rdev,
+		 struct ViceFid *newfid, struct coda_vattr *attrs) 
 {
         union inputArgs *inp;
         union outputArgs *outp;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Mon Nov 18 10:57:19 2002
+++ b/fs/devfs/base.c	Wed Nov 20 11:19:02 2002
@@ -3106,7 +3106,7 @@
 }   /*  End Function devfs_rmdir  */
 
 static int devfs_mknod (struct inode *dir, struct dentry *dentry, int mode,
-			int rdev)
+			dev_t rdev)
 {
     int err;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devices.c b/fs/devices.c
--- a/fs/devices.c	Sat Sep 21 11:39:51 2002
+++ b/fs/devices.c	Wed Nov 20 11:19:02 2002
@@ -202,7 +202,7 @@
 	.open		= sock_no_open
 };
 
-void init_special_inode(struct inode *inode, umode_t mode, int rdev)
+void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 {
 	inode->i_mode = mode;
 	if (S_ISCHR(mode)) {
@@ -217,5 +217,6 @@
 	else if (S_ISSOCK(mode))
 		inode->i_fop = &bad_sock_fops;
 	else
-		printk(KERN_DEBUG "init_special_inode: bogus imode (%o)\n", mode);
+		printk(KERN_DEBUG "init_special_inode: bogus imode (%o)\n",
+		       mode);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext2/namei.c b/fs/ext2/namei.c
--- a/fs/ext2/namei.c	Tue Nov  5 09:18:10 2002
+++ b/fs/ext2/namei.c	Wed Nov 20 11:19:02 2002
@@ -134,7 +134,7 @@
 	return err;
 }
 
-static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct inode * inode = ext2_new_inode (dir, mode);
 	int err = PTR_ERR(inode);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Thu Nov 14 17:10:27 2002
+++ b/fs/ext3/namei.c	Wed Nov 20 11:19:02 2002
@@ -1616,7 +1616,7 @@
 }
 
 static int ext3_mknod (struct inode * dir, struct dentry *dentry,
-			int mode, int rdev)
+			int mode, dev_t rdev)
 {
 	handle_t *handle;
 	struct inode *inode;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
--- a/fs/hpfs/hpfs_fn.h	Sat Oct 12 19:28:48 2002
+++ b/fs/hpfs/hpfs_fn.h	Wed Nov 20 11:19:02 2002
@@ -282,7 +282,7 @@
 
 int hpfs_mkdir(struct inode *, struct dentry *, int);
 int hpfs_create(struct inode *, struct dentry *, int);
-int hpfs_mknod(struct inode *, struct dentry *, int, int);
+int hpfs_mknod(struct inode *, struct dentry *, int, dev_t);
 int hpfs_symlink(struct inode *, struct dentry *, const char *);
 int hpfs_unlink(struct inode *, struct dentry *);
 int hpfs_rmdir(struct inode *, struct dentry *);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hpfs/namei.c b/fs/hpfs/namei.c
--- a/fs/hpfs/namei.c	Mon Nov 18 10:57:20 2002
+++ b/fs/hpfs/namei.c	Wed Nov 20 11:19:02 2002
@@ -181,7 +181,7 @@
 	return -ENOSPC;
 }
 
-int hpfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev)
+int hpfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	const char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Mon Nov 18 10:57:20 2002
+++ b/fs/hugetlbfs/inode.c	Wed Nov 20 11:19:02 2002
@@ -359,7 +359,8 @@
 	return error;
 }
 
-struct inode *hugetlbfs_get_inode(struct super_block *sb, int mode, int dev)
+static struct inode *
+hugetlbfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode * inode = new_inode(sb);
 
@@ -399,7 +400,8 @@
  * File creation. Allocate an inode, and we're done..
  */
 /* SMP-safe */
-static int hugetlbfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int
+hugetlbfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode * inode = hugetlbfs_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/intermezzo/dir.c b/fs/intermezzo/dir.c
--- a/fs/intermezzo/dir.c	Thu Oct 17 02:28:40 2002
+++ b/fs/intermezzo/dir.c	Wed Nov 20 11:19:02 2002
@@ -720,7 +720,7 @@
         return error;
 }
 
-static int presto_mknod(struct inode * dir, struct dentry * dentry, int mode, int rdev)
+static int presto_mknod(struct inode * dir, struct dentry * dentry, int mode, dev_t rdev)
 {
         int error;
         struct presto_cache *cache;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
--- a/fs/jffs/inode-v23.c	Mon Nov 18 10:57:20 2002
+++ b/fs/jffs/inode-v23.c	Wed Nov 20 11:19:02 2002
@@ -1072,7 +1072,7 @@
 
 
 static int
-jffs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev)
+jffs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct jffs_raw_inode raw_inode;
 	struct jffs_file *dir_f;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jffs2/dir.c b/fs/jffs2/dir.c
--- a/fs/jffs2/dir.c	Mon Nov 18 10:57:20 2002
+++ b/fs/jffs2/dir.c	Wed Nov 20 11:19:02 2002
@@ -32,7 +32,7 @@
 static int jffs2_symlink (struct inode *,struct dentry *,const char *);
 static int jffs2_mkdir (struct inode *,struct dentry *,int);
 static int jffs2_rmdir (struct inode *,struct dentry *);
-static int jffs2_mknod (struct inode *,struct dentry *,int,int);
+static int jffs2_mknod (struct inode *,struct dentry *,int,dev_t);
 static int jffs2_rename (struct inode *, struct dentry *,
                         struct inode *, struct dentry *);
 
@@ -567,7 +567,7 @@
 	return ret;
 }
 
-static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, int mode, int rdev)
+static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jfs/namei.c b/fs/jfs/namei.c
--- a/fs/jfs/namei.c	Tue Nov  5 09:18:10 2002
+++ b/fs/jfs/namei.c	Wed Nov 20 11:19:02 2002
@@ -1316,7 +1316,7 @@
  *
  * FUNCTION:    Create a special file (device)
  */
-int jfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev)
+int jfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct btstack btstack;
 	struct component_name dname;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/minix/namei.c b/fs/minix/namei.c
--- a/fs/minix/namei.c	Sat Oct  5 13:46:10 2002
+++ b/fs/minix/namei.c	Wed Nov 20 11:19:02 2002
@@ -75,7 +75,7 @@
 	return NULL;
 }
 
-static int minix_mknod(struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int minix_mknod(struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	int error;
 	struct inode * inode = minix_new_inode(dir, &error);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ncpfs/dir.c b/fs/ncpfs/dir.c
--- a/fs/ncpfs/dir.c	Sun Aug  4 14:16:58 2002
+++ b/fs/ncpfs/dir.c	Wed Nov 20 11:19:02 2002
@@ -42,7 +42,7 @@
 static int ncp_rename(struct inode *, struct dentry *,
 	  	      struct inode *, struct dentry *);
 static int ncp_mknod(struct inode * dir, struct dentry *dentry,
-		     int mode, int rdev);
+		     int mode, dev_t rdev);
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 extern int ncp_symlink(struct inode *, struct dentry *, const char *);
 #else
@@ -883,7 +883,7 @@
 }
 
 int ncp_create_new(struct inode *dir, struct dentry *dentry, int mode,
-		   int rdev, int attributes)
+		   dev_t rdev, int attributes)
 {
 	struct ncp_server *server = NCP_SERVER(dir);
 	struct ncp_entry_info finfo;
@@ -1169,7 +1169,7 @@
 }
 
 static int ncp_mknod(struct inode * dir, struct dentry *dentry,
-		     int mode, int rdev)
+		     int mode, dev_t rdev)
 {
 	if (ncp_is_nfs_extras(NCP_SERVER(dir), NCP_FINFO(dir)->volNumber)) {
 		DPRINTK(KERN_DEBUG "ncp_mknod: mode = 0%o\n", mode);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ncpfs/ncplib_kernel.h b/fs/ncpfs/ncplib_kernel.h
--- a/fs/ncpfs/ncplib_kernel.h	Sat Jul 27 19:03:25 2002
+++ b/fs/ncpfs/ncplib_kernel.h	Wed Nov 20 11:19:02 2002
@@ -117,7 +117,7 @@
 int ncp_dirhandle_free(struct ncp_server *, __u8 dirhandle);
 
 int ncp_create_new(struct inode *dir, struct dentry *dentry,
-                          int mode, int rdev, int attributes);
+                          int mode, dev_t rdev, int attributes);
 
 static inline int ncp_is_nfs_extras(struct ncp_server* server, unsigned int volnum) {
 #ifdef CONFIG_NCPFS_NFS_NS
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/dir.c b/fs/nfs/dir.c
--- a/fs/nfs/dir.c	Sat Oct 12 19:28:48 2002
+++ b/fs/nfs/dir.c	Wed Nov 20 11:19:02 2002
@@ -45,7 +45,7 @@
 static int nfs_unlink(struct inode *, struct dentry *);
 static int nfs_symlink(struct inode *, struct dentry *, const char *);
 static int nfs_link(struct dentry *, struct inode *, struct dentry *);
-static int nfs_mknod(struct inode *, struct dentry *, int, int);
+static int nfs_mknod(struct inode *, struct dentry *, int, dev_t);
 static int nfs_rename(struct inode *, struct dentry *,
 		      struct inode *, struct dentry *);
 
@@ -801,7 +801,8 @@
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
-static int nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev)
+static int
+nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct iattr attr;
 	struct nfs_fattr fattr;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ramfs/inode.c b/fs/ramfs/inode.c
--- a/fs/ramfs/inode.c	Thu Oct 31 14:14:49 2002
+++ b/fs/ramfs/inode.c	Wed Nov 20 11:19:02 2002
@@ -47,7 +47,7 @@
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
-struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev)
+static struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode * inode = new_inode(sb);
 
@@ -87,14 +87,15 @@
  * File creation. Allocate an inode, and we're done..
  */
 /* SMP-safe */
-static int ramfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int
+ramfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode * inode = ramfs_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
 
 	if (inode) {
 		d_instantiate(dentry, inode);
-		dget(dentry);		/* Extra count - pin the dentry in core */
+		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
 	}
 	return error;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Mon Nov 18 10:57:21 2002
+++ b/fs/reiserfs/namei.c	Wed Nov 20 11:19:02 2002
@@ -605,7 +605,7 @@
 }
 
 
-static int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
     int retval;
     struct inode * inode;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/smbfs/dir.c b/fs/smbfs/dir.c
--- a/fs/smbfs/dir.c	Mon Nov 18 10:57:21 2002
+++ b/fs/smbfs/dir.c	Wed Nov 20 11:19:02 2002
@@ -31,7 +31,7 @@
 static int smb_unlink(struct inode *, struct dentry *);
 static int smb_rename(struct inode *, struct dentry *,
 		      struct inode *, struct dentry *);
-static int smb_make_node(struct inode *,struct dentry *,int,int);
+static int smb_make_node(struct inode *,struct dentry *,int,dev_t);
 static int smb_link(struct dentry *, struct inode *, struct dentry *);
 
 struct file_operations smb_dir_operations =
@@ -641,7 +641,7 @@
  * matches the connection credentials (and we don't know which those are ...)
  */
 static int
-smb_make_node(struct inode *dir, struct dentry *dentry, int mode, int dev)
+smb_make_node(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	int error;
 	struct iattr attr;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Mon Nov 18 10:57:22 2002
+++ b/fs/sysfs/inode.c	Wed Nov 20 11:19:02 2002
@@ -87,7 +87,7 @@
 	return inode;
 }
 
-static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode *inode;
 	int error = 0;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/sysv/namei.c b/fs/sysv/namei.c
--- a/fs/sysv/namei.c	Sat Oct 12 19:28:51 2002
+++ b/fs/sysv/namei.c	Wed Nov 20 11:19:02 2002
@@ -83,7 +83,7 @@
 	return NULL;
 }
 
-static int sysv_mknod(struct inode * dir, struct dentry * dentry, int mode, int rdev)
+static int sysv_mknod(struct inode * dir, struct dentry * dentry, int mode, dev_t rdev)
 {
 	struct inode * inode = sysv_new_inode(dir, mode);
 	int err = PTR_ERR(inode);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/udf/namei.c b/fs/udf/namei.c
--- a/fs/udf/namei.c	Mon Nov 18 10:57:22 2002
+++ b/fs/udf/namei.c	Wed Nov 20 11:19:02 2002
@@ -669,7 +669,7 @@
 	return 0;
 }
 
-static int udf_mknod(struct inode * dir, struct dentry * dentry, int mode, int rdev)
+static int udf_mknod(struct inode * dir, struct dentry * dentry, int mode, dev_t rdev)
 {
 	struct inode * inode;
 	struct udf_fileident_bh fibh;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/ufs/namei.c b/fs/ufs/namei.c
--- a/fs/ufs/namei.c	Sat Oct  5 13:46:10 2002
+++ b/fs/ufs/namei.c	Wed Nov 20 11:19:02 2002
@@ -108,7 +108,7 @@
 	return err;
 }
 
-static int ufs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int ufs_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct inode * inode = ufs_new_inode(dir, mode);
 	int err = PTR_ERR(inode);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/umsdos/namei.c b/fs/umsdos/namei.c
--- a/fs/umsdos/namei.c	Mon Nov 18 10:57:22 2002
+++ b/fs/umsdos/namei.c	Wed Nov 20 11:19:02 2002
@@ -237,7 +237,7 @@
  * The same is true for directory creation.
  */
 static int umsdos_create_any (struct inode *dir, struct dentry *dentry,
-				int mode, int rdev, char flags)
+				int mode, dev_t rdev, char flags)
 {
 	struct dentry *fake;
 	struct inode *inode;
@@ -861,7 +861,7 @@
  * in particular and other parts of the kernel I guess.
  */
 int UMSDOS_mknod (struct inode *dir, struct dentry *dentry,
-		 int mode, int rdev)
+		 int mode, dev_t rdev)
 {
 	return umsdos_create_any (dir, dentry, mode, rdev, 0);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/xfs/linux/xfs_iops.c b/fs/xfs/linux/xfs_iops.c
--- a/fs/xfs/linux/xfs_iops.c	Mon Nov 18 10:57:22 2002
+++ b/fs/xfs/linux/xfs_iops.c	Wed Nov 20 11:19:02 2002
@@ -69,7 +69,7 @@
 	struct inode	*dir,
 	struct dentry	*dentry,
 	int		mode,
-	int		rdev)
+	dev_t		rdev)
 {
 	struct inode	*ip;
 	vattr_t		va;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
--- a/include/linux/coda_psdev.h	Sat Oct 12 19:28:52 2002
+++ b/include/linux/coda_psdev.h	Wed Nov 20 11:19:02 2002
@@ -47,13 +47,13 @@
 int venus_open(struct super_block *sb, struct ViceFid *fid,
 		int flags, struct file **f);
 int venus_mkdir(struct super_block *sb, struct ViceFid *dirfid, 
-			  const char *name, int length, 
-			  struct ViceFid *newfid, struct coda_vattr *attrs);
+		const char *name, int length, 
+		struct ViceFid *newfid, struct coda_vattr *attrs);
 int venus_create(struct super_block *sb, struct ViceFid *dirfid, 
-		    const char *name, int length, int excl, int mode, int rdev,
-		    struct ViceFid *newfid, struct coda_vattr *attrs) ;
+		 const char *name, int length, int excl, int mode, dev_t rdev,
+		 struct ViceFid *newfid, struct coda_vattr *attrs) ;
 int venus_rmdir(struct super_block *sb, struct ViceFid *dirfid, 
-		    const char *name, int length);
+		const char *name, int length);
 int venus_remove(struct super_block *sb, struct ViceFid *dirfid, 
 		 const char *name, int length);
 int venus_readlink(struct super_block *sb, struct ViceFid *fid, 
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Mon Nov 18 10:57:23 2002
+++ b/include/linux/fs.h	Wed Nov 20 11:19:02 2002
@@ -773,7 +773,7 @@
 	int (*symlink) (struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct inode *,struct dentry *,int);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,int,int);
+	int (*mknod) (struct inode *,struct dentry *,int,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char *,int);
@@ -1109,7 +1109,7 @@
 }
 extern const char * cdevname(kdev_t);
 extern const char * kdevname(kdev_t);
-extern void init_special_inode(struct inode *, umode_t, int);
+extern void init_special_inode(struct inode *, umode_t, dev_t);
 
 /* Invalid inode operations -- fs/bad_inode.c */
 extern void make_bad_inode(struct inode *);
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/umsdos_fs.p b/include/linux/umsdos_fs.p
--- a/include/linux/umsdos_fs.p	Sun Jun  9 07:28:45 2002
+++ b/include/linux/umsdos_fs.p	Wed Nov 20 11:19:02 2002
@@ -82,7 +82,7 @@
 int UMSDOS_mknod (struct inode *dir,
 		  struct dentry *dentry,
 		  int mode,
-		  int rdev);
+		  dev_t rdev);
 int UMSDOS_rmdir (struct inode *dir,struct dentry *dentry);
 int UMSDOS_unlink (struct inode *dir, struct dentry *dentry);
 int UMSDOS_rename (struct inode *old_dir,
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/umsdos_fs_i.h b/include/linux/umsdos_fs_i.h
--- a/include/linux/umsdos_fs_i.h	Sun Jun  9 07:30:56 2002
+++ b/include/linux/umsdos_fs_i.h	Wed Nov 20 11:19:02 2002
@@ -50,9 +50,9 @@
 struct umsdos_inode_info {
 	struct msdos_inode_info msdos_info;
 	struct dir_locking_info dir_info;
-	int i_patched;			/* Inode has been patched */
-	int i_is_hlink;			/* Resolved hardlink inode? */
-	off_t pos;			/* Entry offset in the emd_owner file */
+	int i_patched;		/* Inode has been patched */
+	int i_is_hlink;		/* Resolved hardlink inode? */
+	off_t pos;		/* Entry offset in the emd_owner file */
 };
 
 #endif
diff -u --recursive --new-file -X /linux/dontdiff a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Mon Nov 18 10:57:24 2002
+++ b/mm/shmem.c	Wed Nov 20 11:19:02 2002
@@ -1015,7 +1015,8 @@
 	return 0;
 }
 
-struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
+static struct inode *
+shmem_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -1426,7 +1427,8 @@
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int
+shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode *inode = shmem_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;



