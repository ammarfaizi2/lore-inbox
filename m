Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310212AbSCPKRR>; Sat, 16 Mar 2002 05:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310213AbSCPKRH>; Sat, 16 Mar 2002 05:17:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61118 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310212AbSCPKQ7>;
	Sat, 16 Mar 2002 05:16:59 -0500
Date: Sat, 16 Mar 2002 05:16:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined reference
 to `sys_nfsservctl'
In-Reply-To: <Pine.GSO.4.21.0203160317490.4093-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0203160515240.5891-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Alexander Viro wrote:

> On 16 Mar 2002, Miles Lane wrote:
> 
> > arch/i386/kernel/kernel.o: In function `sys_call_table':
> > arch/i386/kernel/kernel.o(.data+0x300): undefined reference to
> > `sys_nfsservctl'
> 
> Fix: add a weak alias sys_nfsservctl -> sys_ni_syscall in kernel/sys.c.
> While we are at it, the same can be done with sys_quotactl() - I suspect
> that fs/noqout.c can be killed.

It can.  Linus, what do you think about the following variant?

diff -urN C7-pre2/fs/Makefile C7-pre2-current/fs/Makefile
--- C7-pre2/fs/Makefile	Fri Mar 15 22:22:35 2002
+++ C7-pre2-current/fs/Makefile	Sat Mar 16 04:24:26 2002
@@ -16,12 +16,6 @@
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o
 
-ifeq ($(CONFIG_QUOTA),y)
-obj-y += dquot.o
-else
-obj-y += noquot.o
-endif
-
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
 obj-y += nfsctl.o
@@ -84,6 +78,8 @@
 obj-y				+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
+
+obj-$(CONFIG_QUOTA) += dquot.o
 
 # persistent filesystems
 obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))
diff -urN C7-pre2/fs/dquot.c C7-pre2-current/fs/dquot.c
--- C7-pre2/fs/dquot.c	Tue Feb 19 22:33:03 2002
+++ C7-pre2-current/fs/dquot.c	Sat Mar 16 04:45:14 2002
@@ -59,6 +59,7 @@
 #include <linux/tty.h>
 #include <linux/file.h>
 #include <linux/slab.h>
+#include <linux/sysctl.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 
@@ -1240,9 +1241,22 @@
 	return ret;
 }
 
+static ctl_table fs_table[] = {
+	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
+	 0444, NULL, &proc_dointvec},
+	{},
+};
+
+static ctl_table dquot_table[] = {
+	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
+	{},
+};
+
 static int __init dquot_init(void)
 {
 	int i;
+
+	register_sysctl_table(dquot_table, 0);
 
 	for (i = 0; i < NR_DQHASH; i++)
 		INIT_LIST_HEAD(dquot_hash + i);
diff -urN C7-pre2/fs/noquot.c C7-pre2-current/fs/noquot.c
--- C7-pre2/fs/noquot.c	Fri May 12 14:21:20 2000
+++ C7-pre2-current/fs/noquot.c	Sat Mar 16 04:18:29 2002
@@ -2,14 +2,4 @@
  *           compiled into the kernel.
  */
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-
 int nr_dquots, nr_free_dquots;
-int max_dquots;
-
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return(-ENOSYS);
-}
diff -urN C7-pre2/include/linux/quota.h C7-pre2-current/include/linux/quota.h
--- C7-pre2/include/linux/quota.h	Mon Jan 14 23:13:52 2002
+++ C7-pre2-current/include/linux/quota.h	Sat Mar 16 04:23:01 2002
@@ -144,7 +144,6 @@
 
 #ifdef __KERNEL__
 
-extern int nr_dquots, nr_free_dquots;
 extern int dquot_root_squash;
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
diff -urN C7-pre2/kernel/sys.c C7-pre2-current/kernel/sys.c
--- C7-pre2/kernel/sys.c	Fri Mar 15 22:22:40 2002
+++ C7-pre2-current/kernel/sys.c	Sat Mar 16 03:43:14 2002
@@ -173,6 +173,11 @@
 	return -ENOSYS;
 }
 
+/* "Conditional" syscalls */
+
+asmlinkage long sys_nfsservctl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+asmlinkage long sys_quotactl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+
 static int proc_sel(struct task_struct *p, int which, int who)
 {
 	if(p->pid)
diff -urN C7-pre2/kernel/sysctl.c C7-pre2-current/kernel/sysctl.c
--- C7-pre2/kernel/sysctl.c	Tue Feb 19 22:33:08 2002
+++ C7-pre2-current/kernel/sysctl.c	Sat Mar 16 04:22:45 2002
@@ -284,8 +284,6 @@
 	 0444, NULL, &proc_dointvec},
 	{FS_MAXFILE, "file-max", &files_stat.max_files, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
-	 0444, NULL, &proc_dointvec},
 	{FS_DENTRY, "dentry-state", &dentry_stat, 6*sizeof(int),
 	 0444, NULL, &proc_dointvec},
 	{FS_OVERFLOWUID, "overflowuid", &fs_overflowuid, sizeof(int), 0644, NULL,

