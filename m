Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTIJUVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTIJUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:21:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:41174 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265624AbTIJUUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:20:07 -0400
Date: Wed, 10 Sep 2003 13:19:47 -0700
Message-Id: <200309102019.h8AKJld6010925@penguin.co.intel.com>
From: Rusty Lynch <rusty@penguin.co.intel.com>
Subject: [PATCH 2.6.0-test5 latest bk]mqueue filesystem
to: golbi@mat.uni.torun.pl
to: wrona@mat.uni.torun.pl
CC: linux-kernel@vger.kernel.org
Reply-To: rusty@linux.co.intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal & Krzysztof,

I was trying out your mqueue filesystem patch, and found that a couple of 
changes in 2.6.0-test4 caused your patch to no longer build.  Here is a patch
against the latest bk tree (2.6.0-test5+) that:

  * no longer uses the now non-existent kdev_t system by no long setting
    inode->i_rdev = NODEV;

  * removing the use of _IOW(something, something, void) since this is now
    caught by the build system with a forced error

    Since the two ioctls that used this only called dummy functions, it
    seemed to me like the right thing to do was just remove them seeing as
    the didn't really do anything.  I'm refering to the original ==>

+#define MQ_IOC_CLOSE	_IOW(0xB2, 5, void)
+#define MQ_IOC_SETATTR	_IOW(0xB2, 6, void)

  * since I was hammering on the system, and because wanting to tune some 
    of the hard coded values in your patch, I also added proc support
    for controlling the maximum number of queues, the maximum memory usage,
    and also added a proc entry for getting the current amount of memory
    used by all message queues.

For what it is worth, I have been hammering the hell out of this filesystem
without exposing any problems.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1276  -> 1.1277 
#	        ipc/Makefile	1.3     -> 1.4    
#	Documentation/filesystems/proc.txt	1.16    -> 1.17   
#	          fs/Kconfig	1.29    -> 1.30   
#	             CREDITS	1.97    -> 1.98   
#	Documentation/ioctl-number.txt	1.10    -> 1.11   
#	               (new)	        -> 1.1     include/linux/mqueue.h
#	               (new)	        -> 1.1     ipc/mqueue.c   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	rusty@penguin.co.intel.com	1.1217.8.1
# Adding the POSIX Message Queue Filesystem implemented by Krzysztof Benedyczak
# and Michal Wronski, along with proc support for a couple of tunables.
# --------------------------------------------
# 03/09/10	rusty@penguin.co.intel.com	1.1277
# Merge http://linux.bkbits.net:8080/linux-2.5
# into penguin.co.intel.com:/src/linux/linus
# --------------------------------------------
#
diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Wed Sep 10 12:54:48 2003
+++ b/CREDITS	Wed Sep 10 12:54:48 2003
@@ -289,6 +289,15 @@
 S: Terni 05100
 S: Italy
 
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
@@ -3466,6 +3475,14 @@
 S: 920 SW 3rd, Ste. 100
 S: Portland, OR 97204
 S: USA
+
+N: Michal Wronski
+E: wrona@mat.uni.torun.pl
+W: http://www.mat.uni.torun.pl/~wrona
+D: POSIX message queues fs (with K. Benedyczak)
+S: ul. Teczowa 23/12
+S: 80-680 Gdansk-Sobieszewo
+S: Poland
 
 N: Frank Xia
 E: qx@math.columbia.edu
diff -Nru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	Wed Sep 10 12:54:48 2003
+++ b/Documentation/filesystems/proc.txt	Wed Sep 10 12:54:48 2003
@@ -38,6 +38,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  POSIX Message Queues Filesystem
 
 ------------------------------------------------------------------------------
 Preface
@@ -1804,6 +1805,25 @@
 The /proc/net/ipx_route  table  holds  a list of IPX routes. For each route it
 gives the  destination  network, the router node (or Directly) and the network
 address of the router (or Connected) for internal networks.
+
+2.11 POSIX Message Queues Filesystem
+
+The "mqueue" filesystem provides the nessicary kernel features to enable the
+creation of a user space library that implements the POSIX message queues
+API (as noted by the MSG tag in the POSIX 1003.1-2001 version of the System
+Interfaces specification.)
+
+The "mqueue" filesystem contains both tunable values as well as informative
+values for determining the amount of resources used by the file system.
+
+/proc/fs/mqueue/max_queues is a read/write file for setting/getting the
+maximum number of message queues allowed on the system.
+
+/proc/fs/mqueue/max_sys_size is a read/write file for setting/getting the 
+maximum  bytes of memory utilited by the entire system for storing messages.
+
+/proc/fs/mqueue/msgs_size is a read-only file for getting the total amount 
+of memory currently being used to store all messages on the system.
 
 ------------------------------------------------------------------------------
 Summary
diff -Nru a/Documentation/ioctl-number.txt b/Documentation/ioctl-number.txt
--- a/Documentation/ioctl-number.txt	Wed Sep 10 12:54:48 2003
+++ b/Documentation/ioctl-number.txt	Wed Sep 10 12:54:48 2003
@@ -189,5 +189,6 @@
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2    00-0F   POSIX Message Queues    <http://www.mat.uni.torun.pl/~wrona/posix_ipc>
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Wed Sep 10 12:54:48 2003
+++ b/fs/Kconfig	Wed Sep 10 12:54:48 2003
@@ -882,6 +882,42 @@
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called ramfs.
 
+config POSIX_MQUEUE_FS
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
+config POSIX_MQUEUE_FS_PROC
+	bool "/proc/fs/mqueue support"
+	depends on POSIX_MQUEUE_FS
+	---help---
+	 Enabling this opion will add various files to the /proc/fs/mqueue
+         directory providing the ability to tune the mqueue filesystem, and 
+         also query resource usage.
+
+         For more information on the specific tunables, see 
+         Documentation/filesystems/proc.txt.
+
+         There is a small amount of overhead to be paid for adding proc 
+         support, but other then that it should be safe to enable this option.
+
 endmenu
 
 menu "Miscellaneous filesystems"
diff -Nru a/include/linux/mqueue.h b/include/linux/mqueue.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/mqueue.h	Wed Sep 10 12:54:48 2003
@@ -0,0 +1,39 @@
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
+/*
+ *	struct for passing data via ioctl calls
+ */
+
+/* the same for send & receive */
+struct ioctl_mq_sndrcv {
+	__u64	msg_ptr;
+	__u32	msg_len;
+	__u64	msg_prio;	/* it is long or long* */
+	__u64	timeout;
+};
+
+#define MQ_IOC_CREATE	_IOW(0xB2, 0, struct kern_mq_attr)
+#define MQ_IOC_GETATTR	_IOR(0xB2, 1, struct kern_mq_attr)
+#define MQ_IOC_SEND	_IOW(0xB2, 2, struct ioctl_mq_sndrcv)
+#define MQ_IOC_RECEIVE	_IOR(0xB2, 3, struct ioctl_mq_sndrcv)
+#define MQ_IOC_NOTIFY	_IOW(0xB2, 4, struct sigevent)
+
+#endif
diff -Nru a/ipc/Makefile b/ipc/Makefile
--- a/ipc/Makefile	Wed Sep 10 12:54:48 2003
+++ b/ipc/Makefile	Wed Sep 10 12:54:48 2003
@@ -5,3 +5,4 @@
 obj-y   := util.o
 
 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_POSIX_MQUEUE_FS) += mqueue.o
diff -Nru a/ipc/mqueue.c b/ipc/mqueue.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/ipc/mqueue.c	Wed Sep 10 12:54:48 2003
@@ -0,0 +1,1181 @@
+/*
+ * POSIX message queues filesystem for Linux.
+ *
+ * Copyright (C) 2003 	Krzysztof Benedyczak 	(golbi@mat.uni.torun.pl)
+ *			Michal Wronski		(wrona@mat.uni.torun.pl)
+ *
+ * Spinlocks:		Mohamed Abbas 		(abbas.mohamed@intel.com)
+ * Proc support:        Rusty Lynch             (rusty@linux.intel.com)
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
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+
+#include <asm/atomic.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+
+
+#define MQUEUE_MAGIC	0x19800202
+#define DIRENT_SIZE	20
+#define FILENT_SIZE	60
+#define SEND		0
+#define RECV		1
+
+struct msg {			/* this represents particular message */
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
+struct mqueue_inode_info {
+	struct kern_mq_attr attr;
+	
+	/* this is messages heap */
+	struct msg *messages[MQ_MAXMSG+1]; /* +1 for first entry - sentinel */
+
+	struct task_struct *notify_task;
+	struct sigevent notify;
+	
+	/* for processes waiting for free space or message (respectively) */
+	/* this is left mainly because of poll */
+	wait_queue_head_t wait_q[2];
+	/* avoids extra invocations of wake_up */
+	wait_queue_head_t wait_q2[2];
+	struct ext_wait_queue e_wait_q[2];	/* 0=free space   1=message */
+	
+	__u32 qsize; /* size of queue in memory (msgs & struct) */	
+	spinlock_t lock;
+	struct inode vfs_inode;
+};
+
+static struct inode_operations mqueue_dir_inode_operations;
+static struct file_operations mqueue_file_operations;
+static struct super_operations mqueue_super_ops;
+
+
+static unsigned long msgs_size;	  /* sum of sizes of all msgs in all queues */
+static unsigned long max_sys_size = MQ_MAXSYSSIZE;
+static unsigned int queues_count; /* number of existing queues */
+static unsigned int max_queues = MQ_MAX; /* maximum number of queues allowed */
+static spinlock_t mq_lock;
+static kmem_cache_t *mqueue_inode_cachep;
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+static struct proc_dir_entry *proc_fs_mqueue;
+static struct proc_dir_entry *max_queues_file;
+static struct proc_dir_entry *max_sys_size_file;
+static struct proc_dir_entry *msgs_size_file;
+
+static int proc_read_max_queues(char *page, char **start,
+				off_t off, int count, 
+				int *eof, void *data)
+{
+	return snprintf(page, count, "%i\n", max_queues); 
+}
+
+static int proc_write_max_queues(struct file *file,
+				 const char *buffer,
+				 unsigned long count, 
+				 void *data)
+{
+	char tmp[16];
+	unsigned long len;
+
+	if (count>16)
+		len = 16;
+	else
+		len = count;
+	
+	if(copy_from_user(tmp, buffer, len))
+		return -EFAULT;
+
+	tmp[len] = '\0';
+	if (sscanf(tmp,"%d",&max_queues) <= 0)
+		return -EFAULT;
+
+	return len;
+}
+
+static int proc_read_max_sys_size(char *page, char **start,
+				off_t off, int count, 
+				int *eof, void *data)
+{
+	return snprintf(page, count, "%ld\n", max_sys_size); 
+}
+
+static int proc_write_max_sys_size(struct file *file,
+				 const char *buffer,
+				 unsigned long count, 
+				 void *data)
+{
+	char tmp[16];
+	unsigned long len;
+
+	if (count>16)
+		len = 16;
+	else
+		len = count;
+	
+	if(copy_from_user(tmp, buffer, len))
+		return -EFAULT;
+
+	tmp[len] = '\0';
+	if (sscanf(tmp,"%ld",&max_sys_size) <= 0)
+		return -EFAULT;
+
+	return len;
+}
+
+static int proc_read_msgs_size(char *page, char **start,
+			       off_t off, int count, 
+			       int *eof, void *data)
+{
+	return snprintf(page, count, "%ld\n", msgs_size); 
+}
+
+#endif // CONFIG_POSIX_MQUEUE_FS_PROC
+
+static inline struct mqueue_inode_info *MQUEUE_I(struct inode *ino)
+{
+	return list_entry(ino, struct mqueue_inode_info, vfs_inode);
+}
+
+static struct inode *mqueue_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode;
+	struct mqueue_inode_info *ino_extra;
+	struct msg *m;
+
+	m = kmalloc(sizeof(struct msg), GFP_KERNEL);
+	if (!m) return NULL;
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		if ((mode & S_IFMT) == S_IFREG) {
+			inode->i_fop = &mqueue_file_operations;
+			inode->i_size = FILENT_SIZE;
+			/* mqueue specific info */
+			ino_extra = MQUEUE_I(inode);
+			spin_lock_init(&(ino_extra->lock));
+			init_waitqueue_head((&(ino_extra->wait_q[0])));
+			init_waitqueue_head((&(ino_extra->wait_q[1])));
+			init_waitqueue_head((&(ino_extra->wait_q2[0])));
+			init_waitqueue_head((&(ino_extra->wait_q2[1])));
+			INIT_LIST_HEAD(&(ino_extra->e_wait_q[0].list));
+			INIT_LIST_HEAD(&(ino_extra->e_wait_q[1].list));
+			ino_extra->notify_task = NULL;
+			ino_extra->notify.sigev_signo = 0;
+			ino_extra->notify.sigev_notify = SIGEV_NONE;
+			ino_extra->qsize = sizeof(struct mqueue_inode_info);
+			ino_extra->attr.mq_curmsgs = 0;
+			ino_extra->messages[0] = m;
+			ino_extra->messages[0]->msg_prio = MQ_PRIO_MAX + 1;
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
+	} else
+		kfree(m);
+		
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
+
+/* function for get_sb_nodev. Fill up our data in super block */
+static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
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
+static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
+					 int flags, const char *dev_name, void *data)
+{
+	return get_sb_nodev(fs_type, flags, data, mqueue_fill_super);
+}
+
+static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct mqueue_inode_info *p = (struct mqueue_inode_info *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&p->vfs_inode);
+}
+
+static struct inode *mqueue_alloc_inode(struct super_block *sb)
+{
+	struct mqueue_inode_info *ei;
+
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
+static void mqueue_delete_inode(struct inode *ino)
+{
+	struct mqueue_inode_info *info;
+	int size;
+	
+	if ((ino->i_mode & S_IFMT) == S_IFDIR) {
+		clear_inode(ino);
+		return;
+	}
+	info = MQUEUE_I(ino);
+	size = 0;
+	spin_lock(&info->lock);
+         
+	while (info->attr.mq_curmsgs > 0) {
+		kfree(info->messages[info->attr.mq_curmsgs]->mtext);
+		size += info->messages[info->attr.mq_curmsgs]->msg_len;
+		kfree(info->messages[info->attr.mq_curmsgs]);
+		info->attr.mq_curmsgs--;
+	}; 
+	kfree(info->messages[0]);
+	
+	spin_unlock(&info->lock);
+	clear_inode(ino);
+	spin_lock(&mq_lock);
+	msgs_size -= size;
+	queues_count--;
+	spin_unlock(&mq_lock);
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
+static struct dentry *mqueue_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
+{	
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	d_add(dentry, NULL);
+	return NULL;
+}
+
+static int mqueue_create(struct inode *dir, struct dentry *dent, int mode, struct nameidata *nd)
+{
+	struct inode *ino;
+	int error = 0;
+
+	spin_lock(&mq_lock);
+	if (queues_count >= max_queues) {
+		error = -ENOSPC;
+		goto out;
+	}
+	queues_count++;
+	spin_unlock(&mq_lock);
+
+	ino = mqueue_get_inode(dir->i_sb, mode);
+	if (!ino) {
+		error = -ENOMEM;
+		spin_lock(&mq_lock);
+		queues_count--;
+		goto out;
+	}
+
+	dir->i_size += DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+
+	d_instantiate(dent, ino);
+	dget(dent);
+	return 0;
+out:
+	spin_unlock(&mq_lock);
+	return error;
+}
+
+/*
+*	This is routine for system read from queue file. 
+*	To avoid mess with doing some 
+*	sort of mq_receive here we allow to read only queue size & 
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
+		 info->notify.sigev_signo, (info->notify_task) ? (info->notify_task)->pid : 0);
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
+	spin_lock(&info->lock);
+	if (info->notify_task == current) {
+		info->notify_task = NULL;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	}
+	spin_unlock(&info->lock);
+	return 0;
+}
+
+
+static unsigned int mqueue_poll_file(struct file *file, struct poll_table_struct *poll_tab)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(file->f_dentry->d_inode);
+	int retval = 0;
+
+	poll_wait(file, &info->wait_q[0], poll_tab);
+	poll_wait(file, &info->wait_q[1], poll_tab);
+
+	spin_lock(&info->lock);
+	if (info->attr.mq_curmsgs)
+		retval = POLLIN | POLLRDNORM;
+
+	if (info->attr.mq_curmsgs < info->attr.mq_maxmsg)
+		retval |= POLLOUT | POLLWRNORM;
+	spin_unlock(&info->lock);
+
+	return retval;
+}
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
+	spin_unlock(&i->lock);
+	schedule();
+	spin_lock(&i->lock);
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
+			}
+		}
+}
+
+/* adds current to info->e_wait_q[sr] before element with smaller prio */
+static inline void wq_add(struct mqueue_inode_info *info, int sr,
+			struct ext_wait_queue *tmp)
+{
+	struct ext_wait_queue *ptr;
+
+	tmp->task = current;
+
+	if (list_empty(&info->e_wait_q[sr].list))
+		list_add(&tmp->list, &info->e_wait_q[sr].list);
+	else {
+		list_for_each_entry(ptr, &info->e_wait_q[sr].list, list)
+			if (ptr->task->static_prio <= current->static_prio) {
+				/* we add before ptr element */
+				__list_add(&tmp->list, ptr->list.prev, &ptr->list);
+				return;
+			}
+		/* we add on tail */
+		list_add_tail(&tmp->list, &info->e_wait_q[sr].list);
+	}
+	return;
+}
+
+/* removes from info->e_wait_q[sr] current process. 
+ * Only for wq_sleep(): as we are here current must be one 
+ * before-first (last) (meaning first in order as our 'queue' is inversed) */
+static inline void wq_remove_last(struct mqueue_inode_info *info, int sr)
+{
+	struct ext_wait_queue *tmp =
+	    list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list);
+	list_del(&(tmp->list));
+	kfree(tmp);
+}
+
+/* 
+ * adds current process 
+ * sr: SEND or RECV 
+ */
+static int wq_sleep(struct mqueue_inode_info *info, int sr,
+		    signed long timeout, struct ext_wait_queue *wq_ptr)
+{
+	wait_queue_t __wait;
+	long error;
+
+	wq_add(info, sr, wq_ptr);
+
+	init_waitqueue_entry(&__wait, current);
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if ((current->pid == (list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list))->task->pid)
+			&& ((info->attr.mq_curmsgs > 0 && sr == RECV)
+			|| (info->attr.mq_curmsgs < info->attr.mq_maxmsg && sr == SEND)))
+			break;
+
+		if (signal_pending(current)) {
+			current->state = TASK_RUNNING;
+			wq_remove(info, sr);
+			return -EINTR;		
+		}
+
+		spin_unlock(&info->lock);
+		error = schedule_timeout(timeout);
+		spin_lock(&info->lock);
+
+		if ((!error) && (!signal_pending(current))) {
+			wq_remove(info, sr);
+			return -ETIMEDOUT;
+		}
+	}
+	current->state = TASK_RUNNING;
+	wq_remove_last(info, sr);
+
+	return 0;
+}
+
+/* wakes up all sleeping processes in queue */
+static void wq_wakeup(struct mqueue_inode_info *info, int sr)
+{
+	if (sr == SEND) {
+		/* We can't invoke wake_up for processes waiting for free space
+		 * if there is less then MAXMSG-1 messages - then wake_up was 
+		 * invoked previously (and finished) but mq_sleep() of proper
+		 * (only one) process didn't start to continue running yet, 
+		 * thus we must wait until this process receives IT'S message
+		 */
+		if ((info->attr.mq_curmsgs < info->attr.mq_maxmsg - 1)
+		    && (!list_empty(&info->e_wait_q[sr].list)))
+			wait_exclusive(&(info->wait_q2[sr]), info);
+	} else {
+		/* As above but for processes waiting for new message */
+		if ((info->attr.mq_curmsgs > 1) && (!list_empty(&info->e_wait_q[sr].list)))
+			wait_exclusive(&(info->wait_q2[sr]), info);
+	}
+	/* We can wake up now - either all are sleeping or 
+	 * queue is empty. */
+	if (!list_empty(&info->e_wait_q[sr].list))
+		wake_up_process((list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list))->task);
+	/* for poll */
+	wake_up_interruptible(&(info->wait_q[sr]));
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
+	if (u_attr != NULL) {
+		if (copy_from_user(&attr, u_attr, sizeof(struct kern_mq_attr))) {
+			error = -EFAULT;
+			goto out_nolock;
+		}
+		if (attr.mq_maxmsg == 0 || attr.mq_msgsize == 0
+		    || attr.mq_maxmsg > MQ_MAXMSG || attr.mq_msgsize > MQ_MSGSIZE) {
+			error = -EINVAL;
+			goto out_nolock;
+		}
+        }
+
+	spin_lock(&info->lock);
+	if (info->attr.mq_maxmsg != 0) {
+		error = -EBADF;
+		goto out;
+	}
+	if (u_attr != NULL) {
+		info->attr.mq_maxmsg = attr.mq_maxmsg;
+		info->attr.mq_msgsize = attr.mq_msgsize;
+	} else {
+		info->attr.mq_maxmsg = MQ_MAXMSG;
+		info->attr.mq_msgsize = MQ_MSGSIZE;
+	}
+out:
+	spin_unlock(&info->lock);
+out_nolock:
+	return error;
+}
+
+/* Auxiliary functions to manipulate messages' heap */
+static inline void heap_insert(struct msg *ptr, struct mqueue_inode_info *info)
+{
+	int k, parent;
+	
+	k = ++(info->attr.mq_curmsgs);
+	parent = k >> 1;
+	while (info->messages[parent]->msg_prio < ptr->msg_prio) {
+		info->messages[k] = info->messages[parent];
+		k = parent;
+		parent >>= 1;
+	}
+	info->messages[k] = ptr;
+}
+
+static inline struct msg *heap_get(struct mqueue_inode_info *info)
+{
+	int k = 1, child = 2;
+	struct msg *newtop, *retval;
+	
+	retval = info->messages[1];
+	newtop = info->messages[info->attr.mq_curmsgs];
+	info->attr.mq_curmsgs--;
+	child = 2;
+	k = 1;
+
+	while (child <= info->attr.mq_curmsgs) {
+		if (child+1 <= info->attr.mq_curmsgs &&
+		    info->messages[child]->msg_prio < 
+		    info->messages[child+1]->msg_prio)
+			child++;
+		    	
+		if (info->messages[child]->msg_prio > newtop->msg_prio) {
+			info->messages[k] = info->messages[child];
+			k = child;
+			child <<= 1;
+			continue;
+		}
+		break;
+	}
+	
+	if (info->attr.mq_curmsgs)
+		info->messages[k] = newtop;
+	return retval;
+}
+
+/* 
+ * The next function is only to split too long mq_send_ioctl 
+ */
+static inline void do_notify(struct mqueue_inode_info *info)
+{
+	struct siginfo sig_i;
+
+	/* notification 
+	 * invoked when there is registered process and there isn't process 
+	 * waiting synchronously for message AND state of queue changed from
+	 * empty to not empty*/
+	if (info->notify_task && list_empty(&info->e_wait_q[RECV].list)
+	    && info->attr.mq_curmsgs == 1) {
+		sig_i.si_signo = info->notify.sigev_signo;
+		sig_i.si_errno = 0;
+		sig_i.si_code = SI_MESGQ;
+		sig_i.si_value = info->notify.sigev_value;
+		sig_i.si_pid = current->pid;
+		sig_i.si_uid = current->uid;
+		
+		/* sends signal */
+		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
+			kill_proc_info(info->notify.sigev_signo,
+				       &sig_i, info->notify_task->pid);
+		} else  if (info->notify.sigev_notify == SIGEV_THREAD || 
+			    info->notify.sigev_notify == SIGEV_THREAD_ID)
+			send_sig_info(info->notify.sigev_signo, &sig_i, info->notify_task);
+		/* after notification unregisters process */
+		info->notify_task = NULL;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	}
+}
+
+static inline long prepare_timeout(struct ioctl_mq_sndrcv arg)
+{
+	struct timespec ts, nowts;
+	long timeout;
+
+	if (arg.timeout) {
+		if (copy_from_user(&ts, (struct timespec *) (long) arg.timeout, 
+			sizeof(struct timespec)))
+			return -EFAULT;
+			
+		if (ts.tv_nsec < 0 || ts.tv_sec < 0 
+			|| ts.tv_nsec >= NSEC_PER_SEC)
+			return -EINVAL;
+		nowts = CURRENT_TIME;
+		/* first subtract as jiffies can't be too big */
+		ts.tv_sec -= nowts.tv_sec;
+		if (ts.tv_nsec < nowts.tv_nsec) {
+			ts.tv_nsec += NSEC_PER_SEC;
+			ts.tv_sec--;
+		}
+		ts.tv_nsec -= nowts.tv_nsec;
+		if (ts.tv_sec < 0)
+			return 0;
+
+		timeout = timespec_to_jiffies(&ts) + 1;
+	} else
+		return MAX_SCHEDULE_TIMEOUT;
+
+	return timeout;
+}
+
+
+int mq_send_ioctl(struct inode *ino, int oflag,
+		  struct ioctl_mq_sndrcv *u_arg)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	struct ioctl_mq_sndrcv arg;	
+	struct msg *msg_ptr;
+	struct ext_wait_queue *wq_ptr;
+	char *msg_text_ptr;	
+	long timeout;
+	int i, error;
+
+	i = error = 0;
+
+	if ((oflag & O_ACCMODE) == O_RDONLY)
+		return -EBADF;
+
+	if (copy_from_user(&arg, (void *) u_arg, sizeof(arg)))
+		return -EFAULT;
+
+	if (arg.msg_prio >= (unsigned long) MQ_PRIO_MAX)
+		return -EINVAL;
+
+	timeout = prepare_timeout(arg);
+	if (timeout < 0)
+		return timeout;
+
+	/* first try to allocate memory, before doing anything with 
+	 * existing queues */
+	msg_ptr = kmalloc(sizeof(struct msg), GFP_KERNEL);
+	if (!msg_ptr)
+		return -ENOMEM;
+		
+	msg_text_ptr = kmalloc(arg.msg_len, GFP_KERNEL);
+	if (!msg_text_ptr) {
+		error = -ENOMEM;
+		goto out_1free;
+	}
+
+	if (copy_from_user(msg_text_ptr, (char *) (long) arg.msg_ptr, arg.msg_len)) {
+		error = -EFAULT;
+		goto out_2free;
+	}       
+
+	/* This memory may be unnecessary but we must alloc it here
+	 * because of spinlock. kfree is called in wq_remove(_last) */
+	wq_ptr = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (wq_ptr == NULL) {
+		error = -ENOMEM;
+		goto out_2free;
+	}
+
+	spin_lock(&info->lock);
+
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
+			error = -EAGAIN;
+			goto out_1unlock;
+		}
+			
+	if (arg.msg_len > info->attr.mq_msgsize) {
+		error = -EMSGSIZE;
+		goto out_1unlock;
+	}
+       
+	/* checks if queue is full -> I'm waiting as O_NONBLOCK isn't
+	 * set then. mq_receive wakes up only 1 process */
+	if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
+		error = wq_sleep(info, SEND, timeout, wq_ptr);
+		if (error)
+			goto out_1unlock_nofree;
+	} else
+		kfree(wq_ptr);
+	
+	spin_lock(&mq_lock);
+
+	if (msgs_size + arg.msg_len > max_sys_size) {
+		error = -ENOMEM;
+		goto out_2unlock;
+	}
+
+	msgs_size += arg.msg_len;
+
+	spin_unlock(&mq_lock);
+
+	/* adds message to the queue */
+	msg_ptr->msg_len = arg.msg_len;
+	msg_ptr->msg_prio = (unsigned int) arg.msg_prio;
+	msg_ptr->mtext = msg_text_ptr;	
+	
+	heap_insert(msg_ptr, info);
+
+	info->qsize += arg.msg_len;
+	do_notify(info);
+
+	/* after sending message we must wake up (ONLY 1 no matter which) */
+	/* process sleeping in wq_wakeup() */
+	wake_up(&(info->wait_q2[0]));
+
+	/* wakes up processes waiting for message */
+	wq_wakeup(info, RECV);
+	
+	spin_unlock(&info->lock);
+	return 0;
+		
+	/* I hate this goto convention... */
+out_2unlock:
+	spin_unlock(&mq_lock);	
+	goto out_1unlock_nofree;
+out_1unlock:
+	kfree(wq_ptr);
+out_1unlock_nofree:
+	spin_unlock(&info->lock);
+out_2free:
+	kfree(msg_text_ptr);
+out_1free:
+	kfree(msg_ptr);
+	return error;
+}
+
+
+ssize_t mq_receive_ioctl(struct inode * ino, long oflag,
+			 struct ioctl_mq_sndrcv * u_arg)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+	struct ioctl_mq_sndrcv arg;
+	struct msg *msg_ptr;
+	struct ext_wait_queue *wq_ptr;
+	ssize_t retval;
+	long timeout;
+
+	if ((oflag & O_ACCMODE) == O_WRONLY)
+		return -EBADF;
+
+	if (copy_from_user(&arg, u_arg, sizeof(struct ioctl_mq_sndrcv)))
+		return -EFAULT;
+
+	timeout = prepare_timeout(arg);
+	if (timeout < 0)
+		return timeout;
+
+        /* The same as in mq_send_ioctl */
+	wq_ptr = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (wq_ptr == NULL)
+		return -ENOMEM;
+
+	spin_lock(&info->lock);
+
+	/* checks if O_NONBLOCK is set and queue is empty */
+	if ((oflag & O_NONBLOCK) != 0)
+		if (info->attr.mq_curmsgs == 0) {
+			retval = -EAGAIN;
+			goto out_1unlock;
+		}
+
+	/* checks if buffer is big enough */
+	if (arg.msg_len < info->attr.mq_msgsize) {
+		retval = -EMSGSIZE;
+		goto out_unlock_only;
+	}
+	
+	/* checks if queue is empty -> as O_NONBLOCK isn't set then 
+	 * we must wait */
+	if (info->attr.mq_curmsgs == 0) {
+		retval = wq_sleep(info, RECV, timeout, wq_ptr);
+		if (retval < 0)
+			goto out_unlock_only;
+	} else
+		kfree(wq_ptr);
+
+	msg_ptr = heap_get(info);
+	retval = msg_ptr->msg_len;
+
+	/* decrease total space used by messages */
+	spin_lock(&mq_lock);
+	msgs_size -= retval;
+	spin_unlock(&mq_lock);
+	info->qsize -= retval;
+
+	/* after receive we can wakeup 1 process waiting in wq_wakeup */
+	wake_up(&(info->wait_q2[1]));
+	/* wakes up processes waiting for sending message */
+	wq_wakeup(info, SEND);
+
+	spin_unlock(&info->lock);
+
+	if (arg.msg_prio) {
+		if (put_user(msg_ptr->msg_prio, (long *) (long) arg.msg_prio)) {
+			retval = -EFAULT;
+			goto out_2free;
+		}
+        }
+	if (copy_to_user((char *) (long) arg.msg_ptr, msg_ptr->mtext, msg_ptr->msg_len))
+		retval = -EFAULT;
+
+out_2free:
+	kfree(msg_ptr->mtext);
+	kfree(msg_ptr);
+	return retval;
+out_1unlock:
+	kfree(wq_ptr);
+out_unlock_only:
+	spin_unlock(&info->lock);
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
+		if (copy_from_user(&notification, u_notification, sizeof(struct sigevent)))
+			return -EFAULT;
+
+	spin_lock(&info->lock);
+
+	if ((info->notify_task == current) && (u_notification == NULL ||
+		notification.sigev_notify == SIGEV_NONE)) {
+		info->notify_task = NULL;	/* remove notification */
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	} else if (info->notify_task) {
+		error = -EBUSY;
+		goto out;
+	} else if (u_notification != NULL && notification.sigev_notify != SIGEV_NONE) {
+		/* add notification */
+		info->notify_task = current;
+		info->notify.sigev_signo = notification.sigev_signo;
+		info->notify.sigev_notify = notification.sigev_notify;
+		info->notify.sigev_value = notification.sigev_value;
+	}
+out:
+	spin_unlock(&info->lock);
+	return error;
+}
+
+int mq_getattr_ioctl(struct inode *ino, int oflag, struct kern_mq_attr *u_mqstat)
+{
+	struct kern_mq_attr attr;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	if (u_mqstat == NULL)
+		return -EINVAL;
+
+	spin_lock(&info->lock);
+
+	attr = info->attr;
+	attr.mq_flags = oflag;
+
+	spin_unlock(&info->lock);
+
+	if (copy_to_user(u_mqstat, &attr, sizeof(struct kern_mq_attr)))
+		return -EFAULT;
+	return 0;
+}
+
+/*
+*	IOCTL FUNCTION - demultiplexer for various mqueues operations
+*/
+
+static int mqueue_ioctl_file(struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOTTY;
+
+	unlock_kernel();
+
+	switch (cmd) {
+	case MQ_IOC_CREATE:
+		ret = mq_create_ioctl(inode, (struct kern_mq_attr *) arg);
+		break;
+	case MQ_IOC_SEND:
+		ret = mq_send_ioctl(inode, filp->f_flags, (struct ioctl_mq_sndrcv *) arg);
+		break;
+	case MQ_IOC_RECEIVE:
+		ret = mq_receive_ioctl(inode, filp->f_flags, (struct ioctl_mq_sndrcv *) arg);
+		break;
+	case MQ_IOC_NOTIFY:
+		ret = mq_notify_ioctl(inode, (struct sigevent *) arg);
+		break;
+	case MQ_IOC_GETATTR:
+		ret = mq_getattr_ioctl(inode, filp->f_flags, (struct kern_mq_attr *) arg);
+		break;
+	}
+
+	lock_kernel();
+	return ret;
+}
+
+static struct inode_operations mqueue_dir_inode_operations = {
+	.lookup = mqueue_lookup,
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
+static int __init init_mqueue_fs(void)
+{
+	int error;
+	
+	mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
+		sizeof(struct mqueue_inode_info), 0, SLAB_HWCACHE_ALIGN, init_once, NULL);
+
+	if (mqueue_inode_cachep == NULL)
+		return -ENOMEM;
+
+	error = register_filesystem(&mqueue_fs_type);
+	if (error)
+		goto out_inodecache;
+
+	/* internal initialization - not common for vfs */
+	msgs_size = 0;
+	queues_count = 0;
+	spin_lock_init(&mq_lock);
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+	proc_fs_mqueue = proc_mkdir("mqueue", proc_root_fs);
+	if (!proc_fs_mqueue) {
+		error = -ENOMEM;
+		goto out_inodecache;
+	}		
+	proc_fs_mqueue->owner = THIS_MODULE;
+
+	max_queues_file = create_proc_entry("max_queues",0644,proc_fs_mqueue);
+	if(max_queues_file == NULL) {
+		error = -ENOMEM;
+		goto out_max_queues_file;
+	}
+	max_queues_file->read_proc = proc_read_max_queues;
+	max_queues_file->write_proc = proc_write_max_queues;
+	max_queues_file->owner = THIS_MODULE;	
+
+	max_sys_size_file = create_proc_entry("max_sys_size",0644,proc_fs_mqueue);
+	if(max_sys_size_file == NULL) {
+		error = -ENOMEM;
+		goto out_max_sys_size_file;
+	}
+	max_sys_size_file->read_proc = proc_read_max_sys_size;
+	max_sys_size_file->write_proc = proc_write_max_sys_size;
+	max_sys_size_file->owner = THIS_MODULE;	
+
+	msgs_size_file = create_proc_read_entry("msgs_size", 
+						0444, proc_fs_mqueue, 
+						proc_read_msgs_size,
+						NULL);
+	if(msgs_size_file == NULL) {
+		error  = -ENOMEM;
+		goto out_msgs_size_file;
+	}
+	msgs_size_file->owner = THIS_MODULE;
+#endif // CONFIG_POSIX_MQUEUE_FS_PROC
+
+	return 0;
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+out_msgs_size_file:
+	remove_proc_entry("max_sys_size", proc_fs_mqueue);
+
+out_max_sys_size_file:
+	remove_proc_entry("max_queues", proc_fs_mqueue);
+
+out_max_queues_file:
+	remove_proc_entry("mqueue", proc_root_fs);
+#endif // CONFIG_POSIX_MQUEUE_FS_PROC
+
+out_inodecache:
+	if (kmem_cache_destroy(mqueue_inode_cachep))
+		printk(KERN_INFO "mqueue_inode_cache: not all structures were freed\n");
+	return error;
+}
+
+static void __exit exit_mqueue_fs(void)
+{
+	unregister_filesystem(&mqueue_fs_type);
+	if (kmem_cache_destroy(mqueue_inode_cachep))
+		printk(KERN_INFO "mqueue_inode_cache: not all structures were freed\n");
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+	remove_proc_entry("msgs_size", proc_fs_mqueue);
+	remove_proc_entry("max_sys_size", proc_fs_mqueue);
+	remove_proc_entry("max_queues", proc_fs_mqueue);
+	remove_proc_entry("mqueue", proc_root_fs);
+#endif
+}
+
+module_init(init_mqueue_fs)
+module_exit(exit_mqueue_fs) 
+
+MODULE_LICENSE("GPL");
