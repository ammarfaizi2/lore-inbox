Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUCGOGg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 09:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUCGOGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 09:06:36 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:55463 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261993AbUCGOGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 09:06:05 -0500
Message-ID: <404B2C46.90709@colorfullife.com>
Date: Sun, 07 Mar 2004 15:05:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] different proposal for mq_notify(SIGEV_THREAD)
Content-Type: multipart/mixed;
 boundary="------------000506020908070607060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506020908070607060102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Ulrich Drepper preferred a simpler (from user space point of view) 
SIGEV_THREAD implementation:

SIGEV_THREAD means that a notification function should be called in the 
context of a new thread. The new thread is created by glibc in user 
space, thus the problem for the kernel is registering the notification 
and then delivering the event to user space.

Current approach:
mq_notify(SIGEV_THREAD) creates (and returns) a new file descriptor. 
User space reads from the fd. If the event happens, then the kernel 
changes the state of the created fd. User spaces notices that through 
read(2) and calls the notification function.

Problem:
- high resource usage: one fd for each pending notification.
- complex user space.

New proposal:
mq_notify(SIGEV_THREAD) receives two additional parameters:
- a 16-byte cookie.
- a file descriptor of a special notify file. The notify file is similar 
to a pipe. The main difference is that writing to it mustn't block, 
therefore the buffer handling differs.
If the event happens, then the kernel "writes" the cookie to the notify 
file.
User space reads the cookie and calls the notification function.

Problems:
- More complexity in kernel.
- How should the notify fd be created? Right now it's mq_notify with 
magic parameters, probably a char device in /dev is the better approach.

What do you think? The first approach is in Andrew's 2.6.4-rc1-mm2 
kernel, a patch that implements a notify file is attached.
I think that the added complexity is not worth the effort if the notify 
fd is only used for posix message queues. Are there other users that 
could use the notify file? How is SIGEV_THREAD implemented for aio and 
timers?

--
    Manfred

--------------000506020908070607060102
Content-Type: text/plain;
 name="mq-work"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mq-work"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 4
//  EXTRAVERSION =-rc1-mm2
--- 2.6/ipc/mqueue.c	2004-03-07 14:56:59.000000000 +0100
+++ build-2.6/ipc/mqueue.c	2004-03-07 14:57:42.000000000 +0100
@@ -33,9 +33,6 @@
 #define STATE_PENDING	1
 #define STATE_READY	2
 
-#define NP_NONE		((void*)NOTIFY_NONE)
-#define NP_WOKENUP	((void*)NOTIFY_WOKENUP)
-#define NP_REMOVED	((void*)NOTIFY_REMOVED)
 /* used by sysctl */
 #define FS_MQUEUE 	1
 #define CTL_QUEUESMAX 	2
@@ -48,6 +45,12 @@
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
 
+#define NOTIFY_COOKIE_LEN	16
+struct notify_cookie {
+	struct list_head next;
+	char cookie[NOTIFY_COOKIE_LEN];
+};
+
 struct ext_wait_queue {		/* queue of sleeping tasks */
 	struct task_struct *task;
 	struct list_head list;
@@ -56,20 +59,27 @@
 };
 
 struct mqueue_inode_info {
+	/* 1) shared members */
+	spinlock_t lock;
+	struct inode vfs_inode;
+	wait_queue_head_t wait_q;
+
+	/* 2) message queue fd members */
+	struct msg_msg **messages;	/* messages == NULL means notify fd */
 	struct mq_attr attr;
-	struct msg_msg **messages;
 
-	pid_t notify_owner;	/* != 0 means notification registered */
-	struct sigevent notify;
-	struct file *notify_filp;
+	struct sigevent notify; /* notify.sigev_notify == SIGEV_NONE means */
+	pid_t notify_owner;	/*           no notification registered */
+	struct file *nfilp;
+	struct notify_cookie *nc;
 
 	/* for tasks waiting for free space and messages, respectively */
 	struct ext_wait_queue e_wait_q[2];
-	wait_queue_head_t wait_q;
 
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
-	spinlock_t lock;
-	struct inode vfs_inode;
+
+	/* 3) notify fd members */
+	struct list_head pending;
 };
 
 static struct inode_operations mqueue_dir_inode_operations;
@@ -119,7 +129,7 @@
 			init_waitqueue_head(&info->wait_q);
 			INIT_LIST_HEAD(&info->e_wait_q[0].list);
 			INIT_LIST_HEAD(&info->e_wait_q[1].list);
-			info->notify_owner = 0;
+			info->notify.sigev_notify = SIGEV_NONE;
 			info->qsize = 0;
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
@@ -204,17 +214,29 @@
 		return;
 	}
 	info = MQUEUE_I(inode);
-	spin_lock(&info->lock);
-	for (i = 0; i < info->attr.mq_curmsgs; i++)
-		free_msg(info->messages[i]);
-	kfree(info->messages);
-	spin_unlock(&info->lock);
+	if (info->messages) {
+		spin_lock(&info->lock);
+		for (i = 0; i < info->attr.mq_curmsgs; i++)
+			free_msg(info->messages[i]);
+		kfree(info->messages);
+		spin_unlock(&info->lock);
 
-	clear_inode(inode);
+		spin_lock(&mq_lock);
+		queues_count--;
+		spin_unlock(&mq_lock);
+	} else {
+		struct list_head *l1, *l2;
 
-	spin_lock(&mq_lock);
-	queues_count--;
-	spin_unlock(&mq_lock);
+		spin_lock(&info->lock);
+		list_for_each_safe(l1, l2, &info->pending) {
+			struct notify_cookie *nc;
+
+			nc = list_entry(l1, struct notify_cookie, next);
+			kfree(nc);
+		}
+		spin_unlock(&info->lock);
+	}
+	clear_inode(inode);
 }
 
 static int mqueue_create(struct inode *dir, struct dentry *dentry,
@@ -283,10 +305,11 @@
 	snprintf(buffer, sizeof(buffer),
 			"QSIZE:%-10lu NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
 			info->qsize,
-			info->notify_owner ? info->notify.sigev_notify : SIGEV_NONE,
-			(info->notify_owner && info->notify.sigev_notify == SIGEV_SIGNAL ) ?
+			info->notify.sigev_notify,
+			(info->notify.sigev_notify == SIGEV_SIGNAL ) ?
 				info->notify.sigev_signo : 0,
-			info->notify_owner);
+			(info->notify.sigev_notify != SIGEV_NONE) ?
+				info->notify_owner : 0);
 	spin_unlock(&info->lock);
 	buffer[sizeof(buffer)-1] = '\0';
 	slen = strlen(buffer)+1;
@@ -299,7 +322,7 @@
 		count = slen - o;
 
 	if (copy_to_user(u_data, buffer + o, count))
-       		return -EFAULT;
+		return -EFAULT;
 
 	*off = o + count;
 	filp->f_dentry->d_inode->i_atime = filp->f_dentry->d_inode->i_ctime = CURRENT_TIME;
@@ -311,7 +334,8 @@
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (current->tgid == info->notify_owner)
+	if (info->notify.sigev_notify != SIGEV_NONE &&
+			current->tgid == info->notify_owner)
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -445,7 +469,8 @@
 	 * waiting synchronously for message AND state of queue changed from
 	 * empty to not empty. Here we are sure that no one is waiting
 	 * synchronously. */
-	if (info->notify_owner && info->attr.mq_curmsgs == 1) {
+	if (info->notify.sigev_notify != SIGEV_NONE &&
+			info->attr.mq_curmsgs == 1) {
 		/* sends signal */
 		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
 			struct siginfo sig_i;
@@ -460,10 +485,17 @@
 			kill_proc_info(info->notify.sigev_signo,
 				       &sig_i, info->notify_owner);
 		} else if (info->notify.sigev_notify == SIGEV_THREAD) {
-			info->notify_filp->private_data = (void*)NP_WOKENUP;
+			struct mqueue_inode_info *ninfo;
+
+			ninfo = MQUEUE_I(info->nfilp->f_dentry->d_inode);
+			spin_lock(&ninfo->lock);
+			list_add_tail(&info->nc->next, &ninfo->pending);
+			wake_up(&ninfo->wait_q);
+			spin_unlock(&ninfo->lock);
+			fput(info->nfilp);
 		}
 		/* after notification unregisters process */
-		info->notify_owner = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
 	}
 	wake_up(&info->wait_q);
 }
@@ -525,7 +557,7 @@
 
 	poll_wait(filp, &info->wait_q, poll_tab);
 
-	if (filp->private_data == NP_NONE)
+	if (list_empty(&info->pending))
 		retval = 0;
 	else
 		retval = POLLIN | POLLRDNORM;
@@ -536,14 +568,15 @@
 					size_t count, loff_t *ppos)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
-	char result;
+	size_t read;
 
-	if (!count)
+	if (unlikely(!count))
 		return 0;
-	if (*ppos != 0)
+	/* no pread */
+	if (unlikely(ppos != &filp->f_pos))
 		return 0;
 	spin_lock(&info->lock);
-	while (filp->private_data == NP_NONE) {
+	while (list_empty(&info->pending)) {
 		DEFINE_WAIT(wait);
 		if (filp->f_flags & O_NONBLOCK) {
 			spin_unlock(&info->lock);
@@ -555,34 +588,61 @@
 		finish_wait(&info->wait_q, &wait);
 		spin_lock(&info->lock);
 	}
+	read = 0;
+	while(count && !list_empty(&info->pending)) {
+		struct notify_cookie *nc;
+		int len;
+
+		nc = list_entry(info->pending.next, struct notify_cookie, next);
+		list_del(&nc->next);
+		spin_unlock(&info->lock);
+		len = sizeof(nc->cookie);
+		if (len > count)
+			len = count;
+		if (copy_to_user(buf, nc->cookie, len)) {
+			if (!read)
+				read = -EFAULT;
+			count = 0;
+		} else {
+			count -=len;
+			buf += len;
+		}
+		kfree(nc);
+		spin_lock(&info->lock);
+	}
+	wake_up(&info->wait_q);
 	spin_unlock(&info->lock);
-	result = (char)(unsigned long)filp->private_data;
-	if (put_user(result, buf))
-		return -EFAULT;
-	*ppos = 1;
-	return 1;
+	return read;
 }
 
-static int mqueue_notify_release(struct inode *inode, struct file *filp)
+static void wait_notify_free(struct file *filp)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (info->notify_owner && info->notify_filp == filp)
-		info->notify_owner = 0;
-	filp->private_data = NP_REMOVED;
-	spin_unlock(&info->lock);
+	while (!list_empty(&info->pending)) {
+		DEFINE_WAIT(wait);
 
-	return 0;
+		prepare_to_wait(&info->wait_q, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock(&info->lock);
+		schedule();
+		finish_wait(&info->wait_q, &wait);
+		spin_lock(&info->lock);
+	}
+	spin_unlock(&info->lock);
 }
 
 static void remove_notification(struct mqueue_inode_info *info)
 {
 	if (info->notify.sigev_notify == SIGEV_THREAD) {
-		info->notify_filp->private_data = NP_REMOVED;
-		wake_up(&info->wait_q);
+		struct mqueue_inode_info *ninfo;
+
+		kfree(info->nc);
+		ninfo = MQUEUE_I(info->nfilp->f_dentry->d_inode);
+		wake_up(&ninfo->wait_q);
+		fput(info->nfilp);
 	}
-	info->notify_owner = 0;
+	info->notify.sigev_notify = SIGEV_NONE;
 }
 
 /*
@@ -780,7 +840,8 @@
  */
 
 /* pipelined_send() - send a message directly to the task waiting in
- * sys_mq_timedreceive() (without inserting message into a queue). */
+ * sys_mq_timedreceive() (without inserting message into a queue).
+ */
 static inline void pipelined_send(struct mqueue_inode_info *info,
 				  struct msg_msg *message,
 				  struct ext_wait_queue *receiver)
@@ -837,11 +898,11 @@
 		goto out;
 
 	inode = filp->f_dentry->d_inode;
-	if (unlikely(inode->i_sb != mqueue_mnt->mnt_sb))
+	if (unlikely(filp->f_op != &mqueue_file_operations))
 		goto out_fput;
 	info = MQUEUE_I(inode);
 
-	if (unlikely((filp->f_flags & O_ACCMODE) == O_RDONLY))
+	if (unlikely(!(filp->f_mode & FMODE_WRITE)))
 		goto out_fput;
 
 	if (unlikely(msg_len > info->attr.mq_msgsize)) {
@@ -915,11 +976,11 @@
 		goto out;
 
 	inode = filp->f_dentry->d_inode;
-	if (unlikely(inode->i_sb != mqueue_mnt->mnt_sb))
+	if (unlikely(filp->f_op != &mqueue_file_operations))
 		goto out_fput;
 	info = MQUEUE_I(inode);
 
-	if (unlikely((filp->f_flags & O_ACCMODE) == O_WRONLY))
+	if (unlikely(!(filp->f_mode & FMODE_READ)))
 		goto out_fput;
 
 	/* checks if buffer is big enough */
@@ -966,6 +1027,87 @@
 	return ret;
 }
 
+static int mqueue_notify_delete_dentry(struct dentry *dentry)
+{
+        return 1;
+}
+static struct dentry_operations mqueue_notify_dops = {
+	.d_delete       = mqueue_notify_delete_dentry,
+};
+
+static int get_notify_fd(void)
+{
+	struct mqueue_inode_info *info;
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+	struct inode * inode;
+	struct file *filp;
+	int ret, fd;
+
+	ret = get_unused_fd();
+	if (ret < 0)
+		goto out;
+	fd = ret;
+
+	ret = -ENFILE;
+	filp = get_empty_filp();
+	if (!filp)
+		goto out_putfd;
+
+	ret = -ENOMEM;
+	inode = new_inode(mqueue_mnt->mnt_sb);
+	if (!inode)
+		goto out_putfilp;
+
+        inode->i_fop = &mqueue_notify_fops;
+	/*
+	 * Mark the inode dirty from the very beginning,
+	 * that way it will never be moved to the dirty
+	 * list because "mark_inode_dirty()" will think
+	 * that it already _is_ on the dirty list.
+	 */
+	inode->i_state = I_DIRTY;
+	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_blksize = PAGE_SIZE;
+
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = inode->i_ino; /* will go */
+	dentry = d_alloc(mqueue_mnt->mnt_sb->s_root, &this);
+	if (!dentry)
+		goto out_freeinode;
+
+	dentry->d_op = &mqueue_notify_dops;
+	d_add(dentry, inode);
+
+	filp->f_op = &mqueue_notify_fops;
+	filp->f_vfsmnt = mntget(mqueue_mnt);
+	filp->f_dentry = dentry;
+	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
+	filp->f_mode = FMODE_READ;
+
+	info = MQUEUE_I(inode);
+	spin_lock_init(&info->lock);
+	info->messages = NULL;
+	init_waitqueue_head(&info->wait_q);
+	INIT_LIST_HEAD(&info->pending);
+	fd_install(fd, filp);
+	return fd;
+	
+out_freeinode:
+	iput(inode);
+out_putfilp:
+	put_filp(filp);
+out_putfd:
+	put_unused_fd(fd);
+out:
+	return ret;
+}
 /*
  * Notes: the case when user wants us to deregister (with NULL as pointer
  * or SIGEV_NONE) and he isn't currently owner of notification will be
@@ -974,12 +1116,15 @@
 asmlinkage long sys_mq_notify(mqd_t mqdes,
 				const struct sigevent __user *u_notification)
 {
-	int ret, fd;
+	int ret;
 	struct file *filp, *nfilp;
 	struct inode *inode;
 	struct sigevent notification;
 	struct mqueue_inode_info *info;
+	struct notify_cookie *nc;
 
+	nc = NULL;
+	nfilp = NULL;
 	if (u_notification == NULL) {
 		notification.sigev_notify = SIGEV_NONE;
 	} else {
@@ -996,6 +1141,32 @@
 			 notification.sigev_signo > _NSIG)) {
 			return -EINVAL;
 		}
+		if (notification.sigev_notify == SIGEV_THREAD) {
+			if (notification.sigev_value.sival_ptr == NULL) {
+				ret = get_notify_fd();
+				goto out;
+			} else {
+				/* get a ref to the notify fd: */
+				nfilp = fget(notification.sigev_signo);
+				ret = -EBADF;
+				if (!nfilp)
+					goto out;
+				if (unlikely(nfilp->f_op != &mqueue_notify_fops))
+					goto out;
+				wait_notify_free(nfilp);
+
+				nc = kmalloc(sizeof(*nc), GFP_KERNEL);
+				ret = -ENOMEM;
+				if (!nc)
+					goto out;
+				ret = -EFAULT;
+				if (copy_from_user(nc->cookie,
+						notification.sigev_value.sival_ptr,
+						sizeof(nc->cookie))) {
+					goto out;
+				}
+			}
+		}
 	}
 
 	ret = -EBADF;
@@ -1004,64 +1175,43 @@
 		goto out;
 
 	inode = filp->f_dentry->d_inode;
-	if (unlikely(inode->i_sb != mqueue_mnt->mnt_sb))
+	if (unlikely(filp->f_op != &mqueue_file_operations))
 		goto out_fput;
 	info = MQUEUE_I(inode);
 
 	ret = 0;
-	if (notification.sigev_notify == SIGEV_THREAD) {
-		ret = get_unused_fd();
-		if (ret < 0)
-			goto out_fput;
-		fd = ret;
-		nfilp = get_empty_filp();
-		if (!nfilp) {
-			ret = -ENFILE;
-			goto out_dropfd;
-		}
-		nfilp->private_data = NP_NONE;
-		nfilp->f_op = &mqueue_notify_fops;
-		nfilp->f_vfsmnt = mntget(mqueue_mnt);
-		nfilp->f_dentry = dget(filp->f_dentry);
-		nfilp->f_mapping = filp->f_dentry->d_inode->i_mapping;
-		nfilp->f_mode = FMODE_READ;
-	} else {
-		nfilp = NULL;
-		fd = -1;
-	}
-
 	spin_lock(&info->lock);
 
 	if (notification.sigev_notify == SIGEV_NONE) {
-		if (info->notify_owner == current->tgid) {
+		if (info->notify.sigev_notify != SIGEV_NONE &&
+				info->notify_owner == current->tgid) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
-	} else if (info->notify_owner) {
+	} else if (info->notify.sigev_notify != SIGEV_NONE) {
 		ret = -EBUSY;
 	} else if (notification.sigev_notify == SIGEV_THREAD) {
-		info->notify_filp = nfilp;
-		fd_install(fd, nfilp);
-		ret = fd;
-		fd = -1;
-		nfilp = NULL;
 		info->notify.sigev_notify = SIGEV_THREAD;
 		info->notify_owner = current->tgid;
+		info->nfilp = nfilp;
+		info->nc = nc;
+		nc = NULL;
+		nfilp = NULL;
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}  else {
+		info->notify.sigev_notify = SIGEV_SIGNAL;
 		info->notify.sigev_signo = notification.sigev_signo;
 		info->notify.sigev_value = notification.sigev_value;
-		info->notify.sigev_notify = SIGEV_SIGNAL;
 		info->notify_owner = current->tgid;
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}
 	spin_unlock(&info->lock);
-out_dropfd:
-	if (fd != -1)
-		put_unused_fd(fd);
 out_fput:
 	fput(filp);
 out:
+	kfree(nc);
+	if (nfilp)
+		fput(nfilp);
 	return ret;
 }
 
@@ -1088,7 +1238,7 @@
 		goto out;
 
 	inode = filp->f_dentry->d_inode;
-	if (unlikely(inode->i_sb != mqueue_mnt->mnt_sb))
+	if (unlikely(filp->f_op != &mqueue_file_operations))
 		goto out_fput;
 	info = MQUEUE_I(inode);
 
@@ -1133,10 +1283,8 @@
 static struct file_operations mqueue_notify_fops = {
 	.poll = mqueue_notify_poll,
 	.read = mqueue_notify_read,
-	.release = mqueue_notify_release,
 };
 
-
 static struct super_operations mqueue_super_ops = {
 	.alloc_inode = mqueue_alloc_inode,
 	.destroy_inode = mqueue_destroy_inode,
--- 2.6/include/linux/mqueue.h	2004-03-07 08:13:23.000000000 +0100
+++ build-2.6/include/linux/mqueue.h	2004-03-07 13:43:08.000000000 +0100
@@ -30,8 +30,4 @@
 	long	__reserved[4];	/* ignored for input, zeroed for output */
 };
 
-#define NOTIFY_NONE	0
-#define NOTIFY_WOKENUP	1
-#define NOTIFY_REMOVED	2
-
 #endif

--------------000506020908070607060102--

