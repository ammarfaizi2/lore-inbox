Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUGBNQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUGBNQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGBNQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:16:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:11206 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264500AbUGBNOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:14:33 -0400
Date: Fri, 2 Jul 2004 18:53:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 10/22] AIO pipe support
Message-ID: <20040702132356.GJ4374@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch
> [10] aio-pipe.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
---------------------------------------------------

From: Chris Mason <mason@suse.com>

AIO support for pipes (using the retry infrastructure).

They were easier than I expected ;-)  This goes on top of your fsaio
patches.  This is only lightly tested.

I missed the obvious for the pipe aio cancel routine, which is to just
wake up the pipe wait queue (which is what the retry is waiting on).
Here's a new pipe aio patch, along with a change to sys_aio_cancel to
set the cancel bit (See aio-cancel.patch).  I'm not 100% sure we need
it, but it seems like a good idea.


 fs/pipe.c                 |  102 +++++++++++++++++++++++++++++++++++++--------- include/linux/pipe_fs_i.h |    2 
 2 files changed, 84 insertions(+), 20 deletions(-)

--- aio/fs/pipe.c	2004-06-15 22:19:35.000000000 -0700
+++ aio-pipe/fs/pipe.c	2004-06-18 09:55:34.746340192 -0700
@@ -33,15 +33,21 @@
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
-void pipe_wait(struct inode * inode)
+int pipe_wait(struct inode * inode)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(local_wait);
+	wait_queue_t *wait = &local_wait;
 
-	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
+	if (current->io_wait)
+		wait = current->io_wait;
+	prepare_to_wait(PIPE_WAIT(*inode), wait, TASK_INTERRUPTIBLE);
+	if (!is_sync_wait(wait))
+		return -EIOCBRETRY;
 	up(PIPE_SEM(*inode));
 	schedule();
-	finish_wait(PIPE_WAIT(*inode), &wait);
+	finish_wait(PIPE_WAIT(*inode), wait);
 	down(PIPE_SEM(*inode));
+	return 0;
 }
 
 static inline int
@@ -81,11 +87,11 @@ pipe_iov_copy_to_user(struct iovec *iov,
 		iov->iov_base += copy;
 		iov->iov_len -= copy;
 	}
-	return 0;
+	return 0; 
 }
 
 static ssize_t
-pipe_readv(struct file *filp, const struct iovec *_iov,
+pipe_aio_readv(struct file *filp, const struct iovec *_iov,
 	   unsigned long nr_segs, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -93,6 +99,7 @@ pipe_readv(struct file *filp, const stru
 	ssize_t ret;
 	struct iovec *iov = (struct iovec *)_iov;
 	size_t total_len;
+	ssize_t retry;
 
 	/* pread is not allowed on pipes. */
 	if (unlikely(ppos != &filp->f_pos))
@@ -156,7 +163,12 @@ pipe_readv(struct file *filp, const stru
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
-		pipe_wait(inode);
+		retry = pipe_wait(inode);
+		if (retry == -EIOCBRETRY) {
+			if (!ret)
+				ret = retry;
+			break;
+		}
 	}
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
@@ -173,11 +185,15 @@ static ssize_t
 pipe_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = count };
-	return pipe_readv(filp, &iov, 1, ppos);
+	ssize_t ret;
+	ret = pipe_aio_readv(filp, &iov, 1, ppos);
+	if (ret == -EIOCBRETRY)
+		BUG();
+	return ret;
 }
 
 static ssize_t
-pipe_writev(struct file *filp, const struct iovec *_iov,
+pipe_aio_writev(struct file *filp, const struct iovec *_iov,
 	    unsigned long nr_segs, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -186,6 +202,7 @@ pipe_writev(struct file *filp, const str
 	int do_wakeup;
 	struct iovec *iov = (struct iovec *)_iov;
 	size_t total_len;
+	int retry;
 
 	/* pwrite is not allowed on pipes. */
 	if (unlikely(ppos != &filp->f_pos))
@@ -254,7 +271,12 @@ pipe_writev(struct file *filp, const str
 			do_wakeup = 0;
 		}
 		PIPE_WAITING_WRITERS(*inode)++;
-		pipe_wait(inode);
+		retry = pipe_wait(inode);
+		if (retry == -EIOCBRETRY) {
+			if (!ret)
+				ret = retry;
+			break;
+		}
 		PIPE_WAITING_WRITERS(*inode)--;
 	}
 	up(PIPE_SEM(*inode));
@@ -272,7 +294,41 @@ pipe_write(struct file *filp, const char
 	   size_t count, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = count };
-	return pipe_writev(filp, &iov, 1, ppos);
+	return pipe_aio_writev(filp, &iov, 1, ppos);
+}
+
+static int
+pipe_aio_cancel(struct kiocb *iocb, struct io_event *evt)
+{
+	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
+	evt->obj = (u64)(unsigned long)iocb->ki_obj.user;
+	evt->data = iocb->ki_user_data;
+	evt->res = iocb->ki_nbytes - iocb->ki_left;
+	if (evt->res == 0)
+		evt->res = -EINTR;
+	evt->res2 = 0;
+	wake_up_interruptible(PIPE_WAIT(*inode));
+	aio_put_req(iocb);
+	return 0;
+}
+
+static ssize_t
+pipe_aio_write(struct kiocb *iocb, const char __user *buf,
+			       size_t count, loff_t pos)
+{
+	struct file *file = iocb->ki_filp;
+	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = count };
+	iocb->ki_cancel = pipe_aio_cancel;
+	return pipe_aio_writev(file, &iov, 1, &file->f_pos);
+}
+
+static ssize_t
+pipe_aio_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
+{
+	struct file *file = iocb->ki_filp;
+	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = count };
+	iocb->ki_cancel = pipe_aio_cancel;
+	return pipe_aio_readv(file, &iov, 1, &file->f_pos);
 }
 
 static ssize_t
@@ -467,7 +523,8 @@ pipe_rdwr_open(struct inode *inode, stru
 struct file_operations read_fifo_fops = {
 	.llseek		= no_llseek,
 	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.readv		= pipe_aio_readv,
+	.aio_read	= pipe_aio_read,
 	.write		= bad_pipe_w,
 	.poll		= fifo_poll,
 	.ioctl		= pipe_ioctl,
@@ -480,7 +537,8 @@ struct file_operations write_fifo_fops =
 	.llseek		= no_llseek,
 	.read		= bad_pipe_r,
 	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.writev		= pipe_aio_writev,
+	.aio_write	= pipe_aio_write,
 	.poll		= fifo_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
@@ -491,9 +549,11 @@ struct file_operations write_fifo_fops =
 struct file_operations rdwr_fifo_fops = {
 	.llseek		= no_llseek,
 	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.readv		= pipe_aio_readv,
 	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.writev		= pipe_aio_writev,
+	.aio_write	= pipe_aio_write,
+	.aio_read	= pipe_aio_read,
 	.poll		= fifo_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
@@ -504,7 +564,8 @@ struct file_operations rdwr_fifo_fops = 
 struct file_operations read_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.aio_read	= pipe_aio_read,
+	.readv		= pipe_aio_readv,
 	.write		= bad_pipe_w,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
@@ -517,7 +578,8 @@ struct file_operations write_pipe_fops =
 	.llseek		= no_llseek,
 	.read		= bad_pipe_r,
 	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.writev		= pipe_aio_writev,
+	.aio_write	= pipe_aio_write,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
@@ -528,9 +590,11 @@ struct file_operations write_pipe_fops =
 struct file_operations rdwr_pipe_fops = {
 	.llseek		= no_llseek,
 	.read		= pipe_read,
-	.readv		= pipe_readv,
+	.readv		= pipe_aio_readv,
+	.aio_read	= pipe_aio_read,
+	.aio_write	= pipe_aio_write,
 	.write		= pipe_write,
-	.writev		= pipe_writev,
+	.writev		= pipe_aio_writev,
 	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
--- aio/include/linux/pipe_fs_i.h	2004-06-15 22:19:42.000000000 -0700
+++ aio-pipe/include/linux/pipe_fs_i.h	2004-06-18 09:55:34.746340192 -0700
@@ -41,7 +41,7 @@ struct pipe_inode_info {
 #define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
-void pipe_wait(struct inode * inode);
+int pipe_wait(struct inode * inode);
 
 struct inode* pipe_new(struct inode* inode);
 
