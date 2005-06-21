Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVFUWAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVFUWAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVFUV7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:59:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41663 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262557AbVFUVja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/11] spufs: Use a system call instead of ioctl
Date: Tue, 21 Jun 2005 23:31:59 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <200506212310.54156.arnd@arndb.de> <200506212328.28929.arnd@arndb.de> <200506212330.06734.arnd@arndb.de>
In-Reply-To: <200506212330.06734.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212331.59883.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to use a system call instead of
an ioctl to run spu code on spufs.

This is mostly for review, to see how ugly it gets. I personally
don't like the ioctl implementation very much, but haven't
come up with the best solution. The system call doesn't appear
to be much better than ioctl here.

One other solution that I haven't implemented yet would be an
interface that returns a struct { __u32 npc; __u32 status; };
with the help of a read system call and uses lseek to update
the npc value. That would require some knowledge about
status code in the kernel if we want to avoid calling lseek
every time an SPU does a callback that returns to the owning
thread.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--
 arch/ppc64/kernel/misc.S   |    2 
 fs/spufs/Makefile          |    3 +
 fs/spufs/file.c            |   12 +++++
 fs/spufs/spu_run.c         |   96 +++++++++++++++++++++++++++++++++++++++++++++
 fs/spufs/spufs.h           |    2 
 include/asm-ppc/unistd.h   |    3 -
 include/asm-ppc64/unistd.h |    3 -
 include/linux/syscalls.h   |    3 +
 kernel/sys_ni.c            |    1 
 9 files changed, 122 insertions(+), 3 deletions(-)

--- linux-cg.orig/arch/ppc64/kernel/misc.S	2005-06-21 22:48:52.323893000 -0400
+++ linux-cg/arch/ppc64/kernel/misc.S	2005-06-21 22:51:43.412976752 -0400
@@ -956,6 +956,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys32_request_key
 	.llong .compat_sys_keyctl
 	.llong .compat_sys_waitid
+	.llong .sys_spu_run
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1232,3 +1233,4 @@ _GLOBAL(sys_call_table)
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
 	.llong .sys_waitid
+	.llong .sys_spu_run
--- linux-cg.orig/fs/spufs/Makefile	2005-06-21 22:48:52.326892544 -0400
+++ linux-cg/fs/spufs/Makefile	2005-06-21 22:51:43.413976600 -0400
@@ -1,2 +1,5 @@
 obj-$(CONFIG_SPU_FS) += spufs.o
+syscall-$(CONFIG_SPU_FS) += spu_run.o
+
+obj-y += $(syscall-y) $(syscall-m)
 spufs-y += inode.o file.o
--- linux-cg.orig/fs/spufs/file.c	2005-06-21 22:50:20.599920208 -0400
+++ linux-cg/fs/spufs/file.c	2005-06-21 22:51:56.088914672 -0400
@@ -343,6 +343,16 @@ out:
 	return ret;
 }
 
+static int spufs_run_open(struct inode *inode, struct file *file)
+{
+        struct spufs_inode_info *i = SPUFS_I(inode);
+        file->private_data = i->i_ctx;
+
+	i->i_spu_run = spufs_run_spu;
+
+	return nonseekable_open(inode, file);
+}
+
 struct spufs_run_arg {
 	u32 npc;    /* inout: Next Program Counter */
 	u32 status; /* out:   SPU status */
@@ -371,7 +381,7 @@ static long spufs_run_ioctl(struct file 
 }
 
 static struct file_operations spufs_run_fops = {
-	.open		= spufs_pipe_open,
+	.open		= spufs_run_open,
 	.unlocked_ioctl	= spufs_run_ioctl,
 	.compat_ioctl	= spufs_run_ioctl,
 };
--- linux-cg.orig/fs/spufs/spu_run.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_run.c	2005-06-21 22:51:43.414976448 -0400
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
--- linux-cg.orig/fs/spufs/spufs.h	2005-06-21 22:49:22.676938600 -0400
+++ linux-cg/fs/spufs/spufs.h	2005-06-21 22:51:56.798938904 -0400
@@ -42,6 +42,8 @@ struct spu_context {
 
 struct spufs_inode_info {
 	struct spu_context *i_ctx;
+	long (*i_spu_run)(struct file *filp, struct spu_context *ctx,
+		u32 *npc, u32 *result);
 	struct inode vfs_inode;
 };
 #define SPUFS_I(inode) container_of(inode, struct spufs_inode_info, vfs_inode)
--- linux-cg.orig/include/asm-ppc/unistd.h	2005-06-21 22:48:52.330891936 -0400
+++ linux-cg/include/asm-ppc/unistd.h	2005-06-21 22:51:43.414976448 -0400
@@ -277,8 +277,9 @@
 #define __NR_request_key	270
 #define __NR_keyctl		271
 #define __NR_waitid		272
+#define __NR_spu_run		273
 
-#define __NR_syscalls		273
+#define __NR_syscalls		274
 
 #define __NR(n)	#n
 
--- linux-cg.orig/include/asm-ppc64/unistd.h	2005-06-21 22:48:52.332891632 -0400
+++ linux-cg/include/asm-ppc64/unistd.h	2005-06-21 22:51:43.415976296 -0400
@@ -283,8 +283,9 @@
 #define __NR_request_key	270
 #define __NR_keyctl		271
 #define __NR_waitid		272
+#define __NR_spu_run		273
 
-#define __NR_syscalls		273
+#define __NR_syscalls		274
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
--- linux-cg.orig/include/linux/syscalls.h	2005-06-21 22:48:52.335891176 -0400
+++ linux-cg/include/linux/syscalls.h	2005-06-21 22:51:43.416976144 -0400
@@ -505,4 +505,7 @@ asmlinkage long sys_request_key(const ch
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
+asmlinkage long sys_spu_run(int fd, __u32 __user *unpc,
+				 __u32 __user *ustatus);
+
 #endif
--- linux-cg.orig/kernel/sys_ni.c	2005-06-21 22:48:52.337890872 -0400
+++ linux-cg/kernel/sys_ni.c	2005-06-21 22:51:43.417975992 -0400
@@ -85,3 +85,4 @@ cond_syscall(sys_pciconfig_iobase);
 cond_syscall(sys32_ipc);
 cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
+cond_syscall(sys_spu_run);

