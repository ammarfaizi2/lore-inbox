Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLMNR6>; Fri, 13 Dec 2002 08:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLMNR6>; Fri, 13 Dec 2002 08:17:58 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:22144 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S262821AbSLMNR3>; Fri, 13 Dec 2002 08:17:29 -0500
Date: Fri, 13 Dec 2002 14:24:41 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, "Abbas, Mohamed" <mohamed.abbas@intel.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH][RESEND] POSIX message queues, 2.5.50
In-Reply-To: <20021203151238.A14315@infradead.org>
Message-ID: <Pine.GSO.4.40.0212131414110.19392-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Dec 2002, Christoph Hellwig wrote:

> > +struct mq_attr {
> > +	long mq_flags;		/* message queue flags */
> > +	long mq_maxmsg;		/* maximum number of messages */
> > +	long mq_msgsize;	/* maximum message size */
> > +	long mq_curmsgs;	/* number of messages currently queued */
>
> Please don't use longs as ioctl arguments, better s32.  (and why
> can't this be unsigned, btw?)


I have no idea why it can't be unsigned. POSIX defined it to be long so we
just follow it :-)

We have made other code improvements (e.g. it can work as module) and
here is latest version.
Our page http://www.mat.uni.torun.pl/~wrona/posix_ipc
contains also this patch in version suitable for 2.4.19 kernel.

Regards

Krzysiek


---------------------------------------------------------------------------
diff -urN linux-2.5.50-org/CREDITS linux-2.5.50-patched/CREDITS
--- linux-2.5.50-org/CREDITS	2002-11-27 23:36:15.000000000 +0100
+++ linux-2.5.50-patched/CREDITS	2002-12-02 13:09:57.000000000 +0100
@@ -279,6 +279,15 @@
 S: Greenbelt, Maryland 20771
 S: USA

+N: Krzysztof Benedyczak
+E: golbi@mat.uni.torun.pl
+W: http://www.mat.uni.torun.pl/~golbi
+D: POSIX message queues fs (with M. Wronski)
+S: ul. Podmiejska 52
+S: Radunica
+S: 83-000 Pruszcz Gdanski
+S: Poland
+
 N: Randolph Bentson
 E: bentson@grieg.seaslug.org
 W: http://www.aa.net/~bentson/
@@ -3380,6 +3389,14 @@
 S: Portland, OR 97204
 S: USA

+N: Michal Wronski
+E: wrona@mat.uni.torun.pl
+W: http://www.mat.uni.torun.pl/~wrona
+D: POSIX message queues fs (with K. Benedyczak)
+S: ul. Teczowa 23/12
+S: 80-680 Gdansk-Sobieszewo
+S: Poland
+
 N: Frank Xia
 E: qx@math.columbia.edu
 D: Xiafs filesystem [defunct]
diff -urN linux-2.5.50-org/Documentation/ioctl-number.txt linux-2.5.50-patched/Documentation/ioctl-number.txt
--- linux-2.5.50-org/Documentation/ioctl-number.txt	2002-11-27 23:36:20.000000000 +0100
+++ linux-2.5.50-patched/Documentation/ioctl-number.txt	2002-11-29 21:03:35.000000000 +0100
@@ -186,5 +186,6 @@
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-04	linux/mqueue.h		<http://mat.uni.torun.pl/~wrona/posix_ipc>
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
diff -urN linux-2.5.50-org/fs/Kconfig linux-2.5.50-patched/fs/Kconfig
--- linux-2.5.50-org/fs/Kconfig	2002-11-27 23:36:03.000000000 +0100
+++ linux-2.5.50-patched/fs/Kconfig	2002-12-10 01:31:02.000000000 +0100
@@ -588,6 +588,28 @@

 	  If unsure, say N.

+config POSIX_MQUEUE
+	tristate "POSIX Message Queues"
+	---help---
+	  POSIX variant of message queues is a part of IPC. In POSIX message
+	  queues every message has a priority which decides about succession
+	  of receiving it by a process. If you want to compile and run
+	  programs written e.g. for Solaris with use of its POSIX message
+	  queues (functions mq_*) say Y here. To use this feature you will
+	  also need mqueue library, available from
+	  <http://www.mat.uni.torun.pl/~wrona/posix_ipc/>
+
+	  POSIX message queues are visible as a filesystem called 'mqueue'
+	  and should be mounted in /dev/mqueue in order to work with standard
+	  library.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called mqueue.o.
+
+	  If unsure, say N.
+
 config TMPFS
 	bool "Virtual memory file system support (former shm fs)"
 	help
diff -urN linux-2.5.50-org/include/linux/mqueue.h linux-2.5.50-patched/include/linux/mqueue.h
--- linux-2.5.50-org/include/linux/mqueue.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.50-patched/include/linux/mqueue.h	2002-12-06 13:54:39.000000000 +0100
@@ -0,0 +1,43 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#include <asm/types.h>
+
+#define MQ_MAX		64	/* max number of message queues */
+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
+#define MQ_MSGSIZE 	16384	/* max message size */
+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
+#define MQ_PRIO_MAX 	32768	/* max priority */
+
+typedef int mqd_t;
+
+struct kern_mq_attr {
+	__u32	mq_flags;	/* message queue flags */
+	__u32	mq_maxmsg;	/* maximum number of messages */
+	__u32	mq_msgsize;	/* maximum message size */
+	__u32	mq_curmsgs;	/* number of messages currently queued */
+};
+
+
+/*
+*	struct for passing data via ioctls calls
+*/
+
+
+/* the same for send & receive */
+struct ioctl_mq_sndrcv {
+	__u64	msg_ptr;
+	__u32	msg_len;
+	__u64	msg_prio;	/* it is long or long* */
+	__u64	timeout;
+};
+
+
+#define MQ_IOC_CREATE	_IOW(0xB2, 0, struct kern_mq_attr)
+#define MQ_IOC_GETATTR	_IOR(0xB2, 1, struct kern_mq_attr)
+#define MQ_IOC_SEND	_IOW(0xB2, 2, struct ioctl_mq_sndrcv)
+#define MQ_IOC_RECEIVE	_IOR(0xB2, 3, struct ioctl_mq_sndrcv)
+#define MQ_IOC_NOTIFY	_IOW(0xB2, 4, struct sigevent)
+
+
+#endif
diff -urN linux-2.5.50-org/ipc/Makefile linux-2.5.50-patched/ipc/Makefile
--- linux-2.5.50-org/ipc/Makefile	2002-11-27 23:35:50.000000000 +0100
+++ linux-2.5.50-patched/ipc/Makefile	2002-11-27 21:13:35.000000000 +0100
@@ -5,5 +5,6 @@
 obj-y   := util.o

 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o

 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.50-org/ipc/mqueue.c linux-2.5.50-patched/ipc/mqueue.c
--- linux-2.5.50-org/ipc/mqueue.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.50-patched/ipc/mqueue.c	2002-12-10 01:16:05.000000000 +0100
@@ -0,0 +1,1074 @@
+/*
+ * POSIX message queues filesystem for Linux.
+ *
+ * Copyright (C) 2002 	Krzysztof Benedyczak 	(golbi@mat.uni.torun.pl)
+ *			Michal Wronski		(wrona@mat.uni.torun.pl)
+ *
+ * This file is released under the GPL.
+ */
+
+
+#include <linux/mqueue.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+
+#include <asm/current.h>
+#include <asm/siginfo.h>
+#include <asm/uaccess.h>
+
+
+#define MQUEUE_MAGIC	0x19800202
+#define DIRENT_SIZE	20
+#define FILENT_SIZE	60
+
+
+struct msg {			/* this represent particular message */
+	unsigned int msg_len;	/* in the queue */
+	unsigned int msg_prio;
+	char *mtext;
+};
+
+struct ext_wait_queue {		/* queue of sleeping processes */
+	struct task_struct *task;
+	struct list_head list;
+};
+
+
+/* this stores extra data for inode - queue specific data */
+struct mqueue_inode_info {
+	struct kern_mq_attr attr;
+	/* table of sorted pointers to messages */
+	struct msg *messages[MQ_MAXMSG];
+	pid_t notify_pid;	/* who we have to notify (or 0) */
+	struct sigevent notify;	/* notification */
+	/* for processes waiting for free space or message (respectively) */
+	/* this is left mainly because of poll */
+	wait_queue_head_t wait_q[2];
+	/* avoids extra invocations of wake_up */
+	wait_queue_head_t wait_q2[2];
+	struct ext_wait_queue e_wait_q[2];	/* 0=free space   1=message */
+	struct semaphore mq_sem;
+	/* size of queue in memory (msgs & struct) */
+	__u32 qsize;
+
+	/* VFS stuff */
+	struct inode vfs_inode;
+};
+
+
+static unsigned long msgs_size;	/* sum of sizes of all msgs in all queues */
+static unsigned int queues_count;	/* number of existing queues */
+static struct semaphore mq_sem;	/* main queues semaphore */
+
+/* fs stuff */
+static inline struct mqueue_inode_info *MQUEUE_I(struct inode *ino)
+{
+	return list_entry(ino, struct mqueue_inode_info, vfs_inode);
+}
+
+static kmem_cache_t *mqueue_inode_cachep;
+
+static int mqueue_ioctl_file(struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg);
+static unsigned int mqueue_poll_file(struct file *,
+				     struct poll_table_struct *);
+static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
+					 int flags, char *dev_name,
+					 void *data);
+static int mqueue_create(struct inode *dir, struct dentry *dent, int mode);
+static struct inode *mqueue_alloc_inode(struct super_block *sb);
+static void mqueue_destroy_inode(struct inode *inode);
+static int mqueue_release_file(struct inode *ino, struct file *f);
+static void mqueue_delete_inode(struct inode *ino);
+static int mqueue_unlink(struct inode *dir, struct dentry *dent);
+static ssize_t mqueue_read_file(struct file *, char *, size_t, loff_t *);
+
+static struct inode *mqueue_get_inode(struct super_block *sb, int mode);
+
+static struct inode_operations mqueue_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.create = mqueue_create,
+	.unlink = mqueue_unlink,
+};
+
+static struct file_operations mqueue_file_operations = {
+	.ioctl = mqueue_ioctl_file,
+	.release = mqueue_release_file,
+	.poll = mqueue_poll_file,
+	.read = mqueue_read_file,
+};
+
+static struct super_operations mqueue_super_ops = {
+	.alloc_inode = mqueue_alloc_inode,
+	.destroy_inode = mqueue_destroy_inode,
+	.statfs = simple_statfs,
+	.delete_inode = mqueue_delete_inode,
+	.drop_inode = generic_delete_inode,
+};
+
+static struct file_system_type mqueue_fs_type = {
+	.owner = THIS_MODULE,
+	.name = "mqueue",
+	.get_sb = mqueue_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+
+/*
+*		GENERAL FUNCTIONS FOR FS CREATION
+*/
+
+/*
+* 	auxiliary function - produce a new inode
+*/
+static struct inode *mqueue_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode;
+	struct mqueue_inode_info *ino_extra;
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_rdev = NODEV;
+		inode->i_atime = inode->i_mtime = inode->i_ctime =
+		    CURRENT_TIME;
+		if ((mode & S_IFMT) == S_IFREG) {
+			inode->i_fop = &mqueue_file_operations;
+			inode->i_size = FILENT_SIZE;
+			/* mqueue specific info */
+			ino_extra = MQUEUE_I(inode);
+			init_MUTEX(&(ino_extra->mq_sem));
+			init_waitqueue_head((&(ino_extra->wait_q[0])));
+			init_waitqueue_head((&(ino_extra->wait_q[1])));
+			init_waitqueue_head((&(ino_extra->wait_q2[0])));
+			init_waitqueue_head((&(ino_extra->wait_q2[1])));
+			INIT_LIST_HEAD(&(ino_extra->e_wait_q[0].list));
+			INIT_LIST_HEAD(&(ino_extra->e_wait_q[1].list));
+			ino_extra->notify_pid = 0;
+			ino_extra->notify.sigev_signo = 0;
+			ino_extra->notify.sigev_notify = SIGEV_NONE;
+			ino_extra->qsize =
+			    sizeof(struct mqueue_inode_info);
+			ino_extra->attr.mq_curmsgs = 0;
+			/* fill up with defaults
+			 * (mq_open will set it up via next ioctl call) */
+			ino_extra->attr.mq_maxmsg = 0;
+			ino_extra->attr.mq_msgsize = 0;
+		} else if ((mode & S_IFMT) == S_IFDIR) {
+			inode->i_nlink++;
+			/* Some things misbehave if size == 0 on a directory */
+			inode->i_size = 2 * DIRENT_SIZE;
+			inode->i_op = &mqueue_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+		}
+	}
+	return inode;
+}
+
+
+static int mqueue_parse_options(char *options, int *mode, uid_t * uid,
+				gid_t * gid, int silent)
+{
+	char *this_char, *value, *rest;
+
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
+		if ((value = strchr(this_char, '=')) != NULL) {
+			*value++ = 0;
+		} else {
+			if (!silent)
+				printk(KERN_ERR
+				       "mqueuefs: No value for mount option '%s'\n",
+				       this_char);
+			return 1;
+		}
+
+		if (!strcmp(this_char, "mode")) {
+			if (!mode)
+				continue;
+			*mode = simple_strtoul(value, &rest, 8);
+			if (*rest)
+				goto bad_val;
+		} else if (!strcmp(this_char, "uid")) {
+			if (!uid)
+				continue;
+			*uid = simple_strtoul(value, &rest, 0);
+			if (*rest)
+				goto bad_val;
+		} else if (!strcmp(this_char, "gid")) {
+			if (!gid)
+				continue;
+			*gid = simple_strtoul(value, &rest, 0);
+			if (*rest)
+				goto bad_val;
+		} else {
+			if (!silent)
+				printk(KERN_ERR
+				       "mqueuefs: Bad mount option %s\n",
+				       this_char);
+			return 1;
+		}
+	}
+	return 0;
+
+bad_val:
+	if (!silent)
+		printk(KERN_ERR
+		       "mqueuefs: Bad value '%s' for mount option '%s'\n",
+		       value, this_char);
+	return 1;
+
+}
+
+
+/* function for get_sb_nodev. Fill up our data in super block */
+static int mqueue_fill_super(struct super_block *sb, void *data,
+			     int silent)
+{
+	struct inode *inode;
+	uid_t uid = current->fsuid;
+	gid_t gid = current->fsgid;
+	int mode = S_IRWXUGO;
+
+	if (mqueue_parse_options(data, &mode, &uid, &gid, silent))
+		return -EINVAL;
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = MQUEUE_MAGIC;
+	sb->s_op = &mqueue_super_ops;
+
+	inode = mqueue_get_inode(sb, S_IFDIR | mode);
+
+	if (!inode)
+		return -ENOMEM;
+	inode->i_uid = uid;
+	inode->i_gid = gid;
+
+	sb->s_root = d_alloc_root(inode);
+
+	if (!sb->s_root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* called when mounting */
+static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
+					 int flags, char *dev_name,
+					 void *data)
+{
+	return get_sb_nodev(fs_type, flags, data, mqueue_fill_super);
+}
+
+
+static struct inode *mqueue_alloc_inode(struct super_block *sb)
+{
+	struct mqueue_inode_info *ei;
+	ei = (struct mqueue_inode_info *)
+	    kmem_cache_alloc(mqueue_inode_cachep, SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	return &ei->vfs_inode;
+}
+
+static void mqueue_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(mqueue_inode_cachep, MQUEUE_I(inode));
+}
+
+static void init_once(void *foo, kmem_cache_t * cachep,
+		      unsigned long flags)
+{
+	struct mqueue_inode_info *p = (struct mqueue_inode_info *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		inode_init_once(&p->vfs_inode);
+	}
+}
+
+
+static int init_inode_cache(void)
+{
+	mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
+						sizeof(struct
+						       mqueue_inode_info),
+						0, SLAB_HWCACHE_ALIGN,
+						init_once, NULL);
+	if (mqueue_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static void destroy_inode_cache(void)
+{
+	if (kmem_cache_destroy(mqueue_inode_cachep))
+		printk(KERN_INFO
+		       "mqueue_inode_cache: not all structures were freed\n");
+}
+
+
+/*
+*	init function
+*/
+static int __init init_mqueue_fs(void)
+{
+	int error;
+	error = init_inode_cache();
+
+	if (error) {
+		printk(KERN_ERR
+		       "Could not init inode cache for mqueue filesystem\n");
+		return error;
+	}
+
+	error = register_filesystem(&mqueue_fs_type);
+	if (error) {
+		printk(KERN_ERR "Could not register mqueue filesystem\n");
+		goto out_inodecache;
+	}
+
+	/* internal initialization - not common for vfs */
+	msgs_size = 0;
+	queues_count = 0;
+	init_MUTEX(&mq_sem);
+
+	return 0;
+
+out_inodecache:
+	destroy_inode_cache();
+	return error;
+}
+
+static void __exit exit_mqueue_fs(void)
+{
+	unregister_filesystem(&mqueue_fs_type);
+	destroy_inode_cache();
+}
+
+module_init(init_mqueue_fs)
+module_exit(exit_mqueue_fs)
+
+MODULE_LICENSE("GPL");
+
+static void mqueue_delete_inode(struct inode *ino)
+{
+	int i;
+	struct mqueue_inode_info *info;
+
+	if ((ino->i_mode & S_IFMT) == S_IFDIR) {
+		clear_inode(ino);
+		return;
+	}
+	info = MQUEUE_I(ino);
+	i = 0;
+	down(&info->mq_sem);
+	while (info->attr.mq_curmsgs > 0) {
+		kfree(info->messages[i]->mtext);
+		msgs_size -= info->messages[i]->msg_len;
+		kfree(info->messages[i]);
+		info->messages[i] = NULL;
+		i++;
+		info->attr.mq_curmsgs--;
+	}
+	up(&info->mq_sem);
+	clear_inode(ino);
+	down(&mq_sem);
+	queues_count--;
+	up(&mq_sem);
+}
+
+static int mqueue_unlink(struct inode *dir, struct dentry *dent)
+{
+	struct inode *inode = dent->d_inode;
+
+	dir->i_size -= DIRENT_SIZE;
+	inode->i_nlink--;
+	dput(dent);
+	return 0;
+}
+
+
+static int mqueue_create(struct inode *dir, struct dentry *dent, int mode)
+{
+	struct inode *ino;
+	int error = 0;
+
+	down(&mq_sem);
+	if (queues_count >= MQ_MAX) {
+		error = -ENOSPC;
+		goto out;
+	}
+	ino = mqueue_get_inode(dir->i_sb, mode);
+	if (!ino) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	queues_count++;
+	up(&mq_sem);
+
+	dir->i_size += DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+
+	d_instantiate(dent, ino);
+	dget(dent);
+	return 0;
+out:
+	up(&mq_sem);
+	return error;
+}
+
+/*
+*	This is routine for system read from queue file.
+*	To avoid mess with doing some
+*	sort of mq_receive here we allow to read only: queue size &
+* 	notification info (the only values that are interesting from user
+*	point of view and aren't accessible through std. routines)
+*/
+static ssize_t mqueue_read_file(struct file *file, char *data, size_t size,
+				loff_t * off)
+{
+	char buffer[FILENT_SIZE + 1];
+	struct mqueue_inode_info *info = MQUEUE_I(file->f_dentry->d_inode);
+	ssize_t retval = 0;
+
+	if (*off >= FILENT_SIZE)
+		return 0;
+
+	snprintf(buffer, FILENT_SIZE + 1,
+		 "QSIZE:%-10u NOTIFY:%-5d SIGNO:%-6d NOTIFY_PID:%-6d",
+		 info->qsize, info->notify.sigev_notify,
+		 info->notify.sigev_signo, info->notify_pid);
+
+	retval = FILENT_SIZE - *off;
+	if (copy_to_user(data, buffer + *off, retval)) {
+		retval = (ssize_t) - EFAULT;
+		goto out;
+	}
+	*off += retval;
+out:
+	return retval;
+}
+
+
+static int mqueue_release_file(struct inode *ino, struct file *f)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	down(&info->mq_sem);
+	if (info->notify_pid == current->pid) {
+		info->notify_pid = 0;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	}
+	up(&info->mq_sem);
+	return 0;
+}
+
+
+static unsigned int mqueue_poll_file(struct file *file,
+				     struct poll_table_struct *poll_tab)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(file->f_dentry->d_inode);
+	int retval = 0;
+
+	poll_wait(file, &info->wait_q[0], poll_tab);
+	poll_wait(file, &info->wait_q[1], poll_tab);
+
+	down(&info->mq_sem);
+	if (info->attr.mq_curmsgs)
+		retval = POLLIN | POLLRDNORM;
+
+	if (info->attr.mq_curmsgs < info->attr.mq_maxmsg)
+		retval |= POLLOUT | POLLWRNORM;
+	up(&info->mq_sem);
+
+	return retval;
+}
+
+
+/*
+*			CORE MQUEUE FUNCTIONS
+*/
+
+/*
+*  This cut&paste version of wait_event() without event checking & with
+*  exclusive adding to queue.
+*/
+void inline wait_exclusive(wait_queue_head_t * wq,
+			   struct mqueue_inode_info *i)
+{
+	wait_queue_t wait;
+	init_waitqueue_entry(&wait, current);
+
+	add_wait_queue_exclusive(wq, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+
+	up(&i->mq_sem);
+	schedule();
+	down(&i->mq_sem);
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(wq, &wait);
+}
+
+/* Removes from info->e_wait_q[sr] current process */
+static void wq_remove(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *ptr;
+
+	if (!list_empty(&(info->e_wait_q[sr].list)))
+		list_for_each_entry(ptr, &(info->e_wait_q[sr].list), list) {
+			if (ptr->task->pid == current->pid) {
+				list_del(&(ptr->list));
+				kfree(ptr);
+				break;
+		}
+		}
+}
+
+/* adds current to info->e_wait_q[sr] before element with smaller prio */
+static inline int wq_add(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *tmp, *ptr;
+
+	tmp = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (tmp == NULL)
+		return -2;
+	tmp->task = current;
+
+	if (list_empty(&info->e_wait_q[sr].list))
+		list_add(&tmp->list, &info->e_wait_q[sr].list);
+	else {
+		list_for_each_entry(ptr, &info->e_wait_q[sr].list, list)
+			if (ptr->task->static_prio <= current->static_prio) {
+				/* we add before ptr element */
+				__list_add(&tmp->list, ptr->list.prev,
+					&ptr->list);
+				return 0;
+			}
+		/* we add on tail */
+		list_add_tail(&tmp->list, &info->e_wait_q[sr].list);
+	}
+	return 0;
+}
+
+/* removes from info->e_wait_q[sr] current process.
+ * Only for wq_sleep(): as we are here current must be one
+ * before-first (last) (meaning first in order as our 'queue' is inversed) */
+static inline void wq_remove_last(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *tmp =
+	    list_entry(info->e_wait_q[sr].list.prev,
+		       struct ext_wait_queue, list);
+	list_del(&(tmp->list));
+	kfree(tmp);
+}
+
+/* adds current process
+ * sr: 0-send 1-receive
+ * Returns: 0=ok -1=signal -2=memory allocation error -3=timeout passed*/
+static int wq_sleep(struct mqueue_inode_info *info, int sr,
+		    signed long timeout)
+{
+	wait_queue_t __wait;
+	long error;
+
+	if (wq_add(info, sr) < 0)
+		return -2;
+
+	init_waitqueue_entry(&__wait, current);
+	add_wait_queue(&(info->wait_q[sr]), &__wait);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if ((current->pid ==
+		     (list_entry(info->e_wait_q[sr].list.prev,
+				 struct ext_wait_queue, list))->task->pid)
+		    && ((info->attr.mq_curmsgs > 0 && sr == 1)
+			|| (info->attr.mq_curmsgs <
+			    info->attr.mq_maxmsg && sr == 0)))
+			 break;
+		if (!signal_pending(current)) {
+			up(&info->mq_sem);
+			error = schedule_timeout(timeout);
+			down(&info->mq_sem);
+			if ((!error) && (!signal_pending(current))) {
+				remove_wait_queue(&(info->wait_q[sr]),
+						  &__wait);
+				wq_remove(info, sr);
+				return -3;
+			}
+			continue;
+		} else {
+			current->state = TASK_RUNNING;
+			remove_wait_queue(&(info->wait_q[sr]), &__wait);
+			wq_remove(info, sr);
+			return -1;
+		}
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&(info->wait_q[sr]), &__wait);
+	wq_remove_last(info, sr);
+
+	return 0;
+}
+
+/* wakes up all sleeping processes in queue */
+static void wq_wakeup(struct mqueue_inode_info *info, int sr)
+{
+	if (sr == 0) {
+		/* We can't invoke wake_up for processes waiting for free space
+		 * if there is less then MAXMSG-1 messages - then wake_up was
+		 * invoked previously (and finished) but mq_sleep() of proper
+		 * (only one) process didn't start to continue running yet,
+		 * thus we must wait until this process receives IT'S message
+		 */
+		if ((info->attr.mq_curmsgs < info->attr.mq_maxmsg - 1)
+		    && (!list_empty(&info->e_wait_q[sr].list))) {
+			wait_exclusive(&(info->wait_q2[sr]), info);
+		}
+	} else {
+		/* As above but for processes waiting for new message */
+		if ((info->attr.mq_curmsgs > 1)
+		    && (!list_empty(&info->e_wait_q[sr].list))) {
+			wait_exclusive(&(info->wait_q2[sr]), info);
+		}
+	}
+	/* We can wake up now - either all are sleeping or
+	 * queue is empty. */
+	if (!list_empty(&info->e_wait_q[sr].list))
+		wake_up_process((list_entry(info->e_wait_q[sr].list.prev,
+					    struct ext_wait_queue,
+					    list))->task);
+}
+
+/*
+ * Invoked via ioctl to do the rest of work when creating new queue:
+ * set limits
+ */
+static int mq_create_ioctl(struct inode *ino, struct kern_mq_attr *u_attr)
+{
+	struct kern_mq_attr attr;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	int error = 0;
+
+	down(&info->mq_sem);
+	if (info->attr.mq_maxmsg != 0) {
+		error = -EBADF;
+		goto out;
+	}
+	if (u_attr != NULL) {
+		if (copy_from_user
+		    (&attr, u_attr, sizeof(struct kern_mq_attr))) {
+			error = -EFAULT;
+			goto out;
+		}
+		if (attr.mq_maxmsg == 0
+		    || attr.mq_msgsize == 0
+		    || attr.mq_maxmsg > MQ_MAXMSG
+		    || attr.mq_msgsize > MQ_MSGSIZE) {
+			error = -EINVAL;
+			goto out;
+		}
+		info->attr.mq_maxmsg = attr.mq_maxmsg;
+		info->attr.mq_msgsize = attr.mq_msgsize;
+	} else {
+		info->attr.mq_maxmsg = MQ_MAXMSG;
+		info->attr.mq_msgsize = MQ_MSGSIZE;
+	}
+out:
+	up(&info->mq_sem);
+	return error;
+}
+
+/*
+ * The next two functions are only to do little split of too long mq_send_ioctl
+ */
+
+static inline int check_send_arg(struct mqueue_inode_info *info, int oflag,
+				 struct ioctl_mq_sndrcv *arg,
+				 long *timeout)
+{
+	struct timespec ts;
+
+	/* checks if O_NONBLOCK is set and queue is full */
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs == info->attr.mq_maxmsg)
+			return -EAGAIN;
+	/* checks msg_prio boundary */
+	if (arg->msg_prio >= (unsigned long) MQ_PRIO_MAX)
+		return -EINVAL;
+	/* checks if message isn't too large */
+	if (arg->msg_len > info->attr.mq_msgsize)
+		return -EMSGSIZE;
+	/* get & validate timeout */
+	if (arg->timeout) {
+		if (copy_from_user
+		    (&ts, (struct timespec *) (long) arg->timeout,
+		     sizeof(struct timespec)))
+			return -EFAULT;
+		if (ts.tv_nsec < 0 || ts.tv_sec < 0
+		    || ts.tv_nsec >= 1000000000L)
+			return -EINVAL;
+		/* it schould be enough */
+		*timeout = timespec_to_jiffies(&ts);
+	} else
+		*timeout = MAX_SCHEDULE_TIMEOUT;
+	return 0;
+}
+
+static inline void do_notify(struct mqueue_inode_info *info)
+{
+	struct siginfo sig_i;
+
+	/* notification
+	 * invoked when there is registered process and there isn't process
+	 * waiting synchronously for message AND state of queue changed from
+	 * empty to not empty*/
+	if (info->notify_pid != 0 && list_empty(&info->e_wait_q[1].list)
+	    && info->attr.mq_curmsgs == 1) {
+		/* TODO:
+		 *    Add support for sigev_notify==SIGEV_THREAD
+		 */
+		/* sends signal */
+		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
+			sig_i.si_signo = info->notify.sigev_signo;
+			sig_i.si_errno = 0;
+			sig_i.si_code = SI_MESGQ;
+			sig_i.si_pid = current->pid;
+			sig_i.si_uid = current->uid;
+			kill_proc_info(info->notify.sigev_signo,
+				       &sig_i, info->notify_pid);
+		}
+		/* after notification unregisters process */
+		info->notify_pid = 0;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	}
+}
+
+int mq_send_ioctl(struct inode *ino, int oflag,
+		  struct ioctl_mq_sndrcv *u_arg)
+{
+	struct msg *tmp_ptr1;
+	char *tmp_ptr2;
+	int sleep_ret, i, error = 0;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	long timeout;
+	struct ioctl_mq_sndrcv arg;
+
+	if ((oflag & O_ACCMODE) == O_RDONLY)
+		return -EBADF;
+
+	if (copy_from_user(&arg, (void *) u_arg, sizeof(arg))) {
+		printk(KERN_ERR
+		       " mqueue fs: can't copy data from user space");
+		return -EFAULT;
+	}
+
+	down(&info->mq_sem);
+
+	error = check_send_arg(info, oflag, &arg, &timeout);
+	if (error < 0)
+		goto out;
+
+	/* checks if queue is full -> I'm waitng as O_NONBLOCK isn't        */
+	/* set then. mq_receive wakes up only 1 process                     */
+	if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
+		sleep_ret = wq_sleep(info, 0, timeout);
+		if (sleep_ret == -1) {
+			error = -EINTR;
+			goto out;
+		} else if (sleep_ret == -2) {
+			error = -ENOMEM;
+			goto out;
+		} else if (sleep_ret == -3) {
+			error = -ETIMEDOUT;
+			goto out;
+		}
+	}
+
+	down(&mq_sem);
+	/* check if this message will exceed overall limit for mesages */
+	if (msgs_size + arg.msg_len > MQ_MAXSYSSIZE) {
+		error = -ENOMEM;
+		goto out_lock;
+	}
+
+	/* first try to allocate memory, before doing anything with
+	 * existing queues */
+	tmp_ptr1 = kmalloc(sizeof(struct msg), GFP_KERNEL);
+	if (!tmp_ptr1) {
+		error = -ENOMEM;
+		goto out_lock;
+	}
+	tmp_ptr2 = kmalloc(arg.msg_len, GFP_KERNEL);
+	if (!tmp_ptr2) {
+		error = -ENOMEM;
+		goto out_1free;
+	}
+
+	/* adds message to the queue */
+	i = info->attr.mq_curmsgs - 1;
+	while (i >= 0
+	       && info->messages[i]->msg_prio <
+	       (unsigned int) arg.msg_prio) {
+		info->messages[i + 1] = info->messages[i];
+		i--;
+	}
+
+	i++;			/* i == position */
+	info->messages[i] = tmp_ptr1;
+	info->messages[i]->msg_len = arg.msg_len;
+	info->messages[i]->msg_prio = (unsigned int) arg.msg_prio;
+	info->messages[i]->mtext = tmp_ptr2;
+	if (copy_from_user
+	    (info->messages[i]->mtext, (char *) (long) arg.msg_ptr,
+	     arg.msg_len)) {
+		error = -EFAULT;
+		printk(KERN_ERR " coping data from user failed\n");
+		goto out_2free;
+	}
+
+	info->attr.mq_curmsgs++;
+	msgs_size += arg.msg_len;
+	up(&mq_sem);
+	info->qsize += arg.msg_len;
+
+	do_notify(info);
+
+	/* after sending message we must wake up (ONLY 1 no matter which) */
+	/* process sleeping in wq_wakeup() */
+	wake_up(&(info->wait_q2[0]));
+
+	/* wakes up processes waiting for message */
+	wq_wakeup(info, 1);
+	goto out;
+out_2free:
+	kfree(tmp_ptr2);
+out_1free:
+	kfree(tmp_ptr1);
+out_lock:
+	up(&mq_sem);
+out:
+	up(&info->mq_sem);
+	return error;
+}
+
+
+ssize_t mq_receive_ioctl(struct inode * ino, long oflag,
+			 struct ioctl_mq_sndrcv * u_arg)
+{
+	int i, sleep_ret;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	struct timespec ts;
+	long timeout;
+	ssize_t retval;
+	struct ioctl_mq_sndrcv arg;
+
+	if ((oflag & O_ACCMODE) == O_WRONLY)
+		return -EBADF;
+
+	if (copy_from_user(&arg, u_arg, sizeof(struct ioctl_mq_sndrcv))) {
+		printk(KERN_ERR
+		       " mqueue fs: can't copy data from user space");
+		return -EFAULT;
+	}
+
+	down(&info->mq_sem);
+	/* checks if O_NONBLOCK is set and queue is empty */
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs == 0) {
+			retval = -EAGAIN;
+			goto out;
+		}
+	/* get & validate timeout */
+	if (arg.timeout) {
+		if (copy_from_user
+		    (&ts, (struct timespec *) (long) arg.timeout,
+		     sizeof(struct timespec))) {
+			retval = -EFAULT;
+			goto out;
+		}
+		if (ts.tv_nsec < 0 || ts.tv_sec < 0
+		    || ts.tv_nsec >= 1000000000L) {
+			retval = -EINVAL;
+			goto out;
+		}
+		/* it schould be enough */
+		timeout = timespec_to_jiffies(&ts);
+	} else
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	/* checks if queue is empty -> as O_NONBLOCK isn't set then
+	 * we must wait */
+	if (info->attr.mq_curmsgs == 0) {
+		sleep_ret = wq_sleep(info, 1, timeout);
+		if (sleep_ret == -1) {
+			retval = -EINTR;
+			goto out;
+		} else if (sleep_ret == -2) {
+			retval = -ENOMEM;
+			goto out;
+		} else if (sleep_ret == -3) {
+			retval = -ETIMEDOUT;
+			goto out;
+		}
+	}
+
+	/* checks if buffer is big enough */
+	if (arg.msg_len < info->messages[0]->msg_len) {
+		retval = -EMSGSIZE;
+		goto out;
+	}
+
+	retval = info->messages[0]->msg_len;
+	/* gets message */
+	if (arg.msg_prio)
+		if (put_user
+		    (info->messages[0]->msg_prio,
+		     (long *) (long) arg.msg_prio)) {
+			retval = -EFAULT;
+			goto out;
+		}
+	if (copy_to_user
+	    ((char *) (long) arg.msg_ptr, info->messages[0]->mtext,
+	     info->messages[0]->msg_len)) {
+		retval = -EFAULT;
+		goto out;
+	}
+	/* and deletes it */
+	kfree(info->messages[0]->mtext);
+	kfree(info->messages[0]);
+	for (i = 1; i < info->attr.mq_curmsgs; i++)
+		info->messages[i - 1] = (struct msg *) (info->messages[i]);
+	info->attr.mq_curmsgs--;
+	info->messages[info->attr.mq_curmsgs] = NULL;
+	/*decrease total space used by messages */
+	down(&mq_sem);
+	msgs_size -= retval;
+	up(&mq_sem);
+	info->qsize -= retval;
+
+	/* after receive we can wakeup 1 process waiting in wq_wakeup */
+	wake_up(&(info->wait_q2[1]));
+	/* wakes up processes waiting for sending message */
+	wq_wakeup(info, 0);
+out:
+	up(&info->mq_sem);
+	return retval;
+}
+
+
+int mq_notify_ioctl(struct inode *ino,
+		    const struct sigevent *u_notification)
+{
+	struct sigevent notification;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	int error = 0;
+
+	if (u_notification != NULL)
+		if (copy_from_user(&notification, u_notification,
+				   sizeof(struct sigevent)))
+			return -EFAULT;
+
+	down(&info->mq_sem);
+
+	if (info->notify_pid == current->pid
+	    && (u_notification == NULL ||
+		notification.sigev_notify == SIGEV_NONE)) {
+		info->notify_pid = 0;	/* remove notification */
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	} else if (info->notify_pid > 0) {
+		error = -EBUSY;
+		goto out;
+	} else if (u_notification != NULL &&
+		   notification.sigev_notify != SIGEV_NONE) {
+		/* add notification */
+		info->notify_pid = current->pid;
+		info->notify.sigev_signo = notification.sigev_signo;
+		info->notify.sigev_notify = notification.sigev_notify;
+	}
+out:
+	up(&info->mq_sem);
+	return error;
+}
+
+int mq_getattr_ioctl(struct inode *ino, int oflag,
+		     struct kern_mq_attr *u_mqstat)
+{
+	struct kern_mq_attr attr;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	int error = 0;
+
+	down(&info->mq_sem);
+
+	attr = info->attr;
+	attr.mq_flags = oflag;
+
+	if (u_mqstat == NULL) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (u_mqstat != NULL)
+		if (copy_to_user
+		    (u_mqstat, &attr, sizeof(struct kern_mq_attr)))
+			error = -EFAULT;
+out:
+	up(&info->mq_sem);
+	return error;
+}
+
+/*
+*	IOCTL FUNCTION - demultiplexer for various mqueues operations
+*/
+
+static int mqueue_ioctl_file(struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg)
+{
+	int ret = 1;
+
+	unlock_kernel();
+
+	switch (cmd) {
+	case MQ_IOC_CREATE:
+		ret = mq_create_ioctl(inode, (struct kern_mq_attr *) arg);
+		break;
+	case MQ_IOC_SEND:
+		ret =
+		    mq_send_ioctl(inode, filp->f_flags,
+				  (struct ioctl_mq_sndrcv *) arg);
+		break;
+	case MQ_IOC_RECEIVE:
+		ret =
+		    mq_receive_ioctl(inode, filp->f_flags,
+				     (struct ioctl_mq_sndrcv *) arg);
+		break;
+	case MQ_IOC_NOTIFY:
+		ret = mq_notify_ioctl(inode, (struct sigevent *) arg);
+		break;
+	case MQ_IOC_GETATTR:
+		ret = mq_getattr_ioctl(inode, filp->f_flags,
+				       (struct kern_mq_attr *) arg);
+		break;
+	}
+
+	lock_kernel();
+	return ret;
+}

