Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWCAC1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWCAC1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWCAC1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:27:04 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:5356 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964819AbWCAC1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:27:01 -0500
Date: Tue, 28 Feb 2006 21:28:00 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add O_ASYNC support to FUSE
Message-ID: <20060301022800.GA9624@ccure.user-mode-linux.org>
References: <20060227183759.GA5669@ccure.user-mode-linux.org> <E1FE1sy-0006Bz-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FE1sy-0006Bz-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patch below...

On Tue, Feb 28, 2006 at 11:15:16AM +0100, Miklos Szeredi wrote:
> Yes, but you need to use fuse_get_conn() and check the result (see
> fuse_dev_poll()).

Fixed.

> Although it may be possible that kill_fasync() races with the final
> fput(), but as I see kill_fasync() only uses the file->f_owner field
> which should still be valid before and during file->release().
> 
> Which BUG is triggered?

I cleaned up a couple things, and I can't make it break any more.

> This should be POLL_IN too, no?

Duh, yes.

> I like this style better:

Fixed.

				Jeff

# This adds asynchronous notification to FUSE - a FUSE server can
# request O_ASYNC on a /dev/fuse file descriptor and receive SIGIO
# when there is input available.
#
# One subtlety - fuse_dev_fasync, which is called when O_ASYNC is
# requested, does no locking, unlink the other methods.  I think it's
# unnecessary, as the fuse_conn.fasync list is manipulated only by
# fasync_helper and kill_fasync, which provide their own locking.  It
# would also be wrong to use the fuse_lock, as it's a spin lock and
# fasync_helper can sleep.  My one concern with this is the fuse_conn
# going away underneath fuse_dev_fasync - sys_fcntl takes a reference
# on the file struct, so this seems not to be a problem.
#
# Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: host-2.6.15-fuse/fs/fuse/dev.c
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/dev.c	2006-02-18 12:19:07.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/dev.c	2006-02-28 21:04:40.000000000 -0500
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
+		kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	}
 	spin_unlock(&fuse_lock);
 }
@@ -910,12 +912,26 @@ static int fuse_dev_release(struct inode
 		end_requests(fc, &fc->processing);
 	}
 	spin_unlock(&fuse_lock);
-	if (fc)
+	if (fc) {
 		kobject_put(&fc->kobj);
+		fasync_helper(-1, file, 0, &fc->fasync);
+		fc->fasync = NULL;
+	}
 
 	return 0;
 }
 
+static int fuse_dev_fasync(int fd, struct file *file, int on)
+{
+	struct fuse_conn *fc = fuse_get_conn(file);
+
+	if (!fc)
+		return -ENODEV;
+
+	/* No locking - fasync_helper does its own locking */
+	return fasync_helper(fd, file, on, &fc->fasync);
+}
+
 struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -925,6 +941,7 @@ struct file_operations fuse_dev_operatio
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
+++ host-2.6.15-fuse/fs/fuse/inode.c	2006-02-28 21:00:55.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/statfs.h>
+#include <linux/poll.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -216,6 +217,7 @@ static void fuse_put_super(struct super_
 	spin_unlock(&fuse_lock);
 	up_write(&fc->sbput_sem);
 	/* Flush all readers on this fs */
+	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
 	wake_up_all(&fc->waitq);
 	kobject_del(&fc->kobj);
 	kobject_put(&fc->kobj);
@@ -409,6 +411,7 @@ static struct fuse_conn *new_conn(void)
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
 		fc->reqctr = 0;
+		fc->fasync = NULL;
 	}
 	return fc;
 }
