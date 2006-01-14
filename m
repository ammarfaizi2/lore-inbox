Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWANVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWANVVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWANVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:21:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:28613 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750715AbWANVVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:21:52 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.15: Filesystem capabilities 0.16
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 14 Jan 2006 22:21:50 +0100
Message-ID: <8764om8pzl.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- updated to 2.6.15

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fscaps-2.6.15-0.16.patch
Content-Description: Filesystem capabilities

diff -urN a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Wed Jan  4 22:01:06 2006
+++ b/fs/Kconfig	Sun Jan  8 15:12:25 2006
@@ -1209,6 +1209,69 @@
 	  It's currently broken, so for now:
 	  answer N.
 
+config FS_CAPABILITIES
+	bool "Filesystem capabilities (Experimental)"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  This implementation is likely _not_ POSIX compatible.
+
+	  If you say Y here, you will be able to grant selective privileges to
+	  executables on a needed basis. This means for some executables, there
+	  is no need anymore to run as root or as a suid root binary.
+
+	  For example, you may drop the SUID bit from ping and grant the
+	  CAP_NET_RAW capability:
+	  # chmod u-s /bin/ping
+	  # chcap cap_net_raw=ep /bin/ping
+
+	  Another use would be to run system daemons with their own uid:
+	  # chcap cap_net_bind_service=ei /usr/sbin/named
+	  This sets the effective and inheritable capabilities of named.
+
+	  In your startup script:
+	  inhcaps cap_net_bind_service=i bind:bind /usr/sbin/named
+
+	  This sets the inheritable set to CAP_NET_BIND_SERVICE, which is
+	  needed in order to bind to port 53, and runs named as user bind
+	  with group bind.
+
+	  This allows running named with needed restricted privileges, if the
+	  parent process (root) owns them already. When started by regular
+	  users, named runs without any privileges.
+
+	  WARNING:
+	  resize2fs(8) might relocate inodes and thus break fs capabilities.
+	  For this to work you must dump the capability db before you resize
+	  and restore the db afterwards.
+
+	  For user space tools see:
+	  <http://home.t-online.de/home/olaf.dietsche/linux/capability/>
+
+	  For libcap and an alternative implementation, based on extended
+	  attributes, see:
+	  <http://www.kernel.org/pub/linux/libs/security/linux-privs/>
+
+	  If you're unsure, say N.
+
+config LIBC_ENABLE_SECURE_HACK
+	bool "Disable LD_PRELOAD on privileged executables"
+	depends on FS_CAPABILITIES
+	default y
+	help
+	  LD_PRELOAD is a glibc feature, which allows to override system
+	  library functions. But this means also a security hole, through
+	  which an attacker might gain unauthorized privileges. This is
+	  already prevented for SUID and SGID binaries.
+
+	  GNU libc doesn't know about filesystem capabilities yet and doesn't
+	  disable LD_PRELOAD for privileged executables, which are not SUID or
+	  SGID. This hack sets the group id to an invalid value and tricks GNU
+	  libc into thinking, this is a SGID binary (unless it is already SUID
+	  and/or SGID).
+	  However, this may break some programs.
+
+	  If you're unsure, say Y.
 
 
 config SYSV_FS
diff -urN a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Wed Jan  4 22:01:06 2006
+++ b/fs/Makefile	Sun Jan  8 15:12:25 2006
@@ -48,7 +48,8 @@
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
- 
+obj-$(CONFIG_FS_CAPABILITIES)	+= fscaps.o
+
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
diff -urN a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Wed Jan  4 22:01:06 2006
+++ b/fs/attr.c	Sun Jan  8 15:12:25 2006
@@ -15,6 +15,7 @@
 #include <linux/quotaops.h>
 #include <linux/security.h>
 #include <linux/time.h>
+#include <linux/fscaps.h>
 
 /* Taken over from the old code... */
 
@@ -171,8 +172,12 @@
 	if (ia_valid & ATTR_SIZE)
 		up_write(&dentry->d_inode->i_alloc_sem);
 
-	if (!error)
+	if (!error) {
+		if (ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
+			fscap_drop(inode);
+
 		fsnotify_change(dentry, ia_valid);
+	}
 
 	return error;
 }
diff -urN a/fs/fscaps.c b/fs/fscaps.c
--- a/fs/fscaps.c	Thu Jan  1 01:00:00 1970
+++ b/fs/fscaps.c	Sun Jan  8 15:12:25 2006
@@ -0,0 +1,321 @@
+/*
+ * Copyright (c) 2002 Olaf Dietsche
+ *
+ * Filesystem capabilities for linux.
+ */
+
+#include <linux/fscaps.h>
+#include <linux/module.h>
+#include <linux/binfmts.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/mount.h>
+#include <asm/uaccess.h>
+
+struct fscap_info {
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+	struct inode_operations rootdir_envelop;
+	struct inode_operations *rootdir_iops;
+	struct inode_operations cap_envelop;
+	struct inode_operations *cap_iops;
+};
+
+static char __capname[] = ".capabilities";
+
+static int __is_capname(const char *name)
+{
+	if (*name != __capname[0])
+		return 0;
+
+	return !strcmp(name, __capname);
+}
+
+static int __is_capentry(struct dentry *dentry)
+{
+	return dentry == dentry->d_sb->s_fscaps->dentry;
+}
+
+static int __cap_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct inode_operations *iops;
+	if ((mask & MAY_WRITE) && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = inode->i_sb->s_fscaps->cap_iops;
+	if (iops && iops->permission)
+		return iops->permission(inode, mask, nd);
+
+	return generic_permission(inode, mask, NULL);
+}
+
+static void __info_cap_release(struct fscap_info *info)
+{
+	if (info->dentry) {
+		struct inode *inode = info->dentry->d_inode;
+		if (inode)
+			inode->i_op = info->cap_iops;
+
+		dput(info->dentry);
+	}
+}
+
+static void __info_cap_init(struct fscap_info *info, struct dentry *dentry)
+{
+	struct inode *inode;
+	struct inode_operations *iops;
+	__info_cap_release(info);
+
+	info->dentry = dget(dentry);
+	if (!dentry)
+		return;
+
+	inode = dentry->d_inode;
+	if (!inode) {
+		printk(KERN_WARNING "%s: negative dentry. Disabling capabilities on %s.\n", __FUNCTION__, info->mnt->mnt_mountpoint->d_name.name);
+		dput(info->dentry);
+		info->dentry = NULL;
+		return;
+	}
+
+	info->cap_iops = iops = inode->i_op;
+	memset(&info->cap_envelop, 0, sizeof(info->cap_envelop));
+	if (iops)
+		info->cap_envelop = *iops;
+
+	info->cap_envelop.permission = __cap_permission;
+	inode->i_op = &info->cap_envelop;
+}
+
+static int __rootdir_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
+{
+	struct inode_operations *iops;
+	int err, iscapdb = __is_capname(dentry->d_name.name);
+	if (iscapdb && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = dir->i_sb->s_fscaps->rootdir_iops;
+	err = iops->create(dir, dentry, mode, nd);
+	if (!err && iscapdb)
+		__info_cap_init(dir->i_sb->s_fscaps, dentry);
+
+	return err;
+}
+
+static int __rootdir_link(struct dentry *old_dentry, struct inode *dir,
+			  struct dentry *new_dentry)
+{
+	struct inode_operations *iops;
+	int err, iscapdb = __is_capname(new_dentry->d_name.name);
+	if (iscapdb && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = dir->i_sb->s_fscaps->rootdir_iops;
+	err = iops->link(old_dentry, dir, new_dentry);
+	if (!err && iscapdb)
+		__info_cap_init(dir->i_sb->s_fscaps, new_dentry);
+
+	return err;
+}
+
+static int __rootdir_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode_operations *iops;
+	int err, iscapdb = __is_capentry(dentry);
+	if (iscapdb && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = dir->i_sb->s_fscaps->rootdir_iops;
+	err = iops->unlink(dir, dentry);
+	if (!err && iscapdb)
+		__info_cap_init(dir->i_sb->s_fscaps, NULL);
+
+	return err;
+}
+
+static int __rootdir_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
+{
+	struct inode_operations *iops;
+	if (__is_capname(dentry->d_name.name))
+		return -EPERM;
+
+	iops = dir->i_sb->s_fscaps->rootdir_iops;
+	return iops->symlink(dir, dentry, oldname);
+}
+
+static int __rootdir_rename(struct inode *old_dir, struct dentry *old_dentry,
+			    struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode_operations *iops;
+	if (__is_capentry(old_dentry) || __is_capname(new_dentry->d_name.name))
+		return -EPERM;
+
+	iops = old_dir->i_sb->s_fscaps->rootdir_iops;
+	return iops->rename(old_dir, old_dentry, new_dir, new_dentry);
+}
+
+static void __info_rootdir_release(struct fscap_info *info)
+{
+	struct inode *inode = info->mnt->mnt_sb->s_root->d_inode;
+	if (inode) {
+		inode->i_op = info->rootdir_iops;
+	}
+}
+
+static void __info_rootdir_init(struct fscap_info *info, struct inode *dir)
+{
+	struct inode_operations *iops = dir->i_op;
+	info->rootdir_iops = iops;
+	if (iops) {
+		info->rootdir_envelop = *iops;
+		info->rootdir_envelop.create = iops->create ? __rootdir_create : 0;
+		info->rootdir_envelop.link = iops->link ? __rootdir_link : 0;
+		info->rootdir_envelop.unlink = iops->unlink ? __rootdir_unlink : 0;
+		info->rootdir_envelop.symlink = iops->symlink ? __rootdir_symlink : 0;
+		info->rootdir_envelop.rename = iops->rename ? __rootdir_rename : 0;
+		dir->i_op = &info->rootdir_envelop;
+	}
+}
+
+static void __info_init(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct fscap_info *info = kmalloc(sizeof(struct fscap_info), GFP_KERNEL);
+	if (info) {
+		info->mnt = mnt;
+		info->dentry = NULL;
+		__info_rootdir_init(info, mnt->mnt_sb->s_root->d_inode);
+		__info_cap_init(info, dentry);
+	}
+
+	mnt->mnt_sb->s_fscaps = info;
+}
+
+static void __info_release(struct fscap_info *info)
+{
+	if (info) {
+		__info_cap_release(info);
+		__info_rootdir_release(info);
+		kfree(info);
+	}
+}
+
+static inline struct fscap_info *__info_lookup(struct super_block *sb) 
+{
+	return sb->s_fscaps;
+}
+
+static int __fscap_lookup(struct vfsmount *mnt, struct nameidata *nd)
+{
+	nd->mnt = mntget(mnt);
+	nd->dentry = dget(mnt->mnt_sb->s_root);
+	nd->flags = 0;
+	return path_walk(__capname, nd);
+}
+
+static struct file *__fscap_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+{
+	if (mnt->mnt_flags & MNT_NOSUID)
+		return ERR_PTR(-EPERM);
+
+	dentry = dget(dentry);
+	mnt = mntget(mnt);
+	return dentry_open(dentry, mnt, flags);
+}
+
+static void __fscap_read(struct file *filp, struct linux_binprm *bprm)
+{
+	__u32 fscaps[3][4];
+	unsigned long ino = bprm->file->f_dentry->d_inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps)) {
+		/* small sanity check */
+		if (fscaps[0][1] || fscaps[0][2] || fscaps[0][3]
+		    || fscaps[1][1] || fscaps[1][2] || fscaps[1][3]
+		    || fscaps[2][1] || fscaps[2][2] || fscaps[2][3])
+			return;
+
+		bprm->cap_effective = fscaps[0][0];
+		bprm->cap_inheritable = fscaps[1][0];
+		bprm->cap_permitted = fscaps[2][0];
+	}
+}
+
+static int kernel_write(struct file *file, unsigned long offset,
+		 char *addr, unsigned long count)
+{
+	mm_segment_t old_fs;
+	loff_t pos = offset;
+	int result;
+
+	old_fs = get_fs();
+	set_fs(get_ds());
+	result = vfs_write(file, addr, count, &pos);
+	set_fs(old_fs);
+	return result;
+}
+
+static void __fscap_drop(struct file *filp, struct inode *inode)
+{
+	__u32 fscaps[3][4];
+	unsigned long ino = inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps) && (fscaps[0][0] || fscaps[1][0] || fscaps[2][0])) {
+		memset(fscaps, 0, sizeof(fscaps));
+		kernel_write(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	}
+}
+
+void fscap_mount(struct vfsmount *mnt)
+{
+	struct nameidata nd;
+	if (__info_lookup(mnt->mnt_sb))
+		return;
+
+	if (__fscap_lookup(mnt, &nd)) {
+		__info_init(mnt, NULL);
+	} else {
+		__info_init(mnt, nd.dentry);
+		path_release(&nd);
+	}
+}
+
+void fscap_umount(struct super_block *sb)
+{
+	struct fscap_info *info = __info_lookup(sb);
+	__info_release(info);
+	sb->s_fscaps = NULL;
+}
+
+void fscap_read(struct linux_binprm *bprm)
+{
+	struct file *filp;
+	struct fscap_info *info = __info_lookup(bprm->file->f_vfsmnt->mnt_sb);
+	if (!info || !info->dentry)
+		return;
+
+	filp = __fscap_open(info->dentry, info->mnt, O_RDONLY);
+	if (filp && !IS_ERR(filp)) {
+		__fscap_read(filp, bprm);
+		filp_close(filp, 0);
+	}
+}
+
+void fscap_drop(struct inode *inode)
+{
+	struct file *filp;
+	struct fscap_info *info = __info_lookup(inode->i_sb);
+	if (!info || !info->dentry)
+		return;
+
+	filp = __fscap_open(info->dentry, info->mnt, O_RDWR);
+	if (filp && !IS_ERR(filp)) {
+		__fscap_drop(filp, inode);
+		filp_close(filp, 0);
+	}
+}
+
+EXPORT_SYMBOL(fscap_mount);
+EXPORT_SYMBOL(fscap_umount);
+EXPORT_SYMBOL(fscap_read);
+EXPORT_SYMBOL(fscap_drop);
diff -urN a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Wed Jan  4 22:01:10 2006
+++ b/fs/namespace.c	Fri Jan 13 20:36:16 2006
@@ -22,6 +22,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/fscaps.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include "pnode.h"
@@ -1066,6 +1067,8 @@
 	newmnt->mnt_flags = mnt_flags;
 	if ((err = graft_tree(newmnt, nd)))
 		goto unlock;
+
+	fscap_mount(newmnt);
 
 	if (fslist) {
 		/* add to the specified expiration list */
diff -urN a/fs/open.c b/fs/open.c
--- a/fs/open.c	Wed Jan  4 22:01:11 2006
+++ b/fs/open.c	Sun Jan  8 15:12:25 2006
@@ -19,6 +19,7 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/fscaps.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
@@ -787,6 +788,9 @@
 			f = ERR_PTR(-EINVAL);
 		}
 	}
+
+	if (flags & O_CREAT)
+		fscap_drop(inode);
 
 	return f;
 
diff -urN a/fs/super.c b/fs/super.c
--- a/fs/super.c	Wed Jan  4 22:01:12 2006
+++ b/fs/super.c	Fri Jan 13 22:48:12 2006
@@ -37,6 +37,7 @@
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
 #include <linux/kobject.h>
+#include <linux/fscaps.h>
 #include <asm/uaccess.h>
 
 
@@ -86,6 +87,7 @@
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
+ 		s->s_fscaps = NULL;
 	}
 out:
 	return s;
@@ -172,6 +174,7 @@
 		s->s_count -= S_BIAS-1;
 		spin_unlock(&sb_lock);
 		DQUOT_OFF(s);
+		fscap_umount(s);
 		down_write(&s->s_umount);
 		fs->kill_sb(s);
 		put_filesystem(fs);
diff -urN a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h	Wed Jan  4 13:23:47 2006
+++ b/include/linux/capability.h	Sun Jan  8 15:13:54 2006
@@ -287,6 +287,10 @@
 
 #define CAP_AUDIT_CONTROL    30
 
+/* Allow setting capabilities on files */
+
+#define CAP_SETFCAP          31
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff -urN a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Jan  4 22:01:44 2006
+++ b/include/linux/fs.h	Sun Jan  8 15:12:25 2006
@@ -807,6 +807,7 @@
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct fscap_info	*s_fscaps;	/* Filesystem capability stuff */
 
 	int			s_frozen;
 	wait_queue_head_t	s_wait_unfrozen;
diff -urN a/include/linux/fscaps.h b/include/linux/fscaps.h
--- a/include/linux/fscaps.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/fscaps.h	Sun Jan  8 15:12:25 2006
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2002 Olaf Dietsche
+ *
+ * Filesystem capabilities for linux.
+ */
+
+#ifndef _LINUX_FS_CAPS_H
+#define _LINUX_FS_CAPS_H
+
+#include <linux/config.h>
+
+struct vfsmount;
+struct super_block;
+struct linux_binprm;
+struct inode;
+
+#if defined(CONFIG_FS_CAPABILITIES) || defined(CONFIG_FS_CAPABILITIES_MODULE)
+extern void fscap_mount(struct vfsmount *mnt);
+extern void fscap_umount(struct super_block *sb);
+extern void fscap_read(struct linux_binprm *bprm);
+extern void fscap_drop(struct inode *inode);
+#else	
+/* !CONFIG_FS_CAPABILITIES */
+static inline void fscap_mount(struct vfsmount *mnt) {}
+static inline void fscap_umount(struct super_block *sb) {}
+static inline void fscap_read(struct linux_binprm *bprm) {}
+static inline void fscap_drop(struct inode *inode) {}
+#endif
+
+#endif
diff -urN a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c	Mon Aug 29 20:59:43 2005
+++ b/security/commoncap.c	Sun Jan  8 15:12:25 2006
@@ -23,6 +23,7 @@
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
+#include <linux/fscaps.h>
 
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
@@ -113,11 +114,12 @@
 {
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
 
+	fscap_read(bprm);
+
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
@@ -161,6 +163,10 @@
 							current->cap_permitted);
 			}
 		}
+#ifdef CONFIG_LIBC_ENABLE_SECURE_HACK
+		if (bprm->e_uid == current->uid && bprm->e_gid == current->gid)
+			current->gid = -1;
+#endif
 	}
 
 	current->suid = current->euid = current->fsuid = bprm->e_uid;

--=-=-=--
