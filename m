Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUEaNsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUEaNsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUEaNqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:46:39 -0400
Received: from mx-00.sil.at ([62.116.68.196]:48145 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id S264645AbUEaNnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:43:43 -0400
Subject: [RFC/PATCH] Nonotify - A simplistic way to determine directory
	content changes
From: nf <nf2@scheinwelt.at>
Reply-To: nf2@scheinwelt.at
To: kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-YbpbhbcZ/lp/Vij/ziC6"
Message-Id: <1086011020.3736.9.camel@lilota.lamp.priv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2mdk 
Date: Mon, 31 May 2004 15:43:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YbpbhbcZ/lp/Vij/ziC6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi kernel experts,

After nagging about dnotify and unmount problems, i wrote my own little
patch and hope to provide a better solution.

My proposal is different from event based dnotify/inotify. Nonotify
provides an interface to make polling for directory changes more
efficient: Modification timestamps of files in a directory get stored in
an extra field of the directory inode. Therefore there is no need to
"stat" all the files in a directory for changes - a filemanager just has
to look at the "i_dcontents_mtime" timestamp of the directory.

The reason why i think that polling is better than sending events can be
easily demonstrated by running the following command in a directory
beeing watched by fam/dnotify:

$ time bash -c "for ((a=1;a<100000;a++)); do echo \"test $a\"; done >
test.txt"

with fam: 0:30.44elapsed 12%CPU (the rest goes to fam 45% and nautilus
40%)
without fam: 0:03.47elapsed 98%CPU

Dnotify slows down file operations by factor 10!!! I assume that all
event based mechanisms cause similar problems, because they generate
fireworks of events when a file is beeing written.

Nonotify has another advantage: It doesn't need to pin down inodes
(which would cause umount problems). When an inode object gets dropped
and reallocated by the kernel the "i_dcontents_mtime" field is
initialized to the current time. In this case an application watching a
directory will have to reread the directory although there were no
changes - but this will not happen very often (Because of the caching of
inode objects).

Please remember that this patch is only for testing. It works, but the
public interface for reading "i_dcontents_mtime" is not finished - i
have just reused the __unused fields of the "stat" structure. I think we
will need an extra system-call for this purpose, because changing the
"stat" structure would break C compatibility.

Please tell me what you think about this. I'm new to kernel programming
- i'm sure there are lots of things to improve.

Thanks,
Norbert










--=-YbpbhbcZ/lp/Vij/ziC6
Content-Disposition: attachment; filename=nonotify-patch0.3.txt
Content-Type: text/plain; name=nonotify-patch0.3.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ru linux-2.6.3-10mdk/fs/attr.c /usr/src/linux/fs/attr.c
--- linux-2.6.3-10mdk/fs/attr.c	2004-02-18 04:57:16.000000000 +0100
+++ /usr/src/linux/fs/attr.c	2004-05-31 13:26:40.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/nonotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -184,8 +185,10 @@
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
diff -ru linux-2.6.3-10mdk/fs/inode.c /usr/src/linux/fs/inode.c
--- linux-2.6.3-10mdk/fs/inode.c	2004-04-19 18:54:32.000000000 +0200
+++ /usr/src/linux/fs/inode.c	2004-05-31 13:31:21.000000000 +0200
@@ -151,6 +151,9 @@
 			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
+
+		/* Nonotify: Initially set dcontents_mtime to the current time. Why? When the inode object gets lost and reallocated, "clients" should reread the directory.  */
+		inode->i_dcontents_mtime = current_kernel_time(); 
 	}
 	return inode;
 }
diff -ru linux-2.6.3-10mdk/fs/Makefile /usr/src/linux/fs/Makefile
--- linux-2.6.3-10mdk/fs/Makefile	2004-04-19 18:54:32.000000000 +0200
+++ /usr/src/linux/fs/Makefile	2004-05-31 13:29:46.000000000 +0200
@@ -10,7 +10,7 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o nonotify.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
diff -ru linux-2.6.3-10mdk/fs/read_write.c /usr/src/linux/fs/read_write.c
--- linux-2.6.3-10mdk/fs/read_write.c	2004-02-18 04:58:33.000000000 +0100
+++ /usr/src/linux/fs/read_write.c	2004-05-31 13:11:20.000000000 +0200
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
 
@@ -471,9 +474,11 @@
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
 
diff -ru linux-2.6.3-10mdk/fs/stat.c /usr/src/linux/fs/stat.c
--- linux-2.6.3-10mdk/fs/stat.c	2004-02-18 04:57:17.000000000 +0100
+++ /usr/src/linux/fs/stat.c	2004-05-31 13:16:08.000000000 +0200
@@ -32,6 +32,7 @@
 	stat->size = i_size_read(inode);
 	stat->blocks = inode->i_blocks;
 	stat->blksize = inode->i_blksize;
+	stat->contents_mtime = inode->i_dcontents_mtime; /* Nonotify */
 }
 
 EXPORT_SYMBOL(generic_fillattr);
@@ -222,6 +223,17 @@
 #endif
 	tmp.st_blocks = stat->blocks;
 	tmp.st_blksize = stat->blksize;
+
+	/* Nonotify hack: use unused structure members for contents_mtime 
+	 This is just for testing - We will need an extra system-call for 
+	 reading contents_mtime!
+	 */
+
+	tmp.__unused4 = stat->contents_mtime.tv_sec;
+	tmp.__unused5 = stat->contents_mtime.tv_nsec;
+
+	/* end hack */
+	
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
diff -ru linux-2.6.3-10mdk/include/linux/fs.h /usr/src/linux/include/linux/fs.h
--- linux-2.6.3-10mdk/include/linux/fs.h	2004-04-19 18:54:32.000000000 +0200
+++ /usr/src/linux/include/linux/fs.h	2004-05-31 12:39:48.000000000 +0200
@@ -415,6 +415,8 @@
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
+	struct timespec		i_dcontents_mtime;  /* Nonotify: Time of last modification of a file in this directory or time this inode object has been allocated */
+
 	unsigned long		i_state;
 
 	unsigned int		i_flags;
diff -ru linux-2.6.3-10mdk/include/linux/stat.h /usr/src/linux/include/linux/stat.h
--- linux-2.6.3-10mdk/include/linux/stat.h	2004-02-18 04:57:24.000000000 +0100
+++ /usr/src/linux/include/linux/stat.h	2004-05-26 23:23:23.000000000 +0200
@@ -70,6 +70,7 @@
 	struct timespec	ctime;
 	unsigned long	blksize;
 	unsigned long	blocks;
+	struct timespec		contents_mtime;
 };
 
 #endif

--=-YbpbhbcZ/lp/Vij/ziC6
Content-Disposition: attachment; filename=nonotify.c
Content-Type: text/x-csrc; name=nonotify.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 *  Directory content modification detection for Linux
 *   
 *  Copyright (C) 2004 Norbert Frese
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License as published by the
 *  Free Software Foundation; either version 2, or (at your option) any
 *  later version.
 *  
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  General Public License for more details.
 */     
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/nonotify.h> 
#include <linux/spinlock.h>
/* 
 * Report mtime of this dentry to dcontents_mtime of the parent directory.
 * Should get invoked inside file-write system calls. Take care that i_mtime
 * is set to the current time before this is invoked.
 */
void nonotify_parent(struct dentry *dentry)
{
	struct dentry *parent;
	spin_lock(&dentry->d_lock);
	parent = dentry->d_parent;

	dget(parent);
	/* Assumption: This is faster than current_kernel_time(). If not - consider replacement */
	parent->d_inode->i_dcontents_mtime = dentry->d_inode->i_mtime;
	dput(parent);
	spin_unlock(&dentry->d_lock);
}

EXPORT_SYMBOL_GPL(nonotify_parent);


--=-YbpbhbcZ/lp/Vij/ziC6
Content-Disposition: attachment; filename=nonotify.h
Content-Type: text/x-chdr; name=nonotify.h; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 *   Directory content modification detection for Linux
 *   
 *   Copyright (C) 2004 Norbert Frese
 */     
#include <linux/fs.h>

void nonotify_parent(struct dentry *dentry);


--=-YbpbhbcZ/lp/Vij/ziC6
Content-Disposition: attachment; filename=nonotify_stat.c
Content-Type: text/x-csrc; name=nonotify_stat.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/**
 *
 *  This is the test-application to read the Nonotify i_dcontents_mtime value.
 *
 */

#include <linux/unistd.h>
#include <stdio.h>
#include <errno.h>


/* We need to call SYS_stat, not SYS_stat64, that's why we have to use syscall  */

_syscall2(int, stat, void*, file, void*, buf);

/* App-Main */
int main(int argc, char *argv[]) {

	long rval;
	int buf[100];
        int i;	

	if (argc <= 1) {
		fprintf(stderr, "usage nonotify_stat path\n");
		return 1;
	}
	
	
	for (i=0; i<100; i++) {
		buf[i]=0; 
	}


	rval = stat(argv[1], buf);
	
	printf("atime            %s", ctime(&buf[8]));
	printf("mtime            %s", ctime(&buf[10]));
	printf("ctime            %s", ctime(&buf[12]));
	printf("dcontents_mtime  %s", ctime(&buf[14]));
	return 0;
	
}


--=-YbpbhbcZ/lp/Vij/ziC6--

