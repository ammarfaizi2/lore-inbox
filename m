Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289068AbSAIXYP>; Wed, 9 Jan 2002 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289074AbSAIXYH>; Wed, 9 Jan 2002 18:24:07 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:47629 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289068AbSAIXX6>; Wed, 9 Jan 2002 18:23:58 -0500
Date: Wed, 9 Jan 2002 23:23:55 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <Pine.LNX.4.33.0201081443540.8169-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201092319080.31300-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Linus Torvalds wrote:

> > Sorry to bother you, but how much inode/dentry stuff do I
> > need to have?
>
> You do need to have a dentry and an inode, but they don't have to
> contain anything interesting. In fact, you could have one global
> inode/dentry and just point the filp always at that.

Here we go.  I'm sure Al and others will pull the fs stuff
to bits, but it does seem to work.  The previously attached
test stuff didn't need any changes and can be fetched from

	http://hairy.beasts.org/ust.tar.gz

Both user and kernel bits are, of course, improvable, but
this should at least show that the approach works.

Matthew.


diff -X dontdiff -ruN linux-2.4.17/arch/i386/kernel/entry.S linux-2.4.17-usersem/arch/i386/kernel/entry.S
--- linux-2.4.17/arch/i386/kernel/entry.S	Sat Jan  5 14:00:37 2002
+++ linux-2.4.17-usersem/arch/i386/kernel/entry.S	Sun Jan  6 13:52:50 2002
@@ -622,6 +622,9 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_FS_create)
+	.long SYMBOL_NAME(sys_FS_down)
+	.long SYMBOL_NAME(sys_FS_up)

 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -X dontdiff -ruN linux-2.4.17/include/asm-i386/unistd.h linux-2.4.17-usersem/include/asm-i386/unistd.h
--- linux-2.4.17/include/asm-i386/unistd.h	Wed Oct 17 18:03:03 2001
+++ linux-2.4.17-usersem/include/asm-i386/unistd.h	Sun Jan  6 13:49:54 2002
@@ -230,6 +230,9 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define	__NR_FS_create		226
+#define	__NR_FS_down		227
+#define	__NR_FS_up		228

 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */

diff -X dontdiff -ruN linux-2.4.17/include/linux/usersem.h linux-2.4.17-usersem/include/linux/usersem.h
--- linux-2.4.17/include/linux/usersem.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.17-usersem/include/linux/usersem.h	Mon Jan  7 22:47:28 2002
@@ -0,0 +1,11 @@
+#ifndef __LINUX_USERSEM_H
+#define __LINUX_USERSEM_H
+
+#define	FS_OPAQUE_SIZE	24
+
+struct fast_sem {
+	int count;
+	int fd;
+} __attribute__((aligned(64)));
+
+#endif /* __LINUX_USERSEM_H */
diff -X dontdiff -ruN linux-2.4.17/kernel/Makefile linux-2.4.17-usersem/kernel/Makefile
--- linux-2.4.17/kernel/Makefile	Mon Sep 17 05:22:40 2001
+++ linux-2.4.17-usersem/kernel/Makefile	Sat Jan  5 14:36:39 2002
@@ -9,12 +9,12 @@

 O_TARGET := kernel.o

-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o usersem.o

 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o usersem.o

 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -X dontdiff -ruN linux-2.4.17/kernel/usersem.c linux-2.4.17-usersem/kernel/usersem.c
--- linux-2.4.17/kernel/usersem.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.17-usersem/kernel/usersem.c	Wed Jan  9 14:42:38 2002
@@ -0,0 +1,144 @@
+/*
+ * Lightweight user-level semaphores
+ */
+
+#include <linux/usersem.h>
+
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
+
+static int lock_fop_release(struct inode *i, struct file *f)
+{
+	kfree(f->private_data);
+}
+
+static struct file_operations lock_file_ops = {
+release: lock_fop_release,
+};
+
+
+static struct semaphore *get_sem(struct fast_sem *fs)
+{
+	int fd;
+	struct file *f;
+	if(get_user(fd, &fs->fd))
+		return NULL;
+	if(!(f = fget(fd)))
+		return NULL;
+	/* XXX - check that it's the right kind of file */
+	return (struct semaphore*)f->private_data;
+}
+
+
+asmlinkage long sys_FS_create(struct fast_sem *sem)
+{
+	int fd, err;
+	struct semaphore *s;
+	struct file *f;
+	static struct dentry *dent = NULL;
+	static struct inode *semi = NULL;
+
+       	if((fd = get_unused_fd()) < 0)
+		return fd;
+
+	if(!(f = get_empty_filp())) {
+		err = -ENFILE;
+		goto fd_out;
+	}
+
+	err = -ENOMEM;
+	if(unlikely(!dent)) {
+		if(!(dent = d_alloc(NULL, &(const struct qstr){ "lock", 4, 0})))
+			goto file_out;
+	}
+
+	if(unlikely(!semi)) {
+		if(!(semi = get_empty_inode()))
+			goto file_out;
+
+		semi->i_state = I_DIRTY;
+		semi->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
+		semi->i_uid = current->fsuid;
+		semi->i_gid = current->fsgid;
+		semi->i_atime = semi->i_mtime = semi->i_ctime = CURRENT_TIME;
+		d_add(dent, semi);
+	}
+
+	if(!(s = kmalloc(sizeof(*s), GFP_KERNEL)))
+		goto file_out;
+
+	sema_init(s, 1);
+	f->f_dentry = dget(dent);
+	f->f_op = &lock_file_ops;
+	f->private_data = (void*)s;
+
+	if(put_user(0, &sem->count) || put_user(0, &sem->fd)) {
+		err = -EFAULT;
+		goto file_out;
+	}
+
+	fd_install(fd, f);
+
+	put_user(fd, &sem->fd);
+
+	return 0;
+
+file_out:
+	put_filp(f);
+fd_out:
+	put_unused_fd(fd);
+	return err;
+}
+
+
+static struct file * get_filp(struct fast_sem *s)
+{
+	int r;
+	if(get_user(r, &s->fd))
+		return NULL;
+	return fget(r);
+}
+
+
+asmlinkage long sys_FS_down(struct fast_sem *fs)
+{
+	int r = -EBADF;
+	struct semaphore *s;
+	struct file *f;
+
+	if(!(f = get_filp(fs)))
+		return -EBADF;
+
+       	s = get_sem(fs);
+	if(s) {
+		down_interruptible(s);
+		r = 0;
+	}
+	fput(f);
+	return r;
+}
+
+asmlinkage long sys_FS_up(struct fast_sem *fs)
+{
+	int r = -EBADF;
+	struct semaphore *s;
+	struct file *f;
+
+	if(!(f = get_filp(fs)))
+		return -EBADF;
+
+       	s = get_sem(fs);
+	if(s) {
+		up(s);
+		r = 0;
+	}
+	fput(f);
+	return r;
+}

