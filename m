Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUDCTnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUDCTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:43:31 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:52368 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261899AbUDCTnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:43:02 -0500
Message-ID: <406F13A1.4030201@colorfullife.com>
Date: Sat, 03 Apr 2004 21:42:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
CC: Michal Wronski <wrona@mat.uni.torun.pl>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: [RFC, PATCH] netlink based mq_notify(SIGEV_THREAD)
Content-Type: multipart/mixed;
 boundary="------------020509080401080507010703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509080401080507010703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mq_notify(SIGEV_THREAD) must be implemented in user space. If an event 
is triggered, the kernel must send a notification to user space, and 
then glibc must create the thread with the requested attributes for the 
notification callback. The current implementation in Andrew's -mm tree 
uses single shot file descriptor - it works, but it's resource hungry.

Attached is a new proposal:
- split netlink_unicast into separate substeps
- use an AF_NETLINK socket for the message queue notification

What do you think?

--
    Manfred

--------------020509080401080507010703
Content-Type: text/plain;
 name="patch-mqueue-netlink"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mqueue-netlink"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 5
//  EXTRAVERSION =-rc3-mm1
--- 2.6/include/linux/netlink.h	2004-04-03 14:29:26.000000000 +0200
+++ build-2.6/include/linux/netlink.h	2004-04-03 21:05:11.525685846 +0200
@@ -120,6 +120,13 @@
 extern int netlink_register_notifier(struct notifier_block *nb);
 extern int netlink_unregister_notifier(struct notifier_block *nb);
 
+/* finegrained unicast helpers: */
+struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid);
+struct sock *netlink_getsockbyfilp(struct file *filp);
+int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo);
+void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
+int netlink_sendskb(struct sock *sk, struct sk_buff *skb, int protocol);
+
 /*
  *	skb should fit one page. This choice is good for headerless malloc.
  *
--- 2.6/net/netlink/af_netlink.c	2004-03-31 18:36:32.000000000 +0200
+++ build-2.6/net/netlink/af_netlink.c	2004-04-03 21:30:26.147554044 +0200
@@ -415,38 +415,66 @@
 	}
 }
 
-int netlink_unicast(struct sock *ssk, struct sk_buff *skb, u32 pid, int nonblock)
+struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid)
 {
-	struct sock *sk;
-	struct netlink_opt *nlk;
-	int len = skb->len;
 	int protocol = ssk->sk_protocol;
-	long timeo;
-        DECLARE_WAITQUEUE(wait, current);
-
-	timeo = sock_sndtimeo(ssk, nonblock);
+	struct sock *sock;
+	struct netlink_opt *nlk;
 
-retry:
-	sk = netlink_lookup(protocol, pid);
-	if (sk == NULL)
-		goto no_dst;
-	nlk = nlk_sk(sk);
+	sock = netlink_lookup(protocol, pid);
+	if (!sock)
+		return ERR_PTR(-ECONNREFUSED);
 
 	/* Don't bother queuing skb if kernel socket has no input function */
-        if (nlk->pid == 0 && !nlk->data_ready)
-        	goto no_dst;
+	nlk = nlk_sk(sock);
+	if (nlk->pid == 0 && !nlk->data_ready) {
+		sock_put(sock);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+	return sock;
+}
+
+struct sock *netlink_getsockbyfilp(struct file *filp)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct socket *socket;
+	struct sock *sock;
+
+	if (!inode->i_sock || !(socket = SOCKET_I(inode)))
+		return ERR_PTR(-ENOTSOCK);
+
+	sock = socket->sk;
+	if (sock->sk_family != AF_NETLINK)
+		return ERR_PTR(-EINVAL);
+
+	sock_hold(sock);
+	return sock;
+}
+
+/*
+ * Attach a skb to a netlink socket.
+ * The caller must hold a reference to the destination socket. On error, the
+ * reference is dropped. The skb is not send to the destination, just all
+ * all error checks are performed and memory in the queue is reserved.
+ * Return values:
+ * < 0: error. skb freed, reference to sock dropped.
+ * 0: continue
+ * 1: repeat lookup - reference dropped while waiting for socket memory.
+ */
+int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo)
+{
+	struct netlink_opt *nlk;
+
+	nlk = nlk_sk(sk);
 
 #ifdef NL_EMULATE_DEV
-	if (nlk->handler) {
-		skb_orphan(skb);
-		len = nlk->handler(protocol, skb);
-		sock_put(sk);
-		return len;
-	}
+	if (nlk->handler)
+		return 0;
 #endif
 
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
 	    test_bit(0, &nlk->state)) {
+		DECLARE_WAITQUEUE(wait, current);
 		if (!timeo) {
 			if (!nlk->pid)
 				netlink_overrun(sk);
@@ -471,19 +499,62 @@
 			kfree_skb(skb);
 			return sock_intr_errno(timeo);
 		}
-		goto retry;
+		return 1;
 	}
-
 	skb_orphan(skb);
 	skb_set_owner_r(skb, sk);
+	return 0;
+
+}
+
+int netlink_sendskb(struct sock *sk, struct sk_buff *skb, int protocol)
+{
+	struct netlink_opt *nlk;
+	int len = skb->len;
+
+	nlk = nlk_sk(sk);
+#ifdef NL_EMULATE_DEV
+	if (nlk->handler) {
+		skb_orphan(skb);
+		len = nlk->handler(protocol, skb);
+		sock_put(sk);
+		return len;
+	}
+#endif
+
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk, len);
 	sock_put(sk);
 	return len;
+}
 
-no_dst:
+void netlink_detachskb(struct sock *sk, struct sk_buff *skb)
+{
 	kfree_skb(skb);
-	return -ECONNREFUSED;
+	sock_put(sk);
+}
+
+int netlink_unicast(struct sock *ssk, struct sk_buff *skb, u32 pid, int nonblock)
+{
+	struct sock *sk;
+	int err;
+	long timeo;
+
+	timeo = sock_sndtimeo(ssk, nonblock);
+
+retry:
+	sk = netlink_getsockbypid(ssk, pid);
+	if (IS_ERR(sk)) {
+		kfree_skb(skb);
+		return PTR_ERR(skb);
+	}
+	err = netlink_attachskb(sk, skb, nonblock, timeo);
+	if (err == 1)
+		goto retry;
+	if (err)
+		return err;
+
+	return netlink_sendskb(sk, skb, ssk->sk_protocol);
 }
 
 static __inline__ int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
--- 2.6/include/linux/mqueue.h	2004-04-03 14:29:26.000000000 +0200
+++ build-2.6/include/linux/mqueue.h	2004-04-03 21:32:34.006794932 +0200
@@ -30,8 +30,24 @@
 	long	__reserved[4];	/* ignored for input, zeroed for output */
 };
 
+/*
+ * SIGEV_THREAD implementation:
+ * SIGEV_THREAD must be implemented in user space. If SIGEV_THREAD is passed
+ * to mq_notify, then
+ * - sigev_signo must be the file descriptor of an AF_NETLINK socket. It's not
+ *   necessary that the socket is bound.
+ * - sigev_value.sival_ptr must point to a cookie that is NOTIFY_COOKIE_LEN
+ *   bytes long.
+ * If the notification is triggered, then the cookie is sent to the netlink
+ * socket. The first byte of the cookie is replaced with the NOTIFY_?? codes:
+ * NOTIFY_WOKENUP if the notification got triggered, NOTIFY_REMOVED if it was
+ * removed, either due to a close() on the message queue fd or due to a
+ * mq_notify() that removed the notification.
+ */
 #define NOTIFY_NONE	0
 #define NOTIFY_WOKENUP	1
 #define NOTIFY_REMOVED	2
 
+#define NOTIFY_COOKIE_LEN	32
+
 #endif
--- 2.6/ipc/mqueue.c	2004-04-03 14:29:27.000000000 +0200
+++ build-2.6/ipc/mqueue.c	2004-04-03 20:30:07.207197313 +0200
@@ -20,6 +20,9 @@
 #include <linux/poll.h>
 #include <linux/mqueue.h>
 #include <linux/msg.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <net/sock.h>
 #include "util.h"
 
 #define MQUEUE_MAGIC	0x19800202
@@ -33,9 +36,6 @@
 #define STATE_PENDING	1
 #define STATE_READY	2
 
-#define NP_NONE		((void*)NOTIFY_NONE)
-#define NP_WOKENUP	((void*)NOTIFY_WOKENUP)
-#define NP_REMOVED	((void*)NOTIFY_REMOVED)
 /* used by sysctl */
 #define FS_MQUEUE 	1
 #define CTL_QUEUESMAX 	2
@@ -48,6 +48,8 @@
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
 
+#define NOTIFY_COOKIE_LEN	32
+
 struct ext_wait_queue {		/* queue of sleeping tasks */
 	struct task_struct *task;
 	struct list_head list;
@@ -56,25 +58,26 @@
 };
 
 struct mqueue_inode_info {
-	struct mq_attr attr;
+	spinlock_t lock;
+	struct inode vfs_inode;
+	wait_queue_head_t wait_q;
+
 	struct msg_msg **messages;
+	struct mq_attr attr;
 
-	pid_t notify_owner;	/* != 0 means notification registered */
-	struct sigevent notify;
-	struct file *notify_filp;
+	struct sigevent notify; /* notify.sigev_notify == SIGEV_NONE means */
+	pid_t notify_owner;	/*           no notification registered */
+	struct sock *notify_sock;
+	struct sk_buff *notify_cookie;
 
 	/* for tasks waiting for free space and messages, respectively */
 	struct ext_wait_queue e_wait_q[2];
-	wait_queue_head_t wait_q;
 
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
-	spinlock_t lock;
-	struct inode vfs_inode;
 };
 
 static struct inode_operations mqueue_dir_inode_operations;
 static struct file_operations mqueue_file_operations;
-static struct file_operations mqueue_notify_fops;
 static struct super_operations mqueue_super_ops;
 static void remove_notification(struct mqueue_inode_info *info);
 
@@ -119,7 +122,7 @@
 			init_waitqueue_head(&info->wait_q);
 			INIT_LIST_HEAD(&info->e_wait_q[0].list);
 			INIT_LIST_HEAD(&info->e_wait_q[1].list);
-			info->notify_owner = 0;
+			info->notify.sigev_notify = SIGEV_NONE;
 			info->qsize = 0;
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
@@ -283,10 +286,11 @@
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
@@ -299,7 +303,7 @@
 		count = slen - o;
 
 	if (copy_to_user(u_data, buffer + o, count))
-       		return -EFAULT;
+		return -EFAULT;
 
 	*off = o + count;
 	filp->f_dentry->d_inode->i_atime = filp->f_dentry->d_inode->i_ctime = CURRENT_TIME;
@@ -311,7 +315,8 @@
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (current->tgid == info->notify_owner)
+	if (info->notify.sigev_notify != SIGEV_NONE &&
+			current->tgid == info->notify_owner)
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -445,7 +450,8 @@
 	 * waiting synchronously for message AND state of queue changed from
 	 * empty to not empty. Here we are sure that no one is waiting
 	 * synchronously. */
-	if (info->notify_owner && info->attr.mq_curmsgs == 1) {
+	if (info->notify.sigev_notify != SIGEV_NONE &&
+			info->attr.mq_curmsgs == 1) {
 		/* sends signal */
 		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
 			struct siginfo sig_i;
@@ -460,10 +466,11 @@
 			kill_proc_info(info->notify.sigev_signo,
 				       &sig_i, info->notify_owner);
 		} else if (info->notify.sigev_notify == SIGEV_THREAD) {
-			info->notify_filp->private_data = (void*)NP_WOKENUP;
+			*(char*)info->notify_cookie->data = NOTIFY_WOKENUP;
+			netlink_sendskb(info->notify_sock, info->notify_cookie, 0);
 		}
 		/* after notification unregisters process */
-		info->notify_owner = 0;
+		info->notify.sigev_notify = SIGEV_NONE;
 	}
 	wake_up(&info->wait_q);
 }
@@ -499,90 +506,13 @@
 	return timeout;
 }
 
-/*
- * File descriptor based notification, intended to be used to implement
- * SIGEV_THREAD:
- * SIGEV_THREAD means that a notification function should be called in the
- * context of a new thread. The kernel can't do that. Therefore mq_notify
- * calls with SIGEV_THREAD return a new file descriptor. A user space helper
- * must create a new thread and then read from the given file descriptor.
- * The read always returns one byte. If it's NOTIFY_WOKENUP, then it must
- * call the notification function. If it's NOTIFY_REMOVED, then the
- * notification was removed. The file descriptor supports poll, thus one
- * supervisor thread can manage multiple message queue notifications.
- *
- * The implementation must support multiple outstanding notifications:
- * It's possible that a new notification is added and signaled before user
- * space calls mqueue_notify_read for the previous notification.
- * Therefore the notification state is stored in the private_data field of
- * the file descriptor.
- */
-static unsigned int mqueue_notify_poll(struct file *filp,
-					struct poll_table_struct *poll_tab)
-{
-	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
-	int retval;
-
-	poll_wait(filp, &info->wait_q, poll_tab);
-
-	if (filp->private_data == NP_NONE)
-		retval = 0;
-	else
-		retval = POLLIN | POLLRDNORM;
-	return retval;
-}
-
-static ssize_t mqueue_notify_read(struct file *filp, char __user *buf,
-					size_t count, loff_t *ppos)
-{
-	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
-	char result;
-
-	if (!count)
-		return 0;
-	if (*ppos != 0)
-		return 0;
-	spin_lock(&info->lock);
-	while (filp->private_data == NP_NONE) {
-		DEFINE_WAIT(wait);
-		if (filp->f_flags & O_NONBLOCK) {
-			spin_unlock(&info->lock);
-			return -EAGAIN;
-		}
-		prepare_to_wait(&info->wait_q, &wait, TASK_INTERRUPTIBLE);
-		spin_unlock(&info->lock);
-		schedule();
-		finish_wait(&info->wait_q, &wait);
-		spin_lock(&info->lock);
-	}
-	spin_unlock(&info->lock);
-	result = (char)(unsigned long)filp->private_data;
-	if (put_user(result, buf))
-		return -EFAULT;
-	*ppos = 1;
-	return 1;
-}
-
-static int mqueue_notify_release(struct inode *inode, struct file *filp)
-{
-	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
-
-	spin_lock(&info->lock);
-	if (info->notify_owner && info->notify_filp == filp)
-		info->notify_owner = 0;
-	filp->private_data = NP_REMOVED;
-	spin_unlock(&info->lock);
-
-	return 0;
-}
-
 static void remove_notification(struct mqueue_inode_info *info)
 {
 	if (info->notify.sigev_notify == SIGEV_THREAD) {
-		info->notify_filp->private_data = NP_REMOVED;
-		wake_up(&info->wait_q);
+		*(char*)info->notify_cookie->data = NOTIFY_REMOVED;
+		netlink_sendskb(info->notify_sock, info->notify_cookie, 0);
 	}
-	info->notify_owner = 0;
+	info->notify.sigev_notify = SIGEV_NONE;
 }
 
 /*
@@ -780,7 +710,8 @@
  */
 
 /* pipelined_send() - send a message directly to the task waiting in
- * sys_mq_timedreceive() (without inserting message into a queue). */
+ * sys_mq_timedreceive() (without inserting message into a queue).
+ */
 static inline void pipelined_send(struct mqueue_inode_info *info,
 				  struct msg_msg *message,
 				  struct ext_wait_queue *receiver)
@@ -974,12 +905,16 @@
 asmlinkage long sys_mq_notify(mqd_t mqdes,
 				const struct sigevent __user *u_notification)
 {
-	int ret, fd;
-	struct file *filp, *nfilp;
+	int ret;
+	struct file *filp;
+	struct sock *sock;
 	struct inode *inode;
 	struct sigevent notification;
 	struct mqueue_inode_info *info;
+	struct sk_buff *nc;
 
+	nc = NULL;
+	sock = NULL;
 	if (u_notification == NULL) {
 		notification.sigev_notify = SIGEV_NONE;
 	} else {
@@ -996,6 +931,44 @@
 			 notification.sigev_signo > _NSIG)) {
 			return -EINVAL;
 		}
+		if (notification.sigev_notify == SIGEV_THREAD) {
+			/* create the notify skb */
+			nc = alloc_skb(NOTIFY_COOKIE_LEN, GFP_KERNEL);
+			ret = -ENOMEM;
+			if (!nc)
+				goto out;
+			ret = -EFAULT;
+			if (copy_from_user(nc->data,
+					notification.sigev_value.sival_ptr,
+					NOTIFY_COOKIE_LEN)) {
+				goto out;
+			}
+
+			/* TODO: add a header? */
+			skb_put(nc, NOTIFY_COOKIE_LEN);
+			/* and attach it to the socket */
+retry:
+			filp = fget(notification.sigev_signo);
+			ret = -EBADF;
+			if (!filp)
+				goto out;
+			sock = netlink_getsockbyfilp(filp);
+			fput(filp);
+			if (IS_ERR(sock)) {
+				ret = PTR_ERR(sock);
+				sock = NULL;
+				goto out;
+			}
+
+			ret = netlink_attachskb(sock, nc, 0, MAX_SCHEDULE_TIMEOUT);
+			if (ret == 1)
+		       		goto retry;
+			if (ret) {
+				sock = NULL;
+				nc = NULL;
+				goto out;
+			}
+		}
 	}
 
 	ret = -EBADF;
@@ -1009,47 +982,33 @@
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
-		nfilp->f_flags = O_RDONLY;
-		nfilp->f_mode = FMODE_READ;
-	} else {
-		nfilp = NULL;
-		fd = -1;
-	}
-
 	spin_lock(&info->lock);
-
-	if (notification.sigev_notify == SIGEV_NONE) {
-		if (info->notify_owner == current->tgid) {
+	switch (notification.sigev_notify) {
+	case SIGEV_NONE:
+		if (info->notify.sigev_notify != SIGEV_NONE &&
+				info->notify_owner == current->tgid) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
-	} else if (info->notify_owner) {
-		ret = -EBUSY;
-	} else if (notification.sigev_notify == SIGEV_THREAD) {
-		info->notify_filp = nfilp;
-		fd_install(fd, nfilp);
-		ret = fd;
-		fd = -1;
-		nfilp = NULL;
+		break;
+	case SIGEV_THREAD:
+		if (info->notify.sigev_notify != SIGEV_NONE) {
+			ret = -EBUSY;
+			break;
+		}
+		info->notify_sock = sock;
+		info->notify_cookie = nc;
+		sock = NULL;
+		nc = NULL;
 		info->notify.sigev_notify = SIGEV_THREAD;
 		info->notify_owner = current->tgid;
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	}  else {
+		break;
+	case SIGEV_SIGNAL:
+		if (info->notify.sigev_notify != SIGEV_NONE) {
+			ret = -EBUSY;
+			break;
+		}
 		info->notify.sigev_signo = notification.sigev_signo;
 		info->notify.sigev_value = notification.sigev_value;
 		info->notify.sigev_notify = SIGEV_SIGNAL;
@@ -1057,12 +1016,14 @@
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}
 	spin_unlock(&info->lock);
-out_dropfd:
-	if (fd != -1)
-		put_unused_fd(fd);
 out_fput:
 	fput(filp);
 out:
+	if (sock) {
+		netlink_detachskb(sock, nc);
+	} else if (nc) {
+		dev_kfree_skb(nc);
+	}
 	return ret;
 }
 
@@ -1131,13 +1092,6 @@
 	.read = mqueue_read_file,
 };
 
-static struct file_operations mqueue_notify_fops = {
-	.poll = mqueue_notify_poll,
-	.read = mqueue_notify_read,
-	.release = mqueue_notify_release,
-};
-
-
 static struct super_operations mqueue_super_ops = {
 	.alloc_inode = mqueue_alloc_inode,
 	.destroy_inode = mqueue_destroy_inode,

--------------020509080401080507010703--

