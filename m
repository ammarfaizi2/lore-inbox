Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261846AbSJQH33>; Thu, 17 Oct 2002 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJQH32>; Thu, 17 Oct 2002 03:29:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:25242 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261849AbSJQH3M>;
	Thu, 17 Oct 2002 03:29:12 -0400
Message-ID: <3DAE6826.72C345EE@digeo.com>
Date: Thu, 17 Oct 2002 00:35:02 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Pathological case identified from contest
References: <1034820820.3dae1cd4bc0e3@kolivas.net> <3DAE252B.A9A5F6B1@digeo.com> <1034828795.3dae3bfb42911@kolivas.net> <1034839006.3dae63de3f69a@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 07:35:03.0398 (UTC) FILETIME=[B4DE2860:01C275AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> Well this has become more common with 2.5.43-mm2. I had to abort the
> process_load run 3 times when benchmarking it. Going back to other kernels and
> trying them it didnt happen so I dont think its my hardware failing or something
> like that.

No, it's a bug in either the pipe code or the CPU scheduler I'd say.

You could try backing out to the 2.5.40 pipe implementation; not sure if
that would tell us much though.

Here's a backout patch:


 fs/pipe.c                 |  323 +++++++++++++++++++++++++---------------------
 include/linux/pipe_fs_i.h |    2 
 2 files changed, 183 insertions(+), 142 deletions(-)

--- 2.5.43/include/linux/pipe_fs_i.h~pipe-backout	Thu Oct 17 00:28:13 2002
+++ 2.5.43-akpm/include/linux/pipe_fs_i.h	Thu Oct 17 00:28:25 2002
@@ -9,6 +9,7 @@ struct pipe_inode_info {
 	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
+	unsigned int waiting_readers;
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
@@ -27,6 +28,7 @@ struct pipe_inode_info {
 #define PIPE_LEN(inode)		((inode).i_pipe->len)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
+#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
--- 2.5.43/fs/pipe.c~pipe-backout	Thu Oct 17 00:28:16 2002
+++ 2.5.43-akpm/fs/pipe.c	Thu Oct 17 00:28:20 2002
@@ -25,9 +25,6 @@
  *
  * FIFOs and Pipes now generate SIGIO for both readers and writers.
  * -- Jeremy Elson <jelson@circlemud.org> 2001-08-16
- *
- * pipe_read & write cleanup
- * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -47,81 +44,97 @@ static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	int do_wakeup;
-	ssize_t ret;
+	ssize_t size, read, ret;
 
-	/* pread is not allowed on pipes. */
-	if (unlikely(ppos != &filp->f_pos))
-		return -ESPIPE;
-	
-	/* Null read succeeds. */
-	if (unlikely(count == 0))
-		return 0;
+	/* Seeks are not allowed on pipes.  */
+	ret = -ESPIPE;
+	read = 0;
+	if (ppos != &filp->f_pos)
+		goto out_nolock;
 
-	do_wakeup = 0;
+	/* Always return 0 on null read.  */
 	ret = 0;
-	down(PIPE_SEM(*inode));
-	for (;;) {
-		int size = PIPE_LEN(*inode);
-		if (size) {
-			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
-			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
-
-			if (chars > count)
-				chars = count;
-			if (chars > size)
-				chars = size;
-
-			if (copy_to_user(buf, pipebuf, chars)) {
-				if (!ret) ret = -EFAULT;
-				break;
-			}
-			ret += chars;
+	if (count == 0)
+		goto out_nolock;
 
-			PIPE_START(*inode) += chars;
-			PIPE_START(*inode) &= (PIPE_SIZE - 1);
-			PIPE_LEN(*inode) -= chars;
-			count -= chars;
-			buf += chars;
-			do_wakeup = 1;
-		}
-		if (!count)
-			break;	/* common path: read succeeded */
-		if (PIPE_LEN(*inode)) /* test for cyclic buffers */
-			continue;
+	/* Get the pipe semaphore */
+	ret = -ERESTARTSYS;
+	if (down_interruptible(PIPE_SEM(*inode)))
+		goto out_nolock;
+
+	if (PIPE_EMPTY(*inode)) {
+do_more_read:
+		ret = 0;
 		if (!PIPE_WRITERS(*inode))
-			break;
-		if (!PIPE_WAITING_WRITERS(*inode)) {
-			/* syscall merging: Usually we must not sleep
-			 * if O_NONBLOCK is set, or if we got some data.
-			 * But if a writer sleeps in kernel space, then
-			 * we can wait for that data without violating POSIX.
-			 */
-			if (ret)
-				break;
-			if (filp->f_flags & O_NONBLOCK) {
-				ret = -EAGAIN;
+			goto out;
+
+		ret = -EAGAIN;
+		if (filp->f_flags & O_NONBLOCK)
+			goto out;
+
+		for (;;) {
+			PIPE_WAITING_READERS(*inode)++;
+			pipe_wait(inode);
+			PIPE_WAITING_READERS(*inode)--;
+			ret = -ERESTARTSYS;
+			if (signal_pending(current))
+				goto out;
+			ret = 0;
+			if (!PIPE_EMPTY(*inode))
 				break;
-			}
+			if (!PIPE_WRITERS(*inode))
+				goto out;
 		}
-		if (signal_pending(current)) {
-			if (!ret) ret = -ERESTARTSYS;
-			break;
-		}
-		if (do_wakeup) {
-			wake_up_interruptible(PIPE_WAIT(*inode));
- 			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
-		}
-		pipe_wait(inode);
 	}
-	up(PIPE_SEM(*inode));
-	/* Signal writers asynchronously that there is more room.  */
-	if (do_wakeup) {
+
+	/* Read what data is available.  */
+	ret = -EFAULT;
+	while (count > 0 && (size = PIPE_LEN(*inode))) {
+		char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
+		ssize_t chars = PIPE_MAX_RCHUNK(*inode);
+
+		if (chars > count)
+			chars = count;
+		if (chars > size)
+			chars = size;
+
+		if (copy_to_user(buf, pipebuf, chars))
+			goto out;
+
+		read += chars;
+		PIPE_START(*inode) += chars;
+		PIPE_START(*inode) &= (PIPE_SIZE - 1);
+		PIPE_LEN(*inode) -= chars;
+		count -= chars;
+		buf += chars;
+	}
+
+	/* Cache behaviour optimization */
+	if (!PIPE_LEN(*inode))
+		PIPE_START(*inode) = 0;
+
+	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
+		/*
+		 * We know that we are going to sleep: signal
+		 * writers synchronously that there is more
+		 * room.
+		 */
 		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+ 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+		if (!PIPE_EMPTY(*inode))
+			BUG();
+		goto do_more_read;
 	}
-	if (ret > 0)
-		UPDATE_ATIME(inode);
+	/* Signal writers asynchronously that there is more room.  */
+	wake_up_interruptible(PIPE_WAIT(*inode));
+ 	kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+
+	ret = read;
+out:
+	up(PIPE_SEM(*inode));
+out_nolock:
+	if (read)
+		ret = read;
 	return ret;
 }
 
@@ -129,90 +142,116 @@ static ssize_t
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t ret;
-	size_t min;
-	int do_wakeup;
-
-	/* pwrite is not allowed on pipes. */
-	if (unlikely(ppos != &filp->f_pos))
-		return -ESPIPE;
-	
-	/* Null write succeeds. */
-	if (unlikely(count == 0))
-		return 0;
+	ssize_t free, written, ret;
 
-	do_wakeup = 0;
+	/* Seeks are not allowed on pipes.  */
+	ret = -ESPIPE;
+	written = 0;
+	if (ppos != &filp->f_pos)
+		goto out_nolock;
+
+	/* Null write succeeds.  */
 	ret = 0;
-	min = count;
-	if (min > PIPE_BUF)
-		min = 1;
-	down(PIPE_SEM(*inode));
-	for (;;) {
-		int free;
-		if (!PIPE_READERS(*inode)) {
-			send_sig(SIGPIPE, current, 0);
-			if (!ret) ret = -EPIPE;
-			break;
+	if (count == 0)
+		goto out_nolock;
+
+	ret = -ERESTARTSYS;
+	if (down_interruptible(PIPE_SEM(*inode)))
+		goto out_nolock;
+
+	/* No readers yields SIGPIPE.  */
+	if (!PIPE_READERS(*inode))
+		goto sigpipe;
+
+	/* If count <= PIPE_BUF, we have to make it atomic.  */
+	free = (count <= PIPE_BUF ? count : 1);
+
+	/* Wait, or check for, available space.  */
+	if (filp->f_flags & O_NONBLOCK) {
+		ret = -EAGAIN;
+		if (PIPE_FREE(*inode) < free)
+			goto out;
+	} else {
+		while (PIPE_FREE(*inode) < free) {
+			PIPE_WAITING_WRITERS(*inode)++;
+			pipe_wait(inode);
+			PIPE_WAITING_WRITERS(*inode)--;
+			ret = -ERESTARTSYS;
+			if (signal_pending(current))
+				goto out;
+
+			if (!PIPE_READERS(*inode))
+				goto sigpipe;
 		}
-		free = PIPE_FREE(*inode);
-		if (free >= min) {
-			/* transfer data */
-			ssize_t chars = PIPE_MAX_WCHUNK(*inode);
-			char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
-			/* Always wakeup, even if the copy fails. Otherwise
-			 * we lock up (O_NONBLOCK-)readers that sleep due to
-			 * syscall merging.
-			 */
-			do_wakeup = 1;
+	}
+
+	/* Copy into available space.  */
+	ret = -EFAULT;
+	while (count > 0) {
+		int space;
+		char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
+		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
+
+		if ((space = PIPE_FREE(*inode)) != 0) {
 			if (chars > count)
 				chars = count;
-			if (chars > free)
-				chars = free;
+			if (chars > space)
+				chars = space;
 
-			if (copy_from_user(pipebuf, buf, chars)) {
-				if (!ret) ret = -EFAULT;
-				break;
-			}
+			if (copy_from_user(pipebuf, buf, chars))
+				goto out;
 
-			ret += chars;
+			written += chars;
 			PIPE_LEN(*inode) += chars;
 			count -= chars;
 			buf += chars;
-		}
-		if (!count)
-			break;
-		if (PIPE_FREE(*inode) && ret) {
-			/* handle cyclic data buffers */
-			min = 1;
+			space = PIPE_FREE(*inode);
 			continue;
 		}
-		if (filp->f_flags & O_NONBLOCK) {
-			if (!ret) ret = -EAGAIN;
-			break;
-		}
-		if (signal_pending(current)) {
-			if (!ret) ret = -ERESTARTSYS;
+
+		ret = written;
+		if (filp->f_flags & O_NONBLOCK)
 			break;
-		}
-		if (do_wakeup) {
+
+		do {
+			/*
+			 * Synchronous wake-up: it knows that this process
+			 * is going to give up this CPU, so it doesn't have
+			 * to do idle reschedules.
+			 */
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
-			do_wakeup = 0;
-		}
-		PIPE_WAITING_WRITERS(*inode)++;
-		pipe_wait(inode);
-		PIPE_WAITING_WRITERS(*inode)--;
+ 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+			PIPE_WAITING_WRITERS(*inode)++;
+			pipe_wait(inode);
+			PIPE_WAITING_WRITERS(*inode)--;
+			if (signal_pending(current))
+				goto out;
+			if (!PIPE_READERS(*inode))
+				goto sigpipe;
+		} while (!PIPE_FREE(*inode));
+		ret = -EFAULT;
 	}
+
+	/* Signal readers asynchronously that there is more data.  */
+	wake_up_interruptible(PIPE_WAIT(*inode));
+	kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty(inode);
+
+out:
 	up(PIPE_SEM(*inode));
-	if (do_wakeup) {
-		wake_up_interruptible(PIPE_WAIT(*inode));
-		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
-	}
-	if (ret > 0) {
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(inode);
-	}
+out_nolock:
+	if (written)
+		ret = written;
 	return ret;
+
+sigpipe:
+	if (written)
+		goto out;
+	up(PIPE_SEM(*inode));
+	send_sig(SIGPIPE, current, 0);
+	return -EPIPE;
 }
 
 static ssize_t
@@ -412,7 +451,7 @@ struct file_operations read_fifo_fops = 
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_read_open,
 	.release	= pipe_read_release,
-	.fasync		= pipe_read_fasync,
+	.fasync         = pipe_read_fasync,
 };
 
 struct file_operations write_fifo_fops = {
@@ -423,7 +462,7 @@ struct file_operations write_fifo_fops =
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
 	.release	= pipe_write_release,
-	.fasync		= pipe_write_fasync,
+	.fasync         = pipe_write_fasync,
 };
 
 struct file_operations rdwr_fifo_fops = {
@@ -434,7 +473,7 @@ struct file_operations rdwr_fifo_fops = 
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
 	.release	= pipe_rdwr_release,
-	.fasync		= pipe_rdwr_fasync,
+	.fasync         = pipe_rdwr_fasync,
 };
 
 struct file_operations read_pipe_fops = {
@@ -445,7 +484,7 @@ struct file_operations read_pipe_fops = 
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_read_open,
 	.release	= pipe_read_release,
-	.fasync		= pipe_read_fasync,
+	.fasync         = pipe_read_fasync,
 };
 
 struct file_operations write_pipe_fops = {
@@ -456,7 +495,7 @@ struct file_operations write_pipe_fops =
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
 	.release	= pipe_write_release,
-	.fasync		= pipe_write_fasync,
+	.fasync         = pipe_write_fasync,
 };
 
 struct file_operations rdwr_pipe_fops = {
@@ -467,7 +506,7 @@ struct file_operations rdwr_pipe_fops = 
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
 	.release	= pipe_rdwr_release,
-	.fasync		= pipe_rdwr_fasync,
+	.fasync         = pipe_rdwr_fasync,
 };
 
 struct inode* pipe_new(struct inode* inode)
@@ -486,7 +525,7 @@ struct inode* pipe_new(struct inode* ino
 	PIPE_BASE(*inode) = (char*) page;
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_WRITERS(*inode) = 0;
+	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 

.
