Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUHVDez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUHVDez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 23:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUHVDez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 23:34:55 -0400
Received: from mx-00.sil.at ([62.116.68.196]:33299 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id S265932AbUHVDeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 23:34:06 -0400
Subject: Nonotify 0.3.2 (A simple dnotify replacement)
From: nf <nf2@scheinwelt.at>
Reply-To: nf2@scheinwelt.at
To: kernel mailing list <linux-kernel@vger.kernel.org>,
       Nautilus mailing <nautilus-list@gnome.org>
Content-Type: multipart/mixed; boundary="=-C7YySO6wob6c2MI0eSPg"
Message-Id: <1093145821.4578.20.camel@lilota.lamp.priv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2mdk 
Date: Sun, 22 Aug 2004 05:37:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C7YySO6wob6c2MI0eSPg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi list, 

I have finished a new version of nonotify, it uses ioctl instead of
manipulating the stat() structure.

Norbert


the README:
-------------------------------------------

NONOTIFY 

... is a simple dnotify replacement to make polling for directory
content changes more efficient.

The basic idea is that any write-access to a file will set a special
'contents_mtime' (directory contents modification time) field in the
inode object of the parent directory. Any application interested in
directory content changes - a filemanager for instance - just has to
poll this 'contents_mtime' field to find out if it has to reread the
whole directory.


1) Reasons for Nonotify: 

-) It does not (or hardly ever) block umount. Umount blocking by
fam&dnotify has been really annoying for linux desktop users for quite a
long time, and that was the main reason why i wrote Nonotify.

-) Polling in a fixed interval takes less resources than change
notification when the filesystem is busy (writing files for instance).
Change notification is quite time consuming, which can be easily
demonstrated by running the following command in a directory beeing
watched by fam/dnotify:

$ time bash -c "for ((a=1;a<100000;a++)); do echo \"test $a\"; done >
test.txt"

with fam: 0:30.44elapsed 12%CPU (the rest goes to fam 45% and nautilus
40%)
without fam: 0:03.47elapsed 98%CPU

... dnotify slows down file operations by factor 10!!! (This is a
'worst-case' example, but under normal conditions - not flushing the
buffers for every line - i experienced slowing down file writing by
about factor 2 - which is still quite bad).

I suppose that all notification based mechanisms cause similar problems,
because they generate fireworks of events when a file is beeing written.

-) GUI applications can hardly ever respond to all the events recieved
from notification based mechanisms (that would cause terrible
flickering). Therefore such systems (like dnotify and inotify) always
require special timers to gather events in user-space: That means
polling event queues in the client - so why not just poll the filesystem
directly?

-) Simplicity: Nonotify does not pin down inodes (which dnotify achieves
with open file-handles and inotify with watcher-counters - AFAIK):

When an inode object gets dropped and reallocated by the kernel, the
"i_dcontents_mtime" field is initialized to the current time. In this
case a nonotify-client will reread the directory although there were no
changes - but this will not happen very often (Because of inode caching
in kernel memory).


2) The /dev/nonotify device:

/dev/nonotify has the only purpose to offer a special stat() call via
ioctl to read the contents_mtime field of directories (together with
atime, mtime, ctime). The client has to set the 'filename' field of the
'nonotify_stat' structure and receives the four timespec fields updated
via ioctl.

struct nonotify_stat {
	char *filename;
	struct timespec atime;
	struct timespec	mtime;
	struct timespec	ctime;
	struct timespec	contents_mtime;
};


3) The nonostat utility:

  $ echo blabla >> /tmp/notest
  $ nonostat /tmp
  Nonotify Stat : Success
  atime            Sun Aug 22 04:15:16 2004; nsecs=818102656
  mtime            Sun Aug 22 04:25:26 2004; nsecs=790149821
  ctime            Sun Aug 22 04:25:26 2004; nsecs=790149821
  dcontents_mtime  Sun Aug 22 04:25:26 2004; nsecs=790149821

  $ echo blabla >> /tmp/notest
  $ nonostat /tmp
  Nonotify Stat : Success
  atime            Sun Aug 22 04:15:16 2004; nsecs=818102656
  mtime            Sun Aug 22 04:25:26 2004; nsecs=790149821
  ctime            Sun Aug 22 04:25:26 2004; nsecs=790149821
  dcontents_mtime  Sun Aug 22 04:25:37 2004; nsecs=232959250

This example shows the output of 'nonostat' after creating and appending
to the file '/tmp/notest'. You can see that only dcontents_mtime has
changed after appending to the file.


4) Open questions:

- Automounters: Polling might cause problems with automounters, because
stat() calls can cause a remount in case a device is not mounted. (See
the supermount-faq for instance). 
--> Perhaps automounters should not mount on 'nonotify_stat'-calls
(special flag?)
--> Or better: Have a 'contents_mtime' field per device - in this case
there would be no necessity to poll directories on an idle device. This
would also avoid the (almost negligible anyway) umount blocking by
nonotify_stat calls.

- Tick-less systems: Josef Weidendorfer pointed out that polling has the
disadvantage of causing activity on a sleeping system.

- Hardlinks: Nonotify can not detect all changes in files which have
mulitple references (via hardlinks). I think dnotify has the same
problem.


5) Other related issues:

- Nonotify can improve the situation for clean umounting (with no open
files), but to make the linux desktop work, something like a functioning
"umount -f", to detach and invalidate filehandles from the outside
instantly, is still essential. (IFAIK only supermount can do that at the
moment). 


6) Other attempts to handle directory change notification without umount
blocking:

Inotify: A sophisticated event based system for directory change
notification. Nonotify does not try to compete with Inotify, but rather
offer a very basic light-weight alternative.


7) Changes:

0.3.1: Use of ioctl() /dev/nonotify for reading the 'contents_mtime'
field. (Changing the stat() syscall would break glibc compatibility).
0.3.2: Code cleanup and documentation.



--=-C7YySO6wob6c2MI0eSPg
Content-Disposition: attachment; filename=nonostat.c
Content-Type: text/x-csrc; name=nonostat.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
*
* Nonotify Stat (nonostat.c):
* Reads atime, mtime, ctime and contents_mtime from a directory.
* Uses ioctl on /dev/nonotify to obtain this data.
*
*/
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/nonotify.h> // don't forget to copy nonotify.h to /usr/include/linux !!


int main(int argc, char *argv[]) {

	struct nonotify_stat nost;
	int wd;
	int fd;

	if (argc <= 1) {
		fprintf(stderr, "Usage: nonostat directory-path\n");
		return 1;
	}

	nost.filename = argv[1];

	fd = open("/dev/nonotify", O_RDONLY);

	if (fd < 0) {
		perror ("open(\"/dev/nonotify\", O_RDONLY) = ");
		return 1;
	}


	wd = ioctl(fd, NONOTIFY_STAT , &nost);

	perror("Nonotify Stat ");

	if (!wd) {

		printf("atime            %s; nsecs=%09ld\n"
			, strtok(ctime(&nost.atime.tv_sec), "\n")
			, nost.atime.tv_nsec);

		printf("mtime            %s; nsecs=%09ld\n"
			, strtok(ctime(&nost.mtime.tv_sec), "\n")
			, nost.mtime.tv_nsec);

		printf("ctime            %s; nsecs=%09ld\n"
			, strtok(ctime(&nost.ctime.tv_sec), "\n")
			, nost.ctime.tv_nsec);

		printf("dcontents_mtime  %s; nsecs=%09ld\n"
			, strtok(ctime(&nost.contents_mtime.tv_sec), "\n")
			, nost.contents_mtime.tv_nsec);
	}

	return wd;
}




--=-C7YySO6wob6c2MI0eSPg
Content-Disposition: attachment; filename=nonotify_0.3.2.patch
Content-Type: text/x-patch; name=nonotify_0.3.2.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/attr.c	2004-08-16 02:54:45.000000000 +0200
+++ /usr/src/linux/fs/attr.c	2004-08-15 22:04:28.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/nonotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -185,8 +186,10 @@
 	}
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
-		if (dn_mask)
+		if (dn_mask) {
 			dnotify_parent(dentry, dn_mask);
+		}
+		nonotify_parent(dentry);
 	}
 	return error;
 }
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/inode.c	2004-08-16 02:51:39.000000000 +0200
+++ /usr/src/linux/fs/inode.c	2004-08-15 22:04:28.000000000 +0200
@@ -166,6 +166,9 @@
 		}
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
+
+		/* Nonotify: Initially set dcontents_mtime to the current time. Why? When the inode object gets lost and reallocated, "clients" should reread the directory.  */
+		inode->i_dcontents_mtime = current_kernel_time(); 
 	}
 	return inode;
 }
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/Makefile	2004-08-16 02:49:57.000000000 +0200
+++ /usr/src/linux/fs/Makefile	2004-08-15 22:04:28.000000000 +0200
@@ -10,7 +10,7 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o nonotify.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/read_write.c	2004-08-16 02:48:07.000000000 +0200
+++ /usr/src/linux/fs/read_write.c	2004-08-15 22:04:28.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/nonotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 
@@ -257,8 +258,10 @@
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
+				nonotify_parent(file->f_dentry);
+			}
 		}
 	}
 
@@ -472,9 +475,11 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
+	if ((ret + (type == READ)) > 0) {
 		dnotify_parent(file->f_dentry,
 				(type == READ) ? DN_ACCESS : DN_MODIFY);
+		if (DN_MODIFY) nonotify_parent(file->f_dentry);
+	}
 	return ret;
 }
 
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/stat.c	2004-08-16 02:46:51.000000000 +0200
+++ /usr/src/linux/fs/stat.c	2004-08-22 02:17:29.000000000 +0200
@@ -33,6 +33,7 @@
 	stat->size = i_size_read(inode);
 	stat->blocks = inode->i_blocks;
 	stat->blksize = inode->i_blksize;
+	stat->contents_mtime = inode->i_dcontents_mtime; /* Nonotify */
 }
 
 EXPORT_SYMBOL(generic_fillattr);
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/include/linux/fs.h	2004-08-16 02:52:38.000000000 +0200
+++ /usr/src/linux/include/linux/fs.h	2004-08-15 22:04:28.000000000 +0200
@@ -454,6 +454,8 @@
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
+	struct timespec		i_dcontents_mtime;  /* Nonotify: Time of last modification of a file in this directory or time this inode object has been allocated */
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/include/linux/stat.h	2004-08-16 02:46:52.000000000 +0200
+++ /usr/src/linux/include/linux/stat.h	2004-08-22 02:12:26.000000000 +0200
@@ -70,6 +70,7 @@
 	struct timespec	ctime;
 	unsigned long	blksize;
 	unsigned long	blocks;
+	struct timespec		contents_mtime;		// field for nonotify_stat call
 };
 
 #endif
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/include/linux/nonotify.h	1970-01-01 01:00:00.000000000 +0100
+++ /usr/src/linux/include/linux/nonotify.h	2004-08-22 03:39:52.000000000 +0200
@@ -0,0 +1,30 @@
+/*
+ *   Directory content modification detection for Linux
+ *   
+ *   Copyright (C) 2004 Norbert Frese
+ */     
+
+#ifndef _LINUX_NONOTIFY_H
+#define _LINUX_NONOTIFY_H
+
+// internal kernel api
+
+void nonotify_parent(struct dentry *dentry);
+
+// data structure for ioctl 
+
+struct nonotify_stat {
+	char *filename;
+	struct timespec atime;
+	struct timespec	mtime;
+	struct timespec	ctime;
+	struct timespec	contents_mtime;
+};
+
+// defines
+
+#define NONOTIFY_IOCTL_MAGIC 'Q'
+#define NONOTIFY_IOCTL_MAXNR 1
+#define NONOTIFY_STAT    _IOWR(NONOTIFY_IOCTL_MAGIC, 1, struct nonotify_stat)
+
+#endif
--- /brenn/tmp/src/linux-2.6.8-0.rc1.2mdk/fs/nonotify.c	1970-01-01 01:00:00.000000000 +0100
+++ /usr/src/linux/fs/nonotify.c	2004-08-22 03:55:05.000000000 +0200
@@ -0,0 +1,197 @@
+/*
+ *  Directory content modification detection for Linux
+ *   
+ *  Copyright (C) 2004 Norbert Frese
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2, or (at your option) any
+ *  later version.
+ *  
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */     
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/nonotify.h> 
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+
+/* 
+ * Report mtime of this dentry to dcontents_mtime of the parent directory.
+ * Should get invoked inside file-write system calls. Take care that i_mtime
+ * is set to the current time before this is invoked.
+ */
+void nonotify_parent(struct dentry *dentry)
+{
+	struct dentry *parent;
+	spin_lock(&dentry->d_lock);
+	parent = dentry->d_parent;
+
+	dget(parent);
+	/* Assumption: This is faster than current_kernel_time(). If not - consider replacement */
+	parent->d_inode->i_dcontents_mtime = dentry->d_inode->i_mtime;
+	dput(parent);
+	spin_unlock(&dentry->d_lock);
+}
+
+EXPORT_SYMBOL_GPL(nonotify_parent);
+
+/**
+*
+*  call vfs_stat and copy times
+*
+*/
+int nonotify_stat_it(struct nonotify_stat * data) {
+		
+	struct kstat stat;
+	int error = vfs_stat(data->filename, &stat);
+
+	if (!error) {
+
+		if (copy_to_user(&data->atime,&(stat.atime),sizeof(struct timespec))) 
+			return -1;
+		if (copy_to_user(&data->mtime,&(stat.mtime),sizeof(struct timespec))) 
+			return -1;
+		if (copy_to_user(&data->ctime,&(stat.ctime),sizeof(struct timespec))) 
+			return -1;
+		if (copy_to_user(&data->contents_mtime,&(stat.contents_mtime),sizeof(struct timespec)))
+ 			return -1;
+	}
+	return error;
+}
+
+/**
+*
+*  nonotify ioctl
+*
+*/
+static int nonotify_ioctl(struct inode *ip, struct file *fp,
+		unsigned int cmd, unsigned long arg) {
+	int err;
+
+	if (_IOC_TYPE(cmd) != NONOTIFY_IOCTL_MAGIC) return -EINVAL;
+	if (_IOC_NR(cmd) > NONOTIFY_IOCTL_MAXNR) return -EINVAL;
+
+	err = -EINVAL;
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		err = !access_ok(VERIFY_READ, (void *)arg, _IOC_SIZE(cmd));
+
+	if (err) {
+		return -EFAULT;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_WRITE)
+		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
+
+	if (err) {
+		return -EFAULT;
+	}
+
+	err = -EINVAL;
+
+ 	switch (cmd) {
+		case NONOTIFY_STAT:
+			err = nonotify_stat_it((struct nonotify_stat *) arg);
+			break;
+	}
+	return err;
+}
+
+/*
+*
+* nonotify open
+*
+*/
+static int nonotify_open(struct inode *inode, struct file *file) {
+
+ printk(KERN_ALERT "nonotify device opened\n");
+
+ return 0;
+}
+
+/*
+*
+* nonotify release
+*
+*/
+static int nonotify_release(struct inode *inode, struct file *file)
+{
+
+ printk(KERN_ALERT "inotify device released\n");
+
+ return 0;
+}
+
+/**
+*
+* fops/device defs
+*
+*/
+static struct file_operations nonotify_fops = {
+ .owner  = THIS_MODULE,
+ .open  = nonotify_open,
+ .release = nonotify_release,
+ .ioctl  = nonotify_ioctl,
+};
+
+struct miscdevice nonotify_device = {
+ .minor  = MISC_DYNAMIC_MINOR, // auto
+ .name = "nonotify",
+ .fops = &nonotify_fops,
+};
+
+/**
+*
+* init module
+*
+*/
+static int __init nonotify_init (void)
+{
+	int ret;
+	ret = misc_register(&nonotify_device);
+	if (ret) {
+		goto out;
+	}
+	printk(KERN_ALERT "nonotify 0.3.2 minor=%d\n", nonotify_device.minor);
+out:
+	return ret;
+}
+
+/**
+*
+* exit module
+*
+*/
+static void nonotify_exit (void)
+{
+ printk(KERN_ALERT "nonotify shutdown\n");
+}
+
+/**
+*
+* module defs
+*
+*/
+MODULE_AUTHOR("norbert frese postfach@nfrese.net");
+MODULE_DESCRIPTION("Nonotify dirchange polling driver");
+MODULE_LICENSE("GPL");
+
+module_init (nonotify_init);
+module_exit (nonotify_exit);
+

--=-C7YySO6wob6c2MI0eSPg--

