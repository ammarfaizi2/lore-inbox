Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSJ1WuT>; Mon, 28 Oct 2002 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSJ1WuT>; Mon, 28 Oct 2002 17:50:19 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:24223 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261646AbSJ1WuC>; Mon, 28 Oct 2002 17:50:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.GSO.4.21.0210182018010.21677-100000@weyl.math.psu.edu>
	<877kg8xbvk.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Mon, 28 Oct 2002 23:56:16 +0100
Message-ID: <87smyqnpf3.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, here I am again monologising :-)

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> Alexander Viro <viro@math.psu.edu> writes:
>
>> On Sat, 19 Oct 2002, Olaf Dietsche wrote:
>>
>> mount --bind my_file /usr/.capabilities
>
> This is still open.

Fixed with this version.

This is as good as it gets without digging deeper into filesystem
details. Right now, I'm running this code and I'm content with this
patch. Thanks to Al Viro for pointing out the weakness of earlier
versions.

Solving the last issue (checking access to the capabilities database)
involves filesystem support, I guess. So, this will be the next step
to address.

If you're careful with giving away capabilities however, this patch
can make your system more secure as it is. But this isn't fully
explored, so you might achieve the opposite and open new security
holes.

If you have comments, feedback, suggestions, let me know.

Regards, Olaf.

diff -urN a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Wed Oct 16 09:23:41 2002
+++ b/fs/Config.help	Mon Oct 28 14:12:02 2002
@@ -1152,3 +1152,15 @@
 
   If unsure, say N.
 
+CONFIG_FS_CAPABILITIES
+  If you say Y here, you will be able to grant selective privileges to
+  executables on a needed basis. This means for some executables,
+  there is no need anymore to run as root or as a suid binary.
+
+  For example, you may drop the SUID bit from ping and grant the
+  CAP_NET_RAW capability:
+  # chmod u-s /bin/ping
+  # chcap cap_net_raw=ep /bin/ping
+
+  If you're unsure, say N.
+
diff -urN a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Wed Oct 16 09:23:41 2002
+++ b/fs/Config.in	Thu Oct 24 00:11:51 2002
@@ -108,6 +108,8 @@
    define_bool CONFIG_QUOTACTL y
 fi
 
+dep_bool 'Filesystem capabilities (Experimental)' CONFIG_FS_CAPABILITIES $CONFIG_EXPERIMENTAL
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -urN a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Sat Oct 19 13:52:46 2002
+++ b/fs/Makefile	Thu Oct 24 00:11:51 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o
+                fcntl.o read_write.o dcookies.o fscaps.o
 
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
+++ b/fs/attr.c	Mon Oct 28 14:52:02 2002
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
+++ b/fs/fscaps.c	Mon Oct 28 15:58:37 2002
@@ -0,0 +1,155 @@
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
+};
+
+static void __info_init(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct fscap_info *info = kmalloc(sizeof(struct fscap_info), GFP_KERNEL);
+	if (info) {
+		info->mnt = mnt;
+		info->dentry = dget(dentry);
+		mnt->mnt_sb->s_fscaps = info;
+	}
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
+	static char name[] = ".capabilities";
+	nd->mnt = mntget(mnt);
+	nd->dentry = dget(mnt->mnt_sb->s_root);
+	nd->flags = 0;
+	return path_walk(name, nd);
+}
+
+static struct file *__fscap_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	if (mnt->mnt_flags & MNT_NOSUID)
+		return ERR_PTR(-EPERM);
+
+	if (inode->i_uid != 0 || inode->i_gid != 0)
+		return ERR_PTR(-EPERM);
+
+	if ((inode->i_mode & 077) != 0)
+		return ERR_PTR(-EACCES);
+
+	dentry = dget(dentry);
+	mnt = mntget(mnt);
+	return dentry_open(dentry, mnt, flags);
+}
+
+static void __fscap_read(struct file *filp, struct linux_binprm *bprm)
+{
+	__u32 fscaps[3];
+	unsigned long ino = bprm->file->f_dentry->d_inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps)) {
+		bprm->cap_effective = fscaps[0];
+		bprm->cap_inheritable = fscaps[1];
+		bprm->cap_permitted = fscaps[2];
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
+	__u32 fscaps[3];
+	unsigned long ino = inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps) && (fscaps[0] || fscaps[1] || fscaps[2])) {
+		fscaps[0] = fscaps[1] = fscaps[2] = 0;
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
+++ b/fs/namespace.c	Sun Oct 27 19:29:58 2002
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
--- a/fs/open.c	Wed Oct 16 09:23:41 2002
+++ b/fs/open.c	Mon Oct 28 14:52:55 2002
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
--- a/fs/super.c	Sat Oct  5 18:45:22 2002
+++ b/fs/super.c	Mon Oct 28 11:25:05 2002
@@ -72,6 +72,7 @@
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
+		s->s_fscaps = NULL;
 	}
 out:
 	return s;
diff -urN a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sat Oct 19 13:52:47 2002
+++ b/include/linux/fs.h	Mon Oct 28 11:25:49 2002
@@ -665,6 +665,7 @@
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct fscap_info	*s_fscaps;	/* Filesystem capability stuff */
 
 	char s_id[32];				/* Informational name */
 
diff -urN a/include/linux/fscaps.h b/include/linux/fscaps.h
--- a/include/linux/fscaps.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/fscaps.h	Mon Oct 28 14:46:22 2002
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
+++ b/security/capability.c	Thu Oct 24 00:11:51 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/fscaps.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -119,10 +120,11 @@
 {
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
+
+	fscap_read(bprm);
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
