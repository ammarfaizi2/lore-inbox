Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130647AbRBGUqy>; Wed, 7 Feb 2001 15:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbRBGUqo>; Wed, 7 Feb 2001 15:46:44 -0500
Received: from colorfullife.com ([216.156.138.34]:6155 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130407AbRBGUqk>;
	Wed, 7 Feb 2001 15:46:40 -0500
Message-ID: <3A81AE75.3CEF5577@colorfullife.com>
Date: Wed, 07 Feb 2001 21:22:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: single copy pipe/fifo
Content-Type: multipart/mixed;
 boundary="------------66674D32372BCE53175B5989"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------66674D32372BCE53175B5989
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I finished my single copy pipe/fifo implementation.

Main changes:
* it's more a rewrite of pipe_read() and pipe_write().
Both functions were a nightmare of nested loops and gotos.
I wrote a test app - with the right timing multiple writers on a fifo
can race and then they busy loop in the current pipe_write() - adding
another set of goto's for single copy is imho a bad idea.

* slightly faster for non-zero copy transfers due to the code
simplification.

* No single copy for exactly 4096 byte writes, only > PIPE_BUF.
Single copy (and thus blocking) such writes could trigger bugs in user
space apps that errorneously assume that a pipe write of PIPE_BUF bytes
after a successful poll(POLLOUT) doesn't block even if O_NONBLOCK is not
set. It's not defined in posix or susv2, but no unix version I tested
blocks in such writes.

* on P II/350 single cpu it's a big win (~+70 % bw_pipe)

* if you run 2 instances on a dual cpu P II/350 it's a big win, but if
you run only one instance, then the bw_pipe processes will jump from one
cpu to the other and it's only a small improvement (~+15%).

I've attached the patch, the test app is at
http://colorfullife.com/~manfred/kiopipe/fail.cpp

Please test it!

--
	Manfred
--------------66674D32372BCE53175B5989
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =
--- 2.4/fs/pipe.c	Thu Nov 16 22:18:26 2000
+++ build-2.4/fs/pipe.c	Wed Feb  7 17:17:13 2001
@@ -10,6 +10,8 @@
 #include <linux/malloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/iobuf.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 
@@ -35,97 +37,149 @@
 	down(PIPE_SEM(*inode));
 }
 
+struct pipe_pio {
+	int *pdone;
+	struct kiobuf iobuf;
+};
+
+static int
+pio_copy_to_user(struct kiobuf* iobuf, int offset, char* ubuf, int chars)
+{
+	int page_nr;
+	offset += iobuf->offset;
+	page_nr = offset/PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	while(chars) {
+		int pcount = PAGE_SIZE-offset;
+		void *kaddr;
+		if (pcount > chars)
+			pcount = chars;
+		kaddr = kmap(iobuf->maplist[page_nr]);
+		if (copy_to_user(ubuf, kaddr+offset, pcount))
+			return 1;
+		kunmap(iobuf->maplist[page_nr]);
+		chars -= pcount;
+		ubuf += pcount;
+		offset = 0;
+		page_nr++;
+	}
+	return 0;
+}
+
 static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t size, read, ret;
+	ssize_t read, ret;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	read = 0;
+	/* pread is not allowed on pipes.  */
 	if (ppos != &filp->f_pos)
-		goto out_nolock;
+		return -ESPIPE;
 
 	/* Always return 0 on null read.  */
-	ret = 0;
 	if (count == 0)
-		goto out_nolock;
+		return 0;
 
-	/* Get the pipe semaphore */
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
+	down(PIPE_SEM(*inode));
 
-	if (PIPE_EMPTY(*inode)) {
-do_more_read:
+	read = 0;
+	for (;;) {
+		/* read what data is available */
+		int chars = PIPE_LEN(*inode);
+		if (chars) {
+			char *pipebuf = PIPE_BASE(*inode);
+			int offset = PIPE_START(*inode);
+
+			if (chars > count)
+				chars = count;
+			ret = -EFAULT;
+			if(PIPE_IS_PIO(*inode)) {
+				struct pipe_pio* pio = ((struct pipe_pio*)pipebuf);
+				if(pio_copy_to_user(&pio->iobuf, offset, buf, chars))
+					goto out;
+
+				PIPE_LEN(*inode) -= chars;
+				if(!PIPE_LEN(*inode)) {
+					unmap_kiobuf(&pio->iobuf);
+					*pio->pdone = 1;
+					PIPE_IS_PIO(*inode) = 0;
+					PIPE_START(*inode) = 0;
+				} else {
+					PIPE_START(*inode) += chars;
+				}
+			} else {
+				if (chars > PIPE_SIZE-offset)
+					chars = PIPE_SIZE-offset;
+				if (copy_to_user(buf, pipebuf+offset, chars))
+					goto out;
+				PIPE_LEN(*inode) -= chars;
+				if (!PIPE_LEN(*inode)) {
+					/* Cache behaviour optimization */
+					PIPE_START(*inode) = 0;
+				} else {
+					PIPE_START(*inode) += chars;
+					PIPE_START(*inode) &= (PIPE_SIZE - 1);
+				}
+			}
+			read += chars;
+			count -= chars;
+			buf += chars;
+		}
 		ret = 0;
+		if (!count)
+			goto out;
+	
+		/* Rare special case:
+		 * The pipe buffer was really circular,
+		 * the wrapped bytes must be read before sleeping.
+		 */
+		if (PIPE_LEN(*inode))
+			continue;
+
+		/* Never sleep if no process has the pipe open
+		 * for writing */
 		if (!PIPE_WRITERS(*inode))
 			goto out;
 
+		/* Never sleep if O_NONBLOCK is set */
 		ret = -EAGAIN;
 		if (filp->f_flags & O_NONBLOCK)
 			goto out;
 
-		for (;;) {
-			PIPE_WAITING_READERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_READERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
+		/* optimization:
+		 * pipe_read() should return even if only a single byte
+		 * was read.  (Posix Std. 6.4.1.2)
+		 * But if another process is sleeping in pipe_write()
+		 * then we wait for that data - it's invisible for user
+		 * space programs.
+		 */
+		if (PIPE_MORE_DATA_WAITING(*inode)) {
+			/*
+			 * We know that we are going to sleep: signal
+			 * writers synchronously that there is more
+			 * room.
+			 */
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		} else if (read) {
+			/* We know that there are no writers, no need
+			 * for wake up.
+			 */
 			ret = 0;
-			if (!PIPE_EMPTY(*inode))
-				break;
-			if (!PIPE_WRITERS(*inode))
-				goto out;
+			goto out;
 		}
-	}
 
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
+		pipe_wait(inode);
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
 			goto out;
-
-		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
-		count -= chars;
-		buf += chars;
 	}
 
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
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		if (!PIPE_EMPTY(*inode))
-			BUG();
-		goto do_more_read;
-	}
+out:
 	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
+	if (read && !PIPE_IS_PIO(*inode))
+		wake_up_interruptible(PIPE_WAIT(*inode));
 
-	ret = read;
-out:
 	up(PIPE_SEM(*inode));
-out_nolock:
 	if (read)
 		ret = read;
 	return ret;
@@ -136,113 +190,143 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t free, written, ret;
+	int pio_done, do_wakeup;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
+	/* pwrite is not allowed on pipes.  */
 	if (ppos != &filp->f_pos)
-		goto out_nolock;
+		return -ESPIPE;
 
 	/* Null write succeeds.  */
-	ret = 0;
 	if (count == 0)
-		goto out_nolock;
-
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
+		return 0;
 
-	/* No readers yields SIGPIPE.  */
-	if (!PIPE_READERS(*inode))
-		goto sigpipe;
+	down(PIPE_SEM(*inode));
 
 	/* If count <= PIPE_BUF, we have to make it atomic.  */
 	free = (count <= PIPE_BUF ? count : 1);
 
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
+	written = 0;
+	pio_done = 1;
+	do_wakeup = 0;
+	for(;;) {
+		/* No readers yields SIGPIPE.  */
+		ret = -EPIPE;
+		if (!PIPE_READERS(*inode))
 			goto out;
-	} else {
-		while (PIPE_FREE(*inode) < free) {
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
 
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		}
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
-			if (chars > count)
-				chars = count;
-			if (chars > space)
-				chars = space;
-
-			if (copy_from_user(pipebuf, buf, chars))
-				goto out;
-
-			written += chars;
-			PIPE_LEN(*inode) += chars;
-			count -= chars;
-			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+		if(!PIPE_IS_PIO(*inode)) {
+			int chars;
+			/* Copy into available space.  */
+			chars = PIPE_FREE(*inode);
+		
+			/*
+			 * Try zero-copy:
+			 * - only possible if the normal pipe buffer
+			 *   is empty
+			 * - only possible if we can block:
+			 *   a) O_NONBLOCK not set
+			 *	and
+			 *   b) request for more than PIPE_BUF bytes.
+			 *	No Unix version blocks in pipe write for
+			 *	<= PIPE_BUF bytes after poll() returned POLLOUT.
+			 */
+			ret = -EFAULT;
+			if (count > PIPE_BUF && chars == PIPE_SIZE &&
+				    (!(filp->f_flags & O_NONBLOCK))) {
+				struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+				chars = KIO_MAX_ATOMIC_BYTES;
+				if (chars > count)
+					chars = count;
+				kiobuf_init(&pio->iobuf);
+				if(map_user_kiobuf(READ, &pio->iobuf, (unsigned long)buf, chars))
+					goto out;
+				PIPE_IS_PIO(*inode) = 1;
+				pio_done = 0;
+				pio->pdone = &pio_done;
+
+				written += chars;
+				PIPE_LEN(*inode) += chars;
+				count -= chars;
+				buf += chars;
+				do_wakeup = 1;
+			} else if (chars >= free) {
+				int offset;
+next_chunk:
+				offset = PIPE_END(*inode);
+
+				if (chars > count)
+					chars = count;
+				if (chars > PIPE_SIZE-offset)
+					chars = PIPE_SIZE-offset;
+				if (copy_from_user(PIPE_BASE(*inode)+offset, buf, chars))
+					goto out;
+
+				written += chars;
+				PIPE_LEN(*inode) += chars;
+				count -= chars;
+				buf += chars;
+				do_wakeup = 1;
+				
+				if(!count)
+					break; /* DONE! */
+
+				/* special case: pipe buffer wrapped */
+				if(PIPE_LEN(*inode) != PIPE_SIZE) {
+					chars = PIPE_FREE(*inode);
+					goto next_chunk;
+				}
+			}
 		}
 
-		ret = written;
+		ret = -EAGAIN;
 		if (filp->f_flags & O_NONBLOCK)
 			break;
 
-		do {
+		/* Do not wakeup unless data was written, otherwise
+		 * multiple writers can cause a wakeup storm
+		 */
+		if(do_wakeup) {
 			/*
 			 * Synchronous wake-up: it knows that this process
 			 * is going to give up this CPU, so it doesnt have
 			 * to do idle reschedules.
 			 */
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
-		ret = -EFAULT;
+			do_wakeup = 0;
+		}
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)++;
+		pipe_wait(inode);
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)--;
+		if (!count && pio_done)
+			break; /* DONE */
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
+			goto out;
 	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-
 out:
-	up(PIPE_SEM(*inode));
-out_nolock:
-	if (written)
-		ret = written;
-	return ret;
+	if(!pio_done) {
+		struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+		PIPE_IS_PIO(*inode) = 0;
+		written -= PIPE_LEN(*inode);
+		PIPE_LEN(*inode) = 0;
+		unmap_kiobuf(&pio->iobuf);
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	}
+	if (written) {
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
 
-sigpipe:
-	if (written)
-		goto out;
+		ret = written;
+	}
 	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
+	/* Signal readers asynchronously that there is more data.  */
+	if(do_wakeup)
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	if (ret == -EPIPE)
+		send_sig(SIGPIPE, current, 0);
+	return ret;
 }
 
 static loff_t
@@ -453,9 +537,10 @@
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
 	PIPE_BASE(*inode) = (char*) page;
+	PIPE_IS_PIO(*inode) = 0;
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
+	PIPE_MORE_DATA_WAITING(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 
 	return inode;
--- 2.4/include/linux/pipe_fs_i.h	Mon May  8 20:17:47 2000
+++ build-2.4/include/linux/pipe_fs_i.h	Tue Feb  6 13:29:48 2001
@@ -5,11 +5,11 @@
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	char *base;
+	unsigned int is_pio;
 	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
-	unsigned int waiting_writers;
+	unsigned int more_data;
 	unsigned int r_counter;
 	unsigned int w_counter;
 };
@@ -21,12 +21,12 @@
 #define PIPE_SEM(inode)		(&(inode).i_sem)
 #define PIPE_WAIT(inode)	(&(inode).i_pipe->wait)
 #define PIPE_BASE(inode)	((inode).i_pipe->base)
+#define PIPE_IS_PIO(inode)	((inode).i_pipe->is_pio)
 #define PIPE_START(inode)	((inode).i_pipe->start)
 #define PIPE_LEN(inode)		((inode).i_size)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
-#define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
+#define PIPE_MORE_DATA_WAITING(inode)	((inode).i_pipe->more_data)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
 
@@ -34,8 +34,6 @@
 #define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
 #define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))
 #define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE-1))
-#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE - PIPE_START(inode))
-#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode);

--------------66674D32372BCE53175B5989--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
