Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUBTN1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUBTNZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:25:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18376 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261235AbUBTNW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:22:58 -0500
Date: Fri, 20 Feb 2004 14:23:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jamie Lokier <jamie@shareable.org>
Subject: [patch] explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220132352.GA11618@elte.hu>
References: <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20040220120417.GA4010@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What Samba needs is a way to tell between two points in time whether the
> directory contents have changed in any way - nothing more. Only one new
> syscall is used to maintain the Samba dcache:
> 
> 	long sys_mark_dir_clean(dirfd);

> this is how Samba could create a file atomically:
> 
> 	sys_create(name, mode | O_CLEAN);

i've attached a quick patch (against 2.6.3) that implements the new
sys_mark_dir_clean() syscall and O_CLEAN support in all open() variants,
just to have an idea of how it looks like roughly. (It's incomplete -
e.g. there's no explicit way to do an atomic unlink or rename.)

i've also attached dir-cache.c, a simple testcode for the new
functionality. It marks the current directory clean and tries to open
the "./1" file via O_CLEAN with 1 second delay. Start this in one shell
and do VFS-namespace modifying ops in another window (eg. "rm -f 2;
touch 2") and see the dir-cache code react to it - the 'clean' bit is
lost, and the file open-create does not succeed if the directory is not
clean.

there's a new dentry flag that is maintained under the directory's i_sem
semaphore. (It would be simpler to have the flag on the inode level,
that way the invalidation could be done as a simple filter to the
dnotify function.)

	Ingo

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dir-mark-clean-2.6.3-A3"

--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -882,5 +882,6 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+ 	.long sys_mark_dir_clean
 
 syscall_table_size=(.-sys_call_table)
--- linux/include/linux/dcache.h.orig	
+++ linux/include/linux/dcache.h	
@@ -153,9 +153,25 @@ d_iput:		no		no		yes
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
+#define DCACHE_USER_CLEAN	0x0020	/* userspace cache coherent */
 
 extern spinlock_t dcache_lock;
 
+static inline void d_user_flush(struct dentry *dentry)
+{
+	dentry->d_vfs_flags &= ~DCACHE_USER_CLEAN;
+}
+
+static inline void d_user_mark_clean(struct dentry *dentry)
+{
+	dentry->d_vfs_flags |= DCACHE_USER_CLEAN;
+}
+
+static inline long d_user_valid(struct dentry *dentry)
+{
+	return (dentry->d_vfs_flags & DCACHE_USER_CLEAN) != 0;
+}
+
 /**
  * d_drop - drop a dentry
  * @dentry: dentry to drop
--- linux/include/asm-generic/errno.h.orig	
+++ linux/include/asm-generic/errno.h	
@@ -96,5 +96,6 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFLUSH		125	/* cache not valid */
 
 #endif
--- linux/include/asm-i386/fcntl.h.orig	
+++ linux/include/asm-i386/fcntl.h	
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_CLEAN	       01000000 /* parent dir must be clean */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux/fs/open.c.orig	
+++ linux/fs/open.c	
@@ -747,6 +747,7 @@ struct file *filp_open(const char * file
 		namei_flags++;
 	if (namei_flags & O_TRUNC)
 		namei_flags |= 2;
+	namei_flags |= flags & O_CLEAN;
 
 	error = open_namei(filename, namei_flags, mode, &nd);
 	if (!error)
@@ -1029,6 +1030,26 @@ out_unlock:
 
 EXPORT_SYMBOL(sys_close);
 
+asmlinkage long sys_mark_dir_clean(unsigned int fd)
+{
+	struct file *filp;
+	long ret = -EBADF;
+
+	filp = fget(fd);
+	if (!filp)
+		return ret;
+
+	down(&filp->f_dentry->d_inode->i_sem);
+	ret = d_user_valid(filp->f_dentry);
+	d_user_mark_clean(filp->f_dentry);
+	up(&filp->f_dentry->d_inode->i_sem);
+
+	fput(filp);
+
+	return ret;
+}
+
+
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
--- linux/fs/namei.c.orig	
+++ linux/fs/namei.c	
@@ -1295,11 +1295,23 @@ do_last:
 		goto exit;
 	}
 
+	/*
+	 * Did user-space require the parent directory to be clean
+	 * but it was invalid?:
+	 */
+	error = -EFLUSH;
+	if ((flag & O_CLEAN) && !d_user_valid(dir)) {
+		up(&dir->d_inode->i_sem);
+		goto exit;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
 		error = vfs_create(dir->d_inode, dentry, mode, nd);
+		if (!error)
+			d_user_flush(dir);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
 		nd->dentry = dentry;
@@ -1493,6 +1505,8 @@ asmlinkage long sys_mknod(const char __u
 		}
 		dput(dentry);
 	}
+	if (!error)
+		d_user_flush(nd.dentry);
 	up(&nd.dentry->d_inode->i_sem);
 	path_release(&nd);
 out:
@@ -1545,6 +1559,8 @@ asmlinkage long sys_mkdir(const char __u
 			if (!IS_POSIXACL(nd.dentry->d_inode))
 				mode &= ~current->fs->umask;
 			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+			if (!error)
+				d_user_flush(nd.dentry);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1653,6 +1669,8 @@ asmlinkage long sys_rmdir(const char __u
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+		if (!error)
+			d_user_flush(nd.dentry);
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1728,6 +1746,8 @@ asmlinkage long sys_unlink(const char __
 		if (inode)
 			atomic_inc(&inode->i_count);
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		if (!error)
+			d_user_flush(nd.dentry);
 	exit2:
 		dput(dentry);
 	}
@@ -2099,6 +2119,10 @@ static inline int do_rename(const char *
 
 	error = vfs_rename(old_dir->d_inode, old_dentry,
 				   new_dir->d_inode, new_dentry);
+	if (!error) {
+		d_user_flush(old_dir);
+		d_user_flush(new_dir);
+	}
 exit5:
 	dput(new_dentry);
 exit4:

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dir-cache.c"

/*
 * Copyright (C) Ingo Molnar, 2002
 */
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/times.h>
#include <sys/wait.h>
#include <sys/ioctl.h>
#include <linux/unistd.h>

#define __NR_sys_mark_dir_clean 274
_syscall1(int, sys_mark_dir_clean, int, fd);

#define O_DIRECTORY        0200000 /* must be a directory */

#define O_CLEAN        01000000 /* parent dir must be clean */

int main(int argc, char **argv)
{
	int fd, fd2, clean;

	fd = open(".", O_RDONLY | O_DIRECTORY);
	if (fd <= 0) {
		perror("fd:");
		exit(-1);
	}

	for (;;) {
		clean = sys_mark_dir_clean(fd);
		printf("clean:%d ", clean); fflush(stdout);
		sleep(1);
		fd2 = open("./1", O_CREAT|O_TRUNC|O_CLEAN, 0777);
		close(fd2);
		printf("fd:%d\n", fd2);
		sleep(1);
	}

	return 0;
}


--0eh6TmSyL6TZE2Uz--
