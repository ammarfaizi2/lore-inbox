Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbVIPHCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbVIPHCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbVIPHBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:21208 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161073AbVIPHBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:12 -0400
Message-Id: <20050916123313.884887000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 05/11] spufs: Use a system call instead of ioctl
Content-Disposition: inline; filename=spufs-syscall-4.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are moving to a system call based approach for some
low-level operations now. Two system calls are introduced,
spu_run and spu_create. The spu_create call can be
used in place of the mkdir syscall to create an spu
context. It returns an open file descriptor to the
new directory. When the fd is closed (e.g. on process
exit), the context is automatically destroyed.

The spu_run call takes over the role of the ioctl
with the same name. It operates on the file descriptor
returned from spu_create, so we don't need the "run"
file any more.

The old interfaces are retained in this patch, so 
that libraries continue to work.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com.de>

--

 arch/ppc64/kernel/Makefile       |    2 
 arch/ppc64/kernel/misc.S         |    4 
 arch/ppc64/kernel/spu_syscalls.c |   86 ++++++++++++
 fs/spufs/Makefile                |    3 
 fs/spufs/context.c               |    4 
 fs/spufs/file.c                  |    2 
 fs/spufs/inode.c                 |  135 ++++++++++++++-----
 fs/spufs/spufs.h                 |    8 -
 fs/spufs/syscalls.c              |  106 ++++++++++++++
 include/asm-ppc/unistd.h         |    4 
 include/asm-ppc64/spu.h          |   23 +++
 include/asm-ppc64/unistd.h       |    5 
 include/linux/syscalls.h         |    3 
 kernel/sys_ni.c                  |    2 
 14 files changed, 349 insertions(+), 38 deletions(-)

Index: linux-cg/arch/ppc64/kernel/misc.S
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/misc.S
+++ linux-cg/arch/ppc64/kernel/misc.S
@@ -1230,6 +1230,8 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_inotify_init	/* 275 */
 	.llong .sys_inotify_add_watch
 	.llong .sys_inotify_rm_watch
+	.llong .sys_spu_run
+	.llong .sys_spu_create_thread
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1511,3 +1513,5 @@ _GLOBAL(sys_call_table)
 	.llong .sys_inotify_init	/* 275 */
 	.llong .sys_inotify_add_watch
 	.llong .sys_inotify_rm_watch
+	.llong .sys_spu_run
+	.llong .sys_spu_create_thread
Index: linux-cg/fs/spufs/Makefile
===================================================================
--- linux-cg.orig/fs/spufs/Makefile
+++ linux-cg/fs/spufs/Makefile
@@ -1,6 +1,5 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
-
-spufs-y += inode.o file.o context.o switch.o
+spufs-y += inode.o file.o context.o switch.o syscalls.o
 
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -378,7 +378,7 @@ static struct file_operations spufs_wbox
 	.read	= spufs_wbox_stat_read,
 };
 
-static long spufs_run_spu(struct file *file, struct spu_context *ctx,
+long spufs_run_spu(struct file *file, struct spu_context *ctx,
 		u32 *npc, u32 *status)
 {
 	struct spu_problem __iomem *prob;
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -53,11 +53,17 @@ struct spufs_inode_info {
 
 extern struct tree_descr spufs_dir_contents[];
 
+/* system call implementation */
+long spufs_run_spu(struct file *file,
+		   struct spu_context *ctx, u32 *npc, u32 *status);
+long spufs_create_thread(struct nameidata *nd, const char *name,
+			 unsigned int flags, mode_t mode);
+
 /* context management */
 struct spu_context * alloc_spu_context(void);
 void destroy_spu_context(struct kref *kref);
 struct spu_context * get_spu_context(struct spu_context *ctx);
-void put_spu_context(struct spu_context *ctx);
+int put_spu_context(struct spu_context *ctx);
 
 void spu_acquire(struct spu_context *ctx);
 void spu_release(struct spu_context *ctx);
Index: linux-cg/include/asm-ppc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-ppc/unistd.h
+++ linux-cg/include/asm-ppc/unistd.h
@@ -282,8 +282,10 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_spu_run		278
+#define __NR_spu_create_thread	279
 
-#define __NR_syscalls		278
+#define __NR_syscalls		280
 
 #define __NR(n)	#n
 
Index: linux-cg/include/asm-ppc64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/unistd.h
+++ linux-cg/include/asm-ppc64/unistd.h
@@ -288,8 +288,11 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_spu_run		278
+#define __NR_spu_create_thread	279
+#define __NR_syscalls		280
+
 
-#define __NR_syscalls		278
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
Index: linux-cg/include/linux/syscalls.h
===================================================================
--- linux-cg.orig/include/linux/syscalls.h
+++ linux-cg/include/linux/syscalls.h
@@ -509,4 +509,7 @@ asmlinkage long sys_keyctl(int cmd, unsi
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
 
+asmlinkage long sys_spu_run(int fd, __u32 __user *unpc,
+				 __u32 __user *ustatus);
+
 #endif
Index: linux-cg/kernel/sys_ni.c
===================================================================
--- linux-cg.orig/kernel/sys_ni.c
+++ linux-cg/kernel/sys_ni.c
@@ -90,3 +90,5 @@ cond_syscall(sys_pciconfig_iobase);
 cond_syscall(sys32_ipc);
 cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
+cond_syscall(sys_spu_run);
+cond_syscall(sys_spu_create_thread);
Index: linux-cg/arch/ppc64/kernel/Makefile
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/Makefile
+++ linux-cg/arch/ppc64/kernel/Makefile
@@ -57,6 +57,8 @@ obj-$(CONFIG_IBMVIO)		+= vio.o $(vio-obj
 obj-$(CONFIG_XICS)		+= xics.o
 obj-$(CONFIG_MPIC)		+= mpic.o
 obj-$(CONFIG_SPU_FS)		+= spu_base.o
+spu_syscalls-$(CONFIG_SPU_FS)	+= spu_syscalls.o
+obj-y += $(spu_syscalls-m)
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
Index: linux-cg/arch/ppc64/kernel/spu_syscalls.c
===================================================================
--- /dev/null
+++ linux-cg/arch/ppc64/kernel/spu_syscalls.c
@@ -0,0 +1,86 @@
+/*
+ * SPU file system -- system call stubs
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+
+#include <asm/spu.h>
+
+struct spufs_calls spufs_calls = {
+	.owner = NULL,
+};
+
+/* These stub syscalls are needed to have the actual implementation
+ * within a loadable module. When spufs is built into the kernel,
+ * this file is not used and the syscalls directly enter the fs code */
+
+asmlinkage long sys_spu_create_thread(const char __user *name,
+		unsigned int flags, mode_t mode)
+{
+	long ret;
+
+	ret = -ENOSYS;
+	if (try_module_get(spufs_calls.owner)) {
+		ret = spufs_calls.create_thread(name, flags, mode);
+		module_put(spufs_calls.owner);
+	}
+	return ret;
+}
+
+asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
+{
+	long ret;
+	struct file *filp;
+	int fput_needed;
+
+	ret = -ENOSYS;
+	if (try_module_get(spufs_calls.owner)) {
+		ret = -EBADF;
+		filp = fget_light(fd, &fput_needed);
+		if (filp) {
+			ret = spufs_calls.spu_run(filp, unpc, ustatus);
+			fput_light(filp, fput_needed);
+		}
+		module_put(spufs_calls.owner);
+	}
+	return ret;
+}
+
+int register_spu_syscalls(struct spufs_calls *calls)
+{
+	if (spufs_calls.owner)
+		return -EBUSY;
+
+	spufs_calls.create_thread = calls->create_thread;
+	spufs_calls.spu_run = calls->spu_run;
+	smp_mb();
+	spufs_calls.owner = calls->owner;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_spu_syscalls);
+
+void unregister_spu_syscalls(struct spufs_calls *calls)
+{
+	BUG_ON(spufs_calls.owner != calls->owner);
+	spufs_calls.owner = NULL;
+}
+EXPORT_SYMBOL_GPL(unregister_spu_syscalls);
Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -77,9 +77,9 @@ struct spu_context * get_spu_context(str
 	return ctx;
 }
 
-void put_spu_context(struct spu_context *ctx)
+int put_spu_context(struct spu_context *ctx)
 {
-	kref_put(&ctx->kref, &destroy_spu_context);
+	return kref_put(&ctx->kref, &destroy_spu_context);
 }
 
 
Index: linux-cg/fs/spufs/inode.c
===================================================================
--- linux-cg.orig/fs/spufs/inode.c
+++ linux-cg/fs/spufs/inode.c
@@ -20,11 +20,13 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/module.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
@@ -210,12 +212,60 @@ out:
 	return ret;
 }
 
+static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+{
+	struct dentry *dentry;
+	int err;
+
+	spin_lock(&dcache_lock);
+	/* remove all entries */
+	err = 0;
+	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		atomic_dec(&dentry->d_count);
+		spin_lock(&dentry->d_lock);
+		__d_drop(dentry);
+		spin_unlock(&dentry->d_lock);
+	}
+	spin_unlock(&dcache_lock);
+	if (!err) {
+		shrink_dcache_parent(dir_dentry);
+		err = simple_rmdir(root, dir_dentry);
+	}
+	return err;
+}
+
+static int spufs_dir_close(struct inode *inode, struct file *file)
+{
+	struct inode *dir;
+	struct dentry *dentry;
+	int ret;
+
+	dentry = file->f_dentry;
+	dir = dentry->d_parent->d_inode;
+	down(&dir->i_sem);
+	ret = spufs_rmdir(dir, file->f_dentry);
+	WARN_ON(ret);
+	up(&dir->i_sem);
+	return dcache_dir_close(inode, file);
+}
+
 struct inode_operations spufs_dir_inode_operations = {
 	.lookup = simple_lookup,
 	.unlink = simple_unlink,
 	.create = spufs_create,
 };
 
+struct file_operations spufs_autodelete_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= spufs_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= dcache_readdir,
+	.fsync		= simple_sync_file,
+};
+
 static int
 spufs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
@@ -256,40 +306,56 @@ out:
 	return ret;
 }
 
-/* This looks really wrong! */
-static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
+long
+spufs_create_thread(struct nameidata *nd, const char *name,
+			unsigned int flags, mode_t mode)
 {
 	struct dentry *dentry;
-	int err;
+	struct file *filp;
+	int ret;
 
-	spin_lock(&dcache_lock);
-#if 0
-	/* check if any entry is used */
-	err = -EBUSY;
-	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
-		if (d_unhashed(dentry) || !dentry->d_inode)
-			continue;
-		if (atomic_read(&dentry->d_count) != 1)
-			goto out;
-	}
-#endif
-	/* remove all entries */
-	err = 0;
-	list_for_each_entry(dentry, &dir_dentry->d_subdirs, d_child) {
-		if (d_unhashed(dentry) || !dentry->d_inode)
-			continue;
-		atomic_dec(&dentry->d_count);
-		__d_drop(dentry);
+	/* need to be at the root of spufs */
+	ret = -EINVAL;
+	if (nd->dentry->d_sb->s_magic != SPUFS_MAGIC ||
+		nd->dentry != nd->dentry->d_sb->s_root)
+		goto out;
+
+	dentry = lookup_create(nd, 1);
+	ret = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
+		goto out_dir;
+
+	ret = -EEXIST;
+	if (dentry->d_inode)
+		goto out_dput;
+
+	mode &= ~current->fs->umask;
+	ret = spufs_mkdir(nd->dentry->d_inode, dentry, mode & S_IRWXUGO);
+	if (ret)
+		goto out_dput;
+
+	ret = get_unused_fd();
+	if (ret < 0)
+		goto out_dput;
+
+	dentry->d_inode->i_nlink++;
+
+	filp = filp_open(name, O_RDONLY, mode);
+	if (IS_ERR(filp)) {
+		// FIXME: remove directory again
+		put_unused_fd(ret);
+		ret = PTR_ERR(filp);
+	} else {
+		filp->f_op = &spufs_autodelete_dir_operations;
+		fd_install(ret, filp);
 	}
-#if 0
+
+out_dput:
+	dput(dentry);
+out_dir:
+	up(&nd->dentry->d_inode->i_sem);
 out:
-#endif
-	spin_unlock(&dcache_lock);
-	if (!err) {
-		shrink_dcache_parent(dir_dentry);
-		err = simple_rmdir(root, dir_dentry);
-	}
-	return err;
+	return ret;
 }
 
 /* File system initialization */
@@ -417,7 +483,15 @@ static int spufs_init(void)
 		goto out;
 	ret = register_filesystem(&spufs_type);
 	if (ret)
-		kmem_cache_destroy(spufs_inode_cache);
+		goto out_cache;
+	ret = register_spu_syscalls(&spufs_calls);
+	if (ret)
+		goto out_fs;
+	return 0;
+out_fs:
+	unregister_filesystem(&spufs_type);
+out_cache:
+	kmem_cache_destroy(spufs_inode_cache);
 out:
 	return ret;
 }
@@ -425,6 +499,7 @@ module_init(spufs_init);
 
 static void spufs_exit(void)
 {
+	unregister_spu_syscalls(&spufs_calls);
 	unregister_filesystem(&spufs_type);
 	kmem_cache_destroy(spufs_inode_cache);
 }
Index: linux-cg/fs/spufs/syscalls.c
===================================================================
--- /dev/null
+++ linux-cg/fs/spufs/syscalls.c
@@ -0,0 +1,106 @@
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+
+#include <asm/uaccess.h>
+
+#include "spufs.h"
+
+/**
+ * sys_spu_run - run code loaded into an SPU
+ *
+ * @unpc:    next program counter for the SPU
+ * @ustatus: status of the SPU
+ *
+ * This system call transfers the control of execution of a
+ * user space thread to an SPU. It will return when the
+ * SPU has finished executing or when it hits an error
+ * condition and it will be interrupted if a signal needs
+ * to be delivered to a handler in user space.
+ *
+ * The next program counter is set to the passed value
+ * before the SPU starts fetching code and the user space
+ * pointer gets updated with the new value when returning
+ * from kernel space.
+ *
+ * The status value returned from spu_run reflects the
+ * value of the spu_status register after the SPU has stopped.
+ *
+ */
+long do_spu_run(struct file *filp, __u32 __user *unpc, __u32 __user *ustatus)
+{
+	long ret;
+	struct spufs_inode_info *i;
+	u32 npc, status;
+
+	ret = -EFAULT;
+	if (get_user(npc, unpc))
+		goto out;
+
+	ret = -EINVAL;
+	if (filp->f_vfsmnt->mnt_sb->s_magic != SPUFS_MAGIC)
+		goto out;
+
+	i = SPUFS_I(filp->f_dentry->d_inode);
+	ret = spufs_run_spu(filp, i->i_ctx, &npc, &status);
+
+	if (ret ==-EAGAIN || ret == -EIO)
+		ret = status;
+
+	if (put_user(npc, unpc))
+		ret = -EFAULT;
+
+	if (ustatus && put_user(status, ustatus))
+		ret = -EFAULT;
+out:
+	return ret;
+}
+
+#ifndef MODULE
+asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
+{
+	int fput_needed;
+	struct file *filp;
+	long ret;
+
+	ret = -EBADF;
+	filp = fget_light(fd, &fput_needed);
+	if (filp) {
+		ret = do_spu_run(filp, unpc, ustatus);
+		fput_light(filp, fput_needed);
+	}
+
+	return ret;
+}
+#endif
+
+asmlinkage long sys_spu_create_thread(const char __user *pathname,
+					unsigned int flags, mode_t mode)
+{
+	char *tmp;
+	int ret;
+
+	tmp = getname(pathname);
+	ret = PTR_ERR(tmp);
+	if (!IS_ERR(tmp)) {
+		struct nameidata nd;
+
+		ret = path_lookup(tmp, LOOKUP_PARENT|
+				LOOKUP_OPEN|LOOKUP_CREATE, &nd);
+		if (!ret) {
+			ret = spufs_create_thread(&nd, pathname, flags, mode);
+			path_release(&nd);
+		}
+		putname(tmp);
+	}
+
+	return ret;
+}
+
+struct spufs_calls spufs_calls = {
+	.create_thread = sys_spu_create_thread,
+	.spu_run = do_spu_run,
+	.owner = THIS_MODULE,
+};
Index: linux-cg/include/asm-ppc64/spu.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu.h
+++ linux-cg/include/asm-ppc64/spu.h
@@ -22,6 +22,7 @@
 
 #ifndef _SPU_H
 #define _SPU_H
+#include <linux/config.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
 
@@ -140,6 +141,28 @@ int spu_run(struct spu *spu);
 size_t spu_wbox_write(struct spu *spu, u32 data);
 size_t spu_ibox_read(struct spu *spu, u32 *data);
 
+extern struct spufs_calls {
+	asmlinkage long (*create_thread)(const char __user *name,
+					unsigned int flags, mode_t mode);
+	asmlinkage long (*spu_run)(struct file *filp, __u32 __user *unpc,
+						__u32 __user *ustatus);
+	struct module *owner;
+} spufs_calls;
+
+#ifdef CONFIG_SPU_FS_MODULE
+int register_spu_syscalls(struct spufs_calls *calls);
+void unregister_spu_syscalls(struct spufs_calls *calls);
+#else
+static inline int register_spu_syscalls(struct spufs_calls *calls)
+{
+	return 0;
+}
+static inline void unregister_spu_syscalls(struct spufs_calls *calls)
+{
+}
+#endif /* MODULE */
+
+
 /*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
  */

--

