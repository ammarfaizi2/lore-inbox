Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTJEMrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTJEMrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:47:25 -0400
Received: from A17-250-248-84.apple.com ([17.250.248.84]:49358 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S263101AbTJEMos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:44:48 -0400
Subject: Re: [PATCH] [2/2] posix message queues
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       bo.z.li@intel.com, manfred@colorfullife.com
In-Reply-To: <20031003182211.Q26086@devserv.devel.redhat.com>
References: <1065196646.3682.54.camel@picklock.adams.family>
	 <20031003182211.Q26086@devserv.devel.redhat.com>
Content-Type: multipart/mixed; boundary="=-PzK0mIX/z2d3B6CZDGxX"
Organization: 
Message-Id: <1065357747.4034.2.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Oct 2003 14:42:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PzK0mIX/z2d3B6CZDGxX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

s/__NR_sys_mq/__NR_mq/g in asm-i386/unistd.h
changed comment for SIGEV_THREAD
+ * removed unwanted/ugly macros and replaced with fget_light/fput_light
+ *    this only helps single threaded apps
+ * removed wait_on_msg test (list_empty() can't happen here)
+ * removed wake_up_interruptible_all, since waiters are sorted in 
+ *    static_prio order on wait_queues when added



--=-PzK0mIX/z2d3B6CZDGxX
Content-Description: 
Content-Disposition: attachment; filename=px.patch
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

diff -X dontdiff -Nur vanilla-2.6.0-test6/arch/i386/kernel/entry.S linux-2.6.0-test6/arch/i386/kernel/entry.S
--- vanilla-2.6.0-test6/arch/i386/kernel/entry.S	2003-08-23 01:53:39.000000000 +0200
+++ linux-2.6.0-test6/arch/i386/kernel/entry.S	2003-09-07 21:48:07.000000000 +0200
@@ -879,5 +879,12 @@
 	.long sys_tgkill	/* 270 */
 	.long sys_utimes
  	.long sys_fadvise64_64
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend	/* 275 */
+	.long sys_mq_timedreceive
+	.long sys_mq_notify
+	.long sys_mq_getattr
+	.long sys_mq_setattr
 
 nr_syscalls=(.-sys_call_table)/4
diff -X dontdiff -Nur vanilla-2.6.0-test6/CREDITS linux-2.6.0-test6/CREDITS
--- vanilla-2.6.0-test6/CREDITS	2003-10-04 16:37:56.000000000 +0200
+++ linux-2.6.0-test6/CREDITS	2003-10-03 14:10:31.000000000 +0200
@@ -3286,6 +3295,14 @@
 S: 5554 GG Valkenswaard
 S: The Netherlands
 
+N: Peter Wächtler
+E: pwaechtler@mac.com
+W: http://homepage.mac.com/pwaechtler/
+D: Posix message queues
+S: Fliederstr. 3
+S: 30167 Hannover
+S: Germany
+
 N: Peter Shaobo Wang
 E: pwang@mmdcorp.com
 W: http://www.mmdcorp.com/pw/linux
diff -X dontdiff -Nur vanilla-2.6.0-test6/include/asm-i386/unistd.h linux-2.6.0-test6/include/asm-i386/unistd.h
--- vanilla-2.6.0-test6/include/asm-i386/unistd.h	2003-08-23 01:57:19.000000000 +0200
+++ linux-2.6.0-test6/include/asm-i386/unistd.h	2003-10-04 17:55:41.000000000 +0200
@@ -278,8 +278,15 @@
 #define __NR_tgkill		270
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
+#define __NR_mq_open 		273
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getattr		(__NR_mq_open+5)
+#define __NR_mq_setattr		(__NR_mq_open+6)
 
-#define NR_syscalls 273
+#define NR_syscalls 279
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -X dontdiff -Nur vanilla-2.6.0-test6/include/linux/pxqueue.h linux-2.6.0-test6/include/linux/pxqueue.h
--- vanilla-2.6.0-test6/include/linux/pxqueue.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test6/include/linux/pxqueue.h	2003-09-28 22:30:48.000000000 +0200
@@ -0,0 +1,48 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
+#define MQ_PRIO_MAX 	256	/* max priority */
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
diff -X dontdiff -Nur vanilla-2.6.0-test6/init/Kconfig linux-2.6.0-test6/init/Kconfig
--- vanilla-2.6.0-test6/init/Kconfig	2003-10-04 16:38:22.000000000 +0200
+++ linux-2.6.0-test6/init/Kconfig	2003-10-03 17:08:01.000000000 +0200
@@ -91,6 +91,14 @@
 	  section 6.4 of the Linux Programmer's Guide, available from
 	  <http://www.tldp.org/docs.html#guide>.
 
+config POSIXMSG
+	bool "POSIX message queues"
+	---help---
+	  This gives you POSIX compliant interfaces for message queues.
+	  For userspace stub look at 
+	  <http://homepage.mac.com/pwaechtler/mqueue.html>.
+
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	help
diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/Makefile linux-2.6.0-test6/ipc/Makefile
--- vanilla-2.6.0-test6/ipc/Makefile	2003-10-05 14:31:50.000000000 +0200
+++ linux-2.6.0-test6/ipc/Makefile	2003-10-05 14:30:58.000000000 +0200
@@ -5,3 +5,4 @@
 obj-y   := util.o
 
 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_POSIXMSG) += posixmsg.o

diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/posixmsg.c linux-2.6.0-test6/ipc/posixmsg.c
--- vanilla-2.6.0-test6/ipc/posixmsg.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test6/ipc/posixmsg.c	2003-10-05 14:16:43.000000000 +0200
@@ -0,0 +1,945 @@
+/*
+ *  linux/ipc/posixmsg.c
+ *
+ *  Copyright 2002,2003 Peter Wächtler <pwaechtler@mac.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * root can mount the filesystem to see the names of the currently
+ * used mqueues. The i_size shows the number of msgs in the queue.
+ * The only shell operation on the "fifos" is an unlink() via rm(1)
+ * The queues are accessed through syscalls, poll is supported
+ *
+ * CHANGES:
+ * put MSGFS_MAGIC into mqueue.h
+ * update inode->m_time on send (yes, no posix semantics on this)
+ * update inode->a_time on recv
+ * translate absolute timeouts in kernel to prevent too long sleeps
+ * corrected spinlocks + [gs]etattr/mq_flags
+ * replaced spinlocks with inode->i_sem 
+ *		(don't know yet what's broken on SMP with spinlocks)
+ * use spinlocks, where was the problem?
+ * open coded the wait_event_interruptible_timeouts to avoid races
+ * fixed accmode tests
+ * fixed freespace check (meant a per queue limit?)
+ * fixed msg_len check in sys_mq_timedreceive
+ * defer check for negative timeout on mq_timedreceive
+ * don't put_user in timedreceive if msg_prio is NULL
+ * add macros to choose fget/fput or not (read comment at get_filp)
+ * removed unwanted/ugly macros and replaced with fget_light/fput_light
+ *    this only helps single threaded apps
+ * removed wait_on_msg test (list_empty() can't happen here)
+ * removed wake_up_interruptible_all, since waiters are sorted in 
+ *    static_prio order on wait_queues when added
+ *
+ * * passes the posixtestsuite 1.2
+ *
+ * TODO:
+ *	check for more sysv msg limits (or add some new, e.g. MQ_PRIO_MAX)?
+ *  rethink SIGEV_THREAD support (can't block immediatly for error handling)
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
+#include <linux/security.h>
+#include <linux/pxqueue.h>
+#include <linux/msg.h>
+#include <asm/uaccess.h>
+#include "util.h"
+
+
+extern int msg_ctlmnb;		/* default max size of a message queue (all msgs sum up) */
+extern int msg_ctlmni;		/* max # of msg queue identifiers */
+extern int msg_ctlmax;		/* max size of one message (bytes) */
+
+static atomic_t msg_bytes = ATOMIC_INIT(0);
+static struct vfsmount *msg_mnt;
+
+#define get_mqueue(filp)\
+	((filp) ? filp->f_dentry->d_inode->u.generic_ip: filp)
+
+static struct msg_queue *
+init_queue(struct msg_queue *queue)
+{
+	int retval;
+
+	queue->q_perm.mode = 0;
+	queue->q_perm.key = 0;
+	queue->q_perm.security = NULL;
+	retval = security_msg_queue_alloc(queue);
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
+static int 
+mqueue_unlink (struct inode *dir, struct dentry *dentry)
+{
+   dentry->d_inode->i_nlink--;
+   dput(dentry);
+   return 0;
+}
+
+/* cleans up after close() or exit() if the refount drops to zero */
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
+		q->notify.sigev_notify = SIGEV_NONE;
+	}
+	spin_unlock(&q->lock);
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
+	if (q->queue.q_qnum < (unsigned long)q->attr.mq_maxmsg)
+		ret |= POLLOUT | POLLWRNORM;
+
+	return ret;
+}
+
+static struct file_operations msg_fops = {
+	.llseek = no_llseek,
+	.release = mqueue_close,
+	.poll = mqueue_poll,
+};
+static struct inode_operations msg_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.unlink = mqueue_unlink,
+};
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
+			if ((q = kmalloc(sizeof (struct mqueue_ds), GFP_KERNEL))) {
+				if (!init_queue(&q->queue)) {
+					iput(inode);
+					inode = ERR_PTR(-EACCES);
+				}
+				inode->u.generic_ip = q;
+				spin_lock_init(&q->lock);
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
+static inline int
+freespace(struct mqueue_ds *q, size_t msg_len)
+{
+	return (int) ( q->queue.q_qnum < (unsigned long)q->attr.mq_maxmsg);
+}
+
+/* removes a queue - called from vfs when an inode gets deleted */
+static void
+mqueue_release(struct inode *inode)
+{
+	struct mqueue_ds *q = inode->u.generic_ip;
+	struct msg_queue *queue;
+	struct list_head *tmp;
+
+	if (q){
+		queue = &q->queue;
+		tmp = queue->q_messages.next;
+		while (tmp != &queue->q_messages) {
+			struct msg_msg *msg = list_entry(tmp, struct msg_msg, m_list);
+			tmp = tmp->next;
+			free_msg(msg);
+		}
+		atomic_sub(queue->q_cbytes, &msg_bytes);
+		security_msg_queue_free(queue);
+		inode->u.generic_ip = NULL;
+		kfree(q);
+	}
+	clear_inode(inode);
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
+	q->notify.sigev_notify = SIGEV_NONE;
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
+	filp->f_mode = (q->attr.mq_flags +1 ) & O_ACCMODE;
+	filp->f_flags = oflag;
+
+	/* Now we map fd to filp, so userspace can access it */
+	fd_install(fd, filp);
+	ret = fd;
+	goto out_ret;
+
+out_filp:
+	put_filp(filp);
+out_fd:
+	put_unused_fd(fd);
+out_inode:
+	iput(inode);
+out_ret:
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
+		return PTR_ERR(this.name);
+	this.len = strlen(this.name);
+	down(&msg_mnt->mnt_root->d_inode->i_sem);
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
+			ret = create_queue(msg_mnt->mnt_root, &this, 
+					oflag, mode, u_attr);
+		}
+
+	} else {		/* O_CREAT */
+		if (!dentry->d_inode) {
+			ret = -ENOENT;
+		} else {
+open_existing:
+			if (permission
+			    (dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL)) {
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
+out_ret:
+	up(&msg_mnt->mnt_root->d_inode->i_sem);
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
+	int err=0;
+	struct dentry *dentry;
+	char *name = getname(u_name);
+
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	down(&msg_mnt->mnt_root->d_inode->i_sem);
+	dentry = lookup_one_len(name, msg_mnt->mnt_root, strlen(name));
+	if (IS_ERR(dentry)){
+		err= PTR_ERR(dentry);
+		goto out_unlock;
+	}
+	if (!dentry->d_inode){
+		err= -ENOENT;
+		goto out_unlock;
+	}
+	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+
+out_unlock:
+	up(&msg_mnt->mnt_root->d_inode->i_sem);
+	putname(name);
+	return err;
+}
+
+static inline long get_timeout( struct timespec *abs, int *err)
+{
+	struct timespec t;
+	*err = 0;
+	if (abs->tv_nsec >= 1000000000L || abs->tv_nsec < 0 || abs->tv_sec < 0)
+		return *err = -EINVAL;
+
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
+static void local_add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
+{
+	struct list_head *p;
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	spin_lock(&q->lock);
+
+	/* enqueue waiters in prio order */
+	p = q->task_list.next;	/* used as flag if msg was queued */
+	if ( !list_empty(&q->task_list)) {
+
+		list_for_each(p, &q->task_list) {
+			wait_queue_t *wtask =
+			    list_entry(p, wait_queue_t, task_list);
+			if (wtask->task->static_prio < current->static_prio) {
+				list_add_tail(&wait->task_list, p);
+				p = NULL;
+				break;
+			}
+		}
+	}
+	if (p)			/* ok, put it at the end */
+		list_add_tail(&wait->task_list, &q->task_list);
+
+	spin_unlock(&q->lock);
+}
+
+static void local_remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
+{
+	spin_lock(&q->lock);
+	__remove_wait_queue(q, wait);
+	spin_unlock(&q->lock);
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
+	struct msg_msg *msg;
+	struct list_head *p;
+	struct msg_queue *queue;
+	int err;
+	long timeout;
+	struct timespec ts;
+	struct mqueue_ds *q;
+	int fput_needed;
+	struct file *filp = fget_light(mqdes, &fput_needed);
+	struct inode *inode;
+
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+	if ( !(filp->f_mode & FMODE_WRITE))
+		{ err = -EBADF; goto out_fput;};
+	if ((unsigned int) msg_prio >= (unsigned int) MQ_PRIO_MAX)
+		{ err = -EINVAL; goto out_fput;}
+	if ((long)msg_len > q->attr.mq_msgsize)
+		{ err = -EMSGSIZE; goto out_fput;}
+
+	queue = &q->queue;
+	inode=filp->f_dentry->d_inode;
+	spin_lock(&q->lock);
+	if ((filp->f_flags & O_NONBLOCK) && !freespace(q, msg_len)){
+		spin_unlock(&q->lock);
+		{ err = -EAGAIN; goto out_fput;}
+	}
+	spin_unlock(&q->lock);
+	/* check if this message will exceed overall limit for messages */
+	if (atomic_read(&msg_bytes) + msg_len > MQ_MAXSYSSIZE)
+		{ err = -ENOMEM; goto out_fput;}
+
+	if (utime) {
+		if (copy_from_user(&ts, utime, sizeof (ts)))
+			{ err = -EFAULT; goto out_fput;}
+		timeout = get_timeout(&ts, &err);
+		if ( err == -EINVAL )
+			goto out_fput;
+			/* don't timeout yet, check if queue is empty */
+	} else
+		timeout = 0L;
+
+	msg = get_msg((char *) msg_ptr, msg_len);
+	if (IS_ERR(msg))
+		{ err = PTR_ERR(msg); goto out_fput;}
+
+	msg->m_type = msg_prio;
+	msg->m_ts = msg_len;
+
+	if (!timeout)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	/* open coded wait_event_interruptible_timeout() 
+	 * to avoid race on freespace()
+	 */
+	spin_lock(&q->lock);
+	if (!freespace(q, msg_len) ){
+		if ( unlikely(timeout < 0) ){
+			err = -ETIMEDOUT;
+			goto out_unlock;
+		}
+		wait_queue_t __wait;
+		init_waitqueue_entry(&__wait, current);
+
+		local_add_wait_queue(&q->wait_send, &__wait);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if ( freespace(q, msg_len))
+				break;
+			if (!signal_pending(current)) {
+				spin_unlock(&q->lock);
+				timeout = schedule_timeout(timeout);
+				spin_lock(&q->lock);
+				if (!timeout)
+					break;
+				continue;
+			}
+			timeout = -ERESTARTSYS;
+			break;
+		}
+		current->state = TASK_RUNNING;
+		local_remove_wait_queue(&q->wait_send, &__wait);
+
+		if (unlikely(timeout == -ERESTARTSYS)){
+			err = -EINTR;
+			goto out_unlock;
+		}
+		if (unlikely(timeout == 0)){
+			err = -ETIMEDOUT;
+			goto out_unlock;
+		}
+	}
+	err = 0;
+	/* enqueue message in prio order */
+	p = queue->q_messages.next;	/* used as flag if msg was queued */
+	if (msg_prio > 0 && !list_empty(&queue->q_messages)) {
+
+		list_for_each(p, &queue->q_messages) {
+			struct msg_msg *tmp =
+			    list_entry(p, struct msg_msg, m_list);
+			if (tmp->m_type < (long)msg_prio) {
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
+	inode->i_size = queue->q_qnum;
+	inode->i_mtime = CURRENT_TIME;
+
+	if (waitqueue_active(&q->wait_recv)) {
+		/* wake up all waiters to serve the highest prio waiter */
+		wake_up_interruptible(&q->wait_recv);
+	} else {
+		/* since there was no synchronously waiting process for message
+		 * we notify it when the state of queue changed from
+		 * empty to not empty */
+		if (q->notify_pid != 0 && queue->q_qnum == 1) {
+			/* userspace translates SIGEV_THREAD into SIGEV_SIGNAL
+			 * for now, perhaps we block the task on a passed in futex
+			 * in the future
+			 */
+			if (q->notify.sigev_notify == SIGEV_THREAD) {
+				
+				err = -ENOSYS;
+				pr_info("mq_*send: SIGEV_THREAD not supported\n");
+			}
+			/* sends signal */
+			if (q->notify.sigev_notify == SIGEV_SIGNAL) {
+				struct siginfo sig_i;
+				sig_i.si_signo = q->notify.sigev_signo;
+				sig_i.si_errno = 0;
+				sig_i.si_code = SI_MESGQ;
+				sig_i.si_pid = current->pid;
+				sig_i.si_uid = current->uid;
+				kill_proc_info(q->notify.sigev_signo,
+					       &sig_i, q->notify_pid);
+			}
+			/* after notification unregister process */
+			q->notify_pid = 0;
+		}
+	}
+out_unlock:
+	spin_unlock(&q->lock);
+out_fput: 
+	fput_light(filp, fput_needed);
+
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
+	int fput_needed;
+	struct file *filp = fget_light(mqdes, &fput_needed);
+	struct inode *inode;
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+	if ((long)msg_len < q->attr.mq_msgsize)
+		{ err = -EMSGSIZE; goto out_fput;}
+
+	if ( !(filp->f_mode & FMODE_READ))
+		{ err = -EBADF; goto out_fput;}
+
+	queue = &q->queue;
+	if ((filp->f_flags & O_NONBLOCK) && queue->q_qnum == 0)
+		{ err = -EAGAIN; goto out_fput;}
+
+	if (utime) {
+		if (copy_from_user(&ts, utime, sizeof (ts)))
+			{ err = -EFAULT; goto out_fput;}
+		timeout = get_timeout(&ts, &err);
+		if ( err == -EINVAL )
+			goto out_fput;
+			 /* we do not check yet for the timeout */
+	} else
+		timeout = 0L;
+	if (!timeout)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
+	spin_lock(&q->lock);
+
+	if (queue->q_qnum == 0 ){
+		if (unlikely(timeout < 0)){
+			err = -ETIMEDOUT;
+			goto out_unlock;
+		}
+		wait_queue_t __wait;
+		init_waitqueue_entry(&__wait, current);
+
+		local_add_wait_queue(&q->wait_recv, &__wait);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if ( queue->q_qnum > 0)
+				break;
+			if (!signal_pending(current)) {
+				spin_unlock(&q->lock);
+				timeout = schedule_timeout(timeout);
+				spin_lock(&q->lock);
+				if (!timeout)
+					break;
+				continue;
+			}
+			timeout = -ERESTARTSYS;
+			break;
+		}
+		current->state = TASK_RUNNING;
+		local_remove_wait_queue(&q->wait_recv, &__wait);
+
+		if (unlikely(timeout == -ERESTARTSYS)){
+			err = -EINTR;
+			goto out_unlock;
+		}
+		if (unlikely(timeout == 0)){
+			err = -ETIMEDOUT;
+			goto out_unlock;
+		}
+	}
+	msg=list_entry(queue->q_messages.next, struct msg_msg, m_list);
+	list_del(&msg->m_list);
+	queue->q_lrpid = current->pid;
+	queue->q_cbytes -= msg->m_ts;
+	atomic_sub(msg->m_ts, &msg_bytes);
+	queue->q_qnum--;
+	inode=filp->f_dentry->d_inode;
+	inode->i_size = queue->q_qnum;
+	inode->i_atime = CURRENT_TIME;
+	/* msg is removed from list, we're already safe */
+	spin_unlock(&q->lock);
+
+	wake_up_interruptible(&q->wait_send);
+
+	msg_len = (msg_len > (size_t)msg->m_ts) ? (size_t)msg->m_ts : msg_len;
+
+	if ( put_msg(msg_ptr, msg, msg_len) ||
+		( msg_prio && put_user(msg->m_type, msg_prio))) {
+		msg_len = -EFAULT;	/* hmh, now the msg is lost */
+	}
+	free_msg(msg);
+	
+	fput_light(filp, fput_needed);
+	return msg_len;
+
+out_unlock:
+	spin_unlock(&q->lock);
+out_fput: 
+	fput_light(filp, fput_needed);
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
+	int fput_needed;
+	struct file *filp = fget_light(mqdes, &fput_needed);
+	struct mqueue_ds *q;
+	int err = 0;
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+	if (u_notification != NULL)
+		if (copy_from_user
+		    (&notify, u_notification, sizeof (struct sigevent)))
+			{ err = -EFAULT; goto out_fput;}
+
+	down(&filp->f_dentry->d_inode->i_sem);
+	if (q->notify_pid == current->pid
+	    && (u_notification == NULL || notify.sigev_notify == SIGEV_NONE)) {
+		q->notify_pid = 0;	/* remove notification */
+		q->notify.sigev_signo = 0;
+		q->notify.sigev_notify = SIGEV_NONE;
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
+	up(&filp->f_dentry->d_inode->i_sem);
+out_fput: 
+	fput_light(filp, fput_needed);
+
+	return err;
+}
+
+static inline void 
+fill_flags(struct mqueue_ds *q, struct file *filp)
+{
+	spin_lock(&q->lock);
+	q->attr.mq_flags = (filp->f_mode -1) & O_ACCMODE;
+	q->attr.mq_flags |= (filp->f_flags) & O_NONBLOCK;
+	q->attr.mq_curmsgs = q->queue.q_qnum;
+	spin_unlock(&q->lock);
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
+	int fput_needed;
+	struct file *filp = fget_light(mqdes, &fput_needed);
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+
+	fill_flags(q,filp);
+	if (copy_to_user(u_mqstat, &q->attr, sizeof (struct mq_attr)))
+		err = -EFAULT;
+	fput_light(filp, fput_needed);
+
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
+	int fput_needed;
+	struct file *filp = fget_light(mqdes, &fput_needed);
+	int err = 0;
+
+	if (!(q = get_mqueue(filp)))
+		return -EBADF;
+
+	if (u_omqstat != NULL) {
+		fill_flags(q,filp);
+		if (copy_to_user(u_omqstat, &q->attr, sizeof (struct mq_attr)))
+			{ err = -EFAULT; goto out_fput;}
+	}
+	if (copy_from_user(&mqstat, u_mqstat, sizeof (struct mq_attr)))
+		{ err = -EFAULT; goto out_fput;}
+	if (mqstat.mq_flags & O_NONBLOCK)
+		filp->f_flags |= O_NONBLOCK;
+	else
+		filp->f_flags &= ~O_NONBLOCK;
+
+out_fput: 
+	fput_light(filp, fput_needed);
+
+	return err;
+}
+
+static struct super_operations msg_s_ops = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+	.delete_inode = mqueue_release,
+};
+
+static int
+msg_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *root;
+	struct dentry *root_dentry;
+	static const struct qstr this={ .name="msg:", .len=4, .hash=0 };
+	
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = MSGFS_MAGIC;
+	sb->s_op = &msg_s_ops;
+
+	root = get_msg_inode(sb, S_IFDIR | S_IRWXUGO | S_ISVTX);
+	if (!root)
+		goto out;
+	root_dentry = d_alloc(NULL, &this);
+	if (!root_dentry)
+		goto out_iput;
+	sb->s_root = root_dentry;
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+	return 0;
+
+out_iput:
+	iput(root);
+out:
+	return -ENOMEM;
+}
+
+static struct super_block *
+msgfs_get_sb(struct file_system_type *fs_type,
+	     int flags, const char *dev_name, void *data)
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
+	int err = register_filesystem(&msg_fs_type);
+
+	if (!err){
+		if (IS_ERR(msg_mnt = kern_mount(&msg_fs_type))){
+			unregister_filesystem(&msg_fs_type);
+			err= PTR_ERR(msg_mnt);
+		} else
+			err=0;
+	}
+
+	return err;
+}
+
+__initcall(mqueue_init);
diff -X dontdiff -Nur vanilla-2.6.0-test6/ipc/util.c linux-2.6.0-test6/ipc/util.c
--- vanilla-2.6.0-test6/ipc/util.c	2003-10-05 14:32:25.000000000 +0200
+++ linux-2.6.0-test6/ipc/util.c	2003-10-03 14:58:35.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/pxqueue.h>
 
 #if defined(CONFIG_SYSVIPC)
 
@@ -731,3 +732,50 @@
 }
 
 #endif /* CONFIG_SYSVIPC */
+
+#if !defined(CONFIG_POSIXMSG)
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
diff -X dontdiff -Nur vanilla-2.6.0-test6/MAINTAINERS linux-2.6.0-test6/MAINTAINERS
--- vanilla-2.6.0-test6/MAINTAINERS	2003-10-04 16:37:57.000000000 +0200
+++ linux-2.6.0-test6/MAINTAINERS	2003-10-03 13:40:59.000000000 +0200
@@ -1558,6 +1558,11 @@
 M:	ambx1@neo.rr.com
 S:	Maintained
 
+POSIXMSG message queues
+P:	Peter Wächtler
+M:	pwaechtler@mac.com
+S:	Maintained
+
 PPP PROTOCOL DRIVERS AND COMPRESSORS
 P:	Paul Mackerras
 M:	paulus@samba.org

--=-PzK0mIX/z2d3B6CZDGxX--

