Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTKPO66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 09:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTKPO66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 09:58:58 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:24964 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S262864AbTKPO6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 09:58:06 -0500
Date: Sun, 16 Nov 2003 15:57:25 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Manfred Spraul <manfred@colorfullife.com>,
       Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD 
Message-ID: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Here is a new version of POSIX message queues. Now it uses syscalls.
There is also one bugfix from previous version.
Supported fs ops: unlink, open, poll, read.
Filesystem can be mounted but mqueues work fine without mounting.
Code for fetching and storing messages was taken from existing Sys V
queues.

Our current todo has two main points:
 - replace currently used algorithm for queuing processes waiting for
send/receive with simpler one (based on sys V implementation little bit)
 - work on SIGEV_THREAD: Urlich Drepper suggested using futexes as the
base of this notification. The idea is nice (I have written a sample code)
but frankly speaking I can't see how to do suggested optimization (one
thread waiting for all possible notifications from kernel and after
getting them spawns another thread which does needed work). Intuitive
solution is with FUTEX_FD & poll but this will have synchronization
problems. The solution with one futex and multiple values would be very
complicated (we need mechanism for cancellation of notification and of
course information which queue(s) produced event(s)). On the another hand
I can think about signals doing all the work - using thread sig mask we
have synchronization and signals can carry quite a lot information. Of
course this are only suggestions and I can miss something about futexes.

Regards
Krzysiek


diff -urN 2.6.0-test9-orig/arch/i386/kernel/entry.S 2.6.0-test9-patched/arch/i386/kernel/entry.S
--- 2.6.0-test9-orig/arch/i386/kernel/entry.S	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/arch/i386/kernel/entry.S	2003-10-19 14:20:23.000000000 +0200
@@ -880,5 +880,12 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_mq_open
+	.long sys_mq_unlink	/* 275 */
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive
+	.long sys_mq_notify
+	.long sys_mq_getattr
+	.long sys_mq_setattr

 nr_syscalls=(.-sys_call_table)/4
diff -urN 2.6.0-test9-orig/CREDITS 2.6.0-test9-patched/CREDITS
--- 2.6.0-test9-orig/CREDITS	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/CREDITS	2003-10-19 14:33:01.000000000 +0200
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
@@ -3475,6 +3484,14 @@
 S: Beaverton, OR 97005
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
diff -urN 2.6.0-test9-orig/Documentation/filesystems/proc.txt 2.6.0-test9-patched/Documentation/filesystems/proc.txt
--- 2.6.0-test9-orig/Documentation/filesystems/proc.txt	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/Documentation/filesystems/proc.txt	2003-10-07 22:03:35.000000000 +0200
@@ -38,6 +38,7 @@
   2.8	/proc/sys/net/ipv4 - IPV4 settings
   2.9	Appletalk
   2.10	IPX
+  2.11  POSIX Message Queues Filesystem

 ------------------------------------------------------------------------------
 Preface
@@ -1805,6 +1806,26 @@
 gives the  destination  network, the router node (or Directly) and the network
 address of the router (or Connected) for internal networks.

+2.11 POSIX Message Queues Filesystem
+
+The "mqueue"  filesystem provides  the necessary kernel features to enable the
+creation of a  user space  library that  implements  the  POSIX message queues
+API (as noted by the  MSG tag in the  POSIX 1003.1-2001 version  of the System
+Interfaces specification.)
+
+The "mqueue"  filesystem  contains both  tunable values as well as informative
+values for determining the amount of resources used by the file system.
+
+/proc/fs/mqueue/max_queues  is  a  read/write  file  for  setting/getting  the
+maximum number of message queues allowed on the system.
+
+/proc/fs/mqueue/max_sys_size  is  a  read/write  file for  setting/getting the
+maximum bytes of memory that can be utilized by the entire  system for storing
+messages.
+
+/proc/fs/mqueue/msgs_size  is  a  read-only  file for getting the total amount
+of memory currently being used to store all messages on the system.
+
 ------------------------------------------------------------------------------
 Summary
 ------------------------------------------------------------------------------
diff -urN 2.6.0-test9-orig/fs/Kconfig 2.6.0-test9-patched/fs/Kconfig
--- 2.6.0-test9-orig/fs/Kconfig	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/fs/Kconfig	2003-10-19 14:22:08.000000000 +0200
@@ -893,6 +893,37 @@
 	  To compile this as a module, choose M here: the module will be called
 	  ramfs.

+config POSIX_MQUEUE_FS
+	bool "POSIX Message Queues"
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
+	  and can be mounted somewhere if you want to do filesystem
+	  operations on message queues.
+
+	  If unsure, say N.
+
+config POSIX_MQUEUE_FS_PROC
+	bool "/proc/fs/mqueue support"
+	depends on POSIX_MQUEUE_FS && PROC_FS
+	---help---
+	 Enabling this option will add various files to the /proc/fs/mqueue
+         directory providing the ability to tune the mqueue filesystem, and
+         also query resource usage.
+
+         For more information on the specific tunables, see
+         Documentation/filesystems/proc.txt.
+
+         There is a small amount of overhead to be paid for adding proc
+         support, but other than that it should be safe to enable this option.
+
 endmenu

 menu "Miscellaneous filesystems"
diff -urN 2.6.0-test9-orig/include/asm-generic/siginfo.h 2.6.0-test9-patched/include/asm-generic/siginfo.h
--- 2.6.0-test9-orig/include/asm-generic/siginfo.h	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/include/asm-generic/siginfo.h	2003-10-19 14:26:04.000000000 +0200
@@ -118,6 +118,7 @@
 #define __SI_FAULT	(3 << 16)
 #define __SI_CHLD	(4 << 16)
 #define __SI_RT		(5 << 16)
+#define __SI_MESGQ	(6 << 16)
 #define __SI_CODE(T,N)	((T) | ((N) & 0xffff))
 #else
 #define __SI_KILL	0
@@ -126,6 +127,7 @@
 #define __SI_FAULT	0
 #define __SI_CHLD	0
 #define __SI_RT		0
+#define __SI_MESGQ	0
 #define __SI_CODE(T,N)	(N)
 #endif

@@ -137,7 +139,7 @@
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_MESGQ,-3) /* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
diff -urN 2.6.0-test9-orig/include/asm-i386/unistd.h 2.6.0-test9-patched/include/asm-i386/unistd.h
--- 2.6.0-test9-orig/include/asm-i386/unistd.h	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/include/asm-i386/unistd.h	2003-10-19 14:27:22.000000000 +0200
@@ -279,8 +279,15 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
-
-#define NR_syscalls 274
+#define __NR_mq_open 		274
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getattr		(__NR_mq_open+5)
+#define __NR_mq_setattr		(__NR_mq_open+6)
+
+#define NR_syscalls 281

 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */

diff -urN 2.6.0-test9-orig/include/linux/mqueue.h 2.6.0-test9-patched/include/linux/mqueue.h
--- 2.6.0-test9-orig/include/linux/mqueue.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.0-test9-patched/include/linux/mqueue.h	2003-10-10 18:31:39.000000000 +0200
@@ -0,0 +1,32 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/signal.h>
+#include <linux/linkage.h>
+
+#define MQ_MAX		64	/* max number of message queues */
+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
+#define MQ_MSGSIZE 	16384	/* max message size */
+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
+#define MQ_PRIO_MAX 	32768	/* max priority */
+
+typedef int mqd_t;
+
+struct mq_attr {
+	long mq_flags;		/* message queue flags */
+	long mq_maxmsg;		/* maximum number of messages */
+	long mq_msgsize;	/* maximum message size */
+	long mq_curmsgs;	/* number of messages currently queued */
+};
+
+asmlinkage mqd_t sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
+asmlinkage int sys_mq_unlink(const char __user *name);
+asmlinkage int mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage ssize_t mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage int mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
+asmlinkage int mq_getattr(mqd_t mqdes, struct mq_attr __user *mqstat);
+asmlinkage int mq_setattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
+
+#endif
diff -urN 2.6.0-test9-orig/ipc/Makefile 2.6.0-test9-patched/ipc/Makefile
--- 2.6.0-test9-orig/ipc/Makefile	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/ipc/Makefile	2003-10-07 22:03:35.000000000 +0200
@@ -5,3 +5,4 @@
 obj-y   := util.o

 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_POSIX_MQUEUE_FS) += mqueue.o
diff -urN 2.6.0-test9-orig/ipc/mqueue.c 2.6.0-test9-patched/ipc/mqueue.c
--- 2.6.0-test9-orig/ipc/mqueue.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.0-test9-patched/ipc/mqueue.c	2003-11-06 16:01:27.000000000 +0100
@@ -0,0 +1,1301 @@
+/*
+ * POSIX message queues filesystem for Linux.
+ *
+ * Copyright (C) 2003   Krzysztof Benedyczak    (golbi@mat.uni.torun.pl)
+ *                      Michal Wronski          (wrona@mat.uni.torun.pl)
+ *
+ * Spinlocks:           Mohamed Abbas           (abbas.mohamed@intel.com)
+ * Proc support:        Rusty Lynch             (rusty@linux.intel.com)
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/mqueue.h>
+#include <linux/msg.h>
+#include <linux/list.h>
+#include <linux/poll.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include "util.h"
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+#include <linux/proc_fs.h>
+#endif
+
+#define MQUEUE_MAGIC	0x19800202
+#define DIRENT_SIZE	20
+#define FILENT_SIZE	60
+#define SEND		0
+#define RECV		1
+
+#define ERRNO_OK_SIGNAL		0
+#define ERRNO_OK_THREAD		1
+#define ERRNO_REMOVE_THREAD	2
+
+
+struct ext_wait_queue {		/* queue of sleeping processes */
+	struct task_struct *task;
+	struct list_head list;
+};
+
+struct mqueue_inode_info {
+	struct mq_attr attr;
+
+
+	struct msg_msg *messages[MQ_MAXMSG];
+
+	struct sigevent notify;
+	pid_t notify_task;
+	pid_t notify_owner; /* == tgid of notify_task */
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
+static inline void remove_notification(struct mqueue_inode_info *info);
+
+static unsigned long msgs_size;	         /* sum of sizes of all msgs in all queues */
+static unsigned long max_sys_size = MQ_MAXSYSSIZE;
+static unsigned int queues_count;        /* number of existing queues */
+static unsigned int max_queues = MQ_MAX; /* maximum number of queues allowed */
+static spinlock_t mq_lock;
+static kmem_cache_t *mqueue_inode_cachep;
+static struct vfsmount *mqueue_mnt;
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+static struct proc_dir_entry *proc_fs_mqueue;
+static struct proc_dir_entry *max_queues_file;
+static struct proc_dir_entry *max_sys_size_file;
+static struct proc_dir_entry *msgs_size_file;
+
+static inline int proc_calc_metrics(char *page, char **start, off_t off,
+				    int count, int *eof, int len)
+{
+	if (len <= off + count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count) len = count;
+	if (len < 0) len = 0;
+	return len;
+}
+
+static int proc_read_max_queues(char *page, char **start,
+				off_t off, int count, int *eof, void *data)
+{
+	int len = sprintf(page, "%u\n", max_queues);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+static int proc_write_max_queues(struct file *file, const char *buffer,
+				 unsigned long count, void *data)
+{
+	char tmp[17];
+	unsigned long len;
+	unsigned int m;
+
+	len = (count > 16) ? 16 : count;
+
+	if (copy_from_user(tmp, buffer, len))
+		return -EFAULT;
+
+	tmp[len] = '\0';
+	if (sscanf(tmp, "%u", &m) <= 0)
+		return -EFAULT;
+
+	spin_lock(&mq_lock);
+	max_queues = m;
+	spin_unlock(&mq_lock);
+
+	return len;
+}
+
+static int proc_read_max_sys_size(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	int len = sprintf(page, "%lu\n", max_sys_size);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+static int proc_write_max_sys_size(struct file *file, const char *buffer,
+				   unsigned long count, void *data)
+{
+	char tmp[17];
+	unsigned long len;
+	unsigned long m;
+
+	len = (count > 16) ? 16 : count;
+
+	if (copy_from_user(tmp, buffer, len))
+		return -EFAULT;
+
+	tmp[len] = '\0';
+	if (sscanf(tmp, "%lu", &m) <= 0)
+		return -EFAULT;
+
+	spin_lock(&mq_lock);
+	max_sys_size = m;
+	spin_unlock(&mq_lock);
+
+	return len;
+}
+
+static int proc_read_msgs_size(char *page, char **start, off_t off,
+			       int count, int *eof, void *data)
+{
+	int len = sprintf(page, "%lu\n", msgs_size);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+#endif /* CONFIG_POSIX_MQUEUE_FS_PROC */
+
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
+
+	inode = new_inode(sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_mtime = inode->i_ctime = inode->i_atime = CURRENT_TIME;
+
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
+			ino_extra->notify_task = 0;
+			ino_extra->notify_owner = 0;
+			ino_extra->notify.sigev_signo = 0;
+			ino_extra->notify.sigev_notify = SIGEV_NONE;
+			ino_extra->qsize = sizeof(struct mqueue_inode_info);
+			ino_extra->attr.mq_curmsgs = 0;
+			/* fill up with defaults */
+			ino_extra->attr.mq_maxmsg = MQ_MAXMSG;
+			ino_extra->attr.mq_msgsize = MQ_MSGSIZE;
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
+static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = MQUEUE_MAGIC;
+	sb->s_op = &mqueue_super_ops;
+
+	inode = mqueue_get_inode(sb, S_IFDIR | S_IRWXUGO);
+	if (!inode)
+		return -ENOMEM;
+
+	sb->s_root = d_alloc_root(inode);
+	if (!sb->s_root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static struct super_block *mqueue_get_sb(struct file_system_type *fs_type,
+					 int flags, const char *dev_name,
+					 void *data)
+{
+	return get_sb_single(fs_type, flags, data, mqueue_fill_super);
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
+	int size, i;
+
+	if ((ino->i_mode & S_IFMT) == S_IFDIR) {
+		clear_inode(ino);
+		return;
+	}
+	info = MQUEUE_I(ino);
+	size = 0;
+
+	spin_lock(&info->lock);
+	for (i = 0; i < info->attr.mq_curmsgs; i++) {
+		size += info->messages[i]->m_ts;
+		free_msg(info->messages[i]);
+	}
+	spin_unlock(&info->lock);
+
+	clear_inode(ino);
+
+	spin_lock(&mq_lock);
+	msgs_size -= size;
+	queues_count--;
+	spin_unlock(&mq_lock);
+}
+
+static int mqueue_unlink(struct inode *dir, struct dentry *dent)
+{
+	struct inode *inode = dent->d_inode;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
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
+	int error;
+
+	spin_lock(&mq_lock);
+	if (queues_count >= max_queues) {
+		error = -ENOSPC;
+		goto out_lock;
+	}
+	queues_count++;
+	spin_unlock(&mq_lock);
+
+	ino = mqueue_get_inode(dir->i_sb, mode);
+	if (!ino) {
+		error = -ENOMEM;
+		spin_lock(&mq_lock);
+		queues_count--;
+		goto out_lock;
+	}
+
+	dir->i_size += DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
+
+	d_instantiate(dent, ino);
+	dget(dent);
+	return 0;
+out_lock:
+	spin_unlock(&mq_lock);
+	return error;
+}
+
+/*
+*	This is routine for system read from queue file.
+*	To avoid mess with doing here some sort of mq_receive we allow
+*	to read only queue size & notification info (the only values
+*	that are interesting from user point of view and aren't accessible
+*	through std. routines)
+*/
+static ssize_t mqueue_read_file(struct file *filp, char __user *data,
+				size_t count, loff_t * off)
+{
+	size_t pos;
+	ssize_t retval;
+	char buffer[FILENT_SIZE + 1];
+	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
+
+	pos = *off;
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+	if (!count)
+		return 0;
+	if (pos >= FILENT_SIZE)
+		return 0;
+	if (pos + count >= FILENT_SIZE)
+		count = FILENT_SIZE - pos - 1;
+
+	if (!access_ok(VERIFY_WRITE, data, count))
+		return -EFAULT;
+
+	snprintf(buffer, FILENT_SIZE + 1,
+		"QSIZE:%-10u NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
+	 	info->qsize, info->notify.sigev_notify,
+	 	info->notify.sigev_signo, info->notify_owner);
+
+	retval = FILENT_SIZE - *off;
+	if (copy_to_user(data, buffer + pos, retval)) {
+		retval = (ssize_t)-EFAULT;
+		goto out;
+	}
+	*off += retval;
+	filp->f_dentry->d_inode->i_atime = filp->f_dentry->d_inode->i_ctime = CURRENT_TIME;
+out:
+	return retval;
+}
+
+
+static int mqueue_release_file(struct inode *ino, struct file *filp)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	spin_lock(&info->lock);
+	if (current->tgid == info->notify_owner)
+		remove_notification(info);
+
+	spin_unlock(&info->lock);
+	return 0;
+}
+
+
+static unsigned int mqueue_poll_file(struct file *filp, struct poll_table_struct *poll_tab)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
+	int retval = 0;
+
+	poll_wait(filp, &info->wait_q[0], poll_tab);
+	poll_wait(filp, &info->wait_q[1], poll_tab);
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
+	struct ext_wait_queue *tmp = list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list);
+	list_del(&(tmp->list));
+	kfree(tmp);
+}
+
+/*
+ * puts current process to sleep
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
+/* wakes up sleeping process */
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
+	/* We can wake up now - either all are sleeping or queue is empty. */
+	if (!list_empty(&info->e_wait_q[sr].list))
+		wake_up_process((list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list))->task);
+	/* for poll */
+	wake_up_interruptible(&(info->wait_q[sr]));
+}
+
+
+/* Auxiliary functions to manipulate messages' list */
+static inline void msg_insert(struct msg_msg *ptr, struct mqueue_inode_info *info)
+{
+	int k;
+
+	k = (info->attr.mq_curmsgs)-1;
+	while ((k >= 0) && (info->messages[k]->m_type >= ptr->m_type)) {
+		info->messages[k + 1] = info->messages[k];
+		k--;
+	}
+	(info->attr.mq_curmsgs)++;
+	info->messages[k + 1] = ptr;
+}
+
+static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
+{
+	return info->messages[--(info->attr.mq_curmsgs)];
+}
+
+/*
+ * The next function is only to split too long mq_send_ioctl
+ */
+static inline void __do_notify(struct mqueue_inode_info *info)
+{
+	struct siginfo sig_i;
+	struct task_struct *p;
+
+	/* notification
+	 * invoked when there is registered process and there isn't process
+	 * waiting synchronously for message AND state of queue changed from
+	 * empty to not empty */
+	if ((info->notify.sigev_notify != SIGEV_NONE) && list_empty(&info->e_wait_q[RECV].list)
+	    && info->attr.mq_curmsgs == 1) {
+
+		sig_i.si_signo = info->notify.sigev_signo;
+		sig_i.si_errno = ERRNO_OK_SIGNAL;
+		sig_i.si_code = SI_MESGQ;
+		sig_i.si_value = info->notify.sigev_value;
+		sig_i.si_pid = current->tgid;
+		sig_i.si_uid = current->uid;
+
+		/* sends signal */
+		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
+			kill_proc_info(info->notify.sigev_signo,
+				       &sig_i, info->notify_task);
+		} else  if (info->notify.sigev_notify == SIGEV_THREAD ||
+			    info->notify.sigev_notify == SIGEV_THREAD_ID) {
+			sig_i.si_errno = ERRNO_OK_THREAD;
+			read_lock(&tasklist_lock);
+			p = find_task_by_pid(info->notify_task);
+			if (p && (p->tgid == info->notify_owner))
+				send_sig_info(info->notify.sigev_signo, &sig_i, p);
+			read_unlock(&tasklist_lock);
+		}
+		/* after notification unregisters process */
+		info->notify_task = 0;
+		info->notify_owner = 0;
+		info->notify.sigev_signo = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
+	}
+}
+
+static inline long prepare_timeout(const struct timespec *arg)
+{
+	struct timespec ts, nowts;
+	long timeout;
+
+	if (arg) {
+		if (copy_from_user(&ts, arg, sizeof(struct timespec)))
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
+static inline void remove_notification(struct mqueue_inode_info *info)
+{
+	struct siginfo sig_i;
+	struct task_struct *p;
+
+	if (info->notify.sigev_notify == SIGEV_THREAD) {
+		/* cancel waiting thread */
+		sig_i.si_signo = info->notify.sigev_signo;
+		sig_i.si_errno = ERRNO_REMOVE_THREAD;
+		sig_i.si_code = SI_MESGQ;
+		sig_i.si_value = info->notify.sigev_value;
+		sig_i.si_pid = current->tgid;
+		sig_i.si_uid = current->uid;
+
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(info->notify_task);
+
+		if (p && (p->tgid == info->notify_owner))
+			send_sig_info(info->notify.sigev_signo, &sig_i, p);
+		read_unlock(&tasklist_lock);
+	}
+	info->notify_task = 0;
+	info->notify_owner = 0;
+	info->notify.sigev_signo = 0;
+	info->notify.sigev_notify = SIGEV_NONE;
+}
+
+/*
+ * Invoked when creating a new queue via sys_mq_open
+ */
+static struct file *do_create(struct dentry *dir, struct dentry *dentry,
+	     int oflag, mode_t mode, struct mq_attr __user *u_attr)
+{
+	struct file *filp;
+	struct inode *ino;
+	struct mqueue_inode_info *info;
+	struct mq_attr attr;
+	int ret;
+
+	if (u_attr != NULL) {
+		if (copy_from_user(&attr, u_attr, sizeof(struct mq_attr)))
+			return ERR_PTR(-EFAULT);
+
+		if (attr.mq_maxmsg <= 0 || attr.mq_msgsize <= 0
+		    || attr.mq_maxmsg > MQ_MAXMSG || attr.mq_msgsize > MQ_MSGSIZE)
+			return ERR_PTR(-EINVAL);
+	}
+
+	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ino = dentry->d_inode;
+	info = MQUEUE_I(ino);
+	if (u_attr != NULL) {
+		info->attr.mq_maxmsg = attr.mq_maxmsg;
+		info->attr.mq_msgsize = attr.mq_msgsize;
+	}
+
+	filp = dentry_open(dentry, mqueue_mnt, oflag);
+	if (!IS_ERR(filp))
+		dget(dentry);
+
+	return filp;
+}
+
+/* opens existing queue */
+static struct file *do_open(struct dentry *dentry, int oflag)
+{
+	struct file *filp;
+	static int oflag2acc[O_ACCMODE] = { MAY_READ, MAY_WRITE, MAY_READ | MAY_WRITE };
+
+	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL))
+		return ERR_PTR(-EACCES);
+
+	filp = dentry_open(dentry, mqueue_mnt, oflag);
+
+	if (!IS_ERR(filp))
+		dget(dentry);
+
+	return filp;
+}
+
+asmlinkage mqd_t sys_mq_open(const char __user *u_name, int oflag, mode_t mode,
+	struct mq_attr __user *attr)
+{
+	struct dentry *dentry;
+	struct file *filp;
+	char   *name;
+	int    fd, error;
+
+	if (IS_ERR(name = getname(u_name)))
+		return PTR_ERR(name);
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		goto out_putname;
+
+	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
+		goto out_err;
+	}
+	mntget(mqueue_mnt);
+
+	if (oflag & O_CREAT) {
+		if (dentry->d_inode) {	/* entry already exists */
+			filp = (oflag & O_EXCL) ? ERR_PTR(-EEXIST) : do_open(dentry, oflag);
+		} else {
+			filp = do_create(mqueue_mnt->mnt_root, dentry, oflag, mode, attr);
+		}
+	} else
+		filp = (dentry->d_inode) ? do_open(dentry, oflag) : ERR_PTR(-ENOENT);
+
+	dput(dentry);
+
+	if (IS_ERR(filp)) {
+		error = PTR_ERR(filp);
+		goto out_putfd;
+	}
+
+	fd_install(fd, filp);
+	goto out_upsem;
+
+out_putfd:
+	mntput(mqueue_mnt);
+	put_unused_fd(fd);
+out_err:
+	fd = error;
+out_upsem:
+	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+out_putname:
+	putname(name);
+	return fd;
+}
+
+
+asmlinkage int sys_mq_unlink(const char __user *u_name)
+{
+	int err;
+	char *name;
+	struct dentry *dentry;
+	struct inode *ino = NULL;
+
+	name = getname(u_name);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
+	if (IS_ERR(dentry)){
+		err = PTR_ERR(dentry);
+		goto out_unlock;
+	}
+	if (permission(dentry->d_inode, MAY_WRITE, NULL))
+	{
+		err = -EACCES;
+		goto out_err;
+	}
+	ino = dentry->d_inode;
+	if (ino)
+		atomic_inc(&ino->i_count);
+
+	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+out_err:
+	dput(dentry);
+
+out_unlock:
+	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	putname(name);
+	if (ino)
+		iput(ino);
+
+	return err;
+}
+
+
+asmlinkage int sys_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
+	size_t msg_len, unsigned int msg_prio, const struct timespec __user *u_abs_timeout)
+{
+	struct file *filp;
+	struct inode *ino;
+	struct ext_wait_queue *wq_ptr;
+	struct msg_msg *msg_ptr;
+	long timeout;
+	int ret;
+	struct mqueue_inode_info *info = MQUEUE_I(ino);
+
+	if (msg_prio >= (unsigned long) MQ_PRIO_MAX)
+		return -EINVAL;
+
+	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
+		return timeout;
+
+	ret = -EBADF;
+	filp = fget(mqdes);
+	if (!filp)
+		goto out;
+
+	ino = filp->f_dentry->d_inode;
+	if (ino->i_sb->s_magic != MQUEUE_MAGIC)
+		goto out_fput;
+	info = MQUEUE_I(ino);
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY)
+		goto out_fput;
+
+	/* first try to allocate memory, before doing anything with
+	 * existing queues */
+	msg_ptr = load_msg((void *)u_msg_ptr, msg_len);
+	if (IS_ERR(msg_ptr)) {
+		ret = PTR_ERR(msg_ptr);
+		goto out_fput;
+	}
+
+	/* This memory may be unnecessary but we must alloc it here
+	 * because of spinlock. kfree is called in wq_remove(_last) */
+	wq_ptr = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (wq_ptr == NULL) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	spin_lock(&info->lock);
+
+	if ((filp->f_flags & O_NONBLOCK) && (info->attr.mq_curmsgs == info->attr.mq_maxmsg)) {
+		ret = -EAGAIN;
+		goto out_1unlock;
+	}
+
+	if (msg_len > info->attr.mq_msgsize) {
+		ret = -EMSGSIZE;
+		goto out_1unlock;
+	}
+
+	/* checks if queue is full -> I'm waiting as O_NONBLOCK isn't
+	 * set then. mq_receive wakes up only 1 process */
+	if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
+		ret = wq_sleep(info, SEND, timeout, wq_ptr);
+		if (ret)
+			goto out_1unlock_nofree;
+	} else
+		kfree(wq_ptr);
+
+	spin_lock(&mq_lock);
+
+	if (msgs_size + msg_len > max_sys_size) {
+		ret = -ENOMEM;
+		goto out_2unlock;
+	}
+	msgs_size += msg_len;
+
+	spin_unlock(&mq_lock);
+
+	/* adds message to the queue */
+	msg_ptr->m_ts = msg_len;
+	msg_ptr->m_type = msg_prio;
+
+	msg_insert(msg_ptr, info);
+
+	info->qsize += msg_len;
+	ino->i_atime = ino->i_mtime = ino->i_ctime = CURRENT_TIME;
+	__do_notify(info);
+
+	/* after sending message we must wake up (ONLY 1 no matter which) */
+	/* process sleeping in wq_wakeup() */
+	wake_up(&(info->wait_q2[SEND]));
+
+	/* wakes up process waiting for message */
+	wq_wakeup(info, RECV);
+
+	spin_unlock(&info->lock);
+	ret = 0;
+	goto out_fput;
+
+	/* I hate this goto convention... */
+out_2unlock:
+	spin_unlock(&mq_lock);
+	goto out_1unlock_nofree;
+out_1unlock:
+	kfree(wq_ptr);
+out_1unlock_nofree:
+	spin_unlock(&info->lock);
+out_free:
+	free_msg(msg_ptr);
+out_fput:
+	fput(filp);
+out:
+	return ret;
+}
+
+asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
+	size_t msg_len, unsigned int __user *u_msg_prio, const struct timespec __user *u_abs_timeout)
+{
+	long timeout;
+	ssize_t ret;
+	struct msg_msg *msg_ptr;
+	struct file *filp;
+	struct inode *ino;
+	struct mqueue_inode_info *info;
+	struct ext_wait_queue *wq_ptr;
+
+	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
+		return timeout;
+
+	ret = -EBADF;
+	filp = fget(mqdes);
+	if (!filp)
+		goto out;
+
+	ino = filp->f_dentry->d_inode;
+	if (ino->i_sb->s_magic != MQUEUE_MAGIC)
+		goto out_fput;
+	info = MQUEUE_I(ino);
+
+	if ((filp->f_flags & O_ACCMODE) == O_WRONLY)
+		goto out_fput;
+
+        /* The same as in send */
+	wq_ptr = kmalloc(sizeof(struct ext_wait_queue), GFP_KERNEL);
+	if (wq_ptr == NULL) {
+		ret = -ENOMEM;
+		goto out_fput;
+	}
+
+	spin_lock(&info->lock);
+
+	/* checks if O_NONBLOCK is set and queue is empty */
+	if ((filp->f_flags & O_NONBLOCK) && (info->attr.mq_curmsgs == 0)) {
+		ret = -EAGAIN;
+		goto out_1unlock;
+	}
+
+	/* checks if buffer is big enough */
+	if (msg_len < info->attr.mq_msgsize) {
+		ret = -EMSGSIZE;
+		goto out_1unlock;
+	}
+
+	/* checks if queue is empty -> as O_NONBLOCK isn't set then
+	 * we must wait */
+	if (info->attr.mq_curmsgs == 0) {
+		ret = wq_sleep(info, RECV, timeout, wq_ptr);
+		if (ret < 0)
+			goto out_unlock_only;
+	} else
+		kfree(wq_ptr);
+
+	msg_ptr = msg_get(info);
+	ret = msg_ptr->m_ts;
+
+	/* decrease total space used by messages */
+	spin_lock(&mq_lock);
+	msgs_size -= ret;
+	spin_unlock(&mq_lock);
+	info->qsize -= ret;
+	ino->i_atime = ino->i_mtime = ino->i_ctime = CURRENT_TIME;
+
+	/* after receive we can wakeup 1 process waiting in wq_wakeup */
+	wake_up(&(info->wait_q2[RECV]));
+	/* wakes up process waiting for sending message */
+	wq_wakeup(info, SEND);
+
+	spin_unlock(&info->lock);
+
+	if (u_msg_prio) {
+		if (put_user(msg_ptr->m_type, u_msg_prio)) {
+			ret = -EFAULT;
+			goto out_2free;
+		}
+        }
+	if (store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts))
+		ret = -EFAULT;
+
+out_2free:
+	free_msg(msg_ptr);
+	goto out_fput;
+out_1unlock:
+	kfree(wq_ptr);
+out_unlock_only:
+	spin_unlock(&info->lock);
+out_fput:
+	fput(filp);
+out:
+	return ret;
+}
+
+
+/* Notes: the case when user wants us to deregister (with NULL as pointer or SIGEV_NONE)
+ * and he isn't currently owner of notification will be silently discarded.
+ * It isn't explicitly defined in the POSIX.
+ */
+asmlinkage int sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u_notification)
+{
+	int ret;
+	struct file *filp;
+	struct inode *ino;
+	struct sigevent notification;
+	struct mqueue_inode_info *info;
+
+	if (u_notification != NULL) {
+		if (copy_from_user(&notification, u_notification, sizeof(struct sigevent)))
+			return -EFAULT;
+
+		if (unlikely(notification.sigev_notify != SIGEV_NONE &&
+			     notification.sigev_notify != SIGEV_SIGNAL &&
+			     notification.sigev_notify != SIGEV_THREAD))
+			return -EINVAL;
+	}
+
+	ret = -EBADF;
+	filp = fget(mqdes);
+	if (!filp)
+		goto out;
+
+	ino = filp->f_dentry->d_inode;
+	if (ino->i_sb->s_magic != MQUEUE_MAGIC)
+		goto out_fput;
+	info = MQUEUE_I(ino);
+
+	ret = 0;
+	spin_lock(&info->lock);
+
+	if (u_notification == NULL || notification.sigev_notify == SIGEV_NONE) {
+		if (info->notify_owner == current->tgid)
+			remove_notification(info);
+		goto out_unlock;
+	}
+
+	if (info->notify_task) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	/* add notification */
+	if (notification.sigev_signo < 0 || notification.sigev_signo > _NSIG)
+		ret = -EINVAL;
+	else {
+		info->notify_task = current->pid;
+		info->notify_owner = current->tgid;
+		info->notify.sigev_signo = notification.sigev_signo;
+		info->notify.sigev_notify = notification.sigev_notify;
+		info->notify.sigev_value = notification.sigev_value;
+	}
+out_unlock:
+	ino->i_atime = ino->i_ctime = CURRENT_TIME;
+	spin_unlock(&info->lock);
+out_fput:
+	fput(filp);
+out:
+	return ret;
+}
+
+asmlinkage int sys_mq_getattr(mqd_t mqdes, struct mq_attr __user *u_mqstat)
+{
+	int ret;
+	struct mq_attr attr;
+	struct file *filp;
+	struct inode *ino;
+	struct mqueue_inode_info *info;
+
+	if (u_mqstat == NULL)
+		return -EINVAL;
+
+	ret = -EBADF;
+	filp = fget(mqdes);
+	if (!filp)
+		goto out;
+
+	ino = filp->f_dentry->d_inode;
+	if (ino->i_sb->s_magic != MQUEUE_MAGIC)
+		goto out_fput;
+	info = MQUEUE_I(ino);
+
+	spin_lock(&info->lock);
+	attr = info->attr;
+	attr.mq_flags = filp->f_flags;
+	ino->i_atime = ino->i_ctime = CURRENT_TIME;
+
+	spin_unlock(&info->lock);
+
+	ret = 0;
+	if (copy_to_user(u_mqstat, &attr, sizeof(struct mq_attr)))
+		ret = -EFAULT;
+
+out_fput:
+	fput(filp);
+out:
+	return ret;
+}
+
+asmlinkage int sys_mq_setattr(mqd_t mqdes, const struct mq_attr __user *u_mqstat,
+	struct mq_attr __user *u_omqstat)
+{
+	int ret;
+	struct mq_attr mqstat, omqstat;
+	struct file *filp;
+	struct inode *ino;
+	struct mqueue_inode_info *info;
+
+	if (u_mqstat == NULL)
+		return -EINVAL;
+
+	if (copy_from_user(&mqstat, u_mqstat, sizeof (struct mq_attr)))
+		return -EFAULT;
+
+	ret = -EBADF;
+	filp = fget(mqdes);
+	if (!filp)
+		goto out;
+
+	ino = filp->f_dentry->d_inode;
+	if (ino->i_sb->s_magic != MQUEUE_MAGIC)
+		goto out_fput;
+	info = MQUEUE_I(ino);
+
+	spin_lock(&info->lock);
+
+	omqstat = info->attr;
+	omqstat.mq_flags = filp->f_flags;
+
+	if (mqstat.mq_flags & O_NONBLOCK)
+		filp->f_flags |= O_NONBLOCK;
+	else
+		filp->f_flags &= ~O_NONBLOCK;
+
+	ino->i_atime = ino->i_ctime = CURRENT_TIME;
+
+	spin_unlock(&info->lock);
+
+	ret = 0;
+	if (u_omqstat != NULL && copy_to_user(u_omqstat, &omqstat, sizeof(struct mq_attr)))
+		ret = -EFAULT;
+
+out_fput:
+	fput(filp);
+out:
+	return ret;
+}
+
+
+static struct inode_operations mqueue_dir_inode_operations = {
+	.lookup = mqueue_lookup,
+	.create = mqueue_create,
+	.unlink = mqueue_unlink,
+};
+
+static struct file_operations mqueue_file_operations = {
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
+	if (IS_ERR(mqueue_mnt = kern_mount(&mqueue_fs_type))) {
+		unregister_filesystem(&mqueue_fs_type);
+		error = PTR_ERR(mqueue_mnt);
+		goto out_inodecache;
+	}
+
+	/* internal initialization - not common for vfs */
+	msgs_size = 0;
+	queues_count = 0;
+	spin_lock_init(&mq_lock);
+
+#ifdef CONFIG_POSIX_MQUEUE_FS_PROC
+	error = -ENOMEM;
+	if (!(proc_fs_mqueue = proc_mkdir("mqueue", proc_root_fs)))
+		goto out_inodecache;
+
+	if (!(max_queues_file = create_proc_entry("max_queues", 0644, proc_fs_mqueue)))
+		goto out_max_queues_file;
+	max_queues_file->read_proc = proc_read_max_queues;
+	max_queues_file->write_proc = proc_write_max_queues;
+
+	if (!(max_sys_size_file = create_proc_entry("max_sys_size", 0644, proc_fs_mqueue)))
+		goto out_max_sys_size_file;
+	max_sys_size_file->read_proc = proc_read_max_sys_size;
+	max_sys_size_file->write_proc = proc_write_max_sys_size;
+
+	if ( !(msgs_size_file = create_proc_read_entry("msgs_size", 0444,
+				proc_fs_mqueue, proc_read_msgs_size, NULL)))
+		goto out_msgs_size_file;
+#endif /* CONFIG_POSIX_MQUEUE_FS_PROC */
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
+#endif /* CONFIG_POSIX_MQUEUE_FS_PROC */
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
+__initcall(init_mqueue_fs);
diff -urN 2.6.0-test9-orig/ipc/msg.c 2.6.0-test9-patched/ipc/msg.c
--- 2.6.0-test9-orig/ipc/msg.c	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/ipc/msg.c	2003-11-07 18:30:17.000000000 +0100
@@ -51,11 +51,6 @@
 	struct task_struct* tsk;
 };

-struct msg_msgseg {
-	struct msg_msgseg* next;
-	/* the next part of the message follows immediately */
-};
-
 #define SEARCH_ANY		1
 #define SEARCH_EQUAL		2
 #define SEARCH_NOTEQUAL		3
@@ -129,106 +124,6 @@
 	return msg_buildid(id,msq->q_perm.seq);
 }

-static void free_msg(struct msg_msg* msg)
-{
-	struct msg_msgseg* seg;
-
-	security_msg_msg_free(msg);
-
-	seg = msg->next;
-	kfree(msg);
-	while(seg != NULL) {
-		struct msg_msgseg* tmp = seg->next;
-		kfree(seg);
-		seg = tmp;
-	}
-}
-
-static struct msg_msg* load_msg(void* src, int len)
-{
-	struct msg_msg* msg;
-	struct msg_msgseg** pseg;
-	int err;
-	int alen;
-
-	alen = len;
-	if(alen > DATALEN_MSG)
-		alen = DATALEN_MSG;
-
-	msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);
-	if(msg==NULL)
-		return ERR_PTR(-ENOMEM);
-
-	msg->next = NULL;
-	msg->security = NULL;
-
-	if (copy_from_user(msg+1, src, alen)) {
-		err = -EFAULT;
-		goto out_err;
-	}
-
-	len -= alen;
-	src = ((char*)src)+alen;
-	pseg = &msg->next;
-	while(len > 0) {
-		struct msg_msgseg* seg;
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
-		if(seg==NULL) {
-			err=-ENOMEM;
-			goto out_err;
-		}
-		*pseg = seg;
-		seg->next = NULL;
-		if(copy_from_user (seg+1, src, alen)) {
-			err = -EFAULT;
-			goto out_err;
-		}
-		pseg = &seg->next;
-		len -= alen;
-		src = ((char*)src)+alen;
-	}
-
-	err = security_msg_msg_alloc(msg);
-	if (err)
-		goto out_err;
-
-	return msg;
-
-out_err:
-	free_msg(msg);
-	return ERR_PTR(err);
-}
-
-static int store_msg(void* dest, struct msg_msg* msg, int len)
-{
-	int alen;
-	struct msg_msgseg *seg;
-
-	alen = len;
-	if(alen > DATALEN_MSG)
-		alen = DATALEN_MSG;
-	if(copy_to_user (dest, msg+1, alen))
-		return -1;
-
-	len -= alen;
-	dest = ((char*)dest)+alen;
-	seg = msg->next;
-	while(len > 0) {
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		if(copy_to_user (dest, seg+1, alen))
-			return -1;
-		len -= alen;
-		dest = ((char*)dest)+alen;
-		seg=seg->next;
-	}
-	return 0;
-}
-
 static inline void ss_add(struct msg_queue* msq, struct msg_sender* mss)
 {
 	mss->tsk=current;
diff -urN 2.6.0-test9-orig/ipc/util.c 2.6.0-test9-patched/ipc/util.c
--- 2.6.0-test9-orig/ipc/util.c	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/ipc/util.c	2003-10-22 14:37:27.000000000 +0200
@@ -24,10 +24,13 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/mqueue.h>

-#if defined(CONFIG_SYSVIPC)
-
+#if defined(CONFIG_SYSVIPC) || defined(CONFIG_POSIX_MQUEUE_FS)
 #include "util.h"
+#endif
+
+#if defined(CONFIG_SYSVIPC)

 /**
  *	ipc_init	-	initialise IPC subsystem
@@ -611,3 +614,154 @@
 }

 #endif /* CONFIG_SYSVIPC */
+
+#if defined(CONFIG_POSIX_MQUEUE_FS) || defined(CONFIG_SYSVIPC)
+
+void free_msg(struct msg_msg* msg)
+{
+	struct msg_msgseg* seg;
+
+	security_msg_msg_free(msg);
+
+	seg = msg->next;
+	kfree(msg);
+	while(seg != NULL) {
+		struct msg_msgseg* tmp = seg->next;
+		kfree(seg);
+		seg = tmp;
+	}
+}
+
+struct msg_msg* load_msg(void* src, int len)
+{
+	struct msg_msg* msg;
+	struct msg_msgseg** pseg;
+	int err;
+	int alen;
+
+	alen = len;
+	if(alen > DATALEN_MSG)
+		alen = DATALEN_MSG;
+
+	msg = (struct msg_msg *) kmalloc (sizeof(*msg) + alen, GFP_KERNEL);
+	if(msg==NULL)
+		return ERR_PTR(-ENOMEM);
+
+	msg->next = NULL;
+	msg->security = NULL;
+
+	if (copy_from_user(msg+1, src, alen)) {
+		err = -EFAULT;
+		goto out_err;
+	}
+
+	len -= alen;
+	src = ((char*)src)+alen;
+	pseg = &msg->next;
+	while(len > 0) {
+		struct msg_msgseg* seg;
+		alen = len;
+		if(alen > DATALEN_SEG)
+			alen = DATALEN_SEG;
+		seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
+		if(seg==NULL) {
+			err=-ENOMEM;
+			goto out_err;
+		}
+		*pseg = seg;
+		seg->next = NULL;
+		if(copy_from_user (seg+1, src, alen)) {
+			err = -EFAULT;
+			goto out_err;
+		}
+		pseg = &seg->next;
+		len -= alen;
+		src = ((char*)src)+alen;
+	}
+
+	err = security_msg_msg_alloc(msg);
+	if (err)
+		goto out_err;
+
+	return msg;
+
+out_err:
+	free_msg(msg);
+	return ERR_PTR(err);
+}
+
+int store_msg(void* dest, struct msg_msg* msg, int len)
+{
+	int alen;
+	struct msg_msgseg *seg;
+
+	alen = len;
+	if(alen > DATALEN_MSG)
+		alen = DATALEN_MSG;
+	if(copy_to_user (dest, msg+1, alen))
+		return -1;
+
+	len -= alen;
+	dest = ((char*)dest)+alen;
+	seg = msg->next;
+	while(len > 0) {
+		alen = len;
+		if(alen > DATALEN_SEG)
+			alen = DATALEN_SEG;
+		if(copy_to_user (dest, seg+1, alen))
+			return -1;
+		len -= alen;
+		dest = ((char*)dest)+alen;
+		seg=seg->next;
+	}
+	return 0;
+}
+
+#endif
+
+#if !defined(CONFIG_POSIX_MQUEUE_FS)
+
+/*
+ * Return ENOSYS when posix mqueue filesystem is not compiled in
+ */
+
+asmlinkage mqd_t sys_mq_open(const char *name, int oflag, mode_t mode,
+	struct mq_attr *attr)
+{
+	return (mqd_t)-ENOSYS;
+}
+
+asmlinkage int sys_mq_unlink(const char *name)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_timedsend(mqd_t mqdes, const char *msg_ptr,
+	size_t msg_len, unsigned int msg_prio, const struct timespec *abs_timeout)
+{
+	return -ENOSYS;
+}
+
+asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char *msg_ptr,
+	size_t msg_len, unsigned int *msg_prio, const struct timespec *abs_timeout)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_notify(mqd_t mqdes, const struct sigevent *notification)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_setattr(mqd_t mqdes, const struct mq_attr *mqstat,
+	struct mq_attr *omqstat)
+{
+	return -ENOSYS;
+}
+
+#endif
diff -urN 2.6.0-test9-orig/ipc/util.h 2.6.0-test9-patched/ipc/util.h
--- 2.6.0-test9-orig/ipc/util.h	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/ipc/util.h	2003-10-22 14:34:59.000000000 +0200
@@ -25,6 +25,16 @@
 	struct kern_ipc_perm* p;
 };

+struct msg_msgseg {
+	struct msg_msgseg* next;
+	/* the next part of the message follows immediately */
+};
+
+void free_msg(struct msg_msg* msg);
+struct msg_msg* load_msg(void* src, int len);
+int store_msg(void* dest, struct msg_msg* msg, int len);
+
+
 void __init ipc_init_ids(struct ipc_ids* ids, int size);

 /* must be called with ids->sem acquired.*/
diff -urN 2.6.0-test9-orig/kernel/signal.c 2.6.0-test9-patched/kernel/signal.c
--- 2.6.0-test9-orig/kernel/signal.c	2003-11-07 17:07:13.000000000 +0100
+++ 2.6.0-test9-patched/kernel/signal.c	2003-10-19 14:31:03.000000000 +0200
@@ -2046,6 +2046,7 @@
 		err |= __put_user(from->si_stime, &to->si_stime);
 		break;
 	case __SI_RT: /* This is not generated by the kernel as of now. */
+	case __SI_MESGQ: /* But this is */
 		err |= __put_user(from->si_pid, &to->si_pid);
 		err |= __put_user(from->si_uid, &to->si_uid);
 		err |= __put_user(from->si_int, &to->si_int);
