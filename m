Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWB0Sg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWB0Sg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWB0Sg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:36:56 -0500
Received: from [198.99.130.12] ([198.99.130.12]:36317 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751481AbWB0Sgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:36:55 -0500
Date: Mon, 27 Feb 2006 13:37:59 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Add O_ASYNC support to FUSE
Message-ID: <20060227183759.GA5669@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds asynchronous notification to FUSE - a FUSE server can
request O_ASYNC on a /dev/fuse file descriptor and receive SIGIO
when there is input available.

One subtlety - fuse_dev_fasync, which is called when O_ASYNC is
requested, does no locking, unlike the other methods.  I think it's
unnecessary, as the fuse_conn.fasync list is manipulated only by
fasync_helper and kill_fasync, which provide their own locking.  It
would also be wrong to use fuse_lock, as it's a spin lock and
fasync_helper can sleep.  My one concern with this is the fuse_conn
going away underneath fuse_dev_fasync - sys_fcntl takes a reference
on the file struct, so this seems not to be a problem.

One possible bug - there is a wakeup in inode.c:fuse_put_super, but
sticking a kill_fasync there causes BUGs because the /dev/fuse
file struct seems to have gone away.  So, this may be lacking when a
FUSE mount is unmounted from underneath the server (is that
possible, or must the server be killed in order to do the umount?).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: host-2.6.15-fuse/fs/fuse/dev.c
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/dev.c	2006-02-18 12:19:07.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/dev.c	2006-02-27 13:19:10.000000000 -0500
@@ -311,6 +311,7 @@ static void queue_request(struct fuse_co
 	list_add_tail(&req->list, &fc->pending);
 	req->state = FUSE_REQ_PENDING;
 	wake_up(&fc->waitq);
+	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 }
 
 /*
@@ -894,6 +895,7 @@ void fuse_abort_conn(struct fuse_conn *f
 		end_requests(fc, &fc->pending);
 		end_requests(fc, &fc->processing);
 		wake_up_all(&fc->waitq);
+		kill_fasync(&fc->fasync, SIGIO, POLLIN);
 	}
 	spin_unlock(&fuse_lock);
 }
@@ -913,9 +915,20 @@ static int fuse_dev_release(struct inode
 	if (fc)
 		kobject_put(&fc->kobj);
 
+	fasync_helper(-1, file, 0, &fc->fasync);
+
 	return 0;
 }
 
+static int fuse_dev_fasync(int fd, struct file *file, int on)
+{
+	struct fuse_conn *fc;
+
+	/* No locking - fasync_helper does its own locking */
+	fc = file->private_data;
+	return(fasync_helper(fd, file, on, &fc->fasync));
+}
+
 struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -925,6 +938,7 @@ struct file_operations fuse_dev_operatio
 	.writev		= fuse_dev_writev,
 	.poll		= fuse_dev_poll,
 	.release	= fuse_dev_release,
+	.fasync		= fuse_dev_fasync,
 };
 
 static struct miscdevice fuse_miscdevice = {
Index: host-2.6.15-fuse/fs/fuse/fuse_i.h
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/fuse_i.h	2006-02-24 17:46:47.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/fuse_i.h	2006-02-24 18:24:49.000000000 -0500
@@ -318,6 +318,9 @@ struct fuse_conn {
 
 	/** kobject */
 	struct kobject kobj;
+
+	/** O_ASYNC requests */
+	struct fasync_struct *fasync;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
Index: host-2.6.15-fuse/fs/fuse/inode.c
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/inode.c	2006-02-18 12:19:07.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/inode.c	2006-02-27 13:17:50.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/statfs.h>
+#include <linux/poll.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -377,6 +378,7 @@ static void fuse_conn_release(struct kob
 		list_del(&req->list);
 		fuse_request_free(req);
 	}
+
 	kfree(fc);
 }
 
@@ -409,6 +411,7 @@ static struct fuse_conn *new_conn(void)
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
 		fc->reqctr = 0;
+		fc->fasync = NULL;
 	}
 	return fc;
 }
