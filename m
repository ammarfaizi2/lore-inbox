Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbRAFX0M>; Sat, 6 Jan 2001 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135290AbRAFX0C>; Sat, 6 Jan 2001 18:26:02 -0500
Received: from colorfullife.com ([216.156.138.34]:37132 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130810AbRAFXZt>;
	Sat, 6 Jan 2001 18:25:49 -0500
Message-ID: <3A57A95C.A1411221@colorfullife.com>
Date: Sun, 07 Jan 2001 00:25:16 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@redhat.com
Subject: [patch] single copy pipe rewrite
Content-Type: multipart/mixed;
 boundary="------------9F042124F781E2996C26200F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F042124F781E2996C26200F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

(Linus, look away, I'll resubmit it for 2.5.0)

The Linux pipe implementation is extremely inefficient for long,
blocking data transfers with pipes (e.g. what gcc -pipe does):
* 2 memcopies: user space->kernel buffer->user space
* 2 context switches for each transfered page.

Last march David Miller proposed using kiobuf for these data transfers,
I've written a new patch for 2.4.

(David's original patch contained 2 bugs: it doesn't protect properly
against multiple writers and it causes a BUG() in pipe_read() when data
is stored in both the kiobuf and the normal buffer)


--
	Manfred
--------------9F042124F781E2996C26200F
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 0
//  EXTRAVERSION =
--- 2.4/fs/pipe.c	Thu Nov 16 22:18:26 2000
+++ build-2.4/fs/pipe.c	Sat Jan  6 22:43:32 2001
@@ -10,6 +10,8 @@
 #include <linux/malloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/iobuf.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 
@@ -35,30 +37,100 @@
 	down(PIPE_SEM(*inode));
 }
 
+struct pipe_pio {
+	int *pdone;
+	struct kiobuf iobuf;
+};
+
+static int
+pio_copy_to_user(struct kiobuf* iobuf, char* ubuf, int chars, int offset)
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
 
 	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	read = 0;
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
+				if(pio_copy_to_user(&pio->iobuf, buf, chars, offset))
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
+				if (offset+chars <= PIPE_SIZE) {
+					if (copy_to_user(buf, pipebuf+offset, chars))
+						goto out;
+				} else {
+					int p1 = PIPE_SIZE-offset;
+					if (copy_to_user(buf, pipebuf+offset, p1))
+						goto out;
+					if (copy_to_user(buf+p1, pipebuf, chars-p1))
+						goto out;
+				}
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
 		if (!PIPE_WRITERS(*inode))
 			goto out;
@@ -67,65 +139,33 @@
 		if (filp->f_flags & O_NONBLOCK)
 			goto out;
 
-		for (;;) {
-			PIPE_WAITING_READERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_READERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-			ret = 0;
+		ret = 0;
+		if (count && PIPE_MORE_DATA_WAITING(*inode) && !(filp->f_flags & O_NONBLOCK)) {
+			/*
+			 * We know that we are going to sleep: signal
+			 * writers synchronously that there is more
+			 * room.
+			 */
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
 			if (!PIPE_EMPTY(*inode))
-				break;
-			if (!PIPE_WRITERS(*inode))
-				goto out;
+				BUG();
+		} else if (read) {
+			goto out;
 		}
-	}
-
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
@@ -136,92 +176,89 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t free, written, ret;
+	int pio_done;
 
 	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
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
+	for(;;) {
+		int chars;
+
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
-
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
 
-		if ((space = PIPE_FREE(*inode)) != 0) {
+		/* Copy into available space.  */
+		ret = -EFAULT;
+		if (count >= PIPE_BUF && PIPE_EMPTY(*inode) &&
+		    (!(filp->f_flags & O_NONBLOCK))) {
+			struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+			chars = KIO_MAX_ATOMIC_BYTES;
 			if (chars > count)
 				chars = count;
-			if (chars > space)
-				chars = space;
-
-			if (copy_from_user(pipebuf, buf, chars))
+			kiobuf_init(&pio->iobuf);
+			if(map_user_kiobuf(READ, &pio->iobuf, (unsigned long)buf, chars))
 				goto out;
+			PIPE_IS_PIO(*inode) = 1;
+			pio_done = 0;
+			pio->pdone = &pio_done;
+		} else if (!PIPE_IS_PIO(*inode) &&
+				(chars = PIPE_FREE(*inode)) >= free) {
+			char *pipebuf = PIPE_BASE(*inode);
+			int offset = PIPE_END(*inode);
 
-			written += chars;
-			PIPE_LEN(*inode) += chars;
-			count -= chars;
-			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+			if (chars > count)
+				chars = count;
+			if (chars+offset <= PIPE_SIZE) {
+				if (copy_from_user(pipebuf+offset, buf, chars))
+					goto out;
+			} else {
+				int p1 = PIPE_SIZE-offset;
+				if (copy_from_user(pipebuf+offset, buf, p1))
+					goto out;
+				if (copy_from_user(pipebuf, buf+p1, chars-p1))
+					goto out;
+			}
 		}
+		written += chars;
+		PIPE_LEN(*inode) += chars;
+		count -= chars;
+		buf += chars;
+		if (!count && pio_done)
+			break; /* DONE */
 
-		ret = written;
+		ret = -EAGAIN;
 		if (filp->f_flags & O_NONBLOCK)
 			break;
 
-		do {
-			/*
-			 * Synchronous wake-up: it knows that this process
-			 * is going to give up this CPU, so it doesnt have
-			 * to do idle reschedules.
-			 */
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
-		ret = -EFAULT;
+		/*
+		 * Synchronous wake-up: it knows that this process
+		 * is going to give up this CPU, so it doesnt have
+		 * to do idle reschedules.
+		 */
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)++;
+		pipe_wait(inode);
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)--;
+		if (!count && pio_done)
+			break; /* DONE */
+		if (signal_pending(current))
+			goto out;
 	}
 
 	/* Signal readers asynchronously that there is more data.  */
@@ -231,18 +268,20 @@
 	mark_inode_dirty(inode);
 
 out:
+	if(!pio_done) {
+		struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+		PIPE_IS_PIO(*inode) = 0;
+		written -= PIPE_LEN(*inode);
+		PIPE_LEN(*inode) = 0;
+		unmap_kiobuf(&pio->iobuf);
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	}
 	up(PIPE_SEM(*inode));
-out_nolock:
 	if (written)
 		ret = written;
+	if (ret == -EPIPE)
+		send_sig(SIGPIPE, current, 0);
 	return ret;
-
-sigpipe:
-	if (written)
-		goto out;
-	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
 }
 
 static loff_t
@@ -453,9 +492,10 @@
 
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
+++ build-2.4/include/linux/pipe_fs_i.h	Sat Jan  6 17:56:33 2001
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


--------------9F042124F781E2996C26200F--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
