Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315997AbSEJOag>; Fri, 10 May 2002 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316006AbSEJOaf>; Fri, 10 May 2002 10:30:35 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:35981 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S315997AbSEJOa3>;
	Fri, 10 May 2002 10:30:29 -0400
Message-ID: <3CDBD96C.4251CB4D@colorfullife.com>
Date: Fri, 10 May 2002 16:30:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] fs/pipe cleanup
Content-Type: multipart/mixed;
 boundary="------------819B7409D2AE061D85A23C58"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------819B7409D2AE061D85A23C58
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a cleanup of fs/pipe.c, against 2.5.14-dj2.

Main changes:
* 50 lines shorter
* fifo open now runs without the big kernel lock. The code didn't rely
on the blk since ~2.3.52.
* only update mtime, atime, ctime if a nonzero amount of data was
transfered.
* enable syscall merging for O_NONBLOCK pipe_read.
* fix a race that could trigger a wakeup storm if multiple threads read
from the same pipe.

The patch doesn't apply to 2.5.15 due to the fasync support.
--	
	Manfred
--------------819B7409D2AE061D85A23C58
Content-Type: text/plain; charset=us-ascii;
 name="patch-simplepipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-simplepipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 14
//  EXTRAVERSION =-dj2
--- 2.5/fs/pipe.c	Thu May  9 12:52:13 2002
+++ build-2.5/fs/pipe.c	Thu May  9 23:07:58 2002
@@ -25,6 +25,9 @@
  *
  * FIFOs and Pipes now generate SIGIO for both readers and writers.
  * -- Jeremy Elson <jelson@circlemud.org> 2001-08-16
+ *
+ * pipe_read & write cleanup
+ * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -44,99 +47,81 @@
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
 		wake_up_interruptible(PIPE_WAIT(*inode));
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
-
-	UPDATE_ATIME(inode);
+	if (ret > 0)
+		UPDATE_ATIME(inode);
 	return ret;
 }
 
@@ -144,116 +129,90 @@
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t free, written, ret;
-
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
-	if (ppos != &filp->f_pos)
-		goto out_nolock;
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
-			 * is going to give up this CPU, so it doesnt have
-			 * to do idle reschedules.
-			 */
+		}
+		if (signal_pending(current)) {
+			if (!ret) ret = -ERESTARTSYS;
+			break;
+		}
+		if (do_wakeup) {
 			wake_up_interruptible(PIPE_WAIT(*inode));
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
@@ -527,7 +486,7 @@
 	PIPE_BASE(*inode) = (char*) page;
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
+	PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
--- 2.5/include/linux/pipe_fs_i.h	Thu May  9 12:52:13 2002
+++ build-2.5/include/linux/pipe_fs_i.h	Thu May  9 22:22:28 2002
@@ -9,7 +9,6 @@
 	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
@@ -28,7 +27,6 @@
 #define PIPE_LEN(inode)		((inode).i_pipe->len)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
--- 2.5/fs/fifo.c	Fri Mar  1 23:01:45 2002
+++ build-2.5/fs/fifo.c	Thu May  9 21:37:58 2002
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 
 static void wait_for_partner(struct inode* inode, unsigned int* cnt)
 {
@@ -33,10 +32,8 @@
 {
 	int ret;
 
-	ret = -ERESTARTSYS;
-	lock_kernel();
 	if (down_interruptible(PIPE_SEM(*inode)))
-		goto err_nolock_nocleanup;
+		return -ERESTARTSYS;
 
 	if (!inode->i_pipe) {
 		ret = -ENOMEM;
@@ -117,7 +114,6 @@
 
 	/* Ok! */
 	up(PIPE_SEM(*inode));
-	unlock_kernel();
 	return 0;
 
 err_rd:
@@ -142,9 +138,6 @@
 
 err_nocleanup:
 	up(PIPE_SEM(*inode));
-
-err_nolock_nocleanup:
-	unlock_kernel();
 	return ret;
 }
 


--------------819B7409D2AE061D85A23C58--


