Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSK3RXu>; Sat, 30 Nov 2002 12:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbSK3RXu>; Sat, 30 Nov 2002 12:23:50 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:8375 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S261645AbSK3RXe>; Sat, 30 Nov 2002 12:23:34 -0500
Date: Sat, 30 Nov 2002 18:30:37 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: linux-kernel@vger.kernel.org
cc: Michal Wronski <wrona@mat.uni.torun.pl>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>
Subject: [PATCH] POSIX message queues, 2.5.50
Message-ID: <Pine.GSO.4.40.0211301727580.1824-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After some (rather long) work we have finished and tested
(also on SMP machine) new implementation of POSIX message queues.

As it was suggested it is made as a filesystem.

Recently there were Peter Waechtler's patch with the same functionality.
As it is concurrent to us I will point out some key differences (and
advantages of our implementation as I think :-)

 - In order to work mqueue fs must be mounted (under /dev/mqueue if we
one want to use our lib)
 - system read from queue file will return some info about it
   also main vfs functions are supported
 - we don't create any new system call (but if it is now preferred to
don't use ioctls we can change it in one day)
 - this implementation doesn't change anything in the rest of kernel

and two most important ones:

 - our implementation does support priority scheduling which is omitted in
Peter's version (meaning that if many processes wait e.g. for a message
_random_ one will get it). It is important because developers could rely
on this feature - and it is as I think the most difficult part of
implementation
 - our version was quit well tested - with Peter's patch (at least this
for 2.5.46) I've had many problems.


Finally one note about library - it is possible to wget it from
www.mat.uni.torun.pl/~golbi/mqueuelib-3.0beta.tar.gz
but it is beta version (mainly because docs weren't updated)
We plan to finish it (and update our page) on next Tuesday.


Is this version acceptable for applying now?

Regards
Krzysiek Benedyczak


-----------mqueue-3.0 patch for 2.5.50----------------
diff -urN linux-org/CREDITS linux-patched/CREDITS
--- linux-org/CREDITS	Wed Nov 27 23:36:15 2002
+++ linux-patched/CREDITS	Sat Nov 30 12:45:32 2002
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
diff -urN linux-org/Documentation/ioctl-number.txt linux-patched/Documentation/ioctl-number.txt
--- linux-org/Documentation/ioctl-number.txt	Wed Nov 27 23:36:20 2002
+++ linux-patched/Documentation/ioctl-number.txt	Fri Nov 29 21:03:35 2002
@@ -186,5 +186,6 @@
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-04	linux/mqueue.h		<http://mat.uni.torun.pl/~wrona/posix_ipc>
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
diff -urN linux-org/fs/Kconfig linux-patched/fs/Kconfig
--- linux-org/fs/Kconfig	Wed Nov 27 23:36:03 2002
+++ linux-patched/fs/Kconfig	Sat Nov 30 12:43:14 2002
@@ -600,6 +600,23 @@

 	  See <file:Documentation/filesystems/tmpfs.txt> for details.

+config POSIX_MQUEUE
+    bool "POSIX Message Queues"
+    ---help---
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
+	  If unsure, say N.
+
 config RAMFS
 	bool
 	default y
diff -urN linux-org/include/linux/mqueue.h linux-patched/include/linux/mqueue.h
--- linux-org/include/linux/mqueue.h	Thu Jan  1 01:00:00 1970
+++ linux-patched/include/linux/mqueue.h	Fri Nov 29 21:23:12 2002
@@ -0,0 +1,43 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#include <linux/init.h>
+
+#define MQ_MAX		64	/* max number of message queues */
+
+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
+#define MQ_MSGSIZE 	16384	/* max message size */
+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
+#define MQ_PRIO_MAX 	32768	/* max priority */
+
+typedef int mqd_t;
+
+
+struct mq_attr {
+	long mq_flags;		/* message queue flags */
+	long mq_maxmsg;		/* maximum number of messages */
+	long mq_msgsize;	/* maximum message size */
+	long mq_curmsgs;	/* number of messages currently queued */
+};
+
+/*
+*	struct for passing data via ioctls calls
+*/
+
+/* the same for send&receive */
+struct ioctl_mq_sndrcv {
+	const char	*msg_ptr;
+	int		msg_len;
+	unsigned int	msg_prio;
+	struct timespec *timeout;
+};
+
+
+#define MQ_CREATE	_IOW(0xB2, 0, struct mq_attr)
+#define MQ_GETATTR	_IOR(0xB2, 1, struct mq_attr)
+#define MQ_SEND		_IOW(0xB2, 2, struct ioctl_mq_sndrcv)
+#define MQ_RECEIVE	_IOR(0xB2, 3, struct ioctl_mq_sndrcv)
+#define MQ_NOTIFY	_IOW(0xB2, 4, struct sigevent)
+
+
+#endif
diff -urN linux-org/ipc/Makefile linux-patched/ipc/Makefile
--- linux-org/ipc/Makefile	Wed Nov 27 23:35:50 2002
+++ linux-patched/ipc/Makefile	Wed Nov 27 21:13:35 2002
@@ -5,5 +5,6 @@
 obj-y   := util.o

 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o

 include $(TOPDIR)/Rules.make
diff -urN linux-org/ipc/mqueue.c linux-patched/ipc/mqueue.c
--- linux-org/ipc/mqueue.c	Thu Jan  1 01:00:00 1970
+++ linux-patched/ipc/mqueue.c	Sat Nov 30 16:54:00 2002
@@ -0,0 +1,1055 @@
+#include <linux/mqueue.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
+#include <linux/mount.h>
+
+#include <asm/current.h>
+#include <asm/siginfo.h>
+#include <asm/uaccess.h>
+
+
+#define MQUEUE_MAGIC	0x19800202
+#define DIRENT_SIZE	20
+#define FILENT_SIZE	(sizeof(long)+sizeof(int)*2+sizeof(pid_t))
+
+
+struct msg {			/* this represent particular message */
+	int msg_len;		/* in the queue */
+	unsigned int msg_prio;
+	char *mtext;
+};
+
+struct ext_wait_queue {		/* extra data (priority) for sleeping process */
+	int prio;		/* priority of the process(!) */
+	pid_t associated;	/* and it's pid */
+	struct ext_wait_queue *next;
+	struct ext_wait_queue *prev;
+};
+
+
+/* this stores extra data for inode - queue specific data */
+struct mqueue_inode_info {
+	struct mq_attr attr;
+	/* table of sorted pointers to messages */
+	struct msg *messages[MQ_MAXMSG];
+	pid_t notify_pid;	/* who we have to notify (or 0) */
+	struct sigevent notify;	/* notification */
+	/* for processes waiting for free space or message (respectively) */
+	wait_queue_head_t wait_q[2];
+	/* avoids extra invocations of wake_up*/
+	wait_queue_head_t wait_q2[2];
+	struct ext_wait_queue *e_wait_q[2];	/* 0=free space   1=message */
+	struct semaphore mq_sem;
+	/* size of queue in memory (msgs&struct) */
+	long qsize;
+
+	/* VFS stuff */
+	struct inode vfs_inode;
+};
+
+
+static long 	msgs_size;		/* sum of sizes of all msgs in all queues */
+static int	queues_count;		/* number of existing queues */
+static struct 	semaphore mq_sem;	/* main queues semaphore */
+
+/* fs stuff */
+static inline struct mqueue_inode_info *MQUEUE_I(struct inode *ino)
+{
+	return list_entry(ino, struct mqueue_inode_info, vfs_inode);
+}
+
+static kmem_cache_t *mqueue_inode_cachep;
+
+static struct vfsmount 		*mounted_mq;
+
+static int mqueue_ioctl_file (struct inode * inode, struct file * filp,
+	unsigned int cmd, unsigned long arg);
+static unsigned int mqueue_poll_file (struct file *, struct poll_table_struct *);
+static struct super_block *mqueue_get_sb (struct file_system_type *fs_type,
+	int flags, char *dev_name, void *data);
+static int mqueue_create (struct inode *dir, struct dentry *dent, int mode);
+static struct inode *mqueue_alloc_inode(struct super_block *sb);
+static void mqueue_destroy_inode(struct inode *inode);
+static int mqueue_release_file(struct inode *ino, struct file * f);
+static void mqueue_delete_inode (struct inode *ino);
+static int mqueue_unlink (struct inode *dir, struct dentry *dent);
+static ssize_t mqueue_read_file (struct file *, char *, size_t, loff_t *);
+
+static struct inode *mqueue_get_inode(struct super_block *sb, int mode);
+
+static struct inode_operations mqueue_dir_inode_operations = {
+    .lookup	=	simple_lookup,
+    .create	=	mqueue_create,
+    .unlink	=	mqueue_unlink,
+};
+
+static struct inode_operations mqueue_file_inode_operations = {};
+
+static struct file_operations mqueue_file_operations = {
+	.ioctl		=	mqueue_ioctl_file,
+	.release	=	mqueue_release_file,
+	.poll		=	mqueue_poll_file,
+	.read		=	mqueue_read_file,
+};
+
+static struct super_operations mqueue_super_ops = {
+	.alloc_inode	= mqueue_alloc_inode,
+	.destroy_inode	= mqueue_destroy_inode,
+	.statfs		= simple_statfs,
+	.delete_inode	= mqueue_delete_inode,
+	.drop_inode	= generic_delete_inode,
+};
+
+static struct file_system_type mqueue_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "mqueue",
+	.get_sb		= mqueue_get_sb,
+	.kill_sb	= kill_litter_super,
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
+struct inode *inode;
+struct mqueue_inode_info *ino_extra;
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_rdev = NODEV;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		if ( (mode & S_IFMT) == S_IFREG) {
+			inode->i_op = &mqueue_file_inode_operations;
+			inode->i_fop = &mqueue_file_operations;
+			inode->i_size = FILENT_SIZE;
+			/* mqueue specific info */
+			ino_extra = MQUEUE_I(inode);
+			init_MUTEX(&(ino_extra->mq_sem));
+			init_waitqueue_head((&(ino_extra->wait_q[0])));
+			init_waitqueue_head((&(ino_extra->wait_q[1])));
+			init_waitqueue_head((&(ino_extra->wait_q2[0])));
+			init_waitqueue_head((&(ino_extra->wait_q2[1])));
+			ino_extra->e_wait_q[0] = NULL;
+			ino_extra->e_wait_q[1] = NULL;
+			ino_extra->notify_pid = 0;
+			ino_extra->notify.sigev_signo = 0;
+			ino_extra->notify.sigev_notify = 0;
+			ino_extra->qsize = sizeof(struct mqueue_inode_info);
+			ino_extra->attr.mq_curmsgs = 0;
+			/* fill up with defaults
+			 * (mq_open will set it up via next ioctl call) */
+			ino_extra->attr.mq_maxmsg = 0;
+			ino_extra->attr.mq_msgsize = 0;
+		}else if((mode & S_IFMT) == S_IFDIR) {
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
+static int mqueue_parse_options(char *options,int *mode,uid_t *uid,gid_t *gid, int silent)
+{
+	char *this_char, *value, *rest;
+
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
+		if ((value = strchr(this_char,'=')) != NULL) {
+			*value++ = 0;
+		} else {
+			if(!silent)
+				printk(KERN_ERR
+			    		"mqueuefs: No value for mount option '%s'\n",
+			    		this_char);
+			return 1;
+		}
+
+		if (!strcmp(this_char,"mode")) {
+			if (!mode)
+				continue;
+			*mode = simple_strtoul(value,&rest,8);
+			if (*rest)
+				goto bad_val;
+		} else if (!strcmp(this_char,"uid")) {
+			if (!uid)
+				continue;
+			*uid = simple_strtoul(value,&rest,0);
+			if (*rest)
+				goto bad_val;
+		} else if (!strcmp(this_char,"gid")) {
+			if (!gid)
+				continue;
+			*gid = simple_strtoul(value,&rest,0);
+			if (*rest)
+				goto bad_val;
+		} else {
+			if(!silent)
+				printk(KERN_ERR "mqueuefs: Bad mount option %s\n",
+			       		this_char);
+			return 1;
+		}
+	}
+	return 0;
+
+bad_val:
+	if(!silent)
+		printk(KERN_ERR "mqueuefs: Bad value '%s' for mount option '%s'\n",
+	       		value, this_char);
+	return 1;
+
+}
+
+
+/* function for get_sb_nodev. Fill up our data in super block */
+static int mqueue_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	uid_t uid = current->fsuid;
+	gid_t gid = current->fsgid;
+	int mode   = S_IRWXUGO;
+
+	if (mqueue_parse_options (data, &mode, &uid, &gid, silent))
+		return -EINVAL;
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
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
+	int flags, char *dev_name, void *data)
+{
+	return get_sb_nodev(fs_type,flags,data,mqueue_fill_super);
+}
+
+
+static struct inode *mqueue_alloc_inode(struct super_block *sb)
+{
+	struct mqueue_inode_info *ei;
+	ei = (struct mqueue_inode_info *)kmem_cache_alloc(mqueue_inode_cachep, SLAB_KERNEL);
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
+static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct mqueue_inode_info *p = (struct mqueue_inode_info *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		inode_init_once(&p->vfs_inode);
+	}
+}
+
+
+static int init_inode_cache(void)
+{
+	mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
+					     sizeof(struct mqueue_inode_info),
+					     0, SLAB_HWCACHE_ALIGN,
+					     init_once, NULL);
+	if (mqueue_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static void destroy_inode_cache(void)
+{
+	if (kmem_cache_destroy(mqueue_inode_cachep))
+		printk(KERN_INFO "mqueue_inode_cache: not all structures were freed\n");
+}
+
+
+/*
+*	init function
+*/
+static int __init init_mqueue_fs(void)
+{
+	int error;
+	struct vfsmount * res;
+	error = init_inode_cache();
+	if(error) {
+		printk (KERN_ERR "Could not init inode cache for mqueue filesystem\n");
+	    	return error;
+	}
+
+	error = register_filesystem(&mqueue_fs_type);
+	if (error) {
+		printk (KERN_ERR "Could not register mqueue filesystem\n");
+		goto out_inodecache;
+	}
+
+	res = kern_mount(&mqueue_fs_type);
+	if (IS_ERR (res)) {
+		error = PTR_ERR(res);
+		printk (KERN_ERR "Could not kern_mount mqueue filesystem\n");
+		goto out_unregister;
+	}
+	mounted_mq = res;
+
+	/* internal initialization - not common for vfs*/
+	msgs_size = 0;
+	queues_count = 0;
+	init_MUTEX(&mq_sem);
+
+	return 0;
+
+out_unregister:
+	unregister_filesystem(&mqueue_fs_type);
+out_inodecache:
+	destroy_inode_cache();
+	return error;
+}
+
+static void __exit exit_mqueue_fs(void)
+{
+	unregister_filesystem(&mqueue_fs_type);
+	mntput(mounted_mq);
+}
+
+module_init(init_mqueue_fs)
+module_exit(exit_mqueue_fs)
+
+MODULE_LICENSE("GPL");
+
+
+static void mqueue_delete_inode (struct inode *ino)
+{
+	int i;
+	struct mqueue_inode_info *info;
+
+	if ( (ino->i_mode & S_IFMT) == S_IFDIR) {
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
+static int mqueue_unlink (struct inode *dir, struct dentry *dent)
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
+struct inode * ino;
+
+	down(&mq_sem);
+	if(queues_count>=MQ_MAX) {
+		up(&mq_sem);
+		return -ENOSPC;
+	}
+	ino = mqueue_get_inode(dir->i_sb,mode);
+	if(!ino) {
+		up(&mq_sem);
+		return -ENOMEM;
+	}
+
+	queues_count++;
+	up(&mq_sem);
+
+	dir->i_size += DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+
+	d_instantiate(dent,ino);
+	dget(dent);
+	return 0;
+}
+
+/*
+*	This is routine for system read from queue file.
+*	To avoid mess with doing some
+*	sort of mq_receive here we allow to read only: queue size &
+* 	notification info (the only values that are interesting from user
+*	point of view and aren't accessible through std. routines
+*/
+static ssize_t mqueue_read_file(struct file *file, char *data, size_t size, loff_t *off)
+{
+	char * buffer;
+	struct mqueue_inode_info *info = MQUEUE_I(file->f_dentry->d_inode);
+	int retval=0;
+
+	if (*off>=FILENT_SIZE)
+		return 0;
+	buffer = kmalloc(FILENT_SIZE,GFP_KERNEL);
+	if (buffer==NULL)
+		return -ENOMEM;
+
+	*((long *)buffer) = info->qsize;
+	*((pid_t *)(buffer+sizeof(long))) = info->notify_pid;
+	*((int *)(buffer+sizeof(long)+sizeof(pid_t))) =
+					info->notify.sigev_signo;
+	*((int *)(buffer+sizeof(long)+sizeof(pid_t)+sizeof(int))) =
+					info->notify.sigev_notify;
+	retval = FILENT_SIZE - *off;
+	if (copy_to_user(data,buffer+*off,retval))
+		return -EFAULT;
+	*off += retval;
+	return retval;
+}
+
+
+static int mqueue_release_file(struct inode *ino, struct file * f)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	down(&info->mq_sem);
+	if (info->notify_pid == current->pid) {
+		info->notify_pid = 0;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = 0;
+	}
+	up(&info->mq_sem);
+	return 0;
+}
+
+
+static unsigned int mqueue_poll_file(struct file *file,
+				struct poll_table_struct *poll_tab)
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
+
+/* the same as in sched.c but added up and down of out sem*/
+/* FIXME: why there was a bug on SMP with std. function used ????? */
+void wq_sleep_on(wait_queue_head_t *q,struct mqueue_inode_info *info)
+{
+	unsigned long flags;
+	wait_queue_t wait;
+	init_waitqueue_entry(&wait, current);
+
+	current->state = TASK_UNINTERRUPTIBLE;
+	spin_lock_irqsave(&q->lock,flags);
+	__add_wait_queue(q, &wait);
+	spin_unlock(&q->lock);
+
+	up(&info->mq_sem);
+	schedule();
+	down(&info->mq_sem);
+
+	spin_lock_irq(&q->lock);
+	__remove_wait_queue(q, &wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+
+static void wq_remove(struct mqueue_inode_info *info, int sr, pid_t p)
+{
+	struct ext_wait_queue *ptr;
+
+	if (info->e_wait_q[sr] != NULL) {
+		ptr = info->e_wait_q[sr];
+		do {
+			if (ptr->associated == p) {
+				if (ptr == info->e_wait_q[sr]) {
+					if (ptr->next == ptr)
+						info->e_wait_q[sr] =
+						    NULL;
+					else
+						info->e_wait_q[sr] =
+						    ptr->next;
+				}
+				ptr->next->prev = ptr->prev;
+				ptr->prev->next = ptr->next;
+				kfree(ptr);
+				break;
+			}
+			ptr = ptr->next;
+		} while (ptr != info->e_wait_q[sr]);
+	}
+}
+
+/* adds current to info->e_wait_q[sr] */
+static inline int wq_add(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *tmp, *ptr;
+
+	ptr = info->e_wait_q[sr];
+	tmp = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (tmp == NULL)
+		return -2;
+	tmp->associated = current->pid;
+	tmp->prio = current->static_prio;
+
+	if (ptr == NULL) {	/* empty queue */
+		tmp->next = tmp;
+		tmp->prev = tmp;
+		info->e_wait_q[sr] = tmp;
+	} else {
+/*		if (ptr->prio >= current->static_prio)
+			ptr = NULL;*/
+		if (ptr->prio < current->static_prio)
+			ptr = NULL;
+		else {
+			do {	/* looking up for a place */
+				ptr = ptr->next;
+/*				if (ptr->prio >= current->static_prio)*/
+				if (ptr->prio < current->static_prio)
+					break;
+			} while (ptr != info->e_wait_q[sr]);
+		}
+
+		if (ptr == NULL) {	/* it should be placed first */
+			tmp->next = info->e_wait_q[sr];
+			tmp->prev = info->e_wait_q[sr]->prev;
+			info->e_wait_q[sr]->prev = tmp;
+			tmp->prev->next = tmp;
+			info->e_wait_q[sr] = tmp;
+		} else {	/* it should be placed before ptr element */
+			tmp->next = ptr;
+			tmp->prev = ptr->prev;
+			ptr->prev = tmp;
+			tmp->prev->next = tmp;
+		}
+	}
+	return 0;
+}
+
+/* removes from info->e_wait_q[sr] current process.
+ * Only for wq_sleep(): as we are here current must be one
+ * before-first (meaning first in order) */
+static inline void wq_delete(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *tmp;
+
+	tmp = info->e_wait_q[sr]->prev;
+	if (tmp->next == tmp) {
+		kfree(info->e_wait_q[sr]);
+		info->e_wait_q[sr] = NULL;
+	} else {
+		info->e_wait_q[sr]->prev = tmp->prev;
+		tmp->prev->next = info->e_wait_q[sr];
+		kfree(tmp);
+	}
+}
+
+/* adds current process
+ * sr: 0-send 1-receive
+ * Returns: 0=ok -1=signal -2=memory allocation error -3=timeout passed*/
+static int wq_sleep(struct mqueue_inode_info *info, int sr, signed long timeout)
+{
+	wait_queue_t __wait;
+	long retval;
+
+	if(wq_add(info,sr)<0)
+		return -2;
+
+	init_waitqueue_entry(&__wait, current);
+	add_wait_queue(&(info->wait_q[sr]), &__wait);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if ((current->pid ==
+		     info->e_wait_q[sr]->prev->associated)
+		    && ((info->attr.mq_curmsgs > 0 && sr == 1)
+			|| (info->attr.mq_curmsgs <
+			    info->attr.mq_maxmsg && sr == 0)))
+			break;
+		if (!signal_pending(current)) {
+			up(&info->mq_sem);
+			retval = schedule_timeout(timeout);
+			down(&info->mq_sem);
+			if ((!retval) && (!signal_pending(current))) {
+				remove_wait_queue(&(info->wait_q[sr]),
+					  &__wait);
+				wq_remove(info, sr, current->pid);
+				return -3;
+			}
+			continue;
+		} else {
+			current->state = TASK_RUNNING;
+			remove_wait_queue(&(info->wait_q[sr]),
+					  &__wait);
+			wq_remove(info, sr, current->pid);
+			return -1;
+		}
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&(info->wait_q[sr]), &__wait);
+	wq_delete(info,sr);
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
+		if ((info->attr.mq_curmsgs <
+		     info->attr.mq_maxmsg - 1)
+		    && (info->e_wait_q[sr] != NULL)) {
+			wq_sleep_on(&(info->wait_q2[sr]),info);
+		}
+	} else {
+		/* As above but for processes waiting for new message */
+		if ((info->attr.mq_curmsgs > 1)
+		    && (info->e_wait_q[sr] != NULL)) {
+			wq_sleep_on(&(info->wait_q2[sr]),info);
+		}
+	}
+	/* We can wake up now - either all are sleeping or
+	 * queue is empty */
+	wake_up_all((&(info->wait_q[sr])));
+}
+
+/*
+ * Invoked via ioctl to do the rest of work when creating new queue:
+ * set limits
+ */
+static int mq_create_ioctl(struct inode *ino, struct mq_attr *u_attr)
+{
+	struct mq_attr attr;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	if (u_attr != NULL) {
+		if (copy_from_user(&attr, u_attr, sizeof(struct mq_attr)))
+			return -EFAULT;
+		if (attr.mq_maxmsg <= 0
+		    || attr.mq_msgsize <= 0
+		    || attr.mq_maxmsg > MQ_MAXMSG
+		    || attr.mq_msgsize > MQ_MSGSIZE)
+		return -EINVAL;
+		down(&info->mq_sem);
+		info->attr.mq_maxmsg = attr.mq_maxmsg;
+		info->attr.mq_msgsize = attr.mq_msgsize;
+	}else{
+		down(&info->mq_sem);
+		info->attr.mq_maxmsg = MQ_MAXMSG;
+		info->attr.mq_msgsize = MQ_MSGSIZE;
+	}
+	up(&info->mq_sem);
+	return 0;
+}
+
+
+int mq_send_ioctl(struct inode * ino, int oflag, const char *msg_ptr, int msg_len,
+			   unsigned int msg_prio, struct timespec *ts_ptr)
+{
+	struct siginfo sig_i;
+	struct msg *tmp_ptr1;
+	char *tmp_ptr2;
+	int sleep_ret, i;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	struct timespec ts;
+	long timeout;
+	down(&info->mq_sem);
+	/* checks if O_NONBLOCK is set and queue is full */
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs ==
+		    info->attr.mq_maxmsg) {
+			up(&info->mq_sem);
+			return -EAGAIN;
+		}
+	/* checks msg_prio boundary */
+	if ((unsigned int) msg_prio >= (unsigned int) MQ_PRIO_MAX) {
+		up(&info->mq_sem);
+		return -EINVAL;
+	}
+	/* checks if message isn't too large */
+	if (msg_len > info->attr.mq_msgsize) {
+		up(&info->mq_sem);
+		return -EMSGSIZE;
+	}
+	/* get & validate timeout */
+	if(ts_ptr)
+	{
+		if (copy_from_user(&ts,ts_ptr,sizeof(struct timespec)))
+		{
+			up(&info->mq_sem);
+			return -EFAULT;
+		}
+		if (ts.tv_nsec<0 || ts.tv_sec<0 || ts.tv_nsec>=1000000000L)
+		{
+			up(&info->mq_sem);
+			return -EINVAL;
+		}
+		/* it schould be enough */
+		timeout = timespec_to_jiffies(&ts);
+	}else
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	/* checks if queue is full -> I'm waitng as O_NONBLOCK isn't        */
+	/* set then. mq_receive wakes up only 1 process                     */
+
+	if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
+		sleep_ret = wq_sleep(info, 0, timeout);
+		if (sleep_ret == -1) {
+			up(&info->mq_sem);
+			return -EINTR;
+		} else if (sleep_ret == -2) {
+			up(&info->mq_sem);
+			return -ENOMEM;
+		} else if (sleep_ret == -3) {
+			up(&info->mq_sem);
+			return -ETIMEDOUT;
+		}
+	}
+	down(&mq_sem);
+	/* check if this message will exceed overall limit for mesages */
+	if (msgs_size + msg_len > MQ_MAXSYSSIZE) {
+		up(&info->mq_sem);
+		up(&mq_sem);
+		return -ENOMEM;
+	}
+
+	/* first try to allocate memory, before doing anything with
+	 * existing queues */
+	tmp_ptr1 = kmalloc(sizeof(struct msg), GFP_KERNEL);
+	if (!tmp_ptr1) {
+		up(&info->mq_sem);
+		up(&mq_sem);
+		return -ENOMEM;
+	}
+	tmp_ptr2 = kmalloc(msg_len, GFP_KERNEL);
+	if (!tmp_ptr2) {
+		up(&info->mq_sem);
+		up(&mq_sem);
+		kfree(tmp_ptr1);
+		return -ENOMEM;
+	}
+	/* adds message to the queue */
+	i = info->attr.mq_curmsgs - 1;
+	while (i >= 0 && info->messages[i]->msg_prio < msg_prio) {
+		info->messages[i + 1] = info->messages[i];
+		i--;
+	}
+
+	i++;			/* i == position */
+	info->messages[i] = tmp_ptr1;
+	info->messages[i]->msg_len = msg_len;
+	info->messages[i]->msg_prio = msg_prio;
+	info->messages[i]->mtext = tmp_ptr2;
+	if (copy_from_user(info->messages[i]->mtext, msg_ptr, msg_len))
+	{
+		up(&info->mq_sem);
+		up(&mq_sem);
+		kfree(tmp_ptr1);
+		kfree(tmp_ptr2);
+		printk(KERN_ERR " coping data from user failed\n");
+		return -EFAULT;
+	}
+	info->attr.mq_curmsgs++;
+	msgs_size += msg_len;
+	up(&mq_sem);
+	info->qsize += msg_len;
+
+	/* notification
+	 * invoked when there is registered process and there isn't process
+	 * waiting synchronously for message AND state of queue changed from
+	 * empty to not empty*/
+	if (info->notify_pid != 0
+	    && info->e_wait_q[1] == NULL
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
+	}
+
+	/* after sending message we must wake up (ONLY 1 no matter which) */
+	/* process sleeping in wq_wakeup() */
+	wake_up(&(info->wait_q2[0]));
+
+	/* wakes up processes waiting for message */
+	wq_wakeup(info, 1);
+	up(&info->mq_sem);
+	return 0;
+}
+
+
+size_t mq_receive_ioctl(struct inode *ino, long oflag, char *msg_ptr, int msg_len,
+			 unsigned int *msg_prio, struct timespec *ts_ptr)
+{
+	int i, retval, sleep_ret;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	struct timespec ts;
+	long timeout;
+	down(&info->mq_sem);
+
+	/* checks if O_NONBLOCK is set and queue is empty */
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs == 0) {
+			up(&info->mq_sem);
+			return -EAGAIN;
+		}
+
+	/* get & validate timeout */
+	if(ts_ptr)
+	{
+		if (copy_from_user(&ts,ts_ptr,sizeof(struct timespec)))
+		{
+			up(&info->mq_sem);
+			return -EFAULT;
+		}
+		if (ts.tv_nsec<0 || ts.tv_sec<0 || ts.tv_nsec>=1000000000L)
+		{
+			up(&info->mq_sem);
+			return -EINVAL;
+		}
+		/* it schould be enough */
+		timeout = timespec_to_jiffies(&ts);
+	}else
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+
+
+	/* checks if queue is empty -> as O_NONBLOCK isn't set then
+	 * we must wait */
+	if (info->attr.mq_curmsgs == 0) {
+		sleep_ret = wq_sleep(info, 1, timeout);
+		if (sleep_ret == -1) {
+			up(&info->mq_sem);
+			return -EINTR;
+		} else if (sleep_ret == -2) {
+			up(&info->mq_sem);
+			return -ENOMEM;
+		} else if (sleep_ret == -3) {
+			up(&info->mq_sem);
+			return -ETIMEDOUT;
+		}
+	}
+	/* checks if buffer is big enough */
+	if (msg_len < info->messages[0]->msg_len) {
+		up(&info->mq_sem);
+		return -EMSGSIZE;
+	}
+
+	retval = info->messages[0]->msg_len;
+	/* gets message */
+	if (msg_prio != NULL)
+		if (put_user(info->messages[0]->msg_prio, msg_prio)){
+			up(&info->mq_sem);
+			return -EFAULT;
+	    	}
+	if (copy_to_user(msg_ptr, info->messages[0]->mtext,
+		     info->messages[0]->msg_len))
+	{
+		up(&info->mq_sem);
+		return -EFAULT;
+	}
+	/* and deletes it */
+	kfree(info->messages[0]->mtext);
+	kfree(info->messages[0]);
+	for (i = 1; i < info->attr.mq_curmsgs; i++)
+		info->messages[i - 1] =
+		    (void *) (info->messages[i]);
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
+	up(&info->mq_sem);
+	return retval;
+}
+
+
+int mq_notify_ioctl(struct inode *ino, const struct sigevent *u_notification)
+{
+	struct sigevent notification;
+	struct mqueue_inode_info *info=MQUEUE_I(ino);
+
+
+	if (u_notification != NULL)
+		if (copy_from_user(&notification, u_notification,
+			       sizeof(struct sigevent)))
+			return -EFAULT;
+
+	down(&info->mq_sem);
+
+	if (info->notify_pid == current->pid
+	    && (u_notification == NULL ||
+	    	notification.sigev_notify == SIGEV_NONE)) {
+		info->notify_pid = 0;	/* remove notification */
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = 0;
+	} else if (info->notify_pid > 0) {
+		up(&info->mq_sem);
+		return -EBUSY;
+	} else if (u_notification != NULL &&
+			notification.sigev_notify != SIGEV_NONE) {
+		/* add notification */
+		info->notify_pid = current->pid;
+		info->notify.sigev_signo = notification.sigev_signo;
+		info->notify.sigev_notify = notification.sigev_notify;
+	}
+	up(&info->mq_sem);
+	return 0;
+}
+
+int mq_getattr_ioctl(struct inode *ino, int oflag, struct mq_attr *u_mqstat)
+{
+	struct mq_attr attr;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	int error = 0;
+
+	down(&info->mq_sem);
+
+	attr = info->attr;
+	attr.mq_flags = oflag;
+
+	if (u_mqstat != NULL)
+		if (copy_to_user(u_mqstat, &attr, sizeof(struct mq_attr)))
+			error = -EFAULT;
+	up(&info->mq_sem);
+	return error;
+}
+
+/*
+*	IOCTL FUNCTION - demultiplexer for various mqueues operations
+*/
+
+static int mqueue_ioctl_file (struct inode * inode, struct file * filp,
+			unsigned int cmd, unsigned long arg)
+{
+	int 			ret=1;
+	struct ioctl_mq_sndrcv	sndrcv_arg;
+	unlock_kernel();
+
+	switch(cmd)
+	{
+	case MQ_CREATE:
+		ret = mq_create_ioctl(inode,(struct mq_attr *)arg);
+		break;
+	case MQ_SEND:
+		if ((filp->f_flags & O_ACCMODE) == O_RDONLY)
+			return -EBADF;
+		if(copy_from_user(&sndrcv_arg,(void *)arg,sizeof(sndrcv_arg)))
+		{
+			printk(KERN_ERR " mqueue fs: can't copy data from user space");
+			break;
+		}
+		ret = mq_send_ioctl(inode,filp->f_flags,sndrcv_arg.msg_ptr,
+				sndrcv_arg.msg_len,sndrcv_arg.msg_prio,
+				sndrcv_arg.timeout);
+		break;
+	case MQ_RECEIVE:
+		if ((filp->f_flags & O_ACCMODE) == O_WRONLY)
+			return -EBADF;
+		if(copy_from_user(&sndrcv_arg,(void *)arg,sizeof(sndrcv_arg)))
+		{
+			printk(KERN_ERR " mqueue fs: can't copy data from user space");
+			break;
+		}
+		ret = mq_receive_ioctl(inode,filp->f_flags,(char *)sndrcv_arg.msg_ptr,
+				sndrcv_arg.msg_len,(unsigned *)sndrcv_arg.msg_prio,
+				sndrcv_arg.timeout);
+		break;
+	case MQ_NOTIFY:
+		ret = mq_notify_ioctl(inode, (struct sigevent *)arg);
+		break;
+	case MQ_GETATTR:
+		ret = mq_getattr_ioctl(inode, filp->f_flags,
+					(struct mq_attr *)arg);
+		break;
+	}
+
+	lock_kernel();
+	return ret;
+}

