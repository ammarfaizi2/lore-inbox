Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSKXWw7>; Sun, 24 Nov 2002 17:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSKXWw7>; Sun, 24 Nov 2002 17:52:59 -0500
Received: from smtpout.mac.com ([17.250.248.85]:4862 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261872AbSKXWwp>;
	Sun, 24 Nov 2002 17:52:45 -0500
From: Peter Waechtler <pwaechtler@mac.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] unified SysV and POSIX mqueues - complete rewrite
Date: Mon, 25 Nov 2002 00:05:00 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C4S3XUGYHUSQ8R1F4VZO"
Message-Id: <200211250005.00447.pwaechtler@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C4S3XUGYHUSQ8R1F4VZO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

[part to lkml]
Alan, feel invited to add it to your -ac tree :-)

There are at least 3 attempts to provide POSIX mqueues for Linux:

a) early attempt of Jakub Jelinek based on 2.4-test based on a
filesystem with read/write/ioctl interface - very intrusive to ipc/msg.c

b) http://www.mat.uni.torun.pl/~wrona/posix_ipc
complicated standalone version (against recent 2.4), with 
multiplexed syscall - and great effort to keep track of resources
which is far easier accomplished by vfs

c) based on a filesystem with its own syscalls and clean separation
(but dependence ) on SysV ipc/msg.c
why separate syscalls? you cannot specify the priority of a sent
message without ioctl/fcntl, also problems with timed versions - and
yes there is an outstanding issue with priority aware waitqueues

interface stub and userspace implementation is on
http://homepage.mac.com/pwaechtler/linux/mqueue.tgz

The userspace implementation is not complete. There we have the problems
with the locks on crashing apps (we could use flock), signal safety but what
about the timed versions? Performance is not as good as kernel version!?

following patch is against 2.5.49


--------------Boundary-00=_C4S3XUGYHUSQ8R1F4VZO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kernel.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="kernel.patch"

diff -X dontdiff -Nur vanilla-2.5.49/arch/i386/kernel/entry.S linux-2.5.49/arch/i386/kernel/entry.S
--- vanilla-2.5.49/arch/i386/kernel/entry.S	2002-11-23 17:04:27.000000000 +0100
+++ linux-2.5.49/arch/i386/kernel/entry.S	2002-11-23 17:13:38.000000000 +0100
@@ -741,8 +741,19 @@
 	.long sys_epoll_create
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
- 	.long sys_remap_file_pages
- 	.long sys_set_tid_address
+	.long sys_remap_file_pages
+	.long sys_set_tid_address
+	.long sys_ni_syscall
+	.long sys_ni_syscall	/* 260 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend	/* 265 */
+	.long sys_mq_timedreceive
+	.long sys_mq_notify
+	.long sys_mq_getattr
+	.long sys_mq_setattr
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -X dontdiff -Nur vanilla-2.5.49/include/asm-i386/unistd.h linux-2.5.49/include/asm-i386/unistd.h
--- vanilla-2.5.49/include/asm-i386/unistd.h	2002-11-21 00:18:34.000000000 +0100
+++ linux-2.5.49/include/asm-i386/unistd.h	2002-11-24 01:49:32.000000000 +0100
@@ -261,9 +261,16 @@
 #define __NR_sys_epoll_create	254
 #define __NR_sys_epoll_ctl	255
 #define __NR_sys_epoll_wait	256
-#define __NR_remap_file_pages	257
+#define __NR_remap_file_pages 257
 #define __NR_set_tid_address	258
-
+#define __NR_sys_mq_open	263
+#define __NR_sys_mq_unlink	264
+#define __NR_mq_timedsend	265
+#define __NR_mq_timedreceive	266
+#define __NR_mq_notify	267
+#define __NR_mq_getattr	268
+#define __NR_mq_setattr	269
+  
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -X dontdiff -Nur vanilla-2.5.49/include/linux/mqueue.h linux-2.5.49/include/linux/mqueue.h
--- vanilla-2.5.49/include/linux/mqueue.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.49/include/linux/mqueue.h	2002-11-24 17:20:20.000000000 +0100
@@ -0,0 +1,49 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
+#define MQ_PRIO_MAX 	100000	/* max priority */
+
+#define MSGFS_MAGIC 0x4D455347
+#define  _POSIX_MESSAGE_PASSING 1
+
+typedef int mqd_t;		/* message queue descriptor */
+
+struct mq_attr {
+	long mq_flags;		/* message queue flags */
+	long mq_maxmsg;		/* maximum number of messages */
+	long mq_msgsize;	/* maximum message size */
+	long mq_curmsgs;	/* number of messages currently queued */
+};
+
+asmlinkage mqd_t sys_mq_open(const char *u_path, int oflag, mode_t mode,
+	struct mq_attr *u_attr);
+asmlinkage int sys_mq_close(mqd_t mqdes);
+asmlinkage int sys_mq_unlink(const char *u_name);
+asmlinkage int sys_mq_timedsend(mqd_t mqdes, const char *msg_ptr, 
+	size_t msg_len, unsigned int msg_prio, struct timespec *utime);
+asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char *msg_ptr, 
+	size_t msg_len, unsigned int *msg_prio, struct timespec *utime);
+asmlinkage int sys_mq_notify(mqd_t mqdes,
+	const struct sigevent *u_notification);
+asmlinkage int sys_mq_getattr(mqd_t mqdes, struct mq_attr *u_mqstat);
+asmlinkage int sys_mq_setattr(mqd_t mqdes, const struct mq_attr *u_mqstat,
+	struct mq_attr *u_omqstat);
+
+#ifdef __KERNEL__
+
+struct mqueue_ds {		/* queue */
+	struct mq_attr attr;
+	struct msg_queue queue;	/* ipc/msg */
+
+	spinlock_t lock;
+	wait_queue_head_t wait_recv;
+	wait_queue_head_t wait_send;
+
+	pid_t notify_pid;	/* who we have to notify (or 0) */
+	struct sigevent notify;	/* notification */
+};
+#endif /* __KERNEL__ */
+
+#endif
diff -X dontdiff -Nur vanilla-2.5.49/include/linux/sys.h linux-2.5.49/include/linux/sys.h
--- vanilla-2.5.49/include/linux/sys.h	2002-11-01 01:15:04.000000000 +0100
+++ linux-2.5.49/include/linux/sys.h	2002-11-01 16:36:48.000000000 +0100
@@ -4,7 +4,7 @@
 /*
  * system call entry points ... but not all are defined
  */
-#define NR_syscalls 260
+#define NR_syscalls 270
 
 /*
  * These are system calls that will be removed at some time
diff -X dontdiff -Nur vanilla-2.5.49/init/Kconfig linux-2.5.49/init/Kconfig
--- vanilla-2.5.49/init/Kconfig	2002-11-21 00:18:37.000000000 +0100
+++ linux-2.5.49/init/Kconfig	2002-11-21 00:26:40.000000000 +0100
@@ -69,6 +69,13 @@
 	  section 6.4 of the Linux Programmer's Guide, available from
 	  <http://www.linuxdoc.org/docs.html#guide>.
 
+config POSIXMSG
+	bool "POSIX message queues"
+	depends on SYSVIPC
+	---help---
+	  This gives you POSIX compliant interfaces for message queues.
+
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	help
diff -X dontdiff -Nur vanilla-2.5.49/ipc/Makefile linux-2.5.49/ipc/Makefile
--- vanilla-2.5.49/ipc/Makefile	2002-09-23 15:54:57.000000000 +0200
+++ linux-2.5.49/ipc/Makefile	2002-11-04 17:50:24.000000000 +0100
@@ -6,4 +6,8 @@
 
 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
 
+ifeq ($(CONFIG_POSIXMSG),y)
+obj-$(CONFIG_SYSVIPC) += posixmsg.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -X dontdiff -Nur vanilla-2.5.49/ipc/msg.c linux-2.5.49/ipc/msg.c
--- vanilla-2.5.49/ipc/msg.c	2002-11-21 00:18:37.000000000 +0100
+++ linux-2.5.49/ipc/msg.c	2002-11-21 00:26:40.000000000 +0100
@@ -127,7 +127,7 @@
 	return msg_buildid(id,msq->q_perm.seq);
 }
 
-static void free_msg(struct msg_msg* msg)
+void free_msg(struct msg_msg* msg)
 {
 	struct msg_msgseg* seg;
 	seg = msg->next;
@@ -139,7 +139,7 @@
 	}
 }
 
-static struct msg_msg* load_msg(void* src, int len)
+struct msg_msg* load_msg(void* src, int len)
 {
 	struct msg_msg* msg;
 	struct msg_msgseg** pseg;
@@ -191,7 +191,7 @@
 	return ERR_PTR(err);
 }
 
-static int store_msg(void* dest, struct msg_msg* msg, int len)
+int store_msg(void* dest, struct msg_msg* msg, int len)
 {
 	int alen;
 	struct msg_msgseg *seg;
diff -X dontdiff -Nur vanilla-2.5.49/ipc/posixmsg.c linux-2.5.49/ipc/posixmsg.c
--- vanilla-2.5.49/ipc/posixmsg.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.49/ipc/posixmsg.c	2002-11-24 17:27:42.000000000 +0100
@@ -0,0 +1,829 @@
+/*
+ *  linux/ipc/posixmsg.c
+ *
+ *  Copyright 2002 Peter Wächtler <pwaechtler@mac.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * root can mount the filesystem to see the names of the currently
+ * used mqueues. The i_size shows the number of msgs in the queue.
+ * The only shell operation on the "fifos" is an unlink() via rm(1)
+ * The queues are accessed through syscalls - poll is supported
+ *
+ * put MSGFS_MAGIC into mqueue.h
+ * update inode->m_time on send (yes, no posix semantics on this)
+ * update inode->a_time on recv
+ * translate absolute timeouts in kernel to prevent too long sleeps
+ *
+ * TODO:
+ *	check for more sysv msg limits (or add some new, e.g. MQ_PRIO_MAX)?
+ *  implement SIGEV_THREAD with clone_startup(hey, where is it?)
+ *  think about prio based waitqueues: simply enqueue them in order?
+ *   bits/posix_opt.h  claims to support _POSIX_PRIORITY_SCHEDULING
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>	/* PAGE_CACHE_SIZE */
+#include <linux/poll.h>
+
+#include <linux/mqueue.h>
+#include <linux/msg.h>
+#include <asm/uaccess.h>
+
+/* functions used from ipc/msg.c */
+extern void free_msg(struct msg_msg *msg);
+extern int store_msg(void *dest, struct msg_msg *msg, int len);
+extern struct msg_msg *load_msg(void *src, int len);
+
+extern int msg_ctlmnb;		/* default max size of a message queue (all msgs sum up) */
+extern int msg_ctlmni;		/* max # of msg queue identifiers */
+extern int msg_ctlmax;		/* max size of one message (bytes) */
+
+static int mqueue_release(struct inode *inode, struct dentry *dentry);
+static int mqueue_close(struct inode *inode, struct file *filp);
+static unsigned int mqueue_poll(struct file *, struct poll_table_struct *);
+
+static atomic_t msg_bytes = ATOMIC_INIT(0);
+static struct vfsmount *msg_mnt;
+
+static struct file_operations msg_fops = {
+	.llseek = no_llseek,
+	.release = mqueue_close,
+	.poll = mqueue_poll,
+};
+static struct inode_operations msg_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.unlink = mqueue_release,
+};
+
+static struct msg_queue *
+init_queue(struct msg_queue *queue)
+{
+	int retval;
+
+	queue->q_perm.mode = 0;
+	queue->q_perm.key = 0;
+	queue->q_perm.security = NULL;
+	retval = security_ops->msg_queue_alloc_security(queue);
+	if (retval)
+		return ERR_PTR(retval);;
+
+	queue->q_stime = queue->q_rtime = 0;
+	queue->q_qbytes = queue->q_cbytes = queue->q_qnum = 0;
+	queue->q_lspid = queue->q_lrpid = 0;
+	INIT_LIST_HEAD(&queue->q_messages);
+	INIT_LIST_HEAD(&queue->q_receivers);	/* unused */
+	INIT_LIST_HEAD(&queue->q_senders);	/* unused */
+
+	return queue;
+}
+
+static struct inode *
+get_msg_inode(struct super_block *sb, mode_t mode)
+{
+	struct mqueue_ds *q;
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_blksize = 1024;
+		switch (mode & S_IFMT) {
+		default:
+		case S_IFIFO:
+		case S_IFREG:
+			inode->i_fop = &msg_fops;
+			if ((q = kmalloc(sizeof (*q), GFP_KERNEL))) {
+				if (!init_queue(&q->queue)) {
+					kfree(q);
+					iput(inode);
+					inode = ERR_PTR(-EACCES);
+				}
+				inode->u.generic_ip = q;
+			} else {
+				iput(inode);
+				inode = ERR_PTR(-ENOSPC);
+			}
+			break;
+		case S_IFDIR:
+			inode->i_op = &msg_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inode->i_nlink++;
+			break;
+		case S_IFLNK:
+			break;
+		}
+	} else
+		inode = ERR_PTR(-ENOSPC);
+
+	return inode;
+}
+
+#define get_mqueue(filp)\
+	((filp) ? filp->f_dentry->d_inode->u.generic_ip: filp)
+
+/* don't use fget() to avoid the fput() for no good reason */
+static struct file *
+mqueue_lookup(mqd_t fd)
+{
+	struct files_struct *files = current->files;
+
+	read_lock(&files->file_lock);
+	if (fd >= files->max_fds || fd < 0)
+		goto out_unlock;
+	read_unlock(&files->file_lock);
+	return files->fd[fd];
+
+      out_unlock:
+	read_unlock(&files->file_lock);
+	return NULL;
+}
+
+static inline int
+freespace(struct mqueue_ds *q, size_t msg_len)
+{
+	int rc;
+	spin_lock(&q->lock);
+
+	rc = msg_len + q->queue.q_cbytes <= q->attr.mq_msgsize &&
+	    q->queue.q_qnum < q->attr.mq_maxmsg;
+
+	spin_unlock(&q->lock);
+	return rc;
+}
+
+/* cleans up after close() or exit() */
+static int
+mqueue_close(struct inode *inode, struct file *filp)
+{
+	struct mqueue_ds *q = inode->u.generic_ip;
+
+	if (!q || !filp)
+		return -EBADFD;
+
+	spin_lock(&q->lock);
+	/* remove possible notification;
+	 * sys_getpid() returns the tgid if multithreaded */
+	if (q->notify_pid == current->pid) {
+		q->notify_pid = 0;
+		q->notify.sigev_signo = 0;
+		q->notify.sigev_notify = 0;
+	}
+	spin_unlock(&q->lock);
+	return 0;
+}
+
+/* removes a queue - inode is the inode of the directory */
+static int
+mqueue_release(struct inode *inode, struct dentry *dentry)
+{
+	struct mqueue_ds *q = dentry->d_inode->u.generic_ip;
+	struct msg_queue *queue;
+	struct list_head *tmp;
+
+	if (!q)
+		return -EBADFD;
+
+	queue = &q->queue;
+
+	tmp = queue->q_messages.next;
+	while (tmp != &queue->q_messages) {
+		struct msg_msg *msg = list_entry(tmp, struct msg_msg, m_list);
+		tmp = tmp->next;
+		free_msg(msg);
+	}
+	atomic_sub(queue->q_cbytes, &msg_bytes);
+	security_ops->msg_queue_free_security(queue);
+	dentry->d_inode->u.generic_ip = NULL;
+
+	kfree(q);
+	return 0;
+}
+
+static unsigned int
+mqueue_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	struct mqueue_ds *q = get_mqueue(filp);
+	int ret = 0;
+
+	poll_wait(filp, &q->wait_recv, wait);
+	poll_wait(filp, &q->wait_send, wait);
+
+	if (q->queue.q_qnum)
+		ret = POLLIN | POLLRDNORM;
+
+	if (q->queue.q_qnum < q->attr.mq_maxmsg)
+		ret |= POLLOUT | POLLWRNORM;
+
+	return ret;
+}
+
+static int
+create_queue(struct dentry *dir, struct qstr *qname,
+	     int oflag, mode_t mode, struct mq_attr *u_attr)
+{
+	int ret, fd;
+	struct file *filp;
+	struct mqueue_ds *q;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	inode = get_msg_inode(msg_mnt->mnt_sb, S_IFIFO | (mode & S_IRWXUGO));
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		goto out_ret;
+	}
+	q = inode->u.generic_ip;
+
+	if (u_attr != NULL) {
+		if (copy_from_user(&q->attr, u_attr, sizeof (struct mq_attr))) {
+			ret = -EFAULT;
+			goto out_inode;
+		}
+		if (q->attr.mq_maxmsg <= 0
+		    || q->attr.mq_msgsize <= 0
+		    || q->attr.mq_maxmsg > MQ_MAXMSG
+		    || q->attr.mq_msgsize > msg_ctlmax) {
+			ret = -EINVAL;
+			goto out_inode;
+		}
+	} else {		/* implementation defined */
+		q->attr.mq_maxmsg = MQ_MAXMSG;
+		q->attr.mq_msgsize = 1024 /*msg_ctlmax */ ;
+	}
+	q->attr.mq_flags = oflag & O_ACCMODE;
+	q->notify_pid = 0;
+	q->notify.sigev_signo = 0;
+	q->notify.sigev_notify = 0;
+	init_waitqueue_head(&q->wait_send);
+	init_waitqueue_head(&q->wait_recv);
+
+	ret = -ENFILE;
+	if ((fd = get_unused_fd()) < 0)
+		goto out_inode;
+	if (!(filp = get_empty_filp()))
+		goto out_fd;
+
+	qname->hash = full_name_hash(qname->name, qname->len);
+	dentry = d_alloc(dir, qname);
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto out_filp;
+	}
+	d_add(dentry, inode);
+	ret = get_write_access(inode);
+	if (ret)
+		goto out_filp;
+
+	filp->f_vfsmnt = mntget(msg_mnt);
+	filp->f_dentry = dget(dentry);	/* leave it active */
+	filp->f_op = &msg_fops;
+	filp->f_mode = (q->attr.mq_flags + 1) & O_ACCMODE;
+	filp->f_flags = oflag;
+
+	/* Now we map fd to filp, so userspace can access it */
+	fd_install(fd, filp);
+	ret = fd;
+	goto out_ret;
+
+      out_filp:
+	put_filp(filp);
+      out_fd:
+	put_unused_fd(fd);
+      out_inode:
+	kfree(q);
+	iput(inode);
+      out_ret:
+	return ret;
+}
+
+/**
+ *	sys_mq_open	-	opens a message queue associated with @u_name 
+ *	@mqdes: descriptor of mqueue
+ *	@oflag: flags like O_CREAT, O_EXCL, O_RDWR
+ *	@mode: when O_CREAT is specified, the permission bits
+ *	@u_attr: pointer to the attributes, like max msgsize, when creating
+ *
+ *	returns a descriptor to the opened queue or negative value on error
+ */
+asmlinkage mqd_t
+sys_mq_open(const char *u_name, int oflag, mode_t mode, struct mq_attr * u_attr)
+{
+	struct file *filp;
+	struct dentry *dentry;
+	struct qstr this;
+	static int oflag2acc[O_ACCMODE] =
+	    { MAY_READ, MAY_WRITE, MAY_READ | MAY_WRITE };
+	int fd, ret;
+
+	if (IS_ERR(this.name = getname(u_name)))
+		return -ENOMEM;
+	this.len = strlen(this.name);
+	dentry = lookup_one_len(this.name, msg_mnt->mnt_root, this.len);
+
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out_ret;
+	}
+	if (oflag & O_CREAT) {
+		if (dentry->d_inode) {
+			/* entry exists already */
+			if (oflag & O_EXCL) {
+				ret = -EEXIST;
+			} else {
+				goto open_existing;
+			}
+			goto out_dput;
+		} else {
+			ret =
+			    create_queue(msg_mnt->mnt_root, &this, oflag, mode,
+					 u_attr);
+		}
+
+	} else {		/* O_CREAT */
+		if (!dentry->d_inode) {
+			ret = -ENOENT;
+		} else {
+open_existing:
+			if (permission
+			    (dentry->d_inode, oflag2acc[oflag & O_ACCMODE])) {
+				ret = -EACCES;
+			} else {
+				fd = get_unused_fd();
+				if (fd >= 0) {
+					mntget(msg_mnt);
+					filp =
+					    dentry_open(dentry, msg_mnt, oflag);
+					filp->f_op = &msg_fops;
+					if (IS_ERR(filp)) {
+						ret = PTR_ERR(filp);
+						put_unused_fd(fd);
+						goto out_dput;
+					}
+					dget(dentry);
+					fd_install(fd, filp);
+				}
+				ret = fd;
+			}
+		}
+	}
+out_dput:
+	dput(dentry);
+      out_ret:
+	putname(this.name);
+
+	return ret;
+}
+
+/**
+ *	sys_mq_unlink	-	removes a message queue from the namespace 
+ *	
+ *	@u_name: pointer to the name
+ */
+asmlinkage int
+sys_mq_unlink(const char *u_name)
+{
+	int err;
+	struct dentry *dentry, *dir;
+	char *name = getname(u_name);
+
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	dentry = lookup_one_len(name, msg_mnt->mnt_root, strlen(name));
+	putname(name);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	if (!dentry->d_inode)
+		return -ENOENT;
+
+	err = -EACCES;
+	dir = dentry->d_parent;
+	if (dir) {
+		err = vfs_unlink(dir->d_inode, dentry);
+		if (!err)
+			d_delete(dentry);
+	}
+	dput(dentry);
+	return err;
+}
+
+static inline long get_timeout( struct timespec *abs)
+{
+	struct timespec t;
+
+	if (abs->tv_nsec >= 1000000000L || abs->tv_nsec < 0 || abs->tv_sec < 0)
+		return -EINVAL;
+	t=current_kernel_time();
+	if (t.tv_sec > abs->tv_sec || 
+	(t.tv_sec == abs->tv_sec && t.tv_nsec > abs->tv_nsec))
+		return -ETIMEDOUT;
+
+	t.tv_sec = abs->tv_sec - t.tv_sec;
+	t.tv_nsec = abs->tv_nsec - t.tv_nsec;
+	if (t.tv_nsec < 0){
+		t.tv_sec--;
+		t.tv_nsec+= 1000000000;
+	}
+	return timespec_to_jiffies(&t) + 1;
+}
+
+/**
+ *	sys_mq_timedsend	-	send a message to the queue associated 
+ *	with the descriptor mqdes
+ *	@mqdes: descriptor of mqueue
+ *	@msg_ptr: pointer to buffer holding the message
+ *	@msg_len: length of the message
+ *	@msg_prio: the priority of the message
+ *	@utime: if !NULL the function will only block for specified time
+ */
+asmlinkage int
+sys_mq_timedsend(mqd_t mqdes,
+		 const char *msg_ptr, size_t msg_len,
+		 unsigned int msg_prio, struct timespec *utime)
+{
+	struct siginfo sig_i;
+	struct msg_msg *msg;
+	struct list_head *p;
+	struct msg_queue *queue;
+	int err;
+	long timeout;
+	struct timespec ts;
+	struct mqueue_ds *q;
+	struct file *filp = mqueue_lookup(mqdes);
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+	if ((filp->f_mode & O_ACCMODE) == O_RDONLY)
+		return -EBADF;
+	if ((unsigned int) msg_prio >= (unsigned int) MQ_PRIO_MAX)
+		return -EINVAL;
+	if (msg_len > q->attr.mq_msgsize)
+		return -EMSGSIZE;
+
+	queue = &q->queue;
+	if ((filp->f_flags & O_NONBLOCK) && !freespace(q, msg_len))
+		return -EAGAIN;
+
+	/* check if this message will exceed overall limit for messages */
+	if (atomic_read(&msg_bytes) + msg_len > MQ_MAXSYSSIZE)
+		return -ENOMEM;
+
+	if (utime) {
+		if (copy_from_user(&ts, utime, sizeof (ts)))
+			return -EFAULT;
+		if ((timeout = get_timeout(&ts))<0)
+			return timeout;
+	} else
+		timeout = 0L;
+
+	msg = load_msg((char *) msg_ptr, msg_len);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	msg->m_type = msg_prio;
+	msg->m_ts = msg_len;
+
+	if (!timeout)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	err = wait_event_interruptible_timeout(q->wait_send,
+					       freespace(q, msg_len), timeout);
+
+	if (err == -ERESTARTSYS)
+		return -EINTR;
+	if (err == 0)
+		return -ETIMEDOUT;
+
+	err = 0;
+	/* if we lose the race for the lock, we can overflow the limits */
+	spin_lock(&q->lock);
+	/* enqueue message in prio order */
+	p = queue->q_messages.next;	/* used as flag if msg was queued */
+	if (msg_prio > 0 && !list_empty(&queue->q_messages)) {
+
+		list_for_each(p, &queue->q_messages) {
+			struct msg_msg *tmp =
+			    list_entry(p, struct msg_msg, m_list);
+			if (tmp->m_type < msg_prio) {
+				list_add_tail(&msg->m_list, p);
+				p = NULL;
+				break;
+			}
+		}
+	}
+	if (p)			/* ok, put it at the end */
+		list_add_tail(&msg->m_list, &queue->q_messages);
+
+	queue->q_lspid = current->pid;
+	queue->q_cbytes += msg_len;
+	atomic_add(msg_len, &msg_bytes);
+	queue->q_qnum++;
+	filp->f_dentry->d_inode->i_size = queue->q_qnum;
+	filp->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+
+	if (waitqueue_active(&q->wait_recv)) {
+		wake_up_interruptible(&q->wait_recv);
+	} else {
+		/* since there was no synchronously waiting process for message
+		 * we notify it when the state of queue changed from
+		 * empty to not empty */
+		if (q->notify_pid != 0 && queue->q_qnum == 1) {
+			/* TODO: Add support for sigev_notify==SIGEV_THREAD
+			 *    should we really create a thread? I think so.
+			 */
+			if (q->notify.sigev_notify == SIGEV_THREAD) {
+				
+				err = -ENOSYS;
+				pr_info
+				    ("mq_*send: SIGEV_THREAD not supported\n");
+			}
+			/* sends signal */
+			if (q->notify.sigev_notify == SIGEV_SIGNAL) {
+				sig_i.si_signo = q->notify.sigev_signo;
+				sig_i.si_errno = 0;
+				sig_i.si_code = SI_MESGQ;
+				sig_i.si_pid = current->pid;
+				sig_i.si_uid = current->uid;
+				kill_proc_info(q->notify.sigev_signo,
+					       &sig_i, q->notify_pid);
+			}
+			/* after notification unregisters process */
+			q->notify_pid = 0;
+		}
+	}
+	spin_unlock(&q->lock);
+	return err;
+}
+
+/**
+ *	sys_mq_timedreceive	-	receive a message from the queue associated 
+ *	with the descriptor mqdes
+ *	@mqdes: descriptor of mqueue
+ *	@msg_ptr: pointer to buffer to hold the message
+ *	@msg_len: length of the userspace buffer
+ *	@msg_prio: will hold the priority if a message was received
+ *	@utime: if !NULL the function will only block for specified time
+ */
+asmlinkage ssize_t
+sys_mq_timedreceive(mqd_t mqdes,
+		    char *msg_ptr, size_t msg_len,
+		    unsigned int *msg_prio, struct timespec * utime)
+{
+	struct msg_queue *queue;
+	struct msg_msg *msg;
+	int err;
+	long timeout;
+	struct timespec ts;
+	struct mqueue_ds *q;
+	struct file *filp = mqueue_lookup(mqdes);
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
+
+	queue = &q->queue;
+	if ((filp->f_flags & O_NONBLOCK) && queue->q_qnum == 0)
+		return -EAGAIN;
+
+	if (utime) {
+		if (copy_from_user(&ts, utime, sizeof (ts)))
+			return -EFAULT;
+		if ((timeout = get_timeout(&ts))<0)
+			return timeout;
+	} else
+		timeout = 0L;
+wait_on_msg:
+	if (!timeout)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	err = wait_event_interruptible_timeout(q->wait_recv,
+					       queue->q_qnum > 0, timeout);
+
+	if (err == -ERESTARTSYS)
+		return -EINTR;
+	if (err == 0)
+		return -ETIMEDOUT;
+
+	err = 0;
+	spin_lock(&q->lock);
+	if (!list_empty(&queue->q_messages)) {
+
+		msg =
+		    list_entry(queue->q_messages.next, struct msg_msg, m_list);
+		if (msg_len < msg->m_ts) {
+			err = -EMSGSIZE;
+			goto out_unlock;
+		}
+		list_del(&msg->m_list);
+		queue->q_lrpid = current->pid;
+		queue->q_cbytes -= msg->m_ts;
+		atomic_sub(msg->m_ts, &msg_bytes);
+		queue->q_qnum--;
+		filp->f_dentry->d_inode->i_size = queue->q_qnum;
+		filp->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
+		wake_up_interruptible(&q->wait_send);
+
+		msg_len = (msg_len > msg->m_ts) ? msg->m_ts : msg_len;
+
+		spin_unlock(&q->lock);
+		if ((err = store_msg(msg_ptr, msg, msg_len)) ||
+		    put_user(msg->m_type, msg_prio)) {
+			msg_len = -EFAULT;	/* hmh, now the msg is lost */
+		}
+		free_msg(msg);
+		return msg_len;
+	} else {
+		spin_unlock(&q->lock);
+		goto wait_on_msg;
+	}
+      out_unlock:
+	spin_unlock(&q->lock);
+	return err;
+}
+
+/**
+ *	sys_mq_notify	-	set or remove a notification on the queue associated 
+ *	with the descriptor mqdes
+ *	@mqdes: descriptor of mqueue
+ *	@u_notification: pointer to struct sigevent 
+ *
+ */
+asmlinkage int
+sys_mq_notify(mqd_t mqdes, const struct sigevent *u_notification)
+{
+	struct sigevent notify;
+	struct inode *inode;
+	struct file *filp = mqueue_lookup(mqdes);
+	struct mqueue_ds *q = get_mqueue(filp);
+	int err = 0;
+
+	if (!q)
+		return -EBADF;
+	if (u_notification != NULL)
+		if (copy_from_user
+		    (&notify, u_notification, sizeof (struct sigevent)))
+			return -EFAULT;
+
+	inode = filp->f_dentry->d_inode;
+	spin_lock(&q->lock);
+	if (q->notify_pid == current->pid
+	    && (u_notification == NULL || notify.sigev_notify == SIGEV_NONE)) {
+		q->notify_pid = 0;	/* remove notification */
+		q->notify.sigev_signo = 0;
+		q->notify.sigev_notify = 0;
+	} else if (q->notify_pid > 0) {
+		err = -EBUSY;
+	} else if (u_notification != NULL) {
+		if (notify.sigev_notify == SIGEV_SIGNAL) {
+			/* add notification */
+			q->notify_pid = current->pid;
+			q->notify.sigev_signo = notify.sigev_signo;
+			q->notify.sigev_notify = notify.sigev_notify;
+		} else if (notify.sigev_notify == SIGEV_THREAD) {
+			err = -ENOSYS;
+			pr_info("mq_*send: SIGEV_THREAD not supported yet\n");
+		}
+	}
+	spin_unlock(&q->lock);
+	return err;
+}
+
+/**
+ *	sys_mq_getattr	-	get the attributes of the queue associated 
+ *	with the descriptor mqdes
+ *	@mqdes: descriptor of mqueue
+ *	@u_mqstat: pointer to struct holding the new values
+ *
+ */
+asmlinkage int
+sys_mq_getattr(mqd_t mqdes, struct mq_attr *u_mqstat)
+{
+	int err = 0;
+	struct mqueue_ds *q;
+	struct file *filp = mqueue_lookup(mqdes);
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+
+	spin_lock(&q->lock);
+	q->attr.mq_flags = (filp->f_mode - 1) & O_ACCMODE;
+	q->attr.mq_flags = (filp->f_flags) & O_NONBLOCK;
+	q->attr.mq_curmsgs = q->queue.q_qnum;
+	if (copy_to_user(u_mqstat, &q->attr, sizeof (struct mq_attr)))
+		err = -EFAULT;
+	spin_lock(&q->lock);
+	return err;
+}
+
+/**
+ *	sys_mq_setattr	-	set the attributes of the queue associated 
+ *	with the descriptor mqdes
+ *	@mqdes: descriptor of mqueue
+ *	@u_mqstat: pointer to struct holding the new values
+ *	@u_omqstat: pointer to store the original attributes (if !NULL)
+ *
+ */
+asmlinkage int
+sys_mq_setattr(mqd_t mqdes, const struct mq_attr *u_mqstat,
+	       struct mq_attr *u_omqstat)
+{
+	struct mq_attr mqstat;
+	struct mqueue_ds *q;
+	struct file *filp = mqueue_lookup(mqdes);
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+
+	spin_lock(&q->lock);
+	if (u_omqstat != NULL) {
+		q->attr.mq_flags = (filp->f_mode - 1) & O_ACCMODE;
+		q->attr.mq_flags = (filp->f_flags) & O_NONBLOCK;
+		q->attr.mq_curmsgs = q->queue.q_qnum;
+		if (copy_to_user(u_omqstat, &q->attr, sizeof (struct mq_attr))) {
+			spin_unlock(&q->lock);
+			return -EFAULT;
+		}
+	}
+	if (copy_from_user(&mqstat, u_mqstat, sizeof (struct mq_attr))) {
+		spin_unlock(&q->lock);
+		return -EFAULT;
+	}
+	if (mqstat.mq_flags & O_NONBLOCK)
+		filp->f_flags |= O_NONBLOCK;
+	else
+		filp->f_flags &= ~O_NONBLOCK;
+
+	spin_unlock(&q->lock);
+	return 0;
+}
+
+static struct super_operations msg_s_ops = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int
+msg_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *root;
+	struct dentry *root_dentry;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = MSGFS_MAGIC;
+	sb->s_op = &msg_s_ops;
+
+	root = get_msg_inode(sb, S_IFDIR | S_IRWXUGO | S_ISVTX);
+	if (!root)
+		goto out;
+	root_dentry = d_alloc_root(root);
+	if (!root_dentry)
+		goto out_iput;
+	sb->s_root = root_dentry;
+	return 0;
+
+      out_iput:
+	iput(root);
+      out:
+	return -ENOMEM;
+}
+
+static struct super_block *
+msgfs_get_sb(struct file_system_type *fs_type,
+	     int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, msg_fill_super);
+}
+
+static struct file_system_type msg_fs_type = {
+	.name = "msgfs",
+	.get_sb = msgfs_get_sb,
+	.kill_sb = kill_anon_super,
+};
+
+static int __init
+mqueue_init(void)
+{
+	register_filesystem(&msg_fs_type);
+	if (IS_ERR(msg_mnt = kern_mount(&msg_fs_type)))
+		return PTR_ERR(msg_mnt);
+
+	return 0;
+}
+
+__initcall(mqueue_init);
diff -X dontdiff -Nur vanilla-2.5.49/ipc/util.c linux-2.5.49/ipc/util.c
--- vanilla-2.5.49/ipc/util.c	2002-11-23 17:04:49.000000000 +0100
+++ linux-2.5.49/ipc/util.c	2002-11-23 17:14:05.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/mqueue.h>
 
 #if defined(CONFIG_SYSVIPC)
 
@@ -585,3 +586,52 @@
 }
 
 #endif /* CONFIG_SYSVIPC */
+
+#if defined(CONFIG_POSIXMSG)
+/* nothing yet */
+#else
+/*
+ * Dummy functions when POSIXMSG isn't configured
+ */
+
+asmlinkage mqd_t sys_mq_open(const char *u_path, int oflag, mode_t mode,
+	struct mq_attr *u_attr)
+{
+	return (mqd_t) -ENOSYS;
+}
+
+asmlinkage int sys_mq_unlink(const char *u_name)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_timedsend(mqd_t mqdes, const char *msg_ptr, 
+	size_t msg_len, unsigned int msg_prio, struct timespec *utime)
+{
+	return -ENOSYS;
+}
+
+asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char *msg_ptr, 
+	size_t msg_len, unsigned int *msg_prio, struct timespec *utime)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_notify(mqd_t mqdes,
+	const struct sigevent *u_notification)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_getattr(mqd_t mqdes, struct mq_attr *u_mqstat)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int sys_mq_setattr(mqd_t mqdes, const struct mq_attr *u_mqstat,
+	struct mq_attr *u_omqstat)
+{
+	return -ENOSYS;
+}
+
+#endif				/* CONFIG_POSIXMSG */

--------------Boundary-00=_C4S3XUGYHUSQ8R1F4VZO--

