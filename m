Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbSJXMTS>; Thu, 24 Oct 2002 08:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJXMTS>; Thu, 24 Oct 2002 08:19:18 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51386 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265405AbSJXMTL>; Thu, 24 Oct 2002 08:19:11 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.GSO.4.21.0210182018010.21677-100000@weyl.math.psu.edu>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 24 Oct 2002 14:25:03 +0200
Message-ID: <877kg8xbvk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Sat, 19 Oct 2002, Olaf Dietsche wrote:
>
> mount --bind my_file /usr/.capabilities

This is still open.

>> > ditto for owner of
>> > root directory on some filesystem.
>> 
>> Which is a problem for foreign (network) filesystems only. Should be
>> solvable with a mount option (i.e. mount -o nocaps ...).

I use option nosuid for now.

>> > And there is no way to recognize
>> > that file as such, so additional checks on write(), mount(), unlink().
>> > etc. are not possible.
>> 
>> Depends on, wether I want to recognize it and do these checks. Anyway,
>> could be solved with a mount option too or something like quotactl(2)
>> maybe.
>
> Ahem.  You had made several capabilities equivalent to "everything".
> E.g. "anyone who can override checks in chown() can set arbitrary
> capabilities", etc.  Which changes model big way and makes the affected
> capabilities pretty much useless - they can be elevated to any other
> capability.

Which is nothing new, how I learnt recently: CAP_SYS_RAWIO,
CAP_SYS_MODULE for example, not to mention CAP_SETPCAP. But maybe
pinning the .capabilities inode in memory and providing an appropriate
i_op could be a solution?

> mount --bind /usr/bin /mnt
> Suddenly /mnt/foo and /usr/bin/foo (same file) have different capabilities.

I use super_block->s_root, so this is no problem anymore.

Now it drops capabilities, when a chown() or open() is done.

Well, here is my next try against 2.5.44. It's slightly better than
before, boots and seems to work as expected :-)

Regards, Olaf.

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
+++ b/fs/attr.c	Thu Oct 24 00:11:51 2002
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
+			fscap_drop(dentry);
+
 		if (dn_mask)
 			dnotify_parent(dentry, dn_mask);
 	}
diff -urN a/fs/fscaps.c b/fs/fscaps.c
--- a/fs/fscaps.c	Thu Jan  1 01:00:00 1970
+++ b/fs/fscaps.c	Thu Oct 24 13:44:37 2002
@@ -0,0 +1,102 @@
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
+#include <asm/uaccess.h>
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
+static struct file *__fscap_open(struct dentry *de, struct vfsmount *mnt, int flags)
+{
+	struct inode *inode = de->d_inode;
+	if (mnt->mnt_flags & MNT_NOSUID)
+		return ERR_PTR(-EPERM);
+
+	if (inode->i_uid != 0 || inode->i_gid != 0)
+		return ERR_PTR(-EPERM);
+
+	if ((inode->i_mode & 077) != 0)
+		return ERR_PTR(-EACCES);
+
+	return dentry_open(de, mnt, flags);
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
+static void __fscap_drop(struct file *filp, struct dentry *de)
+{
+	__u32 fscaps[3];
+	unsigned long ino = de->d_inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps) && (fscaps[0] || fscaps[1] || fscaps[2])) {
+		fscaps[0] = fscaps[1] = fscaps[2] = 0;
+		kernel_write(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	}
+}
+
+void fscap_read(struct linux_binprm *bprm)
+{
+	struct nameidata nd;
+	int err = __fscap_lookup(bprm->file->f_vfsmnt, &nd);
+	if (!err) {
+		struct file *filp = __fscap_open(nd.dentry, nd.mnt, O_RDONLY);
+		if (filp && !IS_ERR(filp)) {
+			__fscap_read(filp, bprm);
+			filp_close(filp, 0);
+		}
+	}
+}
+
+void fscap_drop(struct dentry *de)
+{
+	struct nameidata nd;
+	int err = __fscap_lookup(de->d_sb->s_rootmnt, &nd);
+	if (!err) {
+		struct file *filp = __fscap_open(nd.dentry, nd.mnt, O_RDWR);
+		if (filp && !IS_ERR(filp)) {
+			__fscap_drop(filp, de);
+			filp_close(filp, 0);
+		}
+	}
+}
+
+EXPORT_SYMBOL(fscap_read);
+EXPORT_SYMBOL(fscap_drop);
diff -urN a/fs/open.c b/fs/open.c
--- a/fs/open.c	Wed Oct 16 09:23:41 2002
+++ b/fs/open.c	Thu Oct 24 13:53:25 2002
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
+		fscap_drop(dentry);
 
 	return f;
 
diff -urN a/fs/super.c b/fs/super.c
--- a/fs/super.c	Sat Oct  5 18:45:22 2002
+++ b/fs/super.c	Thu Oct 24 00:11:51 2002
@@ -72,6 +72,7 @@
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
+		s->s_rootmnt = NULL;
 	}
 out:
 	return s;
@@ -619,6 +620,7 @@
 	sb = type->get_sb(type, flags, name, data);
 	if (IS_ERR(sb))
 		goto out_mnt;
+	sb->s_rootmnt = mnt;
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
diff -urN a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sat Oct 19 13:52:47 2002
+++ b/include/linux/fs.h	Thu Oct 24 00:11:51 2002
@@ -650,6 +650,7 @@
 	unsigned long		s_flags;
 	unsigned long		s_magic;
 	struct dentry		*s_root;
+	struct vfsmount		*s_rootmnt;
 	struct rw_semaphore	s_umount;
 	struct semaphore	s_lock;
 	int			s_count;
diff -urN a/include/linux/fscaps.h b/include/linux/fscaps.h
--- a/include/linux/fscaps.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/fscaps.h	Thu Oct 24 13:44:52 2002
@@ -0,0 +1,24 @@
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
+struct linux_binprm;
+struct dentry;
+
+#if defined(CONFIG_FS_CAPABILITIES) || defined(CONFIG_FS_CAPABILITIES_MODULE)
+extern void fscap_read(struct linux_binprm *bprm);
+extern void fscap_drop(struct dentry *de);
+#else	
+/* !CONFIG_FS_CAPABILITIES */
+static inline void fscap_read(struct linux_binprm *bprm) {}
+static inline void fscap_drop(struct dentry *de) {}
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
