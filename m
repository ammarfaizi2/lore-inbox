Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWCaRui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWCaRui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWCaRui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:50:38 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:21211 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932159AbWCaRuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:50:37 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 3/10] fuse: add O_ASYNC support to FUSE device
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNlQ-0005bB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:50:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Dike <jdike@addtoit.com>

This adds asynchronous notification to FUSE - a FUSE server can
request O_ASYNC on a /dev/fuse file descriptor and receive SIGIO
when there is input available.

One subtlety - fuse_dev_fasync, which is called when O_ASYNC is
requested, does no locking, unlink the other methods.  I think it's
unnecessary, as the fuse_conn.fasync list is manipulated only by
fasync_helper and kill_fasync, which provide their own locking.  It
would also be wrong to use the fuse_lock, as it's a spin lock and
fasync_helper can sleep.  My one concern with this is the fuse_conn
going away underneath fuse_dev_fasync - sys_fcntl takes a reference
on the file struct, so this seems not to be a problem.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-03-31 18:55:30.000000000 +0200
+++ linux/fs/fuse/dev.c	2006-03-31 18:55:31.000000000 +0200
@@ -317,6 +317,7 @@ static void queue_request(struct fuse_co
 	list_add_tail(&req->list, &fc->pending);
 	req->state = FUSE_REQ_PENDING;
 	wake_up(&fc->waitq);
+	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 }
 
 /*
@@ -901,6 +902,7 @@ void fuse_abort_conn(struct fuse_conn *f
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
 		wake_up_all(&fc->waitq);
+		kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock(&fuse_lock);
 }
@@ -917,12 +919,24 @@ static int fuse_dev_release(struct inode
 		end_requests(fc, &fc->processing);
 	}
 	spin_unlock(&fuse_lock);
-	if (fc)
+	if (fc) {
+		fasync_helper(-1, file, 0, &fc->fasync);
 		kobject_put(&fc->kobj);
+	}
 
 	return 0;
 }
 
+static int fuse_dev_fasync(int fd, struct file *file, int on)
+{
+	struct fuse_conn *fc = fuse_get_conn(file);
+	if (!fc)
+		return -ENODEV;
+
+	/* No locking - fasync_helper does its own locking */
+	return fasync_helper(fd, file, on, &fc->fasync);
+}
+
 const struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -932,6 +946,7 @@ const struct file_operations fuse_dev_op
 	.writev		= fuse_dev_writev,
 	.poll		= fuse_dev_poll,
 	.release	= fuse_dev_release,
+	.fasync		= fuse_dev_fasync,
 };
 
 static struct miscdevice fuse_miscdevice = {
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-03-31 18:55:11.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-03-31 18:55:31.000000000 +0200
@@ -318,6 +318,9 @@ struct fuse_conn {
 
 	/** kobject */
 	struct kobject kobj;
+
+	/** O_ASYNC requests */
+	struct fasync_struct *fasync;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:11.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:31.000000000 +0200
@@ -216,6 +216,7 @@ static void fuse_put_super(struct super_
 	spin_unlock(&fuse_lock);
 	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
+	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
 	kobject_del(&fc->kobj);
 	kobject_put(&fc->kobj);
