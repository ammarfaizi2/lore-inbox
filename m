Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUK2LoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUK2LoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUK2LoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:44:04 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:31442 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261685AbUK2Lkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:40:43 -0500
Date: Mon, 29 Nov 2004 03:43:31 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] relinquish_fs() syscall
Message-ID: <20041129114331.GA33900@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 29 Nov 2004 03:43:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

relinquish_fs() is a replacement for the chroot("/var/empty") technique
currently used for privilege-separated daemons such as recent OpenSSH.
Rather than using a directory on the normal filesystem it places the
process in an alternate namespace.  This namespace has one filesystem
of type "nullfs" -- it's empty and immutable.

This has several benefits:

 * Considerably safer against root users in cage

   Normal chroot's are trivial for privileged users to break out of -
   these tasks don't work in the namespace.  You can't create a directory
   to do the "chroot foo; cd ../../..; chroot ." trick.  You can't
   create device nodes or mount /proc anywhere (I added an extra check
   to do_mount() that even prevents a mount on top of '/')

 * Can be used by non-root users!

   Normally chroot is restricted to root (to prevent the escape mentioned
   above and also to avoid confusing setuid programs about their environment)
   Obviously setuid binaries are not an issue here since execve() will be
   impossible after relinquish_fs() is called.

   This is a big deal for privilege separation; currently it's hard to
   implement except in a daemon that starts its life as root.  Now the
   same techniques can be used by any process.

   Imagine, for example, a jpeg decoder that after opening its input and
   output files called relinquish_fs().  Now if the decoder has a flaw and
   is fed an exploit it is not able to do much of anything.  And although
   adding privsep is hard work this technique can, in theory, be extended
   to anything that processes untrusted data from the network (html parsers,
   ssh client, etc)

   Of course, even after chroot() or relinquish_fs() an exploited process
   can still do bad things (chew up CPU, fork bomb, implement a rogue TCP
   proxy service, etc) but at least with this technique it makes it hard
   for an exploit to do lasting damage to the OS.
   
I reused the i386 syscall number from the (apparently now gone) set_altroot
syscall for now.

Also, this is the first time I've dug into the VFS internals; let me know
if I'm doing something terribly wrong.

Patch is versus 2.6.10-rc2-bk9

-Mitch

Signed-off-by: Mitchell Blank Jr <mitch@sfgoth.com>

diff -ur linux-2.6.10-rc2-bk9-VIRGIN/arch/i386/kernel/entry.S linux-2.6.10-rc2-bk9/arch/i386/kernel/entry.S
--- linux-2.6.10-rc2-bk9-VIRGIN/arch/i386/kernel/entry.S	2004-11-25 21:46:20.000000000 -0800
+++ linux-2.6.10-rc2-bk9/arch/i386/kernel/entry.S	2004-11-29 03:26:08.960348873 -0800
@@ -860,7 +860,7 @@
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
 	.long sys_waitid
-	.long sys_ni_syscall		/* 285 */ /* available */
+	.long sys_relinquish_fs		/* 285 */
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
diff -ur linux-2.6.10-rc2-bk9-VIRGIN/fs/namespace.c linux-2.6.10-rc2-bk9/fs/namespace.c
--- linux-2.6.10-rc2-bk9-VIRGIN/fs/namespace.c	2004-11-25 21:46:59.000000000 -0800
+++ linux-2.6.10-rc2-bk9/fs/namespace.c	2004-11-29 02:48:08.833945322 -0800
@@ -22,6 +22,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
@@ -991,6 +992,9 @@
 	return 0;
 }
 
+/* This is the namespace tasks go to after calling relinquish_fs() */
+static struct namespace *nullfs_namespace;
+
 /*
  * Flags is a 32-bit value that allows up to 31 non-fs dependent flags to
  * be given to the mount() call (ie: read-only, no-dev, no-suid etc).
@@ -1023,6 +1027,14 @@
 	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
 		return -EINVAL;
 
+	/*
+	 * If the task has called relinquish_fs() then don't allow any
+	 * mounts.  They can't get a mount point but they could mount
+	 * something on top of "/"
+	 */
+	if (current->namespace == nullfs_namespace)
+		return -EROFS;
+
 	if (data_page)
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
@@ -1358,15 +1370,10 @@
 	goto out2;
 }
 
-static void __init init_mount_tree(void)
+static struct namespace * __init init_new_namespace(struct vfsmount *mnt)
 {
-	struct vfsmount *mnt;
 	struct namespace *namespace;
-	struct task_struct *g, *p;
 
-	mnt = do_kern_mount("rootfs", 0, "rootfs", NULL);
-	if (IS_ERR(mnt))
-		panic("Can't create rootfs");
 	namespace = kmalloc(sizeof(*namespace), GFP_KERNEL);
 	if (!namespace)
 		panic("Can't allocate initial namespace");
@@ -1376,6 +1383,19 @@
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
+	return namespace;
+}
+
+static void __init init_mount_tree(void)
+{
+	struct vfsmount *mnt;
+	struct namespace *namespace;
+	struct task_struct *g, *p;
+
+	mnt = do_kern_mount("rootfs", 0, "rootfs", NULL);
+	if (IS_ERR(mnt))
+		panic("Can't create rootfs");
+	namespace = init_new_namespace(mnt);
 
 	init_task.namespace = namespace;
 	read_lock(&tasklist_lock);
@@ -1389,6 +1409,78 @@
 	set_fs_root(current->fs, namespace->root, namespace->root->mnt_root);
 }
 
+/* Make sure that noone tries a remount a "nullfs" */
+static int nullfs_remount(struct super_block *sb, int *flagsp, char *data)
+{
+	return -EROFS;
+}
+
+/* Simple filesystem that is just an immutable empty directory */
+static int nullfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct super_operations nullfs_ops= {
+		.statfs		= simple_statfs,
+		.drop_inode	= generic_delete_inode,
+		.remount_fs	= nullfs_remount,
+	};
+	static struct address_space_operations nullfs_aops = {
+        	.readpage       = simple_readpage,
+	};
+	static struct inode_operations nullfs_dir_inode_operations = {
+		.lookup		= simple_lookup,
+	};
+	struct inode *inode;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = 0x6c6c754e;	/* "Null" */
+	sb->s_op = &nullfs_ops;
+	inode = new_inode(sb);
+	if (inode == NULL)
+		return -ENOMEM;
+	inode->i_mode = S_IFDIR | 0555;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_mapping->a_ops = &nullfs_aops;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_op = &nullfs_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_nlink++;
+	sb->s_root = d_alloc_root(inode);
+	if (sb->s_root == NULL) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static struct super_block *nullfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_nodev(fs_type, flags | MS_NOUSER,
+			    data, nullfs_fill_super);
+}
+
+static void __init init_nullfs(void)
+{
+	static struct file_system_type nullfs_fs_type = {
+		.name		= "nullfs",
+		.get_sb		= nullfs_get_sb,
+		.kill_sb	= kill_anon_super,
+	};
+
+	if (register_filesystem(&nullfs_fs_type) != 0)
+		panic("Can't register nullfs");
+	/* Most of these flags are not needed, but won't hurt */
+	nullfs_namespace = init_new_namespace(do_kern_mount("nullfs",
+	      			(MS_RDONLY | MS_NOSUID | MS_NODEV |
+				 MS_NOEXEC | MS_NOATIME | MS_NODIRATIME),
+				"nullfs", NULL));
+	if (IS_ERR(nullfs_namespace->root))
+		panic("Can't mount nullfs");
+}
+
 void __init mnt_init(unsigned long mempages)
 {
 	struct list_head *d;
@@ -1439,6 +1531,54 @@
 	sysfs_init();
 	init_rootfs();
 	init_mount_tree();
+	init_nullfs();
+}
+
+/*
+ * Callable by any process to relinquish all access to the filesystem by
+ * putting their root in an immutably empty namespace.  Note that like
+ * chroot() we do NOT change pwd, so a chdir("/") should be done afterwards
+ */
+asmlinkage long sys_relinquish_fs(void)
+{
+	struct fs_struct *fs = current->fs;
+
+	if (current->namespace == nullfs_namespace)
+	  	return 0;	/* already relinquished */
+	/*
+	 * Since namespace is per-thread yet the ->fs struct can be shared
+	 * we need to make sure we're in a thread.  Unfortunately that means
+	 * this syscall can fail with -ENOMEM; luckily it's only in the
+	 * threaded case
+	 */
+	if (atomic_read(&fs->count) != 1) {
+		struct fs_struct *n = copy_fs_struct(current->fs);
+		if (n == NULL)
+		  	return -ENOMEM;
+		task_lock(current);
+		current->fs = n;
+		task_unlock(current);
+		put_fs_struct(fs);
+		fs = n;
+	}
+	get_namespace(nullfs_namespace);
+	put_namespace(current->namespace);
+	current->namespace = nullfs_namespace;
+
+	set_fs_root(fs, nullfs_namespace->root,
+	    	    nullfs_namespace->root->mnt_root);
+	/*
+	 * We also just rid ourselves of any altroot; an attacker could get
+	 * it back via set_personality() but that won't do any good since
+	 * emul_prefix can't be looked up anymore
+	 */
+	if (current->fs->altroot != NULL) {
+	  	dput(current->fs->altroot);
+		mntput(current->fs->altrootmnt);
+		current->fs->altroot = NULL;
+		current->fs->altrootmnt = NULL;
+	}
+	return 0;
 }
 
 void __put_namespace(struct namespace *namespace)
diff -ur linux-2.6.10-rc2-bk9-VIRGIN/include/asm-i386/unistd.h linux-2.6.10-rc2-bk9/include/asm-i386/unistd.h
--- linux-2.6.10-rc2-bk9-VIRGIN/include/asm-i386/unistd.h	2004-11-25 21:46:39.000000000 -0800
+++ linux-2.6.10-rc2-bk9/include/asm-i386/unistd.h	2004-11-28 22:04:48.000000000 -0800
@@ -290,7 +290,7 @@
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
 #define __NR_waitid		284
-/* #define __NR_sys_setaltroot	285 */
+#define __NR_sys_relinquish_fs	285
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
diff -ur linux-2.6.10-rc2-bk9-VIRGIN/include/linux/syscalls.h linux-2.6.10-rc2-bk9/include/linux/syscalls.h
--- linux-2.6.10-rc2-bk9-VIRGIN/include/linux/syscalls.h	2004-11-25 21:46:40.000000000 -0800
+++ linux-2.6.10-rc2-bk9/include/linux/syscalls.h	2004-11-28 09:59:28.449907226 -0800
@@ -506,4 +506,6 @@
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
+asmlinkage long sys_relinquish_fs(void);
+
 #endif
