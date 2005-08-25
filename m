Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbVHYWEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVHYWEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVHYWEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:04:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:19662 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964924AbVHYWEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:04:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 5/7] spufs: Use a system call instead of ioctl
Date: Fri, 26 Aug 2005 00:04:23 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508260004.23926.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to use a system call instead of
an ioctl to run spu code on spufs.

This is only provided for reference, the current patch is
unlikely to be used in future versions.

We planning to move to a model where creation/destruction
of SPU threads as well as entering the execution is done
with new system calls instead of mkdir, rmdir and this
call.
This will make an SPU thread a property of a Linux user
space thread instead of the global object that can be
used by any process.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com.de>

--

 arch/ppc64/kernel/misc.S   |    2 
 fs/spufs/Makefile          |    2 
 fs/spufs/file.c            |   12 +++++
 fs/spufs/spufs.h           |    2 
 fs/spufs/spurun.c          |   96 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/unistd.h   |    3 -
 include/asm-ppc64/unistd.h |    3 -
 include/linux/syscalls.h   |    3 +
 kernel/sys_ni.c            |    1 
 9 files changed, 121 insertions(+), 3 deletions(-)

--- linux-cg.orig/arch/ppc64/kernel/misc.S	2005-08-25 23:12:31.254917248 -0400
+++ linux-cg/arch/ppc64/kernel/misc.S	2005-08-25 23:12:36.582906000 -0400
@@ -1132,6 +1132,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_inotify_init	/* 275 */
 	.llong .sys_inotify_add_watch
 	.llong .sys_inotify_rm_watch
+	.llong .sys_spu_run
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1413,3 +1414,4 @@ _GLOBAL(sys_call_table)
 	.llong .sys_inotify_init	/* 275 */
 	.llong .sys_inotify_add_watch
 	.llong .sys_inotify_rm_watch
+	.llong .sys_spu_run
--- linux-cg.orig/fs/spufs/Makefile	2005-08-25 23:12:34.935890192 -0400
+++ linux-cg/fs/spufs/Makefile	2005-08-25 23:12:36.582906000 -0400
@@ -1,5 +1,7 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
+syscall-$(CONFIG_SPU_FS) += spurun.o
 
+obj-y += $(syscall-y) $(syscall-m)
 spufs-y += inode.o file.o context.o switch.o
 
 # Rules to build switch.o with the help of SPU tool chain
--- linux-cg.orig/fs/spufs/file.c	2005-08-25 23:12:31.259916488 -0400
+++ linux-cg/fs/spufs/file.c	2005-08-25 23:12:36.584905696 -0400
@@ -406,6 +406,16 @@ out:
 	return ret;
 }
 
+static int spufs_run_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	file->private_data = i->i_ctx;
+
+	i->i_spu_run = spufs_run_spu;
+
+	return nonseekable_open(inode, file);
+}
+
 struct spufs_run_arg {
 	u32 npc;    /* inout: Next Program Counter */
 	u32 status; /* out:   SPU status */
@@ -472,7 +482,7 @@ static long spufs_run_ioctl(struct file 
 }
 
 static struct file_operations spufs_run_fops = {
-	.open		= spufs_pipe_open,
+	.open		= spufs_run_open,
 	.unlocked_ioctl	= spufs_run_ioctl,
 	.compat_ioctl	= spufs_run_ioctl,
 	.read		= spufs_run_read,
--- linux-cg.orig/fs/spufs/spufs.h	2005-08-25 23:12:31.261916184 -0400
+++ linux-cg/fs/spufs/spufs.h	2005-08-25 23:12:36.584905696 -0400
@@ -46,6 +46,8 @@ struct spu_context {
 
 struct spufs_inode_info {
 	struct spu_context *i_ctx;
+	long (*i_spu_run)(struct file *filp, struct spu_context *ctx,
+		u32 *npc, u32 *result);
 	struct inode vfs_inode;
 };
 #define SPUFS_I(inode) \
--- linux-cg.orig/fs/spufs/spurun.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spurun.c	2005-08-25 23:12:36.585905544 -0400
@@ -0,0 +1,96 @@
+/*
+ * SPU file system -- run system call
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
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
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
+ * The function must get linked into the kernel, even if spufs
+ * itself is built as a module, so we can use the pointer in the
+ * system call table.
+ */
+long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
+{
+	struct file *filp;
+	struct spufs_inode_info *i;
+	long ret;
+	u32 npc, status;
+	int fput_needed;
+
+	ret = -EBADF;
+	filp = fget_light(fd, &fput_needed);
+	if (!filp)
+		goto out;
+
+	ret = -EFAULT;
+	if (get_user(npc, unpc) || get_user(status, ustatus))
+		goto out;
+
+	ret = -EINVAL;
+	if (filp->f_vfsmnt->mnt_sb->s_magic != SPUFS_MAGIC)
+		goto out_fput;
+
+	i = SPUFS_I(filp->f_dentry->d_inode);
+	/*
+	 * In order to call the underlying spu_run operation, we have the
+	 * function pointer as part of our inode info. This is anything but
+	 * nice, but it helps to avoid registering a global function pointer
+	 * at module load time, which would be even worse imho.
+	 */
+	if (!i->i_spu_run)
+		goto out_fput;
+	ret = i->i_spu_run(filp, i->i_ctx, &npc, &status);
+
+	if (put_user(npc, unpc))
+		ret = -EFAULT;
+
+out_fput:
+	fput_light(filp, fput_needed);
+out:
+	return ret;
+}
--- linux-cg.orig/include/asm-ppc/unistd.h	2005-08-25 23:12:31.265915576 -0400
+++ linux-cg/include/asm-ppc/unistd.h	2005-08-25 23:12:36.586905392 -0400
@@ -282,8 +282,9 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_spu_run		278
 
-#define __NR_syscalls		278
+#define __NR_syscalls		279
 
 #define __NR(n)	#n
 
--- linux-cg.orig/include/asm-ppc64/unistd.h	2005-08-25 23:12:31.268915120 -0400
+++ linux-cg/include/asm-ppc64/unistd.h	2005-08-25 23:12:36.586905392 -0400
@@ -288,8 +288,9 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_spu_run		278
+#define __NR_syscalls		279
 
-#define __NR_syscalls		278
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
--- linux-cg.orig/include/linux/syscalls.h	2005-08-25 23:12:31.270914816 -0400
+++ linux-cg/include/linux/syscalls.h	2005-08-25 23:12:36.587905240 -0400
@@ -509,4 +509,7 @@ asmlinkage long sys_keyctl(int cmd, unsi
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
 
+asmlinkage long sys_spu_run(int fd, __u32 __user *unpc,
+				 __u32 __user *ustatus);
+
 #endif
--- linux-cg.orig/kernel/sys_ni.c	2005-08-25 23:12:31.272914512 -0400
+++ linux-cg/kernel/sys_ni.c	2005-08-25 23:12:36.588905088 -0400
@@ -90,3 +90,4 @@ cond_syscall(sys_pciconfig_iobase);
 cond_syscall(sys32_ipc);
 cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
+cond_syscall(sys_spu_run);

