Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJaOQB>; Thu, 31 Oct 2002 09:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJaOQB>; Thu, 31 Oct 2002 09:16:01 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:63887 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262214AbSJaOPo>; Thu, 31 Oct 2002 09:15:44 -0500
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.45: Filesystem capabilities
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 31 Oct 2002 15:21:39 +0100
Message-ID: <87znsuy9ho.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- switched from 32 bits to 128 bits for capabilities

I have addressed all objections Al Viro has raised. However, this is
not widely tested so far. But this is a relative small patch, so it
shouldn't be too hard to remove it later, if it turns out to be too
dangerous, either security or file system wise.

Please include.

Regards, Olaf.

diff -urN a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Thu Oct 31 06:48:19 2002
+++ b/fs/Kconfig	Thu Oct 31 07:51:19 2002
@@ -1093,6 +1093,59 @@
 	  with or without the generic quota support enabled (CONFIG_QUOTA) -
 	  they are completely independent subsystems.
 
+config FS_CAPABILITIES
+	bool "Filesystem capabilities (Experimental)"
+	depends on EXPERIMENTAL
+	help
+	  If you say Y here, you will be able to grant selective privileges to
+	  executables on a needed basis. This means for some executables,
+	  there is no need anymore to run as root or as a suid binary.
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
+	help
+	  LD_PRELOAD is a glibc feature, which allows to override system
+	  library functions. But this means also a security hole, through
+	  which an attacker might gain unauthorized privileges. This is
+	  already prevented for SUID and SGID binaries.
+
+	  GNU libc doesn't know about filesystem capabilities yet and doesn't
+	  disable LD_PRELOAD for privileged executables, which are not SUID or
+	  SGID. This hack sets the group id to an invalid value and tricks GNU
+	  libc into thinking, this is a SGID binary (unless this is already
+	  SUID and/or SGID). However, this may break some programs.
+
+	  If you're unsure, say Y.
 
 menu "Network File Systems"
 	depends on NET
diff -urN a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Thu Oct 31 06:48:19 2002
+++ b/fs/Makefile	Thu Oct 31 07:42:51 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o fcblist.o
+                fcntl.o read_write.o dcookies.o fcblist.o fscaps.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -41,7 +41,8 @@
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
- 
+obj-$(CONFIG_FS_CAPABILITIES)	+= fscaps.o
+
 # Do not add any filesystems before this line
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
 obj-$(CONFIG_JBD)		+= jbd/
diff -urN a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Sat Oct  5 18:44:20 2002
+++ b/fs/attr.c	Thu Oct 31 06:53:36 2002
@@ -13,6 +13,7 @@
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
+#include <linux/fscaps.h>
 
 /* Taken over from the old code... */
 
@@ -170,6 +171,9 @@
 	}
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
+		if (ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
+			fscap_drop(inode);
+
 		if (dn_mask)
 			dnotify_parent(dentry, dn_mask);
 	}
diff -urN a/fs/fscaps.c b/fs/fscaps.c
--- a/fs/fscaps.c	Thu Jan  1 01:00:00 1970
+++ b/fs/fscaps.c	Thu Oct 31 14:12:33 2002
@@ -0,0 +1,297 @@
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
+static int __cap_permission(struct inode *inode, int mask)
+{
+	struct inode_operations *iops;
+	if ((mask & MAY_WRITE) && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = inode->i_sb->s_fscaps->cap_iops;
+	if (iops && iops->permission)
+		return iops->permission(inode, mask);
+
+	return vfs_permission(inode, mask);
+}
+
+static void __info_cap_init(struct fscap_info *info, struct dentry *dentry)
+{
+	struct inode *inode;
+	struct inode_operations *iops;
+	if (info->dentry) {
+		inode = info->dentry->d_inode;
+		if (inode)
+			inode->i_op = inode->i_sb->s_fscaps->cap_iops;
+
+		dput(info->dentry);
+	}
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
+static int __rootdir_create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct inode_operations *iops;
+	int err, iscapdb = __is_capname(dentry->d_name.name);
+	if (iscapdb && !capable(CAP_SETFCAP))
+		return -EPERM;
+
+	iops = dir->i_sb->s_fscaps->rootdir_iops;
+	err = iops->create(dir, dentry, mode);
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
+static void __info_free(struct fscap_info *info)
+{
+	if (info) {
+		dput(info->dentry);
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
+	if (__fscap_lookup(mnt, &nd))
+		return;
+
+	__info_init(mnt, nd.dentry);
+}
+
+void fscap_umount(struct super_block *sb)
+{
+	struct fscap_info *info = __info_lookup(sb);
+	__info_free(info);
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
--- a/fs/namespace.c	Sat Oct  5 18:45:36 2002
+++ b/fs/namespace.c	Thu Oct 31 06:53:36 2002
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
+#include <linux/fscaps.h>
 
 #include <asm/uaccess.h>
 
@@ -340,6 +341,7 @@
 		lock_kernel();
 		DQUOT_OFF(sb);
 		acct_auto_close(sb);
+		fscap_umount(sb);
 		unlock_kernel();
 		security_ops->sb_umount_close(mnt);
 		spin_lock(&dcache_lock);
@@ -655,6 +657,8 @@
 
 	mnt->mnt_flags = mnt_flags;
 	err = graft_tree(mnt, nd);
+	if (!err)
+		fscap_mount(mnt);
 unlock:
 	up_write(&current->namespace->sem);
 	mntput(mnt);
diff -urN a/fs/open.c b/fs/open.c
--- a/fs/open.c	Thu Oct 31 06:48:19 2002
+++ b/fs/open.c	Thu Oct 31 06:53:36 2002
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
 #include <linux/security.h>
+#include <linux/fscaps.h>
 
 #include <asm/uaccess.h>
 
@@ -665,6 +666,9 @@
 				goto cleanup_all;
 		}
 	}
+
+	if (flags & O_CREAT)
+		fscap_drop(inode);
 
 	return f;
 
diff -urN a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Oct 31 06:48:19 2002
+++ b/fs/super.c	Thu Oct 31 06:53:36 2002
@@ -71,6 +71,7 @@
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
+		s->s_fscaps = NULL;
 	}
 out:
 	return s;
diff -urN a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h	Sat Oct  5 18:43:38 2002
+++ b/include/linux/capability.h	Thu Oct 31 06:53:36 2002
@@ -283,6 +283,10 @@
 
 #define CAP_LEASE            28
 
+/* Allow setting capabilities on files */
+
+#define CAP_SETFCAP          29
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff -urN a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Oct 31 06:48:21 2002
+++ b/include/linux/fs.h	Thu Oct 31 06:53:36 2002
@@ -667,6 +667,7 @@
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct fscap_info	*s_fscaps;	/* Filesystem capability stuff */
 
 	char s_id[32];				/* Informational name */
 
diff -urN a/include/linux/fscaps.h b/include/linux/fscaps.h
--- a/include/linux/fscaps.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/fscaps.h	Thu Oct 31 06:53:36 2002
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
diff -urN a/security/capability.c b/security/capability.c
--- a/security/capability.c	Sat Oct 19 13:52:48 2002
+++ b/security/capability.c	Thu Oct 31 06:53:36 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/fscaps.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -119,11 +120,12 @@
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
@@ -184,6 +186,10 @@
 							       cap_permitted);
 			}
 		}
+#ifdef CONFIG_LIBC_ENABLE_SECURE_HACK
+		if (current->euid == current->uid && current->egid == current->gid)
+			current->gid = -1;
+#endif
 		do_unlock = 1;
 	}
 
