Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbSJCNWh>; Thu, 3 Oct 2002 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSJCNWh>; Thu, 3 Oct 2002 09:22:37 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:38576 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263274AbSJCNWY>;
	Thu, 3 Oct 2002 09:22:24 -0400
Date: Thu, 3 Oct 2002 15:27:49 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pipe bugfix /cleanup
Message-ID: <Pine.LNX.4.44.0210031514230.19230-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pipe_write contains a wakeup storm, 2 writers that write into the same 
fifo can wake each other up, and spend 100% cpu time with wakeup/schedule, 
without making any progress.

The patch below was part of -dj, and IIRC even of -ac, for a few months, 
but it's more a rewrite of pipe_read and _write.

Could you merge it, or do you want a minimal fix?

The only regression I'm aware of is that

  $ dd if=/dev/zero | grep not_there

will fail due to OOM, because grep does something like

	for(;;) {
		rlen = read(fd, buf, len);
		if (rlen == len) {
			len *= 2;
			buf = realloc(buf, len);
		}
	}

if it operates on pipes, and due to the improved syscall merging, read 
will always return the maximum possible amount of data. But that's a grep 
bug, not a kernel problem.

The diff is older, but applies to 2.5.40 without offsets.
--
	Manfred
<<<<<<<<<<<<<<

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/pipe.c linux-2.5/fs/pipe.c
--- bk-linus/fs/pipe.c	2002-08-20 13:15:16.000000000 +0100
+++ linux-2.5/fs/pipe.c	2002-08-20 13:25:24.000000000 +0100
@@ -25,6 +25,9 @@
  *
  * FIFOs and Pipes now generate SIGIO for both readers and writers.
  * -- Jeremy Elson <jelson@circlemud.org> 2001-08-16
+ *
+ * pipe_read & write cleanup
+ * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -44,97 +47,81 @@ static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t size, read, ret;
+	int do_wakeup;
+	ssize_t ret;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	read = 0;
-	if (ppos != &filp->f_pos)
-		goto out_nolock;
+	/* pread is not allowed on pipes. */
+	if (unlikely(ppos != &filp->f_pos))
+		return -ESPIPE;
+	
+	/* Null read succeeds. */
+	if (unlikely(count == 0))
+		return 0;
 
-	/* Always return 0 on null read.  */
+	do_wakeup = 0;
 	ret = 0;
-	if (count == 0)
-		goto out_nolock;
+	down(PIPE_SEM(*inode));
+	for (;;) {
+		int size = PIPE_LEN(*inode);
+		if (size) {
+			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
+			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
 
-	/* Get the pipe semaphore */
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
-
-	if (PIPE_EMPTY(*inode)) {
-do_more_read:
-		ret = 0;
-		if (!PIPE_WRITERS(*inode))
-			goto out;
+			if (chars > count)
+				chars = count;
+			if (chars > size)
+				chars = size;
 
-		ret = -EAGAIN;
-		if (filp->f_flags & O_NONBLOCK)
-			goto out;
-
-		for (;;) {
-			PIPE_WAITING_READERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_READERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-			ret = 0;
-			if (!PIPE_EMPTY(*inode))
+			if (copy_to_user(buf, pipebuf, chars)) {
+				if (!ret) ret = -EFAULT;
 				break;
-			if (!PIPE_WRITERS(*inode))
-				goto out;
-		}
-	}
+			}
+			ret += chars;
 
-	/* Read what data is available.  */
-	ret = -EFAULT;
-	while (count > 0 && (size = PIPE_LEN(*inode))) {
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
-		ssize_t chars = PIPE_MAX_RCHUNK(*inode);
-
-		if (chars > count)
-			chars = count;
-		if (chars > size)
-			chars = size;
-
-		if (copy_to_user(buf, pipebuf, chars))
-			goto out;
-
-		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
-		count -= chars;
-		buf += chars;
+			PIPE_START(*inode) += chars;
+			PIPE_START(*inode) &= (PIPE_SIZE - 1);
+			PIPE_LEN(*inode) -= chars;
+			count -= chars;
+			buf += chars;
+			do_wakeup = 1;
+		}
+		if (!count)
+			break;	/* common path: read succeeded */
+		if (PIPE_LEN(*inode)) /* test for cyclic buffers */
+			continue;
+		if (!PIPE_WRITERS(*inode))
+			break;
+		if (!PIPE_WAITING_WRITERS(*inode)) {
+			/* syscall merging: Usually we must not sleep
+			 * if O_NONBLOCK is set, or if we got some data.
+			 * But if a writer sleeps in kernel space, then
+			 * we can wait for that data without violating POSIX.
+			 */
+			if (ret)
+				break;
+			if (filp->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+		}
+		if (signal_pending(current)) {
+			if (!ret) ret = -ERESTARTSYS;
+			break;
+		}
+		if (do_wakeup) {
+			wake_up_interruptible(PIPE_WAIT(*inode));
+ 			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+		}
+		pipe_wait(inode);
 	}
-
-	/* Cache behaviour optimization */
-	if (!PIPE_LEN(*inode))
-		PIPE_START(*inode) = 0;
-
-	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
-		/*
-		 * We know that we are going to sleep: signal
-		 * writers synchronously that there is more
-		 * room.
-		 */
+	up(PIPE_SEM(*inode));
+	/* Signal writers asynchronously that there is more room.  */
+	if (do_wakeup) {
 		wake_up_interruptible_sync(PIPE_WAIT(*inode));
- 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
-		if (!PIPE_EMPTY(*inode))
-			BUG();
-		goto do_more_read;
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
-	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
- 	kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
-
-	ret = read;
-out:
-	up(PIPE_SEM(*inode));
-out_nolock:
-	if (read)
-		ret = read;
+	if (ret > 0)
+		UPDATE_ATIME(inode);
 	return ret;
 }
 
@@ -142,116 +129,90 @@ static ssize_t
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t free, written, ret;
+	ssize_t ret;
+	size_t min;
+	int do_wakeup;
+
+	/* pwrite is not allowed on pipes. */
+	if (unlikely(ppos != &filp->f_pos))
+		return -ESPIPE;
+	
+	/* Null write succeeds. */
+	if (unlikely(count == 0))
+		return 0;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
-	if (ppos != &filp->f_pos)
-		goto out_nolock;
-
-	/* Null write succeeds.  */
+	do_wakeup = 0;
 	ret = 0;
-	if (count == 0)
-		goto out_nolock;
-
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
-
-	/* No readers yields SIGPIPE.  */
-	if (!PIPE_READERS(*inode))
-		goto sigpipe;
-
-	/* If count <= PIPE_BUF, we have to make it atomic.  */
-	free = (count <= PIPE_BUF ? count : 1);
-
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
-			goto out;
-	} else {
-		while (PIPE_FREE(*inode) < free) {
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
+	min = count;
+	if (min > PIPE_BUF)
+		min = 1;
+	down(PIPE_SEM(*inode));
+	for (;;) {
+		int free;
+		if (!PIPE_READERS(*inode)) {
+			send_sig(SIGPIPE, current, 0);
+			if (!ret) ret = -EPIPE;
+			break;
 		}
-	}
-
-	/* Copy into available space.  */
-	ret = -EFAULT;
-	while (count > 0) {
-		int space;
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
-		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
-
-		if ((space = PIPE_FREE(*inode)) != 0) {
+		free = PIPE_FREE(*inode);
+		if (free >= min) {
+			/* transfer data */
+			ssize_t chars = PIPE_MAX_WCHUNK(*inode);
+			char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
+			/* Always wakeup, even if the copy fails. Otherwise
+			 * we lock up (O_NONBLOCK-)readers that sleep due to
+			 * syscall merging.
+			 */
+			do_wakeup = 1;
 			if (chars > count)
 				chars = count;
-			if (chars > space)
-				chars = space;
+			if (chars > free)
+				chars = free;
 
-			if (copy_from_user(pipebuf, buf, chars))
-				goto out;
+			if (copy_from_user(pipebuf, buf, chars)) {
+				if (!ret) ret = -EFAULT;
+				break;
+			}
 
-			written += chars;
+			ret += chars;
 			PIPE_LEN(*inode) += chars;
 			count -= chars;
 			buf += chars;
-			space = PIPE_FREE(*inode);
+		}
+		if (!count)
+			break;
+		if (PIPE_FREE(*inode) && ret) {
+			/* handle cyclic data buffers */
+			min = 1;
 			continue;
 		}
-
-		ret = written;
-		if (filp->f_flags & O_NONBLOCK)
+		if (filp->f_flags & O_NONBLOCK) {
+			if (!ret) ret = -EAGAIN;
 			break;
-
-		do {
-			/*
-			 * Synchronous wake-up: it knows that this process
-			 * is going to give up this CPU, so it doesn't have
-			 * to do idle reschedules.
-			 */
+		}
+		if (signal_pending(current)) {
+			if (!ret) ret = -ERESTARTSYS;
+			break;
+		}
+		if (do_wakeup) {
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
- 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
-		ret = -EFAULT;
+			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+			do_wakeup = 0;
+		}
+		PIPE_WAITING_WRITERS(*inode)++;
+		pipe_wait(inode);
+		PIPE_WAITING_WRITERS(*inode)--;
 	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-	kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-
-out:
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (written)
-		ret = written;
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+	}
+	if (ret > 0) {
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+	}
 	return ret;
-
-sigpipe:
-	if (written)
-		goto out;
-	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
 }
 
 static ssize_t
@@ -525,7 +486,7 @@ struct inode* pipe_new(struct inode* ino
 	PIPE_BASE(*inode) = (char*) page;
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
+	PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/pipe_fs_i.h linux-2.5/include/linux/pipe_fs_i.h
--- bk-linus/include/linux/pipe_fs_i.h	2002-08-20 13:15:58.000000000 +0100
+++ linux-2.5/include/linux/pipe_fs_i.h	2002-08-20 13:26:25.000000000 +0100
@@ -9,7 +9,6 @@ struct pipe_inode_info {
 	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
@@ -28,7 +27,6 @@ struct pipe_inode_info {
 #define PIPE_LEN(inode)		((inode).i_pipe->len)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
-- 
<<<<<<<<<<<<<<

