Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUBSOfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUBSOc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:32:58 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:50564 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S266681AbUBSOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:30:07 -0500
Date: Thu, 19 Feb 2004 15:30:01 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Michal Wronski <wrona@mat.uni.torun.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC][PATCH] 4/6 POSIX message queues
Message-ID: <Pine.GSO.4.58.0402191529150.18841@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 2
//  EXTRAVERSION =
--- 2.6/ipc/mqueue.c	2004-02-16 23:01:18.000000000 +0100
+++ build-2.6/ipc/mqueue.c	2004-02-16 23:01:05.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/mqueue.h>
 #include <linux/msg.h>
 #include <linux/list.h>
+#include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -250,6 +251,24 @@
 	return 0;
 }

+static unsigned int mqueue_poll_file(struct file *filp, struct poll_table_struct *poll_tab)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
+	int retval = 0;
+
+	poll_wait(filp, &info->wait_q, poll_tab);
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
 /* Adds current to info->e_wait_q[sr] before element with smaller prio */
 static void wq_add(struct mqueue_inode_info *info, int sr,
 			struct ext_wait_queue *ewp)
@@ -374,11 +393,11 @@
 				       &sig_i, info->notify_owner);
 		} else if (info->notify.sigev_notify == SIGEV_THREAD) {
 			info->notify_filp->private_data = (void*)NP_WOKENUP;
-			wake_up(&info->wait_q);
 		}
 		/* after notification unregisters process */
 		info->notify_owner = 0;
 	}
+	wake_up(&info->wait_q);
 }

 static long prepare_timeout(const struct timespec __user *u_arg)
@@ -660,9 +679,11 @@
 {
 	struct ext_wait_queue *sender = wq_get_first_waiter(info, SEND);

-	if (!sender)
+	if (!sender) {
+		/* for poll */
+		wake_up_interruptible(&info->wait_q);
 		return;
-
+	}
 	msg_insert(sender->msg, info);
 	list_del(&sender->list);
 	sender->state = STATE_PENDING;
@@ -974,6 +995,7 @@

 static struct file_operations mqueue_file_operations = {
 	.flush = mqueue_flush_file,
+	.poll = mqueue_poll_file,
 };

 static struct file_operations mqueue_notify_fops = {
