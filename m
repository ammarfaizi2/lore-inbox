Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263916AbUDVK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbUDVK7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbUDVK7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:59:35 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:33485 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S263916AbUDVKye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:54:34 -0400
Date: Thu, 22 Apr 2004 12:54:24 +0200 (MET DST)
Message-Id: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Andrew Morton <akpm@osdl.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] fmount system call 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

This patch adds a new fmount() system call, which is exactly the same
as mount(), except the second parameter (mount target) is a file
descriptor instead of a path.

The main advantage is that caller can check permissions on target
without rename races.  This can be done without fmount(), by doing
chdir() + mount("."), but this only works for directories and uses the
CWD which can be slightly tricky to restore.

Would this be acceptable for inclusion into the main kernel?

I've only added the syscall to i386.  What is the policy wrt adding
syscalls to other archs?  Me or the architecure maintainer is
responsible?

The patch applies against 2.6.6-rc2 and 2.6.6-rc2-mm1.

A test program is included after the patch, which mounts filesystem or
bind mounts file/directory on stdin.  Compiling it after patching the
kernel:

  gcc -I/lib/modules/`uname -r`/build/include fmount.c -o fmount

Miklos

===File ~/tmp/fmount-2.6.6-rc2.patch========================
diff -Nurp linux-2.6.6-rc2.orig/arch/i386/kernel/entry.S linux-2.6.6-rc2/arch/i386/kernel/entry.S
--- linux-2.6.6-rc2.orig/arch/i386/kernel/entry.S	2004-04-22 11:44:54.000000000 +0200
+++ linux-2.6.6-rc2/arch/i386/kernel/entry.S	2004-04-22 12:07:41.000000000 +0200
@@ -891,5 +891,6 @@ ENTRY(sys_call_table)
 	.long sys_mq_timedreceive	/* 280 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
+	.long sys_fmount
 
 syscall_table_size=(.-sys_call_table)
diff -Nurp linux-2.6.6-rc2.orig/fs/namespace.c linux-2.6.6-rc2/fs/namespace.c
--- linux-2.6.6-rc2.orig/fs/namespace.c	2004-04-22 11:45:15.000000000 +0200
+++ linux-2.6.6-rc2/fs/namespace.c	2004-04-22 12:06:09.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/file.h>
 #include <asm/uaccess.h>
 
 extern int __init init_rootfs(void);
@@ -735,6 +736,47 @@ int copy_mount_options (const void __use
 	return 0;
 }
 
+static int dentry_mount(char *dev_name, struct nameidata *nd,
+			       char *type_page,	unsigned int flags,
+			       void *data_page)
+{
+	int retval;
+	int mnt_flags = 0;
+
+	/* Basic sanity checks */
+	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
+		return -EINVAL;
+
+	if (data_page)
+		((char *)data_page)[PAGE_SIZE - 1] = 0;
+
+	/* Separate the per-mountpoint flags */
+	if (flags & MS_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (flags & MS_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (flags & MS_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
+
+	retval = security_sb_mount(dev_name, nd, type_page, flags, data_page);
+	if (retval)
+		return retval;
+
+	if (flags & MS_REMOUNT)
+		retval = do_remount(nd, flags & ~MS_REMOUNT, mnt_flags,
+				    data_page);
+	else if (flags & MS_BIND)
+		retval = do_loopback(nd, dev_name, flags & MS_REC);
+	else if (flags & MS_MOVE)
+		retval = do_move_mount(nd, dev_name);
+	else
+		retval = do_add_mount(nd, type_page, flags, mnt_flags,
+				      dev_name, data_page);
+
+	return retval;
+}
+
 /*
  * Flags is a 32-bit value that allows up to 31 non-fs dependent flags to
  * be given to the mount() call (ie: read-only, no-dev, no-suid etc).
@@ -753,8 +795,7 @@ long do_mount(char * dev_name, char * di
 		  unsigned long flags, void *data_page)
 {
 	struct nameidata nd;
-	int retval = 0;
-	int mnt_flags = 0;
+	int retval;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -764,41 +805,13 @@ long do_mount(char * dev_name, char * di
 
 	if (!dir_name || !*dir_name || !memchr(dir_name, 0, PAGE_SIZE))
 		return -EINVAL;
-	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
-		return -EINVAL;
-
-	if (data_page)
-		((char *)data_page)[PAGE_SIZE - 1] = 0;
-
-	/* Separate the per-mountpoint flags */
-	if (flags & MS_NOSUID)
-		mnt_flags |= MNT_NOSUID;
-	if (flags & MS_NODEV)
-		mnt_flags |= MNT_NODEV;
-	if (flags & MS_NOEXEC)
-		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
 	if (retval)
 		return retval;
 
-	retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page);
-	if (retval)
-		goto dput_out;
-
-	if (flags & MS_REMOUNT)
-		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
-				    data_page);
-	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & MS_MOVE)
-		retval = do_move_mount(&nd, dev_name);
-	else
-		retval = do_add_mount(&nd, type_page, flags, mnt_flags,
-				      dev_name, data_page);
-dput_out:
+	retval = dentry_mount(dev_name, &nd, type_page, flags, data_page);
 	path_release(&nd);
 	return retval;
 }
@@ -929,6 +942,51 @@ out1:
 	return retval;
 }
 
+asmlinkage long sys_fmount(char __user * dev_name, unsigned int fd,
+			   char __user * type, unsigned long flags,
+			   void __user * data)
+{
+	int retval;
+	unsigned long data_page;
+	unsigned long type_page;
+	unsigned long dev_page;
+	struct file *file;
+	struct nameidata nd;
+	
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	nd.dentry = file->f_dentry;
+	nd.mnt = file->f_vfsmnt;
+
+	retval = copy_mount_options (type, &type_page);
+	if (retval < 0)
+		goto out1;
+
+	retval = copy_mount_options (dev_name, &dev_page);
+	if (retval < 0)
+		goto out2;
+
+	retval = copy_mount_options (data, &data_page);
+	if (retval < 0)
+		goto out3;
+
+	lock_kernel();
+	retval = dentry_mount((char*)dev_page, &nd, (char*)type_page,
+			  flags, (void*)data_page);
+	unlock_kernel();
+	free_page(data_page);
+
+out3:
+	free_page(dev_page);
+out2:
+	free_page(type_page);
+out1:
+	fput(file);
+	return retval;
+}
+
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
diff -Nurp linux-2.6.6-rc2.orig/include/asm-i386/unistd.h linux-2.6.6-rc2/include/asm-i386/unistd.h
--- linux-2.6.6-rc2.orig/include/asm-i386/unistd.h	2004-04-22 11:45:17.000000000 +0200
+++ linux-2.6.6-rc2/include/asm-i386/unistd.h	2004-04-22 12:08:49.000000000 +0200
@@ -288,8 +288,9 @@
 #define __NR_mq_timedreceive	(__NR_mq_open+3)
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
+#define __NR_fmount		283
 
-#define NR_syscalls 283
+#define NR_syscalls 284
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nurp linux-2.6.6-rc2.orig/include/linux/syscalls.h linux-2.6.6-rc2/include/linux/syscalls.h
--- linux-2.6.6-rc2.orig/include/linux/syscalls.h	2004-04-22 11:45:21.000000000 +0200
+++ linux-2.6.6-rc2/include/linux/syscalls.h	2004-04-22 11:56:08.000000000 +0200
@@ -192,6 +192,9 @@ asmlinkage long sys_bdflush(int func, lo
 asmlinkage long sys_mount(char __user *dev_name, char __user *dir_name,
 				char __user *type, unsigned long flags,
 				void __user *data);
+asmlinkage long sys_fmount(char __user * dev_name, unsigned int fd,
+				char __user * type, unsigned long flags,
+				void __user * data);
 asmlinkage long sys_umount(char __user *name, int flags);
 asmlinkage long sys_oldumount(char __user *name);
 asmlinkage long sys_truncate(const char __user *path,
============================================================


===File ~/cc/fmount.c=======================================
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <linux/unistd.h>
#include <sys/mount.h>

int syscall(int, ...);

static void usage(char *progname)
{
    fprintf(stderr, "usage: %s [--bind] type dev\n", progname);
    exit(1);
}

int main(int argc, char *argv[])
{
    int res;
    char *type;
    char *dev;
    int ctr;
    int flags = 0;
  
    if(argc < 3 || strcmp(argv[1], "-h") == 0)
        usage(argv[0]);

    ctr = 1;
    if (strcmp(argv[ctr], "--bind") == 0) {
            flags |= MS_BIND;
            ctr ++;
    }
    if(argc - ctr < 2)
            usage(argv[0]);
    type = argv[ctr++];
    dev = argv[ctr++];
    res = syscall(__NR_fmount, dev, 0, type, flags, NULL);
    if(res == -1) {
        perror("mount failed");
        exit(1);
    }
    return 0;
}
============================================================
