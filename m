Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSCaHyi>; Sun, 31 Mar 2002 02:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSCaHy2>; Sun, 31 Mar 2002 02:54:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35237 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312410AbSCaHyP>;
	Sun, 31 Mar 2002 02:54:15 -0500
Date: Sun, 31 Mar 2002 02:54:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: tim@birdsnest.maths.tcd.ie, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: <20020330.182243.88963096.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0203310253360.4431-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Mar 2002, David S. Miller wrote:

>    From: Alexander Viro <viro@math.psu.edu>
>    Date: Sat, 30 Mar 2002 18:41:46 -0500 (EST)
>    
>    	Dave, you've mentioned doing the equivalent of
>    __attribute__((weak,alias("foo")) by hand.  Could you give an example?
>    
> 
> #define make_weak(foo,bar)	__asm__(".weak foo, bar")
> 
> Or however the assembler syntax works.  GLIBC has some header file it
> at least used to use which had macros doing something similar.

OK...  How about the following?

diff -urN C7-0/fs/Makefile C7-1/fs/Makefile
--- C7-0/fs/Makefile	Tue Mar 19 16:05:56 2002
+++ C7-1/fs/Makefile	Sun Mar 31 02:52:35 2002
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
diff -urN C7-0/fs/dquot.c C7-1/fs/dquot.c
--- C7-0/fs/dquot.c	Tue Feb 19 22:33:03 2002
+++ C7-1/fs/dquot.c	Sun Mar 31 02:52:35 2002
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
diff -urN C7-0/fs/noquot.c C7-1/fs/noquot.c
--- C7-0/fs/noquot.c	Fri May 12 14:21:20 2000
+++ C7-1/fs/noquot.c	Wed Dec 31 19:00:00 1969
@@ -1,15 +0,0 @@
-/* noquot.c: Quota stubs necessary for when quotas are not
- *           compiled into the kernel.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-
-int nr_dquots, nr_free_dquots;
-int max_dquots;
-
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return(-ENOSYS);
-}
diff -urN C7-0/include/linux/quota.h C7-1/include/linux/quota.h
--- C7-0/include/linux/quota.h	Mon Jan 14 23:13:52 2002
+++ C7-1/include/linux/quota.h	Sun Mar 31 02:52:35 2002
@@ -144,7 +144,6 @@
 
 #ifdef __KERNEL__
 
-extern int nr_dquots, nr_free_dquots;
 extern int dquot_root_squash;
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
diff -urN C7-0/kernel/Makefile C7-1/kernel/Makefile
--- C7-0/kernel/Makefile	Tue Mar 19 16:06:01 2002
+++ C7-1/kernel/Makefile	Sun Mar 31 02:52:35 2002
@@ -14,12 +14,13 @@
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
-	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN C7-0/kernel/acct.c C7-1/kernel/acct.c
--- C7-0/kernel/acct.c	Tue Mar 19 16:06:01 2002
+++ C7-1/kernel/acct.c	Sun Mar 31 02:52:35 2002
@@ -44,17 +44,11 @@
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-
-#ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acct.h>
-#include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/tty.h>
-
 #include <asm/uaccess.h>
 
 /*
@@ -397,15 +391,3 @@
 		spin_unlock(&acct_globals.lock);
 	return 0;
 }
-
-#else
-/*
- * Dummy system call when BSD process accounting is not configured
- * into the kernel.
- */
-
-asmlinkage long sys_acct(const char * filename)
-{
-	return -ENOSYS;
-}
-#endif
diff -urN C7-0/kernel/exit.c C7-1/kernel/exit.c
--- C7-0/kernel/exit.c	Tue Mar 19 16:06:01 2002
+++ C7-1/kernel/exit.c	Sun Mar 31 02:52:35 2002
@@ -14,9 +14,7 @@
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/namespace.h>
-#ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
-#endif
 #include <linux/file.h>
 #include <linux/binfmts.h>
 
@@ -493,9 +491,7 @@
 	del_timer_sync(&tsk->real_timer);
 
 fake_volatile:
-#ifdef CONFIG_BSD_PROCESS_ACCT
 	acct_process(code);
-#endif
 	__exit_mm(tsk);
 
 	lock_kernel();
diff -urN C7-0/kernel/sys.c C7-1/kernel/sys.c
--- C7-0/kernel/sys.c	Tue Mar 19 16:06:01 2002
+++ C7-1/kernel/sys.c	Sun Mar 31 02:52:49 2002
@@ -173,6 +173,18 @@
 	return -ENOSYS;
 }
 
+/*
+ * "Conditional" syscalls
+ *
+ * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
+ * but it doesn't work on sparc64, so we just do it by hand
+ */
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+
+cond_syscall(sys_nfsservctl)
+cond_syscall(sys_quotactl)
+cond_syscall(sys_acct)
+
 static int proc_sel(struct task_struct *p, int which, int who)
 {
 	if(p->pid)
diff -urN C7-0/kernel/sysctl.c C7-1/kernel/sysctl.c
--- C7-0/kernel/sysctl.c	Tue Feb 19 22:33:08 2002
+++ C7-1/kernel/sysctl.c	Sun Mar 31 02:52:35 2002
@@ -284,8 +284,6 @@
 	 0444, NULL, &proc_dointvec},
 	{FS_MAXFILE, "file-max", &files_stat.max_files, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
-	 0444, NULL, &proc_dointvec},
 	{FS_DENTRY, "dentry-state", &dentry_stat, 6*sizeof(int),
 	 0444, NULL, &proc_dointvec},
 	{FS_OVERFLOWUID, "overflowuid", &fs_overflowuid, sizeof(int), 0644, NULL,

