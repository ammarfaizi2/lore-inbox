Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUDMTCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDMTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:02:53 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:45466 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263684AbUDMTCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:02:40 -0400
Date: Tue, 13 Apr 2004 15:35:49 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH] Fix mq_notify with SIGEV_NONE notification
Message-ID: <20040413133549.GY514@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

mq_notify (q, NULL)
and
struct sigevent ev = { .sigev_notify = SIGEV_NONE };
mq_notify (q, &ev)
are not the same thing in POSIX, yet the kernel treats them the same.
Only the former makes the notification available to other processes
immediately, see
http://www.opengroup.org/onlinepubs/007904975/functions/mq_notify.html
Without the patch below,
http://sources.redhat.com/ml/libc-hacker/2004-04/msg00028.html
glibc test fails.
I looked at mq in Solaris and they behave the same in this regard
as Linux with this patch.
Kernel with this patch passes both Intel POSIX testsuite (with testsuite
fixes from Ulrich) and glibc mq testsuite.

--- linux-2.6.5-bk/ipc/mqueue.c.jj	2004-04-13 11:32:06.000000000 +0200
+++ linux-2.6.5-bk/ipc/mqueue.c	2004-04-13 14:27:57.000000000 +0200
@@ -65,8 +65,8 @@ struct mqueue_inode_info {
 	struct msg_msg **messages;
 	struct mq_attr attr;
 
-	struct sigevent notify; /* notify.sigev_notify == SIGEV_NONE means */
-	pid_t notify_owner;	/*           no notification registered */
+	struct sigevent notify;
+	pid_t notify_owner;
 	struct sock *notify_sock;
 	struct sk_buff *notify_cookie;
 
@@ -122,7 +122,7 @@ static struct inode *mqueue_get_inode(st
 			init_waitqueue_head(&info->wait_q);
 			INIT_LIST_HEAD(&info->e_wait_q[0].list);
 			INIT_LIST_HEAD(&info->e_wait_q[1].list);
-			info->notify.sigev_notify = SIGEV_NONE;
+			info->notify_owner = 0;
 			info->qsize = 0;
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
@@ -286,11 +286,11 @@ static ssize_t mqueue_read_file(struct f
 	snprintf(buffer, sizeof(buffer),
 			"QSIZE:%-10lu NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
 			info->qsize,
-			info->notify.sigev_notify,
-			(info->notify.sigev_notify == SIGEV_SIGNAL ) ?
+			info->notify_owner ? info->notify.sigev_notify : 0,
+			(info->notify_owner &&
+			 info->notify.sigev_notify == SIGEV_SIGNAL) ?
 				info->notify.sigev_signo : 0,
-			(info->notify.sigev_notify != SIGEV_NONE) ?
-				info->notify_owner : 0);
+			info->notify_owner);
 	spin_unlock(&info->lock);
 	buffer[sizeof(buffer)-1] = '\0';
 	slen = strlen(buffer)+1;
@@ -315,8 +315,7 @@ static int mqueue_flush_file(struct file
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (info->notify.sigev_notify != SIGEV_NONE &&
-			current->tgid == info->notify_owner)
+	if (current->tgid == info->notify_owner)
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -455,11 +454,14 @@ static void __do_notify(struct mqueue_in
 	 * waiting synchronously for message AND state of queue changed from
 	 * empty to not empty. Here we are sure that no one is waiting
 	 * synchronously. */
-	if (info->notify.sigev_notify != SIGEV_NONE &&
-			info->attr.mq_curmsgs == 1) {
-		/* sends signal */
-		if (info->notify.sigev_notify == SIGEV_SIGNAL) {
-			struct siginfo sig_i;
+	if (info->notify_owner &&
+	    info->attr.mq_curmsgs == 1) {
+		struct siginfo sig_i;
+		switch (info->notify.sigev_notify) {
+		case SIGEV_NONE:
+			break;
+		case SIGEV_SIGNAL:
+			/* sends signal */
 
 			sig_i.si_signo = info->notify.sigev_signo;
 			sig_i.si_errno = 0;
@@ -470,13 +472,15 @@ static void __do_notify(struct mqueue_in
 
 			kill_proc_info(info->notify.sigev_signo,
 				       &sig_i, info->notify_owner);
-		} else if (info->notify.sigev_notify == SIGEV_THREAD) {
+			break;
+		case SIGEV_THREAD:
 			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
 			netlink_sendskb(info->notify_sock,
 					info->notify_cookie, 0);
+			break;
 		}
 		/* after notification unregisters process */
-		info->notify.sigev_notify = SIGEV_NONE;
+		info->notify_owner = 0;
 	}
 	wake_up(&info->wait_q);
 }
@@ -514,11 +518,12 @@ static long prepare_timeout(const struct
 
 static void remove_notification(struct mqueue_inode_info *info)
 {
-	if (info->notify.sigev_notify == SIGEV_THREAD) {
+	if (info->notify_owner != 0 &&
+	    info->notify.sigev_notify == SIGEV_THREAD) {
 		set_cookie(info->notify_cookie, NOTIFY_REMOVED);
 		netlink_sendskb(info->notify_sock, info->notify_cookie, 0);
 	}
-	info->notify.sigev_notify = SIGEV_NONE;
+	info->notify_owner = 0;
 }
 
 /*
@@ -908,9 +913,9 @@ out:
 }
 
 /*
- * Notes: the case when user wants us to deregister (with NULL as pointer
- * or SIGEV_NONE) and he isn't currently owner of notification will be
- * silently discarded. It isn't explicitly defined in the POSIX.
+ * Notes: the case when user wants us to deregister (with NULL as pointer)
+ * and he isn't currently owner of notification, will be silently discarded.
+ * It isn't explicitly defined in the POSIX.
  */
 asmlinkage long sys_mq_notify(mqd_t mqdes,
 				const struct sigevent __user *u_notification)
@@ -925,9 +930,7 @@ asmlinkage long sys_mq_notify(mqd_t mqde
 
 	nc = NULL;
 	sock = NULL;
-	if (u_notification == NULL) {
-		notification.sigev_notify = SIGEV_NONE;
-	} else {
+	if (u_notification != NULL) {
 		if (copy_from_user(&notification, u_notification,
 					sizeof(struct sigevent)))
 			return -EFAULT;
@@ -993,35 +996,31 @@ retry:
 
 	ret = 0;
 	spin_lock(&info->lock);
-	switch (notification.sigev_notify) {
-	case SIGEV_NONE:
-		if (info->notify.sigev_notify != SIGEV_NONE &&
-				info->notify_owner == current->tgid) {
+	if (u_notification == NULL) {
+		if (info->notify_owner == current->tgid) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
-		break;
-	case SIGEV_THREAD:
-		if (info->notify.sigev_notify != SIGEV_NONE) {
-			ret = -EBUSY;
+	} else if (info->notify_owner != 0) {
+		ret = -EBUSY;
+	} else {
+		switch (notification.sigev_notify) {
+		case SIGEV_NONE:
+			info->notify.sigev_notify = SIGEV_NONE;
 			break;
-		}
-		info->notify_sock = sock;
-		info->notify_cookie = nc;
-		sock = NULL;
-		nc = NULL;
-		info->notify.sigev_notify = SIGEV_THREAD;
-		info->notify_owner = current->tgid;
-		inode->i_atime = inode->i_ctime = CURRENT_TIME;
-		break;
-	case SIGEV_SIGNAL:
-		if (info->notify.sigev_notify != SIGEV_NONE) {
-			ret = -EBUSY;
+		case SIGEV_THREAD:
+			info->notify_sock = sock;
+			info->notify_cookie = nc;
+			sock = NULL;
+			nc = NULL;
+			info->notify.sigev_notify = SIGEV_THREAD;
+			break;
+		case SIGEV_SIGNAL:
+			info->notify.sigev_signo = notification.sigev_signo;
+			info->notify.sigev_value = notification.sigev_value;
+			info->notify.sigev_notify = SIGEV_SIGNAL;
 			break;
 		}
-		info->notify.sigev_signo = notification.sigev_signo;
-		info->notify.sigev_value = notification.sigev_value;
-		info->notify.sigev_notify = SIGEV_SIGNAL;
 		info->notify_owner = current->tgid;
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}


	Jakub
