Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268270AbTBMTkC>; Thu, 13 Feb 2003 14:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268277AbTBMTkC>; Thu, 13 Feb 2003 14:40:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268270AbTBMTjo>; Thu, 13 Feb 2003 14:39:44 -0500
Date: Thu, 13 Feb 2003 11:46:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Tridgell <tridge@samba.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Synchronous signal delivery..
Message-ID: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 I talked about select() and signal races in Australia at IBM (forget who
exactly was involved so I just cc'd the usual suspects), and here's a
prototype example of what I suggested as a potential solution.

[ Warning: this goes on top of the current BK tree with all the signal 
  fixes and the generalized "dequeue_signal()" stuff. 

  Also note that it is a prototype, ie the packet returned to "read()" is 
  obviously not the full info, and there may be other issues with this. ]

It's a generic "synchronous signal delivery" method, and it uses a
perfectly regular file descriptor to deliver an arbitrary set of signals
that are pending.

It adds one new system call:

	fd = sigfd(sigset_t * mask, unsigned long flags);

which creates a file descriptor that is associated with the particular
thread that created it, and the particular signal mask that the user was
interested in. That file descriptor can be passed around all the normal
ways: it can be dup()'ed, given to somebody else with a AF_UNIX socket,
and obviously read() and select()/poll()'ed upon.

So you can have a process that does a sigfd(), forks, and the child can 
then listen in on the specified signals of the parent, for example.

NOTE! For it to be useful, the signals that you want to wait on and read()
using the file descriptor obviously have to be blocked, otherwise they'll 
just be delivered the old-fashioned way.

Here's a trivial example program using the new system call:

	#include <stdio.h>
	#include <signal.h>

	#define __NR_syscall (259)

	int sigfd(sigset_t *mask, unsigned long flags)
	{
		void *vsyscall = (void *) 0xffffe000;
		int ret;
		asm volatile("call *%1"
			:"=a" (ret)
			:"m" (vsyscall),
			 "0" (__NR_syscall),
			 "b" (mask),
			 "c" (flags));
		return ret;
	}

	int main(void)
	{
		sigset_t mask;
		int fd, len;
		char buffer[1024];

		sigfillset(&mask);
		sigprocmask(SIG_BLOCK, &mask, NULL);

		fd = sigfd(&mask, 0);
		printf("sigfd returns %d\n", fd);
	
		len = read(fd, buffer, sizeof(buffer));
		printf("read returns %d (signal %d)\n", len, *(int *)buffer);
		return 0;
	}

Just run it, and send the process signals to see what happens.

The above example program is obviously totally useless, and any real use
would have to expand the implementation with addign the full siginfo to
the packet read (which is trivial apart from deciding on what format to
use - it would be good to not have it be architecture-dependent and in
particular it would be horrible to have different formats for different
compatibility layers).

Any real use would also probably be a select() or poll() loop.

			Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1053  -> 1.1054 
#	include/linux/init_task.h	1.21    -> 1.22   
#	include/linux/sched.h	1.131   -> 1.132  
#	       kernel/fork.c	1.104   -> 1.105  
#	arch/i386/kernel/entry.S	1.54    -> 1.55   
#	           fs/exec.c	1.70    -> 1.71   
#	     kernel/signal.c	1.71    -> 1.72   
#	         fs/Makefile	1.56    -> 1.57   
#	include/asm-i386/unistd.h	1.23    -> 1.24   
#	               (new)	        -> 1.1     fs/sigfd.c     
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/13	torvalds@home.transmeta.com	1.1054
# Add support for "sigfd()" system call, that allows you to get signals
# through a synchronous system call interface instead of interrupting the
# process asynchronously.
# 
# This allows things like adding certain signal masks to poll() or select()
# loops without the normal races or special cases.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Feb 13 11:19:23 2003
+++ b/arch/i386/kernel/entry.S	Thu Feb 13 11:19:23 2003
@@ -801,6 +801,7 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
+	.long sys_sigfd
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Thu Feb 13 11:19:23 2003
+++ b/fs/Makefile	Thu Feb 13 11:19:23 2003
@@ -10,7 +10,8 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
+		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o \
+		sigfd.o
 
 obj-$(CONFIG_COMPAT) += compat.o
 
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu Feb 13 11:19:23 2003
+++ b/fs/exec.c	Thu Feb 13 11:19:23 2003
@@ -578,6 +578,7 @@
 		return -ENOMEM;
 
 	spin_lock_init(&newsighand->siglock);
+	init_waitqueue_head(&newsighand->waiting);
 	atomic_set(&newsighand->count, 1);
 	memcpy(newsighand->action, oldsighand->action, sizeof(newsighand->action));
 
diff -Nru a/fs/sigfd.c b/fs/sigfd.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/sigfd.c	Thu Feb 13 11:19:23 2003
@@ -0,0 +1,327 @@
+/*
+ *  linux/fs/sigfd.c
+ *
+ *  Copyright (C) 2003  Linus Torvalds
+ */
+
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+
+#include <asm/uaccess.h>
+
+#define SIGFD_MAGIC (0xa01eaf86)	/* Random number, no meaning. No, really! */
+
+struct sigfd_inode {
+	sigset_t sigmask;
+	struct task_struct *tsk;
+	struct sighand_struct *sighand;
+	struct inode vfs_inode;
+};
+
+static inline struct sigfd_inode *SIGFD_I(struct inode *inode)
+{
+	return container_of(inode, struct sigfd_inode, vfs_inode);
+}
+
+
+static kmem_cache_t * sigfd_inode_cachep;
+
+static struct inode *sigfd_alloc_inode(struct super_block *sb)
+{
+	struct sigfd_inode *ei;
+	ei = (struct sigfd_inode *)kmem_cache_alloc(sigfd_inode_cachep, SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	return &ei->vfs_inode;
+}
+
+static void sigfd_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(sigfd_inode_cachep, SIGFD_I(inode));
+}
+
+static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct sigfd_inode *ei = (struct sigfd_inode *) foo; 
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&ei->vfs_inode);
+}
+
+/*
+ * This needs to have some standardized structure return value..
+ */
+static ssize_t sigfd_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
+{
+	struct sigfd_inode *ei = SIGFD_I(filp->f_dentry->d_inode);
+	struct task_struct *tsk = ei->tsk;
+	struct sighand_struct *sighand = ei->sighand;
+	DECLARE_WAITQUEUE(wait, current);
+	int signr;
+	siginfo_t info;
+
+	for (;;) {
+		spin_lock_irq(&sighand->siglock);
+		signr = 0;
+		if (sighand != tsk->sighand)
+			break;
+		signr = dequeue_signal(tsk, &ei->sigmask, &info);
+		if (signr)
+			break;
+
+		add_wait_queue(&sighand->waiting, &wait);
+		set_task_state(tsk, TASK_INTERRUPTIBLE);  
+		spin_unlock_irq(&sighand->siglock);
+		schedule();
+		remove_wait_queue(&sighand->waiting, &wait);
+		if (signal_pending(current))
+			return -ERESTARTNOHAND;
+	}
+	spin_unlock_irq(&sighand->siglock);
+	if (count > sizeof(int))
+		count = sizeof(int);
+	count -= copy_to_user(buf, &signr, count);
+	if (!count)
+		count = -EFAULT;
+	return count;
+}
+
+static unsigned int sigfd_poll(struct file *filp, poll_table *wait)
+{
+	struct sigfd_inode *ei = SIGFD_I(filp->f_dentry->d_inode);
+	struct task_struct *tsk = ei->tsk;
+	struct sighand_struct *sighand = ei->sighand;
+	unsigned long *mask, *shared, *private;
+	int i;
+
+	poll_wait(filp, &sighand->waiting, wait);
+
+	if (sighand != tsk->sighand)
+		return 0;
+
+	mask = ei->sigmask.sig;
+	shared = tsk->signal->shared_pending.signal.sig;
+	private = tsk->pending.signal.sig;
+	for (i = 0; i < _NSIG_WORDS; i++) {
+		if (*mask & (*shared | *private))
+			return POLLIN;
+		mask++; shared++; private++;
+	}
+	return 0;
+}
+
+static int sigfd_release(struct inode *inode, struct file *filp)
+{
+	struct sigfd_inode *ei = SIGFD_I(inode);
+	struct sighand_struct *sighand = ei->sighand;
+
+	if (atomic_dec_and_test(&sighand->count))
+		kmem_cache_free(sighand_cachep, sighand);
+	put_task_struct(ei->tsk);
+	return 0;
+}
+
+static struct file_operations sigfd_fops = {
+	.read		= sigfd_read,
+	.poll		= sigfd_poll,
+	.release	= sigfd_release,
+};
+
+static int sigfd_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations sigfd_dentry_operations = {
+	.d_delete	= sigfd_delete_dentry,
+};
+
+static struct vfsmount *sigfd_mnt;
+
+static struct inode * get_sigfd_inode(void)
+{
+	struct inode *inode = new_inode(sigfd_mnt->mnt_sb);
+
+	if (inode) {
+		/* This is what we do. */
+		inode->i_fop = &sigfd_fops;
+
+		/*
+		 * Mark the inode dirty from the very beginning,
+		 * that way it will never be moved to the dirty
+		 * list because "mark_inode_dirty()" will think
+		 * that it already _is_ on the dirty list.
+		 */
+		inode->i_state = I_DIRTY;
+		inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_blksize = PAGE_SIZE;
+	}
+	return inode;
+}
+
+/*
+ * Create a file descriptor that is associated with our signal
+ * state. We can pass it around to others if we want to, but
+ * it will always be _our_ signal state.
+ */
+asmlinkage long sys_sigfd(sigset_t *user_mask, unsigned long flags)
+{
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+	struct file *file;
+	struct inode *inode;
+	struct sigfd_inode *ei;
+	sigset_t sigmask;
+	int error, fd;
+
+	error = -EINVAL;
+	if (copy_from_user(&sigmask, user_mask, sizeof(sigmask)))
+		goto badmask;
+	sigdelsetmask(&sigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+
+	/*
+	 * The user gives us the signals he is interested in,
+	 * but the signal code is geared towards the signals
+	 * that are blocked and thus _not_ interesting. Switch
+	 * the meaning here.
+	 */
+	signotset(&sigmask);
+
+	error = -ENFILE;
+	file = get_empty_filp();
+	if (!file)
+		goto no_files;
+	inode = get_sigfd_inode();
+	if (!inode)
+		goto close_file;
+	error = get_unused_fd();
+	if (error < 0)
+		goto close_inode;
+	fd = error;
+	
+	error = -ENOMEM;
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = inode->i_ino; /* will go */
+	dentry = d_alloc(sigfd_mnt->mnt_sb->s_root, &this);
+	if (!dentry)
+		goto close_fd;
+
+	dentry->d_op = &sigfd_dentry_operations;
+	d_add(dentry, inode);
+	file->f_vfsmnt = mntget(mntget(sigfd_mnt));
+	file->f_dentry = dget(dentry);
+
+	file->f_pos = 0;
+	file->f_flags = O_RDONLY;
+	file->f_op = &sigfd_fops;
+	file->f_mode = FMODE_READ;
+	file->f_version = 0;
+
+	/* sigfd state */
+	ei = SIGFD_I(inode);
+	ei->sigmask = sigmask;
+	get_task_struct(current);
+	ei->tsk = current;
+
+	/*
+	 * We also increment the sighand count to make sure
+	 * it doesn't go away from us in poll() when the task
+	 * exits (which can happen if the fd is passed to
+	 * another process with unix domain sockets.
+	 *
+	 * This also guarantees that an execve() will reallocate
+	 * the signal state, and thus avoids security concerns
+	 * with a untrusted process that passes off the signal
+	 * queue fd to another, and then does a suid execve.
+	 */
+	ei->sighand = current->sighand;
+	atomic_inc(&ei->sighand->count);
+
+	/* Ok, return it! */
+	fd_install(fd, file);
+	return fd;
+
+close_fd:
+	put_unused_fd(fd);
+close_inode:
+	iput(inode);
+close_file:
+	put_filp(file);
+no_files:
+badmask:
+	return error;	
+}
+
+static struct super_operations sigfd_ops = {
+	.alloc_inode	= sigfd_alloc_inode,
+	.destroy_inode	= sigfd_destroy_inode,
+	.statfs		= simple_statfs,
+};
+
+static struct super_block *sigfd_get_sb(struct file_system_type *fs_type,
+	int flags, char *dev_name, void *data)
+{
+	return get_sb_pseudo(fs_type, "sigfd:", &sigfd_ops, SIGFD_MAGIC);
+}
+
+static struct file_system_type sigfd_fs_type = {
+	.name		= "sigfd",
+	.get_sb		= sigfd_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static int __init init_sigfd(void)
+{
+	int err;
+
+	sigfd_inode_cachep = kmem_cache_create("sigfd_inode_cache",
+		sizeof(struct sigfd_inode),
+		0, SLAB_HWCACHE_ALIGN,
+		init_once, NULL);
+
+	err = -ENOMEM;
+	if (!sigfd_inode_cachep)
+		goto cachep_failed;
+
+	err = register_filesystem(&sigfd_fs_type);
+	if (err)
+		goto registration_failed;
+
+	sigfd_mnt = kern_mount(&sigfd_fs_type);
+	err = PTR_ERR(sigfd_mnt);
+	if (IS_ERR(sigfd_mnt))
+		goto mount_failed;
+
+	/* All done */
+	return 0;
+
+mount_failed:
+	unregister_filesystem(&sigfd_fs_type);
+registration_failed:
+	kmem_cache_destroy(sigfd_inode_cachep);
+cachep_failed:
+	return err;
+}
+
+static void __exit exit_sigfd(void)
+{
+	kmem_cache_destroy(sigfd_inode_cachep);
+	unregister_filesystem(&sigfd_fs_type);
+	mntput(sigfd_mnt);
+}
+
+module_init(init_sigfd)
+module_exit(exit_sigfd)
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Thu Feb 13 11:19:23 2003
+++ b/include/asm-i386/unistd.h	Thu Feb 13 11:19:23 2003
@@ -264,6 +264,7 @@
 #define __NR_epoll_wait		256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
+#define __NR_sigfd		259
 
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Thu Feb 13 11:19:23 2003
+++ b/include/linux/init_task.h	Thu Feb 13 11:19:23 2003
@@ -52,6 +52,7 @@
 	.count		= ATOMIC_INIT(1), 		\
 	.action		= { {{0,}}, }, 			\
 	.siglock	= SPIN_LOCK_UNLOCKED, 		\
+	.waiting	= __WAIT_QUEUE_HEAD_INITIALIZER(sighand.waiting), \
 }
 
 /*
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Feb 13 11:19:23 2003
+++ b/include/linux/sched.h	Thu Feb 13 11:19:23 2003
@@ -224,6 +224,7 @@
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	wait_queue_head_t	waiting;
 };
 
 /*
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Feb 13 11:19:23 2003
+++ b/kernel/fork.c	Thu Feb 13 11:19:23 2003
@@ -676,6 +676,7 @@
 	if (!sig)
 		return -1;
 	spin_lock_init(&sig->siglock);
+	init_waitqueue_head(&sig->waiting);
 	atomic_set(&sig->count, 1);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	return 0;
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Thu Feb 13 11:19:23 2003
+++ b/kernel/signal.c	Thu Feb 13 11:19:23 2003
@@ -758,6 +758,7 @@
 	if (LEGACY_QUEUE(&t->pending, sig))
 		return 0;
 
+	wake_up(&t->sighand->waiting);
 	ret = send_signal(sig, info, &t->pending);
 	if (!ret && !sigismember(&t->blocked, sig))
 		signal_wake_up(t, sig == SIGKILL);
@@ -849,6 +850,7 @@
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
 	 */
+	wake_up(&p->sighand->waiting);
 	ret = send_signal(sig, info, &p->signal->shared_pending);
 	if (unlikely(ret))
 		return ret;

