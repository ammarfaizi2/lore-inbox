Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313450AbSC2OyH>; Fri, 29 Mar 2002 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313451AbSC2Ox5>; Fri, 29 Mar 2002 09:53:57 -0500
Received: from isis.telemach.net ([213.143.65.10]:36107 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S313450AbSC2Oxq>;
	Fri, 29 Mar 2002 09:53:46 -0500
Date: Fri, 29 Mar 2002 15:54:38 +0100
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: rem@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Compile problems with 2.5.7
Message-Id: <20020329155438.3fcdc054.Gregor.Fajdiga@telemach.net>
In-Reply-To: <006201c1d729$a7fa1520$41448fd5@telemach.net>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

> >
> > Hi,
> >
> > Sorry to be so long getting back to you.  I've tried everything I can
> > think of to reproduce this but haven't been able to.

I'm sorry I didn't get back to you sooner too. I'm in the boarding school 
during the week and can use e-mail only at weekends ;-)

> >
> > So could you:
> >
> > 1.) Let me know which version of gcc you're using (cc --version).

[grega@tm-68-65 linux-2.5.7]$ gcc --version 
3.0.3

[grega@tm-68-65 linux-2.5.7]$ ld --version
GNU ld 2.10.91
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
  Supported emulations:
   elf_i386
   i386linux
   elf_i386_glibc21


> >
> > 2.) Verify that kernel/acct.c compile line looks like (the path for
> >     the -I line will match your machine):
> >
> > gcc -D__KERNEL__ -I/home/rem/views/linux-2.5.7-orig/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=i586  -DKBUILD_BASENAME=acct  -c -o kernel/acct.o kernel/acct.c

The path is correct.

> >
> > 3.) Use this compile line (substitute your path for ${YOUR_PATH}):
> >
> > gcc -E -D__KERNEL__ -I${YOUR_PATH}/linux-2.5.7-orig/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=i586  -DKBUILD_BASENAME=acct  -c -o kernel/acct.o kernel/acct.c
> >

Not neccessary. See above.

> > 4.) E-mail me the kernel/acct.c and kernel/acct.o (BTW the kernel/acct.o
> >     is not really an object file but the output of cpp).

As I have already said, the only patch I use is 0-aliases-c-C7-pre2 by Al 
Viro. It makes the kernel compile without NFS support, which I don't need.
The patch follows:

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
+++ C7-pre2-current/fs/noquot.c	Wed Dec 31 19:00:00 1969
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
diff -urN C7-pre2/include/linux/quota.h C7-pre2-current/include/linux/quota.h
--- C7-pre2/include/linux/quota.h	Mon Jan 14 23:13:52 2002
+++ C7-pre2-current/include/linux/quota.h	Sat Mar 16 04:23:01 2002
@@ -144,7 +144,6 @@
 
 #ifdef __KERNEL__
 
-extern int nr_dquots, nr_free_dquots;
 extern int dquot_root_squash;
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
diff -urN C7-pre2/kernel/Makefile C7-pre2-current/kernel/Makefile
--- C7-pre2/kernel/Makefile	Fri Mar 15 22:22:40 2002
+++ C7-pre2-current/kernel/Makefile	Sat Mar 16 05:43:10 2002
@@ -20,6 +20,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_CONFIG_BSD_PROCESS_ACCT) += acct.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN C7-pre2/kernel/acct.c C7-pre2-current/kernel/acct.c
--- C7-pre2/kernel/acct.c	Fri Mar 15 22:22:40 2002
+++ C7-pre2-current/kernel/acct.c	Sat Mar 16 05:47:40 2002
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
diff -urN C7-pre2/kernel/sys.c C7-pre2-current/kernel/sys.c
--- C7-pre2/kernel/sys.c	Fri Mar 15 22:22:40 2002
+++ C7-pre2-current/kernel/sys.c	Sat Mar 16 05:42:26 2002
@@ -173,6 +173,12 @@
 	return -ENOSYS;
 }
 
+/* "Conditional" syscalls */
+
+asmlinkage long sys_nfsservctl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+asmlinkage long sys_quotactl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
+asmlinkage long sys_acct(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
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

As you can see it touches the acct.c file. I'm not a hacker, so I don't know what it does.

Best Regards,

Grega Fajdiga 
